#define CAESAR_ADT_EXPERT_T 5.6

/*
 * -----------------------------------------------------------------------------
 *      reducing the domains of sorts HEADER, DATA, ACK to one value
 * -----------------------------------------------------------------------------
 */

#define ITR_FIRST_HEADER() CAESAR_ADT_FUNC_C1 ()
#define ITR_NEXT_HEADER(CAESAR_ADT_0) (CAESAR_ADT_USE (CAESAR_ADT_0), 0)

#define ITR_FIRST_DATA() CAESAR_ADT_FUNC_D1 ()
#define ITR_NEXT_DATA(CAESAR_ADT_0) (CAESAR_ADT_USE (CAESAR_ADT_0), 0)

#define ITR_FIRST_ACK() CAESAR_ADT_FUNC_A1 ()
#define ITR_NEXT_ACK(CAESAR_ADT_0) (CAESAR_ADT_USE (CAESAR_ADT_0), 0)

/*
 * -----------------------------------------------------------------------------
 *      reducing the domain of sort NAT to the range [0...LIMIT_ITR_NAT-1]
 * -----------------------------------------------------------------------------
 */

#define CAESAR_ADT_HASH_ADT_NAT LIMIT_ITR_NAT

/*
 * alternative solution
 *   #define ADT_ENUM_NEXT_NAT(CAESAR_ADT_0) ((CAESAR_ADT_0)++ < (LIMIT_ITR_NAT-1))
 */
