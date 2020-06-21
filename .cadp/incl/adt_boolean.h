/******************************************************************************
 *   			            C A D P
 *-----------------------------------------------------------------------------
 *   INRIA - Centre de Recherche de Grenoble Rhone-Alpes
 *   655, avenue de l'Europe
 *   38330 Montbonnot Saint Martin
 *   FRANCE
 *-----------------------------------------------------------------------------
 *   Module		:	adt_boolean.h
 *   Auteur		:	Hubert GARAVEL
 *   Version		:	1.18
 *   Date		: 	2017/09/26 18:47:42
 *****************************************************************************/

#if defined (ADT_BOOLEAN_ADT_ALREADY_INCLUDED)
#undef ADT_BOOLEAN_ADT_DEFINITIONS
#elif defined (ADT_X_BOOLEAN)
#define ADT_BOOLEAN_ADT_ALREADY_INCLUDED
#define ADT_BOOLEAN_ADT_DEFINITIONS
#endif

#if defined (ADT_BOOLEAN_BCG_ALREADY_INCLUDED)
#undef ADT_BOOLEAN_BCG_DEFINITIONS
#elif defined (BCG_PREDEFINED_DECLARATIONS_INTERFACE)
#define ADT_BOOLEAN_BCG_ALREADY_INCLUDED
#define ADT_BOOLEAN_BCG_DEFINITIONS
#endif

#if defined (ADT_BOOLEAN_XTL_ALREADY_INCLUDED)
#undef ADT_BOOLEAN_XTL_DEFINITIONS
#elif defined (XTL_STANDARD_INTERFACE)
#define ADT_BOOLEAN_XTL_ALREADY_INCLUDED
#define ADT_BOOLEAN_XTL_DEFINITIONS
#endif

/*---------------------------------------------------------------------------*/
/* Boolean type / Includes and preliminary definitions                       */
/*---------------------------------------------------------------------------*/

#if defined (ADT_BOOLEAN_BCG_DEFINITIONS)

#include <strings.h>		/* for strcasecmp() */

#endif

/*---------------------------------------------------------------------------*/
/* Boolean type / Implementation                                             */
/*---------------------------------------------------------------------------*/

#if defined (ADT_BOOLEAN_ADT_DEFINITIONS)

typedef unsigned char ADT_BOOL;

#endif

/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */

#if defined (ADT_BOOLEAN_BCG_DEFINITIONS) || \
    defined (ADT_BOOLEAN_XTL_DEFINITIONS)

typedef unsigned char bcg_type_boolean;

#endif

/*---------------------------------------------------------------------------*/
/* Boolean type / Size in bits                                               */
/*---------------------------------------------------------------------------*/

#if defined (ADT_BOOLEAN_ADT_DEFINITIONS)

#ifndef lint
#define CAESAR_ADT_BITS_ADT_BOOL : 1
#endif

#endif

/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */

#if defined (ADT_BOOLEAN_BCG_DEFINITIONS)

#define bcg_boolean_size ((BCG_TYPE_NATURAL) 1)

#endif

/*---------------------------------------------------------------------------*/
/* Boolean type / Scalarity                                                  */
/*---------------------------------------------------------------------------*/

#if defined (ADT_BOOLEAN_ADT_DEFINITIONS)

#define CAESAR_ADT_SCALAR_ADT_BOOL

#endif

/*---------------------------------------------------------------------------*/
/* Boolean type / Assignment                                                 */
/*---------------------------------------------------------------------------*/

#if defined (ADT_BOOLEAN_BCG_DEFINITIONS)

#define bcg_boolean_assign(bcg_1,bcg_2) (bcg_1) = (bcg_2)

#endif

/*---------------------------------------------------------------------------*/
/* Boolean type / Canonicity                                                 */
/*---------------------------------------------------------------------------*/

/* not uncanonical */

/*---------------------------------------------------------------------------*/
/* Boolean type / Equality                                                   */
/*---------------------------------------------------------------------------*/

#if defined (ADT_BOOLEAN_ADT_DEFINITIONS)

#define ADT_CMP_BOOL(X1,X2) ((X1) == (X2))

#endif

/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */

#if defined (ADT_BOOLEAN_BCG_DEFINITIONS)

#define bcg_boolean_cmp(bcg_1,bcg_2) ((bcg_1) == (bcg_2))

#endif

/*---------------------------------------------------------------------------*/
/* Boolean type / Iteration                                                  */
/*---------------------------------------------------------------------------*/

#if defined (ADT_BOOLEAN_ADT_DEFINITIONS)

#define ADT_ENUM_FIRST_BOOL() (ADT_FALSE ())
#define ADT_ENUM_NEXT_BOOL(X) ((X)++ < ADT_TRUE ())

#endif

/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */

#if defined (ADT_BOOLEAN_BCG_DEFINITIONS)

#define bcg_boolean_enum(bcg_0) for ((bcg_0) = 0; (bcg_0) != 2; (bcg_0)++)

#endif

/*---------------------------------------------------------------------------*/
/* Boolean type / Print                                                      */
/*---------------------------------------------------------------------------*/

#if defined (ADT_BOOLEAN_ADT_DEFINITIONS)

#define ADT_PRINT_BOOL(F,X) fprintf ((F), (X) ? "TRUE" : "FALSE")

#endif

/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */

#if defined (ADT_BOOLEAN_BCG_DEFINITIONS)

#define bcg_boolean_print(bcg_file,bcg_0) fprintf ((bcg_file), "%s", (bcg_0) ? "TRUE" : "FALSE")

#endif

/*---------------------------------------------------------------------------*/
/* Boolean type / Scan                                                       */
/*---------------------------------------------------------------------------*/

#if defined (ADT_BOOLEAN_BCG_DEFINITIONS)
#if defined (BCG_PREDEFINED_DECLARATIONS_SPECIAL_INCLUSION_1)

extern BCG_TYPE_SCAN_RESULT bcg_boolean_scan BCG_ARG_2 (BCG_TYPE_C_STRING, bcg_type_boolean *);

#else

BCG_TYPE_SCAN_RESULT bcg_boolean_scan (bcg_text, bcg_boolean)
BCG_TYPE_C_STRING bcg_text;
bcg_type_boolean *bcg_boolean;
{
     /* tentative de lire le booleen TRUE */

     if (strcasecmp (bcg_text, "TRUE") == 0) {
	  *bcg_boolean = BCG_TRUE;
	  return (BCG_SCAN_OK);
     }
     /* tentative de lire le booleen FALSE */

     if (strcasecmp (bcg_text, "FALSE") == 0) {
	  *bcg_boolean = BCG_FALSE;
	  return (BCG_SCAN_OK);
     }
     return (BCG_SCAN_NOK);
}

#endif
#endif

/*---------------------------------------------------------------------------*/
/* Boolean type / Binary write                                               */
/*---------------------------------------------------------------------------*/

#if defined (ADT_BOOLEAN_BCG_DEFINITIONS)
#if defined (BCG_PREDEFINED_DECLARATIONS_SPECIAL_INCLUSION_1)

extern void bcg_boolean_write BCG_ARG_3 (BCG_TYPE_STREAM, bcg_type_boolean, BCG_TYPE_NATURAL *);

#else

void bcg_boolean_write (bcg_file, bcg_boolean, bcg_size)
BCG_TYPE_STREAM bcg_file;
bcg_type_boolean bcg_boolean;
BCG_TYPE_NATURAL *bcg_size;
{
     bcg_type_boolean bcg_working_boolean;

     BCG_PUSH_WRITE_FILE (bcg_file);
     bcg_working_boolean = (bcg_type_boolean) (bcg_boolean ? (1 << 7) : 0);
     BCG_WRITE_BLOCK ((BCG_TYPE_BLOCK) & bcg_working_boolean, bcg_boolean_size);
     *bcg_size = bcg_boolean_size;
     BCG_PULL_WRITE_FILE ();
}

#endif
#endif

/*---------------------------------------------------------------------------*/
/* Boolean type / Binary read                                                */
/*---------------------------------------------------------------------------*/

#if defined (ADT_BOOLEAN_BCG_DEFINITIONS)
#if defined (BCG_PREDEFINED_DECLARATIONS_SPECIAL_INCLUSION_1)

extern void bcg_boolean_read BCG_ARG_3 (BCG_TYPE_STREAM, bcg_type_boolean *, BCG_TYPE_NATURAL *);

#else

void bcg_boolean_read (bcg_file, bcg_boolean, bcg_size)
BCG_TYPE_STREAM bcg_file;
bcg_type_boolean *bcg_boolean;
BCG_TYPE_NATURAL *bcg_size;
{
     BCG_PUSH_READ_FILE (bcg_file);
     BCG_READ_BLOCK ((BCG_TYPE_BLOCK) bcg_boolean, bcg_boolean_size);
     *bcg_boolean = (bcg_type_boolean) ((*bcg_boolean) >> 7);
     *bcg_size = bcg_boolean_size;
     BCG_PULL_READ_FILE ();
}

#endif
#endif

/*---------------------------------------------------------------------------*/
/* Boolean type / End of list                                                */
/*---------------------------------------------------------------------------*/
