require('dotenv').config();
const chalk = require('chalk');

const { getConnection } = require('../../db/db.js');
const { generateError } = require('../../helpers/helpers.js');

const {
  editRoomFacilitiesSchema
} = require('../../validations/roomValidation');

async function editRoomFacilities(request, response, next) {
  let connection;
  try {
    await editRoomFacilitiesSchema.validateAsync(request.body);
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
    ] = await connection.query(`SELECT id_user FROM room WHERE id_room=?`, [
      id
    ]);

    if (!current.length) {
      throw generateError(
        `La habitación con id ${id} no existe en la BBDD`,
        404
      );
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

    await connection.query(
      `
      DELETE FROM facility_room WHERE id_room=?
      `,
      [id]
    );

    const [
      idfacility1
    ] = await connection.query(
      `SELECT id_facility FROM facility WHERE name=?`,
      [facility1]
    );

    await connection.query(
      `INSERT INTO facility_user(id_user, id_facility, status) 
      VALUES(?,?,?)`,
      [id, idfacility1[0].id_facility, status1]
    );

    const [
      idfacility2
    ] = await connection.query(
      `SELECT id_facility FROM facility WHERE name=?`,
      [facility2]
    );

    await connection.query(
      `INSERT INTO facility_user(id_user, id_facility, status) 
      VALUES(?,?,?)`,
      [id, idfacility2[0].id_facility, status2]
    );

    const [
      idfacility3
    ] = await connection.query(
      `SELECT id_facility FROM facility WHERE name=?`,
      [facility3]
    );

    await connection.query(
      `INSERT INTO facility_user(id_user, id_facility, status) 
      VALUES(?,?,?)`,
      [id, idfacility3[0].id_facility, status3]
    );

    const [
      idfacility4
    ] = await connection.query(
      `SELECT id_facility FROM facility WHERE name=?`,
      [facility4]
    );

    await connection.query(
      `INSERT INTO facility_user(id_user, id_facility, status) 
      VALUES(?,?,?)`,
      [id, idfacility4[0].id_facility, status4]
    );

    const [
      idfacility5
    ] = await connection.query(
      `SELECT id_facility FROM facility WHERE name=?`,
      [facility5]
    );

    await connection.query(
      `INSERT INTO facility_user(id_user, id_facility, status) 
      VALUES(?,?,?)`,
      [id, idfacility5[0].id_facility, status5]
    );

    const [
      idfacility6
    ] = await connection.query(
      `SELECT id_facility FROM facility WHERE name=?`,
      [facility6]
    );

    await connection.query(
      `INSERT INTO facility_user(id_user, id_facility, status) 
      VALUES(?,?,?)`,
      [id, idfacility6[0].id_facility, status6]
    );

    const [
      idfacility7
    ] = await connection.query(
      `SELECT id_facility FROM facility WHERE name=?`,
      [facility7]
    );

    await connection.query(
      `INSERT INTO facility_user(id_user, id_facility, status) 
      VALUES(?,?,?)`,
      [id, idfacility7[0].id_facility, status7]
    );

    const [
      idfacility8
    ] = await connection.query(
      `SELECT id_facility FROM facility WHERE name=?`,
      [facility8]
    );

    await connection.query(
      `INSERT INTO facility_user(id_user, id_facility, status) 
      VALUES(?,?,?)`,
      [id, idfacility8[0].id_facility, status8]
    );

    const [
      idfacility9
    ] = await connection.query(
      `SELECT id_facility FROM facility WHERE name=?`,
      [facility9]
    );

    await connection.query(
      `INSERT INTO facility_user(id_user, id_facility, status) 
      VALUES(?,?,?)`,
      [id, idfacility9[0].id_facility, status9]
    );

    const [
      idfacility10
    ] = await connection.query(
      `SELECT id_facility FROM facility WHERE name=?`,
      [facility10]
    );

    await connection.query(
      `INSERT INTO facility_user(id_user, id_facility, status) 
      VALUES(?,?,?)`,
      [id, idfacility10[0].id_facility, status10]
    );

    const [
      idfacility11
    ] = await connection.query(
      `SELECT id_facility FROM facility WHERE name=?`,
      [facility11]
    );

    await connection.query(
      `INSERT INTO facility_user(id_user, id_facility, status) 
      VALUES(?,?,?)`,
      [id, idfacility11[0].id_facility, status11]
    );

    const [
      idfacility12
    ] = await connection.query(
      `SELECT id_facility FROM facility WHERE name=?`,
      [facility12]
    );

    await connection.query(
      `INSERT INTO facility_user(id_user, id_facility, status) 
      VALUES(?,?,?)`,
      [id, idfacility12[0].id_facility, status12]
    );

    const [
      idfacility13
    ] = await connection.query(
      `SELECT id_facility FROM facility WHERE name=?`,
      [facility13]
    );

    await connection.query(
      `INSERT INTO facility_user(id_user, id_facility, status) 
      VALUES(?,?,?)`,
      [id, idfacility13[0].id_facility, status13]
    );

    const [
      idfacility14
    ] = await connection.query(
      `SELECT id_facility FROM facility WHERE name=?`,
      [facility14]
    );

    await connection.query(
      `INSERT INTO facility_user(id_user, id_facility, status) 
      VALUES(?,?,?)`,
      [id, idfacility14[0].id_facility, status14]
    );

    const [
      idfacility15
    ] = await connection.query(
      `SELECT id_facility FROM facility WHERE name=?`,
      [facility15]
    );

    await connection.query(
      `INSERT INTO facility_user(id_user, id_facility, status) 
      VALUES(?,?,?)`,
      [id, idfacility15[0].id_facility, status15]
    );

    const [
      idfacility16
    ] = await connection.query(
      `SELECT id_facility FROM facility WHERE name=?`,
      [facility16]
    );

    await connection.query(
      `INSERT INTO facility_user(id_user, id_facility, status) 
      VALUES(?,?,?)`,
      [id, idfacility16[0].id_facility, status16]
    );

    const [
      idfacility17
    ] = await connection.query(
      `SELECT id_facility FROM facility WHERE name=?`,
      [facility17]
    );

    await connection.query(
      `INSERT INTO facility_user(id_user, id_facility, status) 
      VALUES(?,?,?)`,
      [id, idfacility17[0].id_facility, status17]
    );

    const [
      idfacility18
    ] = await connection.query(
      `SELECT id_facility FROM facility WHERE name=?`,
      [facility18]
    );

    await connection.query(
      `INSERT INTO facility_user(id_user, id_facility, status) 
      VALUES(?,?,?)`,
      [id, idfacility18[0].id_facility, status18]
    );

    response.send({
      status: 'ok',
      message: `Características de la habitación con id ${id} actualizado correctamente`
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
