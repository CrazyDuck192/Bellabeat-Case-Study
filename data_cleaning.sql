/*
hourly_steps_total
*/
-- add new column to specify period of records
ALTER TABLE hourly_steps_march_april
ADD COLUMN period VARCHAR(255);

UPDATE hourly_steps_march_april
SET period = "march-april";


ALTER TABLE hourly_steps_april_may
ADD COLUMN period VARCHAR(255);

UPDATE hourly_steps_april_may
SET period = "april-may";

-- combine two tables into one
CREATE TABLE IF NOT EXISTS hourly_steps_total AS (
	SELECT * FROM hourly_steps_march_april
    UNION 
    SELECT * FROM hourly_steps_april_may
);

-- parse date and cast to datetime type
UPDATE hourly_steps_total
SET ActivityHour = STR_TO_DATE(ActivityHour, "%m/%d/%Y %h:%i:%s %p");

ALTER TABLE hourly_steps_total
MODIFY ActivityHour DATETIME;


/*
hourly_calories_total
*/
ALTER TABLE hourly_calories_march_april
ADD COLUMN period VARCHAR(255);

UPDATE hourly_calories_march_april
SET period = "march-april";


ALTER TABLE hourly_calories_april_may
ADD COLUMN period VARCHAR(255);

UPDATE hourly_calories_april_may
SET period = "april-may";


CREATE TABLE IF NOT EXISTS hourly_calories_total AS (
	SELECT * FROM hourly_calories_march_april
    UNION 
    SELECT * FROM hourly_calories_april_may
);


UPDATE hourly_calories_total
SET ActivityHour = STR_TO_DATE(ActivityHour, "%m/%d/%Y %h:%i:%s %p");

ALTER TABLE hourly_calories_total
MODIFY ActivityHour DATETIME;


/*
hourly_intensity_total
*/
ALTER TABLE hourly_intensity_march_april
ADD COLUMN period VARCHAR(255);

UPDATE hourly_intensity_march_april
SET period = "march-april";


ALTER TABLE hourly_intensity_april_may
ADD COLUMN period VARCHAR(255);

UPDATE hourly_intensity_april_may
SET period = "april-may";


CREATE TABLE IF NOT EXISTS hourly_intensity_total AS (
	SELECT * FROM hourly_intensity_march_april
    UNION 
    SELECT * FROM hourly_intensity_april_may
);

UPDATE hourly_intensity_total
SET ActivityHour = STR_TO_DATE(ActivityHour, "%m/%d/%Y %h:%i:%s %p");

ALTER TABLE hourly_intensity_total
MODIFY ActivityHour DATETIME;


/*
daily_activity_total
*/
ALTER TABLE daily_activity_march_april
ADD COLUMN period VARCHAR(255);

UPDATE daily_activity_march_april
SET period = "march-april";


ALTER TABLE daily_activity_april_may
ADD COLUMN period VARCHAR(255);

UPDATE daily_activity_april_may
SET period = "april-may";


CREATE TABLE IF NOT EXISTS daily_activity_total AS (
	SELECT * FROM daily_activity_march_april
    UNION
    SELECT * FROM daily_activity_april_may
);


/*
daily_sleep_total
*/
UPDATE minute_sleep_march_april
SET date = STR_TO_DATE(date, "%m/%d/%Y %h:%i:%s %p");

-- create table to summarise sleep time of every user
CREATE TABLE IF NOT EXISTS daily_sleep_march_april AS (
	SELECT 
		Id,
		date AS SleepDay,
		COUNT(*) AS TotalSleepRecords,
		SUM(minutesAsleep) AS TotalMinutesAsleep,
		SUM(timeInBed) AS TotalTimeInBed,
        "march-april" AS period
	FROM (
		SELECT 
			Id, 
			DATE(date) AS date,
			COUNT(*) AS minutesAsleep,
			logId
		FROM minute_sleep_march_april
		WHERE value = 1
		GROUP BY Id, DATE(date), logId
	) sleep_time
	JOIN (
		SELECT 
			Id,
			DATE(date) AS date,
			COUNT(*) AS timeInBed,
			logId
		FROM minute_sleep_march_april
		GROUP BY Id, DATE(date), logId
	) bed_time
	USING (Id, date, logId)
	GROUP BY Id, date
);


ALTER TABLE daily_sleep_april_may
ADD COLUMN period VARCHAR(255);

UPDATE daily_sleep_april_may
SET period = "april-may";


CREATE TABLE IF NOT EXISTS daily_sleep_total AS (
	SELECT * FROM daily_sleep_march_april
    UNION
    SELECT * FROM daily_sleep_april_may
);


/*
average_sleep_by_weekdays
*/
-- create table to find average sleep time by days of week
CREATE TABLE IF NOT EXISTS average_sleep_by_weekdays AS (
	SELECT 
		DAYNAME(SleepDay) AS WeekDay, 
		AVG(TotalMinutesAsleep) AS AverageMinutesAsleep
	FROM daily_sleep_total
	GROUP BY DAYNAME(SleepDay)
	ORDER BY AverageMinutesAsleep DESC
);


/*
bad_sleep_total
*/
-- create table to find for every user number of days 
-- when he/she slept less than 7 hours
CREATE TABLE IF NOT EXISTS bad_sleep_total AS (
	SELECT 
		Id, 
		period,
		COUNT(*) AS days
	FROM daily_sleep_total
	WHERE TotalMinutesAsleep < 420
	GROUP BY Id, period
);