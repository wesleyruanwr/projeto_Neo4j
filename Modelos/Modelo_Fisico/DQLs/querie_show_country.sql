SELECT sc.title_show, c.name_country
FROM show_catalog sc
INNER JOIN show_catalog_country scc ON sc.id_show_catalog = scc.fk_id_show_catalog
INNER JOIN country c ON scc.fk_id_country = c.id_country;