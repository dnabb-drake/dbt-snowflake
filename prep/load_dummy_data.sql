-- Loosely Follotinwg https://docs.getdbt.com/guides/snowflake

-- Pick an existing role and database to use to load the data
USE ROLE DBTDEMO_DEV;
USE DATABASE DBTDEMO_DEV;

create or replace schema RAW_JAFFLE;
create or replace schema RAW_STRIPE;

create or replace table raw_jaffle.customers 
( id integer,
  first_name varchar,
  last_name varchar
);

copy into raw_jaffle.customers (id, first_name, last_name)
from 's3://dbt-tutorial-public/jaffle_shop_customers.csv'
file_format = (
    type = 'CSV'
    field_delimiter = ','
    skip_header = 1
    ); 

create or replace table raw_jaffle.orders
( id integer,
  user_id integer,
  order_date date,
  status varchar,
  _etl_loaded_at timestamp default current_timestamp
);

copy into raw_jaffle.orders (id, user_id, order_date, status)
from 's3://dbt-tutorial-public/jaffle_shop_orders.csv'
file_format = (
    type = 'CSV'
    field_delimiter = ','
    skip_header = 1
    );

create or replace table raw_stripe.payment 
( id integer,
  orderid integer,
  paymentmethod varchar,
  status varchar,
  amount integer,
  created date,
  _batched_at timestamp default current_timestamp
);

copy into raw_stripe.payment (id, orderid, paymentmethod, status, amount, created)
from 's3://dbt-tutorial-public/stripe_payments.csv'
file_format = (
    type = 'CSV'
    field_delimiter = ','
    skip_header = 1
    );

select * from raw_jaffle.customers;
select * from raw_jaffle.orders;
select * from raw_stripe.payment;   