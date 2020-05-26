const { getConnection } = require('../../db/db.js');
const { generateError } = require('../../helpers/helpers.js');
const { voteSchema } = require('../../validations/voteValidation.js');

async function voteUser(request, response, next) {
  let connection;
  try {
    const { id } = request.params;

    await voteSchema.validateAsync(request.body);

    const { rating, comment } = request.body;

    connection = await getConnection();

    const [
      entry
    ] = await connection.query('select id_user from user where id_user=?', [
      id
    ]);

    if (!entry.length) {
      throw generateError(
        `El usuario con id ${id} no se encuentra en la BBDD`,
        404
      );
    }

    const [
      existingVote
    ] = await connection.query(
      `select id_rating from rating where id_user_gets=? and id_user_sends=?`,
      [id, request.auth.id]
    );

    if (existingVote.length) {
      throw generateError(
        `El usuario con id${request.auth.id} ya ha votado al usuario con id ${id}`,
        403
      );
    }

    const [
      bookingMatchA
    ] = await connection.query(
      'select id_booking from booking where id_user=? and id_user_owner=? and status="accepted"',
      [id, request.auth.id]
    );

    const [
      bookingMatchB
    ] = await connection.query(
      'select id_booking from booking where id_user=? and id_user_owner=? and status="accepted"',
      [request.auth.id, id]
    );

    if (bookingMatchA.length || bookingMatchB.length) {
      await connection.query(
        `insert into rating (id_user_sends, id_user_gets, type, rate, comment, creation_date)
      values(?, ?, 'user', ?, ?, now())`,
        [request.auth.id, id, rating, comment]
      );
    }

    //
    //
    response.send({
      status: 'ok',
      message: `El voto (${rating} puntos) al usuario ${id} se ha enviado correctamente`
    });
  } catch (error) {
    next(error);
  } finally {
    connection.release();
  }
}

module.exports = { voteUser };
