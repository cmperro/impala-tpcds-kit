#!/bin/bash

users=( joe_analyst_0 ivanna_hr john_finance_0 ivanna_eu_hr_0 john_end_user jim_end_user user001 user002 user003 user004)
password=''
dm_knox_host=""
dm_impala_path=""
spark_database="tpcds_10_text_hive"
impala_database="tpcds_10_parquet"
hive_database="tpcds_10_orc"

for i in {1..2000}
do
   seleted_user_number=$(($RANDOM % 10))
   selected_user=${users[$seleted_user_number]}
   selected_host_number=$(($RANDOM % 3))
   query_num=$((1 + $RANDOM % 100))
   
   if [ $selected_host_number == 1 ]
   then
      echo "Hive"
      #cd /home/cperro/hive-testbench; echo $password | kinit $selected_user; bash run_some_hive_queries.sh $hive_database
   elif [ $selected_host_number == 2 ] 
   then
      echo "Spark"
      #cd /home/cperro/hive-testbench; echo $password | kinit $selected_user; spark3-submit run_some_spark_queries.py $query_num $spark_database
   else
      echo "Impala"
      cd /home/cperro/impala-tpcds-kit; bash run_some_impala_queries.sh $password $dm_knox_host $dm_impala_path $impala_database $selected_user
   fi
   

done
