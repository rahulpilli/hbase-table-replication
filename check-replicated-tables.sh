#!/bin/bash
# check-replicated-tables.sh
# Run as hbase user

# Define the email details
SENDER="SENDER"
RECIPIENT="RECIPIENT_EMAIL"
SUBJECT="CLUSTER_NAME - HBase Replicated Tables"

# Use HBase shell to get the list of replicated tables
REPLICATED_TABLES=$(echo 'list_replicated_tables' | hbase shell 2>/dev/null | awk 'BEGIN {print "+------------------------------------------+\n| Tables  |\n+------------------------------------------+"} NR>6 {print "|", $1, " |\n+------------------------------------------+"}')

# Check if any tables are replicated
if [[ $REPLICATED_TABLES != "+------------------------------------------+\n| Tables  |\n+------------------------------------------+" ]]; then
    # Send the email
    echo -e "Replicated tables found:\n$REPLICATED_TABLES" | mail -r "$SENDER" -s "$SUBJECT" "$RECIPIENT"
fi
