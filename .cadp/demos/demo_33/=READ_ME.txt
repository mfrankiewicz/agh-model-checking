-- CADP (CONSTRUCTION AND ANALYSIS OF DISTRIBUTED PROCESSES)
-- http://cadp.inria.fr

[Last updated: Fri Mar 20 16:51:33 CET 2015]

This directory contains an example for BCG, CAESAR, CAESAR.ADT,
BCG_GRAPH, BCG_LABELS, BCG_MIN, BISIMULATOR, PROJECTOR, and SVL. It describes
the specification in LOTOS and the compositional verification using SVL of
a randomized binary consensus protocol.

The consensus protocol is a typical distributed agreement problem: a
set of predefined processes try to converge on issuing a common value.
In this example, there are two possible values TRUE and FALSE (hence
the binary qualification).

* This protocol is fully described in:
* 
* M. Ben-Or. Another advantage of free choice: Completely asynchronous
* agreement protocols (extended abstract). In Proceedings of the second
* ACM SIGACT-SIGOPS Symposium on Principles of Distributed Systems,
* pages 27--30, Montreal, Quebec, Canada, August 1983.
*
* and also in:
*
* M. O. Rabin. Randomized Byzantine Generals. In Proceedings of the
* 24th Annual IEEE Symposium on Foundations of Computer Science, pages
* 403--409, 1983.
*
* The LOTOS specification and the verification scenario have been 
* proposed by F. Tronel (unpublished work).

The protocol works in an unbounded number of rounds as follows: at
each round, each process inputs a value, which is either equal to the
value output at previous round, or in the first round, an initial
value given by the environment.

After communication with the other processes, each process provides 
either an ouput value (another round being necessary to reach 
agreement), or a decision value (process has decided and other 
processes should agree).

In generated LTSs, labels have one of the following forms:
   - "INPUT !N !V" models input of value V (TRUE or FALSE) by process
     number N.
   - "OUTPUT_R !N !V" models output of value V (TRUE or FALSE) by
     process N at round R.
   - "DEC !V" models decision of value V (TRUE or FALSE).

Intermediate LTSs also contain labels prefixed with SEND and RECV, 
which model communications between processes and are hidden during
compositional verification.

Files:
  CONSENSUS.lotos	generic LOTOS process specifications
  CONSENSUS.t		auxiliary file
  TRISTATE.lib		LOTOS data definition
  demo.svl		SVL verification script
  labels-$i-$j-$k	files defining labels modeling messages
			exchanged from process number $i to process
			number $j at round $k

The verification scenario is described and commented in the file 
"consensus.svl".
It can be run by typing
$       svl demo
or even simply
$       svl

After the verification you may type
$       svl -clean demo
or even simply
$       svl -clean
to remove all the generated files.

