#define CAESAR_ADT_EXPERT_T 5.6

#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include "caesar_system.h"

typedef char *EXP;
#define CAESAR_ADT_UNCANONICAL_EXP
#define CAESAR_ADT_SCALAR_EXP

#define CMP_EXP(E1,E2) (((E1)==(E2)) || strcmp ((E1),(E2))==0)

#define PRINT_EXP(F,E) fprintf((F), "`%s'", ((E) == NULL) ? "null" : (E))

