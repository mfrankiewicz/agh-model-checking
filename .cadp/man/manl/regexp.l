.TH regexp LOCAL "2019/01/08" " " "UNIX MANUAL PAGES"
.fp 4 CB
.lg 0
.SH REGULAR EXPRESSIONS
.P
This page is an excerpt of the UNIX manual page
.BR regexp (5)
that defines the syntax and semantics of regular expressions
used by the
.BR seq (LOCAL)
format of CADP, the
.BR exhibitor (LOCAL)
tool, and the
.SB OPEN/CAESAR
application programming interfaces
.BR caesar_hide_1 (LOCAL)
and
.BR caesar_rename_1 (LOCAL).

.SH REGULAR EXPRESSIONS
A regular expression specifies a set of character strings.
A member of this set of strings is said to be matched by the regular
expression.
Some characters have special meaning when used in a regular
expression;
other characters stand for themselves.
.LP
The following
.I one-character
.IR \s-1RE\s+1 s
match a
.I single
character:
.TP
1.1
An ordinary character
(\c
.I not
one of those discussed in 1.2 below)
is a
one-character \s-1RE\s+1
that matches itself.
.br
.ne 5
.TP
1.2
A backslash (\fB\|\^\e\fP\|) followed by any special character is a
one-character \s-1RE\s+1
that matches the special character itself.
The special characters are:
.RS
.TP
a.
\&\fB.\fP,
\fB\(**\fP,
\fB[\fP\|,
and
\fB\^\e\fP (period, asterisk, left square bracket,
and backslash, respectively), which are always special,
.I except
when they appear within square brackets (\^\fB[\|]\fP\^; see 1.4 below).
.TP
b.
^ (caret or circumflex), which is special at the
.I beginning
of an
.I entire
\s-1RE\s+1
(see 4.1 and 4.3 below),
or when it immediately follows the left of a pair of square brackets (\^\fB[\|]\fP\^) (see 1.4 below).
.TP
c.
\fB$\fP (dollar sign), which is special at the
\fBend\fP
of an
\fIentire\fR \s-1RE\s+1
(see 4.2 below).
.TP
d.
The character used to bound
(that is, delimit) an entire \s-1RE\s+1, which is special for that RE
(for example,
see how slash (\^\fB/\fP\^) is used in the
.B g
command, below.)
.RE
.TP
1.3
A period (\^\fB.\fP\^) is a
one-character \s-1RE\s+1
that matches any character except new-line.
.TP
1.4
A non-empty string of characters enclosed in
square brackets (\^\fB[\|]\fP\^) is a
one-character \s-1RE\s+1
that matches
.I "any one\^"
character in that string.
If, however, the first character of the string is a circumflex
(\^^\^), the
one-character \s-1RE\s+1
matches any character
.I except
new-line and the remaining characters in the string.
The ^ has this special meaning
.I only
if it
occurs first in the string.
The minus (\fB\-\fP) may be used to indicate a range of consecutive
characters;
for example, \fB[0\-9]\fP is equivalent to \fB[0123456789]\fP.
The \fB\-\fP loses this special meaning if it occurs first (after
an initial ^, if any)
or last in the string.
The right square bracket (\^\fB]\fP\^)
does not terminate such a string when it
is the first character within it (after an initial ^, if any);
for example, \fB[\|]a\-f]\fP matches either a right square
bracket (\^\fB]\fP\^) or one of the
.SM ASCII
letters \fBa\fP through \fBf\fP inclusive.
The four characters listed in 1.2.a above stand for themselves
within such a string of characters.
.LP
The following rules may be used to construct \s-1RE\s+1s
from
one-character
\s-1RE\s+1s:
.TP
2.1
A
one-character \s-1RE\s+1
is a
\s-1RE\s+1
that matches whatever the
one-character \s-1RE\s+1 matches.
.br
.ne 5
.TP
2.2
A
one-character \s-1RE\s+1
followed by an asterisk (\fB\(**\fP) is a
\s-1RE\s+1
that matches
.B 0
or more occurrences of the
one-character \s-1RE\s+1.
If there is any choice,
the longest leftmost string that permits a match is chosen.
.TP
2.3
A
one-character \s-1RE\s+1
followed by \fB\^\e{\fP\^\fIm\fP\^\fB\e}\fP,
\fB\^\e{\fP\^\fIm,\fP\^\fB\e}\fP,
or
\fB\^\e{\fP\^\fIm,n\fP\^\fB\e}\fP is a
\s-1RE\s+1
that matches a
.I range
of occurrences of the
one-character \s-1RE\s+1.
The values of
.I m
and
.I n
must be non-negative integers less than 256;
\fB\^\e{\fP\^\fIm\fP\^\fB\e}\fP
matches
.I exactly
.I m
occurrences;
\fB\^\e{\fP\^\fIm,\fP\^\fB\e}\fP
matches
.I "at least\^"
.I m
occurrences;
\fB\^\e{\fP\^\fIm,n\fP\^\fB\e}\fP
matches
.I "any number\^"
of occurrences
.I between
.I m
and
.I n
inclusive.
Whenever a choice exists,
the
\s-1RE\s+1
matches as many occurrences as possible.
.TP
2.4
The concatenation of
\s-1RE\s+1s
is a
\s-1RE\s+1
that matches the concatenation of the strings matched by each component of the
\s-1RE\s+1.
.TP
2.5
A
\s-1RE\s+1
enclosed between the character sequences
\fB\^\e\|(\fP and \fB\^\e\|)\fP
is a
\s-1RE\s+1
that matches whatever the unadorned
\s-1RE\s+1
matches.
.br
.ne 5
.TP
2.6
The expression \fB\^\e\|\fP\fIn\fP\^ matches the same string of characters
as was
matched by an expression enclosed between \fB\^\e\|(\fP and \fB\^\e\|)\fP
.I earlier
in the same \s-1RE\s+1.
Here
.I n
is a digit;
the sub-expression specified is that beginning with the
.IR n -th
occurrence of \fB\^\|\e\|(\fP counting from the left.
For example, the expression ^\|\fB\e\|(\|.\|\(**\|\e\|)\|\e\|1\|$\fP matches a line
consisting of two repeated appearances of the same string.
.LP
A RE may be constrained to match words.
.TP
3.1
\fB\e\|<\fP constrains a RE to match the beginning of a string or to follow
a character that is not a digit, underscore, or letter.
The first character matching the RE must be a digit,
underscore, or letter.
.TP
3.2
\fB\e\|>\fP constrains a RE to match the end of a
string or to precede
a character that is not a digit, underscore, or letter.
.LP
An
.I entire
.I \s-1RE\s+1
may be constrained to match only an initial segment or final segment
of a line (or both).
.TP
4.1
A circumflex (\^^\^) at the beginning of an
entire \s-1RE\s+1
constrains that \s-1RE\s+1 to match an
.I initial
segment of a line.
.TP
4.2
A dollar sign (\^\fB$\fP\^)
at the end of an
entire \s-1RE\s+1
constrains that
\s-1RE\s+1
to match a
.I final
segment of a line.
.TP
4.3
The construction
^\fIentire \s-1RE\s+1\fP\|\fB$\fP
constrains the
entire \s-1RE\s+1
to match the entire line.
.LP
The null \s-1RE\s+1 (for example, \fB//\|\fP)
is equivalent to the last \s-1RE\s+1 encountered.

.SH CHARACTERS WITH SPECIAL MEANING
Characters that have special meaning except when they appear
within square brackets (\fB[\|]\fR) or are preceded by \fB\e\fR
are:  \fB.\fR, \fB*\fR, \fB[\|\fR, \fB\e\fR\|.
Other special characters, such as \fB$\fR have special meaning
in more restricted contexts.
.P
The character \fB^\fR at the beginning of an expression permits a
successful match only immediately after a newline, and the
character \fB$\fR at the end of an expression requires a trailing newline.
.P
Two characters have special meaning only when used within square brackets.
The character \fB\-\fR denotes a range,
\fB[\|\fIc\fB\-\fIc\fB]\fR, unless it is just after the
open bracket or before the closing bracket,
\fB[\|\-\fIc\fB]\fR or \fB[\|\fIc\fB\-]\fR in which
case it has no special meaning.
When used within brackets, the character \fB^\fR
has the meaning \fIcomplement of\fR if it immediately
follows the open bracket (example: \fB[^\fIc\fB]\|\fR);
elsewhere between brackets (example: \fB[\fIc\fB^]\|\fR)
it stands for the ordinary character \fB^\fR.
.LP
The special meaning of the \fB\e\fR operator can be
escaped only by preceding it with another \fB\e\fR\|,
for example \fB\e\e\fR\|.

