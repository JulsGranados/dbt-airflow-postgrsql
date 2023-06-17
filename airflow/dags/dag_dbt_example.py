

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
    'email': ['natnaelmasresha@gmail.com'],
    'email_on_failure': True,
    'email_on_retry': False,
    'retries': 0,
    'retry_delay': timedelta(minutes=5),
}    

with DAG(
    "dag_dbt_example",
    start_date=datetime(2022, 9, 20),
    description="DAG that invokes dbt runs",
    schedule_interval=None,
    catchup=False,
    default_args=default_args, 
) as dag:
    
    dbt_clean = BashOperator(
        task_id="dbt_clean",
        bash_command=f"cd ../../opt/dbt/traffic_data && dbt clean ",
    )
    dbt_seed = BashOperator(
        task_id="dbt_seed",
        bash_command=f"cd ../../opt/dbt/traffic_data && dbt seed ",
    )
    
    # timestamp strategy uses an updated_at field to determine if a row has changed. 
    # If the configured updated_at column for a row is more recent than the last time the snapshot ran, 
    # then dbt will invalidate the old record and record the new one. If the timestamps are unchanged, 
    # then dbt will not take any action.
    
    #The check strategy is useful for tables which do not have a reliable updated_at column. 
    # This strategy works by comparing a list of columns between their current and historical values.
    
    # strategy='timestamp',
    # updated_at='order_date',

    dbt_snapshot = BashOperator(
        task_id="dbt_snapshot",
        bash_command=f"cd ../../opt/dbt/traffic_data && dbt snapshot",
    )
    #dbt deps pulls the most recent version of the dependencies listed in your packages.yml from
    # dbt_deps = BashOperator(
    #     task_id="dbt_deps",
    #     bash_command=f"cd ../../opt/dbt/traffic_data && dbt deps ",
    # )

    #dbt debug is a utility function to test the database connection and show information for debugging purposes. 
    # dbt_debug = BashOperator(
    #     task_id="dbt_debug",
    #     bash_command=f"cd ../../opt/dbt/traffic_data && dbt debug ",
    # )
    ##dbt compile generates executable SQL from source model, test, and analysis files. 
    ##You can find these compiled SQL files in the target/ directory of your dbt project.
    ##dbt compile is not a pre-requisite of dbt run, or other building commands. 
    ##Those commands will handle compilation themselves.
    
    dbt_compile = BashOperator(
        task_id="dbt_compile",
        bash_command=f"cd ../../opt/dbt/traffic_data && dbt compile ",
    )
    # dbt run executes compiled sql model files against the current target database. 
    # dbt connects to the target database and runs the relevant SQL required to materialize all data models
    # using the specified materialization strategies. Models are run in the order defined by the dependency graph generated 
    # during compilation. Intelligent multi-threading is used to minimize execution time without violating dependencies.
    dbt_run = BashOperator(
        task_id="dbt_run",
        bash_command=f"cd ../../opt/dbt/traffic_data && dbt run --vars 'start_date: 2018-01-01' ",
    )

    ##dbt seed, snapshot, run y test de manera intercalada
    dbt_build = BashOperator(
        task_id="dbt_build",
        bash_command=f"cd ../../opt/dbt/traffic_data && dbt build ",
    )


    dbt_test = BashOperator(
        task_id="dbt_test",
        bash_command=f"cd ../../opt/dbt/traffic_data && dbt test",
    )
    # The command is responsible for generating your project's documentation website by

    # copying the website index.html file into the target/ directory
    # compiling the project to target/manifest.json
    # producing the target/catalog.json file, which contains metadata about the tables and views produced by the models in your project.
    
    #dbt docs serve --port 8001
    dbt_doc_generate = BashOperator(
        task_id="dbt_doc_gen", 
        bash_command=f"cd ../../opt/dbt/traffic_data && dbt docs generate",

    )

    dbt_clean>>dbt_seed>>dbt_snapshot>>dbt_compile>>dbt_run>>dbt_build>>dbt_test>>dbt_doc_generate