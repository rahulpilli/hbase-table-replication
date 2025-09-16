#!/bin/bash
# Run this script from source cluster
# Replace table names, Active & Standby NameNodes 
# kinit with hbase user

tables=("TABLE_NAME_1" "TABLE_NAME_2" "TABLE_NAME_3" "TABLE_NAME_4")

   for table in "${tables[@]}"
    do
        echo "Performing delta copy for $table"
        hbase org.apache.hadoop.hbase.mapreduce.Export -Dmapreduce.job.hdfs-servers.token-renewal.exclude=<STANDBY_NAMENODE_SOURCE,STANDBY_NAMENODE_DESTINATION> $table hdfs://<ACTIVE_NAMENODE_DESTINATION>:8020/tmp/delta_snapshot/"$table"_delta_snapshot 3 <start_time_in_epoch> #1693931400
        echo "Complete delta copy for $table"
    done