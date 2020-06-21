/******************************************************************************
 *                                B C G
 *-----------------------------------------------------------------------------
 *   INRIA - Unite de Recherche Rhone-Alpes
 *   655, avenue de l'Europe
 *   38330 Montbonnot Saint Martin
 *   FRANCE
 *-----------------------------------------------------------------------------
 *   Module             :       bcg_iterator.h
 *   Auteurs            :       Renaud RUFFIOT et Radu MATEESCU
 *   Version            :       1.12
 *   Date               :       2007/06/04 12:13:07
 *****************************************************************************/

#ifndef BCG_ITERATOR_INTERFACE

#define BCG_ITERATOR_INTERFACE

#ifdef __cplusplus
extern "C" {
#endif

#ifdef BCG_UNDEFINED
}
#endif

#include "bcg_edge_sort.h"

#define BCG_OT_END(bcg_ot_iterator) ((bcg_ot_iterator).bcg_edge_buffer.bcg_end)
#define BCG_OT_I(bcg_ot_iterator) ((bcg_ot_iterator).bcg_edge_buffer.bcg_i)
#define BCG_OT_P(bcg_ot_iterator) ((bcg_ot_iterator).bcg_edge_buffer.bcg_p)
#define BCG_OT_L(bcg_ot_iterator) ((bcg_ot_iterator).bcg_edge_buffer.bcg_l)
#define BCG_OT_N(bcg_ot_iterator) ((bcg_ot_iterator).bcg_edge_buffer.bcg_n)

#ifdef bcg_check_all_iterators

/*
 * Si l'on ne definit pas la macro bcg_check_all_iterators, alors
 * l'utilisation d'un iterateur non implemente provoquera un message d'erreur
 * a la compilation ou l'edition de liens ("bcg_iterator_not_implemented not
 * found"). Sinon, l'utilisation d'un iterateur non implemente provoquera un
 * message d'erreur a l'execution
 */

#define bcg_iterator_not_implemented(bcg_message) \
	BCG_ERROR ("bcg_iterator", bcg_message, BCG_TRUE)

#endif

#define BCG_OT_GENERIC(bcg_object_transition, bcg_assign_i, bcg_assign_p, bcg_assign_l, bcg_assign_n) \
        {BCG_TYPE_OT_ITERATOR bcg_ot_iterator; \
        for (BCG_OT_START (&bcg_ot_iterator, (bcg_object_transition), BCG_UNDEFINED_SORT); \
             !BCG_OT_END(bcg_ot_iterator) && \
                ( \
                        (bcg_assign_i), \
                        (bcg_assign_p), \
                        (bcg_assign_l), \
                        (bcg_assign_n), \
                        BCG_TRUE \
                ); \
             BCG_OT_NEXT (&bcg_ot_iterator))

#define BCG_OT_ITERATE_I(bcg_object_transition, bcg_i) \
        BCG_OT_GENERIC((bcg_object_transition), \
                       (bcg_i) = BCG_OT_I (bcg_ot_iterator), \
                       (void) NULL, \
                       (void) NULL, \
                       (void) NULL)

#define BCG_OT_ITERATE_P(bcg_object_transition, bcg_p) \
        BCG_OT_GENERIC((bcg_object_transition), \
                       (void) NULL, \
                       (bcg_p) = BCG_OT_P (bcg_ot_iterator), \
                       (void) NULL, \
                       (void) NULL)

#define BCG_OT_ITERATE_L(bcg_object_transition, bcg_l) \
        BCG_OT_GENERIC((bcg_object_transition), \
                       (void) NULL, \
                       (void) NULL, \
                       (bcg_l) = BCG_OT_L (bcg_ot_iterator), \
                       (void) NULL)

#define BCG_OT_ITERATE_N(bcg_object_transition, bcg_n) \
        BCG_OT_GENERIC((bcg_object_transition), \
                       (void) NULL, \
                       (void) NULL, \
                       (void) NULL, \
                       (bcg_n) = BCG_OT_N (bcg_ot_iterator))

#define BCG_OT_ITERATE_IP(bcg_object_transition, bcg_i, bcg_p) \
        BCG_OT_GENERIC((bcg_object_transition), \
                       (bcg_i) = BCG_OT_I (bcg_ot_iterator), \
                       (bcg_p) = BCG_OT_P (bcg_ot_iterator), \
                       (void) NULL, \
                       (void) NULL)

#define BCG_OT_ITERATE_IL(bcg_object_transition, bcg_i, bcg_l) \
        BCG_OT_GENERIC((bcg_object_transition), \
                       (bcg_i) = BCG_OT_I (bcg_ot_iterator), \
                       (void) NULL, \
                       (bcg_l) = BCG_OT_L (bcg_ot_iterator), \
                       (void) NULL)

#define BCG_OT_ITERATE_IN(bcg_object_transition, bcg_i, bcg_n) \
        BCG_OT_GENERIC((bcg_object_transition), \
                       (bcg_i) = BCG_OT_I (bcg_ot_iterator), \
                       (void) NULL, \
                       (void) NULL, \
                       (bcg_n) = BCG_OT_N (bcg_ot_iterator))

#define BCG_OT_ITERATE_PL(bcg_object_transition, bcg_p, bcg_l) \
        BCG_OT_GENERIC((bcg_object_transition), \
                       (void) NULL, \
                       (bcg_p) = BCG_OT_P (bcg_ot_iterator), \
                       (bcg_l) = BCG_OT_L (bcg_ot_iterator), \
                       (void) NULL)

#define BCG_OT_ITERATE_PN(bcg_object_transition, bcg_p, bcg_n) \
        BCG_OT_GENERIC((bcg_object_transition), \
                       (void) NULL, \
                       (bcg_p) = BCG_OT_P (bcg_ot_iterator), \
                       (void) NULL, \
                       (bcg_n) = BCG_OT_N (bcg_ot_iterator))

#define BCG_OT_ITERATE_LN(bcg_object_transition, bcg_l, bcg_n) \
        BCG_OT_GENERIC((bcg_object_transition), \
                       (void) NULL, \
                       (void) NULL, \
                       (bcg_l) = BCG_OT_L (bcg_ot_iterator), \
                       (bcg_n) = BCG_OT_N (bcg_ot_iterator))

#define BCG_OT_ITERATE_IPL(bcg_object_transition, bcg_i, bcg_p, bcg_l) \
        BCG_OT_GENERIC((bcg_object_transition), \
                       (bcg_i) = BCG_OT_I (bcg_ot_iterator), \
                       (bcg_p) = BCG_OT_P (bcg_ot_iterator), \
                       (bcg_l) = BCG_OT_L (bcg_ot_iterator), \
                       (void) NULL)

#define BCG_OT_ITERATE_IPN(bcg_object_transition, bcg_i, bcg_p, bcg_n) \
        BCG_OT_GENERIC((bcg_object_transition), \
                       (bcg_i) = BCG_OT_I (bcg_ot_iterator), \
                       (bcg_p) = BCG_OT_P (bcg_ot_iterator), \
                       (void) NULL, \
                       (bcg_n) = BCG_OT_N (bcg_ot_iterator))

#define BCG_OT_ITERATE_ILN(bcg_object_transition, bcg_i, bcg_l, bcg_n) \
        BCG_OT_GENERIC((bcg_object_transition), \
                       (bcg_i) = BCG_OT_I (bcg_ot_iterator), \
                       (void) NULL, \
                       (bcg_l) = BCG_OT_L (bcg_ot_iterator), \
                       (bcg_n) = BCG_OT_N (bcg_ot_iterator))

#define BCG_OT_ITERATE_PLN(bcg_object_transition, bcg_p, bcg_l, bcg_n) \
        BCG_OT_GENERIC((bcg_object_transition), \
                       (void) NULL, \
                       (bcg_p) = BCG_OT_P (bcg_ot_iterator), \
                       (bcg_l) = BCG_OT_L (bcg_ot_iterator), \
                       (bcg_n) = BCG_OT_N (bcg_ot_iterator))

#define BCG_OT_ITERATE_IPLN(bcg_object_transition, bcg_i, bcg_p, bcg_l, bcg_n) \
        BCG_OT_GENERIC((bcg_object_transition), \
                       (bcg_i) = BCG_OT_I (bcg_ot_iterator), \
                       (bcg_p) = BCG_OT_P (bcg_ot_iterator), \
                       (bcg_l) = BCG_OT_L (bcg_ot_iterator), \
                       (bcg_n) = BCG_OT_N (bcg_ot_iterator))

#define BCG_OT_GENERIC_I(bcg_object_transition, bcg_i) \
        {BCG_TYPE_OT_ITERATOR bcg_ot_iterator; \
        BCG_OT_START_I (&bcg_ot_iterator, (bcg_object_transition), (bcg_i));

#define BCG_OT_ITERATE_I_P(bcg_object_transition, bcg_i, bcg_p)\
        BCG_OT_GENERIC_I((bcg_object_transition), (bcg_i)) \
        (bcg_p) = BCG_OT_P (bcg_ot_iterator);

#define BCG_OT_ITERATE_I_L(bcg_object_transition, bcg_i, bcg_l)\
        BCG_OT_GENERIC_I((bcg_object_transition), (bcg_i)) \
        (bcg_l) = BCG_OT_L (bcg_ot_iterator);

#define BCG_OT_ITERATE_I_N(bcg_object_transition, bcg_i, bcg_n)\
        BCG_OT_GENERIC_I((bcg_object_transition), (bcg_i)) \
        (bcg_n) = BCG_OT_N (bcg_ot_iterator);

#define BCG_OT_ITERATE_I_PL(bcg_object_transition, bcg_i, bcg_p, bcg_l)\
        BCG_OT_GENERIC_I((bcg_object_transition), (bcg_i)) \
        (bcg_p) = BCG_OT_P (bcg_ot_iterator); \
        (bcg_l) = BCG_OT_L (bcg_ot_iterator);

#define BCG_OT_ITERATE_I_PN(bcg_object_transition, bcg_i, bcg_p, bcg_n)\
        BCG_OT_GENERIC_I((bcg_object_transition), (bcg_i)) \
        (bcg_p) = BCG_OT_P (bcg_ot_iterator); \
        (bcg_n) = BCG_OT_N (bcg_ot_iterator);

#define BCG_OT_ITERATE_I_LN(bcg_object_transition, bcg_i, bcg_l, bcg_n)\
        BCG_OT_GENERIC_I((bcg_object_transition), (bcg_i)) \
        (bcg_l) = BCG_OT_L (bcg_ot_iterator); \
        (bcg_n) = BCG_OT_N (bcg_ot_iterator);

#define BCG_OT_ITERATE_I_PLN(bcg_object_transition, bcg_i, bcg_p, bcg_l, bcg_n)\
        BCG_OT_GENERIC_I((bcg_object_transition), (bcg_i)) \
        (bcg_p) = BCG_OT_P (bcg_ot_iterator); \
        (bcg_l) = BCG_OT_L (bcg_ot_iterator); \
        (bcg_n) = BCG_OT_N (bcg_ot_iterator);

#define BCG_OT_GENERIC_P(bcg_object_transition, bcg_p, bcg_assign_i, bcg_assign_l, bcg_assign_n) \
        {BCG_TYPE_OT_ITERATOR bcg_ot_iterator; \
        for (BCG_OT_START_P (&bcg_ot_iterator, (bcg_object_transition), BCG_P_SORT, (bcg_p)); \
             !BCG_OT_END (bcg_ot_iterator) && \
             (BCG_OT_P (bcg_ot_iterator) == (bcg_p)) && \
                ( \
                        (bcg_assign_i), \
                        (bcg_assign_l), \
                        (bcg_assign_n), \
                        BCG_TRUE \
                ); \
             BCG_OT_NEXT (&bcg_ot_iterator))

#define BCG_OT_ITERATE_P_I(bcg_object_transition, bcg_p, bcg_i) \
        BCG_OT_GENERIC_P((bcg_object_transition), (bcg_p), \
                       (bcg_i) = BCG_OT_I (bcg_ot_iterator), \
                       (void) NULL, \
                       (void) NULL)

#define BCG_OT_ITERATE_P_L(bcg_object_transition, bcg_p, bcg_l) \
        BCG_OT_GENERIC_P((bcg_object_transition), (bcg_p), \
                       (void) NULL, \
                       (bcg_l) = BCG_OT_L (bcg_ot_iterator), \
                       (void) NULL)

#define BCG_OT_ITERATE_P_N(bcg_object_transition, bcg_p, bcg_n) \
        BCG_OT_GENERIC_P((bcg_object_transition), (bcg_p), \
                       (void) NULL, \
                       (void) NULL, \
                       (bcg_n) = BCG_OT_N (bcg_ot_iterator))

#define BCG_OT_ITERATE_P_IL(bcg_object_transition, bcg_p, bcg_i, bcg_l) \
        BCG_OT_GENERIC_P((bcg_object_transition), (bcg_p), \
                       (bcg_i) = BCG_OT_I (bcg_ot_iterator), \
                       (bcg_l) = BCG_OT_L (bcg_ot_iterator), \
                       (void) NULL)

#define BCG_OT_ITERATE_P_IN(bcg_object_transition, bcg_p, bcg_i, bcg_n) \
        BCG_OT_GENERIC_P((bcg_object_transition), (bcg_p), \
                       (bcg_i) = BCG_OT_I (bcg_ot_iterator), \
                       (void) NULL, \
                       (bcg_n) = BCG_OT_N (bcg_ot_iterator))

#define BCG_OT_ITERATE_P_LN(bcg_object_transition, bcg_p, bcg_l, bcg_n) \
        BCG_OT_GENERIC_P((bcg_object_transition), (bcg_p), \
                       (void) NULL, \
                       (bcg_l) = BCG_OT_L (bcg_ot_iterator), \
                       (bcg_n) = BCG_OT_N (bcg_ot_iterator))

#define BCG_OT_ITERATE_P_ILN(bcg_object_transition, bcg_p, bcg_i, bcg_l, bcg_n) \
        BCG_OT_GENERIC_P((bcg_object_transition), (bcg_p), \
                       (bcg_i) = BCG_OT_I (bcg_ot_iterator), \
                       (bcg_l) = BCG_OT_L (bcg_ot_iterator), \
                       (bcg_n) = BCG_OT_N (bcg_ot_iterator))

#define BCG_OT_GENERIC_N(bcg_object_transition, bcg_n, bcg_assign_i, bcg_assign_p, bcg_assign_l) \
        {BCG_TYPE_OT_ITERATOR bcg_ot_iterator; \
        for (BCG_OT_START_N (&bcg_ot_iterator, (bcg_object_transition), BCG_N_SORT, (bcg_n)); \
             !BCG_OT_END (bcg_ot_iterator) && \
             (BCG_OT_N (bcg_ot_iterator) == (bcg_n)) && \
                ( \
                        (bcg_assign_i), \
                        (bcg_assign_p), \
                        (bcg_assign_l), \
                        BCG_TRUE \
                ); \
             BCG_OT_NEXT (&bcg_ot_iterator))

#define BCG_OT_ITERATE_N_I(bcg_object_transition, bcg_n, bcg_i) \
        BCG_OT_GENERIC_N((bcg_object_transition), (bcg_n), \
                       (bcg_i) = BCG_OT_I (bcg_ot_iterator), \
                       (void) NULL, \
                       (void) NULL)

#define BCG_OT_ITERATE_N_P(bcg_object_transition, bcg_n, bcg_p) \
        BCG_OT_GENERIC_N((bcg_object_transition), (bcg_n), \
                       (void) NULL, \
                       (bcg_p) = BCG_OT_P (bcg_ot_iterator), \
                       (void) NULL)

#define BCG_OT_ITERATE_N_L(bcg_object_transition, bcg_n, bcg_l) \
        BCG_OT_GENERIC_N((bcg_object_transition), (bcg_n), \
                       (void) NULL, \
                       (void) NULL, \
                       (bcg_l) = BCG_OT_L (bcg_ot_iterator))

#define BCG_OT_ITERATE_N_IP(bcg_object_transition, bcg_n, bcg_i, bcg_p) \
        BCG_OT_GENERIC_N((bcg_object_transition), (bcg_n), \
                       (bcg_i) = BCG_OT_I (bcg_ot_iterator), \
                       (bcg_p) = BCG_OT_P (bcg_ot_iterator), \
                       (void) NULL)

#define BCG_OT_ITERATE_N_IL(bcg_object_transition, bcg_n, bcg_i, bcg_l) \
        BCG_OT_GENERIC_N((bcg_object_transition), (bcg_n), \
                       (bcg_i) = BCG_OT_I (bcg_ot_iterator), \
                       (void) NULL, \
                       (bcg_l) = BCG_OT_L (bcg_ot_iterator))

#define BCG_OT_ITERATE_N_PL(bcg_object_transition, bcg_n, bcg_p, bcg_l) \
        BCG_OT_GENERIC_N((bcg_object_transition), (bcg_n), \
                       (void) NULL, \
                       (bcg_p) = BCG_OT_P (bcg_ot_iterator), \
                       (bcg_l) = BCG_OT_L (bcg_ot_iterator))

#define BCG_OT_ITERATE_N_IPL(bcg_object_transition, bcg_n, bcg_i, bcg_p, bcg_l)\
        BCG_OT_GENERIC_N((bcg_object_transition), (bcg_n), \
                       (bcg_i) = BCG_OT_I (bcg_ot_iterator), \
                       (bcg_p) = BCG_OT_P (bcg_ot_iterator), \
                       (bcg_l) = BCG_OT_L (bcg_ot_iterator))

#define BCG_OT_GENERIC_L(bcg_object_transition, bcg_l, bcg_assign_i, bcg_assign_p, bcg_assign_n) \
        {BCG_TYPE_OT_ITERATOR bcg_ot_iterator; \
        for (BCG_OT_START_L (&bcg_ot_iterator, (bcg_object_transition), \
                             BCG_UNDEFINED_SORT, (bcg_l)); \
             !BCG_OT_END (bcg_ot_iterator) && \
             (BCG_OT_L (bcg_ot_iterator) == (bcg_l)) && \
                ( \
                        (bcg_assign_i), \
                        (bcg_assign_p), \
                        (bcg_assign_n), \
                        BCG_TRUE \
                ); \
             BCG_OT_NEXT (&bcg_ot_iterator))

#define BCG_OT_ITERATE_L_I(bcg_object_transition, bcg_l, bcg_i)\
        BCG_OT_GENERIC_L((bcg_object_transition), (bcg_n), \
                       (bcg_i) = BCG_OT_I (bcg_ot_iterator), \
                       (void) NULL, \
                       (void) NULL)

#define BCG_OT_ITERATE_L_P(bcg_object_transition, bcg_l, bcg_p)\
        BCG_OT_GENERIC_L((bcg_object_transition), (bcg_n), \
                       (void) NULL, \
                       (bcg_p) = BCG_OT_P (bcg_ot_iterator), \
                       (void) NULL)

#define BCG_OT_ITERATE_L_N(bcg_object_transition, bcg_l, bcg_n)\
        BCG_OT_GENERIC_L((bcg_object_transition), (bcg_n), \
                       (void) NULL, \
                       (void) NULL, \
                       (bcg_n) = BCG_OT_N (bcg_ot_iterator))

#define BCG_OT_ITERATE_L_IP(bcg_object_transition, bcg_l, bcg_i, bcg_p)\
        BCG_OT_GENERIC_L((bcg_object_transition), (bcg_n), \
                       (bcg_i) = BCG_OT_I (bcg_ot_iterator), \
                       (bcg_p) = BCG_OT_P (bcg_ot_iterator), \
                       (void) NULL)

#define BCG_OT_ITERATE_L_IN(bcg_object_transition, bcg_l, bcg_i, bcg_n)\
        BCG_OT_GENERIC_L((bcg_object_transition), (bcg_n), \
                       (bcg_i) = BCG_OT_I (bcg_ot_iterator), \
                       (void) NULL, \
                       (bcg_n) = BCG_OT_N (bcg_ot_iterator))

#define BCG_OT_ITERATE_L_PN(bcg_object_transition, bcg_l, bcg_p, bcg_n)\
        BCG_OT_GENERIC_L((bcg_object_transition), (bcg_n), \
                       (void) NULL, \
                       (bcg_p) = BCG_OT_P (bcg_ot_iterator), \
                       (bcg_n) = BCG_OT_N (bcg_ot_iterator))

#define BCG_OT_ITERATE_L_IPN(bcg_object_transition, bcg_l, bcg_i, bcg_p, bcg_n)\
        BCG_OT_GENERIC_L((bcg_object_transition), (bcg_n), \
                       (bcg_i) = BCG_OT_I (bcg_ot_iterator), \
                       (bcg_p) = BCG_OT_P (bcg_ot_iterator), \
                       (bcg_n) = BCG_OT_N (bcg_ot_iterator))

#define BCG_OT_ITERATE_PL_I(bcg_object_transition, bcg_p, bcg_l, bcg_i) \
	BCG_OT_GENERIC (bcg_object_transition, bcg_i, bcg_p, bcg_l, (void) NULL) \
	bcg_iterator_not_implemented ("iterator BCG_OT_ITERATE_PL_I() not implemented yet\n");

#define BCG_OT_ITERATE_PL_N(bcg_object_transition, bcg_p, bcg_l, bcg_n) \
	BCG_OT_GENERIC (bcg_object_transition, (void) NULL, bcg_p, bcg_l, bcg_n) \
	bcg_iterator_not_implemented ("iterator BCG_OT_ITERATE_PL_N() not implemented yet\n");

#define BCG_OT_ITERATE_PL_IN(bcg_object_transition, bcg_p, bcg_l, bcg_i, bcg_n)\
	BCG_OT_GENERIC (bcg_object_transition, bcg_i, bcg_p, bcg_l, bcg_n) \
	bcg_iterator_not_implemented ("iterator BCG_OT_ITERATE_PL_IN() not implemented yet\n");

#define BCG_OT_ITERATE_PN_I(bcg_object_transition, bcg_p, bcg_n, bcg_i) \
	BCG_OT_GENERIC (bcg_object_transition, bcg_i, bcg_p, (void) NULL, bcg_n) \
	bcg_iterator_not_implemented ("iterator BCG_OT_ITERATE_PN_I() not implemented yet\n");

#define BCG_OT_ITERATE_PN_L(bcg_object_transition, bcg_p, bcg_n, bcg_l) \
	BCG_OT_GENERIC (bcg_object_transition, (void) NULL, bcg_p, bcg_l, bcg_n) \
	bcg_iterator_not_implemented ("iterator BCG_OT_ITERATE_PN_L() not implemented yet\n");

#define BCG_OT_ITERATE_PN_IL(bcg_object_transition, bcg_p, bcg_n, bcg_i, bcg_l)\
	BCG_OT_GENERIC (bcg_object_transition, bcg_i, bcg_p, bcg_l, bcg_n) \
	bcg_iterator_not_implemented ("iterator BCG_OT_ITERATE_PN_IL() not implemented yet\n");

#define BCG_OT_ITERATE_LN_I(bcg_object_transition, bcg_l, bcg_n, bcg_i) \
	BCG_OT_GENERIC (bcg_object_transition, bcg_i, (void) NULL, bcg_l, bcg_n) \
	bcg_iterator_not_implemented ("iterator BCG_OT_ITERATE_LN_I() not implemented yet\n");

#define BCG_OT_ITERATE_LN_P(bcg_object_transition, bcg_l, bcg_n, bcg_p) \
	BCG_OT_GENERIC (bcg_object_transition, (void) NULL, bcg_p, bcg_l, bcg_n) \
	bcg_iterator_not_implemented ("iterator BCG_OT_ITERATE_LN_P() not implemented yet\n");

#define BCG_OT_ITERATE_LN_IP(bcg_object_transition, bcg_l, bcg_n, bcg_i, bcg_p)\
	BCG_OT_GENERIC (bcg_object_transition, bcg_i, bcg_p, bcg_l, bcg_n) \
	bcg_iterator_not_implemented ("iterator BCG_OT_ITERATE_LN_IP() not implemented yet\n");

#define BCG_OT_ITERATE_PLN_I(bcg_object_transition, bcg_p, bcg_l, bcg_n, bcg_i)\
	BCG_OT_GENERIC (bcg_object_transition, bcg_i, bcg_p, bcg_l, bcg_n) \
	bcg_iterator_not_implemented ("iterator BCG_OT_ITERATE_PLN_I() not implemented yet\n");

/**                     Tableau de disponibilite des iterateurs

                        1       2       3

OT_ITERATE_IPLN ()      X       X       X
OT_ITERATE_I_PLN ()                     X
OT_ITERATE_P_ILN ()             X       X
OT_ITERATE_N_IPL ()             X       X
OT_ITERATE_L_IPN ()                     X
OT_ITERATE_PL_IN ()                     X
OT_ITERATE_PN_IL ()                     X
OT_ITERATE_LN_IP ()                     X
OT_ITERATE_PLN_I ()                     X

**/

/** Collection d'iterateur avec specification du tri

                        1       2       3

OT_ITERATE_IPLN ()  15  X       X       X (undefined,
                                           P, L, N,
                                           PL, PN, LP, LN, NP, NL,
                                           PLN, PNL, LPN, LNP, NPL, NLP)
OT_ITERATE_I_PLN ()  7                  X (undefined) Inutile
OT_ITERATE_P_ILN ()  7          X       X (undefined, L, N, LN, NL)
OT_ITERATE_N_IPL ()  7          X       X (undefined, P, L, PL, LP)
OT_ITERATE_L_IPN ()  7                  X (undefined, P, N, PN, NP)
OT_ITERATE_PL_IN ()  3                  X (undefined, N)
OT_ITERATE_PN_IL ()  3                  X (undefined, L)
OT_ITERATE_LN_IP ()  3                  X (undefined, P)
OT_ITERATE_PLN_I ()                     X (undefined) Inutile

On ne peut pas multiplier le nombre d'iterateurs par le nombre de tris
parce qu'on en obtient 15 * 15 = 225.

**/

#define BCG_OT_END_ITERATE BCG_OT_STOP (&bcg_ot_iterator);}

#ifdef BCG_UNDEFINED
{
#endif

#ifdef __cplusplus
}
#endif

#endif
