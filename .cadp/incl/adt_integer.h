/******************************************************************************
 *   			            C A D P
 *-----------------------------------------------------------------------------
 *   INRIA - Centre de Recherche de Grenoble Rhone-Alpes
 *   655, avenue de l'Europe
 *   38330 Montbonnot Saint Martin
 *   FRANCE
 *-----------------------------------------------------------------------------
 *   Module		:	adt_integer.h
 *   Auteur		:	Hubert GARAVEL
 *   Version		:	1.35
 *   Date		: 	2017/09/26 18:48:08
 *****************************************************************************/

#if defined (ADT_INTEGER_ADT_ALREADY_INCLUDED)
#undef ADT_INTEGER_ADT_DEFINITIONS
#elif defined (ADT_X_INTEGER)
#define ADT_INTEGER_ADT_ALREADY_INCLUDED
#define ADT_INTEGER_ADT_DEFINITIONS
#endif

#if defined (ADT_INTEGER_BCG_ALREADY_INCLUDED)
#undef ADT_INTEGER_BCG_DEFINITIONS
#elif defined (BCG_PREDEFINED_DECLARATIONS_INTERFACE)
#define ADT_INTEGER_BCG_ALREADY_INCLUDED
#define ADT_INTEGER_BCG_DEFINITIONS
#endif

#if defined (ADT_INTEGER_XTL_ALREADY_INCLUDED)
#undef ADT_INTEGER_XTL_DEFINITIONS
#elif defined (XTL_STANDARD_INTERFACE)
#define ADT_INTEGER_XTL_ALREADY_INCLUDED
#define ADT_INTEGER_XTL_DEFINITIONS
#endif

/*---------------------------------------------------------------------------*/
/* Integer type / Includes and preliminary definitions [DIVERGENCE!]         */
/*---------------------------------------------------------------------------*/

#if defined (ADT_INTEGER_ADT_DEFINITIONS)

#ifndef ADT_BITS_INT
/* by default each integer has 32 bits (for backward compatibility) */
#define ADT_BITS_INT 32
/* by default integers are in the range -9..9 (for backward compatibility) */
#define ADT_INF_INT (-9)
#define ADT_SUP_INT 9
#endif

#if ADT_BITS_INT <= 0
#error "ADT_BITS_INT too small"
#endif

#if ADT_BITS_INT > 64
#error "ADT_BITS_INT too large"
#endif

#if (ADT_BITS_INT > 32) && (LONG_MAX == INT_MAX)
#error "ADT_BITS_INT too large for a 32-bit machine"
#endif

/* . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . */

#if ADT_BITS_INT < 32
#define ADT_HIGH_INT ((1 << (ADT_BITS_INT - 1)) - 1)
#define ADT_LOW_INT (-(ADT_HIGH_INT) - 1)

#elif ADT_BITS_INT == 32
#define ADT_HIGH_INT INT_MAX
#define ADT_LOW_INT INT_MIN

#elif ADT_BITS_INT < 64
#define ADT_HIGH_INT ((1L << (ADT_BITS_INT - 1)) - 1)
#define ADT_LOW_INT (-(ADT_HIGH_INT) - 1)

#else				/* ADT_BITS_INT == 64 */
#define ADT_HIGH_INT LONG_MAX
#define ADT_LOW_INT LONG_MIN
#endif

/* . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . */

#define ADT_INVALID_INT(X) (((X) < ADT_LOW_INT) || (ADT_HIGH_INT < (X)))

/* . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . */

#ifndef ADT_INF_INT
#define ADT_INF_INT ADT_LOW_INT
#else
/* check that user-defined ADT_INF_INT is compatible with ADT_BITS_INT */
#if ADT_INVALID_INT (ADT_INF_INT)
#error "ADT_INF_INT is incompatible with ADT_BITS_INT"
#endif
#endif

/* . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . */

#ifndef ADT_SUP_INT
#define ADT_SUP_INT ADT_HIGH_INT
#else
/* check that user-defined ADT_SUP_INT is compatible with ADT_BITS_INT */
#if ADT_INVALID_INT (ADT_SUP_INT)
#error "ADT_SUP_INT is incompatible with ADT_BITS_INT"
#endif
#endif

/* . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . */

#if ADT_INF_INT > ADT_SUP_INT
#error "empty domain of type INT (ADT_INF_INT > ADT_SUP_INT)"
#endif

#endif

/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */

#if defined (ADT_INTEGER_BCG_DEFINITIONS)

#include <strings.h>
#include <stdlib.h>		/* for strtol() */
#include <errno.h>		/* for errno */

#define bcg_integer_low INT_MIN

#define bcg_integer_high INT_MAX

#if ULONG_MAX == UINT_MAX
/* 32-bit machine */
#define bcg_integer_invalid(bcg_signed_long) 0
#else
/* 64-bit machine */
#define bcg_integer_invalid(bcg_signed_long) \
   (((bcg_signed_long) < (long) bcg_integer_low) || \
     ((long) bcg_integer_high < (bcg_signed_long)))

#endif

#endif

/*---------------------------------------------------------------------------*/
/* Integer type / Implementation [DIVERGENCE!]                               */
/*---------------------------------------------------------------------------*/

#if defined (ADT_INTEGER_ADT_DEFINITIONS)

#ifdef ADT_INT
/* users can define ADT_INT themselves, provided that it is a signed type */
/* if so, they should provide a macro ADT_WIDE_INT defining a wider INT type */
#if defined (ADT_CHECK_INT) && !defined (ADT_WIDE_INT)
#warning "missing macro defining ADT_WIDE_INT type: no integer overflow check possible"
#undef ADT_CHECK_INT
#endif

#elif ADT_BITS_INT <= 8
typedef signed char ADT_INT;
#ifdef ADT_CHECK_INT
typedef signed short ADT_WIDE_INT;
#endif

#elif ADT_BITS_INT <= 16
typedef signed short ADT_INT;
#ifdef ADT_CHECK_INT
typedef signed int ADT_WIDE_INT;
#endif

#elif ADT_BITS_INT <= 32
typedef signed int ADT_INT;
#ifdef ADT_CHECK_INT
#if LONG_MAX == INT_MAX
/* 32-bit machine */
typedef signed long long ADT_WIDE_INT;
#else
/* 64-bit machine */
typedef signed long ADT_WIDE_INT;
#endif
#endif

#else
typedef signed long ADT_INT;
#ifdef ADT_CHECK_INT
#warning "64-bit ADT_INT type: no integer overflow check possible"
#undef ADT_CHECK_INT
#endif
#endif

#if !defined (ADT_CHECK_INT)
typedef ADT_INT ADT_WIDE_INT;
#endif

#endif

/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */

#if defined (ADT_INTEGER_BCG_DEFINITIONS) || \
    defined (ADT_INTEGER_XTL_DEFINITIONS)

typedef int bcg_type_integer;

#endif

/*---------------------------------------------------------------------------*/
/* Integer type / Size in bits [DIVERGENCE!]                                 */
/*---------------------------------------------------------------------------*/

#if defined (ADT_INTEGER_ADT_DEFINITIONS)

#define CAESAR_ADT_BITS_ADT_INT : ADT_BITS_INT

#endif

/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */

#if defined (ADT_INTEGER_BCG_DEFINITIONS)

#define bcg_integer_size ((BCG_TYPE_NATURAL) sizeof (bcg_type_integer) * 8)

#endif

/*---------------------------------------------------------------------------*/
/* Integer type / Scalarity                                                  */
/*---------------------------------------------------------------------------*/

#if defined (ADT_INTEGER_ADT_DEFINITIONS)

#define CAESAR_ADT_SCALAR_ADT_INT

#endif

/*---------------------------------------------------------------------------*/
/* Integer type / Assignment                                                 */
/*---------------------------------------------------------------------------*/

#if defined (ADT_INTEGER_BCG_DEFINITIONS)

#define bcg_integer_assign(bcg_1,bcg_2) (bcg_1) = (bcg_2)

#endif

/*---------------------------------------------------------------------------*/
/* Integer type / Canonicity                                                 */
/*---------------------------------------------------------------------------*/

/* not uncanonical */

/*---------------------------------------------------------------------------*/
/* Integer type / Equality                                                   */
/*---------------------------------------------------------------------------*/

#if defined (ADT_INTEGER_ADT_DEFINITIONS)

#define ADT_CMP_INT(X1,X2) ((X1) == (X2))

#endif

/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */

#if defined (ADT_INTEGER_BCG_DEFINITIONS)

#define bcg_integer_cmp(bcg_1,bcg_2) ((bcg_1) == (bcg_2))

#endif

/*---------------------------------------------------------------------------*/
/* Integer type / Iteration [DIVERGENCE!]                                    */
/*---------------------------------------------------------------------------*/

#if defined (ADT_INTEGER_ADT_DEFINITIONS)

#define ADT_ENUM_FIRST_INT() ADT_INF_INT
#define ADT_ENUM_NEXT_INT(X) ((X)++ < ADT_SUP_INT)

#endif

/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */

#if defined (ADT_INTEGER_BCG_DEFINITIONS)

#define bcg_integer_enum(bcg_0) for ((bcg_0) = 1; (bcg_0) != 0; (bcg_0)++)

#endif

/*---------------------------------------------------------------------------*/
/* Integer type / Print [DIVERGENCE!]                                        */
/*---------------------------------------------------------------------------*/

#if defined (ADT_INTEGER_ADT_DEFINITIONS)

#define ADT_PRINT_INT(F,X) fprintf ((F), "%+ld", (long) (X))

#endif

/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */

#if defined (ADT_INTEGER_BCG_DEFINITIONS)

#define bcg_integer_print(bcg_file,bcg_0) fprintf ((bcg_file), "%+d", (bcg_0))

#endif

/*---------------------------------------------------------------------------*/
/* Integer type / Scan                                                       */
/*---------------------------------------------------------------------------*/

#if defined (ADT_INTEGER_BCG_DEFINITIONS)
#if defined (BCG_PREDEFINED_DECLARATIONS_SPECIAL_INCLUSION_1)

extern BCG_TYPE_SCAN_RESULT bcg_integer_scan BCG_ARG_2 (BCG_TYPE_C_STRING, bcg_type_integer *);

#else

BCG_TYPE_SCAN_RESULT bcg_integer_scan (bcg_text, bcg_integer)
BCG_TYPE_C_STRING bcg_text;
bcg_type_integer *bcg_integer;
{
     long bcg_i;
     BCG_TYPE_C_STRING bcg_pointer;

     if ((bcg_text[0] != '-') && (bcg_text[0] != '+')) {
	  /* an integer value must start with an explicit sign */
	  return (BCG_SCAN_NOK);
     }
     errno = 0;
     bcg_i = strtol (bcg_text, &bcg_pointer, /* base */ 10);
     if (bcg_text == bcg_pointer) {
	  /* no conversion was performed */
	  return (BCG_SCAN_NOK);
     }
     if (*bcg_pointer != '\0') {
	  /* invalid trailing characters */
	  return (BCG_SCAN_NOK);
     }
     if ((bcg_i == 0) && (errno == EINVAL)) {
	  /* no conversion could be performed */
	  return (BCG_SCAN_NOK);
     }
     if (((bcg_i == LONG_MAX) && (errno == ERANGE)) ||
	 ((bcg_i == LONG_MIN) && (errno == ERANGE)) ||
	 bcg_integer_invalid (bcg_i)) {
	  /*
	   * conversion could be performed, but led to a result outside the
	   * range of either representable "long" values or bcg_type_integer
	   * values
	   */
	  if (bcg_i < 0)
	       return (BCG_SCAN_NOK_UNDERFLOW);
	  else
	       return (BCG_SCAN_NOK_OVERFLOW);
     }
     *bcg_integer = (bcg_type_integer) bcg_i;
     return (BCG_SCAN_OK);
}

#endif
#endif

/*---------------------------------------------------------------------------*/
/* Integer type / Binary write                                               */
/*---------------------------------------------------------------------------*/

#if defined (ADT_INTEGER_BCG_DEFINITIONS)
#if defined (BCG_PREDEFINED_DECLARATIONS_SPECIAL_INCLUSION_1)

extern void bcg_integer_write BCG_ARG_3 (BCG_TYPE_STREAM, bcg_type_integer, BCG_TYPE_NATURAL *);

#else

void bcg_integer_write (bcg_file, bcg_integer, bcg_size)
BCG_TYPE_STREAM bcg_file;
bcg_type_integer bcg_integer;
BCG_TYPE_NATURAL *bcg_size;
{
     BCG_PUSH_WRITE_FILE (bcg_file);
     BCG_WRITE_UNSIGNED ((BCG_TYPE_NATURAL) bcg_integer, bcg_integer_size);
     /*
      * ne pas utiliser de BCG_WRITE_BLOCK() ici, sinon on a des problemes de
      * portabilite "little endian/big endian" lorsque l'on convertit
      * l'entier en bloc et vice-versa
      */
     *bcg_size = bcg_integer_size;
     BCG_PULL_WRITE_FILE ();
}

#endif
#endif

/*---------------------------------------------------------------------------*/
/* Integer type / Binary read                                                */
/*---------------------------------------------------------------------------*/

#if defined (ADT_INTEGER_BCG_DEFINITIONS)
#if defined (BCG_PREDEFINED_DECLARATIONS_SPECIAL_INCLUSION_1)

extern void bcg_integer_read BCG_ARG_3 (BCG_TYPE_STREAM, bcg_type_integer *, BCG_TYPE_NATURAL *);

#else

void bcg_integer_read (bcg_file, bcg_integer, bcg_size)
BCG_TYPE_STREAM bcg_file;
bcg_type_integer *bcg_integer;
BCG_TYPE_NATURAL *bcg_size;
{
     BCG_PUSH_READ_FILE (bcg_file);
     BCG_READ_UNSIGNED ((BCG_TYPE_NATURAL *) bcg_integer, bcg_integer_size);
     /*
      * ne pas utiliser de BCG_READ_BLOCK() ici, sinon on a des problemes de
      * portabilite "little endian/big endian" lorsque l'on convertit
      * l'entier en bloc et vice-versa
      */
     *bcg_size = bcg_integer_size;
     BCG_PULL_READ_FILE ();
}

#endif
#endif

/*---------------------------------------------------------------------------*/
/* Integer type / End of list                                                */
/*---------------------------------------------------------------------------*/
