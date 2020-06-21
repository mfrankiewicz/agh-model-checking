/******************************************************************************
 *                           O P E N / C A E S A R
 *-----------------------------------------------------------------------------
 *   INRIA - Unite de Recherche Rhone-Alpes
 *   655, avenue de l'Europe
 *   38330 Montbonnot Saint Martin
 *   FRANCE
 *-----------------------------------------------------------------------------
 *   Module             :       caesar_version.h
 *   Auteur             :       Hubert GARAVEL
 *   Version            :       2.4
 *   Date               :       2013/06/24 17:22:02
 *****************************************************************************/

#ifndef CAESAR_VERSION_INTERFACE

#define CAESAR_VERSION_INTERFACE

#ifdef __cplusplus
extern "C" {
#endif

#ifdef CAESAR_UNDEFINED
}
#endif

/*****************************************************************************/

#include "caesar_standard.h"

/*---------------------------------------------------------------------------*/

typedef double CAESAR_TYPE_VERSION;

/*---------------------------------------------------------------------------*/

extern CAESAR_TYPE_VERSION CAESAR_LIBRARY_VERSION CAESAR_ARG_0 ();

extern CAESAR_TYPE_BOOLEAN CAESAR_COMPARE_VERSION CAESAR_ARG_2 (CAESAR_TYPE_VERSION, CAESAR_TYPE_VERSION);

extern CAESAR_TYPE_BOOLEAN CAESAR_MATCH_VERSION CAESAR_ARG_2 (CAESAR_TYPE_VERSION, CAESAR_TYPE_VERSION);

extern void CAESAR_CHECK_VERSION CAESAR_ARG_2 (CAESAR_TYPE_VERSION, CAESAR_TYPE_VERSION);

extern void CAESAR_PRINT_VERSION CAESAR_ARG_2 (CAESAR_TYPE_FILE, CAESAR_TYPE_VERSION);

/*****************************************************************************/

#ifdef CAESAR_UNDEFINED
{
#endif

#ifdef __cplusplus
}
#endif

#endif
