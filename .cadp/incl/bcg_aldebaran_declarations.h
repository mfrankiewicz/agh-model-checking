/******************************************************************************
 *                                B C G
 *-----------------------------------------------------------------------------
 *   INRIA - Unite de Recherche Rhone-Alpes
 *   655, avenue de l'Europe
 *   38330 Montbonnot Saint Martin
 *   FRANCE
 *-----------------------------------------------------------------------------
 *   Module             :       bcg_aldebaran_declarations.h
 *   Auteurs            :       Renaud RUFFIOT, Radu MATEESCU et Hubert GARAVEL
 *   Version            :       1.37
 *   Date               :       2014/12/23 12:05:45
 *****************************************************************************/

#ifndef BCG_ALDEBARAN_DECLARATIONS_INTERFACE

#define BCG_ALDEBARAN_DECLARATIONS_INTERFACE

#ifdef __cplusplus
extern "C" {
#endif

#ifdef BCG_UNDEFINED
}
#endif

/*
 * le present fichier assure la compatibilite ascendante avec les fichiers
 * BCG produits par les versions de CADP depuis l'origine jusqu'a 2014-l
 * inclus ; les nouveaux fichiers BCG produits a partir de CADP 2015-a inclus
 * n'utilisent plus ce fichier
 */

#define BCG_VERSION_ALDEBARAN_DECLARATIONS 2	

/*
 * les fichiers BCG produits jusqu'a CADP 2014-l inclus comportent des
 * valeurs de type STRING qui, pour preserver la compatibilite ascendante,
 * doivent desormais etre affichees avec bcg_raw_print() et non plus
 * bcg_string_print() qui a ete modifie
 */

#undef bcg_string_print
#define bcg_string_print bcg_raw_print

/*
 * emulation (totale) de la macro bcg_gate_size introduite dans la zone des
 * inclusions des fichiers BCG produits a partir de CADP 2015-a inclus :  les
 * fichiers BCG produits depuis l'origine de CADP jusqu'a CADP 2014-l inclus
 * contiennent, dans leur zone des inclusions, une macro-definition
 * bcg_aldebaran_gate_compressed_size que l'on reutilise pour definir
 * bcg_gate_size
 */

#define bcg_gate_size bcg_aldebaran_gate_compressed_size

/*
 * emulation (partielle) de la macro bcg_nb_gates introduite dans la zone des
 * inclusions des fichiers BCG produits a partir de CADP 2015-a inclus
 */

#if defined (BCG_NB_GATES)
/*
 * cas des fichiers BCG produits depuis l'origine de CADP jusqu'a CADP 2008-a
 * inclus : leur zone des inclusions comportait une macro-definition
 * BCG_NB_GATES que l'on reutilise pour definir bcg_nb_gates
 */
#define bcg_nb_gates BCG_NB_GATES
#else
/*
 * cas des fichiers BCG produits entre CADP 2008-b inclus et CADP 2014-l
 * inclus : leur zone des inclusions ne comporte aucune information sur le
 * nombre de portes ; le fichier "adt_gate.h" devra calculer ce nombre
 * dynamiquement et le stocker dans une variable appelee bcg_nb_gates
 */
#endif

#if bcg_gate_size > 0

#include "adt_gate.h"

#endif

/*
 * code de retro-compatibilite pour traiter les fichiers BCG produits par
 * CADP depuis l'origine jusqu'a CADP 2014-l inclus
 */

#define bcg_type_aldebaran_gate   bcg_type_gate
#define bcg_aldebaran_gate_assign bcg_gate_assign
#define bcg_aldebaran_gate_cmp    bcg_gate_cmp
#define bcg_aldebaran_gate_enum   bcg_gate_enum
#define bcg_aldebaran_gate_print  bcg_gate_print
#define bcg_aldebaran_gate_write  bcg_gate_write
#define bcg_aldebaran_gate_read   bcg_gate_read

#ifdef BCG_UNDEFINED
{
#endif

#ifdef __cplusplus
}
#endif

#endif
