import pandas as pd
import mysql.connector

arq = 'Arquivo CSV/Arquivo RAW/netflix.csv'
df = pd.read_csv(arq)

config = {
    'user': 'root',
    'password': 'root',
    'host': 'localhost',
    'port': 3306,
    'database': 'mydb'
}

conn = mysql.connector.connect(**config)
cursor = conn.cursor()

for index, row in df.iterrows():
    sql = """
    INSERT INTO netflix_titles 
        (show_id, type, title, director, cast, country, date_added, release_year, rating, duration, listed_in) 
    VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
    """
    values = (
        row['show_id'], row['type'], row['title'], row['director'], row['cast'], 
        row['country'], row['date_added'], row['release_year'], row['rating'], 
        row['duration'], row['listed_in']
    )

cursor.close()
conn.close()