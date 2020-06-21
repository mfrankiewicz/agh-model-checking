.\" @(#)determinator.l - VASY and CONVECS teams - 2020/02/12
.TH DETERMINATOR LOCAL "2020/02/12" "(C) INRIA" "CADP MANUAL PAGES"
.fp 4 CB
.lg 0
.SH NAME
determinator \- elimination of nondeterminism for stochastic systems

.SH SYNOPSIS
.B bcg_open
.RI [ bcg_opt ]
\fIspec\fP[\fB.bcg\fP]
.RI [ cc_opt ]
.BR determinator
.RI [ determinator_opt ]
\fIresult\fP[\fB.bcg\fP]
.P
or:
.P
.B exp.open
[\fIexp_opt\fP]
\fIspec\fP[\fB.exp\fP] 
.RI [ cc_opt ]
.BR determinator
.RI [ determinator_opt ]
\fIresult\fP[\fB.bcg\fP]
.P
or:
.P
.B fsp.open
[\fIfsp_opt\fP]
\fIspec\fP[\fB.lts\fP]
.RI [ cc_opt ]
.BR determinator
.RI [ determinator_opt ]
\fIresult\fP[\fB.bcg\fP]
.P
or:
.P
.B lnt.open
[\fIlnt_opt\fP]
\fIspec\fP[\fB.lnt\fP]
.RI [ cc_opt ]
.BR determinator
.RI [ determinator_opt ]
\fIresult\fP[\fB.bcg\fP]
.P
or:
.P
.B lotos.open
[\fIlotos_opt\fP]
\fIspec\fP[\fB.lotos\fP]
.RI [ cc_opt ]
.BR determinator
.RI [ determinator_opt ]
\fIresult\fP[\fB.bcg\fP]
.P
or: 
.P
.B seq.open
[\fIseq_opt\fP]
\fIspec\fP[\fB.seq\fP]
.RI [ cc_opt ]
.BR determinator
.RI [ determinator_opt ]
\fIresult\fP[\fB.bcg\fP]

.SH DESCRIPTION
Taking as input an extended Markovian model expressed either as
a BCG graph \fIspec\fP\fB.bcg\fP,
a composition expression \fIspec\fP\fB.exp\fP,
an FSP program \fIspec\fP\fB.lts\fP,
a LNT program \fIspec\fP\fB.lnt\fP,
a LOTOS program \fIspec\fP\fB.lotos\fP,
or a SEQ file \fIspec\fP\fB.seq\fP,
\fBdeterminator\fP generates a reduced model by removing stochastic 
nondeterminism on-the-fly.

.P
Extended Markovian models are state-transition models containing ordinary,
probabilistic and/or stochastic transitions. Stochastic determinization
consists in trying to convert the extended Markovian model \fIspec\fP
into a continuous-time Markov chain (CTMC) by removing local sources of
nondeterminism. It might fail if \fIspec\fP does not satisfy certain
conditions. If it succeeds, the CTMC is written to 
\fIresult\fP\fB.bcg\fP; otherwise, an error message is issued. See section 
STOCHASTIC DETERMINIZATION below for details.

.P
Note: Since March 2006, determinization of ordinary Labelled Transition
Systems is no longer supported by \fBdeterminator\fP. Option \fB-rate\fP
becomes the default option. The formerly available options \fB-normal\fP
and \fB-tauclosure\fP are now deprecated. Use the
.BR reductor (LOCAL)
tool instead, as explained below.

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
The following options \fIdeterminator_opt\fP are currently available:

.TP
.BI -epsilon \ eps 
Set the precision of certain floating-point comparisons to \fIeps\fP, where
\fIeps\fP is a real value. When \fIeps\fP is out of [0..1[, \fBdeterminator\fP
reports an error. Default value for \fIeps\fP is 1E-6.

.TP
.BI -format \ format_string
Use \fIformat_string\fP to control the format of the floating-point numbers
contained in transition labels (these numbers correspond to the occurrences
of \fB%f\fP and \fB%p\fP mentioned in section STOCHASTIC DETERMINIZATION
below). The value of \fIformat_string\fP should obey the same conventions as
the \fIformat\fP parameter of function
.BR sprintf (3C)
for values of type \fBdouble\fP. Default value for \fIformat_string\fP
is \fB"%g"\fP, meaning that floating-point numbers are printed with at most
six digits after the "." (i.e., the radix character). Other values can be 
used, for instance \fB"%.9g"\fP to obtain nine digits instead of six, or 
by replacing the \fB"%g"\fP flag with other flags, namely \fB"%e"\fP,
\fB"%E"\fP, \fB"%f"\fP, or \fB"%G"\fP, possibly combined with additional
flags (e.g., to specify precision).

.TP
\fB\-hide [ \-total | \-partial | \-gate ]\fP \fIhiding_filename\fP
Use the hiding rules defined in \fIhiding_filename\fP to hide (on the fly) the
labels of the CTMC being generated. See the
.BR caesar_hide_1 (LOCAL)
manual page for a detailed description of the appropriate format for
\fIhiding_filename\fP.
.sp
The \fB-total\fP, \fB-partial\fP, and \fB-gate\fP options specify the "total
matching", "partial matching", and "gate matching" semantics, respectively.
See the
.BR caesar_hide_1 (LOCAL)
manual page for more details about these semantics. Option \fB-total\fP is the
default.

.TP
\fB\-rename [\-total|\-single|\-multiple|\-gate]\fP \fIrenaming_filename\fP
Use the renaming rules defined in \fIrenaming_filename\fP to rename (on the
fly) the labels of the CTMC being generated. See the
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

.TP
.BI -monitor 
Open a window for monitoring in real-time the generation of \fIresult\fP\fB.bcg\fP. Not a default option. 

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

.SH DEPRECATED OPTIONS

.TP
.B -rate
This option is supported for backward compatibility but has no effect.

.TP
.B -normal
This option triggers an error message. Use ``\fBreductor -trace\fP'' instead 
of ``\fBdeterminator -normal\fP''.

.TP
.B -tauclosure
This option triggers an error message. Use ``\fBreductor -weaktrace\fP''
instead of ``\fBdeterminator -normal -tauclosure\fP''.

.SH STOCHASTIC DETERMINIZATION

The input of \fBdeterminator\fP is an extended Markovian model combining
features from discrete-time and continuous-time Markov chains. All transition
labels must have one of the following forms:
.IP -
"\fBrate\fP \fI%f\fP" (called a stochastic transition), or 
.IP - 
"\fIlabel\fP\fB;\ rate\fP \fI%f\fP" (called a labelled stochastic transition), or 
.IP -
"\fBprob\fP \fI%p\fP" (called a probabilistic transition), or 
.IP -
"\fIlabel\fP\fB;\ prob\fP \fI%p\fP" (called a labelled probabilistic transition), or
.IP -
"\fIlabel\fP" (called an ordinary transition). 
.P
where \fB%f\fP denotes a strictly positive floating-point number,
\fB%p\fP denotes a floating-point number in the range ]0..1],
and \fIlabel\fP denotes a character string that does not contain the "\fB;\fP"
character (\fIlabel\fP may be equal to the internal action, often noted "i"
or "tau").

.P
On the opposite, the expected output of \fBdeterminator\fP is a continuous-time
Markov chain, i.e., a model containing stochastic transitions only.

.P
See also
.BR bcg_min (LOCAL)
for a discussion about the various probabilistic and stochastic models present
in the literature.

.P
States are classified as follows:
.IP -
A state is called \fIdecision\fP if it is the source state of at least one 
ordinary transition.
.IP -
A state is called \fIvanishing\fP if it is not decision and the source state of at least one (possibly labelled) probabilistic transition.
.IP -
A state is called \fItangible\fP if it is neither decision nor vanishing.

.P
Note: the 
.BR bcg_steady (LOCAL)
and
.BR bcg_transient (LOCAL)
tools rely on the same notions of vanishing and tangible states, but do not
have to consider decision states as they do not accept ordinary transitions.

.P
In order to be accepted by \fBdeterminator\fP, the input model must satisfy
two conditions (otherwise, \fBdeterminator\fP will emit an error message 
and stop):
.IP -
No decision state can be the source state of a (possibly labelled) 
probabilistic transition.
.IP -
The model may not contain cycles of ordinary and/or (possibly labelled) 
probabilistic transitions; consequently, it necessarily contains at least 
one tangible state.

.P
Note that if there exists an ordinary transition or a (labelled) probabilistic
transition from a state \fIS1\fP to a state \fIS2\fP, then all (labelled)
stochastic transitions from \fIS1\fP, if any, are discarded, thus expressing
that ordinary and probabilistic transitions are instantaneous.

.P
Note: The sum of \fB%p\fP values on (possibly labelled) probabilistic 
transitions leaving a vanishing state needs not be equal to 1; if this
sum is different from 1, then probabilistic values will be normalized (i.e.,
divided by this sum) during determinization.

.P
The stochastic determinization algorithm used in \fBdeterminator\fP is a
variant of Deavours-Sanders' algorithm [DS99]. In a nutshell, it starts from
the initial state of the input model and recursively explores tangible states
as follows. When in a tangible state \fIS1\fP, the algorithm inspects all
states \fIS2\fP reachable from \fIS1\fP by following one single (labelled)
stochastic transition, the rate of which will be noted \fB%f\fP:

.IP -
If \fIS2\fP is a tangible state, then the transition from \fIS1\fP to \fIS2\fP
is kept in \fIresult\fP\fB.bcg\fP, and \fIS2\fP will be explored recursively;
.IP -
If \fIS2\fP is a decision or a vanishing state, then the algorithm checks a
local confluence property, namely, for each tangible state \fIS3\fP reachable
following only ordinary and probabilistic transitions, that the probability
\fB%p\fP to reach \fIS3\fP from \fIS2\fP does not depend on the choice of
the ordinary transitions followed. 
If so, a new stochastic transition from \fIS1\fP to \fIS3\fP with rate
\fB%p\fP*\fB%f\fP is added to \fIresult\fP\fB.bcg\fP, and \fIS3\fP will be
explored recursively. If not, \fBdeterminator\fP stops with an error message.

.P
Note: if the initial state \fIS0\fP is not tangible, and if one single tangible
state \fIS\fP is reachable from \fIS0\fP by following ordinary and/or
probabilistic transitions only, then \fIS\fP will form the initial state of
\fIresult\fP\fB.bcg\fP.
Otherwise, for each tangible state \fIS\fP reachable from \fIS0\fP by following
ordinary and/or probabilistic transitions only, a probabilistic transition from
\fIS0\fP to \fIS\fP (labelled with the probability to reach \fIS\fP) will be
created; this is the only case where \fIresult\fP\fB.bcg\fP will contain a
vanishing state, i.e., the only case where \fBdeterminator\fP does not produce
a continuous-time Markov chain, strictly speaking.

.SH EXIT STATUS
Exit status is 0 if everything is alright, 1 otherwise.

.SH DIAGNOSTICS
When the source is erroneous, error messages are issued.

.SH AUTHORS
The first version of the stochastic determinization was written by Christophe 
Joubert (INRIA/VASY) and Holger Hermanns (Saarland University and University 
of Twente). Frederic Lang (INRIA/VASY) deeply revised the code. Frederic Lang
and Hubert Garavel (both at INRIA/VASY) wrote the current \fBdeterminator\fP
manual page.

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
SEQ file (input)
.TP
.IB result .bcg
BCG graph (output)
.PD

.SH SEE ALSO
OPEN/CAESAR Reference Manual,
.BR bcg (LOCAL),
.BR bcg_min (LOCAL),
.BR bcg_open (LOCAL),
.BR bcg_steady (LOCAL),
.BR bcg_transient (LOCAL),
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

Please report bugs to cadp@inria.fr

.SH BIBLIOGRAPHY

.P 
[DS99] 
D. Deavours and W. Sanders.  An Efficient Well-Specified Check. In Proceedings
of the International Workshop on Petri Nets and Performance Models (PNPM'99),
pages 124-133. IEEE Computer Society Press, 1999.

.P
[HJ03] H. Hermanns and Ch. Joubert. A Set of Performance and Dependability
Analysis Components for CADP. In Proceedings of TACAS'2003, LNCS 2619, pages
425-430, Springer Verlag. Available from
http://cadp.inria.fr/publications/Hermanns-Joubert-03.html

