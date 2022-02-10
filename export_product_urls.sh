mysql --defaults-extra-file=$mysql_connection_config_path $db_name -e \
"SELECT concat('\"product_', a.ID, '\"') as '\"id\"', "\
"concat('\"', a.post_name, '\"') as '\"url\"' "\
"FROM ${db_name}.${wp_db_prefix}_posts as a "\
"where a.post_type = \"product\" and a.post_status != \"trash\" and a.post_name != \"\";"\
| sed 's/\t/,/g' > urls.csv
