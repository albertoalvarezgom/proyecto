require('dotenv').config();
const chalk = require('chalk');

const { getConnection } = require('../../db/db.js');
const {
  generateError,
  formatDateToFront
} = require('../../helpers/helpers.js');

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
      `SELECT *,
      (SELECT YEAR(CURDATE()) - YEAR(birthday)) AS age, 
      (SELECT ROUND(AVG(rate),1) FROM rating WHERE rating.id_user_gets=user.id_user) AS rating
      FROM user
      WHERE hidden=0 AND id_user=?`,
      [id]
    );

    if (!user.length) {
      throw (
        (generateError(`El usuario con id ${id} no existe en la BBDD`), 404)
      );
    }

    if (user[0].hidden === true) {
      throw generateError(
        `No se puede mostrar el usuario con id ${id}. Ahora mismo este perfil está oculto`,
        404
      );
    }

    const [
      personality
    ] = await connection.query(
      `SELECT personality.name FROM personality_user JOIN personality ON personality_user.id_personality=personality.id_personality WHERE id_user=?`,
      [id]
    );

    const [
      hobby
    ] = await connection.query(
      `SELECT hobby.name, hobby_user.description FROM hobby_user JOIN hobby ON hobby_user.id_hobby=hobby.id_hobby WHERE id_user=?`,
      [id]
    );

    const [
      rule
    ] = await connection.query(
      `SELECT rule.name FROM rule_user JOIN rule ON rule_user.id_rule=rule.id_rule WHERE id_user=?`,
      [id]
    );

    const [room] = await connection.query(
      `SELECT * FROM room WHERE id_user=?`,
      [id]
    );

    const [dbUser] = user;

    const [
      bookingMatchA
    ] = await connection.query(
      `SELECT booking.id_booking from booking JOIN user_match ON booking.id_match=user_match.id_match WHERE user_match.id_user1=? AND user_match.id_user2=? AND booking.status="accepted"`,
      [id, request.auth.id]
    );

    const [
      bookingMatchB
    ] = await connection.query(
      `SELECT booking.id_booking from booking JOIN user_match ON booking.id_match=user_match.id_match WHERE user_match.id_user1=? AND user_match.id_user2=? AND booking.status="accepted"`,
      [request.auth.id, id]
    );

    //Preparamos algunas constantes para mostrarlas en el front como dios manda
    const date = formatDateToFront(dbUser.birthday);

    let formatCouple;
    if (dbUser.couple === 0) {
      formatCouple = 'No';
    } else {
      formatCouple = 'Sí';
    }

    let formatHidden;
    if (dbUser.hidden === 0) {
      formatHidden = 'No';
    } else {
      formatHidden = 'Sí';
    }

    let formatType;
    if (dbUser.type === 'owner') {
      formatType = 'Buscando inquilino';
    } else {
      formatType = 'Buscando piso';
    }

    let formatStatus;
    if (dbUser.occupation_status === 'both') {
      formatStatus = 'Ambas';
    } else if (dbUser.occupation_status === 'working') {
      formatStatus = 'Trabajando';
    } else {
      formatStatus = 'Estudiando';
    }

    let formatGender;
    if (dbUser.gender === 'masculine') {
      formatGender = 'Masculino';
    } else if (dbUser.gender === 'femenine') {
      formatGender = 'Femenino';
    } else {
      formatGender = 'Otro';
    }

    //Armamos el payload con toda la info
    const payload = {
      name: dbUser.first_name,
      age: dbUser.age,
      birthday: date,
      city: dbUser.city,
      gender: formatGender,
      occupationField: dbUser.occupation_field,
      occupationStatus: formatStatus,
      couple: formatCouple,
      ig_profile: dbUser.ig_profile,
      image1: dbUser.image_1,
      image2: dbUser.image_2,
      image3: dbUser.image_3,
      image4: dbUser.image_4,
      image5: dbUser.image_5,
      hidden: formatHidden,
      type: formatType,
      memberSince: dbUser.creation_date,
      views: dbUser.views,
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

    response.send({
      status: 'ok',
      data: {
        profile: payload,
        personality: personality,
        hobbies: hobby,
        rules: rule,
        room: room
      }
    });
  } catch (error) {
    next(error);
  } finally {
    if (connection) {
      connection.release();
    }
  }
}

module.exports = { viewUser };
