mysql --defaults-extra-file=$mysql_connection_config_path $db_name -e \
	"SELECT concat('\"brand_', b.term_id, '\"') as '\"id\"',
	concat('\"', b.name, '\"') as '\"name\"'
	FROM ${db_name}.${wp_db_prefix}_term_taxonomy as a
	left join ${db_name}.${wp_db_prefix}_terms as b
	on a.term_id = b.term_id
	where taxonomy = \"yith_product_brand\";"\
| sed 's/\t/,/g' > brands.csv
