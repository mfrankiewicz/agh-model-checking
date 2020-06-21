/******************************************************************************
 *                           O P E N / C A E S A R
 *-----------------------------------------------------------------------------
 *   INRIA - Unite de Recherche Rhone-Alpes
 *   655, avenue de l'Europe
 *   38330 Montbonnot Saint Martin
 *   FRANCE
 *-----------------------------------------------------------------------------
 *   Module             :       declarator.c
 *   Auteurs            :       Renaud RUFFIOT, Hubert GARAVEL et Bruno ONDET
 *   Version            :       1.35
 *   Date               :       2017/09/05 17:31:49
 *****************************************************************************/

char caesar_sccs_what_declarator[] =
"@(#)open/caesar -- 1.35 -- 2017/09/05 17:31:49 -- declarator.c";

#include "caesar_graph.h"

#define caesar_max_transitions      2000
#define caesar_modulus 		      50

CAESAR_TYPE_NATURAL caesar_nb_states;
CAESAR_TYPE_NATURAL caesar_current_state_number;
CAESAR_TYPE_NATURAL caesar_nb_transitions;
CAESAR_TYPE_NATURAL caesar_hash;

CAESAR_TYPE_FORMAT caesar_max_format_state;
CAESAR_TYPE_FORMAT caesar_max_format_label;

CAESAR_TYPE_STATE caesar_start_state;
CAESAR_TYPE_STATE caesar_tab_state[caesar_max_transitions];

/*---------------------------------------------------------------------------*/

static void caesar_abort (caesar_signal)
CAESAR_TYPE_GENUINE_INT caesar_signal;

{
     CAESAR_SET_SIGNALS (SIG_IGN);
     CAESAR_ERROR ("caught signal %d; exiting", caesar_signal);
}

/*---------------------------------------------------------------------------*/

static void caesar_print_state (caesar_state)
CAESAR_TYPE_STATE caesar_state;

{
     CAESAR_TYPE_STATE caesar_state_copy;
     CAESAR_TYPE_FORMAT caesar_state_format;

     CAESAR_CREATE_STATE (&caesar_state_copy);

     CAESAR_COPY_STATE (caesar_state_copy, caesar_state);

     if (CAESAR_COMPARE_STATE (caesar_state_copy, caesar_state)) {
	  fprintf (stdout, "CAESAR_COPY_STATE : OK\n");
	  fprintf (stdout, "CAESAR_COMPARE_STATE : OK\n");
     } else
	  CAESAR_ERROR ("incorrect implementation of function CAESAR_COMPARE_STATE()");

     caesar_hash = CAESAR_HASH_STATE (caesar_state, caesar_modulus);
     if (caesar_hash < caesar_modulus)
	  fprintf (stdout, "CAESAR_HASH_STATE = %lu\n", caesar_hash);
     else
	  CAESAR_ERROR ("incorrect implementation of function CAESAR_HASH_STATE()\nthe expected result should be in the range 0..CAESAR_MODULUS-1");

     for (caesar_state_format = 0; caesar_state_format <= caesar_max_format_state; ++caesar_state_format) {
	  fprintf (stdout, "CAESAR_PRINT_STATE [format %u]: ", caesar_state_format);
	  CAESAR_FORMAT_STATE (caesar_state_format);
	  CAESAR_PRINT_STATE (stdout, caesar_state);
	  fprintf (stdout, "\n");

	  fprintf (stdout, "CAESAR_DELTA_STATE [format %u]: ", caesar_state_format);
	  CAESAR_FORMAT_STATE (caesar_state_format);
	  CAESAR_DELTA_STATE (stdout, caesar_start_state, caesar_state);
	  fprintf (stdout, "\n");
     }
     CAESAR_DELETE_STATE (&caesar_state_copy);
     fprintf (stdout, "\n");
}

/*---------------------------------------------------------------------------*/

static void caesar_print_label (caesar_label)
CAESAR_TYPE_LABEL caesar_label;

{
     CAESAR_TYPE_LABEL caesar_label_copy;
     CAESAR_TYPE_FORMAT caesar_label_format;
     CAESAR_CREATE_LABEL (&caesar_label_copy);

     CAESAR_COPY_LABEL (caesar_label_copy, caesar_label);

     if (CAESAR_COMPARE_LABEL (caesar_label_copy, caesar_label)) {
	  fprintf (stdout, "\tCAESAR_COPY_LABEL : OK\n");
	  fprintf (stdout, "\tCAESAR_COMPARE_LABEL : OK\n");
     } else
	  CAESAR_ERROR ("incorrect implementation of function CAESAR_COMPARE_LABEL()");

     fprintf (stdout, "\tCAESAR_VISIBLE_LABEL = %s\n",
	      CAESAR_VISIBLE_LABEL (caesar_label) ? "true" : "false");

     fprintf (stdout, "\tCAESAR_GATE_LABEL = \"%s\"\n",
	      CAESAR_GATE_LABEL (caesar_label));

     fprintf (stdout, "\tCAESAR_CARDINAL_LABEL = %lu\n",
	      CAESAR_CARDINAL_LABEL (caesar_label));

     caesar_hash = CAESAR_HASH_LABEL (caesar_label, caesar_modulus);
     if (caesar_hash < caesar_modulus)
	  fprintf (stdout, "\tCAESAR_HASH_LABEL = %lu\n", caesar_hash);
     else
	  CAESAR_ERROR ("incorrect implementation of function CAESAR_HASH_LABEL()\nthe expected result should be in the range 0..CAESAR_MODULUS-1");

     fprintf (stdout, "\tCAESAR_PRINT_LABEL = \"");
     CAESAR_PRINT_LABEL (stdout, caesar_label);
     fprintf (stdout, "\"\n");

     fprintf (stdout, "\tCAESAR_STRING_LABEL = \"%s\"\n", CAESAR_STRING_LABEL (caesar_label));

     if (strchr (CAESAR_STRING_LABEL (caesar_label), '\n') != NULL)
	  CAESAR_ERROR ("incorrect implementation of function CAESAR_STRING_LABEL()\nlabel strings should not contain \\n characters");

     if (strchr (CAESAR_STRING_LABEL (caesar_label), '\r') != NULL)
	  CAESAR_ERROR ("incorrect implementation of function CAESAR_STRING_LABEL()\nlabel strings should not contain \\r characters");

     for (caesar_label_format = 0; caesar_label_format <= caesar_max_format_label; ++caesar_label_format) {
	  CAESAR_FORMAT_LABEL (caesar_label_format);

	  fprintf (stdout, "\tCAESAR_INFORMATION_LABEL [format %u] = \"%s\"\n", caesar_label_format, CAESAR_INFORMATION_LABEL (caesar_label));
     }

     CAESAR_DELETE_LABEL (&caesar_label_copy);
     fprintf (stdout, "\n");
}

/*---------------------------------------------------------------------------*/

static void caesar_add_transition (caesar_state_1, caesar_label, caesar_state_2)
CAESAR_TYPE_STATE caesar_state_1;
CAESAR_TYPE_STATE caesar_state_2;
CAESAR_TYPE_LABEL caesar_label;

{
     caesar_use (caesar_state_1);
     fprintf (stdout, "\t*** transition %lu of state %lu\n\n", caesar_nb_transitions + 1, caesar_current_state_number);
     caesar_print_label (caesar_label);
     if (caesar_nb_transitions < caesar_max_transitions)
	  CAESAR_COPY_STATE (caesar_tab_state[caesar_nb_transitions], caesar_state_2);
     caesar_nb_transitions++;
}

/*---------------------------------------------------------------------------*/

static void caesar_explore ()
{
     CAESAR_TYPE_NATURAL caesar_i;
     CAESAR_TYPE_STATE caesar_initial_state;
     CAESAR_TYPE_STATE caesar_state_1, caesar_state_2;
     CAESAR_TYPE_LABEL caesar_label;

     CAESAR_CREATE_STATE (&caesar_initial_state);
     CAESAR_CREATE_STATE (&caesar_state_2);
     CAESAR_CREATE_LABEL (&caesar_label);

     CAESAR_START_STATE (caesar_initial_state);

     caesar_state_1 = caesar_initial_state;
     for (caesar_i = 0; caesar_i < caesar_nb_states; caesar_i++) {

	  caesar_current_state_number = caesar_i + 1;
	  fprintf (stdout, "*** state #%lu\n\n", caesar_current_state_number);
	  caesar_print_state (caesar_state_1);
	  caesar_nb_transitions = 0;

	  CAESAR_ITERATE_STATE (caesar_state_1, caesar_label, caesar_state_2,
				caesar_add_transition);

	  if (caesar_nb_transitions == 0) {
	       fprintf (stdout, "sink state\n");
	       break;
	  } else if (caesar_nb_transitions >= caesar_max_transitions)
	       caesar_nb_transitions = caesar_max_transitions;

	  caesar_state_1 = caesar_tab_state[((unsigned int) rand ()) % caesar_nb_transitions];
     }
     CAESAR_DELETE_STATE (&caesar_initial_state);
     CAESAR_DELETE_STATE (&caesar_state_2);
     CAESAR_DELETE_LABEL (&caesar_label);
}

/*---------------------------------------------------------------------------*/

static void caesar_check_compatibility (caesar_tool, caesar_compiler, caesar_version)
CAESAR_TYPE_STRING caesar_tool;
CAESAR_TYPE_STRING caesar_compiler;
CAESAR_TYPE_VERSION caesar_version;
{
     char caesar_command[4096];

     sprintf (caesar_command, "/bin/sh -c \"$CADP/src/com/cadp_decl '%s' %s %s %.1f\"", caesar_tool, "CAESAR_RANK_LABEL", caesar_compiler, caesar_version);
     system (caesar_command);

     sprintf (caesar_command, "/bin/sh -c \"$CADP/src/com/cadp_decl '%s' %s %s %.1f\"", caesar_tool, "CAESAR_DUMP_LABEL", caesar_compiler, caesar_version);
     system (caesar_command);

     printf ("\n");
}

/*---------------------------------------------------------------------------*/

CAESAR_TYPE_GENUINE_INT main (argc, argv)
CAESAR_TYPE_GENUINE_INT argc;
char *argv[];

{
     CAESAR_TYPE_NATURAL caesar_i;
     CAESAR_TYPE_FORMAT caesar_state_format;

     CAESAR_TOOL = argv[0];

     if (argc == 1)
	  caesar_nb_states = 10;
     else if (argc == 2)
	  caesar_nb_states = (CAESAR_TYPE_NATURAL) atol (argv[1]);
     else
	  CAESAR_ERROR ("at most one argument expected");

     CAESAR_SET_SIGNALS (caesar_abort);

     printf ("\n*** checking compatibility of ``%s''\n", CAESAR_TOOL);

     caesar_check_compatibility (CAESAR_TOOL, CAESAR_GRAPH_COMPILER (), CAESAR_GRAPH_VERSION ());

     CAESAR_INIT_GRAPH ();

     caesar_max_format_state = CAESAR_FORMAT_STATE (CAESAR_MAXIMAL_FORMAT);
     caesar_max_format_label = CAESAR_FORMAT_LABEL (CAESAR_MAXIMAL_FORMAT);

     fprintf (stdout, "*** general parameters\n\n");

     fprintf (stdout, "CAESAR_GRAPH_COMPILER = \"%s\"\n", CAESAR_GRAPH_COMPILER ());

     fprintf (stdout, "CAESAR_GRAPH_VERSION = ");
     CAESAR_PRINT_VERSION (stdout, CAESAR_GRAPH_VERSION ());
     fprintf (stdout, "\n");

     fprintf (stdout, "CAESAR_SIZE_STATE = %lu\n", CAESAR_SIZE_STATE ());

     fprintf (stdout, "CAESAR_HASH_SIZE_STATE = %lu\n", CAESAR_HASH_SIZE_STATE ());

     fprintf (stdout, "CAESAR_ALIGNMENT_STATE = %lu\n", CAESAR_ALIGNMENT_STATE ());

     fprintf (stdout, "CAESAR_MAX_FORMAT_STATE = %u\n", caesar_max_format_state);

     fprintf (stdout, "CAESAR_SIZE_LABEL = %lu\n", CAESAR_SIZE_LABEL ());

     fprintf (stdout, "CAESAR_HASH_SIZE_LABEL = %lu\n", CAESAR_HASH_SIZE_LABEL ());

     fprintf (stdout, "CAESAR_ALIGNMENT_LABEL = %lu\n", CAESAR_ALIGNMENT_LABEL ());

     fprintf (stdout, "CAESAR_MAX_FORMAT_LABEL = %u\n", caesar_max_format_label);

     CAESAR_CREATE_STATE (&caesar_start_state);
     CAESAR_START_STATE (caesar_start_state);

     for (caesar_i = 0; caesar_i < caesar_max_transitions; caesar_i++)
	  CAESAR_CREATE_STATE (&caesar_tab_state[caesar_i]);

     fprintf (stdout, "\n");

     for (caesar_state_format = 0; caesar_state_format <= caesar_max_format_state; ++caesar_state_format) {
	  fprintf (stdout, "CAESAR_PRINT_STATE_HEADER [format %u] = \n", caesar_state_format);
	  CAESAR_FORMAT_STATE (caesar_state_format);
	  CAESAR_PRINT_STATE_HEADER (stdout);
	  fprintf (stdout, "\n");
     }

     caesar_explore ();

     CAESAR_DELETE_STATE (&caesar_start_state);

     for (caesar_i = 0; caesar_i < caesar_max_transitions; caesar_i++)
	  CAESAR_DELETE_STATE (&caesar_tab_state[caesar_i]);

     return (0);
}

/*---------------------------------------------------------------------------*/
