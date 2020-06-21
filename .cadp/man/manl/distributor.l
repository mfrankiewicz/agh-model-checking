.\" @(#)distributor.l - VASY and CONVECS teams - 2020/02/12
.TH DISTRIBUTOR LOCAL "2020/02/12" "(C) INRIA" "CADP MANUAL PAGES"
.fp 4 CB
.lg 0
.SH NAME
distributor \- state space generation using distributed reachability analysis

.SH SYNOPSIS
.B bcg_open
.RI [ bcg_opt ]
\fIspec\fP[\fB.bcg\fP]
.RI [ cc_opt ]
.BR distributor
.RI [ distributor_opt ]
\fIconfiguration\fP[\fB.gcf\fP]
\fIresult\fP[\fB.pbg\fP]
.RI [ global_opt ]
.RI [ instance_opt ]
.P
or:
.P
.B exp.open
.RI [ exp_opt ]
\fIspec\fP[\fB.exp\fP]
.RI [ cc_opt ]
.BR distributor
.RI [ distributor_opt ]
\fIconfiguration\fP[\fB.gcf\fP]
\fIresult\fP[\fB.pbg\fP]
.RI [ global_opt ]
.RI [ instance_opt ]
.P
or:
.P
.B fsp.open
.RI [ fsp_opt ]
\fIspec\fP[\fB.lts\fP]
.RI [ cc_opt ]
.BR distributor
.RI [ distributor_opt ]
\fIconfiguration\fP[\fB.gcf\fP]
\fIresult\fP[\fB.pbg\fP]
.RI [ global_opt ]
.RI [ instance_opt ]
.P
or:
.P
.B lnt.open
.RI [ lnt_opt ]
\fIspec\fP[\fB.lnt\fP]
.RI [ cc_opt ]
.BR distributor
.RI [ distributor_opt ]
\fIconfiguration\fP[\fB.gcf\fP]
\fIresult\fP[\fB.pbg\fP]
.RI [ global_opt ]
.RI [ instance_opt ]
.P
or:
.P
.B lotos.open
.RI [ lotos_opt ]
\fIspec\fP[\fB.lotos\fP]
.RI [ cc_opt ]
.BR distributor
.RI [ distributor_opt ]
\fIconfiguration\fP[\fB.gcf\fP]
\fIresult\fP[\fB.pbg\fP]
.RI [ global_opt ]
.RI [ instance_opt ]
.P
or:
.P
.B seq.open
.RI [ seq_opt ]
\fIspec\fP[\fB.seq\fP]
.RI [ cc_opt ]
.BR distributor
.RI [ distributor_opt ]
\fIconfiguration\fP[\fB.gcf\fP]
\fIresult\fP[\fB.pbg\fP]
.RI [ global_opt ]
.RI [ instance_opt ]

.SH DESCRIPTION

This program performs exhaustive reachability analysis and generates the
Labelled Transition System corresponding to
the BCG graph \fIspec\fP\fB.bcg\fP,
the composition expression \fIspec\fP\fB.exp\fP,
the FSP program \fIspec\fP\fB.lts\fP,
the LNT program \fIspec\fP\fB.lnt\fP,
the LOTOS program \fIspec\fP\fB.lotos\fP,
or the SEQ file \fIspec\fP\fB.seq\fP.

.P
Additionally, this program can generate a reduced Labelled Transition System
by applying tau-compression or tau-confluence reductions on the fly.

.P
Compared to
.BR generator (LOCAL)
and
.BR reductor (LOCAL),
which are sequential programs executing on a single machine,
.B distributor
implements a distributed algorithm (derived from [GMS01]) that runs on several
machines listed in the grid configuration file \fIconfiguration\fP\fB.gcf\fP;
see
.BR gcf (LOCAL)
for information about the GCF format. Each machine is used to generate
and store a part of the Labelled Transition System. This allows
.B distributor
to exploit the computing resources (memory and processors) provided by many
machines.

.P
The current version of
.B distributor
does not handle LOTOS programs containing dynamic data types (such as lists,
trees, etc.) implemented using pointers, i.e., all LOTOS programs such that
the condition
.nf
   CAESAR_HASH_SIZE_STATE() < CAESAR_SIZE_STATE()
.fi
is verified, where the two functions \fBCAESAR_HASH_SIZE_STATE()\fP and 
\fBCAESAR_SIZE_STATE()\fP are defined in the
.BR caesar_graph (LOCAL)
application programming interface.

.P
All the machines used by
.B distributor
must have the same processor and operating system; for instance,
mixing little-endian and big-endian architectures is not allowed.

.P
As regards the communications between the machines,
.B distributor
does not make strong assumptions and only requires standard TCP sockets to
be available, together with at least one standard remote connection protocol 
(such as "rsh/rcp", "ssh/scp", "krsh"/"kcp", etc.). In particular,
.B distributor
does not require the existence of a common file system (e.g., NFS, Samba) 
shared between the machines.

.P
The machine on which
.B distributor
is launched (using the command line described in the SYNOPSIS section above)
is called the \fIlocal\fP machine. All other machines are called \fIremote\fP
machines. Depending on the contents of \fIconfiguration\fP\fB.gcf\fP,
.B distributor
will launch distributed processes, which are called \fIinstances\fP. 

.P
Typically, each instance executes on one remote machine, but there can be
also several instances per remote machine as well as some instances executing
on the local machine.

.P
The generated Labelled Transition System will be stored as a partitioned 
BCG graph \fIresult\fP\fB.pbg\fP; see 
.BR pbg (LOCAL)
for information about the PBG format. The resulting PBG file can later be
turned into a BCG file using the
.BR bcg_merge (LOCAL)
tool.

.SH OPTIONS

The options \fIbcg_opt\fP, if any, are passed to
.BR bcg_lib (LOCAL).

.P
The options \fIexp_opt\fP, if any, are passed to
.BR exp.open (LOCAL).

.P
The options \fIfsp_opt\fP, if any, are passed to
.BR fsp.open (LOCAL).

.P
The options \fIlnt_opt\fP, if any, are passed to
.BR lnt.open (LOCAL).

.P
The options \fIlotos_opt\fP, if any, are passed to
.BR caesar (LOCAL)
and to
.BR caesar.adt (LOCAL).

.P
The options \fIseq_opt\fP, if any, are passed to
.BR seq.open (LOCAL).

.P
The options \fIcc_opt\fP, if any, are passed to the C compiler.

.P
The following options \fIdistributor_opt\fP are currently available:

.TP
.B -taucompression
Perform tau-compression on the fly, which eliminates all cycles (i.e.,
strongly connected components) of "internal" transitions; such transitions
are usually noted "tau" in the scientific literature and displayed as the 
character string "\fBi\fP" by the various BCG tools. This elimination
is usually fast (linear in the size of the state space) and preserves
branching bisimulation.
Not a default option.

.TP
.B -tauconfluence
Perform tau-confluence on the fly, which is a partial order reduction
preserving branching simulation. Tau-confluence subsumes tau-compression,
thus leading to potentially stronger reductions, but it can be slower.
Not a default option.

.TP
.B -monitor
Open a window for monitoring in real-time the distributed generation of the
PBG, i.e., the progress status of each instance. The organization of 
the monitor window is described in section DISTRIBUTED MONITOR WINDOW below.
Not a default option.

.TP
.BI -display \ display
Connect to the X server \fIdisplay\fP for opening the monitor window. 
This option is only useful in conjunction with the \fB-monitor\fP option.
It overrides the current value, if any, of the \fB$DISPLAY\fP environment
variable, which gives, by default, the X server for opening the monitor
window. An erroneous value for \fIdisplay\fP may cause 
.B distributor
to abort. See
.BR X (7)
for details.
Not a default option.

.TP
.B -stat
Display various statistics during graph generation.
Not a default option.

.SH OPTIONS AFFECTING THE G\&C\&F INFORMATION

.P
To provide for last-minute changes, the contents of the grid configuration
file \fIconfiguration\fP\fB.gcf\fP can be extended and/or modified on the 
command line using the options \fIglobal_opt\fP and \fIinstance_opt\fP.

.P
The grid configuration file can even be empty, in which
case \fIconfiguration\fP\fB.gcf\fP should be replaced with "-" on
the command line (in such case \fIinstance_opt\fP should not be empty). 

.P
\fIglobal_opt\fP has the same syntax as the non-terminal \fB<global_opt>\fP
in the grammar of the 
.BR gcf (LOCAL)
format (keeping in mind that some characters meaningful to the shell must
be escaped or quoted properly). If it is non-empty, it is interpreted exactly
as if its contents were inserted in the grid configuration file, at the end of
the \fB<global_opt>\fP list and before the first \fB<instance_opt>\fP.

.P
\fIinstance_opt\fP has the same syntax as a possibly empty list of 
non-terminals \fB<instance_opt>\fP in the grammar of the 
.BR gcf (LOCAL)
format (keeping in mind that some characters meaningful to the shell must
be escaped or quoted properly). If it is non-empty, it is interpreted exactly
as if its contents were appended at the end of the grid configuration file,
after the last \fB<instance_opt>\fP.

.P
Thus, the value of the GCF variables can be set in five different ways, 
listed below by increasing precedence:

.IP -
default value,
.IP -
value given by \fB<global_opt>\fP in the grid configuration file,
.IP -
value given by \fIglobal_opt\fP on the command line,
.IP -
value given by \fB<instance_opt>\fP in the grid configuration file,
.IP -
value given by \fIinstance_opt\fP on the command line.

.SH DISTRIBUTED MONITOR WINDOW

The distributed monitor window started by the \fB-monitor\fP option is divided
into five tabs:

.IP - 
The "Overview" tab gives, for each instance, the number of explored states,
the number of remaining states, the number of transitions in the corresponding
BCG fragment, and the remaining state variation.
Explored states are those for which 
.B distributor
has already computed the successors. Remaining states are those visited by
.B distributor
but not explored yet. 
The remaining state variation is represented by a coloured box. 
A green box indicates that the number of remaining states is strictly increasing.
An orange box indicates that the number of remaining states is decreasing or stable.
A red box indicates that the instance has finished its computations (i.e.,
it is idle).
An instance which is currently idle may start computations again if it
receives new messages from another instance.
When all instances are idle and there are no more messages in transit, the
distributed exploration algorithm terminates.

.ce 1
see http://cadp.inria.fr/man/pictures/distributor1.jpg
.ce 1
.I "Overview" tab of the distributed monitor window

.IP -
The "Labels" tab displays all different labels encountered when firing
transitions during state space exploration. 

.ce 1
see http://cadp.inria.fr/man/pictures/distributor2.jpg
.ce 1
.I "Labels" tab of the distributed monitor window

.IP -
The "Progress" tab displays, for each instance, a progress bar indicating
the number of states explored for this instance.

.ce 1
see http://cadp.inria.fr/man/pictures/distributor3.jpg
.ce 1
.I "Progress" tab of the distributed monitor window

.IP -
The "Statistics" tab gives the total number of visited states, of remaining
states, etc.

.ce 1
see http://cadp.inria.fr/man/pictures/distributor4.jpg
.ce 1
.I "Statistics" tab of the distributed monitor window

.IP -
The "Resources" tab estimates, for each instance, the corresponding 
memory and CPU usage.

.ce 1
see http://cadp.inria.fr/man/pictures/distributor5.jpg
.ce 1
.I "Resources" tab of the distributed monitor window

.P
It is worth keeping in mind that using the distributed monitor may slow 
down the state space generation.

.SH EXIT STATUS
Exit status is 0 if everything is alright, 1 otherwise.

.SH DIAGNOSTICS
When the source is erroneous, error messages are issued. Additionally,
.B distributor
leaves "\fB.log\fP" files in the working directories on each machine;
these files may help understanding the reason of a problem.

.SH AUTHORS

Version 1.0 of \fBdistributor\fP was developed by Irina Smarandache-Sturm
(INRIA/VASY) along the lines of [GMS01].

.P
Version 2.0 of \fBdistributor\fP was developed by Adrian Curic (INRIA/VASY) 
and Gilles Stragier (INRIA/VASY).

.P
Version 3.0 of \fBdistributor\fP implements a modified algorithm by Christophe
Joubert (INRIA/VASY). It was rewritten from scratch by Nicolas Descoubes
(INRIA/VASY). Damien Bergamini (INRIA/VASY) made a few adaptations. Hubert
Garavel and Radu Mateescu fixed various issues and wrote the \fBdistributor\fP
manual page. 

.SH OPERANDS
.PD 0
.TP 20
.IB spec .bcg
BCG graph (input)
.TP
.IB spec .exp
network of communicating LTSs (input)
.TP
.IB spec .lts
FSP specification (input)
.TP
.IB spec .lnt
LNT specification (input)
.TP
.IB spec .lotos
LOTOS specification (input)
.TP
.IB spec .seq
SEQ file (input)
.TP
.IB configuration .gcf
grid configuration file (input)
.TP
.IB result .pbg
partitioned BCG graph (output)
.TP
.IB result -*.bcg 
BCG fragments (outputs)
.TP
.B distributor-*.log
log files (outputs)
.PD

.SH FILES

.P
The binary code of \fBdistributor\fP is available in $CADP/bin.`arch`/distributor.a

.P
The code for the distributed monitor window is available in 
$CADP/src/monitor/distributor.tcl

.SH SEE ALSO
OPEN/CAESAR Reference Manual,
.BR bcg (LOCAL),
.BR bcg_open (LOCAL),
.BR bcg_merge (LOCAL),
.BR caesar (LOCAL),
.BR caesar.adt (LOCAL),
.BR exp (LOCAL),
.BR exp.open (LOCAL),
.BR fsp.open (LOCAL),
.BR generator (LOCAL),
.BR lnt.open (LOCAL),
.BR lotos (LOCAL),
.BR lotos.open (LOCAL),
.BR pbg (LOCAL),
.BR seq (LOCAL),
.BR seq.open (LOCAL)

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

Please report bugs to cadp@inria.fr

.SH BIBLIOGRAPHY

.P
[GMS01] Hubert Garavel, Radu Mateescu, and Irina Smarandache. 
Parallel State Space Construction for Model-Checking.
In Matthew B. Dwyer, ed, Proceedings of the 8th International SPIN Workshop
on Model Checking of Software (SPIN'01), Toronto, Canada, LNCS 2057, pp.
217-234, May 2001. Revised version available as INRIA Research Report RR-4341,
December 2001. Available from
http://cadp.inria.fr/publications/Garavel-Mateescu-Smarandache-01.html

.P
[GMB+06] Hubert Garavel, Radu Mateescu, Damien Bergamini, Adrian Curic,
Nicolas Descoubes, Christophe Joubert, Irina Smarandache-Sturm, and
Gilles Stragier.
DISTRIBUTOR and BCG_MERGE: Tools for Distributed Explicit State Space
Generation.
In Holger Hermanns and Jens Palberg, eds., Proceedings of the 12th
International Conference on Tools and Algorithms for the Construction and
Analysis of Systems (TACAS'06), Vienna, Austria, LNCS 3920, pp. 445-449,
March-April 2006. Available from
http://cadp.inria.fr/publications/Garavel-Mateescu-Bergamini-et-al-06.html

.P
[GMS12] Hubert Garavel, Radu Mateescu, and Wendelin Serwe.
Large-scale Distributed Verification using CADP: Beyond Clusters to Grids.
Electronic Notes in Theoretical Computer Science, vol. 296, pp. 145-161,
August 2012. Available from
http://cadp.inria.fr/publications/Garavel-Mateescu-Serwe-12.html

