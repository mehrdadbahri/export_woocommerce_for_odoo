mysql --defaults-extra-file=$mysql_connection_config_path $db_name -e \
	"SELECT
	concat('\"variant_', a.id, '\"') AS '\"product_id\"',
	concat('\"', b.meta_value, '\"') AS '\"image\"'
	FROM
	    ${db_name}.${wp_db_prefix}_posts AS a
		LEFT JOIN
	    (SELECT
		ba.post_id, bb.meta_value
	    FROM
		${db_name}.${wp_db_prefix}_postmeta AS ba
	    LEFT JOIN (SELECT
		post_id, meta_value
	    FROM
		${db_name}.${wp_db_prefix}_postmeta AS bba
	    WHERE
		meta_key = '_wp_attached_file') AS bb ON ba.meta_value = bb.post_id
	    WHERE
		meta_key = '_thumbnail_id') AS b ON a.id = b.post_id
	WHERE
	    a.post_type = 'product_variation'
		AND b.meta_value IS NOT NULL
		AND b.meta_value != 0
	LIMIT 1000000;"\
| sed 's/\t/,/g' > variant_imgs.csv
