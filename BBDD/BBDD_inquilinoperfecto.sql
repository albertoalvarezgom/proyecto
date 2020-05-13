SET SQL_SAFE_UPDATES = 0;
-- drop database inquilino_perfecto;
create database inquilino_perfecto;
use inquilino_perfecto;

create table user (
id_user int primary key auto_increment,
first_name varchar(100) not null,
birthday date not null,
email varchar(100) not null,
password varchar(100) not null,
creation_date datetime not null,
last_update datetime not null,
role enum('normal', 'admin') not null default 'normal',
gender varchar(20),
occupation_field varchar(100),
occupation_status enum('working', 'studying', 'both'),
couple boolean default false,
ig_profile varchar(50),
image_1 varchar(600),
image_2 varchar(600),
image_3 varchar(600),
image_4 varchar(600),
image_5 varchar(600),
hidden boolean default false
);

create table personality (
id_personality int primary key auto_increment,
name varchar(100) not null,
type enum ('feature', 'lifestyle')
);

create table personality_user (
id_user int not null,
id_personality int not null,
primary key (id_user, id_personality),
constraint FK_user_personality foreign key(id_user) references user (id_user),
constraint FK_personality_user foreign key(id_personality) references personality (id_personality),
creation_date datetime not null
);

create table hobby (
id_hobby int primary key auto_increment,
name varchar(100) not null
);

create table hobby_user (
id_user int not null,
id_hobby int not null,
description text not null,
primary key(id_user, id_hobby),
constraint FK_user_hobby foreign key (id_user) references user(id_user),
constraint FK_hobby_user foreign key (id_hobby) references hobby(id_hobby),
creation_date datetime not null,
last_update datetime not null
);

create table room (
id_room int primary key auto_increment,
id_user int not null,
constraint FK_user_room foreign key (id_user) references user(id_user),
title text not null,
description text not null,
address text not null,
postal_code int not null,
city varchar(100) not null,
flatmates_masc int not null default 0,
flatmates_fem int not null default 0,
flat_size int not null,
preference_gender varchar(20) not null,
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
max_stay int,
image_1 varchar(600) not null,
image_2 varchar(600),
image_3 varchar(600),
image_4 varchar(600),
image_5 varchar(600),
hidden boolean default false,
views int,
creation_date datetime not null,
last_update datetime
);

create table facility (
id_facility int primary key auto_increment,
name varchar(100) not null
);

create table facility_room (
id_room int not null,
id_facility int not null,
primary key(id_room, id_facility),
constraint FK_room_facility foreign key(id_room) references room (id_room),
constraint FK_facility_room foreign key(id_facility) references facility (id_facility),
creation_date datetime not null
);

create table rule (
id_rule int primary key auto_increment,
name varchar(100) not null
);

create table rule_user (
id_user int not null,
id_rule int not null,
primary key(id_user, id_rule),
constraint FK_user_rule foreign key(id_user) references user (id_user),
constraint FK_rule_user foreign key(id_rule) references rule (id_rule),
creation_date datetime not null
);

create table rule_room (
id_room int not null,
id_rule int not null,
primary key(id_room, id_rule),
constraint FK_room_rule foreign key(id_room) references room (id_room),
constraint FK_rule_room foreign key(id_rule) references rule (id_rule),
creation_date datetime not null
);

create table rating (
id_rating int primary key auto_increment,
id_user_sends int not null,
id_user_gets int,
id_room_gets int,
type enum ('room', 'user') not null,
rate int check (rate between 1 and 5),
constraint FK_user_sends foreign key (id_user_sends) references user(id_user),
constraint FK_user_gets foreign key (id_user_gets) references user(id_user),
constraint FK_room_gets foreign key (id_room_gets) references room(id_room),
creation_date datetime not null
);

create table booking(
id_booking int primary key auto_increment,
id_user int not null,
id_user_owner int not null,
type enum ('offer', 'demand'),
constraint FK_user_booking foreign key (id_user) references user (id_user),
constraint FK_user_owner foreign key (id_user_owner) references user (id_user),
status enum ('pending', 'cancelled', 'accepted') default 'pending',
creation_date datetime not null,
start_date date,
finish_date date
);

insert into user values (1, 'Sara', '1990-07-06', 'femenine', 'Enfermera', 'working', true, 'sara.marinho@gmail.com', 'sarasara123', null, '@sara', 'https://unsplash.com/photos/mEZ3PoFGs_k', null, null, null, null, false, '2020-01-02 11-22-22','2020-01-04 12-42-23');
insert into user values (2, 'Pedro', '1989-03-12', 'masculine', 'Ingeniero', 'working', false, 'pedro.ramallo@gmail.com', 'pedropedro123', null, '@pedro', 'https://unsplash.com/photos/NDCy2-9JhUs', null, null, null, null,false, '2020-01-02 11-22-22','2020-01-04 12-42-23');
insert into user values (3, 'Brais', '1987-10-08', 'masculine', 'Consultor', 'working', true, 'brais.moldes@gmail.com', 'braisbrais123', null, '@brais', 'https://unsplash.com/photos/NDCy2-9JhUs', null, null, null, null, false,'2020-01-02 11-22-22','2020-01-04 12-42-23');
insert into user values (4, 'Andrea', '1988-11-01', 'femenine', 'Investigadora', 'both', true, 'andrea.fernandez@gmail.com', 'andreaandrea123',null, '@andrea', 'https://unsplash.com/photos/mEZ3PoFGs_k', null, null, null, null,false, '2020-01-02 11-22-22','2020-01-04 12-42-23');
insert into user values (5, 'Xabier', '1991-12-22', 'masculine', 'Diseñador grafico', 'working', false, 'xabi.cambeiro@gmail.com', 'xabixabi123', null, '@xabier', 'https://unsplash.com/photos/NDCy2-9JhUs', null, null, null, null, false,'2020-01-02 11-22-22','2020-01-04 12-42-23');
insert into user values (6, 'Lara', '1992-02-07', 'femenine', 'Finanzas', 'both', false, 'lara.seoane@gmail.com', 'laralara123', null, '@lara', 'https://unsplash.com/photos/mEZ3PoFGs_k', null, null, null, null, false,'2020-01-02 11-22-22','2020-01-04 12-42-23');
insert into user values (7, 'Ruben', '1994-12-03', 'masculine', 'Departamento de ventas', 'studying', true, 'ruben.arias@gmail.com', 'rubenruben123', null, '@ruben', 'https://unsplash.com/photos/NDCy2-9JhUs', null, null, null, null, false,'2020-01-02 11-22-22','2020-01-04 12-42-23');
insert into user values (8, 'Alex', '1996-08-30', 'femenine', 'Logistica', 'studying', false, 'alex.lopez@gmail.com', 'alexalex123', null, '@alex', 'https://unsplash.com/photos/mEZ3PoFGs_k', null, null, null, null, false,'2020-01-02 11-22-22','2020-01-04 12-42-23');
insert into user values (9, 'Diego', '1990-11-01', 'masculine', 'Abogado', 'studying', false, 'diego.muros@gmail.com', 'diegodiego123', null, '@diego', 'https://unsplash.com/photos/NDCy2-9JhUs', null, null, null, null,false, '2020-01-02 11-22-22','2020-01-04 12-42-23');
insert into user values (10, 'Mara', '1992-04-12', 'femenine', 'Turismo', 'working', true, 'mara.carballo@gmail.com', 'maramara123', null, '@mara', 'https://unsplash.com/photos/mEZ3PoFGs_k', null, null, null, null, false,'2020-01-02 11-22-22','2020-01-04 12-42-23');
insert into user values (11, 'Tomas', '1996-05-07', 'masculine', 'Departamento de comunicacion', 'studying', true, 'tomas.hervas@gmail.com', 'tomastomas123', null, '@tomas', 'https://unsplash.com/photos/NDCy2-9JhUs', null, null, null, null,false, '2020-01-02 11-22-22','2020-01-04 12-42-23');
insert into user values (12, 'Uxia', '2000-02-10', 'femenine', 'Educacion', 'both', false, 'uxia.rodriguez@gmail.com', 'uxiauxia123', null, '@uxia', 'https://unsplash.com/photos/mEZ3PoFGs_k', null, null, null, null, false,'2020-01-02 11-22-22','2020-01-04 12-42-23');
insert into user values (13, 'Marcos', '1999-09-09', 'masculine', 'Educacion', 'studying', false, 'marcos.blanco@gmail.com', 'marcosmarcos123', null, '@marcos', 'https://unsplash.com/photos/NDCy2-9JhUs', null, null, null, null, false,'2020-01-02 11-22-22','2020-01-04 12-42-23');
insert into user values (14, 'Carmen', '1997-12-02', 'femenine', 'Fotografa', 'working', true, 'carmen.camaño@gmail.com', 'carmencarmen123', null, '@carmen', 'https://unsplash.com/photos/mEZ3PoFGs_k', null, null, null, null, false,'2020-01-02 11-22-22','2020-01-04 12-42-23');
insert into user values (15, 'Roi', '1990-05-01', 'masculine', 'Artista 3D', 'both', false, 'roi.cal@gmail.com', 'roiroi123', null, '@roi', 'https://unsplash.com/photos/NDCy2-9JhUs', null, null, null, null, false,'2020-01-02 11-22-22','2020-01-04 12-42-23');
insert into user values (16, 'Ines', '1995-06-11', 'femenine', 'Abodaga', 'studying', false, 'ines.barros@gmail.com', 'inesines123', null, '@ines', 'https://unsplash.com/photos/mEZ3PoFGs_k', null, null, null, null, false,'2020-01-02 11-22-22','2020-01-04 12-42-23');
insert into user values (17, 'Berto', '1989-02-02', 'masculine', 'Educacion', 'working', true, 'berto.novo@gmail.com', 'bertoberto123', null, '@berto', 'https://unsplash.com/photos/NDCy2-9JhUs', null, null, null, null, false,'2020-01-02 11-22-22','2020-01-04 12-42-23');
insert into user values (18, 'Alba', '1999-10-05', 'femenine', 'Servicio tecnico', 'both', false, 'alba.iglesias@gmail.com', 'albaalba123', null, '@alba', 'https://unsplash.com/photos/mEZ3PoFGs_k', null, null, null, null, false,'2020-01-02 11-22-22','2020-01-04 12-42-23');
insert into user values (19, 'David', '2000-11-02', 'masculine', 'Finanzas', 'studying', true, 'david.casas@gmail.com', 'daviddavid123', null, '@david', 'https://unsplash.com/photos/NDCy2-9JhUs', null, null, null, null, false,'2020-01-02 11-22-22','2020-01-04 12-42-23');
insert into user values (20, 'Antia', '2001-01-22', 'femenine', 'Investigadora', 'working', false, 'antia.mato@gmail.com', 'antiaantia123', null, '@antia', 'https://unsplash.com/photos/mEZ3PoFGs_k', null, null, null, null, false,'2020-01-02 11-22-22','2020-01-04 12-42-23');

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

insert into personality_user values (1, 1, '2020-01-02 11-22-22');
insert into personality_user values (1, 3, '2020-01-02 11-22-22');
insert into personality_user values (1, 8, '2020-01-02 11-22-22');
insert into personality_user values (1, 10, '2020-01-02 11-22-22');
insert into personality_user values (1, 12, '2020-01-02 11-22-22');
insert into personality_user values (1, 21, '2020-01-02 11-22-22');
insert into personality_user values (1, 23, '2020-01-02 11-22-22');
insert into personality_user values (1, 28, '2020-01-02 11-22-22');
insert into personality_user values (1, 30, '2020-01-02 11-22-22');
insert into personality_user values (1, 32, '2020-01-02 11-22-22');

insert into personality_user values (2, 2, '2020-01-02 11-22-22');
insert into personality_user values (2, 5, '2020-01-02 11-22-22');
insert into personality_user values (2, 6, '2020-01-02 11-22-22');
insert into personality_user values (2, 7, '2020-01-02 11-22-22');
insert into personality_user values (2, 8, '2020-01-02 11-22-22');
insert into personality_user values (2, 22, '2020-01-02 11-22-22');
insert into personality_user values (2, 25, '2020-01-02 11-22-22');
insert into personality_user values (2, 26, '2020-01-02 11-22-22');
insert into personality_user values (2, 27, '2020-01-02 11-22-22');
insert into personality_user values (2, 28, '2020-01-02 11-22-22');

insert into personality_user values (3, 1, '2020-01-02 11-22-22');
insert into personality_user values (3, 2, '2020-01-02 11-22-22');
insert into personality_user values (3, 3, '2020-01-02 11-22-22');
insert into personality_user values (3, 7, '2020-01-02 11-22-22');
insert into personality_user values (3, 9, '2020-01-02 11-22-22');
insert into personality_user values (3, 21, '2020-01-02 11-22-22');
insert into personality_user values (3, 22, '2020-01-02 11-22-22');
insert into personality_user values (3, 23, '2020-01-02 11-22-22');
insert into personality_user values (3, 27, '2020-01-02 11-22-22');
insert into personality_user values (3, 29, '2020-01-02 11-22-22');

insert into personality_user values (4, 13, '2020-01-02 11-22-22');
insert into personality_user values (4, 17, '2020-01-02 11-22-22');
insert into personality_user values (4, 18, '2020-01-02 11-22-22');
insert into personality_user values (4, 19, '2020-01-02 11-22-22');
insert into personality_user values (4, 20, '2020-01-02 11-22-22');
insert into personality_user values (4, 33, '2020-01-02 11-22-22');
insert into personality_user values (4, 37, '2020-01-02 11-22-22');
insert into personality_user values (4, 38, '2020-01-02 11-22-22');
insert into personality_user values (4, 39, '2020-01-02 11-22-22');
insert into personality_user values (4, 40, '2020-01-02 11-22-22');

insert into personality_user values (5, 10, '2020-01-02 11-22-22');
insert into personality_user values (5, 11, '2020-01-02 11-22-22');
insert into personality_user values (5, 14, '2020-01-02 11-22-22');
insert into personality_user values (5, 15, '2020-01-02 11-22-22');
insert into personality_user values (5, 4, '2020-01-02 11-22-22');
insert into personality_user values (5, 30, '2020-01-02 11-22-22');
insert into personality_user values (5, 31, '2020-01-02 11-22-22');
insert into personality_user values (5, 34, '2020-01-02 11-22-22');
insert into personality_user values (5, 35, '2020-01-02 11-22-22');
insert into personality_user values (5, 24, '2020-01-02 11-22-22');

insert into personality_user values (6, 15, '2020-01-02 11-22-22');
insert into personality_user values (6, 2, '2020-01-02 11-22-22');
insert into personality_user values (6, 3, '2020-01-02 11-22-22');
insert into personality_user values (6, 12, '2020-01-02 11-22-22');
insert into personality_user values (6, 19, '2020-01-02 11-22-22');
insert into personality_user values (6, 35, '2020-01-02 11-22-22');
insert into personality_user values (6, 22, '2020-01-02 11-22-22');
insert into personality_user values (6, 23, '2020-01-02 11-22-22');
insert into personality_user values (6, 32, '2020-01-02 11-22-22');
insert into personality_user values (6, 39, '2020-01-02 11-22-22');

insert into personality_user values (7, 9, '2020-01-02 11-22-22');
insert into personality_user values (7, 6, '2020-01-02 11-22-22');
insert into personality_user values (7, 11, '2020-01-02 11-22-22');
insert into personality_user values (7, 20, '2020-01-02 11-22-22');
insert into personality_user values (7, 12, '2020-01-02 11-22-22');
insert into personality_user values (7, 29, '2020-01-02 11-22-22');
insert into personality_user values (7, 26, '2020-01-02 11-22-22');
insert into personality_user values (7, 31, '2020-01-02 11-22-22');
insert into personality_user values (7, 40, '2020-01-02 11-22-22');
insert into personality_user values (7, 32, '2020-01-02 11-22-22');

insert into personality_user values (8, 10, '2020-01-02 11-22-22');
insert into personality_user values (8, 18, '2020-01-02 11-22-22');
insert into personality_user values (8, 11, '2020-01-02 11-22-22');
insert into personality_user values (8, 7, '2020-01-02 11-22-22');
insert into personality_user values (8, 17, '2020-01-02 11-22-22');
insert into personality_user values (8, 30, '2020-01-02 11-22-22');
insert into personality_user values (8, 38, '2020-01-02 11-22-22');
insert into personality_user values (8, 31, '2020-01-02 11-22-22');
insert into personality_user values (8, 27, '2020-01-02 11-22-22');
insert into personality_user values (8, 37, '2020-01-02 11-22-22');

insert into personality_user values (9, 1, '2020-01-02 11-22-22');
insert into personality_user values (9, 5, '2020-01-02 11-22-22');
insert into personality_user values (9, 15, '2020-01-02 11-22-22');
insert into personality_user values (9, 10, '2020-01-02 11-22-22');
insert into personality_user values (9, 20, '2020-01-02 11-22-22');
insert into personality_user values (9, 21, '2020-01-02 11-22-22');
insert into personality_user values (9, 25, '2020-01-02 11-22-22');
insert into personality_user values (9, 35, '2020-01-02 11-22-22');
insert into personality_user values (9, 30, '2020-01-02 11-22-22');
insert into personality_user values (9, 40, '2020-01-02 11-22-22');

insert into personality_user values (10, 10, '2020-01-02 11-22-22');
insert into personality_user values (10, 2, '2020-01-02 11-22-22');
insert into personality_user values (10, 3, '2020-01-02 11-22-22');
insert into personality_user values (10, 13, '2020-01-02 11-22-22');
insert into personality_user values (10, 17, '2020-01-02 11-22-22');
insert into personality_user values (10, 30, '2020-01-02 11-22-22');
insert into personality_user values (10, 22, '2020-01-02 11-22-22');
insert into personality_user values (10, 23, '2020-01-02 11-22-22');
insert into personality_user values (10, 33, '2020-01-02 11-22-22');
insert into personality_user values (10, 37, '2020-01-02 11-22-22');

insert into personality_user values (11, 1, '2020-01-02 11-22-22');
insert into personality_user values (11, 3, '2020-01-02 11-22-22');
insert into personality_user values (11, 8, '2020-01-02 11-22-22');
insert into personality_user values (11, 10, '2020-01-02 11-22-22');
insert into personality_user values (11, 12, '2020-01-02 11-22-22');
insert into personality_user values (11, 21, '2020-01-02 11-22-22');
insert into personality_user values (11, 23, '2020-01-02 11-22-22');
insert into personality_user values (11, 28, '2020-01-02 11-22-22');
insert into personality_user values (11, 30, '2020-01-02 11-22-22');
insert into personality_user values (11, 32, '2020-01-02 11-22-22');

insert into personality_user values (12, 2, '2020-01-02 11-22-22');
insert into personality_user values (12, 5, '2020-01-02 11-22-22');
insert into personality_user values (12, 6, '2020-01-02 11-22-22');
insert into personality_user values (12, 7, '2020-01-02 11-22-22');
insert into personality_user values (12, 8, '2020-01-02 11-22-22');
insert into personality_user values (12, 22, '2020-01-02 11-22-22');
insert into personality_user values (12, 25, '2020-01-02 11-22-22');
insert into personality_user values (12, 26, '2020-01-02 11-22-22');
insert into personality_user values (12, 27, '2020-01-02 11-22-22');
insert into personality_user values (12, 28, '2020-01-02 11-22-22');

insert into personality_user values (13, 1, '2020-01-02 11-22-22');
insert into personality_user values (13, 2, '2020-01-02 11-22-22');
insert into personality_user values (13, 3, '2020-01-02 11-22-22');
insert into personality_user values (13, 7, '2020-01-02 11-22-22');
insert into personality_user values (13, 9, '2020-01-02 11-22-22');
insert into personality_user values (13, 21, '2020-01-02 11-22-22');
insert into personality_user values (13, 22, '2020-01-02 11-22-22');
insert into personality_user values (13, 23, '2020-01-02 11-22-22');
insert into personality_user values (13, 27, '2020-01-02 11-22-22');
insert into personality_user values (13, 29, '2020-01-02 11-22-22');

insert into personality_user values (14, 13, '2020-01-02 11-22-22');
insert into personality_user values (14, 17, '2020-01-02 11-22-22');
insert into personality_user values (14, 18, '2020-01-02 11-22-22');
insert into personality_user values (14, 19, '2020-01-02 11-22-22');
insert into personality_user values (14, 20, '2020-01-02 11-22-22');
insert into personality_user values (14, 33, '2020-01-02 11-22-22');
insert into personality_user values (14, 37, '2020-01-02 11-22-22');
insert into personality_user values (14, 38, '2020-01-02 11-22-22');
insert into personality_user values (14, 39, '2020-01-02 11-22-22');
insert into personality_user values (14, 40, '2020-01-02 11-22-22');

insert into personality_user values (15, 10, '2020-01-02 11-22-22');
insert into personality_user values (15, 11, '2020-01-02 11-22-22');
insert into personality_user values (15, 14, '2020-01-02 11-22-22');
insert into personality_user values (15, 15, '2020-01-02 11-22-22');
insert into personality_user values (15, 4, '2020-01-02 11-22-22');
insert into personality_user values (15, 30, '2020-01-02 11-22-22');
insert into personality_user values (15, 31, '2020-01-02 11-22-22');
insert into personality_user values (15, 34, '2020-01-02 11-22-22');
insert into personality_user values (15, 35, '2020-01-02 11-22-22');
insert into personality_user values (15, 24, '2020-01-02 11-22-22');

insert into personality_user values (16, 15, '2020-01-02 11-22-22');
insert into personality_user values (16, 2, '2020-01-02 11-22-22');
insert into personality_user values (16, 3, '2020-01-02 11-22-22');
insert into personality_user values (16, 12, '2020-01-02 11-22-22');
insert into personality_user values (16, 19, '2020-01-02 11-22-22');
insert into personality_user values (16, 35, '2020-01-02 11-22-22');
insert into personality_user values (16, 22, '2020-01-02 11-22-22');
insert into personality_user values (16, 23, '2020-01-02 11-22-22');
insert into personality_user values (16, 32, '2020-01-02 11-22-22');
insert into personality_user values (16, 39, '2020-01-02 11-22-22');

insert into personality_user values (17, 9, '2020-01-02 11-22-22');
insert into personality_user values (17, 6, '2020-01-02 11-22-22');
insert into personality_user values (17, 11, '2020-01-02 11-22-22');
insert into personality_user values ( 17, 20, '2020-01-02 11-22-22');
insert into personality_user values (17, 12, '2020-01-02 11-22-22');
insert into personality_user values (17, 29, '2020-01-02 11-22-22');
insert into personality_user values (17, 26, '2020-01-02 11-22-22');
insert into personality_user values (17, 31, '2020-01-02 11-22-22');
insert into personality_user values ( 17, 40, '2020-01-02 11-22-22');
insert into personality_user values (17, 32, '2020-01-02 11-22-22');

insert into personality_user values (18, 10, '2020-01-02 11-22-22');
insert into personality_user values (18, 18, '2020-01-02 11-22-22');
insert into personality_user values (18, 11, '2020-01-02 11-22-22');
insert into personality_user values (18, 7, '2020-01-02 11-22-22');
insert into personality_user values (18, 17, '2020-01-02 11-22-22');
insert into personality_user values (18, 30, '2020-01-02 11-22-22');
insert into personality_user values (18, 38, '2020-01-02 11-22-22');
insert into personality_user values (18, 31, '2020-01-02 11-22-22');
insert into personality_user values (18, 27, '2020-01-02 11-22-22');
insert into personality_user values (18, 37, '2020-01-02 11-22-22');

insert into personality_user values (19, 1, '2020-01-02 11-22-22');
insert into personality_user values (19, 5, '2020-01-02 11-22-22');
insert into personality_user values (19, 15, '2020-01-02 11-22-22');
insert into personality_user values (19, 10, '2020-01-02 11-22-22');
insert into personality_user values (19, 20, '2020-01-02 11-22-22');
insert into personality_user values (19, 21, '2020-01-02 11-22-22');
insert into personality_user values (19, 25, '2020-01-02 11-22-22');
insert into personality_user values (19, 35, '2020-01-02 11-22-22');
insert into personality_user values (19, 30, '2020-01-02 11-22-22');
insert into personality_user values (19, 40, '2020-01-02 11-22-22');

insert into personality_user values (20, 10, '2020-01-02 11-22-22');
insert into personality_user values (20, 2, '2020-01-02 11-22-22');
insert into personality_user values (20, 3, '2020-01-02 11-22-22');
insert into personality_user values (20, 13, '2020-01-02 11-22-22');
insert into personality_user values (20, 17, '2020-01-02 11-22-22');
insert into personality_user values (20, 30, '2020-01-02 11-22-22');
insert into personality_user values (20, 22, '2020-01-02 11-22-22');
insert into personality_user values (20, 23, '2020-01-02 11-22-22');
insert into personality_user values (20, 33, '2020-01-02 11-22-22');
insert into personality_user values (20, 37, '2020-01-02 11-22-22');

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

insert into room values (1, 1, 
'¡Busco compañero/a de piso en A Coruña!', 'Morbi eget dui gravida, auctor quam eget, varius lorem. Suspendisse hendrerit sem sit amet orci tempor lobortis quis sit amet enim. Proin lobortis tristique risus, et lobortis lorem tempor in. Phasellus dignissim lacinia velit et dignissim. Donec nec pellentesque arcu. Maecenas malesuada sapien augue, ac lobortis nibh vestibulum dignissim. Nam semper suscipit velit a sodales. Praesent gravida ex nec massa viverra, vel cursus nisl tempor. Ut maximus rutrum sodales. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae.',
'Santiago de la Iglesia, 8 1D', 15004, 'A Coruña', 0, 0, 80, 'any', 'working', 20, 32, 'private', 12, 'double', 200.00, false, false, null, current_date(), null, 3, null,
'https://unsplash.com/photos/DhFHtkECn7Q', null, null, null, null, false, 22, '2020-01-02 11-22-22','2020-02-04 12-42-23', '2020-08-01 11-22-22', null);
insert into room values (2, 2, 
'¡Busco compañero/a de piso en A Coruña!', 'Morbi eget dui gravida, auctor quam eget, varius lorem. Suspendisse hendrerit sem sit amet orci tempor lobortis quis sit amet enim. Proin lobortis tristique risus, et lobortis lorem tempor in. Phasellus dignissim lacinia velit et dignissim. Donec nec pellentesque arcu. Maecenas malesuada sapien augue, ac lobortis nibh vestibulum dignissim. Nam semper suscipit velit a sodales. Praesent gravida ex nec massa viverra, vel cursus nisl tempor. Ut maximus rutrum sodales. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae.',
'Avenida Finisterre 19, 4', 15004, 'A Coruña', 1, 0, 90, 'femenine', 'any', 30, 40, 'private', 16, 'double', 300, true, true, 300, current_date(), null, 6, null,
'https://unsplash.com/photos/DhFHtkECn7Q', null, null, null, null, false, 35, '2020-01-02 11-22-22','2020-01-04 12-42-23', '2020-08-01 11-22-22', '2021-12-02 11-22-22');
insert into room values (3, 3, 
'¡Busco compañero/a de piso en A Coruña!', 'Morbi eget dui gravida, auctor quam eget, varius lorem. Suspendisse hendrerit sem sit amet orci tempor lobortis quis sit amet enim. Proin lobortis tristique risus, et lobortis lorem tempor in. Phasellus dignissim lacinia velit et dignissim. Donec nec pellentesque arcu. Maecenas malesuada sapien augue, ac lobortis nibh vestibulum dignissim. Nam semper suscipit velit a sodales. Praesent gravida ex nec massa viverra, vel cursus nisl tempor. Ut maximus rutrum sodales. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae.',
'San Andres 36, 3', 15003, 'A Coruña', 0, 1, 70, 'masculine', 'working', 20, 40, 'private', 10, 'individual', 220, true, true, 440, current_date(), null, 12, null,
'https://unsplash.com/photos/DhFHtkECn7Q', null, null, null, null, false, 44, '2020-01-02 11-22-22','2020-01-04 12-42-23', '2020-09-01 11-22-22', null);
insert into room values (4, 4, 
'¡Busco compañero/a de piso en A Coruña!', 'Morbi eget dui gravida, auctor quam eget, varius lorem. Suspendisse hendrerit sem sit amet orci tempor lobortis quis sit amet enim. Proin lobortis tristique risus, et lobortis lorem tempor in. Phasellus dignissim lacinia velit et dignissim. Donec nec pellentesque arcu. Maecenas malesuada sapien augue, ac lobortis nibh vestibulum dignissim. Nam semper suscipit velit a sodales. Praesent gravida ex nec massa viverra, vel cursus nisl tempor. Ut maximus rutrum sodales. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae.',
'Zalaeta 27, 5 Izq', 15002, 'A Coruña', 1, 1, 90, 'femenine', 'student', 22, 28, 'shared', 24, 'double', 200, true, true, 200, current_date(), 20220101, 6, null,
'https://unsplash.com/photos/DhFHtkECn7Q', null, null, null, null, false, 12, '2020-01-02 11-22-22','2020-01-04 12-42-23', '2020-08-01 11-22-22', null);
insert into room values (5, 5, 
'¡Busco compañero/a de piso en A Coruña!', 'Morbi eget dui gravida, auctor quam eget, varius lorem. Suspendisse hendrerit sem sit amet orci tempor lobortis quis sit amet enim. Proin lobortis tristique risus, et lobortis lorem tempor in. Phasellus dignissim lacinia velit et dignissim. Donec nec pellentesque arcu. Maecenas malesuada sapien augue, ac lobortis nibh vestibulum dignissim. Nam semper suscipit velit a sodales. Praesent gravida ex nec massa viverra, vel cursus nisl tempor. Ut maximus rutrum sodales. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae.',
'Angeles 2, 1', 15001, 'A Coruña', 0, 0, 60, 'any', 'working', 18, 50,  'private', 14, 'double', 240, false, false, null, date_sub(current_date(), interval 3 month), null, 6, null,
'https://unsplash.com/photos/DhFHtkECn7Q', null, null, null, null, false, 9, '2020-01-02 11-22-22','2020-01-04 12-42-23', '2020-08-01 11-22-22', '2022-08-01 11-22-22');

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

insert into facility_room values (1, 1, '2020-01-02 11-22-22');
insert into facility_room values (1, 2, '2020-01-02 11-22-22');
insert into facility_room values (1, 6, '2020-01-02 11-22-22');
insert into facility_room values (1, 10, '2020-01-02 11-22-22');
insert into facility_room values (1, 12, '2020-01-02 11-22-22');
insert into facility_room values (1, 14, '2020-01-02 11-22-22');

insert into facility_room values (2, 1, '2020-01-02 11-22-22');
insert into facility_room values (2, 2, '2020-01-02 11-22-22');
insert into facility_room values (2, 7, '2020-01-02 11-22-22');
insert into facility_room values (2, 8, '2020-01-02 11-22-22');
insert into facility_room values (2, 13, '2020-01-02 11-22-22');
insert into facility_room values (2, 14, '2020-01-02 11-22-22');

insert into facility_room values (3, 1, '2020-01-02 11-22-22');
insert into facility_room values (3, 2, '2020-01-02 11-22-22');
insert into facility_room values (3, 6, '2020-01-02 11-22-22');
insert into facility_room values (3, 7, '2020-01-02 11-22-22');
insert into facility_room values (3, 8, '2020-01-02 11-22-22');
insert into facility_room values (3, 10, '2020-01-02 11-22-22');

insert into facility_room values (4, 1, '2020-01-02 11-22-22');
insert into facility_room values (4, 2, '2020-01-02 11-22-22');
insert into facility_room values (4, 5, '2020-01-02 11-22-22');
insert into facility_room values (4, 6, '2020-01-02 11-22-22');
insert into facility_room values (4, 7, '2020-01-02 11-22-22');
insert into facility_room values (4, 10, '2020-01-02 11-22-22');

insert into facility_room values (5, 1, '2020-01-02 11-22-22');
insert into facility_room values ( 5, 2, '2020-01-02 11-22-22');
insert into facility_room values (5, 3, '2020-01-02 11-22-22');
insert into facility_room values (5, 4, '2020-01-02 11-22-22');
insert into facility_room values (5, 12, '2020-01-02 11-22-22');
insert into facility_room values (5, 18, '2020-01-02 11-22-22');

insert into rule values (1, 'pets');
insert into rule values (2, 'smoking');
insert into rule values (3, 'vegetarian');
insert into rule values (4, 'allergies');
insert into rule values (5, 'couples');

insert into rule_user values (1, 1, '2020-01-02 11-22-22');
insert into rule_user values (1, 2, '2020-01-02 11-22-22');
insert into rule_user values (1, 3, '2020-01-02 11-22-22');
insert into rule_user values (1, 4, '2020-01-02 11-22-22');

insert into rule_user values (2, 1, '2020-01-02 11-22-22');
insert into rule_user values (2, 3, '2020-01-02 11-22-22');
insert into rule_user values (2, 4, '2020-01-02 11-22-22');
insert into rule_user values (2, 5, '2020-01-02 11-22-22');

insert into rule_user values (3, 3, '2020-01-02 11-22-22');
insert into rule_user values (3, 4, '2020-01-02 11-22-22');

insert into rule_user values (4, 1, '2020-01-02 11-22-22');
insert into rule_user values (4, 2, '2020-01-02 11-22-22');
insert into rule_user values (4, 3, '2020-01-02 11-22-22');
insert into rule_user values (4, 4, '2020-01-02 11-22-22');
insert into rule_user values (4, 5, '2020-01-02 11-22-22');

insert into rule_user values (5, 1, '2020-01-02 11-22-22');
insert into rule_user values (5, 4, '2020-01-02 11-22-22');
insert into rule_user values (5, 5, '2020-01-02 11-22-22');

insert into rule_user values (6, 2, '2020-01-02 11-22-22');
insert into rule_user values (6, 4, '2020-01-02 11-22-22');

insert into rule_user values (7, 1, '2020-01-02 11-22-22');
insert into rule_user values (7, 5, '2020-01-02 11-22-22');

insert into rule_user values (8, 5, '2020-01-02 11-22-22');

insert into rule_user values (9, 1, '2020-01-02 11-22-22');
insert into rule_user values (9, 2, '2020-01-02 11-22-22');

insert into rule_user values (10, 1, '2020-01-02 11-22-22');
insert into rule_user values (10, 2, '2020-01-02 11-22-22');
insert into rule_user values (10, 5, '2020-01-02 11-22-22');

insert into rule_user values (11, 1, '2020-01-02 11-22-22');
insert into rule_user values (11, 2, '2020-01-02 11-22-22');
insert into rule_user values (11, 3, '2020-01-02 11-22-22');
insert into rule_user values (11, 4, '2020-01-02 11-22-22');
insert into rule_user values (11, 5, '2020-01-02 11-22-22');

insert into rule_user values (12, 1, '2020-01-02 11-22-22');
insert into rule_user values (12, 2, '2020-01-02 11-22-22');
insert into rule_user values (12, 3, '2020-01-02 11-22-22');
insert into rule_user values (12, 5, '2020-01-02 11-22-22');

insert into rule_user values (13, 2, '2020-01-02 11-22-22');
insert into rule_user values (13, 3, '2020-01-02 11-22-22');
insert into rule_user values (13, 4, '2020-01-02 11-22-22');
insert into rule_user values (13, 5, '2020-01-02 11-22-22');

insert into rule_user values (14, 1, '2020-01-02 11-22-22');
insert into rule_user values (14, 3, '2020-01-02 11-22-22');
insert into rule_user values (14, 4, '2020-01-02 11-22-22');
insert into rule_user values (14, 5, '2020-01-02 11-22-22');

insert into rule_user values (15, 1, '2020-01-02 11-22-22');
insert into rule_user values (15, 4, '2020-01-02 11-22-22');
insert into rule_user values (15, 5, '2020-01-02 11-22-22');

insert into rule_user values (16, 1, '2020-01-02 11-22-22');

insert into rule_user values (17, 1, '2020-01-02 11-22-22');
insert into rule_user values (17, 2, '2020-01-02 11-22-22');
insert into rule_user values (17, 5, '2020-01-02 11-22-22');

insert into rule_user values (18, 3, '2020-01-02 11-22-22');
insert into rule_user values (18, 5, '2020-01-02 11-22-22');

insert into rule_user values (19, 1, '2020-01-02 11-22-22');
insert into rule_user values (19, 5, '2020-01-02 11-22-22');

insert into rule_user values (20, 2, '2020-01-02 11-22-22');
insert into rule_user values (20, 3, '2020-01-02 11-22-22');

insert into rule_room values (1, 1, '2020-01-02 11-22-22');
insert into rule_room values (1, 2, '2020-01-02 11-22-22');
insert into rule_room values (1, 3, '2020-01-02 11-22-22');
insert into rule_room values (1, 4, '2020-01-02 11-22-22');
insert into rule_room values (1, 5, '2020-01-02 11-22-22');

insert into rule_room values (2, 1, '2020-01-02 11-22-22');
insert into rule_room values (2, 2, '2020-01-02 11-22-22');
insert into rule_room values (2, 3, '2020-01-02 11-22-22');
insert into rule_room values (2, 4, '2020-01-02 11-22-22');
insert into rule_room values (2, 5, '2020-01-02 11-22-22');

insert into rule_room values (3, 1, '2020-01-02 11-22-22');
insert into rule_room values (3, 2, '2020-01-02 11-22-22');
insert into rule_room values (3, 3, '2020-01-02 11-22-22');
insert into rule_room values (3, 4, '2020-01-02 11-22-22');
insert into rule_room values (3, 5, '2020-01-02 11-22-22');

insert into rule_room values (4, 1, '2020-01-02 11-22-22');
insert into rule_room values (4, 2, '2020-01-02 11-22-22');
insert into rule_room values (4, 3, '2020-01-02 11-22-22');
insert into rule_room values (4, 4, '2020-01-02 11-22-22');
insert into rule_room values (4, 5, '2020-01-02 11-22-22');

insert into rule_room values (5, 1, '2020-01-02 11-22-22');
insert into rule_room values (5, 2, '2020-01-02 11-22-22');
insert into rule_room values (5, 3, '2020-01-02 11-22-22');
insert into rule_room values (5, 4, '2020-01-02 11-22-22');
insert into rule_room values (5, 5, '2020-01-02 11-22-22');

insert into rating values (1, 1, 6, 'user', 4, '2020-01-02 11-22-22');
insert into rating values (2, 1, 12, 5, 'user','2020-01-02 11-22-22');
insert into rating values (3, 1, 20, 3, 'user','2020-01-02 11-22-22');
insert into rating values (4, 1, 7, 4, 'user','2020-01-02 11-22-22');
insert into rating values (5, 1, 8, 5, 'user','2020-01-02 11-22-22');

insert into rating values (6, 2, 9, 4, 'user','2020-01-02 11-22-22');
insert into rating values (7, 2, 10, 4, 'user','2020-01-02 11-22-22');
insert into rating values (8, 2, 11, 4, 'user','2020-01-02 11-22-22');
insert into rating values (9, 2, 13, 4, 'user','2020-01-02 11-22-22');
insert into rating values (10, 2, 14, 5, 'user','2020-01-02 11-22-22');

insert into rating values (11, 3, 15, 5, 'user','2020-01-02 11-22-22');
insert into rating values (12, 3, 16, 4, 'user','2020-01-02 11-22-22');
insert into rating values (13, 3, 17, 4, 'user','2020-01-02 11-22-22');
insert into rating values (14, 3, 18, 3, 'user','2020-01-02 11-22-22');
insert into rating values (15, 3, 19, 4, 'user','2020-01-02 11-22-22');

insert into rating values (16, 4, 9, 4, 'user','2020-01-02 11-22-22');
insert into rating values (17, 4, 17, 5, 'user','2020-01-02 11-22-22');
insert into rating values (18, 4, 12, 4, 'user','2020-01-02 11-22-22');
insert into rating values (19, 4, 6, 4, 'user','2020-01-02 11-22-22');
insert into rating values (20, 4, 5, 3, 'user','2020-01-02 11-22-22');

insert into rating values (21, 5, 19, 3, 'user','2020-01-02 11-22-22');
insert into rating values (22, 5, 13, 4, 'user','2020-01-02 11-22-22');
insert into rating values (23, 5, 16, 5, 'user','2020-01-02 11-22-22');
insert into rating values (24, 5, 8, 4, 'user','2020-01-02 11-22-22');
insert into rating values (25, 5, 10, 4, 'user','2020-01-02 11-22-22');

insert into rating values (26, 6, 1, 4, 'user','2020-01-02 11-22-22');
insert into rating values (27, 12, 1, 5, 'user','2020-01-02 11-22-22');
insert into rating values (28, 20, 1, 3, 'user','2020-01-02 11-22-22');
insert into rating values (29, 7, 1, 4, 'user','2020-01-02 11-22-22');
insert into rating values (30, 8, 1, 5, 'user','2020-01-02 11-22-22');

insert into rating values (31, 9, 2, 4, 'user','2020-01-02 11-22-22');
insert into rating values (32, 10, 2, 4, 'user','2020-01-02 11-22-22');
insert into rating values (33, 11, 2, 4, 'user','2020-01-02 11-22-22');
insert into rating values (34, 13, 2, 4, 'user','2020-01-02 11-22-22');
insert into rating values (35, 14, 2, 5, 'user','2020-01-02 11-22-22');

insert into rating values (36, 15, 3, 5, 'user','2020-01-02 11-22-22');
insert into rating values (37, 16, 3, 4, 'user','2020-01-02 11-22-22');
insert into rating values (38, 17, 3, 4, 'user','2020-01-02 11-22-22');
insert into rating values (39, 18, 3, 3, 'user','2020-01-02 11-22-22');
insert into rating values (40, 19, 3, 4, 'user','2020-01-02 11-22-22');

insert into rating values (41, 9, 4, 4, 'user','2020-01-02 11-22-22');
insert into rating values (42, 17, 4, 5, 'user','2020-01-02 11-22-22');
insert into rating values (43, 12, 4, 4, 'user','2020-01-02 11-22-22');
insert into rating values (44, 6, 4, 4, 'user','2020-01-02 11-22-22');
insert into rating values (45, 5, 4, 3, 'user','2020-01-02 11-22-22');

insert into rating values (46, 19, 5, 3, 'user','2020-01-02 11-22-22');
insert into rating values (47, 13, 5, 4, 'user','2020-01-02 11-22-22');
insert into rating values (48, 16, 5, 5, 'user','2020-01-02 11-22-22');
insert into rating values (49, 8, 5, 4, 'user','2020-01-02 11-22-22');
insert into rating values (50, 10, 5, 4, 'user','2020-01-02 11-22-22');

insert into rating values (51, 1, 6, 'room', 4, '2020-01-02 11-22-22');
insert into rating values (52, 1, 12, 5, 'room', '2020-01-02 11-22-22');
insert into rating values (53, 1, 20, 3, 'room', '2020-01-02 11-22-22');
insert into rating values (54, 1, 7, 4, 'room', '2020-01-02 11-22-22');
insert into rating values (55, 1, 8, 5, 'room', '2020-01-02 11-22-22');

insert into rating values (56, 2, 9, 4, 'room', '2020-01-02 11-22-22');
insert into rating values (57, 2, 10, 4, 'room', '2020-01-02 11-22-22');
insert into rating values (58, 2, 11, 4, 'room', '2020-01-02 11-22-22');
insert into rating values (59, 2, 13, 4, 'room', '2020-01-02 11-22-22');
insert into rating values (60, 2, 14, 5, 'room', '2020-01-02 11-22-22');

insert into rating values (61, 3, 15, 5, 'room', '2020-01-02 11-22-22');
insert into rating values (62, 3, 16, 4, 'room', '2020-01-02 11-22-22');
insert into rating values (63, 3, 17, 4, 'room', '2020-01-02 11-22-22');
insert into rating values (64, 3, 18, 3, 'room', '2020-01-02 11-22-22');
insert into rating values (65, 3, 19, 4, 'room', '2020-01-02 11-22-22');

insert into rating values (66, 4, 9, 4, 'room', '2020-01-02 11-22-22');
insert into rating values (67, 4, 17, 5, 'room', '2020-01-02 11-22-22');
insert into rating values (68, 4, 12, 4, 'room', '2020-01-02 11-22-22');
insert into rating values (69, 4, 6, 4, 'room', '2020-01-02 11-22-22');
insert into rating values (70, 4, 5, 3, 'room', '2020-01-02 11-22-22');

insert into rating values (71, 5, 19, 3, 'room', '2020-01-02 11-22-22');
insert into rating values (72, 5, 13, 4, 'room', '2020-01-02 11-22-22');
insert into rating values (73, 5, 16, 5, 'room', '2020-01-02 11-22-22');
insert into rating values (74, 5, 8, 4, 'room', '2020-01-02 11-22-22');
insert into rating values (75, 5, 10, 4, 'room', '2020-01-02 11-22-22');

insert into rating values (76, 6, 1, 4, 'room', '2020-01-02 11-22-22');
insert into rating values (77, 12, 1, 5, 'room', '2020-01-02 11-22-22');
insert into rating values (78, 20, 1, 3, 'room', '2020-01-02 11-22-22');
insert into rating values (79, 7, 1, 4, 'room', '2020-01-02 11-22-22');
insert into rating values (80, 8, 1, 5,'room', '2020-01-02 11-22-22');

insert into rating values (81, 9, 2, 4, 'room', '2020-01-02 11-22-22');
insert into rating values (82, 10, 2, 4, 'room', '2020-01-02 11-22-22');
insert into rating values (83, 11, 2, 4, 'room', '2020-01-02 11-22-22');
insert into rating values (84, 13, 2, 4, 'room', '2020-01-02 11-22-22');
insert into rating values (85, 14, 2, 5, 'room', '2020-01-02 11-22-22');

insert into rating values (86, 15, 3, 5, 'room', '2020-01-02 11-22-22');
insert into rating values (87, 16, 3, 4, 'room', '2020-01-02 11-22-22');
insert into rating values (88, 17, 3, 4, 'room', '2020-01-02 11-22-22');
insert into rating values (89, 18, 3, 3, 'room', '2020-01-02 11-22-22');
insert into rating values (90, 19, 3, 4, 'room', '2020-01-02 11-22-22');

insert into rating values (91, 9, 4, 4, 'room', '2020-01-02 11-22-22');
insert into rating values (92, 17, 4, 5, 'room', '2020-01-02 11-22-22');
insert into rating values (93, 12, 4, 4, 'room','2020-01-02 11-22-22');
insert into rating values (94, 6, 4, 4, 'room', '2020-01-02 11-22-22');
insert into rating values (95, 5, 4, 3, 'room', '2020-01-02 11-22-22');

insert into rating values (96, 19, 5, 3, 'room', '2020-01-02 11-22-22');
insert into rating values (97, 13, 5, 4, 'room', '2020-01-02 11-22-22');
insert into rating values (98, 16, 5, 5, 'room', '2020-01-02 11-22-22');
insert into rating values (99, 8, 5, 4, 'room', '2020-01-02 11-22-22');
insert into rating values (100, 10, 5, 4, 'room', '2020-01-02 11-22-22');

insert into booking values (1, 6, 5, 'demand', 'pending', "2020-04-14 17:02:01");

insert into booking values (2, 10, 4, 'demand','pending', "2020-04-12 10:02:01");
insert into booking values (3, 11, 4, 'demand','pending', "2020-04-04 07:12:01");

insert into booking values (4, 6, 3, 'demand', 'pending', "2020-04-14 17:02:01");
insert into booking values (5, 7, 3, 'demand', 'pending', "2020-04-14 12:42:12");

insert into booking values (6, 12, 2, 'demand', 'pending', "2020-04-08 11:52:21");
insert into booking values (7, 20, 2, 'demand', 'pending', "2020-04-15 01:13:41");

insert into booking values (8, 9, 1, 'demand','pending', "2020-04-14 17:02:01");
insert into booking values (9, 7, 1, 'offer','pending', "2020-04-14 17:02:01");
insert into booking values (10, 11, 1, 'demand','pending', "2020-04-14 17:02:01");

insert into booking values (11, 7, 5, 'demand','cancelled', "2020-04-14 09:02:07");
insert into booking values (12, 12, 3, 'demand','cancelled',"2020-04-09 19:02:01");

insert into booking values (13, 6, 1, 'demand', 'accepted', "2020-04-09 19:02:01", '2020-03-01', '2020-09-01');
insert into booking values (14, 12, 1, 'demand', 'accepted', "2020-04-04 07:12:01", '2020-03-01', null);
insert into booking values (15, 20, 1, 'demand', 'accepted', "2020-04-04 07:12:01", '2020-03-01', null);
insert into booking values (16, 7, 1, 'demand', 'accepted', "2020-04-08 07:12:01", '2020-03-01', null);
insert into booking values (17, 8, 1, 'demand', 'accepted', "2020-03-30 07:12:01", '2020-03-01', null);

insert into booking values (18, 9, 2, 'demand','accepted', "2020-03-21 07:12:01", '2020-03-01', '2020-03-01');
insert into booking values (19, 10, 2, 'offer','accepted', "2020-04-12 12:12:01", '2020-03-01', null);
insert into booking values (20, 11, 2, 'demand','accepted', "2020-04-02 17:12:01", '2020-01-01', '2020-08-01');
insert into booking values (21, 13, 2, 'offer','accepted', "2020-04-11 19:12:01", '2020-03-01', null);
insert into booking values (22, 14, 2, 'demand','accepted', "2020-03-12 05:12:01", '2020-03-01', '2020-03-01');

insert into booking values (23, 15, 3, 'offer','accepted', "2020-03-04 17:45:01", '2020-03-01', null);
insert into booking values (24, 16, 3, 'demand','accepted', "2020-03-01 17:45:01", '2020-03-01', null);
insert into booking values (25, 17, 3, 'offer','accepted', "2020-03-02 17:45:01", '2019-06-01', '2020-01-01');
insert into booking values (26, 18, 3, 'demand','accepted', "2020-03-09 07:06:13", '2020-03-01', '2020-03-01');
insert into booking values (27, 19, 3, 'demand','accepted', "2020-03-01 10:45:01", '2020-03-01', null);

insert into booking values (28, 5, 4,'offer','accepted', "2020-03-01 10:45:01", '2020-03-01', null);
insert into booking values (29, 6, 4, 'offer','accepted', "2020-03-14 10:45:01", '2020-03-01', '2020-03-01');
insert into booking values (30, 9, 4, 'demand','accepted', "2020-03-07 15:45:01", '2020-03-01', null);
insert into booking values (31, 12, 4, 'offer','accepted', "2020-03-10 22:45:01", '2020-03-01', '2020-03-01');
insert into booking values (32, 17, 4, 'offer','accepted', "2020-03-06 20:45:01", '2020-03-01', null);

insert into booking values (33, 8, 5, 'demand','accepted', "2020-03-01 21:45:01", '2020-03-01', null);
insert into booking values (34, 10, 5, 'offer','accepted', "2020-03-10 22:45:01", '2019-01-01', '2020-07-01');
insert into booking values (35, 13, 5, 'demand','accepted', "2020-01-10 22:45:01", '2020-03-01', null);
insert into booking values (36, 16, 5, 'offer','accepted', "2019-11-19 02:25:21", '2020-03-01', null);
insert into booking values (37, 19, 5, 'demand','accepted', "2020-03-10 22:45:01", '2020-03-01', null);
