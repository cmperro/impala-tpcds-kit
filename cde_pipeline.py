from airflow import DAG
from airflow.operators.bash_operator import BashOperator
from airflow.utils import timezone
from cloudera.cdp.airflow.operators.cde_operator import CDEJobRunOperator
from datetime import timedelta
from dateutil import parser

dag = DAG(
    dag_id='CP_DAG',
    start_date=parser.isoparse('2024-09-26T14:08:13Z').replace(tzinfo=timezone.utc),
    schedule_interval=None,
    is_paused_upon_creation=False,
    default_args={
        'owner': 'cperro',
    },
)

Job1 = CDEJobRunOperator(
    job_name='CMP_TEST_CDE',
    trigger_rule='all_success',
    task_id='Job1',
    dag=dag,
)

Sleep1 = BashOperator(
    bash_command='''sleep_time=$((1 + $RANDOM % 60))
sleep $sleep_time''',
    trigger_rule='all_success',
    task_id='Sleep1',
    dag=dag,
)

Job2 = CDEJobRunOperator(
    job_name='CMP_TEST_CDE',
    task_id='Job2',
    dag=dag,
)

Job3 = CDEJobRunOperator(
    job_name='CMP_TEST_CDE',
    task_id='Job3',
    dag=dag,
)

Sleep2 = BashOperator(
    bash_command='''sleep_time=$((1 + $RANDOM % 60))
sleep $sleep_time''',
    trigger_rule='all_success',
    task_id='Sleep2',
    dag=dag,
)

cde_job_1 = CDEJobRunOperator(
    job_name='CMP_TEST_CDE',
    task_id='cde_job_1',
    dag=dag,
)

cde_job_2 = CDEJobRunOperator(
    job_name='CMP_TEST_CDE',
    task_id='cde_job_2',
    dag=dag,
)

cde_job_3 = CDEJobRunOperator(
    job_name='CMP_TEST_CDE',
    task_id='cde_job_3',
    dag=dag,
)

Sleep3 = BashOperator(
    bash_command='''sleep_time=$((1 + $RANDOM % 60))
sleep $sleep_time''',
    task_id='Sleep3',
    dag=dag,
)

cde_job_4 = CDEJobRunOperator(
    job_name='CMP_TEST_CDE',
    task_id='cde_job_4',
    dag=dag,
)

Sleep4 = BashOperator(
    bash_command='''sleep_time=$((1 + $RANDOM % 60))
sleep $sleep_time''',
    task_id='Sleep4',
    dag=dag,
)

Sleep1 << [Job1]
Job2 << [Sleep1]
Job3 << [Sleep1]
Sleep2 << [Job2, Job3]
cde_job_1 << [Sleep2]
cde_job_2 << [Sleep2]
cde_job_3 << [Sleep2]
Sleep3 << [cde_job_3, cde_job_2]
cde_job_4 << [cde_job_1]
Sleep4 << [cde_job_4, Sleep3]
