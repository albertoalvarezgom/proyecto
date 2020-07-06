require('dotenv').config();
// const chalk = require('chalk');

const { getConnection } = require('../../db/db.js');
// const { generateError } = require('../../helpers/helpers.js');

async function getUserPersonality(request, response, next) {
  let connection;
  try {
    const { id } = request.params;

    connection = await getConnection();

    const [personalities] = await connection.query(
      `SELECT personality.name, personality_user.status
       FROM personality JOIN personality_user ON personality.id_personality=personality_user.id_personality
      WHERE personality_user.id_user=?`,
      [id]
    );

    response.send({
      status: 'ok',
      personalities: personalities
    });
  } catch (error) {
    next(error);
  } finally {
    if (connection) {
      connection.release();
    }
  }
}

module.exports = { getUserPersonality };
