from flask import Flask
from flask import (render_template,
                   request,
                   url_for,
                   redirect,
                   abort)

from connection import get_db_connection

# [x] Inserir e remover um retalhista, com todos os seus produtos, garantindo que esta operação seja atómica;
# [x] Listar todos os eventos de reposição de uma IVM, apresentando o número de unidades repostas por categoria de produto
# [x] Inserir e remover categorias e sub-categorias
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
    return render_template("replenishments/replenishments.html")

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
                    'GROUP BY category_name;',
                    (serial_nr, manuf))
        res = cur.fetchall()
    except Exception as e:
        return str(e)
    finally:
        cur.close()
        conn.close()

    return render_template("replenishments/replenishments.html", serial_nr=serial_nr, manuf=manuf, table=res)

# -------------- Categories Page -------------- #


@app.route('/categories/', methods=["GET"])
def categories_page():
    return render_template("categories/categories.html")

# --- List --- #


@app.route('/categories/', methods=["POST"])
def list_categories():
    super_category_name = request.form["super_category_name"]

    try:
        conn = get_db_connection()
        cur = conn.cursor()
        cur.execute('WITH RECURSIVE all_sub AS ( '
                    'SELECT super_category, category '
                    'FROM has_other '
                    'WHERE super_category = %s '
                    'UNION '
                    'SELECT e.super_category, e.category '
                    'FROM has_other e '
                    'INNER JOIN all_sub s ON s.category = e.super_category '
                    ') '
                    'SELECT * '
                    'FROM '
                    'all_sub; ',
                    (super_category_name,))
        res = cur.fetchall()
    except Exception as e:
        return str(e)
    finally:
        cur.close()
        conn.close()

    return render_template("categories/categories.html", super_category_name=super_category_name, table=res)

# --- Create --- #


@app.route('/categories/create', methods=["GET"])
def create_categories_page():
    return render_template("categories/create_category.html")


@app.route('/categories/create/simple_category', methods=['POST'])
def create_simple_category():
    name = request.form["name"]

    try:
        conn = get_db_connection()
        cur = conn.cursor()
        cur.execute('INSERT INTO category VALUES (%s);', (name,))
        cur.execute('INSERT INTO simple_category VALUES (%s);', (name,))
        conn.commit()
    except Exception as e:
        return str(e)
    finally:
        cur.close()
        conn.close()

    return redirect(url_for('categories_page'))


@app.route('/categories/create/super_category', methods=['POST'])
def create_super_category():
    name = request.form["name"]
    sub_category_name = request.form["sub_category_name"]

    try:
        conn = get_db_connection()
        cur = conn.cursor()
        cur.execute('INSERT INTO category VALUES (%s);', (name,))
        cur.execute('INSERT INTO super_category VALUES (%s);', (name,))
        cur.execute('INSERT INTO has_other VALUES (%s, %s);',
                    (name, sub_category_name))
        conn.commit()
    finally:
        cur.close()
        conn.close()

    return redirect(url_for('categories_page'))


@app.route('/categories/create/sub_category', methods=['POST'])
def create_sub_category():
    super_category_name = request.form["super_category_name"]
    sub_category_name = request.form["sub_category_name"]

    try:
        conn = get_db_connection()
        cur = conn.cursor()
        cur.execute('INSERT INTO has_other VALUES (%s, %s);',
                    (super_category_name, sub_category_name))
        conn.commit()
    except Exception as e:
        return str(e)
    finally:
        cur.close()
        conn.close()

    return redirect(url_for('categories_page'))

# --- Delete --- #


@app.route('/categories/delete/', methods=['GET'])
def delete_categories_page():
    return render_template("categories/delete_category.html")


@app.route('/categories/delete/simple_category', methods=['POST'])
def delete_simple_category():
    name = request.form["name"]

    try:
        conn = get_db_connection()
        cur = conn.cursor()
        cur.execute(
            'DELETE FROM replenishment_event '
            'WHERE  ean IN (SELECT ean FROM product WHERE category_name = %s);', (name,))
        cur.execute(
            'DELETE FROM planogram '
            'WHERE  ean IN (SELECT ean FROM product WHERE category_name = %s);', (name,))
        cur.execute(
            'DELETE FROM has_category '
            'WHERE  ean IN (SELECT ean FROM product WHERE category_name = %s);', (name,))
        cur.execute(
            'DELETE FROM has_other '
            'WHERE ean IN (SELECT ean FROM product WHERE category_name = %s);', (name,))
        cur.execute('DELETE FROM product WHERE category_name = %s;', (name,))
        cur.execute(
            'DELETE FROM responsible_for WHERE category_name = %s', (name,))
        cur.execute('DELETE FROM replenishment_event '
                    'WHERE '
                    'nr IN (SELECT nr FROM shelve WHERE category_name = %s) '
                    'serial_nr IN (SELECT serial_nr FROM shelve WHERE category_name = %s) '
                    'manuf IN (SELECT manuf FROM shelve WHERE category_name = %s);', (name, name, name))
        cur.execute('DELETE FROM planogram '
                    'WHERE '
                    'nr IN (SELECT nr FROM shelve WHERE category_name = %s) '
                    'serial_nr IN (SELECT serial_nr FROM shelve WHERE category_name = %s) '
                    'manuf IN (SELECT manuf FROM shelve WHERE category_name = %s);', (name, name, name))
        cur.execute('DELETE FROM shelve WHERE category_name = %s', (name,))
        cur.execute(
            'DELETE FROM simple_category WHERE category_name = %s;', (name,))
        cur.execute('DELETE FROM category WHERE category_name = %s;', (name,))
        conn.commit()
    except Exception as e:
        return(str(e))
    finally:
        cur.close()
        conn.close()

    return redirect(url_for('categories_page'))


@app.route('/categories/delete/super_category', methods=['POST'])
def delete_super_category():
    name = request.form["name"]

    try:
        conn = get_db_connection()
        cur = conn.cursor()
        cur.execute(
            'DELETE FROM replenishment_event '
            'WHERE  ean IN (SELECT ean FROM product WHERE category_name = %s);', (name,))
        cur.execute(
            'DELETE FROM planogram '
            'WHERE  ean IN (SELECT ean FROM product WHERE category_name = %s);', (name,))
        cur.execute(
            'DELETE FROM has_category '
            'WHERE  ean IN (SELECT ean FROM product WHERE category_name = %s);', (name,))
        cur.execute('DELETE FROM has_other WHERE category = %s;', (name,))
        cur.execute('DELETE FROM has_other WHERE super_category = %s;', (name,))
        cur.execute('DELETE FROM product WHERE category_name = %s;', (name,))
        cur.execute(
            'DELETE FROM responsible_for WHERE category_name = %s', (name,))
        cur.execute('DELETE FROM shelve WHERE category_name = %s', (name,))
        cur.execute(
            'DELETE FROM super_category WHERE category_name = %s;', (name,))
        cur.execute('DELETE FROM category WHERE category_name = %s;', (name,))
        conn.commit()
    except Exception as e:
        return(str(e))
    finally:
        cur.close()
        conn.close()

    return redirect(url_for('categories_page'))

# -------------- Replenishments Page -------------- #


@app.route("/retailers/", methods=["GET"])
def retailers_page():
    return render_template("retailers/retailers.html")

# --- Create --- #


@app.route("/retailers/create", methods=["GET"])
def create_retailers_page():
    return render_template("retailers/create_retailer.html")


@app.route("/retailers/create", methods=["POST"])
def create_retailer():
    name = request.form["name"]
    tin = request.form["tin"]
    category_name = request.form["category_name"]
    serial_nr = request.form["serial_nr"]
    manuf = request.form["manuf"]

    try:
        conn = get_db_connection()
        cur = conn.cursor()
        cur.execute('INSERT INTO retailer VALUES (%s, %s);',
                    (tin, name))
        cur.execute('INSERT INTO responsible_for VALUES (%s, %s, %s, %s);',
                    (category_name, tin, serial_nr, manuf))
        conn.commit()
    except Exception as e:
        return str(e)
    finally:
        cur.close()
        conn.close()

    return redirect(url_for('retailers_page'))

# --- Delete --- #


@app.route("/retailers/delete", methods=["GET"])
def delete_retailers_page():
    return render_template("retailers/delete_retailer.html")


@app.route("/retailers/delete", methods=["POST"])
def delete_retailer():
    tin = request.form["tin"]

    try:
        conn = get_db_connection()
        cur = conn.cursor()
        cur.execute('DELETE FROM replenishment_event WHERE tin = %s;', (tin,))
        cur.execute('DELETE FROM responsible_for WHERE tin = %s;', (tin,))
        cur.execute('DELETE FROM retailer WHERE tin = %s;', (tin,))
        conn.commit()
    except Exception as e:
        return str(e)
    finally:
        cur.close()
        conn.close()

    return redirect(url_for('retailers_page'))

# -------------- Error Handlers -------------- #


@app.errorhandler(404)
def not_found_page():
    return render_template("errors/404.html"), 404


@app.errorhandler(500)
def internal_error_page():
    return render_template("errors/500.html"), 500
