{{
  config(
    target_database = DEV_DB,
    target_schema = DBT_VISWANATHSEEPOM01ALUMNIIIMKACIN,
    strategy='check',
    unique_key='product_id',
    check_cols=['inventory'],
   )
}}

