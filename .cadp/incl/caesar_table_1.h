/******************************************************************************
 *                           O P E N / C A E S A R
 *-----------------------------------------------------------------------------
 *   INRIA - Unite de Recherche Rhone-Alpes
 *   655, avenue de l'Europe
 *   38330 Montbonnot Saint Martin
 *   FRANCE
 *-----------------------------------------------------------------------------
 *   Module             :       caesar_table_1.h
 *   Auteur             :       Hubert GARAVEL
 *   Version            :       1.24
 *   Date               :       2017/09/04 15:32:41
 *****************************************************************************/

#ifndef CAESAR_TABLE_1_INTERFACE

#define CAESAR_TABLE_1_INTERFACE

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

typedef CAESAR_TYPE_ABSTRACT (CAESAR_STRUCT_TABLE_1) CAESAR_TYPE_TABLE_1;

typedef CAESAR_TYPE_NATURAL CAESAR_TYPE_INDEX_TABLE_1;

#define CAESAR_NULL_INDEX_TABLE_1 ((CAESAR_TYPE_INDEX_TABLE_1) -1L)

extern CAESAR_TYPE_INDEX_TABLE_1 CAESAR_MAX_INDEX_TABLE_1 CAESAR_ARG_0 ();

/*---------------------------------------------------------------------------*/

typedef void (*CAESAR_TYPE_OVERFLOW_FUNCTION_TABLE_1) CAESAR_ARG_1 (CAESAR_TYPE_TABLE_1);

extern void CAESAR_OVERFLOW_SIGNAL_TABLE_1 CAESAR_ARG_1 (CAESAR_TYPE_TABLE_1);

extern void CAESAR_OVERFLOW_ABORT_TABLE_1 CAESAR_ARG_1 (CAESAR_TYPE_TABLE_1);

extern void CAESAR_OVERFLOW_IGNORE_TABLE_1 CAESAR_ARG_1 (CAESAR_TYPE_TABLE_1);

/*---------------------------------------------------------------------------*/

extern void CAESAR_CREATE_TABLE_1 CAESAR_ARG_10
     (CAESAR_TYPE_TABLE_1 *,
           CAESAR_TYPE_AREA_1,
           CAESAR_TYPE_AREA_1,
           CAESAR_TYPE_NATURAL,
           CAESAR_TYPE_NATURAL,
           CAESAR_PROMOTE_TO_INT (CAESAR_TYPE_BOOLEAN),
           CAESAR_TYPE_COMPARE_FUNCTION,
           CAESAR_TYPE_HASH_FUNCTION,
           CAESAR_TYPE_PRINT_FUNCTION,
           CAESAR_TYPE_OVERFLOW_FUNCTION_TABLE_1
);

/*---------------------------------------------------------------------------*/

extern void CAESAR_DELETE_TABLE_1 CAESAR_ARG_1 (CAESAR_TYPE_TABLE_1 *);

/*---------------------------------------------------------------------------*/

extern void CAESAR_TUNE_TABLE_1 CAESAR_ARG_2 (CAESAR_TYPE_TABLE_1, unsigned int);

/*---------------------------------------------------------------------------*/

extern void CAESAR_PURGE_TABLE_1 CAESAR_ARG_1 (CAESAR_TYPE_TABLE_1);

/*---------------------------------------------------------------------------*/

extern CAESAR_TYPE_INDEX_TABLE_1 CAESAR_PUT_INDEX_TABLE_1 CAESAR_ARG_1 (CAESAR_TYPE_TABLE_1);

/*---------------------------------------------------------------------------*/

extern CAESAR_TYPE_POINTER CAESAR_PUT_BASE_TABLE_1 CAESAR_ARG_1 (CAESAR_TYPE_TABLE_1);

/*---------------------------------------------------------------------------*/

extern CAESAR_TYPE_POINTER CAESAR_PUT_MARK_TABLE_1 CAESAR_ARG_1 (CAESAR_TYPE_TABLE_1);

/*---------------------------------------------------------------------------*/

extern void CAESAR_PUT_TABLE_1 CAESAR_ARG_1 (CAESAR_TYPE_TABLE_1);

/*---------------------------------------------------------------------------*/

extern CAESAR_TYPE_BOOLEAN CAESAR_SEARCH_TABLE_1 CAESAR_ARG_4 (CAESAR_TYPE_TABLE_1, CAESAR_TYPE_POINTER, CAESAR_TYPE_INDEX_TABLE_1 *, CAESAR_TYPE_POINTER *);

/*---------------------------------------------------------------------------*/

extern CAESAR_TYPE_BOOLEAN CAESAR_SEARCH_AND_PUT_TABLE_1 CAESAR_ARG_3 (CAESAR_TYPE_TABLE_1, CAESAR_TYPE_INDEX_TABLE_1 *, CAESAR_TYPE_POINTER *);

/*---------------------------------------------------------------------------*/

extern CAESAR_TYPE_INDEX_TABLE_1 CAESAR_GET_INDEX_TABLE_1 CAESAR_ARG_1 (CAESAR_TYPE_TABLE_1);

/*---------------------------------------------------------------------------*/

extern CAESAR_TYPE_POINTER CAESAR_GET_BASE_TABLE_1 CAESAR_ARG_1 (CAESAR_TYPE_TABLE_1);

/*---------------------------------------------------------------------------*/

extern CAESAR_TYPE_POINTER CAESAR_GET_MARK_TABLE_1 CAESAR_ARG_1 (CAESAR_TYPE_TABLE_1);

/*---------------------------------------------------------------------------*/

extern void CAESAR_GET_TABLE_1 CAESAR_ARG_1 (CAESAR_TYPE_TABLE_1);

/*---------------------------------------------------------------------------*/

extern CAESAR_TYPE_BOOLEAN CAESAR_EMPTY_TABLE_1 CAESAR_ARG_1 (CAESAR_TYPE_TABLE_1);

/*---------------------------------------------------------------------------*/

extern CAESAR_TYPE_BOOLEAN CAESAR_FULL_TABLE_1 CAESAR_ARG_1 (CAESAR_TYPE_TABLE_1);

/*---------------------------------------------------------------------------*/

extern CAESAR_TYPE_BOOLEAN CAESAR_EXPLORED_TABLE_1 CAESAR_ARG_1 (CAESAR_TYPE_TABLE_1);

/*---------------------------------------------------------------------------*/

extern void CAESAR_RETRIEVE_I_B_TABLE_1 CAESAR_ARG_3 (CAESAR_TYPE_TABLE_1, CAESAR_TYPE_INDEX_TABLE_1, CAESAR_TYPE_POINTER *);

extern void CAESAR_RETRIEVE_I_M_TABLE_1 CAESAR_ARG_3 (CAESAR_TYPE_TABLE_1, CAESAR_TYPE_INDEX_TABLE_1, CAESAR_TYPE_POINTER *);

extern void CAESAR_RETRIEVE_I_BM_TABLE_1 CAESAR_ARG_4 (CAESAR_TYPE_TABLE_1, CAESAR_TYPE_INDEX_TABLE_1, CAESAR_TYPE_POINTER *, CAESAR_TYPE_POINTER *);

/*---------------------------------------------------------------------------*/

extern void CAESAR_RETRIEVE_B_I_TABLE_1 CAESAR_ARG_3 (CAESAR_TYPE_TABLE_1, CAESAR_TYPE_POINTER, CAESAR_TYPE_INDEX_TABLE_1 *);

extern void CAESAR_RETRIEVE_M_I_TABLE_1 CAESAR_ARG_3 (CAESAR_TYPE_TABLE_1, CAESAR_TYPE_POINTER, CAESAR_TYPE_INDEX_TABLE_1 *);

/*---------------------------------------------------------------------------*/

extern void CAESAR_RETRIEVE_B_M_TABLE_1 CAESAR_ARG_3 (CAESAR_TYPE_TABLE_1, CAESAR_TYPE_POINTER, CAESAR_TYPE_POINTER *);

extern void CAESAR_RETRIEVE_M_B_TABLE_1 CAESAR_ARG_3 (CAESAR_TYPE_TABLE_1, CAESAR_TYPE_POINTER, CAESAR_TYPE_POINTER *);

/*---------------------------------------------------------------------------*/

extern CAESAR_TYPE_NATURAL CAESAR_FAILURE_TABLE_1 CAESAR_ARG_1 (CAESAR_TYPE_TABLE_1);

/*---------------------------------------------------------------------------*/

extern CAESAR_TYPE_NATURAL CAESAR_SUCCESS_TABLE_1 CAESAR_ARG_1 (CAESAR_TYPE_TABLE_1);

/*---------------------------------------------------------------------------*/

extern CAESAR_TYPE_FORMAT CAESAR_FORMAT_TABLE_1 CAESAR_ARG_2 (CAESAR_TYPE_TABLE_1, CAESAR_PROMOTE_TO_INT (CAESAR_TYPE_FORMAT));

/*---------------------------------------------------------------------------*/

/* deprecated primitive, kept as a macro for backward compatibility */
#define CAESAR_MAX_FORMAT_TABLE_1() (CAESAR_FORMAT_TABLE_1 (NULL, CAESAR_MAXIMAL_FORMAT))

/*---------------------------------------------------------------------------*/

extern void CAESAR_PRINT_TABLE_1 CAESAR_ARG_2 (CAESAR_TYPE_FILE, CAESAR_TYPE_TABLE_1);

/*****************************************************************************/

#ifdef CAESAR_UNDEFINED
{
#endif

#ifdef __cplusplus
}
#endif

#endif
