/******************************************************************************
 *                           O P E N / C A E S A R
 *-----------------------------------------------------------------------------
 *   INRIA - Unite de Recherche Rhone-Alpes
 *   655, avenue de l'Europe
 *   38330 Montbonnot Saint Martin
 *   FRANCE
 *-----------------------------------------------------------------------------
 *   Module             :       caesar_diagnostic_1.h
 *   Auteur             :       Hubert GARAVEL
 *   Version            :       1.11
 *   Date               :       2004/12/03 11:47:40
 *****************************************************************************/

#ifndef CAESAR_DIAGNOSTIC_1_INTERFACE

#define CAESAR_DIAGNOSTIC_1_INTERFACE

#ifdef __cplusplus
extern "C" {
#endif

#ifdef CAESAR_UNDEFINED
}
#endif

/*****************************************************************************/

#include "caesar_stack_1.h"

/*---------------------------------------------------------------------------*/

typedef CAESAR_TYPE_ABSTRACT (CAESAR_STRUCT_DIAGNOSTIC_1) CAESAR_TYPE_DIAGNOSTIC_1;

/*---------------------------------------------------------------------------*/

typedef enum {
     CAESAR_NONE_DIAGNOSTIC_1,
     CAESAR_ALL_DIAGNOSTIC_1,
     CAESAR_FIRST_DIAGNOSTIC_1,
     CAESAR_DECREASING_DIAGNOSTIC_1,
     CAESAR_SHORTEST_DIAGNOSTIC_1
}    CAESAR_TYPE_STRATEGY_DIAGNOSTIC_1;

/*---------------------------------------------------------------------------*/

extern void CAESAR_CREATE_DIAGNOSTIC_1 CAESAR_ARG_9 (CAESAR_TYPE_DIAGNOSTIC_1 *, CAESAR_TYPE_STRATEGY_DIAGNOSTIC_1, CAESAR_TYPE_NATURAL, CAESAR_TYPE_FILE, CAESAR_TYPE_STRING, CAESAR_TYPE_STRING, CAESAR_TYPE_STRING, CAESAR_TYPE_STRING, CAESAR_TYPE_STRING);

/*---------------------------------------------------------------------------*/

extern void CAESAR_DELETE_DIAGNOSTIC_1 CAESAR_ARG_1 (CAESAR_TYPE_DIAGNOSTIC_1 *);

/*---------------------------------------------------------------------------*/

extern void CAESAR_RECORD_DIAGNOSTIC_1 CAESAR_ARG_2 (CAESAR_TYPE_DIAGNOSTIC_1, CAESAR_TYPE_STACK_1);

/*---------------------------------------------------------------------------*/

extern void CAESAR_SUMMARIZE_DIAGNOSTIC_1 CAESAR_ARG_1 (CAESAR_TYPE_DIAGNOSTIC_1);

/*---------------------------------------------------------------------------*/

extern CAESAR_TYPE_BOOLEAN CAESAR_EMPTY_DIAGNOSTIC_1 CAESAR_ARG_1 (CAESAR_TYPE_DIAGNOSTIC_1);

/*---------------------------------------------------------------------------*/

extern CAESAR_TYPE_BOOLEAN CAESAR_BACKTRACK_DIAGNOSTIC_1 CAESAR_ARG_2 (CAESAR_TYPE_DIAGNOSTIC_1, CAESAR_TYPE_NATURAL);

/*****************************************************************************/

#ifdef CAESAR_UNDEFINED
{
#endif

#ifdef __cplusplus
}
#endif

#endif
