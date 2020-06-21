/******************************************************************************
 *                                B C G
 *-----------------------------------------------------------------------------
 *   INRIA - Unite de Recherche Rhone-Alpes
 *   655, avenue de l'Europe
 *   38330 Montbonnot Saint Martin
 *   FRANCE
 *-----------------------------------------------------------------------------
 *   Module             :       bcg_edge_sort.h
 *   Auteurs            :       Renaud RUFFIOT et Hubert GARAVEL
 *   Version            :       1.6
 *   Date               :       2008/05/27 10:56:34
 *****************************************************************************/

#ifndef BCG_EDGE_SORT_INTERFACE

#define BCG_EDGE_SORT_INTERFACE

#ifdef __cplusplus
extern "C" {
#endif

#ifdef BCG_UNDEFINED
}
#endif

typedef enum bcg_enum_edge_sort {
     BCG_UNDEFINED_SORT,
     BCG_P_SORT,
     BCG_L_SORT,
     BCG_N_SORT,
     BCG_PL_SORT,
     BCG_PN_SORT,
     BCG_LP_SORT,
     BCG_LN_SORT,
     BCG_NP_SORT,
     BCG_NL_SORT,
     BCG_PLN_SORT,
     BCG_PNL_SORT,
     BCG_LPN_SORT,
     BCG_LNP_SORT,
     BCG_NPL_SORT,
     BCG_NLP_SORT
}    BCG_TYPE_EDGE_SORT;

#define BCG_NB_SORTS 16

#define BCG_SORT_NUMBER(bcg_sort) ((short int) (bcg_sort))

typedef BCG_TYPE_NATURAL bcg_type_sort_set;

extern bcg_type_sort_set BCG_SORT_SET[BCG_NB_SORTS];

#ifdef BCG_UNDEFINED
{
#endif

#ifdef __cplusplus
}
#endif

#endif
