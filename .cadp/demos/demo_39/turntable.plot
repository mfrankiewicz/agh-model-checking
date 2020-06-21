# Output terminal
set term postscript landscape color
 
# Output file
set output "turntable.ps"
  
# Label
set xlabel "Load"
set ylabel "Throughput"

# Scale and range
set autoscale x
set autoscale y
set yrange [0:0.6]

#############################################################################

# Title
set title "Product delivery throughput (large processing delays)"

# Plotting command
plot "tt_seq_0.5.thr" using 1:5 title "sequential" w linespoints, \
     "tt_par_0.5.thr" using 1:5 title "parallel" w linespoints

#############################################################################

# Title
set title "Product delivery throughput (medium processing delays)"

# Plotting command
plot "tt_seq_1.0.thr" using 1:5 title "sequential" w linespoints, \
     "tt_par_1.0.thr" using 1:5 title "parallel" w linespoints

#############################################################################

# Title
set title "Product delivery throughput (small processing delays)"

# Plotting command
plot "tt_seq_2.0.thr" using 1:5 title "sequential" w linespoints, \
     "tt_par_2.0.thr" using 1:5 title "parallel" w linespoints

#############################################################################

