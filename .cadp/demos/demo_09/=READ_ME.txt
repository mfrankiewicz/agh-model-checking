-- CADP (CONSTRUCTION AND ANALYSIS OF DISTRIBUTED PROCESSES)
-- http://cadp.inria.fr

[Last updated: Wed Feb 12 14:14:28 CET 2020]

This directory contains an example for CAESAR, CAESAR.ADT, BISIMULATOR,
OPEN/CAESAR, and TGV. It describes the INRES (Initiator Responder) protocol,
which is a simplified version of the ABRACADABRA protocol.

# The original version of INRES protocol and service are described in:
#    Dieter Hogrefe
#    OSI Formal Specification Case Study: the INRES protocol and service
#    Institut Fur Informatik, Universitat Bern, April 1991
# The original version has been corrected and improved by Ana Cavalli's
# team at INT. Various reports have been written, for instance:
#    Hok Hiong Pang
#    Generation of a Finite State Machine From a LOTOS Specification 
#    of INRES Protocol using CAESAR
#    Institut National des Telecommunications, Evry, France

This directory provides various versions of the INRES protocol and service,
by courtesy of INT.

Early versions:

inres_service_original.lotos : original specification of the service,
                               by D. Hogrefe
inres_service_japan.lotos :     improved version of the service, provided
			        by Japanese researchers
inres_protocol_original.lotos : original specification of the protocol
                                by D. Hogrefe

Improved versions:
inres_service_int.lotos :	service specification, by K. H. Pang (INT)
inres_protocol_int_4.lotos :    version 4 of the protocol, by P. Maigron (INT)
				(with remaining deadlocks)
inres_protocol_int_5.lotos :    version 5 of the protocol, by K. H. Pang (INT)
				(debugged protocol specification, no coder)
inres_protocol_int_6.lotos :	version 6 of the protocol, by K. H. Pang (INT)
				(debugged protocol specification, no coder, 
				LOSS gate).
INRES_PROTOCOL.lib : 		type library for the protocol specification
INRES_SERVICE.lib : 		type library for the service specification
sequence_*.seq :		Message Sequence Charts describing allowed
				execution sequences of the INRES protocol

1) First, you can compile the abstract data types using CAESAR.ADT
$	caesar.adt inres_service_int.lotos
$	caesar.adt inres_protocol_int_4.lotos
$	caesar.adt inres_protocol_int_5.lotos
$	caesar.adt inres_protocol_int_6.lotos

2) You can detect deadlocks in inres_protocol_int_4.lotos using OPEN/CAESAR
$        lotos.open inres_protocol_int_4.lotos terminator

> order for transition firing (between 0 and 4) ? 0
> number of bitmap tables (between 1 and 2) ? 1
> size of bitmap (between 0 and 4294967295) ? 10000
> ...
 
3) You can generate the LTS files for inres_protocol_int_6.lotos using CAESAR
$	caesar inres_protocol_int_6.lotos

and the LTS for inres_service_int.lotos using CAESAR
$	caesar inres_service_int.lotos

Both LTSs can be compared using BISIMULATOR wrt safety equivalence
$	bcg_open inres_protocol_int_6.bcg bisimulator -bfs -equal -safety -diag diag.bcg inres_service_int.bcg
or wrt safety preorder
$	bcg_open inres_protocol_int_6.bcg bisimulator -bfs -greater -safety -diag diag.bcg inres_service_int.bcg

BISIMULATOR points out that the service is not safety equivalent to the 
protocol and gives distinguishing sequences in file diag.bcg.

4) You can also check whether some execution sequences are accepted by
various service and protocol descriptions. Those suitable execution 
sequences are contained in files sequence_*.seq. They are derived 
from the graphical "Message Sequence Charts" (MSC) of the INRES protocol.

For instance, checking whether these sequences are accepted by
inres_protocol_int_6.bcg is done as follows:
$	bcg_open inres_protocol_int_6.bcg exhibitor < sequence_1.seq
$	bcg_open inres_protocol_int_6.bcg exhibitor < sequence_2.seq
$	bcg_open inres_protocol_int_6.bcg exhibitor < sequence_3.seq
$	bcg_open inres_protocol_int_6.bcg exhibitor < sequence_4.seq
$	bcg_open inres_protocol_int_6.bcg exhibitor < sequence_5.seq
$	bcg_open inres_protocol_int_6.bcg exhibitor < sequence_6.seq
$	bcg_open inres_protocol_int_6.bcg exhibitor < sequence_7.seq
$	bcg_open inres_protocol_int_6.bcg exhibitor < sequence_8.seq
$	bcg_open inres_protocol_int_6.bcg exhibitor < sequence_9.seq

The same verifications can also be done on-the-fly, without generating
inres_protocol_int_6.bcg first:
$     lotos.open inres_protocol_int_6.lotos exhibitor < sequence_1.seq
$     lotos.open inres_protocol_int_6.lotos exhibitor < sequence_2.seq
$     lotos.open inres_protocol_int_6.lotos exhibitor < sequence_3.seq
$     lotos.open inres_protocol_int_6.lotos exhibitor < sequence_4.seq
$     lotos.open inres_protocol_int_6.lotos exhibitor < sequence_5.seq
$     lotos.open inres_protocol_int_6.lotos exhibitor < sequence_6.seq
$     lotos.open inres_protocol_int_6.lotos exhibitor < sequence_7.seq
$     lotos.open inres_protocol_int_6.lotos exhibitor < sequence_8.seq
$     lotos.open inres_protocol_int_6.lotos exhibitor < sequence_9.seq

5) You can also simulate interactively a description of the protocol, e.g.:
$	lotos.open inres_protocol_int_4.lotos xsimulator

Note: currently, the maximal number of ISDU sent by the Initiator is fixed
to 1. This can be changed by adding new constructors (data2, data3, ...)
to sort ISDU (type ISDUType in file INRES_PROTOCOL.lib)

6) You can use the TGV tool to generate test cases for the INRES service
according to the test purpose specified in inres_service_tp.aut, either
on the fly:
$	lotos.open inres_service_int.lotos tgv -csg -io inres_service_int.io -output test.bcg -unlock inres_service_tp.aut

or on the service graph generated exhaustively:
$	caesar.adt inres_service_int.lotos
$	caesar inres_service_int.lotos
$	bcg_open inres_service_int.bcg tgv -csg -io inres_service_int.io -output test.bcg -unlock inres_service_tp.aut

Then, you can display the resulting test case
$	bcg_draw test.bcg




