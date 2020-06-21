.\" @(#)pbg_cp.l - VASY and CONVECS teams - 2015/11/26
.TH PBG_CP LOCAL "2015/11/26" "(C) INRIA" "CADP MANUAL PAGES"
.fp 4 CB
.lg 0
.SH NAME

pbg_cp \- copy a partitioned BCG graph

.SH SYNOPSIS
.B pbg_cp 
[
.B \-i
]
.IB source [.pbg] \ target [.pbg]

.SH DESCRIPTION

.B pbg_cp 
copies 
.IB source .pbg,
which is a partitioned BCG graph encoded in the PBG format, into
.IB target .pbg.
Both names
.IB source .pbg
and
.IB target .pbg
must not designate the same file. If
.IB target .pbg
already exists, it is removed first, as well as all the BCG 
fragments and log fragments referred to in 
.IB target .pbg
(these fragments being stored either on the local machine or on 
remote machines); however, the grid configuration file referred to in
.IB target .pbg
is not removed, as this file may be used by other PBG files than
.IB target .pbg.

.P
The difference between
.B pbg_cp
and the UNIX command
.B cp
is that
.B pbg_cp
does a "deep" copy, whereas
.B cp
does a "shallow" copy (only
.IB source .pbg
is copied and only
.IB target .pbg
is removed if it exists already, but their associated fragments are kept
unchanged).

.P
Refer to the
.BR gcf (LOCAL)
and
.BR pbg (LOCAL)
manual pages for details about the GCF and PBG formats.

.SH OPTIONS

.TP
.B \-i\ \ \ \ \ 
Prompt for overwrite confirmation whenever
.IB target .pbg
already exists.
Any answer starting with 'y' or 'Y' means that the copy should proceed.
Any other answer prevents overwriting to take place.

.SH EXIT STATUS

Exit status is 0 if everything is alright, 1 otherwise.

.SH AUTHORS

An early prototype was written by Jerome Fereyre and Hubert Garavel.
The current version was developed by Wendelin Serwe and Hubert Garavel
(INRIA Rhone-Alpes).

.SH OPERANDS
.PD 0
.TP 14
.IB source .pbg
partitioned BCG graph (input)
.TP
.IB target .pbg
resulting partitioned BCG graph (output)
.PD

.SH FILES

The binary code of \fBpbg_cp\fP is available in
$CADP/bin.`arch`/pbg_cp.

.SH SEE ALSO

.BR bcg (LOCAL),
.BR gcf (LOCAL),
.BR pbg (LOCAL),
.BR bcg_merge (LOCAL),
.BR distributor (LOCAL),
.BR pbg_info (LOCAL),
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

.B pbg_cp
was not designed to ensure atomic transactions. If an error occurs while
copying certain fragments,
.B pbg_cp
will abort the copy and try to remove all fragments already copied. However,
if
.IB target .pbg
already existed, its removal and the removal of its fragments cannot be undone.

.P
Please report other bugs to cadp@inria.fr
