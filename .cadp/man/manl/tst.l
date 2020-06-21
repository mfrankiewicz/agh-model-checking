.\" @(#)tst.l - VASY and CONVECS teams - 2013/09/09
.TH TST LOCAL "2013/09/09" "(C) INRIA" "CADP MANUAL PAGES"
.fp 4 CB
.lg 0
.SH NAME
tst \- CADP installation and configuration auto-test facility

.SH SYNOPSIS
.B tst
.RI [ arch ]

.SH DESCRIPTION
This program checks the way CADP is installed and configured on the current
machine in order to detect potential problems. Many verifications are 
performed, most of which derived from common problems reported by CADP users.

.P
This program should be run after every installation or upgrade of CADP,
as well as every time a problem occurs (especially when reporting a bug
to the developers of CADP).

.SH OPTIONS

.P
Depending on the optional parameter \fIarch\fP, 
.B tst
has two different usages.

.P
If
.I arch
is absent, then 
.B tst
will check the current machine on which CADP is installed. In such case, the
environment variable 
.B $CADP
should point to the directory in which CADP is installed.

.P
If 
.I arch
is present, then
.B tst
will check the current machine on which CADP is supposed not to be installed
yet. In such case, \fIarch\fP should be equal to the name of the architecture 
of the current machine, for instance "sun4", "sun5", "iX86", "win32"... 
The list of architecture names supported by CADP is defined in file
.B $CADP/INSTALLATION_2.

.SH EXIT STATUS
Exit status is 0 if everything is alright, 1 otherwise.

.SH AUTHOR
Hubert Garavel (INRIA Rhone-Alpes)

.SH FILES

The source code (Bourne shell script) of this tool is available in file 
.B $CADP/com/tst

.SH SEE ALSO

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
Please report new bugs to Hubert.Garavel@inria.fr

