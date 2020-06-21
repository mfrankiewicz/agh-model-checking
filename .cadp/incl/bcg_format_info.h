/******************************************************************************
 *                                B C G
 *-----------------------------------------------------------------------------
 *   INRIA - Unite de Recherche Rhone-Alpes
 *   655, avenue de l'Europe
 *   38330 Montbonnot Saint Martin
 *   FRANCE
 *-----------------------------------------------------------------------------
 *   Module             :       bcg_format_info.h
 *   Auteurs            :       Renaud RUFFIOT et Hubert GARAVEL
 *   Version            :       1.5
 *   Date               :       2014/08/27 09:51:22
 *****************************************************************************/

#ifndef BCG_FORMAT_INFO_INTERFACE

#define BCG_FORMAT_INFO_INTERFACE

#ifdef __cplusplus
extern "C" {
#endif

#ifdef BCG_UNDEFINED
}
#endif

typedef struct bcg_struct_profile_format {
     BCG_TYPE_C_STRING bcg_begin;
     BCG_TYPE_C_STRING bcg_separator;
     BCG_TYPE_C_STRING bcg_end;
}    bcg_body_profile_format, *bcg_type_profile_format;

#define bcg_nb_profile_formats 3

#ifdef BCG_DYNAMIC_LIBRARY

/*
 * on est a l'interieur de la bibliotheque dynamique : on doit definir
 * bcg_profile_format ici-meme afin qu'il soit renomme par bcg_expand
 */

static bcg_body_profile_format bcg_profile_format[bcg_nb_profile_formats] = {
     {"", "", ""},
     {"", " !", ""},
     {"{", ", ", "}"}
};

#else

/*
 * on est dans le cas ordinaire (soit dans les bibliotheques libBCG.a ou
 * libBCG_IO.a, soit dans un outil qui utilise ces bibliotheques)
 */

extern bcg_body_profile_format bcg_profile_format[  ];

#endif

#ifdef BCG_UNDEFINED
{
#endif

#ifdef __cplusplus
}
#endif

#endif
