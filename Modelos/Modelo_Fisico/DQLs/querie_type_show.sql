SELECT sc.title_show, st.show_type
FROM show_catalog sc
INNER JOIN show_catalog_show_type scst ON sc.id_show_catalog = scst.fk_id_show_catalogs
INNER JOIN show_type st ON scst.fk_id_show_types = st.id_show_type;
