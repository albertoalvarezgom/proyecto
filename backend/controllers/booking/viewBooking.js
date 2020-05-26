const { getConnection } = require('../../db/db.js');
const { generateError } = require('../../helpers/helpers.js');

async function viewBooking(request, response, next) {
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

    if (
      request.auth.id !== existingBooking[0].id_user1 &&
      request.auth.id !== existingBooking[0].id_user2
    ) {
      throw generateError(`No tienes permiso para ver esta reserva`, 400);
    }

    const [
      booking
    ] = await connection.query(`SELECT * FROM booking WHERE id_booking=?`, [
      idbooking
    ]);

    const [
      user1type
    ] = await connection.query(`SELECT type FROM user WHERE id_user=?`, [
      existingBooking[0].id_user1
    ]);

    let room;
    if (user1type[0].type === 'owner') {
      [room] = await connection.query(`SELECT * FROM room WHERE id_user=?`, [
        existingBooking[0].id_user1
      ]);
    } else {
      [room] = await connection.query(`SELECT * FROM room WHERE id_user=?`, [
        existingBooking[0].id_user2
      ]);
    }

    response.send({ status: 'ok', booking: booking, room: room });
  } catch (error) {
    next(error);
  } finally {
    connection.release();
  }
}

module.exports = {
  viewBooking
};
