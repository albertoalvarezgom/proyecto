const joi = require('@hapi/joi').extend(require('@hapi/joi-date'));
const { generateError } = require('../helpers/helpers.js');

const booleanSQL = joi
  .number()
  .min(0)
  .max(1)
  .error(generateError('El campo solo permite "sí" o "no"', 400));

const any = joi.any();

const phone = joi
  .number()
  .required()
  .error(generateError('Número de teléfono no válido', 400));

const email = joi
  .string()
  .email()
  .required()
  .error(generateError('Email no válido', 400));

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

const boolean = joi
  .boolean()
  .error(
    generateError('Es un campo booleano. Opciones válidas true o false', 400)
  );

const string = joi
  .string()
  .max(100)
  .error(
    generateError(
      'El campo relleneado debe tener un máximo de 100 caracteres',
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
  .valid('trabajando', 'estudiando', 'estudiando y trabajando', 'nada')
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
  city: string,
  phone: phone
});

const changePasswordSchema = joi.object().keys({
  oldPassword: password,
  newPassword: password
  // newPasswordRepeat: joi
  //   .any()
  //   .valid(joi.ref('newPassword'))
  //   .error(generateError('Las nuevas passwords deben ser iguales', 400))
});

const loginSchema = joi.object().keys({ email: email, password: password });

const getUsersSchema = joi.object().keys({
  gender: joi
    .valid('masculine', 'femenine', 'any')
    .error(
      generateError(
        'El género introducido no está entre los establecidos como válidos',
        400
      )
    ),
  couple: boolean,
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
  userCity: string,
  email: email,
  phone: phone,
  occupationField: string,
  occupationStatus: occupationStatus,
  couple: string,
  gender: string,
  ig_profile: string,
  type: string,
  image_1: any
});

const emailSchema = joi.object().keys({ email: email });

const editUserPersonalitySchema = joi.object().keys({
  personality1: string,
  personality2: string,
  personality3: string,
  personality4: string,
  personality5: string
});

const editUserHobbySchema = joi.object().keys({
  hobby1: string,
  description1: string,
  hobby2: string,
  description2: string,
  hobby3: string,
  description3: string,
  hobby4: string,
  description4: string,
  hobby5: string,
  description5: string
});

const editUserRuleSchema = joi.object().keys({
  rule1: string,
  status1: booleanSQL,
  rule2: string,
  status2: booleanSQL,
  rule3: string,
  status3: booleanSQL,
  rule4: string,
  status4: booleanSQL
});

module.exports = {
  newUserSchema,
  loginSchema,
  changePasswordSchema,
  getUsersSchema,
  editUserSchema,
  emailSchema,
  editUserPersonalitySchema,
  editUserHobbySchema,
  editUserRuleSchema
};
