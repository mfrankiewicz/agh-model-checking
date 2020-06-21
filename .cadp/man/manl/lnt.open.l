.\" @(#)lnt.open.l - VASY and CONVECS teams - 2020/02/12
.TH LNT.OPEN LOCAL "2020/02/12" "(C) INRIA" "CADP MANUAL PAGES"
.fp 4 CB
.lg 0

.cs 4 23

.SH NAME
lnt.open \- OPEN/CAESAR connection for the LNT language

.SH SYNOPSIS
.BR lnt.open
[\fB-depend\fP]
[\fB-force\fP]
[\fB-root\fP \fIroot-process\fP]
[\fB-silent\fP | \fB-verbose\fP] 
[\fB-version\fP]
.RI [ lotos_options ]
\fIfilename\fP[\fB.lnt\fP]
.RI [ cc_options ]
\fIprog\fP[\fB.a\fP|\fB.c\fP|\fB.o\fP]
.RI [ prog_options ]

.SH DESCRIPTION
Taking as input
.IB filename .lnt
(which contains the principal module of a LNT specification) and an OPEN/CAESAR program
\fIprog\fP[\fB.a\fP|\fB.c\fP|\fB.o\fP],
\fBlnt.open\fP operates as follows:
.IP -
First, it pre\-processes 
.IB filename .lnt
and all transitively imported modules using
.BR lpp (LOCAL).
See
.BR lpp (LOCAL)
for more information.
.IP -
Second, it translates the pre\-processed LNT specification
.IB filename .lnt
(including all transitively imported modules) into a LOTOS specification
using 
.BR lnt2lotos (LOCAL).
See
.BR lnt2lotos (LOCAL)
for more  information.
.IP -
Third, it calls ``\fBlotos.open\fP
.IB filename .lotos
.RI [ cc_options ]
\fIprog\fP[\fB.a\fP|\fB.c\fP|\fB.o\fP]
[\fIprog_options\fP]'', passing to \fBlotos.open\fP (and, transitively, \fPcaesar.adt\fP and \fPcaesar\fP) appropriate options that depend on the options passed to \fBlnt.open\fP (see below). See
.BR lotos.open (LOCAL),
.BR caesar.adt (LOCAL),
and
.BR caesar (LOCAL)
for more information.
.br
\ 
.br
However, if \fIprog\fP is the "-" string (instead of the name of an OPEN/CAESAR application program), \fBlnt.open\fP will execute only the first two steps (pre\-processing and translation into a LOTOS specification) and then stop without invoking \fBlotos.open\fP. In such case, the files generated during the first two steps are not removed, thus allowing the generated LOTOS specification to be used for other purposes than OPEN/CAESAR (e.g., for rapid prototying with EXEC/CAESAR).

.SH OPTIONS
.TP
.B \-depend
List all the LNT files transitively included in \fIfilename\fP\fB.lnt\fP and
exit. Not a default option.
.TP
.B -force
Overwrite output files, even if they were edited by the user or do not need to be updated.
This option is passed to
.BR lpp (LOCAL),
.BR lnt2lotos (LOCAL),
and
.BR lotos.open (LOCAL).
See
.BR lpp (LOCAL),
.BR lnt2lotos (LOCAL),
and
.BR lotos.open (LOCAL)
for more information.
.TP
.BI \-root \ process-instantiation
Use the process \fIprocess-instantiation\fP as the main process. It is an error if the LNT specification does not contain a corresponding process definition.
This option is passed to
.BR lnt2lotos (LOCAL).
See
.BR lnt2lotos (LOCAL)
for more information.
.TP
.B -silent
Execute silently.
This option is passed to
.BR lpp (LOCAL),
.BR lnt2lotos (LOCAL),
and
.BR lotos.open (LOCAL).
See
.BR lpp (LOCAL),
.BR lnt2lotos (LOCAL),
and
.BR lotos.open (LOCAL)
for more information.
.TP
.B -verbose
Report in detail activities and progress, including errors and messages emitted by auxiliary tools, to the user's screen.
This option is passed to
.BR lpp (LOCAL),
.BR lnt2lotos (LOCAL),
and
.BR lotos.open (LOCAL).
See
.BR lpp (LOCAL),
.BR lnt2lotos (LOCAL),
and
.BR lotos.open (LOCAL)
for more information.
.TP
.B -version
Display the version number of 
.BR lnt2lotos (LOCAL)
and stop.

.TP
.I lotos_options
if any, are passed to
.BR lotos.open (LOCAL).
.TP
.I cc_options
if any, are passed to the C compiler.
.TP
.I prog_options
if any, are passed to \fIprog\fP.

.SH OPERANDS
.PD 0
.TP 20
.IB filename .lnt
LNT specification (input)
.TP
.IB filename .tnt
C code for data types (source, input)
.TP
.IB filename .fnt
C code for functions (source, input)
.TP
.IB filename .o
object code (output)
.TP
.IB filename .err
detailed error messages (output)
.TP
.IB prog .a
exploration module (archive, input)
.TP
.IB prog .c
exploration module (source, input)
.TP
.IB prog .o
exploration module (object code, input)
.TP
.I prog
executable program (output)

.SH FILES
.PD 0
.TP 20
.B $CADP_TMP/lnt.*
temporary files
.TP
.B $CADP/lib/LNT_V1.lib
LNT predefined library (LOTOS code)
.TP
.B $CADP/incl/LNT_V1.h 
LNT predefined library (C code)

.SH EXIT STATUS
When the source is erroneous, error messages are issued.
Exit status is 0 if everything is alright, 1 otherwise.

.SH AUTHORS
.P
Hubert Garavel, Wendelin Serwe, and Gideon Smeding (INRIA Rhone-Alpes).

.SH SEE ALSO
.BR caesar (LOCAL),
.BR caesar.adt (LOCAL),
.BR lotos (LOCAL),
.BR lotos.open (LOCAL),
.BR lnt2lotos (LOCAL),
.BR lpp (LOCAL),
and the "Reference Manual of the LNT to LOTOS Translator" available from
http://cadp.inria.fr/publications/Champelovier-Clerc-Garavel-et-al-10.html

.P
Additional information is available from the CADP Web page located at
http://cadp.inria.fr
.P
Directives for installation are given in files \fB$CADP/INSTALLATION_*\fP.
.P
Recent changes and improvements to this software are reported
and commented in file \fB$CADP/HISTORY\fP.

.SH BUGS
.P
Please report any bug to cadp@inria.fr
