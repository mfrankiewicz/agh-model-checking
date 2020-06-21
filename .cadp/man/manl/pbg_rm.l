.\" @(#)pbg_rm.l - VASY and CONVECS teams - 2015/11/26
.TH PBG_RM LOCAL "2015/11/26" "(C) INRIA" "CADP MANUAL PAGES"
.fp 4 CB
.lg 0
.SH NAME

pbg_rm \- remove a partitioned BCG graph

.SH SYNOPSIS
.B pbg_rm
.IB filename [.pbg]

.SH DESCRIPTION

.B pbg_rm 
removes 
.IB filename .pbg, 
which is a partitioned BCG graph encoded in the PBG format. It also
removes all the BCG fragments and log fragments referred to in
.IB filename .pbg
(these fragments being stored either on the local machine or on remote
machines).

.P
The grid configuration file referred to in
.IB filename .pbg
is not removed, as this file may be used by other PBG files than
.IB filename .pbg.

.P
The difference between
.B pbg_rm
and the UNIX command
.B rm
is that
.B pbg_rm
does a "deep" removal, whereas
.B rm
does a "shallow" removal (only
.IB filename .pbg
is removed, but not its associated fragments).

.P
Refer to the
.BR gcf (LOCAL)
and
.BR pbg (LOCAL)
manual pages for details about the GCF and PBG formats.

.SH EXIT STATUS

Exit status is 0 if everything is alright, 1 otherwise.

.SH AUTHORS

An early prototype was written by Jerome Fereyre and Hubert Garavel.
The current version was developed by Wendelin Serwe and Hubert Garavel
(INRIA Rhone-Alpes).

.SH OPERANDS
.PD 0
.TP 14
.IB filename .pbg
partitioned BCG graph (input)
.PD

.SH FILES

The binary code of \fBpbg_rm\fP is available in
$CADP/bin.`arch`/pbg_rm.

.SH SEE ALSO

.BR bcg (LOCAL),
.BR gcf (LOCAL),
.BR pbg (LOCAL),
.BR bcg_merge (LOCAL),
.BR distributor (LOCAL),
.BR pbg_cp (LOCAL),
.BR pbg_info (LOCAL),
.BR pbg_mv (LOCAL),
.BR pbg_open (LOCAL)

.P
Additional information is available from the CADP Web page located at
http://cadp.inria.fr

.P
Directives for installation are given in files \fB$CADP/INSTALLATION_*\fP.

.P
Recent changes and improvements to this software are reported
and commented in file \fB$CADP/HISTORY\fP.

.SH BUGS

.B pbg_rm
was not designed to ensure atomic transactions. If an error occurs while 
removing certain fragments, other fragments might nevertheless be removed.
In such case, error messages will be displayed on the standard output, and
.IB filename .pbg 
will in general be no longer usable after invoking
.B pbg_rm.

.P
Please report other bugs to cadp@inria.fr

