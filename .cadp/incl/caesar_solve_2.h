/******************************************************************************
 *                           O P E N / C A E S A R
 *-----------------------------------------------------------------------------
 *   INRIA - Unite de Recherche Rhone-Alpes
 *   655, avenue de l'Europe
 *   38330 Montbonnot Saint Martin
 *   FRANCE
 *-----------------------------------------------------------------------------
 *   Module             :       caesar_solve_2.h
 *   Auteur             :       Radu MATEESCU
 *   Version            :       1.10
 *   Date               :       2019/01/11 14:36:04
 *****************************************************************************/

#ifndef CAESAR_SOLVE_2_INTERFACE

#define CAESAR_SOLVE_2_INTERFACE

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

typedef CAESAR_TYPE_ABSTRACT (CAESAR_STRUCT_SOLVE_2) CAESAR_TYPE_SOLVE_2;

/*---------------------------------------------------------------------------*/

typedef double CAESAR_TYPE_REAL;

/*---------------------------------------------------------------------------*/

typedef enum {
     CAESAR_NONE_SOLVE_2,
     CAESAR_MULTIPLE_RESOLUTION_SOLVE_2,
     CAESAR_MEMORY_SHORTAGE_SOLVE_2,
     CAESAR_SINGULAR_SOLVE_2
}    CAESAR_TYPE_ERROR_SOLVE_2;

/*---------------------------------------------------------------------------*/

extern void CAESAR_CREATE_SOLVE_2 CAESAR_ARG_13
     (CAESAR_TYPE_SOLVE_2 *,
           CAESAR_PROMOTE_TO_INT (CAESAR_TYPE_BOOLEAN),
           CAESAR_TYPE_NATURAL,
           CAESAR_TYPE_REAL,
           CAESAR_TYPE_AREA_1,
           CAESAR_TYPE_NATURAL,
           CAESAR_TYPE_NATURAL,
           CAESAR_PROMOTE_TO_INT (CAESAR_TYPE_BOOLEAN),
           CAESAR_TYPE_COMPARE_FUNCTION,
           CAESAR_TYPE_HASH_FUNCTION,
           CAESAR_TYPE_PRINT_FUNCTION,
           void (*) (CAESAR_TYPE_POINTER,
		          CAESAR_TYPE_POINTER,
		          void (*) (CAESAR_TYPE_REAL,
				         CAESAR_TYPE_POINTER
				    )
		     )   ,
           CAESAR_TYPE_POINTER
);

/*---------------------------------------------------------------------------*/

extern CAESAR_TYPE_SOLVE_2 CAESAR_CURRENT_SYSTEM_SOLVE_2 ();

/*---------------------------------------------------------------------------*/

extern void CAESAR_DELETE_SOLVE_2 CAESAR_ARG_1 (CAESAR_TYPE_SOLVE_2 *);

/*---------------------------------------------------------------------------*/

extern void CAESAR_PURGE_SOLVE_2 CAESAR_ARG_1 (CAESAR_TYPE_SOLVE_2);

/*---------------------------------------------------------------------------*/

extern CAESAR_TYPE_REAL CAESAR_COMPUTE_SOLVE_2 CAESAR_ARG_2 (CAESAR_TYPE_SOLVE_2, CAESAR_TYPE_POINTER);

/*---------------------------------------------------------------------------*/

extern CAESAR_TYPE_ERROR_SOLVE_2 CAESAR_STATUS_COMPUTE_SOLVE_2 CAESAR_ARG_1 (CAESAR_TYPE_SOLVE_2);

/*---------------------------------------------------------------------------*/

CAESAR_TYPE_FORMAT CAESAR_FORMAT_SOLVE_2 CAESAR_ARG_2 (CAESAR_TYPE_SOLVE_2, CAESAR_PROMOTE_TO_INT (CAESAR_TYPE_FORMAT));

/*---------------------------------------------------------------------------*/

extern void CAESAR_PRINT_SOLVE_2 CAESAR_ARG_2 (CAESAR_TYPE_FILE, CAESAR_TYPE_SOLVE_2);

/*****************************************************************************/

#ifdef CAESAR_UNDEFINED
{
#endif

#ifdef __cplusplus
}
#endif

#endif
