-- CADP (CONSTRUCTION AND ANALYSIS OF DISTRIBUTED PROCESSES)
-- http://cadp.inria.fr

[Last updated: Thu Aug 23 17:19:00 CEST 2018]

This directory contains an example for BCG_MIN, CAESAR, CAESAR.ADT, LNT2LOTOS,
and SVL. It describes a standard cache coherency protocol for a multiprocessor
architecture written in full LOTOS (with values) and in LNT (translated in May
2012). The system consists of four processes: one Remote Directory and three
Agents numbered Agent_1, Agent_2, and Agent_3.

This example shows how the state graph of protocol can be generated either 
directly, or compositionally. Compositional verification allows to generate
smaller state spaces and, thus, to control the state explosion problem. 

				-o-o-o-o-

For a compositional generation of the LOTOS and LNT specifications, type the
following command
$	svl demo
or simply: 
$	svl
which builds the Labelled Transition Systems "cache.bcg" and "LOTOS/cache.bcg"
using compositional verification.

Whatever the language used (LOTOS or LNT), the generated Labelled Transition
Systems are strongly equivalent. This is checked by the SVL script.

				-o-o-o-o-

Note: After the verification, you can type
$	svl -clean demo
or simply:
$	svl -clean
to remove all files produced during the verification.

				-o-o-o-o-

Miscellaneous remarks
---------------------

Using CAESAR 6.0, compositional generation produces a final state space of 
600 states and 1,925 transitions. Moreover, the sizes of the intermediate
state spaces produced using compositional generation never exceed 3,181
states and 56,546 transitions. 

Using CAESAR 7.0, compositional generation produces a final state space of 
600 states and 1,925 transitions. Moreover, the sizes of the intermediate
state spaces produced using compositional generation never exceed 2,881
states and 51,196 transitions. 

				-o-o-o-o-

For a direct generation of the LOTOS specification, type the following commands
$  cd LOTOS ; caesar.adt cache.lotos ; caesar cache.lotos ; bcg_info cache.bcg

Using CAESAR 6.0, direct generation produces a state space of 70,643 states
and 254,356 transitions.

Using CAESAR 7.0, direct generation produces a state space of 6,322 states
and 18,444 transitions only.

				-o-o-o-o-

For a direct generation of the LNT specification, type the following command:
$	lnt.open cache.lnt generator cache.bcg

We observed that for CAESAR 7.0 (but not CAESAR 6.0) the number of states
and transitions are the same for cache.bcg and LOTOS/cache.bcg.

				-o-o-o-o-

