import sys
import pandas as pd
from sqlalchemy import text
import json
from sqlalchemy import create_engine
from sqlalchemy.engine import url
import numpy as np


# default
engine = create_engine("postgresql://airflow:airflow@host.docker.internal:8585/postgres")

# psycopg2
#engine = create_engine("postgresql+psycopg2://airflow:airflow@host.docker.internal:8585/postgres")

# pg8000
#engine = create_engine("postgresql+pg8000://airflow:airflow@host.docker.internal:8585/postgres")


#engine = create_engine(url_object)
#engine = create_engine('postgresql+psycopg2://airflow:airflow@192.168.1.100:8585/postgres')
#engine = create_engine('postgresql+psycopg2://airflow:airflow@host.docker.internal:8585/postgres')

JAFFLE = "initialise.sql"


def drop_table():
    try:
        with engine.connect() as conn:
            for name in [JAFFLE]:
                
                with open(f'/opt/pgsql/{name}', "r") as file:
                    query = text(file.read())
                    conn.execute(query)
        print("Successfull")
    except Exception as e:
        print("Error jaffle",e)
        sys.exit(e)

def insert_to_table(df :pd.DataFrame, table_name: str):
    try:
        with engine.connect() as conn:
            df.to_sql(name=table_name, con=conn, if_exists='append', index=False)

    except Exception as e:
        print(f"error while inserting to table: {e}")  
        sys.exit(e)