const joi = require('@hapi/joi').extend(require('@hapi/joi-date'));
const { generateError } = require('../helpers/helpers.js');

const string = joi
  .string()
  .max(100)
  .generateError(
    'La campo relleneado debe tener un máximo de 100 caracteres',
    400
  );

const name = joi
  .string()
  .min(2)
  .max(50)
  .required()
  .error(
    generateError('El nombre tiene que tener como máximo 50 caracteres', 400)
  );

const newRoomSchema = joi.object().keys({});

const changePasswordSchema = joi.object().keys({});

const loginSchema = joi.object().keys({});

const getUsersSchema = joi.object().keys({});

const editUserSchema = joi.object().keys({});

const emailSchema = joi.object().keys({});

module.exports = {
  newRoomSchema,
  loginSchema,
  changePasswordSchema,
  getUsersSchema,
  editUserSchema,
  emailSchema
};
