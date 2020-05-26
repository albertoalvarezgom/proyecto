const { getConnection } = require('../../db/db.js');
const { generateError } = require('../../helpers/helpers.js');

async function getBookings(request, response, next) {
  let connection;
  try {
    connection = await getConnection();

    const { id } = request.params;

    const [
      existingUser
    ] = await connection.query(`SELECT id_user FROM user WHERE id_user=?`, [
      id
    ]);

    if (!existingUser.length) {
      throw generateError(
        `El usuario con el id ${id} no se encuentra en la BBDD`,
        404
      );
    }

    if (request.auth.id !== existingUser[0].id_user) {
      throw generateError(
        `El usuario con el id ${request.auth.id} tiene permisos para ver las reservas del usuario con id ${id}`,
        404
      );
    }

    const [
      bookings
    ] = await connection.query(
      `SELECT * FROM booking WHERE id_user1=? OR id_user2=?`,
      [id, id]
    );

    response.send({ status: 'ok', data: bookings });
  } catch (error) {
    next(error);
  } finally {
    connection.release();
  }
}

module.exports = {
  getBookings
};
