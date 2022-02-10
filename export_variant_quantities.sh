mysql --defaults-extra-file=$mysql_connection_config_path $db_name -e \
	"SELECT concat('\"product_', a.ID, '\"') as '\"id\"',
	concat('\"', b.meta_value, '\"') as '\"quantity\"'
	FROM ${db_name}.${wp_db_prefix}_posts as a
	left join ${db_name}.${wp_db_prefix}_postmeta as b
	on a.ID = b.post_id and b.meta_key = \"_stock\"
	where a.ID in
	(SELECT a.ID FROM ${db_name}.${wp_db_prefix}_posts as a
	left join ${db_name}.${wp_db_prefix}_postmeta as b
	on a.ID = b.post_id and b.meta_key = \"_shop_swatches\"
	where a.post_type = \"product\" and a.post_status != 'trash'
	and b.meta_value = \"no\")"\
| sed 's/\t/,/g' > quantities.csv
