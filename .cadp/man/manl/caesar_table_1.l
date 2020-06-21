'\" t
.\" @(#)caesar_table_1.l - VASY and CONVECS teams - version 1.1
.TH caesar_table_1 LOCAL "2020/02/11 (version 1.1)" "(C) INRIA" "OPEN/CAESAR MANUAL"
.fp 4 CB
.lg 0
.SH NAME
caesar_table_1 \- the ``table_1'' library of OPEN/CAESAR
.SH PURPOSE
The ``table_1'' library provides primitives for managing a ``state space''. It can be used either for breadth-first or depth-first search in the state graph.
.sp
.sp
.SH USAGE
The ``table_1'' library consists of:
.IP -
a predefined header file \fBcaesar_table_1.h\fP;
.IP -
the precompiled library file \fBlibcaesar.a\fP, which implements the features described in \fBcaesar_table_1.h\fP.
.P
Note: The ``table_1'' library is a software layer built above the primitives offered by the ``standard'', ``area_1'', and ``hash'' libraries, and by the \fIOPEN/CAESAR\fP graph module.
.sp
.sp
.SH DESCRIPTION
A ``table'' is basically a set of items.
.sp
Each item in the table is basically a byte string of fixed size. All items in a given table have the same size. An item can be considered as a tuple with two fields, whose size and contents are freely determined by the user:
.IP -
(1) a ``base'' field, that is a byte string of fixed size. In a given table, all base fields have the same size. This size must be greater than zero.
.sp
More often than not, the base field contains a state (as defined in the graph module). However, this is not mandatory, and base fields can contain other information than states.
.IP -
(2) a ``mark'' field, that is a byte string whose size and contents are freely determined by the user. In a given table, all mark fields have the same size, which must be greater or equal to zero.
Pointers to mark fields will be considered as values of type \fBCAESAR_TYPE_POINTER\fP; ``mark'' fields are always aligned on appropriate boundaries so that the user can put any information in these fields without alignment problem.
.P
The user also determines the nature of the data stored in these fields, which is not meaningful to the ``table_1'' library.
.sp
Invariant property 1: the table is organized in such a way that all items have different base fields. Said differently, two items in a given table cannot have identical base fields (but they can have identical mark fields).
.sp
Invariant property 2: the number of items in a given table never decreases. New items can be inserted in the table, existing items can be replaced by new ones, but no item can be removed if it is not replaced by another one. Exception to this rule: it is possible to purge the table, i.e., to remove simultaneously all its items.
.sp
Invariant property 3: it is not allowed to modify the base field of any item in the table (except if this item is to be replaced by another one that has exactly the same hash value, which is unlikely). But it is possible to modify the mark field of any item.
.sp
Each item in a table is given a unique identification number (``index'') which is a natural number. A table can contain no more than a maximum of M items, with indexes between 0 and M - 1.
Currently, M = 2^{29} = 536,870,912 on 32-bit machines and M = 2^{34} = 17,179,869,184 on 64-bit machines.
But, for each table, the user can also limit the maximal number of items to a lesser bound N <= M.
.sp
When the table overflows (either because the maximum number of items is reached or because there is no enough memory to store new items), an action chosen by the user (e.g., abort, recovery, etc.) is performed.
.sp
Each item in the table can be accessed in three different ways:
.IP -
(1) by using its address (i.e., a pointer to the memory location where it is stored in the table),
.IP -
(2) by using its index,
.IP -
(3) by using its base field.
.P
The table data structure establishes a correspondence between these three data. Indeed:
.IP -
given an address, one can retrieve the index, the base field, and the mark field of the corresponding item;
.IP -
given an index, one can retrieve the address, the base field, and the mark field of the corresponding item;
.IP -
given a base field, one can retrieve the address, the index, and the mark field of the corresponding item.
.P
Retrieving the address and the index of an item from its base field involves some associative search. To allow fast retrievals, an hash-table is associated to each table. This is quite transparent from the user's point of view. Only the base field is taken into account when computing the hash-value and comparing items; the mark field is not meaningful for the search.
.sp
Two special variables are associated to a given table:
.IP -
the ``put index'' corresponds to the last item inserted in the table. Initialized to zero, the put index is incremented each time a new item is inserted. Therefore, the first item is numbered 0, the second one is numbered 1, etc.
.sp
The ``put index'' is always useful, whatever the way the graph is explored: breadth-first, depth-first, etc.
.IP -
the ``get index'' is associated to the last item consulted in the table. Initialized to zero, the get index is incremented each time a new item is consulted. Since only the items previously inserted in the table can be consulted, the get index is always less or equal to the put index.
.sp
The ``get index'' can be used to consult sequentially all the items, in the same order as they have been inserted in the table. Therefore it can be used for (pseudo) breadth-first exploration, but not for depth-first exploration.
.P
Additionally, statistics are attached to each table. These statistics consist of a ``success counter'' and a ``failure counter'', which respectively count how many retrievals (given the base field) have succeeded and failed.
.sp
.sp
.SH FEATURES
.P
 ............................................................
.SS \fBCAESAR_TYPE_TABLE_1\fP
 \&
.nf
\fBtypedef CAESAR_TYPE_ABSTRACT (...) CAESAR_TYPE_TABLE_1;
\fP
.fi
This type denotes a pointer to the concrete representation of a table. The table representation is supposed to be ``opaque''.
.sp
.P
 ............................................................
.SS \fBCAESAR_TYPE_INDEX_TABLE_1\fP
 \&
.nf
\fBtypedef CAESAR_TYPE_NATURAL CAESAR_TYPE_INDEX_TABLE_1;
\fP
.fi
This type denotes an index, which is a natural number.
.sp
.P
 ............................................................
.SS \fBCAESAR_NULL_INDEX_TABLE_1\fP
 \&
.nf
\fB#define CAESAR_NULL_INDEX_TABLE_1 ((CAESAR_TYPE_INDEX_TABLE_1) -1L)
\fP
.fi
This constant denotes a special index value corresponding to the largest unsigned integer. Since item indexes are always in the range 0..M-1, no item index can be equal to \fBCAESAR_NULL_INDEX_TABLE_1\fP.
.sp
.P
 ............................................................
.SS \fBCAESAR_MAX_INDEX_TABLE_1\fP
 \&
.nf
\fBCAESAR_TYPE_INDEX_TABLE_1 CAESAR_MAX_INDEX_TABLE_1 ()
   { ... }
\fP
.fi
This function returns the value of M, i.e., the maximal number of items that can be stored in a table. Since item indexes are always in the range 0..M-1, no item index can be equal to \fBCAESAR_MAX_INDEX_TABLE_1()\fP.
.sp
.P
 ............................................................
.SS \fBCAESAR_TYPE_OVERFLOW_FUNCTION_TABLE_1\fP
 \&
.nf
\fBtypedef void (*CAESAR_TYPE_OVERFLOW_FUNCTION_TABLE_1) (CAESAR_TYPE_TABLE_1);
\fP
.fi
\fBCAESAR_TYPE_OVERFLOW_FUNCTION_TABLE_1\fP is the ``pointer to an overflow procedure'' type used in the ``table_1'' library. An overflow procedure takes one parameter of type \fBCAESAR_TYPE_TABLE_1\fP. Examples of overflow procedures are \fBCAESAR_OVERFLOW_SIGNAL_TABLE_1()\fP, \fBCAESAR_OVERFLOW_ABORT_TABLE_1()\fP, and \fBCAESAR_OVERFLOW_IGNORE_TABLE_1()\fP defined below.
.sp
.P
 ............................................................
.SS \fBCAESAR_OVERFLOW_SIGNAL_TABLE_1\fP
 \&
.nf
\fBvoid CAESAR_OVERFLOW_SIGNAL_TABLE_1 (CAESAR_T)
    CAESAR_TYPE_TABLE_1 CAESAR_T;
   { ... }
\fP
.fi
This procedure is a possible action that can be performed in case the table pointed to by \fBCAESAR_T\fP overflows (either because the maximum number of items for \fBCAESAR_T\fP is reached or because there is no enough memory to store new items).
.sp
It first prints an error message to the standard output, and also various statistics about the table. Then, it returns. Practically, if the table is used for state space exploration, this means that some portions of the graph will not be explored, but an error message will be issued.
.sp
.P
 ............................................................
.SS \fBCAESAR_OVERFLOW_ABORT_TABLE_1\fP
 \&
.nf
\fBvoid CAESAR_OVERFLOW_ABORT_TABLE_1 (CAESAR_T)
    CAESAR_TYPE_TABLE_1 CAESAR_T;
   { ... }
\fP
.fi
This procedure is a possible action that can be performed in case the table pointed to by \fBCAESAR_T\fP overflows (either because the maximum number of items for \fBCAESAR_T\fP is reached or because there is no enough memory to store new items).
.sp
It first prints an error message to the standard output, and also various statistics about the table. Then, it aborts the program using the C function \fBexit(3)\fP. The error code 1 is returned.
.sp
.P
 ............................................................
.SS \fBCAESAR_OVERFLOW_IGNORE_TABLE_1\fP
 \&
.nf
\fBvoid CAESAR_OVERFLOW_IGNORE_TABLE_1 (CAESAR_T)
    CAESAR_TYPE_TABLE_1 CAESAR_T;
   { ... }
\fP
.fi
This procedure is a possible action that can be performed in case the table pointed to by \fBCAESAR_T\fP overflows (either because the maximum number of items for \fBCAESAR_T\fP is reached or because there is no enough memory to store new items).
.sp
It does nothing and returns. Practically, if the table is used for state space exploration, this means that some portions of the graph will not be explored; they are silently ignored.
.sp
.P
 ............................................................
.SS \fBCAESAR_CREATE_TABLE_1\fP
 \&
.nf
\fBvoid CAESAR_CREATE_TABLE_1 (CAESAR_T, CAESAR_BASE_AREA, CAESAR_MARK_AREA,
                            CAESAR_LIMIT_SIZE, CAESAR_HASH_SIZE,
                            CAESAR_PRIME, CAESAR_COMPARE, CAESAR_HASH,
                            CAESAR_PRINT, CAESAR_OVERFLOW)
   CAESAR_TYPE_TABLE_1 *CAESAR_T;
   CAESAR_TYPE_AREA_1 CAESAR_BASE_AREA;
   CAESAR_TYPE_AREA_1 CAESAR_MARK_AREA;
   CAESAR_TYPE_NATURAL CAESAR_LIMIT_SIZE;
   CAESAR_TYPE_NATURAL CAESAR_HASH_SIZE;
   CAESAR_TYPE_BOOLEAN CAESAR_PRIME;
   CAESAR_TYPE_COMPARE_FUNCTION CAESAR_COMPARE;
   CAESAR_TYPE_HASH_FUNCTION CAESAR_HASH;
   CAESAR_TYPE_PRINT_FUNCTION CAESAR_PRINT;
   CAESAR_TYPE_OVERFLOW_FUNCTION_TABLE_1 CAESAR_OVERFLOW;
   { ... }
\fP
.fi
This procedure allocates a table using \fBCAESAR_CREATE()\fP and assigns its address to \fB*CAESAR_T\fP. If the allocation fails, the \fBNULL\fP value is assigned to \fB*CAESAR_T\fP.
.sp
Note: when it is called, this procedure does not allocate at once all the memory needed to represent the table: the table will grow progressively as new items are inserted. Consequently, if \fBCAESAR_CREATE_TABLE_1()\fP returns a value different from \fBNULL\fP, this does not mean that no overflow will occur in the future.
.sp
Note: because \fBCAESAR_TYPE_TABLE_1\fP is a pointer type, any variable \fBCAESAR_T\fP of type \fBCAESAR_TYPE_TABLE_1\fP must be allocated before used, for instance using:
.TS
center;
l.
 
 \fBCAESAR_CREATE_TABLE_1 (&CAESAR_T, ...);\fP 
 
.TE
.sp
The value of \fBCAESAR_BASE_AREA\fP determines the (constant) size and (constant) alignment factor of the base field in the table.
In the particular case where base fields are used to store states (resp. labels, strings), one must give the value \fBCAESAR_STATE_AREA_1()\fP (resp. \fBCAESAR_LABEL_AREA_1()\fP, \fBCAESAR_STRING_AREA_1()\fP) to the formal parameter \fBCAESAR_BASE_AREA\fP.
.sp
Note: For backward compatibility reasons, if \fBCAESAR_BASE_AREA\fP is equal to \fBCAESAR_EMPTY_AREA_1()\fP, it will be treated exactly like \fBCAESAR_STATE_AREA_1()\fP, i.e., specifying an empty area for the base field is equivalent to specifying a state area. However, relying on this feature is not recommended and this case will no longer be considered in the sequel of this manual.
.sp
The value of \fBCAESAR_MARK_AREA\fP determines the (constant) size and (constant) alignment factor of the mark field according to the specifications of the ``area_1'' library. In particular, if \fBCAESAR_MARK_AREA\fP is equal to \fBCAESAR_EMPTY_AREA_1()\fP, there will be no mark field in the table.
.sp
Each item in the table will be represented as a byte string of fixed size \fBcaesar_item_size\fP, such that \fBcaesar_item_size\fP is strictly greater than \fBcaesar_base_size + caesar_mark_size\fP, where \fBcaesar_base_size\fP denotes the size (in bytes) of the base field (i.e., \fBCAESAR_SIZE_AREA_1 (CAESAR_BASE_AREA)\fP) and where \fBcaesar_mark_size\fP denotes the size (in bytes) of the mark field, if any (i.e., \fBCAESAR_SIZE_AREA_1 (CAESAR_MARK_AREA)\fP).
.sp
An item in the table contains not only the base field and the mark field, but also additional information needed for internal management. Also, ``padding'' bytes may be inserted around the base and mark fields to ensure that these fields are correctly aligned according to \fBCAESAR_ALIGNMENT_AREA_1 (CAESAR_BASE_AREA)\fP and \fBCAESAR_ALIGNMENT_AREA_1 (CAESAR_MARK_AREA)\fP.
.sp
The value of \fBCAESAR_LIMIT_SIZE\fP determines the maximal number of items that can be stored in the table; all indexes will consequently be in the range 0..\fBCAESAR_LIMIT_SIZE\fP - 1. It must be less or equal to M. If it is equal to zero, it is replaced by the default value M.
.sp
Note: in order to spare memory, the value of \fBCAESAR_LIMIT_SIZE\fP (which is an upper bound on the number of items to be inserted in the table) should be as small as possible. This can only be done if the user has some knowledge about the way the table will be used. The value of \fBCAESAR_LIMIT_SIZE\fP (or its default value if \fBCAESAR_LIMIT_SIZE\fP is equal to zero) might be reduced automatically if it exceeds the number of all possible different base fields or if it exceeds the amount of physical memory available (which is either specified by the environment variable \fB$CADP_MEMORY\fP or determined automatically by the \fBcadp_memory\fP program).
.sp
The value of \fBCAESAR_HASH_SIZE\fP determines the number of entries in the hash-table associated to the table. If \fBCAESAR_HASH_SIZE\fP is different from zero, it remains constant during the entire existence of the table (static hashing scheme). If \fBCAESAR_HASH_SIZE\fP is equal to zero, it is replaced with a default value greater than zero that might increase automatically when a sufficiently large number of items have been inserted into the table (dynamic hashing scheme).
.sp
Note: in order to spare memory, the value of \fBCAESAR_HASH_SIZE\fP (or its default value if \fBCAESAR_HASH_SIZE\fP is equal to zero) might be reduced automatically if it exceeds the value of \fBCAESAR_LIMIT_SIZE\fP, i.e., the maximal number of items that can be stored in the table, or if it exceeds the maximal number of different hash values that can be obtained taking into account the ``hashable'' size of \fBCAESAR_BASE_AREA\fP.
.sp
If the value of \fBCAESAR_PRIME\fP is equal to \fBCAESAR_TRUE\fP and if the value of \fBCAESAR_HASH_SIZE\fP is not a prime number, this value will be replaced by the nearest smaller prime number (since some hash functions require prime modulus). Otherwise, the value of \fBCAESAR_HASH_SIZE\fP will be kept unchanged.
.sp
The actual value of the formal parameter \fBCAESAR_COMPARE\fP will be stored and associated to the table pointed to by \fB*CAESAR_T\fP. It will be used as a comparison function when it is necessary to decide whether two base fields are equal or not.
.sp
Precisely, the actual value of \fBCAESAR_COMPARE\fP should be a pointer to a comparison function with two parameters \fBcaesar_base_1\fP and \fBcaesar_base_2\fP that returns \fBCAESAR_TRUE\fP if the two base fields pointed to by \fBcaesar_base_1\fP and \fBcaesar_base_2\fP are equal.
.sp
If the actual value of the formal parameter \fBCAESAR_COMPARE\fP is \fBNULL\fP, it is replaced by a pointer to a default comparison function that depends on the value of \fBCAESAR_BASE_AREA\fP and is determined according to the rules specified for function \fBCAESAR_USE_COMPARE_FUNCTION_AREA_1()\fP of the ``area_1'' library.
.sp
The actual value of the formal parameter \fBCAESAR_HASH\fP will be stored and associated to the table pointed to by \fB*CAESAR_T\fP. It will be used as a hash-function when it is necessary to compute a hash-value for searching or inserting an item in the table.
.sp
Precisely, the actual value of \fBCAESAR_HASH\fP should be a pointer to a hash function with two parameters \fBcaesar_pointer\fP and \fBcaesar_modulus\fP that returns a natural number in the range 0..\fBcaesar_modulus\fP-1.
.sp
If the actual value of the formal parameter \fBCAESAR_HASH\fP is \fBNULL\fP, it is replaced by a pointer to a default hash function that depends on the value of \fBCAESAR_BASE_AREA\fP and is determined according to the rules specified for function \fBCAESAR_USE_HASH_FUNCTION_AREA_1()\fP of the ``area_1'' library.
.sp
Note: for backward compatibility reasons, the current implementation of \fBCAESAR_CREATE_TABLE_1()\fP tries to handle the case where \fBCAESAR_HASH\fP points to an hash function with three parameters (such as the \fBCAESAR_0_HASH()\fP, \fBCAESAR_1_HASH()\fP, ... functions provided by the ``hash'' library) instead of two.
However, this support for hash functions with three parameters only occurs under very specific circumstances (e.g., if \fBCAESAR_BASE_AREA\fP has a null exponent field and a non-null length field). Relying on this feature is not recommended and this case will no longer be considered in the sequel of this manual.
.sp
The actual value of the formal parameter \fBCAESAR_PRINT\fP will be stored and associated to the table pointed to by \fB*CAESAR_T\fP. It will be used subsequently to print the items of this table.
.sp
Precisely, the actual value of \fBCAESAR_PRINT\fP should be a pointer to a printing procedure with two parameters \fBcaesar_file\fP and \fBcaesar_item\fP that prints to file \fBcaesar_file\fP information about the contents (base field and/or mark field, if any) of the item pointed to by \fBcaesar_item\fP.
.sp
If the actual value of the formal parameter \fBCAESAR_PRINT\fP is \fBNULL\fP, it is replaced by a pointer to a default procedure that prints the base field and the mark field, if any. The printing procedure used for the base field (respectively, the mark field) depends on the value of \fBCAESAR_BASE_AREA\fP (resp. \fBCAESAR_MARK_AREA\fP) and is determined according to the rules specified for function \fBCAESAR_USE_PRINT_FUNCTION_AREA_1()\fP of the ``area_1'' library.
The actual value of the formal parameter \fBCAESAR_OVERFLOW\fP will be stored and associated to the table pointed to by \fB*CAESAR_T\fP. It will be used subsequently to determine the action to take if the table pointed to by \fB*CAESAR_T\fP overflows: in this case, the procedure pointed to by \fBCAESAR_OVERFLOW\fP will be called with the overflowing table \fB*CAESAR_T\fP passed as actual parameter.
.sp
The above procedures \fBCAESAR_OVERFLOW_SIGNAL_TABLE_1()\fP, \fBCAESAR_OVERFLOW_ABORT_TABLE_1()\fP, and \fBCAESAR_OVERFLOW_IGNORE_TABLE_1()\fP, can be used as actual values for the formal parameter \fBCAESAR_OVERFLOW\fP.
If the actual value of the formal parameter \fBCAESAR_OVERFLOW\fP is \fBNULL\fP, it is replaced by the default value \fBCAESAR_OVERFLOW_SIGNAL_TABLE_1\fP.
.sp
The table is initially empty. The success and failure counters attached to the table are both initialized to 0.
.sp
.P
 ............................................................
.SS \fBCAESAR_DELETE_TABLE_1\fP
 \&
.nf
\fBvoid CAESAR_DELETE_TABLE_1 (CAESAR_T)
   CAESAR_TYPE_TABLE_1 *CAESAR_T;
   { ... }
\fP
.fi
This procedure frees the memory space corresponding to the table pointed to by \fB*CAESAR_T\fP using \fBCAESAR_DELETE()\fP. The items contained in the table and its associated hash-table are also freed. Afterwards, the \fBNULL\fP value is assigned to \fB*CAESAR_T\fP.
.sp
.P
 ............................................................
.SS \fBCAESAR_PURGE_TABLE_1\fP
 \&
.nf
\fBvoid CAESAR_PURGE_TABLE_1 (CAESAR_T)
   CAESAR_TYPE_TABLE_1 CAESAR_T;
   { ... }
\fP
.fi
This procedure empties the table pointed to by \fBCAESAR_T\fP without deleting it. Each item contained in the table is freed using \fBCAESAR_DELETE()\fP. Afterwards, this table is exactly in the same state as after its creation using \fBCAESAR_CREATE_TABLE_1()\fP.
.sp
.P
 ............................................................
.SS \fBCAESAR_PUT_INDEX_TABLE_1\fP
 \&
.nf
\fBCAESAR_TYPE_INDEX_TABLE_1 CAESAR_PUT_INDEX_TABLE_1 (CAESAR_T)
   CAESAR_TYPE_TABLE_1 CAESAR_T;
   { ... }
\fP
.fi
This function returns the number of items that have been put in the table pointed to by \fBCAESAR_T\fP, which is also equal to the index of the next item to be put in the table. This number is initialized to 0 and it is incremented every time the \fBCAESAR_PUT_TABLE_1()\fP function (see below) is called.
.sp
Note: This number is always less or equal to N, where N is the maximal number of items that can be stored in the table; the value of N depends on the actual value given to the formal parameter \fBCAESAR_LIMIT_SIZE\fP when the table was created using \fBCAESAR_CREATE_TABLE_1()\fP.
.sp
Note: When the table is empty, the result returned by this function is equal to zero. When the table is full, the result returned by this function is equal to N.
.sp
.P
 ............................................................
.SS \fBCAESAR_PUT_BASE_TABLE_1\fP
 \&
.nf
\fBCAESAR_TYPE_POINTER CAESAR_PUT_BASE_TABLE_1 (CAESAR_T)
   CAESAR_TYPE_TABLE_1 CAESAR_T;
   { ... }
\fP
.fi
If the table pointed to by \fBCAESAR_T\fP is not full, this function returns a pointer to the base field of the next item to be put in the table. This base field is initially undefined and must be assigned before calling some other functions of the ``table_1'' library (see below).
.sp
If the table pointed to by \fBCAESAR_T\fP is full, this function returns a pointer to the base field of a special item located beyond the table. It is permitted to modify (and subsequently consult) the contents of this base field, but invoking the \fBCAESAR_PUT_TABLE_1()\fP function (see below) will cause an overflow.
.sp
.sp
.P
 ............................................................
.SS \fBCAESAR_PUT_MARK_TABLE_1\fP
 \&
.nf
\fBCAESAR_TYPE_POINTER CAESAR_PUT_MARK_TABLE_1 (CAESAR_T)
   CAESAR_TYPE_TABLE_1 CAESAR_T;
   { ... }
\fP
.fi
If there are no mark fields in the table (due to the initialization parameters supplied to \fBCAESAR_CREATE_TABLE_1()\fP), the result returned by \fBCAESAR_PUT_MARK_TABLE_1()\fP is always undefined.
.sp
If the table pointed to by \fBCAESAR_T\fP is not full, this function returns a pointer to the mark field of the next item to be put in the table. This mark field is always initialized to a bit string of 0's. It can be consulted and modified.
.sp
If the table pointed to by \fBCAESAR_T\fP is full, this function returns a pointer to the mark field of a special item located beyond the table. It is permitted to modify and consult the contents of this mark field, but invoking the \fBCAESAR_PUT_TABLE_1()\fP function (see below) will cause an overflow.
.sp
.P
 ............................................................
.SS \fBCAESAR_PUT_TABLE_1\fP
 \&
.nf
\fBvoid CAESAR_PUT_TABLE_1 (CAESAR_T)
   CAESAR_TYPE_TABLE_1 CAESAR_T;
   { ... }
\fP
.fi
This procedure puts into the table pointed to by \fBCAESAR_T\fP the item whose base field is pointed to by \fBCAESAR_PUT_BASE_TABLE_1 (CAESAR_T)\fP and whose mark field (if any) is pointed to by \fBCAESAR_PUT_MARK_TABLE_1 (CAESAR_T)\fP.
.sp
The base field must have been assigned before this procedure is called.
.sp
This procedure assumes that no other item in the table has the same base field. There is no attempt to check the validity of this assumption. It is therefore of the user's responsibility to ensure that this assumption is true. See also function \fBCAESAR_SEARCH_AND_PUT_TABLE_1()\fP below.
.sp
The hash-table associated to the table is updated to take into account the new item. To compute the hash-value for the base field, the hash-function associated with the table is used.
.sp
If the maximum number of items in the table was already reached when the procedure \fBCAESAR_PUT_TABLE_1()\fP was called, or in case of memory shortage, the overflow procedure associated with \fBCAESAR_T\fP is called with the actual parameter \fBCAESAR_T\fP.
.sp
Finally, \fBCAESAR_PUT_INDEX_TABLE_1 (CAESAR_T)\fP is incremented; \fBCAESAR_PUT_BASE_TABLE_1 (CAESAR_T)\fP and \fBCAESAR_PUT_MARK_TABLE_1 (CAESAR_T)\fP are advanced, respectively, to the base field and the mark field (if any) of the next free item.
.sp
Note: the table is implemented in such a way that \fBCAESAR_PUT_BASE_TABLE_1()\fP and \fBCAESAR_PUT_MARK_TABLE_1()\fP always return a valid pointer, even if the table is already full. Overflow can only occur when \fBCAESAR_PUT_TABLE_1()\fP is called, but not when \fBCAESAR_PUT_BASE_TABLE_1()\fP or \fBCAESAR_PUT_MARK_TABLE_1()\fP are called.
.sp
.P
 ............................................................
.SS \fBCAESAR_SEARCH_TABLE_1\fP
 \&
.nf
\fBCAESAR_TYPE_BOOLEAN CAESAR_SEARCH_TABLE_1 (CAESAR_T, CAESAR_B, CAESAR_I, CAESAR_P)
   CAESAR_TYPE_TABLE_1 CAESAR_T;
   CAESAR_TYPE_POINTER CAESAR_B;
   CAESAR_TYPE_INDEX_TABLE_1 *CAESAR_I;
   CAESAR_TYPE_POINTER *CAESAR_P;
   { ... }
\fP
.fi
This function determines if there exists, in the table pointed to by \fBCAESAR_T\fP, an item whose base field is equal to the byte string pointed to by \fBCAESAR_B\fP. Byte string comparisons are performed using the comparison function associated to the table. The search is done using the hash-function and hash-table associated to the table.
.sp
If so, this function returns \fBCAESAR_TRUE\fP. In this case, the index and the address of the item are respectively assigned to \fB*CAESAR_I\fP and \fB*CAESAR_P\fP. The success counter attached to the table is incremented.
If not, this function returns \fBCAESAR_FALSE\fP. In this case, both variables \fB*CAESAR_I\fP and \fB*CAESAR_P\fP are left unchanged. The failure counter attached to the table is incremented.
.sp
.P
 ............................................................
.SS \fBCAESAR_SEARCH_AND_PUT_TABLE_1\fP
 \&
.nf
\fBCAESAR_TYPE_BOOLEAN CAESAR_SEARCH_AND_PUT_TABLE_1 (CAESAR_T, CAESAR_I, CAESAR_P)
   CAESAR_TYPE_TABLE_1 CAESAR_T;
   CAESAR_TYPE_INDEX_TABLE_1 *CAESAR_I;
   CAESAR_TYPE_POINTER *CAESAR_P;
    { ... }
\fP
.fi
This function is a combination of the function \fBCAESAR_SEARCH_TABLE_1()\fP and the procedure \fBCAESAR_PUT_TABLE_1()\fP defined above.
The base field pointed to by \fBCAESAR_PUT_BASE_TABLE_1 (CAESAR_T)\fP must have been assigned before this function is called.
.sp
It first determines if there exists, in the table pointed by \fBCAESAR_T\fP, an item whose base field is equal to the base field of the item pointed to by \fBCAESAR_PUT_BASE_TABLE_1 (CAESAR_T)\fP. Byte string comparisons are performed using the comparison function associated to the table. The search is done using the hash-function and hash-table associated to the table.
.sp
If so, this function returns \fBCAESAR_TRUE\fP. In this case, the index and the address of the existing item are respectively assigned to \fB*CAESAR_I\fP and \fB*CAESAR_P\fP. The success counter attached to the table is incremented.
If not, this function returns \fBCAESAR_FALSE\fP. In this case, it puts into the table pointed to by \fBCAESAR_T\fP the item whose base field is pointed to by \fBCAESAR_PUT_BASE_TABLE_1 (CAESAR_T)\fP and whose mark field (if any) is pointed to by \fBCAESAR_PUT_MARK_TABLE_1 (CAESAR_T)\fP. The hash-table associated to the table is updated to take into account the new item. The overflow procedure associated with the table is called if overflow occurs.
.sp
\fBCAESAR_PUT_INDEX_TABLE_1 (CAESAR_T)\fP is copied into \fB*CAESAR_I\fP and then incremented. \fBCAESAR_PUT_BASE_TABLE_1 (CAESAR_T)\fP is copied into \fB*CAESAR_P\fP and then advanced to the base field of the next free item. The failure counter attached to the table is incremented.
.sp
Note: formally the body of function \fBCAESAR_SEARCH_AND_PUT_TABLE_1()\fP could be defined as follows:
 \&
.nf
\fB        {
        CAESAR_TYPE_BOOLEAN caesar_found;
        caesar_found = CAESAR_SEARCH_TABLE_1 (CAESAR_T,
                CAESAR_PUT_BASE_TABLE_1 (CAESAR_T), CAESAR_I, CAESAR_P);
        if (! caesar_found)
                {
                *CAESAR_I = CAESAR_PUT_INDEX_TABLE_1 (CAESAR_T);
                *CAESAR_P = CAESAR_PUT_BASE_TABLE_1 (CAESAR_T);
                CAESAR_PUT_TABLE_1 (CAESAR_T);
                }
        }
\fP
.fi
Practically, it is implemented differently, for efficiency reasons (the computation of the hash-value and the access through the hash-table are performed only once, not twice).
.sp
.P
 ............................................................
.SS \fBCAESAR_GET_INDEX_TABLE_1\fP
 \&
.nf
\fBCAESAR_TYPE_INDEX_TABLE_1 CAESAR_GET_INDEX_TABLE_1 (CAESAR_T)
   CAESAR_TYPE_TABLE_1 CAESAR_T;
   { ... }
\fP
.fi
This function returns the number of items that have been got from the table pointed to by \fBCAESAR_T\fP, which is also the index of the next item to be got from the table. This number is initialized to 0 and it is incremented every time the \fBCAESAR_GET_TABLE_1()\fP function (see below) is called.
.sp
Note: This number is always less or equal to the value returned by \fBCAESAR_PUT_INDEX_TABLE_1()\fP.
.sp
.P
 ............................................................
.SS \fBCAESAR_GET_BASE_TABLE_1\fP
 \&
.nf
\fBCAESAR_TYPE_POINTER CAESAR_GET_BASE_TABLE_1 (CAESAR_T)
   CAESAR_TYPE_TABLE_1 CAESAR_T;
   { ... }
\fP
.fi
This function returns a pointer to the base field of the next item to be got in the table pointed to by \fBCAESAR_T\fP.
.sp
This pointer can only be used if \fBCAESAR_GET_INDEX_TABLE_1 (CAESAR_T)\fP is strictly less than \fBCAESAR_PUT_INDEX_TABLE_1 (CAESAR_T)\fP. In the opposite case, the result of this function is undefined (since it is not possible to get items that have not been put yet).
.sp
The base field pointed to by the result of \fBCAESAR_GET_BASE_TABLE_1()\fP can be consulted, but not modified.
.sp
.P
 ............................................................
.SS \fBCAESAR_GET_MARK_TABLE_1\fP
 \&
.nf
\fBCAESAR_TYPE_POINTER CAESAR_GET_MARK_TABLE_1 (CAESAR_T)
   CAESAR_TYPE_TABLE_1 CAESAR_T;
   { ... }
\fP
.fi
This function returns a pointer to the mark field of the next item to be got in the table pointed to by \fBCAESAR_T\fP. If there are no mark fields in the table (due to the initialization parameters supplied to \fBCAESAR_CREATE_TABLE_1()\fP) the result is undefined.
.sp
This pointer can only be used if \fBCAESAR_GET_INDEX_TABLE_1 (CAESAR_T)\fP is strictly less than \fBCAESAR_PUT_INDEX_TABLE_1 (CAESAR_T)\fP. In the opposite case, the result of this function is undefined (since it is not possible to get items that have not been put yet).
.sp
The mark field pointed to by the result of \fBCAESAR_GET_MARK_TABLE_1()\fP can be either consulted or modified.
.sp
.P
 ............................................................
.SS \fBCAESAR_GET_TABLE_1\fP
 \&
.nf
\fBvoid CAESAR_GET_TABLE_1 (CAESAR_T)
   CAESAR_TYPE_TABLE_1 CAESAR_T;
   { ... }
\fP
.fi
This procedure increments \fBCAESAR_GET_INDEX_TABLE_1 (CAESAR_T)\fP; it advances, respectively, \fBCAESAR_GET_BASE_TABLE_1 (CAESAR_T)\fP and \fBCAESAR_GET_MARK_TABLE_1 (CAESAR_T)\fP to the base field and the mark field (if any) of the next free item.
.sp
If \fBCAESAR_GET_INDEX_TABLE_1 (CAESAR_T)\fP is equal to \fBCAESAR_PUT_INDEX_TABLE_1 (CAESAR_T)\fP when the procedure \fBCAESAR_GET_TABLE_1()\fP is called, the result is undefined.
.sp
.P
 ............................................................
.SS \fBCAESAR_EMPTY_TABLE_1\fP
 \&
.nf
\fBCAESAR_TYPE_BOOLEAN CAESAR_EMPTY_TABLE_1 (CAESAR_T)
   CAESAR_TYPE_TABLE_1 CAESAR_T;
   { ... }
\fP
.fi
This function returns a value different from 0 if the table pointed to by \fBCAESAR_T\fP is empty, and 0 otherwise. \fBCAESAR_EMPTY_TABLE_1 (CAESAR_T)\fP is always equivalent to:
.TS
center;
l.
 
 \fBCAESAR_PUT_INDEX_TABLE_1 (CAESAR_T) == 0\fP 
 
.TE
.sp
.P
 ............................................................
.SS \fBCAESAR_FULL_TABLE_1\fP
 \&
.nf
\fBCAESAR_TYPE_BOOLEAN CAESAR_FULL_TABLE_1 (CAESAR_T)
   CAESAR_TYPE_TABLE_1 CAESAR_T;
   { ... }
\fP
.fi
This function returns a value different from 0 if the table pointed to by \fBCAESAR_T\fP is full, and 0 otherwise. \fBCAESAR_FULL_TABLE_1 (CAESAR_T)\fP is always equivalent to:
.TS
center;
l.
 
 \fBCAESAR_PUT_INDEX_TABLE_1 (CAESAR_T) == $N$\fP 
 
.TE
where N denotes the maximum number of items that the table can contain; the value of N depends on the actual value given to the formal parameter \fBCAESAR_LIMIT_SIZE\fP when the table was created using \fBCAESAR_CREATE_TABLE_1()\fP.
.sp
.P
 ............................................................
.SS \fBCAESAR_EXPLORED_TABLE_1\fP
 \&
.nf
\fBCAESAR_TYPE_BOOLEAN CAESAR_EXPLORED_TABLE_1 (CAESAR_T)
   CAESAR_TYPE_TABLE_1 CAESAR_T;
   { ... }
\fP
.fi
This function returns a value different from 0 if the get index and the put index are identical, or 0 otherwise. \fBCAESAR_EXPLORED_TABLE_1 (CAESAR_T)\fP is always equivalent to:
.TS
center;
l.
 
 \fBCAESAR_GET_INDEX_TABLE_1 (CAESAR_T) == CAESAR_PUT_INDEX_TABLE_1 (CAESAR_T)\fP 
 
.TE
.sp
.P
 ............................................................
.SS \fBCAESAR_RETRIEVE_I_B_TABLE_1\fP
 \&
.nf
\fBvoid CAESAR_RETRIEVE_I_B_TABLE_1 (CAESAR_T, CAESAR_I, CAESAR_B)
   CAESAR_TYPE_TABLE_1 CAESAR_T;
   CAESAR_TYPE_INDEX_TABLE_1 CAESAR_I;
   CAESAR_TYPE_POINTER *CAESAR_B;
   { ... }
\fP
.fi
This procedure computes the address of the base field of the item with index \fBCAESAR_I\fP in the table pointed to by \fBCAESAR_T\fP. This address is assigned to \fB*CAESAR_B\fP.
.sp
If \fBCAESAR_I\fP is greater or equal to the value returned by \fBCAESAR_PUT_INDEX_TABLE_1()\fP, a \fBNULL\fP pointer is assigned to \fB*CAESAR_B\fP.
.sp
.P
 ............................................................
.SS \fBCAESAR_RETRIEVE_I_M_TABLE_1\fP
 \&
.nf
\fBvoid CAESAR_RETRIEVE_I_M_TABLE_1 (CAESAR_T, CAESAR_I, CAESAR_M)
   CAESAR_TYPE_TABLE_1 CAESAR_T;
   CAESAR_TYPE_INDEX_TABLE_1 CAESAR_I;
   CAESAR_TYPE_POINTER *CAESAR_M;
   { ... }
\fP
.fi
This procedure computes the address of the mark field of the item with index \fBCAESAR_I\fP in the table pointed to by \fBCAESAR_T\fP. This address is assigned to \fB*CAESAR_M\fP.
.sp
If \fBCAESAR_I\fP is greater or equal to the value returned by \fBCAESAR_PUT_INDEX_TABLE_1()\fP, a \fBNULL\fP pointer is assigned to \fB*CAESAR_M\fP.
.sp
If there are no mark fields in the table (due to the initialization parameters supplied to \fBCAESAR_CREATE_TABLE_1()\fP) the effect of this procedure is undefined.
.sp
.P
 ............................................................
.SS \fBCAESAR_RETRIEVE_I_BM_TABLE_1\fP
 \&
.nf
\fBvoid CAESAR_RETRIEVE_I_BM_TABLE_1 (CAESAR_T, CAESAR_I, CAESAR_B, CAESAR_M)
   CAESAR_TYPE_TABLE_1 CAESAR_T;
   CAESAR_TYPE_INDEX_TABLE_1 CAESAR_I;
   CAESAR_TYPE_POINTER *CAESAR_B;
   CAESAR_TYPE_POINTER *CAESAR_M;
   { ... }
\fP
.fi
This procedure computes the address of the base field of the item with index \fBCAESAR_I\fP in the table pointed to by \fBCAESAR_T\fP. This address is assigned to \fB*CAESAR_B\fP.
.sp
It also computes the address of the mark field of the item with index \fBCAESAR_I\fP in the table pointed to by \fBCAESAR_T\fP. This address is assigned to \fB*CAESAR_M\fP.
.sp
If \fBCAESAR_I\fP is greater or equal to the value returned by \fBCAESAR_PUT_INDEX_TABLE_1()\fP, a \fBNULL\fP pointer is assigned to \fB*CAESAR_B\fP and \fB*CAESAR_M\fP.
.sp
If there are no mark fields in the table (due to the initialization parameters supplied to \fBCAESAR_CREATE_TABLE_1()\fP) the effect of this procedure is undefined.
.sp
.P
 ............................................................
.SS \fBCAESAR_RETRIEVE_B_I_TABLE_1\fP
 \&
.nf
\fBvoid CAESAR_RETRIEVE_B_I_TABLE_1 (CAESAR_T, CAESAR_B, CAESAR_I)
CAESAR_TYPE_TABLE_1 CAESAR_T;
CAESAR_TYPE_POINTER CAESAR_B;
CAESAR_TYPE_INDEX_TABLE_1 *CAESAR_I;
   { ... }
\fP
.fi
This procedure computes the index of the item whose base field, in the table pointed to by \fBCAESAR_T\fP, is pointed to by \fBCAESAR_B\fP. This index is assigned to \fB*CAESAR_I\fP.
.sp
If no item stored in the table has a base field at address \fBCAESAR_B\fP, the \fBCAESAR_NULL_INDEX_TABLE_1\fP value is assigned to \fB*CAESAR_I\fP.
.sp
.P
 ............................................................
.SS \fBCAESAR_RETRIEVE_M_I_TABLE_1\fP
 \&
.nf
\fBvoid CAESAR_RETRIEVE_M_I_TABLE_1 (CAESAR_T, CAESAR_M, CAESAR_I)
CAESAR_TYPE_TABLE_1 CAESAR_T;
CAESAR_TYPE_POINTER CAESAR_M;
CAESAR_TYPE_INDEX_TABLE_1 *CAESAR_I;
   { ... }
\fP
.fi
This procedure computes the index of the item whose mark field, in the table pointed to by \fBCAESAR_T\fP, is pointed to by \fBCAESAR_M\fP. This index is assigned to \fB*CAESAR_I\fP.
.sp
If no item stored in the table has a mark field at address \fBCAESAR_M\fP, the \fBCAESAR_NULL_INDEX_TABLE_1\fP value is assigned to \fB*CAESAR_I\fP.
.sp
If there are no mark fields in the table (due to the initialization parameters supplied to \fBCAESAR_CREATE_TABLE_1()\fP) the effect of this procedure is undefined.
.sp
.P
 ............................................................
.SS \fBCAESAR_RETRIEVE_B_M_TABLE_1\fP
 \&
.nf
\fBvoid CAESAR_RETRIEVE_B_M_TABLE_1 (CAESAR_T, CAESAR_B, CAESAR_M)
CAESAR_TYPE_TABLE_1 CAESAR_T;
CAESAR_TYPE_POINTER CAESAR_B;
CAESAR_TYPE_POINTER *CAESAR_M;
   { ... }
\fP
.fi
This procedure computes, for the table pointed to by \fBCAESAR_T\fP, the address of the mark field of the item whose base field is pointed to by \fBCAESAR_B\fP. This address is assigned to \fB*CAESAR_M\fP.
.sp
If no item stored in the table has a base field at address \fBCAESAR_B\fP, the effect of this procedure is undefined.
.sp
If there are no mark fields in the table (due to the initialization parameters supplied to \fBCAESAR_CREATE_TABLE_1()\fP) the effect of this procedure is undefined.
.sp
.P
 ............................................................
.SS \fBCAESAR_RETRIEVE_M_B_TABLE_1\fP
 \&
.nf
\fBvoid CAESAR_RETRIEVE_M_B_TABLE_1 (CAESAR_T, CAESAR_M, CAESAR_B)
CAESAR_TYPE_TABLE_1 CAESAR_T;
CAESAR_TYPE_POINTER CAESAR_M;
CAESAR_TYPE_POINTER *CAESAR_B;
   { ... }
\fP
.fi
This procedure computes, for the table pointed to by \fBCAESAR_T\fP, the address of the base field of the item whose mark field is pointed to by \fBCAESAR_M\fP. This address is assigned to \fB*CAESAR_B\fP.
.sp
If no item stored in the table has a mark field at address \fBCAESAR_M\fP, the effect of this procedure is undefined.
.sp
If there are no mark fields in the table (due to the initialization parameters supplied to \fBCAESAR_CREATE_TABLE_1()\fP) the effect of this procedure is undefined.
.sp
.P
 ............................................................
.SS \fBCAESAR_FAILURE_TABLE_1\fP
 \&
.nf
\fBCAESAR_TYPE_NATURAL CAESAR_FAILURE_TABLE_1 (CAESAR_T)
   CAESAR_TYPE_TABLE_1 CAESAR_T;
   { ... }
\fP
.fi
This function returns the value of the failure counter of the table pointed to by \fBCAESAR_T\fP, i.e., the number of searches that failed.
.sp
.P
 ............................................................
.SS \fBCAESAR_SUCCESS_TABLE_1\fP
 \&
.nf
\fBCAESAR_TYPE_NATURAL CAESAR_SUCCESS_TABLE_1 (CAESAR_T)
   CAESAR_TYPE_TABLE_1 CAESAR_T;
   { ... }
\fP
.fi
This function returns the value of the success counter of the table pointed to by \fBCAESAR_T\fP, i.e., the number of searches that succeeded.
.sp
.P
 ............................................................
.SS \fBCAESAR_FORMAT_TABLE_1\fP
 \&
.nf
\fBCAESAR_TYPE_FORMAT CAESAR_FORMAT_TABLE_1 (CAESAR_T, CAESAR_FORMAT)
   CAESAR_TYPE_TABLE_1 CAESAR_T;
   CAESAR_TYPE_FORMAT CAESAR_FORMAT;
   { ... }
\fP
.fi
This function allows to control the format under which the table pointed to by \fBCAESAR_T\fP will be printed by the procedure \fBCAESAR_PRINT_TABLE_1()\fP (see below).
.sp
Currently, the following formats are available:
.IP -
With format 0, statistical information about the table is displayed such as: the number of items put, the number of items got, the size in bytes, the success counter, the failure counter, etc.
.IP -
With format 1, all items in the table are printed, sorted by increasing indexes. For each item, the corresponding index is displayed; the base field and the mark field (if any) are also displayed using the printing procedure associated to the table.
.IP -
With format 2, all items in the table are printed, sorted by increasing indexes. For each item, the index, the address, and the corresponding hash-value are displayed; the base field and the mark field (if any) are also displayed using the printing procedure associated to the table. Informations concerning the associated hash-table are also displayed. This format is mainly intended for debugging purpose.
.IP -
(no other format available yet)
.P
By default, the current format of each table is initialized to 0.
.sp
When called with \fBCAESAR_FORMAT\fP between 0 and 2, this fonction sets the current format of \fBCAESAR_T\fP to \fBCAESAR_FORMAT\fP and returns an undefined result.
.sp
When called with another value of \fBCAESAR_FORMAT\fP, this function does not modify the current format of \fBCAESAR_T\fP but returns a result defined as follows. If \fBCAESAR_FORMAT\fP is equal to the constant \fBCAESAR_CURRENT_FORMAT\fP, the result is the value of the current format of \fBCAESAR_T\fP. If \fBCAESAR_FORMAT\fP is equal to the constant \fBCAESAR_MAXIMAL_FORMAT\fP, the result is the maximal format value (i.e., 2). In all other cases, the effect of this function is undefined.
.sp
.sp
.P
 ............................................................
.SS \fBCAESAR_MAX_FORMAT_TABLE_1\fP
 \&
.nf
\fBCAESAR_TYPE_FORMAT CAESAR_MAX_FORMAT_TABLE_1 ()
   { ... }
\fP
.fi
Caution! This function is deprecated. It should no longer be used, as it might be removed from future versions of the \fIOPEN/CAESAR\fP. Use function \fBCAESAR_FORMAT_TABLE_1()\fP instead, called with argument \fBCAESAR_MAXIMAL_FORMAT\fP.
.sp
This function returns the maximal format value available for printing tables.
.sp
.P
 ............................................................
.SS \fBCAESAR_PRINT_TABLE_1\fP
 \&
.nf
\fBvoid CAESAR_PRINT_TABLE_1 (CAESAR_FILE, CAESAR_T)
   CAESAR_TYPE_FILE CAESAR_FILE;
   CAESAR_TYPE_TABLE_1 CAESAR_T;
   { ... }
\fP
.fi
This procedure prints to file \fBCAESAR_FILE\fP a text containing information about the table pointed to by \fBCAESAR_T\fP. The nature of the information is determined by the current format of the table pointed to by \fBCAESAR_T\fP.
.sp
Before this procedure is called, \fBCAESAR_FILE\fP must have been properly opened, for instance using \fBfopen(3)\fP.
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
