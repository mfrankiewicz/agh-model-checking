# Title
set title "Time-dependent activities for Hubble"

# Output terminal
set term postscript landscape color
 
# Output file
set output "hubble.ps"
  
# Label
set xlabel "Time (years)"
set ylabel "Throughput"

# Scale
set logscale x
set autoscale y

# Plotting command
plot "hubble.thr" using 1:4 title "HUBBLE suspend" w linespoints

