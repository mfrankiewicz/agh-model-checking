-- CADP (CONSTRUCTION AND ANALYSIS OF DISTRIBUTED PROCESSES)
-- http://cadp.inria.fr

[Last updated: Wed Mar 18 18:35:27 CET 2015]

This directory contains an example for BCG, BISIMULATOR, CAESAR, CAESAR.ADT, 
EVALUATOR, OPEN/CAESAR, PROJECTOR, and SVL. It describes a reliable atomic 
multicast protocol written in full LOTOS (with values).

* This example originates from the HP Labs in Bristol.
* It is described in detail in:
*    Simon Bainbridge and Laurent Mounier
*    Specification and Verification of a Reliable Multicast Protocol
*    Hewlett-Packard Laboratories Bristol, U.K.
*    HPL-91-163, oct 1991
* It is summarized in:
*    Fernandez, Garavel, Mounier, Rasse, Rodriguez, and Sifakis
*    A Toolbox for the Verification of LOTOS Programs
*    Proceedings of the 14th International Conference on Software 
*    Engineering ICSE'14 (Melbourne, Australia), may 1992
*    Lori A. Clarke, editor, ACM.

This example shows how the rel/REL protocol can be verified
compositionally with user-given interfaces for a network composed of 1
Transmitter and 3 Receiver nodes. A verification of the same protocol
for 2 Receiver nodes is described in directory ../demo_08.

The verification scenario, described and commented in file "demo.svl",
can be executed by typing the following command:
$	svl demo
or even simply:
$	svl

After verification, you can type
$	svl -clean demo
or even simply 
$	svl -clean
to remove all files produced during execution of the scenario.

The following tables summarize the sizes of the generated LTSs, before
and after minimization modulo strong equivalence, using either CAESAR 6.0 
(CADP 2001 "Ottawa") or CAESAR 7.0 (CADP 2006 "Edinburgh"). 

Let Ri = (RECEIVER_NODE_i -||? "ri_interface.lotos") (i = 1, 2, 3)
     T = CRASH_TRANSMITTER
    A1 = (R2 |[R23, R32]| R3) -|[RT_2, RT_3]| T
    A2 = (R1 |[R12, R21, R13, R31]| A1) -|[RT_1, RT_2, RT_3]| T
and  F = hide ... in (A2 |[RT_1, RT_2, RT_3]| T)

Using CAESAR 6.0:

+----+-----------------------++-----------------------+
|    | before  minimization  ||  after  minimization  |
|6.0 +---------+-------------++---------+-------------+
|    | states  | transitions || states  | transitions |
+----+---------+-------------++---------+-------------+
| Ri |  16,674 |     108,047 ||   1,088 |      14,883 |
+----+---------+-------------++---------+-------------+
| T  |     187 |         264 ||      50 |         151 |
+----+---------+-------------++---------+-------------+
| A1 |  66,929 |     969,382 ||  31,475 |     431,072 |
+----+---------+-------------++---------+-------------+
| A2 | 311,775 |   2,672,613 ||  71,423 |     616,538 |  
+----+---------+-------------++---------+-------------+
| F  | 286,117 |   2,302,600 || 150,911 |   1,249,375 |
+----+---------+-------------++---------+-------------+

Using CAESAR 7.0:

+----+-----------------------++-----------------------+
|    | before  minimization  ||  after  minimization  |
|7.0 +---------+-------------++---------+-------------+
|    | states  | transitions || states  | transitions |
+----+---------+-------------++---------+-------------+
| Ri |   1,086 |       8,290 ||     369 |       7,313 |
+----+---------+-------------++---------+-------------+
| T  |     187 |         264 ||      50 |         151 |
+----+---------+-------------++---------+-------------+
| A1 |  22,557 |     481,830 ||  21,644 |     457,552 |
+----+---------+-------------++---------+-------------+
| A2 | 212,545 |   2,453,385 || 137,086 |   1,535,507 |
+----+---------+-------------++---------+-------------+
| F  | 692,429 |   6,737,959 || 150,911 |   1,249,375 |
+----+---------+-------------++---------+-------------+

