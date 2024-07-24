#!/bin/bash

knox_host="per1-dm-master0.per1-cdp.a465-9q4k.cloudera.site"
http_path="per1-dm/cdp-proxy-api/impala"
db_name="tpcds_1000_parquet"


#Run a random query
query_num=$((1 + $RANDOM % 100))
echo "Running Query" $query_num

impala-shell --var=DB=$db_name -i $knox_host:443 --protocol=hs2-http --http_path=$http_path --ssl -l --ldap_password_cmd='echo -n "Eddie0102!!@@"' -f queries/query$query_num.sql

#Wait a random amount of time
sleep_time=$((1 + $RANDOM % 60))
echo "Sleeping for " $sleep_time " seconds"
sleep $sleep_time