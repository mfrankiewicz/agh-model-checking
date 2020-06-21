/******************************************************************************
 *   			            C A D P
 *-----------------------------------------------------------------------------
 *   INRIA - Centre de Recherche de Grenoble Rhone-Alpes
 *   655, avenue de l'Europe
 *   38330 Montbonnot Saint Martin
 *   FRANCE
 *-----------------------------------------------------------------------------
 *   Module		:	X_STRING.h
 *   Auteur		:	Hubert GARAVEL
 *   Version		:	1.12
 *   Date		: 	2018/01/03 11:06:27
 *****************************************************************************/

#ifndef ADT_X_STRING

#define ADT_X_STRING

/*---------------------------------------------------------------------------*/

#include <ctype.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <signal.h>		/* for raise() */

/** This module also requires the importation of the basic data types,
 *  either generated automatically by CAESAR.ADT, or implemented by
 *  hand, e.g.
 *     #include <X_BOOLEAN.h>
 *     #include <X_NATURAL.h>
 *     #include <X_INTEGER.h>
 *     #include <X_CHARACTER.h>
 *     #include <X_REAL.h>
 **/

#ifdef MCL_DATA_EXTENSION
#include "caesar_standard.h"	/* for CAESAR_TYPE_STRING */
#endif

/*---------------------------------------------------------------------------*/

#if !defined (CAESAR_ADT_HASH_ADT_STRING) || \
    (CAESAR_ADT_HASH_ADT_STRING == 0) || \
    (CAESAR_ADT_HASH_ADT_STRING == 1)

/* native implementation of strings as pointers to char */

#define CAESAR_ADT_NATIVE_ADT_STRING

#else

/* canonical implementation of strings as index entries in a hash table */

#endif

/*---------------------------------------------------------------------------*/

#include "adt_string.h"

/*---------------------------------------------------------------------------*/

#if defined (CAESAR_ADT_NATIVE_ADT_STRING)

/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */

#define CAESAR_ADT_CONTENTS_STORE_ADT_STRING(X) (X)
#define CAESAR_ADT_CONTENTS_RETRIEVE_ADT_STRING(X,N) (X)

/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */

/*
 * Contrary to ADT_CMP_STRING() (comparison of states) and ADT_PRINT_STRING()
 * (printing of states), the following functions are not supposed to be
 * called with string pointers having the NULL value
 */

#define ADT_EQ_STRING(X1,X2) ((ADT_BOOL) ((strcmp ((X1), (X2)) == 0) ? ADT_TRUE() : ADT_FALSE()))

#define ADT_NE_STRING(X1,X2) ((ADT_BOOL) ((strcmp ((X1), (X2)) != 0) ? ADT_TRUE() : ADT_FALSE()))

#define ADT_LT_STRING(X1,X2) ((ADT_BOOL) ((strcmp ((X1), (X2)) < 0) ? ADT_TRUE() : ADT_FALSE()))

#define ADT_LE_STRING(X1,X2) ((ADT_BOOL) ((strcmp ((X1), (X2)) <= 0) ? ADT_TRUE() : ADT_FALSE()))

#define ADT_GT_STRING(X1,X2) ((ADT_BOOL) ((strcmp ((X1), (X2)) > 0) ? ADT_TRUE() : ADT_FALSE()))

#define ADT_GE_STRING(X1,X2) ((ADT_BOOL) ((strcmp ((X1), (X2)) >= 0) ? ADT_TRUE() : ADT_FALSE()))

/*---------------------------------------------------------------------------*/

#else

/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */

#ifndef CAESAR_ADT_COLLISIONS_ADT_STRING
#ifdef CAESAR_ADT_COLLISIONS
#define CAESAR_ADT_COLLISIONS_ADT_STRING CAESAR_ADT_COLLISIONS
#else
#define CAESAR_ADT_COLLISIONS_ADT_STRING 1
#endif
#endif

/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */

#ifndef CAESAR_ADT_FORMAT_ADT_STRING
#ifdef CAESAR_ADT_FORMAT
#define CAESAR_ADT_FORMAT_ADT_STRING CAESAR_ADT_FORMAT
#endif
#endif

/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */

/* declaration of the hash table for string values */

#ifndef CAESAR_ADT_INTERFACE
static CAESAR_TYPE_TABLE_1 CAESAR_ADT_TABLE_ADT_STRING = NULL;
#endif

/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */

#ifndef CAESAR_ADT_TABLE_ALLOCATE_ERROR
#define CAESAR_ADT_TABLE_ALLOCATE_ERROR(CAESAR_ADT_LOTOS_SORT) \
	fprintf (stdout, "#300 error in file ``.h'' :\n     failure when creating a data table\n     for the values of sort %s\n", CAESAR_ADT_LOTOS_SORT)
#endif

/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */

#ifndef CAESAR_ADT_TABLE_OVERFLOW_ERROR
#define CAESAR_ADT_TABLE_OVERFLOW_ERROR(CAESAR_ADT_LOTOS_SORT,CAESAR_ADT_C_TYPE,CAESAR_ADT_CARDINAL) \
	fprintf (stdout, "#301 error in file ``.h'' :\n     overflow of a data table\n     too many values for sort %s\n     the maximum number of values was set to %lu\n     enlarge the constant CAESAR_ADT_HASH_%s\n", CAESAR_ADT_LOTOS_SORT, (unsigned long) ADT_CARDINAL_ADT_STRING, CAESAR_ADT_C_TYPE)
#endif

/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */

#ifndef CAESAR_ADT_TABLE_RETRIEVE_ERROR
#define CAESAR_ADT_TABLE_RETRIEVE_ERROR(CAESAR_ADT_C_TYPE) \
	fprintf (stdout, "#302 error in file ``.h'' :\n     search for invalid index in a data table\n     in function CAESAR_ADT_CONTENTS_RETRIEVE_%s [%s:%d]\n", CAESAR_ADT_C_TYPE, __FILE__, __LINE__)
#endif

/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */

#ifdef CAESAR_ADT_INTERFACE

extern void CAESAR_ADT_CONTENTS_PRT_ADT_STRING ();

#else

void CAESAR_ADT_CONTENTS_PRT_ADT_STRING (ADT_FILE, ADT_X)
CAESAR_TYPE_FILE ADT_FILE;
CAESAR_TYPE_STRING *ADT_X;
{
     ADT_PRINT_CORE_STRING (ADT_FILE, *ADT_X);
}

#endif

/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */

#ifdef CAESAR_ADT_FORMAT_ADT_STRING

#define CAESAR_ADT_SHOW_ADT_STRING(F) \
	if (1) { \
	     fprintf (stdout, "\ndata table information for sort STRING [X_STRING:2]:\n"); \
	     CAESAR_PRINT_TABLE_1 ((F), CAESAR_ADT_TABLE_ADT_STRING); \
	} else ((void) 0)
#endif

/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */

#ifdef CAESAR_ADT_INTERFACE

extern void ADT_OVERFLOW_ADT_STRING ();

#else

void ADT_OVERFLOW_ADT_STRING (CAESAR_T)
CAESAR_TYPE_TABLE_1 CAESAR_T;
{
     (void) CAESAR_T;

     CAESAR_ADT_TABLE_OVERFLOW_ERROR ("STRING [X_STRING:2]", "ADT_STRING", ADT_CARDINAL_ADT_STRING);
#ifdef CAESAR_ADT_SHOW_ADT_STRING
     CAESAR_ADT_SHOW_ADT_STRING (stdout);
#endif
     fflush (stdout);
     raise (15);
}

#endif

/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */

#ifdef CAESAR_ADT_FORMAT_ADT_STRING

#define CAESAR_ADT_SHAPE_ADT_STRING() CAESAR_FORMAT_TABLE_1 (CAESAR_ADT_TABLE_ADT_STRING, CAESAR_ADT_FORMAT_ADT_STRING)

#else

#define CAESAR_ADT_SHAPE_ADT_STRING()	/* nothing */

#endif

/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */

#define CAESAR_ADT_CREATE_ADT_STRING() \
	if (1) { \
	CAESAR_CREATE_TABLE_1 (&CAESAR_ADT_TABLE_ADT_STRING, \
	   CAESAR_STRING_AREA_1 (), \
	   CAESAR_EMPTY_AREA_1 (), \
	   (unsigned long) ADT_CARDINAL_ADT_STRING, \
	   (unsigned long) ((unsigned long) ADT_CARDINAL_ADT_STRING / (unsigned long) CAESAR_ADT_COLLISIONS_ADT_STRING), \
	   CAESAR_TRUE, \
	   (CAESAR_TYPE_COMPARE_FUNCTION) NULL, \
	   (CAESAR_TYPE_HASH_FUNCTION) NULL, \
	   (CAESAR_TYPE_PRINT_FUNCTION) CAESAR_ADT_CONTENTS_PRT_ADT_STRING, \
	   (CAESAR_TYPE_OVERFLOW_FUNCTION_TABLE_1) ADT_OVERFLOW_ADT_STRING); \
	if (CAESAR_ADT_TABLE_ADT_STRING == NULL) { \
	     CAESAR_ADT_TABLE_ALLOCATE_ERROR ("STRING [X_STRING:2]"); \
	     fflush (stdout); \
	     raise (15); \
	} \
	CAESAR_ADT_SHAPE_ADT_STRING (); \
	} else ((void) 0)

/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */

#define CAESAR_ADT_DELETE_ADT_STRING() \
	CAESAR_DELETE_TABLE_1 (&CAESAR_ADT_TABLE_ADT_STRING)

/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */

#ifdef CAESAR_ADT_INTERFACE

extern ADT_STRING CAESAR_ADT_CONTENTS_STORE_ADT_STRING ();

#else

static ADT_STRING CAESAR_ADT_CONTENTS_STORE_ADT_STRING (ADT_X)
CAESAR_TYPE_STRING ADT_X;
{
     CAESAR_TYPE_POINTER ADT_X_POINTER;
     CAESAR_TYPE_INDEX_TABLE_1 ADT_INDEX;

     *((CAESAR_TYPE_STRING *) CAESAR_PUT_BASE_TABLE_1 (CAESAR_ADT_TABLE_ADT_STRING)) = ADT_X;
     (void) CAESAR_SEARCH_AND_PUT_TABLE_1 (CAESAR_ADT_TABLE_ADT_STRING, &ADT_INDEX, &ADT_X_POINTER);
     return ((ADT_STRING) ADT_INDEX);
}

#endif

/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */

#ifdef CAESAR_ADT_INTERFACE

extern CAESAR_TYPE_STRING CAESAR_ADT_CONTENTS_RETRIEVE_ADT_STRING ();

#else

CAESAR_TYPE_STRING CAESAR_ADT_CONTENTS_RETRIEVE_ADT_STRING (ADT_X, ADT_TRANSMIT)
ADT_STRING ADT_X;
int  ADT_TRANSMIT;
{
     CAESAR_TYPE_POINTER ADT_RESULT;

     CAESAR_RETRIEVE_I_B_TABLE_1 (CAESAR_ADT_TABLE_ADT_STRING, (CAESAR_TYPE_INDEX_TABLE_1) ADT_X, &ADT_RESULT);
     if (ADT_RESULT != NULL)
	  return (*((CAESAR_TYPE_STRING *) ADT_RESULT));
     else if (ADT_TRANSMIT)
	  return (NULL);
     else {
	  CAESAR_ADT_TABLE_RETRIEVE_ERROR ("ADT_STRING");
	  fflush (stdout);
	  raise (15);
	  /* NOTREACHED */
#ifdef __GNUC__
	  return 0;		/* to keep "gcc -Wall" silent */
#endif
     }
}

#endif

/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */

#define ADT_EQ_STRING(X1,X2) ((ADT_BOOL) (((X1) == (X2)) ? ADT_TRUE() : ADT_FALSE()))

#define ADT_NE_STRING(X1,X2) ((ADT_BOOL) (((X1) != (X2)) ? ADT_TRUE() : ADT_FALSE()))

#define ADT_LT_STRING(X1,X2) ((ADT_BOOL) ((strcmp (CAESAR_ADT_CONTENTS_RETRIEVE_ADT_STRING ((X1), 0), CAESAR_ADT_CONTENTS_RETRIEVE_ADT_STRING ((X2), 0)) < 0) ? ADT_TRUE() : ADT_FALSE()))

#define ADT_LE_STRING(X1,X2) ((ADT_BOOL) ((strcmp (CAESAR_ADT_CONTENTS_RETRIEVE_ADT_STRING ((X1), 0), CAESAR_ADT_CONTENTS_RETRIEVE_ADT_STRING ((X2), 0)) <= 0) ? ADT_TRUE() : ADT_FALSE()))

#define ADT_GT_STRING(X1,X2) ((ADT_BOOL) ((strcmp (CAESAR_ADT_CONTENTS_RETRIEVE_ADT_STRING ((X1), 0), CAESAR_ADT_CONTENTS_RETRIEVE_ADT_STRING ((X2), 0)) > 0) ? ADT_TRUE() : ADT_FALSE()))

#define ADT_GE_STRING(X1,X2) ((ADT_BOOL) ((strcmp (CAESAR_ADT_CONTENTS_RETRIEVE_ADT_STRING ((X1), 0), CAESAR_ADT_CONTENTS_RETRIEVE_ADT_STRING ((X2), 0)) >= 0) ? ADT_TRUE() : ADT_FALSE()))

/*---------------------------------------------------------------------------*/

#endif

/*---------------------------------------------------------------------------*/

#ifdef MCL_DATA_EXTENSION

#include <math.h>		/* for log10() */

/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */

/*
 * in all the string functions below, characters and sub-string indexes start
 * from 1 (and not from 0 as in the C language)
 */

/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */

#ifndef ADT_ALLOC_STRING

#ifndef CAESAR_ADT_GARBAGE_COLLECTION
#ifndef GC_malloc
#define GC_malloc(X0) malloc(X0)
#endif
#else
extern char *GC_malloc ();
#endif

#define ADT_ALLOC_STRING(X,SIZE,C_FUNCTION) \
   if (((X) = (CAESAR_TYPE_STRING) GC_malloc ((size_t) (SIZE))) == NULL) { fprintf (stdout, "memory shortage in function %s [%s:%d]\n", C_FUNCTION, __FILE__, __LINE__); raise (15); } else ((void) 0)

#endif

/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */

#if defined (ADT_STRING_INTERFACE_EXPORT)
#define ADT_STRING_STATIC	/* nothing */
#elif defined (__GNUC__)
#define ADT_STRING_STATIC static __attribute__((unused))
#else
#define ADT_STRING_STATIC static
#endif

/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */

#if defined (ADT_STRING_INTERFACE_ONLY)
ADT_STRING ADT_CONCAT_STRING (ADT_STRING ADT_X1, ADT_STRING ADT_X2);
#else
ADT_STRING_STATIC ADT_STRING ADT_CONCAT_STRING (ADT_STRING ADT_X1, ADT_STRING ADT_X2)
{
     CAESAR_TYPE_STRING ADT_X1_CONTENTS, ADT_X2_CONTENTS;
     CAESAR_TYPE_STRING ADT_RESULT;

     ADT_X1_CONTENTS = CAESAR_ADT_CONTENTS_RETRIEVE_ADT_STRING (ADT_X1, 0);
     ADT_X2_CONTENTS = CAESAR_ADT_CONTENTS_RETRIEVE_ADT_STRING (ADT_X2, 0);
     ADT_ALLOC_STRING (ADT_RESULT, strlen (ADT_X1_CONTENTS) + strlen (ADT_X2_CONTENTS) + 1, "ADT_CONCAT_STRING");
     strcpy (ADT_RESULT, ADT_X1_CONTENTS);
     strcat (ADT_RESULT, ADT_X2_CONTENTS);
     return (CAESAR_ADT_CONTENTS_STORE_ADT_STRING (ADT_RESULT));
}
#endif

/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */

#define ADT_LENGTH_STRING(X) (strlen (CAESAR_ADT_CONTENTS_RETRIEVE_ADT_STRING ((X), 0)))

/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */

#if defined (ADT_STRING_INTERFACE_ONLY)
ADT_BOOL ADT_ISEMPTY_STRING (ADT_STRING ADT_X1);
#else
ADT_STRING_STATIC ADT_BOOL ADT_ISEMPTY_STRING (ADT_STRING ADT_X1)
{
     return (ADT_BOOL) ((ADT_LENGTH_STRING (ADT_X1) == 0) ? ADT_TRUE () : ADT_FALSE ());
}
#endif

/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */

#if defined (ADT_STRING_INTERFACE_ONLY)
ADT_STRING ADT_PREFIX_STRING (ADT_STRING ADT_X1, ADT_NAT ADT_X2);
#else
ADT_STRING_STATIC ADT_STRING ADT_PREFIX_STRING (ADT_STRING ADT_X1, ADT_NAT ADT_X2)
/* ADT_X2: length of prefix */
{
     CAESAR_TYPE_STRING ADT_X1_CONTENTS;
     CAESAR_TYPE_STRING ADT_RESULT;
     size_t ADT_LENGTH;

     ADT_X1_CONTENTS = CAESAR_ADT_CONTENTS_RETRIEVE_ADT_STRING (ADT_X1, 0);
     ADT_LENGTH = strlen (ADT_X1_CONTENTS);
     if (((size_t) ADT_X2) > ADT_LENGTH)
	  ADT_X2 = (ADT_NAT) ADT_LENGTH;
     ADT_ALLOC_STRING (ADT_RESULT, ADT_X2 + 1, "ADT_PREFIX_STRING");
     strncpy (ADT_RESULT, ADT_X1_CONTENTS, ADT_X2);
     ADT_RESULT[ADT_X2] = '\0';
     return (CAESAR_ADT_CONTENTS_STORE_ADT_STRING (ADT_RESULT));
}
#endif

/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */

#if defined (ADT_STRING_INTERFACE_ONLY)
ADT_STRING ADT_SUFFIX_STRING (ADT_STRING ADT_X1, ADT_NAT ADT_X2);
#else
ADT_STRING_STATIC ADT_STRING ADT_SUFFIX_STRING (ADT_STRING ADT_X1, ADT_NAT ADT_X2)
/* ADT_X2: length of suffix */
{
     CAESAR_TYPE_STRING ADT_X1_CONTENTS;
     CAESAR_TYPE_STRING ADT_RESULT;
     size_t ADT_LENGTH;

     ADT_X1_CONTENTS = CAESAR_ADT_CONTENTS_RETRIEVE_ADT_STRING (ADT_X1, 0);
     ADT_LENGTH = strlen (ADT_X1_CONTENTS);
     if (((size_t) ADT_X2) > ADT_LENGTH)
	  ADT_X2 = (ADT_NAT) ADT_LENGTH;
     ADT_ALLOC_STRING (ADT_RESULT, ADT_X2 + 1, "ADT_SUFFIX_STRING");
     strcpy (ADT_RESULT, ADT_X1_CONTENTS + ADT_LENGTH - ADT_X2);
     return (CAESAR_ADT_CONTENTS_STORE_ADT_STRING (ADT_RESULT));
}
#endif

/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */

#if defined (ADT_STRING_INTERFACE_ONLY)
ADT_STRING ADT_SUBSTR_STRING (ADT_STRING ADT_X1, ADT_NAT ADT_X2, ADT_NAT ADT_X3);
#else
ADT_STRING_STATIC ADT_STRING ADT_SUBSTR_STRING (ADT_STRING ADT_X1, ADT_NAT ADT_X2, ADT_NAT ADT_X3)
/* ADT_X2: left index of character */
/* ADT_X3: sub-string length */
{
     CAESAR_TYPE_STRING ADT_X1_CONTENTS;
     CAESAR_TYPE_STRING ADT_RESULT;
     size_t ADT_LENGTH;

     ADT_X1_CONTENTS = CAESAR_ADT_CONTENTS_RETRIEVE_ADT_STRING (ADT_X1, 0);
     ADT_LENGTH = strlen (ADT_X1_CONTENTS);
     if ((ADT_X2 == 0) || (((size_t) ADT_X2) > ADT_LENGTH)) {
	  ADT_ALLOC_STRING (ADT_RESULT, 1, "ADT_SUBSTR_STRING");
	  ADT_RESULT[0] = '\0';
	  return (CAESAR_ADT_CONTENTS_STORE_ADT_STRING (ADT_RESULT));
     }
     ADT_X2 = ADT_X2 - 1;
     if (((size_t) ADT_X2) + ((size_t) ADT_X3) > ADT_LENGTH) {
	  ADT_X3 = (ADT_NAT) (ADT_LENGTH - ADT_X2);
     }
     ADT_ALLOC_STRING (ADT_RESULT, ADT_X3 + 1, "ADT_SUBSTR_STRING");
     strncpy (ADT_RESULT, ADT_X1_CONTENTS + ADT_X2, ADT_X3);
     ADT_RESULT[ADT_X3] = '\0';
     return (CAESAR_ADT_CONTENTS_STORE_ADT_STRING (ADT_RESULT));
}
#endif

/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */

#if defined (ADT_STRING_INTERFACE_ONLY)
ADT_CHAR ADT_NTH_STRING (ADT_STRING ADT_X1, ADT_NAT ADT_X2);
#else
ADT_STRING_STATIC ADT_CHAR ADT_NTH_STRING (ADT_STRING ADT_X1, ADT_NAT ADT_X2)
/* ADT_X2: index of character */
{
     CAESAR_TYPE_STRING ADT_X1_CONTENTS;
     size_t ADT_LENGTH;

     ADT_X1_CONTENTS = CAESAR_ADT_CONTENTS_RETRIEVE_ADT_STRING (ADT_X1, 0);
     ADT_LENGTH = strlen (ADT_X1_CONTENTS);
     if ((ADT_X2 == 0) || (((size_t) ADT_X2) > ADT_LENGTH))
	  return '\0';
     else
	  return (ADT_X1_CONTENTS[ADT_X2 - 1]);
}
#endif

/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */

#if defined (ADT_STRING_INTERFACE_ONLY)
ADT_NAT ADT_INDEX_STRING (ADT_STRING ADT_X1, ADT_STRING ADT_X2);
#else
ADT_STRING_STATIC ADT_NAT ADT_INDEX_STRING (ADT_STRING ADT_X1, ADT_STRING ADT_X2)
{
     CAESAR_TYPE_STRING ADT_X1_CONTENTS, ADT_X2_CONTENTS;
     CAESAR_TYPE_STRING ADT_LOCATION;

     ADT_X1_CONTENTS = CAESAR_ADT_CONTENTS_RETRIEVE_ADT_STRING (ADT_X1, 0);
     ADT_X2_CONTENTS = CAESAR_ADT_CONTENTS_RETRIEVE_ADT_STRING (ADT_X2, 0);
     ADT_LOCATION = strstr (ADT_X1_CONTENTS, ADT_X2_CONTENTS);
     if (ADT_LOCATION == NULL) {
	  /* sub-string not found */
	  return (ADT_NAT) 0;
     } else
	  /* LINTED (warning: possible ptrdiff_t overflow) */
	  return (ADT_NAT) (ADT_LOCATION - ADT_X1_CONTENTS) + 1;
}
#endif

/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */

#if defined (ADT_STRING_INTERFACE_ONLY)
ADT_NAT ADT_RINDEX_STRING (ADT_STRING ADT_X1, ADT_STRING ADT_X2);
#else
ADT_STRING_STATIC ADT_NAT ADT_RINDEX_STRING (ADT_STRING ADT_X1, ADT_STRING ADT_X2)
{
     CAESAR_TYPE_STRING ADT_X1_CONTENTS, ADT_X2_CONTENTS;
     ADT_NAT ADT_RESULT;
     CAESAR_TYPE_STRING ADT_NEW_X1_CONTENTS;
     CAESAR_TYPE_STRING ADT_LOCATION;

     ADT_X1_CONTENTS = CAESAR_ADT_CONTENTS_RETRIEVE_ADT_STRING (ADT_X1, 0);
     ADT_X2_CONTENTS = CAESAR_ADT_CONTENTS_RETRIEVE_ADT_STRING (ADT_X2, 0);

     /* just an optimization */
     if (strlen (ADT_X2_CONTENTS) == 0)
	  return (ADT_NAT) strlen (ADT_X1_CONTENTS);

     ADT_RESULT = 0;
     ADT_NEW_X1_CONTENTS = ADT_X1_CONTENTS;
     for (;;) {
	  /* assert ADT_NEW_X1_CONTENTS is within the string ADT_X1_CONTENTS */
	  ADT_LOCATION = strstr (ADT_NEW_X1_CONTENTS, ADT_X2_CONTENTS);
	  if (ADT_LOCATION == NULL) {
	       /* sub-string not found */
	       break;
	  }
	  /* LINTED (warning: possible ptrdiff_t overflow) */
	  ADT_RESULT = (ADT_NAT) (ADT_LOCATION - ADT_X1_CONTENTS) + 1;
	  ADT_NEW_X1_CONTENTS = ADT_LOCATION + 1;
     }
     return (ADT_RESULT);
}
#endif

/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */

#if defined (ADT_STRING_INTERFACE_ONLY)
ADT_STRING ADT_TO_STRING_NAT (ADT_NAT ADT_X);
#else
ADT_STRING_STATIC ADT_STRING ADT_TO_STRING_NAT (ADT_NAT ADT_X)
{
     CAESAR_TYPE_STRING ADT_RESULT;

     ADT_ALLOC_STRING (ADT_RESULT, log10 ((double) ADT_X + 1) + 3, "ADT_TO_STRING_NAT");
     sprintf (ADT_RESULT, "%lu", (unsigned long) ADT_X);
     return (CAESAR_ADT_CONTENTS_STORE_ADT_STRING (ADT_RESULT));
}
#endif

/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */

#if defined (ADT_STRING_INTERFACE_ONLY)
ADT_STRING ADT_TO_STRING_INT (ADT_INT ADT_X);
#else
ADT_STRING_STATIC ADT_STRING ADT_TO_STRING_INT (ADT_INT ADT_X)
{
     CAESAR_TYPE_STRING ADT_RESULT;

     ADT_ALLOC_STRING (ADT_RESULT, log10 ((double) labs ((long) ADT_X) + 1) + 4, "ADT_TO_STRING_INT");
     sprintf (ADT_RESULT, "%ld", (long) ADT_X);
     return (CAESAR_ADT_CONTENTS_STORE_ADT_STRING (ADT_RESULT));
}
#endif

/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */

#if defined (ADT_STRING_INTERFACE_ONLY)
ADT_STRING ADT_TO_STRING_CHAR (ADT_CHAR ADT_X);
#else
ADT_STRING_STATIC ADT_STRING ADT_TO_STRING_CHAR (ADT_CHAR ADT_X)
{
     CAESAR_TYPE_STRING ADT_RESULT;

     ADT_ALLOC_STRING (ADT_RESULT, 2, "ADT_TO_STRING_CHAR");
     sprintf (ADT_RESULT, "%c", ADT_X);
     return (CAESAR_ADT_CONTENTS_STORE_ADT_STRING (ADT_RESULT));
}
#endif

/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */

#if defined (ADT_STRING_INTERFACE_ONLY)
ADT_STRING ADT_TO_STRING_REAL (ADT_REAL ADT_X);
#else
ADT_STRING_STATIC ADT_STRING ADT_TO_STRING_REAL (ADT_REAL ADT_X)
{
     CAESAR_TYPE_STRING ADT_RESULT;

     ADT_ALLOC_STRING (ADT_RESULT, 16, "ADT_TO_STRING_REAL");
     sprintf (ADT_RESULT, "%g", ADT_X);
     return (CAESAR_ADT_CONTENTS_STORE_ADT_STRING (ADT_RESULT));
}
#endif

/*---------------------------------------------------------------------------*/

#endif

/*---------------------------------------------------------------------------*/

#endif
