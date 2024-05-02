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
    # Verifica se há valores 'nan' e substitui por None
    values = [None if pd.isna(value) else value for value in row.values]
    
    sql = """
    INSERT INTO netflix_titles 
        (show_id, type_show, title, director, cast, country, date_added, release_year, rating, duration, listed_in, description_show) 
    VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
    """
    
    cursor.execute(sql, values)
    con.commit()  # Commit a transação após cada inserção de dados

cursor.close()
con.close()
