-- CADP (CONSTRUCTION AND ANALYSIS OF DISTRIBUTED PROCESSES)
-- http://cadp.inria.fr

[Last updated: Tue May 22 09:31:44 CEST 2018]

This directory contains an example for BCG_MIN, CAESAR, EVALUATOR,
SVL and XTL. It describes Peterson's mutual exclusion algorithm.

* This example is taken from Michel Raynal's book "Algorithmique
* du parallelisme : le probleme de l'exclusion mutuelle", Dunod,
* Paris, 1984.

The LOTOS version was written by Radu Mateescu in 1997. The SVL
file was added by Frederic Lang and Hubert Garavel in 2001 and
enriched with temporal-logic formulas in 2015. The LNT version
was added in 2015 by Gianluca Barbon and Hubert Garavel.

Files:
   demo.svl               verification scenario
   peterson.lnt           algorithm description in LNT
   macros.mcl             common definitions for the MCL formulas
   LOTOS/peterson.lotos   algorithm description in LOTOS

You can perform the experiment by typing the command:
$       svl demo
or even simply
$	svl

Cleanup of the current directory can be obtained by typing:
$       svl -clean demo
or even simply
$	svl -clean

