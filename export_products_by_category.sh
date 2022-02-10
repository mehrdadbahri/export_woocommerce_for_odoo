mysql --defaults-extra-file=$mysql_connection_config_path $db_name -e \
"SELECT concat('\"product_', a.ID, '\"') as '\"id\"', "\
"a.post_title as '\"name\"', "\
"a.post_excerpt as '\"website_description\"', "\
"concat('\"', a.post_status, '\"') as '\"website_published\"', "\
"concat('\"', b.meta_value, '\"') as '\"default_code\"', "\
"concat('\"', f.meta_value, '\"') as '\"price\"', "\
"concat('\"brand_', l.meta_value, '\"') as '\"brand\"', "\
"concat('\"',\"True\",'\"') as '\"sale_ok\"', "\
"concat('\"',\"True\",'\"') as '\"purchase_ok\"', "\
"concat('\"',\"product\",'\"') as '\"type\"', "\
"d.meta_value as '\"website_meta_title\"', "\
"e.meta_value as '\"website_meta_description\"', "\
"concat('\"', m.meta_value, '\"') as '\"website_public_categ_ids\"', "\
"j.meta_value as '\"image_1920\"', "\
"k.meta_value as '\"product_template_image_ids/image_1920\"', "\
"'image' as '\"image\"', "\
"'image' as '\"image\"', "\
"'image' as '\"image\"', "\
"'image' as '\"image\"', "\
"'image' as '\"image\"', "\
"'image' as '\"image\"', "\
"'image' as '\"image\"', "\
"'image' as '\"image\"', "\
"'image' as '\"image\"', "\
"'image' as '\"image\"', "\
"'image' as '\"image\"', "\
"'image' as '\"image\"', "\
"'image' as '\"image\"', "\
"'image' as '\"image\"', "\
"'image' as '\"image\"' "\
"FROM ${db_name}.${wp_db_prefix}_posts as a "\
"left join "\
"(SELECT post_id, meta_value FROM ${db_name}.${wp_db_prefix}_postmeta where meta_key = \"_sku\") as b "\
"on a.ID = b.post_id "\
"left join "\
"(SELECT post_id, meta_value FROM ${db_name}.${wp_db_prefix}_postmeta where meta_key = \"product_garanty\") as c "\
"on a.ID = c.post_id "\
"left join "\
"(SELECT post_id, meta_value FROM ${db_name}.${wp_db_prefix}_postmeta where meta_key = \"_yoast_wpseo_title\") as d "\
"on a.ID = d.post_id "\
"left join "\
"(SELECT post_id, meta_value FROM ${db_name}.${wp_db_prefix}_postmeta where meta_key = \"_yoast_wpseo_metadesc\") as e "\
"on a.ID = e.post_id "\
"left join "\
"(SELECT post_id, meta_value FROM ${db_name}.${wp_db_prefix}_postmeta where meta_key = \"_regular_price\") as f "\
"on a.ID = f.post_id "\
"left join "\
"(SELECT post_id, meta_value FROM ${db_name}.${wp_db_prefix}_postmeta where meta_key = \"_sale_price\") as g "\
"on a.ID = g.post_id "\
"left join "\
"(SELECT post_id, meta_value FROM ${db_name}.${wp_db_prefix}_postmeta where meta_key = \"_shop_swatches\") as h "\
"on a.ID = h.post_id "\
"left join "\
"(SELECT post_id, meta_value FROM ${db_name}.${wp_db_prefix}_postmeta where meta_key = \"_weight\") as i "\
"on a.ID = i.post_id "\
"left join "\
"(SELECT ja.post_id, jb.meta_value FROM ${db_name}.${wp_db_prefix}_postmeta as ja "\
"left join ${db_name}.${wp_db_prefix}_postmeta as jb "\
"on jb.post_id = ja.meta_value and jb.meta_key = \"_wp_attached_file\" "\
"where ja.meta_key = \"_thumbnail_id\") as j "\
"on a.ID = j.post_id "\
"left join "\
"(select ka.post_id, group_concat(kb.meta_value separator 'ة') as meta_value from "\
"(SELECT kaa.post_id as post_id, kab.attachment_id as attachment_id FROM ${db_name}.${wp_db_prefix}_postmeta as kaa "\
"join "\
"json_table( "\
"replace(json_array(kaa.meta_value), ',', '\",\"'), "\
"'$\[*]' columns (attachment_id varchar(50) path '$') "\
") as kab "\
"where kaa.meta_key = \"_product_image_gallery\" and kaa.meta_value is not null and kaa.meta_value != '') as ka "\
"left join ${db_name}.${wp_db_prefix}_postmeta as kb "\
"on kb.post_id = ka.attachment_id and kb.meta_key = \"_wp_attached_file\" group by ka.post_id) as k "\
"on a.ID = k.post_id "\
"left join "\
"(SELECT post_id, meta_value FROM ${db_name}.${wp_db_prefix}_postmeta where meta_key = \"_yoast_wpseo_primary_yith_product_brand\") as l "\
"on a.ID = l.post_id "\
"left join "\
"(SELECT ma.object_id, group_concat(ma.term_taxonomy_id separator '|') as meta_value "\
"FROM ${db_name}.${wp_db_prefix}_term_relationships AS ma "\
"JOIN ${db_name}.${wp_db_prefix}_term_taxonomy AS mb ON ma.term_taxonomy_id = mb.term_taxonomy_id "\
"WHERE mb.taxonomy = 'product_cat' "\
"AND mb.term_id IN (12225,15010,7917,4537,4679,4543,471,3443,345,3431,3417,1028,4978,1027,1022,1021, "\
"1036,1041,1034,1040,1035,1038,1037,10655,1032,1033,1045,1043,1046,1047,1044,1039,11276,12847,10658, "\
"10662,10657,10664,10665,10660,11857,11275,11273,11274,1317,1316,1318,1312,1319,1315,1314,1313,13277, "\
"13285,13589,13590,13710,13726,15197,13725,15196,15206,15216,15219,15220,15217,15218,15204,15200,15210, "\
"15211,15208,15203,15867,15212,1611,15215,15214,15213,1567,15205,15202,15201,15199,15209,16817,1631,16910, "\
"1630,1636,1633,1641,16818,1635,1637,16909,1643,1644,1642,1639,16120,16341,16340,1629,1628,1638,1646, "\
"1647,1627,1645,1634,1640,1648,1632,16915,16916,16913,16912,16919,16920,16924,17811,16973,17921,17983, "\
"17928,17931,17948,17924,17925,17930,17926,17927,17923,17929,17996,17985,17984,17986,17987,17994,17995, "\
"17993,3069,5318,229,3668,3671,270,2491,311,3672,5290,292,22,5470,5316,545,5473,5301,5319,3670,18026, "\
"18025,4378,2612,5469,3666,380,290,5474,324,535,281,5317,3059,3669,3095,5315,5314,5320,3060,303,3667, "\
"5322,262,251,5310,5552,5550,5553,5551,5557,6274,7348,606,6969,5563,6251,7349,5555,6273,6271,5556,701, "\
"6957,6272,6019,5558,7927,7929,7928,7353,7352) group by ma.object_id) as m "\
"on a.ID = m.object_id "\
"where a.post_type = \"product\" and a.post_status != \"trash\" and h.meta_value = \"no\";"\
| sed 's/\t/ة/g' > products_temp.csv

out_file=products.csv
in_file=products_temp.csv
echo \"id\",\"name\",\"website_description\",\"website_published\",\"default_code\",\"lst_price\",\"product_brand_id/id\",\
	\"sale_ok\",\"purchase_ok\",\"type\",\"website_meta_title\",\"website_meta_description\", \"website_public_categ_ids\",\
	\"image\",\"images/image\" > $out_file;
	i=1
	line=1
	NUMOFLINES=$(wc -l < "$in_file")

	while IFS="ة" read f1 f2 f3 f4 f5 f6 f7 f8 f9 f10 f11 f12 f13 f14 f15 f16 f17 f18 f19 f20 f21 f22 f23 f24 f25 f26 f27 f28 f29 f30 f31 f32 f33; do
		if (($i))
		then
			i=0
			continue
		fi

		if [ "$f4" == "\"publish\"" ];
		then
			f4=\"True\"
		else
			f4=\"False\"
		fi

		f2=${f2//,/\#\^\*\#\^}
		f3=${f3//,/\#\^\*\#\^}
		f11=${f11//,/\#\^\*\#\^}
		f12=${f12//,/\#\^\*\#\^}
		f13=${f13//,/\#\^\*\#\^}

		echo -n $f1,\"${f2//\"/\\\"}\",\"${f3//\"/\\\"}\",$f4,$f5,$f6,$f7,$f8,$f9,$f10,\"${f11//\"/\\\"}\",\"${f12//\"/\\\"}\",\"${f13//\"/\\\"}\",$f14,\"$f15\",\"$f16\" | sed 's/\rn/\\n/g' >> $out_file

		if [ "$f16" != "image" ];
		then
			echo -n ,\"$f16\" >> $out_file
		fi

		if [ "$f17" != "image" ];
		then
			echo -n ,\"$f17\" >> $out_file
		fi

		if [ "$f18" != "image" ];
		then
			echo -n ,\"$f18\" >> $out_file
		fi

		if [ "$f19" != "image" ];
		then
			echo -n ,\"$f19\" >> $out_file
		fi

		if [ "$f20" != "image" ];
		then
			echo -n ,\"$f20\" >> $out_file
		fi

		if [ "$f21" != "image" ];
		then
			echo -n ,\"$f21\" >> $out_file
		fi

		if [ "$f22" != "image" ];
		then
			echo -n ,\"$f22\" >> $out_file
		fi

		if [ "$f23" != "image" ];
		then
			echo -n ,\"$f23\" >> $out_file
		fi

		if [ "$f24" != "image" ];
		then
			echo -n ,\"$f24\" >> $out_file
		fi

		if [ "$f25" != "image" ];
		then
			echo -n ,\"$f25\" >> $out_file
		fi

		if [ "$f26" != "image" ];
		then
			echo -n ,\"$f26\" >> $out_file
		fi

		if [ "$f27" != "image" ];
		then
			echo -n ,\"$f27\" >> $out_file
		fi

		if [ "$f28" != "image" ];
		then
			echo -n ,\"$f28\" >> $out_file
		fi

		if [ "$f29" != "image" ];
		then
			echo -n ,\"$f29\" >> $out_file
		fi

		if [ "$f30" != "image" ];
		then
			echo -n ,\"$f30\" >> $out_file
		fi


    #echo $(echo ${f13} | tr -d '\r' | tr -d '"' | xargs) | base64 --wrap=0 >> $2

    echo '' >> $out_file
    echo $((NUMOFLINES - line))
    line=$((line+1))
done < $in_file
