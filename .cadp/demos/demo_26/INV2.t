#define CAESAR_ADT_EXPERT_T 5.6

/* -----------------------------------------------------------------------------
        The iteration over natural numbers is limited to n = 0, 1, 2
   -----------------------------------------------------------------------------
 */

#define ADT_ENUM_NEXT_NAT(CAESAR_ADT_0) ((CAESAR_ADT_0)++ < 2)

/*
 * here, one should not use the alternative approach
 *   #define CAESAR_ADT_HASH_ADT_NAT 3
 * because this would automatically generate
 *   #define CAESAR_ADT_BITS_ADT_NAT : 2
 * leading to truncation in arithmetic operations on sort NAT
 */
