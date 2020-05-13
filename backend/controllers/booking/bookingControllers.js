const { getConnection } = require("../../db/db.js");

async function newBooking(request, response, next) {
  let connection;
  try {
    connection = await getConnection();
  } catch (error) {
    next(error);
  } finally {
    connection.release();
  }
}

async function showBooking(request, response, next) {
  let connection;
  try {
    connection = await getConnection();
  } catch (error) {
    next(error);
  } finally {
    connection.release();
  }
}

async function editBooking(request, response, next) {
  let connection;
  try {
    connection = await getConnection();
  } catch (error) {
    next(error);
  } finally {
    connection.release();
  }
}

async function acceptBooking(request, response, next) {
  let connection;
  try {
    connection = await getConnection();
  } catch (error) {
    next(error);
  } finally {
    connection.release();
  }
}

async function declineBooking(request, response, next) {
  let connection;
  try {
    connection = await getConnection();
  } catch (error) {
    next(error);
  } finally {
    connection.release();
  }
}

async function deleteBooking(request, response, next) {
  let connection;
  try {
    connection = await getConnection();
  } catch (error) {
    next(error);
  } finally {
    connection.release();
  }
}

async function getBookings(request, response, next) {
  let connection;
  try {
    connection = await getConnection();
  } catch (error) {
    next(error);
  } finally {
    connection.release();
  }
}

module.exports = {
  newBooking,
  showBooking,
  editBooking,
  acceptBooking,
  declineBooking,
  deleteBooking,
  getBookings,
};
