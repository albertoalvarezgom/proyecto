require('dotenv').config();
// const chalk = require('chalk');

const { getConnection } = require('../../db/db.js');
const { generateError } = require('../../helpers/helpers.js');

// const {
//   editUserPersonalitySchema
// } = require('../../validations/userValidation');

async function editUserPersonality(request, response, next) {
  let connection;
  try {
    // await editUserPersonalitySchema.validateAsync(request.body);
    const { id } = request.params;
    const {
      personality1,
      personality2,
      personality3,
      personality4,
      personality5
    } = request.body;

    connection = await getConnection();

    const [
      current
    ] = await connection.query('select id_user from user where id_user=?', [
      id
    ]);

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

    const idPersonalitiesList = [];
    const [idPersonalities] = await connection.query(
      `SELECT id_personality FROM personality`
    );
    for (let i = 0; i < idPersonalities.length; i++) {
      idPersonalitiesList.push(idPersonalities[i].id_personality);
    }

    await connection.query(
      `
      DELETE FROM personality_user WHERE id_user=?
      `,
      [id]
    );

    const [
      idPersonality1
    ] = await connection.query(
      `SELECT id_personality FROM personality WHERE name=?`,
      [personality1]
    );

    await connection.query(
      `INSERT INTO personality_user(id_user, id_personality, status) 
      VALUES(?,?,1)`,
      [id, idPersonality1[0].id_personality]
    );
    idPersonalitiesList.splice(
      idPersonalitiesList.indexOf(idPersonality1[0].id_personality),
      1
    );

    const [
      idPersonality2
    ] = await connection.query(
      `SELECT id_personality FROM personality WHERE name=?`,
      [personality2]
    );

    await connection.query(
      `INSERT INTO personality_user(id_user, id_personality, status) 
      VALUES(?,?,1)`,
      [id, idPersonality2[0].id_personality]
    );
    idPersonalitiesList.splice(
      idPersonalitiesList.indexOf(idPersonality2[0].id_personality),
      1
    );

    const [
      idPersonality3
    ] = await connection.query(
      `SELECT id_personality FROM personality WHERE name=?`,
      [personality3]
    );

    await connection.query(
      `INSERT INTO personality_user(id_user, id_personality,status) 
      VALUES(?,?,1)`,
      [id, idPersonality3[0].id_personality]
    );
    idPersonalitiesList.splice(
      idPersonalitiesList.indexOf(idPersonality3[0].id_personality),
      1
    );

    const [
      idPersonality4
    ] = await connection.query(
      `SELECT id_personality FROM personality WHERE name=?`,
      [personality4]
    );

    await connection.query(
      `INSERT INTO personality_user(id_user, id_personality, status) 
      VALUES(?,?,1)`,
      [id, idPersonality4[0].id_personality]
    );
    idPersonalitiesList.splice(
      idPersonalitiesList.indexOf(idPersonality4[0].id_personality),
      1
    );

    const [
      idPersonality5
    ] = await connection.query(
      `SELECT id_personality FROM personality WHERE name=?`,
      [personality5]
    );

    await connection.query(
      `INSERT INTO personality_user(id_user, id_personality, status) 
      VALUES(?,?,1)`,
      [id, idPersonality5[0].id_personality]
    );
    idPersonalitiesList.splice(
      idPersonalitiesList.indexOf(idPersonality5[0].id_personality),
      1
    );

    for (let i = 0; i < idPersonalitiesList.length; i++) {
      await connection.query(
        `INSERT INTO personality_user(id_user, id_personality, status)
      VALUES(?,?,0)`,
        [id, idPersonalitiesList[i]]
      );
    }

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

module.exports = { editUserPersonality };
