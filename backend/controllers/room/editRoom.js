require('dotenv').config();
const chalk = require('chalk');

const { getConnection } = require('../../db/db.js');

const {
  generateError,
  processAndSavePhoto,
  deletePhoto
} = require('../../helpers/helpers.js');

const { editRoomSchema } = require('../../validations/roomValidation');

async function editRoom(request, response, next) {
  let connection;
  try {
    await editRoomSchema.validateAsync(request.body);
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
      idRoom
    ] = await connection.query(`SELECT id_room FROM room WHERE id_user =?`, [
      id
    ]);

    const idroom = idRoom[0].id_room;

    const [
      room
    ] = await connection.query(
      `SELECT image_1, image_2, image_3, image_4, image_5 FROM room WHERE id_room=?`,
      [idroom]
    );

    if (!room.length) {
      throw generateError(
        `La habitación con id ${idroom} no existe en la BBDD`,
        404
      );
    }

    if (Number(id) !== request.auth.id && request.auth.role !== 'admin') {
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

    const imagestoDB = [];

    if (request.files) {
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

      let savedFileName;

      for (let i = 0; i < checkNewImages.length; i++) {
        savedFileName = await processAndSavePhoto(checkNewImages[i]);

        if (currentImages[i]) {
          await deletePhoto(checkCurrentImages[i]);
        }
        imagestoDB.push(savedFileName);
      }
    }

    let formatBills;
    if (billsIncluded === 'false') {
      formatBills = 0;
    } else {
      formatBills = 1;
    }

    let formatDeposit;
    if (deposit === 'false') {
      formatDeposit = 0;
    } else {
      formatDeposit = 1;
    }

    let formatAmmount;
    if (!depositAmmount) {
      formatAmmount === null;
    } else {
      formatAmmount = depositAmmount;
    }

    await connection.query(
      `UPDATE room SET title=?, description=?, address=?, postal_code=?, city=?, flatmates_masc=?, flatmates_fem=?, 
      flat_size=?, preference_gender=?, status=?, min_age=?, max_age=?, room_type=?, room_size=?, bed_type=?, 
      price=?, bills_included=?, deposit=?, deposit_ammount=?, availability_from=?, availability_until=?, min_stay=?, max_stay=?,
      image_1=?, image_2=?, image_3=?, image_4=?, image_5=? WHERE id_room=?`,
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
        formatBills,
        formatDeposit,
        formatAmmount,
        availabilityFrom,
        availabilityUntil,
        minStay,
        maxStay,
        imagestoDB[0],
        imagestoDB[1],
        imagestoDB[2],
        imagestoDB[3],
        imagestoDB[4],
        idroom
      ]
    );
    response.send({
      status: 'ok',
      message: `Habitación con id ${idroom} actualizada correctamente`
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
