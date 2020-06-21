.\" @(#)scrutator.l - INRIA - 2020/02/12
.TH SCRUTATOR LOCAL "2020/02/12" "(C) INRIA" "CADP MANUAL PAGES"
.fp 4 CB
.lg 0
.SH NAME
scrutator \- pruning of Labelled Transition Systems

.SH SYNOPSIS
.B bcg_open
.RI [ bcg_opt ]
\fIspec\fP[\fB.bcg\fP]
.RI [ cc_opt ]
.B scrutator
.RI [ scrutator_opt ]
\fIlts\fP[\fB.bcg\fP]
.sp
or:
.sp
.B exp.open
.RI [ exp_opt ]
\fIspec\fP[\fB.exp\fP]
.RI [ cc_opt ]
.B scrutator
.RI [ scrutator_opt ]
\fIlts\fP[\fB.bcg\fP]
.sp
or:
.sp
.B fsp.open
.RI [ fsp_opt ]
\fIspec\fP[\fB.lts\fP]
.RI [ cc_opt ]
.B scrutator
.RI [ scrutator_opt ]
\fIlts\fP[\fB.bcg\fP]
.sp
or:
.sp
.B lnt.open
.RI [ lnt_opt ]
\fIspec\fP[\fB.lnt\fP]
.RI [ cc_opt ]
.B scrutator
.RI [ scrutator_opt ]
\fIlts\fP[\fB.bcg\fP]
.sp
or:
.sp
.B lotos.open
.RI [ lotos_opt ]
\fIspec\fP[\fB.lotos\fP]
.RI [ cc_opt ]
.B scrutator
.RI [ scrutator_opt ]
\fIlts\fP[\fB.bcg\fP]
.sp
or:
.sp
.B seq.open
.RI [ seq_opt ]
\fIspec\fP[\fB.seq\fP]
.RI [ cc_opt ]
.B scrutator
.RI [ scrutator_opt ]
\fIlts\fP[\fB.bcg\fP]

.SH DESCRIPTION
\fBscrutator\fP takes as input a Labelled Transition System (LTS)
represented either as
a BCG graph \fIspec\fP\fB.bcg\fP,
a composition expression \fIspec\fP\fB.exp\fP,
an FSP program \fIspec\fP\fB.lts\fP, 
an LNT program \fIspec\fP\fB.lnt\fP,
a LOTOS program \fIspec\fP\fB.lotos\fP,
or a sequence file \fIspec\fP\fB.seq\fP.

.P
\fBscrutator\fP performs an on-the-fly exploration of the LTS \fIspec\fP
and prunes certain parts of it according to the options and arguments
specified (see OPTIONS below). The resulting LTS, represented as a BCG
graph, is stored in the file \fIlts\fP\fB.bcg\fP.

.P
Additionally, \fBscrutator\fP can also reduce the LTS on the fly according
to various relations (see OPTIONS below).

.P
Note: The method implemented in the current version of
\fBscrutator\fP (described in [MPS07,MPS12]) is based on a translation
of the pruning problem into the resolution of a Boolean Equation System
(BES), which is performed on the fly using the algorithms provided by the
.BR caesar_solve_1 (LOCAL)
library of OPEN/CAESAR (see the corresponding manual page and the
article [Mat06] for details).

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

.P
The following options \fIscrutator_opt\fP are currently available:

.TP
\fB-nodeadlock\fP
Prune \fIspec\fP by keeping only the transitions whose target
states do not eventually lead to deadlock states.
.sp
Formally, a transition s--L-->s' is kept in \fIlts\fP\fB.bcg\fP
iff state s' satisfies the following CTL formula:
.nf
    \fBnot (AF deadlock)\fP
.fi
or the equivalent mu-calculus formula:
.nf
    \fBnu X . <true> X\fP
.fi
This kind of pruning corresponds to the adaptation technique proposed
in [CPS06], the difference being that the pruning is performed on-the-fly.
This option is mutually exclusive with the \fB-potential\fP and 
\fB-inevitable\fP options.
Default option.

.TP
\fB\-potential [ \-total | \-partial | \-gate ]\fP \fImatching_filename\fP 
Prune \fIspec\fP by keeping only the transitions whose target
states potentially lead to states having an outgoing transition
labelled by an action matching the rules defined in \fImatching_filename\fP.
.sp
The format of \fImatching_filename\fP is the same as of hiding files
defined in the
.BR caesar_hide_1 (LOCAL)
manual page, except that the keyword "match" is used instead of "hide".
The \fB-total\fP, \fB-partial\fP, and \fB-gate\fP options specify the "total
matching", "partial matching", and "gate matching" semantics, respectively.
See the
.BR caesar_hide_1 (LOCAL)
manual page for more details about these semantics. Option
\fB-total\fP is the default.
.sp
Formally, a transition s--L-->s' is kept in \fIlts\fP\fB.bcg\fP
iff state s' satisfies the following CTL formula:
.nf
    \fBEF <\fP\fIaction\fP\fB> true\fP
.fi
or the equivalent mu-calculus formula:
.nf
    \fBmu X . <\fP\fIaction\fP\fB> true or <true> X\fP
.fi
where \fIaction\fP denotes an action (transition label) matching the
rules specified in \fImatching_filename\fP.
This kind of pruning corresponds to the adaptation technique proposed
in [MPS07,MPS12].
This option is mutually exclusive with the \fB-nodeadlock\fP and 
\fB-inevitable\fP options.
Not a default option.

.TP
\fB\-inevitable [ \-total | \-partial | \-gate ]\fP \fImatching_filename\fP
Prune \fIspec\fP by keeping only the transitions whose target
states eventually lead to states having an outgoing transition
labelled by an action matching the rules defined in \fImatching_filename\fP.
.sp
The format of \fImatching_filename\fP is the same as of hiding files
defined in the
.BR caesar_hide_1 (LOCAL)
manual page, except that the keyword "match" is used instead of "hide".
The \fB-total\fP, \fB-partial\fP, and \fB-gate\fP options specify the "total
matching", "partial matching", and "gate matching" semantics, respectively.
See the
.BR caesar_hide_1 (LOCAL)
manual page for more details about these semantics. Option
\fB-total\fP is the default.
.sp
Formally, a transition s--L-->s' is kept in \fIlts\fP\fB.bcg\fP
iff state s' satisfies the following CTL formula:
.nf
    \fBAF <\fP\fIaction\fP\fB> true\fP
.fi
or the equivalent mu-calculus formula:
.nf
    \fBmu X . <\fP\fIaction\fP\fB> true or (<true> true and [true] X)\fP
.fi
where \fIaction\fP denotes an action (transition label) matching the
rules specified in \fImatching_filename\fP.
This option is mutually exclusive with the \fB-nodeadlock\fP and 
\fB-potential\fP options.
Not a default option.

.TP
\fB-cache\fP \fIn\fP
Use a cache of size \fIn\fP for storing the states of \fIspec\fP during
the pruning. This option allows to trade off memory consumption against
execution time.
Not a default option.

.TP
\fB-stat\fP
Display statistical information about the resolution of the BES
corresponding to the pruning of \fIspec\fP. Not a default option.

.TP
\fB-version\fP
Display the current version number of the tool and stop.
To be effective, this option should occur as the first argument
on the command line. Subsequent options and/or arguments, if any,
will be discarded. Not a default option.

.P
The options below specify additional reductions that can be applied
on-the-fly during the pruning of the LTS:

.TP
\fB-tauconfluence\fP
Reduce the LTS on the fly modulo tau-confluence (a form of partial
order reduction that preserves branching equivalence).
This option can be used in conjunction with options \fB-taustar\fP
and \fB-weaktrace\fP, and in some cases it may reduce the execution
time and the memory consumption significantly.
Not a default option.

.TP
\fB-taustar\fP
Reduce the LTS on the fly modulo tau*.a equivalence. This reduction
eliminates all internal transitions (labelled by the "i" action) in
\fIlts\fP\fB.bcg\fP.
Not a default option.

.TP
\fB-weaktrace\fP
Reduce the LTS on the fly modulo weak trace equivalence. This reduction
eliminates all internal transitions and determinizes
\fIlts\fP\fB.bcg\fP.
Not a default option.

.P
Note: The reduction options above replace the divergences (cycles of
tau-transitions) present in the LTS with deadlock states.
This may influence the inevitable reachability of certain states
(e.g., deadlock states or states having an outgoing transition
labelled by a given action), and therefore may trigger a more drastic
pruning of the LTS when used in conjunction with the \fB-nodeadlock\fP
and \fB-inevitable\fP options.

.SH EXIT STATUS
Exit status is 0 if everything is alright, 1 otherwise.

.SH BIBLIOGRAPHY

.TP
[CPS06]
C. Canal, P. Poizat, and G. Salaun.
Synchronizing Behavioural Mismatch in Software Composition.
In Roberto Gorrieri and Heike Wehrheim (Eds.), Proceedings of the 8th
IFIP International Conference on Formal Methods for Open Object-Based
Distributed Systems FMOODS'2006 (Bologna, Italy), Lecture Notes in
Computer Science vol. 4037, pp. 63-77. Springer Verlag, June 2006.

.TP
[Mat06]
R. Mateescu.
CAESAR_SOLVE: A Generic Library for On-the-Fly Resolution of
Alternation-Free Boolean Equation Systems.
Springer International Journal on Software Tools for Technology Transfer
(STTT) 8(1):37-56, 2006. Full version available as INRIA
Research Report RR-5948.

.TP
[MPS07]
R. Mateescu, P. Poizat, and G. Salaun.
On-the-Fly Adaptation of Component Compositions based on Process Algebra
Encodings. In Alexander Egyed and Bernd Fischer (Eds.), Proceedings of the
22nd IEEE/ACM International Conference on Automated Software Engineering
ASE'07 (Atlanta, Georgia, USA), pp. 385-388. ACM Press, Nov. 2007.
Full version available as INRIA Research Report RR-6362.

.TP
[MPS12]
R. Mateescu, P. Poizat, and G. Salaun.
Adaptation of Service Protocols Using Process Algebra and On-the-Fly Reduction
Techniques. IEEE Transactions on Software Engineering 38(4):755-777, 2012.

.SH AUTHORS
Radu Mateescu (INRIA/CONVECS).

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
.TP
.IB lts .bcg
BCG graph (output)

.PD
.SH FILES
The binary code of \fBscrutator\fP is available in
$CADP/bin.`arch`/scrutator.a

.SH SEE ALSO
.BR bcg (LOCAL),
.BR bcg_open (LOCAL),
.BR exp (LOCAL),
.BR exp.open (LOCAL),
.BR fsp.open (LOCAL),
.BR lnt.open (LOCAL),
.BR lotos (LOCAL),
.BR lotos.open (LOCAL),
.BR seq (LOCAL)
.BR seq.open (LOCAL)
.P
Additional information is available from the CADP Web page located at http://cadp.inria.fr
.P
Directives for installation are given in files \fB$CADP/INSTALLATION_*\fP.
.P
Recent changes and improvements to this software are reported
and commented in file \fB$CADP/HISTORY\fP.

.SH BUGS
Please report bugs to Radu.Mateescu@inria.fr

