.\" @(#)bcg_info.l - VASY and CONVECS teams - 2019/01/09
.TH BCG_INFO LOCAL "2019/01/09" "(C) INRIA" "CADP MANUAL PAGES"
.fp 4 CB
.lg 0
.SH NAME
bcg_info \- display information about graphs encoded in the BCG format

.SH SYNOPSIS
.B bcg_info
[
\fIbcg_options\fP
]
[
.B \-branching
]
[
.B \-deadlock
]
[
.B \-format
]
[
.B \-hidden
]
[
.B \-labels
]
[
.B \-nondeterministic \fIlabel_number\fP
]
[
.B \-order
]
[
.B \-path \fIstate_number\fP
]
[
.B \-profiles
]
[
.B \-size
]
[
.B \-unreachable
]
[
.B \-compact | \-verbose | \-line
]
.IB filename [.bcg]

.SH DESCRIPTION
This command takes as input the BCG graph
.IB filename .bcg
and displays various information (number of states, number of
transitions, number of labels, etc.) about this graph.
.P
A dynamic library corresponding to 
.IB filename .bcg
may be generated if necessary.

.SH GENERAL OPTIONS
The following \fIbcg_options\fP are currently supported: 
\fB-version\fP, \fB-create\fP, \fB-update\fP, \fB-remove\fP, \fB-cc\fP, 
and \fB-tmp\fP. See the
.BR bcg (LOCAL)
manual page for a description of these options.

.SH PARTICULAR OPTIONS
The following options are also supported:

.TP
.B \-branching\ \ \ \ 
Display statistics about the branching factor, i.e., the average, minimal,
and maximal number of transitions going out of the states.

.TP
.B \-deadlock\ \ \ \ \ \ 
Display the list of deadlock states. 
The output of this command can be controlled using the \fB-compact\fP, 
\fB-verbose\fP, and \fB-line\fP options (see below).

.TP
.B \-format\ \ \ \ \ \ 
Display the BCG format version number (e.g., 1.0, 1.1) used for
.IB filename [.bcg]

.TP
.B \-hidden\ \ \ \ \ \ 
Display the number of hidden (i.e., `tau') transitions.

.TP
.B \-labels\ \ \ \ \ \ 
Display the number of labels followed by the list of labels.

.TP
.B \-nondeterministic \fIlabel_string\fP\ \ \ \ \ \ 
Display the list of states in which there is nondeterminism for label
\fIlabel_string\fP, i.e., the states in which there are at least two
outgoing transitions labelled by \fIlabel_string\fP. If \fIlabel_string\fP
is equal to the special string `-', then nondeterministic states are searched
for each label. 
The output of this command can be controlled using the \fB-compact\fP, 
\fB-verbose\fP, and \fB-line\fP options (see below).

.TP
.B \-order
Display information about the order in which transitions are sorted
(depending on source states, destination states and label numbers)

.TP
.B \-path \fIstate_number\fP\ \ \ \ \ \ 
Display the shortest path from the initial state to the state given by
\fIstate_number\fP. The path is displayed using the simple SEQ format
(see the
.BR seq (LOCAL)
man page for a description of this format).

.TP
.B \-profiles
Undocumented option.

.TP
.B \-size\ \ \ \ \ \ 
Display the number of states and transitions on a single line.

.TP
.B \-unreachable\ \ \ \ \ \ 
Display the list of states that cannot be reached from the initial state
of the graph (this list should be empty if the graph is connected). 
The output of this command can be controlled using the \fB-compact\fP, 
\fB-verbose\fP, and \fB-line\fP options (see below).

.TP
.B \-compact\ \ \ \ \ 
Display lists of states in a user-friendly, synthetic form. There are 
about ten state numbers per line and, whenever possible, a shorthand notation
`\fIM\fP ... \fIN\fP' is used to indicate all state numbers in the range
between \fIM\fP and \fIN\fP. Default option.

.TP
.B \-verbose\ \ \ \ \ 
Similar to \-compact option, except that the shorthand notation `...' is
not used. Not a default option.

.TP
.B \-line\ \ \ \ \ \ 
Display lists of states in a simple form, with only one state number 
per line. Not a default option.

.SH ENVIRONMENT VARIABLES

See the
.BR bcg (LOCAL)
manual page for a description of the environment variables used by all
the BCG application tools.


.SH EXIT STATUS
Exit status is 0 if everything is alright, 1 otherwise.

.SH AUTHORS
Hubert Garavel, Bruno Ondet, and Damien Bergamini

.SH OPERANDS
.PD 0
.TP 25
.IB filename .bcg
BCG graph (input)
.TP
.IB filename @1.o
dynamic library (input or output)
.PD

.SH FILES
.PD 0
.TP 32
.B $CADP/com/bcg_info
``\fBbcg_info\fP'' shell script
.TP
.B $CADP/bin.`arch`/libbcg_info.a
``\fBbcg_info\fP'' static library
.PD
.P
See the
.BR bcg (LOCAL)
manual page for a description of the other files.

.SH SEE ALSO
.BR bcg (LOCAL),
.BR bcg_read (LOCAL),
.BR seq (LOCAL)
.P
Additional information is available from the CADP Web page located at
http://cadp.inria.fr
.P
Directives for installation are given in files \fB$CADP/INSTALLATION_*\fP.
.P
Recent changes and improvements to this software are reported
and commented in file \fB$CADP/HISTORY\fP.

.SH BUGS

Please report bugs to Hubert.Garavel@inria.fr
