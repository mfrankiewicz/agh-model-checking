'\" t
.\" @(#)caesar_hash.l - VASY and CONVECS teams - version 1.3
.TH caesar_hash LOCAL "2020/02/11 (version 1.3)" "(C) INRIA" "OPEN/CAESAR MANUAL"
.fp 4 CB
.lg 0
.SH NAME
caesar_hash \- the ``hash'' library of OPEN/CAESAR
.SH PURPOSE
The ``hash'' library provides primitives for computing various hashing functions on byte strings, states and labels.
.sp
.sp
.SH USAGE
The ``hash'' library consists of:
.IP -
a predefined header file \fBcaesar_hash.h\fP;
.IP -
the precompiled library file \fBlibcaesar.a\fP, which implements the features described in \fBcaesar_hash.h\fP.
.P
Note: The ``hash'' library is a software layer built above the primitives offered by the ``standard'' library and by the \fIOPEN/CAESAR\fP graph module.
.sp
.sp
.SH FEATURES
.P
 ............................................................
.SS \fBCAESAR_PRIME_HASH\fP
 \&
.nf
\fBCAESAR_TYPE_BOOLEAN CAESAR_PRIME_HASH (CAESAR_I)
  CAESAR_TYPE_NATURAL CAESAR_I;
  { ... }
\fP
.fi
This function returns a value different from 0 if \fBCAESAR_I\fP is a prime number, or 0 otherwise.
.sp
.P
 ............................................................
.SS \fBCAESAR_0_HASH\fP
 \&
.nf
\fBCAESAR_TYPE_NATURAL CAESAR_0_HASH (CAESAR_P, CAESAR_SIZE, CAESAR_MODULUS)
   CAESAR_TYPE_POINTER CAESAR_P;
   CAESAR_TYPE_NATURAL CAESAR_SIZE;
   CAESAR_TYPE_NATURAL CAESAR_MODULUS;
   { ... }
\fP
.fi
This function computes a hash-value for the byte string of length \fBCAESAR_SIZE\fP pointed to by \fBCAESAR_P\fP, and returns this value, which is in the range 0..(\fBCAESAR_MODULUS\fP-1). If either \fBCAESAR_SIZE\fP or \fBCAESAR_MODULUS\fP is equal to 0, the result is undefined.
.sp
Note: The string is exactly \fBCAESAR_SIZE\fP bytes long, starting from \fBCAESAR_P\fP [0] to \fBCAESAR_P\fP [\fBCAESAR_SIZE\fP - 1]. It is not required that the byte string is terminated by a null byte (which is not the case of character strings in C). The same remark applies to the other functions defined below.
.sp
.P
 ............................................................
.SS \fBCAESAR_1_HASH\fP
 \&
.nf
\fBCAESAR_TYPE_NATURAL CAESAR_1_HASH (CAESAR_P, CAESAR_SIZE, CAESAR_MODULUS)
   CAESAR_TYPE_POINTER CAESAR_P;
   CAESAR_TYPE_NATURAL CAESAR_SIZE;
   CAESAR_TYPE_NATURAL CAESAR_MODULUS;
   { ... }
\fP
.fi
This function computes a hash-value for the byte string of length \fBCAESAR_SIZE\fP pointed to by \fBCAESAR_P\fP, and returns this value, which is in the range 0..(\fBCAESAR_MODULUS\fP-1). If either \fBCAESAR_SIZE\fP or \fBCAESAR_MODULUS\fP is equal to 0, the result is undefined.
.sp
Note: This function is derived from the hash function \fBs_hash()\fP formerly used in the SPIN validation system (see Gerard Holzmann's book ``Design and Validation of Computer Protocols'', 1991, page 307). The result of \fBs_hash()\fP is also the same as the one returned in global variable \fBJ1\fP by the other hash function \fBd_hash()\fP.
The \fBCAESAR_1_HASH()\fP function is more general than \fBs_hash()\fP since it was extended to 64-bit machines and since it does not assume that \fBCAESAR_SIZE\fP is a power of four and that \fBCAESAR_MODULUS\fP is a power of two. It also attempts to solve portability issues that occur in \fBs_hash()\fP. Yet, it may be slower than \fBs_hash()\fP.
.sp
Note: The result returned by this function may differ accross different machines, since it depends on machine endianness.
.sp
.P
 ............................................................
.SS \fBCAESAR_2_HASH\fP
 \&
.nf
\fBCAESAR_TYPE_NATURAL CAESAR_2_HASH (CAESAR_P, CAESAR_SIZE, CAESAR_MODULUS)
   CAESAR_TYPE_POINTER CAESAR_P;
   CAESAR_TYPE_NATURAL CAESAR_SIZE;
   CAESAR_TYPE_NATURAL CAESAR_MODULUS;
   { ... }
\fP
.fi
This function computes a hash-value for the byte string of length \fBCAESAR_SIZE\fP pointed to by \fBCAESAR_P\fP, and returns this value, which is in the range 0..(\fBCAESAR_MODULUS\fP-1). If either \fBCAESAR_SIZE\fP or \fBCAESAR_MODULUS\fP is equal to 0, the result is undefined.
.sp
Note: This function is derived from the hash function \fBd_hash()\fP formerly used in the SPIN validation system (see Gerard Holzmann's book ``Design and Validation of Computer Protocols'', 1991, page 307) with respect to the result returned in global variable \fBJ2\fP.
The \fBCAESAR_2_HASH()\fP function is more general than \fBd_hash()\fP since it was extended to 64-bit machines and since it does not assume that \fBCAESAR_SIZE\fP is a power of four and that \fBCAESAR_MODULUS\fP is a power of two. It also attempts to solve portability issues that occur in \fBd_hash()\fP. Yet, it may be slower than \fBd_hash()\fP.
.sp
Note: The result returned by this function may differ accross different machines, since it depends on machine endianness.
.sp
.P
 ............................................................
.SS \fBCAESAR_3_HASH\fP
 \&
.nf
\fBCAESAR_TYPE_NATURAL CAESAR_3_HASH (CAESAR_P, CAESAR_SIZE, CAESAR_MODULUS)
   CAESAR_TYPE_POINTER CAESAR_P;
   CAESAR_TYPE_NATURAL CAESAR_SIZE;
   CAESAR_TYPE_NATURAL CAESAR_MODULUS;
   { ... }
\fP
.fi
This function computes a hash-value for the byte string of length \fBCAESAR_SIZE\fP pointed to by \fBCAESAR_P\fP, and returns this value, which is in the range 0..(\fBCAESAR_MODULUS\fP-1). If either \fBCAESAR_SIZE\fP or \fBCAESAR_MODULUS\fP is equal to 0, the result is undefined.
.sp
.P
 ............................................................
.SS \fBCAESAR_4_HASH\fP
 \&
.nf
\fBCAESAR_TYPE_NATURAL CAESAR_4_HASH (CAESAR_P, CAESAR_SIZE, CAESAR_MODULUS)
   CAESAR_TYPE_POINTER CAESAR_P;
   CAESAR_TYPE_NATURAL CAESAR_SIZE;
   CAESAR_TYPE_NATURAL CAESAR_MODULUS;
   { ... }
\fP
.fi
This function computes a hash-value for the byte string of length \fBCAESAR_SIZE\fP pointed to by \fBCAESAR_P\fP, and returns this value, which is in the range 0..(\fBCAESAR_MODULUS\fP-1). If either \fBCAESAR_SIZE\fP or \fBCAESAR_MODULUS\fP is equal to 0, the result is undefined.
.sp
Note: This function is derived from the PJW algorithm given in "Compilers: Principles, Techniques, and Tools" by Alfred V. Aho, Ravi Sethi, and Jeffrey D. Ullman, [pp. 434-438], which was used primarly for compressing character strings.
The \fBCAESAR_4_HASH()\fP function removes a limitation of the original PJW algorithm, which always returns a hash value on 24 bits only. If \fBCAESAR_MODULUS\fP is larger than 24 bits, the result of \fBCAESAR_4_HASH()\fP might be also larger than 24 bits.
.sp
.P
 ............................................................
.SS \fBCAESAR_5_HASH\fP
 \&
.nf
\fBCAESAR_TYPE_NATURAL CAESAR_5_HASH (CAESAR_P, CAESAR_SIZE, CAESAR_MODULUS)
   CAESAR_TYPE_POINTER CAESAR_P;
   CAESAR_TYPE_NATURAL CAESAR_SIZE;
   CAESAR_TYPE_NATURAL CAESAR_MODULUS;
   { ... }
\fP
.fi
This function computes a hash-value for the byte string of length \fBCAESAR_SIZE\fP pointed to by \fBCAESAR_P\fP, and returns this value, which is in the range 0..(\fBCAESAR_MODULUS\fP-1). If either \fBCAESAR_SIZE\fP or \fBCAESAR_MODULUS\fP is equal to 0, the result is undefined.
.sp
Note: This function performs simple computations based upon XOR operations and bit shifts.
.sp
.P
 ............................................................
.SS \fBCAESAR_6_HASH\fP
 \&
.nf
\fBCAESAR_TYPE_NATURAL CAESAR_6_HASH (CAESAR_P, CAESAR_SIZE, CAESAR_MODULUS)
   CAESAR_TYPE_POINTER CAESAR_P;
   CAESAR_TYPE_NATURAL CAESAR_SIZE;
   CAESAR_TYPE_NATURAL CAESAR_MODULUS;
   { ... }
\fP
.fi
This function computes a hash-value for the byte string of length \fBCAESAR_SIZE\fP pointed to by \fBCAESAR_P\fP, and returns this value, which is in the range 0..(\fBCAESAR_MODULUS\fP-1). If either \fBCAESAR_SIZE\fP or \fBCAESAR_MODULUS\fP is equal to 0, the result is undefined.
.sp
.P
 ............................................................
.SS \fBCAESAR_7_HASH\fP
 \&
.nf
\fBCAESAR_TYPE_NATURAL CAESAR_7_HASH (CAESAR_P, CAESAR_SIZE, CAESAR_MODULUS)
   CAESAR_TYPE_POINTER CAESAR_P;
   CAESAR_TYPE_NATURAL CAESAR_SIZE;
   CAESAR_TYPE_NATURAL CAESAR_MODULUS;
   { ... }
\fP
.fi
This function computes a hash-value for the byte string of length \fBCAESAR_SIZE\fP pointed to by \fBCAESAR_P\fP, and returns this value, which is in the range 0..(\fBCAESAR_MODULUS\fP-1). If either \fBCAESAR_SIZE\fP or \fBCAESAR_MODULUS\fP is equal to 0, the result is undefined.
.sp
Note: This function is derived from the hash functions proposed by Bob Jenkins, namely \fBlookup2()\fP for 32-bit machines and \fBlookup8()\fP for 64-bit machines.
.sp
.P
 ............................................................
.SS \fBCAESAR_STATE_0_HASH\fP
 \&
.nf
\fBCAESAR_TYPE_NATURAL CAESAR_STATE_0_HASH (CAESAR_S, CAESAR_MODULUS)
   CAESAR_TYPE_STATE CAESAR_S;
   CAESAR_TYPE_NATURAL CAESAR_MODULUS;
   { ... }
\fP
.fi
This function computes a hash-value for the state pointed to by \fBCAESAR_S\fP and returns this value, which is in the range 0..(\fBCAESAR_MODULUS\fP-1). If \fBCAESAR_MODULUS\fP is equal to 0, the result is undefined.
.sp
This function is defined by the following equality:
.sp
 \&
.nf
\fB   CAESAR_STATE_0_HASH (CAESAR_S, CAESAR_MODULUS) =
   CAESAR_HASH_STATE (CAESAR_S, CAESAR_MODULUS)
\fP
.fi
where \fBCAESAR_HASH_STATE()\fP is the hashing function exported by the graph module.
.sp
.P
 ............................................................
.SS \fBCAESAR_STATE_1_HASH\fP
 \&
.nf
\fBCAESAR_TYPE_NATURAL CAESAR_STATE_1_HASH (CAESAR_S, CAESAR_MODULUS)
   CAESAR_TYPE_STATE CAESAR_S;
   CAESAR_TYPE_NATURAL CAESAR_MODULUS;
   { ... }
\fP
.fi
This function computes a hash-value for the state pointed to by \fBCAESAR_S\fP and returns this value, which is in the range 0..(\fBCAESAR_MODULUS\fP-1). If \fBCAESAR_MODULUS\fP is equal to 0, the result is undefined.
.sp
This function is defined by the following equality:
.sp
 \&
.nf
\fB   CAESAR_STATE_1_HASH (CAESAR_S, CAESAR_MODULUS) =
   CAESAR_1_HASH (CAESAR_S, CAESAR_HASH_SIZE_STATE (), CAESAR_MODULUS)
\fP
.fi
Additional functions
.sp
 \&
.nf
\fB   CAESAR_STATE_2_HASH (CAESAR_S, CAESAR_MODULUS)
   CAESAR_STATE_3_HASH (CAESAR_S, CAESAR_MODULUS)
   CAESAR_STATE_4_HASH (CAESAR_S, CAESAR_MODULUS)
   CAESAR_STATE_5_HASH (CAESAR_S, CAESAR_MODULUS)
   CAESAR_STATE_6_HASH (CAESAR_S, CAESAR_MODULUS)
   CAESAR_STATE_7_HASH (CAESAR_S, CAESAR_MODULUS)
\fP
.fi
are defined in the same way as \fBCAESAR_STATE_1_HASH()\fP.
.sp
.P
 ............................................................
.SS \fBCAESAR_LABEL_0_HASH\fP
 \&
.nf
\fBCAESAR_TYPE_NATURAL CAESAR_LABEL_0_HASH (CAESAR_L, CAESAR_MODULUS)
   CAESAR_TYPE_LABEL CAESAR_L;
   CAESAR_TYPE_NATURAL CAESAR_MODULUS;
   { ... }
\fP
.fi
This function computes a hash-value for the label pointed to by \fBCAESAR_L\fP and returns this value, which is in the range 0..(\fBCAESAR_MODULUS\fP-1). If \fBCAESAR_MODULUS\fP is equal to 0, the result is undefined.
.sp
This function is defined by the following equality:
.sp
 \&
.nf
\fB   CAESAR_LABEL_0_HASH (CAESAR_L, CAESAR_MODULUS) =
   CAESAR_HASH_LABEL (CAESAR_L, CAESAR_MODULUS)
\fP
.fi
where \fBCAESAR_HASH_LABEL()\fP is the hashing function exported by the graph module.
.sp
.P
 ............................................................
.SS \fBCAESAR_LABEL_1_HASH\fP
 \&
.nf
\fBCAESAR_TYPE_NATURAL CAESAR_LABEL_1_HASH (CAESAR_L, CAESAR_MODULUS)
   CAESAR_TYPE_LABEL CAESAR_L;
   CAESAR_TYPE_NATURAL CAESAR_MODULUS;
   { ... }
\fP
.fi
This function computes a hash-value for the label pointed to by \fBCAESAR_L\fP and returns this value, which is in the range 0..(\fBCAESAR_MODULUS\fP-1). If \fBCAESAR_MODULUS\fP is equal to 0, the result is undefined.
.sp
This function is defined by the following equality:
.sp
 \&
.nf
\fB   CAESAR_LABEL_1_HASH (CAESAR_L, CAESAR_MODULUS) =
   CAESAR_1_HASH (CAESAR_L, CAESAR_HASH_SIZE_LABEL (), CAESAR_MODULUS)
\fP
.fi
Additional functions
.sp
 \&
.nf
\fB   CAESAR_LABEL_2_HASH (CAESAR_L, CAESAR_MODULUS)
   CAESAR_LABEL_3_HASH (CAESAR_L, CAESAR_MODULUS)
   CAESAR_LABEL_4_HASH (CAESAR_L, CAESAR_MODULUS)
   CAESAR_LABEL_5_HASH (CAESAR_L, CAESAR_MODULUS)
   CAESAR_LABEL_6_HASH (CAESAR_L, CAESAR_MODULUS)
   CAESAR_LABEL_7_HASH (CAESAR_L, CAESAR_MODULUS)
\fP
.fi
are defined in the same way as \fBCAESAR_LABEL_1_HASH()\fP.
.sp
.P
 ............................................................
.SS \fBCAESAR_STRING_0_HASH\fP
 \&
.nf
\fBCAESAR_TYPE_NATURAL CAESAR_STRING_0_HASH (CAESAR_S, CAESAR_MODULUS)
   CAESAR_TYPE_STRING CAESAR_S;
   CAESAR_TYPE_NATURAL CAESAR_MODULUS;
   { ... }
\fP
.fi
This function computes a hash-value for the (variable-length, null-terminated) character string pointed to by \fBCAESAR_S\fP and returns this value, which is in the range 0..(\fBCAESAR_MODULUS\fP-1). If \fBCAESAR_MODULUS\fP is equal to 0, the result is undefined.
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
.sp
