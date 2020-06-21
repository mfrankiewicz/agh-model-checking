/******************************************************************************
 *   			            C A D P
 *-----------------------------------------------------------------------------
 *   INRIA - Centre de Recherche de Grenoble Rhone-Alpes
 *   655, avenue de l'Europe
 *   38330 Montbonnot Saint Martin
 *   FRANCE
 *-----------------------------------------------------------------------------
 *   Module		:	X_REAL.h
 *   Auteur		:	Hubert GARAVEL
 *   Version		:	1.3
 *   Date		: 	2018/01/03 11:06:01
 *****************************************************************************/

#ifndef ADT_X_REAL

#define ADT_X_REAL

/*---------------------------------------------------------------------------*/

#include "adt_real.h"

/*---------------------------------------------------------------------------*/

#define ADT_EQ_REAL(X1,X2) ((X1) == (X2))

#define ADT_NE_REAL(X1,X2) ((X1) != (X2))

#define ADT_LT_REAL(X1,X2) ((X1) < (X2))

#define ADT_LE_REAL(X1,X2) ((X1) <= (X2))

#define ADT_GT_REAL(X1,X2) ((X1) > (X2))

#define ADT_GE_REAL(X1,X2) ((X1) >= (X2))

#define ADT_EQ_BIS_REAL(X1,X2) ((X1) == (X2))

#define ADT_NE_BIS_REAL(X1,X2) ((X1) != (X2))

#define ADT_LT_BIS_REAL(X1,X2) ((X1) < (X2))

#define ADT_LE_BIS_REAL(X1,X2) ((X1) <= (X2))

#define ADT_GT_BIS_REAL(X1,X2) ((X1) > (X2))

#define ADT_GE_BIS_REAL(X1,X2) ((X1) >= (X2))

/*---------------------------------------------------------------------------*/

#ifdef MCL_DATA_EXTENSION

#define ADT_PLUS_REAL(X1,X2) ((X1) + (X2))

#define ADT_MINUS_REAL(X1,X2) ((X1) - (X2))

#define ADT_UMINUS_REAL(X) (- (X))

#define ADT_DIV_REAL(X1,X2) ((X1) / (X2))

#define ADT_MOD_REAL(X1,X2) ((X1) % (X2))

#define ADT_MULT_REAL(X1,X2) ((X1) * (X2))

#include <math.h>
#define ADT_POWER_REAL(X1,X2) \
	(sizeof (ADT_REAL) == sizeof (float) \
	? powf ((X1), (X2)) \
	: pow ((X1), (X2)) \
	)

#endif

/*---------------------------------------------------------------------------*/

#endif

