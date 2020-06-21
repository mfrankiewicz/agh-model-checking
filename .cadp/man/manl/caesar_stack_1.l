'\" t
.\" @(#)caesar_stack_1.l - VASY and CONVECS teams - version 1.6
.TH caesar_stack_1 LOCAL "2020/02/11 (version 1.6)" "(C) INRIA" "OPEN/CAESAR MANUAL"
.fp 4 CB
.lg 0
.SH NAME
caesar_stack_1 \- the ``stack_1'' library of OPEN/CAESAR
.SH PURPOSE
The ``stack_1'' library provides primitives for managing a stack when performing depth-first search in the state graph.
.sp
.sp
.SH USAGE
The ``stack_1'' library consists of:
.IP -
a predefined header file \fBcaesar_stack_1.h\fP;
.IP -
the precompiled library file \fBlibcaesar.a\fP, which implements the features described in \fBcaesar_stack_1.h\fP.
.P
Note: The ``stack_1'' library is a software layer built above the primitives offered by the ``standard'' and ``edge'' libraries, and by the \fIOPEN/CAESAR\fP graph module.
.sp
Note: The ``stack_1'' library relies on the ``edge'' library. Therefore, when using the ``stack_1'' library, there are restrictions concerning the use of the ``edge'' library primitives. These restrictions are listed in the sequel.
.sp
.sp
.SH DESCRIPTION
Each item in the stack is basically a tuple with 3 fields:
.IP -
(1) a ``label'' field containing a label,
.IP -
(2) a ``state'' field containing a state,
.IP -
(3) an ``edge'' field containing a list of edges (see the ``edge'' library).
.P
There is no constraint on the contents of these fields. Yet, if the stack is used for a depth-first search in the state graph (see below) it is likely that the following invariants hold:
.sp
.IP -
the state field of the stack base is the initial state of the graph;
.IP -
the label field of the stack base is undefined;
.IP -
the state field of the stack top is the current state;
.IP -
the label and state fields of the stack determine the path leading from the initial state to the current state. If, for a given stack item (different from the top), the state field is equal to S_1, and if, for the immediately above stack item, the label and state fields are respectively equal to L and S_2, then ``(S_1, L, S_2)'' is an edge of the graph;
.IP -
if, for a given stack item, the state field is equal to S, then the ``edge'' field of this item contains a list of edges outgoing from state S; more precisely, it is the list of edges that have not been explored yet.
.IP -
the lists of edges associated to the stack items are pairwise disjoint. Said differently, the edge fields respectively attached to different stack items do not have shared items in common.
.P
.sp
.SH FEATURES
.P
 ............................................................
.SS \fBCAESAR_TYPE_STACK_1\fP
 \&
.nf
\fBtypedef CAESAR_TYPE_ABSTRACT (...) CAESAR_TYPE_STACK_1;
\fP
.fi
This type denotes a pointer to the concrete representation of a stack. The stack representation is supposed to be ``opaque''.
.sp
.P
 ............................................................
.SS \fBCAESAR_TYPE_OVERFLOW_FUNCTION_STACK_1\fP
 \&
.nf
\fBtypedef void (*CAESAR_TYPE_OVERFLOW_FUNCTION_STACK_1) (CAESAR_TYPE_STACK_1);
\fP
.fi
\fBCAESAR_TYPE_OVERFLOW_FUNCTION_STACK_1\fP is the ``pointer to an overflow procedure'' type used in the ``stack_1'' library. An overflow procedure takes one parameter of type \fBCAESAR_TYPE_STACK_1\fP. Examples of overflow procedures are \fBCAESAR_OVERFLOW_SIGNAL_STACK_1()\fP, \fBCAESAR_OVERFLOW_ABORT_STACK_1()\fP, and \fBCAESAR_OVERFLOW_IGNORE_STACK_1()\fP defined below.
.sp
.P
 ............................................................
.SS \fBCAESAR_OVERFLOW_SIGNAL_STACK_1\fP
 \&
.nf
\fBvoid CAESAR_OVERFLOW_SIGNAL_STACK_1 (CAESAR_K)
    CAESAR_TYPE_STACK_1 CAESAR_K;
   { ... }
\fP
.fi
This procedure is a possible action that can be performed in case the stack pointed to by \fBCAESAR_K\fP overflows (because there is not enough memory to store new items).
.sp
It first prints an error message to the standard output, and also various statistics about the stack (including the number of items that could not be stored in memory). Then, it returns. Practically, this means that some portions of the graph will not be explored, but an error message will be issued.
.sp
.P
 ............................................................
.SS \fBCAESAR_OVERFLOW_ABORT_STACK_1\fP
 \&
.nf
\fBvoid CAESAR_OVERFLOW_ABORT_STACK_1 (CAESAR_K)
    CAESAR_TYPE_STACK_1 CAESAR_K;
   { ... }
\fP
.fi
This procedure is a possible action that can be performed in case the stack pointed to by \fBCAESAR_K\fP overflows (because there is not enough memory to store new items).
.sp
It first prints an error message to the standard output, and also various statistics about the stack (including the number of items that could not be stored in memory). Then, it aborts the program using the C function \fBexit(3)\fP. The error code 1 is returned.
.sp
.P
 ............................................................
.SS \fBCAESAR_OVERFLOW_IGNORE_STACK_1\fP
 \&
.nf
\fBvoid CAESAR_OVERFLOW_IGNORE_STACK_1 (CAESAR_K)
    CAESAR_TYPE_STACK_1 CAESAR_K;
   { ... }
\fP
.fi
This procedure is a possible action that can be performed in case the stack pointed to by \fBCAESAR_K\fP overflows (because there is not enough memory to store new items).
.sp
This procedure does nothing and returns. Practically, this means that some portions of the graph will not be explored; they are silently ignored.
.sp
.P
 ............................................................
.SS \fBCAESAR_INIT_STACK_1\fP
 \&
.nf
\fBvoid CAESAR_INIT_STACK_1 ()
   { ... }
\fP
.fi
This initialization procedure must be called before using any other primitive of the ``stack_1'' library.
.sp
This procedure calls internally the initialization procedure of the ``edge'' library; the call is done as follows:
.TS
center;
l.
 
 \fBCAESAR_INIT_EDGE (0, 1, 1, CAESAR_SIZE_POINTER(), CAESAR_ALIGNMENT_POINTER());\fP 
 
.TE
.sp
Consequently, when using the ``stack_1'' library, it is forbidden:
.sp
.IP -
to call \fBCAESAR_INIT_EDGE()\fP directly (which would result in several calls to this procedure with undefined results);
.IP -
to use any primitive of the ``edge'' library relying on the existence of the ``previous state'' field.
.P
.sp
.P
 ............................................................
.SS \fBCAESAR_CREATE_STACK_1\fP
 \&
.nf
\fBvoid CAESAR_CREATE_STACK_1 (CAESAR_K, CAESAR_ORDER, CAESAR_OVERFLOW)
   CAESAR_TYPE_STACK_1 *CAESAR_K;
   CAESAR_TYPE_NATURAL CAESAR_ORDER;
   CAESAR_TYPE_OVERFLOW_FUNCTION_STACK_1 CAESAR_OVERFLOW;
   { ... }
\fP
.fi
This procedure allocates a stack using \fBCAESAR_CREATE()\fP and assigns its address to \fB*CAESAR_K\fP. If the allocation fails, the \fBNULL\fP value is assigned to \fB*CAESAR_K\fP.
.sp
Note: because \fBCAESAR_TYPE_STACK_1\fP is a pointer type, any variable \fBCAESAR_K\fP of type \fBCAESAR_TYPE_STACK_1\fP must be allocated before used, for instance using:
.TS
center;
l.
 
 \fBCAESAR_CREATE_STACK_1 (&CAESAR_K, ...);\fP 
 
.TE
.sp
The actual value of the formal parameter \fBCAESAR_ORDER\fP will be stored and associated to the stack pointed to by \fB*CAESAR_K\fP. This parameter follows the same conventions as the formal parameter \fBCAESAR_ORDER\fP of the \fBCAESAR_CREATE_EDGE_LIST()\fP procedure of the ``edge'' library. It will be used subsequently to determine the order of the list of edges contained in the ``edge'' fields of the items of the stack pointed to by \fB*CAESAR_K\fP. See below for more details.
.sp
The actual value of the formal parameter \fBCAESAR_OVERFLOW\fP will be stored and associated to the stack pointed to by \fB*CAESAR_K\fP. It will be used subsequently to determine the action to take if the stack pointed to by \fB*CAESAR_K\fP overflows: in this case, the procedure pointed to by \fBCAESAR_OVERFLOW\fP will be called with the overflowing stack \fB*CAESAR_K\fP passed as actual parameter.
.sp
The above procedures \fBCAESAR_OVERFLOW_SIGNAL_STACK_1()\fP, \fBCAESAR_OVERFLOW_ABORT_STACK_1()\fP, and \fBCAESAR_OVERFLOW_IGNORE_STACK_1()\fP, can be used as actual values for the formal parameter \fBCAESAR_OVERFLOW\fP.
.sp
If the actual value of the formal parameter \fBCAESAR_OVERFLOW\fP is \fBNULL\fP, it is replaced by the default value \fBCAESAR_OVERFLOW_SIGNAL_STACK_1\fP.
.sp
.P
 ............................................................
.SS \fBCAESAR_DELETE_STACK_1\fP
 \&
.nf
\fBvoid CAESAR_DELETE_STACK_1 (CAESAR_K)
   CAESAR_TYPE_STACK_1 *CAESAR_K;
   { ... }
\fP
.fi
This procedure frees the memory space corresponding to the stack pointed to by \fB*CAESAR_K\fP using \fBCAESAR_DELETE()\fP. Each stack item is also freed, as well as each item of the ``edge'' field of each stack item. Afterwards, the \fBNULL\fP value is assigned to \fB*CAESAR_K\fP.
.sp
.P
 ............................................................
.SS \fBCAESAR_PURGE_STACK_1\fP
 \&
.nf
\fBvoid CAESAR_PURGE_STACK_1 (CAESAR_K)
   CAESAR_TYPE_STACK_1 CAESAR_K;
   { ... }
\fP
.fi
This procedure empties the stack pointed to by \fBCAESAR_K\fP without deleting it. Each stack item is freed, as well as each item of the ``edge'' field of each stack item. Afterwards, the stack is exactly in the same state as after its creation using \fBCAESAR_CREATE_STACK_1()\fP.
.sp
.P
 ............................................................
.SS \fBCAESAR_COPY_STACK_1\fP
 \&
.nf
\fBvoid CAESAR_COPY_STACK_1 (CAESAR_K1, CAESAR_K2, CAESAR_FULL)
   CAESAR_TYPE_STACK_1 CAESAR_K1;
   CAESAR_TYPE_STACK_1 CAESAR_K2;
   CAESAR_TYPE_BOOLEAN CAESAR_FULL;
   { ... }
\fP
.fi
This procedure empties the stack pointed to by \fBCAESAR_K1\fP using \fBCAESAR_PURGE_STACK_1()\fP. This stack must have been created previously using \fBCAESAR_CREATE_STACK_1()\fP.
.sp
Afterwards, the contents of the stack pointed to by \fBCAESAR_K2\fP are copied to the stack pointed to by \fBCAESAR_K1\fP. For each item of the stack pointed to by \fBCAESAR_K2\fP, a duplicated item is allocated and inserted into the stack pointed to by \fBCAESAR_K1\fP. Said differently, after the copy, both stacks do not have shared items in common.
.sp
If \fBCAESAR_FULL\fP is equal to zero, the ``edge'' fields of all items in the stack pointed to by \fBCAESAR_K1\fP are set to NULL; the ``edge'' fields of the items in the stack pointed to by \fBCAESAR_K2\fP are not duplicated. This is useful for storing a path leading from the initial state to the current state.
.sp
In case of memory shortage, the overflow procedure associated with \fBCAESAR_K1\fP is called with the actual parameter \fBCAESAR_K1\fP.
.sp
.P
 ............................................................
.SS \fBCAESAR_DEPTH_STACK_1\fP
 \&
.nf
\fBCAESAR_TYPE_NATURAL CAESAR_DEPTH_STACK_1 (CAESAR_K)
   CAESAR_TYPE_STACK_1 CAESAR_K;
   { ... }
\fP
.fi
This function returns the number of items in the stack pointed to by \fBCAESAR_K\fP. It returns 0 if this stack is empty.
.sp
Note: the depth of a stack is the number of states (not the number of labels) stored in the stack. Even if a stack contains only a single state (in a depth-first search, this state is likely to be the initial state of the graph), the depth of the stack will be 1, not 0.
.sp
.P
 ............................................................
.SS \fBCAESAR_BREADTH_STACK_1\fP
 \&
.nf
\fBCAESAR_TYPE_NATURAL CAESAR_BREADTH_STACK_1 (CAESAR_K)
   CAESAR_TYPE_STACK_1 CAESAR_K;
   { ... }
\fP
.fi
This function returns the number of items that have not been explored yet in the stack pointed to by \fBCAESAR_K\fP. More precisely, it returns the sum, for all stack items, of the respective lengths of the ``edge'' fields of these items.
.sp
.P
 ............................................................
.SS \fBCAESAR_TOP_STATE_STACK_1\fP
 \&
.nf
\fBCAESAR_TYPE_STATE CAESAR_TOP_STATE_STACK_1 (CAESAR_K)
   CAESAR_TYPE_STACK_1 CAESAR_K;
   { ... }
\fP
.fi
This function returns a pointer to the ``state'' field of the item on the top of the stack pointed to by \fBCAESAR_K\fP. If the stack is empty, the result is undefined.
.sp
.P
 ............................................................
.SS \fBCAESAR_TOP_LABEL_STACK_1\fP
 \&
.nf
\fBCAESAR_TYPE_LABEL CAESAR_TOP_LABEL_STACK_1 (CAESAR_K)
   CAESAR_TYPE_STACK_1 CAESAR_K;
   { ... }
\fP
.fi
This function returns a pointer to the ``label'' field of the item on the top of the stack pointed to by \fBCAESAR_K\fP. If the stack is empty, the result is undefined.
.sp
.P
 ............................................................
.SS \fBCAESAR_TOP_EDGE_STACK_1\fP
 \&
.nf
\fBCAESAR_TYPE_EDGE CAESAR_TOP_EDGE_STACK_1 (CAESAR_K)
   CAESAR_TYPE_STACK_1 CAESAR_K;
   { ... }
\fP
.fi
This function returns a pointer to the ``edge'' field of the item on the top of the stack pointed to by \fBCAESAR_K\fP. If the stack is empty, the result is undefined.
.sp
.P
 ............................................................
.SS \fBCAESAR_EMPTY_STACK_1\fP
 \&
.nf
\fBCAESAR_TYPE_BOOLEAN CAESAR_EMPTY_STACK_1 (CAESAR_K)
   CAESAR_TYPE_STACK_1 CAESAR_K;
   { ... }
\fP
.fi
This function returns a value different from 0 if the stack pointed to by \fBCAESAR_K\fP is empty, and 0 otherwise. \fBCAESAR_EMPTY_STACK_1 (CAESAR_K)\fP is always equivalent to:
.TS
center;
l.
 
 \fBCAESAR_DEPTH_STACK_1 (CAESAR_K) == 0\fP 
 
.TE
.sp
.P
 ............................................................
.SS \fBCAESAR_EXPLORED_STACK_1\fP
 \&
.nf
\fBCAESAR_TYPE_BOOLEAN CAESAR_EXPLORED_STACK_1 (CAESAR_K)
   CAESAR_TYPE_STACK_1 CAESAR_K;
   { ... }
\fP
.fi
This function returns a value different from 0 if the ``edge'' field of the item on the top of the stack pointed to by \fBCAESAR_K\fP is equal to \fBNULL\fP (i.e., the empty edge list), and 0 otherwise. If the stack is empty, the result is undefined. \fBCAESAR_EXPLORED_STACK_1 (CAESAR_K)\fP is always equivalent to:
.TS
center;
l.
 
 \fB*(CAESAR_TOP_EDGE_STACK_1 (CAESAR_K)) == NULL\fP 
 
.TE
.sp
.P
 ............................................................
.SS \fBCAESAR_CREATE_TOP_EDGE_STACK_1\fP
 \&
.nf
\fBvoid CAESAR_CREATE_TOP_EDGE_STACK_1 (CAESAR_K)
   CAESAR_TYPE_STACK_1 CAESAR_K;
   { ... }
\fP
.fi
This procedure computes the list of the edges going out from the ``state'' field of the top of the stack pointed to by \fBCAESAR_K\fP, and assigns the result to the ``edge'' field of the stack top.
.sp
If the stack is empty, or if the ``edge'' field of the stack top is not equal to the empty list when the procedure is called, the result is undefined.
.sp
This is done by calling the \fBCAESAR_CREATE_EDGE_LIST()\fP procedure of the ``edge'' library. The actual value given to the formal parameter \fBCAESAR_ORDER\fP of this procedure is equal to the actual value of the formal parameter \fBCAESAR_ORDER\fP at the time the stack was created using \fBCAESAR_CREATE_STACK_1()\fP.
.sp
In case of memory shortage, either when allocating the new item or the list of its outgoing edges, the overflow procedure associated with \fBCAESAR_K\fP is called with the actual parameter \fBCAESAR_K\fP.
.sp
The functions \fBCAESAR_CREATION_EDGE_LIST()\fP and \fBCAESAR_TRUNCATION_EDGE_LIST()\fP can be used in the overflow procedure. They can also be used after any call to \fBCAESAR_CREATE_TOP_EDGE_STACK_1()\fP, assuming that the overflow procedure has not aborted the program.
.sp
.P
 ............................................................
.SS \fBCAESAR_DELETE_TOP_EDGE_STACK_1\fP
 \&
.nf
\fBvoid CAESAR_DELETE_TOP_EDGE_STACK_1 (CAESAR_K)
   CAESAR_TYPE_STACK_1 CAESAR_K;
   { ... }
\fP
.fi
This procedure frees the list of the edges in the ``edge'' field of the top of the stack pointed to by \fBCAESAR_K\fP. Afterwards, the \fBNULL\fP value is assigned to the ``edge'' field of the stack top.
.sp
If the stack is empty, the result is undefined.
.sp
.P
 ............................................................
.SS \fBCAESAR_PUSH_STACK_1\fP
 \&
.nf
\fBvoid CAESAR_PUSH_STACK_1 (CAESAR_K, CAESAR_L, CAESAR_S)
   CAESAR_TYPE_STACK_1 CAESAR_K;
   CAESAR_TYPE_LABEL CAESAR_L;
   CAESAR_TYPE_STATE CAESAR_S;
   { ... }
\fP
.fi
This procedure allocates a new item, using \fBCAESAR_CREATE()\fP, and pushes it onto the top of the stack pointed to by \fBCAESAR_K\fP.
.sp
The label pointed to by \fBCAESAR_L\fP is copied into the ``label'' field of the new stack top. However, if \fBCAESAR_L\fP is equal to \fBNULL\fP, the ``label'' field of the new stack top is left undefined (this is useful for pushing the base when the stack is still empty).
.sp
The state pointed to by \fBCAESAR_S\fP is copied into the ``state'' field of the new stack top. However, if \fBCAESAR_S\fP is equal to \fBNULL\fP, the ``state'' field of the new stack top is left undefined (this is useful for pushing the base when the stack is still empty).
.sp
The ``edge'' field of the new stack top is initialized to \fBNULL\fP.
.sp
In case of memory shortage when allocating the new item, the overflow procedure associated with \fBCAESAR_K\fP is called with the actual parameter \fBCAESAR_K\fP.
.sp
.P
 ............................................................
.SS \fBCAESAR_POP_STACK_1\fP
 \&
.nf
\fBvoid CAESAR_POP_STACK_1 (CAESAR_K)
   CAESAR_TYPE_STACK_1 CAESAR_K;
   { ... }
\fP
.fi
This procedure pops the item on the top of the stack pointed to by \fBCAESAR_K\fP. This item is freed using \fBCAESAR_DELETE()\fP.
.sp
If the stack is empty, or if the ``edge'' field of the old stack top is not equal to the empty list, the result is undefined.
.sp
.P
 ............................................................
.SS \fBCAESAR_SWAP_STACK_1\fP
 \&
.nf
\fBvoid CAESAR_SWAP_STACK_1 (CAESAR_K)
   CAESAR_TYPE_STACK_1 CAESAR_K;
   { ... }
\fP
.fi
This procedure removes the first item of the list of edges pointed to by the ``edge'' field of the top of the stack pointed to by \fBCAESAR_K\fP, and pushes it onto the top of the stack.
.sp
If the stack is empty, or if the ``edge'' field of the old stack top is equal to the empty list, the result is undefined.
.sp
.P
 ............................................................
.SS \fBCAESAR_REJECT_STACK_1\fP
 \&
.nf
\fBvoid CAESAR_REJECT_STACK_1 (CAESAR_K)
   CAESAR_TYPE_STACK_1 CAESAR_K;
   { ... }
\fP
.fi
This procedure removes the first item of the list of edges pointed to by the ``edge'' field of the top of the stack pointed to by \fBCAESAR_K\fP. This item is freed using \fBCAESAR_DELETE()\fP.
.sp
If the stack is empty, or if the ``edge'' field of the old stack top is equal to the empty list, the result is undefined.
.sp
.P
 ............................................................
.SS \fBCAESAR_FORMAT_STACK_1\fP
 \&
.nf
\fBCAESAR_TYPE_FORMAT CAESAR_FORMAT_STACK_1 (CAESAR_K, CAESAR_FORMAT)
   CAESAR_TYPE_STACK_1 CAESAR_K;
   CAESAR_TYPE_FORMAT CAESAR_FORMAT;
   { ... }
\fP
.fi
This function allows to control the format under which the stack pointed to by \fBCAESAR_K\fP will be printed by the procedure \fBCAESAR_PRINT_STACK_1()\fP (see below). Currently, the following formats are available:
.sp
.IP -
With format 0, statistical information about the stack is displayed such as: current depth, memory size, etc.
.IP -
With format 1, the items are printed from the stack base to the stack top. For each item, the ``label'' field is printed; however, the ``label'' field of the stack base is not printed, since it is supposed to be undefined. The ``state'' and ``edge'' fields are not printed.
.sp
This format can be used to display the execution sequence leading from the initial state to the current state.
.IP -
With format 2, the items are printed from the stack base to the stack top. For each item, the ``label'' and ``state'' fields are printed; however, the ``label'' field of the stack base is not printed, since it is supposed to be undefined. The ``edge'' fields are not printed.
.sp
This format is intended mainly for debugging purpose.
.IP -
With format 3, the items are printed from the stack top to the stack base. For each item, the ``label'' and ``state'' fields are printed; however, the ``label'' field of the stack base is not printed, since it is supposed to be undefined. The ``edge'' fields are not printed.
.sp
This format is intended mainly for debugging purpose.
.IP -
With format 4, the items are printed from the stack base to the stack top. For each item, the ``label'', ``state'', and ``edge'' fields are printed; however, the ``label'' field of the stack base is not printed, since it is supposed to be undefined.
.sp
This format is intended mainly for debugging purpose.
.IP -
With format 5, the items are printed from the stack top to the stack base. For each item, the ``label'', ``state'', and ``edge'' fields are printed; however, the ``label'' field of the stack base is not printed, since it is supposed to be undefined.
.sp
This format is intended mainly for debugging purpose.
.IP -
(no other format available yet).
.P
Note: whatever the format chosen, the stack will be displayed in a form compatible with the SEQ format defined in the \fBseq\fP manual page of CADP.
.sp
By default, the current format of each stack is initialized to 0.
.sp
When called with \fBCAESAR_FORMAT\fP between 0 and 5, this fonction sets the current format of \fBCAESAR_K\fP to \fBCAESAR_FORMAT\fP and returns an undefined result.
.sp
When called with another value of \fBCAESAR_FORMAT\fP, this function does not modify the current format of \fBCAESAR_K\fP but returns a result defined as follows. If \fBCAESAR_FORMAT\fP is equal to the constant \fBCAESAR_CURRENT_FORMAT\fP, the result is the value of the current format of \fBCAESAR_K\fP. If \fBCAESAR_FORMAT\fP is equal to the constant \fBCAESAR_MAXIMAL_FORMAT\fP, the result is the maximal format value (i.e., 5). In all other cases, the effect of this function is undefined.
.sp
.P
 ............................................................
.SS \fBCAESAR_MAX_FORMAT_STACK_1\fP
 \&
.nf
\fBCAESAR_TYPE_FORMAT CAESAR_MAX_FORMAT_STACK_1 ()
   { ... }
\fP
.fi
Caution! This function is deprecated. It should no longer be used, as it might be removed from future versions of the \fIOPEN/CAESAR\fP. Use function \fBCAESAR_FORMAT_STACK_1()\fP instead, called with argument \fBCAESAR_MAXIMAL_FORMAT\fP.
.sp
This function returns the maximal format value available for printing stacks.
.sp
.P
 ............................................................
.SS \fBCAESAR_PRINT_STACK_1\fP
 \&
.nf
\fBvoid CAESAR_PRINT_STACK_1 (CAESAR_FILE, CAESAR_K)
   CAESAR_TYPE_FILE CAESAR_FILE;
   CAESAR_TYPE_STACK_1 CAESAR_K;
   { ... }
\fP
.fi
This procedure prints to file \fBCAESAR_FILE\fP a text containing information about the stack pointed to by \fBCAESAR_K\fP. The nature of the information is determined by the current format of the stack pointed to by \fBCAESAR_K\fP.
.sp
Before this procedure is called, \fBCAESAR_FILE\fP must have been properly opened, for instance using \fBfopen(3)\fP.
.sp
.SH EXAMPLE
The following portion of C code implements a standard depth-first search using the above primitives:
.sp
 \&
.nf
\fB#include "caesar_stack_1.h"
 
int main ()
{
CAESAR_TYPE_STACK_1 caesar_k;
 
CAESAR_INIT_GRAPH ();
CAESAR_INIT_STACK_1 ();
 
CAESAR_CREATE_STACK_1 (&caesar_k, 0, NULL);
CAESAR_PUSH_STACK_1 (caesar_k, NULL, NULL);
CAESAR_START_STATE (CAESAR_TOP_STATE_STACK_1 (caesar_k));
CAESAR_CREATE_TOP_EDGE_STACK_1 (caesar_k);
 
while (! CAESAR_EMPTY_STACK_1 (caesar_k)) {
        if (CAESAR_EXPLORED_STACK_1 (caesar_k))
                CAESAR_POP_STACK_1 (caesar_k);
        else if /* first successor already known */
                CAESAR_REJECT_STACK_1 (caesar_k);
        else    {
                CAESAR_SWAP_STACK_1 (caesar_k);
                CAESAR_CREATE_TOP_EDGE_STACK_1 (caesar_k);
                /* add new top in the heap */
             }
        }
exit (0);
}
\fP
.fi
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
