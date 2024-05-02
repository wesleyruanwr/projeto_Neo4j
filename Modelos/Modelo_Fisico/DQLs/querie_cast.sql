SELECT sc.title_show as Movie_Title, 
       GROUP_CONCAT(a.actor_name SEPARATOR ', ') as Cast_Names
FROM show_catalog sc
JOIN cast c ON sc.id_show_catalog = c.fk_id_show_catalog
JOIN actor a ON c.fk_id_actor = a.id_actor
GROUP BY sc.id_show_catalog;