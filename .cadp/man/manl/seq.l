.\" @(#)seq.l - VASY and CONVECS teams - 2019/01/14
.TH SEQ LOCAL "2019/01/14" "(C) INRIA" "CADP MANUAL PAGES"
.fp 4 CB
.lg 0
.SH NAME
seq, SEQ \- CADP common format for execution sequences (i.e., traces)

.SH DESCRIPTION
.P
The SEQ format (where \fISEQ\fP stands for \fISEQuence\fP) is used to
specify a finite set (possibly empty) of execution sequences belonging
to a Labelled Transition System (LTS). Each of these sequences is finite
and starts from the initial state of the LTS. Thus, a SEQ file specifies
a subgraph of the LTS; in this subgraph, only the initial state may have
more than one successor state (namely, if there are several sequences).

.P
The SEQ format has been carefully designed so as to be easily
readable and writable by both humans and computer programs. For this
reason, it is a character-based format. Files in the SEQ format
are expected to have a \fB.seq\fP extension.

.P
There are two versions of the SEQ format:

.IP -
In the \fIsimple format\fP, execution sequences are merely specified
as lists of transition labels; labels are specified as character strings.

.IP -
In the \fIfull format\fP, execution sequences are specified in
a more sophisticated way, using regular expressions; labels are
represented either as character strings or regular expressions.

.P
Both versions of the SEQ format are compatible in the sense that
the simple format is a subset of the full format. Therefore, the
simple format can be used at every place where the full format is
allowed.

.SH B\&N\&F-LIKE NOTATION
.P
The syntax of the SEQ format is described below using a
notation similar to the BNF (Backus-Naur Form) notation. However,
as the angle brackets \fB<\fP and \fB>\fP used in BNF are also meaningful
in the SEQ format, there are some differences with respect to the
standard BNF notation:

.IP -
Terminal symbols are enclosed in simple quotes, whether they
are one or several characters long
(for instance: \fB'+'\fP, \fB'"'\fP, \fB'<while>'\fP, etc.).
In particular, \fB'\en'\fP and \fB'\et'\fP denote the newline and tabulation
characters.

.IP -
Non-terminal symbols are written as alphabetic identifiers
(for instance, \fBsequence\fP, \fBsequence_list\fP, etc.).
Contrary to the standard BNF notation, non-terminal symbols are
not enclosed within angle brackets.

.IP -
The following meta symbols are used, with their usual meaning:
parentheses for grouping, star (\fB*\fP) for zero or more repeated
occurrences, and vertical bar (\fB|\fP) for alternates.

.P
Note: it should be understood that \fB*\fP and \fB'*'\fP do not have
the same meaning: the former is the meta-symbol denoting repeated occurrences,
whereas the latter denotes the terminal character "star".

.SH LEXICAL DEFINITIONS

.SS STRINGS

A \fBstring\fP is a sequence of characters, enclosed between double
quotes characters \fB'"'\fP, that denotes a label of the LTS: 

.nf
 \fBstring ::= '"' valid_character* '"'\fP
.fi

where \fBvalid_character\fP denotes any character different from double quote
(\fB'"'\fP) and from end-of-line (\fB'\en'\fP). Consequently, a \fBstring\fP
cannot encompass several lines; however, there can be several \fBstring\fPs
on the same line (see, e.g., \fBlabel\fP and \fBlabel_group\fP below).

.P
The \fBstring\fPs can be used in both the simple and full SEQ format,
with the same lexical conventions.

.SS REGULAR EXPRESSIONS

A \fBregular_expression\fP is a notation for a set of labels.
The \fBregular_expression\fPs of the SEQ format are based upon
UNIX basic regular expressions (see the
.BR regexp (5)
and
.BR regexp (LOCAL)
manual page for a detailed description of UNIX basic regular expressions).
Syntactically, a \fBregular_expression\fP of the SEQ format is a
UNIX basic regular expression enclosed between square brackets \fB'['\fP
and \fB']'\fP:

.nf
 \fBregular_expression ::= '[' UNIX_basic_regular_expression ']'\fP
.fi

Unlike standard UNIX basic regular expressions, each \fBregular_expression\fP
must satisfy two additional restrictions:

.IP -
First, it should not be empty (otherwise, the \fBregular_expression\fP
would be confused with another meaningful token \fB'[]'\fP).

.IP -
Second, there should be exactly the same numbers of \fB'['\fP and \fB']'\fP
characters in \fBUNIX_basic_regular_expression\fP. This precludes
the use of very particular regular expressions such as \fB'a[^]]b'\fP
or \fB'a[]bc]d'\fP. This restriction should not be a problem for
OPEN/CAESAR users.

.P
Like \fBstring\fPs, \fBregular_expression\fPs cannot encompass several
lines; however, there can be several \fBregular_expression\fPs on the
same line (see, e.g., \fBlabel\fP and \fBlabel_group\fP below).

.P
Note: the choice operator \fB'|'\fP is not supported in UNIX basic
regular expressions. For instance, 
.nf
      \fB[PUT.*|GET.*]\fP
.fi
will search for a label of the form \fB"PUT.*|GET.*"\fP rather than
for either \fB"PUT.*"\fP or \fB"GET.*"\fP. However, the intended
meaning can be obtained using the choice operator available in
the syntax of \fBlabel\fPs (see below):
.nf
      \fB[PUT.*] | [GET.*]\fP
.fi

.P
The \fBregular expression\fPs can only be used in the full SEQ format.

.SS BLANKS

A \fBblank\fP is a (possibly empty) sequence of space
characters \fB'\ '\fP and/or tab \fB'\et'\fP characters:

.nf
 \fB blank ::= ( ' ' | '\et' )*\fP
.fi

\fBBlank\fPs can appear anywhere, at the beginning of a line, at the
end of a line, or between two tokens. They are ignored (except, of
course, in \fBstring\fPs and \fBregular expression\fPs).
.P
Note: end-of-line characters (\fB'\en'\fP) are not part
of \fBblank\fPs. On the contrary, they are meaningful in the
SEQ format as they are used in the definition of many
non-terminal symbols.
.P
Both versions of the SEQ format share the same lexical conventions
for \fBblank\fPs.

.SS COMMENTS

A \fBcomment\fP is a sequence of characters that is meaningless and
ignored. There are two kinds of \fBcomment\fPs:

.IP -
Any sequence of characters that begins with the special
character \fB'\e001'\fP (control-A) and that ends with the special
character \fB'\e002'\fP (control-B) is a \fBcomment\fP.
A \fBcomment\fP of this form may encompass several lines of text.  The
characters \fB'\e001'\fP and \fB'\e002'\fP have been selected because
they are not visible by the user.

.IP -
Any line whose first non-blank character does not belong to the
following list of reserved
characters: \fB'['\fP, \fB'('\fP, \fB'<'\fP, \fB'"'\fP, \fB'~'\fP, \fB'\e001'\fP
is a \fBcomment\fP. This \fBcomment\fP extends up to the end-of-line. This
definition includes the case of lines that contain nothing but \fBblanks\fP.

.LP
Both versions of the SEQ format share the same lexical conventions
for \fBcomment\fPs.

.SH SYNTAX OF THE SIMPLE FORMAT

The following BNF-like grammar defines the syntax of the simple SEQ
format. The axiom of the grammar is \fBsequence_list\fP.

.nf
.cs 4 23
\fBsequence_list     ::= ''
                   |  sequence
                   |  sequence '[]' '\en' sequence_list

sequence          ::= string '\en'
                   |  string '\en' sequence
                   |  '<deadlock>' '\en'\fP
.cs 4
.fi
.P
Note: this grammar defines a regular language.

.SH SYNTAX OF THE FULL FORMAT

The following BNF-like grammar defines the syntax of the full SEQ
format. The axiom of the grammar is \fBsequence_list\fP.

.nf
.cs 4 23
\fBsequence_list     ::= ''
                   |  sequence
                   |  sequence '[]' '\en' sequence_list
.sp
sequence          ::= label_group '\en'
                   |  label_group '\en' sequence
                   |  '<deadlock>' '\en'
.sp
label_group       ::= label
                   |  label '*'
                   |  label '+'
                   |  '<while>' label
                   |  '<until>' label
                   |  '<while>' label '<until>' label
.sp
label             ::= simple_label
                   |  label '&' simple_label
                   |  label '|' simple_label
                   |  label '^' simple_label
.sp
simple_label      ::= '<any>'
                   |  string
                   |  regular_expression
                   |  '~' simple_label
                   |  '(' label ')'\fP
.fi
.cs 4

Note: each \fBlabel_group\fP (and consequently each \fBlabel\fP
and \fBsimple_label\fP) appears on a single line of text.
.P
Note: from the grammar, the postfix operators \fB'+'\fP and \fB'*'\fP,
and the \fB'<while>'\fP and \fB'<until>'\fP operators have the lowest
priority. Then, the binary operators \fB'&'\fP, \fB'|'\fP,
and \fB'^'\fP have the same, intermediate priority.  Finally, the prefix
operator \fB'~'\fP has the highest priority.

.P
Note: the simple SEQ format is the subset of the full SEQ format in
which each \fBlabel_group\fP is constrained to be simply a \fBstring\fP.

.SH SEMANTICS OF THE FULL FORMAT

The semantics of the full format is defined by induction on its syntax;
the semantics of the simple format can be derived as a special case.

.P
Let (S0 T1 ... Tn Sn) be an execution sequence that starts from some state
S0 (not necessarily the initial state of the LTS) and that reaches some
state Sn by applying n successive transitions T1, ..., Tn. The number n of
transitions can be null.

.P
A SEQ file contains a finite list of execution \fBsequence\fPs,
separated by the \fB'[]'\fP keyword. This list can be empty, as
specified by the \fB''\fP token in the BNF-like grammar. The
semantics of the full format is only defined for a given \fBsequence\fP:

.IP -
If this list is empty, then the SEQ file only matches the empty
execution sequence (S0), where S0 is equal to the initial state of the LTS.

.IP -
If this list contains more than one element, then a particular
\fBsequence\fP must be selected; for instance, the \fB-seqno\fP of the
.BR exhibitor (LOCAL)
tool enables the user to indicate which \fBsequence\fP is to be 
considered. In such case, the semantics of the full format is the
set of all execution sequences (S0 T1 ... Tn Sn) such that S0 is
equal to the initial state of the LTS and such that the sequence-matching 
relation "(S0 T1 ... Tn Sn) |==== \fBsequence\fP" defined hereafter
is satisfied.

.SS DEFINITION OF SIMPLE LABEL MATCHING

.P
For any transition T of the LTS, let L(T) denote the character string
generated from the label of transition T.

.P
Let "T |= \fBsimple_label\fP" be a relation expressing that the transition
T "matches" \fBsimple_label\fP. This relation is defined by induction on the
syntax of \fBsimple_label\fP and it is mutually recursive with the relation
"T |== \fBlabel\fP" defined in the next subsection.

.TP
T |= \fB'<any>'\fP
is always true
.sp
.TP
T |= \fBstring\fP
iff L(T) is equal to \fBstring\fP
.sp
.TP
T |= \fBregular_expression\fP
iff L(T) matches \fBregular_expression\fP
.sp
.TP
T |= \fB'~' simple_label\fP
iff not T |= \fBsimple_label\fP
.sp
.TP
T |= \fB'(' label ')'\fP
iff T |== \fBlabel\fP

.SS DEFINITION OF LABEL MATCHING

.P
Let "T |== \fBlabel\fP" be a relation expressing that the transition 
T "matches" \fBlabel\fP. This relation is defined by induction on the
syntax of \fBlabel\fP.

.TP
T |== \fBsimple_label\fP
iff T |= \fBsimple_label\fP
.sp
.TP
T |== \fBlabel\fP \fB'&' simple_label\fP
iff T |== \fBlabel\fP and T |= \fBsimple_label\fP
.sp
.TP
T |== \fBlabel\fP \fB'|' simple_label\fP
iff T |== \fBlabel\fP or T |= \fBsimple_label\fP
.sp
.TP
T |== \fBlabel\fP \fB'^' simple_label\fP
iff T |== \fBlabel\fP exclusive-or T |= \fBsimple_label\fP
.P
Note: \fBregular_expression\fPs apply to \fIentire\fP \fBlabel\fP
strings, from the first character to the last one, and not to
substrings. For instance, the \fBlabel\fP \fB'PUT !0'\fP will match
the regular expression \fB'PUT.*'\fP, but not \fB'PUT'\fP.
Consequently, the special characters \fB'^'\fP and \fB'$'\fP of
UNIX basic regular expressions are useless in the SEQ format, and
should not be used.

.SS DEFINITION OF LABEL GROUP MATCHING

.P
Let "(S0 T1 ... Tn Sn) |=== \fBlabel_group\fP" be a relation expressing that
the execution sequence (S0 T1 ... Tn Sn) matches \fBlabel_group\fP. This
relation is defined by induction on the syntax of \fBlabel_group\fP.

.TP
(S0 T1 ... Tn Sn) |=== \fBlabel\fP
iff n = 1 and T1 |== \fBlabel\fP
.sp
.TP
(S0 T1 ... Tn Sn) |=== \fBlabel '*'\fP
iff for all i in {1 ... n} Ti |== \fBlabel\fP

.P
The remaining constructs \fB'+'\fP, \fB'<while>'\fP, and \fB'<until>'\fP
used in  the syntactic definition of \fBlabel_group\fP are merely shorthand
notations introduced for user convenience. They are defined as follows:

.IP -
The construct:
.nf
      \fBlabel '+'\fP
.fi
is equivalent to:
.nf
      \fBlabel '\en'
      label '*'\fP
.fi
It denotes a sequence of one or more transitions matching \fBlabel\fP.

.IP -
The construct:
.nf
      \fB'<while>' label\fP
.fi
is equivalent to:
.nf
      \fBlabel\fP '*'
.fi
It denotes a sequence of zero or more transitions matching \fBlabel\fP.

.IP -
The construct:
.nf
      \fB'<until>' label\fP
.fi
is equivalent to:
.nf
      \fB'(~' label ')*' '\en'
      label\fP
.fi
It denotes a sequence of zero or more transitions that do not
match \fBlabel\fP, followed by a transition matching \fBlabel\fP.

.IP -
The construct:
.nf
      \fB'<while>' label1 '<until>' label2\fP
.fi
is equivalent to:
.nf
      \fB'(' label1 '& ~' label2 ')*' '\en'
      label2\fP
.fi
It denotes a sequence of zero or more transitions that match \fBlabel1\fP
and do not match \fBlabel2\fP, followed by a transition matching \fBlabel2\fP.

.SS DEFINITION OF SEQUENCE MATCHING

.P
Let "(S0 T1 ... Tn Sn) |==== \fBsequence\fP" be a relation expressing
that the execution sequence (S0 T1 ... Tn Sn) matches \fBsequence\fP.
This relation is defined by induction on the syntax of \fBsequence\fP.

.TP
(S0 T1 ... Tn Sn) |==== \fBlabel_group '\en'\fP
iff (S0 T1 ... Tn Sn) |=== \fBlabel_group\fP
.sp
.TP
(S0 T1 ... Tn Sn) |==== \fBlabel_group '\en' sequence\fP
iff there exists some state Sm in the sequence (S0 T1 ... Tn Sn) such that:
.br
(S0 T1 ... Tm Sm) |=== \fBlabel_group\fP and
.br
(Sm Tm+1 ... Tn Sn) |==== \fBsequence\fP
.sp
.TP
(S0 T1 ... Tn Sn) |==== \fB'<deadlock>' '\en'\fP
iff n = 0 (the sequence is reduced to a single state) and
.br
S0 is a sink state (no transition goes out from S0)
.P

.SH EXHIBITOR'S SEMANTIC CONVENTIONS

The current version of 
.BR exhibitor (LOCAL)
interprets the full SEQ format in particular ways, described hereafter.

.SS TRANSITION LABELS

Since
.BR exhibitor (LOCAL)
operates on the fly and is based on the OPEN/CAESAR's graph module,
it implements the aforementioned T(L) notation by invoking
the \fBCAESAR_STRING_LABEL()\fP function (see the
.BR caesar_graph (LOCAL)
manual page).

.SS CASE INSENSITIVITY

In order to be compatible with the conventions used by
.BR caesar (LOCAL)
when printing labels as character strings, all lower-case letters
contained in \fBstring\fPs and \fBregular_expression\fPs are turned 
to upper case. However, the \fBstring\fPs and \fBregular_expression\fPs
(case-insensitively) equal to \fB"i"\fP or \fB"exit"\fP are recognized 
as special values (denoting the internal gate and the termination gate)
and turned to lower case.

.P
This is the default option, but it can be overriden using the \fB-case\fP
option of
.BR exhibitor (LOCAL)
if case sensitivity needs to be preserved.

.SS DETERMINIZATION STRATEGY

.P
Given a \fBsequence\fP, \fBexhibitor\fP will search for execution
sequences (S0 T1 ... Tn Sn) such that S0 is equal to the initial state of
the LTS and such that (S0 T1 ... Tn Sn) |==== \fBsequence\fP. 

.P
In the above second semantic rule defining sequence matching (namely, 
"(S0 T1 ... Tn Sn) |==== \fBlabel_group '\en' sequence\fP"), if there exist
several states Sm, the one with the greatest index m is selected. By doing
so, \fBexhibitor\fP reduces potentially non-deterministic sequences into
deterministic ones.  Intuitively, every time that \fBexhibitor\fP has
the choice between remaining in a '*'-group or leaving it, it will
remain in the '*'-group. For instance, if the label \fB"B"\fP has to
be matched against the sequence:
.nf
 \fB     (~ "A") *
      "B"\fP
.fi
there is a conflict, since \fB"B"\fP matches both lines of the sequence.
In such case, the sequence will not be recognized successfully, since
the label \fB"B"\fP will be used to match the first line of the sequence
instead of the second line. Therefore, the determinization strategy gives
priority to the longest match.
.P
The \fB-conflict\fP option of
.B exhibitor
(see the
.BR exhibitor (LOCAL)
manual page for a detailed decription of this option) can be used to
display the list of all conflicts which have been solved using this
determinization strategy.
.P
The solution to this problem consists in avoiding the conflict by
making the sequence more precise:
.nf
 \fB     (~ "A" & ~ "B") *
      "B"\fP
.fi

Similarly, the sequence:
.nf
 \fB     <any>*
      "A"\fP
.fi
will never be recognized, because of the conflict between \fB<any>\fP
and \fB"A"\fP.  It should be written instead:
.nf
  \fB    (~ "A") *
      "A"\fP
.fi

Note: translating the \fBlabel_group\fP construct:
.nf
      \fBlabel '+'\fP
.fi
to:
.nf
      \fBlabel '*' '\en'
      label\fP
.fi
would not be correct because, due to the determinization strategy, this
sequence is never recognized (one always remains in the '*'-group).

.SS SEQUENCE REDUCTION

\fBexhibitor\fP removes all trailing '*'-groups at the end of the sequence to
be searched, because these groups are meaningless. For instance, the following
sequence:
.nf
      \fB"A"
      "B"*
      "C"*\fP
.fi
is reduced to:
.nf
      \fB"A"\fP
.fi

If the sequence becomes empty due to this reduction, \fBexhibitor\fP emits
a warning and stops.

.SH EXAMPLES OF PATTERNS

The following sequence:
.nf
     \fB"i" *
     "PUT"
     "i" *
     "GET"\fP
.fi
searches for an action \fB"PUT"\fP, followed by an action \fB"GET"\fP,
with any number of invisible actions \fB"i"\fP before and between.
.P
The following sequence:
.nf
     \fB<until> [PUT !TRUE !.*]
     <until> [GET !FALSE !.*]\fP
.fi
searches for an action of the form \fB"PUT !TRUE !.*"\fP, followed by
an action of the form \fB"GET !FALSE !.*"\fP, with any number of visible or
invisible actions before and between.
.P
The following sequence:
.nf
        \fB<until> ([SEND !.*] & ~ "SEND !NULL")\fP
.fi
searches for an action of the form \fB"SEND !.*"\fP such that the
offer associated with gate \fB"SEND"\fP is different from \fB"NULL"\fP.
.P
The following sequence:
.nf
     \fB<until> "OPEN !1"
     <while> ~ "CLOSE !1" <until> "OPEN !2"\fP
.fi
searches for an action \fB"OPEN !1"\fP, followed by an action \fB"OPEN
!2"\fP without any \fB"CLOSE !1"\fP action between them.
.P
The following sequence:
.nf
      \fB<any>*
      <deadlock>\fP
.fi
searches for deadlocks. Thus, \fBexhibitor\fP can be used as an
alternative to
.BR terminator (LOCAL),
although it implements totally different algorithms.

.SH HOW TO CREATE A S\&E\&Q FILE

.P
It is easy to create a SEQ file manually, using a text editor. 
It is also possible to produce a SEQ file automatically, using the
.BR bcg_io (LOCAL)
tool, which converts to the simple SEQ format a graph (encoded
in various other formats) consisting of a set of sequences all starting
from the initial state. Finally, many CADP tools for simulation, model
checking, equivalence checking, etc. generate their output in SEQ format
when such output denotes an execution sequence or a set of execution
sequences (as opposed to more general labelled transition systems).

.SH HOW TO READ A S\&E\&Q FILE
.P
The tool
.BR seq.open (LOCAL)
reads a SEQ file in the simple SEQ format.

.P
The tool
.BR exhibitor (LOCAL)
reads a SEQ file in the full SEQ format.

.P
SEQ files can be converted to many other graph formats using the
.BR bcg_io (LOCAL)
tool.

.SH AUTHORS
The SEQ format was developed by Hubert Garavel (INRIA Rhone-Alpes).

.SH SEE ALSO
.P
.BR bcg_io (LOCAL),
.BR exhibitor (LOCAL),
.BR seq.open (LOCAL)

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

