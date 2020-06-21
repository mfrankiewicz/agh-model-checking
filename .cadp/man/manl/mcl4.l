.\" @(#)mcl4.l - VASY and CONVECS teams - 2018/05/25
.TH MCL4 LOCAL "2018/05/25" "(C) INRIA" "CADP MANUAL PAGES"
.fp 4 CB
.lg 0
.SH NAME
mcl, MCL \- Model Checking Language version 4 (value-passing modal mu-calculus)

.SH DESCRIPTION

This manual page presents the version 4 of \fIMCL\fP (\fIModel Checking Language\fP),
which is the temporal logic accepted as input by
.BR evaluator4 (LOCAL).
In the remainder of this page, "\fIMCL\fP" denotes version 4 of \fIMCL\fP; see
.BR mcl (LOCAL)
for other versions of \fIMCL\fP.

.P
A description of \fIMCL\fP can be found in article [MT08], which also
describes the verification method implemented in version 4.0 of EVALUATOR.

.P
The \fIMCL\fP language attempts to make a compromise between expressiveness,
user-friendliness, and efficiency of model checking for temporal
properties involving data. \fIMCL\fP is based on the alternation-free
fragment of the modal mu-calculus [Koz83, EL86], to which it brings
two kinds of extensions:

.IP -
Action predicates equipped with data variables and expressions,
modalities containing extended regular expressions over action sequences,
parameterized fixed point operators, and data-handling constructs
inspired from the RICO temporal logic [Gar89] and from programming languages.
.IP -
An infinite looping operator (of alternation depth two [EL86]) similar to the
one present in \fIPDL-delta\fP
(Propositional Dynamic Logic with Looping) [Str82], which enables the
expression of fairness properties by characterizing complex unfair cycles
of transitions in the LTS.
.P
An overview of the \fIMCL\fP language is presented below.
The abstract syntax of each language construct is defined by a
BNF grammar and the semantics is described informally.
In the grammar, terminal symbols are written between double
quotes. Optional constructs are enclosed between square brackets.
The axiom of the grammar is the \fIF\fP symbol.
.P
The following convention is adopted for the lists of symbols occurring in
the grammar rules: the index \fIn\fP of the last symbol in the list is always
greater or equal to 0, meaning that if the index of the first symbol is 0
(e.g., \fIE0\fP, ..., \fIEn\fP), then the list must contain at least one symbol,
and if the index of the first symbol is 1 (e.g., \fIE1\fP, ..., \fIEn\fP), then
the list may be empty.
.P
When referring to a certain construct of the grammar, the term "enclosing
formula" denotes the (action, regular, or state) formula immediately
surrounding that construct.
.P
.cs 4 23
.cs I 23
.nf
\fB                  +--------+------------------------+
                  | Symbol |      Description       |
       +----------+--------+------------------------+
       |          |   \fIE\fP    | expression             |
       |          |   \fIP\fP    | pattern                |
       |          |   \fIO\fP    | offer                  |
       | Non-     |   \fIAP\fP   | action pattern         |
       | terminal |   \fIA\fP    | action formula         |
       |          |   \fIR\fP    | regular formula        |
       |          |   \fIF\fP    | state formula          |
       +----------+--------+------------------------+
       |          |   \fIK\fP    | constant               |
       |          |   \fIX\fP    | data variable          |
       | Terminal |   \fIY\fP    | propositional variable |
       |          |   \fIH\fP    | function or operator   |
       |          |   \fIT\fP    | type                   |
       +----------+--------+------------------------+\fR
.fi
.cs 4
.cs I
.P
The formulas \fIA\fP, \fIR\fP, \fPF\fP are interpreted over an LTS
\fI<S, A, T, s0>\fP, where:
\fIS\fP is the set of \fIstates\fP,
\fIA\fP is the set of \fIactions\fP (transition labels),
\fIT\fP is the \fItransition relation\fP (a subset of \fIS * A * S\fP),
and \fIs0\fP is the \fIinitial state\fP.
A transition \fI(s1, a, s2)\fP of \fIT\fP, also written \fIs1-a->s2\fP,
indicates that the system can move from state \fIs1\fP to state \fIs2\fP
by performing action \fIa\fP.
An action \fIa\fP has the following structure:
.sp
.cs 4 23
.cs I 23
.nf
    \fB\fIG\fP \fIv1\fP ... \fIvn\fP\fR
.fi
.cs 4
.cs I
.sp
where \fIG\fP is the name of a gate (communication channel) and
\fIv1\fP, ..., \fIvn\fP are the values exchanged on \fIG\fP when
the rendezvous underlying action \fIa\fP was executed. In the case
that there are no values exchanged, the action is simply a gate name.
There is an invisible action (named \fIi\fP in LOTOS and \fItau\fP in other
process algebras).
.P
Note: Actions are also represented as character strings, which is useful
for expressing certain action predicates (see ACTION FORMULAS below).
The character string representation of actions depends on the language from
which the LTS \fIspec\fP is generated. For example, if the input is given as
a LOTOS program \fIspec\fP[\fB.lotos\fP], an action having the structure
shown above will be represented as the character string
"\fIG\fP !\fIv1\fP ... !\fIvn\fP".

.SH LEXICAL ELEMENTS
.P
Identifiers are built from letters, digits, and underscores (beginning
with a letter or an underscore). \fBevaluator4\fP is case-sensitive,
except for the identifiers of predefined types and functions (see TYPES,
FUNCTIONS AND CONSTANTS below). Keywords must be written in lowercase.
Comments are enclosed between '\fB(*\fP' and '\fB*)\fP'. Nested comments
are not allowed. The keywords of \fIMCL\fP are listed below.
.P
.TS
center;
L L L L.
\fBamong\fP	\fBequ\fP	\fBin\fP	\fBrepeat\fP
\fBand\fP	\fBexists\fP	\fBlet\fP	\fBstep\fP
\fBany\fP	\fBexit\fP	\fBloop\fP	\fBtau\fP
\fBcase\fP	\fBexport\fP	\fBmu\fP	\fBthen\fP
\fBchoice\fP	\fBfalse\fP	\fBnil\fP	\fBto\fP
\fBcontinue\fP	\fBfor\fP	\fBnot\fP	\fBtrue\fP
\fBdo\fP	\fBforall\fP	\fBnu\fP	\fBuntil\fP
\fBelse\fP	\fBfrom\fP	\fBof\fP	\fBwhere\fP
\fBelsif\fP	\fBif\fP	\fBon\fP	\fBwhile\fP
\fBend\fP	\fBimplies\fP	\fBor\fP	\fBxor\fP
.TE

.SH TYPES, FUNCTIONS AND CONSTANTS
\fIMCL\fP is a strongly-typed language: every variable used in an
\fIMCL\fP formula must have a unique type, which is statically
determined. In its current version, the language does not provide a
mechanism for type or function definition. \fIMCL\fP predefines the usual types
encountered in programming languages (\fBbool\fP, \fBnat\fP, \fBnatset\fP,
\fBint\fP, \fBreal\fP, \fBchar\fP, \fBstring\fP), equipped with the standard
functions and operators listed below.
.P
.cs R 23
.nf
+--------------------------------+--------------------------+
|                Operator        |         Meaning          |
+--------------------------------+--------------------------+
| false, true : -> bool          | boolean constants        |
| not : bool -> bool             | negation                 |
| or, and, implies, equ, xor :   | binary boolean operators |
|     bool, bool -> bool         |                          |
| <, <=, >, >=, =, <> :          | comparison operators     |
|     bool, bool -> bool         |                          |
+--------------------------------+--------------------------+
| succ : nat -> nat              | successor                |
| - : nat -> int                 | unary minus              |
| +, - : nat, nat -> nat         | addition, subtraction    |
| *, / : nat, nat -> nat         | multiplication, division |
| % : nat, nat -> nat            | modulo                   |
| ^ : nat, nat -> nat            | power                    |
| string : nat -> string         | convert to string        |
| <, <=, >, >=, =, <> :          | comparison operators     |
|     nat, nat -> bool           |                          |
+--------------------------------+--------------------------+
| empty : -> natset              | empty set                |
| insert : nat, natset -> natset | element insertion        |
| remove : nat, natset -> natset | element deletion         |
| isin : nat, natset -> bool     | membership               |
| union, inter, diff :           | binary set operators     |
|     natset, natset -> natset   |                          |
| <, <=, >, >=, =, <> :          | comparison operators     |
|     natset, natset -> bool     |                          |
+--------------------------------+--------------------------+
| succ : int -> int              | successor                |
| abs : int -> nat               | absolute value           |
| sign : int -> int              | returns -1, 0, 1 if arg. |
|                                |     is < 0, = 0, > 0     |
| - : int -> int                 | unary minus              |
| +, - : int, int -> int         | addition, subtraction    |
| *, / : int, int -> int         | multiplication, division |
| % : int, int -> int            | modulo                   |
| ^ : int, nat -> int            | power                    |
| string : int -> string         | convert to string        |
| <, <=, >, >=, =, <> :          | comparison operators     |
|     int, int -> bool           |                          |
+--------------------------------+--------------------------+
| - : real -> real               | unary minus              |
| +, - : real, real -> real      | addition, subtraction    |
| *, / : real, real -> real      | multiplication, division |
| ^ : real, real -> real         | power                    |
| string : real -> string        | convert to string        |
| <, <=, >, >=, =, <> :          | comparison operators     |
|     real, real -> bool         |                          |
+--------------------------------+--------------------------+
| tolower, toupper :             | convert letter to lower- |
|     char -> char               |     or upper-case        |
| islower, isupper :             | test if lower- or upper- |
|     char -> bool               |     case letter          |
| isalpha, isdigit, isalnum :    | test if letter, digit,   |
|     char -> bool               |     letter or digit      |
| isxdigit :                     | test if hexadecimal      |
|     char -> bool               |     digit                |
| string : char -> string        | convert to string        |
| <, <=, >, >=, =, <> :          | comparison operators     |
|     char, char -> bool         |                          |
+--------------------------------+--------------------------+
| length : string -> nat         | length (number of chars) |
| empty : string -> bool         | test if empty string     |
| concat :                       | concatenation            |
|     string, string -> string   |                          |
| index, rindex :                | index of the first/last  |
|     string, string -> nat      |     occurrence of the    |
|                                |     2nd arg. in the 1st  |
| prefix, suffix :               | prefix/suffix of given   |
|     string, nat -> string      |     length               |
| nth : string, nat -> char      | nth character            |
| substr :                       | substring starting at an |
|     string, nat, nat -> string |     index and having a   |
|                                |     given length         |
| <, <=, >, >=, =, <> :          | comparison operators     |
|     string, string -> bool     |                          |
+--------------------------------+--------------------------+
.fi
.cs R
.P
The numerical, character, and string constants have a C-like syntax
(e.g., \fB13\fP, \fB-1\fP, \fB1.618\fP, \fB'a'\fP, \fB'\e007'\fP, \fB'\en'\fP,
\fB"hello world\en"\fP). In order to allow implicit type conversions,
numerical constants are overloaded as follows: a constant of type \fBnat\fP
can also be of type \fBint\fP or \fBreal\fP, and a constant of type \fBint\fP
can also be of type \fBreal\fP.
.P
The names of the operators of type \fBbool\fP (constants,
negation, and binary operators) that coincide with the keywords
operating on formulas must be written in lowercase.
.P
The binary boolean operators, binary set and membership operators,
the arithmetic operators
(of types \fBnat\fP, \fBint\fP, and \fBreal\fP), and all comparison operators
must be written in infixed form (e.g., \fB1 + 2\fP,  \fBX inter Y\fP,
\fB1.0 < 2.0\fP, etc.). All the other operators must be written in prefixed
form (e.g., \fBinsert (0, empty)\fP, \fBconcat ("a", "b")\fP, etc.).
.P
The operands of the binary operators of type \fBbool\fP
("\fBor\fP", "\fBand\fP", "\fBimplies\fP", "\fBequ\fP", "\fBxor\fP") are
evaluated from left to right in a lazy way, i.e., the right operand is not
evaluated if the value of the left operand can determine the value of the
whole expression.
.P
All the binary operators of the predefined types shown above are
left-associative. Unary operators have the highest precedence, followed by
binary operators. In the current version of the tool all binary operators
are considered to be of equal precedence; parentheses must be used for
imposing a desired parsing/evaluation order.

.SH EXPRESSIONS
The syntax of \fIMCL\fP expressions is defined by the following grammar:
.P
.cs 4 23
.cs I 23
.nf
\fB\fIE\fP	::=  \fIK\fP

	 |   \fIX\fP

	 |   \fIH\fP \fIE\fP

	 |   \fIE1\fP \fIH\fP \fIE2\fP

	 |   \fIH\fP "(" \fIE1\fP"," ..."," \fIEn\fP ")"

	 |   \fIE\fP "of" \fIT\fP

	 |   "(" \fIE\fP ")"\fR
.fi
.cs 4
.cs I
.P
The semantics of \fIMCL\fP expressions is described informally below.
The evaluation of an expression \fIE\fP in a context assigning values
to all data variables occurring in \fIE\fP yields a unique value.
.P
.nf
\fIK\fP
.fi
.IP
is a literal constant of a predefined type (see TYPES, FUNCTIONS AND
CONSTANTS above).
.P
.cs R
.cs I
.nf
\fIX\fP
.fi
.IP
is a data variable (see DECLARATIONS below).
.P
.cs R
.cs I
.nf
\fIH\fP \fIE\fP
.fi
.IP
denotes a call of the unary prefixed operator \fIH\fP on the argument
\fIE\fP.
The argument must be of the same type as the formal parameter of \fIH\fP.
.P
.cs R
.cs I
.nf
\fIE1\fP \fIH\fP \fIE2\fP
.fi
.IP
denotes a call of the binary infixed operator \fIH\fP on the arguments
\fIE1\fP and \fIE2\fP. The arguments must be of the same types as the
corresponding formal parameters of \fIH\fP.
.P
.cs R
.cs I
.nf
\fIH\fP "(" \fIE1\fP"," ..."," \fIEn\fP ")"
.fi
.cs R
.cs I
.IP
denotes a call of the function \fIF\fP on the arguments \fIE1\fP, ..., \fIEn\fP.
The arguments must be compatible (in number and type) with the formal
parameters of \fIH\fP.
.P
.cs R
.cs I
.nf
\fIE\fP "of" \fIT\fP
.fi
.cs R
.cs I
.IP
specifies that expression \fIE\fP has type \fIT\fP. This mechanism
makes it possible to solve ambiguities that may be caused by the overloading
of operators and constants (see TYPES, FUNCTIONS AND CONSTANTS above).
.P
.cs R
.cs I
.nf
"(" \fIE\fP ")"
.fi
.cs R
.cs I
.IP
has the same meaning as the expression \fIE\fP. Parentheses are useful
for imposing an evaluation order of subexpressions different from the
order given by the associativity and precedence of operators. For example,
\fBx + (y / 2)\fP is different from \fBx + y / 2\fP, which is evaluated
by default as \fB(x + y) / 2\fP since all binary operators have the same
precedence.

.SH DECLARATIONS

Similarly to classical functional programming languages, \fIMCL\fP provides
mechanisms for declaring and initializing data variables.
Declarations (without initialization) have the following general form:

.nf
\fB    \fIx01\fP "," ... "," \fIx0m0\fP ":" \fIT0\fP
    "," ... ","
    \fIxn1\fP "," ... "," \fIxnmn\fP ":" \fITn\fP\fR
.fi

which declares the data variables \fIxi1\fP, ..., \fIximi\fP of type \fITi\fP
for each 0 <= \fIi\fP <= \fIn\fP. This general form of declaration is
equivalent to the simplified form below, which will be used in the remainder
of this manual page:

.nf
\fB    \fIx01\fP ":" \fIT0\fP "," ... "," \fIx0m0\fP ":" \fIT0\fP
    "," ... ","
    \fIxn1\fP ":" \fITn\fP "," ... "," \fIxnmn\fP ":" \fITn\fP\fR
.fi

In the same way, declarations with initialization have the following general
form:

.nf
\fB    \fIx01\fP "," ... "," \fIx0m0\fP ":" \fIT0\fP ":=" \fIE0\fP
    "," ... ","
    \fIxn1\fP "," ... "," \fIxnmn\fP ":" \fITn\fP ":=" \fIEn\fP\fR
.fi

which declares the data variables \fIxi1\fP, ..., \fIximi\fP of type \fITi\fP
and initializes them with the value of the expression \fIEi\fP for each
0 <= \fIi\fP <= \fIn\fP. This general form of declaration with initialization
is equivalent to the simplified form below, which will be used in the remainder
of this manual page:

.nf
\fB    \fIx01\fP ":" \fIT0\fP ":=" \fIE0\fP "," ... "," \fIx0m0\fP ":" \fIT0\fP ":=" \fIE0\fP
    "," ... ","
    \fIxn1\fP ":" \fITn\fP ":=" \fIEn\fP "," ... "," \fIxnmn\fP ":" \fITn\fP ":=" \fIEn\fP\fR
.fi

.SH PATTERNS
\fIMCL\fP allows the manipulation of data values by matching them against
patterns and storing them in data variables. The syntax of \fIMCL\fP patterns
is defined by the following grammar:
.P
.cs 4 23
.cs I 23
.nf
\fB\fIP\fP	::=  "any"

	 |   \fIK\fP

	 |   \fIX\fP ":" \fIT\fP

	 |   \fIP\fP "of" \fIT\fP

	 |   \fIP1\fP "|" \fIP2\fP\fR
.fi
.cs 4
.cs I
.P
The semantics of \fIMCL\fP patterns is described informally below.
.P
.cs R
.cs I
.nf
"any"
.fi
.cs R
.cs I
.IP
is the "wildcard" pattern, which matches any value of any type.
.P
.cs R
.cs I
.nf
\fIK\fP
.fi
.cs R
.cs I
.IP
is the constant pattern, which matches a value identical to \fIK\fP.
.P
.cs R
.cs I
.nf
\fIX\fP ":" \fIT\fP
.fi
.cs R
.cs I
.IP
matches any value of type \fIT\fP and stores it in variable \fIX\fP,
which is exported to (i.e., made visible in) the enclosing formula.
.P
.cs R
.cs I
.nf
\fIP\fP "of" \fIT\fP
.fi
.cs R
.cs I
.IP
removes ambiguities (caused, e.g., by overloaded functions) by imposing
that a value can be matched by \fIP\fP only if it is of type \fIT\fP.
.P
.cs R
.cs I
.nf
\fIP1\fP "|" \fIP2\fP\fR
.fi
.cs R
.cs I
.IP
matches a value if either \fIP1\fP or \fIP2\fP matches it.
The patterns \fIP1\fP and \fIP2\fP must declare the same data variables,
all of which are exported to the enclosing formula.

.SH OFFERS
Expressions and patterns can be used in offers, which enable one to match
a given value against an expression or to extract and store it in a variable.
The syntax of \fIMCL\fP offers is defined by the following grammar:
.P
.cs 4 23
.cs I 23
.nf
\fB\fIO\fP	::=  "?" \fIP\fP

	 |   "!" \fIE\fP\fR
.fi
.cs 4
.cs I
.P
The semantics of \fIMCL\fP offers is described informally below.
.P
.cs R
.cs I
.nf
"?" \fIP\fP
.fi
.cs R
.cs I
.IP
is a pattern offer, which matches a value iff the pattern \fIP\fP matches
that value. All variables declared in \fIP\fP are exported to the enclosing
formula.
.P
.cs R
.cs I
.nf
"!" \fIE\fP
.fi
.cs R
.cs I
.IP
is an expression offer, which matches a value iff the evaluation of the
expression \fIE\fP yields that value, which also means that \fIE\fP and
that value must be of the same type.
.sp
Note: Pattern and expression offers involving constants have the same
semantics, e.g., \fB? 3.1416\fP is equivalent to \fB! 3.1416\fP.

.SH ACTION PATTERNS
An action pattern \fIAP\fP specifies that a certain action (transition label)
of the LTS matches a list of offers. The syntax of \fIMCL\fP action patterns
is defined by the following grammar:
.P
.cs 4 23
.cs I 23
.nf
\fB\fIAP\fP	::=  "{" \fIO0\fP ... \fIOn\fP [ "where" \fIE\fP ] "}"

	 |   "{" \fIO1\fP ... \fIOn\fP "..." \fIO'1\fP ... \fIO'm\fP [ "where" \fIE\fP ] "}"\fR
.fi
.cs 4
.cs I
.P
Action patterns inspect the structure of actions \fIG\fP \fIv1\fP ...
\fIvn\fP by matching values \fIvi\fP against expression offers or extracting
them using pattern offers. The optional clause "\fBwhere\fP" defines a boolean
expression \fIE\fP (a guard) that must evaluate to true for the action pattern
to match the action. All variables declared by the offers of an action pattern
are visible in the guard \fIE\fP (if present) and are also exported to the
enclosing formula.
.P
The gate name \fIG\fP can be matched by the first offer of an action pattern
in three different ways:
.IP -
As a character string constant, using an expression offer (e.g.,
\fB!"Send"\fP);
.IP -
As a gate identifier, using a particular form of expression offer without
the "\fB!\fP" mark (e.g., \fBSend\fP). This form of matching can be applied only when
the gate name has a syntax compatible with the syntax of \fIMCL\fP identifiers;
.IP -
As a character string value, using a pattern offer (e.g., \fB?gate:string\fP).
.P
The semantics of \fIMCL\fP action patterns is described informally below.
.P
.cs R
.cs I
.nf
"{" \fIO0\fP ... \fIOm\fP [ "where" \fIE\fP ] "}"
.fi
.cs R
.cs I
.IP
matches an action \fIG\fP \fIv1\fP ... \fIvn\fP iff
\fIm\fP = \fIn\fP, the offer \fIO0\fP matches \fIG\fP, 
each offer \fIOi\fP (for \fIi\fP = 1..\fIn\fP) matches its corresponding
value \fIvi\fP, and the expression \fIE\fP (if present) evaluates to true
in a context in which all variables declared in the offers \fIO0\fP, ...,
\fIOm\fP are replaced with the corresponding values.
.sp
This is the basic action pattern, in which all values present in the action
are explicitly matched by offers. The matching of the gate name \fIG\fP by the
offer \fIO0\fP can be done in one of the three ways indicated above.
.P
.cs R
.cs I
.IP
The simplest action pattern of this form consists of a gate name (e.g.,
\fB{ Send }\fP). For conciseness, the curly braces can be omitted in this
case: one can write simply \fBSend\fP in order to match an action
consisting only of a gate name \fBSend\fP.
.P
.cs R
.cs I
.nf
"{" \fIO1\fP ... \fIOm\fP "..." \fIO'1\fP ... \fIO'p\fP [ "where" \fIE\fP ] "}"
.fi
.cs R
.cs I
.IP
matches an action \fIG\fP \fIv1\fP ... \fIvn\fP iff
\fIm+p\fP <= \fIn\fP, the offer \fIO1\fP (if present, i.e., if \fIm\fP > 0)
matches \fIG\fP, each offer \fIOi\fP (for \fIi\fP = 1..\fIm\fP) matches its
corresponding value \fIvi\fP, each offer \fIO'j\fP (for \fIj\fP = 1..\fIp\fP)
matches its corresponding value \fIvn-(p-j)\fP, and the expression \fIE\fP
(if present) evaluates to true in a context in which all variables declared
in the offers \fIO1\fP, ..., \fIOm\fP, \fIO'1\fP, ..., \fIO'p\fP are replaced
with the corresponding values.
.sp
This is a form of action pattern that enables matching only the first \fIm\fP
and the last \fIp\fP values contained in an action, and skipping the other
values (if any) in the middle. The matching of the gate name \fIG\fP by the
offer \fIO1\fP can be done in one of the three ways indicated above.
Either one, or both groups of offers \fIO1\fP ... \fIOm\fP and
\fIO'1\fP ... \fIO'p\fP can be absent (i.e., \fIm\fP = 0 or/and \fIp\fP = 0).
The simplest action pattern of this form (which is always matched by any
action) is \fB{ ... }\fP.

.SH ACTION FORMULAS
An \fIaction formula\fP is a logical formula built from action
predicates (which can be action patterns, character strings, regular
expressions over character strings, and the "\fBtau\fP" constant operator)
and boolean operators. The syntax of \fIMCL\fP action formulas
is defined by the following grammar:
.P
.cs 4 23
.cs I 23
.nf
\fB\fIA\fP	::=  \fIAP\fP

	 |   \fIaction_string\fP

	 |   \fIaction_regexp\fP

	 |   "tau"

	 |   "true"

	 |   "false"

	 |   "not" \fIA\fP

	 |   \fIA1\fP "or" \fIA2\fP

	 |   \fIA1\fP "xor" \fIA2\fP

	 |   \fIA1\fP "and" \fIA2\fP

	 |   \fIA1\fP "implies" \fIA2\fP

	 |   \fIA1\fP "equ" \fIA2\fP

	 |   "(" \fIA\fP ")"\fR
.fi
.cs 4
.cs I
.P
Syntactically, all binary operators on action formulas
are left-associative. The "\fBnot\fP" operator has the highest precedence,
followed by "\fBand\fP", followed by "\fBor\fP" and "\fBxor\fP", followed
by "\fBimplies\fP", followed by "\fBequ\fP".
.P
An action formula defines a predicate over the actions of the LTS.
The semantics of \fIMCL\fP action formulas is described informally below.
.P
.cs R
.cs I
.nf
\fIAP\fP
.fi
.cs R
.cs I
.IP
an action (transition label) of the LTS satisfies an action pattern \fIAP\fP
if the content of the action matches the pattern. In this case, all variables
declared by the offers of \fIAP\fP are initialized with the corresponding values
extracted from the action and are also exported to the enclosing formula.
.P
.cs R
.cs I
.nf
\fIaction_string\fP
.fi
.cs R
.cs I
.IP
an \fIaction_string\fP is a sequence of 0 or more characters, enclosed
between double quotes ('\fB"\fP'), which denotes an action of the LTS.
A string may contain any character but '\fB\en\fP' (end-of-line).
Double quotes are also allowed, if preceded by a backslash ('\fB\e\fP').
Strings can be concatenated using the binary operator '\fB#\fP' according to
the grammar below:
.sp
.cs 4 23
.cs I 23
.nf
\fB\fIaction_string\fP ::= "(\fIany char but end-of-line\fP)*"\fR

        |   \fIaction_string1\fP "#" \fIaction_string2\fP
.fi
.cs 4
.cs I
.sp
An action of the LTS satisfies an \fIaction_string\fP iff its
string representation is identical to the corresponding character string
(obtained after concatenation whenever needed).
.P
.cs R
.cs I
.nf
\fIaction_regexp\fP
.fi
.cs R
.cs I
.IP
an \fIaction_regexp\fP is a UNIX regular expression (see the
.BR regexp (LOCAL)
manual page
for a detailed description of UNIX regular expressions), enclosed between
single quotes ('\fB'\fP'), which denotes a predicate on the actions of the LTS.
Regexps can be concatenated using the binary operator '\fB#\fP' according to
the grammar below. Strings can be concatenated to regexps, in which case
they are implicitly converted into regexps.
.sp
.cs 4 23
.cs I 23
.nf
\fB\fIaction_regexp\fP ::= '\fIUNIX_regular_expression\fP'\fR

        |   \fIaction_regexp1\fP "#" \fIaction_regexp2\fP

        |   \fIaction_string1\fP "#" \fIaction_regexp2\fP

        |   \fIaction_regexp1\fP "#" \fIaction_string2\fP\fR
.fi
.cs 4
.cs I
.sp
An action of the LTS satisfies an \fIaction_regexp\fP iff its string
representation matches the corresponding \fIUNIX_regular_expression\fP
(obtained after concatenation whenever needed).
.P
.cs R
.cs I
.nf
"tau"
.fi
.cs R
.cs I
.IP
an action of the LTS satisfies this action formula iff it is the invisible
action.
.P
.cs R
.cs I
.nf
"true"
.fi
.cs R
.cs I
.IP
an action of the LTS always satisfies this formula.
.P
.cs R
.cs I
.nf
"false"
.fi
.cs R
.cs I
.IP
an action of the LTS never satisfies this formula.
.P
.cs R
.cs I
.nf
"not" \fIA\fP
.fi
.cs R
.cs I
.IP
an action of the LTS satisfies this formula iff it does not satisfy \fIA\fP.
.P
.cs R
.cs I
.nf
\fIA1\fP "or" \fIA2\fP
.fi
.cs R
.cs I
.IP
an action of the LTS satisfies this formula iff it satisfies \fIA1\fP or
it satisfies \fIA2\fP.
.P
.cs R
.cs I
.nf
\fIA1\fP "xor" \fIA2\fP
.fi
.cs R
.cs I
.IP
an action of the LTS satisfies this formula iff it satisfies exactly one of
\fIA1\fP and \fIA2\fP.
.P
.cs R
.cs I
.nf
\fIA1\fP "and" \fIA2\fP
.fi
.cs R
.cs I
.IP
an action of the LTS satisfies this formula iff it satisfies both \fIA1\fP
and \fIA2\fP.
.P
.cs R
.cs I
.nf
\fIA1\fP "implies" \fIA2\fP
.fi
.cs R
.cs I
.IP
an action of the LTS satisfies this formula iff it does not satisfy \fIA1\fP
or it satisfies \fIA2\fP.
.P
.cs R
.cs I
.nf
\fIA1\fP "equ" \fIA2\fP
.fi
.cs R
.cs I
.IP
an action of the LTS satisfies this formula iff either it satisfies both
\fIA1\fP and \fIA2\fP, or neither of them.
.P
.cs R
.cs I
.nf
"(" \fIA\fP ")"
.fi
.cs R
.cs I
.IP
an action of the LTS satisfies this formula iff it satisfies \fIA\fP.
Parentheses are useful for imposing an evaluation order of subformulas
different from the order given by the associativity and precedence of
operators.
.P
If an action pattern \fIAP\fP occurs as operand of a unary or binary boolean
operator, none of the data variables declared by the pattern offers of
\fIAP\fP is exported to the enclosing formula (e.g., action formula
\fBnot { Send ?msg:nat }\fP does not export variable \fImsg\fP to the enclosing
formula). In other words, only the action formulas consisting of action
patterns can export data variables to the enclosing formula (see also REGULAR
FORMULAS and the description of modalities in STATE FORMULAS below).

.SH REGULAR FORMULAS
A \fIregular formula\fP is a logical formula built from action
formulas, traditional and extended regular expression operators, and
data-handling constructs inspired from functional programming languages.
The syntax of \fIMCL\fP regular formulas is defined by the following grammar:
.P
.cs 4 23
.cs I 23
.nf
\fB\fIR\fP	::=  \fIA\fP

	 |   "nil"

	 |   \fIR1\fP "." \fIR2\fP

	 |   \fIR1\fP "|" \fIR2\fP

	 |   \fIR\fP "*"

	 |   \fIR\fP "+"

	 |   \fIR\fP "?"

	 |   \fIR\fP "{" \fIE\fP "}"

	 |   \fIR\fP "{" \fIE\fP "..." "}"

	 |   \fIR\fP "{" \fIE\fP "," "}"

	 |   \fIR\fP "{" \fIE1\fP "..." \fIE2\fP "}"

	 |   \fIR\fP "{" \fIE1\fP "," \fIE2\fP "}"

	 |   "let" \fIX0\fP ":" \fIT0\fP ":=" \fIE0\fP "," ... "," \fIXn\fP ":" \fITn\fP ":=" \fIEn\fP "in"
	         \fIR\fP
	     "end" "let"

	 |   "if" \fIF0\fP "then"
	         \fIR0\fP
	     [ "elsif" \fIF1\fP "then"
	         \fIR1\fP
	       ...
	       "elsif" \fIFn\fP "then"
	         \fIRn\fP
	       "else"
	         \fIRn+1\fP ]
	     "end" "if"

	 |   "case" \fIE\fP "in"
	         \fIP0\fP [ "where" \fIE0\fP ] "->" \fIR0\fP
	         ...
	     "|" \fIPn\fP [ "where" \fIEn\fP ] "->" \fIRn\fP
	     "end" "case"

	 |   "choice" \fIX0\fP ":" \fIT0\fP [ "among" "{" \fIE01\fP "..." \fIE02\fP "}" ]
	              "," ... ","
	              \fIXn\fP ":" \fITn\fP [ "among" "{" \fIEn1\fP "..." \fIEn2\fP "}" ]
	     "in"
	         \fIR\fP
	     "end" "choice"

	 |   "while" \fIF\fP "do"
	         \fIR\fP
	     "end" "while"

	 |   "repeat"
	         \fIR\fP
	     "until" \fIF\fP "end" "repeat"

	 |   "for" \fIX\fP ":" \fIT\fP "from" \fIE1\fP "to" \fIE2\fP [ "step" \fIE3\fP ] "do"
	         \fIR\fP
	     "end" "for"

	 |   "loop" [ "(" \fIX0\fP ":" \fIT0\fP ":=" \fIE0\fP "," ... "," \fIXn\fP ":" \fITn\fP ":=" \fIEn\fP ")" ]
	            [ ":" "(" \fIX'0\fP ":" \fIT'0\fP "," ... "," \fIX'm\fP ":" \fIT'm\fP ")" ]
	     "in"
	         \fIR\fP
	     "end" "loop"

	 |   "continue" [ "(" \fIE0\fP "," ..."," \fIEn\fP ")" ]

	 |   "exit" [ "(" \fIE0\fP "," ... "," \fIEm\fP ")" ]

	 |   "export" "(" \fIX0\fP ":" \fIT0\fP ":=" \fIE0\fP "," ... "," \fIXn\fP ":" \fITn\fP ":=" \fIEn\fP ")"

	 |   "(" \fIR\fP ")"\fR
.fi
.cs 4
.cs I
.P
Syntactically, all binary operators on regular formulas are
left-associative. The "\fB*\fP", "\fB+\fP", "\fB?\fP", and
"\fB{\fP ... \fB}\fP" operators have the highest precedence,
followed by "\fB.\fP", followed by "\fB|\fP".
.P
A regular formula \fIR\fP denotes a sequence (represented by the couple
of its source and target states) of consecutive LTS transitions such that
the word obtained by concatenating the actions labeling them belongs to
the regular language defined by \fIR\fP.
.P
A transition sequence \fIweakly satisfies\fP a regular formula
\fIR\fP iff, by deleting some of its invisible transitions, the resulting
sub-sequence satisfies \fIR\fP. In other words, the transitions of the
sequence matched by the action predicates of \fIR\fP (which can denote either
visible or invisible actions) can be interspersed with sub-sequences of 0
or more invisible transitions.
.P
The semantics of \fIMCL\fP regular formulas is described informally below.
.P
.cs R
.cs I
.nf
\fIA\fP
.fi
.cs R
.cs I
.IP
is the action regular formula, which denotes one-step transition sequences.
It is satisfied by a sequence of LTS transitions iff this sequence consists
of a single transition labeled by an action satisfying the action formula
\fIA\fP.
.sp
All data variables exported by \fIA\fP are also exported to the enclosing
formula.
.P
.cs R
.cs I
.nf
"nil"
.fi
.cs R
.cs I
.IP
is the null regular formula, which denotes empty transition sequences.
It is satisfied by any sequence of LTS transitions that is empty, i.e., it
contains no transitions. An empty sequence has identical source and target
states.
.P
.cs R
.cs I
.nf
\fIR1\fP "." \fIR2\fP
.fi
.cs R
.cs I
.IP
is the concatenation regular formula, which denotes the concatenation of two
transition sequences. It is satisfied by a sequence of LTS transitions iff
this sequence consists of a first sub-sequence concatenated with a second
one (the target state of the first sub-sequence being the source state of the
second one), the first sub-sequence satisfying \fIR1\fP and the second one
satisfying \fIR2\fP.
.sp
All data variables exported by \fIR1\fP are visible in \fIR2\fP.
For each data variable \fIX\fP exported by both \fIR1\fP and \fIR2\fP, the
occurrence of \fIX\fP exported by \fIR2\fP is also exported to the enclosing
formula (i.e., it overrides the occurrence of \fIX\fP possibly exported
by \fIR1\fP). All the other data variables (i.e., those exported by \fIR1\fP
only and by \fIR2\fP only) are also exported to the enclosing formula.
.P
.cs R
.cs I
.nf
\fIR1\fP "|" \fIR2\fP
.fi
.cs R
.cs I
.IP
is the choice regular formula, which denotes the choice between two transition
sequences. It is satisfied by a sequence of LTS transitions iff this sequence
satisfies \fIR1\fP or it satisfies \fIR2\fP.
.sp
None of the data variables exported by \fIR1\fP (resp. by \fIR2\fP) is
visible in \fIR2\fP (resp. in \fIR1\fP). All data variables exported both
by \fIR1\fP and by \fIR2\fP are also exported to the enclosing formula.
.P
.cs R
.cs I
.nf
\fIR\fP "*"
.fi
.cs R
.cs I
.IP
is the repetition regular formula, which denotes the repetition of a
transition sequence 0 or more times (transitive reflexive closure).
It is satisfied by a sequence of LTS transitions iff this sequence consists
of the concatenation of 0 or more sub-sequences, each of them satisfying
\fIR\fP. Note that any empty sequence satisfies the repetition formula.
.sp
None of the data variables exported by \fIR\fP is exported to the enclosing
formula, since none of these variables will be initialized when the repetition
formula is satisfied by an empty sequence.
.P
.cs R
.cs I
.nf
\fIR\fP "+"
.fi
.cs R
.cs I
.IP
is the strict repetition regular formula, which denotes the repetition of a
transition sequence 1 or more times (transitive closure). It is satisfied by
a sequence of LTS transitions iff this sequence consists of the concatenation
of 1 or more sub-sequences, each of them satisfying \fIR\fP.
.sp
All data variables exported by \fIR\fP are also exported to the enclosing
formula, since \fIR\fP is always satisfied by at least one sub-sequence of
the current sequence.
.P
.cs R
.cs I
.nf
\fIR\fP "?"
.fi
.cs R
.cs I
.IP
is the option regular formula, which denotes the optional occurrence of a
transition sequence (i.e., its repetition 0 or 1 times). It is satisfied by
a sequence of LTS transitions iff this sequence is empty or it satisfies
\fIR\fP.
.sp
None of the data variables exported by \fIR\fP is exported to the enclosing
formula, since none of these variables will be initialized when the option
formula is satisfied by an empty sequence.
.P
.cs R
.cs I
.nf
\fIR\fP "{" \fIE\fP "}"
.fi
.cs R
.cs I
.IP
is the counting regular formula, which denotes the repetition of a transition
sequence \fIE\fP times, where \fIE\fP must be of type \fBnat\fP. It is
satisfied by a sequence of LTS transitions iff this sequence is the
concatenation of exactly \fIE\fP sub-sequences, each of them satisfying
\fIR\fP.
.sp
None of the data variables exported by \fIR\fP is exported to the enclosing
formula, since none of these variables will be initialized when the value of
\fIE\fP is 0 (i.e., when the counting formula is satisfied by an empty
sequence).
.P
.cs R
.cs I
.nf
\fIR\fP "{" \fIE\fP "..." "}"
.fi
or
.cs R
.cs I
.nf
\fIR\fP "{" \fIE\fP "," "}"
.fi
.cs R
.cs I
.IP
is the left interval counting regular formula, which denotes the repetition
of a transition sequence at least \fIE\fP times, where \fIE\fP must be of
type \fBnat\fP. It is satisfied by a sequence of LTS transitions iff this
sequence is the concatenation of \fIE\fP or more sub-sequences, each of them
satisfying \fIR\fP.
.sp
None of the data variables exported by \fIR\fP is exported to the enclosing
formula, since none of these variables will be initialized when the value of
\fIE\fP is 0 (i.e., when the left interval counting formula is satisfied
by an empty sequence).
.P
.cs R
.cs I
.nf
\fIR\fP "{" \fIE1\fP "..." \fIE2\fP "}"
.fi
or
.cs R
.cs I
.nf
\fIR\fP "{" \fIE1\fP "," \fIE2\fP "}"
.fi
.cs R
.cs I
.IP
is the interval counting regular formula, which denotes the repetition of a
transition sequence at least \fIE1\fP times and at most \fIE2\fP times,
where \fIE1\fP and \fIE2\fP must be of type \fBnat\fP. It is satisfied by a
sequence of LTS transitions iff this sequence is the concatenation of
\fIE1\fP or more (but not more than \fIE2\fP) sub-sequences, each of them
satisfying \fIR\fP.
.sp
If the value of \fIE1\fP is equal to the value of \fIE2\fP, the regular
formula is equivalent to \fIR\fP \fB{\fP \fIE1\fP \fB}\fP.
.sp
If the value of \fIE1\fP is larger than the value of \fIE2\fP, the regular
formula is equivalent to \fBnil\fP.
.sp
None of the data variables exported by \fIR\fP is exported to the enclosing
formula, since none of these variables will be initialized when the value of
\fIE1\fP is 0 (i.e., when the interval counting formula is satisfied
by an empty sequence).
.P
.cs R
.cs I
.nf
"let" \fIX0\fP ":" \fIT0\fP ":=" \fIE0\fP "," ... "," \fIXn\fP ":" \fITn\fP ":=" \fIEn\fP "in"
    \fIR\fP
"end" "let"
.fi
.cs R
.cs I
.IP
is the variable definition regular formula, which declares and initializes
data variables. It is satisfied by a sequence of LTS transitions iff this
sequence satisfies the regular formula \fIR\fP in which all occurrences of
variables \fIX0\fP, ..., \fIXn\fP are substituted with the values of the
expressions \fIE0\fP, ..., \fIEn\fP, respectively. Each expression \fIEi\fP
must be of type \fITi\fP for 0 <= \fIi\fP <= \fIn\fP.
.sp
Variables \fIX0\fP, ..., \fIXn\fP are visible in \fIR\fP but not in the
enclosing formula. All data variables exported by \fIR\fP are also exported
to the enclosing formula (regardless of whether or not they are identical
to some of the variables \fIX0\fP, ..., \fIXn\fP).
.P
.cs R
.cs I
.nf
"if" \fIF0\fP "then"
    \fIR0\fP
[ "elsif" \fIF1\fP "then"
    \fIR1\fP
  ...
  "elsif" \fIFn\fP "then"
    \fIRn\fP
  "else"
    \fIRn+1\fP ]
"end" "if"
.fi
.cs R
.cs I
.IP
is the conditional regular formula, which denotes the conditional branching
between several alternative transition sequences depending whether their
source states satisfy or not certain state formulas.
It is satisfied by a sequence of LTS transitions iff the source state of
this sequence satisfies \fIF0\fP and the sequence satisfies \fIR0\fP, or
the source state of this sequence satisfies \fIF1\fP (if present) and the
sequence satisfies \fIR1\fP, ..., or the source state of this sequence
satisfies \fIFn\fP (if present) and the sequence satisfies \fIRn\fP, or
the sequence satisfies \fIRn+1\fP (if present).
.sp
All state formulas \fIF0\fP, ..., \fIFn\fP occurring as conditions of
the branches must be propositionally closed (i.e., they cannot contain free
occurrences of propositional variables, but may contain free occurrences of
data variables) in order to ensure the syntactic monotonicity condition
(see STATE FORMULAS below) for the whole \fIMCL\fP formula.
.sp
The branches "\fBelsif\fP" and "\fBelse\fP" are optional; if they
are all absent and the source state of the sequence does not satisfy \fIF0\fP,
then the empty sequence consisting of that state satisfies the conditional
formula. In other words, the following equality holds:
.sp
.nf
    "if" \fIF\fP "then" \fIR\fP "end if"

    =

    "if" \fIF\fP "then" \fIR\fP "else" "nil" "end" "if"
.fi
.sp
If the "\fBelse\fP" clause is absent, none of the data variables exported
by the regular formulas \fIR0\fP, ..., \fIRn\fP is exported to the enclosing
formula, since none of these variables will be initialized when the
conditional formula is satisfied by an empty sequence. If the "\fBelse\fP"
clause is present, each data variable exported simultaneously by all regular
formulas \fIR0\fP, ..., \fIRn+1\fP is also exported to the enclosing formula.
.P
.cs R
.cs I
.nf
"case" \fIE\fP "in"
    \fIP0\fP [ "where" \fIE0\fP ] "->" \fIR0\fP
    ...
"|" \fIPn\fP [ "where" \fIEn\fP ] "->" \fIRn\fP
"end" "case"
.fi
.cs R
.cs I
.IP
is the selection regular formula, which denotes the selection between several
alternative transition sequences depending whether the value \fIv\fP of
\fIE\fP matches or not certain patterns.
It is satisfied by a sequence of LTS transitions iff this sequence matches
one of the branches 0, ..., \fIn\fP of the selection, in this order.
A sequence matches a branch \fIi\fP iff the following conditions hold:
.sp
- \fIv\fP matches the pattern \fIPi\fP;
.sp
- the boolean expression \fIEi\fP (if present) evaluates to true in a
context in which all variables declared in \fIPi\fP are replaced with the
corresponding values extracted from \fIv\fP;
.sp
- the sequence satisfies \fIRi\fP in the same context.
.sp
If the value of \fIE\fP does not match any of the patterns
\fIP0\fP, ..., \fIPn\fP, then an empty sequence satisfies the selection
formula. In other words, in this case the selection formula becomes
equivalent to "\fBnil\fP".
.sp
If some pattern \fIPi\fP for some 0 <= \fIi\fP <= \fIn\fP is \fBany\fP,
then each data variable exported simultaneously by all regular formulas
\fIR0\fP, ..., \fIRi\fP is also exported to the enclosing formula, since
at least one of these regular formulas will be satisfied by the current
sequence. If none of the patterns \fIPi\fP is \fBany\fP, then none of the
data variables exported by the regular formulas \fIR0\fP, ..., \fIRn\fP
is exported to the enclosing formula, since none of these variables will
be initialized when the selection formula is satisfied by an empty sequence.
.sp
Note: For technical reasons (syntactic ambiguity concerning the "\fB|\fP"
symbol occurring both as choice operator and as branch separator), formulas
\fIR0\fP, ..., \fIRn\fP must \fInot\fP contain the "\fB|\fP" operator at
top-level. For instance, the following formula is illegal:
.nf
    case E in
        P0 -> R1 | R2
    |   P1 -> R3
    end case
.fi
If regular formulas with the "\fB|\fP" operator at top-level are required
as branches of a selection formula, then they must be surrounded
by parentheses, as in the formula below:
.nf
    case E in
        P0 -> (R1 | R2)
    |   P1 -> R3
    end case
.fi
which is legal.
.P
.cs R
.cs I
.nf
"choice" \fIX0\fP ":" \fIT0\fP [ "among" "{" \fIE01\fP "..." \fIE02\fP "}" ]
         "," ... ","
         \fIXn\fP ":" \fITn\fP [ "among" "{" \fIEn1\fP "..." \fIEn2\fP "}" ]
"in"
    \fIR\fP
"end" "choice"
.fi
.cs R
.cs I
.IP
is the generalized choice regular formula, which denotes the choice among
several alternative transition sequences depending whether data variables
belong or not to certain domains. It is satisfied by
a sequence of LTS transitions iff for each 0 <= \fIi\fP <= \fIn\fP there
exists at least a value \fIvi\fP of type \fITi\fP in the domain delimited by
the values of \fIEi1\fP and \fIEi2\fP (if present) such that the sequence
satisfies the regular formula \fIR\fP in which all occurrences of variables
\fIX0\fP, ..., \fIXn\fP are substituted with the values
\fIv0\fP, ..., \fIvn\fP, respectively. The optional expressions \fIEi1\fP
and \fIEi2\fP must be of type \fITi\fP for 0 <= \fIi\fP <= \fIn\fP.
Only the types \fBbool\fP and \fBnat\fP are allowed currently as \fITi\fPs.
.sp
All data variables exported by \fIR\fP are also exported
to the enclosing formula (regardless of whether or not they are identical
to some of the variables \fIX0\fP, ..., \fIXn\fP).
.P
.cs R
.cs I
.nf
"while" \fIF\fP "do"
    \fIR\fP
"end" "while"
.fi
.cs R
.cs I
.IP
is the initial condition loop regular formula, which denotes the repetition
of a regular sub-sequence as long as its source state satisfies a certain state
formula. It is satisfied by a sequence of LTS transitions iff this sequence
consists of the concatenation of 0 or more sub-sequences such that the source
state of each sub-sequence satisfies \fIF\fP and each sub-sequence satisfies
\fIR\fP.
.sp
None of the data variables exported by \fIR\fP is exported to the enclosing
formula, since none of these variables will be initialized when the initial
condition loop formula is satisfied by an empty sequence (whose source state
does not satisfy \fIF\fP).
.P
.cs R
.cs I
.nf
"repeat"
    \fIR\fP
"until" \fIF\fP "end" "repeat"
.fi
.cs R
.cs I
.IP
is the final condition loop regular formula, which denotes the repetition
of a regular sub-sequence until its target state satisfies a certain state
formula. It is satisfied by a sequence of LTS transitions iff this sequence
consists of the concatenation of 1 or more sub-sequences such that the target
state of each sub-sequence satisfies \fIF\fP and each sub-sequence satisfies
\fIR\fP.
.sp
All data variables exported by \fIR\fP are also exported to the enclosing
formula, since \fIR\fP is always satisfied by at least one sub-sequence of
the current sequence (the body of the final condition loop formula is repeated
at least once).
.P
.cs R
.cs I
.nf
"for" \fIX\fP ":" \fIT\fP "from" \fIE1\fP "to" \fIE2\fP [ "step" \fIE3\fP ] "do"
    \fIR\fP
"end" "for"
.fi
.cs R
.cs I
.IP
is the bounded loop regular formula, which denotes the repetition of a regular
sub-sequence depending on the values taken by variable \fIX\fP in an interval.
It is satisfied by a sequence of LTS transitions iff this sequence
consists of the concatenation of 0 or more sub-sequences, such that each
sub-sequence satisfies the regular formula \fIR\fP for the current value of
variable \fIX\fP (which may occur or not in \fIR\fP).
The expressions \fIE1\fP, \fIE2\fP, and \fIE3\fP must be of type \fIT\fP.
At the first iteration of the loop, \fIX\fP is initialized with the value of
\fIE1\fP. At each sub-sequent iteration, \fIX\fP is incremented either by 
the value of \fIE3\fP if the optional clause "step" is present, or by 1
otherwise. The loop terminates when \fIX\fP becomes strictly greater than
the value of \fIE2\fP.
.sp
None of the data variables exported by \fIR\fP is exported to the enclosing
formula, since none of these variables will be initialized when the bounded
loop formula is satisfied by an empty sequence.
.sp
The type \fIT\fP of the iteration variable can be currently the \fBnat\fP
type only.
.P
.cs R
.cs I
.nf
"loop" [ "(" \fIX0\fP ":" \fIT0\fP ":=" \fIE0\fP "," ... "," \fIXn\fP ":" \fITn\fP ":=" \fIEn\fP ")" ]
       [ ":" "(" \fIX'0\fP ":" \fIT'0\fP "," ... "," \fIX'm\fP ":" \fIT'm\fP ")" ]
"in"
    \fIR\fP
"end" "loop"
.fi
.cs R
.cs I
.IP
is the general loop regular formula, which denotes the repetition of a regular
sub-sequence satisfying \fIR\fP depending on the values of the optional
input parameters \fIX0\fP, ..., \fIXn\fP. These parameters are
initialized at the start of the loop with the values of expressions
\fIE0\fP, ..., \fIEn\fP, which must be of types
\fIT0\fP, ..., \fITn\fP, respectively.
Upon termination of the loop, the optional output parameters
\fIX'0\fP, ..., \fIX'm\fP are assigned appropriate values and are exported
to the enclosing formula.
.sp
An iteration of the loop is triggered when the
evaluation of \fIR\fP on a sub-sequence of the current sequence leads to
the evaluation of a "continue" subformula of \fIR\fP (see below), which must
assign values to the input parameters \fIX0\fP, ..., \fIXn\fP.
The loop terminates when the evaluation of \fIR\fP on a sub-sequence of
the current sequence either does not lead to the evaluation of a "continue"
subformula (in this case the loop must not have output parameters), or it
leads to the evaluation of an "exit" subformula of \fIR\fP (see below),
which must assign values to the output parameters \fIX'0\fP, ..., \fIX'm\fP.
.sp
None of the data variables exported by \fIR\fP is exported to the enclosing
formula, since none of these variables will be initialized when the general
loop formula is satisfied by an empty sequence.
.P
.cs R
.cs I
.nf
"continue" [ "(" \fIE0\fP "," ..."," \fIEn\fP ")" ]
.fi
.cs R
.cs I
.IP
is the continuation regular formula, which denotes the general loop repetition.
It can occur only in the scope of a "loop" regular formula. If present,
the optional expressions
\fIE0\fP, ..., \fIEn\fP must be of the same types \fIT0\fP, ..., \fITn\fP as
the input parameters \fIX0\fP, ..., \fIXn\fP of the immediately enclosing
"loop" formula. The continuation formula is always satisfied by an LTS
sequence and triggers an iteration of the immediately enclosing "loop"
formula, the input parameters of which are assigned the values of the
expressions \fIE0\fP, ..., \fIEn\fP, respectively.
.P
.cs R
.cs I
.nf
"exit" [ "(" \fIE0\fP "," ... "," \fIEm\fP ")" ]
.fi
.cs R
.cs I
.IP
is the termination regular formula, which denotes the general loop termination.
It can occur only in the scope of a "loop" regular formula. If present,
the optional expressions
\fIE0\fP, ..., \fIEm\fP must be of the same types \fIT'0\fP, ..., \fIT'm\fP as
the output parameters \fIX'0\fP, ..., \fIX'm\fP of the immediately enclosing
"loop" formula. The termination formula is always satisfied by an LTS
sequence and triggers the termination of the immediately enclosing "loop"
formula, the output parameters of which are exported to the enclosing formula
after being assigned the values of the expressions \fIE0\fP, ..., \fIEm\fP,
respectively.
.P
.cs R
.cs I
.nf
"export" "(" \fIX0\fP ":" \fIT0\fP ":=" \fIE0\fP "," ... "," \fIXn\fP ":" \fITn\fP ":=" \fIEn\fP ")"
.fi
.cs R
.cs I
.IP
is the exporting regular formula, which assigns the values of expressions
\fIE0\fP, ..., \fIEn\fP to variables \fIX0\fP, ..., \fIXn\fP and exports
them to the enclosing formula. The expressions \fIE0\fP, ..., \fIEn\fP
must be of types \fIT0\fP, ..., \fITn\fP, respectively. The exporting
formula is satisfied by any LTS sequence. It is an abbreviation of the
following "loop" formula:
.sp
.nf
    "loop" "(" \fIX0\fP ":" \fIT0\fP"," ... "," \fIXn\fP ":" \fITn\fP ")" "in"
        "exit" "(" \fIE0\fP "," ... "," \fIEn\fP ")"
    "end" "loop"
.fi
.sp
Note: The "let" regular formula (see above) also assigns values to variables,
but these variables are visible only in the regular subformula of the "let"
formula and are not exported to the enclosing formula.
.P
.cs R
.cs I
.nf
"(" \fIR\fP ")"
.fi
.cs R
.cs I
.IP
a sequence of LTS transitions satisfies this formula iff it satisfies \fIR\fP.
Parentheses are useful for imposing an evaluation order of subformulas
different from the order given by the associativity and precedence of
operators.

.SH STATE FORMULAS
A \fIstate formula\fP is a logical formula built from boolean operators,
modalities, fixed point operators, and data-handling constructs inspired
from functional programming languages. The syntax of \fIMCL\fP state formulas
is defined by the following grammar:
.P
.cs 4 23
.cs I 23
.nf
\fB\fIF\fP	::=  \fIE\fP

	 |   "true"

	 |   "false"

	 |   "not" \fIF\fP

	 |   \fIF1\fP "or" \fIF2\fP

	 |   \fIF1\fP "xor" \fIF2\fP

	 |   \fIF1\fP "and" \fIF2\fP

	 |   \fIF1\fP "implies" \fIF2\fP

	 |   \fIF1\fP "equ" \fIF2\fP

	 |   "<" \fIR\fP ">" \fIF\fP

	 |   "<<" \fIR\fP ">>" \fIF\fP

	 |   "[" \fIR\fP "]" \fIF\fP

	 |   "[[" \fIR\fP "]]" \fIF\fP

	 |   "<" \fIR\fP ">" "@"

	 |   "<<" \fIR\fP ">>" "@"

	 |   "[" \fIR\fP "]" "-|"

	 |   "[[" \fIR\fP "]]" "-|"

	 |   \fIY\fP [ "(" \fIE0\fP "," ... "," \fIEn\fP ")" ]

	 |   "mu" \fIY\fP [ "(" \fIX0\fP ":" \fIT0\fP ":=" \fIE0\fP "," ... ","
	                  \fIXn\fP ":" \fITn\fP ":=" \fIEn\fP ")" ]
	     "." \fIF\fP

	 |   "nu" \fIY\fP [ "(" \fIX0\fP ":" \fIT0\fP ":=" \fIE0\fP "," ... ","
	                  \fIXn\fP ":" \fITn\fP ":=" \fIEn\fP ")" ]
	     "." \fIF\fP

	 |   "exists" \fIX0\fP ":" \fIT0\fP [ "among" "{" \fIE01\fP "..." \fIE02\fP "}" ]
	             "," ... ","
	              \fIXn\fP ":" \fITn\fP [ "among" "{" \fIEn1\fP "..." \fIEn2\fP "}" ]
	     "." \fIF\fP

	 |   "forall" \fIX0\fP ":" \fIT0\fP [ "among" "{" \fIE01\fP "..." \fIE02\fP "}" ]
	              "," ... ","
	              \fIXn\fP ":" \fITn\fP [ "among" "{" \fIEn1\fP "..." \fIEn2\fP "}" ]
	     "." \fIF\fP

	 |   "let" \fIX0\fP ":" \fIT0\fP ":=" \fIE0\fP "," ... "," \fIXn\fP ":" \fITn\fP ":=" \fIEn\fP "in"
	         \fIF\fP
	     "end" "let"

	 |   "if" \fIF0\fP "then"
	         \fIF'0\fP
	     [ "elsif" \fIF1\fP "then"
	         \fIF'1\fP
	       ...
	       "elsif" \fIFn\fP "then"
	         \fIF'n\fP
	       "else"
	         \fIFn+1\fP ]
	     "end" "if"

	 |   "case" \fIE\fP "in"
	         \fIP0\fP [ "where" \fIE0\fP ] "->" \fIF0\fP
	         ...
	     "|" \fIPn\fP [ "where" \fIEn\fP ] "->" \fIFn\fP
	     "end" "case"

	 |   "(" \fIF\fP ")"\fR
\fR
.fi
.cs 4
.cs I
.P
Syntactically, all binary operators on state formulas are left-associative.
The unary operators "\fBnot\fP", "<"...">", "<<"...">>", "["..."]",
"[["..."]]", "mu", "nu", "exists", and "forall" have the highest precedence,
followed by "\fBand\fP", followed by "\fBor\fP" and "\fBxor\fP",
followed by "\fBimplies\fP", followed by "\fBequ\fP".
.P
The minimal and maximal fixed point operators "mu" and "nu" act as binders
for the propositional variables \fIY\fP in a way that is similar to quantifiers
in first-order logic.
In each meaningful "\fBmu\fP \fIY\fP \fB(\fP...\fB)\fP \fB.\fP \fIF\fP"
or "\fBnu\fP \fIY\fP \fB(\fP...\fB)\fP \fB.\fP \fIF\fP" formula,
\fIY\fP is assumed to have free occurrences inside \fIF\fP.
.P
State formulas must satisfy the following two syntactic conditions:
.IP -
\fISyntactic monotonicity\fP [Koz83] means that in each fixed point formula
"\fBmu\fP \fIY\fP \fB(\fP...\fB)\fP \fB.\fP \fIF\fP" or
"\fBnu\fP \fIY\fP \fB(\fP...\fB)\fP \fB.\fP \fIF\fP",
free occurrences of the propositional variable \fIY\fP in \fIF\fP may appear
only under an even number of negations and/or left-hand sides of implications.

.IP -
\fIAlternation-freeness\fP [EL86] means that each fixed point formula
"\fBmu\fP \fIY\fP \fB(\fP...\fB)\fP \fB.\fP \fIF\fP" cannot contain free
occurrences of propositional variables \fIY'\fP defined by "\fBnu\fP"
operators, and each fixed point formula
"\fBnu\fP \fIY\fP \fB(\fP...\fB)\fP \fB.\fP \fIF\fP" cannot contain free
occurrences of propositional variables \fIY'\fP defined by "\fBmu\fP"
operators. When checking this condition on a formula, strong possibility
(resp. necessity) modalities whose regular subformulas contain an iteration
operator, and weak possibility (resp. necessity) modalities are interpreted
as "hidden" minimal (resp. maximal) fixed point operators.
Note that the state formulas corresponding to infinite looping and saturation
operators do not satisfy the alternation-freeness condition
(see REMARKS below).
.P
A state formula defines a predicate over the states of the LTS.
The semantics of \fIMCL\fP state formulas is described informally below.
.P
.cs R
.cs I
.nf
\fIE\fP
.fi
.cs R
.cs I
.IP
a state of the LTS satisfies a boolean expression \fIE\fP
iff \fIE\fP evaluates to \fBtrue\fP.
.P
.cs R
.cs I
.nf
"true"
.fi
.cs R
.cs I
.IP
a state of the LTS always satisfies this formula.
.P
.cs R
.cs I
.nf
"false"
.fi
.cs R
.cs I
.IP
a state of the LTS never satisfies this formula.
.P
.cs R
.cs I
.nf
"not" \fIF\fP
.fi
.cs R
.cs I
.IP
a state of the LTS satisfies this formula iff it does not satisfy \fIF\fP.
.P
.cs R
.cs I
.nf
\fIF1\fP "or" \fIF2\fP
.fi
.cs R
.cs I
.IP
a state of the LTS satisfies this formula iff it satisfies \fIF1\fP or
it satisfies \fIF2\fP.
.P
.cs R
.cs I
.nf
\fIF1\fP "xor" \fIF2\fP
.fi
.cs R
.cs I
.IP
a state of the LTS satisfies this formula iff it satisfies exactly one of
\fIF1\fP and \fIF2\fP.
.P
.cs R
.cs I
.nf
\fIF1\fP "and" \fIF2\fP
.fi
.cs R
.cs I
.IP
a state of the LTS satisfies this formula iff it satisfies both \fIF1\fP
and \fIF2\fP.
.P
.cs R
.cs I
.nf
\fIF1\fP "implies" \fIF2\fP
.fi
.cs R
.cs I
.IP
a state of the LTS satisfies this formula iff it does not satisfy \fIF1\fP
or it satisfies \fIF2\fP.
.P
.cs R
.cs I
.nf
\fIF1\fP "equ" \fIF2\fP
.fi
.cs R
.cs I
.IP
a state of the LTS satisfies this formula iff either it satisfies both
\fIF1\fP and \fIF2\fP, or neither of them.
.P
.cs R
.cs I
.nf
"<" \fIR\fP ">" \fIF\fP
.fi
.cs R
.cs I
.IP
is the possibility modality. It is satisfied by a state of the LTS
iff there is some transition sequence going out of this state that satisfies
the regular formula \fIR\fP and leads to a state satisfying the state formula
\fIF\fP.
.sp
The evaluation of \fIF\fP on the target state of the transition sequence is
carried out in a context in which all data variables exported by \fIR\fP are
initialized with the corresponding values extracted from the sequence.
If there is no transition sequence satisfying \fIR\fP, then the whole
possibility modality is false and \fIF\fP is not evaluated at all.
.sp
All data variables exported by \fIR\fP are visible in \fIF\fP, but none of
them is exported outside the whole possibility modality.
.P
.cs R
.cs I
.nf
"<<" \fIR\fP ">>" \fIF\fP
.fi
.cs R
.cs I
.IP
is the weak possibility modality. It is satisfied by a state of the LTS
iff there is some transition sequence going out of this state that weakly
satisfies the regular formula \fIR\fP and leads to a state satisfying the
state formula \fIF\fP.
.sp
The evaluation of \fIF\fP on the target state of the transition sequence is
carried out in a context in which all data variables exported by \fIR\fP are
initialized with the corresponding values extracted from the sequence.
If there is no transition sequence weakly satisfying \fIR\fP, then the whole
weak possibility modality is false and \fIF\fP is not evaluated at all.
.sp
All data variables exported by \fIR\fP are visible in \fIF\fP, but none of
them is exported outside the whole weak possibility modality.
.sp
The regular formula \fIR\fP must not contain any occurrence of the \fBtau\fP
action formula.
.P
.cs R
.cs I
.nf
"[" \fIR\fP "]" \fIF\fP
.fi
.cs R
.cs I
.IP
is the necessity modality. It is satisfied by a state of the LTS
iff for each transition sequence going out of this state, if this sequence
satisfies the regular formula \fIR\fP, then it must lead to a state satisfying
the state formula \fIF\fP.
.sp
The evaluation of \fIF\fP on the target state of each transition sequence is
carried out in a context in which all data variables exported by \fIR\fP are
initialized with the corresponding values extracted from that sequence.
If there is no transition sequence satisfying \fIR\fP, then the whole
necessity modality is true and \fIF\fP is not evaluated at all.
.sp
All data variables exported by \fIR\fP are visible in \fIF\fP, but none of
them is exported outside the whole necessity modality.
.P
.cs R
.cs I
.nf
"[[" \fIR\fP "]]" \fIF\fP
.fi
.cs R
.cs I
.IP
is the weak necessity modality. It is satisfied by a state of the LTS
iff for each transition sequence going out of this state, if this sequence
weakly satisfies the regular formula \fIR\fP, then it must lead to a state
satisfying the state formula \fIF\fP.
.sp
The evaluation of \fIF\fP on the target state of each transition sequence is
carried out in a context in which all data variables exported by \fIR\fP are
initialized with the corresponding values extracted from that sequence.
If there is no transition sequence weakly satisfying \fIR\fP, then the whole
weak necessity modality is true and \fIF\fP is not evaluated at all.
.sp
All data variables exported by \fIR\fP are visible in \fIF\fP, but none of
them is exported outside the whole weak necessity modality.
.sp
The regular formula \fIR\fP must not contain any occurrence of the \fBtau\fP
action formula.
.P
.cs R
.cs I
.nf
"<" \fIR\fP ">" "@"
.fi
.cs R
.cs I
.IP
is the infinite looping formula. It is satisfied by a state of the LTS
iff there is some transition sequence going out of this state and consisting
of an infinite concatenation of sub-sequences that satisfy the regular formula
\fIR\fP.
.sp
None of the data variables exported by \fIR\fP is exported outside of the
infinite looping formula.
.P
.cs R
.cs I
.nf
"<<" \fIR\fP ">>" "@"
.fi
.cs R
.cs I
.IP
is the weak infinite looping formula. It is satisfied by a state of the
LTS iff there is some transition sequence going out of this state and
consisting of an infinite concatenation of sub-sequences that weakly satisfy
the regular formula \fIR\fP.
.sp
None of the data variables exported by \fIR\fP is exported outside of the
weak infinite looping formula.
.sp
The regular formula \fIR\fP must not contain any occurrence of the \fBtau\fP
action formula.
.P
.cs R
.cs I
.nf
"[" \fIR\fP "]" "-|"
.fi
.cs R
.cs I
.IP
is the finite saturation formula. It is satisfied by a state of the LTS
iff for each transition sequence going out of this state, if this sequence
consists of a concatenation of sub-sequences that satisfy the regular formula
\fIR\fP, then the sequence must be finite.
.sp
None of the data variables exported by \fIR\fP is exported outside of the
finite saturation formula.
.P
.cs R
.cs I
.nf
"[[" \fIR\fP "]]" "-|"
.fi
.cs R
.cs I
.IP
is the weak finite saturation formula. It is satisfied by a state of the
LTS iff for each transition sequence going out of this state, if this sequence
consists of a concatenation of sub-sequences that weakly satisfy the regular
formula \fIR\fP, then the sequence must be finite.
.sp
None of the data variables exported by \fIR\fP is exported outside of the
weak finite saturation formula.
.sp
The regular formula \fIR\fP must not contain any occurrence of the \fBtau\fP
action formula.
.P
.cs R
.cs I
.nf
\fIY\fP [ "(" \fIE0\fP "," ... "," \fIEn\fP ")" ]
.fi
.cs R
.cs I
.IP
is a call of the propositional variable \fIY\fP. It can occur only in
the scope of a fixed point formula defining \fIY\fP. If present, the optional
expressions \fIE0\fP, ..., \fIEn\fP must be of the same types \fIT0\fP, ...,
\fITn\fP as the parameters \fIX0\fP, ..., \fIXn\fP of the corresponding
fixed point formula. The propositional variable call formula is satisfied by
a state of the LTS iff this state belongs to the solution \fIY\fP of the
corresponding fixed point equation, evaluated by assigning the values of the
expressions \fIE0\fP, ..., \fIEn\fP to the parameters \fIX0\fP, ..., \fIXn\fP,
respectively.
.P
.cs R
.cs I
.nf
"mu" \fIY\fP [ "(" \fIX0\fP ":" \fIT0\fP ":=" \fIE0\fP "," ... ","
             \fIXn\fP ":" \fITn\fP ":=" \fIEn\fP ")" ]
"." \fIF\fP
.fi
.cs R
.cs I
.IP
is the parameterized minimal fixed point formula defining the
propositional variable \fIY\fP. The expressions \fIE0\fP, ..., \fIEn\fP must
be of types \fIT0\fP, ..., \fITn\fP, respectively. The formula is satisfied by
a state of the LTS iff this state belongs to the minimal solution of the fixed
point equation \fIY\fP (\fIX0\fP, ..., \fIXn\fP) = \fIF\fP, evaluated by
assigning the values of the expressions \fIE0\fP, ..., \fIEn\fP to the
parameters \fIX0\fP, ..., \fIXn\fP, respectively. The parameters \fIX0\fP, ...,
\fIXn\fP are visible only in \fIF\fP and are not exported outside the minimal
fixed point formula.
.sp
Intuitively, a parameterized minimal fixed point formula characterizes finite
subgraphs contained in the LTS. The parameters enable one to perform arbitrary
computations during a forward traversal of the subgraphs.
.P
.cs R
.cs I
.nf
"nu" \fIY\fP [ "(" \fIX0\fP ":" \fIT0\fP ":=" \fIE0\fP "," ... ","
             \fIXn\fP ":" \fITn\fP ":=" \fIEn\fP ")" ]
"." \fIF\fP
.fi
.cs R
.cs I
.IP
is the parameterized maximal fixed point formula defining the
propositional variable \fIY\fP. The expressions \fIE0\fP, ..., \fIEn\fP must
be of types \fIT0\fP, ..., \fITn\fP, respectively. The formula is satisfied by
a state of the LTS iff this state belongs to the maximal solution of the fixed
point equation \fIY\fP (\fIX0\fP, ..., \fIXn\fP) = \fIF\fP, evaluated by
assigning the values of the expressions \fIE0\fP, ..., \fIEn\fP to the
parameters \fIX0\fP, ..., \fIXn\fP, respectively. The parameters \fIX0\fP, ...,
\fIXn\fP are visible only in \fIF\fP and are not exported outside the maximal
fixed point formula.
.sp
Intuitively, a parameterized maximal fixed point formula characterizes infinite
subgraphs contained in the LTS. The parameters enable one to perform arbitrary
computations during a forward traversal of the subgraphs.
.P
.cs R
.cs I
.nf
"exists" \fIX0\fP ":" \fIT0\fP [ "among" "{" \fIE01\fP "..." \fIE02\fP "}" ]
         "," ... ","
         \fIXn\fP ":" \fITn\fP [ "among" "{" \fIEn1\fP "..." \fIEn2\fP "}" ]
"." \fIF\fP
.fi
.cs R
.cs I
.IP
is the existential quantification over variables \fIX0\fP, ..., \fIXn\fP.
It is satisfied by a state of the LTS iff there exists a combination of values
\fIv0\fP, ..., \fIvn\fP belonging to the types \fIT0\fP, ..., \fITn\fP
(possibly restricted to the optional domains delimited by the values of
\fIE01\fP, \fIE02\fP, ..., \fIEn1\fP, \fIEn2\fP if present) such that
this state satisfies the state formula \fIF\fP in which all occurrences of
variables \fIX0\fP, ..., \fIXn\fP are substituted with the values
\fIv0\fP, ..., \fIvn\fP, respectively. The optional expressions \fIEi1\fP
and \fIEi2\fP must be of type \fITi\fP for 0 <= \fIi\fP <= \fIn\fP.
Only the types \fBbool\fP and \fBnat\fP are allowed currently as \fITi\fPs.
.sp
The variables \fIX0\fP, ..., \fIXn\fP are visible only in \fIF\fP and are not
exported outside the existential quantification formula.
.sp
Note: The existential quantifier is not, strictly speaking, a primitive operator
of \fIMCL\fP. It can be seen as an abbreviation of the disjunction operator.
Assuming that the domain of variable \fIXi\fP is
\fB{\fP \fIvi0\fP, ... \fIvimi\fP \fB}\fP for 0 <= \fIi\fP <= \fIn\fP,
the existential quantification formula is equivalent to the disjunction below:
.sp
.nf
    \fIF\fP (\fIv00\fP, ..., \fIvn0\fP) or ... or \fIF\fP (\fIv00\fP, ..., \fIvnmn\fP)
    or ... or
    \fIF\fP (\fIv0m0\fP, ..., \fIvn0\fP) or ... or \fIF\fP (\fIv0m0\fP, ..., \fIvnmn\fP)
.fi
.sp
where \fIF\fP (\fIv0j\fP, ..., \fIvnk\fP) denotes the state formula \fIF\fP
in which all occurrences of variables \fIX0\fP, ..., \fIXn\fP are substituted
with the values \fIv0j\fP, ..., \fIvnk\fP, respectively. In practice, the
usage of the existential quantifier may yield much more concise formulations
of properties than its equivalent disjunctive formulation.
.P
.cs R
.cs I
.nf
"forall" \fIX0\fP ":" \fIT0\fP [ "among" "{" \fIE01\fP "..." \fIE02\fP "}" ]
         "," ... ","
         \fIXn\fP ":" \fITn\fP [ "among" "{" \fIEn1\fP "..." \fIEn2\fP "}" ]
"." \fIF\fP
.fi
.cs R
.cs I
.IP
is the universal quantification over variables \fIX0\fP, ..., \fIXn\fP.
It is satisfied by a state of the LTS iff for every combination of values
\fIv0\fP, ..., \fIvn\fP belonging to the types \fIT0\fP, ..., \fITn\fP
(possibly restricted to the optional domains delimited by the values of
\fIE01\fP, \fIE02\fP, ..., \fIEn1\fP, \fIEn2\fP if present), this
state satisfies the state formula \fIF\fP in which all occurrences of
variables \fIX0\fP, ..., \fIXn\fP are substituted with the values
\fIv0\fP, ..., \fIvn\fP, respectively. The optional expressions \fIEi1\fP
and \fIEi2\fP must be of type \fITi\fP for 0 <= \fIi\fP <= \fIn\fP.
Only the types \fBbool\fP and \fBnat\fP are allowed currently as \fITi\fPs.
.sp
The variables \fIX0\fP, ..., \fIXn\fP are visible only in \fIF\fP and are not
exported outside the universal quantification formula.
.sp
Note: The universal quantifier is not, strictly speaking, a primitive operator
of \fIMCL\fP. It can be seen as an abbreviation of the conjunction operator.
Assuming that the domain of variable \fIXi\fP is
\fB{\fP \fIvi0\fP, ... \fIvimi\fP \fB}\fP for 0 <= \fIi\fP <= \fIn\fP,
the universal quantification formula is equivalent to the conjunction below:
.sp
.nf
    \fIF\fP (\fIv00\fP, ..., \fIvn0\fP) and ... and \fIF\fP (\fIv00\fP, ..., \fIvnmn\fP)
    and ... and
    \fIF\fP (\fIv0m0\fP, ..., \fIvn0\fP) and ... and \fIF\fP (\fIv0m0\fP, ..., \fIvnmn\fP)
.fi
.sp
where \fIF\fP (\fIv0j\fP, ..., \fIvnk\fP) denotes the state formula \fIF\fP
in which all occurrences of variables \fIX0\fP, ..., \fIXn\fP are substituted
with the values \fIv0j\fP, ..., \fIvnk\fP, respectively. In practice, the
usage of the universal quantifier may yield much more concise formulations
of properties than its equivalent conjunctive formulation.
.P
.cs R
.cs I
.nf
"let" \fIX0\fP ":" \fIT0\fP ":=" \fIE0\fP "," ... "," \fIXn\fP ":" \fITn\fP ":=" \fIEn\fP "in"
      \fIF\fP
"end" "let"
.fi
.cs R
.cs I
.IP
is the variable definition state formula, which declares and initializes
data variables.
It is satisfied by a state of the LTS iff this state satisfies the state
formula \fIF\fP in which all occurrences of variables
\fIX0\fP, ..., \fIXn\fP are substituted with the values of the expressions
\fIE0\fP, ..., \fIEn\fP, respectively. Each expression \fIEi\fP must be of
type \fITi\fP for 0 <= \fIi\fP <= \fIn\fP.
.sp
The variables \fIX0\fP, ..., \fIXn\fP are visible only in \fIF\fP and are not
exported outside the variable definition formula.
.P
.cs R
.cs I
.nf
"if" \fIF0\fP "then"
     \fIF'0\fP
[ "elsif" \fIF1\fP "then"
     \fIF'1\fP
  ...
  "elsif" \fIFn\fP "then"
     \fIF'n\fP
  "else"
     \fIFn+1\fP ]
"end" "if"
.fi
.cs R
.cs I
.IP
is the conditional state formula, which denotes the branching
according to certain state formulas.
It is satisfied by a state of the LTS iff either this state satisfies \fIF0\fP
and it also satisfies \fIF'0\fP, or this state satisfies \fIF1\fP (if present)
and it also satisfies \fIF'1\fP, ..., or this state satisfies \fIFn\fP
(if present) and it also satisfies \fIF'n\fP, or this state satisfies
\fIFn+1\fP (if present).
.sp
All state formulas \fIF0\fP, ..., \fIFn\fP occurring as conditions of
the branches must be propositionally closed (i.e., they cannot contain free
occurrences of propositional variables, but may contain free occurrences of
data variables) in order to ensure the syntactic monotonicity condition for
the whole \fIMCL\fP formula.
.sp
The branches "\fBelsif\fP" and "\fBelse\fP" are optional; if they
are all absent and the state does not satisfy \fIF0\fP, then this state
satisfies the conditional formula.
In other words, the following equality holds:
.sp
.nf
    "if" \fIF0\fP "then" \fIF'0\fP "end if"

    =

    "if" \fIF0\fP "then" \fIF'0\fP "else" "true" "end" "if"
.fi
.P
.cs R
.cs I
.nf
"case" \fIE\fP "in"
    \fIP0\fP [ "where" \fIE0\fP ] "->" \fIF0\fP
    ...
"|" \fIPn\fP [ "where" \fIEn\fP ] "->" \fIFn\fP
"end" "case"
.fi
.cs R
.cs I
.IP
is the selection state formula, which denotes the selection between several
alternatives depending on whether the
value \fIv\fP of \fIE\fP matches or not certain patterns.
It is satisfied by a state of the LTS iff this state matches one of the
branches 0, ..., \fIn\fP of the selection, in this order.
A state matches a branch \fIi\fP iff the following conditions hold:
.sp
- \fIv\fP matches the pattern \fIPi\fP;
.sp
- the boolean expression \fIEi\fP (if present) evaluates to true in a context
in which all variables declared in \fIPi\fP are replaced with the corresponding
values extracted from \fIv\fP;
.sp
- the state satisfies \fIFi\fP in the same context.
.sp
If the value of \fIE\fP does not match any of the patterns
\fIP0\fP, ..., \fIPn\fP, then the selection formula is true.
.P
.cs R
.cs I
.nf
"(" \fIF\fP ")"
.fi
.cs R
.cs I
.IP
a state of the LTS satisfies this formula iff it satisfies \fIF\fP.
Parentheses are useful for imposing an evaluation order of subformulas
different from the order given by the associativity and precedence of
operators.
.P
An LTS satisfies a state formula \fIF\fP iff its initial state \fIs0\fP
satisfies \fIF\fP.

.SH REMARKS

When writing complex formulas containing many operators (especially
when mixing regular and boolean operators), it is safer to use
parentheses to enclose subformulas whenever being in doubt about the
relative precedence of the operators. Otherwise, the tool may parse
and evaluate the formulas in a way different from the user's intentions,
leading to erroneous results that may be quite difficult to track down.
.P
Not all operators defined above are primitive constructs of the logic.
The boolean operators "\fBfalse\fP", "\fBand\fP", "\fBimplies\fP", and "\fBequ\fP" can
be expressed in terms of "\fBtrue\fP", "\fBor\fP", and "\fBnot\fP" in the usual way.
The diamond and box modalities are dual:
.sp
.nf
 \fB   [ \fIR\fP ] \fIF\fP   = not < \fIR\fP >   not \fIF\fP\fR
 \fB   [[ \fIR\fP ]] \fIF\fP = not << \fIR\fP >> not \fIF\fP\fR
.fi
.P
The same holds for minimal and maximal fixed point operators
(only parameterless versions are illustrated below):
.sp
.nf
 \fB   nu \fIY\fP . \fIF\fP = not mu \fIY\fP . not \fIF\fP (not \fIY\fP)\fR
.fi
.sp
where \fIF\fP \fB(not\fP \fIY\fP\fB)\fP denotes the syntactic substitution of
\fIY\fP by \fBnot\fP \fIY\fP in \fIF\fP.
.P
The infinite looping operator and the finite saturation operator are opposites:
.sp
.nf
 \fB   < \fIR\fP > @   = not [ \fIR\fP ]   -|
    << \fIR\fP >> @ = not [[ \fIR\fP ]] -|\fR
.fi
.P
The modalities containing regular formulas can be translated in terms
of boolean operators, fixed point operators, and modalities containing
only action formulas (see [MS03,MT08] for details).
.P
The infinite looping and finite saturation operators correspond to fixed
point formulas belonging to the mu-calculus fragment of alternation depth
two [EL86]. In practice, this means that one can write formulas
"\fB<\fP \fIR\fP \fB>\fP \fB@\fP" in which the regular subformula \fIR\fP
contains iteration operators. This feature is supported by \fBevaluator4\fP,
but was not available in \fBevaluator3\fP, which accepted only
"\fB<\fP \fIR\fP \fB>\fP \fB@\fP" formulas containing iteration-free
regular subformulas \fIR\fP.
.P
\fBevaluator4\fP handles the equivalent fixed point formulations of
infinite looping and saturation operators, which can be used directly instead
of these operators:
.sp
.nf
 \fB   < \fIR\fP > @    = nu \fIY\fP . < \fIR\fP > \fIY\fP
    << \fIR\fP >> @  = nu \fIY\fP . << \fIR\fP >> \fIY\fP
    [ \fIR\fP ] -|   = mu \fIY\fP . [ \fIR\fP ] \fIY\fP
    [[ \fIR\fP ]] -| = mu \fIY\fP . [[ \fIR\fP ]] \fIY\fP\fR
.fi
.P
Moreover, in the fixed point formulas equivalent to infinite looping and
saturation operators, \fBevaluator4\fP accepts propositional variables
\fIY\fP parameterized by data values (see FAIRNESS PROPERTIES below).
.P
For efficiency reasons, when using fixed point operators, it is
recommended to put the recursive call of the propositional variable
at the rightmost place in the formula (as in all fixed point formulas
shown above). This reduces both the evaluation time and the size of
the diagnostic generated for the formula.
.P
A fixed point formula "\fBmu\fP" \fIX\fP "\fB.\fP" \fIF\fP or
"\fBnu\fP" \fIX\fP "\fB.\fP" \fIF\fP is \fIunguarded\fP [Koz83] if \fIF\fP
contains at least one free occurrence of \fIX\fP which is not preceded
(not necessarily immediately) by a modality. The evaluation of an unguarded
formula on an LTS may yield a BES with cyclic dependencies between variables
even if the LTS is acyclic.
.P
Note that a state formula containing regular modalities with nested star
operators may yield after translation an unguarded mu-calculus formula.
For example, in the following formula:
.sp
.nf
 \fB   < \fIA1\fP** . \fIA2\fP > true =
        mu \fIX1\fP . (< \fIA2\fP > true or mu \fIX2\fP . (\fIX1\fP or < \fIA1\fP > \fIX2\fP)\fR
.fi
.P
the free occurrence of \fIX1\fP is not preceded by any modality,
and hence the formula is unguarded.
.P
Unguarded occurrences of propositional variables can always be eliminated
from a mu-calculus formula, at the price of an increase in size [Koz83,Mat02].

.SH EXAMPLES OF TEMPORAL PROPERTIES

\fIMCL\fP allows to express concisely various interesting properties.
The most useful classes of temporal properties are illustrated below.

.SS SAFETY PROPERTIES
Informally, a \fIsafety\fP property specifies that "something bad never
happens."
Typical safety properties are those forbidding "bad" execution sequences
in the LTS. These properties can be naturally expressed using box
modalities containing regular formulas. For instance, mutual exclusion
can be characterized by the following formula:
.P
.nf
 \fB   [ true* . "ENTER !1" . (not "LEAVE !1")* . "ENTER !2" ] false\fR
.fi
.P
which states that every time process 1 enters its critical section
(action \fB"ENTER !1"\fP), it is impossible that process 2 also enters its
critical section (action \fB"ENTER !2"\fP) before process 1 has left its
critical section (action \fB"LEAVE !1"\fP).
.sp
Note that this formula does not make any assumption about the fact that
a process enters/leaves several times its critical section, i.e., the
formula does not forbid sequences of the form
\fB"ENTER !1 . ENTER !1 . LEAVE !1 . LEAVE !1"\fP.
.P
The above formula can be made parametric w.r.t. the number of processes in
the system, by using action predicates equipped with data variables:
.P
.nf
 \fB   [ true* . { ENTER ?m:Nat } . (not { LEAVE !m })* .
      { ENTER ?n:Nat where m <> n } ] false\fR
.fi
.P
where the values of \fBm\fP, \fBn\fP captured by the action predicates
\fB{\fP \fIENTER\fP ?\fIm\fP:Nat \fB}\fP and
\fB{\fP \fIENTER\fP ?\fIn\fP:Nat \fB}\fP are propagated to the
enclosing formula in order to ensure that a process \fIn\fP different from
\fIm\fP cannot enter its critical section before process \fIm\fP has left it
(action predicate \fB{\fP \fILEAVE\fP !\fIm\fP \fI}\fP).
.P
Regular formulas equipped with counters provide a useful means for describing
safety properties depending on data. The formula below expresses (part of)
the safety of a \fIn\fP-place buffer:
.P
.nf
  \fB  [ (INPUT . (not OUTPUT)*) { n + 1 } ] false\fR
.fi
.P
by forbidding the existence of a sequence containing more than \fIn\fP
insertions of elements in the buffer (action \fIINPUT\fP) without any
deletions of elements in between (action \fIOUTPUT\fP).
.P
A more precise formulation of the above property can be obtained by using
a fixed point operator parameterized by a counter \fIc\fP, which stores the
number of elements (initially 0) currently present in the buffer:
.P
.nf
  \fB  nu Buffer (c:Nat := 0) . (
        [ INPUT ] ((c < n) and Buffer (c + 1))
        and
        [ OUTPUT ] ((c > 0) and Buffer (c - 1))
        and
        [ not (INPUT or OUTPUT) ] Buffer (c)
    )\fR
.fi
.P
The number of elements \fIc\fP in the buffer is equal to the difference
between the number of elements inserted and deleted from the buffer, and
for a \fIn\fP-place buffer \fIc\fP must belong to 0..\fIn\fP.
.P
Other typical safety properties are the \fIinvariants\fP, expressing
that every state of the LTS satisfies some "good" property. For example,
deadlock freedom can be expressed by the formula below:
.P
.nf
  \fB  [ true* ] < true > true\fR
.fi
.P
stating that every state has at least one successor. Alternately, this
formula may be expressed directly using a fixed point operator:
.P
.nf
  \fB  nu \fIX\fP . (< true > true and [ true ] \fIX\fP)\fR
.fi
.P
but less concisely than by using a regular formula.
.P
The "\fBnatset\fP" type is useful for expressing the occurrence of a set of
actions in any order. For instance, the fact that natural numbers inserted
in a bag (initially empty) can be retrieved in any order can be expressed by
the \fIMCL\fP formula below:
.P
.nf
  \fB  nu Bag (b:NatSet := empty) . (
        [ { PUT ?n:nat } ] Bag (insert (n, b))
        and
        [ { GET ?n:nat } ] ((n isin b) and Bag (remove (n, b)))
        and
        [ not ({ PUT ... } or { GET ... }) ] Bag (b)
    )\fR
.fi
.P
Here the action predicates
\fB{\fP \fIPUT\fP ?\fIn\fP:Nat \fB}\fP and
\fB{\fP \fIGET\fP ?\fIn\fP:Nat \fB}\fP
denote the insertion and retrieval of a natural number into/from the bag,
respectively.

.SS LIVENESS PROPERTIES
Informally, a \fIliveness\fP property specifies that "something good eventually
happens." Typical liveness properties are \fIpotentiality\fP assertions
(i.e., expressing the reachability on a sequence) and \fIinevitability\fP
assertions (i.e., expressing the reachability on all sequences).
.P
Potentiality assertions can be directly expressed using diamond
modalities containing regular formulas.
For instance, the following formula:
.P
.nf
  \fB  < true* . { PUT ?n:Nat } . true* . { GET !n } > true\fR
.fi
.P
states that there exists a sequence that passes (after 0 or more transitions)
through a \fIPUT\fP \fIn\fP action for some natural number \fIn\fP, and then
leads (after 0 or more transitions) to a \fIGET\fP \fIn\fP action.
.P
Regular formulas allow to express succinctly complex potentiality
assertions, such as the formula below:
.P
.nf
  \fB  < true* . SEND . (true* . RETRY) { 0 ... max } .
      true* . RECV > true\fR
.fi
.P
stating that there exists a sequence leading (after 0 or more
transitions) to a \fISEND\fP action, possibly followed by a sequence
of at most \fImax\fP \fIRETRY\fP actions (possibly separated by other
actions) and leading (after 0 or more transitions) to a \fIRECV\fP action.
.P
Inevitability assertions can be expressed using fixed point operators.
For instance, the following formula:
.P
.nf
  \fB  mu \fIX\fP . (< true > true and [ not START ] \fIX\fP)\fR
.fi
.P
states that all transition sequences starting at the current state
lead to \fISTART\fP actions after a finite number of steps.
.P
Similarly, temporal properties containing both safety and liveness aspects
can be expressed by combining box modalities and inevitability operators.
For example, the \fIresponse\fP property stating that every emission of a
message must be inevitably followed in the future by the reception of the
same message can be expressed by the \fIMCL\fP formula below:
.P
.nf
  \fB  [ true* . { SEND ?n:Nat } ]
        mu \fIX\fP . (< true > true and [ not { RECV !n } ] \fIX\fP)\fR
.fi
.P
Note how variable \fIn\fP is assigned in the box modality by capturing
the value of a message sent (action predicate
\fB{\fP \fISEND\fP ?\fIn\fP:Nat \fB}\fP)
and is used later in the body of the fixed point formula
(action predicate \fB{\fP \fIRECV\fP !\fIn\fP \fB}\fP).

.SS FAIRNESS PROPERTIES
These are similar to liveness properties, except that they express
reachability of actions by considering only \fIfair\fP execution
sequences. One simple notion of fairness that can be easily encoded
in \fIMCL\fP is the "fair reachability of predicates" defined by
Queille and Sifakis [QS83]: a sequence is fair iff
it does not infinitely often enable the reachability of a certain
state without infinitely often reaching it. For instance, the following
formula specifies that after every message emission (action SEND),
all fair execution sequences will lead to the reception of the
message (action RECV) after a finite number of steps:
.P
.cs 4 23
.nf
  \fB  [ true* . SEND . (not RECV)* ] < (not RECV)* . RECV > true\fR
.fi
.cs 4
.P
Intuitively, the formula above considers the sequences following
the \fISEND\fP action by "skipping" the circuits of the LTS that do not
contain \fIRECV\fP actions: it states that from every state of such a
circuit, there is still a finite sequence leading to a \fIRECV\fP action.
.P
More elaborated forms of fairness can be expressed by specifying the
absence of \fIunfair\fP execution sequences, which can be characterized
using the infinite looping operator. For example, the formula \fIMCL\fP
below expresses that after process \fIi\fP has requested access to a
resource, it cannot be indefinitely preempted by another process \fIj\fP:
.P
.nf
  \fB  [ true* . { REQUEST ?i:Nat } ]
      not < (not { GRANT !i })* . { REQUEST ?j:Nat where j <> i } .
            (not { GRANT !i })* . { GRANT !j } > @\fR
.fi
.P
This formula can be expressed more concisely by propagating the negation
in front of the infinite looping operator and using the saturation operator:
.P
.nf
  \fB  [ true* . { REQUEST ?i:Nat } ]
      [ (not { GRANT !i })* . { REQUEST ?j:Nat where j <> i } .
        (not { GRANT !i })* . { GRANT !j } ] -|\fR
.fi
.P
The existence of complex cycles can be specified using the fixed point
formulation of the infinite looping operator, in which the propositional
variable has data parameters. The formula below expresses the existence of
a cycle on which the pairs emission-reception of messages \fBn=0..4\fP occur in
this order:
.nf
  \fB  nu \fIY\fP (n:Nat := 0) .
      < true* . { PUT !n } . true* . { GET !n } >
        \fIY\fP ((n + 1) % 5)\fR
.fi
.P
Other, more elaborated examples of fairness properties can be found in
[MT08,MS10].

.SS ACTION PREDICATES
The use of action formulas (and, in particular, of regexps) may be of
considerable help when dealing with actions having the same gate
but different values in the offers. For instance, the following formula:
.P
.cs 4 23
.nf
  \fB  < true* . 'SEND !1.*' and not 'SEND !1.*!2.*' > true\fR
.fi
.cs 4
.P
states the potential reachability of an action having the gate \fISEND\fP
followed by the value 1, possibly followed by other values different from 2. 
.P
Moreover, action formulas combined with modalities allow to express invariants
over actions (i.e., action formulas that must be satisfied by all transition
labels of the LTS). For instance, the following formula:
.P
.cs 4 23
.nf
  \fB  [ true* . { RECV ?src:Nat ?dest:Nat where src <> dest } ] false\fR
.fi
.cs 4
.P
states that all message receptions have different source and destination
fields. Another way of formulating this property is by using regexps on
character strings:
.P
.cs 4 23
.nf
  \fB  [ true* .
      not ('RECV !.* !.*' and 'RECV !\e(.*\e) !\e1')
    ] false\fR
.fi
.cs 4
.P
Note the use of the UNIX regular expression construct `\fB\e( \e)\fP'
allowing to match a portion of a string and to reuse it later in the same
regexp.

.SH MACROS AND LIBRARIES

\fIevaluator4\fP allows to define and use macros for temporal operators
parameterized by action and/or state formulas. This feature is
particularly useful for constructing reusable libraries encoding
various temporal operators of other logics translatable in regular
alternation-free mu-calculus (like CTL and ACTL). The \fImacro-definitions\fP
have the following syntax:
.P
.cs 4 23
.nf
  \fB  "macro" \fIM\fP "(" \fIP1\fP"," ..."," \fIPn\fP ")" "="
        \fI<text>\fP
    "end_macro"\fR
.fi
.cs 4
.P
The above construct defines a macro \fIM\fP having the parameters
\fIP1\fP, \.\.\., \fIPn\fP and the body \fI<text>\fP, which is a string
of alpha-numeric characters (normally) containing occurrences of
the parameters \fIP1\fP, \.\.\., \fIPn\fP. For example, the
following macro-definition:
.P
.cs 4 23
.cs I
.nf
  \fB  macro EU_A (\fIF1\fP, \fIA\fP, \fIF2\fP) =
        mu \fIX\fP . ((\fIF2\fP) or ((\fIF1\fP) and < \fIA\fP > \fIX\fP))
    end_macro\fR
.fi
.cs 4
.cs I
.P
encodes the "Exists Until" operator of ACTL, which states that
there exists a sequence of transitions leading to a state satisfying F2
such that all intermediate states satisfy F1 and all intermediate labels
satisfy A.
.P
The calls of a macro \fIM\fP have the following form:
.P
.nf
   \fB \fIM\fP "(" \fI<text1>\fP"," ..."," \fI<textn>\fP ")"\fR
.fi
.P
where the arguments \fI<text1>\fP, ..., \fI<textn>\fP are strings. The result of
the call is the body <text> of the macro \fIM\fP in which all occurrences
of the parameters \fIPi\fP have been syntactically substituted with the
arguments \fI<texti>\fP, for all i between 1 and n. For example, the following
call:
.P
.nf
  \fB  EU_A (true, not "SEND", < "RECV" > true)\fR
.fi
.P
expands into the formula below:
.P
.nf
  \fB  mu \fIX\fP . ((< "RECV" > true) or ((true) and < not "SEND" > \fIX\fP))\fR
.fi
.P
A macro is visible from the point of its definition until the end
of the formula. Macros may be overloaded: several macros with
the same name, but different arities, may be defined in the same scope.
.P
Various macro-definitions (typically encoding the operators of some
particular temporal logic) can be grouped into files called
\fIlibraries\fP. These files may be included in the source program
using the following command:
.P
.cs 4 23
.cs I 23
.nf
  \fB  "library"
        <\fIfile0\fP.mcl>"," ..."," <\fIfilen\fP.mcl>
    "end_library"\fR
.fi
.cs 4
.cs I
.P
At the compilation of the program, the above construct is
syntactically replaced with the contents of the files
<\fIfile0\fP\fB.mcl\fP>, ..., <\fIfilen\fP\fB.mcl\fP>, placed one after the other in
this order. For example, the following command:
.P
.nf
  \fB  library \fIactl\fP.mcl end_library\fR
.fi
.P
is syntactically replaced with the contents of the file
.IB actl .mcl,
which implements the ACTL operators.
.P
The included files are searched first in the current directory,
then in the directory referenced by $CADP/src/xtl. Multiple inclusions
of the same file are silently discarded.

.SH EXPRESSIVENESS

\fIMCL\fP enables direct and succinct encodings of "pure" branching-time
logics like \fICTL\fP (Computation Tree Logic) [CES86] or \fIACTL\fP
(Action-based CTL) [DV90], as well as of regular logics like \fIPDL\fP
(Propositional Dynamic Logic) [FL79] or \fIPDL-delta\fP [Str82].
.P
The infinite looping operator, whenever it is applied to a regular subformula
containing iteration operators, belongs to the mu-calculus fragment of
alternation depth two [EL86]. It is able to express the existence of complex
cycles (containing regular sub-sequences) in the LTS, which cannot be expressed
using the other operators of \fIMCL\fP because they belong to the
alternation-free fragment of the modal mu-calculus.
In particular, the infinite looping operator can express the existence of
accepting cycles in Büchi automata, which underlies the classical verification
procedure for \fILTL\fP (Linear Time Logic) [CGP00].
.P
Therefore, \fIMCL\fP strictly subsumes both \fICTL\fP and \fILTL\fP, since
these two logics are not comparable w.r.t. their expressive power (each of
them is able to express properties that the other one cannot).
\fIMCL\fP also syntactically subsumes \fIPDL-delta\fP, which was shown to be
more expressive than \fICTL*\fP [Wol82].
.P
When dealing with finite state LTS models, the presence of data-handling
constructs does not, strictly speaking, increase the expressiveness of
\fIMCL\fP because one can instantiate all parameters present in an \fIMCL\fP
formula based on the finite set of values contained in the transition labels
of the LTS. However, in practice the data-handling constructs lead to
significant simplifications and reductions in size of the formulas, thus
facilitating the specification activity and reducing the risk of errors.

.SH MODEL CHECKING COMPLEXITY

The dataless part of \fIMCL\fP has an efficient on-the-fly model checking
algorithm, with a space and time complexity linear in the size of the
formula (number of operators) and the size of the LTS model (number of
states and transitions). Despite the fact that it belongs to the mu-calculus
fragment of alternation depth two (which has theoretically a quadratic-time
model checking complexity [EL86]), the infinite looping operator can be
evaluated in linear-time using the algorithm proposed in [MT08].
The evaluation of \fICTL\fP and \fIPDL-delta\fP operators, which cover the
quasi-totality of practical needs, stores in memory only the states, and not
the transitions of the LTS.
.P
Note: The linear-time model checking complexity obtained for \fIPDL-delta\fP
does not imply a similar result for \fILTL\fP or \fICTL*\fP, since the
translations of these logics in \fIPDL-delta\fP are not guaranteed to be
succinct.
.P
The evaluation of fixed points having parameters of infinite types
(e.g., \fBnat\fP, \fBstring\fP, etc.) may diverge when the number of
fixed point variable instances is unbounded.
Therefore, parameterized fixed points should be used with the same
care as recursive functions in programming languages (note however that cycles
\fIY\fP (\fIv0\fP, ..., \fIvn\fP) -> ... -> \fIY\fP (\fIv0\fP, ..., \fIvn\fP)
do no harm, since BES resolution algorithms can handle cyclic dependencies
between variables). The evaluation of all extended regular operators involving
counters is guaranteed to converge, because it always creates a finite number
of fixed point variable instances, bounded by the values of counters and/or
the number of LTS states.

.SH BIBLIOGRAPHY

.TP
[CES86]
E. M. Clarke, E. A. Emerson, and A. P. Sistla.
"Automatic Verification of Finite-State Concurrent Systems
using Temporal Logic Specifications." ACM Transactions on
Programming Languages and Systems, v. 8, no. 2, p. 244-263, 1986.

.TP
[CGP00]
E. M. Clarke, O. Grumberg, and D. Peled.
"Model Checking." MIT Press, 2000.

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
[Mat98a]
R. Mateescu.
"Verification des proprietes temporelles des programmes
paralleles." PhD Thesis, Institut National Polytechnique de Grenoble,
April 1998.
Available from http://cadp.inria.fr/publications/Mateescu-98-a.html

.TP
[Mat98b]
R. Mateescu.
"Local Model-Checking of an Alternation-Free Value-Based Modal Mu-Calculus."
Proceedings of the 2nd International Workshop on Verification, Model Checking
and Abstract Interpretation VMCAI'98, 1998.
Available from http://cadp.inria.fr/publications/Mateescu-98-b.html

.TP
[Mat02]
R. Mateescu.
"Local Model-Checking of Modal Mu-Calculus on Acyclic
Labeled Transition Systems".
Proceedings of the 8th International Conference on Tools and Algorithms
for the Construction and Analysis of Systems TACAS'02, LNCS v. 2280,
p. 281-295, 2002. Full version available as INRIA Research Report RR-4430.
Available from http://cadp.inria.fr/publications/Mateescu-02.html

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

.TP
[MS10]
R. Mateescu and W. Serwe.
"A Study of Shared-Memory Mutual Exclusion Protocols using CADP."
Proceedings of the 15th International Workshop on Formal Methods for
Industrial Critical Systems FMICS'10, LNCS v. 6371, p. 180-197, 2010.
Available from http://cadp.inria.fr/publications/Mateescu-Serwe-10.html

.TP
[MT08]
R. Mateescu and D. Thivolle.
"A Model Checking Language for Concurrent Value-Passing Systems."
Proceedings of the 15th International Symposium on Formal Methods
FM'08, LNCS v. 5014, p. 148-164, 2008.
Available from http://cadp.inria.fr/publications/Mateescu-Thivolle-08.html

.TP
[QS83]
J-P. Queille and J. Sifakis.
"Fairness and Related Properties in Transition Systems - A Temporal Logic
to Deal with Fairness."
Acta Informatica, v. 19, p. 195-220, 1983.

.TP
[Str82]
R. S. Streett.
"Propositional Dynamic Logic of Looping and Converse."
Information and Control, v. 54, p. 121-141, 1982.

.TP
[Wol82]
P. Wolper.
"A Translation from Full Branching Time Temporal Logic to One Letter
Propositional Dynamic Logic with Looping."
Unpublished manuscript, 1982.

.SH SEE ALSO

.BR evaluator (LOCAL),
.BR evaluator3 (LOCAL),
.BR evaluator4 (LOCAL),
.BR mcl (LOCAL),
.BR mcl3 (LOCAL),
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

