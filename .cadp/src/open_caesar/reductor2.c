/******************************************************************************
 *                           O P E N / C A E S A R
 *-----------------------------------------------------------------------------
 *   INRIA - Unite de Recherche Rhone-Alpes
 *   655, avenue de l'Europe
 *   38330 Montbonnot Saint Martin
 *   FRANCE
 *-----------------------------------------------------------------------------
 *   Module             :       reductor2.c
 *   Auteur             :       Hubert GARAVEL
 *   Version            :       2.20 (revision I of 2019/09/11 10:48:11)
 *   Date               :       2003/12/16 11:57:44
 *****************************************************************************/

char caesar_sccs_what_reductor2[] =
"@(#)open/caesar -- 2.20.I -- 2019/09/11 10:48:11 -- reductor2.c";

char *LDFLAGS = "@(#)LDFLAGS = -L\"${BCG:-$CADP}\"/bin.`\"$CADP\"/com/arch` -lBCG_IO -lBCG -lm";

#include "caesar_graph.h"
#include "caesar_edge.h"
#include "caesar_table_1.h"

#include "bcg_user.h"

/*---------------------------------------------------------------------------*/

static void caesar_abort (caesar_signal)
int  caesar_signal;

{
     caesar_use (caesar_signal);
     CAESAR_SET_SIGNALS (SIG_IGN);
     BCG_IO_WRITE_BCG_END ();
     CAESAR_ERROR ("caught interrupt: closing BCG file");
}

/*---------------------------------------------------------------------------*/

CAESAR_TYPE_TABLE_1 caesar_t1, caesar_t2;

/*---------------------------------------------------------------------------*/

int main (argc, argv)
int  argc;
char *argv[];

{
     char *caesar_filename;
     CAESAR_TYPE_BOOLEAN caesar_monitor;
     CAESAR_TYPE_STATE caesar_s0, caesar_s1, caesar_s2;
     CAESAR_TYPE_EDGE caesar_e1_en, caesar_e;
     CAESAR_TYPE_LABEL caesar_l;
     CAESAR_TYPE_STRING caesar_label;
     CAESAR_TYPE_INDEX_TABLE_1 caesar_n1, caesar_n2, caesar_dummy_n;
     CAESAR_TYPE_POINTER caesar_dummy_s;
     CAESAR_TYPE_INDEX_TABLE_1 caesar_initial_state;

     CAESAR_TOOL = argv[0];
     --argc;
     ++argv;

     if ((argc >= 1) && (strcmp (argv[0], "-monitor") == 0)) {
	  caesar_monitor = CAESAR_TRUE;
	  --argc;
	  ++argv;
     } else {
	  caesar_monitor = CAESAR_FALSE;
     }

     if (argc != 1)
	  CAESAR_ERROR ("one BCG filename expected as argument");

     caesar_filename = argv[0];

     CAESAR_INIT_GRAPH ();

     CAESAR_INIT_EDGE (CAESAR_FALSE, CAESAR_TRUE, CAESAR_TRUE, 0, 0);

     CAESAR_CREATE_TABLE_1 (&caesar_t1, CAESAR_STATE_AREA_1 (), CAESAR_EMPTY_AREA_1 (), 0, 0, CAESAR_TRUE, (CAESAR_TYPE_COMPARE_FUNCTION) NULL, (CAESAR_TYPE_HASH_FUNCTION) NULL, (CAESAR_TYPE_PRINT_FUNCTION) NULL, (CAESAR_TYPE_OVERFLOW_FUNCTION_TABLE_1) NULL);
     if (caesar_t1 == NULL)
	  CAESAR_ERROR ("not enough memory for table 1");

     CAESAR_CREATE_TABLE_1 (&caesar_t2, CAESAR_STATE_AREA_1 (), CAESAR_EMPTY_AREA_1 (), 0, 0, CAESAR_TRUE, (CAESAR_TYPE_COMPARE_FUNCTION) NULL, (CAESAR_TYPE_HASH_FUNCTION) NULL, (CAESAR_TYPE_PRINT_FUNCTION) NULL, (CAESAR_TYPE_OVERFLOW_FUNCTION_TABLE_1) NULL);
     if (caesar_t2 == NULL)
	  CAESAR_ERROR ("not enough memory for table 2");

     CAESAR_START_STATE ((CAESAR_TYPE_STATE) CAESAR_PUT_BASE_TABLE_1 (caesar_t1));
     CAESAR_PUT_TABLE_1 (caesar_t1);
     caesar_initial_state = CAESAR_GET_INDEX_TABLE_1 (caesar_t1);

     BCG_INIT ();

     BCG_IO_WRITE_BCG_BEGIN (caesar_filename, caesar_initial_state, 2, "created by reductor", caesar_monitor);

     CAESAR_SET_SIGNALS (caesar_abort);

     while (!CAESAR_EXPLORED_TABLE_1 (caesar_t1)) {
	  caesar_s0 = (CAESAR_TYPE_STATE) CAESAR_GET_BASE_TABLE_1 (caesar_t1);
	  caesar_n1 = CAESAR_GET_INDEX_TABLE_1 (caesar_t1);
	  CAESAR_GET_TABLE_1 (caesar_t1);

	  CAESAR_PURGE_TABLE_1 (caesar_t2);
	  CAESAR_COPY_STATE ((CAESAR_TYPE_STATE) CAESAR_PUT_BASE_TABLE_1 (caesar_t2), caesar_s0);
	  CAESAR_PUT_TABLE_1 (caesar_t2);

	  while (!CAESAR_EXPLORED_TABLE_1 (caesar_t2)) {
	       caesar_s1 = (CAESAR_TYPE_STATE) CAESAR_GET_BASE_TABLE_1 (caesar_t2);
	       CAESAR_GET_TABLE_1 (caesar_t2);

	       CAESAR_CREATE_EDGE_LIST (caesar_s1, &caesar_e1_en, 1);
	       if (CAESAR_TRUNCATION_EDGE_LIST () != 0) {
		    BCG_IO_WRITE_BCG_END ();
		    CAESAR_ERROR ("not enough memory for edge lists");
	       }

	       CAESAR_ITERATE_LN_EDGE_LIST (caesar_e1_en, caesar_e, caesar_l, caesar_s2) {
		    if (CAESAR_VISIBLE_LABEL (caesar_l)) {
			 CAESAR_COPY_STATE ((CAESAR_TYPE_STATE) CAESAR_PUT_BASE_TABLE_1 (caesar_t1), caesar_s2);
			 (void) CAESAR_SEARCH_AND_PUT_TABLE_1 (caesar_t1, &caesar_n2, &caesar_dummy_s);
			 caesar_label = CAESAR_STRING_LABEL (caesar_l);
			 BCG_IO_WRITE_BCG_EDGE (caesar_n1, caesar_label, caesar_n2);
		    } else {
			 CAESAR_COPY_STATE ((CAESAR_TYPE_STATE) CAESAR_PUT_BASE_TABLE_1 (caesar_t2), caesar_s2);
			 (void) CAESAR_SEARCH_AND_PUT_TABLE_1 (caesar_t2, &caesar_dummy_n, &caesar_dummy_s);
		    }
	       }
	       CAESAR_DELETE_EDGE_LIST (&caesar_e1_en);
	  }
     }
     BCG_IO_WRITE_BCG_END ();
     return (0);
}
