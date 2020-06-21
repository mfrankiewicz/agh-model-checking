.\" @(#)projector.l - VASY and CONVECS teams - 2020/02/12
.TH PROJECTOR LOCAL "2020/02/12" "(C) INRIA" "CADP MANUAL PAGES"
.fp 4 CB
.lg 0
.SH NAME
projector \- semi-composition and generation of Labelled Transition
Systems

.SH SYNOPSIS

.P
.B bcg_open
.RI [ bcg_opt ]
\fIspec\fP[\fB.bcg\fP]
.RI [ cc_opt ]
.B projector 
.RI [ projector_opt ]
\fIinterface\fP[\fB.bcg\fP]
\fIresult\fP[\fB.bcg\fP]
.sp
or:
.sp
.B exp.open
.RI [ exp_opt ]
\fIspec\fP[\fB.exp\fP]
.RI [ cc_opt ]
.B projector 
.RI [ projector_opt ]
\fIinterface\fP[\fB.bcg\fP]
\fIresult\fP[\fB.bcg\fP]
.sp
or:
.sp
.B fsp.open
.RI [ fsp_opt ]
\fIspec\fP[\fB.lts\fP]
.RI [ cc_opt ]
.B projector 
.RI [ projector_opt ]
\fIinterface\fP[\fB.bcg\fP]
\fIresult\fP[\fB.bcg\fP]
.sp
or:
.sp
.B lnt.open
.RI [ lnt_opt ]
\fIspec\fP[\fB.lnt\fP]
.RI [ cc_opt ]
.B projector 
.RI [ projector_opt ]
\fIinterface\fP[\fB.bcg\fP]
\fIresult\fP[\fB.bcg\fP]
.sp
or:
.sp
.B lotos.open
.RI [ lotos_opt ]
\fIspec\fP[\fB.lotos\fP]
.RI [ cc_opt ]
.B projector
.RI [ projector_opt ]
\fIinterface\fP[\fB.bcg\fP]
\fIresult\fP[\fB.bcg\fP]
.sp
or:
.sp
.B seq.open
.RI [ seq_opt ]
\fIspec\fP[\fB.seq\fP]
.RI [ cc_opt ]
.B projector 
.RI [ projector_opt ]
\fIinterface\fP[\fB.bcg\fP]
\fIresult\fP[\fB.bcg\fP]

.SH DESCRIPTION
\fBprojector\fP takes two different inputs: 

.IP -
A Labelled Transition System (LTS), expressed either as a BCG graph
.IB spec .bcg,
a composition expression
.IB spec .exp,
an FSP program
.IB spec .lts,
an LNT program
.IB spec .lnt,
a LOTOS program
.IB spec .lotos,
or a sequence file
.IB spec .seq.

.IP -
An LTS contained in the file
\fIinterface\fP[\fB.bcg\fP].

.P
.B projector
performs the semi-composition of \fIspec\fP with respect to the
LTS \fIinterface\fP and using a
synchronization set determined by the \fB-sync\fP option.
.P
The resulting LTS is stored in \fIresult\fP, in BCG format.
.P
The semantics of the semi-composition operator is given in
.B $CADP/doc/*/Krimm-Mounier-97.* 
and in Section \fBFORMAL DEFINITION OF SEMI-COMPOSITION\fP below.
.P
In a few words, \fBprojector\fP reduces the LTS
\fIspec\fP by suppressing the transitions that are not possible when
\fIspec\fP is synchronized with \fIinterface\fP, with respect to a
given synchronization set (see \fB-sync\fP option below). The way
transitions are suppressed depends on the nature of the interface. See
option \fB-userinterface\fP for details.

.SH OPTIONS

.TP
.I bcg_opt
if any, are passed to
.BR bcg_lib (LOCAL).
.TP
.I exp_opt
if any, are passed to
.BR exp.open (LOCAL).
.TP
.I fsp_opt
if any, are passed to
.BR fsp.open (LOCAL).
.TP
.I lnt_opt
if any, are passed to
.BR lnt.open (LOCAL).
.TP
.I lotos_opt
if any, are passed to
.BR caesar (LOCAL)
and
.BR caesar.adt (LOCAL).
.TP
.I seq_opt
if any, are passed to
.BR seq.open (LOCAL).
.TP
.I cc_opt
if any, are passed to the C compiler.
.P
The following options \fIprojector_opt\fP are currently available:

.TP
.B \-monitor
Open a window for monitoring in real-time the generation of \fIresult.bcg\fP.
This is not a default option.

.TP
\fB\-sync  [\-total|\-partial|\-gate]\fP \fIsync-file\fP
Use the synchronization rules defined in \fIsync-file\fP. The \fB-total\fP, \fB-partial\fP, and \fB-gate\fP options specify the "total matching", "partial matching", and "gate matching" semantics, respectively.
.sp
In "total matching" semantics, the regular expressions contained in 
\fIsync-file\fP denote full labels (i.e., gates possibly followed by experiment
offers). Each transition of \fIspec\fP carrying a label that matches some
rule in \fIsync-file\fP must be synchronized with a transition of 
\fIinterface\fP carrying the same label.
.sp
In "partial matching" semantics, the regular expressions contained in 
\fIsync-file\fP denote substrings of labels. Each transition of \fIspec\fP
carrying a label, a substring of which matches some rule in \fIsync-file\fP,
must be synchronized with a transition of \fIinterface\fP carrying the same
label.
.sp
At last, in "gate matching" semantics, the regular expressions contained in
\fIsync-file\fP denote gates. Each transition of \fIspec\fP carrying a label,
the first word of which (called gate) matches some rule in \fIsync-file\fP,
must be synchronized with a transition of \fIinterface\fP carrying the same
label.
In this case, regular expressions in the synchronization set should not
contain characters forbidden in gate identifiers (e.g., " ", "(", or "!").
.sp
Option \fB-total\fP is the default.

.TP
\fB\-hide [ \-total | \-partial | \-gate ]\fP \fIhiding_filename\fP
Use the hiding rules defined in \fIhiding_filename\fP to hide (on the fly)
the labels of the LTS being generated. See the
.BR caesar_hide_1 (LOCAL)
manual page for a detailed description of the appropriate format for
\fIhiding_filename\fP.
.sp
The \fB-total\fP, \fB-partial\fP, and \fB-gate\fP options specify the "total
matching", "partial matching", and "gate matching" semantics, respectively.
See the
.BR caesar_hide_1 (LOCAL)
manual page for more details about these semantics. Option
\fB-total\fP is the default.
.sp
Note that label hiding does not operate on \fIspec\fP, but on the LTS
resulting from the semi-composition of \fIspec\fP with respect to
\fIinterface\fP.\fBbcg\fP.

.TP
\fB\-rename [\-total|\-single|\-multiple|\-gate]\fP \fIrenaming_filename\fP

Use the renaming rules defined in \fIrenaming_filename\fP to rename (on the
fly) the labels of the LTS being generated. See the
.BR caesar_rename_1 (LOCAL)
manual page for a detailed description of the appropriate format for
\fIrenaming_filename\fP.
.sp
The \fB-total\fP, \fB-single\fP, \fB-multiple\fP, and \fB-gate\fP options
specify the "total matching", "single partial matching", "multiple partial
matching", and "gate matching" semantics, respectively. See the
.BR caesar_rename_1 (LOCAL)
manual page for more details about these semantics.  Option
\fB-total\fP is the default.
.sp
As for the
.BR bcg_labels (LOCAL)
tool, several hiding and/or renaming options can be present on the
command-line, in which case they are processed from left to right.
However, the semi-composition (synchronizations) is always performed before
hiding and/or renaming.
Note that hiding and renaming only affect the part of refused labels that follow the "fail: " string.
.sp
Note that label renaming does not operate on \fIspec\fP, but on the
LTS resulting from the semi-composition of \fIspec\fP with respect to
\fIinterface\fP.\fBbcg\fP.

.TP
.B \-userinterface | -interfaceuser
This option is used when \fIinterface\fP is a "user-given" interface, in 
which case \fBprojector\fP computes validation predicate in the form of
\fIrefused transitions\fP, in order to check the validity of this interface.
A refused transition is identified by its label, which begins with the
string "fail: ". Such a label may be present in \fIspec\fP, but not in
\fIinterface\fP. When
.BR \-userinterface
is specified, \fBprojector\fP may produce new refused transitions in
addition to those already existing in \fIspec\fP.

Note that this option does not make sense outside an entire compositional
generation process and it is mainly used by the
.B svl
tool. The validation predicates are checked by the
.B exp.open
tool, with \fB-interfaceuser\fP option.
This is not a default option.

.TP
.B -uncompress, -compress, -register, -short, -medium, -size
These options control the form under which the BCG graph 
\fIresult\fP\fB.bcg\fP is generated. See the
.BR bcg (LOCAL)
manual page for a description of these options.

.TP
.B -tmp
This option specifies the directory in which temporary files are to
be stored. See the
.BR bcg (LOCAL)
manual page for a description of this option.

.SH PROJECTOR USAGE

Even if \fBprojector\fP may be used by the command line described 
in the \fBSYNOPSIS\fP section, it is mainly used by
.BI svl (LOCAL)
with \fBsvl\fP script lines like:
.P
.nf
.cs 4 23
\fB"spec.lotos" -|| "interface.bcg"
"spec.lotos" -|[G1, G2]| "interface.bcg"
.cs 4
.cs I
.fi
.P

.SH FORMAT FOR INPUT LABELLED TRANSITION SYSTEMS

.P
The LTS expressed by
.I spec
does not have any restriction. In particular, it may contain refused
transitions (i.e., labels prefixed by the special marker "fail: ").

.P 
The LTS contained in 
.I interface
may not contain refused transitions. No other constraint is imposed
(for instance, it may have non deterministic transitions). 
.P 
Note: Minimizing \fIinterface\fP for safety equivalence after hiding all
labels that are not accepted by the synchronization set is likely to improve the
time and space performances of \fBprojector\fP, while not changing the
resulting LTS. In \fBsvl\fP, those two operations
are automatically performed before calling \fBprojector\fP.

.SH FORMAT FOR OUTPUT LABELLED TRANSITION SYSTEM

The resulting LTS (\fIresult\fP[\fB.bcg\fP])
may contain refused transitions. Such refused transitions form a loop
from one state to the same state with a label prefixed by "fail: ".

.SH FORMAT FOR SYNCHRONIZATION SETS

The description of the synchronization set is made through a
file, which must respect the following grammar:

.nf
.cs 4 23
\fB
<sync-set>        ::=  <positive-header> '\en' <label-list>
                   |   <negative-header> '\en' <label-list>
<label-list>      ::=  <label>
                   |   <label> '\en' <label-list>
<label>           ::=  <regexp-denoting-a-label>
<positive-header> ::=  'Sync' 
                   |   'sync'
<negative-header> ::=  'Sync all but'
                   |   'sync all but'
\fP
.cs 4
.fi
.P
If the header is a positive header, any label matching a regular
expression of the file will be considered as accepted by the
synchronization set. On the contrary, if the header is a negative
header, any label that does not match any regular expression of the file
will be considered as accepted by the synchronization set.

The synchronization set should not accept any label prefixed by
"fail: " if there is any in the graph module. The special label
"i" should not be accepted by the synchronization set. If it does, a
warning is issued but "i" is not synchronized.

When no synchronisation set is given, the synchronisation is performed
on all labels of \fIspec\fP and \fIinterface\fP, except the hidden label "i".

.SH FORMAL DEFINITION OF SEMI-COMPOSITION

.P
First of all, remind that an LTS is defined formally as a tuple (Q, A, T, q0), where Q is the set of states, A is a set of actions, T is the transition relation between states, and q0 is the initial state.
.P 
Let S1 and S2 be two LTSs, and SYNC be a set of labels (the synchronization set).
We write (S1 |[SYNC]| S2) the parallel composition of S1 and S2, using an extension of LOTOS parallel composition, where SYNC contains full labels instead of gates.
.P
The semi-composition (S1 -|[SYNC]| S2) is the LTS (Q, A, T, q0) defined as follows: 
.IP -
Q is the set of states p1 of S1 such that for some state p2 of S2, (p1, p2) is reachable in (S1 |[SYNC]| S2).
.IP -
T is the set of transitions (p1, a, q1) of S1 such that for some states p2, q2 of S2 there exists a transition ((p1, p2), a, (q1, q2)) in (S1 |[SYNC]| S2).
.IP -
q0 is the initial state of S1.

.SH FREQUENTLY ASKED QUESTIONS ABOUT SEMI-COMPOSITION

.P
In the sequel, we describe LTSs as sets of transitions of the form q -a-> q'.
The initial state will be generally noted q0, and sets of states and actions can be easily reconstructed from the transition relation.
.IP Q:
Does (S1 -|[SYNC]| S2) have always less states and transitions than S1?
.IP A:
Yes. One can see from the mathematical definition that (S1 -|[SYNC]| S2) cannot have more than the states and transitions of S1.
.IP Q:
If LTS S1 is minimal modulo an equivalence relation (e.g., strong, branching, etc.), will (S1 -|[SYNC]| S2) be also a minimal LTS?
.IP A:
No, as shows the following example. Take the minimal LTS S1 = {q0 -a-> q1, q0 -a-> q2, q1 -b-> q3}. The semi-composition (S1 -|[b]| S2), where S2 contains a unique state and no transition, results in {q0 -a-> q1, q0 -a-> q2}, which is not minimal (q1 and q2 are equivalent states).
.P
.IP Q:
Starting from an LTS S1, I made the following two experiments: 
(1) simply minimize S1;
(2) first restrict S1 by semi-composition and then minimize the result.
Amazingly the LTS obtained by experiment (2) was larger than that obtained by experiment (1). Is this normal?
.IP A:
Yes, this may happen, for instance, if semi-composition breaks some symmetry in S1.
Take S1 = {q0 -a-> q1, q1 -a-> q2, q2 -a-> q0}. 
Experiment (1), i.e., minimizing S1 yields S2 = {q0 -a-> q0}.
Experiment (2) using (S1 -|[a]| S3) with S3 =  {q0 -a-> q1, q1 -a-> q2} yields S3, which is minimal.
S3 is effectively larger than S2.
.IP Q:
Are standard equivalence relations congruences for the semi-composition operator.
.IP A:
No. Take LTSs S1, S2, and S3 defined in previous example. S1 and S2 are equivalent, but (S1 -|[a]| S3) (which is equal to S3) is not equivalent to (S2 -|[a]| S3) (which is equal to S2).
However, most equivalence relations (strong, branching, observational, tau*.a, safety) are semi-congruences for semi-composition, in the sense that minimizing the interface will not alter the result of semi-composition.

.SH EXIT STATUS
Exit status is 0 if everything is alright, 1 otherwise.

.SH DIAGNOSTICS
When the source is erroneous, error messages are issued.

.SH BIBLIOGRAPHY
.IP -
Jean-Pierre Krimm. Une Approche Pratique pour la V\*'erification 
Compositionnelle de Programmes LOTOS. M\*'emoire de Magist\*`ere, September
1996. (In French.)
.IP -
Jean-Pierre Krimm and Laurent Mounier. Compositional State Space Generation
from Lotos Programs. In Proceedings of TACAS'97, Tools and Algorithms
for the Construction and Analysis of Systems (University of Twente,
Enschede, The Netherlands), April 1997.
Available from http://cadp.inria.fr/publications/Krimm-Mounier-97.html
.IP -
Hubert Garavel. OPEN/CAESAR: An Open Software Architecture for Verification,
Simulation, and Testing. In Proceedings of the First
International Conference on Tools and Algorithms for the Construction
and Analysis of Systems TACAS'98, March 1998.
Available from http://cadp.inria.fr/publications/Garavel-98.html
.IP -
Hubert Garavel, Fr\*'ed\*'eric Lang. SVL: a Scripting Language for 
Compositional Verification. In Proceedings of the 21st IFIP WG 6.1
International Conference on Formal Techniques for Networked and
Distributed Systems FORTE'2001 (Cheju Island, Korea), August 2001.
Available from http://cadp.inria.fr/publications/Garavel-Lang-01.html

.SH AUTHORS
.P
Version 1.x of \fBprojector\fP was developped by Jean-Pierre
Krimm using an algorithm written by Laurent Mounier and himself
(VERIMAG).
.P
Version 2.x of \fBprojector\fP was totally rewritten from scratch
by Gordon Pace, Bruno Ondet, Nicolas Descoubes, and Frederic Lang (INRIA
Rhone-Alpes/VASY).
.P
Version 3.x of \fBprojector\fP was partially rewritten by Remi Herilier and
Frederic Lang (INRIA Rhone-Alpes/VASY).

.SH OPERANDS
.PD 0
.TP 18
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
.IB interface .bcg
interface LTS (input)
.TP
.IB sync-file .sync
set of synchronization labels (input)
.TP
.IB result .bcg 
BCG graph (output)
.PD
.P

.SH FILES

The binary code of \fBprojector\fP is available in
.B $CADP/bin.`arch`/projector.a
.P

.SH SEE ALSO
CAESAR Reference Manual, OPEN/CAESAR Reference Manual,
.BR bcg (LOCAL),
.BR bcg_open (LOCAL),
.BR caesar_hide_1 (LOCAL),
.BR caesar_rename_1 (LOCAL),
.BR caesar (LOCAL),
.BR caesar.adt (LOCAL),
.BR exp (LOCAL),
.BR exp.open (LOCAL),
.BR fsp.open (LOCAL),
.BR lnt.open (LOCAL),
.BR lotos (LOCAL),
.BR lotos.open (LOCAL),
.BR seq (LOCAL),
.BR seq.open (LOCAL),
.BR svl (LOCAL)

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
