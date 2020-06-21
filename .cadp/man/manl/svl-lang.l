'\" t
.\" @(#)svl-lang.l - VASY and CONVECS teams - 2020/02/12
.TH SVL LOCAL "2020/02/12" "(C) INRIA" "CADP MANUAL PAGES"
.fp 4 CB
.lg 0

.cs 4 23

.SH NAME
svl, SVL \- script language for verification scenarios

.SH DESCRIPTION 
.P
SVL (\fIScript Verification Language\fP) offers a way to describe (compositional and on-the-fly) verification scenarios, under the form of sequences of statements of several kinds:
.IP -
assignment statements, which produce a file containing a representation of a given expression;
.IP -
comparison statements, which compare two expressions modulo some equivalence or preorder relation;
.IP -
statements for verifying a temporal logic formula in an expression;
.IP -
statements for checking livelocks or deadlocks in an expression.
.P
Expressions are built upon the following components:
.IP -
behaviour systems represented either implicitly (as LNT, LOTOS, or FSP programs, processes in LNT, LOTOS, or FSP programs, or networks of communicating automata in the EXP format), or explicitly (as Labelled Transition Systems in one of the formats provided with CADP, namely BCG, AUT, sequential FC2, or SEQ);
note that the parallel FC2 format is no longer supported;
.IP -
LNT and LOTOS like parallel operators, enabling parallel composition of expressions;
.IP -
label hiding, label cutting, and label renaming operators;
.IP -
operators of abstraction of an expression with respect to some interface;
.IP -
operators for generating the explicit LTS of an expression;
.IP -
operators of (total or partial) reduction modulo some equivalence relation;
.IP -
so-called \fImeta-operators\fP of (total or partial) reduction, that apply to SVL abstract trees during a preliminary compilation phase called "expansion"; the meta-operators implement several useful compositional reduction strategies.
.P
Moreover, SVL offers a way to invoke Bourne shell commands and to parameterize expressions with respect to particular tools and methods of CADP.

.SH SYNTAX DESCRIPTION
.P
The syntax of SVL is described using productions in the Extended Bachus-Naur Form (EBNF). 
.P
Terminal symbols are written between double quotes, except for the double quote itself, which is written between single quotes. The newline character is written "\\n". Non-terminal symbols are written in italic. Optional parts of productions are enclosed between square brackets, and parts that can be iterated zero or more times are written between braces.
.P
The following table sums up the non-terminal symbols and their meaning.

.ne 27v
.nf
.cs I 23
\fB   +-----------+--------------------------------------+
   | Symbol    |            Description               |
   +-----------+--------------------------------------+
   | \fIP\fP         | program, sequence of statements      |
   | \fIS, S1, S2\fP | statement                            |
   | \fIF\fP         | file                                 |
   | \fIEXT\fP       | file extension                       |
   | \fIB\fP         | behaviour expression                 |
   | \fISPEC\fP      | behaviour specification              |
   | \fIE\fP         | equivalence relation                 |
   | \fIM\fP         | verification method                  |
   | \fIT\fP         | verification tool                    |
   | \fIRE\fP        | result and/or expected value         |
   | \fILL\fP        | list of labels                       |
   | \fIL\fP         | label                                |
   | \fIGPL\fP       | list of gate parameters              |
   | \fIG\fP         | gate                                 |
   | \fIAL\fP        | list of data parameters (process)    |
   | \fIA\fP         | data parameter (process)             |
   | \fITL\fP        | list of (possibly typed) labels      |
   | \fILD\fP        | list of synchronization definitions  |
   | \fIRL\fP        | list of renaming rules               |
   | \fILP\fP        | label pattern                        |
   | \fIPID\fP       | process/property identifier          |
   | \fIC\fP         | LNT channel identifier               |
   | \fIO\fP         | data operator                        |
   +-----------+--------------------------------------+\fP
.cs I
.fi

.SH SYNTAX OF PROGRAMS
.P
A program is a sequence of statements, separated in two categories: \fIS1\fP and \fIS2\fP.
Statements in \fIS2\fP are composed sequentially with subsequent statements using the ";" character.
Statements in \fIS1\fP have their own terminating character and do not need a ";" separator.

.ne 4v
.nf
.cs I 23
    \fIP\fP  ::= <\fIempty\fP>
        |  \fIS1\fP [ \fIP\fP ]
        |  \fIS2\fP [ ";" \fIP\fP ]
.cs I
.fi
.P
Statements are either assignments, behaviour comparisons, temporal logic verifications, deadlock/livelock checks, Bourne shell commands, property definitions, or property checks.
A property definition can embed other statements.
It is given a name, optional parameters, comments, and possibly an expected result that must be attached to each embedded verification statement, namely behaviour comparisons, temporal logic verifications, and deadlock/livelock checks.
An expected result may also be attached optionally to Bourne shell commands.
.P
Comparisons can be parameterized modulo a particular equivalence relation (\fIE\fP), with a particular CADP tool (\fIT\fP), and using a particular exploration method provided by the selected tool (\fIM\fP).
.P
Temporal logic formulas can be either stored in a file or inlined in the SVL script.
.P
Deadlock/livelock checks can be parameterized with a particular CADP tool.
.P
Comparisons, temporal logic verifications, and deadlock/livelock checks may produce diagnostic files.
.P
Assignments produce LTS files.
.P
Using the keyword "result \fIresult-id\fP", one can associate to a comparison, temporal logic verification, deadlock/livelock verification, or Bourne shell command a shell variable \fIresult-id\fP in which the result (of the verification or Bourne shell command) will be stored.
Such shell-variables can be used to guide the script execution depending on verification results, using Bourne shell commands.

.nf
.cs I 23
    \fIS1\fP ::= "%" \fIshell-line\fP "\\n"

        |  "property" \fIPID\fP ["("\fIparam\fP"," ..."," \fIparam\fP")"]
               ['"'\fIcomment\fP'"' ... '"'\fIcomment\fP'"']
           "is"
               \fIP\fP
           "end property"

        |  [\fIF\fP "="] \fIB\fP "|=" ["using" \fIM\fP] ["with" \fIT\fP] \fIformula\fP ";"

    \fIS2\fP ::= "%" \fIshell-line\fP "\\n"
               \fIRE\fP

        | \fIF\fP "=" \fIB\fP 

        |  "check" \fIPID\fP "(" \fIarg\fP "," ... "," \fIarg\fP ")"

        |  [\fIF\fP "="] [\fIE\fP]  ["probabilistic" | "stochastic"]
               "comparison" ["using" \fIM\fP] ["with" \fIT\fP]
               \fIB\fP ("==" | ">=" | "<=") \fIB\fP [ ";" \fIRE\fP ]

        |  [\fIF\fP "="] "verify" \fIF\fP ["using" \fIM\fP] ["with" \fIT\fP] "in"
               \fIB\fP [ ";" \fIRE\fP ]

        |  [\fIF\fP "="] "deadlock" ["with" \fIT\fP] "of"
               \fIB\fP [ ";" \fIRE\fP ]

        |  [\fIF\fP "="] "livelock" ["with" \fIT\fP] "of"
               \fIB\fP [ ";" \fIRE\fP ]

        |  [\fIF\fP "="] \fIB\fP "|=" ["using" \fIM\fP] ["with" \fIT\fP] \fIformula\fP ";"
               \fIRE\fP

    \fIRE\fP ::= "result" \fIL1\fP
        |  "expected" \fIL2\fP
        |  "result" \fIL1\fP "expected" \fIL2\fP

    \fIE\fP  ::= "strong" | "observational" | "branching"
        |  "divbranching" | "tau*.a" | "safety" | "trace"
        |  "weak trace" | "tau-confluence"
        |  "tau-compression" | "tau-divergence"
 
    \fIM\fP  ::= "std" | "bdd" | "fly" | "bfs" | "dfs"
        |  "acyclic"

    \fIT\fP  ::= "aldebaran" | "bcg_min" | "bcg_cmp"
        |  "bisimulator" | "evaluator" | "evaluator3"
        |  "evaluator4" | "evaluator5" | "exhibitor"
        |  "reductor" 
.cs I
.fi
.P
Note that the keyword "expected" is only allowed in the scope of a "property" statement.
.P
Note that \fBfc2tools\fP are no longer supported.
.P
Files are written between double quotes, and must specify a valid extension. Not all extensions are valid in all contexts, as stated more precisely in the sections describing the particular statements and behaviours. 

.nf
.cs I 23
    \fIF\fP   ::= '"'\fIprefix\fP.\fIEXT\fP'"' | '"'\fIfilename\fP'"'

    \fIEXT\fP ::= "aut" | "bcg" | "fc2" | "seq" 
         |  "lnt" | "lotos" | "lot" | "lts" | "exp" 
         |  "hide" | "hid" | "cut" | "rename" | "ren" | "sync" 
         |  "mcl" | "xtl"
.cs I
.fi

A file \fIprefix\fP is any string satisfying the syntax of file names in the current operating system.

.SH SYNTAX OF BEHAVIOUR EXPRESSIONS
.P
Behaviour expressions are built from elementary systems, that are combined together using the various operators described below.

.nf
.cs I 23
.ne 27v
    \fIB\fP   ::= \fISPEC\fP

         |  "stop"

         |  "generation" "of" \fIB\fP

         |  ["leaf" | "root" | "root leaf" | "node" | "smart"]
            ["total" | "partial"]
            [\fIE\fP] ["probabilistic" | "stochastic"]
            "reduction" ["using" \fIM\fP] ["with" \fIT\fP]
            "of" \fIB\fP

         |  ["total" | "partial" | "gate"] "hide" 
            (["all" "but"] [\fITL\fP] | "using" \fIF\fP) "in" \fIB\fP 
            ["end" "hide"]

         |  ["total" | "partial" | "gate"] "cut" 
            (["all" "but"] [\fITL\fP] | "using" \fIF\fP) "in" \fIB\fP 
            ["end" "cut"]

         |  ["total" | "partial" | "gate"] "prio"
            (["all" "but"] \fILL\fP (">" ["all" "but"] \fILL\fP)+)+
            "in" \fIB\fP
            ["end" "prio"]

         |  ["total" | "single" | "multiple" | "gate"] 
            "rename" (\fIRL\fP | "using" \fIF\fP) "in" \fIB\fP 
            ["end" "rename"]

         |  ["total" | "partial" | "gate"]  
            ["user"] "abstraction" \fIB\fP
            ["sync" ([\fILL\fP] | "using" \fIF\fP)] "of" \fIB\fP 

         |  "refined" ["user"] "abstraction" \fILL\fP
            ["using" \fIB\fP] "of" \fIB\fP

         | "chaos" ( "with" \fILL\fP 
                   | "with" \fIn\fP "labels" \fILP\fP 
                   | "using" \fIF\fP )

         | "bag" \fIm\fP ( "with" \fILL\fP
                   | "with" \fIn\fP "labels" \fILP\fP "," \fILP\fP
                   | "using" \fIF\fP )

         | "fifo" \fIm\fP ( "with" \fILL\fP
                    | "with" \fIn\fP "labels" \fILP\fP "," \fILP\fP
                    | "using" \fIF\fP )

         | ["label" | "gate"] "par" [("all" | \fILD\fP) "in"]
           [\fILD\fP "->"] \fIB\fP ("||" [\fILD\fP "->"] \fIB\fP)+
           "end par"

         |  \fIB\fP "||" \fIB\fP 

         |  \fIB\fP "|||" \fIB\fP 

         |  \fIB\fP "|[" [\fILL\fP] "]|" \fIB\fP

         |  \fIB\fP "-||"["?"] \fIB\fP

         |  \fIB\fP "-|||"["?"] \fIB\fP

         |  \fIB\fP "-|[" [\fILL\fP] "]|"["?"] \fIB\fP

         |  "(" \fIB\fP ")" 

    \fISPEC\fP ::= \fIF\fP 
          |  [\fIF\fP ":"] \fIL\fP ["[" \fIGPL\fP "]"] ["(" \fIAL\fP ")"]

    \fILL\fP ::= \fIL\fP [ "," \fILL\fP ]
        |  "{"\fIstring\fP"}"

    \fIGPL\fP ::= \fIL\fP [ "," \fIGPL\fP ]
        |  \fIL\fP "=>" \fIL\fP [ "," \fIGPL\fP ]
        |  "..."
        |  "{"\fIstring\fP"}"

    \fIAL\fP ::= \fIA\fP [ "," \fIAL\fP ]

    \fITL\fP ::= \fIL\fP [ ":" \fIC\fP ] [ "," \fITL\fP ]
        |  "{"\fIstring\fP"}"

    \fILD\fP ::= \fIL\fP [ "," \fILD\fP ]
        |  \fIL\fP "#" \fIn\fP [ "," \fILD\fP ]
        |  "{"\fIstring\fP"}"

    \fIRL\fP ::= \fIL\fP "->" \fIL\fP [ "," \fIRL\fP ]
        |  "{"\fIstring\fP"}"

    \fIL\fP ::= \fIG\fP | '"'\fIstring\fP'"'

    \fILP\fP ::= '"'\fIstring-with-%d\fP'"'

    \fIG\fP, \fIPID\fP, \fIC\fP ::= \fIlotos-identifier\fP
	| \fIlnt-identifier\fP

    \fIA\fP ::= \fIO\fP ["(" \fIAL\fP ")"]
        | \fIA\fP \fIO\fP \fIA\fP
        | \fIA\fP "of" \fIL\fP
        | ["+" | "-"] \fIn\fP
        | "'"\fIchar\fP"'"

    \fIO\fP ::= \fIlotos-identifier\fP
        | \fIlnt-identifier\fP
        | \fIspecial-identifier\fP
.cs I
.fi
.P
where \fIn\fP denotes a natural number greater or equal to 2.

.ne 4v
.P
A \fIlotos-identifier\fP or an \fIlnt-identifier\fP is a word that starts with a letter and contains letters, digits, and underscores, and is not a keyword. Underscore can not be the last character of a \fIlotos-identifier\fP or of an \fIlnt-identifier\fP.
.P
A \fIspecial-identifier\fP is a word consisting of the characters '#', '&', '*', '+', '-', '.', '/', '>', '=', '<', '@', '\\', '^', '~', '{', and '}', that is not a key symbol of SVL. Note that if the sequence starts with character '{', then it must finish with character '}'.

.SH PRECEDENCE AND ASSOCIATIVITY OF OPERATORS
.IP -
Parallel composition operators ("||", "|||", and "|[" \fILL\fP "]|") associate to the right. For instance,  
.nf
\fB"a.bcg" ||| "b.aut" |[A]| "c.fc2" |[B]| "d.seq"\fP
.fi
reads
.nf
\fB"a.bcg" ||| ("b.aut" |[A]| ("c.fc2" |[B]| "d.seq"))\fP
.fi
.IP -
On the opposite, infix abstraction operators associate to the left. For instance,
.nf
\fB"a.bcg" -||| "b.aut" -|[A]| "c.fc2" -|[B]| "d.seq"\fP
.fi
reads
.nf
\fB(("a.bcg" -||| "b.aut") -|[A]| "c.fc2") -|[B]| "d.seq"\fP
.fi
.IP -
Infix abstraction has a higher priority than parallel composition. For instance,
.nf
\fB"a.bcg" -|| "i.bcg" ||| "c.bcg" -|| "i.bcg"\fP
.fi
reads
.nf
\fB("a.bcg" -|| "i.bcg") ||| ("c.bcg" -|| "i.bcg")\fP
.fi
.IP -
The lexical scope of "hide", "cut", "prio", "rename", "generation", "reduction", and "abstraction" (prefix operators) extends as far as possible to the right of the expression. For instance,
.nf
\fBhide A in "a.bcg" || "b.bcg"\fP
.fi
is the same as 
.nf
\fBhide A in ("a.bcg" || "b.bcg")\fP
.fi
.P
\fBExamples\fP:

.nf
\fB"a.bcg" || "b.bcg" -|| hide G in "c.bcg" ||| "d.bcg"\fP
.fi
reads
.nf
\fB"a.bcg" || ("b.bcg" -|| hide G in ("c.bcg" ||| "d.bcg"))\fP
.fi

.nf
\fBpar A#2 in "a.bcg" || reduction of "b.bcg" || "c.bcg" end par\fP
.fi
reads
.nf
\fBpar A#2 in "a.bcg" || reduction of ("b.bcg" || "c.bcg") end par\fP
.fi

.ne 9v
.SH SEMANTICS OF BEHAVIOUR EXPRESSIONS

The semantics of behaviours is defined as follows:

.SS BEHAVIOUR SYSTEMS

\fISPEC\fP may be the name of a file containing a Labelled Transition System (LTS) in one of the AUT (extension \fB.aut\fP), BCG (extension \fB.bcg\fP), FC2 (extension \fB.fc2\fP), or SEQ (extension \fB.seq\fP) file formats.
BCG files may define stochastic or probabilistic LTSs as explained in the
.BR bcg_min (LOCAL)
manual page.
.P
\fISPEC\fP may also be the name of a file containing a network of LTSs in the EXP file format (extension \fB.exp\fP). See a description of the .exp format in the 
.BR aldebaran (LOCAL)
manual page
.P
At last, \fISPEC\fP may also be the name of an LNT, LOTOS, or FSP file, or an instanciation of a process in an LNT, LOTOS, or FSP file.
In the latter case, the syntax is as follows:
.nf
.cs I 23
[\fIF\fP ":"] \fIL\fP ["[" \fIGPL\fP "]"] ["(" \fIAL\fP ")"]
.cs I
.fi
where \fIF\fP is the name of the LNT (extension \fB.lnt\fP), LOTOS (extension \fB.lotos\fP or \fB.lot\fP), or FSP (extension \fB.lts\fP) file, \fIL\fP is a label denoting the name of the invoked process, \fIGPL\fP is an optional list of gate parameters of the process, and \fIAL\fP is an optional list of arguments representing the data parameters of the process.
For an FSP process instanciation, \fIGPL\fP and \fIAL\fP must remain empty.
For a LOTOS process instanciation, \fIGPL\fP must contain a list of gates.
For an LNT process instanciation, \fIGPL\fP may use the dot notation "..." and the named notation \fBG1 => G2\fP, where \fBG1\fP is a formal gate parameter of the process, and \fIG2\fP is the corresponding actual parameter. See the LNT user manual for details.
Note that \fIL\fP, \fIGPL\fP, and \fIAL\fP may contain Bourne Shell variables (see Section USING SHELL VARIABLES IN EXPRESSIONS for details).
Those Bourne Shell variables can only occur inside double quotes.
As a consequence, the double quotes in \fIAL\fP must not be interpreted as the delimiter of a LOTOS or LNT character string.
For arguments of type string, the double quotes must be escaped, as in the following example:
.br
\fBP [A, B] ("$X" of Nat, "\\"this is a string\\"")\fP
.P
The filename \fIF\fP is optional. If it is not mentioned, the process will be searched in the default LNT, LOTOS, or FSP file assigned to the shell variable \fBDEFAULT_PROCESS_FILE\fP on a shell line preceding the expression (see Section SHELL LINES).
.P
Note that SVL relies uniquely on extensions to recognize file formats. All files describing the behaviour of a system must therefore have a valid extension.

.SS STOP

"stop" represents a Labelled Transition System which contains a single state and no transitions.

.ne 9v
.SS HIDING
.nf
.cs I 23
["total" | "partial" | "gate"] "hide" ["all" "but"] [\fITL\fP] "in"
   \fIB\fP
["end" "hide"]
.cs I
.fi
and
.nf
.cs I 23
["total" | "partial" | "gate"] "hide" "using" \fIF\fP "in"
   \fIB\fP
["end" "hide"]
.cs I
.fi
will hide the labels found in \fIB\fP using the given hiding rules. These rules can be specified either as a list \fITL\fP of (possibly typed) labels (first form), or using an external file \fIF\fP (second form).
.P
In the first case, the types (usually channel names defined in an LNT program) are purely ignored. SVL builds a temporary file with extension \fB.hid\fP, filled with the given labels. In the second case, the hide file must be provided by the user, with extension \fB.hide\fP or \fB.hid\fP.
.P
A label can be a gate (possibly followed by experiment offers) or a regular expression denoting a gate (possibly followed by experiment offers). For instance, "G", "G.*", "G !1", "G. !.*" are labels. Among them, only "G" is a gate.
A channel name can be any LNT identifier (see <lnt-identifier> in Section BEHAVIOUR EXPRESSIONS above), or any string between double quotes.
.P
Double quotes around a label can be omitted if and only if the label is a gate (therefore, the syntax of the LOTOS hiding operator is accepted as a particular case of the more general SVL hiding operator). However, for compatibility with LOTOS syntax, gates that are not enclosed between quotes are systematically turned to uppercase, unless the \fB-case\fP option of
.BR svl (LOCAL)
is used. Note that double quotes are mandatory to avoid syntactic ambiguities when a gate has the same name as a reserved SVL keyword (e.g. "reduction", "all", etc.).
They are also mandatory to enable the use of shell variables denoting gates or labels as described in Section USING SHELL VARIABLES IN EXPRESSIONS.
.P
The "all but" keywords modify the semantics of the hiding rules: all the labels, except the labels specified in list \fITL\fP, are hidden in the given behaviour.
.P
The keywords "total", "partial", and "gate" modify the matching mode, that is the way the hiding rules are interpreted, see the
.BR caesar_hide_1 (LOCAL)
manual page. If no matching mode is specified, then the default is "gate", which implements the LOTOS hiding operator (possibly extended by the use of regular expressions on gate names).
.P
For every hiding with "gate" matching, SVL checks whether the gates to be hidden have an appropriate syntax and emit a warning if they appear to contain experiment offers (which is a common mistake for novice users). For instance, 
.nf
        hide "G !1" 
.fi
will trigger a warning message because of the occurence of "!1".
.P
\fBExamples\fP:
.br
.nf
        \fBtotal hide "G"\fP
.fi
hides every label equal to "G",
.br
.nf
        \fBgate hide "G"\fP
.fi
hides every label whose gate is G, e.g., "G !1", "G !2",
.br
.nf
        \fBgate hide ".*G.*"\fP
.fi
hides every label whose gate contains the character G and
.br
.nf
        \fBpartial hide "G"\fP
.fi
hides every label whose gate or offers contain the character G.
.P
See the 
.BR bcg_labels (LOCAL)
and 
.BR caesar_hide_1 (LOCAL)
man pages for more information on the hide file format, and on the semantics of the different matching modes. See the 
.BR regexp (LOCAL)
man page for information about the syntax of regular expression.

.ne 9v
.SS CUTTING
.nf
.cs I 23
["total" | "partial" | "gate"] "cut" ["all" "but"] [\fITL\fP] "in"
   \fIB\fP
["end" "cut"]
.cs I
.fi
and
.nf
.cs I 23
["total" | "partial" | "gate"] "cut" "using" \fIF\fP "in"
   \fIB\fP
["end" "cut"]
.cs I
.fi
will cut the labels found in \fIB\fP using the given cutting rules. These rules can be specified either as a list of (possibly typed) labels (first form), or using an external file \fIF\fP (second form).
.P
In the first case, the types (usually channel names defined in an LNT program) are purely ignored. SVL builds a temporary file with extension \fB.cut\fP, filled with the given labels.  In the second case, the cut file must be provided by the user, with extension \fB.cut\fP.
.P
A label can be a gate (possibly followed by experiment offers) or a regular expression denoting a gate (possibly followed by experiment offers). For instance, "G", "G.*", "G !1", "G. !.*" are labels. Among them, only "G" is a gate.
A channel name can be any LNT identifier (see <lnt-identifier> in Section BEHAVIOUR EXPRESSIONS above), or any string between double quotes.
.P
Double quotes around a label can be omitted if and only if the label is a gate. However, for compatibility with LOTOS syntax, gates that are not enclosed between quotes are systematically turned to uppercase, unless the \fB-case\fP option of
.BR svl (LOCAL)
is used. Note that double quotes are mandatory to avoid syntactic ambiguities when a gate has the same name as a reserved SVL keyword (e.g. "reduction", "all", etc.).
They are also mandatory to enable the use of shell variables denoting gates or labels as described in Section USING SHELL VARIABLES IN EXPRESSIONS.
.P
The "all but" keywords modify the semantics of the cutting rules: all the labels, except the labels specified in list \fITL\fP, are cut in the given behaviour.
.P
The keywords "total", "partial", and "gate" modify the matching mode, that is the way the cutting rules are interpreted, see the
.BR exp.open (LOCAL)
manual page. If no matching mode is specified, then the default is "gate".
.P
For every cutting with "gate" matching, SVL checks whether the gates to be cut have an appropriate syntax and emit a warning if they appear to contain experiment offers (which is a common mistake for novice users). For instance, 
.nf
        \fBcut "G !1"\fP
.fi
will trigger a warning message because of the occurence of "!1".
.P
\fBExamples\fP:
.P
.nf
        \fBtotal cut "G"\fP
.fi
cuts every label equal to "G",
.br
.nf
        \fBgate cut "G"\fP
.fi
cuts every label whose gate is G, e.g., "G !1", "G !2",
.br
.nf
        \fBgate cut ".*G.*"\fP
.fi
cuts every label whose gate contains the character G and
.br
.nf
        \fBpartial cut "G"\fP
.fi
cuts every label whose gate or offers contain the character G.
.P
See the 
.BR exp.open (LOCAL)
man page for more information on the cut file format, and on the semantics of the different matching modes. See the 
.BR regexp (LOCAL)
man page for information about the syntax of regular expression.
.P

.ne 9v
.SS PRIORITY
.nf
.cs I 23
["total" | "partial" | "gate"] "prio"
   (["all" "but"] [\fILL\fP] (">" ["all" "but"] [\fILL\fP])+)+ "in" \fIB\fP
["end" "prio"]
.cs I
.fi
sets priorities between the transitions of \fIB\fP.
In each state of \fIB\fP, a transition may be executed only if all transitions of higher priority are not ready for execution.
.P
Priorities between transitions (or equivalently, between labels) are defined by a set of priority rules of the form \fIX1\fP > ... > \fIXn\fP, where each \fIXi\fP (for \fIi\fP ranging in 1..n) has the form [all but] \fILLi\fP and \fILLi\fP is a list of regular expressions denoting gates or labels.
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
If ">>" is not a strict partial order, then the \fBexp.open\fP tool will issue an error message and then exit.
.P
Beware that the rules \fIX\fP > \fIX'\fP and \fIX'\fP > \fIX''\fP (which are equivalent to \fIX\fP > \fIX'\fP > \fIX''\fP) imply \fIX\fP > \fIX''\fP only if some label of \fIB\fP matches \fIX'\fP.
Therefore, to avoid tricky errors, \fBexp.open\fP checks that every individual regular expression \fIL\fP in \fILL1\fP, ..., \fILLn\fP matches some label of \fIB\fP.
If not, then \fBexp.open\fP will issue a warning.
.P
The optional "gate", "total", and "partial" keywords define the matching mode, in the same way as for the "hide" and "cut" operators.
The matching mode by default is "gate".
.P
See the 
.BR exp.open (LOCAL)
manual page for details.
.P
\fBExamples\fP:
.nf
        \fBgate prio
            "A.*" > B > all but "A.*", B
        in
            "f.bcg"
        end prio\fP
.fi
defines an LTS in which every transition whose gate starts with the letter "A" has priority over every transition whose gate is "B", which themselves have priority over all other transitions.
.nf
        \fBpartial prio
            "A" > all but "A"
        in
            "f.bcg"
        end prio\fP
.fi
defines an LTS in which every transition whose label contains the letter "A" has priority over every transition whose label does not contain the letter "A" (including hidden transitions).
.nf
        \fBtotal prio
            "A" > "B" > "C"
            "D" > "E" > "F"
            "A" > "D"
            "B" > "E"
            "C" > "F"
        in
            "f.bcg"
        end prio\fP
.fi
defines an LTS in which:
.IP -
A has priority over B, C, D, E, and F,
.IP -
B has priority over C, E, and F,
.IP -
C has priority over F,
.IP -
D has priority over E and F, and
.IP -
E has priority over F.
.P
Note: Strong bisimulation is a congruence for all \fBsvl\fP hiding, cutting, renaming, priority, and parallel composition operators operators.
However, branching, divbranching, observational, and safety equivalences are congruences for all \fBsvl\fP hiding, cutting, renaming, and parallel composition operators, but not for priority.
It should also be noted that tau*.a equivalence is not a congruence for parallel composition.

.ne 8v
.SS RENAMING
.nf
.cs I 23
["total" | "single" | "multiple" | "gate"] "rename" \fIRL\fP "in"
   \fIB\fP
["end" "rename"]
.cs I
.fi
and
.nf
.cs I 23
["total" | "single" | "multiple" | "gate"] "rename"
   "using" \fIF\fP "in" \fIB\fP
["end" "rename"]
.cs I
.fi
will rename the labels of \fIB\fP using the given renaming rules. These rules can be specified either as a list of rules of the form \fIL1\fP "->" \fIL2\fP, where \fIL1, L2\fP denote any labels (first form), or using an external file \fIF\fP (second form). 
.P
In the first case SVL builds a temporary file with extension \fB.ren\fP, filled with the given substitution rules. In the second case SVL uses the given renaming file, whose extension must be \fB.ren\fP or \fB.rename\fP.
.P
A label can be a gate (possibly followed by experiment offers) or a regular expression denoting a gate (possibly followed by experiment offers). For instance, "G", "G.*", "G !1", "G. !.*" are labels. Among them, only "G" is a gate.
.P
Double quotes around a label can be omitted if and only if the label is a standard LOTOS gate. However, for compatibility with LOTOS syntax, gates which are not enclosed between quotes are systematically turned to uppercase, unless the \fB-case\fP option of 
.BR svl (local)
is used. Note that double quotes are mandatory to avoid syntactic ambiguities when a gate has the same name as a reserved SVL keyword (e.g. "reduction", "all", etc.) and that they enable the use of shell variables denoting gates or labels as described in Section USING SHELL VARIABLES IN EXPRESSIONS.
.P
The keywords "total", "single", "multiple", and "gate" modify the way the left hand sides of the renaming rules are interpreted, see the
.BR caesar_rename_1 (LOCAL)
manual page. If no matching mode is specified, then the default is "gate".
.P
For every renaming with "gate" matching, SVL checks whether the gates to be renamed have an appropriate syntax and emit a warning if they appear to contain experiment offers (which is a common mistake for novice users). For instance, 
.nf
        \fBrename "G !1" -> "G !2"\fP
.fi
will trigger a warning message because of the occurence of "!1". Note however that 
.nf
        \fBrename "G" -> "G !1"\fP
.fi
is correct.
.P
\fBExamples\fP:
.P
.nf
        \fBtotal rename "G" -> "H"\fP
.fi
renames to "H" every label equal to "G",
.br
.nf
        \fBgate rename "G" -> "H"\fP
.fi
renames to "H" the gate of every label whose gate is G, e.g., "G !1", "G !2",
.br
.nf
        \fBgate rename ".*G.*" -> "H"\fP
.fi
renames to "H" the gate of every label whose gate contains a G,
.br
.nf
        \fBsingle rename "G" -> "H"\fP
.fi
replaces the first occurrence of "G" by "H" in every label whose gate or offers contain a G,
.br
.nf
        \fBmultiple rename "G" -> "H"\fP
.fi
replaces every occurrence of "G" by "H" in every label whose gate or offers contain a G, and
.br
.nf
        \fBtotal rename "\\([A-Z0-9]*\\) \\(!.*\\)" -> "\\1 !1 \\2"\fP
.fi
inserts "!1" between every gate and its first offer.
.P
See the 
.BR bcg_labels (LOCAL)
and
.BR caesar_rename_1 (LOCAL)
manual pages for more information on these options and on the format of renaming rules.
See also the 
.BR regexp (LOCAL)
manual page for more information on regular expressions.

.SS ROOT REDUCTION
.nf
.cs I 23
"root" ["total" | "partial"]
   [\fIE\fP] ["probabilistic" | "stochastic"] "reduction"
   ["using" \fIM\fP] ["with" \fIT\fP] "of" \fIB\fP
.cs I
.fi
or more simply
.nf
.cs I 23
["total" | "partial"]
   [\fIE\fP] ["probabilistic" | "stochastic"] "reduction"
   ["using" \fIM\fP] ["with" \fIT\fP] "of" \fIB\fP
.cs I
.fi
will generate the behaviour \fIB\fP (totally or partially) reduced modulo the reduction relation \fIE\fP, and possibly taking into account the probabilistic or stochastic information present in \fIB\fP. The reduction is done with the tool \fIT\fP and using the method \fIM\fP.
.P
\fIT\fP, \fIM\fP, \fIE\fP, "total", "partial", "probabilistic", and "stochastic" are optional:
.IP -
Partial reduction is an incomplete form of reduction.
Compared to total reduction, it generally generates a larger LTS but in a shorter time.
If the "total" or "partial" keyword is not specified, then the reduction will be total.
.IP -
The "probabilistic" and "stochastic" reductions are only available for strong, branching, and divbranching bisimulations with bcg_min and using the std method. In this case, the behaviour \fIB\fP must denote an explicit LTS containing probabilistic or stochastic information. See the 
.BR bcg_min (LOCAL)
manual page for more information.
.IP -
The default value for \fIE\fP is "strong" and can be changed via the shell variable \fBDEFAULT_REDUCTION_RELATION\fP. 
.IP -
The default value for \fIM\fP depends on the equivalence relation considered.
The shell variable \fBDEFAULT_REDUCTION_METHOD\fP can be set in the SVL file to enforce a particular default value.
.IP -
The default value for \fIT\fP depends on the relation \fIE\fP and whether the reduction is partial or total, as summarized in the following table:
.sp
.nf
.cs R 23
.cs B 23
+------------------+------------------+---------------+
| relation         |      total       |    partial    |
+------------------+------------------+---------------+
| strong           |     \fBbcg_min\fP      |   \fBreductor\fP    |
| strong stoch.    |     \fBbcg_min\fP      | not available |
| strong prob.     |     \fBbcg_min\fP      | not available |
| tau-divergence   | \fBreductor\fP+\fBbcg_min\fP |   \fBreductor\fP    |
| tau-compression  | \fBreductor\fP+\fBbcg_min\fP |   \fBreductor\fP    |
| tau-confluence   | \fBreductor\fP+\fBbcg_min\fP |   \fBreductor\fP    |
| branching        |     \fBbcg_min\fP      | not available |
| branching stoch. |     \fBbcg_min\fP      | not available |
| branching prob.  |     \fBbcg_min\fP      | not available |
| divbranching     |     \fBbcg_min\fP      | not available |
| divbr. stoch.    |     \fBbcg_min\fP      | not available |
| divbr. prob.     |     \fBbcg_min\fP      | not available |
| observational    |   \fBaldebaran\fP      | not available |
| tau*.a           | \fBreductor\fP+\fBbcg_min\fP |   \fBreductor\fP    |
| safety           | \fBreductor\fP+\fBbcg_min\fP |   \fBreductor\fP    |
| trace            | \fBreductor\fP+\fBbcg_min\fP |   \fBreductor\fP    |
| weak trace       | \fBreductor\fP+\fBbcg_min\fP |   \fBreductor\fP    |
+------------------+------------------+---------------+
.cs R
.cs B
.fi
where "\fBreductor\fP+\fBbcg_min\fP" means that the total \fIE\fP reduction is done by first applying partial \fIE\fP reduction with \fBreductor\fP, followed by total strong reduction with \fBbcg_min\fP.
.sp
The shell variable \fBDEFAULT_REDUCTION_TOOL\fP can be set in the SVL file to enforce a particular default value for \fIT\fP.
.P
.ne 10v
.B Example:

.nf
\fB% DEFAULT_REDUCTION_TOOL="reductor"
% DEFAULT_REDUCTION_RELATION="tau*.a"
"a_red.aut" = total reduction of "a.aut"\fP
.fi
.P
will induce the total reduction modulo tau*.a of a.aut with \fBreductor\fP, and store the result in file a_red.aut.
.P
When a combination of total/partial reduction, tool, method, and relation is not available, SVL tries to change (at run-time) some parameters to perform a (total or partial) reduction as close as possible to what appears to be expected, trying to preserve the parameters in the following priority order: stochastic or probabilistic reduction, reduction relation, reduction tool, reduction method, and then total or partial reduction.
.P
Moreover, if the reduction fails (for instance because of memory exhaustion) then SVL tries to achieve it another way. For instance, using another tool, or performing a reduction modulo a stronger equivalence relation to reduce the size of the LTS to reducee before re-attempting the weaker reduction. When all attempts fail, then the verification proceeds with the non reduced behaviour.
.P
Note: In some versions of CADP, the \fBaldebaran.old\fP tool, which performs "observational reduction", may be not available.
If this is the case, then SVL replaces "observational reduction" by "branching reduction" (performed by the \fBbcg_min\fP tool) and issues a warning message.

.SS LEAF REDUCTION
.nf
.cs I 23
"leaf" ["total" | "partial"]
   [\fIE\fP] ["probabilistic" | "stochastic"] "reduction"
   ["using" \fIM\fP] ["with" \fIT\fP] "of" \fIB\fP
.cs I
.fi
is a meta-operator that will (totally or partially) reduce the LTSs generated as components of \fIB\fP. As above, \fIT\fP, \fIM\fP, \fIE\fP, the "total" and "partial" keywords and the "probabilistic" and "stochastic" keywords are optional parameters (see \fBROOT REDUCTION\fP). The final result of a "leaf reduction" is not necessarily as small as that obtained with "root", "root leaf", and "node reduction" since only components of \fIB\fP are reduced.
.P
The expansion rules of "leaf reduction" are the following:
.ne 10v
.nf
leaf reduction of \fIB\fP = lRed (\fIB\fP)

lRed (\fIB1\fP |\fIop\fP| \fIB2\fP) = lRed (\fIB1\fP) |\fIop\fP| lRed (\fIB2\fP)
lRed (Hide (\fIX\fP, \fIB1\fP |\fIop\fP| \fIB2\fP)) = Hide (\fIX\fP, lRed (\fIB1\fP |\fIop\fP| \fIB2\fP)) 
lRed (Hide (\fIX\fP, \fIB\fP)) = Red (Hide (\fIX\fP, lRed (\fIB\fP))) 
                     (other cases)
lRed (Cut (\fIX\fP, \fIB1\fP |\fIop\fP| \fIB2\fP)) = Cut (\fIX\fP, lRed (\fIB1\fP |\fIop\fP| \fIB2\fP)) 
lRed (Cut (\fIX\fP, \fIB\fP)) = Red (Cut (\fIX\fP, lRed (\fIB\fP))) 
                     (other cases)
lRed (Prio (\fIX\fP, \fIB1\fP |\fIop\fP| \fIB2\fP)) = Prio (\fIX\fP, lRed (\fIB1\fP |\fIop\fP| \fIB2\fP))
lRed (Prio (\fIX\fP, \fIB\fP)) = Red (Prio (\fIX\fP, lRed (\fIB\fP))) 
                     (other cases)
lRed (Ren (\fIX\fP, \fIB1\fP |\fIop\fP| \fIB2\fP)) = Ren (\fIX\fP, lRed (\fIB1\fP) |\fIop\fP| lRed (\fIB2\fP))
lRed (Ren (\fIX\fP, \fIB\fP)) = Red (Ren (\fIX\fP, lRed (\fIB\fP)))
                     (other cases)
lRed (Abs (\fIB1\fP, \fIX\fP, \fIB2\fP)) = Red (Abs (\fIB1\fP, \fIX\fP, lRed(\fIB2\fP)))
lRed (Gen (\fIB\fP)) = Red (Gen (lRed (B)))
lRed (\fIB\fP) = Red (\fIB\fP) otherwise
.fi
where Red means reduction, Ren means rename, Abs means abstraction or refined abstraction (its first operand is the interface, and its third operand is the body), Gen means generation, \fIB\fP, \fIB1\fP, \fIB2\fP denote any behaviour, \fIX\fP denotes either a file or a list of items (labels or renaming rules), and |\fIop\fP| denotes any parallel composition operator.
.P
Note that expansion does not propagate meta-operations across "reduction" operations, nor inside the interface part of the "abstraction" operation.
.P
Note also that, at the end of the expansion phase, the obtained abstract tree is cleaned to optimize execution. Therefore some "reduction" operators inserted by the lRed function are then removed by the cleaning function. For instance, any "reduction" operation inserted at the root of the body of an "abstraction" operation will be systematically deleted to avoid the (useless and expensive) generation of the behaviour to be abstracted. See Section CLEANING below.

.SS ROOT LEAF REDUCTION
.nf
.cs I 23
"root leaf" ["total" | "partial"]
   [\fIE\fP] ["probabilistic" | "stochastic"] "reduction"
   ["using" \fIM\fP] ["with" \fIT\fP] "of" \fIB\fP
.cs I
.fi
is a meta-operator, which has the same meaning as "root reduction of leaf reduction of \fIB\fP".

.SS NODE REDUCTION
.nf
.cs I 23
"node" ["total" | "partial"]
   [\fIE\fP] ["probabilistic" | "stochastic"] "reduction"
   ["using" \fIM\fP] ["with" \fIT\fP] "of" \fIB\fP
.cs I
.fi
is a meta-operator that will generate \fIB\fP in a compositional way. The only difference between "root leaf" and "node reduction" is that "node reduction" performs also reduction at each parallel composition node, and that hide and cut operators are propagated as far as possible inside the behaviour expression. As above, \fIT\fP, \fIM\fP, \fIE\fP, the "total" and "partial" keywords and the "probabilistic" and "stochastic" keywords are optional parameters (see \fBROOT REDUCTION\fP).
.P
The expansion rules of "node reduction" are the following:
.ne 7v
.nf
node reduction of B = Red (nRed (B))

nRed (\fIB1\fP |\fIop\fP| \fIB2\fP) = Red (nRed (\fIB1\fP) |\fIop\fP| nRed (\fIB2\fP))
nRed (Hide (\fIX\fP, \fIB\fP)) = Red (Hide (\fIX\fP, nRed (\fIB\fP)))
nRed (Cut (\fIX\fP, \fIB\fP)) = Red (Cut (\fIX\fP, nRed (\fIB\fP)))
nRed (Prio (\fIX\fP, \fIB\fP)) = Red (Prio (\fIX\fP, nRed (\fIB\fP)))
nRed (Ren (\fIX\fP, \fIB\fP)) = Red (Ren (\fIX\fP, nRed (\fIB\fP)))
nRed (Abs (\fIB1\fP, \fIX\fP, \fIB2\fP)) = Red (Abs (\fIB1\fP, \fIX\fP, lRed (\fIB2\fP)))
nRed (Gen (\fIB\fP)) = Red (Gen (lRed (\fIB\fP)))
nRed (\fIB\fP) = Red (\fIB\fP) otherwise
.fi
where Red means reduction, Ren means rename, Abs means abstraction or refined abstraction (its first operand is the interface, and its third operand is the body), Gen means generation, \fIB\fP, \fIB1\fP, \fIB2\fP denote any behaviour, \fIX\fP denotes either a file or a list of items (labels or renaming rules), and |\fIop\fP| denotes any parallel composition operator.
.P
Note that expansion does not propagate meta-operations across "reduction" operations, nor inside the interface part of the "abstraction" operation.
The "node reduction" becomes a "leaf reduction" (lRed) once it has passed through an "abstraction", "refined abstraction", or "generation" operator.
.P
Note also that, at the end of the expansion phase, the obtained abstract tree is cleaned to optimize execution. Therefore some "reduction" operators inserted by the nRed function are then removed by the cleaning function. For instance, any "reduction" operation inserted at the root of the body of an "abstraction" operation will be systematically deleted to avoid the (useless and expensive) generation of the behaviour to be abstracted. See Section CLEANING below.

.SS SMART REDUCTION
.nf
.cs I 23
"smart" ["total" | "partial"]
   [\fIE\fP] ["probabilistic" | "stochastic"] "reduction"
   ["using" \fIM\fP] ["with" \fIT\fP] "of" \fIB\fP
.cs I
.fi
is an operator that will generate \fIB\fP in a compositional way using a smart heuristic, the aim being to try to avoid generating too large intermediate LTSs.
.P
To do so, \fIB\fP is first turned into a network whose LTSs are minimized.
Then, SVL executes the following loop until this network contains only a single LTS:
.IP 1
Automatically select several LTSs in the network; this step relies on a heuristic metric (computed by exp2c) that depends on an estimate rate of hidden transitions and an estimate rate of interleaved transitions belonging to the product of selected LTSs.
.IP 2
Compose the selected LTSs in parallel.
.IP 3
Generate the LTS corresponding to the composition obtained in step 2 and minimize it.
.IP 4
Replace in the network the LTSs selected in step 1 by the LTS resulting from step 3; continue in step 1.
.P
The LTS corresponding to the obtained network is finally generated, minimized, and returned as the LTS corresponding to \fIB\fP.
.P
The maximal number of LTSs that can be selected in step 1 is bounded.
By default, the limit is set to 4.
This limit can be changed by assigning a different value to the variable \fIDEFAULT_SMART_LIMIT\fP.
.P
Note: Unlike other meta-operations, "smart reduction" is not expanded.
Indeed, the expansion phase is static, whereas the order in which the LTSs in \fIB\fP are composed by "smart reduction" is determined at run time.

.SS GENERATION
.nf
.cs I 23
"generation" "of" \fIB\fP
.cs I
.fi
will force the generation of an explicit LTS representation of \fIB\fP. More precisely, if \fIB\fP is an LNT, LOTOS, or FSP program, this program will be compiled, and if \fIB\fP has an implicit representation as a network of communicating automata in the EXP format, then an explicit representation of \fIB\fP will be generated.
.P
There are some cases where the "generation" operation is implicit:
.IP -
generation of the body of a "hide", "cut", or "rename" operation when it is a LNT, LOTOS, or FSP file;
.IP -
generation of the interface of an "abstraction" operation;
.IP -
generation of the body of a "reduction" operation;
.P
Note that, during the expansion phase, meta-operators do not propagate across "generation" operations in the abstract syntax tree.

.SS PARALLEL COMPOSITION
.nf
.cs I 23
\fIB\fP "||" \fIB\fP
.cs I
.fi
and
.nf
.cs I 23
\fIB\fP "|||" \fIB\fP
.cs I
.fi
and
.nf
.cs I 23
\fIB\fP "|[" [\fILL\fP] "]|" \fIB\fP
.cs I
.fi
have the LOTOS semantics of parallel composition: "|||" denotes parallel composition with synchronization on termination only, "||" denotes parallel composition with synchronization on all gates, and at last "|[" [\fILL\fP] "]|" denotes parallel composition with synchronization on termination and on gates specified in the optional list of labels \fILL\fP.

.SS GENERALIZED PARALLEL
.nf
.cs I 23
["label" | "gate"] "par" [("all" | \fILD\fP) "in"]
   [\fILD\fP "->"] \fIB\fP ("||" [\fILD\fP "->"] \fIB\fP)+
"end par"
.cs I
.fi
is an extension of the E-LOTOS/LNT generalized parallel composition operator.
It denotes the concurrent execution of parallel behaviours following synchronisation rules expressed using:
.IP -
the keyword "all" or the list "\fILD\fP" that follows the keyword "par", called \fIglobal synchronisation interface\fP, and
.IP -
the lists \fILD\fP that precede the symbols "->", called \fIlocal synchronisation interfaces\fP.
.P
Synchronisation interfaces \fILD\fP are lists of synchronisation elements of the
form \fIL\fP or \fIL#N\fP, where \fIL\fP is a gate or a label and \fIN\fP is a natural number called \fIsynchronisation degree\fP.
.P
The semantics of synchronisation rules are defined in the following paragraphs.
.IP -
The "gate" or "label" keywords indicate the \fIsynchronisation mode\fP, which influences the way synchronisation rules apply to transition labels.
We say that a transition matches a synchronisation element of the form \fIL\fP or \fIL#N\fP in the following cases:
.br
In "gate" synchronisation mode, a transition matches \fIL\fP or \fIL#N\fP if the gate of the transition label is \fIL\fP.
Therefore, for every synchronisation element of the form \fIL\fP or \fIL#N\fP occurring in a synchronisation interface, \fIL\fP must be a gate without offers.
.br
In "label" synchronisation mode, a transition matches \fIL\fP or \fIL#N\fP if the transition label is \fIL\fP.
Therefore, for every synchronisation element of the form \fIL\fP or \fIL#N\fP occurring in a synchronisation interface, \fIL\fP must be a full label (i.e., a gate possibly followed by offers).
.br
Unlike "hide", "cut", and "rename", regular expressions are not allowed in synchronisation elements.
If not specified, the synchronisation mode by default is "gate".
.IP -
The keyword "all" is a shorthand notation for the global synchronisation set consisting of all synchronisation elements \fIL\fP (without degree) such that \fIL\fP is the gate (in "gate" synchronisation mode) or the label (in "label" synchronisation mode) of a transition in at least one of the parallel behaviours, except transitions carrying hidden events.
.P
Synchronisation elements have the following meaning:
.IP -
A synchronisation element of the form \fIL\fP (without degree) occurring in the
global synchronisation interface indicates that all parallel behaviours may synchronize all together on transitions that match \fIL\fP.
.IP -
A synchronisation element of the form \fIL\fP (without degree) occurring in a local synchronisation interface indicates that all parallel behaviours that contain \fIL\fP in their synchronisation interface may synchronize all together on transitions that match \fIL\fP.
.IP -
A synchronisation element of the form \fIL#N\fP occurring in the global synchronisation interface indicates that \fIN\fP behaviours among the parallel behaviours may synchronize together on transitions that match \fIL\fP.
.IP -
A synchronisation element of the form \fIL#N\fP occurring in a local synchronisation interface indicates that \fIN\fP behaviours among the parallel behaviours that contain \fIL#N\fP in their synchronisation interface may synchronize on transitions that match \fIL\fP.
.IP -
A transition in a parallel behaviour may execute asynchronously if both the global synchronization interface and the local synchronization interface of that behaviour do not contain any element of the form \fIL\fP or \fIL#N\fP such that the transition matches \fIL\fB.
.P
Note that both the global synchronisation interface and local synchronisation interfaces may contain several synchronisation elements with same label \fIL\fP but different synchronisation degrees.
In this case, the corresponding synchronisation rules apply nondeterministically.
.P
Following the above meaning of synchronisation elements, it is possible to prevent the execution of particular transitions matching \fIL\fP by using synchronisation elements of the form \fIL#0\fP, either in the global synchronisation interface (thus preventing execution of transitions matching \fIL\fP in all parallel behaviours) or in local synchronisation interfaces (thus preventing execution of transitions matching \fIL\fP in those behaviours containing \fIL#0\fP in their interface), provided the (global or local) interface does not contain another occurrence of \fIL\fP or \fIL#N\fP with \fIN\fP a strictly positive number.
.P
Transition synchronisation is a generalization of LOTOS rendezvous: synchronisation requires that all transitions have exactly the same label (i.e., gate and possible offers), which is also the label of the resulting transition.
.P
Note that synchronization interfaces can neither contain the hidden gate nor the termination gate.
Behaviours always synchronize on labels whose gate is the termination gate and never synchronize on hidden events.
.P
The following syntactic restrictions (checked by
.BR exp.open (LOCAL)) should hold:
.IP -
If the global synchronisation interface contains a synchronisation element of the form \fIL#N\fP with \fIN\fP > 0, then the parallel composition must contain at least \fIN\fP parallel behaviours.
.IP -
If the global synchronisation interface contains a synchronisation element of the form \fIL#0\fP, then no synchronisation element of the form \fIL\fP or \fIL#N\fP with same \fIL\fP and \fIN\fP > 0 should occur in the global synchronization
interface or in any local synchronization interface.
.IP -
If a local synchronisation interface contains a synchronisation element of the form \fIL\fP (without degree), then at least two local synchronisation interfaces (this one included) should contain the same synchronisation element.
.IP -
If a local synchronisation interface contains a synchronisation element of the form \fIL#N\fP with \fIN\fP > 0, then at least \fIN\fP local synchronisation interfaces (this one included) should contain the same synchronisation element.
.IP -
If a local synchronisation interface contains a synchronisation element of the form \fIL#0\fP, then no synchronisation element of the form \fIL\fP or \fIL#N\fP
with same \fIL\fP and \fIN\fP > 0 should occur in the global synchronization interface or in the same local synchronization interface.
.P
.ne 16v
.SS ABSTRACTION
.nf
.cs I 23
["total" | "partial" | "gate"] ["user"] "abstraction" \fIB\fP
   "sync" [\fILL\fP] "of" \fIB\fP
.cs I
.fi
and
.nf
.cs I 23
["total" | "partial" | "gate"] ["user"] "abstraction" \fIB\fP
   "sync" "using" \fIF\fP "of" \fIB\fP
.cs I
.fi
and
.nf
.cs I 23
["total" | "partial" | "gate"] ["user"] "abstraction" \fIB\fP
   "of" \fIB\fP
.cs I
.fi
denote abstraction using an interface, also called semi-composition. It allows to restrict the rightmost behaviour with respect to its environment i.e., an expression called the interface and a synchronization set.
.P
Interfaces can be either ``exact'' interfaces i.e., parts of the syntactic environment of the sub-expression to be restricted, or ``user-given'' interfaces i.e., expressions that are supposed to correctly approximate this environment. The second case must be expressed with the "user" keyword that involves the generation of some validation predicates in the produced LTS. These predicates are checked afterwards, when the components obtained by user abstractions are recomposed together. SVL issues a warning message if the check fails.
.P
Similarly to hide, cut, and rename operators, the synchronization set can be given explicitly as a list of labels in the abstraction expression, or in a \fB.sync\fP file. See the 
.BR projector (LOCAL)
manual page for more information on the sync file format.
.P
A label can be a gate (possibly followed by experiment offers) or a regular expression denoting a gate (possibly followed by experiment offers). For instance, "G", "G.*", "G !1", "G. !.*" are labels. Among them, only "G" is a gate.
.P
Double quotes around a label can be omitted if and only if the label is a gate . However, gates that are not enclosed between quotes are systematically turned to uppercase, unless the \fB-case\fP option of
.BR svl (LOCAL)
is used. Note that double quotes are mandatory to avoid syntactic ambiguities when a gate has the same name as a reserved SVL keyword (e.g. "reduction", "all", etc.).
They are also mandatory to enable the use of shell variables denoting gates or labels as described in Section USING SHELL VARIABLES IN EXPRESSIONS.
.P
The "all but" keywords modify the semantics of the synchronization rules: all the labels, except the labels specified in list \fILL\fP, must be used in the synchronization between the given behaviour and its interface.
.P
The keywords "total", "partial", and "gate" modify the matching mode, that is the way the synchronization rules are interpreted, see the
.BR projector (LOCAL)
manual page. If no matching mode is specified, then the default is "gate".
.P
If no synchronization set is given (no "sync" keyword), the synchronization is done as follows:
.IP -
In "gate" matching mode, synchronization is done on all gates visible in the interface.
.IP -
In "total" or "partial" matching mode, synchronization is done on all labels visible in the interface.
.P
For every abstraction with "gate" matching, SVL checks whether the gates to be synchronized have an appropriate syntax and emit a warning if they appear to contain experiment offers (which is a common mistake for novice users). For instance, 
.nf
        \fBabstraction ... sync "G !1"\fP
.fi
will trigger a warning message because of the occurence of "!1".
.P
\fBExamples\fP:
.P
.nf
        \fBtotal abstraction ... sync "G"\fP
.fi
synchronizes every label equal to "G",
.br
.nf
        \fBgate abstraction ... sync "G"\fP
.fi
synchronizes every label whose gate is G, e.g., "G !1", "G !2",
.br
.nf
        \fBgate abstraction ... sync ".*G.*"\fP
.fi
synchronizes every label whose gate contains the character G and
.br
.nf
        \fBpartial abstraction ... sync "G"\fP
.fi
synchronizes every label whose gate or offers contain the character G.
.P
See the 
.BR projector (LOCAL)
man page for more information on the sync file format, and on the semantics of the different matching modes. See the 
.BR regexp (LOCAL)
man page for information about the syntax of regular expression.
.P
Before doing the semi-composition, SVL does the following to optimize verification efficiency:
.IP - 
It hides in the interface all gates or labels (depending on the matching mode), except those which are in the synchronization list.
.IP - 
It reduces the interface modulo safety equivalence.

.ne 5v
.SS INFIX ABSTRACTION OPERATORS
.nf
.cs I 23
\fIB1\fP "-||" ["?"] \fIB2\fP
.cs I
.fi
and
.nf
.cs I 23
\fIB1\fP "-|||" ["?"] \fIB2\fP
.cs I
.fi
and
.nf
.cs I 23
\fIB1\fP "-|[" [\fILL\fP] "]|" ["?"] \fIB2\fP
.cs I
.fi
are shorthand notations for, respectively, 
.nf
.cs I 23
["user"] "abstraction" \fIB2\fP "of" \fIB1\fP
.cs I
.fi
and
.nf
.cs I 23
["user"] "abstraction" \fIB2\fP "sync" "of" \fIB1\fP
.cs I
.fi
and
.nf
.cs I 23
["user"] "abstraction" \fIB2\fP "sync" [\fILL\fP] "of" \fIB1\fP
.cs I
.fi
where the "?" symbol has the same meaning as the "user" keyword.

.SS REFINED ABSTRACTION
.nf
.cs I 23
"refined" ["user"] "abstraction" \fILL\fP ["using" \fIB\fP] "of" \fIB\fP
.cs I
.fi
allows to restrict the rightmost behaviour expression (the \fIbody\fP) with respect to some of its neighbours (specified in the list \fILL\fP).
.P
The neighbours are those behaviour systems (LTS files, files containing networks of LTSs, LNT, LOTOS, or FSP files, or processes in LNT, LOTOS, or FSP files) that are in the environment of (i.e., composed in parallel with) the body.
The identifier of a neighbour is either its process name (without offer parameters) in the case of a process, or its filename (with extension and between quotes) in all other cases.
Each label in \fILL\fP must be the identifier of exactly one neighbour (see examples below).
.P
The behaviour expression that follows the "using" keyword, if present, should provide a set of labels, which includes all labels that can be fired by the body.
Its states and transitions are simply ignored.
These labels allow to compute the possible synchronizations between the body and its environment, without having to generate the LTS corresponding to the body.
This expression is required if the body is an LNT, LOTOS, or FSP file or a process in an LNT, LOTOS, or FSP file and can be omitted otherwise.
If the body is a parallel composition expression (encoded in an EXP file) or an EXP file, this set is computed automatically using the
.BR exp.open (LOCAL)
tool.
If the body is neither an LNT, LOTOS, or FSP file, a process in an LNT, LOTOS, or FSP file, a parallel composition expression, nor an EXP file, then its LTS is generated and serves as label set.
.P
The "user" keyword should be used when the user cannot guarantee that the label set provided by this expression includes all labels that can be fired by the body.
In this case, validation predicates will be generated in the resulting LTS, and warning messages will be issued if the validation predicates are not satisfied.
.P
Refined abstraction executes in two steps:
in a first step, an interface and a synchronization set will be generated automatically from the behaviours of neighbours and the environment of the expression, using the
.BR exp.open (LOCAL)
tool;
during this step, the LTSs of neighbours in \fILL\fP are automatically minimized modulo safety equivalence, so as to generate as small an interface as possible; 
in a second step, the interface and synchronization set obtained during the first step are used to restrict the body, using the
.BR projector (LOCAL)
tool.
.P
.B Examples:
.P
The following expressions are examples of correct usage of the "refined abstraction" operator:
.ne 11v
.nf
\fB"a.bcg" = node strong reduction of
  (
    P
  ||
    (
      (refined abstraction P, "r.bcg" using "q.bcg" of Q)
    ||
      hide A in "r.bcg"
    )
  )\fP
.fi
.ne 13v
.nf
\fB"a.bcg" = generation of
  (
    P
  ||
    (
      refined abstraction P of
        (
          Q
        ||
          (refined abstraction P, Q using "r.bcg" of R)
        )
    )
  )\fP
.fi
.P
The following expression is an example of incorrect usage of the "refined abstraction" operator, where Q has two neighbours whose identifier is P, and no neighbour whose identifier is R:
.ne 11v
.nf
\fB"a.bcg" = generation of
  (
    P
  ||
    (
      (refined abstraction P, R using "q.bcg" of Q)
    ||
      hide A in P
    )
  )\fP
.fi

.SS CHAOS AUTOMATA
.nf
.cs I 23
"chaos" "using" \fIF\fP
.cs I
.fi
and
.nf
.cs I 23
"chaos" "with" \fILL\fP
.cs I
.fi
and
.nf
.cs I 23
"chaos" "with" \fIn\fP "labels" \fILP\fP
.cs I
.fi
generate an LTS with a single state and looping transitions, using the bcg_graph tool.
.P
There are several ways to define the transition labels:
.IP -
Using a file \fIF\fP (first form): \fIF\fP must be the full name of an existing file, no particular extension being required.
Each label in \fIF\fP must be written on a separate line, and may be enclosed in double quotes that are removed in the generated LTS.
.IP -
Using a label list \fILL\fP (second form):
\fILL\fP is a list of any length. In this case, SVL generates a temporary file used by bcg_graph.
.IP -
Using a label pattern \fILP\fP and a number \fIn\fP (third form): \fILP\fP must be enclosed between double quotes and contain exactly one occurrence of the substring "%d".
This pattern denotes exactly \fIn\fP different labels, obtained by replacing the occurrence of "%d" by numbers in the range 1..\fIn\fP.
\fIn\fP must be a natural number (sequence of digits), possibly enclosed between double quotes. It can also be defined using a shell variable (in which case double quotes are mandatory), such as e.g., "$N" and "${N}0".
.P
See the 
.BR bcg_graph (LOCAL)
manual page for more information.
.P
.B Example:
.P
If "labels" is a file containing three labels A1, A2, and A3, then the following three behaviours denote the same explicit LTS that contains a unique state and three transitions from and to this state, labelled respectively A1, A2, and A3.
.P
.nf
    \fBchaos using "labels"
    chaos with 3 labels "A%d"
    chaos with "A1", "A2", "A3"\fP
.fi

.SS BAGS AND FIFO BUFFERS
.nf
.cs I 23
"bag" \fIm\fP "using" \fIF\fP
.cs I
.fi
and
.nf
.cs I 23
"bag" \fIm\fP "with" \fILL\fP
.cs I
.fi
and
.nf
.cs I 23
.nf
.cs I 23
"bag" \fIm\fP "with" \fIn\fP "labels" \fILP1\fP "," \fILP2\fP
.cs I
.fi
and
.nf
.cs I 23
"fifo" \fIm\fP "using" \fIF\fP
.cs I
.fi
and
.nf
.cs I 23
"fifo" \fIm\fP "with" \fILL\fP
.cs I
.fi
and
.nf
.cs I 23
"fifo" \fIm\fP "with" \fIn\fP "labels" \fILP1\fP "," \fILP2\fP
.cs I
.fi
generate an LTS modeling a communication buffer of size \fIm\fP, which can be either a bag (i.e., a communication buffer in which the ordering of messages is not enforced) or a FIFO (First In/First Out) buffer.
.P
\fIm\fP must be a natural number (sequence of digits), possibly enclosed between double quotes. it can also be defined using shell variables (in which case double quotes are mandatory), such as e.g., "$N" and "${N}0".
.P
Buffers distinguish between two kinds of labels, namely \fIinputs\fP and \fIoutputs\fP, modeling respectively the ingoing and outgoing messages.
Each \fIinput\fP is paired with the corresponding \fIoutput\fP.
.P
There are several ways to define the labels handled by the buffer:
.IP -
Using a file \fIF\fP (first and fourth forms): \fIF\fP must be the full name of an existing file, no particular extension being required.
Each label in file \fIF\fP must be written on a separate line, and may be enclosed in double quotes that are removed in the generated LTS.
Labels occurring in odd (respectively even) positions in the file denote \fIinputs\fP (respectively \fIoutputs\fP).
Each \fIinput\fP is paired with the following \fIoutput\fP label in the file.
.IP -
Using a label list \fILL\fP (second and fifth forms):
\fILL\fP is a list of even length. 
Labels occurring in odd (respectively even) positions in the list denote \fIinputs\fP (respectively \fIoutputs\fP).
Each \fIinput\fP is paired with the following \fIoutput\fP in the label list.
In this case, SVL generates a temporary label file used by bcg_graph.
.IP -
Using two label patterns \fILP1\fP, \fILP2\fP and a number \fIn\fP (third and sixth forms): Each of \fILP1\fP and \fILP2\fP must be enclosed between double quotes and contain exactly one occurrence of the substring "%d".
These patterns denote exactly 2\fIn\fP different labels, obtained by replacing the occurrences of "%d" by numbers in the range 1..\fIn\fP.
\fILP1\fP (respectively \fILP2\fP) defines the form of \fIinputs\fP (respectively \fIoutputs\fP).
\fIinputs\fP and \fIoutputs\fP are paired when they are obtained by instanciating \fILP1\fP and \fILP2\fP with the same number.
\fIn\fP must be a natural number (sequence of digits), possibly enclosed between double quotes. It can also be defined using shell variables (in which case double quotes are mandatory), such as e.g., "$N" and "${N}0".
.P
See the
.BR bcg_graph (LOCAL)
manual page for more information.
.P
.B Example:
.P
If "labels" is a file containing four labels INPUT1, INPUT2, OUTPUT1, and OUTPUT2, then the following three behaviours denote the same explicit LTS that models a FIFO buffer with 4 places and exchanging 2 different messages.
.P
.nf
    \fBfifo 4 using "labels"
    fifo 4 with 2 labels "INPUT%d", "OUTPUT%d"
    fifo 4 with "INPUT1", "OUTPUT1", "INPUT2", "OUTPUT2"\fP
.fi

.LP

.ne 5v
.SS CLEANING

Since the expansion phase may generate some redundant operations, the tree of the behaviour is always cleaned using the following clean function:

.ne 18v
.nf
.cs I 23
clean (Gen (Gen (\fIB\fP))) = clean (Gen(\fIB\fP))
clean (Gen (\fISPEC\fP)) =
        Gen (\fISPEC\fP) if LNT, LOTOS, FSP, or EXP
        \fISPEC\fP       otherwise
clean (Gen (Stop)) = Stop
clean (Gen (Abs (\fIB1\fP, \fIL\fP, \fIB2\fP))) = clean (Abs(\fIB1\fP, \fIL\fP, \fIB2\fP))
clean (Gen (Red (\fIB\fP))) = clean (Red (\fIB\fP))
clean (Gen (\fIB\fP)) = Gen (clean (\fIB\fP))
clean (Hide (\fIL\fP, Hide (\fIL'\fP, \fIB\fP)) = clean (Hide (\fIL\fP u \fIL'\fP, \fIB\fP))
                          if matching modes are the same
clean (Hide (\fIX\fP, Stop)) = Stop
clean (Hide (\fIX\fP, \fIB\fP)) = Hide (\fIX\fP, clean (\fIB\fP))
clean (Cut (\fIL\fP, Cut (\fIL'\fP, \fIB\fP)) = clean (Cut (\fIL\fP u \fIL'\fP, \fIB\fP))
                          if matching modes are the same
Clean (Cut (\fIL\fP, Stop)) = Stop
clean (Cut (\fIX\fP, \fIB\fP)) = Cut (\fIX\fP, clean (\fIB\fP))
clean (Prio (\fIX\fP, \fIB\fP)) = Prio (\fIX\fP, clean (\fIB\fP))
clean (\fIB1\fP |\fIop\fP| \fIB2\fP) = clean (\fIB1\fP) |\fIop\fP| clean (\fIB2\fP)
clean (Abs (Stop, \fIL\fP, \fIB2\fP)) = Stop
clean (Abs (\fIB1\fP, \fIL\fP, \fIB2\fP)) = Abs (clean (\fIB1\fP), \fIL\fP, clean (\fIB2\fP))
clean (Red (Red' (\fIB\fP))) = clean (Red' (\fIB\fP)) if Red' <= Red
clean (Red (Gen (Red (\fIB\fP)))) = clean (Red (Gen (\fIB\fP)))
clean (Red (Abs (\fIB1\fP, \fIL\fP, Red (\fIB2\fP)))) = 
                              clean (Red (Abs (\fIB1\fP, \fIL\fP, \fIB2\fP)))
clean (Red (Hide (\fIL\fP, Red (\fIB\fP)))) = clean (Red (Hide (\fIL\fP, \fIB\fP)))
clean (Red (Cut (\fIL\fP, Red (\fIB\fP)))) = clean (Red (Cut (\fIL\fP, \fIB\fP)))
clean (Red (Ren (\fIX\fP, Red (\fIB\fP)))) = clean (Red (Ren (\fIX\fP, \fIB\fP)))
clean (Red (Stop)) = Stop
clean (Red (\fIB\fP)) = Red (clean (\fIB\fP))
clean (Ren (\fIX\fP, Stop)) = Stop
clean (Ren (\fIX\fP, \fIB\fP)) = Ren (\fIX\fP, clean (\fIB\fP))
clean (\fIB\fP) = \fIB\fP otherwise
.cs I
.fi
where Red <= Red' means Red denotes reduction modulo a weaker (<) or equal (=) reduction relation than this of Red'. The "weaker" (partial order) relation is represented by the diagram below, where an arrow goes from R to R' if R' < R:
.ne 23v
.nf
\fB
                   strong
                      |
                +-----+-----+
                |           |
                |     tau-divergence --------+
                |           |                |
                |     tau-compression        |
                |           |          divbranching
                |     tau-confluence         |
                |           |                |
              trace     branching -----------+
                |           |
                |      +----+----+
                |      |         |
                |   tau*.a  observational
                |      |         |
                |      +----+----+
                |           |
                |        safety
                |           |
                +-----+-----+
                      |
                  weak trace\fP
.fi

.SH SEMANTICS OF STATEMENTS

The semantics of statements is defined as follows:

.SS ASSIGNMENT
.nf
.cs I 23
\fIF\fP "=" \fIB\fP
.cs I
.fi
will store in file \fIF\fP the system resulting from the behaviour expression \fIB\fP, with possibly format conversion. \fIF\fP is created in the current directory. 
.P
The file format of \fIF\fP can be LOTOS (extension \fB.lotos\fP or \fB.lot\fP), BCG (extension \fB.bcg\fP), AUT (extension \fB.aut\fP), SEQ (extension \fB.seq\fP), FC2 (extension \fB.fc2\fP), or EXP (extension \fB.exp\fP).
The following rules apply:
.IP -
If the file format of \fIF\fP is LOTOS, then \fIB\fP must be an LNT file (extension \fB.lnt\fP).
In this case, the LOTOS file \fIF\fP is the result of translating the LNT file \fIB\fP into LOTOS using \fBlnt.open\fP.
Note that \fIF\fP can only be overwritten by a subsequent assignment statement having explicitly \fIF\fP as left-hand side.
Therefore, an error message will be issued and the script execution will be stopped if an attempt is made at overwriting \fIF\fP in another way, i.e., if an LNT file with same prefix as \fIF\fP is used in subsequent behaviour expressions.
.IP -
If \fIB\fP is an LNT, LOTOS, or FSP file, or if \fIB\fP is a network of communicating automata (parallel composition expression) and the format of \fIF\fP is this of an explicit LTS, then SVL issues a warning message since the behaviour \fIB\fP should be generated before being assigned.
However, the generation is done automatically by SVL.
.P
Assignment to EXP files must be used cautiously, as shows the following example.
.P
Consider the following program, where \fB<B1>\fP, \fB<B2>\fP, and \fB<B3>\fP are arbitrary behaviours.
.nf
\fB"a.bcg" = <B1>;
"c.bcg" = <B2>;
"b.exp" = "a.bcg" ||| "c.bcg";
"a.bcg" = <B3>;
"d.bcg" = generation of "b.exp"\fP
.fi

It must be clear that the automaton described in "d.bcg" represents the behaviour \fB<B3> ||| <B2>\fP instead of \fB<B1> ||| <B2>\fP since at the time "b.exp" is evaluated, "a.bcg" is bound to \fB<B3>\fP.
.P
On the contrary, in the following program,
.nf
\fB"a.bcg" = <B1>;
"c.bcg" = <B2>;
"b.exp" = (reduction of "a.bcg") ||| "c.bcg";
"a.bcg" = <B3>;
"d.bcg" = generation of "b.exp"\fP
.fi

the automaton described in "d.bcg" represents the behaviour \fB(reduction of <B1>) ||| <B2>\fP, since the reduction is evaluated at the time "b.exp" is created.

.SS COMPARISON
.nf
.cs I 23
[\fIF\fP "="] [\fIE\fP] ["probabilistic" | "stochastic"] "comparison"
   ["using" \fIM\fP] ["with" \fIT\fP]
   \fIB\fP ("==" | "<=" | ">=") \fIB\fP
.cs I
.fi
allows to compare two behaviours. Symbol "==" means "equivalence" whereas "<=" and "=>" denote relation pre-orders. The optional file \fIF\fP must have extension \fB.aut\fP, \fB.bcg\fP, \fB.fc2\fP, or \fB.seq\fP. It is created in the current directory and may contain a diagnostic of the comparison if the result is FALSE.
.P
Some combinations of tool, method, and relation are not available. In this case, SVL tries to change some parameters to perform a comparison as close as possible to what seems to be expected. As much as possible, SVL tries to preserve the parameters in the following priority order: relation, tool, and then method.
.P
\fIT\fP, \fIM\fP, \fIE\fP, "probabilistic", and "stochastic" are optional:
.IP -
The "probabilistic" and "stochastic" comparisons are only available for strong, branching, and divbranching bisimulations with bcg_cmp and using the std method. In this case, the behaviours \fIB\fP must denote explicit LTSs containing probabilistic or stochastic information. See the 
.BR bcg_cmp (LOCAL)
manual page for more information.
.IP -
The default value for \fIE\fP is "strong" and can be changed via the shell variable \fBDEFAULT_COMPARISON_RELATION\fP. 
.IP -
The default value for \fIM\fP depends on the equivalence relation considered.
The shell variable \fBDEFAULT_COMPARISON_METHOD\fP can be set in the SVL file to enforce a particular default value.
.IP -
The default value for \fIT\fP depends on the type of comparison (pre-order or equivalence), on the relation \fIE\fP, and on whether at least one behaviour \fIB\fP is an implicit LTS or not.
For pre-order comparisons, the default value for \fIT\fP is \fIbisimulator\fP.
For equivalence comparisons, the default value for \fIT\fP is determined as in the following table:
.sp
.nf
.cs R 23
.cs B 23
+------------------+---------------+---------------+
| relation         | both explicit |   implicit    |
+------------------+---------------+---------------+
| strong           |    \fBbcg_cmp\fP    |  \fBbisimulator\fP  |
| strong stoch.    |    \fBbcg_cmp\fP    | not available |
| strong prob.     |    \fBbcg_cmp\fP    | not available |
| tau-divergence   |         not available         |
| tau-compression  |         not available         |
| tau-confluence   |         not available         |
| branching        |    \fBbcg_cmp\fP    |  \fBbisimulator\fP  |
| branching stoch. |    \fBbcg_cmp\fP    | not available |
| branching prob.  |    \fBbcg_cmp\fP    | not available |
| divbranching     |    \fBbcg_cmp\fP    | not available |
| divbr. stoch.    |    \fBbcg_cmp\fP    | not available |
| divbr. prob.     |    \fBbcg_cmp\fP    | not available |
| observational    |    \fBbcg_cmp\fP    | not available |
| tau*.a           |          \fBbisimulator\fP          |
| safety           |          \fBbisimulator\fP          |
| trace            |          \fBbisimulator\fP          |
| weak trace       |          \fBbisimulator\fP          |
+------------------+---------------+---------------+
.cs R
.cs B
.fi
.sp
If a relation is not available for implicit LTSs, then a warning is issued and the LTSs are automatically converted into explicit LTSs.
.sp
The shell variable \fBDEFAULT_COMPARISON_TOOL\fP can be set in the SVL file to enforce a particular default value for \fIT\fP.

.SS VERIFICATION
.nf
.cs I 23
[\fIF1\fP "="] "verify" \fIF2\fP ["using" \fIM\fP] ["with" \fIT\fP] "in" \fIB\fP
.cs I
.fi
allows to evaluate a formula on a behaviour, with
.BR evaluator3 (LOCAL),
.BR evaluator4 (LOCAL),
.BR evaluator5 (LOCAL),
or
.BR xtl (LOCAL),
and using method \fIM\fP. The formula must be written in file \fIF2\fP, either in MCL (Model Checking Language) version 3 (regular alternation-free mu-calculus, see the
.BR mcl3 (LOCAL)
manual page), in MCL version 4 (value-passing modal mu-calculus, see the
.BR mcl4 (LOCAL)
manual page), in MCL version 5 (probabilistic value-passing modal mu-calculus, see the
.BR mcl5 (LOCAL)
manual page), or in XTL (eXecutable Temporal Language, see the
.BR xtl-lang (LOCAL)
manual page).
If the formula is written in (dataless or full) MCL, then the file \fIF2\fP must have extension \fB.mcl\fP.
If the formula is written in XTL, then the file \fIF2\fP must have extension \fB.xtl\fP.
.P
The "with \fIT\fP" clause is optional.
\fIT\fP may be one of "evaluator3" (corresponding to the tool
.BR evaluator3 (LOCAL)),
"evaluator4" (corresponding to the tool
.BR evaluator4 (LOCAL)),
"evaluator5" (corresponding to the tool
.BR evaluator5 (LOCAL)),
"evaluator" (corresponding to the tool
.BR evaluator (LOCAL)), or
"xtl" (corresponding to the tool
.BR xtl (LOCAL)).
See
.BR evaluator (LOCAL)
for details on the differences between "evaluator", "evaluator3", "evaluator4", and "evaluator5".
.P
If the "with \fIT\fP" clause is not present, then:
.IP -
If the file \fIF2\fP has extension \fB.xtl\fP, then the tool is \fBxtl\fP.
.IP -
If the file \fIF2\fP has extension \fB.mcl\fP, then the tool is given by the shell variable \fBDEFAULT_VERIFY_TOOL\fP, which is set to "evaluator" by default.
Note that in this case, \fBDEFAULT_VERIFY_TOOL\fP should not have value "xtl".
If the file \fIF2\fP has extension \fB.xtl\fP, then the value of the shell variable \fBDEFAULT_VERIFY_TOOL\fP is irrelevant.
.P
The "using \fIM\fP" clause is optional, and irrelevant in the case of an XTL formula.
In the case of an MCL formula, \fIM\fP may be one of "dfs", "bfs", or "acyclic".
See the
.BR evaluator (LOCAL),
.BR evaluator3 (LOCAL),
.BR evaluator4 (LOCAL),
or
.BR evaluator5 (LOCAL)
manual pages for details about these methods.
If the "using \fIM\fP" clause is not present, then the method is given by the shell variable \fBDEFAULT_VERIFY_METHOD\fP, which is set to "dfs" by default.
.P
File \fIF1\fP is optional and must have extension \fB.aut\fP, \fB.bcg\fP, \fB.fc2\fP, or \fB.seq\fP.
If present, it will contain a diagnostic of the verification in the case of an MCL formula.
It is irrelevant in the case of an XTL formula, since the tool \fBxtl\fP does not generate counter-examples.

.SS VERIFICATION OF INLINE FORMULAS
.nf
.cs I 23
[\fIF\fP "="] \fIB\fP "|=" ["using" \fIM\fP] ["with" \fIT\fP] \fIformula\fP ";"
.cs I
.fi
is similar to "verify" (see Section VERIFICATION for details), except that the formula is not stored in a file, but inlined in the SVL script.
.P
The formula (defined by symbol \fIformula\fP in the syntax above) is defined as the sequence of characters starting from the first character following "|=" (or following the optional "using \fIM\fP" and "with \fIT\fP", if any, where \fIM\fP ranges over "std", "dfs", "bfs", and "acyclic", and \fIT\fP ranges over "evaluator", "evaluator3", "evaluator4", "evaluator5", and "xtl") and ending at the last character preceding the next ";", including all spaces and comments.
Therefore, ";" must be present at the end of this statement, even if it is the last statement of the SVL script.
.P
MCL or XTL libraries can be included by default in the formulas, by using the variables \fBDEFAULT_MCL_LIBRARIES\fP (libraries included by default in all MCL formulas), \fBDEFAULT_EVALUATOR3_LIBRARIES\fP (libraries included by default in dataless MCL formulas checked by
.BR evaluator3 (LOCAL)),
\fBDEFAULT_EVALUATOR4_LIBRARIES\fP (libraries included by default in full  MCL formulas checked by
.BR evaluator4 (LOCAL)),
\fBDEFAULT_EVALUATOR5_LIBRARIES\fP (libraries included by default in full  MCL formulas checked by
.BR evaluator5 (LOCAL)),
and \fBDEFAULT_XTL_LIBRARIES\fP (libraries included by default in all XTL formulas). These variables may be either empty, or contain a list of MCL or XTL library names (with extensions) separated by commas.
They are initially empty, meaning that no library is included by default.
.P
The formula (together with its included libraries) is stored in an intermediate file and parsed by the appropriate tool only during script execution.
Therefore, syntactic errors in the formula (or in the included libraries) will be detected only at runtime, details being reported in the log file.
.P
If the "with \fIT\fP" clause is absent, then the tool is given by the shell variable \fBDEFAULT_VERIFY_TOOL\fP, which is set to "evaluator" by default.
Therefore, by default the formula is supposed to be a dataless MCL formula.
.P
Note that shell variables are substituted in formulas.
.P
.B Examples:
.P
.nf
\fB% ACTION=A
"diag.bcg" = "model.lnt" |= using dfs < '$ACTION' > true;

% DEFAULT_XTL_LIBRARIES="actl.xtl"

"model.bcg" |= with xtl
     let PUT : labelset = EVAL_A (PUT) in
          PRINT_FORM (AG_A (not (PUT), EF (Dia (PUT, true))))
          nop
     end_let;

(* the following is equivalent to the above *)
% DEFAULT_VERIFY_TOOL=xtl
"model.bcg" |=
     let PUT : labelset = EVAL_A (PUT) in
          PRINT_FORM (AG_A (not (PUT), EF (Dia (PUT, true))))
          nop
     end_let;\fP
.fi

.SS DEADLOCK AND LIVELOCK CHECKING
.nf
.cs I 23
[\fIF\fP "="] "deadlock" ["with" \fIT\fP] "of" \fIB\fP
.cs I
.fi
and
.nf
.cs I 23
[\fIF\fP "="] "livelock" ["with" \fIT\fP] "of" \fIB\fP
.cs I
.fi
allow to search deadlocks, respectively livelocks, in a behaviour. 
They return TRUE if the behaviour has at least one deadlock, respectively likelock, and FALSE otherwise.
The optional file \fIF\fP must have extension \fB.aut\fP, \fB.bcg\fP, \fB.fc2\fP, or \fB.seq\fP. It is created in the current directory and may contain a diagnostic of the search, if such a diagnostic is available.
.P 
The tool \fIT\fP is an optional parameter, similar to those described above for the reductions and comparisons.  The default value may be modified via the following variables:
.IP -
\fBDEFAULT_DEADLOCK_TOOL\fP, whose initial value is "exhibitor".
This variable can alternatively be set to "aldebaran", "evaluator", "evaluator3", "evaluator4", or "evaluator5".
.IP -
\fBDEFAULT_LIVELOCK_TOOL\fP, whose initial value is "evaluator".
This variable can alternatively be set to "evaluator3", "evaluator4", "evaluator5", or "aldebaran".
.P
Those two shell variables replace the shell variable \fBDEFAULT_LOCK_TOOL\fP, which was present in earlier versions of SVL and is now obsolete.
.P
Note that \fBfc2tools\fP are no longer supported.

.SS PROPERTY
.nf
.cs I 23
"property" \fIPID\fP ["("\fIparam\fP"," ..."," \fIparam\fP")"]
   ['"'\fIcomment\fP'"' ... '"'\fIcomment\fP'"'] "is" \fIP\fP
"end property"
.cs I
.fi
is the "property" statement, which allows a set of statements to be attached the following attributes:
.IP -
The property has a name, defined by the identifier \fIPID\fP.
It is a string that starts with a letter and contains letters, digits, and underscores, but does not end with an underscore.
.IP -
The property may be parameterized with an arbitrary number of parameters.
Each parameter \fIparam\fP is an identifier satisfying the same syntax as property identifiers.
Distinct parameters of the same property must have distinct identifiers.
Inside the property, every parameter \fIparam\fP can be expanded using $\fIparam\fP or ${\fIparam\fP} as ordinary shell variables.
In particular, if the property contains inline formulas, the parameters are expanded in the formulas.
.IP -
The property may have comments consisting of a (possibly empty) sequence of character strings, each enclosed in double quotes.
Note that parameters can be used inside comments.
.P
The body \fIP\fP of the property consists of a (possibly empty) sequence of statements.
Among those statements, \fIverification statements\fP are the behaviour comparison statement (see Section COMPARISON), the temporal logic verification statement (see Sections VERIFICATION and VERIFICATION OF INLINE FORMULAS), and the deadlock and livelock checking statements (see Section DEADLOCK AND LIVELOCK CHECKING).
.P
Each verification statement (if any) embedded in the property can be followed by an expected result, in the form "expected \fIL\fP", where \fIL\fP is either an identifier (e.g., TRUE, FALSE, ...) or an arbitrary string, which may be a Unix regular expression (see the
.BR regexp (5)
manual page for details about regular expressions).
A verification statement can be followed by an expected result if and only if all verification statements occurring in the same property are also followed by an expected result.
Note that expected results are not allowed outside a property.
.P
Note that for a comparison, a deadlock or livelock checking, or the verification of a formula using
.BR evaluator3 (LOCAL)
or
.BR evaluator4 (LOCAL),
the result is either TRUE or FALSE.
For the verification of a formula using
.BR evaluator5 (LOCAL),
the TRUE or FALSE result may be preceded by probability values if requested by the probabilistic operators contained in the formula.
The probability values are not considered part of the result, only the TRUE or FALSE result being considered.
For the verification of a formula using
.BR xtl (LOCAL),
the format of the result depends on the XTL program; SVL only considers the last non-empty line printed by XTL as being the result.
In all cases, we say that the result satisfies the expected result if the expected result matches the result entirely, using the egrep command (see the
.BR egrep (1)
manual page for details).
.P
If a property has no parameter, then it is checked automatically.
Otherwise, it must be instanciated using a "check" statement of the following form:
.nf
.cs I 23
"check" \fIPID\fP "(" \fIarg\fP "," ... "," \fIarg\fP ")"
.cs I
.fi
where each \fIarg\fP is an argument, which may be any identifier, string (in double quotes), or natural number (i.e., sequence of digits), and where the number of arguments must be equal to the number of parameters.
.P
When checking a property, SVL will display the following information to the user:
.IP -
the name of the property, together with the argument values
.IP -
the comments (one line per comment)
.IP -
if expected results are defined, a PASS or FAIL verdict; PASS indicates that all verification statements met the expected results; otherwise, the verdict has either the form FAIL if the property contains a single verification statement, or the form "FAIL (\fIN\fP/\fIM\fP)" such that \fIM\fP (where \fIM\fP > 1) is the total number of verification statements contained in the property and \fIN\fP (where 0 <= \fIN\fP < \fIM\fP) is the number of verification statements that met the expected results
.IP -
if expected results are not defined, the results of verifications in sequence, in the order of statements
.P
More details of the verifications can be displayed if the user sets the shell variable \fBPROPERTY_DISPLAY_MODE\fP to a non-zero value.
.P
.B Examples:

.nf
\fBproperty No_Deadlock
    "There should be no deadlock in the specification"
is
    "diag.seq" = deadlock of "spec.bcg";
        expected FALSE
end property (* checked automatically *)

property Exist (A, SPEC)
    "Action \\"$A\\" should be reachable in the specification"
is
    "diag_$A_$SPEC.seq" =
        "$SPEC.bcg" |= < true* . '$A' > true;
            expected TRUE
end property

check Exist ("G", "my_spec");
check Exist ("H", "my_spec")\fP
.fi

.P
The display of comments can be parameterized by the user. SVL provides two means to do so:
.IP -
Either redefine the three shell variables \fBPROPERTY_COMMENT_OPEN\fP, \fBPROPERTY_COMMENT_MIDDLE\fP, and \fBPROPERTY_COMMENT_CLOSE\fP, which specify the open comment symbol (printed on one separate line if different from the empty string), middle comment symbol (which will start every comment line), and close comment symbol (printed on one separate line if different from the empty string). See examples below.
.IP -
Or use one of the predefined comment styles by calling the shell function \fBSVL_SET_PROPERTY_COMMENT_STYLE\fP with a parameter among \fBsilent\fP (comments are not displayed), \fBnone\fP, \fBstandard\fP (style by default), \fBindent\fP, \fBada\fP, \fBc\fP, \fBpascal\fP, or \fBsh\fP. Styles are illustrated in the following table:
.br
.ne 20v
.nf
.cs B 23
\fB+----------+-------------+------------+--------------+
| style    | open symbol | mid symbol | close symbol |
+----------+-------------+------------+--------------+
| \fBnone\fP     |             |            |              |
+----------+-------------+------------+--------------+
| \fBstandard\fP |             | " | "      |              |
+----------+-------------+------------+--------------+
| \fBindent\fP   |             | "   "      |              |
+----------+-------------+------------+--------------+
| \fBada\fP      |             | "-- "      |              |
+----------+-------------+------------+--------------+
| \fBc\fP        | "/*"        | " * "      | " */"        |
+----------+-------------+------------+--------------+
| \fBpascal\fP   | "(*"        | " * "      | " *)"        |
+----------+-------------+------------+--------------+
| \fBsh\fP       |             | " # "      |              |
+----------+-------------+------------+--------------+\fP
.cs B
.fi
.P
.B Example:
.P
The following SVL code:
.P
.nf
\fB% PROPERTY_COMMENT_OPEN="(+"
% PROPERTY_COMMENT_MIDDLE=" + "
% PROPERTY_COMMENT_CLOSE=" +)"

property P
    "this is a comment for property P"
is
    stop |= < A > true;
end property\fP
.fi
.P
will execute as follows:
.P
.nf
\fBproperty P
(+
 + this is a comment for property P
 +)

FALSE\fP
.fi
.P
.B Example:
.P
The following SVL code:
.P
.nf
\fB% SVL_SET_PROPERTY_COMMENT_STYLE ada

property P
    "this is a comment for property P"
is
    stop |= < A > true;
end property\fP
.fi
.P
will execute as follows:
.P
.nf
\fBproperty P
-- this is a comment for property P

FALSE\fP
.fi
.ne 8v
.SS SHELL LINES

SVL offers the facility to insert shell lines between statements.  Such lines must start with the symbol "%", and finish with the end of the line.
.P
Of course, SVL operates no static control of the validity of inserted shell lines. Hence, erroneous shell scripts may be generated by SVL due to syntax errors made by the user, or to shell lines breaking the consistency of SVL execution.

.SS COMMENTS

SVL accepts two kinds of comments:
.IP -
Every sequence of characters delimited by "(*" and "*)" is a comment. This notation is inherited from LOTOS and also available in LNT.
.IP -
Every sequence of characters from "--" until the next newline character is a comment. This notation is inherited from LNT.
.P
Comments are ignored (i.e., considered as a blank character) at any place in an SVL script, except:
.IP -
within character strings (delimited by double quotes), and
.IP -
in shell lines (starting with "%"), where shell comments (starting with "#") should be used instead.

.SH STORING STATEMENT RESULTS IN SHELL VARIABLES

SVL allows the result of some statements to be stored in shell variables using the keyword "result" followed by a label, which denotes a shell expression that expands to a shell variable identifier.
The statements whose result can be stored are Bourne shell commands, comparison statements, temporal logic verification statements, and deadlock/livelock checking statements.
If a statement (e.g., a Bourne shell command or an XTL property) produces several lines of output, then only the contents of the last non-empty line is stored in the shell variable.

.P
.B Example 1:

.nf
\fB"a.bcg" = comparison "spec.bcg" == "serv.bcg";
        result R;

% if [ "$R" = FALSE ]
% then
        -- other verifications
        ...
% fi\fP
.fi

.B Example 2:

.nf
\fBproperty P1 (R1)
    "a property"
is
    -- equivalence checking
    "a.bcg" = comparison "spec.bcg" == "serv.bcg";
        result "$R1" expected TRUE;

    -- other verifications
    ...
end property

property P2 (R2)
    "another property reusing part of the previous one"
is
    -- use $R2 to avoid checking equivalence again
    % echo "$R2"
        expected TRUE;

    -- other verifications
    ...
end property

check P1 ("Result"); -- assigns variable Result
check P2 ("$Result") -- uses the value assigned to Result\fP
.fi
.P
Note that "result" can be used in any context, unlike "expected", which cannot be used outside the context of a "property".
Also, if a statement uses both "result" and "expected", then:
.IP -
the "result" part must occur before the "expected" part, and
.IP -
the "result" and "expected" parts must not be separated by a semicolon.
.P
See the syntax of non-terminal \fIRE\fP in Section SYNTAX OF PROGRAMS AND EXPRESSIONS above.

.ne 5v
.SH USING SHELL VARIABLES IN EXPRESSIONS

Every string between double quotes may use defined Bourne shell variables ("$"\fIdefined-shell-variable\fP).
This includes the shell variables defined using the "result" keyword (see Section STORING STATEMENT RESULTS IN SHELL VARIABLES above) and the special Bourne shell variables "$#", "$*", "$@", "$1", "$2", ... which can be used to refer to the \fIscript-parameters\fP passed to the generated script.
.P
However, remember that when using filenames, extensions must always be explicitly mentioned, for the following reasons:
.IP -
They permit to determine at compile-time the resulting format of a behaviour;
.IP -
They permit to distinguish between a file name and a process name, as illustrated in some of the examples below.
.P
.ne 7v
.B Examples:

.nf
\fB% for FNAME in a b c
% do
"reduced-$FNAME.aut" = reduction of "$FNAME.aut"
% done\fP
.fi

is correct, but

.nf
\fB% for FNAME in a.aut b.aut c.aut
% do
"reduced-$FNAME" = reduction of "$FNAME"
% done\fP
.fi

is not correct (a run-time error is issued) because "$FNAME" is interpreted at compile-time as a process whereas it denotes a file name.
However, the following example is correct:

.nf
\fB% DEFAULT_PROCESS_FILE="a.lotos"
% for PNAME in "P1[G1, G2]" P2
% do
"reduced-$PNAME" = reduction of generation of "$PNAME
% done\fP
.fi

This loop reduces in turn the LTSs of processes \fBP1[G1, G2]\fP and \fBP2\fP found in file \fB"a.lotos"\fP.
.P
Shell variables can also be used to denote gates or labels as in the following example:

.nf
\fB% for G in PUT GET
% do
  "P_$G.exp" = 
      "spec.lotos":P ["$G"] 
      |["$G"]|
      "spec.lotos":P ["$G"];
% done\fP
.fi

This loop generates in turn two composition expressions stored in EXP files, corresponding to \fB"spec.lotos":P [PUT] |[PUT]| "spec.lotos":P [PUT]\fP and \fB"spec.lotos":P [GET] |[GET]| "spec.lotos":P [GET]\fP.
.P
Note also that shell variables and expressions can be used to denote lists of labels, gates, or renaming rules, using the braced notation.
A shell expression written between braces will be interpreted as a list of labels instead of a single label, thus differentiating from the quoted notation.
.P
For instance, one may write
.nf
\fB% L1="A, \"B(1, 2)\", C"
"f1.bcg" = total hide D, {$L1} in "f2.bcg";

% L2="A, B, C"
"f3.bcg" = "f4.bcg" |[ {$L2} ]| "f5.lotos":P ["D", {$L2}];

% L3="\"B(\\(.*\\), \\(.*\\))\" -> \"B(\\2, \\1)\", A -> C"
% L4="C -> A, B -> C"
"f6.bcg" = total rename "D" -> "E", {$L3, $L4} in "f7.bcg";\fP
.fi
to express that $A, $B, $C must not be interpreted as single labels or rules (as it would be in "$A", "$B", "$C") but as lists of labels or rules.
.P
Note that the label and rule separator is the coma. 
However, comas between parentheses are not interpreted as label or rule separators, as long as parentheses are well-balanced.

.ne 5v
.SH LOCAL SHELL VARIABLES

SVL provides several shell variables that allow users to fine-tune their verification scripts.  Those variables may be modified (carefully) by the user, in a shell line, as already mentionned.
.P
Use of variables whose name starts with \fBSVL_\fP should be avoided. This syntax is reserved to functions and variables defined internally by SVL.

.SS DEFAULT VERIFICATION PARAMETERS
.P
The following table lists the user-redefinable shell variables relative to the choice of tools, verification methods, equivalence relations, etc., together with their default values.
.P
.ne 9v
.nf
.cs R 23
.cs B 23
+-----------------------------+-----------+----------------+
|           Variable          |  Default  |  Alternative   |
+-----------------------------+-----------+----------------+
| \fBDEFAULT_REDUCTION_TOOL\fP      | See Sect. | aldebaran      |
|                             | REDUCTION | bcg_min        |
|                             | above     | reductor       |
+-----------------------------+-----------+----------------+
| \fBDEFAULT_COMPARISON_TOOL\fP     | See Sect. | aldebaran      |
|                             | COMPARISON| bcg_cmp        |
|                             | above     | bisimulator    |
+-----------------------------+-----------+----------------+
| \fBDEFAULT_VERIFY_TOOL\fP         | See Sect. | evaluator      |
|                             | VERIFY    | evaluator3     |
|                             | above     | evaluator4     |
|                             |           | evaluator5     |
|                             |           | xtl            |
+-----------------------------+-----------+----------------+
| \fBDEFAULT_DEADLOCK_TOOL\fP       | exhibitor | aldebaran      |
|                             |           | evaluator      |
|                             |           | evaluator3     |
|                             |           | evaluator4     |
|                             |           | evaluator5     |
+-----------------------------+-----------+----------------+
| \fBDEFAULT_LIVELOCK_TOOL\fP       | evaluator | evaluator3     |
|                             |           | evaluator4     |
|                             |           | evaluator5     |
|                             |           | aldebaran      |
+-----------------------------+-----------+----------------+
| \fBDEFAULT_REDUCTION_METHOD\fP    | std       | bdd fly        |
+-----------------------------+-----------+----------------+
| \fBDEFAULT_COMPARISON_METHOD\fP   | dfs       | std bdd fly    |
|                             |           | bfs dfs        |
+-----------------------------+-----------+----------------+
| \fBDEFAULT_VERIFY_METHOD\fP       | dfs       | bfs acyclic    |
+-----------------------------+-----------+----------------+
| \fBDEFAULT_REDUCTION_RELATION\fP  | strong    | observational  |
|                             |           | tau*.a         |
|                             |           | branching      |
|                             |           | divbranching   |
|                             |           | safety         |
|                             |           | tau-compression|
|                             |           | tau-divergence |
|                             |           | tau-confluence |
|                             |           | trace          |
|                             |           | weak trace     |
+-----------------------------+-----------+----------------+
| \fBDEFAULT_COMPARISON_RELATION\fP | strong    | observational  |
|                             |           | tau*.a         |
|                             |           | branching      |
|                             |           | divbranching   |
|                             |           | safety         |
|                             |           | trace          |
|                             |           | weak trace     |
+-----------------------------+-----------+----------------+
| \fBDEFAULT_PROCESS_FILE\fP        | not set   |                |
+-----------------------------+-----------+----------------+
| \fBDEFAULT_SMART_LIMIT\fP         | 4         | any nat > 1    |
+-----------------------------+-----------+----------------+
| \fBDEFAULT_MCL_LIBRARIES\fP       | ""        | comma-separated|
|                             |           | MCL lib list   |
+-----------------------------+-----------+----------------+
| \fBDEFAULT_EVALUATOR3_LIBRARIES\fP| ""        | comma-separated|
|                             |           | MCL3 lib list  |
+-----------------------------+-----------+----------------+
| \fBDEFAULT_EVALUATOR4_LIBRARIES\fP| ""        | comma-separated|
|                             |           | MCL4 lib list  |
+-----------------------------+-----------+----------------+
| \fBDEFAULT_EVALUATOR5_LIBRARIES\fP| ""        | comma-separated|
|                             |           | MCL5 lib list  |
+-----------------------------+-----------+----------------+
| \fBDEFAULT_XTL_LIBRARIES\fP       | ""        | comma-separated|
|                             |           | XTL lib list   |
+-----------------------------+-----------+----------------+\fP
.cs R
.cs B
.fi
.P
Note: Variable \fBDEFAULT_LOTOS_FILE\fP is deprecated.
Instead, it is recommended to use \fPDEFAULT_PROCESS_FILE\fP, which can be any file containing a LOTOS (extensions \fB.lot\fP and \fB.lotos\fP), LNT (extension \fB.lnt\fP), or FSP (extension \fB.lts\fP) program.
However, scripts using \fBDEFAULT_LOTOS_FILE\fP should continue to work correctly.

.SS TOOL OPTIONS
.P
The following table lists user-redefinable shell variables that may be assigned options that are passed to tools.
By default, these variables are empty.
See the respective tool manual pages for information about the available options.
.P
.ne 5v
.nf
.cs R 23
.cs B 23
+------------------------+---------------------------------+
|      Variable          |              Role               |
+------------------------+---------------------------------+
| \fBALDEBARAN_OPTIONS\fP      | options passed to \fBaldebaran\fP     |
+------------------------+---------------------------------+
| \fBBCG_CMP_OPTIONS\fP        | options passed to \fBbcg_cmp\fP       |
+------------------------+---------------------------------+
| \fBBCG_GRAPH_OPTIONS\fP      | options passed to \fBbcg_graph\fP     |
+------------------------+---------------------------------+
| \fBBCG_IO_OPTIONS_INPUT\fP   | input options passed to \fBbcg_io\fP  |
+------------------------+---------------------------------+
| \fBBCG_IO_OPTIONS_OUTPUT\fP  | output options passed to \fBbcg_io\fP |
+------------------------+---------------------------------+
| \fBBCG_LABELS_OPTIONS\fP     | options passed to \fBbcg_labels\fP    |
+------------------------+---------------------------------+
| \fBBCG_MIN_OPTIONS\fP        | options passed to \fBbcg_min\fP       |
+------------------------+---------------------------------+
| \fBBCG_OPEN_OPTIONS\fP       | options passed to \fBbcg_open\fP      |
+------------------------+---------------------------------+
| \fBBCG_OPEN_CC_OPTIONS\fP    | C compiler options passed by    |
|                        | \fBbcg_open\fP                        |
+------------------------+---------------------------------+
| \fBCAESAR_ADT_OPTIONS\fP     | options passed to \fBcaesar.adt\fP    |
+------------------------+---------------------------------+
| \fBCAESAR_OPTIONS\fP         | options passed to \fBcaesar\fP        |
+------------------------+---------------------------------+
| \fBEVALUATOR_OPTIONS\fP      | options passed to \fBevaluator\fP     |
+------------------------+---------------------------------+
| \fBEVALUATOR4_OPTIONS\fP     | options passed to \fBevaluator4\fP    |
+------------------------+---------------------------------+
| \fBEVALUATOR5_OPTIONS\fP     | options passed to \fBevaluator5\fP    |
+------------------------+---------------------------------+
| \fBEXHIBITOR_OPTIONS\fP      | options passed to \fBexhibitor\fP     |
+------------------------+---------------------------------+
| \fBEXP_OPEN_OPTIONS\fP       | options passed to \fBexp.open\fP      |
+------------------------+---------------------------------+
| \fBEXP_OPEN_CC_OPTIONS\fP    | C compiler options passed by    |
|                        | \fBexp.open\fP                        |
+------------------------+---------------------------------+
| \fBFSP_OPEN_OPTIONS\fP       | options passed to \fBfsp.open\fP      |
+------------------------+---------------------------------+
| \fBFSP_OPEN_CC_OPTIONS\fP    | C compiler options passed by    |
|                        | \fBfsp.open\fP                        |
+------------------------+---------------------------------+
| \fBGENERATOR_OPTIONS\fP      | options passed to \fBgenerator\fP     |
+------------------------+---------------------------------+
| \fBLNT_OPEN_OPTIONS\fP       | options passed to \fBlnt.open\fP      |
+------------------------+---------------------------------+
| \fBLNT_OPEN_CC_OPTIONS\fP    | C compiler options passed by    |
|                        | \fBlnt.open\fP                        |
+------------------------+---------------------------------+
| \fBLOTOS_OPEN_OPTIONS\fP     | options passed to \fBlotos.open\fP    |
+------------------------+---------------------------------+
| \fBLOTOS_OPEN_CC_OPTIONS\fP  | C compiler options passed by    |
|                        | \fBlotos.open\fP                      |
+------------------------+---------------------------------+
| \fBPROJECTOR_OPTIONS\fP      | options passed to \fBprojector\fP     |
+------------------------+---------------------------------+
| \fBREDUCTOR_OPTIONS\fP       | options passed to \fBreductor\fP      |
+------------------------+---------------------------------+
| \fBSEQ_OPEN_OPTIONS\fP       | options passed to \fBseq.open\fP      |
+------------------------+---------------------------------+
| \fBSEQ_OPEN_CC_OPTIONS\fP    | C compiler options passed by    |
|                        | \fBseq.open\fP                        |
+------------------------+---------------------------------+
| \fBXTL_OPTIONS\fP            | options passed to \fBxtl\fP           |
+------------------------+---------------------------------+
.cs R
.cs B
.fi
.P
As of February 2020, the variables \fBCAESAR_OPEN_OPTIONS\fP and \fBCAESAR_OPEN_CC_OPTIONS\fP are obsolete and replaced by \fBLOTOS_OPEN_OPTIONS\fP and \fBLOTOS_OPEN_CC_OPTIONS\fP, respectively.
.P
In general, SVL does not check the contents of these variables before
passing them to the corresponding tools. However, there is a notable exception
concerning variable \fBEXP_OPEN_OPTIONS\fP:
.IP -
Before calling \fBexp.open\fP, SVL checks that \fB$EXP_OPEN_OPTIONS\fP contains
at most one option among the partial order reduction options available in
\fBexp.open\fP, namely \fB-branching\fP, \fB-deadpreserving\fP, \fB-strong\fP,
and \fB-weaktrace\fP. Otherwise it issues an error message. See
.BR exp.open (LOCAL)
manual page for more details about partial order reduction options.
.IP -
In normal functioning, SVL tries to infer a partial order reduction option
from the context of the composition expression in the SVL program, and then
calls \fBexp.open\fP with this option. However, this is not done if
\fB$EXP_OPEN_OPTIONS\fP already contains a partial order reduction option,
which is thus given priority over the one that could be inferred.

.SS LOCATION OF EXECUTABLES
.P
The following table lists user-redefinable shell variables that may be assigned a path to a different version of the executable file related to a given tool.
.P
.ne 5v
.nf
.cs R 23
.cs B 23
+------------------------+---------------------------------+
|        Variable        |         Default value           |
+------------------------+---------------------------------+
| \fBALDEBARAN_EXECUTABLE\fP   | \fBaldebaran\fP                       |
+------------------------+---------------------------------+
| \fBBCG_CMP_EXECUTABLE\fP     | \fBbcg_cmp\fP                         |
+------------------------+---------------------------------+
| \fBBCG_GRAPH_EXECUTABLE\fP   | \fBbcg_graph\fP                       |
+------------------------+---------------------------------+
| \fBBCG_IO_EXECUTABLE\fP      | \fBbcg_io\fP                          |
+------------------------+---------------------------------+
| \fBBCG_LABELS_EXECUTABLE\fP  | \fBbcg_labels\fP                      |
+------------------------+---------------------------------+
| \fBBCG_MIN_EXECUTABLE\fP     | \fBbcg_min\fP                         |
+------------------------+---------------------------------+
| \fBBCG_OPEN_EXECUTABLE\fP    | \fBbcg_open\fP                        |
+------------------------+---------------------------------+
| \fBBISIMULATOR_EXECUTABLE\fP | \fBbisimulator\fP                     |
+------------------------+---------------------------------+
| \fBCAESAR_ADT_EXECUTABLE\fP  | \fBcaesar.adt\fP                      |
+------------------------+---------------------------------+
| \fBCAESAR_EXECUTABLE\fP      | \fBcaesar\fP                          |
+------------------------+---------------------------------+
| \fBEVALUATOR_EXECUTABLE\fP   | \fBevaluator\fP                       |
+------------------------+---------------------------------+
| \fBEVALUATOR3_EXECUTABLE\fP  | \fBevaluator3\fP                      |
+------------------------+---------------------------------+
| \fBEVALUATOR4_EXECUTABLE\fP  | \fBevaluator4\fP                      |
+------------------------+---------------------------------+
| \fBEVALUATOR5_EXECUTABLE\fP  | \fBevaluator5\fP                      |
+------------------------+---------------------------------+
| \fBEXHIBITOR_EXECUTABLE\fP   | \fBexhibitor\fP                       |
+------------------------+---------------------------------+
| \fBEXP_OPEN_EXECUTABLE\fP    | \fBexp.open\fP                        |
+------------------------+---------------------------------+
| \fBFSP_OPEN_EXECUTABLE\fP    | \fBfsp.open\fP                        |
+------------------------+---------------------------------+
| \fBGENERATOR_EXECUTABLE\fP   | \fBgenerator\fP                       |
+------------------------+---------------------------------+
| \fBLNT_DEPEND_EXECUTABLE\fP  | \fBlnt_depend\fP                      |
+------------------------+---------------------------------+
| \fBLNT_OPEN_EXECUTABLE\fP    | \fBlnt.open\fP                        |
+------------------------+---------------------------------+
| \fBLOTOS_OPEN_EXECUTABLE\fP  | \fBlotos.open\fP                      |
+------------------------+---------------------------------+
| \fBPROJECTOR_EXECUTABLE\fP   | \fBprojector\fP                       |
+------------------------+---------------------------------+
| \fBREDUCTOR_EXECUTABLE\fP    | \fBreductor\fP                        |
+------------------------+---------------------------------+
| \fBSEQ_OPEN_EXECUTABLE\fP    | \fBseq.open\fP                        |
+------------------------+---------------------------------+
| \fBXTL_EXECUTABLE\fP         | \fBxtl\fP                             |
+------------------------+---------------------------------+
.cs R
.cs B
.fi
.P
As of February 2020, the variable \fBCAESAR_OPEN_EXECUTABLE\fP is obsolete and replaced by \fBLOTOS_OPEN_EXECUTABLE\fP.

.SS PROPERTY DISPLAY PARAMETERS
.P
The following table lists the user-redefinable variables that may be used to parameterize the way messages are printed when evaluating properties. See Section PROPERTY for details.
.P
.ne 5v
.nf
.cs R 23
.cs B 23
+-------------------------+------------------------+-------+
|        Variable         |          Role          | Value |
+-------------------------+------------------------+-------+
| \fBPROPERTY_DISPLAY_MODE\fP   | displayed information  |  0/1  |
+-------------------------+------------------------+-------+
| \fBPROPERTY_COMMENT_OPEN\fP   | comment opening symbol |  any  |
+-------------------------+------------------------+-------+
| \fBPROPERTY_COMMENT_MIDDLE\fP | comment middle symbol  |  any  |
+-------------------------+------------------------+-------+
| \fBPROPERTY_COMMENT_CLOSE\fP  | comment closing symbol |  any  |
+-------------------------+------------------------+-------+
.cs R
.cs B
.fi

.SH ENVIRONMENT VARIABLES

The following environment variables are used:

.TP
.B $CADP
Needed. This variable contains the path of directory where CADP is installed.

.TP
.B $CADP/com
This directory should be put in the \fB$PATH\fP variable.

.TP
.B $SVL 
Optional. The first action of the generated script is to include the file \fB$CADP/src/svl/standard\fP, containing a list of predefined shell functions and variables. However, if the environment variable \fBSVL\fP is defined, the included file is \fB$SVL/src/svl/standard\fP. Moreover, the kernel program \fBsvl_kernel\fP will be searched in \fB$SVL/bin.`arch`\fP instead of \fB$CADP/bin.`arch`\fP.

.SH HOW TO READ AN S\&V\&L FILE
.P
The tool
.BR svl (LOCAL)
reads and processes SVL files.


.SH BIBLIOGRAPHY

.P
[GL01] Hubert Garavel and Frederic Lang.
SVL: a Scripting Language for Compositional Verification.
In Myungchul Kim, Byoungmoon Chin, Sungwon Kang, and Danhyung Lee (editors), Proceedings of the 21st International Conference on Formal Techniques for Networked and Distributed Systems FORTE'2001 (Cheju Island, Korea), IFIP Conference Proceedings volume 197, pages 377-394, Kluwer, August 2001.
Available from http://cadp.inria.fr/publications/Garavel-Lang-01.html
.P
[GLM15] Hubert Garavel, Frederic Lang, and Radu Mateescu.
Compositional Verification of Asynchronous Concurrent Systems using CADP.
Acta Informatica, Special Issue on Combining Compositionality and Concurrency: Part 2, 52(4-5):337-392, 2015.
Available from http://cadp.inria.fr/publications/Garavel-Lang-Mateescu-15.html
.P
[KM97] Jean-Pierre Krimm and Laurent Mounier.
Compositional State Space Generation from LOTOS Programs.
In Ed Brinksma (editor), Proceedings of TACAS'97 Tools and Algorithms for the Construction and Analysis of Systems (University of Twente, Enschede, The Netherlands), Lecture Notes in Computer Science volume 1217, Springer, April 1997.
Available from http://cadp.inria.fr/publications/Krimm-Mounier-97.html
.P
[Lan02] Frederic Lang.
Compositional Verification using SVL Scripts.
In Joost-Pieter Katoen and Perdita Stevens (editors), Proceedings of the International Conference on Tools and Algorithms for Construction and Analysis of Systems TACAS'2002 (Grenoble, France), Lecture Notes in Computer Science volume 2280, pages 465-469, Springer, April 2002.
Available from http://cadp.inria.fr/publications/Lang-02.html

.SH SEE ALSO

.BR aldebaran (LOCAL),
.BR aut (LOCAL),
.BR bcg (LOCAL),
.BR bcg_cmp (LOCAL),
.BR bcg_graph (LOCAL),
.BR bcg_io (LOCAL),
.BR bcg_labels (LOCAL),
.BR bcg_min (LOCAL),
.BR bcg_open (LOCAL),
.BR caesar (LOCAL),
.BR caesar.adt (LOCAL),
.BR caesar_hide_1 (LOCAL),
.BR caesar_rename_1 (LOCAL),
.BR evaluator (LOCAL),
.BR evaluator3 (LOCAL),
.BR evaluator4 (LOCAL),
.BR evaluator5 (LOCAL),
.BR exhibitor (LOCAL),
.BR exp (LOCAL),
.BR exp.open (LOCAL),
.BR generator (LOCAL),
.BR lnt.open (LOCAL),
.BR lotos.open (LOCAL),
.BR mcl (LOCAL),
.BR mcl3 (LOCAL),
.BR mcl4 (LOCAL),
.BR mcl5 (LOCAL),
.BR projector (LOCAL),
.BR reductor (LOCAL),
.BR regexp (LOCAL),
.BR seq (LOCAL),
.BR seq.open (LOCAL),
.BR svl (LOCAL),
.BR xtl (LOCAL),
.BR xtl-lang (LOCAL)
.P
Directives for installation are given in files \fB$CADP/INSTALLATION_*\fP.
.P
Recent changes and improvements to this software are reported and commented in file \fB$CADP/HISTORY\fP.

.SH BUGS

Please report any bug to cadp@inria.fr

