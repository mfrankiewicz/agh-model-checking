/******************************************************************************
 *                                B C G
 *-----------------------------------------------------------------------------
 *   INRIA - Unite de Recherche Rhone-Alpes
 *   655, avenue de l'Europe
 *   38330 Montbonnot Saint Martin
 *   FRANCE
 *-----------------------------------------------------------------------------
 *   Module             :       bcg_types.h
 *   Auteurs            :       Renaud RUFFIOT et Hubert GARAVEL
 *   Version            :       1.54
 *   Date               :       2016/05/23 10:30:48
 *****************************************************************************/

#ifndef BCG_TYPES_INTERFACE

#define BCG_TYPES_INTERFACE

#ifdef __cplusplus
extern "C" {
#endif

#ifdef BCG_UNDEFINED
}
#endif

#include <stdio.h>
#include <string.h>
#include <sys/types.h>
#include <sys/time.h>
#include <stdlib.h>
#include <unistd.h>
#include <ctype.h>
#include <limits.h>		

/*
 * en principe, il ne faut pas inclure "bcg_types.h" sans avoir inclus
 * "bcg_standard.h" qui fournit BCG_ARG_xxx() ; de plus, "bcg_standard.h"
 * inclut "bcg_types.h"
 */

typedef FILE *BCG_TYPE_BCG_FILE;

typedef FILE *BCG_TYPE_STREAM;

typedef char BCG_TYPE_OPEN_TYPE[3];
typedef int BCG_TYPE_BCG_BUFFER;

typedef unsigned char BCG_TYPE_8_BITS_INT;
typedef unsigned int BCG_TYPE_32_BITS_INT;
typedef unsigned long long int BCG_TYPE_64_BITS_INT;

typedef int BCG_TYPE_GENUINE_INT;
/*
 * ce type est utilise aux endroits ou l'on veut explicitement un type "int",
 * notamment pour manipuler les variables argc
 */

typedef unsigned int BCG_TYPE_GENUINE_UINT;
/*
 * ce type est utilise aux endroits ou l'on veut explicitement un type
 * "unsigned int"
 */

typedef long BCG_TYPE_GENUINE_LONG;
/*
 * ce type est utilise aux endroits ou l'on veut explicitement un type
 * "long", par exemple pour manipuler le resultat de strtol()
 */

typedef int BCG_TYPE_FILE_DESCRIPTOR;

#define BCG_MAX_FILE_NAME_LENGTH 2048

typedef char *BCG_TYPE_FILE_NAME;

typedef unsigned char BCG_TYPE_BOOLEAN;
#define BCG_FALSE            ((BCG_TYPE_BOOLEAN) 0)
#define BCG_TRUE             ((BCG_TYPE_BOOLEAN) 1)

typedef unsigned int BCG_TYPE_NATURAL;

#define BCG_NATURAL_SIZE	4	

#define BCG_MAX_NATURAL		0xffffffff

#define BCG_MAX_BCG_NATURAL ((BCG_TYPE_NATURAL) 536870912)

typedef unsigned long BCG_TYPE_LONG_NATURAL;

typedef int BCG_TYPE_INTEGER;

#define BCG_MAX_INTEGER		((BCG_TYPE_INTEGER) 0x7fffffff)

typedef long BCG_TYPE_LONG_INTEGER;

#define BCG_MAX_LONG_INTEGER	LONG_MAX

typedef double BCG_TYPE_REAL;

typedef unsigned char BCG_TYPE_BYTE;

typedef char *BCG_TYPE_C_STRING;

typedef char *BCG_TYPE_BLOCK;

typedef size_t BCG_TYPE_SIZE;

typedef off_t BCG_TYPE_OFFSET;

typedef char BCG_TYPE_SHELL_COMMAND[4096];

typedef BCG_TYPE_NATURAL BCG_TYPE_TYPE_NUMBER;
typedef BCG_TYPE_NATURAL BCG_TYPE_PROFILE_NUMBER;
typedef BCG_TYPE_NATURAL BCG_TYPE_FUNCTION_NUMBER;
typedef BCG_TYPE_NATURAL BCG_TYPE_FILE_NUMBER;
typedef BCG_TYPE_NATURAL BCG_TYPE_NAME_NUMBER;
typedef BCG_TYPE_NATURAL BCG_TYPE_LABEL_NUMBER;

typedef BCG_TYPE_LONG_NATURAL BCG_TYPE_EDGE_NUMBER;
typedef BCG_TYPE_LONG_NATURAL BCG_TYPE_STATE_NUMBER;
typedef BCG_TYPE_LONG_NATURAL BCG_TYPE_CLASS_NUMBER;

typedef char *BCG_TYPE_LABEL_STRING;

typedef unsigned int BCG_TYPE_BUFFER_INDEX;

typedef int BCG_TYPE_COMPARISON_RESULT;

typedef int BCG_TYPE_SCAN_RESULT;
#define BCG_SCAN_OK                       ((BCG_TYPE_SCAN_RESULT) 0)
#define BCG_SCAN_NOK                      ((BCG_TYPE_SCAN_RESULT) 1)
#define BCG_SCAN_NOK_OVERFLOW             ((BCG_TYPE_SCAN_RESULT) 2)
#define BCG_SCAN_NOK_UNDERFLOW            ((BCG_TYPE_SCAN_RESULT) 3)
#define BCG_SCAN_NOK_BAD_ESCAPE           ((BCG_TYPE_SCAN_RESULT) 4)
#define BCG_SCAN_NOK_BAD_HEXADECIMAL      ((BCG_TYPE_SCAN_RESULT) 5)
#define BCG_SCAN_NOK_BAD_OCTAL            ((BCG_TYPE_SCAN_RESULT) 6)
#define BCG_SCAN_NOK_BAD_CHARACTER        ((BCG_TYPE_SCAN_RESULT) 7)
#define BCG_SCAN_NOK_BAD_STRING           ((BCG_TYPE_SCAN_RESULT) 8)
#define BCG_SCAN_NOK_NULL_STRING          ((BCG_TYPE_SCAN_RESULT) 9)
#define BCG_SCAN_NOK_MEMORY_SHORTAGE      ((BCG_TYPE_SCAN_RESULT) 10)
#define BCG_SCAN_NOK_BAD_RAW     	  ((BCG_TYPE_SCAN_RESULT) 11)

typedef unsigned int BCG_TYPE_DATA_FORMAT;
#define BCG_UNPARSED_DATA_FORMAT          ((BCG_TYPE_DATA_FORMAT) 0)
#define BCG_STANDARD_DATA_FORMAT          ((BCG_TYPE_DATA_FORMAT) 1)

typedef char *BCG_TYPE_ADDRESS;

typedef BCG_TYPE_COMPARISON_RESULT (*BCG_TYPE_COMPARISON_FUNCTION) ();

typedef BCG_TYPE_NATURAL (*BCG_TYPE_HASH_CODE_FUNCTION) ();

typedef void (*BCG_TYPE_PRINT_FUNCTION) ();

typedef void (BCG_BODY_READ_PROFILE_FUNCTION) BCG_ARG_3 (BCG_TYPE_PROFILE_NUMBER, BCG_TYPE_ADDRESS *, BCG_TYPE_NATURAL *);
typedef BCG_BODY_READ_PROFILE_FUNCTION *BCG_TYPE_READ_PROFILE_FUNCTION;

typedef void (BCG_BODY_WRITE_PROFILE_FUNCTION) BCG_ARG_3 (BCG_TYPE_PROFILE_NUMBER, BCG_TYPE_ADDRESS, BCG_TYPE_NATURAL *);
typedef BCG_BODY_WRITE_PROFILE_FUNCTION *BCG_TYPE_WRITE_PROFILE_FUNCTION;

typedef struct {
     BCG_TYPE_BOOLEAN bcg_end;
     BCG_TYPE_EDGE_NUMBER bcg_i;
     BCG_TYPE_STATE_NUMBER bcg_p;
     BCG_TYPE_LABEL_NUMBER bcg_l;
     BCG_TYPE_STATE_NUMBER bcg_n;
}    BCG_TYPE_EDGE;

#ifdef BCG_UNDEFINED
{
#endif

#ifdef __cplusplus
}
#endif

#endif
