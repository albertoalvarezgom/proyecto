require('dotenv').config();

// const chalk = require('chalk');
const { getConnection } = require('../../db/db.js');
const { generateError } = require('../../helpers/helpers.js');

async function hideUser(request, response, next) {
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
        'No tienes permisos para ocultar esta cuenta de usuario',
        401
      );
    }

    await connection.query(`UPDATE user SET hidden=1 WHERE id_user=?`, [id]);

    response.send({
      status: 'ok',
      message: `La cuenta de usuario con id ${id} fue narcada como oculta correctamente`
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
  hideUser
};
