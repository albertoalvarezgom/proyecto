require('dotenv').config();

const { getConnection } = require('../../db/db.js');
const { generateError } = require('../../helpers/helpers.js');

async function deleteVote(request, response, next) {
  let connection;
  try {
    const { id } = request.params;

    connection = await getConnection();

    if (request.auth.role !== 'admin') {
      throw generateError(
        'Solo un administrador puede eliminar una valoración',
        400
      );
    }
    await connection.query('delete from rating where id_rating=?', [id]);

    response.send({
      status: 'ok',
      message: `La valoración con id ${id} fue eliminada por el administrador de la web`
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
  deleteVote
};
