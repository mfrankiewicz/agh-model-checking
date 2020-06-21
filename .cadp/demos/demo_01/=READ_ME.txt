-- CADP (CONSTRUCTION AND ANALYSIS OF DISTRIBUTED PROCESSES)
-- http://cadp.inria.fr

[Last updated: Wed Feb 12 14:16:09 CET 2020]

This directory contains an example for CAESAR, BISIMULATOR, EVALUATOR, SVL, 
TGV, and XTL. It describes a variant of the alternating bit protocol written 
in basic LOTOS (i.e., without data values).

The whole verification scenario is described and commented in the file 
"demo.svl". It can be executed by typing:
$	svl demo
or even simply 
$	svl

After execution of the SVL scenario, all generated files can be removed by 
typing
$	svl -clean demo
or even simply
$	svl -clean
