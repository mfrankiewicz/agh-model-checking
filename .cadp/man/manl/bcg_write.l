.\" @(#)bcg_write.l - VASY and CONVECS teams - 2016/06/13
.TH BCG_WRITE LOCAL "2016/06/13" "(C) INRIA" "CADP MANUAL PAGES"
.fp 4 CB
.lg 0
.SH NAME
bcg_write \- a simple interface to produce a BCG graph
.SH DESCRIPTION
This interface generates a BCG graph from an 
application program written in C or C++. To keep things simple, this
interface does not give access to the whole BCG format, but only to a
subset, in which states are assumed to be unsigned integer numbers and
labels of the edges are assumed to be character strings.
Note: this subset of BCG is equivalent to the \fB.aut\fP format
described in the
.BR aldebaran (LOCAL)
manual page, although it is much more compact.
.P
.SH USAGE
The application program should start with the following directive:
.P
\fB   #include "bcg_user.h"\fP
.P
Then the BCG library should be initialized by invoking the 
following function:
.P
\fB   BCG_INIT ();\fP
.P
Not invoking this function might cause a run-time error, e.g.,
a segmentation fault. Invoking \fBBCG_INIT()\fP more than once is harmless,
although not recommended.

.SH DATA TYPES
The functions of this interface use the followings types, whose definitions
are provided by the "bcg_user.h" file:
.IP -
\fBBCG_TYPE_BOOLEAN\fP
.IP -
\fBBCG_TYPE_NATURAL\fP
.IP -
\fBBCG_TYPE_C_STRING\fP
.IP -
\fBBCG_TYPE_FILE_NAME\fP
.IP -
\fBBCG_TYPE_LABEL_STRING\fP
.IP -
\fBBCG_TYPE_STATE_NUMBER\fP
.IP -
\fBBCG_TYPE_DATA_FORMAT\fP

.SH FEATURES
.P
 ............................................................
.P
.SS \fBBCG_IO_WRITE_BCG_BEGIN\fP
 \&
.nf
\fB BCG_TYPE_BOOLEAN BCG_IO_WRITE_BCG_BEGIN (\fP\fIfilename\fP\fB, 
              \fP\fIinitial_state\fP\fB, \fP\fIformat\fP\fB, \fP\fIcomment\fP\fB, \fP\fImonitor\fP\fB)\fP
\fB
  BCG_TYPE_FILE_NAME                    \fP\fIfilename\fP\fB;
  BCG_TYPE_STATE_NUMBER                 \fP\fIinitial_state\fP\fB;
  BCG_TYPE_NATURAL                      \fP\fIformat\fP\fB;
  BCG_TYPE_C_STRING                     \fP\fIcomment\fP\fB;
  BCG_TYPE_BOOLEAN                      \fP\fImonitor\fP\fB;
  { ... }
\fP
.fi
This function opens a BCG file. Its arguments have the following meaning:
.TP
.I filename
is a character string containing the path name
of the BCG file to be written. It should contain the  "\fB.bcg\fP" suffix
(if the "\fB.bcg\fP" suffix is missing, it will be added automatically).
.TP
.I initial_state
is the number of the initial state (usually 0).
.TP
.I format
is equal to 2 if, in the forthcoming successive invocations of function
\fBBCG_IO_WRITE_BCG_EDGE()\fP, the sequence of actual values given to the
\fIstate1\fP argument of \fBBCG_IO_WRITE_BCG_EDGE()\fP will increase
monotonically or equal to 1 otherwise. The format 1 applies in
general but is less efficient in terms of time or BCG file compression.
The format 2 is more efficient but only applies to specific situations
(in particular, when the BCG graph is generated in a breadth-first search).
.TP
.I comment
is a character string containing information about the
application tool which is creating the BCG graph. If \fIcomment\fP
is equal to NULL, then it will be replaced with a default string.
.TP
.I monitor
should be equal to \fBBCG_TRUE\fP if a Tcl/Tk window should be opened 
for monitoring in real-time the generation of the BCG graph
or equal to \fBBCG_FALSE\fP otherwise.
.P
By default, if \fIfilename\fP cannot be opened for writing,
\fBBCG_IO_WRITE_BCG_BEGIN()\fP will emit an error message and exit the
program. However, if the following function call:
.P
\fB    BCG_IO_WRITE_BCG_SURVIVE (BCG_TRUE);\fP
.P
has occured before the call to \fBBCG_IO_WRITE_BCG_BEGIN()\fP,
then \fBBCG_IO_WRITE_BCG_BEGIN()\fP will neither emit an error message
nor exit the program, but return normally a boolean result that is
equal to \fBBCG_TRUE\fP if and only if \fIfilename\fP cannot be opened.
.P
Below, we assume that the \fBBCG_IO_WRITE_BCG_BEGIN()\fP function
has returned successfully.
.P
 ............................................................
.P
.SS \fBBCG_IO_WRITE_BCG_SURVIVE\fP
 \&
.nf
\fB BCG_IO_WRITE_BCG_SURVIVE (\fP\fImode\fP\fB)\fP
\fB
  BCG_TYPE_BOOLEAN \fP\fImode\fP\fB;
  { ... }
\fP
.fi
This function controls how the \fBBCG_IO_WRITE_BCG_BEGIN()\fP function defined
above will behave if the BCG file cannot be opened for writing:
.IP -
If \fImode\fP equals \fBBCG_FALSE\fP, then \fBBCG_IO_WRITE_BCG_BEGIN()\fP
will emit an error message and exit the program. This is the default 
behaviour.
.IP -
If \fImode\fP equals \fBBCG_TRUE\fP, then \fBBCG_IO_WRITE_BCG_BEGIN()\fP
will neither emit an error message nor exit the program, but return a 
boolean result. The default behaviour can be restored by calling:
.P
\fB    BCG_IO_WRITE_BCG_SURVIVE (BCG_FALSE);\fP
.P
 ............................................................
.P
.SS \fBBCG_IO_WRITE_BCG_EDGE\fP
 \&
.nf
\fB BCG_IO_WRITE_BCG_EDGE (\fP\fIstate1\fP\fB, \fP\fIlabel\fP\fB, \fP\fIstate2\fP\fB)\fP
\fB
  BCG_TYPE_STATE_NUMBER \fP\fIstate1\fP\fB;
  BCG_TYPE_LABEL_STRING \fP\fIlabel\fP\fB;
  BCG_TYPE_STATE_NUMBER \fP\fIstate2\fP\fB;
  { ... }
\fP
.fi
This function must be invoked once for each edge to be created in the BCG 
graph.  It writes in the previously opened BCG file an edge such that
\fIstate1\fP is the number of the origin state,
\fIstate2\fP is the number of the destination state, and
\fIlabel\fP is a character string containing the label.
.P
Note: \fIlabel\fP should not contain the characters newline (\fB'\en'\fP)
or carriage return (\fB'\er'\fP).
.P
Note: the invisible (also known as hidden, or tau) label is represented by 
the character string \fB"i"\fP (as it is the case in LOTOS).
.P
 ............................................................
.P
.SS \fBBCG_IO_WRITE_BCG_PARSING\fP
 \&
.nf
\fB BCG_IO_WRITE_BCG_PARSING (\fP\fIdata_format\fP\fB)\fP
\fB
  BCG_TYPE_DATA_FORMAT \fP\fIdata_format\fP\fB;
  { ... }
\fP
.fi
This function can be (optionally) invoked to modify the way labels are parsed.
For details about label parsing, see the 
.BR "LABEL PARSING"
section below.
.P
Calling \fBBCG_IO_WRITE_BCG_PARSING()\fP with \fIdata_format\fP equal to the
constant value \fBBCG_UNPARSED_DATA_FORMAT\fP disables the parsing of labels.
.P
Calling \fBBCG_IO_WRITE_BCG_PARSING()\fP with \fIdata_format\fP equal to the
constant value \fBBCG_STANDARD_DATA_FORMAT\fP enables the parsing of labels.
.P
By default (i.e., if \fBBCG_IO_WRITE_BCG_PARSING()\fP is not invoked), label
parsing is enabled. In order to improve inter-operability between tools, we
recommend to leave label parsing enabled.
.P
The call to \fBBCG_IO_WRITE_BCG_PARSING()\fP must be done after invoking
\fBBCG_INIT()\fP and before invoking \fBBCG_IO_WRITE_BCG_BEGIN()\fP. 
.P
 ............................................................
.P
.SS \fBBCG_IO_WRITE_BCG_END\fP
 \&
.nf
\fB BCG_IO_WRITE_BCG_END ()\fP
\fB
  { ... }
\fP
.fi
This function properly closes the BCG file.
.P
 ............................................................
.P
.SS \fBBCG_IO_WRITE_BCG_ABORT\fP
 \&
.nf
\fB BCG_IO_WRITE_BCG_ABORT ()\fP
\fB
  { ... }
\fP
.fi
This function stops the generation of the BCG file, and removes this file.
This function should be invoked in case of a fatal error, so as not to 
leave an unfinished, invalid BCG file.
.P
 ............................................................
.ne 15v
.SH EXAMPLE
The following piece of C code creates a BCG graph with an initial state
numbered 0:
.nf
#include "bcg_user.h"
int main ()
{
   BCG_TYPE_STATE_NUMBER S1;
   BCG_TYPE_LABEL_STRING L;
   BCG_TYPE_STATE_NUMBER S2;

   BCG_INIT ();
   BCG_IO_WRITE_BCG_BEGIN ("test.bcg", 0, 2, "created by tool", 1);
   /* for each transition labelled with L from state S1 to state S2 */
   {
      BCG_IO_WRITE_BCG_EDGE (S1, L, S2);
   }
   BCG_IO_WRITE_BCG_END ();
   return (0);
}
.fi

.SH LABEL PARSING

The \fIlabel\fP argument passed to the \fBBCG_IO_WRITE_BCG_EDGE()\fP function
is a character string that should only contain printable characters; the
meaning of "printable" is given by the POSIX isprint() function with locale
"C" (namely, ASCII characters with decimal codes in the range from 32 to 126, 
bounds included). Otherwise, the effect is undefined. In particular, a label
string should not be terminated with line-feed and/or carriage-return
characters. Wide characters (e.g., UTF-8, UTF-16, etc.) are not supported
because their usefulness for concurrency theory may not be worth their
complexity.

.P
The \fIlabel\fP arguments can be interpreted in two different ways, depending
whether label parsing is enabled or not.

.P
If label parsing is disabled, each label is stored in the generated BCG file 
as a 1-tuple (L) whose unique field L is exactly the character string passed
to \fBBCG_IO_WRITE_EDGE()\fP. In the generated BCG file, this unique field
has the RAW type (see the FIELD PARSING section below for information about
this type).

.P
Note: In legacy BCG files generated by CADP versions up to 2014-h included,
this unique field had the STRING type; this situation is detected by more
recent versions of CADP, which automatically convert that field to the RAW
type to ensure backward compatibility.

.P
The remainder of this section discusses the case where label parsing is
enabled. 

.P
In such case, each label string is assumed to a notation for a 
tuple of typed data values (V0, V1, ..., V\fIn\fP) called \fIfields\fP. 
The number \fIn\fP is not necessarily the same for all labels, meaning that
each label can have its own number of fields.

.P
Therefore, function \fBBCG_IO_WRITE_BCG_EDGE()\fP will attempt at parsing
its \fIlabel\fP argument to cut it into a sequence of fields, and analyze
each field to infer its type and extract its value. In the resulting BCG
file, labels will be represented as tuple of field values.

.P
Parsing labels is not mandatory, but it is recommended, because it enables 
certain model checkers of CADP, namely
.BR evaluator4 (LOCAL)
and
.BR xtl (LOCAL)
to know about the types present in labels and to use field values to
express powerful temporal logic properties.

.P
There are other CADP tools that treat labels as mere character strings,
and do not attempt at considering fields individually. For such tools, label
parsing can still be enabled, as it is (almost) transparent: each label string
is parsed and stored in the BCG file as a tuple of binary fields; this tuple
can later be converted back into a label string by those tools that do 
not examine fields. Notice, however, that this latter label string can be
slightly different from the former one, because of various \fInormalization\fP
actions that will be described below.

.P
As a tribute to tradition, parsed labels are not noted as mathematical tuples:
\fB"(V0, V1, V2, ..., Vn)"\fP, but use the notation for labels established by
the CSP and LOTOS process algebras: \fB"V0 !V1 !V2 !... !Vn"\fP. If there is
only one field, the label is noted \fB"V0"\fP.

.P
It is recommended to leave one space before the '\fB!\fP' character and
no space after. Labels that do not follow this convention will still be
parsed properly, but will be normalized under the recommended form if 
converted back to character strings.

.P
Rules for label parsing continue with the next section, which specifically
discusses the parsing of label fields.

.SH FIELD PARSING

.P
Fields can be of eight possible types: GATE, BOOLEAN, NATURAL, INTEGER, REAL, 
CHARACTER, STRING, and RAW.

.P
Note: BCG files generated with versions 1.0 or 1.1 of the BCG format (namely, 
before September 2014) had only six of these types. The NATURAL and RAW types 
were not defined; these files did not contain any value of the CHARACTER
type, and their STRING type behaved as the current RAW type.

.P
For some of these eight types, there can be multiple field notations that
lead to the same value. For instance, the two different fields \fB"1"\fP
and \fB"01"\fP express the same number. Normalization also applies to fields
and puts them under canonical textual representation.

.P
The rules for parsing fields are applied in the following order:

.IP (1)
If the first field V0 of a label starts with a letter that is followed by 
any number of letters, digits, and/or underscore characters, then it is 
recognized and inserted in the BCG file as a value of the GATE type. This type
is an enumerated type that gathers all the gate identifiers contained in
the labels of the graph. For each gate identifier, a corresponding constant
function of type GATE is inserted in the BCG file.
The precise rules for translating fields denoting GATE values into
binary values stored in memory, and vice versa, are given by two
functions \fBbcg_gate_scan()\fP and \fBbcg_gate_print()\fP defined
in file \fB$CADP/incl/adt_gate.h\fP.

.IP (2)
If a field is equal to "\fBTRUE\fP" or "\fBFALSE\fP" (or to their
case-insensitive variants "\fBtrue\fP", "\fBfalse\fP", "\fBTrue\fP",
"\fBFalse\fP", etc.), then it is recognized and inserted in the BCG file
as a value of the BOOLEAN type. 
The precise rules for translating fields denoting BOOLEAN values into
binary values stored in memory, and vice versa, are given by two
functions \fBbcg_boolean_scan()\fP and \fBbcg_boolean_print()\fP defined
in file \fB$CADP/incl/adt_boolean.h\fP.
Normalization converts BOOLEAN values to upper-case letters, either
"\fBTRUE\fP" or "\fBFALSE\fP".

.IP (3)
If a field denotes an unsigned integer number (e.g., \fB0\fP, \fB1\fP, 
\fB9999\fP, etc.), then it is recognized and inserted in the BCG file
as a value of the NATURAL type. The syntax of NATURAL fields is
the one accepted by the POSIX function
.BR strtoul (3).
The number must not be prefixed with a '\fB+\fP' sign. At present, only
32-bit unsigned integers are recognized as values of the NATURAL type;
larger numbers will be considered as values of the REAL type.
The precise rules for translating fields denoting NATURAL values into
binary values stored in memory, and vice versa, are given by two
functions \fBbcg_natural_scan()\fP and \fBbcg_natural_print()\fP defined
in file \fB$CADP/incl/adt_natural.h\fP.
Normalization removes leading zeros in NATURAL values.

.IP (4)
If a field denotes a signed integer number (e.g., \fP-9999\fP, \fB+0\fP, 
\fB+1\fP, \fB+9999\fP, etc.), then it is recognized and inserted in the BCG 
file as a value of the INTEGER type. The syntax of INTEGER fields
is the one accepted by the POSIX function
.BR strtol (3).
The number (even if it is zero) must be prefixed with either a '\fB+\fP'
or '\fB-\fP' sign. At present, only 32-bit signed integers are recognized as 
values of the INTEGER type; smaller or larger numbers will be considered
as values of the REAL type.
The precise rules for translating fields denoting INTEGER values into
binary values stored in memory, and vice versa, are given by two
functions \fBbcg_integer_scan()\fP and \fBbcg_integer_print()\fP defined
in file \fB$CADP/incl/adt_integer.h\fP.
Normalization removes leading zeros in INTEGER values.

.IP (5)
If a field denotes a floating-point number (e.g., \fB3.1415\fP, \fB-1.2E+10\fP,
etc.), then it is recognized and inserted in the BCG file as a value of the
REAL type. The syntax of REAL fields is the one accepted by the POSIX
function
.BR strtod (3).
The precise rules for translating fields denoting REAL values into
binary values stored in memory, and vice versa, are given by two
functions \fBbcg_real_scan()\fP and \fBbcg_real_print()\fP defined
in file \fB$CADP/incl/adt_real.h\fP.
Normalization removes leading zeros and may add trailing zeros to REAL values.

.IP (6)
If a field denotes a character value (e.g., \fB'a'\fP, \fB'\\012'\fP, \fB'\\x0A'\fP, \fB'\\n'\fP,
etc.), then it is recognized and inserted in the
BCG file as a value of the CHARACTER type. The syntax of CHARACTER fields is
a simplified subset of the C language syntax: characters are enclosed between
single quotes; any printable character \fIc\fP different from the single quote
and backslash characters can be used to form a value '\fIc\fP'; the octal 
notation '\\\fIooo\fP' (where \fIooo\fP denotes exactly three octal digits)
and the hexadecimal notation '\\x\fIhh\fP' (where \fIhh\fP denotes exactly
two hexadecimal digits) are supported; the standard C notations \fB'\\0'\fP, \fB'\\a'\fP, \fB'\\b'\fP, \fB'\\f'\fP, \fB'\\n'\fP, \fB'\\r'\fP, \fB'\\t'\fP, \fB'\\v'\fP, \fB'\\"'\fP, \fB'\\\\'\fP, \fB'\\''\fP and \fB'\\?'\fP
are also supported; notice that the single quote and backslash characters
must be always be escaped with a backslash, whereas the double quote and 
interrogation mark characters may be escaped or not, e.g., \fB'"'\fP or \fB'\\"'\fP.
The precise rules for translating fields denoting CHARACTER values into
binary values stored in memory, and vice versa, are given by two
functions \fBbcg_character_scan()\fP and \fBbcg_character_print()\fP defined
in file \fB$CADP/incl/adt_character.h\fP.
Normalization converts any unprintable CHARACTER value (the
meaning  of "printable" being given  by the POSIX isprint() function with
locale "C") into three-digit octal notation; printable CHARACTER values are
displayed as such; for instance, \fB'\\n'\fP and \fB'\\x23'\fP are normalized
as \fB'\\012'\fP and \fB'#'\fP, respectively.

.IP (7)
If a field denotes a string value (e.g., \fB""\fP, \fB"a\\012\\x04\\n"\fP, 
etc.), then it is recognized and inserted in the BCG file as a value of the 
STRING type. The syntax of STRING fields is a subset of that of the C 
language: characters are enclosed between double quotes and follow the
same notations as for the CHARACTER type. The only two differences are the
following: single quotes (which are always escaped in characters) can be
escaped or not in strings, while double quotes (which can be escaped or not
in characters) must be escaped in strings. 
The precise rules for translating fields denoting STRING values into
binary values stored in memory, and vice versa, are given by two
functions \fBbcg_string_scan()\fP and \fBbcg_string_print()\fP defined
in file \fB$CADP/incl/adt_string.h\fP.
Normalization follows the same rules as for the CHARACTER type. If a null
character (noted '\fB\\0\fP', '\fB\\000\fP', or '\fB\\x00\fP') occurs in the
middle of a field, the remaining characters of this field will be ignored.

.IP (8)
If a field does not match any of the rules above (e.g., \fBx+y\fP, 
\fBcons (1, nil)\fP, etc.), then it is considered as "raw data" and inserted 
in the BCG file as a value of the RAW type. This type gathers all values whose
type cannot be determined easily. In particular, any empty field is considered
as a value of type RAW. A field of type RAW may also contain "embedded"
character and string values (e.g., \fBpair ("name", 'k', 28)\fP, etc.).
Characters in RAW fields follow the same notations as for the CHARACTER type. 
The '\fB!\fP' character, which usually signals the end of the current field
and the beginning of a new field, may occur in a RAW field provided that it 
is escaped (i.e., noted '\fB\\!\fP', '\fB\\041\fP', or '\fB\\x21\fP'); 
however, this character does not need to be escaped if it occurs in an
embedded character or an embedded string. Values of the RAW type are stored 
in memory as byte strings.
The precise rules for translating fields denoting RAW values into
binary values stored in memory, and vice versa, are given by two
functions \fBbcg_raw_scan()\fP and \fBbcg_raw_print()\fP defined
in file \fB$CADP/incl/adt_raw.h\fP.

.P
To summarize the effects of label parsing and normalization on one example, 
the following label string \fB"   G!  true ! 003!+01E+0   "\fP passed to 
function \fBBCG_IO_WRITE_BCG_EDGE()\fP will be stored in the BCG file as a
tuple (G, TRUE, 3, 1.0). If converted back to a character string, it will
display as "G !TRUE !3 !1.000000".

.SH COMPILING AND LINK EDITING

To compile the application tool, the following options must be passed
to the C or C++ compiler:
.P
.B   -I$CADP/incl -L$CADP/bin.`$CADP/com/arch` -lBCG_IO -lBCG -lm
.P
as in, e.g.,
.P
.nf
     $CADP/src/com/cadp_cc tool.c -o tool -I$CADP/incl \\
     -L$CADP/bin.`$CADP/com/arch` -lBCG_IO -lBCG -lm
.fi

.SH EXIT STATUS
Application tools share common conventions with respect to
diagnostics.  Exit status is 0 if everything is alright, 1 otherwise.

.SH AUTHORS
Hubert Garavel (definition of the BCG format) and Renaud Ruffiot
(implementation of the BCG environment).

.SH FILES
See the
.BR bcg (LOCAL)
manual page for a description of the files.

.SH SEE ALSO
.BR bcg (LOCAL)
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
Please report bugs to Hubert.Garavel@inria.fr

