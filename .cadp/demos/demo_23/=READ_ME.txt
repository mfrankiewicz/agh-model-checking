-- CADP (CONSTRUCTION AND ANALYSIS OF DISTRIBUTED PROCESSES)
-- http://cadp.inria.fr

[Last updated: Sun Jan  3 14:41:07 CET 2016]

This directory contains an example for BCG_MIN, CAESAR, CAESAR.ADT, SVL, 
and XTL. It describes the link layer protocol (asynchronous part) of the
IEEE-P1394 high performance serial bus ("Firewire"), written in full LOTOS
(with values).

* This example (written in E-LOTOS) is presented in:
*    Mihaela Sighireanu and Radu Mateescu. Validation of the Link Layer
*    Protocol of the IEEE-1394 Serial Bus (``FireWire''): an Experiment
*    with E-LOTOS. In Proceedings of the 2nd COST 247 International Workshop
*    on Applied Formal Methods in System Design (Zagreb, Croatia), June 1997.
*    Full version of this paper is available as INRIA Research Report RR-3172.

See
     http://cadp.inria.fr/publications/Sighireanu-Mateescu-97.html
and
     http://cadp.inria.fr/case-studies/97-b-firewire.html

Files:

  scen?_correct_<n>[.<k>].lotos	protocol description (correct version)
  scen?_correct_<n>[.<k>].t	auxiliary file

  scen?_orig_<n>[.<k>].lotos	protocol description (original version)
  scen?_orig_<n>[.<k>].f	auxiliary file

  APPLIC_SCEN?[_<k>].lib	APPLICATION layer description
  BUS.lib			BUS layer description
  DATA.lib			data structures description
  LINK.lib			LINK layer description
  TRANS_CORRECT.lib		TRANS layer description (correct version)
  TRANS_ORIG.lib		TRANS layer description (original version)
  macros.xtl			definitions common to all XTL properties
  req1.seq			specification of a diagnostic sequence
				for property 1 (see notes below)

Note: The size of the graphs depends on the maximal number of nodes connected
to the BUS  (denoted by <n>) and on the maximal number of requests made by
APPLICATION layers (denoted by <k>). If <k> is not present, its value is
supposed to be 0 or 1.

Note: In the "spec.xtl" file, the constant "N" must be initialized with the
maximal value of <n> (among all scenarios).

For each of these scenarios, the corresponding LTS is generated using CAESAR
(and CAESAR.ADT), reduced modulo strong equivalence using BCG_MIN, and the
properties written in "spec.xtl" are checked using XTL.

The verification scenario is described in the "demo.svl" file.
By typing the command:
$       svl demo
or even simply
$	svl
all the LTSs are generated, reduced, and checked automatically.

Notes: 
    - The whole execution of the verification scenario takes about 14
      minutes on a Intel machine using CADP 2014-l.

    - For scenario 3, in its original version, the property 1 (deadlock
      freedom) is false. A diagnostic sequence leading to the deadlock state
      can be obtained using the EXHIBITOR tool using the following command:
$	bcg_open scen3_orig_2.3.bmin.bcg exhibitor < req1.seq
      which gives the sequence for scenario 3, in its original version, 
      with <n>=2 and <k>=3.

Cleanup of the current directory can be obtained by typing:
$       svl -clean demo
or even simply
$	svl -clean

