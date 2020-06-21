/******************************************************************************
 *                           E X E C / C A E S A R
 *-----------------------------------------------------------------------------
 *   INRIA - Unite de Recherche Rhone-Alpes
 *   655, avenue de l'Europe
 *   38330 Montbonnot Saint Martin
 *   FRANCE
 *-----------------------------------------------------------------------------
 *   Module             :       main.c
 *   Auteur             :       Hubert GARAVEL
 *   Version            :       1.11
 *   Date               :       2015/08/26 13:46:41
 *****************************************************************************/

#include "caesar_kernel.h"

/*---------------------------------------------------------------------------*/

#include <strings.h>		/* for strcmp() */
#include <unistd.h>		/* for sleep() */
#include <stdarg.h>		/* for va_list ... */

/*---------------------------------------------------------------------------*/

static CAESAR_TYPE_BOOLEAN caesar_kernel_initialized = CAESAR_FALSE;

static FILE *caesar_log_file = NULL;

/*---------------------------------------------------------------------------*/

void CAESAR_KERNEL_EXIT (char *CAESAR_FORMAT,...)
{
     va_list caesar_args;

     va_start (caesar_args, CAESAR_FORMAT);
     if (caesar_log_file != NULL)
	  vfprintf (caesar_log_file, CAESAR_FORMAT, caesar_args);
     if (caesar_log_file != stdout)
	  vfprintf (stdout, CAESAR_FORMAT, caesar_args);
     va_end (caesar_args);

     if (caesar_kernel_initialized)
	  CAESAR_KERNEL_TERM ();

     exit (1);
}

/*---------------------------------------------------------------------------*/

int  main (argc, argv)
int  argc;
char *argv[];

{
#ifdef CAESAR_KERNEL_NO_LOG
     caesar_log_file = NULL;
#else
     /* parsing first argument and setting caesar_log_file */
     if (argc == 1) {
	  /* no argument given => no log */
	  caesar_log_file = NULL;
     } else if (strcmp (argv[1], "-") == 0) {
	  /* argument "-" given => log to stdout */
	  caesar_log_file = stdout;
     } else {
	  /* filename argument given => log to this file */
	  caesar_log_file = fopen (argv[1], "w");
	  if (caesar_log_file == NULL) {
	       CAESAR_KERNEL_EXIT ("cannot write to \"%s\"\n", argv[1]);
	       /* NOTREACHED */
	  }
     }
#endif

     /* main loop */

     CAESAR_KERNEL_INIT (caesar_log_file);
     caesar_kernel_initialized = CAESAR_TRUE;

     while ( /* CONSTCOND */ CAESAR_TRUE) {
	  switch (CAESAR_KERNEL_NEXT ()) {
	  case CAESAR_KERNEL_MOVE:
	       /*
	        * the LOTOS specification has performed a transition that was
	        * accepted by the environment
	        */
	       break;
	  case CAESAR_KERNEL_STOP:
	       /* the LOTOS specification cannot perform any transition */
	       CAESAR_KERNEL_EXIT ("no transition accepted by the specification\n");
	       /* NOTREACHED */
	       break;
	  case CAESAR_KERNEL_WAIT:
	       /*
	        * the LOTOS specification can perform transitions, but none
	        * of them is accepted by the environment
	        */
#ifndef CAESAR_KERNEL_DELAY
	       /* report a mismatch between specification and environment */
	       CAESAR_KERNEL_EXIT ("no transition accepted by the environment\n");
	       /* NOTREACHED */
#elif CAESAR_KERNEL_DELAY == 0
	       /* quietly terminate the execution */
	       CAESAR_KERNEL_TERM ();
	       exit (0);
	       /* NOTREACHED */
#else
	       /* wait CAESAR_KERNEL_DELAY seconds before retrying */
	       sleep (CAESAR_KERNEL_DELAY);
#endif
	       break;
	  }
     }
     /* LINTED (to avoid warnings about missing return) */
}

/*---------------------------------------------------------------------------*/
