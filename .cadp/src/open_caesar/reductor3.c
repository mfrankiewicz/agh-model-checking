/******************************************************************************
 *                           O P E N / C A E S A R
 *-----------------------------------------------------------------------------
 *   INRIA - Unite de Recherche Rhone-Alpes
 *   655, avenue de l'Europe
 *   38330 Montbonnot Saint Martin
 *   FRANCE
 *-----------------------------------------------------------------------------
 *   Module             :       reductor3.c
 *   Auteur             :       Hubert GARAVEL
 *   Version            :       3.16
 *   Date               :       2019/09/12 10:44:18
 *****************************************************************************/

char caesar_sccs_what_reductor[] =
"@(#)open/caesar -- 3.16 -- 2019/09/12 10:44:18 -- reductor3.c";

char *LDFLAGS = "@(#)LDFLAGS = -L\"${BCG:-$CADP}\"/bin.`\"$CADP\"/com/arch` -lBCG_IO -lBCG -lm";

#include "caesar_graph.h"
#include "caesar_edge.h"
#include "caesar_table_1.h"
#include "caesar_mask_1.h"

#include "bcg_user.h"

/*---------------------------------------------------------------------------*/

static void caesar_abort (caesar_signal)
CAESAR_TYPE_GENUINE_INT caesar_signal;

{
     CAESAR_SET_SIGNALS (SIG_IGN);
     BCG_IO_WRITE_BCG_END ();
     CAESAR_ERROR ("caught signal %d; closing BCG file", caesar_signal);
}

/*---------------------------------------------------------------------------*/

CAESAR_TYPE_TABLE_1 caesar_t1, caesar_t2;

/*---------------------------------------------------------------------------*/

CAESAR_TYPE_GENUINE_INT main (argc, argv)
CAESAR_TYPE_GENUINE_INT argc;
char *argv[];

{
     char *caesar_filename;
     CAESAR_TYPE_GENUINE_INT caesar_nb_tokens;
     CAESAR_TYPE_MASK_1 caesar_m;
     CAESAR_TYPE_BOOLEAN caesar_monitor;
     CAESAR_TYPE_STRING caesar_comment;
     CAESAR_TYPE_STATE caesar_s0, caesar_s1, caesar_s2;
     CAESAR_TYPE_EDGE caesar_e1_en, caesar_e;
     CAESAR_TYPE_LABEL caesar_l;
     CAESAR_TYPE_STRING caesar_label;
     CAESAR_TYPE_INDEX_TABLE_1 caesar_n1, caesar_n2, caesar_dummy_n;
     CAESAR_TYPE_POINTER caesar_dummy_s;
     CAESAR_TYPE_INDEX_TABLE_1 caesar_initial_state;

     /* initializing BCG and OPEN/CAESAR */

     BCG_INIT ();
     BCG_INIT_OPTIONS ();
     CAESAR_INIT_GRAPH ();

     /* parsing command-line options */

     CAESAR_TOOL = argv[0];
     --argc;
     ++argv;
     caesar_monitor = CAESAR_FALSE;
     CAESAR_CREATE_MASK_1 (&caesar_m, CAESAR_LABEL_AREA_1 (), CAESAR_TRUE, 0, CAESAR_TRUE, (CAESAR_TYPE_COMPARE_FUNCTION) NULL, (CAESAR_TYPE_HASH_FUNCTION) NULL, (CAESAR_TYPE_CONVERT_FUNCTION) NULL, CAESAR_TRUE);
     while (argc > 0) {
	  /* parsing general BCG options (see "man bcg") */
	  caesar_nb_tokens = BCG_PARSE_OPTION (argc, argv, BCG_WRITE_OPTIONS);
	  if (caesar_nb_tokens != 0) {
	       /* a general BCG option was recognized */
	       argc -= caesar_nb_tokens;
	       argv += caesar_nb_tokens;
	       continue;
	  }
	  /* parsing hiding and renaming options (see "man caesar_mask_1") */
	  CAESAR_PARSE_OPTION_MASK_1 (caesar_m, argc, argv, &caesar_nb_tokens);
	  if (caesar_nb_tokens < 0)
	       CAESAR_ERROR ("invalid hiding or renaming option");
	  else if (caesar_nb_tokens > 0) {
	       /* one or more hiding or renaming options were recognized */
	       argc -= caesar_nb_tokens;
	       argv += caesar_nb_tokens;
	       continue;
	  }
	  if (strcmp (*argv, "-monitor") == 0) {
	       caesar_monitor = CAESAR_TRUE;
	       --argc;
	       ++argv;
	       continue;
	  } else if (*argv[0] == '-') {
	       CAESAR_ERROR ("unknown option ``%s''", *argv);
	  } else {
	       /* found a string corresponding to a file name */
	       break;
	  }
     }
     if (argc != 1)
	  CAESAR_ERROR ("one BCG filename expected as argument");
     caesar_filename = argv[0];

     /* allocating edges and state tables */

     CAESAR_INIT_EDGE (CAESAR_FALSE, CAESAR_TRUE, CAESAR_TRUE, 0, 0);
     CAESAR_CREATE_TABLE_1 (&caesar_t1, CAESAR_STATE_AREA_1 (), CAESAR_EMPTY_AREA_1 (), 0, 0, CAESAR_TRUE, (CAESAR_TYPE_COMPARE_FUNCTION) NULL, (CAESAR_TYPE_HASH_FUNCTION) NULL, (CAESAR_TYPE_PRINT_FUNCTION) NULL, (CAESAR_TYPE_OVERFLOW_FUNCTION_TABLE_1) NULL);
     if (caesar_t1 == NULL)
	  CAESAR_ERROR ("not enough memory for table 1");
     CAESAR_CREATE_TABLE_1 (&caesar_t2, CAESAR_STATE_AREA_1 (), CAESAR_EMPTY_AREA_1 (), 0, 0, CAESAR_TRUE, (CAESAR_TYPE_COMPARE_FUNCTION) NULL, (CAESAR_TYPE_HASH_FUNCTION) NULL, (CAESAR_TYPE_PRINT_FUNCTION) NULL, (CAESAR_TYPE_OVERFLOW_FUNCTION_TABLE_1) NULL);
     if (caesar_t2 == NULL)
	  CAESAR_ERROR ("not enough memory for table 2");

     /* computing and storing the initial state */

     CAESAR_START_STATE ((CAESAR_TYPE_STATE) CAESAR_PUT_BASE_TABLE_1 (caesar_t1));
     CAESAR_PUT_TABLE_1 (caesar_t1);
     caesar_initial_state = CAESAR_GET_INDEX_TABLE_1 (caesar_t1);

     /* opening the BCG graph for writing */

     caesar_comment = CAESAR_HISTORY_MASK_1 (caesar_m, "created by reductor", NULL, NULL, NULL, NULL);
     BCG_IO_WRITE_BCG_BEGIN (caesar_filename, caesar_initial_state, 2, caesar_comment, caesar_monitor);
     CAESAR_DELETE (caesar_comment);

     CAESAR_SET_SIGNALS (caesar_abort);

     /* main program loop */

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
			 caesar_label = CAESAR_APPLY_MASK_1 (caesar_m, (CAESAR_TYPE_POINTER) caesar_l);
			 BCG_IO_WRITE_BCG_EDGE (caesar_n1, caesar_label, caesar_n2);
		    } else {
			 CAESAR_COPY_STATE ((CAESAR_TYPE_STATE) CAESAR_PUT_BASE_TABLE_1 (caesar_t2), caesar_s2);
			 (void) CAESAR_SEARCH_AND_PUT_TABLE_1 (caesar_t2, &caesar_dummy_n, &caesar_dummy_s);
		    }
	       }
	       CAESAR_DELETE_EDGE_LIST (&caesar_e1_en);
	  }
     }

     /* closing the BCG file and terminating */

     CAESAR_DELETE_TABLE_1 (&caesar_t1);
     CAESAR_DELETE_TABLE_1 (&caesar_t2);
     CAESAR_DELETE_MASK_1 (&caesar_m);
     BCG_IO_WRITE_BCG_END ();

     return (0);
}

/*---------------------------------------------------------------------------*/
