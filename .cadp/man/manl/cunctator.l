.\" @(#)cunctator.l - VASY and CONVECS teams - 2020/02/12
.TH CUNCTATOR LOCAL "2020/02/12" "(C) INRIA" "CADP MANUAL PAGES"
.fp 4 CB
.lg 0
.SH NAME
cunctator \- on-the-fly steady-state simulation of continuous-time Markov chains

.SH SYNOPSIS

.B bcg_open
.RI [ bcg_opt ]
\fIspec\fP[\fB.bcg\fP]
.RI [ cc_opt ]
.B cunctator
.RI [ cunctator_opt ]
.sp
or:
.sp
.B exp.open
.RI [ exp_opt ]
\fIspec\fP[\fB.exp\fP]
.RI [ cc_opt ]
.B cunctator
.RI [ cunctator_opt ]
.sp
or:
.sp
.B fsp.open
.RI [ fsp_opt ]
\fIspec\fP[\fB.lts\fP]
.RI [ cc_opt ]
.B cunctator
.RI [ cunctator_opt ]
.sp
or:
.sp
.B lnt.open
.RI [ lnt_opt ]
\fIspec\fP[\fB.lnt\fP]
.RI [ cc_opt ]
.B cunctator
.RI [ cunctator_opt ]
.sp
or:
.sp
.B lotos.open
.RI [ lotos_opt ]
\fIspec\fP[\fB.lotos\fP]
.RI [ cc_opt ]
.B cunctator
.RI [ cunctator_opt ]
.sp
or:
.sp
.B seq.open
.RI [ seq_opt ]
\fIspec\fP[\fB.seq\fP]
.RI [ cc_opt ]
.B cunctator
.RI [ cunctator_opt ]

.SH DESCRIPTION

.B cunctator
(from the Latin, the one who temporises)
takes as input a continuous-time Markov chain (CTMC), expressed either as
a BCG graph
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

.P
.B cunctator
performs an on-the-fly random simulation of the CTMC, by a forward traversal
of a transition sequence in the CTMC, and computes, for certain specified
transitions, their throughput at the equilibrium ("steady-state").
The simulation terminates either when some convergence criterion is met
(see OPTIONS below), or when the user aborts it (e.g., by typing a Ctrl-C).
Upon termination of the simulation, the values of the throughputs, accompanied
by other simulation statistics, are displayed on standard output.

.P
All transition labels of the CTMC must have one of the following forms:
.IP -
"\fBrate\fP \fI%f\fP" (called a stochastic transition),
.IP -
"\fIaction\fP\fB;\ rate\fP \fI%f\fP" (called a labelled stochastic transition), or
.IP -
"\fIi\fP" (called an internal transition),
.P
where \fB%f\fP denotes a strictly positive floating-point number,
and \fIaction\fP denotes a character string that does not contain
the "\fB;\fP" character.

.P
If the graph specified by \fIspec\fP also contains transition labels of other
forms than the aforementioned ones, these labels must be hidden or renamed
using the \fB-hide\fP and the \fB-rename\fP options (see OPTIONS below) in
order to turn \fIspec\fP into a CTMC.

.P
A state is called \fIstable\fP if it has no outgoing internal transitions and
is called \fIunstable\fP otherwise.

.P
The simulation algorithm used by
.B cunctator
applies the notion of maximal progress: every time an unstable state is
encountered, all its outgoing stochastic transitions are ignored and the
simulation sequence is advanced along some of its outgoing internal
transitions.

.P
The CTMC is assumed not to contain nondeterminism, which means that all
internal transitions going out of an unstable state must lead to states
that are equivalent modulo stochastic branching bisimulation.
For efficiency reasons,
.B cunctator
does not attempt to perform this check, but instead it displays among
the simulation statistics whether potential nondeterminism was encountered
or not, i.e., whether a state having at least two outgoing internal
transitions was reached during simulation. The tool also offers several ways
of choosing internal transitions by means of the \fB-scheduler\fP option
(see OPTIONS below) in order to study whether they yield the same throughputs
(which indicates the possible absence of nondeterminism) or not
(which indicates the necessary presence of nondeterminism).

.P
See also
.BR bcg_min (LOCAL)
for a discussion about the various probabilistic and stochastic models present
in the literature.

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
The following options \fIcunctator_opt\fP are currently available:

.TP
\fB-action\fP \fIaction_1\fP ... \fIaction_n\fP
Specify the actions contained in the labels of stochastic transitions
"\fIaction_i\fP\fB;\ rate\fP \fI%f\fP" (for \fB1 <= i <= n\fP) of the CTMC
for which the throughput must be computed. All the stochastic transitions
of the CTMC having labels other than "\fIaction_i\fP\fB;\ rate\fP \fI%f\fP"
(for \fB1 <= i <= n\fP) are considered as purely stochastic transitions
(i.e., their actions are ignored and only their rates are taken into account)
during the simulation. If this option is absent, the throughput is computed
for all the actions contained in the labels of stochastic transitions of
the CTMC.
.sp
To obtain useful results, each of the actions \fIaction_i\fP
(for \fB1 <= i <= n\fP) must be contained in the label of at least one
stochastic transition of the CTMC. This can be ensured by taking care
that the options \fB-action\fP, \fB-hide\fP, and \fB-rename\fP are compatible.
If some action \fIaction_i\fP is absent from the CTMC, its throughput
will be always equal to 0.0 regardless of the other parameters of the
simulation.
.sp
Note: For efficiency reasons, it is recommended to use this option whenever
the actions for which the throughput must be computed are known.

.TP
\fB\-hide [ \-total | \-partial | \-gate ]\fP \fIhiding_filename\fP
Use the hiding rules defined in \fIhiding_filename\fP to hide (on-the-fly)
the labels of \fIspec\fP. See the
.BR caesar_hide_1 (LOCAL)
manual page for a detailed description of the appropriate format for
\fIhiding_filename\fP.
.sp
The \fB-total\fP, \fB-partial\fP, and \fB-gate\fP options specify the
"total matching", "partial matching", and "gate matching" semantics,
respectively.
See the
.BR caesar_hide_1 (LOCAL)
manual page for more details about these semantics. Option
\fB-total\fP is the default.

.TP
\fB\-rename [\-total|\-single|\-multiple|\-gate]\fP \fIrenaming_filename\fP
Use the renaming rules defined in \fIrenaming_filename\fP to rename
(on-the-fly) the labels of \fIspec\fP. See the
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
.sp
The hiding and renaming options are useful for converting the transition
labels of \fIspec\fP on-the-fly in order to transform it into a CTMC.
If (one of) these options and the \fB-action\fP option are present on the
command-line, the hiding and renaming options will be applied before
the \fB-action\fP option is taken into account.

.TP
\fB-cache\fP \fIsize\fP \fIrepl\fP
Trigger the use of an internal cache for storing at most \fIsize\fP states
in order to speed up simulation by avoiding the recomputation of certain
sequences of internal transitions. When the cache is full and a new state
must be inserted in it, some other state present in the cache is deleted and
replaced by the new one. The choice of the state to be deleted is made
according to the replacement strategy \fIrepl\fP, which can take one of the
following values:
LRU (\fILeast Recently Used\fP),
MRU (\fIMost Recently Used\fP),
LFU (\fILeast Frequently Used\fP),
MFU (\fIMost Frequently Used\fP),
and
RND (\fIRandom\fP).
This option can be used only for the schedulers 0 and 1 (see option
\fB-scheduler\fP below). By default, the size of the cache is 0 (i.e., no
caching is performed during simulation).
Not a default option.

.TP
\fB-depth\fP \fIdepth\fP
Specify the maximum number of transitions of the sequence traversed during
simulation. When the number of transitions of the current simulation
sequence becomes equal to the natural number \fIdepth\fP, then the simulation
terminates and the statistics are reported. A value 0 of \fIdepth\fP means
no limit, i.e., the simulation will run for ever unless aborted by the user.
The default value of \fIdepth\fP is 0.

.TP
\fB-time\fP \fItime\fP
Specify the maximum simulation time, which is the sum of all durations spent
in the stable states of the transition sequence traversed during simulation. 
When the current simulation time (the sum of durations spent in the stable
states of the current simulation sequence) becomes equal to or greater than the
real number \fItime\fP, then the simulation terminates and the statistics are
reported. A value 0.0 of \fItime\fP means no limit, i.e., the simulation
will run for ever unless aborted by the user. The default value of \fItime\fP
is 0.0.
.sp
If both options \fB-depth\fP and \fB-time\fP are present on the command-line,
the option \fB-depth\fP is ignored in favor of \fB-time\fP.

.TP
\fB-scheduler\fP \fIn\fP
Specify the way an internal transition going out of an unstable state is
chosen during simulation in order to apply the notion of maximal progress.
When the current state has several outgoing internal transitions, choosing
a particular one as the next transition to be traversed amounts to model a
particular scheduler. The following values are currently available for the
scheduler \fIn\fP:
.sp
- 0: Choose the first internal transition encountered while scanning the
transitions going out from the current state.
.sp
- 1: Choose the last internal transition encountered while scanning the
transitions going out from the current state.
.sp
- 2: Choose randomly (with equal probability) one of the internal transitions
going out from the current state.
.sp
This option enables the user to experiment with several schedulers in order
to study their effect on the throughputs computed by simulation. Several
simulations differing only in the scheduler used and yielding the same
throughputs indicate the possible absence of nondeterminism in the CTMC.
Two simulations differing only in their scheduler and yielding different
throughputs indicate the necessary presence of nondeterminism in the CTMC.
The default value of \fIn\fP is 0.

.TP
\fB-rng\fP \fIn\fP
Specify the random number generator used for computing the
current simulation time and to select the transitions of the simulation
sequence. Four random number generators are currently available
(\fIn\fP = 0, 1, 2, 3). The default value of \fIn\fP is 3.

.TP
\fB-seed\fP \fIseed\fP
Specify the seed of the random number generator used during simulation.
The default value of \fIseed\fP is 1.

.TP
\fB-rate\fP
Trigger the CTMC simulation and computation of throughputs.
.sp
Note: This option is currently superfluous (if it is absent from the
command-line, a warning message is issued but the functioning of
.B cunctator
is unchanged), its current purpose being to anticipate possible future
extensions of the tool.

.TP
\fB-save\fP \fIcontext_file\fP
Save the context reached at the end of the current simulation in a binary file
\fIcontext_file\fP, which can be reused by a future invocation of
.B cunctator
with the \fB-restore\fP option in order to start another simulation exactly
from the point at which the current simulation terminated. 
Not a default option.
.sp
The context stored in \fIcontext_file\fP upon termination of the current
simulation includes the following information: the state of the CTMC,
the number of transitions of the sequence traversed during simulation,
the simulation time, and the state of the random number generator (which
will be used to restart the random number generator in the future invocations
of
.B cunctator
with \fB-restore\fP that reuse the context stored in \fIcontext_file\fP).
The format of \fIcontext_file\fP is undocumented and subject to future changes.

.TP
\fB-restore\fP \fIcontext_file\fP
Restore the context stored in \fIcontext_file\fP by a previous invocation of
.B cunctator
with the \fB-save\fP option and start a new simulation from that context.
Not a default option.
.sp
If option \fB-depth\fP is present on the command-line, the current simulation
will terminate according to the \fIdepth\fP indicated by this option. The
number of new transitions explored during the current simulation is equal to
the difference between \fIdepth\fP and the number of transitions \fId\fP of
the sequence restored from \fIcontext_file\fP. In other words, the current
simulation will terminate when the total number of transitions traversed
during this simulation and during the previous simulation whose termination
context was stored in \fIcontext_file\fP becomes equal to \fIdepth\fP.
If \fIdepth\fP <= \fId\fP, then the current simulation terminates immediately
and a warning message is issued. Option \fB-time\fP is handled similarly.
.sp
If the option \fB-action\fP is present on the command-line, it is ignored
in favor of the corresponding actions restored from \fIcontext_file\fP.
.sp
If the options \fB-seed\fP or \fB-scheduler\fP are present on the
command-line, they have higher precedence than the corresponding values
restored from \fIcontext_file\fP. This makes possible two kinds of simulation
scenarios:
.sp
- One can perform a first simulation \fIsim1\fP, save its context \fIC\fP,
and start one or several simulations from \fIC\fP, but with seed and
scheduler parameters different than those of \fIsim1\fP. This is useful,
e.g., when the \fIsim1\fP simulation is intended to go over some initial
"transient" behaviour of the system, after which several simulations,
with different seed and scheduler parameters, can be performed in order
to study the "steady" behaviour of the system.
.sp
- If one must ensure that the former simulation whose termination context
is stored in \fIcontext_file\fP is a proper prefix of the current simulation,
then the options \fB-seed\fP and \fB-scheduler\fP must be absent from the
command-line. In this way, a simulation \fIsim1\fP terminating in context
\fIC\fP followed by a simulation \fIsim2\fP starting from \fIC\fP yields
the same results as a single simulation \fIsim\fP having the same seed and
scheduler as \fIsim1\fP and having the same termination conditions (depth
or time) as \fIsim2\fP.
.sp
If the options \fB-hide\fP or \fB-rename\fP were present on the command-line
of the previous invocation of
.B cunctator
which produced \fIcontext_file\fP, they must also be present (with exactly
the same arguments) on the command-line of the current invocation of
.B cunctator
in order to ensure that the former simulation is a proper prefix of the
current simulation.
.sp
Note: When the options \fB-save\fP and \fB-restore\fP are simultaneously
present on the command-line, they can use the same file \fIcontext_file\fP.
This file will be first read in order to restore the context from which the
current simulation is started, then rewritten upon termination of the
simulation in order to save the context reached at that point.

.TP
.B \-verbose
Animate the user's screen, telling what is going on.
Not a default option.

.TP
.B \-version
Display the current version number of the tool and stop.
To be effective, this option should occur as the first argument
on the command line. Subsequent options and/or arguments, if any,
will be discarded. Not a default option.

.SH EXIT STATUS

Exit status is 0 if everything is alright, 1 otherwise.

.SH DIAGNOSTICS

When the transition labels of the CTMC \fIspec\fP do not have the right
format, error messages are issued.

.SH AUTHORS

The tool was developed and documented by Radu Mateescu (INRIA/VASY),
with the advice of Holger Hermanns (INRIA/VASY).
It is derived from the \fIgenerator\fP tool of CADP, developed by
Hubert Garavel (INRIA/VASY).
Meriem Zidouni (Bull and INRIA/VASY) suggested various improvements
(such as the computation of throughputs for several actions) concerning
the prototype version 0.5 of the tool.

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

.SH SEE ALSO

.BR bcg (LOCAL),
.BR bcg_open (LOCAL),
.BR caesar (LOCAL),
.BR caesar.adt (LOCAL),
.BR caesar_graph (LOCAL),
.BR caesar_hide_1 (LOCAL),
.BR caesar_rename_1 (LOCAL),
.BR exp (LOCAL),
.BR exp.open (LOCAL),
.BR fsp.open (LOCAL),
.BR lnt.open (LOCAL),
.BR lotos (LOCAL),
.BR lotos.open (LOCAL),
.BR seq (LOCAL),
.BR seq.open (LOCAL),
.BR regexp (LOCAL)

.P
A related CTMC simulator for studying biological models was developed by
Verena Wolf (Saarland University).

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

