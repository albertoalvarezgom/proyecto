require('dotenv').config();

const chalk = require('chalk');
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

    let savedFileName1;

    if (request.files && request.files.image_1) {
      try {
        savedFileName1 = await processAndSavePhoto(request.files.image_1);

        if (current[0].image_1) {
          await deletePhoto(current[0].image_1);
        }
      } catch (error) {
        throw generateError('Error procesando imagen subida', 400);
      }
    } else {
      savedFileName1 = current.image_1;
    }

    let savedFileName2;

    if (request.files && request.files.image_2) {
      try {
        savedFileName2 = await processAndSavePhoto(request.files.image_2);

        if (current && current[0].image_2) {
          await deletePhoto(current[0].image_2);
        }
      } catch (error) {
        throw generateError('Error procesando imagen subida', 400);
      }
    } else {
      savedFileName2 = current.image_2;
    }

    let savedFileName3;

    if (request.files && request.files.image_3) {
      try {
        savedFileName3 = await processAndSavePhoto(request.files.image_3);

        if (current && current[0].image_3) {
          await deletePhoto(current[0].image_3);
        }
      } catch (error) {
        throw generateError('Error procesando imagen subida', 400);
      }
    } else {
      savedFileName3 = current.image_3;
    }

    let savedFileName4;

    if (request.files && request.files.image_4) {
      try {
        savedFileName4 = await processAndSavePhoto(request.files.image_4);

        if (current && current[0].image_4) {
          await deletePhoto(current[0].image_4);
        }
      } catch (error) {
        throw generateError('Error procesando imagen subida', 400);
      }
    } else {
      savedFileName4 = current.image_4;
    }

    let savedFileName5;

    if (request.files && request.files.image_5) {
      try {
        savedFileName5 = await processAndSavePhoto(request.files.image_5);

        if (current && current[0].image_5) {
          await deletePhoto(current[0].image_5);
        }
      } catch (error) {
        throw generateError('Error procesando imagen subida', 400);
      }
    } else {
      savedFileName5 = current.image_5;
    }

    await connection.query(
      'update user set first_name=?, birthday=?, email=?, occupation_field=?, occupation_status=?, image_1=?, image_2=?, image_3=?, image_4=?, image_5=? where id_user=?',
      [
        name,
        birthday,
        email,
        occupationField,
        occupationStatus,
        savedFileName1,
        savedFileName2,
        savedFileName3,
        savedFileName4,
        savedFileName5,
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
