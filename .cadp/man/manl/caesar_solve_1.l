'\" t
.\" @(#)caesar_solve_1.l - VASY and CONVECS teams - version 1.3
.TH caesar_solve_1 LOCAL "2020/02/11 (version 1.3)" "(C) INRIA" "OPEN/CAESAR MANUAL"
.fp 4 CB
.lg 0
.SH NAME
caesar_solve_1 \- the ``solve_1'' library of OPEN/CAESAR
.SH PURPOSE
The ``solve_1'' library provides primitives for solving alternation-free boolean equation systems, which are either provided ``on the fly'' or given as a text file encoded in the \fBBES\fP format. This library can be used as a back-end for various on the fly verification tools that formulate their corresponding problems (e.g., equivalence checking, model checking, tau-confluence reduction, etc.) in terms of boolean equation systems.
.sp
.sp
.SH USAGE
The ``solve_1'' library consists of:
.IP -
a predefined header file \fBcaesar_solve_1.h\fP;
.IP -
the precompiled library file \fBlibcaesar.a\fP, which implements the features described in \fBcaesar_solve_1.h\fP.
.P
Note: The ``solve_1'' library is a software layer built above the primitives offered by the ``standard'', ``area_1'', ``table_1'', and ``hash'' libraries, and by the \fIOPEN/CAESAR\fP graph module.
.sp
.sp
.SH BOOLEAN EQUATION SYSTEMS
See the \fBbes\fP manual page of CADP for:
.sp
.IP -
a definition of boolean equation systems and their terminology: equation blocks, boolean variables, conjunctive and disjunctive formulas, conjunctive and disjunctive variables, dependencies between variables, dependencies between blocks, alternation-free systems, block indexes, variable indexes, sign of a block, etc.
.IP -
a specification of the \fBBES\fP format that is used to store boolean equation systems in text files having the extension ``.bes''.
.P
.sp
.SH ON THE FLY RESOLUTION
Given a boolean equation system, the on the fly (or local) resolution problem consists in computing the value of a particular variable defined in some block of the system. Contrary to global resolution, which consists in computing the values of all variables defined in the system (and therefore must examine all equations of the system), on the fly resolution computes the value of a variable without necessarily examining all equations of the system. This resolution technique allows to construct the boolean equation system in a demand-driven manner, and hence it is useful for building tools for on the fly verification, which explore one or more labelled transition systems incrementally.
.sp
The on the fly resolution method for alternation-free boolean equation systems implemented in the ``solve_1'' library proceeds as follows. To each equation block of the system is associated a resolution routine responsible for computing the values of the variables defined in the block. When the routine associated to a block is called to compute the value of a variable defined in that block, it may in turn call the routines associated to other blocks to compute the values of other variables defined in those blocks. Assuming that all resolution routines associated to the blocks will eventually terminate, the overall resolution process will also terminate, because the size of the call stack of resolution routines is bounded by the number N of blocks in the boolean equation system (since the system is alternation-free, there are no cyclic dependencies between blocks).
.sp
.sp
.SH BOOLEAN GRAPHS
The resolution routines associated to the equation blocks are easier to develop using a representation of blocks as boolean graphs, which provide a more intuitive view of the dependencies between boolean variables. Given an equation block, its corresponding boolean graph is defined as follows:
.IP -
For each boolean variable occurring in the block, there is a vertex in the boolean graph.
.IP -
For each dependency from a boolean variable \fBXi\fP to a boolean variable \fBXj\fP, there is an edge ``(\fBXi\fP, \fBXj\fP)'' in the boolean graph.
.IP -
Each vertex of the boolean graph is labeled as disjunctive or conjunctive according to the kind of the boolean variable it denotes.
.P
Boolean variables whose defining equations have right-hand side formulas identical to \fBfalse\fP (resp. \fBtrue\fP) are represented in the boolean graph as disjunctive (resp. conjunctive) vertices without successors. Dependencies between different equation blocks are represented as edges between the boolean graphs associated to the blocks.
.sp
The boolean graph associated to the boolean equation system above is shown below (edges are represented as couples of boolean variables, the kind of which is indicated between brackets).
 \&
.nf
\fB    (* graph for B0 *)
       (X0_0 [and], X1_0 [or])
       (X0_0 [and], X2_0 [and])
       (X1_0 [or],  X0_0 [and])
       (X1_0 [or],  X1_0 [or])
       (X1_0 [or],  X2_0 [and])
       (X2_0 [and], X0_1 [or])
       (X2_0 [and], X3_0 [or])
       (X3_0 [or],  X1_0 [or])
       (X3_0 [or],  X4_0 [and])
 
    (* graph for B1 *)
       (X0_1 [or],  X1_1 [or])
       (X0_1 [or],  X2_1 [and])
       (X2_1 [and], X2_1 [and])
       (X2_1 [and], X3_1 [or])
       (X3_1 [or],  X0_1 [or])
       (X3_1 [or],  X1_1 [or])
       (X3_1 [or],  X3_1 [or])
\fP
.fi
For each equation block, its corresponding resolution routine will explore forward the boolean graph associated to the block and will propagate backward the values of boolean variables already stabilized (i.e., the value of which has been determined). When solving a boolean variable, only the part of the boolean graph relevant for deciding the value of the variable is explored. For instance, the part of the boolean graph explored for solving variable \fBX0_0\fP of the boolean equation system above is shown below (all boolean variables contained in this part of the boolean graph are false).
 \&
.nf
\fB    (* resolution graph for B0 *)
       (X0_0 [and], X1_0 [or])
       (X0_0 [and], X2_0 [and])
       (X1_0 [or],  X0_0 [and])
       (X1_0 [or],  X1_0 [or])
       (X1_0 [or],  X2_0 [and])
       (X2_0 [and], X0_1 [or])
 
    (* resolution graph for B1 *)
       (X0_1 [or],  X1_1 [or])
       (X0_1 [or],  X2_1 [and])
       (X2_1 [and], X2_1 [and])
\fP
.fi
The resolution was carried out as follows. After exploring variables \fBX0_0\fP and \fBX1_0\fP, the current unexplored successor of \fBX0_0\fP is \fBX2_0\fP. The exploration of \fBX2_0\fP is started by visiting variable \fBX0_1\fP, which is defined in block \fBB1\fP. This variable depends on \fBX1_1\fP, whose value is false (disjunctive vertex without successors) and \fBX2_1\fP, whose value is also false (conjunctive vertex with a self-loop in a minimal fixed point block). Thus, variable \fBX0_1\fP is false, and by propagating its value backward, variables \fBX2_0\fP and \fBX0_0\fP become false (conjunctive vertices with a successor equal to false).
.sp
.sp
.SH RESOLUTION MODES
The ``solve_1'' library implements various algorithms (named ``resolution modes'') to solve boolean equation systems by exploring their associated boolean graphs. For efficiency reasons, each equation block of the same boolean equation system may be solved using the most appropriate algorithm. Currently, the following resolution modes are available:
.sp
.IP -
Mode 0 corresponds to a resolution algorithm based upon a depth-first search of the boolean graph associated to the equation block. This algorithm can be applied to any kind of equation block.
.IP -
Mode 1 corresponds to a resolution algorithm based upon a breadth-first search of the boolean graph associated to the equation block. This algorithm can be applied to any kind of equation block. In practice, it performs slightly slower than mode 0, but produces diagnostics of smaller depth.
.IP -
Mode 2 corresponds to a resolution algorithm based upon a depth-first search of the boolean graph associated to the equation block. This algorithm can be applied only to acyclic equation blocks, i.e., without cyclic dependencies between variables. In practice, it consumes less memory than modes 0 and 1.
.IP -
Mode 3 corresponds to a resolution algorithm based upon a depth-first search of the boolean graph associated to the equation block. This algorithm can be applied only to disjunctive equation blocks, i.e., whose right-hand sides of equations are either (a) disjunctive formulas, or (b) conjunctive formulas whose operands are constants or variables defined in other blocks, with the possible exception of the last operand, which may be a variable defined in the current block (e.g., \fBtrue and X1_j and false and X2\fP, where \fBX1_j\fP is defined in another block of index \fBj\fP and \fBX2\fP is defined in the current block). In practice, it consumes less memory than modes 0 and 1.
.IP -
Mode 4 corresponds to a resolution algorithm based upon a depth-first search of the boolean graph associated to the equation block. This algorithm can be applied only to conjunctive equation blocks, i.e., whose right-hand sides of equations are either (a) conjunctive formulas, or (b) disjunctive formulas whose operands are constants or variables defined in other blocks, with the possible exception of the last operand, which may be a variable defined in the current block (e.g., \fBfalse or X1_j or true or X2\fP, where \fBX1_j\fP is defined in another block of index \fBj\fP and \fBX2\fP is defined in the current block). In practice, it consumes less memory than modes 0 and 1.
.IP -
Mode 5 corresponds to a resolution algorithm based upon a depth-first search of the boolean graph associated to the equation block. This algorithm can be applied to any kind of equation block. In practice, it exhibits a better performance than mode 0 when applied to equation blocks containing alternating dependencies between disjunctive and conjunctive variables (e.g., the equation blocks encoding equivalence checking problems).
.IP -
Mode 6 corresponds to a resolution algorithm based upon a breadth-first search of the boolean graph associated to the equation block. This algorithm can be applied only to disjunctive minimal fixed point equation blocks for which a single resolution was specified. In practice, it consumes less memory than mode 1 and produces diagnostics of smaller depth than mode 3.
.IP -
Mode 7 corresponds to a resolution algorithm based upon a breadth-first search of the boolean graph associated to the equation block. This algorithm can be applied only to conjunctive maximal fixed point equation blocks for which a single resolution was specified. In practice, it consumes less memory than mode 1 and produces diagnostics of smaller depth than mode 4.
.IP -
Mode 8 corresponds to a resolution algorithm based upon a depth-first search of the boolean graph associated to the equation block. This algorithm can be applied to any kind of equation block. In practice, it consumes less memory than modes 0 and 5, being especially useful for solving minimal (resp. maximal) fixed point equation blocks containing many conjunctive (resp. disjunctive) variables.
.IP -
Mode 9 corresponds to a resolution algorithm based upon a breadth-first search of the boolean graph associated to the equation block. This algorithm can be applied only to acyclic equation blocks, i.e., without cyclic dependencies between variables. When applied to an acyclic block consisting of singular equations (i.e., having only one boolean variable in their right-hand sides), whose boolean graph is a sequence, this algorithm consumes a bounded amount of memory, independent of the number of equations in the block (length of the sequence).
.IP -
(no other resolution mode available yet)
.P
.sp
.SH INTERNAL REPRESENTATION
To enable on the fly exploration, the boolean graphs associated to the equation blocks of a boolean equation system are represented in a generic, implicit manner using a scheme similar to the one defined by the \fIOPEN/CAESAR\fP graph module for representing labelled transition systems. This representation roughly consists of the following ingredients (see procedure \fBCAESAR_CREATE_SOLVE_1()\fP below for additional details):
.IP -
Boolean variables (vertices of the boolean graph) are represented as pointers to memory areas of fixed size (for each equation block, all variables defined in that block must have the same size). The precise meaning of the variable contents is defined by the application program and is not relevant for the resolution algorithms.
.IP -
Each equation block is equipped with several functions computing various information about the variables defined in the block: a function returning the kind of a variable (disjunctive or conjunctive), a comparison function, a hashing function, a printing function, and an iterator procedure which enumerates the successors of a variable in the boolean graph.
.IP -
Application programs may also associate, to each edge of the boolean graph, a specific information (label) represented as a pointer to a memory area. The contents of these memory areas are not meaningful for the resolution algorithms, which manipulate the pointers to these areas only by copying them and (possibly) by comparing them to \fBNULL\fP.
.P
To speed up the overall resolution process, each equation block of the boolean equation system has associated an internal table which stores the boolean variables already explored during the previous calls of the resolution routine associated to the block. This avoids recomputations of boolean variables by subsequent calls of the same resolution routine, leading to an overall resolution process of time complexity linear in the size of the boolean equation system (number of variables and operators).
.sp
.sp
.SH DIAGNOSTIC GENERATION
A diagnostic for a boolean variable is a boolean subgraph rooted at the vertex corresponding to the variable, which illustrates the truth value computed for the variable. If the boolean variable is \fBtrue\fP (resp. \fBfalse\fP), then the diagnostic is called example (resp. counterexample). Disjunctive (resp. conjunctive) vertices belonging to an example have only one successor (resp. all their successors) contained in the example. Disjunctive (resp. conjunctive) vertices belonging to a counterexample have all their successors (resp. only one successor) contained in the counterexample.
.sp
The diagnostic of a boolean variable defined in an equation block is always contained in the part of the boolean graph explored by the resolution routine associated to that block when it solved the variable. A counterexample for variable \fBX0_0\fP of the boolean equation system above is shown below.
 \&
.nf
\fB    (* diagnostic graph for X0_0 in B0 *)
       (X0_0 [and], X2_0 [and])
       (X2_0 [and], X0_1 [or])
 
    (* diagnostic graph for X0_1 in B1 *)
       (X0_1 [or],  X1_1 [or])
       (X0_1 [or],  X2_1 [and])
       (X2_1 [and], X2_1 [and])
\fP
.fi
To speed up the generation of diagnostics, resolution routines also compute diagnostic-related information which is kept in the internal tables associated to the blocks. Diagnostics are represented in a generic, implicit manner using a scheme similar to the one defined by the \fIOPEN/CAESAR\fP graph module for representing labelled transition systems. This representation is based upon an iterator procedure that enumerates the successors of a variable contained in its diagnostic (see procedure \fBCAESAR_ITERATE_DIAGNOSTIC_SOLVE_1()\fP below).
.sp
Application programs can generate diagnostics by exploring them using this iterator procedure. To spare memory, the successors of a boolean variable contained in its diagnostic are provided by the iterator procedure as pointers to variables that were stored in the internal tables when the variable was solved (see procedure \fBCAESAR_START_DIAGNOSTIC_SOLVE_1()\fP below). Consequently, these variables should neither be modified, nor freed by the application program.
.sp
Note: Edges contained in diagnostics preserve the information (label) that was attached to the edges of the boolean graph by the application program (see procedure \fBCAESAR_CREATE_SOLVE_1()\fP below).
.sp
.sp
.SH DESCRIPTION
The ``solve_1'' library allows to create and handle boolean equation systems on the fly, providing procedures for resolution, inspection, diagnostic generation, reading from, and writing to text files.
.sp
.sp
.SH FEATURES
.P
 ............................................................
.SS \fBCAESAR_TYPE_SOLVE_1\fP
 \&
.nf
\fBtypedef CAESAR_TYPE_ABSTRACT (...) CAESAR_TYPE_SOLVE_1;
\fP
.fi
This type denotes a pointer to the concrete representation of a boolean equation system. This representation is supposed to be ``opaque''.
.sp
.P
 ............................................................
.SS \fBCAESAR_TYPE_BLOCK_SIGN_SOLVE_1\fP
 \&
.nf
\fBtypedef CAESAR_TYPE_BOOLEAN CAESAR_TYPE_BLOCK_SIGN_SOLVE_1;
\fP
.fi
This type indicates the sign (minimal or maximal fixed point) associated to an equation block of a boolean equation system.
.sp
.P
 ............................................................
.SS \fBCAESAR_MINIMAL_FIXED_POINT_SOLVE_1\fP
 \&
.nf
\fB#define CAESAR_MINIMAL_FIXED_POINT_SOLVE_1 \e
   ((CAESAR_TYPE_BLOCK_SIGN_SOLVE_1) CAESAR_TRUE)
\fP
.fi
This constant denotes the minimal fixed point sign.
.sp
.P
 ............................................................
.SS \fBCAESAR_MAXIMAL_FIXED_POINT_SOLVE_1\fP
 \&
.nf
\fB#define CAESAR_MAXIMAL_FIXED_POINT_SOLVE_1 \e
   ((CAESAR_TYPE_BLOCK_SIGN_SOLVE_1) CAESAR_FALSE)
\fP
.fi
This constant denotes the maximal fixed point sign.
.sp
.P
 ............................................................
.SS \fBCAESAR_TYPE_VARIABLE_KIND_SOLVE_1\fP
 \&
.nf
\fBtypedef CAESAR_TYPE_BOOLEAN CAESAR_TYPE_VARIABLE_KIND_SOLVE_1;
\fP
.fi
This type indicates the kind (disjunctive or conjunctive) associated to a boolean variable.
.sp
.P
 ............................................................
.SS \fBCAESAR_DISJUNCTIVE_VARIABLE_SOLVE_1\fP
 \&
.nf
\fB#define CAESAR_DISJUNCTIVE_VARIABLE_SOLVE_1 \e
   ((CAESAR_TYPE_VARIABLE_KIND_SOLVE_1) CAESAR_TRUE)
\fP
.fi
This constant denotes the disjunctive variable kind.
.sp
.P
 ............................................................
.SS \fBCAESAR_CONJUNCTIVE_VARIABLE_SOLVE_1\fP
 \&
.nf
\fB#define CAESAR_CONJUNCTIVE_VARIABLE_SOLVE_1 \e
   ((CAESAR_TYPE_VARIABLE_KIND_SOLVE_1) CAESAR_FALSE)
\fP
.fi
This constant denotes the conjunctive variable kind.
.sp
.P
 ............................................................
.SS \fBCAESAR_TYPE_BLOCK_SIGN_FUNCTION_SOLVE_1\fP
 \&
.nf
\fBtypedef CAESAR_TYPE_BLOCK_SIGN_SOLVE_1
   (*CAESAR_TYPE_BLOCK_SIGN_FUNCTION_SOLVE_1) (CAESAR_TYPE_NATURAL);
\fP
.fi
This type denotes a pointer to a function which takes as parameter a natural number (index of an equation block) and returns the sign (minimal or maximal fixed point) of the block.
.sp
.P
 ............................................................
.SS \fBCAESAR_TYPE_VARIABLE_KIND_FUNCTION_SOLVE_1\fP
 \&
.nf
\fBtypedef CAESAR_TYPE_VARIABLE_KIND_SOLVE_1
   (*CAESAR_TYPE_VARIABLE_KIND_FUNCTION_SOLVE_1) (CAESAR_TYPE_POINTER);
\fP
.fi
This type denotes a pointer to a function which takes as parameter a pointer to a boolean variable and returns the kind (disjunctive or conjunctive) of the variable.
.sp
.P
 ............................................................
.SS \fBCAESAR_TYPE_AREA_FUNCTION_SOLVE_1\fP
 \&
.nf
\fBtypedef CAESAR_TYPE_AREA_1
   (*CAESAR_TYPE_AREA_FUNCTION_SOLVE_1) (CAESAR_TYPE_NATURAL);
\fP
.fi
This type denotes a pointer to a function which takes as parameter a natural number (index of an equation block) and returns the area (size and alignment) of the boolean variables defined in that block.
.sp
.P
 ............................................................
.SS \fBCAESAR_TYPE_BOOLEAN_FUNCTION_SOLVE_1\fP
 \&
.nf
\fBtypedef CAESAR_TYPE_BOOLEAN
   (*CAESAR_TYPE_BOOLEAN_FUNCTION_SOLVE_1) (CAESAR_TYPE_NATURAL);
\fP
.fi
This type denotes a pointer to a function which takes as parameter a natural number and returns a boolean value.
.sp
.P
 ............................................................
.SS \fBCAESAR_TYPE_NATURAL_FUNCTION_SOLVE_1\fP
 \&
.nf
\fBtypedef CAESAR_TYPE_NATURAL
   (*CAESAR_TYPE_NATURAL_FUNCTION_SOLVE_1) (CAESAR_TYPE_NATURAL);
\fP
.fi
This type denotes a pointer to a function which takes as parameter a natural number and returns a natural number.
.sp
.P
 ............................................................
.SS \fBCAESAR_TYPE_ERROR_SOLVE_1\fP
 \&
.nf
\fBtypedef enum {
     CAESAR_NONE_SOLVE_1,
     CAESAR_MULTIPLE_RESOLUTION_SOLVE_1,
     CAESAR_MEMORY_SHORTAGE_SOLVE_1,
     CAESAR_RECURSIVE_BLOCK_SOLVE_1,
     CAESAR_CYCLIC_BLOCK_SOLVE_1,
     CAESAR_NOT_DISJUNCTIVE_BLOCK_SOLVE_1,
     CAESAR_NOT_CONJUNCTIVE_BLOCK_SOLVE_1,
     CAESAR_MINIMAL_FIXED_POINT_BLOCK_SOLVE_1,
     CAESAR_MAXIMAL_FIXED_POINT_BLOCK_SOLVE_1
}    CAESAR_TYPE_ERROR_SOLVE_1;
\fP
.fi
This enumerated type defines the error codes produced as a side effect by calls to the function \fBCAESAR_COMPUTE_SOLVE_1()\fP (see below), which performs the resolution of a boolean variable defined in a block of a boolean equation system. The error codes have the following meaning:
.IP -
\fBCAESAR_NONE_SOLVE_1\fP indicates that the resolution was performed successfully.
.IP -
\fBCAESAR_MULTIPLE_RESOLUTION_SOLVE_1\fP indicates that another resolution of a variable of the block was already performed, whereas at the creation of the boolean equation system (see procedure \fBCAESAR_CREATE_SOLVE_1()\fP below) a single resolution was specified for the block.
If one of the resolution algorithms 6 or 7, dedicated to blocks with single resolution, was specified for the block, this error code is produced regardless of the fact that a single resolution was specified or not for the block.
.IP -
\fBCAESAR_MEMORY_SHORTAGE_SOLVE_1\fP indicates that a memory allocation failed during the resolution.
.IP -
\fBCAESAR_RECURSIVE_BLOCK_SOLVE_1\fP indicates the presence of a cyclic dependency between the blocks of the boolean equation system, which violates the alternation-free condition.
.IP -
\fBCAESAR_CYCLIC_BLOCK_SOLVE_1\fP indicates the presence of a cyclic dependency between the variables defined in the block, whereas at the creation of the boolean equation system (see procedure \fBCAESAR_CREATE_SOLVE_1()\fP below) the resolution algorithm 2, dedicated to acyclic blocks, was specified for the block.
.IP -
\fBCAESAR_NOT_DISJUNCTIVE_BLOCK_SOLVE_1\fP indicates that the current block is not disjunctive, whereas at the creation of the boolean equation system (see procedure \fBCAESAR_CREATE_SOLVE_1()\fP below) one of the resolution algorithms 3 or 6, dedicated to disjunctive blocks, was specified for the block.
.IP -
\fBCAESAR_NOT_CONJUNCTIVE_BLOCK_SOLVE_1\fP indicates that the current block is not conjunctive, whereas at the creation of the boolean equation system (see procedure \fBCAESAR_CREATE_SOLVE_1()\fP below) one of the resolution algorithms 4 or 7, dedicated to conjunctive blocks, was specified for the block.
.IP -
\fBCAESAR_MINIMAL_FIXED_POINT_BLOCK_SOLVE_1\fP indicates that the current block denotes a minimal fixed point, whereas at the creation of the boolean equation system (see procedure \fBCAESAR_CREATE_SOLVE_1()\fP below) the resolution algorithm 7, dedicated to maximal fixed point blocks, was specified for the block.
.IP -
\fBCAESAR_MAXIMAL_FIXED_POINT_BLOCK_SOLVE_1\fP indicates that the current block denotes a maximal fixed point, whereas at the creation of the boolean equation system (see procedure \fBCAESAR_CREATE_SOLVE_1()\fP below) the resolution algorithm 6, dedicated to minimal fixed point blocks, was specified for the block.
.P
Note: The error code produced by a call to \fBCAESAR_COMPUTE_SOLVE_1()\fP can be obtained by using the function \fBCAESAR_STATUS_COMPUTE_SOLVE_1()\fP (see below).
.sp
.P
 ............................................................
.SS \fBCAESAR_CREATE_SOLVE_1\fP
 \&
.nf
\fBvoid CAESAR_CREATE_SOLVE_1 (CAESAR_B,
                            CAESAR_NUMBER_OF_BLOCKS,
                            CAESAR_BLOCK_SIGN,
                            CAESAR_BLOCK_UNIQUE_RESOLUTION,
                            CAESAR_BLOCK_SOLVE_MODE,
                            CAESAR_BLOCK_VARIABLE_AREA,
                            CAESAR_BLOCK_LIMIT_SIZE,
                            CAESAR_BLOCK_HASH_SIZE,
                            CAESAR_BLOCK_PRIME,
                            CAESAR_VARIABLE_KIND,
                            CAESAR_VARIABLE_COMPARE,
                            CAESAR_VARIABLE_HASH,
                            CAESAR_VARIABLE_PRINT,
                            CAESAR_VARIABLE_ITERATE,
                            CAESAR_INFO)
   CAESAR_TYPE_SOLVE_1 *CAESAR_B;
   CAESAR_TYPE_NATURAL CAESAR_NUMBER_OF_BLOCKS;
   CAESAR_TYPE_BLOCK_SIGN_FUNCTION_SOLVE_1 CAESAR_BLOCK_SIGN;
   CAESAR_TYPE_BOOLEAN_FUNCTION_SOLVE_1 CAESAR_BLOCK_UNIQUE_RESOLUTION;
   CAESAR_TYPE_NATURAL_FUNCTION_SOLVE_1 CAESAR_BLOCK_SOLVE_MODE;
   CAESAR_TYPE_AREA_FUNCTION_SOLVE_1 CAESAR_BLOCK_VARIABLE_AREA;
   CAESAR_TYPE_NATURAL_FUNCTION_SOLVE_1 CAESAR_BLOCK_LIMIT_SIZE;
   CAESAR_TYPE_NATURAL_FUNCTION_SOLVE_1 CAESAR_BLOCK_HASH_SIZE;
   CAESAR_TYPE_BOOLEAN_FUNCTION_SOLVE_1 CAESAR_BLOCK_PRIME;
   CAESAR_TYPE_VARIABLE_KIND_FUNCTION_SOLVE_1 CAESAR_VARIABLE_KIND;
   CAESAR_TYPE_COMPARE_FUNCTION CAESAR_VARIABLE_COMPARE;
   CAESAR_TYPE_HASH_FUNCTION CAESAR_VARIABLE_HASH;
   CAESAR_TYPE_PRINT_FUNCTION CAESAR_VARIABLE_PRINT;
   void (*CAESAR_VARIABLE_ITERATE) (CAESAR_TYPE_POINTER, CAESAR_TYPE_POINTER,
      void (*) (CAESAR_TYPE_POINTER, CAESAR_TYPE_NATURAL, CAESAR_TYPE_POINTER));
   CAESAR_TYPE_POINTER CAESAR_INFO;
   { ... }
\fP
.fi
This procedure allocates a boolean equation system using \fBCAESAR_CREATE()\fP and assigns its address to \fB*CAESAR_B\fP. If the allocation fails, the \fBNULL\fP value is assigned to \fB*CAESAR_B\fP.
.sp
Note: Because \fBCAESAR_TYPE_SOLVE_1\fP is a pointer type, any variable \fBCAESAR_B\fP of type \fBCAESAR_TYPE_SOLVE_1\fP must be allocated before used, for instance using:
.TS
center;
l.
 
 \fBCAESAR_CREATE_SOLVE_1 (&CAESAR_B, ...);\fP 
 
.TE
.sp
The value of \fBCAESAR_NUMBER_OF_BLOCKS\fP determines the number of equation blocks contained in the boolean equation system. Each equation block will be assigned an unique index in the range 0..\fBCAESAR_NUMBER_OF_BLOCKS\fP - 1. If the value of \fBCAESAR_NUMBER_OF_BLOCKS\fP is zero, the effect is undefined.
.sp
The actual value of the formal parameter \fBCAESAR_BLOCK_SIGN\fP will be stored and associated to the boolean equation system pointed to by \fB*CAESAR_B\fP. It will be used to assign to each equation block its corresponding sign, indicating whether the block denotes a minimal or a maximal fixed point.
.sp
Precisely, the actual value of \fBCAESAR_BLOCK_SIGN\fP should be a pointer to a function with a parameter \fBcaesar_block\fP that returns \fBCAESAR_MINIMAL_FIXED_POINT_SOLVE_1\fP (resp. \fBCAESAR_MAXIMAL_FIXED_POINT_SOLVE_1\fP) if the equation block of index \fBcaesar_block\fP denotes a minimal fixed point (resp. a maximal fixed point), where \fBcaesar_block\fP is in the range 0..\fBCAESAR_NUMBER_OF_BLOCKS\fP - 1.
.sp
The actual value of the formal parameter \fBCAESAR_BLOCK_UNIQUE_RESOLUTION\fP will be stored and associated to the boolean equation system pointed to by \fB*CAESAR_B\fP. It will be used to assign to each equation block a boolean indicating whether only one variable (or several variables) of the block will be solved.
.sp
Precisely, the actual value of \fBCAESAR_BLOCK_UNIQUE_RESOLUTION\fP should be a pointer to a function \fBcaesar_f\fP with a parameter \fBcaesar_block\fP that returns \fBCAESAR_TRUE\fP (resp. \fBCAESAR_FALSE\fP) if only one variable (resp. several variables) of the equation block of index \fBcaesar_block\fP will be solved, where \fBcaesar_block\fP is in the range 0..\fBCAESAR_NUMBER_OF_BLOCKS\fP - 1.
.sp
Note: If only one variable of a block will be solved, the function \fBcaesar_f\fP may return for that block either \fBCAESAR_TRUE\fP, or \fBCAESAR_FALSE\fP, without influencing the resolution result; however, returning \fBCAESAR_TRUE\fP may increase the performance of some resolution algorithms.
.sp
Note: The equation blocks encoding equivalence checking problems are typical examples of blocks for which only one variable must be solved, namely the variable representing the equivalence between the initial states of two labelled transition systems.
.sp
The actual value of the formal parameter \fBCAESAR_BLOCK_SOLVE_MODE\fP will be stored and associated to the boolean equation system pointed to by \fB*CAESAR_B\fP. It will be used to assign to each equation block its corresponding resolution mode, determining which algorithm will be used by the resolution routine associated to the block.
.sp
Precisely, the actual value of \fBCAESAR_BLOCK_SOLVE_MODE\fP should be a pointer to a function \fBcaesar_f\fP with a parameter \fBcaesar_block\fP that returns the resolution mode associated to the equation block of index \fBcaesar_block\fP, where \fBcaesar_block\fP is in the range 0..\fBCAESAR_NUMBER_OF_BLOCKS\fP - 1.
.sp
If the resolution mode returned by \fBcaesar_f\fP for some value of \fBcaesar_block\fP is not among the aforementioned list of available resolution modes, the effect is undefined.
.sp
Note: The resolution algorithms denoted by modes 0, 1, 2, 3, and 4 are described in the publications [Mat03,Mat06a], where they are named A1, A2, A3, and A4. The correspondence between modes and the names of the algorithms is the following:
mode 0 corresponds to A1;
mode 1 corresponds to A2;
mode 2 corresponds to A3;
modes 3 and 4, which are symmetric, correspond to A4.
.sp
Note: If the boolean equation system pointed to by \fB*CAESAR_B\fP contains several equation blocks, each block may have associated a different resolution mode. In practice, this is useful for independently optimizing the resolution of blocks having a particular structure (e.g., acyclic, disjunctive, conjunctive).
.sp
The actual value of the formal parameter \fBCAESAR_BLOCK_VARIABLE_AREA\fP will be stored and associated to the boolean equation system pointed to by \fB*CAESAR_B\fP. It will be used to assign to each equation block the (constant) size and (constant) alignment factor of the boolean variables defined in the block.
.sp
Precisely, the actual value of \fBCAESAR_BLOCK_VARIABLE_AREA\fP should be a pointer to a function with a parameter \fBcaesar_block\fP that returns the area (which indicates the length and alignment factor) of the boolean variables defined in the equation block of index \fBcaesar_block\fP, where \fBcaesar_block\fP is in the range 0..\fBCAESAR_NUMBER_OF_BLOCKS\fP - 1.
.sp
The actual value of the formal parameter \fBCAESAR_BLOCK_LIMIT_SIZE\fP will be stored and associated to the boolean equation system pointed to by \fB*CAESAR_B\fP. It will be used to assign to each equation block the maximal size (number of items) of the internal table associated to the block.
.sp
Precisely, the actual value of \fBCAESAR_BLOCK_LIMIT_SIZE\fP should be a pointer to a function \fBcaesar_f\fP with a parameter \fBcaesar_block\fP that returns the maximal size (number of items) of the internal table associated to the equation block of index \fBcaesar_block\fP, where \fBcaesar_block\fP is in the range 0..\fBCAESAR_NUMBER_OF_BLOCKS\fP - 1. The value returned by \fBcaesar_f\fP must be less or equal to a predefined value M (see the ``table_1'' library). If it is equal to zero, it is replaced by the default value M.
.sp
The actual value of the formal parameter \fBCAESAR_BLOCK_HASH_SIZE\fP will be stored and associated to the boolean equation system pointed to by \fB*CAESAR_B\fP. It will be used to assign to each equation block the size (number of entries) of the hash-table accompanying the internal table associated to the block.
.sp
Precisely, the actual value of \fBCAESAR_BLOCK_HASH_SIZE\fP should be a pointer to a function \fBcaesar_f\fP with a parameter \fBcaesar_block\fP that returns the size (number of entries) of the hash-table accompanying the internal table associated to the equation block of index \fBcaesar_block\fP, where \fBcaesar_block\fP is in the range 0..\fBCAESAR_NUMBER_OF_BLOCKS\fP - 1. If the value returned by \fBcaesar_f\fP for some value of \fBcaesar_block\fP is zero, it is replaced with a default value greater than zero (see the ``table_1'' library).
.sp
The actual value of the formal parameter \fBCAESAR_BLOCK_PRIME\fP will be stored and associated to the boolean equation system pointed to by \fB*CAESAR_B\fP. It will be used to assign to each equation block a boolean value allowing to adjust the size of the hash-table accompanying the internal table associated to the block.
.sp
Precisely, the actual value of \fBCAESAR_BLOCK_PRIME\fP should be a pointer to a function \fBcaesar_f\fP with a parameter \fBcaesar_block\fP that returns a boolean value which will be stored and associated to the equation block of index \fBcaesar_block\fP, where \fBcaesar_block\fP is in the range 0..\fBCAESAR_NUMBER_OF_BLOCKS\fP - 1. If the value returned by \fBcaesar_f\fP for some value of \fBcaesar_block\fP is equal to \fBCAESAR_TRUE\fP and if the value returned by \fBCAESAR_BLOCK_HASH_SIZE\fP for that block is not a prime number, this value will be replaced by the nearest smaller prime number (since some hash functions require prime modulus). Otherwise, the value returned by \fBCAESAR_BLOCK_HASH_SIZE\fP for that block will be kept unchanged (see the ``table_1'' library).
.sp
The actual value of the formal parameter \fBCAESAR_VARIABLE_KIND\fP will be stored and associated to the boolean equation system pointed to by \fB*CAESAR_B\fP. It will be used as a function returning the kind (disjunctive or conjunctive) of the boolean variables defined in an equation block of the system.
.sp
Precisely, the actual value of \fBCAESAR_VARIABLE_KIND\fP should be a pointer to a function \fBcaesar_f\fP with a parameter \fBcaesar_variable\fP that returns \fBCAESAR_DISJUNCTIVE_VARIABLE_SOLVE_1\fP (resp. \fBCAESAR_CONJUNCTIVE_VARIABLE_SOLVE_1\fP) if the boolean variable pointed to by \fBcaesar_variable\fP is disjunctive (resp. conjunctive). The index of the equation block in which the boolean variable pointed to by \fBcaesar_variable\fP is defined can be obtained within \fBcaesar_f\fP by calling the function \fBCAESAR_CURRENT_BLOCK_SOLVE_1()\fP (see below). A pointer to the boolean equation system containing this block (i.e., the value assigned to \fB*CAESAR_B\fP) can be obtained within \fBcaesar_f\fP by calling the function \fBCAESAR_CURRENT_SYSTEM_SOLVE_1()\fP (see below).
.sp
The actual value of the formal parameter \fBCAESAR_VARIABLE_COMPARE\fP will be stored and associated to the boolean equation system pointed to by \fB*CAESAR_B\fP. It will be used as a comparison function for the boolean variables defined in an equation block of the system.
.sp
Precisely, the actual value of \fBCAESAR_VARIABLE_COMPARE\fP should be a pointer to a comparison function \fBcaesar_f\fP with two parameters \fBcaesar_variable_1\fP and \fBcaesar_variable_2\fP that returns \fBCAESAR_TRUE\fP (resp. \fBCAESAR_FALSE\fP) if the boolean variables pointed to by \fBcaesar_variable_1\fP and \fBcaesar_variable_2\fP are equal (resp. different). The index of the equation block in which the boolean variables pointed to by \fBcaesar_variable_1\fP and \fBcaesar_variable_2\fP are defined can be obtained within \fBcaesar_f\fP by calling the function \fBCAESAR_CURRENT_BLOCK_SOLVE_1()\fP (see below). A pointer to the boolean equation system containing this block (i.e., the value assigned to \fB*CAESAR_B\fP) can be obtained within \fBcaesar_f\fP by calling the function \fBCAESAR_CURRENT_SYSTEM_SOLVE_1()\fP (see below).
.sp
The actual value of the formal parameter \fBCAESAR_VARIABLE_HASH\fP will be stored and associated to the boolean equation system pointed to by \fB*CAESAR_B\fP. It will be used as a hash-function for the boolean variables defined in an equation block of the system.
.sp
Precisely, the actual value of \fBCAESAR_VARIABLE_HASH\fP should be a pointer to a hash function \fBcaesar_f\fP with two parameters \fBcaesar_variable\fP and \fBcaesar_modulus\fP that returns a hash-value computed on the byte string \fBcaesar_variable [0]\fP up to \fBcaesar_variable [caesar_size - 1]\fP, where the actual value of \fBcaesar_size\fP will always be equal to the size of the boolean variable pointed to by \fBcaesar_variable\fP. This hash-value must belong to the range 0..\fBcaesar_modulus\fP-1. The index of the equation block in which the boolean variable pointed to by \fBcaesar_variable\fP is defined can be obtained within \fBcaesar_f\fP by calling the function \fBCAESAR_CURRENT_BLOCK_SOLVE_1()\fP (see below). A pointer to the boolean equation system containing this block (i.e., the value assigned to \fB*CAESAR_B\fP) can be obtained within \fBcaesar_f\fP by calling the function \fBCAESAR_CURRENT_SYSTEM_SOLVE_1()\fP (see below).
.sp
The actual value of the formal parameter \fBCAESAR_VARIABLE_PRINT\fP will be stored and associated to the boolean equation system pointed to by \fB*CAESAR_B\fP. It will be used as a printing procedure for the boolean variables defined in an equation block of the system.
.sp
Precisely, the actual value of \fBCAESAR_VARIABLE_PRINT\fP should be a pointer to a printing procedure \fBcaesar_p\fP with two parameters \fBcaesar_file\fP and \fBcaesar_variable\fP that prints to file \fBcaesar_file\fP information about the contents of the boolean variable pointed to by \fBcaesar_variable\fP. The index of the equation block in which the boolean variable pointed to by \fBcaesar_variable\fP is defined can be obtained within \fBcaesar_p\fP by calling the function \fBCAESAR_CURRENT_BLOCK_SOLVE_1()\fP (see below). A pointer to the boolean equation system containing this block (i.e., the value assigned to \fB*CAESAR_B\fP) can be obtained within \fBcaesar_p\fP by calling the function \fBCAESAR_CURRENT_SYSTEM_SOLVE_1()\fP (see below).
.sp
The actual value of the formal parameter \fBCAESAR_VARIABLE_ITERATE\fP will be stored and associated to the boolean equation system pointed to by \fB*CAESAR_B\fP. It will be used as an iterator procedure enumerating all successors of the boolean variables defined in an equation block of the system.
.sp
Any user-defined procedure \fBcaesar_p\fP can be used as an actual value for formal parameter \fBCAESAR_VARIABLE_ITERATE\fP, provided that its declaration has the form:
 \&
.nf
\fB        void caesar_p (caesar_variable_1, caesar_variable_2, caesar_loop)
           CAESAR_TYPE_POINTER caesar_variable_1;
           CAESAR_TYPE_POINTER caesar_variable_2;
           void (*caesar_loop) (CAESAR_TYPE_POINTER, CAESAR_TYPE_NATURAL,
              CAESAR_TYPE_POINTER);
           { ... }
\fP
.fi
This procedure \fBcaesar_p\fP enumerates all successors of the boolean variable pointed to by \fBcaesar_variable_1\fP. The index of the equation block in which the boolean variable pointed to by \fBcaesar_variable_1\fP is defined can be obtained within \fBcaesar_p\fP by calling the function \fBCAESAR_CURRENT_BLOCK_SOLVE_1()\fP (see below). A pointer to the boolean equation system containing this block (i.e., the value assigned to \fB*CAESAR_B\fP) can be obtained within \fBcaesar_p\fP by calling the function \fBCAESAR_CURRENT_SYSTEM_SOLVE_1()\fP (see below). At each iteration performed by \fBcaesar_p\fP, two actions must be carried out:
.IP -
First, the boolean variable pointed to by \fBcaesar_variable_2\fP must be assigned a new value, such that ``(\fBcaesar_variable_1\fP, \fBcaesar_variable_2\fP)'' is an edge of the boolean graph.
.IP -
Second, the procedure pointed to by \fBcaesar_loop\fP must be called. The actual value of the formal parameter \fBcaesar_loop\fP is a procedure \fBcaesar_q\fP whose declaration has the form:
 \&
.nf
\fB        void caesar_q (caesar_label, caesar_block_2, caesar_variable_2)
           CAESAR_TYPE_POINTER caesar_label;
           CAESAR_TYPE_NATURAL caesar_block_2;
           CAESAR_TYPE_POINTER caesar_variable_2;
           { ... }
\fP
.fi
Therefore, each call to the procedure pointed to by \fBcaesar_loop\fP must have the following parameters:
 \&
.nf
\fB     (*caesar_loop) (caesar_label, caesar_block_2, caesar_variable_2)
\fP
.fi
Parameter \fBcaesar_label\fP is either a pointer to a memory area containing additional information associated to the edge ``(\fBcaesar_variable_1\fP, \fBcaesar_variable_2\fP)'' of the boolean graph, or is equal to \fBNULL\fP if no such information is desired.
Parameter \fBcaesar_block_2\fP is the index of the equation block where the boolean variable \fBcaesar_variable_2\fP is defined.
.P
Note: The memory area pointed to by the parameter \fBcaesar_variable_1\fP contains a boolean variable and should neither be modified, nor freed by the procedure \fBcaesar_p\fP.
.sp
Note: The memory area pointed to by the parameter \fBcaesar_variable_2\fP is already allocated and should not be freed by the procedure \fBcaesar_p\fP.
.sp
Note: The actual value passed to the parameter \fBcaesar_label\fP when the procedure pointed to by \fBcaesar_loop\fP is invoked by \fBcaesar_p\fP is meaningless with respect to boolean resolution (the value passed to \fBcaesar_label\fP will only be copied and possibly compared to \fBNULL\fP by the resolution algorithms). The parameter \fBcaesar_label\fP allows to attach application-specific information to the edges going out of a boolean variable; this information is retrieved in the diagnostic generated for that variable. For instance, when using the ``solve_1'' library for model checking, \fBcaesar_label\fP may contain a pointer to a label of the labelled transition system on which a temporal logic formula is verified. It is the users' responsibility to manage the memory area pointed to by \fBcaesar_label\fP; in particular, it is recommended not to free this memory area until the resolution of the boolean equation system is finished.
.sp
The value of \fBCAESAR_INFO\fP has no effect on the execution of procedure \fBCAESAR_CREATE_SOLVE_1()\fP. Parameter \fBCAESAR_INFO\fP is intended to serve for future extensions of this procedure; when using the current version of the ``solve_1'' library, it is recommended to set this parameter to \fBNULL\fP.
.sp
.P
 ............................................................
.SS \fBCAESAR_CURRENT_SYSTEM_SOLVE_1\fP
 \&
.nf
\fBCAESAR_TYPE_SOLVE_1 CAESAR_CURRENT_SYSTEM_SOLVE_1 ()
   { ... }
\fP
.fi
This function returns a pointer to the boolean equation system which is currently under resolution. It should be called only within the functions and procedures given as actual values for the formal parameters \fBCAESAR_VARIABLE_KIND\fP, \fBCAESAR_VARIABLE_COMPARE\fP, \fBCAESAR_VARIABLE_HASH\fP, \fBCAESAR_VARIABLE_PRINT\fP, and \fBCAESAR_VARIABLE_ITERATE\fP of procedure \fBCAESAR_CREATE_SOLVE_1()\fP (see above); in this case, the result is a pointer to the boolean equation system created by the call to \fBCAESAR_CREATE_SOLVE_1()\fP. If this function is called anywhere else in the application program, the result is undefined.
.sp
Note: This function allows to invoke, within the five aforementioned functions and procedures, various primitives of the ``solve_1'' library on the current boolean equation system (e.g., resolution, printing, etc.).
.sp
.P
 ............................................................
.SS \fBCAESAR_CURRENT_BLOCK_SOLVE_1\fP
 \&
.nf
\fBCAESAR_TYPE_NATURAL CAESAR_CURRENT_BLOCK_SOLVE_1 ()
   { ... }
\fP
.fi
This function returns the index of the equation block which is currently under resolution; this block is in turn contained in the boolean equation system which is currently under resolution, pointed to by the result of function \fBCAESAR_CURRENT_SYSTEM_SOLVE_1()\fP (see above).
It should be called only within the functions and procedures given as actual values for the formal parameters \fBCAESAR_VARIABLE_KIND\fP, \fBCAESAR_VARIABLE_COMPARE\fP, \fBCAESAR_VARIABLE_HASH\fP, \fBCAESAR_VARIABLE_PRINT\fP, and \fBCAESAR_VARIABLE_ITERATE\fP of procedure \fBCAESAR_CREATE_SOLVE_1()\fP (see above); in this case, the result is the index of the block, i.e., a natural number in the range 0..N-1, where N is the number of blocks in the boolean equation system created by the call to \fBCAESAR_CREATE_SOLVE_1()\fP.
If this function is called anywhere else in the application program, the result is undefined.
.sp
Note: This function allows to identify the block in which the boolean variable(s) passed as arguments to the five aforementioned functions and procedures are defined, and thus to handle these variables accordingly (the size and the contents of variables defined in different blocks may differ). It is especially useful when the number of blocks in the boolean equation system is unknown statically (e.g., when using the ``solve_1'' library for model checking, the number of blocks is inferred from a temporal logic formula read as input).
.sp
.P
 ............................................................
.SS \fBCAESAR_DELETE_SOLVE_1\fP
 \&
.nf
\fBvoid CAESAR_DELETE_SOLVE_1 (CAESAR_B)
   CAESAR_TYPE_SOLVE_1 *CAESAR_B;
   { ... }
\fP
.fi
This procedure frees the memory space corresponding to the boolean equation system pointed to by \fB*CAESAR_B\fP using \fBCAESAR_DELETE()\fP. The boolean variables stored in internal tables allocated during previous resolutions (if any) of the boolean equation system are also freed. Afterwards, the \fBNULL\fP value is assigned to \fB*CAESAR_B\fP.
.sp
.P
 ............................................................
.SS \fBCAESAR_PURGE_BLOCK_SOLVE_1\fP
 \&
.nf
\fBvoid CAESAR_PURGE_BLOCK_SOLVE_1 (CAESAR_B, CAESAR_I)
   CAESAR_TYPE_SOLVE_1 CAESAR_B;
   CAESAR_TYPE_NATURAL CAESAR_I;
   { ... }
\fP
.fi
This procedure reinitializes the information associated to the equation block of index \fBCAESAR_I\fP of the boolean equation system pointed to by \fBCAESAR_B\fP.
The internal table associated to the block is emptied using \fBCAESAR_PURGE_TABLE_1()\fP.
Afterwards, the block is exactly in the same state as after the creation of the boolean equation system using \fBCAESAR_CREATE_SOLVE_1()\fP.
.sp
If the block index \fBCAESAR_I\fP is outside the range 0..N-1 (where N is the number of blocks in the system), the result is undefined.
.sp
.P
 ............................................................
.SS \fBCAESAR_COMPUTE_SOLVE_1\fP
 \&
.nf
\fBCAESAR_TYPE_BOOLEAN CAESAR_COMPUTE_SOLVE_1 (CAESAR_B, CAESAR_I, CAESAR_V)
   CAESAR_TYPE_SOLVE_1 CAESAR_B;
   CAESAR_TYPE_NATURAL CAESAR_I;
   CAESAR_TYPE_POINTER CAESAR_V;
   { ... }
\fP
.fi
This function computes the value of the boolean variable pointed to by \fBCAESAR_V\fP, which must be defined in the equation block of index \fBCAESAR_I\fP of the boolean equation system pointed to by \fBCAESAR_B\fP. It also sets a field of type \fBCAESAR_TYPE_ERROR_SOLVE_1\fP associated to the block, indicating whether the resolution was carried out successfully or not; this field can be inspected using the function \fBCAESAR_STATUS_COMPUTE_SOLVE_1()\fP (see below).
.sp
If the block index \fBCAESAR_I\fP is outside the range 0..N-1 (where N is the number of blocks in the system), the result is undefined.
.sp
.P
 ............................................................
.SS \fBCAESAR_STATUS_COMPUTE_SOLVE_1\fP
 \&
.nf
\fBCAESAR_TYPE_ERROR_SOLVE_1 CAESAR_STATUS_COMPUTE_SOLVE_1 (CAESAR_B, CAESAR_I)
   CAESAR_TYPE_SOLVE_1 CAESAR_B;
   CAESAR_TYPE_NATURAL CAESAR_I;
   { ... }
\fP
.fi
This function returns the status of the last resolution performed by a call to the function \fBCAESAR_COMPUTE_SOLVE_1()\fP (see above) on a boolean variable defined in the equation block of index \fBCAESAR_I\fP of the boolean equation system pointed to by \fBCAESAR_B\fP.
.sp
If the block index \fBCAESAR_I\fP is outside the range 0..N-1 (where N is the number of blocks in the system), the result is undefined.
.sp
.P
 ............................................................
.SS \fBCAESAR_ITERATE_STABLE_VARIABLE_SOLVE_1\fP
 \&
.nf
\fBvoid CAESAR_ITERATE_STABLE_VARIABLE_SOLVE_1 (CAESAR_B, CAESAR_I, CAESAR_V,
                                             CAESAR_VALUE, CAESAR_LOOP)
   CAESAR_TYPE_SOLVE_1 CAESAR_B;
   CAESAR_TYPE_NATURAL CAESAR_I;
   CAESAR_TYPE_POINTER CAESAR_V;
   CAESAR_TYPE_BOOLEAN *CAESAR_VALUE;
   void (*CAESAR_LOOP) (CAESAR_TYPE_SOLVE_1, CAESAR_TYPE_NATURAL,
      CAESAR_TYPE_POINTER, CAESAR_TYPE_BOOLEAN *);
   { ... }
\fP
.fi
This procedure provides an iterator which enumerates the boolean variables defined in the equation block of index \fBCAESAR_I\fP of the boolean equation system pointed to by \fBCAESAR_B\fP which are stable, i.e., whose value was computed by calls to the function \fBCAESAR_COMPUTE_SOLVE_1()\fP (see above). Only the variables computed since the last call of this procedure (or, in the case of the first call of this procedure, since the creation of the boolean equation system pointed to by \fBCAESAR_B\fP) are enumerated. At each iteration, \fB*CAESAR_VALUE\fP and the boolean variable pointed to by \fBCAESAR_V\fP are assigned a new value, such that \fBCAESAR_V\fP is defined in the block of index \fBCAESAR_I\fP of the boolean equation system pointed to by \fBCAESAR_B\fP and the value computed for \fBCAESAR_V\fP is equal to \fB*CAESAR_VALUE\fP. At each iteration, the procedure pointed to by \fBCAESAR_LOOP\fP is invoked, with the following parameters:
.TS
center;
l.
 
 \fB(*CAESAR_LOOP) (CAESAR_B, CAESAR_I, CAESAR_V, CAESAR_VALUE)\fP 
 
.TE
Therefore, any actual parameter supplied for the formal parameter \fBCAESAR_LOOP\fP must be a pointer to a procedure \fBcaesar_p\fP whose declaration has the following form:
 \&
.nf
\fB        void caesar_p (caesar_bes, caesar_block, caesar_variable, caesar_value)
           CAESAR_TYPE_SOLVE_1 caesar_bes;
           CAESAR_TYPE_NATURAL caesar_block;
           CAESAR_TYPE_POINTER caesar_variable;
           CAESAR_TYPE_BOOLEAN *caesar_value;
           { ... }
\fP
.fi
Note: Parameters \fBCAESAR_V\fP and \fBCAESAR_VALUE\fP must point to (distinct) memory locations allocated before procedure \fBCAESAR_ITERATE_STABLE_VARIABLE_SOLVE_1()\fP is invoked. In no event will \fBCAESAR_ITERATE_STABLE_VARIABLE_SOLVE_1()\fP and \fBCAESAR_LOOP()\fP allocate memory for storing \fBCAESAR_V\fP and \fBCAESAR_VALUE\fP.
.sp
Note: More often than not, this procedure will have side-effects. For instance, this procedure may count the number of stable variables, store them in a list, a table, ...
.sp
Note: It is probably a good programming style to keep the body of this procedure as short as possible.
.sp
Note: The code that implements \fBCAESAR_ITERATE_STABLE_VARIABLE_SOLVE_1()\fP in the current version of the ``solve_1'' library is not reentrant, meaning that nested iterations will not work properly. This implies that any actual procedure \fBcaesar_p\fP passed as value for formal parameter \fBCAESAR_LOOP\fP must not call (directly, nor transitively) \fBCAESAR_ITERATE_STABLE_VARIABLE_SOLVE_1()\fP.
.sp
Note: When invoked to solve a variable of interest, the function \fBCAESAR_COMPUTE_SOLVE_1()\fP usually explores and solves other variables upon which the variable of interest depends. This implies that the set of variables enumerated by a call to \fBCAESAR_ITERATE_STABLE_VARIABLE_SOLVE_1()\fP is usually larger than the set of variables defined in the block of index \fBCAESAR_I\fP of the system pointed to by \fBCAESAR_B\fP on which \fBCAESAR_COMPUTE_SOLVE_1()\fP was invoked since the last call of \fBCAESAR_ITERATE_STABLE_VARIABLE_SOLVE_1()\fP.
.sp
If the block index \fBCAESAR_I\fP is outside the range 0..N-1 (where N is the number of blocks in the system), the effect is undefined.
.sp
.P
 ............................................................
.SS \fBCAESAR_START_DIAGNOSTIC_SOLVE_1\fP
 \&
.nf
\fBvoid CAESAR_START_DIAGNOSTIC_SOLVE_1 (CAESAR_B, CAESAR_I, CAESAR_V,
                                      CAESAR_MINIMAL, CAESAR_P)
   CAESAR_TYPE_SOLVE_1 CAESAR_B;
   CAESAR_TYPE_NATURAL CAESAR_I;
   CAESAR_TYPE_POINTER CAESAR_V;
   CAESAR_TYPE_BOOLEAN CAESAR_MINIMAL;
   CAESAR_TYPE_POINTER *CAESAR_P;
   { ... }
\fP
.fi
This procedure initializes the diagnostic generation for the boolean variable pointed to by \fBCAESAR_V\fP, which must be defined in the equation block of index \fBCAESAR_I\fP of the boolean equation system pointed to by \fBCAESAR_B\fP. It must be called before starting to explore the diagnostic for the boolean variable using the procedure \fBCAESAR_ITERATE_DIAGNOSTIC_SOLVE_1()\fP (see below).
.sp
Diagnostic information is computed by the resolution routines and kept in the internal tables associated to the blocks. Therefore, diagnostics can be generated only for boolean variables that were already solved by calls to \fBCAESAR_COMPUTE_SOLVE_1()\fP (see above). If the boolean variable pointed to by \fBCAESAR_V\fP was previously solved, the address of this boolean variable, which was stored in the internal table associated to the block of index \fBCAESAR_I\fP, is assigned to \fB*CAESAR_P\fP. If the boolean variable pointed to by \fBCAESAR_V\fP was not previously solved or a memory allocation failed during diagnostic recomputation (see below), the \fBNULL\fP value is assigned to \fB*CAESAR_P\fP.
.sp
Note: The memory area pointed to by \fB*CAESAR_P\fP must neither be modified, nor freed by the application program.
.sp
The value of \fBCAESAR_MINIMAL\fP influences the depth of the diagnostic (i.e., the length of the longest sequence without repeated vertices contained in the diagnostic) that will be generated for the boolean variable pointed to by \fBCAESAR_V\fP. If the value of \fBCAESAR_MINIMAL\fP is \fBCAESAR_TRUE\fP, then the diagnostic of the boolean variable will be recomputed in order to reduce its depth. If the value of \fBCAESAR_MINIMAL\fP is \fBCAESAR_FALSE\fP, the diagnostic of the boolean variable will be left unchanged, i.e., as it was computed when the variable was solved.
.sp
Note: Setting the value of \fBCAESAR_MINIMAL\fP to \fBCAESAR_TRUE\fP usually increases diagnostic generation time, especially if the variable pointed to by \fBCAESAR_V\fP was solved using a resolution mode based on depth-first search, such as resolution modes 0, 2, 3, and 4 (see the procedure \fBCAESAR_CREATE_SOLVE_1()\fP above).
.sp
If the block index \fBCAESAR_I\fP is outside the range 0..N-1 (where N is the number of blocks in the system), the effect is undefined.
.sp
.P
 ............................................................
.SS \fBCAESAR_ITERATE_DIAGNOSTIC_SOLVE_1\fP
 \&
.nf
\fBvoid CAESAR_ITERATE_DIAGNOSTIC_SOLVE_1 (CAESAR_B, CAESAR_I1, CAESAR_V1,
                                        CAESAR_L, CAESAR_I2, CAESAR_V2,
                                        CAESAR_LOOP)
   CAESAR_TYPE_SOLVE_1 CAESAR_B;
   CAESAR_TYPE_NATURAL CAESAR_I1;
   CAESAR_TYPE_POINTER CAESAR_V1;
   CAESAR_TYPE_POINTER *CAESAR_L;
   CAESAR_TYPE_NATURAL *CAESAR_I2;
   CAESAR_TYPE_POINTER *CAESAR_V2;
   void (*CAESAR_LOOP) (CAESAR_TYPE_SOLVE_1, CAESAR_TYPE_NATURAL,
      CAESAR_TYPE_POINTER, CAESAR_TYPE_POINTER *,
      CAESAR_TYPE_NATURAL *, CAESAR_TYPE_POINTER *);
   { ... }
\fP
.fi
This procedure provides an iterator which enumerates the successors of the boolean variable pointed to by \fBCAESAR_V1\fP that are contained in the diagnostic of this variable. The variable pointed to by \fBCAESAR_V1\fP must be defined in the equation block of index \fBCAESAR_I1\fP of the boolean equation system pointed to by \fBCAESAR_B\fP. At each iteration, \fB*CAESAR_I2\fP and \fB*CAESAR_V2\fP are respectively assigned a block index and a pointer to a boolean variable such that ``(\fBCAESAR_V1\fP, \fB*CAESAR_V2\fP)'' is an edge of the diagnostic computed for the boolean variable pointed to by \fBCAESAR_V1\fP. The boolean variable pointed to by \fB*CAESAR_V2\fP is defined in the equation block of index \fB*CAESAR_I2\fP and is stored in the internal table associated to that block. Also, \fB*CAESAR_L\fP is assigned the information attached to the edge ``(\fBCAESAR_V1\fP, \fB*CAESAR_V2\fP)'' by the procedure pointed to by \fBcaesar_loop\fP invoked by the iterator procedure \fBcaesar_p\fP given as value for formal parameter \fBCAESAR_VARIABLE_ITERATE\fP when the boolean equation system pointed to by \fBCAESAR_B\fP was created (see procedure \fBCAESAR_CREATE_SOLVE_1()\fP above).
.sp
Note: Parameter \fBCAESAR_V1\fP must contain the address of a boolean variable already stored in the internal table associated to the equation block of index \fBCAESAR_I1\fP. Such addresses of boolean variables are obtained as values assigned to the \fB*CAESAR_P\fP parameter of the \fBCAESAR_START_DIAGNOSTIC_SOLVE_1()\fP procedure (see above) or to the \fB*CAESAR_V2\fP parameter of the \fBCAESAR_ITERATE_DIAGNOSTIC_SOLVE_1()\fP procedure. If parameter \fBCAESAR_V1\fP does not meet this condition, the effect is undefined.
.sp
Note: The memory area pointed to by \fB*CAESAR_V2\fP should neither be modified, nor freed by the application program.
.sp
Note: The memory area pointed to by \fB*CAESAR_L\fP is entirely managed by the application program. The resolution algorithms manipulate the address of this memory area only by copying it and possibly by comparing it to \fBNULL\fP (see also procedure \fBCAESAR_CREATE_SOLVE_1()\fP above).
.sp
At each iteration, the procedure pointed to by \fBCAESAR_LOOP\fP is invoked, with the following parameters:
 \&
.nf
\fB        (*CAESAR_LOOP) (CAESAR_B, CAESAR_I1, CAESAR_V1,
                        CAESAR_L, CAESAR_I2, CAESAR_V2)
\fP
.fi
Therefore, any actual parameter supplied for the formal parameter \fBCAESAR_LOOP\fP must be a pointer to a procedure \fBcaesar_p\fP whose declaration has the following form:
 \&
.nf
\fB        void caesar_p (caesar_bes, caesar_block_1, caesar_variable_1,
                       caesar_label, caesar_block_2, caesar_variable_2)
           CAESAR_TYPE_SOLVE_1 caesar_bes;
           CAESAR_TYPE_NATURAL caesar_block_1;
           CAESAR_TYPE_POINTER caesar_variable_1;
           CAESAR_TYPE_POINTER *caesar_label;
           CAESAR_TYPE_NATURAL *caesar_block_2;
           CAESAR_TYPE_POINTER *caesar_variable_2;
           { ... }
\fP
.fi
Note: Parameters \fBCAESAR_I2\fP and \fBCAESAR_V2\fP must point to (distinct) memory locations allocated before procedure \fBCAESAR_ITERATE_DIAGNOSTIC_SOLVE_1()\fP is invoked. In no event will \fBCAESAR_ITERATE_DIAGNOSTIC_SOLVE_1()\fP and \fBCAESAR_LOOP()\fP allocate memory for storing \fBCAESAR_I2\fP and \fBCAESAR_V2\fP.
.sp
Note: More often than not, this procedure will have side-effects. For instance, this procedure may count the number of successors, store them in a list, a table, ...
.sp
Note: It is probably a good programming style to keep the body of this procedure as short as possible.
.sp
Note: The code that implements \fBCAESAR_ITERATE_DIAGNOSTIC_SOLVE_1()\fP in the current version of the ``solve_1'' library is not reentrant, meaning that nested iterations will not work properly. This implies that any actual procedure \fBcaesar_p\fP passed as value for formal parameter \fBCAESAR_LOOP\fP must not call (directly, nor transitively) \fBCAESAR_ITERATE_DIAGNOSTIC_SOLVE_1()\fP.
.sp
Additionally, this procedure sets two fields \fBcaesar_creation\fP and \fBcaesar_truncation\fP of type \fBCAESAR_TYPE_NATURAL\fP associated to the equation block of index \fBCAESAR_I1\fP. After any call to \fBCAESAR_ITERATE_DIAGNOSTIC_SOLVE_1()\fP, these fields can be inspected using the two functions \fBCAESAR_CREATION_DIAGNOSTIC_SOLVE_1()\fP and \fBCAESAR_TRUNCATION_DIAGNOSTIC_SOLVE_1()\fP (see below). The values of these fields are set as follows:
.IP -
If the computation normally succeeds, then \fBcaesar_creation\fP is set to the number of successors of the variable pointed to by \fBCAESAR_V1\fP that are contained in the diagnostic of this variable and \fBcaesar_truncation\fP is set to zero.
.IP -
If allocation fails when enumerating the successors (due to a lack of memory), only a subset of the successors is enumerated. Then \fBcaesar_creation\fP is set to the number of successors enumerated and \fBcaesar_truncation\fP is set to the number of successors that have not been enumerated (this number is greater than zero).
.P
If the block index \fBCAESAR_I1\fP is outside the range 0..N-1 (where N is the number of blocks in the system), the effect is undefined.
.sp
.P
 ............................................................
.SS \fBCAESAR_CREATION_DIAGNOSTIC_SOLVE_1\fP
 \&
.nf
\fBCAESAR_TYPE_NATURAL CAESAR_CREATION_DIAGNOSTIC_SOLVE_1 (CAESAR_B, CAESAR_I)
   CAESAR_TYPE_SOLVE_1 CAESAR_B;
   CAESAR_TYPE_NATURAL CAESAR_I;
   { ... }
\fP
.fi
This function returns the value of the field \fBcaesar_creation\fP associated to the equation block of index \fBCAESAR_I\fP of the boolean equation system pointed to by \fBCAESAR_B\fP, that was computed during the last call to \fBCAESAR_ITERATE_DIAGNOSTIC_SOLVE_1()\fP (see above). This field can only be inspected using this function.
.sp
If the block index \fBCAESAR_I\fP is outside the range 0..N-1 (where N is the number of blocks in the system), the effect is undefined.
.sp
.P
 ............................................................
.SS \fBCAESAR_TRUNCATION_DIAGNOSTIC_SOLVE_1\fP
 \&
.nf
\fBCAESAR_TYPE_NATURAL CAESAR_TRUNCATION_DIAGNOSTIC_SOLVE_1 (CAESAR_B, CAESAR_I)
   CAESAR_TYPE_SOLVE_1 CAESAR_B;
   CAESAR_TYPE_NATURAL CAESAR_I;
   { ... }
\fP
.fi
This function returns the value of the field \fBcaesar_truncation\fP associated to the equation block of index \fBCAESAR_I\fP of the boolean equation system pointed to by \fBCAESAR_B\fP, that was computed during the last call to \fBCAESAR_ITERATE_DIAGNOSTIC_SOLVE_1()\fP (see above). This field can only be inspected using this function.
.sp
If the block index \fBCAESAR_I\fP is outside the range 0..N-1 (where N is the number of blocks in the system), the effect is undefined.
.sp
.P
 ............................................................
.SS \fBCAESAR_READ_SOLVE_1\fP
 \&
.nf
\fBvoid CAESAR_READ_SOLVE_1 (CAESAR_B, CAESAR_FILE,
                          CAESAR_BLOCK_UNIQUE_RESOLUTION,
                          CAESAR_BLOCK_SOLVE_MODE)
   CAESAR_TYPE_SOLVE_1 *CAESAR_B;
   CAESAR_TYPE_FILE CAESAR_FILE;
   CAESAR_TYPE_BOOLEAN_FUNCTION_SOLVE_1 CAESAR_BLOCK_UNIQUE_RESOLUTION;
   CAESAR_TYPE_NATURAL_FUNCTION_SOLVE_1 CAESAR_BLOCK_SOLVE_MODE;
   { ... }
\fP
.fi
This procedure allocates a boolean equation system using \fBCAESAR_CREATE_SOLVE_1()\fP and assigns its address to \fB*CAESAR_B\fP. If the allocation fails, the \fBNULL\fP value is assigned to \fB*CAESAR_B\fP.
.sp
The value of \fBCAESAR_FILE\fP determines the file from which the boolean equation system (represented in textual form) will be read. Before this procedure is called, \fBCAESAR_FILE\fP must have been properly opened, for instance using \fBfopen(3)\fP.
.sp
The boolean equation system file is parsed: its contents is analyzed and stored into the boolean equation system \fB*CAESAR_B\fP.
.sp
So doing, various error conditions may occur: \fBCAESAR_FILE\fP is empty or has syntax errors; it has semantic errors (such as block or variable indexes out of range), etc. In such case, a detailed error message is displayed using the \fBCAESAR_WARNING()\fP procedure, and the \fBNULL\fP value is assigned to \fB*CAESAR_B\fP.
.sp
The actual values of the two remaining formal parameters will be stored and associated to the boolean equation system pointed to by \fB*CAESAR_B\fP.
.sp
The value of \fBCAESAR_BLOCK_UNIQUE_RESOLUTION\fP determines, for each equation block, whether only one variable (or several variables) of the block will be solved.
If the value of \fBCAESAR_BLOCK_UNIQUE_RESOLUTION\fP is different from \fBNULL\fP, it will be given to the corresponding parameter in the call to \fBCAESAR_CREATE_SOLVE_1()\fP used to create the boolean equation system pointed to by \fB*CAESAR_B\fP.
If the value of \fBCAESAR_BLOCK_UNIQUE_RESOLUTION\fP is \fBNULL\fP, then the value of the corresponding parameter in the call to \fBCAESAR_CREATE_SOLVE_1()\fP will be determined by the contents of \fBCAESAR_FILE\fP.
.sp
The value of \fBCAESAR_BLOCK_SOLVE_MODE\fP determines, for each equation block, its corresponding resolution mode, determining which algorithm will be used by the resolution routine associated to the block.
If the value of \fBCAESAR_BLOCK_SOLVE_MODE\fP is different from \fBNULL\fP, it will be given to the corresponding parameter in the call to \fBCAESAR_CREATE_SOLVE_1()\fP used to create the boolean equation system pointed to by \fB*CAESAR_B\fP.
If the value of \fBCAESAR_BLOCK_SOLVE_MODE\fP is \fBNULL\fP, then the value of the corresponding parameter in the call to \fBCAESAR_CREATE_SOLVE_1()\fP will be determined by the contents of \fBCAESAR_FILE\fP.
.sp
Note: These two parameters allow to overwrite the values of the corresponding parameters of \fBCAESAR_CREATE_SOLVE_1()\fP determined by the contents of \fBCAESAR_FILE\fP. This is useful for applying last minute changes on the resolution of the boolean equation system read from \fBCAESAR_FILE\fP.
.sp
The contents of the boolean variables defined in the equation blocks of the system pointed to by \fB*CAESAR_B\fP are natural numbers, i.e., values of type \fBCAESAR_TYPE_NATURAL\fP. Each variable \fBXi\fP defined by an equation of the system is represented by the value \fBi\fP of its index. As an example, the following portion of C code implements the resolution of a boolean equation system created using \fBCAESAR_READ_SOLVE_1()\fP:
 \&
.nf
\fB        CAESAR_TYPE_SOLVE_1 caesar_bes;
        CAESAR_TYPE_FILE caesar_file;
        CAESAR_TYPE_NATURAL caesar_variable;
        CAESAR_TYPE_BOOLEAN caesar_value;
 
        if ((caesar_file = fopen ("file.bes", "r")) != NULL) {
           CAESAR_READ_SOLVE_1 (&caesar_bes, caesar_file, NULL, NULL);
           if (caesar_bes != NULL) {
              /* resolution of variable 0 defined in the block of index 0 */
              caesar_variable = 0;
              caesar_value = CAESAR_COMPUTE_SOLVE_1 (caesar_bes, 0,
                                (CAESAR_TYPE_POINTER) (&caesar_variable));
           }
        }
\fP
.fi
.sp
.P
 ............................................................
.SS \fBCAESAR_WRITE_SOLVE_1\fP
 \&
.nf
\fBvoid CAESAR_WRITE_SOLVE_1 (CAESAR_B, CAESAR_I, CAESAR_V,
                           CAESAR_FILE, CAESAR_DIAGNOSTIC)
   CAESAR_TYPE_SOLVE_1 CAESAR_B;
   CAESAR_TYPE_NATURAL CAESAR_I;
   CAESAR_TYPE_POINTER CAESAR_V;
   CAESAR_TYPE_FILE CAESAR_FILE;
   CAESAR_TYPE_BOOLEAN CAESAR_DIAGNOSTIC;
   { ... }
\fP
.fi
This procedure writes a portion of the boolean equation system pointed to by \fBCAESAR_B\fP in textual form into the file \fBCAESAR_FILE\fP. The portion written contains equations defining boolean variables upon which the boolean variable pointed to by \fBCAESAR_V\fP, which must be defined in the equation block of index \fBCAESAR_I\fP, depends either directly, or transitively.
.sp
Before this procedure is called, \fBCAESAR_FILE\fP must have been properly opened, for instance using \fBfopen(3)\fP.
.sp
So doing, various error conditions may occur: \fBCAESAR_FILE\fP is not writable; a memory allocation failed, etc. In such case, a detailed error message is displayed using the \fBCAESAR_WARNING()\fP procedure and the portion of boolean equation system written into \fBCAESAR_FILE\fP may be truncated.
.sp
If the block index \fBCAESAR_I\fP is outside the range 0..N-1 (where N is the number of blocks in the system), the effect is undefined.
.sp
If the value of \fBCAESAR_DIAGNOSTIC\fP is equal to \fBCAESAR_FALSE\fP, the portion of boolean equation system written into \fBCAESAR_FILE\fP will contain all equations defining the boolean variables upon which the boolean variable pointed to by \fBCAESAR_V\fP depends.
Otherwise, this portion will contain only the equations defining the variables contained in the diagnostic for the variable pointed to by \fBCAESAR_V\fP, which must have been solved previously by using \fBCAESAR_COMPUTE_SOLVE_1()\fP; if this is not the case, an error message is displayed using the \fBCAESAR_WARNING()\fP procedure and nothing is written into \fBCAESAR_FILE\fP.
.sp
Note: This procedure does not perform the resolution of the variable pointed to by \fBCAESAR_V\fP.
.sp
.P
 ............................................................
.SS \fBCAESAR_FORMAT_SOLVE_1\fP
 \&
.nf
\fBCAESAR_FORMAT CAESAR_FORMAT_SOLVE_1 (CAESAR_B, CAESAR_FORMAT)
   CAESAR_TYPE_SOLVE_1 CAESAR_B;
   CAESAR_TYPE_FORMAT CAESAR_FORMAT;
   { ... }
\fP
.fi
This function allows to control the format under which the boolean equation system pointed to by \fBCAESAR_B\fP will be printed by the procedure \fBCAESAR_PRINT_SOLVE_1()\fP (see below). Currently, the following formats are available:
.sp
.IP -
With format 0, statistical information concerning the boolean equation system is displayed such as: the size of variables and resolution modes for each equation block of the system, the number of boolean variables explored during resolution, etc.
.IP -
With format 1, statistical information concerning the internal tables associated to the equation blocks of the system is printed using the procedure \fBCAESAR_PRINT_TABLE_1()\fP.
.IP -
With format 2, the contents of the internal tables associated to the equation blocks of the system are printed using the procedure \fBCAESAR_PRINT_TABLE_1()\fP.
.IP -
(no other format available yet)
.P
By default, the current format of each boolean equation system is initialized to 0.
.sp
When called with \fBCAESAR_FORMAT\fP between 0 and 2, this fonction sets the current format of \fBCAESAR_B\fP to \fBCAESAR_FORMAT\fP and returns an undefined result.
.sp
When called with another value of \fBCAESAR_FORMAT\fP, this function does not modify the current format of \fBCAESAR_B\fP but returns a result defined as follows. If \fBCAESAR_FORMAT\fP is equal to the constant \fBCAESAR_CURRENT_FORMAT\fP, the result is the value of the current format of \fBCAESAR_B\fP. If \fBCAESAR_FORMAT\fP is equal to the constant \fBCAESAR_MAXIMAL_FORMAT\fP, the result is the maximal format value (i.e., 2). In all other cases, the effect of this function is undefined.
.sp
.P
 ............................................................
.SS \fBCAESAR_MAX_FORMAT_SOLVE_1\fP
 \&
.nf
\fBCAESAR_TYPE_FORMAT CAESAR_MAX_FORMAT_SOLVE_1 ()
   { ... }
\fP
.fi
Caution! This function is deprecated. It should no longer be used, as it might be removed from future versions of the \fIOPEN/CAESAR\fP. Use function \fBCAESAR_FORMAT_SOLVE_1()\fP instead, called with argument \fBCAESAR_MAXIMAL_FORMAT\fP.
.sp
This function returns the maximal format value available for printing boolean equation systems.
.sp
.P
 ............................................................
.SS \fBCAESAR_PRINT_SOLVE_1\fP
 \&
.nf
\fBvoid CAESAR_PRINT_SOLVE_1 (CAESAR_FILE, CAESAR_B)
   CAESAR_TYPE_FILE CAESAR_FILE;
   CAESAR_TYPE_SOLVE_1 CAESAR_B;
   { ... }
\fP
.fi
This procedure prints on file \fBCAESAR_FILE\fP an ASCII text containing various informations about the boolean equation system pointed to by \fBCAESAR_B\fP. The nature of these informations is determined by the current format of the boolean equation system pointed to by \fBCAESAR_B\fP.
.sp
Before this procedure is called, \fBCAESAR_FILE\fP must have been properly opened, for instance using \fBfopen(3)\fP.
.sp
.SH BIBLIOGRAPHY
[Mat03] Radu Mateescu.
A Generic On-the-Fly Solver for Alternation-Free Boolean Equation Systems.
In Hubert Garavel and John Hatcliff, editors, Proceedings of the 9th International Conference on Tools and Algorithms for the Construction and Analysis of Systems TACAS'2003 (Warsaw, Poland), Lecture Notes in Computer Science vol. 2619, pages 81--96. Springer Verlag, April 2003. Available from
\fBhttp://cadp.inria.fr/publications/Mateescu-03-a.html\fP
.sp
[Mat06] Radu Mateescu.
CAESAR_SOLVE: A Generic Library for On-the-Fly Resolution of Alternation-Free Boolean Equation Systems.
Springer International Journal on Software Tools for Technology Transfer (STTT), 8(1):37--56, February 2006. Available from
\fBhttp://cadp.inria.fr/publications/Mateescu-06-a.html\fP
.sp
.P
 ............................................................
.SH AUTHOR(S)
Radu Mateescu
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
