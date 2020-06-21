/******************************************************************************
 *   			            C A D P
 *-----------------------------------------------------------------------------
 *   INRIA - Centre de Recherche de Grenoble Rhone-Alpes
 *   655, avenue de l'Europe
 *   38330 Montbonnot Saint Martin
 *   FRANCE
 *-----------------------------------------------------------------------------
 *   Module		:	X_BOOLEAN.h
 *   Auteur		:	Hubert GARAVEL
 *   Version		:	1.4
 *   Date		: 	2018/01/03 11:04:08
 *****************************************************************************/

#ifndef ADT_X_BOOLEAN

#define ADT_X_BOOLEAN

/*---------------------------------------------------------------------------*/

#include "adt_boolean.h"

/*---------------------------------------------------------------------------*/

#define ADT_FALSE() ((ADT_BOOL) 0)

#define CAESAR_ADT_MATCH_ADT_FALSE(X) ((X) == 0)

/*---------------------------------------------------------------------------*/

#define ADT_TRUE() ((ADT_BOOL) 1)

#define CAESAR_ADT_MATCH_ADT_TRUE(X) ((X) == 1)

/*---------------------------------------------------------------------------*/

#define ADT_NOT(X) ((ADT_BOOL) ((! (X)) ? ADT_TRUE() : ADT_FALSE()))

#define ADT_AND(X1,X2) ((ADT_BOOL) (((X1) && (X2)) ? ADT_TRUE() : ADT_FALSE()))

#define ADT_AND_THEN(X1,X2) ((ADT_BOOL) (((X1) && (X2)) ? ADT_TRUE() : ADT_FALSE()))

#define ADT_OR(X1,X2) ((ADT_BOOL) (((X1) || (X2)) ? ADT_TRUE() : ADT_FALSE()))

#define ADT_OR_ELSE(X1,X2) ((ADT_BOOL) (((X1) || (X2)) ? ADT_TRUE() : ADT_FALSE()))

#define ADT_XOR(X1,X2) ((ADT_BOOL) (((X1) ? ! (X2) : (X2)) ? ADT_TRUE() : ADT_FALSE()))

#define ADT_IMPLIES(X1,X2) ((ADT_BOOL) ((! (X1) || (X2)) ? ADT_TRUE() : ADT_FALSE()))

#define ADT_IFF(X1,X2) ((ADT_BOOL) (((X1) ? (X2) : ! (X2)) ? ADT_TRUE() : ADT_FALSE()))

#define ADT_EQ_BOOL(X1,X2) ADT_IFF (X1, X2)

#define ADT_NE_BOOL(X1,X2) ADT_XOR (X1, X2)

/*---------------------------------------------------------------------------*/

#ifdef MCL_DATA_EXTENSION

#define ADT_LT_BOOL(X1, X2) ((ADT_BOOL) ((! (X1) && (X2)) ? ADT_TRUE () : ADT_FALSE ()))

#define ADT_LE_BOOL(X1, X2) ((ADT_BOOL) ((! (X1) || (X2)) ? ADT_TRUE () : ADT_FALSE ()))

#define ADT_GT_BOOL(X1, X2) ((ADT_BOOL) (((X1) && ! (X2)) ? ADT_TRUE () : ADT_FALSE ()))

#define ADT_GE_BOOL(X1, X2) ((ADT_BOOL) (((X1) || ! (X2)) ? ADT_TRUE () : ADT_FALSE ()))

#endif

/*---------------------------------------------------------------------------*/

#endif

