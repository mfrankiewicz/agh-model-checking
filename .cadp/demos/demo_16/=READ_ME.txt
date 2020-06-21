-- CADP (CONSTRUCTION AND ANALYSIS OF DISTRIBUTED PROCESSES)
-- http://cadp.inria.fr

[Last updated: Tue Feb  2 13:29:12 CET 2016]

This directory contains an example for LNT2LOTOS, CAESAR, CAESAR.ADT, BCG,
BISIMULATOR, SVL, and XTL.

It describes a simplified version of the Bounded Retransmission Protocol
(BRP) used by Philips in one of its products. This example was initially
written in LOTOS and was presented in:

*    Radu Mateescu. Formal Description and Analysis of a Bounded
*    Retransmission Protocol. In Proceedings of COST 247 International
*    Workshop on Applied Formal Methods in System Design, Maribor, Slovenia,
*    June 17-19, 1996. This paper is available as INRIA Research Report 
*    RR-2965.

See
     http://cadp.inria.fr/publications/Mateescu-96.html
and
     http://cadp.inria.fr/case-studies/96-c-brp.html

In 2015, this example has been entirely rewritten to LNT by Hubert Garavel,
with the help of Julian Jacques Maurer (Saarland University) and Jose-Ignacio
Requeno (INRIA/CONVECS).

Files:
   SERVICE.lnt          service description in LNT
   PROTOCOL.lnt         protocole description in LNT
   TYPES.lnt            data type library used in the two above files
   CHANNELS.lnt         channel type library
   CLIENT.lnt           auxiliary process library
   demo.svl		SVL verification script
   macros.xtl		XTL macro-definitions shared between properties

   LOTOS/SERVICE.lotos	former service description in LOTOS
   LOTOS/PROTOCOL.lotos	former protocol description in LOTOS
   LOTOS/TYPES.lib	data type library used in the two above files
   LOTOS/TYPES.t	auxiliary file (to specify the packet length)
   LOTOS/SERVICE.t	auxiliary file
   LOTOS/PROTOCOL.t	auxiliary file
   LOTOS/demo.svl	small SVL verification script

Note:
The size of the graphs depends on the packet length and the number of
retransmissions. The packet length is specified in the TYPES.lnt file
(see the definition of the type named Data) and the maximal number of
retransmissions is specified in the PROTOCOL.lnt file (see the constant
named MAX).

The whole verification scenario is described and commented in the file
"demo.svl". It can be executed by typing:
$       svl demo
or even simply
$       svl

After execution of the SVL scenario, all generated files can be removed by
typing
$       svl -clean demo
or even simply
$       svl -clean


