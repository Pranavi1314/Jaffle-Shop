import pandas
import holidays

def model(dbt, session):

    dbt.config(
        materialized="table",
        packages=["pandas","pyarrow","holidays"]
    )
    
    in_holidays = holidays.IN()

    df = dbt.ref('date_spine').to_pandas()

    df["IS_HOLIDAY"] = df["DATE_DAY"].apply(lambda date: date in in_holidays )

    return df

# select * from {{ ref('holiday_2026') }} where is_holiday