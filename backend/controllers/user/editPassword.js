require('dotenv').config();
const bcrypt = require('bcrypt');

const { getConnection } = require('../../db/db.js');
const { generateError } = require('../../helpers/helpers.js');
const { changePasswordSchema } = require('../../validations/userValidation');

async function editPassword(request, response, next) {
  let connection;
  try {
    const { id } = request.params;

    connection = await getConnection();

    await changePasswordSchema.validateAsync(request.body);

    const { oldPassword, newPassword } = request.body;

    if (Number(id) !== request.auth.id) {
      throw generateError(
        `No tienes permisos para cambiar la contraseña del usuario con id ${id}`,
        401
      );
    }

    if (oldPassword === newPassword) {
      throw generateError(
        'La contraseña nueva debe ser distinta a la anterior',
        400
      );
    }

    const [
      currentUser
    ] = await connection.query(
      'select id_user, password from user where id_user=?',
      [id]
    );

    if (!currentUser.length) {
      throw generateError(`El usuario con id ${id} no existe`, 404);
    }

    const [dbUser] = currentUser;

    const passwordMatch = await bcrypt.compare(oldPassword, dbUser.password);

    if (!passwordMatch) {
      throw generateError('Tu contraseña original no es correcta', 401);
    }

    const dbNewPassword = await bcrypt.hash(newPassword, 10);

    const date = new Date();
    await connection.query(
      'update user set password=?, last_password_update=? where id_user =?',
      [dbNewPassword, date, id]
    );

    response.send({
      status: 'ok',
      message: 'Contraseña actualizada correctamente. Ya puedes hacer login!'
    });
  } catch (error) {
    next(error);
  } finally {
    if (connection) {
      connection.release();
    }
  }
}

module.exports = { editPassword };
