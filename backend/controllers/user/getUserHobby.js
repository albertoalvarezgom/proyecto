require('dotenv').config();
// const chalk = require('chalk');

const { getConnection } = require('../../db/db.js');
// const { generateError } = require('../../helpers/helpers.js');

async function getUserHobby(request, response, next) {
  let connection;
  try {
    const { id } = request.params;

    connection = await getConnection();

    const [hobbies] = await connection.query(
      `SELECT hobby.name, hobby_user.description, hobby_user.status
       FROM hobby JOIN hobby_user ON hobby.id_hobby=hobby_user.id_hobby
      WHERE hobby_user.id_user=?`,
      [id]
    );

    response.send({
      status: 'ok',
      hobbies: hobbies
    });
  } catch (error) {
    next(error);
  } finally {
    if (connection) {
      connection.release();
    }
  }
}

module.exports = { getUserHobby };
