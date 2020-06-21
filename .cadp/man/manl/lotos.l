.\" @(#)lotos.l - VASY and CONVECS teams - 2020/02/11
.TH LOTOS LOCAL "2020/02/11" "(C) INRIA" "CADP MANUAL PAGES"
.fp 4 CB
.lg 0
.SH NAME
lotos, LOTOS \- Language of Temporal Ordering Specification

.SH DESCRIPTION

LOTOS [BB88] is a formal specification language to describe communication
protocols and distributed systems. It has been standardized by ISO/IEC in 
1989 [ISO89]. The design of LOTOS was motivated by the need for a language 
with a high abstraction level and strong mathematical bases that would allow 
complex systems to be described precisely and unambiguously, then analyzed 
using formal methods supported by appropriate software tools. LOTOS features
two clearly separated parts:

.IP - 
The \fIdata part\fP of LOTOS, intended to describe data structures, is based 
on the theory of abstract data types and algebraic specifications (especially
the ActOne language defined by Ehrig and Mahr). In this approach, data
structures are described by LOTOS \fIsorts\fP, which represent value domains, 
and LOTOS \fIoperations\fP, which are mathematical functions defined on these 
domains. The meaning of operations is defined by algebraic \fIequations\fP. 
Value expressions are strongly-typed algebraic terms built from variables and
operations. Sorts, operations, and equations are grouped in modules called 
\fItypes\fP, which can be combined together using importation (with multiple
inheritance), renaming, parametrization, and actualization. The underlying
semantics is that of initial algebras.

.IP -
The \fIcontrol part\fP of LOTOS is meant to describe the behaviour of
concurrent processes that execute simultaneously, synchronize, and
communicate using message-passing rendezvous. LOTOS is based on the
process algebra approach for concurrency, and combines the best features
of Milner's CCS and Hoare's CSP process calculi. It relies on a small set 
of basic operators, which express primitive concepts such as sequential
composition, non-deterministic choice, guard, parallel composition,
rendezvous, etc. These operators are used to build \fIbehaviour 
expressions\fP, which are algebraic terms that describe the behaviour of 
concurrent systems, complex behaviours being obtained by combining simpler 
ones. The communication ports for rendezvous are called \fIgates\fP. Any 
behaviour expression can be given a name and reused several times by
enclosing it in a \fIprocess\fP definition. 

.P
A comprehensive list of documents about the LOTOS language is available 
from http://cadp.inria.fr/tutorial

.P
The remainder of this page is devoted to CADP-specific information about
LOTOS. It gathers many technical details that, so far, were only known
by CADP experts.

.P
Note: LOTOS is a powerful yet involved language. Today, new users who do not
know LOTOS already may prefer instead learning LNT (LOTOS New Technology),
a modern language designed to be a replacement for LOTOS, simpler to learn
but equally expressive. The present manual can yet be of interest to LNT
users as well, since LNT is currently implemented by translation to LOTOS.

.SH C\&A\&D\&P TOOLS FOR L\&O\&T\&O\&S

The CADP toolbox provides four main tools to handle LOTOS specifications:

.IP -
.BR caesar.adt (LOCAL)
is a compiler for the data part of LOTOS. It translates LOTOS to C by
generating an implementation for all the sorts and operations defined in a 
LOTOS specification.

.IP -
.BR caesar (LOCAL)
is a compiler for the control part of LOTOS. It translates LOTOS to Petri
nets, and then to C code that can be used for, at least, three different
purposes: (i) exhaustively explore all possible behaviours and generate the 
corresponding Labelled Transition System encoded in
.BR aut (LOCAL)
or
.BR bcg (LOCAL)
format; (ii) explore possible behaviours on the fly by interfacing with
the OPEN/CAESAR framework of CADP; (iii) connect the LOTOS specification
to its environment by interfacing with the EXEC/CAESAR framework of CADP,
e.g., to pilot an external device using the LOTOS specification as a 
controller.

.IP -
.BR caesar.indent (LOCAL)
is a pretty-printer that automatically reformats and indents LOTOS 
specifications.

.IP -
.BR lotos.open (LOCAL)
is a tool that allows running the OPEN/CAESAR application programs on
LOTOS specifications. This tool is actually a shell script that
invokes \fBcaesar.adt\fP and \fBcaesar\fP.

.P
For historical reasons, and because the data part and control part of LOTOS
are largely orthogonal, they are handled separately by the \fBcaesar.adt\fP 
and \fBcaesar\fP compilers, respectively. The landscape is however not so
simple, as close connections exist between both compilers:

.IP -
Both compilers share a common front-end, which performs lexical and
syntactic analyses, abstract tree construction, and static semantics checks
(e.g., identifier binding, type checking, etc.). After these common, 
preliminary steps, each compiler performs additional checks for either the 
data or control part.

.IP -
The \fBcaesar\fP compiler requires a \fIconcrete\fP implementation in C
for each \fIabstract\fP sort and operation defined in the LOTOS 
specification. Such an implementation can be automatically generated 
using \fBcaesar.adt\fP or be manually written by the user.
.sp
In most cases, it is advised to let \fPcaesar.adt\fP produce the C code
automatically, as the generated code will be both correct and, in most 
cases, highly efficient. For the most common classes of types (Booleans,
enumerated types, bounded integers, records, unions, lists, trees, bit 
vectors, etc.), \fPcaesar.adt\fP will generate optimal code (according
to model checking demands, i.e., memory space first, then speed). 
.sp
On the other hand, manual writing gives full control on all implementation
details and may thus be preferred for particular data structures, such as
floating-point numbers, character strings, matrices, variable-length data 
with special encodings, etc. Manual writing also allows to reuse efficient 
C or C++ code libraries that already exist and can be imported in a LOTOS 
specification just by redeclaring their interface in the form of LOTOS 
abstract data types. Manual writing also allows to define functions that
can perform "short-circuits" when evaluating their arguments (see the 
section below on CALL-BY-NEED EVALUATION).
.sp
Both approaches can be combined, in the sense that certain LOTOS sorts 
and/or operations can be declared as \fIexternal\fP by the user and 
implemented manually; in such case, \fBcaesar.adt\fP will only generate C 
code for the non-external sorts and/or operations, and will import the 
C code implementing those external sorts and/or operations.
.sp
In any case, manual writing requires great care in order to produce correct 
implementations. There exist naming and interfacing conventions (described
below) that must be strictly respected. Certain macro-definitions must be
provided by the user to inform \fBcaesar.adt\fP about key properties of 
the external sorts. Moreover, manually-written C functions are not allowed
to have side effects, except in a very limited way (see the section below
on SIDE EFFECTS for details). Examples of manually-written C code for the
standard LOTOS types declared in the "\fB$CADP/lib\fP" directory (see files
"\fBX_*.lib\fP") can be found in the "\fB$CADP/incl\fP" directory (see
files "\fBX_*.h\fP" and "\fBadt_*.h\fP").

.IP -
Yet, the C code generated by \fBcaesar.adt\fP for LOTOS specifications can 
also be used in a standalone manner, independently from the \fBcaesar\fP 
compiler. In this approach, LOTOS is only used as a higher-level language 
for describing data structures with their related operations, from 
which \fBcaesar.adt\fP produces lower-level C code.
.sp
This idea has been applied in two large projects: the development 
of \fBcaesar.adt\fP (version 4.0 and higher), most of which is written 
in LOTOS data types and which bootstraps itself, and the development of the
.BR xtl (LOCAL)
compiler, the largest part of which consists of LOTOS code too.

.IP -
Note that both \fBcaesar\fP and \fBcaesar.adt\fP take great care to
generate C code that does not cause warnings when given to C compilers
with demanding compiling options. So, if warnings are emitted while 
compiling some C code generated by the CADP tools, it is likely that 
these warnings have their origin in the LOTOS specification itself 
(e.g., unused operations or unused operation parameters) or in the 
C code manually written by the user.

.SH TOOLS GENERATING L\&O\&T\&O\&S CODE

The CADP toolbox provides two tools that produce LOTOS code:

.IP -
.BR fsp2lotos (LOCAL)
takes specifications written in Magee and Kramer's FSP (Finite State
Processes) language and translates them into LOTOS.

.IP -
.BR lnt2lotos (LOCAL)
takes specifications written in LNT (LOTOS New Technology) and translates
them into LOTOS.

.P
Other tools have been developed, but not distributed as part of CADP:

.IP -
.B chp2lotos 
takes specifications written in Martin's CHP (Communicating Hardware
Processes) and translate them into LOTOS. See 
http://cadp.inria.fr/software/05-b-chp2lotos.html for details.

.IP -
.B flac
takes models written in the FIACRE formalism and translates them into LOTOS.
See http://cadp.inria.fr/software/11-d-flac.html for details.

.P
Note: Following the above remark that LOTOS is an involved language for
humans, it is involved for translators too. In practice, it is much easier
to generate LNT code rather than LOTOS code, and let the 
.BR lnt2lotos (LOCAL)
translator cope with the intricacies of generating correct LOTOS code.

.SH "RESTRICTIONS ON THE DATA PART OF L\&O\&T\&O\&S"

Abstract data types, as they exist in LOTOS, are a rather unconstrained 
formalism that is difficult to execute efficiently and from which it is 
difficult to generate executable code. To handle algebraic specifications,
there exist techniques based on rewriting or symbolic evaluation, but they
are often slow and memory-intensive. This is a major problem in a 
model-checking context, because state-space exploration is especially
demanding in terms of performance.
.P
Therefore, in order to enable the use of
.BR caesar.adt (LOCAL)
for translating LOTOS abstract data types into C code automatically, the
following restrictions have been set, which turn algebraic specifications 
into (more operational) term-rewrite systems with priorities (see [Gar89c]
and [GT93] for details).
.P
These restrictions also introduce a suitable discipline in LOTOS, which,
even if it is a strongly-typed language and owns a system of modules, 
remains poorly structured and hardly readable, as sorts, operations, and 
equations may appear in arbitrary order, with no guarantee that operations 
related to the same sort or equations related to the same operation will 
be gathered in the same module.

.SS DISTINCTION BETWEEN CONSTRUCTORS AND NON-CONSTRUCTORS

The user must split LOTOS operations into two classes: the \fIconstructors\fP,
which are primitive operations, and the \fInon-constructors\fP, which are
non-primitive operations defined using equations. To this aim, the user must
explicitly indicate which operations are constructors by attaching a special 
comment to them (see below the section on SPECIAL COMMENTS FOR OPERATIONS).

.P
The distinction enables LOTOS abstract data types to be efficiently 
implemented. However, this distinction does not exist in the standard 
definition of the language [ISO89], so that new constraints on
the syntax and static semantics must be added.

.SS CONSTRAINTS ON EQUATIONS

To be accepted by \fBcaesar.adt\fP, each equation must match the
non-terminal symbol E that is the axiom of the following BNF grammar:
.nf
   E ::= [ G, ..., G \fB=>\fP ] F \fB(\fPP, ..., P\fB)\fP \fB=\fP V
   G ::= V | V \fB=\fP V
   P ::= X | C | P C P | C \fB(\fPP, ..., P\fB)\fP | P \fBof\fP S | \fB(\fPP\fB)\fP
   V ::= X | C | V C V | C \fB(\fPV, ..., V\fB)\fP
           | F | V F V | F \fB(\fPV, ..., V\fB)\fP | V \fBof\fP S | \fB(\fPV\fB)\fP
.fi
where:
.IP -
square brackets denote an optional element (here, premisses)
.IP -
C is a terminal symbol denoting a constructor identifier (either
constant, infix binary, or prefix)
.IP -
E is a non-terminal symbol denoting a well-formed equation
.IP -
F is a terminal symbol denoting a non-constructor identifier (either
constant, infix binary, or prefix)
.IP -
G is a non-terminal symbol denoting an equation premiss (either a 
Boolean guard or an equality test)
.IP -
P is a non-terminal symbol denoting a pattern (i.e., a value
expression that does not contain any non-constructor identifier)
.IP -
S is a terminal symbol denoting a sort identifier
.IP -
V is a non-terminal symbol denoting a value expression
.IP -
X is a terminal symbol denoting a value identifier (i.e., a variable)

.P
Any variable occurring in a guard G or in the right-hand side expression V
must also occur in (at least one of) the left-hand side patterns P.

.P
In such case, one says that equation E \fIdefines\fP the non-constructor F.

.P
All constructors must be \fIfree\fP, meaning that the above syntax does 
not allow constructors to be defined by equations.

.P
If a specification contains non-free constructors, it can be transformed
into an equivalent specification containing only free-constructors. This
can be done in a systematic way (see Section 1.7 of [Gar89c]).

.SS CONSTRAINTS ON SORTS AND CONSTRUCTORS

.IP -
If a sort \fIS\fP is not external, there must exist at least one constructor
returning a result of sort \fIS\fP. Otherwise, a compiler warning will be
emitted and \fBcaesar.adt\fP will consider that \fIS\fP is implicitly
external, so that no C code will be generated to implement this sort.

.IP -
If a sort \fIS\fP is not external, then all the constructors returning
a result of sort \fIS\fP should be non-external operations.

.IP -
If a sort \fIS\fP is external, then all the constructors returning a result
of sort \fIS\fP should be external operations.

.IP -
To enforce a modular specification style that LOTOS does not encourage by
default, each constructor returning a result of sort \fIS\fP should be 
declared in the same LOTOS type as \fIS\fP, or a compiler warning 
will be emitted.

.IP -
Each sort \fIS\fP must be \fIproductive\fP, i.e., there must exist at
least one \fIground term\fP that is \fIwell-typed\fP (a ground term being
an an algebraic term that contains only constructors, and neither free 
variables nor non-constructors). For instance, a sort \fIS\fP with only 
one constructor defined as "\fISucc\fP \fB:\fP \fIS\fP \fB->\fP \fIS\fP"
is unproductive (technically, its initial algebra is empty).

.SS CONSTRAINTS ON NON-CONSTRUCTORS AND EQUATIONS

.IP -
If a non-constructor \fIF\fP is not external, there should exist at least 
one equation defining \fIF\fP. Otherwise, a compiler warning will be emitted,
and \fBcaesar.adt\fP will consider that \fIF\fP is implicitly external,
so that no C code will be generated to implement this operation.

.IP -
If non-constructor \fIF\fP is external, then no equations should 
define \fIF\fP (if such equations have already been written, it is
advised to preserve them by commenting them out rather than simply
deleting them).

.IP -
To enforce a modular specification style that LOTOS does not encourage by
default, each equation defining a non-constructor \fIF\fP should be 
located in the same LOTOS type as \fIF\fP, or a compiler warning will
be emitted.

.SS CONSTRAINTS ON RENAMING

.IP -
Sort renaming is supported as follows. If a sort \fIS2\fP renames a 
sort \fIS1\fP, then \fBcaesar.adt\fP generates no C code for
implementing \fIS2\fP, and the CADP tools simply replace all occurrences
of \fIS2\fP by \fIS1\fP in the C code they generate, meaning that both 
sorts share the same implementation in C.

.IP -
Consequently, it is forbidden to define constructors that return a result
of the renaming sort \fIS2\fP, meaning that one cannot modify a renamed 
sort by adding constructors to its renaming sort(s). See item #903 in file 
"\fB$CADP/HISTORY\fP" for details.

.IP -
Operation renaming is supported as follows. If an operation \fIF2\fP 
renames an operation \fIF1\fP, then \fBcaesar.adt\fP generates no C code 
for implementing \fIF2\fP, and the CADP tools simply replace all occurrences
of \fIF2\fP by \fIF1\fP in the C code they generate, meaning that both 
operations share the same implementation in C.

.IP -
Consequently, it is forbidden to write equations that define the result of
the renaming operation \fIF2\fP, meaning that one cannot modify a renamed
non-constructor by adding equations to its renaming operation(s). See
item #2190 in file "\fB$CADP/HISTORY\fP" for details.

.SS CONSTRAINTS ON ACTUALIZATION

.IP -
Type actualization (i.e., on the one hand, generic types parameterized by 
formal sorts, formal operations, and/or formal equations, and, on the other
hand, actualized types obtained by instantiating generic types) is supported 
only in a partial way. The CADP tools indeed parse and statically check such
type definitions, but \fBcaesar.adt\fP later ignores them silently and
generates no C code to implement them. 

.IP -
As a consequence, \fBcaesar.adt\fP does not handle certain types of the 
LOTOS standard library (e.g., \fIElement\fP and \fISet\fP). To address this
limitation, the user has to flatten actualized types manually by making a
copy of parameterized and substituting all formal elements by the
corresponding actual ones.

.SS REWRITE STRATEGY

The C code generated by \fBcaesar.adt\fP for evaluating LOTOS value 
expressions uses a term-rewrite strategy that can be characterized 
by the two following rules:

.TP
\fIcall-by-value\fP (or functional evaluation):
When several subterms can be rewritten simultaneously, the innermost ones 
are rewritten first.

.TP
\fIdecreasing priority between equations\fP:
When, for a given subterm, several equations apply simultaneously, the
equation that occurs first in the LOTOS source text is chosen.

.P
Notice that such strategy is not fully deterministic, since it does not
specify in which order subterms at the same nesting level (e.g., the
various actual arguments of a function call) will be evaluated. The
decision is deferred to the C compiler, which may take advantage of such
degree of freedom to optimize machine-code generation. Therefore, the user 
should not expect leftmost subterms to be rewritten first.

.P
When needed, the call-by-value strategy can be changed to a call-by-need 
one by using external functions and C macro-definitions (see the section
below on CALL-BY-NEED EVALUATION).

.P
With respect to the well-known theory of term-rewrite systems, the following 
remarks can be made:

.TP
Completeness:
The issue of completeness arises when there are \fInot enough\fP equations to
define a non-constructor. For instance, let \fIF\fP be a non-constructor defined
by a single equation "\fIF\fP \fB(\fP\fItrue\fP\fB)\fP = \fItrue\fP"; the
value "\fIF\fP \fB(\fP\fIfalse\fP\fB)\fP" remains undefined. In standard
LOTOS, this value cannot be reduced and is added to the initial algebra 
of the \fIBool\fP sort, thus leading to Booleans having more than two values.
This problem is avoided in the CADP tools, as the C code generated 
by \fBcaesar.adt\fP raises a run-time error when trying to evaluate a
call to a non-constructor whose result is not defined by any equation
matching the values of the actual parameters supplied with the call. 
The \fB-debug\fP option of \fBcaesar.adt\fP can be used to print these values
when a run-time error occurs. Therefore, \fBcaesar.adt\fP extends LOTOS
with the concept of partially-defined functions, which are implemented using
(uncatchable) exceptions. 

.TP
Confluence:
The issue of confluence arises when there are \fItoo many\fP equations to
define a non-constructor. For instance, let \fIF\fP be a non-constructor 
defined by the two following equations "\fIF\fP \fB(\fP\fIx\fP\fB)\fP = \fItrue\fP"
and "\fIF\fP \fB(\fP\fIx\fP\fB)\fP = \fIx\fP"; the value
"\fIF\fP \fB(\fP\fIfalse\fP\fB)\fP" can be rewritten either to \fItrue\fP
or \fIfalse\fP. In standard LOTOS, such a definition of \fIF\fP implies
that both values \fItrue\fP and \fIfalse\fP are equal, thus leading to
Booleans having a single value. This problem is avoided with the decreasing
priority between equations enforced by \fBcaesar.adt\fP, which ensures that 
the evaluation of value expressions is deterministic. Moreover, 
\fBcaesar.adt\fP warns about equations that are never used because they
are overriden by equations of higher priority (note that, when premisses
are used, such detection of unused equations cannot be done systematically).

.TP
Termination:
The LOTOS equations are expected to satisfy the termination property, 
but \fBcaesar.adt\fP makes no attempt to check this property (anyway,
only sufficient conditions for termination could be checked). If the 
user writes non-terminating equations such as
"\fIF\fP (\fIX\fP) \fB=\fP \fIF\fP (\fIX\fP)", the generated C code
will loop forever or cause a stack overflow when executed. In such case, 
the C debugger and/or the \fB-trace\fP option of \fBcaesar.adt\fP can be 
used to understand the reason of the problem.

.P
In principle, if the LOTOS equations are written to be confluent and 
terminating, then all rewrite strategies (including the one implemented 
by \fBcaesar.adt\fP) should produce the same result when evaluating a given
term. However, in the case of partially-defined non-constructors, there
will be a difference as \fBcaesar.adt\fP will trigger a run-time error.
Moreover, seeking for confluent equations prevents from taking advantage of
priority between equations, i.e., from using the "if-then-else" facility
offered by priority, which often leads to shorter specifications and more
efficient implementations. A striking example of the benefits of priority
is the ability to define an equality operation \fIeq\fP for any sort \fIS\fP
using only two equations:
.nf
     \fBforall\fP x, y \fB:\fP \fIS\fP
     \fBofsort\fP \fIBool\fP
        x \fIeq\fP x = \fItrue\fP \fB;\fP
        x \fIeq\fP y = \fIfalse\fP
.fi

.P
Examples of issues that may arise when adding new operations to existing
LOTOS sorts are given in Section 2.a of [Gar13].

.SH "RESTRICTIONS ON THE CONTROL PART OF L\&O\&T\&O\&S"

The CADP tools accept a very large class of LOTOS behaviour expressions
and process definitions: all behavioural operators are accepted and value
expressions are handled as well. However, there are a few restrictions 
dictated either by the need to produce finite-state transition systems, 
or by the efficiency of the translation algorithms. Some restrictions 
also depend on the kind of analysis performed (e.g.,exhaustive state-space
exploration vs sequential C code generation).

.SS STATIC-CONTROL CONSTRAINTS

For efficiency reasons (namely, to ensure that the interpreted Petri
nets generated by the translation have at most one token per place),
the CADP tools lay additional constraints on LOTOS behaviour expressions.
Only a subset of LOTOS behaviour expressions is accepted, those that
satisfy the so-called \fIstatic control\fP property: any recursive call 
to a process is prohibited if it occurs in any of the five following 
contexts:

.IP -
on the left- or on the right-hand side of a parallel composition operator 
("\fB||\fP", "\fB|||\fP", "\fB|[\fP...\fB]|\fP")
.IP -
through a "\fBpar\fP" operator
.IP -
through a "\fBhide\fP" operator
.IP -
on the left-hand side of a "\fB>>\fP" (enable) operator
.IP -
on the left-hand side of a "\fB[>\fP" (disable) operator

.P
See Section 3.1 of [Gar89b] for a formal definition of static control 
constraints, illustrated with detailed examples. Notice that a call 
to a recursive process is not necessarily a recursive process call
(although the converse is true).

.P
In practice, LOTOS specifications that do not satisfy these constraints 
often exhibit a non-regular behaviour and, thus, cannot be translated to 
finite-state transition systems.

.SS FINITE-DOMAIN CONSTRAINTS

The three following LOTOS behaviour expressions require a nondeterministic 
selection, in the domain of sort \fIS\fP, of some value to be stored in
variable \fIx\fP:
.IP -
"\fBchoice\fP \fIx\fP\fB:\fP\fIS\fP \fB[]\fP ..."
.IP -
"\fBexit (any\fP \fIS\fP\fB)\fP"
.IP -
"\fIG\fP \fB?\fP\fIx\fP\fB:\fP\fIS\fP \fB;\fP ..." (provided that this 
input action on the visible gate \fIG\fP is not synchronized with an 
ouput action "\fIG\fP \fB!\fP\fIv\fP \fB;\fP ..." that would impose
value \fIv\fP to \fIx\fP).

.P
In general, to execute such behaviour expressions, the CADP tools enumerate 
all possible values in the domain of sort S and try all possible execution
paths, one for each value. That is, these tools perform \fIconcrete\fP
rather than \fIsymbolic\fP execution. 

.P
Enumerating the domain of sort \fIS\fP is only possible if this domain is 
finite or, in the case of infinite sorts (such as lists, strings, trees, 
etc.), if the enumeration is restricted to a finite subset (e.g., only
those lists whose length is less than five).

.P
If the domain of sort \fIS\fP is infinite, or if it is so large that 
the user wants to restrict it to a smaller subset in order to avoid 
state-space explosion issues, or if \fIS\fP is an external sort, the
user must provide an \fIiterator\fP for sort S, i.e., a fragment of C
code that enables a variable \fIx\fP of sort \fIS\fP to enumerate all 
possible values in the chosen subset.

.P
If sort \fIS\fP is never used in any of the three kinds of behaviour 
expressions listed above, then no iterator for sort \fIS\fP is required, 
as the domain of \fIS\fP will not be enumerated. Thus, sorts with
infinite or large domains are perfectly accepted, as long as no attempt
is made at enumerating their domains. Notice also that, by
default, \fIcaesar.adt\fP automatically generates iterators for all finite, 
non-external sorts (and bounded iterators for infinite, non-external sorts
isomorphic to natural numbers).

.P
Notice that, if a LOTOS specification satisfies the static-control property
and the finite-domain constraints for all its sorts that must be enumerated,
then its labelled transition system is necessarily finite. However, even 
if finite in theory, it may still be too large to be generated in practice.

.SS CLOSED-WORLD MODELLING

As mentioned in the previous section, in the particular case of an input 
action "\fIG\fP \fB?\fP\fIx\fP\fB:\fP\fIS\fP \fB;\fP ..." 
not synchronized, on the visible gate \fIG\fP, with a corresponding
output action, the CADP tools will enumerate all possible values in
the domain of sort \fIS\fP. Such enumeration is indeed conformant with
the operational semantics of LOTOS, in which both terms
"\fIG\fP \fB?\fP\fIx\fP\fB:\fP\fIS\fP \fB;\fP \fIB\fP"
and
"\fBchoice\fP \fIx\fP\fB:\fP\fIS\fP \fB[]\fP \fIG\fP \fB!\fP\fIx\fP \fB;\fP \fIB\fP"
are equivalent modulo strong bisimulation.

.P
Note: in certain cases, value enumeration could be avoided. For instance,
the LOTOS terms
"\fIG\fP \fB?\fP\fIx\fP\fB:\fP\fIS\fP \fB[\fP\fIx\fP\fB=\fP\fIv\fP\fB]\fP 
\fB;\fP \fIB\fP"
and 
"\fIG\fP \fB?\fP\fIx\fP\fB:\fP\fIS\fP \fB;\fP 
\fB[\fP\fIx\fP\fB=\fP\fIv\fP\fB]\fP \fB->\fP \fIB\fP"
are strongly equivalent to the term
"\fIG\fP \fB!\fP\fIv\fP \fB;\fP \fIB\fP"
and thus do not require enumerating all values in the domain of 
sort \fIS\fP. However, such optimizations are not yet implemented
in the \fBcaesar\fP compiler. 

.P
To be precise, value enumeration only takes place when performing
exhaustive state-space exploration (namely, when using \fBcaesar\fP to
generate a Labelled Transition System encoded, e.g., in the
.BR aut (LOCAL)
or
.BR bcg (LOCAL)
format), or when performing on-the-fly exploration using one of the
tools based upon the OPEN/CAESAR framework. However, when \fBcaesar\fP is
used to generate C code that will be connected to a real environment using
the EXEC/CAESAR framework, such iteration does not take place and is replaced 
by a call to a so-called "gate function" that will actually input a value
from the real environment, rather than enumerating all possible values that
could be input.

.P
To restrict value enumeration on an infinite or excessively-large sort domain,
the definition (or redefinition) of an ad-hoc iterator (mentioned in the 
previous section) is sometimes non feasible, because it would affect all
other places in the LOTOS specification where this sort is used. In such
case, alternative techniques must be used.

.P
If the sort domain is finite or isomorphic to natural numbers 
(which \fBcaesar.adt\fP implements using a finite interval), the enumeration
can be straightforwardly restricted by adding a predicate to the input action, 
i.e., "\fIG\fP \fB?\fP\fIx\fP\fB:\fP\fIS\fP 
\fB[\fP\fIf\fP(\fIx\fP)\fB]\fP \fB;\fP ...",
so that only those values \fIv\fP satisfying \fIf\fP(\fIx\fP) will be
selected. This may cause an overhead in CPU time, but it is usually 
negligible.

.P
Another technique to restrict the enumeration is to synchonize each input
action with one or many output actions defining the possible values that 
can be sent by the external environment in which the LOTOS specification is
evolving. This requires to introduce, in the LOTOS specification, an extra
process that runs in parallel with the remainder of the specification and
synchronizes on input gates (at least). This added process describes scenarios
of input (and possibly, output) actions exchanged between the system described 
by the LOTOS specification and its environment. In model-checking terminology,
a specification extended with a model of the environment is often called
a \fIclosed-world\fP description, as opposed to an \fIopen-world\fP
description, where no assumption is made about the environment. In the LOTOS
literature, using parallel composition as a logical conjunction to specify 
additional properties is known as a \fIconstraint-oriented\fP specification
style.

.SH OTHER EXTENSIONS TO L\&O\&T\&O\&S

For convenience, a few enhancements to LOTOS have been implemented in the 
CADP tools. These extensions deviate from the standard definition of LOTOS 
[ISO89] but they can be disabled by giving the command-line option 
"\fB-iso\fP", which enforces the standard definition of LOTOS. These
extensions are the following:

.IP 1.
In standard LOTOS, "i" and "I" are reserved keywords, which forbids to declare
any identifier named "i" or "I". The CADP tools relax this constraint by
turning "i" and "I" into reserved identifiers for gates only. This makes it
possible to declare, e.g., variables or operations named "i" or "I". 
See item #1512 in file "\fB$CADP/HISTORY\fP" for details.

.IP 2.
In standard LOTOS, the sorts of formal variable parameters are not used to
resolve overloading ambiguities in actual value expressions of process
instantiations. For instance, if a process P is declared with a formal 
variable parameter X of sort Nat, invoking this process with the actual
value zero requires to write "0 of Nat" rather than simply "0" if sorts Nat 
and Int both have a constant 0. To address this issue, the CADP tools use
extended type-checking rules that allow to write simply "0" rather than 
"0 of Nat", because the declaration of X is taken into account to infer
that 0 has sort Nat.
See item #1803 in file "\fB$CADP/HISTORY\fP" for details.

.IP 3.
In standard LOTOS, the sorts of the value parameters and exit results of the 
top-level specification must be declared in the section of global definitions
(located before the "behaviour" keyword). When this section is empty, the
CADP tools look into the local definitions (located after the "behaviour"
keyword) to find the declaration of these sorts.
See item #1875 in file "\fB$CADP/HISTORY\fP" for details.

.IP 4.
The CADP tools use a modified semantics for flattening parameterized types,
rather than the standard (seemingly questionable) semantics of LOTOS.
The modified semantics is described in [GS95a]; in practice, however, 
the differences between both semantics should not matter too much, given 
that parameterized types are not fully implemented by the CADP tools.
See item #346 in file "\fB$CADP/HISTORY\fP" for details.

.IP 5.
The CADP tools recognize a special comment of the form "\fB(*! atomic *)\fP"
that, if present in a LOTOS specification (usually, after some ">>" operator),
removes all hidden transitions (labelled "\fBi\fP") created by the ">>"
operators. Such special comment is mostly used for the translation of LNT
to LOTOS, and purposedly deviates from the standard operational semantics
of LOTOS behaviour expressions. 
See item #1327 in file "\fB$CADP/HISTORY\fP" for details.

.SH OTHER DEVIATIONS FROM THE L\&O\&T\&O\&S STANDARD

This section lists a few minor differences between the LOTOS standard [ISO89]
and the way it is implemented in the CADP tools:

.IP -
In the labelled transition systems generated by the CADP tools, the
auxiliary gate used for sequential composition, which is noted using the
Greek letter "delta" in the standard semantics of LOTOS, is noted 
"\fBexit\fP" (always in lower case). This decision is justified by the
need to use Latin-alphabet letters only, by the fact that gate "delta" can
only be produced by the "\fBexit\fP" operator of LOTOS, and by the fact
that no user-defined gate can be named "\fBexit\fP" since this name is 
a reserved keyword of LOTOS (which is not the case of "delta").

.IP -
In the labelled transition systems generated by the CADP tools, the
invisible (or internal) gate, which is usually noted using the Greek letter
"tau" in the scientific literature, is noted "\fBi\fP" (always in lower case).
The standard  semantics of LOTOS also uses the same "\fBi\fP" notation.

.IP -
When a LOTOS specification is defined with formal variable parameters, the
standard semantics of LOTOS does not say much on how these parameters should
be handled. Certain LOTOS implementations (e.g., the TOPO tool) reject such
parameterized specifications. The CADP tools (namely, \fBcaesar\fP) also 
reject them, unless the "\fB-root\fP" option is used to provide actual
value expressions that instantiate the formal variable parameters.
.sp
Note: Earlier versions of \fBcaesar\fP handled formal variable parameters by
enumerating the domains of their respective sorts, but this is no longer the
case. See item #2014 in file "\fB$CADP/HISTORY\fP" for details.

.IP -
The CADP tools may differ from [ISO89] when handling process calls in which
two (or more) actual gate parameters are identical. For instance, the
following behavior:
.nf
      \fIP\fP \fB[\fP\fIc\fP, \fIc\fP\fB]\fP
   \fBwhere\fP
      \fBprocess\fP \fIP\fP \fB[\fP\fIa\fP, \fIb\fP\fB]\fP \fB:\fP \fBnoexit\fP \fB:=\fP
         \fIa\fP\fB ;\fP \fBstop\fP \fB||\fP \fIb\fP\fB ;\fP \fBstop\fP
      \fBendproc\fP
.fi
is strongly equivalent to "\fBstop\fP" according to the standard semantics of 
LOTOS, because the body of process \fIP\fP is evaluated \fIafter\fP applying
the gate relabelling function that maps \fIa\fP to \fIc\fP and \fIb\fP
to \fIc\fP. However, this behaviour is equivalent to 
"\fIc\fP\fB ;\fP \fBstop\fP" according to the CADP tools because the 
expansion phase of \fBcaesar\fP implements a \fIcall-by-value\fP semantics 
that applies the gate relabelling function \fIbefore\fP evaluating the body 
of \fIP\fP, which becomes therefore 
"\fIc\fP\fB ;\fP \fBstop\fP \fB||\fP \fIc\fP\fB ;\fP \fBstop\fP". Both
semantics coincide in most cases, and may only diverge if a process is
called with identical actual gate parameters and if some of the corresponding 
formal gate parameters are synchronized together in the body of the 
process. \fBcaesar\fP always emits a warning message if the relabelling
function is not injective; in the absence of such a warning, the call-by-value
semantics conforms to the standard LOTOS semantics.

.P
There are a few other subtle differences, which should not matter to most 
users:

.IP -
When declaring an infix operation
"\fB_\fP\fIF\fP\fB_\fP \fB:\fP \fIS1\fP, ..., \fISn\fP \fB->\fP \fIS\fP",
the standard syntax of LOTOS allows spaces to be inserted between \fIF\fP 
and its two surrounding underscores (see \fIoperator-descriptor\fP in
Section 6.2.5 of [ISO89]). Such syntax is difficult to parse; at the expense 
of internal complexity, the CADP tools parse it properly but do not check that 
identifier \fIF\fP is not a reserved keyword. Though it may be possible to 
declare an infix operation whose name is a keyword, any further occurrences 
of this operation will be syntactically rejected.

.IP -
In Section 7.3.3 of [ISO89], it is acknowledged that the syntax of LOTOS is
ambiguous, as it does not allow to make the difference between a variable
(i.e., value identifier) and a nullary operation occuring in a value
expression. The disambiguation can only be done later using static semantics 
information, but the remainder of the section does not state clearly how to
bind an identifier \fIx\fP when both a variable and a nullary operation exist 
with both the same name \fIx\fP and both an appropriate sort.
.sp
The CADP tools proceed in two steps. First, they search whether a variable 
named \fIx\fP exists; if so, the identifier \fIx\fP is bound to this variable,
whatever the sort of the variable (a type-checking error will occur later
if the variable does not have the proper sort). Second, if no variable
named \fIx\fP exists, they perform operation binding and overloading
resolution, which will have the effect of binding the identifier to a 
nullary operation \fIx\fP if it exists with an appropriate sort. Thus,
preference is always given to variables over nullary operations, which seems
compatible with the principle of binding with the innermost operation
definition when resolving operation overloading.

.IP -
In Section 7.3.4.5.e of [ISO89], requirement (e1) was strengthened to state
that, when the clause "\fBaccept\fP...\fBin\fP" is missing, the behaviour
expression \fIB1\fP occurring in "\fIB1\fP \fB>>\fP \fIB2\fP" must have 
the functionality "\fIexit\fP".

.IP - 
The decision to implement the "\fBlibrary\fP" declaration using file inclusion
(see below the section on LIBRARY FILES) leads to slightly different rules
for the visibility of identifiers declared in libraries. 

.SH FILENAMES

This section describes the various files related to LOTOS specifications and
their implementation.

.SS L\&O\&T\&O\&S FILES

The files containing LOTOS specifications should have a "\fB.lotos\fP" suffix.
This is the preferred convention when using CADP. However, to ease the use
of non-CADP tools, the alternative suffixes "\fB.lot\fP" and "\fB.l\fP" are
also tolerated, i.e., properly recognized by the CADP tools. 

.SS LIBRARY FILES

The directive "\fBlibrary\fP \fIf1\fP, ..., \fIfn\fP \fBendlib\fP" that is
present in the standard LOTOS definition [BB88] without explicit meaning is
implemented using file inclusion by the CADP tools, as follows:
when such a clause is encountered, the CADP tools look for files 
named "\fIF1\fP\fB.lib\fP", ..., "\fIFn\fP\fB.lib\fP" (where the 
strings "\fIF1\fP, ..., \fIFn\fP" are obtained from "\fIf1\fP, ..., \fIfn\fP"
by turning lower-case letters to upper case, since LOTOS identifiers are
case insensitive whereas file names are often case sensitive) and include 
these files, in that order, at the place where the directive "\fBlibrary\fP"
occurs (the directive itself is replaced by the contents of the files). This
is similar to the effect of a "\fB#include\fP" directive with the C
preprocessor.
.P
The "\fB.lib\fP" files are searched first in the current directory, or else 
in the \fB$CADP/lib\fP directory, which contains a collection of predefined 
LOTOS libraries. If a file cannot be found using these search rules, a fatal 
error is reported. More elaborate search rules can be obtained by creating
symbolic links to library files in the current directory.
.P
Library inclusion can be transitive, meaning that "\fB.lib\fP"
files may contain "\fBlibrary\fP" directives. Circular inclusions are 
prohibited.
.P
Contrary to the standard LOTOS definition [BB88], a "\fBlibrary\fP" directive
may occur at any place (i.e., not only in data-type definitions) and may 
contain arbitrary LOTOS code fragments (e.g., process definitions, rather 
than type definitions only). These extensions help splitting large LOTOS
specifications into several files and enable one to develop reusable libraries
of processes (e.g., buffers, shared variables, etc.).

.SS INCLUDE FILES

To be processed by the CADP tools, a LOTOS specification contained in a 
given file \fIfilename\fP\fB.lotos\fP should come together with an 
implementation (in the C language) of the LOTOS sorts and operations.
This implementation must be provided in a file named \fIfilename\fP\fB.h\fP
located in the current directory.
.P
This file can be either written by hand or automatically generated using
.BR caesar.adt (LOCAL). 
In the latter case, both approaches can be combined, as the user may
(optionally) provide two additional files:

.IP -
a file named \fIfilename\fP\fB.t\fP (where "\fB.t\fP" stands for "types") 
that contains manually-written C code for implementing certain LOTOS sorts,
.IP -
a file named \fIfilename\fP\fB.f\fP (where "\fB.f\fP" stands for "functions") 
that contains manually-written C code for implementing certain LOTOS operations.

.P
Each of these files, if present in the current directory at the moment
when \fBcaesar.adt\fP is invoked, will be #included in 
the \fIfilename\fP\fB.h\fP file generated by \fBcaesar.adt\fP. If both
files are present, \fIfilename\fP\fB.t\fP will be included
before \fIfilename\fP\fB.f\fP.

.P
The motivation behind the "\fB.t\fP" and "\fB.f\fP" files is to offer the
possibility to introduce manually-written C code for certain sorts and/or
operations, and also to customize the C code produced by \fBcaesar.adt\fP
without modifying the contents of the "\fB.h\fP" file generated 
by \fBcaesar.adt\fP.

.P
In particular, the files "\fB$CADP/incl/X_*.h\fP", which contain 
manually-written C code to implement standard LOTOS types, should be
included (using a "\fB#include\fP" directive) in the "\fB.t\fP" file
if the LOTOS specification imports the corresponding types defined in
"\fB$CADP/lib/X_*.lib\fP".

.P
The CADP tools generate auxiliary C programs that include the "\fB.h\fP", 
"\fB.t\fP", and "\fB.f\fP" files, then compile these programs and execute
them to obtain information about the types defined in these files. To be
more precise, \fBcaesar.adt\fP compiles only the "\fB.t\fP" file if it 
exists, while \fBcaesar\fP compiles only the "\fB.h\fP" file if it exists
(keeping in mind that, if the "\fB.h\fP" file has been generated 
using \fBcaesar.adt\fP, it should include the "\fB.t\fP", and "\fB.f\fP"
files if they were present at the time \fBcaesar.adt\fP was invoked).

.P
So doing, the CADP tools check that the manually-written C code contained in
these files is valid according to the definition of the C language. However,
the CADP tools cannot verify whether this C code correctly implements the 
intended meaning of the sorts and operations defined in the LOTOS
specification. In practice, such mistakes can be difficult to detect. 
When debugging such problems, one can safely assume that the errors are in 
the C code manually written by the user, rather than in the C code generated 
by the CADP tools.

.P
Notice that the "\fB-external\fP" option of \fBcaesar.adt\fP is helpful,
as it generates, for the "\fB.t\fP", and "\fB.f\fP" files, skeletons that 
can be later filled in by the user.

.SH TAILORED CODE GENERATION FOR DATA TYPES

\fBcaesar.adt\fP analyzes LOTOS sorts and their constructors and recognizes 
various classes of sorts that can be implemented efficiently, if not
optimally [Gar89c,GT93]. These classes are the following:

.TP
\fIsingleton sorts\fP:
They have only one element; such sorts often arise when performing value
abstraction, i.e., replacing a complex sort by a singleton.

.TP
\fIenumeration sorts\fP:
They correspond to the usual notion of enumerated types.

.TP
\fInumeral sorts\fP:
They correspond to the usual notion of (infinite) natural numbers,
which \fBcaesar.adt\fP restricts to a finite range 0...(\fIn\fP-1).
The value of \fIn\fP is determined as follows: if the 
macro \fBCAESAR_ADT_HASH_\fP\fIN\fP is defined in the "\fB.t\fP" file
(see below the section on SPECIAL SYMBOLS for details), then \fIn\fP is
given by the value of this macro; else if \fBcaesar.adt\fP is invoked
with option \fB-numeral\fP, then \fIn\fP is given by the integer value
following this option; otherwise \fIn\fP is set to 256 (meaning that,
by default, values of a numeral sort are stored using a single byte to
avoid wasting memory during state-space exploration).

.TP
\fItuple sorts\fP:
They correspond to the usual notion of record types.

.TP
\fIordinary sorts\fP:
They correspond to the usual notion of discriminated union types.

.P
Even when automatic code generation is used, it is still possible to 
instruct \fBcaesar.adt\fP to adapt its C code generation to particular
requirements. This can be done in four (non mutually exclusive) ways:

.IP -
By passing specific options on the command line (e.g., \fB-debug\fP,
\fB-infix\fP, \fB-macro\fP, \fB-prefix\fP, \fB-trace\fP) to modify the 
generated C code;

.IP -
By declaring certain LOTOS sorts as \fIexternal\fP (see the section below
on SPECIAL COMMENTS FOR SORTS) and providing the C code that implements
these sorts in \fIfilename\fP\fB.t\fP.

.IP -
By declaring certain LOTOS operations as \fIexternal\fP (see the section 
below on SPECIAL COMMENTS FOR OPERATIONS) and providing the C code that
implements these operations in \fIfilename\fP\fB.f\fP.

.IP -
By inserting, in the aforementioned file \fIfilename\fP\fB.t\fP, various
directives that influence the way certain LOTOS sorts are implemented in C.
See below the section on SPECIAL SYMBOLS for details.

.SH L\&O\&T\&O\&S AND C IDENTIFIERS

To execute LOTOS specifications, one must establish a correspondence between 
\fIabstract\fP data types (i.e., LOTOS sorts and operations) and 
their \fIconcrete\fP implementations (i.e., C types and functions or 
macro-definitions). There is no direct, one-to-one correspondence, because:
(i) LOTOS operation identifiers may contain special characters (e.g., "#", 
"@", etc.) that are not allowed in C identifiers; (ii) LOTOS allows a sort
and an operation to share the same identifier, whereas types and functions
must have distinct identifiers in C; (iii) a LOTOS operation identifier may
be overloaded and thus be implemented by different C functions or 
macro-definitions, each of which must have unique identifier in C.
Notice also that, although LOTOS identifiers are case-insensitive, C 
identifiers are case-sensitive.
.P
In the sequel, a \fIvalid C identifier\fP denotes any identifier that obeys
the rules of the C language; such an identifier must be different from the
reserved keywords of C (i.e., "\fBif\fP", "\fBwhile\fP", etc.), but should 
also be different from POSIX names (e.g., "\fBexit\fP", "\fBFILE\fP", 
"\fBfopen\fP", "\fBmalloc\fP", "\fBprintf\fP", etc.). Moreover, it should 
not start with a prefix used by the CADP tools, among which "\fBADT_\fP,
"\fBadt_\fP, "\fBCAESAR_\fP", "\fBcaesar_\fP", "\fBBCG_\fP", "\fBbcg_\fP",
"\fBXTL_\fP", and "\fBxtl_\fP". It may be worth that users choose another
prefix and use it systematically before their own C identifiers.

.P
The standard definition of LOTOS makes no provision for mapping abstract
data types to concrete ones, so that interface conventions often differ
across tools that implement LOTOS. The next section describes the conventions
adopted by the CADP tools for LOTOS.

.SH SPECIAL COMMENTS
.P
Mapping information is inserted directly in the LOTOS specifications by means
of \fIspecial comments\fP. Such special comments have the following syntax
"\fB(*! ... *)\fP" and are thus a subset of ordinary LOTOS comments
"\fB(* ... *)\fP". But, unlike ordinary comments, their content is meaningful 
and parsed. 
.P
Note: users should carefully respect the syntax of special comments because
they are scanned at a lexical rather than syntactic level. Thus, in case of 
syntax errors in a special comment, the error-recovery actions performed by
the SYNTAX compiler-generator system used to build the CADP tools may be
less intuitive than usually, yielding a cascade of cryptic error messages.
.P
There are two main classes of special comments: those attached to LOTOS
operations, and those attached to LOTOS sorts. Unless stated otherwise,
special comments are optional. If present, they must occur immediately after
the declaration of the sort or the operation they are attached to. 
.P
It is not permitted to attach a special comment to a LOTOS sort or operation 
defined by renaming an other sort or operation, because \fBcaesar.adt\fP
generates no C code for renamed sorts and operations, and just implements
these as synonyms of the sorts and operations they rename.
.P
It is not permitted to attach a special comment to a LOTOS sort or operation
that is either formal (i.e., generic) or defined by actualizing an other
sort or operation, because \fBcaesar.adt\fP generates no C code to implement 
parameterized data types.
.P
Numerous examples of special comments can be found by examining the 
predefined LOTOS libraries contained in directory "\fB$CADP/lib\fP".
The simplest example is probably the \fIBIT\fP type declared in 
"\fB$CADP/lib/X_BIT.lib\fP" and implemented in "\fB$CADP/incl/X_BIT.h\fP".

.SS SPECIAL COMMENTS FOR SORTS

A special comment attached to the declaration of a LOTOS sort \fIS\fP has
the following syntax (where square brackets mean optional elements):

.nf
   \fB(*!\fP
      [ \fBimplementedby\fP \fIN\fP ]
      [ \fBcomparedby\fP \fIN1\fP ]
      [ \fBiteratedby\fP \fIN2\fP \fBand\fP \fIN3\fP ]
      [ \fBprintedby\fP \fIN4\fP ]
      [ \fBlist\fP ]
      [ \fBexternal\fP ]
   \fB*)\fP
.fi

.P
where \fIN\fP, \fIN1\fP, \fIN2\fP, \fIN3\fP, and \fIN4\fP are valid C
identifiers. Even if these elements are optional, their order cannot be 
modified. Spaces and blanks are allowed inside special comments.
All letters in the words "\fBimplementedby\fP", "\fBcomparedby\fP", ...,
"\fBexternal\fP" can be either in lower or upper case; it is advised to
use the lower case only.

.P
The meaning of special comments is the following:

.IP -
The attribute "\fBimplementedby\fP \fIN\fP", if present, indicates that
the abstract LOTOS sort \fIS\fP is implemented by a concrete C type 
named \fIN\fP. The simplest way is to declare \fIN\fP using a "\fBtypedef\fP"
instruction, but declaring \fIN\fP as a macro-definition is also possible.
.sp
Type \fIN\fP can be any C type whose values occupy a fixed number of
bits, so that values of type \fIN\fP can be copied using a standard
C assignment operator "\fB=\fP". This obviously allows (signed and unsigned) 
integers and characters, reals, and enums. This also allows struct and union 
types, for which assignment is also permitted in C; the CADP tools take into 
account the case of certain C compilers that copy each field of structs or 
unions, but do not copy the padding bits that may exist between these fields:
in such case, assignment is replaced by a call to the \fBmemcpy()\fP function
to avoid creating uncanonical values (i.e., identical struct or union values
having a different representation in memory). Array types are not allowed
because assignment is not permitted for them. Finally, pointer types (to,
e.g., vectors, matrices, linked lists, binary trees, etc.) are also allowed,
provided that the allocated memory cells to which they point are assigned 
only once and not modified later. Thus, any function with an argument of 
pointer type should not modify this  argument but first make a copy of it 
and modify this copy only. Under this condition, structural sharing (i.e.,
several pointers referring to the same memory cell) will work correctly.
See below the section on SPECIAL SYMBOLS for a discussion on structural
sharing, as well as other points such as bit fields.
.sp
If the attribute "\fBimplementedby\fP" is absent, the CADP tools will generate 
a unique C identifier for the implementation of \fIS\fP. Nothing else should
be assumed about this identifier. In particular, it may change with future 
versions of the CADP tools.
.sp
The option \fB-comments\fP of the CADP tools emits a warning for each
unspecified "\fBimplementedby\fP" attribute.
.sp
The option \fB-map\fP of the CADP tools produces a file that gives the name
correspondence between abstract LOTOS sorts and concrete C types.

.IP -
The attribute "\fBcomparedby\fP \fIN1\fP", if present, indicates that
the equality comparison between two abstract values of sort \fIS\fP is
implemented by a concrete C function (or macro-definition) named \fIN1\fP.
This function takes two arguments of type \fIN\fP and returns a result 
of type \fBint\fP, which is zero if both arguments are equal, or non-zero
(yet not necessarily one) if both arguments are different.
.sp
If the attribute "\fBcomparedby\fP" is absent, a unique C identifier is
generated for \fIN1\fP, with no other guarantee.
.sp
Notice that function \fIN1\fP should always exist, even if sort \fIS\fP
has no associated comparison operation (e.g., "\fIeq\fP \fB:\fP \fIS\fP, 
\fIS\fP \fB->\fP \fIBool\fP") defined explicitly in the LOTOS specification.
Indeed, one must compare values of sort \fIS\fP whenever they occur 
in equation premisses ("\fIX\fP\fB=\fP\fIY\fP \fB=>\fP ..."), in Boolean
guards ("\fB[\fP\fIX\fP\fB=\fP\fIY\fP\fB] ->\fP ..."), or in rendezvous with
value matching ("\fIG\fP\fB!\fP\fIX\fP ... \fB||\fP \fIG\fP\fB!\fP\fIY\fP ...").
.sp
For simple types (e.g., integers or enumerated types), function \fIN1\fP is
often a mere equality test (noted "\fB==\fP" in C). However, for more complex
types, computations may be more involved, e.g., comparison of two real numbers 
up to a given precision, or deep comparison of linked data structures.
.sp
The definition of function \fIN1\fP should always take into account the 
cases where one or both of its arguments is equal to a bit pattern consisting 
only of zeros, even if such a bit-zero pattern does not normally belong to the
admissible values of type \fIN\fP (for instance, if \fIN\fP is a pointer type
denoting C character strings, the case of the \fBNULL\fP value should 
nevertheless be considered). This is due to the fact that \fBcaesar\fP
initializes all simulator variables to an undefined value represented by
a bit-zero pattern, and also resets variables to this undefined value as 
soon as they are no longer used.

.IP -
The attribute "\fBiteratedby\fP \fIN2\fP \fBand\fP \fIN3\fP", if
present, indicates that the enumeration of all values in the domain of
sort \fIS\fP (or in a finite subset if this domain is infinite or too large)
is implemented by two macro-definitions named \fIN2\fP and \fIN3\fP
(see above the section on FINITE-DOMAIN CONSTRAINTS for a discussion
on iterators). 
The macro \fIN2\fP has no argument and returns a constant value of 
type \fIN\fP, which is the "first" value to be enumerated in the 
domain of \fIS\fP. The macro \fIN3\fP takes one argument, which is
an l-value of type \fIN\fP, and returns a result of type \fBint\fP; 
\fIN3\fP tries to advance its argument to the "next" value 
in the domain of \fIS\fP and returns a non-zero result if such a next
value exists, or a zero result if the argument was already equal to the
"last" value in the domain of \fIS\fP. Therefore, enumerating the domain
of \fIS\fP can be achieved using the following fragment of C code:

.nf
   \fIN\fP x;
   x = \fIN2\fP;
   \fBdo\fP {
      ...
   } \fBwhile\fP (\fIN3\fP (x));
.fi

For an external sort, the iteration macros \fIN2\fP and \fIN3\fP have to
be provided by the user in the "\fB.t\fP" file. Notice that, for the 
external sorts \fIBit\fP, \fIBool\fP, \fIChar\fP, \fIInt\fP, and \fINat\fP
defined in the "\fB$CADP/lib/X_*.lib\fP" files, manually-written iterators
are provided in the corresponding "\fB$CADP/incl/X_*.h\fP" and 
"\fB$CADP/incl/adt_*.h\fP" files. For the two latter sorts, the bounds of
the iterator can be modified by defining the macros \fBADT_INF_NAT\fP,
\fBADT_SUP_NAT\fP, \fBADT_INF_INT\fP, and/or \fBADT_SUP_INT\fP before
including the "\fBX_*.h\fP" file.
.sp
For a non-external sort, these macros are generated automatically
by \fBcaesar.adt\fP if and only if the domain of the sort is finite;
however, these macros are also generated for numeral sorts, even if the 
domain of these sorts is infinite, but \fBcaesar.adt\fP restricts the
iterations to a finite range (by default, 0...255).
.sp
Even when the iteration macros are generated by \fBcaesar.adt\fP, the user 
can still provide alternative definitions for these macros (e.g., to 
enumerate only prime numbers below 1000). This can be done by inserting,
in the "\fB.t\fP" file, the following directives:

.nf
   #undef \fIN2\fP
   #define \fIN2\fP ...
   #undef \fIN3\fP
   #define \fIN3\fP(...) ...
.fi

For numeral sorts, a simpler way to restrict the iterations to the 
range 0...(\fIn\fP-1) is to define the macro \fBCAESAR_ADT_HASH_\fP\fIN\fP
to \fIn\fP (see below the section on SPECIAL SYMBOLS for details).
.sp
If the attribute "\fBiteratedby\fP" is absent, unique C identifiers are
generated for \fIN2\fP and \fIN3\fP, with no other guarantee.
.sp
Note: the attribute "\fBiteratedby\fP" was introduced in April 2004; earlier
versions of the CADP tools used another attribute "\fBenumeratedby\fP" that
is now deprecated as it could not provide iteration for "complex" LOTOS sorts.
See item #903 in file "\fB$CADP/HISTORY\fP" for details and comparison between
old-style and new-style iterators.

.IP -
The attribute "\fBprintedby\fP \fIN4\fP", if present, indicates that the
abstract values of sort \fIS\fP can be displayed using a concrete C function
(or macro-definition) named \fIN4\fP. This function takes two arguments,
a POSIX stream (of type "\fBFILE *\fP") and a value of type \fIN\fP, and
returns a result of type \fBvoid\fP (i.e., no result at all). This function
prints the value to the stream as a human-readable character string, on a
single line and using printable characters only (carriage-return or line-feed
character are forbidden, and non-printable characters must be escaped).
.sp
If the attribute "\fBprintedby\fP" is absent, a unique C identifier is
generated for \fIN4\fP, with no other guarantee.
.sp
The definition of function \fIN4\fP should always take into account the case
where the value to print is undefined (i.e., equal to a bit-zero pattern).

.IP -
The attribute "\fBlist\fP", if present, signals that sort \fIS\fP is a
list data structure and instructs \fBcaesar.adt\fP to generate a printing
function \fIN4\fP that displays the values of this sort as lists rather 
than algebraic terms, e.g., "{\fIx\fP, \fIy\fP, \fIy\fP}" rather than
"CONS (\fIx\fP, CONS (\fIy\fP, CONS (\fIz\fP, NIL)))".
See item #1475 in file "\fB$CADP/HISTORY\fP" for details.

.IP -
The attribute "\fBexternal\fP", if present, instructs \fBcaesar.adt\fP not to
generate C code for \fIS\fP, which has to be implemented manually.
For this sort, the user must provide, in the "\fB.t\fP" file, the
corresponding C type \fIN\fP that implements \fIS\fP, the comparison 
function \fIN1\fP, the iteration macros \fIN2\fP and \fIN3\fP (if needed), 
and the printing function \fIN4\fP.
.sp
If a sort is declared to be external, the attributes "\fBimplementedby\fP",
"\fBcomparedby\fP", "\fBiteratedby\fP" (if needed), and "\fBprintedby\fP"
should be present, so that the names \fIN\fP, ... \fIN4\fP are fixed
and will not change even if the LOTOS specification is modified or if the
CADP tools are upgraded to a new version.
.sp
Other constraints on external sorts have been listed above in the section
entitled CONSTRAINTS ON SORTS AND CONSTRUCTORS.

.SS SPECIAL COMMENTS FOR OPERATIONS

A special comment attached to the declaration of a LOTOS operation \fIF\fP has
the following syntax (where square brackets mean optional elements):

.nf
   \fB(*!\fP
      [ \fBimplementedby\fP \fIN\fP ]
      [ \fBconstructor\fP ]
      [ \fBexternal\fP ]
   \fB*)\fP
.fi

.P
where \fIN\fP is a valid C identifier.
Even if these elements are optional, their order cannot be modified.
Spaces and blanks are allowed inside special comments. 
All letters in the words "\fBimplementedby\fP", "\fBconstructor\fP",
"\fBexternal\fP" can be either in lower or upper case; it is advised to
use the lower case only.

.P
The meaning of special comments is the following:

.IP -
The attribute "\fBimplementedby\fP \fIN\fP", if present, indicates that
the abstract LOTOS operation \fIF\fP is implemented by a concrete C function 
or macro-definition named \fIN\fP.
The parameters and result of \fIN\fP must be compatible with those of \fIF\fP.
.sp
If \fIF\fP is a LOTOS constant (i.e., an operation with arity zero) and
if \fIN\fP is a C macro-definition, then \fIN\fP must be defined to be
followed by parentheses surrounding an empty list of arguments, so that any 
call to \fIN\fP should be written "\fIN()\fP" rather than "\fIN\fP".
.sp
If the attribute "\fBimplementedby\fP" is absent, the CADP tools will generate 
a unique C identifier for the implementation of \fIF\fP. Nothing else should
be assumed about this identifier. In particular, it may change with future 
versions of the CADP tools.
.sp
The option \fB-comments\fP of the CADP tools emits a warning for each
unspecified "\fBimplementedby\fP" attribute.
.sp
The option \fB-map\fP of the CADP tools produces a file that gives the name
correspondence between abstract LOTOS operations and concrete C functions.

.IP -
The attribute "\fBconstructor\fP", if present, instructs \fBcaesar.adt\fP 
that \fIF\fP is a constructor operation. Otherwise, \fBcaesar.adt\fP will
assume that \fIF\fP is a non-constructor, i.e., an operation whose meaning
is defined by the algebraical equations contained in the LOTOS specification.

.IP -
The attribute "\fBexternal\fP", if present, instructs \fBcaesar.adt\fP not to
generate C code for \fIF\fP, which has to be implemented manually.
.sp
If \fIF\fP is a non-constructor, the user must provide, in the "\fB.f\fP" 
file, the corresponding C function or macro-definition \fIN\fP that
implements \fIF\fP.
.sp
If \fIF\fP is a constructor, the user must provide, in the "\fB.t\fP" file, 
the corresponding C function or macro-definition \fIN\fP that
implements \fIF\fP, a \fItester\fP function \fIN0\fP taking one 
argument \fIx\fP of type \fIN\fP and returning a non-zero result if \fIx\fP
matches at its top level the constructor \fIF\fP, and \fIn\fP \fIselector\fP 
functions \fIN1\fP, ..., \fINn\fP (where \fIn\fP is the arity of \fIF\fP)
taking one argument \fIx\fP of type \fIN\fP that satisfies \fIN0\fP (\fIx\fP)
!= 0 and returning, respectively, the values \fIx1\fP, ..., \fIxn\fP
such that \fIx\fP = \fIN\fP (\fIx1\fP, ..., \fIxn\fP).
.sp
If an operation is declared to be external, the attribute "\fBimplementedby\fP"
should be present, so that the name \fIN\fP of the implementation is fixed
and will not change even if the LOTOS specification is modified or if the
CADP tools are upgraded to a new version. 
.sp
If the operation is a constructor, attributes should exist for fixing the
names of the tester and selector functions, but such attributes are not
implemented yet.
.sp
Other constraints on external sorts have been listed above in the section
entitled CONSTRAINTS ON NON-CONSTRUCTORS AND EQUATIONS.

.SH SIDE EFFECTS IN EXTERNAL FUNCTIONS

As a general principle, any C function implementing a (constructor or
non-constructor) LOTOS operation should not perform side effects because
these are not present in the formal semantics of LOTOS abstract data types.
.P
When the manually-written C code is to be used together with \fBcaesar\fP
(i.e., mixed with C code automatically generated by \fBcaesar\fP for
state-space exploration), the above principle holds quite strictly. In
practice, side effects may be possible but only under very limited forms:
allocating new memory cells, storing data values in a unique way 
using hash tables, or writing information to files (e.g., traces on log
files). All other forms of side effects are prohibited. In particular,
certain optimizations performed by \fBcaesar\fP may become incorrect in
presence of external functions with side effects.

.P
When the manually-written C code is not to be used with \fBcaesar\fP,
the aforementioned prohibition can be relaxed, so as to obtain the same
features as monads in functional languages. It becomes even possible to 
provide manually-written C functions that keep internal variables or 
modify previously allocated data structures (e.g., update certain fields 
of a linked list).
.P
This is a risky practice that requires care and insight. An example of 
monads can be found by inspecting the \fIACTION\fP type declared in 
"\fB$CADP/lib/X_ACTION.lib\fP" and implemented in 
"\fB$CADP/incl/X_ACTION.h\fP".

.SH CALL-\&BY-\&NEED EVALUATION IN EXTERNAL FUNCTIONS
.P
When implemented manually as C macro-definitions, certain LOTOS operations
can avoid the call-by-value semantics enforced by \fBcaesar.adt\fP (i.e., 
the actual arguments of a function are always evaluated before calling
this function) and rely on call-by-need semantics instead.
.P
A first example is given by the \fIand_then\fP and \fIor_else\fP operators
declared in \fB$CADP/lib/X_BOOLEAN.lib\fP". These operators are implemented
in "\fB$CADP/incl/X_BOOLEAN.h\fP" as macro-definitions that expand to the C
operators "\fB&&\fP" and "\fB||\fP". Depending on the value of their first
argument, these operators may skip evaluating their second argument
(performing so-called "short-circuits").
.P
A second example is given by the \fIif_then\fP and \fIif_then_else\fP 
operators declared in "\fB$CADP/lib/X_ACTION.lib\fP". These operators are
implemented in "\fB$CADP/incl/X_ACTION.h\fP" as macro-definitions that 
expand to the C ternary operator "(...\fB?\fP...\fB:\fP...)". The value of
the first argument determines which one of the remaining arguments will be
evaluated.

.SH MEMORY CONCERNS WITH DATA TYPES

Saving memory is of utmost importance when using verification techniques
based on state-space exploration. This section presents some effective 
ways to save memory when using LOTOS abstract data types with the CADP tools.

.P
Let \fIC\fP be a constructor that may allocate memory when invoked (for 
instance, \fIC\fP can be the \fIcons\fP operator of linked lists). Any
call to \fIC\fP in the patterns on the left-hand side of an equation will
not allocate memory. However, any call to \fIC\fP in a premiss or on
the right-hand side of an equation will allocate memory, so one should
be careful about such calls if memory space needs to be optimized.

.P
Dynamically-allocated data types are expensive. By default, \fBcaesar.adt\fP
tries to reduce their use by introducing as few pointer types as needed in 
the generated C code, only resorting to pointers where they are necessary
to break dependencies between circular types, or where the user has
explicitly asked for pointers (see the \fBCAESAR_ADT_HASH_\fP\fIN\fP symbol
below).

.P
For a dynamically-allocated type that needs pointers (e.g., a list type), 
the user can request (still using the \fBCAESAR_ADT_HASH_\fP\fIN\fP symbol)
to store all the values of this type in a hash table, meaning that 
each value is represented by its index in the table. Different types have 
different hash tables, meaning that the sizes of tables and the numbers of 
bits for indexes can be tuned for each type independently. The user has to
predict a maximal size for each table, i.e., an upper bound on the number
of values that will be inserted. The advantages of this approach are twofold:
(i) memory consumption is significantly reduced, as identical values are
stored in memory only once; and (ii) the CPU overhead required for insertion
and lookup in hash tables is usually compensated by the gain in comparing
values, because only indexes have to be compared (it is no longer necessary
to perform "deep" structural comparison of algebraic terms). Because
the "\fBcaesar_table_1\fP" library of OPEN/CAESAR is used to handle these 
hash tables, any "\fB.h\fP" file generated by \fBcaesar.adt\fP must be
linked, if it uses hash tables, against the "\fBlibcaesar.a\fP" library of
OPEN/CAESAR and, possibly, the complement library "\fBlibcaesar_plug.a\fP".

.P
Finally, for dynamically-allocated types not stored in tables, it is
also possible to activate a conservative garbage collector, using the "\fBCAESAR_ADT_GARBAGE_COLLECTION\fP" macro defined below.

.SH "SPECIAL SYMBOLS USED IN THE C CODE"

A number of variables, functions, and macro-definitions may or must be
used to exploit at its best the C code generated by \fBcaesar.adt\fP.
Here are the most important ones, sorted into different categories.

.SS VERSION CHECKING

The four following symbols are used for checking versions:

.TP
\fBCAESAR_ADT\fP
This macro is defined in any "\fB.h\fP" file generated by \fBcaesar.adt\fP 
and is equal to the version number of \fBcaesar.adt\fP (e.g., 5.4) at the 
time the file was produced. This macro can be consulted in the "\fB.f\fP"
and "\fB.t\fP" files written by the user.

.TP
\fBCAESAR_ADT_EXPERT\fP
In any "\fB.h\fP" file not generated by \fBcaesar.adt\fP and containing
manually-written C code to be used with \fBcaesar\fP, the user should 
insert a macro-definition of the following form:
.nf
     \fB#define CAESAR_ADT_EXPERT\fP x.y
.fi
where x.y is the version number of \fBcaesar.adt\fP at the time 
the file was written. \fBcaesar\fP will check this number and, should the
conventions evolve in the future, use it to ensure backward compatibility
or warn about deprecated contents. See items #622 and #1033 in file 
"\fB$CADP/HISTORY\fP" for details.

.TP
\fBCAESAR_ADT_EXPERT_F\fP
In any "\fB.f\fP" file, the user should insert a macro-definition of the 
following form:
.nf
     \fB#define CAESAR_ADT_EXPERT_F\fP x.y
.fi
where x.y is the version number of \fBcaesar.adt\fP at the time 
the file was written. \fBcaesar\fP and \fBcaesar.adt\fP will check this number 
and, should the conventions evolve in the future, use it to ensure backward
compatibility or warn about deprecated contents. See items #622 and #1033 in 
file "\fB$CADP/HISTORY\fP" for details.

.TP
\fBCAESAR_ADT_EXPERT_T\fP
In any "\fB.t\fP" file, the user should insert a macro-definition of the 
following form:
.nf
     \fB#define CAESAR_ADT_EXPERT_T\fP x.y
.fi
where x.y is the version number of \fBcaesar.adt\fP at the time 
the file was written. \fBcaesar\fP and \fBcaesar.adt\fP will check this number 
and, should the conventions evolve in the future, use it to ensure backward
compatibility or warn about deprecated contents. See items #622 and #1033 in
file "\fB$CADP/HISTORY\fP" for details.

.SS INTERFACING

The following symbol determines the usage of a "\fB.h\fP" file:

.TP
\fBCAESAR_ADT_INTERFACE\fP
The "\fB.h\fP" file generated by \fBcaesar.adt\fP often contains more than
mere interface declarations, as it also contains definitions of variables and 
functions. Thus, the "\fB.h\fP" file can be included only once, in one 
single "\fB.c\fP" file, otherwise double definitions will ensue at
link-edit time. The \fBCAESAR_ADT_INTERFACE\fP macro-definition addresses
this issue. If this macro is defined before including the "\fB.h\fP" file,
i.e.:
.nf
     \fB#define CAESAR_ADT_INTERFACE\fP
     \fB#include "\fP\fIfilename\fP\fB.h\fP\fB"\fP
.fi
only the interface declarations contained in "\fIfilename\fP\fB.h\fP" will
be included. See item #859 in file "\fB$CADP/HISTORY\fP" for details.

.SS INITIALIZATION AND TERMINATION

The two following symbols perform initialization and termination:

.TP
\fBCAESAR_ADT_INIT()\fP
The "\fB.h\fP" file generated by \fBcaesar.adt\fP defines a function
named \fBCAESAR_ADT_INIT()\fP that must be invoked before using any other 
primitive contained in the "\fB.h\fP" file. See items #212, #1253, and
#1914 in file "\fB$CADP/HISTORY\fP" for details.

.TP
\fBCAESAR_ADT_TERM(...)\fP
The "\fB.h\fP" file generated by \fBcaesar.adt\fP defines a function
named \fBCAESAR_ADT_TERM()\fP that can be (optionally) invoked by the user 
when the other primitives contained in the "\fB.h\fP" file will not 
be called any more. This function takes a single parameter of type
"\fBFILE *\fP" and, if this parameter is not \fBNULL\fP, prints to 
this file the contents of the hash tables for which the user has 
provided a format by means of the symbols \fBCAESAR_ADT_FORMAT_\fP\fIN\fP
or \fBCAESAR_ADT_FORMAT\fP defined below. This function then deletes all 
the hash tables allocated in memory. See item #1250 in file 
"\fB$CADP/HISTORY\fP" for details.

.SS TYPE TUNING

The following symbols enable the representation of types to be modified:

.TP
\fBADT_BITS_NAT\fP
If defined to a natural value \fIn\fP before including the file 
"\fB$CADP/incl/X_NATURAL.h\fP" that implements the natural numbers defined
in the "\fBX_NATURAL.lib\fP" library, this macro indicates that natural 
numbers are implemented on \fIn\fP bits only. See item #1584 in file
"\fB$CADP/HISTORY\fP" for details.

.TP
\fBADT_BITS_INT\fP
If defined to a natural value \fIn\fP before including the file 
"\fB$CADP/incl/X_INTEGER.h\fP" that implements the integer numbers defined
in the "\fBX_INTEGER.lib\fP" library, this macro indicates that integer
numbers are implemented on \fIn\fP bits only. See item #1584 in file
"\fB$CADP/HISTORY\fP" for details.

.TP
\fBCAESAR_ADT_BITS_\fP\fIN\fP
If defined, this macro indicates that the C type \fIN\fP implementing some 
LOTOS sort \fIS\fP can be stored as a bit field in a C struct or union type.
The value of the macro should have the following form ": \fIn\fP" (without
the surrounding double quotes), where \fIn\fP is the number of bits needed 
for representing type \fIN\fP, knowing that \fIn\fP <= \fBsizeof\fP (\fIN\fP).
For non-external sorts, this macro is automatically defined 
by \fBcaesar.adt\fP, and, for external sorts, it can be manually defined 
by the user in the "\fB.t\fP" file; forgetting to define this macro when
appropriate is harmless though less efficient, as more memory will be used
than needed.

.TP
\fBCAESAR_ADT_HASH_\fP\fIN\fP
If defined by the user in the "\fB.t\fP" file as an integer value \fIn\fP,
this macro specifies the way in which the C type \fIN\fP implementing a 
LOTOS sort \fIS\fP must be defined. If \fIS\fP is not external,
then \fBcaesar.adt\fP takes this macro into account to generate
the C code for type \fIN\fP. If \fIS\fP is external, then \fBcaesar.adt\fP 
takes this macro into account to implement or optimize the sorts that
transitively depend on \fIS\fP.
.sp
Setting \fIn\fP > 1 means that the values of sort \fIS\fP are stored in
a hash table that can contain at most \fIn\fP elements. Type \fIN\fP will
be implemented as an index ranging between 0 and (\fIn\fP-1) that gives
access to this table. \fBcaesar.adt\fP checks that the value of \fIn\fP 
is not too large. \fIS\fP should be a tuple, an ordinary, an external,
or a numeral sort (the latter case will be detailed below).
If \fIS\fP is a singleton or an enumeration sort, a warning will be emitted
and the definition of \fBCAESAR_ADT_HASH_\fP\fIN\fP will be ignored.
If the limit of \fIn\fP values is exceeded, the execution will stop with
a \fBSIGTERM\fP signal unless the user has specified a different error
handler using the \fBCAESAR_ADT_OVERFLOW_\fP\fIN\fP macro defined below.
.sp
Setting \fIn\fP < 0 means that the values of sort \fIS\fP are stored in
a hash table that can contain at most (2^-\fIn\fP) elements. This case 
is similar to the previous one, noticing that values of type \fIN\fP
will be implemented on (-\fIn\fP) bits exactly. \fBcaesar.adt\fP checks 
that the value of \fIn\fP is not too small.
.sp
Setting \fIn\fP = 1 means that the values of sort \fIS\fP should be
implemented using pointers to structs or to unions (i.e., they should have
a \fIboxed\fP representation). \fIS\fP should be a tuple, an ordinary, 
or a numeral sort (the latter case will be detailed below). If \fIS\fP 
is a singleton, an enumeration, or an external sort, a warning will be
emitted and the definition of \fBCAESAR_ADT_HASH_\fP\fIN\fP will be ignored.
.sp
Setting \fIn\fP = 0 means that the values of sort \fIS\fP should neither be
implemented using pointers (i.e., they should have an \fIunboxed\fP 
representation) nor be stored in a hash table. \fIS\fP can be a singleton,
an enumeration, a tuple, or an ordinary sort; in the two latter cases, 
an error is reported if there are cyclic dependencies that cannot be 
resolved by introducing pointers or table indexes because the user
has forbidden to do so by requiring \fIn\fP = 0 for the mutually recursive
types. If \fIS\fP is a numeral, an error message is also emitted as 
having \fIn\fP = 0 would be meaningless. If \fIS\fP is an external sort, 
taking \fIn\fP = 0 has no effect and is ignored silently.
.sp
As a consequence of the above, for singleton and enumeration sorts,
the \fBCAESAR_ADT_HASH_\fP\fIN\fP macro should either be undefined
or have its value \fIn\fP set to zero.
.sp
In the case of numeral sorts, hash tables are never used, whatever which
value is given to \fIn\fP. Setting \fIn\fP > 0 means that type \fIN\fP
will represent the natural numbers ranging between 0 and (\fIn\fP-1).
Setting \fIn\fP < 0 means that type \fIN\fP will represent the natural 
numbers coded on (-\fIn\fP) bits.
.sp
Finally, if the \fBCAESAR_ADT_HASH_\fP\fIN\fP macro is undefined,
\fBcaesar.adt\fP automatically chooses the most appropriate implementation
corresponding to either \fIn\fP = 0 or \fIn\fP = 1; \fBcaesar.adt\fP will
do its best efforts to avoid implementing \fIN\fP as a pointer type 
(i.e., choosing \fIn\fP = 0) unless this is necessary to break circular
type dependencies. Hence, by default, no LOTOS sort will have its value
stored in a hash table unless specifically requested by the user.
.sp
See items #623, #1250, #1251, #1255, #1332, #1435, #1494, and #1498 
in file "\fB$CADP/HISTORY\fP" for details.

.TP
\fBCAESAR_ADT_HASH_ADT_STRING\fP
If defined to an integer value \fIn\fP before including the file 
"\fB$CADP/incl/X_STRING.h\fP" that implements the (variable-length)
character strings defined in the "\fBX_STRING.lib\fP" library, this 
macro modifies the way strings are stored in memory. By default,
strings are allocated dynamically using \fBmalloc()\fP, which can be
memory-inefficient. If \fIn\fP > 1, strings are stored in a hash table 
with \fIn\fP entries at most. If \fIn\fP < 0, strings are stored in a
hash table with 2^(-\fIn\fP) entries at most. See item #1495 in file
"\fB$CADP/HISTORY\fP" for details.

.TP
\fBCAESAR_ADT_SCALAR_\fP\fIN\fP
If defined, this macro indicates that the constant 0 belongs to the C 
type \fIN\fP implementing some LOTOS sort \fIS\fP, so that variables of
this type can be reset simply by assigning zero to them. In the C language, 
this corresponds to the usual notion of \fIscalar\fP type, which includes
(signed and unsigned) integers and characters, reals, enums, and pointers,
but excludes arrays, structs, and unions. For non-external
sorts, this macro is automatically defined by \fBcaesar.adt\fP, and,
for external sorts, it can be manually defined by the user in the "\fB.t\fP"
file; forgetting to define this macro when appropriate is usually harmless
though slightly less efficient, as variables will be reset using a call
to \fBmemset()\fP rather than an assignment; however, the proper definition
of this macro for external sorts is required when using the \fB-external\fP
option of CAESAR. See item #493 in file "\fB$CADP/HISTORY\fP" for details.

.TP
\fBCAESAR_ADT_UNCANONICAL_\fP\fIN\fP
If defined, this macro indicates that the values of the C type \fIN\fP 
implementing some LOTOS sort \fIS\fP are not represented under a canonical 
form, meaning that two concrete C values stored in memory using two different 
bit strings may still denote the same abstract LOTOS value. This can 
occur if \fIN\fP is a pointer type (e.g., two pointers referring to two
different memory cells having the same contents), but in other cases as well
(e.g., a struct or union type with uninitialized padding bits between its
fields, or a struct or union type containing pointer fields, and so on
recursively). For non-external sorts, this macro is automatically defined 
by \fBcaesar.adt\fP, and, for external sorts, it must be manually defined 
by the user in the "\fB.t\fP" file; forgetting to define this macro when 
appropriate is harmful as it leads to incorrect comparison and hashing on
bit strings. For this reason, the values of non-canonical sorts should
never be stored in hash tables. See items #623 and #1494 in file 
"\fB$CADP/HISTORY\fP" for details.

.TP
\fBCAESAR_ADT_COLLISIONS_\fP\fIN\fP
.TP
\fBCAESAR_ADT_COLLISIONS\fP
These two macros can be used to reduce the memory size of the hash table
storing the values of the C type \fIN\fP that implements some LOTOS sort.
By default, this table has as many hash entries as its maximal number of
elements specified using the \fBCAESAR_ADT_HASH_\fP\fIN\fP macro,
meaning that the average length of collision lists is expected to be one
if the table is entirely filled. The number of hash entries can be reduced,
thus decreasing memory while potentially increasing access time. If the
former macro, or else the latter macro is defined in the "\fB.t\fP" file
as an integer value \fIn\fP >= 1, the number of hash entries will be the 
maximal number of elements divided by \fIn\fP, meaning that the average 
length of collision lists is expected to be \fIn\fP if the table is 
entirely filled. The latter macro applies to all types whose values are
stored in hash tables, but it is overriden by the former macro as far as
type \fIN\fP is concerned. See item #1250 in file "\fB$CADP/HISTORY\fP"
for details.

.TP
\fBCAESAR_ADT_CREATE_\fP\fIN\fP\fB()\fP
.TP
\fBCAESAR_ADT_DELETE_\fP\fIN\fP\fB()\fP
.TP
\fBCAESAR_ADT_SHOW_\fP\fIN\fP\fB(...)\fP
For each external LOTOS sort S implemented by a C type \fIN\fP, if the
user has specified (by setting the macro \fBCAESAR_ADT_CREATE_\fP\fIN\fP
to a value different from 0 and 1) that the values of type \fIN\fP are
canonical and stored in a hash table, the user has to implement this table 
manually and provide the corresponding implementation in the "\fB.t\fP" 
file; \fBcaesar.adt\fP cannot generate code for this table because the
implementation in C of the elements of this table is not known at the LOTOS
level; to implement this table, the user may reuse the \fBcaesar_table_1\fP
library of OPEN/CAESAR. Whatever which implementation is chosen for the 
table, the user must provide, in the "\fB.t\fP" file, the three above
symbols, which must be implemented as macro-definitions, not as functions.
The two former macros respectively allocate and deallocate the hash table; 
the latter macro prints the table contents to a file pointer passed as
a parameter. These macros are invoked by \fBCAESAR_ADT_INIT()\fP
and \fBCAESAR_ADT_TERM()\fP. Examples of such macros based upon 
the \fBcaesar_table_1\fP library of OPEN/CAESAR can be found by 
examining the definitions of \fBCAESAR_ADT_CREATE_ADT_STRING()\fP,
\fBCAESAR_ADT_DELETE_ADT_STRING()\fP, and \fBCAESAR_ADT_SHOW_ADT_STRING()\fP 
given in file "\fB$CADP/incl/X_STRING.h\fP". See item #1498 in 
file "\fB$CADP/HISTORY\fP" for details.

.SS VALUE PRINTING

The following symbols modify the way terms can be printed:

.TP
\fBCAESAR_ADT_INFIX\fP
If defined, this macro indicates that the values containing constructor
operations declared as infix in the LOTOS specification 
(i.e., "\fB_\fP\fIF\fP\fB_\fP \fB:\fP \fIS\fP, \fIS\fP \fB->\fP \fIS'\fP")
should be printed in the infix form "x \fIF\fP y" rather than the prefix
form "\fIF\fP (x, y)", the latter being the default. This macro is 
normally set by the options \fB-prefix\fP and \fB-infix\fP 
of \fBcaesar.adt\fP, but the user can also define this macro before
including the "\fB.h\fP" file generated by \fBcaesar.adt\fP. See items
#080 and #208 in file "\fB$CADP/HISTORY\fP" for details.

.TP
\fBCAESAR_ADT_PRINT_OPEN_\fP\fIN\fP
.TP
\fBCAESAR_ADT_PRINT_CLOSE_\fP\fIN\fP
These two macros determine how a constructor operation \fIF\fP implemented
by a C function named \fIN\fP and returning a result of some record (or even
singleton) sort is printed. By default, these macros are defined in the 
"\fB.h\fP" file generated by \fBcaesar.adt\fP unless the user provides
alternative definitions before including this file. For instance, values
of type \fIN\fP can be printed as "[x1, x2, ..., xn]" rather than 
"\fIF\fP (x1, x2, ..., xn)". See item #1561 in file "\fB$CADP/HISTORY\fP"
for details.

.TP
\fBCAESAR_ADT_FORMAT_\fP\fIN\fP
.TP
\fBCAESAR_ADT_FORMAT\fP
These two macros determine whether the hash table storing the values of 
the C type \fIN\fP that implements some LOTOS sort will be displayed in
case the table overflows (because it cannot contain as many values as
necessary) or when the \fBCAESAR_ADT_TERM()\fP function is executed. If none
of these two macros is defined before including the "\fB.h\fP" file generated
by \fBcaesar.adt\fP, the table will not be displayed. If the former macro, 
or else the latter macro is defined in the "\fB.t\fP" file as an integer 
value \fIn\fP, the table for type \fIN\fP will be displayed under 
format \fIn\fP, following the conventions of the \fBCAESAR_PRINT_TABLE_1()\fP
primitive of OPEN/CAESAR. The latter macro applies to all types whose values
are stored in hash tables, but it is overriden by the former macro as far as
type \fIN\fP is concerned. See item #1250 in file "\fB$CADP/HISTORY\fP"
for details.

.SS DYNAMIC MEMORY

The following symbols control dynamic memory allocation and reclaim:

.TP
\fBCAESAR_ADT_ALLOC(...)\fP
This macro allocates a memory cell to contain a value of a given type and
assigns the address of this cell to a given variable. If the allocation
fails, an error message is displayed and the execution is interrupted by
a \fBSIGTERM\fP signal. By default, this macro is defined in the "\fB.h\fP" 
file generated by \fBcaesar.adt\fP unless the user provides an alternative
definition before including this file.

.TP
\fBCAESAR_ADT_GARBAGE_COLLECTION\fP
The "\fB.h\fP" file generated by \fBcaesar.adt\fP checks whether a macro
named \fBCAESAR_ADT_GARBAGE_COLLECTION\fP is defined. If so, the memory
allocation primitive of the Boehm-Demers garbage collector will be used 
rather than the standard \fBmalloc()\fP primitive; this will require linking 
with the "\fB$CADP/gc/bin.*/libgc.a\fP" library. This macro
can be defined by the user when compiling the "\fB.h\fP" file generated 
by \fBcaesar.adt\fP, but it is automatically defined by \fBcaesar\fP when 
invoked with its "\fB-gc\fP" option. See item #653 in file
"\fB$CADP/HISTORY\fP" for details.

.SS ERROR HANDLING

The following symbols determine how erroneous situations are handled:

.TP
\fBADT_CHECK_NAT\fP
If defined before including the file "\fB$CADP/incl/X_NATURAL.h\fP" that
implements the natural numbers defined in the "\fBX_NATURAL.lib\fP" library,
this macro activates systematic checks for overflows and underflows,
which could otherwise remain undetected. See item #1584 in file
"\fB$CADP/HISTORY\fP" for details.

.TP
\fBADT_CHECK_INT\fP
If defined before including the file "\fB$CADP/incl/X_INTEGER.h\fP" that
implements the natural numbers defined in the "\fBX_INTEGER.lib\fP" library,
this macro activates systematic checks for overflows and underflows,
which could otherwise remain undetected. See item #1584 in file
"\fB$CADP/HISTORY\fP" for details.

.TP
\fBCAESAR_ADT_ERROR(...)\fP
This macro is invoked when a partially-defined non-constructor is called with
actual parameters whose values are not matched by any equation; an error
message is displayed and the execution is interrupted by a \fBSIGTERM\fP
signal. By default, this macro is defined in the "\fB.h\fP" file generated 
by \fBcaesar.adt\fP unless the user provides an alternative definition
before including this file.

.TP
\fBCAESAR_ADT_OVERFLOW_\fP\fIN\fP\fB(...)\fP
If defined before including the "\fB.h\fP" file generated by \fBcaesar.adt\fP,
this macro provides an "overflow" function to be invoked when the hash table 
storing the values of the C type \fIN\fP that implements some LOTOS sort is
full. If the user does not define this macro, \fBcaesar.adt\fP generates 
a standard overflow function automatically. See item #1250 in file
"\fB$CADP/HISTORY\fP" for details.

.SS FUNCTION TRACING

The following symbols enable functions to be traced at run time: 

.TP
\fBCAESAR_ADT_TRACE_\fP\fIN\fP
When invoked with its "\fB-trace\fP" option, \fBcaesar.adt\fP will generate,
for each LOTOS operation \fIF\fP implemented by a C function named \fIN\fP,
additional C code that is executed when entering and exiting \fIN\fP.
Compared to the usual function-tracing features offered by C debuggers,
this code can print the values of actual parameters and returned results
using the same notations as in the source LOTOS specification. The execution 
of this code can be enabled or disabled, for each LOTOS operation 
considered individually, using an integer variable named
\fBCAESAR_ADT_TRACE_\fP\fIN\fP, which is initialized to zero. Setting this 
variable to one (either at compile time by manually patching the "\fB.h\fP" 
file generated by \fBcaesar.adt\fP, or at run time by assigning the variable 
directly from a debugger) allows the code to be executed when function \fIN\fP 
is called and returns. See item #180 in file "\fB$CADP/HISTORY\fP" for details.

.TP
\fBCAESAR_ADT_ARGUMENT_TRACE(...)\fP
This macro prints the actual parameters passed to functions under trace.
By default, it is defined in the "\fB.h\fP" file generated by \fBcaesar.adt\fP
unless the user provides an alternative definition before including this
file. See items #180 and #181 in file "\fB$CADP/HISTORY\fP" for details.

.TP
\fBCAESAR_ADT_ENTRY_TRACE(...)\fP
This macro prints the name and depth level of functions under trace 
when they are entered. By default, it is defined in the "\fB.h\fP" file 
generated by \fBcaesar.adt\fP unless the user provides an alternative 
definition before including this file.
See items #180 and #181 in file "\fB$CADP/HISTORY\fP" for details.

.TP
\fBCAESAR_ADT_EXIT_TRACE(...)\fP
This macro prints the name and depth level of functions under trace 
when they are exited. By default, it is defined in the "\fB.h\fP" file 
generated by \fBcaesar.adt\fP unless the user provides an alternative
definition before including this file.
See items #180 and #181 in file "\fB$CADP/HISTORY\fP" for details.

.TP
\fBCAESAR_ADT_RESULT_TRACE(...)\fP
This macro prints the results returned by functions under trace.
By default, it is defined in the "\fB.h\fP" file generated by \fBcaesar.adt\fP
unless the user provides an alternative definition before including this
file. See items #180 and #181 in file "\fB$CADP/HISTORY\fP" for details.

.SS DEPRECATED SYMBOLS

The following symbols are no longer supported:

.TP
\fBCAESAR_ADT_NORMAL_FORM\fP
See items #059, #082, and #235 in file "\fB$CADP/HISTORY\fP" for details.

.TP
\fBCAESAR_ADT_POINTER_\fP\fIN\fP
See items #235 and #623 in file "\fB$CADP/HISTORY\fP" for details.

.TP
\fBCAESAR_INFIX_FORM_PRINTING\fP
See items #080 and #208 in file "\fB$CADP/HISTORY\fP" for details.

.SH BIBLIOGRAPHY

[BB88] Tommaso Bolognesi and Ed Brinksma.
Introduction to the ISO Specification Language LOTOS.
Computer Networks and ISDN Systems, vol. 14, num. 1, pages 25-59,
January 1988.
.P
[Gar89b] Hubert Garavel.
Compilation et verification de programmes LOTOS.
These de doctorat, Universite Joseph Fourier, Grenoble, November 1989.
Available from http://cadp.inria.fr/publications/Garavel-89-b.html
.P
[Gar89c] Hubert Garavel.
Compilation of LOTOS Abstract Data Types.
In Son T. Vuong, editor, Proceedings of the 2nd International Conference
on Formal Description Techniques (FORTE'89), Vancouver, Canada. North Holland,
pages 147-162, December 1989. Available from
http://cadp.inria.fr/publications/Garavel-89-c.html
.P
[Gar13] Hubert Garavel et al.
25 Years of Compositionality Issues in CADP: An Overview.
Lecture at the Workshop on the 25 Years of Combining Compositionality and 
Concurrency (WS25CCC), Koenigswinter, Germany, August 6-9, 2013. Available 
from ftp://ftp.inrialpes.fr/pub/vasy/presentations/Garavel-25CCC-13.pdf
.P
[GS95a] Hubert Garavel and Mihaela Sighireanu.
Defect Report Concerning ISO International Standard 8807 and Proposal for a
Correct Flatenning of LOTOS Parametrized Types. Rapport SPECTRE, 95-11, 
VERIMAG, Grenoble, July 1995
http://cadp.inria.fr/publications/Garavel-Sighireanu-95-a.html
.P
[GT93] Hubert Garavel and Philippe Turlier.
CAESAR.ADT : un compilateur pour les types abstraits algebriques du langage 
LOTOS. In Rachida Dssouli and Gregor v. Bochmann, editors, Actes du Colloque
Francophone pour l'Ingenierie des Protocoles (CFIP'93), Montreal, Canada,
1993. Available from http://cadp.inria.fr/publications/Garavel-Turlier-93.html
.P
[ISO89] ISO/IEC International Standard 8807:1989.
LOTOS - A Formal Description Technique Based on the Temporal Ordering of
Observational Behaviour.
International Organization for Standardization, Information Processing
Systems, Open Systems Interconnection, Geneva, September 1989.

.SH SEE ALSO
.BR caesar (LOCAL),
.BR caesar.adt (LOCAL),
.BR caesar.indent (LOCAL),
.BR lotos.open (LOCAL),
.BR fsp2lotos (LOCAL),
.BR lnt2lotos (LOCAL)
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
Please report bugs to cadp@inria.fr


