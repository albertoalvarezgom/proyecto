require('dotenv').config();

const { getConnection } = require('../../db/db.js');
const { generateError } = require('../../helpers/helpers.js');
// const chalk = require('chalk');

async function cancelBooking(request, response, next) {
  let connection;
  try {
    connection = await getConnection();

    const { code } = request.query;

    const [
      result
    ] = await connection.query(
      `UPDATE booking SET status='cancelada' WHERE confirmation_code=?`,
      [code]
    );

    if (result.affectedRows === 0) {
      throw generateError('Confirmación incorrecta', 400);
    }

    await connection.query(
      `SELECT user_match.id_user1, user_match.id_user2, booking.id_room 
      FROM user_match JOIN booking ON booking.id_match=user_match.id_match 
      WHERE booking.confirmation_code=?`,
      [code]
    );

    response.send({
      status: 'ok',
      message: `La reserva ha sido cancelada. ¡Suerte buscando roomie!`
    });
  } catch (error) {
    next(error);
  } finally {
    if (connection) {
      connection.release();
    }
  }
}

module.exports = { cancelBooking };
