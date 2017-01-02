CREATE TABLE v_calendar
(
  calendar_date date,
  day_of_week integer,
  day_of_month integer,
  day_of_year integer,
  day_of_calendar integer,
  weekday_of_month integer,
  week_of_month integer,
  week_of_year integer,
  week_of_calendar integer,
  month_of_quarter integer,
  month_of_year integer,
  month_of_calendar integer,
  quarter_of_year integer,
  quarter_of_calendar integer,
  year_of_calendar integer,
  load_dthms timestamp(0) without time zone
)
WITH (  OIDS=FALSE)
DISTRIBUTED BY (calendar_date);