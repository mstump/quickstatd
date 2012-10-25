#!/bin/bash

function repeat {
   while true
   do
      echo "$1" | /bin/bash
      sleep $graphite_interval_seconds
   done
}

CONFIG_FILE=$1
. $CONFIG_FILE
HOSTNAME=$(hostname -s)

echo "Launching df monitoring, reporting data to $graphite_host"
repeat "df -hP | gawk -f $QUICKSTATD_HOME/awk/df.awk hostname=$HOSTNAME graphite_host=$graphite_host graphite_port=$graphite_port"
 
