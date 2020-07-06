require('dotenv').config();
const bcrypt = require('bcrypt');

const { getConnection } = require('../../db/db.js');

const {
  generateError,
  randomString,
  sendEmail
} = require('../../helpers/helpers.js');

// const { newUserSchema } = require('../../validations/userValidation');

async function newUser(request, response, next) {
  let connection;
  try {
    // await newUserSchema.validateAsync(request.body);
    connection = await getConnection();

    const { name, birthday, email, password, city, phone } = request.body;

    const [
      existingEmail
    ] = await connection.query(`select id_user from user where email=?`, [
      email
    ]);

    if (existingEmail.length) {
      throw generateError('Este email ya está registrado en la BBDD', 409);
    }

    const dbPassword = await bcrypt.hash(password, 10);
    const registrationCode = randomString(40);
    const validationURL = `${process.env.PUBLIC_HOST}/user/validate?code=${registrationCode}`;

    try {
      await sendEmail({
        toEmail: email,
        fromEmail: process.env.DEFAULT_ADMIN_EMAIL,
        title: '¡Bienvenido/a a roomie!',
        html: `<div>
      <h1>Valida tu email</h1>
      <p>Para validar tu cuenta de usuario pega esta url en tu navegador: ${validationURL}</p> 
      <p>Una vez que hagas login, no olvides editar tu perfil de usuario. ¡Cuanto más completo más oportunidades tendrás de encontrar a tu roomie ideal!</p> 
    </div>`
      });
    } catch (error) {
      console.error(error.response.body);
      throw generateError(
        'Error en el envío de mail. Inténtalo de nuevo más tarde.',
        500
      );
    }

    await connection.query(
      `
      INSERT INTO user (first_name, birthday, email, password, city, phone, creation_date, last_update, registration_code)
      VALUES(?, ?, ?, ?, ?, ?, NOW(), NOW(), ?)
    `,
      [name, birthday, email, dbPassword, city, phone, registrationCode]
    );

    response.send({
      status: 'ok',
      message:
        'El usuario creado correctamente. Revisa tu email para confirmar tu alta',
      data: { name: name, birthday: birthday, email: email }
    });
  } catch (error) {
    next(error);
  } finally {
    if (connection) {
      connection.release();
    }
  }
}

module.exports = { newUser };
