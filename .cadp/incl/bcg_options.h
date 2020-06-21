/******************************************************************************
 *                                B C G
 *-----------------------------------------------------------------------------
 *   INRIA - Unite de Recherche Rhone-Alpes
 *   655, avenue de l'Europe
 *   38330 Montbonnot Saint Martin
 *   FRANCE
 *-----------------------------------------------------------------------------
 *   Module             :       bcg_options.h
 *   Auteurs            :       Renaud RUFFIOT et Hubert GARAVEL
 *   Version            :       1.12
 *   Date               :       2009/11/24 12:49:20
 *****************************************************************************/

#ifndef BCG_OPTIONS_INTERFACE

#define BCG_OPTIONS_INTERFACE

#ifdef __cplusplus
extern "C" {
#endif

#ifdef BCG_UNDEFINED
}
#endif

#include "bcg_standard.h"
#include "bcg_types.h"

typedef BCG_TYPE_NATURAL BCG_TYPE_OPTION_SET;

#define BCG_READ_OPTIONS	((BCG_TYPE_OPTION_SET) 1)
#define BCG_WRITE_OPTIONS	((BCG_TYPE_OPTION_SET) 2)
#define BCG_DYNAMIC_LIB_OPTIONS	((BCG_TYPE_OPTION_SET) 4)

typedef struct bcg_struct_cell_string *BCG_TYPE_OPTION_LIST;

extern void BCG_INIT_OPTIONS BCG_ARG_0 ();

extern BCG_TYPE_GENUINE_INT BCG_PARSE_OPTION BCG_ARG_3 (BCG_TYPE_GENUINE_INT, char **, BCG_TYPE_OPTION_SET);

extern BCG_TYPE_OPTION_LIST BCG_GET_OPTION_LIST BCG_ARG_0 ();

extern BCG_TYPE_C_STRING BCG_GET_OPTION BCG_ARG_1 (BCG_TYPE_OPTION_LIST);

extern BCG_TYPE_OPTION_LIST BCG_NEXT_OPTION BCG_ARG_1 (BCG_TYPE_OPTION_LIST);

extern BCG_TYPE_BOOLEAN BCG_GET_REMOVE_LIB BCG_ARG_0 ();

extern void BCG_SET_REMOVE_LIB BCG_ARG_1 (BCG_PROMOTE_TO_INT (BCG_TYPE_BOOLEAN));

extern BCG_TYPE_BOOLEAN BCG_GET_UPDATE_LIB BCG_ARG_0 ();

extern BCG_TYPE_BOOLEAN BCG_PRESENT_COMPRESSION BCG_ARG_0 ();

extern BCG_TYPE_NATURAL BCG_GET_COMPRESSION BCG_ARG_0 ();

extern BCG_TYPE_C_STRING BCG_GET_CC BCG_ARG_0 ();

extern BCG_TYPE_C_STRING BCG_GET_ACTUAL_CC BCG_ARG_0 ();

extern BCG_TYPE_C_STRING BCG_GET_CFLAGS BCG_ARG_0 ();

extern BCG_TYPE_NATURAL BCG_GET_REGISTER_SIZE BCG_ARG_0 ();

extern BCG_TYPE_NATURAL BCG_GET_SHORT_SIZE BCG_ARG_0 ();

extern BCG_TYPE_NATURAL BCG_GET_MEDIUM_SIZE BCG_ARG_0 ();

extern void BCG_SET_DEFAULT_COMPRESSION BCG_ARG_1 (BCG_TYPE_NATURAL);

extern void BCG_SET_DEFAULT_REGISTER_SIZE BCG_ARG_1 (BCG_TYPE_NATURAL);

extern void BCG_SET_DEFAULT_SHORT_SIZE BCG_ARG_1 (BCG_TYPE_NATURAL);

extern void BCG_SET_DEFAULT_MEDIUM_SIZE BCG_ARG_1 (BCG_TYPE_NATURAL);

extern BCG_TYPE_C_STRING BCG_GET_TMP BCG_ARG_0 ();

extern BCG_TYPE_BOOLEAN BCG_GET_DEBUG BCG_ARG_0 ();

#ifdef BCG_UNDEFINED
{
#endif

#ifdef __cplusplus
}
#endif

#endif
