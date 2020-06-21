.\" @(#)seq.open.l - VASY and CONVECS teams - 2020/02/11
.TH SEQ.OPEN LOCAL "2020/02/11" "(C) INRIA" "CADP MANUAL PAGES"
.fp 4 CB
.lg 0
.SH NAME
seq.open \- OPEN/CAESAR connection for traces encoded in the SEQ format

.SH SYNOPSIS
.BI seq.open \ [seq_options]\ filename[ .seq ]\ [cc_options]
\fIprog[\fP\fB.a\fP\fI|\fP\fB.c\fP\fI|\fP\fB.o\fP\fI]\fP
.I [prog_options]

.SH DESCRIPTION
Taking as input the graph \fIfilename\fP\fB.seq\fP, which represents a
set of one or more execution traces encoded in the simple SEQ format 
(see the 
.BR seq (LOCAL)
manual page for a definition of this format), and an OPEN/CAESAR 
program \fIprog\fP[\fB.a\fP|\fB.c\fP|\fB.o\fP], \fBseq.open\fP generates 
an executable program \fIprog\fP by performing appropriate calls to the 
C compiler. Finally, \fIprog\fP is executed.
.P
According to the principles of the OPEN/CAESAR architecture, \fIprog\fP is
obtained by combining three different modules:

.IP -
the graph module is obtained by scanning \fIfilename\fP\fB.seq\fP
.PD 0
.IP -
the storage module is the standard OPEN/CAESAR library
.IP -
the exploration module is \fIprog\fP[\fB.a\fP|\fB.c\fP|\fB.o\fP]
.PD

.P
The \fBseq.open\fP tool was designed to handle very large execution traces,
such as those obtained by a random execution of a real system. For this
reason, \fBseq.open\fP works on-the-fly, without storing in memory the entire
contents of \fIfilename\fP\fB.seq\fP. In order to speed up the exploration,
an hash-based cache table of bounded size is used to avoid multiple
computations of label strings and successor transitions.

.SH PROCESSING OF THE EXPLORATION MODULE
The exploration module \fIprog\fP[\fB.a\fP|\fB.c\fP|\fB.o\fP] is
supposed to contain an OPEN/CAESAR application program, such as
\fBexhibitor\fP, \fBevaluator\fP, \fBterminator\fP...
.P
The exploration module can be supplied in three different forms. It can
be either an archive file (with \fB.a\fP suffix), or a source C program 
(with \fB.c\fP suffix) or an object code file (with \fB.o\fP suffix).
.P
If \fIprog\fP\fB.a\fP is not present in the current directory, \fBseq.open\fP
attempts to fetch it in the OPEN/CAESAR binary library \fB$CADP/bin.`arch`\fP.
.P
If \fIprog\fP\fB.c\fP is not present in the current directory,
\fBseq.open\fP attempts to fetch it in the OPEN/CAESAR source library
\fB$CADP/src/open_caesar\fP.
.P
If \fIprog\fP\fB.o\fP is not present in the current directory, \fBseq.open\fP
attempts to fetch it in the OPEN/CAESAR binary library \fB$CADP/bin.`arch`\fP.
.P
If no suffix (\fB.a\fP, \fB.c\fP, \fB.o\fP) is specified on the command 
line for the exploration module \fIprog\fP, \fBseq.open\fP will make
successive attempts to fetch this exploration module: first, as a source 
C program with \fB.c\fP suffix; then as an archive file with \fB.a\fP suffix;
finally as an object code file with suffix \fB.o\fP.

.SH DETERMINATION OF INCLUDE OR LINK MODE

Only the ``link mode'' of OPEN/CAESAR is supported by \fBseq.open\fP.

.SH OPTIONS
The \fIcc_options\fP, if any, are passed to the C compiler.
.P
The \fIprog_options\fP, if any, are passed to \fIprog\fP.

The following options \fIseq_options\fP are currently available:
.TP
.BI -seqno \ number
Select the \fInumber\fP-th sequence in \fIfilename\fP\fB.seq\fP as the
only sequence to be considered during exploration. \fInumber\fP should be 
a positive integer. By default (if this option is not present on the 
command-line) or if \fIseqno\fP is equal to zero, all sequences contained
in \fIfilename\fP\fB.seq\fP will be considered. If \fIfilename\fP\fB.seq\fP
only contains a single sequence, using option `\fB-seqno\fP 1' may speed up
the execution by avoiding a preliminary scan of the sequence file.

.TP
.BI -cache \ number
Select the size of the hash-based cache table used to avoid recomputations
of label strings and successor transitions. This size defines the number
of entries in the cache table. If \fInumber\fP is not a prime, it will be 
replaced by the closest higher prime number. By default (if this option is 
not present on the command-line), the cache size will be 49999.

.TP
.BI -stat
Print statistics about the usage of cache, such as the number of failures
(the requested data is not stored in the cache) and the number of successes
(the requested data is already in cache) every time a sink state is reached
(i.e., at the end of each sequence). Not a default option.

.SH EXIT STATUS
Exit status is 0 if everything is alright, 1 otherwise.

.SH AUTHORS
Hubert GARAVEL, Radu MATEESCU, and Bruno ONDET (INRIA Rhone-Alpes / VASY)

.SH OPERANDS
.PD 0
.TP 21
.IB filename .seq
sequence graph (input)
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
.IB prog\ \ \ \ \ \ \ \ 
executable program (output)
.PD

.SH FILES
.PD 0
.TP 31
.B $CADP/com/seq.open
``seq.open'' shell script
.TP
.B $CADP/bin.`arch`/libseq_open.a
``seq.open'' static library
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

.SH SEE ALSO
.BR seq (LOCAL),
.BR lotos.open (LOCAL),
.BR exhibitor (LOCAL)

.P
Additional information is available from the CADP Web page located at http://cadp.inria.fr

.P
Directives for installation are given in files \fB$CADP/INSTALLATION_*\fP.

.P
Recent changes and improvements to this software are reported
and commented in file \fB$CADP/HISTORY\fP.

.SH BUGS
Please report bugs to Hubert.Garavel@inria.fr

