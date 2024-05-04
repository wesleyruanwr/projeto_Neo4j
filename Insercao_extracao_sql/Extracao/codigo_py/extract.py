import mysql.connector
import pandas as pd
import os

config = {
    'user': 'root',
    'password': 'root',
    'host': 'localhost',
    'port': 3306,
    'database': 'ufc'
}

con = mysql.connector.connect(**config)
cursor = con.cursor()


diretorio = "Arquivo CSV/Arquivos_transição"


def extrair_tabela(table_name, csv_filename):
    sql = f"SELECT * FROM {table_name}"     # querie sql

    df = pd.read_sql(sql, con)

    csv_path = os.path.join(diretorio, csv_filename)
    df.to_csv(csv_path, index=False)


os.makedirs(diretorio, exist_ok=True) # se por acaso n tiver criado ele vai criar a pasta


extrair_tabela("show_extract", "show_extract.csv")


cursor.close()
con.close()
