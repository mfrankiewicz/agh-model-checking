'\" t
.\" @(#)reductor.l - VASY and CONVECS teams - 2020/02/12
.TH REDUCTOR LOCAL "2020/02/12" "(C) INRIA" "CADP MANUAL PAGES"
.fp 4 CB
.lg 0

.SH NAME
reductor \- BCG graph generation using reachability analysis combined
with on-the-fly reduction

.SH SYNOPSIS
.B bcg_open
.RI [ bcg_opt ]
\fIspec\fP[\fB.bcg\fP]
.RI [ cc_opt ]
.B reductor
.RI [ reductor_opt ]
\fIresult\fP[\fB.bcg\fP]
.P
or:
.P
.B exp.open
[\fIexp_opt\fP]
\fIspec\fP[\fB.exp\fP] 
.RI [ cc_opt ]
.B reductor
.RI [ reductor_opt ]
\fIresult\fP[\fB.bcg\fP]
.P
or:
.P
.B fsp.open
[\fIfsp_opt\fP]
\fIspec\fP[\fB.lts\fP]
.RI [ cc_opt ]
.B reductor
.RI [ reductor_opt ]
\fIresult\fP[\fB.bcg\fP]
.P
or:
.P
.B lnt.open
[\fIlnt_opt\fP]
\fIspec\fP[\fB.lnt\fP]
.RI [ cc_opt ]
.B reductor
.RI [ reductor_opt ]
\fIresult\fP[\fB.bcg\fP]
.P
or:
.P
.B lotos.open
[\fIlotos_opt\fP]
\fIspec\fP[\fB.lotos\fP]
.RI [ cc_opt ]
.B reductor
.RI [ reductor_opt ]
\fIresult\fP[\fB.bcg\fP]
.P 
or:
.P
.B seq.open
[\fIseq_opt\fP]
\fIspec\fP[\fB.seq\fP]
.RI [ cc_opt ]
.B reductor
.RI [ reductor_opt ]
\fIresult\fP[\fB.bcg\fP]

.SH DESCRIPTION
This program performs exhaustive reachability analysis and generates the 
Labelled Transition System corresponding to
the BCG graph \fIspec\fP\fB.bcg\fP,
the composition expression \fIspec\fP\fB.exp\fP,
the FSP program \fIspec\fP\fB.lts\fP,
the LNT program \fIspec\fP\fB.lnt\fP,
the LOTOS program \fIspec\fP\fB.lotos\fP,
or the sequence file \fIspec\fP\fB.seq\fP.
.P
During the generation, this Labelled Transition System is reduced
on-the-fly with respect to a relation chosen among strong equivalence,
tau-divergence, tau-compression, tau-confluence, tau*.a equivalence, safety
equivalence, trace equivalence, or weak trace equivalence.
The resulting Labelled Transition System is encoded in the BCG format and
stored into file \fIresult\fP\fB.bcg\fP.
.P
For most of the above relations, the \fBreductor\fP tool allows two levels
of reduction:
.IP -
\fIPartial reduction\fP just compresses, cuts, or merges transitions
of \fIspec\fP in a way that preserves the given relation. In general, partial
reduction does not yield a minimal Labelled Transition System.
.IP -
\fITotal reduction\fP additionally merges on-the-fly all strongly bisimilar
states of the partially reduced Labelled Transition System into a unique
representative state. Total reduction thus yields a Labelled Transition
System that is minimal modulo strong bisimulation. In general, total reduction
does not necessarily yield a Labelled Transition System that is minimal modulo 
the chosen relation, except in some cases such as tau*.a and safety
equivalences.
.P
By default, \fBreductor\fP performs only partial reduction. Total reduction
can be done using the \fB-total\fP option (see OPTIONS below).
.P
.ne 8v
Note: The eight relations implemented in \fBreductor\fP are partially
ordered from the strongest (strong bisimulation) to the weakest (weak
trace equivalence) as follows. We include branching bisimulation and
observational equivalence in this picture, although they are not
implemented in \fBreductor\fP.
.nf
.cs R 23


                         strong
                            |
                      +-----+-----+
                      |           |
                      |     tau-divergence
                      |           |
                      |     tau-compression
                      |           |
                      |     tau-confluence
                      |           |
                    trace    (branching)
                      |           |
                      |      +----+----+
                      |      |         |
                      |   tau*.a (observational)
                      |      |         |
                      |      +----+----+
                      |           |
                      |        safety
                      |           |
                      +-----+-----+
                            |
                        weak trace
.cs R
.fi
.P
Note: The above order shows that branching bisimulation (and weaker relations)
is preserved by tau-divergence, tau-compression, and tau-confluence. Although
branching bisimulation is not implemented in \fBreductor\fP, tau-divergence, 
tau-compression and tau-confluence can thus be used as preprocessing steps
for branching bisimulation minimization, which itself can be done using
.BR bcg_min (LOCAL).
.P
Note: The tau-divergence, tau-compression, and tau-confluence reductions
remove some of the internal transitions, and the tau*.a, safety, and weak
trace reductions remove all internal transitions present in the Labelled
Transition System. These transitions are usually called tau-transitions in
the literature, and are displayed as the character string "i" by the various
BCG tools.
.P
Note: Although they reduce the number of states and they eliminate 
all tau-transitions, the tau*.a and safety reductions may increase
the total number of transitions. The weak trace reduction may even increase
the total number of states as it determinizes the Labelled Transition System.

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
The options \fIreductor_opt\fP currently available are described below.
.P
The options below specify the equivalence relation used for reducing (partially or totally) \fIspec\fP.
.TP
.B -safety
Generate in \fIresult\fP\fB.bcg\fP a Labelled Transition System (partially
or totally) reduced modulo safety equivalence [BFG+91]. Partial safety 
reduction both eliminates the tau-transitions and cuts the \fIredundant\fP
transitions (as defined in [Mou92]) of \fIspec\fP. See also the
.BR bisimulator (LOCAL)
manual page for a formal definition of safety equivalence. Not a default
option.

.TP
.B -strong
Generate in \fIresult\fP\fB.bcg\fP a Labelled Transition System (partially
or totally) reduced modulo strong equivalence [Par81]. Partial strong 
reduction replaces duplicate transitions (i.e., transitions with same source
state, target state, and label) by a single transition. See also the
.BR bisimulator (LOCAL)
manual page for a formal definition of strong bisimulation. Not a default
option.

.TP
\fB-taucompression\fP
Generate in \fIresult\fP\fB.bcg\fP a Labelled Transition System (partially
or totally) reduced modulo tau-compression. Partial tau-compression reduction
eliminates all strongly connected components of tau-transitions.
.sp
Partial tau-compression reduction is usually fast (linear in the size of the
Labelled Transition System). Tau-compression reduction preserves branching
bisimulation. Not a default option.

.TP
.B -tauconfluence
Generate in \fIresult\fP\fB.bcg\fP a Labelled Transition System (partially
or totally) reduced modulo tau-confluence [PLM03], which is a partial order
reduction preserving branching bisimulation. Tau-confluence subsumes
tau-compression, thus leading to potentially stronger reductions, but it can
be slower. Not a default option.

.TP
.B -taudivergence
Generate in \fIresult\fP\fB.bcg\fP a Labelled Transition System (partially
or totally) reduced modulo tau-divergence. Partial tau-divergence reduction
replaces each strongly connected component of tau-transitions by a
self-looping tau-transition.
.sp
Partial tau-divergence reduction is usually fast (linear in the size of the
Labelled Transition System). Tau-divergence reduction preserves both branching
bisimulation and the livelocks of \fIspec\fP.

.TP
.B -taustar
Generate in \fIresult\fP\fB.bcg\fP a Labelled Transition System reduced
modulo tau*.a equivalence [FM91]. Partial tau*.a reduction eliminates the
tau-transitions of \fIspec\fP. See also the
.BR bisimulator (LOCAL)
manual page for a formal definition of tau*.a equivalence. Default option
(for backward compatibility with versions 1.* to 3.* of \fBreductor\fP).

.TP
.B -trace
Generate in \fIresult\fP\fB.bcg\fP a Labelled Transition System reduced
modulo trace equivalence. Partial trace reduction determinizes \fIspec\fP
using a classical automata determinization algorithm, see section ABOUT
TRACE AND WEAK TRACE EQUIVALENCES below for more details. This option is 
not compatible with \fB-total\fP. Not a default option.

.TP
.B -weaktrace
Generate in \fIresult\fP\fB.bcg\fP a Labelled Transition System reduced
modulo weak trace equivalence. Partial weak trace reduction eliminates the
tau-transitions of \fIspec\fP and determinizes it using a classical automata
determinization algorithm, see section TRACE AND WEAK TRACE EQUIVALENCES
below for more details. This option is not compatible with \fB-total\fP. 
Not a default option.

.P
The options below specify the kind of reduction of \fIspec\fP.
.TP
.B -partial
Perform partial reduction. Default option.

.TP
\fB-total\fP [ \fB-class\fP ]
Perform total reduction instead of partial reduction. The Labelled Transition
System generated in \fIresult\fP\fB.bcg\fP is thus both partially reduced
for the chosen relation and minimized modulo strong bisimulation.
.sp
If the \fB-class\fP option is set, display the classes of strongly bisimilar
states of the partially reduced Labelled Transition System on standard output.
Not a default option.
.sp
Note: Although it yields generally smaller Labelled Transition Systems, the 
\fB-total\fP option often slowers the generation. 

.P
The options below specify various features available in addition to the reduction of \fIspec\fP.

.TP
.B -monitor
Open a window for monitoring in real-time the generation of 
\fIresult\fP\fB.bcg\fP.

.TP
\fB\-hide [ \-total | \-partial | \-gate ]\fP \fIhiding_filename\fP
Use the hiding rules defined in \fIhiding_filename\fP to hide (on the fly)
the labels of the Labelled Transition System being generated. See the
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
Note that label hiding does not operate on \fIspec\fP, but on the Labeled
Transition System resulting from the reduction of \fIspec\fP. As a
consequence, \fIresult\fP.\fBbcg\fP may be not minimal with respect to 
the chosen relation. 

.TP
\fB\-rename [\-total|\-single|\-multiple|\-gate]\fP \fIrenaming_filename\fP
Use the renaming rules defined in \fIrenaming_filename\fP to rename (on the
fly) the labels of the Labelled Transition System being generated. See the
.BR caesar_rename_1 (LOCAL)
manual page for a detailed description of the appropriate format for
\fIrenaming_filename\fP.
.sp
The \fB-total\fP, \fB-single\fP, \fB-multiple\fP, and \fB-gate\fP options
specify the "total matching", "single partial matching", "multiple partial
matching", and "gate matching" semantics, respectively. See the
.BR caesar_rename_1 (LOCAL)
manual page for more details about these semantics. Option
\fB-total\fP is the default.
.sp
Note that label renaming does not operate on \fIspec\fP, but on the
Labeled Transition System resulting from the reduction of \fIspec\fP. As a
consequence, \fIresult\fP.\fBbcg\fP may be not minimal with respect to the
chosen relation.

.sp
As for the
.BR bcg_labels (LOCAL)
tool, several hiding and/or renaming options can be present on the
command-line, in which case they are processed from left to right.

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

.SH ABOUT TRACE AND WEAK TRACE EQUIVALENCES

The algorithm used to reduce \fIspec\fP modulo trace and weak trace
equivalences is the classical "subset construction" algorithm used to
determinize finite automata [ASU86].
Each state \fIS\fP of \fIresult\fP\fB.bcg\fP corresponds to a set of 
states {\fIs1\fP, ..., \fIsn\fP} belonging to the input Labelled
Transition System \fIspec\fP.
.P
Starting from the initial state of \fIresult\fP\fB.bcg\fP, which is
the singleton set containing the initial state of \fIspec\fP, the
transitions going out of each state \fIS\fP of \fIresult\fP\fB.bcg\fP are
computed as follows:

.IP -
In case of trace reduction, for each label \fIL\fP, 
there exists a transition \fIS\fP--\fIL\fP-->\fIS'\fP if and only if the set
\fIS'\fP = { \fIs'\fP | exists \fIs\fP in \fIS\fP such that \fIs\fP--\fIL\fP-->\fIs'\fP }
is not empty.
.sp
In this case, \fIresult\fP\fB.bcg\fP is a deterministic Labelled Transition
System, which is trace equivalent to \fIspec\fP.

.IP -
In case of weak trace reduction, for each visible label \fIL\fP, 
there exists a transition \fIS\fP--\fIL\fP-->\fIS'\fP if and only if the set
\fIS'\fP = { \fIs'\fP | exists \fIs\fP in \fIS\fP such that \fIs\fP--tau*.\fIL\fP-->\fIs'\fP }
is not empty, where "tau" denotes the invisible label. This definition
expresses that each transition in \fIresult\fP\fB.bcg\fP results from zero
or more invisible transitions followed by a visible one.
.sp
In this case, \fIresult\fP\fB.bcg\fP is a deterministic Labelled Transition
System, does not contain
invisible transitions, and is weakly trace equivalent to \fIspec\fP (i.e., it
contains the same transition sequences as \fIspec\fP by considering only
visible transitions).

.SH EXIT STATUS
Exit status is 0 if everything is alright, 1 otherwise.

.SH DIAGNOSTICS
When the source is erroneous, error messages are issued.

.SH BIBLIOGRAPHY

.ne 4v
.IP [ASU86]
A. V. Aho, R. Sethi, and J. D. Ullman. Compilers: Principles, Techniques
and Tools. Addison-Wesley, 1986.

.IP [BFG+91]
A. Bouajjani, J-C. Fernandez, S. Graf, C. Rodriguez, and J. Sifakis.
Safety for Branching Time Semantics. In Proceedings of 18th ICALP. Springer
Verlag, July 1991.

.ne 6v
.IP [FM91]
J-C. Fernandez and L. Mounier. ``On the Fly'' Verification of Behavioural
Equivalences and Preorders. In K. G. Larsen and A. Skou (Eds.), Proceedings
of the 3rd Workshop on Computer-Aided Verification CAV'91 (Aalborg, Denmark),
Lecture Notes in Computer Science vol. 575. Springer Verlag, July 1991.

.ne 3v
.IP [Mou92]
Laurent Mounier. Methodes de verification de specifications comportementales :
etude et mise en oeuvre. PhD thesis, Universite Joseph Fourier, Grenoble 1, 
1992.

.ne 4v
.IP [Par81]
D. Park. Concurrency and Automata on Infinite Sequences. In Peter Deussen 
(Ed.), Theoretical Computer Science, Lecture Notes in Computer Science vol.
104, pages 167-183. Springer Verlag, March 1981.

.ne 6v
.IP [PLM03]
G. Pace, F. Lang, and R. Mateescu. Calculating Tau-Confluence Compositionally.
In W.A. Hunt Jr and F. Somenzi (Eds.), Proceedings of the 15th Computer-Aided
Verification conference CAV'2003 (Boulder, Colorado, USA), Lecture Notes in 
Computer Science vol. 2725. Springer Verlag, July 2003. Available from
http://cadp.inria.fr/publications/Pace-Lang-Mateescu-03.html

.SH AUTHORS
.P
Versions 1.*, 2.*, and 3.* of \fBreductor\fP have been developed by Hubert
Garavel.
.P
Version 4.* of \fBreductor\fP was developed by Frederic Lang and
Radu Mateescu (INRIA Rhone-Alpes). 
.P
Version 5.* of \fBreductor\fP, merging features previously belonging to
.BR determinator (LOCAL),
was developed by Frederic Lang, with advices of Hubert Garavel and Radu
Mateescu.

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

.P
The binary code of \fBreductor\fP is available in $CADP/bin.`arch`/reductor.a

.P
See the 
.BR caesar_hide_1 (LOCAL), 
.BR caesar_rename_1 (LOCAL),
.BR bcg_labels (LOCAL)
manual pages for a description of hiding and renaming conventions.

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
Please report new bugs to cadp@inria.fr

