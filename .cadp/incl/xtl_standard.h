/******************************************************************************
 *                                X T L
 *-----------------------------------------------------------------------------
 *   INRIA - Unite de Recherche Rhone-Alpes
 *   655, avenue de l'Europe
 *   38330 Montbonnot Saint Martin
 *   FRANCE
 *-----------------------------------------------------------------------------
 *   Module             :       xtl_standard.h
 *   Auteur             :       Radu MATEESCU
 *   Version            :       1.15
 *   Date               :       2014/07/08 13:24:15
 *****************************************************************************/

#ifndef XTL_STANDARD_INTERFACE
#define XTL_STANDARD_INTERFACE

#include <string.h>
#include <stdio.h>

#ifndef BCG_PREDEFINED_DECLARATIONS_INTERFACE

/*
 * On importe la definition en C des types suivants : bcg_type_boolean,
 * bcg_type_integer, bcg_type_real et bcg_type_character
 */

#include "adt_boolean.h"
#include "adt_integer.h"
#include "adt_real.h"
#include "adt_character.h"

#endif

#define xtl_streq(XTL_STRING_1, XTL_STRING_2) \
	(strcmp ((XTL_STRING_1), (XTL_STRING_2)) == 0)

#define XTL_LINT_RETURN(XTL_VAR)		return (XTL_VAR)

#define XTL_INITIALIZE(XTL_VAR)		(XTL_VAR) = 0

typedef enum xtl_enum_boolean {
     XTL_FALSE, XTL_TRUE
}    XTL_TYPE_BOOLEAN;

#define XTL_GENERIC_BOUNDED_ENUM(XTL_ITER, XTL_LIM_1, XTL_LIM_2) \
	for ((XTL_ITER) = (XTL_LIM_1); (XTL_ITER) <= (XTL_LIM_2); (XTL_ITER)++)

#endif
