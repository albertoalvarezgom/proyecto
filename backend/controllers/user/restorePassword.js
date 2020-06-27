require('dotenv').config();
const bcrypt = require('bcrypt');
const chalk = require('chalk');

const { getConnection } = require('../../db/db.js');
const {
  generateError,
  randomString,
  restoreEmail
} = require('../../helpers/helpers.js');

const { emailSchema } = require('../../validations/userValidation');

async function restorePassword(req, res, next) {
  let connection;

  try {
    await emailSchema.validateAsync(req.body);

    const { email } = req.body;

    connection = await getConnection();

    const [
      user
    ] = await connection.query(
      'SELECT id_user, email, password FROM user WHERE email=? AND active=1',
      [email]
    );

    console.log(chalk.inverse.yellow(email));

    if (!user.length) {
      throw generateError(
        'No se encuentra ningún usuario activo registrado con ese email en la BBDD',
        404
      );
    }

    const [dbUser] = user;

    const tempPass = randomString(10);

    try {
      await restoreEmail({
        email: dbUser.email,
        title: 'Esta es tu contraseña',
        content: `Tu nueva contraseña es ${tempPass}. Inicia sesión con ella y cámbiala lo antes posible por motivos de seguridad`
      });
    } catch (error) {
      throw generateError(
        'Algo ha fallado enviando el email de recuperación de contraseña',
        500
      );
    }

    const tempDBPassword = await bcrypt.hash(tempPass, 10);

    await connection.query('UPDATE user SET password=? WHERE id_user=?', [
      tempDBPassword,
      dbUser.id_user
    ]);

    res.send({
      staus: 'ok',
      message: 'Una nueva contraseña ha sido enviada por email'
    });
  } catch (error) {
    next(error);
  } finally {
    if (connection) {
      connection.release();
    }
  }
}

module.exports = { restorePassword };
