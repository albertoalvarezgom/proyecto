require('dotenv').config();
const jwt = require('jsonwebtoken');
const chalk = require('chalk');

const { generateError } = require('../helpers/helpers.js');
const { getConnection } = require('../db/db.js');

async function userAuthenticated(request, response, next) {
  let connection;

  try {
    const { authorization } = request.headers;

    if (!authorization) {
      throw generateError(
        'La cabecera de autorización es necesaria para realizar esta acción',
        400
      );
    }

    const authorizationParts = authorization.split(' ');

    let token;

    if (authorizationParts.length === 1) {
      token = authorization;
    } else if (authorizationParts[0] === 'Bearer') {
      token = authorizationParts[1];
    } else {
      throw generateError('Algo falló en la lectura del token', 400);
    }

    let decoded;

    try {
      decoded = jwt.verify(authorization, process.env.SECRET);
    } catch (error) {
      throw generateError('Hay un problema con la forma del token', 400);
    }

    //Comprobar la fecha de creación del token (iat)

    const { id, iat } = decoded;

    connection = await getConnection();

    const [
      result
    ] = await connection.query(
      'select role, last_password_update from user where id_user=?',
      [id]
    );

    if (!result.length) {
      throw generateError(`El usuario con id ${id} no existe en la BBDD`, 404);
    }

    const [user] = result;

    //Comprobar que la fecha de última actualización de la contraseña es menor que la de creación del token

    if (new Date(iat * 1000) < new Date(user.last_password_update)) {
      throw generateError(
        'Has cambiado de contraseña. Haz login de nuevo',
        400
      );
    }

    request.auth = decoded;
    next();
  } catch (error) {
    const authError = new Error('El token de autenticación no es válido');
    authError.httpCode = 401;
    next(authError);
  }
}

function userIsAdmin(request, response, next) {
  // Check if the user is admin in req.auth (see before) and send error if not

  if (!request.auth && request.auth.role !== 'admin') {
    const error = new Error(
      'Acción reservda a usuarios con privilegios de administrador'
    );
    error.httpCode = 401;
    return next(error);
  }

  next();
}

module.exports = {
  userAuthenticated,
  userIsAdmin
};
