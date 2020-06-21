'\" t

.TH FSP.OPEN LOCAL "2019/01/13" "(C) INRIA" "CADP MANUAL PAGES"
.fp 4 CB
.lg 0

.cs 4 23

.SH NAME
fsp.open \- OPEN/CAESAR connection for the FSP language

.SH SYNOPSIS
.BR fsp.open
[\fB-root\fP \fIroot-process\fP]
[\fB-silent\fP | \fB-verbose\fP]
[\fB-version\fP]
[\fIexp_options\fP]
\fIfilename\fP[\fB.lts\fP]
.RI [ cc_options ]
\fIprog\fP[\fB.a\fP|\fB.c\fP|\fB.o\fP]
.RI [ prog_options ]

.SH DESCRIPTION
Taking as input
.IB filename .lts
(which describes a  process in the FSP language of Magee & Kramer, Imperial
College, London) and an OPEN/CAESAR program
\fIprog\fP[\fB.a\fP|\fB.c\fP|\fB.o\fP], \fBfsp.open\fP operates as follows:
.IP -
First, it translates
.IB filename .lts
into an EXP.OPEN network of automata
.IB filename .exp,
using
.BR fsp2lotos (LOCAL)
and
.BR svl (LOCAL).
See
.BR fsp2lotos (LOCAL)
for more  information.
.IP -
Second, it calls ``\fBexp.open\fP
.IB filename .exp
.RI [ cc_options ]
\fIprog\fP[\fB.a\fP|\fB.c\fP|\fB.o\fP]
[\fIprog_options\fP]'', passing to \fBexp.open\fP appropriate options that depend on the options passed to \fBfsp.open\fP (see below). See
.BR exp.open (LOCAL)
for more information.
.br
However, if \fIprog\fP is the "-" string (instead of the name of an OPEN/CAESAR application program), \fBfsp.open\fP will execute only the first step (translation into an EXP.OPEN network of automata) and then stop without invoking \fBexp.open\fP.
In such case, the files generated during the first step are not removed, thus allowing the generated EXP.OPEN network of automata to be used for other purpose than OPEN/CAESAR.

.SH OPTIONS
.TP
.B -root \fIroot-process\fP
Use the process root-process as the main process. 
This option is passed to
.BR fsp2lotos (LOCAL).
See
.BR fsp2lotos (LOCAL)
for more information.
.TP
.B -silent
Execute silently.
This option is passed to
.BR exp.open (LOCAL)
and
.BR svl (LOCAL).
See 
.BR exp.open (LOCAL)
and
.BR svl (LOCAL)
for more information.
.TP
.B -verbose
Report activities and progress, including errors and messages emitted by auxiliary tools, to the user's screen.
This option is passed to
.BR exp.open (LOCAL)
and
.BR svl (LOCAL).
See 
.BR exp.open (LOCAL)
and
.BR svl (LOCAL)
for more information.
.TP
.B -version
Display the version number of
.BR fsp2lotos (LOCAL)
and stop.

.TP
.I exp_options
if any, are passed to
.BR exp.open (LOCAL).
.TP
.I cc_options
if any, are passed to the C compiler.
.TP
.I prog_options
if any, are passed to \fIprog\fP.

.SH OPERANDS
.PD 0
.TP 20
.IB filename .lts
FSP specification (input)
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
.BI $CADP_TMP/fsp.*
temporary files
.TP
.BI $CADP/lib/FSP_V1.lib
FSP predefined library (LOTOS code)
.TP
.BI $CADP/incl/FSP_V1.h 
FSP predefined library (C code)

.SH EXIT STATUS
When the source is erroneous, error messages are issued.
Exit status is 0 if everything is alright, 1 otherwise.

.SH AUTHORS
.P
Remi Herilier and Frederic Lang (INRIA Rhone-Alpes).

.SH SEE ALSO
.P
.BR exp (LOCAL),
.BR exp.open (LOCAL),
.BR fsp2lotos (LOCAL),
.BR lotos (LOCAL),
.BR svl (LOCAL),
.BR svl-lang (LOCAL)

.P
Additional information is available from the CADP Web page located at http://cadp.inria.fr
.P
Directives for installation are given in files
.B $CADP/INSTALLATION_*.
.P
Recent changes and improvements to this software are reported and
commented in file
.B $CADP/HISTORY.

.SH BUGS
.P
Please report any bug to cadp@inria.fr
