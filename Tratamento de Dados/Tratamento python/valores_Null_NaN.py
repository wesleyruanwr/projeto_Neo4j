#tratando valores Null e Not a Number com o mesmo codigo pois são equivalentes

import pandas as pd

arq = 'Arquivo CSV/Arquivo RAW/netflix.csv'

df = pd.read_csv(arq)

df['director'].fillna("Indefinido", inplace=True)
df['cast'].fillna("Indefinido", inplace=True)
df['country'].fillna("Indefinido", inplace=True)
df['date_added'].fillna("Indefinido", inplace=True)
df['country'].fillna("Indefinido", inplace=True)
df['rating'].fillna("Indefinido", inplace=True)
df['duration'].fillna("Indefinido", inplace=True)


colunas_com_nan = df.columns[df.isna().any()].tolist()  #tambem podia usar df.isnull()
print("Colunas com valores NaN:", colunas_com_nan)
