#!/bin/bash

password=''
oozie_knox_endpoint=""
bucket=""

for i in {0..47}
do
   #Sandbox
   selected_user='etl_user_0'

   if [[ $(( $i % 3 )) == 0 ]]
   then
      echo "Running Map Reduce Job"
      cd /home/cperro/impala-tpcds-kit/tpcds-gen; echo $password | kinit $selected_user; hadoop jar target/tpcds-gen-1.0-SNAPSHOT.jar -d s3a://${bucket}/data/tpcds_300_text -p 30 -s 300; hdfs dfs -rm -r -skipTrash s3a://${bucket}/data/tpcds_300_text
      echo "Running Oozie Job"
      cd /home/cperro/impala-tpcds-kit/oozie-wf; echo $password | kinit $selected_user; oozie job -oozie ${oozie_knox_endpoint} -auth BASIC -username $selected_user -password ${password} -config job.properties -run
   else
      echo "Running Oozie Job"
      cd /home/cperro/impala-tpcds-kit/oozie-wf; echo $password | kinit $selected_user; oozie job -oozie ${oozie_knox_endpoint} -auth BASIC -username $selected_user -password ${password} -config job.properties -run
   fi
   echo $(date)
   echo "Sleeping for an hour"
   sleep 3600

done