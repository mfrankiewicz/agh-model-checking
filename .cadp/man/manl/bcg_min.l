.\" @(#)bcg_min.l - VASY and CONVECS teams - 2016/04/12
.TH BCG_MIN LOCAL "2016/04/12" "(C) INRIA" "CADP MANUAL PAGES"
.fp 4 CB
.lg 0
.SH NAME
bcg_min \- minimization of normal, probabilistic, or stochastic labeled transitions systems (LTS) encoded in the BCG format

.SH SYNOPSIS
\fBbcg_min\fP [\fIbcg_options\fP] [\fB-strong\fP | \fB-branching\fP | \fB-divbranching\fP | \fB-observational\fP]
[\fB-normal\fP | \fB-prob\fP | \fB-rate\fP [\fB-self\fP]]
[\fB-epsilon\fP \fIeps\fP] [\fB-format\fP \fIformat_string\fP]
[\fB-class\fP \fIclass_file\fP] \fIinput\fP\fB.bcg\fP [\fIoutput\fP\fB.bcg\fP]
.P
where \fIbcg_options\fP is defined below (see GENERAL OPTIONS).
.P
\fBbcg_min\fP takes as input the BCG graph \fIinput\fP\fB.bcg\fP,
minimizes this graph according to some bisimulation relation, and
writes the resulting reduced graph to \fIoutput\fP\fB.bcg\fP,
replacing \fIinput\fP\fB.bcg\fP if \fIoutput\fP\fB.bcg\fP is omitted.

.SH DESCRIPTION

\fBbcg_min\fP implements various algorithms to perform minimization
of graphs encoded in the BCG format according to strong bisimulation,
branching bisimulation, divergence-sensitive branching bisimulation,
or observational equivalence. A graph input or output by \fBbcg_min\fP
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
equal than 1 (see ANNEX\ 1 below for a discussion on how the probabilistic
LTS model of \fBbcg_min\fP generalizes other theoretical models published
in the literature),

.IP - 
or a "stochastic LTS": 
these are LTS with "normal" labelled transitions, as well as "special"
transitions, whose labels are either of the form "\fBrate\ %f\fP" or
"\fIlabel\fP\fB;\ rate\ %f\fP", where \fB%f\fP denotes a strictly positive
floating-point number and \fIlabel\fP denotes a character string that does
not contain the "\fB;\fP" character (see ANNEX\ 2 below for a discussion on
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
Perform LTS reduction according to strong bisimulation. On (Discrete or
Continuous Time) Markov Chains and on Markov Reward Models, this reduction 
agrees with lumpability of [KS76] (see ANNEX\ 1, ANNEX\ 2, and
BIBLIOGRAPHY below). Default option.

.TP
.B -branching 
Perform LTS reduction according to branching bisimulation.
It is worth noticing that the notion of branching bisimulation is rather
meaningless for probabilistic systems. Not a default option.

.TP
.B -divbranching
Perform LTS reduction according to divergence-sensitive branching bisimulation
[GW96].
Divergence-sensitive branching bisimulation differs from branching bisimulation
only in the way cycles of internal transitions (also called divergences)
are treated. It is known that all states traversed by a cycle of internal
transitions belong to the same branching equivalence class. While divergences
are eliminated in the LTS obtained by reduction modulo ordinary branching
bisimulation, a self-looping internal transition is kept in each such
equivalence class in the LTS obtained by divergence-sensitive branching
bisimulation. Unlike branching bisimulation, divergence-sensitive branching
bisimulation preserves inevitability properties. Like branching bisimulation,
it is worth noticing that the notion of divergence-sensitive branching
bisimulation is rather meaningless for probabilistic systems. Not a default
option.

.TP
.B -observational
Perform LTS reduction according to observational equivalence [Mil89].
It is worth noticing that observational equivalence is computationally
more expensive than branching bisimulation, so that reduction may fail even
for graphs containing only few thousands of states. To reduce the risk of
failure, in a first step the input graph is automatically reduced according
to branching bisimulation. This is sound because branching bisimulation is a
graph relation stronger than observational equivalence. However, this
optimisation is not applied if the \fB-class\fP option is set, so that
\fBbcg_min\fP can print the equivalence classes relatively to the states of
the input graph, instead of the states of the branching minimal intermediate
graph produced in the first step. This option cannot be combined with neither
\fB-prob\fP nor \fB-rate\fP options. Not a default option.

.TP
.B -normal 
Consider \fIinput\fP\fB.bcg\fP as a normal LTS. With this option,
labels of the form "\fBrate\ %f\fP" or "\fIlabel\fP\fB;\ rate\ %f\fP"
or "\fBprob\ %p\fP" or "\fIlabel\fP\fB;\ prob\ %p\fP" are processed as 
ordinary labels, without special meaning attached. Default option.

.TP
.B -prob\ \ \ \ 
Consider \fIinput\fP\fB.bcg\fP as a probabilistic LTS. With this option, each 
label of the form "\fBprob\ %p\fP" or "\fIlabel\fP\fB;\ prob\ %p\fP"
is recognized as denoting a probabilistic transition with probability \fB%p\fP.
\fBbcg_min\fP will stop with an error message if, for some probabilistic 
transition, \fB%p\fP is out of ]0..1], or if the probabilistic transitions 
going out of the same state have a cumulated sum strictly greater than 1. 
With this option, labels of the form "\fBrate\ %f\fP" or
"\fIlabel\fP\fB;\ rate\ %f\fP" are processed as ordinary labels. 
Not a default option.

.TP
.B -rate\ \fR[\fP -self \fR]\fP 
Consider \fIinput\fP\fB.bcg\fP as a stochastic LTS. With this option, each
label of the form "\fBrate\ %f\fP" or "\fIlabel\fP\fB;\ rate\ %f\fP"
is recognized as denoting a stochastic transition with rate \fB%f\fP. 
\fBbcg_min\fP will stop with an error message if, for some stochastic 
transition, \fB%f\fP is less or equal to 0.
If the \fB-branching\fP or the \fB-divbranching\fP option is selected, and some state has both an 
outgoing stochastic transition and an outgoing internal (i.e., "tau") 
transition, \fBbcg_min\fP will print a warning and remove the stochastic 
transition in order to preserve the notion of maximal progress. With 
this option, labels of the form "\fBprob\ %p\fP" or 
"\fIlabel\fP\fB;\ prob\ %p\fP" are processed as ordinary labels. 
Not a default option.
.br
.br
If \fB-self\fP sub-option is given, all self loops (i.e., transitions
that remain within the same equivalence class) having labels of the form 
"\fBrate\ %f\fP" are removed. This implements the weak Markovian equivalences
described in [Bra02] and [BHKW05].
Not a default sub-option.

.TP
.BI -epsilon \ eps
Set the precision of floating-point comparisons to \fIeps\fP, where \fIeps\fP 
is a real value. When \fIeps\fP is out of [0..1[, \fBbcg_min\fP reports an
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
classes on the standard output. Otherwise, display the equivalence classes in
a file named \fIclass_file\fP. Not a default option.

.LP
Note: In \fBbcg_min\fP versions up to 2.1, option \fB-class\fP was not followed
by a \fIclass_file\fP argument and equivalence classes were always displayed on
the standard output. The \fIclass_file\fP argument was introduced in \fBbcg_min\fP
version 2.2. Because such evolution breaks backward compatibility, \fBbcg_min\fP
issues an error message and stops if the argument following option \fB-class\fP is
either an option (i.e., starts with a hyphen) or a file name with extension \fB.bcg\fP,
which prevents overwriting an existing BCG file.

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

Version 1.* of \fBbcg_min\fP was developed by Damien Bergamini (INRIA/VASY),
Moez Cherif (INRIA/VASY), Hubert Garavel (INRIA/VASY) and Holger Hermanns
(University of Twente). Pepijn Crouzen added \fP-self\fP sub-option.
Version 1.* of \fBbcg_min\fP used the following algorithms: 
.IP -
It used the algorithm of [KS90] to compute strong bisimulation on a normal LTS.
.IP -
It used the algorithm of [HS99] to compute strong bisimulation on probabilistic
and stochastic LTS.
.IP -
It used the algorithm of [GV90] to compute branching bisimulation on a normal
LTS. The implementation in \fBbcg_min\fP was derived from a Pascal program
written by Jan Friso Groote (CWI).
.IP -
It used a variant of the algorithm of [HS99] to compute branching bisimulation
on a stochastic (resp. probabilistic) LTS: the branching bisimulation
condition was applied only to the "normal" fragment of the transition relation,
while the stochastic (resp. probabilistic) fragments were mimimized with
respect to strong bisimulation.
.P
Version 2.* of \fBbcg_min\fP was developed by Frederic Lang (INRIA/VASY).
It uses (sequential) variants of the signature-based algorithm of [BO03] to
compute strong, branching, and divergence-sensitive vranching bisimulation
on normal, probabilistic and stochastic LTS.

.SH OPERANDS
.PD 0
.TP 20
.IB input .bcg
BCG graph (input)
.TP
.IB output .bcg
BCG graph (output)
.TP
.IB input @1.o
dynamic library (input or output)
.PD

.SH FILES

.PD 0
.TP 32
.B $CADP/bin.`arch`/bcg_min
``\fBbcg_min\fP'' binary program
.PD

.P
See the
.BR bcg (LOCAL)
manual page for a description of the other files.

.SH SEE ALSO
.BR bcg (LOCAL),
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

Please report bugs to Hubert.Garavel@inria.fr.

.SH ANNEX 1 - PROBABILISTIC MODELS

The probabilistic LTS model used in \fBbcg_min\fP is general enough to support
the following models, which can be considered as special cases of probabilistic
LTS:
.TP
.BR "Discrete Time Markov Chains"\ [Nor97] 
The graph contains transitions of the form "\fBprob\ %p\fP" only.
.TP
.BR "Discrete Time Markov Reward Models"\ [How71] 
The graph contains transitions of the form "\fBprob\ %p\fP" to represent 
transitions not obtaining an impulse reward. State rewards are associated 
to states by "normal" transitions with source and target states being 
identical. The label indicates the state reward such as "\fBreward\ 5\fP". 
Impulse rewards are associated to probabilistic transitions by prefixing 
the "\fBprob\ %p\fP" label with a label indicating the reward obtained by 
taking this transition, as in "\fBimpulse\ 4;\ prob\ %p\fP".
.TP
.BR "Alternating Probabilistic LTS"\ [Han91] 
The graph contains transitions of the
form "\fBprob\ %p\fP", as well as normal transitions in such a way that there
is no state possessing both normal as well as "\fBprob\ %p\fP" transitions. 
.TP
.BR "Discrete Time Markov Decision Processes"\ [Put94] 
The graph contains transitions of the form "\fBprob\ %p\fP", as well as normal
transitions in such a way that there is no state possessing both normal as well
as "\fBprob\ %p\fP" transitions. Normal and probabilistic transitions strictly
alternate, i.e. normal (resp. "\fBprob\ %p\fP") transitions are not directly
followed by normal (resp. "\fBprob\ %p\fP") transitions. Uses an encoding of
Discrete Time Markov Decision Processes into strictly Alternating Probabilistic
LTS proposed in [Arg00].
.TP
.BR "Generative Probabilistic LTS"\ [GSS95] 
The graph contains transitions of the type
"\fIlabel\fP\fB;\ prob\ %p\fP" only, and for each state the sum of 
"\fB%p\fP" values leaving a state is equal to (or smaller than) 1.
.TP
.BR "Reactive Probabilistic LTS"\ [GSS95] 
The graph contains transitions of the type "\fIlabel\fP\fB;\ prob\ %p\fP" 
only, and for each state and each "\fIlabel\fP" the sum of "\fB%p\fP" values 
leaving a state is equal to (or smaller than) 1.
.TP
.BR "Stratified Probabilistic LTS"\ [GSS95] 
The graph contains transitions
of the form "\fBprob\ %p\fP", as well as normal transitions in such a way that
there is no state possessing both normal as well as "\fBprob\ %p\fP"
transitions. Normal transitions are not directly followed by normal transitions.

.SH ANNEX 2 - STOCHASTIC MODELS

The stochastic LTS model used in \fBbcg_min\fP is general enough
to support the following models, which can be considered as special cases 
of stochastic LTS:
.TP
.BR "Continuous Time Markov Chains"\ [Nor97] 
The graph contains transitions of the form "\fBrate\ %f\fP" only. 
.TP
.BR "Continuous Time Markov Reward Models"\ [How71] 
The graph contains transitions of the
form "\fBrate\ %f\fP" to represent transitions not obtaining an impulse
reward. State rewards are assigned to states by "normal" transitions with
source and target states being identical. The label indicates the state reward
such as "\fBreward 5\fP". Impulse rewards are assigned to probabilistic 
transitions by prefixing the "\fBrate\ %f\fP" label with a label indicating
the reward obtained, as in "\fBimpulse 4;\ rate\ %f\fP".
.TP
.BR "Continuous Time Markov Decision Processes"\ [Put94] 
The graph contains transitions of
the form "\fBrate\ %f\fP", as well as normal transitions in such a way that
there is no state possessing both normal as well as "\fBrate\ %f\fP" 
transitions. Normal and stochastic transitions strictly alternate, meaning 
that normal (resp. "\fBrate\ %f\fP") transitions are not directly followed by 
normal (resp. "\fBrate\ %f\fP") transitions. Inspired by an encoding proposed 
in [Arg00].
.TP
.BR "Interactive Markov Chains"\ [Her98] 
The graph contains transitions of the form "\fBrate\ %f\fP", as well as 
normal transitions. 
.TP
.BR "Timed Processes for Performance (TIPP) Models"\ [HHM98] 
The graph contains transitions of
the form "\fIlabel\fP\fB;\ rate\ %f\fP", as well as normal transitions. 
.TP
.BR "Performance Evaluation Process Algebra (PEPA) Models"\ [Hil96] 
The graph contains transitions of the form "\fIlabel\fP\fB;\ rate\ %f\fP" only.
Passsive transitions are represented by abuse of the "\fBrate\fP" keyword.
The transition label of a passive transition is augmented by a distinguishing 
string to indicate that the rate value has to be interpreted as a weight, such
as in "\fBTHIS IS A PASSIVE TRANSITION LABELLED\fP\ \fIlabel\fP\ \fBWITH 
WEIGHT\fP\fB; rate %f\fP". The actual distinguishing string used for this 
purpose is of no importance for \fBbcg_min\fP, but it must not contain 
"\fB;\fP" and must not start with the keyword "\fBrate\fP".

.TP
.BR "Extended Markovian Process Algebra (EMPA) Models"\ [BG98] 
The graph contains transitions of the form "\fIlabel\fP\fB;\ rate\ %f\fP" only.
Passive and immediate transitions are represented by abuse of the "\fBrate\fP"
keyword. The transition label of a passive transition is augmented by a 
distinguishing string to indicate that the rate value has to be interpreted 
as a weight, such as in "\fBTHIS IS A PASSIVE TRANSITION LABELLED\fP\ 
\fIlabel\fP\fB WITH PRIORITY\fP\ \fIp\fP\fB\ AND WEIGHT\fP\fB; rate %f\fP".
The transition label of an immediate transition is augmented in a similar way,
as in "\fBTHIS IS AN IMMEDIATE TRANSITION LABELLED\fP\ \fIlabel\fP\ \fBWITH
PRIORITY\fP\ \fIp\fP\ \fBAND WEIGHT\fP\fB; rate %f\fP". The actual 
distinguishing strings used for these purposes are of no importance for
\fBbcg_min\fP, but they must not contain "\fB;\fP" and must not start with 
the keyword "\fBrate\fP".

.SH BIBLIOGRAPHY

.P 
[Arg00] P. R. D'Argenio (2000). On the relation among different probabilistic 
transition systems and probabilistic bisimulations. CTIT Tech Report, 
to appear 2000.
.P
[BG98] M. Bernardo and R. Gorrieri (1998).  A Tutorial on EMPA: A
Theory of Concurrent Processes with Nondeterminism, Priorities, Probabilities
and Time.  Theoretical Computer Science 202, pp. 1-54, 1998.
.P
[BHKW05] C. Baier, H. Hermanns, J.P. Katoen, V. Wolf. Comparative branching-time
semantics for Markov chains. Information and Computation, vol. 200(2), pp.
149-214, 2005.
.P
[BO03] S. Blom, S. Orzan. Distributed State Space Minimization. Electronic
Notes in Theoretical Computer Science, vol. 80, 2003.
.P
[Bra02] M. Bravetti. Revisiting Interactive Markov Chains. Electronic Notes
on Theoretical Computer Science, vol. 68(5), 2002.
.P
[GH02] H. Garavel and H. Hermanns (2002). On Combining Functional Verification
and Performance Evaluation using CADP. Proc. 11th Int. Symp. of Formal Methods
Europe FME'2002 (Copenhagen, Denmark), LNCS 2391, July 2002. Available from
http://cadp.inria.fr/publications/Garavel-Hermanns-02.html
.P
[GSS95] R. J. van Glabbeek, S. A. Smolka, and B. Steffen
(1995).  Reactive, generative, and stratified models of probabilistic
processes. Information and Computation 121, pp. 59-80, 1995.
.P
[GW96] R.J. van Glabbeek and W.P. Weijland (1996). Branching Time and
Abstraction in Bisimulation Semantics. Journal of the ACM 43(3):555-600.
.P
[GV90] J. F. Groote and F. Vaandrager (1990). An efficient algorithm for
branching bisimulation and stuttering equivalence. Proceedings of the 
17th ICALP (Warwick), LNCS 443, pp. 626-638, 1990.
.P
[Han91] H. A. Hansson (1991). Time and Probability in Formal Design of
Distributed Systems.  PhD thesis, University of Uppsala, 1991.
.P
[Her98] H. Hermanns (1998). Interactive Markov Chains. Ph.D. Thesis, 
University of Erlangen-Nuernberg, Germany, 1998.
.P
[HHM98] H. Hermanns, U. Herzog, and V. Mertsiotakis
(1998).  Stochastic Process Algebras - Between LOTOS and Markov Chains.
Computer Networks and ISDN Systems 30, pp. 901-924, 1998.
.P
[Hil96] J. Hillston (1996).  A Compositional Approach to Performance
Modelling. Cambridge University Press, 1996.
.P
[How71] R. A. Howard (1971). Dynamic Probabilistic Systems, Vol II: 
Semi-Markov and Decision Processes. Wiley, 1971.
.P
[HS99] H. Hermanns and M. Siegle (1999). Bisimulation algorithms for 
stochastic process algebras and their BDD-based implementation. Proceedings 
of the 5th ARTS, LNCS 1601, pp. 244-265, 1999.
.P
[KS76] J. G. Kemeny and J. L. Snell (1976).
Finite Markov Chains. Springer, 1976.
.P
[KS90] P. C. Kanellakis and S. A. Smolka (1990). CCS expressions, finite state
processes, and three problems of equivalence. Information and Computation
86(1), pp. 43-68, May 1990.
.P
[Mil89] R. Milner (1989). Communication and Concurrency. Prentice-Hall, 1989.
.P
[Nor97] J. R. Norris (1997). Markov Chains. Cambridge University Press, 1997.
.P
[Put94] M. L. Puterman (1994). Markov Decision Processes: Discrete
Stochastic Dynamic Programming. Wiley, New York, NY, 1994.

