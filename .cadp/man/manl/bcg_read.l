.\" @(#)bcg_read.l - VASY and CONVECS teams - 2013/09/09
.TH BCG_READ LOCAL "2013/09/09" "(C) INRIA" "CADP MANUAL PAGES"
.fp 4 CB
.lg 0
.SH NAME
bcg_read \- a simple interface to read a BCG graph 
.SH DESCRIPTION
This interface reads a BCG graph from an application
program written in C or C++. To keep things simple, this interface 
views states as unsigned integer numbers and labels as character
strings. Note: this subset of BCG is equivalent to the \fB.aut\fP format
described in the
.BR aldebaran (LOCAL)
manual page, although it is much more compact.
.P
.SH USAGE
The application program should start with the following directive:
.P
\fB   #include "bcg_user.h"\fP
.P
Then the BCG library should be initialized by invoking the
following function:
.P
\fB   BCG_INIT ();\fP
.P
Not invoking this function might cause a run-time error, e.g., 
a segmentation fault. Invoking \fBBCG_INIT()\fP more than once is harmless,
although not recommended. 

.SH DATA TYPES
In order to read a BCG graph, declare a data structure
having the type \fBBCG_TYPE_OBJECT_TRANSITION\fP (this type is provided by
the "bcg_user.h" file), which contains information related to the graph.
Assuming that this data structure will be named \fIbcg_graph\fP, this
declaration will have the following form:
.P
\fB    BCG_TYPE_OBJECT_TRANSITION \fP\fIbcg_graph\fP\fB;\fP
.P
Note: this interface is reentrant, in the sense that several BCG graphs
can be read concurrently, provided that each BCG graph is associated
with a distinct data structure of type \fBBCG_TYPE_OBJECT_TRANSITION\fP.
.P
The functions of this interface also use the followings types, whose definitions
are provided by the "bcg_user.h" file:
.TP 
\fB    BCG_TYPE_BOOLEAN\fP
.TP 
\fB    BCG_TYPE_NATURAL\fP
.TP 
\fB    BCG_TYPE_C_STRING\fP
.TP 
\fB    BCG_TYPE_FILE_NAME\fP
.TP 
\fB    BCG_TYPE_STATE_NUMBER\fP
.TP 
\fB    BCG_TYPE_LABEL_NUMBER\fP
.TP 
\fB    BCG_TYPE_EDGE_NUMBER\fP

.SH FEATURES
.P
 ............................................................
.P
.SS \fBBCG_OT_READ_BCG_BEGIN\fP
 \&
.nf
\fB BCG_OT_READ_BCG_BEGIN (\fP\fIfilename\fP\fB, \fP\fIbcg_graph\fP\fB, \fP\fIaccess_mode\fP\fB)\fP
\fB
  BCG_TYPE_FILE_NAME         \fP\fIfilename\fP\fB;
  BCG_TYPE_OBJECT_TRANSITION *\fP\fIbcg_graph\fP\fB;
  BCG_TYPE_NATURAL           \fP\fIaccess_mode\fP\fB;
  { ... }
\fP
.fi
This function opens a BCG file. 
.TP
.I filename
is a character string containing the path name
of the BCG file to be read. It should contain the  "\fB.bcg\fP" suffix
(if the "\fB.bcg\fP" suffix is missing, it will be added automatically);
.TP
.I bcg_graph
is a pointer to the data structure which will become associated with
the BCG graph and into which information about the BCG graph will be
stored;
.TP
.I access_mode
is an integer indicating which kind of primitives are expected for
exploring the transition relation of the BCG graph.
.P
There are several possible values for \fIaccess_mode\fP:
.TP 
0:
should be used when it is only necessary to enumerate the edges in the BCG
graph.
.TP 
1:
should be used when one has to enumerate the successors of a given state.
.TP 
2:
should be used when one has to enumerate the predecessors of a given state.
.TP 
3:
should be used when one has to enumerate both the successors and predecessors
of a given state.
.TP 
4:
is similar to value 3, but uses a different data structure.
.P
By default, if \fIfilename\fP cannot be opened for reading,
\fBBCG_OT_READ_BCG_BEGIN()\fP will emit an error message and exit the
program. However, if the following function call:
.P
\fB    BCG_OT_READ_BCG_SURVIVE (BCG_TRUE);\fP
.P
has occured before the call to \fBBCG_OT_READ_BCG_BEGIN()\fP,
then \fBBCG_OT_READ_BCG_BEGIN()\fP will neither emit an error message 
nor exit the program, but return normally with its \fIbcg_graph\fP
parameter set to \fBNULL\fP if and only if \fIfilename\fP cannot 
be opened.
.P
Below, we assume that the \fI*bcg_graph\fP data structure has
been properly assigned after a successful invocation of the
\fBBCG_OT_READ_BCG_BEGIN()\fP function.
.P
 ............................................................
.P
.SS \fBBCG_OT_READ_BCG_SURVIVE\fP
 \&
.nf
\fB BCG_OT_READ_BCG_SURVIVE (\fP\fImode\fP\fB)\fP
\fB
  BCG_TYPE_BOOLEAN \fP\fImode\fP\fB;
  { ... }
\fP
.fi
This function controls how the \fBBCG_OT_READ_BCG_BEGIN()\fP function defined
above will behave if the BCG file cannot be opened for writing:
.IP -
If \fImode\fP equals \fBBCG_FALSE\fP, then \fBBCG_OT_READ_BCG_BEGIN()\fP
will emit an error message and exit the program. This is the default
behaviour.
.IP -
If \fImode\fP equals \fBBCG_TRUE\fP, then \fBBCG_OT_READ_BCG_BEGIN()\fP
will neither emit an error message nor exit the program, but return a
boolean result. The default behaviour can be restored by calling:
.P
\fB    BCG_OT_READ_BCG_SURVIVE (BCG_FALSE);\fP
.P
 ............................................................
.P
.SS \fBBCG_OT_INITIAL_STATE\fP
 \&
.nf
\fB BCG_TYPE_STATE_NUMBER BCG_OT_INITIAL_STATE (\fP\fIbcg_graph\fP\fB)\fP
\fB
  BCG_TYPE_OBJECT_TRANSITION \fP\fIbcg_graph\fP\fB;
  { ... }
\fP
.fi
This function returns the number of the initial state of the BCG graph.
.P
 ............................................................
.P
.SS \fBBCG_OT_NB_STATES\fP
 \&
.nf
\fB BCG_STATE_NUMBER BCG_OT_NB_STATES (\fP\fIbcg_graph\fP\fB)\fP
\fB
  BCG_TYPE_OBJECT_TRANSITION \fP\fIbcg_graph\fP\fB;
  { ... }
\fP
.fi
This function returns the number of states of the BCG graph. States are given unique
numbers in the range \fB\&0\fP to
\fBBCG_OT_NB_STATES (\fP\fIbcg_graph\fP\fB) - 1\fP.
.P
 ............................................................
.P
.SS \fBBCG_OT_NB_EDGES\fP
 \&
.nf
\fB BCG_TYPE_EDGE_NUMBER BCG_OT_NB_EDGES (\fP\fIbcg_graph\fP\fB)\fP
\fB
  BCG_TYPE_OBJECT_TRANSITION \fP\fIbcg_graph\fP\fB;
  { ... }
\fP
.fi
This function returns the number of edges (i.e., transitions) of the BCG
graph. Edges are given unique numbers in the range \fB\&0\fP to
\fBBCG_OT_NB_EDGES (\fP\fIbcg_graph\fP\fB) - 1\fP.
.P
 ............................................................
.P
.SS \fBBCG_OT_NB_LABELS\fP
 \&
.nf
\fB BCG_TYPE_LABEL_NUMBER BCG_OT_NB_LABELS (\fP\fIbcg_graph\fP\fB)\fP
\fB
  BCG_TYPE_OBJECT_TRANSITION \fP\fIbcg_graph\fP\fB;
  { ... }
\fP
.fi
This function returns the number of labels of the BCG graph. Labels are given unique
numbers in the range \fB\&0\fP to \fBBCG_OT_NB_LABELS (\fP\fIbcg_graph\fP\fB) - 1\fP.
.P
 ............................................................
.P
.SS \fBBCG_OT_LABEL_STRING\fP
 \&
.nf
\fB BCG_TYPE_C_STRING BCG_OT_LABEL_STRING (\fP\fIbcg_graph,
                                        bcg_label_number\fP\fB)\fP
\fB
  BCG_TYPE_OBJECT_TRANSITION \fP\fIbcg_graph\fP\fB;
  BCG_TYPE_LABEL_NUMBER      \fP\fIbcg_label_number\fP\fB;
  { ... }
\fP
.fi
This function returns a character string denoting the label
whose index is \fIbcg_label_number\fP.
It assumes \fIbcg_label_number\fP belongs to the range \fB\&0\fP to
\fBBCG_OT_NB_LABELS (\fP\fIbcg_graph\fP\fB) - 1\fP.
.P
 ............................................................
.P
.SS \fBBCG_OT_LABEL_VISIBLE\fP
 \&
.nf
\fB BCG_TYPE_BOOLEAN BCG_OT_LABEL_VISIBLE (\fP\fIbcg_graph,
                                        bcg_label_number\fP\fB)\fP
\fB
  BCG_TYPE_OBJECT_TRANSITION \fP\fIbcg_graph\fP\fB;
  BCG_TYPE_LABEL_NUMBER      \fP\fIbcg_label_number\fP\fB;
  { ... }
\fP
.fi
This function returns a boolean that is equal to \fBBCG_FALSE\fP 
if the label whose index is \fIbcg_label_number\fP is not visible, 
or \fBBCG_TRUE\fP if this label is visible.
It assumes \fIbcg_label_number\fP belongs to the range \fB\&0\fP to
\fBBCG_OT_NB_LABELS (\fP\fIbcg_graph\fP\fB) - 1\fP.
.P
 ............................................................
.P
.SS \fBBCG_OT_LABEL_GATE\fP
 \&
.nf
\fB BCG_TYPE_C_STRING BCG_OT_LABEL_GATE (\fP\fIbcg_graph,
                                        bcg_label_number\fP\fB)\fP
\fB
  BCG_TYPE_OBJECT_TRANSITION \fP\fIbcg_graph\fP\fB;
  BCG_TYPE_LABEL_NUMBER      \fP\fIbcg_label_number\fP\fB;
  { ... }
\fP
.fi
This function returns a character string that is equal to \fB"i"\fP 
if the label whose index is \fIbcg_label_number\fP is not visible, 
or to the gate (i.e., first element) of this label if this label is 
visible.
It assumes \fIbcg_label_number\fP belongs to the range \fB\&0\fP to
\fBBCG_OT_NB_LABELS (\fP\fIbcg_graph\fP\fB) - 1\fP.
.P
 ............................................................
.P
.SS \fBBCG_OT_LABEL_HIDDEN_GATE\fP
 \&
.nf
\fB BCG_TYPE_C_STRING BCG_OT_LABEL_HIDDEN_GATE (\fP\fIbcg_graph,
                                        bcg_label_number\fP\fB)\fP
\fB
  BCG_TYPE_OBJECT_TRANSITION \fP\fIbcg_graph\fP\fB;
  BCG_TYPE_LABEL_NUMBER      \fP\fIbcg_label_number\fP\fB;
  { ... }
\fP
.fi
This function returns a character string that is equal to \fB""\fP 
if the label whose index is \fIbcg_label_number\fP is visible, 
or to the gate (i.e., first element) of this label (if any) before
it was hidden.
It assumes \fIbcg_label_number\fP belongs to the range \fB\&0\fP to
\fBBCG_OT_NB_LABELS (\fP\fIbcg_graph\fP\fB) - 1\fP.
.P
 ............................................................
.P
.SS \fBBCG_OT_LABEL_CARDINAL\fP
 \&
.nf
\fB BCG_TYPE_NATURAL BCG_OT_LABEL_CARDINAL (\fP\fIbcg_graph,
                                        bcg_label_number\fP\fB)\fP
\fB
  BCG_TYPE_OBJECT_TRANSITION \fP\fIbcg_graph\fP\fB;
  BCG_TYPE_LABEL_NUMBER      \fP\fIbcg_label_number\fP\fB;
  { ... }
\fP
.fi
This function returns a natural number that is equal to the number
of elements in the label whose index is \fIbcg_label_number\fP
(this number is always equal to 1 if the label is not visible).
It assumes \fIbcg_label_number\fP belongs to the range \fB\&0\fP to
\fBBCG_OT_NB_LABELS (\fP\fIbcg_graph\fP\fB) - 1\fP.
.P
 ............................................................
.P
.ne 8v
.SS \fBBCG_OT_ITERATE_PLN\fP
 \&
.nf
\fB
  BCG_TYPE_OBJECT_TRANSITION \fP\fIbcg_graph\fP\fB;
  BCG_TYPE_STATE_NUMBER      \fP\fIbcg_state_1\fP\fB;
  BCG_TYPE_LABEL_NUMBER      \fP\fIbcg_label_number\fP\fB;
  BCG_TYPE_STATE_NUMBER      \fP\fIbcg_state_2\fP\fB;
.sp
  BCG_OT_ITERATE_PLN (\fP\fIbcg_graph, bcg_state_1,
                        bcg_label_number, bcg_state_2\fP\fB)
  {
  /* loop body */
  } BCG_OT_END_ITERATE;
\fP
.fi
This iterator enumerates all the edges in the BCG graph associated
to \fIbcg_graph\fP.
.P
\fIbcg_state_1\fP is the number of the origin state of the edge, 
\fIbcg_state_2\fP is the number of the destination state of the edge,
and \fIbcg_label_number\fP is the number of the label of the edge. 
These three variables are assigned by the iterator. They are visible 
in the loop body, where they can be read but not assigned.
.P
For each edge \fI(bcg_state_1, bcg_label_number, bcg_state_2)\fP, the
loop body is executed. The loop body can be any statement block of the 
C language. In particular, it may contain "\fBbreak\fP" and 
"\fBcontinue\fP" statements with their usual semantics.
The order in which the edges are enumerated by this iterator is 
left unspecified.
.P
This iterator is available whatever value was given to 
\fIaccess_mode\fP when the BCG file associated to \fIbcg_graph\fP
was opened using \fBBCG_OT_READ_BCG_BEGIN()\fP.
.P
There is also a whole family of iterators that allow the enumeration of
all the edges for which \fIbcg_state_1\fP
and/or \fIbcg_label_number\fP and/or \fIbcg_state_2\fP are
given fixed values. The availability of these iterators depends
upon the value given to \fIaccess_mode\fP when the BCG file associated
to \fIbcg_graph\fP was opened. We describe below a representative
iterator (named \fBBCG_OT_ITERATE_P_LN\fP) in this family.
.P
 ............................................................
.P
.ne 8v
.SS \fBBCG_OT_ITERATE_P_LN\fP
 \&
.nf
\fB
  BCG_TYPE_OBJECT_TRANSITION \fP\fIbcg_graph\fP\fB;
  BCG_TYPE_STATE_NUMBER      \fP\fIbcg_state_1\fP\fB;
  BCG_TYPE_LABEL_NUMBER      \fP\fIbcg_label_number\fP\fB;
  BCG_TYPE_STATE_NUMBER      \fP\fIbcg_state_2\fP\fB;
.sp
  BCG_OT_ITERATE_P_LN (\fP\fIbcg_graph, bcg_state_1,
                         bcg_label_number, bcg_state_2\fP\fB)
  {
  /* loop body */
  } BCG_OT_END_ITERATE;
\fP
.fi
This iterator enumerates all the edges in the BCG graph with origin
state equal to \fIbcg_state_1\fP. \fIbcg_state_1\fP is a variable or
an expression whose value is evaluated when the iterator is started.
\fIbcg_state_1\fP is not assigned by the iterator.
.P
\fIbcg_state_2\fP is the number of the destination state of the edge, 
and \fIbcg_label_number\fP is the number of the label of the edge.
These two variables are assigned by the iterator. They are visible
in the loop body, where they can be read but not assigned.
.P
For each edge \fI(bcg_state_1, bcg_label_number, bcg_state_2)\fP, the
loop body is executed. The loop body can be any statement block of the 
C language. In particular, it may contain "\fBbreak\fP" and 
"\fBcontinue\fP" statements with their usual semantics.
The order in which the edges going out of a given state \fIbcg_state_1\fP
are enumerated by this iterator is left unspecified.
.P
This iterator is available if \fIaccess_mode\fP was given the value
1, 3, or 4 when the BCG file associated to \fIbcg_graph\fP was
opened using \fBBCG_OT_READ_BCG_BEGIN()\fP.
.P
There are several others iterators available. They are defined in 
file "\fB$CADP/incl/bcg_iterator.h\fP".
.P
 ............................................................
.P
.SS \fBBCG_OT_READ_BCG_END\fP
 \&
.nf
\fB BCG_TYPE_BOOLEAN BCG_OT_READ_BCG_END (\fP\fIbcg_graph\fP\fB);\fP
\fB BCG_TYPE_OBJECT_TRANSITION \fP*\fIbcg_graph\fP\fB;
  { ... }
\fP
.fi
This function closes a BCG graph and erases the contents of the \fI*bcg_graph\fP data structure.
.P
 ............................................................
.ne 15v
.SH EXAMPLE

.nf
#include "bcg_user.h"
.sp
/* The following function prints information about a BCG graph */

void bcg_print_info (bcg_graph)
BCG_TYPE_OBJECT_TRANSITION bcg_graph;
{
   printf ("initial state = %lu\en", BCG_OT_INITIAL_STATE (bcg_graph));
   printf ("nb states = %lu\en", BCG_OT_NB_STATES (bcg_graph));
   printf ("nb edges = %lu\en", BCG_OT_NB_EDGES (bcg_graph));
   printf ("nb labels = %u\en", BCG_OT_NB_LABELS (bcg_graph));
}
.sp
.ne 23v
/* The following function displays an edge */
.sp
void bcg_print_edge (bcg_graph, bcg_state_1, bcg_label_number, bcg_state_2)
BCG_TYPE_OBJECT_TRANSITION bcg_graph;
BCG_TYPE_STATE_NUMBER bcg_state_1;
BCG_TYPE_LABEL_NUMBER bcg_label_number;
BCG_TYPE_STATE_NUMBER bcg_state_2;
{
   BCG_TYPE_C_STRING bcg_label_string;
   BCG_TYPE_BOOLEAN bcg_visible;
   BCG_TYPE_NATURAL bcg_cardinal;
   BCG_TYPE_C_STRING bcg_gate;
.sp
   bcg_label_string = BCG_OT_LABEL_STRING (bcg_graph, bcg_label_number);
   bcg_visible = BCG_OT_LABEL_VISIBLE (bcg_graph, bcg_label_number);
   bcg_cardinal = BCG_OT_LABEL_CARDINAL (bcg_graph, bcg_label_number);
.sp
   printf ("transition from state %lu to state %lu\en", 
           bcg_state_1, bcg_state_2);
   printf ("label unique number = %u\en", bcg_label_number);
   printf ("label string = %s\en", bcg_label_string);
   printf ("label cardinal = %u\en", bcg_cardinal);
   if (bcg_visible) {
      bcg_gate = BCG_OT_LABEL_GATE (bcg_graph, bcg_label_number);
      printf ("visible label (gate = %s)\en", bcg_gate);
   } else {
      bcg_gate = BCG_OT_LABEL_HIDDEN_GATE (bcg_graph, bcg_label_number);
      printf ("hidden label (hidden gate = %s)\en", bcg_gate);
   }
}
.sp
.ne 19v
int main ()
{
   BCG_TYPE_OBJECT_TRANSITION bcg_graph;
   BCG_TYPE_STATE_NUMBER bcg_s1;
   BCG_TYPE_LABEL_NUMBER bcg_label_number;
   BCG_TYPE_STATE_NUMBER bcg_s2;
   BCG_TYPE_STATE_NUMBER bcg_nb_states;
.sp
   BCG_INIT ();
.sp
   /* The following fragment of code reads and prints all the edges 
      of a BCG graph, in an undefined order */
.sp
   BCG_OT_READ_BCG_BEGIN ("test.bcg", &bcg_graph, 0);
   bcg_print_info (bcg_graph);
   BCG_OT_ITERATE_PLN (bcg_graph, bcg_s1, bcg_label_number, bcg_s2) {
      bcg_print_edge (bcg_graph, bcg_s1, bcg_label_number, bcg_s2);
   } BCG_OT_END_ITERATE;
   BCG_OT_READ_BCG_END (&bcg_graph);
.sp
.ne 14v
   /* The following fragment of code reads and prints all the edges 
      of a BCG graph, sorted by origin states in increasing order */
.sp
   BCG_OT_READ_BCG_BEGIN ("test.bcg", &bcg_graph, 1);
   bcg_print_info (bcg_graph);
   bcg_nb_states = BCG_OT_NB_STATES (bcg_graph);
   for (bcg_s1 = 0; bcg_s1 < bcg_nb_states; bcg_s1++) {
      printf ("successors of state %lu:\en", bcg_s1);
      BCG_OT_ITERATE_P_LN (bcg_graph, bcg_s1, bcg_label_number, bcg_s2) {
        bcg_print_edge (bcg_graph, bcg_s1, bcg_label_number, bcg_s2);
      } BCG_OT_END_ITERATE;
   }
   BCG_OT_READ_BCG_END (&bcg_graph);
   exit (0);
}
.fi

.SH COMPILING AND LINK EDITING

To compile the application tool, the following options must be passed to the
C or C++ compiler:
.P
.B   -I$CADP/incl -L$CADP/bin.`$CADP/com/arch` -lBCG_IO -lBCG -lm
.P
as in, e.g.,
.P
.nf
   $CADP/src/com/cadp_cc tool.c -o tool -I$CADP/incl \\
   -L$CADP/bin.`$CADP/com/arch` -lBCG_IO -lBCG -lm
.fi

.SH EXIT STATUS
Application tools share common conventions with respect to diagnostics.
Exit status is 0 if everything is alright, 1 otherwise.

.SH AUTHORS
Hubert Garavel (definition of the BCG format) and 
Renaud Ruffiot (implementation of the BCG environment).

.SH FILES
See the
.BR bcg (LOCAL)
manual page for a description of the files.

.SH SEE ALSO
.BR bcg (LOCAL)
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
Please report bugs to Hubert.Garavel@inria.fr

