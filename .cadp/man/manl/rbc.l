.\" @(#)rbc.l - VASY and CONVECS teams - 2020/02/11
.TH RBC LOCAL "2020/02/11" "(C) INRIA" "CADP MANUAL PAGES"
.fp 4 CB
.lg 0
.SH NAME
rbc, RBC \- textual file format for random BES (Boolean Equation Systems) configuration

.SH DESCRIPTION

An RBC (Random BES Configuration) file \fIfilename\fP\fB.rbc\fP specifies
a set of parameters controlling the random generation of a
Boolean Equation System (BES). See the
.BR bes (LOCAL)
manual page for a definition of Boolean Equation Systems and their terminology.

.P
The BES specified by the RBC file can be generated and solved on the fly using the
.BR bes_solve (LOCAL)
tool, which computes the value of one or several boolean variables of interest
defined in some equation block(s) of the BES.

.SH SYNTAX OF THE R\&B\&C FORMAT

The format of \fIfilename\fP\fB.rbc\fP is defined by the following BNF grammar:

.nf
   <rbc>              ::= <random_options>
                          <bes_options>
                          <block_options>*
   <random_options>   ::= <random_directive>*
   <random_directive> ::= <random_variable> "=" <value> "\\n"
   <random_variable>  ::= "number_of_blocks"
                       |  "alternation_free"
                       |  "strategy"
   <bes_options>      ::= <directive>*
   <block_options>    ::= <block_set>+ <directive>*
   <block_set>        ::= <interval>+ "\\n"
   <interval>         ::= <block_index>
                       |  "["<block_index>".."<block_index>"]"
   <directive>        ::= <variable> "=" <value> "\\n"
   <variable>         ::= "sign"
                       |  "unique_resolution"
                       |  "solve_mode"
                       |  "number_of_variables"
                       |  "equation_length"
                       |  "variable_ratio"
                       |  "local_variable_ratio"
                       |  "or_variable_ratio"
                       |  "or_variable_alternation"
                       |  "false_constant_ratio"
                       |  "shape"
   <value>            ::= <character-string>
.fi

.P
where:

.IP -
\fB<random_options>\fP is a (possibly empty) list of directives applicable
to the BES.

.IP -
\fB<bes_options>\fP is a (possibly empty) list of directives applicable to
every equation block of the BES.

.IP -
\fB<block_options>\fP defines a set of block indexes together with a 
(possibly empty) list of directives applicable to these blocks exclusively.

.IP -
\fB<interval>\fP is an interval on natural numbers denoting a set of
indexes of equation blocks of the BES. An \fB<interval>\fP can contain
either a single index specified as \fB<block_index>\fP, or a range of
block indexes specified
as "\fB[\fP"\fB<block_index>\fP".."\fB<block_index>\fP"\fB]\fP".

.IP -
\fB<block_index>\fP is a natural number denoting the index of an
equation block of the BES.

.IP -
\fB<random_directive>\fP (resp. \fB<directive>\fP) is an assignment of
a \fB<value>\fP to a \fB<random_variable>\fP (resp. a \fB<variable>\fP),
followed by a newline character. 

.P
Any line starting with the "#" character is considered as a comment and
ignored. Spaces and tabulations can be inserted before, between, or after
terminal symbols.

.SH SEMANTICS OF THE R\&B\&C FORMAT

Variables can be modified by directives as follows. First, all variables
have a default value, which will be used unless overriden by some directive.
A \fB<random_directive>\fP occurring in the \fB<random_options>\fP list assigns a 
\fB<random_variable>\fP associated to the BES.
A \fB<directive>\fP occurring in the \fB<bes_options>\fP list assigns its 
\fB<variable>\fP for all equation blocks of the BES. A \fB<directive>\fP
occurring in a \fB<block_options>\fP list assigns its \fB<variable>\fP only
for the blocks mentioned in this \fB<block_options>\fP, possibly overriding
the value specified for this \fB<variable>\fP in the \fB<bes_options>\fP list.
If a variable is assigned multiple times, the value assigned by the last
directive overrides the previous ones.

.P
The meaning of the different \fB<random_variable>\fPs is the following:

.IP \fBnumber_of_blocks\fP
This variable specifies the number N of blocks contained in the BES.
N must be greater than 0.
Default value is 1.
.sp
Note: Due to the hazard of random generation, it is not guaranteed that
all block indexes in the range [0..N-1] will be present in the BES.

.IP \fBalternation_free\fP
This variable indicates whether the BES is alternation-free (value \fBtrue\fP)
or not (value \fBfalse\fP).
Default value is \fBtrue\fP.
.sp
Note: The current version of the
.BR caesar_solve_1 (LOCAL)
library handles only alternation-free BESs. Therefore, specifying the value
\fBfalse\fP for this variable will trigger error messages issued by the
resolution algorithms, which detect the presence of cyclic dependencies
between blocks.

.IP \fBstrategy\fP
This variable specifies the value of the seed initializing the
random number generator used for generating the BES. The value
0 means that an arbitrary seed is chosen automatically at each execution
of the tool (nondeterministic case). A value greater than 0 is used as
the seed, which will entail the generation of the same BES at each
execution of the tool (deterministic case).
Default value is 1.

.P
The meaning of the different \fB<variable>\fPs is the following:

.IP \fBsign\fP
This variable specifies the probability (given in percent, as a natural
number in the interval [0..100]) that the sign of the current block
is \fBmu\fP rather than \fBnu\fP. A value of 0 (resp. 100) will fix
the sign of the block to \fBnu\fP (resp. \fBmu\fP).
Default value is 50.

.IP \fBunique_resolution\fP
This variable indicates whether the current block will be solved only once
(value \fBtrue\fP) or several times (value \fBfalse\fP).
Default value is \fBfalse\fP.
.sp
Note: Setting this variable in the \fIbes_options\fP section of the
command line will also act on a BES provided as a file \fIinput\fP.\fBbes\fP.
For technical reasons, if this variable is set on the command line for a
set \fIL\fP of block indexes, all the remaining blocks of the BES
(of indexes not belonging to \fIL\fP) will have this variable set to
the default value \fBfalse\fP. If another value is required for
the remaining blocks, this may be specified either using additional
\fBunique_resolution\fP directives on the command line, or by explicitly
editing the \fIinput\fP.\fBbes\fP file.

.IP \fBsolve_mode\fP
This variable specifies the index of the resolution algorithm (see the
.BR caesar_solve_1 (LOCAL)
manual page)
used for solving boolean variables defined in the current block.
Default value is 0.
.sp
Note: Setting this variable in the \fIbes_options\fP section of the
command line will also act on a BES provided as a file \fIinput\fP.\fBbes\fP.
For technical reasons, if this variable is set on the command line for a
set \fIL\fP of block indexes, all the remaining blocks of the BES
(of indexes not belonging to \fIL\fP) will be solved using the default
resolution algorithm 0. If another resolution algorithm is required for
the remaining blocks, this may be specified either using additional
\fBsolve_mode\fP directives on the command line, or by explicitly editing
the \fIinput\fP.\fBbes\fP file.
.sp
Note: If the value set to this variable denotes an unexisting resolution
algorithm (e.g., 100), then an error message is issued and the execution
is aborted.

.IP \fBnumber_of_variables\fP
This variable specifies the number M of boolean variables that may be
defined in the current block (i.e., that may occur in the left-hand side
of equations of the block). M must be greater than 0.
Default value is 1.
.sp
Note: Due to the hazard of random generation, it is not guaranteed that
all variable indexes in the range [0..M-1] will be defined by equations
of the block.

.IP \fBequation_length\fP
This variable specifies the maximum length L (number of operands) of the
boolean formulas occurring in the right-hand sides of equations of the
current block. L must be greater than 0. The length of the
right-hand side of an equation will be chosen randomly in the
interval [1..L].
Default value is 1.

.IP \fBvariable_ratio\fP
This variable specifies the percentage (natural number in the
interval [0..100]) of boolean variables among the operands in the
right-hand sides of equations of the current block (the remaining
operands are boolean constants).
Default value is 50.

.IP \fBlocal_variable_ratio\fP
This variable specifies the percentage (natural number in the
interval [0..100]) of local variables (i.e., defined in the current
block) among the variables in the right-hand sides of equations of
the current block (the remaining variables are defined in other blocks).
In an alternation-free BES containing N equation blocks, this variable
must be set to 100 for the block of index N-1, since this block does
not depend upon any other blocks of the BES.
Default value is chosen automatically such that the variables occurring
in the right-hand sides of equations are randomly spread over the
blocks of the BES.

.IP \fBor_variable_ratio\fP
This variable specifies the percentage (natural number in the
interval [0..100]) of disjunctive boolean variables among the local
variables in the right-hand sides of equations of the current block (the
remaining local variables in the right-hand sides of equations are
conjunctive). Due to the way equations are generated, this variable
will also correspond to the percentage of disjunctive boolean variables
occurring in the left-hand sides of equations of the current block.
Default value is 50.

.IP \fBor_variable_alternation\fP
This variable modifies the interpretation of \fBor_variable_ratio\fP
according to the binary boolean operators occurring in the right-hand sides
of the equations of the current block.
If this variable is set to \fBtrue\fP, then all local variables occuring
in the right-hand sides of purely disjunctive (resp. conjunctive) equations
are forced to be conjunctive (resp. disjunctive). Said differently, the
type of variables must strictly alternate between the left-hand side and
the right-hand side of each equation. However, the total percentage of
disjunctive boolean variables in all right-hand sides of equations will
roughly correspond to the value of \fBor_variable_ratio\fP.
If this variable is set to \fBfalse\fP, then the amount of disjunctive
variables among the local variables occurring in the right-hand side of
each equation is determined according to the value of \fBor_variable_ratio\fP.
Default value is \fBfalse\fP.

.IP \fBfalse_constant_ratio\fP
This variable specifies the percentage (natural number in the
interval [0..100]) of \fBfalse\fP among the constants
in the right-hand sides of equations of the current block (the
remaining constants are \fBtrue\fP).
Default value is 50.

.IP \fBshape\fP
This variable specifies the shape of the current block, i.e., the
structure of the dependency graph between the boolean variables defined
in the block (see the
.BR caesar_solve_1 (LOCAL)
manual page).
The following values are available for this variable:
\fBgeneral\fP indicates no constraint on dependencies;
\fBacyclic\fP indicates the absence of cyclic dependencies;
\fBdisjunctive\fP (resp. \fBconjunctive\fP) indicates that the block
is disjunctive (resp. conjunctive) according to the definition given
in
.BR bes (LOCAL).
Default value is \fBgeneral\fP.

.SH EXAMPLES OF R\&B\&C FILES

The RBC file below specifies a random BES with a single equation block
of maximal fixed point, which contains only conjunctive variables and
does not contain any constant:

.nf
   sign = 0
   number_of_variables = 1000
   equation_length = 10
   variable_ratio = 100
   or_variable_ratio = 0
.fi
.P
This kind of BES is typically encountered by translating the model checking
of satisfied safety properties (see the
.BR evaluator (LOCAL)
manual page).
The local resolution of any variable of this BES will yield TRUE, since there
is no \fBfalse\fP constant reachable from that variable.

.P
The RBC file below specifies a random BES with a single maximal fixed point
block with a small amount of constants, and in which disjunctive
and conjunctive variables strictly alternate along dependencies:

.nf
   strategy = 2
   sign = 0
   number_of_variables = 10000
   equation_length = 10
   variable_ratio = 98
   or_variable_alternation = true
.fi
.P
This kind of BES typically underlies the comparison of equivalent
nondeterministic LTSs modulo strong bisimulation (see the
.BR bisimulator (LOCAL)
manual page).
The local resolution of the variable of index 0 of this BES will yield TRUE.

.P
Finally, the RBC file below describes a random BES containing two equation
blocks, the first one being a conjunctive maximal fixed point and the second
one a disjunctive minimal fixed point:

.nf
   number_of_blocks = 2
   variable_ratio = 90

   # conjunctive nu-block
   0
   sign = 0
   solve_mode = 4
   number_of_variables = 1000
   equation_length = 20
   or_variable_ratio = 5
   false_constant_ratio = 0
   shape = conjunctive

   # disjunctive mu-block
   1
   sign = 100
   solve_mode = 3
   number_of_variables = 2000
   equation_length = 10
   or_variable_ratio = 95
   false_constant_ratio = 80
   shape = disjunctive
.fi
.P
This kind of BES corresponds to the model checking of certain fairness
properties, such as the "fair reachability of predicates" (see the
.BR evaluator (LOCAL)
manual page).
The local resolution of a variable of the first block may yield TRUE or
FALSE, depending on the chosen strategy. The strategy is set by default to 1;
setting it to 0 would yield different BESs at each execution of the tool.

.SH HOW TO CREATE A R\&B\&C FILE

At present, RBC files must be written by hand.

.P
The contents of an RBC file passed as argument to the
.BR bes_solve (LOCAL)
tool can also be extended using the options
\fIrandom_options\fP, \fIbes_options\fP, and \fIblock_options\fP.
Each argument contained in \fIrandom_options\fP, \fIbes_options\fP,
and \fIblock_options\fP corresponds to a line in the RBC file.

.IP -
\fIrandom_options\fP has the same syntax as the non-terminal \fB<random_options>\fP
in the RBC grammar (except that some characters meaningful to the shell
must be escaped or quoted properly). If it is non-empty, it is interpreted
exactly as if its contents were inserted in the RBC file, at the end of the
\fB<random_options>\fP list and before the first \fB<bes_options>\fP.

.IP -
\fIbes_options\fP has the same syntax as the non-terminal \fB<bes_options>\fP
in the RBC grammar (except that some characters meaningful to the shell
must be escaped or quoted properly). If it is non-empty, it is interpreted
exactly as if its contents were inserted in the RBC file, at the end of the
\fB<bes_options>\fP list and before the first \fB<block_options>\fP.

.IP -
\fIblock_options\fP has the same syntax as a possibly empty list of 
non-terminals \fB<block_options>\fP (except that some characters meaningful to
the shell must be escaped or quoted properly). If it is non-empty, it is
interpreted exactly as if its contents were appended at the end of the RBC
file, after the last \fB<block_options>\fP.

.P
Thus, the value of \fB<random_variable>\fPs can be set in three different ways,
listed below by increasing precedence:

.IP -
default value,
.IP -
value given by \fB<random_options>\fP in the RBC file,
.IP -
value given by \fIrandom_options\fP on the command line.

.P
The value of \fB<variable>\fPs can be set in five different ways,
listed below by increasing precedence:

.IP -
default value,
.IP -
value given by \fB<bes_options>\fP in the RBC file,
.IP -
value given by \fIbes_options\fP on the command line,
.IP -
value given by \fB<block_options>\fP in the RBC file,
.IP -
value given by \fIblock_options\fP on the command line.

.SH HOW TO READ A R\&B\&C FILE

At present, there is one single CADP tool,
.BR bes_solve (LOCAL),
that reads and processes RBC files.

.SH BIBLIOGRAPHY

[Mat06]
R. Mateescu.
CAESAR_SOLVE: A Generic Library for On-the-Fly Resolution of
Alternation-Free Boolean Equation Systems.
Springer International Journal on Software Tools for Technology Transfer
(STTT), 8(1):37-56, 2006. Full version available as INRIA Research
Report RR-5948. Available from
http://cadp.inria.fr/publications/Mateescu-06-a.html

.P
[GLMS13]
H. Garavel, F. Lang, R. Mateescu, and W. Serwe.
CADP 2011: A Toolbox for the Construction and Analysis of
Distributed Processes.
Springer International Journal on Software Tools for Technology Transfer
(STTT), 15(2):89-107, 2013. Available from
http://cadp.inria.fr/publications/Garavel-Lang-Mateescu-Serwe-13.html

.SH SEE ALSO
OPEN/CAESAR Reference Manual,
.BR bes (LOCAL),
.BR bes_solve (LOCAL),
.BR bisimulator (LOCAL),
.BR caesar_solve_1 (LOCAL),
.BR evaluator (LOCAL),
.BR lotos.open (LOCAL)

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

