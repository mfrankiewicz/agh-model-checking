-- CADP (CONSTRUCTION AND ANALYSIS OF DISTRIBUTED PROCESSES)
-- http://cadp.inria.fr

[Last updated: Mon May 28 10:11:34 CEST 2018]

This directory describes the verification of a set of requirements
on the LOTOS specification of a POTS (Plain Old Telephony System).

The original version of these requirements has been proposed by P. Ernberg 
(SICS, Sweden). They were expressed as alternation-free mu-calculus formulas
and were checked using CWB (Concurrency Workbench).

Radu Mateescu expressed and verified these requirements using the EVALUATOR
tool of CADP. Note that this verification is performed on a version of the
POTS specification different from the one used by P. Ernberg, which explains
that the results sometimes differ. In 2001, Frederic Lang put this demo under
the form of an SVL script. In 2014, Hubert Garavel simplified and slightly
corrected the LOTOS specification, and translated it into LNT.

Files:

   demo.svl		SVL description of the verification scenario
   pots.lnt		LNT specification of the POTS
   requirement*.mcl	EVALUATOR specification of the requirements
   macros.mcl		auxiliary macro-operators used in the requirements
   LOTOS/pots.lotos	former LOTOS specification of the POTS

Typing the command
$       svl demo
or even simply
$       svl
will generate the labelled transition system corresponding to "pots.lotos"
and evaluate all the temporal logic formulas characterizing the proper 
functionning of the POTS. See the "demo.svl" file for comments. 

Note: A part of requirement 4 happens to be false (subscriber 2 cannot always
perform an offhook or an onhook). You can obtain more detailed diagnostic
information for this requirement by typing:
$	bcg_open pots.bcg evaluator -diag requirement04.mcl

After the verification, you can type
$       svl -clean demo.svl
or simply:
$       svl -clean
to remove all files produced during the verification.

