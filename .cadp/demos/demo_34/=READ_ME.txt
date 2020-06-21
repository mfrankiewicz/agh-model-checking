-- CADP (CONSTRUCTION AND ANALYSIS OF DISTRIBUTED PROCESSES)
-- http://cadp.inria.fr

[Last updated: Fri Nov 28 14:13:08 CET 2014]

This directory describes the verification of a CIM (Computer Integrated
Manufacturing) architecture specified in LOTOS.

The LOTOS specification is based on an ACP specification given in [Mauw-90],
which in turn is inspired from an early LOTOS specification [Biemans-Blonk-86].

* [Biemans-Blonk-86] F. Biemans and P. Blonk. "On the formal specification
*   and verification of CIM architectures using LOTOS." Computers in Industry,
*   7(6), pages 491-504, 1986.
*
* [Mauw-90] S. Mauw. "Process Algebra as a Tool for the Specification and
*   Verification of CIM-architectures." In J.C.M. Baeten, editor, Applications
*   of Process Algebra, pages 53-80, Cambridge University Press, 1990.

The verification presented in [Mauw-90] established that the CIM architecture
is branching equivalent to a desired external behaviour. Here we identified a
set of temporal properties of the CIM architecture, expressed in MCL and
verified using the EVALUATOR 3 and 4 model-checkers.

The whole verification scenario is described and commented in the file
"demo.svl".  It can be executed by typing:
$       svl demo
or just
$       svl

After execution of the SVL scenario, all generated files can be removed by
typing:
$       svl -clean demo
or just
$       svl -clean

