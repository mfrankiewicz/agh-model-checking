.\" @(#)bes_solve.l - VASY and CONVECS teams - 2020/02/11
.TH BES_SOLVE LOCAL "2020/02/11" "(C) INRIA" "CADP MANUAL PAGES"
.fp 4 CB
.lg 0
.SH NAME
bes_solve \- resolution of boolean equation systems

.SH SYNOPSIS
.B bes_solve
.RI [ general_options ]
\fIinput\fP[\fB.bes\fP[\fI.ext\fP]]
.RI [ bes_options ]
.RI [ block_options ]
[\fB-sequential\fP|\fB-parallel\fP \fIfile\fP[\fB.gcf\fP]
.RI [ global_options ]
.RI [ instance_options ]]
.sp
or:
.sp
.B bes_solve
.RI [ general_options ]
\fIinput\fP[\fB.rbc\fP]
.RI [ random_options ]
.RI [ bes_options ]
.RI [ block_options ]
[\fB-sequential\fP|\fB-parallel\fP \fIfile\fP[\fB.gcf\fP]
.RI [ global_options ]
.RI [ instance_options ]]

.SH DESCRIPTION

This program computes the value of one or several boolean variables of
interest defined in some equation block(s) of a Boolean Equation System (BES),
by applying an algorithm for local (or on-the-fly) resolution of BESs.
The value of each boolean variable of interest (TRUE or FALSE) is displayed
on the standard output. See the
.BR bes (LOCAL)
manual page for a definition of Boolean Equation Systems and their terminology.

.P
The resolution is performed using the sequential algorithms
provided by the
.BR caesar_solve_1 (LOCAL)
library of OPEN/CAESAR (see the corresponding manual page and the article
[Mat06] for details).
The resolution can be also performed using the prototype
distributed resolution algorithms described in [JM05,JM06].
Therefore,
.B bes_solve
allows to test, cross-check, and study the performance of various
local BES resolution algorithms.

.P
The BES under resolution can be represented in two different forms:
.IP -
Explicitly, as a textual BES file \fIinput\fP\fB.bes\fP,
possibly compressed according to the extension \fI.ext\fP,
containing all equations of the BES
(see 
.BR caesar_solve_1 (LOCAL)
for a description of the \fB.bes\fP format).
If the filename extension is missing for the \fIinput\fP file, the default
extension is \fB.bes\fP.
If present, the extension \fI.ext\fP must correspond to a known file
compression format (e.g., \fI.Z\fP, \fI.gz\fP, \fI.bz2\fP, etc.).
The list of currently supported extensions and compression formats is
given by the
.B $CADP/src/com/cadp_zip
shell-script.
.sp
In this case,
.B bes_solve
will first read all the BES equations contained in the
\fIinput\fP\fB.bes\fP file, and then it will solve the
boolean variables of interest on-the-fly.
.sp
The BES representation using \fB.bes\fP files allows to study
the behaviour of local resolution algorithms either on (usually small) BESs
constructed by hand, or on (usually large) BESs produced by
.BR evaluator (LOCAL)
or
.BR bisimulator (LOCAL)
as a result of encoding model checking and equivalence checking
problems, respectively.

.IP -
Implicitly, as a random BES configuration file \fIinput\fP\fB.rbc\fP
containing various parameters allowing to generate randomly
the equations of the BES
(see
.BR rbc (LOCAL)
for a description of the RBC format).
.sp
In this case,
.B bes_solve
will generate a random BES according to the parameters specified
in \fIinput\fP\fB.rbc\fP and solve the variables of interest,
both activities being carried out on-the-fly.
.sp
The BES representation using \fB.rbc\fP files provides a very compact
encoding for complex BESs with various forms.
Moreover, since it consumes very few memory and CPU resources,
random BES generation allows to measure the performance of resolution
algorithms accurately on large examples of BESs.

.SH BOOLEAN EQUATION SYSTEMS

A BES is a collection of N equation blocks having unique numbers in the
range [0..N-1].
A block is a set of recursive equations containing boolean variables
in their left-hand sides and boolean formulas (defined over variables
and the boolean constants \fBtrue\fP and \fBfalse\fP) in their
right-hand sides.

.P
A variable Xk defined in a block Bi depends upon a variable Xl defined 
in a block Bj if Xl occurs in the right-hand side of the equation 
defining Xk. A block Bi depends upon a block Bj if some variable of 
Bi depends upon some variable of Bj. 

.P
For further details on BESs, see the
.BR caesar_solve_1 (LOCAL)
manual page.

.SH GENERAL OPTIONS

The following options specify various forms of output, but do not
influence the resolution.

.TP
\fB-bes\fP \fIoutput\fP[\fB.bes\fP[\fI.ext\fP]]
If a single variable of interest is considered for resolution (see option
\fB-variable\fP), print in file \fIoutput\fP[\fB.bes\fP] the portion of the
BES reachable from that variable along variable dependencies.
If several variables of interest are considered, for each variable of index
\fIi\fP defined in the block of index \fIj\fP, print in file
\fIoutput_i_j\fP[\fB.bes\fP] the portion of the BES reachable from that
variable along variable dependencies.
If the extension \fB.bes\fP\fI.ext\fP is present, the file
containing the BES portion is compressed according to the corresponding
format.
Not a default option.

.TP
\fB-diag\fP \fIdiag\fP[\fB.bes\fP[\fI.ext\fP]]
If a single variable of interest is considered for resolution (see option
\fB-variable\fP), print in file \fIdiag\fP[\fB.bes\fP] a diagnostic
(portion of the BES) explaining the truth value of that variable.
If several variables of interest are considered, for each variable of index
\fIi\fP defined in the block of index \fIj\fP, print in file
\fIdiag_i_j\fP[\fB.bes\fP] a diagnostic (portion of the BES) explaining
the truth value of that variable.
If the extension \fB.bes\fP\fI.ext\fP is present, the file
containing the diagnostic is compressed according to the corresponding
format.
This option is mutually exclusive with \fB-nosolve\fP.
Not a default option.

.TP
.B \-nosolve
Do not perform the resolution of the BES.
This option is mutually exclusive with \fB-diag\fP.
Not a default option.

.TP
.B \-silent
Execute silently. Opposite of \fB-verbose\fP. Default option.

.TP
.B \-stat
Display statistical information about the resolution of the BES.
Not a default option.
.sp
Note: The number of boolean variables and dependencies displayed by the
\fB-stat\fP option is generally smaller than the number of variables and
dependencies of the BES contained in the \fIoutput\fP.\fBbes\fP file
created with the \fB-nosolve\fP option.
This is due to the on-the-fly nature of the resolution algorithms,
which terminate as soon as they have determined the value of the variables
of interest.

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

.P
The following options specify how the resolution is carried out.

.TP
\fB-sequential\fP
Perform the resolution of the BES in a sequential manner, by applying
the resolution algorithms provided by the
.BR caesar_solve_1 (LOCAL)
library.
This option is mutually exclusive with \fB-parallel\fP.
Default option.

.TP
\fB-parallel\fP \fIfile\fP[\fB.gcf\fP] [\fIglobal_options\fP] [\fIinstance_options\fP]
Perform the resolution of the BES in a distributed manner, using several
machines connected by a network. The list of these machines, together with
various directives tuning the distributed computation, is given in the
grid configuration file \fIfile\fP[\fB.gcf\fP]
(see the
.BR distributor (LOCAL)
manual page for details about the GCF format).
The lists of options \fIglobal_options\fP and \fIinstance_options\fP
can be used for last-minute changes to the settings of the grid configuration
file \fIfile\fP[\fB.gcf\fP]. See the
.BR distributor (LOCAL)
manual page for a description of these options.
This option is mutually exclusive with \fB-sequential\fP.
Not a default option.

.TP
\fB-variable\fP \fIv0\fP \fIb0\fP ...  \fIvn\fP \fIbn\fP
Indicates the indexes \fIv0\fP, ..., \fIvn\fP of the variables of interest
and the indexes \fIb0\fP, ..., \fIbn\fP of the equation blocks defining
those variables (\fIn\fP >= 0). The default value for \fIn\fP is 0 (i.e.,
only one variable of interest is considered for resolution) and the default
value for both \fIv0\fP and \fIb0\fP is 0. If some \fIbi\fP is the index of
a block undefined in the BES, or if some \fIvj\fP is the index of a variable
undefined in the block of index \fIbj\fP
(where 0 <= \fIi\fP, \fIj\fP <= \fIn\fP),
then an error message is issued and the execution is aborted.
Not a default option.

.SH RANDOM, B\&E\&S, AND BLOCK OPTIONS

The options \fIrandom_options\fP, \fIbes_options\fP, and \fIblock_options\fP
are described in the
.BR rbc (LOCAL)
manual page.

.P
When the input is a textual BES file \fIinput\fP\fB.bes\fP,
the only directives \fIbes_options\fP and \fIblock_options\fP that have
effect on the equation blocks of the BES are those concerning
the variables \fBunique_resolution\fP and \fBsolve_mode\fP.

.P
To provide for last-minute changes, the contents of the RBC
file can be extended on the command line using the
options \fIrandom_options\fP, \fIbes_options\fP, and \fIblock_options\fP.
The RBC file can even be empty, in which
case \fIinput\fP\fB.rbc\fP should be replaced with "-" on the command line.

.SH EXIT STATUS
Exit status is 0 if everything is alright, 1 otherwise.

.SH DIAGNOSTICS
When the source is erroneous, error messages are issued.

.SH BIBLIOGRAPHY

.P
[JM05]
Ch. Joubert and R. Mateescu.
Distributed Local Resolution of Boolean Equation Systems.
In Francisco Tirado and Manuel Prieto (Eds.), Proceedings of the 13th
Euromicro Conference on Parallel, Distributed and Network-Based Processing
PDP'2005 (Lugano, Switzerland), pp. 264-271. IEEE Computer Society,
February 2005. Available from
http://cadp.inria.fr/publications/Joubert-Mateescu-05.html

.P
[JM06]
Ch. Joubert and R. Mateescu.
Distributed On-the-Fly Model Checking and Test Case Generation.
In Antti Valmari (Ed.), Proceedings of the 13th International Workshop on
Model Checking of Software SPIN'2006 (Vienna, Austria), Lecture Notes in
Computer Science vol. 3925, pp. 126-145. Springer Verlag, March-April 2006.
Available from http://cadp.inria.fr/publications/Joubert-Mateescu-06.html

.P
[Mat06]
R. Mateescu.
CAESAR_SOLVE: A Generic Library for On-the-Fly Resolution of
Alternation-Free Boolean Equation Systems.
Springer International Journal on Software Tools for Technology Transfer
(STTT), v. 8, no. 1, p. 37-56, 2006. Full version available as INRIA Research
Report RR-5948. Available from
http://cadp.inria.fr/publications/Mateescu-06-a.html

.SH AUTHORS

A prototype version of \fBbes_solve\fP was developed by Christophe Joubert
and subsequently enhanced by Jerome Fereyre (both at INRIA/VASY).

.P
Version 1.0 of \fBbes_solve\fP was entirely rewritten and documented
by Radu Mateescu (INRIA/VASY), who also defined and implemented the RBC
file format.

.P
The option \fB-parallel\fP invokes the distributed BES resolution algorithm
proposed in [JM06]. The implementation of this algorithm was a long-term
effort carried out (chronologically) by Christophe Joubert, Jerome Fereyre,
Hubert Garavel, Remi Herilier, Wendelin Serwe, Iker Bellicot,
and Radu Mateescu.

.SH OPERANDS
.PD 0
.TP 20
.IB input .rbc
random BES configuration file (input)
.TP
.IB input .bes[.ext]
BES text file (input)
.TP
.IB output .bes[.ext]
BES text file (output)
.TP
.IB diag .bes[.ext]
diagnostic BES text file (output)
.PD

.SH FILES

.P
The binary code of \fBbes_solve\fP is available in $CADP/bin.`arch`/bes_solve

.P
See the
.BR caesar_solve_1 (LOCAL)
manual page for a description of the \fB.bes\fP files.

.SH SEE ALSO
OPEN/CAESAR Reference Manual,
.BR bes (LOCAL),
.BR bisimulator (LOCAL),
.BR caesar_solve_1 (LOCAL),
.BR evaluator (LOCAL),
.BR lotos.open (LOCAL),
.BR rbc (LOCAL)

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

Please report bugs to Radu.Mateescu@inria.fr.

