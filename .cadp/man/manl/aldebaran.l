'\" t
.\" @(#)aldebaran.l - VASY and CONVECS teams - 2019/01/09
.TH ALDEBARAN LOCAL "2019/01/09" "(C) INRIA" "CADP MANUAL PAGES"
.fp 4 CB
.lg 0
.SH NAME
aldebaran \- minimization and comparison of labelled transitions systems

.SH IMPORTANT NOTICE

As of July 2008, 
.B aldebaran
is a deprecated tool of CADP. Instead of
.B aldebaran
it is highly recommended to invoke the following tools of CADP (either directly or indirectly using SVL):
.IP -
.BR bcg_cmp (LOCAL)
.IP -
.BR bcg_info (LOCAL)
.IP -
.BR bcg_io (LOCAL)
.IP -
.BR bcg_labels (LOCAL)
.IP -
.BR bcg_min (LOCAL)
.IP -
.BR bcg_open (LOCAL)
.IP -
.BR bisimulator (LOCAL)
.IP -
.BR caesar_hide_1 (LOCAL)
.IP -
.BR caesar_rename_1 (LOCAL)
.IP -
.BR evaluator (LOCAL)
.IP -
.BR exp.open (LOCAL)
.IP -
.BR exhibitor (LOCAL)
.IP -
.BR generator (LOCAL)
.IP -
.BR reductor (LOCAL)

.P
From version 1.0 (January 1990) to version 6.6 (October 2005),
.B aldebaran
has been a binary executable (located in "$CADP/bin.`arch`/aldebaran" and
later in "$CADP/bin.`arch`/aldebaran.old"). It performed minimizations and 
comparisons of labelled transition systems, using the Paige & Tarjan algorithm,
the Fernandez & Mounier on-the-fly algorithm, the Minimal Model Generation
algorithm, and algorithms based on Binary Decision Diagrams (BDD for short).
Because
.B aldebaran
was no longer maintained by its authors and  was known to contain bugs 
(including false verdicts about equivalence or preorder comparisons), it was
marked as deprecated in CADP 2006. In July 2008, it was eventually
removed from CADP because it would no longer compile using gcc/g++ 3.4.*
and no one volunteered to port it to 64-bit platforms.

.P
Version 7.* of 
.B aldebaran
is a shell-script (located in file "$CADP/com/aldebaran") that has been 
introduced in October 2005. This shell-script invokes the CADP tools mentioned
above and does not rely on \fBaldebaran\fP 6.6. It provides extensive backward 
compatibility with previous versions of \fBaldebaran\fP by supporting all 
their commands/options but \fB-dequ\fP. It also removes many limitations that 
existed in the previous versions of \fBaldebaran\fP.

.SH SYNOPSIS
.B aldebaran
.IR command \ [ options ]
.br
.B aldebaran
.IR command \ [ options ] \ filename1
.br
.B aldebaran
.IR command \ [ options ] \ filename1\ filename2
.P
where \fIfilename\fP can be either a file in Aldebaran format
(with suffix \fB.aut\fP), a file in BCG format (with suffix \fB.bcg\fP),
or a file describing a system of communicating automata (with
suffix \fB.exp\fP).

.SH DESCRIPTION

.B aldebaran
allows the minimization or comparison of Labelled Transitions Systems
(LTS for short) with respect to various equivalence and preorder
relations. It can be applied:
.IP -
either to completely generated LTSs, which are usually contained in files
with the \fB.aut\fP or \fB.bcg\fP suffix. See the
.BR aut (LOCAL)
and
.BR bcg (LOCAL)
manual pages for a description of the \fB.aut\fP and \fB.bcg\fP formats. 
\fBaldebaran\fP also accepts other LTSs formats (such as \fB.fc2\fP
or \fB.seq\fP files): in such case, the \fBbcg_io\fP tool is used to perform
silently the translation of these other formats into the BCG format.
.IP -
or to networks of communicating LTSs, which are contained in files with the
.B .exp
suffix. See the 
.BR exp (LOCAL)
manual page for a description of this format.

.SH COMMANDS

The followings \fIcommand\fPs are currently available:

.TP
.B -dead\ \ \ \ \ \ 
Print the set of deadlock states (sinks) for a LTS or a network of
communicating LTSs.

.TP
.B -det\ \ \ \ \ \ 
Determinize a LTS and display the result as a new LTS.

.TP
.B -help\ \ \ \ \ \ 
Display the help file and stop.

.TP
.B -info\ \ \ \ \ \ 
Print various graph structure information for the LTS contained in
\fIfilename1\fP\fB.(aut,bcg)\fP or the network of communicating LTSs
contained in \fIfilename1\fP\fB.exp\fP. See also the
.BR bcg_info (LOCAL)
tool, which provides more complete structure information on a BCG graph.

.TP
.B -live\ \ \ \ \ \ 
Check whether there are livelock states (tau circuits) in the LTS or 
network of communicating LTSs stored in \fIfilename1\fP\fB.(aut,bcg,exp)\fP.
If so, generate in file \fBaldebaran.bcg\fP a diagnostic, which is
a subgraph of \fIfilename1\fP that exhibits both a livelock and a path to the
livelock, starting from the initial state.

.TP
\fB-output\fP \fIfilename\fP[\fB.aut\fP|\fB.bcg\fP]
Specify the name (either \fIfilename\fP\fB.aut\fP or
\fIfilename\fP\fB.bcg\fP) and the format (either ALDEBARAN format or
BCG format) of the output file in which \fBaldebaran\fP will display
its results (for those \fBaldebaran\fP commands that produce an
LTS). By default, if no \fB-output\fP command is given, the result is
printed on the standard output in ALDEBARAN format.

.TP
.BI -path \ nb
Compute in a LTS a path from the initial state to the state \fInb\fP.
Display the result on the standard output as an LTS encoded in the
.BR seq (LOCAL)
format (see the DIAGNOSTICS section below).

.TP
.B -sort\ \ \ \ \ \ 
Sort the LTS. Sorting is done with the source state of transitions as
primary key, and the label as secondary key. The LTS descriptor
remains at the beginning of the file.

.TP
.B -version
Display the current version number of the software and stop.

.P
The remaining commands have the following syntax:
.P
   \fB-\fP\fI<relation><action>\fP
.P
where
.I <relation>
is a one-character string, either \fBb\fP, \fBi\fP, \fBo\fP, \fBp\fP,
or \fBs\fP:
.IP *
.B `b'
: use the strong bisimulation equivalence [Park-81] or the
corresponding preorder
.IP *
.B `i'
: use the tau*.a bisimulation [Fernandez-Mounier-90] or the
corresponding preorder (tau is written i in LOTOS)
.IP *
.B `o'
: use the observational relation [Milner-80]
.IP *
.B `p'
: use the branching bisimulation [R.J. Van Glabbeek and
W.P. Weijland]
.IP *
.B `s'
: use the safety relation [Rodriguez-88]
[Bouajjani-Fernandez-Graf-Rodriguez-Sifakis-91] or the corresponding
preorder
.P
and where
.I <action>
is a character string, either \fBmin\fP, \fBcla\fP, \fBequ\fP or \fBord\fP:
.IP *
.B `min'
: minimize the LTS contained in \fIfilename1\fP\fB.(aut,bcg)\fP, or the
network of communicating LTSs represented by \fIfilename1\fP\fB.exp\fP,
with respect to
.I <relation>
and display the minimized LTS
.IP *
.B `cla'
: same as above, but display the equivalence classes on the standard
output (instead of the reduced LTS)
.IP *
.B `equ'
: compare both LTSs contained in \fIfilename1\fP\fB.(aut,bcg)\fP and
\fIfilename2\fP\fB.(aut,bcg)\fP, or the network of communicating LTSs
\fIfilename1\fP\fB.exp\fP to the LTS \fIfilename2\fP\fB.(aut,bcg)\fP,
or the network of communicating LTSs \fIfilename2\fP\fB.exp\fP to
LTS \fIfilename1\fP\fB.(aut,bcg)\fP, with respect to \fI<relation>\fP,
using \fIalgorithm\fP. The result can be either \fBTRUE\fP
(both LTSs are equivalent) or \fBFALSE\fP; in the latter case, \fBaldebaran\fP
issues a diagnostic consisting either of a set of discriminating sequences
displayed on standard output (see the DIAGNOSTICS section below), or of an 
acyclic BCG graph stored in file \fBaldebaran.bcg\fP (see the \fB-diag\fP
options of
.BR bcg_cmp (LOCAL)
and
.BR bisimulator (LOCAL)
for details about diagnostics in the BCG format).
.IP *
.B `ord'
: same as \fBequ\fP, but use a preorder relation instead of the
equivalence relation

.P
In version 7.* of \fBaldebaran\fP, the method is selected automatically as 
follows:
.IP -
As regards tau*.a and safety minimizations (\fB-imin\fP, \fB-icla\fP,
\fB-pmin\fP, and \fB-pcla\fP options), the LTS is first pre-reduced on the fly
using \fBreductor\fP, then minimized modulo strong bisimulation following the
standard method using \fBbcg_min\fP.
.IP -
As regards strong and branching minimizations (\fB-bmin\fP, \fB-bcla\fP,
\fB-pmin\fP, \fB-pcla\fP), the LTS is first generated (if needed) using
\fBgenerator\fP and then minimized following the standard method using
\fBbcg_min\fP.
.IP -
As regards comparisons modulo strong, branching, observational, tau*.a, and
safety equivalences (\fB-bequ\fP, \fB-bord\fP, \fB-pequ\fP, \fB-pord\fP,
\fB-oequ\fP, \fB-oord\fP, \fB-iequ\fP, \fB-iord\fP, \fB-sequ\fP, and
\fB-sord\fP options), they are performed using \fBbcg_cmp\fP or, if not
possible, using \fBbisimulator\fP.
.P
Note: options \fB-iord\fP and \fB-sord\fP are identical, since both
compute the same preorder relation.

.SH OPTIONS
The following \fIoptions\fP are currently available:

.TP
.B -stat\ \ \ \ \ \ 
Print various statistics.

.TP
.BI -hide \ filename
Use the hiding rules defined in \fIfilename\fP to hide the labels
contained in files \fIfilename1\fP\fB.(aut,bcg,exp)\fP and possibly
\fIfilename2\fP\fB.(aut,bcg,exp)\fP. See the
.BR caesar_hide_1 (LOCAL)
manual page for a detailed description of the appropriate format for
\fIfilename\fP. There is no required extension for \fIfilename\fP;
however, extensions "\fB.hid\fP" or "\fB.hide\fP" are recommended
for using the SVL compiler and the EUCALYPTUS graphical user-interface.

.TP
.BI -rename \ filename
Use the renaming rules defined in \fIfilename\fP to rename the labels
contained in files \fIfilename1\fP\fB.(aut,bcg,exp)\fP and possibly
\fIfilename2\fP\fB.(aut,bcg,exp)\fP. See the
.BR caesar_rename_1 (LOCAL)
manual page for a description of the appropriate format for
\fIfilename\fP. There is no required extension for \fIfilename\fP;
however, extensions "\fB.ren\fP" or "\fB.rename\fP" are recommended
for using the SVL compiler and the EUCALYPTUS graphical user-interface.

.P
Renaming and hiding patterns are applied in the order in which 
they occur on the command line.

.SH DIAGNOSTICS
\fBaldebaran\fP produces diagnostics to explain why two LTSs are not related 
(\fBequ\fP or \fBord\fP commands). In the general case, these diagnostics are
directed acyclic subgraphs (encoded in the BCG format) containing all sequences
that, when executed simultaneously in the two LTSs, lead to non-equivalent
states. In the particular case where diagnostics are just a single sequence,
.B aldebaran
displays this sequence using the 
.BR seq (LOCAL)
format, in the same way as 
.BR bcg_cmp (LOCAL)
and
.BR bisimulator (LOCAL)
do.

.SH EXIT STATUS
When the source is erroneous, error messages are issued.
Exit status is 0 if everything is alright, 1 otherwise.

.SH AUTHORS
Versions up to 6.6 of \fBaldebaran\fP have been developed by Jean-Claude\ Fernandez, Laurent\ Mounier, Alain\ Kerbrat, and Aline\ Senart\ (IMAG), with various bug fixes by Marc\ Herbert, Hubert\ Garavel, and Frederic\ Lang (INRIA Rhone-Alpes).

.P
Version 7.* of \fBaldebaran\fP was developed by Frederic Lang (INRIA Rhone-Alpes).

.SH OPERANDS
.PD 0
.TP 21
.IB filename .aut
LTS in the Aldebaran format (input or output)
.TP
.IB filename .bcg
LTS in the BCG format (input or output)
.TP
.IB filename .exp
network of communicating LTSs (input)
.TP
.IB filename .hide
list of labels to hide (input)
.TP
.IB filename .rename
list of labels to rename (input)
.PD

.SH FILES
.PD 0
.TP 32
.B $CADP/LICENSE
license file
.TP
.B $CADP/com/aldebaran
shell-script (version 7.*)
.TP
.B aldebaran.bcg
diagnostic file
.PD

.SH SEE ALSO
ALDEBARAN Reference Manual,
.BR aut (LOCAL),
.BR bcg (LOCAL),
.BR bcg_cmp (LOCAL),
.BR bcg_info (LOCAL),
.BR bcg_io (LOCAL),
.BR bcg_labels (LOCAL),
.BR bcg_min (LOCAL),
.BR bcg_open (LOCAL),
.BR bisimulator (LOCAL),
.BR caesar_hide_1 (LOCAL),
.BR caesar_rename_1 (LOCAL),
.BR evaluator (LOCAL),
.BR exp (LOCAL),
.BR exp.open (LOCAL),
.BR exhibitor (LOCAL),
.BR generator (LOCAL),
.BR reductor (LOCAL),
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
Please report any bug to cadp@inria.fr

