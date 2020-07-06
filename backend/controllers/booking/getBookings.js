const { getConnection } = require('../../db/db.js');
const {
  generateError,
  formatDateToFront
} = require('../../helpers/helpers.js');
// const chalk = require('chalk');

async function getBookings(request, response, next) {
  let connection;
  try {
    connection = await getConnection();

    const { id } = request.params;

    const [
      existingUser
    ] = await connection.query(
      `SELECT id_user, type FROM user WHERE id_user=?`,
      [id]
    );

    if (!existingUser.length) {
      throw generateError(
        `El usuario con el id ${id} no se encuentra en la BBDD`,
        404
      );
    }

    if (request.auth.id !== existingUser[0].id_user) {
      throw generateError(
        `El usuario con el id ${request.auth.id} tiene permisos para ver las reservas del usuario con id ${id}`,
        404
      );
    }

    const [bookings] = await connection.query(
      `SELECT booking.*, room.image_1, room.title, room.price, 
      user.first_name as name1, user.image_1 as user_image1, user.email as user_email, user.phone as user_phone,
      user_match.id_user1, user_match.id_user2
      FROM booking 
      JOIN user_match ON booking.id_match=user_match.id_match
      JOIN room ON room.id_room = booking.id_room
      JOIN user ON user_match.id_user1 = user.id_user 
      WHERE user_match.id_user1=? OR user_match.id_user2=?`,
      [id, id]
    );

    const otherUsers = [];

    for (let i = 0; i < bookings.length; i++) {
      let [user] = await connection.query(
        `SELECT user.id_user, user.first_name, user.image_1, user.email, user.phone FROM user
      JOIN user_match ON user_match.id_user2 = user.id_user 
      WHERE user_match.id_match=?`,
        [bookings[i].id_match]
      );
      otherUsers.push(user);
    }

    const fullBooking = [];
    for (let i = 0; i < bookings.length; i++) {
      const bookingDate = formatDateToFront(bookings[i].creation_date);
      const startDate = formatDateToFront(bookings[i].start_date);
      const finishDate = formatDateToFront(bookings[i].finish_date);
      const element = {
        booking: {
          title: bookings[i].title,
          image_1: bookings[i].image_1,
          creation_date: bookingDate,
          start_date: startDate,
          finish_date: finishDate,
          user_image_1: bookings[i].user_image1,
          name1: bookings[i].name1,
          id_user_sending: bookings[i].id_user_sending,
          id_match: bookings[i].id_match,
          status: bookings[i].status,
          confirmation_code: bookings[i].confirmation_code,
          email: bookings[i].user_email,
          phone: bookings[i].user_phone,
          voted: bookings[i].voted,
          id_user1: bookings[i].id_user1,
          id_user2: bookings[i].id_user2
        },
        otherUser: otherUsers[i]
      };
      fullBooking.push(element);
    }

    response.send({ status: 'ok', bookings: fullBooking });
  } catch (error) {
    next(error);
  } finally {
    connection.release();
  }
}

module.exports = {
  getBookings
};
