#!usr/bin/python3

from flask import Flask
from flask import render_template, request, url_for, redirect, abort

from connection import get_db_connection

app = Flask(__name__)


@app.errorhandler(404)
def page_not_found(error):
    return render_template('404.html'), 404

@app.errorhandler(500)
def internal_error(error):
    return render_template('500.html'), 500

@app.route('/', methods=['GET'])
def index():
    try:
        conn = get_db_connection()
        cur = conn.cursor()
        cur.execute('SELECT * FROM books;')
        books = cur.fetchall()
    except Exception as _:
        abort(400)
    finally:
        cur.close()
        conn.close()

    return render_template('index.html', books=books)

@app.route('/create/', methods=['GET'])
def create():
    return render_template('create.html')

@app.route('/create/', methods=['POST'])
def create_book():
    title = request.form['title']
    author = request.form['author']
    pages_num = int(request.form['pages_num'])
    review = request.form['review']
    values = (title, author, pages_num, review)

    try:
        conn = get_db_connection()
        cur = conn.cursor()
        cur.execute('INSERT INTO books (title, author, pages_num, review)' 
                    'VALUES (%s, %s, %s, %s)', values)
    except Exception as _:
        abort(400)
    finally:
        conn.commit()
        cur.close()
        conn.close()

    return redirect(url_for('index'))
