-- CADP (CONSTRUCTION AND ANALYSIS OF DISTRIBUTED PROCESSES)
-- http://cadp.inria.fr

[Last updated: Thu Aug 23 17:22:01 CEST 2018]

This directory contains an example for BISIMULATOR, CAESAR, LNT2LOTOS, and
SVL. It describes the verification of a distributed cache memory by using
abstractions.

* The cache memory has been initially described in
* 
* @article{Afek-Brown-Meritt-93,
*    author  = {Y. Afek and G. Brown and M. Meritt},
*    title   = {Lazy Caching},
*    journal = {ACM Transactions on Programming Languages and Systems},
*    volume  = {15},
*    number  = {1},
*    year    = {1993}
* }
* 
* Its verification using abstractions is described in
* 
* @article{Graf-99,
*    author  = {S. Graf},
*    title   = {Characterization of a Sequentially Consistent Memory
*               and Verification of a Cache Memory by Abstraction},
*    journal = {Distributed Computing},
*    volume  = {12},
*    number  = {2--3},
*    pages   = {75--90},
*    year    = {1999}
* }
* and originally in
* 
* @inproceedings{Graf-94,
*    author    = {S. Graf},
*    title     = {Verification of a Distributed Cache Memory by using
*                 Abstractions},
*    booktitle = {Conference on Computer Aided Verification (CAV'94)},
*    series    = {Lecture Notes in Computer Science},
*    volume    = {818},
*    month     = jun,
*    pages     = {207--219},
*    year      = {1994},
*    publisher = {Springer Verlag}
* }
*
* 
* Short Description of the Cache Memory System
* --------------------------------------------
*
* This is a very simple cache memory consisting of a process MEMORY
* and a set of processes, each of which may either:
* 
* 1) WRITE a datum d on address a:
*    this has the effect to push the pair (a, d) into a local buffer
*    OUT (in our modelisations such pairs are represented by E1, E2
*    (observed pairs) and EPS (standing fo "any other pair"))
* 
* 2) MEMORY-WRITE the first pair (a, d) of OUT: 
*    this has the effect
*      - to eliminate (a, d) from OUT
*      - to push the triple (a, d, 1) into a local buffer IN
*      - to push the triple (a, d, 0) into the buffers IN of all other
*        processes (in the LOTOS description this is obtained by a
*        synchronisation of all processes on this action)
*      - to write datum d on address a in the global memory M
* 
* 3) CASH-UPDATE the first triple (a, d, *) of IN:
*    this has the effect
*      - to eliminate (a, d, *) from IN
*      - to write datum d on address a in the local cache memory C
* 
* 4) READ a datum d on address a (of the local cache memory C): 
*    this is only possible if 
*    a) the local buffer OUT is empty and 
*    b) the local buffer IN contains no element of the form (*, *, 1)
*    and has no effect
* 
* 5) CACHE-INVALIDATE an address a (of the local cache memory C):
*    this has the effect to put an "undefined" value in address a of
*    memory C
*    (for efficiency reasons only allowed if C(a) is not already
*    invalidated)
* 
* 6) MEMORY-READ a datum d on address a (of the global memory M):
*    this has the effect to push the triple (a, d, 0) into the local
*    buffer IN
*    (for efficiency reasons only allowed if C(a) invalidated)
*
* The original description of the cache memory can be found in:
* @Article{AfekBrownMeritt93,
*    author  = {Y. Afek and G. Brown and M. Meritt},
*    title   = {Lazy Caching},
*    journal = {ACM Transactions on Programming Languages and Systems},
*    volume  = {15},
*    number  = {1},
*    year    = {1993}
* }
*
*
* Short Description of the Properties to be verified
* --------------------------------------------------
*
* For a description by means of temporal logic formulas see the paper
* @Article{Graf99,
*    author  = {S. Graf},
*    title   = {Characterization of a Sequentially Consistent Memory
* 		 and Verification of a Cache Memory by Abstraction},
*    journal = {Distributed Computing},
*    volume  = {12},
*    number  = {2--3},
*    pages   = {75--90},
*    year    = {1999}
* } 
* Here we give just an intuitive description of all properties.
*   
* The automatons expressing the properites used for the verification
* with the CADP are defined in the files "C2.aut", "S1.aut", "S2.aut",
* "S3.aut" and "S4.lotos" (cited below).
*  
* Property C2:
* ------------ 
* Whenever a pair (a, d) (= E1) has been taken into account
* (cache-updated) by some processes, then as soon a pair (a, d') with
* d != d' (= E2) has been taken into account, d on address a (E1) can
* never be read any more by this process
*  
* Property C3:
* ------------
* Whenever a pair (a, d) has been written by some process, it will
* eventually be taken into account (cache-updated) (This liveness
* property does not hold on any finite abstraction, but it has been
* proven in the paper [Graf99]).
*  
* Property S1: 
* ------------
* Whenever a pair (a, d) has been written by some process, in this
* process read is disabled until (a, d) has been taken into account
* (cache-updated).
*  
* Property S2: 
* ------------
* A pair (a, d) can only be taken into account (cache-updated) by some
* process, if it has been written before by some process.
*  
* Property S3:
* ------------
* Any two pairs (a, d) and (a', d') written by the same process are
* (in this process) taken into account in the order in which they have
* been written.
*  
* Property S4: 
* ------------
* Any two pairs (a, d) and (a', d') (written by the same or by
* different processes) are in all processes taken into account
* (cache-updated) in the same order.
*
*
* Verification of the Specifications 
* ----------------------------------
*
* All these properties (except C3) can be verified on very simple
* abstract systems in which at most two pairs (a, d) (= E1) and 
* (a', d') (= E2) must be distinguished, whereas all other possible
* pairs are grouped together in a single one, expressing ``any pair
* different from those two'' (EPS).
* Also, for any property, at most 3 processes must be different from
* the trivial process in which all local variables are abstracted
* away, and which can therefore execute any action at any time
* (completely abstracted).
*
* We consider 5 different abstract systems. See the SVL file for
* more details

The whole verification scenario is described and commented in the file 
"demo.svl".  It can be executed by typing:
$	svl demo
or just
$	svl

After execution of the SVL scenario, all generated files can be removed by 
typing:
$	svl -clean demo
or just
$	svl -clean

