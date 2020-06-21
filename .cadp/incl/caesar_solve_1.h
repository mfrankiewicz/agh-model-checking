/******************************************************************************
 *                           O P E N / C A E S A R
 *-----------------------------------------------------------------------------
 *   INRIA - Unite de Recherche Rhone-Alpes
 *   655, avenue de l'Europe
 *   38330 Montbonnot Saint Martin
 *   FRANCE
 *-----------------------------------------------------------------------------
 *   Module             :       caesar_solve_1.h
 *   Auteur             :       Radu MATEESCU
 *   Version            :       1.52
 *   Date               :       2017/09/04 15:29:22
 *****************************************************************************/

#ifndef CAESAR_SOLVE_1_INTERFACE

#define CAESAR_SOLVE_1_INTERFACE

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

typedef CAESAR_TYPE_ABSTRACT (CAESAR_STRUCT_SOLVE_1) CAESAR_TYPE_SOLVE_1;

/*---------------------------------------------------------------------------*/

typedef CAESAR_TYPE_BOOLEAN CAESAR_TYPE_BLOCK_SIGN_SOLVE_1;

#define CAESAR_MINIMAL_FIXED_POINT_SOLVE_1 \
	((CAESAR_TYPE_BLOCK_SIGN_SOLVE_1) CAESAR_TRUE)

#define CAESAR_MAXIMAL_FIXED_POINT_SOLVE_1 \
	((CAESAR_TYPE_BLOCK_SIGN_SOLVE_1) CAESAR_FALSE)

/*---------------------------------------------------------------------------*/

typedef CAESAR_TYPE_BOOLEAN CAESAR_TYPE_VARIABLE_KIND_SOLVE_1;

#define CAESAR_DISJUNCTIVE_VARIABLE_SOLVE_1 \
	((CAESAR_TYPE_VARIABLE_KIND_SOLVE_1) CAESAR_TRUE)

#define CAESAR_CONJUNCTIVE_VARIABLE_SOLVE_1 \
	((CAESAR_TYPE_VARIABLE_KIND_SOLVE_1) CAESAR_FALSE)

/*---------------------------------------------------------------------------*/

typedef CAESAR_TYPE_BLOCK_SIGN_SOLVE_1 (*CAESAR_TYPE_BLOCK_SIGN_FUNCTION_SOLVE_1) CAESAR_ARG_1 (CAESAR_TYPE_NATURAL);

typedef CAESAR_TYPE_VARIABLE_KIND_SOLVE_1 (*CAESAR_TYPE_VARIABLE_KIND_FUNCTION_SOLVE_1) CAESAR_ARG_1 (CAESAR_TYPE_POINTER);

typedef CAESAR_TYPE_AREA_1 (*CAESAR_TYPE_AREA_FUNCTION_SOLVE_1) CAESAR_ARG_1 (CAESAR_TYPE_NATURAL);

typedef CAESAR_TYPE_BOOLEAN (*CAESAR_TYPE_BOOLEAN_FUNCTION_SOLVE_1) CAESAR_ARG_1 (CAESAR_TYPE_NATURAL);

typedef CAESAR_TYPE_NATURAL (*CAESAR_TYPE_NATURAL_FUNCTION_SOLVE_1) CAESAR_ARG_1 (CAESAR_TYPE_NATURAL);

/*---------------------------------------------------------------------------*/

typedef enum {
     CAESAR_NONE_SOLVE_1,
     CAESAR_MULTIPLE_RESOLUTION_SOLVE_1,
     CAESAR_MEMORY_SHORTAGE_SOLVE_1,
     CAESAR_RECURSIVE_BLOCK_SOLVE_1,
     CAESAR_CYCLIC_BLOCK_SOLVE_1,
     CAESAR_NOT_DISJUNCTIVE_BLOCK_SOLVE_1,
     CAESAR_NOT_CONJUNCTIVE_BLOCK_SOLVE_1,
     CAESAR_MINIMAL_FIXED_POINT_BLOCK_SOLVE_1,
     CAESAR_MAXIMAL_FIXED_POINT_BLOCK_SOLVE_1
}    CAESAR_TYPE_ERROR_SOLVE_1;

/*---------------------------------------------------------------------------*/

extern void CAESAR_CREATE_SOLVE_1 CAESAR_ARG_15
     (CAESAR_TYPE_SOLVE_1 *,
           CAESAR_TYPE_NATURAL,
           CAESAR_TYPE_BLOCK_SIGN_FUNCTION_SOLVE_1,
           CAESAR_TYPE_BOOLEAN_FUNCTION_SOLVE_1,
           CAESAR_TYPE_NATURAL_FUNCTION_SOLVE_1,
           CAESAR_TYPE_AREA_FUNCTION_SOLVE_1,
           CAESAR_TYPE_NATURAL_FUNCTION_SOLVE_1,
           CAESAR_TYPE_NATURAL_FUNCTION_SOLVE_1,
           CAESAR_TYPE_BOOLEAN_FUNCTION_SOLVE_1,
           CAESAR_TYPE_VARIABLE_KIND_FUNCTION_SOLVE_1,
           CAESAR_TYPE_COMPARE_FUNCTION,
           CAESAR_TYPE_HASH_FUNCTION,
           CAESAR_TYPE_PRINT_FUNCTION,
           void (*) (CAESAR_TYPE_POINTER,
		          CAESAR_TYPE_POINTER,
		          void (*) (CAESAR_TYPE_POINTER,
				         CAESAR_TYPE_NATURAL,
				         CAESAR_TYPE_POINTER
				    )
		     )   ,
           CAESAR_TYPE_POINTER
);

/*---------------------------------------------------------------------------*/

extern CAESAR_TYPE_SOLVE_1 CAESAR_CURRENT_SYSTEM_SOLVE_1 ();

/*---------------------------------------------------------------------------*/

extern CAESAR_TYPE_NATURAL CAESAR_CURRENT_BLOCK_SOLVE_1 ();

/*---------------------------------------------------------------------------*/

extern void CAESAR_DELETE_SOLVE_1 CAESAR_ARG_1 (CAESAR_TYPE_SOLVE_1 *);

/*---------------------------------------------------------------------------*/

extern void CAESAR_PURGE_BLOCK_SOLVE_1 CAESAR_ARG_2
     (CAESAR_TYPE_SOLVE_1, CAESAR_TYPE_NATURAL);

/*---------------------------------------------------------------------------*/

extern CAESAR_TYPE_BOOLEAN CAESAR_COMPUTE_SOLVE_1 CAESAR_ARG_3
     (CAESAR_TYPE_SOLVE_1,
           CAESAR_TYPE_NATURAL,
           CAESAR_TYPE_POINTER);

/*---------------------------------------------------------------------------*/

extern CAESAR_TYPE_ERROR_SOLVE_1 CAESAR_STATUS_COMPUTE_SOLVE_1 CAESAR_ARG_2
     (CAESAR_TYPE_SOLVE_1, CAESAR_TYPE_NATURAL);

/*---------------------------------------------------------------------------*/

extern void CAESAR_ITERATE_STABLE_VARIABLE_SOLVE_1 CAESAR_ARG_5
     (CAESAR_TYPE_SOLVE_1,
           CAESAR_TYPE_NATURAL,
           CAESAR_TYPE_POINTER,
           CAESAR_TYPE_BOOLEAN *,
           void (*) (CAESAR_TYPE_SOLVE_1,
		          CAESAR_TYPE_NATURAL,
		          CAESAR_TYPE_POINTER,
		          CAESAR_TYPE_BOOLEAN *
		     )
);

/*---------------------------------------------------------------------------*/

extern void CAESAR_START_DIAGNOSTIC_SOLVE_1 CAESAR_ARG_5
     (CAESAR_TYPE_SOLVE_1,
           CAESAR_TYPE_NATURAL,
           CAESAR_TYPE_POINTER,
           CAESAR_PROMOTE_TO_INT (CAESAR_TYPE_BOOLEAN),
           CAESAR_TYPE_POINTER *);

/*---------------------------------------------------------------------------*/

extern void CAESAR_ITERATE_DIAGNOSTIC_SOLVE_1 CAESAR_ARG_7
     (CAESAR_TYPE_SOLVE_1,
           CAESAR_TYPE_NATURAL,
           CAESAR_TYPE_POINTER,
           CAESAR_TYPE_POINTER *,
           CAESAR_TYPE_NATURAL *,
           CAESAR_TYPE_POINTER *,
           void (*) (CAESAR_TYPE_SOLVE_1,
		          CAESAR_TYPE_NATURAL,
		          CAESAR_TYPE_POINTER,
		          CAESAR_TYPE_POINTER *,
		          CAESAR_TYPE_NATURAL *,
		          CAESAR_TYPE_POINTER *
		     )
);

/*---------------------------------------------------------------------------*/

extern CAESAR_TYPE_NATURAL CAESAR_CREATION_DIAGNOSTIC_SOLVE_1 CAESAR_ARG_2
     (CAESAR_TYPE_SOLVE_1, CAESAR_TYPE_NATURAL);

/*---------------------------------------------------------------------------*/

extern CAESAR_TYPE_NATURAL CAESAR_TRUNCATION_DIAGNOSTIC_SOLVE_1 CAESAR_ARG_2
     (CAESAR_TYPE_SOLVE_1, CAESAR_TYPE_NATURAL);

/*---------------------------------------------------------------------------*/

void CAESAR_READ_SOLVE_1 CAESAR_ARG_4
     (CAESAR_TYPE_SOLVE_1 *,
           CAESAR_TYPE_FILE,
           CAESAR_TYPE_BOOLEAN_FUNCTION_SOLVE_1,
           CAESAR_TYPE_NATURAL_FUNCTION_SOLVE_1);

/*---------------------------------------------------------------------------*/

void CAESAR_WRITE_SOLVE_1 CAESAR_ARG_5
     (CAESAR_TYPE_SOLVE_1,
           CAESAR_TYPE_NATURAL,
           CAESAR_TYPE_POINTER,
           CAESAR_TYPE_FILE,
           CAESAR_PROMOTE_TO_INT (CAESAR_TYPE_BOOLEAN));

/*---------------------------------------------------------------------------*/

CAESAR_TYPE_FORMAT CAESAR_FORMAT_SOLVE_1 CAESAR_ARG_2
     (CAESAR_TYPE_SOLVE_1,
           CAESAR_PROMOTE_TO_INT (CAESAR_TYPE_FORMAT));

/*---------------------------------------------------------------------------*/

/* deprecated primitive, kept as a macro for backward compatibility */
#define CAESAR_MAX_FORMAT_SOLVE_1() (CAESAR_FORMAT_SOLVE_1 (NULL, CAESAR_MAXIMAL_FORMAT))

/*---------------------------------------------------------------------------*/

extern void CAESAR_PRINT_SOLVE_1 CAESAR_ARG_2
     (CAESAR_TYPE_FILE, CAESAR_TYPE_SOLVE_1);

/*****************************************************************************/

#ifdef CAESAR_UNDEFINED
{
#endif

#ifdef __cplusplus
}
#endif

#endif
