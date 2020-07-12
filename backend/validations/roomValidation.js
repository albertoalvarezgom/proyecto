const joi = require('@hapi/joi').extend(require('@hapi/joi-date'));
const { generateError } = require('../helpers/helpers.js');

const any = joi.any();

const string = joi
  .string()
  .max(400)
  .error(
    generateError(
      'La campo relleneado debe tener un máximo de 400 caracteres',
      400
    )
  );

const postalCode = joi
  .number()
  .min(10000)
  .max(99999)
  .error(
    generateError(
      'El valor del código postal debe ser un número de 5 cifras',
      400
    )
  );

const gender = joi
  .string()
  .valid('chico', 'chica', 'indiferente')
  .error(
    generateError(
      'La opciones de género son "chico", "chica" o "indiferente"',
      400
    )
  );

const room = joi
  .string()
  .valid('privada', 'compartida')
  .error(
    generateError(
      'La opciones de tipo de habitación son "privada" o "compartida"',
      400
    )
  );

const bed = joi
  .string()
  .valid('doble', 'individual', 'sofa-cama', 'sin cama')
  .error(
    generateError(
      'La opciones de tipo de cama son "individual", "doble", "sofá-cama" o "sin cama',
      400
    )
  );

const smallNumber = joi
  .number()
  .min(0)
  .max(20)
  .error(generateError('El valor debe estar comprendido entre 0 y 20', 400));

const mediumNumber = joi
  .number()
  .min(30)
  .max(400)
  .error(generateError('El valor debe estar comprendido entre 30 y 400', 400));

const age = joi
  .number()
  .min(18)
  .max(90)
  .error(
    generateError('Las edades deben estar comprendidas entre 18 y 90 años', 400)
  );

const boolean = joi
  .boolean()
  .error(
    generateError('Es un campo booleano. Opciones válidas true o false', 400)
  );

const booleanSQL = joi
  .number()
  .min(0)
  .max(1)
  .error(generateError('El campo solo permite "sí" o "no"', 400));

const date = joi
  .date()
  .format('YYYY-MM-DD')
  .required()
  .error(generateError('El formato de fecha introducido no es válido', 400));

const roomSchema = joi.object().keys({
  title: string,
  description: string,
  address: string,
  postalCode: postalCode,
  city: string,
  flatmatesMasc: smallNumber,
  flatmatesFem: smallNumber,
  flatSize: mediumNumber,
  preferenceGender: gender,
  status: string,
  minAge: age,
  maxAge: age,
  roomType: room,
  roomSize: smallNumber,
  bedType: bed,
  price: mediumNumber,
  billsIncluded: boolean,
  deposit: boolean,
  depositAmmount: mediumNumber,
  availabilityFrom: date,
  availabilityUntil: date,
  minStay: smallNumber,
  maxStay: smallNumber,
  image_1: ''
});

const editRoomSchema = joi.object().keys({
  title: string,
  description: string,
  address: string,
  postalCode: postalCode,
  city: string,
  flatmatesMasc: smallNumber,
  flatmatesFem: smallNumber,
  flatSize: mediumNumber,
  preferenceGender: gender,
  status: string,
  minAge: age,
  maxAge: age,
  roomType: room,
  roomSize: smallNumber,
  bedType: bed,
  price: mediumNumber,
  billsIncluded: boolean,
  deposit: boolean,
  depositAmmount: any,
  availabilityFrom: date,
  availabilityUntil: date,
  minStay: smallNumber,
  maxStay: smallNumber,
  image_1: any
});

const editRoomFacilitiesSchema = joi.object().keys({
  facility1: string,
  status1: booleanSQL,
  facility2: string,
  status2: booleanSQL,
  facility3: string,
  status3: booleanSQL,
  facility4: string,
  status4: booleanSQL,
  facility5: string,
  status5: booleanSQL,
  facility6: string,
  status6: booleanSQL,
  facility7: string,
  status7: booleanSQL,
  facility8: string,
  status8: booleanSQL,
  facility9: string,
  status9: booleanSQL,
  facility10: string,
  status10: booleanSQL,
  facility11: string,
  status11: booleanSQL,
  facility12: string,
  status12: booleanSQL,
  facility13: string,
  status13: booleanSQL,
  facility14: string,
  status14: booleanSQL,
  facility15: string,
  status15: booleanSQL,
  facility16: string,
  status16: booleanSQL,
  facility17: string,
  status17: booleanSQL,
  facility18: string,
  status18: booleanSQL
});

module.exports = {
  roomSchema,
  editRoomSchema,
  editRoomFacilitiesSchema
};
