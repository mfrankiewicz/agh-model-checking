-- CADP (CONSTRUCTION AND ANALYSIS OF DISTRIBUTED PROCESSES)
-- http://cadp.inria.fr - Copyright (C) INRIA 2012

[Last updated: Thu Aug 30 14:37:13 CEST 2018]

This directory contains a specification in LNT (formerly LOTOS NT) of a
Dynamic Task Dispatcher (DTD), which is a hardware circuit designed as a
part of (an early version of) the platform 2012 project of STMicroelectronics.

This case study is presented in [Lantreibecq-Serwe-14]; a simplified version
was described in [Lantreibecq-Serwe-11]. This directory contains the source
code for all the scenarios mentioned in [Lantreibecq-Serwe-14].

Note: The LNT code of this directory differs from the code given as appendix
in [Lantreibecq-Serwe-14], because this directory uses the "only if" construct
(added to LNT in December 2014) rather than the syntactic sugar "when"
defined in [Lantreibecq-Serwe-14, footnote 2]. Another difference is the
replacement of the String type by dedicated enumerated types, making possible
the distributed state space generation using DISTRIBUTOR. Finally, several
small changes were made to avoid warning messages emitted by LNT2LOTOS:
some gate parameters of processes LEAF, SLAVE, and MASTER have been removed,
some case instructions have been made exhaustive, etc.

Note: In August 2018, Radu Mateescu slightly modified the property PHI_1 to
bound the iterations of the "exists" operator, which made the verification
of this property much faster than reported in [Lantreibecq-Serwe-14].

This demo uses (among others) the following CADP tools: BCG_MIN, EVALUATOR 4.0,
LNT.OPEN, and SVL. 

To execute all scenarios (but 3_3, 8_1, and 8_2) for four processors and the
model where all processors have booted before arrival of the first job request
from the host processor, type:
$	svl demo
or even simply 
$	svl

To execute a particular set of scenarios, type
$	svl demo "<models>" "<sizes>" "<applications>"
where
   - <models> is a list of model versions, i.e., a non empty white-space
     separated sequence of the words "booted", "partial", and "unconstrained"
   - <sizes> is a list of processor numbers taken from the set 4, 6, and 8
   - <applications> is a list of applications
Notice that certain scenarios may run out of memory, as indicated in Table 1
of [Lantreibecq-Serwe-14].

After execution of the SVL scenario, all generated files can be removed by 
typing:
$	svl -clean demo
or even simply
$	svl -clean

Files:
	DTD.lnt		description of the behaviour of DTD
	FIFO.lnt	data type describing a FIFO queue of tasks
	INFO.lnt	data type describing the status of processor
	PROCESSOR.lnt	description of the behaviour of a processor
	TYPES.lnt	basic data types used by the DTD
	macros.mcl	macro definitions for the MCL formulae
	Scenarios	directory containing scenario-dependent files
	demo.svl	SVL verification scenario

References:

[Lantreibecq-Serwe-11]
	Etienne Lantreibecq and Wendelin Serwe.
	Model Checking and Co-simulation of a Dynamic Task Dispatcher Circuit
	Using CADP.
	In Proceedings of the 16th International Workshop on Formal Methods
	for Industrial Critical Systems FMICS 2011 (Trento, Italy), Lecture
	Notes in Computer Science 6959, pages 180-195, Springer Verlag, August
	2011.
	http://cadp.inria.fr/publications/Lantreibecq-Serwe-11.html

[Lantreibecq-Serwe-14]
	Etienne Lantreibecq and Wendelin Serwe.
	Formal Analysis of a Hardware Dynamic Task Dispatcher with CADP.
	Science of Computer Programming, volume 80 part A, pp. 130-149,
	February 2014.
	http://cadp.inria.fr/publications/Lantreibecq-Serwe-14.html

See also http://cadp.inria.fr/case-studies/11-g-dtd.html

