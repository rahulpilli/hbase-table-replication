#!/bin/bash
# export_snapshot.sh
# Run this script from source cluster 
# Replace table names, Active & Standby NameNodes 
# kinit with hbase user

# List of HBase tables to perform delta snapshots
tables=("TABLE_NAME_1" "TABLE_NAME_2" "TABLE_NAME_3" "TABLE_NAME_4")

# Directory to store the snapshots
snapshotDir="hdfs://ACTIVE_NAME_NODE_DESTINATION:8020/hbase"   # Active NameNode of destination cluster

# Get current timestamp
timestamp=$(date +"%F")
# Perform snapshots for each table
for table in "${tables[@]}"
do
    # Generate snapshot name using table name and timestamp
    snapshotName="${table}_snapshot_${timestamp}"

    # Execute hbase shell command to create the delta snapshot
    echo "Creating snapshot $snapshotName for table $table..."
    echo "snapshot '$table', '$snapshotName'" | hbase shell -n

    # Move the snapshot to the desired directory
    echo "Moving snapshot to destination cluster directory $snapshotDir..."
		
	export _JAVA_OPTIONS="-Xmx8g -Xms8g";
        
	hbase org.apache.hadoop.hbase.snapshot.ExportSnapshot -Dmapreduce.job.hdfs-servers.token-renewal.exclude=<STANDBY_NAMENODE_SOURCE,ACTIVE_NAMENODE_DESTINATION> -Dmapreduce.map.memory.mb=4000 -Dmapreduce.map.java.opts="-Xmx3200m"  -snapshot $snapshotName -copy-to $snapshotDir -mappers 16
done