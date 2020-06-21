/******************************************************************************
 *                                B C G
 *-----------------------------------------------------------------------------
 *   INRIA - Unite de Recherche Rhone-Alpes
 *   655, avenue de l'Europe
 *   38330 Montbonnot Saint Martin
 *   FRANCE
 *-----------------------------------------------------------------------------
 *   Module             :       bcg_temporary.h
 *   Auteurs            :       Renaud RUFFIOT et Hubert GARAVEL
 *   Version            :       1.4
 *   Date               :       2004/07/07 18:39:49
 *****************************************************************************/

#ifndef BCG_TEMPORARY_INTERFACE

#define BCG_TEMPORARY_INTERFACE

#ifdef __cplusplus
extern "C" {
#endif

#ifdef BCG_UNDEFINED
}
#endif

#include "bcg_standard.h"
#include "bcg_types.h"

extern BCG_TYPE_C_STRING BCG_TEMPORARY_FILE BCG_ARG_1 (BCG_TYPE_C_STRING);

extern void BCG_UNLINK BCG_ARG_1 (BCG_TYPE_C_STRING);

extern void BCG_CLEANUP BCG_ARG_0 ();

#ifdef BCG_UNDEFINED
{
#endif

#ifdef __cplusplus
}
#endif

#endif
