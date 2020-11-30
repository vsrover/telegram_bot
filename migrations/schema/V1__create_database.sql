

----------------------------------------------------------------------------------------------
-- entity tables
create table bot_user (
    bot_user_id serial not null constraint bot_user_pk primary key,
    name varchar(64),
    second_name varchar (64),
    age integer
);
-- entity tables end
----------------------------------------------------------------------------------------------


----------------------------------------------------------------------------------------------
-- vocabulary tables
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
-- vocabulary tables end
----------------------------------------------------------------------------------------------


----------------------------------------------------------------------------------------------
-- state tables
create table user_day_data (
    user_day_data_id serial not null constraint user_day_data_pk primary key,
    bot_user_id integer references bot_user (bot_user_id),
    date timestamp with time zone not null,
    sleep integer,
    weight integer,
    basal_temperature integer
);


create table user_periods (
    user_periods_id serial not null constraint user_periods_pk primary key,
    user_day_data_id integer references user_day_data (user_day_data_id),
    periods_id integer references periods (periods_id)
);


create table user_excreta (
    user_excreta_id serial not null constraint user_excreta_pk primary key,
    user_day_data_id integer references user_day_data (user_day_data_id),
    excreta_id integer references excreta (excreta_id)
);


create table user_intestines (
    user_intestines_id serial not null constraint user_intestines_pk primary key,
    user_day_data_id integer references user_day_data (user_day_data_id),
    intestines_id integer references intestines (intestines_id)
);


create table user_bladder (
    user_bladder_id serial not null constraint user_bladder_pk primary key,
    user_day_data_id integer references user_day_data (user_day_data_id),
    bladder_id integer references bladder (bladder_id)
);


create table user_indisposition (
    user_indisposition_id serial not null constraint user_indisposition_pk primary key,
    user_day_data_id integer references user_day_data (user_day_data_id),
    indisposition_id integer references indisposition (indisposition_id)
);


create table user_mood (
    user_mood_id serial not null constraint user_mood_pk primary key,
    user_day_data_id integer references user_day_data (user_day_data_id),
    mood_id integer references mood (mood_id)
);


create table user_sex (
    user_sex_id serial not null constraint user_sex_pk primary key,
    user_day_data_id integer references user_day_data (user_day_data_id),
    sex_id integer references sex (sex_id)
);


create table user_ration (
    user_ration_id serial not null constraint user_ration_pk primary key,
    user_day_data_id integer references user_day_data (user_day_data_id),
    ration_id integer references ration (ration_id)
);


create table user_event (
    user_event_id serial not null constraint user_event_pk primary key,
    user_day_data_id integer references user_day_data (user_day_data_id),
    event_id integer references event (event_id)
);
-- state tables end
----------------------------------------------------------------------------------------------
