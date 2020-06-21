/******************************************************************************
 *   			            C A D P
 *-----------------------------------------------------------------------------
 *   INRIA - Centre de Recherche de Grenoble Rhone-Alpes
 *   655, avenue de l'Europe
 *   38330 Montbonnot Saint Martin
 *   FRANCE
 *-----------------------------------------------------------------------------
 *   Module		:	adt_character.h
 *   Auteur		:	Hubert GARAVEL
 *   Version		:	1.54
 *   Date		: 	2017/09/26 18:49:24
 *****************************************************************************/

#if defined (ADT_CHARACTER_ADT_ALREADY_INCLUDED)
#undef ADT_CHARACTER_ADT_DEFINITIONS
#elif defined (ADT_X_CHARACTER)
#define ADT_CHARACTER_ADT_ALREADY_INCLUDED
#define ADT_CHARACTER_ADT_DEFINITIONS
#endif

#if defined (ADT_CHARACTER_BCG_ALREADY_INCLUDED)
#undef ADT_CHARACTER_BCG_DEFINITIONS
#elif defined (BCG_PREDEFINED_DECLARATIONS_INTERFACE)
#define ADT_CHARACTER_BCG_ALREADY_INCLUDED
#define ADT_CHARACTER_BCG_DEFINITIONS
#endif

#if defined (ADT_CHARACTER_XTL_ALREADY_INCLUDED)
#undef ADT_CHARACTER_XTL_DEFINITIONS
#elif defined (XTL_STANDARD_INTERFACE)
#define ADT_CHARACTER_XTL_ALREADY_INCLUDED
#define ADT_CHARACTER_XTL_DEFINITIONS
#endif

/*---------------------------------------------------------------------------*/
/* Character type / Includes and preliminary definitions                     */
/*---------------------------------------------------------------------------*/

#include <ctype.h>		/* for isprint() */

/*---------------------------------------------------------------------------*/
/* Character type / Implementation                                           */
/*---------------------------------------------------------------------------*/

#if defined (ADT_CHARACTER_ADT_DEFINITIONS)

#ifndef ADT_CHAR
typedef char ADT_CHAR;
#endif

/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */

#endif

#if defined (ADT_CHARACTER_BCG_DEFINITIONS) || \
    defined (ADT_CHARACTER_XTL_DEFINITIONS)

typedef char bcg_type_character;

#endif

/*---------------------------------------------------------------------------*/
/* Character type / Size in bits                                             */
/*---------------------------------------------------------------------------*/

#if defined (ADT_CHARACTER_BCG_DEFINITIONS)

#define bcg_character_size ((BCG_TYPE_NATURAL) sizeof (bcg_type_character) * 8)

#endif

/*---------------------------------------------------------------------------*/
/* Character type / Scalarity                                                */
/*---------------------------------------------------------------------------*/

#if defined (ADT_CHARACTER_ADT_DEFINITIONS)

#define CAESAR_ADT_SCALAR_ADT_CHAR

#endif

/*---------------------------------------------------------------------------*/
/* Character type / Assignment                                               */
/*---------------------------------------------------------------------------*/

#if defined (ADT_CHARACTER_BCG_DEFINITIONS)

#define bcg_character_assign(bcg_1,bcg_2) (bcg_1) = (bcg_2)

#endif

/*---------------------------------------------------------------------------*/
/* Character type / Canonicity                                               */
/*---------------------------------------------------------------------------*/

/* not uncanonical */

/*---------------------------------------------------------------------------*/
/* Character type / Equality                                                 */
/*---------------------------------------------------------------------------*/

#if defined (ADT_CHARACTER_ADT_DEFINITIONS)

#define ADT_CMP_CHAR(X1,X2) ((X1) == (X2))

#endif

/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */

#if defined (ADT_CHARACTER_BCG_DEFINITIONS)

#define bcg_character_cmp(bcg_1,bcg_2) ((bcg_1) == (bcg_2))

#endif

/*---------------------------------------------------------------------------*/
/* Character type / Iteration [DIVERGENCE!]                                  */
/*---------------------------------------------------------------------------*/

#if defined (ADT_CHARACTER_ADT_DEFINITIONS)

#ifndef ADT_ENUM_FIRST_CHAR
#define ADT_ENUM_FIRST_CHAR() 0
#endif

#ifndef ADT_ENUM_NEXT_CHAR
#define ADT_ENUM_NEXT_CHAR(X) ((X)++ < 127)
#endif

#endif

/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */

#if defined (ADT_CHARACTER_BCG_DEFINITIONS)

#define bcg_character_enum(bcg_0) for ((bcg_0) = 1; (bcg_0) != 0; (bcg_0)++)

#endif

/*---------------------------------------------------------------------------*/
/* Character type / Print                                                    */
/*---------------------------------------------------------------------------*/

#if defined (ADT_CHARACTER_ADT_DEFINITIONS)

/* auxiliary macro used by ADT_PRINT_CHAR() and ADT_PRINT_STRING() */
#define ADT_PRINT_CORE_CHAR(F,X) \
	if (isprint (X)) \
		fprintf ((F), "%c", (X)); \
	else \
		fprintf ((F), "\\%03o", (unsigned char) (X))

#define ADT_PRINT_CHAR(F,X) \
	if (1) { \
		fprintf ((F), "'"); \
		if ((X) == '\'') \
			fprintf ((F), "\\\'"); \
		else if ((X) == '\\') \
			fprintf ((F), "\\\\"); \
		else \
			ADT_PRINT_CORE_CHAR ((F), (X)); \
		fprintf ((F), "'"); \
	} else ((void) 0)

#endif

/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */

#if defined (ADT_CHARACTER_BCG_DEFINITIONS)
#if defined (BCG_PREDEFINED_DECLARATIONS_SPECIAL_INCLUSION_1)

extern void bcg_character_print BCG_ARG_2 (BCG_TYPE_STREAM, bcg_type_character);

#else

/*
 * auxiliary macro used by bcg_character_print(), bcg_string_print(), and
 * bcg_raw_print()
 */
#define bcg_core_character_print(bcg_file,bcg_0) \
	if (isprint (bcg_0)) \
		fprintf ((bcg_file), "%c", (bcg_0)); \
	else \
		fprintf ((bcg_file), "\\%03o", (unsigned char) (bcg_0))

void bcg_character_print (bcg_file, bcg_0)
BCG_TYPE_STREAM bcg_file;
bcg_type_character bcg_0;

{
     fprintf ((bcg_file), "'");
     if ((bcg_0) == '\'')
	  fprintf ((bcg_file), "\\\'");
     else if ((bcg_0) == '\\')
	  fprintf ((bcg_file), "\\\\");
     else
	  bcg_core_character_print ((bcg_file), (bcg_0));
     fprintf ((bcg_file), "'");
}

#endif
#endif

/*---------------------------------------------------------------------------*/
/* Character type / Scan                                                     */
/*---------------------------------------------------------------------------*/

#if defined (ADT_CHARACTER_BCG_DEFINITIONS)
#if defined (BCG_PREDEFINED_DECLARATIONS_SPECIAL_INCLUSION_1)

extern BCG_TYPE_SCAN_RESULT bcg_core_character_scan BCG_ARG_3 (BCG_TYPE_C_STRING, bcg_type_character *, BCG_TYPE_NATURAL *);

extern BCG_TYPE_SCAN_RESULT bcg_character_scan BCG_ARG_2 (BCG_TYPE_C_STRING, bcg_type_character *);

#else

BCG_TYPE_SCAN_RESULT bcg_core_character_scan (bcg_text, bcg_character, bcg_nb_scanned_characters)
BCG_TYPE_C_STRING bcg_text;
bcg_type_character *bcg_character;
BCG_TYPE_NATURAL *bcg_nb_scanned_characters;

{
     bcg_type_character bcg_c;

     /*
      * this function scans bcg_text to extract a character denotation
      * (either a single character or an escape sequence starting with a
      * backslash); on success, it returns BCG_SCAN_OK, copies the character
      * value in (*bcg_character), and sets (*bcg_nb_scanned_characters) to
      * the length of the denotation; on error, an appropriate result
      * BCG_SCAN_NOK... is returned and (*bcg_character) is undefined
      */

     bcg_c = bcg_text[0];
     if (bcg_c == '\0') {
	  return (BCG_SCAN_NOK);
     } else if (bcg_c != '\\') {
	  /* ordinary character */
	  *bcg_character = bcg_c;
	  *bcg_nb_scanned_characters = 1;
	  return (BCG_SCAN_OK);
     } else {
	  /* escape sequence starting with a backslash */
	  bcg_c = bcg_text[1];
	  switch (bcg_c) {
	  case 'a':
	       *bcg_character = '\a';
	       *bcg_nb_scanned_characters = 2;
	       return (BCG_SCAN_OK);
	  case 'b':
	       *bcg_character = '\b';
	       *bcg_nb_scanned_characters = 2;
	       return (BCG_SCAN_OK);
	  case 'f':
	       *bcg_character = '\f';
	       *bcg_nb_scanned_characters = 2;
	       return (BCG_SCAN_OK);
	  case 'n':
	       *bcg_character = '\n';
	       *bcg_nb_scanned_characters = 2;
	       return (BCG_SCAN_OK);
	  case 'r':
	       *bcg_character = '\r';
	       *bcg_nb_scanned_characters = 2;
	       return (BCG_SCAN_OK);
	  case 't':
	       *bcg_character = '\t';
	       *bcg_nb_scanned_characters = 2;
	       return (BCG_SCAN_OK);
	  case 'v':
	       *bcg_character = '\v';
	       *bcg_nb_scanned_characters = 2;
	       return (BCG_SCAN_OK);
	  case '\"':
	       *bcg_character = '\"';
	       *bcg_nb_scanned_characters = 2;
	       return (BCG_SCAN_OK);
	  case '\\':
	       *bcg_character = '\\';
	       *bcg_nb_scanned_characters = 2;
	       return (BCG_SCAN_OK);
	  case '\'':
	       *bcg_character = '\'';
	       *bcg_nb_scanned_characters = 2;
	       return (BCG_SCAN_OK);
	  case '\?':
	       *bcg_character = '\?';
	       *bcg_nb_scanned_characters = 2;
	       return (BCG_SCAN_OK);
	  case '0':
	  case '1':
	  case '2':
	  case '3':
	       if (bcg_isodigit (bcg_text[2]) && bcg_isodigit (bcg_text[3])) {
		    /* escape sequence \OOO, where O are octal digits */
		    *bcg_character = (bcg_type_character) (
							64 * (bcg_c - '0') +
						   8 * (bcg_text[2] - '0') +
						       (bcg_text[3] - '0'));
		    *bcg_nb_scanned_characters = 4;
		    return (BCG_SCAN_OK);
	       } else if (bcg_c == '0') {
		    /* escape sequence \0 */
		    *bcg_character = '\0';
		    *bcg_nb_scanned_characters = 2;
		    return (BCG_SCAN_OK);
	       } else
		    return (BCG_SCAN_NOK_BAD_OCTAL);
	  case 'x':
	       if (isxdigit (bcg_text[2]) && isxdigit (bcg_text[3])) {
		    /* escape sequence \xXX, where X are hexa digits */
		    *bcg_character = (bcg_type_character) (
				(16 * BCG_HEXADECIMAL_VALUE (bcg_text[2])) +
				       BCG_HEXADECIMAL_VALUE (bcg_text[3]));
		    *bcg_nb_scanned_characters = 4;
		    return (BCG_SCAN_OK);
	       } else
		    return (BCG_SCAN_NOK_BAD_HEXADECIMAL);
	  default:
	       /*
	        * unexpected or unfinished escape sequence (including the
	        * case where bcg_c == '\0')
	        */
	       return (BCG_SCAN_NOK_BAD_ESCAPE);
	  }
     }
}

BCG_TYPE_SCAN_RESULT bcg_character_scan (bcg_text, bcg_character)
BCG_TYPE_C_STRING bcg_text;
bcg_type_character *bcg_character;
{
     BCG_TYPE_NATURAL bcg_length, bcg_nb_scanned_characters;
     BCG_TYPE_SCAN_RESULT bcg_result;

     /*
      * this function scans bcg_text to extract a character denotation of the
      * form '...' (which may contain an escape sequence starting with a
      * backslash); on success, it returns BCG_SCAN_OK, copies the character
      * value in (*bcg_character), and sets (*bcg_nb_scanned_characters) to
      * the length of the denotation; on error, an appropriate result
      * BCG_SCAN_NOK... is returned and (*bcg_character) is undefined
      */

     if (bcg_text[0] != '\'')
	  return (BCG_SCAN_NOK);

     bcg_length = (BCG_TYPE_NATURAL) strlen (bcg_text);
     /* assert: bcg_length >= 1 */

     if (bcg_text[bcg_length - 1] == ']') {
	  /* silently reject CHP constants of the form '2.1.1.2'[3] */
	  return (BCG_SCAN_NOK);
     }
     bcg_result = bcg_core_character_scan (&(bcg_text[1]), bcg_character, &bcg_nb_scanned_characters);

     switch (bcg_result) {
     case BCG_SCAN_NOK:
	  /* bcg_text[1] is '\0' : bcg_text is a single quote */
	  return (BCG_SCAN_NOK_BAD_CHARACTER);
     case BCG_SCAN_NOK_BAD_OCTAL:
     case BCG_SCAN_NOK_BAD_HEXADECIMAL:
     case BCG_SCAN_NOK_BAD_ESCAPE:
	  /* bcg_text[1...] contains an incorrect escape sequence */
	  return (bcg_result);
     case BCG_SCAN_OK:
	  /* bcg_text[1...] starts with a valid character */
	  /* here, (*bcg_character) has been duly assigned */
	  if (bcg_text[bcg_length - 1] != '\'') {
	       /* bcg_text begins with, but does not end with a quote */
	       return (BCG_SCAN_NOK_BAD_CHARACTER);
	  } else if (bcg_nb_scanned_characters < bcg_length - 2) {
	       /* bcg_text is too long (contains more than one character) */
	       return (BCG_SCAN_NOK_BAD_CHARACTER);
	  } else if (bcg_nb_scanned_characters > bcg_length - 2) {
	       /* bcg_text is too short (it has the invalid form '\') */
	       return (BCG_SCAN_NOK_BAD_CHARACTER);
	  } else if ((*bcg_character == '\'') && (bcg_nb_scanned_characters == 1)) {
	       /* bcg_text has the invalid form ''' */
	       return (BCG_SCAN_NOK_BAD_CHARACTER);
	  } else
	       return (BCG_SCAN_OK);
     }
     /* NOTREACHED */
#ifdef __GNUC__
     return BCG_SCAN_NOK;	/* to keep "gcc -Wall" silent */
#endif
}

#endif
#endif

/*---------------------------------------------------------------------------*/
/* Character type / Binary write                                             */
/*---------------------------------------------------------------------------*/

#if defined (ADT_CHARACTER_BCG_DEFINITIONS)
#if defined (BCG_PREDEFINED_DECLARATIONS_SPECIAL_INCLUSION_1)

extern void bcg_character_write BCG_ARG_3 (BCG_TYPE_STREAM, bcg_type_character, BCG_TYPE_NATURAL *);

#else

void bcg_character_write (bcg_file, bcg_character, bcg_size)
BCG_TYPE_STREAM bcg_file;
bcg_type_character bcg_character;
BCG_TYPE_NATURAL *bcg_size;
{
     BCG_PUSH_WRITE_FILE (bcg_file);
     BCG_WRITE_BLOCK ((BCG_TYPE_BLOCK) & bcg_character, bcg_character_size);
     *bcg_size = bcg_character_size;
     BCG_PULL_WRITE_FILE ();
}

#endif
#endif

/*---------------------------------------------------------------------------*/
/* Character type / Binary read                                              */
/*---------------------------------------------------------------------------*/

#if defined (ADT_CHARACTER_BCG_DEFINITIONS)
#if defined (BCG_PREDEFINED_DECLARATIONS_SPECIAL_INCLUSION_1)

extern void bcg_character_read BCG_ARG_3 (BCG_TYPE_STREAM, bcg_type_character *, BCG_TYPE_NATURAL *);

#else

void bcg_character_read (bcg_file, bcg_character, bcg_size)
BCG_TYPE_STREAM bcg_file;
bcg_type_character *bcg_character;
BCG_TYPE_NATURAL *bcg_size;
{
     BCG_PUSH_READ_FILE (bcg_file);
     BCG_READ_BLOCK ((BCG_TYPE_BLOCK) bcg_character, bcg_character_size);
     *bcg_size = bcg_character_size;
     BCG_PULL_READ_FILE ();
}

#endif
#endif

/*---------------------------------------------------------------------------*/
/* Character type / End of list                                              */
/*---------------------------------------------------------------------------*/
