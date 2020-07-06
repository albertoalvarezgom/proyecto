const { getConnection } = require('../../db/db.js');
const { generateError } = require('../../helpers/helpers.js');

// const chalk = require('chalk');

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
      `SELECT id_match, id_user1, id_user2 FROM user_match WHERE id_user1=? OR (id_user2=? AND status='match')`,
      [request.auth.id, request.auth.id]
    );

    const matchesId = [];
    for (let i = 0; i < matches.length; i++) {
      if (matches[i].id_user1 !== request.auth.id) {
        matchesId.push(matches[i].id_user1);
      }
      if (matches[i].id_user2 !== request.auth.id) {
        matchesId.push(matches[i].id_user2);
      }
    }

    const matchesArray = [];

    for (let i = 0; i < matchesId.length; i++) {
      let [
        userData
      ] = await connection.query(
        `SELECT id_user, first_name, image_1 FROM user WHERE id_user=?`,
        [matchesId[i]]
      );
      let [
        statusData
      ] = await connection.query(
        `SELECT id_match, status FROM user_match WHERE id_user1=? OR (id_user2=? AND status='match')`,
        [request.auth.id, request.auth.id]
      );
      matchesArray.push({ user: userData, match: statusData[i] });
    }

    response.send({ status: 'ok', data: matchesArray });
  } catch (error) {
    next(error);
  } finally {
    connection.release();
  }
}

module.exports = { getMatches };
