require('dotenv').config();
// const chalk = require('chalk');

const { getConnection } = require('../../db/db.js');
// const { generateError } = require('../../helpers/helpers.js');

const {
  editRoomFacilitiesSchema
} = require('../../validations/roomValidation');

async function getRoomFacilities(request, response, next) {
  let connection;
  try {
    await editRoomFacilitiesSchema.validateAsync(request.body);
    const { id } = request.params;

    connection = await getConnection();

    const [facilities] = await connection.query(
      `
    SELECT facility.name, facility_room.status 
    FROM room
    JOIN facility_room ON room.id_room=facility_room.id_room
    JOIN facility ON facility.id_facility=facility_room.id_facility
    WHERE room.id_user=?
    `,
      [id]
    );

    response.send({
      status: 'ok',
      facilities: facilities
    });
  } catch (error) {
    next(error);
  } finally {
    if (connection) {
      connection.release();
    }
  }
}

module.exports = { getRoomFacilities };
