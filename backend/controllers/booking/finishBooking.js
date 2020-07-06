require('dotenv').config();

const { getConnection } = require('../../db/db.js');
const { generateError, sendEmail } = require('../../helpers/helpers.js');
// const chalk = require('chalk');

async function finishBooking(request, response, next) {
  let connection;
  try {
    const { code } = request.query;

    connection = await getConnection();

    const [
      existingBooking
    ] = await connection.query(
      `SELECT id_booking, id_match, id_room FROM booking WHERE confirmation_code=? AND status='aceptada'`,
      [code]
    );

    const [
      users
    ] = await connection.query(
      `SELECT id_user1, id_user2 FROM user_match WHERE id_match=?`,
      [existingBooking[0].id_match]
    );

    if (!existingBooking.length) {
      throw generateError(
        `La reserva con id ${existingBooking[0].id_booking} no existe en nuestra BBDD o no se encuentra en activo`,
        404
      );
    }

    //     const [
    //       idusers
    //     ] = await connection.query(
    //       `SELECT id_user1, id_user2 FROM user_match WHERE id_match=?`,
    //       [existingBooking[0].id_match]
    //     );

    // idusers[0].id_user1

    if (
      request.auth.id !== users[0].id_user1 &&
      request.auth.id !== users[0].id_user2
    ) {
      throw generateError(
        `No tienes permiso para realizar ninguna acción relacionada con esta reserva`,
        400
      );
    }

    await connection.query(
      `UPDATE booking SET status='terminada', finish_date=now() WHERE id_booking=?`,
      [existingBooking[0].id_booking]
    );

    await connection.query(`UPDATE user SET hidden=0 WHERE id_user=?`, [
      users[0].id_user1
    ]);

    await connection.query(`UPDATE user SET hidden=0 WHERE id_user=?`, [
      users[0].id_user2
    ]);

    await connection.query(`UPDATE room SET hidden=0 WHERE id_user=?`, [
      users[0].id_user2
    ]);

    await connection.query(`UPDATE room SET hidden=0 WHERE id_room=?`, [
      existingBooking[0].id_room
    ]);

    //Guardamos las direcciones de email de los dos usuarios participantes en la reserva
    const [user1] = await connection.query(
      `
    SELECT email, first_name FROM user WHERE id_user=?
    `,
      [users[0].id_user1]
    );

    const [user2] = await connection.query(
      `
    SELECT email, first_name FROM user WHERE id_user=?
    `,
      [users[0].id_user2]
    );

    try {
      await sendEmail({
        toEmail: user1[0].email,
        fromEmail: process.env.DEFAULT_ADMIN_EMAIL,
        title: `¡${user1[0].first_name}, tu reserva de habitación con ${user2[0].first_name} ha finalizado!`,
        html: `<div>
      <h1>La reserva ha terminado</h1>
      <p>¡No olvides votar a tu roomie!</p>  
    </div>`
      });
      await sendEmail({
        toEmail: user2[0].email,
        fromEmail: process.env.DEFAULT_ADMIN_EMAIL,
        title: `¡${user2[0].first_name}, tu reserva de habitación con ${user1[0].first_name} ha finalizado!`,
        html: `<div>
      <h1>La reserva ha terminado</h1>
      <p>¡No olvides votar a tu roomie!</p>  
    </div>`
      });
    } catch (error) {
      console.error(error.response.body);
      throw generateError(
        'Error en el envío de mail. Inténtalo de nuevo más tarde.',
        500
      );
    }

    response.send({
      status: 'ok',
      message: `La reserva con id ${existingBooking[0].id_booking} ha finalizado. 
      La habitación con id ${existingBooking[0].id_room} vuelve a estar disponible y los usuarios ${existingBooking[0].id_user1} y ${existingBooking[0].id_user2} visibles de nuevo.`
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
