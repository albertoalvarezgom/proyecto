require('dotenv').config();

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
      email,
      occupationField,
      occupationStatus
    } = request.body;

    connection = await getConnection();

    const [
      current
    ] = await connection.query(
      'select id_user, image_1, image_2, image_3, image_4, image_5 from user where id_user=?',
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

    const newImages = [
      request.files.image_1,
      request.files.image_2,
      request.files.image_3,
      request.files.image_4,
      request.files.image_5
    ];

    const imagestoDB = [];

    if (request.files) {
      let savedFileName;

      for (let i = 0; i < newImages.length; i++) {
        savedFileName = await processAndSavePhoto(newImages[i]);

        if (currentImages[i]) {
          await deletePhoto(currentImages[i]);
        }

        imagestoDB.push(savedFileName);
      }
    }

    await connection.query(
      'update user set first_name=?, birthday=?, email=?, occupation_field=?, occupation_status=?, image_1=?, image_2=?, image_3=?, image_4=?, image_5=? where id_user=?',
      [
        name,
        birthday,
        email,
        occupationField,
        occupationStatus,
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
