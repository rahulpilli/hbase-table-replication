#!/bin/bash
# restore_snapshot.sh
# Run this script from destination cluster 
# Replace table names, Active & Standby NameNodes 
# kinit with hbase user

tables=("TABLE_NAME_1" "TABLE_NAME_2" "TABLE_NAME_3" "TABLE_NAME_4")
timestamp=$(date +"%F")
snapshotName="${table}_snapshot_${timestamp}"

for table in "${tables[@]}"
    do
        echo "Disabling table $table..."
        echo "disable '$table'" | hbase shell -n

        echo "Restoring table $table from snapshot..."
        echo "restore_snapshot '${table}_snapshot_${timestamp}'" | hbase shell -n

        echo "Enabling table $table..."
        echo "enable '$table'" | hbase shell -n
    done
