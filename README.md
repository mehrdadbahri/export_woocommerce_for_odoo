# Export Woocommerce shop data to import inside Odoo

The following data are exported:
* Products
    * All general information like (name, description, price, ...)
    * Images
    * Stock info
    * Variants
* Categories
* Users
* States
* Cities

## How to use
Create a config file for mysql connection information like below:

    [client]
    user = "username"
    password = "password"
    host = "localhost"

Set the created config file path in the environment variable `mysql_connection_config_path`:

    export mysql_connection_config_path=~/mysql_connection.conf

Set the database name and your wordperss database prefix:

    export db_name=mydb
    export wp_db_prefix=wp

Turn off `sql_mode=only_full_group_by` option for mysql:

    SET GLOBAL sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));

Then run the each script in bash to get the exported data in csv format.
Then you can:
* Use Odoo import option to import the data in Odoo. Good luck with that :D
* Use This repository (link will be available soon) to import the data in Odoo using API.
