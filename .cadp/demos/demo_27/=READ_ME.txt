-- CADP (CONSTRUCTION AND ANALYSIS OF DISTRIBUTED PROCESSES)
-- http://cadp.inria.fr

[Last updated: Mon Jan  4 15:02:22 CET 2016]

This directory contains an example for CAESAR, EXP.OPEN, BCG_MIN, SVL, and XTL.

It describes the leader election protocol used in the HAVi (Home Audio-Video)
standard developed by eight consumer electronics companies (Grundig, Hitachi,
Matsushita, Philips, Sharp, Sony, Thomson, and Toshiba) in order to solve
interoperability problems for home audio/video networks.

* The LOTOS and XTL source files for this example have been gracefully
* provided by Judi Romijn (University of Nijmegen, The Netherlands).
* The application is fully described in the following document:
* Judi Romijn. "Model Checking a HAVi Leader Election Protocol".
* Technical Report SEN-R9915, CWI, June 1999.
* Available on-line from http://oai.cwi.nl/oai/asset/4534/04534D.pdf

This example makes use of the compositional verification features provided
by CADP. Two versions of the HAVi leader election protocol are contained in
this directory: an asynchronous and a synchronous one. The HAVi configuration
considered here involves only two DCMs (Device Control Managers).

Files:
   HAVi_{asyn,sync}.lotos protocol specification (asynchronous/synchronous)
   demo.svl               compositional description of the protocols
   MY_NATURAL.lib         user-defined library implementing bounded naturals

As described in the "demo.svl" file, the HAVi leader election protocol is
divided into several processes, the corresponding LTSs being automatically
generated and reduced modulo strong equivalence. These LTSs are then composed
together (using LOTOS parallel and hiding operators). The final LTSs are
generated and stored in files "HAVi_{asyn,sync}.bcg".

The desired temporal properties of the protocol are specified in XTL and
verified on the LTSs HAVi_{asyn,sync}.bcg using the XTL model-checker.

Typing the command
$	svl demo
or even simply
$	svl
will generate the LTSs automatically and then verify the temporal logic
properties, first for the asynchronous version, then for the synchronous
version.

After the verification you may type
$	svl -clean demo
or even simply
$	svl -clean
to remove all the generated files.

The following tables summarize the sizes of individual processes obtained
for the asynchronous version of the protocol, before and after minimization
modulo strong equivalence, using either CAESAR 6.0 (CADP 2001 "Ottawa") or
CAESAR 7.0 (CADP 2006 "Edinburgh"). The final LTS has 5,107 states and
18,725 transitions.

Using CAESAR 6.0:

+------------------+-----------------------++----------------------+
|                  | before  minimization  ||  after  minimization |
|    CAESAR 6.0    +---------+-------------++--------+-------------+
|                  | states  | transitions || states | transitions |
+------------------+---------+-------------++--------+-------------+
| BUSRESET         |      33 |          45 ||     16 |          24 |
+------------------+---------+-------------++--------+-------------+
| DCM (1)          | 404,477 |   3,025,842 ||     37 |         233 |
+------------------+---------+-------------++--------+-------------+
| DCM (2)          |   2,155 |      18,392 ||     27 |         170 |
+------------------+---------+-------------++--------+-------------+
| CMM (1), CMM (2) |   9,497 |      43,418 ||     12 |          49 |
+------------------+---------+-------------++--------+-------------+
| MS (1), MS (2)   |   2,279 |      17,931 ||     27 |         159 |
+------------------+---------+-------------++--------+-------------+

Using CAESAR 7.0:

+------------------+-----------------------++----------------------+
|                  | before  minimization  ||  after  minimization |
|    CAESAR 7.0    +---------+-------------++--------+-------------+
|                  | states  | transitions || states | transitions |
+------------------+---------+-------------++--------+-------------+
| BUSRESET         |      17 |          25 ||     16 |          24 |
+------------------+---------+-------------++--------+-------------+
| DCM (1)          |      92 |         977 ||     37 |         233 |
+------------------+---------+-------------++--------+-------------+
| DCM (2)          |      53 |         592 ||     27 |         170 |
+------------------+---------+-------------++--------+-------------+
| CMM (1), CMM (2) |      32 |         125 ||     12 |          49 |
+------------------+---------+-------------++--------+-------------+
| MS (1), MS (2)   |      69 |         504 ||     27 |         159 |
+------------------+---------+-------------++--------+-------------+

