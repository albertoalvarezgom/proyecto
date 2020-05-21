require('dotenv').config();

const { getConnection } = require('../../db/db.js');
const { generateError } = require('../../helpers/helpers.js');

async function deleteRoom(request, response, next) {
  let connection;
  try {
    const { id } = request.params;

    connection = await getConnection();

    const [
      idUserRoom
    ] = await connection.query(`SELECT id_user FROM room WHERE id_room=?`, [
      id
    ]);

    if (idUserRoom[0].id_user !== request.auth.id) {
      throw generateError(
        'No tienes permiso para realizar esta acción: Sólo el propietario puede eliminar una habitación.',
        401
      );
    }

    await connection.query('delete from room where id_room=?', [id]);

    response.send({
      status: 'ok',
      message: `La habitación con id ${id} fue eliminada por el titular de la entrada`
    });
  } catch (error) {
    next(error);
  } finally {
    if (connection) {
      connection.release();
    }
  }
}

module.exports = {
  deleteRoom
};
