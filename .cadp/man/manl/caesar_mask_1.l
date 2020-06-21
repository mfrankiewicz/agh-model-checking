'\" t
.\" @(#)caesar_mask_1.l - VASY and CONVECS teams - version 1.1
.TH caesar_mask_1 LOCAL "2020/02/11 (version 1.1)" "(C) INRIA" "OPEN/CAESAR MANUAL"
.fp 4 CB
.lg 0
.SH NAME
caesar_mask_1 \- the ``mask_1'' library of OPEN/CAESAR
.SH PURPOSE
The ``mask_1'' library provides primitives for applying sequences of hiding and renaming operations to memory areas (such as labels) converted to character strings. In particular, this allows to hide and/or rename labels on the fly.
.sp
.sp
.SH USAGE
The ``mask_1'' library consists of:
.IP -
a predefined header file \fBcaesar_mask_1.h\fP;
.IP -
the precompiled library file \fBlibcaesar.a\fP, which implements the features described in \fBcaesar_mask_1.h\fP.
.P
Note: The ``mask_1'' library is a software layer built above the primitives offered by the ``standard'', ``area_1'', ``hide_1'', and ``rename_1'' libraries.
.sp
.sp
.SH DESCRIPTION
The ``mask_1'' library allows to apply successive operations to memory areas (for instance, labels). These operations are, first, the conversion of a memory area to a character string, and then a sequence of hiding and/or renaming operations on the resulting character string.
.sp
Hiding a character string consists in renaming it into the internal action ``i'' (or tau) according to a ``hiding file'', which contains a list of regular expressions. The format of ``hiding files'' is defined in the ``hide_1'' library.
.sp
Renaming consists in applying string substitutions according to a ``renaming file'', which contains a list of substitution patterns defined using regular expressions. The format of ``renaming files'' is defined in the ``rename_1'' library.
.sp
The ``mask_1'' library targets at efficiency. Each hiding file and each renaming file is parsed and checked only once. In addition, a hash-based cache table is available to speed up performance; this table stores the character strings resulting from prior operations performed by the masking object, so as to avoid multiple, redundant computations.
.sp
The ``mask_1'' library introduces the concept of ``masking object'', which is an abstract data structure containing (among others) the following information:
.IP -
a description of the memory areas to be processed, including their size, hash size, comparison function, hashing function, conversion function, and printing procedure;
.IP -
a (possibly empty) ordered list of hiding and renaming operations to be applied sequentially; hiding and renaming operations can be intertwined arbitrarily;
.IP -
an (optional) hash-based cache table and (if applicable) statistical data about caching efficiency.
.P
.sp
.SH FEATURES
.sp
.P
 ............................................................
.SS \fBCAESAR_TYPE_MASK_1\fP
 \&
.nf
\fBtypedef CAESAR_TYPE_ABSTRACT (...) CAESAR_TYPE_MASK_1;
\fP
.fi
This type denotes a pointer to the concrete representation of a masking object, which is supposed to be ``opaque''.
.sp
.P
 ............................................................
.SS \fBCAESAR_CREATE_MASK_1\fP
 \&
.nf
\fBvoid CAESAR_CREATE_MASK_1 (CAESAR_M, CAESAR_AREA, CAESAR_CACHE,
                           CAESAR_CACHE_SIZE, CAESAR_PRIME, CAESAR_COMPARE,
                           CAESAR_HASH, CAESAR_CONVERT, CAESAR_HISTORY)
   CAESAR_TYPE_MASK_1 *CAESAR_M;
   CAESAR_TYPE_AREA_1 CAESAR_AREA;
   CAESAR_TYPE_BOOLEAN CAESAR_CACHE;
   CAESAR_TYPE_NATURAL CAESAR_CACHE_SIZE;
   CAESAR_TYPE_BOOLEAN CAESAR_PRIME;
   CAESAR_TYPE_COMPARE_FUNCTION CAESAR_COMPARE;
   CAESAR_TYPE_HASH_FUNCTION CAESAR_HASH;
   CAESAR_TYPE_CONVERT_FUNCTION CAESAR_CONVERT;
   CAESAR_TYPE_BOOLEAN CAESAR_HISTORY;
   { ... }
\fP
.fi
This procedure allocates a masking object using \fBCAESAR_CREATE()\fP and assigns its address to \fB*CAESAR_M\fP. If the allocation fails or if any error occurs in this procedure, the \fBNULL\fP value is assigned to \fB*CAESAR_M\fP.
.sp
Note: because \fBCAESAR_TYPE_MASK_1\fP is a pointer type, any variable \fBCAESAR_M\fP of type \fBCAESAR_TYPE_MASK_1\fP must be allocated before used, for instance using:
.TS
center;
l.
 
 \fBCAESAR_CREATE_MASK_1 (&CAESAR_M, ...);\fP 
 
.TE
.sp
The value of \fBCAESAR_AREA\fP specifies the kind of memory areas that can be processed by the masking object to be created. All the memory areas handled using a given masking object must be of the same kind and have the same size and alignment.
.sp
The (optional) hash-based cache table is enabled if and only if \fBCAESAR_CACHE\fP is equal to \fBCAESAR_TRUE\fP.
.sp
If the cache table is disabled, the four next parameters \fBCAESAR_CACHE_SIZE\fP, \fBCAESAR_PRIME\fP, \fBCAESAR_COMPARE\fP, and \fBCAESAR_HASH\fP are unused and must be equal to 0, \fBCAESAR_FALSE\fP, \fBNULL\fP, and \fBNULL\fP, respectively; otherwise, the effect of this procedure is undefined. In the sequel, we only consider the case where the cache table is enabled.
.sp
Note: If the value of \fBCAESAR_AREA\fP is equal to \fBCAESAR_STRING_AREA_1 ()\fP, the character strings that will be stored in the masking object pointed to by \fB*CAESAR_M\fP may be of arbitrary length. If the cache table is enabled, the contents of these character strings should remain constant, in the sense that, after a character string is passed as argument to the function \fBCAESAR_APPLY_MASK_1()\fP defined below, its contents should no longer be modified (as the cache table stores only the string pointer, but not the string contents).
.sp
The value of \fBCAESAR_CACHE_SIZE\fP determines the maximal number of areas that can be stored simultaneously in the cache table, together with the corresponding characters strings obtained after applying conversion, hiding, and/or renaming operations.
Whenever a new area is inserted in the cache table and an existing area is already present with the same hash value as the new area, the new area will replace the existing area.
If the value of \fBCAESAR_CACHE_SIZE\fP is equal to zero, it is replaced with a default value greater than zero.
.sp
If the value of \fBCAESAR_PRIME\fP is equal to \fBCAESAR_TRUE\fP and if the value of \fBCAESAR_CACHE_SIZE\fP is not a prime number, this value will be replaced by the nearest smaller prime number (since some hash functions require prime modulus). Otherwise, the value of \fBCAESAR_CACHE_SIZE\fP will be kept unchanged.
.sp
The actual value of the formal parameter \fBCAESAR_COMPARE\fP will be stored and associated to the masking object pointed to by \fB*CAESAR_M\fP. It will be used as a comparison function when it is necessary to decide whether two memory areas are equal or not.
If the actual value of \fBCAESAR_COMPARE\fP is \fBNULL\fP, it may be replaced by a non-\fBNULL\fP default value depending on the value of \fBCAESAR_AREA\fP and according to the rules specified for function \fBCAESAR_USE_COMPARE_FUNCTION_AREA_1()\fP of the ``area_1'' library.
In both cases, all area comparisons will be done using the \fBCAESAR_COMPARE_AREA_1()\fP macro defined in the ``area_1'' library.
.sp
The actual value of the formal parameter \fBCAESAR_HASH\fP will be stored and associated to the masking object pointed to by \fB*CAESAR_M\fP. It will be used as a hashing function when it is necessary to compute a hash-value for a memory area.
If the actual value of \fBCAESAR_HASH\fP is \fBNULL\fP, it may be replaced by a non-\fBNULL\fP default value depending on the value of \fBCAESAR_AREA\fP and according to the rules specified for function \fBCAESAR_USE_HASH_FUNCTION_AREA_1()\fP of the ``area_1'' library.
In both cases, area hashing will be done using the \fBCAESAR_HASH_AREA_1()\fP macro defined in the ``area_1'' library.
.sp
The actual value of the formal parameter \fBCAESAR_CONVERT\fP will be stored and associated to the masking object pointed to by \fB*CAESAR_M\fP. It will be used as a conversion function when it is necessary to translate a memory area into a character string.
If the actual value of \fBCAESAR_CONVERT\fP is \fBNULL\fP, it may be replaced by a non-\fBNULL\fP default value depending on the value of \fBCAESAR_AREA\fP and according to the rules specified for function \fBCAESAR_USE_CONVERT_FUNCTION_AREA_1()\fP of the ``area_1'' library.
In both cases, all area conversions will be done using the \fBCAESAR_CONVERT_AREA_1()\fP macro defined in the ``area_1'' library.
.sp
The value of the formal parameter \fBCAESAR_HISTORY\fP must be equal to \fBCAESAR_TRUE\fP if the user wants to invoke the \fBCAESAR_HISTORY_MASK_1()\fP function defined below.
.sp
Note: the list of hiding and renaming operations associated to the masking object pointed to by \fB*CAESAR_M\fP is not specified at the time the masking object is created but later, using the \fBCAESAR_USE_HIDE_MASK_1()\fP, \fBCAESAR_USE_RENAME_MASK_1()\fP, and \fBCAESAR_PARSE_OPTION_MASK_1()\fP primitives defined below.
.sp
.P
 ............................................................
.SS \fBCAESAR_DELETE_MASK_1\fP
 \&
.nf
\fBvoid CAESAR_DELETE_MASK_1 (CAESAR_M)
   CAESAR_TYPE_MASK_1 *CAESAR_M;
   { ... }
\fP
.fi
This procedure frees the memory space corresponding to the masking object pointed to by \fB*CAESAR_M\fP using \fBCAESAR_DELETE()\fP. Afterwards, the \fBNULL\fP value is assigned to \fB*CAESAR_M\fP.
.sp
.P
 ............................................................
.SS \fBCAESAR_USE_HIDE_MASK_1\fP
 \&
.nf
\fBvoid CAESAR_USE_HIDE_MASK_1 (CAESAR_M, CAESAR_PATHNAME, CAESAR_KIND,
                             CAESAR_FAILED)
   CAESAR_TYPE_MASK_1 CAESAR_M;
   CAESAR_TYPE_STRING CAESAR_PATHNAME;
   CAESAR_TYPE_NATURAL CAESAR_KIND;
   CAESAR_TYPE_BOOLEAN *CAESAR_FAILED;
   { ... }
\fP
.fi
This function adds a new hiding operation at the end of the (initially empty) list of hiding and renaming operations associated to the masking object pointed to by \fBCAESAR_M\fP.
.sp
The hiding operation is specified by the actual values of the formal parameters \fBCAESAR_PATHNAME\fP and \fBCAESAR_KIND\fP, the signification of which is the same as for function \fBCAESAR_CREATE_HIDE_1()\fP of the ``hide_1'' library.
.sp
Note: the additional formal parameters \fBCAESAR_POSITIVE_HEADER\fP and \fBCAESAR_NEGATIVE_HEADER\fP of \fBCAESAR_CREATE_HIDE_1()\fP are not accessible using \fBCAESAR_USE_HIDE_MASK_1()\fP; their default values will be used, meaning that the hiding file referred to by \fBCAESAR_PATHNAME\fP must start with either \fBhide\fP (positive header) or \fBhide all but\fP (negative header).
.sp
If the call to \fBCAESAR_USE_HIDE_MASK_1()\fP fails, (e.g., because the hiding file is incorrect), the boolean pointed to by \fB*CAESAR_FAILED\fP is set to \fBCAESAR_TRUE\fP, and an error message is printed to the standard output. Otherwise, the boolean pointed to by \fB*CAESAR_FAILED\fP it is set to \fBCAESAR_FALSE\fP.
.sp
If the cache table is enabled, its contents are erased after any call to \fBCAESAR_USE_HIDE_MASK_1()\fP, since the results of previous hiding and/or renaming operations performed so far can no longer be reused after a new hiding operation is added. This allows to invoke \fBCAESAR_USE_HIDE_MASK_1()\fP safely, even after a call to the function \fBCAESAR_APPLY_MASK_1()\fP defined below.
.sp
.P
 ............................................................
.SS \fBCAESAR_USE_RENAME_MASK_1\fP
 \&
.nf
\fBvoid CAESAR_USE_RENAME_MASK_1 (CAESAR_M, CAESAR_PATHNAME, CAESAR_KIND,
                               CAESAR_FAILED)
    CAESAR_TYPE_MASK_1 CAESAR_M;
    CAESAR_TYPE_STRING CAESAR_PATHNAME;
    CAESAR_TYPE_NATURAL CAESAR_KIND;
    CAESAR_TYPE_BOOLEAN *CAESAR_FAILED;
    { ... }
\fP
.fi
This function adds a new renaming operation at the end of the (initially empty) list of hiding and renaming operations associated to the masking object pointed to by \fBCAESAR_M\fP.
.sp
The renaming operation is specified by the actual values of the formal parameters \fBCAESAR_PATHNAME\fP and \fBCAESAR_KIND\fP, the signification of which is the same as for function \fBCAESAR_CREATE_RENAME_1()\fP of the ``rename_1'' library.
.sp
Note: the additional formal parameter \fBCAESAR_HEADER\fP of \fBCAESAR_CREATE_RENAME_1()\fP is not accessible using \fBCAESAR_USE_RENAME_MASK_1()\fP; its default value will be used, meaning that the renaming file referred to by \fBCAESAR_PATHNAME\fP must start with \fBrename\fP.
.sp
If the call to \fBCAESAR_USE_RENAME_MASK_1()\fP fails, (e.g., because the renaming file is incorrect), the boolean pointed to by \fB*CAESAR_FAILED\fP is set to \fBCAESAR_TRUE\fP, and an error message is printed to the standard output. Otherwise, the boolean pointed to by \fB*CAESAR_FAILED\fP it is set to \fBCAESAR_FALSE\fP.
.sp
If the cache table is enabled, its contents are erased after any call to \fBCAESAR_USE_RENAME_MASK_1()\fP, since the results of previous hiding and/or renaming operations performed so far can no longer be reused after a new renaming operation is added. This allows to invoke \fBCAESAR_USE_RENAME_MASK_1()\fP safely, even after a call to the function \fBCAESAR_APPLY_MASK_1()\fP defined below.
.sp
.P
 ............................................................
.SS \fBCAESAR_PARSE_OPTION_MASK_1\fP
 \&
.nf
\fBvoid CAESAR_PARSE_OPTION_MASK_1 (CAESAR_M, CAESAR_ARGC, CAESAR_ARGV,
                                 CAESAR_NB_TOKENS)
   CAESAR_TYPE_MASK_1 CAESAR_M;
   CAESAR_TYPE_ARGC CAESAR_ARGC;
   CAESAR_TYPE_ARGV CAESAR_ARGV;
   CAESAR_TYPE_GENUINE_INT *CAESAR_NB_TOKENS;
   { ... }
\fP
.fi
This procedure parses the command-line options specified by parameters \fBCAESAR_ARGC\fP and \fBCAESAR_ARGV\fP and, if specific options defining a hiding or renaming operation are recognized, the corresponding hiding or renaming operation is added to the masking object pointed to by \fBCAESAR_M\fP; this addition is done by invoking the \fBCAESAR_USE_HIDE_MASK_1()\fP or \fBCAESAR_USE_RENAME_MASK_1()\fP procedure internally.
.sp
The parameters \fBCAESAR_ARGC\fP and \fBCAESAR_ARGV\fP specify a list of character strings (named options). They follow the standard conventions regarding the \fBargc\fP and \fBargv\fP parameters of the \fBmain()\fP function of any C program.
\fBCAESAR_ARGC\fP denotes the number of options and \fBCAESAR_ARGV\fP is a character string array containing the options.
.sp
A hiding operation is defined by the following sequence of command-line options:
.TS
center;
l.
 
 \fB-hide [ -total | -partial | -gate ]\fP \fIhiding_filename\fP 
 
.TE
where \fIhiding_filename\fP is the pathname of a hiding file (the format of this file is described in the ``hide_1'' library), and where the optional \fB-total\fP, \fB-partial\fP, and \fB-gate\fP options correspond, respectively, to the ``total matching'', ``partial matching'', and ``gate matching'' semantics defined in the documentation of the ``hide_1'' library; option \fB-total\fP is the default.
.sp
A renaming operation is defined by the following sequence of command-line options:
.TS
center;
l.
 
 \fB-rename [ -total | -single | -multiple | -gate ]\fP \fIrenaming_filename\fP 
 
.TE
where \fIrenaming_filename\fP is the pathname of a renaming file (the format of this file is described in the ``rename_1'' library), and where the optional \fB-total\fP, \fB-single\fP, \fB-multiple\fP, and \fB-gate\fP options correspond, respectively, to the ``total matching'', ``single partial matching'', ``multiple partial matching'', and ``gate matching'' semantics defined in the documentation of the ``rename_1'' library; option \fB-total\fP is the default.
.sp
The \fBCAESAR_PARSE_OPTION_MASK_1()\fP procedure processes command-line options from left to right. One single call to \fBCAESAR_PARSE_OPTION_MASK_1()\fP recognizes at most one (hiding or renaming) operation. Thus, \fBCAESAR_PARSE_OPTION_MASK_1()\fP should be used within a program loop in which \fBCAESAR_ARGC\fP is decremented and \fBCAESAR_ARGV\fP is incremented as hiding or renaming options are recognized.
.sp
An integer value is assigned to \fB*CAESAR_NB_TOKENS\fP in order to indicate how many command-line options have been recognized and processed. The conventions are the following:
.sp
.IP -
If \fB*CAESAR_NB_TOKENS\fP is a strictly positive integer N, the N-th first options have been recognized as forming either a hiding operation or a renaming operation. In this case, \fBCAESAR_ARGC\fP will need to be decremented by N and \fBCAESAR_ARGV\fP will need to be incremented by N.
.IP -
If \fB*CAESAR_NB_TOKENS\fP is equal to 0, then the first option of \fBCAESAR_ARGV\fP has not been recognized as forming either a hiding operation or a renaming operation.
.IP -
If \fB*CAESAR_NB_TOKENS\fP is strictly negative, the first options have been recognized as forming (at least, the beginning of) either a hiding operation or renaming operation, but some error occured while processing these options (e.g., incorrect option syntax, unreadable hiding or renaming file, memory shortage, ...). In this case, an error message will be printed to the standard output. This situation is usually considered as a fatal error.
.P
.sp
.P
 ............................................................
.SS \fBCAESAR_APPLY_MASK_1\fP
 \&
.nf
\fBCAESAR_TYPE_STRING CAESAR_APPLY_MASK_1 (CAESAR_M, CAESAR_P)
   CAESAR_TYPE_MASK_1 CAESAR_M;
   CAESAR_TYPE_POINTER CAESAR_P;
   { ... }
\fP
.fi
This function first converts the memory area pointed to by \fBCAESAR_P\fP into a character string S using the conversion function associated to the masking object pointed to by \fBCAESAR_M\fP.
.sp
Then, this function applies, in sequence, to S the list of hiding and/or renaming operations associated to the masking object pointed to by \fBCAESAR_M\fP and returns the resulting character string.
.sp
Note: hiding is done using the \fBCAESAR_TEST_HIDE_1()\fP function of the ``hide_1'' library, a hidden character string being renamed into the constant character string \fB"i"\fP.
.sp
Note: renaming is done using the \fBCAESAR_TEST_RENAME_1()\fP operation of the ``rename_1'' library.
.sp
The order in which hiding and/or renaming operations are applied is the same as the order in which the procedures \fBCAESAR_USE_HIDE_MASK_1()\fP and/or \fBCAESAR_USE_RENAME_MASK_1()\fP have been called, successively, for the masking object pointed to by \fBCAESAR_M\fP.
If the list of operations is empty (i.e., if no calls to \fBCAESAR_USE_HIDE_1()\fP nor to \fBCAESAR_USE_RENAME_1()\fP have occurred), then the result is simply S.
.sp
Note: if enabled, the cache table will be used to speed up the execution of \fBCAESAR_APPLY_MASK_1()\fP.
.sp
Note: if the cache table is enabled and if the masking object was created to handle string areas, meaning that the \fBCAESAR_AREA\fP parameter of \fBCAESAR_CREATE_MASK_1()\fP was equal to \fBCAESAR_STRING_AREA_1()\fP, then \fB*CAESAR_P\fP is a pointer to a null-terminated character string. The contents of this string must remain constant, i.e., it is forbidden to modify them after invoking of \fBCAESAR_APPLY_MASK_1{\fP} until the masking object is deleted.
.sp
Note: as regards side effects, the contents of \fBCAESAR_M\fP and \fBCAESAR_P\fP are not modified, except for the cache table associated to \fBCAESAR_M\fP, if any, which might be modified by a call to to \fBCAESAR_APPLY_MASK_1()\fP.
.sp
Note: it is not allowed to modify the character string returned by \fBCAESAR_APPLY_MASK_1()\fP nor to free it, for instance using \fBfree(3)\fP.
.sp
Note: the contents of the character string returned by \fBCAESAR_APPLY_MASK_1()\fP may be destroyed by a subsequent call to this function.
.sp
.P
 ............................................................
.SS \fBCAESAR_LABEL_HIDE_FORMAT_MASK_1\fP
 \&
.nf
\fB#define CAESAR_LABEL_HIDE_FORMAT_MASK_1 "   with labels hidden using \e"%s\e""
\fP
.fi
This macro-definition returns the default value used for the parameter \fBCAESAR_HIDE_FORMAT\fP of function \fBCAESAR_HISTORY_MASK_1()\fP when the actual value given to this parameter is \fBNULL\fP.
.sp
.P
 ............................................................
.SS \fBCAESAR_LABEL_RENAME_FORMAT_MASK_1\fP
 \&
.nf
\fB#define CAESAR_LABEL_RENAME_FORMAT_MASK_1 "   with labels renamed using \e"%s\e""
\fP
.fi
This macro-definition returns the default value used for the parameter \fBCAESAR_RENAME_FORMAT\fP of function \fBCAESAR_HISTORY_MASK_1()\fP when the actual value given to this parameter is \fBNULL\fP.
.sp
.P
 ............................................................
.SS \fBCAESAR_HISTORY_MASK_1\fP
 \&
.nf
\fBCAESAR_TYPE_STRING CAESAR_HISTORY_MASK_1 (CAESAR_M, CAESAR_PREFIX,
                                          CAESAR_HIDE_FORMAT,
                                          CAESAR_RENAME_FORMAT,
                                          CAESAR_SUFFIX, CAESAR_SEPARATOR)
   CAESAR_TYPE_MASK_1 CAESAR_M;
   CAESAR_TYPE_STRING CAESAR_PREFIX;
   CAESAR_TYPE_STRING CAESAR_HIDE_FORMAT;
   CAESAR_TYPE_STRING CAESAR_RENAME_FORMAT;
   CAESAR_TYPE_STRING CAESAR_SUFFIX;
   CAESAR_TYPE_STRING CAESAR_SEPARATOR;
   { ... }
\fP
.fi
If the masking object pointed to by \fBCAESAR_M\fP was created by a call to \fBCAESAR_CREATE_MASK_1()\fP in which the value of the \fBCAESAR_HISTORY\fP parameter was equal to \fBCAESAR_FALSE\fP, the effect of this function is undefined.
.sp
Otherwise, this function allocates and returns a character string S summarizing the list of hiding and/or renaming operations associated to the masking object pointed to by \fBCAESAR_M\fP. If allocation fails, then S will be equal to \fBNULL\fP; if not, S will consist of several components:
.sp
.IP -
If the character string pointed to by \fBCAESAR_PREFIX\fP is different from \fBNULL\fP, it will form the first component of S.
.IP -
Then, for each hiding or renaming operation associated to the masking object, a corresponding component will be appended to S; these operations are considered in the order in which the \fBCAESAR_USE_HIDE_MASK_1()\fP and \fBCAESAR_USE_RENAME_MASK_1()\fP procedures have been called.
.sp
For a hiding operation, the corresponding component is given by the character string pointed to by \fBCAESAR_HIDE_FORMAT\fP. This character string follows the same conventions as a format string given to the \fBprintf(3)\fP function.
However, this string may contain at most one \fB%s\fP pattern, which will be substituted by the pathname of the hiding file associated to the operation. It should not contain any other pattern such as \fB%d\fP, \fB%x\fP, or even \fB%32s\fP. If \fBCAESAR_HIDE_FORMAT\fP is equal to \fBNULL\fP, it will be replaced by its default value \fBCAESAR_LABEL_HIDE_FORMAT_MASK_1\fP.
.sp
For a renaming operation, the corresponding component is given by the character string pointed to by \fBCAESAR_RENAME_FORMAT\fP. This character string follows the same conventions as a format string given to the \fBprintf(3)\fP function.
However, this string may contain at most one \fB%s\fP pattern, which will be substituted by the pathname of the renaming file associated to the operation. It should not contain any other pattern such as \fB%d\fP, \fB%x\fP, or even \fB%32s\fP. If \fBCAESAR_RENAME_FORMAT\fP is equal to \fBNULL\fP, it will be replaced by its default value \fBCAESAR_LABEL_RENAME_FORMAT_MASK_1\fP.
.IP -
If the character string pointed to by \fBCAESAR_SUFFIX\fP is different from \fBNULL\fP, it will form the last component of S.
.IP -
The character string pointed to by \fBCAESAR_SEPARATOR\fP (or, if \fBCAESAR_SEPARATOR\fP is \fBNULL\fP, the default string \fB"\fP\e\fBn"\fP) will be inserted as a separator between every two components of S.
.P
Note: The resulting character string S is allocated using \fBCAESAR_CREATE()\fP and should be freed as soon as possible using \fBCAESAR_DELETE()\fP.
.sp
.P
 ............................................................
.SS \fBCAESAR_FAILURE_MASK_1\fP
 \&
.nf
\fBvoid CAESAR_FAILURE_MASK_1 (CAESAR_M)
   CAESAR_TYPE_MASK_1 CAESAR_M;
   { ... }
\fP
.fi
This function returns the value of the failure counter (i.e., the number of searches that failed) of the cache table associated to the masking object pointed to by \fBCAESAR_M\fP.
.sp
If the cache table is not enabled in the masking object, the effect of this function is undefined.
.sp
.P
 ............................................................
.SS \fBCAESAR_SUCCESS_MASK_1\fP
 \&
.nf
\fBvoid CAESAR_SUCCESS_MASK_1 (CAESAR_M)
   CAESAR_TYPE_MASK_1 CAESAR_M;
   { ... }
\fP
.fi
This function returns the value of the success counter (i.e., the number of searches that succeeded) of the cache table associated to the masking object pointed to by \fBCAESAR_M\fP.
.sp
If the cache table is not enabled in the masking object, the effect of this function is undefined.
.sp
.P
 ............................................................
.SS \fBCAESAR_FORMAT_MASK_1\fP
 \&
.nf
\fBCAESAR_TYPE_FORMAT CAESAR_FORMAT_MASK_1 (CAESAR_M, CAESAR_FORMAT)
   CAESAR_TYPE_MASK_1 CAESAR_M;
   CAESAR_TYPE_FORMAT CAESAR_FORMAT;
   { ... }
\fP
.fi
This function allows to control the format under which the masking object pointed to by \fBCAESAR_M\fP will be printed by the procedure \fBCAESAR_PRINT_MASK_1()\fP (see below). Currently, the following formats are available:
.sp
.IP -
With format 0, statistical information about the masking object is displayed such as: the area size (in bytes), the area hashable size (in bytes), the area comparison function, the area hash function, the area conversion function, etc. The cache size is also displayed together with, if it is different from zero, the number of searches that failed and succeeded.
.IP -
With format 1, the list of operations performed by the masking object is displayed using the procedures \fBCAESAR_PRINT_HIDE_1()\fP and \fBCAESAR_PRINT_RENAME_1()\fP exported by the ``hide_1'' and ``rename_1'' libraries (these procedures are called with their respective formats set to 0).
.IP -
With format 2, the contents of the cache table are displayed if the cache table is enabled.
.IP -
(no other format available yet).
.P
By default, the current format of each masking object is initialized to 0.
.sp
When called with \fBCAESAR_FORMAT\fP between 0 and 2, this fonction sets the current format of \fBCAESAR_M\fP to \fBCAESAR_FORMAT\fP and returns an undefined result.
.sp
When called with another value of \fBCAESAR_FORMAT\fP, this function does not modify the current format of \fBCAESAR_M\fP but returns a result defined as follows. If \fBCAESAR_FORMAT\fP is equal to the constant \fBCAESAR_CURRENT_FORMAT\fP, the result is the value of the current format of \fBCAESAR_M\fP. If \fBCAESAR_FORMAT\fP is equal to the constant \fBCAESAR_MAXIMAL_FORMAT\fP, the result is the maximal format value (i.e., 2). In all other cases, the effect of this function is undefined.
.sp
.P
 ............................................................
.SS \fBCAESAR_MAX_FORMAT_MASK_1\fP
 \&
.nf
\fBCAESAR_TYPE_FORMAT CAESAR_MAX_FORMAT_MASK_1 ()
   { ... }
\fP
.fi
Caution! This function is deprecated. It should no longer be used, as it might be removed from future versions of the \fIOPEN/CAESAR\fP. Use function \fBCAESAR_FORMAT_MASK_1()\fP instead, called with argument \fBCAESAR_MAXIMAL_FORMAT\fP.
.sp
This function returns the maximal format value available for printing masking objects.
.sp
.P
 ............................................................
.SS \fBCAESAR_PRINT_MASK_1\fP
 \&
.nf
\fBvoid CAESAR_PRINT_MASK_1 (CAESAR_FILE, CAESAR_M)
   CAESAR_TYPE_FILE CAESAR_FILE;
   CAESAR_TYPE_MASK_1 CAESAR_M;
   { ... }
\fP
.fi
This procedure prints to file \fBCAESAR_FILE\fP a text containing information about the masking object pointed to by \fBCAESAR_M\fP. The nature of the information is determined by the current format of the masking object pointed to by \fBCAESAR_M\fP.
.sp
Before this procedure is called, \fBCAESAR_FILE\fP must have been properly opened, for instance using \fBfopen(3)\fP.
.sp
.P
 ............................................................
.SH AUTHOR(S)
Nicolas Descoubes and Hubert Garavel
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
