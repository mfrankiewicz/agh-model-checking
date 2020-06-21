'\" t
.\" @(#)caesar_solve_2.l - VASY and CONVECS teams - version 1.1
.TH caesar_solve_2 LOCAL "2020/02/11 (version 1.1)" "(C) INRIA" "OPEN/CAESAR MANUAL"
.fp 4 CB
.lg 0
.SH NAME
caesar_solve_2 \- the ``solve_2'' library of OPEN/CAESAR
.SH PURPOSE
The ``solve_2'' library provides primitives for solving linear equation systems, which are provided ``on the fly''. This library can be used as a back-end for various on the fly verification tools that formulate their corresponding problems (e.g., probabilistic verification) in terms of linear equation systems.
.sp
.sp
.SH USAGE
The ``solve_2'' library consists of:
.IP -
a predefined header file \fBcaesar_solve_2.h\fP;
.IP -
the precompiled library file \fBlibcaesar.a\fP, which implements the features described in \fBcaesar_solve_2.h\fP.
.P
Note: The ``solve_2'' library is a software layer built above the primitives offered by the ``standard'', ``area_1'', and ``table_1'' libraries, and by the \fIOPEN/CAESAR\fP graph module.
.sp
.sp
.SH LINEAR EQUATION SYSTEMS
A ``linear equation system'' is a set of (possibly recursive) equations with numerical variables on their left-hand sides and linear algebraic expressions on their right-hand sides.
.sp
The expressions on the right-hand sides of equations are built from numerical variables (\fBX1\fP, \fBX2\fP, etc.) and real numbers (\fB3.1416\fP, \fB-0.5\fP, etc.) using arithmetic operators (\fB+\fP, \fB*\fP).
.sp
Equations are of the following form:
 \&
.nf
\fB    Xi = Ci1 * X1 + ... + Cin * Xn + Bi
\fP
.fi
where the real numbers \fBCij\fP are the coefficients of variables \fBXj\fP and the real numbers \fBBi\fP are constants, for i, j between 1 and n.
If a coefficient \fBCij\fP is equal to 0, the term \fBCij * Xj\fP is omitted.
.sp
A variable is defined in a linear equation system if it occurs as left-hand side in an equation of the system. Multiple definitions of a variable are forbidden, i.e., a variable can occur as left-hand side in at most one equation of a linear equation system. Each variable occurring on the right-hand side of an equation in a linear equation system must be defined by some equation of the system.
.sp
If the formula on the right-hand side of the equation defining a variable \fBXi\fP contains another variable \fBXj\fP, there is a dependency from \fBXi\fP to \fBXj\fP.
.sp
An example of a linear equation system containing four equations is shown below.
 \&
.nf
\fB    X1 = 0.4 * X2 + 0.6 * X3
    X2 = 0.5 * X1 + 0.2
    X3 = 0.3
\fP
.fi
This system contains a cyclic dependency between variables \fBX1\fP and \fBX2\fP.
.sp
.sp
.SH ON THE FLY RESOLUTION
Given a linear equation system, the on the fly (or local) resolution problem consists in computing the value of a particular variable defined in the system. Contrary to global resolution, which consists in computing the values of all variables defined in the system (and therefore must examine all equations of the system), on the fly resolution computes the value of a variable without necessarily examining all equations of the system. This resolution technique allows to construct the linear equation system in a demand-driven manner, and hence it is useful for building tools for on the fly verification, which explore one or more labelled transition systems incrementally.
.sp
The on the fly resolution method for linear equation systems implemented in the ``solve_2'' library (see [MR18]) proceeds as follows. Each system has an associated resolution routine responsible for computing the values of the variables defined in the system.
.sp
The resolution routine associated to a linear equation system is easier to develop using a representation of the system as a dependency graph (also known as Signal Flow Graph), which provides a more intuitive view of the dependencies between variables. Given an equation system, its corresponding dependency graph is defined as follows:
.IP -
For each variable \fBXi\fP occurring in the system, there is a vertex \fBXi\fP in the dependency graph.
.IP -
For each dependency from a variable \fBXi\fP to a variable \fBXj\fP such that the term \fBCij * Xj\fP occurs on the right-hand side of the equation defining \fBXi\fP, there is an edge ``(\fBXi\fP, \fBCij\fP, \fBXj\fP)'' in the dependency graph.
.IP -
There is a special sink vertex \fBX0\fP (i.e., without any outgoing transitions), which denotes the constant \fB1.0\fP.
.P
To construct its dependency graph, the linear equation system shown above must be first transformed into the equivalent form below, by replacing each constant \fBBi\fP by a term \fBBi * X0\fP and adding the equation \fBX0 = 1.0\fP:
 \&
.nf
\fB    X0 = 1.0
    X1 = 0.4 * X2 + 0.6 * X3
    X2 = 0.5 * X1 + 0.2 * X0
    X3 = 0.3 * X0
\fP
.fi
Its dependency graph is the following:
 \&
.nf
\fB    (X1, 0.4, X2)
    (X1, 0.6, X3)
    (X2, 0.5, X1)
    (X2, 0.2, X0)
    (X3, 0.3, X0)
\fP
.fi
The resolution routine associated to a linear equation system will explore forward the corresponding dependency graph and will propagate backward the values of variables already stabilized (i.e., the value of which has been determined). When solving a variable, only the part of the dependency graph relevant for computing the value of the variable is explored. For example, solving the variable \fBX3\fP of the system above requires to explore only the dependency ``(\fBX3\fP, \fB0.3\fP, \fBX0\fP)'', yielding the value \fB0.3\fP for \fBX3\fP.
The resolution of variables \fBX1\fP and \fBX2\fP, which are present on a cycle of the dependency graph, is carried out by a traditional linear resolution algorithm (e.g., an iterative algorithm) executed on the equations defining \fBX1\fP and \fBX2\fP, yielding the values 0.325 and 0.3625, respectively.
.sp
To enable on the fly exploration, the dependency graphs associated to linear equation systems are represented in a generic, implicit manner using a scheme similar to the one defined by the \fIOPEN/CAESAR\fP graph module for representing labelled transition systems. This representation roughly consists of the following ingredients (see procedure \fBCAESAR_CREATE_SOLVE_2()\fP below for additional details):
.IP -
Variables (vertices of the dependency graph) are represented as pointers to memory areas of fixed size. The precise meaning of the variable contents is defined by the application program and is not relevant for the resolution algorithms.
.IP -
A linear equation system is equipped with several functions computing various information about the variables defined in the system: a comparison function, a hashing function, a printing function, and an iterator procedure which enumerates the successors of a variable in the dependency graph.
.P
To speed up the resolution process, a linear equation system has associated an internal table which stores the variables already explored during the previous calls of the resolution routine associated to the system. This avoids recomputations of variables by subsequent calls of the resolution routine, leading (for the sparse linear equation systems encountered in verification problems) to an overall resolution process of time complexity linear in the size of the system (number of variables and operators).
.sp
.sp
.SH DESCRIPTION
The ``solve_2'' library allows to create and handle linear equation systems on the fly, providing procedures for resolution, inspection, and writing information to text files.
.sp
.sp
.SH FEATURES
.P
 ............................................................
.SS \fBCAESAR_TYPE_SOLVE_2\fP
 \&
.nf
\fBtypedef CAESAR_TYPE_ABSTRACT (...) CAESAR_TYPE_SOLVE_2;
\fP
.fi
This type denotes a pointer to the concrete representation of a linear equation system. This representation is supposed to be ``opaque''.
.sp
.P
 ............................................................
.SS \fBCAESAR_TYPE_REAL\fP
 \&
.nf
\fBtypedef double CAESAR_TYPE_REAL;
\fP
.fi
\fBCAESAR_TYPE_REAL\fP is the real number type used in the ``solve_2'' library.
.sp
.P
 ............................................................
.SS \fBCAESAR_TYPE_ERROR_SOLVE_2\fP
 \&
.nf
\fBtypedef enum {
     CAESAR_NONE_SOLVE_2,
     CAESAR_MULTIPLE_RESOLUTION_SOLVE_2,
     CAESAR_MEMORY_SHORTAGE_SOLVE_2,
     CAESAR_SINGULAR_SOLVE_2
}    CAESAR_TYPE_ERROR_SOLVE_2;
\fP
.fi
This enumerated type defines the error codes produced as a side effect by calls to the function \fBCAESAR_COMPUTE_SOLVE_2()\fP (see below), which performs the resolution of a variable defined in a linear equation system. The error codes have the following meaning:
.IP -
\fBCAESAR_NONE_SOLVE_2\fP indicates that the resolution was performed successfully.
.IP -
\fBCAESAR_MULTIPLE_RESOLUTION_SOLVE_2\fP indicates that another resolution of a variable of the system was already performed, whereas at the creation of the linear equation system (see procedure \fBCAESAR_CREATE_SOLVE_2()\fP below) a single resolution was specified for the system.
.IP -
\fBCAESAR_MEMORY_SHORTAGE_SOLVE_2\fP indicates that a memory allocation failed during the resolution.
.IP -
\fBCAESAR_SINGULAR_SOLVE_2\fP indicates that the linear equation system contains singularities, i.e., either it has no solution, or it does not have a unique solution.
.P
Note: The error code produced by a call to \fBCAESAR_COMPUTE_SOLVE_2()\fP can be obtained by using the function \fBCAESAR_STATUS_COMPUTE_SOLVE_2()\fP (see below).
.sp
.P
 ............................................................
.SS \fBCAESAR_CREATE_SOLVE_2\fP
 \&
.nf
\fBvoid CAESAR_CREATE_SOLVE_2 (CAESAR_L,
                            CAESAR_UNIQUE_RESOLUTION,
                            CAESAR_SOLVE_MODE,
                            CAESAR_EPSILON,
                            CAESAR_VARIABLE_AREA,
                            CAESAR_LIMIT_SIZE,
                            CAESAR_HASH_SIZE,
                            CAESAR_PRIME,
                            CAESAR_VARIABLE_COMPARE,
                            CAESAR_VARIABLE_HASH,
                            CAESAR_VARIABLE_PRINT,
                            CAESAR_VARIABLE_ITERATE,
                            CAESAR_INFO)
   CAESAR_TYPE_SOLVE_2 *CAESAR_L;
   CAESAR_TYPE_BOOLEAN CAESAR_UNIQUE_RESOLUTION;
   CAESAR_TYPE_NATURAL CAESAR_SOLVE_MODE;
   CAESAR_TYPE_REAL CAESAR_EPSILON;
   CAESAR_TYPE_AREA_1 CAESAR_VARIABLE_AREA;
   CAESAR_TYPE_NATURAL CAESAR_LIMIT_SIZE;
   CAESAR_TYPE_NATURAL CAESAR_HASH_SIZE;
   CAESAR_TYPE_BOOLEAN CAESAR_PRIME;
   CAESAR_TYPE_COMPARE_FUNCTION CAESAR_VARIABLE_COMPARE;
   CAESAR_TYPE_HASH_FUNCTION CAESAR_VARIABLE_HASH;
   CAESAR_TYPE_PRINT_FUNCTION CAESAR_VARIABLE_PRINT;
   void (*CAESAR_VARIABLE_ITERATE) (CAESAR_TYPE_POINTER, CAESAR_TYPE_POINTER,
      void (*) (CAESAR_TYPE_REAL, CAESAR_TYPE_POINTER));
   CAESAR_TYPE_POINTER CAESAR_INFO;
   { ... }
\fP
.fi
This procedure allocates a linear equation system using \fBCAESAR_CREATE()\fP and assigns its address to \fB*CAESAR_L\fP. If the allocation fails, the \fBNULL\fP value is assigned to \fB*CAESAR_L\fP.
.sp
Note: Because \fBCAESAR_TYPE_SOLVE_2\fP is a pointer type, any variable \fBCAESAR_L\fP of type \fBCAESAR_TYPE_SOLVE_2\fP must be allocated before used, for instance using:
.TS
center;
l.
 
 \fBCAESAR_CREATE_SOLVE_2 (&CAESAR_L, ...);\fP 
 
.TE
.sp
The actual value of the formal parameter \fBCAESAR_UNIQUE_RESOLUTION\fP will be stored and associated to the linear equation system pointed to by \fB*CAESAR_L\fP. It will be used to assign a boolean indicating whether only one variable (or several variables) of the system will be solved.
.sp
The actual value of the formal parameter \fBCAESAR_SOLVE_MODE\fP will be stored and associated to the linear equation system pointed to by \fB*CAESAR_L\fP. It will be used to assign the resolution mode, determining which algorithm will be used by the resolution routine associated to the system.
.sp
Currently, the following resolution modes are available:
.IP -
Mode 0 corresponds to a resolution algorithm based upon a depth-first search of the dependency graph associated to the system, with detection of strongly connected components (SCCs) and iterative resolution of the variables contained in the SCCs [MR18].
This mode works only for stochastic linear equation systems, whose equations \fBXi\fP = \fBCi1 * X1\fP + ... + \fBCin * Xn\fP + \fBBi\fP are such that all coefficients \fBCij\fP and constant \fBBi\fP are positive, and their sum \fBCi1\fP + ... + \fBCin\fP + \fBBi\fP is less than or equal to 1.0.
.IP -
(no other resolution mode available yet)
.P
If the resolution mode given by \fBCAESAR_SOLVE_MODE\fP is not among the resolution modes above, or the linear equation system does not have the form expected by that resolution mode, the effect is undefined.
.sp
The actual value of the formal parameter \fBCAESAR_EPSILON\fP will be stored and associated to the linear equation system pointed to by \fB*CAESAR_L\fP. It will be used to assign the precision of comparisons between real numbers during the resolution.
If this value is equal to zero, it is replaced by the default value \fB1E-6\fP.
.sp
The actual value of the formal parameter \fBCAESAR_VARIABLE_AREA\fP will be stored and associated to the linear equation system pointed to by \fB*CAESAR_L\fP. It will be used to assign the (constant) size and (constant) alignment factor of the variables defined in the system.
.sp
The actual value of the formal parameter \fBCAESAR_LIMIT_SIZE\fP will be stored and associated to the linear equation system pointed to by \fB*CAESAR_L\fP. It will be used to assign the maximal size (number of items) of the internal table associated to the system.
This value must be less or equal to a predefined value M (see the ``table_1'' library). If it is equal to zero, it is replaced by the default value M.
.sp
The actual value of the formal parameter \fBCAESAR_HASH_SIZE\fP will be stored and associated to the linear equation system pointed to by \fB*CAESAR_L\fP. It will be used to assign the size (number of entries) of the hash-table accompanying the internal table associated to the system.
If this value is equal to zero, it is replaced by a default value greater than zero (see the ``table_1'' library).
.sp
The actual value of the formal parameter \fBCAESAR_PRIME\fP will be stored and associated to the linear equation system pointed to by \fB*CAESAR_L\fP. It will be used to assign a boolean value allowing to adjust the size of the hash-table accompanying the internal table associated to the system.
If this value is equal to \fBCAESAR_TRUE\fP and if the value of \fBCAESAR_HASH_SIZE\fP is not a prime number, this value will be replaced by the nearest smaller prime number (since some hash functions require prime modulus). Otherwise, the value of \fBCAESAR_HASH_SIZE\fP will be kept unchanged (see the ``table_1'' library).
.sp
The actual value of the formal parameter \fBCAESAR_VARIABLE_COMPARE\fP will be stored and associated to the linear equation system pointed to by \fB*CAESAR_L\fP. It will be used as a comparison function for the variables defined in the system.
.sp
Precisely, the actual value of \fBCAESAR_VARIABLE_COMPARE\fP should be a pointer to a comparison function \fBcaesar_f\fP with two parameters \fBcaesar_variable_1\fP and \fBcaesar_variable_2\fP that returns \fBCAESAR_TRUE\fP (resp. \fBCAESAR_FALSE\fP) if the variables pointed to by \fBcaesar_variable_1\fP and \fBcaesar_variable_2\fP are equal (resp. different).
A pointer to the linear equation system (i.e., the value assigned to \fB*CAESAR_B\fP) can be obtained within \fBcaesar_f\fP by calling the function \fBCAESAR_CURRENT_SYSTEM_SOLVE_1()\fP (see below).
.sp
The actual value of the formal parameter \fBCAESAR_VARIABLE_HASH\fP will be stored and associated to the linear equation system pointed to by \fB*CAESAR_L\fP. It will be used as a hash-function for the variables defined in the system.
.sp
Precisely, the actual value of \fBCAESAR_VARIABLE_HASH\fP should be a pointer to a hash function \fBcaesar_f\fP with two parameters \fBcaesar_variable\fP and \fBcaesar_modulus\fP that returns a hash-value computed on the byte string \fBcaesar_variable [0]\fP up to \fBcaesar_variable [caesar_size - 1]\fP, where the actual value of \fBcaesar_size\fP will always be equal to the size of the variable pointed to by \fBcaesar_variable\fP. This hash-value must belong to the range 0..\fBcaesar_modulus\fP-1.
A pointer to the linear equation system (i.e., the value assigned to \fB*CAESAR_L\fP) can be obtained within \fBcaesar_f\fP by calling the function \fBCAESAR_CURRENT_SYSTEM_SOLVE_2()\fP (see below).
.sp
The actual value of the formal parameter \fBCAESAR_VARIABLE_PRINT\fP will be stored and associated to the linear equation system pointed to by \fB*CAESAR_L\fP. It will be used as a printing procedure for the variables defined in the system.
.sp
Precisely, the actual value of \fBCAESAR_VARIABLE_PRINT\fP should be a pointer to a printing procedure \fBcaesar_p\fP with two parameters \fBcaesar_file\fP and \fBcaesar_variable\fP that prints to file \fBcaesar_file\fP information about the contents of the variable pointed to by \fBcaesar_variable\fP.
A pointer to the linear equation system (i.e., the value assigned to \fB*CAESAR_L\fP) can be obtained within \fBcaesar_p\fP by calling the function \fBCAESAR_CURRENT_SYSTEM_SOLVE_2()\fP (see below).
.sp
The actual value of the formal parameter \fBCAESAR_VARIABLE_ITERATE\fP will be stored and associated to the linear equation system pointed to by \fB*CAESAR_L\fP. It will be used as an iterator procedure enumerating all successors of the variables defined in the system.
.sp
Any user-defined procedure \fBcaesar_p\fP can be used as an actual value for formal parameter \fBCAESAR_VARIABLE_ITERATE\fP, provided that its declaration has the form:
 \&
.nf
\fB        void caesar_p (caesar_variable_1, caesar_variable_2, caesar_loop)
           CAESAR_TYPE_POINTER caesar_variable_1;
           CAESAR_TYPE_POINTER caesar_variable_2;
           void (*caesar_loop) (CAESAR_TYPE_REAL, CAESAR_TYPE_POINTER);
           { ... }
\fP
.fi
This procedure \fBcaesar_p\fP enumerates all successors of the variable pointed to by \fBcaesar_variable_1\fP.
A pointer to the linear equation system (i.e., the value assigned to \fB*CAESAR_L\fP) can be obtained within \fBcaesar_p\fP by calling the function \fBCAESAR_CURRENT_SYSTEM_SOLVE_2()\fP (see below). At each iteration performed by \fBcaesar_p\fP, two actions must be carried out:
.IP -
First, the variable pointed to by \fBcaesar_variable_2\fP must be assigned a new value, such that \fBcaesar_variable_1\fP and \fBcaesar_variable_2\fP are the source and target vertices of an edge in the dependency graph.
.IP -
Second, the procedure pointed to by \fBcaesar_loop\fP must be called. The actual value of the formal parameter \fBcaesar_loop\fP is a procedure \fBcaesar_q\fP whose declaration has the form:
 \&
.nf
\fB        void caesar_q (caesar_coefficient_2, caesar_variable_2)
           CAESAR_TYPE_REAL caesar_coefficient_2;
           CAESAR_TYPE_POINTER caesar_variable_2;
           { ... }
\fP
.fi
Therefore, each call to the procedure pointed to by \fBcaesar_loop\fP must have the following parameters:
 \&
.nf
\fB     (*caesar_loop) (caesar_coefficient_2, caesar_variable_2)
\fP
.fi
Parameter \fBcaesar_coefficient_2\fP represents the coefficient of the variable \fBcaesar_variable_2\fP on the right-hand side of the equation defining \fBcaesar_variable_1\fP, i.e., ``(\fBcaesar_variable_1\fP, \fBcaesar_coefficient_2\fP, \fBcaesar_variable_2\fP)'' represents an edge of the dependency graph.
.P
Note: The memory area pointed to by the parameter \fBcaesar_variable_1\fP contains a variable and should neither be modified, nor freed by the procedure \fBcaesar_p\fP.
.sp
Note: The memory area pointed to by the parameter \fBcaesar_variable_2\fP is already allocated and should not be freed by the procedure \fBcaesar_p\fP.
.sp
The value of \fBCAESAR_INFO\fP has no effect on the execution of procedure \fBCAESAR_CREATE_SOLVE_2()\fP. Parameter \fBCAESAR_INFO\fP is intended to serve for future extensions of this procedure; when using the current version of the ``solve_2'' library, it is recommended to set this parameter to \fBNULL\fP.
.sp
.P
 ............................................................
.SS \fBCAESAR_CURRENT_SYSTEM_SOLVE_2\fP
 \&
.nf
\fBCAESAR_TYPE_SOLVE_2 CAESAR_CURRENT_SYSTEM_SOLVE_2 ()
   { ... }
\fP
.fi
This function returns a pointer to the linear equation system which is currently under resolution. It should be called only within the functions and procedures given as actual values for the formal parameters \fBCAESAR_VARIABLE_COMPARE\fP, \fBCAESAR_VARIABLE_HASH\fP, \fBCAESAR_VARIABLE_PRINT\fP, and \fBCAESAR_VARIABLE_ITERATE\fP of procedure \fBCAESAR_CREATE_SOLVE_2()\fP (see above); in this case, the result is a pointer to the linear equation system created by the call to \fBCAESAR_CREATE_SOLVE_2()\fP. If this function is called anywhere else in the application program, the result is undefined.
.sp
Note: This function allows to invoke, within the five aforementioned functions and procedures, various primitives of the ``solve_2'' library on the current linear equation system (e.g., resolution, printing, etc.).
.sp
.P
 ............................................................
.SS \fBCAESAR_DELETE_SOLVE_2\fP
 \&
.nf
\fBvoid CAESAR_DELETE_SOLVE_2 (CAESAR_L)
   CAESAR_TYPE_SOLVE_2 *CAESAR_L;
   { ... }
\fP
.fi
This procedure frees the memory space corresponding to the linear equation system pointed to by \fB*CAESAR_L\fP using \fBCAESAR_DELETE()\fP. The variables stored in the internal table allocated during previous resolutions (if any) of the linear equation system are also freed. Afterwards, the \fBNULL\fP value is assigned to \fB*CAESAR_L\fP.
.sp
.P
 ............................................................
.SS \fBCAESAR_PURGE_SOLVE_2\fP
 \&
.nf
\fBvoid CAESAR_PURGE_SOLVE_2 (CAESAR_L)
   CAESAR_TYPE_SOLVE_2 CAESAR_L;
   { ... }
\fP
.fi
This procedure reinitializes the information associated to the linear equation system pointed to by \fBCAESAR_L\fP.
The internal table associated to the system is emptied using \fBCAESAR_PURGE_TABLE_1()\fP.
Afterwards, the linear equation system is exactly in the same state as after its creation using \fBCAESAR_CREATE_SOLVE_2()\fP.
.sp
.P
 ............................................................
.SS \fBCAESAR_COMPUTE_SOLVE_2\fP
 \&
.nf
\fBCAESAR_TYPE_REAL CAESAR_COMPUTE_SOLVE_2 (CAESAR_L, CAESAR_V)
   CAESAR_TYPE_SOLVE_2 CAESAR_L;
   CAESAR_TYPE_POINTER CAESAR_V;
   { ... }
\fP
.fi
This function computes the value of the variable pointed to by \fBCAESAR_V\fP, which must be defined in the linear equation system pointed to by \fBCAESAR_L\fP. It also sets a field of type \fBCAESAR_TYPE_ERROR_SOLVE_2\fP associated to the system, indicating whether the resolution was carried out successfully or not; this field can be inspected using the function \fBCAESAR_STATUS_COMPUTE_SOLVE_2()\fP (see below).
.sp
.P
 ............................................................
.SS \fBCAESAR_STATUS_COMPUTE_SOLVE_2\fP
 \&
.nf
\fBCAESAR_TYPE_ERROR_SOLVE_2 CAESAR_STATUS_COMPUTE_SOLVE_2 (CAESAR_L)
   CAESAR_TYPE_SOLVE_2 CAESAR_L;
   { ... }
\fP
.fi
This function returns the status of the last resolution performed by a call to the function \fBCAESAR_COMPUTE_SOLVE_2()\fP (see above) on a variable defined in the linear equation system pointed to by \fBCAESAR_L\fP.
.sp
.P
 ............................................................
.SS \fBCAESAR_FORMAT_SOLVE_2\fP
 \&
.nf
\fBCAESAR_FORMAT CAESAR_FORMAT_SOLVE_2 (CAESAR_L, CAESAR_FORMAT)
   CAESAR_TYPE_SOLVE_2 CAESAR_L;
   CAESAR_TYPE_FORMAT CAESAR_FORMAT;
   { ... }
\fP
.fi
This function allows to control the format under which the linear equation system pointed to by \fBCAESAR_L\fP will be printed by the procedure \fBCAESAR_PRINT_SOLVE_2()\fP (see below). Currently, the following formats are available:
.sp
.IP -
With format 0, statistical information concerning the linear equation system is displayed, such as: the size of variables and resolution mode, the number of variables explored during resolution, etc.
.IP -
With format 1, statistical information concerning the internal table associated to the system is printed using the procedure \fBCAESAR_PRINT_TABLE_1()\fP.
.IP -
With format 2, the contents of the internal table associated to the system is printed using the procedure \fBCAESAR_PRINT_TABLE_1()\fP.
.IP -
(no other format available yet)
.P
By default, the current format of each linear equation system is initialized to 0.
.sp
When called with \fBCAESAR_FORMAT\fP between 0 and 2, this function sets the current format of \fBCAESAR_L\fP to \fBCAESAR_FORMAT\fP and returns an undefined result.
.sp
When called with another value of \fBCAESAR_FORMAT\fP, this function does not modify the current format of \fBCAESAR_L\fP but returns a result defined as follows. If \fBCAESAR_FORMAT\fP is equal to the constant \fBCAESAR_CURRENT_FORMAT\fP, the result is the value of the current format of \fBCAESAR_L\fP. If \fBCAESAR_FORMAT\fP is equal to the constant \fBCAESAR_MAXIMAL_FORMAT\fP, the result is the maximal format value (i.e., 2). In all other cases, the effect of this function is undefined.
.sp
.P
 ............................................................
.SS \fBCAESAR_PRINT_SOLVE_2\fP
 \&
.nf
\fBvoid CAESAR_PRINT_SOLVE_2 (CAESAR_FILE, CAESAR_L)
   CAESAR_TYPE_FILE CAESAR_FILE;
   CAESAR_TYPE_SOLVE_2 CAESAR_L;
   { ... }
\fP
.fi
This procedure prints on file \fBCAESAR_FILE\fP an ASCII text containing various informations about the linear equation system pointed to by \fBCAESAR_L\fP. The nature of these informations is determined by the current format of the linear equation system pointed to by \fBCAESAR_L\fP.
.sp
Before this procedure is called, \fBCAESAR_FILE\fP must have been properly opened, for instance using \fBfopen(3)\fP.
.sp
.SH BIBLIOGRAPHY
[MR18] Radu Mateescu and Jose Ignacio Requeno.
On-the-Fly Model Checking for Extended Action-Based Probabilistic Operators.
Springer International Journal on Software Tools for Technology Transfer (STTT), 20(5):563--587, October 2018. Available from
\fBhttp://hal.inria.fr/hal-01862754/en\fP
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
