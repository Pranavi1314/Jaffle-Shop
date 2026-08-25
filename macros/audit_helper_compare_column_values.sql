{% macro audit_helper_compare_column_values(old_relation= ref('fct_orders__deprecated'), dbt_relation=ref('fct_orders'), primary_column="order_id") %} 

{%- set columns_to_compare=adapter.get_columns_in_relation(old_relation)  -%}

{% set old_etl_relation_query %}
    select * from {{ old_relation }}
{% endset %}

{% set new_etl_relation_query %}
    select * from {{ dbt_relation }}
{% endset %}

{% if execute %}
    {% for column in columns_to_compare %}
        {{ log('Comparing column "' ~ column.name ~'"', info=True) }}
        {% set audit_query = audit_helper.compare_column_values(
                a_query=old_etl_relation_query,
                b_query=new_etl_relation_query,
                primary_key= primary_column,
                column_to_compare=column.name
        ) %}

        {% set audit_results = run_query(audit_query) %}

        {% do log(audit_results.column_names, info=True) %}
        {% for row in audit_results.rows %}
            {% do log(row.values(), info=True) %}
        {% endfor %}
    {% endfor %}
{% endif %}

{% endmacro %}

{# audit_helper_compare_column_values(ref('fct_orders_deprecated'), ref('fct_orders'), 'order_id') #}