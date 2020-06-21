.\" @(#)aut.l - VASY and CONVECS teams - 2016/04/02
.TH AUT LOCAL "2016/04/02" "(C) INRIA" "CADP MANUAL PAGES"
.fp 4 CB
.lg 0
.SH NAME
aut, AUT \- simple file format for labelled transition systems

.SH DESCRIPTION

The AUT format (where \fIAUT\fP stands for \fIAUTomaton\fP), also called
the ALDEBARAN format, is a simple file format for representing labelled
transition systems.

.P
The AUT format has been present in the CADP toolbox since its origins (see
the HISTORY section below for details about the chronology of the AUT format).

.P
Because of its simplicity and because it is human readable, this format has
enjoyed some popularity in academia among developers of verification and 
testing tools.

.P
However, the AUT format suffers from three drawbacks: 
.IP -
Because it is a text format, it is not compact enough to efficiently store
very large transitions systems (both in terms of disk space and access time).
.IP -
Because the AUT format definition was kept as simple as possible, the various 
implementations would often diverge, for instance, regarding the maximal
length for label strings, the places where white spaces are allowed, etc.
.IP -
There was a lot of redundant work across these implementations, as each 
developer would have to implement the same functionalities, e.g., to store
labels and transitions in main memory.

.P
To address these issues (and others), the CADP toolbox has been, since 1993,
equipped with an alternative file format named BCG (see the
.BR bcg (LOCAL)
manual page for details). Progressively, the BCG format has supplanted the
AUT format in CADP, and most of the CADP tools nowadays that can read or write
the AUT format do it by internal translation from/to BCG. 

.P
Thus, it is advised to use the BCG format rather than the AUT format when 
developing new tools. The only exception to this general principle concerns
those tools developed using a programming language that can not bridge with
the BCG code libraries provided by the CADP toolbox.

.SH "SPECIFICATION OF THE A\&U\&T FORMAT (2014 VERSION)"

Labelled transition systems encoded in the AUT format are stored in files 
having the \fB.aut\fP suffix. 

.P
In an AUT file, each state is represented by a natural (i.e., unsigned) number.

.P
Blanks (i.e., white spaces, tabulations, etc.) may appear everywhere
between lexical tokens (i.e., keywords, numbers, strings, commas,
parentheses, etc.), and also at the beginning or end of each line.
Blanks are not significant and can be discarded, except inside quoted labels.

.P
Line breaks are significant. Each line should be terminated with a line-feed
(LF) character, with the possible exception of the last line of the file.
To ensure compatibility with Windows, each line-feed character may be 
preceded (or not) by a carriage-return (CR) character.

.P
The numbers of states and transitions should be at least 32-bit wide, which 
enables 4 billions of states and transitions. On 64-bit machines, wider numbers
can be used, but the size of AUT files is likely to become prohibitive for 
large models (in such case, the BCG format is the option of choice).

.P
In the AUT format, only 7-bit ASCII characters are accepted. This is 
currently found to be sufficient for the study of concurrent systems.

.P
The first line of an AUT file has the following syntax:
.nf
   des (<initial-state>, <number-of-transitions>, <number-of-states>)
.fi
The "\fBdes\fP" keywords stands for "descriptor". 
The \fB<number-of-states>\fP must be greater or equal to 1, because there
is always at least one state, the initial state.
State numbers range between 0 and \fB<number-of-states> - 1\fP.
The \fB<initial-state>\fP is always equal to 0.

.P
The remainder of the AUT file consists of one line per transition, in an
arbitrary order. Each remaining line has the following syntax:
.nf
   (<from-state>, <label>, <to-state>)
.fi
where \fB<from-state>\fP and \fB<to-state>\fP are state numbers, and where
<label> can take two possible forms:

.IP -
\fB<unquoted-label>\fP consists of a character string starting with a letter,
and followed by zero, one, or many letters, digits, or underscore characters.
To ensure backward compatibility with the version of AUT format used by the
.BR tgv (LOCAL)
tool, the character string consisting of a single '\fB*\fP' character is also
accepted as a valid unquoted label.

.IP -
\fB<quoted-label>\fP consists of a character string starting with a double
quote and ending with a double quote. Between these two double quotes, there
can be zero, one or many printable characters; the meaning of "printable" is
given by the POSIX isprint() function with locale "C" (namely, ASCII characters
with decimal codes in the range from 32 to 126, bounds included).
No other assumption should be made about the characters present between 
these two double quotes. In particular, the double quote character itself may
be present, and may not necessarily be "escaped" in some way (e.g., preceded
by a backslash, as in C).

.P 
Any conformant implementation of the AUT format should at least handle labels
that are 5000-character long; handling labels of unbounded length is obviously
better.

.P
An unquoted label (e.g., \fBPUT_1\fP) can also be written as a quoted label
(e.g., \fB"PUT_1"\fP) without changing its meaning: both labels should be
considered to be identical. This rule also applies to the '\fB*\fP' label.

.P
The non-observable label (also called invisible label, or hidden label, and
usually noted "tau" in concurrency theory) is noted \fBi\fP in the AUT format,
following a convention set by the ISO International Standard 8807 "LOTOS".
This same label can also be noted \fB"i"\fP, but the unquoted notation is
better for compactness. Notice that there is no way to express an observable
label that would be noted \fBi\fP; this is not a problem for languages such
as LOTOS and LNT, in which \fBi\fP is a reserved keyword or a reserved gate
identifier.

.P
By default, labels are case sensitive, meaning that two labels such as 
\fB"put"\fP and \fB"PUT"\fP should be considered to be different. 

.P
If each label can semantically be seen as a tuple consisting of a communication
port (or gate, channel, etc.) followed by zero, one, or many typed values,
then it is recommended (although not mandatory) to write labels according to
the syntax conventions defined in the LABEL PARSING section of the
.BR bcg_write (LOCAL)
manual page, and to enable label parsing when processing the AUT file using
the CADP tools.

.P
When label parsing is enabled, two labels may be considered to be the same
even if they are not character-wise identical. For instance, label 
\fB"PUT!false!'\\x23'"\fP will be turned into \fB"PUT !FALSE !'#'"\fP by label
parsing, and both labels will be considered to be the same.

.SH EXAMPLE OF AN A\&U\&T FILE

This is an example of a valid AUT file:

.nf
   des (0, 5, 4)
   (0, PUT_6, 1)
   (0, "GET !true !7 !CONS (A, CONS (B, NIL))", 2)
   (1, i, 3)
   (2, "SEND !"hello" !"world"", 3)
   (3, "DUMP ... " ... \\" ...", 0)
.fi

The two latter transitions illustrate that no particular assumption should be 
made about occurrences of double quotes in labels: neither must they be 
systematically preceded by a backslash, nor must they occur an even number
of times, etc.

.SH HOW TO CREATE AN A\&U\&T FILE

At present, there are two CADP tools that directly create AUT files:
.BR caesar (LOCAL)
when invoked with its \fB-aldebaran\fP option, and
.BR bcg_io (LOCAL).

.P
The easiest way to produce an AUT file is to first create a BCG file
using the
.BR bcg_write (LOCAL)
application programming interface, and then invoke the
.BR bcg_io (LOCAL)
tool to convert this BCG file into an AUT file.

.P
Otherwise, it is easy to produce AUT files directly by writing lines to a file.
The only issue may be to produce the descriptor line if the total numbers of 
states and/or transitions are not already known at the moment the AUT file is
created. To solve this issue,
.BR caesar (LOCAL)
writes a first line of the following form:
.nf
   des (0, ?, ?)_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _
.fi
where the _'s denote a sufficient number of white spaces, and then proceeds 
normally writing the subsequent lines corresponding to the transitions. When
all transitions have been written, the numbers of states and transitions should
be known. One can then skip back to the beginning of the file, e.g., using the
ftell() POSIX primitive, and overwrite the first line with the actual numbers.

.P
When an AUT file is generated directly, its correctness can be checked by 
converting it to a BCG file, then back to an AUT file using the
.BR bcg_io (LOCAL)
tool. If the former AUT file is correct, the conversion should succeed. If 
label parsing is disabled during the conversion, both AUT files should be 
character-wise identical (with the possible exception of blanks that might
have been inserted  or removed outside labels). If label parsing is enabled,
the conversion will additionally parse the contents of each label, check its
correctness, and possibly turn some values into their normal form. 

.SH HOW TO READ AN A\&U\&T FILE

At present, there is one single CADP tool,
.BR bcg_io (LOCAL),
that directly reads AUT files. This is a design decision to stop maintaining
multiple parsers.
.BR bcg_io (LOCAL)
is the reference parser for the AUT format. It has command-line options to
enable or disable label parsing.

.P
The easiest way to read an AUT file is to first convert it to BCG using
the
.BR bcg_io (LOCAL)
tool, and then opening the resulting BCG file using the
.BR bcg_read (LOCAL)
application programming interface, which provides primitives and data
structures for loading and accessing the labelled transition system in memory.

.P
Otherwise, it is always possible to write a new parser for the AUT format.
The simplest approach is to write it manually. There is yet an involved
point: when reading an AUT file, quoted labels should not be parsed
from left to right, as it is not possible, upon occurrence of a double quote
character, to immediately decide whether this character marks the end of the
label, or if it is just a double quote present in the middle of the label
(technically, this is a shift-reduce conflict in the grammar). 

.P
The recommended way of parsing quoted labels is to read the entire transition
line in a buffer and search for the leftmost and rightmost double quotes, e.g.,
using the POSIX functions strchr() and strrchr(). The quoted label is the 
sub-string of characters located between these two double quotes.

.P
As an alternative to manual writing, a parser generator may be used, but one
should keep in mind that the AUT format cannot be simply parsed from left to
right because double quotes are allowed inside labels. Using a parser
generator will only work if the generated parser can perform lookahead and
take decisions based upon the right-hand context to resolve shift-reduce
conflicts. If so, the double quote that terminates a label can be
characterized as any double quote that is followed by no other double quote
before the end of line.

.SH HISTORY OF THE A\&U\&T FORMAT

An early version of the AUT format was defined in 1987, as part of the 
VENUS tool [Sor87] for the verification of communicating systems. Because
this tool was written in Prolog, the file format for describing automata 
was naturally a set of Prolog clauses. For instance, the transition relation
of a given automaton \fIA\fP was described as a set of clauses of the form:
\fIA\fP (\fIstate1\fP, \fIlabel\fP, \fIstate2\fP).

.P
The actual AUT format was defined in 1988, as part of the ALDEBARAN tool
[Fer88] for the verification of communicating processes. The Prolog-clause
style of the VENUS format was kept (for instance, on the first line),
sometimes with simplifications (for instance, the automaton name \fIA\fP was
dropped from each transition clause).

.P
In 1989, Hubert Garavel extended the syntax with labels between double quotes,
so as to provide support for the labelled transition systems generated from 
value-passing LOTOS specifications.

.P
The AUT format remained unchanged until September 2014, when Hubert Garavel
introduced the explicit possibility of having double quotes in labels, so
as to support concurrent modelling languages with rich data types, in
particular the LNT and PseuCo languages that can pass character string values
across communication channels. The specification of the AUT format was revised
and made more precise.

.SH BIBLIOGRAPHY

[Sor87] Amelia Soriano Montes. Venus: un outil d'aide a la verification
des systemes communicants. These de doctorat, Institut National Polytechnique
de Grenoble, Jan. 1987.

.P
[Fer88] Jean-Claude Fernandez. Aldebaran : un systeme de verification par
reduction de processus communicants. These de doctorat, Universite Joseph 
Fourier (Grenoble I), May 1988.

.SH SEE ALSO
.BR aldebaran (LOCAL),
.BR bcg (LOCAL),
.BR bcg_io (LOCAL),
.BR bcg_write (LOCAL).

.P
Additional information is available from the CADP Web page located at
http://cadp.inria.fr
.P
Directives for installation are given in files \fB$CADP/INSTALLATION_*\fP.
.P
Recent changes and improvements to this software are reported
and commented in file \fB$CADP/HISTORY\fP.
.SH BUGS
Please report bugs to cadp@inria.fr


