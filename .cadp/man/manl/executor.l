.\" @(#)executor.l - VASY and CONVECS teams - 2020/02/12
.TH EXECUTOR LOCAL "2020/02/12" "(C) INRIA" "CADP MANUAL PAGES"
.fp 4 CB
.lg 0
.SH NAME
executor \- random execution 

.SH SYNOPSIS
.B bcg_open
.RI [ bcg_opt ]
\fIspec\fP[\fB.bcg\fP] 
.RI [ cc_opt ]
.BI executor
.RI [ executor_opt ]
.I executor_param
.P
or:
.P
.B exp.open
[\fIexp_opt\fP]
\fIspec\fP[\fB.exp\fP]
.RI [ cc_opt ]
.BI executor
.RI [ executor_opt ]
.I executor_param
.P
or:
.P
.B fsp.open
[\fIfsp_opt\fP]
\fIspec\fP[\fB.lts\fP]
.RI [ cc_opt ]
.BI executor
.RI [ executor_opt ]
.I executor_param
.P
or:
.P
.B lnt.open
[\fIlnt_opt\fP]
\fIspec\fP[\fB.lnt\fP]
.RI [ cc_opt ]
.BI executor
.RI [ executor_opt ]
.I executor_param
.P
or:
.P
.B lotos.open
.RI [ lotos_opt ]
\fIspec\fP[\fB.lotos\fP]
.RI [ cc_opt ]
.BI executor
.RI [ executor_opt ]
.I executor_param
.P
or: 
.P
.B seq.open 
[\fIseq_opt\fP]
\fIspec\fP[\fB.seq\fP]
.RI [ cc_opt ]
.BI executor
.RI [ executor_opt ]
.I executor_param

.SH DESCRIPTION
This program explores the labelled transition system corresponding to
the BCG graph \fIspec\fP\fB.bcg\fP,
the composition expression \fIspec\fP\fB.exp\fP,
the FSP program \fIspec\fP\fB.lts\fP,
the LNT program \fIspec\fP\fB.lnt\fP,
the LOTOS program \fIspec\fP\fB.lotos\fP,
or the sequence file \fIspec\fP\fB.seq\fP,
and produces a random execution sequence.
.P
Visible labels in the execution sequence are displayed as the
corresponding transitions are fired. Invisible labels (noted
``\fBi\fP'') are not displayed.
.P
The execution sequence is displayed using the full SEQ format
(see the
.BR seq (LOCAL)
man page for a description of this format).
.P
Various strategies are currently available to solve non-determinism:

.IP (1):
Non-determinism is not allowed. The program will stop if the
current state has more than one successor.

.IP (2):
Non-determinism is allowed. If the current state has several
successors, one of them is selected using a pseudo-random number
generator. The seed of the generator is initialized using the system
clock.

.IP (3):
Same as strategy (2), except that the seed of the generator is provided
by the user, in order to obtain reproducible execution sequences.

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
The following options \fIexecutor_opt\fP are currently available:
.TP
\fB\-hide [ \-total | \-partial | \-gate ]\fP \fIhiding_filename\fP
Use the hiding rules defined in \fIhiding_filename\fP to hide (on the fly)
the labels of the Labelled Transition System being generated. See the
.BR caesar_hide_1 (LOCAL)
manual page for a detailed description of the appropriate format for
\fIhiding_filename\fP.
.sp
The \fB-total\fP, \fB-partial\fP, and \fB-gate\fP options specify the "total
matching", "partial matching", and "gate matching" semantics, respectively.
See the
.BR caesar_hide_1 (LOCAL)
manual page for more details about these semantics. Option
\fB-total\fP is the default.
.P

.TP
\fB\-rename [\-total|\-single|\-multiple|\-gate]\fP \fIrenaming_filename\fP
Use the renaming rules defined in \fIrenaming_filename\fP to rename (on the
fly) the labels of the Labelled Transition System being generated. See the
.BR caesar_rename_1 (LOCAL)
manual page for a detailed description of the appropriate format for
\fIrenaming_filename\fP.
.sp
The \fB-total\fP, \fB-single\fP, \fB-multiple\fP, and \fB-gate\fP options
specify the "total matching", "single partial matching", "multiple partial
matching", and "gate matching" semantics, respectively. See the
.BR caesar_rename_1 (LOCAL)
manual page for more details about these semantics.  Option
\fB-total\fP is the default.

.P
The parameters \fIexecutor_param\fP have the following formats, where
\fIdepth\fP is an integer denoting the maximal number of transitions to be 
fired (if \fIdepth\fP = 0, no upper bound is fixed) and where \fIseed\fP
is an integer denoting the value of the chosen seed:

.IP *
If \fIexecutor_param\fP =\ 
.IB depth \ 1
.br
=> strategy (1): deterministic execution
.P
.IP *
If \fIexecutor_param\fP =\ 
.IB depth \ 2
.br
=> strategy (2): non-deterministic with random seed
.P
.IP *
If \fIexecutor_param\fP =\ 
.IB depth \ 3 \ seed
.br
=> strategy (3): non-deterministic with chosen seed
.P
.IP *
If \fIexecutor_param\fP is empty
.br
=> interactive mode.

.SH EXIT STATUS
When the source is erroneous, error messages are issued.  Exit status
is 0 if everything is alright, 1 otherwise.

.SH AUTHOR
Hubert Garavel (INRIA Rhone-Alpes)

.SH FILES
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
.P
The source code of this tool is available in file 
.B $CADP/src/open_caesar/executor.c 
.P

.SH SEE ALSO
OPEN/CAESAR Reference Manual,
.BR bcg_open (LOCAL),
.BR bcg (LOCAL),
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
Directives for installation are given in files
.B $CADP/INSTALLATION_*.
.P
Recent changes and improvements to this software are reported and
commented in file
.B $CADP/HISTORY.

.SH BUGS
Please report new bugs to Hubert.Garavel@inria.fr

