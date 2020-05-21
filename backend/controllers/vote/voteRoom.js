const { getConnection } = require('../../db/db.js');
const { generateError } = require('../../helpers/helpers.js');
const { voteSchema } = require('../../validations/voteValidation.js');

async function voteRoom(request, response, next) {
  let connection;
  try {
    const { id } = request.params;

    await voteSchema.validateAsync(request.body);

    const { rating, comment } = request.body;

    connection = await getConnection();

    const [
      entry
    ] = await connection.query('select id_room from room where id_room=?', [
      id
    ]);

    if (!entry.length) {
      throw generateError(
        `La habitación con id ${id} no se encuentra en la BBDD`,
        404
      );
    }

    const [
      existingVote
    ] = await connection.query(
      `select id_rating from rating where id_room_gets=? and id_user_sends=?`,
      [id, request.auth.id]
    );

    if (existingVote.length) {
      throw generateError(
        `El usuario con id${request.auth.id} ya ha valorado la habitación con id ${id}`,
        403
      );
    }

    const [
      room
    ] = await connection.query(`select id_user from room where id_room=?`, [
      id
    ]);

    if (request.auth.id === room.id_user) {
      throw generateError(
        'Un propietario no puede valorar su propia habitación',
        401
      );
    }

    const [bookingMatch] = await connection.query(
      `SELECT booking.id_booking from booking JOIN room on booking.id_user_owner=room.id_user 
      WHERE booking.id_user=? AND booking.id_user_owner=room.id_user AND status="accepted AND room.id_room=?"`,
      [request.auth.id, id]
    );

    if (!bookingMatch.length) {
      throw generateError(
        'No hay registro en nuestra BBDD de una reserva a esta habitación con tu id de usuario',
        401
      );
    }

    await connection.query(
      `insert into rating (id_user_sends, id_room_gets, type, rate, comment, creation_date)
      values(?, ?, 'room', ?, ?, now())`,
      [request.auth.id, id, rating, comment]
    );
    //
    //
    response.send({
      status: 'ok',
      message: `El voto (${rating} puntos) a la habitación ${id} se ha enviado correctamente`
    });
  } catch (error) {
    next(error);
  } finally {
    connection.release();
  }
}

module.exports = { voteRoom };
