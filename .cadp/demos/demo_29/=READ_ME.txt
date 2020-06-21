-- CADP (CONSTRUCTION AND ANALYSIS OF DISTRIBUTED PROCESSES)
-- http://cadp.inria.fr

[Last updated: Thu Aug 23 17:20:57 CEST 2018]

This directory contains an example for BCG, BISIMULATOR, CAESAR, CAESAR.ADT,
EVALUATOR, LN2LOTOS, and SVL. It is about the dynamic reconfiguration
protocol for agent-based applications used in the AAA middleware developed
by DYADE and the SIRAC project of INRIA Rhone-Alpes.

The example is described in:
   M. Aguilar Cornejo, H. Garavel, R. Mateescu, and N. De Palma.
   Specification and Verification of a Dynamic Reconfiguration Protocol
   for Agent-Based Applications. In Proceedings of the 3rd IFIP WG 6.1
   International Working Conference on Distributed Applications and
   Interoperable Systems DAIS'2001 (Krakow, Poland), Kluwer Academic, 2001.

See
   http://cadp.inria.fr/publications/Aguilar-Garavel-et-al-01.html
and
   http://cadp.inria.fr/case-studies/01-c-reconfiguration.html

The protocol is specified both in LOTOS (as originally done in 2001 as 
explained in the aforementioned publication) and in LNT (the LNT description
was developed in 2011). Verification is done by model checking. Equivalence
checking is also used to make sure that the LOTOS and LNT specifications are
equivalent. 

The instance of the protocol considered here contains a configurator agent
(which is responsible of implementing the dynamic reconfiguration protocol)
and two application agents executing on the same site.

Files:
   demo.svl		SVL verification script
   DATA.lnt		LNT specification (data types)
   SPEC.lnt		LNT specification (behaviour)
   LOTOS/DATA.lib	LOTOS specification (data types)
   LOTOS/SPEC.lotos	LOTOS specification (behaviour)
   LOTOS/SPEC.t		settings for the data type hash tables
   LOTOS/demo.svl	SVL verification script

The verification scenario is described and commented in the file "demo.svl".
It can be run by typing
$       svl demo
or even simply
$       svl

After the verification you may type
$       svl -clean demo
or even simply
$       svl -clean
to remove all the generated files.

