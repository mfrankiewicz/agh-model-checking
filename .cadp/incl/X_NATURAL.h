/******************************************************************************
 *   			            C A D P
 *-----------------------------------------------------------------------------
 *   INRIA - Centre de Recherche de Grenoble Rhone-Alpes
 *   655, avenue de l'Europe
 *   38330 Montbonnot Saint Martin
 *   FRANCE
 *-----------------------------------------------------------------------------
 *   Module		:	X_NATURAL.h
 *   Auteur		:	Hubert GARAVEL
 *   Version		:	1.10
 *   Date		: 	2018/01/03 11:05:38
 *****************************************************************************/

#ifndef ADT_X_NATURAL

#define ADT_X_NATURAL

#include <limits.h>		/* for UINT_MAX and ULONG_MAX */
#include <math.h>		/* for pow() */

#include <unistd.h>
#include <sys/types.h>
#include <signal.h>		/* for raise() */

/*---------------------------------------------------------------------------*/

/**
 * the following macros can be defined by the user before including this file
 *    - ADT_NAT_INTERFACE_EXPORT  undefined or just defined
 *    - ADT_NAT_INTERFACE_ONLY    undefined or just defined
 *    - MCL_DATA_EXTENSION        undefined or just defined
 *    - ADT_NAT                   undefined or defined as an unsigned int type
 *    - ADT_WIDE_NAT              defined iff both ADT_NAT and ADT_CHECK_NAT
 *                                are defined; if so, it must be such that
 *                                sizeof (ADT_NAT) <= sizeof (ADT_WIDE_NAT)
 *    - ADT_BITS_NAT              undefined or defined as a number of bits
 *    - ADT_INF_NAT               undefined or defined as a natural constant
 *    - ADT_SUP_NAT               undefined or defined as a natural constant
 *    - ADT_CHECK_NAT             undefined or just defined
**/

/*---------------------------------------------------------------------------*/

#if defined (ADT_NAT_INTERFACE_EXPORT)
#define ADT_NAT_STATIC		/* nothing */
#elif defined (__GNUC__)
#define ADT_NAT_STATIC static __attribute__((unused))
#else
#define ADT_NAT_STATIC static
#endif

/*---------------------------------------------------------------------------*/

#include "adt_natural.h"

#include "caesar_system.h"	/* to have own_fprintf() and "%llu" on win32 */

/*---------------------------------------------------------------------------*/

#if defined (ADT_CHECK_NAT)
#ifdef __GNUC__
#if (__GNUC__ > 4) || ((__GNUC__ == 4) && (__GNUC_MINOR__ > 2))
#pragma GCC diagnostic ignored "-Wtype-limits"
#endif
#endif
#endif

/*---------------------------------------------------------------------------*/

#if !defined (ADT_CHECK_NAT)

/* no overflow checks at run-time for ADT_NAT values */
/* here, ADT_WIDE_NAT and ADT_NAT are identical types */
#define ADT_CHECKED_NAT(ADT_X,ADT_FILE,ADT_LINE) (ADT_X)

#else

#if defined (ADT_NAT_INTERFACE_ONLY)
ADT_NAT ADT_CHECKED_NAT (ADT_WIDE_NAT ADT_X, char *ADT_FILE, int ADT_LINE);
#else
inline ADT_NAT_STATIC ADT_NAT ADT_CHECKED_NAT (ADT_WIDE_NAT ADT_X, char *ADT_FILE, int ADT_LINE)
{
     if (ADT_INVALID_NAT (ADT_X)) {
	  fprintf (stdout, "#401 error in file ``%s'' at line %d:\n     natural value %llu out of the range [%lu .. %lu]\n", ADT_FILE, ADT_LINE, (unsigned long long) ADT_X, (unsigned long) ADT_LOW_NAT, (unsigned long) ADT_HIGH_NAT);
	  fflush (stdout);
	  raise (15);
     }
     return ((ADT_NAT) ADT_X);
}
#endif

#endif

/*---------------------------------------------------------------------------*/

#define ADT_N0() ADT_CHECKED_NAT ((ADT_WIDE_NAT) 0, __FILE__, __LINE__)

#define CAESAR_ADT_MATCH_ADT_N0(X0) ((X0) == 0)

/*---------------------------------------------------------------------------*/

#define ADT_SUCC_NAT(X) ADT_CHECKED_NAT ((ADT_WIDE_NAT) (X) + 1, __FILE__, __LINE__)

#define CAESAR_ADT_MATCH_ADT_SUCC_NAT(X0) ((X0) > 0)

#define CAESAR_ADT_GET_1_ADT_SUCC_NAT(X0) ((X0) - 1)

/*---------------------------------------------------------------------------*/

#define ADT_N1() ADT_CHECKED_NAT ((ADT_WIDE_NAT) 1, __FILE__, __LINE__)

#define ADT_N2() ADT_CHECKED_NAT ((ADT_WIDE_NAT) 2, __FILE__, __LINE__)

#define ADT_N3() ADT_CHECKED_NAT ((ADT_WIDE_NAT) 3, __FILE__, __LINE__)

#define ADT_N4() ADT_CHECKED_NAT ((ADT_WIDE_NAT) 4, __FILE__, __LINE__)

#define ADT_N5() ADT_CHECKED_NAT ((ADT_WIDE_NAT) 5, __FILE__, __LINE__)

#define ADT_N6() ADT_CHECKED_NAT ((ADT_WIDE_NAT) 6, __FILE__, __LINE__)

#define ADT_N7() ADT_CHECKED_NAT ((ADT_WIDE_NAT) 7, __FILE__, __LINE__)

#define ADT_N8() ADT_CHECKED_NAT ((ADT_WIDE_NAT) 8, __FILE__, __LINE__)

#define ADT_N9() ADT_CHECKED_NAT ((ADT_WIDE_NAT) 9, __FILE__, __LINE__)

/*---------------------------------------------------------------------------*/

#define ADT_PLUS_NAT(X1,X2) ADT_CHECKED_NAT ((ADT_WIDE_NAT) (X1) + (ADT_WIDE_NAT) (X2), __FILE__, __LINE__)

#define ADT_MULT_NAT(X1,X2) ADT_CHECKED_NAT ((ADT_WIDE_NAT) (X1) * (ADT_WIDE_NAT) (X2), __FILE__, __LINE__)

#define ADT_POWER_NAT(X1,X2) ADT_CHECKED_NAT ((ADT_WIDE_NAT) pow ((double) (X1), (double) (X2)), __FILE__, __LINE__)

#define ADT_MINUS_NAT(X1,X2) ADT_CHECKED_NAT ((ADT_WIDE_NAT) (X1) - (ADT_WIDE_NAT) (X2), __FILE__, __LINE__)

#define ADT_DIV_NAT(X1,X2) ADT_CHECKED_NAT ((ADT_WIDE_NAT) ((ADT_WIDE_NAT) (X1) / (ADT_WIDE_NAT) (X2)), __FILE__, __LINE__)

#define ADT_MOD_NAT(X1,X2) ADT_CHECKED_NAT ((ADT_WIDE_NAT) ((ADT_WIDE_NAT) (X1) % (ADT_WIDE_NAT) (X2)), __FILE__, __LINE__)

/*---------------------------------------------------------------------------*/

#define ADT_EQ_NAT(X1,X2) ((ADT_BOOL) ((X1) == (X2) ? ADT_TRUE() : ADT_FALSE()))

#define ADT_NE_NAT(X1,X2) ((ADT_BOOL) ((X1) != (X2) ? ADT_TRUE() : ADT_FALSE()))

#define ADT_LT_NAT(X1,X2) ((ADT_BOOL) ((X1) < (X2) ? ADT_TRUE() : ADT_FALSE()))

#define ADT_LE_NAT(X1,X2) ((ADT_BOOL) ((X1) <= (X2) ? ADT_TRUE() : ADT_FALSE()))

#define ADT_GT_NAT(X1,X2) ((ADT_BOOL) ((X1) > (X2) ? ADT_TRUE() : ADT_FALSE()))

#define ADT_GE_NAT(X1,X2) ((ADT_BOOL) ((X1) >= (X2) ? ADT_TRUE() : ADT_FALSE()))

#define ADT_EQ_BIS_NAT(X1,X2) ((ADT_BOOL) ((X1) == (X2) ? ADT_TRUE() : ADT_FALSE()))

#define ADT_NE_BIS_NAT(X1,X2) ((ADT_BOOL) ((X1) != (X2) ? ADT_TRUE() : ADT_FALSE()))

#define ADT_LT_BIS_NAT(X1,X2) ((ADT_BOOL) ((X1) < (X2) ? ADT_TRUE() : ADT_FALSE()))

#define ADT_LE_BIS_NAT(X1,X2) ((ADT_BOOL) ((X1) <= (X2) ? ADT_TRUE() : ADT_FALSE()))

#define ADT_GT_BIS_NAT(X1,X2) ((ADT_BOOL) ((X1) > (X2) ? ADT_TRUE() : ADT_FALSE()))

#define ADT_GE_BIS_NAT(X1,X2) ((ADT_BOOL) ((X1) >= (X2) ? ADT_TRUE() : ADT_FALSE()))

/*---------------------------------------------------------------------------*/

#define ADT_MIN_NAT(X1,X2) ((X1) <= (X2) ? (X1) : (X2))

#define ADT_MAX_NAT(X1,X2) ((X1) >= (X2) ? (X1) : (X2))

/*---------------------------------------------------------------------------*/

#if defined (ADT_NAT_INTERFACE_ONLY)
ADT_NAT ADT_GCD_NAT (ADT_NAT ADT_X1, ADT_NAT ADT_X2);
#else
ADT_NAT_STATIC ADT_NAT ADT_GCD_NAT (ADT_NAT ADT_X1, ADT_NAT ADT_X2)
{
     if (ADT_X1 == 0 || ADT_X2 == 0) {
	  raise (15);
	  /* NOTREACHED */
	  return (0);		/* to keep "gcc -Wall" silent */
     } else if (ADT_X1 < ADT_X2)
	  return (ADT_GCD_NAT (ADT_X1, ADT_MINUS_NAT (ADT_X2, ADT_X1)));
     else if (ADT_X1 > ADT_X2)
	  return (ADT_GCD_NAT (ADT_MINUS_NAT (ADT_X1, ADT_X2), ADT_X2));
     else
	  return (ADT_CHECKED_NAT ((ADT_WIDE_NAT) ADT_X1, __FILE__, __LINE__));
}
#endif

/*---------------------------------------------------------------------------*/

#define ADT_SCM_NAT(X1,X2) (ADT_DIV_NAT ((ADT_WIDE_NAT) (X1) * (ADT_WIDE_NAT) (X2), ADT_GCD_NAT ((X1), (X2))))

/*---------------------------------------------------------------------------*/

#ifdef MCL_DATA_EXTENSION

#define ADT_UMINUS_NAT(X) (- (X))	/* unchecked !? */

#endif

/* ------------------------------------------------------------------------- */

#endif
