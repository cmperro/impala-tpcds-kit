#!/bin/bash 

knox_host=${2}
http_path=${6}
db_name=${4}
password=${1}
user=${3}
exec_env=${5}

#Run a random query
query_num=$((1 + $RANDOM % 100))
echo "Running Query" $query_num

if [ $exec_env == "datahub" ]
then
    impala-shell --verbose --var=DB=$db_name -i $knox_host:443 --protocol=hs2-http --http_path=$http_path --ssl -l -u $user --ldap_password_cmd="echo -n $password" -f queries/query$query_num.sql
else
    impala-shell --verbose --var=DB=$db_name -i $knox_host:443 --protocol=hs2-http  --ssl -l -u $user --ldap_password_cmd="echo -n $password" -f queries/query$query_num.sql
fi

#Wait a random amount of time
sleep_time=$((1 + $RANDOM % 60))
echo "Sleeping for " $sleep_time " seconds"
sleep $sleep_time