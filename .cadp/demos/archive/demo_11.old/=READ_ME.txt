-- CADP (CONSTRUCTION AND ANALYSIS OF DISTRIBUTED PROCESSES)
-- http://cadp.inria.fr - Copyright (C) INRIA 2011

[Last updated: Tue Jan  3 17:25:49 MET 2006]

This directory contains an example for CAESAR, CAESAR.ADT, BCG_MIN,
BISIMULATOR, and SVL. It describes a reliable atomic multicast 
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

This example shows how the rel/REL protocol can be verified compositionally. 
A non-compositional verification of the same protocol is described in 
directory ../demo_08.

The rel/REL protocol is divided into five processes:
	- Crash_Transmitter
	- Fail_Receiver1
	- Fail_Receiver2
	- Receiver_Thread1
	- Receiver_Thread2

For each of these processes, the corresponding LTS is generated and
reduced modulo strong equivalence. The five reduced LTSs are composed 
together (using LOTOS parallel and hiding operators) as described in the
"./demo.svl" file.

By typing the command:
$	svl demo
or simply:
$	svl
all the LTSs are generated and reduced automatically, producing 
"rel_rel.exp".

Note: After the verification, you can type
$	svl -clean demo
or simply:
$	svl -clean
to remove all files produced during the verification.

