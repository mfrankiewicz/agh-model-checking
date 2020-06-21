'\" t
.\" @(#)caesar_area_1.l - VASY and CONVECS teams - version 1.1
.TH caesar_area_1 LOCAL "2020/02/11 (version 1.1)" "(C) INRIA" "OPEN/CAESAR MANUAL"
.fp 4 CB
.lg 0
.SH NAME
caesar_area_1 \- the ``area_1'' library of OPEN/CAESAR
.SH PURPOSE
The ``area_1'' library provides primitives for managing ``areas'', which are memory chunks of various sizes and alignment factors. This library provides for genericity by allowing different objects (states, labels, character strings, user-defined memory chunks) to be handled uniformly.
.sp
.sp
.SH USAGE
The ``area_1'' library consists of:
.IP -
a predefined header file \fBcaesar_area_1.h\fP;
.IP -
the precompiled library file \fBlibcaesar.a\fP, which implements the features described in \fBcaesar_area_1.h\fP.
.P
Note: The ``area_1'' library is a software layer built above the primitives offered by the ``standard'' and ``hash'' libraries, and by the \fIOPEN/CAESAR\fP graph module.
.sp
.sp
.SH DESCRIPTION
An ``area'' is basically a memory chunk (i.e., a sequence of contiguous bytes) characterized by its (fixed) size and its alignment factor (see the description of \fBCAESAR_ALIGNMENT_POINTER()\fP in the ``standard'' library for a definition of the alignment factor).
.sp
There are five different kinds of areas:
.IP -
an ``ordinary area'' may contain any kind of data; the precise contents of an ordinary area is left to the user and is not specified in the context of the ``area_1'' library;
.IP -
an ``empty area'' is a special area of zero bytes;
.IP -
a ``state area'' is a special area dedicated to contain a state, as described in the graph module, i.e., a value of type \fBCAESAR_BODY_STATE\fP;
.IP -
a ``label area'' is a special area dedicated to contain a label, as described in the graph module, i.e., a value of type \fBCAESAR_BODY_LABEL\fP;
.IP -
a ``string area'' is a special area dedicated to contain a pointer to a null-terminated character string, i.e., a value of type \fBCAESAR_TYPE_STRING\fP. Notice that a string area does not contain a (variable length) character string but a (fixed length) pointer to a (variable length) character string.
.P
.sp
.SH FEATURES
.P
 ............................................................
.SS \fBCAESAR_TYPE_AREA_1\fP
 \&
.nf
\fBtypedef CAESAR_TYPE_NATURAL CAESAR_TYPE_AREA_1;
#define CAESAR_EXPONENT_EMPTY_AREA_1     0
#define CAESAR_EXPONENT_STATE_AREA_1     1
#define CAESAR_EXPONENT_LABEL_AREA_1     2
#define CAESAR_EXPONENT_STRING_AREA_1    3
\fP
.fi
Concretely, the type \fBCAESAR_TYPE_AREA_1\fP is represented as a numerical type (32-bit or 64-bit natural number depending on the machine architecture). Logically, a value of type \fBCAESAR_TYPE_AREA_1\fP is a pair (length field, exponent field), where:
.sp
.IP -
the exponent field is an unsigned natural number coded on the 4 highest bits (thus, in the range 0..15), and
.IP -
the length field is an unsigned natural number coded on the remaining (all but 4) lowest bits, i.e., either coded on 28 bits (and thus, in the range 0...268,435,455) on 32-bit machines, or coded on 60 bits (and thus, in the range 0...1,152,921,504,606,846,975) on 64-bit machines.
.P
The different kinds of areas are represented as follows:
.sp
.IP -
for an ordinary area, the length field is different from zero and represents the size (in bytes) of the area; if the exponent field is equal to a value f different from zero, the alignment factor (in bytes) of the area is equal to 2^{f-1}; the case in which the exponent field is equal to zero corresponds to a backward compatibility situation, which is now obsolete and in which the alignment factor is guessed empirically from the value of the length field (see the definition of \fBCAESAR_ALIGNMENT_AREA_1()\fP below);
.IP -
for an empty area, the length field is equal to zero and the exponent field is equal to the constant \fBCAESAR_EXPONENT_EMPTY_AREA_1\fP;
.IP -
for a state area, the length field is equal to zero and the exponent field is equal to the constant \fBCAESAR_EXPONENT_STATE_AREA_1\fP;
.IP -
for a label area, the length field is equal to zero and the exponent field is equal to the constant \fBCAESAR_EXPONENT_LABEL_AREA_1\fP;
.IP -
for a string area, the length field is equal to zero and the exponent field is equal to the constant \fBCAESAR_EXPONENT_STRING_AREA_1\fP;
.IP -
any other case in which the length field is equal to zero is undefined.
.P
.sp
.P
 ............................................................
.SS \fBCAESAR_LENGTH_AREA_1\fP
 \&
.nf
\fBCAESAR_TYPE_NATURAL CAESAR_LENGTH_AREA_1 (CAESAR_AREA)
   CAESAR_TYPE_AREA_1 CAESAR_AREA;
   { ... }
\fP
.fi
This function returns the length field of the area \fBCAESAR_AREA\fP.
.sp
.P
 ............................................................
.SS \fBCAESAR_EXPONENT_AREA_1\fP
 \&
.nf
\fBCAESAR_TYPE_NATURAL CAESAR_EXPONENT_AREA_1 (CAESAR_AREA)
   CAESAR_TYPE_AREA_1 CAESAR_AREA;
   { ... }
\fP
.fi
This function returns the exponent field of the area \fBCAESAR_AREA\fP.
.sp
.P
 ............................................................
.SS \fBCAESAR_AREA_1\fP
 \&
.nf
\fBCAESAR_AREA_1 CAESAR_AREA_1 (CAESAR_LENGTH, CAESAR_EXPONENT)
   CAESAR_TYPE_NATURAL CAESAR_LENGTH;
   CAESAR_TYPE_NATURAL CAESAR_EXPONENT;
   { ... }
\fP
.fi
This function returns the area with a length field equal to \fBCAESAR_LENGTH\fP and an exponent field equal to \fBCAESAR_EXPONENT\fP.
.sp
Note: this function does not check that its parameters are consistent, e.g., that for an ordinary area the alignment (specified by the exponent field) is an exact divider of the size (specified by the length field).
.sp
.P
 ............................................................
.SS \fBCAESAR_EMPTY_AREA_1\fP
 \&
.nf
\fBCAESAR_TYPE_AREA_1 CAESAR_EMPTY_AREA_1 ()
   { ... }
\fP
.fi
This function returns the area with a length field equal to 0 and an exponent field equal to \fBCAESAR_EXPONENT_EMPTY_AREA_1\fP (i.e., corresponding to an empty area).
.sp
Note: For backward compatibility reasons, \fBCAESAR_EMPTY_AREA_1()\fP is equal to 0.
.sp
.P
 ............................................................
.SS \fBCAESAR_STATE_AREA_1\fP
 \&
.nf
\fBCAESAR_TYPE_AREA_1 CAESAR_STATE_AREA_1 ()
   { ... }
\fP
.fi
This function returns the area with a length field equal to 0 and an exponent field equal to \fBCAESAR_EXPONENT_STATE_AREA_1\fP (i.e., corresponding to a state area).
.sp
.P
 ............................................................
.SS \fBCAESAR_LABEL_AREA_1\fP
 \&
.nf
\fBCAESAR_TYPE_AREA_1 CAESAR_LABEL_AREA_1 ()
   { ... }
\fP
.fi
This function returns the area with a length field equal to 0 and an exponent field equal to \fBCAESAR_EXPONENT_LABEL_AREA_1\fP (i.e., corresponding to a label area).
.sp
.P
 ............................................................
.SS \fBCAESAR_STRING_AREA_1\fP
 \&
.nf
\fBCAESAR_TYPE_AREA_1 CAESAR_STRING_AREA_1 ()
   { ... }
\fP
.fi
This function returns the area with a length field equal to 0 and an exponent field equal to \fBCAESAR_EXPONENT_STRING_AREA_1\fP (i.e., corresponding to a string area).
.sp
.P
 ............................................................
.SS \fBCAESAR_BYTE_AREA_1\fP
 \&
.nf
\fBCAESAR_TYPE_AREA_1 CAESAR_BYTE_AREA_1 (CAESAR_LENGTH)
   CAESAR_TYPE_NATURAL CAESAR_LENGTH;
   { ... }
\fP
.fi
This function returns the area with a length field equal to \fBCAESAR_LENGTH\fP and an exponent field corresponding to a byte or a character (i.e., a memory area with an alignment of 1).
.sp
.P
 ............................................................
.SS \fBCAESAR_NATURAL_AREA_1\fP
 \&
.nf
\fBCAESAR_TYPE_AREA_1 CAESAR_NATURAL_AREA_1 (CAESAR_LENGTH)
   CAESAR_TYPE_NATURAL CAESAR_LENGTH;
   { ... }
\fP
.fi
This function returns the area with a length field equal to \fBCAESAR_LENGTH\fP and an exponent field corresponding to a natural or integer number (i.e., a memory area with an alignment suitable for a value of type \fBCAESAR_TYPE_NATURAL\fP or \fBCAESAR_TYPE_INTEGER\fP).
.sp
Note: In principle, such an area should not contain pointers.
.sp
.P
 ............................................................
.SS \fBCAESAR_POINTER_AREA_1\fP
 \&
.nf
\fBCAESAR_TYPE_AREA_1 CAESAR_POINTER_AREA_1 (CAESAR_LENGTH)
   CAESAR_TYPE_NATURAL CAESAR_LENGTH;
   { ... }
\fP
.fi
This function returns the area with a length field equal to \fBCAESAR_LENGTH\fP and an exponent field corresponding to a pointer (i.e., a memory area with an alignment equal to \fBCAESAR_ALIGNMENT_POINTER()\fP).
.sp
Note: In principle, such an area should contain at least one pointer, because pointers usually have the strongest alignment constraints.
.sp
.P
 ............................................................
.SS \fBCAESAR_SIZE_AREA_1\fP
 \&
.nf
\fBCAESAR_TYPE_NATURAL CAESAR_SIZE_AREA_1 (CAESAR_AREA)
   CAESAR_TYPE_AREA_1 CAESAR_AREA;
   { ... }
\fP
.fi
This function returns the size (in bytes) of the area \fBCAESAR_AREA\fP:
.IP -
for an ordinary area, this size is equal to the length field of \fBCAESAR_AREA\fP;
.IP -
for an empty area, this size is equal to zero;
.IP -
for a state area, this size is given by the \fBCAESAR_SIZE_STATE()\fP function exported by the graph module;
.IP -
for a label area, this size is given by the \fBCAESAR_SIZE_LABEL()\fP function exported by the graph module;
.IP -
for a string area, this size is equal to \fBCAESAR_SIZE_POINTER()\fP (which corresponds to the size of a character string pointer).
.P
.sp
.P
 ............................................................
.SS \fBCAESAR_HASH_SIZE_AREA_1\fP
 \&
.nf
\fBCAESAR_TYPE_NATURAL CAESAR_HASH_SIZE_AREA_1 (CAESAR_AREA)
   CAESAR_TYPE_AREA_1 CAESAR_AREA;
   { ... }
\fP
.fi
This function returns the ``hashable'' size (in bytes) of the area \fBCAESAR_AREA\fP:
.IP -
for an ordinary area, this size is equal to the length field of \fBCAESAR_AREA\fP (this is an arbitrary definition, since the actual contents of \fBCAESAR_AREA\fP are unknown);
.IP -
for an empty area, this size is equal to zero (which expresses the fact that an empty area is not appropriate for hashing);
.IP -
for a state area, this size is given by the \fBCAESAR_HASH_SIZE_STATE()\fP function exported by the graph module;
.IP -
for a label area, this size is given by the \fBCAESAR_HASH_SIZE_LABEL()\fP function exported by the graph module;
.IP -
for a string area, this size is equal to zero (which expresses the fact that a character string pointer, i.e., a value of type \fB(CAESAR_TYPE_STRING *)\fP, is not directly appropriate for hashing).
.P
.sp
.P
 ............................................................
.SS \fBCAESAR_ALIGNMENT_AREA_1\fP
 \&
.nf
\fBCAESAR_TYPE_NATURAL CAESAR_ALIGNMENT_AREA_1 (CAESAR_AREA)
   CAESAR_TYPE_AREA_1 CAESAR_AREA;
   { ... }
\fP
.fi
This function returns the alignment factor (in bytes) of the area \fBCAESAR_AREA\fP:
.IP -
for an ordinary area whose exponent field f is different from zero, the alignment factor is equal to 2^{f-1};
.IP -
for an ordinary area whose exponent field is equal to zero (backward compatibility case), the alignment factor is guessed empirically from the size of \fBCAESAR_AREA\fP (precisely, the alignment factor will be the largest value in the set {1, 2, 4, 8} that divides the size of \fBCAESAR_AREA\fP exactly; this is an arbitrary definition, since the actual contents of \fBCAESAR_AREA\fP are unknown);
.IP -
for an empty area, this alignment factor is equal to one (which expresses the fact that an empty area has no specific alignment constraint);
.IP -
for a state area, this alignment factor is given by the \fBCAESAR_ALIGNMENT_STATE()\fP function exported by the graph module;
.IP -
for a label area, this alignment factor is given by the \fBCAESAR_ALIGNMENT_LABEL()\fP function exported by the graph module;
.IP -
for a string area, this alignment factor is equal to \fBCAESAR_ALIGNMENT_POINTER()\fP (which corresponds to the alignment factor of a character string pointer).
.P
.sp
.P
 ............................................................
.SS \fBCAESAR_COPY_AREA_1\fP
 \&
.nf
\fBvoid CAESAR_COPY_AREA_1 (CAESAR_P1, CAESAR_P2, CAESAR_SIZE)
   CAESAR_TYPE_POINTER CAESAR_P1;
   CAESAR_TYPE_POINTER CAESAR_P2;
   CAESAR_TYPE_NATURAL CAESAR_SIZE;
   { ... }
\fP
.fi
This procedure copies the memory area (of \fBCAESAR_SIZE\fP bytes) pointed to by \fBCAESAR_P2\fP to the location pointed to by \fBCAESAR_P1\fP.
.sp
Note: This function is implemented as a simple wrapper for the POSIX function \fBmemcpy(3)\fP.
.sp
.P
 ............................................................
.SS \fBCAESAR_COMPARE_EMPTY_AREA_1\fP
 \&
.nf
\fBCAESAR_TYPE_BOOLEAN CAESAR_COMPARE_EMPTY_AREA_1 (CAESAR_P1, CAESAR_P2)
   CAESAR_TYPE_POINTER CAESAR_P1;
   CAESAR_TYPE_POINTER CAESAR_P2;
   { ... }
\fP
.fi
This function is intended to compare two empty areas and, thus, always returns a value different from 0 (since there is only one empty area).
.sp
Note: this function is used by the \fBCAESAR_USE_COMPARE_FUNCTION_AREA_1()\fP function described below.
.sp
.P
 ............................................................
.SS \fBCAESAR_COMPARE_STRING_AREA_1\fP
 \&
.nf
\fBCAESAR_TYPE_BOOLEAN CAESAR_COMPARE_STRING_AREA_1 (CAESAR_S1, CAESAR_S2)
   CAESAR_TYPE_STRING *CAESAR_S1;
   CAESAR_TYPE_STRING *CAESAR_S2;
   { ... }
\fP
.fi
This function returns a value different from 0 if both character strings pointed to by \fB*CAESAR_S1\fP and \fB*CAESAR_S2\fP are identical, or 0 if they are not.
.sp
Note: This function uses the POSIX function \fBstrcmp(3)\fP.
.sp
Note: this function is used by the \fBCAESAR_USE_COMPARE_FUNCTION_AREA_1()\fP function described below.
.sp
.P
 ............................................................
.SS \fBCAESAR_USE_COMPARE_FUNCTION_AREA_1\fP
 \&
.nf
\fBvoid CAESAR_USE_COMPARE_FUNCTION_AREA_1 (CAESAR_AREA, CAESAR_COMPARE_FUNCTION)
   CAESAR_TYPE_AREA_1 CAESAR_AREA;
   CAESAR_TYPE_COMPARE_FUNCTION *CAESAR_COMPARE_FUNCTION;
   { ... }
\fP
.fi
This procedure modifies the (function pointer) value pointed to by \fB*CAESAR_COMPARE_FUNCTION\fP (possibly to assign this function pointer a default value if it is equal to \fBNULL\fP before the procedure is invoked) in the following cases:
.sp
.IP -
if \fBCAESAR_AREA\fP is an empty area and if \fB*CAESAR_COMPARE_FUNCTION\fP is equal to \fBNULL\fP, then the \fBCAESAR_COMPARE_EMPTY_AREA_1()\fP function defined above will be assigned to \fB*CAESAR_COMPARE_FUNCTION\fP;
.sp
Note: it is not allowed to call this procedure if \fBCAESAR_AREA\fP is an empty area, and if \fB*CAESAR_COMPARE_FUNCTION\fP is different from both \fBNULL\fP and \fBCAESAR_COMPARE_EMPTY_AREA_1()\fP, since in this case \fBCAESAR_COMPARE_EMPTY_AREA_1()\fP is the only sensible comparison function;
.IP -
if \fBCAESAR_AREA\fP is a state area and if \fB*CAESAR_COMPARE_FUNCTION\fP is equal to \fBNULL\fP, then the \fBCAESAR_COMPARE_STATE()\fP function of the graph module will be assigned to \fB*CAESAR_COMPARE_FUNCTION\fP;
.sp
Note: it is not allowed to call this procedure if \fBCAESAR_AREA\fP is a state area, and if \fB*CAESAR_COMPARE_FUNCTION\fP is different from both \fBNULL\fP and \fBCAESAR_COMPARE_STATE()\fP, and if the result of \fBCAESAR_HASH_SIZE_STATE()\fP is strictly less than the result of \fBCAESAR_SIZE_STATE()\fP, since in this case \fBCAESAR_COMPARE_STATE()\fP is the only sensible comparison function;
.IP -
if \fBCAESAR_AREA\fP is a label area and if \fB*CAESAR_COMPARE_FUNCTION\fP is equal to \fBNULL\fP, then the \fBCAESAR_COMPARE_LABEL()\fP function of the graph module will be assigned to \fB*CAESAR_COMPARE_FUNCTION\fP;
.sp
Note: it is not allowed to call this procedure if \fBCAESAR_AREA\fP is a label area, and if \fB*CAESAR_COMPARE_FUNCTION\fP is different from both \fBNULL\fP and \fBCAESAR_COMPARE_LABEL()\fP, and if the result of \fBCAESAR_HASH_SIZE_LABEL()\fP is strictly less than the result of \fBCAESAR_SIZE_LABEL()\fP, since in this case \fBCAESAR_COMPARE_LABEL()\fP is the only sensible comparison function;
.IP -
if \fBCAESAR_AREA\fP is a string area and if \fB*CAESAR_COMPARE_FUNCTION\fP is equal to \fBNULL\fP, then the \fBCAESAR_COMPARE_STRING_AREA_1()\fP function defined above will be assigned to \fB*CAESAR_COMPARE_FUNCTION\fP.
.P
In any other case, \fB*CAESAR_COMPARE_FUNCTION\fP is kept unchanged.
.sp
.sp
.P
 ............................................................
.SS \fBCAESAR_COMPARE_AREA_1\fP
 \&
.nf
\fBCAESAR_TYPE_BOOLEAN CAESAR_COMPARE_AREA_1 (CAESAR_COMPARE_FUNCTION,
                                           CAESAR_P1, CAESAR_P2, CAESAR_SIZE)
   CAESAR_TYPE_COMPARE_FUNCTION CAESAR_COMPARE_FUNCTION;
   CAESAR_TYPE_POINTER CAESAR_P1;
   CAESAR_TYPE_POINTER CAESAR_P2;
   CAESAR_TYPE_NATURAL CAESAR_SIZE;
   { ... }
\fP
.fi
This function compares the two memory areas (of \fBCAESAR_SIZE\fP bytes) pointed to by \fBCAESAR_P1\fP and \fBCAESAR_P2\fP using either \fBCAESAR_COMPARE_FUNCTION\fP if this function pointer is not \fBNULL\fP, or the POSIX function \fBmemcmp(3)\fP otherwise. The result is \fBCAESAR_TRUE\fP if and only if both memory areas are found to be equal.
Note: Before calling \fBCAESAR_COMPARE_AREA_1()\fP, the actual value of \fBCAESAR_COMPARE_FUNCTION\fP should have been set by calling the \fBCAESAR_USE_COMPARE_FUNCTION_AREA_1()\fP function.
.sp
.P
 ............................................................
.SS \fBCAESAR_HASH_EMPTY_AREA_1\fP
 \&
.nf
\fBCAESAR_TYPE_BOOLEAN CAESAR_HASH_EMPTY_AREA_1 (CAESAR_P, CAESAR_MODULUS)
   CAESAR_TYPE_POINTER CAESAR_P;
   CAESAR_TYPE_NATURAL CAESAR_MODULUS;
   { ... }
\fP
.fi
This function is intended to compute an hash-value on empty areas and, thus, always returns 0 (since there is only one empty area). If \fBCAESAR_MODULUS\fP is equal to 0, the result is undefined.
.sp
Note: this function is used by the \fBCAESAR_USE_HASH_FUNCTION_AREA_1()\fP function described below.
.sp
.P
 ............................................................
.SS \fBCAESAR_HASH_STRING_AREA_1\fP
 \&
.nf
\fBCAESAR_TYPE_BOOLEAN CAESAR_HASH_STRING_AREA_1 (CAESAR_P, CAESAR_MODULUS)
   CAESAR_TYPE_POINTER CAESAR_P;
   CAESAR_TYPE_NATURAL CAESAR_MODULUS;
   { ... }
\fP
.fi
This function is intended to compute an hash-value on string areas. It returns a value in the range 0..(\fBCAESAR_MODULUS\fP-1), computed from the character string pointed to by \fB*CAESAR_P\fP (and not by \fBCAESAR_P\fP, as \fBCAESAR_P\fP is expected to be of type \fB(CAESAR_TYPE_STRING *)\fP, not \fBCAESAR_TYPE_STRING\fP).
.sp
Note: to compute the hash-value, this function invokes the \fBCAESAR_STRING_0_HASH()\fP function of the ``hash'' library.
.sp
Note: this function is used by the \fBCAESAR_USE_HASH_FUNCTION_AREA_1()\fP function described below.
.sp
.P
 ............................................................
.SS \fBCAESAR_USE_HASH_FUNCTION_AREA_1\fP
 \&
.nf
\fBvoid CAESAR_USE_HASH_FUNCTION_AREA_1 (CAESAR_AREA, CAESAR_HASH_FUNCTION)
   CAESAR_TYPE_AREA_1 CAESAR_AREA;
   CAESAR_TYPE_HASH_FUNCTION *CAESAR_HASH_FUNCTION;
   { ... }
\fP
.fi
This procedure modifies the (function pointer) value pointed to by \fB*CAESAR_HASH_FUNCTION\fP (possibly to assign this function pointer a default value if it is equal to \fBNULL\fP before the procedure is invoked) in the following cases:
.sp
.IP -
if \fBCAESAR_AREA\fP is an empty area and if \fB*CAESAR_HASH_FUNCTION\fP is equal to \fBNULL\fP, then the \fBCAESAR_HASH_EMPTY_AREA_1()\fP function defined above will be assigned to \fB*CAESAR_HASH_FUNCTION\fP;
.sp
Note: it is not allowed to call this procedure if \fBCAESAR_AREA\fP is an empty area, and if \fB*CAESAR_HASH_FUNCTION\fP is different from both \fBNULL\fP and \fBCAESAR_HASH_EMPTY_AREA_1()\fP, since in this case \fBCAESAR_HASH_EMPTY_AREA_1()\fP is the only sensible hashing function;
.IP -
if \fBCAESAR_AREA\fP is a state area and if \fB*CAESAR_HASH_FUNCTION\fP is equal to \fBNULL\fP, then the \fBCAESAR_HASH_STATE()\fP function of the graph module will be assigned to \fB*CAESAR_HASH_FUNCTION\fP;
.sp
Note: it is not allowed to call this procedure if \fBCAESAR_AREA\fP is a state area, and if \fB*CAESAR_HASH_FUNCTION\fP is different from both \fBNULL\fP and \fBCAESAR_HASH_STATE()\fP, and if the result of \fBCAESAR_HASH_SIZE_STATE()\fP is equal to zero, since in this case \fBCAESAR_HASH_STATE()\fP is the only sensible hashing function;
.IP -
if \fBCAESAR_AREA\fP is a label area and if \fB*CAESAR_HASH_FUNCTION\fP is equal to \fBNULL\fP, then the \fBCAESAR_HASH_LABEL()\fP function of the graph module will be assigned to \fB*CAESAR_HASH_FUNCTION\fP;
.sp
Note: it is not allowed to call this procedure if \fBCAESAR_AREA\fP is a label area, and if \fB*CAESAR_HASH_FUNCTION\fP is different from both \fBNULL\fP and \fBCAESAR_HASH_LABEL()\fP, and if the result of \fBCAESAR_HASH_SIZE_LABEL()\fP is equal to zero, since in this case \fBCAESAR_HASH_LABEL()\fP is the only sensible hashing function;
.IP -
if \fBCAESAR_AREA\fP is a string area and if \fB*CAESAR_HASH_FUNCTION\fP is equal to \fBNULL\fP, then the \fBCAESAR_HASH_STRING_AREA_1()\fP function of the ``hash'' library will be assigned to \fB*CAESAR_HASH_FUNCTION\fP.
.P
In any other case, \fB*CAESAR_HASH_FUNCTION\fP is kept unchanged.
.sp
.P
 ............................................................
.SS \fBCAESAR_HASH_AREA_1\fP
 \&
.nf
\fBCAESAR_TYPE_NATURAL CAESAR_HASH_AREA_1 (CAESAR_HASH_FUNCTION, CAESAR_P,
                                        CAESAR_HASH_SIZE, CAESAR_MODULUS)
   CAESAR_TYPE_HASH_FUNCTION CAESAR_HASH_FUNCTION;
   CAESAR_TYPE_POINTER CAESAR_P;
   CAESAR_TYPE_NATURAL CAESAR_HASH_SIZE;
   CAESAR_TYPE_NATURAL CAESAR_MODULUS;
   { ... }
\fP
.fi
This function computes a hash value for the memory area pointed to by \fBCAESAR_P\fP using either \fBCAESAR_HASH_FUNCTION\fP if this function pointer is not \fBNULL\fP, or function \fBCAESAR_0_HASH()\fP of the ``hash'' library otherwise.
Hashing is performed on the \fBCAESAR_HASH_SIZE\fP first bytes and the hash value returned is in the range 0..(\fBCAESAR_MODULUS\fP-1).
.sp
Note: Before calling \fBCAESAR_HASH_AREA_1()\fP, the actual value of \fBCAESAR_HASH_FUNCTION\fP should have been set by calling the \fBCAESAR_USE_HASH_FUNCTION_AREA_1()\fP function.
.sp
.P
 ............................................................
.SS \fBCAESAR_CONVERT_EMPTY_AREA_1\fP
 \&
.nf
\fBCAESAR_TYPE_STRING CAESAR_CONVERT_EMPTY_AREA_1 (CAESAR_P)
   CAESAR_TYPE_POINTER CAESAR_P;
   { ... }
\fP
.fi
This function returns a constant, user-readable character string representing the empty area.
.sp
Note: It is not allowed to modify the character string returned by \fBCAESAR_CONVERT_EMPTY_AREA_1()\fP nor to free it, for instance using \fBfree(3)\fP.
.sp
Note: this function is used by the \fBCAESAR_USE_CONVERT_FUNCTION_AREA_1()\fP function described below.
.sp
.P
 ............................................................
.SS \fBCAESAR_CONVERT_STRING_AREA_1\fP
 \&
.nf
\fBCAESAR_TYPE_STRING CAESAR_CONVERT_STRING_AREA_1 (CAESAR_S)
   CAESAR_TYPE_STRING *CAESAR_S;
   { ... }
\fP
.fi
This function returns the character string pointed to by \fB*CAESAR_S\fP.
.sp
Note: this function is used by the \fBCAESAR_USE_CONVERT_FUNCTION_AREA_1()\fP function described below.
.sp
.P
 ............................................................
.SS \fBCAESAR_CONVERT_BINARY_AREA_1\fP
 \&
.nf
\fBCAESAR_TYPE_STRING CAESAR_CONVERT_BINARY_AREA_1 (CAESAR_P, CAESAR_SIZE)
   CAESAR_TYPE_POINTER CAESAR_P;
   CAESAR_TYPE_NATURAL CAESAR_SIZE;
   { ... }
\fP
.fi
This function returns a pointer to a character string corresponding to the hexadecimal representation for the \fBCAESAR_SIZE\fP bytes-long memory chunk pointed to by \fBCAESAR_P\fP.
.sp
Note: It is not allowed to modify the character string returned by \fBCAESAR_CONVERT_BINARY_AREA_1()\fP nor to free it, for instance using \fBfree(3)\fP.
.sp
Note: this function is used by the \fBCAESAR_CONVERT_AREA_1()\fP function described below.
.sp
.P
 ............................................................
.SS \fBCAESAR_USE_CONVERT_FUNCTION_AREA_1\fP
 \&
.nf
\fBvoid CAESAR_USE_CONVERT_FUNCTION_AREA_1 (CAESAR_AREA, CAESAR_CONVERT_FUNCTION)
   CAESAR_TYPE_AREA_1 CAESAR_AREA;
   CAESAR_TYPE_CONVERT_FUNCTION *CAESAR_CONVERT_FUNCTION;
   { ... }
\fP
.fi
This procedure modifies the (function pointer) value pointed to by \fB*CAESAR_CONVERT_FUNCTION\fP (possibly to assign this function pointer a default value if it is equal to \fBNULL\fP before the procedure is invoked) in the following cases:
.sp
.IP -
if \fBCAESAR_AREA\fP is an empty area and if \fB*CAESAR_CONVERT_FUNCTION\fP is equal to \fBNULL\fP, then the \fBCAESAR_CONVERT_EMPTY_AREA_1()\fP function defined above will be assigned to \fB*CAESAR_CONVERT_FUNCTION\fP;
.IP -
if \fBCAESAR_AREA\fP is a state area and if \fB*CAESAR_CONVERT_FUNCTION\fP is equal to \fBNULL\fP, then the effect of this procedure is undefined;
.IP -
if \fBCAESAR_AREA\fP is a label area and if \fB*CAESAR_CONVERT_FUNCTION\fP is equal to \fBNULL\fP, then the \fBCAESAR_STRING_LABEL()\fP function of the graph module will be assigned to \fB*CAESAR_CONVERT_FUNCTION\fP;
.IP -
if \fBCAESAR_AREA\fP is a string area and if \fB*CAESAR_CONVERT_FUNCTION\fP is equal to \fBNULL\fP, then the \fBCAESAR_CONVERT_STRING_AREA_1()\fP function defined above will be assigned to \fB*CAESAR_CONVERT_FUNCTION\fP.
.P
In any other case, \fB*CAESAR_CONVERT_FUNCTION\fP is kept unchanged.
.sp
.P
 ............................................................
.SS \fBCAESAR_CONVERT_AREA_1\fP
 \&
.nf
\fBCAESAR_TYPE_STRING CAESAR_CONVERT_AREA_1 (CAESAR_CONVERT_FUNCTION, CAESAR_P,
                                          CAESAR_SIZE)
   CAESAR_TYPE_CONVERT_FUNCTION CAESAR_CONVERT_FUNCTION;
   CAESAR_TYPE_POINTER CAESAR_P;
   CAESAR_TYPE_NATURAL CAESAR_SIZE;
   { ... }
\fP
.fi
This function converts the memory area (of \fBCAESAR_SIZE\fP bytes) pointed to by \fBCAESAR_P\fP into a character string using either \fBCAESAR_CONVERT_FUNCTION\fP if this function pointer is not \fBNULL\fP, or function \fBCAESAR_CONVERT_BINARY_AREA_1()\fP otherwise.
.sp
Note: Before calling \fBCAESAR_CONVERT_AREA_1()\fP, the actual value of \fBCAESAR_CONVERT_FUNCTION\fP should have been set by calling the \fBCAESAR_USE_CONVERT_FUNCTION_AREA_1()\fP function.
.sp
.P
 ............................................................
.SS \fBCAESAR_PRINT_EMPTY_AREA_1\fP
 \&
.nf
\fBvoid CAESAR_PRINT_EMPTY_AREA_1 (CAESAR_FILE, CAESAR_P)
   CAESAR_TYPE_FILE CAESAR_FILE;
   CAESAR_TYPE_POINTER CAESAR_P;
   { ... }
\fP
.fi
This procedure prints to file \fBCAESAR_FILE\fP a constant, user-readable character string representing the empty area.
.sp
Before this procedure is called, \fBCAESAR_FILE\fP must have been properly opened, for instance using \fBfopen(3)\fP.
.sp
Note: this function is used by the \fBCAESAR_USE_PRINT_FUNCTION_AREA_1()\fP function described below.
.sp
.P
 ............................................................
.SS \fBCAESAR_PRINT_STRING_AREA_1\fP
 \&
.nf
\fBvoid CAESAR_PRINT_STRING_AREA_1 (CAESAR_FILE, CAESAR_S)
   CAESAR_TYPE_FILE CAESAR_FILE;
   CAESAR_TYPE_STRING *CAESAR_S;
   { ... }
\fP
.fi
This procedure prints to file \fBCAESAR_FILE\fP the character string pointed to by \fB*CAESAR_S\fP.
.sp
Before this procedure is called, \fBCAESAR_FILE\fP must have been properly opened, for instance using \fBfopen(3)\fP.
.sp
Note: this function is used by the \fBCAESAR_USE_PRINT_FUNCTION_AREA_1()\fP function described below.
.sp
.P
 ............................................................
.SS \fBCAESAR_PRINT_BINARY_AREA_1\fP
 \&
.nf
\fBvoid CAESAR_PRINT_BINARY_AREA_1 (CAESAR_FILE, CAESAR_P, CAESAR_SIZE)
   CAESAR_TYPE_FILE CAESAR_FILE;
   CAESAR_TYPE_POINTER CAESAR_P;
   CAESAR_TYPE_NATURAL CAESAR_SIZE;
   { ... }
\fP
.fi
This procedure prints to file \fBCAESAR_FILE\fP the character string corresponding to the hexadecimal representation for the \fBCAESAR_SIZE\fP bytes-long memory chunk pointed to by \fBCAESAR_P\fP.
.sp
Before this procedure is called, \fBCAESAR_FILE\fP must have been properly opened, for instance using \fBfopen(3)\fP.
.sp
Note: this function is used by the \fBCAESAR_PRINT_AREA_1()\fP function described below.
.sp
.P
 ............................................................
.SS \fBCAESAR_USE_PRINT_FUNCTION_AREA_1\fP
 \&
.nf
\fBvoid CAESAR_USE_PRINT_FUNCTION_AREA_1 (CAESAR_AREA, CAESAR_PRINT_FUNCTION)
   CAESAR_TYPE_AREA_1 CAESAR_AREA;
   CAESAR_TYPE_PRINT_FUNCTION *CAESAR_PRINT_FUNCTION;
   { ... }
\fP
.fi
This procedure modifies the (function pointer) value pointed to by \fB*CAESAR_PRINT_FUNCTION\fP (possibly to assign this function pointer a default value if it is equal to \fBNULL\fP before the procedure is invoked) in the following cases:
.sp
.IP -
if \fBCAESAR_AREA\fP is an empty area and if \fB*CAESAR_PRINT_FUNCTION\fP is equal to \fBNULL\fP, then the \fBCAESAR_PRINT_EMPTY_AREA_1()\fP function defined above will be assigned to \fB*CAESAR_PRINT_FUNCTION\fP;
.IP -
if \fBCAESAR_AREA\fP is a state area and if \fB*CAESAR_PRINT_FUNCTION\fP is equal to \fBNULL\fP, then the \fBCAESAR_PRINT_STATE()\fP function of the graph module will be assigned to \fB*CAESAR_PRINT_FUNCTION\fP;
.IP -
if \fBCAESAR_AREA\fP is a label area and if \fB*CAESAR_PRINT_FUNCTION\fP is equal to \fBNULL\fP, then the \fBCAESAR_PRINT_LABEL()\fP function of the graph module will be assigned to \fB*CAESAR_PRINT_FUNCTION\fP;
.IP -
if \fBCAESAR_AREA\fP is a string area and if \fB*CAESAR_PRINT_FUNCTION\fP is equal to \fBNULL\fP, then the \fBCAESAR_PRINT_STRING_AREA_1()\fP function defined above will be assigned to \fB*CAESAR_PRINT_FUNCTION\fP.
.P
In any other case, \fB*CAESAR_PRINT_FUNCTION\fP is kept unchanged.
.sp
.P
 ............................................................
.SS \fBCAESAR_PRINT_AREA_1\fP
 \&
.nf
\fBvoid CAESAR_PRINT_AREA_1 (CAESAR_PRINT_FUNCTION, CAESAR_FILE, CAESAR_P,
                          CAESAR_SIZE)
   CAESAR_TYPE_PRINT_FUNCTION CAESAR_PRINT_FUNCTION;
   CAESAR_TYPE_FILE CAESAR_FILE;
   CAESAR_TYPE_POINTER CAESAR_P;
   CAESAR_TYPE_NATURAL CAESAR_SIZE;
   { ... }
\fP
.fi
This function prints to file \fBCAESAR_FILE\fP a character string representing the memory area (of \fBCAESAR_SIZE\fP bytes) pointed to by \fBCAESAR_P\fP. Printing is done using either \fBCAESAR_PRINT_FUNCTION\fP if this function pointer is not \fBNULL\fP, or function \fBCAESAR_PRINT_BINARY_AREA_1()\fP otherwise.
.sp
Before this procedure is called, \fBCAESAR_FILE\fP must have been properly opened, for instance using \fBfopen(3)\fP.
.sp
Note: Before calling \fBCAESAR_PRINT_AREA_1()\fP, the actual value of \fBCAESAR_PRINT_FUNCTION\fP should have been set by calling the \fBCAESAR_USE_PRINT_FUNCTION_AREA_1()\fP function.
.sp
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
