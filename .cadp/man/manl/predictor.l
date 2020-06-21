.\" @(#)predictor.l - VASY and CONVECS teams - 2020/02/12
.TH PREDICTOR LOCAL "2020/02/12" "(C) INRIA" "CADP MANUAL PAGES"
.fp 4 CB
.lg 0
.SH NAME
predictor \- predict the feasability of reachability analysis

.SH SYNOPSIS
.B bcg_open
.RI [ bcg_opt ]
\fIspec\fP[\fB.bcg\fP]
.RI [ cc_opt ]
.BR predictor
.P
or:
.P
.B exp.open
[\fIexp_opt\fP]
\fIspec\fP[\fB.exp\fP] 
.RI [ cc_opt ]
.BR predictor
.P
or:
.P
.B fsp.open
[\fIfsp_opt\fP]
\fIspec\fP[\fB.lts\fP]
.RI [ cc_opt ]
.BR predictor
.P
or:
.P
.B lnt.open
[\fIlnt_opt\fP]
\fIspec\fP[\fB.lnt\fP]
.RI [ cc_opt ]
.BR predictor
.P
or:
.P
.B lotos.open
[\fIlotos_opt\fP]
\fIspec\fP[\fB.lotos\fP]
.RI [ cc_opt ]
.BR predictor
.P
or:
.P
.B seq.open
[\fIseq_opt\fP]
\fIspec\fP[\fB.seq\fP]
.RI [ cc_opt ]
.BR predictor

.SH DESCRIPTION
This program gives some predictive estimations concerning the
feasability of reachability analysis for
the BCG graph \fIspec\fP\fB.bcg\fP,
the composition expression \fIspec\fP\fB.exp\fP,
the FSP program \fIspec\fP\fB.lts\fP,
the LNT program \fIspec\fP\fB.lnt\fP,
the LOTOS program \fIspec\fP\fB.lotos\fP,
or the sequence file \fIspec\fP\fB.seq\fP.
It displays:

.IP - 
The state size (in bytes). Notice that this size only refers to the "static"
part of the state vector; the "dynamic" part (dynamic data structures such
as lists, trees, etc.) cannot be taken into account.

.IP - 
One or several estimations of the amount of memory available on the current
machine. If the environment variable \fB$CADP_MEMORY\fP (see below) is set,
then its value is used. Otherwise, \fBpredictor\fP invokes an auxiliary
program named \fBcadp_memory\fP to determine a relevant value or, whenever
possible, three values of interest:
(1) the amount of free memory currently available, (2) the total amount of 
memory physically installed on the current machine, and (3) the sum of free
memory and free swap currently available. 

.IP
Notice that relying on the swap may significantly decrease the performance of 
model checking algorithms. 

.IP
Also, on 32-bit machines or 64-bit machines running processes in 32-bit mode,
these estimations take into account the fact that, even if 4 gigabytes of
memory are physically available, only a part of it (e.g., 3 gigabytes) can be
used by application programs.

.IP - 
For each estimation of the amount of memory available, an upper bound on the
number of states that can be generated exhaustively (e.g., using "standard"
CAESAR, OPEN/CAESAR's Generator, etc.). Notice that this number is not merely
the quotient of the amount of memory available divided by the state size,
because auxiliary data structures must also be considered.

.IP
Notice, however, that this number is only an upper bound, since the amount of
memory required for dynamic data types, hash tables, and other data structures,
etc., is not taken into account.

.P
Note: the \fPpredictor\fP program is not very useful when applied to BCG
graphs, since the graph has already been generated.

.SH OPTIONS

The options \fIbcg_opt\fP, if any, are passed to
.BR bcg_lib (LOCAL).

.P
The options \fIexp_opt\fP, if any, are passed to
.BR exp.open (LOCAL).

.P
The options \fIfsp_opt\fP, if any, are passed to
.BR fsp.open (LOCAL).

.P
The options \fIlnt_opt\fP, if any, are passed to
.BR lnt.open (LOCAL).

.P
The options \fIlotos_opt\fP, if any, are passed to
.BR caesar (LOCAL)
and to
.BR caesar.adt (LOCAL).

.P
The options \fIseq_opt\fP, if any, are passed to
.BR seq.open (LOCAL).

.P
The options \fIcc_opt\fP, if any, are passed to the C compiler.

.SH ENVIRONMENT VARIABLES

.TP
.B $CADP_MEMORY
If this variable is set, its value gives an estimation of the amount of 
memory (in kilobytes) that can be allocated by a process on the current
machine; if this variable is not set, a default value will be determined 
automatically. See the \fB$CADP/INSTALLATION_2\fP file for details.

.SH EXIT STATUS
Exit status is 0 if everything is alright, 1 otherwise.

.SH DIAGNOSTICS
When the source is erroneous, error messages are issued.

.SH AUTHOR
Hubert Garavel (INRIA Rhone-Alpes)

.SH OPERANDS
.PD 0
.TP 20
.IB spec .bcg
BCG graph (input)
.TP
.IB spec .exp
network of communicating LTSs (input)
.TP
.IB spec .lts
FSP specification (input)
.TP
.IB spec .lnt
LNT specification (input)
.TP
.IB spec .lotos
LOTOS specification (input)
.TP
.IB spec .seq
sequence file (input)
.PD

.SH FILES

The source code of this tool is available in file 
.B $CADP/src/open_caesar/predictor.c 
.P

.SH SEE ALSO
OPEN/CAESAR Reference Manual,
.BR bcg (LOCAL),
.BR bcg_open (LOCAL),
.BR caesar (LOCAL),
.BR caesar.adt (LOCAL),
.BR exp (LOCAL),
.BR exp.open (LOCAL),
.BR fsp.open (LOCAL),
.BR lnt.open (LOCAL),
.BR lotos (LOCAL),
.BR lotos.open (LOCAL),
.BR seq (LOCAL),
.BR seq.open (LOCAL)

.P
Additional information is available from the CADP Web page located at
http://cadp.inria.fr

.P
Directives for installation are given in files
.B $CADP/INSTALLATION_*.
.P
Recent changes and improvements to this software are reported
and commented in file
.B $CADP/HISTORY.

.SH BUGS
Please report new bugs to Hubert.Garavel@inria.fr

