/******************************************************************************
 *                                X T L
 *-----------------------------------------------------------------------------
 *   INRIA - Unite de Recherche Rhone-Alpes
 *   655, avenue de l'Europe
 *   38330 Montbonnot Saint Martin
 *   FRANCE
 *-----------------------------------------------------------------------------
 *   Module             :       xtl_predefined_declarations.h
 *   Auteur             :       Radu MATEESCU
 *   Version            :       1.19
 *   Date               :       2018/01/12 16:20:05
 *****************************************************************************/

#ifndef XTL_PREDEFINED_DECLARATIONS_INTERFACE
#define XTL_PREDEFINED_DECLARATIONS_INTERFACE

#include "xtl_action.h"
#include "xtl_number.h"
#include "xtl_state_label_edge.h"
#include "xtl_nb_labels.h"

#define XTL_ABORT(XTL_FILENAME, XTL_LINE_NUMBER) \
	((void) fprintf (stdout, "###  run-time error:\n     assertion failed [%s:%d]\n     quit\n\n", (XTL_FILENAME), (XTL_LINE_NUMBER)), exit (1), 0)

#define XTL_ERROR(XTL_MESSAGE) \
	((void) fprintf (stdout, "###  run-time error:\n     %s\n     quit\n\n", (XTL_MESSAGE)), exit (1), 0)

/*****
 * Implementation des iterateurs sur les sous-domaines des types BCG predefinis
 *****/

#define XTL_BOOLEAN_BOUNDED_ENUM(XTL_ITER, XTL_LIM_1, XTL_LIM_2) \
	XTL_GENERIC_BOUNDED_ENUM (                               \
		(XTL_ITER),                                      \
		((bcg_type_boolean) XTL_LIM_1),                  \
		((bcg_type_boolean) XTL_LIM_2)                   \
	)

#define XTL_NATURAL_BOUNDED_ENUM(XTL_ITER, XTL_LIM_1, XTL_LIM_2) \
	XTL_GENERIC_BOUNDED_ENUM (                               \
		(XTL_ITER),                                      \
		((bcg_type_natural) XTL_LIM_1),                  \
		((bcg_type_natural) XTL_LIM_2)                   \
	)

#define XTL_INTEGER_BOUNDED_ENUM(XTL_ITER, XTL_LIM_1, XTL_LIM_2) \
	XTL_GENERIC_BOUNDED_ENUM (                               \
		(XTL_ITER),                                      \
		((bcg_type_integer) XTL_LIM_1),                  \
		((bcg_type_integer) XTL_LIM_2)                   \
	)

#define XTL_CHARACTER_BOUNDED_ENUM(XTL_ITER, XTL_LIM_1, XTL_LIM_2) \
	XTL_GENERIC_BOUNDED_ENUM (                                 \
		(XTL_ITER),                                        \
		((bcg_type_character) XTL_LIM_1),                  \
		((bcg_type_character) XTL_LIM_2)                   \
	)

#endif

/*****
 * Implementation des operateurs ``replace'' pour les types predefinis
 *****/

#define XTL_BOOLEAN_REPLACE(XTL_1, XTL_2)	(XTL_2)

#define XTL_NATURAL_REPLACE(XTL_1, XTL_2)	(XTL_2)

#define XTL_INTEGER_REPLACE(XTL_1, XTL_2)	(XTL_2)

#define XTL_REAL_REPLACE(XTL_1, XTL_2)		(XTL_2)

#define XTL_CHARACTER_REPLACE(XTL_1, XTL_2)	(XTL_2)

#define XTL_STRING_REPLACE(XTL_1, XTL_2)	(XTL_2)

#define XTL_RAW_REPLACE(XTL_1, XTL_2)		(XTL_2)

/*****
 * Operateur printf() sur les valeurs de type ``string''
 *****/

/*
 * XTL_STRING_PRINTF(S) est similaire a bcg_string_print(XTL_RESULT_STREAM,
 * S) mais il interprete les sequences d'echappement (par exemple, '\n',
 * '\t', etc.) contenues dans S alors que bcg_string_print() les affiche en
 * octal
 */

#define XTL_STRING_PRINTF(S) (XTL_TYPE_ACTION) fputs ((S), (XTL_RESULT_STREAM))
