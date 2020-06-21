/******************************************************************************
 *   			      L N T 2 L O T O S
 *-----------------------------------------------------------------------------
 *   INRIA - Unite de Recherche Rhone-Alpes
 *   655, avenue de l'Europe
 *   38330 Montbonnot Saint Martin
 *   FRANCE
 *-----------------------------------------------------------------------------
 *   Module		:	LNT_V1.h
 *   Auteur		:	Hubert Garavel, Wendelin Serwe, Yves Guerte,
 *				and Gideon Smeding
 *   Version		:	1.47
 *   Date		: 	2018/01/15 15:40:03
 *****************************************************************************/

#ifndef LNT_V1_INTERFACE

#define LNT_V1_INTERFACE

/*---------------------------------------------------------------------------*/

/* This include file is used by the lnt2lotos translator */

#include <stdio.h>		/* for fprintf() and stdout */
#include <stdlib.h>		/* for strtof() and strtod() */

/*---------------------------------------------------------------------------*/

/* implementation of type Action */

#ifndef LNT_OWN_ACTION

#include "X_ACTION.h"

#endif

/*---------------------------------------------------------------------------*/

/* implementation of types Boolean and BooleanExtensions */

#ifndef LNT_OWN_BOOLEAN

#define MCL_DATA_EXTENSION
#include "X_BOOLEAN.h"
#undef MCL_DATA_EXTENSION

/* alternative notations needed for predicate type iterators */
#define CAESAR_ADT_ITR_FIRST_BOOL ADT_ENUM_FIRST_BOOL
#define CAESAR_ADT_ITR_NEXT_BOOL  ADT_ENUM_NEXT_BOOL

#define ADT_AND_BIS(X1,X2)       ADT_AND(X1,X2)
#define ADT_AND_THEN_BIS(X1,X2)  ADT_AND_THEN(X1,X2)
#define ADT_OR_BIS(X1,X2)        ADT_OR(X1,X2)
#define ADT_OR_ELSE_BIS(X1,X2)   ADT_OR_ELSE(X1,X2)
#define ADT_XOR_BIS(X1,X2)       ADT_XOR(X1,X2)
#define ADT_IMPLIES_BIS(X1,X2)   ADT_IMPLIES(X1,X2)
#define ADT_IFF_BIS(X1,X2)       ADT_IFF(X1,X2)

#define ADT_EQ_BIS_BOOL(X1,X2)   ADT_EQ_BOOL(X1,X2)
#define ADT_EQ_TER_BOOL(X1,X2)   ADT_EQ_BOOL(X1,X2)
#define ADT_EQ_QUA_BOOL(X1,X2)   ADT_EQ_BOOL(X1,X2)

#define ADT_NE_BIS_BOOL(X1,X2)   ADT_NE_BOOL(X1,X2)
#define ADT_NE_TER_BOOL(X1,X2)   ADT_NE_BOOL(X1,X2)
#define ADT_NE_QUA_BOOL(X1,X2)   ADT_NE_BOOL(X1,X2)
#define ADT_NE_QUI_BOOL(X1,X2)   ADT_NE_BOOL(X1,X2)
#define ADT_NE_SEX_BOOL(X1,X2)   ADT_NE_BOOL(X1,X2)

#define ADT_LT_BIS_BOOL(X1,X2)   ADT_LT_BOOL(X1,X2)
#define ADT_LT_TER_BOOL(X1,X2)   ADT_LT_BOOL(X1,X2)
#define ADT_LT_QUA_BOOL(X1,X2)   ADT_LT_BOOL(X1,X2)

#define ADT_LE_BIS_BOOL(X1,X2)   ADT_LE_BOOL(X1,X2)
#define ADT_LE_TER_BOOL(X1,X2)   ADT_LE_BOOL(X1,X2)
#define ADT_LE_QUA_BOOL(X1,X2)   ADT_LE_BOOL(X1,X2)

#define ADT_GT_BIS_BOOL(X1,X2)   ADT_GT_BOOL(X1,X2)
#define ADT_GT_TER_BOOL(X1,X2)   ADT_GT_BOOL(X1,X2)
#define ADT_GT_QUA_BOOL(X1,X2)   ADT_GT_BOOL(X1,X2)

#define ADT_GE_BIS_BOOL(X1,X2)   ADT_GE_BOOL(X1,X2)
#define ADT_GE_TER_BOOL(X1,X2)   ADT_GE_BOOL(X1,X2)
#define ADT_GE_QUA_BOOL(X1,X2)   ADT_GE_BOOL(X1,X2)

#endif

/*---------------------------------------------------------------------------*/

/* implementation of types Natural and NaturalExtensions */

#ifndef LNT_OWN_NATURAL

#if !defined (ADT_OVERFLOW_CHECK_NAT)
/* the LNT source code contains no "!nat_check" pragma; yet activate checks */
#define ADT_CHECK_NAT
#elif (ADT_OVERFLOW_CHECK_NAT == 1)
/* the LNT source code contains a "!nat_check 1" pragma => activate checks */
#define ADT_CHECK_NAT
#else
/* ADT_OVERFLOW_CHECK_NAT == 0 => ADT_CHECK_NAT will be undefined */
#endif

#if !defined (ADT_NAT) && !defined (ADT_BITS_NAT)
/* by default, ADT_NAT is in the range 0..255 */
#define ADT_NAT unsigned char
#define ADT_BITS_NAT 8
#ifdef ADT_CHECK_NAT
#define ADT_WIDE_NAT unsigned short
#endif
#ifdef LNT_RESTRICTED_NAT
/* range 0..9 kept for backward compatibility with Lnt2Lotos <= 5.3 */
#define ADT_INF_NAT 0
#define ADT_SUP_NAT 9
#endif
#endif

#include "X_NATURAL.h"

#define ADT_PRED_NAT(X) CAESAR_ADT_GET_1_ADT_SUCC_NAT(X)

/* alternative notations needed for predicate type iterators */
#define CAESAR_ADT_ITR_FIRST_NAT ADT_ENUM_FIRST_NAT
#define CAESAR_ADT_ITR_NEXT_NAT  ADT_ENUM_NEXT_NAT

#define ADT_NA()  ADT_CHECKED_NAT((ADT_WIDE_NAT) 10, __FILE__, __LINE__)
#define ADT_NB()  ADT_CHECKED_NAT((ADT_WIDE_NAT) 11, __FILE__, __LINE__)
#define ADT_NC()  ADT_CHECKED_NAT((ADT_WIDE_NAT) 12, __FILE__, __LINE__)
#define ADT_ND()  ADT_CHECKED_NAT((ADT_WIDE_NAT) 13, __FILE__, __LINE__)
#define ADT_NE()  ADT_CHECKED_NAT((ADT_WIDE_NAT) 14, __FILE__, __LINE__)
#define ADT_NF()  ADT_CHECKED_NAT((ADT_WIDE_NAT) 15, __FILE__, __LINE__)

#define ADT_BINNUM_NAT(X1,X2)      ADT_CHECKED_NAT((2 * (ADT_WIDE_NAT) (X1)) + (ADT_WIDE_NAT) (X2), __FILE__, __LINE__)
#define ADT_OCTNUM_NAT(X1,X2)      ADT_CHECKED_NAT((8 * (ADT_WIDE_NAT) (X1)) + (ADT_WIDE_NAT) (X2), __FILE__, __LINE__)
#define ADT_DECNUM_NAT(X1,X2)      ADT_CHECKED_NAT((10 * (ADT_WIDE_NAT) (X1)) + (ADT_WIDE_NAT) (X2), __FILE__, __LINE__) 
#define ADT_HEXNUM_NAT(X1,X2)      ADT_CHECKED_NAT((16 * (ADT_WIDE_NAT) (X1)) + (ADT_WIDE_NAT) (X2), __FILE__, __LINE__)

#define ADT_PLUS_BIS_NAT(X1,X2)    ADT_PLUS_NAT(X1,X2)
#define ADT_MINUS_BIS_NAT(X1,X2)   ADT_MINUS_NAT(X1,X2)
#define ADT_MULT_BIS_NAT(X1,X2)    ADT_MULT_NAT(X1,X2)
#define ADT_DIV_BIS_NAT(X1,X2)     ADT_DIV_NAT(X1,X2)
#define ADT_MOD_BIS_NAT(X1,X2)     ADT_MOD_NAT(X1,X2)
#define ADT_POWER_BIS_NAT(X1,X2)   ADT_POWER_NAT(X1,X2)

#define ADT_BINNUM_BIS_NAT(X1,X2)  ADT_BINNUM_NAT(X1,X2)
#define ADT_OCTNUM_BIS_NAT(X1,X2)  ADT_OCTNUM_NAT(X1,X2)
#define ADT_DECNUM_BIS_NAT(X1,X2)  ADT_DECNUM_NAT(X1,X2)
#define ADT_HEXNUM_BIS_NAT(X1,X2)  ADT_HEXNUM_NAT(X1,X2)

#define ADT_EQ_TER_NAT(X1,X2)      ADT_EQ_NAT(X1,X2)
#define ADT_EQ_QUA_NAT(X1,X2)      ADT_EQ_NAT(X1,X2)

#define ADT_NE_TER_NAT(X1,X2)      ADT_NE_NAT(X1,X2)
#define ADT_NE_QUA_NAT(X1,X2)      ADT_NE_NAT(X1,X2)
#define ADT_NE_QUI_NAT(X1,X2)      ADT_NE_NAT(X1,X2)
#define ADT_NE_SEX_NAT(X1,X2)      ADT_NE_NAT(X1,X2)

#define ADT_LT_TER_NAT(X1,X2)      ADT_LT_NAT(X1,X2)
#define ADT_LT_QUA_NAT(X1,X2)      ADT_LT_NAT(X1,X2)

#define ADT_LE_TER_NAT(X1,X2)      ADT_LE_NAT(X1,X2)
#define ADT_LE_QUA_NAT(X1,X2)      ADT_LE_NAT(X1,X2)

#define ADT_GT_TER_NAT(X1,X2)      ADT_GT_NAT(X1,X2)
#define ADT_GT_QUA_NAT(X1,X2)      ADT_GT_NAT(X1,X2)

#define ADT_GE_TER_NAT(X1,X2)      ADT_GE_NAT(X1,X2)
#define ADT_GE_QUA_NAT(X1,X2)      ADT_GE_NAT(X1,X2)

#define ADT_MIN_BIS_NAT(X1,X2)     ADT_MIN_NAT(X1,X2)
#define ADT_MAX_BIS_NAT(X1,X2)     ADT_MAX_NAT(X1,X2)
#define ADT_GCD_BIS_NAT(X1,X2)     ADT_GCD_NAT(X1,X2)
#define ADT_SCM_BIS_NAT(X1,X2)     ADT_SCM_NAT(X1,X2)

#endif

/*---------------------------------------------------------------------------*/

/* implementation of types Integer and IntegerExtensions */

#ifndef LNT_OWN_INTEGER

#if !defined (ADT_OVERFLOW_CHECK_INT)
/* the LNT source code contains no "!int_check" pragma; yet activate checks */
#define ADT_CHECK_INT
#elif (ADT_OVERFLOW_CHECK_INT == 1)
/* the LNT source code contains a "!int_check 1" pragma => activate checks */
#define ADT_CHECK_INT
#else
/* ADT_OVERFLOW_CHECK_INT == 0 => ADT_CHECK_INT will be undefined */
#endif

#if !defined (ADT_INT) && !defined (ADT_BITS_INT)
/* by default, ADT_INT is in the range -128..127 */
#define ADT_INT signed char
#ifdef ADT_CHECK_INT
#define ADT_WIDE_INT signed short
#endif
#define ADT_BITS_INT 8
#ifdef LNT_RESTRICTED_INT
/* range -9..9 kept for backward compatibility with Lnt2Lotos <= 5.3 */
#define ADT_INF_INT -9
#define ADT_SUP_INT 9
#endif
#endif

#include "X_INTEGER.h"

/* alternative notations needed for predicate type iterators */
#define CAESAR_ADT_ITR_FIRST_INT ADT_ENUM_FIRST_INT
#define CAESAR_ADT_ITR_NEXT_INT  ADT_ENUM_NEXT_INT

#define ADT_NE_TER_INT(X1,X2) ADT_NE_INT(X1,X2)

#define ADT_IA()  ADT_CHECKED_INT((ADT_WIDE_INT) 10, __FILE__, __LINE__)
#define ADT_IB()  ADT_CHECKED_INT((ADT_WIDE_INT) 11, __FILE__, __LINE__)
#define ADT_IC()  ADT_CHECKED_INT((ADT_WIDE_INT) 12, __FILE__, __LINE__)
#define ADT_ID()  ADT_CHECKED_INT((ADT_WIDE_INT) 13, __FILE__, __LINE__)
#define ADT_IE()  ADT_CHECKED_INT((ADT_WIDE_INT) 14, __FILE__, __LINE__)
#define ADT_IF()  ADT_CHECKED_INT((ADT_WIDE_INT) 15, __FILE__, __LINE__)

#define ADT_NEGNUM_INT(X) ADT_OPP_INT (X)
/*
 * since version 4G, ADT_NEGNUM_INT() has been deprecated and replaced with
 * ADT_OPP_INT()
 */

#define ADT_BINNUM_INT(X1,X2)      ADT_CHECKED_INT((2 * (ADT_WIDE_INT) (X1)) + (ADT_WIDE_INT) (X2), __FILE__, __LINE__)
#define ADT_OCTNUM_INT(X1,X2)      ADT_CHECKED_INT((8 * (ADT_WIDE_INT) (X1)) + (ADT_WIDE_INT) (X2), __FILE__, __LINE__)
#define ADT_DECNUM_INT(X1,X2)      ADT_CHECKED_INT((10 * (ADT_WIDE_INT) (X1)) + (ADT_WIDE_INT) (X2), __FILE__, __LINE__)
#define ADT_HEXNUM_INT(X1,X2)      ADT_CHECKED_INT((16 * (ADT_WIDE_INT) (X1)) + (ADT_WIDE_INT) (X2), __FILE__, __LINE__)

#define ADT_PLUS_BIS_INT(X1,X2)    ADT_PLUS_INT(X1,X2)
#define ADT_MINUS_BIS_INT(X1,X2)   ADT_MINUS_INT(X1,X2)
#define ADT_MULT_BIS_INT(X1,X2)    ADT_MULT_INT(X1,X2)
#define ADT_DIV_BIS_INT(X1,X2)     ADT_DIV_INT(X1,X2)
#define ADT_REM_BIS_INT(X1,X2)     ADT_REM_INT(X1,X2)
#define ADT_MOD_BIS_INT(X1,X2)     ADT_MOD_INT(X1,X2)
#define ADT_POWER_BIS_INT(X1,X2)   ADT_POWER_INT(X1,X2)

#define ADT_BINNUM_BIS_INT(X1,X2)  ADT_BINNUM_INT(X1,X2)
#define ADT_OCTNUM_BIS_INT(X1,X2)  ADT_OCTNUM_INT(X1,X2)
#define ADT_DECNUM_BIS_INT(X1,X2)  ADT_DECNUM_INT(X1,X2)
#define ADT_HEXNUM_BIS_INT(X1,X2)  ADT_HEXNUM_INT(X1,X2)

#define ADT_EQ_TER_INT(X1,X2)      ADT_EQ_INT(X1,X2)
#define ADT_EQ_QUA_INT(X1,X2)      ADT_EQ_INT(X1,X2)

#define ADT_NE_TER_INT(X1,X2)      ADT_NE_INT(X1,X2)
#define ADT_NE_QUA_INT(X1,X2)      ADT_NE_INT(X1,X2)
#define ADT_NE_QUI_INT(X1,X2)      ADT_NE_INT(X1,X2)
#define ADT_NE_SEX_INT(X1,X2)      ADT_NE_INT(X1,X2)

#define ADT_LT_TER_INT(X1,X2)      ADT_LT_INT(X1,X2)
#define ADT_LT_QUA_INT(X1,X2)      ADT_LT_INT(X1,X2)

#define ADT_LE_TER_INT(X1,X2)      ADT_LE_INT(X1,X2)
#define ADT_LE_QUA_INT(X1,X2)      ADT_LE_INT(X1,X2)

#define ADT_GT_TER_INT(X1,X2)      ADT_GT_INT(X1,X2)
#define ADT_GT_QUA_INT(X1,X2)      ADT_GT_INT(X1,X2)

#define ADT_GE_TER_INT(X1,X2)      ADT_GE_INT(X1,X2)
#define ADT_GE_QUA_INT(X1,X2)      ADT_GE_INT(X1,X2)

#define ADT_MIN_BIS_INT(X1,X2)     ADT_MIN_INT(X1,X2)
#define ADT_MAX_BIS_INT(X1,X2)     ADT_MAX_INT(X1,X2)

#endif

/*---------------------------------------------------------------------------*/

/* implementation of type Real */

#ifndef LNT_OWN_REAL

#define MCL_DATA_EXTENSION
#include "X_REAL.h"
#undef MCL_DATA_EXTENSION

#define ADT_ABS_REAL(X) ((X) >= 0 ? (X) : - (X))

#define ADT_PLUS_BIS_REAL(X1,X2)   ADT_PLUS_REAL(X1,X2)
#define ADT_MINUS_BIS_REAL(X1,X2)  ADT_MINUS_REAL(X1,X2)
#define ADT_DIV_BIS_REAL(X1,X2)    ADT_DIV_REAL(X1,X2)
#define ADT_MOD_BIS_REAL(X1,X2)    ADT_MOD_REAL(X1,X2)
#define ADT_MULT_BIS_REAL(X1,X2)   ADT_MULT_REAL(X1,X2)

#define ADT_EQ_TER_REAL(X1,X2)     ADT_EQ_REAL(X1,X2)
#define ADT_EQ_QUA_REAL(X1,X2)     ADT_EQ_REAL(X1,X2)

#define ADT_NE_TER_REAL(X1,X2)     ADT_NE_REAL(X1,X2)
#define ADT_NE_QUA_REAL(X1,X2)     ADT_NE_REAL(X1,X2)
#define ADT_NE_QUI_REAL(X1,X2)     ADT_NE_REAL(X1,X2)
#define ADT_NE_SEX_REAL(X1,X2)     ADT_NE_REAL(X1,X2)

#define ADT_LT_TER_REAL(X1,X2)     ADT_LT_REAL(X1,X2)
#define ADT_LT_QUA_REAL(X1,X2)     ADT_LT_REAL(X1,X2)

#define ADT_LE_TER_REAL(X1,X2)     ADT_LE_REAL(X1,X2)
#define ADT_LE_QUA_REAL(X1,X2)     ADT_LE_REAL(X1,X2)

#define ADT_GT_TER_REAL(X1,X2)     ADT_GT_REAL(X1,X2)
#define ADT_GT_QUA_REAL(X1,X2)     ADT_GT_REAL(X1,X2)

#define ADT_GE_TER_REAL(X1,X2)     ADT_GE_REAL(X1,X2)
#define ADT_GE_QUA_REAL(X1,X2)     ADT_GE_REAL(X1,X2)

#define ADT_REAL_CONS(X) \
	(sizeof (ADT_REAL) == sizeof (float) \
	? strtof (X, (char **) NULL) \
	: strtod (X, (char **) NULL) \
	)

#define ADT_REAL_0() "0"
#define ADT_REAL_1() "1"
#define ADT_REAL_2() "2"
#define ADT_REAL_3() "3"
#define ADT_REAL_4() "4"
#define ADT_REAL_5() "5"
#define ADT_REAL_6() "6"
#define ADT_REAL_7() "7"
#define ADT_REAL_8() "8"
#define ADT_REAL_9() "9"

#define ADT_REAL_POS() "+"
#define ADT_REAL_NEG() "-"
#define ADT_REAL_DOT() "."
#define ADT_REAL_EXP() "E"

#endif

/*---------------------------------------------------------------------------*/

/* implementation of types Character and CharacterExtensions */

#ifndef LNT_OWN_CHARACTER

/* source: http://en.wikipedia.org/wiki/ISO_8859-1 */

#define MCL_DATA_EXTENSION
#include "X_CHARACTER.h"
#undef MCL_DATA_EXTENSION

/* alternative notations needed for predicate type iterators */
#define CAESAR_ADT_ITR_FIRST_CHAR ADT_ENUM_FIRST_CHAR
#define CAESAR_ADT_ITR_NEXT_CHAR  ADT_ENUM_NEXT_CHAR

#define ADT_EQ_BIS_CHAR(X1,X2)     ADT_EQ_CHAR(X1,X2)
#define ADT_EQ_TER_CHAR(X1,X2)     ADT_EQ_CHAR(X1,X2)
#define ADT_EQ_QUA_CHAR(X1,X2)     ADT_EQ_CHAR(X1,X2)

#define ADT_NE_BIS_CHAR(X1,X2)     ADT_NE_CHAR(X1,X2)
#define ADT_NE_TER_CHAR(X1,X2)     ADT_NE_CHAR(X1,X2)
#define ADT_NE_QUA_CHAR(X1,X2)     ADT_NE_CHAR(X1,X2)
#define ADT_NE_QUI_CHAR(X1,X2)     ADT_NE_CHAR(X1,X2)
#define ADT_NE_SEX_CHAR(X1,X2)     ADT_NE_CHAR(X1,X2)

#define ADT_LT_BIS_CHAR(X1,X2)     ADT_LT_CHAR(X1,X2)
#define ADT_LT_TER_CHAR(X1,X2)     ADT_LT_CHAR(X1,X2)
#define ADT_LT_QUA_CHAR(X1,X2)     ADT_LT_CHAR(X1,X2)

#define ADT_LE_BIS_CHAR(X1,X2)     ADT_LE_CHAR(X1,X2)
#define ADT_LE_TER_CHAR(X1,X2)     ADT_LE_CHAR(X1,X2)
#define ADT_LE_QUA_CHAR(X1,X2)     ADT_LE_CHAR(X1,X2)

#define ADT_GT_BIS_CHAR(X1,X2)     ADT_GT_CHAR(X1,X2)
#define ADT_GT_TER_CHAR(X1,X2)     ADT_GT_CHAR(X1,X2)
#define ADT_GT_QUA_CHAR(X1,X2)     ADT_GT_CHAR(X1,X2)

#define ADT_GE_BIS_CHAR(X1,X2)     ADT_GE_CHAR(X1,X2)
#define ADT_GE_TER_CHAR(X1,X2)     ADT_GE_CHAR(X1,X2)
#define ADT_GE_QUA_CHAR(X1,X2)     ADT_GE_CHAR(X1,X2)

#define ADT_CHAR_000()     '\x00'
#define ADT_CHAR_001()     '\x01'
#define ADT_CHAR_002()     '\x02'
#define ADT_CHAR_003()     '\x03'
#define ADT_CHAR_004()     '\x04'
#define ADT_CHAR_005()     '\x05'
#define ADT_CHAR_006()     '\x06'
#define ADT_CHAR_007()     '\x07'
#define ADT_CHAR_008()     '\x08'
#define ADT_CHAR_009()     '\x09'

#define ADT_CHAR_010()     '\x0A'
#define ADT_CHAR_011()     '\x0B'
#define ADT_CHAR_012()     '\x0C'
#define ADT_CHAR_013()     '\x0D'
#define ADT_CHAR_014()     '\x0E'
#define ADT_CHAR_015()     '\x0F'
#define ADT_CHAR_016()     '\x10'
#define ADT_CHAR_017()     '\x11'
#define ADT_CHAR_018()     '\x11'
#define ADT_CHAR_019()     '\x13'

#define ADT_CHAR_020()     '\x14'
#define ADT_CHAR_021()     '\x15'
#define ADT_CHAR_022()     '\x16'
#define ADT_CHAR_023()     '\x17'
#define ADT_CHAR_024()     '\x18'
#define ADT_CHAR_025()     '\x19'
#define ADT_CHAR_026()     '\x1A'
#define ADT_CHAR_027()     '\x1B'
#define ADT_CHAR_028()     '\x1C'
#define ADT_CHAR_029()     '\x1D'

#define ADT_CHAR_030()     '\x1E'
#define ADT_CHAR_031()     '\x1F'
#define ADT_CHAR_032()     ' '
#define ADT_CHAR_033()     '!'
#define ADT_CHAR_034()     '"'
#define ADT_CHAR_035()     '#'
#define ADT_CHAR_036()     '$'
#define ADT_CHAR_037()     '%'
#define ADT_CHAR_038()     '&'
#define ADT_CHAR_039()     '\''

#define ADT_CHAR_040()     '('
#define ADT_CHAR_041()     ')'
#define ADT_CHAR_042()     '*'
#define ADT_CHAR_043()     '+'
#define ADT_CHAR_044()     ','
#define ADT_CHAR_045()     '-'
#define ADT_CHAR_046()     '.'
#define ADT_CHAR_047()     '/'
#define ADT_CHAR_048()     '0'
#define ADT_CHAR_049()     '1'

#define ADT_CHAR_050()     '2'
#define ADT_CHAR_051()     '3'
#define ADT_CHAR_052()     '4'
#define ADT_CHAR_053()     '5'
#define ADT_CHAR_054()     '6'
#define ADT_CHAR_055()     '7'
#define ADT_CHAR_056()     '8'
#define ADT_CHAR_057()     '9'
#define ADT_CHAR_058()     ':'
#define ADT_CHAR_059()     ';'

#define ADT_CHAR_060()     '<'
#define ADT_CHAR_061()     '='
#define ADT_CHAR_062()     '>'
#define ADT_CHAR_063()     '?'
#define ADT_CHAR_064()     '@'
#define ADT_CHAR_065()     'A'
#define ADT_CHAR_066()     'B'
#define ADT_CHAR_067()     'C'
#define ADT_CHAR_068()     'D'
#define ADT_CHAR_069()     'E'

#define ADT_CHAR_070()     'F'
#define ADT_CHAR_071()     'G'
#define ADT_CHAR_072()     'H'
#define ADT_CHAR_073()     'I'
#define ADT_CHAR_074()     'J'
#define ADT_CHAR_075()     'K'
#define ADT_CHAR_076()     'L'
#define ADT_CHAR_077()     'M'
#define ADT_CHAR_078()     'N'
#define ADT_CHAR_079()     'O'

#define ADT_CHAR_080()     'P'
#define ADT_CHAR_081()     'Q'
#define ADT_CHAR_082()     'R'
#define ADT_CHAR_083()     'S'
#define ADT_CHAR_084()     'T'
#define ADT_CHAR_085()     'U'
#define ADT_CHAR_086()     'V'
#define ADT_CHAR_087()     'W'
#define ADT_CHAR_088()     'X'
#define ADT_CHAR_089()     'Y'

#define ADT_CHAR_090()     'Z'
#define ADT_CHAR_091()     '['
#define ADT_CHAR_092()     '\\'
#define ADT_CHAR_093()     ']'
#define ADT_CHAR_094()     '^'
#define ADT_CHAR_095()     '_'
#define ADT_CHAR_096()     '`'
#define ADT_CHAR_097()     'a'
#define ADT_CHAR_098()     'b'
#define ADT_CHAR_099()     'c'

#define ADT_CHAR_100()     'd'
#define ADT_CHAR_101()     'e'
#define ADT_CHAR_102()     'f'
#define ADT_CHAR_103()     'g'
#define ADT_CHAR_104()     'h'
#define ADT_CHAR_105()     'i'
#define ADT_CHAR_106()     'j'
#define ADT_CHAR_107()     'k'
#define ADT_CHAR_108()     'l'
#define ADT_CHAR_109()     'm'

#define ADT_CHAR_110()     'n'
#define ADT_CHAR_111()     'o'
#define ADT_CHAR_112()     'p'
#define ADT_CHAR_113()     'q'
#define ADT_CHAR_114()     'r'
#define ADT_CHAR_115()     's'
#define ADT_CHAR_116()     't'
#define ADT_CHAR_117()     'u'
#define ADT_CHAR_118()     'v'
#define ADT_CHAR_119()     'w'

#define ADT_CHAR_120()     'x'
#define ADT_CHAR_121()     'y'
#define ADT_CHAR_122()     'z'
#define ADT_CHAR_123()     '{'
#define ADT_CHAR_124()     '|'
#define ADT_CHAR_125()     '}'
#define ADT_CHAR_126()     '~'
#define ADT_CHAR_127()     '\x7F'
#define ADT_CHAR_128()     '\x80'
#define ADT_CHAR_129()     '\x81'

#define ADT_CHAR_130()     '\x82'
#define ADT_CHAR_131()     '\x83'
#define ADT_CHAR_132()     '\x84'
#define ADT_CHAR_133()     '\x85'
#define ADT_CHAR_134()     '\x86'
#define ADT_CHAR_135()     '\x87'
#define ADT_CHAR_136()     '\x88'
#define ADT_CHAR_137()     '\x89'
#define ADT_CHAR_138()     '\x8A'
#define ADT_CHAR_139()     '\x8B'

#define ADT_CHAR_140()     '\x8C'
#define ADT_CHAR_141()     '\x8D'
#define ADT_CHAR_142()     '\x8E'
#define ADT_CHAR_143()     '\x8F'
#define ADT_CHAR_144()     '\x90'
#define ADT_CHAR_145()     '\x91'
#define ADT_CHAR_146()     '\x92'
#define ADT_CHAR_147()     '\x93'
#define ADT_CHAR_148()     '\x94'
#define ADT_CHAR_149()     '\x95'
#define ADT_CHAR_150()     '\x96'

#define ADT_CHAR_151()     '\x97'
#define ADT_CHAR_152()     '\x98'
#define ADT_CHAR_153()     '\x99'
#define ADT_CHAR_154()     '\x9A'
#define ADT_CHAR_155()     '\x9B'
#define ADT_CHAR_156()     '\x9C'
#define ADT_CHAR_157()     '\x9D'
#define ADT_CHAR_158()     '\x9E'
#define ADT_CHAR_159()     '\x9F'
#define ADT_CHAR_160()     '\xA0'

#define ADT_CHAR_161()     '¡'
#define ADT_CHAR_162()     '¢'
#define ADT_CHAR_163()     '£'
#define ADT_CHAR_164()     '¤'
#define ADT_CHAR_165()     '¥'
#define ADT_CHAR_166()     '¦'
#define ADT_CHAR_167()     '§'
#define ADT_CHAR_168()     '¨'
#define ADT_CHAR_169()     '©'

#define ADT_CHAR_170()     'ª'
#define ADT_CHAR_171()     '«'
#define ADT_CHAR_172()     '¬'
#define ADT_CHAR_173()     '­'
#define ADT_CHAR_174()     '®'
#define ADT_CHAR_175()     '¯'
#define ADT_CHAR_176()     '°'
#define ADT_CHAR_177()     '±'
#define ADT_CHAR_178()     '²'
#define ADT_CHAR_179()     '³'

#define ADT_CHAR_180()     '´'
#define ADT_CHAR_181()     'µ'
#define ADT_CHAR_182()     '¶'
#define ADT_CHAR_183()     '·'
#define ADT_CHAR_184()     '¸'
#define ADT_CHAR_185()     '¹'
#define ADT_CHAR_186()     'º'
#define ADT_CHAR_187()     '»'
#define ADT_CHAR_188()     '¼'
#define ADT_CHAR_189()     '½'

#define ADT_CHAR_190()     '¾'
#define ADT_CHAR_191()     '¿'
#define ADT_CHAR_192()     'À'
#define ADT_CHAR_193()     'Á'
#define ADT_CHAR_194()     'Â'
#define ADT_CHAR_195()     'Ã'
#define ADT_CHAR_196()     'Ä'
#define ADT_CHAR_197()     'Å'
#define ADT_CHAR_198()     'Æ'
#define ADT_CHAR_199()     'Ç'

#define ADT_CHAR_200()     'È'
#define ADT_CHAR_201()     'É'
#define ADT_CHAR_202()     'Ê'
#define ADT_CHAR_203()     'Ë'
#define ADT_CHAR_204()     'Ì'
#define ADT_CHAR_205()     'Í'
#define ADT_CHAR_206()     'Î'
#define ADT_CHAR_207()     'Ï'
#define ADT_CHAR_208()     'Ð'
#define ADT_CHAR_209()     'Ñ'

#define ADT_CHAR_210()     'Ò'
#define ADT_CHAR_211()     'Ó'
#define ADT_CHAR_212()     'Ô'
#define ADT_CHAR_213()     'Õ'
#define ADT_CHAR_214()     'Ö'
#define ADT_CHAR_215()     '×'
#define ADT_CHAR_216()     'Ø'
#define ADT_CHAR_217()     'Ù'
#define ADT_CHAR_218()     'Ú'
#define ADT_CHAR_219()     'Û'

#define ADT_CHAR_220()     'Ü'
#define ADT_CHAR_221()     'Ý'
#define ADT_CHAR_222()     'Þ'
#define ADT_CHAR_223()     'ß'
#define ADT_CHAR_224()     'à'
#define ADT_CHAR_225()     'á'
#define ADT_CHAR_226()     'â'
#define ADT_CHAR_227()     'ã'
#define ADT_CHAR_228()     'ä'
#define ADT_CHAR_229()     'å'

#define ADT_CHAR_230()     'æ'
#define ADT_CHAR_231()     'ç'
#define ADT_CHAR_232()     'è'
#define ADT_CHAR_233()     'é'
#define ADT_CHAR_234()     'ê'
#define ADT_CHAR_235()     'ë'
#define ADT_CHAR_236()     'ì'
#define ADT_CHAR_237()     'í'
#define ADT_CHAR_238()     'î'
#define ADT_CHAR_239()     'ï'

#define ADT_CHAR_240()     'ð'
#define ADT_CHAR_241()     'ñ'
#define ADT_CHAR_242()     'ò'
#define ADT_CHAR_243()     'ó'
#define ADT_CHAR_244()     'ô'
#define ADT_CHAR_245()     'õ'
#define ADT_CHAR_246()     'ö'
#define ADT_CHAR_247()     '÷'
#define ADT_CHAR_248()     'ø'
#define ADT_CHAR_249()     'ù'

#define ADT_CHAR_250()     'ú'
#define ADT_CHAR_251()     'û'
#define ADT_CHAR_252()     'ü'
#define ADT_CHAR_253()     'ý'
#define ADT_CHAR_254()     'þ'
#define ADT_CHAR_255()     'ÿ'

#endif

/*---------------------------------------------------------------------------*/

/* implementation of types String and StringExtensions */

#ifndef LNT_OWN_STRING

#define MCL_DATA_EXTENSION
#include "X_STRING.h"
#undef MCL_DATA_EXTENSION

#define ADT_STORE_STRING(X) CAESAR_ADT_CONTENTS_STORE_ADT_STRING (X)

#define ADT_CONCAT_CONST_STRING(X1,X2) X1 X2

#define ADT_CONCAT_BIS_STRING(X1,X2)       ADT_CONCAT_STRING(X1,X2)
#define ADT_CONCAT_CONST_BIS_STRING(X1,X2) ADT_CONCAT_CONST_STRING(X1,X2)
#define ADT_PREFIX_BIS_STRING(X1,X2)       ADT_PREFIX_STRING(X1,X2)
#define ADT_SUFFIX_BIS_STRING(X1,X2)       ADT_SUFFIX_STRING(X1,X2)
#define ADT_NTH_BIS_STRING(X1,X2)          ADT_NTH_STRING(X1,X2)
#define ADT_INDEX_BIS_STRING(X1,X2)        ADT_INDEX_STRING(X1,X2)
#define ADT_RINDEX_BIS_STRING(X1,X2)       ADT_RINDEX_STRING(X1,X2)

#define ADT_EQ_BIS_STRING(X1,X2)     ADT_EQ_STRING(X1,X2)
#define ADT_EQ_TER_STRING(X1,X2)     ADT_EQ_STRING(X1,X2)
#define ADT_EQ_QUA_STRING(X1,X2)     ADT_EQ_STRING(X1,X2)

#define ADT_NE_BIS_STRING(X1,X2)     ADT_NE_STRING(X1,X2)
#define ADT_NE_TER_STRING(X1,X2)     ADT_NE_STRING(X1,X2)
#define ADT_NE_QUA_STRING(X1,X2)     ADT_NE_STRING(X1,X2)
#define ADT_NE_QUI_STRING(X1,X2)     ADT_NE_STRING(X1,X2)
#define ADT_NE_SEX_STRING(X1,X2)     ADT_NE_STRING(X1,X2)

#define ADT_LT_BIS_STRING(X1,X2)     ADT_LT_STRING(X1,X2)
#define ADT_LT_TER_STRING(X1,X2)     ADT_LT_STRING(X1,X2)
#define ADT_LT_QUA_STRING(X1,X2)     ADT_LT_STRING(X1,X2)

#define ADT_LE_BIS_STRING(X1,X2)     ADT_LE_STRING(X1,X2)
#define ADT_LE_TER_STRING(X1,X2)     ADT_LE_STRING(X1,X2)
#define ADT_LE_QUA_STRING(X1,X2)     ADT_LE_STRING(X1,X2)

#define ADT_GT_BIS_STRING(X1,X2)     ADT_GT_STRING(X1,X2)
#define ADT_GT_TER_STRING(X1,X2)     ADT_GT_STRING(X1,X2)
#define ADT_GT_QUA_STRING(X1,X2)     ADT_GT_STRING(X1,X2)

#define ADT_GE_BIS_STRING(X1,X2)     ADT_GE_STRING(X1,X2)
#define ADT_GE_TER_STRING(X1,X2)     ADT_GE_STRING(X1,X2)
#define ADT_GE_QUA_STRING(X1,X2)     ADT_GE_STRING(X1,X2)

#define ADT_STRING_000()     "\x00"
#define ADT_STRING_001()     "\x01"
#define ADT_STRING_002()     "\x02"
#define ADT_STRING_003()     "\x03"
#define ADT_STRING_004()     "\x04"
#define ADT_STRING_005()     "\x05"
#define ADT_STRING_006()     "\x06"
#define ADT_STRING_007()     "\x07"
#define ADT_STRING_008()     "\x08"
#define ADT_STRING_009()     "\x09"

#define ADT_STRING_010()     "\x0A"
#define ADT_STRING_011()     "\x0B"
#define ADT_STRING_012()     "\x0C"
#define ADT_STRING_013()     "\x0D"
#define ADT_STRING_014()     "\x0E"
#define ADT_STRING_015()     "\x0F"
#define ADT_STRING_016()     "\x10"
#define ADT_STRING_017()     "\x11"
#define ADT_STRING_018()     "\x11"
#define ADT_STRING_019()     "\x13"

#define ADT_STRING_020()     "\x14"
#define ADT_STRING_021()     "\x15"
#define ADT_STRING_022()     "\x16"
#define ADT_STRING_023()     "\x17"
#define ADT_STRING_024()     "\x18"
#define ADT_STRING_025()     "\x19"
#define ADT_STRING_026()     "\x1A"
#define ADT_STRING_027()     "\x1B"
#define ADT_STRING_028()     "\x1C"
#define ADT_STRING_029()     "\x1D"

#define ADT_STRING_030()     "\x1E"
#define ADT_STRING_031()     "\x1F"
#define ADT_STRING_032()     " "
#define ADT_STRING_033()     "!"
#define ADT_STRING_034()     "\""
#define ADT_STRING_035()     "#"
#define ADT_STRING_036()     "$"
#define ADT_STRING_037()     "%"
#define ADT_STRING_038()     "&"
#define ADT_STRING_039()     "'"

#define ADT_STRING_040()     "("
#define ADT_STRING_041()     ")"
#define ADT_STRING_042()     "*"
#define ADT_STRING_043()     "+"
#define ADT_STRING_044()     ","
#define ADT_STRING_045()     "-"
#define ADT_STRING_046()     "."
#define ADT_STRING_047()     "/"
#define ADT_STRING_048()     "0"
#define ADT_STRING_049()     "1"

#define ADT_STRING_050()     "2"
#define ADT_STRING_051()     "3"
#define ADT_STRING_052()     "4"
#define ADT_STRING_053()     "5"
#define ADT_STRING_054()     "6"
#define ADT_STRING_055()     "7"
#define ADT_STRING_056()     "8"
#define ADT_STRING_057()     "9"
#define ADT_STRING_058()     ":"
#define ADT_STRING_059()     ";"

#define ADT_STRING_060()     "<"
#define ADT_STRING_061()     "="
#define ADT_STRING_062()     ">"
#define ADT_STRING_063()     "?"
#define ADT_STRING_064()     "@"
#define ADT_STRING_065()     "A"
#define ADT_STRING_066()     "B"
#define ADT_STRING_067()     "C"
#define ADT_STRING_068()     "D"
#define ADT_STRING_069()     "E"

#define ADT_STRING_070()     "F"
#define ADT_STRING_071()     "G"
#define ADT_STRING_072()     "H"
#define ADT_STRING_073()     "I"
#define ADT_STRING_074()     "J"
#define ADT_STRING_075()     "K"
#define ADT_STRING_076()     "L"
#define ADT_STRING_077()     "M"
#define ADT_STRING_078()     "N"
#define ADT_STRING_079()     "O"

#define ADT_STRING_080()     "P"
#define ADT_STRING_081()     "Q"
#define ADT_STRING_082()     "R"
#define ADT_STRING_083()     "S"
#define ADT_STRING_084()     "T"
#define ADT_STRING_085()     "U"
#define ADT_STRING_086()     "V"
#define ADT_STRING_087()     "W"
#define ADT_STRING_088()     "X"
#define ADT_STRING_089()     "Y"

#define ADT_STRING_090()     "Z"
#define ADT_STRING_091()     "["
#define ADT_STRING_092()     "\\"
#define ADT_STRING_093()     "]"
#define ADT_STRING_094()     "^"
#define ADT_STRING_095()     "_"
#define ADT_STRING_096()     "`"
#define ADT_STRING_097()     "a"
#define ADT_STRING_098()     "b"
#define ADT_STRING_099()     "c"

#define ADT_STRING_100()     "d"
#define ADT_STRING_101()     "e"
#define ADT_STRING_102()     "f"
#define ADT_STRING_103()     "g"
#define ADT_STRING_104()     "h"
#define ADT_STRING_105()     "i"
#define ADT_STRING_106()     "j"
#define ADT_STRING_107()     "k"
#define ADT_STRING_108()     "l"
#define ADT_STRING_109()     "m"

#define ADT_STRING_110()     "n"
#define ADT_STRING_111()     "o"
#define ADT_STRING_112()     "p"
#define ADT_STRING_113()     "q"
#define ADT_STRING_114()     "r"
#define ADT_STRING_115()     "s"
#define ADT_STRING_116()     "t"
#define ADT_STRING_117()     "u"
#define ADT_STRING_118()     "v"
#define ADT_STRING_119()     "w"

#define ADT_STRING_120()     "x"
#define ADT_STRING_121()     "y"
#define ADT_STRING_122()     "z"
#define ADT_STRING_123()     "{"
#define ADT_STRING_124()     "|"
#define ADT_STRING_125()     "}"
#define ADT_STRING_126()     "~"
#define ADT_STRING_127()     "\x7F"
#define ADT_STRING_128()     "\x80"
#define ADT_STRING_129()     "\x81"

#define ADT_STRING_130()     "\x82"
#define ADT_STRING_131()     "\x83"
#define ADT_STRING_132()     "\x84"
#define ADT_STRING_133()     "\x85"
#define ADT_STRING_134()     "\x86"
#define ADT_STRING_135()     "\x87"
#define ADT_STRING_136()     "\x88"
#define ADT_STRING_137()     "\x89"
#define ADT_STRING_138()     "\x8A"
#define ADT_STRING_139()     "\x8B"

#define ADT_STRING_140()     "\x8C"
#define ADT_STRING_141()     "\x8D"
#define ADT_STRING_142()     "\x8E"
#define ADT_STRING_143()     "\x8F"
#define ADT_STRING_144()     "\x90"
#define ADT_STRING_145()     "\x91"
#define ADT_STRING_146()     "\x92"
#define ADT_STRING_147()     "\x93"
#define ADT_STRING_148()     "\x94"
#define ADT_STRING_149()     "\x95"

#define ADT_STRING_150()     "\x96"
#define ADT_STRING_151()     "\x97"
#define ADT_STRING_152()     "\x98"
#define ADT_STRING_153()     "\x99"
#define ADT_STRING_154()     "\x9A"
#define ADT_STRING_155()     "\x9B"
#define ADT_STRING_156()     "\x9C"
#define ADT_STRING_157()     "\x9D"
#define ADT_STRING_158()     "\x9E"
#define ADT_STRING_159()     "\x9F"

#define ADT_STRING_160()     "\xA0"
#define ADT_STRING_161()     "¡"
#define ADT_STRING_162()     "¢"
#define ADT_STRING_163()     "£"
#define ADT_STRING_164()     "¤"
#define ADT_STRING_165()     "¥"
#define ADT_STRING_166()     "¦"
#define ADT_STRING_167()     "§"
#define ADT_STRING_168()     "¨"
#define ADT_STRING_169()     "©"

#define ADT_STRING_170()     "ª"
#define ADT_STRING_171()     "«"
#define ADT_STRING_172()     "¬"
#define ADT_STRING_173()     "­"
#define ADT_STRING_174()     "®"
#define ADT_STRING_175()     "¯"
#define ADT_STRING_176()     "°"
#define ADT_STRING_177()     "±"
#define ADT_STRING_178()     "²"
#define ADT_STRING_179()     "³"

#define ADT_STRING_180()     "´"
#define ADT_STRING_181()     "µ"
#define ADT_STRING_182()     "¶"
#define ADT_STRING_183()     "·"
#define ADT_STRING_184()     "¸"
#define ADT_STRING_185()     "¹"
#define ADT_STRING_186()     "º"
#define ADT_STRING_187()     "»"
#define ADT_STRING_188()     "¼"
#define ADT_STRING_189()     "½"

#define ADT_STRING_190()     "¾"
#define ADT_STRING_191()     "¿"
#define ADT_STRING_192()     "À"
#define ADT_STRING_193()     "Á"
#define ADT_STRING_194()     "Â"
#define ADT_STRING_195()     "Ã"
#define ADT_STRING_196()     "Ä"
#define ADT_STRING_197()     "Å"
#define ADT_STRING_198()     "Æ"
#define ADT_STRING_199()     "Ç"

#define ADT_STRING_200()     "È"
#define ADT_STRING_201()     "É"
#define ADT_STRING_202()     "Ê"
#define ADT_STRING_203()     "Ë"
#define ADT_STRING_204()     "Ì"
#define ADT_STRING_205()     "Í"
#define ADT_STRING_206()     "Î"
#define ADT_STRING_207()     "Ï"
#define ADT_STRING_208()     "Ð"
#define ADT_STRING_209()     "Ñ"

#define ADT_STRING_210()     "Ò"
#define ADT_STRING_211()     "Ó"
#define ADT_STRING_212()     "Ô"
#define ADT_STRING_213()     "Õ"
#define ADT_STRING_214()     "Ö"
#define ADT_STRING_215()     "×"
#define ADT_STRING_216()     "Ø"
#define ADT_STRING_217()     "Ù"
#define ADT_STRING_218()     "Ú"
#define ADT_STRING_219()     "Û"

#define ADT_STRING_220()     "Ü"
#define ADT_STRING_221()     "Ý"
#define ADT_STRING_222()     "Þ"
#define ADT_STRING_223()     "ß"
#define ADT_STRING_224()     "à"
#define ADT_STRING_225()     "á"
#define ADT_STRING_226()     "â"
#define ADT_STRING_227()     "ã"
#define ADT_STRING_228()     "ä"
#define ADT_STRING_229()     "å"

#define ADT_STRING_230()     "æ"
#define ADT_STRING_231()     "ç"
#define ADT_STRING_232()     "è"
#define ADT_STRING_233()     "é"
#define ADT_STRING_234()     "ê"
#define ADT_STRING_235()     "ë"
#define ADT_STRING_236()     "ì"
#define ADT_STRING_237()     "í"
#define ADT_STRING_238()     "î"
#define ADT_STRING_239()     "ï"

#define ADT_STRING_240()     "ð"
#define ADT_STRING_241()     "ñ"
#define ADT_STRING_242()     "ò"
#define ADT_STRING_243()     "ó"
#define ADT_STRING_244()     "ô"
#define ADT_STRING_245()     "õ"
#define ADT_STRING_246()     "ö"
#define ADT_STRING_247()     "÷"
#define ADT_STRING_248()     "ø"
#define ADT_STRING_249()     "ù"

#define ADT_STRING_250()     "ú"
#define ADT_STRING_251()     "û"
#define ADT_STRING_252()     "ü"
#define ADT_STRING_253()     "ý"
#define ADT_STRING_254()     "þ"
#define ADT_STRING_255()     "ÿ"

#endif

/*---------------------------------------------------------------------------*/

/* implementation of the type Number */

#ifndef LNT_OWN_NUMBER

typedef int ADT_NUMBER;

#define CAESAR_ADT_SCALAR_ADT_NUMBER

#define ADT_CMP_NUMBER(X1,X2) ((X1) == (X2))

#define ADT_ENUM_FIRST_NUMBER() 0
#define ADT_ENUM_NEXT_NUMBER(X) ((X)++ < INT_MAX)

#define ADT_PRINT_NUMBER(F,X) fprintf ((F), "%d", (X))

#define ADT_NUMBER0() 0
#define ADT_NUMBER1() 1
#define ADT_NUMBER2() 2
#define ADT_NUMBER3() 3
#define ADT_NUMBER4() 4
#define ADT_NUMBER5() 5
#define ADT_NUMBER6() 6
#define ADT_NUMBER7() 7
#define ADT_NUMBER8() 8
#define ADT_NUMBER9() 9

#define ADT_DECNUM_NUMBER(X1,X2)   ((10 * (X1)) + (X2))

#endif

/*---------------------------------------------------------------------------*/

#endif

