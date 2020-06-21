.\" @(#)pbg_info.l - VASY and CONVECS teams - 2015/11/26
.TH PBG_INFO LOCAL "2015/11/26" "(C) INRIA" "CADP MANUAL PAGES"
.fp 4 CB
.lg 0
.SH NAME

pbg_info \- display information about a partitioned BCG graph

.SH SYNOPSIS
.B pbg_info
[
.B \-check
] 
[
.B \-labels
]
[
.B \-log
]
[
.B \-size
]
.IB filename [.pbg]

.SH DESCRIPTION

.B pbg_info
takes as input the partioned BCG graph 
.IB filename .pbg,
encoded in the PBG format and, depending on the option given on the 
command-line, displays various information about
.IB filename .pbg.

.P
Refer to the
.BR gcf (LOCAL)
and
.BR pbg (LOCAL)
manual pages for details about the GCF and PBG formats.

.SH OPTIONS

.TP
.B \-check
Check whether 
.IB filename .pbg
is consistent, i.e. whether all local and remote files referred to in
.IB filename .pbg
exist and are readable.

.TP
.B \-labels\ \ \ 
Display the number of labels followed by the list of labels present in
.IB filename .pbg.

.TP
.B \-log\ \ \ 
Display the concatenation of all the log fragments referred to in
.IB filename .pbg
(these fragments generally are stored on remote machines).

.TP
.B \-size\ \ \ 
Print the total number of states and transitions of the labelled transition
system described by
.IB filename .pbg. 

.SH EXIT STATUS

Exit status is 0 if everything is alright, 1 otherwise.

.SH AUTHORS

Hubert Garavel and Wendelin Serwe (INRIA Rhone-Alpes).

.SH OPERANDS
.PD 0
.TP 14
.IB filename .pbg
partitioned BCG graph (input)
.PD

.SH FILES

The binary code of \fBpbg_info\fP is available in
$CADP/bin.`arch`/pbg_info.

.SH SEE ALSO

.BR bcg (LOCAL),
.BR gcf (LOCAL),
.BR pbg (LOCAL),
.BR bcg_merge (LOCAL),
.BR distributor (LOCAL),
.BR pbg_cp (LOCAL),
.BR pbg_mv (LOCAL),
.BR pbg_open (LOCAL),
.BR pbg_rm (LOCAL)

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
