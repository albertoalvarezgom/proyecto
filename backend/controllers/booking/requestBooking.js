const chalk = require('chalk');
const { getConnection } = require('../../db/db.js');
const {
  generateError,
  randomString,
  sendEmail
} = require('../../helpers/helpers.js');

async function requestBooking(request, response, next) {
  let connection;

  try {
    const { id } = request.params;
    const { startDate, finishDate } = request.body;
    connection = await getConnection();

    //Comprobamos que el match sobre el que se está realizando la solicitud de reserva existe
    const [
      checkMatch
    ] = await connection.query(
      `SELECT id_user1, id_user2 FROM user_match WHERE id_match=?`,
      [id]
    );

    if (!checkMatch.length) {
      throw generateError(`El match con id ${id} no existe en en la BBDD`, 404);
    }

    //Comprobamos que el usuario que realiza la solicitud es uno de los dos miembros del match
    if (
      request.auth.id !== checkMatch[0].id_user1 &&
      request.auth.id !== checkMatch[0].id_user2
    ) {
      throw generateError(
        `El usuario con id ${request.auth.id} no puede solicitar una reserva`,
        401
      );
    }

    const [
      existingBooking
    ] = await connection.query(
      `SELECT id_booking FROM booking WHERE status='pending' AND id_match=?`,
      [id]
    );

    if (existingBooking.length) {
      throw generateError(
        'La solicitud para esta reserva ya ha sido enviada. ¡Gracias!',
        400
      );
    }

    //Sacamos el nombre y el mail del usuario que realiza la solicitud de reserva
    const [
      user
    ] = await connection.query(
      `SELECT first_name, email FROM user WHERE id_user=?`,
      [request.auth.id]
    );

    //Sacamos la dirección de mail de los dos usuarios del match
    const [
      emailUser1
    ] = await connection.query(`SELECT email FROM user WHERE id_user=?`, [
      checkMatch[0].id_user1
    ]);

    const [
      emailUser2
    ] = await connection.query(`SELECT email FROM user WHERE id_user=?`, [
      checkMatch[0].id_user2
    ]);

    //Generamos un código de confirmación de reserva
    const confirmationCode = randomString(40);
    //Contruimos la url de confirmación de reserva con el código anterior
    const confirmationURL = `${process.env.PUBLIC_HOST}/matches/${id}/booking/accept?code=${confirmationCode}`;

    //Como no sabemos cuál de los dos usuarios del match es el que solicita la reserva, comprobamos
    let toEmail;
    let fromEmail;
    if (request.auth.id === checkMatch[0].id_user1) {
      toEmail = emailUser2[0].email;
      fromEmail = user[0].email;
    } else {
      toEmail = emailUser1[0].email;
      fromEmail = user[0].email;
    }

    //Ejecutamos la función de enviar el mail
    try {
      await sendEmail({
        toEmail: toEmail,
        fromEmail: fromEmail,
        title: `¡${user[0].first_name} (id ${request.auth.id}) te ha enviado una solicitud de reserva!`,
        html: `<div>
      <h1>Valida tu email</h1>
      <p>Para validar tu cuenta de usuario pega esta url en tu navegador: ${confirmationURL}</p>  
    </div>`
      });
    } catch (error) {
      console.error(error.response.body);
      throw generateError(
        'Error en el envío de mail. Inténtalo de nuevo más tarde.',
        500
      );
    }

    //Metemos los valores de la reserva en la BBDD.
    //Por defecto, las nuevas reservas tienen status='pending' hasta que no son confirmadas
    await connection.query(
      `
      INSERT INTO booking (id_user1, id_user2, confirmation_code, start_date, finish_date)
      VALUES(?, ?, ?, ?, ?)
    `,
      [
        checkMatch[0].id_user1,
        checkMatch[0].id_user2,
        confirmationCode,
        startDate,
        finishDate
      ]
    );

    response.send({
      status: 'ok',
      message: `La solicitud de reserva correspondiente al match con id ${id} fue enviada correctamente`
    });
  } catch (error) {
    next(error);
  } finally {
    connection.release();
  }
}

module.exports = {
  requestBooking
};
