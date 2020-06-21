/******************************************************************************
 *                           O P E N / C A E S A R
 *-----------------------------------------------------------------------------
 *   INRIA - Unite de Recherche Rhone-Alpes
 *   655, avenue de l'Europe
 *   38330 Montbonnot Saint Martin
 *   FRANCE
 *-----------------------------------------------------------------------------
 *   Module             :       caesar_rename_1.h
 *   Auteurs            :       Hubert GARAVEL et Christophe DISCOURS
 *   Version            :       1.8
 *   Date               :       2017/09/04 15:32:41
 *****************************************************************************/

#ifndef CAESAR_RENAME_1_INTERFACE

#define CAESAR_RENAME_1_INTERFACE

#ifdef __cplusplus
extern "C" {
#endif

#ifdef CAESAR_UNDEFINED
}
#endif

/*****************************************************************************/

#include "caesar_standard.h"

/*---------------------------------------------------------------------------*/

typedef CAESAR_TYPE_ABSTRACT (CAESAR_STRUCT_RENAME_1) CAESAR_TYPE_RENAME_1;

/*---------------------------------------------------------------------------*/

extern void CAESAR_CREATE_RENAME_1 CAESAR_ARG_4 (CAESAR_TYPE_RENAME_1 *, CAESAR_TYPE_STRING, CAESAR_TYPE_STRING, CAESAR_TYPE_NATURAL);

/*---------------------------------------------------------------------------*/

#define CAESAR_HEADER_RENAME_1 "rename"

/*---------------------------------------------------------------------------*/

extern void CAESAR_DELETE_RENAME_1 CAESAR_ARG_1 (CAESAR_TYPE_RENAME_1 *);

/*---------------------------------------------------------------------------*/

extern CAESAR_TYPE_STRING CAESAR_APPLY_RENAME_1 CAESAR_ARG_2 (CAESAR_TYPE_RENAME_1, CAESAR_TYPE_STRING);

/*---------------------------------------------------------------------------*/

extern CAESAR_TYPE_FORMAT CAESAR_FORMAT_RENAME_1 CAESAR_ARG_2 (CAESAR_TYPE_RENAME_1, CAESAR_PROMOTE_TO_INT (CAESAR_TYPE_FORMAT));

/*---------------------------------------------------------------------------*/

/* deprecated primitive, kept as a macro for backward compatibility */
#define CAESAR_MAX_FORMAT_RENAME_1() (CAESAR_FORMAT_RENAME_1 (NULL, CAESAR_MAXIMAL_FORMAT))

/*---------------------------------------------------------------------------*/

extern void CAESAR_PRINT_RENAME_1 CAESAR_ARG_2 (CAESAR_TYPE_FILE, CAESAR_TYPE_RENAME_1);

/*****************************************************************************/

#ifdef CAESAR_UNDEFINED
{
#endif

#ifdef __cplusplus
}
#endif

#endif
