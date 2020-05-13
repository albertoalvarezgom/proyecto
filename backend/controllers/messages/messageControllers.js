const { getConnection } = require('../../db/db.js');

async function getMessage(request, response, next) {
  let connection;
  try {
    connection = await getConnection();
  } catch (error) {
    next(error);
  } finally {
    connection.release();
  }
}

async function sendMessage(request, response, next) {
  let connection;
  try {
    connection = await getConnection();
  } catch (error) {
    next(error);
  } finally {
    connection.release();
  }
}

async function deleteMessage(request, response, next) {
  let connection;
  try {
    connection = await getConnection();
  } catch (error) {
    next(error);
  } finally {
    connection.release();
  }
}

module.exports = { getMessage, sendMessage, deleteMessage };
