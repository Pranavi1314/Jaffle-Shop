{% test dollars_greater_than_one(model, group_by_column, clv_column) %}

    select {{ group_by_column }}, sum({{ clv_column }}) as total_clv
    from {{ model }}
    group by {{ group_by_column }}
    having sum({{ clv_column }}) < 1

{% endtest %}
