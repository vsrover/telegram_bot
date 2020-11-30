
create table bot_user (
    bot_user_id serial not null constraint bot_user_pk primary key,
    day_data_id integer references bot_user_day_data (day_data_id),
    name varchar(64),
    second_name varchar (64),
    age integer
);


create table periods (
    periods_id serial not null constraint periods_pk primary key,
    type varchar (64)
);


--bound with periods?
create table excreta (
    excreta_id serial not null constraint excreta_pk primary key,
    type varchar (64)
);


create table intestines (
    intestines_id serial not null constraint intestines_pk primary key,
    type varchar (64)
);


create table bladder (
    bladder_id serial not null constraint bladder_pk primary key,
    type varchar (64)
);


create table indisposition (
    indisposition_id serial not null constraint indisposition_pk primary key,
    type varchar (64)
);


create table mood (
    mood_id serial not null constraint mood_pk primary key,
    type varchar (64)
);


create table sex (
    sex_id serial not null constraint sex_pk primary key,
    type varchar (64)
);


create table ration (
    ration_id serial not null constraint ration_pk primary key,
    type varchar (64)
);


create table event (
    event_id serial not null constraint event_pk primary key,
    type varchar (64)
);


create table user_day_data (
    user_day_data_id serial not null constraint user_day_data_pk primary key,
    user_id integer references bot_user (bot_user_id),
    date timestamp with time zone not null,
    sleep integer,
    weight integer,
    basal_temperature integer
);

create table user_indisposition (
    user_indisposition_id serial not null constraint user_indisposition_pk primary key,
    user_day_data_id integer references user_day_data (user_day_data_id),
    indisposition_id integer references indisposition (indisposition_id),
);