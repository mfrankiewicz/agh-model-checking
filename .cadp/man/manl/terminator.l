.\" @(#)terminator.l - VASY and CONVECS teams - 2020/02/12
.TH TERMINATOR LOCAL "2020/02/12" "(C) INRIA" "CADP MANUAL PAGES"
.fp 4 CB
.lg 0
.SH NAME
terminator \- deadlock detection

.SH SYNOPSIS
.B bcg_open
.RI [ bcg_opt ]
\fIspec\fP[\fB.bcg\fP]
.RI [ cc_opt ]
.B terminator
.RI [ terminator_opt ]
.I terminator_param
.P
or:
.P
.B exp.open
[\fIexp_opt\fP]
\fIspec\fP[\fB.exp\fP]
.RI [ cc_opt ]
.B terminator
.RI [ terminator_opt ]
.I terminator_param
.P
or:
.P
.B fsp.open
[\fIfsp_opt\fP]
\fIspec\fP[\fB.lts\fP]
.RI [ cc_opt ]
.B terminator
.RI [ terminator_opt ]
.I terminator_param
.P
or:
.P
.B lnt.open
[\fIlnt_opt\fP]
\fIspec\fP[\fB.lnt\fP]
.RI [ cc_opt ]
.B terminator
.RI [ terminator_opt ]
.I terminator_param
.P
or:
.P
.B lotos.open
[\fIlotos_opt\fP]
\fIspec\fP[\fB.lotos\fP]
.RI [ cc_opt ]
.B terminator
.RI [ terminator_opt ]
.I terminator_param
.P
or:
.P
.B seq.open
[\fIseq_opt\fP]
\fIspec\fP[\fB.seq\fP]
.RI [ cc_opt ]
.B terminator
.RI [ terminator_opt ]
.I terminator_param

.SH DESCRIPTION
This program attempts to detect deadlocks (i.e. states without
successors) in
the BCG graph \fIspec\fP\fB.bcg\fP,
the composition expression \fIspec\fP\fB.exp\fP,
the FSP program \fIspec\fP\fB.lts\fP,
the LNT program \fIspec\fP\fB.lnt\fP,
the LOTOS program \fIspec\fP\fB.lotos\fP,
or the sequence file \fIspec\fP\fB.seq\fP.
It is based on the ``bit state space'' verification technique proposed by Gerard Holzmann.
.P
When the program detects deadlock states, it displays diagnostic sequences, 
i.e., execution sequences leading from the initial state to the deadlock
states. Diagnostic sequences are displayed using the simple SEQ format
(see the
.BR seq (LOCAL)
man page for a description of this format).
.P
Note: the deadlock detection performed using this technique is partial: 
due to potential hash-code collisions, some states may not be visited. 
Therefore, this program is likely to find only a subset of the existing
deadlocks. It might even fail to find deadlocks when they exist.
.P
Note: in its first form (i.e., when applied to the BCG
graph \fIspec\fP\fB.bcg\fP), this program is probably not the best way to
perform deadlock detection.
.P
Note: the
.BR exhibitor (LOCAL)
program can also be used to find the shortest sequence leading to a
deadlock.

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
The following \fIterminator_options\fP are currently available:

.TP
.BI -depth \ depth
Consider only execution sequences whose number of transitions is less or
equal than \fIdepth\fP (where \fIdepth\fP is greater than zero). Prune the 
exploration of the graph when the distance from the initial state becomes 
greater than \fIdepth\fP transitions. By default (if this option is not 
present on the command-line) or if \fIdepth\fP is equal to zero, all
sequences will be considered.
.TP 
.B -none\ \ \ \ \ \ 
Don't print any diagnostic sequence. Not a default option.
.TP 
.B -all\ \ \ \ \ \ 
Print all diagnostic sequences. Not a default option.
.TP
.B -first\ \ \ \ \ \ 
Print the first diagnostic sequence encountered and stop just after.
Not a default option.
.TP
.B -decr\ \ \ \ \ \ 
Print only those diagnostic sequences which are shorter than the last
diagnostic sequence previously diplayed. Prune the exploration of the
graph in order to find diagnostic sequences of decreasing sizes.  It
is not guaranteed that the final sequence is minimal (some shorter
sequence might exist, which can not be found by the program).
.TP
.I by\ default
(in absence of \fB-none\fP, \fB-all\fP, \fB-first\fP, \fB-decr\fP)
.br
Print only the shortest diagnostic sequence obtained. Prune the exploration
of the graph in order to find diagnostic sequences of decreasing sizes.
It is not guaranteed that the final sequence is minimal (some shorter 
sequence might exist, which can not be found by the program).
.P
The parameters \fIterminator_param\fP have the following formats, where
\fIorder\fP is an integer denoting the order in which the transitions 
will be fired (see functions \fBCAESAR_CREATE_EDGE_LIST()\fP and 
\fBCAESAR_CREATE_STACK_1()\fP, in the
.BR caesar_edge (LOCAL)
and
.BR caesar_stack_1 (LOCAL)
manual pages), and where \fIsize\fP, \fIsize_1\fP, 
and \fIsize_2\fP are integer numbers denoting the sizes of bitmap tables:
.P
.IP *
If \fIterminator_param\fP = \fIorder\fP \fIsize\fP
.br
=> automatic search using a single bitmap table with \fIsize\fP entries.
If \fIsize\fP is equal to zero, then the bitmap table will be as large 
as possible, within the limits of the available computer memory.
.P
.IP *
If \fIterminator_param\fP = \fIorder\fP \fIsize_1\fP \fIsize_2\fP
.br
=> automatic search using two bitmap tables with \fIsize_1\fP and
\fIsize_2\fP entries, respectively.
.P
.IP *
If \fIterminator_param\fP is empty
.br
=> interactive mode.

.SH EXIT STATUS
Exit status is 0 if everything is alright, 1 otherwise.

.SH DIAGNOSTICS
When the source is erroneous, error messages are issued.

.SH AUTHOR
Hubert Garavel (INRIA Rhone-Alpes)

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
.PD

.SH FILES

The source code of this tool is available in file 
.B $CADP/src/open_caesar/terminator.c 
.P

.SH SEE ALSO
OPEN/CAESAR Reference Manual,
.BR bcg (LOCAL),
.BR bcg_open (LOCAL),
.BR caesar (LOCAL),
.BR caesar.adt (LOCAL),
.BR exhibitor (LOCAL),
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
Directives for installation are given in files
.B $CADP/INSTALLATION_*.
.P
Recent changes and improvements to this software are reported
and commented in file
.B $CADP/HISTORY.

.SH BUGS
Please report new bugs to Hubert.Garavel@inria.fr
