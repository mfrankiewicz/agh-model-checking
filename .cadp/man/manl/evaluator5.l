.\" @(#)evaluator5.l - VASY and CONVECS teams - 2020/02/12
.TH EVALUATOR5 LOCAL "2020/02/12" "(C) INRIA" "CADP MANUAL PAGES"
.fp 4 CB
.lg 0
.SH NAME
evaluator5 \- on-the-fly model checking of MCL v5 formulas

.SH SYNOPSIS

.B bcg_open
.RI [ bcg_opt ]
\fIspec\fP[\fB.bcg\fP]
.RI [ cc_opt ]
.B evaluator5
.RI [ evaluator_opt ]
\fIprop\fP[\fB.mcl\fP]
.sp
or:
.sp
.B exp.open
\fIspec\fP[\fB.exp\fP]
.RI [ cc_opt ]
.B evaluator5
.RI [ evaluator_opt ]
\fIprop\fP[\fB.mcl\fP]
.sp
or:
.sp
.B fsp.open
.RI [ fsp_opt ]
\fIspec\fP[\fB.lts\fP]
.RI [ cc_opt ]
.B evaluator5
.RI [ evaluator_opt ]
\fIprop\fP[\fB.mcl\fP]
.sp
or:
.sp
.B lnt.open
.RI [ lnt_opt ]
\fIspec\fP[\fB.lnt\fP]
.RI [ cc_opt ]
.B evaluator5
.RI [ evaluator_opt ]
\fIprop\fP[\fB.mcl\fP]
.sp
or:
.sp
.B lotos.open
.RI [ lotos_opt ]
\fIspec\fP[\fB.lotos\fP]
.RI [ cc_opt ]
.B evaluator5
.RI [ evaluator_opt ]
\fIprop\fP[\fB.mcl\fP]
.sp 
or: 
.sp
.B seq.open
\fIspec\fP[\fB.seq\fP]
.RI [ cc_opt ]
.B evaluator5
.RI [ evaluator_opt ]
\fIprop\fP[\fB.mcl\fP]

.SH DESCRIPTION

.B evaluator5
takes two inputs:

.IP -
A Probabilistic Transition System (PTS for short), expressed either
as a BCG graph
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
See the
.BR mcl5 (LOCAL)
manual page for the definition of the PTS model.

.IP -
A temporal logic property, contained in the file \fIprop\fP[\fB.mcl\fP],
expressed as a formula in the \fIMCL\fP version 5 language. See the
.BR mcl5 (LOCAL)
manual page for a complete definition of the \fIMCL\fP version 5 language.
.P
.B evaluator5
performs an on-the-fly verification of the temporal property on the given PTS.
The result of this verification (TRUE or FALSE, preceded by the values
of probabilities if they are requested by the probabilistic operators
contained in \fIprop\fP[\fB.mcl\fP]) is displayed.
.P
The verification method underlying
.B evaluator5
is based upon a translation of the probabilistic model checking
problem into the resolutions of a Linear Equation System (LES) and
a Parameterized Boolean Equation System (PBES), as described in [MR18].
These resolutions are carried out simultaneously and on the fly,
using the algorithms provided by the
.BR caesar_solve_1 (LOCAL)
and
.BR caesar_solve_2 (LOCAL)
libraries of OPEN/CAESAR (see the corresponding manual pages and the
articles [Mat06,MR18] for details).

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
The options \fIevaluator_opt\fP are the same as those of
evaluator4 (see the
.BR evaluator4 (LOCAL)
manual page), with the following addition:

.TP
\fB-epsilon\fP \fIeps\fP
Set the precision of certain floating-point comparisons to \fIeps\fP, where
\fIeps\fP is a real value. When \fIeps\fP is out of [0..1[, \fBevaluator5\fP
reports an error. Default value for \fIeps\fP is 1E-6.

.SH EXIT STATUS

Exit status is 0 if everything is alright, 1 otherwise.

.SH DIAGNOSTICS

When the source file \fIprop\fP[\fB.mcl\fP] is erroneous, error messages
are issued.

.SH BIBLIOGRAPHY

.TP
[Mat06]
R. Mateescu.
"CAESAR_SOLVE: A Generic Library for On-the-Fly Resolution of
Alternation-Free Boolean Equation Systems."
Springer International Journal on Software Tools for Technology Transfer
(STTT) 8(1):37-56, 2006. Full version available as INRIA Research
Report RR-5948.
Available from http://cadp.inria.fr/publications/Mateescu-06-a.html

.TP
[MR18]
R. Mateescu and J. I. Requeno.
"On-the-Fly Model Checking for Extended Action-Based Probabilistic Operators."
Springer International Journal on Software Tools for Technology Transfer
(STTT) 20(5):563-587, 2018.
Available from http://hal.inria.fr/hal-01862754/en

.SH AUTHORS

Version 5.0 of EVALUATOR handles version 5 of the \fIMCL\fP language.
It was implemented by Radu Mateescu (INRIA/CONVECS).

.P
For the previous versions of EVALUATOR, see the AUTHORS section of the
.BR evaluator (LOCAL)
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
sequence file (input)
.TP
.IB prop .mcl
MCL version 5 formula (input)
.TP
.IB diag .bcg
diagnostic in BCG format (output)
.TP
.IB file .bes
BES in textual format (output)

.PD
.SH FILES
.PD 0
.TP 25
.B $CADP/src/xtl/*\fI.mcl\fP
predefined libraries (input)
.PD

.SH SEE ALSO

.BR bcg (LOCAL),
.BR bcg_open (LOCAL),
.BR caesar.adt (LOCAL),
.BR caesar_graph (LOCAL),
.BR caesar_solve_1 (LOCAL),
.BR caesar_solve_2 (LOCAL),
.BR caesar (LOCAL),
.BR evaluator4 (LOCAL),
.BR exhibitor (LOCAL),
.BR exp (LOCAL),
.BR exp.open (LOCAL),
.BR fsp.open (LOCAL),
.BR lnt.open (LOCAL),
.BR lotos (LOCAL),
.BR lotos.open (LOCAL),
.BR mcl (LOCAL),
.BR regexp (LOCAL),
.BR seq (LOCAL),
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

