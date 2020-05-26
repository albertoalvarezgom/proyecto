const { getConnection } = require('../../db/db.js');
const { generateError } = require('../../helpers/helpers.js');

async function deleteMessage(request, response, next) {
  let connection;
  try {
    const { id } = request.params;
    connection = await getConnection();

    const [existingMatch] = await connection.query(
      `
    SELECT id_match FROM user_match WHERE id_match=?`,
      [id]
    );

    if (!existingMatch.length) {
      throw generateError(
        `El match con id ${id} no existe en nuestra BBDD`,
        404
      );
    }

    const [
      existingMessage
    ] = await connection.query(
      `SELECT id_message FROM messages WHERE id_message=?`,
      [id]
    );

    if (!existingMessage.length) {
      throw generateError(`No existe un mensaje con el id ${id} en la BBDD`);
    }

    if (request.auth.role !== 'admin') {
      throw generateError(
        'Solo un administrador puede eliminar un mensaje',
        400
      );
    }

    await connection.query(`DELETE FROM messages WHERE id_message=?)`, [id]);

    response.send({
      status: 'ok',
      message: `El mensaje con id ${id} ha sido borrado por un administrador`
    });
  } catch (error) {
    next(error);
  } finally {
    connection.release();
  }
}

module.exports = { deleteMessage };
