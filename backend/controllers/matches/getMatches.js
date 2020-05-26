const { getConnection } = require('../../db/db.js');
const { generateError } = require('../../helpers/helpers.js');

const chalk = require('chalk');

async function getMatches(request, response, next) {
  let connection;
  try {
    const { id } = request.params;
    connection = await getConnection();

    if (Number(id) !== request.auth.id) {
      throw generateError(
        `Sólo el usuario con id ${id} puede ver sus propios matches`,
        401
      );
    }

    const [
      matches
    ] = await connection.query(
      `SELECT * FROM user_match WHERE id_user1=? OR (id_user2=? AND status='match')`,
      [request.auth.id, request.auth.id]
    );

    response.send({ status: 'ok', data: matches });
  } catch (error) {
    next(error);
  } finally {
    connection.release();
  }
}

module.exports = { getMatches };
