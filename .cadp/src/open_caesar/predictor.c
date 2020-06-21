/******************************************************************************
 *                           O P E N / C A E S A R
 *-----------------------------------------------------------------------------
 *   INRIA - Unite de Recherche Rhone-Alpes
 *   655, avenue de l'Europe
 *   38330 Montbonnot Saint Martin
 *   FRANCE
 *-----------------------------------------------------------------------------
 *   Module             :       predictor.c
 *   Auteur             :       Hubert GARAVEL
 *   Version            :       2.27
 *   Date               :       2009/05/15 11:24:01
 *****************************************************************************/

char caesar_sccs_what_predictor[] =
"@(#)open/caesar -- 2.27 -- 2009/05/15 11:24:01 -- predictor.c";

#include "caesar_graph.h"

#include <limits.h>		/* pour UINT_MAX et ULONG_MAX */

/*---------------------------------------------------------------------------*/

typedef unsigned long long caesar_type_memory_size;
/*
 * note: il faut absolument prendre un entier sur 64 bits car, par exemple,
 * sous Solaris 32 bits avec 4Go de memoire, "cadp_memory -physical" renvoie
 * 4294967296, c'est-a-dire 2^32, soit 0 si on prenait un type "unsigned
 * long"
 */

#define caesar_megabyte 1048576	/* 1024 * 1024 */

#define caesar_megastate 1000000

/*---------------------------------------------------------------------------*/

int  main (argc, argv)
int  argc;
char *argv[];
{
     CAESAR_TYPE_NATURAL caesar_state_size;	/* in bytes */
     caesar_type_memory_size caesar_memory_size;	/* in bytes */
     CAESAR_TYPE_NATURAL caesar_bucket_size;	/* in bytes */
     CAESAR_TYPE_NATURAL caesar_max_states;
     CAESAR_TYPE_NATURAL caesar_modulus;
     CAESAR_TYPE_FILE caesar_pipe;
     char caesar_message[1024];
     CAESAR_TYPE_GENUINE_INT caesar_result;

     caesar_use (argc);
     CAESAR_TOOL = argv[0];
     CAESAR_INIT_GRAPH ();

     caesar_state_size = CAESAR_SIZE_STATE ();
     if (caesar_state_size == 1)
	  fprintf (stdout, "\nstate size = %lu byte\n", caesar_state_size);
     else
	  fprintf (stdout, "\nstate size = %lu bytes\n", caesar_state_size);

     caesar_pipe = popen ("$CADP/bin.`$CADP/com/arch`/cadp_memory", "r");
     if (caesar_pipe == NULL)
	  CAESAR_ERROR ("cannot open pipe for cadp_memory");

     while (CAESAR_TRUE) {
	  caesar_result = fscanf (caesar_pipe, "%llu %[^\n]", &caesar_memory_size, caesar_message);
	  if ((caesar_result == EOF) || (caesar_result == 0)) {
	       /* end-of-pipe */
	       break;
	  } else if (caesar_result == 1) {
	       /* memory value without accompanying message */
	       strcpy (caesar_message, "memory size available on this machine");
	  }
	  fprintf (stdout, "\n%s = %.2f megabytes\n", caesar_message, (float) caesar_memory_size / caesar_megabyte);

#if ULONG_MAX == UINT_MAX
	  caesar_bucket_size = caesar_state_size + 4;
#else
	  caesar_bucket_size = caesar_state_size + 5;
#endif
	  caesar_modulus = caesar_bucket_size % CAESAR_ALIGNMENT_STATE ();
	  if (caesar_modulus != 0)
	       caesar_bucket_size += (CAESAR_ALIGNMENT_STATE () - caesar_modulus);
	  caesar_max_states = (CAESAR_TYPE_NATURAL) (caesar_memory_size / caesar_bucket_size);
	  fprintf (stdout, "maximal number of states that can be stored = %.2f megastates\n", (float) caesar_max_states / caesar_megastate);
     }

     pclose (caesar_pipe);
     return (0);
}

/*---------------------------------------------------------------------------*/
