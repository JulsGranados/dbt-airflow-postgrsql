import os
import sys
import pandas as pd
from datetime import datetime
from datetime import timedelta
from airflow import DAG
from airflow.operators.python import PythonOperator

cwd=os.getcwd()
sys.path.append(f'../data/')
sys.path.append(f'../pgsql/')
sys.path.append(f'../temp_storage/')
sys.path.insert(0,os.path.abspath(os.path.dirname(__file__)))
import db_jaffle_shop


def drop_table():
    db_jaffle_shop.drop_table()

def populate_table():
    try:
        df = pd.read_csv("../data/jaffle_shop_customers.csv")
        db_jaffle_shop.insert_to_table(df=df,table_name='jaffle_shop_customers')
        df = pd.read_csv("../data/jaffle_shop_orders.csv")
        db_jaffle_shop.insert_to_table(df=df,table_name='jaffle_shop_orders')
        df = pd.read_csv("../data/stripe_payments.csv")
        db_jaffle_shop.insert_to_table(df=df,table_name='stripe_payments')

    except Exception as e:
        print(f"error while inserting to table: {e}")  
        sys.exit(e)

# Specifing the default_args
default_args = {
    'owner': 'julio',
    'depends_on_past': False,
    'email': ['juliooo@gmail.com'],
    'email_on_failure': False,
    'email_on_retry': False,
    'retries': 0
}

with DAG(
    dag_id='extractor_jaffle',
    default_args=default_args,
    description='this loads our data to the database',
    start_date=datetime(2022,9,20,3),
    schedule_interval='@daily',
    catchup=False
) as dag:
    
    create_tables = PythonOperator(
        task_id='drop_table',
        python_callable = drop_table
    )
    populate_tables = PythonOperator(
        task_id='load_data',
        python_callable = populate_table
    )

    create_tables>>populate_tables
    
