require('dotenv').config();

const chalk = require('chalk');
const { getConnection } = require('../../db/db.js');
const { generateError } = require('../../helpers/helpers.js');

async function showUser(request, response, next) {
  let connection;
  try {
    const { id } = request.params;

    connection = await getConnection();

    const [
      user
    ] = await connection.query(
      `select id_user, hidden from user where id_user=?`,
      [id]
    );

    if (!user.length) {
      throw generateError(
        `El usuario con el id ${id} no existe en la BBDD`,
        404
      );
    }

    if (user[0].id_user !== request.auth.id && request.auth.role !== 'admin') {
      throw generateError(
        'No tienes permisos para hacer visible esta cuenta de usuario',
        401
      );
    }

    await connection.query(`update user set hidden=0 where id_user=?`, [id]);

    response.send({
      status: 'ok',
      message: `La cuenta de usuario con id ${id} fue marcada como visible correctamente`
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
  showUser
};
