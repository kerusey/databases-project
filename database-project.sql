create table golf_course(
    id int PRIMARY KEY,
    name varchar(255) NOT NULL,
    difficulty_level int NOT NULL CHECK (difficulty_level > 0),
    length int NOT NULL CHECK (length > 0),
    holes int NOT NULL CHECK (holes >= 9 AND holes <= 36),
    water_hazards int NOT NULL CHECK (water_hazards < holes),
    person_who_registered int,
    description text
);

create sequence golf_course_id_seq
    as integer;

alter table golf_course
    alter column id set default nextval('public.golf_course_id_seq'::regclass);

alter sequence golf_course_id_seq owned by golf_course.id;

create table person(
    id int NOT NULL PRIMARY KEY,
    name varchar(255) NOT NULL,
    surname varchar(255) NOT NULL,
    email varchar(255) NOT NULL,
    is_worker boolean NOT NULL DEFAULT False,
    is_client boolean NOT NULL DEFAULT False,
    can_receive_ad boolean NOT NULL DEFAULT False
);

alter table golf_course
    add constraint golf_course_person__fk
        foreign key (person_who_registered) references person("id");

create sequence person_id_seq
    as integer;

alter table person
    alter column id set default nextval('public.person_id_seq'::regclass);

alter sequence person_id_seq owned by person.id;

create table difficulty_level_name(
    id int NOT NULL PRIMARY KEY,
    difficulty_name varchar(255) NOT NULL
);

create sequence difficulty_level_name_id_seq
    as integer;

alter table difficulty_level_name
    alter column id set default nextval('public.difficulty_level_name_id_seq'::regclass);

alter sequence difficulty_level_name_id_seq owned by difficulty_level_name.id;

alter table golf_course
    add constraint golf_course_difficulty_level__fk
        foreign key (difficulty_level) references difficulty_level_name("id")
            on delete cascade;

INSERT INTO public.difficulty_level_name VALUES
(DEFAULT, 'easy'),
(DEFAULT, 'medium'),
(DEFAULT, 'hard'),
(DEFAULT, 'insane');

INSERT INTO public.person VALUES
(DEFAULT, 'das', 'is', 'good', false, true, false),
(DEFAULT, 'danila', 'likh', 'email@email.ci', false, true, false)

INSERT INTO public.golf_course VALUES
(DEFAULT, 'name of the course', 2, 123, 14, 2, 1, 'descr'),
(DEFAULT, 'name of the course 2', 3, 31231, 22, 12, 2, 'descr2')
