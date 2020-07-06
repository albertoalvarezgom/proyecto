require('dotenv').config();
// const chalk = require('chalk');

const { getConnection } = require('../../db/db.js');
// const { generateError } = require('../../helpers/helpers.js');

async function getUserRule(request, response, next) {
  let connection;
  try {
    const { id } = request.params;

    connection = await getConnection();

    const [rules] = await connection.query(
      `SELECT rule.name, rule_user.status
       FROM rule JOIN rule_user ON rule.id_rule=rule_user.id_rule
      WHERE rule_user.id_user=?`,
      [id]
    );

    response.send({
      status: 'ok',
      rules: rules
    });
  } catch (error) {
    next(error);
  } finally {
    if (connection) {
      connection.release();
    }
  }
}

module.exports = { getUserRule };
