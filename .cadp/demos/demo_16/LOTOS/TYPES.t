#define CAESAR_ADT_EXPERT_T 5.6

/*
 * we restrict the set of natural numbers, i.e., the number of chunks in a
 * packet, to the range [0...4]
 */

#define CAESAR_ADT_HASH_ADT_NAT 5

/* 
 * alternative solution:
 *   #undef ADT_ENUM_NEXT_NAT
 *   #define ADT_ENUM_NEXT_NAT(CAESAR_ADT_0) ((CAESAR_ADT_0)++ < 4)
 *   #ifndef lint
 *   #define CAESAR_ADT_BITS_ADT_NAT : 3
 *   #endif
 */

