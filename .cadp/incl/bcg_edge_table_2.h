/******************************************************************************
 *                                B C G
 *-----------------------------------------------------------------------------
 *   INRIA - Unite de Recherche Rhone-Alpes
 *   655, avenue de l'Europe
 *   38330 Montbonnot Saint Martin
 *   FRANCE
 *-----------------------------------------------------------------------------
 *   Module             :       bcg_edge_table_2.h
 *   Auteurs            :       Renaud RUFFIOT et Hubert GARAVEL
 *   Version            :       1.13
 *   Date               :       2014/12/17 13:18:49
 *****************************************************************************/

#ifndef BCG_EDGE_TABLE_2_INTERFACE

#define BCG_EDGE_TABLE_2_INTERFACE

#ifdef __cplusplus
extern "C" {
#endif

#ifdef BCG_UNDEFINED
}
#endif

#include "bcg_standard.h"
#include "bcg_types.h"

#include "bcg_binary_table.h"
#include "bcg_edge_sort.h"

typedef enum bcg_enum_kind_table {
     bcg_kind_table,
     bcg_kind_index
}    bcg_type_kind_table;

typedef struct bcg_struct_main_table {
     BCG_TYPE_BINARY_TABLE bcg_table;
     BCG_TYPE_EDGE_NUMBER bcg_nb_edges;
     BCG_TYPE_STATE_NUMBER bcg_nb_states;
     BCG_TYPE_LABEL_NUMBER bcg_nb_labels;
     BCG_TYPE_NATURAL bcg_nb_references;
}    bcg_body_main_table, *bcg_type_main_table;

typedef struct bcg_struct_edge_table_2 {
     bcg_type_kind_table bcg_type;
     bcg_type_main_table bcg_main_table;
     BCG_TYPE_BINARY_ARRAY bcg_index;
     BCG_TYPE_BINARY_ARRAY bcg_direct_index;
     BCG_TYPE_NATURAL bcg_key_field_1;
     BCG_TYPE_NATURAL bcg_key_field_2;
     BCG_TYPE_NATURAL bcg_key_field_3;
     BCG_TYPE_EDGE_SORT bcg_edge_sort;
}    BCG_BODY_EDGE_TABLE_2, *BCG_TYPE_EDGE_TABLE_2;

typedef struct bcg_struct_et2_iterator {
     BCG_TYPE_EDGE_TABLE_2 bcg_edge_table;
     BCG_TYPE_EDGE_NUMBER bcg_edge_number;
     BCG_TYPE_EDGE_NUMBER bcg_index_number;
     BCG_TYPE_EDGE *bcg_edge_buffer;
}    BCG_TYPE_ET2_ITERATOR, *bcg_type_et2_iterator;

extern void BCG_CREATE_EDGE_TABLE_2 BCG_ARG_3 (BCG_TYPE_EDGE_TABLE_2 *, BCG_TYPE_OBJECT_TRANSITION, BCG_TYPE_EDGE_SORT);

extern void BCG_CREATE_EDGE_INDEX_2 BCG_ARG_3 (BCG_TYPE_EDGE_TABLE_2 *, BCG_TYPE_EDGE_TABLE_2, BCG_TYPE_EDGE_SORT);

extern void BCG_DELETE_EDGE_TABLE_2 BCG_ARG_1 (BCG_TYPE_EDGE_TABLE_2 *);

extern void BCG_ET2_START_0 BCG_ARG_3 (BCG_TYPE_ET2_ITERATOR *, BCG_TYPE_EDGE_TABLE_2, BCG_TYPE_EDGE *);

extern void BCG_ET2_START_1 BCG_ARG_4 (BCG_TYPE_ET2_ITERATOR *, BCG_TYPE_EDGE_TABLE_2, BCG_TYPE_EDGE *, BCG_TYPE_LONG_NATURAL);

extern void BCG_ET2_START_2 BCG_ARG_5 (BCG_TYPE_ET2_ITERATOR *, BCG_TYPE_EDGE_TABLE_2, BCG_TYPE_EDGE *, BCG_TYPE_LONG_NATURAL, BCG_TYPE_LONG_NATURAL);

extern void BCG_ET2_START_3 BCG_ARG_6 (BCG_TYPE_ET2_ITERATOR *, BCG_TYPE_EDGE_TABLE_2, BCG_TYPE_EDGE *, BCG_TYPE_LONG_NATURAL, BCG_TYPE_LONG_NATURAL, BCG_TYPE_LONG_NATURAL);

extern void BCG_ET2_START_I BCG_ARG_4 (BCG_TYPE_ET2_ITERATOR *, BCG_TYPE_EDGE_TABLE_2, BCG_TYPE_EDGE *, BCG_TYPE_EDGE_NUMBER);

extern void BCG_ET2_NEXT BCG_ARG_1 (BCG_TYPE_ET2_ITERATOR *);

#define bcg_et2_type(bcg_edge_table) \
	((bcg_edge_table)->bcg_type)

#define bcg_et2_main_table(bcg_edge_table) \
	((bcg_edge_table)->bcg_main_table)

#define bcg_et2_index(bcg_edge_table) \
	((bcg_edge_table)->bcg_index)

#define bcg_et2_direct_index(bcg_edge_table) \
	((bcg_edge_table)->bcg_direct_index)

#define bcg_et2_edge_sort(bcg_edge_table) \
	((bcg_edge_table)->bcg_edge_sort)

#define bcg_et2_nb_edges(bcg_edge_table) \
	(bcg_et2_main_table(bcg_edge_table)->bcg_nb_edges)

#define bcg_et2_nb_states(bcg_edge_table) \
	(bcg_et2_main_table(bcg_edge_table)->bcg_nb_states)

#define bcg_et2_nb_labels(bcg_edge_table) \
	(bcg_et2_main_table(bcg_edge_table)->bcg_nb_labels)

#define bcg_et2_nb_references(bcg_edge_table) \
	(bcg_et2_main_table(bcg_edge_table)->bcg_nb_references)

#define bcg_et2_table(bcg_edge_table) \
	(bcg_et2_main_table(bcg_edge_table)->bcg_table)

#ifdef BCG_UNDEFINED
{
#endif

#ifdef __cplusplus
}
#endif

#endif
