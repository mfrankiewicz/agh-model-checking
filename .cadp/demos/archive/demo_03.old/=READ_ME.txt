-- CADP (CONSTRUCTION AND ANALYSIS OF DISTRIBUTED PROCESSES)
-- http://cadp.inria.fr

[Last updated: Tue Nov 10 12:17:00 CET 2009]

This directory contains an example for BISIMULATOR, CAESAR, CAESAR.ADT, and
SVL. It describes a variant of the alternating bit protocol written in full
LOTOS (with values).

* This example is presented in:
*    Juan Quemada, Santiago Pavo'n and Angel Ferna'ndez. State Exploration
*    by Transformation with LOLA. In E. D. Clarke, A. Pnueli and J. Sifakis,
*    editors. Proceedings of Workshop On Automatic Verification Methods For
*    Finite State Systems (Grenoble, June 89). Printed in LNCS series
*    Springer-Verlag, Berlin.

This example is partially presented in appendix B of CAESAR Reference Manual

Files:
   datalink_service.lotos	service description
   datalink_protocol.lotos	protocol description
   datalink_mistake.lotos	intentionally erroneous protocol description
   DATALINK.lib			data type library used in 3 above files
   DATALINK.t			auxiliary file 
   datalink_service.t		symbolic link to DATALINK.t
   datalink_protocol.t		symbolic link to DATALINK.t
   datalink_mistake.t		symbolic link to DATALINK.t
   demo.svl			SVL verification script

Note:
The size of the graphs depends on the number of possible different messages.
This number is defined in file DATALINK.t and it is equal to 40. CAESAR 
could generate larger graphs, at least with 100 messages.

The whole verification scenario is described and commented in the file 
"demo.svl". It can be executed by typing:
$	svl demo
or even simply
$	svl

After execution of the SVL scenario, all generated files can be removed by 
typing
$       svl -clean demo
or even simply
$       svl -clean
