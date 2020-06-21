#define CAESAR_ADT_EXPERT_F 5.6

#include <stdlib.h>

#define ZERO() "0"

#define X1() "X1"
#define X2() "X2"
#define X3() "X3"
#define X4() "X4"
#define X5() "X5"
#define X6() "X6"
#define X7() "X7"
#define X8() "X8"
#define X9() "X9"
#define X10() "X10"
#define X11() "X11"
#define X12() "X12"
#define X13() "X13"
#define X14() "X14"
#define X15() "X15"
#define X16() "X16"
#define X17() "X17"
#define X18() "X18"
#define X19() "X19"
#define X20() "X20"
#define X21() "X21"
#define X22() "X22"
#define X23() "X23"
#define X24() "X24"
#define X25() "X25"
#define X26() "X26"

#define W1() "W1"
#define W2() "W2"
#define W3() "W3"
#define W4() "W4"
#define W5() "W5"
#define W6() "W6"
#define W7() "W7"

/*---------------------------------------------------------------------------*/

EXP Plus (E1, E2)
EXP E1, E2;
{
     EXP E;
     if (CMP_EXP (E1, ZERO ()))
	  return E2;
     else if (CMP_EXP (E2, ZERO ()))
	  return E1;
     else {
	  E = (EXP) malloc (strlen (E1) + strlen (E2) + 2);
	  if (E == NULL) {
	       printf ("Plus: not enough memory\n");
	       exit (1);
	  }
	  sprintf (E, "%s+%s", E1, E2);
	  return E;
     }
}

/*---------------------------------------------------------------------------*/

EXP Star (E1, E2)
EXP E1, E2;
{
     EXP E;
     E = (EXP) malloc (strlen (E1) + strlen (E2) + 2);
     if (E == NULL) {
	  printf ("Star: not enough memory\n");
	  exit (1);
     }
     sprintf (E, "%s*%s", E1, E2);
     return E;
}

/*---------------------------------------------------------------------------*/

