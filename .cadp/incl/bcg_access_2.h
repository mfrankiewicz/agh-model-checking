/******************************************************************************
 *                                B C G
 *-----------------------------------------------------------------------------
 *   INRIA - Unite de Recherche Rhone-Alpes
 *   655, avenue de l'Europe
 *   38330 Montbonnot Saint Martin
 *   FRANCE
 *-----------------------------------------------------------------------------
 *   Module             :       bcg_access_2.h
 *   Auteurs            :       Renaud RUFFIOT, Radu MATEESCU, Hubert GARAVEL
 *   Version            :       1.12
 *   Date               :       2014/12/17 12:55:53
 *****************************************************************************/

#ifndef BCG_ACCESS_INTERFACE

#define BCG_ACCESS_INTERFACE

#ifdef __cplusplus
extern "C" {
#endif

#ifdef BCG_UNDEFINED
}
#endif

#define BCG_INCLUDES(bcg_bcg_object) \
	((bcg_bcg_object)->bcg_includes.bcg_union)

#define BCG_TYPES(bcg_bcg_object) \
	((bcg_bcg_object)->bcg_types.bcg_union)

#define BCG_FUNCTIONS(bcg_bcg_object) \
	((bcg_bcg_object)->bcg_functions.bcg_union)

#define BCG_PROFILES(bcg_bcg_object) \
	((bcg_bcg_object)->bcg_profiles.bcg_union)

#define BCG_FILES(bcg_bcg_object) \
	((bcg_bcg_object)->bcg_files.bcg_union)

#define BCG_NAMES(bcg_bcg_object) \
	((bcg_bcg_object)->bcg_names.bcg_union)

#define BCG_EDGES(bcg_bcg_object) \
	((bcg_bcg_object)->bcg_edges.bcg_union)

#define BCG_LABELS(bcg_bcg_object) \
	((bcg_bcg_object)->bcg_labels.bcg_union)

#define BCG_STATES(bcg_bcg_object) \
	((bcg_bcg_object)->bcg_states.bcg_union)

#define BCG_CLASSES(bcg_bcg_object) \
	((bcg_bcg_object)->bcg_classes.bcg_union)

#define BCG_I_CODE(bcg_bcg_object) \
	((bcg_bcg_object)->bcg_code[0])

#define BCG_T_CODE(bcg_bcg_object) \
	((bcg_bcg_object)->bcg_code[1])

#define BCG_F_CODE(bcg_bcg_object) \
	((bcg_bcg_object)->bcg_code[2])

#define BCG_P_CODE(bcg_bcg_object) \
	((bcg_bcg_object)->bcg_code[3])

#define BCG_U_CODE(bcg_bcg_object) \
	((bcg_bcg_object)->bcg_code[4])

#define BCG_N_CODE(bcg_bcg_object) \
	((bcg_bcg_object)->bcg_code[5])

#define BCG_E_CODE(bcg_bcg_object) \
	((bcg_bcg_object)->bcg_code[6])

#define BCG_L_CODE(bcg_bcg_object) \
	((bcg_bcg_object)->bcg_code[7])

#define BCG_S_CODE(bcg_bcg_object) \
	((bcg_bcg_object)->bcg_code[8])

#define BCG_C_CODE(bcg_bcg_object) \
	((bcg_bcg_object)->bcg_code[9])

#define BCG_INCLUDE_1(bcg_bcg_object) \
	(BCG_INCLUDES (bcg_bcg_object).bcg_include_1)

#define BCG_TYPE_1(bcg_bcg_object) \
	(BCG_TYPES (bcg_bcg_object).bcg_type_1)

#define BCG_FUNCTION_1(bcg_bcg_object) \
	(BCG_FUNCTIONS (bcg_bcg_object).bcg_function_1)

#define BCG_PROFILE_1(bcg_bcg_object) \
	(BCG_PROFILES (bcg_bcg_object).bcg_profile_1)

#define BCG_FILE_1(bcg_bcg_object) \
	(BCG_FILES (bcg_bcg_object).bcg_file_1)

#define BCG_NAME_1(bcg_bcg_object) \
	(BCG_NAMES (bcg_bcg_object).bcg_name_1)

#define BCG_EDGE_1(bcg_bcg_object) \
	(BCG_EDGES (bcg_bcg_object).bcg_edge_1)

#define BCG_EDGE_2(bcg_bcg_object) \
	(BCG_EDGES (bcg_bcg_object).bcg_edge_2)

#define BCG_LABEL_1(bcg_bcg_object) \
	(BCG_LABELS (bcg_bcg_object).bcg_label_1)

#define BCG_STATE_1(bcg_bcg_object) \
	(BCG_STATES (bcg_bcg_object).bcg_state_1)

#define BCG_CLASS_1(bcg_bcg_object) \
	(BCG_CLASSES (bcg_bcg_object).bcg_class_1)

#define BCG_AI1_DECLARATIONS(bcg_include_area_1) \
	((bcg_include_area_1)->bcg_declarations)

#define BCG_I1_DECLARATIONS(bcg_bcg_object) \
	(BCG_AI1_DECLARATIONS (BCG_INCLUDE_1 (bcg_bcg_object)))

#define BCG_AI1_INITIALIZATIONS(bcg_include_area_1) \
	((bcg_include_area_1)->bcg_initializations)

#define BCG_I1_INITIALIZATIONS(bcg_bcg_object) \
	(BCG_AI1_INITIALIZATIONS (BCG_INCLUDE_1 (bcg_bcg_object)))

#define BCG_AT1_TYPES(bcg_type_area_1) \
	((bcg_type_area_1)->bcg_type)

#define BCG_T1_TYPES(bcg_bcg_object) \
	(BCG_AT1_TYPES (BCG_TYPE_1 (bcg_bcg_object)))

#define BCG_AT1_NB_TYPES(bcg_type_area_1) \
	(BCG_TABLE_CARDINAL (BCG_AT1_TYPES (bcg_type_area_1)))

#define BCG_T1_NB_TYPES(bcg_bcg_object) \
	(BCG_AT1_NB_TYPES (BCG_TYPE_1 (bcg_bcg_object)))

#define BCG_AT1_TYPE(bcg_type_area_1, bcg_index) \
	((BCG_TYPE_TYPE_1) BCG_TABLE_SEARCH (BCG_AT1_TYPES (bcg_type_area_1), \
					     (bcg_index)))

#define BCG_T1_TYPE(bcg_bcg_object, bcg_index) \
	(BCG_AT1_TYPE (BCG_TYPE_1 (bcg_bcg_object), (bcg_index)))

#define BCG_AT1_TYPES_UPGRADED(bcg_type_area_1) \
	((bcg_type_area_1)->bcg_types_upgraded)

#define BCG_T1_TYPES_UPGRADED(bcg_bcg_object) \
	(BCG_AT1_TYPES_UPGRADED (BCG_TYPE_1 (bcg_bcg_object)))

#define BCG_TT1_SOURCE_NAME(bcg_type_1) \
	((bcg_type_1)->bcg_source_name)

#define BCG_AT1_SOURCE_NAME(bcg_type_area_1, bcg_index) \
	(BCG_TT1_SOURCE_NAME (BCG_AT1_TYPE ((bcg_type_area_1), (bcg_index))))

#define BCG_T1_SOURCE_NAME(bcg_bcg_object, bcg_index) \
        (BCG_AT1_SOURCE_NAME (BCG_TYPE_1 (bcg_bcg_object), (bcg_index)))

#define BCG_TT1_STATUS(bcg_type_1) \
	((bcg_type_1)->bcg_status)

#define BCG_AT1_STATUS(bcg_type_area_1, bcg_index) \
	(BCG_TT1_STATUS (BCG_AT1_TYPE ((bcg_type_area_1), (bcg_index))))

#define BCG_T1_STATUS(bcg_bcg_object, bcg_index) \
        (BCG_AT1_STATUS (BCG_TYPE_1 (bcg_bcg_object), (bcg_index)))

#define BCG_TT1_SIZE(bcg_type_1) \
	((bcg_type_1)->bcg_size)

#define BCG_AT1_SIZE(bcg_type_area_1, bcg_index) \
	(BCG_TT1_SIZE (BCG_AT1_TYPE ((bcg_type_area_1), (bcg_index))))

#define BCG_T1_SIZE(bcg_bcg_object, bcg_index) \
        (BCG_AT1_SIZE (BCG_TYPE_1 (bcg_bcg_object), (bcg_index)))

#define BCG_TT1_ALIGNMENT(bcg_type_1) \
        ((bcg_type_1)->bcg_alignment)

#define BCG_AT1_ALIGNMENT(bcg_type_area_1, bcg_index) \
        (BCG_TT1_ALIGNMENT (BCG_AT1_TYPE ((bcg_type_area_1), (bcg_index))))

#define BCG_T1_ALIGNMENT(bcg_bcg_object, bcg_index) \
        (BCG_AT1_ALIGNMENT (BCG_TYPE_1 (bcg_bcg_object), (bcg_index)))

#define BCG_TT1_C_NAME(bcg_type_1) \
	((bcg_type_1)->bcg_c_name)

#define BCG_AT1_C_NAME(bcg_type_area_1, bcg_index) \
	(BCG_TT1_C_NAME (BCG_AT1_TYPE ((bcg_type_area_1), (bcg_index))))

#define BCG_T1_C_NAME(bcg_bcg_object, bcg_index) \
        (BCG_AT1_C_NAME (BCG_TYPE_1 (bcg_bcg_object), (bcg_index)))

#define BCG_TT1_C_ASSIGNMENT(bcg_type_1) \
        ((bcg_type_1)->bcg_c_assignment)

#define BCG_AT1_C_ASSIGNMENT(bcg_type_area_1, bcg_index) \
        (BCG_TT1_C_ASSIGNMENT (BCG_AT1_TYPE ((bcg_type_area_1), (bcg_index))))

#define BCG_T1_C_ASSIGNMENT(bcg_bcg_object, bcg_index) \
        (BCG_AT1_C_ASSIGNMENT (BCG_TYPE_1 (bcg_bcg_object), (bcg_index)))

#define BCG_TT1_C_COMPARISON(bcg_type_1) \
        ((bcg_type_1)->bcg_c_comparison)

#define BCG_AT1_C_COMPARISON(bcg_type_area_1, bcg_index) \
        (BCG_TT1_C_COMPARISON (BCG_AT1_TYPE ((bcg_type_area_1), (bcg_index))))

#define BCG_T1_C_COMPARISON(bcg_bcg_object, bcg_index) \
        (BCG_AT1_C_COMPARISON (BCG_TYPE_1 (bcg_bcg_object), (bcg_index)))

#define BCG_TT1_C_ENUMERATION(bcg_type_1) \
        ((bcg_type_1)->bcg_c_enumeration)

#define BCG_AT1_C_ENUMERATION(bcg_type_area_1, bcg_index) \
        (BCG_TT1_C_ENUMERATION (BCG_AT1_TYPE ((bcg_type_area_1), (bcg_index))))

#define BCG_T1_C_ENUMERATION(bcg_bcg_object, bcg_index) \
        (BCG_AT1_C_ENUMERATION (BCG_TYPE_1 (bcg_bcg_object), (bcg_index)))

#define BCG_TT1_C_PRINT(bcg_type_1) \
        ((bcg_type_1)->bcg_c_print)

#define BCG_AT1_C_PRINT(bcg_type_area_1, bcg_index) \
        (BCG_TT1_C_PRINT (BCG_AT1_TYPE ((bcg_type_area_1), (bcg_index))))

#define BCG_T1_C_PRINT(bcg_bcg_object, bcg_index) \
        (BCG_AT1_C_PRINT (BCG_TYPE_1 (bcg_bcg_object), (bcg_index)))

#define BCG_TT1_C_WRITE(bcg_type_1) \
        ((bcg_type_1)->bcg_c_write)

#define BCG_AT1_C_WRITE(bcg_type_area_1, bcg_index) \
        (BCG_TT1_C_WRITE (BCG_AT1_TYPE ((bcg_type_area_1), (bcg_index))))

#define BCG_T1_C_WRITE(bcg_bcg_object, bcg_index) \
        (BCG_AT1_C_WRITE (BCG_TYPE_1 (bcg_bcg_object), (bcg_index)))

#define BCG_TT1_C_READ(bcg_type_1) \
        ((bcg_type_1)->bcg_c_read)

#define BCG_AT1_C_READ(bcg_type_area_1, bcg_index) \
        (BCG_TT1_C_READ (BCG_AT1_TYPE ((bcg_type_area_1), (bcg_index))))

#define BCG_T1_C_READ(bcg_bcg_object, bcg_index) \
        (BCG_AT1_C_READ (BCG_TYPE_1 (bcg_bcg_object), (bcg_index)))

#define BCG_AF1_FUNCTIONS(bcg_function_area_1) \
        ((bcg_function_area_1)->bcg_function)

#define BCG_F1_FUNCTIONS(bcg_bcg_object) \
        (BCG_AF1_FUNCTIONS (BCG_FUNCTION_1 (bcg_bcg_object)))

#define BCG_AF1_NB_FUNCTIONS(bcg_function_area_1) \
	(BCG_TABLE_CARDINAL (BCG_AF1_FUNCTIONS (bcg_function_area_1)))

#define BCG_F1_NB_FUNCTIONS(bcg_bcg_object) \
        (BCG_AF1_NB_FUNCTIONS (BCG_FUNCTION_1 (bcg_bcg_object)))

#define BCG_AF1_FUNCTIONS_UPGRADED(bcg_function_area_1) \
	((bcg_function_area_1)->bcg_functions_upgraded)

#define BCG_F1_FUNCTIONS_UPGRADED(bcg_bcg_object) \
	(BCG_AF1_FUNCTIONS_UPGRADED (BCG_FUNCTION_1 (bcg_bcg_object)))

#define BCG_AF1_FUNCTION(bcg_function_area_1, bcg_index) \
        ((BCG_TYPE_FUNCTION_1) BCG_TABLE_SEARCH \
		(BCG_AF1_FUNCTIONS (bcg_function_area_1), (bcg_index)))

#define BCG_F1_FUNCTION(bcg_bcg_object, bcg_index) \
        (BCG_AF1_FUNCTION (BCG_FUNCTION_1 (bcg_bcg_object), (bcg_index)))

#define BCG_FF1_SOURCE_NAME(bcg_function_1) \
        ((bcg_function_1)->bcg_source_name)

#define BCG_AF1_SOURCE_NAME(bcg_function_area_1, bcg_index) \
        (BCG_FF1_SOURCE_NAME (BCG_AF1_FUNCTION ((bcg_function_area_1), \
						(bcg_index))))

#define BCG_F1_SOURCE_NAME(bcg_bcg_object, bcg_index) \
        (BCG_AF1_SOURCE_NAME (BCG_FUNCTION_1 (bcg_bcg_object), (bcg_index)))

#define BCG_FF1_STATUS(bcg_function_1) \
        ((bcg_function_1)->bcg_status)

#define BCG_AF1_STATUS(bcg_function_area_1, bcg_index) \
        (BCG_FF1_STATUS (BCG_AF1_FUNCTION ((bcg_function_area_1), \
						(bcg_index))))

#define BCG_F1_STATUS(bcg_bcg_object, bcg_index) \
        (BCG_AF1_STATUS (BCG_FUNCTION_1 (bcg_bcg_object), (bcg_index)))

#define BCG_FF1_C_NAME(bcg_function_1) \
        ((bcg_function_1)->bcg_c_name)

#define BCG_AF1_C_NAME(bcg_function_area_1, bcg_index) \
        (BCG_FF1_C_NAME (BCG_AF1_FUNCTION ((bcg_function_area_1), \
						(bcg_index))))

#define BCG_F1_C_NAME(bcg_bcg_object, bcg_index) \
        (BCG_AF1_C_NAME (BCG_FUNCTION_1 (bcg_bcg_object), (bcg_index)))

#define BCG_FF1_RESULT_TYPE(bcg_function_1) \
        ((bcg_function_1)->bcg_result_type)

#define BCG_AF1_RESULT_TYPE(bcg_function_area_1, bcg_index) \
        (BCG_FF1_RESULT_TYPE (BCG_AF1_FUNCTION ((bcg_function_area_1), \
						(bcg_index))))

#define BCG_F1_RESULT_TYPE(bcg_bcg_object, bcg_index) \
        (BCG_AF1_RESULT_TYPE (BCG_FUNCTION_1 (bcg_bcg_object), (bcg_index)))

#define BCG_FF1_SOURCE_OPERATOR(bcg_function_1) \
        ((bcg_function_1)->bcg_source_operator)

#define BCG_AF1_SOURCE_OPERATOR(bcg_function_area_1, bcg_index) \
        (BCG_FF1_SOURCE_OPERATOR (BCG_AF1_FUNCTION ((bcg_function_area_1), \
                                                (bcg_index))))

#define BCG_F1_SOURCE_OPERATOR(bcg_bcg_object, bcg_index) \
        (BCG_AF1_SOURCE_OPERATOR (BCG_FUNCTION_1 (bcg_bcg_object), (bcg_index)))

#define BCG_FF1_C_OPERATOR(bcg_function_1) \
        ((bcg_function_1)->bcg_c_operator)

#define BCG_AF1_C_OPERATOR(bcg_function_area_1, bcg_index) \
        (BCG_FF1_C_OPERATOR (BCG_AF1_FUNCTION ((bcg_function_area_1), \
                                                (bcg_index))))

#define BCG_F1_C_OPERATOR(bcg_bcg_object, bcg_index) \
        (BCG_AF1_C_OPERATOR (BCG_FUNCTION_1 (bcg_bcg_object), (bcg_index)))

#define BCG_FF1_ARGUMENT_TYPE_LIST(bcg_function_1) \
        ((bcg_function_1)->bcg_argument_type_list)

#define BCG_AF1_ARGUMENT_TYPE_LIST(bcg_function_area_1, bcg_index) \
        (BCG_FF1_ARGUMENT_TYPE_LIST (BCG_AF1_FUNCTION ((bcg_function_area_1), \
                                                (bcg_index))))

#define BCG_F1_ARGUMENT_TYPE_LIST(bcg_bcg_object, bcg_index) \
        (BCG_AF1_ARGUMENT_TYPE_LIST (BCG_FUNCTION_1 (bcg_bcg_object), (bcg_index)))

#define BCG_TF1_ARGUMENT_TYPE(bcg_function_argument_1) \
        (*(bcg_function_argument_1))

#define BCG_FF1_ARGUMENT_TYPE(bcg_function_1, bcg_index) \
        (BCG_TF1_ARGUMENT_TYPE ((BCG_TYPE_FUNCTION_ARGUMENT_1) BCG_LIST_SEARCH \
	  (BCG_FF1_ARGUMENT_TYPE_LIST (bcg_function_1), (bcg_index))))

#define BCG_AF1_ARGUMENT_TYPE(bcg_function_area_1, bcg_function_index, bcg_argument_index) \
        (BCG_FF1_ARGUMENT_TYPE (BCG_AF1_FUNCTION ((bcg_function_area_1), \
		(bcg_function_index)), bcg_argument_index))

#define BCG_F1_ARGUMENT_TYPE(bcg_bcg_object, bcg_function_index, bcg_argument_index) \
        (BCG_AF1_ARGUMENT_TYPE (BCG_FUNCTION_1 (bcg_bcg_object), \
		(bcg_function_index), (bcg_argument_index)))

#define BCG_FF1_NB_ARGUMENTS(bcg_function_1) \
	(BCG_LIST_CARDINAL (BCG_FF1_ARGUMENT_TYPE_LIST (bcg_function_1)))

#define BCG_AF1_NB_ARGUMENTS(bcg_function_area_1, bcg_index) \
        (BCG_FF1_NB_ARGUMENTS (BCG_AF1_FUNCTION ((bcg_function_area_1), \
						(bcg_index))))

#define BCG_F1_NB_ARGUMENTS(bcg_bcg_object, bcg_index) \
        (BCG_AF1_NB_ARGUMENTS (BCG_FUNCTION_1 (bcg_bcg_object), (bcg_index)))

#define BCG_AP1_PROFILES(bcg_profile_area_1) \
        ((bcg_profile_area_1)->bcg_profile)

#define BCG_P1_PROFILES(bcg_bcg_object) \
        (BCG_AP1_PROFILES (BCG_PROFILE_1 (bcg_bcg_object)))

#define BCG_AP1_NB_PROFILES(bcg_profile_area_1) \
	(BCG_TABLE_CARDINAL (BCG_AP1_PROFILES (bcg_profile_area_1)))

#define BCG_P1_NB_PROFILES(bcg_bcg_object) \
        (BCG_AP1_NB_PROFILES (BCG_PROFILE_1 (bcg_bcg_object)))

#define BCG_AP1_PROFILE(bcg_profile_area_1, bcg_index) \
        ((BCG_TYPE_PROFILE_1) \
	 BCG_TABLE_SEARCH (BCG_AP1_PROFILES (bcg_profile_area_1), (bcg_index)))

#define BCG_P1_PROFILE(bcg_bcg_object, bcg_index) \
        (BCG_AP1_PROFILE (BCG_PROFILE_1 (bcg_bcg_object), (bcg_index)))

#define BCG_PP1_ELEMENTS(bcg_profile_1) \
        ((bcg_profile_1)->bcg_element)

#define BCG_AP1_ELEMENTS(bcg_profile_area_1, bcg_index) \
        (BCG_PP1_ELEMENTS (BCG_AP1_PROFILE (bcg_profile_area_1, (bcg_index))))

#define BCG_P1_ELEMENTS(bcg_bcg_object, bcg_index) \
        (BCG_AP1_ELEMENTS (BCG_PROFILE_1 (bcg_bcg_object), (bcg_index)))

#define BCG_PP1_NB_ELEMENTS(bcg_profile_1) \
	(BCG_LIST_CARDINAL (BCG_PP1_ELEMENTS (bcg_profile_1)))

#define BCG_AP1_NB_ELEMENTS(bcg_profile_area_1, bcg_index) \
        (BCG_PP1_NB_ELEMENTS (BCG_AP1_PROFILE ((bcg_profile_area_1), (bcg_index))))

#define BCG_P1_NB_ELEMENTS(bcg_bcg_object, bcg_index) \
        (BCG_AP1_NB_ELEMENTS (BCG_PROFILE_1 (bcg_bcg_object), (bcg_index)))

#define BCG_PP1_ELEMENT(bcg_profile_1, bcg_index) \
        ((BCG_TYPE_PROFILE_ELEMENT_1) \
	 BCG_LIST_SEARCH (BCG_PP1_ELEMENTS (bcg_profile_1), (bcg_index)))

#define BCG_AP1_ELEMENT(bcg_profile_area_1, bcg_profile_index, bcg_element_index)\
        (BCG_PP1_ELEMENT (BCG_AP1_PROFILE ((bcg_profile_area_1), \
		(bcg_profile_index)), (bcg_element_index)))

#define BCG_P1_ELEMENT(bcg_bcg_object, bcg_profile_index, bcg_element_index) \
        (BCG_AP1_ELEMENT (BCG_PROFILE_1 (bcg_bcg_object), (bcg_profile_index), \
				(bcg_element_index)))

#define BCG_PP1_LAST_PADDING(bcg_profile_1) \
        ((bcg_profile_1)->bcg_last_padding)

#define BCG_AP1_LAST_PADDING(bcg_profile_area_1, bcg_index) \
        (BCG_PP1_LAST_PADDING (BCG_AP1_PROFILE ((bcg_profile_area_1), (bcg_index))))

#define BCG_P1_LAST_PADDING(bcg_bcg_object, bcg_index) \
        (BCG_AP1_LAST_PADDING (BCG_PROFILE_1 (bcg_bcg_object), (bcg_index)))

#define BCG_EP1_NAME(bcg_profile_element_1) \
        ((bcg_profile_element_1)->bcg_name)

#define BCG_PP1_NAME(bcg_profile_1, bcg_index) \
        (BCG_EP1_NAME (BCG_PP1_ELEMENT ((bcg_profile_1), (bcg_index))))

#define BCG_AP1_NAME(bcg_profile_area_1, bcg_profile_index, bcg_element_index) \
        (BCG_PP1_NAME (BCG_AP1_PROFILE ((bcg_profile_area_1), \
		(bcg_profile_index)), (bcg_element_index)))

#define BCG_P1_NAME(bcg_bcg_object, bcg_profile_index, bcg_element_index) \
        (BCG_AP1_NAME (BCG_PROFILE_1 (bcg_bcg_object), (bcg_profile_index),\
		       (bcg_element_index)))

#define BCG_EP1_TYPE(bcg_profile_element_1) \
        ((bcg_profile_element_1)->bcg_type)

#define BCG_PP1_TYPE(bcg_profile_1, bcg_index) \
        (BCG_EP1_TYPE (BCG_PP1_ELEMENT ((bcg_profile_1), (bcg_index))))

#define BCG_AP1_TYPE(bcg_profile_area_1, bcg_profile_index, bcg_element_index) \
        (BCG_PP1_TYPE (BCG_AP1_PROFILE ((bcg_profile_area_1), \
                (bcg_profile_index)), (bcg_element_index)))

#define BCG_P1_TYPE(bcg_bcg_object, bcg_profile_index, bcg_element_index) \
        (BCG_AP1_TYPE (BCG_PROFILE_1 (bcg_bcg_object), (bcg_profile_index),\
                       (bcg_element_index)))

#define BCG_EP1_PADDING(bcg_profile_element_1) \
        ((bcg_profile_element_1)->bcg_padding)

#define BCG_PP1_PADDING(bcg_profile_1, bcg_index) \
        (BCG_EP1_PADDING (BCG_PP1_ELEMENT ((bcg_profile_1), (bcg_index))))

#define BCG_AP1_PADDING(bcg_profile_area_1, bcg_profile_index, bcg_element_index) \
        (BCG_PP1_PADDING (BCG_AP1_PROFILE ((bcg_profile_area_1), \
                (bcg_profile_index)), (bcg_element_index)))

#define BCG_P1_PADDING(bcg_bcg_object, bcg_profile_index, bcg_element_index) \
        (BCG_AP1_PADDING (BCG_PROFILE_1 (bcg_bcg_object), (bcg_profile_index), \
                       (bcg_element_index)))

#define BCG_AU1_FILES(bcg_file_area_1) \
        ((bcg_file_area_1)->bcg_file)

#define BCG_U1_FILES(bcg_bcg_object) \
        (BCG_AU1_FILES (BCG_FILE_1 (bcg_bcg_object)))

#define BCG_AU1_NB_FILES(bcg_file_area_1) \
	(BCG_TABLE_CARDINAL (BCG_AU1_FILES (bcg_file_area_1)))

#define BCG_U1_NB_FILES(bcg_bcg_object) \
        (BCG_AU1_NB_FILES (BCG_FILE_1 (bcg_bcg_object)))

#define BCG_AU1_FILE(bcg_file_area_1, bcg_index) \
        ((BCG_TYPE_FILE_1) \
         BCG_TABLE_SEARCH (BCG_AU1_FILES (bcg_file_area_1), (bcg_index)))

#define BCG_U1_FILE(bcg_bcg_object, bcg_index) \
        (BCG_AU1_FILE (BCG_FILE_1 (bcg_bcg_object), (bcg_index)))

#define BCG_UU1_UNIX_NAME(bcg_file_1) \
        ((bcg_file_1)->bcg_unix_name)

#define BCG_AU1_UNIX_NAME(bcg_file_area_1, bcg_index) \
        (BCG_UU1_UNIX_NAME (BCG_AU1_FILE ((bcg_file_area_1), (bcg_index))))

#define BCG_U1_UNIX_NAME(bcg_bcg_object, bcg_index) \
        (BCG_AU1_UNIX_NAME (BCG_FILE_1 (bcg_bcg_object), (bcg_index)))

#define BCG_AN1_CASE_SENSITIVE(bcg_name_area_1) \
        ((bcg_name_area_1)->bcg_case_sensitive)

#define BCG_N1_CASE_SENSITIVE(bcg_bcg_object) \
        (BCG_AN1_CASE_SENSITIVE (BCG_NAME_1 (bcg_bcg_object)))

#define BCG_AN1_ROOT_NAME(bcg_name_area_1) \
        ((bcg_name_area_1)->bcg_root_name)

#define BCG_N1_ROOT_NAME(bcg_bcg_object) \
        (BCG_AN1_ROOT_NAME (BCG_NAME_1 (bcg_bcg_object)))

#define BCG_AN1_NAMES(bcg_name_area_1) \
        ((bcg_name_area_1)->bcg_name)

#define BCG_N1_NAMES(bcg_bcg_object) \
        (BCG_AN1_NAMES (BCG_NAME_1 (bcg_bcg_object)))

#define BCG_AN1_NB_NAMES(bcg_name_area_1) \
	(BCG_TABLE_CARDINAL (BCG_AN1_NAMES (bcg_name_area_1)))

#define BCG_N1_NB_NAMES(bcg_bcg_object) \
        (BCG_AN1_NB_NAMES (BCG_NAME_1 (bcg_bcg_object)))

#define BCG_AN1_NAME(bcg_name_area_1, bcg_index) \
        ((BCG_TYPE_NAME_1) \
         BCG_TABLE_SEARCH (BCG_AN1_NAMES (bcg_name_area_1), (bcg_index)))

#define BCG_N1_NAME(bcg_bcg_object, bcg_index) \
        (BCG_AN1_NAME (BCG_NAME_1 (bcg_bcg_object), (bcg_index)))

#define BCG_NN1_COMMENT(bcg_name_1) \
        ((bcg_name_1)->bcg_comment)

#define BCG_AN1_COMMENT(bcg_name_area_1, bcg_index) \
        (BCG_NN1_COMMENT (BCG_AN1_NAME ((bcg_name_area_1), (bcg_index))))

#define BCG_N1_COMMENT(bcg_bcg_object, bcg_index) \
        (BCG_AN1_COMMENT (BCG_NAME_1 (bcg_bcg_object), (bcg_index)))

#define BCG_NN1_PREFIX(bcg_name_1) \
        ((bcg_name_1)->bcg_prefix)

#define BCG_AN1_PREFIX(bcg_name_area_1, bcg_index) \
        (BCG_NN1_PREFIX (BCG_AN1_NAME ((bcg_name_area_1), (bcg_index))))

#define BCG_N1_PREFIX(bcg_bcg_object, bcg_index) \
        (BCG_AN1_PREFIX (BCG_NAME_1 (bcg_bcg_object), (bcg_index)))

#define BCG_NN1_KIND(bcg_name_1) \
        ((bcg_name_1)->bcg_kind)

#define BCG_AN1_KIND(bcg_name_area_1, bcg_index) \
        (BCG_NN1_KIND (BCG_AN1_NAME ((bcg_name_area_1), (bcg_index))))

#define BCG_N1_KIND(bcg_bcg_object, bcg_index) \
        (BCG_AN1_KIND (BCG_NAME_1 (bcg_bcg_object), (bcg_index)))

#define BCG_NN1_IDENTIFIER(bcg_name_1) \
        ((bcg_name_1)->bcg_node.bcg_dotted_kind.bcg_identifier)

#define BCG_AN1_IDENTIFIER(bcg_name_area_1, bcg_index) \
        (BCG_NN1_IDENTIFIER (BCG_AN1_NAME ((bcg_name_area_1), (bcg_index))))

#define BCG_N1_IDENTIFIER(bcg_bcg_object, bcg_index) \
        (BCG_AN1_IDENTIFIER (BCG_NAME_1 (bcg_bcg_object), (bcg_index)))

#define BCG_NN1_FILE(bcg_name_1) \
        ((bcg_name_1)->bcg_node.bcg_dotted_kind.bcg_file)

#define BCG_AN1_FILE(bcg_name_area_1, bcg_index) \
        (BCG_NN1_FILE (BCG_AN1_NAME ((bcg_name_area_1), (bcg_index))))

#define BCG_N1_FILE(bcg_bcg_object, bcg_index) \
        (BCG_AN1_FILE (BCG_NAME_1 (bcg_bcg_object), (bcg_index)))

#define BCG_NN1_LINE(bcg_name_1) \
        ((bcg_name_1)->bcg_node.bcg_dotted_kind.bcg_line)

#define BCG_AN1_LINE(bcg_name_area_1, bcg_index) \
        (BCG_NN1_LINE (BCG_AN1_NAME ((bcg_name_area_1), (bcg_index))))

#define BCG_N1_LINE(bcg_bcg_object, bcg_index) \
        (BCG_AN1_LINE (BCG_NAME_1 (bcg_bcg_object), (bcg_index)))

#define BCG_NN1_COLUMN(bcg_name_1) \
        ((bcg_name_1)->bcg_node.bcg_dotted_kind.bcg_column)

#define BCG_AN1_COLUMN(bcg_name_area_1, bcg_index) \
        (BCG_NN1_COLUMN (BCG_AN1_NAME ((bcg_name_area_1), (bcg_index))))

#define BCG_N1_COLUMN(bcg_bcg_object, bcg_index) \
        (BCG_AN1_COLUMN (BCG_NAME_1 (bcg_bcg_object), (bcg_index)))

#define BCG_NN1_INDEXES(bcg_name_1) \
        ((bcg_name_1)->bcg_node.bcg_indexed_kind.bcg_index)

#define BCG_AN1_INDEXES(bcg_name_area_1, bcg_index) \
        (BCG_NN1_INDEXES (BCG_AN1_NAME ((bcg_name_area_1), (bcg_index))))

#define BCG_N1_INDEXES(bcg_bcg_object, bcg_index) \
        (BCG_AN1_INDEXES (BCG_NAME_1 (bcg_bcg_object), (bcg_index)))

#define BCG_TN1_INDEX(bcg_name_index_1) \
        (*(bcg_name_index_1))

#define BCG_NN1_INDEX(bcg_name_1, bcg_index) \
        (BCG_TN1_INDEX ((BCG_TYPE_NAME_INDEX_1) BCG_LIST_SEARCH \
	  (BCG_NN1_INDEXES (bcg_name_1), (bcg_index))))

#define BCG_AN1_INDEX(bcg_name_area_1, bcg_name_index, bcg_index_index) \
        (BCG_NN1_INDEX (BCG_AN1_NAME ((bcg_name_area_1), \
		(bcg_name_index)), bcg_index_index))

#define BCG_N1_INDEX(bcg_bcg_object, bcg_name_index, bcg_index_index) \
        (BCG_AN1_INDEX (BCG_NAME_1 (bcg_bcg_object), \
		(bcg_name_index), (bcg_index_index)))

#define BCG_NN1_NB_INDEXES(bcg_name_1) \
	(BCG_LIST_CARDINAL (BCG_NN1_INDEXES (bcg_name_1)))

#define BCG_AN1_NB_INDEXES(bcg_name_area_1, bcg_index) \
        (BCG_NN1_NB_INDEXES (BCG_AN1_NAME ((bcg_name_area_1), (bcg_index))))

#define BCG_N1_NB_INDEXES(bcg_bcg_object, bcg_index) \
        (BCG_AN1_NB_INDEXES (BCG_NAME_1 (bcg_bcg_object), (bcg_index)))

#define BCG_NN1_NATURE(bcg_name_1) \
        ((bcg_name_1)->bcg_nature)

#define BCG_AN1_NATURE(bcg_name_area_1, bcg_index) \
        (BCG_NN1_NATURE (BCG_AN1_NAME ((bcg_name_area_1), (bcg_index))))

#define BCG_N1_NATURE(bcg_bcg_object, bcg_index) \
        (BCG_AN1_NATURE (BCG_NAME_1 (bcg_bcg_object), (bcg_index)))

#define BCG_NN1_TYPE_ENTRY(bcg_name_1) \
        ((bcg_name_1)->bcg_entry.bcg_type_entry)

#define BCG_AN1_TYPE_ENTRY(bcg_name_area_1, bcg_index) \
        (BCG_NN1_TYPE_ENTRY (BCG_AN1_NAME ((bcg_name_area_1), (bcg_index))))

#define BCG_N1_TYPE_ENTRY(bcg_bcg_object, bcg_index) \
        (BCG_AN1_TYPE_ENTRY (BCG_NAME_1 (bcg_bcg_object), (bcg_index)))

#define BCG_NN1_FUNCTION_ENTRY(bcg_name_1) \
        ((bcg_name_1)->bcg_entry.bcg_function_entry)

#define BCG_AN1_FUNCTION_ENTRY(bcg_name_area_1, bcg_index) \
        (BCG_NN1_FUNCTION_ENTRY (BCG_AN1_NAME ((bcg_name_area_1), (bcg_index))))

#define BCG_N1_FUNCTION_ENTRY(bcg_bcg_object, bcg_index) \
        (BCG_AN1_FUNCTION_ENTRY (BCG_NAME_1 (bcg_bcg_object), (bcg_index)))

#define BCG_NN1_SIGNAL_ENTRY(bcg_name_1) \
        ((bcg_name_1)->bcg_entry.bcg_signal_entry)

#define BCG_AN1_SIGNAL_ENTRY(bcg_name_area_1, bcg_index) \
        (BCG_NN1_SIGNAL_ENTRY (BCG_AN1_NAME ((bcg_name_area_1), (bcg_index))))

#define BCG_N1_SIGNAL_ENTRY(bcg_bcg_object, bcg_index) \
        (BCG_AN1_SIGNAL_ENTRY (BCG_NAME_1 (bcg_bcg_object), (bcg_index)))

#define BCG_NN1_VARIABLE_ENTRY(bcg_name_1) \
        ((bcg_name_1)->bcg_entry.bcg_variable_entry)

#define BCG_AN1_VARIABLE_ENTRY(bcg_name_area_1, bcg_index) \
        (BCG_NN1_VARIABLE_ENTRY (BCG_AN1_NAME ((bcg_name_area_1), (bcg_index))))

#define BCG_N1_VARIABLE_ENTRY(bcg_bcg_object, bcg_index) \
        (BCG_AN1_VARIABLE_ENTRY (BCG_NAME_1 (bcg_bcg_object), (bcg_index)))

/*
 * Note: Les macros ci-dessous dependent du type de la zone des arcs. Dans la
 * mesure du possible, il faut leur preferer la fonction BCG_GET_NB_EDGES () *
 */

#define BCG_AE1_NB_EDGES(bcg_edge_area_1) \
        ((bcg_edge_area_1)->bcg_nb_edges)

#define BCG_E1_NB_EDGES(bcg_bcg_object) \
        (BCG_AE1_NB_EDGES (BCG_EDGE_1 (bcg_bcg_object)))

#define BCG_AE2_NB_EDGES(bcg_edge_area_2) \
        ((bcg_edge_area_2)->bcg_nb_edges)

#define BCG_E2_NB_EDGES(bcg_bcg_object) \
        (BCG_AE2_NB_EDGES (BCG_EDGE_2 (bcg_bcg_object)))

#define BCG_AL1_LABELS(bcg_label_area_1) \
        ((bcg_label_area_1)->bcg_label)

#define BCG_L1_LABELS(bcg_bcg_object) \
        (BCG_AL1_LABELS (BCG_LABEL_1 (bcg_bcg_object)))

#define BCG_AL1_NB_LABELS(bcg_label_area_1) \
	(BCG_TABLE_CARDINAL (BCG_AL1_LABELS (bcg_label_area_1)))

#define BCG_L1_NB_LABELS(bcg_bcg_object) \
        (BCG_AL1_NB_LABELS (BCG_LABEL_1 (bcg_bcg_object)))

#define BCG_AL1_LABEL(bcg_label_area_1, bcg_index) \
        ((BCG_TYPE_LABEL_1) \
         BCG_TABLE_SEARCH (BCG_AL1_LABELS (bcg_label_area_1), (bcg_index)))

#define BCG_L1_LABEL(bcg_bcg_object, bcg_index) \
        (BCG_AL1_LABEL (BCG_LABEL_1 (bcg_bcg_object), (bcg_index)))

#define BCG_LL1_SIGNAL_PROFILE(bcg_label_1) \
        ((bcg_label_1)->bcg_signal_profile)

#define BCG_AL1_SIGNAL_PROFILE(bcg_label_area_1, bcg_index) \
        (BCG_LL1_SIGNAL_PROFILE (BCG_AL1_LABEL ((bcg_label_area_1), (bcg_index))))

#define BCG_L1_SIGNAL_PROFILE(bcg_bcg_object, bcg_index) \
        (BCG_AL1_SIGNAL_PROFILE (BCG_LABEL_1 (bcg_bcg_object), (bcg_index)))

#define BCG_LL1_SIGNAL_CONTENT(bcg_label_1) \
        ((bcg_label_1)->bcg_signal_content)

#define BCG_AL1_SIGNAL_CONTENT(bcg_label_area_1, bcg_index) \
        (BCG_LL1_SIGNAL_CONTENT (BCG_AL1_LABEL ((bcg_label_area_1), (bcg_index))))

#define BCG_L1_SIGNAL_CONTENT(bcg_bcg_object, bcg_index) \
        (BCG_AL1_SIGNAL_CONTENT (BCG_LABEL_1 (bcg_bcg_object), (bcg_index)))

#define BCG_LL1_SIGNAL_SIZE(bcg_label_1) \
        ((bcg_label_1)->bcg_signal_size)

#define BCG_AL1_SIGNAL_SIZE(bcg_label_area_1, bcg_index) \
        (BCG_LL1_SIGNAL_SIZE (BCG_AL1_LABEL ((bcg_label_area_1), (bcg_index))))

#define BCG_L1_SIGNAL_SIZE(bcg_bcg_object, bcg_index) \
        (BCG_AL1_SIGNAL_SIZE (BCG_LABEL_1 (bcg_bcg_object), (bcg_index)))

#define BCG_LL1_SIGNAL_STRING(bcg_label_1) \
        ((bcg_label_1)->bcg_signal_string)

#define BCG_AL1_SIGNAL_STRING(bcg_label_area_1, bcg_index) \
        (BCG_LL1_SIGNAL_STRING (BCG_AL1_LABEL ((bcg_label_area_1), (bcg_index))))

#define BCG_L1_SIGNAL_STRING(bcg_bcg_object, bcg_index) \
        (BCG_AL1_SIGNAL_STRING (BCG_LABEL_1 (bcg_bcg_object), (bcg_index)))

#define BCG_LL1_SIGNAL_STRING_LIST(bcg_label_1) \
        ((bcg_label_1)->bcg_signal_string_list)

#define BCG_AL1_SIGNAL_STRING_LIST(bcg_label_area_1, bcg_index) \
        (BCG_LL1_SIGNAL_STRING_LIST (BCG_AL1_LABEL ((bcg_label_area_1), (bcg_index))))

#define BCG_L1_SIGNAL_STRING_LIST(bcg_bcg_object, bcg_index) \
        (BCG_AL1_SIGNAL_STRING_LIST (BCG_LABEL_1 (bcg_bcg_object), (bcg_index)))

#define BCG_LL1_VISIBLE(bcg_label_1) \
        ((bcg_label_1)->bcg_visible)

#define BCG_AL1_VISIBLE(bcg_label_area_1, bcg_index) \
        (BCG_LL1_VISIBLE (BCG_AL1_LABEL ((bcg_label_area_1), (bcg_index))))

#define BCG_L1_VISIBLE(bcg_bcg_object, bcg_index) \
        (BCG_AL1_VISIBLE (BCG_LABEL_1 (bcg_bcg_object), (bcg_index)))

/*
 * Note: Les deux macros ci-dessous dependent du type de la zone des etats.
 * Dans la mesure du possible, il faut leur preferer la fonction
 * BCG_GET_NB_STATES ()
 */

#define BCG_AS1_NB_STATES(bcg_state_area_1) \
        ((bcg_state_area_1)->bcg_nb_states)

#define BCG_S1_NB_STATES(bcg_bcg_object) \
        (BCG_AS1_NB_STATES (BCG_STATE_1 (bcg_bcg_object)))

/*
 * Note: Les deux macros ci-dessous dependent du type de la zone des etats.
 * Dans la mesure du possible, il faut leur preferer la fonction
 * BCG_GET_INITIAL_STATES ()
 */

#define BCG_AS1_INITIAL_STATE(bcg_state_area_1) \
        ((bcg_state_area_1)->bcg_initial_state)

#define BCG_S1_INITIAL_STATE(bcg_bcg_object) \
        (BCG_AS1_INITIAL_STATE (BCG_STATE_1 (bcg_bcg_object)))

#define BCG_AS1_VARIABLE_PROFILE(bcg_state_area_1) \
        ((bcg_state_area_1)->bcg_variable_profile)

#define BCG_S1_VARIABLE_PROFILE(bcg_bcg_object) \
        (BCG_AS1_VARIABLE_PROFILE (BCG_STATE_1 (bcg_bcg_object)))

#define BCG_AC1_NB_CLASSES(bcg_class_area_1) \
        ((bcg_class_area_1)->bcg_nb_classes)

#define BCG_C1_NB_CLASSES(bcg_bcg_object) \
        (BCG_AC1_NB_CLASSES (BCG_CLASS_1 (bcg_bcg_object)))

#ifdef BCG_UNDEFINED
{
#endif

#ifdef __cplusplus
}
#endif

#endif
