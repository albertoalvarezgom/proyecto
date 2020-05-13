const { getConnection } = require("../../db/db.js");

async function voteUser(request, response, next) {
  let connection;
  try {
    connection = await getConnection();
  } catch (error) {
    next(error);
  } finally {
    connection.release();
  }
}

async function voteRoom(request, response, next) {
  let connection;
  try {
    connection = await getConnection();
  } catch (error) {
    next(error);
  } finally {
    connection.release();
  }
}

async function getVotes(request, response, next) {
  let connection;
  try {
    connection = await getConnection();
  } catch (error) {
    next(error);
  } finally {
    connection.release();
  }
}

async function editVote(request, response, next) {
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
  voteUser,
  voteRoom,
  getVotes,
  editVote,
};
