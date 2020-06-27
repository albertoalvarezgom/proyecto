const joi = require('@hapi/joi').extend(require('@hapi/joi-date'));
const { generateError } = require('../helpers/helpers.js');

const string = joi
  .string()
  .required()
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
  .valid('masculine', 'femenine', 'any')
  .error(
    generateError(
      'La opciones de género son "masculine", "femenine" o "any"',
      400
    )
  );

const room = joi
  .string()
  .valid('private', 'shared')
  .error(
    generateError(
      'La opciones de tipo de habitación son "private" o "shared"',
      400
    )
  );

const bed = joi
  .string()
  .valid('single', 'double', 'coach')
  .error(
    generateError(
      'La opciones de tipo de cama son "single", "double" o "coach"',
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
  .max(200)
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
  maxStay: smallNumber
});

const editRoomFacilitiesSchema = joi.object().keys({
  facility1: string,
  status1: boolean,
  facility2: string,
  status2: boolean,
  facility3: string,
  status3: boolean,
  facility4: string,
  status4: boolean,
  facility5: string,
  status5: boolean,
  facility6: string,
  status7: boolean,
  facility8: string,
  status8: boolean,
  facility9: string,
  status9: boolean,
  facility10: string,
  status10: boolean,
  facility11: string,
  status11: boolean,
  facility12: string,
  status12: boolean,
  facility13: string,
  status13: boolean,
  facility14: string,
  status14: boolean,
  facility15: string,
  status15: boolean,
  facility16: string,
  status16: boolean,
  facility17: string,
  status17: boolean,
  facility18: string,
  status18: boolean
});

module.exports = {
  roomSchema,
  editRoomFacilitiesSchema
};
