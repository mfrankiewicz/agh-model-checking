.\" @(#)mcl3.l - VASY and CONVECS teams - 2018/05/29
.TH MCL3 LOCAL "2018/05/29" "(C) INRIA" "CADP MANUAL PAGES"
.fp 4 CB
.lg 0
.SH NAME
mcl, MCL \- Model Checking Language version 3 (regular alternation-free mu-calculus)

.SH DESCRIPTION

This manual page presents the version 3 of \fIMCL\fP (\fIModel Checking Language\fP), 
which is the temporal logic accepted as input by
.BR evaluator3 (LOCAL).

.P
This temporal logic is also known as "regular alternation-free mu-calculus".
A description of the regular alternation-free mu-calculus can be found in
the articles [MS03] and [Mat06], which also describe the verification methods
implemented in versions 3.0 and 3.5 of EVALUATOR, respectively.

.P
The regular alternation-free mu-calculus is an extension of the
alternation-free fragment of the modal mu-calculus [Koz83, EL86]
with action predicates and regular expressions over action sequences.
In this setting, action labels are merely handled as character strings.

.P
Note: There exists an extended version of this logic, able to express temporal
properties involving data values; see the
.BR mcl4 (LOCAL)
manual page for details. This extended version is supported by
.BR evaluator4 (LOCAL)
but not by
.BR evaluator3 (LOCAL).

.P
Regular alternation-free mu-calculus allows direct encodings of
"pure" branching-time logics like \fICTL\fP [CES86]
or \fIACTL\fP [DV90], as well as of regular logics
like \fIPDL\fP [FL79] or \fIPDL-delta\fP [Str82].
Moreover, it has an efficient model checking algorithm, with a linear-time
complexity in the size of the formula (number of operators) and the size
of the LTS model (number of states and transitions).
The logic is built from three types of formulas, indicated in the table below.
.P
.cs 4 23
.cs I 23
.nf
\fB               +--------+-----------------+
               | Symbol |   Description   |
               +--------+-----------------+
               |   \fIA\fP    | action formula  |
               |   \fIR\fP    | regular formula |
               |   \fIF\fP    | state formula   |
               +--------+-----------------+\fR
.fi
.cs 4
.cs I
.P
The BNF syntax and the informal semantics of these formulas are
defined below. In the grammar, terminal symbols are written between double quotes.
The axiom of the grammar is the \fBF\fP symbol.
.P
Identifiers are built from letters, digits, and underscores (beginning
with a letter or an underscore). Keywords must be written in lowercase.
Comments are enclosed between '\fB(*\fP' and '\fB*)\fP'. Nested comments are
not allowed. \fBevaluator3\fP is case-sensitive.
.P
The formulas are interpreted over an LTS \fI<S, A, T, s0>\fP, where:
\fIS\fP is the set of \fIstates\fP,
\fIA\fP is the set of \fIactions\fP (transition labels),
\fIT\fP is the \fItransition relation\fP (a subset of \fIS * A * S\fP),
and \fIs0\fP is the \fIinitial state\fP.
A transition \fI(s1, a, s2)\fP of \fIT\fP, also noted \fIs1-a->s2\fP,
indicates that the program from which the LTS has been generated can
move from state \fIs1\fP to state \fIs2\fP by performing action \fIa\fP.

.SH ACTION FORMULAS
An \fIaction formula\fP is a logical formula built from basic action
predicates and boolean connectives, according to the grammar below:
.P
.cs 4 23
.cs I 23
.nf
\fB\fIA\fP	::=  \fIstring\fP
	 |   \fIregexp\fP
	 |   "true"
	 |   "false"
	 |   "not" \fIA\fP
	 |   \fIA1\fP "or" \fIA2\fP
	 |   \fIA1\fP "and" \fIA2\fP
	 |   \fIA1\fP "implies" \fIA2\fP
	 |   \fIA1\fP "equ" \fIA2\fP\fR
.fi
.cs 4
.cs I
.P
A \fIstring\fP is a sequence of zero or more characters, enclosed
between double quotes ('\fB"\fP'), which denotes a label of the LTS. 
A string may contain any character but '\fB\en\fP' (end-of-line).
Double quotes are also allowed, if preceded by a backslash ('\fB\e\fP').
Strings can be concatenated using the binary operator '\fB#\fP'.
.P
.cs 4 23
.cs I 23
.nf
\fB\fIstring\fP ::= "(\fIany char but end-of-line\fP)*"\fR
        |   \fIstring1\fP "#" \fIstring2\fP
.fi
.cs 4
.cs I
.P
A transition label of the LTS satisfies a \fIstring\fP iff it is
identical to the corresponding character string (obtained after concatenation
whenever needed).
.P
A \fIregexp\fP is a UNIX regular expression (see the
.BR regexp (LOCAL)
manual page
for a detailed description of UNIX regular expressions), enclosed between
single quotes ('\fB'\fP'), which denotes a predicate on the labels of the LTS.
Regexp's can be concatenated using the binary operator '\fB#\fP'. Strings 
can be concatenated to regexp's, in which case they are implicitly converted
into regexp's.
.P
.cs 4 23
.cs I 23
.nf
\fB\fIregexp\fP ::= '\fIUNIX_regular_expression\fP'\fR
        |   \fIregexp1\fP "#" \fIregexp2\fP
        |   \fIstring1\fP "#" \fIregexp2\fP
        |   \fIregexp1\fP "#" \fIstring2\fP
.fi
.cs 4
.cs I
.P
A label of the LTS satisfies a \fIregexp\fP if it matches the corresponding
\fIUNIX_regular_expression\fP (obtained after concatenation whenever needed).
.P
Syntactically, all binary operators on action formulas
are left-associative. The "\fBnot\fP" operator has the highest precedence,
followed by "\fBand\fP", followed by "\fBor\fP", followed by "\fBimplies\fP",
followed by "\fBequ\fP".
.P
The boolean operators have the usual semantics:
a label of the LTS always satisfies "\fBtrue\fP";
it never satisfies "\fBfalse\fP";
it satisfies "\fBnot\fP \fIA\fP"
iff it does not satisfy \fIA\fP;
it satisfies "\fIA1\fP \fBor\fP \fIA2\fP"
iff it satisfies \fIA1\fP or it satisfies \fIA2\fP;
it satisfies "\fIA1\fP \fBand\fP \fIA2\fP"
iff it satisfies both \fIA1\fP and \fIA2\fP;
it satisfies "\fIA1\fP \fBimplies\fP \fIA2\fP"
iff it does not satisfy \fIA1\fP or it satisfies \fIA2\fP;
it satisfies "\fIA1\fP \fBequ\fP \fIA2\fP"
iff either it satisfies both \fIA1\fP and \fIA2\fP, or none of them.

.SH REGULAR FORMULAS
A \fIregular formula\fP is a logical formula built from action
formulas and the traditional regular expression operators,
according to the grammar below:
.P
.cs 4 23
.cs I 23
.nf
\fB\fIR\fP ::=  \fIA\fP
   |   "nil"
   |   \fIR1\fP "." \fIR2\fP
   |   \fIR1\fP "|" \fIR2\fP
   |   \fIR\fP "?"
   |   \fIR\fP "*"
   |   \fIR\fP "+"\fR
.fi
.cs 4
.cs I
.P
where "\fBnil\fP" is the empty operator,
"\fB.\fP" is the concatenation operator,
"\fB|\fP" is the choice operator,
"\fB?\fP" is the option operator,
"\fB*\fP" is the transitive and reflexive closure operator, and
"\fB+\fP" is the transitive closure operator.
.P
Syntactically, all binary operators on regular formulas are
left-associative. The "\fB?\fP", "\fB*\fP", and "\fB+\fP" operators have
the highest precedence, followed by "\fB.\fP", followed by "\fB|\fP".
.P
Note: In early versions of
.BR evaluator3 (LOCAL),
the "\fB|\fP" operator had a higher precedence than "\fB.\fP".
To ensure that "old" MCL version 3 regular formulas are interpreted by
the current version of
.BR evaluator3 (LOCAL)
according to their original intended meaning, it is recommended
to add parentheses at appropriate places. For example, an "old"
MCL version 3 regular formula "R1 | R2 . R3" should be rewritten
as "(R1 | R2) . R3" to maintain its original meaning, otherwise
the current version of
.BR evaluator3 (LOCAL)
would parse it as "R1 | (R2 . R3)".
.P
A regular formula \fIR\fP denotes a sequence of (consecutive)
LTS transitions such that the word obtained by concatenating
their labels belongs to the regular language defined by \fIR\fP.
.P
The regular operators have the following semantics:
a sequence of LTS transitions satisfies \fIA\fP
iff it has the form \fIs1-a->s2\fP, where the label
\fIa\fP satisfies the formula \fIA\fP;
it satisfies "\fBnil\fP"
iff it is empty (i.e., it contains no transition);
it satisfies "\fIR1\fP \fB.\fP \fIR2\fP"
iff it is the concatenation of two sequences satisfying
\fIR1\fP and \fIR2\fP, respectively;
it satisfies "\fIR1\fP \fB|\fP \fIR2\fP"
iff it satisfies \fIR1\fP or it satisfies \fIR2\fP;
it satisfies "\fIR\fP \fB?\fP"
iff it is either empty, or it satisfies \fIR\fP;
it satisfies "\fIR\fP \fB*\fP"
iff it is the concatenation of zero or more sequences satisfying \fIR\fP;
it satisfies "\fIR\fP \fB+\fP"
iff it is the concatenation of one or more sequences satisfying \fIR\fP.

.SH STATE FORMULAS
A \fIstate formula\fP is a logical formula built from boolean,
modal, and fixed point operators, according to the grammar below:
.P
.cs 4 23
.cs I 23
.nf
\fB\fIF\fP	::=  "true"
	 |   "false"
	 |   "not" \fIF\fP
	 |   \fIF1\fP "or" \fIF2\fP
	 |   \fIF1\fP "and" \fIF2\fP
	 |   \fIF1\fP "implies" \fIF2\fP
	 |   \fIF1\fP "equ" \fIF2\fP
	 |   "<" \fIR\fP ">" \fIF\fP
	 |   "[" \fIR\fP "]" \fIF\fP
	 |   "<" \fIR\fP ">" "@"
	 |   "[" \fIR\fP "]" "-|"
	 |   \fIX\fP
	 |   "mu" \fIX\fP "." \fIF\fP
	 |   "nu" \fIX\fP "." \fIF\fR
.fi
.cs 4
.cs I
.P
where "\fB<\fP \fIR\fP \fB>\fP \fIF\fP" and "\fB[\fP \fIR\fP \fB]\fP \fIF\fP"
are the possibility and necessity modal operators,
"\fB<\fP \fIR\fP \fB>\fP \fB@\fP" is the infinite looping operator,
"\fB[\fP \fIR\fP \fB]\fP \fB-|\fP" is the saturation operator,
"\fBmu\fP \fIX\fP \fB.\fP \fIF\fP" and "\fBnu\fP \fIX\fP \fB.\fP \fIF\fP" are
the minimal and maximal fixed point operators,
and \fIX\fP is a \fIpropositional variable\fP.
.P
Syntactically, all binary operators on state formulas are
left-associative. The "\fBnot\fP", "\fB< >\fP", "\fB[ ]\fP", "\fBmu\fP", and "\fBnu\fP"
operators have the highest precedence, followed by "\fBand\fP",
followed by "\fBor\fP", followed by "\fBimplies\fP", followed by "\fBequ\fP".
The fixed point operators act as binders for the variables \fIX\fP
in a way similar to quantifiers in first-order logic. In each
meaningful "\fBmu\fP \fIX\fP \fB.\fP \fIF\fP" or "\fBnu\fP \fIX\fP \fB.\fP \fIF\fP"
formula, \fIX\fP is supposed to have free occurrences inside \fIF\fP.
State formulas are assumed to be \fIsyntactically monotonic\fP
(i.e., in each fixed point formula "\fBmu\fP \fIX\fP \fB.\fP \fIF\fP" or
"\fBnu\fP \fIX\fP \fB.\fP \fIF\fP", free occurrences of \fIX\fP in \fIF\fP
may appear only under an even number of negations and/or left-hand
sides of implications) and \fIalternation-free\fP (i.e., without
mutually recursive minimal and maximal fixed point variables).
.P
The boolean operators have the usual semantics:
a state of the LTS always satisfies "\fBtrue\fP";
it never satisfies "\fBfalse\fP";
it satisfies "\fBnot\fP \fIF\fP"
iff it does not satisfy \fIF\fP;
it satisfies "\fIF1\fP \fBor\fP \fIF2\fP"
iff it satisfies \fIF1\fP or it satisfies \fIF2\fP;
it satisfies "\fIF1\fP \fBand\fP \fIF2\fP"
iff it satisfies both \fIF1\fP and \fIF2\fP;
it satisfies "\fIF1\fP \fBimplies\fP \fIF2\fP"
iff it does not satisfy \fIF1\fP or it satisfies \fIF2\fP;
it satisfies "\fIF1\fP \fBequ\fP \fIF2\fP"
iff either it satisfies both \fIF1\fP and \fIF2\fP, or none of them.
.P
The modal operators have the following semantics:
a state of the LTS satisfies "\fB<\fP \fIR\fP \fB>\fP \fIF\fP"
iff there is (at least) one transition sequence starting at the state,
satisfying \fIR\fP, and leading to a state satisfying \fIF\fP;
it satisfies "\fB[\fP \fIR\fP \fB]\fP \fIF\fP"
iff all transition sequences starting at the state and satisfying
\fIR\fP are leading to states satisfying \fIF\fP.
.P
The infinite looping and saturation operators have the following semantics:
a state of the LTS satisfies "\fB<\fP \fIR\fP \fB>\fP \fB@\fP"
iff there is a transition sequence starting at the state and
consisting of an infinite concatenation of sequences satisfying \fIR\fP;
it satisfies "\fB[\fP \fIR\fP \fB]\fP \fB-|\fP"
iff all transition sequences starting at the state and
consisting of a concatenation of sequences satisfying \fIR\fP are finite.
.P
The fixed point operators have the following semantics:
a state satisfies "\fBmu\fP \fIX\fP \fB.\fP \fIF\fP"
iff it belongs to the minimal solution of the fixed point equation
\fIX\fP = \fIF\fP (\fIX\fP),
and it satisfies "\fBnu\fP \fIX\fP \fB.\fP \fIF\fP"
iff it belongs to the maximal solution of the same equation,
where the propositional variable \fIX\fP denotes a set of LTS states.
Intuitively, minimal (resp. maximal) fixed point operators allow to
characterize finite (resp. infinite) tree-like patterns in the LTS.
.P
An LTS satisfies a state formula \fIF\fP iff its initial state \fIs0\fP
satisfies \fIF\fP.

.TP
Note:
When writing complex formulas containing many operators (especially
when mixing regular and boolean operators), it is safer to use
parenthesis to enclose subformulas whenever being in doubt about the
relative priorities of the operators. Otherwise, the tool may parse
and evaluate the formulas in a way different from the user's intentions,
leading to erroneous results that may be quite difficult to track down.

.TP
Note:
Not all operators defined above are primitive constructs of the logic.
The boolean operators "\fBfalse\fP", "\fBand\fP", "\fBimplies\fP", and "\fBequ\fP" can
be expressed in terms of "\fBtrue\fP", "\fBor\fP", and "\fBnot\fP" in the usual way.
The diamond and box modalities are dual:

.nf
 \fB   [ \fIR\fP ] \fIF\fP = not < \fIR\fP > not \fIF\fP\fR
.fi

The same holds for minimal and maximal fixed point operators:

.nf
 \fB   nu \fIX\fP . \fIF\fP = not mu \fIX\fP . not \fIF\fP (not \fIX\fP)\fR
.fi

where \fIF\fP \fB(not\fP \fIX\fP\fB)\fP denotes the syntactic substitution of
\fIX\fP by \fBnot\fP \fIX\fP in \fIF\fP.

The saturation operator is the negation of the infinite looping operator:

.nf
 \fB   [ \fIR\fP ] -| = not < \fIR\fP > @\fR
.fi

The modalities containing regular formulas can be translated in terms
of boolean operators, fixed point operators, and modalities containing
only action formulas, by recursively applying the identities below:

.cs 4 23
.cs I 23
.nf
\fB    < nil > \fIF\fP = < false* > \fIF\fP
    < \fIR1\fP . \fIR2\fP > \fIF\fP = < \fIR1\fP > < \fIR2\fP > \fIF\fP
    < \fIR1\fP | \fIR2\fP > \fIF\fP = < \fIR1\fP > \fIF\fP or < \fIR2\fP > \fIF\fP
    < \fIR\fP? > \fIF\fP = < nil | \fIR\fP > \fIF\fP
    < \fIR\fP* > \fIF\fP = mu \fIX\fP . (\fIF\fP or < \fIR\fP > \fIX\fP)
    < \fIR\fP+ > \fIF\fP = < \fIR\fP . \fIR\fP* > \fIF\fP\fR
.fi
.cs 4
.cs I

where \fIX\fP is a "fresh" propositional variable (the corresponding
identities for box modalities are obtained by duality).

The infinite looping operator is equivalent to the maximal
fixed point formula below:

.nf
 \fB   < \fIR\fP > @ = nu \fIX\fP . < \fIR\fP > \fIX\fP\fR
.fi

where \fIX\fP is a "fresh" propositional variable.

.TP
Note:
Early versions of
.BR evaluator3 (LOCAL)
accepted only alternation-free formulas, meaning that infinite looping
operators "\fB<\fP \fIR\fP \fB>\fP \fB@\fP" were not allowed to contain
"\fB*\fP" or "\fB+\fP" operators in their regular formulas \fIR\fP.
The current version of
.BR evaluator3 (LOCAL)
accepts regular formulas with "\fB*\fP" or "\fB+\fP" in infinite
looping operators, which are now able to characterize complex
cycles in the LTS (e.g., generalized Buchi accepting cycles).
An example of formula accepted by the current version of
.BR evaluator3 (LOCAL)
but not expressible in alternation-free mu-calculus is the
following:

.nf
 \fB   < true* . "A" > @\fR
.fi

This formula is equivalent (by applying the identities above)
to a fixed point formula of alternation depth 2:

.nf
 \fB   nu \fIX\fP . mu \fIY\fP . (< "A" > \fIX\fP or < true > \fIY\fP)\fR
.fi

Although the mu-calculus fragment of alternation depth 2 has in
general a quadratic-time model checking complexity in the size
of the LTS, the alternation depth 2 formulas resulting from the
translation of infinite looping operators "\fB<\fP \fIR\fP \fB>\fP \fB@\fP"
containing "\fB*\fP" or "\fB+\fP" operators in their regular formulas
\fIR\fP have a linear-time model checking complexity in the size
of the LTS [MT08].

.TP
Note:
Early versions of
.BR evaluator3 (LOCAL)
accepted the syntax "\fB@\fP \fB(\fP \fIR\fP \fB)\fP" for the infinite
looping operator. This syntax is now obsolete, but still accepted by
.BR evaluator3 (LOCAL)
for backward compatibility. It is recommended to use the new syntax
"\fB<\fP \fIR\fP \fB>\fP \fB@\fP", which is closer to the syntax of
possibility modalities and reflects more intuitively the existence of
an infinite sequence, terminated by a loop ("@") in a finite state LTS.

.P
A fixed point formula "\fBmu\fP \fIX\fP \fB.\fP \fIF\fP" or
"\fBnu\fP \fIX\fP \fB.\fP \fIF\fP" is \fIunguarded\fP [Koz83] if \fIF\fP
contains at least one free occurrence of \fIX\fP which is not preceded
(not necessarily immediately) by a modality. The evaluation of an unguarded
formula on an LTS may yield a BES with cyclic dependencies between variables
even if the LTS is acyclic.
.sp
A state formula containing regular modalities with nested star
operators may yield after translation an unguarded mu-calculus formula.
For example, in the following formula:

.nf
 \fB   < \fIA1\fP** . \fIA2\fP > true =
        mu \fIX1\fP . (< \fIA2\fP > true or mu \fIX2\fP . (\fIX1\fP or < \fIA1\fP > \fIX2\fP)\fR
.fi

the free occurrence of \fIX1\fP is not preceded by any modality,
and hence the formula is unguarded.

Unguarded occurrences of propositional variables can always be eliminated
from a mu-calculus formula, at the price of an increase in size [Koz83,Mat02].

.SH EXAMPLES OF TEMPORAL PROPERTIES

The regular alternation-free mu-calculus allows to express concisely
various interesting properties. The most useful classes of temporal
properties are illustrated below.

.SS SAFETY PROPERTIES
Informally, a safety property expresses that "something bad never happens".
Typical safety properties are those forbidding "bad" execution sequences
in the LTS. These properties can be naturally expressed using box
modalities containing regular formulas. For instance, mutual exclusion
can be characterized by the following formula:
.P
.nf
 \fB   [ true* . "OPEN !1" . (not "CLOSE !1")* . "OPEN !2" ] false\fR
.fi
.P
which states that every time process 1 enters its critical section
(action "OPEN !1"), it is impossible that process 2 also enters its
critical section (action "OPEN !2") before process 1 has left its critical
section (action "CLOSE !1").
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

.SS LIVENESS PROPERTIES
Informally, a liveness property expresses that "something good eventually
happens". Typical liveness properties are \fIpotentiality\fP assertions
(i.e., expressing the reachability on a sequence) and \fIinevitability\fP
assertions (i.e., expressing the reachability on all sequences).
.P
Potentiality assertions can be directly expressed using diamond
modalities containing regular formulas.
For instance, the following formula:
.P
.nf
  \fB  < true* . "GET !0" > true\fR
.fi
.P
states that there exists a sequence leading to a "GET !0" action
after performing zero or more transitions.
Regular formulas allow to express succinctly complex potentiality
assertions, such as the formula below:
.P
.nf
  \fB  < true* . "SEND" . (true* . "ERROR")* . true* . "RECV" > true\fR
.fi
.P
stating that there exists a sequence leading (after zero or more
transitions) to a "SEND" action, possibly followed by a sequence
of "ERROR" actions (possibly separated by other actions) and leading
(after zero or more transitions) to a "RECV" action.
.P
Inevitability assertions can be expressed using fixed point operators.
For instance, the following formula:
.P
.nf
  \fB  mu \fIX\fP . (< true > true and [ not "START" ] \fIX\fP)\fR
.fi
.P
states that all transition sequences starting at the current state
lead to "START" actions after a finite number of steps.

.SS FAIRNESS PROPERTIES
These are similar to liveness properties, except that they express
reachability of actions by considering only \fIfair\fP execution
sequences. One notion of fairness that can be easily encoded
in the logic is the "fair reachability of predicates" defined by
Queille and Sifakis [QS83]: a sequence is fair iff
it does not infinitely often enable the reachability of a certain
state without infinitely often reaching it. For instance, the following
formula expresses that after every message emission (action "SEND"),
all fair execution sequences will lead to the reception of the
message (action "RECV") after a finite number of steps:
.P
.cs 4 23
.nf
  \fB  [ true* . "SEND" . (not "RECV")* ]
    < (not "RECV")* . "RECV" > true\fR
.fi
.cs 4
.P
Intuitively, the formula above considers the sequences following
the "SEND" action by "skipping" the cycles of the LTS that do not
contain "RECV" actions: it states that from every state of such a
cycle, there is still a finite sequence leading to a "RECV" action.

.SS ACTION PREDICATES
The use of action formulas (and, in particular, of regexp's) may be of 
considerable help when dealing with LOTOS actions having the same gate 
but different values in the offers. For instance, the following formula:
.P
.cs 4 23
.nf
  \fB  < true* . 'SEND !1.*' and not 'SEND !1.*!2' > true\fR
.fi
.cs 4
.P
states the potential reachability of an action having the gate SEND
and the value of the first offer equal to 1, possibly followed by
other offers with values different from 2. Moreover, action formulas
combined with modalities allow to express invariants over actions
(i.e., action formulas that must be satisfied by all transition labels
of the LTS). For instance, the following formula:
.P
.cs 4 23
.nf
  \fB  [ true* .
      not ('RECV !.* !.*' and 'RECV !\e(.*\e) !\e1')
    ] false\fR
.fi
.cs 4
.P
states that all message receptions (actions "RECV !source !dest")
have different source and destination fields. The
UNIX regular expression construct `\fB\e( \e)\fP' enables to match a portion
of a string and to re-use it later in the same regexp.

.TP
Note:
For efficiency reasons, when using fixed point operators, it is
recommended to put the recursive call of the propositional variable
at the rightmost place in the formula (as in all fixed point formulas
shown above). This reduces both the evaluation time and the size of
the diagnostic generated for the formula.

.SH MACROS AND LIBRARIES

\fIevaluator3\fP allows to define and use macros for temporal operators
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
of the program. The macros may be overloaded: several macros with
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
is syntactically replaced with the content of the file
.IB actl .mcl,
which implements the ACTL operators.
.P
The included files are searched first in the current directory,
then in the directory referenced by $CADP/src/xtl. Multiple inclusions
of the same file are silently discarded.

.SH BIBLIOGRAPHY

.TP
[CES86]
E. M. Clarke, E. A. Emerson, and A. P. Sistla.
"Automatic Verification of Finite-State Concurrent Systems
using Temporal Logic Specifications". ACM Transactions on
Programming Languages and Systems, v. 8, no. 2, p. 244-263, 1986.

.TP
[DV90]
R. De Nicola and F. W. Vaandrager.
"Action versus State based Logics for Transition Systems".
Proceedings Ecole de Printemps on Semantics of Concurrency,
LNCS v. 469, p. 407-419, 1990.

.TP
[EL86]
E. A. Emerson and C-L. Lei.
"Efficient Model Checking in Fragments of the Propositional Mu-Calculus".
Proceedings of the 1st LICS, p. 267-278, 1986.

.TP
[FL79]
M. J. Fischer and R. E. Ladner.
"Propositional Dynamic Logic of Regular Programs".
Journal of Computer and System Sciences, no. 18, p. 194-211, 1979.

.TP
[Koz83]
D. Kozen.
"Results on the Propositional Mu-Calculus".
Theoretical Computer Science, v. 27, p. 333-354, 1983.

.TP
[Mat98]
R. Mateescu.
"Verification des proprietes temporelles des programmes
paralleles". PhD Thesis, Institut National Polytechnique de Grenoble,
April 1998.
Available from http://cadp.inria.fr/publications/Mateescu-98-a.html

.TP
[Mat02]
R. Mateescu.
"Local Model-Checking of Modal Mu-Calculus on Acyclic
Labeled Transition Systems".
Proceedings of TACAS'02, LNCS v. 2280, p. 281-295, 2002.
Full version available as INRIA Research Report RR-4430.
Available from http://cadp.inria.fr/publications/Mateescu-02.html

.TP
[Mat06]
R. Mateescu.
"CAESAR_SOLVE: A Generic Library for On-the-Fly Resolution of
Alternation-Free Boolean Equation Systems".
Springer International Journal on Software Tools for Technology Transfer
(STTT), v. 8, no. 1, p. 37-56, 2006. Full version available as INRIA Research
Report RR-5948.
Available from http://cadp.inria.fr/publications/Mateescu-06-a.html

.TP
[MS03]
R. Mateescu and M. Sighireanu.
"Efficient On-the-Fly Model-Checking for Regular Alternation-Free Mu-Calculus".
Science of Computer Programming, v. 46, no. 3, p. 255-281, 2003.
Available from http://cadp.inria.fr/publications/Mateescu-Sighireanu-03.html

.TP
[MT08]
R. Mateescu and D. Thivolle.
"A Model Checking Language for Concurrent Value-Passing Systems".
Proceedings of the 15th International Symposium on Formal Methods
FM'08, LNCS v. 5014, p. 148-164, 2008.
Available from http://cadp.inria.fr/publications/Mateescu-Thivolle-08.html

.TP
[QS83]
J-P. Queille and J. Sifakis.
"Fairness and Related Properties in Transition Systems - A Temporal Logic
to Deal with Fairness".
Acta Informatica, v. 19, p. 195-220, 1983.

.TP
[Str82]
R. S. Streett.
"Propositional Dynamic Logic of Looping and Converse".
Information and Control, v. 54, p. 121-141, 1982.

.SH SEE ALSO

.BR evaluator (LOCAL),
.BR evaluator3 (LOCAL),
.BR evaluator4 (LOCAL),
.BR mcl (LOCAL),
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

