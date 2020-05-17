require('dotenv').config();

const { getConnection } = require('../../db/db.js');

const { getUsersSchema } = require('../../validations/userValidation');

async function getUsers(request, response, next) {
  let connection;
  try {
    await getUsersSchema.validateAsync(request.body);
    const {
      gender,
      couple,
      sort,
      sortOrder,
      occupationStatus,
      personality
    } = request.body;

    connection = await getConnection();

    // let q =
    //   'SELECT id_user, first_name, birthday, occupation_status, image_1, image_2, image_3, image_4, image_5, email, creation_date, gender, views FROM user';

    let q = `SELECT user.id_user, user.first_name, user.birthday, user.image_1, 
      user.image_2, user.image_3, user.image_4, user.image_5, user.email, user.creation_date, 
      user.gender, user.views
      FROM user
      LEFT JOIN personality_user ON user.id_user = personality_user.id_user
      LEFT JOIN personality ON personality.id_personality=personality_user.id_personality
      LEFT JOIN hobby_user ON user.id_user = hobby_user.id_user
      LEFT JOIN hobby ON hobby.id_hobby= hobby_user.id_hobby
      LEFT JOIN rule_user ON user.id_user = rule_user.id_user
      LEFT JOIN rule ON rule.id_rule = rule_user.id_rule`;

    const queryValues = [];

    if (gender && couple && occupationStatus && personality) {
      q = `${q} WHERE user.gender=? AND user.couple=? AND user.occupation_status=? AND personality.name=?`;
      queryValues.push(gender, couple, occupationStatus, personality);
    } else if (gender && couple) {
      q = `${q} WHERE user.gender=? AND user.couple=?`;
      queryValues.push(gender, couple);
    } else if (gender && occupationStatus) {
      q = `${q} WHERE user.gender=? AND user.occupation_status=?`;
      queryValues.push(gender, occupationStatus);
    } else if (couple && occupationStatus) {
      q = `${q} WHERE user.couple=? AND user.occupation_status=?`;
      queryValues.push(couple, occupationStatus);
    } else {
      if (gender || couple || occupationStatus || personality) {
        q = `${q} WHERE `;

        if (gender) {
          q = `${q} user.gender=?`;
          queryValues.push(gender);
        }

        if (couple) {
          q = `${q} user.couple=?`;
          queryValues.push(couple);
        }

        if (occupationStatus) {
          q = `${q} user.occupation_status=?`;
          queryValues.push(occupationStatus);
        }

        if (personality) {
          q = `${q} personality.name=?`;
          queryValues.push(personality);
        }
      }
    }

    if (sort) {
      if (sort) {
        q = `${q} ORDER BY ${sort}`;
        queryValues.push(sort);
      }

      if (sortOrder) {
        q = `${q} ${sortOrder}`;
        queryValues.push(sortOrder);
      }
    }

    const [users] = await connection.query(q, queryValues);

    response.send({ status: 'ok', data: users });
  } catch (error) {
    next(error);
  } finally {
    if (connection) {
      connection.release();
    }
  }
}

module.exports = { getUsers };
