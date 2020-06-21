/******************************************************************************
 *                                X T L
 *-----------------------------------------------------------------------------
 *   INRIA - Unite de Recherche Rhone-Alpes
 *   655, avenue de l'Europe
 *   38330 Montbonnot Saint Martin
 *   FRANCE
 *-----------------------------------------------------------------------------
 *   Module             :       xtl_number.h
 *   Auteur             :       Radu MATEESCU
 *   Version            :       1.3
 *   Date               :       2014/10/13 15:47:47
 *****************************************************************************/

#ifndef XTL_NUMBER_INTERFACE
#define XTL_NUMBER_INTERFACE

#include <math.h>

#include "caesar_system.h"
#include "bcg_standard.h"
#include "xtl_standard.h"

typedef BCG_TYPE_LONG_NATURAL XTL_TYPE_NUMBER;

#define XTL_MAX_LIMIT_NUMBER	((XTL_TYPE_NUMBER) (~((XTL_TYPE_NUMBER) 0)))

#define XTL_NUMBER_ASSIGN(XTL_ARG_1, XTL_ARG_2) \
	((XTL_ARG_1) = (XTL_ARG_2))

#define XTL_NUMBER_EQUAL(XTL_ARG_1, XTL_ARG_2) \
	(((XTL_ARG_1) == (XTL_ARG_2)) ? ((bcg_type_boolean) 1) : \
					((bcg_type_boolean) 0))

#define XTL_NUMBER_NOT_EQUAL(XTL_ARG_1, XTL_ARG_2) \
	(((XTL_ARG_1) != (XTL_ARG_2)) ? ((bcg_type_boolean) 1) : \
					((bcg_type_boolean) 0))

#define XTL_NUMBER_ENUM(XTL_N) \
	for ((XTL_N) = (XTL_TYPE_NUMBER) 0; (XTL_N) < XTL_MAX_LIMIT_NUMBER; (XTL_N)++)

#define XTL_NUMBER_BOUNDED_ENUM(XTL_ITER, XTL_LIM_1, XTL_LIM_2) \
	XTL_GENERIC_BOUNDED_ENUM (                               \
		(XTL_ITER),                                      \
		((XTL_TYPE_NUMBER) XTL_LIM_1),                  \
		((XTL_TYPE_NUMBER) XTL_LIM_2)                   \
	)

#define XTL_NUMBER_ADD(XTL_N1, XTL_N2)		((XTL_N1) + (XTL_N2))

#define XTL_NUMBER_SUB(XTL_N1, XTL_N2)		((XTL_N1) - (XTL_N2))

#define XTL_NUMBER_MUL(XTL_N1, XTL_N2)		((XTL_N1) * (XTL_N2))

#define XTL_NUMBER_DIV(XTL_N1, XTL_N2)		((XTL_N1) / (XTL_N2))

#define XTL_NUMBER_MOD(XTL_N1, XTL_N2)		((XTL_N1) % (XTL_N2))

#define XTL_NUMBER_POW(XTL_BASE, XTL_EXP) \
	((XTL_TYPE_NUMBER) pow ((double) (XTL_BASE), (double) (XTL_EXP)))

#define XTL_NUMBER_LT(XTL_N1, XTL_N2)		((XTL_N1) < (XTL_N2))

#define XTL_NUMBER_LE(XTL_N1, XTL_N2)		((XTL_N1) <= (XTL_N2))

#define XTL_NUMBER_GT(XTL_N1, XTL_N2)		((XTL_N1) > (XTL_N2))

#define XTL_NUMBER_GE(XTL_N1, XTL_N2)		((XTL_N1) >= (XTL_N2))

extern XTL_TYPE_NUMBER XTL_CONV_CHARACTER_TO_NUMBER ();
extern bcg_type_character XTL_CONV_NUMBER_TO_CHARACTER ();
extern XTL_TYPE_NUMBER XTL_CONV_INTEGER_TO_NUMBER ();
extern bcg_type_integer XTL_CONV_NUMBER_TO_INTEGER ();
extern XTL_TYPE_NUMBER XTL_CONV_REAL_TO_NUMBER ();
extern bcg_type_real XTL_CONV_NUMBER_TO_REAL ();

#define XTL_NUMBER_REPLACE(XTL_N1, XTL_N2)	(XTL_N2)

#define XTL_NUMBER_PRINT(XTL_STREAM, XTL_ARG) \
	((XTL_TYPE_ACTION) (fprintf ((XTL_STREAM), "%lu", (XTL_ARG))))

#endif
