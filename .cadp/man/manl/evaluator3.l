.\" @(#)evaluator3.l - VASY and CONVECS teams - 2020/02/12
.TH EVALUATOR3 LOCAL "2020/02/12" "(C) INRIA" "CADP MANUAL PAGES"
.fp 4 CB
.lg 0
.SH NAME
evaluator3 \- on-the-fly model checking of MCL v3 formulas

.SH SYNOPSIS

.B bcg_open
.RI [ bcg_opt ]
\fIspec\fP[\fB.bcg\fP]
.RI [ cc_opt ]
.B evaluator3
.RI [ evaluator_opt ]
\fIprop\fP[\fB.mcl\fP]
.sp
or:
.sp
.B exp.open
.RI [ exp_opt ]
\fIspec\fP[\fB.exp\fP]
.RI [ cc_opt ]
.B evaluator3
.RI [ evaluator_opt ]
\fIprop\fP[\fB.mcl\fP]
.sp
or:
.sp
.B fsp.open
.RI [ fsp_opt ]
\fIspec\fP[\fB.lts\fP]
.RI [ cc_opt ]
.B evaluator3
.RI [ evaluator_opt ]
\fIprop\fP[\fB.mcl\fP]
.sp
or:
.sp
.B lnt.open
.RI [ lnt_opt ]
\fIspec\fP[\fB.lnt\fP]
.RI [ cc_opt ]
.B evaluator3
.RI [ evaluator_opt ]
\fIprop\fP[\fB.mcl\fP]
.sp
or:
.sp
.B lotos.open
.RI [ lotos_opt ]
\fIspec\fP[\fB.lotos\fP]
.RI [ cc_opt ]
.B evaluator3
.RI [ evaluator_opt ]
\fIprop\fP[\fB.mcl\fP]
.sp
or:
.sp
.B seq.open
.RI [ seq_opt ]
\fIspec\fP[\fB.seq\fP]
.RI [ cc_opt ]
.B evaluator3
.RI [ evaluator_opt ]
\fIprop\fP[\fB.mcl\fP]

.SH DESCRIPTION

.B evaluator3
takes two different inputs:

.IP -
A Labelled Transition System, expressed either as a BCG graph
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
A temporal logic property, contained in the file \fIprop\fP[\fB.mcl\fP],
expressed as a \fIMCL\fP version 3 formula (i.e., a formula of the regular
alternation-free mu-calculus). See the
.BR mcl3 (LOCAL)
manual page for a complete definition of \fIMCL\fP version 3.

.P
.B evaluator3
performs an on-the-fly verification of the temporal
property on the given Labelled Transition System (LTS for short).
The result of this verification (TRUE or FALSE) is displayed
on the standard output, possibly accompanied by a diagnostic
(see OPTIONS below).

.P
Note: The verification method underlying the current version of
\fBevaluator3\fP is based upon a translation of the model checking
problem into the resolution of a Boolean Equation System (BES),
which is performed on-the-fly using the algorithms provided by the
.BR caesar_solve_1 (LOCAL)
library of OPEN/CAESAR (see the corresponding manual page and the
article [Mat06] for details). Complete descriptions of regular
alternation-free mu-calculus and of the verification method are
available in [MS03] (the reference article for version 3.0 of EVALUATOR)
and in [Mat06] (the reference article for versions 3.5 and 3.6 of
EVALUATOR).
.sp
A newer version of the model checker is also available as
.BR evaluator4 (LOCAL)
(see the corresponding manual page for details).

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
The following options \fIevaluator_opt\fP are currently available:

.TP
\fB-bes\fP [ \fIfile\fP[\fB.bes\fP[\fI.ext\fP]] ]
Print in \fIfile\fP[\fB.bes\fP] or, if the file name argument is missing,
in file \fBevaluator.bes\fP, a textual description of the BES
corresponding to the evaluation of the formula on the LTS.
If present, the extension \fI.ext\fP must correspond to a known file
compression format (e.g., \fI.Z\fP, \fI.gz\fP, \fI.bz2\fP, etc.).
In this case, the file containing the BES is compressed according to
the corresponding format.
The list of currently supported extensions and compression formats is
given by the
.B $CADP/src/com/cadp_zip
shell-script.
This option does not influence the evaluation of the formula.
Not a default option.

.TP
.B \-block
Assume that the property is specified as a system of modal equations
in a file \fIfile\fP[\fB.blk\fP] that must be given as argument
to \fBevaluator3\fP instead of \fIprop\fP[\fB.mcl\fP]. This option is mainly
intended for debugging purposes. The format of the input file is
undocumented and subject to future changes. Not a default option.

.TP
.B \-acyclic
Evaluate the formula on the LTS using an algorithm optimized for acyclic
graphs.
If option \fB-dfs\fP is present (which is the case by default), the tool
checks during verification whether the LTS contains cycles; if this is
the case, an error message is displayed and the execution is aborted.
If option \fB-bfs\fP is present, the tool may not always detect the
presence of cycles in the LTS, and hence it may enter an infinite loop;
in this case, it is the user's responsibility to ensure that the LTS
is acyclic.
If the formula is unguarded (see Section STATE FORMULAS of the
.BR mcl3 (LOCAL)
manual page), which may yield
a BES with cyclic dependencies between variables even if the LTS is acyclic,
an error message is displayed and the execution is aborted.
Not a default option.

.TP
.B \-bfs
Evaluate the formula on the LTS using a breadth-first search algorithm.
Compared to \fB-dfs\fP, this option is generally slower, but
produces diagnostics of smaller depth.
If option \fB-acyclic\fP is present, the breadth-first search algorithm
is optimized for reducing memory consumption: in particular, if the LTS
is a sequence, the memory used for verification is bounded by the size of
the formula (number of operators) and independent of the length of the
sequence (number of transitions).
Not a default option.

.TP
.B \-dfs
Evaluate the formula on the LTS using a depth-first search algorithm.
Compared to \fB-bfs\fP, this option produces diagnostics of greater depth,
but is generally faster and consumes less memory for certain classes of
formulas (such as those shown in Section EXAMPLES OF TEMPORAL PROPERTIES
in the
.BR mcl3 (LOCAL)
manual page).
Default option.

.TP
\fB-diag\fP [ \fIdiag\fP[\fB.bcg\fP] ]
Generate a diagnostic in BCG format (see the
.BR bcg (LOCAL)
manual page for details)
explaining the truth value of the formula. The diagnostic is generated
in the file \fIdiag\fP[\fB.bcg\fP] or, if the file name argument is missing,
in the file \fBevaluator.bcg\fP.
The BCG files containing diagnostics can be visualized using the
.BR bcg_draw (LOCAL)
and
.BR bcg_edit (LOCAL)
tools of CADP (see respective manual pages for details).
Diagnostics are (usually small) portions of the LTS on which the
formula yields the same result as when it is evaluated on the whole LTS.
If the diagnostic is a sequence of LTS transitions, it will also be
displayed on standard output using the SEQ format (see the
.BR seq (LOCAL)
manual page
for the definition of this format). Not a default option.

.TP
.B \-depend
Display the list of library files included (directly or transitively)
in the file \fIprop\fP[\fB.mcl\fP] and stop. This list may be incomplete
if the formula is syntactically incorrect. If present, this option
has precedence over all the other options. Not a default option.

.TP
.B \-expand
Expand the macro definitions and the source files included as
libraries in the file \fIprop\fP[\fB.mcl\fP], producing as output a
file \fIprop\fP\fB.xm\fP, and stop. This option is useful for
debugging purposes. Not a default option.

.TP
.B \-silent
Execute silently. Opposite of \fB-verbose\fP. Default option.

.TP
\fB-source\fP \fIfile\fP:\fIline\fP
Change the file name and line number displayed in error messages
as if the formula was contained in file \fIfile\fP starting at
line \fIline\fP (instead of starting at line 1 in file
\fIprop\fP[\fB.mcl\fP]).
This option has effect only on the messages triggered by the errors
occurring in the top-level file \fIprop\fP[\fB.mcl\fP]. The messages
triggered by the errors occurring in the included libraries
(if any) are left unchanged.

.TP
.B \-stat
Display statistical information about the resolution of the BES
corresponding to the evaluation of the formula on the LTS.
Not a default option.

.TP
.B \-tauconfluence
Reduce the LTS on-the-fly modulo tau-confluence (a form of partial
order reduction that preserves branching equivalence) while evaluating
the formula. This option can be safely used only for verifying formulas
adequate w.r.t. branching equivalence, i.e., whose evaluation yields
the same result on all branching equivalent LTSs. For example, formulas
belonging to the fragment ACTL-X (i.e., ACTL without the next time
operators) are adequate w.r.t. branching equivalence [DV90]. In some
cases, this option may improve speed and memory consumption significantly.
Not a default option.

.TP
.B \-verbose
Animate the user's screen, telling what is going on.
Opposite of \fB-silent\fP. Default option is \fB-silent\fP.

.TP
.B \-version
Display the current version number of the tool and stop.
To be effective, this option should occur as the first argument
on the command line. Subsequent options and/or arguments, if any,
will be discarded. Not a default option.

.SH EXIT STATUS

Exit status is 0 if everything is alright, 1 otherwise.

.SH DIAGNOSTICS

When the source file \fIprop\fP[\fB.mcl\fP] is erroneous, error messages
are issued.

.SH BIBLIOGRAPHY

.TP
[DV90]
R. De Nicola and F. W. Vaandrager.
"Action versus State based Logics for Transition Systems."
Proceedings Ecole de Printemps on Semantics of Concurrency,
LNCS v. 469, p. 407-419, 1990.

.TP
[Mat06]
R. Mateescu.
"CAESAR_SOLVE: A Generic Library for On-the-Fly Resolution of
Alternation-Free Boolean Equation Systems."
Springer International Journal on Software Tools for Technology Transfer
(STTT), v. 8, no. 1, p. 37-56, 2006. Full version available as INRIA Research
Report RR-5948.
Available from http://cadp.inria.fr/publications/Mateescu-06-a.html

.TP
[MS03]
R. Mateescu and M. Sighireanu.
"Efficient On-the-Fly Model-Checking for Regular Alternation-Free Mu-Calculus."
Science of Computer Programming, v. 46, no. 3, p. 255-281, 2003.
Available from http://cadp.inria.fr/publications/Mateescu-Sighireanu-03.html

.SH AUTHORS

See the AUTHORS section of the
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
regular mu-calculus formula (input)
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
.BR caesar (LOCAL),
.BR evaluator (LOCAL),
.BR evaluator4 (LOCAL),
.BR exhibitor (LOCAL),
.BR exp (LOCAL),
.BR exp.open (LOCAL),
.BR fsp.open (LOCAL),
.BR lnt.open (LOCAL),
.BR lotos (LOCAL),
.BR lotos.open (LOCAL),
.BR mcl (LOCAL),
.BR mcl3 (LOCAL),
.BR mcl4 (LOCAL),
.BR seq (LOCAL),
.BR seq.open (LOCAL),
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

