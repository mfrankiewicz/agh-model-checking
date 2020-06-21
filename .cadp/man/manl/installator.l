.\" @(#)installator.l - VASY and CONVECS teams - 2013/11/08
.TH INSTALLATOR LOCAL "2013/11/08" "(C) INRIA" "CADP MANUAL PAGES"
.fp 4 CB
.lg 0
.SH NAME
installator \- CADP installation assistant 

.SH SYNOPSIS
.B installator
.RB [ -beta ]

.SH DESCRIPTION
This program installs CADP on one machine or on several machines connected 
by a Local Area Network. It can also be used to upgrade an existing version 
of CADP already installed. Installator takes in charge the following tasks:
.IP - 
Inquiry about the latest version of CADP available on the FTP site of CADP,
.IP -
Download of the latest version of CADP available using the FTP protocol,
.IP -
Archive extraction and installation of CADP on the local machine or network,
.IP -
Registration of CADP using the Request For License procedure.

.P
Although a manual installation of CADP also exists, the use of
.B installator
is strongly recommended, as it ensures that the installation will be
done correctly and automatically.

.ce 1
see http://cadp.inria.fr/man/pictures/install1.gif
.ce 1
see http://cadp.inria.fr/man/pictures/install2.gif
.ce 1
see http://cadp.inria.fr/man/pictures/install3.gif
.ce 1
see http://cadp.inria.fr/man/pictures/install4.gif
.ce 1
.I "A few snapshots of Installator"

.SH OPTIONS
.TP
.B -beta
download a beta-version of CADP (instead of a plain, stable version). Do not 
use this option unless you have been specifically advised to do so by the 
CADP development team. 

.SH EXIT STATUS
Exit status is 0 if everything is alright, 1 otherwise.

.SH AUTHORS
Hubert Garavel, Aldo Mazzilli, Patrick Wendel (INRIA Rhone-Alpes)

.SH FILES

.B installator
is a shell script located in
.B $CADP/com/installator
that launches a Tcl/Tk script to be executed by the 
.B wish
interpreter. The source files of
.B installator
are available in directory 
.B $CADP/src/installator

.SH SEE ALSO
.BR tst (LOCAL)

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

