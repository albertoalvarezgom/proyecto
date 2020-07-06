require('dotenv').config();

const { getConnection } = require('../../db/db.js');
const { generateError } = require('../../helpers/helpers.js');
// const chalk = require('chalk');

async function deleteRoom(request, response, next) {
  let connection;
  try {
    const { id } = request.params;

    connection = await getConnection();

    const [
      idUserRoom
    ] = await connection.query(`SELECT id_user FROM room WHERE id_user=?`, [
      id
    ]);

    if (idUserRoom[0].id_user !== request.auth.id) {
      throw generateError(
        `No tienes permiso para realizar esta acción: Sólo el propietario puede eliminar una habitación.`,
        401
      );
    }

    await connection.query(
      `UPDATE user SET type='buscando piso', hidden=0 WHERE id_user=?`,
      [id]
    );

    await connection.query(`DELETE FROM room WHERE id_user=?`, [id]);

    response.send({
      status: 'ok',
      message: `La habitación del usuario con id ${id} fue eliminada con éxito.`
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
