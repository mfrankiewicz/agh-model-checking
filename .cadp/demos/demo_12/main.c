#include <strings.h>
#include <stdio.h>
#include <ctype.h>
#include <sys/types.h>
#include <sys/stat.h>

#include "caesar_system.h"
#include "maa.h"

/*---------------------------------------------------------------------------*/

#define streq(S1, S2) (!strcmp (S1, S2))

/*---------------------------------------------------------------------------*/

typedef enum {
     false, true
}    bool;

/*---------------------------------------------------------------------------*/

FILE *INPUT;

/*---------------------------------------------------------------------------*/

#if !defined (ARCHITECTURE_PC_WIN32)

/* normal case: the sscanf() function properly interprets format "%2hhx" */

#define SSCANF_FOUR_OCTETS(S,O1,O2,O3,O4) \
	sscanf ((S), "%2hhx%2hhx%2hhx%2hhx", (O1), (O2), (O3), (O4));

#else

/* Windows case: the own_sscanf() function fails with format "%2hhx" */

#define SSCANF_FOUR_OCTETS(S,O1,O2,O3,O4) \
	{ \
	int I1, I2, I3, I4; \
	sscanf ((S), "%2x%2x%2x%2x", &I1, &I2, &I3, &I4); \
	*(O1) = (char) I1; \
	*(O2) = (char) I2; \
	*(O3) = (char) I3; \
	*(O4) = (char) I4; \
	}
#endif

/*---------------------------------------------------------------------------*/

int  main (argc, argv)
int  argc;
char *argv[];
{
     char *PROGRAM;
     bool OPTION_M, OPTION_T;
     char KEY_OCTET[8];		/* 64-bit key */
     BLOCK J, K;
     char MAC_OCTET[4];		/* 32-bit MAC */
     BLOCK EXPECTED_MAC, B, MAC_RESULT;
     MESSAGE M;
     char X[4], Y;
     int  N;
     bool ANOTHER_BLOCK, NEW_BLOCK;
     char *FILENAME;
     struct stat STAT;

     PROGRAM = argv[0];

     CAESAR_ADT_INIT ();

     OPTION_M = false;
     OPTION_T = false;


     /* parsing command-line arguments */
     argc--;
     argv++;

     while ((argc > 0) && (*argv)[0] == '-') {
	  if (streq (argv[0], "-m")) {
	       OPTION_M = true;
	  } else if (streq (argv[0], "-t")) {
	       OPTION_T = true;
	  } else {
	       printf ("%s: unknown option %s\n", PROGRAM, argv[0]);
	       exit (1);
	  }
	  argc--;
	  argv++;
     }

     if (OPTION_T) {
	  /* verification of standard test vectors */
	  CHECK ();		/* on error, CHECK() will display a message */
	  printf ("\n");
	  exit (0);
     }
     if (argc < 3 || argc > 4) {
	  printf ("usage: %s [-m] [-t] <file> <key-J> <key-K> [<result>]\n", PROGRAM);
	  printf ("       print the MAA value for <file> computed with key (<key-J>, <key-K>)\n");
	  printf ("       -m: print the contents of <file> in hexadecimal\n");
	  printf ("       -t: check the standard MAA vector tests\n");
	  printf ("       <file> is the pathname of a Unix file\n");
	  printf ("       <key-J> is a sequence of 8 hexadecimal digits\n");
	  printf ("       <key-K> is a sequence of 8 hexadecimal digits\n");
	  printf ("       <result> is an optional sequence of 8 hexadecimal digits\n");
	  printf ("       that is the expected MAC result, given for verification\n");
	  exit (1);
     }
     /* open the input file */
     FILENAME = argv[0];
     if ((INPUT = fopen (FILENAME, "r")) == NULL) {
	  printf ("%s: cannot read file %s\n", PROGRAM, FILENAME);
	  exit (1);
     }
     /* check the size of the input file */
     if (stat (FILENAME, &STAT) != 0) {
	  printf ("%s: cannot stat file %s\n", PROGRAM, FILENAME);
	  exit (1);
     } else if (STAT.st_size > 4000000) {
	  printf ("%s: warning: file \"%s\" exceeds the maximal recommended size (1000000 blocks, i.e., 4000000 bytes)\n", PROGRAM, FILENAME);
     }
     /* read the J block of the key */
     if (strlen (argv[1]) != 8) {
	  printf ("%s: the first key \"%s\" must have exactly 8 hexadecimal digits\n", PROGRAM, argv[1]);
	  exit (1);
     }
     SSCANF_FOUR_OCTETS (argv[1], &(KEY_OCTET[0]), &(KEY_OCTET[1]), &(KEY_OCTET[2]), &(KEY_OCTET[3]));
     J = BUILD_BLOCK (NAT_TO_OCTET (KEY_OCTET[0]),
		      NAT_TO_OCTET (KEY_OCTET[1]),
		      NAT_TO_OCTET (KEY_OCTET[2]),
		      NAT_TO_OCTET (KEY_OCTET[3]));

     /* read the K block of the key */
     if (strlen (argv[2]) != 8) {
	  printf ("%s: the second key \"%s\" must have exactly 8 hexadecimal digits\n", PROGRAM, argv[2]);
	  exit (1);
     }
     SSCANF_FOUR_OCTETS (argv[2], &(KEY_OCTET[4]), &(KEY_OCTET[5]), &(KEY_OCTET[6]), &(KEY_OCTET[7]));
     K = BUILD_BLOCK (NAT_TO_OCTET (KEY_OCTET[4]),
		      NAT_TO_OCTET (KEY_OCTET[5]),
		      NAT_TO_OCTET (KEY_OCTET[6]),
		      NAT_TO_OCTET (KEY_OCTET[7]));

     /* optionally, read the MAC_OCTET block */
     if (argc == 4) {
	  if (strlen (argv[3]) != 8) {
	       printf ("%s: the expected MAC \"%s\" must have exactly 8 hexadecimal digits\n", PROGRAM, argv[3]);
	       exit (1);
	  }
	  SSCANF_FOUR_OCTETS (argv[3], &(MAC_OCTET[0]), &(MAC_OCTET[1]), &(MAC_OCTET[2]), &(MAC_OCTET[3]));
	  EXPECTED_MAC = BUILD_BLOCK (NAT_TO_OCTET (MAC_OCTET[0]),
				      NAT_TO_OCTET (MAC_OCTET[1]),
				      NAT_TO_OCTET (MAC_OCTET[2]),
				      NAT_TO_OCTET (MAC_OCTET[3]));
     }
     /* print the key */
     fprintf (stdout, "\nkey = ");
     PRINT_HEXA_BLOCK (stdout, J);
     fprintf (stdout, "_");
     PRINT_HEXA_BLOCK (stdout, K);
     fprintf (stdout, "\n\n");

     /* read the input file; translate each byte to BLOCK, then MESSAGE */
     ANOTHER_BLOCK = true;
     M = NIL_MESSAGE ();

     while (ANOTHER_BLOCK) {
	  NEW_BLOCK = false;
	  for (N = 0; N <= 3; N++) {
	       /* read 4 bytes to form a block */
	       X[N] = 0x00;
	       if (fread (&Y, 1, 1, INPUT) != 0) {
		    X[N] = Y;
		    NEW_BLOCK = true;
	       } else
		    ANOTHER_BLOCK = false;	/* no byte was read => EOF */
	  }

	  if (NEW_BLOCK) {
	       B = BUILD_BLOCK (NAT_TO_OCTET (X[0]),
				NAT_TO_OCTET (X[1]),
				NAT_TO_OCTET (X[2]),
				NAT_TO_OCTET (X[3]));
	       M = PLUS_MESSAGE (B, M);
	  }
     }
     fclose (INPUT);

     /* reverse the message, which was build in the reverse direction */
     M = REVERSE (M);

     /* print the message */
     if (OPTION_M) {
	  fprintf (stdout, "\nmessage = \n");
	  PRINT_HEXA_MESSAGE (stdout, M, 0);
	  fprintf (stdout, "\n\nend of message\n\n");
     }
     /* compute the MAC */
     MAC_RESULT = MAC (J, K, M);

     /* print the MAC */
     fprintf (stdout, "MAC = ");
     PRINT_HEXA_BLOCK (stdout, MAC_RESULT);

     if (argc == 4) {
	  /* check equality between MAC_RESULT and EXPECTED_MAC */
	  if (EQUAL_BLOCK (MAC_RESULT, EXPECTED_MAC))
	       printf ("   (correct)");
	  else
	       printf ("   (INCORRECT)");
     }
     printf ("\n\n");

     return (0);
}
