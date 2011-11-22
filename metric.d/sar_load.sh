#!/bin/bash

DEFAULT_CONFIG_FILE="/etc/quickstatd.conf"
CONFIG_FILE=$1
if [ "$CONFIG_FILE" == "" ]
then
   CONFIG_FILE=$DEFAULT_CONFIG_FILE
fi
. $CONFIG_FILE
HOSTNAME=$(hostname -s)

echo "Launching sar load monitoring, reporting data to $graphite_host"
sar -q $graphite_interval_seconds 99999999999 | awk -f $QUICKSTATD_HOME/awk/sar_load.awk hostname=$HOSTNAME graphite_host=$graphite_host graphite_port=$graphite_port &
echo $! >> $PID_FILE
 
