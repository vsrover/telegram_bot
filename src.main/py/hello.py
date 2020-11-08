import psycopg2

print("Connecting to DB")
conn = psycopg2.connect(dbname='bot', user='postgres', password='postgres', host='127.0.0.1', port=5444)
cursor = conn.cursor()
res = cursor.execute('select * from bot_table_main')
records = cursor.fetchall()
print(records)
cursor.close()
conn.close()
