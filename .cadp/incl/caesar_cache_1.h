/******************************************************************************
 *                           O P E N / C A E S A R
 *-----------------------------------------------------------------------------
 *   INRIA - Unite de Recherche Rhone-Alpes
 *   655, avenue de l'Europe
 *   38330 Montbonnot Saint Martin
 *   FRANCE
 *-----------------------------------------------------------------------------
 *   Module             :       caesar_cache_1.h
 *   Auteur             :       Radu MATEESCU
 *   Version            :       1.30
 *   Date               :       2017/09/04 15:28:05
 *****************************************************************************/

#ifndef CAESAR_CACHE_1_INTERFACE

#define CAESAR_CACHE_1_INTERFACE

#ifdef __cplusplus
extern "C" {
#endif

#ifdef CAESAR_UNDEFINED
}
#endif

/*****************************************************************************/

#include "caesar_area_1.h"

/*---------------------------------------------------------------------------*/

typedef CAESAR_TYPE_ABSTRACT (CAESAR_STRUCT_CACHE_1) CAESAR_TYPE_CACHE_1;

/*---------------------------------------------------------------------------*/

typedef CAESAR_TYPE_NATURAL (*CAESAR_TYPE_NATURAL_FUNCTION_CACHE_1) CAESAR_ARG_1 (CAESAR_TYPE_NATURAL);

/*---------------------------------------------------------------------------*/

typedef CAESAR_TYPE_INTEGER (*CAESAR_TYPE_ORDER_FUNCTION_CACHE_1) CAESAR_ARG_3 (CAESAR_TYPE_CACHE_1, CAESAR_TYPE_POINTER, CAESAR_TYPE_POINTER);

/*---------------------------------------------------------------------------*/

typedef CAESAR_TYPE_NATURAL (*CAESAR_TYPE_SUBCACHE_FUNCTION_CACHE_1) CAESAR_ARG_3 (CAESAR_TYPE_CACHE_1, CAESAR_TYPE_NATURAL, CAESAR_TYPE_POINTER);

/*---------------------------------------------------------------------------*/

typedef void (*CAESAR_TYPE_CLEANUP_FUNCTION_CACHE_1) CAESAR_ARG_1 (CAESAR_TYPE_POINTER);

/*---------------------------------------------------------------------------*/

typedef enum {
     CAESAR_NONE_CACHE_1,
     CAESAR_CYCLIC_CACHE_1
}    CAESAR_TYPE_ERROR_CACHE_1;

/*---------------------------------------------------------------------------*/

extern CAESAR_TYPE_INTEGER CAESAR_LRU_ORDER_CACHE_1 CAESAR_ARG_3 (CAESAR_TYPE_CACHE_1, CAESAR_TYPE_POINTER, CAESAR_TYPE_POINTER);

/*---------------------------------------------------------------------------*/

extern CAESAR_TYPE_INTEGER CAESAR_MRU_ORDER_CACHE_1 CAESAR_ARG_3 (CAESAR_TYPE_CACHE_1, CAESAR_TYPE_POINTER, CAESAR_TYPE_POINTER);

/*---------------------------------------------------------------------------*/

extern CAESAR_TYPE_INTEGER CAESAR_LRP_ORDER_CACHE_1 CAESAR_ARG_3 (CAESAR_TYPE_CACHE_1, CAESAR_TYPE_POINTER, CAESAR_TYPE_POINTER);

/*---------------------------------------------------------------------------*/

extern CAESAR_TYPE_INTEGER CAESAR_MRP_ORDER_CACHE_1 CAESAR_ARG_3 (CAESAR_TYPE_CACHE_1, CAESAR_TYPE_POINTER, CAESAR_TYPE_POINTER);

/*---------------------------------------------------------------------------*/

extern CAESAR_TYPE_INTEGER CAESAR_LFU_ORDER_CACHE_1 CAESAR_ARG_3 (CAESAR_TYPE_CACHE_1, CAESAR_TYPE_POINTER, CAESAR_TYPE_POINTER);

/*---------------------------------------------------------------------------*/

extern CAESAR_TYPE_INTEGER CAESAR_MFU_ORDER_CACHE_1 CAESAR_ARG_3 (CAESAR_TYPE_CACHE_1, CAESAR_TYPE_POINTER, CAESAR_TYPE_POINTER);

/*---------------------------------------------------------------------------*/

extern CAESAR_TYPE_INTEGER CAESAR_RND_ORDER_CACHE_1 CAESAR_ARG_3 (CAESAR_TYPE_CACHE_1, CAESAR_TYPE_POINTER, CAESAR_TYPE_POINTER);

/*---------------------------------------------------------------------------*/

extern CAESAR_TYPE_INTEGER CAESAR_LFU_LRU_ORDER_CACHE_1 CAESAR_ARG_3 (CAESAR_TYPE_CACHE_1, CAESAR_TYPE_POINTER, CAESAR_TYPE_POINTER);

/*---------------------------------------------------------------------------*/

extern CAESAR_TYPE_INTEGER CAESAR_LFU_MRU_ORDER_CACHE_1 CAESAR_ARG_3 (CAESAR_TYPE_CACHE_1, CAESAR_TYPE_POINTER, CAESAR_TYPE_POINTER);

/*---------------------------------------------------------------------------*/

extern CAESAR_TYPE_INTEGER CAESAR_LFU_LRP_ORDER_CACHE_1 CAESAR_ARG_3 (CAESAR_TYPE_CACHE_1, CAESAR_TYPE_POINTER, CAESAR_TYPE_POINTER);

/*---------------------------------------------------------------------------*/

extern CAESAR_TYPE_INTEGER CAESAR_LFU_MRP_ORDER_CACHE_1 CAESAR_ARG_3 (CAESAR_TYPE_CACHE_1, CAESAR_TYPE_POINTER, CAESAR_TYPE_POINTER);

/*---------------------------------------------------------------------------*/

extern CAESAR_TYPE_INTEGER CAESAR_MFU_LRU_ORDER_CACHE_1 CAESAR_ARG_3 (CAESAR_TYPE_CACHE_1, CAESAR_TYPE_POINTER, CAESAR_TYPE_POINTER);

/*---------------------------------------------------------------------------*/

extern CAESAR_TYPE_INTEGER CAESAR_MFU_MRU_ORDER_CACHE_1 CAESAR_ARG_3 (CAESAR_TYPE_CACHE_1, CAESAR_TYPE_POINTER, CAESAR_TYPE_POINTER);

/*---------------------------------------------------------------------------*/

extern CAESAR_TYPE_INTEGER CAESAR_MFU_LRP_ORDER_CACHE_1 CAESAR_ARG_3 (CAESAR_TYPE_CACHE_1, CAESAR_TYPE_POINTER, CAESAR_TYPE_POINTER);

/*---------------------------------------------------------------------------*/

extern CAESAR_TYPE_INTEGER CAESAR_MFU_MRP_ORDER_CACHE_1 CAESAR_ARG_3 (CAESAR_TYPE_CACHE_1, CAESAR_TYPE_POINTER, CAESAR_TYPE_POINTER);

/*---------------------------------------------------------------------------*/

extern void CAESAR_SEED_RND_CACHE_1 CAESAR_ARG_2 (CAESAR_TYPE_CACHE_1, CAESAR_TYPE_NATURAL);

/*---------------------------------------------------------------------------*/

extern void CAESAR_CREATE_CACHE_1 CAESAR_ARG_16
     (CAESAR_TYPE_CACHE_1 *,
           CAESAR_TYPE_NATURAL,
           CAESAR_TYPE_NATURAL,
           CAESAR_TYPE_NATURAL_FUNCTION_CACHE_1,
           CAESAR_TYPE_NATURAL_FUNCTION_CACHE_1,
           CAESAR_TYPE_ORDER_FUNCTION_CACHE_1 (*) (CAESAR_TYPE_NATURAL),
           CAESAR_TYPE_SUBCACHE_FUNCTION_CACHE_1 (*) (CAESAR_TYPE_NATURAL),
           CAESAR_TYPE_AREA_1,
           CAESAR_TYPE_AREA_1,
           CAESAR_TYPE_NATURAL,
           CAESAR_PROMOTE_TO_INT (CAESAR_TYPE_BOOLEAN),
           CAESAR_TYPE_COMPARE_FUNCTION,
           CAESAR_TYPE_HASH_FUNCTION,
           CAESAR_TYPE_PRINT_FUNCTION,
           CAESAR_TYPE_CLEANUP_FUNCTION_CACHE_1,
           CAESAR_TYPE_POINTER
);

/*---------------------------------------------------------------------------*/

extern CAESAR_TYPE_CACHE_1 CAESAR_CURRENT_CACHE_1 CAESAR_ARG_0 ();

/*---------------------------------------------------------------------------*/

extern CAESAR_TYPE_NATURAL CAESAR_CURRENT_SUBCACHE_CACHE_1 CAESAR_ARG_0 ();

/*---------------------------------------------------------------------------*/

extern void CAESAR_DELETE_CACHE_1 CAESAR_ARG_1 (CAESAR_TYPE_CACHE_1 *);

/*---------------------------------------------------------------------------*/

extern void CAESAR_PURGE_SUBCACHE_CACHE_1 CAESAR_ARG_2 (CAESAR_TYPE_CACHE_1, CAESAR_TYPE_NATURAL);

/*---------------------------------------------------------------------------*/

extern void CAESAR_PURGE_CACHE_1 CAESAR_ARG_1 (CAESAR_TYPE_CACHE_1);

/*---------------------------------------------------------------------------*/

extern CAESAR_TYPE_BOOLEAN CAESAR_SEARCH_CACHE_1 CAESAR_ARG_4 (CAESAR_TYPE_CACHE_1, CAESAR_TYPE_POINTER, CAESAR_TYPE_NATURAL *, CAESAR_TYPE_POINTER *);

/*---------------------------------------------------------------------------*/

extern CAESAR_TYPE_POINTER CAESAR_PUT_BASE_CACHE_1 CAESAR_ARG_1 (CAESAR_TYPE_CACHE_1);

/*---------------------------------------------------------------------------*/

extern CAESAR_TYPE_POINTER CAESAR_PUT_MARK_CACHE_1 CAESAR_ARG_1 (CAESAR_TYPE_CACHE_1);

/*---------------------------------------------------------------------------*/

extern void CAESAR_PUT_CACHE_1 CAESAR_ARG_1 (CAESAR_TYPE_CACHE_1);

/*---------------------------------------------------------------------------*/

extern CAESAR_TYPE_BOOLEAN CAESAR_SEARCH_AND_PUT_CACHE_1 CAESAR_ARG_3 (CAESAR_TYPE_CACHE_1, CAESAR_TYPE_NATURAL *, CAESAR_TYPE_POINTER *);

/*---------------------------------------------------------------------------*/

extern CAESAR_TYPE_ERROR_CACHE_1 CAESAR_STATUS_PUT_CACHE_1 CAESAR_ARG_1 (CAESAR_TYPE_CACHE_1);

/*---------------------------------------------------------------------------*/

extern CAESAR_TYPE_POINTER CAESAR_MINIMAL_ITEM_CACHE_1 CAESAR_ARG_2 (CAESAR_TYPE_CACHE_1, CAESAR_TYPE_NATURAL);

/*---------------------------------------------------------------------------*/

extern void CAESAR_DELETE_ITEM_CACHE_1 CAESAR_ARG_3 (CAESAR_TYPE_CACHE_1, CAESAR_TYPE_NATURAL, CAESAR_TYPE_POINTER *);

/*---------------------------------------------------------------------------*/

extern void CAESAR_LAST_ITEM_REPLACED_CACHE_1 CAESAR_ARG_3 (CAESAR_TYPE_CACHE_1, CAESAR_TYPE_NATURAL *, CAESAR_TYPE_POINTER *);

/*---------------------------------------------------------------------------*/

extern void CAESAR_UPDATE_CACHE_1 CAESAR_ARG_3 (CAESAR_TYPE_CACHE_1, CAESAR_TYPE_NATURAL, CAESAR_TYPE_POINTER);

/*---------------------------------------------------------------------------*/

extern CAESAR_TYPE_NATURAL CAESAR_CURRENT_DATE_SUBCACHE_CACHE_1 CAESAR_ARG_2 (CAESAR_TYPE_CACHE_1, CAESAR_TYPE_NATURAL);

/*---------------------------------------------------------------------------*/

extern CAESAR_TYPE_NATURAL CAESAR_CURRENT_DATE_CACHE_1 CAESAR_ARG_1 (CAESAR_TYPE_CACHE_1);

/*---------------------------------------------------------------------------*/

extern CAESAR_TYPE_NATURAL CAESAR_NUMBER_OF_ITEMS_SUBCACHE_CACHE_1 CAESAR_ARG_2 (CAESAR_TYPE_CACHE_1, CAESAR_TYPE_NATURAL);

/*---------------------------------------------------------------------------*/

extern CAESAR_TYPE_NATURAL CAESAR_NUMBER_OF_ITEMS_CACHE_1 CAESAR_ARG_1 (CAESAR_TYPE_CACHE_1);

/*---------------------------------------------------------------------------*/

extern CAESAR_TYPE_NATURAL CAESAR_NUMBER_OF_SEARCHES_CACHE_1 CAESAR_ARG_1 (CAESAR_TYPE_CACHE_1);

/*---------------------------------------------------------------------------*/

extern CAESAR_TYPE_NATURAL CAESAR_NUMBER_OF_HITS_SUBCACHE_CACHE_1 CAESAR_ARG_2 (CAESAR_TYPE_CACHE_1, CAESAR_TYPE_NATURAL);

/*---------------------------------------------------------------------------*/

extern CAESAR_TYPE_NATURAL CAESAR_NUMBER_OF_HITS_CACHE_1 CAESAR_ARG_1 (CAESAR_TYPE_CACHE_1);

/*---------------------------------------------------------------------------*/

extern CAESAR_TYPE_NATURAL CAESAR_ITEM_PUT_DATE_CACHE_1 CAESAR_ARG_2 (CAESAR_TYPE_CACHE_1, CAESAR_TYPE_POINTER);

/*---------------------------------------------------------------------------*/

extern CAESAR_TYPE_NATURAL CAESAR_ITEM_CURRENT_DATE_CACHE_1 CAESAR_ARG_2 (CAESAR_TYPE_CACHE_1, CAESAR_TYPE_POINTER);

/*---------------------------------------------------------------------------*/

extern CAESAR_TYPE_NATURAL CAESAR_ITEM_NUMBER_OF_HITS_CACHE_1 CAESAR_ARG_2 (CAESAR_TYPE_CACHE_1, CAESAR_TYPE_POINTER);

/*---------------------------------------------------------------------------*/

extern CAESAR_TYPE_BOOLEAN CAESAR_EMPTY_SUBCACHE_CACHE_1 CAESAR_ARG_2 (CAESAR_TYPE_CACHE_1, CAESAR_TYPE_NATURAL);

/*---------------------------------------------------------------------------*/

extern CAESAR_TYPE_BOOLEAN CAESAR_EMPTY_CACHE_1 CAESAR_ARG_1 (CAESAR_TYPE_CACHE_1);

/*---------------------------------------------------------------------------*/

extern CAESAR_TYPE_BOOLEAN CAESAR_FULL_SUBCACHE_CACHE_1 CAESAR_ARG_2 (CAESAR_TYPE_CACHE_1, CAESAR_TYPE_NATURAL);

/*---------------------------------------------------------------------------*/

extern CAESAR_TYPE_BOOLEAN CAESAR_FULL_CACHE_1 CAESAR_ARG_1 (CAESAR_TYPE_CACHE_1);

/*---------------------------------------------------------------------------*/

extern CAESAR_TYPE_POINTER CAESAR_INFO_CACHE_1 CAESAR_ARG_1 (CAESAR_TYPE_CACHE_1);

/*---------------------------------------------------------------------------*/

extern void CAESAR_RETRIEVE_B_M_CACHE_1 CAESAR_ARG_3 (CAESAR_TYPE_CACHE_1, CAESAR_TYPE_POINTER, CAESAR_TYPE_POINTER *);

/*---------------------------------------------------------------------------*/

extern void CAESAR_RETRIEVE_M_B_CACHE_1 CAESAR_ARG_3 (CAESAR_TYPE_CACHE_1, CAESAR_TYPE_POINTER, CAESAR_TYPE_POINTER *);

/*---------------------------------------------------------------------------*/

extern CAESAR_TYPE_FORMAT CAESAR_FORMAT_CACHE_1 CAESAR_ARG_2 (CAESAR_TYPE_CACHE_1, CAESAR_PROMOTE_TO_INT (CAESAR_TYPE_FORMAT));

/*---------------------------------------------------------------------------*/

/* deprecated primitive, kept as a macro for backward compatibility */
#define CAESAR_MAX_FORMAT_CACHE_1() (CAESAR_FORMAT_CACHE_1 (NULL, CAESAR_MAXIMAL_FORMAT))

/*---------------------------------------------------------------------------*/

extern void CAESAR_PRINT_CACHE_1 CAESAR_ARG_2 (CAESAR_TYPE_FILE, CAESAR_TYPE_CACHE_1);

/*****************************************************************************/

#ifdef CAESAR_UNDEFINED
{
#endif

#ifdef __cplusplus
}
#endif

#endif
