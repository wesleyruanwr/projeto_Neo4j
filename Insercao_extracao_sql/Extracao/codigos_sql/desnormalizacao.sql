ALTER TABLE show_catalog
ADD COLUMN type_show VARCHAR(100);		-- precisa ser feito para evitar valores nulos na coluna type_show
UPDATE show_catalog sc
JOIN show_type st ON sc.duration_type_id = st.id_show_type
SET sc.type_show = st.show_type;


INSERT IGNORE INTO show_extract (       -- em versoes anteriores precisavado ignore para evitar valores duplicados
    show_id,
    type_show,
    title,
    director,
    cast,
    country,
    date_added,
    release_year,
    rating,
    duration,
    listed_in,
    description_show
)
SELECT
    sc.id_show_catalog AS show_id,
    sc.type_show AS type_show,
    sc.title_show AS title,
    GROUP_CONCAT(DISTINCT d.director_name) AS director,
    GROUP_CONCAT(DISTINCT a.actor_name) AS cast,
    GROUP_CONCAT(DISTINCT c.name_country) AS country,
    sc.date_added AS date_added,
    sc.release_year AS release_year,
    sc.rating AS rating,
    CONCAT(sc.duration, ' ', dt.type_name) AS duration,
    sc.listed_in AS listed_in,
    sc.description_show AS description_show
FROM
    show_catalog sc
LEFT JOIN
    show_catalog_director scd ON sc.id_show_catalog = scd.fk_id_show_catalog
LEFT JOIN
    director d ON scd.fk_id_director = d.id_director
LEFT JOIN
    cast ca ON sc.id_show_catalog = ca.fk_id_show_catalog
LEFT JOIN
    actor a ON ca.fk_id_actor = a.id_actor
LEFT JOIN
    show_catalog_country scc ON sc.id_show_catalog = scc.fk_id_show_catalog
LEFT JOIN
    country c ON scc.fk_id_country = c.id_country
LEFT JOIN
    duration_type dt ON sc.duration_type_id = dt.id_duration_type
GROUP BY
    sc.id_show_catalog, sc.title_show, sc.date_added, sc.release_year, sc.rating, sc.listed_in, sc.description_show;
