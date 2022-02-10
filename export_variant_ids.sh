mysql --defaults-extra-file=$mysql_connection_config_path $db_name -e \
	"SELECT
	concat('\"product_', a.post_parent, '\"') as '\"product_id\"',
	concat('\"', b.object_id, '\"') as '\"variant_id\"',
	concat('\"', b.term_taxonomy_id, '\"') as '\"value_id\"'
	FROM
	${db_name}.${wp_db_prefix}_posts as a left join
	${db_name}.${wp_db_prefix}_term_relationships as b on
	a.id = b.object_id
	where a.post_type = 'product_variation' and
	b.object_id is not NULL and b.term_taxonomy_id != 10
	limit 1000000;"\
| sed 's/\t/,/g' > variant_ids.csv
