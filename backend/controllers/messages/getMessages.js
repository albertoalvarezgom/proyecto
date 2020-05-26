const { getConnection } = require('../../db/db.js');
const { generateError } = require('../../helpers/helpers.js');

async function getMessages(request, response, next) {
  let connection;
  try {
    const { id } = request.params;
    connection = await getConnection();

    const [
      existingMatch
    ] = await connection.query(
      `SELECT id_match, id_user1, id_user2 FROM user_match WHERE id_match=?`,
      [id]
    );

    if (!existingMatch.length) {
      throw generateError(`No existe un match con el id ${id} en nuestra BBDD`);
    }

    if (
      request.auth.id !== existingMatch[0].id_user1 &&
      request.auth.id !== existingMatch[0].id_user2
    ) {
      throw generateError(
        `No tienes permiso para leer los mensajes de este chat`
      );
    }

    const [
      messages
    ] = await connection.query(
      `SELECT * FROM messages WHERE id_match=? ORDER BY creation_date DESC`,
      [id]
    );

    response.send({
      status: 'ok',
      messages: messages
    });
  } catch (error) {
    next(error);
  } finally {
    connection.release();
  }
}

module.exports = { getMessages };
