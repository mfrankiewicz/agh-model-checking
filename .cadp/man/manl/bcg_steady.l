.\" @(#)bcg_steady.l - VASY and CONVECS teams - 2019/01/08
.TH BCG_STEADY LOCAL "2019/01/08" "(C) INRIA" "CADP MANUAL PAGES"
.fp 4 CB
.lg 0
.SH NAME
bcg_steady \- steady-state numerical analysis of (extended) continuous-time Markov chains encoded in the BCG format

.SH SYNOPSIS

.B bcg_steady
[\fIbcg_options\fP]
[\fB-epsilon\fP \fIeps\fP]
[\fB-sol\fI \fIsolution_file\fP]
[\fB-thr\fP [\fB-append\fP] \fIthroughput_file\fP]
[\fB-mat\fP \fImatrix_file\fP]
[\fB-red\fP \fIreduced_matrix_file\fP]
[\fB-log\fP \fIlog_file\fP]
.IB filename [.bcg]
[\fIparameter\fP=\fIvalue\fP ...]

.P
where \fIbcg_options\fP is defined below (see GENERAL OPTIONS).

.SH DESCRIPTION

\fBbcg_steady\fP performs steady-state analysis on \fIfilename\fP\fB.bcg\fP,
which is an (extended) continuous-time Markov chain encoded in the BCG format.

.P
\fBbcg_steady\fP first transforms \fIfilename\fP\fB.bcg\fP into a numerical
matrix indexed by states. Then, it reduces this matrix by normalizing
probabilistic transitions, removing unreachable states and "vanishing" states,
keeping "tangible" states only (see section INPUT below for details about the
BCG graphs accepted by \fBbcg_steady\fP and the definition of tangible and 
vanishing states). As a result, the reduced matrix obtained is
the generator matrix of a continuous-time Markov chain. Finally,
\fBbcg_steady\fP computes the corresponding equilibrium ("steady-state")
probability distribution on the long run using the Gauss/Seidel algorithm
(see e.g. [Ste94]). It can also compute throughputs for the transitions of
the system.

.SH GENERAL OPTIONS

The following \fIbcg_options\fP are currently supported: \fB-version\fP, 
\fB-create\fP, \fB-update\fP, \fB-remove\fP, \fB-cc\fP, and \fB-tmp\fP. See the
.BR bcg (LOCAL)
manual page for a description of these options.

.SH PARTICULAR OPTIONS

Taking as input \fIfilename\fP\fB.bcg\fP, on the form of which various
restrictions apply (see section INPUT below), \fBbcg_steady\fP can produce
five kinds of output files, depending on the command-line options specified.

.P
The optional list of "\fIparameter\fP=\fIvalue\fP" arguments at the end of
the command-line (where \fIparameter\fP is any character string that neither
contain blanks nor the "=" character, and where \fIvalue\fP is any character
string that does not contain blanks) is only meaningful to option \fB-thr\fP.
These arguments have no influence on the actual numerical computations, they
only serve to add columns in throughput tables (see section OUTPUT-2 below).

.P
The following options are supported:

.TP
.BI -epsilon \ eps
Set the precision of certain floating-point comparisons to \fIeps\fP, where 
\fIeps\fP is a real value. When \fIeps\fP is out of [0..1[, \fBbcg_steady\fP
reports an error. Default value for \fIeps\fP is 1E-6.

.TP
.BI -sol \ \fIsolution_file\fP
Write the probability vector, computed at the equilibrium state, to file 
\fIsolution_file\fP (see section OUTPUT-1 below for a description of the file
format). If \fIsolution_file\fP already exists, its contents will be
overwritten. If \fIsolution_file\fP is equal to the special string `-', the
probability vector is displayed on the standard output. 
Not a default option.

.TP 
.BI -thr \ [\fB-append\fP]\ \fIthroughput_file\fP
Write the transition throughputs, computed at the equilibrium state, to file
\fIthroughput_file\fP. The format of this file is determined by the suffix
(i.e., file extension) of \fIthroughput_file\fP (see section OUTPUT-2 below
for a description of the available file formats). If \fIthroughput_file\fP
already exists, its contents will be overwritten, unless the \fB-append\fP
option is specified, in which case the transition throughputs will be added
at the end of \fIthroughput_file\fP so as to form a proper data table. If
the \fB-thr\fP option is missing or if \fIthroughput_file\fP is equal to the
special string `-', the transition throughputs are displayed on the standard
output.
Option "\fB-thr -\fP" is the default option when the command line does not
contain any of the following options: \fB-mat\fP, \fB-red\fP, \fB-sol\fP,
and \fB-thr\fP.

.TP
.BI -mat \ \fImatrix_file\fP
Write the transposed "raw" matrix (prior to matrix reduction) to file 
\fImatrix_file\fP. The format of this file is determined by the suffix
(i.e., file extension) of \fImatrix_file\fP (see section OUTPUT-3 below for
a description of the available file formats). If \fImatrix_file\fP already
exists, its contents will be overwritten. If \fImatrix_file\fP is equal to
the special string `-', the matrix is displayed on the standard output.
Not a default option.

.TP
.BI -red \ \fIreduced_matrix_file\fP
Write the reduced transposed matrix to file \fIreduced_matrix_file\fP.
The format of this file is determined by the suffix (i.e., file extension) of
\fIreduced_matrix_file\fP (see section OUTPUT-3 below for a description of
the available file formats). If \fIreduced_matrix_file\fP already exists,
its contents will be overwritten.  If \fIreduced_matrix_file\fP is equal to
the special string `-', the matrix is displayed on the standard output.
Not a default option.

.TP
.BI -log \ \fIlog_file\fP
Write various information about data structures and computations to file
\fIlog_file\fP. The format of this file is undocumented but self-understandable,
and might change in future releases of \fIbcg_steady\fP. If \fIlog_file\fP
already exists, its contents will be overwritten. If \fIlog_file\fP is
equal to the special string `-', information is displayed on the
standard output.
Not a default option.

.P
The files \fIsolution_file\fP, \fIthroughput_file\fP, \fImatrix_file\fP,
\fIreduced_matrix_file\fP, and \fIlog_file\fP should be pairwise different;
otherwise, the result is undefined.

.SH INPUT: THE B\&C\&G GRAPH

The input of \fBbcg_steady\fP is an extended Markovian model combining
features from discrete-time and continuous-time Markov chains.
In order to be accepted by \fBbcg_steady\fP, \fIfilename\fP\fB.bcg\fP must
satisfy several conditions, otherwise an error message will occur.

All transition labels of \fIfilename\fP\fB.bcg\fP must have one of the
following forms:
.IP -
"\fBrate\fP \fI%f\fP" (called a stochastic transition),
.IP - 
"\fIlabel\fP\fB;\ rate\fP \fI%f\fP" (called a labelled stochastic transition),
.IP -
"\fBprob\fP \fI%p\fP" (called a probabilistic transition), or
.IP -
"\fIlabel\fP\fB;\ prob\fP \fI%p\fP" (called a labelled probabilistic transition), 
.P
where \fB%f\fP denotes a strictly positive floating-point number,
\fB%p\fP denotes a floating-point number in the range ]0..1], 
and \fIlabel\fP denotes a character string that does not contain the "\fB;\fP"
character (\fIlabel\fP may be equal to the internal action, often noted "i"
or "tau").

.P
Note: transitions labelled with only "\fIlabel\fP" are always forbidden by
\fBbcg_steady\fP, including the case where "\fIlabel\fP" denotes the internal
action.

.P
When constructing the "raw" matrix, all \fIlabel\fPs occurring in labelled
probabilistic transitions are discarded.

.P
If there exists a (labelled) probabilistic transition from a state \fIS1\fP
to a state \fIS2\fP, then all (labelled) stochastic transitions from \fIS1\fP
to any state (including \fIS2\fP) are discarded when constructing the "raw" 
matrix. This reflects that probabilistic transitions are instantaneous, while
stochastic transitions are not.

.P
We classify states as being either \fIvanishing\fP if at least one (possibly
labelled) probabilistic transition goes out of these states, or \fItangible\fP
otherwise. 

.P
The input BCG graph should contain at least one tangible state, and it should
not contain cycles (including self-loops) of states connected by (possibly 
labelled) probabilistic transitions.

.P
Note: The sum of \fB%p\fP values on all (possibly labelled) probabilistic
transitions leaving a vanishing state needs not be equal to 1; if this
sum is different from 1, then probabilistic values will be normalized (i.e.,
divided by this sum).

.P
To build the reduced matrix, \fBbcg_steady\fP eliminates all
vanishing states, so that this matrix contains tangible states only. 
The input BCG graph should be such that, after reduction, each tangible
state possesses at least one outgoing transition (i.e., there is no deadlock
state).

.P
See also
.BR bcg_min (LOCAL)
for a discussion about the various probabilistic and stochastic models present
in the literature.

.SH OUTPUT-1: THE SOLUTION VECTOR

The format of the file generated using the \fB-sol\fP option of
\fBbcg_steady\fP is the following. There is one line per tangible state.
Each line contains two numbers: an integer corresponding to the state number
in the input BCG graph and a real number corresponding to the probability
of being in this state on the long run (i.e., at the equilibrium).

.SH OUTPUT-2: THE TRANSITION THROUGHPUTS

.P
The throughput table has two (possibly empty) groups of columns:

.IP -
The first group contains one column for each option \fIparameter\fP=\fIvalue\fP
given on the command-line. These columns, if any, are useful when evaluating
the performance of a system parameterized with one or more variables, namely
to aggregate in the same table the different throughputs measures corresponding
to different values of the parameters. Columns of the first group appear in
the same order as the corresponding options on the command-line. 

.IP -
The second group contains one column per labelled stochastic transition label
present in the input BCG graph, precisely, one column for each different
\fIlabel\fP occurring on a transition of the form 
"\fIlabel\fP\fB;\ rate\ %f\fP".

.P
The throughput table starts with a first "header" line followed by one or
several "subsequent" lines.

.IP -
The header line contains the "titles" of columns. For a column of the first
group associated to a \fIparameter\fP=\fIvalue\fP option, the corresponding
title is \fIparameter\fP. For a column of the second group associated to a
label, the corresponding title is the label itself.

.IP -
The subsequent lines contain values. For a column of the first group associated
to a \fIparameter\fP=\fIvalue\fP option, the corresponding cell contains
\fIvalue\fP. For a column of the second group associated to a \fIlabel\fP,
the corresponding cell contains the throughput for this label, i.e., the
sum, for each stochastic transition "\fIlabel\fP\fB;\ rate\ %f\fP", of the
rate value \fI%f\fP weighted with the probability of being in the tangible
source state of this transition, in the long run.

.P
If the \fB-append\fP option is absent, or if the throughput file is equal to
the special string `-', or if the throughput file does not exist, or if it is
empty, \fIbcg_steady\fP will generate automatically the header line and one
single subsequent line.

.P
Otherwise, the first line of the throughput file is expected to contain the
titles of columns and will be parsed to identify the correspondance between
labels and columns. In particular, \fBbcg_steady\fP checks that the first
group of columns corresponds to the parameters given on the command-line.
After parsing the header line, \fBbcg_steady\fP will append one single
subsequent line at the end of the throughput file. As regards the second group
of columns, if the label of a given column title does not occur in
\fIfilename\fP\fB.bcg\fP, a zero throughput will be reported in the
corresponding column; conversely, labels of \fIfilename\fP\fB.bcg\fP for which
there is no corresponding column title will be ignored.

.P
Throughputs can be displayed in two different formats, which are determined
according to the suffix (i.e., file extension) of the throughput file name.

.IP -
If the file name has the "\fB.csv\fP" extension, the throughput table will be
displayed in the CSV (Comma-Separated Values) exchange format understood by
most relational data base applications and spreadsheet software (such as
Microsoft Excel, etc.).

.IP -
Otherwise, if the file name has a different extension, or no extension, or
if it is the standard output, throughputs will be displayed in a human-readable
format that is essentially the same format as CSV with commas replaced by
spaces so as to align columns properly. Note that this format is also
understood by some data visualization tools such as Gnuplot.

.SH OUTPUT-3: THE (TRANSPOSED) MATRICES

Both the (transposed) "raw" matrix produced using option \fB-mat\fP and
the (transposed) reduced matrix produced using option \fB-red\fP
follow the same format conventions. The essential difference is that the
former contains vanishing and tangible states, whereas the latter only
contains tangible states. Also, the reduced matrix is a generator of a
continuous-time Markov chain.

.P
For two different indexes \fIi\fP and \fIj\fP, the element (\fIi\fP,\fIj\fP)
of the matrix, located at the \fIi\fP-th row and the \fIj\fP-th column, is the
sum of all the floating-point numbers associated to the (labelled) stochastic
or probabilistic transitions going from the \fIj\fP-th state to the \fIi\fP-th 
state, where floating-point numbers associated to (labelled) stochastic 
transitions are interpreted as positive numbers whereas floating-point numbers
associated to (labelled) probabilistic transitions are interpreted as negative
numbers between -1 and 0. Note that rates and probabilities are never mixed
since, between two states, there cannot be stochastic and probabilistic
transitions at the same time.

.P
The diagonal elements (\fIj\fP,\fIj\fP) are defined to be the negative sum 
of all matrix elements (\fIi\fP,\fIj\fP) with \fIi\fP different from \fIj\fP.

.P
Matrices can be displayed in three different formats, which are determined
according to the suffix (i.e., file extension) of the matrix file name.

.IP -
If the file name has the "\fB.csv\fP" extension, the matrix will be
displayed in the CSV (Comma-Separated Values) format mentioned above.
Each raw of the matrix is displayed on one line of the output file, and
on each line, the matrix elements are separated with commas.

.IP -
If the file name has the "\fB.spm\fP" extension, the matrix will be 
displayed in the format used by the Sparse 1.3 software library (see
the CREDITS section below). This format is the following. 
The first line of the file contains the file name.
The second line contains the number of states, followed by the "\fBreal\fP"
keyword. 
Then, there is one line per each non-zero element (\fIi\fP,\fIj\fP) in
the matrix. Each line contains two integers followed by one real number:
the value of \fIi\fP, the value of \fIj\fP, and the value of matrix element
(\fIi\fP,\fIj\fP).
The file ends with a "sentinel" line consisting of three zeros.
 
.IP -
Otherwise, if the file name has a different extension, or no extension, or
if it is the standard output, the matrix will be displayed in a human-readable
format. The columns of the matrix are split into "packets" so that the text
fits on the size of the display. The indexes of rows and columns are indicated
and null elements of the matrix are displayed as "..." instead of "0".
Statistics (such as matrix size, density, etc.), are displayed after the 
matrix.

.P
Note: for graphs with many states, whatever the chosen matrix format, the
matrix files can be large and writing them to disk may take time. 

.SH ENVIRONMENT VARIABLES

See the
.BR bcg (LOCAL)
manual page for a description of the environment variables used by all
the BCG application tools.

.SH EXIT STATUS
Exit status is 0 if everything is all right, 1 otherwise.

.SH AUTHORS
The first version of \fBbcg_steady\fP was written by Christophe Joubert 
(INRIA/VASY) and Holger Hermanns (Saarland University and University of
Twente). The algorithm for steady-state analysis is based on a former
implementation by Vassilis Mertsiotakis (University of Erlangen). Bruno
Ondet (INRIA/VASY) ported the tool to various architectures. David 
Champelovier and Hubert Garavel (both at INRIA/VASY) deeply revised the 
\fBbcg_steady\fP code and manual page to allow their integration within CADP.
Holger Hermanns and Frederic Lang (INRIA/VASY) proof-checked the manual page.

.SH CREDITS
\fBbcg_steady\fP uses (an extended version of) the Sparse 1.3 package from
the University of California, Berkeley, developed by Kenneth S. Kundert
under the supervision of Alberto Sangiovanni-Vincentelli. 

.SH OPERANDS
.PD 0
.TP 20
.IB filename .bcg
BCG graph (input)
.TP
.IB filename @1.o
dynamic library (input or output)
.PD

.SH FILES

.PD 0
.TP 32
.B $CADP/bin.`arch`/bcg_steady
``\fBbcg_steady\fP'' program
.PD

.P
See the
.BR bcg (LOCAL)
manual page for a description of the other files.

.SH SEE ALSO
.BR bcg (LOCAL),
.BR bcg_min (LOCAL),
.BR bcg_transient (LOCAL),
.BR determinator (LOCAL)

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

.SH BIBLIOGRAPHY

.P
[GH02] H. Garavel and H. Hermanns. On Combining Functional Verification 
and Performance Evaluation using CADP. In proceedings of FME'2002, LNCS 2391,
pages 410-429, Springer Verlag. Full version available as INRIA Research 
Report 4492. Available from
http://cadp.inria.fr/publications/Garavel-Hermanns-02.html

.P
[HJ03] H. Hermanns and Ch. Joubert. A Set of Performance and Dependability
Analysis Components for CADP. In proceedings of TACAS'2003, LNCS 2619, pages
425-430, Springer Verlag. Available from
http://cadp.inria.fr/publications/Hermanns-Joubert-03.html

.P
[Mer98] V. Mertsiotakis. Approximate Analysis Methods for Stochastic Process
Algebras. Ph.D Thesis, University of Erlangen (Germany), 1998.

.P 
[Ste94] W. J. Stewart. Introduction to the Numerical Solution of Markov 
Chains. Princeton University Press, 1994.

