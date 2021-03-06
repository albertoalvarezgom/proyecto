use inquilino_perfecto;
select * from user;

-- 1. Registrar un usuario. 

INSERT INTO user
       (first_name, birthday, email, password, creation_date, last_update, role)
VALUES
       ('Berto', '1989-08-26','bertoalvarezgom@gmail.com', 'contraseñaadmin', now(), now(), 'admin');


-- Mientras no complete el resto de campos del perfil, que salga un aviso de que el perfil no esta completo.
-- Perfil 2/4 completo. Completa tu perfil para que te sea mas facil encontrar piso, bla bla bla


-- 2. Iniciar sesión. 

SELECT id_user,first_name, birthday, email, password, creation_date, role
FROM user
WHERE email = 'albertoalvarezgom@gmail.com';

-- 2b. Completar/editar el perfil de usuario. Requisito indispensable para acceder a funcionalidades reservadas a usuarios.

UPDATE user
SET gender = 'masculine', occupation_field='Design and video', occupation_status='both', couple=false, ig_profile='@berto', image_1='https://unsplash.com/photos/NDCy2-9JhUs'
	WHERE id_user=1;


-- Tendriamos que comprobar si son los primeros datos que se meten en esta tabla para este usuario. 
-- Si la tabla esta vacia, hacemos INSERT
INSERT INTO personality_user (id_user, id_personality, creation_date)
VALUES
       (1, 1, NOW());

INSERT INTO hobby_user (id_user, id_hobby, description, creation_date, last_update)
VALUES
       (1, 1, 'Tremendo follón',  now(),  now());

INSERT INTO rule_user (id_user, id_rule, creation_date)
VALUES
       (1, 1, now());


-- Si la tabla tiene ya informacion, hacemos UPDATE
        
UPDATE personality_user
SET id_user = 1, id_personality=2, creation_date=now();

UPDATE hobby_user
SET id_user =1, id_hobby=2, description = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. 
Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. 
Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. 
Curabitur aliquet posuere turpis in ultrices.', last_update = now();

UPDATE rule_user
SET id_user = 1, id_rule = 2, creation_date = '2020-01-02 11-22-22';


-- 3. Ver pefil de usuario completo

SELECT *
FROM user JOIN personality_user ON user.id_user = personality_user.id_user JOIN hobby_user ON user.id_user = hobby_user.id_user JOIN rule_user
       ON user.id_user = rule_user.id_user
WHERE user.id_user = 1;

-- 4. El usuario cambia la contraseña (se le pide la antigua y dos veces la nueva)

UPDATE user
SET password = 'adminpass'
WHERE email = 'albertoalvarezgom@gmail.com' AND password = 'admin';


-- 5. Publicar una habitación

INSERT INTO room(id_room, id_user, title, description, address, postal_code, city, flat_size, status, min_age, max_age, room_type, room_size, bed_type, price, availability_from, min_stay, image_1, creation_date, last_update)
VALUES
       (1, 1, '¡Busco compañero/a de piso en A Coruña!', 'Morbi eget dui gravida, auctor quam eget, varius lorem. Suspendisse hendrerit sem sit amet orci tempor lobortis quis sit amet enim. 
       Proin lobortis tristique risus, et lobortis lorem tempor in. Phasellus dignissim lacinia velit et dignissim. Donec nec pellentesque arcu. Maecenas malesuada sapien augue, ac lobortis nibh 
       vestibulum dignissim. Nam semper suscipit velit a sodales. Praesent gravida ex nec massa viverra, vel cursus nisl tempor. Ut maximus rutrum sodales. Vestibulum ante ipsum primis in faucibus 
       orci luctus et ultrices posuere cubilia Curae.', 'Angeles 2, 1', 15001, 'A Coruña', 60, 'working', 19, 30, 'private', 14, 'double', 240, '2020-08-01', 6, 'https://unsplash.com/photos/DhFHtkECn7Q', now(), now());

-- 6. Editar una publicación de habitación

UPDATE room
SET image_2='image2.jpg', image_3='image3.jpg', image_4='image4.jpg',image_5='image5.jpg', last_update=now()
WHERE id_room = 1;

UPDATE facility_room
SET id_room=7, id_facility=1, creation_date=now();

UPDATE rule_room
SET id_room=7, id_rule=1, creation_date=now();


-- 7. Hacer una búsqueda de habitaciones / usuarios

-- Búsqueda general (sin ningún tipo de filtrado más allá de la ciudad o el código postal)

SELECT room.id_room, room.title, room.price, room.image_1, user.first_name, user.image_1, user.birthday
FROM room JOIN user ON user.id_user = room.id_user
WHERE room.city
LIKE '%Coruña%';

--

SELECT room.id_room, room.title, room.price, room.image_1, user.first_name, user.image_1, user.birthday
FROM room JOIN user
       ON user.id_user = room.id_user
WHERE room.postal_code = 15001;


-- Búsqueda avanzada (filtrando la habitación)

SELECT room.id_room, room.title, room.price, room.image_1, user.name, user.image_1, user.birthday
FROM room JOIN user
       ON user.id_user = room.id_user
WHERE room.city
LIKE '%Coruña%' AND room.price < 300 AND room.availability_from = '2020-08-01';

-- Búsqueda avanzada (filtrando el usuario)

SELECT room.id_room, room.title, room.price, room.image_1, user.first_name, user.image_1, user.birthday
FROM room JOIN user
       ON user.id_user = room.id_user
WHERE user.gender = 'masculine';

-- 8. Solicitar una reserva: Guardamos la solicitud en la tabla de reservas y seleccionamos la información de la habitación asociada al propietario de la habitación

INSERT INTO booking
VALUES
       (1, 2, 3, 'demand', 'pending', now(), null, null);

SELECT *
FROM room LEFT JOIN user ON room.id_user = user.id_user
WHERE user.id_user=1;

-- 8b. Aceptar una reserva

UPDATE booking
SET status = 'accepted' WHERE id_booking=1;

-- 8c. Cancelar una reserva

UPDATE booking
SET status = 'cancelled' WHERE id_booking=1;

-- 9. Valorar un usuario o una habitación

INSERT INTO rating
       (id_rating, id_user_sends, id_user_gets, type, rate, comment, creation_date)
VALUES
       (2, 1, 1, 'user', 5, 'Lorem ipsum bla bla bla tremendo compañero de piso',now());


INSERT INTO rating
       (id_rating, id_user_sends, id_room_gets, type, rate, comment,creation_date)
VALUES
       (3, 1, 1, 'room', 5, 'Lorem ipsum bla bla bla tremenda habitacion', now());

-- 10. Listado completo de habitaciones o usuarios

SELECT id_room, title, price, address, postal_code, city, views, image_1, image_2, image_3, image_4, image_5
FROM room
WHERE hidden= false;

SELECT id_user, first_name, birthday, image_1, image_2, image_3, image_4, image_5, occupation_field, occupation_status
FROM user
WHERE hidden = false;


-- 11.Ocultar habitación

UPDATE room
SET hidden= true WHERE id_room = 1;

-- 12. Ocultar usuario

UPDATE user
SET hidden = true WHERE id_user = 1;

-- 13. Eliminar habitación

DELETE FROM room WHERE id_room = 1;

-- 14. Eliminar usuario

select * from user;
DELETE FROM user WHERE id_user =1;

-- 15. Enviar un mensaje
INSERT into messages (id_booking, id_user, comment, creation_date) VALUES (1, 1, 'Tremenda reserva, no?', now());

-- 16. Ver los mensajes
SELECT comment, id_user, creation_date  FROM messages;

-- 17. Borrar un mensaje
DELETE FROM messages WHERE id_message=1;
