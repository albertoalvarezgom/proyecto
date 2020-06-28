require('dotenv').config();

const { getConnection } = require('../../db/db.js');
const { generateError, sendEmail } = require('../../helpers/helpers.js');
const chalk = require('chalk');

async function validateUser(request, response, next) {
  let connection;
  try {
    connection = await getConnection();

    const { code } = request.query;

    const [
      user
    ] = await connection.query(
      `SELECT id_user, email FROM user WHERE registration_code=?`,
      [code]
    );

    //METER HOBBIES, PERSONALIDAD Y REGLAS A FALSO
    const [hobbies] = await connection.query(`SELECT id_hobby FROM hobby`);

    for (let i = 1; i <= hobbies.length; i++) {
      await connection.query(
        `INSERT INTO hobby_user(id_user, id_hobby, status) VALUES(?,?,false)`,
        [user[0].id_user, i]
      );
    }

    const [personalities] = await connection.query(
      `SELECT id_personality FROM personality`
    );

    for (let i = 1; i <= personalities.length; i++) {
      await connection.query(
        `INSERT INTO personality_user(id_user, id_personality, status) VALUES(?,?,false)`,
        [user[0].id_user, i]
      );
    }

    console.log(personalities.length);

    const [rules] = await connection.query(`SELECT id_rule FROM rule`);

    for (let i = 1; i <= rules.length; i++) {
      await connection.query(
        `INSERT INTO rule_user(id_user, id_rule, status) VALUES(?,?,false)`,
        [user[0].id_user, i]
      );
    }

    const [
      result
    ] = await connection.query(
      'UPDATE user SET active=1, registration_code=NULL WHERE registration_code=?',
      [code]
    );

    if (result.affectedRows === 0) {
      throw generateError('Validación incorrecta', 400);
    }

    try {
      await sendEmail({
        toEmail: user[0].email,
        fromEmail: process.env.DEFAULT_ADMIN_EMAIL,
        title: '¡Bienvenido/a a roomie!',
        html: `<div>
      <h1>El siguiente paso es completar tu perfil</h1>
      <p>Haz login y comienza a editar tu perfil.</p> 
      <p>¡Cuanto más completo más oportunidades tendrás de encontrar a tu roomie ideal!</p> 
    </div>`
      });
    } catch (error) {
      console.error(error.response.body);
      throw generateError(
        'Error en el envío de mail. Inténtalo de nuevo más tarde.',
        500
      );
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
