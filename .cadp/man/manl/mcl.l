.\" @(#)mcl.l - VASY and CONVECS teams - 2019/04/01
.TH MCL LOCAL "2019/04/01" "(C) INRIA" "CADP MANUAL PAGES"
.fp 4 CB
.lg 0
.SH NAME
mcl, MCL \- Model Checking Language (versions 3, 4, and 5)

.SH DESCRIPTION

\fIMCL\fP (\fIModel Checking Language\fP) is an action-based, branching-time
temporal logic suitable for expressing properties of concurrent systems.
\fIMCL\fP is interpreted on Labelled Transition Systems (LTSs).

.P
Three versions of \fIMCL\fP are currently available:

.IP -
\fIMCL\fP version 3 (regular alternation-free mu-calculus) [MS03, Mat06]
is an extension of the alternation-free fragment of the modal
mu-calculus [Koz83, EL86] with action predicates similar to those of
\fIACTL\fP [DV90] and regular expressions over action sequences
similar to those of \fIPDL\fP [FL79].
In the temporal formulas of \fIMCL\fP version 3, the LTS actions are
merely character strings.
.sp
A description of \fIMCL\fP version 3 can be found in the
.BR mcl3 (LOCAL)
manual page.
.sp
\fIMCL\fP version 3 is supported by the
.BR evaluator3 (LOCAL)
on-the-fly model checker.

.IP -
\fIMCL\fP version 4 (value-passing modal mu-calculus) [MT08]
is an extension of \fIMCL\fP version 3 with data-handling constructs
(data variables, expressions, parameterized fixed point operators,
programming language constructs) and an infinite looping operator
similar to that of \fIPDL-delta\fP [Str82], able to express
fairness properties.
In the temporal formulas of \fIMCL\fP version 4, the LTS actions are
tuples containing channel names and data values, which can be extracted
and used in calculations, as originally proposed in the RICO logic [Gar89].
.sp
A description of \fIMCL\fP version 4 can be found in the
.BR mcl4 (LOCAL)
manual page.
.sp
\fIMCL\fP version 4 is supported by the
.BR evaluator4 (LOCAL)
on-the-fly model checker.

.IP -
\fIMCL\fP version 5 (probabilistic value-passing modal mu-calculus) [MR18]
is an extension of \fIMCL\fP version 4 with a probabilistic operator
specifying the probability of transition sequences described using
generalized regular formulas.
\fIMCL\fP version 5 is interpreted on Probabilistic Transition Systems (PTSs)
[LS91], whose transitions are labeled by actions containing channel names,
data values, and probabilities.
.sp
A description of \fIMCL\fP version 5 can be found in the
.BR mcl5 (LOCAL)
manual page.
.sp
\fIMCL\fP version 5 is supported by the
.BR evaluator5 (LOCAL)
on-the-fly model checker.

.SH BIBLIOGRAPHY

.TP
[DV90]
R. De Nicola and F. W. Vaandrager.
"Action versus State based Logics for Transition Systems."
Proceedings Ecole de Printemps on Semantics of Concurrency,
LNCS v. 469, p. 407-419, 1990.

.TP
[EL86]
E. A. Emerson and C-L. Lei.
"Efficient Model Checking in Fragments of the Propositional Mu-Calculus."
Proceedings of the 1st LICS, p. 267-278, 1986.

.TP
[FL79]
M. J. Fischer and R. E. Ladner.
"Propositional Dynamic Logic of Regular Programs."
Journal of Computer and System Sciences, no. 18, p. 194-211, 1979.

.TP
[Gar89]
H. Garavel. 
Chapter 9 of "Compilation et verification de programmes LOTOS."
PhD thesis, Universite Joseph-Fourier Grenoble, 1989.
Available from http://cadp.inria.fr/publications/Garavel-89-b.html

.TP
[Koz83]
D. Kozen.
"Results on the Propositional Mu-Calculus."
Theoretical Computer Science, v. 27, p. 333-354, 1983.

.TP
[LS91]
K. G. Larsen and A. Skou.
"Bisimulation through Probabilistic Testing."
Information and Computation, v. 94, no. 1, p. 1-28, 1991.

.TP
[MR18]
R. Mateescu and J. I. Requeno.
"On-the-Fly Model Checking for Extended Action-Based Probabilistic Operators."
Springer International Journal on Software Tools for Technology Transfer
(STTT), v. 20, no. 5, p. 563-587, 2018.

.TP
[MS03]
R. Mateescu and M. Sighireanu.
"Efficient On-the-Fly Model-Checking for Regular Alternation-Free Mu-Calculus."
Science of Computer Programming, v. 46, no. 3, p. 255-281, 2003.
Available from http://cadp.inria.fr/publications/Mateescu-Sighireanu-03.html

.TP
[MT08]
R. Mateescu and D. Thivolle.
"A Model Checking Language for Concurrent Value-Passing Systems."
Proceedings of the 15th International Symposium on Formal Methods
FM'08, LNCS v. 5014, p. 148-164, 2008.
Available from http://cadp.inria.fr/publications/Mateescu-Thivolle-08.html

.TP
[Str82]
R. S. Streett.
"Propositional Dynamic Logic of Looping and Converse."
Information and Control, v. 54, p. 121-141, 1982.

.SH SEE ALSO

.BR evaluator (LOCAL),
.BR evaluator3 (LOCAL),
.BR evaluator4 (LOCAL),
.BR mcl3 (LOCAL),
.BR mcl4 (LOCAL),
.BR regexp (LOCAL)
.P
Additional information is available from the CADP Web page located at http://cadp.inria.fr
.P
Directives for installation are given in files \fB$CADP/INSTALLATION_*\fP.
.P
Recent changes and improvements to this software are reported
and commented in file \fB$CADP/HISTORY\fP.

.SH BUGS

Please report bugs to Radu.Mateescu@inria.fr

