.\" @(#)bcg_lib.l - VASY and CONVECS teams - 2013/09/09
.TH BCG_LIB LOCAL "2013/09/09" "(C) INRIA" "CADP MANUAL PAGES"
.fp 4 CB
.lg 0
.SH NAME
bcg_lib \- generate dynamic libraries for graphs encoded in the BCG format

.SH SYNOPSIS

.BI bcg_lib \ [bcg_options]\ [ -n \ integer]\ [ -c ]
.IB [ -h ]\ filename[ .bcg ]

.SH DESCRIPTION
This command takes as input the BCG graph \fIfilename\fP\fB.bcg\fP and
generates the corresponding library, which is contained in file
\fIfilename\fP\fB@integer.o\fP. This command is not supposed to be invoked
directly by end-users.

.SH GENERAL OPTIONS
The following \fIbcg_options\fP are currently supported: 
\fB-version\fP, \fB-create\fP, \fB-update\fP, \fB-cc\fP, and \fB-tmp\fP.  
See the
.BR bcg (LOCAL)
manual page for a description of these options.

.SH PARTICULAR OPTIONS
The following options are also suported:

.TP
.BI \-n \ integer
Determine the number of the dynamic library to be generated. By default
\fIinteger\fP is equal to 1.
.TP
.B \-c\ \ \ \ \ \ 
Do not generate the dynamic library, but display instead its
source code on the standard output. Debugging option, not available 
in official releases of CADP.
.TP
.B \-h\ \ \ \ \ \ 
Do not generate the dynamic library, but generate instead its 
interface, the generic include file \fBbcg_dynamic_lib_integer.h\fP. 
Debugging option, not available in official releases of CADP.

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
.TP 30
.IB filename .bcg
BCG graph (input)
.TP
.IB filename @integer.o
dynamic library (output)
.PD

.SH FILES
.PD 0
.TP 30
.B bcg_dynamic_lib_integer.h
dynamic library interface (output)
.TP
.B $CADP/bin.`arch`/bcg_lib
``\fBbcg_lib\fP'' binary program
.PD
.P
See the
.BR bcg (LOCAL)
manual page for a description of the other files).

.SH SEE ALSO
.BR bcg (LOCAL)
.P
Additional information is available from the CADP Web page located at http://cadp.inria.fr
.P
Directives for installation are given in files \fB$CADP/INSTALLATION_*\fP.
.P
Recent changes and improvements to this software are reported
and commented in file \fB$CADP/HISTORY\fP.

.SH BUGS
Please report bugs to Hubert.Garavel@inria.fr

