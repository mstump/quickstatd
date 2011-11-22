#!/bin/bash

DEFAULT_CONFIG_FILE="/etc/quickstatd.conf"
CONFIG_FILE=$1
if [ "$CONFIG_FILE" == "" ]
then
   CONFIG_FILE=$DEFAULT_CONFIG_FILE
fi
. $CONFIG_FILE
HOSTNAME=$(hostname -s)

# get the units -- bytes or KB?
U=$(sar -n DEV 1 1 | head -4 | awk '/IFACE/{print $6}')
if [ "$U" == "rxkB/s" ]
then
   UNITS="kb"
else
   UNITS="bytes"
fi

echo "Launching sar network monitoring, reporting data to $graphite_host"
sar -n DEV $graphite_interval_seconds 99999999999 | awk -f $QUICKSTATD_HOME/awk/sar_network.awk hostname=$HOSTNAME graphite_host=$graphite_host graphite_port=$graphite_port units=$UNITS &
echo $! >> $PID_FILE
 
