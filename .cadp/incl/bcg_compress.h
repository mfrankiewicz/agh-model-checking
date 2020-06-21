/******************************************************************************
 *                                B C G
 *-----------------------------------------------------------------------------
 *   INRIA - Unite de Recherche Rhone-Alpes
 *   655, avenue de l'Europe
 *   38330 Montbonnot Saint Martin
 *   FRANCE
 *-----------------------------------------------------------------------------
 *   Module             :       bcg_compress.h
 *   Auteur             :       Renaud RUFFIOT
 *   Version            :       1.3
 *   Date               :       2013/09/09 11:33:40
 *****************************************************************************/

#ifndef BCG_COMPRESS_INTERFACE

#define BCG_COMPRESS_INTERFACE

#ifdef __cplusplus
extern "C" {
#endif

#ifdef BCG_UNDEFINED
}
#endif

#include "bcg_types.h"
#include "bcg_standard.h"

extern void BCG_COMPRESS BCG_ARG_3 (BCG_TYPE_BLOCK, BCG_TYPE_NATURAL, BCG_TYPE_NATURAL);

extern void BCG_DECOMPRESS BCG_ARG_3 (BCG_TYPE_BLOCK, BCG_TYPE_NATURAL, BCG_TYPE_NATURAL);

#ifdef BCG_UNDEFINED
{
#endif

#ifdef __cplusplus
}
#endif

#endif
