/******************************************************************************
 *                           O P E N / C A E S A R
 *-----------------------------------------------------------------------------
 *   INRIA - Unite de Recherche Rhone-Alpes
 *   655, avenue de l'Europe
 *   38330 Montbonnot Saint Martin
 *   FRANCE
 *-----------------------------------------------------------------------------
 *   Module             :       simulator.c
 *   Auteur             :       Hubert GARAVEL
 *   Version            :       2.22
 *   Date               :       2017/09/05 12:47:24
 *****************************************************************************/

char caesar_sccs_what_simulator[] =
"@(#)open/caesar -- 2.22 -- 2017/09/05 12:47:24 -- simulator.c";

#include "caesar_standard.h"

#include "simulator.i"

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

#define caesar_select if (CAESAR_FALSE) ((void) 0)

#define caesar_when(caesar_s) else if (strcmp (caesar_command, caesar_s) == 0)

#define caesar_otherwise else

/*---------------------------------------------------------------------------*/

int  main (argc, argv)
int  argc;
char *argv[];
{
     char caesar_command[4096];
     CAESAR_TYPE_NATURAL caesar_history;
     CAESAR_TYPE_NATURAL caesar_n;

     caesar_use (argc);
     CAESAR_TOOL = argv[0];

     caesar_history = 0;

     caesar_S_init (stdout);

     while ( /* CONSTCOND */ CAESAR_TRUE) {
	  /* read and parse the user command */

	  fprintf (stdout, "command %lu ? ", ++caesar_history);
	  fflush (stdout);
	  fscanf (stdin, "%s", caesar_command);
	  fprintf (stdout, "\n");

	  /* CONSTCOND */
	  caesar_select;

	  caesar_when ("state")
	       caesar_S_state_display ();

	  caesar_when ("edges")
	       caesar_S_edge_display ();

	  caesar_when ("path")
	       caesar_S_path_display ();

	  caesar_when ("header")
	       caesar_S_header_display ();

	  caesar_when ("prev")
	       caesar_S_previous ();

	  caesar_when ("next") {
	       caesar_S_next_1 ();
	       if (caesar_S_cardinal_successors () != 0) {
		    caesar_n = caesar_read_number ("which successor", 1L, caesar_S_cardinal_successors ());
		    caesar_S_next_2 (caesar_n);
	       }
	  }

	  caesar_when ("reset")
	       caesar_S_reset ();

	  caesar_when ("verbose")
	       caesar_S_set_verbose ();

	  caesar_when ("silent")
	       caesar_S_unset_verbose ();

	  caesar_when ("delta")
	       caesar_S_set_delta ();

	  caesar_when ("plain")
	       caesar_S_unset_delta ();

	  caesar_when ("stack")
	       caesar_S_set_stack ();

	  caesar_when ("sequence")
	       caesar_S_unset_stack ();

	  caesar_when ("state_format") {
	       caesar_n = caesar_read_number ("which state format", 0L, CAESAR_FORMAT_STATE (CAESAR_MAXIMAL_FORMAT));
	       caesar_S_assign_state_format (caesar_n);
	  }

	  caesar_when ("label_format") {
	       caesar_n = caesar_read_number ("which label format", 0L, CAESAR_FORMAT_LABEL (CAESAR_MAXIMAL_FORMAT));
	       caesar_S_assign_label_format (caesar_n);
	  }

	  caesar_when ("quit")
	       break;

	  caesar_when ("exit")
	       break;

	  caesar_when ("help")
	       caesar_S_help (0L);

	  caesar_when ("?")
	       caesar_S_help (0L);

	  caesar_otherwise
	       fprintf (stdout, "illegal command ``%s''\n\n", caesar_command);

     }
     return (0);
}
