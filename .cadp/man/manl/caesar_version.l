'\" t
.\" @(#)caesar_version.l - VASY and CONVECS teams - version 2.0
.TH caesar_version LOCAL "2020/02/11 (version 2.0)" "(C) INRIA" "OPEN/CAESAR MANUAL"
.fp 4 CB
.lg 0
.SH NAME
caesar_version \- the ``version'' library of OPEN/CAESAR
.SH PURPOSE
The ``version'' library allows to access and control the version numbers (also called release numbers, revision numbers) of the tools and libraries making up the \fIOPEN/CAESAR\fP environment.
.sp
It is be used to check whether a \fBspec.c\fP file (generated from a source program) is up to date with respect to the \fBcaesar_graph,h\fP file and other files and libraries of the \fIOPEN/CAESAR\fP environment. Version clashes between \fBspec.c\fP and \fBcaesar_graph,h\fP can cause subtle errors very difficult to detect; the ``version'' library aims at preventing such clashes.
.sp
.SH USAGE
The ``version'' library consists of:
.IP -
a predefined header file \fBcaesar_version.h\fP;
.IP -
the precompiled library file \fBlibcaesar.a\fP, which implements the features described in \fBcaesar_version.h\fP.
.P
Note: The ``version'' library is a software layer built above the primitives offered by the ``standard'' library.
.sp
.SH FEATURES
.P
 ............................................................
.SS \fBCAESAR_TYPE_VERSION\fP
 \&
.nf
\fBtypedef double CAESAR_TYPE_VERSION;
\fP
.fi
\fBCAESAR_TYPE_VERSION\fP represents a version number, which is a positive floating-point number with a single digit after the decimal point.
.P
 ............................................................
.SS \fBCAESAR_LIBRARY_VERSION\fP
 \&
.nf
\fBCAESAR_TYPE_VERSION CAESAR_LIBRARY_VERSION ()
   { ... }
\fP
.fi
This function returns the version number of the \fIOPEN/CAESAR\fP environment. This version number covers the \fBcaesar_graph.h\fP file, as well as other \fB.h\fP, \fB.c\fP and \fB.a\fP files contained in the \fIOPEN/CAESAR\fP distribution. All these files are supposed to be mutually up to date and compatible.
.P
 ............................................................
.SS \fBCAESAR_COMPARE_VERSION\fP
 \&
.nf
\fBCAESAR_TYPE_BOOLEAN CAESAR_COMPARE_VERSION (CAESAR_V1, CAESAR_V2)
   CAESAR_TYPE_VERSION CAESAR_V1;
   CAESAR_TYPE_VERSION CAESAR_V2;
   { ... }
\fP
.fi
This function returns \fBCAESAR_TRUE\fP if both version numbers \fBCAESAR_V1\fP and \fBCAESAR_V2\fP are identical, or \fBCAESAR_FALSE\fP if they are not.
.sp
Note: the standard C operator \fB==\fP should not be used for this purpose, because of problems inherent to the floating-point representation. For instance, version number \fB1.1\fP will not be exactly represented as \fB1.1\fP, but as \fB1.10000002384185791\fP, so it is possible that \fB1.1\fP is not strictly equal to \fB1.1\fP! Function \fBCAESAR_COMPARE_VERSION\fP solves this problem by comparing both version numbers with a limited precision (+/- 10^{-3}).
.P
 ............................................................
.SS \fBCAESAR_MATCH_VERSION\fP
 \&
.nf
\fBCAESAR_TYPE_BOOLEAN CAESAR_MATCH_VERSION (CAESAR_V1, CAESAR_V2)
   CAESAR_TYPE_VERSION CAESAR_V1;
   CAESAR_TYPE_VERSION CAESAR_V2;
   { ... }
\fP
.fi
This function returns \fBCAESAR_TRUE\fP if \fBCAESAR_LIBRARY_VERSION()\fP is contained in the numeric interval [\fBCAESAR_V1\fP, \fBCAESAR_V2\fP], or \fBCAESAR_FALSE\fP otherwise. \fBCAESAR_V1\fP and \fBCAESAR_V2\fP can be equal: in this case, the result is \fBCAESAR_TRUE\fP iff \fBCAESAR_LIBRARY_VERSION()\fP is equal to \fBCAESAR_V1\fP.
.sp
The parameters \fBCAESAR_V1\fP and \fBCAESAR_V2\fP delimit the bounds of an interval of acceptable version numbers for the value of \fBCAESAR_LIBRARY_VERSION()\fP, meaning that \fBspec.c\fP can be safely compiled and linked with any revision of the \fIOPEN/CAESAR\fP library whose version number is between \fBCAESAR_V1\fP and \fBCAESAR_V2\fP (bounds included).
.P
 ............................................................
.SS \fBCAESAR_CHECK_VERSION\fP
 \&
.nf
\fBvoid CAESAR_CHECK_VERSION (CAESAR_V1, CAESAR_V2)
   CAESAR_TYPE_VERSION CAESAR_V1;
   CAESAR_TYPE_VERSION CAESAR_V2;
   { ... }
\fP
.fi
This procedure evaluates the following boolean expression:
.TS
center;
l.
 
 \fBCAESAR_MATCH_VERSION (CAESAR_V1, CAESAR_V2)\fP 
 
.TE
and aborts the execution if the result is equal to 0.
.sp
Note: This function should be called in the \fBspec.c\fP program, for instance at the beginning of procedure \fBCAESAR_INIT_GRAPH()\fP.
.P
 ............................................................
.SS \fBCAESAR_PRINT_VERSION\fP
 \&
.nf
\fBvoid CAESAR_PRINT_VERSION (CAESAR_FILE, CAESAR_V)
   CAESAR_TYPE_FILE CAESAR_FILE;
   CAESAR_TYPE_VERSION CAESAR_V;
   { ... }
\fP
.fi
This procedure prints to file \fBCAESAR_FILE\fP a character string representing the version number \fBCAESAR_V\fP.
.sp
Before this procedure is called, \fBCAESAR_FILE\fP must have been properly opened, for instance using \fBfopen(3)\fP.
.P
 ............................................................
.SH AUTHOR(S)
Hubert Garavel
.SH FILES
.PD 0
.TP 30
.B $CADP/incl/caesar_graph.h
interface of the graph module
.TP
.B $CADP/incl/caesar_*.h
interfaces of the storage module
.TP
.B $CADP/bin.`arch`/libcaesar.a
object code of the storage module
.TP
.B $CADP/src/open_caesar/*.c
source code of various exploration modules
.TP
.B $CADP/com/lotos.open
shell script to run OPEN/CAESAR
.PD
.SH SEE ALSO
Reference Manuals of OPEN/CAESAR, CAESAR, and CAESAR.ADT,
.BR lotos.open (LOCAL),
.BR caesar (LOCAL),
.BR caesar.adt (LOCAL)
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
Known bugs are described in the Reference Manual of OPEN/CAESAR.
Please report new bugs to cadp@inria.fr
