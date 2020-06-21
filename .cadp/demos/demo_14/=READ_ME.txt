-- CADP (CONSTRUCTION AND ANALYSIS OF DISTRIBUTED PROCESSES)
-- http://cadp.inria.fr

[Last updated: Mon May 28 10:17:06 CEST 2018]

This directory contains the specification and verification of a Plain Old
Telephony Service (POTS). This example originates from Patrick Ernberg
(Swedish Institute of Computer Science), who developed, between 1992 and
1994, the LOTOS specification of POTS and its requirements expressed as
alternation-free mu-calculus formulas to be checked using CWB (Concurrency
Workbench).

Laurent Mounier expressed formally these requirements using the equivalence
and preorder checking capabilities of CADP. In parallel, Radu Mateescu
expressed and verified these requirements using the EVALUATOR tool of CADP. 

In 2001, Frederic Lang put this demo under the form of an SVL script. In 2014,
Hubert Garavel simplified and slightly corrected the LOTOS specification, and
extensively rewrote it into LNT. He also merged into one unique CADP demo the
two POTS demos that had existed separately so far. In 2015, Radu Mateescu
added formulas written in the MCL language and Frederic Lang rewrote the SVL
script to use "property"/"check" statements and to inline all formulas within
the SVL script.

Files:
   demo.svl		SVL description of the verification scenario
   pots.lnt		LNT specification of the POTS
   r*.aut		Graphs used for equivalence and preorder checking
   macros_v*.mcl	auxiliary macro-operators used in the requirements
   LOTOS/pots.lotos	former LOTOS specification of the POTS

The verification scenario described and commented in "demo.svl" is executed
by typing the command:
$	svl demo
or even simply
$	svl 

Typing the command
$	svl -clean demo
or even simply
$	svl -clean
allows to remove all files produced during the verification.

