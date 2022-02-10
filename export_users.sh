mysql --defaults-extra-file=$mysql_connection_config_path $db_name -e \
	"select user_data.* from (
	select concat('\"user_', a.uid, '\"') as '\"id\"',
		concat('\"', a.meta_value, \" \", b.meta_value, '\"') as '\"name\"',
		concat('\"', coalesce(concat('0', c.meta_value),
				e.meta_value, f.meta_value), '\"') as '\"login\"',
		concat('\"', u.user_login, '\"') as '\"dummy_field\"',
		concat('\"', u.user_pass, '\"') as '\"wp_pass\"',
		concat('\"', u.user_email, '\"') as '\"email\"',
		concat('\"', d.meta_value, '\"') as '\"street\"',
		concat('\"', coalesce(concat('0', c.meta_value),
				e.meta_value, f.meta_value), '\"') as phone,
		concat('\"', g.meta_value, '\"') as '\"zip\"',
		concat('\"state_', h.meta_value, '\"') as '\"state_id/id\"',
		concat('\"', i.city_name, '\"') as '\"city\"' from
		(SELECT ID, user_login, user_email, user_pass FROM ${db_name}.${wp_db_prefix}_users) as u
		left join
		(SELECT user_id as uid, meta_value FROM ${db_name}.${wp_db_prefix}_usermeta where meta_key = 'first_name') as a
		on u.ID = a.uid
		left join
		(SELECT user_id as uid, meta_value FROM ${db_name}.${wp_db_prefix}_usermeta where meta_key = 'last_name') as b
		on a.uid = b.uid
		left join
		(SELECT user_id as uid, meta_value FROM ${db_name}.${wp_db_prefix}_usermeta where meta_key = 'digits_phone_no') as c
		on a.uid = c.uid
		left join
		(SELECT user_id as uid, meta_value FROM ${db_name}.${wp_db_prefix}_usermeta where meta_key = 'billing_address_1') as d
		on a.uid = d.uid
		left join
		(SELECT user_id as uid, meta_value FROM ${db_name}.${wp_db_prefix}_usermeta where meta_key = 'billing_phone' and meta_value != '') as e
		on a.uid = e.uid
		left join
		(SELECT user_id as uid, meta_value FROM ${db_name}.${wp_db_prefix}_usermeta where meta_key = 'billing_mobile') as f
		on a.uid = f.uid
		left join
		(SELECT user_id as uid, meta_value FROM ${db_name}.${wp_db_prefix}_usermeta where meta_key = 'billing_postcode' and CHAR_LENGTH(meta_value) = 10) as g
		on a.uid = g.uid
		left join
		(SELECT h1.user_id as uid, h2.term_id as meta_value FROM ${db_name}.${wp_db_prefix}_usermeta as h1 left join ${db_name}.${wp_db_prefix}_terms as h2 on h1.meta_value = h2.term_id where h1.meta_key = 'billing_state') as h
		on a.uid = h.uid
		left join
		(SELECT i1.user_id as uid, i1.meta_value, i2.name as city_name FROM ${db_name}.${wp_db_prefix}_usermeta as i1 left join ${db_name}.${wp_db_prefix}_terms as i2 on i1.meta_value = i2.term_id where i1.meta_key = 'billing_city') as i
		on a.uid = i.uid
		) as user_data where phone is not null group by(phone);"\
			| sed 's/\t/,/g' | sed 's/NULL/\"\"/g' | sed 's/"0+98/"0/g' | sed 's/"state_"//g' > users.csv
