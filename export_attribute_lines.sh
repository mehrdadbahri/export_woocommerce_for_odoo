mysql --defaults-extra-file=$mysql_connection_config_path $db_name -e \
"SELECT
	concat('\"', oa.object_id, '\"') as '\"id\"',
	concat('\"', ob.taxonomy, '\"') as '\"attribute_id\"',
	concat('\"', GROUP_CONCAT(oc.term_id SEPARATOR '|'), '\"') as '\"attribute_values\"'
FROM
	${db_name}.${wp_db_prefix}_term_relationships AS oa
		LEFT JOIN
	${db_name}.${wp_db_prefix}_term_taxonomy AS ob ON oa.term_taxonomy_id = ob.term_taxonomy_id
		LEFT JOIN
	${db_name}.${wp_db_prefix}_terms AS oc ON oa.term_taxonomy_id = oc.term_id
WHERE
	ob.taxonomy LIKE 'pa%'
GROUP BY oa.object_id, ob.taxonomy;"\
| sed 's/\t/,/g' > lines.csv
