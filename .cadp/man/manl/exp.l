'\" t
.\" @(#)exp.l - VASY and CONVECS teams - 2020/02/11
.TH EXP LOCAL "2020/02/11" "(C) INRIA" "CADP MANUAL PAGES"
.fp 4 CB
.lg 0

.cs 4 23

.SH NAME
exp, EXP - language for describing networks of communicating automata

.SH DESCRIPTION

This manual page presents EXP 2.0, which is a conservative extension of a previous version EXP 1.0.
EXP 2.0 allows networks of communicating automata (also called \fIbehaviours\fP in the sequel) to be modelled using operators of several languages.
.P
In addition to LOTOS parallel composition and hiding [ISO-89], already implemented in EXP 1.0, EXP 2.0 contains operators taken from E-LOTOS [ISO-01] and LNT, CCS [Milner-89], CSP [Brookes-Hoare-Roscoe-84], and mCRL [Groote-Ponse-90], as well as parallel composition using synchronisation vectors, and generalized operators for label hiding, renaming, and cutting (also called restriction in CCS or encapsulation in mCRL).
EXP2.0 also contains a priority operator that allows priorities between transitions to be defined.
.P
Since these operators are taken from various languages that are not always compatible (for instance, the hidden event is written "i" in LOTOS, E-LOTOS, and LNT, "t" in CCS and CSP, "tau" in mCRL), \fBexp.open\fP allows the graph module to be customized with respect to a particular language (called the \fIreference language\fP).
.P
The customization operates on the following parameters:

.IP -
The string representing hidden events.

.IP -
The string representing the gate used to express behaviour termination (e.g., "exit" in LOTOS, E-LOTOS, and LNT, "delta" in CSP, irrelevant in CCS and mCRL).

.IP -
Case sensitivity, i.e., whether labels in the EXP file should be turned to upper-case or not.

.IP -
The meaning of symbols existing in different languages with different semantics ("\\" in CCS and CSP, "||" in LOTOS and mCRL).
.P
See
.BR exp.open (LOCAL)
for options enabling a definition of these parameters.
When these options are not used, default values are associated to each of these parameters, depending on the reference language selected. For backward compatibility reasons, there is no reference language selected by default. See Section LANGUAGE PARAMETERS for details.
.P
Beware that the
.BR aldebaran (LOCAL)
tool only works with EXP 1.0 descriptions and that the
\fBexp2fc2\fP tool is now deprecated.

.P
The publication [Lang-05] provides an overview of \fBexp.open\fP 2.0 and its input language.

.SH SYNTAX OF E\&X\&P 2.0

.P
The syntax of EXP 2.0 is presented using a grammar in the Extended Backus-Naur Form (EBNF):

.IP -
Non-terminal symbols are written using capital letters (e.g., \fIB\fP).

.IP -
Keywords are written using lowercase characters (e.g., hide, par, in, etc.).

.IP -
Key symbols are written between double quotes to avoid ambiguities with EBNF symbols (in particular, "|", "(", "[", "*", etc.). However, the quotes may be omitted for non-ambiguous symbols (",", "<-", etc.)

.IP -
Definitions in natural language are enclosed in angles (e.g., <filename>).

.IP -
Optional sequences of symbols are written between square brackets.

.IP -
Star (*) denotes repetition zero or more times of the preceding EBNF expression.

.IP -
Plus (+) denotes repetition one or more times of the preceding EBNF expression.

.IP -
Operators * and + have precedence over other EBNF operators.
Parentheses are used to associate sequences of symbols (e.g., "\fIG\fP (, \fIG\fP)*").

.P
The EXP 2.0 grammar is presented in several parts, corresponding to the different languages supported.  We write "\fIB\fP ::= ... | \fIexpression\fP" to express that the definition of \fIB\fP is extended with \fIexpression\fP.  The entry point of the grammar is the non-terminal symbol \fIAXIOM\fP.
.P
The following productions are common to all languages.
\fIIDF\fP stands for any sequence of letters, digits, and underscores ("_"), which begins with a letter and does not end with an underscore.
\fILTS\fP stands for files containing an automaton, \fIFILE\fP for other files, \fIG\fP for gates, \fIGL\fP for gate lists, \fIL\fP for labels, and \fILL\fP for label lists.
.P
Comments of the form
.nf
    (* <any text on one or several lines> *)
.fi
and
.nf
    -- <any text on one line>
.fi
are allowed in EXP 2.0 behaviours.
.nf
.cs I 23

\fILTS\fP ::= "<filename>"
     | \fIIDF\fP                 (* automaton without extension *)
     | "<filename>.bcg"
     | \fIIDF\fP.bcg             (* automaton in BCG format *)
     | "<filename>.aut"
     | \fIIDF\fP.aut             (* automaton in AUT format *)
     | "<filename>.seq"
     | \fIIDF\fP.seq             (* automaton in SEQ format *)
     | "<filename>.fc2
     | \fIIDF\fP.fc2             (* automaton in FC2 format *)
     | "<filename>.exp"    (* include file in EXP format *)

\fIFILE\fP ::= "<filename>"
      | \fIIDF\fP                (* file without extension *)
      | "<filename>(.hid|.hide)"
      | \fIIDF\fP(.hid|.hide)    (* hide file *)
      | "<filename>(.ren|.rename)"
      | \fIIDF\fP(.ren|.rename)  (* rename file *)
      | "<filename>.cut"
      | \fIIDF\fP.cut            (* cut file *)

\fIG\fP ::= \fIIDF\fP                  (* gate *)
   |  "<string denoting a gate>"

\fIGL\fP ::= [\fIG\fP (, \fIG\fP)*]          (* gate list *)

\fIL\fP ::= \fIG\fP                    (* label *)
   |  "<gate with offers>"
   |  "<regular expression denoting a gate>"
   |  "<regular expression denoting a gate with offers>"

\fILL\fP ::= [\fIL\fP (, \fIL\fP)*]          (* label list *)
.cs I
.fi
.P
Note that \fIL\fP can be a gate, or a gate followed by experiment offers, or a regular expression denoting a gate possibly followed by experiment offers.
(See the definition of regular expressions in the
.BR regexp (LOCAL)
man page.)
The gate of a label \fIL\fP is the sub-string starting at the beginning of \fIL\fP and ending at the first character !, ?, (, space, or tabulation, if any, or at the end of \fIL\fP otherwise.
.P
For instance, "G", "G.*", "G !1", "G(1)", "G.* !.*" are labels, among which "G" is a gate, "G.*" is a regular expression denoting a gate or a gate with offers, "G !1" is a gate with offers, and "G.* !.*" is a regular expression denoting a gate with offers (following LOTOS syntax). Note that the syntax of offers is not restricted to LOTOS: "G(1, 2)" also denotes a gate with offers.
.P
Double quotes around a label can be omitted if and only if the label is a gate satisfying the syntax of \fIIDF\fP, but they are mandatory to avoid syntactic ambiguities when a gate has the same name as a reserved EXP keyword (e.g. "cut", "all", etc.) or when a label contains special characters.
.P
Note: all escape character sequences defined in the specification of ANSI C character constants, except octal numbers, hexadecimal numbers, and '\\n', are allowed in labels and filenames enclosed in double quotes.
These escape character sequences are replaced by a single character accordingly.
Every '\\' character that does not belong to an ANSI C escape character sequence is kept unchanged.
For instance, \'\\"\' and '\\\\' are replaced respectively by '"' and '\\', whereas '\\p' and '\\(' are kept unchanged.

.SS L\&O\&T\&O\&S OPERATORS
.nf
.cs I 23
\fIAXIOM\fP ::= [[lotos] (behaviour | behavior)] \fIB\fP

\fIB\fP ::= \fILTS\fP
   |  hide \fIGL\fP in \fIB\fP
   |  \fIB\fP "||" \fIB\fP
   |  \fIB\fP "|||" \fIB\fP
   |  \fIB\fP "|[" \fIGL\fP "]|" \fIB\fP
   |  (\fIB\fP)
.cs I
.fi
.P
Note that the LOTOS syntax corresponds exactly to EXP 1.0, except the "lotos" keyword, which was absent in EXP 1.0.
In EXP 2.0, LOTOS operators are subsumed by E-LOTOS/LNT operators, but they are kept for backward compatibility with EXP 1.0.

.SS E-\&L\&O\&T\&O\&S/\&L\&N\&T OPERATORS
.nf
.cs I 23
\fIAXIOM\fP ::= ...
       |  [[elotos] (behaviour | behavior)] \fIB\fP

\fIB\fP ::= ...

   |  [gate | total | partial] hide
      ([all but] \fILL\fP | using \fIFILE\fP) in \fIB\fP end hide

   |  [gate | total | single | multiple] rename
      (\fIL\fP -> \fIL\fP (, \fIL\fP -> \fIL\fP)* | using \fIFILE\fP) in \fIB\fP
      end rename

   | [gate | label] par [(all | \fIS\fP) in]
     [\fIS\fP ->] \fIB\fP ("||" [\fIS\fP ->] \fIB\fP)+ end par

\fIS\fP ::= [\fIL\fP [# \fIN\fP] (, \fIL\fP [# \fIN\fP])*]

\fIN\fP ::= <natural number>
.cs I
.fi

.SS C\&C\&S OPERATORS
.nf
.cs I 23
\fIAXIOM\fP ::= ...
       |  [[ccs] (behaviour | behavior)] \fIB\fP

\fIB\fP ::= ...
   |  \fIB\fP "|" \fIB\fP
   |  \fIB\fP \\ \fIL\fP
   |  \fIB\fP \\ "{" \fILL\fP "}"
   |  \fIB\fP "[" \fIL\fP / \fIL\fP (, \fIL\fP / \fIL\fP)* "]"
.cs I
.fi

.SS C\&S\&P OPERATORS
.nf
.cs I 23
\fIAXIOM\fP ::= ...
       |  [[csp] (behaviour | behavior)] \fIB\fP

\fIB\fP ::= ...
   |  \fIB\fP "|||" \fIB\fP
   |  \fIB\fP "[|" "{" \fIGL\fP "}" "|]" \fIB\fP
   |  \fIB\fP "[" "{" \fIGL\fP "}" "||" "{" \fIGL\fP "}" "]" \fIB\fP
   |  \fIB\fP \\ \fIL\fP
   |  \fIB\fP \\ "{" \fILL\fP "}"
   |  \fIB\fP "[[" \fIL\fP <- \fIL\fP (, \fIL\fP <- \fIL\fP)* "]]"
.cs I
.fi

.SS M\&C\&R\&L OPERATORS
.nf
.cs I 23
\fIAXIOM\fP ::= ...
       |  [[mcrl] (behaviour | behavior)]
          [comm \fIC\fP (, \fIC\fP)* end comm] \fIB\fP

\fIC\fP ::= \fIG\fP "|" \fIG\fP "=" \fIG\fP

\fIB\fP ::= ...
   |  \fIB\fP "||" \fIB\fP
.cs I
.fi
.P
The mCRL operators "hide", "rename", and "encaps" are subsumed by the operators "hide", "rename", and "cut" presented in Sections "E-LOTOS/LNT OPERATORS" above and "OTHER OPERATORS" below.

.SS OTHER OPERATORS
.nf
.cs I 23
\fIB\fP ::= ...

   |  [gate | total | partial] cut
      ([all but] \fILL\fP | using \fIFILE\fP) in \fIB\fP end cut

   |  [gate | total | partial] prio
      ([all but] \fILL\fP (> [all but] \fILL\fP)+)+
      in \fIB\fP end prio

   |  [gate | label] par using
      \fISV\fP (, \fISV\fP)* in \fIB\fP ("||" \fIB\fP)* end par

\fIR\fP ::=

\fISV\fP ::= (\fIL\fP |  _) ("*" (\fIL\fP |  _))* -> \fIL\fP
    |  (\fIL\fP |  _) ("||" (\fIL\fP |  _))* -> \fIL\fP
.cs I
.fi
.P

.SS SYNTAX CONVENTIONS
.P
EXP 2.0 satisfies the following precedence and associativity rules:

.IP -
LOTOS "hide" gives precedence to infix parallel operators (same as in LOTOS).
For instance, the behaviour:
.nf
        \fIhide G in "f1.bcg" ||| "f2.bcg"\fP
.fi
is parsed as:
.nf
        \fIhide G in ("f1.bcg" ||| "f2.bcg")\fP
.fi
.IP -
Infix parallel operators associate to the right.
For instance, the behaviour:
.nf
        \fI"f1.bcg" ||| "f2.bcg" |[G]| "f3.bcg"\fP
.fi
is parsed as:
.nf
        \fI"f1.bcg" ||| ("f2.bcg" |[G]| "f3.bcg")\fP
.fi

.IP -
Postfix operators have precedence over all other operators.
For instance, the behaviour:
.nf
        \fI"f1.bcg" | "f2.bcg" \\ G\fP
.fi
is parsed as:
.nf
        \fI"f1.bcg" | ("f2.bcg" \\ G)\fP
.fi

.P
The syntax of EXP 2.0 is the union of all EBNF productions presented above, with
 the following exceptions:

.IP -
Inside "par" operators, behaviours using infix parallel operators are enclosed in parenthesis or parenthesized operators (hide...end hide, rename...end rename, etc.).
For instance, the following behaviour is not syntactically correct:
.nf
        \fIpar G in
           "f1.bcg" ||| "f2.bcg"
        || "f3.bcg"
        end par\fP
.fi
whereas the following behaviours are syntactically correct:
.nf
        \fIpar G in
           ("f1.bcg" ||| "f2.bcg")
        || "f3.bcg"
        end par\fP

        \fIpar G in
           hide H in "f1.bcg" ||| "f2.bcg" end hide
        || "f3.bcg"
        end par\fP
.fi
Note in particular that the following two behaviours have different semantics:
.nf
        \fIpar G in
           "f1.bcg"
        || "f2.bcg"
        || "f3.bcg"
        end par\fP
and
        \fIpar G in
           ("f1.bcg" || "f2.bcg")
        || "f3.bcg"
        end par\fP
.fi
In the latter case, the "||" occurring in the parentheses corresponds to the LOTOS or mCRL parallel composition operator, whereas all other occurrences of "||" correspond to the E-LOTOS/LNT parallel symbol.

.IP -
Similarly, the "hide" operator must be ended by "end hide" (recommended) or enclosed in parentheses when used inside parenthesized operators.

.SH SEMANTICS OF E\&X\&P 2.0

.P
This section describes the semantics of all EXP 2.0 constructs.

.SS LABELLED TRANSITION SYSTEMS

.P
\fILTS\fP may be the name of a file containing an automaton in one of the AUT (extension \fB.aut\fP), BCG (extension \fB.bcg\fP), FC2 (extension \fB.fc2\fP), or SEQ (extension \fB.seq\fP) file formats.
.P
All automaton files must have a known extension.
However, the extension may be omitted in the behaviour description if the automaton is in the BCG or in the AUT format.
If \fILTS\fP has not a known extension, then \fBexp.open\fP will first attempt to open \fILTS\fP\fB.bcg\fP. If \fILTS\fP\fB.bcg\fP does not exist in the current directory, \fBexp.open\fP will then attempt to open \fILTS\fP\fB.aut\fP.
.P
Use of the BCG format is recommended since \fBexp.open\fP will automatically convert other formats to BCG using the
.BR bcg_io (LOCAL)
tool.

.SS E\&X\&P FILE INCLUSION

.P
\fILTS\fP may also be the name of an EXP file (extension \fB.exp\fP) within double quotes.
In this case, the contents of this EXP file is simply copied inside the current EXP expression.
This allows large expressions to be split into a hierarchy of EXP files.
.P
Example: The expression
.nf
   "a.exp" || "b.bcg"
.fi
where file "a.exp" contains the expression
.nf
   hide A in "a.bcg"
.fi
is equivalent to
.nf
   hide A in "a.bcg" || "b.bcg"
.fi
Note that this is parsed as
.nf
   hide A in ("a.bcg" || "b.bcg")
.fi
hence parentheses may be required to avoid lexical scoping issues.

.SS GENERALIZED HIDING
.nf
  [gate | total | partial] hide [all but] \fILL\fP in \fIB\fP end hide

| [gate | total | partial] hide using \fIFILE\fP in \fIB\fP end hide

.fi
will hide the labels found in \fIB\fP using the given hiding rules.
These rules can be specified either as a list of labels (first form), or using an external file \fIFILE\fP (second form).
.P
In the first case, \fBexp.open\fP builds a temporary file, filled with the given labels.
In the second case, the hide file must be provided by the user.
No particular extension is required, but the filename must be written between double quotes if it does not have the form \fIIDF\fP,  \fIIDF\fP\fB.hide\fP, or \fIIDF\fP\fB.hid\fP.
See the
.BR caesar_hide_1 (LOCAL)
man page for a definition of the hide file format.
.P
The "all but" keywords modify the semantics of the hiding rules: all the labels, except the labels specified in the list of labels, are hidden.
.P
The keywords "total", "partial", and "gate" modify the matching mode, that is the way the hiding rules are interpreted.
See the
.BR caesar_hide_1 (LOCAL)
man page.
See also Section SYNTAX OF EXP 2.0 above, which explains how the gate of a label is recognized.
If no matching mode is specified, then the default is "gate", which implements the LOTOS hiding operator extended with regular expressions denoting gates.
.P
For every hiding with "gate" matching, \fBexp.open\fP checks whether the gates to be hidden have an appropriate syntax and issues a warning if they appear to contain experiment offers (which is a common mistake for novice users). For instance,
.nf
        hide "G !1"
.fi
will trigger a warning message because of the occurrence of "!1".
.P
\fBExamples\fP:
.nf

        total hide "G"
.fi
hides every label equal to "G",
.nf

        gate hide "G"
.fi
hides every label whose gate is G, e.g., "G !1", "G !2",
.nf

        gate hide ".*G.*"
.fi
hides every label whose gate contains the character G and
.nf

        partial hide "G"
.fi
hides every label whose gate or offers contain the character G.
.P
See the
.BR caesar_hide_1 (LOCAL)
man page for more information on matching mode semantics.
.BR regexp (LOCAL)
man page for information about regular expression syntax.
.P
The semantics of LOTOS "hide" is compatible with that of E-LOTOS/LNT, i.e.,
.nf
        hide \fIGL\fP in \fIB\fP
.fi
is equivalent to
.nf
        gate hide \fIGL\fP in \fIB\fP end hide
.fi

.SS GENERALIZED RENAMING
.nf
  [gate | total | single | multiple] rename
        \fIL\fP -> \fIL\fP (, \fIL\fP -> \fIL\fP)* in \fIB\fP end rename

| [gate | total | single | multiple] rename
        using \fIFILE\fP in \fIB\fP end rename

.fi
will rename the labels of \fIB\fP using the given renaming rules.
These rules can be specified either as a list of items of the form \fIL\fP -> \fIL\fP (first form), or using an external file \fIFILE\fP (second form).
.P
In the first case \fBexp.open\fP builds a temporary file, filled with the given substitution rules.
In the second case \fBexp.open\fP uses the given renaming file.
No particular extension is required, but the filename must be written between double quotes if it does not have the form \fIIDF\fP,  \fIIDF\fP\fB.rename\fP, or \fIIDF\fP\fB.ren\fP.
See the
.BR caesar_rename_1 (LOCAL)
man page for a definition of the hide file format.
.P
See also Section SYNTAX OF EXP 2.0 above, which explains how the gate of a label is recognized.
The keywords "total", "single", "multiple", and "gate" modify the way the left-hand sides of the renaming rules are interpreted, see the
.BR caesar_rename_1 (LOCAL)
man page. If no matching mode is specified, then the default is "gate".
.P
For every renaming with "gate" matching, \fBexp.open\fP checks whether the gates to be renamed have an appropriate syntax and issues a warning if they appear to contain experiment offers (which is a common mistake for novice users). For instance,
.nf
        rename "G !1" -> "G !2"
.fi
will trigger a warning message because of the occurrence of "!1" in the left-hand side. Note however that
.nf
        rename "G" -> "G !1"
.fi
is correct.
.P
\fBExamples\fP:
.nf

        total rename "G" -> "H"
.fi
renames to "H" every label equal to "G",
.nf

        gate rename "G" -> "H"
.fi
renames to "H" every gate equal to "G",
e.g., "G !1" is renamed to "H !1",
.nf

        gate rename ".*G.*" -> "H"
.fi
renames to "H" every gate that contains a G character,
.nf

        single rename "G" -> "H"
.fi
replaces the first occurrence of "G" by "H" in every label whose gate or offers contain a G character,
.nf

        multiple rename "G" -> "H"
.fi
replaces every occurrence of "G" by "H" in every label whose gate or offers contain a G character, and
.nf

        total rename "\\([a-zA-Z0-9]*\\) \\(!.*\\)" -> "\\1 !1 \\2"
.fi
inserts "!1" between every gate (sequence of letters and digits) and its offers (prefixed with !).
.P
See the
.BR caesar_rename_1 (LOCAL)
man page for more information on matching mode semantics.
See also the
.BR regexp (LOCAL)
man page for more information on regular expressions.

.SS GENERALIZED CUT
.nf
  [gate | total | partial] cut [all but] \fILL\fP in \fIB\fP end cut

| [gate | total | partial] cut using \fIFILE\fP in \fIB\fP end cut

.fi
is a generalization of mCRL encapsulation, on the same principles as the generalized "hide" operator.
Instead of being converted into silent transitions as does the "hide" operator, transitions whose label matches the given regular expressions are simply cut off.
.P
Cut files have the following syntax:
.nf
.cs I 23

\fIAXIOM\fP ::= <blanks> cut <blanks> \\n \fILABELS\fP
       |  <blanks> cut all but <blanks> \\n \fILABELS\fP

\fILABELS\fP ::= (<blanks> \fIL\fP <blanks> \\n)*

.cs I
.fi
where \fIL\fP is a label, and <blanks> is any sequence of spaces, tabulations, carriage returns, newlines, vertical tabulation, or form feeds;
these characters are those recognized by the POSIX function isspace();
they are always skipped and ignored.

.SS GENERALIZED PRIORITY

.nf
  [gate | total | partial] prio
      ([all but] \fILL\fP (> [all but] \fILL\fP)+)+
  in \fIB\fP end prio

.fi
sets priorities between the transitions of \fIB\fP.
In each state of \fIB\fP, a transition may be executed only if all transitions of higher priority are not ready for execution.
.P
Priorities between transitions (or equivalently, between labels) are defined by a set of priority rules \fIX1\fP > ... \fIXn\fP, where each \fIXi\fP has the form [all but] \fILLi\fP and \fILL1\fP, ..., \fILLn\fP are lists of regular expressions denoting gates or labels.
The "all but" keywords that may precede some \fILLi\fP means all gates or labels but those matching \fILLi\fP.
.P
Such priority rules define a transitive relation ">>" on labels as follows:
.IP -
if \fIX\fP > \fIX'\fP, the visible label \fIL\fP of \fIB\fP matches \fIX\fP, and the visible label \fIL'\fP of \fIB\fP matches \fIX'\fP then \fIL\fP >> \fIL'\fP
.IP -
if \fIL\fP >> \fIL'\fP and \fIL'\fP >> \fIL''\fP then \fIL\fP >> \fIL''\fP
.P
\fIL\fP >> \fIL'\fP means that any transition labeled \fIL\fP has priority over any transition labeled \fIL'\fP or, equivalently, any transition labeled \fIL'\fP yields priority to any transition labeled \fIL\fP.
.P
The relation ">>" must be a strict partial order: \fIB\fP must not contain any label \fIL\fP such that \fIL\fP >> \fIL\fP.
If ">>" is not a strict partial order, \fBexp.open\fP will issue an error message and exit.
.P
Beware that the rules \fIX\fP > \fIX'\fP and \fIX'\fP > \fIX''\fP (which are equivalent to \fIX\fP > \fIX'\fP > \fIX''\fP) imply \fIX\fP > \fIX''\fP if and only if some label of \fIB\fP matches \fIX'\fP.
Therefore, to avoid tricky errors, \fBexp.open\fP checks that every individual regular expression \fIL\fP in \fILL1\fP, ..., \fILLn\fP matches some label of \fIB\fP.
If not, then \fBexp.open\fP will issue a warning.
.P
The optional "gate", "total", and "partial" keywords define the matching mode, in the same way as for the "hide" and "cut" operators.
The matching mode by default is "gate".
.P
\fBExamples:\fP
.IP -
The following expression:
.nf

gate prio
    "A.*" > B > all but "A.*", B
in
    "f.bcg"
end prio

.fi
defines an LTS in which every transition whose gate starts with the letter "A" has priority over every transition whose gate is "B", which themselves have priority over all other transitions.
.IP -
The following expression:
.nf

partial prio
    "A" > all but "A"
in
    "f.bcg"
end prio

.fi
defines an LTS in which every transition whose label contains the letter "A" has priority over every transition whose label does not contain the letter "A" (including hidden transitions).
.IP -
The following expression:
.nf

total prio
    "A" > "B" > "C"
    "D" > "E" > "F"
    "A" > "D"
    "B" > "E"
    "C" > "F"
in
    "f.bcg"
end prio

.fi
defines an LTS in which A has priority over B, C, D, E, and F, B has priority over C, E, and F, C has priority over F, D has priority over E and F, and E has priority over F.
.P
Note: Strong bisimulation is a congruence for all \fBexp.open\fP operators, including "prio".
However, branching, observational, and safety equivalences are congruences for all \fBexp.open\fP hiding, cutting, renaming, and parallel composition operators, but not for "prio".
It should also be noted that tau*.a equivalence is not a congruence for parallel composition.

.SS GENERALIZED PARALLEL

.nf
  [gate | label] par [(all | \fIS\fP) in]
    [\fIS\fP ->] \fIB\fP ("||" [\fIS\fP ->] \fIB\fP)+ end par

.fi
is an extension of the E-LOTOS/LNT generalized parallel composition operator presented in [Garavel-Sighireanu-99].
It denotes the concurrent execution of parallel behaviours following synchronisation rules expressed using:
.IP -
the keyword "all" or the list \fIS\fP that follows the keyword "par", called \fIglobal synchronisation interface\fP, and
.IP -
the lists \fIS\fP that precede the symbols "->", called \fIlocal synchronisation interfaces\fP.
.P
Synchronisation interfaces \fIS\fP are lists of synchronisation elements of the form \fIL\fP or \fIL#N\fP, where \fIL\fP is a gate or a label and \fIN\fP is a natural number called \fIsynchronisation degree\fP.
.P
The semantics of synchronisation rules is defined in the following paragraphs.
.P
The "gate" or "label" keywords indicate the \fIsynchronisation mode\fP, which influences the way synchronisation rules apply to transition labels.
We say that a transition matches a synchronisation element of the form \fIL\fP or \fIL#N\fP in the following cases:
.IP -
In "gate" synchronisation mode, a transition matches \fIL\fP or \fIL#N\fP if the gate of the transition label is \fIL\fP.
Therefore, for every synchronisation element of the form \fIL\fP or \fIL#N\fP occurring in a synchronisation interface, \fIL\fP must be a gate without offers.
See Section SYNTAX OF EXP 2.0 above, which explains how the gate of a transition is extracted from its label.
.IP -
In "label" synchronisation mode, a transition matches \fIL\fP or \fIL#N\fP if the transition label is \fIL\fP.
Therefore, for every synchronisation element of the form \fIL\fP or \fIL#N\fP occurring in a synchronisation interface, \fIL\fP must be a full label (i.e., a gate possibly followed by offers).
.P
Unlike "hide", "cut", and "rename", regular expressions are not allowed in synchronisation elements.
If not specified, the synchronisation mode by default is "gate".
.P
The keyword "all" is a shorthand notation for the global synchronisation set consisting of all synchronisation elements \fIL\fP (without degree) such that \fIL\fP is the gate (in "gate" synchronisation mode) or the label (in "label" synchronisation mode) of a transition in at least one of the parallel behaviours, except hidden and termination labels.
.P
Synchronisation elements have the following meaning:
.IP -
A synchronisation element of the form \fIL\fP (without degree) occurring in the global synchronisation interface indicates that all parallel behaviours may synchronise all together on transitions that match \fIL\fP.
.IP -
A synchronisation element of the form \fIL\fP (without degree) occurring in a local synchronisation interface indicates that all parallel behaviours that contain \fIL\fP in their synchronisation interface may synchronise all together on transitions that match \fIL\fP.
.IP -
A synchronisation element of the form \fIL#N\fP occurring in the global synchronisation interface indicates that \fIN\fP behaviours among the parallel behaviours may synchronise together on transitions that match \fIL\fP.
.IP -
A synchronisation element of the form \fIL#N\fP occurring in a local synchronisation interface indicates that \fIN\fP behaviours among the parallel behaviours that contain \fIL#N\fP in their synchronisation interface may synchronise on transitions that match \fIL\fP.
.IP -
A transition in a parallel behaviour may execute asynchronously if both the global synchronisation interface and the local synchronisation interface of that behaviour do not contain any element of the form \fIL\fP or \fIL#N\fP such that the transition matches \fIL\fB.
.P
Note that both the global synchronisation interface and local synchronisation interfaces may contain several synchronisation elements with same label \fIL\fP but different synchronisation degrees.
In this case, the corresponding synchronisation rules apply nondeterministically.
.P
Following the above meaning of synchronisation elements, it is possible to prevent the execution of particular transitions matching \fIL\fP by using synchronisation elements of the form \fIL#0\fP, either in the global synchronisation interface (thus preventing execution of transitions matching \fIL\fP in all parallel behaviours) or in local synchronisation interfaces (thus preventing execution of transitions matching \fIL\fP in those behaviours containing \fIL#0\fP in their interface), provided the (global or local) interface does not contain another occurrence of \fIL\fP or \fIL#N\fP with \fIN\fP a strictly positive number.
.P
Transition synchronisation is a generalization of LOTOS rendezvous: synchronisation requires that all transitions have exactly the same label (i.e., gate and possible offers), which is also the label of the resulting transition.
.P
Note that synchronisation interfaces can neither contain the hidden gate nor the termination gate.
Behaviours always synchronise on labels whose gate is the termination gate and never synchronise on hidden transitions.
.P
Before generating the graph module, \fBexp.open\fP checks that generalized parallel operators are well-formed, i.e.:
.IP -
If the global synchronisation interface contains a synchronisation element of the form \fIL#N\fP with \fIN\fP > 0, then the parallel composition must contain at least \fIN\fP parallel behaviours.
.IP -
If the global synchronisation interface contains a synchronisation element of the form \fIL#0\fP, then no synchronisation element of the form \fIL\fP or \fIL#N\fP with same \fIL\fP and \fIN\fP > 0 should occur in the global synchronisation interface or in any local synchronisation interface.
.IP -
If a local synchronisation interface contains a synchronisation element of the form \fIL\fP (without degree), then at least two local synchronisation interfaces (this one included) should contain the same synchronisation element.
However, if the intention is to explicitly indicate that the behaviour should not synchronise on \fIL\fP, then the synchronisation element can be written in the form \fIL#1\fP.
Synchronisation elements of the form \fIL#1\fP can also be used in the global interface to indicate that all transitions matching \fIL\fP may execute asynchronously in all behaviours that contain \fIL\fP.
.IP -
If a local synchronisation interface contains a synchronisation element of the form \fIL#N\fP with \fIN\fP > 0, then at least \fIN\fP local synchronisation interfaces (this one included) should contain the same synchronisation element.
.IP -
If a local synchronisation interface contains a synchronisation element of the form \fIL#0\fP, then no synchronisation element of the form \fIL\fP or \fIL#N\fP with same \fIL\fP and \fIN\fP > 0 should occur in the global synchronisation interface or in the same local synchronisation interface.
.IP -
If the global synchronisation interface contains a synchronisation element of the form \fIL\fP, then all parallel behaviours must contain a label matching \fIL\fP.
.IP -
If the global synchronisation interface contains a synchronisation element of the form \fIL#N\fP, then at least \fIN\fP parallel behaviours must contain a label matching \fIL\fP.
.IP -
If a local synchronisation interface contains a synchronisation element of the form \fIL\fP or \fIL#N\fP, then the corresponding parallel behaviours must contain a label matching \fIL\fP.
.P
Warnings are issued if those conditions are not satisfied.
These checks can be discarded by using the \fB-nocheck\fP option of
.BR exp.open (LOCAL).
This is not recommended because errors may lead to unpredictable behaviours.
.P
\fBExamples:\fP
.nf
gate par G#2 in
   G4, G1 -> "f1.bcg"
|| G1, G2 -> "f2.bcg"
|| G2, G3 -> "f3.bcg"
|| G3, G4 -> "f4.bcg"
end par
.fi
.P
represents an automaton such that:
.IP -
any two automata among "f1.bcg", "f2.bcg", "f3.bcg", and "f4.bcg" synchronise on transitions whose gate is \fIG\fP
.IP -
"f1.bcg" and "f2.bcg" synchronise on transitions whose gate is \fIG1\fP
.IP -
"f2.bcg" and "f3.bcg" synchronise on transitions whose gate is \fIG2\fP
.IP -
"f3.bcg" and "f4.bcg" synchronise on transitions whose gate is \fIG3\fP
.IP -
"f4.bcg" and "f1.bcg" synchronise on transitions whose gate is \fIG4\fP
.IP -
"f1.bcg" executes transitions whose gate is neither \fIG\fP, \fIG1\fP, \fIG4\fP, nor the termination gate, without synchronising with others
.IP -
etc.
.P
.nf
gate par G#2, G#3 in
   "f1.bcg"
|| "f2.bcg"
|| "f3.bcg"
|| "f4.bcg"
end par
.fi
.P
represents an automaton such that:
.IP -
any two or three automata among "f1.bcg", "f2.bcg", "f3.bcg", and "f4.bcg" synchronise on transitions whose gate is \fIG\fP
.IP -
any of "f1.bcg", "f2.bcg", "f3.bcg", or "f4.bcg" executes transitions whose gate is neither \fIG\fP nor the termination gate, without synchronising with others
.P
.nf
gate par G in
   G1#2, G2 -> "f1.bcg"
|| G1#2 -> "f2.bcg"
|| G1#2 -> "f3.bcg"
|| G2 -> "f4.bcg"
end par
.fi
.P
represents an automaton such that:
.IP -
all automata "f1.bcg", "f2.bcg", "f3.bcg", and "f4.bcg" synchronise on transitions whose gate is \fIG\fP
.IP -
any two automata among "f1.bcg", "f2.bcg", and "f3.bcg" synchronise on transitions whose gate is \fIG1\fP
.IP -
"f1.bcg" and "f4.bcg" synchronise on transitions whose gate is \fIG2\fP
.IP -
"f1.bcg" executes transitions whose gate is neither \fIG\fP, \fIG1\fP, \fIG2\fP, nor the termination gate, without synchronising with others
.IP -
etc.
.P
.nf
gate par
   G#1, G#2 -> "f1.bcg"
|| G#1, G#2 -> "f2.bcg"
|| G#1, G#2 -> "f3.bcg"
end par
.fi
.P
represents an automaton such that transitions of "f1.bcg", "f2.bcg", and "f3.bcg" whose gate is \fIG\fP may either synchronise by pair, or execute asynchronously.

.SS PARALLEL WITH SYNCHRONISATION VECTORS

.nf
  [gate | label] par using \fISV\fP (, \fISV\fP)* in \fIB\fP ("||" \fIB\fP)* end par

.fi
is parallel composition with \fIsynchronisation vectors\fP.
It denotes the concurrent execution of behaviours following synchronisation rules, expressed using vectors of gates (in "gate" synchronisation mode) or labels (in "label" synchronisation mode).
.P
A synchronisation vector \fISV\fP has the form "\fIE1\fP || ... || \fIEn\fP -> L", or equivalently "\fIE1\fP * ... * \fIEn\fP -> L", where each \fIEi\fP (\fIi = 1..n\fP) is either a visible gate without offers (in "gate" synchronisation mode), a visible label, i.e., visible gate with offers (in "label" synchronisation mode), or the special symbol "_" (in both synchronisation modes).
Note that gates and labels must not be defined using regular expressions.
If it is not specified, the synchronisation mode by default is "gate".
See Section SYNTAX OF EXP 2.0 above, which explains how the gate of a label is recognized.
.P
The left-hand side (left of the arrow) of each synchronisation vector must have as many gates (or labels) and "_" symbols as there are behaviours \fIB\fP in parallel.
A gate (or label) \fIG\fP as nth component of a vector left-hand side means that the nth behaviour in the parallel composition can perform a transition whose gate is \fIG\fP only if all behaviours can perform simultaneously as specified by the same vector, possibly on different gates, but with same offers (in "gate" synchronisation mode).
"_" means that no transition is required for the corresponding behaviour.
The resulting transition is labelled with the right-hand side of the vector (in "label" synchronisation mode) or with the right-hand side of the vector, followed by the offers, if any (in "gate" synchronisation mode).
The hidden string is forbidden in the left-hand side of a synchronisation vector.
.P
Transitions that do not fit any vector are blocked, except hidden transitions, which always perform asynchronously.
In particular, if one wants to let visible transitions perform asynchronously, it is necessary to define vectors whose left-hand side contain only "_" but one visible gate.
.P
\fBExample:\fP
.nf
gate par using
  G1 || _  || G3 -> G13,
  G1 || G2 || _  -> G12,
  G1 || _  || _  -> G1
  H  || _  || _  -> H
in
  "f1.bcg" || "f2.bcg" || "f3.bcg"
end par
.fi
.P
represents the automaton defined as follows:
.IP 1):
if "f1.bcg" can perform a transition whose gate is G1, possibly followed with experiment offers (written \fIO1...On\fP), then a transition labelled "G1 \fIO1... On\fP" is created in the resulting automaton due to the vector "G1 || _ || _ -> G1"
.IP 2):
if, additionally to 1), "f3.bcg" can perform a transition labelled "G3 \fIO1...On\fP", then a transition labelled "G13 \fIO1...On\fP" is created in the resulting automaton due to the vector "G1 || _ || G3 -> G13"
.IP 3):
if, additionally to 1), "f2.bcg" can perform a transition labelled "G2 \fIO1...On\fP", then a transition labelled "G12 \fIO1...On\fP" is created in the resulting automaton due to the vector "G1 || G2 || _ -> G12"
.IP 4):
if "f1.bcg" can perform a transition whose gate is H, then the same transition is created in the resulting automaton, due to the vector "H || _ || _ -> H"
.IP 5):
all other transitions of "f1.bcg", "f2.bcg" and "f3.bcg" do not create any transition in the resulting automaton.

.SS L\&O\&T\&O\&S PARALLEL
.nf
  \fIB\fP "||" \fIB\fP

| \fIB\fP "|||" \fIB\fP

| \fIB\fP "|[" \fIGL\fP "]|" \fIB\fP

.fi
have the same semantics as, respectively:
.nf
gate par all in \fIB\fP "||" \fIB\fP end par
.br
gate par \fIB\fP "||" \fIB\fP end par
.br
gate par \fIGL\fP in \fIB\fP "||" \fIB\fP end par
.fi
Note that in mCRL mode, "||" has a different semantics (see MCRL PARALLEL).
Note also that the "|||" operator of CSP has the same semantics as in LOTOS.

.SS C\&C\&S PARALLEL
.nf
  \fIB\fP "|" \fIB\fP

.fi
is the parallel composition operator of CCS.
.P
Transitions of both behaviours may either perform asynchronously, or may synchronise, resulting in a hidden event.
.P
Synchronisation is possible only if the corresponding transition labels are \fIco-actions\fP, i.e., they have the same gate and offers, but one of the gates is prefixed with the co-action prefix.
The co-action prefix by default is "'" but can be modified using the \fB-coaction\fP option of
.BR exp.open (LOCAL).
Note that (1) the co-action prefix should not contain !, ?, (, space, and tabulation characters, which are used to delimit a gate from its offer, and (2) there should not be any space or tabulation between the co-action prefix and the gate identifier (see Section SYNTAX OF EXP 2.0 above, which explains how the gate of a label is recognized).
.P
For instance, transitions labelled "G" and "'G" may synchronise, as well as transitions labelled "G O" and "'G O".
In both cases, the resulting label after synchronisation is the hidden label.
.P
Note that hidden transitions perform asynchronously and that there is no termination label in CCS.

.SS C\&S\&P PARALLEL
.nf
  \fIB\fP "|||" \fIB\fP

| \fIB\fP "[|" "{" \fIGL\fP "}" "|]" \fIB\fP

| \fIB\fP "[" "{" \fIGL\fP "}" "||" "{" \fIGL\fP "}" "]" \fIB\fP

.fi
denote parallel composition in CSP.
.IP -
"|||" has the same semantics as in LOTOS (see LOTOS PARALLEL above).
.IP -
"[|" "{" \fIGL\fP "}" "|]" has the same semantics as LOTOS "|[" \fIGL\fP "]|" (see LOTOS PARALLEL above).
.IP -
In "\fIB1\fP [{\fIGL1\fP}||{\fIGL2\fP}] \fIB2\fP", transitions of \fIB1\fP (respectively \fIB2\fP) perform asynchronously if their gate is in \fIGL1\fP (respectively \fIGL2\fP) but not in \fIGL2\fP (respectively \fIGL1\fP).
Transitions of \fIB1\fP and \fIB2\fP synchronise if they have the same label, the gate of which is either both in \fIGL1\fP and \fIGL2\fP or the termination gate (usually written "delta" in CSP).
Other transitions are cut off.
As usual, hidden transitions perform asynchronously.
See Section SYNTAX OF EXP 2.0 above, which explains how the gate of a label is recognized.

.SS M\&C\&R\&L PARALLEL
.nf
  \fIB\fP "||" \fIB\fP

.fi
denotes parallel composition in mCRL.
.P
In "\fIB1\fP || \fIB2\fP", transitions may either perform asynchronously, or they may synchronise following communication rules, that must be defined in the preamble of the EXP file ("comm" keyword).
A communication rule has the form "\fIG1\fP | \fIG2\fP = \fIG3\fP", where \fIG1\fP, \fIG2\fP, and \fIG3\fP are gates.
Communication rules are commutative, i.e., there is no difference between "\fIG1\fP | \fIG2\fP = \fIG3\fP" and "\fIG2\fP | \fIG1\fP = \fIG3\fP".
Such a rule means that if an operand (\fIB1\fP or \fIB2\fP) may perform a transition whose gate is \fIG1\fP and the other operand may perform a transition whose gate is \fIG2\fP, and both transitions carry the same experiment offers \fIO\fP, then a synchronisation is possible and results in a transition labelled "\fIG3 O\fP".
See Section SYNTAX OF EXP 2.0 above, which explains how the gate of a label is recognized.
.P
Note that hidden transitions must perform asynchronously, and that there must be at most one communication rule for each pair of gates occurring in the left-hand side of the "=" symbol.
For instance, the following is not allowed:
.nf
comm G1 | G2 = G3, G2 | G1 = G4 end comm
.fi
.P
Note that the reference language must be mCRL in order for the "||" operator to have mCRL semantics instead of LOTOS semantics.  If the reference language is different from mCRL, then any "comm" definition is useless and irrelevant.

.SS C\&C\&S RESTRICTION
.nf
  \fIB\fP \\ "{" \fIL\fP (, \fIL\fP)* "}"

| \fIB\fP \\ \fIL\fP

.fi
denotes the CCS restriction operator, except when the language option is set to CSP (see Section CSP HIDING below).
In the first form, the behaviour \fIB\fP is restricted with respect to several labels, whereas in the second form it is restricted with respect to a single label.
.P
CCS restriction is similar to cut (in gate matching mode), except that co-action labels are also affected by the restriction whenever the corresponding action label is affected.
.P
For instance, in "\fIB\fP \\ \fIG\fP", transitions of \fIB\fP labelled "\fIG\fP", "\fI'G\fP" (where "'" stands for the co-action prefix), "\fIG O\fP" (where \fIO\fP denotes any communication offer), and "'\fIG\fP O" are cut off.
See Section SYNTAX OF EXP 2.0 above, which explains how the gate of a label is recognized.
.P
Note that labels in the restriction set can be regular expressions denoting gates, but should not have offers and should not start with the co-action prefix.

.SS C\&S\&P HIDING
.nf
  \fIB\fP \\ "{" \fIL\fP (, \fIL\fP)* "}"

| \fIB\fP \\ \fIL\fP

.fi
denotes the CSP hiding operator when the language option is set to CSP (otherwise it denotes the CCS restriction operator, see Section CCS RESTRICTION above).
Both forms are equivalent to
.nf
gate hide \fIL\fP (, \fIL\fP)* in \fIB\fP end hide

gate hide \fIL\fP in \fIB\fP end hide
.fi
respectively.

.SS C\&C\&S RELABELING
.nf
  \fIB\fP "[" \fIL\fP / \fIL\fP (, \fIL\fP / \fIL\fP)* "]"

.fi
denotes the CCS relabeling operator.
It is similar to the renaming operator (in gate matching mode) except that the co-action prefix is preserved by renaming.
.P
For instance, in "\fIB\fP [\fIG1\fP/\fIG2\fP]", the labels "\fIG2\fP", "'\fIG2\fP" (where "'" stands for the co-action prefix), "\fIG2\fP \fIO\fP" (where \fIO\fP denotes any communication offer), and "'\fIG2\fP \fIO\fP" are renamed respectively into "\fIG1\fP", "'\fIG1\fP", "\fIG1\fP \fIO\fP", and "'\fIG1\fP \fIO\fP".
See Section SYNTAX OF EXP 2.0 above, which explains how the gate of a label is recognized.
.P
Note that labels can be regular expressions denoting gates, but should not have offers and should not start with the co-action prefix.

.SS C\&S\&P RELABELING
.nf
  \fIB\fP "[[" \fIL\fP <- \fIL\fP (, \fIL\fP <- \fIL\fP)* "]]"

.fi
denotes the CSP relabeling operator.
.P
The behaviour
.nf
\fIB [[ G1 <- G2, ..., G2n+1 <- G2n+2 ]]\fP
.fi
is equivalent to
.nf
\fIgate rename G1 -> G2, ..., G2n+1 -> G2n+2 in B\fP
.fi
.P
(Note the opposite direction of the arrows.)
.P
Note that, as a consequence, labels can be regular expressions denoting gates, but should not have offers.

.SH LANGUAGE PARAMETERS

.P
There are two means to select a reference language:
.IP -
Using 
.BR exp.open (LOCAL)
with a command line option (\fB-lotos\fP, \fB-elotos\fP, \fB-ccs\fP, \fB-csp\fP, or \fB-mcrl\fP), or
.IP -
Specifying the language in the EXP file header ("lotos behaviour", "elotos behaviour", etc.).
Note that "behaviour" or "behavior" alone is equivalent to "lotos behaviour" when no language option is set.
The absence of the "behaviour" or "behavior" keyword means that no reference language is set.
.P
If the EXP file header and the command line option specify different reference languages, then a warning is issued.
It is not allowed to specify more than one language option on the command line.
.P
The following table summarizes the default parameter values according to reference languages.
Note that these values (in particular lines labelled none and LOTOS) are compatible with \fBexp.open\fP version 1.0.

.ne 18v
.nf
.cs R 23
+----------+--------+--------+-------------+------+-------+
| language | hidden | termin.|    case     | sem. | sem.  |
|          | event  |  gate  | sensitivity | of \\ | of || |
+----------+--------+--------+-------------+------+-------+
| none     |   "i"  | "exit" |  sensitive  | CCS  | LOTOS |
+----------+--------+--------+-------------+------+-------+
| LOTOS    |   "i"  | "exit" | insensitive | CCS  | LOTOS |
+----------+--------+--------+-------------+------+-------+
| E-LOTOS* |   "i"  | "exit" |  sensitive  | CCS  | LOTOS |
+----------+--------+--------+-------------+------+-------+
| CCS      |   "t"  |  N/A   | insensitive | CCS  | LOTOS |
+----------+--------+--------+-------------+------+-------+
| CSP      |   "t"  | "delta"| insensitive | CSP  | LOTOS |
+----------+--------+--------+-------------+------+-------+
| mCRL     |  "tau" |  N/A   |  sensitive  | CCS  | mCRL  |
+----------+--------+--------+-------------+------+-------+
.cs R
.fi
where N/A stands for \fINot Applicable\fP.
.P
* The parameters associated to E-LOTOS are subject to modifications in the future, depending on implementation choices still to be made.
.P
Note that the hidden string (written either "i", "t", "tau", or anything else) should not be followed by communication offers, whereas the termination string may.

.SH HOW TO CREATE AN E\&X\&P FILE

.P
At present, EXP files can be either written by hand or produced automatically by
.BR svl (LOCAL)
from SVL scripts containing some parallel composition operator.

.SH HOW TO READ AN E\&X\&P FILE

At present, there is one single CADP tool,
.BR exp.open (LOCAL),
that reads and processes EXP files.

.SH BIBLIOGRAPHY

.IP [Berthomieu-Ribet-Vernadat-04]
B. Berthomieu, P.-O. Ribet, and F. Vernadat.
The tool TINA - Construction of Abstract State Spaces for Petri Nets and Time Petri Nets.
In International Journal of Production Research, Vol. 42, No 14, July 2004.

.IP [Best-Grahlmann-98]
Eike Best and Bernd Grahlmann.
"PEP Documentation and User Guide."
http://parsys.informatik.uni-oldenburg.de/~pep/paper.html. 1998."

.IP [Bouali-Ressouche-Roy-deSimone-96]
Amar Bouali, Annie Ressouche, Valerie Roy, and Robert de Simone.
The Fc2Tools set: a Toolset for the Verification of Concurrent Systems.
In R. Alur and T.A. Henzinger, editors, Proceedings of the 8th Conference on Computer-Aided Verification (New Brunswick, New Jersey, USA). Lecture Notes in Computer Science volume 1102, Springer-Verlag, 1996.

.IP [Brookes-Hoare-Roscoe-84]
S. D. Brookes, C. A. R. Hoare, and A. W. Roscoe.
"A Theory of Communicating Sequential Processes."
In Journal of the ACM, vol. 31, number 3, pages 560-599. ACM, 1984.

.IP [Garavel-15-a]
Hubert Garavel.
"Nested-Unit Petri Nets: A Structural Means to Increase Efficiency and Scalability of Verification on Elementary Nets."
In R. Devillers and A. Valmari, editors, Proceedings of the 36th International Conference on Application and Theory of Petri Nets and Concurrency (Brussels, Belgium). Lecture Notes in Computer Science volume 9115, Springer-Verlag, 2015.
Available from http://cadp.inria.fr/publications/Garavel-15-a.html

.IP [Garavel-Sighireanu-99]
Hubert Garavel and Mihaela Sighireanu.
"A Graphical Parallel Composition Operator for Process Algebras."
In J. Wu, Q. Gao, and S.T. Chanson, editors, Proceedings of the Joint International Conference on Formal Description Techniques for Distributed Systems and Communication Protocols, and Protocol Specification, Testing, and Verification FORTE/PSTV'99 (Beijing, China).
Kluwer Academic Publishers, 1999.
Available from http://cadp.inria.fr/publications/Garavel-Sighireanu-99.html

.IP [Groote-Ponse-90]
J.F. Groote and A. Ponse.
"The syntax and semantics of mCRL."
In A. Ponse, C. Verhoef and S.F.M. van Vlijmen, editors, Algebra of Communicating Processes '94, Workshops in Computing Series, Springer-Verlag, pp. 26-62, 1995.
Also appeared as: Technical Report CS-R9076, CWI, Amsterdam, 1990.

.IP [ISO-89]
ISO/IEC.
"LOTOS --- A Formal Description Technique Based on the Temporal Ordering of Observational Behaviour."
International Organization for Standardization --- Information Processing Systems --- Open Systems Interconnection.
International Standard number 8807.
Geneva, September 1989.

.IP [ISO-01]
ISO/IEC.
"Enhancements to LOTOS (E-LOTOS)."
International Organization for Standardization --- Information Technology.
International Standard number 15437:2001.
Geneva, September 2001.

.IP [Lang-05]
Frederic Lang.
"EXP.OPEN 2.0: A Flexible Tool Integrating Partial Order, Compositional, and On-the-fly Verification Methods."
In J. van de Pol, J. Romijn and G. Smith, editors, Proceedings of the 5th International Conference on Integrated Formal Methods IFM'2005 (Eindhoven, The Netherlands).
Lecture Notes in Computer Science volume 3771, Springer-Verlag, 2005.
Available from http://cadp.inria.fr/publications/Lang-05.html

.IP [Lang-06]
Frederic Lang.
"Refined Interfaces for Compositional Verification."
In E. Najm, J.-F. Pradat-Peyre and V. Viguie Donzeau-Gouge, editors, Proceedings of the 26th IFIP WG 6.1 International Conference on Formal Techniques for Networked and Distributed Systems FORTE'2006 (Paris, France).
Lecture Notes in Computer Science volume 4229, Springer-Verlag, 2006.
Available from http://cadp.inria.fr/publications/Lang-06.html

.IP [Milner-89]
Robin Milner.
"Communication and Concurrency."
Prentice-Hall, 1989.

.IP [Pace-Lang-Mateescu-03]
Gordon Pace, Frederic Lang, and Radu Mateescu.
"Calculating tau-confluence compositionally."
In W.A. Hunt Jr. and F. Somenzi, editors, 15th Computer-Aided Verification conference (CAV 2003), Lecture Notes in Computer Science volume 2725, Springer-Verlag, 2003.
Available from http://cadp.inria.fr/publications/Pace-Lang-Mateescu-03.html

.SH SEE ALSO

.BR aldebaran (LOCAL),
.BR aut (LOCAL),
.BR bcg (LOCAL),
.BR bcg_io (LOCAL),
.BR caesar_hide_1 (LOCAL),
.BR caesar_rename_1 (LOCAL),
.BR exp.open (LOCAL),
.BR lotos.open (LOCAL),
.BR projector (LOCAL),
.BR regexp (LOCAL),
.BR seq (LOCAL),
.BR svl (LOCAL)
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
Please report bugs to cadp@inria.fr



