/******************************************************************************
 *                                X T L
 *-----------------------------------------------------------------------------
 *   INRIA - Unite de Recherche Rhone-Alpes
 *   655, avenue de l'Europe
 *   38330 Montbonnot Saint Martin
 *   FRANCE
 *-----------------------------------------------------------------------------
 *   Module             :       xtl_bcg_interface.h
 *   Auteur             :       Radu MATEESCU
 *   Version            :       1.10
 *   Date               :       2014/12/19 15:45:43
 *****************************************************************************/

#ifndef XTL_BCG_INTERFACE_INTERFACE
#define XTL_BCG_INTERFACE_INTERFACE

#include "bcg_standard.h"
#include "bcg_types.h"
#include "bcg_area.h"
#include "bcg_file_1.h"
#include "xtl_state_label_edge.h"

/*
 * Operateurs pour le nombre d'etats, de transitions et d'etiquettes du
 * graphe
 */

#define XTL_NUMBER_OF_STATES()		XTL_BCG_NB_STATES

#define XTL_NUMBER_OF_EDGES()		XTL_BCG_NB_EDGES

#define XTL_NUMBER_OF_LABELS()		XTL_BCG_NB_LABELS

extern unsigned XTL_GET_BCG_EDGE_NB_FIELDS BCG_ARG_1 (XTL_TYPE_EDGE);
extern unsigned XTL_GET_BCG_LABEL_NB_FIELDS BCG_ARG_1 (XTL_TYPE_LABEL);

extern unsigned XTL_GET_BCG_EDGE_FIELD_TYPE BCG_ARG_2 (XTL_TYPE_EDGE, unsigned);
extern unsigned XTL_GET_BCG_LABEL_FIELD_TYPE BCG_ARG_2 (XTL_TYPE_LABEL, unsigned);

extern BCG_TYPE_ADDRESS XTL_GET_BCG_EDGE_FIELD BCG_ARG_2 (XTL_TYPE_EDGE, unsigned);
extern BCG_TYPE_ADDRESS XTL_GET_BCG_LABEL_FIELD BCG_ARG_2 (XTL_TYPE_LABEL, unsigned);

#endif
