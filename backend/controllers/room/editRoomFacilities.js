require('dotenv').config();
// const chalk = require('chalk');

const { getConnection } = require('../../db/db.js');
const { generateError } = require('../../helpers/helpers.js');

// const {
//   editRoomFacilitiesSchema
// } = require('../../validations/roomValidation');

async function editRoomFacilities(request, response, next) {
  let connection;
  try {
    // await editRoomFacilitiesSchema.validateAsync(request.body);
    const { id } = request.params;
    const {
      facility1,
      status1,
      facility2,
      status2,
      facility3,
      status3,
      facility4,
      status4,
      facility5,
      status5,
      facility6,
      status6,
      facility7,
      status7,
      facility8,
      status8,
      facility9,
      status9,
      facility10,
      status10,
      facility11,
      status11,
      facility12,
      status12,
      facility13,
      status13,
      facility14,
      status14,
      facility15,
      status15,
      facility16,
      status16,
      facility17,
      status17,
      facility18,
      status18
    } = request.body;

    connection = await getConnection();

    const [
      current
    ] = await connection.query(`SELECT id_room FROM room WHERE id_user=?`, [
      id
    ]);

    if (!current.length) {
      throw generateError(`La habitación no existe en la BBDD`, 404);
    }

    if (Number(id) !== request.auth.id && request.auth.role !== 'admin') {
      throw generateError(
        'No tienes permiso para editar este perfil de usuario',
        401
      );
    }

    const [
      roomid
    ] = await connection.query(`SELECT id_room FROM room WHERE id_user=?`, [
      id
    ]);

    await connection.query(
      `
      DELETE FROM facility_room WHERE id_room=?
      `,
      [roomid[0].id_room]
    );
    //BUCLE

    const facilities = [
      facility1,
      facility2,
      facility3,
      facility4,
      facility5,
      facility6,
      facility7,
      facility8,
      facility9,
      facility10,
      facility11,
      facility12,
      facility13,
      facility14,
      facility15,
      facility16,
      facility17,
      facility18
    ];

    const status = [
      status1,
      status2,
      status3,
      status4,
      status5,
      status6,
      status7,
      status8,
      status9,
      status10,
      status11,
      status12,
      status13,
      status14,
      status15,
      status16,
      status17,
      status18
    ];

    for (let i = 0; i < facilities.length; i++) {
      const [
        idfacility
      ] = await connection.query(
        `SELECT id_facility FROM facility WHERE name=?`,
        [facilities[i]]
      );

      await connection.query(
        `INSERT INTO facility_room(id_room, id_facility, status) 
      VALUES(?,?,?)`,
        [roomid[0].id_room, idfacility[0].id_facility, status[i]]
      );
    }

    response.send({
      status: 'ok',
      message: `Características de la habitación con id ${roomid[0].id_room} actualizado correctamente`
    });
  } catch (error) {
    next(error);
  } finally {
    if (connection) {
      connection.release();
    }
  }
}

module.exports = { editRoomFacilities };
