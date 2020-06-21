/******************************************************************************
 *                                X T L
 *-----------------------------------------------------------------------------
 *   INRIA - Unite de Recherche Rhone-Alpes
 *   655, avenue de l'Europe
 *   38330 Montbonnot Saint Martin
 *   FRANCE
 *-----------------------------------------------------------------------------
 *   Module             :       xtl_action.h
 *   Auteur             :       Radu MATEESCU
 *   Version            :       1.8
 *   Date               :       2009/06/30 17:31:55
 *****************************************************************************/

#ifndef XTL_ACTION_INTERFACE
#define XTL_ACTION_INTERFACE

#include "caesar_system.h"
#include "xtl_standard.h"

typedef char XTL_TYPE_ACTION;

#define XTL_ACTION_NOP() ((XTL_TYPE_ACTION) '\0')

#define XTL_ACTION_FBY(XTL_ARG_1, XTL_ARG_2) \
	((XTL_TYPE_ACTION) ((void) (XTL_ARG_1), (XTL_ARG_2)))

#define XTL_ACTION_ASSIGN(XTL_ARG_1, XTL_ARG_2) \
	((XTL_ARG_1) = (XTL_ARG_2), (void) (XTL_ARG_1))

#define XTL_ACTION_EQUAL(XTL_ARG_1, XTL_ARG_2) \
	(((XTL_ARG_1) == (XTL_ARG_2)) ? ((bcg_type_boolean) 1) : \
					((bcg_type_boolean) 0))

#define XTL_ACTION_NOT_EQUAL(XTL_ARG_1, XTL_ARG_2) \
	(((XTL_ARG_1) != (XTL_ARG_2)) ? ((bcg_type_boolean) 1) : \
					((bcg_type_boolean) 0))

#define XTL_ACTION_PRINT(XTL_STREAM, XTL_ARG) \
	((XTL_TYPE_ACTION) (fprintf ((XTL_STREAM), "<action>")))

#endif
