from neo4j import GraphDatabase
import csv

neo4j_url = "bolt://localhost:7687"
neo4j_username = "neo4j"
neo4j_password = "wr99582435"

arq = 'Arquivo CSV/Arquivo Refined/netflix_trusted.csv'


def inserir_neo4j(neo4j_url, neo4j_username, neo4j_password, csv_file):

    conexao = GraphDatabase.driver(neo4j_url, auth=(neo4j_username, neo4j_password))     #conectando com o neo4j


    with conexao.session() as session:
        with open(csv_file, 'r', encoding='utf-8') as file:
            reader = csv.DictReader(file)
            for row in reader:              #querie para inserir o nó "show"

                query = (
                    "CREATE (:Show {id_show_catalog: $id_show_catalog, type_show: $type_show, title: $title, director: $director, cast: $cast, "
                    "country: $country, date_added: $date_added, release_year: $release_year, rating: $rating, duration: $duration, listed_in: $listed_in, description: $description})"
                )
                session.run(query, row)

    conexao.close()

inserir_neo4j(neo4j_url, neo4j_username, neo4j_password, arq)
