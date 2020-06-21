/******************************************************************************
 *   			            C A D P
 *-----------------------------------------------------------------------------
 *   INRIA - Centre de Recherche de Grenoble Rhone-Alpes
 *   655, avenue de l'Europe
 *   38330 Montbonnot Saint Martin
 *   FRANCE
 *-----------------------------------------------------------------------------
 *   Module		:	X_BIT.h
 *   Auteur		:	Hubert GARAVEL
 *   Version		:	1.2
 *   Date		: 	2018/01/14 10:12:45
 *****************************************************************************/

#ifndef ADT_X_BIT

#define ADT_X_BIT

/*---------------------------------------------------------------------------*/

typedef unsigned char ADT_BIT;

#define CAESAR_ADT_SCALAR_ADT_BIT

#ifndef lint
#define CAESAR_ADT_BITS_ADT_BIT : 1
#endif

#define ADT_CMP_BIT(X1,X2) ((X1) == (X2))

#define ADT_ENUM_FIRST_BIT() (ADT_ZERO_BIT ())

#define ADT_ENUM_NEXT_BIT(X) ((X)++ < ADT_ONE_BIT ())

#define ADT_PRINT_BIT(F,X) fprintf((F), (X) ? "1" : "0")

/*---------------------------------------------------------------------------*/

#define ADT_ZERO_BIT() ((ADT_BIT) 0)

#define CAESAR_ADT_MATCH_ADT_ZERO_BIT(X) ((X) == 0)

/*---------------------------------------------------------------------------*/

#define ADT_ONE_BIT() ((ADT_BIT) 1)

#define CAESAR_ADT_MATCH_ADT_ONE_BIT(X) ((X) == 1)

/*---------------------------------------------------------------------------*/

#define ADT_NOT_BIT(X) ((ADT_BIT) ((X) ? 0 : 1))

#define ADT_AND_BIT(X1,X2) ((ADT_BIT) ((X1) & (X2)))

#define ADT_OR_BIT(X1,X2) ((ADT_BIT) ((X1) | (X2)))

#define ADT_XOR_BIT(X1,X2) ((ADT_BIT) ((X1) ^ (X2)))

#define ADT_EQ_BIT(X1,X2) ((X1) == (X2))

#define ADT_NE_BIT(X1,X2) ((X1) != (X2))

#define ADT_LT_BIT(X1,X2) ((X1) < (X2))

#define ADT_LE_BIT(X1,X2) ((X1) <= (X2))

#define ADT_GT_BIT(X1,X2) ((X1) > (X2))

#define ADT_GE_BIT(X1,X2) ((X1) >= (X2))

#define ADT_NATNUM_BIT(X) ((ADT_NAT) (X))

/*---------------------------------------------------------------------------*/

#endif

