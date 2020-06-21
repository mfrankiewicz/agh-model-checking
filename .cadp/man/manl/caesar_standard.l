'\" t
.\" @(#)caesar_standard.l - VASY and CONVECS teams - version 1.3
.TH caesar_standard LOCAL "2020/02/11 (version 1.3)" "(C) INRIA" "OPEN/CAESAR MANUAL"
.fp 4 CB
.lg 0
.SH NAME
caesar_standard \- the ``standard'' library of OPEN/CAESAR
.SH PURPOSE
The ``standard'' library provides basic types and notations shared by all \fIOPEN/CAESAR\fP modules.
.sp
.sp
.SH USAGE
The ``standard'' library only consists of a predefined header file \fBcaesar_standard.h\fP.
.sp
.sp
.SH FEATURES
.P
 ............................................................
 \&
.nf
\fB#include <stdlib.h>
#include <stdio.h>
#include <memory.h>
#include <signal.h>
\fP
.fi
Various standard C libraries are imported, notably those providing functions for dynamic memory allocation, input/output, byte string facilities, and software signals. In particular, the \fBFILE\fP type and file handling primitives are imported.
.sp
.P
 ............................................................
.SS \fBCAESAR_TYPE_NATURAL\fP
 \&
.nf
\fBtypedef unsigned long CAESAR_TYPE_NATURAL;
\fP
.fi
\fBCAESAR_TYPE_NATURAL\fP is the unsigned integer type used in \fIOPEN/CAESAR\fP.
.sp
.P
 ............................................................
.SS \fBCAESAR_TYPE_INTEGER\fP
 \&
.nf
\fBtypedef long CAESAR_TYPE_INTEGER;
\fP
.fi
\fBCAESAR_TYPE_INTEGER\fP is the signed integer type used in \fIOPEN/CAESAR\fP.
.sp
.P
 ............................................................
.SS \fBCAESAR_TYPE_BOOLEAN\fP
 \&
.nf
\fBtypedef unsigned char CAESAR_TYPE_BOOLEAN;
\fP
.fi
\fBCAESAR_TYPE_BOOLEAN\fP is the boolean type used in \fIOPEN/CAESAR\fP. It follows the usual conventions of the C language: 0 means ``false'' and any value different from 0 means ``true''.
.sp
.P
 ............................................................
.SS \fBCAESAR_FALSE\fP
 \&
.nf
\fB#define CAESAR_FALSE ((CAESAR_TYPE_BOOLEAN) 0)
\fP
.fi
\fBCAESAR_FALSE\fP is the ``false'' boolean value.
.sp
.P
 ............................................................
.SS \fBCAESAR_TRUE\fP
 \&
.nf
\fB#define CAESAR_TRUE ((CAESAR_TYPE_BOOLEAN) 1)
\fP
.fi
\fBCAESAR_TRUE\fP is one possible ``true'' boolean value.
.sp
.P
 ............................................................
.SS \fBCAESAR_TYPE_BYTE\fP
 \&
.nf
\fBtypedef unsigned char CAESAR_TYPE_BYTE;
\fP
.fi
\fBCAESAR_TYPE_BYTE\fP is the byte type used in \fIOPEN/CAESAR\fP.
.sp
.P
 ............................................................
.SS \fBCAESAR_TYPE_STRING\fP
 \&
.nf
\fBtypedef char *CAESAR_TYPE_STRING;
\fP
.fi
\fBCAESAR_TYPE_STRING\fP is the string type (pointer to a character string termined by a null character) used in \fIOPEN/CAESAR\fP.
.sp
.P
 ............................................................
.SS \fBCAESAR_TYPE_FILE\fP
 \&
.nf
\fBtypedef FILE *CAESAR_TYPE_FILE;
\fP
.fi
\fBCAESAR_TYPE_FILE\fP is the file type (pointer to a POSIX file descriptor) used in \fIOPEN/CAESAR\fP.
.sp
.P
 ............................................................
.SS \fBCAESAR_TYPE_POINTER\fP
 \&
.nf
\fBtypedef unsigned char *CAESAR_TYPE_POINTER;
\fP
.fi
\fBCAESAR_TYPE_POINTER\fP is a pointer to a (generic) byte string.
.sp
.P
 ............................................................
.SS \fBCAESAR_TYPE_GENUINE_INT\fP
 \&
.nf
\fBtypedef int CAESAR_TYPE_GENUINE_INT;
\fP
.fi
\fBCAESAR_TYPE_GENUINE_INT\fP is a 32-bit integer type; its usage is discouraged, except at specific places where the C~standard explicitly requires an ``int'' type to be used.
.sp
.P
 ............................................................
.SS \fBCAESAR_TYPE_ARGC\fP
 \&
.nf
\fBtypedef CAESAR_TYPE_GENUINE_INT CAESAR_TYPE_ARGC;
\fP
.fi
\fBCAESAR_TYPE_ARGC\fP is a 32-bit integer type; it is used to declare the \fBargc\fP parameter of the \fBmain()\fP function of a C program.
.sp
.P
 ............................................................
.SS \fBCAESAR_TYPE_ARGV\fP
 \&
.nf
\fBtypedef char **CAESAR_TYPE_ARGV;
\fP
.fi
\fBCAESAR_TYPE_ARGV\fP is a pointer to an array of strings; it is used to declare the \fBargv\fP parameter of the \fBmain()\fP function of a C program.
.sp
.P
 ............................................................
.SS \fBCAESAR_SIZE_POINTER\fP
 \&
.nf
\fBCAESAR_TYPE_NATURAL CAESAR_SIZE_POINTER ()
   { ... }
\fP
.fi
This function returns the size (in bytes) of a value of type \fBCAESAR_TYPE_POINTER\fP.
.sp
.P
 ............................................................
.SS \fBCAESAR_ALIGNMENT_POINTER\fP
 \&
.nf
\fBCAESAR_TYPE_NATURAL CAESAR_ALIGNMENT_POINTER ()
   { ... }
\fP
.fi
This function returns the alignment factor (in bytes) for a value of type \fBCAESAR_TYPE_POINTER\fP.
.sp
Note: The alignment factor is often dependent from the machine architecture. For any memory area (and not only those of type \fBCAESAR_TYPE_POINTER\fP), the alignment factor is always a power of two (1, 2, 4, ...) and is an exact divider of the size of the area.
Whatever the machine architecture, any memory area must start at a machine address that is an even multiple of the alignment factor for that area, this constraint stating that areas must be properly aligned on machine word boundaries. In general, one has only to care about alignment constraints when creating structures containing areas with different alignment factors.
.sp
.P
 ............................................................
.SS \fBCAESAR_TYPE_GENERIC_FUNCTION\fP
 \&
.nf
\fBtypedef void (*CAESAR_TYPE_GENERIC_FUNCTION) ();
\fP
.fi
\fBCAESAR_TYPE_GENERIC_FUNCTION\fP is the ``pointer to a function'' type used in \fIOPEN/CAESAR\fP. The number of parameters for this function, the types of these parameters (if any) and the result type for this function are not specified.
.sp
.P
 ............................................................
.SS \fBCAESAR_TYPE_COMPARE_FUNCTION\fP
 \&
.nf
\fBtypedef CAESAR_TYPE_BOOLEAN (*CAESAR_TYPE_COMPARE_FUNCTION)
   (CAESAR_TYPE_POINTER, CAESAR_TYPE_POINTER);
\fP
.fi
\fBCAESAR_TYPE_COMPARE_FUNCTION\fP is the ``pointer to a comparison function'' type used in \fIOPEN/CAESAR\fP. A comparison function takes two parameters (two pointers to data of the same type) and returns a boolean value, depending whether both pointers refer to identical data or not.
.sp
.P
 ............................................................
.SS \fBCAESAR_TYPE_HASH_FUNCTION\fP
 \&
.nf
\fBtypedef CAESAR_TYPE_NATURAL (*CAESAR_TYPE_HASH_FUNCTION)
   (CAESAR_TYPE_POINTER, CAESAR_TYPE_NATURAL);
\fP
.fi
\fBCAESAR_TYPE_HASH_FUNCTION\fP is the ``pointer to a hash function'' type used in \fIOPEN/CAESAR\fP. A hash function takes two parameters (a pointer to data and a natural number N) and returns a natural number in the range 0..N-1.
.sp
.P
 ............................................................
.SS \fBCAESAR_TYPE_CONVERT_FUNCTION\fP
 \&
.nf
\fBtypedef CAESAR_TYPE_STRING (*CAESAR_TYPE_CONVERT_FUNCTION)
   (CAESAR_TYPE_POINTER);
\fP
.fi
\fBCAESAR_TYPE_HASH_FUNCTION\fP is the ``pointer to a conversion function'' type used in \fIOPEN/CAESAR\fP. A conversion function takes one parameter (a pointer to data) and returns a character string containing the data under some printable form.
.sp
.P
 ............................................................
.SS \fBCAESAR_TYPE_PRINT_FUNCTION\fP
 \&
.nf
\fBtypedef void (*CAESAR_TYPE_PRINT_FUNCTION)
   (CAESAR_TYPE_FILE, CAESAR_TYPE_POINTER);
\fP
.fi
\fBCAESAR_TYPE_PRINT_FUNCTION\fP is the ``pointer to a printing procedure'' type used in \fIOPEN/CAESAR\fP. A printing procedure takes two parameters (a pointer to a file and a pointer to data) and prints the latter to the former.
.sp
.P
 ............................................................
.SS \fBCAESAR_TYPE_FORMAT\fP
 \&
.nf
\fBtypedef unsigned char CAESAR_TYPE_FORMAT;
\fP
.fi
\fBCAESAR_TYPE_FORMAT\fP is the type used to control the output of the various printing functions (i.e., functions whose name starts with \fBCAESAR_PRINT_\fP) specified in the \fIOPEN/CAESAR\fP ``graph module'' interface or provided by the \fIOPEN/CAESAR\fP library.
.sp
Many of these functions can display a given object under various formats with different degree of information (e.g., a concise format vs a verbose format).
.sp
Each format is represented by a small value of type \fBCAESAR_TYPE_FORMAT\fP, e.g., 0, 1, 2, etc.
.sp
The format to be used by a printing function is not passed to this function as an argument (this would be too heavy); instead, the format is stored either in a global variable or in a field contained in the object to be printed.
.sp
.P
 ............................................................
.SS \fBCAESAR_INVALID_FORMAT\fP
 \&
.nf
\fB#define CAESAR_INVALID_FORMAT ((CAESAR_TYPE_FORMAT) 255)
\fP
.fi
\fBCAESAR_INVALID_FORMAT\fP is a special value of the type \fBCAESAR_TYPE_FORMAT\fP. It can be returned as a result by function \fBCAESAR_HANDLE_FORMAT()\fP when this function is invoked with an incorrect argument.
.sp
.P
 ............................................................
.SS \fBCAESAR_CURRENT_FORMAT\fP
 \&
.nf
\fB#define CAESAR_CURRENT_FORMAT ((CAESAR_TYPE_FORMAT) 254)
\fP
.fi
\fBCAESAR_CURRENT_FORMAT\fP is a special value of the type \fBCAESAR_TYPE_FORMAT\fP. It can be passed as an argument to function \fBCAESAR_HANDLE_FORMAT()\fP and to the various functions whose name starts with \fBCAESAR_FORMAT_\fP so as to query the current value of the global variable or object field that stores the format used by the corresponding printing function.
.sp
.P
 ............................................................
.SS \fBCAESAR_MAXIMAL_FORMAT\fP
 \&
.nf
\fB#define CAESAR_MAXIMAL_FORMAT ((CAESAR_TYPE_FORMAT) 253)
\fP
.fi
\fBCAESAR_MAXIMAL_FORMAT\fP is a special value of the type \fBCAESAR_TYPE_FORMAT\fP. It can be passed as an argument to function \fBCAESAR_HANDLE_FORMAT()\fP and to the various functions whose name starts with \fBCAESAR_FORMAT_\fP so as to query the largest format value supported by the corresponding printing function.
.sp
.P
 ............................................................
.SS \fBCAESAR_PRINT_FORMAT\fP
 \&
.nf
\fBvoid CAESAR_PRINT_FORMAT (CAESAR_FILE, CAESAR_FORMAT)
   CAESAR_TYPE_FILE CAESAR_FILE;
   CAESAR_TYPE_FORMAT CAESAR_FORMAT;
   { ... }
\fP
.fi
This procedure prints to file \fBCAESAR_FILE\fP the value of \fBCAESAR_FORMAT\fP. If \fBCAESAR_FORMAT\fP is equal to one of the three special values \fBCAESAR_INVALID_FORMAT\fP, \fBCAESAR_CURRENT_FORMAT\fP, or \fBCAESAR_MAXIMAL_FORMAT\fP, its value is printed symbolically rather than numerically.
.sp
Before this procedure is called, \fBCAESAR_FILE\fP must have been properly opened, for instance using \fBfopen(3)\fP.
.sp
.P
 ............................................................
.SS \fBCAESAR_HANDLE_FORMAT\fP
 \&
.nf
\fBCAESAR_TYPE_FORMAT CAESAR_HANDLE_FORMAT (CAESAR_VARIABLE, CAESAR_VALUE,
                                         CAESAR_MAXIMAL_VALUE)
   CAESAR_TYPE_FORMAT *CAESAR_VARIABLE;
   CAESAR_TYPE_FORMAT CAESAR_VALUE;
   CAESAR_TYPE_FORMAT CAESAR_MAXIMAL_VALUE;
   { ... }
\fP
.fi
This function is an auxiliary function that should be used to define all the various functions whose name starts with \fBCAESAR_FORMAT_\fP. Examples of the proper use of this function can be found by inspecting the C~code generated by \fICAESAR\fP or \fIEXP.OPEN\fP.
.sp
This function consults or modifies the format value pointed to by \fBCAESAR_VARIABLE\fP, which is expected to be the address of the global variable or object field that stores the format used by the corresponding printing function.
.sp
If \fBCAESAR_VALUE\fP is equal to \fBCAESAR_CURRENT_FORMAT\fP, this function returns the current value of the format pointed to by \fBCAESAR_VARIABLE\fP.
.sp
If \fBCAESAR_VALUE\fP is equal to \fBCAESAR_MAXIMAL_FORMAT\fP, this function returns \fBCAESAR_MAXIMAL_VALUE\fP, which is expected to be the largest format value supported by the corresponding printing function.
.sp
If \fBCAESAR_VALUE\fP is less or equal to \fBCAESAR_MAXIMAL_VALUE\fP, then the value of the format pointed to by \fBCAESAR_VARIABLE\fP is modified and set to \fBCAESAR_VALUE\fP. In such case, this function returns an undefined value.
.sp
In all other cases, this function returns \fBCAESAR_INVALID_FORMAT\fP.
.sp
.P
 ............................................................
.SS \fBCAESAR_TYPE_ABSTRACT\fP
 \&
.nf
\fB#define CAESAR_TYPE_ABSTRACT(CAESAR_NAME) struct CAESAR_NAME *
\fP
.fi
\fBCAESAR_TYPE_ABSTRACT (CAESAR_NAME)\fP is a pointer to a structure of name \fBCAESAR_NAME\fP.
.sp
Usually, the definition of \fBCAESAR_NAME\fP is not available, so that \fBCAESAR_TYPE_ABSTRACT (...)\fP is a ``generic'' pointer to some data structure, the internal representation of which is not pertinent to the user. This data structure is ``abstract'', in the sense that one should not rely on a particular implementation.
.sp
If \fBCAESAR_X\fP is an expression of type \fBCAESAR_TYPE_ABSTRACT (...)\fP, dereferencing \fBCAESAR_X\fP (e.g., \fB*CAESAR_X\fP or \fBCAESAR_X->...\fP) is not allowed.
Note: if \fBCAESAR_X\fP is an expression of type \fBCAESAR_TYPE_ABSTRACT (...)\fP, its value usually obeys alignment constraints (for instance, it can be an address multiple of 4).
.sp
.P
 ............................................................
.SS \fBCAESAR_CREATE\fP
 \&
.nf
\fB#define CAESAR_CREATE(CAESAR_ADDRESS,CAESAR_SIZE,CAESAR_TYPE) \e
        (CAESAR_ADDRESS) = (CAESAR_TYPE) malloc (CAESAR_SIZE)
\fP
.fi
This macro-definition encapsulates the C function \fBmalloc(3)\fP. It allocates a memory area of \fBCAESAR_SIZE\fP bytes and assigns its address to variable \fBCAESAR_ADDRESS\fP, which should be of type \fBCAESAR_TYPE\fP. If allocation fails, a \fBNULL\fP pointer is assigned to \fBCAESAR_ADDRESS\fP.
.sp
.P
 ............................................................
.SS \fBCAESAR_DELETE\fP
 \&
.nf
\fB#define CAESAR_DELETE(CAESAR_ADDRESS) \e
        free ((char *) (CAESAR_ADDRESS))
\fP
.fi
This macro-definition encapsulates the C function \fBfree(3)\fP. It frees the memory area pointed to by \fBCAESAR_ADDRESS\fP.
.sp
.P
 ............................................................
.SS \fBCAESAR_TOOL\fP
 \&
.nf
\fBextern CAESAR_TYPE_STRING CAESAR_TOOL;
\fP
.fi
The global variable \fBCAESAR_TOOL\fP is a pointer to a character string which should contain the name of the \fIOPEN/CAESAR\fP application program. By default, \fBCAESAR_TOOL\fP is always initialized to the empty string \fB""\fP. Although this default value can be left unchanged, it is advisable for each application program to give a meaningful value to \fBCAESAR_TOOL\fP. This is generally done by the first instruction of the \fBmain()\fP routine:
.sp
 \&
.nf
\fB        int main (argc, argv)
        int  argc;
        char *argv[];
        {
        /* additional declarations */
        CAESAR_TOOL = argv[0];
        /* other instructions */
        }
\fP
.fi
.sp
.P
 ............................................................
.SS \fBCAESAR_WARNING\fP
 \&
.nf
\fBvoid CAESAR_WARNING (CAESAR_TYPE_STRING CAESAR_FORMAT, ...)
   { ... }
\fP
.fi
This function displays a (non-fatal) warning message to the standard output. The warning message is specified by the actual parameters passed to the function. These parameters follow the same conventions as for \fBprintf(3)\fP and their number can be variable. The warning message will be prefixed by the value of the global variable \fBCAESAR_TOOL\fP, unless this value is the empty string. The format string given by \fBCAESAR_FORMAT\fP should not be suffixed with an end-of-line character, as \fBCAESAR_WARNING()\fP will add one automatically.
.sp
.P
 ............................................................
.SS \fBCAESAR_ERROR\fP
 \&
.nf
\fBvoid CAESAR_ERROR (CAESAR_TYPE_STRING CAESAR_FORMAT, ...)
   { ... }
\fP
.fi
This function displays a (fatal) error message to the standard output and stops using \fBexit (1)\fP. The error message is specified by the actual parameters passed to the function. These parameters follow the same conventions as for \fBprintf(3)\fP and their number can be variable. The error message will be prefixed by the value of the global variable \fBCAESAR_TOOL\fP, unless this value is the empty string. The format string given by \fBCAESAR_FORMAT\fP should not be suffixed with an end-of-line character, as \fBCAESAR_ERROR()\fP will add one automatically.
.sp
.P
 ............................................................
.SS \fBCAESAR_PROTEST\fP
 \&
.nf
\fB#define CAESAR_PROTEST() ...
\fP
.fi
This macro-definition displays an error message (containing the current file name and current line number) and stops. This macro-definition should be used only to report about unexpected, internal errors. If a more detailed error message should be displayed, then function \fBCAESAR_ERROR()\fP should be used instead.
.sp
.P
 ............................................................
.SS \fBCAESAR_ASSERT\fP
 \&
.nf
\fB#define CAESAR_ASSERT(CAESAR_ASSERTION) \e
        { if (!(CAESAR_ASSERTION)) CAESAR_PROTEST(); }
\fP
.fi
This macro-definition evaluates the boolean expression \fBCAESAR_ASSERTION\fP and, if the result is false, displays an error message (containing the current file name and current line number) and stops. This macro-definition should be used only to check assertions and report about unexpected, internal errors. If a more detailed error message should be displayed, then function \fBCAESAR_ERROR()\fP should be used instead.
.sp
.P
 ............................................................
.SS \fBCAESAR_TYPE_SIGNAL_HANDLER\fP
 \&
.nf
\fBtypedef void (*CAESAR_TYPE_SIGNAL_HANDLER) (int);
\fP
.fi
\fBCAESAR_TYPE_SIGNAL_HANDLER\fP is the ``pointer to a signal-handler procedure'' type used in \fIOPEN/CAESAR\fP. A signal-handler procedure takes one parameter, which a POSIX signal number. The type \fBCAESAR_TYPE_SIGNAL_HANDLER\fP is identical to the type \fBsighandler_t\fP that exists in certain Unix distributions. See the \fBsignal\fP manual page for further details.
.sp
.P
 ............................................................
.SS \fBCAESAR_SET_SIGNALS\fP
 \&
.nf
\fBvoid CAESAR_SET_SIGNALS (CAESAR_HANDLER)
   CAESAR_TYPE_SIGNAL_HANDLER CAESAR_HANDLER;
   { ... }
\fP
.fi
This procedure sets the POSIX signal handler to \fBCAESAR_HANDLER\fP for the following signals: \fBSIGHUP\fP, \fBSIGINT\fP, \fBSIGQUIT\fP, \fBSIGILL\fP, \fBSIGABRT\fP, \fBSIGFPE\fP, \fBSIGBUS\fP, \fBSIGSEGV\fP, \fBSIGSYS\fP, \fBSIGTERM\fP, and \fBSIGPIPE\fP (whenever these signals are supported by the operating system implementation). In particular, the signal handler \fBCAESAR_HANDLER\fP can be equal to the predefined values \fBSIG_IGN\fP or \fBSIG_DFL\fP. See the \fBsignal\fP manual page for further details.
.sp
.P
 ............................................................
.SS \fBCAESAR_RESET_SIGNALS\fP
 \&
.nf
\fBvoid CAESAR_RESET_SIGNALS ()
   { ... }
\fP
.fi
This procedure resets the POSIX signal handler for the following signals: \fBSIGHUP\fP, \fBSIGINT\fP, \fBSIGQUIT\fP, \fBSIGILL\fP, \fBSIGABRT\fP, \fBSIGFPE\fP, \fBSIGBUS\fP, \fBSIGSEGV\fP, \fBSIGSYS\fP, \fBSIGTERM\fP, and \fBSIGPIPE\fP (whenever these signals are supported by the operating system implementation). If the procedure \fBCAESAR_SET_SIGNALS\fP has been invoked (at least once) and if no invocation of \fBCAESAR_RESET_SIGNALS\fP occurred after the most recent invocation of \fBCAESAR_SET_SIGNALS\fP, this signal handler is reset to the value of the \fBCAESAR_HANDLER\fP argument passed to the most recent invocation of \fBCAESAR_SET_SIGNALS\fP. If the procedure \fBCAESAR_SET_SIGNALS\fP has never been invoked or not been invoked after the most recent invocation of \fBCAESAR_RESET_SIGNALS\fP, this signal handler is reset to \fBSIG_DFL\fP.
.sp
.P
 ............................................................
.SS \fBCAESAR_TEMPORARY_FILE\fP
 \&
.nf
\fBCAESAR_TYPE_STRING CAESAR_TEMPORARY_FILE (CAESAR_TEMPORARY_SUFFIX)
   CAESAR_TYPE_STRING CAESAR_TEMPORARY_SUFFIX;
   { ... }
\fP
.fi
This function returns a character string that can safely be used as a file name for a temporary file.
The prefix of this file name (i.e., the directory in which the temporary file will be created) is either given by the environment variable \fB$CADP_TMP\fP if this variable is defined, or is equal to \fB"/tmp"\fP otherwise.
The suffix of this file name is given by \fBCAESAR_TEMPORARY_SUFFIX\fP, which is usually a file extension starting with a dot.
If the allocation of the file name fails (due to a lack of memory) or if the temporary file cannot not be created in the directory specified by \fB$CADP_TMP\fP (e.g., because this directory does not exist, is write-protected, or belongs to a file system with unsufficient disk space to create new files), the \fBNULL\fP value is returned.
.sp
The contents of the character string returned by \fBCAESAR_TEMPORARY_FILE()\fP differs at every call to this function.
.sp
Note: It is not allowed to modify the character string returned by \fBCAESAR_TEMPORARY_FILE()\fP nor to free it, for instance using \fBfree(3)\fP.
.sp
Note: The contents of the character string returned by \fBCAESAR_TEMPORARY_FILE()\fP may be destroyed by a subsequent call to this function.
.sp
.P
 ............................................................
.SS \fBCAESAR_OPEN_COMPRESSED_FILE\fP
 \&
.nf
\fBvoid CAESAR_OPEN_COMPRESSED_FILE (CAESAR_FILE, CAESAR_FILENAME, CAESAR_MODE)
   CAESAR_TYPE_FILE *CAESAR_FILE;
   CAESAR_TYPE_STRING CAESAR_FILENAME;
   CAESAR_TYPE_STRING CAESAR_MODE;
   { ... }
\fP
.fi
This function opens (for reading or writing) a file, the pathname of which is \fBCAESAR_FILENAME\fP. The value of \fBCAESAR_MODE\fP, which must be equal to \fB"r"\fP or \fB"w"\fP, determines whether this file is opened for reading (\fB"r"\fP) or writing (\fB"w"\fP).
.sp
If the suffix of \fBCAESAR_FILENAME\fP corresponds to a known compression format (\fB".Z"\fP, \fB".gz"\fP, \fB".bz2"\fP, etc.), the file will be treated as a compressed file. Otherwise, the file will not be compressed and treated as an ordinary file. The list of supported suffixes and compression formats is given by the \fBcadp_zip\fP shell-script provided within the CADP distribution.
.sp
If the file can be opened, the value of \fB*CAESAR_FILE\fP is set to a POSIX stream descriptor from (respectively, to) which data can be read (respectively, written) using the standard input (respectively, output) routines available in POSIX, e.g., \fBfgets(3)\fP, \fBfprintf(3)\fP, \fBfputs(3)\fP, \fBfscanf(3)\fP, etc. Data compression, if any, is performed transparently, meaning that the data sent or read to a compressed file are exactly the same as if the file was not compressed.
.sp
If the file cannot be opened, the value of \fB*CAESAR_FILE\fP is set to \fBNULL\fP.
.sp
Note: Since type \fBCAESAR_TYPE_FILE\fP is defined as \fBFILE *\fP, variable \fBCAESAR_FILE\fP is actually of type \fBFILE **\fP, where \fBFILE\fP is the type of a POSIX file descriptor.
.sp
Note: Function \fBCAESAR_OPEN_COMPRESSED_FILE()\fP invokes \fBfopen(3)\fP to open an uncompressed file and \fBpopen(3)\fP to open a compressed file.
.sp
.P
 ............................................................
.SS \fBCAESAR_CLOSE_COMPRESSED_FILE\fP
 \&
.nf
\fBvoid CAESAR_CLOSE_COMPRESSED_FILE (CAESAR_FILE)
   CAESAR_TYPE_FILE *CAESAR_FILE;
   { ... }
\fP
.fi
This function closes the file pointed to by \fB*CAESAR_FILE\fP, which must have been opened previously by a call to the \fBCAESAR_OPEN_COMPRESSED_FILE()\fP function. After the file is closed, the value of \fB*CAESAR_FILE\fP is set to \fBNULL\fP.
.sp
Note: Since type \fBCAESAR_TYPE_FILE\fP is defined as \fBFILE *\fP, variable \fBCAESAR_FILE\fP is actually of type \fBFILE **\fP, where \fBFILE\fP is the type of a POSIX file descriptor.
.sp
Note: Function \fBCAESAR_CLOSE_COMPRESSED_FILE()\fP invokes either \fBfclose(3)\fP or \fBpclose(3)\fP to close the file.
.sp
.P
 ............................................................
.SS \fBCAESAR_FUNCTION_NAME\fP
 \&
.nf
\fBCAESAR_TYPE_STRING CAESAR_FUNCTION_NAME (CAESAR_FUNCTION)
   void (*CAESAR_FUNCTION) ();
   { ... }
\fP
.fi
This function returns a printable character string identifying the function \fBCAESAR_FUNCTION\fP. If \fBCAESAR_FUNCTION\fP belongs to a predefined set of functions of the \fIOPEN/CAESAR\fP library, the character string contains the name of this function (e.g., \fBCAESAR_0_HASH\fP, \fBCAESAR_PRINT_STATE\fP, \fBCAESAR_COMPARE_LABEL\fP, etc.); otherwise, the character string contains the hexadecimal value of the function pointer \fBCAESAR_FUNCTION\fP.
.sp
Note: It is not allowed to modify the character string returned by \fBCAESAR_FUNCTION_NAME()\fP nor to free it, for instance using \fBfree(3)\fP.
.sp
Note: In fact, \fBCAESAR_FUNCTION_NAME()\fP is implemented as a macro-definition that invokes an auxiliary function. This avoids the need for inserting a type cast before any parameter given to \fBCAESAR_FUNCTION_NAME()\fP.
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
