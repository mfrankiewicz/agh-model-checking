/******************************************************************************
 *                           O P E N / C A E S A R
 *-----------------------------------------------------------------------------
 *   INRIA - Unite de Recherche Rhone-Alpes
 *   655, avenue de l'Europe
 *   38330 Montbonnot Saint Martin
 *   FRANCE
 *-----------------------------------------------------------------------------
 *   Module             :       caesar_standard.h
 *   Auteur             :       Hubert GARAVEL
 *   Version            :       1.96
 *   Date               :       2019/10/15 07:37:02
 *****************************************************************************/

#ifndef CAESAR_STANDARD_INTERFACE

#define CAESAR_STANDARD_INTERFACE

#ifdef __cplusplus
extern "C" {
#endif

#ifdef CAESAR_UNDEFINED
}
#endif

/*****************************************************************************/

#include "caesar_system.h"	/* pour la portabilite */

/*---------------------------------------------------------------------------*/

#include <memory.h>

#include <signal.h>

/*---------------------------------------------------------------------------*/

#ifndef CAESAR_KERNEL_INTERFACE
#define caesar_use(X)         (void) (X)
/* macro pour faire taire ``lint'' au sujet des variables inutilisees */
#endif

#define caesar_initialize(X)  (X) = 0

/*
 * macro pour faire taire ``gcc -Wall'' au sujet des variables
 * potentiellement utilisees sans etre initialisees
 */

#define caesar_lint_return return (0)
/* pour faire taire ``lint'' : main() returns random value to ... */

/*---------------------------------------------------------------------------*/

/*
 * attention: la plupart des definitions ci-dessous sont reprises dans
 * l'interface "caesar_kernel.h" ainsi que dans le code C produit par Caesar
 * pour la generation de graphes explicites
 */

#ifndef CAESAR_KERNEL_INTERFACE

typedef unsigned long CAESAR_TYPE_NATURAL;

typedef long CAESAR_TYPE_INTEGER;

typedef unsigned char CAESAR_TYPE_BOOLEAN;
#define CAESAR_FALSE ((CAESAR_TYPE_BOOLEAN) 0)
#define CAESAR_TRUE ((CAESAR_TYPE_BOOLEAN) 1)

typedef unsigned char CAESAR_TYPE_BYTE;

typedef char *CAESAR_TYPE_STRING;

typedef FILE *CAESAR_TYPE_FILE;

typedef unsigned char *CAESAR_TYPE_POINTER;

typedef int CAESAR_TYPE_GENUINE_INT;
/*
 * ce type est utilise aux endroits ou l'on veut explicitement un type "int",
 * notamment pour manipuler les variables argc
 */

#endif

/*---------------------------------------------------------------------------*/

typedef CAESAR_TYPE_GENUINE_INT CAESAR_TYPE_ARGC;

typedef char **CAESAR_TYPE_ARGV;

/*---------------------------------------------------------------------------*/

extern CAESAR_TYPE_NATURAL CAESAR_SIZE_POINTER CAESAR_ARG_0 ();

extern CAESAR_TYPE_NATURAL CAESAR_ALIGNMENT_POINTER CAESAR_ARG_0 ();

/*---------------------------------------------------------------------------*/

typedef void (*CAESAR_TYPE_GENERIC_FUNCTION) CAESAR_ARG_0 ();

typedef CAESAR_TYPE_BOOLEAN (*CAESAR_TYPE_COMPARE_FUNCTION) CAESAR_ARG_2 (CAESAR_TYPE_POINTER, CAESAR_TYPE_POINTER);

typedef CAESAR_TYPE_NATURAL (*CAESAR_TYPE_HASH_FUNCTION) CAESAR_ARG_2 (CAESAR_TYPE_POINTER, CAESAR_TYPE_NATURAL);

typedef CAESAR_TYPE_STRING (*CAESAR_TYPE_CONVERT_FUNCTION) CAESAR_ARG_1 (CAESAR_TYPE_POINTER);

typedef void (*CAESAR_TYPE_PRINT_FUNCTION) CAESAR_ARG_2 (CAESAR_TYPE_FILE, CAESAR_TYPE_POINTER);

/*---------------------------------------------------------------------------*/

typedef unsigned char CAESAR_TYPE_FORMAT;
#define CAESAR_INVALID_FORMAT ((CAESAR_TYPE_FORMAT) 255)
#define CAESAR_CURRENT_FORMAT ((CAESAR_TYPE_FORMAT) 254)
#define CAESAR_MAXIMAL_FORMAT ((CAESAR_TYPE_FORMAT) 253)

extern void CAESAR_PRINT_FORMAT CAESAR_ARG_2 (CAESAR_TYPE_FILE, CAESAR_PROMOTE_TO_INT (CAESAR_TYPE_FORMAT));

extern CAESAR_TYPE_FORMAT CAESAR_HANDLE_FORMAT CAESAR_ARG_3 (CAESAR_TYPE_FORMAT *, CAESAR_PROMOTE_TO_INT (CAESAR_TYPE_FORMAT), CAESAR_PROMOTE_TO_INT (CAESAR_TYPE_FORMAT));

/*---------------------------------------------------------------------------*/

/*
 * attention: la plupart des definitions ci-dessous sont reprises dans
 * l'interface "caesar_kernel.h"
 */

/*
 * les deux macros ci-dessous servent a declarer un type pointeur vers un
 * objet abstrait: la premiere declare un pointeur vers une structure et la
 * seconde un pointeur vers caractere; c'est l'implementation effective qui
 * va determiner laquelle des deux macros doit etre utilisee
 */

#ifndef CAESAR_KERNEL_INTERFACE
#define CAESAR_TYPE_ABSTRACT(CAESAR_NAME) struct CAESAR_NAME *
#endif

#define CAESAR_TYPE_ABSTRACT_POINTER(CAESAR_NAME) CAESAR_TYPE_POINTER

/*---------------------------------------------------------------------------*/

/*
 * attention: la plupart des definitions ci-dessous sont reprises dans
 * l'interface "caesar_kernel.h"
 */

#ifndef CAESAR_MEMORY_DEBUG

#define CAESAR_CREATE(CAESAR_ADDRESS,CAESAR_SIZE,CAESAR_TYPE) \
	(CAESAR_ADDRESS) = (CAESAR_TYPE) malloc (CAESAR_SIZE)

#define CAESAR_DELETE(CAESAR_ADDRESS) \
	free ((char *) (CAESAR_ADDRESS))

#else

#define CAESAR_CREATE(CAESAR_ADDRESS,CAESAR_SIZE,CAESAR_TYPE) \
	{ \
	fprintf (stderr, "[%s:%d] new ",  __FILE__, __LINE__); \
	(CAESAR_ADDRESS) = (CAESAR_TYPE) malloc (CAESAR_SIZE); \
	fprintf (stderr, "%d--%d\n",  (CAESAR_ADDRESS), ((unsigned) (CAESAR_ADDRESS)) + (CAESAR_SIZE)); \
	}

#define CAESAR_DELETE(CAESAR_ADDRESS) \
	{ \
	fprintf (stderr, "[%s:%d] old ", __FILE__, __LINE__); \
	free ((char *) (CAESAR_ADDRESS)); \
	fprintf (stderr, "%d\n", (CAESAR_ADDRESS)); \
	}

#endif

/*****************************************************************************/

extern CAESAR_TYPE_STRING CAESAR_TOOL;

extern void CAESAR_WARNING CAESAR_ARG_2 (CAESAR_TYPE_STRING,...);

extern void CAESAR_ERROR CAESAR_ARG_2 (CAESAR_TYPE_STRING,...);

/*---------------------------------------------------------------------------*/

#ifndef CAESAR_PROTEST

#define CAESAR_PROTEST() \
	CAESAR_ERROR ("assertion violation at line %d of file \"%s\"", __LINE__, __FILE__)

#endif

/*---------------------------------------------------------------------------*/

#ifndef CAESAR_ASSERT

#define CAESAR_ASSERT(CAESAR_ASSERTION) \
	{ if (!(CAESAR_ASSERTION)) CAESAR_PROTEST(); }

#endif

/*---------------------------------------------------------------------------*/

typedef void (*CAESAR_TYPE_SIGNAL_HANDLER) (int);

extern void CAESAR_SET_SIGNALS CAESAR_ARG_1 (CAESAR_TYPE_SIGNAL_HANDLER);

extern void CAESAR_RESET_SIGNALS CAESAR_ARG_0 ();

/*---------------------------------------------------------------------------*/

extern CAESAR_TYPE_STRING CAESAR_TEMPORARY_FILE CAESAR_ARG_1 (CAESAR_TYPE_STRING);

/*---------------------------------------------------------------------------*/

extern void CAESAR_OPEN_COMPRESSED_FILE CAESAR_ARG_3 (CAESAR_TYPE_FILE *, CAESAR_TYPE_STRING, CAESAR_TYPE_STRING);

extern void CAESAR_CLOSE_COMPRESSED_FILE CAESAR_ARG_1 (CAESAR_TYPE_FILE *);

/*---------------------------------------------------------------------------*/

#define CAESAR_FUNCTION_NAME(CAESAR_FUNCTION) \
    CAESAR_HINT_FUNCTION_NAME ((CAESAR_TYPE_GENERIC_FUNCTION) (CAESAR_FUNCTION))

extern CAESAR_TYPE_STRING CAESAR_HINT_FUNCTION_NAME CAESAR_ARG_1 (CAESAR_TYPE_GENERIC_FUNCTION);

/*****************************************************************************/

#ifdef CAESAR_UNDEFINED
{
#endif

#ifdef __cplusplus
}
#endif

#endif
