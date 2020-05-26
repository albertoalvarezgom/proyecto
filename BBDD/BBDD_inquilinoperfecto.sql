SET SQL_SAFE_UPDATES = 0;
SET GLOBAL sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));
-- drop database inquilino_perfecto;
create database inquilino_perfecto;
use inquilino_perfecto;

create table user (
id_user int primary key auto_increment,
first_name varchar(100) not null,
birthday date not null,
city varchar(255) not null,
email varchar(100) not null,
password varchar(100) not null,
creation_date datetime not null,
last_update datetime default now() on update now(),
last_password_update datetime,
role enum('normal', 'admin') not null default 'normal',
gender enum('masculine', 'femenine', 'other'),
occupation_field varchar(100),
occupation_status enum('working', 'studying', 'both', 'none'),
couple boolean default false,
ig_profile varchar(50),
image_1 varchar(600),
image_2 varchar(600),
image_3 varchar(600),
image_4 varchar(600),
image_5 varchar(600),
hidden boolean default false,
active boolean default false,
type enum('owner', 'looking') not null default 'looking',
views int default 0,
registration_code varchar(255)
);

create table personality (
id_personality int primary key auto_increment,
name varchar(100) not null,
type enum ('feature', 'lifestyle')
);

insert into personality values (1, 'active','feature');
insert into personality values (2, 'calm','feature');
insert into personality values (3, 'thoughtful','feature');
insert into personality values (4, 'happy','feature');
insert into personality values (5, 'helpful','feature');
insert into personality values (6, 'creative','feature');
insert into personality values (7, 'easy going','feature');
insert into personality values (8, 'empathic','feature');
insert into personality values (9, 'enthusiastic','feature');
insert into personality values (10, 'kind','feature');
insert into personality values (11, 'funny','feature');
insert into personality values (12, 'honest','feature');
insert into personality values (13, 'optimistic','feature');
insert into personality values (14, 'organized','feature');
insert into personality values (15, 'passionate','feature');
insert into personality values (16, 'proactive','feature');
insert into personality values (17, 'sensible','feature');
insert into personality values (18, 'tolerant','feature');
insert into personality values (19, 'sociable','feature');
insert into personality values (20, 'sensitive','feature');
insert into personality values (21, 'familiar', 'lifestyle');
insert into personality values (22, 'healthy', 'lifestyle');
insert into personality values (23, 'gamer', 'lifestyle');
insert into personality values (24, 'foodie', 'lifestyle');
insert into personality values (25, 'workaholic', 'lifestyle');
insert into personality values (26, 'early bird', 'lifestyle');
insert into personality values (27, 'adventurous', 'lifestyle');
insert into personality values (28, 'quiet', 'lifestyle');
insert into personality values (29, 'party animal', 'lifestyle');
insert into personality values (30, 'shopper', 'lifestyle');
insert into personality values (31, 'animal lover', 'lifestyle');
insert into personality values (32, 'lonely', 'lifestyle');
insert into personality values (33, 'nocturnal', 'lifestyle');
insert into personality values (34, 'practical', 'lifestyle');
insert into personality values (35, 'improviser', 'lifestyle');
insert into personality values (36, 'homelike', 'lifestyle');
insert into personality values (37, 'fashion addict', 'lifestyle');
insert into personality values (38, 'geek', 'lifestyle');
insert into personality values (39, 'hater', 'lifestyle');
insert into personality values (40, 'entrepreneur', 'lifestyle');



create table personality_user (
id_user int not null,
id_personality int not null,
primary key (id_user, id_personality),
constraint FK_user_personality foreign key(id_user) references user (id_user) on delete cascade,
constraint FK_personality_user foreign key(id_personality) references personality (id_personality) on delete cascade,
creation_date datetime not null default now()
);

create table hobby (
id_hobby int primary key auto_increment,
name varchar(100) not null
);

insert into hobby values (1, 'cinema');
insert into hobby  values (2, 'music');
insert into hobby  values (3, 'photography');
insert into hobby  values (4, 'nature');
insert into hobby  values (5, 'sports');
insert into hobby  values (6, 'reading');
insert into hobby  values (7, 'cooking');
insert into hobby  values (8, 'series');
insert into hobby  values (9, 'videogames');
insert into hobby  values (10, 'fashion');
insert into hobby  values (11, 'art');
insert into hobby  values (12, 'technology');
insert into hobby  values (13, 'adventure');
insert into hobby  values (14, 'travel');
insert into hobby  values (15, 'crafts');

create table hobby_user (
id_user int not null,
id_hobby int not null,
description text not null,
primary key(id_user, id_hobby),
constraint FK_user_hobby foreign key (id_user) references user(id_user) on delete cascade,
constraint FK_hobby_user foreign key (id_hobby) references hobby(id_hobby) on delete cascade,
creation_date datetime not null,
last_update datetime not null
);

create table room (
id_room int primary key auto_increment,
id_user int,
constraint FK_user_room foreign key (id_user) references user(id_user) on delete cascade,
title text not null,
description text not null,
address text not null,
postal_code int not null,
city varchar(100) not null,
flatmates_masc int not null default 0,
flatmates_fem int not null default 0,
flat_size int not null,
preference_gender enum ('masc', 'fem', 'any') default 'any',
status varchar(15),
min_age int check (rate between 18 and 50),
max_age int check (rate between 18 and 50),
room_type varchar(20) not null,
room_size int not null,
bed_type varchar(20),
price decimal (6,2) not null,
bills_included boolean default false,
deposit boolean default false,
deposit_ammount decimal (6,2),
availability_from date not null,
availability_until date,
min_stay int not null,
max_stay int default null,
image_1 varchar(600),
image_2 varchar(600),
image_3 varchar(600),
image_4 varchar(600),
image_5 varchar(600),
hidden boolean default false,
views int default 0,
creation_date datetime not null default now(),
last_update datetime on update now()
);

create table facility (
id_facility int primary key auto_increment,
name varchar(100) not null
);

insert into facility values (1, 'TV');
insert into facility values (2, 'Wifi');
insert into facility values (3, 'air conditioner');
insert into facility values (4, 'parking');
insert into facility values (5, 'elevator');
insert into facility values (6, 'heat');
insert into facility values (7, 'washing machine');
insert into facility values (8, 'dryer');
insert into facility values (9, 'doorman');
insert into facility values (10, 'furniture');
insert into facility values (11, 'swimmingpool');
insert into facility values (12, 'private bathroom');
insert into facility values (13, 'balcony');
insert into facility values (14, 'view');
insert into facility values (15, 'dishwasher');
insert into facility values (16, 'accessible');
insert into facility values (17, 'garden');
insert into facility values (18, 'terrace');

create table facility_room (
id_room int not null,
id_facility int not null,
primary key(id_room, id_facility),
constraint FK_room_facility foreign key(id_room) references room (id_room) on delete cascade,
constraint FK_facility_room foreign key(id_facility) references facility (id_facility) on delete cascade,
creation_date datetime not null default now()
);

create table rule (
id_rule int primary key auto_increment,
name varchar(100) not null
);

insert into rule values (1, 'pets');
insert into rule values (2, 'smoking');
insert into rule values (3, 'vegetarian');
insert into rule values (4, 'allergies');
insert into rule values (5, 'couples');


create table rule_user (
id_user int not null,
id_rule int not null,
primary key(id_user, id_rule),
constraint FK_user_rule foreign key(id_user) references user (id_user) on delete cascade,
constraint FK_rule_user foreign key(id_rule) references rule (id_rule) on delete cascade,
creation_date datetime not null default now()
);

create table rule_room (
id_room int not null,
id_rule int not null,
primary key(id_room, id_rule),
constraint FK_room_rule foreign key(id_room) references room (id_room) on delete cascade,
constraint FK_rule_room foreign key(id_rule) references rule (id_rule) on delete cascade,
creation_date datetime not null default now()
);

create table rating (
id_rating int primary key auto_increment,
id_user_sends int,
id_user_gets int,
id_room_gets int,
type enum ('room', 'user') not null,
rate int check (rate between 1 and 5),
comment text not null,
constraint FK_user_sends foreign key (id_user_sends) references user(id_user) on delete set null,
constraint FK_user_gets foreign key (id_user_gets) references user(id_user) on delete cascade,
constraint FK_room_gets foreign key (id_room_gets) references room(id_room) on delete cascade,
creation_date datetime not null default now()
);



create table user_match (
id_match int primary key auto_increment,
id_user1 int,
id_user2 int,
constraint FK_user_match1 foreign key(id_user1) references user (id_user),
constraint FK_user_match2 foreign key(id_user2) references user (id_user),
status enum('pending', 'match') default 'pending'
);

insert into user_match(id_user1, id_user2, status) VALUES(21, 22, 'match');
select * from user_match;

create table booking(
id_booking int primary key auto_increment,
id_match int not null,
id_room int not null,
constraint FK_user1 foreign key (id_user1) references user (id_user) on delete cascade,
constraint FK_user2 foreign key (id_user2) references user (id_user) on delete cascade,
constraint FK_match foreign key (id_match) references user_match (id_match) on delete cascade,
constraint FK_room foreign key (id_room) references room (id_room) on delete cascade,
status enum ('pending', 'cancelled', 'accepted') default 'pending',
confirmation_code varchar(255),
creation_date datetime not null default now(),
start_date date,
finish_date date
);

create table messages (
id_message int primary key auto_increment,
id_match int,
id_user int,
constraint FK_match_message foreign key(id_match) references user_match(id_match) on delete set null,
constraint FK_user_message foreign key(id_user) references user(id_user) on delete set null,
comment text not null,
creation_date datetime not null default now()
);


insert into user(first_name, birthday, city, email, password, creation_date, last_password_update, gender, occupation_field, occupation_status, couple, ig_profile, active) 
values ('Sara', '1990-07-06', 'A Coruña','sara.marinho@gmail.com', 's1f562a8isd3lajsb78dnf89l3asbfu25ñj2', now(), now(), 'femenine', 'enfermera', 'working', true, '@sara90',  true);

insert into user(first_name, birthday, city, email, password, creation_date, last_password_update, gender, occupation_field, occupation_status, couple, ig_profile, active) 
values ('Pedro', '1989-03-12', 'A Coruña','pedro.ramallo@gmail.com', '1f1f8igsd3ajsb7h8dn4f89vl3fvavssbgj2', now(), now(), 'masculine', 'ingeniero', 'working', false, '@pedro89',  true);

insert into user(first_name, birthday, city, email, password, creation_date, last_password_update, gender, occupation_field, occupation_status, couple, ig_profile, active) 
values ('Brais', '1987-10-08', 'A Coruña','brais.moldes@gmail.com', '112g45igj98vh33ajsb7v3n0f89vl3v3rvrv', now(), now(), 'masculine', 'consultor', 'working', true, '@brais87',  true);

insert into user(first_name, birthday, city, email, password, creation_date, last_password_update, gender, occupation_field, occupation_status, couple, ig_profile, active) 
values ('Andrea', '1988-11-01', 'A Coruña','andrea.fernandez@gmail.com', '2g45i12gj98vhg33ajsb7vl3vg31g', now(), now(), 'femenine', 'investigadora', 'both', true, '@andrea88',  true);

insert into user(first_name, birthday, city, email, password, creation_date, last_password_update, gender, occupation_field, occupation_status, couple, ig_profile, active) 
values ('Xabier', '1991-12-22', 'A Coruña','xabi.cambeiro@gmail.com', 'zg20ehv98v2evi2vnkynpuñ978km9', now(), now(), 'masculine', 'diseñador grafico', 'working', false, '@xabier',  true);

insert into user(first_name, birthday, city, email, password, creation_date, last_password_update, gender, occupation_field, occupation_status, couple, ig_profile, active) 
values ('Lara', '1992-02-07', 'A Coruña','lara.seoane@gmail.com', '20eshvv98v24gevhi4h2v6n5kyjnp7ujñ97', now(), now(), 'femenine', 'finanzas', 'both', false, '@lara92',  true);

insert into user(first_name, birthday, city, email, password, creation_date, last_password_update, gender, occupation_field, occupation_status, couple, ig_profile, active) 
values ('Ruben', '1994-12-03', 'A Coruña','ruben.arias@gmail.com', '90097767ujeshvvk5898v2yk4gevhii764', now(), now(), 'masculine', 'ventas', 'studying', true, '@ruben94',  true);

insert into user(first_name, birthday, city, email, password, creation_date, last_password_update, gender, occupation_field, occupation_status, couple, ig_profile, active) 
values ('Alex', '1996-08-30', 'A Coruña','alex.lopez@gmail.com', '09fsdv77svdvfvvsdvr36t4n75nn6mujm6um', now(), now(), 'femenine', 'logistica', 'studying', false, '@alex96',  true);

insert into user(first_name, birthday, city, email, password, creation_date, last_password_update, gender, occupation_field, occupation_status, couple, ig_profile, active) 
values ('Diego', '1990-11-01', 'A Coruña','diego.muros@gmail.com', 'fsd3v77s45vdv5f8vvksdk7v8kr3u6t4n', now(), now(), 'masculine', 'abodago', 'studying', true, '@diego90',  true);

insert into user(first_name, birthday, city, email, password, creation_date, last_password_update, gender, occupation_field, occupation_status, couple, ig_profile, active) 
values ('Mara', '1992-04-12', 'A Coruña', 'mara.carballo@gmail.com', '3v737s43r5vgd5vg556hf678vj8jvks', now(), now(), 'femenine', 'turismo', 'working', false, '@mara92',  true);

insert into user(first_name, birthday, city, email, password, creation_date, last_password_update, gender, occupation_field, occupation_status, couple, ig_profile, active) 
values ('Tomas', '1996-05-07', 'A Coruña', 'tomas.hervas@gmail.com', '47ugtrs43r5vg9497ngirh823mbrgb', now(), now(), 'masculine', 'comunicacion', 'studying', false, '@tomas96',  true);

insert into user(first_name, birthday, city, email, password, creation_date, last_password_update, gender, occupation_field, occupation_status, couple, ig_profile, active) 
values ('Uxia', '2000-02-10', 'A Coruña', 'uxia.rodriguez@gmail.com', 'gtf2rs463r8598vg9948797n5g64i6r3', now(), now(), 'femenine', 'educacion', 'both', true, '@uxia00',  true);

insert into user(first_name, birthday, city, email, password, creation_date, last_password_update, gender, occupation_field, occupation_status, couple, ig_profile, active) 
values ('Marcos', '1999-09-09', 'A Coruña', 'marcos.blanco@gmail.com', 'f2rs938vfvvg4h996h4568u775j9', now(), now(), 'masculine', 'educacion', 'studying', false, '@marcos99',  true);

insert into user(first_name, birthday, city, email, password, creation_date, last_password_update, gender, occupation_field, occupation_status, couple, ig_profile, active) 
values ('Carmen', '1997-12-02', 'A Coruña', 'carmen.camaño@gmail.com', '298fh2hf92fb2bp5gndvsvn93ov2pn9gnu', now(), now(), 'femenine', 'fotografia', 'working', true, '@carmen97',  true);

insert into user(first_name, birthday, city, email, password, creation_date, last_password_update, gender, occupation_field, occupation_status, couple, ig_profile, active) 
values ('Roi', '1990-05-01', 'A Coruña','roi.cal@gmail.com', 'h2hfv9234fb32hbp5hg45nhd45hvsv6nh79j', now(), now(), 'masculine', 'artista 3D', 'both', true, '@roi90',  true);

insert into user(first_name, birthday, city, email, password, creation_date, last_password_update, gender, occupation_field, occupation_status, couple, ig_profile, active) 
values ('Ines', '1995-06-11', 'A Coruña','ines.barros@gmail.com', '2h2effvg952g36456fhb63j72mh78bp78', now(), now(), 'femenine', 'abogada', 'studying', true, '@ines95',  true);

insert into user(first_name, birthday, city, email, password, creation_date, last_password_update, gender, occupation_field, occupation_status, couple, ig_profile, active) 
values ('Berto', '1989-02-02', 'A Coruña','berto.novo@gmail.com', 'fvd5gg954527g536bt4b4tb4h56f556', now(), now(), 'masculine', 'educacion', 'working', false, '@berto89',  true);

insert into user(first_name, birthday, city, email, password, creation_date, last_password_update, gender, occupation_field, occupation_status, couple, ig_profile, active) 
values ('Alba', '1999-10-05', 'A Coruña','alba.iglesias@gmail.com', 'g3g954g5g527h54g5g536f3btc4bb4y', now(), now(), 'femenine', 'servicio tecnico', 'both', false, '@alba99',  true);

insert into user(first_name, birthday, city, email, password, creation_date, last_password_update, gender, occupation_field, occupation_status, couple, ig_profile, active) 
values ('David',  '2000-11-02', 'A Coruña','david.casas@gmail.com', '527h54g5g5ac2g35g37j7j68fk3btn', now(), now(), 'masculine', 'finanzas', 'studying', true, '@david00',  true);

insert into user(first_name, birthday, city, email, password, creation_date, last_password_update, gender, occupation_field, occupation_status, couple, ig_profile, active) 
values ('Antia', '2001-01-22', 'A Coruña','antia.mato@gmail.com', '4g5g5ac2vg35gb375j6n75jn68n6fk', now(), now(), 'femenine', 'investigadora', 'working', true, '@antia01',  true);


insert into personality_user (id_user, id_personality)values (1, 1);
insert into personality_user (id_user, id_personality)values (1, 3);
insert into personality_user (id_user, id_personality)values (1, 8);
insert into personality_user (id_user, id_personality)values (1, 10);
insert into personality_user (id_user, id_personality)values (1, 12);
insert into personality_user (id_user, id_personality)values (1, 21);
insert into personality_user (id_user, id_personality)values (1, 23);
insert into personality_user (id_user, id_personality)values (1, 28);
insert into personality_user (id_user, id_personality)values (1, 30);
insert into personality_user (id_user, id_personality)values (1, 32);

insert into personality_user (id_user, id_personality)values (2, 2);
insert into personality_user (id_user, id_personality)values (2, 5);
insert into personality_user (id_user, id_personality)values (2, 6);
insert into personality_user (id_user, id_personality)values (2, 7);
insert into personality_user (id_user, id_personality)values (2, 8);
insert into personality_user (id_user, id_personality)values (2, 22);
insert into personality_user (id_user, id_personality)values (2, 25);
insert into personality_user (id_user, id_personality)values (2, 26);
insert into personality_user (id_user, id_personality)values (2, 27);
insert into personality_user (id_user, id_personality)values (2, 28);

insert into personality_user (id_user, id_personality)values (3, 1);
insert into personality_user (id_user, id_personality)values (3, 2);
insert into personality_user (id_user, id_personality)values (3, 3);
insert into personality_user (id_user, id_personality)values (3, 7);
insert into personality_user (id_user, id_personality)values (3, 9);
insert into personality_user (id_user, id_personality)values (3, 21);
insert into personality_user (id_user, id_personality)values (3, 22);
insert into personality_user (id_user, id_personality)values (3, 23);
insert into personality_user (id_user, id_personality)values (3, 27);
insert into personality_user (id_user, id_personality)values (3, 29);

insert into personality_user (id_user, id_personality)values (4, 13);
insert into personality_user (id_user, id_personality)values (4, 17);
insert into personality_user (id_user, id_personality)values (4, 18);
insert into personality_user (id_user, id_personality)values (4, 19);
insert into personality_user (id_user, id_personality)values (4, 20);
insert into personality_user (id_user, id_personality)values (4, 33);
insert into personality_user (id_user, id_personality)values (4, 37);
insert into personality_user (id_user, id_personality)values (4, 38);
insert into personality_user (id_user, id_personality)values (4, 39);
insert into personality_user (id_user, id_personality)values (4, 40);

insert into personality_user (id_user, id_personality)values (5, 10);
insert into personality_user (id_user, id_personality)values (5, 11);
insert into personality_user (id_user, id_personality)values (5, 14);
insert into personality_user (id_user, id_personality)values (5, 15);
insert into personality_user (id_user, id_personality)values (5, 4);
insert into personality_user (id_user, id_personality)values (5, 30);
insert into personality_user (id_user, id_personality)values (5, 31);
insert into personality_user (id_user, id_personality)values (5, 34);
insert into personality_user (id_user, id_personality)values (5, 35);
insert into personality_user (id_user, id_personality)values (5, 24);

insert into personality_user (id_user, id_personality)values (6, 15);
insert into personality_user (id_user, id_personality)values (6, 2);
insert into personality_user (id_user, id_personality)values (6, 3);
insert into personality_user (id_user, id_personality)values (6, 12);
insert into personality_user (id_user, id_personality)values (6, 19);
insert into personality_user (id_user, id_personality)values (6, 35);
insert into personality_user (id_user, id_personality)values (6, 22);
insert into personality_user (id_user, id_personality)values (6, 23);
insert into personality_user (id_user, id_personality)values (6, 32);
insert into personality_user (id_user, id_personality)values (6, 39);

insert into personality_user (id_user, id_personality)values (7, 9);
insert into personality_user (id_user, id_personality)values (7, 6);
insert into personality_user (id_user, id_personality)values (7, 11);
insert into personality_user (id_user, id_personality)values (7, 20);
insert into personality_user (id_user, id_personality)values (7, 12);
insert into personality_user (id_user, id_personality)values (7, 29);
insert into personality_user (id_user, id_personality)values (7, 26);
insert into personality_user (id_user, id_personality)values (7, 31);
insert into personality_user (id_user, id_personality)values (7, 40);
insert into personality_user (id_user, id_personality)values (7, 32);

insert into personality_user (id_user, id_personality)values (8, 10);
insert into personality_user (id_user, id_personality)values (8, 18);
insert into personality_user (id_user, id_personality)values (8, 11);
insert into personality_user (id_user, id_personality)values (8, 7);
insert into personality_user (id_user, id_personality)values (8, 17);
insert into personality_user (id_user, id_personality)values (8, 30);
insert into personality_user (id_user, id_personality)values (8, 38);
insert into personality_user (id_user, id_personality)values (8, 31);
insert into personality_user (id_user, id_personality)values (8, 27);
insert into personality_user (id_user, id_personality)values (8, 37);

insert into personality_user (id_user, id_personality)values (9, 1);
insert into personality_user (id_user, id_personality)values (9, 5);
insert into personality_user (id_user, id_personality)values (9, 15);
insert into personality_user (id_user, id_personality)values (9, 10);
insert into personality_user (id_user, id_personality)values (9, 20);
insert into personality_user (id_user, id_personality)values (9, 21);
insert into personality_user (id_user, id_personality)values (9, 25);
insert into personality_user (id_user, id_personality)values (9, 35);
insert into personality_user (id_user, id_personality)values (9, 30);
insert into personality_user (id_user, id_personality)values (9, 40);

insert into personality_user (id_user, id_personality)values (10, 10);
insert into personality_user (id_user, id_personality)values (10, 2);
insert into personality_user (id_user, id_personality)values (10, 3);
insert into personality_user (id_user, id_personality)values (10, 13);
insert into personality_user (id_user, id_personality)values (10, 17);
insert into personality_user (id_user, id_personality)values (10, 30);
insert into personality_user (id_user, id_personality)values (10, 22);
insert into personality_user (id_user, id_personality)values (10, 23);
insert into personality_user (id_user, id_personality)values (10, 33);
insert into personality_user (id_user, id_personality)values (10, 37);

insert into personality_user (id_user, id_personality)values (11, 1);
insert into personality_user (id_user, id_personality)values (11, 3);
insert into personality_user (id_user, id_personality)values (11, 8);
insert into personality_user (id_user, id_personality)values (11, 10);
insert into personality_user (id_user, id_personality)values (11, 12);
insert into personality_user (id_user, id_personality)values (11, 21);
insert into personality_user (id_user, id_personality)values (11, 23);
insert into personality_user (id_user, id_personality)values (11, 28);
insert into personality_user (id_user, id_personality)values (11, 30);
insert into personality_user (id_user, id_personality)values (11, 32);

insert into personality_user (id_user, id_personality)values (12, 2);
insert into personality_user (id_user, id_personality)values (12, 5);
insert into personality_user (id_user, id_personality)values (12, 6);
insert into personality_user (id_user, id_personality)values (12, 7);
insert into personality_user (id_user, id_personality)values (12, 8);
insert into personality_user (id_user, id_personality)values (12, 22);
insert into personality_user (id_user, id_personality)values (12, 25);
insert into personality_user (id_user, id_personality)values (12, 26);
insert into personality_user (id_user, id_personality)values (12, 27);
insert into personality_user (id_user, id_personality)values (12, 28);

insert into personality_user (id_user, id_personality)values (13, 1);
insert into personality_user (id_user, id_personality)values (13, 2);
insert into personality_user (id_user, id_personality)values (13, 3);
insert into personality_user (id_user, id_personality)values (13, 7);
insert into personality_user (id_user, id_personality)values (13, 9);
insert into personality_user (id_user, id_personality)values (13, 21);
insert into personality_user (id_user, id_personality)values (13, 22);
insert into personality_user (id_user, id_personality)values (13, 23);
insert into personality_user (id_user, id_personality)values (13, 27);
insert into personality_user (id_user, id_personality)values (13, 29);

insert into personality_user (id_user, id_personality)values (14, 13);
insert into personality_user (id_user, id_personality)values (14, 17);
insert into personality_user (id_user, id_personality)values (14, 18);
insert into personality_user (id_user, id_personality)values (14, 19);
insert into personality_user (id_user, id_personality)values (14, 20);
insert into personality_user (id_user, id_personality)values (14, 33);
insert into personality_user (id_user, id_personality)values (14, 37);
insert into personality_user (id_user, id_personality)values (14, 38);
insert into personality_user (id_user, id_personality)values (14, 39);
insert into personality_user (id_user, id_personality)values (14, 40);

insert into personality_user (id_user, id_personality)values (15, 10);
insert into personality_user (id_user, id_personality)values (15, 11);
insert into personality_user (id_user, id_personality)values (15, 14);
insert into personality_user (id_user, id_personality)values (15, 15);
insert into personality_user (id_user, id_personality)values (15, 4);
insert into personality_user (id_user, id_personality)values (15, 30);
insert into personality_user (id_user, id_personality)values (15, 31);
insert into personality_user (id_user, id_personality)values (15, 34);
insert into personality_user (id_user, id_personality)values (15, 35);
insert into personality_user (id_user, id_personality)values (15, 24);

insert into personality_user (id_user, id_personality)values (16, 15);
insert into personality_user (id_user, id_personality)values (16, 2);
insert into personality_user (id_user, id_personality)values (16, 3);
insert into personality_user (id_user, id_personality)values (16, 12);
insert into personality_user (id_user, id_personality)values (16, 19);
insert into personality_user (id_user, id_personality)values (16, 35);
insert into personality_user (id_user, id_personality)values (16, 22);
insert into personality_user (id_user, id_personality)values (16, 23);
insert into personality_user (id_user, id_personality)values (16, 32);
insert into personality_user (id_user, id_personality)values (16, 39);

insert into personality_user (id_user, id_personality)values (17, 9);
insert into personality_user (id_user, id_personality)values (17, 6);
insert into personality_user (id_user, id_personality)values (17, 11);
insert into personality_user (id_user, id_personality)values (17, 20);
insert into personality_user (id_user, id_personality)values (17, 12);
insert into personality_user (id_user, id_personality)values (17, 29);
insert into personality_user (id_user, id_personality)values (17, 26);
insert into personality_user (id_user, id_personality)values (17, 31);
insert into personality_user (id_user, id_personality)values (17, 40);
insert into personality_user (id_user, id_personality)values (17, 32);

insert into personality_user (id_user, id_personality)values (18, 10);
insert into personality_user (id_user, id_personality)values (18, 18);
insert into personality_user (id_user, id_personality)values (18, 11);
insert into personality_user (id_user, id_personality)values (18, 7);
insert into personality_user (id_user, id_personality)values (18, 17);
insert into personality_user (id_user, id_personality)values (18, 30);
insert into personality_user (id_user, id_personality)values (18, 38);
insert into personality_user (id_user, id_personality)values (18, 31);
insert into personality_user (id_user, id_personality)values (18, 27);
insert into personality_user (id_user, id_personality)values (18, 37);

insert into personality_user (id_user, id_personality)values (19, 1);
insert into personality_user (id_user, id_personality)values (19, 5);
insert into personality_user (id_user, id_personality)values (19, 15);
insert into personality_user (id_user, id_personality)values (19, 10);
insert into personality_user (id_user, id_personality)values (19, 20);
insert into personality_user (id_user, id_personality)values (19, 21);
insert into personality_user (id_user, id_personality)values (19, 25);
insert into personality_user (id_user, id_personality)values (19, 35);
insert into personality_user (id_user, id_personality)values (19, 30);
insert into personality_user (id_user, id_personality)values (19, 40);

insert into personality_user (id_user, id_personality)values (20, 10);
insert into personality_user (id_user, id_personality)values (20, 2);
insert into personality_user (id_user, id_personality)values (20, 3);
insert into personality_user (id_user, id_personality)values (20, 13);
insert into personality_user (id_user, id_personality)values (20, 17);
insert into personality_user (id_user, id_personality)values (20, 30);
insert into personality_user (id_user, id_personality)values (20, 22);
insert into personality_user (id_user, id_personality)values (20, 23);
insert into personality_user (id_user, id_personality)values (20, 33);
insert into personality_user (id_user, id_personality)values (20, 37);

insert into hobby_user values (1, 1, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.', '2020-01-02 11-22-22', '2020-01-02 11-22-22');
insert into hobby_user values (1, 2, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.', '2020-01-02 11-22-22', '2020-01-02 11-22-22');
insert into hobby_user values (1, 3, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.', '2020-01-02 11-22-22', '2020-01-02 11-22-22');
insert into hobby_user values (1, 4, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.', '2020-01-02 11-22-22', '2020-01-02 11-22-22');
insert into hobby_user values (1, 15, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.', '2020-01-02 11-22-22', '2020-01-02 11-22-22');

insert into hobby_user values (2, 9, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.', '2020-01-02 11-22-22', '2020-01-02 11-22-22');
insert into hobby_user values (2, 12, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.', '2020-01-02 11-22-22', '2020-01-02 11-22-22');
insert into hobby_user values (2, 6, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.', '2020-01-02 11-22-22', '2020-01-02 11-22-22');
insert into hobby_user values (2, 7, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.', '2020-01-02 11-22-22', '2020-01-02 11-22-22');
insert into hobby_user values (2, 2, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.', '2020-01-02 11-22-22', '2020-01-02 11-22-22');

insert into hobby_user values (3, 14, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.', '2020-01-02 11-22-22', '2020-01-02 11-22-22');
insert into hobby_user values (3, 12, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.', '2020-01-02 11-22-22', '2020-01-02 11-22-22');
insert into hobby_user values (3, 13, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.', '2020-01-02 11-22-22', '2020-01-02 11-22-22');
insert into hobby_user values (3, 3, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.', '2020-01-02 11-22-22', '2020-01-02 11-22-22');
insert into hobby_user values (3, 1, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.', '2020-01-02 11-22-22', '2020-01-02 11-22-22');

insert into hobby_user values (4, 4, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.', '2020-01-02 11-22-22', '2020-01-02 11-22-22');
insert into hobby_user values (4, 5, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.', '2020-01-02 11-22-22', '2020-01-02 11-22-22');
insert into hobby_user values (4, 6, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.', '2020-01-02 11-22-22', '2020-01-02 11-22-22');
insert into hobby_user values (4, 7, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.', '2020-01-02 11-22-22', '2020-01-02 11-22-22');
insert into hobby_user values (4, 8, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.', '2020-01-02 11-22-22', '2020-01-02 11-22-22');

insert into hobby_user values (5, 7, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.', '2020-01-02 11-22-22', '2020-01-02 11-22-22');
insert into hobby_user values (5, 8, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.', '2020-01-02 11-22-22', '2020-01-02 11-22-22');
insert into hobby_user values (5, 9, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.', '2020-01-02 11-22-22', '2020-01-02 11-22-22');
insert into hobby_user values (5, 11, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.', '2020-01-02 11-22-22', '2020-01-02 11-22-22');
insert into hobby_user values (5, 12, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.', '2020-01-02 11-22-22', '2020-01-02 11-22-22');

insert into hobby_user values (6, 2, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.', '2020-01-02 11-22-22', '2020-01-02 11-22-22');
insert into hobby_user values (6, 12, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.', '2020-01-02 11-22-22', '2020-01-02 11-22-22');
insert into hobby_user values (6, 13, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.', '2020-01-02 11-22-22', '2020-01-02 11-22-22');
insert into hobby_user values (6, 14, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.', '2020-01-02 11-22-22', '2020-01-02 11-22-22');
insert into hobby_user values (6, 15, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.', '2020-01-02 11-22-22', '2020-01-02 11-22-22');

insert into hobby_user values (7, 7, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.', '2020-01-02 11-22-22', '2020-01-02 11-22-22');
insert into hobby_user values (7, 8, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.', '2020-01-02 11-22-22', '2020-01-02 11-22-22');
insert into hobby_user values (7, 4, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.', '2020-01-02 11-22-22', '2020-01-02 11-22-22');
insert into hobby_user values (7, 12, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.', '2020-01-02 11-22-22', '2020-01-02 11-22-22');
insert into hobby_user values (7, 11, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.', '2020-01-02 11-22-22', '2020-01-02 11-22-22');

insert into hobby_user values (8, 2, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.', '2020-01-02 11-22-22', '2020-01-02 11-22-22');
insert into hobby_user values (8, 7, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.', '2020-01-02 11-22-22', '2020-01-02 11-22-22');
insert into hobby_user values (8, 5, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.', '2020-01-02 11-22-22', '2020-01-02 11-22-22');
insert into hobby_user values (8, 8, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.', '2020-01-02 11-22-22', '2020-01-02 11-22-22');
insert into hobby_user values (8, 14, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.', '2020-01-02 11-22-22', '2020-01-02 11-22-22');

insert into hobby_user values (9, 3, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.', '2020-01-02 11-22-22', '2020-01-02 11-22-22');
insert into hobby_user values (9, 5, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.', '2020-01-02 11-22-22', '2020-01-02 11-22-22');
insert into hobby_user values (9, 7, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.', '2020-01-02 11-22-22', '2020-01-02 11-22-22');
insert into hobby_user values (9, 8, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.', '2020-01-02 11-22-22', '2020-01-02 11-22-22');
insert into hobby_user values (9, 11, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.', '2020-01-02 11-22-22', '2020-01-02 11-22-22');

insert into hobby_user values (10, 1, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.', '2020-01-02 11-22-22', '2020-01-02 11-22-22');
insert into hobby_user values (10, 2, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.', '2020-01-02 11-22-22', '2020-01-02 11-22-22');
insert into hobby_user values (10, 3, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.', '2020-01-02 11-22-22', '2020-01-02 11-22-22');
insert into hobby_user values (10, 6, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.', '2020-01-02 11-22-22', '2020-01-02 11-22-22');
insert into hobby_user values (10, 7, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.', '2020-01-02 11-22-22', '2020-01-02 11-22-22');

insert into hobby_user values (11, 1, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.', '2020-01-02 11-22-22', '2020-01-02 11-22-22');
insert into hobby_user values (11, 2, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.', '2020-01-02 11-22-22', '2020-01-02 11-22-22');
insert into hobby_user values (11, 3, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.', '2020-01-02 11-22-22', '2020-01-02 11-22-22');
insert into hobby_user values (11, 4, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.', '2020-01-02 11-22-22', '2020-01-02 11-22-22');
insert into hobby_user values (11, 15, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.', '2020-01-02 11-22-22', '2020-01-02 11-22-22');

insert into hobby_user values (12, 9, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.', '2020-01-02 11-22-22', '2020-01-02 11-22-22');
insert into hobby_user values (12, 12, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.', '2020-01-02 11-22-22', '2020-01-02 11-22-22');
insert into hobby_user values (12, 6, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.', '2020-01-02 11-22-22', '2020-01-02 11-22-22');
insert into hobby_user values (12, 7, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.', '2020-01-02 11-22-22', '2020-01-02 11-22-22');
insert into hobby_user values (12, 2, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.', '2020-01-02 11-22-22', '2020-01-02 11-22-22');

insert into hobby_user values (13, 14, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.', '2020-01-02 11-22-22', '2020-01-02 11-22-22');
insert into hobby_user values (13, 12, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.', '2020-01-02 11-22-22', '2020-01-02 11-22-22');
insert into hobby_user values (13, 13, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.', '2020-01-02 11-22-22', '2020-01-02 11-22-22');
insert into hobby_user values (13, 3, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.', '2020-01-02 11-22-22', '2020-01-02 11-22-22');
insert into hobby_user values (13, 1, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.', '2020-01-02 11-22-22', '2020-01-02 11-22-22');

insert into hobby_user values (14, 4, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.', '2020-01-02 11-22-22', '2020-01-02 11-22-22');
insert into hobby_user values (14, 5, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.', '2020-01-02 11-22-22', '2020-01-02 11-22-22');
insert into hobby_user values (14, 6, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.', '2020-01-02 11-22-22', '2020-01-02 11-22-22');
insert into hobby_user values (14, 7, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.', '2020-01-02 11-22-22', '2020-01-02 11-22-22');
insert into hobby_user values (14, 8, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.', '2020-01-02 11-22-22', '2020-01-02 11-22-22');

insert into hobby_user values (15, 7, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.', '2020-01-02 11-22-22', '2020-01-02 11-22-22');
insert into hobby_user values (15, 8, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.', '2020-01-02 11-22-22', '2020-01-02 11-22-22');
insert into hobby_user values (15, 9, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.', '2020-01-02 11-22-22', '2020-01-02 11-22-22');
insert into hobby_user values (15, 11, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.', '2020-01-02 11-22-22', '2020-01-02 11-22-22');
insert into hobby_user values (15, 12, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.', '2020-01-02 11-22-22', '2020-01-02 11-22-22');

insert into hobby_user values (16, 2, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.', '2020-01-02 11-22-22', '2020-01-02 11-22-22');
insert into hobby_user values (16, 12, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.', '2020-01-02 11-22-22', '2020-01-02 11-22-22');
insert into hobby_user values (16, 13, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.', '2020-01-02 11-22-22', '2020-01-02 11-22-22');
insert into hobby_user values (16, 14, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.', '2020-01-02 11-22-22', '2020-01-02 11-22-22');
insert into hobby_user values (16, 15, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.', '2020-01-02 11-22-22', '2020-01-02 11-22-22');

insert into hobby_user values (17, 7, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.', '2020-01-02 11-22-22', '2020-01-02 11-22-22');
insert into hobby_user values (17, 8, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.', '2020-01-02 11-22-22', '2020-01-02 11-22-22');
insert into hobby_user values (17, 4, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.', '2020-01-02 11-22-22', '2020-01-02 11-22-22');
insert into hobby_user values (17, 12, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.', '2020-01-02 11-22-22', '2020-01-02 11-22-22');
insert into hobby_user values (17, 11, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.', '2020-01-02 11-22-22', '2020-01-02 11-22-22');

insert into hobby_user values (18, 2, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.', '2020-01-02 11-22-22', '2020-01-02 11-22-22');
insert into hobby_user values (18, 7, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.', '2020-01-02 11-22-22', '2020-01-02 11-22-22');
insert into hobby_user values (18, 5, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.', '2020-01-02 11-22-22', '2020-01-02 11-22-22');
insert into hobby_user values (18, 8, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.', '2020-01-02 11-22-22', '2020-01-02 11-22-22');
insert into hobby_user values (18, 14, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.', '2020-01-02 11-22-22', '2020-01-02 11-22-22');

insert into hobby_user values (19, 3, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.', '2020-01-02 11-22-22', '2020-01-02 11-22-22');
insert into hobby_user values (19, 5, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.', '2020-01-02 11-22-22', '2020-01-02 11-22-22');
insert into hobby_user values (19, 7, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.', '2020-01-02 11-22-22', '2020-01-02 11-22-22');
insert into hobby_user values (19, 8, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.', '2020-01-02 11-22-22', '2020-01-02 11-22-22');
insert into hobby_user values (19, 11, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.', '2020-01-02 11-22-22', '2020-01-02 11-22-22');

insert into hobby_user values (20, 1, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.', '2020-01-02 11-22-22', '2020-01-02 11-22-22');
insert into hobby_user values (20, 2, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.', '2020-01-02 11-22-22', '2020-01-02 11-22-22');
insert into hobby_user values (20, 3, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.', '2020-01-02 11-22-22', '2020-01-02 11-22-22');
insert into hobby_user values (20, 6, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.', '2020-01-02 11-22-22', '2020-01-02 11-22-22');
insert into hobby_user values (20, 7, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.', '2020-01-02 11-22-22', '2020-01-02 11-22-22');



insert into room (id_user, title, description, address, postal_code, city, flatmates_masc, flatmates_fem, flat_size, preference_gender, status, min_age, max_age, room_type, room_size, bed_type, price, bills_included, deposit, deposit_ammount, availability_from, availability_until, min_stay, max_stay)
values(1,'¡Busco compañero/a de piso en A Coruña!', 'Morbi eget dui gravida, auctor quam eget, varius lorem. Suspendisse hendrerit sem sit amet orci tempor lobortis quis sit amet enim. Proin lobortis tristique risus, et lobortis lorem tempor in. Phasellus dignissim lacinia velit et dignissim. Donec nec pellentesque arcu. Maecenas malesuada sapien augue, ac lobortis nibh vestibulum dignissim. Nam semper suscipit velit a sodales. Praesent gravida ex nec massa viverra, vel cursus nisl tempor. Ut maximus rutrum sodales. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae.',
 'Santiago de la Iglesia, 8 1D', 15004, 'A Coruña', 0, 0, 80, 'any', 'working', 20, 32, 'private', 12, 'double', 200.00, false, false, null, current_date(), null, 3, null);

insert into room (id_user, title, description, address, postal_code, city, flatmates_masc, flatmates_fem, flat_size, preference_gender, status, min_age, max_age, room_type, room_size, bed_type, price, bills_included, deposit, deposit_ammount, availability_from, availability_until, min_stay, max_stay)
values(2,'¡Busco compañero/a de piso en A Coruña!', 'Morbi eget dui gravida, auctor quam eget, varius lorem. Suspendisse hendrerit sem sit amet orci tempor lobortis quis sit amet enim. Proin lobortis tristique risus, et lobortis lorem tempor in. Phasellus dignissim lacinia velit et dignissim. Donec nec pellentesque arcu. Maecenas malesuada sapien augue, ac lobortis nibh vestibulum dignissim. Nam semper suscipit velit a sodales. Praesent gravida ex nec massa viverra, vel cursus nisl tempor. Ut maximus rutrum sodales. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae.',
 'Avenida Finisterre 19, 4', 15004, 'A Coruña', 1, 0, 90, 'fem', 'any', 30, 40, 'private', 16, 'double', 300, true, true, 300, current_date(), null, 6, null);

insert into room (id_user, title, description, address, postal_code, city, flatmates_masc, flatmates_fem, flat_size, preference_gender, status, min_age, max_age, room_type, room_size, bed_type, price, bills_included, deposit, deposit_ammount, availability_from, availability_until, min_stay, max_stay)
values(3,'¡Busco compañero/a de piso en A Coruña!', 'Morbi eget dui gravida, auctor quam eget, varius lorem. Suspendisse hendrerit sem sit amet orci tempor lobortis quis sit amet enim. Proin lobortis tristique risus, et lobortis lorem tempor in. Phasellus dignissim lacinia velit et dignissim. Donec nec pellentesque arcu. Maecenas malesuada sapien augue, ac lobortis nibh vestibulum dignissim. Nam semper suscipit velit a sodales. Praesent gravida ex nec massa viverra, vel cursus nisl tempor. Ut maximus rutrum sodales. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae.',
'San Andres 36, 3', 15003, 'A Coruña', 0, 1, 70, 'masc', 'working', 20, 40, 'private', 10, 'individual', 220, true, true, 440, current_date(), null, 12, null);

insert into room (id_user, title, description, address, postal_code, city, flatmates_masc, flatmates_fem, flat_size, preference_gender, status, min_age, max_age, room_type, room_size, bed_type, price, bills_included, deposit, deposit_ammount, availability_from, availability_until, min_stay, max_stay)
values(4,'¡Busco compañero/a de piso en A Coruña!', 'Morbi eget dui gravida, auctor quam eget, varius lorem. Suspendisse hendrerit sem sit amet orci tempor lobortis quis sit amet enim. Proin lobortis tristique risus, et lobortis lorem tempor in. Phasellus dignissim lacinia velit et dignissim. Donec nec pellentesque arcu. Maecenas malesuada sapien augue, ac lobortis nibh vestibulum dignissim. Nam semper suscipit velit a sodales. Praesent gravida ex nec massa viverra, vel cursus nisl tempor. Ut maximus rutrum sodales. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae.',
'Zalaeta 27, 5 Izq', 15002, 'A Coruña', 1, 1, 90, 'fem', 'student', 22, 28, 'shared', 24, 'double', 200, true, true, 200, current_date(), 20220101, 6, null);

insert into room (id_user, title, description, address, postal_code, city, flatmates_masc, flatmates_fem, flat_size, preference_gender, status, min_age, max_age, room_type, room_size, bed_type, price, bills_included, deposit, deposit_ammount, availability_from, availability_until, min_stay, max_stay)
values(5,'¡Busco compañero/a de piso en A Coruña!', 'Morbi eget dui gravida, auctor quam eget, varius lorem. Suspendisse hendrerit sem sit amet orci tempor lobortis quis sit amet enim. Proin lobortis tristique risus, et lobortis lorem tempor in. Phasellus dignissim lacinia velit et dignissim. Donec nec pellentesque arcu. Maecenas malesuada sapien augue, ac lobortis nibh vestibulum dignissim. Nam semper suscipit velit a sodales. Praesent gravida ex nec massa viverra, vel cursus nisl tempor. Ut maximus rutrum sodales. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae.',
'Angeles 2, 1', 15001, 'A Coruña', 0, 0, 60, 'any', 'working', 18, 50,  'private', 14, 'double', 240, false, false, null, date_sub(current_date(), interval 3 month), null, 6, null);

select * from room;

insert into facility_room (id_room, id_facility) values (1, 1);
insert into facility_room (id_room, id_facility) values (1, 2);
insert into facility_room (id_room, id_facility)values (1, 6);
insert into facility_room (id_room, id_facility)values (1, 10);
insert into facility_room (id_room, id_facility)values (1, 12);
insert into facility_room (id_room, id_facility)values (1, 14);

insert into facility_room (id_room, id_facility)values (2, 1);
insert into facility_room (id_room, id_facility)values (2, 2);
insert into facility_room (id_room, id_facility)values (2, 7);
insert into facility_room (id_room, id_facility)values (2, 8);
insert into facility_room (id_room, id_facility)values (2, 13);
insert into facility_room (id_room, id_facility)values (2, 14);

insert into facility_room (id_room, id_facility)values (3, 1);
insert into facility_room (id_room, id_facility)values (3, 2);
insert into facility_room (id_room, id_facility)values (3, 6);
insert into facility_room (id_room, id_facility)values (3, 7);
insert into facility_room (id_room, id_facility)values (3, 8);
insert into facility_room (id_room, id_facility)values (3, 10);

insert into facility_room (id_room, id_facility)values (4, 1);
insert into facility_room (id_room, id_facility)values (4, 2);
insert into facility_room (id_room, id_facility)values (4, 5);
insert into facility_room (id_room, id_facility)values (4, 6);
insert into facility_room (id_room, id_facility)values (4, 7);
insert into facility_room (id_room, id_facility)values (4, 10);

insert into facility_room (id_room, id_facility)values (5, 1);
insert into facility_room (id_room, id_facility)values (5, 2);
insert into facility_room (id_room, id_facility)values (5, 3);
insert into facility_room (id_room, id_facility)values (5, 4);
insert into facility_room (id_room, id_facility)values (5, 12);
insert into facility_room (id_room, id_facility)values (5, 18);



insert into rule_user (id_user, id_rule)values (1, 1);
insert into rule_user (id_user, id_rule)values (1, 2);
insert into rule_user (id_user, id_rule)values (1, 3);
insert into rule_user (id_user, id_rule)values (1, 4);

insert into rule_user (id_user, id_rule)values (2, 1);
insert into rule_user (id_user, id_rule)values (2, 3);
insert into rule_user (id_user, id_rule)values (2, 4);
insert into rule_user (id_user, id_rule)values (2, 5);

insert into rule_user (id_user, id_rule)values (3, 3);
insert into rule_user (id_user, id_rule)values (3, 4);

insert into rule_user (id_user, id_rule)values (4, 1);
insert into rule_user (id_user, id_rule)values (4, 2);
insert into rule_user (id_user, id_rule)values (4, 3);
insert into rule_user (id_user, id_rule)values (4, 4);
insert into rule_user (id_user, id_rule)values (4, 5);

insert into rule_user (id_user, id_rule)values (5, 1);
insert into rule_user (id_user, id_rule)values (5, 4);
insert into rule_user (id_user, id_rule)values (5, 5);

insert into rule_user (id_user, id_rule)values (6, 2);
insert into rule_user (id_user, id_rule)values (6, 4);

insert into rule_user (id_user, id_rule)values (7, 1);
insert into rule_user (id_user, id_rule)values (7, 5);

insert into rule_user (id_user, id_rule)values (8, 5);

insert into rule_user (id_user, id_rule)values (9, 1);
insert into rule_user (id_user, id_rule)values (9, 2);

insert into rule_user (id_user, id_rule)values (10, 1);
insert into rule_user (id_user, id_rule)values (10, 2);
insert into rule_user (id_user, id_rule)values (10, 5);

insert into rule_user (id_user, id_rule)values (11, 1);
insert into rule_user (id_user, id_rule)values (11, 2);
insert into rule_user (id_user, id_rule)values (11, 3);
insert into rule_user (id_user, id_rule)values (11, 4);
insert into rule_user (id_user, id_rule)values (11, 5);

insert into rule_user (id_user, id_rule)values (12, 1);
insert into rule_user (id_user, id_rule)values (12, 2);
insert into rule_user (id_user, id_rule)values (12, 3);
insert into rule_user (id_user, id_rule)values (12, 5);

insert into rule_user (id_user, id_rule)values (13, 2);
insert into rule_user (id_user, id_rule)values (13, 3);
insert into rule_user (id_user, id_rule)values (13, 4);
insert into rule_user (id_user, id_rule)values (13, 5);

insert into rule_user (id_user, id_rule)values (14, 1);
insert into rule_user (id_user, id_rule)values (14, 3);
insert into rule_user (id_user, id_rule)values (14, 4);
insert into rule_user (id_user, id_rule)values (14, 5);

insert into rule_user (id_user, id_rule)values (15, 1);
insert into rule_user (id_user, id_rule)values (15, 4);
insert into rule_user (id_user, id_rule)values (15, 5);

insert into rule_user (id_user, id_rule)values (16, 1);

insert into rule_user (id_user, id_rule)values (17, 1);
insert into rule_user (id_user, id_rule)values (17, 2);
insert into rule_user (id_user, id_rule)values (17, 5);

insert into rule_user (id_user, id_rule)values (18, 3);
insert into rule_user (id_user, id_rule)values (18, 5);

insert into rule_user (id_user, id_rule)values (19, 1);
insert into rule_user (id_user, id_rule)values (19, 5);

insert into rule_user (id_user, id_rule)values (20, 2);
insert into rule_user (id_user, id_rule)values (20, 3);

insert into rule_room (id_room, id_rule)values (1, 1);
insert into rule_room (id_room, id_rule)values (1, 2);
insert into rule_room (id_room, id_rule)values (1, 3);
insert into rule_room (id_room, id_rule)values (1, 4);
insert into rule_room (id_room, id_rule)values (1, 5);

insert into rule_room (id_room, id_rule) values (2, 1);
insert into rule_room (id_room, id_rule)values (2, 2);
insert into rule_room (id_room, id_rule)values (2, 3);
insert into rule_room (id_room, id_rule)values (2, 4);
insert into rule_room (id_room, id_rule)values (2, 5);

insert into rule_room (id_room, id_rule)values (3, 1);
insert into rule_room (id_room, id_rule)values (3, 2);
insert into rule_room (id_room, id_rule)values (3, 3);
insert into rule_room (id_room, id_rule)values (3, 4);
insert into rule_room (id_room, id_rule)values (3, 5);

insert into rule_room (id_room, id_rule)values (4, 1);
insert into rule_room (id_room, id_rule)values (4, 2);
insert into rule_room (id_room, id_rule)values (4, 3);
insert into rule_room (id_room, id_rule)values (4, 4);
insert into rule_room (id_room, id_rule)values (4, 5);

insert into rule_room (id_room, id_rule)values (5, 1);
insert into rule_room (id_room, id_rule)values (5, 2);
insert into rule_room (id_room, id_rule)values (5, 3);
insert into rule_room (id_room, id_rule)values (5, 4);
insert into rule_room (id_room, id_rule)values (5, 5);



insert into rating (id_user_sends, id_user_gets, type, rate, comment)
values(1, 6, 'user', 4, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque mauris risus, mollis eu dui nec, iaculis lacinia leo. Suspendisse congue nulla in magna pretium, sit amet ornare orci vehicula. Vivamus neque metus, bibendum id tincidunt a, imperdiet at eros.');
insert into rating (id_user_sends, id_user_gets, type, rate, comment)
values(1, 12, 'user', 5, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque mauris risus, mollis eu dui nec, iaculis lacinia leo. Suspendisse congue nulla in magna pretium, sit amet ornare orci vehicula. Vivamus neque metus, bibendum id tincidunt a, imperdiet at eros.');
insert into rating (id_user_sends, id_user_gets, type, rate, comment)
values(1, 20, 'user', 3, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque mauris risus, mollis eu dui nec, iaculis lacinia leo. Suspendisse congue nulla in magna pretium, sit amet ornare orci vehicula. Vivamus neque metus, bibendum id tincidunt a, imperdiet at eros.');
insert into rating (id_user_sends, id_user_gets, type, rate, comment)
values(1, 7, 'user', 4, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque mauris risus, mollis eu dui nec, iaculis lacinia leo. Suspendisse congue nulla in magna pretium, sit amet ornare orci vehicula. Vivamus neque metus, bibendum id tincidunt a, imperdiet at eros.');
insert into rating (id_user_sends, id_user_gets, type, rate, comment)
values(1, 8, 'user', 5, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque mauris risus, mollis eu dui nec, iaculis lacinia leo. Suspendisse congue nulla in magna pretium, sit amet ornare orci vehicula. Vivamus neque metus, bibendum id tincidunt a, imperdiet at eros.');


insert into rating (id_user_sends, id_user_gets, type, rate, comment)
values(2, 9, 'user', 4, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque mauris risus, mollis eu dui nec, iaculis lacinia leo. Suspendisse congue nulla in magna pretium, sit amet ornare orci vehicula. Vivamus neque metus, bibendum id tincidunt a, imperdiet at eros.');
insert into rating (id_user_sends, id_user_gets, type, rate, comment)
values(2, 10, 'user', 4, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque mauris risus, mollis eu dui nec, iaculis lacinia leo. Suspendisse congue nulla in magna pretium, sit amet ornare orci vehicula. Vivamus neque metus, bibendum id tincidunt a, imperdiet at eros.');
insert into rating (id_user_sends, id_user_gets, type, rate, comment)
values(2, 11, 'user', 4, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque mauris risus, mollis eu dui nec, iaculis lacinia leo. Suspendisse congue nulla in magna pretium, sit amet ornare orci vehicula. Vivamus neque metus, bibendum id tincidunt a, imperdiet at eros.');
insert into rating (id_user_sends, id_user_gets, type, rate, comment)
values(2, 13, 'user', 4, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque mauris risus, mollis eu dui nec, iaculis lacinia leo. Suspendisse congue nulla in magna pretium, sit amet ornare orci vehicula. Vivamus neque metus, bibendum id tincidunt a, imperdiet at eros.');
insert into rating (id_user_sends, id_user_gets, type, rate, comment)
values(2, 14, 'user', 5, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque mauris risus, mollis eu dui nec, iaculis lacinia leo. Suspendisse congue nulla in magna pretium, sit amet ornare orci vehicula. Vivamus neque metus, bibendum id tincidunt a, imperdiet at eros.');



insert into rating (id_user_sends, id_user_gets, type, rate, comment)
values(3, 15, 'user', 5, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque mauris risus, mollis eu dui nec, iaculis lacinia leo. Suspendisse congue nulla in magna pretium, sit amet ornare orci vehicula. Vivamus neque metus, bibendum id tincidunt a, imperdiet at eros.');
insert into rating (id_user_sends, id_user_gets, type, rate, comment)
values(3, 16, 'user', 4, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque mauris risus, mollis eu dui nec, iaculis lacinia leo. Suspendisse congue nulla in magna pretium, sit amet ornare orci vehicula. Vivamus neque metus, bibendum id tincidunt a, imperdiet at eros.');
insert into rating (id_user_sends, id_user_gets, type, rate, comment)
values(3, 17, 'user', 4, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque mauris risus, mollis eu dui nec, iaculis lacinia leo. Suspendisse congue nulla in magna pretium, sit amet ornare orci vehicula. Vivamus neque metus, bibendum id tincidunt a, imperdiet at eros.');
insert into rating (id_user_sends, id_user_gets, type, rate, comment)
values(3, 18, 'user', 3, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque mauris risus, mollis eu dui nec, iaculis lacinia leo. Suspendisse congue nulla in magna pretium, sit amet ornare orci vehicula. Vivamus neque metus, bibendum id tincidunt a, imperdiet at eros.');
insert into rating (id_user_sends, id_user_gets, type, rate, comment)
values(3, 19, 'user', 4, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque mauris risus, mollis eu dui nec, iaculis lacinia leo. Suspendisse congue nulla in magna pretium, sit amet ornare orci vehicula. Vivamus neque metus, bibendum id tincidunt a, imperdiet at eros.');


insert into rating (id_user_sends, id_user_gets, type, rate, comment)
values(4, 9, 'user', 4, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque mauris risus, mollis eu dui nec, iaculis lacinia leo. Suspendisse congue nulla in magna pretium, sit amet ornare orci vehicula. Vivamus neque metus, bibendum id tincidunt a, imperdiet at eros.');
insert into rating (id_user_sends, id_user_gets, type, rate, comment)
values(4, 17, 'user', 5, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque mauris risus, mollis eu dui nec, iaculis lacinia leo. Suspendisse congue nulla in magna pretium, sit amet ornare orci vehicula. Vivamus neque metus, bibendum id tincidunt a, imperdiet at eros.');
insert into rating (id_user_sends, id_user_gets, type, rate, comment)
values(4, 12, 'user', 4, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque mauris risus, mollis eu dui nec, iaculis lacinia leo. Suspendisse congue nulla in magna pretium, sit amet ornare orci vehicula. Vivamus neque metus, bibendum id tincidunt a, imperdiet at eros.');
insert into rating (id_user_sends, id_user_gets, type, rate, comment)
values(4, 6, 'user', 4, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque mauris risus, mollis eu dui nec, iaculis lacinia leo. Suspendisse congue nulla in magna pretium, sit amet ornare orci vehicula. Vivamus neque metus, bibendum id tincidunt a, imperdiet at eros.');
insert into rating (id_user_sends, id_user_gets, type, rate, comment)
values(4, 5, 'user', 3, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque mauris risus, mollis eu dui nec, iaculis lacinia leo. Suspendisse congue nulla in magna pretium, sit amet ornare orci vehicula. Vivamus neque metus, bibendum id tincidunt a, imperdiet at eros.');


insert into rating (id_user_sends, id_user_gets, type, rate, comment)
values(5, 19, 'user', 3, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque mauris risus, mollis eu dui nec, iaculis lacinia leo. Suspendisse congue nulla in magna pretium, sit amet ornare orci vehicula. Vivamus neque metus, bibendum id tincidunt a, imperdiet at eros.');
insert into rating (id_user_sends, id_user_gets, type, rate, comment)
values(5, 13, 'user', 4, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque mauris risus, mollis eu dui nec, iaculis lacinia leo. Suspendisse congue nulla in magna pretium, sit amet ornare orci vehicula. Vivamus neque metus, bibendum id tincidunt a, imperdiet at eros.');
insert into rating (id_user_sends, id_user_gets, type, rate, comment)
values(5, 16, 'user', 5, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque mauris risus, mollis eu dui nec, iaculis lacinia leo. Suspendisse congue nulla in magna pretium, sit amet ornare orci vehicula. Vivamus neque metus, bibendum id tincidunt a, imperdiet at eros.');
insert into rating (id_user_sends, id_user_gets, type, rate, comment)
values(5, 8, 'user', 4, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque mauris risus, mollis eu dui nec, iaculis lacinia leo. Suspendisse congue nulla in magna pretium, sit amet ornare orci vehicula. Vivamus neque metus, bibendum id tincidunt a, imperdiet at eros.');
insert into rating (id_user_sends, id_user_gets, type, rate, comment)
values(5, 10, 'user', 4, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque mauris risus, mollis eu dui nec, iaculis lacinia leo. Suspendisse congue nulla in magna pretium, sit amet ornare orci vehicula. Vivamus neque metus, bibendum id tincidunt a, imperdiet at eros.');




insert into rating (id_user_sends, id_user_gets, type, rate, comment)
values(6, 1, 'user', 4, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque mauris risus, mollis eu dui nec, iaculis lacinia leo. Suspendisse congue nulla in magna pretium, sit amet ornare orci vehicula. Vivamus neque metus, bibendum id tincidunt a, imperdiet at eros.');
insert into rating (id_user_sends, id_user_gets, type, rate, comment)
values(12, 1, 'user', 5, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque mauris risus, mollis eu dui nec, iaculis lacinia leo. Suspendisse congue nulla in magna pretium, sit amet ornare orci vehicula. Vivamus neque metus, bibendum id tincidunt a, imperdiet at eros.');
insert into rating (id_user_sends, id_user_gets, type, rate, comment)
values(20, 1, 'user', 3, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque mauris risus, mollis eu dui nec, iaculis lacinia leo. Suspendisse congue nulla in magna pretium, sit amet ornare orci vehicula. Vivamus neque metus, bibendum id tincidunt a, imperdiet at eros.');
insert into rating (id_user_sends, id_user_gets, type, rate, comment)
values(7, 1, 'user', 4, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque mauris risus, mollis eu dui nec, iaculis lacinia leo. Suspendisse congue nulla in magna pretium, sit amet ornare orci vehicula. Vivamus neque metus, bibendum id tincidunt a, imperdiet at eros.');
insert into rating (id_user_sends, id_user_gets, type, rate, comment)
values(8, 1, 'user', 5, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque mauris risus, mollis eu dui nec, iaculis lacinia leo. Suspendisse congue nulla in magna pretium, sit amet ornare orci vehicula. Vivamus neque metus, bibendum id tincidunt a, imperdiet at eros.');


insert into rating (id_user_sends, id_user_gets, type, rate, comment)
values(9, 2, 'user', 4, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque mauris risus, mollis eu dui nec, iaculis lacinia leo. Suspendisse congue nulla in magna pretium, sit amet ornare orci vehicula. Vivamus neque metus, bibendum id tincidunt a, imperdiet at eros.');
insert into rating (id_user_sends, id_user_gets, type, rate, comment)
values(10, 2, 'user', 4, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque mauris risus, mollis eu dui nec, iaculis lacinia leo. Suspendisse congue nulla in magna pretium, sit amet ornare orci vehicula. Vivamus neque metus, bibendum id tincidunt a, imperdiet at eros.');
insert into rating (id_user_sends, id_user_gets, type, rate, comment)
values(11, 2, 'user', 4, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque mauris risus, mollis eu dui nec, iaculis lacinia leo. Suspendisse congue nulla in magna pretium, sit amet ornare orci vehicula. Vivamus neque metus, bibendum id tincidunt a, imperdiet at eros.');
insert into rating (id_user_sends, id_user_gets, type, rate, comment)
values(13, 2, 'user', 4, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque mauris risus, mollis eu dui nec, iaculis lacinia leo. Suspendisse congue nulla in magna pretium, sit amet ornare orci vehicula. Vivamus neque metus, bibendum id tincidunt a, imperdiet at eros.');
insert into rating (id_user_sends, id_user_gets, type, rate, comment)
values(14, 2, 'user', 5, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque mauris risus, mollis eu dui nec, iaculis lacinia leo. Suspendisse congue nulla in magna pretium, sit amet ornare orci vehicula. Vivamus neque metus, bibendum id tincidunt a, imperdiet at eros.');


insert into rating (id_user_sends, id_user_gets, type, rate, comment)
values(15, 3, 'user', 5, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque mauris risus, mollis eu dui nec, iaculis lacinia leo. Suspendisse congue nulla in magna pretium, sit amet ornare orci vehicula. Vivamus neque metus, bibendum id tincidunt a, imperdiet at eros.');
insert into rating (id_user_sends, id_user_gets, type, rate, comment)
values(16, 3, 'user', 4, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque mauris risus, mollis eu dui nec, iaculis lacinia leo. Suspendisse congue nulla in magna pretium, sit amet ornare orci vehicula. Vivamus neque metus, bibendum id tincidunt a, imperdiet at eros.');
insert into rating (id_user_sends, id_user_gets, type, rate, comment)
values(17, 3, 'user', 4, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque mauris risus, mollis eu dui nec, iaculis lacinia leo. Suspendisse congue nulla in magna pretium, sit amet ornare orci vehicula. Vivamus neque metus, bibendum id tincidunt a, imperdiet at eros.');
insert into rating (id_user_sends, id_user_gets, type, rate, comment)
values(18, 3, 'user', 3, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque mauris risus, mollis eu dui nec, iaculis lacinia leo. Suspendisse congue nulla in magna pretium, sit amet ornare orci vehicula. Vivamus neque metus, bibendum id tincidunt a, imperdiet at eros.');
insert into rating (id_user_sends, id_user_gets, type, rate, comment)
values(19, 3, 'user', 4, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque mauris risus, mollis eu dui nec, iaculis lacinia leo. Suspendisse congue nulla in magna pretium, sit amet ornare orci vehicula. Vivamus neque metus, bibendum id tincidunt a, imperdiet at eros.');


insert into rating (id_user_sends, id_user_gets, type, rate, comment)
values(9, 4, 'user', 4, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque mauris risus, mollis eu dui nec, iaculis lacinia leo. Suspendisse congue nulla in magna pretium, sit amet ornare orci vehicula. Vivamus neque metus, bibendum id tincidunt a, imperdiet at eros.');
insert into rating (id_user_sends, id_user_gets, type, rate, comment)
values(17, 4, 'user', 5, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque mauris risus, mollis eu dui nec, iaculis lacinia leo. Suspendisse congue nulla in magna pretium, sit amet ornare orci vehicula. Vivamus neque metus, bibendum id tincidunt a, imperdiet at eros.');
insert into rating (id_user_sends, id_user_gets, type, rate, comment)
values(12, 4, 'user', 4, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque mauris risus, mollis eu dui nec, iaculis lacinia leo. Suspendisse congue nulla in magna pretium, sit amet ornare orci vehicula. Vivamus neque metus, bibendum id tincidunt a, imperdiet at eros.');
insert into rating (id_user_sends, id_user_gets, type, rate, comment)
values(6, 4, 'user', 4, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque mauris risus, mollis eu dui nec, iaculis lacinia leo. Suspendisse congue nulla in magna pretium, sit amet ornare orci vehicula. Vivamus neque metus, bibendum id tincidunt a, imperdiet at eros.');
insert into rating (id_user_sends, id_user_gets, type, rate, comment)
values(5, 4, 'user', 3, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque mauris risus, mollis eu dui nec, iaculis lacinia leo. Suspendisse congue nulla in magna pretium, sit amet ornare orci vehicula. Vivamus neque metus, bibendum id tincidunt a, imperdiet at eros.');


insert into rating (id_user_sends, id_user_gets, type, rate, comment)
values(19, 5, 'user', 3, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque mauris risus, mollis eu dui nec, iaculis lacinia leo. Suspendisse congue nulla in magna pretium, sit amet ornare orci vehicula. Vivamus neque metus, bibendum id tincidunt a, imperdiet at eros.');
insert into rating (id_user_sends, id_user_gets, type, rate, comment)
values(13, 5, 'user', 4, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque mauris risus, mollis eu dui nec, iaculis lacinia leo. Suspendisse congue nulla in magna pretium, sit amet ornare orci vehicula. Vivamus neque metus, bibendum id tincidunt a, imperdiet at eros.');
insert into rating (id_user_sends, id_user_gets, type, rate, comment)
values(16, 5, 'user', 5, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque mauris risus, mollis eu dui nec, iaculis lacinia leo. Suspendisse congue nulla in magna pretium, sit amet ornare orci vehicula. Vivamus neque metus, bibendum id tincidunt a, imperdiet at eros.');
insert into rating (id_user_sends, id_user_gets, type, rate, comment)
values(8, 5, 'user', 4, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque mauris risus, mollis eu dui nec, iaculis lacinia leo. Suspendisse congue nulla in magna pretium, sit amet ornare orci vehicula. Vivamus neque metus, bibendum id tincidunt a, imperdiet at eros.');
insert into rating (id_user_sends, id_user_gets, type, rate, comment)
values(10, 5, 'user', 4, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque mauris risus, mollis eu dui nec, iaculis lacinia leo. Suspendisse congue nulla in magna pretium, sit amet ornare orci vehicula. Vivamus neque metus, bibendum id tincidunt a, imperdiet at eros.');


insert into rating (id_user_sends, id_room_gets, type, rate, comment)
values(6, 1, 'room', 4, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque mauris risus, mollis eu dui nec, iaculis lacinia leo. Suspendisse congue nulla in magna pretium, sit amet ornare orci vehicula. Vivamus neque metus, bibendum id tincidunt a, imperdiet at eros.');
insert into rating (id_user_sends, id_room_gets, type, rate, comment)
values(12, 1, 'room', 5, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque mauris risus, mollis eu dui nec, iaculis lacinia leo. Suspendisse congue nulla in magna pretium, sit amet ornare orci vehicula. Vivamus neque metus, bibendum id tincidunt a, imperdiet at eros.');
insert into rating (id_user_sends, id_room_gets, type, rate, comment)
values(20, 1, 'room', 3, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque mauris risus, mollis eu dui nec, iaculis lacinia leo. Suspendisse congue nulla in magna pretium, sit amet ornare orci vehicula. Vivamus neque metus, bibendum id tincidunt a, imperdiet at eros.');
insert into rating (id_user_sends, id_room_gets, type, rate, comment)
values(7, 1, 'room', 4, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque mauris risus, mollis eu dui nec, iaculis lacinia leo. Suspendisse congue nulla in magna pretium, sit amet ornare orci vehicula. Vivamus neque metus, bibendum id tincidunt a, imperdiet at eros.');
insert into rating (id_user_sends, id_room_gets, type, rate, comment)
values(8, 1, 'room', 5, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque mauris risus, mollis eu dui nec, iaculis lacinia leo. Suspendisse congue nulla in magna pretium, sit amet ornare orci vehicula. Vivamus neque metus, bibendum id tincidunt a, imperdiet at eros.');


insert into rating (id_user_sends, id_room_gets, type, rate, comment)
values(9, 2, 'room', 4, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque mauris risus, mollis eu dui nec, iaculis lacinia leo. Suspendisse congue nulla in magna pretium, sit amet ornare orci vehicula. Vivamus neque metus, bibendum id tincidunt a, imperdiet at eros.');
insert into rating (id_user_sends, id_room_gets, type, rate, comment)
values(10, 2, 'room', 4, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque mauris risus, mollis eu dui nec, iaculis lacinia leo. Suspendisse congue nulla in magna pretium, sit amet ornare orci vehicula. Vivamus neque metus, bibendum id tincidunt a, imperdiet at eros.');
insert into rating (id_user_sends, id_room_gets, type, rate, comment)
values(11, 2, 'room', 4, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque mauris risus, mollis eu dui nec, iaculis lacinia leo. Suspendisse congue nulla in magna pretium, sit amet ornare orci vehicula. Vivamus neque metus, bibendum id tincidunt a, imperdiet at eros.');
insert into rating (id_user_sends, id_room_gets, type, rate, comment)
values(13, 2, 'room', 4, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque mauris risus, mollis eu dui nec, iaculis lacinia leo. Suspendisse congue nulla in magna pretium, sit amet ornare orci vehicula. Vivamus neque metus, bibendum id tincidunt a, imperdiet at eros.');
insert into rating (id_user_sends, id_room_gets, type, rate, comment)
values(14, 2, 'room', 5, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque mauris risus, mollis eu dui nec, iaculis lacinia leo. Suspendisse congue nulla in magna pretium, sit amet ornare orci vehicula. Vivamus neque metus, bibendum id tincidunt a, imperdiet at eros.');



insert into rating (id_user_sends, id_room_gets, type, rate, comment)
values(9, 3, 'room', 4, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque mauris risus, mollis eu dui nec, iaculis lacinia leo. Suspendisse congue nulla in magna pretium, sit amet ornare orci vehicula. Vivamus neque metus, bibendum id tincidunt a, imperdiet at eros.');
insert into rating (id_user_sends, id_room_gets, type, rate, comment)
values(17, 3, 'room', 5, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque mauris risus, mollis eu dui nec, iaculis lacinia leo. Suspendisse congue nulla in magna pretium, sit amet ornare orci vehicula. Vivamus neque metus, bibendum id tincidunt a, imperdiet at eros.');
insert into rating (id_user_sends, id_room_gets, type, rate, comment)
values(12, 3, 'room', 4, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque mauris risus, mollis eu dui nec, iaculis lacinia leo. Suspendisse congue nulla in magna pretium, sit amet ornare orci vehicula. Vivamus neque metus, bibendum id tincidunt a, imperdiet at eros.');
insert into rating (id_user_sends, id_room_gets, type, rate, comment)
values(6, 3, 'room', 4, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque mauris risus, mollis eu dui nec, iaculis lacinia leo. Suspendisse congue nulla in magna pretium, sit amet ornare orci vehicula. Vivamus neque metus, bibendum id tincidunt a, imperdiet at eros.');
insert into rating (id_user_sends, id_room_gets, type, rate, comment)
values(5, 3, 'room', 3, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque mauris risus, mollis eu dui nec, iaculis lacinia leo. Suspendisse congue nulla in magna pretium, sit amet ornare orci vehicula. Vivamus neque metus, bibendum id tincidunt a, imperdiet at eros.');


insert into rating (id_user_sends, id_room_gets, type, rate, comment)
values(19, 4, 'room', 3, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque mauris risus, mollis eu dui nec, iaculis lacinia leo. Suspendisse congue nulla in magna pretium, sit amet ornare orci vehicula. Vivamus neque metus, bibendum id tincidunt a, imperdiet at eros.');
insert into rating (id_user_sends, id_room_gets, type, rate, comment)
values(13, 4, 'room', 5, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque mauris risus, mollis eu dui nec, iaculis lacinia leo. Suspendisse congue nulla in magna pretium, sit amet ornare orci vehicula. Vivamus neque metus, bibendum id tincidunt a, imperdiet at eros.');
insert into rating (id_user_sends, id_room_gets, type, rate, comment)
values(16, 4, 'room', 3, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque mauris risus, mollis eu dui nec, iaculis lacinia leo. Suspendisse congue nulla in magna pretium, sit amet ornare orci vehicula. Vivamus neque metus, bibendum id tincidunt a, imperdiet at eros.');
insert into rating (id_user_sends, id_room_gets, type, rate, comment)
values(8, 4, 'room', 4, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque mauris risus, mollis eu dui nec, iaculis lacinia leo. Suspendisse congue nulla in magna pretium, sit amet ornare orci vehicula. Vivamus neque metus, bibendum id tincidunt a, imperdiet at eros.');
insert into rating (id_user_sends, id_room_gets, type, rate, comment)
values(10, 4, 'room', 5, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque mauris risus, mollis eu dui nec, iaculis lacinia leo. Suspendisse congue nulla in magna pretium, sit amet ornare orci vehicula. Vivamus neque metus, bibendum id tincidunt a, imperdiet at eros.');

insert into rating (id_user_sends, id_room_gets, type, rate, comment)
values(11, 5, 'room', 4, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque mauris risus, mollis eu dui nec, iaculis lacinia leo. Suspendisse congue nulla in magna pretium, sit amet ornare orci vehicula. Vivamus neque metus, bibendum id tincidunt a, imperdiet at eros.');
insert into rating (id_user_sends, id_room_gets, type, rate, comment)
values(9, 5, 'room', 5, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque mauris risus, mollis eu dui nec, iaculis lacinia leo. Suspendisse congue nulla in magna pretium, sit amet ornare orci vehicula. Vivamus neque metus, bibendum id tincidunt a, imperdiet at eros.');
insert into rating (id_user_sends, id_room_gets, type, rate, comment)
values(8, 5, 'room', 4, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque mauris risus, mollis eu dui nec, iaculis lacinia leo. Suspendisse congue nulla in magna pretium, sit amet ornare orci vehicula. Vivamus neque metus, bibendum id tincidunt a, imperdiet at eros.');
insert into rating (id_user_sends, id_room_gets, type, rate, comment)
values(12, 5, 'room', 5, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque mauris risus, mollis eu dui nec, iaculis lacinia leo. Suspendisse congue nulla in magna pretium, sit amet ornare orci vehicula. Vivamus neque metus, bibendum id tincidunt a, imperdiet at eros.');
insert into rating (id_user_sends, id_room_gets, type, rate, comment)
values(6, 5, 'room', 5, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque mauris risus, mollis eu dui nec, iaculis lacinia leo. Suspendisse congue nulla in magna pretium, sit amet ornare orci vehicula. Vivamus neque metus, bibendum id tincidunt a, imperdiet at eros.');


insert into booking(id_user, id_user_owner, type, status)values(6, 5, 'demand', 'pending');

insert into booking(id_user, id_user_owner, type, status)values(10, 4, 'demand','pending'); 
insert into booking(id_user, id_user_owner, type, status)values(11, 4, 'demand','pending'); 

insert into booking(id_user, id_user_owner, type, status)values(6, 3, 'demand','pending'); 
insert into booking(id_user, id_user_owner, type, status)values(7, 3, 'demand','pending'); 

insert into booking(id_user, id_user_owner, type, status)values(12, 2, 'demand','pending'); 
insert into booking(id_user, id_user_owner, type, status)values(20, 2, 'demand','pending'); 

insert into booking(id_user, id_user_owner, type, status)values(9, 1, 'demand','pending'); 
insert into booking(id_user, id_user_owner, type, status)values(7, 1, 'demand','pending'); 
insert into booking(id_user, id_user_owner, type, status)values(11, 1, 'demand','pending'); 


insert into booking(id_user, id_user_owner, type, status)values(11, 1, 'demand','cancelled'); 
insert into booking(id_user, id_user_owner, type, status)values(11, 7, 'demand','cancelled'); 

insert into booking(id_user, id_user_owner, type, status)values(12, 12, 'demand','cancelled'); 

insert into booking(id_user, id_user_owner, type, status, start_date, finish_date)values(6, 1, 'demand','accepted', '2020-03-01', '2020-09-01'); 
insert into booking(id_user, id_user_owner, type, status, start_date, finish_date)values(12, 1, 'demand','accepted', '2020-03-01', null); 
insert into booking(id_user, id_user_owner, type, status, start_date, finish_date)values(20, 1, 'demand','accepted', '2020-03-01', null); 
insert into booking(id_user, id_user_owner, type, status, start_date, finish_date)values(7, 1, 'demand','accepted', '2020-03-01', null); 
insert into booking(id_user, id_user_owner, type, status, start_date, finish_date)values(8, 1, 'demand','accepted', '2020-03-01', null); 

insert into booking(id_user, id_user_owner, type, status, start_date, finish_date)values(9, 2, 'demand','accepted', '2018-03-01', '2020-06-01'); 
insert into booking(id_user, id_user_owner, type, status, start_date, finish_date)values(10, 2, 'demand','accepted', '2020-03-01', null); 
insert into booking(id_user, id_user_owner, type, status, start_date, finish_date)values(11, 2, 'demand','accepted', '2019-03-01', '2020-08-01');
insert into booking(id_user, id_user_owner, type, status, start_date, finish_date)values(13, 2, 'demand','accepted', '2020-03-01', null);
insert into booking(id_user, id_user_owner, type, status, start_date, finish_date)values(14, 2, 'demand','accepted', '2019-11-01', '2020-09-01');


insert into booking(id_user, id_user_owner, type, status, start_date, finish_date)values(15, 3, 'demand','accepted', '2020-02-01', '2020-06-01'); 
insert into booking(id_user, id_user_owner, type, status, start_date, finish_date)values(16, 3, 'demand','accepted', '2020-01-01', null); 
insert into booking(id_user, id_user_owner, type, status, start_date, finish_date)values(17, 3, 'demand','accepted', '2020-02-01', '2020-08-01');
insert into booking(id_user, id_user_owner, type, status, start_date, finish_date)values(18, 3, 'demand','accepted', '2020-01-01', null);
insert into booking(id_user, id_user_owner, type, status, start_date, finish_date)values(19, 3, 'demand','accepted', '2020-02-01', '2020-09-01');

insert into booking(id_user, id_user_owner, type, status, start_date, finish_date)values(5, 4, 'demand','accepted', '2020-02-01', '2020-06-01'); 
insert into booking(id_user, id_user_owner, type, status, start_date, finish_date)values(6, 4, 'demand','accepted', '2020-02-01', null); 
insert into booking(id_user, id_user_owner, type, status, start_date, finish_date)values(9, 4, 'demand','accepted', '2020-02-01', '2020-08-01');
insert into booking(id_user, id_user_owner, type, status, start_date, finish_date)values(12, 4, 'demand','accepted', '2020-02-01', null);
insert into booking(id_user, id_user_owner, type, status, start_date, finish_date)values(17, 4, 'demand','accepted', '2019-12-01', '2020-09-01');


insert into booking(id_user, id_user_owner, type, status, start_date, finish_date)values(8, 5, 'demand','accepted', '2020-02-01', '2020-06-01'); 
insert into booking(id_user, id_user_owner, type, status, start_date, finish_date)values(10, 5, 'demand','accepted', '2020-02-01', null); 
insert into booking(id_user, id_user_owner, type, status, start_date, finish_date)values(13, 5, 'demand','accepted', '2020-02-01', '2020-08-01');
insert into booking(id_user, id_user_owner, type, status, start_date, finish_date)values(16, 5, 'demand','accepted', '2020-02-01', null);
insert into booking(id_user, id_user_owner, type, status, start_date, finish_date)values(19, 5, 'demand','accepted', '2019-12-01', '2020-09-01');