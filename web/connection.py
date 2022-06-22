from os import environ
from psycopg2 import connect
from dotenv import load_dotenv
from functools import wraps
from flask import abort
from psycopg2 import (InterfaceError,
                      DatabaseError,
                      DataError,
                      OperationalError,
                      IntegrityError,
                      InternalError,
                      ProgrammingError,
                      NotSupportedError)

load_dotenv()

HOST = environ["DB_HOST"]
DATABASE = environ["DB_NAME"]
USER = environ["DB_USERNAME"]
PASSWORD = environ["DB_PASSWORD"]


def get_db_connection():
    conn = connect(host=HOST, database=DATABASE, user=USER, password=PASSWORD)
    return conn


def handle_transaction(transaction):
    @wraps(transaction)
    def decorated(*args, **kwargs):
        g = transaction.__globals__
        sentinel = object()
        oldvalue = g.get('var', sentinel)

        g['var'] = value
        try:
            return transaction()
        except (InterfaceError, OperationalError, InternalError, ProgrammingError, NotSupportedError):
            abort(500)
        except (DataError, IntegrityError):
            abort(400)
        except DatabaseError:
            abort(500)
        except Exception:
            abort(400)
        finally:
            cur.close()
            conn.close()

    return decorated
