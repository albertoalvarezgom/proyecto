const { getConnection } = require('../../db/db.js');
const { generateError } = require('../../helpers/helpers.js');

async function deleteBooking(request, response, next) {
  let connection;
  try {
    const { iduser, idbooking } = request.params;
    connection = await getConnection();

    const [
      existingUser
    ] = await connection.query(`SELECT id_user FROM user WHERE id_user=?`, [
      iduser
    ]);

    if (!existingUser.length) {
      throw generateError(
        `El usuario con id ${iduser} no existe en nuestra BBDD`
      );
    }

    const [
      existingBooking
    ] = await connection.query(
      `SELECT id_booking, id_user1, id_user2 FROM booking WHERE id_booking=?`,
      [idbooking]
    );

    if (!existingBooking.length) {
      throw generateError(
        `La reserva con id ${idbooking} no existe en nuestra BBDD`,
        404
      );
    }

    if (request.auth.role !== 'admin') {
      throw generateError(
        `No tienes permiso para eliminar esta reserva de la BBDD`,
        400
      );
    }

    await connection.query(`DELETE FROM booking WHERE id_booking=?`, [
      idbooking
    ]);

    response.send({
      status: 'ok',
      message: `La reserva con id ${idbooking} ha sido eliminada por un administrador`
    });
  } catch (error) {
    next(error);
  } finally {
    connection.release();
  }
}

module.exports = {
  deleteBooking
};
