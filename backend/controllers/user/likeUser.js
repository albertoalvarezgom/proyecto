require('dotenv').config();
// const chalk = require('chalk');

const { getConnection } = require('../../db/db.js');
const { generateError } = require('../../helpers/helpers.js');

async function likeUser(request, response, next) {
  let connection;
  try {
    const { id } = request.params;

    connection = await getConnection();

    //Comprobamos que el usuario exsite en la BBDD
    const [
      checkUser
    ] = await connection.query(
      `SELECT id_user, hidden FROM user WHERE id_user=?`,
      [request.auth.id]
    );

    if (!checkUser.length) {
      throw generateError(
        `El usuario con id ${id} no existe en en la BBDD`,
        404
      );
    }

    //Comprobamos que el usuario que le da a Me gusta está visible. Si no, lanzamos error
    if (checkUser[0].hidden === true) {
      throw generateError(
        'Un usuario oculto no puede ver pefiles de ususarios. Haz tu cuenta visible e inténtalo de nuevo',
        401
      );
    }

    //Comprobamos que un usuario no se de a Me gusta a sí mismo
    if (Number(id) === request.auth.id) {
      throw generateError(
        'Un usuario no puede realizar esta acción sobre sí mismo',
        401
      );
    }

    // const [
    //   likedUser
    // ] = await connection.query(
    //   `SELECT id_like FROM user_liked WHERE id_user_sends=? AND id_user_gets=?`,
    //   [request.auth.id, id]
    // );

    // if (!likedUser) {
    //   await connection.query(
    //     `
    // INSERT INTO user_liked(id_user_sends, id_user_gets) VALUES(?,?)`,
    //     [request.auth.id, id]
    //   );
    // }

    //Comprobamos que no exista un match activo entre estos dos usuarios
    const [
      existingMatchA
    ] = await connection.query(
      `SELECT id_match FROM user_match WHERE id_user1=? AND id_user2=? AND status='match'`,
      [request.auth.id, id]
    );

    if (existingMatchA.length) {
      throw generateError(
        `Ya existe un match entre los usuarios con id ${request.auth.id} y ${id}`
      );
    }

    const [
      existingMatchB
    ] = await connection.query(
      `SELECT id_match FROM user_match WHERE id_user1=? AND id_user2=? AND status='match'`,
      [id, request.auth.id]
    );

    if (existingMatchB.length) {
      throw generateError(
        `Ya existe un match entre los usuarios con id ${request.auth.id} y ${id}`
      );
    }

    //Comprobamos si la acción de darle Me gusta a este usuario ya se realizó anteriormente
    const [
      existingLike
    ] = await connection.query(
      `SELECT id_match FROM user_match WHERE id_user1=? AND id_user2=? AND status='enviado'`,
      [request.auth.id, id]
    );

    if (existingLike.length) {
      throw generateError(
        `El usuario con id ${id} ya ha sido valorado con 'Me gusta'`,
        401
      );
    }

    //Comprobamos si había un Me gusta en la dirección inversa
    const [
      checkMatch
    ] = await connection.query(
      `SELECT id_match FROM user_match WHERE id_user1=? AND id_user2=? AND status='enviado'`,
      [id, request.auth.id]
    );

    let message;

    //Si lo había, hay match y se abre el chat entre los dos usuarios
    if (checkMatch.length) {
      await connection.query(`UPDATE user_match SET status='match'`);
      message = `¡Enhorabuena! Se ha abierto una sala de chat con el usuario con id ${id}`;
    }
    //Si no, creamos uno
    else {
      await connection.query(
        `INSERT into user_match (id_user1, id_user2, status) VALUES (?,?, 'enviado')`,
        [request.auth.id, id]
      );
      message = `'Me gusta' enviado al usuario con id ${id}`;
    }

    response.send({
      status: 'ok',
      message: message
    });
  } catch (error) {
    next(error);
  } finally {
    if (connection) {
      connection.release();
    }
  }
}

module.exports = { likeUser };
