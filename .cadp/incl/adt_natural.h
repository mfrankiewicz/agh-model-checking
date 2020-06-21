/******************************************************************************
 *   			            C A D P
 *-----------------------------------------------------------------------------
 *   INRIA - Centre de Recherche de Grenoble Rhone-Alpes
 *   655, avenue de l'Europe
 *   38330 Montbonnot Saint Martin
 *   FRANCE
 *-----------------------------------------------------------------------------
 *   Module		:	adt_natural.h
 *   Auteur		:	Hubert GARAVEL
 *   Version		:	1.28
 *   Date		: 	2017/09/26 18:48:13
 *****************************************************************************/

#if defined (ADT_NATURAL_ADT_ALREADY_INCLUDED)
#undef ADT_NATURAL_ADT_DEFINITIONS
#elif defined (ADT_X_NATURAL)
#define ADT_NATURAL_ADT_ALREADY_INCLUDED
#define ADT_NATURAL_ADT_DEFINITIONS
#endif

#if defined (ADT_NATURAL_BCG_ALREADY_INCLUDED)
#undef ADT_NATURAL_BCG_DEFINITIONS
#elif defined (BCG_PREDEFINED_DECLARATIONS_INTERFACE)
#define ADT_NATURAL_BCG_ALREADY_INCLUDED
#define ADT_NATURAL_BCG_DEFINITIONS
#endif

#if defined (ADT_NATURAL_XTL_ALREADY_INCLUDED)
#undef ADT_NATURAL_XTL_DEFINITIONS
#elif defined (XTL_STANDARD_INTERFACE)
#define ADT_NATURAL_XTL_ALREADY_INCLUDED
#define ADT_NATURAL_XTL_DEFINITIONS
#endif

/*---------------------------------------------------------------------------*/
/* Natural type / Includes and preliminary definitions [DIVERGENCE!]         */
/*---------------------------------------------------------------------------*/

#if defined (ADT_NATURAL_ADT_DEFINITIONS)

#ifndef ADT_BITS_NAT
/* by default each natural has 32 bits (for backward compatibility) */
#define ADT_BITS_NAT 32
/* by default naturals are in the range 0..9 (for backward compatibility) */
#define ADT_INF_NAT 0
#define ADT_SUP_NAT 9
#endif

#if ADT_BITS_NAT <= 0
#error "ADT_BITS_NAT too small"
#endif

#if ADT_BITS_NAT > 64
#error "ADT_BITS_NAT too large"
#endif

#if (ADT_BITS_NAT > 32) && (ULONG_MAX == UINT_MAX)
#error "ADT_BITS_NAT too large for a 32-bit machine"
#endif

/* . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . */

#define ADT_LOW_NAT 0

/* . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . */

#if ADT_BITS_NAT < 32
#define ADT_HIGH_NAT ((1U << ADT_BITS_NAT) - 1)

#elif ADT_BITS_NAT == 32
#define ADT_HIGH_NAT UINT_MAX

#elif ADT_BITS_NAT < 64
#define ADT_HIGH_NAT ((1LU << ADT_BITS_NAT) - 1)

#else				/* ADT_BITS_NAT == 64 */
#define ADT_HIGH_NAT ULONG_MAX
#endif

/* . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . */

#define ADT_INVALID_NAT(X) (ADT_HIGH_NAT < (X))

/* . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . */

#ifndef ADT_INF_NAT
#define ADT_INF_NAT ADT_LOW_NAT
#else
/* check that user-defined ADT_INF_NAT is compatible with ADT_BITS_NAT */
#if ADT_INVALID_NAT (ADT_INF_NAT)
#error "ADT_INF_NAT is incompatible with ADT_BITS_NAT"
#endif
#endif

/* . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . */

#ifndef ADT_SUP_NAT
#define ADT_SUP_NAT ADT_HIGH_NAT
#else
/* check that user-defined ADT_SUP_NAT is compatible with ADT_BITS_NAT */
#if ADT_INVALID_NAT (ADT_SUP_NAT)
#error "ADT_SUP_NAT is incompatible with ADT_BITS_NAT"
#endif
#endif

/* . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . */

#if ADT_INF_NAT > ADT_SUP_NAT
#error "empty domain of type NAT (ADT_INF_NAT > ADT_SUP_NAT)"
#endif

#endif

/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */

#if defined (ADT_NATURAL_BCG_DEFINITIONS)

#include <strings.h>
#include <stdlib.h>		/* for strtoul() */
#include <errno.h>		/* for errno */

#define bcg_natural_low 0

#define bcg_natural_high UINT_MAX

#if ULONG_MAX == UINT_MAX
/* 32-bit machine */
#define bcg_natural_invalid(bcg_unsigned_long) 0
#else
/* 64-bit machine */
#define bcg_natural_invalid(bcg_unsigned_long) \
   ((unsigned long) bcg_natural_high < (bcg_unsigned_long))
#endif

#endif

/*---------------------------------------------------------------------------*/
/* Natural type / Implementation [DIVERGENCE!]                               */
/*---------------------------------------------------------------------------*/

#if defined (ADT_NATURAL_ADT_DEFINITIONS)

#ifdef ADT_NAT
/* users can define ADT_NAT themselves, provided that it is an unsigned type */
/* if so, they should provide a macro ADT_WIDE_NAT defining a wider NAT type */
#if defined (ADT_CHECK_NAT) && !defined (ADT_WIDE_NAT)
#warning "missing macro defining ADT_WIDE_NAT type: no natural overflow check possible"
#undef ADT_CHECK_NAT
#endif

#elif ADT_BITS_NAT <= 8
typedef unsigned char ADT_NAT;
#ifdef ADT_CHECK_NAT
typedef unsigned short ADT_WIDE_NAT;
#endif

#elif ADT_BITS_NAT <= 16
typedef unsigned short ADT_NAT;
#ifdef ADT_CHECK_NAT
typedef unsigned int ADT_WIDE_NAT;
#endif

#elif ADT_BITS_NAT <= 32
typedef unsigned int ADT_NAT;
#ifdef ADT_CHECK_NAT
#if ULONG_MAX == UINT_MAX
/* 32-bit machine */
typedef unsigned long long ADT_WIDE_NAT;
#else
/* 64-bit machine */
typedef unsigned long ADT_WIDE_NAT;
#endif
#endif

#else
typedef unsigned long ADT_NAT;
#ifdef ADT_CHECK_NAT
#warning "64-bit ADT_NAT type: no natural overflow check possible"
#undef ADT_CHECK_NAT
#endif
#endif

#if !defined (ADT_CHECK_NAT)
typedef ADT_NAT ADT_WIDE_NAT;
#endif

#endif

/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */

#if defined (ADT_NATURAL_BCG_DEFINITIONS) || \
    defined (ADT_NATURAL_XTL_DEFINITIONS)

typedef unsigned int bcg_type_natural;

#endif

/*---------------------------------------------------------------------------*/
/* Natural type / Size in bits [DIVERGENCE!]                                 */
/*---------------------------------------------------------------------------*/

#if defined (ADT_NATURAL_ADT_DEFINITIONS)

#define CAESAR_ADT_BITS_ADT_NAT : ADT_BITS_NAT

#endif

/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */

#if defined (ADT_NATURAL_BCG_DEFINITIONS)

#define bcg_natural_size ((BCG_TYPE_NATURAL) sizeof (bcg_type_natural) * 8)

#endif

/*---------------------------------------------------------------------------*/
/* Natural type / Scalarity                                                  */
/*---------------------------------------------------------------------------*/

#if defined (ADT_NATURAL_ADT_DEFINITIONS)

#define CAESAR_ADT_SCALAR_ADT_NAT

#endif

/*---------------------------------------------------------------------------*/
/* Natural type / Assignment                                                 */
/*---------------------------------------------------------------------------*/

#if defined (ADT_NATURAL_BCG_DEFINITIONS)

#define bcg_natural_assign(bcg_1,bcg_2) (bcg_1) = (bcg_2)

#endif

/*---------------------------------------------------------------------------*/
/* Natural type / Canonicity                                                 */
/*---------------------------------------------------------------------------*/

/* not uncanonical */

/*---------------------------------------------------------------------------*/
/* Natural type / Equality                                                   */
/*---------------------------------------------------------------------------*/

#if defined (ADT_NATURAL_ADT_DEFINITIONS)

#define ADT_CMP_NAT(X1,X2) ((X1) == (X2))

#endif

/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */

#if defined (ADT_NATURAL_BCG_DEFINITIONS)

#define bcg_natural_cmp(bcg_1,bcg_2) ((bcg_1) == (bcg_2))

#endif

/*---------------------------------------------------------------------------*/
/* Natural type / Iteration [DIVERGENCE!]                                    */
/*---------------------------------------------------------------------------*/

#if defined (ADT_NATURAL_ADT_DEFINITIONS)

#define ADT_ENUM_FIRST_NAT() ADT_INF_NAT
#define ADT_ENUM_NEXT_NAT(X) ((X)++ < ADT_SUP_NAT)

#endif

/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */

#if defined (ADT_NATURAL_BCG_DEFINITIONS)

#define bcg_natural_enum(bcg_0) for ((bcg_0) = 1; (bcg_0) != 0; (bcg_0)++)

#endif

/*---------------------------------------------------------------------------*/
/* Natural type / Print [DIVERGENCE!]                                        */
/*---------------------------------------------------------------------------*/

#if defined (ADT_NATURAL_ADT_DEFINITIONS)

#define ADT_PRINT_NAT(F,X) fprintf ((F), "%lu", (unsigned long) (X))

#endif

/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */

#if defined (ADT_NATURAL_BCG_DEFINITIONS)

#define bcg_natural_print(bcg_file,bcg_0) fprintf ((bcg_file), "%u", (bcg_0))

#endif

/*---------------------------------------------------------------------------*/
/* Natural type / Scan                                                       */
/*---------------------------------------------------------------------------*/

#if defined (ADT_NATURAL_BCG_DEFINITIONS)
#if defined (BCG_PREDEFINED_DECLARATIONS_SPECIAL_INCLUSION_1)

extern BCG_TYPE_SCAN_RESULT bcg_natural_scan BCG_ARG_2 (BCG_TYPE_C_STRING, bcg_type_natural *);

#else

BCG_TYPE_SCAN_RESULT bcg_natural_scan (bcg_text, bcg_natural)
BCG_TYPE_C_STRING bcg_text;
bcg_type_natural *bcg_natural;
{
     unsigned long bcg_n;
     BCG_TYPE_C_STRING bcg_pointer;

     if ((bcg_text[0] == '-') || (bcg_text[0] == '+')) {
	  /* a natural value must not start with an explicit sign */
	  return (BCG_SCAN_NOK);
     }
     errno = 0;
     bcg_n = strtoul (bcg_text, &bcg_pointer, /* base */ 10);
     if (bcg_text == bcg_pointer) {
	  /* no conversion was performed */
	  return (BCG_SCAN_NOK);
     }
     if (*bcg_pointer != '\0') {
	  /* invalid trailing characters */
	  return (BCG_SCAN_NOK);
     }
     if ((bcg_n == 0) && (errno == EINVAL)) {
	  /* no conversion could be performed */
	  return (BCG_SCAN_NOK);
     }
     if (((bcg_n == ULONG_MAX) && (errno == ERANGE)) ||
	 bcg_natural_invalid (bcg_n)) {
	  /*
	   * conversion could be performed, but led to a result outside the
	   * range of either representable "unsigned long" values or
	   * bcg_type_natural values
	   */
	  return (BCG_SCAN_NOK_OVERFLOW);
     }
     *bcg_natural = (bcg_type_natural) bcg_n;
     return (BCG_SCAN_OK);
}

#endif
#endif

/*---------------------------------------------------------------------------*/
/* Natural type / Binary write                                               */
/*---------------------------------------------------------------------------*/

#if defined (ADT_NATURAL_BCG_DEFINITIONS)
#if defined (BCG_PREDEFINED_DECLARATIONS_SPECIAL_INCLUSION_1)

extern void bcg_natural_write BCG_ARG_3 (BCG_TYPE_STREAM, bcg_type_natural, BCG_TYPE_NATURAL *);

#else

void bcg_natural_write (bcg_file, bcg_natural, bcg_size)
BCG_TYPE_STREAM bcg_file;
bcg_type_natural bcg_natural;
BCG_TYPE_NATURAL *bcg_size;
{
     BCG_PUSH_WRITE_FILE (bcg_file);
     BCG_WRITE_UNSIGNED (bcg_natural, bcg_natural_size);
     /*
      * ne pas utiliser de BCG_WRITE_BLOCK() ici, sinon on a des problemes de
      * portabilite "little endian/big endian" lorsque l'on convertit
      * l'entier en bloc et vice-versa
      */
     *bcg_size = bcg_natural_size;
     BCG_PULL_WRITE_FILE ();
}

#endif
#endif

/*---------------------------------------------------------------------------*/
/* Natural type / Binary read                                                */
/*---------------------------------------------------------------------------*/

#if defined (ADT_NATURAL_BCG_DEFINITIONS)
#if defined (BCG_PREDEFINED_DECLARATIONS_SPECIAL_INCLUSION_1)

extern void bcg_natural_read BCG_ARG_3 (BCG_TYPE_STREAM, bcg_type_natural *, BCG_TYPE_NATURAL *);

#else

void bcg_natural_read (bcg_file, bcg_natural, bcg_size)
BCG_TYPE_STREAM bcg_file;
bcg_type_natural *bcg_natural;
BCG_TYPE_NATURAL *bcg_size;
{
     BCG_PUSH_READ_FILE (bcg_file);
     BCG_READ_UNSIGNED ((BCG_TYPE_NATURAL *) bcg_natural, bcg_natural_size);
     /*
      * ne pas utiliser de BCG_READ_BLOCK() ici, sinon on a des problemes de
      * portabilite "little endian/big endian" lorsque l'on convertit
      * l'entier en bloc et vice-versa
      */
     *bcg_size = bcg_natural_size;
     BCG_PULL_READ_FILE ();
}

#endif
#endif

/*---------------------------------------------------------------------------*/
/* Natural type / End of list                                                */
/*---------------------------------------------------------------------------*/
