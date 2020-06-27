require('dotenv').config();
const chalk = require('chalk');

const { getConnection } = require('../../db/db.js');
const { generateError } = require('../../helpers/helpers.js');

const { editUserHobbySchema } = require('../../validations/userValidation');

async function editUserHobby(request, response, next) {
  let connection;
  try {
    // await editUserHobbySchema.validateAsync(request.body);
    const { id } = request.params;
    const {
      hobby1,
      description1,
      hobby2,
      description2,
      hobby3,
      description3,
      hobby4,
      description4,
      hobby5,
      description5
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

    const idHobbiesList = [];
    const [idHobbies] = await connection.query(`SELECT id_hobby FROM hobby`);
    for (let i = 0; i < idHobbies.length; i++) {
      idHobbiesList.push(idHobbies[i].id_hobby);
    }

    await connection.query(
      `
      DELETE FROM hobby_user WHERE id_user=?
      `,
      [id]
    );

    const [
      idHobby1
    ] = await connection.query(`SELECT id_hobby FROM hobby WHERE name=?`, [
      hobby1
    ]);

    await connection.query(
      `INSERT INTO hobby_user(id_user, id_hobby,status, description) 
      VALUES(?,?,1,?)`,
      [id, idHobby1[0].id_hobby, description1]
    );
    idHobbiesList.splice(idHobbiesList.indexOf(idHobby1[0].id_hobby), 1);

    const [
      idHobby2
    ] = await connection.query(`SELECT id_hobby FROM hobby WHERE name=?`, [
      hobby2
    ]);

    await connection.query(
      `INSERT INTO hobby_user(id_user, id_hobby, status,description) 
      VALUES(?,?,1,?)`,
      [id, idHobby2[0].id_hobby, description2]
    );
    idHobbiesList.splice(idHobbiesList.indexOf(idHobby2[0].id_hobby), 1);

    const [
      idHobby3
    ] = await connection.query(`SELECT id_hobby FROM hobby WHERE name=?`, [
      hobby3
    ]);

    await connection.query(
      `INSERT INTO hobby_user(id_user, id_hobby, status,description) 
      VALUES(?,?,1,?)`,
      [id, idHobby3[0].id_hobby, description3]
    );
    idHobbiesList.splice(idHobbiesList.indexOf(idHobby3[0].id_hobby), 1);

    const [
      idHobby4
    ] = await connection.query(`SELECT id_hobby FROM hobby WHERE name=?`, [
      hobby4
    ]);

    await connection.query(
      `INSERT INTO hobby_user(id_user, id_hobby, status,description) 
      VALUES(?,?,1,?)`,
      [id, idHobby4[0].id_hobby, description4]
    );
    idHobbiesList.splice(idHobbiesList.indexOf(idHobby4[0].id_hobby), 1);

    const [
      idHobby5
    ] = await connection.query(`SELECT id_hobby FROM hobby WHERE name=?`, [
      hobby5
    ]);

    await connection.query(
      `INSERT INTO hobby_user(id_user, id_hobby,status, description) 
      VALUES(?,?,1,?)`,
      [id, idHobby5[0].id_hobby, description5]
    );
    idHobbiesList.splice(idHobbiesList.indexOf(idHobby5[0].id_hobby), 1);

    for (let i = 0; i < idHobbiesList.length; i++) {
      await connection.query(
        `INSERT INTO hobby_user(id_user, id_hobby, status)
      VALUES(?,?,0)`,
        [id, idHobbiesList[i]]
      );
    }

    response.send({
      status: 'ok',
      message: `Las aficiones del usuario con id ${id} han sido actualizadas correctamente`
    });
  } catch (error) {
    next(error);
  } finally {
    if (connection) {
      connection.release();
    }
  }
}

module.exports = { editUserHobby };
