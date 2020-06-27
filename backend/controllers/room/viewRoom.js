require('dotenv').config();
const chalk = require('chalk');

const { getConnection } = require('../../db/db.js');
const { generateError } = require('../../helpers/helpers.js');

async function viewRoom(request, response, next) {
  let connection;
  try {
    const { iduser, idroom } = request.params;

    connection = await getConnection();

    const [
      hiddenUser
    ] = await connection.query(
      `SELECT id_user FROM user WHERE hidden=1 AND id_user=?`,
      [request.auth.id]
    );

    if (hiddenUser.length) {
      throw generateError(
        'Un usuario oculto no puede realizar búsqedas. Haz tu cuenta visible e inténtalo de nuevo',
        401
      );
    }

    const [room] = await connection.query(
      `SELECT * FROM room WHERE id_room=?`,
      [idroom]
    );

    if (!room.length) {
      throw generateError(
        `La habitación con id ${idroom} no existe en la BBDD`,
        404
      );
    }

    if (room[0].hidden === 1) {
      throw generateError(
        `No se puede mostrar la habitación con id ${idroom}. Ahora mismo esta entrada está oculta`,
        404
      );
    }

    const [
      roomUser
    ] = await connection.query(
      `SELECT id_room FROM room WHERE id_room=? AND id_user=?`,
      [idroom, iduser]
    );

    if (!roomUser.length) {
      throw generateError(
        `La habitación con id ${idroom} no se corresponde con el usuario con id ${iduser}`,
        400
      );
    }

    const [
      facility
    ] = await connection.query(
      `SELECT facility.name FROM facility_room JOIN facility ON facility_room.id_facility=facility.id_facility WHERE id_room=?`,
      [idroom]
    );

    const [
      rule
    ] = await connection.query(
      `SELECT rule.name FROM rule JOIN rule_room ON rule.id_rule = rule_room.id_rule WHERE rule_room.id_room =?`,
      [idroom]
    );

    await connection.query('UPDATE room SET views=? WHERE id_room=?', [
      room[0].views + 1,
      idroom
    ]);

    response.send({
      status: 'ok',
      data: { room: room[0], facility: facility, rule: rule }
    });
  } catch (error) {
    next(error);
  } finally {
    if (connection) {
      connection.release();
    }
  }
}

module.exports = { viewRoom };
