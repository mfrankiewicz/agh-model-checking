.\" @(#)bcg_labels.l - VASY and CONVECS teams - 2013/09/09
.TH BCG_LABELS LOCAL "2013/09/09" "(C) INRIA" "CADP MANUAL PAGES"
.fp 4 CB
.lg 0
.SH NAME
bcg_labels \- modify the labels of graphs encoded in the BCG format

.SH SYNOPSIS
.B bcg_labels
[\fIbcg_options\fP]
[\fB-parse\fP | \fB-unparse\fP]
\fIaction1 action2 ...\fP
\fIinput\fP\fB.bcg\fP [\fIoutput\fP\fB.bcg\fP]
.P
where each \fIaction\fP in the list \fIaction1\fP \fIaction2\fP ... is either a "hiding action", defined as:
.P
\fIaction\fP ::= 
.B -hide
[
.B -total
|
.B -partial
|
.B -gate
]
\fIhiding_filename\fP
.P
or a "renaming action", defined as:
.P
\fIaction\fP ::=
.B -rename
[
.B -total
|
.B -single
|
.B -multiple
|
.B -gate
]
\fIrenaming_filename\fP
.P
or a "scrambling action", defined as:
.P
\fIaction\fP ::=
.B -scramble
\fIpattern\fP
.P
There can be as many actions as needed (possibly none) on the command line 
except in the latter case, where the list \fIaction1\fP \fIaction2\fP ...
should contain only one element, meaning that a scrambling action may not be
combined with any other action.

.SH DESCRIPTION
This command modifies the labels of a BCG graph. It takes as input the BCG
graph \fIinput\fP\fB.bcg\fP and writes the resulting graph to
\fIoutput\fP\fB.bcg\fP, replacing \fIinput\fP\fB.bcg\fP if
\fIoutput\fP\fB.bcg\fP is omitted.
.P
This command applies to the labels of \fIinput\fP\fB.bcg\fP, the hiding,
renaming and/or scrambling operations specified by the list of actions given
on the command line. 

.P
These operations are performed in the same order as the actions occur on 
the command-line (the leftmost actions being applied first, and the 
rightmost ones being applied last). For instance, if \fBbcg_labels\fP is 
called with arguments
.BI \-rename \ file1 \ -hide \ file2 ,
renaming will be applied before hiding.
.P
A dynamic library corresponding to \fIinput\fP\fB.bcg\fP may be generated
if necessary.

.SH GENERAL OPTIONS
The following \fIbcg_options\fP are currently supported: 
\fB-version\fP, \fB-create\fP, \fB-update\fP, \fB-remove\fP, \fB-cc\fP, 
\fB-tmp\fP, \fB-uncompress\fP, \fB-compress\fP, \fB-register\fP, \fB-short\fP,
\fB-medium\fP, and \fB-size\fP. See the
.BR bcg (LOCAL)
manual page for a description of these options.

.SH PARTICULAR OPTIONS
The following options are supported:

.TP
\fB \-hide [\-total|\-partial|\-gate]\fP \fIhiding_filename\fP 

Use the hiding rules defined in \fIhiding_filename\fP to hide the labels in
\fIinput\fP\fB.bcg\fP. See the
.BR caesar_hide_1 (LOCAL)
manual page for a detailed description of the appropriate format for
\fIhiding_filename\fP.
.sp
The \fB-total\fP, \fB-partial\fP, and \fB-gate\fP options specify the "total 
matching", "partial matching", and "gate matching" semantics, respectively. 
See the
.BR caesar_hide_1 (LOCAL)
manual page for more details about these semantics. Option
\fB-total\fP is the default.
.P
.TP
\fB \-rename [\-total|\-single|\-multiple|\-gate]\fP \fIrenaming_filename\fP 

Use the renaming rules defined in \fIrenaming_filename\fP to rename the labels
in \fIinput.bcg\fP. See the 
.BR caesar_rename_1 (LOCAL)
manual page for a detailed description of the appropriate format for
\fIrenaming_filename\fP.
.sp
The \fB-total\fP, \fB-single\fP, \fB-multiple\fP, and \fB-gate\fP options 
specify the "total matching", "single partial matching", "multiple partial 
matching", and "gate matching" semantics, respectively. See the
.BR caesar_rename_1 (LOCAL)
manual page for more details about these semantics.  Option
\fB-total\fP is the default.

.TP
\fB \-scramble\fP \fIpattern\fP

Rename each label string (except the hidden label "i", which is kept as is)
so as to remove any information contained in the string; in essence, scrambling
replaces all label strings by unique numbers in the range 1..N, where N is
the number of labels.
.sp
The \fIpattern\fP is a character string to be used as the format argument of
the C function printf(). It should contain exactly one occurrence of "%d".
The scrambling action renames each label string into \fIpattern\fP, the "%d"
of which being replaced by the unique integer that identifies the label. The
\fIpattern\fP should not contain other %-arguments than "%d", such as
"%c", "%f", etc. If needed, the "%" character can be specified as "%%".

.TP
\fB \-parse | \-unparse\fP

Options \fB-parse\fP and \fB-unparse\fP can be used to control label
parsing in \fIoutput\fP\fB.bcg\fP (see the
.BR bcg_write (LOCAL)
manual page for a technical discussion about label parsing).
By default, or if option \fB-parse\fP is present, label parsing is enabled.
If option \fB-unparse\fP is present, label parsing is disabled.

.SH ENVIRONMENT VARIABLES

See the
.BR bcg (LOCAL)
manual page for a description of the environment variables used by all
the BCG application tools.

.SH EXIT STATUS
Exit status is 0 if everything is alright, 1 otherwise.

.SH AUTHORS
Christophe Discours, Hubert Garavel, and Frederic Lang.

.SH OPERANDS
.PD 0
.TP 25
.IB input .bcg
BCG graph (input)
.TP
.IB output .bcg
BCG graph (output)
.TP
.IB input @1.o
dynamic library (input or output)
.TP
.IB hiding_filename
set of hiding rules (input)
.TP
.IB renaming_filename
set of renaming rules (input)
.PD

.SH FILES

.PD 0
.TP 30
.B $CADP/bin.`arch`/bcg_labels
``\fBbcg_labels\fP'' binary program
.PD

.P
See the
.BR bcg (LOCAL)
manual page for a description of the other files.

.SH SEE ALSO
.BR bcg (LOCAL),
.BR caesar_hide_1 (LOCAL),
.BR caesar_rename_1 (LOCAL)

.P
Additional information is available from the CADP Web page located at
http://cadp.inria.fr
.P
Directives for installation are given in files \fB $CADP/INSTALLATION_*\fP.
.P
Recent changes and improvements to this software are reported
and commented in file \fB$CADP/HISTORY\fP.

.SH BUGS

Please report bugs to Hubert.Garavel@inria.fr


