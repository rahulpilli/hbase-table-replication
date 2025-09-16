#!/bin/bash
# Run this script from destination cluster 
# Replace table names
# kinit with hbase user

tables=("TABLE_NAME_1" "TABLE_NAME_2" "TABLE_NAME_3" "TABLE_NAME_4")

   for table in "${tables[@]}"
    do
        echo "Importing delta copy for $table"
        hbase org.apache.hadoop.hbase.mapreduce.Import $table /tmp/delta_snapshot/"$table"_delta_snapshot
        echo "Completed Importing delta copy for $table"
    done