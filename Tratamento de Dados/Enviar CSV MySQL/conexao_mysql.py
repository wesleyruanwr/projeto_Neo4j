import pandas as pd
import mysql.connector

arq = 'Arquivo CSV/Arquivo Refined/netflix_final.csv'
df = pd.read_csv(arq)

config = {
    'user': 'root',
    'password': 'root',
    'host': 'localhost',
    'port': 3306,
    'database': 'ufc'
}

con = mysql.connector.connect(**config)
cursor = con.cursor()

for index, row in df.iterrows():
    values = [None if pd.isna(value) else value for value in row.values] # coloca NONE no lugar NAN
    
    sql = """
    INSERT INTO show_catalog 
        (show_id, type_show, title, director, cast, country, date_added, release_year, rating, duration, listed_in, description_show) 
    VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
    """
    
    cursor.execute(sql, values)
    con.commit()  # da commit na transação toda vez que insere um dado

cursor.close()
con.close()
