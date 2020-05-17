const joi = require('@hapi/joi').extend(require('@hapi/joi-date'));
const { generateError } = require('../helpers/helpers.js');

const voteSchema = joi.object().keys({
  rating: joi
    .number()
    .min(1)
    .max(5)
    .integer()
    .required()
    .error(
      generateError(
        'El voto numérico es obligatorio y ser un número entre 1 y 5',
        400
      )
    ),
  comment: joi
    .string()
    .required()
    .min(30)
    .max(1000)
    .error(
      generateError(
        'El campo comentario es obligatorio y debe tener entre 30 y 1000 caracteres'
      )
    )
});

module.exports = {
  voteSchema
};
