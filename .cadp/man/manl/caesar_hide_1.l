'\" t
.\" @(#)caesar_hide_1.l - VASY and CONVECS teams - version 1.1
.TH caesar_hide_1 LOCAL "2020/02/11 (version 1.1)" "(C) INRIA" "OPEN/CAESAR MANUAL"
.fp 4 CB
.lg 0
.SH NAME
caesar_hide_1 \- the ``hide_1'' library of OPEN/CAESAR
.SH PURPOSE
The ``hide_1'' library provides primitives for processing ``hiding files''. These files specify which labels of a graph should be hidden (i.e., renamed into the internal action ``i'', or tau) using a set of regular expressions.
.sp
.SH USAGE
The ``hide_1'' library consists of:
.IP -
a predefined header file \fBcaesar_hide_1.h\fP;
.IP -
the precompiled library file \fBlibcaesar.a\fP, which implements the features described in \fBcaesar_hide_1.h\fP.
.P
Note: The ``hide_1'' library is a software layer built above the primitives offered by the ``standard'' library.
.sp
.SH HIDING FILES
In this section, we define the format of hiding files, as they are used in the \fICADP\fP toolbox. The next sections will explain how the ``hide_1'' library of \fIOPEN/CAESAR\fP supports (and extends) this format.
.sp
A hiding file is a text file containing a set of ``hiding patterns''. There is no mandatory suffix (i.e., file extension) for hiding files: any file name can be used; however, it is recommended to use one of the following suffixes ``.hid'' (recommended) or ``.hide''.
.sp
The syntax of hiding files is described by the following context-free grammar:
.sp
 \&
.nf
\fB     <axiom> ::= <blanks> <positive-header> <blanks> \en <pattern-list>
              |  <blanks> <negative-header> <blanks> \en <pattern-list>
 
     <positive-header> ::= hide
 
     <negative-header> ::= hide all but
 
     <pattern-list> ::= <empty>
                     |  <pattern> <pattern-list>
 
     <pattern> ::= <blanks> <regexp> <blanks> \en
                |  <blanks> "<regexp>" <blanks> \en
\fP
.fi
where:
.sp
.IP -
\e\fBn\fP denotes the newline character;
.IP -
\fB<blanks>\fP is any sequence of spaces, tabulations, carriage returns, newlines, vertical tabulations, or form feeds; these characters are those recognized by the POSIX function \fBisspace()\fP; they are always skipped and ignored;
.IP -
\fB<empty>\fP denotes the empty sequence;
.IP -
\fB<regexp>\fP is a character string specifying a regular expression according to the definition given in the \fBregexp\fP(LOCAL) manual page. The \fB<regexp>\fP may be enclosed between double quotes, which will be removed and ignored.
.P
Note: hiding files are case sensitive: upper-case and lower-case letters are considered to be different.
.sp
Note: in the \fB<pattern-list>\fP, lines that are empty or contain only blanks will be ignored.
.sp
Semantically, a hiding file behaves as a predicate that decides whether a character string (presumably representing the label of a transition) belongs to a set of patterns. Depending on the first line of the hiding file (positive or negative header), a label will be hidden (i.e., renamed into the internal action ``i'', often referred to as ``tau'') if recognized (or vice-versa). More precisely, the effect of a hiding file F is defined as follows:
.sp
.IP -
If the first line of F is equal to \fB"hide"\fP, then any character string S that matches one (or more) \fB<regexp>\fP(s) contained in F will be hidden; if S matches no \fB<regexp>\fP, it will be kept unchanged.
.IP -
If the first line of F is equal to \fB"hide all but"\fP, then any character string S that matches no \fB<regexp>\fP contained in F will be hidden; if S matches one (or more) \fB<regexp>\fP(s), it will be kept unchanged.
.P
For instance, the following file:
.sp
 \&
.nf
\fB   hide
   GET
   "ACK !false .*"
\fP
.fi
will hide all character strings equal to \fB"GET"\fP or prefixed with \fB"ACK !false "\fP. Similarly, the following file:
.sp
 \&
.nf
\fB   hide all but
   "PUT .*"
\fP
.fi
will hide all character strings except those prefixed with \fB"PUT "\fP.
.sp
.SH GENERALIZED HIDING FILES
The above format for hiding files is the one used in the \fICADP\fP toolbox for hiding labels selectively. The ``hide_1'' library of \fIOPEN/CAESAR\fP supports this format, while providing additional flexibility, in several directions:
.sp
.IP -
The ``hide_1'' library does not hide labels itself: it simply implements the predicate function that determines whether a character string (representing a label) matches or not some of the \fB<regexp>\fP's contained in a file F. On the basis of this information, the \fIOPEN/CAESAR\fP programmer is free to hide the label, or perform any other action (for instance, distinguish between input and output labels).
.IP -
The ``hide_1'' library allows to parameterize the definition of \fB<positive-header>\fP and \fB<negative-header>\fP. These symbols can be different from \fB"hide"\fP and \fB"hide all but"\fP; for instance, they could be replaced by \fB"input"\fP and \fB"output"\fP. The values of \fB<positive-header>\fP and \fB<negative-header>\fP are determined by two regular expressions passed as parameters to function \fBCAESAR_CREATE_HIDE_1()\fP (see below).
.IP -
The ``hide_1'' library also allows files without \fB<positive-header>\fP nor \fB<negative-header>\fP. This special case is obtained by giving the \fBNULL\fP value to the corresponding parameters in function \fBCAESAR_CREATE_HIDE_1()\fP. In such case, the \fB<axiom>\fP of the grammar is simply defined as \fB<pattern-list>\fP. A character string S will be recognized if it matches one of the \fB<regexp>\fP's contained in the file.
.IP -
The ``hide_1'' library allows three possibilities for deciding whether a character string S matches a \fB<regexp>\fP R: \fItotal matching\fP (S should match R entirely), \fIpartial matching\fP (S should contain a sub-string that matches R), or \fIgate matching\fP (the first word of S, should match R entirely, the remaining part of S being ignored; the first word of S is the sub-string starting at the beginning of S and ending at the first character \fB!\fP, \fB?\fP, \fB(\fP, space, or tabulation, if any, or at the end of S otherwise; in the case where S is a LOTOS label, the first word of S denotes a LOTOS gate identifier).
The choice between these possibilities is determined by the value of an actual parameter passed to function \fBCAESAR_CREATE_HIDE_1()\fP. The hiding files used in the \fICADP\fP toolbox follow the total match semantics.
.P
.SH DESCRIPTION
The ``hide_1'' library allows to process one or several hiding files at the same time. Each hiding file is read, parsed and checked; if correct, its contents are stored (under a compiled form) in a data structure called ``hiding object''. Afterwards, the hiding file will only be handled through a pointer to its corresponding hiding object.
.sp
.SH FEATURES
.P
 ............................................................
.SS \fBCAESAR_TYPE_HIDE_1\fP
 \&
.nf
\fBtypedef CAESAR_TYPE_ABSTRACT (...) CAESAR_TYPE_HIDE_1;
\fP
.fi
This type denotes a pointer to the concrete representation of a hiding object, which is supposed to be ``opaque''.
.P
 ............................................................
.SS \fBCAESAR_CREATE_HIDE_1\fP
 \&
.nf
\fBvoid CAESAR_CREATE_HIDE_1 (CAESAR_H, CAESAR_PATHNAME, CAESAR_POSITIVE_HEADER,
                           CAESAR_NEGATIVE_HEADER, CAESAR_KIND)
   CAESAR_TYPE_HIDE_1 *CAESAR_H;
   CAESAR_TYPE_STRING CAESAR_PATHNAME;
   CAESAR_TYPE_STRING CAESAR_POSITIVE_HEADER;
   CAESAR_TYPE_STRING CAESAR_NEGATIVE_HEADER;
   CAESAR_TYPE_NATURAL CAESAR_KIND;
   { ... }
\fP
.fi
This procedure allocates a hiding object using \fBCAESAR_CREATE()\fP and assigns its address to \fB*CAESAR_H\fP. If the allocation fails, the \fBNULL\fP value is assigned to \fB*CAESAR_H\fP.
.sp
Note: because \fBCAESAR_TYPE_HIDE_1\fP is a pointer type, any variable \fBCAESAR_H\fP of type \fBCAESAR_TYPE_HIDE_1\fP must be allocated before used, for instance using:
.TS
center;
l.
 
 \fBCAESAR_CREATE_HIDE_1 (&CAESAR_H, ...);\fP 
 
.TE
.sp
The actual value of the formal parameter \fBCAESAR_PATHNAME\fP denotes a character string containing the file name of the hiding file. If the file name has a suffix (see above for a discussion about suffixes for hiding files), this suffix should be part of the character string \fBCAESAR_PATHNAME\fP (no suffix will be added implicitly). The hiding file referred to by \fBCAESAR_PATHNAME\fP should exist and be readable.
.sp
As a special case, if \fBCAESAR_PATHNAME\fP is equal to \fBNULL\fP, then the hiding file will be read from the standard input.
.sp
The actual value of the formal parameter \fBCAESAR_POSITIVE_HEADER\fP denotes a character string containing a regular expression according to the definition given in the manual page of the POSIX \fBregexp(LOCAL)\fP command. This regular expression specifies the \fB<positive-header>\fP that may occur at the first line of the hiding file.
.sp
The actual value of the formal parameter \fBCAESAR_NEGATIVE_HEADER\fP denotes a character string containing a regular expression according to the definition given in the manual page of the POSIX \fBregexp(LOCAL)\fP command. This regular expression specifies the \fB<negative-header>\fP that may occur at the first line of the hiding file.
.sp
As a special case, if both \fBCAESAR_POSITIVE_HEADER\fP and \fBCAESAR_NEGATIVE_HEADER\fP are equal to \fBNULL\fP, then the hiding file should have no header line. Otherwise, \fBCAESAR_POSITIVE_HEADER\fP and \fBCAESAR_NEGATIVE_HEADER\fP should both be different from \fBNULL\fP.
.sp
Note: if the regular expressions \fBCAESAR_POSITIVE_HEADER\fP and \fBCAESAR_NEGATIVE_HEADER\fP are not exclusive (i.e., there exists at least one character string that matches both regular expressions), then the effect is undefined.
.sp
The actual value of the formal parameter \fBCAESAR_KIND\fP should be equal to 0 if total matching is desired, to 1 if partial matching is desired, or to 2 if gate matching is desired (see above for a definition of these terms).
.sp
The hiding file is parsed: its \fB<regexp>\fP's are analyzed and stored (under a compiled form) into the hiding object \fB*CAESAR_H\fP.
.sp
So doing, various error conditions may occur: the hiding file can not be open; it is empty, or the first line matches neither the header specified by \fBCAESAR_POSITIVE_HEADER\fP nor the one specified by \fBCAESAR_NEGATIVE_HEADER\fP; \fBCAESAR_POSITIVE_HEADER\fP (resp. \fBCAESAR_NEGATIVE_HEADER\fP) is not a valid regular expression; the hiding file has syntax errors; it contains some \fB<regexp>\fP that is not a valid regular expression; etc. In such case, a detailed error message is displayed using the \fBCAESAR_WARNING()\fP procedure, and the \fBNULL\fP value is assigned to \fB*CAESAR_H\fP.
.P
 ............................................................
.SS \fBCAESAR_POSITIVE_HEADER_HIDE_1\fP
 \&
.nf
\fB#define CAESAR_POSITIVE_HEADER_HIDE_1 "hide"
\fP
.fi
This macro-definition returns the standard positive header for the hiding files used in the \fICADP\fP toolbox (see above). In such case, this macro-definition should be used as an actual value for parameter \fBCAESAR_POSITIVE_HEADER\fP when invoking function \fBCAESAR_CREATE_HIDE_1\fP.
.P
 ............................................................
.SS \fBCAESAR_NEGATIVE_HEADER_HIDE_1\fP
 \&
.nf
\fB#define CAESAR_NEGATIVE_HEADER_HIDE_1 "hide[ \et][ \et]*all[ \et][ \et]*but"
\fP
.fi
This macro-definition returns the standard negative header for the hiding files used in the \fICADP\fP toolbox (see above). In such case, this macro-definition should be used as an actual value for parameter \fBCAESAR_NEGATIVE_HEADER\fP when invoking function \fBCAESAR_CREATE_HIDE_1\fP.
.P
 ............................................................
.SS \fBCAESAR_DELETE_HIDE_1\fP
 \&
.nf
\fBvoid CAESAR_DELETE_HIDE_1 (CAESAR_H)
   CAESAR_TYPE_HIDE_1 *CAESAR_H;
   { ... }
\fP
.fi
This procedure frees the memory space corresponding to the hiding object pointed to by \fB*CAESAR_H\fP using \fBCAESAR_DELETE()\fP. Afterwards, the \fBNULL\fP value is assigned to \fB*CAESAR_H\fP.
.P
 ............................................................
.SS \fBCAESAR_TEST_HIDE_1\fP
 \&
.nf
\fBCAESAR_TYPE_BOOLEAN CAESAR_TEST_HIDE_1 (CAESAR_H, CAESAR_S)
   CAESAR_TYPE_HIDE_1 CAESAR_H;
   CAESAR_TYPE_STRING CAESAR_S;
   { ... }
\fP
.fi
This function returns \fBCAESAR_TRUE\fP if the character string \fBCAESAR_S\fP is recognized by the hiding object pointed to by \fBCAESAR_H\fP (according to the semantics defined above), or \fBCAESAR_FALSE\fP otherwise.
.P
 ............................................................
.SS \fBCAESAR_FORMAT_HIDE_1\fP
 \&
.nf
\fBCAESAR_TYPE_FORMAT CAESAR_FORMAT_HIDE_1 (CAESAR_H, CAESAR_FORMAT)
   CAESAR_TYPE_HIDE_1 CAESAR_H;
   CAESAR_TYPE_FORMAT CAESAR_FORMAT;
   { ... }
\fP
.fi
This function allows to control the format under which the hiding object pointed to by \fBCAESAR_H\fP will be printed by the procedure \fBCAESAR_PRINT_HIDE_1()\fP (see below). Currently, the following format is available:
.sp
.IP -
With format 0, information about the hiding object is displayed such as: the pathname of the corresponding hiding file, the positive header (if any), the negative header (if any), the number of patterns, the list of patterns, etc.
.IP -
(no other format available yet).
.P
By default, the current format of each hiding object is initialized to 0.
.sp
When called with \fBCAESAR_FORMAT\fP between 0 and 0, this fonction sets the current format of \fBCAESAR_H\fP to \fBCAESAR_FORMAT\fP and returns an undefined result.
.sp
When called with another value of \fBCAESAR_FORMAT\fP, this function does not modify the current format of \fBCAESAR_H\fP but returns a result defined as follows. If \fBCAESAR_FORMAT\fP is equal to the constant \fBCAESAR_CURRENT_FORMAT\fP, the result is the value of the current format of \fBCAESAR_H\fP. If \fBCAESAR_FORMAT\fP is equal to the constant \fBCAESAR_MAXIMAL_FORMAT\fP, the result is the maximal format value (i.e., 0). In all other cases, the effect of this function is undefined.
.P
 ............................................................
.SS \fBCAESAR_MAX_FORMAT_HIDE_1\fP
 \&
.nf
\fBCAESAR_TYPE_FORMAT CAESAR_MAX_FORMAT_HIDE_1 ()
   { ... }
\fP
.fi
Caution! This function is deprecated. It should no longer be used, as itmight be removed from future versions of the \fIOPEN/CAESAR\fP. Use function \fBCAESAR_FORMAT_HIDE_1()\fP instead, called with argument \fBCAESAR_MAXIMAL_FORMAT\fP.
.sp
This function returns the maximal format value available for printing hiding objects.
.P
 ............................................................
.SS \fBCAESAR_PRINT_HIDE_1\fP
 \&
.nf
\fBvoid CAESAR_PRINT_HIDE_1 (CAESAR_FILE, CAESAR_H)
   CAESAR_TYPE_FILE CAESAR_FILE;
   CAESAR_TYPE_HIDE_1 CAESAR_H;
   { ... }
\fP
.fi
This procedure prints to file \fBCAESAR_FILE\fP a text containing information about the hiding object pointed to by \fBCAESAR_H\fP. The nature of the information is determined by the current format of the hiding object pointed to by \fBCAESAR_H\fP.
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
