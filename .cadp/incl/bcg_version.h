/******************************************************************************
 *                                B C G
 *-----------------------------------------------------------------------------
 *   INRIA - Unite de Recherche Rhone-Alpes
 *   655, avenue de l'Europe
 *   38330 Montbonnot Saint Martin
 *   FRANCE
 *-----------------------------------------------------------------------------
 *   Module             :       bcg_version.h
 *   Auteur             :       Hubert GARAVEL
 *   Version            :       1.26
 *   Date               :       2017/12/05 17:49:46
 *****************************************************************************/

#ifndef BCG_VERSION_INTERFACE

#define BCG_VERSION_INTERFACE

#ifdef __cplusplus
extern "C" {
#endif

#ifdef BCG_UNDEFINED
}
#endif

#include "bcg_standard.h"

typedef unsigned short BCG_TYPE_VERSION;

#define BCG_VERSION_FORMAT_1_0	100	
#define BCG_VERSION_FORMAT_1_1	101	
#define BCG_VERSION_FORMAT_1_2	102	

#define BCG_CURRENT_VERSION BCG_VERSION_FORMAT_1_2

#if BCG_CURRENT_VERSION == BCG_VERSION_FORMAT_1_0
#define BCG_CURRENT_MAJOR_VERSION_NUMBER ((BCG_TYPE_BYTE) 1)
#define BCG_CURRENT_MINOR_VERSION_NUMBER ((BCG_TYPE_BYTE) 0)

#elif BCG_CURRENT_VERSION == BCG_VERSION_FORMAT_1_1
#define BCG_CURRENT_MAJOR_VERSION_NUMBER ((BCG_TYPE_BYTE) 1)
#define BCG_CURRENT_MINOR_VERSION_NUMBER ((BCG_TYPE_BYTE) 1)

#elif BCG_CURRENT_VERSION == BCG_VERSION_FORMAT_1_2
#define BCG_CURRENT_MAJOR_VERSION_NUMBER ((BCG_TYPE_BYTE) 1)
#define BCG_CURRENT_MINOR_VERSION_NUMBER ((BCG_TYPE_BYTE) 2)

#else
...
#endif

extern void BCG_SET_WRITE_VERSION BCG_ARG_3 (BCG_TYPE_BCG_FILE, BCG_TYPE_BYTE *, BCG_TYPE_BYTE *);

extern void BCG_SET_READ_VERSION BCG_ARG_3 (BCG_TYPE_BCG_FILE, BCG_PROMOTE_TO_INT (BCG_TYPE_BYTE), BCG_PROMOTE_TO_INT (BCG_TYPE_BYTE));

extern void BCG_GET_VERSION BCG_ARG_3 (BCG_TYPE_BCG_FILE, BCG_TYPE_BYTE *, BCG_TYPE_BYTE *);

#define BCG_VERSION_BCG_LIB	1.8

#define BCG_VERSION_BCG_IO	1.8

#define BCG_VERSION_BCG_OPEN	1.8

#define BCG_VERSION_BCG_DRAW	1.8

#define BCG_VERSION_BCG_EDIT	1.8

#define BCG_VERSION_BCG_INFO	1.8

#define BCG_VERSION_BCG_LABELS  1.8

#define BCG_VERSION_BCG_GRAPH   1.8

#define BCG_VERSION_BCG_MIN     1.8

#define BCG_VERSION_BCG_STEADY  1.8

#define BCG_VERSION_BCG_TRANSIENT  1.8

#ifdef BCG_UNDEFINED
{
#endif

#ifdef __cplusplus
}
#endif

#endif
