require('dotenv').config();
const chalk = require('chalk');

const { getConnection } = require('../../db/db.js');

const {
  generateError,
  processAndSavePhoto
} = require('../../helpers/helpers.js');

// const { newRoomSchema } = require('../../validations/roomValidation');

async function newRoom(request, response, next) {
  let connection;
  try {
    // await newRoomSchema.validateAsync(request.body);
    connection = await getConnection();

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

    const [
      dbRoom
    ] = await connection.query(
      `SELECT title, id_user FROM room WHERE room.id_user = ?`,
      [request.auth.id]
    );
    if (dbRoom.length) {
      if (dbRoom[0].title === title && request.auth.id === dbRoom[0].id_user) {
        throw generateError(
          `Ya existe una habitación publicada con tu id con el título ${title}`,
          401
        );
      }
    }

    ////

    let room;

    if (request.files) {
      const newImages = [
        request.files.image_1,
        request.files.image_2,
        request.files.image_3,
        request.files.image_4,
        request.files.image_5
      ];

      const checkImages = [];

      for (const image of newImages) {
        if (image) {
          checkImages.push(image);
        }
      }

      const imagestoDB = [];

      let savedFileName;

      for (let i = 0; i < checkImages.length; i++) {
        savedFileName = await processAndSavePhoto(checkImages[i]);

        imagestoDB.push(savedFileName);
      }

      [room] = await connection.query(
        `
      INSERT INTO room (id_user, title, description, address, postal_code, city, flatmates_masc, flatmates_fem, flat_size, preference_gender, status, min_age, max_age, 
        room_type, room_size, bed_type, price, bills_included, deposit, deposit_ammount, availability_from, availability_until, min_stay, max_stay, image_1, image_2, image_3, image_4, image_5)
        VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)
        `,

        [
          request.auth.id,
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
          imagestoDB[4]
        ]
      );
    }
    ////
    // let room;

    // if (request.files) {
    //   const newImages = [
    //     request.files.image_1,
    //     request.files.image_2,
    //     request.files.image_3,
    //     request.files.image_4,
    //     request.files.image_5
    //   ];

    //   const imagestoDB = [];

    //   if (request.files) {
    //     let savedFileName;

    //     for (let i = 0; i < newImages.length; i++) {
    //       savedFileName = await processAndSavePhoto(newImages[i]);

    //       imagestoDB.push(savedFileName);
    //     }
    //   }
    //   [room] = await connection.query(
    //     `
    //   INSERT INTO room (id_user, title, description, address, postal_code, city, flatmates_masc, flatmates_fem, flat_size, preference_gender, status, min_age, max_age,
    //     room_type, room_size, bed_type, price, bills_included, deposit, deposit_ammount, availability_from, availability_until, min_stay, max_stay, image_1, image_2, image_3, image_4, image_5)
    //     VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)
    //     `,

    //     [
    //       request.auth.id,
    //       title,
    //       description,
    //       address,
    //       postalCode,
    //       city,
    //       flatmatesMasc,
    //       flatmatesFem,
    //       flatSize,
    //       preferenceGender,
    //       status,
    //       minAge,
    //       maxAge,
    //       roomType,
    //       roomSize,
    //       bedType,
    //       price,
    //       billsIncluded,
    //       deposit,
    //       depositAmmount,
    //       availabilityFrom,
    //       availabilityUntil,
    //       minStay,
    //       maxStay,
    //       imagestoDB[0],
    //       imagestoDB[1],
    //       imagestoDB[2],
    //       imagestoDB[3],
    //       imagestoDB[4]
    //     ]
    //   );
    // }
    else {
      [room] = await connection.query(
        `
      INSERT INTO room (id_user, title, description, address, postal_code, city, flatmates_masc, flatmates_fem, flat_size, preference_gender, status, min_age, max_age, 
        room_type, room_size, bed_type, price, bills_included, deposit, deposit_ammount, availability_from, availability_until, min_stay, max_stay)
        VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)
        `,
        [
          request.auth.id,
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
        ]
      );
    }

    //Marcamos al usuario que publicó una habitación como propietario
    await connection.query(`UPDATE user set type='owner' WHERE id_user=?`, [
      request.auth.id
    ]);

    response.send({
      status: 'ok',
      message: 'La habitación fue creada correctamente.',
      data: { title: title, description: description }
    });
  } catch (error) {
    next(error);
  } finally {
    if (connection) {
      connection.release();
    }
  }
}

module.exports = { newRoom };
