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
    generateError(
      'La contraseña debe tener entre 6 y 20 caracteres y estar formada por caracteres alfanuméricos',
      400
    )
  );

const string = joi
  .string()
  .max(100)
  .error(
    generateError(
      'La campo relleneado debe tener un máximo de 100 caracteres',
      400
    )
  );
const sortOrder = joi
  .string()
  .valid('asc', 'desc', 'ASC', 'DESC')
  .error(
    generateError(
      'La órdenes de orden válidas en SQL son sólo "asc" o "desc"',
      400
    )
  );

const occupationStatus = joi
  .string()
  .valid('working', 'studying', 'both', 'none')
  .error(
    generateError(
      'La opción de estado de ocupación introducida no es válida',
      400
    )
  );

const name = joi
  .string()
  .min(2)
  .max(50)
  .required()
  .error(
    generateError('El nombre tiene que tener como máximo 50 caracteres', 400)
  );

const newUserSchema = joi.object().keys({
  name: name,
  birthday: joi
    .date()
    .format('YYYY-MM-DD')
    .required()
    .error(generateError('El formato de fecha introducido no es válido', 400)),
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
      generateError(
        'El género introducido no está entre los establecidos como válidos',
        400
      )
    ),
  couple: joi
    .boolean()
    .error(
      generateError('Es un campo booleano. Opciones válidas true o false', 400)
    ),
  sort: string,
  sortOrder: sortOrder,
  occupationStatus: string,
  personality: string,
  hobby: string,
  rule: string
});

const editUserSchema = joi.object().keys({
  name: name,
  birthday: joi
    .date()
    .required()
    .error(generateError('El formato de fecha introducido no es válido', 400)),
  email: email,
  occupationField: string,
  occupationStatus: occupationStatus
});

const emailSchema = joi.object().keys({ email: email });

module.exports = {
  newUserSchema,
  loginSchema,
  changePasswordSchema,
  getUsersSchema,
  editUserSchema,
  emailSchema
};
