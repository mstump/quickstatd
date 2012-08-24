#
# expects mpstat data in this format:
#
# 04:41:27 PM  CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal  %guest   %idle
# 04:41:28 PM  all   16.16    0.00    2.02    0.00    0.00    0.00    0.00    0.00   81.82
# 04:41:28 PM    0    1.00    0.00    1.00    0.00    0.00    0.00    0.00    0.00   98.00
# 04:41:28 PM    1   31.96    0.00    2.06    0.00    0.00    0.00    0.00    0.00   65.98


/^[0-9][0-9]\:[0-9][0-9]\:[0-9][0-9] [A-Z][A-Z] +[0-9]+/{
   print "servers." hostname ".mpstat.cpu." $3 ".idle " $12 " " systime() | "nc " graphite_host " " graphite_port
}

