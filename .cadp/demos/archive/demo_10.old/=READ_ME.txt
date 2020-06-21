-- CADP (CONSTRUCTION AND ANALYSIS OF DISTRIBUTED PROCESSES)
-- http://cadp.inria.fr - Copyright (C) INRIA 2011

[Last updated: Tue Nov 10 12:18:41 CET 2009]

This directory contains an example for CAESAR, CAESAR.ADT, BCG_MIN,
BISIMULATOR, and SVL.
It describes a variant of the alternating bit protocol written in full LOTOS
(with values).

* This example is presented in appendix C of:
*    Hubert Garavel. Compilation et ve'rification de programmes LOTOS.
*    The`se de Doctorat, Universite' Joseph-Fourier (Grenoble), Nov 89

This example shows how the alternating bit protocol can be verified
compositionally. A non-compositional verification of the same protocol
is described in directory ../demo_02.

The file "demo.svl" describes the verification of the protocol.
You can execute it by typing:
$       svl demo.svl
or even simply 
$       svl

After the verification, you can type
$	svl -clean demo.svl
or simply:
$	svl -clean
to remove all files produced during the verification.

