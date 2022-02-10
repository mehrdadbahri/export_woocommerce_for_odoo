mysql --defaults-extra-file=$mysql_connection_config_path $db_name -e \
	"SET @row_number = 0; SELECT concat('\"state_', b.term_id, '\"') as '\"id\"',
	concat('\"', b.name, '\"') as '\"name\"', concat('\"', (@row_number:=@row_number + 1), '\"') as '\"code\"', '\"base.ir\"' as '\"country_id/id\"'
FROM ${db_name}.${wp_db_prefix}_term_taxonomy as a left join ${db_name}.${wp_db_prefix}_terms as b on a.term_id = b.term_id
where a.taxonomy = 'state_city' and a.parent = 0;"\
| sed 's/\t/,/g' > states.csv
