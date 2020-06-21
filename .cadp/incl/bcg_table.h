/******************************************************************************
 *                                B C G
 *-----------------------------------------------------------------------------
 *   INRIA - Unite de Recherche Rhone-Alpes
 *   655, avenue de l'Europe
 *   38330 Montbonnot Saint Martin
 *   FRANCE
 *-----------------------------------------------------------------------------
 *   Module             :       bcg_table.h
 *   Auteurs            :       Renaud RUFFIOT et Hubert GARAVEL
 *   Version            :       1.8
 *   Date               :       2002/05/28 20:25:58
 *****************************************************************************/

#ifndef BCG_TABLE_INTERFACE

#define BCG_TABLE_INTERFACE

#ifdef __cplusplus
extern "C" {
#endif

#ifdef BCG_UNDEFINED
}
#endif

#include "bcg_standard.h"
#include "bcg_types.h"

typedef BCG_TYPE_NATURAL BCG_TYPE_TABLE_INDEX;

typedef struct bcg_struct_packet_element {
     BCG_TYPE_ADDRESS bcg_address;
     BCG_TYPE_NATURAL bcg_num_item;
     struct bcg_struct_packet_element *bcg_next;
}    bcg_body_packet_element, *bcg_type_packet_element;

typedef struct bcg_struct_packet {
     bcg_type_packet_element bcg_address_array;
     struct bcg_struct_packet *bcg_next;
}    bcg_body_packet, *bcg_type_packet;

typedef struct {
     BCG_TYPE_TABLE_INDEX bcg_packet_size;
     BCG_TYPE_TABLE_INDEX bcg_nb_items;
     bcg_type_packet bcg_first_packet;
     bcg_type_packet bcg_last_packet;
     BCG_TYPE_NATURAL (*bcg_hash_function) (BCG_TYPE_ADDRESS, BCG_TYPE_NATURAL);
     BCG_TYPE_COMPARISON_RESULT (*bcg_comparison_function) (BCG_TYPE_ADDRESS, BCG_TYPE_ADDRESS);
     BCG_TYPE_NATURAL bcg_hash_table_size;
     bcg_type_packet_element *bcg_hash_table;
}    bcg_body_table_structure, *bcg_type_table_structure;

typedef bcg_type_table_structure BCG_TYPE_TABLE;

extern void BCG_TABLE_CREATE BCG_ARG_5 (BCG_TYPE_TABLE *, BCG_TYPE_TABLE_INDEX, BCG_TYPE_NATURAL (*) (), BCG_TYPE_COMPARISON_RESULT (*) (), BCG_TYPE_NATURAL);

extern void BCG_TABLE_DELETE BCG_ARG_1 (BCG_TYPE_TABLE *);

extern BCG_TYPE_NATURAL BCG_TABLE_ADD BCG_ARG_3 (BCG_TYPE_TABLE, BCG_TYPE_ADDRESS, BCG_TYPE_BOOLEAN *);

extern BCG_TYPE_ADDRESS BCG_TABLE_SEARCH BCG_ARG_2 (BCG_TYPE_TABLE, BCG_TYPE_TABLE_INDEX);

extern BCG_TYPE_TABLE_INDEX BCG_TABLE_CARDINAL BCG_ARG_1 (BCG_TYPE_TABLE);

#define BCG_TABLE_ITER(bcg_table,bcg_element) \
	bcg_type_packet  bcg_packet; \
	BCG_TYPE_TABLE_INDEX bcg_num_item = 0; \
	BCG_TYPE_TABLE_INDEX bcg_index; \
	for (bcg_packet = bcg_table->bcg_first_packet; bcg_packet != NULL; \
		bcg_packet = bcg_packet->bcg_next) \
	for (bcg_index = 0; \
		(bcg_element) = (bcg_index < (bcg_table)->bcg_packet_size) ? \
		   bcg_packet->bcg_address_array[bcg_index].bcg_address : NULL,\
		(bcg_index < (bcg_table)->bcg_packet_size) && \
			(bcg_num_item < (bcg_table)->bcg_nb_items); \
		bcg_index++, bcg_num_item++)

#ifdef BCG_UNDEFINED
{
#endif

#ifdef __cplusplus
}
#endif

#endif
