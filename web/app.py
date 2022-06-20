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

# [ ] TODO: (perguntar) Inserir e remover um retalhista, com todos os seus produtos, garantindo que esta operação seja atómica;
# [x] Listar todos os eventos de reposição de uma IVM, apresentando o número de unidades repostas por categoria de produto
# [ ] Inserir e remover categorias e sub-categorias
# [ ] Listar todas as sub-categorias de uma super-categoria, a todos os níveis de profundidade.

# TODO: 3: parse date time?
# TODO: 3: tem mesmo de ser com o post?
# TODO: tirar o load esquiesito dos butões

app = Flask(__name__)

# -------------- Home Page -------------- #

@app.route("/", methods=["GET"])
def index_page():
    return render_template("index.html")

# -------------- Replenishments Page -------------- #

@app.route("/replenishments/", methods=["GET"])
def replenishments_page():
    return render_template("replenishments.html")

# --- List --- #

@app.route("/replenishments/", methods=["POST"])
def list_replenishments():
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
def categories_page():
    return render_template("categories.html")

# --- Create --- #

@app.route('/categories/', methods=["POST"])
def list_categories():
    # TODO: 
    print(request.form)
    return render_template("categories.html")

# --- Create --- #

@app.route('/categories/create', methods=["GET"])
def create_categories_page():
    return render_template("create_category.html")

@app.route('/categories/create/simple_category', methods=['POST'])
def create_simple_category():
    # TODO:
    print(request.form)
    return redirect(url_for('categories_page'))

@app.route('/categories/create/super_category', methods=['POST'])
def create_super_category():
    # TODO:
    print(request.form)
    return redirect(url_for('categories_page'))

@app.route('/categories/create/sub_category', methods=['POST'])
def create_sub_category():
    # TODO:
    print(request.form)
    return redirect(url_for('categories_page'))

# --- Delete --- #

@app.route('/categories/delete/', methods=['GET'])
def delete_categories_page():
    return render_template("delete_category.html")

@app.route('/categories/delete/simple_category', methods=['POST'])
def delete_simple_category():
    # TODO:
    print(request.form)
    return redirect(url_for('categories_page'))

@app.route('/categories/delete/super_category', methods=['POST'])
def delete_super_category():
    # TODO:
    print(request.form)
    return redirect(url_for('categories_page'))

# -------------- Replenishments Page -------------- #

@app.route("/retailers/", methods=["GET"])
def retailers_page():
    return render_template("retailers.html")

# --- Create --- #

@app.route("/retailers/create", methods=["GET"])
def create_retailers_page():
    return render_template("create_retailer.html")

@app.route("/retailers/create", methods=["POST"])
def create_retailer():
    # TODO:
    print(request.form)
    return redirect(url_for('retailers_page'))

# --- Delete --- #

@app.route("/retailers/delete", methods=["GET"])
def delete_retailers_page():
    # TODO:
    print(request.form)
    return render_template("delete_retailer.html")

@app.route("/retailers/delete", methods=["POST"])
def delete_retailer():
    # TODO: 
    print(request.form)
    return redirect(url_for('retailers_page'))

# -------------- Error Handlers -------------- #

@app.errorhandler(404)
def not_found_page():
    return render_template("404.html"), 404

@app.errorhandler(500)
def internal_error_page():
    return render_template("500.html"), 500