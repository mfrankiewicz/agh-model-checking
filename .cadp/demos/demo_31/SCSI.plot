# Output terminal
set term postscript landscape color
 
# Output file
set output "SCSI.ps"
  
# Label
set xlabel "Load"
set ylabel "Throughput"

# Scale
set autoscale x
set autoscale y

#############################################################################

# Title
set title "High priority disk throughput for different values of bus delay"

# Plotting command
plot "SCSI_A_400.thr" using 1:5 title "2.5 ms" w linespoints, \
     "SCSI_A_4000.thr" using 1:5 title "250 microseconds" w linespoints, \
     "SCSI_A_40000.thr" using 1:5 title "25 microseconds" w linespoints

#############################################################################

# Title
set title "Low priority disk throughput for different values of bus delay"

# Plotting command
plot "SCSI_A_400.thr" using 1:3 title "2.5 ms" w linespoints, \
     "SCSI_A_4000.thr" using 1:3 title "250 microseconds" w linespoints, \
     "SCSI_A_40000.thr" using 1:3 title "25 microseconds" w linespoints

#############################################################################

# Title
set title "Load-dependent throughput for high priority disk"

# Plotting command
plot "SCSI_A_400.thr" using 1:5 title "controller=7" w linespoints, \
     "SCSI_B_400.thr" using 1:5 title "controller=1" w linespoints, \
     "SCSI_C_400.thr" using 1:5 title "controller=0" w linespoints

#############################################################################

# Title
set title "Load-dependent throughput for low priority disk"

# Plotting command
plot "SCSI_A_400.thr" using 1:3 title "controller=7" w linespoints, \
     "SCSI_B_400.thr" using 1:3 title "controller=1" w linespoints, \
     "SCSI_C_400.thr" using 1:3 title "controller=0" w linespoints

#############################################################################


