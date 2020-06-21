-- CADP (CONSTRUCTION AND ANALYSIS OF DISTRIBUTED PROCESSES)
-- http://cadp.inria.fr

[Last updated: Wed Feb  3 15:43:53 CET 2016]

This directory contains an example for BCG_LABELS, BCG_MIN, BISIMULATOR,
CAESAR, CAESAR.ADT, EVALUATOR4, EXP.OPEN, LNT2LOTOS, and SVL. 

This example is the specification of a distributed Eratosthenes sieve. It
is based on a specification written in the XL language by Y.S. Ramakrishna
and C.R. Ramakrishnan, which in turn is inspired from a Promela specification
due to D. Peled. The LOTOS version was prepared by Frederic Lang in 2005,
and the LNT version was prepared by Hubert Garavel and Gianluca Barbon
in 2015.

The sieve system consists of a pipeline of N+1 processes:

	- the first process, called generator, sends to the next process a 
	  bounded sequence of consecutive numbers starting at 2;

	- the next N processes, called units, are N instances of the same
	  process; the first number received by a unit, which is prime by
	  construction, is stored in a variable P and sent on the OUTPUT 
	  gate; then, each number received by the same unit is either sent
	  forward if not divisible by P, or ignored otherwise.

Processes in the pipeline communicate by asynchronous buffers. The system
thus contains N buffers, each of which is an instance of a medium process.
All buffer gates are eventually hidden, thus making invisible every internal
communication between processes. In the end, OUTPUT is the only visible gate.
The external behaviour of the system is thus a sequence of N transitions
labelled respectively OUTPUT !M_1, ..., OUTPUT !M_N, where M_1, ..., M_N are
the first N prime numbers (2, 3, 5, etc.).

In this example, several compositional verification techniques are tried,
possibly combined with partial order reduction. In all cases, the graphs
of sequential processes are first generated, minimized, and then composed
using the EXP.OPEN tool. The scenario is as follows:

	1) The graph of an instance of the sieve involving 10 units is
	   first generated with partial order reduction turned off and then
	   reduced modulo branching bisimulation.

	2) The graph of the same instance of the sieve is generated with
	   partial order reduction (preserving branching bisimulation)
	   turned on.

	3) The graph of the same instance of the sieve is generated using
	   incremental reduction: gates are hidden as early as possible in 
 	   the expression and intermediate compositions reduced modulo
	   branching bisimulation.

	4) Finally, a value-passing mu-calculus formula is evaluated on the
	   graph to check that the sieve effectively outputs the first N prime
	   numbers, where the primality test is encoded in the formula.

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
