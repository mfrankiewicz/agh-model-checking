/******************************************************************************
 *                           O P E N / C A E S A R
 *-----------------------------------------------------------------------------
 *   INRIA - Unite de Recherche Rhone-Alpes
 *   655, avenue de l'Europe
 *   38330 Montbonnot Saint Martin
 *   FRANCE
 *-----------------------------------------------------------------------------
 *   Module             :       caesar_stack_1.h
 *   Auteur             :       Hubert GARAVEL
 *   Version            :       1.20
 *   Date               :       2017/09/04 15:32:41
 *****************************************************************************/

#ifndef CAESAR_STACK_1_INTERFACE

#define CAESAR_STACK_1_INTERFACE

#ifdef __cplusplus
extern "C" {
#endif

#ifdef CAESAR_UNDEFINED
}
#endif

/*****************************************************************************/

#include "caesar_standard.h"

#include "caesar_graph.h"

#include "caesar_edge.h"

/*---------------------------------------------------------------------------*/

typedef CAESAR_TYPE_ABSTRACT (CAESAR_STRUCT_STACK_1) CAESAR_TYPE_STACK_1;

/*---------------------------------------------------------------------------*/

typedef void (*CAESAR_TYPE_OVERFLOW_FUNCTION_STACK_1) CAESAR_ARG_1 (CAESAR_TYPE_STACK_1);

extern void CAESAR_OVERFLOW_SIGNAL_STACK_1 CAESAR_ARG_1 (CAESAR_TYPE_STACK_1);

extern void CAESAR_OVERFLOW_ABORT_STACK_1 CAESAR_ARG_1 (CAESAR_TYPE_STACK_1);

extern void CAESAR_OVERFLOW_IGNORE_STACK_1 CAESAR_ARG_1 (CAESAR_TYPE_STACK_1);

/*---------------------------------------------------------------------------*/

extern void CAESAR_INIT_STACK_1 CAESAR_ARG_0 ();

/*---------------------------------------------------------------------------*/

extern void CAESAR_CREATE_STACK_1 CAESAR_ARG_3 (CAESAR_TYPE_STACK_1 *, CAESAR_TYPE_NATURAL, CAESAR_TYPE_OVERFLOW_FUNCTION_STACK_1);

/*---------------------------------------------------------------------------*/

extern void CAESAR_DELETE_STACK_1 CAESAR_ARG_1 (CAESAR_TYPE_STACK_1 *);

/*---------------------------------------------------------------------------*/

extern void CAESAR_PURGE_STACK_1 CAESAR_ARG_1 (CAESAR_TYPE_STACK_1);

/*---------------------------------------------------------------------------*/

extern void CAESAR_COPY_STACK_1 CAESAR_ARG_3 (CAESAR_TYPE_STACK_1, CAESAR_TYPE_STACK_1, CAESAR_PROMOTE_TO_INT (CAESAR_TYPE_BOOLEAN));

/*---------------------------------------------------------------------------*/

extern CAESAR_TYPE_NATURAL CAESAR_DEPTH_STACK_1 CAESAR_ARG_1 (CAESAR_TYPE_STACK_1);

/*---------------------------------------------------------------------------*/

extern CAESAR_TYPE_NATURAL CAESAR_BREADTH_STACK_1 CAESAR_ARG_1 (CAESAR_TYPE_STACK_1);

/*---------------------------------------------------------------------------*/

extern CAESAR_TYPE_STATE CAESAR_TOP_STATE_STACK_1 CAESAR_ARG_1 (CAESAR_TYPE_STACK_1);

/*---------------------------------------------------------------------------*/

extern CAESAR_TYPE_LABEL CAESAR_TOP_LABEL_STACK_1 CAESAR_ARG_1 (CAESAR_TYPE_STACK_1);

/*---------------------------------------------------------------------------*/

extern CAESAR_TYPE_EDGE CAESAR_TOP_EDGE_STACK_1 CAESAR_ARG_1 (CAESAR_TYPE_STACK_1);

/*---------------------------------------------------------------------------*/

extern CAESAR_TYPE_BOOLEAN CAESAR_EMPTY_STACK_1 CAESAR_ARG_1 (CAESAR_TYPE_STACK_1);

/*---------------------------------------------------------------------------*/

extern CAESAR_TYPE_BOOLEAN CAESAR_EXPLORED_STACK_1 CAESAR_ARG_1 (CAESAR_TYPE_STACK_1);

/*---------------------------------------------------------------------------*/

extern void CAESAR_CREATE_TOP_EDGE_STACK_1 CAESAR_ARG_1 (CAESAR_TYPE_STACK_1);

/*---------------------------------------------------------------------------*/

extern void CAESAR_DELETE_TOP_EDGE_STACK_1 CAESAR_ARG_1 (CAESAR_TYPE_STACK_1);

/*---------------------------------------------------------------------------*/

extern void CAESAR_PUSH_STACK_1 CAESAR_ARG_3 (CAESAR_TYPE_STACK_1, CAESAR_TYPE_LABEL, CAESAR_TYPE_STATE);

/*---------------------------------------------------------------------------*/

extern void CAESAR_POP_STACK_1 CAESAR_ARG_1 (CAESAR_TYPE_STACK_1);

/*---------------------------------------------------------------------------*/

extern void CAESAR_SWAP_STACK_1 CAESAR_ARG_1 (CAESAR_TYPE_STACK_1);

/*---------------------------------------------------------------------------*/

extern void CAESAR_REJECT_STACK_1 CAESAR_ARG_1 (CAESAR_TYPE_STACK_1);

/*---------------------------------------------------------------------------*/

extern CAESAR_TYPE_FORMAT CAESAR_FORMAT_STACK_1 CAESAR_ARG_2 (CAESAR_TYPE_STACK_1, CAESAR_PROMOTE_TO_INT (CAESAR_TYPE_FORMAT));

/*---------------------------------------------------------------------------*/

/* deprecated primitive, kept as a macro for backward compatibility */
#define CAESAR_MAX_FORMAT_STACK_1() (CAESAR_FORMAT_STACK_1 (NULL, CAESAR_MAXIMAL_FORMAT))

/*---------------------------------------------------------------------------*/

extern void CAESAR_PRINT_STACK_1 CAESAR_ARG_2 (CAESAR_TYPE_FILE, CAESAR_TYPE_STACK_1);

/*****************************************************************************/

#ifdef CAESAR_UNDEFINED
{
#endif

#ifdef __cplusplus
}
#endif

#endif
