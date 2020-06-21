/******************************************************************************
 *                           O P E N / C A E S A R
 *-----------------------------------------------------------------------------
 *   INRIA - Unite de Recherche Rhone-Alpes
 *   655, avenue de l'Europe
 *   38330 Montbonnot Saint Martin
 *   FRANCE
 *-----------------------------------------------------------------------------
 *   Module             :       caesar_edge.h
 *   Auteur             :       Hubert GARAVEL
 *   Version            :       1.23
 *   Date               :       2017/09/04 15:32:41
 *****************************************************************************/

#ifndef CAESAR_EDGE_INTERFACE

#define CAESAR_EDGE_INTERFACE

#ifdef __cplusplus
extern "C" {
#endif

#ifdef CAESAR_UNDEFINED
}
#endif

/*****************************************************************************/

#include "caesar_graph.h"

/*---------------------------------------------------------------------------*/

typedef CAESAR_TYPE_ABSTRACT_POINTER (CAESAR_STRUCT_EDGE) CAESAR_TYPE_EDGE;

/*---------------------------------------------------------------------------*/

extern void CAESAR_INIT_EDGE CAESAR_ARG_5 (CAESAR_PROMOTE_TO_INT (CAESAR_TYPE_BOOLEAN), CAESAR_PROMOTE_TO_INT (CAESAR_TYPE_BOOLEAN), CAESAR_PROMOTE_TO_INT (CAESAR_TYPE_BOOLEAN), CAESAR_TYPE_NATURAL, CAESAR_TYPE_NATURAL);

/*---------------------------------------------------------------------------*/

extern CAESAR_TYPE_NATURAL CAESAR_SIZE_EDGE CAESAR_ARG_0 ();

/*---------------------------------------------------------------------------*/

extern CAESAR_TYPE_NATURAL CAESAR_ALIGNMENT_EDGE CAESAR_ARG_0 ();

/*---------------------------------------------------------------------------*/

extern CAESAR_TYPE_STATE CAESAR_PREVIOUS_STATE_EDGE CAESAR_ARG_1 (CAESAR_TYPE_EDGE);

/*---------------------------------------------------------------------------*/

extern CAESAR_TYPE_LABEL CAESAR_LABEL_EDGE CAESAR_ARG_1 (CAESAR_TYPE_EDGE);

/*---------------------------------------------------------------------------*/

extern CAESAR_TYPE_STATE CAESAR_NEXT_STATE_EDGE CAESAR_ARG_1 (CAESAR_TYPE_EDGE);

/*---------------------------------------------------------------------------*/

extern CAESAR_TYPE_POINTER CAESAR_MARK_EDGE CAESAR_ARG_1 (CAESAR_TYPE_EDGE);

/*---------------------------------------------------------------------------*/

extern CAESAR_TYPE_EDGE *CAESAR_SUCCESSOR_EDGE CAESAR_ARG_1 (CAESAR_TYPE_EDGE);

/*---------------------------------------------------------------------------*/

extern void CAESAR_CREATE_EDGE CAESAR_ARG_1 (CAESAR_TYPE_EDGE *);

/*---------------------------------------------------------------------------*/

extern void CAESAR_DELETE_EDGE CAESAR_ARG_1 (CAESAR_TYPE_EDGE *);

/*---------------------------------------------------------------------------*/

extern void CAESAR_COPY_EDGE CAESAR_ARG_2 (CAESAR_TYPE_EDGE, CAESAR_TYPE_EDGE);

/*---------------------------------------------------------------------------*/

extern CAESAR_TYPE_FORMAT CAESAR_FORMAT_EDGE CAESAR_ARG_1 (CAESAR_PROMOTE_TO_INT (CAESAR_TYPE_FORMAT));

/*---------------------------------------------------------------------------*/

/* deprecated primitive, kept as a macro for backward compatibility */
#define CAESAR_MAX_FORMAT_EDGE() (CAESAR_FORMAT_EDGE (CAESAR_MAXIMAL_FORMAT))

/*---------------------------------------------------------------------------*/

extern void CAESAR_PRINT_EDGE CAESAR_ARG_2 (CAESAR_TYPE_FILE, CAESAR_TYPE_EDGE);

/* ======================================================================== */

extern void CAESAR_CREATE_EDGE_LIST CAESAR_ARG_3 (CAESAR_TYPE_STATE, CAESAR_TYPE_EDGE *, CAESAR_TYPE_NATURAL);

/*---------------------------------------------------------------------------*/

extern CAESAR_TYPE_NATURAL CAESAR_MAX_ORDER_EDGE_LIST CAESAR_ARG_0 ();

/*---------------------------------------------------------------------------*/

extern void CAESAR_DELETE_EDGE_LIST CAESAR_ARG_1 (CAESAR_TYPE_EDGE *);

/*---------------------------------------------------------------------------*/

extern void CAESAR_COPY_EDGE_LIST CAESAR_ARG_2 (CAESAR_TYPE_EDGE *, CAESAR_TYPE_EDGE);

/*---------------------------------------------------------------------------*/

extern CAESAR_TYPE_NATURAL CAESAR_CREATION_EDGE_LIST CAESAR_ARG_0 ();

/*---------------------------------------------------------------------------*/

extern CAESAR_TYPE_NATURAL CAESAR_TRUNCATION_EDGE_LIST CAESAR_ARG_0 ();

/*---------------------------------------------------------------------------*/

extern CAESAR_TYPE_FORMAT CAESAR_FORMAT_EDGE_LIST CAESAR_ARG_1 (CAESAR_PROMOTE_TO_INT (CAESAR_TYPE_FORMAT));

/*---------------------------------------------------------------------------*/

/* deprecated primitive, kept as a macro for backward compatibility */
#define CAESAR_MAX_FORMAT_EDGE_LIST() (CAESAR_FORMAT_EDGE_LIST (CAESAR_MAXIMAL_FORMAT))

/*---------------------------------------------------------------------------*/

extern void CAESAR_PRINT_EDGE_LIST CAESAR_ARG_2 (CAESAR_TYPE_FILE, CAESAR_TYPE_EDGE);

/* ======================================================================== */

#define CAESAR_SELECT_P_EDGE(CAESAR_E,CAESAR_S1) \
	((CAESAR_S1) = CAESAR_PREVIOUS_STATE_EDGE ((CAESAR_E)))

#define CAESAR_SELECT_L_EDGE(CAESAR_E,CAESAR_L) \
	((CAESAR_L) = CAESAR_LABEL_EDGE ((CAESAR_E)))

#define CAESAR_SELECT_N_EDGE(CAESAR_E,CAESAR_S2) \
	((CAESAR_S2) = CAESAR_NEXT_STATE_EDGE ((CAESAR_E)))

#define CAESAR_SELECT_M_EDGE(CAESAR_E,CAESAR_M) \
	((CAESAR_M) = CAESAR_MARK_EDGE ((CAESAR_E)))

/*---------------------------------------------------------------------------*/

#define CAESAR_ITERATE_GENERIC_EDGE_LIST(CAESAR_E1_En,CAESAR_E,CAESAR_ASSIGN_S1,CAESAR_ASSIGN_L,CAESAR_ASSIGN_S2,CAESAR_ASSIGN_M) \
	for ( \
		(CAESAR_E) = (CAESAR_E1_En) ;  \
		((CAESAR_E) != NULL) && \
			( \
			CAESAR_ASSIGN_S1, \
			CAESAR_ASSIGN_L, \
			CAESAR_ASSIGN_S2, \
			CAESAR_ASSIGN_M, \
			1 \
			); \
		(CAESAR_E) = *CAESAR_SUCCESSOR_EDGE ((CAESAR_E)) \
	)

/*---------------------------------------------------------------------------*/

#define CAESAR_ITERATE_EDGE_LIST(CAESAR_E1_En,CAESAR_E) \
	CAESAR_ITERATE_GENERIC_EDGE_LIST (CAESAR_E1_En, CAESAR_E, \
		(void) NULL, \
		(void) NULL, \
		(void) NULL, \
		(void) NULL)

#define CAESAR_ITERATE_P_EDGE_LIST(CAESAR_E1_En,CAESAR_E,CAESAR_S1) \
	CAESAR_ITERATE_GENERIC_EDGE_LIST (CAESAR_E1_En,CAESAR_E, \
		CAESAR_SELECT_P_EDGE (CAESAR_E, CAESAR_S1), \
		(void) NULL, \
		(void) NULL, \
		(void) NULL)

#define CAESAR_ITERATE_L_EDGE_LIST(CAESAR_E1_En,CAESAR_E,CAESAR_L) \
	CAESAR_ITERATE_GENERIC_EDGE_LIST (CAESAR_E1_En,CAESAR_E, \
		(void) NULL, \
		CAESAR_SELECT_L_EDGE (CAESAR_E, CAESAR_L), \
		(void) NULL, \
		(void) NULL)

#define CAESAR_ITERATE_N_EDGE_LIST(CAESAR_E1_En,CAESAR_E,CAESAR_S2) \
        CAESAR_ITERATE_GENERIC_EDGE_LIST (CAESAR_E1_En,CAESAR_E, \
		(void) NULL, \
		(void) NULL, \
		CAESAR_SELECT_N_EDGE (CAESAR_E, CAESAR_S2), \
		(void) NULL)

#define CAESAR_ITERATE_M_EDGE_LIST(CAESAR_E1_En,CAESAR_E,CAESAR_M) \
        CAESAR_ITERATE_GENERIC_EDGE_LIST (CAESAR_E1_En,CAESAR_E, \
		(void) NULL, \
		(void) NULL, \
		(void) NULL, \
		CAESAR_SELECT_M_EDGE (CAESAR_E, CAESAR_M))

#define CAESAR_ITERATE_PL_EDGE_LIST(CAESAR_E1_En,CAESAR_E,CAESAR_S1,CAESAR_L) \
	 CAESAR_ITERATE_GENERIC_EDGE_LIST (CAESAR_E1_En,CAESAR_E, \
		CAESAR_SELECT_P_EDGE (CAESAR_E, CAESAR_S1), \
		CAESAR_SELECT_L_EDGE (CAESAR_E, CAESAR_L), \
		(void) NULL, \
		(void) NULL)

#define CAESAR_ITERATE_PN_EDGE_LIST(CAESAR_E1_En,CAESAR_E,CAESAR_S1,CAESAR_S2) \
	CAESAR_ITERATE_GENERIC_EDGE_LIST (CAESAR_E1_En,CAESAR_E, \
		CAESAR_SELECT_P_EDGE (CAESAR_E, CAESAR_S1), \
		(void) NULL, \
		CAESAR_SELECT_N_EDGE (CAESAR_E, CAESAR_S2), \
		(void) NULL)

#define CAESAR_ITERATE_PM_EDGE_LIST(CAESAR_E1_En,CAESAR_E,CAESAR_S1,CAESAR_M) \
	CAESAR_ITERATE_GENERIC_EDGE_LIST (CAESAR_E1_En,CAESAR_E, \
		CAESAR_SELECT_P_EDGE (CAESAR_E, CAESAR_S1), \
		(void) NULL, \
		(void) NULL, \
		CAESAR_SELECT_M_EDGE (CAESAR_E, CAESAR_M))

#define CAESAR_ITERATE_LN_EDGE_LIST(CAESAR_E1_En,CAESAR_E,CAESAR_L,CAESAR_S2) \
	CAESAR_ITERATE_GENERIC_EDGE_LIST (CAESAR_E1_En,CAESAR_E, \
		(void) NULL, \
		CAESAR_SELECT_L_EDGE (CAESAR_E, CAESAR_L), \
		CAESAR_SELECT_N_EDGE (CAESAR_E, CAESAR_S2), \
		(void) NULL)

#define CAESAR_ITERATE_LM_EDGE_LIST(CAESAR_E1_En,CAESAR_E,CAESAR_L,CAESAR_M) \
	CAESAR_ITERATE_GENERIC_EDGE_LIST (CAESAR_E1_En,CAESAR_E, \
		(void) NULL, \
		CAESAR_SELECT_L_EDGE (CAESAR_E, CAESAR_L), \
		(void) NULL, \
		CAESAR_SELECT_M_EDGE (CAESAR_E, CAESAR_M))

#define CAESAR_ITERATE_NM_EDGE_LIST(CAESAR_E1_En,CAESAR_E,CAESAR_S2,CAESAR_M) \
	CAESAR_ITERATE_GENERIC_EDGE_LIST (CAESAR_E1_En,CAESAR_E, \
		(void) NULL, \
		(void) NULL, \
		CAESAR_SELECT_N_EDGE (CAESAR_E, CAESAR_S2), \
		CAESAR_SELECT_M_EDGE (CAESAR_E, CAESAR_M))

#define CAESAR_ITERATE_PLN_EDGE_LIST(CAESAR_E1_En,CAESAR_E,CAESAR_S1,CAESAR_L,CAESAR_S2) \
	CAESAR_ITERATE_GENERIC_EDGE_LIST (CAESAR_E1_En,CAESAR_E, \
		CAESAR_SELECT_P_EDGE (CAESAR_E, CAESAR_S1), \
		CAESAR_SELECT_L_EDGE (CAESAR_E, CAESAR_L), \
		CAESAR_SELECT_N_EDGE (CAESAR_E, CAESAR_S2), \
		(void) NULL)

#define CAESAR_ITERATE_PLM_EDGE_LIST(CAESAR_E1_En,CAESAR_E,CAESAR_S1,CAESAR_L,CAESAR_M) \
	CAESAR_ITERATE_GENERIC_EDGE_LIST (CAESAR_E1_En,CAESAR_E, \
		CAESAR_SELECT_P_EDGE (CAESAR_E, CAESAR_S1), \
		CAESAR_SELECT_L_EDGE (CAESAR_E, CAESAR_L), \
		(void) NULL, \
		CAESAR_SELECT_M_EDGE (CAESAR_E, CAESAR_M))

#define CAESAR_ITERATE_PNM_EDGE_LIST(CAESAR_E1_En,CAESAR_E,CAESAR_S1,CAESAR_S2,CAESAR_M) \
	CAESAR_ITERATE_GENERIC_EDGE_LIST (CAESAR_E1_En,CAESAR_E, \
		CAESAR_SELECT_P_EDGE (CAESAR_E, CAESAR_S1), \
		(void) NULL, \
		CAESAR_SELECT_N_EDGE (CAESAR_E, CAESAR_S2), \
		CAESAR_SELECT_M_EDGE (CAESAR_E, CAESAR_M))

#define CAESAR_ITERATE_LNM_EDGE_LIST(CAESAR_E1_En,CAESAR_E,CAESAR_L,CAESAR_S2,CAESAR_M) \
	CAESAR_ITERATE_GENERIC_EDGE_LIST(CAESAR_E1_En,CAESAR_E, \
		(void) NULL, \
		CAESAR_SELECT_L_EDGE (CAESAR_E, CAESAR_L), \
		CAESAR_SELECT_N_EDGE (CAESAR_E, CAESAR_S2), \
		CAESAR_SELECT_M_EDGE (CAESAR_E, CAESAR_M))

#define CAESAR_ITERATE_PLNM_EDGE_LIST(CAESAR_E1_En,CAESAR_E,CAESAR_S1,CAESAR_L,CAESAR_S2,CAESAR_M) \
	CAESAR_ITERATE_GENERIC_EDGE_LIST (CAESAR_E1_En,CAESAR_E, \
		CAESAR_SELECT_P_EDGE (CAESAR_E, CAESAR_S1), \
		CAESAR_SELECT_L_EDGE (CAESAR_E, CAESAR_L), \
		CAESAR_SELECT_N_EDGE (CAESAR_E, CAESAR_S2), \
		CAESAR_SELECT_M_EDGE (CAESAR_E, CAESAR_M))

/*---------------------------------------------------------------------------*/

extern CAESAR_TYPE_NATURAL CAESAR_LENGTH_EDGE_LIST CAESAR_ARG_1 (CAESAR_TYPE_EDGE);

/*---------------------------------------------------------------------------*/

extern CAESAR_TYPE_EDGE CAESAR_ITEM_EDGE_LIST CAESAR_ARG_2 (CAESAR_TYPE_EDGE, CAESAR_TYPE_NATURAL);

/*---------------------------------------------------------------------------*/

extern void CAESAR_REVERSE_EDGE_LIST CAESAR_ARG_1 (CAESAR_TYPE_EDGE *);

/*****************************************************************************/

#ifdef CAESAR_UNDEFINED
{
#endif

#ifdef __cplusplus
}
#endif

#endif
