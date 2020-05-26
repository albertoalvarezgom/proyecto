require('dotenv').config();

const { getConnection } = require('../../db/db.js');
const { generateError } = require('../../helpers/helpers.js');
// const chalk = require('chalk');

async function finishBooking(request, response, next) {
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

    await connection.query(`UPDATE user SET hidden=0 WHERE id_user=?`, [
      existingBooking[0].id_user1
    ]);

    await connection.query(`UPDATE room SET hidden=0 WHERE id_user=?`, [
      existingBooking[0].id_user2
    ]);

    const [
      room
    ] = await connection.query(
      `SELECT id_room FROM booking WHERE id_booking=?`,
      [idbooking]
    );

    await connection.query(`UPDATE room SET hidden=0 WHERE id_room=?`, [
      room[0].id_room
    ]);

    response.send({
      status: 'ok',
      message: `La reserva con id ${idbooking} ha finalizado. 
      La habitación con id ${room[0].id_room} vuelve a estar disponible y los usuarios ${existingBooking[0].id_user1} y ${existingBooking[0].id_user2} visibles de nuevo.`
    });
  } catch (error) {
    next(error);
  } finally {
    if (connection) {
      connection.release();
    }
  }
}

module.exports = { finishBooking };
