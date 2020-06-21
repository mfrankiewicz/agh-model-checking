-- CADP (CONSTRUCTION AND ANALYSIS OF DISTRIBUTED PROCESSES)
-- http://cadp.inria.fr

[Last updated: Wed Oct 10 14:29:15 CEST 2007]

This directory contains an example for BCG_MIN, CAESAR, and SVL.
Four systolic arrays computing the convolution product are
described in LOTOS. The four schemes B1, F, W1 and W2
proposed by Kung are tackled.

This example is presented in appendix D of:
   Hubert Garavel. Compilation et ve'rification de programmes LOTOS.
   The`se de Doctorat, Universite' Joseph-Fourier (Grenoble), Nov 89

See
   http://cadp.inria.fr/publications/Garavel-89-b-CD.html
and
   http://cadp.inria.fr/case-studies/89-b-systol.html

This example is original, since it uses an asynchronous language (LOTOS)
to descrive systolic arrays, which are typically synchronous. A small
step towards asynchronous circuits?

Another interesting point is the use of symbolic computations:
values that label the edges of the graph are algebraic terms 
with formal variables. This is done by providing appropriate
"symbolic" implementations for abstract data types (see EXP.t 
and EXP.f files).

The file "demo.svl" implements the generation and reduction with 
branching equivalence of the four graphs systol_B1, systol_F, 
systol_W1, and systol_W2.

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

Benchmarks for CAESAR 3.2     for CAESAR 4.3	for CAESAR 5.2

   systol B1                  systol B1		systol B1
      cells: 3                (idem)		(idem)
      length: 8               (idem)		(idem)
      states: 37986           states: 133	states: 133
      edges: 54312            edges: 216	edges: 216
      time: 3:14              time: 0:25	time: 0:06

   systol F                   systol F		systol F
      cells: 7                (idem)		(idem)
      length: 19              (idem)		(idem)
      states: 438             states: 438	states: 438
      edges: 669              edges: 669	edges: 669
      time: 3:16              time: 0:42	time: 0:08

   systol W1                  systol W1		systol W1
      cells: 3                (idem)		(idem)
      length: 6               (idem)		(idem)
      states: 64004           states: 113	states: 113
      edges: 87596            edges: 181	edges: 181
      time: 5:01              time: 0:27	time: 0:06

   systol W2                  systol W2		systol W2
      cells: 7                (idem)		(idem)
      length: 26              (idem)		(idem)
      states: 447             states: 447	states: 447
      edges: 575              edges: 575	edges: 575
      time: 3:39              time: 0:46	time: 0:08


