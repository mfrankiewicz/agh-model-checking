-- CADP (CONSTRUCTION AND ANALYSIS OF DISTRIBUTED PROCESSES)
-- http://cadp.inria.fr

[Last updated: Thu Sep  7 18:16:32 CEST 2017]

This directory contains a LOTOS and LNT case study illustrating C code
generation with EXEC/CAESAR, and the interfacing of this generated code
with a "real" device (here, a Tcl/Tk simulator).

It is based upon a formal description in LOTOS of a Metal Plant Production
Cell. This study has been used to compare different formal methods. It was
launched by Claus Lewerentz and Thomas Lindner of FZI (Forschungszentrum 
Informatik) in Karlsruhe, Germany.

The production cell serves to process metal blanks which are conveyed
to a press by a feed belt. A robot takes each blank from the feed belt and 
places it into the press. The robot arm withdraws from the press, the press
processes the metal blank and opens again. Finally, the robot takes the
forged metal plate out of the press and puts it on a deposit belt.

The LOTOS description used was developed by Hubert Garavel in 1994.
The Tcl/Tk interface was developed by Thomas Lindner of FZI and ported
to Windows by H. Garavel in 2013. In 2013, the LOTOS description was
slightly revisited and translated into LNT by Wendelin Serwe and Hubert
Garavel.

The following files qre provided:
   CONTROLLER.lnt         LNT description: controller process
   DISPATCHER.lnt         LNT description: dispatcher process
   STATES.lnt             LNT description: controller states
   TYPES.lnt              LNT description: type definitions
   cell.lnt               Main file of the LNT description
   gate_functions.c       C code for interaction with the Tcl/Tk simulator
   main.c                 C code for interaction with the Tcl/Tk simulator
   start                  shell-script to run the demo
   clean                  shell-script to clean up after running the demo
   LOTOS/cell             LOTOS description enhanced with macro-definitions
                          to be expanded using the C preprocessor cpp
   LOTOS/cell.f           C implementation for external LOTOS functions
   LOTOS/cell.t           C implementation for external LOTOS types
   doc/Garavel-Serwe-17.pdf   Overview paper on the production cell
   doc/[ST]*.pdf              Textual description of the production cell

The Tcl/Tk files located in the "graphics" directory make up the 
Production Cell simulator. Documentation on this simulator is also
available in the "doc" directory.

Typing the command 
$	./start
compiles everything, produces an executable program named 'driver'
and starts the Production Cell graphical simulator.

Cleanup of the current directory can be obtained by typing:
$	./clean

Note: trying to generate the Labelled Transition System for "cell.lnt" or
"cell.lotos" will not work, as this would require hand-written iterators,
which are not provided in the "cell.tnt" or "cell.t" files.

