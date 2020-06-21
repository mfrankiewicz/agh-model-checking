-- CADP (CONSTRUCTION AND ANALYSIS OF DISTRIBUTED PROCESSES)
-- http://cadp.inria.fr

[Last updated: Tue Sep 11 10:54:16 CEST 2018]

It describes the verification of the "distributed leader election" case study
using CAESAR, CAESAR.ADT, LNT.OPEN, BCG_MIN, OPEN/CAESAR, BISIMULATOR,
EXHIBITOR, TERMINATOR, and SVL. 

This case study was first specified in LOTOS. It is presented in: 

* Hubert Garavel and Laurent Mounier. Specification and Verification of various
* Distributed Leader Election Algorithms for Unidirectional Ring Networks. 
* In Science of Computer Programming, Special issue on Industrially Relevant 
* Applications of Formal Analysis Techniques, Jan-Friso Groote and Martin Rem
* editors, 1996. Full version available as INRIA Research Report RR-2986.

See
   http://cadp.inria.fr/publications/Garavel-Mounier-96.html
and
   http://cadp.inria.fr/case-studies/96-f-leaderelection.html

Each experiment presented in the paper is numbered from 01 to 19. All
the LOTOS files and libraries are contained in the ./LOTOS directory.

Note: Due to improvements brought to the CAESAR compiler (i.e., state space
reductions), the graphs generated in the above experiments using recent 
versions of CADP might be smaller than reported in the Garavel-Mounier-96
paper. For instance, experiment 1 produces a graph with only 13 states and 17
transitions, while the Garavel-Mounier-96 reports 42 states and 52 transitions.
This is not a problem as both graphs are strongly bisimilar.

In January 2015, the original LOTOS specifications have been translated to
LNT by Wendelin Serwe. In August 2018, the LNT specifications have been
simplified by Hubert Garavel and integrated in the demo_17 of CADP.

Typing:
$	svl demo
or simply:
$	svl
will execute in turn all experiments of (the LNT and LOTOS versions of)
the demo.

Note: After the verification, you can type
$	svl -clean demo
or simply:
$	svl -clean
to remove all files produced during the verification.

