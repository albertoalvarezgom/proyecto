require('dotenv').config();

const chalk = require('chalk');

const { getConnection } = require('../../db/db.js');
const { generateError } = require('../../helpers/helpers.js');
const { getUsersSchema } = require('../../validations/userValidation');

async function getUsers(request, response, next) {
  let connection;
  try {
    // await getUsersSchema.validateAsync(request.query);
    const {
      gender,
      couple,
      sort,
      sortOrder,
      occupationStatus,
      personality,
      hobby,
      rule
    } = request.query;

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

    const [
      type
    ] = await connection.query(`SELECT type FROM user WHERE id_user=?`, [
      request.auth.id
    ]);

    let userType;

    if (type[0].type === 'buscando piso') {
      userType = 'buscando inquilino';
    } else {
      userType = 'buscando piso';
    }

    let q = `SELECT user.id_user
    FROM user
    LEFT JOIN personality_user ON user.id_user = personality_user.id_user
    LEFT JOIN personality ON personality.id_personality = personality_user.id_personality
    LEFT JOIN hobby_user ON user.id_user = hobby_user.id_user
    LEFT JOIN hobby ON hobby.id_hobby = hobby_user.id_hobby
    LEFT JOIN rule_user ON user.id_user = rule_user.id_user
    LEFT JOIN rule ON rule.id_rule = rule_user.id_rule
    WHERE user.id_user NOT IN(SELECT user_match.id_user1 FROM user_match WHERE user_match.id_user2 =?)
    AND user.id_user NOT IN(SELECT user_match.id_user2 FROM user_match WHERE user_match.id_user1 =?)
    AND user.hidden = 0 AND user.type =? AND user.city =?`;

    const queryValues = [
      request.auth.id,
      request.auth.id,
      userType,
      request.auth.city
    ];

    if (gender && couple && occupationStatus && personality && hobby && rule) {
      q = `${q} AND user.gender=? AND user.couple=? AND user.occupation_status=? AND personality.name=? AND hobby.name=? AND rule.name=? GROUP BY user.id_user`;
      queryValues.push(
        gender,
        couple,
        occupationStatus,
        personality,
        hobby,
        rule
      );
    } //
    else if (gender && couple && occupationStatus && personality && hobby) {
      q = `${q} AND user.gender=? AND user.couple=? AND user.occupation_status=? AND personality.name=? AND hobby.name=? GROUP BY user.id_user`;
      queryValues.push(gender, couple, occupationStatus, personality, hobby);
    } else if (gender && couple && occupationStatus && personality && rule) {
      q = `${q} AND user.gender=? AND user.couple=? AND user.occupation_status=? AND personality.name=? AND rule.name=? GROUP BY user.id_user`;
      queryValues.push(gender, couple, occupationStatus, personality, rule);
    } else if (gender && couple && personality && hobby && rule) {
      q = `${q} AND user.gender=? AND user.couple=? AND personality.name=? AND hobby.name=? AND rule.name=? GROUP BY user.id_user`;
      queryValues.push(gender, couple, personality, hobby, rule);
    } else if (gender && occupationStatus && personality && hobby && rule) {
      q = `${q} AND user.gender=? AND user.occupation_status=? AND personality.name=? AND hobby.name=? AND rule.name=? GROUP BY user.id_user`;
      queryValues.push(gender, occupationStatus, personality, hobby, rule);
    } else if (couple && occupationStatus && personality && hobby && rule) {
      q = `${q} AND user.couple=? AND user.occupation_status=? AND personality.name=? AND hobby.name=? AND rule.name=? GROUP BY user.id_user`;
      queryValues.push(couple, occupationStatus, personality, hobby, rule);
    }
    //
    else if (gender && couple && occupationStatus && personality) {
      q = `${q} AND user.gender=? AND user.couple=? AND user.occupation_status=? AND personality.name=? GROUP BY user.id_user`;
      queryValues.push(gender, couple, occupationStatus, personality);
    } else if (gender && couple && occupationStatus && hobby) {
      q = `${q} AND user.gender=? AND user.couple=? AND user.occupation_status=? AND hobby.name=? GROUP BY user.id_user`;
      queryValues.push(gender, couple, occupationStatus, hobby);
    } else if (gender && couple && occupationStatus && rule) {
      q = `${q} AND user.gender=? AND user.couple=? AND user.occupation_status=? AND rule.name=? GROUP BY user.id_user`;
      queryValues.push(gender, couple, occupationStatus, rule);
    } else if (gender && couple && personality && hobby) {
      q = `${q} AND user.gender=? AND user.couple=? AND personality.name=? AND hobby.name=? GROUP BY user.id_user`;
      queryValues.push(gender, couple, personality, hobby);
    } else if (gender && couple && personality && rule) {
      q = `${q} AND user.gender=? AND user.couple=? AND personality.name=? AND rule.name=? GROUP BY user.id_user`;
      queryValues.push(gender, couple, personality, rule);
    } else if (occupationStatus && personality && hobby && rule) {
      q = `${q} AND user.occupation_status=? AND personality.name=? AND hobby.name=? AND rule.name=? GROUP BY user.id_user`;
      queryValues.push(occupationStatus, personality, hobby, rule);
    } else if (couple && occupationStatus && personality && hobby) {
      q = `${q} AND user.couple =? user.occupation_status=? AND personality.name=? AND hobby.name=? GROUP BY user.id_user`;
      queryValues.push(couple, occupationStatus, personality, hobby);
    }
    //
    else if (gender && occupationStatus && couple) {
      q = `${q} AND user.gender=? AND user.occupation_status=? AND user.couple=? GROUP BY user.id_user`;
      queryValues.push(gender, occupationStatus, couple);
    } else if (gender && couple && personality) {
      q = `${q} AND user.gender=? AND user.couple=? AND personality.name=? GROUP BY user.id_user`;
      queryValues.push(gender, couple, personality);
    } else if (gender && couple && hobby) {
      q = `${q} AND user.gender=? AND user.couple=? AND hobby.name=? GROUP BY user.id_user`;
      queryValues.push(gender, couple, hobby);
    } else if (gender && couple && rule) {
      q = `${q} AND user.gender=? AND user.couple=? AND rule.name=? GROUP BY user.id_user`;
      queryValues.push(gender, couple, rule);
    } else if (gender && occupationStatus && personality) {
      q = `${q} AND user.gender=? AND user.occupation_status=? AND personality.name=? GROUP BY user.id_user`;
      queryValues.push(gender, occupationStatus, personality);
    } else if (gender && occupationStatus && hobby) {
      q = `${q} AND user.gender=? AND user.occupation_status=? AND hobby.name=? GROUP BY user.id_user`;
      queryValues.push(gender, occupationStatus, hobby);
    } else if (gender && occupationStatus && rule) {
      q = `${q} AND user.gender=? AND user.occupation_status=? AND rule.name=? GROUP BY user.id_user`;
      queryValues.push(gender, occupationStatus, rule);
    } else if (gender && personality && hobby) {
      q = `${q} AND user.gender=? AND personality.name=? AND hobby.name=? GROUP BY user.id_user`;
      queryValues.push(gender, personality, hobby);
    } else if (gender && personality && rule) {
      q = `${q} AND user.gender=? AND personality.name=? AND rule.name=? GROUP BY user.id_user`;
      queryValues.push(gender, personality, rule);
    } else if (gender && hobby && rule) {
      q = `${q} AND user.gender=? AND hobby.name=? AND rule.name=? GROUP BY user.id_user`;
      queryValues.push(gender, hobby, rule);
    } else if (personality && occupationStatus && couple) {
      q = `${q} AND personlality.name=? AND user.occupation_status=? AND user.couple=? GROUP BY user.id_user`;
      queryValues.push(personality, occupationStatus, couple);
    } else if (hobby && occupationStatus && couple) {
      q = `${q} AND hobby.name=? AND user.occupation_status=? AND user.couple=? GROUP BY user.id_user`;
      queryValues.push(hobby, occupationStatus, couple);
    } else if (rule && occupationStatus && couple) {
      q = `${q} AND rule.name=? AND user.occupation_status=? AND user.couple=? GROUP BY user.id_user`;
      queryValues.push(rule, occupationStatus, couple);
    } else if (couple && personality && hobby) {
      q = `${q} AND user.couple=? AND personality.name=? AND hobby.name=? GROUP BY user.id_user`;
      queryValues.push(couple, personality, hobby);
    } else if (couple && personality && rule) {
      q = `${q} AND user.couple=? AND personality.name=? AND rule.name=? GROUP BY user.id_user`;
      queryValues.push(couple, personality, rule);
    } else if (couple && hobby && rule) {
      q = `${q} AND user.couple=? AND hobby.name=? AND rule.name=? GROUP BY user.id_user`;
      queryValues.push(couple, hobby, rule);
    } else if (personality && hobby && rule) {
      q = `${q} AND personality.name=? AND hobby.name=? AND rule.name=? GROUP BY user.id_user`;
      queryValues.push(personality, hobby, rule);
    } else if (occupationStatus && personality && hobby) {
      q = `${q} AND user.occupation_status=? AND personality.name=? AND hobby.name=? GROUP BY user.id_user`;
      queryValues.push(occupationStatus, personality, hobby);
    }
    //
    else if (gender && couple) {
      q = `${q} AND user.gender=? AND user.couple=? GROUP BY user.id_user`;
      queryValues.push(gender, couple);
    } else if (gender && occupationStatus) {
      q = `${q} AND user.gender=? AND user.occupation_status=? GROUP BY user.id_user`;
      queryValues.push(gender, occupationStatus);
    } else if (gender && personality) {
      q = `${q} AND user.gender=? AND personality.name=? GROUP BY user.id_user`;
      queryValues.push(gender, personality);
    } else if (gender && hobby) {
      q = `${q} AND user.gender=? AND hobby.name=? GROUP BY user.id_user`;
      queryValues.push(gender, hobby);
    } else if (gender && rule) {
      q = `${q} AND user.gender=? AND rule.name=? GROUP BY user.id_user`;
      queryValues.push(gender, rule);
    } else if (couple && occupationStatus) {
      q = `${q} AND user.couple=? AND user.occupation_status=? GROUP BY user.id_user`;
      queryValues.push(couple, occupationStatus);
    } else if (couple && personality) {
      q = `${q} AND user.couple=? AND personality.name=? GROUP BY user.id_user`;
      queryValues.push(couple, personality);
    } else if (couple && hobby) {
      q = `${q} AND user.couple=? AND hobby.name=? GROUP BY user.id_user`;
      queryValues.push(couple, hobby);
    } else if (couple && rule) {
      q = `${q} AND user.couple=? AND rule.name=? GROUP BY user.id_user`;
      queryValues.push(couple, rule);
    } else if (occupationStatus && personality) {
      q = `${q} AND user.occupation_status=? AND personality.name=? GROUP BY user.id_user`;
      queryValues.push(occupationStatus, personality);
    } else if (occupationStatus && hobby) {
      q = `${q} AND user.occupation_status=? AND hobby.name=? GROUP BY user.id_user`;
      queryValues.push(occupationStatus, hobby);
    } else if (occupationStatus && rule) {
      q = `${q} AND user.occupation_status=? AND rule.name=? GROUP BY user.id_user`;
      queryValues.push(occupationStatus, rule);
    } else if (personality && hobby) {
      q = `${q} AND personality.name=? AND hobby.name=? GROUP BY user.id_user`;
      queryValues.push(personality, hobby);
    } else if (personality && rule) {
      q = `${q} AND personality.name=? AND rule.name=? GROUP BY user.id_user`;
      queryValues.push(personality, rule);
    } else if (hobby && rule) {
      q = `${q} AND hobby.name=? AND rule.name=? GROUP BY user.id_user`;
      queryValues.push(hobby, rule);
    }
    //
    else {
      if (
        gender ||
        couple ||
        occupationStatus ||
        personality ||
        hobby ||
        rule
      ) {
        q = `${q} AND `;

        if (gender) {
          q = `${q} user.gender=? GROUP BY user.id_user`;
          queryValues.push(gender);
        }

        if (couple) {
          q = `${q} user.couple=? GROUP BY user.id_user`;
          queryValues.push(couple);
        }

        if (occupationStatus) {
          q = `${q} user.occupation_status=? GROUP BY user.id_user`;
          queryValues.push(occupationStatus);
        }

        if (personality) {
          q = `${q} personality.name=? GROUP BY user.id_user`;
          queryValues.push(personality);
        }
        if (hobby) {
          q = `${q} hobby.name=? GROUP BY user.id_user`;
          queryValues.push(hobby);
        }
        if (rule) {
          q = `${q} rule.name=? GROUP BY user.id_user`;
          queryValues.push(rule);
        }
      }
    }

    if (sort && sortOrder) {
      q = `${q} ORDER BY ${sort} ${sortOrder}`;
      queryValues.push(sort);
      queryValues.push(sortOrder);
    } else if (sort) {
      q = `${q} ORDER BY ${sort}`;
      queryValues.push(sort);
    }

    if (
      !gender &&
      !couple &&
      !occupationStatus &&
      !personality &&
      !hobby &&
      !rule
    ) {
      q = `SELECT user.id_user
      FROM user
      LEFT JOIN room ON room.id_user=user.id_user
      LEFT JOIN personality_user ON user.id_user = personality_user.id_user
      LEFT JOIN personality ON personality.id_personality=personality_user.id_personality
      LEFT JOIN hobby_user ON user.id_user = hobby_user.id_user
      LEFT JOIN hobby ON hobby.id_hobby= hobby_user.id_hobby
      LEFT JOIN rule_user ON user.id_user = rule_user.id_user
      LEFT JOIN rule ON rule.id_rule = rule_user.id_rule 
      WHERE user.id_user NOT IN (SELECT user_match.id_user1 FROM user_match WHERE user_match.id_user2=? AND user_match.status!='enviado') 
      AND user.id_user NOT IN (SELECT user_match.id_user2 FROM user_match WHERE user_match.id_user1=? AND user_match.status!='enviado') 
      AND user.hidden=0 AND user.type=? AND user.city=? GROUP BY user.id_user`;
    }

    const [users] = await connection.query(q, queryValues);

    const userProfile = [];
    const userPersonality = [];
    const userRule = [];
    const userHobby = [];
    const userRoom = [];

    for (let i = 0; i < users.length; i++) {
      let [sqlUserQuery] = await connection.query(
        `SELECT user.id_user, user.first_name, user.image_1,
      user.image_2, user.image_3, user.image_4, user.image_5, user.creation_date,
      user.gender, user.views, user.type,
      (SELECT ROUND(AVG(rate),1) FROM rating WHERE rating.id_user_gets=user.id_user) AS rating,
      (SELECT YEAR(CURDATE()) - YEAR(birthday)) AS age
      FROM user WHERE user.id_user=?`,
        [users[i].id_user]
      );
      userProfile.push(sqlUserQuery);

      let [
        sqlPersonalityQuery
      ] = await connection.query(
        `SELECT personality.name FROM personality_user JOIN personality ON personality_user.id_personality=personality.id_personality WHERE personality_user.id_user=? AND personality_user.status=1`,
        [users[i].id_user]
      );
      userPersonality.push(sqlPersonalityQuery);

      let [
        sqlRuleQuery
      ] = await connection.query(
        `SELECT rule.name FROM rule_user JOIN rule ON rule_user.id_rule=rule.id_rule WHERE rule_user.id_user=? AND rule_user.status=1`,
        [users[i].id_user]
      );
      userRule.push(sqlRuleQuery);

      let [
        sqlHobbyQuery
      ] = await connection.query(
        `SELECT hobby.name, hobby_user.description FROM hobby_user JOIN hobby ON hobby_user.id_hobby=hobby.id_hobby WHERE hobby_user.id_user=? AND hobby_user.status=1`,
        [users[i].id_user]
      );
      userHobby.push(sqlHobbyQuery);

      let [
        sqlRoomQuery
      ] = await connection.query(`SELECT * FROM room WHERE id_user=?`, [
        users[i].id_user
      ]);
      userRoom.push(sqlRoomQuery);
    }

    const fullUser = [];

    for (let i = 0; i < users.length; i++) {
      fullUser.push({
        perfil: userProfile[i],
        personalidad: userPersonality[i],
        hobbies: userHobby[i],
        rules: userRule[i],
        room: userRoom[i]
      });
    }

    response.send({ status: 'ok', data: fullUser });
  } catch (error) {
    next(error);
  } finally {
    if (connection) {
      connection.release();
    }
  }
}

module.exports = { getUsers };
