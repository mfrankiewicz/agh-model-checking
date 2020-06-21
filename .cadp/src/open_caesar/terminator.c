/******************************************************************************
 *                           O P E N / C A E S A R
 *-----------------------------------------------------------------------------
 *   INRIA - Unite de Recherche Rhone-Alpes
 *   655, avenue de l'Europe
 *   38330 Montbonnot Saint Martin
 *   FRANCE
 *-----------------------------------------------------------------------------
 *   Module             :       terminator.c
 *   Auteur             :       Hubert GARAVEL
 *   Version            :       2.38
 *   Date               :       2019/09/12 10:55:24
 *****************************************************************************/

char caesar_sccs_what_terminator[] =
"@(#)open/caesar -- 2.38 -- 2019/09/12 10:55:24 -- terminator.c";

/* ========================================================================= */

#include "caesar_graph.h"

#include "caesar_edge.h"

#include "caesar_stack_1.h"

#include "caesar_bitmap.h"

#include "caesar_hash.h"

#include "caesar_diagnostic_1.h"

/* ========================================================================= */

#define caesar_max_int ((CAESAR_TYPE_NATURAL) ~0L)
/* 0xffffffff == 4294967295 */

/*---------------------------------------------------------------------------*/

CAESAR_TYPE_STRATEGY_DIAGNOSTIC_1 caesar_option_strategy;

CAESAR_TYPE_NATURAL caesar_option_depth;

CAESAR_TYPE_DIAGNOSTIC_1 caesar_d;

CAESAR_TYPE_NATURAL caesar_nb_bitmaps;

CAESAR_TYPE_NATURAL caesar_size;

CAESAR_TYPE_NATURAL caesar_size_1, caesar_size_2;

CAESAR_TYPE_STACK_1 caesar_k;

CAESAR_TYPE_BITMAP caesar_b;

CAESAR_TYPE_BITMAP caesar_b1, caesar_b2;

/* ========================================================================= */

static CAESAR_TYPE_NATURAL caesar_read_number (caesar_message, caesar_inf, caesar_sup)
CAESAR_TYPE_STRING caesar_message;
CAESAR_TYPE_NATURAL caesar_inf;
CAESAR_TYPE_NATURAL caesar_sup;

{
     CAESAR_TYPE_NATURAL caesar_answer;
     CAESAR_TYPE_GENUINE_INT caesar_result;

     while ( /* CONSTCOND */ CAESAR_TRUE) {
	  fprintf (stdout, "%s (between %lu and %lu) ? ", caesar_message, caesar_inf, caesar_sup);
	  fflush (stdout);
	  caesar_result = fscanf (stdin, "%lu", &caesar_answer);
	  if (caesar_result != 1) {
	       fprintf (stdout, "number expected\n");
	       fscanf (stdin, "%*s");
	  } else if (caesar_answer < caesar_inf || caesar_answer > caesar_sup)
	       fprintf (stdout, "number out of bounds\n");
	  else
	       break;
     }
     fprintf (stdout, "\n");
     return (caesar_answer);
}

/* ========================================================================= */

static void caesar_create_bitmaps ()
{
     CAESAR_TYPE_NATURAL caesar_actual_size;

     CAESAR_TYPE_NATURAL caesar_actual_size_1, caesar_actual_size_2;

     switch (caesar_nb_bitmaps) {
     case 1:
	  CAESAR_CREATE_BITMAP (&caesar_b, caesar_size, CAESAR_TRUE);
	  if (caesar_b == NULL)
	       CAESAR_ERROR ("not enough memory for bitmap");
	  caesar_actual_size = CAESAR_SIZE_BITMAP (caesar_b);
	  if (caesar_actual_size != caesar_size) {
	       fprintf (stdout, "actual size of bitmap: %lu\n\n", caesar_actual_size);
	       caesar_size = caesar_actual_size;
	  }
	  break;

     case 2:
	  CAESAR_CREATE_BITMAP (&caesar_b1, caesar_size_1, CAESAR_TRUE);
	  if (caesar_b1 == NULL)
	       CAESAR_ERROR ("not enough memory for bitmap 1");
	  caesar_actual_size_1 = CAESAR_SIZE_BITMAP (caesar_b1);
	  if (caesar_actual_size_1 != caesar_size_1) {
	       fprintf (stdout, "actual size of bitmap 1: %lu\n\n", caesar_actual_size_1);
	       caesar_size_1 = caesar_actual_size_1;
	  }
	  CAESAR_CREATE_BITMAP (&caesar_b2, caesar_size_2, CAESAR_TRUE);
	  if (caesar_b2 == NULL)
	       CAESAR_ERROR ("not enough memory for bitmap 2");
	  caesar_actual_size_2 = CAESAR_SIZE_BITMAP (caesar_b2);
	  if (caesar_actual_size_2 != caesar_size_2) {
	       fprintf (stdout, "actual size of bitmap 2: %lu\n\n", caesar_actual_size_2);
	       caesar_size_2 = caesar_actual_size_2;
	  }
	  break;
     }
}

/*---------------------------------------------------------------------------*/

static CAESAR_TYPE_BOOLEAN caesar_test_and_set (caesar_s)
CAESAR_TYPE_STATE caesar_s;

{
     CAESAR_TYPE_BOOLEAN caesar_t;
     CAESAR_TYPE_BOOLEAN caesar_t1, caesar_t2;

     switch (caesar_nb_bitmaps) {
     case 1:
	  caesar_t = CAESAR_TEST_AND_SET_BITMAP (caesar_b,
			       CAESAR_STATE_0_HASH (caesar_s, caesar_size));
	  return (caesar_t);
     case 2:
	  caesar_t1 = CAESAR_TEST_AND_SET_BITMAP (caesar_b1,
			     CAESAR_STATE_1_HASH (caesar_s, caesar_size_1));
	  caesar_t2 = CAESAR_TEST_AND_SET_BITMAP (caesar_b2,
			     CAESAR_STATE_2_HASH (caesar_s, caesar_size_2));
	  if (caesar_t1 && caesar_t2)
	       return (CAESAR_TRUE);
	  else
	       return (CAESAR_FALSE);
     }
     /* NOTREACHED */
#ifdef __GNUC__
     return (CAESAR_FALSE);	/* to keep "gcc -Wall" silent */
#endif
}

/*---------------------------------------------------------------------------*/

static void caesar_reset (caesar_s)
CAESAR_TYPE_STATE caesar_s;

{
     switch (caesar_nb_bitmaps) {
     case 1:
	  CAESAR_RESET_BITMAP (caesar_b,
			       CAESAR_STATE_0_HASH (caesar_s, caesar_size));
	  break;
     case 2:
	  CAESAR_RESET_BITMAP (caesar_b1,
			     CAESAR_STATE_1_HASH (caesar_s, caesar_size_1));
	  CAESAR_RESET_BITMAP (caesar_b2,
			     CAESAR_STATE_2_HASH (caesar_s, caesar_size_2));
	  break;
     }
}

/*---------------------------------------------------------------------------*/

static void caesar_print_bitmaps ()
{
     fprintf (stdout, "\001");
     switch (caesar_nb_bitmaps) {
     case 1:
	  CAESAR_PRINT_BITMAP (stdout, caesar_b);
	  break;
     case 2:
	  CAESAR_PRINT_BITMAP (stdout, caesar_b1);
	  fprintf (stdout, "\n");
	  CAESAR_PRINT_BITMAP (stdout, caesar_b2);
	  break;
     }
     fprintf (stdout, "\002");
}

/* ========================================================================= */

static void caesar_check_deadlock ()
{
     if (CAESAR_TOP_EDGE_STACK_1 (caesar_k) == NULL) {
	  /* deadlock detection */
	  CAESAR_RECORD_DIAGNOSTIC_1 (caesar_d, caesar_k);
	  caesar_reset (CAESAR_TOP_STATE_STACK_1 (caesar_k));
     }
}

/* ========================================================================= */

CAESAR_TYPE_GENUINE_INT main (argc, argv)
CAESAR_TYPE_GENUINE_INT argc;
char *argv[];

{
     CAESAR_TYPE_NATURAL caesar_order;
     CAESAR_TYPE_STATE caesar_s;

     CAESAR_TOOL = argv[0];
     --argc;
     ++argv;

     /* parsing command-line options */

     caesar_option_strategy = CAESAR_SHORTEST_DIAGNOSTIC_1;
     caesar_option_depth = 0;

     while ((argc > 0) && ((*argv)[0] == '-')) {
	  if (strcmp (*argv, "-none") == 0)
	       caesar_option_strategy = CAESAR_NONE_DIAGNOSTIC_1;
	  else if (strcmp (*argv, "-all") == 0)
	       caesar_option_strategy = CAESAR_ALL_DIAGNOSTIC_1;
	  else if (strcmp (*argv, "-first") == 0)
	       caesar_option_strategy = CAESAR_FIRST_DIAGNOSTIC_1;
	  else if (strcmp (*argv, "-decr") == 0)
	       caesar_option_strategy = CAESAR_DECREASING_DIAGNOSTIC_1;
	  else if (strcmp (*argv, "-depth") == 0) {
	       if (argc == 1) {
		    fprintf (stdout, "missing argument after \"-depth\"\n");
		    exit (1);
	       }
	       caesar_option_depth = (CAESAR_TYPE_NATURAL) atol (argv[1]);
	       if (caesar_option_depth != 0)
		    ++caesar_option_depth;
	       --argc;
	       ++argv;
	  } else
	       CAESAR_WARNING ("unknown option \"%s\"", *argv);
	  --argc;
	  ++argv;
     }

     switch (argc) {
     case 0:
	  caesar_order = caesar_read_number ("order for transition firing", 0L, CAESAR_MAX_ORDER_EDGE_LIST ());
	  caesar_nb_bitmaps = caesar_read_number ("number of bitmap tables", 1L, 2L);
	  if (caesar_nb_bitmaps == 1)
	       caesar_size = caesar_read_number ("size of bitmap", 0L, caesar_max_int);
	  else {
	       caesar_size_1 = caesar_read_number ("size of bitmap 1", 0L, caesar_max_int);
	       caesar_size_2 = caesar_read_number ("size of bitmap 2", 0L, caesar_max_int);
	  }
	  break;
     case 1:
	  CAESAR_ERROR ("not enough arguments");
	  /* NOTREACHED */
	  caesar_initialize (caesar_order);
	  /* to keep "gcc -Wall -O2" silent */
	  break;
     case 2:
	  caesar_order = (CAESAR_TYPE_NATURAL) atol (argv[0]);
	  caesar_nb_bitmaps = 1;
	  caesar_size = (CAESAR_TYPE_NATURAL) atol (argv[1]);
	  break;
     case 3:
	  caesar_order = (CAESAR_TYPE_NATURAL) atol (argv[0]);
	  caesar_nb_bitmaps = 2;
	  caesar_size_1 = (CAESAR_TYPE_NATURAL) atol (argv[1]);
	  caesar_size_2 = (CAESAR_TYPE_NATURAL) atol (argv[2]);
	  break;
     default:
	  CAESAR_ERROR ("too many arguments");
	  /* NOTREACHED */
	  caesar_initialize (caesar_order);
	  /* to keep "gcc -Wall -O2" silent */
	  break;
     }

     CAESAR_INIT_GRAPH ();
     CAESAR_INIT_STACK_1 ();

     CAESAR_FORMAT_STATE (0);
     if (CAESAR_FORMAT_LABEL (CAESAR_MAXIMAL_FORMAT) == 0)
	  CAESAR_FORMAT_LABEL (0);
     else
	  CAESAR_FORMAT_LABEL (1);

     caesar_create_bitmaps ();

     CAESAR_CREATE_STACK_1 (&caesar_k, caesar_order, (CAESAR_TYPE_OVERFLOW_FUNCTION_STACK_1) NULL);
     if (caesar_k == NULL)
	  CAESAR_ERROR ("not enough memory for stack");

     /* diagnostic initialisation */

     CAESAR_CREATE_DIAGNOSTIC_1 (&caesar_d, caesar_option_strategy, caesar_option_depth, stdout,
				 "*** deadlock(s) found at depth ",
	      "*** deadlock found at depth %u\n\n\001<initial state>\002\n",
				 "<deadlock>\n\n",
				 "[]\n\n",
	"*** no deadlock found (although deadlocks may exist in fact)\n\n");
     if (caesar_d == NULL)
	  CAESAR_ERROR ("not enough memory for diagnostic");

     /* initial state */

     CAESAR_PUSH_STACK_1 (caesar_k, NULL, NULL);
     caesar_s = CAESAR_TOP_STATE_STACK_1 (caesar_k);
     CAESAR_START_STATE (caesar_s);

     caesar_test_and_set (caesar_s);
     CAESAR_CREATE_TOP_EDGE_STACK_1 (caesar_k);
     caesar_check_deadlock ();

     /* main loop */

     while (!CAESAR_EMPTY_STACK_1 (caesar_k)) {
	  if (CAESAR_EXPLORED_STACK_1 (caesar_k))
	       CAESAR_POP_STACK_1 (caesar_k);
	  else {
	       caesar_s = CAESAR_NEXT_STATE_EDGE (CAESAR_TOP_EDGE_STACK_1 (caesar_k));

	       if (caesar_test_and_set (caesar_s))
		    CAESAR_REJECT_STACK_1 (caesar_k);
	       else if (CAESAR_BACKTRACK_DIAGNOSTIC_1 (caesar_d, CAESAR_DEPTH_STACK_1 (caesar_k) + 1))
		    CAESAR_REJECT_STACK_1 (caesar_k);
	       else {
		    CAESAR_SWAP_STACK_1 (caesar_k);
		    CAESAR_CREATE_TOP_EDGE_STACK_1 (caesar_k);
		    caesar_check_deadlock ();
	       }
	  }
     }

     CAESAR_SUMMARIZE_DIAGNOSTIC_1 (caesar_d);

     caesar_print_bitmaps ();

     CAESAR_DELETE_STACK_1 (&caesar_k);

     CAESAR_DELETE_DIAGNOSTIC_1 (&caesar_d);

     return (0);
}

/* ========================================================================= */
