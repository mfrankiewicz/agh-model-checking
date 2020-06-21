/******************************************************************************
 *                                B C G
 *-----------------------------------------------------------------------------
 *   INRIA - Unite de Recherche Rhone-Alpes
 *   655, avenue de l'Europe
 *   38330 Montbonnot Saint Martin
 *   FRANCE
 *-----------------------------------------------------------------------------
 *   Module             :       bcg_read_1.h
 *   Auteurs            :       Renaud RUFFIOT et Hubert GARAVEL
 *   Version            :       1.11
 *   Date               :       2014/07/10 14:29:46
 *****************************************************************************/

#ifndef BCG_READ_1_INTERFACE

#define BCG_READ_1_INTERFACE

#ifdef __cplusplus
extern "C" {
#endif

#ifdef BCG_UNDEFINED
}
#endif

#include "bcg_standard.h"
#include "bcg_types.h"

extern void BCG_READ_BIT BCG_ARG_1 (BCG_TYPE_BOOLEAN *);

extern void BCG_READ_BOOLEAN BCG_ARG_1 (BCG_TYPE_BOOLEAN *);

extern void BCG_READ_BYTE BCG_ARG_1 (BCG_TYPE_BYTE *);

extern void BCG_READ_NATURAL BCG_ARG_1 (BCG_TYPE_NATURAL *);

extern void BCG_READ_LONG_NATURAL BCG_ARG_1 (BCG_TYPE_LONG_NATURAL *);

extern void BCG_READ_UNSIGNED BCG_ARG_2 (BCG_TYPE_NATURAL *, BCG_TYPE_NATURAL);

extern void BCG_READ_REAL BCG_ARG_2 (BCG_TYPE_REAL *, BCG_TYPE_NATURAL);

extern void BCG_READ_OFFSET BCG_ARG_1 (BCG_TYPE_OFFSET *);

extern void BCG_READ_STRING BCG_ARG_1 (BCG_TYPE_C_STRING *);

extern void BCG_READ_FIXED_STRING BCG_ARG_2 (BCG_TYPE_C_STRING *, BCG_TYPE_NATURAL);

extern void BCG_READ_BLOCK BCG_ARG_2 (BCG_TYPE_BLOCK, BCG_TYPE_NATURAL);

extern void BCG_READ_PADDING BCG_ARG_1 (BCG_TYPE_NATURAL);

#ifdef BCG_UNDEFINED
{
#endif

#ifdef __cplusplus
}
#endif

#endif
