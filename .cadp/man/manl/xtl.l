'\" t
.\" @(#)xtl.l - VASY and CONVECS teams - 2018/07/06
.TH XTL LOCAL "2018/07/06" "(C) INRIA" "CADP MANUAL PAGES"
.fp 4 CB
.lg 0
.SH NAME
xtl \- evaluation of value-based temporal logic formulas

.SH SYNOPSIS
.B xtl
[
.BI -cc \ options
]
.RB [ -create ]
.RB [ -depend ]
.RB [ -english ]
.RB [ -expand ]
.RB [ -french ]
.RB [ -remove ]
.RB [ -silent ]
[
.BI -source \ file:line
]
[
.BI -tmp \ directory
]
.RB [ -update ]
.RB [ -verbose ]
.RB [ -version ]
.RB [ -warning ]
\fIfile1\fP[\fB.xtl\fP]
\fIfile2\fP[\fB.bcg\fP]

.SH DESCRIPTION
xtl takes as input \fIfile1\fP[\fB.xtl\fP], which is a program written
in XTL (eXecutable Temporal Language), and evaluates it
on \fIfile2\fP[\fB.bcg\fP], which contains an LTS (Labelled Transition
System) encoded in the BCG (Binary Coded Graph) format.
.sp
The XTL tool offers the following features:

.IP -
XTL supports several temporal logics widely used. Currently,
the following temporal logics are supported: HML, CTL, ACTL,
LTAC, as well as the modal mu-calculus. All of them can be 
directly used by end-users to verify properties on BCG 
graphs.

.IP -
Compared to other model-checkers, XTL is more expressive,
because it allows to handle the data values contained in 
states and transition labels. These values can be used in
temporal formulas, assigned to variables, etc.

.IP -
Moreover, XTL is extensible. A user can define his/her own
temporal logic, as a library of operators written in XTL.
This is the way in which the currently available formalisms
(HML, CTL, ACTL, LTAC and modal mu-calculus) are implemented.

.P
A detailed description of the XTL language is available in the
.BR xtl-lang (LOCAL)
manual page.

.SH OPTIONS

.TP
.BI -cc \ options
Pass \fIoptions\fP to the C compiler when it is invoked. \fIoptions\fP is
a list of compiler options (enclosed in quotes or double quotes). These
options are appended to the compiler options, if any, contained in the
\fB$CADP_CC\fP environment variable (see ENVIRONMENT VARIABLES below).
Not a default option.

.TP
.B -create\ \ \ \ \ \ 
Force the dynamic library of file \fIfile2\fP[\fB.bcg\fP] to be created,
even if it already exists in the current directory and if it is
up-to-date. Not a default option.

.TP
.B -depend
Display the list of library files included (directly or transitively)
in the file \fIfile1\fP[\fB.xtl\fP] and stop. This list may be incomplete
if the XTL program is syntactically incorrect. If present, this option
has precedence over all the other options. Not a default option.

.TP
.B -english
Print messages in English. Opposite of \fB-french\fP. This option
overrides the \fB$CADP_LANGUAGE\fP environment variable (see
ENVIRONMENT VARIABLES below).

.TP
.B -expand
Expand the macro definitions and the XTL source files included as
libraries in the file \fIfile1\fP[\fB.xtl\fP], producing as output a
file \fIfile1\fP\fB.xp\fP, and stop. This option may be useful for
debugging purposes. Not a default option.

.TP
.B -french
Print messages in French. Opposite of \fB-english\fP. This option
overrides the \fB$CADP_LANGUAGE\fP environment variable (see
ENVIRONMENT VARIABLES below).

.TP
.B -remove
Remove the dynamic library of file \fIfile2\fP[\fB.bcg\fP] after usage.
Not a default option.

.TP
.B -silent\ \ \ \ \ \ 
Execute silently. Opposite of \fB-verbose\fP. Default option is \fB-verbose\fP.

.TP
.BI -source \ file:line
Change the file name and line number displayed in error messages
as if the XTL program was contained in file \fIfile\fP starting at
line \fIline\fP (instead of starting at line 1 in file
\fIfile1\fP[\fB.xtl\fP]).
This option has effect only on the messages triggered by the errors
occurring in the top-level file \fIfile1\fP[\fB.xtl\fP]. The messages
triggered by the errors occurring in the included libraries
(if any) are left unchanged.

.TP
.BI -tmp \ directory
Use \fIdirectory\fP to store the temporary files. This option overrides
the environment variable \fB$CADP_TMP\fP (see ENVIRONMENT VARIABLES below).
Not a default option.

.TP
.B -update\ \ \ \ \ \ 
Do not create the dynamic library of file \fIfile2\fP[\fB.bcg\fP] if it
already exists in the current directory and if it is up-to-date.
Default option.

.TP
.B -verbose
Animate the user's screen, telling what is going on. Opposite of \fB-silent\fP.
Default option.

.TP
.B -version
Display the current version number of the XTL tool and stop.
To be effective, this option should occur as the first argument
on the command line. Subsequent options and/or arguments, if any,
will be discarded.

.TP
.B -warning
Print extra warning messages. Not a default option.

.SH ENVIRONMENT VARIABLES
The following environment variables are used:

.TP
.B $CADP, $CADP_LANGUAGE, $CADP_CC, $CADP_TMP
The meaning of these variables is defined in the
.B $CADP/INSTALLATION_2
file.

.TP
.B $XTL\ \ \ \ \ \ 
If this variable is set, its value should reference the directory in which
the XTL package in installed. By default, this variable is supposed to be
unset: the XTL package is normally installed in the directory referenced
by the environment variable \fB$CADP\fP. Setting the \fB$XTL\fP variable
should be avoided in official distributions of the XTL package, since it
may cause problems.

.SH EXIT STATUS
Exit status is 0 if everything is alright, 1 otherwise.

.SH DIAGNOSTICS
When the source XTL file \fIfile1\fP[\fB.xtl\fP] is erroneous, error
messages are issued.

.SH AUTHOR
Radu Mateescu (INRIA Rhone-Alpes / VASY)

.SH OPERANDS
.PD 0
.TP 25
.IB filename .xtl
XTL source program (input)
.TP
.IB filename .bcg
LTS in BCG format (input)
.TP
.IB filename .xp
XTL expanded program (output)
.PD

.SH FILES
.PD 0
.TP 25
.IB filename .o
object file (temporary)
.TP
.IB filename @1.o
dynamic BCG library (auxiliary)
.TP
.B $CADP/LICENSE
license file
.TP
.B $CADP/src/com/cadp_cc
C compiler shell
.TP
.B $CADP/src/xtl/*.xtl
predefined XTL library (input)
.TP
.B $CADP_TMP/xtl_*.c
intermediate C code (temporary)
.TP
.B $CADP_TMP/xtl_*.x
binary code (temporary)
.PD

.SH SEE ALSO
.BR bcg (LOCAL),
.BR bcg_io (LOCAL),
.BR xtl (LOCAL).
.P
Additional information is available from the CADP Web page located at http://cadp.inria.fr
.P
Directives for installation are given in files \fB$CADP/INSTALLATION_*\fP.
.P
Recent changes and improvements to this software are reported
and commented in file \fB$CADP/HISTORY\fP.

.SH BUGS
Please report bugs to Radu.Mateescu@inria.fr

