const { getConnection } = require('../../db/db.js');
const { generateError, sendEmail } = require('../../helpers/helpers.js');
// const chalk = require('chalk');

async function acceptBooking(request, response, next) {
  let connection;
  try {
    connection = await getConnection();

    const { code } = request.query;
    const { idmatch } = request.params;

    const [
      existingBooking
    ] = await connection.query(
      `SELECT id_booking FROM booking WHERE status='accepted' AND confirmation_code=?`,
      [code]
    );

    if (existingBooking.length) {
      throw generateError(
        'Esta reserva ya ha sido confirmada y aceptada. ¡Gracias!',
        400
      );
    }

    const [
      result
    ] = await connection.query(
      `UPDATE booking SET status='aceptada' WHERE confirmation_code=?`,
      [code]
    );

    if (result.affectedRows === 0) {
      throw generateError('Confirmación incorrecta', 400);
    }

    const [
      booking
    ] = await connection.query(
      `SELECT user_match.id_user1, user_match.id_user2, booking.id_room FROM user_match JOIN booking ON booking.id_match=user_match.id_match WHERE booking.confirmation_code=?`,
      [code]
    );

    //Comprobamos el tipo de usuario: si buscaba piso, lo ocultamos al tener una reserva válida.
    //Si es propietario, ocultamos la habitación reservada y comprobamos si tiene más habitaciones disponibles.
    //Si no, ocultamos también al usuario propietario al validar la reserva
    const [
      user1Type
    ] = await connection.query(`SELECT type FROM user WHERE id_user=?`, [
      booking[0].id_user1
    ]);

    if (user1Type[0].type === 'buscando piso') {
      await connection.query(`UPDATE user SET hidden=1 WHERE id_user=?`, [
        booking[0].id_user1
      ]);
    } else {
      await connection.query(`UPDATE room SET hidden=1 WHERE id_user=?`, [
        booking[0].id_user1
      ]);
      const [
        moreRooms
      ] = await connection.query(
        `SELECT id_room FROM room WHERE id_user=? AND hidden=0`,
        [booking[0].id_user1]
      );
      if (!moreRooms.length) {
        await connection.query(`UPDATE user SET hidden=1 WHERE id_user=?`, [
          booking[0].id_user1
        ]);
      }
    }

    //Repetimos la comprobación con el otro usuario de la reserva
    const [
      user2Type
    ] = await connection.query(`SELECT type FROM user WHERE id_user=?`, [
      booking[0].id_user2
    ]);

    if (user2Type[0].type === 'buscando piso') {
      await connection.query(`UPDATE user SET hidden=1 WHERE id_user=?`, [
        booking[0].id_user2
      ]);
    } else {
      await connection.query(`UPDATE room SET hidden=1 WHERE id_user=?`, [
        booking[0].id_user2
      ]);
      const [
        moreRooms
      ] = await connection.query(
        `SELECT id_room FROM room WHERE id_user=? AND hidden=0`,
        [booking[0].id_user2]
      );
      if (!moreRooms.length) {
        await connection.query(`UPDATE user SET hidden=1 WHERE id_user=?`, [
          booking[0].id_user2
        ]);
      }
    }

    //Enviamos mail de confirmación

    const [
      email1
    ] = await connection.query(`SELECT email FROM user WHERE id_user=?`, [
      booking[0].id_user1
    ]);

    const [
      email2
    ] = await connection.query(`SELECT email FROM user WHERE id_user=?`, [
      booking[0].id_user2
    ]);

    try {
      await sendEmail({
        toEmail: email1[0].email,
        fromEmail: process.env.DEFAULT_ADMIN_EMAIL,
        title: `La reserva ha sido confirmada ¡Distruta de tu nuevo/a roomie!`,
        html: `<div>
      <h1>Confirmación de reserva</h1>
      <p>Meter datos de reserva</p>
    </div>`
      });
    } catch (error) {
      console.error(error.response.body);
      throw generateError(
        'Error en el envío de mail. Inténtalo de nuevo más tarde.',
        500
      );
    }

    try {
      await sendEmail({
        toEmail: email2[0].email,
        fromEmail: process.env.DEFAULT_ADMIN_EMAIL,
        title: `La reserva ha sido confirmada ¡Distruta de tu nuevo/a roomie!`,
        html: `<div>
      <h1>Confirmación de reserva</h1>
      <p>Meter datos de reserva</p>
    </div>`
      });
    } catch (error) {
      throw generateError(
        'Error en el envío de mail. Inténtalo de nuevo más tarde.',
        500
      );
    }

    //Marcamos el match como completado con éxito para mostrarlo como archivado
    await connection.query(
      `UPDATE user_match SET status='booking' WHERE id_match=?`,
      [idmatch]
    );

    //Cancelamos el resto de solicitudes de reserva de ambos ususarios al aceptar una reserva
    const [bookingsUser1] = await connection.query(
      `
    SELECT booking.id_booking FROM booking
    JOIN user_match ON booking.id_match=user_match.id_match 
    WHERE (user_match.id_user1=? OR user_match.id_user2=?) AND booking.status ='enviada'
     `,
      [booking[0].id_user1, booking[0].id_user1]
    );

    const [bookingsUser2] = await connection.query(
      `
    SELECT booking.id_booking FROM booking
    JOIN user_match ON booking.id_match=user_match.id_match 
    WHERE (user_match.id_user1=? OR user_match.id_user2=?) AND booking.status ='enviada'
     `,
      [booking[0].id_user2, booking[0].id_user2]
    );

    const bookingsToCancel = bookingsUser1.concat(bookingsUser2);

    for (let i = 0; i < bookingsToCancel.length; i++) {
      await connection.query(
        `UPDATE booking SET status='cancelada' WHERE id_booking=?`,
        [bookingsToCancel[i].id_booking]
      );
    }

    //La habitación deja de estar disponible en ninguna fecha
    await connection.query(
      `
    UPDATE room SET availability_from=null, availability_until=null WHERE id_room=?
    `,
      [booking[0].id_room]
    );

    response.send({
      status: 'ok',
      message: `Reserva confirmada correctamente. ¡Gracias por utilizar roomie!`
    });
  } catch (error) {
    next(error);
  } finally {
    if (connection) {
      connection.release();
    }
  }
}

module.exports = { acceptBooking };
