-- CADP (CONSTRUCTION AND ANALYSIS OF DISTRIBUTED PROCESSES)
-- http://cadp.inria.fr

[Wed Jul  2 16:41:16 CEST 2014]

This directory contains obsolete demo examples for CADP, which have been
kept for archival purpose (some of them may have been used in scientific
publications). Most users of CADP do not need to care with these examples,
which can now be expressed in a better way using the recent features of CADP.
Some of these examples may be still working with the latest CADP versions,
but this is not guaranteed.

The examples are listed below:

    - lib: Collection of LOTOS abstract data types

		   These types can be expressed more easily using LNT.

    - demo_05.old: Linked list (data types only) 
                   [Hubert Garavel] 
                   Tools used: CAESAR.ADT

		   This example is still working, but it is now obsolete,
                   as the same definitions can be expressed more easily
                   using LNT rather than using LOTOS abstract data types.

    - demo_06.old: Boolean array (data types only)
                   [Hubert Garavel]
                   Tools used: CAESAR.ADT, CAESAR, SVL

		   This example is still working, but it is now obsolete,
                   as the same definitions can be expressed more easily
                   using LNT rather than using LOTOS abstract data types.

    - demo_10.old: Alternating bit with data part, same as demo_02
                   but tackled compositionally 
                   [Laurent Mounier, Hubert Garavel, and Frederic Lang]
                   Tools used: CAESAR, CAESAR.ADT, BCG_MIN, BISIMULATOR, SVL

                   This example was merged with demo_02 in January 2014.

    - demo_11.old: rel/REL protocol with data part, same as demo_08
                   but tackled compositionally 
                   [Laurent Mounier, Hubert Garavel, and Frederic Lang]
                   Tools used: CAESAR, CAESAR.ADT, BCG_MIN, BISIMULATOR, SVL

                   This example was merged with demo_08 in January 2014.

    - demo_15.old: Plain Old Telephony System (POTS), specified by Patrick
		   Ernberg (SICS)
		   [Laurent Mounier, Radu Mateescu, Frederic Lang, and
		   Hubert Garavel]
		   Tools used: LNT2LOTOS, CAESAR, CAESAR.ADT, OPEN/CAESAR,
		   EVALUATOR, SVL

                   This example was merged with demo_14 in July 2014.

