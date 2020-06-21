.\" @(#)exhibitor.l - VASY and CONVECS teams - 2020/02/12
.TH EXHIBITOR LOCAL "2020/02/12" "(C) INRIA" "CADP MANUAL PAGES"
.fp 4 CB
.lg 0
.SH NAME
exhibitor \- search for execution sequences matching a given pattern

.SH SYNOPSIS
.B bcg_open
.RI [ bcg_opt ]
\fIspec\fP[\fB.bcg\fP] 
.RI [ cc_opt ]
.B exhibitor
.RI [ exhibitor_opt ]
.P
or:
.P
.B exp.open
[\fIexp_opt\fP]
\fIspec\fP[\fB.exp\fP] 
[\fIcc_opt\fP]
.B exhibitor
.RI [ exhibitor_opt ]
.P
or:
.P
.B fsp.open
[\fIfsp_opt\fP]
\fIspec\fP[\fB.lts\fP]
[\fIcc_opt\fP]
.B exhibitor
.RI [ exhibitor_opt ]
.P
or:
.P
.B lnt.open
[\fIlnt_opt\fP]
\fIspec\fP[\fB.lnt\fP]
[\fIcc_opt\fP]
.B exhibitor
.RI [ exhibitor_opt ]
.P
or:
.P
.B lotos.open
.RI [ lotos_opt ]
\fIspec\fP[\fB.lotos\fP]
.RI [ cc_opt ]
.B exhibitor
.RI [ exhibitor_opt ]
.P
or: 
.P
.B seq.open
[\fIseq_opt\fP]
\fIspec\fP[\fB.seq\fP]
.RI [ cc_opt ]
.B exhibitor
.RI [ exhibitor_opt ]

.SH DESCRIPTION
\fBexhibitor\fP takes two different inputs:

.IP -
A Labelled Transition System, expressed either as 
a BCG graph \fIspec\fP\fB.bcg\fP,
a composition expression \fIspec\fP\fB.exp\fP,
an FSP program \fIspec\fP\fB.lts\fP,
a LNT program \fIspec\fP\fB.lnt\fP,
a LOTOS program \fIspec\fP\fB.lotos\fP,
or a sequence file \fIspec\fP\fB.seq\fP.

.IP -
A "pattern" (or "goal"), expressed in the full SEQ format described
in the
.BR seq (LOCAL)
manual page. By default, this
pattern is read from the standard input (under UNIX, the input stream 
should end up with a 'control-D' character; under Windows, it should 
end with a 'control-Z' character). Alternately, the pattern can be 
stored in a file, e.g., \fIfilename\fP\fB.seq\fP (the "\fB.seq\fP" 
suffix is not mandatory, but strongly advisable), in which case this 
file can be passed to \fBexhibitor\fP (under UNIX, the stream redirection
notation "\fB< \fP\fIfilename\fP\fB.seq\fP" can be used for this purpose).
.P
.B exhibitor
performs an on-the-fly search in the Labelled Transition System (LTS),
looking for execution sequences (also called "diagnostic sequences")
that start from the initial state and match the specified pattern.

.P
.B exhibitor
displays on the standard output, in the simple SEQ format, the diagnostic
sequence(s) found, if any. If no diagnostic sequence has been found,
.B exhibitor
displays an empty result (this case is covered by the simple SEQ format).

.P
If the input pattern is empty (which is allowed by the syntax of the
full SEQ format),
.B exhibitor
stops immediately, as no diagnostic sequence can be found.

.P
If the input pattern contains more than one \fBsequence\fP
(see the
.BR seq (LOCAL)
manual page for details),
.B exhibitor
only searches for a single one, according to the number supplied with
the \fB-seqno\fP option.

.P
In the CADP toolbox, the SEQ format is the standard format for
diagnostic sequences. Many CADP tools take their inputs and/or
deliver their outputs in this format. Unfortunately, such diagnostic
sequences are not necessarily
as short as possible and some information might have been lost (e.g.,
sequences of \fBi\fP-transitions have been compacted or eliminated,
the original gate names corresponding to \fBi\fP-transitions have
vanished, etc.).
.P
In many cases, \fBexhibitor\fP solves these problems by allowing to
find the shortest sequence matching a given pattern and by providing
the source-level information which has been lost.  It is also useful
for verification and test purpose, because it can search and display
automatically an execution scenario defined by a given pattern.


.SH SEARCH ALGORITHMS

.B exhibitor
implements two different search algorithms, one based on a
breadth-first search (BFS) and another one based on a depth-first
search (DFS). Both algorithms have their own merits. Here is a brief
comparison:

.IP - 
The BFS algorithm always produces the shortest diagnostic sequence(s)
(if any) that match the given pattern.

.IP - 
The DFS algorithm does not necessarily produce the shortest diagnostic
sequence (because in '*'-groups, the states are visited only once).
Moreover, as this algorithm is programmed using a recursive C function, 
.B exhibitor
may abort with a core dump if the execution stack overflows. In such
case, the maximal depth should be limited using the \fB-depth\fP
option (see below).
.P
Two small examples will illustrate the differences between both algorithms.
Let S be the sequence \fB'<until> "exit"'\fP. 

.IP -
Let's consider the LTS corresponding to the LOTOS behaviour:
.nf
        \fBL1; L2; exit [] L3; exit\fP
.fi

The BFS algorithm will find the optimal solution:
.nf
        \fBL3; exit\fP
.fi
in a few steps, whereas the DFS algorithm might very well explore entirely 
the longest path:
.nf
        \fBL1; L2; exit\fP
.fi
before finding a better solution. Also, if there are *-s in the sequence
to be searched and circuits in the LTS, the sequence found by the DFS 
algorithm might not be minimal.

.IP -
Let's  consider the LTS corresponding to the LOTOS behaviour:
.nf
        \fBL1; exit ||| L2; exit ||| ... ||| Ln; exit \fP
.fi

The DFS algorithm will directly find a solution in n+1 steps, whereas
the BFS will have to explore and store all the 2^n possible interleavings of
transitions \fBL1, ..., Ln\fP before finding a solution. 

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
The following options \fIexhibitor_options\fP are currently available:

.TP
.BI -seqno \ number
Select the \fInumber\fP-th sequence in the input stream as the pattern
to be searched for. \fInumber\fP should be a non-zero, positive
integer.  It should be less than or equal to the number of sequences
contained in the input stream. By default, the first sequence will be
selected.

.TP
.BI -depth \ depth
Consider only execution sequences whose number of transitions is less
than or equal to \fIdepth\fP (where \fIdepth\fP is greater than
zero). Prune the exploration of the graph when the distance from the
initial state becomes greater than \fIdepth\fP transitions. By default
(if this option is not present on the command-line) or if \fIdepth\fP
is equal to zero, all sequences will be considered.

.TP
.B -conflict
When the search is done, print information about those labels that
created non-determinism conflicts, solved in a deterministic way (see
the
.BR seq (LOCAL)
manual page for details). Not a default option.

.TP
.B -case\ \ \ \ \ \ 
Preserve case-sensitivity in the \fBstring\fPs
and \fBregular_expression\fPs specified in the input stream. Not a default
option. By default, all lower-case letters contained in \fBstring\fPs
and \fBregular_expression\fPs are turned to upper case, except for the
special gates \fB"i"\fP and \fB"exit"\fP  (see the
.BR seq (LOCAL)
manual page for details).

.TP
.B -bfs\ \ \ \ \ \ 
Use the breadth-first search algorithm. Default option. 

.TP
.B -dfs\ \ \ \ \ \ 
Use the depth-first search algorithm. Not a default option.

.TP 
.B -none\ \ \ \ \ \ 
Don't print any diagnostic sequence. Not a default option.

.TP 
.B -all\ \ \ \ \ \ 
Print all diagnostic sequences. With the BFS algorithm,
all the printed sequences are minimal. Not a default option.

.TP
.B -first\ \ \ \ \ \ 
Print the first diagnostic sequence encountered and stop just after. 
Not a default option for the DFS algorithm.

.TP
.B -decr\ \ \ \ \ \ 
For the BFS algorithm: this option is identical to \fB-first\fP.
.sp
For the DFS algorithm: print only those diagnostic sequences which are 
shorter than the last diagnostic sequence previously displayed. Prune the 
exploration of the graph in order to find diagnostic sequences of decreasing 
sizes. It is not guaranteed that the final sequence is minimal (some shorter 
sequence might exist, which can not be found by the DFS algorithm). Not
a default option for the DFS algorithm.

.TP
.I by\ default
(in absence of
.BR -none ,
.BR -all ,
.BR -first ,
.BR -decr )
For the BFS algorithm: default is identical to \fB-first\fP.
.sp
For the DFS algorithm: print only the shortest diagnostic sequence obtained. 
Prune the exploration of the graph in order to find diagnostic sequences of 
decreasing sizes. It is not guaranteed that the final sequence is minimal 
(some shorter sequence might exist, which can not be found by the program).

.SH EXIT STATUS
When the source is erroneous, error messages are issued.  Exit status
is 0 if everything is alright, 1 otherwise.

.SH AUTHORS
Version 1 of \fBexhibitor\fP was developed by Hubert Garavel (INRIA Rhone-Alpes).
.P
Version 2 of \fBexhibitor\fP was developed by Hubert Garavel and
Xavier Etchevers, with the help of Radu Mateescu.

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
sequence file (input)
.TP
.I (standard\ input)
pattern in SEQ format (input)
.PD
.SH FILES
The binary code of \fBexhibitor\fP is available in $CADP/bin.`arch`/exhibitor.a
.P

.SH SEE ALSO
.P
OPEN/CAESAR Reference Manual,
.BR bcg (LOCAL),
.BR bcg_open (LOCAL),
.BR caesar (LOCAL),
.BR caesar.adt (LOCAL),
.BR caesar_graph (LOCAL),
.BR exp (LOCAL),
.BR exp.open (LOCAL),
.BR fsp.open (LOCAL),
.BR lnt.open (LOCAL),
.BR lotos (LOCAL),
.BR lotos.open (LOCAL),
.BR seq (LOCAL),
.BR seq.open (LOCAL)

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

