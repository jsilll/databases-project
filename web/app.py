from functools import wraps
from flask import Flask
from flask import (render_template, 
                   request, 
                   url_for, 
                   redirect, 
                   abort)

from psycopg2 import (InterfaceError,
                      DatabaseError,
                      DataError,
                      OperationalError,
                      IntegrityError,
                      InternalError,
                      ProgrammingError,
                      NotSupportedError)

from connection import get_db_connection

app = Flask(__name__)

# [ ] TODO: (perguntar) Inserir e remover um retalhista, com todos os seus produtos, garantindo que esta operação seja atómica;
# [x] Listar todos os eventos de reposição de uma IVM, apresentando o número de unidades repostas por categoria de produto
# [ ] Inserir e remover categorias e sub-categorias
# [ ] Listar todas as sub-categorias de uma super-categoria, a todos os níveis de profundidade.

# TODO: 3: parse date time?
# TODO: 3: tem mesmo de ser com o post?
# TODO: tirar o load esquiesito dos butões

# -------------- Error Handlers -------------- #

@app.errorhandler(404)
def page_not_found():
    return render_template("404.html"), 404


@app.errorhandler(500)
def internal_error():
    return render_template("500.html"), 500

# -------------- Home Page -------------- #

@app.route("/", methods=["GET"])
def index():
    return render_template("index.html")

# -------------- Replenishments Page -------------- #

@app.route("/replenishments/", methods=["GET"])
def replenishments():
    return render_template("replenishments.html")

@app.route("/replenishments/", methods=["POST"])
def replenishments_post():
    manuf = request.form["manuf"]
    serial_nr = request.form["serial_nr"]

    try:
        conn = get_db_connection()
        cur = conn.cursor()
        cur.execute('SELECT category_name, SUM(nr_units) '
                    'FROM shelve '
                    'NATURAL JOIN '
                    '(SELECT * '
                    'FROM replenishment_event '
                    'WHERE serial_nr = %s AND manuf = %s) AS s '
                    'GROUP BY category_name ',
                    (serial_nr, manuf))
        res = cur.fetchall()
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
    
    return render_template("replenishments.html", serial_nr=serial_nr, manuf=manuf, table=res)

# -------------- Categories Page -------------- #

@app.route('/categories/', methods=["GET"])
def categories():
    return render_template("categories.html")

@app.route('/categories/create', methods=["GET"])
def create_category():
    return render_template("create_category.html")

@app.route('/categories/create', methods=["POST"])
def create_category_post():
    return render_template("categories.html")