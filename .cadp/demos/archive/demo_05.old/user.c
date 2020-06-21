#include "caesar_system.h"
#include "list.h"

int  main ()
{
     ADT_BOOL B;
     ADT_NAT N;
     LIST L1, L2, L3;
     int  I;

     CAESAR_ADT_INIT ();

     printf ("\n*** boolean enumeration\n\n");
     B = ADT_ENUM_FIRST_BOOL ();
     do {
	  ADT_PRINT_BOOL (stdout, B);
	  printf (" ");
     } while (ADT_ENUM_NEXT_BOOL (B));
     printf ("\n");

     printf ("\n*** natural number enumeration\n\n");
     N = ADT_ENUM_FIRST_NAT ();
     do {
	  if (N > 10)
	       break;
	  else
	       ADT_PRINT_NAT (stdout, N);
	  printf (" ");
     } while (ADT_ENUM_NEXT_NAT (N));
     printf ("\n");

     printf ("\n*** list checking\n\n");
     L1 = EMPTY ();
     for (I = 0; I <= 10; ++I)
	  L1 = ADD (I, L1);
     printf ("L1 = ");
     PRINT_LIST (stdout, L1);
     printf ("\n");

     printf ("\nLENGTH (L1) = ");
     ADT_PRINT_NAT (stdout, LENGTH (L1));
     printf ("\n");

     printf ("\nfirst (L1) = ");
     ADT_PRINT_NAT (stdout, FIRST (L1));
     printf ("\n");

     printf ("\nlast (L1) = ");
     ADT_PRINT_NAT (stdout, LAST (L1));
     printf ("\n");

     L2 = REVERSE (L1);
     printf ("\nL2 = REVERSE (L1) = ");
     PRINT_LIST (stdout, L2);
     printf ("\n");

     L3 = CONCAT (L1, L2);
     printf ("\nCONCAT (L1, L2) = ");
     PRINT_LIST (stdout, L3);
     printf ("\n");

     printf ("\n");

     CAESAR_ADT_TERM ((FILE *) NULL);

     return (0);
}
