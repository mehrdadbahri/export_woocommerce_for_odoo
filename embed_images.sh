out_file=products_with_images.csv
in_file=products.csv
i=1
line=1
NUMOFLINES=$(wc -l < "$in_file")

while IFS="|" read f1 f2 f3 f4 f5 f6 f7 f8 f9 f10 f11 f12 f13 f14 f15 f16 f17 f18 f19 f20 f21 f22 f23 f24 f25 f26 f27 f28 f29 f30 f31 f32 f33; do
	if (($i))
	then
		i=0
		continue
	fi

	if [ "$f4" == "publish" ];
	then
		f4=\"True\"
	else
		f4=\"False\"
	fi

	echo -n $f1,\"${f2//\"/\'}\",\"${f3//\"/\'}\",$f4,$f5,$f6,$f7,$f8,$f9,$f10,\"${f11//\"/\'}\",\"${f12//\"/\'}\",\"${f13//\"/\'}\",\"uploads/$f14\",\"uploads/$f15\" | tr -d '\r' >> $out_file

	if [ "$f16" != "image" ];
	then
		echo -n -e "\n,,,,,,,,,,,,,," >> $out_file
		echo -n \"uploads/$f16\" >> $out_file
	fi

	if [ "$f17" != "image" ];
	then
		echo -n -e "\n,,,,,,,,,,,,,," >> $out_file
		echo -n \"uploads/$f17\" >> $out_file
	fi

	if [ "$f18" != "image" ];
	then
		echo -n -e "\n,,,,,,,,,,,,,," >> $out_file
		echo -n \"uploads/$f18\" >> $out_file
	fi

	if [ "$f19" != "image" ];
	then
		echo -n -e "\n,,,,,,,,,,,,,," >> $out_file
		echo -n \"uploads/$f19\" >> $out_file
	fi

	if [ "$f20" != "image" ];
	then
		echo -n -e "\n,,,,,,,,,,,,,," >> $out_file
		echo -n \"uploads/$f20\" >> $out_file
	fi

	if [ "$f21" != "image" ];
	then
		echo -n -e "\n,,,,,,,,,,,,,," >> $out_file
		echo -n \"uploads/$f21\" >> $out_file
	fi

	if [ "$f22" != "image" ];
	then
		echo -n -e "\n,,,,,,,,,,,,,," >> $out_file
		echo -n \"uploads/$f22\" >> $out_file
	fi

	if [ "$f23" != "image" ];
	then
		echo -n -e "\n,,,,,,,,,,,,,," >> $out_file
		echo -n \"uploads/$f23\" >> $out_file
	fi

	if [ "$f24" != "image" ];
	then
		echo -n -e "\n,,,,,,,,,,,,,," >> $out_file
		echo -n \"uploads/$f24\" >> $out_file
	fi

	if [ "$f25" != "image" ];
	then
		echo -n -e "\n,,,,,,,,,,,,,," >> $out_file
		echo -n \"uploads/$f25\" >> $out_file
	fi

	if [ "$f26" != "image" ];
	then
		echo -n -e "\n,,,,,,,,,,,,,," >> $out_file
		echo -n \"uploads/$f26\" >> $out_file
	fi

	if [ "$f27" != "image" ];
	then
		echo -n -e "\n,,,,,,,,,,,,,," >> $out_file
		echo -n \"uploads/$f27\" >> $out_file
	fi

	if [ "$f28" != "image" ];
	then
		echo -n -e "\n,,,,,,,,,,,,,," >> $out_file
		echo -n \"uploads/$f28\" >> $out_file
	fi

	if [ "$f29" != "image" ];
	then
		echo -n -e "\n,,,,,,,,,,,,,," >> $out_file
		echo -n \"uploads/$f29\" >> $out_file
	fi

	if [ "$f30" != "image" ];
	then
		echo -n -e "\n,,,,,,,,,,,,,," >> $out_file
		echo -n \"uploads/$f30\" >> $out_file
	fi


	echo '' >> $out_file
	echo $((NUMOFLINES - line))
	line=$((line+1))
done < $in_file
