/******************************************************************************
 *                           O P E N / C A E S A R
 *-----------------------------------------------------------------------------
 *   INRIA - Unite de Recherche Rhone-Alpes
 *   655, avenue de l'Europe
 *   38330 Montbonnot Saint Martin
 *   FRANCE
 *-----------------------------------------------------------------------------
 *   Module             :       caesar_bitmap.h
 *   Auteur             :       Hubert GARAVEL
 *   Version            :       1.17
 *   Date               :       2017/09/04 15:32:41
 *****************************************************************************/

#ifndef CAESAR_BITMAP_INTERFACE

#define CAESAR_BITMAP_INTERFACE

#ifdef __cplusplus
extern "C" {
#endif

#ifdef CAESAR_UNDEFINED
}
#endif

/*****************************************************************************/

#include "caesar_standard.h"

/*---------------------------------------------------------------------------*/

typedef CAESAR_TYPE_ABSTRACT_POINTER (CAESAR_STRUCT_BITMAP) CAESAR_TYPE_BITMAP;

/*---------------------------------------------------------------------------*/

extern void CAESAR_CREATE_BITMAP CAESAR_ARG_3 (CAESAR_TYPE_BITMAP *, CAESAR_TYPE_NATURAL, CAESAR_PROMOTE_TO_INT (CAESAR_TYPE_BOOLEAN));

/*---------------------------------------------------------------------------*/

extern void CAESAR_DELETE_BITMAP CAESAR_ARG_1 (CAESAR_TYPE_BITMAP *);

/*---------------------------------------------------------------------------*/

extern void CAESAR_PURGE_BITMAP CAESAR_ARG_1 (CAESAR_TYPE_BITMAP);

/*---------------------------------------------------------------------------*/

extern CAESAR_TYPE_NATURAL CAESAR_SIZE_BITMAP CAESAR_ARG_1 (CAESAR_TYPE_BITMAP);

/*---------------------------------------------------------------------------*/

extern void CAESAR_SET_BITMAP CAESAR_ARG_2 (CAESAR_TYPE_BITMAP, CAESAR_TYPE_NATURAL);

/*---------------------------------------------------------------------------*/

extern void CAESAR_RESET_BITMAP CAESAR_ARG_2 (CAESAR_TYPE_BITMAP, CAESAR_TYPE_NATURAL);

/*---------------------------------------------------------------------------*/

extern CAESAR_TYPE_BOOLEAN CAESAR_TEST_BITMAP CAESAR_ARG_2 (CAESAR_TYPE_BITMAP, CAESAR_TYPE_NATURAL);

/*---------------------------------------------------------------------------*/

extern CAESAR_TYPE_BOOLEAN CAESAR_TEST_AND_SET_BITMAP CAESAR_ARG_2 (CAESAR_TYPE_BITMAP, CAESAR_TYPE_NATURAL);

/*---------------------------------------------------------------------------*/

extern CAESAR_TYPE_BOOLEAN CAESAR_TEST_AND_RESET_BITMAP CAESAR_ARG_2 (CAESAR_TYPE_BITMAP, CAESAR_TYPE_NATURAL);

/*---------------------------------------------------------------------------*/

extern CAESAR_TYPE_NATURAL CAESAR_ZERO_BITMAP CAESAR_ARG_1 (CAESAR_TYPE_BITMAP);

/*---------------------------------------------------------------------------*/

extern CAESAR_TYPE_NATURAL CAESAR_ONE_BITMAP CAESAR_ARG_1 (CAESAR_TYPE_BITMAP);

/*---------------------------------------------------------------------------*/

extern CAESAR_TYPE_NATURAL CAESAR_FAILURE_BITMAP CAESAR_ARG_1 (CAESAR_TYPE_BITMAP);

/*---------------------------------------------------------------------------*/

extern CAESAR_TYPE_NATURAL CAESAR_SUCCESS_BITMAP CAESAR_ARG_1 (CAESAR_TYPE_BITMAP);

/*---------------------------------------------------------------------------*/

extern CAESAR_TYPE_FORMAT CAESAR_FORMAT_BITMAP CAESAR_ARG_2 (CAESAR_TYPE_BITMAP, CAESAR_PROMOTE_TO_INT (CAESAR_TYPE_FORMAT));

/*---------------------------------------------------------------------------*/

/* deprecated primitive, kept as a macro for backward compatibility */
#define CAESAR_MAX_FORMAT_BITMAP() (CAESAR_FORMAT_BITMAP (NULL, CAESAR_MAXIMAL_FORMAT))

/*---------------------------------------------------------------------------*/

extern void CAESAR_PRINT_BITMAP CAESAR_ARG_2 (CAESAR_TYPE_FILE, CAESAR_TYPE_BITMAP);

/*****************************************************************************/

#ifdef CAESAR_UNDEFINED
{
#endif

#ifdef __cplusplus
}
#endif

#endif
