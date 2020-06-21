/******************************************************************************
 *   			            C A D P
 *-----------------------------------------------------------------------------
 *   INRIA - Centre de Recherche de Grenoble Rhone-Alpes
 *   655, avenue de l'Europe
 *   38330 Montbonnot Saint Martin
 *   FRANCE
 *-----------------------------------------------------------------------------
 *   Module		:	adt_real.h
 *   Auteur		:	Hubert GARAVEL
 *   Version		:	1.20
 *   Date		: 	2017/09/26 18:48:20
 *****************************************************************************/

#if defined (ADT_REAL_ADT_ALREADY_INCLUDED)
#undef ADT_REAL_ADT_DEFINITIONS
#elif defined (ADT_X_REAL)
#define ADT_REAL_ADT_ALREADY_INCLUDED
#define ADT_REAL_ADT_DEFINITIONS
#endif

#if defined (ADT_REAL_BCG_ALREADY_INCLUDED)
#undef ADT_REAL_BCG_DEFINITIONS
#elif defined (BCG_PREDEFINED_DECLARATIONS_INTERFACE)
#define ADT_REAL_BCG_ALREADY_INCLUDED
#define ADT_REAL_BCG_DEFINITIONS
#endif

#if defined (ADT_REAL_XTL_ALREADY_INCLUDED)
#undef ADT_REAL_XTL_DEFINITIONS
#elif defined (XTL_STANDARD_INTERFACE)
#define ADT_REAL_XTL_ALREADY_INCLUDED
#define ADT_REAL_XTL_DEFINITIONS
#endif

/*---------------------------------------------------------------------------*/
/* Real type / Includes and preliminary definitions                           */
/*---------------------------------------------------------------------------*/

#if defined (ADT_REAL_BCG_DEFINITIONS)

#include <stdlib.h>		/* for strtod() */

#endif

/*---------------------------------------------------------------------------*/
/* Real type / Implementation                                                */
/*---------------------------------------------------------------------------*/

#if defined (ADT_REAL_ADT_DEFINITIONS)

#ifndef ADT_REAL
typedef double ADT_REAL;
#endif

#endif

/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */

#if defined (ADT_REAL_BCG_DEFINITIONS) || \
    defined (ADT_REAL_XTL_DEFINITIONS)

typedef double bcg_type_real;

#endif

/*---------------------------------------------------------------------------*/
/* Real type / Size in bits                                                  */
/*---------------------------------------------------------------------------*/

#if defined (ADT_REAL_ADT_DEFINITIONS)

/* no bit field */

#endif

/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */

#if defined (ADT_REAL_BCG_DEFINITIONS)

#define bcg_real_size ((BCG_TYPE_NATURAL) sizeof (bcg_type_real) * 8)

#endif

/*---------------------------------------------------------------------------*/
/* Real type / Scalarity                                                     */
/*---------------------------------------------------------------------------*/

#if defined (ADT_REAL_ADT_DEFINITIONS)

#define CAESAR_ADT_SCALAR_ADT_REAL

#endif

/*---------------------------------------------------------------------------*/
/* Real type / Assignment                                                    */
/*---------------------------------------------------------------------------*/

#if defined (ADT_REAL_BCG_DEFINITIONS)

#define bcg_real_assign(bcg_1,bcg_2) (bcg_1) = (bcg_2)

#endif

/*---------------------------------------------------------------------------*/
/* Real type / Canonicity                                                    */
/*---------------------------------------------------------------------------*/

/* not uncanonical */

/*---------------------------------------------------------------------------*/
/* Real type / Equality                                                      */
/*---------------------------------------------------------------------------*/

#if defined (ADT_REAL_ADT_DEFINITIONS)

#define ADT_CMP_REAL(X1,X2) ((X1) == (X2))

#endif

/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */

#if defined (ADT_REAL_BCG_DEFINITIONS)

#define bcg_real_cmp(bcg_1,bcg_2) ((bcg_1) == (bcg_2))

#endif

/*---------------------------------------------------------------------------*/
/* Real type / Iteration                                                     */
/*---------------------------------------------------------------------------*/

/* no iterator */

/*---------------------------------------------------------------------------*/
/* Real type / Print [DIVERGENCE!]                                           */
/*---------------------------------------------------------------------------*/

#if defined (ADT_REAL_ADT_DEFINITIONS)

#define ADT_PRINT_REAL(F,X) fprintf((F), "%G", (double) (X))

#endif

/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */

#if defined (ADT_REAL_BCG_DEFINITIONS)

#define bcg_real_print(bcg_file,bcg_0) fprintf ((bcg_file), "%f", (bcg_0))

#endif

/*---------------------------------------------------------------------------*/
/* Real type / Scan                                                          */
/*---------------------------------------------------------------------------*/

#if defined (ADT_REAL_BCG_DEFINITIONS)
#if defined (BCG_PREDEFINED_DECLARATIONS_SPECIAL_INCLUSION_1)

extern BCG_TYPE_SCAN_RESULT bcg_real_scan BCG_ARG_2 (BCG_TYPE_C_STRING, bcg_type_real *);

#else

BCG_TYPE_SCAN_RESULT bcg_real_scan (bcg_text, bcg_real)
BCG_TYPE_C_STRING bcg_text;
bcg_type_real *bcg_real;
{
     bcg_type_real bcg_r;
     BCG_TYPE_C_STRING bcg_pointer;

     errno = 0;
     bcg_r = strtod (bcg_text, &bcg_pointer);
     if ((errno == 0) && (bcg_text != bcg_pointer) && (*bcg_pointer == '\0')) {
	  *bcg_real = bcg_r;
	  return (BCG_SCAN_OK);
     }
     if (errno == ERANGE) {
	  /*
	   * at this point, on Solaris, a floating-point exception should
	   * have already been raised (according to the strtod() manual page)
	   */
	  if ((bcg_r == -HUGE_VAL) || (bcg_r == +HUGE_VAL)) {
	       return (BCG_SCAN_NOK_OVERFLOW);
	  } else {
	       /* assert bcg_r == 0 (at least on Linux and macOS) */
	       return (BCG_SCAN_NOK_UNDERFLOW);
	  }
     }
     /* assert errno == EINVAL (at least on Solaris) */
     /* assert bcg_r == 0 */
     return (BCG_SCAN_NOK);
}

#endif
#endif

/*---------------------------------------------------------------------------*/
/* Real type / Binary write                                                  */
/*---------------------------------------------------------------------------*/

#if defined (ADT_REAL_BCG_DEFINITIONS)
#if defined (BCG_PREDEFINED_DECLARATIONS_SPECIAL_INCLUSION_1)

extern void bcg_real_write BCG_ARG_3 (BCG_TYPE_STREAM, bcg_type_real, BCG_TYPE_NATURAL *);

#else

void bcg_real_write (bcg_file, bcg_real, bcg_size)
BCG_TYPE_STREAM bcg_file;
bcg_type_real bcg_real;
BCG_TYPE_NATURAL *bcg_size;
{
     BCG_PUSH_WRITE_FILE (bcg_file);
     BCG_WRITE_REAL (bcg_real, bcg_real_size);
     /*
      * ne pas utiliser de BCG_WRITE_BLOCK() ici, sinon on a des problemes de
      * portabilite "little endian/big endian" lorsque l'on convertit le reel
      * en bloc et vice-versa (la norme IEEE ne specifiant rien sur l'ordre
      * des octets dans les mots, qui peut differer selon les processeurs)
      */
     *bcg_size = bcg_real_size;
     BCG_PULL_WRITE_FILE ();
}

#endif
#endif

/*---------------------------------------------------------------------------*/
/* Real type / Binary read                                                   */
/*---------------------------------------------------------------------------*/

#if defined (ADT_REAL_BCG_DEFINITIONS)
#if defined (BCG_PREDEFINED_DECLARATIONS_SPECIAL_INCLUSION_1)

extern void bcg_real_read BCG_ARG_3 (BCG_TYPE_STREAM, bcg_type_real *, BCG_TYPE_NATURAL *);

#else

void bcg_real_read (bcg_file, bcg_real, bcg_size)
BCG_TYPE_STREAM bcg_file;
bcg_type_real *bcg_real;
BCG_TYPE_NATURAL *bcg_size;
{
     BCG_PUSH_READ_FILE (bcg_file);
     BCG_READ_REAL (bcg_real, bcg_real_size);
     /*
      * ne pas utiliser de BCG_READ_BLOCK() ici, sinon on a des problemes de
      * portabilite "little endian/big endian" lorsque l'on convertit le reel
      * en bloc et vice-versa (la norme IEEE ne specifiant rien sur l'ordre
      * des octets dans les mots, qui peut differer selon les processeurs)
      */
     *bcg_size = bcg_real_size;
     BCG_PULL_READ_FILE ();
}

#endif
#endif

/*---------------------------------------------------------------------------*/
/* Real type / End of list                                                   */
/*---------------------------------------------------------------------------*/
