const joi = require('@hapi/joi').extend(require('@hapi/joi-date'));
const { generateError } = require('../helpers/helpers.js');

const email = joi
  .string()
  .email()
  .required()
  .error(new Error('Email no válido'));
const password = joi
  .string()
  .min(6)
  .alphanum()
  .max(20)
  .required()
  .error(
    new Error(
      'La contraseña debe tener entre 6 y 20 caracteres y estar formada por caracteres alfanuméricos'
    )
  );

const string = joi
  .string()
  .max(100)
  .error(
    new Error('La campo relleneado debe tener un máximo de 100 caracteres')
  );

const sortOrder = joi
  .string()
  .valid('asc', 'desc', 'ASC', 'DESC')
  .error(
    new Error('La órdenes de orden válidas en SQL son sólo "asc" o "desc"')
  );

const occupationStatus = joi
  .string()
  .valid('working', 'studying', 'both', 'none')
  .error(
    new Error('La opción de estado de ocupación introducida no es válida')
  );

const name = joi
  .string()
  .min(2)
  .max(50)
  .required()
  .error(new Error('El nombre tiene que tener como máximo 50 caracteres'));

const newUserSchema = joi.object().keys({
  name: name,
  birthday: joi
    .date()
    .format('YYYY-MM-DD')
    .required()
    .error(new Error('El formato de fecha introducido no es válido')),
  email: email,
  password: password,
  city: string
});

const changePasswordSchema = joi.object().keys({
  oldPassword: password,
  newPassword: password,
  newPasswordRepeat: joi
    .any()
    .valid(joi.ref('newPassword'))
    .error(generateError('Las nuevas passwords deben ser iguales', 400))
});

const loginSchema = joi.object().keys({ email: email, password: password });

const getUsersSchema = joi.object().keys({
  gender: joi
    .valid('masculine', 'femenine', 'other')
    .error(
      new Error(
        'El género introducido no está entre los establecidos como válidos'
      )
    ),
  couple: joi
    .boolean()
    .error(new Error('Es un campo booleano. Opciones válidas true o false')),
  sort: string,
  sortOrder: sortOrder,
  occupationStatus: string,
  personality: string
});

const editUserSchema = joi.object().keys({
  name: name,
  birthday: joi
    .date()
    .required()
    .error(new Error('El formato de fecha introducido no es válido')),
  email: email,
  occupationField: string,
  occupationStatus: occupationStatus
});

module.exports = {
  newUserSchema,
  loginSchema,
  changePasswordSchema,
  getUsersSchema,
  editUserSchema
};
