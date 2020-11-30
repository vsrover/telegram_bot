
insert into bot_user (name, second_name, age)
values
    ('Anna', 'May', 23),
    ('Galina', 'Bay', 25),
    ('Inna', 'Day', 22);


with ins as (
    insert into user_day_data (bot_user_id, date, sleep, weight, basal_temperature)
    values
        (1, '22-10-2020'::timestamp with time zone, 8, 60.0, 36.6)
        returning user_day_data_id
),
user_periods_ins as (insert into user_periods ( user_day_data_id, periods_id)
    values
        ((select user_day_data_id from ins), '{1, 2, 3}')
),
user_excreta_ins as (insert into user_excreta ( user_day_data_id, excreta_id)
    values
        ((select user_day_data_id from ins), '{1, 4}')
),
user_intestines_ins as (insert into user_intestines ( user_day_data_id, intestines_id)
    values
        ((select user_day_data_id from ins), '{2, 3}')
)
insert into user_bladder ( user_day_data_id, bladder_id)
    values
        ((select user_day_data_id from ins), '{3}');


with ins as (
    insert into user_day_data (bot_user_id, date, sleep, weight, basal_temperature)
    values
        (2, '22-10-2020'::timestamp with time zone, 8, 54.0, 36.4)
        returning user_day_data_id
),
user_periods_ins as (insert into user_periods ( user_day_data_id, periods_id)
    values
        ((select user_day_data_id from ins), '{1}')
),
user_excreta_ins as (insert into user_excreta ( user_day_data_id, excreta_id)
    values
        ((select user_day_data_id from ins), '{4}')
),
user_intestines_ins as (insert into user_intestines ( user_day_data_id, intestines_id)
    values
        ((select user_day_data_id from ins), '{1, 2, 3}')
)
insert into user_bladder ( user_day_data_id, bladder_id)
    values
        ((select user_day_data_id from ins), '{1, 3}');



select name,
       second_name,
       sleep
       weight,
       basal_temperature,

       array_agg(distinct periods.type)    as periods_type,
       array_agg(distinct excreta.type)    as excreta_type,
       array_agg(distinct intestines.type) as intestines_type,
       array_agg(distinct bladder.type)    as bladder_type

from user_day_data
         join bot_user on bot_user.bot_user_id = user_day_data.bot_user_id
         join periods on periods.periods_id = ANY ((select periods_id
                                                    from user_periods
                                                    where user_periods.user_day_data_id = user_day_data.user_day_data_id)::INT[])
         join excreta on excreta.excreta_id = ANY ((select excreta_id
                                                    from user_excreta
                                                    where user_excreta.user_day_data_id = user_day_data.user_day_data_id)::INT[])
         join intestines on intestines.intestines_id = ANY ((select intestines_id
                                                    from user_intestines
                                                    where user_intestines.user_day_data_id = user_day_data.user_day_data_id)::INT[])
         join bladder on bladder.bladder_id = ANY ((select bladder_id
                                                    from user_bladder
                                                    where user_bladder.user_day_data_id = user_day_data.user_day_data_id)::INT[])
where user_day_data.date between '21-10-2020'::timestamp with time zone and '23-10-2020'::timestamp with time zone
group by name, second_name, weight, sleep, basal_temperature;