.\" @(#)bisimulator.l - VASY and CONVECS teams - 2020/02/12
.TH BISIMULATOR LOCAL "2020/02/12" "(C) INRIA" "CADP MANUAL PAGES"
.fp 4 CB
.lg 0
.SH NAME
bisimulator \- on-the-fly equivalence/preorder checking

.SH SYNOPSIS
.B bcg_open
.RI [ bcg_opt ]
\fIlts1\fP[\fB.bcg\fP]
.RI [ cc_opt ]
.B bisimulator
.RI [ bisimulator_opt ]
\fIlts2\fP[\fB.bcg\fP]
.sp
or:
.sp
.B exp.open
.RI [ exp_opt ]
\fIlts1\fP[\fB.exp\fP]
.RI [ cc_opt ]
.B bisimulator
.RI [ bisimulator_opt ]
\fIlts2\fP[\fB.bcg\fP]
.sp
or:
.sp
.B fsp.open
.RI [ fsp_opt ]
\fIlts1\fP[\fB.lts\fP]
.RI [ cc_opt ]
.B bisimulator
.RI [ bisimulator_opt ]
\fIlts2\fP[\fB.bcg\fP]
.sp
or:
.sp
.B lnt.open
.RI [ lnt_opt ]
\fIlts1\fP[\fB.lnt\fP]
.RI [ cc_opt ]
.B bisimulator
.RI [ bisimulator_opt ]
\fIlts2\fP[\fB.bcg\fP]
.sp
or:
.sp
.B lotos.open
.RI [ lotos_opt ]
\fIlts1\fP[\fB.lotos\fP]
.RI [ cc_opt ]
.B bisimulator
.RI [ bisimulator_opt ]
\fIlts2\fP[\fB.bcg\fP]
.sp
or:
.sp
.B seq.open
.RI [ seq_opt ]
\fIlts1\fP[\fB.seq\fP]
.RI [ cc_opt ]
.B bisimulator
.RI [ bisimulator_opt ]
\fIlts2\fP[\fB.bcg\fP]

.SH DESCRIPTION
\fBbisimulator\fP takes as inputs two Labelled Transition Systems (LTSs),
the first one being represented either as 
a BCG graph \fIlts1\fP\fB.bcg\fP,
a composition expression \fIlts1\fP\fB.exp\fP, 
an FSP program \fIlts1\fP\fB.lts\fP,
an LNT program \fIlts1\fP\fB.lnt\fP,
a LOTOS program \fIlts1\fP\fB.lotos\fP, 
or a sequence file \fIlts1\fP\fB.seq\fP,
and the second one being represented as a BCG graph \fIlts2\fP\fB.bcg\fP.
Traditionally, \fIlts1\fP represents the behaviour of a \fIprotocol\fP and
\fIlts2\fP represents the behaviour of its \fIservice\fP.

.P
\fBbisimulator\fP performs an on-the-fly comparison of the two LTSs
\fIlts1\fP and \fIlts2\fP modulo a given equivalence/preorder relation (see
EQUIVALENCE RELATIONS below). The result of this verification (TRUE or FALSE)
is displayed on the standard output, possibly accompanied by a diagnostic
(see OPTIONS below).

.P
Note: The verification method underlying the current version of
\fBbisimulator\fP is based upon a translation of the equivalence/preorder
checking problem into the resolution of a Boolean Equation System (BES),
which is performed on-the-fly using the algorithms provided by the
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
The options \fIbisimulator_opt\fP currently available are described below.

.P
The options below specify the equivalence relation used for
comparing \fIlts1\fP and \fIlts2\fP.

.TP
.B \-branching
Use branching equivalence (resp. its corresponding preorder) as equivalence
(resp. preorder) relation for comparing \fIlts1\fP and \fIlts2\fP.
Not a default option.

.TP
.B \-observational
Use observational equivalence (resp. its corresponding preorder) as equivalence
(resp. preorder) relation for comparing \fIlts1\fP and \fIlts2\fP.
Not a default option.

.TP
.B \-safety
Use safety equivalence (resp. its corresponding preorder) as equivalence
(resp. preorder) relation for comparing \fIlts1\fP and \fIlts2\fP.
Not a default option.

.TP
.B \-strong
Use strong equivalence (resp. its corresponding preorder) as equivalence
(resp. preorder) relation for comparing \fIlts1\fP and \fIlts2\fP.
Default option.

.TP
.B \-taustar
Use \fItau\fP*.\fIa\fP equivalence (resp. its corresponding preorder) as
equivalence (resp. preorder) relation for comparing \fIlts1\fP and \fIlts2\fP.
Not a default option.

.TP
.B \-trace
Use trace equivalence (resp. its corresponding preorder) as equivalence
(resp. preorder) relation for comparing \fIlts1\fP and \fIlts2\fP.
Not a default option.

.TP
.B \-weaktrace
Use weak trace equivalence (resp. its corresponding preorder) as equivalence
(resp. preorder) relation for comparing \fIlts1\fP and \fIlts2\fP.
Not a default option.

.P
The options below specify the kind of comparison between \fIlts1\fP and \fIlts2\fP.

.TP
.B \-smaller
Check whether \fIlts1\fP is included in \fIlts2\fP modulo the preorder
corresponding to the equivalence relation considered (if the two LTSs are
equivalent, they are also included one into the other modulo the corresponding
preorder). Not a default option.

.TP
.B \-equal
Check whether \fIlts1\fP is equivalent to \fIlts2\fP modulo the
equivalence relation considered. Default option.

.TP
.B \-greater
Check whether \fIlts2\fP is included in \fIlts1\fP modulo the preorder
corresponding to the equivalence relation considered (if the two LTSs are
equivalent, they are also included one into the other modulo the corresponding
preorder). Not a default option.

.P
The options below specify the algorithm used for
comparing \fIlts1\fP and \fIlts2\fP.

.TP
.B \-bfs
Compare \fIlts1\fP and \fIlts2\fP using a breadth-first search
algorithm. Compared to \fB-dfs\fP, this option is generally slower, but
produces counterexamples of smaller depth. Not a default option.

.TP
.B \-dfs
Compare \fIlts1\fP and \fIlts2\fP using a depth-first search
algorithm. Compared to \fB-bfs\fP, this option produces counterexamples
of greater depth, but is generally faster and consumes less memory
if \fIlts2\fP is deterministic (for strong equivalence) and has no
invisible actions (for weak equivalences). Default option.

.P
The options below specify various features available in addition to the
comparison of \fIlts1\fP and \fIlts2\fP.

.TP
\fB-bes\fP [ \fIfile\fP[\fB.bes\fP[\fI.ext\fP]] ]
Print in \fIfile\fP[\fB.bes\fP] or, if the file name argument is missing,
in file \fBbisimulator.bes\fP, a textual description of the BES
corresponding to the comparison of \fIlts1\fP and \fIlts2\fP modulo
the equivalence/preorder relation considered.
If present, the extension \fI.ext\fP must correspond to a known file
compression format (e.g., \fI.Z\fP, \fI.gz\fP, \fI.bz2\fP, etc.).
In this case, the file containing the BES is compressed according to
the corresponding format.
The list of currently supported extensions and compression formats is
given by the
.B $CADP/src/com/cadp_zip
shell-script.
This option does not influence the comparison between the two LTSs.
Not a default option.

.TP
\fB-diag\fP [ \fB-minimal\fP ] [ \fIdiag\fP[\fB.bcg\fP] ]
When the comparison of \fIlts1\fP and \fIlts2\fP yields FALSE, generate
a diagnostic (counterexample) in BCG format (see the
.BR bcg (LOCAL)
manual page for details) explaining this result. The diagnostic is generated
in the file \fIdiag\fP.\fBbcg\fP or, if the file name argument is missing, in
file \fBbisimulator.bcg\fP. This option has no effect when the comparison
of \fIlts1\fP and \fIlts2\fP yields TRUE, since in this case the diagnostic
would be larger than \fIlts1\fP and \fIlts2\fP, and would not bring any useful
information. The BCG file containing the diagnostic can be visualized using the
.BR bcg_draw (LOCAL)
and
.BR bcg_edit (LOCAL)
tools of CADP (see respective manual pages for details).
.sp
The diagnostic is a directed acyclic graph included (modulo the preorder
corresponding to the equivalence relation considered) both in \fIlts1\fP and
\fIlts2\fP. Each state \fIp\fP of the diagnostic corresponds to a couple
of states (\fIq\fP, \fIr\fP) belonging to \fIlts1\fP and \fIlts2\fP,
respectively; the portion of diagnostic going out of \fIp\fP illustrates
why the two corresponding states \fIq\fP and \fIr\fP are not equivalent.
The terminal states of the diagnostic have additional "error" outgoing
transitions with labels of the form "Present in lts2.bcg: \fIb\fP" or
"Absent in lts2.bcg: \fIb\fP", indicating that the action \fIb\fP does not
occur either in \fIlts1\fP, or in \fIlts2\fP, respectively (\fIb\fP can be
either a visible action, or the invisible action \fItau\fP, see EQUIVALENCE
RELATIONS below for naming conventions). Intuitively, all transition
sequences contained in the diagnostic lead, when executed simultaneously
in \fIlts1\fP and \fIlts2\fP, to states which are unrelated modulo the
equivalence/preorder relation considered. Note that for weak equivalences,
any transition \fIp1\fP--\fIb\fP-->\fIp2\fP in the diagnostic may
correspond to sequences of the form \fIq1\fP--\fItau\fP*.\fIb\fP-->\fIq2\fP
and \fIr1\fP--\fItau\fP*.\fIb\fP-->\fIr2\fP contained in \fIlts1\fP and
\fIlts2\fP, respectively. Also, any transition \fIp1\fP--\fItau\fP-->\fIp2\fP
in the diagnostic may correspond to a sequence \fIq1\fP--\fItau\fP-->\fIq2\fP
contained in \fIlts1\fP and possibly to a sequence
\fIr1\fP--\fItau\fP*-->\fIr2\fP contained in \fIlts2\fP, or vice-versa.
.sp
In the case of branching equivalence, the diagnostic may also contain
some transitions of the form \fIp1\fP--\fIb\fP-->\fIp2\fP leading to
sink states. Considering that \fIp1\fP corresponds to the couple of states
(\fIq1\fP, \fIr1\fP), such a transition indicates the existence of two
sequences of the form \fIq1\fP--\fItau\fP*-->\fIq2\fP--\fIb\fP-->\fIq3\fP
and \fIr1\fP--\fItau\fP*-->\fIr2\fP--\fIb\fP-->\fIr3\fP in \fIlts1\fP and
\fIlts2\fP, respectively, such that the states \fIq2\fP and \fIr2\fP are
not branching equivalent. For each transition \fIp1\fP--\fIb\fP-->\fIp2\fP
leading to a sink state in the diagnostic, the remainder of the diagnostic
going out of \fIp1\fP illustrates the non equivalence of the states
\fIq2\fP and \fIr2\fP.
This specific handling of branching equivalence is due to the nature of this
relation, which (at the opposite of other relations, such as strong,
observational, \fItau\fP*.\fIa\fP, and safety) requires that not only the
target states of transitions, but also their source states are equivalent.
.sp
If the additional option \fB-minimal\fP is specified, a small-depth diagnostic
is generated (the depth is guaranteed to be minimal only when the diagnostic
is a tree).
.sp
If the diagnostic is a sequence of transitions, it will also be displayed
on standard output using the SEQ format (see the
.BR seq (LOCAL)
manual page for the definition of this format). Not a default option.

.TP
.B \-stat
Display statistical information about the resolution of the BES
corresponding to the comparison of \fIlts1\fP and \fIlts2\fP modulo
the equivalence/preorder relation considered. Not a default option.

.TP
.B \-tauconfluence
Reduce \fIlts1\fP on-the-fly modulo tau-confluence (a form of partial
order reduction that preserves branching equivalence) while performing
the comparison with \fIlts2\fP. This option can be used only in conjunction
with options \fB-branching\fP and \fB-observational\fP, and in some cases
it may improve speed and memory consumption significantly.
Not a default option.

.SH EQUIVALENCE RELATIONS
An LTS is a quadruple \fIM\fP = (\fIQ\fP, \fIA\fP, \fIT\fP, \fIq0\fP),
where: \fIQ\fP is the set of \fIstates\fP, \fIA\fP is the set of \fIactions\fP
(transition labels), \fIT\fP included in \fIQ\fP * \fIA\fP * \fIQ\fP is
the \fItransition relation\fP, and \fIq0\fP is the \fIinitial state\fP.
The set \fIA\fP contains the invisible action \fItau\fP, which denotes
internal (unobservable) activity. A transition (\fIp\fP, \fIa\fP, \fIq\fP)
in \fIT\fP (also noted \fIp\fP--\fIa\fP-->\fIq\fP)
means that the system can evolve from state \fIp\fP to state \fIq\fP by
performing action \fIa\fP. If \fIL\fP is a language included in \fIA\fP*,
then \fIp\fP--\fIL\fP-->\fIq\fP denotes a transition
sequence \fIp\fP--\fIa1\fP-->\fIq2\fP--\fIa2\fP-->...--\fIan\fP-->\fIq\fP
such that the word \fIa1\fP\fIa2\fP...\fIan\fP belongs to \fIL\fP.
All states \fIq\fP of \fIQ\fP are assumed to be reachable from the initial
state \fIq0\fP via sequences of transitions in \fIT\fP
(i.e., \fIq0\fP--\fIA\fP*-->\fIq\fP). In the sequel, visible actions
of \fIA\fP are denoted by \fIa\fP, and (both visible and invisible) actions
of \fIA\fP are denoted by \fIb\fP. The transitive and reflexive closure
of \fIT\fP is denoted by \fIT\fP*.

.P
Two LTSs \fIM1\fP = (\fIQ1\fP, \fIA\fP, \fIT1\fP, \fIq01\fP)
and \fIM2\fP = (\fIQ2\fP, \fIA\fP, \fIT2\fP, \fIq02\fP) are related
modulo an equivalence relation \fIR\fP (noted \fIM1\fP \fIR\fP \fIM2\fP)
if and only if their initial states are related modulo \fIR\fP
(noted \fIq01\fP \fIR\fP \fIq02\fP). The equivalence relations currently
supported by \fBbisimulator\fP are defined below.
For each equivalence \fIR_equ\fP, the corresponding preorder relation
\fII_equ\fP, which indicates whether a state \fIp\fP is ``simulated'' by
a state \fIq\fP (resp. \fIq\fP is ``simulated'' by \fIp\fP) is obtained by
keeping only condition 1 (resp. 2) in the definition of \fIR_equ\fP.

.TP
.B Strong equivalence [Par81]
This is the largest relation \fIR_str\fP such that
two states \fIp\fP and \fIq\fP are related modulo strong equivalence
(\fIp\fP \fIR_str\fP \fIq\fP) if and only if:
.IP
1. for each transition \fIp\fP--\fIb\fP-->\fIp'\fP in \fIT1\fP
   there is a transition \fIq\fP--\fIb\fP-->\fIq'\fP in \fIT2\fP
   such that \fIp'\fP \fIR_str\fP \fIq'\fP
.IP
2. for each transition \fIq\fP--\fIb\fP-->\fIq'\fP in \fIT2\fP
   there is a transition \fIp\fP--\fIb\fP-->\fIp'\fP in \fIT1\fP
   such that \fIp'\fP \fIR_str\fP \fIq'\fP

.TP
.B Branching equivalence [GW89]
This is the largest relation \fIR_bra\fP such that
two states \fIp\fP and \fIq\fP are related modulo branching equivalence
(\fIp\fP \fIR_bra\fP \fIq\fP) if and only if:
.IP
1. for each transition \fIp\fP--\fIb\fP-->\fIp'\fP in \fIT1\fP
   a. either \fIb\fP = \fItau\fP and \fIp'\fP \fIR_bra\fP \fIq\fP, or
   b. there is a sequence \fIq\fP--\fItau\fP*-->\fIq'\fP--\fIb\fP-->\fIq''\fP in \fIT2\fP*
      such that \fIp\fP \fIR_bra\fP \fIq'\fP and \fIp'\fP \fIR_bra\fP \fIq''\fP
.IP
2. for each transition \fIq\fP--\fIb\fP-->\fIq'\fP in \fIT2\fP
   a. either \fIb\fP = \fItau\fP and \fIp\fP \fIR_bra\fP \fIq'\fP, or
   b. there is a sequence \fIp\fP--\fItau\fP*-->\fIp'\fP--\fIb\fP-->\fIp''\fP in \fIT1\fP*
      such that \fIp'\fP \fIR_bra\fP \fIq\fP and \fIp''\fP \fIR_bra\fP \fIq'\fP

.TP
.B Observational equivalence [Mil89]
This is the largest relation \fIR_obs\fP such that
two states \fIp\fP and \fIq\fP are related modulo observational equivalence
(\fIp\fP \fIR_obs\fP \fIq\fP) if and only if:
.IP
1. a. for each transition \fIp\fP--\fItau\fP-->\fIp'\fP in \fIT1\fP
      there is a sequence \fIq\fP--\fItau\fP*-->\fIq'\fP in \fIT2\fP*
      such that \fIp'\fP \fIR_obs\fP \fIq'\fP
   b. for each transition \fIp\fP--\fIa\fP-->\fIp'\fP in \fIT1\fP
      there is a sequence \fIq\fP--\fItau\fP*.\fIa\fP.\fItau\fP*-->\fIq'\fP in \fIT2\fP*
      such that \fIp'\fP \fIR_obs\fP \fIq'\fP
.IP
2. a. for each transition \fIq\fP--\fItau\fP-->\fIq'\fP in \fIT2\fP
      there is a sequence \fIp\fP--\fItau\fP*-->\fIp'\fP in \fIT1\fP*
      such that \fIp'\fP \fIR_obs\fP \fIq'\fP
   b. for each transition \fIq\fP--\fIa\fP-->\fIq'\fP in \fIT2\fP
      there is a sequence \fIp\fP--\fItau\fP*.\fIa\fP.\fItau\fP*-->\fIp'\fP in \fIT1\fP*
      such that \fIp'\fP \fIR_obs\fP \fIq'\fP

.TP
.B Tau*.a equivalence [FM91]
This is the largest relation \fIR_tau\fP such that
two states \fIp\fP and \fIq\fP are related modulo \fItau\fP*.\fIa\fP equivalence
(\fIp\fP \fIR_tau\fP \fIq\fP) if and only if:
.IP
1. for each sequence \fIp\fP--\fItau\fP*.\fIa\fP-->\fIp'\fP in \fIT1\fP*
   there is a sequence \fIq\fP--\fItau\fP*.\fIa\fP-->\fIq'\fP in \fIT2\fP*
   such that \fIp'\fP \fIR_tau\fP \fIq'\fP
.IP
2. for each transition \fIq\fP--\fItau\fP*.\fIa\fP-->\fIq'\fP in \fIT2\fP*
   there is a sequence \fIp\fP--\fItau\fP*.\fIa\fP-->\fIp'\fP in \fIT1\fP*
   such that \fIp'\fP \fIR_tau\fP \fIq'\fP

.TP
.B Safety equivalence [BFG+91]
This is the largest relation \fIR_saf\fP such that
two states \fIp\fP and \fIq\fP are related modulo safety equivalence
(\fIp\fP \fIR_saf\fP \fIq\fP) if and only if:
.IP
1. \fIp\fP \fII_tau\fP \fIq\fP
.IP
2. \fIq\fP \fII_tau\fP \fIp\fP
.sp
Safety equivalence is defined in terms of the \fItau\fP*.\fIa\fP
preorder \fII_tau\fP. It is a \fIsimulation equivalence\fP rather than
a \fIbisimulation\fP (e.g., like \fItau\fP*.\fIa\fP equivalence), because
it only requires that states \fIp\fP and \fIq\fP are included one into the
other modulo \fII_tau\fP, and does not require that each
\fItau\fP*.\fIa\fP-successor of \fIp\fP (resp. \fIq\fP) is equivalent to
a corresponding \fItau\fP*.\fIa\fP-successor of \fIq\fP (resp. \fIp\fP).
Therefore, safety equivalence is weaker than \fItau\fP*.\fIa\fP equivalence
(see the note below), but it has the same associated preorder
(i.e., \fII_saf\fP = \fII_tau\fP).

.TP
.B Trace equivalence (a.k.a. language equivalence)
This is the largest relation \fIR_tra\fP such that
two states \fIp\fP and \fIq\fP are related modulo trace equivalence
(\fIp\fP \fIR_tra\fP \fIq\fP) if and only if:
.IP
1. for each sequence \fIp\fP--\fIb1\fP...\fIbn\fP-->\fIp'\fP in \fIT1\fP*
   there is a sequence \fIq\fP--\fIb1\fP...\fIbn\fP-->\fIq'\fP in \fIT2\fP*
.IP
2. for each sequence \fIq\fP--\fIb1\fP...\fIbn\fP-->\fIq'\fP in \fIT2\fP*
   there is a sequence \fIp\fP--\fIb1\fP...\fIbn\fP-->\fIp'\fP in \fIT1\fP*

.TP
.B Weak trace equivalence [BHR84]
Two states \fIp\fP and \fIq\fP are related modulo weak trace equivalence
(\fIp\fP \fIR_wtr\fP \fIq\fP) if and only if:
.IP
1. for each sequence \fIp\fP--\fItau\fP*.\fIa1\fP...\fItau\fP*.\fIan\fP-->\fIp'\fP in \fIT1\fP*
   there is a sequence \fIq\fP--\fItau\fP*.\fIa1\fP...\fItau\fP*.\fIan\fP-->\fIq'\fP in \fIT2\fP*
.IP
2. for each sequence \fIq\fP--\fItau\fP*.\fIa1\fP...\fItau\fP*.\fIan\fP-->\fIq'\fP in \fIT2\fP*
   there is a sequence \fIp\fP--\fItau\fP*.\fIa1\fP...\fItau\fP*.\fIan\fP-->\fIp'\fP in \fIT1\fP*

.P
Note: A relation \fIR1\fP is said to be \fIstronger\fP than another
relation \fIR2\fP (noted \fIR1\fP <= \fIR2\fP) iff \fIp\fP \fIR1\fP \fIq\fP
implies \fIp\fP \fIR2\fP \fIq\fP for any states \fIp\fP, \fIq\fP.
The relations above are ordered w.r.t. their strength as follows:
.IP
\fIR_str\fP <= \fIR_bra\fP <= \fIR_obs\fP <= \fIR_saf\fP <= \fIR_wtr\fP
.IP
\fIR_str\fP <= \fIR_tra\fP <= \fIR_wtr\fP
.IP
\fIR_bra\fP <= \fIR_tau\fP <= \fIR_saf\fP
.P
As opposed to \fIR_str\fP and \fIR_tra\fP (the strong and trace equivalences),
which handle all transition labels in the same way, the relations \fIR_bra\fP,
\fIR_obs\fP, \fIR_tau\fP, \fIR_saf\fP, and \fIR_wtr\fP are called \fIweak\fP
equivalences, since each of them performs a kind of abstraction over invisible
actions.

.P
Note: To obtain maximal performance, it is recommended to put the ``bigger''
LTS (the protocol) in argument \fIlts1\fP and the ``smaller'' LTS
(the service) in argument \fIlts2\fP. In addition, the service LTS
\fIlts2\fP can be minimized before comparison, either modulo strong
equivalence (when strong equivalence is considered for comparing \fIlts1\fP
and \fIlts2\fP), or modulo branching equivalence (if a weak equivalence is
considered) using the
.BR bcg_min (LOCAL)
tool of CADP (see the corresponding manual page for details). This
restriction will be eliminated in a future version of \fBbisimulator\fP.

.SH EXIT STATUS
Exit status is 0 if everything is alright, 1 otherwise.

.SH BIBLIOGRAPHY

.TP
[BHR84]
S. D. Brookes, C. A. R. Hoare, and A. W. Roscoe.
A Theory of Communicating Sequential Processes.
Journal of the ACM 31(3):560-599, July 1984.

.TP
[BDJ+05]
D. Bergamini, N. Descoubes, C. Joubert, and R. Mateescu.
BISIMULATOR: A Modular Tool for On-the-Fly Equivalence Checking.
In N. Halbwachs and L. Zuck (Eds.), Proceedings of the 11th International
Conference on Tools and Algorithms for the Construction and Analysis of
Systems TACAS'2005 (Edinburgh, Scotland, UK), Lecture Notes in Computer
Science vol. 3440, p. 581-585. Springer Verlag, April 2005. Available from
http://cadp.inria.fr/publications/Bergamini-Descoubes-Joubert-Mateescu-05.html

.TP
[BFG+91]
A. Bouajjani, J-C. Fernandez, S. Graf, C. Rodriguez, and J. Sifakis.
Safety for Branching Time Semantics.
In Proceedings of 18th ICALP. Springer Verlag, July 1991.

.TP
[FM91]
J-C. Fernandez and L. Mounier.
``On the Fly'' Verification of Behavioural Equivalences and Preorders.
In K. G. Larsen and A. Skou (Eds.), Proceedings of the 3rd Workshop on
Computer-Aided Verification CAV'91 (Aalborg, Denmark), Lecture Notes in
Computer Science vol. 575. Springer Verlag, July 1991.

.TP
[GW89]
R. J. van Glabbeek and W. P. Weijland.
Branching-Time and Abstraction in Bisimulation Semantics.
In Proceedings of the IFIP 11th World Computer Congress
(San Francisco, USA), 1989.

.TP
[Mat06]
R. Mateescu.
CAESAR_SOLVE: A Generic Library for On-the-Fly Resolution of
Alternation-Free Boolean Equation Systems.
Springer International Journal on Software Tools for Technology Transfer
(STTT), 8(1):37-56, 2006. Full version available as INRIA
Research Report RR-5948. Available from
http://cadp.inria.fr/publications/Mateescu-06-a.html

.TP
[Mil89]
R. Milner.
Communication and Concurrency.
Prentice-Hall, 1989.

.TP
[Par81]
D. Park.
Concurrency and Automata on Infinite Sequences.
In Peter Deussen (Ed.), Theoretical Computer Science,
Lecture Notes in Computer Science vol. 104, p. 167-183.
Springer Verlag, March 1981.

.SH AUTHORS
Radu Mateescu, with the help of Damien Bergamini (both at INRIA/VASY),
who implemented a first version of the encoding of branching equivalence
in terms of boolean equation systems.

.SH OPERANDS
.PD 0
.TP 20
.IB lts1 .bcg
BCG graph (input)
.TP
.IB lts1 .exp
network of communicating LTSs (input)
.TP
.IB lts1 .lts
FSP specification (input)
.TP
.IB lts1 .lnt
LNT specification (input)
.TP
.IB lts1 .lotos
LOTOS specification (input)
.TP
.IB lts1 .seq
sequence file (input)
.TP
.IB lts2 .bcg
BCG graph (input)
.TP
.IB diag .bcg
diagnostic in BCG format (output)
.TP
.IB file .bes
BES in textual format (output)

.PD
.SH FILES
The binary code of \fBbisimulator\fP is available in
$CADP/bin.`arch`/bisimulator.a

.SH SEE ALSO
.BR bcg (LOCAL),
.BR bcg_open (LOCAL),
.BR exp (LOCAL),
.BR exp.open (LOCAL),
.BR fsp.open (LOCAL),
.BR lnt.open (LOCAL),
.BR lotos.open (LOCAL),
.BR seq (LOCAL),
.BR seq.open (LOCAL)
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
Please report bugs to Radu.Mateescu@inria.fr

