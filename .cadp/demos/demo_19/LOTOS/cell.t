#define CAESAR_ADT_EXPERT_T 5.6

/*---------------------------------------------------------------------------*/

#define CAESAR_ADT_BITS_NAT : 4 /* hack to save 4 bits */

/*---------------------------------------------------------------------------*/

typedef double ADT_REAL;

#define CAESAR_ADT_SCALAR_ADT_REAL

#define ADT_PRINT_REAL(F,X) fprintf((F), "%G", (X))

extern ADT_REAL fabs();

#define ADT_EPSILON ((ADT_REAL) 1.0E-2)

#define ADT_CMP_REAL(X1,X2) (fabs ((X1) - (X2)) < ADT_EPSILON)

#define ADT_EQ_REAL(X1,X2) (fabs ((X1) - (X2)) < ADT_EPSILON)

#define ADT_NE_REAL(X1,X2) (fabs ((X1) - (X2)) >= ADT_EPSILON)

/*---------------------------------------------------------------------------*/

#include "X_CHARACTER.h"
#include "X_STRING.h"

/*---------------------------------------------------------------------------*/

