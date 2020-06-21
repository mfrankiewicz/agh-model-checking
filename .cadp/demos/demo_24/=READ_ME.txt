-- CADP (CONSTRUCTION AND ANALYSIS OF DISTRIBUTED PROCESSES)
-- http://cadp.inria.fr

[Last updated: Wed Feb 12 14:16:31 CET 2020]

Introduction
============

  This directory contains an application of CADP to the verification
  of a distributed knowledge base system called Co4 and described in:

  [Pecheur-97] Charles Pecheur. Specification and Verification of the
  CO4 Distributed Knowledge System Using LOTOS. Proceedings of the
  12th IEEE International Conference on Automated Software Engineering
  ASE-97 (Incline Village, Nevada, USA), November 1997. Extended version
  available as INRIA Research Report RR-3259. 

  See
     http://cadp.inria.fr/publications/Pecheur-97.html
  and
     http://cadp.inria.fr/case-studies/97-a-co4.html

  The LOTOS specification and the different verification stages were
  developed by Charles Pecheur in 1997. Several variants of the
  specification are provided and used to verify different properties.
  Verification is centered on the use of the EXHIBITOR tool.

Remarks
=======

  1) This specification has been written using Norman Ramsey's NOWEB
  literate programming system. The LOTOS files in this directory have
  been automatically extracted from a single source document, which
  also contains all commentaries. The source document is not provided
  but appears in typeset form as annex A of [Pecheur-97].

  2) The data types in this specification have been defined using
  charles Pecheur's APERO concise syntax extensions. The LOTOS files 
  in this directory contain the translation of those definitions in
  standard LOTOS, tuned for the CADP data type compiler.

Contents
========

=READ_ME.txt: the file you are presently reading.

co4-*-*.lotos: the different variants of the LOTOS
  specification, where the variable tags designate the chosen
  hierarchy and the chosen user input scenario, respectively. Refer to
  annex A of [Pecheur-97] for a description.

CO4_DATATYPES.lib: the data type definitions, shared by all variants.

CO4_PROCESSES.lib: the general process definitions, shared by all variants.

*.seq: filters on execution sequences, for use with EXHIBITOR.

short.rename: renaming file to shorten transition labels, in order to produce
  nicer-looking graph print-outs.

demo.svl: a script for SVL that automates all necessary tool invocations.

Usage with SVL
==============

The SVL script "demo.svl" allows to execute the entire verification. 
It can be executed by typing:
$	svl demo
or even simply
$	svl

After execution of the SVL scenario, all generated files can be removed by
typing
$	svl -clean demo
or even simply
$	svl

Usage with Make (obsolete)
==========================

You can also call Make with an appropriate target. The available targets are

$ make -f makefile.old

  Note: The whole execution of the makefile is quite long (about 1 hour
	50 minutes on an Ultra-1 using CADP version 97b "Liege").

  To compile and perform all verifications for a single variant, e.g.
  "co4-3-1.lotos", type

$ make -f makefile.old co4-3-1.result

  The results are logged into a file "co4-3-1.result".

  You can also execute all compilations and verifications by typing

$ make -f makefile.old results

  but be warned that this starts some very long and greedy
  computations that could exhaust the memory space of your
  computer. We have achieved a successful run of the whole set in 256
  MB RAM plus 150 MB swap space.

  Two transition graphs can also be pretty-printed using BCG_DRAW by
  typing

$ make -f makefile.old draws

  and then displaying or printing the produced PostScript files.


