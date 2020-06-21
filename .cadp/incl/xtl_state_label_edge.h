/******************************************************************************
 *                                X T L
 *-----------------------------------------------------------------------------
 *   INRIA - Unite de Recherche Rhone-Alpes
 *   655, avenue de l'Europe
 *   38330 Montbonnot Saint Martin
 *   FRANCE
 *-----------------------------------------------------------------------------
 *   Module             :       xtl_state_label_edge.h
 *   Auteur             :       Radu MATEESCU
 *   Version            :       1.6
 *   Date               :       2019/05/29 10:26:22
 *****************************************************************************/

#ifndef XTL_STATE_LABEL_EDGE_INTERFACE
#define XTL_STATE_LABEL_EDGE_INTERFACE

#include <stdlib.h>
#include "bcg_file_1.h"
#include "bcg_read_1.h"
#include "bcg_push_pull.h"
#include "bcg_access_2.h"
#include "bcg_object_2.h"
#include "bcg_transition.h"
#include "bcg_iterator.h"
#include "xtl_action.h"

typedef BCG_TYPE_STATE_NUMBER XTL_TYPE_STATE;

#define XTL_STATE_ENUM(XTL_STATE) \
	for ((XTL_STATE) = (XTL_TYPE_STATE) 0; (XTL_STATE) < (XTL_TYPE_STATE) XTL_BCG_NB_STATES; (XTL_STATE)++)

#define XTL_STATE_NUMBER(XTL_STATE) \
	((XTL_TYPE_NUMBER) (XTL_STATE))

#define XTL_STATE_INIT() ((XTL_TYPE_STATE) XTL_BCG_INIT_STATE)

#define XTL_STATE_ASSIGN(XTL_STATE_1, XTL_STATE_2) \
	((XTL_STATE_1) = (XTL_STATE_2))

#define XTL_STATE_EQUAL(XTL_STATE_1, XTL_STATE_2) \
	((XTL_STATE_1) == (XTL_STATE_2))

#define XTL_STATE_NOT_EQUAL(XTL_STATE_1, XTL_STATE_2) \
	((XTL_STATE_1) != (XTL_STATE_2))

#define XTL_STATE_REPLACE(XTL_STATE_1, XTL_STATE_2)	(XTL_STATE_2)

typedef BCG_TYPE_LABEL_NUMBER XTL_TYPE_LABEL;

#define XTL_LABEL_ENUM(XTL_LABEL) \
	for ((XTL_LABEL) = (XTL_TYPE_LABEL) 0; (XTL_LABEL) < (XTL_TYPE_LABEL) XTL_BCG_NB_LABELS; (XTL_LABEL)++)

#define XTL_LABEL_NUMBER(XTL_LABEL) \
	((XTL_TYPE_NUMBER) (XTL_LABEL))

#define XTL_LABEL_ASSIGN(XTL_LABEL_1, XTL_LABEL_2) \
	((XTL_LABEL_1) = (XTL_LABEL_2))

#define XTL_LABEL_EQUAL(XTL_LABEL_1, XTL_LABEL_2) \
	((XTL_LABEL_1) == (XTL_LABEL_2))

#define XTL_LABEL_NOT_EQUAL(XTL_LABEL_1, XTL_LABEL_2) \
	((XTL_LABEL_1) != (XTL_LABEL_2))

#define XTL_LABEL_REPLACE(XTL_LABEL_1, XTL_LABEL_2)	(XTL_LABEL_2)

typedef BCG_TYPE_EDGE_NUMBER XTL_TYPE_EDGE;

#define XTL_EDGE_ENUM(XTL_EDGE) \
	for ((XTL_EDGE) = (XTL_TYPE_EDGE) 0; (XTL_EDGE) < (XTL_TYPE_EDGE) XTL_BCG_NB_EDGES; (XTL_EDGE)++)

#define XTL_EDGE_NUMBER(XTL_EDGE) \
	((XTL_TYPE_NUMBER) (XTL_EDGE))

#define XTL_EDGE_ASSIGN(XTL_EDGE_1, XTL_EDGE_2) \
	((XTL_EDGE_1) = (XTL_EDGE_2))

#define XTL_EDGE_EQUAL(XTL_EDGE_1, XTL_EDGE_2) \
	((XTL_EDGE_1) == (XTL_EDGE_2))

#define XTL_EDGE_NOT_EQUAL(XTL_EDGE_1, XTL_EDGE_2) \
	((XTL_EDGE_1) != (XTL_EDGE_2))

#define XTL_EDGE_REPLACE(XTL_EDGE_1, XTL_EDGE_2)	(XTL_EDGE_2)

#define XTL_STATESET_REPLACE(XTL_1, XTL_2)	(XTL_2)

#define XTL_LABELSET_REPLACE(XTL_1, XTL_2)	(XTL_2)

#define XTL_EDGESET_REPLACE(XTL_1, XTL_2)	(XTL_2)

extern XTL_TYPE_ACTION XTL_STATE_PRINT ();
extern bcg_type_boolean XTL_LABEL_VISIBLE ();
extern char *XTL_LABEL_STRING ();
extern XTL_TYPE_ACTION XTL_LABEL_PRINT ();
extern XTL_TYPE_STATE XTL_EDGE_SOURCE ();
extern XTL_TYPE_LABEL XTL_EDGE_LABEL ();
extern XTL_TYPE_STATE XTL_EDGE_TARGET ();
extern bcg_type_boolean XTL_EDGE_VISIBLE ();
extern XTL_TYPE_ACTION XTL_EDGE_PRINT ();

#endif
