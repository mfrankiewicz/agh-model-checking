'\" t
.\" @(#)caesar_cache_1.l - VASY and CONVECS teams - version 1.2
.TH caesar_cache_1 LOCAL "2020/02/11 (version 1.2)" "(C) INRIA" "OPEN/CAESAR MANUAL"
.fp 4 CB
.lg 0
.SH NAME
caesar_cache_1 \- the ``cache_1'' library of OPEN/CAESAR
.SH PURPOSE
The ``cache_1'' library provides primitives for storing arbitrary data items in caches, which can be organized hierarchically. It can be used to speed up the execution of applications that involve costly search operations (by storing data items in caches for fast retrievals), and also to reduce the memory consumption of state space exploration algorithms (by storing a certain amount of states in caches).
.sp
.sp
.SH USAGE
The ``cache_1'' library consists of:
.IP -
a predefined header file \fBcaesar_cache_1.h\fP;
.IP -
the precompiled library file \fBlibcaesar.a\fP, which implements the features described in \fBcaesar_cache_1.h\fP.
.P
Note: The ``cache_1'' library is a software layer built above the primitives offered by the ``standard'', ``area_1'', and ``hash'' libraries, and by the \fIOPEN/CAESAR\fP graph module. It follows as close as possible the principles and features of the ``table_1'' library.
.sp
.sp
.SH DESCRIPTION
A ``cache'' is basically a set containing a fixed number of items.
.sp
Each item in the cache is basically a byte string of fixed size. All items in a given cache have the same size. An item can be considered as a tuple with two fields, whose size and contents are freely determined by the user:
.IP -
(1) a ``base'' field, that is a byte string of fixed size. In a given cache, all base fields have the same size. This size must be greater than zero.
.sp
Sometimes, the base field contains a state (as defined in the graph module). However, this is not mandatory, and base fields can contain other information than states.
.IP -
(2) a ``mark'' field, that is a byte string whose size and contents are freely determined by the user. In a given cache, all mark fields have the same size, which must be greater or equal to zero. Pointers to mark fields will be considered as values of type \fBCAESAR_TYPE_POINTER\fP; mark fields are always aligned on appropriate boundaries so that the user can put any information in these fields without alignment problem.
.P
The user also determines the nature of the data stored in these fields, which is not meaningful to the ``cache_1'' library.
.sp
A cache is organized as a collection of ``subcaches'', each one containing a fixed number of items. A cache can contain no more than a maximum of P subcaches, where currently P = 256. In a cache containing N subcaches, each subcache is assigned an unique index in the range 0..N-1. The subcaches are linked hierarchically by a parent relation, which links a subcache to its ``children'' subcaches. The parent relation is an acyclic relation having as root element the subcache of index 0, denoted ``root subcache'' in the sequel. All the other subcaches are assumed to be descendants of the root subcache, i.e., they should be reachable from the root subcache via the parent relation. A subcache without children subcaches is called a ``leaf'' subcache. The parent relation linking the subcaches of a cache is not necessarily static, but can dynamically change during the usage of the cache.
.sp
A cache can contain no more than a maximum of M items. Currently, M = 2^{29} = 536,870,912 on 32-bit machines and M = 2^{34} = 17,179,869,184 on 64-bit machines. But, for each cache, the user can also limit the maximal number of items to a lesser bound K < M.
.sp
To each cache is associated its current global date, which is the number of modifying operations performed on the cache since it was created. The operations modifying the status of a cache are the following: putting an item into the cache, ``hitting'' an item (i.e., searching and finding the item) in the cache, deleting an item from the cache, and updating an item present in the cache. In the sequel, whenever this is understood from the context, we will use the term ``date'' to designate the current global date of a cache. To each subcache of a cache is associated its current local date, i.e., the date when the last modifying operation was performed on an item present in the subcache.
.sp
To each item present in a cache are associated the following fields:
.IP -
the date when the item was put into the cache;
.IP -
the date of the last access to the item by a put, a hit, or an update operation;
.IP -
the number of hits at the item since it was put into the cache.
.P
All these fields can be accessed from the address of the item (i.e., a pointer to the memory location where the item is stored in the cache).
.sp
Invariant property 1: all items present in a cache have different dates when they were put into the cache. Therefore, the date when an item was put into the cache can serve as unique identification number for the item.
.sp
Invariant property 2: all items present in a cache have different last access dates (but several items may have the same number of hits).
.sp
Invariant property 3: it is not allowed to modify the base field of any item in the cache. But it is possible to modify the mark field of any item.
.sp
Each item of a cache can be accessed by using its address or its base field. The cache data structure establishes a correspondence between these two data. Indeed:
.IP -
given an address, one can retrieve the base field and the mark field of the corresponding item;
.IP -
given a base field, one can retrieve the address and the mark field of the corresponding item.
.P
Retrieving the address of an item from its base field involves some associative search. To allow fast retrievals, a hash-table is associated to each cache. This is quite transparent from the user's point of view. Only the base field is taken into account when computing the hash-value and comparing items; the mark field is not meaningful for the search.
.sp
To each cache are associated two counters recording the number of search and hit operations performed on the cache, respectively. To each subcache of a cache is associated a counter recording the number of hit operations at (items of) that subcache.
.sp
The operation of putting an item E into a cache proceeds as follows. The item is always put into the root subcache (of index 0). When this subcache becomes full, the item E replaces the smallest item E1 contained in this subcache according to the order relation underlying the replacement strategy associated to this subcache. The item E1 is put into one of the child subcaches (of index I1) of the root subcache, determined by the parent relation between subcaches and by the contents of the item E1. If the subcache of index I1 is also full, then the item E1 replaces the smallest item E2 contained in this subcache, and the item E2 will be in turn put into a child subcache (of index I2) of the subcache of index I1, and so on. This process continues along a sequence of subcaches in the hierarchy until either it reaches a subcache of index Ij that is not full (and can therefore accept the current item Ej to be put into it), or it reaches a leaf subcache of index Ik that is full. In the latter case, the item Ek+1 replaced in the leaf subcache is stored temporarily in a field associated to the cache until the next put operation on the cache causes another item El+1 to be replaced in some leaf subcache of index Il that is already full; the item Ek+1 is then deleted and replaced by El+1.
.sp
The parent relation between the subcaches of a cache is assumed to be acyclic (in order to ensure the termination of put operations), but this condition cannot be checked at the creation of the cache because the parent relation may change dynamically during execution. Instead, this condition is checked at each put operation, and if a cycle between subcaches is detected, then the operation is stopped and an appropriate error code is set.
.sp
The ``cache_1'' library supports applications involving dynamic creation of caches. When a put operation performed on a cache C1 causes a replacement to take place, another cache C2 can be created and the last item replaced in C1 (which can be inspected using the \fBCAESAR_LAST_ITEM_REPLACED_CACHE_1()\fP procedure below) can be put into C2. This enables to build hierarchies of caches similar to the hierarchies of subcaches present in individual caches. It is the user's responsibility to ensure that a put operation performed on a cache of a hierarchy does not cause a cycle of put operations on the other caches of the hierarchy.
.sp
.sp
.SH FEATURES
.P
 ............................................................
.SS \fBCAESAR_TYPE_CACHE_1\fP
 \&
.nf
\fBtypedef CAESAR_TYPE_ABSTRACT (...) CAESAR_TYPE_CACHE_1;
\fP
.fi
This type denotes a pointer to the concrete representation of a cache. This representation is supposed to be ``opaque''.
.sp
.P
 ............................................................
.SS \fBCAESAR_TYPE_NATURAL_FUNCTION_CACHE_1\fP
 \&
.nf
\fBtypedef CAESAR_TYPE_NATURAL
   (*CAESAR_TYPE_NATURAL_FUNCTION_CACHE_1) (CAESAR_TYPE_NATURAL);
\fP
.fi
This type denotes a pointer to a function which takes as parameter a natural number (index of a subcache) and returns a natural number (size or percentage of the subcache).
.sp
.P
 ............................................................
.SS \fBCAESAR_TYPE_ORDER_FUNCTION_CACHE_1\fP
 \&
.nf
\fBtypedef CAESAR_TYPE_INTEGER
   (*CAESAR_TYPE_ORDER_FUNCTION_CACHE_1) (CAESAR_TYPE_CACHE_1,
      CAESAR_TYPE_POINTER, CAESAR_TYPE_POINTER);
\fP
.fi
This type denotes a pointer to a function which takes as parameters a cache and two pointers to items (supposed to be contained in the cache), and returns an integer number indicating whether the first item is smaller than, equal to, or greater than the second one modulo an order relation.
.sp
.P
 ............................................................
.SS \fBCAESAR_TYPE_SUBCACHE_FUNCTION_CACHE_1\fP
 \&
.nf
\fBtypedef CAESAR_TYPE_NATURAL
   (*CAESAR_TYPE_SUBCACHE_FUNCTION_CACHE_1) (CAESAR_TYPE_CACHE_1,
      CAESAR_TYPE_NATURAL, CAESAR_TYPE_POINTER);
\fP
.fi
This type denotes a pointer to a function which takes as parameters a cache, a natural number (index of a subcache) and a pointer to an item (the last item replaced in the subcache), and returns a natural number (index of the child subcache in which the replaced item will be put).
.sp
.P
 ............................................................
.SS \fBCAESAR_TYPE_CLEANUP_FUNCTION_CACHE_1\fP
 \&
.nf
\fBtypedef void
   (*CAESAR_TYPE_CLEANUP_FUNCTION_CACHE_1) (CAESAR_TYPE_POINTER);
\fP
.fi
This type denotes a pointer to a procedure which takes as parameter a pointer to an item and cleans up the contents of the item (see the procedure \fBCAESAR_CREATE_CACHE_1()\fP below).
.sp
.P
 ............................................................
.SS \fBCAESAR_TYPE_ERROR_CACHE_1\fP
 \&
.nf
\fBtypedef enum {
     CAESAR_NONE_CACHE_1,
     CAESAR_CYCLIC_CACHE_1
}    CAESAR_TYPE_ERROR_CACHE_1;
\fP
.fi
This enumerated type defines the error codes produced as a side effect by calls to the procedure \fBCAESAR_PUT_CACHE_1()\fP or to the function \fBCAESAR_SEARCH_AND_PUT_CACHE_1()\fP (see below), which put an item into a cache. The error codes have the following meaning:
.IP -
\fBCAESAR_NONE_CACHE_1\fP indicates that the put operation was performed successfully.
.IP -
\fBCAESAR_CYCLIC_CACHE_1\fP indicates the existence of a cycle in the parent relation between subcaches, which would cause the put operation to loop indefinitely when the subcaches present on that cycle are full.
.P
Note: The error code produced by a call to the procedure \fBCAESAR_PUT_CACHE_1()\fP or to the function \fBCAESAR_SEARCH_AND_PUT_CACHE_1()\fP can be obtained by using the function \fBCAESAR_STATUS_PUT_CACHE_1()\fP (see below).
.sp
.P
 ............................................................
.SS \fBCAESAR_LRU_ORDER_CACHE_1\fP
 \&
.nf
\fBCAESAR_TYPE_INTEGER CAESAR_LRU_ORDER_CACHE_1 (CAESAR_C, CAESAR_B1, CAESAR_B2)
   CAESAR_TYPE_CACHE_1 CAESAR_C;
   CAESAR_TYPE_POINTER CAESAR_B1;
   CAESAR_TYPE_POINTER CAESAR_B2;
   { ... }
\fP
.fi
This function returns an integer number which is smaller than, equal to, or greater than 0 depending whether the item pointed to by \fBCAESAR_B1\fP is smaller than, equal to, or greater than the item pointed to by \fBCAESAR_B2\fP according to the order relation underlying the ``least recently used'' (LRU) replacement strategy.
.sp
According to this order relation, an item is smaller than, equal to, or greater than another item if the date of the last access to the first item is smaller than, equal to, or greater than the date of the last access to the second item, respectively.
.sp
.P
 ............................................................
.SS \fBCAESAR_MRU_ORDER_CACHE_1\fP
 \&
.nf
\fBCAESAR_TYPE_INTEGER CAESAR_MRU_ORDER_CACHE_1 (CAESAR_C, CAESAR_B1, CAESAR_B2)
   CAESAR_TYPE_CACHE_1 CAESAR_C;
   CAESAR_TYPE_POINTER CAESAR_B1;
   CAESAR_TYPE_POINTER CAESAR_B2;
   { ... }
\fP
.fi
This function returns an integer number which is smaller than, equal to, or greater than 0 depending whether the item pointed to by \fBCAESAR_B1\fP is smaller than, equal to, or greater than the item pointed to by \fBCAESAR_B2\fP according to the order relation underlying the ``most recently used'' (MRU) replacement strategy.
.sp
According to this order relation, an item is smaller than, equal to, or greater than another item if the date of the last access to the first item is greater than, equal to, or smaller than the date of the last access to the second item, respectively.
.sp
.P
 ............................................................
.SS \fBCAESAR_LRP_ORDER_CACHE_1\fP
 \&
.nf
\fBCAESAR_TYPE_INTEGER CAESAR_LRP_ORDER_CACHE_1 (CAESAR_C, CAESAR_B1, CAESAR_B2)
   CAESAR_TYPE_CACHE_1 CAESAR_C;
   CAESAR_TYPE_POINTER CAESAR_B1;
   CAESAR_TYPE_POINTER CAESAR_B2;
   { ... }
\fP
.fi
This function returns an integer number which is smaller than, equal to, or greater than 0 depending whether the item pointed to by \fBCAESAR_B1\fP is smaller than, equal to, or greater than the item pointed to by \fBCAESAR_B2\fP according to the order relation underlying the ``least recently put'' (LRP) replacement strategy.
.sp
According to this order relation, an item is smaller than, equal to, or greater than another item if the date when the first item was put into the cache is smaller than, equal to, or greater than the date when the second item was put into the cache, respectively.
.sp
.P
 ............................................................
.SS \fBCAESAR_MRP_ORDER_CACHE_1\fP
 \&
.nf
\fBCAESAR_TYPE_INTEGER CAESAR_MRP_ORDER_CACHE_1 (CAESAR_C, CAESAR_B1, CAESAR_B2)
   CAESAR_TYPE_CACHE_1 CAESAR_C;
   CAESAR_TYPE_POINTER CAESAR_B1;
   CAESAR_TYPE_POINTER CAESAR_B2;
   { ... }
\fP
.fi
This function returns an integer number which is smaller than, equal to, or greater than 0 depending whether the item pointed to by \fBCAESAR_B1\fP is smaller than, equal to, or greater than the item pointed to by \fBCAESAR_B2\fP according to the order relation underlying the ``most recently put'' (MRP) replacement strategy.
.sp
According to this order relation, an item is smaller than, equal to, or greater than another item if the date when the first item was put into the cache is greater than, equal to, or smaller than the date when the second item was put into the cache, respectively.
.sp
.P
 ............................................................
.SS \fBCAESAR_LFU_ORDER_CACHE_1\fP
 \&
.nf
\fBCAESAR_TYPE_INTEGER CAESAR_LFU_ORDER_CACHE_1 (CAESAR_C, CAESAR_B1, CAESAR_B2)
   CAESAR_TYPE_CACHE_1 CAESAR_C;
   CAESAR_TYPE_POINTER CAESAR_B1;
   CAESAR_TYPE_POINTER CAESAR_B2;
   { ... }
\fP
.fi
This function returns an integer number which is smaller than, equal to, or greater than 0 depending whether the item pointed to by \fBCAESAR_B1\fP is smaller than, equal to, or greater than the item pointed to by \fBCAESAR_B2\fP according to the order relation underlying the ``least frequently used'' (LFU) replacement strategy.
.sp
According to this order relation, an item is smaller than, equal to, or greater than another item if the number of hits at the first item is smaller than, equal to, or greater than the number of hits at the second item, respectively.
.sp
.P
 ............................................................
.SS \fBCAESAR_MFU_ORDER_CACHE_1\fP
 \&
.nf
\fBCAESAR_TYPE_INTEGER CAESAR_MFU_ORDER_CACHE_1 (CAESAR_C, CAESAR_B1, CAESAR_B2)
   CAESAR_TYPE_CACHE_1 CAESAR_C;
   CAESAR_TYPE_POINTER CAESAR_B1;
   CAESAR_TYPE_POINTER CAESAR_B2;
   { ... }
\fP
.fi
This function returns an integer number which is smaller than, equal to, or greater than 0 depending whether the item pointed to by \fBCAESAR_B1\fP is smaller than, equal to, or greater than the item pointed to by \fBCAESAR_B2\fP according to the order relation underlying the ``most frequently used'' (MFU) replacement strategy.
.sp
According to this order relation, an item is smaller than, equal to, or greater than another item if the number of hits at the first item is greater than, equal to, or smaller than the number of hits at the second item, respectively.
.sp
.P
 ............................................................
.SS \fBCAESAR_RND_ORDER_CACHE_1\fP
 \&
.nf
\fBCAESAR_TYPE_INTEGER CAESAR_RND_ORDER_CACHE_1 (CAESAR_C, CAESAR_B1, CAESAR_B2)
   CAESAR_TYPE_CACHE_1 CAESAR_C;
   CAESAR_TYPE_POINTER CAESAR_B1;
   CAESAR_TYPE_POINTER CAESAR_B2;
   { ... }
\fP
.fi
This function returns an integer number which is smaller than, equal to, or greater than 0 depending whether the item pointed to by \fBCAESAR_B1\fP is smaller than, equal to, or greater than the item pointed to by \fBCAESAR_B2\fP according to the order relation underlying the ``random'' (RND) replacement strategy.
.sp
This order relation is implemented by computing for every item a random cost, i.e., a natural number randomly generated by taking into account the seed associated to the cache pointed to by \fBCAESAR_C\fP (see the procedure \fBCAESAR_SEED_RND_CACHE_1()\fP below), the current global date of the cache, and the base field of the item. According to this relation, an item is smaller than, equal to, or greater than another item if the random cost of the first item is smaller than, equal to, or greater than the random cost of the second item, respectively.
.sp
.P
 ............................................................
.SS \fBCAESAR_LFU_LRU_ORDER_CACHE_1\fP
 \&
.nf
\fBCAESAR_TYPE_INTEGER CAESAR_LFU_LRU_ORDER_CACHE_1 (CAESAR_C, CAESAR_B1, CAESAR_B2)
   CAESAR_TYPE_CACHE_1 CAESAR_C;
   CAESAR_TYPE_POINTER CAESAR_B1;
   CAESAR_TYPE_POINTER CAESAR_B2;
   { ... }
\fP
.fi
This function returns an integer number which is smaller than, equal to, or greater than 0 depending whether the item pointed to by \fBCAESAR_B1\fP is smaller than, equal to, or greater than the item pointed to by \fBCAESAR_B2\fP according to the order relation underlying the ``least frequently used, then least recently used'' (LFU_LRU) replacement strategy.
.sp
According to this order relation:
.IP -
an item is smaller than another item if the number of hits at the first item is smaller than the number of hits at the second one, or the number of hits is the same for both items but the date of the last access to the first item is smaller than the date of the last access to the second one;
.IP -
an item is equal to another one if the number of hits and the date of the last access are the same for both items;
.IP -
an item is greater than another item if the number of hits at the first item is greater than the number of hits at the second one, or the number of hits is the same for both items but the date of the last access to the first item is greater than the date of the last access to the second one.
.P
In other words, the LFU_LRU replacement strategy consists in applying first the LFU, then the LRU replacement strategies.
.sp
.P
 ............................................................
.SS \fBCAESAR_LFU_MRU_ORDER_CACHE_1\fP
 \&
.nf
\fBCAESAR_TYPE_INTEGER CAESAR_LFU_MRU_ORDER_CACHE_1 (CAESAR_C, CAESAR_B1, CAESAR_B2)
   CAESAR_TYPE_CACHE_1 CAESAR_C;
   CAESAR_TYPE_POINTER CAESAR_B1;
   CAESAR_TYPE_POINTER CAESAR_B2;
   { ... }
\fP
.fi
This function returns an integer number which is smaller than, equal to, or greater than 0 depending whether the item pointed to by \fBCAESAR_B1\fP is smaller than, equal to, or greater than the item pointed to by \fBCAESAR_B2\fP according to the order relation underlying the ``least frequently used, then most recently used'' (LFU_MRU) replacement strategy.
.sp
According to this order relation:
.IP -
an item is smaller than another item if the number of hits at the first item is smaller than the number of hits at the second one, or the number of hits is the same for both items but the date of the last access to the first item is greater than the date of the last access to the second one;
.IP -
an item is equal to another one if the number of hits and the date of the last access are the same for both items;
.IP -
an item is greater than another item if the number of hits at the first item is greater than the number of hits at the second one, or the number of hits is the same for both items but the date of the last access to the first item is smaller than the date of the last access to the second one.
.P
In other words, the LFU_MRU replacement strategy consists in applying first the LFU, then the MRU replacement strategies.
.sp
.P
 ............................................................
.SS \fBCAESAR_LFU_LRP_ORDER_CACHE_1\fP
 \&
.nf
\fBCAESAR_TYPE_INTEGER CAESAR_LFU_LRP_ORDER_CACHE_1 (CAESAR_C, CAESAR_B1, CAESAR_B2)
   CAESAR_TYPE_CACHE_1 CAESAR_C;
   CAESAR_TYPE_POINTER CAESAR_B1;
   CAESAR_TYPE_POINTER CAESAR_B2;
   { ... }
\fP
.fi
This function returns an integer number which is smaller than, equal to, or greater than 0 depending whether the item pointed to by \fBCAESAR_B1\fP is smaller than, equal to, or greater than the item pointed to by \fBCAESAR_B2\fP according to the order relation underlying the ``least frequently used, then least recently put'' (LFU_LRP) replacement strategy.
.sp
According to this order relation:
.IP -
an item is smaller than another item if the number of hits at the first item is smaller than the number of hits at the second one, or the number of hits is the same for both items but the date when the first item was put into the cache is smaller than the date when the second one was put into the cache;
.IP -
an item is equal to another one if the number of hits and the date when they were put into the cache are the same for both items;
.IP -
an item is greater than another item if the number of hits at the first item is greater than the number of hits at the second one, or the number of hits is the same for both items but the date when the first item was put into the cache is greater than the date when the second one was put into the cache.
.P
In other words, the LFU_LRP replacement strategy consists in applying first the LFU, then the LRP replacement strategies.
.sp
.P
 ............................................................
.SS \fBCAESAR_LFU_MRP_ORDER_CACHE_1\fP
 \&
.nf
\fBCAESAR_TYPE_INTEGER CAESAR_LFU_MRP_ORDER_CACHE_1 (CAESAR_C, CAESAR_B1, CAESAR_B2)
   CAESAR_TYPE_CACHE_1 CAESAR_C;
   CAESAR_TYPE_POINTER CAESAR_B1;
   CAESAR_TYPE_POINTER CAESAR_B2;
   { ... }
\fP
.fi
This function returns an integer number which is smaller than, equal to, or greater than 0 depending whether the item pointed to by \fBCAESAR_B1\fP is smaller than, equal to, or greater than the item pointed to by \fBCAESAR_B2\fP according to the order relation underlying the ``least frequently used, then most recently put'' (LFU_MRP) replacement strategy.
.sp
According to this order relation:
.IP -
an item is smaller than another item if the number of hits at the first item is smaller than the number of hits at the second one, or the number of hits is the same for both items but the date when the first item was put into the cache is greater than the date when the second one was put into the cache;
.IP -
an item is equal to another one if the number of hits and the date when they were put into the cache are the same for both items;
.IP -
an item is greater than another item if the number of hits at the first item is greater than the number of hits at the second one, or the number of hits is the same for both items but the date when the first item was put into the cache is smaller than the date when the second one was put into the cache.
.P
In other words, the LFU_MRP replacement strategy consists in applying first the LFU, then the MRP replacement strategies.
.sp
.P
 ............................................................
.SS \fBCAESAR_MFU_LRU_ORDER_CACHE_1\fP
 \&
.nf
\fBCAESAR_TYPE_INTEGER CAESAR_MFU_LRU_ORDER_CACHE_1 (CAESAR_C, CAESAR_B1, CAESAR_B2)
   CAESAR_TYPE_CACHE_1 CAESAR_C;
   CAESAR_TYPE_POINTER CAESAR_B1;
   CAESAR_TYPE_POINTER CAESAR_B2;
   { ... }
\fP
.fi
This function returns an integer number which is smaller than, equal to, or greater than 0 depending whether the item pointed to by \fBCAESAR_B1\fP is smaller than, equal to, or greater than the item pointed to by \fBCAESAR_B2\fP according to the order relation underlying the ``most frequently used, then least recently used'' (MFU_LRU) replacement strategy.
.sp
According to this order relation:
.IP -
an item is smaller than another item if the number of hits at the first item is greater than the number of hits at the second one, or the number of hits is the same for both items but the date of the last access to the first item is smaller than the date of the last access to the second one;
.IP -
an item is equal to another one if the number of hits and the date of the last access are the same for both items;
.IP -
an item is greater than another item if the number of hits at the first item is smaller than the number of hits at the second one, or the number of hits is the same for both items but the date of the last access to the first item is greater than the date of the last access to the second one.
.P
In other words, the MFU_LRU replacement strategy consists in applying first the MFU, then the LRU replacement strategies.
.sp
.P
 ............................................................
.SS \fBCAESAR_MFU_MRU_ORDER_CACHE_1\fP
 \&
.nf
\fBCAESAR_TYPE_INTEGER CAESAR_MFU_MRU_ORDER_CACHE_1 (CAESAR_C, CAESAR_B1, CAESAR_B2)
   CAESAR_TYPE_CACHE_1 CAESAR_C;
   CAESAR_TYPE_POINTER CAESAR_B1;
   CAESAR_TYPE_POINTER CAESAR_B2;
   { ... }
\fP
.fi
This function returns an integer number which is smaller than, equal to, or greater than 0 depending whether the item pointed to by \fBCAESAR_B1\fP is smaller than, equal to, or greater than the item pointed to by \fBCAESAR_B2\fP according to the order relation underlying the ``most frequently used, then most recently used'' (MFU_MRU) replacement strategy.
.sp
According to this order relation:
.IP -
an item is smaller than another item if the number of hits at the first item is greater than the number of hits at the second one, or the number of hits is the same for both items but the date of the last access to the first item is greater than the date of the last access to the second one;
.IP -
an item is equal to another one if the number of hits and the date of the last access are the same for both items;
.IP -
an item is greater than another item if the number of hits at the first item is smaller than the number of hits at the second one, or the number of hits is the same for both items but the date of the last access to the first item is smaller than the date of the last access to the second one.
.P
In other words, the MFU_MRU replacement strategy consists in applying first the MFU, then the MRU replacement strategies.
.sp
.P
 ............................................................
.SS \fBCAESAR_MFU_LRP_ORDER_CACHE_1\fP
 \&
.nf
\fBCAESAR_TYPE_INTEGER CAESAR_MFU_LRP_ORDER_CACHE_1 (CAESAR_C, CAESAR_B1, CAESAR_B2)
   CAESAR_TYPE_CACHE_1 CAESAR_C;
   CAESAR_TYPE_POINTER CAESAR_B1;
   CAESAR_TYPE_POINTER CAESAR_B2;
   { ... }
\fP
.fi
This function returns an integer number which is smaller than, equal to, or greater than 0 depending whether the item pointed to by \fBCAESAR_B1\fP is smaller than, equal to, or greater than the item pointed to by \fBCAESAR_B2\fP according to the order relation underlying the ``most frequently used, then least recently put'' (MFU_LRP) replacement strategy.
.sp
According to this order relation:
.IP -
an item is smaller than another item if the number of hits at the first item is greater than the number of hits at the second one, or the number of hits is the same for both items but the date when the first item was put into the cache is smaller than the date when the second one was put into the cache;
.IP -
an item is equal to another one if the number of hits and the date when they were put into the cache are the same for both items;
.IP -
an item is greater than another item if the number of hits at the first item is smaller than the number of hits at the second one, or the number of hits is the same for both items but the date when the first item was put into the cache is greater than the date when the second one was put into the cache.
.P
In other words, the MFU_LRP replacement strategy consists in applying first the MFU, then the LRP replacement strategies.
.sp
.P
 ............................................................
.SS \fBCAESAR_MFU_MRP_ORDER_CACHE_1\fP
 \&
.nf
\fBCAESAR_TYPE_INTEGER CAESAR_MFU_MRP_ORDER_CACHE_1 (CAESAR_C, CAESAR_B1, CAESAR_B2)
   CAESAR_TYPE_CACHE_1 CAESAR_C;
   CAESAR_TYPE_POINTER CAESAR_B1;
   CAESAR_TYPE_POINTER CAESAR_B2;
   { ... }
\fP
.fi
This function returns an integer number which is smaller than, equal to, or greater than 0 depending whether the item pointed to by \fBCAESAR_B1\fP is smaller than, equal to, or greater than the item pointed to by \fBCAESAR_B2\fP according to the order relation underlying the ``most frequently used, then most recently put'' (MFU_MRP) replacement strategy.
.sp
According to this order relation:
.IP -
an item is smaller than another item if the number of hits at the first item is greater than the number of hits at the second one, or the number of hits is the same for both items but the date when the first item was put into the cache is greater than the date when the second one was put into the cache;
.IP -
an item is equal to another one if the number of hits and the date when they were put into the cache are the same for both items;
.IP -
an item is greater than another item if the number of hits at the first item is smaller than the number of hits at the second one, or the number of hits is the same for both items but the date when the first item was put into the cache is smaller than the date when the second one was put into the cache.
.P
In other words, the MFU_MRP replacement strategy consists in applying first the MFU, then the MRP replacement strategies.
.sp
.P
 ............................................................
.SS \fBCAESAR_SEED_RND_CACHE_1\fP
 \&
.nf
\fBvoid CAESAR_SEED_RND_CACHE_1 (CAESAR_C, CAESAR_SEED)
   CAESAR_TYPE_CACHE_1 CAESAR_C;
   CAESAR_TYPE_NATURAL CAESAR_SEED;
   { ... }
\fP
.fi
This procedure initializes the seed for the random number generator associated to the cache pointed to by \fBCAESAR_C\fP with the value of \fBCAESAR_SEED\fP. The seed is used for computing the random costs associated to the items contained in the subcaches of the cache that are equipped with the RND replacement strategy.
.sp
Note: The value of the seed associated to a cache is set by default to 0 when the cache is created by invoking the procedure \fBCAESAR_CREATE_CACHE_1()\fP (see below).
.sp
.P
 ............................................................
.SS \fBCAESAR_CREATE_CACHE_1\fP
 \&
.nf
\fBvoid CAESAR_CREATE_CACHE_1 (CAESAR_C,
                            CAESAR_NUMBER_OF_SUBCACHES,
                            CAESAR_LIMIT_SIZE,
                            CAESAR_SUBCACHE_SIZE,
                            CAESAR_SUBCACHE_PERCENTAGE,
                            CAESAR_SUBCACHE_ORDER,
                            CAESAR_SUBCACHE_CHILD,
                            CAESAR_BASE_AREA,
                            CAESAR_MARK_AREA,
                            CAESAR_HASH_SIZE,
                            CAESAR_PRIME,
                            CAESAR_COMPARE,
                            CAESAR_HASH,
                            CAESAR_PRINT,
                            CAESAR_CLEANUP,
                            CAESAR_INFO)
   CAESAR_TYPE_CACHE_1 *CAESAR_C;
   CAESAR_TYPE_NATURAL CAESAR_NUMBER_OF_SUBCACHES;
   CAESAR_TYPE_NATURAL CAESAR_LIMIT_SIZE;
   CAESAR_TYPE_NATURAL_FUNCTION_CACHE_1 CAESAR_SUBCACHE_SIZE;
   CAESAR_TYPE_NATURAL_FUNCTION_CACHE_1 CAESAR_SUBCACHE_PERCENTAGE;
   CAESAR_TYPE_ORDER_FUNCTION_CACHE_1 (*CAESAR_SUBCACHE_ORDER)
      (CAESAR_TYPE_NATURAL);
   CAESAR_TYPE_SUBCACHE_FUNCTION_CACHE_1 (*CAESAR_SUBCACHE_CHILD)
      (CAESAR_TYPE_NATURAL);
   CAESAR_TYPE_AREA_1 CAESAR_BASE_AREA;
   CAESAR_TYPE_AREA_1 CAESAR_MARK_AREA;
   CAESAR_TYPE_NATURAL CAESAR_HASH_SIZE;
   CAESAR_PROMOTE_TO_INT (CAESAR_TYPE_BOOLEAN) CAESAR_PRIME;
   CAESAR_TYPE_COMPARE_FUNCTION CAESAR_COMPARE;
   CAESAR_TYPE_HASH_FUNCTION CAESAR_HASH;
   CAESAR_TYPE_PRINT_FUNCTION CAESAR_PRINT;
   CAESAR_TYPE_CLEANUP_FUNCTION_CACHE_1 CAESAR_CLEANUP;
   CAESAR_TYPE_POINTER CAESAR_INFO;
   { ... }
\fP
.fi
This procedure allocates a cache using \fBCAESAR_CREATE()\fP and assigns its address to \fB*CAESAR_C\fP. If the allocation fails, the \fBNULL\fP value is assigned to \fB*CAESAR_C\fP.
.sp
Note: Because \fBCAESAR_TYPE_CACHE_1\fP is a pointer type, any variable \fBCAESAR_C\fP of type \fBCAESAR_TYPE_CACHE_1\fP must be allocated before used, for instance using:
.TS
center;
l.
 
 \fBCAESAR_CREATE_CACHE_1 (&CAESAR_C, ...);\fP 
 
.TE
.sp
The value of \fBCAESAR_NUMBER_OF_SUBCACHES\fP determines the number of subcaches contained in the cache. Each subcache will be assigned an unique index in the range 0..\fBCAESAR_NUMBER_OF_SUBCACHES\fP - 1. If the value of \fBCAESAR_NUMBER_OF_SUBCACHES\fP is zero or greater than P, the effect is undefined.
.sp
The value of \fBCAESAR_LIMIT_SIZE\fP determines the maximal number of items that can be stored in the cache. It must be less or equal to M. If it is equal to zero, it is replaced by the default value M.
.sp
Note: in order to spare memory, the value of \fBCAESAR_LIMIT_SIZE\fP (which is an upper bound on the number of items to be inserted in the cache) should be as small as possible. This can only be done if the user has some knowledge about the way the cache will be used.
.sp
The actual value of the formal parameter \fBCAESAR_SUBCACHE_SIZE\fP will be stored and associated to the cache pointed to by \fB*CAESAR_C\fP. It will be used to assign to each subcache its corresponding size, i.e., the maximal number of items the subcache can contain.
.sp
Precisely, the actual value of \fBCAESAR_SUBCACHE_SIZE\fP should be a pointer to a function with a parameter \fBcaesar_index\fP that returns the size of the subcache of index \fBcaesar_index\fP, where \fBcaesar_index\fP is in the range 0..\fBCAESAR_NUMBER_OF_SUBCACHES\fP - 1. If the value returned by \fBCAESAR_SUBCACHE_SIZE\fP for some index \fBcaesar_index\fP is greater than zero, then the size of the subcache of index \fBcaesar_index\fP is set to this value. If the value returned is zero, the size of the subcache of index \fBcaesar_index\fP is unspecified and will be determined by the percentage returned by the \fBCAESAR_SUBCACHE_PERCENTAGE\fP parameter (see below). The sum of the sizes returned by \fBCAESAR_SUBCACHE_SIZE\fP for all subcaches, noted L, must be less or equal to \fBCAESAR_LIMIT_SIZE\fP.
.sp
The actual value of the formal parameter \fBCAESAR_SUBCACHE_PERCENTAGE\fP will be stored and associated to the cache pointed to by \fB*CAESAR_C\fP. It will be used to assign to each subcache its corresponding percentage, i.e., a natural number in the range 0..100 determining the size of the subcache with respect to the size of the other subcaches.
.sp
Precisely, the actual value of \fBCAESAR_SUBCACHE_PERCENTAGE\fP should be a pointer to a function with a parameter \fBcaesar_index\fP that returns the percentage of the subcache of index \fBcaesar_index\fP, where \fBcaesar_index\fP is in the range 0..\fBCAESAR_NUMBER_OF_SUBCACHES\fP - 1. Several configurations are possible, enabling the setup of subcache sizes in a flexible manner:
.IP -
If the value returned by \fBCAESAR_SUBCACHE_SIZE\fP is greater than zero for all subcaches, then the values returned by \fBCAESAR_SUBCACHE_PERCENTAGE\fP are ignored because all subcache sizes are determined by \fBCAESAR_SUBCACHE_SIZE\fP.
.IP -
If there is some subcache with unspecified size (i.e., for which \fBCAESAR_SUBCACHE_SIZE\fP returns zero), then the size of the cache pointed to by \fB*CAESAR_C\fP is set to \fBCAESAR_LIMIT_SIZE\fP. Let R be the number of subcaches with unspecified size. The sizes of these subcaches are determined based on the percentages returned by \fBCAESAR_SUBCACHE_PERCENTAGE\fP.
Two situations are possible:
.sp
(1) If the value returned by \fBCAESAR_SUBCACHE_PERCENTAGE\fP is zero for all subcaches with unspecified size, then the size of each of these subcaches is set to (\fBCAESAR_LIMIT_SIZE\fP - L) / R.
.sp
(2) If there is some cache with unspecified size for which the value returned by \fBCAESAR_SUBCACHE_PERCENTAGE\fP is greater than zero, then the size of a subcache with percentage F is set to (\fBCAESAR_LIMIT_SIZE\fP - L) * F / 100. All the percentages returned by \fBCAESAR_SUBCACHE_PERCENTAGE\fP for the subcaches with unspecified size must be greater than zero, and the sum of all these percentages must be equal to 100.
.P
The actual value of the formal parameter \fBCAESAR_SUBCACHE_ORDER\fP will be stored and associated to the cache pointed to by \fB*CAESAR_C\fP. It will be used to assign to each subcache a function implementing the order relation underlying the replacement strategy associated to the subcache.
.sp
Precisely, the actual value of \fBCAESAR_SUBCACHE_ORDER\fP should be a pointer to a function with a parameter \fBcaesar_index\fP that returns a function implementing an order relation, where \fBcaesar_index\fP is in the range 0..\fBCAESAR_NUMBER_OF_SUBCACHES\fP - 1. The value returned by \fBCAESAR_SUBCACHE_ORDER\fP should be a pointer to a function with three parameters \fBcaesar_cache\fP, \fBcaesar_base_1\fP, \fBcaesar_base_2\fP. This function returns a value smaller than, equal to, or greater than 0 if the base field pointed to by \fBcaesar_base_1\fP is smaller than, equal to, or greater than the base field pointed to by \fBcaesar_base_2\fP. The items whose base fields are pointed to by \fBcaesar_base_1\fP and \fBcaesar_base_2\fP are supposed to be contained in the cache pointed to by \fBcaesar_cache\fP, which is always set to the value of \fB*CAESAR_C\fP, i.e., a pointer to the cache currently created. Examples of functions that can be returned by \fBCAESAR_SUBCACHE_ORDER\fP are those implementing the order relations underlying the predefined replacement strategies, namely \fBCAESAR_LRU_ORDER_CACHE_1()\fP, \fBCAESAR_MRU_ORDER_CACHE_1()\fP, etc.
.sp
The actual value of the formal parameter \fBCAESAR_SUBCACHE_CHILD\fP will be stored and associated to the cache pointed to by \fB*CAESAR_C\fP. It will be used to assign to each subcache a function implementing the parent relation that defines the child subcaches of that subcache.
.sp
Precisely, the actual value of \fBCAESAR_SUBCACHE_CHILD\fP should be a pointer to a function with a parameter \fBcaesar_index\fP that returns a function implementing a parent relation, where \fBcaesar_index\fP is in the range 0..\fBCAESAR_NUMBER_OF_SUBCACHES\fP - 1. The value returned by \fBCAESAR_SUBCACHE_CHILD\fP should be a pointer to a function with three parameters \fBcaesar_cache\fP, \fBcaesar_index\fP, \fBcaesar_base\fP. The parameter \fBcaesar_cache\fP is always set to the value of \fB*CAESAR_C\fP, i.e., a pointer to the cache currently created. The parameter \fBcaesar_base\fP is a pointer to the last item replaced in the subcache of index \fBcaesar_index\fP when the current put operation performed on the cache pointed to by \fBcaesar_cache\fP entailed a put operation on the subcache of index \fBcaesar_index\fP, which was already full. This function returns, for the subcache of index \fBcaesar_index\fP, the index of its child subcache in which the item pointed to by \fBcaesar_base\fP will be put. If the index returned by this function is greater or equal to \fBCAESAR_NUMBER_OF_SUBCACHES\fP, then the subcache of index \fBcaesar_index\fP is considered to be a leaf subcache, and the last item replaced pointed to by \fBcaesar_base\fP will be temporarily stored in a field of the cache until the next replacement takes place in the cache (see the \fBCAESAR_LAST_ITEM_REPLACED_CACHE_1()\fP procedure below).
.sp
For example, the following function implements a parent relation corresponding to a stream of subcaches, i.e., a hierarchy in which each subcache of index I has a single child subcache of index I+1:
 \&
.nf
\fB   CAESAR_TYPE_NATURAL caesar_child (caesar_cache, caesar_index, caesar_base)
   CAESAR_TYPE_CACHE_1 caesar_cache;
   CAESAR_TYPE_NATURAL caesar_index;
   CAESAR_TYPE_POINTER caesar_base;
   {
      return (caesar_index + 1);
   }
\fP
.fi
This function does not use the \fBcaesar_cache\fP and the \fBcaesar_base\fP parameters. However, general user-defined functions can implement parent relations that may change dynamically depending on the current status of the cache pointed to by \fBcaesar_cache\fP, the current status of its subcache of index \fBcaesar_index\fP and/or the contents of the item pointed to by \fBcaesar_base\fP.
.sp
The value of \fBCAESAR_BASE_AREA\fP determines the (constant) size and (constant) alignment factor of the base field in the cache. In the particular case where base fields are used to store states (resp. labels, strings), one must give the value \fBCAESAR_STATE_AREA_1()\fP (resp. \fBCAESAR_LABEL_AREA_1()\fP, \fBCAESAR_STRING_AREA_1()\fP) to the formal parameter \fBCAESAR_BASE_AREA\fP.
.sp
The value of \fBCAESAR_MARK_AREA\fP determines the (constant) size and (constant) alignment factor of the mark field according to the specifications of the ``area_1'' library. In particular, if \fBCAESAR_MARK_AREA\fP is equal to \fBCAESAR_EMPTY_AREA_1()\fP, there will be no mark field in the cache.
.sp
Each item in the cache will be represented as a byte string of fixed size \fBcaesar_item_size\fP, such that \fBcaesar_item_size\fP is greater or equal to \fBcaesar_base_size\fP + \fBcaesar_mark_size\fP, where \fBcaesar_base_size\fP denotes the size (in bytes) of the base field (i.e., \fBCAESAR_SIZE_AREA_1 (CAESAR_BASE_AREA)\fP) and where \fBcaesar_mark_size\fP denotes the size (in bytes) of the mark field, if any (i.e., \fBCAESAR_SIZE_AREA_1 (CAESAR_MARK_AREA)\fP).
.sp
An item in the cache contains not only the base field and the mark field, but also ``padding'' bytes that may be inserted between the base and mark fields to ensure that these fields are correctly aligned according to \fBCAESAR_ALIGNMENT_AREA_1 (CAESAR_BASE_AREA)\fP and \fBCAESAR_ALIGNMENT_AREA_1 (CAESAR_MARK_AREA)\fP.
.sp
The value of \fBCAESAR_HASH_SIZE\fP determines the number of entries in the hash-table associated to the cache. If it is equal to zero, it is replaced with a default value greater than zero.
.sp
If the value of \fBCAESAR_PRIME\fP is equal to \fBCAESAR_TRUE\fP and if the value of \fBCAESAR_HASH_SIZE\fP is not a prime number, this value will be replaced by the nearest smaller prime number (since some hash functions require prime modulus). Otherwise, the value of \fBCAESAR_HASH_SIZE\fP will be kept unchanged.
.sp
The actual value of the formal parameter \fBCAESAR_COMPARE\fP will be stored and associated to the cache pointed to by \fB*CAESAR_C\fP. It will be used as a comparison function when it is necessary to decide whether two base fields are equal or not.
.sp
Precisely, the actual value of \fBCAESAR_COMPARE\fP should be a pointer to a comparison function with two parameters \fBcaesar_base_1\fP and \fBcaesar_base_2\fP that returns \fBCAESAR_TRUE\fP if the two base fields pointed to by \fBcaesar_base_1\fP and \fBcaesar_base_2\fP are equal.
.sp
If the actual value of the formal parameter \fBCAESAR_COMPARE\fP is \fBNULL\fP, it is replaced by a pointer to a default comparison function that depends on the value of \fBCAESAR_BASE_AREA\fP and is determined according to the rules specified for function \fBCAESAR_USE_COMPARE_FUNCTION_AREA_1()\fP of the ``area_1'' library.
.sp
The actual value of the formal parameter \fBCAESAR_HASH\fP will be stored and associated to the cache pointed to by \fB*CAESAR_C\fP. It will be used as a hash-function when it is necessary to compute a hash-value for searching or inserting an item in the cache.
.sp
Precisely, the actual value of \fBCAESAR_HASH\fP should be a pointer to a hash function with two parameters \fBcaesar_pointer\fP and \fBcaesar_modulus\fP that returns a natural number in the range 0..\fBcaesar_modulus\fP - 1.
.sp
If the actual value of the formal parameter \fBCAESAR_HASH\fP is \fBNULL\fP, it is replaced by a pointer to a default hash function that depends on the value of \fBCAESAR_BASE_AREA\fP and is determined according to the rules specified for function \fBCAESAR_USE_HASH_FUNCTION_AREA_1()\fP of the ``area_1'' library.
.sp
The actual value of the formal parameter \fBCAESAR_PRINT\fP will be stored and associated to the cache pointed to by \fB*CAESAR_C\fP. It will be used subsequently to print the items of this cache.
.sp
Precisely, the actual value of \fBCAESAR_PRINT\fP should be a pointer to a printing procedure with two parameters \fBcaesar_file\fP and \fBcaesar_item\fP that prints to file \fBcaesar_file\fP information about the contents (base field and/or mark field, if any) of the item pointed to by \fBcaesar_item\fP.
.sp
If the actual value of the formal parameter \fBCAESAR_PRINT\fP is \fBNULL\fP, it is replaced by a pointer to a default procedure that prints the base field and the mark field, if any. The printing procedure used for the base field (respectively, the mark field) depends on the value of \fBCAESAR_BASE_AREA\fP (resp. \fBCAESAR_MARK_AREA\fP) and is determined according to the rules specified for function \fBCAESAR_USE_PRINT_FUNCTION_AREA_1()\fP of the ``area_1'' library.
.sp
The actual value of the formal parameter \fBCAESAR_CLEANUP\fP will be stored and associated to the cache pointed to by \fB*CAESAR_C\fP. It will be used subsequently to clean up the contents of the items deleted from this cache.
.sp
Precisely, the actual value of \fBCAESAR_CLEANUP\fP should be a pointer to a procedure with one parameter \fBcaesar_item\fP that cleans up the contents (base field and mark field, if any) of the item pointed to by \fBcaesar_item\fP. This cleanup operation is useful if the base and/or the mark fields (if any) of items contain pointers to dynamic data structures (e.g., lists, sets, etc.) that must be freed when those items are deleted from the cache. For example, if the base field is a list of edges of type \fBCAESAR_TYPE_EDGE\fP that must not be kept in memory when items are deleted from the cache, a good candidate for the \fBCAESAR_CLEANUP\fP parameter is the \fBCAESAR_DELETE_EDGE_LIST()\fP procedure of the ``edge'' library, which deletes the list pointed to by the base field of the item pointed to by \fBcaesar_item\fP, and then sets this base field to \fBNULL\fP.
.sp
If the actual value of the formal parameter \fBCAESAR_CLEANUP\fP is \fBNULL\fP, there will be no cleanup operation performed on the contents of the items when these items are deleted from the cache.
.sp
The actual value of the formal parameter \fBCAESAR_INFO\fP will be stored and associated to the cache pointed to by \fB*CAESAR_C\fP. This value should be a pointer to some data structure containing user-defined information that will be associated to this cache. The value of this pointer remains unchanged during the lifetime of the cache and can be inspected using the \fBCAESAR_INFO_CACHE_1()\fP function (see below).
.sp
.P
 ............................................................
.SS \fBCAESAR_CURRENT_CACHE_1\fP
 \&
.nf
\fBCAESAR_TYPE_CACHE_1 CAESAR_CURRENT_CACHE_1 ()
   { ... }
\fP
.fi
This function returns a pointer to the cache which is currently in use. It should be called only within the functions and procedures given as actual values for the formal parameters \fBCAESAR_SUBCACHE_SIZE\fP, \fBCAESAR_SUBCACHE_PERCENTAGE\fP, \fBCAESAR_COMPARE\fP, \fBCAESAR_HASH\fP, \fBCAESAR_PRINT\fP, and \fBCAESAR_CLEANUP\fP of procedure \fBCAESAR_CREATE_CACHE_1()\fP (see above); in this case, the result is a pointer to the cache created by the call to \fBCAESAR_CREATE_CACHE_1()\fP. If this function is called anywhere else in the application program, the result is undefined.
.sp
Note: This function allows to identify the cache to which the items passed as arguments to the six aforementioned functions and procedures belong, and thus to handle these items accordingly (the size and the contents of items belonging to different caches may differ). It is especially useful when the number of caches is unknown statically (e.g., when new caches are created dynamically during the execution of the application program).
.sp
.P
 ............................................................
.SS \fBCAESAR_CURRENT_SUBCACHE_CACHE_1\fP
 \&
.nf
\fBCAESAR_TYPE_NATURAL CAESAR_CURRENT_SUBCACHE_CACHE_1 ()
   { ... }
\fP
.fi
This function returns the index of the subcache which is currently in use; this subcache is in turn contained in the cache which is currently in use, pointed to by the result of function \fBCAESAR_CURRENT_CACHE_1()\fP (see above). It should be called only within the functions and procedures given as actual values for the formal parameters \fBCAESAR_SUBCACHE_ORDER\fP, \fBCAESAR_COMPARE\fP, \fBCAESAR_HASH\fP, \fBCAESAR_PRINT\fP, and \fBCAESAR_CLEANUP\fP of procedure \fBCAESAR_CREATE_CACHE_1()\fP (see above); in this case, the result is the index of the subcache, i.e., a natural number in the range 0..N-1, where N is the number of subcaches in the cache created by the call to \fBCAESAR_CREATE_CACHE_1()\fP. If this function is called anywhere else in the application program, the result is undefined.
.sp
Note: This function allows to identify the subcache to which the items passed as arguments to the five aforementioned functions and procedures belong, and thus to handle these items accordingly.
.sp
.P
 ............................................................
.SS \fBCAESAR_DELETE_CACHE_1\fP
 \&
.nf
\fBvoid CAESAR_DELETE_CACHE_1 (CAESAR_C)
   CAESAR_TYPE_CACHE_1 *CAESAR_C;
   { ... }
\fP
.fi
This procedure frees the memory space corresponding to the cache pointed to by \fB*CAESAR_C\fP using \fBCAESAR_DELETE()\fP. All the items currently present in the cache are freed by invoking first the cleanup function (if any) associated to the cache, and then \fBCAESAR_DELETE()\fP. Afterwards, the \fBNULL\fP value is assigned to \fB*CAESAR_C\fP.
.sp
.P
 ............................................................
.SS \fBCAESAR_PURGE_SUBCACHE_CACHE_1\fP
 \&
.nf
\fBvoid CAESAR_PURGE_SUBCACHE_CACHE_1 (CAESAR_C, CAESAR_N)
   CAESAR_TYPE_CACHE_1 CAESAR_C;
   CAESAR_TYPE_NATURAL CAESAR_N;
   { ... }
\fP
.fi
This procedure reinitializes the information associated to the subcache of index \fBCAESAR_N\fP of the cache pointed to by \fBCAESAR_C\fP. All the items currently present in the subcache are freed by invoking first the cleanup function (if any) associated to the cache, and then \fBCAESAR_DELETE()\fP. Afterwards, the subcache is exactly in the same state as after the creation of the cache using \fBCAESAR_CREATE_CACHE_1()\fP.
.sp
If the subcache index \fBCAESAR_N\fP is outside the range 0..N-1 (where N is the number of subcaches in the cache), the effect is undefined.
.sp
.P
 ............................................................
.SS \fBCAESAR_PURGE_CACHE_1\fP
 \&
.nf
\fBvoid CAESAR_PURGE_CACHE_1 (CAESAR_C)
   CAESAR_TYPE_CACHE_1 CAESAR_C;
   { ... }
\fP
.fi
This procedure reinitializes the information associated to the cache pointed to by \fBCAESAR_C\fP. All the items currently present in the cache are freed by invoking first the cleanup function (if any) associated to the cache, and then \fBCAESAR_DELETE()\fP. Afterwards, the cache is exactly in the same state as after its creation using \fBCAESAR_CREATE_CACHE_1()\fP.
.sp
.P
 ............................................................
.SS \fBCAESAR_SEARCH_CACHE_1\fP
 \&
.nf
\fBCAESAR_TYPE_BOOLEAN CAESAR_SEARCH_CACHE_1 (CAESAR_C, CAESAR_B, CAESAR_N, CAESAR_P)
   CAESAR_TYPE_CACHE_1 CAESAR_C;
   CAESAR_TYPE_POINTER CAESAR_B;
   CAESAR_TYPE_NATURAL *CAESAR_N;
   CAESAR_TYPE_POINTER *CAESAR_P;
   { ... }
\fP
.fi
This function determines if there exists, in the cache pointed to by \fBCAESAR_C\fP, an item whose base field is equal to the byte string pointed to by \fBCAESAR_B\fP. Byte string comparisons are performed using the comparison function associated to the cache. The search is done using the hash-function and hash-table associated to the cache.
.sp
If so, this function returns \fBCAESAR_TRUE\fP. In this case, the index of the subcache containing the existing item and the address of the item are respectively assigned to \fB*CAESAR_N\fP and \fB*CAESAR_P\fP. The number of searches and hits at the cache and the current global date of the cache are incremented. The number of hits at the subcache is incremented and the current local date of the subcache is set to the current global date of the cache. The number of hits at the item is also incremented and the date of the last access to the item is set to the current global date of the cache (the item becomes the most recently accessed item in the cache).
.sp
If not, this function returns \fBCAESAR_FALSE\fP. In this case, both variables \fB*CAESAR_N\fP and \fB*CAESAR_P\fP are left unchanged. The number of searches in the cache is incremented. The number of hits at the cache and the current global date of the cache are left unchanged.
.sp
.P
 ............................................................
.SS \fBCAESAR_PUT_BASE_CACHE_1\fP
 \&
.nf
\fBCAESAR_TYPE_POINTER CAESAR_PUT_BASE_CACHE_1 (CAESAR_C)
   CAESAR_TYPE_CACHE_1 CAESAR_C;
   { ... }
\fP
.fi
This function returns a pointer to the base field of the next item to be put into the cache pointed to by \fBCAESAR_C\fP.
.sp
The base field pointed to by the result of \fBCAESAR_PUT_BASE_CACHE_1()\fP is initially undefined and must be assigned before calling some other functions of the ``cache_1'' library (see below).
.P
 ............................................................
.SS \fBCAESAR_PUT_MARK_CACHE_1\fP
 \&
.nf
\fBCAESAR_TYPE_POINTER CAESAR_PUT_MARK_CACHE_1 (CAESAR_C)
   CAESAR_TYPE_CACHE_1 CAESAR_C;
   { ... }
\fP
.fi
This function returns a pointer to the mark field of the next item to be put into the cache pointed to by \fBCAESAR_C\fP. If there are no mark fields in the cache (due to the initialization parameters supplied to \fBCAESAR_CREATE_CACHE_1()\fP) the result is undefined.
.sp
The mark field pointed to by the result of \fBCAESAR_PUT_MARK_CACHE_1()\fP is always initialized to a bit string of 0's. It can be either consulted or modified.
.sp
.P
 ............................................................
.SS \fBCAESAR_PUT_CACHE_1\fP
 \&
.nf
\fBvoid CAESAR_PUT_CACHE_1 (CAESAR_C)
   CAESAR_TYPE_CACHE_1 CAESAR_C;
   { ... }
\fP
.fi
This procedure puts into the cache pointed to by \fBCAESAR_C\fP the item whose base field is pointed to by \fBCAESAR_PUT_BASE_CACHE_1 (CAESAR_C)\fP and whose mark field (if any) is pointed to by \fBCAESAR_PUT_MARK_CACHE_1 (CAESAR_C)\fP.
.sp
The base field must have been assigned before this procedure is called.
.sp
This procedure also sets a field of type \fBCAESAR_TYPE_ERROR_CACHE_1\fP associated to the cache, indicating whether the put operation was carried out successfully or not; this field can be inspected using the function \fBCAESAR_STATUS_PUT_CACHE_1()\fP (see below).
.sp
The hash-table associated to the cache is updated to take into account the new item. To compute the hash-value for the base field, the hash-function associated to the cache is used.
.sp
If the put operation causes another item E contained in (some leaf subcache of) the cache to be replaced, this item is stored temporarily in a field associated to the cache until a future call to \fBCAESAR_PUT_CACHE_1()\fP or \fBCAESAR_SEARCH_AND_PUT_CACHE_1()\fP will cause another replacement to take place. Meanwhile, the item E can be inspected by using the \fBCAESAR_LAST_ITEM_REPLACED_CACHE_1()\fP procedure (see below). When the next replacement takes place, if the item E has not been inspected meanwhile by a call to \fBCAESAR_LAST_ITEM_REPLACED_CACHE_1()\fP, it will be first cleaned up using the cleanup function (if any) associated to the cache, and then freed using \fBCAESAR_DELETE()\fP; otherwise, the item E will not be cleaned up (because it is the user's responsibility to manage the memory possibly referenced in the contents of this item), but freed using \fBCAESAR_DELETE()\fP only.
.sp
Note: the cache is implemented in such a way that if a memory shortage occurs during a put operation when the cache is not already full, all the subcaches are considered to become full and their associated replacement strategies start to be used.
.sp
.P
 ............................................................
.SS \fBCAESAR_SEARCH_AND_PUT_CACHE_1\fP
 \&
.nf
\fBCAESAR_TYPE_BOOLEAN CAESAR_SEARCH_AND_PUT_CACHE_1 (CAESAR_C, CAESAR_N, CAESAR_P)
   CAESAR_TYPE_CACHE_1 CAESAR_C;
   CAESAR_TYPE_NATURAL *CAESAR_N;
   CAESAR_TYPE_POINTER *CAESAR_P;
   { ... }
\fP
.fi
This function is a combination of the function \fBCAESAR_SEARCH_CACHE_1()\fP and the procedure \fBCAESAR_PUT_CACHE_1()\fP defined above.
.sp
The base field pointed to by \fBCAESAR_PUT_BASE_CACHE_1 (CAESAR_C)\fP must have been assigned before this function is called.
.sp
It first determines if there exists, in the cache pointed to by \fBCAESAR_C\fP, an item whose base field is equal to the base field of the item pointed to by \fBCAESAR_PUT_BASE_CACHE_1 (CAESAR_C)\fP. Byte string comparisons are performed using the comparison function associated to the cache. The search is done using the hash-function and hash-table associated to the cache.
.sp
If so, this function returns \fBCAESAR_TRUE\fP. In this case, the index of the subcache containing the existing item and the address of the item are respectively assigned to \fB*CAESAR_N\fP and \fB*CAESAR_P\fP. The number of searches and hits at the cache and the current global date of the cache are incremented. The number of hits at the subcache is incremented and the current local date of the subcache is set to the current global date of the cache. The number of hits at the item is also incremented and the date of the last access to the item is set to the current global date of the cache (the item becomes the most recently accessed item in the cache). The field of type \fBCAESAR_TYPE_ERROR_CACHE_1\fP associated to the cache is set to \fBCAESAR_NONE_CACHE_1\fP.
.sp
If not, this function returns \fBCAESAR_FALSE\fP. In this case, it puts into the cache pointed to by \fBCAESAR_C\fP the item whose base field is pointed to by \fBCAESAR_PUT_BASE_CACHE_1 (CAESAR_C)\fP and whose mark field (if any) is pointed to by \fBCAESAR_PUT_MARK_CACHE_1 (CAESAR_C)\fP. The hash-table associated to the cache is updated to take into account the new item. The number of searches in the cache and the current global date of the cache are incremented.
.sp
The field of type \fBCAESAR_TYPE_ERROR_CACHE_1\fP associated to the cache is set to indicate whether the put operation was carried out successfully or not. If the put operation succeeded, variable \fB*CAESAR_N\fP is assigned the value 0 (since the item was put into the root subcache, of index 0) and variable \fB*CAESAR_P\fP is assigned the address of the item, which is now contained in the cache. If the put operation failed (because a cycle was detected in the parent relation between subcaches), the variables \fB*CAESAR_N\fP and \fB*CAESAR_P\fP are left unchanged.
.sp
If the put operation causes another item E contained in (some leaf subcache of) the cache to be replaced, this item is stored temporarily in a field associated to the cache until a future call to \fBCAESAR_PUT_CACHE_1()\fP or \fBCAESAR_SEARCH_AND_PUT_CACHE_1()\fP will cause another replacement to take place. Meanwhile, the item E can be inspected by using the \fBCAESAR_LAST_ITEM_REPLACED_CACHE_1()\fP procedure (see below). When the next replacement takes place, if the item E has not been inspected meanwhile by a call to \fBCAESAR_LAST_ITEM_REPLACED_CACHE_1()\fP, it will be first cleaned up using the cleanup function (if any) associated to the cache, and then freed using \fBCAESAR_DELETE()\fP; otherwise, the item E will not be cleaned up (because it is the user's responsibility to manage the memory possibly referenced in the contents of this item), but freed using \fBCAESAR_DELETE()\fP only.
.sp
Note: the cache is implemented in such a way that if a memory shortage occurs during a put operation when the cache is not already full, all the subcaches are considered to become full and their associated replacement strategies start to be used.
.sp
.P
 ............................................................
.SS \fBCAESAR_STATUS_PUT_CACHE_1\fP
 \&
.nf
\fBCAESAR_TYPE_ERROR_CACHE_1 CAESAR_STATUS_PUT_CACHE_1 (CAESAR_C)
   CAESAR_TYPE_CACHE_1 CAESAR_C;
   { ... }
\fP
.fi
This function returns the status of the last put operation performed by a call to the procedure \fBCAESAR_PUT_CACHE_1()\fP or to the function \fBCAESAR_SEARCH_AND_PUT_CACHE_1()\fP (see above) on the cache pointed to by \fBCAESAR_C\fP.
.sp
.P
 ............................................................
.SS \fBCAESAR_MINIMAL_ITEM_CACHE_1\fP
 \&
.nf
\fBCAESAR_TYPE_POINTER CAESAR_MINIMAL_ITEM_CACHE_1 (CAESAR_C, CAESAR_N)
   CAESAR_TYPE_CACHE_1 CAESAR_C;
   CAESAR_TYPE_NATURAL CAESAR_N;
   { ... }
\fP
.fi
This function returns the address of the smallest item contained in the subcache of index \fBCAESAR_N\fP of the cache pointed to by \fBCAESAR_C\fP. The smallest item is determined according to the order relation underlying the replacement strategy of the subcache of index \fBCAESAR_N\fP.
.sp
If the index \fBCAESAR_N\fP is outside the range 0..N-1 (where N is the number of subcaches in the cache) or the subcache of index \fBCAESAR_N\fP is empty, the result is undefined.
.sp
.P
 ............................................................
.SS \fBCAESAR_DELETE_ITEM_CACHE_1\fP
 \&
.nf
\fBvoid CAESAR_DELETE_ITEM_CACHE_1 (CAESAR_C, CAESAR_N, CAESAR_B)
   CAESAR_TYPE_CACHE_1 CAESAR_C;
   CAESAR_TYPE_NATURAL CAESAR_N;
   CAESAR_TYPE_POINTER *CAESAR_B;
   { ... }
\fP
.fi
This procedure deletes, for the subcache of index \fBCAESAR_N\fP of the cache pointed to by \fBCAESAR_C\fP, the item whose base field is pointed to by \fB*CAESAR_B\fP. The item is freed by invoking first the cleanup function (if any) associated to the cache, and then \fBCAESAR_DELETE()\fP. Afterwards, the \fBNULL\fP value is assigned to \fB*CAESAR_B\fP.
.sp
The number of items in the subcache of index \fBCAESAR_N\fP and in the cache is decremented. The current global date of the cache is incremented and the current local date of the subcache of index \fBCAESAR_N\fP is set to the current global date of the cache.
.sp
If no item stored in the subcache of index \fBCAESAR_N\fP of the cache has a base field at address \fBCAESAR_B\fP, the effect is undefined.
.sp
If the index \fBCAESAR_N\fP is outside the range 0..N-1 (where N is the number of subcaches in the cache) or the subcache of index \fBCAESAR_N\fP is empty, the effect is undefined.
.sp
.P
 ............................................................
.SS \fBCAESAR_LAST_ITEM_REPLACED_CACHE_1\fP
 \&
.nf
\fBvoid CAESAR_LAST_ITEM_REPLACED_CACHE_1 (CAESAR_C, CAESAR_N, CAESAR_B)
   CAESAR_TYPE_CACHE_1 CAESAR_C;
   CAESAR_TYPE_NATURAL *CAESAR_N;
   CAESAR_TYPE_POINTER *CAESAR_B;
   { ... }
\fP
.fi
This procedure respectively assigns to the variables \fB*CAESAR_N\fP and \fB*CAESAR_B\fP the index of the subcache and the address of the item that was replaced in that subcache when the last call to \fBCAESAR_PUT_CACHE_1()\fP or to \fBCAESAR_SEARCH_AND_PUT_CACHE_1()\fP was performed on the cache pointed to by \fBCAESAR_C\fP and caused a replacement to take place.
.sp
This procedure also sets an internal field of the cache indicating that the last item replaced was inspected, and from now on it is the user's responsibility to manage the memory possibly referenced in the contents of the item pointed to by \fB*CAESAR_B\fP. Thus, when some future call to \fBCAESAR_PUT_CACHE_1()\fP or to \fBCAESAR_SEARCH_AND_PUT_CACHE_1()\fP on the cache will cause another item to be replaced, the item pointed to by \fB*CAESAR_B\fP will not be cleaned up by invoking the cleanup function (if any) associated to the cache, but its contents will be freed by invoking \fBCAESAR_DELETE()\fP only.
.sp
If none of the previous calls to \fBCAESAR_PUT_CACHE_1()\fP or to \fBCAESAR_SEARCH_AND_PUT_CACHE_1()\fP caused a replacement to take place, then the values N (where N is the number of subcaches in the cache) and \fBNULL\fP are respectively assigned to the variables \fB*CAESAR_N\fP and \fB*CAESAR_B\fP.
.sp
Note: The item pointed to by \fB*CAESAR_B\fP can be handled in the same way as an ordinary item present in the cache, e.g., the address of its mark field can be retrieved using the \fBCAESAR_RETRIEVE_B_M_CACHE_1()\fP procedure.
.sp
.P
 ............................................................
.SS \fBCAESAR_UPDATE_CACHE_1\fP
 \&
.nf
\fBvoid CAESAR_UPDATE_CACHE_1 (CAESAR_C, CAESAR_N, CAESAR_B)
   CAESAR_TYPE_CACHE_1 CAESAR_C;
   CAESAR_TYPE_NATURAL CAESAR_N;
   CAESAR_TYPE_POINTER CAESAR_B;
   { ... }
\fP
.fi
This procedure simulates, for the subcache of index \fBCAESAR_N\fP of the cache pointed to by \fBCAESAR_C\fP, a hit at the item whose base field is pointed to by \fBCAESAR_B\fP.
.sp
The current global date of the cache is incremented and the current local date of the subcache of index \fBCAESAR_N\fP is set to the current global date of the cache. The date of the last access to the item pointed to by \fBCAESAR_B\fP is set to the current global date of the cache (the item becomes the most recently accessed item in the cache). The number of hits at the item is incremented. Finally, the subcache is updated depending whether the item has become smaller or greater according to the order relation underlying the replacement strategy associated to the subcache.
.sp
If no item stored in the subcache of index \fBCAESAR_N\fP of the cache has a base field at address \fBCAESAR_B\fP, the effect is undefined.
.sp
If the subcache index \fBCAESAR_N\fP is outside the range 0..N-1 (where N is the number of subcaches in the cache), the effect is undefined.
.sp
Note: If the items of the cache contain mark fields, and if the subcache is equipped with a user-defined replacement strategy whose underlying order relation depends on the contents of mark fields, this procedure should be called after any modification of the mark field of an item of the subcache in order to bring the subcache to a consistent state.
.sp
.P
 ............................................................
.SS \fBCAESAR_CURRENT_DATE_SUBCACHE_CACHE_1\fP
 \&
.nf
\fBCAESAR_TYPE_NATURAL CAESAR_CURRENT_DATE_SUBCACHE_CACHE_1 (CAESAR_C, CAESAR_N)
   CAESAR_TYPE_CACHE_1 CAESAR_C;
   CAESAR_TYPE_NATURAL CAESAR_N;
   { ... }
\fP
.fi
This function returns the date of the last modifying operation performed on an item present in the subcache of index \fBCAESAR_N\fP of the cache pointed to by \fBCAESAR_C\fP.
.sp
If the subcache index \fBCAESAR_N\fP is outside the range 0..N-1 (where N is the number of subcaches in the cache), the result is undefined.
.sp
.P
 ............................................................
.SS \fBCAESAR_CURRENT_DATE_CACHE_1\fP
 \&
.nf
\fBCAESAR_TYPE_NATURAL CAESAR_CURRENT_DATE_CACHE_1 (CAESAR_C)
   CAESAR_TYPE_CACHE_1 CAESAR_C;
   { ... }
\fP
.fi
This function returns the current global date of the cache pointed to by \fBCAESAR_C\fP.
.sp
.P
 ............................................................
.SS \fBCAESAR_NUMBER_OF_ITEMS_SUBCACHE_CACHE_1\fP
 \&
.nf
\fBCAESAR_TYPE_NATURAL CAESAR_NUMBER_OF_ITEMS_SUBCACHE_CACHE_1 (CAESAR_C, CAESAR_N)
   CAESAR_TYPE_CACHE_1 CAESAR_C;
   CAESAR_TYPE_NATURAL CAESAR_N;
   { ... }
\fP
.fi
This function returns the number of items currently contained in the subcache of index \fBCAESAR_N\fP of the cache pointed to by \fBCAESAR_C\fP.
.sp
If the subcache index \fBCAESAR_N\fP is outside the range 0..N-1 (where N is the number of subcaches in the cache), the result is undefined.
.sp
.P
 ............................................................
.SS \fBCAESAR_NUMBER_OF_ITEMS_CACHE_1\fP
 \&
.nf
\fBCAESAR_TYPE_NATURAL CAESAR_NUMBER_OF_ITEMS_CACHE_1 (CAESAR_C)
   CAESAR_TYPE_CACHE_1 CAESAR_C;
   { ... }
\fP
.fi
This function returns the number of items currently contained in the cache pointed to by \fBCAESAR_C\fP.
.sp
.P
 ............................................................
.SS \fBCAESAR_NUMBER_OF_SEARCHES_CACHE_1\fP
 \&
.nf
\fBCAESAR_TYPE_NATURAL CAESAR_NUMBER_OF_SEARCHES_CACHE_1 (CAESAR_C)
   CAESAR_TYPE_CACHE_1 CAESAR_C;
   { ... }
\fP
.fi
This function returns the number of search operations performed on the cache pointed to by \fBCAESAR_C\fP.
.sp
.P
 ............................................................
.SS \fBCAESAR_NUMBER_OF_HITS_SUBCACHE_CACHE_1\fP
 \&
.nf
\fBCAESAR_TYPE_NATURAL CAESAR_NUMBER_OF_HITS_SUBCACHE_CACHE_1 (CAESAR_C, CAESAR_N)
   CAESAR_TYPE_CACHE_1 CAESAR_C;
   CAESAR_TYPE_NATURAL CAESAR_N;
   { ... }
\fP
.fi
This function returns the number of hits at the subcache of index \fBCAESAR_N\fP of the cache pointed to by \fBCAESAR_C\fP.
.sp
If the subcache index \fBCAESAR_N\fP is outside the range 0..N-1 (where N is the number of subcaches in the cache), the result is undefined.
.sp
.P
 ............................................................
.SS \fBCAESAR_NUMBER_OF_HITS_CACHE_1\fP
 \&
.nf
\fBCAESAR_TYPE_NATURAL CAESAR_NUMBER_OF_HITS_CACHE_1 (CAESAR_C)
   CAESAR_TYPE_CACHE_1 CAESAR_C;
   { ... }
\fP
.fi
This function returns the number of hits at the cache pointed to by \fBCAESAR_C\fP.
.sp
.P
 ............................................................
.SS \fBCAESAR_ITEM_PUT_DATE_CACHE_1\fP
 \&
.nf
\fBCAESAR_TYPE_NATURAL CAESAR_ITEM_PUT_DATE_CACHE_1 (CAESAR_C, CAESAR_B)
   CAESAR_TYPE_CACHE_1 CAESAR_C;
   CAESAR_TYPE_POINTER CAESAR_B;
   { ... }
\fP
.fi
This function returns the date when the item whose base field is pointed to by \fBCAESAR_B\fP was put into the cache pointed to by \fBCAESAR_C\fP.
.sp
If no item stored in (some subcache of) the cache has a base field at address \fBCAESAR_B\fP, the result is undefined.
.sp
.P
 ............................................................
.SS \fBCAESAR_ITEM_CURRENT_DATE_CACHE_1\fP
 \&
.nf
\fBCAESAR_TYPE_NATURAL CAESAR_ITEM_CURRENT_DATE_CACHE_1 (CAESAR_C, CAESAR_B)
   CAESAR_TYPE_CACHE_1 CAESAR_C;
   CAESAR_TYPE_POINTER CAESAR_B;
   { ... }
\fP
.fi
This function returns, for the cache pointed to by \fBCAESAR_C\fP, the date of the last access to the item whose base field is pointed to by \fBCAESAR_B\fP.
.sp
If no item stored in (some subcache of) the cache has a base field at address \fBCAESAR_B\fP, the result is undefined.
.sp
.P
 ............................................................
.SS \fBCAESAR_ITEM_NUMBER_OF_HITS_CACHE_1\fP
 \&
.nf
\fBCAESAR_TYPE_NATURAL CAESAR_ITEM_NUMBER_OF_HITS_CACHE_1 (CAESAR_C, CAESAR_B)
   CAESAR_TYPE_CACHE_1 CAESAR_C;
   CAESAR_TYPE_POINTER CAESAR_B;
   { ... }
\fP
.fi
This function returns, for the cache pointed to by \fBCAESAR_C\fP, the number of hits at the item whose base field is pointed to by \fBCAESAR_B\fP.
.sp
If no item stored in (some subcache of) the cache has a base field at address \fBCAESAR_B\fP, the result is undefined.
.sp
.P
 ............................................................
.SS \fBCAESAR_EMPTY_SUBCACHE_CACHE_1\fP
 \&
.nf
\fBCAESAR_TYPE_BOOLEAN CAESAR_EMPTY_SUBCACHE_CACHE_1 (CAESAR_C, CAESAR_N)
   CAESAR_TYPE_CACHE_1 CAESAR_C;
   CAESAR_TYPE_NATURAL CAESAR_N;
   { ... }
\fP
.fi
This function returns a value different from 0 if the subcache of index \fBCAESAR_N\fP of the cache pointed to by \fBCAESAR_C\fP is empty, and 0 otherwise. \fBCAESAR_EMPTY_SUBCACHE_CACHE_1 (CAESAR_C, CAESAR_N)\fP is always equivalent to:
.TS
center;
l.
 
 \fBCAESAR_NUMBER_OF_ITEMS_SUBCACHE_CACHE_1 (CAESAR_C, CAESAR_N) == 0\fP 
 
.TE
.sp
If the subcache index \fBCAESAR_N\fP is outside the range 0..N-1 (where N is the number of subcaches in the cache), the result is undefined.
.sp
.P
 ............................................................
.SS \fBCAESAR_EMPTY_CACHE_1\fP
 \&
.nf
\fBCAESAR_TYPE_BOOLEAN CAESAR_EMPTY_CACHE_1 (CAESAR_C)
   CAESAR_TYPE_CACHE_1 CAESAR_C;
   { ... }
\fP
.fi
This function returns a value different from 0 if the cache pointed to by \fBCAESAR_C\fP is empty, and 0 otherwise. \fBCAESAR_EMPTY_CACHE_1 (CAESAR_C)\fP is always equivalent to:
.TS
center;
l.
 
 \fBCAESAR_NUMBER_OF_ITEMS_CACHE_1 (CAESAR_C) == 0\fP 
 
.TE
.sp
.P
 ............................................................
.SS \fBCAESAR_FULL_SUBCACHE_CACHE_1\fP
 \&
.nf
\fBCAESAR_TYPE_BOOLEAN CAESAR_FULL_SUBCACHE_CACHE_1 (CAESAR_C, CAESAR_N)
   CAESAR_TYPE_CACHE_1 CAESAR_C;
   CAESAR_TYPE_NATURAL CAESAR_N;
   { ... }
\fP
.fi
This function returns a value different from 0 if the subcache of index \fBCAESAR_N\fP of the cache pointed to by \fBCAESAR_C\fP is full, and 0 otherwise. \fBCAESAR_FULL_SUBCACHE_CACHE_1 (CAESAR_C, CAESAR_N)\fP is always equivalent to:
.TS
center;
l.
 
 \fBCAESAR_NUMBER_OF_ITEMS_SUBCACHE_CACHE_1 (CAESAR_C, CAESAR_N) == $K$\fP 
 
.TE
where K denotes the maximum number of items that the subcache can contain.
.sp
If the subcache index \fBCAESAR_N\fP is outside the range 0..N-1 (where N is the number of subcaches in the cache), the result is undefined.
.sp
.P
 ............................................................
.SS \fBCAESAR_FULL_CACHE_1\fP
 \&
.nf
\fBCAESAR_TYPE_BOOLEAN CAESAR_FULL_CACHE_1 (CAESAR_C)
   CAESAR_TYPE_CACHE_1 CAESAR_C;
   { ... }
\fP
.fi
This function returns a value different from 0 if the cache pointed to by \fBCAESAR_C\fP is full, and 0 otherwise. \fBCAESAR_FULL_CACHE_1 (CAESAR_C)\fP is always equivalent to:
.TS
center;
l.
 
 \fBCAESAR_NUMBER_OF_ITEMS_CACHE_1 (CAESAR_C) == $K$\fP 
 
.TE
where K denotes the maximum number of items that the cache can contain.
.sp
.P
 ............................................................
.SS \fBCAESAR_INFO_CACHE_1\fP
 \&
.nf
\fBCAESAR_TYPE_POINTER CAESAR_INFO_CACHE_1 (CAESAR_C)
   CAESAR_TYPE_CACHE_1 CAESAR_C;
   { ... }
\fP
.fi
This function returns the pointer to the user information associated to the cache pointed to by \fBCAESAR_C\fP when this cache was created using \fBCAESAR_CREATE_CACHE_1()\fP.
Precisely, the result returned by this function is the value of the formal parameter \fBCAESAR_INFO\fP supplied at the call to \fBCAESAR_CREATE_CACHE_1()\fP.
.sp
.P
 ............................................................
.SS \fBCAESAR_RETRIEVE_B_M_CACHE_1\fP
 \&
.nf
\fBvoid CAESAR_RETRIEVE_B_M_CACHE_1 (CAESAR_C, CAESAR_B, CAESAR_M)
   CAESAR_TYPE_CACHE_1 CAESAR_C;
   CAESAR_TYPE_POINTER CAESAR_B;
   CAESAR_TYPE_POINTER *CAESAR_M;
   { ... }
\fP
.fi
This procedure computes, for the cache pointed to by \fBCAESAR_C\fP, the address of the mark field of the item whose base field is pointed to by \fBCAESAR_B\fP. This address is assigned to \fB*CAESAR_M\fP.
.sp
If no item stored in (some subcache of) the cache has a base field at address \fBCAESAR_B\fP, the effect is undefined.
.sp
If there are no mark fields in the cache (due to the initialization parameters supplied to \fBCAESAR_CREATE_CACHE_1()\fP), the effect is undefined.
.sp
.P
 ............................................................
.SS \fBCAESAR_RETRIEVE_M_B_CACHE_1\fP
 \&
.nf
\fBvoid CAESAR_RETRIEVE_M_B_CACHE_1 (CAESAR_C, CAESAR_M, CAESAR_B)
   CAESAR_TYPE_CACHE_1 CAESAR_C;
   CAESAR_TYPE_POINTER CAESAR_M;
   CAESAR_TYPE_POINTER *CAESAR_B;
   { ... }
\fP
.fi
This procedure computes, for the cache pointed to by \fBCAESAR_C\fP, the address of the base field of the item whose mark field is pointed to by \fBCAESAR_M\fP. This address is assigned to \fB*CAESAR_B\fP.
.sp
If no item stored in (some subcache of) the cache has a mark field at address \fBCAESAR_M\fP, the effect is undefined.
.sp
If there are no mark fields in the cache (due to the initialization parameters supplied to \fBCAESAR_CREATE_CACHE_1()\fP), the effect is undefined.
.sp
.P
 ............................................................
.SS \fBCAESAR_FORMAT_CACHE_1\fP
 \&
.nf
\fBCAESAR_TYPE_FORMAT CAESAR_FORMAT_CACHE_1 (CAESAR_C, CAESAR_FORMAT)
   CAESAR_TYPE_CACHE_1 CAESAR_C;
   CAESAR_TYPE_FORMAT CAESAR_FORMAT;
   { ... }
\fP
.fi
This function allows to control the format under which the cache pointed to by \fBCAESAR_C\fP will be printed by the procedure \fBCAESAR_PRINT_CACHE_1()\fP (see below). Currently, the following formats are available:
.sp
.IP -
With format 0, statistical information concerning the cache is displayed such as: the number of items, the replacement strategy and the number of hits for each subcache of the cache, the total number of searches and hits for the whole cache, etc.
.IP -
(no other format available yet)
.P
By default, the current format of each cache is initialized to 0.
.sp
When called with \fBCAESAR_FORMAT\fP between 0 and 0, this fonction sets the current format of \fBCAESAR_C\fP to \fBCAESAR_FORMAT\fP and returns an undefined result.
.sp
When called with another value of \fBCAESAR_FORMAT\fP, this function does not modify the current format of \fBCAESAR_C\fP but returns a result defined as follows. If \fBCAESAR_FORMAT\fP is equal to the constant \fBCAESAR_CURRENT_FORMAT\fP, the result is the value of the current format of \fBCAESAR_C\fP. If \fBCAESAR_FORMAT\fP is equal to the constant \fBCAESAR_MAXIMAL_FORMAT\fP, the result is the maximal format value (i.e., 0). In all other cases, the effect of this function is undefined.
.sp
.P
 ............................................................
.SS \fBCAESAR_MAX_FORMAT_CACHE_1\fP
 \&
.nf
\fBCAESAR_TYPE_FORMAT CAESAR_MAX_FORMAT_CACHE_1 ()
   { ... }
\fP
.fi
Caution! This function is deprecated. It should no longer be used, as it might be removed from future versions of the \fIOPEN/CAESAR\fP. Use function \fBCAESAR_FORMAT_CACHE_1()\fP instead, called with argument \fBCAESAR_MAXIMAL_FORMAT\fP.
.sp
This function returns the maximal format value available for printing caches.
.sp
.P
 ............................................................
.SS \fBCAESAR_PRINT_CACHE_1\fP
 \&
.nf
\fBvoid CAESAR_PRINT_CACHE_1 (CAESAR_FILE, CAESAR_C)
   CAESAR_TYPE_FILE CAESAR_FILE;
   CAESAR_TYPE_CACHE_1 CAESAR_C;
   { ... }
\fP
.fi
This procedure prints on file \fBCAESAR_FILE\fP an ASCII text containing various informations about the cache pointed to by \fBCAESAR_C\fP. The nature of these informations is determined by the current format of the cache pointed to by \fBCAESAR_C\fP.
.sp
Before this procedure is called, \fBCAESAR_FILE\fP must have been properly opened, for instance using \fBfopen(3)\fP.
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
