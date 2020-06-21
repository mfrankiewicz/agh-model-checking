/******************************************************************************
 *                           O P E N / C A E S A R
 *-----------------------------------------------------------------------------
 *   INRIA - Unite de Recherche Rhone-Alpes
 *   655, avenue de l'Europe
 *   38330 Montbonnot Saint Martin
 *   FRANCE
 *-----------------------------------------------------------------------------
 *   Module             :       caesar_mask_1.h
 *   Auteurs            :       Nicolas DESCOUBES et Hubert GARAVEL
 *   Version            :       1.14
 *   Date               :       2017/09/04 15:32:41
 *****************************************************************************/

#ifndef CAESAR_MASK_1_INTERFACE

#define CAESAR_MASK_1_INTERFACE

#ifdef __cplusplus
extern "C" {
#endif

#ifdef CAESAR_UNDEFINED
}
#endif

/*****************************************************************************/

#include "caesar_standard.h"
#include "caesar_area_1.h"

/*---------------------------------------------------------------------------*/

typedef CAESAR_TYPE_ABSTRACT (CAESAR_STRUCT_MASK_1) CAESAR_TYPE_MASK_1;

/*---------------------------------------------------------------------------*/

extern void CAESAR_CREATE_MASK_1 CAESAR_ARG_9
     (CAESAR_TYPE_MASK_1 *,
           CAESAR_TYPE_AREA_1,
           CAESAR_PROMOTE_TO_INT (CAESAR_TYPE_BOOLEAN),
           CAESAR_TYPE_NATURAL,
           CAESAR_PROMOTE_TO_INT (CAESAR_TYPE_BOOLEAN),
           CAESAR_TYPE_COMPARE_FUNCTION,
           CAESAR_TYPE_HASH_FUNCTION,
           CAESAR_TYPE_CONVERT_FUNCTION,
           CAESAR_PROMOTE_TO_INT (CAESAR_TYPE_BOOLEAN));

/*---------------------------------------------------------------------------*/

extern void CAESAR_DELETE_MASK_1 CAESAR_ARG_1 (CAESAR_TYPE_MASK_1 *);

/*---------------------------------------------------------------------------*/

extern void CAESAR_USE_HIDE_MASK_1 CAESAR_ARG_4
     (CAESAR_TYPE_MASK_1,
           CAESAR_TYPE_STRING,
           CAESAR_TYPE_NATURAL,
           CAESAR_TYPE_BOOLEAN *);

/*---------------------------------------------------------------------------*/

extern void CAESAR_USE_RENAME_MASK_1 CAESAR_ARG_4
     (CAESAR_TYPE_MASK_1,
           CAESAR_TYPE_STRING,
           CAESAR_TYPE_NATURAL,
           CAESAR_TYPE_BOOLEAN *);

/*---------------------------------------------------------------------------*/

extern void CAESAR_PARSE_OPTION_MASK_1 CAESAR_ARG_4
     (CAESAR_TYPE_MASK_1,
           CAESAR_TYPE_GENUINE_INT,
           CAESAR_TYPE_STRING *,
           CAESAR_TYPE_GENUINE_INT *);

/*---------------------------------------------------------------------------*/

extern CAESAR_TYPE_STRING CAESAR_APPLY_MASK_1 CAESAR_ARG_2 (CAESAR_TYPE_MASK_1, CAESAR_TYPE_POINTER);

/*---------------------------------------------------------------------------*/

#define CAESAR_LABEL_HIDE_FORMAT_MASK_1 "   with labels hidden using \"%s\""

#define CAESAR_LABEL_RENAME_FORMAT_MASK_1 "   with labels renamed using \"%s\""

extern CAESAR_TYPE_STRING CAESAR_HISTORY_MASK_1 CAESAR_ARG_6
     (CAESAR_TYPE_MASK_1,
           CAESAR_TYPE_STRING,
           CAESAR_TYPE_STRING,
           CAESAR_TYPE_STRING,
           CAESAR_TYPE_STRING,
           CAESAR_TYPE_STRING);

/*---------------------------------------------------------------------------*/

extern CAESAR_TYPE_NATURAL CAESAR_FAILURE_MASK_1 CAESAR_ARG_1 (CAESAR_TYPE_MASK_1);

/*---------------------------------------------------------------------------*/

extern CAESAR_TYPE_NATURAL CAESAR_SUCCESS_MASK_1 CAESAR_ARG_1 (CAESAR_TYPE_MASK_1);

/*---------------------------------------------------------------------------*/

extern CAESAR_TYPE_FORMAT CAESAR_FORMAT_MASK_1 CAESAR_ARG_2 (CAESAR_TYPE_MASK_1, CAESAR_PROMOTE_TO_INT (CAESAR_TYPE_FORMAT));

/*---------------------------------------------------------------------------*/

/* deprecated primitive, kept as a macro for backward compatibility */
#define CAESAR_MAX_FORMAT_MASK_1() (CAESAR_FORMAT_MASK_1 (NULL, CAESAR_MAXIMAL_FORMAT))

/*---------------------------------------------------------------------------*/

extern void CAESAR_PRINT_MASK_1 CAESAR_ARG_2 (CAESAR_TYPE_FILE, CAESAR_TYPE_MASK_1);

/*****************************************************************************/

#ifdef CAESAR_UNDEFINED
{
#endif

#ifdef __cplusplus
}
#endif

#endif
