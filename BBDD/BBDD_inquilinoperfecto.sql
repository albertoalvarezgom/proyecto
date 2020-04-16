SET SQL_SAFE_UPDATES = 0;

create database inquilino_perfecto;
use inquilino_perfecto;

create table user (
PK_user int primary key auto_increment,
first_name varchar(100) not null,
last_name varchar(100) not null,
birthday date not null,
gender enum ('masc', 'fem', 'other') not null,
occupation_field enum('arts_design', 'science', 'education', 'industry', 'law', 'state', 'consulting', 'customer_service', 'communication', 'finances', 'entertainment', 'real_state', 'health', 'sales', 'tourism' ,'logistics'),
occupation enum ('student', 'working', 'both'),
single boolean default true,
email varchar(100) not null,
password varchar(15) not null,
rating tinyint default null
);

alter table user
add column date_start datetime default "2019-06-15 09:34:21";

alter table user
add column date_last_update datetime default "2020-04-14 17:02:01";

insert into user values (1, 'Sara', 'Mariño', '19900706', 'fem', 'health', 'working', true, 'sara.marinho@gmail.com', 'sarasara123');
insert into user values (2, 'Pedro', 'Ramallo', '19890312', 'masc', 'industry', 'working', false, 'pedro.ramallo@gmail.com', 'pedropedro123');
insert into user values (3, 'Brais', 'Moldes', '19871008', 'masc', 'consulting', 'working', true, 'brais.moldes@gmail.com', 'braisbrais123');
insert into user values (4, 'Andrea', 'Fernandez', '19881101', 'fem', 'science', 'both', true, 'andrea.fernandez@gmail.com', 'andreaandrea123');
insert into user values (5, 'Xabier', 'Cambeiro', '19911222', 'masc', 'arts_design', 'both', false, 'xabi.cambeiro@gmail.com', 'xabixabi123');
insert into user values (6, 'Lara', 'Seoane', '19920207', 'fem', 'finances', 'working', false, 'lara.seoane@gmail.com', 'laralara123');
insert into user values (7, 'Ruben', 'Arias', '19941203', 'masc', 'sales', 'both', true, 'ruben.arias@gmail.com', 'rubenruben123');
insert into user values (8, 'Alex', 'Lopez', '19960830', 'fem', 'logistics', 'both', false, 'alex.lopez@gmail.com', 'alexalex123');
insert into user values (9, 'Diego', 'Muros', '19901101', 'masc', 'law', 'both', false, 'diego.muros@gmail.com', 'diegodiego123');
insert into user values (10, 'Mara', 'Carballo', '19920412', 'fem', 'tourism', 'working', true, 'mara.carballo@gmail.com', 'maramara123');
insert into user values (11, 'Tomas', 'Hervas', '19960507', 'masc', 'communication', 'student', true, 'tomas.hervas@gmail.com', 'tomastomas123');
insert into user values (12, 'Uxia', 'Rodriguez', '20000210', 'fem', 'education', 'student', false, 'uxia.rodriguez@gmail.com', 'uxiauxia123');
insert into user values (13, 'Marcos', 'Blanco', '19990909', 'masc', 'education', 'student', false, 'marcos.blanco@gmail.com', 'marcosmarcos123');
insert into user values (14, 'Carmen', 'Camaño', '19971202', 'fem', 'arts_design', 'both', true, 'carmen.camaño@gmail.com', 'carmencarmen123');
insert into user values (15, 'Roi', 'Cal', '19900501', 'masc', 'arts_design', 'working', false, 'roi.cal@gmail.com', 'roiroi123');
insert into user values (16, 'Ines', 'Barros', '19950611', 'fem', 'law', 'student', false, 'ines.barros@gmail.com', 'inesines123');
insert into user values (17, 'Berto', 'Novo', '19890202', 'masc', 'education', 'working', true, 'berto.novo@gmail.com', 'bertoberto123');
insert into user values (18, 'Alba', 'Iglesias', '19991005', 'fem', 'customer_service', 'both', false, 'alba.iglesias@gmail.com', 'albaalba123');
insert into user values (19, 'David', 'Casas', '20001102', 'masc', 'finances', 'student', true, 'david.casas@gmail.com', 'daviddavid123');
insert into user values (20, 'Antia', 'Mato', '20010122', 'fem', 'science', 'student', false, 'antia.mato@gmail.com', 'antiaantia123');

create table personality (
PK_personality int primary key auto_increment,
name varchar(100) not null
);

insert into personality values (1, 'active');
insert into personality values (2, 'calm');
insert into personality values (3, 'thoughtful');
insert into personality values (4, 'happy');
insert into personality values (5, 'helpful');
insert into personality values (6, 'creative');
insert into personality values (7, 'easy going');
insert into personality values (8, 'empathic');
insert into personality values (9, 'enthusiastic');
insert into personality values (10, 'kind');
insert into personality values (11, 'funny');
insert into personality values (12, 'honest');
insert into personality values (13, 'optimistic');
insert into personality values (14, 'organized');
insert into personality values (15, 'passionate');
insert into personality values (16, 'proactive');
insert into personality values (17, 'sensible');
insert into personality values (18, 'tolerant');
insert into personality values (19, 'sociable');
insert into personality values (20, 'sensitive');

create table personality_user (
FK_user_personality_user int not null,
FK_personality_personality_user int not null,
primary key (FK_user_personality_user, FK_personality_personality_user),
foreign key(FK_user_personality_user) references user (PK_user),
foreign key(FK_personality_personality_user) references personality (PK_personality)
);

alter table personality_user
add column date_start datetime default "2019-06-15 09:34:21";

insert into personality_user values (1, 1);
insert into personality_user values (1, 3);
insert into personality_user values (1, 8);
insert into personality_user values (1, 10);
insert into personality_user values (1, 12);

insert into personality_user values (2, 2);
insert into personality_user values (2, 5);
insert into personality_user values (2, 6);
insert into personality_user values (2, 7);
insert into personality_user values (2, 8);

insert into personality_user values (3, 1);
insert into personality_user values (3, 2);
insert into personality_user values (3, 3);
insert into personality_user values (3, 7);
insert into personality_user values (3, 9);

insert into personality_user values (4, 13);
insert into personality_user values (4, 17);
insert into personality_user values (4, 18);
insert into personality_user values (4, 19);
insert into personality_user values (4, 20);

insert into personality_user values (5, 10);
insert into personality_user values (5, 11);
insert into personality_user values (5, 14);
insert into personality_user values (5, 15);
insert into personality_user values (5, 4);

insert into personality_user values (6, 15);
insert into personality_user values (6, 2);
insert into personality_user values (6, 3);
insert into personality_user values (6, 12);
insert into personality_user values (6, 19);

insert into personality_user values (7, 9);
insert into personality_user values (7, 6);
insert into personality_user values (7, 11);
insert into personality_user values (7, 20);
insert into personality_user values (7, 12);

insert into personality_user values (8, 10);
insert into personality_user values (8, 18);
insert into personality_user values (8, 11);
insert into personality_user values (8, 7);
insert into personality_user values (8, 17);

insert into personality_user values (9, 1);
insert into personality_user values (9, 5);
insert into personality_user values (9, 15);
insert into personality_user values (9, 10);
insert into personality_user values (9, 20);

insert into personality_user values (10, 10);
insert into personality_user values (10, 2);
insert into personality_user values (10, 3);
insert into personality_user values (10, 13);
insert into personality_user values (10, 17);

insert into personality_user values (11, 1);
insert into personality_user values (11, 3);
insert into personality_user values (11, 8);
insert into personality_user values (11, 10);
insert into personality_user values (11, 12);

insert into personality_user values (12, 2);
insert into personality_user values (12, 5);
insert into personality_user values (12, 6);
insert into personality_user values (12, 7);
insert into personality_user values (12, 8);

insert into personality_user values (13, 1);
insert into personality_user values (13, 2);
insert into personality_user values (13, 3);
insert into personality_user values (13, 7);
insert into personality_user values (13, 9);

insert into personality_user values (14, 13);
insert into personality_user values (14, 17);
insert into personality_user values (14, 18);
insert into personality_user values (14, 19);
insert into personality_user values (14, 20);

insert into personality_user values (15, 10);
insert into personality_user values (15, 11);
insert into personality_user values (15, 14);
insert into personality_user values (15, 15);
insert into personality_user values (15, 4);

insert into personality_user values (16, 15);
insert into personality_user values (16, 2);
insert into personality_user values (16, 3);
insert into personality_user values (16, 12);
insert into personality_user values (16, 19);

insert into personality_user values (17, 9);
insert into personality_user values (17, 6);
insert into personality_user values (17, 11);
insert into personality_user values ( 17, 20);
insert into personality_user values (17, 12);

insert into personality_user values (18, 10);
insert into personality_user values (18, 18);
insert into personality_user values (18, 11);
insert into personality_user values (18, 7);
insert into personality_user values (18, 17);

insert into personality_user values (19, 1);
insert into personality_user values (19, 5);
insert into personality_user values (19, 15);
insert into personality_user values (19, 10);
insert into personality_user values (19, 20);

insert into personality_user values (20, 10);
insert into personality_user values (20, 2);
insert into personality_user values (20, 3);
insert into personality_user values (20, 13);
insert into personality_user values (20, 17);

create table lifestyle (
PK_lifestyle int primary key auto_increment,
name varchar(100) not null
);

insert into lifestyle values (1, 'familiar');
insert into lifestyle values (2, 'healthy');
insert into lifestyle values (3, 'gamer');
insert into lifestyle values (4, 'foodie');
insert into lifestyle values (5, 'workaholic');
insert into lifestyle values (6, 'early bird');
insert into lifestyle values (7, 'adventurous');
insert into lifestyle values (8, 'quiet');
insert into lifestyle values (9, 'party animal');
insert into lifestyle values (10, 'shopper');
insert into lifestyle values (11, 'animal lover');
insert into lifestyle values (12, 'lonely');
insert into lifestyle values (13, 'nocturnal');
insert into lifestyle values (14, 'practical');
insert into lifestyle values (15, 'improviser');
insert into lifestyle values (16, 'homelike');
insert into lifestyle values (17, 'fashion addict');
insert into lifestyle values (18, 'geek');
insert into lifestyle values (19, 'hater');
insert into lifestyle values (20, 'entrepreneur');

create table lifestyle_user (
FK_user_lifestyle_user int not null,
FK_lifestyle_lifestyle_user int not null,
primary key (FK_user_lifestyle_user, FK_lifestyle_lifestyle_user),
foreign key(FK_user_lifestyle_user) references user (PK_user),
foreign key(FK_lifestyle_lifestyle_user) references lifestyle (PK_lifestyle)
);

alter table lifestyle_user
add column date_start datetime default "2019-06-15 09:34:21";

insert into lifestyle_user values (1, 1);
insert into lifestyle_user values (1, 3);
insert into lifestyle_user values (1, 8);
insert into lifestyle_user values (1, 10);
insert into lifestyle_user values (1, 12);

insert into lifestyle_user values (2, 2);
insert into lifestyle_user values (2, 5);
insert into lifestyle_user values (2, 6);
insert into lifestyle_user values (2, 7);
insert into lifestyle_user values (2, 8);

insert into lifestyle_user values (3, 1);
insert into lifestyle_user values (3, 2);
insert into lifestyle_user values (3, 3);
insert into lifestyle_user values (3, 7);
insert into lifestyle_user values (3, 9);

insert into lifestyle_user values (4, 13);
insert into lifestyle_user values (4, 17);
insert into lifestyle_user values (4, 18);
insert into lifestyle_user values (4, 19);
insert into lifestyle_user values (4, 20);

insert into lifestyle_user values (5, 10);
insert into lifestyle_user values (5, 11);
insert into lifestyle_user values (5, 14);
insert into lifestyle_user values (5, 15);
insert into lifestyle_user values (5, 4);

insert into lifestyle_user values (6, 15);
insert into lifestyle_user values (6, 2);
insert into lifestyle_user values (6, 3);
insert into lifestyle_user values (6, 12);
insert into lifestyle_user values (6, 19);

insert into lifestyle_user values (7, 9);
insert into lifestyle_user values (7, 6);
insert into lifestyle_user values (7, 11);
insert into lifestyle_user values (7, 20);
insert into lifestyle_user values (7, 12);

insert into lifestyle_user values (8, 10);
insert into lifestyle_user values (8, 18);
insert into lifestyle_user values (8, 11);
insert into lifestyle_user values (8, 7);
insert into lifestyle_user values (8, 17);

insert into lifestyle_user values (9, 1);
insert into lifestyle_user values (9, 5);
insert into lifestyle_user values (9, 15);
insert into lifestyle_user values (9, 10);
insert into lifestyle_user values (9, 20);

insert into lifestyle_user values (10, 10);
insert into lifestyle_user values (10, 2);
insert into lifestyle_user values (10, 3);
insert into lifestyle_user values (10, 13);
insert into lifestyle_user values (10, 17);

insert into lifestyle_user values (11, 1);
insert into lifestyle_user values (11, 3);
insert into lifestyle_user values (11, 8);
insert into lifestyle_user values (11, 10);
insert into lifestyle_user values (11, 12);

insert into lifestyle_user values (12, 2);
insert into lifestyle_user values (12, 5);
insert into lifestyle_user values (12, 6);
insert into lifestyle_user values (12, 7);
insert into lifestyle_user values (12, 8);

insert into lifestyle_user values (13, 1);
insert into lifestyle_user values (13, 2);
insert into lifestyle_user values (13, 3);
insert into lifestyle_user values (13, 7);
insert into lifestyle_user values (13, 9);

insert into lifestyle_user values (14, 13);
insert into lifestyle_user values (14, 17);
insert into lifestyle_user values (14, 18);
insert into lifestyle_user values (14, 19);
insert into lifestyle_user values (14, 20);

insert into lifestyle_user values (15, 10);
insert into lifestyle_user values (15, 11);
insert into lifestyle_user values (15, 14);
insert into lifestyle_user values (15, 15);
insert into lifestyle_user values (15, 4);

insert into lifestyle_user values (16, 15);
insert into lifestyle_user values (16, 2);
insert into lifestyle_user values (16, 3);
insert into lifestyle_user values (16, 12);
insert into lifestyle_user values (16, 19);

insert into lifestyle_user values (17, 9);
insert into lifestyle_user values (17, 6);
insert into lifestyle_user values (17, 11);
insert into lifestyle_user values (17, 20);
insert into lifestyle_user values (17, 12);

insert into lifestyle_user values (18, 10);
insert into lifestyle_user values (18, 18);
insert into lifestyle_user values (18, 11);
insert into lifestyle_user values (18, 7);
insert into lifestyle_user values (18, 17);

insert into lifestyle_user values (19, 1);
insert into lifestyle_user values (19, 5);
insert into lifestyle_user values (19, 15);
insert into lifestyle_user values (19, 10);
insert into lifestyle_user values (19, 20);

insert into lifestyle_user values (20, 10);
insert into lifestyle_user values (20, 2);
insert into lifestyle_user values (20, 3);
insert into lifestyle_user values (20, 13);
insert into lifestyle_user values (20, 17);

create table highlights (
PK_highlights int primary key auto_increment,
name varchar(100) not null
);

insert into highlights values (1, 'cinema');
insert into highlights values (2, 'music');
insert into highlights values (3, 'photography');
insert into highlights values (4, 'nature');
insert into highlights values (5, 'sports');
insert into highlights values (6, 'reading');
insert into highlights values (7, 'cooking');
insert into highlights values (8, 'series');
insert into highlights values (9, 'videogames');
insert into highlights values (10, 'fashion');
insert into highlights values (11, 'art');
insert into highlights values (12, 'technology');
insert into highlights values (13, 'adventure');
insert into highlights values (14, 'travel');
insert into highlights values (15, 'crafts');

create table highlights_user (
FK_user_highlights_user int not null,
FK_highlights_highlights_user int not null,
description text not null,
foreign key(FK_user_highlights_user) references user (PK_user),
foreign key(FK_highlights_highlights_user) references highlights (PK_highlights)
);

alter table highlights_user
add column date_start datetime default "2019-06-15 09:34:21";

insert into highlights_user values (1, 1, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.');
insert into highlights_user values (1, 2, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.');
insert into highlights_user values (1, 3, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.');
insert into highlights_user values (1, 4, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.');
insert into highlights_user values (1, 15, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.');

insert into highlights_user values (2, 9, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.');
insert into highlights_user values (2, 12, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.');
insert into highlights_user values (2, 6, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.');
insert into highlights_user values (2, 7, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.');
insert into highlights_user values (2, 2, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.');

insert into highlights_user values (3, 14, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.');
insert into highlights_user values (3, 12, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.');
insert into highlights_user values (3, 13, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.');
insert into highlights_user values (3, 3, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.');
insert into highlights_user values (3, 1, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.');

insert into highlights_user values (4, 4, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.');
insert into highlights_user values (4, 5, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.');
insert into highlights_user values (4, 6, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.');
insert into highlights_user values (4, 7, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.');
insert into highlights_user values (4, 8, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.');

insert into highlights_user values (5, 7, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.');
insert into highlights_user values (5, 8, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.');
insert into highlights_user values (5, 9, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.');
insert into highlights_user values (5, 11, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.');
insert into highlights_user values (5, 12, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.');

insert into highlights_user values (6, 2, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.');
insert into highlights_user values (6, 12, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.');
insert into highlights_user values (6, 13, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.');
insert into highlights_user values (6, 14, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.');
insert into highlights_user values (6, 15, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.');

insert into highlights_user values (7, 7, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.');
insert into highlights_user values (7, 8, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.');
insert into highlights_user values (7, 4, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.');
insert into highlights_user values (7, 12, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.');
insert into highlights_user values (7, 11, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.');

insert into highlights_user values (8, 2, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.');
insert into highlights_user values (8, 7, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.');
insert into highlights_user values (8, 5, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.');
insert into highlights_user values (8, 8, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.');
insert into highlights_user values (8, 14, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.');

insert into highlights_user values (9, 3, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.');
insert into highlights_user values (9, 5, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.');
insert into highlights_user values (9, 7, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.');
insert into highlights_user values (9, 8, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.');
insert into highlights_user values (9, 11, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.');

insert into highlights_user values (10, 1, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.');
insert into highlights_user values (10, 2, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.');
insert into highlights_user values (10, 3, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.');
insert into highlights_user values (10, 6, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.');
insert into highlights_user values (10, 7, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.');

insert into highlights_user values (11, 1, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.');
insert into highlights_user values (11, 2, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.');
insert into highlights_user values (11, 3, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.');
insert into highlights_user values (11, 4, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.');
insert into highlights_user values (11, 15, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.');

insert into highlights_user values (12, 9, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.');
insert into highlights_user values (12, 12, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.');
insert into highlights_user values (12, 6, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.');
insert into highlights_user values (12, 7, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.');
insert into highlights_user values (12, 2, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.');

insert into highlights_user values (13, 14, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.');
insert into highlights_user values (13, 12, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.');
insert into highlights_user values (13, 13, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.');
insert into highlights_user values (13, 3, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.');
insert into highlights_user values (13, 1, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.');

insert into highlights_user values (14, 4, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.');
insert into highlights_user values (14, 5, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.');
insert into highlights_user values (14, 6, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.');
insert into highlights_user values (14, 7, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.');
insert into highlights_user values (14, 8, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.');

insert into highlights_user values (15, 7, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.');
insert into highlights_user values (15, 8, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.');
insert into highlights_user values (15, 9, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.');
insert into highlights_user values (15, 11, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.');
insert into highlights_user values (15, 12, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.');

insert into highlights_user values (16, 2, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.');
insert into highlights_user values (16, 12, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.');
insert into highlights_user values (16, 13, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.');
insert into highlights_user values (16, 14, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.');
insert into highlights_user values (16, 15, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.');

insert into highlights_user values (17, 7, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.');
insert into highlights_user values (17, 8, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.');
insert into highlights_user values (17, 4, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.');
insert into highlights_user values (17, 12, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.');
insert into highlights_user values (17, 11, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.');

insert into highlights_user values (18, 2, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.');
insert into highlights_user values (18, 7, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.');
insert into highlights_user values (18, 5, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.');
insert into highlights_user values (18, 8, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.');
insert into highlights_user values (18, 14, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.');

insert into highlights_user values (19, 3, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.');
insert into highlights_user values (19, 5, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.');
insert into highlights_user values (19, 7, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.');
insert into highlights_user values (19, 8, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.');
insert into highlights_user values (19, 11, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.');

insert into highlights_user values (20, 1, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.');
insert into highlights_user values (20, 2, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.');
insert into highlights_user values (20, 3, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.');
insert into highlights_user values (20, 6, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.');
insert into highlights_user values (20, 7, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in pretium neque. Nullam nibh libero, pulvinar vel porta vel, vehicula porttitor diam. Quisque sodales neque quis sem congue, vel vestibulum lorem condimentum. Donec lacinia arcu sit amet ante porttitor eleifend. Suspendisse eu arcu vehicula, posuere ligula sed, vulputate sapien. Nulla id elementum lorem, imperdiet tincidunt sapien. Curabitur aliquet posuere turpis in ultrices.');

create table rules (
PK_rules int primary key auto_increment,
name varchar(100) not null
);

insert into rules values (1, 'pets');
insert into rules values (2, 'smoking');
insert into rules values (3, 'vegetarian');
insert into rules values (4, 'allergies');
insert into rules values (5, 'couples');

create table rules_user (
FK_user_rules_user int not null,
FK_rules_rules_user int not null,
primary key(FK_user_rules_user, FK_rules_rules_user),
foreign key(FK_user_rules_user) references user (PK_user),
foreign key(FK_rules_rules_user) references rules (PK_rules)
);

alter table rules_user
add column date_start datetime default "2019-06-15 09:34:21";

insert into rules_user values (1, 1);
insert into rules_user values (1, 2);
insert into rules_user values (1, 3);
insert into rules_user values (1, 4);

insert into rules_user values (2, 1);
insert into rules_user values (2, 3);
insert into rules_user values (2, 4);
insert into rules_user values (2, 5);

insert into rules_user values (3, 3);
insert into rules_user values (3, 4);

insert into rules_user values (4, 1);
insert into rules_user values (4, 2);
insert into rules_user values (4, 3);
insert into rules_user values (4, 4);
insert into rules_user values (4, 5);

insert into rules_user values (5, 1);
insert into rules_user values (5, 4);
insert into rules_user values (5, 5);

insert into rules_user values (6, 2);
insert into rules_user values (6, 4);

insert into rules_user values (7, 1);
insert into rules_user values (7, 5);

insert into rules_user values (8, 5);

insert into rules_user values (9, 1);
insert into rules_user values (9, 2);

insert into rules_user values (10, 1);
insert into rules_user values (10, 2);
insert into rules_user values (10, 5);

insert into rules_user values (11, 1);
insert into rules_user values (11, 2);
insert into rules_user values (11, 3);
insert into rules_user values (11, 4);
insert into rules_user values (11, 5);

insert into rules_user values (12, 1);
insert into rules_user values (12, 2);
insert into rules_user values (12, 3);
insert into rules_user values (12, 5);

insert into rules_user values (13, 2);
insert into rules_user values (13, 3);
insert into rules_user values (13, 4);
insert into rules_user values (13, 5);

insert into rules_user values (14, 1);
insert into rules_user values (14, 3);
insert into rules_user values (14, 4);
insert into rules_user values (14, 5);

insert into rules_user values (15, 1);
insert into rules_user values (15, 4);
insert into rules_user values (15, 5);

insert into rules_user values (16, 1);

insert into rules_user values (17, 1);
insert into rules_user values (17, 2);
insert into rules_user values (17, 5);

insert into rules_user values (18, 3);
insert into rules_user values (18, 5);

insert into rules_user values (19, 1);
insert into rules_user values (19, 5);

insert into rules_user values (20, 2);
insert into rules_user values (20, 3);

create table entry (
PK_entry int primary key auto_increment,
FK_user_entry int not null,
foreign key (FK_user_entry) references user(PK_user),
title text not null,
description text not null
);

alter table entry
add column date_start datetime default "2019-06-15 09:34:21";

alter table entry
add column date_last_update datetime default "2020-04-14 17:02:01";

insert into entry values (1, 1, '¡Busco compañero/a de piso en A Coruña!', 'Morbi eget dui gravida, auctor quam eget, varius lorem. Suspendisse hendrerit sem sit amet orci tempor lobortis quis sit amet enim. Proin lobortis tristique risus, et lobortis lorem tempor in. Phasellus dignissim lacinia velit et dignissim. Donec nec pellentesque arcu. Maecenas malesuada sapien augue, ac lobortis nibh vestibulum dignissim. Nam semper suscipit velit a sodales. Praesent gravida ex nec massa viverra, vel cursus nisl tempor. Ut maximus rutrum sodales. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae.');
insert into entry values (2, 2, '¡Busco compañero/a de piso en A Coruña!', 'Morbi eget dui gravida, auctor quam eget, varius lorem. Suspendisse hendrerit sem sit amet orci tempor lobortis quis sit amet enim. Proin lobortis tristique risus, et lobortis lorem tempor in. Phasellus dignissim lacinia velit et dignissim. Donec nec pellentesque arcu. Maecenas malesuada sapien augue, ac lobortis nibh vestibulum dignissim. Nam semper suscipit velit a sodales. Praesent gravida ex nec massa viverra, vel cursus nisl tempor. Ut maximus rutrum sodales. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae.');
insert into entry values (3, 3, '¡Busco compañero/a de piso en A Coruña!', 'Morbi eget dui gravida, auctor quam eget, varius lorem. Suspendisse hendrerit sem sit amet orci tempor lobortis quis sit amet enim. Proin lobortis tristique risus, et lobortis lorem tempor in. Phasellus dignissim lacinia velit et dignissim. Donec nec pellentesque arcu. Maecenas malesuada sapien augue, ac lobortis nibh vestibulum dignissim. Nam semper suscipit velit a sodales. Praesent gravida ex nec massa viverra, vel cursus nisl tempor. Ut maximus rutrum sodales. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae.');
insert into entry values (4, 4, '¡Busco compañero/a de piso en A Coruña!', 'Morbi eget dui gravida, auctor quam eget, varius lorem. Suspendisse hendrerit sem sit amet orci tempor lobortis quis sit amet enim. Proin lobortis tristique risus, et lobortis lorem tempor in. Phasellus dignissim lacinia velit et dignissim. Donec nec pellentesque arcu. Maecenas malesuada sapien augue, ac lobortis nibh vestibulum dignissim. Nam semper suscipit velit a sodales. Praesent gravida ex nec massa viverra, vel cursus nisl tempor. Ut maximus rutrum sodales. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae.');
insert into entry values (5, 5, '¡Busco compañero/a de piso en A Coruña!', 'Morbi eget dui gravida, auctor quam eget, varius lorem. Suspendisse hendrerit sem sit amet orci tempor lobortis quis sit amet enim. Proin lobortis tristique risus, et lobortis lorem tempor in. Phasellus dignissim lacinia velit et dignissim. Donec nec pellentesque arcu. Maecenas malesuada sapien augue, ac lobortis nibh vestibulum dignissim. Nam semper suscipit velit a sodales. Praesent gravida ex nec massa viverra, vel cursus nisl tempor. Ut maximus rutrum sodales. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae.');

create table sharing (
FK_entry_sharing int not null,
foreign key (FK_entry_sharing) references entry(PK_entry),
preference_gender enum ('masc', 'fem', 'any') not null,
occupation enum ('student', 'working', 'both'),
min_age int check (rate between 18 and 50),
max_age int check (rate between 18 and 50)
);

alter table sharing
add column date_start datetime default "2019-06-15 09:34:21";

alter table sharing
add column date_last_update datetime default "2020-04-14 17:02:01";

insert into sharing values (1, 'any', 'working', 20, 32);
insert into sharing values (2, 'fem', 'both', 30, 40);
insert into sharing values (3, 'masc', 'working', 20, 40);
insert into sharing values (4, 'fem', 'student', 22, 28);
insert into sharing values (5, 'any', 'working', 18, 50);

create table room (
PK_room int primary key auto_increment,
FK_entry_room int not null,
foreign key (FK_entry_room) references entry(PK_entry),
type enum ('private', 'shared', 'entire_property') not null,
size tinyint not null,
bed_type enum ('individual', 'double', 'other', 'none' ),
price int not null,
bills_included boolean default false,
deposit boolean default false,
deposit_ammount int,
availability_from date not null,
availability_until date,
min_stay tinyint not null,
max_stay tinyint
);

alter table room
add column date_start datetime default "2019-06-15 09:34:21";

alter table room
add column date_last_update datetime default "2020-04-14 17:02:01";

insert into room values (1, 1, 'private', 12, 'double', 200, false, false, null, current_date(), null, 3, null);
insert into room values (2, 2, 'private', 16, 'double', 300, true, true, 300, current_date(), null, 6, null);
insert into room values (3, 3, 'private', 10, 'individual', 220, true, true, 440, current_date(), null, 12, null);
insert into room values (4, 4, 'shared', 24, 'double', 200, true, true, 200, current_date(), 20220101, 6, null);
insert into room values (5, 5, 'private', 14, 'double', 240, false, false, null, date_sub(current_date(), interval 3 month), null, 6, null);

create table flat(
FK_entry_flat int not null,
foreign key (FK_entry_flat) references entry(PK_entry),
address text not null,
postal_code int not null,
city varchar(100) not null,
flatmates_masc int not null default 0,
flatmates_fem int not null default 0,
size int not null
);

alter table flat
add column date_start datetime default "2019-06-15 09:34:21";

alter table flat
add column date_last_update datetime default "2020-04-14 17:02:01";

insert into flat values (1, 'Santiago de la Iglesia, 8 1D', 15004, 'A Coruña', 0, 0, 80);
insert into flat values (2, 'Avenida Finisterre 19, 4', 15004, 'A Coruña', 1, 0, 90);
insert into flat values (3, 'San Andres 36, 3', 15003, 'A Coruña', 0, 1, 70);
insert into flat values (4, 'Zalaeta 27, 5 Izq', 15002, 'A Coruña', 1, 1, 90);
insert into flat values (5, 'Angeles 2, 1', 15001, 'A Coruña', 0, 0, 60);

create table facilities(
PK_facilities int primary key auto_increment,
name varchar(100) not null
);

insert into facilities values (1, 'TV');
insert into facilities values (2, 'Wifi');
insert into facilities values (3, 'air conditioner');
insert into facilities values (4, 'parking');
insert into facilities values (5, 'elevator');
insert into facilities values (6, 'heat');
insert into facilities values (7, 'washing machine');
insert into facilities values (8, 'dryer');
insert into facilities values (9, 'doorman');
insert into facilities values (10, 'furniture');
insert into facilities values (11, 'swimmingpool');
insert into facilities values (12, 'private bathroom');
insert into facilities values (13, 'balcony');
insert into facilities values (14, 'view');
insert into facilities values (15, 'dishwasher');
insert into facilities values (16, 'accessible');
insert into facilities values (17, 'garden');
insert into facilities values (18, 'terrace');

create table facilities_entry(
FK_entry_facilities_entry int not null,
FK_facilities_facilities_entry int not null,
foreign key(FK_entry_facilities_entry) references entry (PK_entry),
foreign key(FK_facilities_facilities_entry) references facilities (PK_facilities)
);

alter table facilities_entry
add column date_start datetime default "2019-06-15 09:34:21";

insert into facilities_entry values (1, 1);
insert into facilities_entry values (1, 2);
insert into facilities_entry values (1, 6);
insert into facilities_entry values (1, 10);
insert into facilities_entry values (1, 12);
insert into facilities_entry values (1, 14);

insert into facilities_entry values (2, 1);
insert into facilities_entry values (2, 2);
insert into facilities_entry values (2, 7);
insert into facilities_entry values (2, 8);
insert into facilities_entry values (2, 13);
insert into facilities_entry values (2, 14);

insert into facilities_entry values (3, 1);
insert into facilities_entry values (3, 2);
insert into facilities_entry values (3, 6);
insert into facilities_entry values (3, 7);
insert into facilities_entry values (3, 8);
insert into facilities_entry values (3, 10);

insert into facilities_entry values (4, 1);
insert into facilities_entry values (4, 2);
insert into facilities_entry values (4, 5);
insert into facilities_entry values (4, 6);
insert into facilities_entry values (4, 7);
insert into facilities_entry values (4, 10);

insert into facilities_entry values (5, 1);
insert into facilities_entry values ( 5, 2);
insert into facilities_entry values (5, 3);
insert into facilities_entry values (5, 4);
insert into facilities_entry values (5, 12);
insert into facilities_entry values (5, 18);

create table rules_entry (
FK_entry_rules_entry int not null,
FK_rules_rules_entry int not null,
primary key(FK_entry_rules_entry, FK_rules_rules_entry),
foreign key(FK_entry_rules_entry) references entry (PK_entry),
foreign key(FK_rules_rules_entry) references rules (PK_rules)
);

alter table rules_entry
add column date_start datetime default "2019-06-15 09:34:21";

insert into rules_entry values (1, 1);
insert into rules_entry values (1, 2);
insert into rules_entry values (1, 3);
insert into rules_entry values (1, 4);
insert into rules_entry values (1, 5);

insert into rules_entry values (2, 1);
insert into rules_entry values (2, 2);
insert into rules_entry values (2, 3);
insert into rules_entry values (2, 4);
insert into rules_entry values (2, 5);

insert into rules_entry values (3, 1);
insert into rules_entry values (3, 2);
insert into rules_entry values (3, 3);
insert into rules_entry values (3, 4);
insert into rules_entry values (3, 5);

insert into rules_entry values (4, 1);
insert into rules_entry values (4, 2);
insert into rules_entry values (4, 3);
insert into rules_entry values (4, 4);
insert into rules_entry values (4, 5);

insert into rules_entry values (5, 1);
insert into rules_entry values (5, 2);
insert into rules_entry values (5, 3);
insert into rules_entry values (5, 4);
insert into rules_entry values (5, 5);

create table rating (
PK_rating int primary key auto_increment,
FK_user_sent_rating int not null,
FK_user_received_rating int not null,
rate int check (rate between 1 and 5),
foreign key (FK_user_sent_rating) references user(PK_user),
foreign key (FK_user_received_rating) references user(PK_user)
);

alter table rating
add column date_start datetime default "2019-06-15 09:34:21";

insert into rating values (1, 1, 6, 4);
insert into rating values (2, 1, 12, 5);
insert into rating values (3, 1, 20, 3);
insert into rating values (4, 1, 7, 4);
insert into rating values (5, 1, 8, 5);

insert into rating values (6, 2, 9, 4);
insert into rating values (7, 2, 10, 4);
insert into rating values (8, 2, 11, 4);
insert into rating values (9, 2, 13, 4);
insert into rating values (10, 2, 14, 5);

insert into rating values (11, 3, 15, 5);
insert into rating values (12, 3, 16, 4);
insert into rating values (13, 3, 17, 4);
insert into rating values (14, 3, 18, 3);
insert into rating values (15, 3, 19, 4);

insert into rating values (16, 4, 9, 4);
insert into rating values (17, 4, 17, 5);
insert into rating values (18, 4, 12, 4);
insert into rating values (19, 4, 6, 4);
insert into rating values (20, 4, 5, 3);

insert into rating values (21, 5, 19, 3);
insert into rating values (22, 5, 13, 4);
insert into rating values (23, 5, 16, 5);
insert into rating values (24, 5, 8, 4);
insert into rating values (25, 5, 10, 4);

create table booking(
PK_booking int primary key auto_increment,
FK_user_booking int not null,
foreign key (FK_user_booking) references user (PK_user),
FK_entry_booking int not null,
foreign key (FK_entry_booking) references entry (PK_entry),
status enum ('pending', 'cancelled', 'accepted'),
booking_date datetime not null
);

insert into booking values (1, 6, 5, 'pending', "2020-04-14 17:02:01");

insert into booking values (2, 10, 4, 'pending', "2020-04-12 10:02:01");
insert into booking values (3, 11, 4, 'pending', "2020-04-04 07:12:01");

insert into booking values (4, 6, 3, 'pending', "2020-04-14 17:02:01");
insert into booking values (5, 7, 3, 'pending', "2020-04-14 12:42:12");

insert into booking values (6, 12, 2, 'pending', "2020-04-08 11:52:21");
insert into booking values (7, 20, 2, 'pending', "2020-04-15 01:13:41");

insert into booking values (8, 9, 1, 'pending', "2020-04-14 17:02:01");
insert into booking values (9, 7, 1, 'pending', "2020-04-14 17:02:01");
insert into booking values (10, 11, 1, 'pending', "2020-04-14 17:02:01");

insert into booking values (11, 7, 5, 'cancelled', "2020-04-14 09:02:07");
insert into booking values (12, 12, 3, 'cancelled',"2020-04-09 19:02:01");

insert into booking values (13, 6, 1, 'accepted', "2020-04-09 19:02:01");
insert into booking values (14, 12, 1, 'accepted', "2020-04-04 07:12:01");
insert into booking values (15, 20, 1, 'accepted', "2020-04-04 07:12:01");
insert into booking values (16, 7, 1, 'accepted', "2020-04-08 07:12:01");
insert into booking values (17, 8, 1, 'accepted', "2020-03-30 07:12:01");

insert into booking values (18, 9, 2, 'accepted', "2020-03-21 07:12:01");
insert into booking values (19, 10, 2, 'accepted', "2020-04-12 12:12:01");
insert into booking values (20, 11, 2, 'accepted', "2020-04-02 17:12:01");
insert into booking values (21, 13, 2, 'accepted', "2020-04-11 19:12:01");
insert into booking values (22, 14, 2, 'accepted', "2020-03-12 05:12:01");

insert into booking values (23, 15, 3, 'accepted', "2020-03-04 17:45:01");
insert into booking values (24, 16, 3, 'accepted', "2020-03-01 17:45:01");
insert into booking values (25, 17, 3, 'accepted', "2020-03-02 17:45:01");
insert into booking values (26, 18, 3, 'accepted', "2020-03-09 07:06:13");
insert into booking values (27, 19, 3, 'accepted', "2020-03-01 10:45:01");

insert into booking values (28, 5, 4, 'accepted', "2020-03-01 10:45:01");
insert into booking values (29, 6, 4, 'accepted', "2020-03-14 10:45:01");
insert into booking values (30, 9, 4, 'accepted', "2020-03-07 15:45:01");
insert into booking values (31, 12, 4, 'accepted', "2020-03-10 22:45:01");
insert into booking values (32, 17, 4, 'accepted', "2020-03-06 20:45:01");

insert into booking values (33, 8, 5, 'accepted', "2020-03-01 21:45:01");
insert into booking values (34, 10, 5, 'accepted', "2020-03-10 22:45:01");
insert into booking values (35, 13, 5, 'accepted', "2020-01-10 22:45:01");
insert into booking values (36, 16, 5, 'accepted', "2019-11-19 02:25:21");
insert into booking values (37, 19, 5, 'accepted', "2020-03-10 22:45:01");

create table image (
PK_image int primary key auto_increment,
name text not null
);

create table image_user (
FK_image_image_user int not null,
foreign key (FK_image_image_user) references image (PK_image),
FK_user_image_user int not null,
foreign key (FK_user_image_user) references user (PK_user)
);

alter table image_user
add column date_start datetime default "2019-06-15 09:34:21";

create table image_entry(
FK_image_image_entry int not null,
foreign key (FK_image_image_entry) references image (PK_image),
FK_entry_image_entry int not null,
foreign key (FK_entry_image_entry) references entry (PK_entry)
);

alter table image_entry
add column date_start datetime default "2019-06-15 09:34:21";