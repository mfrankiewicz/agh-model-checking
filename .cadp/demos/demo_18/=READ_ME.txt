-- CADP (CONSTRUCTION AND ANALYSIS OF DISTRIBUTED PROCESSES)
-- http://cadp.inria.fr

[Last updated: Mon Feb  1 17:56:38 CET 2016]

This directory contains the LOTOS specification of a "Transit Node".

This case-study is fully described in:
   Laurent Mounier, "A LOTOS specification of a Transit Node", 
   Spectre Report 94-8, VERIMAG (Grenoble, France), March 1994.
See
   http://cadp.inria.fr/publications/Mounier-94.html
and
   http://cadp.inria.fr/case-studies/94-a-transitnode.html

The Transit Node specification has been initially written in LOTOS by
Laurent Mounier. Frederic Lang and Hubert Garavel added an SVL script
for the compositional generation of the state space. This initial
version is stored in the LOTOS directory.

In 2013, Julian Maurer and Alexander Graf-Brill translated to LNT this
LOTOS specification as part of a lab exercise of the "Applied Concurrency
Theory" lecture given at Saarland University. In 2014, after further
enhancements brought to the LNT language and translator, Hubert Garavel
wrote the LNT version provided herein.

Typing the command
$	svl demo
or simply: 
$	svl

builds the Labelled Transition System "transit_node.bcg" using compositional
verification. Then, all the verifications described in [Mounier-94] can be
carried out on this LTS. 

Note: After the verification, you can type
$	svl -clean demo
or simply:
$	svl -clean
to remove all files produced during the verification.
