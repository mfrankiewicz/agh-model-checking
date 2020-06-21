/******************************************************************************
 *                                B C G
 *-----------------------------------------------------------------------------
 *   INRIA - Unite de Recherche Rhone-Alpes
 *   655, avenue de l'Europe
 *   38330 Montbonnot Saint Martin
 *   FRANCE
 *-----------------------------------------------------------------------------
 *   Module		:	bcg_standard.h
 *   Auteurs		:	Renaud RUFFIOT et Hubert GARAVEL
 *   Version		:	1.66
 *   Date		: 	2017/09/07 09:51:25
 *****************************************************************************/

#ifndef BCG_STANDARD_INTERFACE

#define BCG_STANDARD_INTERFACE

#ifdef __cplusplus
extern "C" {
#endif

#ifdef BCG_UNDEFINED
}
#endif

/*****************************************************************************/

#include "caesar_system.h"	/* pour la portabilite */

/*---------------------------------------------------------------------------*/

#if defined (CAESAR_WITHOUT_PROTOTYPES)

/*
 * les prototypes de fonctions sont desactives uniquement pour les
 * architectures obsoletes
 */

#define BCG_ARG_0()                                  ()
#define BCG_ARG_1(A1)                                ()
#define BCG_ARG_2(A1,A2)                             ()
#define BCG_ARG_3(A1,A2,A3)                          ()
#define BCG_ARG_4(A1,A2,A3,A4)                       ()
#define BCG_ARG_5(A1,A2,A3,A4,A5)                    ()
#define BCG_ARG_6(A1,A2,A3,A4,A5,A6)                 ()
#define BCG_ARG_7(A1,A2,A3,A4,A5,A6,A7)              ()
#define BCG_ARG_8(A1,A2,A3,A4,A5,A6,A7,A8)           ()
#define BCG_ARG_9(A1,A2,A3,A4,A5,A6,A7,A8,A9)        ()
#define BCG_ARG_10(A1,A2,A3,A4,A5,A6,A7,A8,A9,A10)   ()
#define BCG_ARG_11(A1,A2,A3,A4,A5,A6,A7,A8,A9,A10,A11) ()

#else

#define BCG_ARG_0() \
        (void)
#define BCG_ARG_1(A1) \
        (A1)
#define BCG_ARG_2(A1,A2) \
        (A1, A2)
#define BCG_ARG_3(A1,A2,A3) \
        (A1, A2, A3)
#define BCG_ARG_4(A1,A2,A3,A4) \
        (A1, A2, A3, A4)
#define BCG_ARG_5(A1,A2,A3,A4,A5) \
        (A1, A2, A3, A4, A5)
#define BCG_ARG_6(A1,A2,A3,A4,A5,A6) \
        (A1, A2, A3, A4, A5, A6)
#define BCG_ARG_7(A1,A2,A3,A4,A5,A6,A7) \
        (A1, A2, A3, A4, A5, A6, A7)
#define BCG_ARG_8(A1,A2,A3,A4,A5,A6,A7,A8) \
        (A1, A2, A3, A4, A5, A6, A7, A8)
#define BCG_ARG_9(A1,A2,A3,A4,A5,A6,A7,A8,A9) \
        (A1, A2, A3, A4, A5, A6, A7, A8, A9)
#define BCG_ARG_10(A1,A2,A3,A4,A5,A6,A7,A8,A9,A10) \
        (A1, A2, A3, A4, A5, A6, A7, A8, A9, A10)
#define BCG_ARG_11(A1,A2,A3,A4,A5,A6,A7,A8,A9,A10,A11) \
        (A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11)

#endif

/*---------------------------------------------------------------------------*/

#if defined (CAESAR_WITH_OLD_PROTOTYPES)
#define BCG_PROMOTE_TO_INT(T) int
#else
#define BCG_PROMOTE_TO_INT(T) T
#endif

/*---------------------------------------------------------------------------*/

/* buffer pour passer une chaine de caractere a BCG_ASSERT */
extern char BCG_ASSERT_BUFFER[];

#define BCG_ASSERT(bcg_assertion,bcg_file,bcg_message,bcg_fatal) \
	{ \
        if (! (bcg_assertion)) BCG_ERROR (bcg_file, bcg_message,bcg_fatal) \
        }

#define BCG_ERROR(bcg_file,bcg_message,bcg_fatal) \
	{ \
	fprintf (stdout, "%s: %s", (bcg_file), (bcg_message)); \
	if ((bcg_fatal) == BCG_TRUE) \
		BCG_CLEANUP (); \
	}

/*---------------------------------------------------------------------------*/

#define bcg_streq(bcg_string_1,bcg_string_2) \
	(strcmp((bcg_string_1),(bcg_string_2))==0)

#define bcg_isodigit(bcg_c) (((bcg_c) >= '0') && ((bcg_c) <= '7'))

#define bcg_blanks " \f\n\r\t\v"

#define bcg_blank_character(bcg_character) \
	(((bcg_character) != '\0') && strchr (bcg_blanks, (bcg_character)) != NULL)

#define bcg_blank_string(bcg_string) \
        (strspn ((bcg_string), bcg_blanks) == strlen (bcg_string))

/*---------------------------------------------------------------------------*/

#define bcg_lint_use(bcg_var)          (void) (bcg_var)
/* pour faire taire ``lint'' au sujet des variables inutilisees */

#define bcg_lint_initialize(bcg_var)   (bcg_var) = 0
/*
 * pour faire taire ``gcc -Wall'' au sujet des variables potentiellement
 * utilisees sans etre initialisees
 */

#define bcg_lint_return return (0)
/* pour faire taire ``lint'' : main() returns random value to ... */

/*---------------------------------------------------------------------------*/

#if defined (COMPILER_SUNOS_CC)

#define BCG_CAST(A)		/* rien */

#else

#define BCG_CAST(A)	(A)

#endif

/*---------------------------------------------------------------------------*/

#include "bcg_types.h"

#include "bcg_temporary.h"

/*---------------------------------------------------------------------------*/

extern int BCG_HEXADECIMAL_VALUE BCG_ARG_1 (BCG_PROMOTE_TO_INT (char));

/*---------------------------------------------------------------------------*/

extern BCG_TYPE_STREAM BCG_FOPEN BCG_ARG_4 (BCG_TYPE_C_STRING, BCG_TYPE_C_STRING, BCG_TYPE_C_STRING, BCG_PROMOTE_TO_INT (BCG_TYPE_BOOLEAN));

/*****************************************************************************/

#ifdef BCG_UNDEFINED
{
#endif

#ifdef __cplusplus
}
#endif

#endif
