/******************************************************************************
 *                                B C G
 *-----------------------------------------------------------------------------
 *   INRIA - Unite de Recherche Rhone-Alpes
 *   655, avenue de l'Europe
 *   38330 Montbonnot Saint Martin
 *   FRANCE
 *-----------------------------------------------------------------------------
 *   Module             :       bcg_name.h
 *   Auteurs            :       R. RUFFIOT, R. MATEESCU, H. GARAVEL et F. LANG
 *   Version            :       1.6
 *   Date               :       2014/07/31 08:37:38
 *****************************************************************************/

#ifndef BCG_NAME_INTERFACE

#define BCG_NAME_INTERFACE

#ifdef __cplusplus
extern "C" {
#endif

#ifdef BCG_UNDEFINED
}
#endif

#define BCG_DEFAULT_FILE_INDEX 0

extern void BCG_PRINT_SIMPLE_NAME BCG_ARG_3 (BCG_TYPE_STREAM, BCG_TYPE_BCG_OBJECT, BCG_TYPE_NAME_NUMBER);

extern void BCG_PRINT_NAME BCG_ARG_3 (BCG_TYPE_STREAM, BCG_TYPE_BCG_OBJECT, BCG_TYPE_NAME_NUMBER);

extern void BCG_PRINT_PROFILE_HEADER BCG_ARG_4 (BCG_TYPE_STREAM, BCG_TYPE_PROFILE_NUMBER, BCG_TYPE_NATURAL, BCG_TYPE_BCG_OBJECT);

#ifdef BCG_UNDEFINED
{
#endif

#ifdef __cplusplus
}
#endif

#endif
