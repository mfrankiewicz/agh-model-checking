-- CADP (CONSTRUCTION AND ANALYSIS OF DISTRIBUTED PROCESSES)
-- http://cadp.inria.fr

[Last updated: Wed Mar 18 18:06:25 CET 2015]

This directory contains an example for BCG_MIN, BISIMULATOR, CAESAR, 
CAESAR.ADT, OPEN/CAESAR, and SVL. It describes a reliable atomic multicast
protocol written in full LOTOS (with values).

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

The file "demo.svl" describes the verification of the protocol.
You can execute it by typing:
$	svl demo
or even simply 
$	svl

Detailed explanations on the verification scenario are given in "demo.svl".

After execution of the SVL scenario, all generated files can be removed 
by typing
$	svl -clean demo
or even simply
$	svl -clean

