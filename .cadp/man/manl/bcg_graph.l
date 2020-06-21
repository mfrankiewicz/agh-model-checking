'\" t
.\" @(#)bcg_graph.l - VASY and CONVECS teams - 2014/07/11
.TH BCG_GRAPH LOCAL "2014/07/11" "(C) INRIA" "CADP MANUAL PAGES"
.fp 4 CB
.lg 0

.SH NAME
bcg_graph \- generate various kinds of useful BCG graphs

.SH SYNOPSIS
.B bcg_graph
[\fIbcg_options\fP]
.B \-chaos
[\fIlabelfile\fP | \fB-labels\fP \fInumber\fP\ \fIpattern1\fP]
[\fB-monitor\fP] [\fB-verbose\fP]
\fIoutput\fP [\fB.bcg\fP]

.P
or

.P
.B bcg_graph
[\fIbcg_options\fP]
.B \-bag \fIsize\fP
[\fIlabelfile\fP | \fB-labels\fP \fInumber\fP\ \fIpattern1\fP \fIpattern2\fP]
[\fB-monitor\fP] [\fB-verbose\fP]
\fIoutput\fP [\fB.bcg\fP]

.P
or

.P
.B bcg_graph
[\fIbcg_options\fP]
.B \-fifo \fIsize\fP
[\fIlabelfile\fP | \fB-labels\fP \fInumber\fP\ \fIpattern1\fP \fIpattern2\fP]
[\fB-monitor\fP] [\fB-verbose\fP ]
\fIoutput\fP [\fB.bcg\fP]

.SH DESCRIPTION
This command produces a BCG graph named
.IB output .bcg
the structure of which is specified by the command-line options. At present, 
three kinds of graphs can be generated using this command: chaos automata,
bag buffers, and FIFO buffers (see below for detailed definitions).

.P
Note: Such particular graphs could be easily described in a high-level language such as LOTOS or LNT, and then translated to BCG. However, the \fBbcg_graph\fP tool contains specialized algorithms designed for time and memory efficiency and ensuring that each generated graph is minimal wrt to branching bisimulation.

.P
Note: Unless specified otherwise, \fBbcg_graph\fP generates graphs that are minimal for strong equivalence (i.e., that do not contain redondant states or transitions). However, this property is only ensured if the specified labels are pairwise different.

.SH GENERAL OPTIONS
The following \fIbcg_options\fP are currently supported:
\fB-version\fP, \fB-tmp\fP, \fB-uncompress\fP, \fB-compress\fP, 
\fB-register\fP, \fB-short\fP, \fB-medium\fP, and \fB-size\fP. See the
.BR bcg (LOCAL)
manual page for a description of these options.

See the
.BR bcg (LOCAL)
manual page for a description of these options.

.SH PARTICULAR OPTIONS
The following options and arguments are also supported:

.TP
.B \-chaos\ \ \ \ 
Generate a chaos automaton.
This option must occur immediately after \fIbcg_options\fP on the command-line.

.TP
.B \-bag \fIsize\fP\ \ \ \ \ \ 
Generate a bag buffer with \fIsize\fP places (with \fIsize\fP >= 0).
This option must occur immediately after \fIbcg_options\fP on the command-line.

.TP
.B \-fifo \fIsize\fP\ \ \ \ \ \ 
Generate a FIFO buffer with \fIsize\fP places (with \fIsize\fP >= 0).
This option must occur immediately after \fIbcg_options\fP on the command-line.

.TP
.I labelfile\ \ \ \ \ \ \ \ \ 
Specify that the labels of the generated graph are listed in file \fIlabelfile\fP containing an exhaustive list of labels, one label per line. See Section LABEL DEFINITIONS below for details.

.TP
.B \-labels \fInumber\fP \fIpattern1\fP [\fIpattern2\fP]\ \ \ \ \ \ 
Specify that the labels of the generated graph are defined by \fIpattern1\fP (and possibly \fIpattern2\fP) instantiated by integers in the range [1..\fInumber\fP] (with \fInumber\fP >= 0).
See Section LABEL DEFINITIONS below for a definition of patterns.
This option is forbidden if \fIlabelfile\fP is given and mandatory otherwise.

.TP
.B \-monitor\ \ \ \ \ \ 
Open a window for monitoring the graph generation in real-time.
Not a default option.

.TP
.B \-verbose\ \ \ \ \ \ 
Display the number of states and transitions of the generated graph.
Not a default option.

.SH CHAOS AUTOMATA

Chaos automata (\fB-chaos\fP option) accept all messages in a given set of messages.
.sp
A chaos automaton is determined by the number N (with N >= 0) of different messages it can handle. It has a single state and N looping transitions, each labelled by a different message.

.SH BAG BUFFERS

Bag buffers (\fB-bag\fP option) model communication media that do not lose messages but do not preserve the ordering of messages (messages are reset in any order).
.sp
A bag buffer is determined by its size P (with P >= 0), which is the maximal number of messages that can be stored into the buffer, and the number N (with N >= 0) of different messages (there are N labels corresponding to message inputs and N labels corresponding to message outputs; see the notions of get-label and put-label below).
.sp
The number of states of a bag buffer is equal to
.nf
     (N+P)! / (N! * P!)
.fi
The number of transitions of a bag buffer is equal to
.nf
     if N=0 or P=0 then 0 else 2*(N+P-1)!/((N-1)!*(P-1)!)
.fi

.SH FIFO BUFFERS

FIFO buffers (\fB-fifo\fP option) model communication media that do not lose messages and preserve the ordering of messages (messages are resent in the same order as they were received).
.sp
A FIFO buffer is determined by its size P (with P >= 0), which is the maximal number of messages that can be stored into the buffer, and the number N (with N >= 0) of different messages (there are N labels corresponding to message inputs and N labels corresponding to message outputs; see the notions of get-label and put-label below).
.sp
The number of states of a FIFO buffer is equal to 
.nf
     sum_{k in 0..P} N^k
.fi
or also
.nf
     if N=1 then P+1 else (N^(P+1)-1)/(N-1)
.fi
The number of transitions of a FIFO buffer is equal to
.nf
     2 * N * sum_{k in 0..P-1} N^k
.fi
or also
.nf
     if N=1 then 2*P else 2*N*(((N^P)-1)/(N-1))
.fi

.SH LABEL DEFINITIONS
.P
For some forms of graphs (such as \fI-chaos\fP), a single list of labels is needed.
.P
For other forms of graphs (such as \fI-bag\fP and \fI-fifo\fP), two lists of labels are needed: the get-labels (corresponding to input messages) and the put-labels (corresponding to output messages). There is a pairwise correspondence between both lists, as each put-label emitted corresponds to a get-label received previously.

.SS A. LABELS DEFINED USING A FILE
.P
A \fIlabelfile\fP contains a list of labels separated with newline characters.
Labels are strings of characters without newline characters.
Labels can be enclosed between double quotes, which will be ignored, and may contain spaces.
For instance, \fBA\fP, \fB"B"\fP, and \fB"A !1 !CONS(3, 4)"\fP are valid labels.
In the label definition file, lines that contain only spaces (including empty lines) are ignored.
On each line, leading and trailing spaces are ignored, unless they are enclosed in quotes.
.P
For graphs requiring two lists of labels, the position of each label in the file determines whether it is a put-label or a get-label. 
In the \fIlabelfile\fP, pairs of corresponding labels alternate strictly. 
Each get-label occurs on an odd-numbered line and is followed by its corresponding put-label on an even-numbered line (empty lines notwithstanding).
Therefore, there must be an even number of labels in \fIlabelfile\fP.
.P
The degenerate case in which \fIlabelfile\fP contains no label (e.g., the file is empty) is permitted and no warning will be issued.

.SS B. LABELS DEFINED USING PATTERNS
.P
A \fIpattern\fP is a character string to be used as the \fIformat\fP argument of the C function \fBprintf()\fP. 
It should contain exactly one occurrence of "%d" (and no occurrence of other %-arguments such as "%c", "%f", etc.). If needed, the "%" character can be specified as "%%".
.P
Patterns are used to generate labels, the "%d" argument being substituted by an integer in the range [1..\fInumber\fP]. If \fInumber\fP is null, the generated set of labels is empty.
.P
For graphs requiring two lists of labels, \fIpattern1\fP defines the get-labels and \fIpattern2\fP defines the put-labels; each put-label is associated with the get-label instantiated with the same number. 

.SH EXAMPLES
.IP -
``\fBbcg_graph -fifo 2 labelfile output.bcg\fP'' will generate a graph named \fBoutput.bcg\fP modeling a 2-place FIFO buffer whose get- and put-labels are defined in \fBlabelfile\fP.
.IP -
``\fBbcg_graph -chaos -labels 4 "A%d" output.bcg\fP'' will generate a graph named \fBoutput.bcg\fP consisting of a single state and four transitions labeled \fBA1\fP through \fBA4\fP.
.IP -
``\fBbcg_graph -bag 2 -labels 3 "GET \e!%d" "PUT \e!%d" output.bcg\fP'' will generate a graph named \fBoutput.bcg\fP modeling a 2-place bag buffer whose labels are named \fBGET !1\fP, \fBPUT !1\fP, \fBGET !2\fP, \fBPUT !2\fP, \fBGET !3\fP, and \fBPUT !3\fP respectively. Note: the "\fB!\fP" characters are escaped with backslashes in order to avoid problems with csh/tcsh history substitution features.

.SH LIMITATIONS
.P
\fBbcg_graph\fP cannot generate graphs with more than 2^32 transitions (note that the number of transitions is always larger than the number of states).

.P
Moreover, if the available memory is unsufficient, \fBbcg_graph\fP might be unable to generate large graphs (even with less than 2^32 transitions).

.P
\fBbcg_graph\fP does not check if the specified labels are pairwise different.

.SH ENVIRONMENT VARIABLES
.P
See the
.BR bcg (LOCAL)
manual page for a description of the environment variables used by all
the BCG application tools.

.SH EXIT STATUS
Exit status is 0 if everything is alright, 1 otherwise.

.SH AUTHORS
Frederic Tronel, Frederic Lang, Hubert Garavel, and David Champelovier

.SH OPERANDS
.PD 0
.TP 20
.IB labelfile
Label definition file (optional input)
.TP
.IB output .bcg
BCG graph (output)
.PD

.SH FILES
.PD 0
.TP 32
.B $CADP/bin.`arch`/bcg_graph
``\fBbcg_graph\fP'' binary program
.PD
.P
See the
.BR bcg (LOCAL)
manual page for a description of the other files.

.SH SEE ALSO
.BR bcg (LOCAL),
.BR bcg_info (LOCAL)
.P
Additional information is available from the CADP Web page located at
http://cadp.inria.fr
.P
Directives for installation are given in files \fB$CADP/INSTALLATION_*\fP.
.P
Recent changes and improvements to this software are reported
and commented in file \fB$CADP/HISTORY\fP.

.SH BUGS
Please report bugs to cadp@inria.fr
