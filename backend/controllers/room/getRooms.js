require('dotenv').config();
// const jwt = require('jsonwebtoken');
const chalk = require('chalk');

const { getConnection } = require('../../db/db.js');
const { generateError } = require('../../helpers/helpers.js');
const { getUsersSchema } = require('../../validations/userValidation');

async function getRooms(request, response, next) {
  let connection;
  try {
    // await getUsersSchema.validateAsync(request.body);
    const {
      minPrice,
      maxPrice,
      sort,
      sortOrder,
      availabilityFrom,
      availabilityUntil,
      facility,
      rule
    } = request.body;

    const { city } = request.query;

    connection = await getConnection();

    // const [
    //   hiddenUser
    // ] = await connection.query(
    //   `SELECT id_user FROM user WHERE hidden=1 AND id_user=?`,
    //   [request.auth.id]
    // );

    // if (hiddenUser.length) {
    //   throw generateError(
    //     'Un usuario oculto no puede realizar búsquedas. Haz tu cuenta visible e inténtalo de nuevo',
    //     401
    //   );
    // }

    let q = `SELECT room.*,  
    (SELECT ROUND(AVG(rate),1) FROM rating WHERE rating.id_room_gets=room.id_room) AS rating
    FROM room
    JOIN facility_room ON room.id_room = facility_room.id_room
    JOIN facility ON facility.id_facility=facility_room.id_facility
    JOIN rule_room ON room.id_room = rule_room.id_room
    JOIN rule ON rule.id_rule = rule_room.id_rule WHERE room.hidden=0 AND room.city=?`;

    const queryValues = [city];

    if (
      minPrice &&
      maxPrice &&
      availabilityUntil &&
      availabilityFrom &&
      facility &&
      rule
    ) {
      q = `${q} AND room.price>=? AND room.price<=? AND room.availability_from>=? AND room.availability_until<=? AND facility.name=? AND rule.name=? GROUP BY room.id_room`;
      queryValues.push(
        minPrice,
        maxPrice,
        availabilityFrom,
        availabilityUntil,
        facility,
        rule
      );
    } //
    else if (
      minPrice &&
      maxPrice &&
      availabilityUntil &&
      availabilityFrom &&
      facility
    ) {
      q = `${q} AND room.price>=? AND room.price<=? AND room.availability_from>=? AND room.availability_until<=? AND facility.name=? GROUP BY room.id_room`;
      queryValues.push(
        minPrice,
        maxPrice,
        availabilityFrom,
        availabilityUntil,
        facility
      );
    } else if (
      minPrice &&
      maxPrice &&
      availabilityUntil &&
      availabilityFrom &&
      rule
    ) {
      q = `${q} AND room.price>=? AND room.price<=? AND room.availability_from>=? AND room.availability_until<=? AND rule.name=? GROUP BY room.id_room`;
      queryValues.push(
        minPrice,
        maxPrice,
        availabilityFrom,
        availabilityUntil,
        rule
      );
    } else if (minPrice && maxPrice && availabilityFrom && facility && rule) {
      q = `${q} AND room.price>=? AND room.price<=? AND room.availability_from>=? AND facility.name=? AND rule.name=? GROUP BY room.id_room`;
      queryValues.push(minPrice, maxPrice, availabilityFrom, facility, rule);
    } else if (
      minPrice &&
      availabilityUntil &&
      availabilityFrom &&
      facility &&
      rule
    ) {
      q = `${q} AND room.price>=? AND room.availability_from>=? AND room.availability_until<=? AND facility.name=? AND rule.name=? GROUP BY room.id_room`;
      queryValues.push(
        minPrice,
        availabilityFrom,
        availabilityUntil,
        facility,
        rule
      );
    } else if (
      maxPrice &&
      availabilityUntil &&
      availabilityFrom &&
      facility &&
      rule
    ) {
      q = `${q} AND room.price<=? AND room.availability_from>=? AND room.availability_until<=? AND facility.name=? AND rule.name=? GROUP BY room.id_room`;
      queryValues.push(
        maxPrice,
        availabilityFrom,
        availabilityUntil,
        facility,
        rule
      );
    }
    //
    else if (minPrice && maxPrice && availabilityUntil && availabilityFrom) {
      q = `${q} AND room.price<=? AND room.price>=? AND room.availability_from>=? AND room.availability_until<=? GROUP BY room.id_room`;
      queryValues.push(minPrice, maxPrice, availabilityFrom, availabilityUntil);
    } else if (minPrice && maxPrice && availabilityUntil && facility) {
      q = `${q} AND room.price>=? AND room.price<=? AND room.availability_until<=? AND facility.name=? GROUP BY room.id_room`;
      queryValues.push(minPrice, maxPrice, availabilityUntil, facility);
    } else if (minPrice && maxPrice && availabilityUntil && rule) {
      q = `${q} AND room.price>=? AND room.price<=? AND room.availability_until<=? AND rule.name=? GROUP BY room.id_room`;
      queryValues.push(minPrice, maxPrice, availabilityUntil, rule);
    } else if (minPrice && maxPrice && availabilityFrom && facility) {
      q = `${q} AND room.price>=? AND room.price<=? AND room.availability_from>=? AND facility.name=? GROUP BY room.id_room`;
      queryValues.push(minPrice, maxPrice, availabilityFrom, facility);
    } else if (minPrice && maxPrice && availabilityFrom && rule) {
      q = `${q} AND room.price>=? AND room.price<=? AND room.availability_from>=? AND rule.name=? GROUP BY room.id_room`;
      queryValues.push(minPrice, maxPrice, availabilityFrom, rule);
    } else if (availabilityUntil && availabilityFrom && facility && rule) {
      q = `${q} AND room.availability_until<=? AND room.availability_from>=? AND facility.name=? AND rule.name=? GROUP BY room.id_room`;
      queryValues.push(availabilityUntil, availabilityFrom, facility, rule);
    } else if (maxPrice && availabilityUntil && availabilityFrom && facility) {
      q = `${q} AND room.price<=? room.availability_from>=? AND room.availability_until<=? AND facility.name=? GROUP BY room.id_room`;
      queryValues.push(maxPrice, availabilityFrom, availabilityUntil, facility);
    }
    //
    else if (minPrice && availabilityUntil && maxPrice) {
      q = `${q} AND room.price>=? AND room.availability_until<=? AND room.price<=? GROUP BY room.id_room`;
      queryValues.push(minPrice, availabilityUntil, maxPrice);
    } else if (minPrice && maxPrice && availabilityFrom) {
      q = `${q} AND room.price>=? AND room.price<=? AND room.availability_from>=? GROUP BY room.id_room`;
      queryValues.push(minPrice, maxPrice, availabilityFrom);
    } else if (minPrice && maxPrice && facility) {
      q = `${q} AND room.price>=? AND room.price<=? AND facility.name=? GROUP BY room.id_room`;
      queryValues.push(minPrice, maxPrice, facility);
    } else if (minPrice && maxPrice && rule) {
      q = `${q} AND room.price>=? AND room.price<=? AND rule.name=? GROUP BY room.id_room`;
      queryValues.push(minPrice, maxPrice, rule);
    } else if (minPrice && availabilityUntil && availabilityFrom) {
      q = `${q} AND room.price>=? AND room.availability_from>=? AND room.availability_until<=? GROUP BY room.id_room`;
      queryValues.push(minPrice, availabilityFrom, availabilityUntil);
    } else if (minPrice && availabilityUntil && facility) {
      q = `${q} AND room.price>=? AND room.availability_until<=? AND facility.name=? GROUP BY room.id_room`;
      queryValues.push(minPrice, availabilityUntil, facility);
    } else if (minPrice && availabilityUntil && rule) {
      q = `${q} AND room.price>=? AND room.availability_until<=? AND rule.name=? GROUP BY room.id_room`;
      queryValues.push(minPrice, availabilityUntil, rule);
    } else if (minPrice && availabilityFrom && facility) {
      q = `${q} AND room.price>=? AND room.availability_from>=? AND facility.name=? GROUP BY room.id_room`;
      queryValues.push(minPrice, availabilityFrom, facility);
    } else if (minPrice && availabilityFrom && rule) {
      q = `${q} AND room.price>=? AND room.availability_from>=? AND rule.name=? GROUP BY room.id_room`;
      queryValues.push(minPrice, availabilityFrom, rule);
    } else if (minPrice && facility && rule) {
      q = `${q} AND room.price>=? AND facility.name=? AND rule.name=? GROUP BY room.id_room`;
      queryValues.push(minPrice, facility, rule);
    } else if (availabilityFrom && availabilityUntil && maxPrice) {
      q = `${q}  AND room.availability_from>=? AND room.availability_until<=? AND room.price<=? GROUP BY room.id_room`;
      queryValues.push(availabilityFrom, availabilityUntil, maxPrice);
    } else if (facility && availabilityUntil && maxPrice) {
      q = `${q} AND facility.name=? AND room.availability_until<=? AND room.price<=? GROUP BY room.id_room`;
      queryValues.push(facility, availabilityUntil, maxPrice);
    } else if (rule && availabilityUntil && maxPrice) {
      q = `${q} AND rule.name=? AND room.availability_until<=? AND room.price<=? GROUP BY room.id_room`;
      queryValues.push(rule, availabilityUntil, maxPrice);
    } else if (maxPrice && availabilityFrom && facility) {
      q = `${q} AND room.price<=? AND room.availability_from>=? AND facility.name=? GROUP BY room.id_room`;
      queryValues.push(maxPrice, availabilityFrom, facility);
    } else if (maxPrice && availabilityFrom && rule) {
      q = `${q} AND room.price<=? AND room.availability_from>=? AND rule.name=? GROUP BY room.id_room`;
      queryValues.push(maxPrice, availabilityFrom, rule);
    } else if (maxPrice && facility && rule) {
      q = `${q} AND room.price<=? AND facility.name=? AND rule.name=? GROUP BY room.id_room`;
      queryValues.push(maxPrice, facility, rule);
    } else if (availabilityFrom && facility && rule) {
      q = `${q} AND room.availability_from>=? AND facility.name=? AND rule.name=? GROUP BY room.id_room`;
      queryValues.push(availabilityFrom, facility, rule);
    } else if (availabilityUntil && availabilityFrom && facility) {
      q = `${q} AND room.availability_until<=? AND room.availability_from>=? AND facility.name=? GROUP BY room.id_room`;
      queryValues.push(availabilityUntil, availabilityFrom, facility);
    }
    //
    else if (minPrice && maxPrice) {
      q = `${q} AND room.price>=? AND room.price<=? GROUP BY room.id_room`;
      queryValues.push(minPrice, maxPrice);
    } else if (minPrice && availabilityUntil) {
      q = `${q} AND room.price>=? AND room.availability_until<=? GROUP BY room.id_room`;
      queryValues.push(minPrice, availabilityUntil);
    } else if (minPrice && availabilityFrom) {
      q = `${q} AND room.price>=? AND room.availability_from>=? GROUP BY room.id_room`;
      queryValues.push(minPrice, availabilityFrom);
    } else if (minPrice && facility) {
      q = `${q} AND room.price>=? AND facility.name=? GROUP BY room.id_room`;
      queryValues.push(minPrice, facility);
    } else if (minPrice && rule) {
      q = `${q} AND room.price>=? AND rule.name=? GROUP BY room.id_room`;
      queryValues.push(minPrice, rule);
    } else if (maxPrice && availabilityUntil) {
      q = `${q} AND room.price<=? AND room.availability_until<=? GROUP BY room.id_room`;
      queryValues.push(maxPrice, availabilityUntil);
    } else if (maxPrice && availabilityFrom) {
      q = `${q} AND room.price<=? AND room.availability_from>=? GROUP BY room.id_room`;
      queryValues.push(maxPrice, availabilityFrom);
    } else if (maxPrice && facility) {
      q = `${q} AND room.price<=? AND facility.name=? GROUP BY room.id_room`;
      queryValues.push(maxPrice, facility);
    } else if (maxPrice && rule) {
      q = `${q} AND room.price<=? AND rule.name=? GROUP BY room.id_room`;
      queryValues.push(maxPrice, rule);
    } else if (availabilityUntil && availabilityFrom) {
      q = `${q} AND room.availability_until<=? AND room.availability_from>=? GROUP BY room.id_room`;
      queryValues.push(availabilityUntil, availabilityFrom);
    } else if (availabilityUntil && facility) {
      q = `${q} AND room.availability_until<=? AND facility.name=? GROUP BY room.id_room`;
      queryValues.push(availabilityUntil, facility);
    } else if (availabilityUntil && rule) {
      q = `${q} AND room.availability_until<=? AND rule.name=? GROUP BY room.id_room`;
      queryValues.push(availabilityUntil, rule);
    } else if (availabilityFrom && facility) {
      q = `${q} AND room.availability_from>=? AND facility.name=? GROUP BY room.id_room`;
      queryValues.push(availabilityFrom, facility);
    } else if (availabilityFrom && rule) {
      q = `${q} AND room.availability_from>=? AND rule.name=? GROUP BY room.id_room`;
      queryValues.push(availabilityFrom, rule);
    } else if (facility && rule) {
      q = `${q} AND facility.name=? AND rule.name=? GROUP BY room.id_room`;
      queryValues.push(facility, rule);
    }
    //
    else if (
      minPrice ||
      maxPrice ||
      availabilityUntil ||
      availabilityFrom ||
      facility ||
      rule
    ) {
      q = `${q} AND `;

      if (minPrice) {
        q = `${q} room.price>? GROUP BY room.id_room`;
        queryValues.push(minPrice);
      }

      if (maxPrice) {
        q = `${q} room.price<=? GROUP BY room.id_room`;
        queryValues.push(maxPrice);
      }

      if (availabilityUntil) {
        q = `${q} room.availability_until<=? GROUP BY room.id_room`;
        queryValues.push(availabilityUntil);
      }

      if (availabilityFrom) {
        q = `${q} room.availability_from>=? GROUP BY room.id_room`;
        queryValues.push(availabilityFrom);
      }
      if (facility) {
        q = `${q} facility.name=? GROUP BY room.id_room`;
        queryValues.push(facility);
      }
      if (rule) {
        q = `${q} rule.name=? GROUP BY room.id_room`;
        queryValues.push(rule);
      }
    } else {
      q = `${q} GROUP BY room.id_room`;
    }

    if (sort && sortOrder) {
      q = `${q} ORDER BY ${sort} ${sortOrder}`;
      queryValues.push(sort);
      queryValues.push(sortOrder);
    } else if (sort) {
      q = `${q} ORDER BY ${sort}`;
      queryValues.push(sort);
    }

    const [rooms] = await connection.query(q, queryValues);

    response.send({ status: 'ok', data: rooms });
  } catch (error) {
    next(error);
  } finally {
    if (connection) {
      connection.release();
    }
  }
}

module.exports = { getRooms };
