/******************************************************************************
 *   			            C A D P
 *-----------------------------------------------------------------------------
 *   INRIA - Centre de Recherche de Grenoble Rhone-Alpes
 *   655, avenue de l'Europe
 *   38330 Montbonnot Saint Martin
 *   FRANCE
 *-----------------------------------------------------------------------------
 *   Module		:	adt_string.h
 *   Auteur		:	Hubert GARAVEL
 *   Version		:	1.60
 *   Date		: 	2017/09/26 18:48:44
 *****************************************************************************/

#if defined (ADT_STRING_ADT_ALREADY_INCLUDED)
#undef ADT_STRING_ADT_DEFINITIONS
#elif defined (ADT_X_STRING)
#define ADT_STRING_ADT_ALREADY_INCLUDED
#define ADT_STRING_ADT_DEFINITIONS
#endif

#if defined (ADT_STRING_BCG_ALREADY_INCLUDED)
#undef ADT_STRING_BCG_DEFINITIONS
#elif defined (BCG_PREDEFINED_DECLARATIONS_INTERFACE)
#define ADT_STRING_BCG_ALREADY_INCLUDED
#define ADT_STRING_BCG_DEFINITIONS
#endif

#if defined (ADT_STRING_XTL_ALREADY_INCLUDED)
#undef ADT_STRING_XTL_DEFINITIONS
#elif defined (XTL_STANDARD_INTERFACE)
#define ADT_STRING_XTL_ALREADY_INCLUDED
#define ADT_STRING_XTL_DEFINITIONS
#endif

/*---------------------------------------------------------------------------*/
/* String type / Includes and preliminary definitions                        */
/*---------------------------------------------------------------------------*/

#include <strings.h>

#if defined (ADT_STRING_ADT_DEFINITIONS)

#if defined (CAESAR_ADT_NATIVE_ADT_STRING)

/* native implementation of strings as pointers to char */

#else

/* canonical implementation of strings as index entries in a hash table */

#ifdef CAESAR_ORDINARY_HASH
#include "caesar_hash.h"
#else
#define CAESAR_ORDINARY_HASH
#include "caesar_hash.h"
#undef CAESAR_ORDINARY_HASH
#endif

#include "caesar_table_1.h"

/* maximal number of string values */

#if CAESAR_ADT_HASH_ADT_STRING > 1
#define ADT_CARDINAL_ADT_STRING CAESAR_ADT_HASH_ADT_STRING

#elif CAESAR_ADT_HASH_ADT_STRING < 0
#define ADT_CARDINAL_ADT_STRING (1 << (- CAESAR_ADT_HASH_ADT_STRING))

#else
...				/* should not occur */
#endif

#endif

#endif

/*---------------------------------------------------------------------------*/
/* String type / Implementation [DIVERGENCE!]                                */
/*---------------------------------------------------------------------------*/

#if defined (ADT_STRING_ADT_DEFINITIONS)

#if defined (CAESAR_ADT_NATIVE_ADT_STRING)

typedef char *ADT_STRING;

#else

#if ADT_CARDINAL_ADT_STRING <= 256	/* 2^8 */
typedef unsigned char ADT_STRING;

#elif ADT_CARDINAL_ADT_STRING <= 65536	/* 2^16 */
typedef unsigned short ADT_STRING;

#else
typedef unsigned int ADT_STRING;
#endif

#endif

#endif

/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */

#if defined (ADT_STRING_BCG_DEFINITIONS)

#if defined (BCG_PREDEFINED_DECLARATIONS_SPECIAL_INCLUSION_1)
/*
 * here, bcg_string_length needs not be defined, as its value is not needed
 */
typedef char *bcg_type_string;

#elif defined (BCG_PREDEFINED_DECLARATIONS_SPECIAL_INCLUSION_2)
/*
 * here, bcg_string_length is a macro expanding to a global variable with a
 * defined value computed at run time; the value of this variable evolves in
 * time; bcg_string_length == 0 iff no string value has been recognized so
 * far; otherwise, bcg_string_length > 0 as the string-termination character
 * '\0' is counted in the value of bcg_string_length
 */
typedef char *bcg_type_string;

#else
/*
 * here, bcg_string_length is a macro defined to be a constant (this macro is
 * defined in the include area of BCG files, before the present file is
 * included); bcg_string_length == 0 iff no string value occurs in the
 * present BCG file; otherwise, bcg_string_length > 0 as the
 * string-termination character '\0' is counted in the value of
 * bcg_string_length
 */

#if bcg_string_length == 0
typedef char *bcg_type_string;	/* void type */
#else
typedef char bcg_type_string[bcg_string_length];
#endif

#endif

#endif

/*---------------------------------------------------------------------------*/
/* String type / Size in bits                                                */
/*---------------------------------------------------------------------------*/

#if defined (ADT_STRING_ADT_DEFINITIONS)

#if defined (CAESAR_ADT_NATIVE_ADT_STRING)

/* no bitfields */

#else

#if ADT_CARDINAL_ADT_STRING <= 2
#define CAESAR_ADT_BITS_ADT_STRING : 1

#elif ADT_CARDINAL_ADT_STRING <= 4
#define CAESAR_ADT_BITS_ADT_STRING : 2

#elif ADT_CARDINAL_ADT_STRING <= 8
#define CAESAR_ADT_BITS_ADT_STRING : 3

#elif ADT_CARDINAL_ADT_STRING <= 16
#define CAESAR_ADT_BITS_ADT_STRING : 4

#elif ADT_CARDINAL_ADT_STRING <= 32
#define CAESAR_ADT_BITS_ADT_STRING : 5

#elif ADT_CARDINAL_ADT_STRING <= 64
#define CAESAR_ADT_BITS_ADT_STRING : 6

#elif ADT_CARDINAL_ADT_STRING <= 128
#define CAESAR_ADT_BITS_ADT_STRING : 7

#elif ADT_CARDINAL_ADT_STRING <= 256
#define CAESAR_ADT_BITS_ADT_STRING : 8

#elif ADT_CARDINAL_ADT_STRING <= 512
#define CAESAR_ADT_BITS_ADT_STRING : 9

#elif ADT_CARDINAL_ADT_STRING <= 1024
#define CAESAR_ADT_BITS_ADT_STRING : 10

#elif ADT_CARDINAL_ADT_STRING <= 2048
#define CAESAR_ADT_BITS_ADT_STRING : 11

#elif ADT_CARDINAL_ADT_STRING <= 4096
#define CAESAR_ADT_BITS_ADT_STRING : 12

#elif ADT_CARDINAL_ADT_STRING <= 8192
#define CAESAR_ADT_BITS_ADT_STRING : 13

#elif ADT_CARDINAL_ADT_STRING <= 16384
#define CAESAR_ADT_BITS_ADT_STRING : 14

#elif ADT_CARDINAL_ADT_STRING <= 32768
#define CAESAR_ADT_BITS_ADT_STRING : 15

#elif ADT_CARDINAL_ADT_STRING <= 65536
#define CAESAR_ADT_BITS_ADT_STRING : 16

#elif ADT_CARDINAL_ADT_STRING <= 131072
#define CAESAR_ADT_BITS_ADT_STRING : 17

#elif ADT_CARDINAL_ADT_STRING <= 262144
#define CAESAR_ADT_BITS_ADT_STRING : 18

#elif ADT_CARDINAL_ADT_STRING <= 524288
#define CAESAR_ADT_BITS_ADT_STRING : 19

#elif ADT_CARDINAL_ADT_STRING <= 1048576
#define CAESAR_ADT_BITS_ADT_STRING : 20

#elif ADT_CARDINAL_ADT_STRING <= 2097152
#define CAESAR_ADT_BITS_ADT_STRING : 21

#elif ADT_CARDINAL_ADT_STRING <= 4194304
#define CAESAR_ADT_BITS_ADT_STRING : 22

#elif ADT_CARDINAL_ADT_STRING <= 8388608
#define CAESAR_ADT_BITS_ADT_STRING : 23

#elif ADT_CARDINAL_ADT_STRING <= 16777216
#define CAESAR_ADT_BITS_ADT_STRING : 24

#elif ADT_CARDINAL_ADT_STRING <= 33554432
#define CAESAR_ADT_BITS_ADT_STRING : 25

#elif ADT_CARDINAL_ADT_STRING <= 67108864
#define CAESAR_ADT_BITS_ADT_STRING : 26

#elif ADT_CARDINAL_ADT_STRING <= 134217728
#define CAESAR_ADT_BITS_ADT_STRING : 27

#elif ADT_CARDINAL_ADT_STRING <= 268435456
#define CAESAR_ADT_BITS_ADT_STRING : 28

#elif ADT_CARDINAL_ADT_STRING <= 536870912
#define CAESAR_ADT_BITS_ADT_STRING : 29

#elif ADT_CARDINAL_ADT_STRING <= 1073741824
#define CAESAR_ADT_BITS_ADT_STRING : 30

#elif ADT_CARDINAL_ADT_STRING - 1 <= 2147483647
#define CAESAR_ADT_BITS_ADT_STRING : 31

#else
/* #define CAESAR_ADT_BITS_ADT_STRING : 32 */

#endif

#endif

#endif

/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */

#if defined (ADT_STRING_BCG_DEFINITIONS)

#define bcg_string_size (bcg_string_length * 8)

/*
 * bcg_string_size is the maximal number of bits needed to store in memory
 * any of the string values contained in the BCG file; this size includes the
 * string-termination character '\0'
 */

#endif

/*---------------------------------------------------------------------------*/
/* String type / Scalarity                                                   */
/*---------------------------------------------------------------------------*/

#if defined (ADT_STRING_ADT_DEFINITIONS)

#define CAESAR_ADT_SCALAR_ADT_STRING

#endif

/*---------------------------------------------------------------------------*/
/* String type / Assignment                                                  */
/*---------------------------------------------------------------------------*/

#if defined (ADT_STRING_BCG_DEFINITIONS)

#define bcg_string_assign(bcg_1,bcg_2) strcpy ((bcg_1), (bcg_2))

#endif

/*---------------------------------------------------------------------------*/
/* String type / Canonicity                                                  */
/*---------------------------------------------------------------------------*/

#if defined (ADT_STRING_ADT_DEFINITIONS)

#if defined (CAESAR_ADT_NATIVE_ADT_STRING)

#define CAESAR_ADT_UNCANONICAL_ADT_STRING

#else

/* not uncanonical */

#endif

#endif

/*---------------------------------------------------------------------------*/
/* String type / Equality                                                    */
/*---------------------------------------------------------------------------*/

#if defined (ADT_STRING_ADT_DEFINITIONS)

#if defined (CAESAR_ADT_NATIVE_ADT_STRING)

/*
 * Because CAESAR resets variables automatically to NULL, we must be prepared
 * to compare string pointers having the NULL value
 */

#define ADT_CMP_STRING(X1,X2) (((X1) == (X2)) || (((X1) != NULL) && ((X2) != NULL) && (strcmp ((X1), (X2)) == 0)))

#else

#define ADT_CMP_STRING(X1,X2) ((X1) == (X2))

#endif

#endif

/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */

#if defined (ADT_STRING_BCG_DEFINITIONS)

#define bcg_string_cmp(bcg_1,bcg_2) (strcmp ((bcg_1), (bcg_2)) == 0)

#endif

/*---------------------------------------------------------------------------*/
/* String type / Iteration                                                   */
/*---------------------------------------------------------------------------*/

/* no iterator */

/*---------------------------------------------------------------------------*/
/* String type / Print [DIVERGENCE!]                                         */
/*---------------------------------------------------------------------------*/

#if defined (ADT_STRING_ADT_DEFINITIONS)

/*
 * Because CAESAR reset variables automatically to NULL, we must be prepared
 * to print string pointers having the NULL value
 */

#define ADT_PRINT_CORE_STRING(F,X) \
	if ((X) == NULL) \
		fprintf ((F), "NULL"); \
	else { \
		char *ADT_C; \
		fprintf ((F), "\""); \
		for (ADT_C = (X); *ADT_C != '\0'; ++ADT_C) { \
			if (*ADT_C == '\"') \
				fprintf ((F), "\\\""); \
			else if (*ADT_C == '\\') \
				fprintf ((F), "\\\\"); \
			else \
				ADT_PRINT_CORE_CHAR ((F), *ADT_C); \
		} \
		fprintf ((F), "\""); \
	}

#if defined (CAESAR_ADT_NATIVE_ADT_STRING)

#define ADT_PRINT_STRING(F,X) ADT_PRINT_CORE_STRING ((F), (X))

#else

#define ADT_PRINT_STRING(F,X) ADT_PRINT_CORE_STRING ((F), CAESAR_ADT_CONTENTS_RETRIEVE_ADT_STRING ((X), 1))

#endif

#endif

/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */

#if defined (ADT_STRING_BCG_DEFINITIONS)
#if defined (BCG_PREDEFINED_DECLARATIONS_SPECIAL_INCLUSION_1)

extern void bcg_string_print BCG_ARG_2 (BCG_TYPE_STREAM, bcg_type_string);

#else

void bcg_string_print (bcg_file, bcg_0)
BCG_TYPE_STREAM bcg_file;
bcg_type_string bcg_0;

{
     if ((bcg_0) == NULL)
	  fprintf ((bcg_file), "NULL");
     else {
	  char *bcg_c;
	  fprintf ((bcg_file), "\"");
	  for (bcg_c = (bcg_0); *bcg_c != '\0'; ++bcg_c) {
	       if (*bcg_c == '\"')
		    fprintf ((bcg_file), "\\\"");
	       else if (*bcg_c == '\\')
		    fprintf ((bcg_file), "\\\\");
	       else
		    bcg_core_character_print ((bcg_file), *bcg_c);
	  }
	  fprintf ((bcg_file), "\"");
     }
}

#endif
#endif

/*---------------------------------------------------------------------------*/
/* String type / Scan                                                        */
/*---------------------------------------------------------------------------*/

#if defined (ADT_STRING_BCG_DEFINITIONS)
#if defined (BCG_PREDEFINED_DECLARATIONS_SPECIAL_INCLUSION_1)

extern BCG_TYPE_SCAN_RESULT bcg_string_scan BCG_ARG_2 (BCG_TYPE_C_STRING, bcg_type_string *);

#else

BCG_TYPE_SCAN_RESULT bcg_string_scan (bcg_text, bcg_string)
BCG_TYPE_C_STRING bcg_text;
bcg_type_string *bcg_string;
{
     BCG_TYPE_C_STRING bcg_t, bcg_s;
     BCG_TYPE_NATURAL bcg_nb_scanned_characters;
     BCG_TYPE_SCAN_RESULT bcg_result;

     /*
      * this function scans bcg_text to extract a string denotation (either
      * NULL or  "...", the latter possibly containing escape sequences
      * starting with a backslash); on success, it returns BCG_SCAN_OK,
      * copies the string value in (*bcg_string); on error, an appropriate
      * result BCG_SCAN_NOK... is returned and (*bcg_string) is generally
      * undefined; however, when BCG_SCAN_NOK_BAD_OCTAL,
      * BCG_SCAN_NOK_BAD_HEXADECIMAL, or BCG_SCAN_NOK_BAD_ESCAPE are
      * returned, (*bcg_string) is set to the suffix of bcg_text starting at
      * the first invalid escape sequence (such information is useful to
      * produce error diagnostics)
      */

     /*
      * the following post-condition holds: when BCG_SCAN_NOK is returned,
      * strlen (bcg_string) <= strlen (bcg_text); that is, if bcg_string was
      * allocated with the same number of bytes as bcg_text before calling
      * bcg_string_scan(), no buffer overflow will occur inside this function
      */

#if defined (BCG_PREDEFINED_DECLARATIONS_SPECIAL_INCLUSION_2)
     static bcg_type_string bcg_string_buffer;
     static BCG_TYPE_NATURAL bcg_string_buffer_length = 0;
#endif

     if (strcasecmp (bcg_text, "NULL") == 0)
	  return (BCG_SCAN_NOK_NULL_STRING);

     if (bcg_text[0] != '\"')
	  return (BCG_SCAN_NOK);

#if defined (BCG_PREDEFINED_DECLARATIONS_SPECIAL_INCLUSION_2)
     if (bcg_string_length == 0) {
	  /*
	   * no string value has been successfully scanned so far; one needs
	   * to allocate a buffer of sufficient size, e.g.,
	   * bcg_max_label_length (a valid smaller size could be: strlen
	   * (bcg_text) + 1)
	   */
	  /* assert (bcg_string_buffer_length == 0) */
	  bcg_string_buffer = (bcg_type_string) malloc (bcg_max_label_length);
	  if (bcg_string_buffer == NULL)
	       return (BCG_SCAN_NOK_MEMORY_SHORTAGE);
	  bcg_string_buffer_length = bcg_max_label_length;
     } else if (bcg_string_buffer_length < bcg_string_length) {
	  /*
	   * the value of bcg_string_length has increased and is now larger
	   * than the allocated buffer size
	   */
	  if (bcg_string_buffer_length > 0)
	       free (bcg_string_buffer);
	  bcg_string_buffer = (bcg_type_string) malloc (bcg_string_length);
	  if (bcg_string_buffer == NULL)
	       return (BCG_SCAN_NOK_MEMORY_SHORTAGE);
	  bcg_string_buffer_length = bcg_string_length;
     }
     *bcg_string = bcg_string_buffer;
#endif

     bcg_t = &(bcg_text[1]);

     bcg_s = *bcg_string;

     while (BCG_TRUE) {
	  bcg_result = bcg_core_character_scan (bcg_t, bcg_s, &bcg_nb_scanned_characters);

	  switch (bcg_result) {
	  case BCG_SCAN_NOK:
	       /* (*bcg_t) == '\0': unexpected end of string */
	       return (BCG_SCAN_NOK_BAD_STRING);
	  case BCG_SCAN_NOK_BAD_OCTAL:
	  case BCG_SCAN_NOK_BAD_HEXADECIMAL:
	  case BCG_SCAN_NOK_BAD_ESCAPE:
	       /* bcg_t[0...] contains an incorrect escape sequence */
	       /* return in (*bcg_string) the offending string fragment */
	       strcpy (*bcg_string, bcg_t);
	       return (bcg_result);
	  case BCG_SCAN_OK:
	       /* bcg_t[0...] starts with a valid character */
	       /* here, (*bcg_s) has been duly assigned */
	       if ((*bcg_s == '\"') && (bcg_nb_scanned_characters == 1)) {
		    /* (*bcg_t) is a non-escaped double quote : end of string */
		    *bcg_s = '\0';
		    if (*(bcg_t + 1) == '\0')
			 return (BCG_SCAN_OK);
		    else
			 return (BCG_SCAN_NOK_BAD_STRING);
	       } else {
		    bcg_t += bcg_nb_scanned_characters;
		    ++bcg_s;
		    /* proceed to the next loop iteration */
	       }
	  }
     }
     /* NOTREACHED */
}

#endif
#endif

/*---------------------------------------------------------------------------*/
/* String type / Binary write                                                */
/*---------------------------------------------------------------------------*/

#if defined (ADT_STRING_BCG_DEFINITIONS)
#if defined (BCG_PREDEFINED_DECLARATIONS_SPECIAL_INCLUSION_1)

extern void bcg_string_write BCG_ARG_3 (BCG_TYPE_STREAM, bcg_type_string, BCG_TYPE_NATURAL *);

#else

void bcg_string_write (bcg_file, bcg_string, bcg_size)
BCG_TYPE_STREAM bcg_file;
bcg_type_string bcg_string;
BCG_TYPE_NATURAL *bcg_size;
{
     BCG_PUSH_WRITE_FILE (bcg_file);
     BCG_WRITE_STRING ((BCG_TYPE_C_STRING) bcg_string);
     *bcg_size = 8 * (strlen ((char *) bcg_string) + 1);
     BCG_PULL_WRITE_FILE ();
}

#endif
#endif

/*---------------------------------------------------------------------------*/
/* String type / Binary read                                                 */
/*---------------------------------------------------------------------------*/

#if defined (ADT_STRING_BCG_DEFINITIONS)
#if defined (BCG_PREDEFINED_DECLARATIONS_SPECIAL_INCLUSION_1)

extern void bcg_string_read BCG_ARG_3 (BCG_TYPE_STREAM, bcg_type_string *, BCG_TYPE_NATURAL *);

#else

void bcg_string_read (bcg_file, bcg_string, bcg_size)
BCG_TYPE_STREAM bcg_file;
bcg_type_string *bcg_string;
BCG_TYPE_NATURAL *bcg_size;
{
     BCG_TYPE_C_STRING bcg_pointer;

     BCG_PUSH_READ_FILE (bcg_file);
     /* the following assignment is mandatory to avoid type cast problems */
     bcg_pointer = (BCG_TYPE_C_STRING) (*bcg_string);
#ifdef BCG_VERSION_PREDEFINED_DEFINITIONS
     /* case of a recent BCG file produced after CADP 2015-a included */
     BCG_READ_STRING (&bcg_pointer);
     *bcg_size = 8 * (strlen (bcg_pointer) + 1);
#else
     /* case of a legacy BCG file produced before CADP 2014-l included */
     {
	  BCG_TYPE_BYTE bcg_byte;
	  BCG_READ_FIXED_STRING (&bcg_pointer, bcg_string_length - 1);
	  /* the string is terminated with an extra '\0' character */
	  BCG_READ_BYTE (&bcg_byte);
	  /* assert (bcg_byte == 0); */
	  *bcg_size = 8 * bcg_string_length;
     }
#endif
     BCG_PULL_READ_FILE ();
}

#endif
#endif

/*---------------------------------------------------------------------------*/
/* String type / End of list                                                 */
/*---------------------------------------------------------------------------*/
