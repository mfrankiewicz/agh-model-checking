/******************************************************************************
 *                           O P E N / C A E S A R
 *-----------------------------------------------------------------------------
 *   INRIA - Unite de Recherche Rhone-Alpes
 *   655, avenue de l'Europe
 *   38330 Montbonnot Saint Martin
 *   FRANCE
 *-----------------------------------------------------------------------------
 *   Module             :       caesar_area_1.h
 *   Auteur             :       Hubert GARAVEL
 *   Version            :       1.22
 *   Date               :       2008/08/26 14:46:41
 *****************************************************************************/

#ifndef CAESAR_AREA_INTERFACE

#define CAESAR_AREA_INTERFACE

#ifdef __cplusplus
extern "C" {
#endif

#ifdef CAESAR_UNDEFINED
}
#endif

/*****************************************************************************/

#include "caesar_standard.h"

/*---------------------------------------------------------------------------*/

typedef CAESAR_TYPE_NATURAL CAESAR_TYPE_AREA_1;

#define CAESAR_EXPONENT_EMPTY_AREA_1     0
#define CAESAR_EXPONENT_STATE_AREA_1     1
#define CAESAR_EXPONENT_LABEL_AREA_1     2
#define CAESAR_EXPONENT_STRING_AREA_1    3

/*---------------------------------------------------------------------------*/

#define CAESAR_LENGTH_MASK_AREA_1        ((~0UL) >> 4)
/*
 * this constant is not part of the documented API; it is equal to 0x0FFFFFFF
 * on 32-bit machines, and to 0x0FFFFFFFFFFFFFFF on 64-bit machines
 */

#define CAESAR_LENGTH_AREA_1(CAESAR_AREA) \
	(((CAESAR_TYPE_AREA_1) (CAESAR_AREA)) & CAESAR_LENGTH_MASK_AREA_1)

/*---------------------------------------------------------------------------*/

#define CAESAR_EXPONENT_SHIFT_AREA_1     (8 * sizeof (CAESAR_TYPE_AREA_1) - 4)
/*
 * this constant is not part of the documented API; it is equal to 28 on
 * 32-bit machines, and to 60 on 64-bit machines
 */

#define CAESAR_EXPONENT_AREA_1(CAESAR_AREA) \
	(((CAESAR_TYPE_AREA_1) (CAESAR_AREA)) >> CAESAR_EXPONENT_SHIFT_AREA_1)

/*---------------------------------------------------------------------------*/

#define CAESAR_AREA_1(CAESAR_LENGTH,CAESAR_EXPONENT) \
	((CAESAR_TYPE_AREA_1) ((((CAESAR_TYPE_AREA_1) (CAESAR_EXPONENT)) << CAESAR_EXPONENT_SHIFT_AREA_1) | (CAESAR_LENGTH)))

/*---------------------------------------------------------------------------*/

#define CAESAR_EMPTY_AREA_1() (CAESAR_AREA_1 (0, CAESAR_EXPONENT_EMPTY_AREA_1))

#define CAESAR_STATE_AREA_1() (CAESAR_AREA_1 (0, CAESAR_EXPONENT_STATE_AREA_1))

#define CAESAR_LABEL_AREA_1() (CAESAR_AREA_1 (0, CAESAR_EXPONENT_LABEL_AREA_1))

#define CAESAR_STRING_AREA_1() (CAESAR_AREA_1 (0, CAESAR_EXPONENT_STRING_AREA_1))

/*---------------------------------------------------------------------------*/

#define CAESAR_EXPONENT_BYTE_AREA_1      1	/* alignment 1 (= 2^(1-1)) */
#define CAESAR_BYTE_AREA_1(CAESAR_LENGTH) \
	(CAESAR_AREA_1 (CAESAR_LENGTH, CAESAR_EXPONENT_BYTE_AREA_1))

#define CAESAR_EXPONENT_NATURAL_AREA_1 ((sizeof (CAESAR_TYPE_NATURAL) / 4) + 2)
/*
 * this constant is not part of the documented API; it is equal to 3 (i.e.,
 * an alignment of 2^(3-1) = 4) on 32-bit machines, and to 4 (i.e., an
 * alignment of 2^(4-1) = 8) on 64-bit machines; it should be defined as
 * CAESAR_EXPONENT_NATURAL_AREA_1 = log2 (sizeof (CAESAR_TYPE_NATURAL)) + 1;
 * the current definition is optimized but will not extrapolate to 128-bit
 * machines
 */
#define CAESAR_NATURAL_AREA_1(CAESAR_LENGTH) \
	(CAESAR_AREA_1 (CAESAR_LENGTH, CAESAR_EXPONENT_NATURAL_AREA_1))

#define CAESAR_EXPONENT_POINTER_AREA_1 ((sizeof (CAESAR_TYPE_POINTER) / 4) + 2)
/*
 * this constant is not part of the documented API; it is equal to 3 (i.e.,
 * an alignment of 2^(3-1) = 4) on 32-bit machines, and to 4 (i.e., an
 * alignment of 2^(4-1) = 8) on 64-bit machines; it should be defined as
 * CAESAR_EXPONENT_POINTER_AREA_1 = log2 (sizeof (CAESAR_TYPE_POINTER)) + 1;
 * the current definition is optimized but will not extrapolate to 128-bit
 * machines
 */
#define CAESAR_POINTER_AREA_1(CAESAR_LENGTH) \
	(CAESAR_AREA_1 (CAESAR_LENGTH, CAESAR_EXPONENT_POINTER_AREA_1))

/*---------------------------------------------------------------------------*/

extern CAESAR_TYPE_NATURAL CAESAR_SIZE_AREA_1 CAESAR_ARG_1 (CAESAR_TYPE_AREA_1);

extern CAESAR_TYPE_NATURAL CAESAR_HASH_SIZE_AREA_1 CAESAR_ARG_1 (CAESAR_TYPE_AREA_1);

extern CAESAR_TYPE_NATURAL CAESAR_ALIGNMENT_AREA_1 CAESAR_ARG_1 (CAESAR_TYPE_AREA_1);

/*---------------------------------------------------------------------------*/

#define CAESAR_COPY_AREA_1(CAESAR_P1,CAESAR_P2,CAESAR_SIZE) \
	(memcpy ((CAESAR_P1), (CAESAR_P2), (CAESAR_SIZE)))

/*---------------------------------------------------------------------------*/

extern CAESAR_TYPE_BOOLEAN CAESAR_COMPARE_EMPTY_AREA_1 CAESAR_ARG_2 (CAESAR_TYPE_POINTER, CAESAR_TYPE_POINTER);

extern CAESAR_TYPE_BOOLEAN CAESAR_COMPARE_STRING_AREA_1 CAESAR_ARG_2 (CAESAR_TYPE_STRING *, CAESAR_TYPE_STRING *);

extern void CAESAR_USE_COMPARE_FUNCTION_AREA_1 CAESAR_ARG_2 (CAESAR_TYPE_AREA_1, CAESAR_TYPE_COMPARE_FUNCTION *);

#define CAESAR_COMPARE_AREA_1(CAESAR_COMPARE_FUNCTION,CAESAR_P1,CAESAR_P2,CAESAR_SIZE) \
	(((CAESAR_COMPARE_FUNCTION) != NULL) \
	? (*(CAESAR_COMPARE_FUNCTION)) ((CAESAR_P1), (CAESAR_P2)) \
	: (memcmp ((CAESAR_P1), (CAESAR_P2), (CAESAR_SIZE)) \
		? CAESAR_FALSE \
		: CAESAR_TRUE))

/*---------------------------------------------------------------------------*/

extern CAESAR_TYPE_NATURAL CAESAR_HASH_EMPTY_AREA_1 CAESAR_ARG_2 (CAESAR_TYPE_POINTER, CAESAR_TYPE_NATURAL);

extern CAESAR_TYPE_NATURAL CAESAR_HASH_STRING_AREA_1 CAESAR_ARG_2 (CAESAR_TYPE_POINTER, CAESAR_TYPE_NATURAL);

extern void CAESAR_USE_HASH_FUNCTION_AREA_1 CAESAR_ARG_2 (CAESAR_TYPE_AREA_1, CAESAR_TYPE_HASH_FUNCTION *);

#define CAESAR_HASH_AREA_1(CAESAR_HASH_FUNCTION,CAESAR_P,CAESAR_HASH_SIZE,CAESAR_MODULUS) \
	(((CAESAR_HASH_FUNCTION) != NULL) \
	? (*(CAESAR_HASH_FUNCTION)) ((CAESAR_P), (CAESAR_MODULUS)) \
	: (CAESAR_0_HASH ((CAESAR_P), (CAESAR_HASH_SIZE), (CAESAR_MODULUS))))

/*---------------------------------------------------------------------------*/

extern CAESAR_TYPE_STRING CAESAR_CONVERT_EMPTY_AREA_1 CAESAR_ARG_1 (CAESAR_TYPE_POINTER);

extern CAESAR_TYPE_STRING CAESAR_CONVERT_STRING_AREA_1 CAESAR_ARG_1 (CAESAR_TYPE_STRING *);

extern CAESAR_TYPE_STRING CAESAR_CONVERT_BINARY_AREA_1 CAESAR_ARG_2 (CAESAR_TYPE_POINTER, CAESAR_TYPE_NATURAL);

extern void CAESAR_USE_CONVERT_FUNCTION_AREA_1 CAESAR_ARG_2 (CAESAR_TYPE_AREA_1, CAESAR_TYPE_CONVERT_FUNCTION *);

#define CAESAR_CONVERT_AREA_1(CAESAR_CONVERT_FUNCTION,CAESAR_P,CAESAR_SIZE) \
	(((CAESAR_CONVERT_FUNCTION) != NULL) \
	? (*(CAESAR_CONVERT_FUNCTION)) ((CAESAR_P)) \
	: (CAESAR_CONVERT_BINARY_AREA_1 ((CAESAR_P), (CAESAR_SIZE))))

/*---------------------------------------------------------------------------*/

extern void CAESAR_PRINT_EMPTY_AREA_1 CAESAR_ARG_2 (CAESAR_TYPE_FILE, CAESAR_TYPE_POINTER);

extern void CAESAR_PRINT_STRING_AREA_1 CAESAR_ARG_2 (CAESAR_TYPE_FILE, CAESAR_TYPE_STRING *);

extern void CAESAR_PRINT_BINARY_AREA_1 CAESAR_ARG_3 (CAESAR_TYPE_FILE, CAESAR_TYPE_POINTER, CAESAR_TYPE_NATURAL);

extern void CAESAR_USE_PRINT_FUNCTION_AREA_1 CAESAR_ARG_2 (CAESAR_TYPE_AREA_1, CAESAR_TYPE_PRINT_FUNCTION *);

#define CAESAR_PRINT_AREA_1(CAESAR_PRINT_FUNCTION,CAESAR_FILE,CAESAR_P,CAESAR_SIZE) \
	(((CAESAR_PRINT_FUNCTION) != NULL) \
	? (*(CAESAR_PRINT_FUNCTION)) ((CAESAR_FILE), (CAESAR_P)) \
	: (CAESAR_PRINT_BINARY_AREA_1 ((CAESAR_FILE), (CAESAR_P), (CAESAR_SIZE))))

/*****************************************************************************/

#ifdef CAESAR_UNDEFINED
{
#endif

#ifdef __cplusplus
}
#endif

#endif
