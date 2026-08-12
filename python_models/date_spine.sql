{{dbt_utils.date_spine(
    datepart = "day",
    start_date = "cast('2026-01-01'as date)",
    end_date = "cast('2026-12-01'as date)"
)}}

-- This function gives the sequence of dates from start_date to end_date