
# Expects data in the 'sar -q 1 1' format:
#
# Linux 2.6.32-34-generic (ubuntu) 	11/16/2011 	_x86_64_	(2 CPU)
#
# 04:12:30 PM   runq-sz  plist-sz   ldavg-1   ldavg-5  ldavg-15
# 04:12:31 PM         0       429      0.27      0.31      0.33
# Average:            0       429      0.27      0.31      0.33

/^[0-9]/{
   if ($3=="runq-sz") {
   }
   else {
      print "servers." hostname ".sar.load.runq-sz " $3 " " systime() | "nc " graphite_host " " graphite_port 
      print "servers." hostname ".sar.load.plist-sz " $4 " " systime() | "nc " graphite_host " " graphite_port
      print "servers." hostname ".sar.load.ldavg-1 " $5 " " systime() | "nc " graphite_host " " graphite_port
      print "servers." hostname ".sar.load.ldavg-5 " $6 " " systime() | "nc " graphite_host " " graphite_port
      print "servers." hostname ".sar.load.ldavg-15 " $7 " " systime() | "nc " graphite_host " " graphite_port 
   }
}

