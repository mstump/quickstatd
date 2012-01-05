#print "servers." hostname ".sar.load.runq-sz " $3 " " systime() | "nc " graphite_host " " graphite_port
# expects 'df -h' data in this format:
# Filesystem            Size  Used Avail Use% Mounted on
# /dev/sda1              39G  8.2G   29G  23% /
# udev                  2.0G  4.0K  2.0G   1% /dev
# tmpfs                 793M  760K  793M   1% /run
# none                  5.0M     0  5.0M   0% /run/lock
# none                  2.0G  700K  2.0G   1% /run/shm


{
   if ($1=="Filesystem") {
   }
   else {
      gsub(/\//, "_", $6)
      print "servers." hostname ".df.use." $6 " " substr($5,0,length($5)-1) " " systime() | "nc " graphite_host " " graphite_port
   }
}

