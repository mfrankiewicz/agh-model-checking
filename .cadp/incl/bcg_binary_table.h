/******************************************************************************
 *                                B C G
 *-----------------------------------------------------------------------------
 *   INRIA - Unite de Recherche Rhone-Alpes
 *   655, avenue de l'Europe
 *   38330 Montbonnot Saint Martin
 *   FRANCE
 *-----------------------------------------------------------------------------
 *   Module             :       bcg_binary_table.h
 *   Auteurs            :       Renaud RUFFIOT et Hubert GARAVEL
 *   Version            :       1.21
 *   Date               :       2009/07/24 18:25:20
 *****************************************************************************/

#ifndef BCG_BINARY_TABLE_INTERFACE

#define BCG_BINARY_TABLE_INTERFACE

#ifdef __cplusplus
extern "C" {
#endif

#ifdef BCG_UNDEFINED
}
#endif

#include "bcg_standard.h"
#include "bcg_types.h"

typedef BCG_TYPE_LONG_NATURAL BCG_TYPE_BINARY_ARRAY_LENGTH;
typedef BCG_TYPE_LONG_NATURAL BCG_TYPE_BINARY_TABLE_LENGTH;

typedef BCG_TYPE_LONG_NATURAL BCG_TYPE_MEMORY_VALUE;
typedef BCG_TYPE_MEMORY_VALUE *BCG_TYPE_MEMORY_AREA;

typedef BCG_TYPE_64_BITS_INT BCG_TYPE_BINARY_OFFSET;
/*
 * deplacement exprime en nombre de bits ; on doit le definir comme "unsigned
 * long long" et non pas "unsigned long" car, sur une machine 32 bits et pour
 * une table binaire de grande taille, ce deplacement peut depasser 2^32 (par
 * exemple, pour une table occupant plus de 2^29 octets, donc contenant plus
 * de 2^32 bits adressables)
 */
#define BCG_MAX_BINARY_OFFSET ((BCG_TYPE_BINARY_OFFSET) -1LL)

typedef struct bcg_struct_binary_array *BCG_TYPE_BINARY_ARRAY;
typedef struct bcg_struct_binary_table *BCG_TYPE_BINARY_TABLE;

typedef struct bcg_struct_binary_array {
     BCG_TYPE_MEMORY_AREA bcg_memory_area;
     BCG_TYPE_BINARY_ARRAY_LENGTH bcg_length;	
     BCG_TYPE_NATURAL bcg_size;	
}    bcg_body_binary_array, *bcg_type_binary_array;

typedef struct bcg_struct_attribut {
     BCG_TYPE_NATURAL bcg_size;	
     BCG_TYPE_NATURAL bcg_offset;	/* offset de l'attribut dans
					 * l'element */
}    bcg_body_attribut, *bcg_type_attribut;

typedef struct bcg_struct_binary_table {
     BCG_TYPE_MEMORY_AREA bcg_memory_area;
     BCG_TYPE_BINARY_TABLE_LENGTH bcg_length;	
     BCG_TYPE_NATURAL bcg_size;	
     BCG_TYPE_NATURAL bcg_nb_attributs;	
     bcg_body_attribut *bcg_attribut;
}    bcg_body_binary_table, *bcg_type_binary_table;

#define bcg_memory_multiply(bcg_x,bcg_y) \
   ((BCG_TYPE_BINARY_OFFSET) \
      ((BCG_TYPE_BINARY_OFFSET) (bcg_x) * (BCG_TYPE_BINARY_OFFSET) (bcg_y)) \
   )

#define BCG_GET_BINARY_ARRAY(bcg_array, bcg_item_number) \
	BCG_GET_MEMORY ((bcg_array)->bcg_memory_area, \
			bcg_memory_multiply ((bcg_array)->bcg_size, (bcg_item_number)), \
			(bcg_array)->bcg_size)

#define BCG_SET_BINARY_ARRAY(bcg_array, bcg_item_number, bcg_value) \
        BCG_SET_MEMORY ((bcg_array)->bcg_memory_area, \
                        bcg_memory_multiply ((bcg_array)->bcg_size, (bcg_item_number)), \
                        (bcg_array)->bcg_size, \
                        (BCG_TYPE_MEMORY_VALUE) (bcg_value))

#define BCG_GET_BINARY_TABLE(bcg_table, bcg_item_number, bcg_num_attribut) \
        BCG_GET_MEMORY ((bcg_table)->bcg_memory_area, \
                        bcg_memory_multiply ((bcg_table)->bcg_size, (bcg_item_number)) + (bcg_table)->bcg_attribut[(bcg_num_attribut)].bcg_offset, \
                        (bcg_table)->bcg_attribut[(bcg_num_attribut)].bcg_size)

#define BCG_SET_BINARY_TABLE(bcg_table, bcg_item_number, bcg_num_attribut, bcg_value) \
        BCG_SET_MEMORY ((bcg_table)->bcg_memory_area, \
                        bcg_memory_multiply ((bcg_table)->bcg_size, (bcg_item_number)) + (bcg_table)->bcg_attribut[(bcg_num_attribut)].bcg_offset, \
                        (bcg_table)->bcg_attribut[(bcg_num_attribut)].bcg_size, \
                        (BCG_TYPE_MEMORY_VALUE) (bcg_value))

extern BCG_TYPE_MEMORY_VALUE BCG_GET_MEMORY BCG_ARG_3 (BCG_TYPE_MEMORY_AREA, BCG_TYPE_BINARY_OFFSET, BCG_TYPE_NATURAL);

extern void BCG_SET_MEMORY BCG_ARG_4 (BCG_TYPE_MEMORY_AREA, BCG_TYPE_BINARY_OFFSET, BCG_TYPE_NATURAL, BCG_TYPE_MEMORY_VALUE);

extern void BCG_CREATE_BINARY_ARRAY BCG_ARG_3 (BCG_TYPE_BINARY_ARRAY *, BCG_TYPE_BINARY_ARRAY_LENGTH, BCG_TYPE_NATURAL);

extern void BCG_DELETE_BINARY_ARRAY BCG_ARG_1 (BCG_TYPE_BINARY_ARRAY *);

extern void BCG_INIT_BINARY_ARRAY BCG_ARG_1 (BCG_TYPE_BINARY_ARRAY);

extern void BCG_PRINT_BINARY_ARRAY BCG_ARG_2 (BCG_TYPE_STREAM, BCG_TYPE_BINARY_ARRAY);

extern void BCG_CREATE_BINARY_TABLE BCG_ARG_4 (BCG_TYPE_BINARY_TABLE *, BCG_TYPE_BINARY_TABLE_LENGTH, BCG_TYPE_NATURAL,...);

/*
 * ... represente la liste des tailles des colonnes de la table terminee par
 * une valeur speciale BCG_END_LIST
 */

extern void BCG_DELETE_BINARY_TABLE BCG_ARG_1 (BCG_TYPE_BINARY_TABLE *);

extern BCG_TYPE_NATURAL BCG_BINARY_SIZE_OF BCG_ARG_1 (BCG_TYPE_LONG_NATURAL);

extern void BCG_PRINT_BINARY_TABLE BCG_ARG_2 (BCG_TYPE_STREAM, BCG_TYPE_BINARY_TABLE);

#ifdef BCG_UNDEFINED
{
#endif

#ifdef __cplusplus
}
#endif

#endif
