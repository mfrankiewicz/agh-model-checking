/******************************************************************************
 *             D A T A    E N C R Y P T I O N    S T A N D A R D
 *-----------------------------------------------------------------------------
 *   INRIA - Unite de Recherche Rhone-Alpes
 *   655, avenue de l'Europe
 *   38330 Montbonnot Saint Martin
 *   FRANCE
 *-----------------------------------------------------------------------------
 *   Module		:	gate_functions.c
 *   Auteur		:	Wendelin SERWE
 *   Version		:	1.20
 *   Date		: 	2015/09/11 12:26:43
 *****************************************************************************/

/*
 * Gate functions for the DES prototype generated using EXEC/CAESAR
 * 
 * The DES prototype reads its inputs from stdin and prints its results to
 * stdout. Each rendezvous corresponds to one line of input (respectively,
 * output), following the syntax of LOTOS, i.e., "<GATE> !<OFFER>". For
 * convenience, 64-bit vectors are represented by a sequence of sixteen
 * hexadecimal digits. The prototype can also write its execution trace in the
 * SEQ format to a log file.
 */

/* ------------------------------------------------------------------------- */

#define CAESAR_ADT_INTERFACE

#if defined (LOTOS)
	#include "DES_CONCRETE.h"
#elif defined (LNT)
	#include "DES.h"
#else
	#error "compile with either -DLOTOS or -DLNT"
#endif

/* ------------------------------------------------------------------------- */

#include "caesar_kernel.h"

extern void CAESAR_KERNEL_EXIT();

#define streq(S1,S2) (strcmp ((S1), (S2)) == 0)

/* ------------------------------------------------------------------------- */

/* auxiliary function to convert a hexadecimal digit into a 4-bit vector */

static ADT_BIT4 CHAR_TO_BIT4 (C)
char C;
{
     switch (C) {
     case '0':
	  return MK_4 (BIT_ZERO (), BIT_ZERO (), BIT_ZERO (), BIT_ZERO ());
     case '1':
	  return MK_4 (BIT_ZERO (), BIT_ZERO (), BIT_ZERO (), BIT_ONE ());
     case '2':
	  return MK_4 (BIT_ZERO (), BIT_ZERO (), BIT_ONE (), BIT_ZERO ());
     case '3':
	  return MK_4 (BIT_ZERO (), BIT_ZERO (), BIT_ONE (), BIT_ONE ());
     case '4':
	  return MK_4 (BIT_ZERO (), BIT_ONE (), BIT_ZERO (), BIT_ZERO ());
     case '5':
	  return MK_4 (BIT_ZERO (), BIT_ONE (), BIT_ZERO (), BIT_ONE ());
     case '6':
	  return MK_4 (BIT_ZERO (), BIT_ONE (), BIT_ONE (), BIT_ZERO ());
     case '7':
	  return MK_4 (BIT_ZERO (), BIT_ONE (), BIT_ONE (), BIT_ONE ());
     case '8':
	  return MK_4 (BIT_ONE (), BIT_ZERO (), BIT_ZERO (), BIT_ZERO ());
     case '9':
	  return MK_4 (BIT_ONE (), BIT_ZERO (), BIT_ZERO (), BIT_ONE ());
     case 'a':
     case 'A':
	  return MK_4 (BIT_ONE (), BIT_ZERO (), BIT_ONE (), BIT_ZERO ());
     case 'b':
     case 'B':
	  return MK_4 (BIT_ONE (), BIT_ZERO (), BIT_ONE (), BIT_ONE ());
     case 'c':
     case 'C':
	  return MK_4 (BIT_ONE (), BIT_ONE (), BIT_ZERO (), BIT_ZERO ());
     case 'd':
     case 'D':
	  return MK_4 (BIT_ONE (), BIT_ONE (), BIT_ZERO (), BIT_ONE ());
     case 'e':
     case 'E':
	  return MK_4 (BIT_ONE (), BIT_ONE (), BIT_ONE (), BIT_ZERO ());
     case 'f':
     case 'F':
	  return MK_4 (BIT_ONE (), BIT_ONE (), BIT_ONE (), BIT_ONE ());
     default:
	  CAESAR_KERNEL_EXIT ("cannot convert '%c' into a 4-bit vector\n", C);
	  /* NOTREACHED */
	  return MK_4 (BIT_ZERO (), BIT_ZERO (), BIT_ZERO (), BIT_ZERO ());
     }
}

/* ------------------------------------------------------------------------- */

/* auxiliary macro to print four bits as a hexadecimal digit */

#define PRINT_4_BITS(F,B1,B2,B3,B4) \
 	{ \
	char N; \
	N = 0; \
	if ((B1) == BIT_ONE ()) N += 8; \
	if ((B2) == BIT_ONE ()) N += 4; \
	if ((B3) == BIT_ONE ()) N += 2; \
	if ((B4) == BIT_ONE ()) N += 1; \
	fprintf ((F), "%x", N); \
	}

/* ------------------------------------------------------------------------- */

/* auxiliary macro to access bit number N of the 64-bit vector V */

#define BIT(V,N) (CAESAR_ADT_STAR_ADT_BIT64 (V).CAESAR_ADT_ ## N ## _MK_64)

/* ------------------------------------------------------------------------- */

/* auxiliary function to output a 64-bit vector V as 16 hexadecimal digits */

static void PRINT_64_BIT_VECTOR (F, V)
FILE *F;
ADT_BIT64 V;
{
     PRINT_4_BITS (F, BIT (V,  1), BIT (V,  2), BIT (V,  3), BIT (V,  4)); 
     PRINT_4_BITS (F, BIT (V,  5), BIT (V,  6), BIT (V,  7), BIT (V,  8)); 
     PRINT_4_BITS (F, BIT (V,  9), BIT (V, 10), BIT (V, 11), BIT (V, 12)); 
     PRINT_4_BITS (F, BIT (V, 13), BIT (V, 14), BIT (V, 15), BIT (V, 16)); 
     PRINT_4_BITS (F, BIT (V, 17), BIT (V, 18), BIT (V, 19), BIT (V, 20)); 
     PRINT_4_BITS (F, BIT (V, 21), BIT (V, 22), BIT (V, 23), BIT (V, 24)); 
     PRINT_4_BITS (F, BIT (V, 25), BIT (V, 26), BIT (V, 27), BIT (V, 28)); 
     PRINT_4_BITS (F, BIT (V, 29), BIT (V, 30), BIT (V, 31), BIT (V, 32)); 
     PRINT_4_BITS (F, BIT (V, 33), BIT (V, 34), BIT (V, 35), BIT (V, 36)); 
     PRINT_4_BITS (F, BIT (V, 37), BIT (V, 38), BIT (V, 39), BIT (V, 40)); 
     PRINT_4_BITS (F, BIT (V, 41), BIT (V, 42), BIT (V, 43), BIT (V, 44)); 
     PRINT_4_BITS (F, BIT (V, 45), BIT (V, 46), BIT (V, 47), BIT (V, 48)); 
     PRINT_4_BITS (F, BIT (V, 49), BIT (V, 50), BIT (V, 51), BIT (V, 52)); 
     PRINT_4_BITS (F, BIT (V, 53), BIT (V, 54), BIT (V, 55), BIT (V, 56)); 
     PRINT_4_BITS (F, BIT (V, 57), BIT (V, 58), BIT (V, 59), BIT (V, 60)); 
     PRINT_4_BITS (F, BIT (V, 61), BIT (V, 62), BIT (V, 63), BIT (V, 64)); 
}

/* ------------------------------------------------------------------------- */

/* buffer for the gate of the rendezvous in the current line of stdin */

static char CURRENT_GATE[6];

/* buffer for the offer of the rendezvous in the current line of stdin */

static char CURRENT_OFFER[17];

/*
 * if equal to zero, CURRENT_GATE and CURRENT_OFFER contain the gate (resp.
 * OFFER) of the rendezvous in the current line of stdin
 */

static char CURRENT_LINE_NOT_READ = 1;

/* ------------------------------------------------------------------------- */

/*
 * auxiliary function to check whether the current line of stdin corresponds to
 * a rendezvous on gate GATE
 */

int PARSE_INPUT (GATE, OFFER)
char *GATE;
void *OFFER; /* a caster */
{
     int N;

     if (feof (stdin))
	  return (0);

     if (CURRENT_LINE_NOT_READ) {
	  /* read a line from stdin */
	  N = scanf ("%5s !%16[0123456789aAbBcCdDeEfF]\n",
		     CURRENT_GATE, CURRENT_OFFER);
	  if (N == EOF)
	       return (0);
	  if (N != 2) {
	       CAESAR_KERNEL_EXIT ("incorrect input syntax\n");
	  }
	  CURRENT_LINE_NOT_READ = 0;
     }
     if (!streq (CURRENT_GATE, GATE))
	  return (0);
     CURRENT_LINE_NOT_READ = 1;

     if (streq (GATE, "CRYPT")) {
	  if (streq (CURRENT_OFFER, "0")) {
	       *((ADT_BOOL *) OFFER) = ADT_FALSE ();
	  } else if (streq (CURRENT_OFFER, "1")) {
	       *((ADT_BOOL *) OFFER) = ADT_TRUE ();
	  } else {
	       CAESAR_KERNEL_EXIT ("incorrect offer \"%s\" for gate %s\n",
				   CURRENT_OFFER, GATE);
	       /* NOTREACHED */
	  }
     } else if (streq (GATE, "DATA") || streq (GATE, "KEY")) {
	  /* set remaining digits to '0' */
	  for (N = strlen (CURRENT_OFFER) ; N < 16 ; N++)
	       CURRENT_OFFER[N] = '0';
	  /* concatenation of the 16 characters to form a 64-bit vector */
	  *((ADT_BIT64 *) OFFER) =
	       CONCAT_BIT4 (CHAR_TO_BIT4 (CURRENT_OFFER[0]),
			    CHAR_TO_BIT4 (CURRENT_OFFER[1]),
			    CHAR_TO_BIT4 (CURRENT_OFFER[2]),
			    CHAR_TO_BIT4 (CURRENT_OFFER[3]),
			    CHAR_TO_BIT4 (CURRENT_OFFER[4]),
			    CHAR_TO_BIT4 (CURRENT_OFFER[5]),
			    CHAR_TO_BIT4 (CURRENT_OFFER[6]),
			    CHAR_TO_BIT4 (CURRENT_OFFER[7]),
			    CHAR_TO_BIT4 (CURRENT_OFFER[8]),
			    CHAR_TO_BIT4 (CURRENT_OFFER[9]),
			    CHAR_TO_BIT4 (CURRENT_OFFER[10]),
			    CHAR_TO_BIT4 (CURRENT_OFFER[11]),
			    CHAR_TO_BIT4 (CURRENT_OFFER[12]),
			    CHAR_TO_BIT4 (CURRENT_OFFER[13]),
			    CHAR_TO_BIT4 (CURRENT_OFFER[14]),
			    CHAR_TO_BIT4 (CURRENT_OFFER[15]));
     } else {
	  CAESAR_KERNEL_EXIT ("unknown gate \"%s\"\n", CURRENT_GATE);
	  /* NOTREACHED */
     }
     return (1);
}

/*---------------------------------------------------------------------------*/

int  CRYPT (INPUT_MODE, BOOL, OFFER, EOL)
CAESAR_KERNEL_OFFER INPUT_MODE;
char *BOOL;
ADT_BOOL *OFFER;
CAESAR_KERNEL_OFFER EOL;
{
     int CAESAR_STATUS;

     CAESAR_KERNEL_ASSERT_INPUT (INPUT_MODE);
     CAESAR_KERNEL_ASSERT_TYPE (BOOL, "ADT_BOOL");
     CAESAR_KERNEL_ASSERT_EOL (EOL);

     CAESAR_STATUS = PARSE_INPUT ("CRYPT", OFFER);

     CAESAR_KERNEL_LOG_GATE (__func__);
     /* LINTED */
     CAESAR_KERNEL_LOG_OFFER (INPUT_MODE, BOOL, *OFFER, ADT_PRINT_BOOL, CAESAR_STATUS);
     CAESAR_KERNEL_LOG_RESULT (CAESAR_STATUS);

     return (CAESAR_STATUS);
}

/* ------------------------------------------------------------------------- */

int  DATA (INPUT_MODE, BIT64, OFFER, EOL)
CAESAR_KERNEL_OFFER INPUT_MODE;
char *BIT64;
ADT_BIT64 *OFFER;
CAESAR_KERNEL_OFFER EOL;
{
     int CAESAR_STATUS;

     CAESAR_KERNEL_ASSERT_INPUT (INPUT_MODE);
     CAESAR_KERNEL_ASSERT_TYPE (BIT64, "ADT_BIT64");
     CAESAR_KERNEL_ASSERT_EOL (EOL);

     CAESAR_STATUS = PARSE_INPUT ("DATA", OFFER);

     CAESAR_KERNEL_LOG_GATE (__func__);
     /* LINTED */
     CAESAR_KERNEL_LOG_OFFER (INPUT_MODE, BIT64, *OFFER, ADT_PRINT_BIT64, CAESAR_STATUS);
     CAESAR_KERNEL_LOG_RESULT (CAESAR_STATUS);

     return (CAESAR_STATUS);
}

/* ------------------------------------------------------------------------- */

int  KEY (INPUT_MODE, BIT64, OFFER, EOL)
CAESAR_KERNEL_OFFER INPUT_MODE;
char *BIT64;
ADT_BIT64 *OFFER;
CAESAR_KERNEL_OFFER EOL;
{
     int CAESAR_STATUS;

     CAESAR_KERNEL_ASSERT_INPUT (INPUT_MODE);
     CAESAR_KERNEL_ASSERT_TYPE (BIT64, "ADT_BIT64");
     CAESAR_KERNEL_ASSERT_EOL (EOL);

     CAESAR_STATUS = PARSE_INPUT ("KEY", OFFER);

     CAESAR_KERNEL_LOG_GATE (__func__);
     /* LINTED */
     CAESAR_KERNEL_LOG_OFFER (INPUT_MODE, BIT64, *OFFER, ADT_PRINT_BIT64, CAESAR_STATUS);
     CAESAR_KERNEL_LOG_RESULT (CAESAR_STATUS);

     return (CAESAR_STATUS);
}

/* ------------------------------------------------------------------------- */

int  OUTPUT (OUTPUT_MODE, BIT64, OFFER, EOL)
CAESAR_KERNEL_OFFER OUTPUT_MODE;
char *BIT64;
ADT_BIT64 OFFER;
CAESAR_KERNEL_OFFER EOL;
{
     CAESAR_KERNEL_ASSERT_OUTPUT (OUTPUT_MODE);
     CAESAR_KERNEL_ASSERT_TYPE (BIT64, "ADT_BIT64");
     CAESAR_KERNEL_ASSERT_EOL (EOL);

     fprintf (stdout, "OUTPUT !");
     PRINT_64_BIT_VECTOR (stdout, OFFER);
     fprintf (stdout, "\n");

     CAESAR_KERNEL_LOG_GATE (__func__);
     /* LINTED */
     CAESAR_KERNEL_LOG_OFFER (OUTPUT_MODE, BIT64, OFFER, ADT_PRINT_BIT64, 1);
     CAESAR_KERNEL_LOG_RESULT (1);

     return (1);
}

/* ------------------------------------------------------------------------- */
