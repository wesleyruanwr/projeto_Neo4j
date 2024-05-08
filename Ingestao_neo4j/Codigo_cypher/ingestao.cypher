// para usar esse codigo diretamente no neo4j, seu arquivo de extração deve estar na pasta import
// do seu dbms que no meu caso é "C:\Users\Wesley Ruan\.Neo4jDesktop\relate-data\dbmss\dbms-6e906cf1-d4bf-4775-8f94-f11a74e3f7aa\import"



CREATE INDEX FOR (a:Actor) ON (a.actor_name);       //criar os index antes fez o tempo total de criacao cair de 17 min para 5 min

CREATE INDEX FOR (c:Country) ON (c.name_country);

CREATE INDEX FOR (d:Director) ON (d.director_name);


LOAD CSV WITH HEADERS FROM 'file:///show_extract.csv' AS row
CREATE (:ShowCatalog {
    id: toInteger(row.show_id),
    type_show: row.type_show,
    title: row.title,
    director: row.director,
    cast: row.cast,
    country: row.country,
    date_added: row.date_added,
    release_year: toInteger(row.release_year),
    rating: row.rating,
    duration: row.duration,
    listed_in: row.listed_in,
    description_show: row.description_show
});


LOAD CSV WITH HEADERS FROM 'file:///show_extract.csv' AS row
MATCH (sc:ShowCatalog {id: toInteger(row.show_id)})
UNWIND split(row.cast, ',') AS actor_name
MERGE (a:Actor {actor_name: trim(actor_name)})
CREATE (sc)-[:HAS_CAST]->(a);

LOAD CSV WITH HEADERS FROM 'file:///show_extract.csv' AS row
MATCH (sc:ShowCatalog {id: toInteger(row.show_id)})
MERGE (c:Country {name_country: row.country})
CREATE (sc)-[:LOCATED_IN]->(c);

LOAD CSV WITH HEADERS FROM 'file:///show_extract.csv' AS row
MATCH (sc:ShowCatalog {id: toInteger(row.show_id)})
MERGE (d:Director {director_name: row.director})
CREATE (sc)-[:DIRECTED_BY]->(d);
