-- Date Dimension
CREATE TABLE dvddw.dim_date (
    date_key INT PRIMARY KEY,
    full_date DATE,
    day_of_week SMALLINT,
    day_name VARCHAR,
    day_of_month SMALLINT,
    day_of_year SMALLINT,
    week_of_year SMALLINT,
    month SMALLINT,
    month_name VARCHAR,
    quarter SMALLINT,
    quarter_name VARCHAR,
    year SMALLINT,
    is_weekend BOOLEAN
);

-- Populate dvddw.dim_date
INSERT INTO dvddw.dim_date (
    date_key, full_date, day_of_week, day_name, day_of_month, day_of_year, week_of_year,
    month, month_name, quarter, quarter_name, year, is_weekend
)
SELECT
    TO_CHAR(day, 'YYYYMMDD')::INT AS date_key,
    day::DATE AS full_date,
    EXTRACT(DOW FROM day) AS day_of_week,
    TRIM(TO_CHAR(day, 'Day')) AS day_name,
    EXTRACT(DAY FROM day) AS day_of_month,
    EXTRACT(DOY FROM day) AS day_of_year,
    EXTRACT(WEEK FROM day) AS week_of_year,
    EXTRACT(MONTH FROM day) AS month,
    TRIM(TO_CHAR(day, 'Month')) AS month_name,
    EXTRACT(QUARTER FROM day) AS quarter,
    'Q' || EXTRACT(QUARTER FROM day) AS quarter_name,
    EXTRACT(YEAR FROM day) AS year,
    CASE WHEN EXTRACT(DOW FROM day) IN (0, 6) THEN TRUE ELSE FALSE END AS is_weekend
FROM
    GENERATE_SERIES('2005-01-01'::DATE, '2030-12-31'::DATE, '1 day'::INTERVAL) AS day;


