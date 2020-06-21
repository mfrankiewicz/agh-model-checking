/******************************************************************************
 *                           E X E C / C A E S A R
 *-----------------------------------------------------------------------------
 *   INRIA - Unite de Recherche Rhone-Alpes
 *   655, avenue de l'Europe
 *   38330 Montbonnot Saint Martin
 *   FRANCE
 *-----------------------------------------------------------------------------
 *   Module             :       caesar_kernel.h
 *   Auteur             :       Hubert GARAVEL
 *   Version            :       1.36
 *   Date               :       2017/09/06 15:02:07
 *****************************************************************************/

#ifndef CAESAR_KERNEL_INTERFACE

#define CAESAR_KERNEL_INTERFACE

#ifdef __cplusplus
extern "C" {
#endif

#ifdef CAESAR_UNDEFINED
}
#endif

/*****************************************************************************/

#include "caesar_system.h"

#include <memory.h>

/*****************************************************************************/
/*
 * les definitions ci-dessous sont reprises d'OPEN/CAESAR et leur semantique
 * est decrite dans le manuel de reference Open/Caesar
 */
/*****************************************************************************/

#ifndef CAESAR_STANDARD_INTERFACE

/* definitions reprises de l'interface "caesar_standard.h" */

#define caesar_use(X)         (void) (X)
/* macro pour faire taire ``lint'' au sujet des variables inutilisees */

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

#define CAESAR_TYPE_ABSTRACT(CAESAR_NAME) struct CAESAR_NAME *

#endif

/*---------------------------------------------------------------------------*/

/* definitions egalement reprises de l'interface "caesar_standard.h" */

#ifdef CAESAR_STANDARD_INTERFACE
#undef CAESAR_ARG_0
#undef CAESAR_ARG_1
#endif

#ifdef CAESAR_KERNEL_NO_PROTOTYPE

/*
 * Si CAESAR_KERNEL_NO_PROTOTYPE est defini, les prototypes de fonctions sont
 * desactives (ceci peut etre utile pour compiler avec d'anciens compilateurs
 * C, notamment celui de SunOS). Par defaut, CAESAR_KERNEL_NO_PROTOTYPE n'est
 * pas defini.
 */

#define CAESAR_ARG_0()   ()
#define CAESAR_ARG_1(A1) ()

#else

#define CAESAR_ARG_0()   (void)
#define CAESAR_ARG_1(A1) (A1)

#endif

/*---------------------------------------------------------------------------*/

/* definitions egalement reprises de l'interface "caesar_standard.h" */

#ifdef CAESAR_STANDARD_INTERFACE
#undef CAESAR_CREATE
#undef CAESAR_DELETE
#endif

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

/*---------------------------------------------------------------------------*/

/*
 * definitions reprises du code C produit par Caesar pour la generation de
 * graphes explicites
 */

typedef double CAESAR_TYPE_VERSION;

typedef unsigned int CAESAR_TYPE_TRANSITION_NUMBER;

/*---------------------------------------------------------------------------*/

/* definitions reprises de l'interface "caesar_graph.h" */

typedef CAESAR_TYPE_ABSTRACT (CAESAR_STRUCT_STATE) CAESAR_TYPE_STATE;

/*** extern CAESAR_TYPE_NATURAL CAESAR_SIZE_STATE CAESAR_ARG_0 (); ***/

#define CAESAR_SIZE_STATE() CAESAR_HINT_SIZE_STATE
extern CAESAR_TYPE_NATURAL CAESAR_HINT_SIZE_STATE;	/* not to be referenced! */

/*** extern CAESAR_TYPE_NATURAL CAESAR_ALIGNMENT_STATE CAESAR_ARG_0 (); ***/

#define CAESAR_ALIGNMENT_STATE() CAESAR_HINT_ALIGNMENT_STATE
extern CAESAR_TYPE_NATURAL CAESAR_HINT_ALIGNMENT_STATE;	/* not to be referenced! */

/*** extern void CAESAR_CREATE_STATE CAESAR_ARG_1 (CAESAR_TYPE_STATE *); ***/

#define CAESAR_CREATE_STATE(CAESAR_S) CAESAR_CREATE (*(CAESAR_S), CAESAR_SIZE_STATE(), CAESAR_TYPE_STATE)

/*** extern void CAESAR_DELETE_STATE CAESAR_ARG_1 (CAESAR_TYPE_STATE *); ***/

#define CAESAR_DELETE_STATE(CAESAR_S) { CAESAR_DELETE (*(CAESAR_S)); *(CAESAR_S) = NULL; }

/*---------------------------------------------------------------------------*/

/* definitions reprises de l'interface "caesar_graph.h" */

typedef CAESAR_TYPE_ABSTRACT (CAESAR_STRUCT_LABEL) CAESAR_TYPE_LABEL;

/*****************************************************************************/
/* les definitions ci-dessous sont propres a Exec/Caesar */
/*****************************************************************************/

typedef enum {
     CAESAR_KERNEL_EOL,
     CAESAR_KERNEL_INPUT,
     CAESAR_KERNEL_OUTPUT
}    CAESAR_KERNEL_OFFER;

/*---------------------------------------------------------------------------*/

typedef enum {
     CAESAR_KERNEL_MOVE,
     CAESAR_KERNEL_WAIT,
     CAESAR_KERNEL_STOP
}    CAESAR_KERNEL_ACTION;

/*---------------------------------------------------------------------------*/

extern void CAESAR_KERNEL_INIT CAESAR_ARG_1 (CAESAR_TYPE_FILE);

extern CAESAR_KERNEL_ACTION CAESAR_KERNEL_NEXT CAESAR_ARG_0 ();

extern void CAESAR_KERNEL_TERM CAESAR_ARG_0 ();

/*---------------------------------------------------------------------------*/

#ifndef CAESAR_KERNEL_NO_LOG

/*
 * Si CAESAR_KERNEL_NO_LOG est defini, le code C produit par le compilateur
 * Caesar (avec option -exec) n'effectuera pas l'impression des transitions
 * franchies, lors des appels a la fonction CAESAR_KERNEL_NEXT(), dans un
 * fichier "log" au format Sequence de CADP. Par defaut, CAESAR_KERNEL_NO_LOG
 * n'est pas defini
 */

extern CAESAR_TYPE_FILE CAESAR_KERNEL_LOG;

/*
 * Le code C genere par l'option "-external" de Caesar pour les fonctions
 * portes contient des appels aux macro-definitions suivantes
 */

#ifndef CAESAR_KERNEL_OWN_LOG

/*
 * L'utilisateur ne souhaite pas utiliser ses propres macros, donc on utilise
 * les definitions standards ci-dessous.
 */

#define CAESAR_KERNEL_LOG_MARK_OUTPUT "<output>"
#define CAESAR_KERNEL_LOG_MARK_INPUT "<input>"
#define CAESAR_KERNEL_LOG_MARK_EOL "<eol>"
#define CAESAR_KERNEL_LOG_MARK_SEP ", "
#define CAESAR_KERNEL_LOG_MARK_UNKNOWN_INPUT "?"

#define CAESAR_KERNEL_LOG_GATE(GATE) \
{ \
   if (CAESAR_KERNEL_LOG != NULL) \
      fprintf (CAESAR_KERNEL_LOG, "\001gate function %s (", (GATE)); \
}

#define CAESAR_KERNEL_LOG_OFFER(CAESAR_MODE,CAESAR_TYPE,CAESAR_DATA,CAESAR_PRINT_FUNCTION,CAESAR_RESULT) \
{ \
   if (CAESAR_KERNEL_LOG != NULL) { \
      switch (CAESAR_MODE) { \
      case CAESAR_KERNEL_INPUT: \
         fprintf (CAESAR_KERNEL_LOG, CAESAR_KERNEL_LOG_MARK_INPUT); \
         fprintf (CAESAR_KERNEL_LOG, CAESAR_KERNEL_LOG_MARK_SEP); \
         break; \
      case CAESAR_KERNEL_OUTPUT: \
         fprintf (CAESAR_KERNEL_LOG, CAESAR_KERNEL_LOG_MARK_OUTPUT); \
         fprintf (CAESAR_KERNEL_LOG, CAESAR_KERNEL_LOG_MARK_SEP); \
         break; \
      default: \
         exit (1); \
      } \
      fprintf (CAESAR_KERNEL_LOG, "%s", (CAESAR_TYPE)); \
      fprintf (CAESAR_KERNEL_LOG, CAESAR_KERNEL_LOG_MARK_SEP); \
      if (((CAESAR_RESULT) == 0) && ((CAESAR_MODE) == CAESAR_KERNEL_INPUT)) { \
         fprintf (CAESAR_KERNEL_LOG, CAESAR_KERNEL_LOG_MARK_UNKNOWN_INPUT); \
      } else { \
         CAESAR_PRINT_FUNCTION (CAESAR_KERNEL_LOG, (CAESAR_DATA)); \
      } \
      fprintf (CAESAR_KERNEL_LOG, CAESAR_KERNEL_LOG_MARK_SEP); \
   } \
}

/*
 * note concernant le code ci-dessus : si CAESAR_RESULT est nul, c'est-a-dire
 * si le rendez-vous n'a pas ete accepte, il est possible que certaines des
 * variables correspondant aux receptions (c'est-a-dire aux offres ayant le
 * mode CAESAR_KERNEL_INPUT) n'aient pas ete affectees ; pour eviter tout
 * probleme relatif a l'affichage de variables dont la valeur est indefinie,
 * on affiche la chaine symbolique CAESAR_KERNEL_LOG_MARK_UNKNOWN_INPUT
 */

#define CAESAR_KERNEL_LOG_RESULT(CAESAR_RESULT) \
{ \
   if (CAESAR_KERNEL_LOG != NULL) { \
      fprintf (CAESAR_KERNEL_LOG, CAESAR_KERNEL_LOG_MARK_EOL); \
      fprintf (CAESAR_KERNEL_LOG, ") returns %i\002\n", (CAESAR_RESULT)); \
      fflush (CAESAR_KERNEL_LOG); \
   } \
}

#endif

#endif

/*---------------------------------------------------------------------------*/

#ifdef CAESAR_KERNEL_STATE_INFORMATION

/*
 * Si CAESAR_KERNEL_STATE_INFORMATION est defini, le code C produit par le
 * compilateur Caesar (avec option -exec) contiendra les elements necessaires
 * pour que les fonctions CAESAR_KERNEL_SAVE_STATE() et
 * CAESAR_KERNEL_RESTORE_STATE() soient definies ; la fonction
 * CAESAR_KERNEL_SAVE_STATE() copie l'etat courant vers une zone de memoire
 * et la fonction CAESAR_KERNEL_RESTORE_STATE() effecture l'operation inverse
 * en copiant une zone de memoire vers l'etat courant. La fonction
 * CAESAR_KERNEL_SAVE_STATE() ne peut etre appelee qu'apres un appel a la
 * fonction CAESAR_KERNEL_INIT(). La fonction CAESAR_KERNEL_RESTORE_STATE()
 * ne peut etre appelee qu'apres qu'un appel a la fonction
 * CAESAR_KERNEL_SAVE_STATE() ait eu lieu. Ces deux fonctions ne doivent
 * jamais etre appelees dans les fonctions C associees aux portes visibles de
 * la specification LOTOS
 */

extern void CAESAR_KERNEL_SAVE_STATE CAESAR_ARG_1 (CAESAR_TYPE_STATE);

extern void CAESAR_KERNEL_RESTORE_STATE CAESAR_ARG_1 (CAESAR_TYPE_STATE);

#endif

/*---------------------------------------------------------------------------*/

#ifdef CAESAR_KERNEL_TRANSITION_INFORMATION

/*
 * Si CAESAR_KERNEL_TRANSITION_INFORMATION est defini, le code C produit par
 * le compilateur Caesar (avec option -exec) contiendra les elements
 * necessaires pour que la fonction CAESAR_KERNEL_CURRENT_TRANSITION() soit
 * definie : cette fonction renvoie le numero de la derniere transition
 * franchie lors du plus recent appel a la fonction CAESAR_KERNEL_NEXT().
 * Techniquement, CAESAR_KERNEL_CURRENT_TRANSITION() est implantee par une
 * variable globale CAESAR_CURRENT_TRANSITION qu'il est interdit de modifier
 * directement. Par defaut, CAESAR_KERNEL_TRANSITION_INFORMATION n'est pas
 * defini
 */

#define CAESAR_KERNEL_CURRENT_TRANSITION() (CAESAR_CURRENT_TRANSITION)
extern CAESAR_TYPE_TRANSITION_NUMBER CAESAR_CURRENT_TRANSITION;

#endif

/*---------------------------------------------------------------------------*/

#ifdef CAESAR_KERNEL_NETWORK_INFORMATION

/*
 * Si CAESAR_KERNEL_TRANSITION_INFORMATION est defini, le code C produit par
 * le compilateur Caesar (avec option -exec) contiendra les elements
 * necessaires.
 */

/* nombre total de transitions dans le reseau */

#define CAESAR_KERNEL_NB_TRANSITIONS() \
	CAESAR_KERNEL_HINT_NB_TRANSITIONS
extern CAESAR_TYPE_TRANSITION_NUMBER CAESAR_KERNEL_HINT_NB_TRANSITIONS;

/*
 * fonction : numero de transition -> chaine de caractere contenant la porte
 * de la transition (indefini dans le cas d'une transition epsilon)
 */

#define CAESAR_KERNEL_TRANSITION_GATE(CAESAR_N) (CAESAR_GATE [(CAESAR_N)])
extern CAESAR_TYPE_STRING CAESAR_GATE[];

/* constante exprimant l'absence de transition */

#define CAESAR_KERNEL_NO_TRANSITION ((CAESAR_TYPE_TRANSITION_NUMBER) -1)

/*
 * numeros min/max des transitions epsilon (ou CAESAR_KERNEL_NO_TRANSITION si
 * le reseau ne contient aucune transition epsilon) ; le numero N d'une
 * transition epsilon verifie CAESAR_KERNEL_EPSILON_TRANSITION_MIN_NUMBER()
 * <= N et N <= CAESAR_KERNEL_EPSILON_TRANSITION_MAX_NUMBER()
 */

#define CAESAR_KERNEL_EPSILON_TRANSITION_MIN_NUMBER() \
	CAESAR_KERNEL_HINT_EPSILON_TRANSITION_MIN_NUMBER
extern CAESAR_TYPE_TRANSITION_NUMBER CAESAR_KERNEL_HINT_EPSILON_TRANSITION_MIN_NUMBER;

#define CAESAR_KERNEL_EPSILON_TRANSITION_MAX_NUMBER() \
	CAESAR_KERNEL_HINT_EPSILON_TRANSITION_MAX_NUMBER
extern CAESAR_TYPE_TRANSITION_NUMBER CAESAR_KERNEL_HINT_EPSILON_TRANSITION_MAX_NUMBER;

/*
 * numeros min/max des transitions visibles (ou CAESAR_KERNEL_NO_TRANSITION
 * si le reseau ne contient aucune transition visible) ; le numero N d'une
 * transition visible verifie CAESAR_KERNEL_VISIBLE_TRANSITION_MIN_NUMBER()
 * <= N et N <= CAESAR_KERNEL_VISIBLE_TRANSITION_MAX_NUMBER()
 */

#define CAESAR_KERNEL_VISIBLE_TRANSITION_MIN_NUMBER() \
	CAESAR_KERNEL_HINT_VISIBLE_TRANSITION_MIN_NUMBER
extern CAESAR_TYPE_TRANSITION_NUMBER CAESAR_KERNEL_HINT_VISIBLE_TRANSITION_MIN_NUMBER;

#define CAESAR_KERNEL_VISIBLE_TRANSITION_MAX_NUMBER() \
	CAESAR_KERNEL_HINT_VISIBLE_TRANSITION_MAX_NUMBER
extern CAESAR_TYPE_TRANSITION_NUMBER CAESAR_KERNEL_HINT_VISIBLE_TRANSITION_MAX_NUMBER;

/*
 * numeros min/max des transitions tau (ou CAESAR_KERNEL_NO_TRANSITION si le
 * reseau ne contient aucune transition tau) ; le numero N d'une transition
 * tau verifie CAESAR_KERNEL_TAU_TRANSITION_MIN_NUMBER() <= N et N <=
 * CAESAR_KERNEL_TAU_TRANSITION_MAX_NUMBER()
 */

#define CAESAR_KERNEL_TAU_TRANSITION_MIN_NUMBER() \
	CAESAR_KERNEL_HINT_TAU_TRANSITION_MIN_NUMBER
extern CAESAR_TYPE_TRANSITION_NUMBER CAESAR_KERNEL_HINT_TAU_TRANSITION_MIN_NUMBER;

#define CAESAR_KERNEL_TAU_TRANSITION_MAX_NUMBER() \
	CAESAR_KERNEL_HINT_TAU_TRANSITION_MAX_NUMBER
extern CAESAR_TYPE_TRANSITION_NUMBER CAESAR_KERNEL_HINT_TAU_TRANSITION_MAX_NUMBER;

#endif

/*---------------------------------------------------------------------------*/

#ifdef CAESAR_KERNEL_TAU_CONTROL

/*
 * Si CAESAR_KERNEL_TAU_CONTROL est defini, alors l'utilisateur doit fournir
 * une fonction CAESAR_KERNEL_TAU() (vraisemblablement, basee sur un tirage
 * de nombre aleatoire) qui permet d'introduire une part de non-determinisme
 * dans le franchissement des tau-transitions ; dans le cas contraire,
 * CAESAR_KERNEL_TAU() renvoie systematiquement la valeur "true", ce qui a
 * pour effet de franchir systematiquement la premiere tau-transition tirable
 */

extern CAESAR_TYPE_BOOLEAN CAESAR_KERNEL_TAU CAESAR_ARG_0 ();

#else

#define CAESAR_KERNEL_TAU() CAESAR_TRUE

#endif

/*---------------------------------------------------------------------------*/

#ifndef CAESAR_KERNEL_NO_ASSERT

/*
 * Le code C genere par l'option "-external" de Caesar pour les fonctions
 * portes contient des appels aux macro-definitions suivantes
 */

#ifndef CAESAR_KERNEL_OWN_ASSERT

/*
 * L'utilisateur ne souhaite pas utiliser ses propres macros, donc on utilise
 * les definitions standards ci-dessous. Note: CAESAR_KERNEL_ASSERT_MODE()
 * est une macro auxiliaire qui ne devrait pas etre appelee directement par
 * l'utilisateur
 */

#define CAESAR_KERNEL_ASSERT_MODE(CAESAR_MODE) \
   (((CAESAR_MODE) == CAESAR_KERNEL_EOL) ? "CAESAR_KERNEL_EOL" : \
   (((CAESAR_MODE) == CAESAR_KERNEL_INPUT) ? "CAESAR_KERNEL_INPUT" : \
   (((CAESAR_MODE) == CAESAR_KERNEL_OUTPUT) ? "CAESAR_KERNEL_OUTPUT" : \
   "<unknown mode>")))

#define CAESAR_KERNEL_ASSERT_EOL(CAESAR_MODE) { \
   if ((CAESAR_MODE) != CAESAR_KERNEL_EOL) { \
      fprintf (stdout, "unexpected mode for gate function %s() [%s:%d]\n", \
                       __func__, __FILE__, __LINE__); \
      fprintf (stdout, "%s found where CAESAR_KERNEL_EOL expected\n", \
                       CAESAR_KERNEL_ASSERT_MODE (CAESAR_MODE)); \
      exit (1); \
   } \
}

#define CAESAR_KERNEL_ASSERT_NOT_EOL(CAESAR_MODE) { \
   if ((CAESAR_MODE) == CAESAR_KERNEL_EOL) { \
      fprintf (stdout, "unexpected mode for gate function %s() [%s:%d]\n", \
                       __func__, __FILE__, __LINE__); \
      fprintf (stdout, "CAESAR_KERNERL_EOL found where CAESAR_KERNEL_INPUT or ..._OUTPUT expected\n"); \
      exit (1); \
   } \
}

#define CAESAR_KERNEL_ASSERT_INPUT(CAESAR_MODE) { \
   if ((CAESAR_MODE) != CAESAR_KERNEL_INPUT) { \
      fprintf (stdout, "unexpected mode for gate function %s() [%s:%d]\n", \
                       __func__, __FILE__, __LINE__); \
      fprintf (stdout, "%s found where CAESAR_KERNEL_INPUT expected\n", \
                       CAESAR_KERNEL_ASSERT_MODE (CAESAR_MODE)); \
      exit (1); \
   } \
}

#define CAESAR_KERNEL_ASSERT_OUTPUT(CAESAR_MODE) { \
   if ((CAESAR_MODE) != CAESAR_KERNEL_OUTPUT) { \
      fprintf (stdout, "unexpected mode for gate function %s() [%s:%d]\n", \
                       __func__, __FILE__, __LINE__); \
      fprintf (stdout, "%s found where CAESAR_KERNEL_OUTPUT expected\n", \
                       CAESAR_KERNEL_ASSERT_MODE (CAESAR_MODE)); \
      exit (1); \
   } \
}

#define CAESAR_KERNEL_ASSERT_TYPE(CAESAR_TYPE,CAESAR_EXPECTED_TYPE) { \
   if (strcmp ((CAESAR_TYPE), (CAESAR_EXPECTED_TYPE)) != 0) { \
      fprintf (stdout, "unexpected type for gate function %s() [%s:%d]\n,", \
                       __func__, __FILE__, __LINE__); \
      fprintf (stdout, "%s found where %s expected\n", \
                       (CAESAR_TYPE), (CAESAR_EXPECTED_TYPE)); \
      exit (1); \
   } \
}

#define CAESAR_KERNEL_PROTEST_WRONG_PROFILE() \
{ \
   fprintf (stdout, "unexpected profile for gate function %s() [%s,%d]", \
                    __func__, __FILE__, __LINE__); \
   exit (1); \
}

#endif

#endif

/*****************************************************************************/

#ifdef CAESAR_UNDEFINED
{
#endif

#ifdef __cplusplus
}
#endif

#endif
