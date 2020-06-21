-- CADP (CONSTRUCTION AND ANALYSIS OF DISTRIBUTED PROCESSES)
-- http://cadp.inria.fr

[Last updated: Wed Feb 12 14:15:24 CET 2020]

This directory contains an example for BCG_MIN, BISIMULATOR, CAESAR, 
CAESAR.ADT, OPEN/CAESAR, and SVL. It describes a car overtaking protocol
written in full LOTOS (with values).

* This example originates from the Swedish Institute of Computer Science
* It is described in detail in:
*    P. Ernberg, L. Fredlund, B. Jonsson:
*    Specification and Validation of a Simple Overtaking Protocol
*    using LOTOS. SICS Technical Report T90006, 1990

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

You can also simulate the overtaking protocol interactively, using the
OCIS interactive simulator. This is done by using the front-end shell
script for OPEN/CAESAR:

$	lotos.open -english overtaking.lotos ocis
