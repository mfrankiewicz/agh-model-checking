/******************************************************************************
 *   			O P E N / C A E S A R
 *-----------------------------------------------------------------------------
 *   INRIA
 *   Unite de Recherche Rhone-Alpes
 *   655, avenue de l'Europe
 *   38330 Montbonnot Saint Martin
 *   FRANCE
 *-----------------------------------------------------------------------------
 *   Module		:	caesar_regexp.h
 *   Auteurs		:	X. ETCHEVERS, H. GARAVEL et Ch. DISCOURS
 *   Version		:	1.9
 *   Date		: 	2016/01/15 15:38:20
 *****************************************************************************/

#ifndef CAESAR_REGEXP_INTERFACE

#define CAESAR_REGEXP_INTERFACE

#ifdef __cplusplus
extern "C" {
#endif

#ifdef CAESAR_UNDEFINED
}
#endif

/*****************************************************************************/

#include "caesar_standard.h"

/*---------------------------------------------------------------------------*/

#define CAESAR_GATE_FINAL_DELIMITER_REGEXP "!?( \t"

/*---------------------------------------------------------------------------*/

typedef char *CAESAR_TYPE_REGEXP;

/*
 * le type CAESAR_TYPE_REGEXP designe la forme compilee d'une expression
 * reguliere
 */

/*---------------------------------------------------------------------------*/

extern CAESAR_TYPE_REGEXP CAESAR_COMPILE_REGEXP CAESAR_ARG_2 (CAESAR_TYPE_STRING, CAESAR_TYPE_STRING *);

/*---------------------------------------------------------------------------*/

extern CAESAR_TYPE_BOOLEAN CAESAR_TEST_REGEXP CAESAR_ARG_3 (CAESAR_TYPE_STRING, CAESAR_TYPE_REGEXP, CAESAR_TYPE_NATURAL);

/*---------------------------------------------------------------------------*/

extern CAESAR_TYPE_STRING CAESAR_COMPILE_SUBSTITUTION_REGEXP CAESAR_ARG_2 (CAESAR_TYPE_STRING, CAESAR_TYPE_STRING *);

/*---------------------------------------------------------------------------*/

extern CAESAR_TYPE_STRING CAESAR_SUBSTITUTE_REGEXP CAESAR_ARG_4 (CAESAR_TYPE_STRING, CAESAR_TYPE_REGEXP, CAESAR_TYPE_STRING, CAESAR_TYPE_NATURAL);

/*---------------------------------------------------------------------------*/

extern void CAESAR_TRIM_SPACES_REGEXP CAESAR_ARG_1 (CAESAR_TYPE_STRING *);

/*---------------------------------------------------------------------------*/

extern void CAESAR_TRIM_QUOTES_REGEXP CAESAR_ARG_1 (CAESAR_TYPE_STRING *);

/*****************************************************************************/

#ifdef CAESAR_UNDEFINED
{
#endif

#ifdef __cplusplus
}
#endif

#endif
