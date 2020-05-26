const { getConnection } = require('../../db/db.js');

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

module.exports = {
  editBooking
};
