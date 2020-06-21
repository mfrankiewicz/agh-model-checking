-- CADP (CONSTRUCTION AND ANALYSIS OF DISTRIBUTED PROCESSES)
-- http://cadp.inria.fr

[Last updated: Tue Feb  2 13:26:50 CET 2016]

This directory contains an example for BCG_MIN, BCG_STEADY, BISIMULATOR,
CAESAR, CAESAR.ADT, DETERMINATOR, EVALUATOR, and SVL. It describes the formal
specification in LOTOS, the functional verification (by model checking
and equivalence checking) and performance evaluation of a turntable system
dedicated to the drilling of metal products.

This example is freely adapted from two descriptions in the Chi language
presented in:

   V. Bos and J.J.T. Kleijn. Formal Specification and Analysis of
   Industrial Systems. PhD Thesis, Chapter 8, Technical University of
   Eindhoven, March 2002.

   E. Bortnik, N. Trcka, A.J. Wijs, S.P. Luttik, J.M. van de Mortel-Fronczak,
   J.C.M. Baeten, W.J. Fokkink, and J.E. Rooda. Analyzing a Chi Model of a
   Turntable System using Spin, CADP, and Uppaal. Journal of Logic and
   Algebraic Programming 65(2):51-104, November-December 2005.

The LOTOS specification of the turntable and the temporal logic properties
were written by R. Mateescu. See 
   http://cadp.inria.fr/publications/Mateescu-06-b.html
and
   http://cadp.inria.fr/publications/Mateescu-08.html
and
   http://cadp.inria.fr/case-studies/04-f-turntable.html
and the corresponding slideshow at
   ftp://ftp.inrialpes.fr/pub/vasy/presentations/Mateescu-ETR-05.pdf

The equivalence checking verification consists in comparing two versions
of the turntable system, equipped with a sequential and a parallel master
controller, respectively. The model checking verification consists in
evaluating a set of temporal logic properties on the two versions of the
turntable system.

The performance evaluation consists in computing the throughput of product
delivery for the two versions of the system, by varying the speed of the
various processing phases (drilling, testing, turning, etc.).

Files:
   ARCHITECTURE.lib     LOTOS specification of turntable architecture
   COMPONENTS.lib       LOTOS specification of physical devices and controllers
   CONTROLLER_PAR.lib   LOTOS specification of parallel master controller
   CONTROLLER_SEQ.lib   LOTOS specification of sequential master controller
   turntable_par.lotos  LOTOS specification (system with parallel controller)
   turntable_seq.lotos  LOTOS specification (system with sequential controller)
   demo.svl             SVL verification script
   Results/tt_*_*.thr   throughput data computed by CADP (output)
   Result/turntable.ps  PostScript file containing throughput figures

The demo can be run by typing
$       svl demo
or even simply
$       svl

After the verification you may type
$       svl -clean demo
or even simply
$       svl -clean
to remove all the generated files.

