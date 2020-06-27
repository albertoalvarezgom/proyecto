const joi = require('@hapi/joi').extend(require('@hapi/joi-date'));
const { generateError } = require('../helpers/helpers.js');

const date = joi
  .date()
  .format('YYYY-MM-DD')
  .required()
  .error(generateError('El formato de fecha introducido no es válido', 400));

const bookingSchema = joi.object().keys({
  startDate: date,
  finishDate: date
});

module.exports = {
  bookingSchema
};
