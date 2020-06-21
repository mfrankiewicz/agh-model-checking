.\" @(#)bcg_merge.l - VASY and CONVECS teams - 2018/05/17
.TH BCG_MERGE LOCAL "2018/05/17" "(C) INRIA" "CADP MANUAL PAGES"
.fp 4 CB
.lg 0
.SH NAME
bcg_merge \- translation of a partitioned BCG graph into one single BCG graph

.SH SYNOPSIS
.B bcg_merge
[\fIoptions\fP]
.IB input [.pbg]
[\fIoutput\fP[\fB.bcg\fP]]
.RI [ global_opt ]
.RI [ instance_opt ]

.SH DESCRIPTION

\fBbcg_merge\fP is usually invoked after the
.BR distributor (LOCAL)
tool of
.B CADP
for distributed state-space generation.

.P
\fBbcg_merge\fP takes as input a partitioned BCG graph
.IB input [.pbg],
usually produced by 
.BR distributor (LOCAL)
and encoded in the PBG format (see the
.BR pbg (LOCAL)
manual page for details about the PBG format), and produces one single BCG file
.IB output [.bcg]
that combines the various graph fragments listed in
.IB input [.pbg].

.P
If
.IB output [.bcg]
is not specified on the command line, the output file will be named
\fIinput\fP\fB.bcg\fP.

.P
These graph fragments are themselves encoded as BCG files and usually located
on different machines. The list of these machines is given in a grid 
configuration file (see the
.BR gcf (LOCAL)
manual page for details about the GCF format) referenced in
.IB input [.pbg].

.P
\fBbcg_merge\fP renumbers the states contained in the BCG files listed
in the input PBG file, in such a way that the states of the output BCG file
are assigned contiguous numbers and that the initial state is assigned 
number 0.

.SH OPTIONS

The following \fIoptions\fP are currently supported:

.TP
.B -compress, -register, -short, -medium, -size, -uncompress
These options control the form under which the BCG graph \fIoutput\fP\fB.bcg\fP
is generated. See the
.BR bcg (LOCAL)
manual page for a description of these options.

.TP
.B \-clean
After generating the output BCG file, erase the input PBG file together
with its BCG graph fragments and their corresponding BCG dynamic libraries.
Not a default option.

.TP
.B \-fast
When building
.IB output [.bcg],
sort, by increasing source state numbers only, the transitions belonging to
the file fragments listed in
.IB input [.pbg].
This is a faster sort than the default one, which sorts transitions 
lexicographically, by increasing source state numbers, then by increasing
target state numbers; however, this faster sort may generate a larger BCG
file than the lexicographic sort. Not a default option.

.TP
.B \-monitor
Open a window for monitoring in real-time the generation of the BCG file
\fIoutput\fP\fB.bcg\fP. Not a default option.

.TP
.BI \-parse\ |\ -unparse
These options can be used to control label parsing in the output BCG graph
(see the
.BR bcg_write (LOCAL)
manual page for a technical discussion about label parsing).
By default, or if option \fB-parse\fP is present, label parsing is enabled.
If option \fB-unparse\fP is present, label parsing is disabled.

.TP
.B \-stat
Display various statistics obtained during graph merging, such as the number
of cross-border transitions in the partitioned BCG graph, and the network
traffic with the remote machines. Not a default option.

.TP
.B -tmp
This option specifies the directory in which temporary files are to
be stored. See the
.BR bcg (LOCAL)
manual page for a description of this option.

.P
Finally, the list of options \fIglobal_opt\fP and \fIinstance_opt\fP can 
be used for last-minute changes to the settings of the grid configuration 
file referenced in
.IB input [.pbg].
See the
.BR distributor (LOCAL)
manual page for a description of these options.

.SH ENVIRONMENT VARIABLES
See the
.BR bcg (LOCAL)
manual page for a description of the environment variables used by all
BCG application tools.

.SH EXIT STATUS
Exit status is 0 if everything is alright, 1 otherwise.

.SH AUTHORS
Version 1.0 of \fBbcg_merge\fP was developed by Irina Smarandache-Sturm
(INRIA/VASY) in 2000. 
.P
Version 2.0 of \fBbcg_merge\fP was developed by Radu Mateescu (INRIA/VASY) 
in 2001. 
.P
Version 3.0 of \fBbcg_merge\fP was developed by Nicolas Descoubes (INRIA/VASY)
in 2003, then revised by Damien Bergamini and Hubert Garavel (both at
INRIA/VASY) in 2004. 

.SH OPERANDS
.PD 0
.TP 14
.IB input .pbg
partitioned BCG graph (input)
.TP
.IB output .bcg
resulting BCG file after merging (output)
.PD

.SH FILES

The binary code of \fBbcg_merge\fP is available in
$CADP/bin.`arch`/bcg_merge.

.P
During the execution of \fBbcg_merge\fP, dynamic libraries corresponding
to the BCG files (i.e., the graph fragments) listed in the input PBG file 
may be generated if necessary, and stored on the remote machines.

.SH SEE ALSO
.BR bcg (LOCAL),
.BR gcf (LOCAL),
.BR pbg (LOCAL),
.BR distributor (LOCAL),
.BR pbg_cp (LOCAL),
.BR pbg_info (LOCAL),
.BR pbg_mv (LOCAL),
.BR pbg_rm (LOCAL)

.P
Additional information is available from the CADP Web page located at
http://cadp.inria.fr
.P
Directives for installation are given in files
.B $CADP/INSTALLATION_*.
.P
Recent changes and improvements to this software are reported
and commented in file
.B $CADP/HISTORY.

.SH BUGS

Please report bugs to cadp@inria.fr

.SH BIBLIOGRAPHY

[GMS01] Hubert Garavel, Radu Mateescu, and Irina Smarandache.
Parallel State Space Construction for Model-Checking.
In Matthew B. Dwyer, ed, Proceedings of the 8th International SPIN Workshop
on Model Checking of Software (SPIN'01), Toronto, Canada, LNCS 2057, pp.
217-234, May 2001. Revised version available as INRIA Research Report RR-4341,
December 2001. Available from
http://cadp.inria.fr/publications/Garavel-Mateescu-Smarandache-01.html

.P
[GMB+06] Hubert Garavel, Radu Mateescu, Damien Bergamini, Adrian Curic,
Nicolas Descoubes, Christophe Joubert, Irina Smarandache-Sturm, and
Gilles Stragier.
DISTRIBUTOR and BCG_MERGE: Tools for Distributed Explicit State Space
Generation.
In Holger Hermanns and Jens Palberg, eds., Proceedings of the 12th
International Conference on Tools and Algorithms for the Construction and
Analysis of Systems (TACAS'06), Vienna, Austria, LNCS 3920, pp. 445-449,
March-April 2006. Available from
http://cadp.inria.fr/publications/Garavel-Mateescu-Bergamini-et-al-06.html

.P
[GMS12] Hubert Garavel, Radu Mateescu, and Wendelin Serwe.
Large-scale Distributed Verification using CADP: Beyond Clusters to Grids.
Electronic Notes in Theoretical Computer Science, vol. 296, pp. 145-161,
August 2012. Available from
http://cadp.inria.fr/publications/Garavel-Mateescu-Serwe-12.html

