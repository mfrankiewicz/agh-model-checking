-- CADP (CONSTRUCTION AND ANALYSIS OF DISTRIBUTED PROCESSES)
-- http://cadp.inria.fr

[Last updated: Tue Jul 11 18:56:59 CEST 2017]

This directory contains an example for BCG_MIN, EVALUATOR, EXP.OPEN, LNT.OPEN,
PROJECTOR, and SVL. It describes an airplane-ground communication protocol
studied by Airbus and based upon TFTP/UDP (Trivial File Transfer Protocol/User
Datagram Protocol). The protocol is specified in LNT and temporal logic
formulas are specified in MCL. See
   http://cadp.inria.fr/case-studies/09-h-tftp.html

This example has been tackled in the framework of the French projects
OpenEmbedd and Topcased. It is described in full detail (in French) in:
   Damien Thivolle
   Langages modernes pour la modelisation et la verification des systemes
   asynchrones
   These de doctorat de l'Universite de Grenoble et de l'Universite
   Polytechnique de Bucarest, 2011.
   http://vasy.inria.fr/press/these_thivolle.html

It is briefly presented (in English) in:
   Hubert Garavel and Damien Thivolle
   Verification of GALS Systems by Combining Synchronous Languages and
   Process Calculi
   In Corina Pasareanu, editor, Proceedings of the 16th International SPIN
   workshop on Model Checking of Software SPIN'2009 (Grenoble, France),
   volume 5578 of Lecture Notes in Computer Science, pages 241-260,
   Springer Verlag, 2009. 
   http://cadp.inria.fr/publications/Garavel-Thivolle-09.html

The compositional verification techniques used are detailed in:
   Hubert Garavel, Frederic Lang, and Radu Mateescu
   Compositional Verification of Asynchronous Concurrent Systems using CADP
   Acta Informatica, 2015.
   http://cadp.inria.fr/publications/Garavel-Lang-Mateescu-15.html

In September 2016 and July 2017, several files have been updated to obey the
new rules of the LNT language regarding checked exceptions.

The directory VERSIONS contains several versions of TFTP:

   AUTOMATON_ORIGINAL.lnt	systematic translation of the SAM automaton
				of TFTP provided by Airbus, containing errors
   AUTOMATON_ERROR_*.lnt	independent versions containing a single error
   AUTOMATON_FINAL.lnt		final version with all errors corrected

The file "demo.svl" describes and comments five verification scenarios named
by letters ranging from A to E.

The SVL script can be parameterized with both the scenarios (any number of
parameters among A, B, C, D, and E) and TFTP version (one parameter among the
files present in VERSIONS) to be verified. For instance, one can verify in
turn all scenarios for the version described in AUTOMATON_ORIGINAL.lnt by
typing the following command:
$	svl demo VERSIONS/AUTOMATON_ORIGINAL.lnt A B C D E
or
$	svl demo AUTOMATON_ORIGINAL.lnt A B C D E

However, beware that verifying all five scenarios takes several hours and may
require several gigabytes of memory.

If no scenario is specified in the list of parameters, then SVL verifies
scenario A. If no TFTP version is specified in the list of parameters,
then SVL uses AUTOMATON_FINAL.lnt. Thus, verifying scenario A for 
AUTOMATON_FINAL.lnt can be done by typing the following command:
$       svl demo
or even simply
$       svl

After execution of the SVL script, all generated files can be removed by 
typing
$	svl -clean demo
or even simply
$	svl -clean

Note that the verification results reported in Table 5.9 (page 92) of Damien
Thivolle's dissertation correspond to the original TFTP version described in
AUTOMATON_ORIGINAL.lnt. However there are a few differences:

- For TFTP entity A, property 17 evaluates to FALSE on scenario C and not on
  scenario E as reported in the table. This seems to be a typo (a X was put
  in the wrong column), because this property is not checked on scenario E.

- For both TFTP entities A and B, property 09 evaluates to TRUE on scenarios
  C and E, and not to FALSE as reported in the table. This seems to be due
  to an error in the original formula (parentheses were missing). This error
  has been corrected in this demo. Note that property 09 still evaluates to
  FALSE on scenario D.

Note that the expected values of the properties specified in "demo.svl"
correspond to the corrected TFTP version described in AUTOMATON_FINAL.lnt.
As a consequence, all properties should pass with AUTOMATON_FINAL.lnt, whereas
some properties may fail with other TFTP versions.

