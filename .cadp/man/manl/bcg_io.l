'\" t
.\" @(#)bcg_io.l - VASY and CONVECS teams - 2019/01/09
.TH BCG_IO LOCAL "2019/01/09" "(C) INRIA" "CADP MANUAL PAGES"
.fp 4 CB
.lg 0
.SH NAME
bcg_io \- convert graphs from and into the BCG format

.SH SYNOPSIS

.B bcg_io
[ \fIbcg_options_1\fP ]
[ \fIinput_options\fP ]
\fIinput_filename\fP 
[ \fIbcg_options_2\fP ]
[ \fIoutput_options\fP ]
\fIoutput_filename\fP

.SH DESCRIPTION

This command takes as input a graph contained in \fIinput_filename\fP
and generates as output a graph in \fIoutput_filename\fP. This command
is mostly used to perform format conversion, in the case where
\fIinput_filename\fP and \fIoutput_filename\fP are not encoded in the
same graph formats.
.P
The following ``input formats'' are currently implemented and
available for \fIinput_filename\fP:
.P
.TS
L L.
- BCG	Binary Coded Graphs format
- AUT	ALDEBARAN graph format
- FC2	ESPRIT project CONCUR2 format (INRIA, Sophia)
- SEQ	CADP common trace format
.TE
.P
The following ``output formats'' are currently implemented and available 
for \fIoutput_filename\fP:
.P
.TS
L L.
- BCG	Binary Coded Graphs format
- ASCII	ASCII dump of the BCG format
- AUT	ALDEBARAN graph format
- AUTO	AUTO and MEIJE graph format (INRIA, Sophia)
- CWB	Concurrency Workbench (LFCS, Edinburgh)
- ETMCC	Erlangen-Twente Markov Chain Checker 
- FC2	ESPRIT project CONCUR2 format (INRIA, Sophia)
- GML	Graph Modelling Language (Univ. Passau)
- GRAPHVIZ	DOT format of the GRAPHVIZ tools (ATT)
- LOTOS	pseudo-LOTOS format
- MEC	MEC graph format (LaBRI, Bordeaux)
- PIPN	PIPN graph format (LAAS, Toulouse)
- SCAN	SCAN format (BULL)
- SEQ	CADP common trace format
- SQUIGGLES	SQUIGGLES graph format (CNUCE, Pisa)
- VCG	Vizualization of Compiler Graphs (Univ. Saarlandes)
- VISCOPE	VISCOPE graph format (IRISA, Rennes)
- XESAR	XESAR graph format (LGI-IMAG, Grenoble)
.TE
.P
Conversions are allowed from any input format into any output format.
.P
When converting from the BCG format into a non-BCG output format,
the dynamic library corresponding to \fIinput_filename\fP may be
generated if necessary.
.P
When converting a non-BCG input format into a non-BCG output format, 
a BCG graph and its dynamic library may be generated as intermediate 
forms. This is normally transparent to the end-user.
.P
Conversion from an input format to itself are allowed, but are useless
except in the case of the BCG format: compression parameters (see below)
can be modified this way.

.SH GENERAL OPTIONS

Two groups of general options, \fIbcg_options_1\fP and \fIbcg_options_2\fP,
are currently supported.
.P
Options \fIbcg_options_1\fP can appear at the beginning of the 
command-line. These options are: \fB-version\fP, \fB-create\fP, 
\fB-update\fP, \fB-remove\fP, \fB-cc\fP, \fB-tmp\fP.
.P
Options \fIbcg_options_2\fP can appear on the command-line after 
\fIinput_filename\fP. These options are: \fB-uncompress\fP, \fB-compress\fP, 
\fB-register\fP, \fB-short\fP, \fB-medium\fP, and \fB-size\fP.
.P
See the
.BR bcg (LOCAL)
manual page for a description of these options.

.SH PARTICULAR OPTIONS

\fBbcg_io\fP is very flexible with respect to options and file suffixes
(i.e., file extensions). Options or file suffixes can be omitted, provided
that there is no ambiguity. \fBbcg_io\fP does its best to guess the user's 
intentions and automatically supplies the missing options and suffixes.
.P
An option can be omitted iff the file suffix is present and, reciprocally, 
a file suffix can be omitted iff the option is present.
.P
If \fIinput_file\fP is equal to ``-'', then it is considered to be the
standard input. In such case, the option must be present.
.P
If \fIoutput_file\fP is equal to ``-'', then it is considered to be the
standard output. In such case, the option must be present. 
.P
Note: if the output option ``-'' is given for producing the BCG, FC2, or
XESAR formats, the standard output of the \fBbcg_io\fP should be a regular 
file (not a pipe), because these formats require either that an explicit 
output file name is given (XESAR), or that the file can be accessed randomly
using the
.BR lseek (2)
system call (BCG and FC2).
.P
For example, the conversion of an AUT file into a FC2 file is normally
done as follows:
.PD 0
.P
.BI "   bcg_io -aldebaran" \ input_file .aut\ -fc2 \ output_file .fc2
.P
but equivalent synopses are allowed, such as:
.P
.BI "   bcg_io -aldebaran" \ input_file \ -fc2 \ output_file
.P
or:
.P
.BI "   bcg_io" \ input_file .aut \ output_file .fc2
.P
or (assuming that \fIoutput_file\fP\fB.fc2\fP is a regular file):
.P
.BI " bcg_io -aldebaran - -fc2 - <" input_file .aut\ > output_file .fc2
.PD
.P
If \fIoutput_file\fP is omitted and has only its suffix mentioned,
it is assumed to be equal to \fIinputfile\fP. For example:
.PD 0
.P
.BI "   bcg_io " filename .aut\ .fc2
.P
is equivalent to:
.P
.BI "   bcg_io " filename .aut \ filename .fc2
.PD
.P
If the input and output files are both in BCG format, e.g.:
.PD 0
.P
.BI "   bcg_io " input_file .bcg \ output_file .bcg
.P
then the input file,  if encoded using an old version of the BCG format,
is systematically converted to the latest version of the BCG format
and stored in the output file.
.PD
.P
Finally, uncompressing or compressing a BCG file can be done as follows:
.PD 0
.P
.BI "   bcg_io " input_file .bcg\ -uncompress \ output_file .bcg
.P
or
.P
.BI " bcg_io " input_file ".bcg -compress -size 2 2 4 " output_file .bcg
.PD
.P
.P
The following associations of options and filenames are currently available, 
for input and/or output:
.TP
.BI -bcg \ input_filename[ .bcg ]
Read \fIinput_filename\fP\fB.bcg\fP encoded in the BCG graph format.

.TP
.BI \-bcg \ [ -parse\ |\ -unparse ]\ output\_filename[ .bcg ]
Write \fIoutput_filename\fP\fB.bcg\fP encoded in the BCG graph format.
General options \fB-uncompress\fP, \fB-compress\fP, \fB-register\fP,
\fB-short\fP, \fB-medium\fP, and \fB-size\fP can be used to control
the contents of \fIoutput_filename\fP\fB.bcg\fP.
Options \fB-parse\fP and \fB-unparse\fP can be used to control label 
parsing in \fIoutput_filename\fP\fB.bcg\fP (see the
.BR bcg_write (LOCAL)
manual page for a technical discussion about label parsing).
By default, or if option \fB-parse\fP is present, label parsing is enabled.
If option \fB-unparse\fP is present, label parsing is disabled. 
If the input file is also in BCG format, options \fB-parse\fP and 
\fB-unparse\fP will have no effect, as the status of label parsing used 
in the input BCG file will be preserved in \fIoutput_filename\fP\fB.bcg\fP. 

.TP
.BI \-ascii \ [ -small ]\ output_filename[ .ascii ]
Write \fIoutput_filename\fP\fB.ascii\fP encoded in the ASCII dump format.
If option \fB-small\fP is present, do not display the contents of the
state area, the edge area, and the class area. By default, these areas
are displayed.

.TP
.BI -auto \ output_filename[ .m0 ]
Write \fIoutput_filename\fP\fB.m0\fP encoded in the AUTO graph format.

.TP
.BI \-aldebaran \ input_filename[ .aut ]
Read \fIinput_filename\fP\fB.aut\fP encoded in the AUT graph format
(see the
.BR aut (LOCAL)
manual page for a description of this format).

.TP
.BI \-aldebaran \ output_filename[ .aut ]
Write \fIoutput_filename\fP\fB.aut\fP encoded in the AUT graph format.

.TP
.BI -cwb \ output_filename[ .cwb ]
Write \fIoutput_filename\fP\fB.cwb\fP encoded in the CWB graph format.

.TP
\fB-etmcc\fP\fI [\fP\fB-format \fP\fIformat_string] output_filename[\fP\fB.tra\fP\fI]\fP
Write \fIoutput_filename\fP\fB.tra\fP encoded in the ETMCC graph format.
If option \fB-format \fP\fIformat_string\fP is present, it specifies the
form under which floating-point numbers are printed to the output file
See the
.BR bcg_min (LOCAL)
and
.BR determinator (LOCAL)
manual pages for a detailed description of \fIformat_string\fP. By default,
i.e., if option \fB-format\fP is absent, the default value of 
\fIformat_string\fP is \fB"%g"\fP.

.TP
\fB-fc2\fP\fI [\fP\fB-net \fP\fInumber] input_filename[\fP\fB.fc2\fP\fI]\fP
Read \fIinput_filename\fP\fB.fc2\fP encoded in the FC2 graph format.
If option \fB-net \fP\fInumber\fP is present, select the \fInumber\fP-th 
automaton contained in \fIinput_filename\fP\fB.fc2\fP. If option \fB-net\fP 
is not specified, \fInumber\fP is given the default 0.

.TP
\fB-fc2\fP\fI [\fP\fB-verbose\fP\fI] output_filename[\fP\fB.fc2\fP\fI]\fP
Write \fIoutput_filename\fP\fB.fc2\fP encoded in the FC2 graph format.
If option \fB-verbose\fP is present, use the verbose form of FC2 (by 
default, the compact form of FC2 is used).

.TP
.BI \-gml \ output_filename[ .gml ]
Write \fIoutput_filename\fP\fB.gml\fP encoded in the GML graph format.

.TP
.BI \-graphviz \ output_filename[ .dot ]
Write \fIoutput_filename\fP\fB.dot\fP encoded in the DOT graph format of
the GRAPHVIZ tools.

.TP
.BI \-lotos \ output_filename[ .lotos ]
Write \fIoutput_filename\fP\fB.lotos\fP in pseudo-LOTOS format.

.TP
.BI \-mec \ output_filename[ .mec ]
Write \fIoutput_filename\fP\fB.mec\fP encoded in the MEC graph format.

.TP 
.BI \-pipn \ output_filename[ .auto.pro ]
Write \fIoutput_filename\fP\fB.auto.pro\fP encoded in the PIPN graph format.

.TP
.BI \-scan \ output_filename[ .scan ]
Write \fIoutput_filename\fP\fB.scan\fP encoded in the SCAN graph format.

.TP
.BI \-sequence \ input_filename[ .seq ]
Read \fIinput_filename\fP\fB.seq\fP encoded in the simple SEQ format (see the
.BR seq (LOCAL)
manual page for a description of this format).

.TP
.BI \-sequence \ output_filename[ .seq ]
Write \fIoutput_filename\fP\fB.seq\fP encoded in the simple SEQ format.
Translating a graph to the SEQ format is only possible if the graph
has no circuits and if all its states (with the possible exception of
the initial state) have at most one outgoing edge.

.TP
.BI \-squiggles \ output_filename[ .graph ]
Write \fIoutput_filename\fP\fB.graph\fP encoded in the SQUIGGLES graph format.

.TP
.BI \-vcg \ output_filename[ .vcg ]
Write \fIoutput_filename\fP\fB.vcg\fP encoded in the VCG graph format.

.TP
.BI \-viscope \ output_filename[ .trans ]
Write \fIoutput_filename\fP\fB.trans\fP encoded in the VISCOPE graph format.

.TP
.BI -xesar \ [ -old ]\ output_filename[ .gra ]
Write \fIoutput_filename\fP\fB.gra\fP encoded in the XESAR graph format.
Three auxiliary files (\fIoutput_filename\fP\fB.dp3\fP, 
\fIoutput_filename\fP\fB.ge3\fP, and \fIoutput_filename\fP\fB.tai\fP) 
are also generated.
If option \fB-old\fP is present, use the old XESAR format 
(this format is now obsolete and does not work for graphs with 
more than 65536 states). By default, the new XESAR format
is used.

.SH NOTES
The letters ``io'' in \fBbcg_io\fP stand for input/output.

.SH ENVIRONMENT VARIABLES

See the
.BR bcg (LOCAL)
manual page for a description of the environment variables used by all
the BCG application tools.

.SH EXIT STATUS
Exit status is 0 if everything is alright, 1 otherwise.

.SH AUTHORS
Renaud Ruffiot, Hubert Garavel, Radu Mateescu, and David Jacquemin.

.SH ACKNOWLEDGEMENTS
Acknowledgements are due to Patrick Ernberg (SICS, Sweden) for
suggesting a conversion scheme to the CWB format.

.SH OPERANDS
.PD 0
.TP 25
.IB filename .bcg
BCG graph (input or output)
.TP
.IB filename @1.o
dynamic library (input or output)
.TP
.IB filename .ascii
ASCII dump (output)
.TP
.IB filename .m0
AUTO graph (output)
.TP
.IB filename .aut
AUT graph (input or output)
.TP
.IB filename .cwb
CWB graph (output)
.TP
.IB filename .tra
ETMCC graph (output)
.TP
.IB filename .fc2
FC2 graph (input or output)
.TP
.IB filename .gml
GML graph (output)
.TP
.IB filename .dot
GRAPHVIZ graph (output)
.TP
.IB filename .lotos
pseudo-LOTOS (output)
.TP
.IB filename .mec
MEC graph (output)
.TP
.IB filename .auto.pro
PIPN graph (output)
.TP
.IB filename .scan
SCAN graph (output)
.TP
.IB filename .seq
SEQ trace (input or output)
.TP
.IB filename .graph
SQUIGGLES graph (output)
.TP
.IB filename .vcg
VCG graph (output)
.TP
.IB filename .trans
VISCOPE graph (output)
.TP
.IB filename .gra
XESAR graph (output)
.TP
.IB filename .dp3
XESAR graph (output)
.TP
.IB filename .ge3
XESAR graph (output)
.TP
.IB filename .tai
XESAR graph (output)
.PD

.SH FILES

.PD 0
.TP 32
.B $CADP/bin.`arch`/bcg_io
``\fBbcg_io\fP'' binary program
.TP
.B $CADP/bin.`arch`/libBCG_IO.a
``\fBbcg_io\fP'' static library #1
.TP
.B $CADP/bin.`arch`/libbcg_iodyn.a
``\fBbcg_io\fP'' static library #2
.PD
.P
See the
.BR bcg (LOCAL)
manual page for a description of the other files.

.SH SEE ALSO

.BR aut (LOCAL),
.BR bcg (LOCAL),
.BR bcg_min (LOCAL),
.BR bcg_write (LOCAL),
.BR determinator (LOCAL),
.BR exhibitor (LOCAL),
.BR seq (LOCAL)

.P
Additional information is available from the CADP Web page located at
http://cadp.inria.fr
.P
Directives for installation are given in files
.B $CADP/INSTALLATION_*.
.P
Recent changes and improvements to this software are reported
and commented in file
.B $CADP/HISTORY.

.SH BUGS
Please report bugs to Hubert.Garavel@inria.fr

