/******************************************************************************
 *   			            C A D P
 *-----------------------------------------------------------------------------
 *   INRIA - Centre de Recherche de Grenoble Rhone-Alpes
 *   655, avenue de l'Europe
 *   38330 Montbonnot Saint Martin
 *   FRANCE
 *-----------------------------------------------------------------------------
 *   Module		:	X_INTEGER.h
 *   Auteur		:	Hubert GARAVEL
 *   Version		:	1.13
 *   Date		: 	2020/05/10 18:25:37
 *****************************************************************************/

#ifndef ADT_X_INTEGER

#define ADT_X_INTEGER

#include <limits.h>		/* for INT_MAX, INT_MIN, LONG_MAX, and
				 * LONG_MIN */
#include <math.h>		/* for pow() */
#include <signal.h>		/* for raise() */

/*---------------------------------------------------------------------------*/

/**
 * the following macros can be defined by the user before including this file
 *    - ADT_INT_INTERFACE_EXPORT  undefined or just defined
 *    - ADT_INT_INTERFACE_ONLY    undefined or just defined
 *    - MCL_DATA_EXTENSION        undefined or just defined
 *    - ADT_INT                   undefined or defined as a signed int type
 *    - ADT_WIDE_INT              defined iff both ADT_INT and ADT_CHECK_INT
 *                                are defined; if so, it must be such that
 *                                sizeof (ADT_INT) <= sizeof (ADT_WIDE_INT)
 *    - ADT_BITS_INT              undefined or defined as a number of bits
 *    - ADT_INF_INT               undefined or defined as a integer constant
 *    - ADT_SUP_INT               undefined or defined as a integer constant
 *    - ADT_CHECK_INT             undefined or just defined
**/

/*---------------------------------------------------------------------------*/

#if defined (ADT_INT_INTERFACE_EXPORT)
#define ADT_INT_STATIC		/* nothing */
#elif defined (__GNUC__)
#define ADT_INT_STATIC static __attribute__((unused))
#else
#define ADT_INT_STATIC static
#endif

/*---------------------------------------------------------------------------*/

#include "adt_integer.h"

#include "caesar_system.h"	/* to have own_fprintf() and "%lld" on win32 */

/*---------------------------------------------------------------------------*/

#if defined (ADT_CHECK_INT)
#ifdef __GNUC__
#if (__GNUC__ > 4) || ((__GNUC__ == 4) && (__GNUC_MINOR__ > 2))
#pragma GCC diagnostic ignored "-Wtype-limits"
#endif
#endif
#endif

/*---------------------------------------------------------------------------*/

/*---------------------------------------------------------------------------*/

#if !defined (ADT_CHECK_INT)

/* no overflow checks at run-time for ADT_INT values */
/* here, ADT_WIDE_INT and ADT_INT are identical types */
#define ADT_CHECKED_INT(ADT_X,ADT_FILE,ADT_LINE) (ADT_X)
#define ADT_CHECKED_POSITIVE_INT(ADT_X,ADT_FILE,ADT_LINE) (ADT_X)

#else

#if defined (ADT_INT_INTERFACE_ONLY)
ADT_INT ADT_CHECKED_INT (ADT_WIDE_INT ADT_X, char *ADT_FILE, int ADT_LINE);
ADT_INT ADT_CHECKED_POSITIVE_INT (ADT_WIDE_INT ADT_X, char *ADT_FILE, int ADT_LINE);
#else
inline ADT_INT_STATIC ADT_INT ADT_CHECKED_INT (ADT_WIDE_INT ADT_X, char *ADT_FILE, int ADT_LINE)
{
     if (ADT_INVALID_INT (ADT_X)) {
	  fprintf (stdout, "#402 error in file ``%s'' at line %d:\n     integer value %lld out of the range [%ld .. %ld]\n", ADT_FILE, ADT_LINE, (signed long long) ADT_X, (signed long) ADT_LOW_INT, (signed long) ADT_HIGH_INT);
	  fflush (stdout);
	  raise (15);
     }
     return ((ADT_INT) ADT_X);
}

inline ADT_INT_STATIC ADT_INT ADT_CHECKED_POSITIVE_INT (ADT_WIDE_INT ADT_X, char *ADT_FILE, int ADT_LINE)
{
     if (ADT_X < 0) {
	  fprintf (stdout, "#403 error in file ``%s'' at line %d:\n     negative integer value %lld not convertible to a natural\n", ADT_FILE, ADT_LINE, (signed long long) ADT_X);
	  fflush (stdout);
	  raise (15);
     }
     return ((ADT_INT) ADT_X);
}
#endif

#endif

/*---------------------------------------------------------------------------*/

#define ADT_POS_INT(X) ADT_CHECKED_INT ((ADT_WIDE_INT) (X), __FILE__, __LINE__)

#define CAESAR_ADT_MATCH_ADT_POS_INT(X) ((X) >= 0)

#define CAESAR_ADT_GET_1_ADT_POS_INT(X) ADT_CHECKED_NAT ((ADT_WIDE_NAT) ADT_CHECKED_POSITIVE_INT ((X), __FILE__, __LINE__), __FILE__, __LINE__)

/*---------------------------------------------------------------------------*/

#define ADT_NEG_INT(X) ADT_CHECKED_INT ((ADT_WIDE_INT) (- (ADT_WIDE_INT) (X) - 1), __FILE__, __LINE__)

#define CAESAR_ADT_MATCH_ADT_NEG_INT(X) ((X) < 0)

#define CAESAR_ADT_GET_1_ADT_NEG_INT(X) ADT_CHECKED_NAT ((ADT_WIDE_NAT) ADT_CHECKED_POSITIVE_INT ((- (ADT_WIDE_INT) (X) - 1), __FILE__, __LINE__), __FILE__, __LINE__)

/*---------------------------------------------------------------------------*/

#define ADT_SUCC_INT(X) ADT_CHECKED_INT ((ADT_WIDE_INT) (X) + 1, __FILE__, __LINE__)

#define ADT_PRED_INT(X) ADT_CHECKED_INT ((ADT_WIDE_INT) (X) - 1, __FILE__, __LINE__)

/*---------------------------------------------------------------------------*/

#define ADT_I0() ADT_CHECKED_INT ((ADT_WIDE_INT) 0, __FILE__, __LINE__)

#define ADT_I1() ADT_CHECKED_INT ((ADT_WIDE_INT) 1, __FILE__, __LINE__)

#define ADT_I2() ADT_CHECKED_INT ((ADT_WIDE_INT) 2, __FILE__, __LINE__)

#define ADT_I3() ADT_CHECKED_INT ((ADT_WIDE_INT) 3, __FILE__, __LINE__)

#define ADT_I4() ADT_CHECKED_INT ((ADT_WIDE_INT) 4, __FILE__, __LINE__)

#define ADT_I5() ADT_CHECKED_INT ((ADT_WIDE_INT) 5, __FILE__, __LINE__)

#define ADT_I6() ADT_CHECKED_INT ((ADT_WIDE_INT) 6, __FILE__, __LINE__)

#define ADT_I7() ADT_CHECKED_INT ((ADT_WIDE_INT) 7, __FILE__, __LINE__)

#define ADT_I8() ADT_CHECKED_INT ((ADT_WIDE_INT) 8, __FILE__, __LINE__)

#define ADT_I9() ADT_CHECKED_INT ((ADT_WIDE_INT) 9, __FILE__, __LINE__)

/*---------------------------------------------------------------------------*/

#define ADT_IM1() ADT_CHECKED_INT ((ADT_WIDE_INT) -1, __FILE__, __LINE__)

#define ADT_IM2() ADT_CHECKED_INT ((ADT_WIDE_INT) -2, __FILE__, __LINE__)

#define ADT_IM3() ADT_CHECKED_INT ((ADT_WIDE_INT) -3, __FILE__, __LINE__)

#define ADT_IM4() ADT_CHECKED_INT ((ADT_WIDE_INT) -4, __FILE__, __LINE__)

#define ADT_IM5() ADT_CHECKED_INT ((ADT_WIDE_INT) -5, __FILE__, __LINE__)

#define ADT_IM6() ADT_CHECKED_INT ((ADT_WIDE_INT) -6, __FILE__, __LINE__)

#define ADT_IM7() ADT_CHECKED_INT ((ADT_WIDE_INT) -7, __FILE__, __LINE__)

#define ADT_IM8() ADT_CHECKED_INT ((ADT_WIDE_INT) -8, __FILE__, __LINE__)

#define ADT_IM9() ADT_CHECKED_INT ((ADT_WIDE_INT) -9, __FILE__, __LINE__)

/*---------------------------------------------------------------------------*/

#define ADT_SIGN_INT(X) ADT_CHECKED_INT ((ADT_WIDE_INT) ((X) == 0 ? 0 : ((X) > 0 ? 1 : -1)), __FILE__, __LINE__)

#define ADT_ABS_INT(X) ADT_CHECKED_INT ((ADT_WIDE_INT) ((X) >= 0 ? (X) : - (X)), __FILE__, __LINE__)

#define ADT_POSNUM_INT(X) (X)

#define ADT_OPP_INT(X) ADT_CHECKED_INT ((ADT_WIDE_INT) (- (X)), __FILE__, __LINE__)

#define ADT_PLUS_INT(X1,X2) ADT_CHECKED_INT ((ADT_WIDE_INT) (X1) + (ADT_WIDE_INT) (X2), __FILE__, __LINE__)

#define ADT_MINUS_INT(X1,X2) ADT_CHECKED_INT ((ADT_WIDE_INT) (X1) - (ADT_WIDE_INT) (X2), __FILE__, __LINE__)

#define ADT_MULT_INT(X1,X2) ADT_CHECKED_INT ((ADT_WIDE_INT) (X1) * (ADT_WIDE_INT) (X2), __FILE__, __LINE__)

#define ADT_DIV_INT(X1,X2) ADT_CHECKED_INT ((ADT_WIDE_INT) (X1) / (ADT_WIDE_INT) (X2), __FILE__, __LINE__)

#define ADT_REM_INT(X1,X2) ADT_CHECKED_INT ((ADT_WIDE_INT) (X1) % (ADT_WIDE_INT) (X2), __FILE__, __LINE__)

#define ADT_MOD_INT(X1,X2) \
     ADT_CHECKED_INT ((ADT_WIDE_INT) \
	  (((ADT_REM_INT (X1, X2) == 0) || \
	    (ADT_SIGN_INT (X1) == ADT_SIGN_INT (X2))) ? \
	       ADT_REM_INT (X1, X2) : \
	       ADT_PLUS_INT (ADT_REM_INT (X1, X2), X2)), \
	  __FILE__, __LINE__)

#define ADT_POWER_INT(X1,X2) ADT_CHECKED_INT ((ADT_WIDE_INT) pow ((double) (X1), (double) (X2)), __FILE__, __LINE__)

/*---------------------------------------------------------------------------*/

#define ADT_EQ_INT(X1,X2) ((X1) == (X2))

#define ADT_NE_INT(X1,X2) ((X1) != (X2))

#define ADT_LT_INT(X1,X2) ((X1) < (X2))

#define ADT_LE_INT(X1,X2) ((X1) <= (X2))

#define ADT_GT_INT(X1,X2) ((X1) > (X2))

#define ADT_GE_INT(X1,X2) ((X1) >= (X2))

#define ADT_EQ_BIS_INT(X1,X2) ((X1) == (X2))

#define ADT_NE_BIS_INT(X1,X2) ((X1) != (X2))

#define ADT_LT_BIS_INT(X1,X2) ((X1) < (X2))

#define ADT_LE_BIS_INT(X1,X2) ((X1) <= (X2))

#define ADT_GT_BIS_INT(X1,X2) ((X1) > (X2))

#define ADT_GE_BIS_INT(X1,X2) ((X1) >= (X2))

/*---------------------------------------------------------------------------*/

#define ADT_MIN_INT(X1,X2) ((X1) <= (X2) ? (X1) : (X2))

#define ADT_MAX_INT(X1,X2) ((X1) >= (X2) ? (X1) : (X2))

/*---------------------------------------------------------------------------*/

#define ADT_NATTOINT(X) ADT_CHECKED_INT ((ADT_WIDE_INT) (X), __FILE__, __LINE__)

#define ADT_INTTONAT(X) ADT_CHECKED_NAT ((ADT_WIDE_NAT) ADT_CHECKED_POSITIVE_INT ((X), __FILE__, __LINE__), __FILE__, __LINE__)

/*---------------------------------------------------------------------------*/

#ifdef MCL_DATA_EXTENSION

#define ADT_UMINUS_INT(X) ADT_OPP_INT (X)

#endif

/* ------------------------------------------------------------------------- */

#endif
