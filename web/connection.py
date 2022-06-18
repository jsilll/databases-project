from os import environ
from psycopg2 import connect
from dotenv import load_dotenv

load_dotenv()

HOST = environ["DB_HOST"]
DATABASE = environ["DB_NAME"]
USER = environ["DB_USERNAME"]
PASSWORD = environ["DB_PASSWORD"]

def get_db_connection():
    conn = connect(host=HOST, database=DATABASE, user=USER, password=PASSWORD)
    return conn
