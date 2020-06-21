/******************************************************************************
 *                                B C G
 *-----------------------------------------------------------------------------
 *   INRIA - Unite de Recherche Rhone-Alpes
 *   655, avenue de l'Europe
 *   38330 Montbonnot Saint Martin
 *   FRANCE
 *-----------------------------------------------------------------------------
 *   Module             :       bcg_states.h
 *   Auteurs            :       Renaud RUFFIOT et Hubert GARAVEL
 *   Version            :       1.11
 *   Date               :       2010/02/26 09:52:16
 *****************************************************************************/

#ifndef BCG_STATES_INTERFACE

#define BCG_STATES_INTERFACE

#ifdef __cplusplus
extern "C" {
#endif

#ifdef BCG_UNDEFINED
}
#endif

#include "bcg_standard.h"
#include "bcg_types.h"

extern void BCG_INIT_READ_STATES BCG_ARG_1 (BCG_TYPE_BCG_FILE);

extern void BCG_TERM_READ_STATES BCG_ARG_1 (BCG_TYPE_BCG_FILE);

extern BCG_TYPE_STATE_NUMBER BCG_GET_NB_STATES BCG_ARG_1 (BCG_TYPE_BCG_FILE);

extern BCG_TYPE_STATE_NUMBER BCG_GET_INITIAL_STATE BCG_ARG_1 (BCG_TYPE_BCG_FILE);

extern void BCG_CHECK_STATE_NUMBER BCG_ARG_2 (BCG_TYPE_BCG_FILE, BCG_TYPE_STATE_NUMBER);

extern void BCG_CHECK_NB_STATES BCG_ARG_2 (BCG_TYPE_BCG_FILE, BCG_TYPE_STATE_NUMBER);

extern void BCG_SEEK_STATE BCG_ARG_2 (BCG_TYPE_BCG_FILE, BCG_TYPE_STATE_NUMBER);

extern void BCG_INIT_WRITE_STATES BCG_ARG_2 (BCG_TYPE_BCG_FILE, BCG_TYPE_NATURAL);

extern void BCG_TERM_WRITE_STATES BCG_ARG_1 (BCG_TYPE_BCG_FILE);

extern void BCG_COPY_STATE_AREA BCG_ARG_6 (BCG_TYPE_BCG_FILE, BCG_PROMOTE_TO_INT (BCG_TYPE_BYTE), BCG_PROMOTE_TO_INT (BCG_TYPE_BYTE), BCG_TYPE_BCG_FILE, BCG_PROMOTE_TO_INT (BCG_TYPE_BYTE), BCG_PROMOTE_TO_INT (BCG_TYPE_BYTE));

#ifdef BCG_UNDEFINED
{
#endif

#ifdef __cplusplus
}
#endif

#endif
