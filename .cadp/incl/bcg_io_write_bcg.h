/******************************************************************************
 *                                B C G
 *-----------------------------------------------------------------------------
 *   INRIA - Unite de Recherche Rhone-Alpes
 *   655, avenue de l'Europe
 *   38330 Montbonnot Saint Martin
 *   FRANCE
 *-----------------------------------------------------------------------------
 *   Module             :       bcg_io_write_bcg.h
 *   Auteurs            :       Renaud RUFFIOT et Hubert GARAVEL
 *   Version            :       1.19
 *   Date               :       2014/10/03 14:42:52
 *****************************************************************************/

#ifndef BCG_IO_WRITE_BCG_INTERFACE

#define BCG_IO_WRITE_BCG_INTERFACE

#ifdef __cplusplus
extern "C" {
#endif

#ifdef BCG_UNDEFINED
}
#endif

#include "bcg_standard.h"
#include "bcg_types.h"

extern void BCG_IO_WRITE_BCG_SURVIVE BCG_ARG_1 (BCG_PROMOTE_TO_INT (BCG_TYPE_BOOLEAN));

extern BCG_TYPE_BOOLEAN BCG_IO_WRITE_BCG_BEGIN BCG_ARG_5 (BCG_TYPE_FILE_NAME, BCG_TYPE_STATE_NUMBER, BCG_TYPE_NATURAL, BCG_TYPE_C_STRING, BCG_PROMOTE_TO_INT (BCG_TYPE_BOOLEAN));

extern void BCG_IO_WRITE_BCG_END BCG_ARG_0 ();

extern void BCG_IO_WRITE_BCG_ABORT BCG_ARG_0 ();

extern void BCG_IO_WRITE_BCG_EDGE BCG_ARG_3 (BCG_TYPE_STATE_NUMBER, BCG_TYPE_LABEL_STRING, BCG_TYPE_STATE_NUMBER);

extern void BCG_IO_WRITE_BCG_PARSING BCG_ARG_1 (BCG_TYPE_DATA_FORMAT);

extern void BCG_IO_WRITE_BCG_MONITORING BCG_ARG_2 (BCG_TYPE_STATE_NUMBER (*) (), BCG_TYPE_STATE_NUMBER (*) ());

#ifdef BCG_UNDEFINED
{
#endif

#ifdef __cplusplus
}
#endif

#endif
