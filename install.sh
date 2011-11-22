#!/bin/bash

# check for root
if [ $UID != "0" ]
then
   echo "The installer can only run with rootly privileges"
   exit 1
fi

# check for current directory
if ! ls awk/vmstat.awk > /dev/null 2>&1
then
   echo "Installer must be run from the quickstatd directory."
   exit 1
fi

DEFAULT_GRAPHITE_PORT="2003"
# get the install dir on the cmd line
INSTALL_DIR=$1
GRAPHITE_HOST=$2
MONITOR_INTERVAL=$3
GRAPHITE_PORT=$4
CONFIG="/etc/quickstatd.conf"

if [ "$MONITOR_INTERVAL" == "" ]
then
   echo "Usage: install.sh <install dir> <graphite host> <monitor interval seconds> [ graphite port (default=2003) ]"
   exit 1
fi
mkdir -p $INSTALL_DIR
if [ "$GRAPHITE_PORT" == "" ]
then
   GRAPHITE_PORT=$DEFAULT_GRAPHITE_PORT
fi

echo "QUICKSTATD_HOME=$INSTALL_DIR" > $CONFIG
echo >> $CONFIG

# copy bits to new dir
cp -r awk $INSTALL_DIR
cp -r metric.d $INSTALL_DIR
cat conf/quickstatd.conf >> $CONFIG
cp quickstatd /etc/init.d

echo "graphite_host=$GRAPHITE_HOST" >> $CONFIG
echo "graphite_port=$GRAPHITE_PORT" >> $CONFIG
echo "graphite_interval_seconds=$MONITOR_INTERVAL" >> $CONFIG


#if ! sar 1 1 > /dev/null 2>&1
#then
#   echo "WARNING: sysstat system package not found.  iostat and sar"
#   echo "         monitoring tools will be unavailable."
#fi

echo "quickstatd installed successfully to $INSTALL_DIR"


