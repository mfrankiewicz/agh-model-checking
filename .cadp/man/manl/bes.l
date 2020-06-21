.\" @(#)bes.l - VASY and CONVECS teams - 2019/01/14
.TH BES LOCAL "2019/01/14" "(C) INRIA" "CADP MANUAL PAGES"
.fp 4 CB
.lg 0
.SH NAME
bes, BES \- text file format for Boolean Equation Systems

.SH DESCRIPTION

The acronym \fIBES\fP stands for \fIB\fPoolean \fIE\fPquation \fIS\fPystem.
It is a mathematical formalism used to solve verification problems, such
as model checking and equivalence checking.
.P
In CADP, BES is also a text file format to represent Boolean Equation Systems.

.SH BOOLEAN EQUATION SYSTEMS

A BES is a non-empty set of equation blocks. Each block is a (possibly empty)
set of equations. Each equation contains, on its left-hand side, a boolean
variable, and, on its right-hand side, a boolean formula built using boolean
variables (noted \fIX\fP, \fIX'\fP, etc.), constants (\fBtrue\fP, \fBfalse\fP),
and binary operators of disjunction (\fBor\fP) and conjunction (\fBand\fP).

.P
Without loss of generality, it is assumed that each boolean formula is either
purely disjunctive (i.e., contains only \fBor\fP operators), or purely
conjunctive (i.e., contains only \fBand\fP operators). Formulas containing
both operators can be easily eliminated by introducing auxiliary variables.
The formula \fBfalse\fP (resp. \fBtrue\fP) is considered as a disjunctive
(resp. conjunctive) formula.

.P
A boolean variable is said to be defined by an equation if this variable
occurs on the left-hand side of this equation. A boolean variable is said
to be defined in a block if it is defined by an equation of this block.

.P
Each boolean variable occurring on the right-hand side of an equation in
a BES must be defined by some equation of this BES (but not necessarily
in the same block).

.P
Multiple definitions of a variable are forbidden, i.e., a variable is defined
by at most one equation.

.P
Recursive definitions of a variable are allowed (e.g., a variable occurs
both on the left- and right-hand side of the same equation).

.P
A boolean variable defined by an equation is disjunctive (resp. conjunctive)
if the boolean formula on the right-hand side of this equation is purely
disjunctive (resp. conjunctive).

.P
If a variable \fIX'\fP occurs on the right-hand side of the equation defining
a variable \fIX\fP, then \fIX\fP (directly) depends on variable \fIX'\fP.

.P
If a variable defined in a block \fIB\fP depends on a variable defined in a
block \fIB'\fP, then block \fIB\fP (directly) depends on block \fIB'\fP.

.P
A BES is said alternation-free if there are no cyclic dependencies between its
blocks (but there can be cyclic dependencies between variables inside blocks).

.P
Each equation block has a sign, which is equal to \fBmu\fP (resp. \fBnu\fP) if
the block denotes the minimal (resp. maximal) fixed point of the functional
induced by the equations of the block; see [Mat06] for a mathematical 
definition of this functional.

.SH B\&E\&S NOTATION

.P
BES can be either represented in binary form (in internal memory) using the
.BR caesar_solve (LOCAL)
library, or in textual form (in files with \fB.bes\fP extension) using the
syntax described below.

.SS LEXICAL CONVENTIONS
.P
In a BES file, lexical tokens may be separated by any sequence of spaces,
tabulations, carriage returns, newlines, vertical tabulations, form feeds
(these characters are those recognized by the POSIX function \fBisspace()\fP),
or comments, which are enclosed between \fB(*\fP and \fB*)\fP; these
sequences are always skipped and ignored.
.P
BES files are case-sensitive: upper-case and lower-case letters are
considered to be different.

.SS SYNTAX DEFINITION
.P
The textual syntax of BES files is described by the following context-free
grammar, where \fB<empty>\fP denotes the empty sequence of symbols and
\fB<nat>\fP denotes a non-negative integer:

.nf
.cs 4 23
 \fB<axiom> ::= <block-list>
.sp
 <block-list> ::= <block>
               |  <block> <block-list>
.sp
 <block> ::= block <sign> <block-idf> <unique> <mode> is
                 <equation-list>
             end block
.sp
 <sign> ::= mu
         |  nu
.sp
 <block-idf> ::= B<nat>
.sp
 <unique> ::= <empty>
           |  unique
.sp
 <mode> ::= <empty>
         |  mode <nat>
.sp
 <equation-list> ::= <equation>
                  |  <equation> <equation-list>
.sp
 <equation> ::= <local-variable-idf> = <formula>
.sp
 <local-variable-idf> ::= X<nat>
.sp
 <global-variable-idf> ::= X<nat>_<nat>
.sp
 <formula> ::= <atomic-form>
            |  <disjunctive-form>
            |  <conjunctive-form>
.sp
 <atomic-form> ::= false
                |  true
                |  <local-variable-idf>
                |  <global-variable-idf>
.sp
 <disjunctive-form> ::= <atomic-form> or <atomic-form>
                     |  <atomic-form> or <disjunctive-form>
.sp
 <conjunctive-form> ::= <atomic-form> and <atomic-form>
                     |  <atomic-form> and <conjunctive-form>\fP
.fi
.cs 4

.SS BLOCK IDENTIFIERS
.P
In a BES file, each block has a unique identifier of the form \fBB<nat>\fP,
where \fB<nat>\fP is called the block index. Blocks may occur in the file
in any order w.r.t. their indexes, and these indexes are not necessarily
contiguous (i.e., there may be ``holes'' in the block numbering). If for
some index \fBi\fP there is no block \fBBi\fP defined in the file, it is
considered that the block \fBBi\fP is empty.

.SS VARIABLE IDENTIFIERS
.P
In each equation block, each boolean variable defined by an equation (i.e.,
occurring on the left-hand side of an equation) has an identifier of the
form \fBX<nat>\fP, which is unique in the block, where \fB<nat>\fP is called
the variable index. Variables may be defined in the block in any order w.r.t.
their indexes, and these indexes are not necessarily contiguous (i.e., there
may be ``holes'' in the variable numbering).

.P
Variable identifiers occurring in formulas have two forms:

.IP -
\fBX<nat1>_<nat2>\fP is a global identifier that denotes the variable
\fBX<nat1>\fP defined in the block \fBB<nat2>\fP. Global identifiers can
be used for any variable occurring on the right-hand side of an equation.

.IP -
\fBX<nat>\fP is a local identifier that denotes the variable \fBX<nat>\fP
defined in the current block.

.SS MODE CLAUSE
.P
One can attach an optional clause \fBmode <nat>\fP to each equation block.
Such a clause specifies that the variables defined in this equation block
should be computed using the resolution algorithm named A\fB<nat>\fP of the
.BR caesar_solve_1 (LOCAL)
library. The value \fB<nat>\fP is called the resolution mode of the
block. If the \fBmode\fP clause is absent, the resolution mode is set to
0 by default, meaning that the resolution algorithm A0 will be used.

.SS UNIQUE CLAUSE
.P
Since the 
.BR caesar_solve_1 (LOCAL)
library does not operate globally, but locally, to compute a given variable
defined in a given equation block, the same equation block may be solved
several times, each time for computing a different variable of this block.
Of course, caching is used to avoid recomputing variables already calculated.

.P
It is however possible to help the solver by attaching an optional clause
\fBunique\fP to an equation block. Such a clause indicates that the block
will be solved only once, meaning that the value of a single variable
defined in the block will be computed. This increases the memory performance
of certain resolution algorithms. Any attempt at solving twice an equation
block having the \fBunique\fP clause will trigger a run-time error. By
default, if the \fBunique\fP clause it absent, one assumes that several
variables of the equation block will need to be computed.

.SH B\&E\&S FILE EXAMPLE

An example of a boolean equation system containing two equation blocks is
shown below:
.nf
.cs 4 23
   \fBblock nu B0 is
       X0 = X1 and X2
       X1 = X0 or X1 or X2
       X2 = X0_1 and X3
       X3 = X1 or X4
       X4 = true
    end block
.sp
    block mu B1 is
       X0 = X1 or X2
       X1 = false
       X2 = X2 and X3
       X3 = X0 or X1 or X3
    end block\fP
.fi
.cs 4

.P
The global variable \fBX0_1\fP, which is present on the right-hand side of the
equation defining variable \fBX2\fP in block \fBB0\fP, references the variable
\fBX0\fP defined in block \fBB1\fP.

.SH HOW TO CREATE A B\&E\&S FILE

One can produce a BES file manually, using a text editor. 

.P
BES files can also be generated using option \fB-diag\fP of the tool
.BR bes_solve (LOCAL),
or using option \fB-bes\fP of the tools
.BR bes_solve (LOCAL),
.BR bisimulator (LOCAL),
.BR evaluator3 (LOCAL),
and
.BR evaluator4 (LOCAL).

.SH HOW TO READ A B\&E\&S FILE
.P
BES files can be read and resolved using the
.BR bes_solve (LOCAL)
tool.
They can also be loaded in memory in binary internal form using the
\fBCAESAR_READ_SOLVE_1()\fP procedure of the
.BR caesar_solve (LOCAL)
library.

.SH BIBLIOGRAPHY

[Mat06]
R. Mateescu.
"CAESAR_SOLVE: A Generic Library for On-the-Fly Resolution of
Alternation-Free Boolean Equation Systems."
Springer International Journal on Software Tools for Technology Transfer
(STTT), v. 8, no. 1, p. 37-56, 2006. Full version available as INRIA Research
Report RR-5948.
Available from http://cadp.inria.fr/publications/Mateescu-06-a.html

.SH SEE ALSO

.P
.BR bes_solve (LOCAL),
.BR bisimulator (LOCAL),
.BR caesar_solve_1 (LOCAL),
.BR evaluator (LOCAL),
.BR evaluator3 (LOCAL),
.BR evaluator4 (LOCAL),
.BR rbc (LOCAL),
.BR scrutator (LOCAL)

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

Please report any bug to cadp@inria.fr

