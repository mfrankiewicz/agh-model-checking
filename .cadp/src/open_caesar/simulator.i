/******************************************************************************
 *                           O P E N / C A E S A R
 *-----------------------------------------------------------------------------
 *   INRIA - Unite de Recherche Rhone-Alpes
 *   655, avenue de l'Europe
 *   38330 Montbonnot Saint Martin
 *   FRANCE
 *-----------------------------------------------------------------------------
 *   Module             :       simulator.i
 *   Auteur             :       Hubert GARAVEL
 *   Version            :       1.31
 *   Date               :       2019/09/12 10:55:24
 *****************************************************************************/

char caesar_sccs_what_common[] =
"@(#)open/caesar -- 1.31 -- 2019/09/12 10:55:24 -- simulator.i";

#include "caesar_graph.h"

#include "caesar_edge.h"

#include "caesar_stack_1.h"

#include <signal.h>
#include <setjmp.h>

/* ======================================================================== */

/* parametres definissant l'etat global du simulateur */

static CAESAR_TYPE_FILE caesar_S_output;

static CAESAR_TYPE_BOOLEAN caesar_S_verbose_mode = CAESAR_FALSE;

static CAESAR_TYPE_BOOLEAN caesar_S_delta_mode = CAESAR_FALSE;

static CAESAR_TYPE_BOOLEAN caesar_S_stack_mode = CAESAR_FALSE;

static CAESAR_TYPE_NATURAL caesar_S_state_format;

static CAESAR_TYPE_NATURAL caesar_S_label_format;

static CAESAR_TYPE_STACK_1 caesar_k;

static CAESAR_TYPE_NATURAL caesar_S_nb_successors;

static CAESAR_TYPE_NATURAL caesar_S_nb_truncations;

static int caesar_S_problem_at_current_state;

static jmp_buf caesar_recovery;

/* ======================================================================== */

void caesar_S_logo ()
{
     fprintf (caesar_S_output, "-- open/caesar simulator with X-windows interface 1.31\n");
     fprintf (caesar_S_output, "-- graphics: Frederic Rocheteau\n");
     fprintf (caesar_S_output, "-- lyrics: Hubert Garavel\n");
     fprintf (caesar_S_output, "\n");
}

/* ======================================================================== */

CAESAR_TYPE_BOOLEAN caesar_S_value_verbose ()
{
     return (caesar_S_verbose_mode);
}

/*---------------------------------------------------------------------------*/

CAESAR_TYPE_STRING caesar_S_text_verbose ()
{
     switch (caesar_S_verbose_mode) {
	  case CAESAR_FALSE:
	  return ("silent");
     case CAESAR_TRUE:
	  return ("verbose");
     }
     /* NOTREACHED */
#ifdef __GNUC__
     return (NULL);		/* to keep "gcc -Wall" silent */
#endif
}

/*---------------------------------------------------------------------------*/

void caesar_S_unset_verbose ()
{
     caesar_S_verbose_mode = CAESAR_FALSE;
}

/*---------------------------------------------------------------------------*/

void caesar_S_set_verbose ()
{
     caesar_S_verbose_mode = CAESAR_TRUE;
}

/*---------------------------------------------------------------------------*/

void caesar_S_toggle_verbose ()
{
     if (caesar_S_verbose_mode)
	  caesar_S_verbose_mode = CAESAR_FALSE;
     else
	  caesar_S_verbose_mode = CAESAR_TRUE;
}

/* ======================================================================== */

CAESAR_TYPE_BOOLEAN caesar_S_value_delta ()
{
     return (caesar_S_delta_mode);
}

/*---------------------------------------------------------------------------*/

CAESAR_TYPE_STRING caesar_S_text_delta ()
{
     switch (caesar_S_delta_mode) {
	  case CAESAR_FALSE:
	  return ("plain");
     case CAESAR_TRUE:
	  return ("delta");
     }
     /* NOTREACHED */
#ifdef __GNUC__
     return (NULL);		/* to keep "gcc -Wall" silent */
#endif
}

/*---------------------------------------------------------------------------*/

void caesar_S_unset_delta ()
{
     caesar_S_delta_mode = CAESAR_FALSE;
}

/*---------------------------------------------------------------------------*/

void caesar_S_set_delta ()
{
     caesar_S_delta_mode = CAESAR_TRUE;
}

/*---------------------------------------------------------------------------*/

void caesar_S_toggle_delta ()
{
     if (caesar_S_delta_mode)
	  caesar_S_delta_mode = CAESAR_FALSE;
     else
	  caesar_S_delta_mode = CAESAR_TRUE;
}

/* ======================================================================== */

CAESAR_TYPE_BOOLEAN caesar_S_value_stack ()
{
     return (caesar_S_stack_mode);
}

/*---------------------------------------------------------------------------*/

CAESAR_TYPE_STRING caesar_S_text_stack ()
{
     switch (caesar_S_stack_mode) {
	  case CAESAR_FALSE:
	  return ("sequence");
     case CAESAR_TRUE:
	  return ("stack");
     }
     /* NOTREACHED */
#ifdef __GNUC__
     return (NULL);		/* to keep "gcc -Wall" silent */
#endif
}

/*---------------------------------------------------------------------------*/

void caesar_S_unset_stack ()
{
     caesar_S_stack_mode = CAESAR_FALSE;
}

/*---------------------------------------------------------------------------*/

void caesar_S_set_stack ()
{
     caesar_S_stack_mode = CAESAR_TRUE;
}

/*---------------------------------------------------------------------------*/

void caesar_S_toggle_stack ()
{
     if (caesar_S_stack_mode)
	  caesar_S_stack_mode = CAESAR_FALSE;
     else
	  caesar_S_stack_mode = CAESAR_TRUE;
}

/* ======================================================================== */

#define caesar_S_range_state_format 1

/*---------------------------------------------------------------------------*/

CAESAR_TYPE_NATURAL caesar_S_default_state_format ()
{
     return (0);
}

/*---------------------------------------------------------------------------*/

CAESAR_TYPE_STRING caesar_S_text_state_format ()
{
     static char caesar_S_text[8];
     sprintf (caesar_S_text, "%lu", caesar_S_state_format);
     return (caesar_S_text);
}

/*---------------------------------------------------------------------------*/

void caesar_S_assign_state_format (caesar_n)
CAESAR_TYPE_NATURAL caesar_n;
{
     caesar_S_state_format = caesar_n;
     CAESAR_FORMAT_STATE (caesar_S_state_format);
}

/*---------------------------------------------------------------------------*/

void caesar_S_toggle_state_format ()
{
     ++caesar_S_state_format;
     if (caesar_S_state_format == caesar_S_range_state_format)
	  caesar_S_state_format = 0;
     CAESAR_FORMAT_STATE (caesar_S_state_format);
}

/* ======================================================================== */

#define caesar_S_range_label_format 2

/*---------------------------------------------------------------------------*/

CAESAR_TYPE_NATURAL caesar_S_default_label_format ()
{
     if (CAESAR_FORMAT_LABEL (CAESAR_MAXIMAL_FORMAT) == 0)
	  return (0);
     else
	  return (1);		/* for LOTOS */
}

/*---------------------------------------------------------------------------*/

CAESAR_TYPE_STRING caesar_S_text_label_format ()
{
     static char caesar_S_text[8];
     sprintf (caesar_S_text, "%lu", caesar_S_label_format);
     return (caesar_S_text);
}

/*---------------------------------------------------------------------------*/

void caesar_S_assign_label_format (caesar_n)
CAESAR_TYPE_NATURAL caesar_n;
{
     caesar_S_label_format = caesar_n;
     CAESAR_FORMAT_LABEL (caesar_S_label_format);
}

/*---------------------------------------------------------------------------*/

void caesar_S_toggle_label_format ()
{
     ++caesar_S_label_format;
     if (caesar_S_label_format == caesar_S_range_label_format)
	  caesar_S_label_format = 0;
     CAESAR_FORMAT_LABEL (caesar_S_label_format);
}

/* ======================================================================== */

void caesar_S_header_display ()
{
     fprintf (caesar_S_output, "state vector:\n");
     CAESAR_PRINT_STATE_HEADER (caesar_S_output);
     fprintf (caesar_S_output, "\n");
}

/* ======================================================================== */

void caesar_S_state_display ()
{
     fprintf (caesar_S_output, "current state: ");
     CAESAR_PRINT_STATE (caesar_S_output, CAESAR_TOP_STATE_STACK_1 (caesar_k));
     fprintf (caesar_S_output, "\n\n");
}

/* ======================================================================== */

void caesar_S_edge_display ()
{
     CAESAR_TYPE_STATE caesar_s1, caesar_s2;
     CAESAR_TYPE_LABEL caesar_l;
     CAESAR_TYPE_NATURAL caesar_n;
     CAESAR_TYPE_EDGE caesar_e;
     CAESAR_TYPE_STRING caesar_information;

     caesar_s1 = CAESAR_TOP_STATE_STACK_1 (caesar_k);
     caesar_n = 0;
     CAESAR_ITERATE_LN_EDGE_LIST (CAESAR_TOP_EDGE_STACK_1 (caesar_k), caesar_e, caesar_l, caesar_s2) {
	  ++caesar_n;
	  fprintf (caesar_S_output, "successor #%lu: ", caesar_n);
	  if (caesar_S_value_verbose ()) {
	       fprintf (caesar_S_output, "--- ");
	  }
	  CAESAR_PRINT_LABEL (caesar_S_output, caesar_l);
	  caesar_information = CAESAR_INFORMATION_LABEL (caesar_l);
	  if (*caesar_information != '\0')
	       fprintf (caesar_S_output, " (%s)", caesar_information);
	  if (caesar_S_value_verbose ()) {
	       fprintf (caesar_S_output, " ---> ");
	       if (caesar_S_value_delta ())
		    CAESAR_DELTA_STATE (caesar_S_output, caesar_s1, caesar_s2);
	       else
		    CAESAR_PRINT_STATE (caesar_S_output, caesar_s2);
	  }
	  fprintf (caesar_S_output, "\n");
     }
     if (caesar_n == 0)
	  fprintf (caesar_S_output, "<sink state>\n");
     fprintf (caesar_S_output, "\n");
}

/* ========================================================================= */

void caesar_S_enter ()
{
     /* Recovery point (in case of error in CAESAR.ADT computations) */

     caesar_S_problem_at_current_state = setjmp (caesar_recovery);

     /*
      * Here, caesar_S_problem_at_current_state is equal to 0 if the
      * successor list has not been computed yet, or equal to 1 if the
      * successor list has been already computed and an ADT error has
      * occurred (a signal 15 was received)
      */

     fprintf (caesar_S_output, "*** current state at depth %lu\n\n", CAESAR_DEPTH_STACK_1 (caesar_k) - 1);

     if (caesar_S_problem_at_current_state == 0) {
	  /* compute the successor list */

	  CAESAR_CREATE_TOP_EDGE_STACK_1 (caesar_k);

	  caesar_S_nb_successors = CAESAR_CREATION_EDGE_LIST ();

	  caesar_S_nb_truncations = CAESAR_TRUNCATION_EDGE_LIST ();
	  if (caesar_S_nb_truncations != 0)
	       fprintf (caesar_S_output, "<truncation occurred: %lu successors missing>\n", caesar_S_nb_truncations);

	  /* print informations related to the current state */

	  if (caesar_S_value_verbose ())
	       caesar_S_header_display ();

	  if (caesar_S_value_verbose ())
	       caesar_S_state_display ();

	  caesar_S_edge_display ();
     } else {
	  /*
	   * a problem occured when computing the successor list consider the
	   * current state as a deadlock state
	   */
	  caesar_S_nb_successors = 0;
	  caesar_S_nb_truncations = 0;	/* just to be clean */
     }
}

/* ========================================================================= */

static void caesar_S_recover (caesar_signal)
int  caesar_signal;
{
     /* assert caesar_signal == 15 */

     fprintf (stdout, "\n<caught signal %d, probably raised during evaluation of an ADT expression>\n\n", caesar_signal);

     fprintf (stdout, "<cannot compute the edges going out of the current state>\n\n");

     CAESAR_DELETE_TOP_EDGE_STACK_1 (caesar_k);

     /* reinstall the signal catch for non-POSIX systems (see below) */
     signal (SIGTERM, caesar_S_recover);

     longjmp (caesar_recovery, 1);
}

/* ========================================================================= */

void caesar_S_init (caesar_file)
CAESAR_TYPE_FILE caesar_file;

{
     CAESAR_INIT_GRAPH ();
     CAESAR_INIT_STACK_1 ();

     caesar_S_state_format = caesar_S_default_state_format ();
     CAESAR_FORMAT_STATE (caesar_S_state_format);

     caesar_S_label_format = caesar_S_default_label_format ();
     CAESAR_FORMAT_LABEL (caesar_S_label_format);

     CAESAR_CREATE_STACK_1 (&caesar_k, 5, (CAESAR_TYPE_OVERFLOW_FUNCTION_STACK_1) NULL);
     if (caesar_k == NULL)
	  CAESAR_ERROR ("not enough memory for stack");

     CAESAR_PUSH_STACK_1 (caesar_k, (CAESAR_TYPE_LABEL) NULL, (CAESAR_TYPE_STATE) NULL);
     CAESAR_START_STATE (CAESAR_TOP_STATE_STACK_1 (caesar_k));

     caesar_S_output = caesar_file;

     fprintf (caesar_S_output, "\n<initial state>\n\n");

     /* for catching "raise (15)" signals sent by CAESAR.ADT code */
     signal (SIGTERM, caesar_S_recover);

     caesar_S_enter ();
}

/* ======================================================================== */

CAESAR_TYPE_NATURAL caesar_S_cardinal_successors ()
{
     return (caesar_S_nb_successors);
}

/* ========================================================================= */

void caesar_S_path_display ()
{
     if (caesar_S_value_stack ()) {
	  CAESAR_FORMAT_STACK_1 (caesar_k, 0);
	  CAESAR_PRINT_STACK_1 (caesar_S_output, caesar_k);
	  CAESAR_FORMAT_STACK_1 (caesar_k, 3);
	  CAESAR_PRINT_STACK_1 (caesar_S_output, caesar_k);
	  fprintf (caesar_S_output, "\n");
     } else {
	  CAESAR_FORMAT_STACK_1 (caesar_k, 1);
	  fprintf (caesar_S_output, "<initial state>\n");
	  CAESAR_PRINT_STACK_1 (caesar_S_output, caesar_k);
	  fprintf (caesar_S_output, "<current state>\n\n");
     }
}

/* ========================================================================= */

void caesar_S_previous ()
{
     if (CAESAR_DEPTH_STACK_1 (caesar_k) == 1)
	  fprintf (caesar_S_output, "<initial state>\n\n");
     else {
	  CAESAR_DELETE_TOP_EDGE_STACK_1 (caesar_k);
	  CAESAR_POP_STACK_1 (caesar_k);
	  caesar_S_enter ();
     }
}

/* ========================================================================= */

void caesar_S_reset ()
{
     if (CAESAR_DEPTH_STACK_1 (caesar_k) == 1)
	  fprintf (caesar_S_output, "<initial state>\n\n");
     else {
	  while (CAESAR_DEPTH_STACK_1 (caesar_k) > 1) {
	       CAESAR_DELETE_TOP_EDGE_STACK_1 (caesar_k);
	       CAESAR_POP_STACK_1 (caesar_k);
	  }
	  caesar_S_enter ();
     }
}

/* ========================================================================= */

void caesar_S_next_1 ()
{
     if (caesar_S_problem_at_current_state != 0)
	  fprintf (caesar_S_output, "<cannot compute the successors of this state>\n\n");
     else if (caesar_S_nb_successors == 0)
	  fprintf (caesar_S_output, "<sink state>\n\n");
}

/* ========================================================================= */

void caesar_S_next_2 (caesar_n)
CAESAR_TYPE_NATURAL caesar_n;
{
     CAESAR_TYPE_NATURAL caesar_m;
     CAESAR_TYPE_LABEL caesar_new_label;
     CAESAR_TYPE_STATE caesar_new_state;

     CAESAR_CREATE_LABEL (&caesar_new_label);
     CAESAR_CREATE_STATE (&caesar_new_state);

     for (caesar_m = 1; caesar_m <= caesar_S_nb_successors; ++caesar_m) {
	  if (caesar_m == caesar_n) {
	       CAESAR_COPY_LABEL (caesar_new_label,
		    CAESAR_LABEL_EDGE (CAESAR_TOP_EDGE_STACK_1 (caesar_k)));
	       CAESAR_COPY_STATE (caesar_new_state,
	       CAESAR_NEXT_STATE_EDGE (CAESAR_TOP_EDGE_STACK_1 (caesar_k)));
	  }
	  CAESAR_REJECT_STACK_1 (caesar_k);
     }
     CAESAR_PUSH_STACK_1 (caesar_k, caesar_new_label, caesar_new_state);
     caesar_S_enter ();

     CAESAR_DELETE_LABEL (&caesar_new_label);
     CAESAR_DELETE_STATE (&caesar_new_state);
}

/* ========================================================================= */

void caesar_S_next_3 (caesar_string)
CAESAR_TYPE_STRING caesar_string;
{
     int  caesar_result;
     CAESAR_TYPE_NATURAL caesar_n;

     if (caesar_S_problem_at_current_state != 0)
	  fprintf (caesar_S_output, "<cannot compute the successors of this state>\n\n");
     else if (caesar_S_nb_successors == 0)
	  fprintf (caesar_S_output, "<sink state>\n\n");
     else if ((caesar_string == NULL) || (caesar_string[0] == '\0'))
	  fprintf (caesar_S_output, "<select first a 'successor #' line with the mouse>\n\n");
     else {
	  caesar_result = sscanf (caesar_string, "successor #%lu:", &caesar_n);
	  if (caesar_result != 1)
	       fprintf (caesar_S_output, "<selected line is not valid>\n\n");
	  else if (caesar_n > caesar_S_nb_successors)
	       fprintf (caesar_S_output, "<successor #%lu does not exist>\n\n", caesar_n);
	  else {
	       fprintf (caesar_S_output, "*** successor #%lu selected\n\n", caesar_n);
	       caesar_S_next_2 (caesar_n);
	  }
     }
}

/* ========================================================================= */

void caesar_S_help (caesar_format)
CAESAR_TYPE_NATURAL caesar_format;
{
     /* caesar_format = 0 => simulator.c */
     /* caesar_format = 1 => xsimulator.c */

     if (caesar_format == 0) {
	  fprintf (caesar_S_output, "The following commands are currently supported by the simulator:\n\n");
     } else if (caesar_format == 1) {
	  fprintf (caesar_S_output, "BUTTONS CURRENTLY SUPPORTED BY THE SIMULATOR:\n\n");
     }
     fprintf (caesar_S_output, "state               print the current state\n");
     fprintf (caesar_S_output, "edges               print the successor list of the current state\n");
     fprintf (caesar_S_output, "path                print the execution sequence from initial to current state\n");
     fprintf (caesar_S_output, "header              print the state vector contents\n");
     fprintf (caesar_S_output, "next                move to a selected successor state\n");
     fprintf (caesar_S_output, "prev                move to the predecessor state (backtrack)\n");
     fprintf (caesar_S_output, "reset               move to the initial state (backtrack)\n");
     fprintf (caesar_S_output, "help                display this message\n");
     fprintf (caesar_S_output, "quit                terminate the simulation\n");

     if (caesar_format == 0) {
	  fprintf (caesar_S_output, "?                   same as \"help\"\n");
	  fprintf (caesar_S_output, "exit                same as \"quit\"\n");
     } else if (caesar_format == 1) {
	  fprintf (caesar_S_output, "\n");
	  fprintf (caesar_S_output, "SWITCHES CURRENTLY SUPPORTED BY THE SIMULATOR:\n\n");
     }
     fprintf (caesar_S_output, "verbose             set verbose mode to display the successor list\n");
     fprintf (caesar_S_output, "silent              opposite of verbose (default)\n");
     fprintf (caesar_S_output, "delta               set delta mode to display next states (verbose mode only)\n");
     fprintf (caesar_S_output, "plain               opposite of delta (default)\n");
     fprintf (caesar_S_output, "stack               set stack mode to display the execution sequence\n");
     fprintf (caesar_S_output, "sequence            opposite of stack (default)\n");
     fprintf (caesar_S_output, "state_format        set the format for displaying states (default %lu)\n", caesar_S_default_state_format ());
     fprintf (caesar_S_output, "label_format        set the format for displaying labels (default %lu)\n", caesar_S_default_label_format ());
     fprintf (caesar_S_output, "\n");
}

/* ======================================================================== */
