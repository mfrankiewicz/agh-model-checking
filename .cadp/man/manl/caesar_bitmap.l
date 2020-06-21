'\" t
.\" @(#)caesar_bitmap.l - VASY and CONVECS teams - version 1.5
.TH caesar_bitmap LOCAL "2020/02/11 (version 1.5)" "(C) INRIA" "OPEN/CAESAR MANUAL"
.fp 4 CB
.lg 0
.SH NAME
caesar_bitmap \- the ``bitmap'' library of OPEN/CAESAR
.SH PURPOSE
The ``bitmap'' library provides primitives for implementing the ``bit state space'' verification technique proposed by Gerard Holzmann.
.sp
.SH USAGE
The ``bitmap'' library consists of:
.IP -
a predefined header file \fBcaesar_bitmap.h\fP;
.IP -
the precompiled library file \fBlibcaesar.a\fP, which implements the features described in \fBcaesar_bitmap.h\fP.
.P
Note: The ``bitmap'' library is a software layer built above the primitives offered by the ``standard'' and ``hash'' libraries.
.sp
.SH DESCRIPTION
A ``bitmap'' of size N is basically an array of N bits numbered from 0 to N-1. The value of N is usually large (e.g., some tenth million states).
.sp
Additionally, statistics are attached to each bitmap. These statistics consist of a ``success counter'' (which counts how many bits equal to 1 have been read) and a ``failure counter'' (which counts how many bits equal to 0 have been read).
.sp
.SH FEATURES
.P
 ............................................................
.SS \fBCAESAR_TYPE_BITMAP\fP
 \&
.nf
\fBtypedef CAESAR_TYPE_ABSTRACT (...) CAESAR_TYPE_BITMAP;
\fP
.fi
This type denotes a pointer to the concrete representation of a bitmap, which is supposed to be ``opaque''.
.P
 ............................................................
.SS \fBCAESAR_CREATE_BITMAP\fP
 \&
.nf
\fBvoid CAESAR_CREATE_BITMAP (CAESAR_B, CAESAR_SIZE, CAESAR_PRIME)
   CAESAR_TYPE_BITMAP *CAESAR_B;
   CAESAR_TYPE_NATURAL CAESAR_SIZE;
   CAESAR_TYPE_BOOLEAN CAESAR_PRIME;
   { ... }
\fP
.fi
This procedure allocates a bitmap using \fBCAESAR_CREATE()\fP and assigns its address to \fB*CAESAR_B\fP. The size N of this bitmap is determined by the values of formal parameters \fBCAESAR_SIZE\fP and \fBCAESAR_PRIME\fP, and also by the amount of memory available.
.sp
Note: because \fBCAESAR_TYPE_BITMAP\fP is a pointer type, any variable \fBCAESAR_B\fP of type \fBCAESAR_TYPE_BITMAP\fP must be allocated before used, for instance using:
.TS
center;
l.
 
 \fBCAESAR_CREATE_BITMAP (&CAESAR_B, ...)\fP 
 
.TE
.sp
If the value of \fBCAESAR_SIZE\fP is different from 0, then the number N of bits in the bitmap will be \fBCAESAR_SIZE\fP.
.sp
If the value of \fBCAESAR_SIZE\fP is equal to 0, then N will be given a default value as large as possible.
.sp
Note: in this case, the bitmap will fill most of the memory space available for the current process. Therefore, if \fBCAESAR_CREATE_BITMAP()\fP is to be called with \fBCAESAR_SIZE\fP = 0, it should be called only after having allocated all the other data structures (e.g., stacks, ...), otherwise there may be not enough memory for these data structures.
.sp
In both cases, the value of N can be reduced to a smaller value as to fit into the amount of available memory.
.sp
If the value of \fBCAESAR_PRIME\fP is different from 0, the value of N can also be reduced to the immediately smaller prime number (since some hash functions require prime modulus). If the value of \fBCAESAR_PRIME\fP is equal to 0, the value of N is not changed.
.sp
If (in spite of various attempts) the allocation fails, the \fBNULL\fP value is assigned to \fB*CAESAR_B\fP.
.sp
If the allocation succeeds, the final value of N can be known using the function \fBCAESAR_SIZE_BITMAP()\fP (see below).
.sp
If the allocation succeeds, the N bits of the bitmap are initialized to 0. The success and failure counters attached to the bitmap are also initialized to 0.
.sp
Note: since variable \fBCAESAR_SIZE\fP is a value of type \fBCAESAR_TYPE_NATURAL\fP, a bitmap can contain at most 2^{8n}-1 bits, where:
.TS
center;
l.
 
 n = \fBsizeof (CAESAR_TYPE_NATURAL)\fP 
 
.TE
It is assumed that n >= 4. For n = 4, this makes 4,294,967,295 bits, that is approximately 537 Megabytes of memory, which is currently enough.
.P
 ............................................................
.SS \fBCAESAR_DELETE_BITMAP\fP
 \&
.nf
\fBvoid CAESAR_DELETE_BITMAP (CAESAR_B)
   CAESAR_TYPE_BITMAP *CAESAR_B;
   { ... }
\fP
.fi
This procedure frees the memory space corresponding to the bitmap pointed to by \fB*CAESAR_B\fP using \fBCAESAR_DELETE()\fP. Afterwards, the \fBNULL\fP value is assigned to \fB*CAESAR_B\fP.
.P
 ............................................................
.SS \fBCAESAR_PURGE_BITMAP\fP
 \&
.nf
\fBvoid CAESAR_PURGE_BITMAP (CAESAR_B)
   CAESAR_TYPE_BITMAP CAESAR_B;
   { ... }
\fP
.fi
This procedure empties the bitmap pointed to by \fBCAESAR_B\fP without deleting it. Afterwards, this bitmap is exactly in the same state as after its creation using \fBCAESAR_CREATE_BITMAP()\fP. Its size remains unchanged.
.P
 ............................................................
.SS \fBCAESAR_SIZE_BITMAP\fP
 \&
.nf
\fBCAESAR_TYPE_NATURAL CAESAR_SIZE_BITMAP (CAESAR_B)
   CAESAR_TYPE_BITMAP CAESAR_B;
   { ... }
\fP
.fi
This function returns the size (i.e., number of bits) of the bitmap pointed to by \fBCAESAR_B\fP. This size is determined when the bitmap is created using \fBCAESAR_CREATE_BITMAP()\fP and remains constant.
.P
 ............................................................
.SS \fBCAESAR_SET_BITMAP\fP
 \&
.nf
\fBvoid CAESAR_SET_BITMAP (CAESAR_B, CAESAR_I)
   CAESAR_TYPE_BITMAP CAESAR_B;
   CAESAR_TYPE_NATURAL CAESAR_I;
   { ... }
\fP
.fi
This procedure sets to 1 the \fBCAESAR_I\fP-th bit of the bitmap pointed to by \fBCAESAR_B\fP. The value of \fBCAESAR_I\fP is such that:
.TS
center;
l.
 
 0 <= \fBCAESAR_I\fP <= \fBCAESAR_SIZE_BITMAP (CAESAR_B)\fP 
 
.TE
It is usually the result of some hash-code computation.
.P
 ............................................................
.SS \fBCAESAR_RESET_BITMAP\fP
 \&
.nf
\fBvoid CAESAR_RESET_BITMAP (CAESAR_B, CAESAR_I)
   CAESAR_TYPE_BITMAP CAESAR_B;
   CAESAR_TYPE_NATURAL CAESAR_I;
   { ... }
\fP
.fi
This procedure sets to 0 the \fBCAESAR_I\fP-th bit of the bitmap pointed to by \fBCAESAR_B\fP. The value of \fBCAESAR_I\fP is such that:
.TS
center;
l.
 
 0 <= \fBCAESAR_I\fP <= \fBCAESAR_SIZE_BITMAP (CAESAR_B)\fP 
 
.TE
It is usually the result of some hash-code computation.
.P
 ............................................................
.SS \fBCAESAR_TEST_BITMAP\fP
 \&
.nf
\fBCAESAR_TYPE_BOOLEAN CAESAR_TEST_BITMAP (CAESAR_B, CAESAR_I)
   CAESAR_TYPE_BITMAP CAESAR_B;
   CAESAR_TYPE_NATURAL CAESAR_I;
   { ... }
\fP
.fi
This function returns 0 if the \fBCAESAR_I\fP-th bit of the bitmap pointed to by \fBCAESAR_B\fP is equal to 0, or a value different from 0 if this bit is equal to 1. The value of \fBCAESAR_I\fP is such that:
.TS
center;
l.
 
 0 <= \fBCAESAR_I\fP <= \fBCAESAR_SIZE_BITMAP (CAESAR_B)\fP 
 
.TE
It is usually the result of some hash-code computation.
.sp
A return value of 0 increments the failure counter attached to the bitmap pointed to by \fBCAESAR_B\fP, whereas a return value of 1 increments the success counter.
.P
 ............................................................
.SS \fBCAESAR_TEST_AND_SET_BITMAP\fP
 \&
.nf
\fBCAESAR_TYPE_BOOLEAN CAESAR_TEST_AND_SET_BITMAP (CAESAR_B, CAESAR_I)
   CAESAR_TYPE_BITMAP CAESAR_B;
   CAESAR_TYPE_NATURAL CAESAR_I;
   { ... }
\fP
.fi
This function returns 0 if the \fBCAESAR_I\fP-th bit of the bitmap pointed to by \fBCAESAR_B\fP is equal to 0, or a value different from 0 if this bit is equal to 1. The value of \fBCAESAR_I\fP is such that:
.TS
center;
l.
 
 0 <= \fBCAESAR_I\fP <= \fBCAESAR_SIZE_BITMAP (CAESAR_B)\fP 
 
.TE
It is usually the result of some hash-code computation.
.sp
The \fBCAESAR_I\fP-th bit of the bitmap pointed to by \fBCAESAR_B\fP is set to 1 if it was equal to 0.
.sp
A return value of 0 increments the failure counter attached to the bitmap pointed to by \fBCAESAR_B\fP, whereas a return value of 1 increments the success counter.
.P
 ............................................................
.SS \fBCAESAR_TEST_AND_RESET_BITMAP\fP
 \&
.nf
\fBCAESAR_TYPE_BOOLEAN CAESAR_TEST_AND_RESET_BITMAP (CAESAR_B, CAESAR_I)
   CAESAR_TYPE_BITMAP CAESAR_B;
   CAESAR_TYPE_NATURAL CAESAR_I;
   { ... }
\fP
.fi
This function returns 0 if the \fBCAESAR_I\fP-th bit of the bitmap pointed to by \fBCAESAR_B\fP is equal to 0, or a value different from 0 if this bit is equal to 1. The value of \fBCAESAR_I\fP is such that:
.TS
center;
l.
 
 0 <= \fBCAESAR_I\fP <= \fBCAESAR_SIZE_BITMAP (CAESAR_B)\fP 
 
.TE
It is usually the result of some hash-code computation.
.sp
The \fBCAESAR_I\fP-th bit of the bitmap pointed to by \fBCAESAR_B\fP is set to 0 if it was equal to 1.
.sp
A return value of 0 increments the failure counter attached to the bitmap pointed to by \fBCAESAR_B\fP, whereas a return value of 1 increments the success counter.
.P
 ............................................................
.SS \fBCAESAR_ZERO_BITMAP\fP
 \&
.nf
\fBCAESAR_TYPE_NATURAL CAESAR_ZERO_BITMAP (CAESAR_B)
   CAESAR_TYPE_BITMAP CAESAR_B;
   { ... }
\fP
.fi
This function returns the number of bits which are equal to 0 in the bitmap pointed to by \fBCAESAR_B\fP.
.P
 ............................................................
.SS \fBCAESAR_ONE_BITMAP\fP
 \&
.nf
\fBCAESAR_TYPE_NATURAL CAESAR_ONE_BITMAP (CAESAR_B)
   CAESAR_TYPE_BITMAP CAESAR_B;
   { ... }
\fP
.fi
This function returns the number of bits which are equal to 1 in the bitmap pointed to by \fBCAESAR_B\fP.
.sp
Note: for any bitmap \fBCAESAR_B\fP:
.TS
center;
l.
 
 \fBCAESAR_ZERO_BITMAP (CAESAR_B)\fP + \fBCAESAR_ONE_BITMAP (CAESAR_B)\fP 
 
.TE
is equal to:
.TS
center;
l.
 
 \fBCAESAR_SIZE_BITMAP (CAESAR_B)\fP 
 
.TE
.P
 ............................................................
.SS \fBCAESAR_FAILURE_BITMAP\fP
 \&
.nf
\fBCAESAR_TYPE_NATURAL CAESAR_FAILURE_BITMAP (CAESAR_B)
   CAESAR_TYPE_BITMAP CAESAR_B;
   { ... }
\fP
.fi
This function returns the value of the failure counter of the bitmap pointed to by \fBCAESAR_B\fP, i.e., the number of searches that failed (see functions \fBCAESAR_TEST_BITMAP()\fP, \fBCAESAR_TEST_AND_SET_BITMAP()\fP, and \fBCAESAR_TEST_AND_RESET()\fP above).
.P
 ............................................................
.SS \fBCAESAR_SUCCESS_BITMAP\fP
 \&
.nf
\fBCAESAR_TYPE_NATURAL CAESAR_SUCCESS_BITMAP (CAESAR_B)
   CAESAR_TYPE_BITMAP CAESAR_B;
   { ... }
\fP
.fi
This function returns the value of the success counter of the bitmap pointed to by \fBCAESAR_B\fP, i.e., the number of searches that succeeded (see functions \fBCAESAR_TEST_BITMAP()\fP, \fBCAESAR_TEST_AND_SET_BITMAP()\fP, and \fBCAESAR_TEST_AND_RESET()\fP above).
.P
 ............................................................
.SS \fBCAESAR_FORMAT_BITMAP\fP
 \&
.nf
\fBCAESAR_TYPE_FORMAT CAESAR_FORMAT_BITMAP (CAESAR_B, CAESAR_FORMAT)
   CAESAR_TYPE_BITMAP CAESAR_B;
   CAESAR_TYPE_FORMAT CAESAR_FORMAT;
   { ... }
\fP
.fi
This function allows to control the format under which the bitmap pointed to by \fBCAESAR_B\fP will be printed by the procedure \fBCAESAR_PRINT_BITMAP()\fP (see below). Currently, the following formats are available:
.sp
.IP -
With format 0, statistical information about the bitmap is displayed such as: the size in bytes, the number of bits, the number of bits equal to 0, the number of bits equal to 1, the success counter, the failure counter, etc.
.IP -
With format 1, the contents of the bitmap are printed in hexadecimal. This can be useful for debugging bitmaps of small size.
.IP -
With format 2, the list of bits which are equal to 0 is printed. This can be useful for debugging bitmaps with almost all bits equal to 1.
.IP -
With format 3, the list of bits which are equal to 1 is printed. This can be useful for debugging bitmaps with almost all bits equal to 0.
.IP -
(no other format available yet).
.P
By default, the current format of each bitmap is initialized to 0.
.sp
When called with \fBCAESAR_FORMAT\fP between 0 and 3, this fonction sets the current format of \fBCAESAR_B\fP to \fBCAESAR_FORMAT\fP and returns an undefined result.
.sp
When called with another value of \fBCAESAR_FORMAT\fP, this function does not modify the current format of \fBCAESAR_B\fP but returns a result defined as follows. If \fBCAESAR_FORMAT\fP is equal to the constant \fBCAESAR_CURRENT_FORMAT\fP, the result is the value of the current format of \fBCAESAR_B\fP. If \fBCAESAR_FORMAT\fP is equal to the constant \fBCAESAR_MAXIMAL_FORMAT\fP, the result is the maximal format value (i.e., 3). In all other cases, the effect of this function is undefined.
.P
 ............................................................
.SS \fBCAESAR_MAX_FORMAT_BITMAP\fP
 \&
.nf
\fBCAESAR_TYPE_FORMAT CAESAR_MAX_FORMAT_BITMAP ()
   { ... }
\fP
.fi
Caution! This function is deprecated. It should no longer be used, as it might be removed from future versions of the \fIOPEN/CAESAR\fP. Use function \fBCAESAR_FORMAT_BITMAP()\fP instead, called with argument \fBCAESAR_MAXIMAL_FORMAT\fP.
.sp
This function returns the maximal format value available for printing bitmaps.
.P
 ............................................................
.SS \fBCAESAR_PRINT_BITMAP\fP
 \&
.nf
\fBvoid CAESAR_PRINT_BITMAP (CAESAR_FILE, CAESAR_B)
   CAESAR_TYPE_FILE CAESAR_FILE;
   CAESAR_TYPE_BITMAP CAESAR_B;
   { ... }
\fP
.fi
This procedure prints to file \fBCAESAR_FILE\fP a character string containing information about the bitmap pointed to by \fBCAESAR_B\fP. The nature of the information is determined by the current format of the bitmap pointed to by \fBCAESAR_B\fP.
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
