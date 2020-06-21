-- CADP (CONSTRUCTION AND ANALYSIS OF DISTRIBUTED PROCESSES)
-- http://cadp.inria.fr

[Last updated: Tue Sep 25 14:04:19 CEST 2012]

This directory contains an example for BCG_MIN, BISIMULATOR, CAESAR.ADT,
CAESAR, EXP.OPEN, PROJECTOR, and SVL.

It describes objects exchanging services via an ODP (Open Distributed
Processing) trader. The processes that describe the objects and the trader
are written in LOTOS. They are composed in parallel in "demo.svl" using 
``2 among n'' synchronization to model the dynamicity of object exchanges.

* The ODP standard is fully described in the following document:
*
* ISO/IEC. Open Distributed Processing -- Reference Model. International
* Standard 10746, ISO -- Information Processing Systems, Geneve, 1995. 
*
* The ``m among n'' synchronization and a preliminary version of this case
* study are described in:
* 
* H. Garavel and M. Sighireanu. A Graphical Parallel Composition Operator
* for Process Algebras. In Proceedings of the Joint International Conference
* on Formal Description Techniques for Distributed Systems and Communication
* Protocols, and Protocol Specification, Testing, and Verification 
* FORTE/PSTV'99 (Beijing, China), October 1999

In this example, the ODP trader executes in an environment consisting of
4 objects and 5 services. Interface constraints are generated automatically
from this environment to restrict the state graph of the trader. These
interface constraints allow to limit the generation to 256 states, instead
of 1 million otherwise.

The whole verification scenario is described and commented in the file 
"demo.svl". It can be executed by typing:
$	svl demo
or even simply 
$	svl

After execution of the SVL scenario, all generated files can be removed by 
typing
$	svl -clean demo
or even simply
$	svl -clean
