require('dotenv').config();
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const chalk = require('chalk');

const { getConnection } = require('../../db/db.js');
const { generateError } = require('../../helpers/helpers.js');
const { loginSchema } = require('../../validations/userValidation');

async function loginUser(request, response, next) {
  let connection;
  try {
    const { email, password } = request.body;
    await loginSchema.validateAsync(request.body);

    connection = await getConnection();

    const [
      dbUser
    ] = await connection.query(
      'select id_user, email, password, role from user where email=? and active=1',
      [email]
    );

    if (!dbUser.length) {
      throw generateError(
        'No hay ningún usuario activo con ese mail. Regístrate y valida el email antes de iniciar sesión',
        404
      );
    }

    const [user] = dbUser;

    const passwordMatch = await bcrypt.compare(password, user.password);

    if (!passwordMatch) {
      throw generateError('La contraseña no es correcta', 401);
    }

    const tokenPayload = { id: user.id_user, role: user.role };
    const token = jwt.sign(tokenPayload, process.env.SECRET, {
      expiresIn: '30d'
    });

    response.send({
      status: 'ok',
      message: 'Login Correcto. Bienvenido!',
      data: token
    });
  } catch (error) {
    next(error);
  } finally {
    if (connection) {
      connection.release();
    }
  }
}

module.exports = { loginUser };
