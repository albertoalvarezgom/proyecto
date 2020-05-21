require('dotenv').config();
const jwt = require('jsonwebtoken');
// const chalk = require('chalk');

const { getConnection } = require('../../db/db.js');
const { generateError } = require('../../helpers/helpers.js');

async function viewUser(request, response, next) {
  let connection;
  try {
    const { id } = request.params;

    connection = await getConnection();

    const [
      hiddenUser
    ] = await connection.query(
      `SELECT id_user FROM user WHERE hidden=1 AND id_user=?`,
      [request.auth.id]
    );

    if (hiddenUser.length) {
      throw generateError(
        'Un usuario oculto no puede realizar búsqedas. Haz tu cuenta visible e inténtalo de nuevo',
        401
      );
    }

    const [user] = await connection.query(
      `SELECT user.id_user, user.first_name, user.birthday, user.image_1, user.image_2, user.image_3, user.image_4, user.image_5, user.email, user.creation_date, user.gender, user.ig_profile, user.views, 
      (SELECT ROUND(AVG(rate),1) FROM rating WHERE rating.id_user_gets=user.id_user) AS rating
      FROM user WHERE user.id_user=?`,
      [id]
    );

    if (!user.length) {
      throw (
        (generateError(`El usuario con id ${id} no existe en la BBDD`), 404)
      );
    }

    const [dbUser] = user;

    const [
      bookingMatchA
    ] = await connection.query(
      'select id_booking from booking where id_user=? and id_user_owner=? and status="accepted"',
      [id, request.auth.id]
    );

    console.log(bookingMatchA.length);

    const [
      bookingMatchB
    ] = await connection.query(
      'select id_booking from booking where id_user=? and id_user_owner=? and status="accepted"',
      [request.auth.id, id]
    );

    const payload = {
      name: dbUser.first_name,
      birthday: dbUser.birthday,
      image1: dbUser.image_1,
      image2: dbUser.image_2,
      image3: dbUser.image_3,
      image4: dbUser.image_4,
      image5: dbUser.image_5,
      memberSince: dbUser.creation_date,
      gender: dbUser.gender,
      views: dbUser.views,
      igProfile: dbUser.ig_profile,
      rating: dbUser.rating
    };

    if (
      dbUser.id_user === request.auth.id ||
      request.auth.role === 'admin' ||
      bookingMatchA.length ||
      bookingMatchB.length
    ) {
      payload.email = dbUser.email;
    }

    await connection.query('update user set views=? where id_user=?', [
      dbUser.views + 1,
      id
    ]);

    response.send({ status: 'ok', data: payload });
  } catch (error) {
    next(error);
  } finally {
    if (connection) {
      connection.release();
    }
  }
}

module.exports = { viewUser };
