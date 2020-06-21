-- CADP (CONSTRUCTION AND ANALYSIS OF DISTRIBUTED PROCESSES)
-- http://cadp.inria.fr

[Last updated: Thu Jan  7 17:03:45 CET 2016]

This directory contains an example for BCG, CAESAR, CAESAR.ADT,
BCG_TRANSIENT, LNT2LOTOS, and SVL. It describes the specification and
the computation of time dependent througput measures of a simple failure
model for the Hubble space telescope.  After generation, the state
space is first transformed into an Interactive Markov Chain, then
reduced to a Continuous Time Markov Chain, and finally analysed at
various time points. A graphics is produced using Gnuplot.

* The specification is described in:
*   H. Hermanns. Construction and Verification of Performance and  
*   Reliability Models. Bulletin of the European Association of 
*   Theoretical Computer Science 74:135-154, 2001.

The model was originally specified in LOTOS and translated to LNT in 2013.

The computed throughput measures indicate how the activities related
to the failures and repairs of the telescope change as time advances,
and how they fade out on the long run. 

Files:
   hubble.lnt		LNT specification (behaviour)
   hubble.plot		Gnuplot input file
   demo.svl		SVL verification script
   LOTOS/hubble.lotos	LOTOS specification (behaviour)
   LOTOS/demo.svl	SVL verification script
   doc/paper.pdf	H. Hermanns' paper (EATCS 2001 bulletin)
   doc/slides.pdf	H. Garavel's slides (CNAM 2011 lecture)
 
The verification scenario is described and commented in the file "demo.svl".
It can be run by typing
$       svl demo
or even simply
$       svl

After the verification you may type
$       svl -clean demo
or even simply
$       svl -clean
to remove all the generated files.

