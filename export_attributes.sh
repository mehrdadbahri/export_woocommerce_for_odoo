mysql --defaults-extra-file=$mysql_connection_config_path $db_name -e \
	"SELECT concat('\"', taxonomy, '\"') as '\"id\"',
	concat('\"', taxonomy, '\"') as '\"name\"'
	FROM ${db_name}.${wp_db_prefix}_term_taxonomy
	where taxonomy like \"pa_%\" group by taxonomy;"\
| sed 's/\t/|/g' > attributes_temp.csv

out_file=attributes.csv
in_file=attributes_temp.csv
echo \"id\",\"name\" > $out_file
i=1

while IFS="|" read f1 f2; do
	if (($i))
	then
		i=0
		continue
	fi

	name=${f2//pa_/}
	echo $f1,${name//-/ } >> $out_file

done < $in_file
