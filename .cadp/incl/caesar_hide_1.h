/******************************************************************************
 *                           O P E N / C A E S A R
 *-----------------------------------------------------------------------------
 *   INRIA - Unite de Recherche Rhone-Alpes
 *   655, avenue de l'Europe
 *   38330 Montbonnot Saint Martin
 *   FRANCE
 *-----------------------------------------------------------------------------
 *   Module             :       caesar_hide_1.h
 *   Auteur             :       Hubert GARAVEL
 *   Version            :       1.10
 *   Date               :       2017/09/04 15:32:41
 *****************************************************************************/

#ifndef CAESAR_HIDE_1_INTERFACE

#define CAESAR_HIDE_1_INTERFACE

#ifdef __cplusplus
extern "C" {
#endif

#ifdef CAESAR_UNDEFINED
}
#endif

/*****************************************************************************/

#include "caesar_standard.h"

/*---------------------------------------------------------------------------*/

typedef CAESAR_TYPE_ABSTRACT (CAESAR_STRUCT_HIDE_1) CAESAR_TYPE_HIDE_1;

/*---------------------------------------------------------------------------*/

extern void CAESAR_CREATE_HIDE_1 CAESAR_ARG_5 (CAESAR_TYPE_HIDE_1 *, CAESAR_TYPE_STRING, CAESAR_TYPE_STRING, CAESAR_TYPE_STRING, CAESAR_TYPE_NATURAL);

/*---------------------------------------------------------------------------*/

#define CAESAR_POSITIVE_HEADER_HIDE_1 "hide"

#define CAESAR_NEGATIVE_HEADER_HIDE_1 "hide[ \t][ \t]*all[ \t][ \t]*but"

/*---------------------------------------------------------------------------*/

extern void CAESAR_DELETE_HIDE_1 CAESAR_ARG_1 (CAESAR_TYPE_HIDE_1 *);

/*---------------------------------------------------------------------------*/

extern CAESAR_TYPE_BOOLEAN CAESAR_TEST_HIDE_1 CAESAR_ARG_2 (CAESAR_TYPE_HIDE_1, CAESAR_TYPE_STRING);

/*---------------------------------------------------------------------------*/

extern CAESAR_TYPE_FORMAT CAESAR_FORMAT_HIDE_1 CAESAR_ARG_2 (CAESAR_TYPE_HIDE_1, CAESAR_PROMOTE_TO_INT (CAESAR_TYPE_FORMAT));

/*---------------------------------------------------------------------------*/

/* deprecated primitive, kept as a macro for backward compatibility */
#define CAESAR_MAX_FORMAT_HIDE_1() (CAESAR_FORMAT_HIDE_1 (NULL, CAESAR_MAXIMAL_FORMAT))

/*---------------------------------------------------------------------------*/

extern void CAESAR_PRINT_HIDE_1 CAESAR_ARG_2 (CAESAR_TYPE_FILE, CAESAR_TYPE_HIDE_1);

/*****************************************************************************/

#ifdef CAESAR_UNDEFINED
{
#endif

#ifdef __cplusplus
}
#endif

#endif
