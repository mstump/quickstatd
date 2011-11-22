# | "nc 172.17.2.100 2003"
#
# expects vmstat data in this format:
#
# procs -----------memory---------- ---swap-- -----io---- -system-- ----cpu----
# r  b   swpd   free   buff  cache   si   so    bi    bo   in   cs us sy id wa
# 0  0      0 192380 315556 1537288    0    0     6    14  116   40  2  1 96  0


/.*[0-9]/{
   # PROCS
   print "servers." hostname ".vmstat.procs.running " $1 " " systime() | "nc " graphite_host " " graphite_port
   print "servers." hostname ".vmstat.procs.blocked " $2 " " systime() | "nc " graphite_host " " graphite_port

   # MEMORY
   print "servers." hostname ".vmstat.mem.swapped " $3 " " systime() | "nc " graphite_host " " graphite_port
   print "servers." hostname ".vmstat.mem.free " $4 " " systime() | "nc " graphite_host " " graphite_port
   print "servers." hostname ".vmstat.mem.buffer " $5 " " systime() | "nc " graphite_host " " graphite_port
   print "servers." hostname ".vmstat.mem.cache " $6 " " systime() | "nc " graphite_host " " graphite_port
   
   # SWAP
   print "servers." hostname ".vmstat.swap.in " $7 " " systime() | "nc " graphite_host " " graphite_port
   print "servers." hostname ".vmstat.swap.out " $8 " " systime() | "nc " graphite_host " " graphite_port

   # I/O
   print "servers." hostname ".vmstat.io.blocks_in " $9 " " systime() | "nc " graphite_host " " graphite_port
   print "servers." hostname ".vmstat.io.blocks_out " $10 " " systime() | "nc " graphite_host " " graphite_port

   # SYSTEM
   print "servers." hostname ".vmstat.sys.interrupts " $11 " " systime() | "nc " graphite_host " " graphite_port
   print "servers." hostname ".vmstat.sys.ctxt_switches " $12 " " systime() | "nc " graphite_host " " graphite_port

   # CPU
   print "servers." hostname ".vmstat.cpu.user " $13 " " systime() | "nc " graphite_host " " graphite_port
   print "servers." hostname ".vmstat.cpu.system " $14 " " systime() | "nc " graphite_host " " graphite_port
   print "servers." hostname ".vmstat.cpu.idle " $15 " " systime() | "nc " graphite_host " " graphite_port
   print "servers." hostname ".vmstat.cpu.iowait " $16 " " systime() | "nc " graphite_host " " graphite_port
}

