'\" t
.\" @(#)exp.open.l - VASY and CONVECS teams - 2020/02/11
.TH EXP.OPEN LOCAL "2020/02/11" "(C) INRIA" "CADP MANUAL PAGES"
.fp 4 CB
.lg 0

.cs 4 23

.SH NAME
exp.open \- OPEN/CAESAR connection for EXP networks of communicating automata

.SH SYNOPSIS
.BR exp.open
[\fB-branching\fP | \fB-deadpreserving\fP | \fB-strong\fP | \fB-weaktrace\fP]
[\fB-case\fP]
[\fB-debug\fP]
[\fB-lotos\fP | \fB-elotos\fP | \fB-ccs\fP | \fB-csp\fP | \fB-mcrl\fP]
[\fB-hidden\fP \fIstring\fP]
[\fB-termination\fP \fIstring\fP]
[\fB-coaction\fP \fIstring\fP]
[\fB-depend\fP]
[\fB-history\fP]
[\fB-info\fP] 
[\fB-inline\fP] 
[\fB-interface\fP \fIinterface_directives\fP]
[\fB-interfaceuser\fP] 
[\fB-labels\fP]
[\fB-network\fP \fIformat\fP]
[\fB-nocheck\fP]
[\fB-prob\fP]
[\fB-rate\fP]
[\fB-silent\fP | \fB-verbose\fP]
[\fB-unparse\fP]
[\fB-version\fP]
\fIfilename\fP[\fB.exp\fP]
.RI [ cc_options ]
\fIprog\fP[\fB.a\fP|\fB.c\fP|\fB.o\fP]
.RI [ prog_options ]

.SH DESCRIPTION
Taking as input
.IB filename .exp, 
which describes a network of communicating automata in the EXP 2.0, see
.BR exp (LOCAL),
and an OPEN/CAESAR program \fIprog\fP[\fB.a\fP|\fB.c\fP|\fB.o\fP], \fBexp.open\fP generates an OPEN/CAESAR graph module
.IB filename .c .
This file is then compiled into
.IB filename .o
and an executable program \fIprog\fP resulting from the combination of
.IB filename .o
and \fIprog\fP[\fB.a\fP|\fB.c\fP|\fB.o\fP] is produced.
Finally, \fIprog\fP is executed.
.sp
According to the principles of the OPEN/CAESAR architecture, \fIprog\fP is
obtained by combining three different modules:

.IP -
the graph module is generated from \fIfilename\fP\fB.exp\fP

.IP -
the storage module is the standard OPEN/CAESAR library

.IP -
the exploration module is \fIprog\fP[\fB.a\fP|\fB.c\fP|\fB.o\fP]

.SH PROCESSING OF THE EXPLORATION MODULE
The exploration module \fIprog\fP[\fB.a\fP|\fB.c\fP|\fB.o\fP] is
supposed to contain an OPEN/CAESAR application program, such as
.BR evaluator (LOCAL),
.BR generator (LOCAL),
.BR ocis (LOCAL)...
.P
The exploration module can be supplied in three different forms. It can
be either an archive file (with \fB.a\fP suffix), or a source C program 
(with \fB.c\fP suffix) or an object code file (with \fB.o\fP suffix).
.P
If \fIprog\fP\fB.a\fP is not present in the current directory, \fBexp.open\fP
attempts to fetch it in the OPEN/CAESAR binary library \fB$CADP/bin.`arch`\fP.
.P
If \fIprog\fP\fB.c\fP is not present in the current directory, \fBexp.open\fP
attempts to fetch it in the OPEN/CAESAR source library \fB$CADP/src/open_caesar\fP.
.P
If \fIprog\fP\fB.o\fP
is not present in the current directory, \fBexp.open\fP attempts to
fetch it in the OPEN/CAESAR binary library \fB$CADP/bin.`arch`\fP.
.P
If no suffix (\fB.a\fP, \fB.c\fP, \fB.o\fP) is specified on the command 
line for the exploration module \fIprog\fP, \fBexp.open\fP will make
successive attempts to fetch this exploration module: first, as a source 
C program with \fB.c\fP suffix; then as an archive file with \fB.a\fP suffix;
finally as an object code file with \fB.o\fP suffix.

.SH OPTIONS

.TP
.B -branching
Perform on-the-fly partial order reduction modulo branching bisimulation.
This yields a generally smaller graph, which is equivalent modulo branching
bisimulation to the graph obtained using the \fB-strong\fP option. The used 
technique is based on prioritization of so-called \fItau-confluent\fP 
transitions [Pace-Lang-Mateescu-03]. This is not a default option.
.sp
If the \fB-branching\fP option is used in combination with \fB-rate\fP, then
also attempt on-the-fly partial order reduction modulo stochastic branching
bisimulation (which is weaker than branching bisimulation), by giving priority
to hidden actions over stochastic transitions (see the \fB-rate\fP option
below), thus taking an account of the maximal progress of hidden actions.

.TP
.B -case 
Force the distinction between lowercase and uppercase characters in labels occurring within the operators used in \fIfilename\fP\fB.exp\fP.
This is the default option if no reference language is selected or if the reference language is E-LOTOS or mCRL.
In other cases, labels occurring within the operators used in \fIfilename\fP\fB.exp\fP are automatically turned to uppercase.
Therefore, labels in LTSs should also be uppercase, except possibly the strings representing the hidden label, termination label, co-action prefix, and the "prob" and "rate" keywords used to denote probabilistic and stochastic transitions (see the \fB-prob\fP and \fB-rate\fP options below).

.TP
.B -ccs \ \ \ 
Set CCS as the reference language. This is not a default option.
See Section LANGUAGE PARAMETERS of 
.BR exp (LOCAL)
for details.

.TP
.B -coaction\ \fIstring\fP
Set \fIstring\fP so as to prefix CCS co-action labels;
\fIstring\fP is named \fIco-action prefix\fP.
See Section CCS PARALLEL COMPOSITION of
.BR exp (LOCAL)
for more information about the co-action prefix.

.TP
.B -csp \ \ \ 
Set CSP as the reference language. This is not a default option.
See Section LANGUAGE PARAMETERS of
.BR exp (LOCAL)
for details.

.TP
.B -deadpreserving
Perform on-the-fly partial order reduction preserving deadlocks. This yields
a generally smaller graph, which contains the same deadlocks as the graph
obtained using the \fB-strong\fP option. This is not a default option.

.TP
.B -debug
Undocumented option.

.TP
.B -depend
Display the list of EXP files included (directly or transitively) in \fIfilename\fP\fB.exp\fP, followed by the list of communicating automata, hide, rename, and cut files used in the EXP behaviour and stop.
This list may be incomplete if the EXP behaviour is syntactically incorrect.
Not a default option.

.TP
.B -elotos
Set E-LOTOS as the reference language. This is not a default option.
See Section LANGUAGE PARAMETERS of
.BR exp (LOCAL)
for details.

.TP
.B -hidden\ \fIstring\fP
Set \fIstring\fP as denoting the hidden label in BCG files of both the communicating automata and of the automaton corresponding to their composition.
The default value depends on the reference language, see Section LANGUAGE PARAMETERS of
.BR exp (LOCAL)
for details.
.sp
Note that many CADP tools (such as for instance
.BR bcg_min (LOCAL),
.BR aldebaran (LOCAL),
etc.) require the hidden label to be written "i".
If it is written differently, e.g., "tau", then one may use the "-hidden i" option and hide "tau" in each communicating automaton, by using the hiding operator of EXP 2.0.
.sp
Note also that the hidden label is usually written "tau" in the FC2 format.  During conversion from FC2 communicating automata into BCG, "tau" labels are automatically renamed into "i" by the
.BR bcg_io (LOCAL)
tool.
Therefore, since bcg_io is systematically called to translate FC2 components into the BCG format, the hidden label should be set to "i", using "-hidden i", even though some component is in the FC2 format, with "tau" denoting the hidden label.

.TP
.B -history
Record a history of each label.
The history can be read using the CAESAR_INFORMATION_LABEL function of the OPEN/CAESAR API. 
With the \fB-history\fP option, it is possible to set FORMAT_LABEL (see the OPEN/CAESAR manual) to a natural number up to 3 (instead of 2 otherwise):
.sp
o The behaviour of CAESAR_INFORMATION_LABEL with FORMAT_LABEL set to 0 or 1 is described in the OPEN/CAESAR documentation.
.sp
o If FORMAT_LABEL is equal to 2, then information about the synchronisations involved in the computation of each label is displayed under the form of a \fIsynchronisation vector\fP.
.sp
o If FORMAT_LABEL is equal to 3, then the displayed synchronisation vector is extended with information about hidings and renamings performed to produce the label.
.sp
This is not a default option.

.TP
.B -info
Print structural information about the LTSs referenced in \fIfilename\fP\fB.exp\fP and stop. See
.BR bcg_info (LOCAL)
for more information.

.TP
.B -inline
Generate an OPEN/CAESAR graph module that does not depend on BCG files.
This option cannot be combined with \fB-branching\fP, \fB-deadpreserving\fP, \fB-weaktrace\fP, and/or the priority operator.
Debugging option, not available in official releases of CADP.

.TP
.B -interface \fIinterface_directives\fP
This option allows to generate a refined interface as explained in the article [Lang-06].
.sp
This option assumes that the composition of LTSs stored in \fIfilename\fP\fB.exp\fP corresponds to a system of concurrent processes \fIS\fP as follows: The concurrent architecture of \fIfilename\fP\fB.exp\fP is the same as the concurrent architecture of \fIS\fP, and each LTS in \fIfilename\fP\fB.exp\fP represents either the state space (named concrete LTS in the sequel) or simply the set of labels (named abstract LTS in the sequel) of the corresponding process in \fIS\fP;
States and transitions of abstract LTSs are irrelevant.
.sp
Consider processes \fIP0, P1, ..., Pm\fP of \fIS\fP, such that, in \fIfilename\fP\fB.exp\fP, the LTS corresponding to \fIP0\fP is abstract and the LTSs corresponding to \fIP1, ..., Pm\fP are concrete.
The \fB-interface\fP option allows to synthesize an interface representing the synchronization constraints imposed on \fIP0\fP by \fIP1, ..., Pm\fP.
This interface has the form of an OPEN/CAESAR graph module stored in a file named \fIfilename\fP\fB.c\fP and a list of synchronisation labels stored in a file named \fIfilename\fP\fB.sync\fP.
The graph module can be translated into an explicit LTS using the
.BR generator (LOCAL)
tool.
The resulting LTS can then be given, together with \fIfilename\fP\fB.sync\fP, to the
.BR projector (LOCAL)
tool so as to restrict the behaviour of \fIP0\fP.
.sp
The \fIinterface_directives\fP argument has the form \fI"nat:nat_list"\fP, where \fInat\fP is a natural number and \fInat_list\fP is a list of natural numbers separated by blank characters. 
Each of these natural numbers is an index corresponding to the rank of occurrence of an LTS in \fIfilename\fP\fB.exp\fP (once eventual \fB.exp\fP file names have been substituted by the expression stored in the corresponding \fB.exp\fP files).
Index 1 represents the leftmost LTS.
The left-hand side of ":" is the index of the LTS corresponding to \fIP0\fP.
The right-hand side of ":" is the list of indices of the LTSs corresponding to \fIP1, ..., Pm\fP.
\fIinterface_directives\fP must be parsed as a single argument on the command line and thus must be enclosed in quotes.

.TP
.B -interfaceuser
Indicate that some of the automata in \fIfilename\fP\fB.exp\fP have been obtained by semi-composition with
"user-given" restriction interfaces, and compute the associated validation
predicates.
Note that this option does not make sense outside a compositional verification process using restriction interfaces.
See 
.BR projector (LOCAL)
and
.BR svl (LOCAL)
for more information about using restriction interfaces.
This is not a default option.

.TP
.B -labels
Display the number of labels followed by the list of labels potentially occurring in the state space of the input network of communicating automata and stop.
If the \fB-interfaceuser\fP option is set, do not print the labels representing validation predicates (see \fB-interfaceuser\fP option).

.TP
.B -lotos
Set LOTOS as the reference language. This is not a default option.
See Section LANGUAGE PARAMETERS of
.BR exp (LOCAL)
for details.

.TP
.B -mcrl
Set mCRL as the reference language. This is not a default option.
See Section LANGUAGE PARAMETERS of
.BR exp (LOCAL)
for details.

.TP
.B -network \fIformat\fP
Generate a network equivalent to \fIfilename\fP\fB.exp\fP in one of "nupn", "pep", "tina", "fc2", or "txt" \fIformat\fP and stop:
.sp
If \fIformat\fP is "nupn", \fBexp.open\fP generates a file named \fIfilename\fP\fB.nupn\fP, containing a Petri net in the NUPN (\fINested Unit Petri Net\fP) file format [Garavel-15-a] (see
.BR caesar.bdd (LOCAL)
for a description of the NUPN format);
.sp
If \fIformat\fP is "pep", \fBexp.open\fP generates a file named \fIfilename\fP\fB.ll_net\fP, containing a Petri net in the low-level PEP file format [Best-Grahlmann-98];
.sp
If \fIformat\fP is "tina", \fBexp.open\fP generates a file named \fIfilename\fP\fB.tpn\fP, containing a Petri net in the ``tpn'' format of the TINA toolbox [Berthomieu-Ribet-Vernadat-04];
.sp
If \fIformat\fP is "fc2", \fBexp.open\fP generates a file named \fIfilename\fP\fB.fc2\fP, containing a network of automata in the FC2 format [Bouali-Ressouche-Roy-deSimone-96].
.sp
If \fIformat\fP is "txt", \fBexp.open\fP generates a file named \fIfilename\fP\fB.txt\fP, containing a description of the network of automata in an undocumented textual format.
This description includes the list of files containing the communicating automata, the list of labels potentially occurring in the product and, for each label, the list of synchronization vectors.
.sp
The 
.BR bcg_io (LOCAL)
and \fBfc2link\fP tools are called internally to make the conversion from EXP to FC2.
Note however that \fBfc2link\fP is not provided within CADP but belongs to the Fc2Tools distribution, which can be downloaded at http://www-sop.inria.fr/meije/verification.
.sp
Moreover, when converting EXP to FC2, the hidden event must be written "i" (see \fB-hidden\fP option above and Section LANGUAGE PARAMETERS of
.BR exp (LOCAL)
for details) because this is required by 
.BR bcg_io (LOCAL)
and \fBfc2link\fP.
.sp
This option does not require an exploration module.
This is not a default option.
.sp
This option is not available if \fIfilename\fP\fB.exp\fP contains a priority operator.

.TP
.B -nocheck
Parsing of EXP behaviours is generally followed by a static semantics verification phase to verify that behaviours are well-formed.
Option \fB-nocheck\fP skips this verification phase.
This option should be used with caution since the semantics of ill-formed behaviours is undefined.
This is not a default option.

.TP
.B -prob
Consider the LTSs composed in \fIfilename\fP\fB.exp\fP as "probabilistic LTSs" (see the
.BR bcg_min (LOCAL)
manual page for details about probabilistic LTSs).
Labels of the form "prob %p" or "\fIlabel\fP; prob %p", where %p denotes a floating-point number in the range ]0..1] and \fIlabel\fP denotes a  character string that does not contain the ";" character, are interpreted as "special" transitions, named "probabilistic".
With this option, probabilistic transitions can always execute asynchronously.
If a parallel composition attempts to synchronize probabilistic transitions explicitly, then \fBexp.open\fP issues a warning message.

.TP
.B -rate
Consider the LTSs composed in \fIfilename\fP\fB.exp\fP as "stochastic LTSs" (see the
.BR bcg_min (LOCAL)
manual page for details about stochastic LTSs).
Labels of the form "rate %f" or "\fIlabel\fP; rate %f", where %f denotes a stricly positive floating-point number and \fIlabel\fP denotes a  character string that does not contain the ";" character, are interpreted as "special" transitions, named "stochastic".
With this option, stochastic transitions can always execute asynchronously.
If a parallel composition attempts to synchronize stochastic transitions explicitly, then \fBexp.open\fP issues a warning message.

.TP
.B -ratebranching
This option is obsolete and should be replaced by the combination of options
\fB-rate -branching\fP.

.TP
.B -silent
Execute silently. Opposite of \fB-verbose\fP. Default option is \fB-verbose\fP.

.TP
.B -strong
Do not perform partial order reduction of the graph.
This is a default option.

.TP
.B -termination \fIstring\fP
Set \fIstring\fP as denoting the gate used to express behaviour termination.
The default value depends on the reference language, see Section LANGUAGE PARAMETERS of
.BR exp (LOCAL)
for details.

.TP
.B -unparse
Use the "\fB-bcg -unparse\fP" options of \fBbcg_io\fP while converting LTSs in AUT, FC2, or SEQ formats into BCG.
See the
.BR bcg_io (LOCAL)
manual page for details about these options.

.TP
.B -verbose
Report activities and progress, including errors, to the user's screen.
Opposite of \fB-silent\fP.
Default option is \fB-verbose\fP.

.TP
.B -version
Display the version number and stop.

.TP
.B -weaktrace
Perform on-the-fly partial order reduction modulo weak trace equivalence.
This yields a generally smaller graph, which is equivalent modulo weak trace
equivalence to the graph obtained using the \fB-strong\fP option.
This is not a default option.

.TP
.I cc_options
if any, are passed to the C compiler.
.TP
.I prog_options
if any, are passed to \fIprog\fP.

.SH EXIT STATUS
Exit status is 0 if everything is all right, > 0 otherwise.

.SH BIBLIOGRAPHY

.IP [Berthomieu-Ribet-Vernadat-04]
B. Berthomieu, P.-O. Ribet, and F. Vernadat.
The tool TINA - Construction of Abstract State Spaces for Petri Nets and 
Time Petri Nets.
In International Journal of Production Research, Vol. 42, No 14, July 2004.

.IP [Best-Grahlmann-98]
Eike Best and Bernd Grahlmann.
"PEP Documentation and User Guide."
http://parsys.informatik.uni-oldenburg.de/~pep/paper.html. 1998."

.IP [Bouali-Ressouche-Roy-deSimone-96]
Amar Bouali, Annie Ressouche, Valerie Roy, and Robert de Simone.
The Fc2Tools set: a Toolset for the Verification of Concurrent Systems.
In R. Alur and T.A. Henzinger, editors, Proceedings of the 8th Conference on Computer-Aided Verification (New Brunswick, New Jersey, USA). Lecture Notes in Computer Science volume 1102, Springer-Verlag, 1996.

.IP [Brookes-Hoare-Roscoe-84]
S. D. Brookes, C. A. R. Hoare, and A. W. Roscoe.
"A Theory of Communicating Sequential Processes."
In Journal of the ACM, vol. 31, number 3, pages 560-599. ACM, 1984.

.IP [Garavel-15-a]
Hubert Garavel.
"Nested-Unit Petri Nets: A Structural Means to Increase Efficiency and Scalability of Verification on Elementary Nets."
In R. Devillers and A. Valmari, editors, Proceedings of the 36th International Conference on Application and Theory of Petri Nets and Concurrency (Brussels, Belgium). Lecture Notes in Computer Science volume 9115, Springer-Verlag, 2015.
Available from http://cadp.inria.fr/publications/Garavel-15-a.html

.IP [Garavel-Sighireanu-99]
Hubert Garavel and Mihaela Sighireanu.
"A Graphical Parallel Composition Operator for Process Algebras." 
In J. Wu, Q. Gao, and S.T. Chanson, editors, Proceedings of the Joint International Conference on Formal Description Techniques for Distributed Systems and Communication Protocols, and Protocol Specification, Testing, and Verification FORTE/PSTV'99 (Beijing, China).
Kluwer Academic Publishers, 1999.
Available from http://cadp.inria.fr/publications/Garavel-Sighireanu-99.html

.IP [Groote-Ponse-90]
J.F. Groote and A. Ponse.
"The syntax and semantics of mCRL."
In A. Ponse, C. Verhoef and S.F.M. van Vlijmen, editors, Algebra of Communicating Processes '94, Workshops in Computing Series, Springer-Verlag, pp. 26-62, 1995.
Also appeared as: Technical Report CS-R9076, CWI, Amsterdam, 1990.

.IP [ISO-89]
ISO/IEC.
"LOTOS --- A Formal Description Technique Based on the Temporal	Ordering of Observational Behaviour."
International Organization for Standardization --- Information Processing Systems --- Open Systems Interconnection.
International Standard number 8807.
Geneva, September 1989.

.IP [ISO-01]
ISO/IEC.
"Enhancements to LOTOS (E-LOTOS)."
International Organization for Standardization --- Information Technology.
International Standard number 15437:2001.
Geneva, September 2001.

.IP [Lang-05]
Frederic Lang.
"EXP.OPEN 2.0: A Flexible Tool Integrating Partial Order, Compositional, and On-the-fly Verification Methods."
In J. van de Pol, J. Romijn and G. Smith, editors, Proceedings of the 5th International Conference on Integrated Formal Methods IFM'2005 (Eindhoven, The Netherlands).
Lecture Notes in Computer Science volume 3771, Springer-Verlag, 2005.
Available from http://cadp.inria.fr/publications/Lang-05.html

.IP [Lang-06]
Frederic Lang.
"Refined Interfaces for Compositional Verification."
In E. Najm, J.-F. Pradat-Peyre and V. Viguie Donzeau-Gouge, editors, Proceedings of the 26th IFIP WG 6.1 International Conference on Formal Techniques for Networked and Distributed Systems FORTE'2006 (Paris, France).
Lecture Notes in Computer Science volume 4229, Springer-Verlag, 2006.
Available from http://cadp.inria.fr/publications/Lang-06.html

.IP [Milner-89]
Robin Milner. 
"Communication and Concurrency." 
Prentice-Hall, 1989.

.IP [Pace-Lang-Mateescu-03]
Gordon Pace, Frederic Lang, and Radu Mateescu.
"Calculating tau-confluence compositionally."
In W.A. Hunt Jr. and F. Somenzi, editors, 15th Computer-Aided Verification conference (CAV 2003), Lecture Notes in Computer Science volume 2725, Springer-Verlag, 2003.
Available from http://cadp.inria.fr/publications/Pace-Lang-Mateescu-03.html

.SH AUTHORS

Versions 1.*: Marius Bozga, Jean-Claude Fernandez, and Laurent Mounier.
.P
Versions 2.*: Frederic Lang and Hubert Garavel.

.SH OPERANDS
.PD 0
.TP 20
.IB filename .exp
network of communicating automata (input)
.TP
.IB filename .c
graph module for filename.exp (output)
.TP
.IB filename .fc2 
FC2 network (output, with \fB-network fc2\fP option)
.TP
.IB filename .ll_net 
low level PEP Petri net (output, with \fB-network pep\fP option)
.TP
.IB filename .nupn 
NUPN Petri net (output, with \fB-network nupn\fP option)
.TP
.IB filename .tpn 
TINA Petri net (output, with \fB-network tina\fP option)
.TP
.IB prog .a\ \ \ \ \ \ 
exploration module (archive, input)
.TP
.IB prog .c\ \ \ \ \ \ 
exploration module (source, input)
.TP
.IB prog .o\ \ \ \ \ \ 
exploration module (object code, input)
.TP
.IB prog\ \ \ \ \ \ 
executable program (output)
.PD

.SH FILES
.PD 0
.TP 31
.B $CADP/com/exp.open
``exp.open'' shell script
.TP
.B $CADP/bin.`arch`/libexp_open.a
``exp.open'' static library
.TP
.B $CADP/bin.`arch`/exp2c
``exp.open'' graph module generator
.TP
.B $CADP/incl/caesar_*.h
OPEN/CAESAR interfaces
.TP
.B $CADP/bin.`arch`/libcaesar.a
OPEN/CAESAR library
.TP
.B $CADP/src/open_caesar/*.c
exploration modules (source)
.TP
.B $CADP/bin.`arch`/*.a
exploration modules (archive)
.TP
.B $CADP/bin.`arch`/*.o
exploration modules (object code)
.PD

.SH SEE ALSO

.BR aldebaran (LOCAL), 
.BR aut (LOCAL), 
.BR bcg (LOCAL), 
.BR bcg_io (LOCAL), 
.BR caesar_hide_1 (LOCAL), 
.BR caesar_rename_1 (LOCAL), 
.BR exp (LOCAL),
.BR lotos.open (LOCAL), 
.BR projector (LOCAL), 
.BR regexp (LOCAL), 
.BR seq (LOCAL), 
.BR svl (LOCAL)
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
Please report bugs to cadp@inria.fr

