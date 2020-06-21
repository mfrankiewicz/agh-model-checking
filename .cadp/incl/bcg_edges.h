/******************************************************************************
 *                                B C G
 *-----------------------------------------------------------------------------
 *   INRIA - Unite de Recherche Rhone-Alpes
 *   655, avenue de l'Europe
 *   38330 Montbonnot Saint Martin
 *   FRANCE
 *-----------------------------------------------------------------------------
 *   Module             :       bcg_edges.h
 *   Auteurs            :       Renaud RUFFIOT et Hubert GARAVEL
 *   Version            :       1.17
 *   Date               :       2010/02/25 18:43:21
 *****************************************************************************/

#ifndef BCG_EDGES_INTERFACE

#define BCG_EDGES_INTERFACE

#ifdef __cplusplus
extern "C" {
#endif

#ifdef BCG_UNDEFINED
}
#endif

#include "bcg_standard.h"
#include "bcg_types.h"

extern void BCG_INIT_READ_EDGES BCG_ARG_1 (BCG_TYPE_BCG_FILE);

extern void BCG_TERM_READ_EDGES BCG_ARG_1 (BCG_TYPE_BCG_FILE);

extern BCG_TYPE_EDGE_NUMBER BCG_GET_NB_EDGES BCG_ARG_1 (BCG_TYPE_BCG_FILE);

extern void BCG_CHECK_NB_EDGES BCG_ARG_2 (BCG_TYPE_BCG_FILE, BCG_TYPE_EDGE_NUMBER);

extern BCG_TYPE_LABEL_NUMBER BCG_GET_NB_LABELS BCG_ARG_1 (BCG_TYPE_BCG_FILE);

extern void BCG_GET_COMPRESSION_PARAMETERS BCG_ARG_5 (BCG_TYPE_BCG_FILE, BCG_TYPE_NATURAL *, BCG_TYPE_NATURAL *, BCG_TYPE_NATURAL *, BCG_TYPE_NATURAL *);

extern void BCG_INIT_WRITE_EDGES BCG_ARG_2 (BCG_TYPE_BCG_FILE, BCG_TYPE_NATURAL);

extern void BCG_TERM_WRITE_EDGES BCG_ARG_1 (BCG_TYPE_BCG_FILE);

extern void BCG_READ_EDGE BCG_ARG_4 (BCG_TYPE_BCG_FILE, BCG_TYPE_STATE_NUMBER *, BCG_TYPE_LABEL_NUMBER *, BCG_TYPE_STATE_NUMBER *);

extern void BCG_WRITE_EDGE BCG_ARG_4 (BCG_TYPE_BCG_FILE, BCG_TYPE_STATE_NUMBER, BCG_TYPE_LABEL_NUMBER, BCG_TYPE_STATE_NUMBER);

extern void BCG_COPY_EDGE_AREA BCG_ARG_6 (BCG_TYPE_BCG_FILE, BCG_PROMOTE_TO_INT (BCG_TYPE_BYTE), BCG_PROMOTE_TO_INT (BCG_TYPE_BYTE), BCG_TYPE_BCG_FILE, BCG_PROMOTE_TO_INT (BCG_TYPE_BYTE), BCG_PROMOTE_TO_INT (BCG_TYPE_BYTE));

#ifdef BCG_UNDEFINED
{
#endif

#ifdef __cplusplus
}
#endif

#endif
