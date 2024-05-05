MATCH (sc:ShowCatalog)
WHERE sc.release_year = $ano    //definir o ano que voce quer
RETURN sc.title AS title, sc.release_year AS release_year