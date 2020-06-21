/******************************************************************************
 *                                B C G
 *-----------------------------------------------------------------------------
 *   INRIA - Unite de Recherche Rhone-Alpes
 *   655, avenue de l'Europe
 *   38330 Montbonnot Saint Martin
 *   FRANCE
 *-----------------------------------------------------------------------------
 *   Module             :       bcg_transition.h
 *   Auteurs            :       Renaud RUFFIOT et Hubert GARAVEL
 *   Version            :       1.26
 *   Date               :       2011/03/21 18:52:55
 *****************************************************************************/

#ifndef BCG_TRANSITION_INTERFACE

#define BCG_TRANSITION_INTERFACE

#ifdef __cplusplus
extern "C" {
#endif

#ifdef BCG_UNDEFINED
}
#endif

#include "bcg_standard.h"
#include "bcg_types.h"
#include "bcg_edge_sort.h"
#include "bcg_structure_2.h"
#include "bcg_iterator.h"

typedef struct bcg_struct_object_transition *BCG_TYPE_OBJECT_TRANSITION;

#include "bcg_edge_table_1.h"
#include "bcg_edge_table_2.h"

typedef enum bcg_enum_code_object {
     bcg_code_bcg_file = 0,
     bcg_code_edge_table_1 = 1,
     bcg_code_edge_table_2 = 2
} bcg_type_code_object;

typedef struct bcg_struct_bcg_file_iterator {
     BCG_TYPE_EDGE_NUMBER bcg_nb_edges;
}    bcg_body_bcg_file_iterator, *bcg_type_bcg_file_iterator;

#define BCG_SUCCESSOR    ((BCG_TYPE_32_BITS_INT) 1)
#define BCG_PREDECESSOR  ((BCG_TYPE_32_BITS_INT) 2)

typedef struct bcg_struct_ot_iterator {
     BCG_TYPE_OBJECT_TRANSITION bcg_object_transition;
     bcg_body_bcg_file_iterator bcg_bcg_file_iterator;
     BCG_TYPE_ET1_ITERATOR bcg_et1_iterator;
     BCG_TYPE_ET2_ITERATOR bcg_et2_iterator;
     BCG_TYPE_EDGE bcg_edge_buffer;
}    bcg_body_ot_iterator, *bcg_type_ot_iterator;

typedef bcg_body_ot_iterator BCG_TYPE_OT_ITERATOR;

extern BCG_TYPE_STATE_NUMBER BCG_OT_INITIAL_STATE (BCG_TYPE_OBJECT_TRANSITION);

extern BCG_TYPE_EDGE_NUMBER BCG_OT_NB_EDGES (BCG_TYPE_OBJECT_TRANSITION);

extern BCG_TYPE_LABEL_NUMBER BCG_OT_NB_LABELS (BCG_TYPE_OBJECT_TRANSITION);

extern BCG_TYPE_STATE_NUMBER BCG_OT_NB_STATES (BCG_TYPE_OBJECT_TRANSITION);

extern void BCG_CREATE_OBJECT_TRANSITION BCG_ARG_3 (BCG_TYPE_BCG_FILE, BCG_TYPE_BCG_OBJECT, BCG_TYPE_OBJECT_TRANSITION *);

extern void BCG_CREATE_OBJECT_TRANSITION_ET1 BCG_ARG_4 (BCG_TYPE_BCG_FILE, BCG_TYPE_BCG_OBJECT, BCG_TYPE_OBJECT_TRANSITION *, BCG_TYPE_NATURAL);

extern void BCG_CREATE_OBJECT_TRANSITION_ET2 BCG_ARG_5 (BCG_TYPE_BCG_FILE, BCG_TYPE_BCG_OBJECT, BCG_TYPE_OBJECT_TRANSITION *, BCG_TYPE_NATURAL,...);

extern void BCG_DELETE_OBJECT_TRANSITION BCG_ARG_1 (BCG_TYPE_OBJECT_TRANSITION *);

extern BCG_TYPE_EDGE_SORT BCG_OT_EDGE_SORT BCG_ARG_1 (BCG_TYPE_OBJECT_TRANSITION);

extern BCG_TYPE_BOOLEAN BCG_OT_SORT_BY BCG_ARG_2 (BCG_TYPE_OBJECT_TRANSITION, BCG_TYPE_EDGE_SORT);

extern void BCG_OT_START BCG_ARG_3 (BCG_TYPE_OT_ITERATOR *, BCG_TYPE_OBJECT_TRANSITION, BCG_TYPE_EDGE_SORT);

extern void BCG_OT_START_P BCG_ARG_4 (BCG_TYPE_OT_ITERATOR *, BCG_TYPE_OBJECT_TRANSITION, BCG_TYPE_EDGE_SORT, BCG_TYPE_STATE_NUMBER);

extern void BCG_OT_START_L BCG_ARG_4 (BCG_TYPE_OT_ITERATOR *, BCG_TYPE_OBJECT_TRANSITION, BCG_TYPE_EDGE_SORT, BCG_TYPE_LABEL_NUMBER);

extern void BCG_OT_START_N BCG_ARG_4 (BCG_TYPE_OT_ITERATOR *, BCG_TYPE_OBJECT_TRANSITION, BCG_TYPE_EDGE_SORT, BCG_TYPE_STATE_NUMBER);

extern void BCG_OT_START_I BCG_ARG_3 (BCG_TYPE_OT_ITERATOR *, BCG_TYPE_OBJECT_TRANSITION, BCG_TYPE_EDGE_NUMBER);

extern void BCG_OT_NEXT BCG_ARG_1 (BCG_TYPE_OT_ITERATOR *);

extern void BCG_OT_STOP BCG_ARG_1 (BCG_TYPE_OT_ITERATOR *);

extern void BCG_OT_SET_CODE BCG_ARG_2 (BCG_TYPE_OBJECT_TRANSITION, bcg_type_code_object);

extern BCG_TYPE_BCG_FILE BCG_OT_GET_FILE BCG_ARG_1 (BCG_TYPE_OBJECT_TRANSITION);

extern BCG_TYPE_BCG_OBJECT BCG_OT_GET_OBJECT BCG_ARG_1 (BCG_TYPE_OBJECT_TRANSITION);

extern void BCG_OT_READ_BCG_SURVIVE BCG_ARG_1 (BCG_PROMOTE_TO_INT (BCG_TYPE_BOOLEAN));

extern void BCG_OT_READ_BCG_BEGIN BCG_ARG_3 (BCG_TYPE_FILE_NAME, BCG_TYPE_OBJECT_TRANSITION *, BCG_TYPE_NATURAL);

extern void BCG_OT_READ_BCG_END BCG_ARG_1 (BCG_TYPE_OBJECT_TRANSITION *);

extern BCG_TYPE_C_STRING BCG_OT_LABEL_STRING BCG_ARG_2 (BCG_TYPE_OBJECT_TRANSITION, BCG_TYPE_LABEL_NUMBER);

extern BCG_TYPE_BOOLEAN BCG_OT_LABEL_VISIBLE BCG_ARG_2 (BCG_TYPE_OBJECT_TRANSITION, BCG_TYPE_LABEL_NUMBER);

extern BCG_TYPE_C_STRING BCG_OT_LABEL_GATE BCG_ARG_2 (BCG_TYPE_OBJECT_TRANSITION, BCG_TYPE_LABEL_NUMBER);

extern BCG_TYPE_C_STRING BCG_OT_LABEL_HIDDEN_GATE BCG_ARG_2 (BCG_TYPE_OBJECT_TRANSITION, BCG_TYPE_LABEL_NUMBER);

extern BCG_TYPE_NATURAL BCG_OT_LABEL_CARDINAL BCG_ARG_2 (BCG_TYPE_OBJECT_TRANSITION, BCG_TYPE_LABEL_NUMBER);

#ifdef BCG_UNDEFINED
{
#endif

#ifdef __cplusplus
}
#endif

#endif
