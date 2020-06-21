'\" t
.\" @(#)ocis.l - VASY and CONVECS teams - 2020/02/12
.TH OCIS LOCAL "2020/02/12" "(C) INRIA" "CADP MANUAL PAGES"
.fp 4 CB
.lg 0

.cs 4 23

.SH NAME
ocis \- Open/Caesar Interactive Simulator

.SH SYNOPSIS
.B bcg_open
.RI [ bcg_opt ]
\fIspec\fP[\fB.bcg\fP] 
.RI [ cc_opt ]
.B ocis
.RI [ ocis_opt ]
.P
or:
.P
.B exp.open
[\fIexp_opt\fP]
\fIspec\fP[\fB.exp\fP] 
[\fIcc_opt\fP]
.B ocis
.RI [ ocis_opt ]
.P
or:
.P
.B fsp.open
[\fIfsp_opt\fP]
\fIspec\fP[\fB.lts\fP]
[\fIcc_opt\fP]
.B ocis
.RI [ ocis_opt ]
.P
or:
.P
.B lnt.open
[\fIlnt_opt\fP]
\fIspec\fP[\fB.lnt\fP]
[\fIcc_opt\fP]
.B ocis
.RI [ ocis_opt ]
.P
or:
.P
.B lotos.open 
.RI [ lotos_opt ]
\fIspec\fP[\fB.lotos\fP]
.RI [ cc_opt ]
.B ocis
.RI [ ocis_opt ]
.P
or:
.P
.B seq.open
[\fIseq_opt\fP]
\fIspec\fP[\fB.seq\fP]
.RI [ cc_opt ]
.B ocis
.RI [ ocis_opt ]

.SH DESCRIPTION 

.P
OCIS (Open/Caesar Interactive Simulator) is an interactive, graphical simulator for the CADP toolset. OCIS enables visualization and error detection during the design phase of systems containing parallelism and asynchronous communication between tasks.

.P
OCIS was designed to be language-independent as much as possible and should therefore be usable for any specification language or formalism interfaced with the Open/Caesar API (version 1 or 2). For instance, to be simulated using OCIS, a system may be either specified as
a BCG graph \fIspec\fP\fB.bcg\fP,
a composition expression \fIspec\fP\fB.exp\fP,
an FSP program \fIspec\fP\fB.lts\fP,
a LNT program \fIspec\fP\fB.lnt\fP,
a LOTOS program \fIspec\fP\fB.lotos\fP,
or a sequence file \fIspec\fP\fB.seq\fP.

.P
The main features of OCIS are:

.IP -
\fBVisualization of simulation scenarios\fP, which are trees describing the execution paths followed by the user. Scenarios can be visualized under three different forms: execution traces, trees, and MSC (\fIMessage Sequence Charts\fP) diagrams that reflect the communications between parallel processes (emission/reception of messages, rendez-vous, diffusion, etc.) 

.IP -
\fBManipulation of simulation scenarios\fP, which can be edited, saved as BCG graphs, and loaded again during another simulation session. 

.IP -
\fBManual (step by step) and automatic navigation\fP in the system under simulation: when several tasks are involved, the navigation is done on the communicated automata describing the whole system. Automatic navigation is done in two ways. The first way uses the Open/Caesar tool Exhibitor in order to find one or more execution sequences corresponding to regular expressions searched by the user. The second way consists in re-playing some parts of sequences obtained in former simulation sessions.

.IP -
\fBSource-level debugging\fP: The user can follow the execution of the source code and the evolution of the state variables during simulation. The user can also focus on a particular parallel task, and on the evolution of a subset of the state variables.

.IP -
\fBPossibility to modify the source code\fP and to re-compile it without quitting the current simulation session. This is done in a transparent way, by trying to replay the current simulation scenario with the updated system obtained after applying the changes in the source code and recompiling.

.SH OPTIONS

The options \fIbcg_opt\fP, if any, are passed to
.BR bcg_lib (LOCAL).

.P
The options \fIexp_opt\fP, if any, are passed to
.BR exp.open (LOCAL).

.P
The options \fIfsp_opt\fP, if any, are passed to
.BR fsp.open (LOCAL).

.P
The options \fIlnt_opt\fP, if any, are passed to
.BR lnt.open (LOCAL).

.P
The options \fIlotos_opt\fP, if any, are passed to
.BR caesar (LOCAL)
and to
.BR caesar.adt (LOCAL).

.P
The options \fIseq_opt\fP, if any, are passed to
.BR seq.open (LOCAL).

.P
The options \fIcc_opt\fP, if any, are passed to the C compiler.
.P
The following options \fIocis_opt\fP are currently available:

.TP
.B -tty
Launch OCIS in non-graphical mode.

.SH GENERAL OVERVIEW OF THE GRAPHICAL USER-INTERFACE

.P
The main window of OCIS is divided as follows (from top to bottom):

.IP -
On top, the \fBMenu\fP (see description below)

.IP -
Just below, the \fBMenu bar\fP

.IP -
Then, the \fBHistory sub window\fP (see description below)

.IP -
The \fBTransition sub-window\fP (see description below)

.IP -
On bottom, the \fBOn-line help bar\fP

.P
Navigation through the entries of this menu may be done by using the
mouse or using "tab" and the "space key" for selecting the button.

.ce 1
see http://cadp.inria.fr/man/pictures/ocis1.jpg
.ce 1
.I "Main window of OCIS"

.SH VIEWS

.SS HISTORY SUB-WINDOW

.P
It is the upper part of the OCIS window.  It is dedicated to the visualization of the scenario being simulated.  There are three visualization modes: the MSC view, the TEXT view, and the TREE view. Each of these views is activated through a thumbnail-index.

.IP -
\fBMSC view\fP: This visualization mode shows the interactions between processes. Each task is shown as a vertical line. Each transition is shown as a horizontal line. If a process synchronizes on this transition, a circle is shown at the intersection of the 2 lines. When a task changes its process, it is shown on the vertical line of this task, and the name of the process is displayed.

.IP -
\fBTEXT view\fP: Display the current path as a sequence of labels. 

.IP -
\fBTREE view\fP: Display the whole scenario as a tree. Each branch in the tree represents a sequence of explored transitions in the automaton of the simulated system. In particular, the repetitive exploration of a cycle in this automaton results in a sequence of transitions which length is a multiple of the length of the cycle.

.P
\fBMouse interactions\fP: In each of the three views, clicking on a transition with the left button of the mouse permits to go back to this transition. In both TEXT and MSC views, clicking on the right button of the mouse will popup a menu giving information and source capabilities.

.ce 1
see http://cadp.inria.fr/man/pictures/ocis2.jpg
.ce 1
.I "The MSC view"

.ce 1
see http://cadp.inria.fr/man/pictures/ocis3.jpg
.ce 1
.I "The TEXT view"

.ce 1
see http://cadp.inria.fr/man/pictures/ocis4.jpg
.ce 1
.I "The TREE view"

.SS TRANSITION SUB-WINDOW

.P
It is the lower part of the OCIS window. It displays the list of transitions that can be fired from the current state.  There are two visualization modes: the MSC view, and the TEXT view.

.IP -
\fBMSC view\fP: Display the list of the transitions that can be fired from the current state as an MSC diagram.

.IP -
\fBTEXT view\fP: Display the list of labels of the transitions that can be fired from the current state.

.P
\fBMouse interactions\fP: In both MSC and TEXT views, clicking on a transition with the left button of the mouse permits to put this transition in the history window (i.e. follow the transition). Clicking on the right button of the mouse will popup a menu giving information and source capabilities.

.SH MENUS

.ce 1
see http://cadp.inria.fr/man/pictures/ocis5.jpg
.ce 1
.I "The menu and buttons bars"

.P
The following subsections describe each menu entry of OCIS.

.SS FILE

.IP -
\fBReset\fP: Clear the current scenario.

.IP -
\fBNew\fP: Clear the current scenario and open a new scenario.

.IP -
\fBLoad\fP: Select and load an existing simulation scenario (\fB.bcg\fP file).

.IP -
\fBSave as\fP: Select a name for the current scenario and save it.

.IP -
\fBSave\fP: Save the current scenario (without changing the name, 
by default \fBuntitled.bcg\fP). Scenario files are saved in the BCG file format, see 
.BR bcg (LOCAL).
Many other tools of the CADP toolkit can read the BCG file format. For instance, the program 
.BR bcg_draw (LOCAL)
will draw the tree of scenarios. Each label of the BCG tree contains 2 parts separated by a "#" symbol: the first is a list of internal values for OCIS, the second is the labelled transition.


.IP -
\fBSave sequence tree\fP: Select a file name (with extension \fB.bcg\fP) for the sub-tree of the current scenario (defined by the path starting at the initial state and ending at the current state, and the sub-tree going out from the current state) and save it (in the BCG file format, see 
.BR bcg (local)
).

.IP -
\fBSave a sequence of labels\fP: Select a file name (with extension \fB.seq\fP) and save the labels of the transitions lying on the current active path (starting at the initial state and ending at the current state).

.IP -
\fBPreview PostScript\fP: Show a preview of the current scenario (all or part of it) in PostScript. Use the viewer defined by the environment variable \fBCADP_PS_VIEWER\fP.

.ce 1
see http://cadp.inria.fr/man/pictures/ocis6.jpg
.ce 1
.I "The printing, display, and PostScript generation selectors"

.IP -
\fBPrint PostScript\fP: Print the current scenario (all or part of it).

.IP -
\fBSave PostScript\fP: Save the current scenario (all or part of it) in the PostScript format. 

.IP -
\fBQuit\fP: Exit OCIS after verification of the status of the current scenario. If the scenario changed since the last saving, propose the user to save it before quitting.

.SS EDIT

.IP -
\fBSelect current transition (Tree view only)\fP: Select the current transition and highlight it.

.IP
\fBNotice\fP: Effective only in the Tree view. This command is bound to a click on the right button of the mouse, or to a click on the left button of the mouse while hitting the Shift key.

.IP -
\fBSelect specific transitions (Tree view only)\fP: Open a selection menu for choosing a specific label to be searched and selected. The search can start from the initial or the current state. The number of selected transitions is given as a result in this selection window.

.IP
\fBNotice\fP: Effective only in the Tree view.

.IP -
\fBDisable selection\fP: Disable all the selected transitions and unhighlight them.

.IP
\fBNotice\fP: Effective only in the Tree view.

.IP -
\fBClose selected transitions\fP: Close the selected transitions which are visible in the Tree view.

.IP
\fBNotice\fP: Effective only in the Tree view. When many transitions are selected on the same path, only the closest transition to the initial state is closed.

.IP -
\fBOpen selected transitions\fP: Open the selected transitions which are invisible in the Tree view.

.IP
\fBNotice\fP: Effective only in the Tree view. All the closed selected transitions are open.

.IP -
\fBCut selected transitions\fP: Cut the selected transitions and the sub-trees going out from them. The parent of the last cut selected transition becomes the current transition. (Information on fireable transitions from this new transition is updated.)

.IP -
\fBCut current transition\fP: Cut the current transition and the sub-tree going out from it. The parent transition of the cut one becomes the current transition. (Information on fireable transition from this new transition is updated).

.IP -
\fBCut down tree of current transition\fP: Cut only the sub-tree going out from the current transition. (Information on fireable transitions from this new transition is updated.)

.IP -
\fBFind regular expressions\fP: Popup an interface to select options and \fB.seq\fP sequences for launching the 
.BR exhibitor (LOCAL)
tool.

.ce 1
see http://cadp.inria.fr/man/pictures/ocis7.jpg
.ce 1
.I "The Open/Caesar Exhibitor selector"


.SS MOTION

.IP -
\fBBackward\fP: Move backward to the state preceding the current state.

.IP -
\fBForward\fP: Move forward to the last state following the current state.

.IP -
\fBShow current transition\fP: Make current transition visible.

.IP -
\fBShow top\fP: Make the initial state visible.

.SS WINDOW

.IP -
\fBEdit source file\fP: Select a file and edit it using the text editor specified by the environment variable \fBEDITOR\fP.

.IP -
\fBViewing source code\fP: Display the source code of the current specification and show the trace of the execution by highlighting the code corresponding to firing the current transition. The values of internal variables are also displayed.

.IP
\fBNotice\fP: In the source window, the source line concerning the selected transition is highlighted and any variable name appearing on the line is left clickable: by clicking on it, the type and the value of the variable are displayed.  Each task is selectable separately by clicking on the visual tab on top of the window.  The "Edit..." button allows to edit the file using the text editor specified by the environment variable \fBEDITOR\fP.

.IP -
\fBRecompile\fP: Open a window for launching re-compilation of the current specification with the Caesar compiler.

.IP -
\fBOpen shell window\fP: Open a terminal window running a shell interpreter.

.ce 1
see http://cadp.inria.fr/man/pictures/ocis8.jpg
.ce 1
.I "The source code visualization window"

.ce 1
see http://cadp.inria.fr/man/pictures/ocis9.jpg
.ce 1
.I "The source code re-compilation window"

.SS OPTIONS

.IP -
\fBAuto advance mode\fP: Expand automatically the scenario each time a single transition can be fired from the current state.

.IP -
\fBLoopback checking\fP: Show loopback transitions.

.IP
\fBCaution\fP: This option may significantly slow down the simulator when activated.

.IP -
\fBExtended MSC format\fP: Display further information on the tasks involved in a given transition. (Effective on MSC view.)

.IP -
\fBMake windows foreground\fP: Raise automatically to foreground the window on which the mouse is located.

.IP -
\fBSave preferences in current directory\fP: Save preferences in the \fB.ocisrc\fP file located in the directory where OCIS has been launched. This file is read when OCIS is launched. If this file does not exist, OCIS searches instead for file \fB$HOME/.config/cadp/ocisrc\fP, where the environment variable \fB$HOME\fP refers to the home directory. If both files do not exist, OCIS uses its standard preferences.

.IP -
\fBSave preferences in home directory\fP: Save preferences in file \fB$HOME/.config/cadp/ocisrc\fP, so that the saved preferences can be reused in other simulation sessions.

.IP -
\fBReset preferences\fP: Erase the \fB.ocisrc\fP file located in the current directory.

.SS HELP

.IP -
\fBIndex\fP: Open a navigator providing indexed information about OCIS.

.IP -
\fBAbout OCIS\fP: Show version and copyright information.

.SH OPERANDS

.PD 0
.TP 20
.IB spec .bcg
BCG graph (input)
.TP
.IB spec .exp
network of communicating LTSs (input)
.TP
.IB spec .lts
FSP specification (input)
.TP
.IB spec .lnt
LNT specification (input)
.TP
.IB spec .lotos
LOTOS specification (input)
.TP
.IB spec .seq
sequence file (input)
.TP
.IB *.bcg 
scenario files in BCG format (input/output)
.TP
.IB *.ps
PostScript files for printer (output)
.PD

.SH FILES

The binary code of this tool is available in file
.B $CADP/bin.`arch`/ocis.a

.P
Auxiliary files are located in directory
.B $CADP/src/ocis

.SH AUTHORS

.P
Ordered alphabetically:
Moez Cherif,
Hubert Garavel,
Bruno Hondelatte,
Pierre-Alexandre Kessler,
Frederic Perret.

.P
Ocis benefited from the suggestions of Radu Mateescu and Nicolas Zuanon.

.SH SEE ALSO
OPEN/CAESAR Reference Manual,
.BR bcg (LOCAL),
.BR bcg_open (LOCAL),
.BR caesar (LOCAL),
.BR caesar.adt (LOCAL),
.BR exp (LOCAL),
.BR exp.open (LOCAL),
.BR fsp.open (LOCAL),
.BR lnt.open (LOCAL),
.BR lotos (LOCAL),
.BR lotos.open (LOCAL),
.BR seq (LOCAL),
.BR seq.open (LOCAL)

.P
Additional information is available from the CADP Web page located at http://cadp.inria.fr
.P
Directives for installation are given in files \fB$CADP/INSTALLATION_*\fP.
.P
Recent changes and improvements to this software are reported and commented in file \fB$CADP/HISTORY\fP.

.SH BUGS

.P
Please report bugs to Hubert.Garavel@inria.fr

