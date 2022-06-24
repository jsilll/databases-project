# from os import environ
from psycopg2 import connect
# from dotenv import load_dotenv

# load_dotenv()

# HOST = environ["DB_HOST"]
# DATABASE = environ["DB_NAME"]
# USER = environ["DB_USERNAME"]
# PASSWORD = environ["DB_PASSWORD"]

DB_HOST="db.tecnico.ulisboa.pt"
DB_USER="istxxxxxxx"
DB_DATABASE=DB_USER
DB_PASSWORD="xxxxxxx"

def get_db_connection():
    conn = connect(host=DB_HOST, database=DB_DATABASE, user=DB_USER, password=DB_PASSWORD)
    return conn
