mysql --defaults-extra-file=$mysql_connection_config_path $db_name -e \
	"SELECT concat('\"product_category_', b.term_id, '\"') as '\"id\"',
	concat('\"', b.name, '\"') as '\"name\"',
	a.description as '\"website_description\"',
	concat('product_category_', a.parent) as '\"parent_id/id\"'
	FROM ${db_name}.${wp_db_prefix}_term_taxonomy as a
	left join ${db_name}.${wp_db_prefix}_terms as b
	on a.term_id = b.term_id
	where taxonomy = \"product_cat\";"\
| sed 's/\t/ة/g' > categories_temp.csv

out_file=categories.csv
in_file=categories_temp.csv
echo \"id\",\"name\",\"website_description\",\"parent_id/id\" > $out_file
i=1

while IFS="ة" read f1 f2 f3 f4; do
	if (($i))
	then
		i=0
		continue
	fi

	f3=${f3//,/\#\^\*\#\^}
	if [ "$f4" == "product_category_0" ];
	then
		f4=""
	fi

	echo $f1,$f2,\"${f3//\"/\\\"}\",\"$f4\" | sed 's/\rn/\\n/g' >> $out_file

done < $in_file
