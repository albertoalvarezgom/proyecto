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
      price,
      roomSize,
      sort,
      sortOrder,
      availabilityFrom,
      availabilityUntil,
      facility,
      rule
    } = request.body;

    connection = await getConnection();

    const [
      hiddenUser
    ] = await connection.query(
      `SELECT id_user FROM user WHERE hidden=1 AND id_user=?`,
      [request.auth.id]
    );

    if (hiddenUser.length) {
      throw generateError(
        'Un usuario oculto no puede realizar búsquedas. Haz tu cuenta visible e inténtalo de nuevo',
        401
      );
    }

    let q = `SELECT room.id_room, room.title, room.description, room.address, room.postal_code, room.city, 
    room.flatmates_masc, room.flatmates_fem, room.flatmates_masc, room.flat_size, room.preference_gender, room.status, room.min_age, room.max_age,
    room.room_type, room.room_size, room.bed_type, room.price, room.bills_included, room.deposit, room.deposit_ammount, room.availability_from, room.availability_until,
    room.min_stay, room.max_stay, room.image_1, room.image_2, room.image_3, room.image_4, room.image_5,  
    (SELECT ROUND(AVG(rate),1) FROM rating WHERE rating.id_room_gets=room.id_room) AS rating
    FROM room
    LEFT JOIN facility_room ON room.id_room = facility_room.id_room
    LEFT JOIN facility ON facility.id_facility=facility_room.id_facility
    LEFT JOIN rule_room ON room.id_room = rule_room.id_room
    LEFT JOIN rule ON rule.id_rule = rule_room.id_rule WHERE room.hidden=0`;

    const queryValues = [];

    if (
      price &&
      roomSize &&
      availabilityUntil &&
      availabilityFrom &&
      facility &&
      rule
    ) {
      q = `${q} AND room.price=? AND room.room_size=? AND room.availability_from=? AND room.availability_until=? AND facility.name=? AND rule.name=? GROUP BY room.id_room`;
      queryValues.push(
        price,
        roomSize,
        availabilityFrom,
        availabilityUntil,
        facility,
        rule
      );
    } //
    else if (
      price &&
      roomSize &&
      availabilityUntil &&
      availabilityFrom &&
      facility
    ) {
      q = `${q} AND room.price=? AND room.room_size=? AND room.availability_from=? AND room.availability_until=? AND facility.name=? GROUP BY room.id_room`;
      queryValues.push(
        price,
        roomSize,
        availabilityFrom,
        availabilityUntil,
        facility
      );
    } else if (
      price &&
      roomSize &&
      availabilityUntil &&
      availabilityFrom &&
      rule
    ) {
      q = `${q} AND room.price=? AND room.room_size=? AND room.availability_from=? AND room.availability_until=? AND rule.name=? GROUP BY room.id_room`;
      queryValues.push(
        price,
        roomSize,
        availabilityFrom,
        availabilityUntil,
        rule
      );
    } else if (price && roomSize && availabilityFrom && facility && rule) {
      q = `${q} AND room.price=? AND room.room_size=? AND room.availability_until=? AND facility.name=? AND rule.name=? GROUP BY room.id_room`;
      queryValues.push(price, roomSize, availabilityFrom, facility, rule);
    } else if (
      price &&
      availabilityUntil &&
      availabilityFrom &&
      facility &&
      rule
    ) {
      q = `${q} AND room.price=? AND room.availability_from=? AND room.availability_until=? AND facility.name=? AND rule.name=? GROUP BY room.id_room`;
      queryValues.push(
        price,
        availabilityFrom,
        availabilityUntil,
        facility,
        rule
      );
    } else if (
      roomSize &&
      availabilityUntil &&
      availabilityFrom &&
      facility &&
      rule
    ) {
      q = `${q} AND room.room_size=? AND room.availability_from=? AND room.availability_until=? AND facility.name=? AND rule.name=? GROUP BY room.id_room`;
      queryValues.push(
        roomSize,
        availabilityFrom,
        availabilityUntil,
        facility,
        rule
      );
    }
    //
    else if (price && roomSize && availabilityUntil && availabilityFrom) {
      q = `${q} AND room.price=? AND room.room_size=? AND room.availability_from=? AND room.availability_until=? GROUP BY room.id_room`;
      queryValues.push(price, roomSize, availabilityFrom, availabilityUntil);
    } else if (price && roomSize && availabilityUntil && facility) {
      q = `${q} AND room.price=? AND room.room_size=? AND room.availability_until=? AND facility.name=? GROUP BY room.id_room`;
      queryValues.push(price, roomSize, availabilityUntil, facility);
    } else if (price && roomSize && availabilityUntil && rule) {
      q = `${q} AND room.price=? AND room.room_size=? AND room.availability_until=? AND rule.name=? GROUP BY room.id_room`;
      queryValues.push(price, roomSize, availabilityUntil, rule);
    } else if (price && roomSize && availabilityFrom && facility) {
      q = `${q} AND room.price=? AND room.room_size=? AND room.availability_from=? AND facility.name=? GROUP BY room.id_room`;
      queryValues.push(price, roomSize, availabilityFrom, facility);
    } else if (price && roomSize && availabilityFrom && rule) {
      q = `${q} AND room.price=? AND room.room_size=? AND room.availability_from=? AND rule.name=? GROUP BY room.id_room`;
      queryValues.push(price, roomSize, availabilityFrom, rule);
    } else if (availabilityUntil && availabilityFrom && facility && rule) {
      q = `${q} AND room.availability_until=? AND room.availability_from=? AND facility.name=? AND rule.name=? GROUP BY room.id_room`;
      queryValues.push(availabilityUntil, availabilityFrom, facility, rule);
    } else if (roomSize && availabilityUntil && availabilityFrom && facility) {
      q = `${q} AND room.room_size =? room.availability_from=? AND room.availability_until=? AND facility.name=? GROUP BY room.id_room`;
      queryValues.push(roomSize, availabilityFrom, availabilityUntil, facility);
    }
    //
    else if (price && availabilityUntil && roomSize) {
      q = `${q} AND room.price=? AND room.availability_until=? AND room.room_size=? GROUP BY room.id_room`;
      queryValues.push(price, availabilityUntil, roomSize);
    } else if (price && roomSize && availabilityFrom) {
      q = `${q} AND room.price=? AND room.room_size=? AND room.availability_from=? GROUP BY room.id_room`;
      queryValues.push(price, roomSize, availabilityFrom);
    } else if (price && roomSize && facility) {
      q = `${q} AND room.price=? AND room.room_size=? AND facility.name=? GROUP BY room.id_room`;
      queryValues.push(price, roomSize, facility);
    } else if (price && roomSize && rule) {
      q = `${q} AND room.price=? AND room.room_size=? AND rule.name=? GROUP BY room.id_room`;
      queryValues.push(price, roomSize, rule);
    } else if (price && availabilityUntil && availabilityFrom) {
      q = `${q} AND room.price=? AND room.availability_from=? AND room.availability_until=? GROUP BY room.id_room`;
      queryValues.push(price, availabilityFrom, availabilityUntil);
    } else if (price && availabilityUntil && facility) {
      q = `${q} AND room.price=? AND room.availability_until=? AND facility.name=? GROUP BY room.id_room`;
      queryValues.push(price, availabilityUntil, facility);
    } else if (price && availabilityUntil && rule) {
      q = `${q} AND room.price=? AND room.availability_until=? AND rule.name=? GROUP BY room.id_room`;
      queryValues.push(price, availabilityUntil, rule);
    } else if (price && availabilityFrom && facility) {
      q = `${q} AND room.price=? AND room.availability_from=? AND facility.name=? GROUP BY room.id_room`;
      queryValues.push(price, availabilityFrom, facility);
    } else if (price && availabilityFrom && rule) {
      q = `${q} AND room.price=? AND room.availability_from=? AND rule.name=? GROUP BY room.id_room`;
      queryValues.push(price, availabilityFrom, rule);
    } else if (price && facility && rule) {
      q = `${q} AND room.price=? AND facility.name=? AND rule.name=? GROUP BY room.id_room`;
      queryValues.push(price, facility, rule);
    } else if (availabilityFrom && availabilityUntil && roomSize) {
      q = `${q}  AND room.availability_from=? AND room.availability_until=? AND room.room_size=? GROUP BY room.id_room`;
      queryValues.push(availabilityFrom, availabilityUntil, roomSize);
    } else if (facility && availabilityUntil && roomSize) {
      q = `${q} AND facility.name=? AND room.availability_until=? AND room.room_size=? GROUP BY room.id_room`;
      queryValues.push(facility, availabilityUntil, roomSize);
    } else if (rule && availabilityUntil && roomSize) {
      q = `${q} AND rule.name=? AND room.availability_until=? AND room.room_size=? GROUP BY room.id_room`;
      queryValues.push(rule, availabilityUntil, roomSize);
    } else if (roomSize && availabilityFrom && facility) {
      q = `${q} AND room.room_size=? AND room.availability_from=? AND facility.name=? GROUP BY room.id_room`;
      queryValues.push(roomSize, availabilityFrom, facility);
    } else if (roomSize && availabilityFrom && rule) {
      q = `${q} AND room.room_size=? AND room.availability_from=? AND rule.name=? GROUP BY room.id_room`;
      queryValues.push(roomSize, availabilityFrom, rule);
    } else if (roomSize && facility && rule) {
      q = `${q} AND room.room_size=? AND facility.name=? AND rule.name=? GROUP BY room.id_room`;
      queryValues.push(roomSize, facility, rule);
    } else if (availabilityFrom && facility && rule) {
      q = `${q} AND room.availability_from=? AND facility.name=? AND rule.name=? GROUP BY room.id_room`;
      queryValues.push(availabilityFrom, facility, rule);
    } else if (availabilityUntil && availabilityFrom && facility) {
      q = `${q} AND room.availability_until=? AND room.availability_from=? AND facility.name=? GROUP BY room.id_room`;
      queryValues.push(availabilityUntil, availabilityFrom, facility);
    }
    //
    else if (price && roomSize) {
      q = `${q} AND room.price=? AND room.room_size=? GROUP BY room.id_room`;
      queryValues.push(price, roomSize);
    } else if (price && availabilityUntil) {
      q = `${q} AND room.price=? AND room.availability_until=? GROUP BY room.id_room`;
      queryValues.push(price, availabilityUntil);
    } else if (price && availabilityFrom) {
      q = `${q} AND room.price=? AND room.availability_from=? GROUP BY room.id_room`;
      queryValues.push(price, availabilityFrom);
    } else if (price && facility) {
      q = `${q} AND room.price=? AND facility.name=? GROUP BY room.id_room`;
      queryValues.push(price, facility);
    } else if (price && rule) {
      q = `${q} AND room.price=? AND rule.name=? GROUP BY room.id_room`;
      queryValues.push(price, rule);
    } else if (roomSize && availabilityUntil) {
      q = `${q} AND room.room_size=? AND room.availability_until=? GROUP BY room.id_room`;
      queryValues.push(roomSize, availabilityUntil);
    } else if (roomSize && availabilityFrom) {
      q = `${q} AND room.room_size=? AND room.availability_from=? GROUP BY room.id_room`;
      queryValues.push(roomSize, availabilityFrom);
    } else if (roomSize && facility) {
      q = `${q} AND room.room_size=? AND facility.name=? GROUP BY room.id_room`;
      queryValues.push(roomSize, facility);
    } else if (roomSize && rule) {
      q = `${q} AND room.room_size=? AND rule.name=? GROUP BY room.id_room`;
      queryValues.push(roomSize, rule);
    } else if (availabilityUntil && availabilityFrom) {
      q = `${q} AND room.availability_until=? AND room.availability_from=? GROUP BY room.id_room`;
      queryValues.push(availabilityUntil, availabilityFrom);
    } else if (availabilityUntil && facility) {
      q = `${q} AND room.availability_until=? AND facility.name=? GROUP BY room.id_room`;
      queryValues.push(availabilityUntil, facility);
    } else if (availabilityUntil && rule) {
      q = `${q} AND room.availability_until=? AND rule.name=? GROUP BY room.id_room`;
      queryValues.push(availabilityUntil, rule);
    } else if (availabilityFrom && facility) {
      q = `${q} AND room.availability_from=? AND facility.name=? GROUP BY room.id_room`;
      queryValues.push(availabilityFrom, facility);
    } else if (availabilityFrom && rule) {
      q = `${q} AND room.availability_from=? AND rule.name=? GROUP BY room.id_room`;
      queryValues.push(availabilityFrom, rule);
    } else if (facility && rule) {
      q = `${q} AND facility.name=? AND rule.name=? GROUP BY room.id_room`;
      queryValues.push(facility, rule);
    }
    //
    else if (
      price ||
      roomSize ||
      availabilityUntil ||
      availabilityFrom ||
      facility ||
      rule
    ) {
      q = `${q} AND `;

      if (price) {
        q = `${q} room.price=? GROUP BY room.id_room`;
        queryValues.push(price);
      }

      if (roomSize) {
        q = `${q} room.room_size=? GROUP BY room.id_room`;
        queryValues.push(roomSize);
      }

      if (availabilityUntil) {
        q = `${q} room.availability_until=? GROUP BY room.id_room`;
        queryValues.push(availabilityUntil);
      }

      if (availabilityFrom) {
        q = `${q} room.availability_from=? GROUP BY room.id_room`;
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
