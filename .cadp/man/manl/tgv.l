.\" @(#)tgv.l - INRIA Rennes - 2020/02/12
.TH TGV LOCAL "2020/02/12" "(C) INRIA" "TGV MANUAL PAGES"
.fp 4 CB
.lg 0
.if t .so /usr/share/lib/tmac/ms.acc 
 \" L'instruction ci-dessus charge un jeu de macros Troff venant de l'ensemble
 \" de macros "ms" pour avoir les lettres accentuees en PostScript (dans cette
 \" page, on utilise les accents pour les noms propres et les prenoms). 
 \" Toutefois, il est probable que ces macros ne marchent que sur Sun, et
 \" de plus, pas dans les titres, tableaux...
.SH NAME
tgv \- Test Generation from transitions systems using Verification techniques 
 
.SH SYNOPSIS

.B bcg_open
[\fIbcg_opt\fP]
\fIspec\fP[\fB.bcg\fP]
.RI [ cc_opt ]
.B tgv
.RI [ tgv_opt ]
\fItp\fP[\fB.bcg\fP|\fB.aut\fP]
.P
or:
.P
.B exp.open
[\fIexp_opt\fP]
\fIspec\fP[\fB.exp\fP]
.RI [ cc_opt ]
.B tgv
.RI [ tgv_opt ]
\fItp\fP[\fB.bcg\fP|\fB.aut\fP]
.P
or:
.P
.B fsp.open
[\fIfsp_opt\fP]
\fIspec\fP[\fB.lts\fP]
.RI [ cc_opt ]
.B tgv
.RI [ tgv_opt ]
\fItp\fP[\fB.bcg\fP|\fB.aut\fP]
.P
or:
.P
.B lnt.open
[\fIlnt_opt\fP]
\fIspec\fP[\fB.lnt\fP]
.RI [ cc_opt ]
.B tgv
.RI [ tgv_opt ]
\fItp\fP[\fB.bcg\fP|\fB.aut\fP]
.P
or:
.P
.B lotos.open
[\fIlotos_opt\fP]
\fIspec\fP[\fB.lotos\fP]
.RI [ cc_opt ]
.B tgv
.RI [ tgv_opt ]
\fItp\fP[\fB.bcg\fP|\fB.aut\fP]
.P
or: 
.P
.B seq.open
[\fIseq_opt\fP]
\fIspec\fP[\fB.seq\fP]
.RI [ cc_opt ]
.B tgv
.RI [ tgv_opt ]
\fItp\fP[\fB.bcg\fP|\fB.aut\fP]

.SH DESCRIPTION
TGV allows the generation of an abstract test case from a specification and a test purpose. The generation is done "on-the-fly" on the synchronous product of the specification with the test purpose. It is based on Tarjan's algorithm. During the depth-first search (DFS), TGV performs abstraction and determinisation of this product. The DFS stops when an accepting state of test purpose is reached. During the backtracking, TGV synthesizes the transitions of the test case.   
.P
The specification and the test purpose are Inputs/Outputs Labeled Transition Systems (IOLTS).
The specification is either
the BCG graph \fIspec\fP\fB.bcg\fP,
the composition expression \fIspec\fP\fB.exp\fP,
the FSP program \fIspec\fP\fB.lts\fP,
the LNT program \fIspec\fP\fB.lnt\fP,
the LOTOS program \fIspec\fP\fB.lotos\fP,
or the sequence file \fIspec\fP\fB.seq\fP.
.P
The test purpose is described either in a BCG file 
.IB tp .bcg 
or in an \fBAUT\fP file 
.IB tp .aut .
.P
TGV uses the 
.BR bcg_io (LOCAL)
tool to transparently convert a test purpose in AUT format into the BCG format, and to transform the generated test case or complete test graph into the AUT format.

.SH B\&C\&G FORMAT
See the
.BR bcg (LOCAL)
manual page.

.SH A\&U\&T FORMAT 
See the
.BR aut (LOCAL)
manual page.

.SH TEST PURPOSES
A test purpose is an abstract description of a subset of the specification, allowing to choose behaviors to test, and consequently allowing to reduce the specification exploration. Final states of the test purpose graph are either accepting states (the purpose is reached) or refusing states (parts of the specification are rejected).
.P
Accepting (respectively refusing) states must be given as loop-transitions with the predefined label \fBACCEPT\fP or \fBaccept\fP (respectively \fBREFUSE\fP or \fBrefuse\fP). The purpose must own one accepting state at least.
.P
All action names are regular expressions (according to the definition given in the manual page of the POSIX
.BR regexp (LOCAL)).
The test purpose is written in accordance with the specification label names (before renaming and hidding). It can also have transitions labelled with invisible actions of the specification. 
.P
If the predefined label "\fB*\fP" (which means \fBotherwise\fP) is present on a transition leaving some state \fIs\fP, this label represents all other actions than those already present on the outgoing transitions of state \fIs\fP.
.P
So, for an AUT test purpose, a transition has the following grammar:

.ne 10v
.nf
.cs 4 23
.cs I 23

     \fB<transition> ::=
         '(' <from_state> ',' <action> ',' <to_state> ')'  |
         '(' <state> ',' 'ACCEPT'|'accept' ',' <state> ')' |
         '(' <state> ',' 'REFUSE'|'refuse' ',' <state> ')' |
         '(' <from_state> ',' '*' ',' <to_state> ')'
     
     <action> ::= <UNIX_regexp> 
               | '"' <UNIX_regexp> '"'\fP

.cs 4
.cs I
.fi
.P
Note: if the extension of the test purpose filename is omitted (or is different from \fB.bcg\fP and \fB.aut\fP), the file is first searched with \fB.bcg\fP extension and then with \fB.aut\fP extension.

.SH TEST CASES
If the test purpose is valid, i.e. allows to select sequences of the specification leading to an accepting state, TGV produces an LTS that is the description of the test graph in the BCG format (\fB.bcg\fP) or AUT (\fB.aut\fP) format.
.P
Actions labels of this LTS are based on those of the specification, plus some predefined labels as \fBLOCK, OUTPUTLOCK, DEADLOCK, LIVELOCK\fP used in lock transitions. 
A tag (\fBINPUT\fP or \fBOUTPUT\fP), seen from the tester's viewpoint, is added to each label. In some transitions, a verdict (\fBPASS\fP) or \fBPASS\fP or (\fBINCONCLUSIVE\fP) or \fBINCONCLUSIVE\fP is also added to the label.
.P
A \fBPASS\fP verdict on a transition means that in the state reached by this transition, the tester has detected no implementation error in the IUT.
.P
An \fBINCONCLUSIVE\fP verdict is present on a transition corresponding to a possible output of the specification that leads to a sequence not satisfying the test purpose.
.P
There is no \fBFAIL\fP verdict, as fail transitions are implicit (from each state, unrecognized actions lead to a \fBFAIL\fP state).
.P
A verdict not enclosed in parentheses means that the tester has reached a stable state from which no output of the implementation under test (IUT) is expected.

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
The options \fIcc_opt\fP, if any,  are passed to
.BR cc (1).
.P
The options \fItgv_opt\fP, if any, are passed to the TGV program.
.SH T\&G\&V OPTIONS
The following \fItgv_opt\fP are currently available:
.TP
.B -verbose\ \ \ \ \ \ \ 
Verbose mode: TGV displays information about the calculations going on. Not a default option.
.TP
\fB-io\fP \fIfile\fP[\fB.io\fP]
Specify the inputs/outputs of the specification, according to \fIfile\fP[\fB.io\fP] (in case of renaming with \fB-rename\fP option, the \fB.io\fP file must contain \fIrenamed\fP labels).
.TP
\fB-rename\fP \fIfile\fP[\fB.ren\fP|\fB.rename\fP]
Use the renaming rules defined in \fIfile\fP[\fB.ren\fP|\fB.rename\fP] to rename the labels of the product SPEC x TP.
.TP
\fB-hide\fP \fIfile\fP[\fB.hid\fP|\fB.hide\fP]
Use the hiding rules defined in \fIfile\fP[\fB.hid\fP|\fB.hide\fP] to hide some labels of the product SPEC x TP.
.TP
.B -tpprior\ \ \ \ 
Priority to actions of the test purpose. By default, the actions of the specification are prior.
.TP
.B -outprior\ \ \ \ 
Priority to the outputs. By default, the inputs are prior.
.TP
.B -self\ \ \ \ 
For each  state \fIs\fP of the test purpose such that \fIs\fP does not have, for each action \fIa\fP of the specification, an outgoing transition labelled with \fIa\fP, and \fIs\fP does not have an outgoing transition labelled with the predefined label "\fB*\fP", silently add on state \fIs\fP a self-loop transition labelled with "\fB*\fP". By default, such a self-loop transition is added too, but a warning message is emitted for each such state \fIs\fP.
.TP
.BI -hash \ n\ \ \ 
Fix the table hash size to \fIn\fP (by default, 100000). 
.TP
.BI -depth \ n
Fix the maximum preamble-body depth search to \fIn\fP.
.TP
\fB-output\fP \fIfile\fP[\fB.bcg\fP|\fB.aut\fP] [\fB-parse\fP|\fB-unparse\fP]
Specify the name\fIfile\fP[\fB.bcg\fP|\fB.aut\fP] of the output file in which TGV will display the test case. If the filename extension is \fB.aut\fP, the result is an AUT file. Otherwise, the result file is a BCG file with the \fB.bcg\fP extension. By default, the result is printed on the BCG file \fItgv_result\fP\fB.bcg\fP.
.br
\ 
.br
If the produced test case is in BCG format, options \fB-parse\fP 
and \fB-unparse\fP can be specified to control label parsing (see the
.BR bcg_write (LOCAL)
manual page for a technical discussion about label parsing). Option
\fB-parse\fP enables label parsing and option \fB-unparse\fP disables
label parsing. By default, label parsing is enabled.

.TP
.B -label
Display all fired labels. Notice that displaying all labels of the specification can be obtained by using this option with the following test purpose:
.nf
.cs 4 23
     \fBdes (0, 3, 2)
     (0, *, 0)
     (0, "dummy:", 1)
     (1, ACCEPT, 1)\fP.
.cs 4
.fi
.TP
.BR -keeplock\ \ \ \  
By default, TGV computes lock transitions (\fBLOCK\fP) and prints those that remain after conflicts have been resolved. Use \fB-keeplock\fP (without \fB-csg\fP) to keep all the computed locks (the produced test graph is no more completely controllable).
.TP
.BR -unlock | -difflock
Avoid the printing of lock transitions with option \fB-unlock\fP. Make difference between lock tags (\fBOUTPUTLOCK, DEADLOCK, LIVELOCK\fP) with option \fB-difflock\fP. 
.TP
.BR -csg | -unloop
Compute the complete test graph (option \fB-csg\fP) or compute a controllable test case without loop (option \fB-unloop\fP). By default, TGV computes controllable test cases with loops.
 
.TP
.B -post\ \ \ \ \ 
Search a postamble from pass and inconclusive states (i.e. a path to stable states in which no message from the IUT is expected).
.TP
.BI -postdepth  \ n
Fix the maximum postamble depth search to \fIn\fP.
.TP
.B -random \ \ \ 
Compute a random test case. Not a default option.
.TP
.BI -randomseed \ n
Use \fIn\fP as seed for random test-case generation.
.TP
.B -verif\ \ \ \ \ 
Do not annotate transition labels with input or output, nor with verdicts, but generate separate, self-looping verdict transitions for each verdict state. This option is incompatible with options \fB-timer\fP, \fB-difflock\fP, and \fB-unlock\fP.

.TP
.B -timer\ \ \ \ \ 
Produce a test case with test timers (TAC and TNOAC). TAC is started when the tester is waiting for an output from the IUT. TNOAC allows to detect a lock state of the IUT.      

.TP
.B -monitor\ \ \ \ \ 
Open a window for monitoring in real-time the generation of the test case or complete test graph.
Not a default option.

.TP
.B -parse\ \ \ \ \ 
Enable label parsing when reading files in the AUT format and/or writing
files in the BCG format (see the
.BR bcg_write (LOCAL)
manual page for a technical discussion about label parsing).
Note that this also applies to the implicit conversions of command-line arguments in the AUT format.
Default option.

.TP
.B -unparse\ \ \ \ \ 
Disable label parsing when reading files in the AUT format and/or writing
files in the BCG format (see the
.BR bcg_write (LOCAL)
manual page for a technical discussion about label parsing).
Note that this also applies to the implicit conversions of command-line arguments in the AUT format.
Not a default option.

.SH I/O FILE

It is recommended to write an \fB.io\fP file, to distinguish between inputs and outputs. The \fB.io\fP file describes a set of actions, according to the following grammar:
.ne 6v
.nf
.cs 4 23
.cs I 23

       \fB<file.io> ::= 'input' | 'output' \\n <regexp-list>

       <regexp-list> ::= <regexp> \\n <regexp-list>
                       | "<regexp>" \\n <regexp-list>
                       | <empty>\fP

.cs 4
.cs I
.fi
.P
Semantically, if the first line is equal to \fBinput\fP (respectively \fBoutput\fP), the body of the file describes all the inputs actions (respectively all outputs actions). 
.P
Note: If option \fB-io\fP is not given, TGV uses by default the file \fB$CADP/src/tgv/default.io\fP the contents of which are:
.nf
.cs 4 23
.cs I 23

           \fBinput         
           [^!]*[?].*\fP
.cs 4
.cs I
.fi
.P

.SH HIDE FILE

This is an optional input file. See the
.BR caesar_hide_1 (LOCAL)
manual page for the grammar description and examples.

.SH RENAME FILE
This is an optional input file. See the
.BR caesar_rename_1 (LOCAL)
manual page for the grammar description and examples.
.P
Note 1: renaming patterns are applied \fIbefore\fP hiding patterns. Renaming and hiding patterns are applied after the synchronous product SPECxTP.
.P
Note 2: the 
.B .io
file must be written in accordance with the 
.B .ren
(or
.B .rename
) and
.B .hid
(or 
.B .hide
) files (because the \fB.io\fP file is read after the renaming and hiding).

.SH T\&G\&V MESSAGES
If TGV produces a test case,  the execution finishes with the following message: "\fBFile\fP\ \fIfile\fP\ \fBproduced\fP". Otherwise, the message "\fBNo\ test\ case\fP" is printed: may be it is because the test purpose is not valid, or because of an error in the description of files
.B .io
or
.B .hid
or
.B .ren

.SH AUTHORS
Thierry Je\*'ron (Thierry.Jeron@irisa.fr), Pierre Morel, and Se\*'verine Simon.
A few patches were brought by Wendelin Serwe and Hubert Garavel in December 
2004. Since then, TGV has been ported to 64-bit architectures and regularly
maintained by Wendelin Serwe and Hubert Garavel.

.SH SEE ALSO
OPEN/CAESAR Reference Manual,
.BR bcg (LOCAL),
.BR bcg_open (LOCAL),
.BR caesar (LOCAL),
.BR caesar.adt (LOCAL),
.BR exp (LOCAL),
.BR exp.open (LOCAL),
.BR fsp.open (LOCAL),
.BR lnt.open (LOCAL),
.BR lotos (LOCAL),
.BR lotos.open (LOCAL),
.BR seq (LOCAL),
.BR seq.open (LOCAL)

.SH BUGS
Please report any bug to cadp@inria.fr

