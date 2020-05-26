const { getConnection } = require('../../db/db.js');
const { generateError } = require('../../helpers/helpers.js');
const { voteSchema } = require('../../validations/voteValidation.js');

async function editUserVote(request, response, next) {
  let connection;
  try {
    const { id } = request.params;

    await voteSchema.validateAsync(request.body);

    const { rating, comment } = request.body;

    connection = await getConnection();

    //Si existe el id

    const [
      matchingVote
    ] = await connection.query(
      `select id_rating from rating where id_user_sends=? and id_user_gets=? and type='user'`,
      [request.auth.id, id]
    );

    if (!matchingVote.length) {
      throw generateError(
        'No se ecntotró un voto con estos datos para editar',
        404
      );
    }
    //Si el req.auth.id es igual al id_sends
    if (request.auth.id !== id) {
      throw generateError('No tienes permiso para editar este voto', 401);
    }

    await connection.query(
      `update rating set rating=?, comment=? where id_user_sends=? and id_user_gets=?`,
      [rating, comment, request.auth.id, id]
    );

    response.send({
      status: 'ok',
      message: `El voto al usuario con id ${id} ha sido actualizado correctamente`
    });
  } catch (error) {
    next(error);
  } finally {
    connection.release();
  }
}

module.exports = { editUserVote };
