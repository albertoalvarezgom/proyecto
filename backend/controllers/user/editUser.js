require('dotenv').config();
// const chalk = require('chalk');

const { getConnection } = require('../../db/db.js');
const {
  generateError,
  processAndSavePhoto,
  deletePhoto
} = require('../../helpers/helpers.js');

const { editUserSchema } = require('../../validations/userValidation');

async function editUser(request, response, next) {
  let connection;
  try {
    await editUserSchema.validateAsync(request.body);
    const { id } = request.params;
    const {
      name,
      birthday,
      userCity,
      email,
      phone,
      occupationField,
      occupationStatus,
      couple,
      gender,
      ig_profile,
      type
    } = request.body;

    connection = await getConnection();

    const [
      current
    ] = await connection.query(
      'select id_user, email, image_1, image_2, image_3, image_4, image_5 from user where id_user=?',
      [id]
    );

    if (!current.length) {
      throw generateError(`El usuario con id ${id} no existe en la BBDD`, 404);
    }

    if (
      current[0].id_user !== request.auth.id &&
      request.auth.role !== 'admin'
    ) {
      throw generateError(
        'No tienes permiso para editar este perfil de usuario',
        401
      );
    }

    const [user] = current;

    const currentImages = [
      user.image_1,
      user.image_2,
      user.image_3,
      user.image_4,
      user.image_5
    ];

    const checkCurrentImages = [];

    for (const image of currentImages) {
      if (image) {
        checkCurrentImages.push(image);
      }
    }

    let imagestoDB = [];

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
    } else {
      imagestoDB = checkCurrentImages;
    }

    let formatCouple;
    if (couple === 'No') {
      formatCouple = 0;
    } else {
      formatCouple = 1;
    }

    await connection.query(
      `UPDATE user SET first_name=?, birthday=?, city=?, email=?, occupation_field=?, occupation_status=?, couple=?,
      image_1=?, image_2=?, image_3=?, image_4=?, image_5=?, gender=?, type=?, ig_profile=?, phone=? WHERE id_user=?`,
      [
        name,
        birthday,
        userCity,
        email,
        occupationField,
        occupationStatus,
        formatCouple,
        imagestoDB[0],
        imagestoDB[1],
        imagestoDB[2],
        imagestoDB[3],
        imagestoDB[4],
        gender,
        type,
        ig_profile,
        phone,
        id
      ]
    );
    response.send({
      status: 'ok',
      message: `Usuario con id ${id} actualizado correctamente`
    });
  } catch (error) {
    next(error);
  } finally {
    if (connection) {
      connection.release();
    }
  }
}

module.exports = { editUser };
