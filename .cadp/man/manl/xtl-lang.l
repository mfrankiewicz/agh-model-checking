'\" t
.\" @(#)xtl-lang.l - VASY and CONVECS teams - 2019/05/29
.TH XTL-LANG LOCAL "2019/05/29" "(C) INRIA" "CADP MANUAL PAGES"
.fp 4 CB
.lg 0
.SH NAME
xtl \- language for value-based temporal logic formulas

.SH DESCRIPTION

XTL (eXecutable Temporal Language) is a functional programming language
interpreted over LTSs (Labelled Transition Systems) encoded in the
BCG (Binary Coded Graph) file format.

XTL can typically be used for implementing temporal logic operators,
by describing their fixed point semantics as iterative or recursive
computations over sets of states.

More generally, XTL enables one to perform any computation on a BCG
graph: for instance, it can compute the branching factor of a graph,
print its list of labels, etc.

XTL programs are compiled and evaluated on BCG graphs by using the
.BR xtl (LOCAL)
model checker.

.SH L\&T\&S MODEL

An XTL program is evaluated over an LTS model generated from a source
program to be verified. This LTS, encoded in a BCG file, contains the
following elements:

.IP -
a set of \fIstates\fP of the source program. A state is represented as
a tuple containing the values of all the variables of the program (the
so-called "state vector").

.IP -
a set of \fIlabels\fP performed by the program. An label is represented 
as a list of typed values. In BCG files generated from LOTOS programs, 
the labels have the form \fIG\fP \fIv1\fP ... \fIvm\fP (with m >= 0),
where \fIG\fP is a gate name.

.IP -
a \fItransition relation\fP between the states of the program. A transition,
represented as a triple (\fIs1\fP, \fIa\fP, \fIs2\fP), means that the
program can move from state \fIs1\fP to state \fIs2\fP by performing
a transition labelled with \fIa\fP.

.IP -
the \fIinitial state\fP of the program.

.SH SYNTAX AND SEMANTICS OF X\&T\&L

The syntax of each XTL construct is defined by a BNF grammar and
the semantics is described informally. Terminal
symbols are enclosed in double quotes. Optional elements are enclosed
in square brackets. Suspension points are used to denote zero or more
repetitions of an element.
.ne 23v
The meaning of grammar symbols is given in the
table below. The axiom of the grammar is the non-terminal symbol \fIPG\fP.

.cs R 23
.cs I 23
.nf
         +--------+-------------------------------+
         | Symbol |          Description          |
         +========+===============================+
         |   \fIK\fP    | constant                      |
         |   \fIx\fP    | variable                      |
         |   \fIT\fP    | simple type                   |
         |   \fIG\fP    | gate                          |
         |   \fIF\fP    | function                      |
         |   \fIM\fP    | macro                         |
         |   \fIP\fP    | macro parameter               |
         |   \fIE\fP    | expression                    |
         |   \fIO\fP    | offer                         |
         |   \fID\fP    | variable declaration          |
         |   \fIRT\fP   | result type                   |
         |   \fIOP\fP   | operator                      |
         |   \fIFD\fP   | function definition           |
         |   \fIMD\fP   | macro definition              |
         |   \fILI\fP   | library inclusion             |
         |   \fIETD\fP  | external type declaration     |
         |   \fIEFD\fP  | external function declaration |
         |   \fIEID\fP  | external include directive    |
         |   \fIELD\fP  | external compile directive    |
         |   \fIPG\fP   | program                       |
         +--------+-------------------------------+
.fi
.cs R
.cs I

.P
.SS LEXICAL ELEMENTS

The lexical units of XTL are: \fIkeywords\fP, \fIidentifiers\fP and
\fIseparators\fP. The keywords, listed below, must be written in
lower-case letters.
.P
.TS
center;
L L L L.
\fBany\fP	\fBend_def\fP	\fBexists\fP	\fBof\fP
\fBapply\fP	\fBend_exists\fP	\fBfor\fP	\fBon\fP
\fBassert\fP	\fBend_for\fP	\fBforall\fP	\fBthen\fP
\fBdef\fP	\fBend_forall\fP	\fBfrom\fP	\fBto\fP
\fBelse\fP	\fBend_if\fP	\fBif\fP	\fBuse\fP
\fBelse_if\fP	\fBend_let\fP	\fBin\fP	\fBwhere\fP
\fBend_assert\fP	\fBend_use\fP	\fBlet\fP
.TE
.P
The identifiers are grouped into two classes:

.IP -
\fIexternal identifiers\fP denote the objects defined in the source
program to be verified (these objects are contained in the BCG file).
These identifiers may be written like the internal ones, as long as
there is no clash between them and the normal identifiers or the XTL
keywords. In the latter case, external identifiers must be preceded
by a dollar character (e.g., \fB$let\fP) to avoid clashes.

.IP -
\fIinternal identifiers\fP denote the objects defined in the XTL program
(or predefined in the XTL language). These identifiers may be either
\fInormal\fP, i.e., built from letters, digits and underscores (beginning
with a letter or an underscore), or \fIspecial\fP, i.e., built from the
characters #, %, &, *, +, -, \., /, >, =, <, @, \e, ^, and ~. In normal
identifiers, no difference is made between lower- and uppercase letters.
The special identifiers are useful for mathematical and/or logical notations
(e.g., '+', '/\e', etc.).

.LP
The separators are sequences containing space, tab, and newline characters,
as well as \fIcomments\fP, enclosed between \fB(*\fP and \fB*)\fP. 

.SS INTERNAL AND EXTERNAL TYPES

XTL is a strongly-typed language: every object used in an XTL program
must have a unique type, which is statically determined. XTL does not
provide a mechanism for type definition, although anonymous tuple types
(see below) can be implicitly created. The types allowed in XTL fall
into the following classes:

.IP -
\fIexternal types\fP are imported from the source program to be verified.
These types are contained in the type area of the BCG file and can be
referenced in XTL programs using external identifiers. Other externally
defined types can be included in the XTL programs by means of special
directives (see DIRECTIVES below).
.IP -
\fIinternal types\fP are either predefined in the language, or defined
by the user. 

.SS INTERNAL AND EXTERNAL FUNCTIONS

The functions (also called \fIoperators\fP) that can be used in an XTL
program fall into the following classes:

.IP -
\fIexternal functions\fP are defined in the source program to be verified.
They are contained in the function area of the BCG file and can be
referenced in XTL programs using external identifiers.

.IP -
\fIinternal functions\fP are either predefined in XTL (a list of the
predefined functions has been given in the above paragraphs), or
user-defined (see FUNCTIONS below for the syntax of function definitions).

.P
In XTL, functions can be \fIoverloaded\fP, i.e., have the same identifier
but different types for their arguments and/or result. The XTL compiler
resolves overloading statically (i.e., at compile-time) or issues an
error message if the context does not permit to resolve overloading
(in such case, the "\fBof\fP" operator can be used to supply typing
information).

.P
In XTL, a function \fIF\fP can be either \fIprefixed\fP, i.e., its calls are
written "\fIF\fP (\fIE1\fP, ..., \fIEn\fP)", or \fIinfixed\fP, i.e., \fIF\fP
has two arguments and its calls are written "\fIE1\fP \fIF\fP \fIE2\fP". 

.P
Most predefined functions are infixed, except "\fBextract\fP" and 
"\fBreplace\fP". For user-defined functions, the prefix or infix
nature is specified when the function is declared.
.P
Also, unary minus operators must be written in functional notation, 
i.e., \fB-(1)\fP instead of \fB-1\fP, \fB-(X)\fP instead of \fB-X\fP,
etc.

.SS BOOLEAN TYPE AND FUNCTIONS

The Boolean type is named \fBboolean\fP.
The Boolean constants \fBtrue\fP and \fBfalse\fP are defined as 0-ary 
functions.
The table below gives the predefined functions for this type:

.cs R 23
.ne 9v
.nf
+----------------------------------------+--------------------------+
|                Operator                |         Meaning          |
+========================================+==========================+
| true, false : -> boolean               | boolean constants        |
| not : boolean -> boolean               | negation                 |
| or, and, implies,                      | connectors and           |
|   =, <> : boolean, boolean -> boolean  |   relational operators   |
| replace : boolean, boolean -> boolean  | replacement operator     |
+----------------------------------------+--------------------------+
.fi
.cs R

The "\fBreplace\fP" operator (which is overloaded for all types) takes 
two arguments of the same type and returns the second one. It is useful 
for use within the "\fBfor\fP" expressions (see EXPRESSIONS below).

.SS INTEGER TYPE AND FUNCTIONS

The signed integer type is named \fBinteger\fP.
Integer constants are noted with a C-like syntax and should be
preceded of a sign "\fB+\fP" or "\fB-\fP", e.g., \fB-123\fP,
\fB+123\fP, \fB+0\fP, etc.
The table below gives the predefined functions for this type:

.cs R 23
.ne 14v
.nf
+----------------------------------------+--------------------------+
|                Operator                |         Meaning          |
+========================================+==========================+
| -, +    : integer, integer -> integer  | binary minus, plus       |
| -       : integer -> integer           | unary minus              |
| *, div  : integer, integer -> integer  | multiplication, division |
| mod     : integer, integer -> integer  | modulo                   |
| **      : integer, integer -> integer  | power                    |
| integer : real -> integer              | real to integer          |
| integer : character -> integer         | character to integer     |
| <, <=, >, >=, =, <> :                  | relational operators     |
|     integer, integer -> boolean        |                          |
| replace : integer, integer -> integer  | replacement operator     |
+----------------------------------------+--------------------------+
.fi
.cs R

.SS NATURAL TYPE AND FUNCTIONS

The unsigned integer type is named \fBnatural\fP.
Natural constants are noted with a C-like syntax and should never be
preceded of a sign, e.g., \fB123\fP, \fB0\fP, etc.
The table below gives the predefined functions for this type:

.cs R 23
.ne 13v
.nf
+----------------------------------------+--------------------------+
|                Operator                |         Meaning          |
+========================================+==========================+
| -, +    : natural, natural -> natural  | binary minus, plus       |
| *, div  : natural, natural -> natural  | multiplication, division |
| mod     : natural, natural -> natural  | modulo                   |
| **      : natural, natural -> natural  | power                    |
| natural : real -> natural              | real to integer          |
| natural : character -> natural         | character to natural     |
| <, <=, >, >=, =, <> :                  | relational operators     |
|     natural, natural -> boolean        |                          |
| replace : natural, natural -> natural  | replacement operator     |
+----------------------------------------+--------------------------+
.fi
.cs R

.P
By default, an unsigned number \fB123\fP denotes either a value of type
\fBnatural\fP or a value of type \fBinteger\fP. Such overloading can
be resolved explicitly by the user (using an "\fBof\fP" operator) or
implicitly by the context (for instance, in \fB(X + 123)\fP, the type
of \fBX\fP will determine the type of \fB123\fP). If the context does
not permit to resolve overloading, then the constant will ultimately be
given the type Natural. To summarize:
.br
- \fB+123\fP has the \fBinteger\fP type.
.br
- \fB-123\fP has the \fBinteger\fP type.
.br
- \fB123 of integer\fP has the \fBinteger\fP type.
.br
- \fB123 of natural\fP has the \fBnatural\fP type.
.br
- \fB123\fP has either the \fBnatural\fP or \fBinteger\fP type (with a
final priority for \fBnatural\fP).

.SS REAL TYPE AND FUNCTIONS

The floating-point number type is named \fBreal\fP.
Real constants are noted with a C-like syntax,
e.g., \fB3.1416\fP, \fB-9.98E-6\fP, etc.
The table below gives the predefined functions for this type:

.cs R 23
.nf
+----------------------------------------+--------------------------+
|                Operator                |         Meaning          |
+========================================+==========================+
| -, + : real, real -> real              | binary minus, plus       |
| -    : real -> real                    | unary minus              |
| *, / : real, real -> real              | multiplication, division |
| **   : real, real -> real              | power                    |
| real : integer -> real                 | integer to real          |
| <, <=, >, >=, =, <> :                  | relational operators     |
|     real, real -> boolean              |                          |
| replace : real, real -> real           | replacement operator     |
+----------------------------------------+--------------------------+
.fi
.cs R

.SS CHARACTER TYPE AND FUNCTIONS

The character type is named \fBcharacter\fP.
Character constants are noted with a C-like syntax, 
e.g., \fB'a'\fP, \fB'\\n'\fP, \fB'\\012'\fP, \fB'\\x1A'\fP, etc.
The table below gives the predefined functions for this type:

.cs R 23
.nf
+----------------------------------------+--------------------------+
|                Operator                |         Meaning          |
+========================================+==========================+
| -, + : character, integer -> character | subtract, add integer    |
| character : integer -> character       | integer to character     |
| <, <=, >, >=, =, <> :                  | relational operators     |
|     character, character -> boolean    |                          |
| replace :                              |                          |
|     character, character -> character  | replacement operator     |
+----------------------------------------+--------------------------+
.fi
.cs R

.SS STRING TYPE AND FUNCTIONS

The character-string type is named \fBstring\fP.
String constants are noted with a C-like syntax,
e.g., \fB"abc"\fP, \fB"123"\fP, \fB"Hello\\n"\fP, etc.
The table below gives the predefined functions for this type:

.cs R 23
.ne 9v
.nf
+----------------------------------------+--------------------------+
|                Operator                |         Meaning          |
+========================================+==========================+
| null    : -> string                    | empty string             |
| length  : string -> integer            | string length            |
| extract : string, integer -> character | character extraction     |
| =, <>   : string, string -> boolean    | relational operators     |
| replace : string, string -> string     | replacement operator     |
+----------------------------------------+--------------------------+
.fi
.cs R

.SS RAW TYPE AND FUNCTIONS

The \fBraw\fP type represents a byte string that denotes a value of 
unknown type, i.e., whose type is not one of the other predefined types.
Raw constants are noted with a C-like syntax but using backquotes
rather than double quotes, e.g., \fB`foo`\fP, \fB`CONS (0, NIL)`\fP,
or \fB`{0, 1}`\fP, etc.
The table below gives the predefined functions for this type:

.cs R 23
.nf
+----------------------------------------+--------------------------+
|                Operator                |         Meaning          |
+========================================+==========================+
| null    : -> raw                       | empty raw data           |
| length  : raw -> integer               | raw data length          |
| extract : raw, integer -> character    | character extraction     |
| =, <>   : raw, raw -> boolean          | relational operators     |
| replace : raw, raw -> raw              | replacement operator     |
+----------------------------------------+--------------------------+
.fi
.cs R

.P
By default, the string notation \fB"..."\fP denotes either a value
of type \fBstring\fP or a value of type \fBraw\fP. Such overloading can
be resolved explicitly by the user (using an "\fBof\fP" operator) or 
implicitly by the context (for instance, in \fB(X = "foo")\fP, the type
of \fBX\fP will determine the type of \fB"abc"\fP). If the context does
not permit to resolve overloading, then the constant will ultimately be
given the type String. To summarize:
.br
- \fB`foo`\fP has the \fBraw\fP type.
.br
- \fB"foo" of string\fP has the \fBstring\fP type.
.br
- \fB"foo" of raw\fP has the \fBraw\fP type.
.br
- \fB"foo"\fP has either the \fBstring\fP or \fBraw\fP type (with a
final priority for \fBstring\fP).

.SS META-TYPES AND FUNCTIONS

The types \fBstate\fP, \fBlabel\fP, \fBedge\fP, \fBstateset\fP,
\fBlabelset\fP, and \fBedgeset\fP (also called
\fImeta-types\fP because they refer to the LTS model rather than to
the objects defined in the source program to be verified) denote the
states, labels, edges, sets of states, sets of labels, and sets of
edges of the LTS, respectively.

.P
The table below gives the predefined
operators over these types ("\fBset\fP" denoting either
\fBstateset\fP, \fBlabelset\fP, or \fBedgeset\fP). These operators
allow to explore (forward and/or backward) the transition relation of
the LTS, to combine sets of states, labels and edges, and also to
obtain information about the LTS.

.cs R 23
.nf
+-----------------------------------+-------------------------+
|             Operator              |         Meaning         |
+===================================+=========================+
| init   : -> state                 | initial state           |
| succ   : state -> stateset        | successor states        |
| pred   : state -> stateset        | predecessor states      |
| out    : state -> edgeset         | successor transitions   |
| in     : state -> edgeset         | predecessor transitions |
| =, <>  : state, state -> boolean  | comparison operators    |
| replace : state, state -> state   | replacement operator    |
+-----------------------------------+-------------------------+
| visible : label -> boolean        | visibility test         |
| string  : label -> string         | label to string         |
| =, <>   : label, label -> boolean | comparison operators    |
| replace : label, label -> label   | replacement operator    |
+-----------------------------------+-------------------------+
| source : edge -> state            | transition source state |
| target : edge -> state            | transition target state |
| label  : edge -> label            | transition label        |
| succ   : edge -> edgeset          | successor transitions   |
| pred   : edge -> edgeset          | predecessor transitions |
| =, <>  : edge, edge -> boolean    | comparison operators    |
| replace : edge, edge -> edge      | replacement operator    |
.ne 18v
+-----------------------------------+-------------------------+
| empty, false : -> set             | empty set               |
| full, true   : -> set             | full set                |
| comp, not  : set -> set           | complementation         |
| union, or  : set, set -> set      | union                   |
| inter, and : set, set -> set      | intersection            |
| implies    : set, set -> set      | implication             |
| iff        : set, set -> set      | equivalence             |
| diff       : set, set -> set      | difference              |
| includes   : set, set -> boolean  | inclusion test          |
| insert, remove : set, elem -> set | insertion, removal      |
| among : elem, set -> boolean      | membership              |
| card  : set -> number             | cardinal                |
| =, <> : set, set -> boolean       | comparison operators    |
| replace : set, set -> set         | replacement operator    |
+-----------------------------------+-------------------------+
.fi
.cs R

For convenience, some of the operators above are overloaded (see
FUNCTIONS below). Also, some of the set operators have synonyms
(e.g., \fBunion\fP has the synonym \fBor\fP) allowing a more
intuitive writing of boolean properties. 

.SS NUMBER TYPE AND FUNCTIONS

The BCG file format associates a unique number to every state,
label, and edge of the LTS. The XTL language provides the \fBnumber\fP type
for the manipulation of state, label, and edge numbers. The table below gives
the predefined operators of type \fBnumber\fP.

.cs R 23
.nf
+------------------------------------+--------------------------+
|             Operator               |       Meaning            |
+====================================+==========================+
| number_of_states : -> number       | number of states         |
| number_of_labels : -> number       | number of labels         |
| number_of_edges  : -> number       | number of edges          |
| number : state -> number           | state number             |
| number : label -> number           | label number             |
| number : edge -> number            | edge number              |
+------------------------------------+--------------------------+
| -, +   : number, number -> number  | binary minus, plus       |
| *, div : number, number -> number  | multiplication, division |
| mod    : number, number -> number  | modulo                   |
| **     : number, number -> number  | power                    |
| number : character -> number       | conversion from/to       |
| character : number -> character    |   character              |
| number : integer -> number         | conversion from/to       |
| integer : number -> integer        |   integer                |
| number : real -> number            | conversion from/to       |
| real : number -> real              |   real                   |
| <, <=, >, >=, =, <> :              | relational operators     |
|     number, number -> boolean      |                          |
| replace : number, number -> number | replacement operator     |
+------------------------------------+--------------------------+
.fi
.cs R

All arithmetic operators (except unary minus) and relational operators
of type \fBinteger\fP are also available for type \fBnumber\fP.
Moreover, the values belonging to these two types can be freely mixed
within arithmetic and relational expressions. The main difference between
these two types concerns the manipulation of large numbers: the maximum
value of type \fBinteger\fP is
\fB2^31-1\fP = \fB2,147,483,647\fP on 32-bit machines and
\fB2^63-1\fP = \fB9,223,372,036,854,775,807\fP on 64-bit machines,
whereas the maximum value of type \fBnumber\fP is
\fB2^32-1\fP = \fB4,294,967,295\fP on 32-bit machines and
\fB2^64-1\fP = \fB18,446,744,073,709,551,615\fP on 64-bit machines.
Therefore, for large LTSs, any information concerning the LTS structure
(e.g., cardinality of state/edge/label subsets, depth/breadth of the LTS,
number of breadth-first levels, etc.) should be manipulated using values of
type \fBnumber\fP instead of type \fBinteger\fP in order to avoid overflows.
.sp
Conversion operators between the \fBnumber\fP type and the types
\fBcharacter\fP, \fBinteger\fP, and \fBreal\fP are also provided. Constants
of type \fBnumber\fP are written in decimal notation preceded by a \fB'#'\fP
character (e.g., \fB#4294967295\fP). An alternative way of representing
constants of type \fBnumber\fP that fit in the range of type \fBinteger\fP is
by means of the conversion operator from \fBinteger\fP to \fBnumber\fP
(e.g., the values \fBnumber(2147483647)\fP and \fB#2147483647\fP are
the same).

.SS ACTION TYPE AND FUNCTIONS

The XTL language has an action type associated to
XTL expressions that return no value but perform side effects.
These are used to print data values on the POSIX standard output
stream (\fBstdout\fP). The table below gives the predefined operators
of type \fBaction\fP (T may be any type).
.sp
The \fBprint\fP and \fBprintf\fP operators behave differently on strings:
\fBprint\fP prints the string enclosed between double quotes and 
converts unprintable characters and escape sequences to three-digit 
octal notation, whereas \fBprintf\fP does not add double quotes and
interprets execute sequences. For instance, \fBprint ("Hello!\\n")\fP
displays \fB"Hello!\\012"\fP, whereas \fBprintf ("Hello!\\n")\fP
displays \fBHello!\fP followed by a line-feed. So, \fBprint\fP
should be used to display string values (e.g., label offers of
the string type), whereas \fBprintf\fP should be used to display
messages.

.cs R 23
.nf
+--------------------------------+---------------------------+
|            Operator            |        Meaning            |
+================================+===========================+
| nop : -> action                | inaction                  |
| fby : action, action -> action | sequential composition    |
| print : T -> action            | value printing            |
| printf : string -> action      | string formatted printing |
+--------------------------------+---------------------------+
.fi
.cs R

.SS ANONYMOUS TUPLE TYPES

These types denote structures containing
fields of different types. The fields can be of any type (including
anonymous tuples, which enables nesting of tuples).  These types are
noted "(" \fIT0\fP"," ..."," \fITn\fP ")" and are essentially used in
situations when several values must be computed and returned
simultaneously. The equivalence of tuple types is defined
structurally.  The tuple values are noted "(" \fIE0\fP"," ..."," \fIEn\fP
")" (see EXPRESSIONS below).

.SS EXPRESSIONS

The expressions allowed in XTL use the following auxiliary constructs.

.TP
.ne 10v
Offers
An \fIoffer\fP is a construct allowing to match a value contained in a
transition label. The offers have the following syntax:

.cs R 23
.cs I 23
.nf
\fIO\fP       ::=  "?" \fIx\fP ":" \fIT\fP
.sp
         |   "!" \fIE\fP
.sp
         |   "_"
.fi
.cs R
.cs I

An offer "?" \fIx\fP ":" \fIT\fP matches a value \fIv\fP iff \fIv\fP has
the type \fIT\fP; in case of matching, the variable \fIx\fP is also assigned
the value \fIv\fP. An offer "!" \fIE\fP matches a value \fIv\fP iff the
expression \fIE\fP evaluates to \fIv\fP. An offer "_" (wildcard) matches
a value \fIv\fP of any type.
.P
.TP
.ne 7v
Result types
The result types denote either simple types, or anonymous tuple types.
They have the following syntax:

.cs R 23
.cs I 23
.nf
\fIRT\fP      ::= \fIT\fP
.sp
         |  "(" \fIRT0\fP"," ..."," \fIRTn\fP ")"
.fi
.cs R
.cs I

These types may occur in variable declarations (see the next paragraph)
as well as in function declarations (see FUNCTIONS below).
.P
.TP
.ne 6v
Variable declarations
The variable declarations have the following syntax:

.cs R 23
.cs I 23
.nf
\fID\fP ::= \fIx\fP ":" \fIRT\fP
.sp
   |  "any" \fIRT\fP
.sp
   |  "(" \fID0\fP"," ..."," \fIDn\fP ")"
.fi
.cs R
.cs I

A declaration \fIx\fP ":" \fIRT\fP defines the variable \fIx\fP of type
\fIRT\fP. A declaration "any" \fIRT\fP, which is meaningful only inside a
declaration of anonymous tuple type, defines a placeholder of type \fIRT\fP
standing for a field of the tuple. Declarations of the form "any" \fIRT\fP
can occur only in the "let" expressions (see below).
A declaration "(" \fID0\fP"," ..."," \fIDn\fP ")" defines a tuple
whose fields are denoted by the variables and placeholders
occurring inside \fID0\fP, ..., \fIDn\fP.
.P
.TP
.ne 8v
Operators
The operators occur in the "\fBfor\fP" expressions (see below); they denote
calls of binary functions on two arguments. They have the following syntax:

.cs R 23
.cs I 23
.nf
\fIOP\fP        ::= \fIF\fP
.sp
           |  "(" \fIOP0\fP"," ..."," \fIOPn\fP ")"
.fi
.cs R
.cs I

An \fIF\fP operator denotes a call of the binary function \fIF\fP.
An "(" \fIOP0\fP"," ..."," \fIOPn\fP ")" operator denotes a call of
a binary function on two arguments of tuple type; the result is a
tuple whose fields are the results of the calls of \fIOP0\fP, ...,
\fIOPn\fP on the corresponding fields of the arguments. There is a
static semantics constraint on the operators \fIOP\fP: their left
arguments must have the same types as their results.
.P
.ne 55
The syntax of expressions is given by the following grammar:
.P
.cs R 23
.cs I 23
.ne 28v
.nf
.ne 17v
\fIE\fP ::=  \fIK\fP
 
   |   \fIF\fP "(" \fIE0\fP"," ..."," \fIEn\fP ")"
 
   |   \fIE0\fP "of" \fIRT\fP
 
   |   \fIE0\fP "->" "[" \fPO0\fP ... \fIOn\fP [ "..." ] [ "where" \fIE1\fP ] "]"
 
   |   "{" \fIE0\fP"," ..."," \fIEn\fP "}"
 
   |   "(" \fIE0\fP"," ..."," \fIEn\fP ")"
 
   |   "let" \fID0\fP "=" \fIE0\fP"," ..."," \fIDn\fP "=" \fIEn\fP "in"
           \fIEn+1\fP
       "end_let"
 
.ne 20v
   |   "if" \fIE0\fP "then" \fIE'0\fP
           "else_if" \fIE1\fP "then" \fIE'1\fP
           ...
           "else_if" \fIEn\fP "then" \fIE'n\fP
           "else" \fIE'n+1\fP
       "end_if"
 
   |   "assert" \fIE0\fP"," ..."," \fIEn\fP "in"
           \fIEn+1\fP
       "end_assert"
 
   |   "use" \fIx0\fP"," ..."," \fIxn\fP "in"
           \fIE\fP
       "end_use"
 
   |   "for" [ \fIx0\fP ":" \fIT0\fP [ "among" \fIE0\fP ]"," ...","
               \fIxn\fP ":" \fITn\fP [ "among" \fIEn\fP ] ]
           [ "in" \fID\fP ]
           [ "while" \fIE'1\fP ]
           [ "where" \fIE'2\fP ]
           "apply" \fIOP\fP
           "from" \fIE'3\fP
           "to" \fIE'4\fP
       "end_for"
 
.ne 18v
   |   "forall" \fIx0\fP ":" \fIT0\fP [ "among" \fIE0\fP ]"," ...","
                \fIxn\fP ":" \fITn\fP [ "among" \fIEn\fP ]
       "in"
           \fIEn+1\fP
       "end_forall"
 
   |   "exists" \fIx0\fP ":" \fIT0\fP [ "among" \fIE0\fP ]"," ...","
                \fIxn\fP ":" \fITn\fP [ "among" \fIEn\fP ]
       "in"
           \fIEn+1\fP
       "end_exists"
 
   |   "<|" \fIOP\fP "on" \fIx0\fP ":" \fIT0\fP [ "among" \fIE0\fP ]"," ...","
                    \fIxn\fP ":" \fITn\fP [ "among" \fIEn\fP ]
            [ "where" \fIE'\fP ]
       "|>" \fIEn+1\fP
 
   |   "{" \fIx\fP ":" \fIT\fP [ "among" \fIE0\fP ] "where" \fIE1\fP "}"
.fi
.cs R
.cs I

The semantics of expressions is described informally below.

.nf
\fIK\fP
.fi
.IP
is a literal constant of a predefined type (see TYPES, FUNCTIONS AND
CONSTANTS above).
.P
.cs R 23
.cs I 23
.nf
\fIF\fP "(" \fIE0\fP"," ..."," \fIEn\fP ")"
.fi
.cs R
.cs I
.IP
denotes a call of the function \fIF\fP on the arguments \fIE0\fP, ...,
\fIEn\fP. The arguments must be compatible (in number and types) with
the formal parameters given in the definition of \fIF\fP (see FUNCTIONS
below).
.P
.cs R 23
.cs I 23
.nf
\fIE0\fP "of" \fIRT\fP
.fi
.cs R
.cs I
.IP
specifies that expression \fIE0\fP has type \fIRT\fP. This mechanism
allows to solve ambiguities that may be caused by function overloading
(see FUNCTIONS below). 
.P
.cs R 23
.cs I 23
.nf
\fIE0\fP "->" "[" \fIO0\fP ... \fIOn\fP [ "..." ] [ "where" \fIE1\fP ] "]"
.fi
.cs R
.cs I
.IP
is an expression of type \fBboolean\fP, called matching expression.
\fIE0\fP must be of type \fBlabel\fP or \fBedge\fP. The construct
between "\fB[\fP" and "\fB]\fP" is called an label pattern: it allows
to match the content of the label denoted by \fIE0\fP (if \fIE0\fP is
of type \fBlabel\fP) or by \fBlabel\fP (\fIE0\fP) (if \fIE0\fP is of
type \fBedge\fP), possibly extracting the values of its different
fields. The optional construct "..." matches a sequence of zero or
more values of any type. 
.sp
For convenience, in the verification of LOTOS programs, the first
offer \fIO0\fP (intended to match a gate) can be simply written
\fIG\fP (i.e., without the "\fB!\fP" sign).
.sp
The variables contained in \fIO0\fP, ..., \fIOn\fP (if any) are visible
in the optional expression \fIE1\fP, which must be of type \fBboolean\fP.
.sp
The XTL compiler examines the labels present in the BCG graph to
check if there exist labels that correspond, in the number of fields
and types of their fields, to the list of offers \fIO0\fP, ..., \fIOn\fP.
If no such label is found, then the compiler issues a warning message
(this is a form of \fIvacuity checking\fP).
.sp
The compiler also uses the types of field labels to resolve overloading
ambiguities (if any) in offers. For instance, the offer \fB1\fP in the
label pattern "\fBG !1\fP" will be considered of \fBinteger\fP if only
integer values are passed on gate \fBG\fP in the BCG graph on which the
XTL program is evaluated.
.sp
A matching expression matches a label \fIG\fP \fIv1\fP ... \fIvm\fP iff:
m = n if "..." is absent, or m >= n otherwise; \fIO0\fP matches
\fIG\fP; \fIO1\fP, ..., \fIOn\fP match \fIv1\fP, ..., \fIvn\fP;
\fIE1\fP, if present, evaluates to \fBtrue\fP in the context of the
variables assigned in the offers. A matching expression evaluates to
\fBtrue\fP in case of successful matching of a label (in this case,
all the variables contained in the offers have been initialized) and
to \fBfalse\fP otherwise.
.P
.cs R 23
.cs I 23
.nf
"{" \fIE0\fP"," ..."," \fIEn\fP "}"
.fi
.cs R
.cs I
.IP
denotes a value of type set defined explicitly (i.e., by enumerating
all its elements). The expressions \fIE0\fP, ..., \fIEn\fP must all be
of type \fBstateset\fP, \fBlabelset\fP, or \fBedgeset\fP.
.P
.cs R 23
.cs I 23
.nf
"(" \fIE0\fP"," ..."," \fIEn\fP ")"
.fi
.cs R
.cs I
.IP
denotes a value of type tuple, containing n fields whose values are given by
\fIE0\fP, ..., \fIEn\fP.
.P
.cs R 23
.cs I 23
.ne 3v
.nf
"let" \fID0\fP "=" \fIE0\fP"," ..."," \fIDn\fP "=" \fIEn\fP "in"
    \fIEn+1\fP
"end_let"
.fi
.cs R
.cs I
.IP
allows to declare and initialize variables. The types of the initialization
expressions \fIE0\fP, ..., \fIEn\fP must be compatible with the types
corresponding to the declarations \fID0\fP, ..., \fIDn\fP. All the
variables occurring in the declarations \fIDi\fP are initialized with
the values of \fIEi\fP, and are visible in the expression \fIEn+1\fP.
The "\fBlet\fP" expression also allows to extract the fields of tuple values
and to assign them to variables.
.P
.cs R 23
.cs I 23
.ne 6v
.nf
"if" \fIE0\fP "then" \fIE'0\fP
    "else_if" \fIE1\fP "then" \fIE'1\fP
     ...
    "else_if" \fIEn\fP "then" \fIE'n\fP
    "else" \fIE'n+1\fP
"end_if"
.fi
.cs R
.cs I
.IP
allows the conditional evaluation of expressions. The expressions
\fIE0\fP, ..., \fIEn\fP must be of type \fBboolean\fP, whereas
\fIE'0\fP, ..., \fIE'n+1\fP must be of the same type (which is
also the type of the "if" expression). The evaluation of an "if"
expression proceeds as follows: the conditions \fIEi\fP are evaluated
(for 1 <= i <= n) and the value of the "if" expression is equal to
the value of the first \fIE'i\fP for which \fIEi\fP is true. If none
of the conditions evaluates to true, the resulting value is given by
\fIE'n+1\fP.  If a condition \fIEi\fP is a matching operator, the
variables assigned by the offers inside \fIEi\fP are visible only in
the corresponding expression \fIE'i\fP.
.P
.cs R 23
.cs I 23
.ne 3v
.nf
"assert" \fIE0\fP"," ..."," \fIEn\fP "in"
    \fIEn+1\fP
"end_assert"
.fi
.cs R
.cs I
.IP
allows to stop the execution of an XTL program if a given condition
does not hold. The expressions \fIE0\fP, ..., \fIEn\fP must be of type
\fBboolean\fP. If all the assertions evaluate to \fBtrue\fP, the value
of the "assert" expression is equal to the value of \fIEn+1\fP; otherwise,
the execution of the XTL program is interrupted and an error message is
displayed on the POSIX standard output stream (\fBstdout\fP). \"unixerie
.P
.cs R 23
.cs I 23
.ne 3v
.nf
"use" \fIx0\fP"," ..."," \fIxn\fP "in"
    \fIE\fP
"end_use"
.fi
.cs R
.cs I
.IP
uses the values of variables \fIx0\fP, ..., \fIxn\fP without changing
their value and then evaluates the expression \fIE\fP. The "use" expression
allows to write XTL programs in which every variable defined is used,
which avoids the warnings of the form "variable set but not used" issued
during compilation of the C code generated by XTL. Although the usage of
the "use" expression is harmless and does not impact in any way the
evaluation of XTL expressions, it should be employed only in the (rare)
situations where it is really needed.
.P
.cs R 23
.cs I 23
.ne 6v
.nf
"for" [ \fIx0\fP ":" \fIT0\fP [ "among" \fIE0\fP ]"," ...","
        \fIxn\fP ":" \fITn\fP [ "among" \fIEn\fP ] ]
    [ "in" \fID\fP ]
    [ "while" \fIE'1\fP ]
    [ "where" \fIE'2\fP ]
    "apply" \fIOP\fP
    "from" \fIE'3\fP
    "to" \fIE'4\fP
"end_for"
.fi
.cs R
.cs I
.IP
allows the iterative evaluation of expressions. The \fIiteration
variables\fP \fIx0\fP, ..., \fIxn\fP range over the iteration domains
\fIT0\fP [ "among" \fIE0\fP ], ..., \fITn\fP [ "among" \fIEn\fP ],
respectively. The expressions \fIEi\fP must be of type "\fBset of
\fP\fITi\fP": thus, iterations over sets of states, labels, or edges
are allowed. There is an exception concerning integer numbers and
characters: for these types, domains of the form "{" \fIE1\fP "..."
\fIE2\fP "}", meaning all the integers (resp. characters) between
\fIE1\fP and \fIE2\fP, are also allowed. The variables declared in the
"in" \fID\fP declaration (if present) are called \fIaccumulators\fP. Both
iteration variables and accumulators are visible in the expressions
\fIE'1\fP, \fIE'2\fP (if present), and \fIE'4\fP, but not in
\fIE'3\fP.  The expressions \fIE'1\fP and \fIE'2\fP must be of type
\fBboolean\fP.
.sp
Assuming that all the optional constructs are present,
the evaluation of a "\fBfor\fP" expression proceeds as follows. The
accumulators are initialized to the value of \fIE'3\fP. Let us note
\fIv\fP the current values of the accumulators (\fIv\fP may be of type
tuple). Then, for each value of the iteration variables in their
corresponding domains, the expression \fIv\fP \fIOP\fP \fIE'4\fP is
evaluated and its result is stored in the accumulators. The value of
the "\fBfor\fP" expression is equal to the value of the accumulators
obtained after the last iteration. The "where" clause allows to
perform only those iterations for which the expression \fIE'2\fP
evaluates to \fBtrue\fP. The "while" clause allows to stop the
iterations when the expression \fIE'1\fP becomes
\fBfalse\fP.
.sp
Particular cases of "\fBfor\fP" expressions may be obtained by
eliminating some (or all) of the optional constructs. If the iteration
variables are absent, the "\fBfor\fP" becomes an infinite loop: in this
case, the "\fBwhile\fP" clause must be present in order to stop the
evaluation. If the "\fBin\fP" declaration is absent, the accumulator
is implicit: it is used internally to store the results of
intermediate iterations, but it cannot be used in \fIE'1\fP,
\fIE'2\fP, nor \fIE'4\fP.
.sp
The "\fBfor\fP" expressions are useful for describing iterative
computations. For instance, the expression below displays on the
standard output the sequence of Fibonacci numbers smaller than 1000:

.cs R 23
.nf
for
    in    (xn_plus_1, xn: integer, a:action)
    while xn < 1000
    apply (replace, replace, fby)
    from  (1, 1, nop)
    to    (xn_plus_1 + xn, xn_plus_1,
           print (xn) fby printf ("\\n"))
end_for
.fi
.cs R

.P
.cs R 23
.cs I 23
.ne 5v
.nf
"forall" \fIx0\fP ":" \fIT0\fP [ "among" \fIE0\fP ]"," ...","
         \fIxn\fP ":" \fITn\fP [ "among" \fIEn\fP ]
"in"
    \fIEn+1\fP
"end_forall"
.fi
.cs R
.cs I
.IP
is the universal quantifier. It is equivalent to the following
"\fBfor\fP" expression:

.cs R 23
.cs I 23
.ne 6v
.nf
"for" \fIx0\fP ":" \fIT0\fP [ "among" \fIE0\fP ]"," ...","
      \fIxn\fP ":" \fITn\fP [ "among" \fIEn\fP ]
    "apply" and
    "from"  true
    "to"    \fIEn+1\fP
"end_for"
.fi
.cs R
.cs I

The type of \fIEn+1\fP may be either \fBboolean\fP, \fBstateset\fP,
\fBlabelset\fP, or \fBedgeset\fP. In the three latter cases, the
\fBtrue\fP and \fBand\fP operators correspond to full set and set
intersection, respectively (see TYPES, FUNCTIONS AND CONSTANTS above).
.P
.cs R 23
.cs I 23
.ne 5v
.nf
"exists" \fIx0\fP ":" \fIT0\fP [ "among" \fIE0\fP ]"," ...","
         \fIxn\fP ":" \fITn\fP [ "among" \fIEn\fP ]
"in"
    \fIEn+1\fP
"end_exists"
.fi
.cs R
.cs I
.IP
is the existential quantifier. It is equivalent to the following
"\fBfor\fP" expression:

.cs R 23
.cs I 23
.ne 6v
.nf
"for" \fIx0\fP ":" \fIT0\fP [ "among" \fIE0\fP ]"," ...","
      \fIxn\fP ":" \fITn\fP [ "among" \fIEn\fP ]
    "apply" or
    "from"  false
    "to"    \fIEn+1\fP
"end_for"
.fi
.cs R
.cs I

The type of \fIEn+1\fP may be either \fBboolean\fP, \fBstateset\fP,
\fBlabelset\fP, or \fBedgeset\fP. In the three latter cases, the
\fBfalse\fP and \fBor\fP operators correspond to empty set and set
union, respectively (see TYPES, FUNCTIONS AND CONSTANTS above).
.P
.cs R 23
.cs I 23
.ne 4v
.nf
"<|" \fIOP\fP "on" \fIx0\fP ":" \fIT0\fP [ "among" \fIE0\fP ]"," ...","
             \fIxn\fP ":" \fITn\fP [ "among" \fIEn\fP ]
     [ "where" \fIE'\fP ]
"|>" \fIEn+1\fP
.fi
.cs R
.cs I
.IP
is an abbreviated form of the "\fBfor\fP" expression, called \fIiterator\fP.
It is equivalent to the following "\fBfor\fP" expression:

.cs R 23
.cs I 23
.ne 7v
.nf
"for" \fIx0\fP ":" \fIT0\fP [ "among" \fIE0\fP ]"," ...","
      \fIxn\fP ":" \fITn\fP [ "among" \fIEn\fP ]
    [ "where" \fIE'\fP ]
    "apply" \fIOP\fP
    "from"  \fIinit_OP\fP
    "to"    \fIEn+1\fP
"end_for"
.fi
.cs R
.cs I
.IP
Here \fIinit_OP\fP is a "start" value associated by default to the
operator \fIOP\fP. Only the binary predefined operators that have
initial values assigned by default can be used in the iterators.
.ne 18v
These operators, together with their initial values, are given in
the table below (where "\fIset\fP" denotes either \fBstateset\fP,
\fBlabelset\fP, or \fBedgeset\fP).

.cs R 23
.cs I 23
.nf
+-----------------------------------+---------------+
|            Operator \fIOP\fP            |    \fIinit_OP\fP    |
+===================================+===============+
| or  : boolean, boolean -> boolean | false         |
| and : boolean, boolean -> boolean | true          |
| + : integer, integer -> integer   | 0             |
| * : integer, integer -> integer   | 1             |
| union, or  : set, set -> set      | empty, false  |
| inter, and : set, set -> set      | full, true    |
| diff       : set, set -> set      | full          |
| insert : set, elem -> set         | empty         |
| remove : set, elem -> set         | full          |
| fby : action, action -> action    | nop           |
+-----------------------------------+---------------+
.fi
.cs R
.cs I

The iterators allow to express iterative computations in a form close to
the mathematical notation. For example, the sum of the integer numbers
from 1 to 100 may be computed with the following iterator:

.cs R 23
.nf
    <| + on K:integer among { 1 ... 100 } |> K
.fi
.cs R

Similarly, the number of transitions labelled with "SEND" labels may
be computed as follows:

.cs R 23
.nf
    <| + on T:edge where T -> [ SEND ... ] |> 1
.fi
.cs R
 
.ne 11v
.cs R 23
.cs I 23
.P
.nf
"{" \fIx\fP ":" \fIT\fP [ "among" \fIE0\fP ] "where" \fIE1\fP "}"
.fi
.cs R
.cs I
.IP
is a set value defined by specifying a predicate \fIE1\fP
characterizing the elements of the set. This construct is also a
particular case of "\fBfor\fP" expression:

.cs R 23
.cs I 23
.nf
    "for" \fIx\fP ":" \fIT\fP [ "among" \fIE0\fP ]
        "where" \fIE1\fP
        "apply" union
        "from"  empty
        "to"    "{" \fIx\fP "}"
    "end_for"
.fi
.cs R
.cs I

The implicitly defined sets allow to compute sets of states, labels
or transitions in a form close to the mathematical notation. For
example, the set of deadlock states (i.e., states having no successors)
can be computed by the XTL expression below:

.cs R 23
.nf
    { S:state where succ (S) = empty }
.fi
.cs R

.P
.ne 16v
.SS FUNCTIONS

The XTL language allows to define and use functions. The syntax of function
definitions is given by the grammar below:

.cs R 23
.cs I 23
.nf
\fIFD\fP      ::=  "def" \fIF\fP "(" \fIx1\fP ":" \fIT1\fP"," ..."," \fIxn\fP ":" \fITn\fP ")" ":" \fIRT\fP "="
                 [ \fIFD1\fP ... \fIFDm\fP ]
                 \fIE\fP
                 [ "where" \fIFDm+1\fP ... \fIFDm+p\fP ]
             "end_def"
.sp
         |   "def" "_" \fIF\fP "_" "(" \fIx1\fP ":" \fIT1\fP"," \fIx2\fP ":" \fIT2\fP ")" ":" \fIRT\fP "="
                 [ \fIFD1\fP ... \fIFDm\fP ]
                 \fIE\fP
                 [ "where" \fIFDm+1\fP ... \fIFDm+p\fP ]
             "end_def"
.fi
.cs R
.cs I

The first construct above defines a function \fIF\fP having the parameters
\fIx1\fP, ..., \fIxn\fP of types \fIT1\fP, ..., \fITn\fP, the body \fIE\fP,
and returning a result of type \fIRT\fP. The calls of \fIF\fP have the form:

.cs R 23
.cs I 23
.nf
        \fIF\fP "(" \fIE1\fP"," ..."," \fIEn\fP ")"
.fi
.cs R
.cs I

where the arguments \fIE1\fP, ..., \fIEn\fP must be compatible (in
number and types) with the parameters of \fIF\fP. The result of the
call is equal to the value of \fIE\fP computed in a context in which
the parameters \fIxi\fP are assigned the values of \fIEi\fP for all i
between 1 and n.  The body of \fIF\fP may also contain definitions of
local functions, placed either before \fIE\fP, or after \fIE\fP and
the keyword "\fBwhere\fP".  These functions are visible only in the
expression \fIE\fP. Recursive functions are allowed. Also, functions
can be overloaded: several functions with the same name, but different
profiles, may be defined in the same scope.  In case of ambiguity of
the type of a function call, the "\fBof\fP" expression may be used to
precise a unique type (see EXPRESSIONS above).
.P
The second construct above defines a binary infixed function \fIF\fP having
the parameters \fIx1\fP, \fIx2\fP of types \fIT1\fP, \fIT2\fP, and returning
a result of type \fIRT\fP. The function \fIF\fP behaves like an ordinary
binary function, except that its calls may be written either in the form
\fIF\fP "(" \fIE1\fP"," \fIE2\fP ")", or in the form \fIE1\fP \fIF\fP
\fIE2\fP. This kind of functions allow to write expressions involving
infixed operators using a syntax close to the mathematical notation. For
example, the predefined function "\fB+\fP" over integers is in fact an infixed
operator: the user may write either + (1, 2), or 1 + 2. The infixed operators
(both predefined and user-defined) are right-associative: e.g., the expression
1 + 2 + 3 is parsed as 1 + (2 + 3).
.sp
Functions can be, of course, recursive (either directly, or transitively).
For example, the recursive function below computes the factorial of an
integer number:

.cs R 23
.nf
def fact (n:integer) : integer =
    assert n >= 0 in
        if n = 0 then
            1
        else
            n * fact (n - 1)
        end_if
    end_assert
end_def
.fi
.cs R

This function also checks whether its argument is greater or equal to 0
using an "\fBassert\fP" expression; if this is not the case, the program
execution is aborted with an appropriate error message.

.P
.ne 7v
.SS MACROS

The XTL compiler allows to define and use macros. The syntax of
macro-definitions is given by the following grammar:

.cs R 23
.cs I 23
.nf
\fIMD\fP        ::=  "macro" \fIM\fP "(" \fIP1\fP"," ..."," \fIPn\fP ")" "="
                 <text>
               "end_macro"
.fi
.cs R
.cs I

The above construct defines a macro \fIM\fP having the parameters
\fIP1\fP, ..., \fIPn\fP and the body <text>, which is a portion of text
built using the characters allowed by the XTL language (see LEXICAL
ELEMENTS above). The calls of \fIM\fP have the form:

.cs R 23
.cs I 23
.nf
        \fIM\fP "(" <text1>"," ..."," <textn> ")"
.fi
.cs R
.cs I

where the arguments <text1>, ..., <textn> are portions of XTL
text. The result of the call is <text> in which all the occurrences of
the parameters \fIPi\fP have been syntactically substituted with the
arguments <texti>, for all i between 1 and n. The following syntactic
restriction must be satisfied: the keywords contained in each <texti>
argument must be well-bracketed, i.e., if <texti> contains a keyword
opening an expression (e.g., "\fBfor\fP"), then <texti> must also
contain the corresponding keyword closing the expression (e.g.,
"\fBend_for\fP"). This also applies to the non-alphabetic keywords
such as "\fB(\fP", "\fB)\fP", "\fB[\fP", "\fB]\fP", "\fB{\fP",
"\fB}\fP". A macro is visible from the point of its definition until
the end of the XTL program. The macros may be overloaded: several
macros with the same name, but different arities, may be defined in
the same scope.

.SS LIBRARIES

There is also possible to include in the text of an XTL program external
libraries, typically containing definitions of temporal operators. The
inclusion command has the following syntax:

.cs R 23
.cs I 23
.ne 2v
.nf
\fILI\fP        ::=  "library" <file0.xtl>"," ..."," <filen.xtl>
               "end_library"
.fi
.cs R
.cs I

At the compilation of the program, the above construct is
syntactically replaced with the contents of the files <file0.xtl>, ...,
<filen.xtl>, placed one after the other in this order. The XTL
compiler searches the included files first in the current directory,
then in the directory referenced by \fB$CADP/src/xtl\fP.
Multiple inclusions of the same file are silently discarded,
unless the \fB-warning\fP option is passed to the compiler;
in this case, appropriate messages are issued.

.SS DIRECTIVES

The XTL compiler allows to declare and use in an XTL program data types
and functions implemented externally in C. The directive for an external
type declaration has the following syntax:

.nf
.cs I 23
.cs 4 23
\fB\fIETD\fP  ::=  "type" \fIT\fP
                [ "!" "implementedby" "<C_type>" ]
                [ "!" "comparedby" "<C_compare>" ]
                [ "!" "enumeratedby" "<C_iterate>" ]
                [ "!" "printedby" "<C_print>" ]
          "end_type"\fR
.cs 4
.cs I
.fi

where \fIT\fP is the identifier of the declared type and the optional
pragmas preceded by "!" refer to the C implementation of \fIT\fP:
<C_type> is the identifier of the C type implementing \fIT\fP;
<C_compare> is an operator for comparing two values of type \fIT\fP;
<C_iterate> is a macro allowing to iterate over all values of type \fIT\fP;
and <C_print> is a printing function for values of type \fIT\fP.
The C names declared by these pragmas cannot be used directly in the XTL
program, but are used in the C code generated by the XTL compiler.

The directive for an external function declaration has the following syntax:

.nf
.cs I 23
.cs 4 23
\fB\fIEFD\fP  ::=  "func" \fIF\fP "(" \fIT1\fP"," ..."," \fITn\fP ")" ":" \fIRT\fP
                [ "!" "implementedby" "<C_func>" ]
          "end_func"\fR
.cs 4
.cs I
.fi

where \fIF\fP is the identifier of the declared function, \fIT1\fP, ...,
\fITn\fP are the types of its parameters, and \fIRT\fP is the type of its
result. The optional pragma "implementedby" declares the name <C_func>
of the C function implementing \fIF\fP. This C identifier cannot be used
in the XTL program, but is used in the C code generated by the XTL compiler.

The external types and functions declared using the directives above
may be implemented in (one or more) C files file1.c, ..., filen.c that
must be included in the C code generated by the XTL compiler. This is
done using the following external include directive:
 
.nf
\fB\fIEID\fP  ::=  "include" "<file1>", ..., "<filen>" "end_include"\fR
.fi

where <file1>, ..., <filen> are the names of the C source files
(".c" and/or ".h") that must be included. This directive is translated
into corresponding "#include" pre-processor commands in the C code
generated by the XTL compiler.

The compilation and linkediting of the C modules included may require
specific parameters. These can be indicated to the XTL compiler using
the following external compile directive:

.nf
\fB\fIELD\fP  ::=  "flag" "<C_compiler_directives>" "end_flag"\fR
.fi

where <C_compiler_directives> is a portion of command-line for invoking
the C compiler (typically containing "-I", "-L", and "-l" options) that
specifies the desired compilation parameters. This portion of command-line
is used by the XTL compiler when creating the binary file of the generated
C code.

As an example, the XTL program below uses the CAESAR_ERROR() function
for error handling, which is declared externally in the "caesar_standard.h"
file and defined in the OPEN/CAESAR library libcaesar.a. Upon execution,
the program will output the error message and stop.

.nf
.cs 4 23
\fB    include
      "caesar_standard.h"
    end_include
 
    flag
      "-I/common/Cadp/incl -L/common/Cadp/bin.sun5 -lcaesar"
    end_flag
 
    func error (string) : action
      ! implementedby "CAESAR_ERROR"
    end_func
 
    error ("Here occurs a fatal error. Farewell.")\fR
.cs 4
.fi

.P
.ne 12v
.SS PROGRAM

The syntax of an XTL program is given by the following grammar:

.cs 4 23
.cs I 23
.nf
\fB\fIPG\fP  ::=  [ ( \fIFD1\fP | \fIETD1\fP | \fIEFD1\fP | \fIEID1\fP | \fIELD1\fP )
           ...
           ( \fIFDm\fP | \fIETDm\fP | \fIEFDm\fP | \fIEIDm\fP | \fIELDm\fP ) ]
         [ \fIMD1\fP ... \fPMDp\fP ]
         [ \fILI1\fP ... \fPLIr\fP ]
             \fIE\fP
         [ "where"
            [ \fIMDp+1\fP ... \fPMDp+q\fP ]
            [ \fILIr+1\fP ... \fPLIr+s\fP ]
            ( \fIFDm+1\fP | \fIETDm+1\fP | \fIEFDm+1\fP | \fIEIDm+1\fP | \fIELDm+1\fP )
            ...
            ( \fIFDm+n\fP | \fIETDm+n\fP | \fIEFDm+n\fP | \fIEIDm+n\fP | \fIELDm+n\fP ) ]\fR
.fi
.cs 4
.cs I

The expression \fIE\fP is the body of the program. There may also be
lists of function definitions, external directives, macro definitions,
and/or library inclusions, placed in the front of the program or at its end,
after the "\fBwhere\fP" keyword. The functions defined by \fIFD1\fP, ...,
\fIFDm+n\fP are visible in the body \fIE\fP of the program, as well as
in all their bodies.

.SH HOW TO CREATE A X\&T\&L FILE

At present, XTL files must be written by hand.

.SH HOW TO READ A X\&T\&L FILE

At present, there is one single CADP tool,
.BR xtl (LOCAL),
that reads and processes XTL files.

.SH BIBLIOGRAPHY

[MG98]
R. Mateescu and H. Garavel.
XTL: Meta-Language and Tool for Temporal Logic Model-Checking.
Proc. of the International Workshop on Software Tools for Technology Transfer
STTT'98 (Aalborg, Denmark). BRICS Notes Series NS-98-4, pp. 33-42, 1998.
Available from http://cadp.inria.fr/publications/Mateescu-Garavel-98.html

.P
[GLMS13]
H. Garavel, F. Lang, R. Mateescu, and W. Serwe.
CADP 2011: A Toolbox for the Construction and Analysis of
Distributed Processes.
Springer International Journal on Software Tools for Technology Transfer
(STTT), 15(2):89-107, 2013.
http://cadp.inria.fr/publications/Garavel-Lang-Mateescu-Serwe-13.html

.SH SEE ALSO
.BR bcg (LOCAL),
.BR bcg_io (LOCAL),
.BR xtl (LOCAL).
.P
Additional information is available from the CADP Web page located at http://cadp.inria.fr
.P
Directives for installation are given in files \fB$CADP/INSTALLATION_*\fP.
.P
Recent changes and improvements to this software are reported
and commented in file \fB$CADP/HISTORY\fP.

.SH BUGS
Please report bugs to Radu.Mateescu@inria.fr

