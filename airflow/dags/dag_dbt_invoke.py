from datetime import datetime
from datetime import timedelta

from airflow import DAG
from airflow.operators.bash_operator import BashOperator

# We're hardcoding this value here for the purpose of the demo, but in a production environment this
# would probably come from a config file and/or environment variables!
DBT_PROJECT_DIR = "../../opt/dbt/traffic_data"
DBT_PROFILE_DIR = "../../opt/dbt/"

default_args = {
    'owner': 'airflow',
    'depends_on_past': False,
    'email': ['julio@gmail.com'],
    'email_on_failure': True,
    'email_on_retry': False,
    'retries': 0,
    'retry_delay': timedelta(minutes=5),
}    

with DAG(
    "dag_dbt_invoke",
    start_date=datetime(2022, 9, 20),
    description="DAG that invokes dbt runs",
    schedule_interval=None,
    catchup=False,
    default_args=default_args, 
) as dag:
    
    dbt_run = BashOperator(
        task_id="dbt_run",
         bash_command=f"cd ../../opt/dbt/traffic_data && dbt run --select 1_Staging.base ",
    )
