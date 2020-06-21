/******************************************************************************
 *                           E X E C / C A E S A R
 *-----------------------------------------------------------------------------
 *   INRIA - Unite de Recherche Rhone-Alpes
 *   655, avenue de l'Europe
 *   38330 Montbonnot Saint Martin
 *   FRANCE
 *-----------------------------------------------------------------------------
 *   Module             :       main.c
 *   Auteurs            :       Hubert GARAVEL et Wendelin SERWE
 *   Version            :       1.6
 *   Date               :       2017/02/23 12:07:08
 *****************************************************************************/

/*
 * this module is based on file $CADP/src/exec_caesar/main.c with one simple
 * adaptation: the event REACT must be sent to the graphical Tcl/Tk simulator
 * done at each end of cycle, i.e., when the LOTOS / LNT specification has
 * emitted all output actions
 */

#include "caesar_kernel.h"

/*---------------------------------------------------------------------------*/

#include <strings.h>		/* for strcmp() */

/*---------------------------------------------------------------------------*/

extern void REACT ();

/*---------------------------------------------------------------------------*/

int  main (argc, argv)
int  argc;
char *argv[];

{
     FILE *caesar_log_file;

#ifdef CAESAR_KERNEL_NO_LOG
     caesar_log_file = NULL;
#else
     /* parsing first argument and setting caesar_log_file */
     if (argc == 1) {
	  /* no argument given => no log */
	  caesar_log_file = NULL;
     } else if (strcmp (argv[1], "-") == 0) {
	  /* argument "-" given => log to stderr */
	  caesar_log_file = stderr;
     } else {
	  /* filename argument given => log to this file */
	  caesar_log_file = fopen (argv[1], "w");
	  if (caesar_log_file == NULL) {
	       fprintf (stderr, "cannot write to \"%s\"\n", argv[1]);
	       exit (1);
	  }
     }
#endif

     /* main loop */

     CAESAR_KERNEL_INIT (caesar_log_file);

     while ( /* CONSTCOND */ CAESAR_TRUE) {

	  /* secondary loop over all inputs/outputs of the current cycle */

	  while ( /* CONSTCOND */ CAESAR_TRUE) {
	       switch (CAESAR_KERNEL_NEXT ()) {
	       case CAESAR_KERNEL_MOVE:
		    break;
	       case CAESAR_KERNEL_STOP:
		    /* deadlock */
		    CAESAR_KERNEL_TERM ();
		    exit (1);
		    break;
	       case CAESAR_KERNEL_WAIT:
		    goto END_OF_CYCLE;
		    break;
	       }
	  }
END_OF_CYCLE:
	  /*
	   * the driver cannot perform any more events (except GET_STATUS,
	   * that is enabled in the LOTOS/LNT specification, but blocked
	   * at the gate function level) => perform REACT to fire the next
	   * GET_STATUS
	   */
	  REACT ();
     }
     /* LINTED (to avoid warnings about missing return) */
}

/*---------------------------------------------------------------------------*/
