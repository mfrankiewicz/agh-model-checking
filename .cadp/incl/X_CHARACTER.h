/******************************************************************************
 *   			            C A D P
 *-----------------------------------------------------------------------------
 *   INRIA - Centre de Recherche de Grenoble Rhone-Alpes
 *   655, avenue de l'Europe
 *   38330 Montbonnot Saint Martin
 *   FRANCE
 *-----------------------------------------------------------------------------
 *   Module		:	X_CHARACTER.h
 *   Auteur		:	Hubert GARAVEL
 *   Version		:	1.5
 *   Date		: 	2018/01/03 11:04:38
 *****************************************************************************/

#ifndef ADT_X_CHARACTER

#define ADT_X_CHARACTER

/*---------------------------------------------------------------------------*/

#include "adt_character.h"

/*---------------------------------------------------------------------------*/

#define ADT_EQ_CHAR(X1,X2) ((X1) == (X2))

#define ADT_NE_CHAR(X1,X2) ((X1) != (X2))

#define ADT_LT_CHAR(X1,X2) ((X1) < (X2))

#define ADT_LE_CHAR(X1,X2) ((X1) <= (X2))

#define ADT_GT_CHAR(X1,X2) ((X1) > (X2))

#define ADT_GE_CHAR(X1,X2) ((X1) >= (X2))

/*---------------------------------------------------------------------------*/

#ifdef MCL_DATA_EXTENSION

#include <ctype.h>

#define ADT_ISLOWER_CHAR(X) (islower ((int) (X)) ? ADT_TRUE () : ADT_FALSE ())

#define ADT_ISUPPER_CHAR(X) (isupper ((int) (X)) ? ADT_TRUE () : ADT_FALSE ())

#define ADT_ISALPHA_CHAR(X) (isalpha ((int) (X)) ? ADT_TRUE () : ADT_FALSE ())

#define ADT_ISALNUM_CHAR(X) (isalnum ((int) (X)) ? ADT_TRUE () : ADT_FALSE ())

#define ADT_ISDIGIT_CHAR(X) (isdigit ((int) (X)) ? ADT_TRUE () : ADT_FALSE ())

#define ADT_ISXDIGIT_CHAR(X) (isxdigit ((int) (X)) ? ADT_TRUE () : ADT_FALSE ())

#define ADT_TOLOWER_CHAR(X) ((ADT_CHAR) tolower ((int) (X)))

#define ADT_TOUPPER_CHAR(X) ((ADT_CHAR) toupper ((int) (X)))

#endif

/* ------------------------------------------------------------------------- */

#endif

