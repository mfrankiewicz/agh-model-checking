-- CADP (CONSTRUCTION AND ANALYSIS OF DISTRIBUTED PROCESSES)
-- http://cadp.inria.fr

[Last updated: Thu Aug 23 17:23:04 CEST 2018]

This directory contains an example verification scenario using BCG_CMP,
BCG_MIN, BISIMULATOR, CAESAR.ADT, CAESAR, EXP.OPEN, EVALUATOR4, LNT2LOTOS,
PROJECTOR, SVL, and the EXEC/CAESAR framework. It describes an asynchronous
implementation, formally specified both in LOTOS and LNT, of the Data
Encryption Standard [DES], which allows to cipher and decipher 64-bit vectors
using a 64-bit vector as key.

To enable compositional verification, the domain of 64-bit vectors is reduced
to a single value, by simply redefining the abstract data type for bits so as
to use a singleton domain. This is done by using the "BIT_ABSTRACT" module
rather than the "BIT_CONCRETE" module. If this abstraction is not used, the
state space can only be generated entirely if the specification is "closed" to
avoid enumerating all possible 64-bit input values; this is done in the
"DES_SAMPLE" specification, which uses "BIT_CONCRETE" and adds a process
ENVIRONMENT, providing input data (a fixed sample key and data to be encrypted)
and checking the output (correct ciphering).

The formal specification can also be used to automatically generate a prototype
of the DES using the EXEC/CAESAR framework. This prototype reads its inputs
from stdin and prints its results to stdout. Each rendezvous corresponds to
one line of input (respectively, output), following the syntax of LOTOS, i.e.,
"<GATE> !<OFFER>". For convenience, 64-bit vectors are represented by a
sequence of sixteen hexadecimal digits. The prototype can also write its
execution trace in the SEQ format to a log file. The C code implementing the
interaction with the DES on the visible gates is contained in file
"gate_functions.c".

The whole verification scenario is described and commented in the file 
"demo.svl". It can be executed by typing:
$	svl demo
or even simply 
$	svl

After execution of the SVL scenario, all generated files can be removed by 
typing:
$	svl -clean demo
or even simply
$	svl -clean

Files:
   BIT_ABSTRACT.lnt		data type for abstract bits (ie. single valued)
   BIT_CONCRETE.lnt		data type for concrete bits (ie. two valued)
   TYPES.lnt			data type definitions for the algorithm
   PERMUTATION_FUNCTIONS.lnt	permutation functions for bit vectors
   S_BOX_FUNCTIONS.lnt		functions used in the S-boxes
   CHANNELS.lnt			channel definitions for the processes
   CIPHER.lnt			process definitions for the cipher function
   CONTROLLER.lnt		process definitions for the control part
   DATA_PATH.lnt		process definitions for the data path
   KEY_PATH.lnt			process definitions for the key path
   DES.lnt			asynchronous DES architecture
   DES_SAMPLE.lnt		specification of the DES with an environment
   demo.svl			SVL verification scenario
   property_4.lnt		property_4 expressed as a LNT specification
   gate-functions.c		C functions for the external gates
   architecture-1.jpg		diagram of the DES architecture
   architecture-2.jpg		diagram of the DES architecture

References:
[DES] Data Encryption Standard (DES). Federal Information Processing
      Standards 46-3. National Institute of Standards and Technology.
      25 October 1999.

[Serwe-15] Formal Specification and Verification of Fully Asynchronous
      Implementations of the Data Encryption Standard. Proceedings of the
      Workshop on Models for Formal Analysis of Real Systems (MARS 2015),
      Suva, Fiji, November 23, 2015.
