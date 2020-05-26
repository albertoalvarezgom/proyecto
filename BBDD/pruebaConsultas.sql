use inquilino_perfecto;

select * from user_match;

insert into booking (id_user, id_user_owner, type, status, creation_date)
values(15, 16, 'offer', 'accepted', now());

delete from booking where id_booking=1;

select * from booking;

insert into user (first_name, birthday, email, password, city, creation_date, last_update, image_1, type) 
values ('Pepe', '1990-04-20', 'pepe@pepe.com', 'asdjahf972y3', 'A Coruña',now(), now(),'96ef4c40-981d-11ea-a255-3b5eb0d9d19d.jpg','owner');

update user set active=1 where id_user=16;

delete from user where id_user=14;

select * from user where id_user=4;
update user set role='admin' where id_user=4;

update user set image_1=null, image_2=null where id_user=4;

UPDATE user
SET gender = 'masculine' WHERE id_user = 4;

UPDATE user
SET gender = 'femenine' WHERE id_user = 5;

insert into personality_user (id_user, id_personality, creation_date) values
(15, 5, now());


select id_room from room where price >= 300;

-- "minPrice": "100",
-- "maxPrice": "300",
-- "availabilityFrom": "2020-01-01",
-- "availabilityUntil": "2022-01-01"

SELECT facility.name FROM facility_room JOIN facility WHERE id_room=4;
SELECT room.id_room
FROM room
    JOIN facility_room ON room.id_room = facility_room.id_room
    JOIN facility ON facility.id_facility=facility_room.id_facility
    JOIN rule_room ON room.id_room = rule_room.id_room
    JOIN rule ON rule.id_rule = rule_room.id_rule
WHERE rule.name='pets' AND facility.name='Wifi';

delete from room where id_room=46;
select title, id_user from room where id_user=21;
update room set image_1=null, image_2=null, image_3=null, image_4=null, image_5=null where id_room=47;

SELECT user.id_user, user.first_name, user.birthday, user.image_1, user.image_2, user.image_3, user.image_4, user.image_5, user.email, user.creation_date, user.gender, user.views, 
personality_user.id_personality,  personality_user.id_personality, personality.name, personality.type, hobby_user.id_hobby, hobby.name, hobby_user.description , rule_user.id_rule, rule.name
FROM user 
LEFT JOIN personality_user ON user.id_user = personality_user.id_user 
LEFT JOIN personality ON personality.id_personality=personality_user.id_personality 
LEFT JOIN hobby_user ON user.id_user = hobby_user.id_user 
LEFT JOIN hobby ON hobby.id_hobby= hobby_user.id_hobby
LEFT JOIN rule_user ON user.id_user = rule_user.id_user
LEFT JOIN rule ON rule.id_rule = rule_user.id_rule
WHERE user.id_user = 4; 


SELECT user.id_user, user.first_name, user.birthday, user.image_1, user.image_2, user.image_3, user.image_4, user.image_5, user.email, user.creation_date, user.gender, user.views
FROM user 
LEFT JOIN personality_user ON user.id_user = personality_user.id_user 
LEFT JOIN personality ON personality.id_personality=personality_user.id_personality 
LEFT JOIN hobby_user ON user.id_user = hobby_user.id_user 
LEFT JOIN hobby ON hobby.id_hobby= hobby_user.id_hobby
LEFT JOIN rule_user ON user.id_user = rule_user.id_user
LEFT JOIN rule ON rule.id_rule = rule_user.id_rule
WHERE personality.name in ('calm') group by user.id_user;

select user.first_name from user left join personality_user on user.id_user = personality_user.id_user where personality_user.id_personality=(
select personality.id_personality from personality where personality.name ='calm');


select * from rating;


insert into rating(id_user_send, id_user_gets, type, rate, comment, creation_date)
values();

delete from rating where id_rating=1;


SELECT user.id_user, user.first_name, user.birthday, user.image_1, 
      user.image_2, user.image_3, user.image_4, user.image_5, user.email, user.creation_date, 
      user.gender, user.views
      FROM user
      LEFT JOIN personality_user ON user.id_user = personality_user.id_user
      LEFT JOIN personality ON personality.id_personality=personality_user.id_personality
      LEFT JOIN hobby_user ON user.id_user = hobby_user.id_user
      LEFT JOIN hobby ON hobby.id_hobby= hobby_user.id_hobby
      LEFT JOIN rule_user ON user.id_user = rule_user.id_user
      LEFT JOIN rule ON rule.id_rule = rule_user.id_rule
      WHERE user.couple=true AND user.occupation_status='working' AND user.gender='femenine' group by user.id_user;


SELECT * FROM user_match WHERE id_user1=21 OR (id_user2=21 AND status='accepted');
SELECT * FROM user_match WHERE id_user2=21;

SELECT hidden FROM user WHERE id_user=21;
SELECT hidden FROM user WHERE id_user=22;

SELECT * FROM booking;
SELECT * FROM user_match;
DELETE FROM user_match;


SELECT user.id_user, user.first_name, user.birthday, user.image_1, 
      user.image_2, user.image_3, user.image_4, user.image_5, user.email, user.creation_date, 
      user.gender, user.views, user.type,
      (SELECT ROUND(AVG(rate),1) FROM rating WHERE rating.id_user_gets=user.id_user) AS rating
      FROM user
      WHERE user.id_user NOT IN (SELECT user_match.id_user1 FROM user_match WHERE user_match.id_user2=21) 
      AND user.id_user NOT IN (SELECT user_match.id_user2 FROM user_match WHERE user_match.id_user1=21) 
      AND user.hidden=0;
      
      SELECT confirmation_code FROM booking WHERE id_booking=1;
      
SELECT * FROM booking;

SELECT id_user1, id_user2 FROM booking WHERE confirmation_code='f575472375eea1cb27ffb7f4f4e84fa49bd9d082';

UPDATE user SET hidden=1 WHERE id_user = (SELECT booking.id_user2 FROM  booking WHERE booking.confirmation_code='f575472375eea1cb27ffb7f4f4e84fa49bd9d082') 
OR id_user = (SELECT booking.id_user1 FROM  booking WHERE booking.confirmation_code='f575472375eea1cb27ffb7f4f4e84fa49bd9d082');