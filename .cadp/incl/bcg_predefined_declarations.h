/******************************************************************************
 *                                B C G
 *-----------------------------------------------------------------------------
 *   INRIA - Unite de Recherche Rhone-Alpes
 *   655, avenue de l'Europe
 *   38330 Montbonnot Saint Martin
 *   FRANCE
 *-----------------------------------------------------------------------------
 *   Module             :       bcg_predefined_declarations.h
 *   Auteurs            :       Renaud RUFFIOT, Radu MATEESCU et Hubert GARAVEL
 *   Version            :       1.42
 *   Date               :       2014/12/23 12:02:25
 *****************************************************************************/

#ifndef BCG_PREDEFINED_DECLARATIONS_INTERFACE

#define BCG_PREDEFINED_DECLARATIONS_INTERFACE

#ifdef __cplusplus
extern "C" {
#endif

#ifdef BCG_UNDEFINED
}
#endif

#define BCG_VERSION_PREDEFINED_DECLARATIONS 2

/*
 * attention, ce fichier ne doit contenir (directement ou transitivement)
 * aucun identificateur Bcg_xxx, car XTL l'inclut sans lui appliquer
 * bcg_expand
 */

/*
 * emulation (totale) des macros bcg_string_length et bcg_raw_length
 * introduites dans la zone des inclusions des fichiers BCG produits a partir
 * de CADP 2015-a inclus : les fichiers BCG produits depuis l'origine de CADP
 * jusqu'a CADP 2014-l inclus contiennent, dans leur zone des inclusions, une
 * macro-definition bcg_max_string_size que l'on reutilise pour definir
 * bcg_string_length et bcg_raw_length
 */

#ifdef bcg_max_string_size
#define bcg_string_length bcg_max_string_size
#define bcg_raw_length bcg_max_string_size
#endif

#include <math.h>
#include "bcg_push_pull.h"
#include "bcg_file_1.h"
#include "bcg_read_1.h"
#include "bcg_write_1.h"

#include "adt_boolean.h"
#include "adt_natural.h"
#include "adt_integer.h"
#include "adt_real.h"
#include "adt_character.h"
#include "adt_string.h"
#include "adt_raw.h"

#if defined (BCG_PREDEFINED_DECLARATIONS_SPECIAL_INCLUSION_2)

#include "adt_gate.h"

#elif defined (bcg_gate_size) && (bcg_gate_size > 0)
/*
 * cas d'un fichier BCG produit par une version de CADP posterieure a CADP
 * 2014-l inclus et comportant des valeurs de type porte
 */

#include "adt_gate.h"

#endif

#define bcg_pow_nn_n(bcg_1,bcg_2)		\
	((bcg_type_natural) pow ((double)(bcg_1), (double)(bcg_2)))

#define bcg_pow_ii_i(bcg_1,bcg_2)		\
	((bcg_type_integer) pow ((double)(bcg_1), (double)(bcg_2)))

#define bcg_extract_si_c(bcg_1,bcg_2)	\
	((bcg_1) [(bcg_2)])

#define bcg_equal_ss_b(bcg_1,bcg_2)		\
	(strcmp ((char *)(bcg_1), (char *)(bcg_2)) == 0)

#define bcg_not_equal_ss_b(bcg_1,bcg_2)	\
	(strcmp ((char *)(bcg_1), (char *)(bcg_2)) != 0)

#define bcg_extract_xn_c(bcg_1,bcg_2)	    bcg_extract_si_c(bcg_1,bcg_2)
#define bcg_equal_xx_b(bcg_1,bcg_2)	    bcg_equal_ss_b(bcg_1,bcg_2)
#define bcg_not_equal_xx_b(bcg_1,bcg_2)	    bcg_not_equal_ss_b(bcg_1,bcg_2)

#ifdef BCG_UNDEFINED
{
#endif

#ifdef __cplusplus
}
#endif

#endif
