/******************************************************************************
 *   			            C A D P
 *-----------------------------------------------------------------------------
 *   INRIA - Centre de Recherche de Grenoble Rhone-Alpes
 *   655, avenue de l'Europe
 *   38330 Montbonnot Saint Martin
 *   FRANCE
 *-----------------------------------------------------------------------------
 *   Module		:	X_ACTION.h
 *   Auteur		:	Hubert GARAVEL
 *   Version		:	1.2
 *   Date		: 	2018/01/14 10:12:58
 *****************************************************************************/

#ifndef ADT_X_ACTION

#define ADT_X_ACTION

/*---------------------------------------------------------------------------*/

typedef unsigned char ADT_ACTION;

#ifndef lint
#define CAESAR_ADT_BITS_ADT_ACTION : 1
#endif

#define ADT_CMP_ACTION(A1,A2) ((A1) == (A2))

#define ADT_PRINT_ACTION(F,A)  fprintf((F), "<action>")

/*---------------------------------------------------------------------------*/

#define ADT_NOP() ((ADT_ACTION) '\0')

#define ADT_FBY(A1,A2) ((void) (A1), (A2))

#define ADT_IF_THEN(B,A) ((ADT_ACTION) ((B) ? (A) : ADT_NOP()))

#define ADT_IF_THEN_ELSE(B,A1,A2) ((ADT_ACTION) ((B) ? (A1) : (A2)))

/*---------------------------------------------------------------------------*/

#endif
