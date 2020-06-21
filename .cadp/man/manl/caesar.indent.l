.\" @(#)caesar.indent.l - VASY and CONVECS teams - 2016/03/29
.TH CAESAR.INDENT LOCAL "2016/03/29" "(C) INRIA" "CADP MANUAL PAGES"
.fp 4 CB
.lg 0
.SH NAME
caesar.indent \- LOTOS specifications pretty-printer

.SH SYNOPSIS
.B caesar.indent
.RB [ -kwuc \ |\  -keywords_in_upper_case ]
.RB [ -kwlc \ |\  -keywords_in_lower_case ]
.RB [ -kwci \ |\  -keywords_capitalised_initial ]
.RB [ -v \ |\  -verbose ]
.RB [ -nv \ |\  -noverbose ]
[\fB-ll\fP \fInum\fP | \fB-line_length\fP \fInum\fP]
.RB [ -tabs ]
.RB [ -notabs ]
[\fB-every\fP \fInum\fP]
[\fB-m\fP \fInum\fP | \fB-margin\fP \fInum\fP]
.RB [ -struct ]
.RB [ -nstruct ]
\fIfilename\fP

.SH DESCRIPTION
Taking as input \fIfilename\fP which is a file (with
suffix \fB.lotos\fP, \fB.lot\fP, or \fB.l\fP), containing a LOTOS program,
.B caesar.indent
saves \fIfilename\fP as \fIfilename\fP\fB.bak\fP checks its syntax and
pretty-prints the program in file \fIfilename\fP.  This allows to read
more easily LOTOS programs.

.SH OPTIONS

.TP
.BR -kwuc \ |\  -keywords_in_upper_case
Print all the LOTOS keywords in upper case. Not a default option.

.TP
.BR -kwlc \ |\  -keywords_in_lower_case
Print all the LOTOS keywords in lower case. This is a default option.

.TP
.BR -kwci \ |\  -keywords_capitalised_initial
Print all the LOTOS keywords with the first letter in upper-case, the others in
lower-case. Not a default option.

.TP
.BR -v \ |\  -verbose
Display progress information, in addition to errors, on the user's screen.
Opposite of \fB-noverbose\fP. Default option is \fB-noverbose\fP.

.TP
.BR -nv \ |\  -noverbose
Do not display progress information on the user's screen.
Opposite of \fB-verbose\fP. This is the default option.

.TP
\fB-ll\fP \fInum\fP | \fB-line_length\fP \fInum\fP
Set the maximum line length to \fInum\fP. The default value is 500.

.TP
.B -tabs\ \ \ \ \ \ 
Replace spaces by tabs. Not a default option.

.TP
.B -notabs\ \ \ \ \ \ 
Do not replace spaces by tabs. This is a default option.

.TP
.BI -every \ num
Set the number of spaces that make up a tabulation. The default value
is 8.

.TP
\fB-m\fP \fInum\fP | \fB-margin\fP \fInum\fP
Set the maximum length of the margin to \fInum\fP. The default value
is 460.

.TP
.B -struct\ \ \ \ \ \ 
Preserve the structure of nested blocks when cutting. This is a
default option.

.TP
.B -nstruct
Do not preserve the structure of nested blocks when cutting.  Not a
default option.


.SH EXIT STATUS
When the source is erroneous, error messages are issued.
Exit status is 0 if everything is alright, 1 otherwise.

.SH AUTHORS
Bruno Vivien (INRIA Rhone-Alpes)
.br
Adaptation by Mark Jorgensen (INRIA Rhone-Alpes)

.SH OPERANDS
.PD 0
.TP 20
.I filename
LOTOS specification (input/output)
.TP
.IB filename .bak
Backup of input (output)
.PD

.SH SEE ALSO
.BR caesar.adt (LOCAL),
.BR caesar (LOCAL),
.BR lotos (LOCAL)
.P
Additional information is available from the CADP Web page located at http://cadp.inria.fr
.P
Directives for installation are given in files
.B $CADP/INSTALLATION_*.
.P
Recent changes and improvements to this software are reported
and commented in file
.B $CADP/HISTORY.

.SH BUGS
Please report new bugs to cadp@inria.fr

