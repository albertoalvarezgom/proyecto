const { getConnection } = require('../../db/db.js');
const { generateError } = require('../../helpers/helpers.js');

async function cancelMatch(request, response, next) {
  let connection;
  try {
    const { id } = request.params;
    connection = await getConnection();

    const [users] = await connection.query(
      `
    SELECT id_match, id_user1, id_user2 FROM user_match WHERE id_match=?`,
      [id]
    );

    if (!users.length) {
      throw generateError(
        `El match con id ${id} no existe en nuestra BBDD`,
        404
      );
    }

    if (
      users[0].id_user1 !== request.auth.id &&
      users[0].id_user2 !== request.auth.id
    ) {
      throw generateError('No tienes permiso para cancelar este match', 401);
    }

    await connection.query(`DELETE FROM user_match WHERE id_match=?`, [id]);
    await connection.query(`DELETE FROM messages WHERE id_match=?`, [id]);

    response.send({
      status: 'ok',
      message: `El match con id ${id} ha sido borrado`
    });
  } catch (error) {
    next(error);
  } finally {
    connection.release();
  }
}

module.exports = { cancelMatch };
