
# $ sar -n DEV 1 11
# Linux 2.6.32-34-generic (ubuntu) 	11/16/2011 	_x86_64_	(2 CPU)
#
# 05:39:44 PM     IFACE   rxpck/s   txpck/s    rxkB/s    txkB/s   rxcmp/s   txcmp/s  rxmcst/s
# 05:39:45 PM        lo      8.00      8.00      0.58      0.58      0.00      0.00      0.00
# 05:39:45 PM      eth0      3.00      0.00      0.18      0.00      0.00      0.00      0.00


/^[0-9]/{
   if ($3=="IFACE") {
   }
   else {
      print "servers." hostname ".sar.network." $3 ".rxpck_persec " $4 " " systime() | "nc " graphite_host " " graphite_port
      print "servers." hostname ".sar.network." $3 ".txpck_persec " $5 " " systime() | "nc " graphite_host " " graphite_port
      print "servers." hostname ".sar.network." $3 ".rx_" units "_persec " $6 " " systime() | "nc " graphite_host " " graphite_port
      print "servers." hostname ".sar.network." $3 ".tx_" units "_persec " $7 " " systime() | "nc " graphite_host " " graphite_port
      print "servers." hostname ".sar.network." $3 ".rxcmp_persec " $8 " " systime() | "nc " graphite_host " " graphite_port
      print "servers." hostname ".sar.network." $3 ".txcmp_persec " $9 " " systime() | "nc " graphite_host " " graphite_port
      print "servers." hostname ".sar.network." $3 ".rxmcst_persec " $10 " " systime() | "nc " graphite_host " " graphite_port
   }
}

