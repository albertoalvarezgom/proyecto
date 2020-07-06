require('dotenv').config();

// const chalk = require('chalk');
const { getConnection } = require('../../db/db.js');
const { generateError, deletePhoto } = require('../../helpers/helpers.js');

async function deleteUser(request, response, next) {
  let connection;
  try {
    const { id } = request.params;

    connection = await getConnection();

    if (request.auth.role !== 'admin') {
      throw generateError(
        'Solo un administrador puede eliminar un usuario',
        400
      );
    }

    const [
      user
    ] = await connection.query(`select image_1 from user where id_user=?`, [
      id
    ]);

    if (!user.length) {
      throw generateError(
        `El usuario con el id ${id} no existe en la BBDD`,
        404
      );
    }

    if (user[0].image_1) {
      await deletePhoto(user[0].image_1);
    }

    await connection.query('delete from user where id_user=?', [id]);

    response.send({
      status: 'ok',
      message: `El usuario con id ${id} fue eliminado por el administrador de la web`
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
  deleteUser
};
