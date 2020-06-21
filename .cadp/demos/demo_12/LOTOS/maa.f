
#define CAESAR_ADT_EXPERT_F 5.6

/* #define DEBUG */

#include <stdint.h>		/* for uint32_t and uint64_t */

/*---------------------------------------------------------------------------*/

#define N255() 255

/*---------------------------------------------------------------------------*/

#define NAT_TO_BIT(N) ((N) == 0 ? ADT_ZERO_BIT () : ADT_ONE_BIT ())

/*---------------------------------------------------------------------------*/

ADT_OCTET NAT_TO_OCTET (N)
ADT_NAT N;

{
     ADT_BIT B1, B2, B3, B4, B5, B6, B7, B8;

     /* convert the natural number N to an octet */
     B1 = NAT_TO_BIT (N & 0x80);
     B2 = NAT_TO_BIT (N & 0x40);
     B3 = NAT_TO_BIT (N & 0x20);
     B4 = NAT_TO_BIT (N & 0x10);
     B5 = NAT_TO_BIT (N & 0x08);
     B6 = NAT_TO_BIT (N & 0x04);
     B7 = NAT_TO_BIT (N & 0x02);
     B8 = NAT_TO_BIT (N & 0x01);
#ifdef DEBUG
     printf ("NAT_TO_OCTET : %u -> %d %d %d %d %d %d %d %d\n",
	     N, B1, B2, B3, B4, B5, B6, B7, B8);
#endif
     return ADT_OCT (B1, B2, B3, B4, B5, B6, B7, B8);
}

/*---------------------------------------------------------------------------*/

BLOCK NAT_TO_BLOCK (N)
ADT_NAT N;

{
     ADT_OCTET O1, O2, O3, O4;

     /* convert the natural number N to a block */
     O1 = NAT_TO_OCTET ((N >> 24) & 0xFF);
     O2 = NAT_TO_OCTET ((N >> 16) & 0xFF);
     O3 = NAT_TO_OCTET ((N >> 8) & 0xFF);
     O4 = NAT_TO_OCTET (N & 0xFF);
#ifdef DEBUG
     printf ("NAT_TO_BLOCK : 0x%08X ->\n\t", N);
     ADT_PRINT_OCTET (stdout, O1);
     printf ("\n\t");
     ADT_PRINT_OCTET (stdout, O2);
     printf ("\n\t");
     ADT_PRINT_OCTET (stdout, O3);
     printf ("\n\t");
     ADT_PRINT_OCTET (stdout, O4);
     printf ("\n");
#endif

     return BUILD_BLOCK (O1, O2, O3, O4);
}

/*---------------------------------------------------------------------------*/

ADT_NAT OCTET_TO_NAT (O)
ADT_OCTET O;
{
     ADT_BIT B1, B2, B3, B4, B5, B6, B7, B8;
     ADT_NAT N;

     B1 = CAESAR_ADT_STAR_ADT_OCTET (O).CAESAR_ADT_1_ADT_OCT;
     B2 = CAESAR_ADT_STAR_ADT_OCTET (O).CAESAR_ADT_2_ADT_OCT;
     B3 = CAESAR_ADT_STAR_ADT_OCTET (O).CAESAR_ADT_3_ADT_OCT;
     B4 = CAESAR_ADT_STAR_ADT_OCTET (O).CAESAR_ADT_4_ADT_OCT;
     B5 = CAESAR_ADT_STAR_ADT_OCTET (O).CAESAR_ADT_5_ADT_OCT;
     B6 = CAESAR_ADT_STAR_ADT_OCTET (O).CAESAR_ADT_6_ADT_OCT;
     B7 = CAESAR_ADT_STAR_ADT_OCTET (O).CAESAR_ADT_7_ADT_OCT;
     B8 = CAESAR_ADT_STAR_ADT_OCTET (O).CAESAR_ADT_8_ADT_OCT;
     N = (B1 << 7) | (B2 << 6) | (B3 << 5) | (B4 << 4) |
	  (B5 << 3) | (B6 << 2) | (B7 << 1) | B8;
#ifdef DEBUG
     printf ("OCTET_TO_NAT : ");
     ADT_PRINT_OCTET (stdout, O);
     printf (" -> %d %d %d %d %d %d %d %d -> 0x%02X\n",
	     B1, B2, B3, B4, B5, B6, B7, B8, N);
#endif
     return N;
}

/*---------------------------------------------------------------------------*/

ADT_NAT BLOCK_TO_NAT (B)
BLOCK B;

{
     ADT_OCTET O1, O2, O3, O4;
     ADT_NAT N;

     O1 = CAESAR_ADT_STAR_BLOCK (B).CAESAR_ADT_1_BUILD_BLOCK;
     O2 = CAESAR_ADT_STAR_BLOCK (B).CAESAR_ADT_2_BUILD_BLOCK;
     O3 = CAESAR_ADT_STAR_BLOCK (B).CAESAR_ADT_3_BUILD_BLOCK;
     O4 = CAESAR_ADT_STAR_BLOCK (B).CAESAR_ADT_4_BUILD_BLOCK;
     N = (OCTET_TO_NAT (O1) << 24) | (OCTET_TO_NAT (O2) << 16) |
	  (OCTET_TO_NAT (O3) << 8) | OCTET_TO_NAT (O4);
#ifdef DEBUG
     printf ("BLOCK_TO_NAT : ");
     PRINT_BLOCK (stdout, B);
     printf (" -> 0x%08X\n", N);
#endif
     return N;
}

/*---------------------------------------------------------------------------*/
/* redefinition of the printing function for a block */

static void PRINT_HEXA_BLOCK (CAESAR_ADT_FILE, CAESAR_ADT_0)
FILE *CAESAR_ADT_FILE;
BLOCK CAESAR_ADT_0;

{
     fprintf (CAESAR_ADT_FILE, "%08X", BLOCK_TO_NAT (CAESAR_ADT_0));
}

/*---------------------------------------------------------------------------*/
/* redefinition of the printing function for a message */

static void PRINT_HEXA_MESSAGE (CAESAR_ADT_FILE, CAESAR_ADT_0, CAESAR_ADT_LEVEL)
FILE *CAESAR_ADT_FILE;
MESSAGE CAESAR_ADT_0;
ADT_NAT CAESAR_ADT_LEVEL;

{
     if (CAESAR_ADT_0 == NULL)
	  fprintf (CAESAR_ADT_FILE, "?");
     else if (CAESAR_ADT_MATCH_NIL_MESSAGE (CAESAR_ADT_0)) {
	  /* nothing */
     } else {
	  if (CAESAR_ADT_LEVEL % 8 == 0)
	       fprintf (CAESAR_ADT_FILE, "\n");
	  PRINT_HEXA_BLOCK (CAESAR_ADT_FILE, CAESAR_ADT_GET_1_PLUS_MESSAGE (CAESAR_ADT_0));
	  fprintf (CAESAR_ADT_FILE, "  ");
	  PRINT_HEXA_MESSAGE (CAESAR_ADT_FILE, CAESAR_ADT_GET_2_PLUS_MESSAGE (CAESAR_ADT_0), CAESAR_ADT_LEVEL + 1);
     }
}

/*---------------------------------------------------------------------------*/

BLOCK ADD (X, Y)
BLOCK X;
BLOCK Y;

{
     ADT_NAT N_1;
     ADT_NAT N_2;
     ADT_NAT R;

     N_1 = BLOCK_TO_NAT (X);
     N_2 = BLOCK_TO_NAT (Y);
     R = N_1 + N_2;
     return NAT_TO_BLOCK (R);
}

/*---------------------------------------------------------------------------*/

BLOCK CAR (X, Y)
BLOCK X;
BLOCK Y;

{
     ADT_NAT N_1;
     ADT_NAT N_2;
     ADT_BIT MSB_1, MSB_2, NEG_S, CARRY;

     N_1 = BLOCK_TO_NAT (X);
     N_2 = BLOCK_TO_NAT (Y);
     MSB_1 = (ADT_BIT) (N_1 >> 31);	/* most significant bit of N1 */
     MSB_2 = (ADT_BIT) (N_2 >> 31);	/* most significant bit of N2 */
     NEG_S = (ADT_BIT) ((~((ADT_NAT) (N_1 + N_2))) >> 31);
     /* negation of the most significant bit of the sum */
     CARRY = (ADT_BIT) ((MSB_1 & MSB_2) | (NEG_S & MSB_1) | (NEG_S & MSB_2));
     return NAT_TO_BLOCK (CARRY);
}

/*---------------------------------------------------------------------------*/

BLOCK HIGH_MUL (X, Y)
BLOCK X;
BLOCK Y;

{
     ADT_NAT N_1;
     ADT_NAT N_2;
     ADT_NAT R;

     N_1 = BLOCK_TO_NAT (X);
     N_2 = BLOCK_TO_NAT (Y);
     /* compute the higher 32 bits of the product of two 32-bit numbers */
     R = (uint32_t) (((uint64_t) ((uint64_t) N_1 * (uint64_t) N_2)) >> 32);
     return NAT_TO_BLOCK (R);
}

/*---------------------------------------------------------------------------*/

BLOCK LOW_MUL (X, Y)
BLOCK X;
BLOCK Y;

{
     ADT_NAT N_1;
     ADT_NAT N_2;
     ADT_NAT R;

     N_1 = BLOCK_TO_NAT (X);
     N_2 = BLOCK_TO_NAT (Y);
     /* compute the lower 32 bits of the product of two 32-bit numbers */
     R = (uint32_t) (N_1 * N_2);
     return NAT_TO_BLOCK (R);
}

/*---------------------------------------------------------------------------*/

/*
 * For efficiency reasons, the REVERSE function is implemented directly in C
 * (since the implementation automatically generated from abstract data types
 * allocates dangling memory cells)
 */

MESSAGE REVERSE (MSG)
MESSAGE MSG;
{
     MESSAGE CURR, RESULT;

     if (CAESAR_ADT_MATCH_NIL_MESSAGE (MSG)) {
	  /* the list is empty: nothing to do */
	  return MSG;
     }
     RESULT = NIL_MESSAGE ();
     CURR = MSG;
     while (!CAESAR_ADT_MATCH_NIL_MESSAGE (CURR)) {
	  RESULT = PLUS_MESSAGE (CAESAR_ADT_GET_1_PLUS_MESSAGE (CURR), RESULT);
	  CURR = CAESAR_ADT_GET_2_PLUS_MESSAGE (CURR);
     }
     return (RESULT);
}

/*---------------------------------------------------------------------------*/

int  CHECK ()
{
     printf ("no test vectors given in the LOTOS specification of the MAA\n");
     return 0;
}

/*---------------------------------------------------------------------------*/
