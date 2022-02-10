mysql --defaults-extra-file=$mysql_connection_config_path $db_name -e \
	"SELECT concat('\"attribiute_value_', a.term_id, '\"') as '\"id\"',
	a.name as '\"name\"',
	concat('\"', b.taxonomy, '\"') as '\"attribute_id/id\"'
	FROM ${db_name}.${wp_db_prefix}_terms as a
	left join ${db_name}.${wp_db_prefix}_term_taxonomy b on a.term_id = b.term_id
	where b.taxonomy like \"pa_%\";"\
| sed 's/\t/ّ/g' > attribute_values_temp.csv

out_file=attribute_values.csv
in_file=attribute_values_temp.csv
echo \"id\",\"name\",\"attribute_id/id\" > $out_file
i=1

while IFS="ّ" read f1 f2 f3; do
	if (($i))
	then
		i=0
		continue
	fi

	echo $f1,\"${f2//\"/\'}\",$f3 >> $out_file

done < $in_file
