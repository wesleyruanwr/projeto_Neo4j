MATCH (c:Country)<-[:LOCATED_IN]-(sc:ShowCatalog)
RETURN c.name_country AS country, count(sc) AS num_movies