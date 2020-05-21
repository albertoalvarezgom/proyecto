require('dotenv').config();
// const chalk = require('chalk');

const { getConnection } = require('../../db/db.js');
const { generateError } = require('../../helpers/helpers.js');

async function viewRoom(request, response, next) {
  let connection;
  try {
    const { id } = request.params;

    connection = await getConnection();

    const [
      hiddenUser
    ] = await connection.query(
      `SELECT id_user FROM user WHERE hidden=1 AND id_user=?`,
      [request.auth.id]
    );

    if (hiddenUser.length) {
      throw generateError(
        'Un usuario oculto no puede realizar búsqedas. Haz tu cuenta visible e inténtalo de nuevo',
        401
      );
    }

    const [room] = await connection.query(
      `SELECT *,  
      (SELECT ROUND(AVG(rate),1) FROM rating WHERE rating.id_room_gets=room.id_room) AS rating
      FROM room WHERE room.id_room=?`,
      [id]
    );

    if (!room.length) {
      throw (
        (generateError(`La habitación con id ${id} no existe en la BBDD`), 404)
      );
    }

    await connection.query('UPDATE room SET views=? WHERE id_room=?', [
      room[0].views + 1,
      id
    ]);

    response.send({ status: 'ok', data: room[0] });
  } catch (error) {
    next(error);
  } finally {
    if (connection) {
      connection.release();
    }
  }
}

module.exports = { viewRoom };
