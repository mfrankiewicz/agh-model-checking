-- CADP (CONSTRUCTION AND ANALYSIS OF DISTRIBUTED PROCESSES)
-- http://cadp.inria.fr

[Last updated: Sun May 29 10:56:42 CEST 2016]

This directory describes the specification of a distributed summation
algorithm, illustrating the use of ``m among n'' synchronization, supported
by EXP.OPEN and SVL.

* This example is presented in
*
* J. F. Groote, F. Monin, J. Springintveld. A Computer Checked Algebraic
* Verification of a Distributed Summation Algorithm. Computer Science Report
* 97/14, Department of Mathematics and Computer Science, Eindhoven University
* of Technology. 1997.
*

It was translated from mCRL and adapted for LOTOS, EXP.OPEN, and SVL by
Frederic Lang. It was then translated to LNT by Marius Hollinger (student
at the University of Saarland) and Hubert Garavel. 

The system consists of a set of 6 sequential processes, named P_0 to P_5,
defined in file "summation.lnt". Each process has two parameters, namely
a unique process identifier, represented by a natural number, and a weight,
represented by a natural number in [0..7]. Each process can communicate with
a subset of the other processes, called its "neighbours". Neighbourhood is
a symmetrical and antireflexive relation between processes.

The system computes in a distributed way the sum (modulo 8) of the weights
of processes P_0 to P_5: each process collects local sums from some of its 
neighbours, and process P_0 eventually sends the final result on the REPORT 
gate.

The synchronizations between P_0 ... P_5 are described by a composition
expression in "demo.svl", using the ``n among m'' (here, 2 among 6)
synchronization operator. This expression does not depend on the 
neighbourhood relation, but only on the number of processes.

In this demo, the state graph of the system is generated, with the REPORT
gate as the only visible gate. The verification shows that, despite the 
nondeterminism induced by parallel composition, the result output by the
system is unique and correct.

The whole verification scenario is described in the file "demo.svl". It can 
be executed by typing:
$	svl demo
or even simply 
$	svl

After execution of the SVL scenario, all generated files can be removed by 
typing
$	svl -clean demo
or even simply
$	svl -clean

Note: The weights and the neighbourhood relation may be modified, at the end
of file "TYPES.lnt" : to change weights, modify the definition of the
Weight function; to change the neighbourhood relation, modify the
definition of the Connect function; the (symmetric and antireflexive)
neighbourhood relation is defined as follows:

	Neighbour (x, y) <=> (x != y) and (Connect (x, y) or Connect (y, x))

