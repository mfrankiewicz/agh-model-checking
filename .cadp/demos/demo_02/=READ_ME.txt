-- CADP (CONSTRUCTION AND ANALYSIS OF DISTRIBUTED PROCESSES)
-- http://cadp.inria.fr

[Last updated: Tue Feb  2 13:37:20 CET 2016]

This directory contains an example for CAESAR, CAESAR.ADT, BCG_MIN, 
BISIMULATOR, EVALUATOR, SVL, and XTL.
It describes a variant of the alternating bit protocol written in full LOTOS
(with data values).

This example is presented in appendix C of:
   Hubert Garavel. Compilation et ve'rification de programmes LOTOS.
   The`se de Doctorat, Universite' Joseph-Fourier (Grenoble), Nov 89

See
   http://cadp.inria.fr/publications/Garavel-89-b-CD.html
and
   http://cadp.inria.fr/case-studies/89-a-bitalt.html

Files:
   bitalt_service.lotos:	service description
   bitalt_protocol.lotos	protocol description
   bitalt_mistake.lotos		(intentionally) incorrect protocol description
   BITALT.lib			data type library used in 3 above files
   BITALT.t			auxiliary file 
   bitalt_service.t		symbolic link to BITALT.t
   bitalt_protocol.t		symbolic link to BITALT.t
   bitalt_mistake.t		symbolic link to BITALT.t
   demo.svl			SVL verification scenario
   macros.xtl			definitions of auxiliary XTL macros

Note:
The size of the graphs depends on the number of possible different messages.
This number is defined in file "BITALT.t" and it is chosen to be 5 (as
messages are in the range 0...4). Some temporal logic properties to be
verified depend on this number. If it is changed, these properties must be
modified accordingly.

The verification scenario is described and commented in the file "demo.svl".
It can be run by typing
$	svl demo
or even simply
$	svl

After the verification you may type
$	svl -clean demo
or even simply
$	svl -clean
to remove all the generated files.



