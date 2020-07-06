const { getConnection } = require('../../db/db.js');
const { generateError } = require('../../helpers/helpers.js');

// const chalk = require('chalk');

async function sendMessage(request, response, next) {
  let connection;
  try {
    const { idmatch } = request.params;
    const { comment } = request.body;
    connection = await getConnection();

    const [
      existingMatch
    ] = await connection.query(
      `SELECT id_match FROM user_match WHERE id_match=?`,
      [idmatch]
    );

    if (!existingMatch.length) {
      throw generateError(
        `No existe un match con el id ${idmatch} en nuestra BBDD`
      );
    }

    const [userMatch] = await connection.query(
      `
    SELECT id_user1, id_user2 FROM user_match WHERE id_match=?
    `,
      [idmatch]
    );

    if (
      request.auth.id !== userMatch[0].id_user1 &&
      request.auth.id !== userMatch[0].id_user2
    ) {
      throw generateError(`No tienes permiso para escribir mensajes aquí`);
    }

    await connection.query(
      `INSERT INTO messages (id_user, id_match, comment) VALUES (?,?,?)`,
      [request.auth.id, idmatch, comment]
    );

    const [
      messages
    ] = await connection.query(
      `SELECT * FROM messages WHERE id_match=? ORDER BY creation_date DESC`,
      [idmatch]
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

module.exports = { sendMessage };
