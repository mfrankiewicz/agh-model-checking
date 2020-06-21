.\" @(#)bcg_cmp.l - VASY and CONVECS teams - 2019/01/09
.TH BCG_CMP LOCAL "2019/01/09" "(C) INRIA" "CADP MANUAL PAGES"
.fp 4 CB
.lg 0
.SH NAME
bcg_cmp \- equivalence comparison of normal, probabilistic, or stochastic labeled transitions systems (LTS) encoded in the BCG format

.SH SYNOPSIS
\fBbcg_cmp\fP [\fIbcg_options\fP] [\fB-strong\fP | \fB-branching\fP | \fB-divbranching\fP | \fB-observational\fP]
[\fB-normal\fP | \fB-prob\fP | \fB-rate\fP [\fB-self\fP]]
[\fB-epsilon\fP \fIeps\fP] [\fB-format\fP \fIformat_string\fP]
[\fB-class\fP \fIclass_file\fP] 
[\fB-diag\fP \fIdiag_file\fP\fB.bcg\fP]
\fIinput_1\fP\fB.bcg\fP \fIinput_2\fP\fB.bcg\fP
.P
where \fIbcg_options\fP is defined below (see GENERAL OPTIONS).
.P
\fBbcg_cmp\fP takes as inputs the BCG graphs \fIinput_1\fP\fB.bcg\fP
and \fIinput_2\fP\fB.bcg\fP, and compares these graphs according to some
bisimulation relation.

.SH DESCRIPTION

\fBbcg_cmp\fP implements various algorithms to perform comparison
of graphs encoded in the BCG format according to strong bisimulation,
branching bisimulation, divergence-sensitive branching bisimulation,
or observational equivalence. A graph input by \fBbcg_cmp\fP
can be:

.IP -
either a "normal" LTS, whose transitions are either labelled with "normal"
labels or with the "internal" label (usually noted "tau" in the scientific 
literature and displayed as the character string "\fBi\fP" by the various 
BCG tools),

.IP -
or a "probabilistic LTS": 
these are LTS with "normal" labelled transitions, as well as "special" 
transitions, whose labels are either of the form "\fBprob\ %p\fP" or
"\fIlabel\fP\fB;\ prob\ %p\fP", where \fB%p\fP denotes a floating-point 
number in the range ]0..1] and \fIlabel\fP denotes a character string 
that does not contain the "\fB;\fP" character. For each state, the sum of 
"\fB%p\fP" values on special transitions leaving the state must be less or 
equal than 1 (see ANNEX\ 1 of the
.BR bcg_min (LOCAL)
manual page for a discussion on how the probabilistic
LTS model generalizes other theoretical models published
in the literature),

.IP - 
or a "stochastic LTS": 
these are LTS with "normal" labelled transitions, as well as "special"
transitions, whose labels are either of the form "\fBrate\ %f\fP" or
"\fIlabel\fP\fB;\ rate\ %f\fP", where \fB%f\fP denotes a strictly positive
floating-point number and \fIlabel\fP denotes a character string that does
not contain the "\fB;\fP" character (see ANNEX\ 2 of the
.BR bcg_min (LOCAL)
manual page for a discussion on
how the stochastic LTS model of \fBbcg_min\fP generalizes other theoretical
models published in the literature).

.SH GENERAL OPTIONS
The following \fIbcg_options\fP are currently supported:
\fB-version\fP, \fB-create\fP, \fB-update\fP, \fB-remove\fP, \fB-cc\fP,
\fB-tmp\fP, \fB-uncompress\fP, \fB-compress\fP, \fB-register\fP, \fB-short\fP,
\fB-medium\fP, and \fB-size\fP. See the
.BR bcg (LOCAL)
manual page for a description of these options.

.SH PARTICULAR OPTIONS

The following options are also supported:

.TP
.B -strong\ \ \ \ \ \ 
Perform LTS comparison according to strong bisimulation. On (Discrete or
Continuous Time) Markov Chains and on Markov Reward Models, this equivalence
agrees with lumpability of [KS76] (see ANNEX\ 1, ANNEX\ 2, and
BIBLIOGRAPHY of the
.BR bcg_min (LOCAL)
manual page). Default option.

.TP
.B -branching 
Perform LTS comparison according to branching bisimulation.
It is worth noticing that the notion of branching bisimulation is rather
meaningless for probabilistic systems. Not a default option.

.TP
.B -divbranching
Perform LTS comparison according to divergence-sensitive branching bisimulation
[GW96].
Divergence-sensitive branching bisimulation differs from branching bisimulation
only in the way cycles of internal transitions (also called divergences)
are treated. It is known that all states traversed by a cycle of internal
transitions belong to the same branching equivalence class. While divergences
are ignored by ordinary branching bisimulation, they are assimilated to a
self-looping internal transition in each such equivalence class by
divergence-sensitive branching bisimulation. Unlike branching bisimulation,
divergence-sensitive branching bisimulation preserves inevitability properties.
Like branching bisimulation, it is worth noticing that the notion of
divergence-sensitive branching bisimulation is rather meaningless for
probabilistic systems. Not a default option.

.TP
.B -observational
Perform LTS comparison according to observational equivalence [Mil89].
It is worth noticing that observational equivalence is computationally
more expensive than branching bisimulation, so that comparison may fail even
for graphs containing only few thousands of states. To reduce the risk of
failure, in a first step the input graphs are automatically reduced according
to branching bisimulation. This is sound because branching bisimulation is a
graph relation stronger than observational equivalence. However, this
optimisation is not applied if the \fB-class\fP option is set, so that
\fBbcg_cmp\fP can print the equivalence classes relatively to the states of
the input graphs, instead of the states of the branching minimal intermediate
graph produced in the first step. This option cannot be combined with neither
\fB-prob\fP nor \fB-rate\fP options. Not a default option.

.TP
.B -normal 
Consider \fIinput_1\fP\fB.bcg\fP and \fIinput_2\fP\fB.bcg\fP as normal LTSs.
With this option, labels of the form "\fBrate\ %f\fP" or 
"\fIlabel\fP\fB;\ rate\ %f\fP" or "\fBprob\ %p\fP" or 
"\fIlabel\fP\fB;\ prob\ %p\fP" are processed as ordinary labels, without
special meaning attached. Default option.

.TP
.B -prob\ \ \ \ 
Consider \fIinput_1\fP\fB.bcg\fP and \fIinput_2\fP\fB.bcg\fP as probabilistic
LTSs. With this option, each label of the form "\fBprob\ %p\fP" or
"\fIlabel\fP\fB;\ prob\ %p\fP" is recognized as denoting a probabilistic
transition with probability \fB%p\fP. \fBbcg_cmp\fP will stop with an
error message if, for some probabilistic transition, \fB%p\fP is out of ]0..1],
or if the probabilistic transitions going out of the same state have a
cumulated sum strictly greater than 1. With this option, labels of the form
"\fBrate\ %f\fP" or "\fIlabel\fP\fB;\ rate\ %f\fP" are processed as ordinary
labels. Not a default option.

.TP
.B -rate\ \fR[\fP -self \fR]\fP 
Consider \fIinput_1\fP\fB.bcg\fP and \fIinput_2\fP\fB.bcg\fP as stochastic
LTSs. With this option, each label of the form "\fBrate\ %f\fP" or
"\fIlabel\fP\fB;\ rate\ %f\fP" is recognized as denoting a stochastic
transition with rate \fB%f\fP. \fBbcg_cmp\fP will stop with an error
message if, for some stochastic transition, \fB%f\fP is less or equal to 0.
If the \fB-branching\fP or the \fB-divbranching\fP option is selected, and
some state has both an outgoing stochastic transition and an outgoing internal
(i.e., "tau") transition, \fBbcg_cmp\fP will print a warning and ignore
the stochastic transition in order to preserve the notion of maximal progress.
With this option, labels of the form "\fBprob\ %p\fP" or 
"\fIlabel\fP\fB;\ prob\ %p\fP" are processed as ordinary labels. 
Not a default option.
.br
.br
If \fB-self\fP sub-option is given, all self loops (i.e., transitions
that remain within the same equivalence class) having labels of the form 
"\fBrate\ %f\fP" are ignored. This implements the weak Markovian equivalences
described in [Bra02] and [BHKW05].
Not a default sub-option.

.TP
.BI -epsilon \ eps
Set the precision of floating-point comparisons to \fIeps\fP, where \fIeps\fP 
is a real value. When \fIeps\fP is out of [0..1[, \fBbcg_cmp\fP reports an
error. Default value for \fIeps\fP is 1E-6.

.TP
.BI -format \ format_string
Use \fIformat_string\fP to control the format of the floating-point numbers
contained in transition labels (these numbers correspond to the occurrences
of \fB%f\fP and \fB%p\fP mentioned in section DESCRIPTION above). The value 
of \fIformat_string\fP should obey the same conventions as the \fIformat\fP
parameter of function
.BR sprintf (3C)
for values of type \fBdouble\fP. Default value for \fIformat_string\fP
is \fB"%g"\fP, meaning that floating-point numbers are printed with at most
six digits after the "." (i.e., the radix character). Other values can be 
used, for instance \fB"%.9g"\fP to obtain nine digits instead of six, or 
by replacing the \fB"%g"\fP flag with other flags, namely \fB"%e"\fP, 
\fB"%E"\fP, \fB"%f"\fP, \fB"%G"\fP, possibly combined with additional
flags (e.g., to specify precision).

.TP
.BI -class \ class_file\ \ \ \ \ \ 
If \fIclass_file\fP is the character '-', then display the equivalence
classes on standard output. Otherwise, display the equivalence classes in
a file named \fIclass_file\fP. Not a default option.

.TP
.BI -diag \ diag_file\fB.bcg\fP
When the comparison of \fIinput_1\fP and \fIinput_2\fP yields FALSE, generate
a diagnostic (counterexample) in BCG format (see the
.BR bcg (LOCAL)
manual page for details) explaining this result. The diagnostic is generated
in the file \fIdiag\fP\fB.bcg\fP. This option has no effect when the
comparison of \input_1\fP and \fIinput_2\fP yields TRUE, since in this case
the diagnostic would be larger than \fIinput_1\fP and \fIinput_2\fP, and
would not bring any useful information. The BCG file containing the diagnostic
can be visualized using the
.BR bcg_draw (LOCAL)
and
.BR bcg_edit (LOCAL)
tools of CADP (see respective manual pages for details).
.sp
The diagnostic is a directed acyclic graph included (modulo the preorder
corresponding to the equivalence relation considered) both in \fIinput_1\fP
and \fIinput_2\fP.
.sp
If the diagnostic is a sequence of transitions, it will also be displayed
on standard output using the simple SEQ format (see the
.BR seq (LOCAL)
manual page for the definition of this format). Not a default option.

.LP
Note: Options \fB-strong\fP, \fB-branching\fP, and \fB-divbranching\fP are
mutually exclusive.
If they occur simultaneously on the command-line, the option occurring 
last is selected. 

.LP
Note: Options \fB-normal\fP, \fB-prob\fP, and \fB-rate\fP (with or without
\fB-self\fP sub-option) are mutually exclusive. If they occur simultaneously
on the command-line, the option occurring last is selected. 
 
.SH ENVIRONMENT VARIABLES

See the
.BR bcg (LOCAL)
manual page for a description of the environment variables used by all
the BCG application tools.

.SH EXIT STATUS
Exit status is 0 if everything is alright, 1 otherwise.

.SH AUTHORS

\fBbcg_cmp\fP was developped by Frederic Lang (INRIA/CONVECS).
It shares a substantial amount of code with \fBbcg_min\fP.
See the
.BR bcg_min (LOCAL)
manual page for more information.

.SH OPERANDS
.PD 0
.TP 20
.IB input_1 .bcg
BCG graph (input)
.TP
.IB input_2 .bcg
BCG graph (input)
.TP
.IB input_1 @1.o
dynamic library (input or output)
.TP
.IB input_2 @1.o
dynamic library (input or output)
.PD

.SH FILES

.PD 0
.TP 32
.B $CADP/bin.`arch`/bcg_cmp
``\fBbcg_cmp\fP'' binary program
.PD

.P
See the
.BR bcg (LOCAL)
manual page for a description of the other files.

.SH SEE ALSO
.BR bcg (LOCAL),
.BR bcg_min (LOCAL),
.BR seq (LOCAL),
.BR sprintf (3C)

.P
Additional information is available from the CADP Web page located at
http://cadp.inria.fr
.P 
Directives for installation are given in files \fB$CADP/INSTALLATION_*\fP.
.P
Recent changes and improvements to this software are reported
and commented in file \fB$CADP/HISTORY\fP.

.SH BUGS

Please report bugs to cadp@inria.fr.
