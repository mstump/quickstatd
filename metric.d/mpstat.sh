#!/bin/bash

CONFIG_FILE=$1
. $CONFIG_FILE
HOSTNAME=$(hostname -s)

echo "Launching vmstat monitoring, reporting data to $graphite_host"
mpstat -P ALL $graphite_interval_seconds | gawk -f $QUICKSTATD_HOME/awk/mpstat.awk hostname=$HOSTNAME graphite_host=$graphite_host graphite_port=$graphite_port &
echo $! >> $PID_FILE
 
