#!/bin/bash

DEFAULT_CONFIG_FILE="/etc/quickstatd.conf"
CONFIG_FILE=$1
if [ "$CONFIG_FILE" == "" ]
then
   CONFIG_FILE=$DEFAULT_CONFIG_FILE
fi
. $CONFIG_FILE
HOSTNAME=$(hostname -s)

echo "Launching iostat monitoring, reporting data to $graphite_host"
iostat -xm $graphite_interval_seconds | awk -f $QUICKSTATD_HOME/awk/iostat.awk hostname=$HOSTNAME graphite_host=$graphite_host graphite_port=$graphite_port &
echo $! >> $PID_FILE
 
