require('dotenv').config();
const chalk = require('chalk');

const { getConnection } = require('../../db/db.js');

const {
  generateError,
  processAndSavePhoto,
  deletePhoto
} = require('../../helpers/helpers.js');

// const { newRoomSchema } = require('../../validations/roomValidation');

async function editRoom(request, response, next) {
  let connection;
  try {
    // await editRoomSchema.validateAsync(request.body);
    const { id } = request.params;

    const {
      title,
      description,
      address,
      postalCode,
      city,
      flatmatesMasc,
      flatmatesFem,
      flatSize,
      preferenceGender,
      status,
      minAge,
      maxAge,
      roomType,
      roomSize,
      bedType,
      price,
      billsIncluded,
      deposit,
      depositAmmount,
      availabilityFrom,
      availabilityUntil,
      minStay,
      maxStay
    } = request.body;

    connection = await getConnection();

    const [
      room
    ] = await connection.query(
      'select id_user, id_room, image_1, image_2, image_3, image_4, image_5 from room where id_room=?',
      [id]
    );

    if (!room.length) {
      throw generateError(
        `La habitación con id ${id} no existe en la BBDD`,
        404
      );
    }

    if (room[0].id_user !== request.auth.id && request.auth.role !== 'admin') {
      throw generateError('No tienes permiso para editar esta habitación', 401);
    }

    const currentImages = [
      room[0].image_1,
      room[0].image_2,
      room[0].image_3,
      room[0].image_4,
      room[0].image_5
    ];

    const checkCurrentImages = [];

    for (const image of currentImages) {
      if (image) {
        checkCurrentImages.push(image);
      }
    }

    const newImages = [
      request.files.image_1,
      request.files.image_2,
      request.files.image_3,
      request.files.image_4,
      request.files.image_5
    ];

    const checkNewImages = [];

    for (const image of newImages) {
      if (image) {
        checkNewImages.push(image);
      }
    }

    const imagestoDB = [];

    if (request.files) {
      let savedFileName;

      for (let i = 0; i < checkNewImages.length; i++) {
        savedFileName = await processAndSavePhoto(checkNewImages[i]);

        if (currentImages[i]) {
          await deletePhoto(checkCurrentImages[i]);

          imagestoDB.push(savedFileName);
        }
      }
    }

    await connection.query(
      `update room set title=?, description=?, address=?, postal_code=?, city=?, flatmates_masc=?, flatmates_fem=?, flat_size=?, preference_gender=?, status=?, min_age=?, max_age=?,
      room_type=?, room_size=?, bed_type=?, price=?, bills_included=?, deposit=?, deposit_ammount=?, availability_from=?, availability_until=?, min_stay=?, max_stay=?,
      image_1=?, image_2=?, image_3=?, image_4=?, image_5=? where id_room=?`,
      [
        title,
        description,
        address,
        postalCode,
        city,
        flatmatesMasc,
        flatmatesFem,
        flatSize,
        preferenceGender,
        status,
        minAge,
        maxAge,
        roomType,
        roomSize,
        bedType,
        price,
        billsIncluded,
        deposit,
        depositAmmount,
        availabilityFrom,
        availabilityUntil,
        minStay,
        maxStay,
        imagestoDB[0],
        imagestoDB[1],
        imagestoDB[2],
        imagestoDB[3],
        imagestoDB[4],
        id
      ]
    );
    response.send({
      status: 'ok',
      message: `Habitación con id ${id} actualizada correctamente`
    });
  } catch (error) {
    next(error);
  } finally {
    if (connection) {
      connection.release();
    }
  }
}

module.exports = { editRoom };
