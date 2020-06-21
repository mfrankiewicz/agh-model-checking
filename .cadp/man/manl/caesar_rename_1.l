'\" t
.\" @(#)caesar_rename_1.l - VASY and CONVECS teams - version 1.1
.TH caesar_rename_1 LOCAL "2020/02/11 (version 1.1)" "(C) INRIA" "OPEN/CAESAR MANUAL"
.fp 4 CB
.lg 0
.SH NAME
caesar_rename_1 \- the ``rename_1'' library of OPEN/CAESAR
.SH PURPOSE
The ``rename_1'' library provides primitives for processing ``renaming files''. These files specify which labels of a graph should be renamed, and how to rename them, using a set of regular expressions.
.sp
.SH USAGE
The ``rename_1'' library consists of:
.IP -
a predefined header file \fBcaesar_rename_1.h\fP;
.IP -
the precompiled library file \fBlibcaesar.a\fP, which implements
the features described in \fBcaesar_rename_1.h\fP.
.P
Note: The ``rename_1'' library is a software layer built above the primitives offered by the ``standard'' library.
.sp
.SH RENAMING FILES
In this section, we define the format of renaming files, as they are used in the \fICADP\fP toolbox. The next sections will explain how the ``renaming_1'' library of \fIOPEN/CAESAR\fP supports (and extends) this format.
.sp
A renaming file is a text file containing a set of ``renaming patterns''. There is no mandatory suffix (i.e., file extension) for renaming files: any file name can be used; however, it is recommended to use one of the following suffixes ``.ren'' (recommended) or ``.rename''.
.sp
The syntax of renaming files is described by the following context-free grammar:
.sp
 \&
.nf
\fB     <axiom> ::= <blanks> <header> <blanks> \en <renaming-list>
 
     <header> ::= rename
 
     <renaming-list> ::= <empty>
                      |  <renaming> <renaming-list>
 
     <renaming> ::= <left-pattern> -> <right-pattern> \en
 
     <left-pattern> ::= <blanks> <left-regexp> <blanks>
                     |  <blanks> "<left-regexp>" <blanks>
 
     <right-pattern> ::= <blanks> <right-regexp> <blanks>
                      |  <blanks> "<right-regexp>" <blanks>
\fP
.fi
where:
.sp
.IP -
\e\fBn\fP denotes the newline character;
.IP -
\fB<blanks>\fP is any sequence of spaces, tabulations, carriage returns, newlines, vertical tabulations, or form feeds; these characters are those recognised by the POSIX function \fBisspace()\fP; they are always skipped and ignored;
.IP -
\fB<empty>\fP denotes the empty sequence;
.IP -
\fB<left-regexp>\fP is a character string specifying a regular expression according to the definition given in the \fBregexp\fP(LOCAL) manual page. The \fB<left-regexp>\fP may be enclosed between double quotes, which will be removed and ignored.
.IP -
\fB<right-regexp>\fP is a character string specifying a ``replacement'' expression according to the definition given in the manual page of the POSIX \fBregexp(LOCAL)\fP command. The \fB<right-regexp>\fP can be surrounded by double quotes, which will be removed and ignored.
.P
Note: renaming files are case sensitive: upper-case and lower-case letters are considered to be different.
.sp
Note: in the \fB<renaming-list>\fP, lines that are empty or contain only blanks will be ignored.
.sp
Semantically, a renaming file behaves as function that maps a character string S (presumably representing the label of a transition) to another character string (the renamed label).
.sp
More precisely, the effect of a renaming file F on a character string S is defined as follows. The \fB<renaming-list>\fP of S is scanned from top to bottom in order to determine the first \fB<left-regexp>\fP matched by S. If this \fB<left-regexp>\fP does not exist, S is kept unchanged. If it exists, S will be renamed into the corresponding \fB<right-regexp>\fP. Renaming is performed according to the conventions for text substitution defined in the POSIX command \fBregexp(LOCAL)\fP.
.sp
Note: If S matches several \fB<left-regexp>\fPs, only the first one is taken into account. Renamings do not cumulate (although such behaviour can be explicitly programmed by invoking function \fBCAESAR_APPLY_RENAME_1()\fP several times).
.sp
For instance, the following file:
.sp
 \&
.nf
\fB   rename
   GET -> PUT
   PUT -> GET
\fP
.fi
will swap the labels named \fB"GET"\fP and \fB"PUT"\fP. Similarly, the following file:
.sp
 \&
.nf
\fB   rename
   "PUT !\e([A-Z]*\e) !\e([A-Z]*\e)" -> "PUT !\e2 !\e1"
\fP
.fi
will swap the offers of \fB"PUT"\fP labels, e.g., \fB"PUT !ABC !XYZ"\fP will be renamed into \fB"PUT !XYZ !ABC"\fP.
.sp
.SH GENERALIZED RENAMING FILES
The above format for renaming files is the one used in the \fICADP\fP toolbox for renaming labels selectively. The ``rename_1'' library of \fIOPEN/CAESAR\fP supports this format, while providing additional flexibility, in several directions:
.sp
.IP -
The ``rename_1'' library allows to parameterize the definition of \fB<header>\fP, which can therefore be different from \fB"rename"\fP. The value of \fB<header>\fP is determined by a regular expression passed as parameter to function \fBCAESAR_CREATE_RENAME_1()\fP (see below).
.IP -
The ``rename_1'' library also allows files without \fB<header>\fP. This special case is obtained by giving the \fBNULL\fP value to the corresponding parameter in function \fBCAESAR_CREATE_RENAME_1()\fP. In such case, the \fB<axiom>\fP of the grammar is simply defined as \fB<renaming-list>\fP, which does not change the semantics.
.IP -
The ``rename_1'' library allows four possibilities for renaming a character string S according to a \fB<left-regexp>\fP R: \fItotal matching\fP (S should match R entirely, otherwise renaming does not occur), \fIsingle partial matching\fP (renaming is performed for the first sub-string of S that matches R), \fImultiple partial matching\fP (renaming is performed for every sub-string of S that matches R), or \fIgate matching\fP (renaming is only performed for the first word of S and only if this first word matches R, the remaining part of S being unchanged in any case; the first word of S is the sub-string starting at the beginning of S and ending at the first character \fB!\fP, \fB?\fP, \fB(\fP, space, or tabulation, if any, or at the end of S otherwise; in the case where S is a LOTOS label, the first word of S denotes a LOTOS gate identifier).
The choice between these possibilities is determined by the value of an actual parameter passed to function \fBCAESAR_CREATE_RENAME_1()\fP. The renaming files used in the \fICADP\fP toolbox follow the total match semantics.
.P
.SH DESCRIPTION
The ``rename_1'' library allows to process one or several renaming files at the same time. Each renaming file is read, parsed and checked; if correct, its contents are stored (under a compiled form) in a data structure called ``renaming object''. Afterwards, the renaming file will only be handled through a pointer to its corresponding renaming object.
.sp
.SH FEATURES
.P
 ............................................................
.SS \fBCAESAR_TYPE_RENAME_1\fP
 \&
.nf
\fBtypedef CAESAR_TYPE_ABSTRACT (...) CAESAR_TYPE_RENAME_1;
\fP
.fi
This type denotes a pointer to the concrete representation of a renaming object, which is supposed to be ``opaque''.
.P
 ............................................................
.SS \fBCAESAR_CREATE_RENAME_1\fP
 \&
.nf
\fBvoid CAESAR_CREATE_RENAME_1 (CAESAR_R, CAESAR_PATHNAME, CAESAR_HEADER,
                             CAESAR_KIND)
   CAESAR_TYPE_RENAME_1 *CAESAR_R;
   CAESAR_TYPE_STRING CAESAR_PATHNAME;
   CAESAR_TYPE_STRING CAESAR_HEADER;
   CAESAR_TYPE_NATURAL CAESAR_KIND;
   { ... }
\fP
.fi
This procedure allocates a renaming object using \fBCAESAR_CREATE()\fP and assigns its address to \fB*CAESAR_R\fP. If the allocation fails, the \fBNULL\fP value is assigned to \fB*CAESAR_R\fP.
.sp
Note: because \fBCAESAR_TYPE_RENAME_1\fP is a pointer type, any variable \fBCAESAR_R\fP of type \fBCAESAR_TYPE_RENAME_1\fP must be allocated before used, for instance using:
.TS
center;
l.
 
 \fBCAESAR_CREATE_RENAME_1 (&CAESAR_R, ...);\fP 
 
.TE
.sp
The actual value of the formal parameter \fBCAESAR_PATHNAME\fP denotes a character string containing the file name of the renaming file. If the file name has a suffix (see above for a discussion about suffixes for renaming files), this suffix should be part of the character string \fBCAESAR_PATHNAME\fP (no suffix will be added implicitly). The renaming file referred to by \fBCAESAR_PATHNAME\fP should exist and be readable.
.sp
As a special case, if \fBCAESAR_PATHNAME\fP is equal to \fBNULL\fP, then the renaming file will be read from the standard input.
.sp
The actual value of the formal parameter \fBCAESAR_HEADER\fP denotes a character string containing a regular expression according to the definition given in the manual page of the POSIX \fBregexp(LOCAL)\fP command. This regular expression specifies the \fB<header>\fP that must occur at the first line of the renaming file.
.sp
As a special case, if \fBCAESAR_HEADER\fP is equal to \fBNULL\fP, then the renaming file should have no header line.
.sp
The actual value of the formal parameter \fBCAESAR_KIND\fP should be equal to 0 if total matching is desired, to 1 if multiple partial matching is desired, to 2 if single partial matching is desired, or to 3 if gate matching is desired (see above for a definition of these terms).
.sp
The renaming file is parsed: its \fB<left-regexp>\fP's and \fB<right-regexp>\fP's are analyzed and stored (under a compiled form) into the renaming object \fB*CAESAR_R\fP.
.sp
So doing, various error conditions may occur: the renaming file can not be open; it is empty, or the first line does not match the header specified by \fBCAESAR_HEADER\fP; \fBCAESAR_HEADER\fP is not a valid regular expression; the renaming file has syntax errors; it contains some \fB<left-regexp>\fP (resp. some \fBright-regexp>\fP that is not a valid regular expression (resp. replacement); etc. In such case, a detailed error message is displayed using the \fBCAESAR_WARNING()\fP procedure, and the \fBNULL\fP value is assigned to \fB*CAESAR_R\fP.
.P
 ............................................................
.SS \fBCAESAR_HEADER_RENAME_1\fP
 \&
.nf
\fB#define CAESAR_HEADER_RENAME_1 "rename"
\fP
.fi
This macro-definition returns the standard header for the renaming files used in the \fICADP\fP toolbox (see above). In such case, this macro-definition should be used as an actual value for parameter \fBCAESAR_HEADER\fP when invoking function \fBCAESAR_CREATE_RENAME_1\fP.
.P
 ............................................................
.SS \fBCAESAR_DELETE_RENAME_1\fP
 \&
.nf
\fBvoid CAESAR_DELETE_RENAME_1 (CAESAR_R)
   CAESAR_TYPE_RENAME_1 *CAESAR_R;
   { ... }
\fP
.fi
This procedure frees the memory space corresponding to the renaming object pointed to by \fB*CAESAR_R\fP using \fBCAESAR_DELETE()\fP. Afterwards, the \fBNULL\fP value is assigned to \fB*CAESAR_R\fP.
.P
 ............................................................
.SS \fBCAESAR_APPLY_RENAME_1\fP
 \&
.nf
\fBCAESAR_TYPE_STRING CAESAR_APPLY_RENAME_1 (CAESAR_R, CAESAR_S)
   CAESAR_TYPE_RENAME_1 CAESAR_R;
   CAESAR_TYPE_STRING CAESAR_S;
   { ... }
\fP
.fi
This function attempts to rename the character string \fBCAESAR_S\fP according to the renaming object pointed to by \fBCAESAR_R\fP.
.sp
If renaming succeeds, this function returns a character string containing the renamed string. The address of this character string is left unspecified, but it is assumed to be different from \fBCAESAR_S\fP.
.sp
If renaming fails, this function returns \fBCAESAR_S\fP. It is therefore possible to decide whether renaming succeeded or not, by comparing the result to the second parameter passed to \fBCAESAR_APPLY_RENAME_1\fP.
.sp
Note: in any case, the contents of \fBCAESAR_S\fP will not be modified (there is no side effect).
.sp
Note: when renaming succeeds, it is not allowed to modify the character string returned by \fBCAESAR_APPLY_RENAME_1()\fP nor to free it, for instance using \fBfree(3)\fP.
.sp
Note: when renaming succeeds, the contents of the character string returned by \fBCAESAR_APPLY_RENAME_1()\fP may be destroyed by a subsequent call to this function. In particular, it is forbidden to call \fBCAESAR_APPLY_RENAME_1()\fP by giving to \fBCAESAR_S\fP the value returned by a former call to \fBCAESAR_APPLY_RENAME_1()\fP for which renaming succeeded. For instance, the following call is forbidden in the general case:
.sp
.TS
center;
l.
 
 \fBCAESAR_APPLY_RENAME_1 (..., CAESAR_APPLY_RENAME_1 (..., ...));\fP 
 
.TE
.P
 ............................................................
.SS \fBCAESAR_FORMAT_RENAME_1\fP
 \&
.nf
\fBCAESAR_TYPE_FORMAT CAESAR_FORMAT_RENAME_1 (CAESAR_R, CAESAR_FORMAT)
   CAESAR_TYPE_RENAME_1 CAESAR_R;
   CAESAR_TYPE_FORMAT CAESAR_FORMAT;
   { ... }
\fP
.fi
This function allows to control the format under which the renaming object pointed to by \fBCAESAR_R\fP will be printed by the procedure \fBCAESAR_PRINT_RENAME_1()\fP (see below). Currently, the following formats are available:
.sp
.IP -
With format 0, information about the renaming object is displayed such as: the pathname of the corresponding renaming file, the header (if any), the number of patterns, the list of left and right patterns, etc.
.IP -
(no other format available yet).
.P
By default, the current format of each renaming object is initialized to 0.
.sp
When called with \fBCAESAR_FORMAT\fP between 0 and 0, this fonction sets the current format of \fBCAESAR_R\fP to \fBCAESAR_FORMAT\fP and returns an undefined result.
.sp
When called with another value of \fBCAESAR_FORMAT\fP, this function does not modify the current format of \fBCAESAR_R\fP but returns a result defined as follows. If \fBCAESAR_FORMAT\fP is equal to the constant \fBCAESAR_CURRENT_FORMAT\fP, the result is the value of the current format of \fBCAESAR_R\fP. If \fBCAESAR_FORMAT\fP is equal to the constant \fBCAESAR_MAXIMAL_FORMAT\fP, the result is the maximal format value (i.e., 0). In all other cases, the effect of this function is undefined.
.P
 ............................................................
.SS \fBCAESAR_MAX_FORMAT_RENAME_1\fP
 \&
.nf
\fBCAESAR_TYPE_FORMAT CAESAR_MAX_FORMAT_RENAME_1 ()
   { ... }
\fP
.fi
Caution! This function is deprecated. It should no longer be used, as it might be removed from future versions of the \fIOPEN/CAESAR\fP. Use function \fBCAESAR_FORMAT_RENAME_1()\fP instead, called with argument \fBCAESAR_MAXIMAL_FORMAT\fP.
.sp
This function returns the maximal format value available for printing renaming objects.
.P
 ............................................................
.SS \fBCAESAR_PRINT_RENAME_1\fP
 \&
.nf
\fBvoid CAESAR_PRINT_RENAME_1 (CAESAR_FILE, CAESAR_R)
   CAESAR_TYPE_FILE CAESAR_FILE;
   CAESAR_TYPE_RENAME_1 CAESAR_R;
   { ... }
\fP
.fi
This procedure prints to file \fBCAESAR_FILE\fP a text containing information about the renaming object pointed to by \fBCAESAR_R\fP. The nature of the information is determined by the current format of the renaming object pointed to by \fBCAESAR_R\fP.
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
