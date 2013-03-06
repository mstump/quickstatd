#!/bin/bash

CONFIG_FILE=$1
. $CONFIG_FILE
HOSTNAME=$(hostname|sed 's/\./_/g')

echo "Launching iostat monitoring, reporting data to $graphite_host"
iostat -xm $graphite_interval_seconds | gawk -f $QUICKSTATD_HOME/awk/iostat.awk hostname=$HOSTNAME graphite_host=$graphite_host graphite_port=$graphite_port &
echo $! >> $PID_FILE
