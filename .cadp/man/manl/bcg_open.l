.\" @(#)bcg_open.l - VASY and CONVECS teams - 2020/02/11
.TH BCG_OPEN LOCAL "2020/02/11" "(C) INRIA" "CADP MANUAL PAGES"
.fp 4 CB
.lg 0
.SH NAME
bcg_open \- OPEN/CAESAR connection for graphs encoded in the BCG format

.SH SYNOPSIS
.BI bcg_open \ [bcg_options]\ filename[ .bcg ]\ [cc_options]
\fIprog[\fP\fB.a\fP\fI|\fP\fB.c\fP\fI|\fP\fB.o\fP\fI]\fP
.I [prog_options]

.SH DESCRIPTION
Taking as input a BCG graph \fIfilename\fP\fB.bcg\fP and an
OPEN/CAESAR program \fIprog\fP[\fB.a\fP|\fB.c\fP|\fB.o\fP],
\fBbcg_open\fP generates an executable program \fIprog\fP performing
appropriate calls to the BCG programs and the C compiler.  Finally,
\fIprog\fP is executed.
.P
According to the principles of the OPEN/CAESAR architecture, \fIprog\fP is
obtained by combining three different modules:

.IP -
the graph module is generated from \fIfilename\fP\fB.bcg\fP
.PD 0
.IP -
the storage module is the standard OPEN/CAESAR library
.IP -
the exploration module is \fIprog\fP[\fB.a\fP|\fB.c\fP|\fB.o\fP]
.PD

.SH PROCESSING OF THE GRAPH MODULE
A dynamic library corresponding to \fIfilename\fP\fB.bcg\fP may be generated 
if necessary.

.SH PROCESSING OF THE EXPLORATION MODULE
The exploration module \fIprog\fP[\fB.a\fP|\fB.c\fP|\fB.o\fP] is
supposed to contain an OPEN/CAESAR application program, such as
\fBexhibitor\fP, \fBevaluator\fP, \fBterminator\fP...
.P
The exploration module can be supplied in three different forms. It can
be either an archive file (with \fB.a\fP suffix), or a source C program 
(with \fB.c\fP suffix) or an object code file (with \fB.o\fP suffix).
.P
If \fIprog\fP\fB.a\fP is not present in the current directory, \fBbcg_open\fP
attempts to fetch it in the OPEN/CAESAR binary library \fB$CADP/bin.`arch`\fP.
.P
If \fIprog\fP\fB.c\fP is not present in the current directory,
\fBbcg_open\fP attempts to fetch it in the OPEN/CAESAR source library
\fB$CADP/src/open_caesar\fP.
.P
If \fIprog\fP\fB.o\fP is not present in the current directory, \fBbcg_open\fP
attempts to fetch it in the OPEN/CAESAR binary library \fB$CADP/bin.`arch`\fP.
.P
If no suffix (\fB.a\fP, \fB.c\fP, \fB.o\fP) is specified on the command 
line for the exploration module \fIprog\fP, \fBbcg_open\fP will make
successive attempts to fetch this exploration module: first, as a source 
C program with \fB.c\fP suffix; then as an archive file with \fB.a\fP suffix;
finally as an object code file with suffix \fB.o\fP.

.SH DETERMINATION OF INCLUDE OR LINK MODE

Only the ``link mode'' of OPEN/CAESAR is supported by \fBbcg_open\fP.

.SH GENERAL OPTIONS
The following \fIbcg_options\fP are currently supported: 
\fB-version\fP, \fB-create\fP, \fB-update\fP, \fB-remove\fP, \fB-cc\fP, 
and \fB-tmp\fP. See the
.BR bcg (LOCAL)
manual page for a description of these options.

.SH PARTICULAR OPTIONS
The \fIcc_options\fP, if any, are passed to the C compiler.
.P
The \fIprog_options\fP, if any, are passed to \fIprog\fP.

.SH ENVIRONMENT VARIABLES

See the
.BR bcg (LOCAL)
manual page for a description of the environment variables used by all
the BCG application tools.

.SH EXIT STATUS
Exit status is 0 if everything is alright, 1 otherwise.

.SH AUTHORS
Renaud Ruffiot and Hubert Garavel

.SH OPERANDS
.PD 0
.TP 17
.IB filename .bcg
BCG graph (input)
.TP
.IB filename@1 .o
dynamic library (input or output)
.TP
.IB prog .a\ \ \ \ \ \ 
exploration module (archive, input)
.TP
.IB prog .c\ \ \ \ \ \ 
exploration module (source, input)
.TP
.IB prog .o\ \ \ \ \ \ 
exploration module (object code, input)
.TP
.IB prog\ \ \ \ \ \ \ 
executable program (output)
.PD

.SH FILES
.PD 0
.TP 30
.B $CADP/com/bcg_open
``\fBbcg_open\fP'' shell script
.TP
.B $CADP/bin.`arch`/libbcg_open.a
``bcg_open'' static library
.TP
.B $CADP/incl/caesar_*.h
OPEN/CAESAR interfaces
.TP
.B $CADP/bin.`arch`/libcaesar.a
OPEN/CAESAR library
.TP
.B $CADP/src/open_caesar/*.c
exploration modules (source)
.TP
.B $CADP/bin.`arch`/*.a
exploration modules (archive)
.TP
.B $CADP/bin.`arch`/*.o
exploration modules (object code)
.PD
.P
See the
.BR bcg (LOCAL)
manual page bcg for a description of the other files).

.SH SEE ALSO
.BR bcg (LOCAL),
.BR lotos.open (LOCAL)

.P
Additional information is available from the CADP Web page located at http://cadp.inria.fr
.P
Directives for installation are given in files \fB$CADP/INSTALLATION_*\fP.

.P
Recent changes and improvements to this software are reported
and commented in file \fB$CADP/HISTORY\fP.

.SH BUGS
Please report bugs to Hubert.Garavel@inria.fr

