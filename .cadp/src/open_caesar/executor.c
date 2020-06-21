/******************************************************************************
 *                           O P E N / C A E S A R
 *-----------------------------------------------------------------------------
 *   INRIA - Unite de Recherche Rhone-Alpes
 *   655, avenue de l'Europe
 *   38330 Montbonnot Saint Martin
 *   FRANCE
 *-----------------------------------------------------------------------------
 *   Module             :       executor.c
 *   Auteur             :       Hubert GARAVEL
 *   Version            :       1.53
 *   Date               :       2019/09/12 10:44:19
 *****************************************************************************/

char caesar_sccs_what_executor[] =
"@(#)open/caesar -- 1.53 -- 2019/09/12 10:44:19 -- executor.c";

#include "caesar_graph.h"
#include "caesar_edge.h"
#include "caesar_mask_1.h"

#include <sys/types.h>
#include <time.h>
#include <unistd.h>		/* pour sleep() */

/* ========================================================================= */

#define caesar_max_int ((CAESAR_TYPE_NATURAL) ~0L)
/* 0xffffffff == 4294967295 */

#define caesar_max_rand_system_v 32767	/* 32768 = 2^15 - 1 */

#define caesar_max_rand_berkeley 2147483647	/* 2147483647 = 2^31 - 1 */

/* ========================================================================= */

#define caesar_strategy_determinism		1L
#define caesar_strategy_non_determinism_random	2L
#define caesar_strategy_non_determinism_seed	3L

/* ========================================================================= */

static CAESAR_TYPE_NATURAL caesar_read_number (caesar_message, caesar_inf, caesar_sup)
CAESAR_TYPE_STRING caesar_message;
CAESAR_TYPE_NATURAL caesar_inf;
CAESAR_TYPE_NATURAL caesar_sup;

{
     CAESAR_TYPE_NATURAL caesar_answer;
     int  caesar_result;

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

CAESAR_TYPE_NATURAL caesar_nb_states;
CAESAR_TYPE_NATURAL caesar_nb_transitions;

/* ========================================================================= */

static void caesar_finish (caesar_signal)
int  caesar_signal;

{
     caesar_use (caesar_signal);
     CAESAR_SET_SIGNALS (SIG_IGN);
     fprintf (stdout, "\n*** %lu states visited, %lu visible transitions executed\n", caesar_nb_states, caesar_nb_transitions);
     exit (0);
}

/* ========================================================================= */

static void caesar_display_invisible_transitions (caesar_nb_invisible_transitions)
CAESAR_TYPE_NATURAL caesar_nb_invisible_transitions;

{
     if (caesar_nb_invisible_transitions == 0)
	  (void) 0 /* rien */ ;
     else if (caesar_nb_invisible_transitions == 1)
	  fprintf (stdout, "\"i\"\001 (one invisible transition)\002\n");
     else
	  fprintf (stdout, "\"i\"*\001 (%lu invisible transitions)\002\n", caesar_nb_invisible_transitions);
}

/* ========================================================================= */

int  main (argc, argv)
int  argc;
char *argv[];

{
     CAESAR_TYPE_GENUINE_INT caesar_nb_tokens;
     CAESAR_TYPE_MASK_1 caesar_m;
     CAESAR_TYPE_LABEL caesar_l;
     CAESAR_TYPE_STATE caesar_s;
     CAESAR_TYPE_NATURAL caesar_nb_invisible_transitions;
     CAESAR_TYPE_NATURAL caesar_nb_successors;
     CAESAR_TYPE_NATURAL caesar_nb_truncations;
     CAESAR_TYPE_NATURAL caesar_i;
     CAESAR_TYPE_EDGE caesar_e1_en, caesar_ei;
     CAESAR_TYPE_NATURAL caesar_max_nb_transitions;
     CAESAR_TYPE_NATURAL caesar_strategy;
     unsigned int caesar_seed;
     int  caesar_random_int;
     double caesar_random_double;

     CAESAR_TOOL = argv[0];
     --argc;
     ++argv;

     fprintf (stdout, "\n");

     CAESAR_CREATE_MASK_1 (&caesar_m, CAESAR_LABEL_AREA_1 (), CAESAR_TRUE, 0, CAESAR_TRUE, (CAESAR_TYPE_COMPARE_FUNCTION) NULL, (CAESAR_TYPE_HASH_FUNCTION) NULL, (CAESAR_TYPE_CONVERT_FUNCTION) NULL, CAESAR_TRUE);
     while (argc > 0) {
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
	  if (*argv[0] == '-') {
	       CAESAR_ERROR ("unknown option ``%s''", *argv);
	  } else {
	       /* found a string corresponding to a file name */
	       break;
	  }
     }

     if (argc == 0) {
	  caesar_max_nb_transitions = caesar_read_number ("maximal number of visible transitions", 0L, caesar_max_int);

	  fprintf (stdout, "available execution strategies:\n");
	  fprintf (stdout, "\001   (1) deterministic\002\n");
	  fprintf (stdout, "\001   (2) non-deterministic with random seed\002\n");
	  fprintf (stdout, "\001   (3) non-deterministic with chosen seed\002\n");
	  caesar_strategy = caesar_read_number ("chosen strategy", caesar_strategy_determinism, caesar_strategy_non_determinism_seed);

	  switch (caesar_strategy) {
	  case caesar_strategy_determinism:
	  case caesar_strategy_non_determinism_random:
	       break;

	  case caesar_strategy_non_determinism_seed:
	       fprintf (stdout, "chosen seed ? ");
	       fflush (stdout);
	       fscanf (stdin, "%u", &caesar_seed);
	       fprintf (stdout, "\n");
	       break;
	  }

     } else if (argc < 2) {
	  CAESAR_ERROR ("not enough arguments");
	  /* NOTREACHED */
	  caesar_initialize (caesar_max_nb_transitions);
	  caesar_initialize (caesar_strategy);
	  /* to keep "gcc -Wall -O2" silent */
     } else {
	  caesar_max_nb_transitions = (CAESAR_TYPE_NATURAL) atol (argv[0]);
	  caesar_strategy = (CAESAR_TYPE_NATURAL) atol (argv[1]);
	  switch (caesar_strategy) {
	  case caesar_strategy_determinism:
	  case caesar_strategy_non_determinism_random:
	       if (argc > 2)
		    CAESAR_ERROR ("too many arguments");
	       break;

	  case caesar_strategy_non_determinism_seed:
	       if (argc < 3)
		    CAESAR_ERROR ("not enough arguments");
	       else if (argc > 3)
		    CAESAR_ERROR ("too many arguments");
	       else
		    caesar_seed = (unsigned int) atoi (argv[2]);
	       break;
	  default:
	       CAESAR_ERROR ("invalid strategy (second argument)");
	       break;
	  }
     }

     switch (caesar_strategy) {
     case caesar_strategy_determinism:
	  break;

     case caesar_strategy_non_determinism_random:
	  sleep (1);
	  caesar_seed = (unsigned int) time ((time_t *) 0);
	  /*
	   * The seed is the number of seconds elapsed since January 1, 1970.
	   * The above call to sleep() ensures that two successive executions
	   * of "executor", even if they are close, do not share the same
	   * seed
	   */
	  fprintf (stdout, "random seed = %u\n\n", caesar_seed);
	  srand (caesar_seed);
	  break;

     case caesar_strategy_non_determinism_seed:
	  srand (caesar_seed);
	  break;
     }

     CAESAR_INIT_GRAPH ();

     CAESAR_CREATE_STATE (&caesar_s);

     CAESAR_INIT_EDGE (CAESAR_FALSE, CAESAR_TRUE, CAESAR_TRUE, 0, 0);

     CAESAR_START_STATE (caesar_s);

     caesar_nb_states = 1;
     caesar_nb_transitions = 0;
     caesar_nb_invisible_transitions = 0;

     CAESAR_SET_SIGNALS (caesar_finish);

     fprintf (stdout, "\001<initial state>\002\n");

     while ( /* CONSTCOND */ CAESAR_TRUE) {
	  if ((caesar_max_nb_transitions != 0) && (caesar_nb_transitions == caesar_max_nb_transitions))
	       caesar_finish (0);

	  CAESAR_CREATE_EDGE_LIST (caesar_s, &caesar_e1_en, 0);
	  caesar_nb_successors = CAESAR_CREATION_EDGE_LIST ();
	  caesar_nb_truncations = CAESAR_TRUNCATION_EDGE_LIST ();

	  if (caesar_nb_truncations != 0) {
	       fprintf (stdout, "\n*** truncation occurred: %lu successors missing\n", caesar_nb_truncations);
	       caesar_finish (0);
	  }
	  if (caesar_nb_successors == 0) {
	       caesar_display_invisible_transitions (caesar_nb_invisible_transitions);
	       fprintf (stdout, "<deadlock>\n");
	       caesar_finish (0);
	  }
	  switch (caesar_strategy) {
	  case caesar_strategy_determinism:
	       if (caesar_nb_successors != 1) {
		    caesar_display_invisible_transitions (caesar_nb_invisible_transitions);
		    fprintf (stdout, "\n*** non-determinism found: %lu successors to the current state\n", caesar_nb_successors);
		    caesar_finish (0);
	       }
	       caesar_i = 1;
	       break;

	  case caesar_strategy_non_determinism_random:
	  case caesar_strategy_non_determinism_seed:
	       caesar_random_int = rand ();
	       if (caesar_random_int <= caesar_max_rand_system_v) {
		    /*
		     * rand() est probablement la fonction d'UNIX System V
		     * dont les valeurs sont comprises entre 0 et (2^15)-1
		     */
		    caesar_random_double = (double) caesar_random_int / ((double) (caesar_max_rand_system_v) + 1);
	       } else {
		    /*
		     * rand() est certainement la fonction d'UNIX Berkeley
		     * dont les valeurs sont comprises entre 0 et (2^31)-1
		     */
		    caesar_random_double = (double) caesar_random_int / ((double) (caesar_max_rand_berkeley) + 1);
	       }
	       /* assert (caesar_random_double < 1) */
	       caesar_i = (CAESAR_TYPE_NATURAL) (caesar_nb_successors * caesar_random_double) + 1;
	       break;
	  default:
	       CAESAR_ERROR ("unexpected case");
	       /* NOTREACHED */
	       caesar_initialize (caesar_i);
	       /* to keep "gcc -Wall -O2" silent */
	  }

	  caesar_ei = CAESAR_ITEM_EDGE_LIST (caesar_e1_en, caesar_i);
	  caesar_l = CAESAR_LABEL_EDGE (caesar_ei);

	  if (!CAESAR_VISIBLE_LABEL (caesar_l))
	       ++caesar_nb_invisible_transitions;
	  else {
	       caesar_display_invisible_transitions (caesar_nb_invisible_transitions);
	       caesar_nb_invisible_transitions = 0;
	       fprintf (stdout, "\"%s\"\n", CAESAR_APPLY_MASK_1 (caesar_m, (CAESAR_TYPE_POINTER) caesar_l));
	       ++caesar_nb_transitions;
	  }

	  CAESAR_COPY_STATE (caesar_s, CAESAR_NEXT_STATE_EDGE (caesar_ei));
	  ++caesar_nb_states;
	  CAESAR_DELETE_EDGE_LIST (&caesar_e1_en);
     }
     /* LINTED (to avoid warnings about missing return) */
}
