/******************************************************************************
 *                           O P E N / C A E S A R
 *-----------------------------------------------------------------------------
 *   INRIA - Unite de Recherche Rhone-Alpes
 *   655, avenue de l'Europe
 *   38330 Montbonnot Saint Martin
 *   FRANCE
 *-----------------------------------------------------------------------------
 *   Module             :       caesar_graph.h
 *   Auteur             :       Hubert GARAVEL
 *   Version            :       1.33
 *   Date               :       2017/09/04 15:32:41
 *****************************************************************************/

#ifndef CAESAR_GRAPH_INTERFACE

#define CAESAR_GRAPH_INTERFACE

#ifdef __cplusplus
extern "C" {
#endif

#ifdef CAESAR_UNDEFINED
}
#endif

/*****************************************************************************/

#include "caesar_standard.h"

#include "caesar_version.h"

/*---------------------------------------------------------------------------*/

extern CAESAR_TYPE_STRING CAESAR_GRAPH_COMPILER CAESAR_ARG_0 ();

/*---------------------------------------------------------------------------*/

extern CAESAR_TYPE_VERSION CAESAR_GRAPH_VERSION CAESAR_ARG_0 ();

/*---------------------------------------------------------------------------*/

extern void CAESAR_INIT_GRAPH CAESAR_ARG_0 ();

/*---------------------------------------------------------------------------*/

#if !defined (CAESAR_GRAPH_IMPLEMENTATION) || (CAESAR_GRAPH_IMPLEMENTATION - 0 != 0)

/*
 * declaration du type CAESAR_TYPE_STATE sauf dans le cas ou le present
 * fichier est inclus dans un programme C produit avec un compilateur
 * compatible Open/Caesar (par exemple, Caesar, Bcg_Open, etc.) mais obsolete
 * (anterieur a la version Open/Caesar 2.3 incluse), ce que l'on detecte en
 * testant que la variable CAESAR_GRAPH_IMPLEMENTATION est definie et egale a
 * la chaine vide
 */

typedef CAESAR_TYPE_ABSTRACT (CAESAR_STRUCT_STATE) CAESAR_TYPE_STATE;

#endif

/*---------------------------------------------------------------------------*/

/*** extern CAESAR_TYPE_NATURAL CAESAR_SIZE_STATE CAESAR_ARG_0 (); ***/

#define CAESAR_SIZE_STATE() CAESAR_HINT_SIZE_STATE

extern CAESAR_TYPE_NATURAL CAESAR_HINT_SIZE_STATE;	/* not to be referenced! */

/*---------------------------------------------------------------------------*/

/*** extern CAESAR_TYPE_NATURAL CAESAR_HASH_SIZE_STATE CAESAR_ARG_0 (); ***/

#define CAESAR_HASH_SIZE_STATE() CAESAR_HINT_HASH_SIZE_STATE

extern CAESAR_TYPE_NATURAL CAESAR_HINT_HASH_SIZE_STATE;	/* not to be referenced! */

/*---------------------------------------------------------------------------*/

/*** extern CAESAR_TYPE_NATURAL CAESAR_ALIGNMENT_STATE CAESAR_ARG_0 (); ***/

#define CAESAR_ALIGNMENT_STATE() CAESAR_HINT_ALIGNMENT_STATE

extern CAESAR_TYPE_NATURAL CAESAR_HINT_ALIGNMENT_STATE;	/* not to be referenced! */

/*---------------------------------------------------------------------------*/

/*** extern void CAESAR_CREATE_STATE CAESAR_ARG_1 (CAESAR_TYPE_STATE *); ***/

#define CAESAR_CREATE_STATE(CAESAR_S) CAESAR_CREATE (*(CAESAR_S), CAESAR_SIZE_STATE(), CAESAR_TYPE_STATE)

/*---------------------------------------------------------------------------*/

/*** extern void CAESAR_DELETE_STATE CAESAR_ARG_1 (CAESAR_TYPE_STATE *); ***/

#define CAESAR_DELETE_STATE(CAESAR_S) { CAESAR_DELETE (*(CAESAR_S)); *(CAESAR_S) = NULL; }

/*---------------------------------------------------------------------------*/

/*** extern void CAESAR_COPY_STATE CAESAR_ARG_2 (CAESAR_TYPE_STATE, CAESAR_TYPE_STATE); ***/

#if defined (CAESAR_GRAPH_IMPLEMENTATION) && defined (CAESAR_USE_STRUCT_ASSIGNMENT)

#define CAESAR_COPY_STATE(CAESAR_S1,CAESAR_S2) *(CAESAR_S1) = *(CAESAR_S2)

#else

#define CAESAR_COPY_STATE(CAESAR_S1,CAESAR_S2) (void) memcpy ((void *) (CAESAR_S1), (void *) (CAESAR_S2), (size_t) CAESAR_SIZE_STATE ())

#endif

/*---------------------------------------------------------------------------*/

extern CAESAR_TYPE_BOOLEAN CAESAR_COMPARE_STATE CAESAR_ARG_2 (CAESAR_TYPE_STATE, CAESAR_TYPE_STATE);

/*---------------------------------------------------------------------------*/

extern CAESAR_TYPE_NATURAL CAESAR_HASH_STATE CAESAR_ARG_2 (CAESAR_TYPE_STATE, CAESAR_TYPE_NATURAL);

/*---------------------------------------------------------------------------*/

extern CAESAR_TYPE_FORMAT CAESAR_FORMAT_STATE CAESAR_ARG_1 (CAESAR_PROMOTE_TO_INT (CAESAR_TYPE_FORMAT));

/*---------------------------------------------------------------------------*/

/* deprecated primitive, kept as a macro for backward compatibility */
#define CAESAR_MAX_FORMAT_STATE() (CAESAR_FORMAT_STATE (CAESAR_MAXIMAL_FORMAT))

/*---------------------------------------------------------------------------*/

extern void CAESAR_PRINT_STATE_HEADER CAESAR_ARG_1 (CAESAR_TYPE_FILE);

/*---------------------------------------------------------------------------*/

extern void CAESAR_PRINT_STATE CAESAR_ARG_2 (CAESAR_TYPE_FILE, CAESAR_TYPE_STATE);

/*---------------------------------------------------------------------------*/

extern void CAESAR_DELTA_STATE CAESAR_ARG_3 (CAESAR_TYPE_FILE, CAESAR_TYPE_STATE, CAESAR_TYPE_STATE);

/* ======================================================================== */

#if !defined (CAESAR_GRAPH_IMPLEMENTATION) || (CAESAR_GRAPH_IMPLEMENTATION - 0 != 0)

/*
 * declaration du type CAESAR_TYPE_LABEL sauf dans le cas ou le present
 * fichier est inclus dans un programme C produit avec un compilateur
 * compatible Open/Caesar (par exemple, Caesar, Bcg_Open, etc.) mais obsolete
 * (anterieur a la version Open/Caesar 2.3 incluse), ce que l'on detecte en
 * testant que la variable CAESAR_GRAPH_IMPLEMENTATION est definie et egale a
 * la chaine vide
 */

typedef CAESAR_TYPE_ABSTRACT (CAESAR_STRUCT_LABEL) CAESAR_TYPE_LABEL;

#endif

/*---------------------------------------------------------------------------*/

/*** extern CAESAR_TYPE_NATURAL CAESAR_SIZE_LABEL CAESAR_ARG_0 (); ***/

#define CAESAR_SIZE_LABEL() CAESAR_HINT_SIZE_LABEL

extern CAESAR_TYPE_NATURAL CAESAR_HINT_SIZE_LABEL;	/* not to be referenced! */

/*---------------------------------------------------------------------------*/

/*** extern CAESAR_TYPE_NATURAL CAESAR_HASH_SIZE_LABEL CAESAR_ARG_0 (); ***/

#define CAESAR_HASH_SIZE_LABEL() CAESAR_HINT_HASH_SIZE_LABEL

extern CAESAR_TYPE_NATURAL CAESAR_HINT_HASH_SIZE_LABEL;	/* not to be referenced! */

/*---------------------------------------------------------------------------*/

/*** extern CAESAR_TYPE_NATURAL CAESAR_ALIGNMENT_LABEL CAESAR_ARG_0 (); ***/

#define CAESAR_ALIGNMENT_LABEL() CAESAR_HINT_ALIGNMENT_LABEL

extern CAESAR_TYPE_NATURAL CAESAR_HINT_ALIGNMENT_LABEL;	/* not to be referenced! */

/*---------------------------------------------------------------------------*/

/*** extern void CAESAR_CREATE_LABEL CAESAR_ARG_1 (CAESAR_TYPE_LABEL *); ***/

#define CAESAR_CREATE_LABEL(CAESAR_L) CAESAR_CREATE (*(CAESAR_L), CAESAR_SIZE_LABEL(), CAESAR_TYPE_LABEL)

/*---------------------------------------------------------------------------*/

/*** extern void CAESAR_DELETE_LABEL CAESAR_ARG_1 (CAESAR_TYPE_LABEL *); ***/

#define CAESAR_DELETE_LABEL(CAESAR_L) { CAESAR_DELETE (*(CAESAR_L)); *(CAESAR_L) = NULL; }

/*---------------------------------------------------------------------------*/

extern CAESAR_TYPE_BOOLEAN CAESAR_VISIBLE_LABEL CAESAR_ARG_1 (CAESAR_TYPE_LABEL);

/*---------------------------------------------------------------------------*/

extern CAESAR_TYPE_STRING CAESAR_GATE_LABEL CAESAR_ARG_1 (CAESAR_TYPE_LABEL);

/*---------------------------------------------------------------------------*/

extern CAESAR_TYPE_NATURAL CAESAR_CARDINAL_LABEL CAESAR_ARG_1 (CAESAR_TYPE_LABEL);

/*---------------------------------------------------------------------------*/

/*** extern void CAESAR_COPY_LABEL CAESAR_ARG_2 (CAESAR_TYPE_LABEL, CAESAR_TYPE_LABEL); ***/

#if defined (CAESAR_GRAPH_IMPLEMENTATION) && defined (CAESAR_USE_STRUCT_ASSIGNMENT)

#define CAESAR_COPY_LABEL(CAESAR_L1,CAESAR_L2) *(CAESAR_L1) = *(CAESAR_L2)

#else

#define CAESAR_COPY_LABEL(CAESAR_L1,CAESAR_L2) (void) memcpy ((void *) (CAESAR_L1), (void *) (CAESAR_L2), (size_t) CAESAR_SIZE_LABEL ())

#endif

/*---------------------------------------------------------------------------*/

extern CAESAR_TYPE_BOOLEAN CAESAR_COMPARE_LABEL CAESAR_ARG_2 (CAESAR_TYPE_LABEL, CAESAR_TYPE_LABEL);

/*---------------------------------------------------------------------------*/

extern CAESAR_TYPE_NATURAL CAESAR_HASH_LABEL CAESAR_ARG_2 (CAESAR_TYPE_LABEL, CAESAR_TYPE_NATURAL);

/*---------------------------------------------------------------------------*/

extern void CAESAR_PRINT_LABEL CAESAR_ARG_2 (CAESAR_TYPE_FILE, CAESAR_TYPE_LABEL);

/*---------------------------------------------------------------------------*/

extern CAESAR_TYPE_STRING CAESAR_STRING_LABEL CAESAR_ARG_1 (CAESAR_TYPE_LABEL);

/*---------------------------------------------------------------------------*/

extern CAESAR_TYPE_FORMAT CAESAR_FORMAT_LABEL CAESAR_ARG_1 (CAESAR_PROMOTE_TO_INT (CAESAR_TYPE_FORMAT));

/*---------------------------------------------------------------------------*/

/* deprecated primitive, kept as a macro for backward compatibility */
#define CAESAR_MAX_FORMAT_LABEL() (CAESAR_FORMAT_LABEL (CAESAR_MAXIMAL_FORMAT))

/*---------------------------------------------------------------------------*/

extern CAESAR_TYPE_STRING CAESAR_INFORMATION_LABEL CAESAR_ARG_1 (CAESAR_TYPE_LABEL);

/* ======================================================================== */

extern void CAESAR_START_STATE CAESAR_ARG_1 (CAESAR_TYPE_STATE);

/*---------------------------------------------------------------------------*/

extern void CAESAR_ITERATE_STATE CAESAR_ARG_4 (CAESAR_TYPE_STATE, CAESAR_TYPE_LABEL, CAESAR_TYPE_STATE, void (*) (CAESAR_TYPE_STATE, CAESAR_TYPE_LABEL, CAESAR_TYPE_STATE));

/*****************************************************************************/

#ifdef CAESAR_UNDEFINED
{
#endif

#ifdef __cplusplus
}
#endif

#endif
