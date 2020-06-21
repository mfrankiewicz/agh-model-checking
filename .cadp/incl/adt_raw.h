/******************************************************************************
 *   			            C A D P
 *-----------------------------------------------------------------------------
 *   INRIA - Centre de Recherche de Grenoble Rhone-Alpes
 *   655, avenue de l'Europe
 *   38330 Montbonnot Saint Martin
 *   FRANCE
 *-----------------------------------------------------------------------------
 *   Module		:	adt_raw.h
 *   Auteur		:	Hubert GARAVEL
 *   Version		:	1.24
 *   Date		: 	2017/09/26 18:48:56
 *****************************************************************************/

#if defined (ADT_RAW_ADT_ALREADY_INCLUDED)
#undef ADT_RAW_ADT_DEFINITIONS
#elif defined (ADT_X_RAW)
#define ADT_RAW_ADT_ALREADY_INCLUDED
#define ADT_RAW_ADT_DEFINITIONS
#endif

#if defined (ADT_RAW_BCG_ALREADY_INCLUDED)
#undef ADT_RAW_BCG_DEFINITIONS
#elif defined (BCG_PREDEFINED_DECLARATIONS_INTERFACE)
#define ADT_RAW_BCG_ALREADY_INCLUDED
#define ADT_RAW_BCG_DEFINITIONS
#endif

#if defined (ADT_RAW_XTL_ALREADY_INCLUDED)
#undef ADT_RAW_XTL_DEFINITIONS
#elif defined (XTL_STANDARD_INTERFACE)
#define ADT_RAW_XTL_ALREADY_INCLUDED
#define ADT_RAW_XTL_DEFINITIONS
#endif

/*---------------------------------------------------------------------------*/
/* RAW type / Includes and preliminary definitions                           */
/*---------------------------------------------------------------------------*/

#include <strings.h>

/*---------------------------------------------------------------------------*/
/* Raw type / Implementation                                                 */
/*---------------------------------------------------------------------------*/

#if defined (ADT_RAW_BCG_DEFINITIONS)

#if defined (BCG_PREDEFINED_DECLARATIONS_SPECIAL_INCLUSION_1)
/*
 * here, bcg_raw_length needs not be defined, as its value is not needed
 */
typedef char *bcg_type_raw;

#elif defined (BCG_PREDEFINED_DECLARATIONS_SPECIAL_INCLUSION_2)
/*
 * here, bcg_raw_length is a macro expanding to a global variable with a
 * defined value computed at run time; the value of this variable evolves in
 * time; bcg_raw_length == 0 iff no raw value has been recognized so far;
 * otherwise, bcg_raw_length > 0 as the string-termination character '\0' is
 * counted in the value of bcg_raw_length
 */
typedef char *bcg_type_raw;

#else
/*
 * here, bcg_raw_length is a macro defined to be a constant (this macro is
 * defined in the include area of BCG files, before the present file is
 * included); bcg_raw_length == 0 iff no raw value occurs in the present BCG
 * file; otherwise, bcg_raw_length > 0 as the string-termination character
 * '\0' is counted in the value of bcg_raw_length
 */

#if bcg_raw_length == 0
typedef char *bcg_type_raw;	/* void type */
#else
typedef char bcg_type_raw[bcg_raw_length];
#endif

#endif

#endif

/*---------------------------------------------------------------------------*/
/* Raw type / Size in bits                                                   */
/*---------------------------------------------------------------------------*/

#if defined (ADT_RAW_BCG_DEFINITIONS)

#define bcg_raw_size (bcg_raw_length * 8)

/*
 * bcg_raw_size is the maximal number of bits needed to store in memory any
 * of the raw values contained in the BCG file; this size includes the
 * string-termination character '\0'
 */

#endif

/*---------------------------------------------------------------------------*/
/* Raw type / Scalarity                                                      */
/*---------------------------------------------------------------------------*/

/*---------------------------------------------------------------------------*/
/* Raw type / Assignment                                                     */
/*---------------------------------------------------------------------------*/

#if defined (ADT_RAW_BCG_DEFINITIONS)

#define bcg_raw_assign(bcg_1,bcg_2) strcpy ((bcg_1), (bcg_2))

#endif

/*---------------------------------------------------------------------------*/
/* Raw type / Canonicity                                                     */
/*---------------------------------------------------------------------------*/

/*---------------------------------------------------------------------------*/
/* Raw type / Equality                                                       */
/*---------------------------------------------------------------------------*/

#if defined (ADT_RAW_BCG_DEFINITIONS)

#define bcg_raw_cmp(bcg_1,bcg_2) (strcmp ((bcg_1), (bcg_2)) == 0)

#endif

/*---------------------------------------------------------------------------*/
/* Raw type / Iteration                                                      */
/*---------------------------------------------------------------------------*/

/* no iterator */

/*---------------------------------------------------------------------------*/
/* Raw type / Print                                                          */
/*---------------------------------------------------------------------------*/

#if defined (ADT_RAW_BCG_DEFINITIONS)
#if defined (BCG_PREDEFINED_DECLARATIONS_SPECIAL_INCLUSION_1)

extern void bcg_raw_print BCG_ARG_2 (BCG_TYPE_STREAM, bcg_type_raw);

#else

void bcg_raw_print (bcg_file, bcg_0)
BCG_TYPE_STREAM bcg_file;
bcg_type_raw bcg_0;

{
     char *bcg_c;

     for (bcg_c = (bcg_0); *bcg_c != '\0'; ++bcg_c)
	  bcg_core_character_print ((bcg_file), *bcg_c);
}

#endif
#endif

/*---------------------------------------------------------------------------*/
/* Raw type / Scan                                                           */
/*---------------------------------------------------------------------------*/

#if defined (ADT_RAW_BCG_DEFINITIONS)
#if defined (BCG_PREDEFINED_DECLARATIONS_SPECIAL_INCLUSION_1)

extern BCG_TYPE_SCAN_RESULT bcg_raw_scan BCG_ARG_2 (BCG_TYPE_C_STRING, bcg_type_raw *);

#else

BCG_TYPE_SCAN_RESULT bcg_raw_scan (bcg_text, bcg_raw)
BCG_TYPE_C_STRING bcg_text;
bcg_type_raw *bcg_raw;
{
     BCG_TYPE_C_STRING bcg_t, bcg_r;
     BCG_TYPE_NATURAL bcg_nb_scanned_characters;
     BCG_TYPE_SCAN_RESULT bcg_result;
     enum {
	  bcg_s_outside,
	  bcg_s_inside_character,
	  bcg_s_inside_string
     }    bcg_current_s;	/* current state of the automaton */

#if defined (BCG_PREDEFINED_DECLARATIONS_SPECIAL_INCLUSION_2)
     static bcg_type_raw bcg_raw_buffer;
     static BCG_TYPE_NATURAL bcg_raw_buffer_length = 0;
#endif

     /*
      * this function scans bcg_text to extract a raw value denotation
      * (possibly containing escape sequences starting with a backslash); on
      * success, it returns BCG_SCAN_OK, copies the string value in
      * (*bcg_raw); on error, an appropriate result BCG_SCAN_NOK... is
      * returned and (*bcg_raw) is generally undefined; however, when
      * BCG_SCAN_NOK_BAD_OCTAL, BCG_SCAN_NOK_BAD_HEXADECIMAL,
      * BCG_SCAN_NOK_BAD_ESCAPE, or BCG_SCAN_NOK_BAD_RAW are returned,
      * (*bcg_raw) is set to the suffix of bcg_text starting at the first
      * invalid escape sequence (such information is useful to produce error
      * diagnostics)
      */

     /*
      * the following post-condition holds: when BCG_SCAN_NOK is returned,
      * strlen (bcg_raw) <= strlen (bcg_text); that is, if bcg_raw was
      * allocated with the same number of bytes as bcg_text before calling
      * bcg_raw_scan(), no buffer overflow will occur inside this function
      */

#if defined (BCG_PREDEFINED_DECLARATIONS_SPECIAL_INCLUSION_2)
     if (bcg_raw_length == 0) {
	  /*
	   * no raw value has been successfully scanned so far; one needs to
	   * allocate a buffer of sufficient size, e.g., bcg_max_label_length
	   * (a valid smaller size could be: strlen (bcg_text) + 1)
	   */
	  /* assert (bcg_raw_buffer_length == 0) */
	  bcg_raw_buffer = (bcg_type_raw) malloc (bcg_max_label_length);
	  if (bcg_raw_buffer == NULL)
	       return (BCG_SCAN_NOK_MEMORY_SHORTAGE);
	  bcg_raw_buffer_length = bcg_max_label_length;
     } else if (bcg_raw_buffer_length < bcg_raw_length) {
	  /*
	   * the value of bcg_raw_length has increased and is now larger than
	   * the allocated buffer size
	   */
	  if (bcg_raw_buffer_length > 0)
	       free (bcg_raw_buffer);
	  bcg_raw_buffer = (bcg_type_raw) malloc (bcg_raw_length);
	  if (bcg_raw_buffer == NULL)
	       return (BCG_SCAN_NOK_MEMORY_SHORTAGE);
	  bcg_raw_buffer_length = bcg_raw_length;
     }
     *bcg_raw = bcg_raw_buffer;
#endif

     bcg_t = &(bcg_text[0]);

     bcg_r = *bcg_raw;

     bcg_current_s = bcg_s_outside;

     while (BCG_TRUE) {
	  bcg_result = bcg_core_character_scan (bcg_t, bcg_r, &bcg_nb_scanned_characters);

	  switch (bcg_result) {
	  case BCG_SCAN_NOK:
	       /* (*bcg_t) is a NUL character : normal termination */
	       *bcg_r = '\0';
	       return (BCG_SCAN_OK);
	  case BCG_SCAN_NOK_BAD_OCTAL:
	  case BCG_SCAN_NOK_BAD_HEXADECIMAL:
	       /* bcg_t[0...] contains an incorrect escape sequence */
	       /* return in (*bcg_raw) the offending string fragment */
	       strcpy (*bcg_raw, bcg_t);
	       return (bcg_result);
	  case BCG_SCAN_NOK_BAD_ESCAPE:
	       /* assert (*bcg_t) == '\\' */
	       if (*(bcg_t + 1) == '!') {
		    /* bcg_t[0...] starts with an escape sequence '\!' */
		    switch (bcg_current_s) {
		    case bcg_s_outside:
			 /* the '\' before '!' must be kept */
			 *bcg_r = '\\';
			 ++bcg_r;
			 break;
		    case bcg_s_inside_character:
		    case bcg_s_inside_string:
			 /* the '\' before '!' can be removed */
			 break;
		    }
		    *bcg_r = '!';
		    ++bcg_r;
		    bcg_t += 2;
		    break;
	       } else {
		    /* bcg_t[0...] contains an incorrect escape sequence */
		    /* return in (*bcg_raw) the offending string fragment */
		    strcpy (*bcg_raw, bcg_t);
		    return (bcg_result);
	       }
	  case BCG_SCAN_OK:
	       /* bcg_t[0...] starts with a valid character */
	       /* here, (*bcg_r) has been duly assigned */
	       switch (*bcg_r) {
	       case '\\':
		    /* the output character always needs to be escaped */
		    ++bcg_r;
		    *bcg_r = '\\';
		    break;
	       case '!':
		    if (bcg_current_s == bcg_s_outside) {
			 if (bcg_nb_scanned_characters == 1) {
			      /*
			       * the input character was not duly escaped;
			       * this error should not be repaired by
			       * automatically inserting the missing
			       * backslash in (*bcg_r) because this could
			       * violate the above post-condition: for
			       * instance, if bcg_text is "!!!", (*bcg_r)
			       * would be "\!\!\!", so that the length of the
			       * output string could reach the double of that
			       * of the input string
			       */
			      /*
			       * return in (*bcg_raw) the offending string
			       * fragment
			       */
			      strcpy (*bcg_raw, bcg_t);
			      return (BCG_SCAN_NOK_BAD_RAW);
			 } else {
			      /* assert (bcg_nb_scanned_characters > 1) */
			      /*
			       * here, the output character needs to be
			       * escaped
			       */
			      *bcg_r = '\\';
			      ++bcg_r;
			      *bcg_r = '!';
			 }
		    }
		    break;
	       case '\'':
		    if (bcg_nb_scanned_characters == 1) {
			 /* the input character was not escaped */
			 if (bcg_current_s == bcg_s_outside) {
			      /* begin an embedded character */
			      bcg_current_s = bcg_s_inside_character;
			 } else if (bcg_current_s == bcg_s_inside_character) {
			      /* end an embedded character */
			      bcg_current_s = bcg_s_outside;
			 }
		    } else {
			 /* assert (bcg_nb_scanned_characters > 1) */
			 /* the input character was escaped */
			 if (bcg_current_s != bcg_s_inside_string) {
			      /*
			       * here, the output character needs to be
			       * escaped
			       */
			      *bcg_r = '\\';
			      ++bcg_r;
			      *bcg_r = '\'';
			 }
		    }
		    break;
	       case '\"':
		    if (bcg_nb_scanned_characters == 1) {
			 /* the input character was not escaped */
			 if (bcg_current_s == bcg_s_outside) {
			      /* begin an embedded string */
			      bcg_current_s = bcg_s_inside_string;
			 } else if (bcg_current_s == bcg_s_inside_string) {
			      /* end an embedded string */
			      bcg_current_s = bcg_s_outside;
			 }
		    } else {
			 /* assert (bcg_nb_scanned_characters > 1) */
			 /* the input character was escaped */
			 if (bcg_current_s != bcg_s_inside_character) {
			      /* assert (bcg_nb_scanned_characters > 1) */
			      /*
			       * here, the output character needs to be
			       * escaped
			       */
			      *bcg_r = '\\';
			      ++bcg_r;
			      *bcg_r = '\"';
			 }
		    }
		    break;
	       default:
		    break;
	       }
	       ++bcg_r;
	       bcg_t += bcg_nb_scanned_characters;
	  }
	  /* proceed to the next loop iteration */
     }
     /* NOTREACHED */
}

#endif
#endif

/*---------------------------------------------------------------------------*/
/* Raw type / Binary write                                                   */
/*---------------------------------------------------------------------------*/

#if defined (ADT_RAW_BCG_DEFINITIONS)
#if defined (BCG_PREDEFINED_DECLARATIONS_SPECIAL_INCLUSION_1)

extern void bcg_raw_write BCG_ARG_3 (BCG_TYPE_STREAM, bcg_type_raw, BCG_TYPE_NATURAL *);

#else

void bcg_raw_write (bcg_file, bcg_raw, bcg_size)
BCG_TYPE_STREAM bcg_file;
bcg_type_raw bcg_raw;
BCG_TYPE_NATURAL *bcg_size;
{
     BCG_PUSH_WRITE_FILE (bcg_file);
     BCG_WRITE_STRING ((BCG_TYPE_C_STRING) bcg_raw);
     *bcg_size = 8 * (strlen ((char *) bcg_raw) + 1);
     BCG_PULL_WRITE_FILE ();
}

#endif
#endif

/*---------------------------------------------------------------------------*/
/* Raw type / Binary read                                                    */
/*---------------------------------------------------------------------------*/

#if defined (ADT_RAW_BCG_DEFINITIONS)
#if defined (BCG_PREDEFINED_DECLARATIONS_SPECIAL_INCLUSION_1)

extern void bcg_raw_read BCG_ARG_3 (BCG_TYPE_STREAM, bcg_type_raw *, BCG_TYPE_NATURAL *);

#else

void bcg_raw_read (bcg_file, bcg_raw, bcg_size)
BCG_TYPE_STREAM bcg_file;
bcg_type_raw *bcg_raw;
BCG_TYPE_NATURAL *bcg_size;
{
     BCG_TYPE_C_STRING bcg_pointer;

     BCG_PUSH_READ_FILE (bcg_file);
     /* the following assignment is mandatory to avoid type cast problems */
     bcg_pointer = (BCG_TYPE_C_STRING) (*bcg_raw);
     BCG_READ_STRING (&bcg_pointer);
     *bcg_size = 8 * (strlen (bcg_pointer) + 1);
     BCG_PULL_READ_FILE ();
}

#endif
#endif

/*---------------------------------------------------------------------------*/
/* Raw type / End of list                                                    */
/*---------------------------------------------------------------------------*/
