.\" @(#)contributor.l - VASY and CONVECS teams - 2013/09/17
.TH CONTRIBUTOR LOCAL "2013/09/17" "(C) INRIA" "CADP MANUAL PAGES"
.fp 4 CB
.lg 0
.SH NAME
contributor \- CADP contribution assistant 

.SH SYNOPSIS
.B contributor

.SH DESCRIPTION
This program is a utility that you can use to contribute to CADP testing, by
sending files to be added to the regression test suite. You can use it to
select files on your computer and to send them by FTP transfer to the CADP
development team. Your files will help our continuing efforts to improve
quality and stability of CADP, and your contribution ensures that we will 
test features that are of particular interest to you.

.P
The files that you contribute are related to CADP, such as LOTOS 
specifications, BCG graphs, MCL or XTL formulas, Boolean equation systems,
etc. They are treated as confidential and used only by the CADP team for
testing future versions of CADP.

.P
.B contributor
runs on your local machine, making no network connection except to send 
your contribution to the CADP team by FTP at the end of processing.

.P
You have complete control over when you use \fBcontributor\fP.
You choose the directories that
.B contributor
is allowed to search, and the types of files (by specifying the file 
extensions) that
.B contributor
is allowed to consider.  To refine this set of directories and files,
.B contributor 
has also built-in rules that attempt to select only those files that are 
relevant for testing CADP tools. 

.P
Additionally, you have an opportunity to review the set of selected files
and to exclude any that you do not wish to send.

.P
.B contributor 
does not send files you have previously contributed (to avoid duplicates) 
nor files that you have already excluded during a previous invocation of
\fBcontributor\fP.

.P
Running 
.B contributor 
only takes a few minutes, and it has no impact on other CADP components. 
You are recommended to run it every six months and on completion of significant
work, which will help the CADP team to keep the regression test suite up to
date and in line with the needs of CADP users. Use of 
.B contributor 
is completely optional, but is greatly appreciated.

.SH PREFERENCES AND RULES

Each time you use 
.B contributor, 
it saves (in a directory named \fB~/.config/cadp/contributor\fP) information
about the preferences you specified for \fBcontributor\fP, such as the list
of directories to search, the file extensions to consider, the files you
specifically excluded, the files already sent, etc. This information is
used the next time you use \fBcontributor\fP, but you can override it.

.P
.B contributor 
has a built-in set of rules that exclude files that seem unrelated to CADP.
These rules are defined for each file extension. For example, a C program 
(with a "\fB.c\fP" or "\fB.h\fP" file extension) will only be selected if it
contains certain strings (e.g., the string "\fBCAESAR\fP"). There are also
limits on the size of files that can be selected.
User selection has precedence over the built-in rules, so you can decide
to send any file, even if the rules would otherwise exclude it from the
contribution. 

.SH USAGE
There are five steps to using \fBcontributor\fP:

.sp
\fB1.\fP Select the directories where the files to send are located.
If you are using 
.B contributor 
for the first time, your home directory is included by default. 
.ce 1
see http://cadp.inria.fr/man/pictures/contrib1.gif

.sp
\fB2.\fP Select the file types (file extensions) of the files to be sent.
.ce 1
see http://cadp.inria.fr/man/pictures/contrib2.gif

.sp
\fB3.\fP Based on your selection
.B contributor 
computes a proposed list of files to be sent, by applying your preferences and
the built-in rules, not selecting files that have already been sent or files
that you previously excluded.
.ce 1
see http://cadp.inria.fr/man/pictures/contrib3.gif

.sp
\fB4.\fP Review the proposed list, and add or exclude files to get the final list
you want to send to the CADP team. You can view the content of a file by
double-clicking on its name. Also, by checking the relevant boxes on the
the right of the window, you can view the files that are excluded by 
your preferences (user-excluded files), the files that are excluded by the 
built-in rules (rules-excluded files), and the files that have already been
sent.
.ce 1
see http://cadp.inria.fr/man/pictures/contrib4.gif

.sp
\fB5.\fP Using your final selection list, 
.B contributor 
creates a \fB.tar.gz\fP archive containing all the files selected, and sends it
by FTP to \fBftp.inrialpes.fr\fP. 
.ce 1
see http://cadp.inria.fr/man/pictures/contrib5.gif

.LP
Note: This archive is stored in the directory specified by the \fB$CADP_TMP\fP
environment variable, or in \fB/tmp\fP if this variable is undefined. 
If the FTP transfer via
.B contributor
fails, retry the FTP transfer manually. If this is still unsuccessful, please
contact the CADP team to arrange another method of transfering the file.

.SH EXIT STATUS
Exit status is 0 if everything is alright, 1 otherwise.

.SH AUTHORS
Julien Henry, Hubert Garavel, and Christine McKinty (INRIA Rhone-Alpes)

.SH FILES
.B contributor
is a shell script located in
.B $CADP/com/contributor
that launches a Tcl/Tk script to be executed by the
.B wish
interpreter. The source files of 
.B contributor 
are available in directory
.B $CADP/src/contributor

.SH SEE ALSO

Additional information is available from the CADP Web page located at http://cadp.inria.fr
.P
Directives for installation are given in files
.B $CADP/INSTALLATION_*.
.P
Recent changes and improvements to this software are reported and commented
in file
.B $CADP/HISTORY.

.SH BUGS
Please report new bugs to Hubert.Garavel@inria.fr

