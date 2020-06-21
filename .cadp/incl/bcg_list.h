/******************************************************************************
 *                                B C G
 *-----------------------------------------------------------------------------
 *   INRIA - Unite de Recherche Rhone-Alpes
 *   655, avenue de l'Europe
 *   38330 Montbonnot Saint Martin
 *   FRANCE
 *-----------------------------------------------------------------------------
 *   Module             :       bcg_list.h
 *   Auteurs            :       Renaud RUFFIOT, Radu MATEESCU et Hubert GARAVEL
 *   Version            :       1.8
 *   Date               :       2014/07/31 08:39:19
 *****************************************************************************/

#ifndef BCG_LIST_INTERFACE

#define BCG_LIST_INTERFACE

#ifdef __cplusplus
extern "C" {
#endif

#ifdef BCG_UNDEFINED
}
#endif

typedef BCG_TYPE_NATURAL BCG_TYPE_LIST_INDEX;

typedef struct bcg_struct_list_cell {
     BCG_TYPE_ADDRESS bcg_item_address;
     struct bcg_struct_list_cell *bcg_next;
}    bcg_body_list_cell, *bcg_type_list_cell;

typedef struct {
     BCG_TYPE_LIST_INDEX bcg_nb_items;
     bcg_type_list_cell bcg_first_cell;
     bcg_type_list_cell bcg_last_cell;
}    bcg_body_list_structure, *bcg_type_list_structure;

typedef bcg_type_list_structure BCG_TYPE_LIST;

extern void BCG_LIST_CREATE BCG_ARG_1 (BCG_TYPE_LIST *);

extern void BCG_LIST_ADD BCG_ARG_2 (BCG_TYPE_LIST, BCG_TYPE_ADDRESS);

extern BCG_TYPE_ADDRESS BCG_LIST_SEARCH BCG_ARG_2 (BCG_TYPE_LIST, BCG_TYPE_LIST_INDEX);

extern BCG_TYPE_LIST_INDEX BCG_LIST_CARDINAL BCG_ARG_1 (BCG_TYPE_LIST);

extern BCG_TYPE_COMPARISON_RESULT BCG_LIST_COMPARE BCG_ARG_3 (BCG_TYPE_LIST, BCG_TYPE_LIST, BCG_TYPE_COMPARISON_RESULT (*) ());

extern void BCG_LIST_DELETE BCG_ARG_1 (BCG_TYPE_LIST *);

#define BCG_LIST_ITER(bcg_list,bcg_address,bcg_cast) \
	bcg_type_list_cell  bcg_cell; \
	for (bcg_cell = bcg_list->bcg_first_cell; \
	     (bcg_address) =  (bcg_cell != NULL) ? \
			(bcg_cast) bcg_cell->bcg_item_address : \
			(bcg_cast) NULL, \
	        bcg_cell != NULL; \
	     bcg_cell = bcg_cell->bcg_next)

#ifdef BCG_UNDEFINED
{
#endif

#ifdef __cplusplus
}
#endif

#endif
