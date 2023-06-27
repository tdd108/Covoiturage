import psycopg2
import psycopg2.extras

def connect():
  conn = psycopg2.connect(
    host = 'tdd.my.to',
    dbname = 'enjoy',
    user = 'postgres',
    password = '1',
    cursor_factory = psycopg2.extras.NamedTupleCursor
  )
  conn.autocommit = True
  return conn
