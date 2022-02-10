mysql --defaults-extra-file=$mysql_connection_config_path $db_name -e \
	"SELECT concat(
	'\"',
	REPLACE(option_name, \"_transient_wc_var_prices_\", \"product_\"),
	'\"') as '\"id\"',
	option_value as '\"value\"'
	FROM ${db_name}.${wp_db_prefix}_options
	where option_name like \"_transient_wc_var_prices_%\""\
| sed 's/\t/ة/g' > variant_prices_temp.csv

out_file=variant_prices.csv
in_file=variant_prices_temp.csv

echo \"id\",\"value\" > $out_file;
i=1
while IFS="ة" read f1 f2; do
	if (($i))
	then
		i=0
		continue
	fi

	f2=${f2//,/\#\^\*\#\^}

	echo -n $f1,\"${f2//\"/\\\"}\" | sed 's/\rn/\\n/g' >> $out_file

	echo '' >> $out_file
done < $in_file
