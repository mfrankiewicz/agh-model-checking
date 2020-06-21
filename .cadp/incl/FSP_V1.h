/******************************************************************************
 *                            F S P 2 L O T O S
 *-----------------------------------------------------------------------------
 *   INRIA - Unite de Recherche Rhone-Alpes
 *   655, avenue de l'Europe
 *   38330 Montbonnot Saint Martin
 *   FRANCE
 *-----------------------------------------------------------------------------
 *   Module		:	FSP_V1.h
 *   Auteur		:	Remi Herilier and Frederic Lang
 *   Version		:	1.5
 *   Date		:	2018/01/15 16:40:28
 *****************************************************************************/

/*---------------------------------------------------------------------------*/

/* This include file is used by the fsp2lotos translator */

/*---------------------------------------------------------------------------*/

/* implementation of type Integer */

typedef int ADT_INT;

#define ADT_FALSE_INT() (0)
#define ADT_TRUE_INT() (1)
#define ADT_BOOL_INT(X) ((X) ? ADT_TRUE_INT () : ADT_FALSE_INT ())
#define ADT_EQ_INT(X1,X2) (ADT_BOOL_INT ((X1) == (X2)))
#define ADT_NE_INT(X1,X2) (ADT_BOOL_INT ((X1) != (X2)))
#define ADT_LT_INT(X1,X2) (ADT_BOOL_INT ((X1) < (X2)))
#define ADT_LE_INT(X1,X2) (ADT_BOOL_INT ((X1) <= (X2)))
#define ADT_GT_INT(X1,X2) (ADT_BOOL_INT ((X1) > (X2)))
#define ADT_GE_INT(X1,X2) (ADT_BOOL_INT ((X1) >= (X2)))
#define ADT_DIV_INT(X1,X2) ((X1) / (X2))
#define ADT_MOD_INT(X1,X2) ((X1) % (X2))
#define ADT_NOT_INT(X) (ADT_BOOL_INT (!(X)))
#define ADT_AND_INT(X1,X2) (ADT_BOOL_INT ((X1) && (X2)))
#define ADT_OR_INT(X1,X2) (ADT_BOOL_INT ((X1) || (X2)))
#define ADT_BOR_INT(X1,X2) ((X1) | (X2))
#define ADT_BXOR_INT(X1,X2) ((X1) ^ (X2))
#define ADT_BAND_INT(X1,X2) ((X1) & (X2))
#define ADT_SHIFTL_INT(X1,X2) ((X1) << (X2))
#define ADT_SHIFTR_INT(X1,X2) ((X1) >> (X2))
#define ADT_OPP_INT(X) (-(X))
#define ADT_PLUS_INT(X1,X2) ((X1) + (X2))
#define ADT_MINUS_INT(X1,X2) ((X1) - (X2))
#define ADT_MULT_INT(X1,X2) ((X1) * (X2))

#define ADT_CMP_INT(X1,X2) ((X1) == (X2))
#define ADT_PRINT_INT(F,X) fprintf ((F), "%d", (X))

/*---------------------------------------------------------------------------*/
