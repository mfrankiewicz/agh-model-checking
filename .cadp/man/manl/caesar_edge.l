'\" t
.\" @(#)caesar_edge.l - VASY and CONVECS teams - version 1.6
.TH caesar_edge LOCAL "2020/02/11 (version 1.6)" "(C) INRIA" "OPEN/CAESAR MANUAL"
.fp 4 CB
.lg 0
.SH NAME
caesar_edge \- the ``edge'' library of OPEN/CAESAR
.SH PURPOSE
The ``edge'' library provides primitives for computing the edges going out of a given state.
.sp
Although the \fIOPEN/CAESAR\fP graph module already provides an iterator macro for this purpose (the \fBCAESAR_ITERATE_STATE()\fP function), higher-level primitives may be useful and easier to use.
This is especially the case when a depth-first traversal of the state graph is necessary (e.g., on-the-fly verification, interactive simulation, ...).
.sp
From our experience, the \fBCAESAR_ITERATE_STATE()\fP function is often used as follows: for a given state S_1, one wants to compute all outgoing edges of the form ``(S_1, L, S_2)''; the labels L and states S_2 are stored in a data structure (usually a linked list).
.sp
.SH USAGE
The ``edge'' library consists of:
.IP -
a predefined header file \fBcaesar_edge.h\fP;
.IP -
the precompiled library file \fBlibcaesar.a\fP, which implements the features described in \fBcaesar_edge.h\fP.
.P
Note: The ``edge'' library is a software layer built above the primitives offered by the ``standard'' library and by the \fIOPEN/CAESAR\fP graph module.
.sp
.SH DESCRIPTION
An ``edge'' is basically a tuple with 5 fields:
.IP -
(1) a field containing a ``previous'' state;
.IP -
(2) a field containing a label;
.IP -
(3) a field containing a ``next'' state;
.IP -
(4) a ``mark'' field, that is a byte string whose size and contents are freely determined by the user. It can be used to mark states while depth-first exploring the state graph. The size of the mark field is the same for all edges; it must be greater or equal than zero.
Pointers to mark fields will be considered as values of type \fBCAESAR_TYPE_POINTER\fP; ``mark'' fields are always aligned on appropriate boundaries so that the user can put any information in these fields without alignment problem;
.IP -
(5) a pointer to a ``successor'' edge, which is used to build linked lists of edges.
.P
Fields (1), (2), (3), and (4) are optional, depending on the initialization parameters (see function \fBCAESAR_INIT_EDGE()\fP below).
.sp
Edges are represented as byte strings of fixed size (see function \fBCAESAR_SIZE_EDGE()\fP below) with definite alignment constraints (see function \fBCAESAR_ALIGNMENT_EDGE()\fP below). All edges have the same size.
.sp
.SH FEATURES
.P
 ............................................................
.SS \fBCAESAR_TYPE_EDGE\fP
 \&
.nf
\fBtypedef CAESAR_TYPE_ABSTRACT (...) CAESAR_TYPE_EDGE;
\fP
.fi
This type denotes a pointer to the concrete representation of an edge. The edge representation is supposed to be ``opaque''. 
.P
 ............................................................
.SS \fBCAESAR_INIT_EDGE\fP
 \&
.nf
\fBvoid CAESAR_INIT_EDGE (CAESAR_PREVIOUS_STATE, CAESAR_LABEL, CAESAR_NEXT_STATE,
                       CAESAR_SIZE_MARK, CAESAR_ALIGNMENT_MARK)
CAESAR_TYPE_BOOLEAN CAESAR_PREVIOUS_STATE;
CAESAR_TYPE_BOOLEAN CAESAR_LABEL;
CAESAR_TYPE_BOOLEAN CAESAR_NEXT_STATE;
CAESAR_TYPE_NATURAL CAESAR_SIZE_MARK;
CAESAR_TYPE_NATURAL CAESAR_ALIGNMENT_MARK;
{ ... }
\fP
.fi
This initialization procedure must be called before using any other primitive of the ``edge'' library. It should be called only once.
.sp
Each edge will contain a ``previous'' state iff \fBCAESAR_PREVIOUS_STATE\fP is equal to true.
.sp
Each edge will contain a label iff \fBCAESAR_LABEL\fP is equal to true.
.sp
Each edge will contain a ``next'' state iff \fBCAESAR_NEXT_STATE\fP is equal to true.
.sp
Each edge will contain a mark field iff \fBCAESAR_SIZE_MARK\fP is different from zero. If so, the value of \fBCAESAR_SIZE_MARK\fP determines the (constant) size (in bytes) of the mark field, and the value of \fBCAESAR_ALIGNMENT_MARK\fP determines the alignment factor (in bytes) of the mark field.
The alignment factor must be a power of two. Any mark field will be aligned on a boundary that is an even multiple of the alignment factor.
\fBCAESAR_ALIGNMENT_MARK\fP is equal to zero iff \fBCAESAR_SIZE_MARK\fP is equal to zero; otherwise, the effect of \fBCAESAR_INIT_EDGE()\fP is undefined.
.sp
If \fBCAESAR_PREVIOUS_STATE\fP, \fBCAESAR_LABEL\fP, and \fBCAESAR_NEXT_STATE\fP are equal to false, and if \fBCAESAR_SIZE_MARK\fP is equal to zero, the effect of \fBCAESAR_INIT_EDGE()\fP is undefined.
.P
 ............................................................
.SS \fBCAESAR_SIZE_EDGE\fP
 \&
.nf
\fBCAESAR_TYPE_NATURAL CAESAR_SIZE_EDGE ()
{ ... }
\fP
.fi
This function returns the edge size (in bytes).
.P
 ............................................................
.SS \fBCAESAR_ALIGNMENT_EDGE\fP
 \&
.nf
\fBCAESAR_TYPE_NATURAL CAESAR_ALIGNMENT_EDGE ()
   { ... }
\fP
.fi
This function returns the alignment factor (in bytes) for edges. The alignment factor is always a power of two, usually 1, 2, 4, or 8. Any byte string representing a edge must be aligned on a boundary that is an even multiple of the alignment factor.
.P
 ............................................................
.SS \fBCAESAR_PREVIOUS_STATE_EDGE\fP
 \&
.nf
\fBCAESAR_TYPE_STATE CAESAR_PREVIOUS_STATE_EDGE (CAESAR_E)
CAESAR_TYPE_EDGE CAESAR_E;
{ ... }
\fP
.fi
This function returns a pointer to the ``previous'' state field of the edge pointed to by \fBCAESAR_E\fP. If there is no such field (due to the initialization parameters supplied to \fBCAESAR_INIT_EDGE()\fP) the result is undefined.
.P
 ............................................................
.SS \fBCAESAR_LABEL_EDGE\fP
 \&
.nf
\fBCAESAR_TYPE_LABEL CAESAR_LABEL_EDGE (CAESAR_E)
CAESAR_TYPE_EDGE CAESAR_E;
{ ... }
\fP
.fi
This function returns a pointer to the label field of the edge pointed to by \fBCAESAR_E\fP. If there is no such field (due to the initialization parameters supplied to \fBCAESAR_INIT_EDGE()\fP) the result is undefined.
.P
 ............................................................
.SS \fBCAESAR_NEXT_STATE_EDGE\fP
 \&
.nf
\fBCAESAR_TYPE_STATE CAESAR_NEXT_STATE_EDGE (CAESAR_E)
CAESAR_TYPE_EDGE CAESAR_E;
{ ... }
\fP
.fi
This function returns a pointer to the ``next'' state field of the edge pointed to by \fBCAESAR_E\fP. If there is no such field (due to the initialization parameters supplied to \fBCAESAR_INIT_EDGE()\fP) the result is undefined.
.P
 ............................................................
.SS \fBCAESAR_MARK_EDGE\fP
 \&
.nf
\fBCAESAR_TYPE_POINTER CAESAR_MARK_EDGE (CAESAR_E)
CAESAR_TYPE_EDGE CAESAR_E;
{ ... }
\fP
.fi
This function returns a pointer to the mark field of the edge pointed to by \fBCAESAR_E\fP. If there is no such field (due to the initialization parameters supplied to \fBCAESAR_INIT_EDGE()\fP) the result is undefined.
.P
 ............................................................
.SS \fBCAESAR_SUCCESSOR_EDGE\fP
 \&
.nf
\fBCAESAR_TYPE_EDGE *CAESAR_SUCCESSOR_EDGE (CAESAR_E)
CAESAR_TYPE_EDGE CAESAR_E;
{ ... }
\fP
.fi
This function returns a pointer to the ``successor'' edge (pointer) field of the edge pointed to by \fBCAESAR_E\fP.
.P
 ............................................................
.SS \fBCAESAR_CREATE_EDGE\fP
 \&
.nf
\fBvoid CAESAR_CREATE_EDGE (CAESAR_E)
   CAESAR_TYPE_EDGE *CAESAR_E;
   { ... }
\fP
.fi
This procedure allocates a byte string of length \fBCAESAR_SIZE_EDGE()\fP using \fBCAESAR_CREATE()\fP and assigns its address to \fB*CAESAR_E\fP. If the allocation fails, the \fBNULL\fP value is assigned to \fB*CAESAR_E\fP.
.sp
When the allocation succeeds, the mark field (if any) of \fBCAESAR_E\fP is initialized to a bit string of 0's and the ``successor'' edge field is initialized to the \fBNULL\fP pointer. The state field and the label field are left undefined.
.sp
Note: because \fBCAESAR_TYPE_EDGE\fP is a pointer type, any variable \fBCAESAR_E\fP of type \fBCAESAR_TYPE_EDGE\fP must be allocated before used, for instance using:
.TS
center;
l.
 
 \fBCAESAR_CREATE_EDGE (&CAESAR_E);\fP 
 
.TE
However, it is not necessary to use \fBCAESAR_CREATE_EDGE()\fP to perform the allocation. Instead, users can allocate edges into their own data structures (tables, lists, ...)
.P
 ............................................................
.SS \fBCAESAR_DELETE_EDGE\fP
 \&
.nf
\fBvoid CAESAR_DELETE_EDGE (CAESAR_E)
   CAESAR_TYPE_EDGE *CAESAR_E;
   { ... }
\fP
.fi
This procedure frees the byte string of length \fBCAESAR_SIZE_EDGE()\fP pointed to by \fB*CAESAR_E\fP using \fBCAESAR_DELETE()\fP. Afterwards, the \fBNULL\fP value is assigned to \fB*CAESAR_E\fP.
.P
 ............................................................
.SS \fBCAESAR_COPY_EDGE\fP
 \&
.nf
\fBvoid CAESAR_COPY_EDGE (CAESAR_E1, CAESAR_E2)
   CAESAR_TYPE_EDGE CAESAR_E1;
   CAESAR_TYPE_EDGE CAESAR_E2;
   { ... }
\fP
.fi
This procedure copies the edge pointed to by \fBCAESAR_E2\fP onto the edge pointed to by \fBCAESAR_E1\fP.
.P
 ............................................................
.SS \fBCAESAR_FORMAT_EDGE\fP
 \&
.nf
\fBCAESAR_TYPE_FORMAT CAESAR_FORMAT_EDGE (CAESAR_FORMAT)
   CAESAR_TYPE_FORMAT CAESAR_FORMAT;
   { ... }
\fP
.fi
This function allows to control the format under which edges are printed by procedures \fBCAESAR_PRINT_EDGE()\fP and \fBCAESAR_PRINT_EDGE_LIST()\fP (see below). Currently, the following formats are available:
.sp
.IP -
With format 0, the edge is printed as a portion of text. This is mainly intended for debugging purpose.
.IP -
(no other format available yet)
.P
By default, the current edge format is initialized to 0.
.sp
When called with \fBCAESAR_FORMAT\fP between 0 and 0, this fonction sets the current edge format to \fBCAESAR_FORMAT\fP and returns an undefined result.
.sp
When called with another value of \fBCAESAR_FORMAT\fP, this function does not modify the current edge format but returns a result defined as follows. If \fBCAESAR_FORMAT\fP is equal to the constant \fBCAESAR_CURRENT_FORMAT\fP, the result is the value of the current edge format. If \fBCAESAR_FORMAT\fP is equal to the constant \fBCAESAR_MAXIMAL_FORMAT\fP, the result is the maximal format value (i.e., 0). In all other cases, the effect of this function is undefined.
.P
 ............................................................
.SS \fBCAESAR_MAX_FORMAT_EDGE\fP
 \&
.nf
\fBCAESAR_TYPE_FORMAT CAESAR_MAX_FORMAT_EDGE ()
   { ... }
\fP
.fi
Caution! This function is deprecated. It should no longer be used, as it might be removed from future versions of the \fIOPEN/CAESAR\fP. Use function \fBCAESAR_FORMAT_EDGE()\fP instead, called with argument \fBCAESAR_MAXIMAL_FORMAT\fP.
.sp
This function returns the maximal format value available for printing edges.
.P
 ............................................................
.SS \fBCAESAR_PRINT_EDGE\fP
 \&
.nf
\fBvoid CAESAR_PRINT_EDGE (CAESAR_FILE, CAESAR_E)
   CAESAR_TYPE_FILE CAESAR_FILE;
   CAESAR_TYPE_EDGE CAESAR_E;
   { ... }
\fP
.fi
This procedure prints to file \fBCAESAR_FILE\fP information about the contents of the edge pointed to by \fBCAESAR_E\fP. The nature of the information is determined by the current edge format (see procedure \fBCAESAR_FORMAT_EDGE()\fP above).
.sp
Before this procedure is called, \fBCAESAR_FILE\fP must have been properly opened, for instance using \fBfopen(3)\fP.
.P
 ............................................................
.SS \fBCAESAR_CREATE_EDGE_LIST\fP
 \&
.nf
\fBvoid CAESAR_CREATE_EDGE_LIST (CAESAR_S1, CAESAR_E1_En, CAESAR_ORDER)
CAESAR_TYPE_STATE CAESAR_S1;
CAESAR_TYPE_EDGE *CAESAR_E1_En;
CAESAR_TYPE_NATURAL CAESAR_ORDER;
\fP
.fi
This procedure computes all couples (\fBCAESAR_L\fP, \fBCAESAR_S2\fP) such that ``(\fBCAESAR_S1\fP, \fBCAESAR_L\fP, \fBCAESAR_S2\fP)'' is an edge of the labelled transition system (this is done using the \fBCAESAR_ITERATE_STATE()\fP procedure of the graph module).
.sp
This procedure also builds a linked list whose items are values of type \fBCAESAR_TYPE_EDGE\fP, linked together using the ``successor'' edge field. The ``successor'' edge field of the last item is set to \fBNULL\fP. The list can be empty if \fBCAESAR_S1\fP is a sink state. The address of the first item of the list (or \fBNULL\fP if the list is empty) is assigned to \fB*CAESAR_E1_En\fP. Obviously, the previous value of \fB*CAESAR_E1_En\fP is lost.
.sp
The fields of each item are assigned as follows:
.sp
.IP -
the ``previous'' state field (if any) will contain the value of \fBCAESAR_S1\fP.
.IP -
the label field (if any) will contain various values for \fBCAESAR_L\fP.
.IP -
the ``next'' state field (if any) of each item will contain values for \fBCAESAR_S2\fP.
.IP -
the mark field (if any) is initialized to a bit string of 0's.
The value of the formal parameter \fBCAESAR_ORDER\fP determines the order of the items of the linked list. Several cases are currently implemented:
.IP -
if \fBCAESAR_ORDER\fP is equal to 0, the list order is undefined.
.IP -
if \fBCAESAR_ORDER\fP is equal to 1, the edge list is sorted in the same order as transitions are enumerated by the \fBCAESAR_ITERATE_STATE()\fP procedure.
.IP -
if \fBCAESAR_ORDER\fP is equal to 2, the edge list is sorted in the reverse order of the order in which transitions are enumerated by the \fBCAESAR_ITERATE_STATE()\fP procedure.
.IP -
if \fBCAESAR_ORDER\fP is equal to 3 or 5, the list is sorted in such a way that the character string values returned by \fBCAESAR_STRING_LABEL()\fP are increasing, according to the lexicographical order used in the function \fBstrcmp(3)\fP.
.IP -
if \fBCAESAR_ORDER\fP is equal to 4 or 6, the list is sorted in such a way that the character string values returned by \fBCAESAR_STRING_LABEL()\fP are decreasing, according to the lexicographical order used in the function \fBstrcmp(3)\fP.
.P
Additionally, this procedure sets two global variables \fBcaesar_creation\fP and \fBcaesar_truncation\fP of type \fBCAESAR_TYPE_NATURAL\fP. After any call to \fBCAESAR_CREATE_EDGE_LIST()\fP, these variables can be inspected using the two functions \fBCAESAR_CREATION_EDGE_LIST()\fP and \fBCAESAR_TRUNCATION_EDGE_LIST()\fP defined below. The values of these variables are set as follows:
.sp
.IP -
if the computation normally succeeds, then \fBcaesar_creation\fP is set to the number of items in the linked list and \fBcaesar_truncation\fP is set to zero.
.IP -
if allocation fails when building the list (due to a lack of memory), a truncated list is built (the ``successor'' edge field of the last item is still set to \fBNULL\fP). Then \fBcaesar_creation\fP is set to the number of items in the truncated list and \fBcaesar_truncation\fP is set to the number of items that have not been inserted in the list (this number is greater than zero).
.P
.P
 ............................................................
.SS \fBCAESAR_MAX_ORDER_EDGE_LIST\fP
 \&
.nf
\fBCAESAR_TYPE_NATURAL CAESAR_MAX_ORDER_EDGE_LIST ()
   { ... }
\fP
.fi
This function returns the highest order available for edge list creation, i.e., the highest acceptable value for the parameter \fBCAESAR_ORDER\fP of function \fBCAESAR_CREATE_EDGE_LIST()\fP.
.P
 ............................................................
.SS \fBCAESAR_DELETE_EDGE_LIST\fP
 \&
.nf
\fBvoid CAESAR_DELETE_EDGE_LIST (CAESAR_E1_En)
CAESAR_TYPE_EDGE *CAESAR_E1_En;
{ ... }
\fP
.fi
This procedure frees each item of the linked list pointed to by \fB*CAESAR_E1_En\fP. Afterwards, the \fBNULL\fP value is assigned to \fB*CAESAR_E1_En\fP.
.P
 ............................................................
.SS \fBCAESAR_COPY_EDGE_LIST\fP
 \&
.nf
\fBvoid CAESAR_COPY_EDGE_LIST (CAESAR_E1_Em, CAESAR_E1_En)
CAESAR_TYPE_EDGE *CAESAR_E1_Em;
CAESAR_TYPE_EDGE CAESAR_E1_En;
{ ... }
\fP
.fi
This procedure builds a duplicate list, which is a copy of the linked list pointed to by \fBCAESAR_E1_En\fP. A pointer to this duplicate list (or NULL if the list is empty) is assigned to \fB*CAESAR_E1_Em\fP. For each item of the linked list pointed to by \fBCAESAR_E1_En\fP, a duplicated item is allocated. Said differently, both lists do not have shared items in common.
.sp
Additionally, this procedure sets two global variables \fBcaesar_creation\fP and \fBcaesar_truncation\fP of type \fBCAESAR_TYPE_NATURAL\fP. After any call to \fBCAESAR_COPY_EDGE_LIST()\fP, these variables can be inspected using the two functions \fBCAESAR_CREATION_EDGE_LIST()\fP and \fBCAESAR_TRUNCATION_EDGE_LIST()\fP defined below. The values of these variables are set as in the \fBCAESAR_CREATE_EDGE_LIST()\fP function.
.sp
The previous value of \fB*CAESAR_E1_Em\fP is lost: if it points to a non-empty list, this list should be freed using \fBCAESAR_DELETE_EDGE_LIST()\fP before \fBCAESAR_COPY_EDGE_LIST()\fP is called.
.P
 ............................................................
.SS \fBCAESAR_CREATION_EDGE_LIST\fP
 \&
.nf
\fBCAESAR_TYPE_NATURAL CAESAR_CREATION_EDGE_LIST ()
   { ... }
\fP
.fi
This function returns the value of the global variable \fBcaesar_creation\fP computed during the last call to \fBCAESAR_CREATE_EDGE_LIST()\fP or \fBCAESAR_COPY_EDGE_LIST()\fP. This variable can only be accessed using this function.
.P
 ............................................................
.SS \fBCAESAR_TRUNCATION_EDGE_LIST\fP
 \&
.nf
\fBCAESAR_TYPE_NATURAL CAESAR_TRUNCATION_EDGE_LIST ()
   { ... }
\fP
.fi
This function returns the value of the global variable \fBcaesar_truncation\fP computed during the last call to \fBCAESAR_CREATE_EDGE_LIST()\fP or \fBCAESAR_COPY_EDGE_LIST\fP. This variable can only be accessed using this function.
.P
 ............................................................
.SS \fBCAESAR_FORMAT_EDGE_LIST\fP
 \&
.nf
\fBCAESAR_TYPE_FORMAT CAESAR_FORMAT_EDGE_LIST (CAESAR_FORMAT)
   CAESAR_TYPE_FORMAT CAESAR_FORMAT;
   { ... }
\fP
.fi
This function allows to control the format under which edge lists are printed by the procedure \fBCAESAR_PRINT_EDGE_LIST()\fP (see below). Currently, the following formats are available:
.sp
.IP -
With format 0, the edge list is printed as a portion of text. This is mainly intended for debugging purpose.
.IP -
(no other format available yet)
.P
A call to this function sets the current edge list format to \fBCAESAR_FORMAT\fP.
.sp
When called with \fBCAESAR_FORMAT\fP between 0 and 0, this fonction sets the current edge list format to \fBCAESAR_FORMAT\fP and returns an undefined result.
.sp
When called with another value of \fBCAESAR_FORMAT\fP, this function does not modify the current edge list format but returns a result defined as follows. If \fBCAESAR_FORMAT\fP is equal to the constant \fBCAESAR_CURRENT_FORMAT\fP, the result is the value of the current edge list format. If \fBCAESAR_FORMAT\fP is equal to the constant \fBCAESAR_MAXIMAL_FORMAT\fP, the result is the maximal format value (i.e., 0). In all other cases, the effect of this function is undefined.
.P
 ............................................................
.SS \fBCAESAR_MAX_FORMAT_EDGE_LIST\fP
 \&
.nf
\fBCAESAR_TYPE_FORMAT CAESAR_MAX_FORMAT_EDGE_LIST ()
   { ... }
\fP
.fi
Caution! This function is deprecated. It should no longer be used, as it might be removed from future versions of the \fIOPEN/CAESAR\fP. Use function \fBCAESAR_FORMAT_EDGE_LIST()\fP instead, called with argument \fBCAESAR_MAXIMAL_FORMAT\fP.
.sp
This function returns the maximal format value available for printing edge lists.
.P
 ............................................................
.SS \fBCAESAR_PRINT_EDGE_LIST\fP
 \&
.nf
\fBvoid CAESAR_PRINT_EDGE_LIST (CAESAR_FILE, CAESAR_E1_En)
   CAESAR_TYPE_FILE CAESAR_FILE;
   CAESAR_TYPE_EDGE CAESAR_E1_En;
   { ... }
\fP
.fi
This procedure prints to file \fBCAESAR_FILE\fP information about the contents of the linked list of edges pointed to by \fBCAESAR_E1_En\fP. The nature of the information is determined by the current edge format and the current edge list format (see procedures \fBCAESAR_FORMAT_EDGE()\fP and \fBCAESAR_FORMAT_EDGE_LIST()\fP above).
.sp
Before this procedure is called, \fBCAESAR_FILE\fP must have been properly opened, for instance using \fBfopen(3)\fP.
.P
 ............................................................
.SS \fBCAESAR_ITERATE_PLNM_EDGE_LIST\fP
 \&
.nf
\fB#define CAESAR_ITERATE_PLNM_EDGE_LIST(CAESAR_E1_En,CAESAR_E,\e
                    CAESAR_S1,CAESAR_L,CAESAR_S2,CAESAR_M) ...
\fP
.fi
with parameters typed as follows:
 \&
.nf
\fBCAESAR_TYPE_EDGE CAESAR_E1_En;
CAESAR_TYPE_EDGE CAESAR_E;
CAESAR_TYPE_STATE CAESAR_S1;
CAESAR_TYPE_LABEL CAESAR_L;
CAESAR_TYPE_STATE CAESAR_S2;
CAESAR_TYPE_POINTER CAESAR_M;
\fP
.fi
This macro-definition is an iterator which can be used in the same way as a \fBwhile (...)\fP or \fBfor (...; ...; ...)\fP instruction. It is therefore possible to write an instruction such as:
 \&
.nf
\fB        CAESAR_ITERATE_PLNM_EDGE_LIST(caesar_e1_en,caesar_e,
                    caesar_s1,caesar_l,caesar_s2,caesar_m) {
        ...
        body of the loop, containing occurrences of variables
        caesar_e, caesar_s1, caesar_l, caesar_s2, and caesar_m
        ...
        }
\fP
.fi
\fBCAESAR_E1_En\fP is an expression (r-value) containing a pointer to the first item of a linked list of edges.
.sp
\fBCAESAR_E\fP is a variable (l-value) which will be used as the induction variable in the body of the loop. At the n-th iteration step, it points to the n-th item of the linked list.
.sp
\fBCAESAR_S1\fP is a variable (l-value) which can also be used as an induction variable. At the n-th iteration step, it points to the ``previous'' state field of the n-th item of the linked list. If this field does not exist, the result is undefined. At each step, one has:
.TS
center;
l.
 
 \fBCAESAR_S1\fP == \fBCAESAR_PREVIOUS_STATE_EDGE (CAESAR_E)\fP 
 
.TE
.sp
\fBCAESAR_L\fP is a variable (l-value) which can also be used as an induction variable. At the n-th iteration step, it points to the label field of the n-th item of the linked list. If this field does not exist, the result is undefined. At each step, one has:
.TS
center;
l.
 
 \fBCAESAR_L\fP == \fBCAESAR_LABEL_EDGE (CAESAR_E)\fP 
 
.TE
.sp
\fBCAESAR_S2\fP is a variable (l-value) which can also be used as an induction variable. At the n-th iteration step, it points to the ``next'' state field of the n-th item of the linked list. If this field does not exist, the result is undefined. At each step, one has:
.TS
center;
l.
 
 \fBCAESAR_S2\fP == \fBCAESAR_NEXT_STATE_EDGE (CAESAR_E)\fP 
 
.TE
.sp
\fBCAESAR_M\fP is a variable (l-value) which can also be used as an induction variable. At the n-th iteration step, it points to the mark field of the n-th item of the linked list. If this field does not exist, the result is undefined. At each step, one has:
.TS
center;
l.
 
 \fBCAESAR_M\fP == \fBCAESAR_MARK_EDGE (CAESAR_E)\fP 
 
.TE
.sp
The body of the loop can be any statement of the C language. In particular, it may contain \fBbreak\fP and \fBcontinue\fP statements with their usual semantics.
.sp
This is the most general iterator on linked lists of edges. There are also 15 other iterators derived from the general one. These iterators are simpler than the general one, since they deal with the cases where one or several of the following parameters:
.TS
center;
l.
 
 \fBCAESAR_S1\fP,  \fBCAESAR_L\fP,  \fBCAESAR_S2\fP,  \fBCAESAR_M\fP 
 
.TE
are omitted. These operators are used according to the needs (for example, the four aforementioned parameters can be omitted if one only wants to compute the length of an edge list) and also depending on the initialization values given to \fBCAESAR_INIT_EDGE()\fP (since one or several fields may not actually exist).
.sp
The 15 derived iterators are listed below.
.sp
 \&
.nf
\fB#define CAESAR_ITERATE_EDGE_LIST(CAESAR_E1_En,CAESAR_E) ...
 
#define CAESAR_ITERATE_P_EDGE_LIST(CAESAR_E1_En,CAESAR_E,CAESAR_S1) ...
 
#define CAESAR_ITERATE_L_EDGE_LIST(CAESAR_E1_En,CAESAR_E,CAESAR_L) ...
 
#define CAESAR_ITERATE_N_EDGE_LIST(CAESAR_E1_En,CAESAR_E,CAESAR_S2) ...
 
#define CAESAR_ITERATE_M_EDGE_LIST(CAESAR_E1_En,CAESAR_E,CAESAR_M) ...
 
#define CAESAR_ITERATE_PL_EDGE_LIST(CAESAR_E1_En,CAESAR_E,CAESAR_S1,CAESAR_L) ...
 
#define CAESAR_ITERATE_PN_EDGE_LIST(CAESAR_E1_En,CAESAR_E,CAESAR_S1,CAESAR_S2) ...
 
#define CAESAR_ITERATE_PM_EDGE_LIST(CAESAR_E1_En,CAESAR_E,CAESAR_S1,CAESAR_M) ...
 
#define CAESAR_ITERATE_LN_EDGE_LIST(CAESAR_E1_En,CAESAR_E,CAESAR_L,CAESAR_S2) ...
 
#define CAESAR_ITERATE_LM_EDGE_LIST(CAESAR_E1_En,CAESAR_E,CAESAR_L,CAESAR_M) ...
 
#define CAESAR_ITERATE_NM_EDGE_LIST(CAESAR_E1_En,CAESAR_E,CAESAR_S2,CAESAR_M) ...
 
#define CAESAR_ITERATE_PLN_EDGE_LIST(CAESAR_E1_En,CAESAR_E,CAESAR_S1,CAESAR_L,CAESAR_S2) ...
 
#define CAESAR_ITERATE_PLM_EDGE_LIST(CAESAR_E1_En,CAESAR_E,CAESAR_S1,CAESAR_L,CAESAR_M) ...
 
#define CAESAR_ITERATE_PNM_EDGE_LIST(CAESAR_E1_En,CAESAR_E,CAESAR_S1,CAESAR_S2,CAESAR_M) ...
 
#define CAESAR_ITERATE_LNM_EDGE_LIST(CAESAR_E1_En,CAESAR_E,CAESAR_L,CAESAR_S2,CAESAR_M) ...
\fP
.fi
.P
 ............................................................
.SS \fBCAESAR_LENGTH_EDGE_LIST\fP
 \&
.nf
\fBCAESAR_TYPE_NATURAL CAESAR_LENGTH_EDGE_LIST (CAESAR_E1_En)
   CAESAR_TYPE_EDGE CAESAR_E1_En;
   { ... }
\fP
.fi
This function returns the number of items in the linked list pointed to by \fBCAESAR_E1_En\fP.
.P
 ............................................................
.SS \fBCAESAR_ITEM_EDGE_LIST\fP
 \&
.nf
\fBCAESAR_TYPE_EDGE CAESAR_ITEM_EDGE_LIST (CAESAR_E1_En, CAESAR_N)
   CAESAR_TYPE_EDGE CAESAR_E1_En;
   CAESAR_TYPE_NATURAL CAESAR_N;
   { ... }
\fP
.fi
This function returns the \fBCAESAR_N\fP-th item in the linked list pointed to by \fBCAESAR_E1_En\fP (the first item is numbered 1). If \fBCAESAR_N\fP is equal to 0, or is greater than the actual length of the linked list, the result is undefined.
.P
 ............................................................
.SS \fBCAESAR_REVERSE_EDGE_LIST\fP
 \&
.nf
\fBvoid CAESAR_REVERSE_EDGE_LIST (CAESAR_E1_En)
   CAESAR_TYPE_EDGE *CAESAR_E1_En;
   { ... }
\fP
.fi
This procedure reverses the linked list of edges pointed to by \fB*CAESAR_E1_En\fP.
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
