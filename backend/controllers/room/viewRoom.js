require('dotenv').config();
const chalk = require('chalk');

const { getConnection } = require('../../db/db.js');
const {
  generateError,
  formatDateToFront
} = require('../../helpers/helpers.js');

async function viewRoom(request, response, next) {
  let connection;
  try {
    const { id } = request.params;

    connection = await getConnection();

    const [room] = await connection.query(
      `SELECT * FROM room WHERE id_user=?`,
      [id]
    );

    if (!room.length) {
      throw generateError(`La habitación no existe en la BBDD`, 404);
    }

    if (room[0].hidden === 1 && request.auth.id !== room[0].id_user) {
      throw generateError(
        `No se puede mostrar la habitación con id ${room[0].id_room}. Ahora mismo esta entrada está oculta`,
        404
      );
    }

    const [
      facility
    ] = await connection.query(
      `SELECT facility.name FROM facility_room JOIN facility ON facility_room.id_facility=facility.id_facility WHERE id_room=?`,
      [room[0].id_room]
    );

    await connection.query('UPDATE room SET views=? WHERE id_room=?', [
      room[0].views + 1,
      room[0].id_room
    ]);

    const fromDate = formatDateToFront(room[0].availability_from);
    const untilDate = formatDateToFront(room[0].availability_until);

    const payload = {
      title: room[0].title,
      description: room[0].description,
      address: room[0].address,
      postal_code: room[0].postal_ode,
      city: room[0].city,
      flatmates_masc: room[0].flatmates_masc,
      flatmates_fem: room[0].flatmates_fem,
      flatSize: room[0].flat_size,
      preference_gender: room[0].preference_gender,
      status: room[0].status,
      min_age: room[0].min_age,
      max_age: room[0].max_age,
      room_type: room[0].room_type,
      room_size: room[0].room_size,
      bed_type: room[0].bed_type,
      price: room[0].price,
      bills_included: room[0].bills_included,
      deposit: room[0].deposit,
      deposit_ammount: room[0].deposit_ammount,
      availability_from: fromDate,
      availability_until: untilDate,
      min_stay: room[0].min_stay,
      max_stay: room[0].max_stay,
      image_1: room[0].image_1,
      image_2: room[0].image_2,
      image_3: room[0].image_3,
      image_4: room[0].image_4,
      image_5: room[0].image_5
    };

    console.log(chalk.inverse.green(payload.title));

    response.send({
      status: 'ok',
      data: { room: payload, facility: facility }
    });
  } catch (error) {
    next(error);
  } finally {
    if (connection) {
      connection.release();
    }
  }
}

module.exports = { viewRoom };
