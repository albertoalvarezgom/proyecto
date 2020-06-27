const { getConnection } = require('../../db/db.js');

async function getSubmitedVotes(request, response, next) {
  let connection;
  try {
    const { id } = request.params;
    connection = await getConnection();

    const [rating] = await connection.query(
      `SELECT rating.rate, rating.comment, rating.creation_date, 
    user.first_name, user.image_1 
    FROM rating LEFT JOIN user ON user.id_user=rating.id_user_gets WHERE rating.id_user_sends=?`,
      [id]
    );

    response.send({ status: 'ok', votes: rating });
  } catch (error) {
    next(error);
  } finally {
    connection.release();
  }
}

module.exports = { getSubmitedVotes };
