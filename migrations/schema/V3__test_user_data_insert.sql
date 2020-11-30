
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
        ((select user_day_data_id from ins), 1)
),
user_intestines_ins as (insert into user_intestines ( user_day_data_id, user_intestines_id)
    values
        ((select user_day_data_id from ins), 1)
)
insert into user_bladder ( user_day_data_id, user_bladder_id)
    values
        ((select user_day_data_id from ins), 1);


select name, weight,  array_agg(type) from periods, user_periods, user_day_data
join bot_user on bot_user.bot_user_id = user_day_data.bot_user_id
where periods.periods_id = ANY(
    (
        select periods_id
        from user_periods
        where user_periods.user_day_data_id = user_day_data.bot_user_id
    )::INT[]
)
group by name, weight;





--join user_excreta on user_excreta.user_day_data_id = user_day_data.user_day_data_id
--join user_intestines on user_intestines.user_day_data_id = user_day_data.user_day_data_id
--join user_bladder on user_bladder.user_day_data_id = user_day_data.user_day_data_id;



