/******************************************************************************
 *                                B C G
 *-----------------------------------------------------------------------------
 *   INRIA - Unite de Recherche Rhone-Alpes
 *   655, avenue de l'Europe
 *   38330 Montbonnot Saint Martin
 *   FRANCE
 *-----------------------------------------------------------------------------
 *   Module             :       bcg_structure_2.h
 *   Auteurs            :       Renaud RUFFIOT, Radu MATEESCU, Hubert GARAVEL
 *   Version            :       1.17
 *   Date               :       2014/12/17 12:55:53
 *****************************************************************************/

#ifndef BCG_STRUCTURE_INTERFACE

#define BCG_STRUCTURE_INTERFACE

#ifdef __cplusplus
extern "C" {
#endif

#ifdef BCG_UNDEFINED
}
#endif

#include "bcg_standard.h"
#include "bcg_types.h"
#include "bcg_table.h"
#include "bcg_list.h"
#include "bcg_area.h"

/**
typedef struct bcg_struct_preamble_area {
     BCG_TYPE_BYTE bcg_major_version_number;
     BCG_TYPE_BYTE bcg_minor_version_number;
     BCG_TYPE_BOOLEAN bcg_completion;
     BCG_TYPE_C_STRING bcg_comment;
     BCG_TYPE_OFFSET bcg_type_area_offset;
     BCG_TYPE_OFFSET bcg_function_area_offset;
     BCG_TYPE_OFFSET bcg_profile_area_offset;
     BCG_TYPE_OFFSET bcg_file_area_offset;
     BCG_TYPE_OFFSET bcg_name_area_offset;
     BCG_TYPE_OFFSET bcg_edge_area_offset;
     BCG_TYPE_OFFSET bcg_label_area_offset;
     BCG_TYPE_OFFSET bcg_state_area_offset;
     BCG_TYPE_OFFSET bcg_class_area_offset;
} bcg_body_preamble_area, *bcg_type_preamble_area;
**/

typedef struct bcg_struct_include_area_1 {
     BCG_TYPE_C_STRING bcg_declarations;
     BCG_TYPE_C_STRING bcg_initializations;
}    BCG_BODY_INCLUDE_AREA_1, *BCG_TYPE_INCLUDE_AREA_1;

typedef struct bcg_struct_include_area {
     union {
	  BCG_TYPE_INCLUDE_AREA_1 bcg_include_1;
     }    bcg_union;
}    bcg_body_include_area, *bcg_type_include_area;

typedef struct bcg_struct_type_1 {
     BCG_TYPE_NAME_NUMBER bcg_source_name;
     BCG_TYPE_BYTE bcg_status;
     BCG_TYPE_NATURAL bcg_size;
     BCG_TYPE_BOOLEAN bcg_alignment;
     BCG_TYPE_C_STRING bcg_c_name;
     BCG_TYPE_C_STRING bcg_c_assignment;
     BCG_TYPE_C_STRING bcg_c_comparison;
     BCG_TYPE_C_STRING bcg_c_enumeration;
     BCG_TYPE_C_STRING bcg_c_print;
     BCG_TYPE_C_STRING bcg_c_write;
     BCG_TYPE_C_STRING bcg_c_read;
}    BCG_BODY_TYPE_1, *BCG_TYPE_TYPE_1;

typedef struct bcg_struct_type_area_1 {

     BCG_TYPE_TABLE bcg_type;

     BCG_TYPE_BOOLEAN bcg_types_upgraded;	
}    BCG_BODY_TYPE_AREA_1, *BCG_TYPE_TYPE_AREA_1;

typedef struct bcg_struct_type_area {
     union {
	  BCG_TYPE_TYPE_AREA_1 bcg_type_1;
     }    bcg_union;
}    bcg_body_type_area, *bcg_type_type_area;

typedef BCG_TYPE_TYPE_NUMBER BCG_BODY_FUNCTION_ARGUMENT_1, *BCG_TYPE_FUNCTION_ARGUMENT_1;

typedef struct bcg_struct_function_1 {
     BCG_TYPE_NAME_NUMBER bcg_source_name;
     BCG_TYPE_BYTE bcg_status;
     BCG_TYPE_C_STRING bcg_c_name;
     BCG_TYPE_NATURAL bcg_nb_arguments;
     BCG_TYPE_LIST bcg_argument_type_list;
     BCG_TYPE_TYPE_NUMBER bcg_result_type;
     BCG_TYPE_BOOLEAN bcg_source_operator;
     BCG_TYPE_BOOLEAN bcg_c_operator;
}    BCG_BODY_FUNCTION_1, *BCG_TYPE_FUNCTION_1;

typedef struct bcg_struct_function_area_1 {

     BCG_TYPE_TABLE bcg_function;

     BCG_TYPE_BOOLEAN bcg_functions_upgraded;	
}    BCG_BODY_FUNCTION_AREA_1, *BCG_TYPE_FUNCTION_AREA_1;

typedef struct bcg_struct_function_area {
     union {
	  BCG_TYPE_FUNCTION_AREA_1 bcg_function_1;
     }    bcg_union;
}    bcg_body_function_area, *bcg_type_function_area;

typedef struct bcg_struct_profile_element_1 {
     BCG_TYPE_NAME_NUMBER bcg_name;
     BCG_TYPE_TYPE_NUMBER bcg_type;
     BCG_TYPE_NATURAL bcg_padding;
}    BCG_BODY_PROFILE_ELEMENT_1, *BCG_TYPE_PROFILE_ELEMENT_1;

typedef struct bcg_struct_profile_1 {

     BCG_TYPE_LIST bcg_element;
     BCG_TYPE_NATURAL bcg_last_padding;
}    BCG_BODY_PROFILE_1, *BCG_TYPE_PROFILE_1;

typedef struct bcg_struct_profile_area_1 {

     BCG_TYPE_TABLE bcg_profile;
}    BCG_BODY_PROFILE_AREA_1, *BCG_TYPE_PROFILE_AREA_1;

typedef struct bcg_struct_profile_area {
     union {
	  BCG_TYPE_PROFILE_AREA_1 bcg_profile_1;
     }    bcg_union;
}    bcg_body_profile_area, *bcg_type_profile_area;

typedef struct bcg_struct_file_1 {
     BCG_TYPE_C_STRING bcg_unix_name;
}    BCG_BODY_FILE_1, *BCG_TYPE_FILE_1;

typedef struct bcg_struct_file_area_1 {

     BCG_TYPE_TABLE bcg_file;
}    BCG_BODY_FILE_AREA_1, *BCG_TYPE_FILE_AREA_1;

typedef struct bcg_struct_file_area {
     union {
	  BCG_TYPE_FILE_AREA_1 bcg_file_1;
     }    bcg_union;
}    bcg_body_file_area, *bcg_type_file_area;

typedef BCG_TYPE_C_STRING BCG_BODY_NAME_INDEX_1, *BCG_TYPE_NAME_INDEX_1;

typedef struct bcg_struct_dotted_kind_name_1 {
     BCG_TYPE_C_STRING bcg_identifier;
     BCG_TYPE_FILE_NUMBER bcg_file;
     BCG_TYPE_NATURAL bcg_line;
     BCG_TYPE_NATURAL bcg_column;
}    bcg_body_dotted_kind_name_1, *bcg_type_dotted_kind_name_1;

typedef struct bcg_struct_indexed_kind_name_1 {

     BCG_TYPE_LIST bcg_index;
}    bcg_body_indexed_kind_name_1, *bcg_type_indexed_kind_name_1;

typedef struct bcg_struct_name_1 {
     BCG_TYPE_BYTE bcg_kind;
     union {
	  bcg_body_dotted_kind_name_1 bcg_dotted_kind;
	  bcg_body_indexed_kind_name_1 bcg_indexed_kind;
     }    bcg_node;
     BCG_TYPE_C_STRING bcg_comment;
     BCG_TYPE_NAME_NUMBER bcg_prefix;
     BCG_TYPE_BYTE bcg_nature;
     union {
	  BCG_TYPE_TYPE_NUMBER bcg_type_entry;
	  BCG_TYPE_FUNCTION_NUMBER bcg_function_entry;
	  BCG_TYPE_PROFILE_NUMBER bcg_signal_entry;
	  BCG_TYPE_PROFILE_NUMBER bcg_variable_entry;
     }    bcg_entry;
}    BCG_BODY_NAME_1, *BCG_TYPE_NAME_1;

typedef struct bcg_struct_name_area_1 {
     BCG_TYPE_BOOLEAN bcg_case_sensitive;
     BCG_TYPE_NAME_NUMBER bcg_root_name;
     BCG_TYPE_TABLE bcg_name;
}    BCG_BODY_NAME_AREA_1, *BCG_TYPE_NAME_AREA_1;

typedef struct bcg_struct_name_area {
     union {
	  BCG_TYPE_NAME_AREA_1 bcg_name_1;
     }    bcg_union;
}    bcg_body_name_area, *bcg_type_name_area;

typedef struct bcg_struct_edge_area_1 {
     BCG_TYPE_EDGE_NUMBER bcg_nb_edges;
}    BCG_BODY_EDGE_AREA_1, *BCG_TYPE_EDGE_AREA_1;

typedef struct bcg_struct_edge_area_2 {
     BCG_TYPE_EDGE_NUMBER bcg_nb_edges;
}    BCG_BODY_EDGE_AREA_2, *BCG_TYPE_EDGE_AREA_2;

typedef struct bcg_struct_edge_area {
     union {
	  BCG_TYPE_EDGE_AREA_1 bcg_edge_1;
	  BCG_TYPE_EDGE_AREA_2 bcg_edge_2;
     }    bcg_union;
}    bcg_body_edge_area, *bcg_type_edge_area;

typedef struct bcg_struct_label_1 {
     BCG_TYPE_PROFILE_NUMBER bcg_signal_profile;
     /*
      * Dans le cas d'un programme statique, le champ ci-dessous a une valeur
      * indefinie. Dans le cas d'un programme dynamique, il doit contenir une
      * chaine de bits correspondant au contenu du label lu par
      * Bcg_READ_PROFILE ou ecrit par Bcg_WRITE_PROFILE.
      */
     BCG_TYPE_ADDRESS bcg_signal_content;
     BCG_TYPE_BOOLEAN bcg_visible;
     /*
      * les champs ci-dessous ne sont pas dans le format BCG a proprement
      * parler, mais ils contiennent des informations sur les labels
      * representes comme chaines de caracteres, ou comme listes de chaines
      * de caracteres
      */
     BCG_TYPE_NATURAL bcg_signal_size;	
     BCG_TYPE_C_STRING bcg_signal_string;
     BCG_TYPE_LIST bcg_signal_string_list;	
}    BCG_BODY_LABEL_1, *BCG_TYPE_LABEL_1;

typedef struct bcg_struct_label_area_1 {

     BCG_TYPE_TABLE bcg_label;	
}    BCG_BODY_LABEL_AREA_1, *BCG_TYPE_LABEL_AREA_1;

typedef struct bcg_struct_label_area {
     union {
	  BCG_TYPE_LABEL_AREA_1 bcg_label_1;
     }    bcg_union;
}    bcg_body_label_area, *bcg_type_label_area;

typedef struct bcg_struct_state_area_1 {
     BCG_TYPE_STATE_NUMBER bcg_nb_states;
     BCG_TYPE_STATE_NUMBER bcg_initial_state;
     BCG_TYPE_PROFILE_NUMBER bcg_variable_profile;
}    BCG_BODY_STATE_AREA_1, *BCG_TYPE_STATE_AREA_1;

typedef struct bcg_struct_state_area {
     union {
	  BCG_TYPE_STATE_AREA_1 bcg_state_1;
     }    bcg_union;
}    bcg_body_state_area, *bcg_type_state_area;

typedef struct bcg_struct_class_area_1 {
     BCG_TYPE_CLASS_NUMBER bcg_nb_classes;
}    BCG_BODY_CLASS_AREA_1, *BCG_TYPE_CLASS_AREA_1;

typedef struct bcg_struct_class_area {
     union {
	  BCG_TYPE_CLASS_AREA_1 bcg_class_1;
     }    bcg_union;
}    bcg_body_class_area, *bcg_type_class_area;

typedef struct bcg_struct_bcg_object {
     bcg_body_include_area bcg_includes;
     bcg_body_type_area bcg_types;
     bcg_body_function_area bcg_functions;
     bcg_body_profile_area bcg_profiles;
     bcg_body_file_area bcg_files;
     bcg_body_name_area bcg_names;
     bcg_body_edge_area bcg_edges;
     bcg_body_label_area bcg_labels;
     bcg_body_state_area bcg_states;
     bcg_body_class_area bcg_classes;
     BCG_TYPE_NATURAL bcg_code[bcg_nb_areas];
}    BCG_BODY_BCG_OBJECT, *BCG_TYPE_BCG_OBJECT;

#ifdef BCG_UNDEFINED
{
#endif

#ifdef __cplusplus
}
#endif

#endif
