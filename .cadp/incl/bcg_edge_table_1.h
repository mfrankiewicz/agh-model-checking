/******************************************************************************
 *                                B C G
 *-----------------------------------------------------------------------------
 *   INRIA - Unite de Recherche Rhone-Alpes
 *   655, avenue de l'Europe
 *   38330 Montbonnot Saint Martin
 *   FRANCE
 *-----------------------------------------------------------------------------
 *   Module             :       bcg_edge_table_1.h
 *   Auteurs            :       Renaud RUFFIOT et Hubert GARAVEL
 *   Version            :       1.10
 *   Date               :       2009/03/10 14:06:03
 *****************************************************************************/

#ifndef BCG_EDGE_TABLE_1_INTERFACE

#define BCG_EDGE_TABLE_1_INTERFACE

#ifdef __cplusplus
extern "C" {
#endif

#ifdef BCG_UNDEFINED
}
#endif

#include "bcg_standard.h"
#include "bcg_types.h"
#include "bcg_binary_table.h"

typedef enum bcg_enum_type_structure {
     bcg_succ_structure,
     bcg_pred_structure
}    bcg_type_type_structure;

typedef struct bcg_struct_edge_table_1 {
     BCG_TYPE_BINARY_ARRAY bcg_index;
     BCG_TYPE_BINARY_TABLE bcg_table;
     BCG_TYPE_EDGE_NUMBER bcg_nb_edges;
     BCG_TYPE_STATE_NUMBER bcg_nb_states;
     bcg_type_type_structure bcg_type_structure;
}    BCG_BODY_EDGE_TABLE_1, *BCG_TYPE_EDGE_TABLE_1;

typedef struct bcg_struct_et1_iterator {
     BCG_TYPE_EDGE_TABLE_1 bcg_edge_table;
     BCG_TYPE_STATE_NUMBER bcg_current_state;
     BCG_TYPE_EDGE_NUMBER bcg_last_edge_of_state;
     /*
      * en fait, bcg_last_edge_of_state est la premiere transition du
      * prochain etat qui des transitions entrantes ou sortantes
      */
     BCG_TYPE_EDGE_NUMBER bcg_edge_number;
     BCG_TYPE_EDGE *bcg_edge_buffer;
     BCG_TYPE_BOOLEAN bcg_given_state;
}    BCG_TYPE_ET1_ITERATOR, *bcg_type_et1_iterator;

extern void BCG_CREATE_EDGE_TABLE_1 BCG_ARG_5 (BCG_TYPE_OBJECT_TRANSITION, BCG_PROMOTE_TO_INT (BCG_TYPE_BOOLEAN), BCG_TYPE_EDGE_TABLE_1 *, BCG_PROMOTE_TO_INT (BCG_TYPE_BOOLEAN), BCG_TYPE_EDGE_TABLE_1 *);

extern void BCG_DELETE_EDGE_TABLE_1 BCG_ARG_1 (BCG_TYPE_EDGE_TABLE_1 *);

extern void BCG_ET1_START_1 BCG_ARG_5 (BCG_TYPE_ET1_ITERATOR *, BCG_TYPE_EDGE_TABLE_1, BCG_TYPE_EDGE *, BCG_TYPE_STATE_NUMBER, BCG_PROMOTE_TO_INT (BCG_TYPE_BOOLEAN));

extern void BCG_ET1_NEXT BCG_ARG_1 (BCG_TYPE_ET1_ITERATOR *);

#ifdef BCG_UNDEFINED
{
#endif

#ifdef __cplusplus
}
#endif

#endif
