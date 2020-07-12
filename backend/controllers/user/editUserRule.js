require('dotenv').config();
const chalk = require('chalk');

const { getConnection } = require('../../db/db.js');
const { generateError } = require('../../helpers/helpers.js');

const { editUserRuleSchema } = require('../../validations/userValidation');

async function editUserRule(request, response, next) {
  let connection;
  try {
    await editUserRuleSchema.validateAsync(request.body);
    const { id } = request.params;
    const {
      rule1,
      status1,
      rule2,
      status2,
      rule3,
      status3,
      rule4,
      status4
    } = request.body;

    connection = await getConnection();

    const [
      current
    ] = await connection.query('select id_user from user where id_user=?', [
      id
    ]);

    if (!current.length) {
      throw generateError(`El usuario con id ${id} no existe en la BBDD`, 404);
    }

    if (
      current[0].id_user !== request.auth.id &&
      request.auth.role !== 'admin'
    ) {
      throw generateError(
        'No tienes permiso para editar este perfil de usuario',
        401
      );
    }

    await connection.query(
      `
      DELETE FROM rule_user WHERE id_user=?
      `,
      [id]
    );

    const [
      idRule1
    ] = await connection.query(`SELECT id_rule FROM rule WHERE name=?`, [
      rule1
    ]);

    await connection.query(
      `INSERT INTO rule_user(id_user, id_rule, status) 
      VALUES(?,?,?)`,
      [id, idRule1[0].id_rule, status1]
    );

    const [
      idRule2
    ] = await connection.query(`SELECT id_rule FROM rule WHERE name=?`, [
      rule2
    ]);

    await connection.query(
      `INSERT INTO rule_user(id_user, id_rule, status) 
      VALUES(?,?,?)`,
      [id, idRule2[0].id_rule, status2]
    );

    const [
      idRule3
    ] = await connection.query(`SELECT id_rule FROM rule WHERE name=?`, [
      rule3
    ]);

    await connection.query(
      `INSERT INTO rule_user(id_user, id_rule, status) 
      VALUES(?,?,?)`,
      [id, idRule3[0].id_rule, status3]
    );

    const [
      idRule4
    ] = await connection.query(`SELECT id_rule FROM rule WHERE name=?`, [
      rule4
    ]);

    await connection.query(
      `INSERT INTO rule_user(id_user, id_rule, status) 
      VALUES(?,?,?)`,
      [id, idRule4[0].id_rule, status4]
    );

    response.send({
      status: 'ok',
      message: `Usuario con id ${id} actualizado correctamente`
    });
  } catch (error) {
    next(error);
  } finally {
    if (connection) {
      connection.release();
    }
  }
}

module.exports = { editUserRule };
