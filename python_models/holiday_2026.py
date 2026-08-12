import pandas
import holidays
import pyarrow

def model(dbt, session):
    dbt.config(
        materialized="table",
        packages= ['pyarrow','pandas','holidays']
    )

    in_holidays = holidays.India()

    df = dbt.ref("date_spine").to_pandas()

    df["IS_HOLIDAY"] = df["DATE_DAY"].apply(
        lambda date: date in in_holidays
    )

    return df