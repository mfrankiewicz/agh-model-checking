-- CADP (CONSTRUCTION AND ANALYSIS OF DISTRIBUTED PROCESSES)
-- http://cadp.inria.fr

[Last updated: Tue Feb  2 13:32:54 CET 2016]

TITLE:

  Verification of the Invoicing Case Study

TOOLS:

  BCG_MIN, BISIMULATOR, CAESAR, CAESAR.ADT, SVL, and XTL

AUTHOR:

  Mihaela Sighireanu, May 1998. The work on this application has been
  performed in February and May 1998. See
     http://cadp.inria.fr/publications/Sighireanu-Turner-98.html
  and
     http://cadp.inria.fr/case-studies/98-a-invoice.html

  Upgraded by Frederic Lang and Hubert Garavel in June 2001. The main 
  improvement is the replacement of the Makefile written by Mihaela 
  Sighireanu with a (shorter) SVL script.

  Upgraded by Frederic Lang and Hubert Garavel in January 2015 to
  inline XTL formulas in the SVL script and to take advantage of
  the new property/check statements of SVL.

CONTENT:

  inv2d-p<M_p>-r<M_r>-a<M_a>.lot	data-oriented descriptions (DOD)
  inv2d-p<M_p>-r<M_r>-a<M_a>.t		auxiliary file containing iterators
  DATAD.lib				data library for DOD
  INVOICE.lib				process library for DOD

  inv2p-p<M_p>-r<M_r>-a<M_a>.lot	process-oriented descriptions (POD)
  inv2p-p<M_p>-r<M_r>-a<M_a>.t		auxiliary file containing iterators
  DATAP.lib				data library for POD
  ORDERS.lib				process library for POD
  STOCKS.lib				process library for POD

  inv2p_new-p<M_p>-r<M_r>-a<M_a>.lot	modified process-oriented descriptions
				        to support state variables test (NPOD)
  inv2p_new-p<M_p>-r<M_r>-a<M_a>.t	auxiliary file containing iterators
  ORDERS_new.lib			modified process library for NPOD

  inv2d_safety-p<M_p>-r<M_r>-a<M_a>.lot	modified data-oriented descriptions
				        to support safety equivalence (SDOD)
  inv2d_safety-p<M_p>-r<M_r>-a<M_a>.t	auxiliary file containing iterators

  macros.xtl				definitions common to all XTL properties
  demo.svl				SVL script guiding the verification
  =READ_ME.txt				this file

REMARKS:

  The size of the graphs depends on the maximal numbers of order references
  <M_r>, the maximal numbers of products <M_p>, and the maximal numbers of 
  amounts <M_a>.

  In "macros.xtl" file, the constant "N" must be initialized with the
  maximal value of order references <M_r>.

  Some particular LTSs belonging to description having M_p=1 cannot be 
  generated because of state explosion or of large computation time. 
  If you have enough computation power and time available, you may try
  these examples by modifying the script "demo.svl" to enable M_p=1
  in the second "for" loop.

INSTRUCTIONS:

- The appropriate invocations are described in the "demo.svl" file. 
  Execution of the verification scenario can be performed by typing:

$	svl demos
or even simply
$	svl

- Cleanup of the current directory can be obtained by typing:

$       svl -clean demos
or even simply
$	svl -clean


REFERENCES:

  - Mihaela Sighireanu, Model-checking Validation of the LOTOS Descriptions
    of the Invoicing Case Study, appeared in Proceeding of the First 
    International Workshop on Comparing System Specification Techniques, 
    CSST'98, Nantes, March 26--27 1998. (Short version of the report below.)

  - Mihaela Sighireanu, Ken Turner, Invoicing Problem: (E-)LOTOS Description 
    and Model-checking Verification, to appear as INRIA Research Report.

