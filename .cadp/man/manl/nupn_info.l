.\" @(#)nupn_info.l VASY and CONVECS teams - 2019/11/05
.TH NUPN_INFO LOCAL "2019/11/05" "(C) INRIA" "CADP MANUAL PAGES"
.fp 4 CB
.lg 0
.SH NAME
nupn_info \- query and transformation of Nested-Unit Petri Nets

.SH SYNOPSIS
.B nupn_info
\fIoption\fP
[ \fIfilename\fP\fB.nupn\fP ]

.SH DESCRIPTION
Taking as input \fIfilename\fP\fB.nupn\fP (or by default the standard input), 
which contains a Nested-Unit Petri Net (NUPN) encoded in the
.BR nupn (LOCAL)
format,
.B nupn_info
performs various analyses or transformations, depending on the 
\fIoption\fP specified on the command-line, and writes the corresponding
results to the standard output.

.SH OPTIONS
.TP
.B -canonical-nupn
Simplify (if possible) the input NUPN to put it under a normal form.
The following transformations are applied: tabulations are replaced with
spaces; empty or blank lines are deleted; extra spaces are removed; the
description of units and the description of transitions are sorted by
increasing numbers; the list of sub-units of each unit is sorted by
increasing numbers; the lists of input and output places of each
transition are sorted by increasing numbers; any line of the following
form "\fBinitial place %d\P" is replaced with "\fBinitial places #1 %d\P";
any line of the following form "\fBlabels 0 0 0 %d\P" is deleted; the 
maximal length of labels (4th argument of the "\fBlabels\fP" line)
is recomputed and set to its minimal value. The resulting NUPN is displayed
on the standard output.

.TP
.B -place-fusion
Apply the place-fusion abstraction to the input NUPN, merging in each
unit all the places of this unit into a single place. The resulting
NUPN has as many places as it has non-void units. Places may be renumbered
if merged places are deleted; unit and transition numbers are kept unchanged.
The resulting NUPN is displayed on the standard output.

.TP
.B -redundant-removal
Eliminate all redundant units from the input NUPN, i.e., units containing
exactly one (directly nested) sub-unit. Units and places may be renumbered
if redundant units are deleted; transition numbers are kept unchanged.
If the input NUPN has no redundant unit, the only changes applied are
those performed by option \fB-canonical-nupn\fP. The resulting NUPN is
displayed on the standard output.

.TP
.B -trivial-units
Erase the existing unit structure of the input NUPN and replace
it with the trivial unit structure, in which each unit contains a single
place, except the root unit, which has no place and contains all the other
units. The resulting NUPN has as many non-void units as it has places. 
Units may be renumbered if new units are added; place and transition numbers
are kept unchanged. The resulting NUPN is displayed on the standard output.

.TP
.B -void-removal
Eliminate all void (non-root) units from the input NUPN, i.e., units
containing no local places. Units may be renumbered if void units
are deleted; place and transition numbers are kept unchanged. If
the input NUPN has no void (non-root) unit, the only changes applied
are those performed by option \fB-canonical-nupn\fP. The resulting NUPN
is displayed on the standard output.

.P
For performance reasons,
.B nupn_info
assumes that the contents of the input NUPN are correct.
When dealing with an unknown NUPN, it is therefore advisable
to first analyze its contents with the \fB-check\fP option of
.BR caesar.bdd (LOCAL).
However, certain options (especially \fB-canonical-nupn\fB and
\fB-void-removal\fP) may transform an incorrect NUPN into a correct one.

.SH N\&U\&P\&N (\&NESTED-\&UNIT \&PETRI \&NET) FORMAT

See the 
.BR nupn (LOCAL)
manual page for a detailed definition of the NUPN file format.

.SH EXIT STATUS
The exit status of 
.B nupn_info
is zero if execution went well; in such case, a valid NUPN file is
written to the standard output. Otherwise, a non-zero exit status
is returned and an error message may be displayed to the standard
output.

.SH AUTHOR
Hubert Garavel (INRIA Rhone-Alpes) 

.SH FILES
.PD 0
.TP 17
.IB filename .nupn
Nested-Unit Petri Net (input)

.SH BIBLIOGRAPHY

[Gar19] Hubert Garavel. "Nested-Unit Petri Nets".
Journal of Logical and Algebraic Methods in Programming, vol. 104,
pages 60-85, April 2019. Available from
http://cadp.inria.fr/publications/Garavel-19.html

[Gar15] Hubert Garavel.
"Nested-Unit Petri Nets: A Structural Means to Increase Efficiency and
Scalability of Verification on Elementary Nets".
In R. Devillers and A. Valmari, editors, Proceedings of the 36th
International Conference on Application and Theory of Petri Nets and
Concurrency (PETRI NETS'15), Brussels, Belgium. Lecture Notes in Computer
Science, vol. 9115, Springer, 2015. Superseded by [Gar19]. Available from
http://cadp.inria.fr/publications/Garavel-15-a.html

.SH SEE ALSO
.BR caesar.bdd (LOCAL),
.BR nupn (LOCAL)

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
Please report new bugs to Hubert.Garavel@inria.fr

