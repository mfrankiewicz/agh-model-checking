.\" @(#)evaluator.l - VASY and CONVECS teams - 2019/04/10
.TH EVALUATOR LOCAL "2019/04/10" "(C) INRIA" "CADP MANUAL PAGES"
.fp 4 CB
.lg 0
.SH NAME
evaluator \- a family of on-the-fly model checkers

.SH DESCRIPTION

.B evaluator
denotes a family of on-the-fly model checkers of CADP based on
the modal mu-calculus. These tools take as inputs a
Labelled Transition System (LTS) and a temporal logic formula,
and produce as output a verdict indicating whether the LTS
satisfies the formula or not, optionally accompanied by a
diagnostic (fragment of the LTS) illustrating the verdict.

.P
On the theoretical side, these model checkers rely on the
resolution of Boolean Equation Systems (BES), Parameterized
Boolean Equation Systems (PBES), and Linear Equation Systems (LES).
On the practical side, they are implemented using the OPEN/CAESAR
framework of CADP for on-the-fly verification.

.P
Three versions of
.B evaluator
are currently available:

.IP -
.B evaluator3 (see the
.BR evaluator3 (LOCAL)
manual page)
is an on-the-fly model checker for \fIMCL\fP version 3,
an extension of the alternation-free mu-calculus with action predicates
and regular expressions over action sequences. In the temporal formulas
of \fIMCL\fP version 3, LTS actions are merely character strings. See the
.BR mcl3 (LOCAL)
manual page for details.
.sp

.IP -
.B evaluator4 (see the
.BR evaluator4 (LOCAL)
manual page)
is an on-the-fly model checker for \fIMCL\fP version 4,
an extension of \fIMCL\fP version 3 with data-handling constructs
(data variables, expressions, parameterized fixed point operators,
programming language constructs) and an infinite looping operator
able to express fairness properties. In the temporal formulas
of \fIMCL\fP version 4, LTS actions are tuples containing channel names
and data values, which can be extracted and used in calculations. See the
.BR mcl4 (LOCAL)
manual page for details.

.IP -
.B evaluator5 (see the
.BR evaluator5 (LOCAL)
manual page)
is an on-the-fly model checker for \fIMCL\fP version 5,
an extension of \fIMCL\fP version 4 with a probabilistic operator
specifying the probability of transition sequences characterized
by generalized regular formulas. This probabilistic operator is
interpreted on Probabilistic Transition Systems (PTSs), which are
LTSs whose actions contain channel names, data values, and
probabilities. See the
.BR mcl5 (LOCAL)
manual page for details.

.P
Note: Currently, for backward compatibility reasons,
.B evaluator
(located in \fB$CADP/bin.*/evaluator.a\fP)
is a shorthand for
.B evaluator3
(located in \fB$CADP/bin.*/evaluator3.a\fP).

.SH HISTORY AND AUTHORS

Versions 1.x and 2.x of EVALUATOR were developed by
Marius Dorel Bozga (IMAG) and used an on-the-fly BES resolution algorithm
proposed by J-C. Fernandez and L. Mounier. These versions, which accepted as
input alternation-free modal mu-calculus (without regular expressions), are
no longer available.
.P
Version 3.0 of EVALUATOR was developed by Radu Mateescu and Mihaela Sighireanu
(both at INRIA/VASY) and used a completely new on-the-fly BES resolution
algorithm.
Hubert Garavel (INRIA/VASY) suggested the enhancement of action formulas
with the string concatenation operator, which was implemented by
David Champelovier (INRIA/VASY).
.P
Versions 3.5 and 3.6 of EVALUATOR replaced the dedicated BES resolution
algorithm by the more general algorithms available in the
.BR caesar_solve_1 (LOCAL)
library of OPEN/CAESAR for on-the-fly BES resolution. All of this was
implemented by Radu Mateescu (INRIA/VASY).
.P
Version 4.0 of EVALUATOR handles version 4 of the \fIMCL\fP language.
It was implemented by Radu Mateescu and Damien Thivolle (both at INRIA/VASY).
.P
Version 5.0 of EVALUATOR handles version 5 of the \fIMCL\fP language.
It was implemented by Radu Mateescu (INRIA/CONVECS).

.SH SEE ALSO

.BR evaluator3 (LOCAL),
.BR evaluator4 (LOCAL),
.BR evaluator5 (LOCAL),
.BR mcl (LOCAL),
.BR mcl3 (LOCAL),
.BR mcl4 (LOCAL),
.BR mcl5 (LOCAL)
.P
Additional information is available from the CADP Web page located at http://cadp.inria.fr
.P
Directives for installation are given in files \fB$CADP/INSTALLATION_*\fP.
.P
Recent changes and improvements to this software are reported
and commented in file \fB$CADP/HISTORY\fP.

.SH BUGS

Please report bugs to Radu.Mateescu@inria.fr

