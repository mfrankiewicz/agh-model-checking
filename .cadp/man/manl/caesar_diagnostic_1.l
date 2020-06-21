'\" t
.\" @(#)caesar_diagnostic_1.l - VASY and CONVECS teams - version 1.1
.TH caesar_diagnostic_1 LOCAL "2020/02/11 (version 1.1)" "(C) INRIA" "OPEN/CAESAR MANUAL"
.fp 4 CB
.lg 0
.SH NAME
caesar_diagnostic_1 \- the ``diagnostic_1'' library of OPEN/CAESAR
.SH PURPOSE
The ``diagnostic_1'' library provides primitives for managing diagnostics.
.sp
.SH USAGE
The ``diagnostic_1'' library consists of:
.IP -
a predefined header file \fBcaesar_diagnostic_1.h\fP;
.IP -
the precompiled library file \fBlibcaesar.a\fP, which implements the features described in \fBcaesar_diagnostic_1.h\fP.
.P
Note: The ``diagnostic_1'' library is a software layer built above the primitives offered by the ``standard'', ``edge'' and ``stack_1'' libraries, and by the \fIOPEN/CAESAR\fP graph module.
.sp
Note: The ``diagnostic_1'' library relies on the ``edge'' and ``stack_1'' libraries. Therefore, when using the ``diagnostic_1'' library, there are restrictions concerning the use of the ``edge'' and ``stack_1'' library primitives. These restrictions are listed in the sequel.
.sp
.SH DESCRIPTION
A ``diagnostic'' is an execution sequence, i.e., a list of states and transitions starting from the initial state of the graph and leading to a given state.
.sp
The ``size'' of a diagnostic is defined to be the number of states (not the number of transitions) in the corresponding execution sequence. This definition is compatible with the convention used for function \fBCAESAR_DEPTH_STACK_1()\fP.
.sp
Diagnostics are to be used during depth-first graph exploration. For this reason, this library uses (and is compatible with) stacks provided by the ``stack_1'' library. Let's consider, for instance, an \fIOPEN/CAESAR\fP user program that searches for deadlocks. Every time a deadlock state is detected, the appropriate diagnostic is the contents of the stack, i.e., the execution sequence leading from the initial state to the current deadlock state.
.sp
The ``diagnostic_1'' allows to control the way diagnostics are printed. For instance, it allows to display only the shortest diagnostic sequence detected. Other ``strategies'' are also available. The data structure used to store diagnostics and related information is called a ``diagnostic structure''.
.sp
.SH FEATURES
.P
 ............................................................
.SS \fBCAESAR_TYPE_DIAGNOSTIC_1\fP
 \&
.nf
\fBtypedef CAESAR_TYPE_ABSTRACT (...) CAESAR_TYPE_DIAGNOSTIC_1;
\fP
.fi
This type denotes a pointer to the concrete representation of a diagnostic structure, which is supposed to be ``opaque''.
.P
 ............................................................
.SS \fBCAESAR_TYPE_STRATEGY_DIAGNOSTIC_1\fP
 \&
.nf
\fBtypedef enum {
     CAESAR_NONE_DIAGNOSTIC_1,
     CAESAR_ALL_DIAGNOSTIC_1,
     CAESAR_FIRST_DIAGNOSTIC_1,
     CAESAR_DECREASING_DIAGNOSTIC_1,
     CAESAR_SHORTEST_DIAGNOSTIC_1
}    CAESAR_TYPE_STRATEGY_DIAGNOSTIC_1;
\fP
.fi
This enumerated type defines the ``strategy'' used to print diagnostics during graph exploration. Two steps are to be distinguished: every time an execution sequence of interest is detected, it is ``recorded'' using the \fBCAESAR_RECORD_DIAGNOSTIC_1()\fP function defined below. When the depth-first exploration is completed, a ``summary request'' is performed using the \fBCAESAR_SUMMARIZE_DIAGNOSTIC_1()\fP function defined below. The effect of these two functions depends on the chosen strategy:
.sp
.IP -
With \fBCAESAR_NONE_DIAGNOSTIC_1\fP, only the result of the exploration is printed (i.e., some diagnostic has been found or not). Diagnostics themselves are not printed.
.IP -
With \fBCAESAR_ALL_DIAGNOSTIC_1\fP, all diagnostics are printed when they are recorded.
.IP -
With \fBCAESAR_FIRST_DIAGNOSTIC_1\fP, only the first diagnostic is printed when it is recorded; the next ones will not be printed.
.IP -
With \fBCAESAR_DECREASING_DIAGNOSTIC_1\fP, the first diagnostic is printed when it is recorded; the next ones will be printed iff their size is strictly smaller than all previously recorded diagnostics.
.IP -
With \fBCAESAR_SHORTEST_DIAGNOSTIC_1\fP, diagnostics are not printed when they are recorded, but the diagnostic with the smallest size is stored in a diagnostic structure. This shortest diagnostic (if any) will be printed when a summary request is emitted.
.P
.P
 ............................................................
.SS \fBCAESAR_CREATE_DIAGNOSTIC_1\fP
 \&
.nf
\fBvoid CAESAR_CREATE_DIAGNOSTIC_1 (CAESAR_D, CAESAR_STRATEGY,
                                 CAESAR_DEPTH, CAESAR_FILE,
                                 CAESAR_PROGRESS, CAESAR_HEADER,
                                 CAESAR_FOOTER, CAESAR_SEPARATOR,
                                 CAESAR_REPORT)
   CAESAR_TYPE_DIAGNOSTIC_1 *CAESAR_D;
   CAESAR_TYPE_STRATEGY_DIAGNOSTIC_1 CAESAR_STRATEGY;
   CAESAR_TYPE_NATURAL CAESAR_DEPTH;
   CAESAR_TYPE_FILE CAESAR_FILE;
   CAESAR_TYPE_STRING CAESAR_PROGRESS;
   CAESAR_TYPE_STRING CAESAR_HEADER;
   CAESAR_TYPE_STRING CAESAR_FOOTER;
   CAESAR_TYPE_STRING CAESAR_SEPARATOR;
   CAESAR_TYPE_STRING CAESAR_REPORT;
   { ... }
\fP
.fi
This procedure allocates a diagnostic structure using \fBCAESAR_CREATE()\fP and assigns its address to \fB*CAESAR_D\fP. If the allocation fails, the \fBNULL\fP value is assigned to \fB*CAESAR_D\fP.
.sp
Note: because \fBCAESAR_TYPE_DIAGNOSTIC_1\fP is a pointer type, any variable \fBCAESAR_D\fP of type \fBCAESAR_TYPE_DIAGNOSTIC_1\fP must be allocated before used, for instance using:
.TS
center;
l.
 
 \fBCAESAR_CREATE_DIAGNOSTIC_1 (&CAESAR_D, ...);\fP 
 
.TE
.sp
Note: Before calling this procedure, the \fBCAESAR_INIT_STACK_1()\fP procedure of the ``stack_1'' library should have been invoked (because the ``diagnostic_1'' library uses the ``stack_1'' library). Also, the restrictions concerning the \fBCAESAR_INIT_STACK_1()\fP procedure should be observed.
.sp
The actual values of the remaining formal parameters will be stored and associated to the diagnostic structure pointed to by \fB*CAESAR_D\fP.
.sp
The value of \fBCAESAR_STRATEGY\fP determines the strategy used for this diagnostic structure.
.sp
The value of \fBCAESAR_DEPTH\fP determines the ``maximal depth'' used for this diagnostic structure, i.e., an upper bound on the sizes of the diagnostics. If \fBCAESAR_DEPTH\fP is equal to zero, there is no upper bound.
.sp
The value of \fBCAESAR_FILE\fP determines the output file to which the diagnostics will be printed. Before any diagnostic is printed, \fBCAESAR_FILE\fP must have been properly opened, for instance using \fBfopen(3)\fP.
.sp
The values of \fBCAESAR_PROGRESS\fP, \fBCAESAR_HEADER\fP, \fBCAESAR_FOOTER\fP, \fBCAESAR_SEPARATOR\fP, and \fBCAESAR_REPORT\fP are character strings to be used for printing the diagnostics. The exact semantics of these parameters will not be defined here. For interoperability with the other tools of the CADP toolset (see the \fBseq\fP manual page for a definition of the SEQ format), it is advised to use the following actual values:
.sp
 \&
.nf
\fB   CAESAR_PROGRESS  = "*** sequence(s) found at depth "
   CAESAR_HEADER    = "*** sequence found at depth %u\en\en\e001<initial state>\e002\en"
   CAESAR_FOOTER    = "\e001<goal state>\e002\en\en"
   CAESAR_SEPARATOR = "[]\en\en"
   CAESAR_REPORT    = "*** no sequence found\en\en"
\fP
.fi
or, depending on the context:
.sp
 \&
.nf
\fB    CAESAR_PROGRESS  = "*** deadlock(s) found at depth "
    CAESAR_HEADER    = "*** deadlock found at depth %u\en\en\e001<initial state>\e002\en"
    CAESAR_FOOTER    = "<deadlock>\en\en"
    CAESAR_SEPARATOR = "[]\en\en"
    CAESAR_REPORT    = "*** no deadlock found\en\en"
\fP
.fi
.P
 ............................................................
.SS \fBCAESAR_DELETE_DIAGNOSTIC_1\fP
 \&
.nf
\fBvoid CAESAR_DELETE_DIAGNOSTIC_1 (CAESAR_D)
   CAESAR_TYPE_DIAGNOSTIC_1 *CAESAR_D;
   { ... }
\fP
.fi
This procedure frees the memory space corresponding to the diagnostic structure pointed to by \fB*CAESAR_D\fP using \fBCAESAR_DELETE()\fP. Afterwards, the \fBNULL\fP value is assigned to \fB*CAESAR_D\fP.
.P
 ............................................................
.SS \fBCAESAR_RECORD_DIAGNOSTIC_1\fP
 \&
.nf
\fBvoid CAESAR_RECORD_DIAGNOSTIC_1 (CAESAR_D, CAESAR_K)
   CAESAR_TYPE_DIAGNOSTIC_1 CAESAR_D;
   CAESAR_TYPE_STACK_1 CAESAR_K;
   { ... }
\fP
.fi
This procedure records into the diagnostic structure pointed to by \fB*CAESAR_D\fP the diagnostic contained in the stack pointed to by \fB*CAESAR_K\fP. The stack pointed to by \fB*CAESAR_K\fP should contain at least one item (the initial state of the sequence); if it is empty, the result is undefined. The effects of this procedure depend on the strategy and maximal depth associated with the diagnostic structure:
.sp
.IP -
With \fBCAESAR_NONE_DIAGNOSTIC_1\fP, the diagnostic is not printed but stored into the diagnostic structure.
.IP -
With \fBCAESAR_ALL_DIAGNOSTIC_1\fP, the diagnostic is immediately printed.
.IP -
With \fBCAESAR_FIRST_DIAGNOSTIC_1\fP, the diagnostic is immediately printed if it is the first one to be recorded; otherwise nothing is done.
.IP -
With \fBCAESAR_DECREASING_DIAGNOSTIC_1\fP, the diagnostic is immediately printed if its size is less or equal than the maximal depth (if the maximal depth is not equal to zero) and strictly less than the sizes of all previously recorded diagnostics.
.IP -
With \fBCAESAR_SHORTEST_DIAGNOSTIC_1\fP, the diagnostic is not printed but stored into the diagnostic structure if its size os less or equal than the maximal depth (if the maximal depth is not equal to zero) and strictly less than the sizes of all previously recorded diagnostics.
If the character string \fBCAESAR_PROGRESS\fP specified for \fB*CAESAR_D\fP is not the \fBNULL\fP pointer, it is printed, together with the size of the recorded diagnostic.
.P
.P
 ............................................................
.SS \fBCAESAR_SUMMARIZE_DIAGNOSTIC_1\fP
 \&
.nf
\fBvoid CAESAR_SUMMARIZE_DIAGNOSTIC_1 (CAESAR_D)
   CAESAR_TYPE_DIAGNOSTIC_1 CAESAR_D;
   { ... }
\fP
.fi
This procedure summarizes the current status of the diagnostic structure pointed to by \fB*CAESAR_D\fP. The effects of this procedure depends on the strategy associated with the diagnostic structure:
.sp
.IP -
With \fBCAESAR_NONE_DIAGNOSTIC_1\fP, the result of the exploration is displayed: if diagnostics have been recorded, the size of the most recently recorded one is printed; otherwise, the character string \fBCAESAR_REPORT\fP is printed if no diagnostic has been recorded into the diagnostic structure.
.IP -
With \fBCAESAR_ALL_DIAGNOSTIC_1\fP, the character string \fBCAESAR_REPORT\fP is printed if no diagnostic has been previously recorded into the diagnostic structure.
.IP -
With \fBCAESAR_FIRST_DIAGNOSTIC_1\fP, same as for \fBCAESAR_ALL_DIAGNOSTIC_1\fP.
.IP -
With \fBCAESAR_DECREASING_DIAGNOSTIC_1\fP, same as for \fBCAESAR_ALL_DIAGNOSTIC_1\fP.
.IP -
With \fBCAESAR_SHORTEST_DIAGNOSTIC_1\fP, the shortest diagnostic recorded is printed, or the character string \fBCAESAR_REPORT\fP is printed if no diagnostic has been recorded into the diagnostic structure.
.P
.P
 ............................................................
.SS \fBCAESAR_EMPTY_DIAGNOSTIC_1\fP
 \&
.nf
\fBCAESAR_TYPE_BOOLEAN CAESAR_EMPTY_DIAGNOSTIC_1 (CAESAR_D)
   CAESAR_TYPE_DIAGNOSTIC_1 CAESAR_D;
   { ... }
\fP
.fi
This function returns the boolean value \fBCAESAR_TRUE\fP iff at least one diagnostic has been previously recorded (using the \fBCAESAR_RECORD_DIAGNOSTIC_1()\fP function) into the diagnostic structure pointed to by \fB*CAESAR_D\fP.
.P
 ............................................................
.SS \fBCAESAR_BACKTRACK_DIAGNOSTIC_1\fP
 \&
.nf
\fBCAESAR_TYPE_BOOLEAN CAESAR_BACKTRACK_DIAGNOSTIC_1 (CAESAR_D, CAESAR_DEPTH)
   CAESAR_TYPE_DIAGNOSTIC_1 CAESAR_D;
   CAESAR_TYPE_NATURAL CAESAR_DEPTH;
   { ... }
\fP
.fi
This function returns the boolean value \fBCAESAR_TRUE\fP iff the exploration should stop and backtrack when reaching depth \fBCAESAR_DEPTH\fP. For instance, in a depth-first search, the actual value of \fBCAESAR_DEPTH\fP should be equal to the current depth of the stack. The result depends on the strategy and maximal depth associated with the diagnostic structure pointed to by \fB*CAESAR_D\fP:
.sp
.IP -
With \fBCAESAR_NONE_DIAGNOSTIC_1\fP, the result is \fBCAESAR_TRUE\fP iff \fBCAESAR_DEPTH\fP is strictly greater than the maximal depth (if the maximal depth is not equal to zero).
.IP -
With \fBCAESAR_ALL_DIAGNOSTIC_1\fP, same as for \fBCAESAR_NONE_DIAGNOSTIC_1\fP.
.IP -
With \fBCAESAR_FIRST_DIAGNOSTIC_1\fP, the result is \fBCAESAR_TRUE\fP iff \fBCAESAR_DEPTH\fP is strictly greater than the maximal depth (if the maximal depth is not equal to zero) or if some diagnostic has been previously recorded into the diagnostic structure.
.IP -
With \fBCAESAR_DECREASING_DIAGNOSTIC_1\fP, the result is \fBCAESAR_TRUE\fP iff \fBCAESAR_DEPTH\fP is strictly greater than the maximal depth (if the maximal depth is not equal to zero) or if it is greater or equal to the size of some previously recorded diagnostic.
.IP -
With \fBCAESAR_SHORTEST_DIAGNOSTIC_1\fP, same as for \fBCAESAR_DECREASING_DIAGNOSTIC_1\fP.
.P
.P
 ............................................................
.SH AUTHOR(S)
Hubert Garavel
.SH FILES
.PD 0
.TP 30
.B $CADP/incl/caesar_graph.h
interface of the graph module
.TP
.B $CADP/incl/caesar_*.h
interfaces of the storage module
.TP
.B $CADP/bin.`arch`/libcaesar.a
object code of the storage module
.TP
.B $CADP/src/open_caesar/*.c
source code of various exploration modules
.TP
.B $CADP/com/lotos.open
shell script to run OPEN/CAESAR
.PD
.SH SEE ALSO
Reference Manuals of OPEN/CAESAR, CAESAR, and CAESAR.ADT,
.BR lotos.open (LOCAL),
.BR caesar (LOCAL),
.BR caesar.adt (LOCAL)
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
Known bugs are described in the Reference Manual of OPEN/CAESAR.
Please report new bugs to cadp@inria.fr
