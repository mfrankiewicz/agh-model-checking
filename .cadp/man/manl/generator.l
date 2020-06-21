.\" @(#)generator.l - VASY and CONVECS teams - 2020/02/12
.TH GENERATOR LOCAL "2020/02/12" "(C) INRIA" "CADP MANUAL PAGES"
.fp 4 CB
.lg 0
.SH NAME
generator \- BCG graph generation using reachability analysis

.SH SYNOPSIS
.B bcg_open
.RI [ bcg_opt ]
\fIspec\fP[\fB.bcg\fP]
.RI [ cc_opt ]
.B generator
.RI [ generator_opt ]
\fIresult\fP[\fB.bcg\fP]
.P
or:
.P
.B exp.open
[\fIexp_opt\fP]
\fIspec\fP[\fB.exp\fP] 
.RI [ cc_opt ]
.B generator
.RI [ generator_opt ]
\fIresult\fP[\fB.bcg\fP]
.P
or:
.P
.B fsp.open
[\fIfsp_opt\fP]
\fIspec\fP[\fB.lts\fP]
.RI [ cc_opt ]
.B generator
.RI [ generator_opt ]
\fIresult\fP[\fB.bcg\fP]
.P
or:
.P
.B lnt.open
[\fIlnt_opt\fP]
\fIspec\fP[\fB.lnt\fP]
.RI [ cc_opt ]
.B generator
.RI [ generator_opt ]
\fIresult\fP[\fB.bcg\fP]
.P
or:
.P
.B lotos.open
[\fIlotos_opt\fP]
\fIspec\fP[\fB.lotos\fP]
.RI [ cc_opt ]
.B generator
.RI [ generator_opt ]
\fIresult\fP[\fB.bcg\fP]
.P
or:
.P
.B seq.open
[\fIseq_opt\fP]
\fIspec\fP[\fB.seq\fP]
.RI [ cc_opt ]
.B generator
.RI [ generator_opt ]
\fIresult\fP[\fB.bcg\fP]

.SH DESCRIPTION
This program performs exhaustive reachability analysis and generates the 
Labelled Transition System corresponding to
the BCG graph \fIspec\fP\fB.bcg\fP,
the composition expression \fIspec\fP\fB.exp\fP,
the FSP program \fIspec\fP\fB.lts\fP,
the LNT program \fIspec\fP\fB.lnt\fP,
the LOTOS program \fIspec\fP\fB.lotos\fP,
or the sequence file \fIspec\fP\fB.seq\fP.
.P
The resulting Labelled Transition System is encoded in the BCG format and 
stored into file \fIresult\fP\fB.bcg\fP.
.P
Note: In its first form (i.e., when applied to the BCG
graph \fIspec\fP\fB.bcg\fP), this program is not very useful, since the
graph has already been generated.

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
The following options \fIgenerator_opt\fP are currently available:
.TP
.B -monitor
Open a window for monitoring in real-time the generation of 
\fIresult\fP\fB.bcg\fP.

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

.sp
As for the
.BR bcg_labels (LOCAL)
tool, several hiding and/or renaming options can be present on the
command-line, in which case they are processed from left to right.

.TP
.B -uncompress, -compress, -register, -short, -medium, -size
These options control the form under which the BCG graph 
\fIresult\fP\fB.bcg\fP is generated. See the
.BR bcg (LOCAL)
manual page for a description of these options.

.TP
.B -unparse, -parse
These options control label parsing when the BCG graph
\fIresult\fP\fB.bcg\fP is generated. Default option is
.B -parse.
See the
.BR bcg_write (LOCAL)
manual page for a description of label parsing.

.TP
.B -tmp
This option specifies the directory in which temporary files are to
be stored. See the
.BR bcg (LOCAL)
manual page for a description of this option.

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
.B $CADP/src/open_caesar/generator.c 
.P

See the
.BR caesar_hide_1 (LOCAL),
.BR caesar_rename_1 (LOCAL),
.BR bcg_labels (LOCAL)
manual pages for a description of hiding and renaming conventions.

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
Directives for installation are given in files
.B $CADP/INSTALLATION_*.
.P
Recent changes and improvements to this software are reported
and commented in file
.B $CADP/HISTORY.

.SH BUGS
Please report new bugs to Hubert.Garavel@inria.fr

