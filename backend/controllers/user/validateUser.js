require('dotenv').config();

const { getConnection } = require('../../db/db.js');
const { generateError } = require('../../helpers/helpers.js');
const chalk = require('chalk');

async function validateUser(request, response, next) {
  let connection;
  try {
    connection = await getConnection();

    const { code } = request.query;

    const [
      result
    ] = await connection.query(
      'UPDATE user SET active=1, registration_code=NULL WHERE registration_code=?',
      [code]
    );

    if (result.affectedRows === 0) {
      throw generateError('Validación incorrecta', 400);
    }

    response.send({
      status: 'ok',
      message: 'Usuario validado correctamente. Haz login para entrar a la web'
    });
  } catch (error) {
    next(error);
  } finally {
    if (connection) {
      connection.release();
    }
  }
}

module.exports = { validateUser };
