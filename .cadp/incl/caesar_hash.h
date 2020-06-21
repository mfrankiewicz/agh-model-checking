/******************************************************************************
 *                           O P E N / C A E S A R
 *-----------------------------------------------------------------------------
 *   INRIA - Unite de Recherche Rhone-Alpes
 *   655, avenue de l'Europe
 *   38330 Montbonnot Saint Martin
 *   FRANCE
 *-----------------------------------------------------------------------------
 *   Module             :       caesar_hash.h
 *   Auteur             :       Hubert GARAVEL
 *   Version            :       1.21
 *   Date               :       2009/04/06 09:24:24
 *****************************************************************************/

#ifndef CAESAR_HASH_INTERFACE

#define CAESAR_HASH_INTERFACE

#ifdef __cplusplus
extern "C" {
#endif

#ifdef CAESAR_UNDEFINED
}
#endif

/*****************************************************************************/

#include "caesar_standard.h"

#ifndef CAESAR_ORDINARY_HASH
#include "caesar_graph.h"
#endif

/*---------------------------------------------------------------------------*/

extern CAESAR_TYPE_BOOLEAN CAESAR_PRIME_HASH CAESAR_ARG_1 (CAESAR_TYPE_NATURAL);

/* ======================================================================== */

extern CAESAR_TYPE_NATURAL CAESAR_0_HASH CAESAR_ARG_3 (CAESAR_TYPE_POINTER, CAESAR_TYPE_NATURAL, CAESAR_TYPE_NATURAL);

/*---------------------------------------------------------------------------*/

extern CAESAR_TYPE_NATURAL CAESAR_1_HASH CAESAR_ARG_3 (CAESAR_TYPE_POINTER, CAESAR_TYPE_NATURAL, CAESAR_TYPE_NATURAL);

/*---------------------------------------------------------------------------*/

extern CAESAR_TYPE_NATURAL CAESAR_2_HASH CAESAR_ARG_3 (CAESAR_TYPE_POINTER, CAESAR_TYPE_NATURAL, CAESAR_TYPE_NATURAL);

/*---------------------------------------------------------------------------*/

extern CAESAR_TYPE_NATURAL CAESAR_3_HASH CAESAR_ARG_3 (CAESAR_TYPE_POINTER, CAESAR_TYPE_NATURAL, CAESAR_TYPE_NATURAL);

/*---------------------------------------------------------------------------*/

extern CAESAR_TYPE_NATURAL CAESAR_4_HASH CAESAR_ARG_3 (CAESAR_TYPE_POINTER, CAESAR_TYPE_NATURAL, CAESAR_TYPE_NATURAL);

/*---------------------------------------------------------------------------*/

extern CAESAR_TYPE_NATURAL CAESAR_5_HASH CAESAR_ARG_3 (CAESAR_TYPE_POINTER, CAESAR_TYPE_NATURAL, CAESAR_TYPE_NATURAL);

/*---------------------------------------------------------------------------*/

extern CAESAR_TYPE_NATURAL CAESAR_6_HASH CAESAR_ARG_3 (CAESAR_TYPE_POINTER, CAESAR_TYPE_NATURAL, CAESAR_TYPE_NATURAL);

/*---------------------------------------------------------------------------*/

extern CAESAR_TYPE_NATURAL CAESAR_7_HASH CAESAR_ARG_3 (CAESAR_TYPE_POINTER, CAESAR_TYPE_NATURAL, CAESAR_TYPE_NATURAL);

/* ======================================================================== */

#ifndef CAESAR_ORDINARY_HASH

/*---------------------------------------------------------------------------*/

extern CAESAR_TYPE_NATURAL CAESAR_STATE_0_HASH CAESAR_ARG_2 (CAESAR_TYPE_STATE, CAESAR_TYPE_NATURAL);

/*---------------------------------------------------------------------------*/

extern CAESAR_TYPE_NATURAL CAESAR_STATE_1_HASH CAESAR_ARG_2 (CAESAR_TYPE_STATE, CAESAR_TYPE_NATURAL);

/*---------------------------------------------------------------------------*/

extern CAESAR_TYPE_NATURAL CAESAR_STATE_2_HASH CAESAR_ARG_2 (CAESAR_TYPE_STATE, CAESAR_TYPE_NATURAL);

/*---------------------------------------------------------------------------*/

extern CAESAR_TYPE_NATURAL CAESAR_STATE_3_HASH CAESAR_ARG_2 (CAESAR_TYPE_STATE, CAESAR_TYPE_NATURAL);

/*---------------------------------------------------------------------------*/

extern CAESAR_TYPE_NATURAL CAESAR_STATE_4_HASH CAESAR_ARG_2 (CAESAR_TYPE_STATE, CAESAR_TYPE_NATURAL);

/*---------------------------------------------------------------------------*/

extern CAESAR_TYPE_NATURAL CAESAR_STATE_5_HASH CAESAR_ARG_2 (CAESAR_TYPE_STATE, CAESAR_TYPE_NATURAL);

/*---------------------------------------------------------------------------*/

extern CAESAR_TYPE_NATURAL CAESAR_STATE_6_HASH CAESAR_ARG_2 (CAESAR_TYPE_STATE, CAESAR_TYPE_NATURAL);

/*---------------------------------------------------------------------------*/

extern CAESAR_TYPE_NATURAL CAESAR_STATE_7_HASH CAESAR_ARG_2 (CAESAR_TYPE_STATE, CAESAR_TYPE_NATURAL);

/*---------------------------------------------------------------------------*/

#endif

/* ======================================================================== */

#ifndef CAESAR_ORDINARY_HASH

/*---------------------------------------------------------------------------*/

extern CAESAR_TYPE_NATURAL CAESAR_LABEL_0_HASH CAESAR_ARG_2 (CAESAR_TYPE_LABEL, CAESAR_TYPE_NATURAL);

/*---------------------------------------------------------------------------*/

extern CAESAR_TYPE_NATURAL CAESAR_LABEL_1_HASH CAESAR_ARG_2 (CAESAR_TYPE_LABEL, CAESAR_TYPE_NATURAL);

/*---------------------------------------------------------------------------*/

extern CAESAR_TYPE_NATURAL CAESAR_LABEL_2_HASH CAESAR_ARG_2 (CAESAR_TYPE_LABEL, CAESAR_TYPE_NATURAL);

/*---------------------------------------------------------------------------*/

extern CAESAR_TYPE_NATURAL CAESAR_LABEL_3_HASH CAESAR_ARG_2 (CAESAR_TYPE_LABEL, CAESAR_TYPE_NATURAL);

/*---------------------------------------------------------------------------*/

extern CAESAR_TYPE_NATURAL CAESAR_LABEL_4_HASH CAESAR_ARG_2 (CAESAR_TYPE_LABEL, CAESAR_TYPE_NATURAL);

/*---------------------------------------------------------------------------*/

extern CAESAR_TYPE_NATURAL CAESAR_LABEL_5_HASH CAESAR_ARG_2 (CAESAR_TYPE_LABEL, CAESAR_TYPE_NATURAL);

/*---------------------------------------------------------------------------*/

extern CAESAR_TYPE_NATURAL CAESAR_LABEL_6_HASH CAESAR_ARG_2 (CAESAR_TYPE_LABEL, CAESAR_TYPE_NATURAL);

/*---------------------------------------------------------------------------*/

extern CAESAR_TYPE_NATURAL CAESAR_LABEL_7_HASH CAESAR_ARG_2 (CAESAR_TYPE_LABEL, CAESAR_TYPE_NATURAL);

/*---------------------------------------------------------------------------*/

#endif

/* ======================================================================== */

extern CAESAR_TYPE_NATURAL CAESAR_STRING_0_HASH CAESAR_ARG_2 (CAESAR_TYPE_STRING, CAESAR_TYPE_NATURAL);

/*****************************************************************************/

#ifdef CAESAR_UNDEFINED
{
#endif

#ifdef __cplusplus
}
#endif

#endif
