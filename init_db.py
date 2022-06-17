import os
import psycopg2

HOST = "localhost"
DATABASE = "flask_db"
USER = os.environ['DB_USERNAME']
PASSWORD = os.environ['DB_PASSWORD']

conn = psycopg2.connect(host=HOST, 
                        database=DATABASE, 
                        user=USER, 
                        password=PASSWORD)

flask_db_cursor = conn.cursor()

flask_db_cursor.execute('DROP TABLE IF EXISTS books;')
flask_db_cursor.execute('CREATE TABLE books (id serial PRIMARY KEY,'
                                 'title varchar (150) NOT NULL,'
                                 'author varchar (50) NOT NULL,'
                                 'pages_num integer NOT NULL,'
                                 'review text,'
                                 'date_added date DEFAULT CURRENT_TIMESTAMP);'
                                 )
flask_db_cursor.execute('INSERT INTO books (title, author, pages_num, review)'
            'VALUES (%s, %s, %s, %s)',
            ('A Tale of Two Cities',
             'Charles Dickens',
             489,
             'A great classic!')
            )
flask_db_cursor.execute('INSERT INTO books (title, author, pages_num, review)'
            'VALUES (%s, %s, %s, %s)',
            ('Anna Karenina',
             'Leo Tolstoy',
             864,
             'Another great classic!')
            )
flask_db_cursor.execute('INSERT INTO books (title, author, pages_num, review)'
            'VALUES (%s, %s, %s, %s)',
            ('O Ano da Morte de Ricardo Reis',
             'José Saramago',
             503,
             'Yet another great classic!')
            )

conn.commit()
flask_db_cursor.close()
conn.close()