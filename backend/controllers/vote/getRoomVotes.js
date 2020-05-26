const { getConnection } = require('../../db/db.js');

async function getRoomVotes(request, response, next) {
  let connection;
  try {
    const { id } = request.params;
    connection = await getConnection();

    const [rating] = await connection.query(
      `select rating.rate, rating.comment, rating.creation_date, 
    user.first_name, user.image_1 
    from rating left join user on user.id_user=rating.id_user_sends where rating.type='room' and rating.id_room_gets=?`,
      [id]
    );
    response.send({ status: 'ok', data: rating });
  } catch (error) {
    next(error);
  } finally {
    connection.release();
  }
}

module.exports = { getRoomVotes };
