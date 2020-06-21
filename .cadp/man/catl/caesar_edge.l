


OPEN/CAESAR MANUAL                             caesar_edge(LOCAL)



NNNNAAAAMMMMEEEE
     caesar_edge - the ``edge'' library of OPEN/CAESAR

PPPPUUUURRRRPPPPOOOOSSSSEEEE
     The ``edge'' library provides primitives for  computing  the
     edges going out of a given state.

     Although the _O_P_E_N/_C_A_E_S_A_R graph module  already  provides  an
     iterator  macro for this purpose (the CCCCAAAAEEEESSSSAAAARRRR____IIIITTTTEEEERRRRAAAATTTTEEEE____SSSSTTTTAAAATTTTEEEE(((())))
     function), higher-level primitives may be useful and  easier
     to  use.   This  is  especially  the case when a depth-first
     traversal of the state graph is necessary (e.g.,  on-the-fly
     verification, interactive simulation, ...).

     From our experience, the CCCCAAAAEEEESSSSAAAARRRR____IIIITTTTEEEERRRRAAAATTTTEEEE____SSSSTTTTAAAATTTTEEEE(((()))) function  is
     often  used  as follows: for a given state S_1, one wants to
     compute all outgoing edges of the form  ``(S_1,  L,  S_2)'';
     the  labels  L and states S_2 are stored in a data structure
     (usually a linked list).


UUUUSSSSAAAAGGGGEEEE
     The ``edge'' library consists of:

     -    a predefined header file ccccaaaaeeeessssaaaarrrr____eeeeddddggggeeee....hhhh;

     -    the precompiled library file lllliiiibbbbccccaaaaeeeessssaaaarrrr....aaaa, which  imple-
          ments the features described in ccccaaaaeeeessssaaaarrrr____eeeeddddggggeeee....hhhh.

     Note: The ``edge'' library is a software layer  built  above
     the  primitives  offered  by the ``standard'' library and by
     the _O_P_E_N/_C_A_E_S_A_R graph module.


DDDDEEEESSSSCCCCRRRRIIIIPPPPTTTTIIIIOOOONNNN
     An ``edge'' is basically a tuple with 5 fields:

     -    (1) a field containing a ``previous'' state;

     -    (2) a field containing a label;

     -    (3) a field containing a ``next'' state;

     -    (4) a ``mark'' field, that is a byte string whose  size
          and  contents are freely determined by the user. It can
          be used to mark states while depth-first exploring  the
          state graph. The size of the mark field is the same for
          all edges; it must  be  greater  or  equal  than  zero.
          Pointers to mark fields will be considered as values of
          type CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____PPPPOOOOIIIINNNNTTTTEEEERRRR; ``mark''  fields  are  always
          aligned  on appropriate boundaries so that the user can
          put any information in these fields  without  alignment



(C) INRIA     Last change: 2020/02/11 (version 1.6)             1






OPEN/CAESAR MANUAL                             caesar_edge(LOCAL)



          problem;

     -    (5) a pointer to a ``successor'' edge, which is used to
          build linked lists of edges.

     Fields (1), (2), (3), and (4) are optional, depending on the
     initialization  parameters  (see function CCCCAAAAEEEESSSSAAAARRRR____IIIINNNNIIIITTTT____EEEEDDDDGGGGEEEE(((())))
     below).

     Edges are represented as byte strings  of  fixed  size  (see
     function  CCCCAAAAEEEESSSSAAAARRRR____SSSSIIIIZZZZEEEE____EEEEDDDDGGGGEEEE(((())))  below) with definite alignment
     constraints (see  function  CCCCAAAAEEEESSSSAAAARRRR____AAAALLLLIIIIGGGGNNNNMMMMEEEENNNNTTTT____EEEEDDDDGGGGEEEE(((())))  below).
     All edges have the same size.


FFFFEEEEAAAATTTTUUUURRRREEEESSSS
      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____EEEEDDDDGGGGEEEE

     ttttyyyyppppeeeeddddeeeeffff CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____AAAABBBBSSSSTTTTRRRRAAAACCCCTTTT ((((............)))) CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____EEEEDDDDGGGGEEEE;;;;

     This type denotes a pointer to the  concrete  representation
     of  an  edge.  The  edge  representation  is  supposed to be
     ``opaque''.

      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____IIIINNNNIIIITTTT____EEEEDDDDGGGGEEEE

     vvvvooooiiiidddd CCCCAAAAEEEESSSSAAAARRRR____IIIINNNNIIIITTTT____EEEEDDDDGGGGEEEE ((((CCCCAAAAEEEESSSSAAAARRRR____PPPPRRRREEEEVVVVIIIIOOOOUUUUSSSS____SSSSTTTTAAAATTTTEEEE,,,, CCCCAAAAEEEESSSSAAAARRRR____LLLLAAAABBBBEEEELLLL,,,, CCCCAAAAEEEESSSSAAAARRRR____NNNNEEEEXXXXTTTT____SSSSTTTTAAAATTTTEEEE,,,,
                            CCCCAAAAEEEESSSSAAAARRRR____SSSSIIIIZZZZEEEE____MMMMAAAARRRRKKKK,,,, CCCCAAAAEEEESSSSAAAARRRR____AAAALLLLIIIIGGGGNNNNMMMMEEEENNNNTTTT____MMMMAAAARRRRKKKK))))
     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____BBBBOOOOOOOOLLLLEEEEAAAANNNN CCCCAAAAEEEESSSSAAAARRRR____PPPPRRRREEEEVVVVIIIIOOOOUUUUSSSS____SSSSTTTTAAAATTTTEEEE;;;;
     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____BBBBOOOOOOOOLLLLEEEEAAAANNNN CCCCAAAAEEEESSSSAAAARRRR____LLLLAAAABBBBEEEELLLL;;;;
     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____BBBBOOOOOOOOLLLLEEEEAAAANNNN CCCCAAAAEEEESSSSAAAARRRR____NNNNEEEEXXXXTTTT____SSSSTTTTAAAATTTTEEEE;;;;
     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL CCCCAAAAEEEESSSSAAAARRRR____SSSSIIIIZZZZEEEE____MMMMAAAARRRRKKKK;;;;
     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL CCCCAAAAEEEESSSSAAAARRRR____AAAALLLLIIIIGGGGNNNNMMMMEEEENNNNTTTT____MMMMAAAARRRRKKKK;;;;
     {{{{ ............ }}}}

     This initialization procedure must be  called  before  using
     any  other  primitive  of the ``edge'' library. It should be
     called only once.

     Each  edge   will   contain   a   ``previous''   state   iff
     CCCCAAAAEEEESSSSAAAARRRR____PPPPRRRREEEEVVVVIIIIOOOOUUUUSSSS____SSSSTTTTAAAATTTTEEEE is equal to true.

     Each edge will contain a label iff CCCCAAAAEEEESSSSAAAARRRR____LLLLAAAABBBBEEEELLLL is equal  to
     true.

     Each   edge   will   contain   a    ``next''    state    iff
     CCCCAAAAEEEESSSSAAAARRRR____NNNNEEEEXXXXTTTT____SSSSTTTTAAAATTTTEEEE is equal to true.




(C) INRIA     Last change: 2020/02/11 (version 1.6)             2






OPEN/CAESAR MANUAL                             caesar_edge(LOCAL)



     Each edge will contain a mark field iff CCCCAAAAEEEESSSSAAAARRRR____SSSSIIIIZZZZEEEE____MMMMAAAARRRRKKKK  is
     different  from  zero.  If so, the value of CCCCAAAAEEEESSSSAAAARRRR____SSSSIIIIZZZZEEEE____MMMMAAAARRRRKKKK
     determines the (constant) size (in bytes) of the mark field,
     and the value of CCCCAAAAEEEESSSSAAAARRRR____AAAALLLLIIIIGGGGNNNNMMMMEEEENNNNTTTT____MMMMAAAARRRRKKKK determines the align-
     ment factor (in bytes) of the  mark  field.   The  alignment
     factor  must  be  a  power  of  two.  Any mark field will be
     aligned on a boundary that is an even multiple of the align-
     ment  factor.   CCCCAAAAEEEESSSSAAAARRRR____AAAALLLLIIIIGGGGNNNNMMMMEEEENNNNTTTT____MMMMAAAARRRRKKKK  is  equal to zero iff
     CCCCAAAAEEEESSSSAAAARRRR____SSSSIIIIZZZZEEEE____MMMMAAAARRRRKKKK is equal to zero; otherwise, the effect  of
     CCCCAAAAEEEESSSSAAAARRRR____IIIINNNNIIIITTTT____EEEEDDDDGGGGEEEE(((()))) is undefined.

     If      CCCCAAAAEEEESSSSAAAARRRR____PPPPRRRREEEEVVVVIIIIOOOOUUUUSSSS____SSSSTTTTAAAATTTTEEEE,       CCCCAAAAEEEESSSSAAAARRRR____LLLLAAAABBBBEEEELLLL,       and
     CCCCAAAAEEEESSSSAAAARRRR____NNNNEEEEXXXXTTTT____SSSSTTTTAAAATTTTEEEE    are    equal    to    false,   and   if
     CCCCAAAAEEEESSSSAAAARRRR____SSSSIIIIZZZZEEEE____MMMMAAAARRRRKKKK  is  equal   to   zero,   the   effect   of
     CCCCAAAAEEEESSSSAAAARRRR____IIIINNNNIIIITTTT____EEEEDDDDGGGGEEEE(((()))) is undefined.

      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____SSSSIIIIZZZZEEEE____EEEEDDDDGGGGEEEE

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL CCCCAAAAEEEESSSSAAAARRRR____SSSSIIIIZZZZEEEE____EEEEDDDDGGGGEEEE (((())))
     {{{{ ............ }}}}

     This function returns the edge size (in bytes).

      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____AAAALLLLIIIIGGGGNNNNMMMMEEEENNNNTTTT____EEEEDDDDGGGGEEEE

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL CCCCAAAAEEEESSSSAAAARRRR____AAAALLLLIIIIGGGGNNNNMMMMEEEENNNNTTTT____EEEEDDDDGGGGEEEE (((())))
        {{{{ ............ }}}}

     This function returns the alignment factor  (in  bytes)  for
     edges.  The  alignment factor is always a power of two, usu-
     ally 1, 2, 4, or 8. Any byte string representing a edge must
     be  aligned  on  a  boundary that is an even multiple of the
     alignment factor.

      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____PPPPRRRREEEEVVVVIIIIOOOOUUUUSSSS____SSSSTTTTAAAATTTTEEEE____EEEEDDDDGGGGEEEE

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSTTTTAAAATTTTEEEE CCCCAAAAEEEESSSSAAAARRRR____PPPPRRRREEEEVVVVIIIIOOOOUUUUSSSS____SSSSTTTTAAAATTTTEEEE____EEEEDDDDGGGGEEEE ((((CCCCAAAAEEEESSSSAAAARRRR____EEEE))))
     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____EEEEDDDDGGGGEEEE CCCCAAAAEEEESSSSAAAARRRR____EEEE;;;;
     {{{{ ............ }}}}

     This function returns a pointer to  the  ``previous''  state
     field  of  the  edge  pointed to by CCCCAAAAEEEESSSSAAAARRRR____EEEE. If there is no
     such field (due to the initialization parameters supplied to
     CCCCAAAAEEEESSSSAAAARRRR____IIIINNNNIIIITTTT____EEEEDDDDGGGGEEEE(((())))) the result is undefined.





(C) INRIA     Last change: 2020/02/11 (version 1.6)             3






OPEN/CAESAR MANUAL                             caesar_edge(LOCAL)



      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____LLLLAAAABBBBEEEELLLL____EEEEDDDDGGGGEEEE

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____LLLLAAAABBBBEEEELLLL CCCCAAAAEEEESSSSAAAARRRR____LLLLAAAABBBBEEEELLLL____EEEEDDDDGGGGEEEE ((((CCCCAAAAEEEESSSSAAAARRRR____EEEE))))
     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____EEEEDDDDGGGGEEEE CCCCAAAAEEEESSSSAAAARRRR____EEEE;;;;
     {{{{ ............ }}}}

     This function returns a pointer to the label  field  of  the
     edge  pointed to by CCCCAAAAEEEESSSSAAAARRRR____EEEE. If there is no such field (due
     to    the    initialization    parameters    supplied     to
     CCCCAAAAEEEESSSSAAAARRRR____IIIINNNNIIIITTTT____EEEEDDDDGGGGEEEE(((())))) the result is undefined.

      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____NNNNEEEEXXXXTTTT____SSSSTTTTAAAATTTTEEEE____EEEEDDDDGGGGEEEE

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSTTTTAAAATTTTEEEE CCCCAAAAEEEESSSSAAAARRRR____NNNNEEEEXXXXTTTT____SSSSTTTTAAAATTTTEEEE____EEEEDDDDGGGGEEEE ((((CCCCAAAAEEEESSSSAAAARRRR____EEEE))))
     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____EEEEDDDDGGGGEEEE CCCCAAAAEEEESSSSAAAARRRR____EEEE;;;;
     {{{{ ............ }}}}

     This function returns a pointer to the ``next'' state  field
     of  the  edge  pointed  to  by CCCCAAAAEEEESSSSAAAARRRR____EEEE. If there is no such
     field (due to  the  initialization  parameters  supplied  to
     CCCCAAAAEEEESSSSAAAARRRR____IIIINNNNIIIITTTT____EEEEDDDDGGGGEEEE(((())))) the result is undefined.

      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____MMMMAAAARRRRKKKK____EEEEDDDDGGGGEEEE

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____PPPPOOOOIIIINNNNTTTTEEEERRRR CCCCAAAAEEEESSSSAAAARRRR____MMMMAAAARRRRKKKK____EEEEDDDDGGGGEEEE ((((CCCCAAAAEEEESSSSAAAARRRR____EEEE))))
     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____EEEEDDDDGGGGEEEE CCCCAAAAEEEESSSSAAAARRRR____EEEE;;;;
     {{{{ ............ }}}}

     This function returns a pointer to the  mark  field  of  the
     edge  pointed to by CCCCAAAAEEEESSSSAAAARRRR____EEEE. If there is no such field (due
     to    the    initialization    parameters    supplied     to
     CCCCAAAAEEEESSSSAAAARRRR____IIIINNNNIIIITTTT____EEEEDDDDGGGGEEEE(((())))) the result is undefined.

      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____SSSSUUUUCCCCCCCCEEEESSSSSSSSOOOORRRR____EEEEDDDDGGGGEEEE

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____EEEEDDDDGGGGEEEE ****CCCCAAAAEEEESSSSAAAARRRR____SSSSUUUUCCCCCCCCEEEESSSSSSSSOOOORRRR____EEEEDDDDGGGGEEEE ((((CCCCAAAAEEEESSSSAAAARRRR____EEEE))))
     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____EEEEDDDDGGGGEEEE CCCCAAAAEEEESSSSAAAARRRR____EEEE;;;;
     {{{{ ............ }}}}

     This function returns a pointer to  the  ``successor''  edge
     (pointer) field of the edge pointed to by CCCCAAAAEEEESSSSAAAARRRR____EEEE.

      ............................................................




(C) INRIA     Last change: 2020/02/11 (version 1.6)             4






OPEN/CAESAR MANUAL                             caesar_edge(LOCAL)



  CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTEEEE____EEEEDDDDGGGGEEEE

     vvvvooooiiiidddd CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTEEEE____EEEEDDDDGGGGEEEE ((((CCCCAAAAEEEESSSSAAAARRRR____EEEE))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____EEEEDDDDGGGGEEEE ****CCCCAAAAEEEESSSSAAAARRRR____EEEE;;;;
        {{{{ ............ }}}}

     This  procedure  allocates   a   byte   string   of   length
     CCCCAAAAEEEESSSSAAAARRRR____SSSSIIIIZZZZEEEE____EEEEDDDDGGGGEEEE(((())))  using  CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTEEEE(((())))  and  assigns its
     address to ****CCCCAAAAEEEESSSSAAAARRRR____EEEE. If  the  allocation  fails,  the  NNNNUUUULLLLLLLL
     value is assigned to ****CCCCAAAAEEEESSSSAAAARRRR____EEEE.

     When the allocation succeeds, the mark  field  (if  any)  of
     CCCCAAAAEEEESSSSAAAARRRR____EEEE  is  initialized  to  a  bit  string of 0's and the
     ``successor'' edge field is initialized to the NNNNUUUULLLLLLLL pointer.
     The state field and the label field are left undefined.

     Note: because CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____EEEEDDDDGGGGEEEE is a pointer type, any  vari-
     able  CCCCAAAAEEEESSSSAAAARRRR____EEEE  of  type  CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____EEEEDDDDGGGGEEEE must be allocated
     before used, for instance using:

                   CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTEEEE____EEEEDDDDGGGGEEEE ((((&&&&CCCCAAAAEEEESSSSAAAARRRR____EEEE))));;;;

     However, it is not necessary to use CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTEEEE____EEEEDDDDGGGGEEEE(((())))  to
     perform  the  allocation.  Instead, users can allocate edges
     into their own data structures (tables, lists, ...)

      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____DDDDEEEELLLLEEEETTTTEEEE____EEEEDDDDGGGGEEEE

     vvvvooooiiiidddd CCCCAAAAEEEESSSSAAAARRRR____DDDDEEEELLLLEEEETTTTEEEE____EEEEDDDDGGGGEEEE ((((CCCCAAAAEEEESSSSAAAARRRR____EEEE))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____EEEEDDDDGGGGEEEE ****CCCCAAAAEEEESSSSAAAARRRR____EEEE;;;;
        {{{{ ............ }}}}

     This   procedure   frees   the   byte   string   of   length
     CCCCAAAAEEEESSSSAAAARRRR____SSSSIIIIZZZZEEEE____EEEEDDDDGGGGEEEE(((())))    pointed    to   by   ****CCCCAAAAEEEESSSSAAAARRRR____EEEE   using
     CCCCAAAAEEEESSSSAAAARRRR____DDDDEEEELLLLEEEETTTTEEEE(((()))). Afterwards, the NNNNUUUULLLLLLLL value is  assigned  to
     ****CCCCAAAAEEEESSSSAAAARRRR____EEEE.

      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____CCCCOOOOPPPPYYYY____EEEEDDDDGGGGEEEE

     vvvvooooiiiidddd CCCCAAAAEEEESSSSAAAARRRR____CCCCOOOOPPPPYYYY____EEEEDDDDGGGGEEEE ((((CCCCAAAAEEEESSSSAAAARRRR____EEEE1111,,,, CCCCAAAAEEEESSSSAAAARRRR____EEEE2222))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____EEEEDDDDGGGGEEEE CCCCAAAAEEEESSSSAAAARRRR____EEEE1111;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____EEEEDDDDGGGGEEEE CCCCAAAAEEEESSSSAAAARRRR____EEEE2222;;;;
        {{{{ ............ }}}}

     This procedure copies the edge pointed to by CCCCAAAAEEEESSSSAAAARRRR____EEEE2222  onto
     the edge pointed to by CCCCAAAAEEEESSSSAAAARRRR____EEEE1111.





(C) INRIA     Last change: 2020/02/11 (version 1.6)             5






OPEN/CAESAR MANUAL                             caesar_edge(LOCAL)



      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____FFFFOOOORRRRMMMMAAAATTTT____EEEEDDDDGGGGEEEE

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____FFFFOOOORRRRMMMMAAAATTTT CCCCAAAAEEEESSSSAAAARRRR____FFFFOOOORRRRMMMMAAAATTTT____EEEEDDDDGGGGEEEE ((((CCCCAAAAEEEESSSSAAAARRRR____FFFFOOOORRRRMMMMAAAATTTT))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____FFFFOOOORRRRMMMMAAAATTTT CCCCAAAAEEEESSSSAAAARRRR____FFFFOOOORRRRMMMMAAAATTTT;;;;
        {{{{ ............ }}}}

     This function allows to control the format under which edges
     are    printed   by   procedures   CCCCAAAAEEEESSSSAAAARRRR____PPPPRRRRIIIINNNNTTTT____EEEEDDDDGGGGEEEE(((())))   and
     CCCCAAAAEEEESSSSAAAARRRR____PPPPRRRRIIIINNNNTTTT____EEEEDDDDGGGGEEEE____LLLLIIIISSSSTTTT(((()))) (see below). Currently, the follow-
     ing formats are available:


     -    With format 0, the edge is  printed  as  a  portion  of
          text. This is mainly intended for debugging purpose.

     -    (no other format available yet)

     By default, the current edge format is initialized to 0.

     When called with CCCCAAAAEEEESSSSAAAARRRR____FFFFOOOORRRRMMMMAAAATTTT between 0 and 0,  this  fonc-
     tion  sets  the  current  edge  format  to CCCCAAAAEEEESSSSAAAARRRR____FFFFOOOORRRRMMMMAAAATTTT and
     returns an undefined result.

     When called with another value of CCCCAAAAEEEESSSSAAAARRRR____FFFFOOOORRRRMMMMAAAATTTT, this  func-
     tion  does  not modify the current edge format but returns a
     result defined as follows. If CCCCAAAAEEEESSSSAAAARRRR____FFFFOOOORRRRMMMMAAAATTTT is equal to  the
     constant  CCCCAAAAEEEESSSSAAAARRRR____CCCCUUUURRRRRRRREEEENNNNTTTT____FFFFOOOORRRRMMMMAAAATTTT,  the result is the value of
     the current edge format. If CCCCAAAAEEEESSSSAAAARRRR____FFFFOOOORRRRMMMMAAAATTTT is  equal  to  the
     constant  CCCCAAAAEEEESSSSAAAARRRR____MMMMAAAAXXXXIIIIMMMMAAAALLLL____FFFFOOOORRRRMMMMAAAATTTT,  the  result is the maximal
     format value (i.e., 0). In all other cases,  the  effect  of
     this function is undefined.

      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____MMMMAAAAXXXX____FFFFOOOORRRRMMMMAAAATTTT____EEEEDDDDGGGGEEEE

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____FFFFOOOORRRRMMMMAAAATTTT CCCCAAAAEEEESSSSAAAARRRR____MMMMAAAAXXXX____FFFFOOOORRRRMMMMAAAATTTT____EEEEDDDDGGGGEEEE (((())))
        {{{{ ............ }}}}

     Caution! This function is deprecated. It should no longer be
     used,  as  it  might  be removed from future versions of the
     _O_P_E_N/_C_A_E_S_A_R.  Use  function  CCCCAAAAEEEESSSSAAAARRRR____FFFFOOOORRRRMMMMAAAATTTT____EEEEDDDDGGGGEEEE(((())))   instead,
     called with argument CCCCAAAAEEEESSSSAAAARRRR____MMMMAAAAXXXXIIIIMMMMAAAALLLL____FFFFOOOORRRRMMMMAAAATTTT.

     This function returns the maximal format value available for
     printing edges.

      ............................................................





(C) INRIA     Last change: 2020/02/11 (version 1.6)             6






OPEN/CAESAR MANUAL                             caesar_edge(LOCAL)



  CCCCAAAAEEEESSSSAAAARRRR____PPPPRRRRIIIINNNNTTTT____EEEEDDDDGGGGEEEE

     vvvvooooiiiidddd CCCCAAAAEEEESSSSAAAARRRR____PPPPRRRRIIIINNNNTTTT____EEEEDDDDGGGGEEEE ((((CCCCAAAAEEEESSSSAAAARRRR____FFFFIIIILLLLEEEE,,,, CCCCAAAAEEEESSSSAAAARRRR____EEEE))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____FFFFIIIILLLLEEEE CCCCAAAAEEEESSSSAAAARRRR____FFFFIIIILLLLEEEE;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____EEEEDDDDGGGGEEEE CCCCAAAAEEEESSSSAAAARRRR____EEEE;;;;
        {{{{ ............ }}}}

     This procedure prints to file CCCCAAAAEEEESSSSAAAARRRR____FFFFIIIILLLLEEEE information  about
     the  contents of the edge pointed to by CCCCAAAAEEEESSSSAAAARRRR____EEEE. The nature
     of the information is determined by the current edge  format
     (see procedure CCCCAAAAEEEESSSSAAAARRRR____FFFFOOOORRRRMMMMAAAATTTT____EEEEDDDDGGGGEEEE(((()))) above).

     Before this procedure is called, CCCCAAAAEEEESSSSAAAARRRR____FFFFIIIILLLLEEEE must have  been
     properly opened, for instance using ffffooooppppeeeennnn((((3333)))).

      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTEEEE____EEEEDDDDGGGGEEEE____LLLLIIIISSSSTTTT

     vvvvooooiiiidddd CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTEEEE____EEEEDDDDGGGGEEEE____LLLLIIIISSSSTTTT ((((CCCCAAAAEEEESSSSAAAARRRR____SSSS1111,,,, CCCCAAAAEEEESSSSAAAARRRR____EEEE1111____EEEEnnnn,,,, CCCCAAAAEEEESSSSAAAARRRR____OOOORRRRDDDDEEEERRRR))))
     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSTTTTAAAATTTTEEEE CCCCAAAAEEEESSSSAAAARRRR____SSSS1111;;;;
     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____EEEEDDDDGGGGEEEE ****CCCCAAAAEEEESSSSAAAARRRR____EEEE1111____EEEEnnnn;;;;
     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL CCCCAAAAEEEESSSSAAAARRRR____OOOORRRRDDDDEEEERRRR;;;;

     This procedure computes all  couples  (CCCCAAAAEEEESSSSAAAARRRR____LLLL,  CCCCAAAAEEEESSSSAAAARRRR____SSSS2222)
     such that ``(CCCCAAAAEEEESSSSAAAARRRR____SSSS1111, CCCCAAAAEEEESSSSAAAARRRR____LLLL, CCCCAAAAEEEESSSSAAAARRRR____SSSS2222)'' is an edge of
     the labelled transition  system  (this  is  done  using  the
     CCCCAAAAEEEESSSSAAAARRRR____IIIITTTTEEEERRRRAAAATTTTEEEE____SSSSTTTTAAAATTTTEEEE(((()))) procedure of the graph module).

     This procedure also builds a linked  list  whose  items  are
     values  of  type CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____EEEEDDDDGGGGEEEE, linked together using the
     ``successor'' edge field. The ``successor''  edge  field  of
     the  last  item  is  set  to  NNNNUUUULLLLLLLL. The list can be empty if
     CCCCAAAAEEEESSSSAAAARRRR____SSSS1111 is a sink state. The address of the first item  of
     the  list  (or  NNNNUUUULLLLLLLL  if  the  list is empty) is assigned to
     ****CCCCAAAAEEEESSSSAAAARRRR____EEEE1111____EEEEnnnn.   Obviously,   the    previous    value    of
     ****CCCCAAAAEEEESSSSAAAARRRR____EEEE1111____EEEEnnnn is lost.

     The fields of each item are assigned as follows:


     -    the ``previous'' state field (if any) will contain  the
          value of CCCCAAAAEEEESSSSAAAARRRR____SSSS1111.

     -    the label field (if any) will  contain  various  values
          for CCCCAAAAEEEESSSSAAAARRRR____LLLL.

     -    the ``next'' state field (if any)  of  each  item  will
          contain values for CCCCAAAAEEEESSSSAAAARRRR____SSSS2222.

     -    the mark field (if any) is initialized to a bit  string
          of 0's.  The value of the formal parameter CCCCAAAAEEEESSSSAAAARRRR____OOOORRRRDDDDEEEERRRR



(C) INRIA     Last change: 2020/02/11 (version 1.6)             7






OPEN/CAESAR MANUAL                             caesar_edge(LOCAL)



          determines the order of the items of the  linked  list.
          Several cases are currently implemented:

     -    if CCCCAAAAEEEESSSSAAAARRRR____OOOORRRRDDDDEEEERRRR is equal to 0, the list order is  unde-
          fined.

     -    if CCCCAAAAEEEESSSSAAAARRRR____OOOORRRRDDDDEEEERRRR is equal to 1, the edge list is  sorted
          in  the same order as transitions are enumerated by the
          CCCCAAAAEEEESSSSAAAARRRR____IIIITTTTEEEERRRRAAAATTTTEEEE____SSSSTTTTAAAATTTTEEEE(((()))) procedure.

     -    if CCCCAAAAEEEESSSSAAAARRRR____OOOORRRRDDDDEEEERRRR is equal to 2, the edge list is  sorted
          in  the reverse order of the order in which transitions
          are enumerated by the CCCCAAAAEEEESSSSAAAARRRR____IIIITTTTEEEERRRRAAAATTTTEEEE____SSSSTTTTAAAATTTTEEEE(((()))) procedure.

     -    if CCCCAAAAEEEESSSSAAAARRRR____OOOORRRRDDDDEEEERRRR is equal to 3 or 5, the list is  sorted
          in such a way that the character string values returned
          by CCCCAAAAEEEESSSSAAAARRRR____SSSSTTTTRRRRIIIINNNNGGGG____LLLLAAAABBBBEEEELLLL(((()))) are increasing,  according  to
          the   lexicographical   order   used  in  the  function
          ssssttttrrrrccccmmmmpppp((((3333)))).

     -    if CCCCAAAAEEEESSSSAAAARRRR____OOOORRRRDDDDEEEERRRR is equal to 4 or 6, the list is  sorted
          in such a way that the character string values returned
          by CCCCAAAAEEEESSSSAAAARRRR____SSSSTTTTRRRRIIIINNNNGGGG____LLLLAAAABBBBEEEELLLL(((()))) are decreasing,  according  to
          the   lexicographical   order   used  in  the  function
          ssssttttrrrrccccmmmmpppp((((3333)))).

     Additionally,  this  procedure  sets  two  global  variables
     ccccaaaaeeeessssaaaarrrr____ccccrrrreeeeaaaattttiiiioooonnnn     and     ccccaaaaeeeessssaaaarrrr____ttttrrrruuuunnnnccccaaaattttiiiioooonnnn     of    type
     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL.      After      any       call       to
     CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTEEEE____EEEEDDDDGGGGEEEE____LLLLIIIISSSSTTTT(((()))),  these variables can be inspected
     using  the  two  functions  CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTIIIIOOOONNNN____EEEEDDDDGGGGEEEE____LLLLIIIISSSSTTTT(((())))  and
     CCCCAAAAEEEESSSSAAAARRRR____TTTTRRRRUUUUNNNNCCCCAAAATTTTIIIIOOOONNNN____EEEEDDDDGGGGEEEE____LLLLIIIISSSSTTTT(((())))  defined  below. The values of
     these variables are set as follows:


     -    if   the   computation    normally    succeeds,    then
          ccccaaaaeeeessssaaaarrrr____ccccrrrreeeeaaaattttiiiioooonnnn  is  set  to the number of items in the
          linked list and ccccaaaaeeeessssaaaarrrr____ttttrrrruuuunnnnccccaaaattttiiiioooonnnn is set to zero.

     -    if allocation fails when building the list  (due  to  a
          lack  of memory), a truncated list is built (the ``suc-
          cessor'' edge field of the last item is  still  set  to
          NNNNUUUULLLLLLLL).  Then  ccccaaaaeeeessssaaaarrrr____ccccrrrreeeeaaaattttiiiioooonnnn  is  set to the number of
          items in the truncated list  and  ccccaaaaeeeessssaaaarrrr____ttttrrrruuuunnnnccccaaaattttiiiioooonnnn  is
          set  to the number of items that have not been inserted
          in the list (this number is greater than zero).

      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____MMMMAAAAXXXX____OOOORRRRDDDDEEEERRRR____EEEEDDDDGGGGEEEE____LLLLIIIISSSSTTTT

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL CCCCAAAAEEEESSSSAAAARRRR____MMMMAAAAXXXX____OOOORRRRDDDDEEEERRRR____EEEEDDDDGGGGEEEE____LLLLIIIISSSSTTTT (((())))



(C) INRIA     Last change: 2020/02/11 (version 1.6)             8






OPEN/CAESAR MANUAL                             caesar_edge(LOCAL)



        {{{{ ............ }}}}

     This function returns the highest order available  for  edge
     list  creation,  i.e.,  the highest acceptable value for the
     parameter         CCCCAAAAEEEESSSSAAAARRRR____OOOORRRRDDDDEEEERRRR          of          function
     CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTEEEE____EEEEDDDDGGGGEEEE____LLLLIIIISSSSTTTT(((()))).

      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____DDDDEEEELLLLEEEETTTTEEEE____EEEEDDDDGGGGEEEE____LLLLIIIISSSSTTTT

     vvvvooooiiiidddd CCCCAAAAEEEESSSSAAAARRRR____DDDDEEEELLLLEEEETTTTEEEE____EEEEDDDDGGGGEEEE____LLLLIIIISSSSTTTT ((((CCCCAAAAEEEESSSSAAAARRRR____EEEE1111____EEEEnnnn))))
     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____EEEEDDDDGGGGEEEE ****CCCCAAAAEEEESSSSAAAARRRR____EEEE1111____EEEEnnnn;;;;
     {{{{ ............ }}}}

     This procedure frees each item of the linked list pointed to
     by  ****CCCCAAAAEEEESSSSAAAARRRR____EEEE1111____EEEEnnnn. Afterwards, the NNNNUUUULLLLLLLL value is assigned to
     ****CCCCAAAAEEEESSSSAAAARRRR____EEEE1111____EEEEnnnn.

      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____CCCCOOOOPPPPYYYY____EEEEDDDDGGGGEEEE____LLLLIIIISSSSTTTT

     vvvvooooiiiidddd CCCCAAAAEEEESSSSAAAARRRR____CCCCOOOOPPPPYYYY____EEEEDDDDGGGGEEEE____LLLLIIIISSSSTTTT ((((CCCCAAAAEEEESSSSAAAARRRR____EEEE1111____EEEEmmmm,,,, CCCCAAAAEEEESSSSAAAARRRR____EEEE1111____EEEEnnnn))))
     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____EEEEDDDDGGGGEEEE ****CCCCAAAAEEEESSSSAAAARRRR____EEEE1111____EEEEmmmm;;;;
     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____EEEEDDDDGGGGEEEE CCCCAAAAEEEESSSSAAAARRRR____EEEE1111____EEEEnnnn;;;;
     {{{{ ............ }}}}

     This procedure builds a duplicate list, which is a  copy  of
     the  linked  list  pointed  to by CCCCAAAAEEEESSSSAAAARRRR____EEEE1111____EEEEnnnn. A pointer to
     this duplicate list (or  NULL  if  the  list  is  empty)  is
     assigned  to ****CCCCAAAAEEEESSSSAAAARRRR____EEEE1111____EEEEmmmm. For each item of the linked list
     pointed to by CCCCAAAAEEEESSSSAAAARRRR____EEEE1111____EEEEnnnn, a duplicated item is  allocated.
     Said  differently,  both  lists  do not have shared items in
     common.

     Additionally,  this  procedure  sets  two  global  variables
     ccccaaaaeeeessssaaaarrrr____ccccrrrreeeeaaaattttiiiioooonnnn     and     ccccaaaaeeeessssaaaarrrr____ttttrrrruuuunnnnccccaaaattttiiiioooonnnn     of    type
     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL.      After      any       call       to
     CCCCAAAAEEEESSSSAAAARRRR____CCCCOOOOPPPPYYYY____EEEEDDDDGGGGEEEE____LLLLIIIISSSSTTTT(((()))),  these  variables  can be inspected
     using  the  two  functions  CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTIIIIOOOONNNN____EEEEDDDDGGGGEEEE____LLLLIIIISSSSTTTT(((())))  and
     CCCCAAAAEEEESSSSAAAARRRR____TTTTRRRRUUUUNNNNCCCCAAAATTTTIIIIOOOONNNN____EEEEDDDDGGGGEEEE____LLLLIIIISSSSTTTT(((())))  defined  below. The values of
     these variables are set as in the  CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTEEEE____EEEEDDDDGGGGEEEE____LLLLIIIISSSSTTTT(((())))
     function.

     The previous value of ****CCCCAAAAEEEESSSSAAAARRRR____EEEE1111____EEEEmmmm is lost: if it points to
     a   non-empty   list,   this  list  should  be  freed  using
     CCCCAAAAEEEESSSSAAAARRRR____DDDDEEEELLLLEEEETTTTEEEE____EEEEDDDDGGGGEEEE____LLLLIIIISSSSTTTT(((()))) before CCCCAAAAEEEESSSSAAAARRRR____CCCCOOOOPPPPYYYY____EEEEDDDDGGGGEEEE____LLLLIIIISSSSTTTT(((())))  is
     called.

      ............................................................




(C) INRIA     Last change: 2020/02/11 (version 1.6)             9






OPEN/CAESAR MANUAL                             caesar_edge(LOCAL)



  CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTIIIIOOOONNNN____EEEEDDDDGGGGEEEE____LLLLIIIISSSSTTTT

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTIIIIOOOONNNN____EEEEDDDDGGGGEEEE____LLLLIIIISSSSTTTT (((())))
        {{{{ ............ }}}}

     This function returns  the  value  of  the  global  variable
     ccccaaaaeeeessssaaaarrrr____ccccrrrreeeeaaaattttiiiioooonnnn   computed   during   the   last   call   to
     CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTEEEE____EEEEDDDDGGGGEEEE____LLLLIIIISSSSTTTT(((()))) or  CCCCAAAAEEEESSSSAAAARRRR____CCCCOOOOPPPPYYYY____EEEEDDDDGGGGEEEE____LLLLIIIISSSSTTTT(((()))).  This
     variable can only be accessed using this function.

      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____TTTTRRRRUUUUNNNNCCCCAAAATTTTIIIIOOOONNNN____EEEEDDDDGGGGEEEE____LLLLIIIISSSSTTTT

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL CCCCAAAAEEEESSSSAAAARRRR____TTTTRRRRUUUUNNNNCCCCAAAATTTTIIIIOOOONNNN____EEEEDDDDGGGGEEEE____LLLLIIIISSSSTTTT (((())))
        {{{{ ............ }}}}

     This function returns  the  value  of  the  global  variable
     ccccaaaaeeeessssaaaarrrr____ttttrrrruuuunnnnccccaaaattttiiiioooonnnn   computed   during   the   last  call  to
     CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTEEEE____EEEEDDDDGGGGEEEE____LLLLIIIISSSSTTTT(((())))  or  CCCCAAAAEEEESSSSAAAARRRR____CCCCOOOOPPPPYYYY____EEEEDDDDGGGGEEEE____LLLLIIIISSSSTTTT.   This
     variable can only be accessed using this function.

      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____FFFFOOOORRRRMMMMAAAATTTT____EEEEDDDDGGGGEEEE____LLLLIIIISSSSTTTT

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____FFFFOOOORRRRMMMMAAAATTTT CCCCAAAAEEEESSSSAAAARRRR____FFFFOOOORRRRMMMMAAAATTTT____EEEEDDDDGGGGEEEE____LLLLIIIISSSSTTTT ((((CCCCAAAAEEEESSSSAAAARRRR____FFFFOOOORRRRMMMMAAAATTTT))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____FFFFOOOORRRRMMMMAAAATTTT CCCCAAAAEEEESSSSAAAARRRR____FFFFOOOORRRRMMMMAAAATTTT;;;;
        {{{{ ............ }}}}

     This function allows to control the format under which  edge
     lists  are printed by the procedure CCCCAAAAEEEESSSSAAAARRRR____PPPPRRRRIIIINNNNTTTT____EEEEDDDDGGGGEEEE____LLLLIIIISSSSTTTT(((())))
     (see below). Currently, the following formats are available:


     -    With format 0, the edge list is printed as a portion of
          text. This is mainly intended for debugging purpose.

     -    (no other format available yet)

     A call to this function sets the current edge list format to
     CCCCAAAAEEEESSSSAAAARRRR____FFFFOOOORRRRMMMMAAAATTTT.

     When called with CCCCAAAAEEEESSSSAAAARRRR____FFFFOOOORRRRMMMMAAAATTTT between 0 and 0,  this  fonc-
     tion  sets the current edge list format to CCCCAAAAEEEESSSSAAAARRRR____FFFFOOOORRRRMMMMAAAATTTT and
     returns an undefined result.

     When called with another value of CCCCAAAAEEEESSSSAAAARRRR____FFFFOOOORRRRMMMMAAAATTTT, this  func-
     tion  does  not  modify  the  current  edge  list format but
     returns a result defined as  follows.  If  CCCCAAAAEEEESSSSAAAARRRR____FFFFOOOORRRRMMMMAAAATTTT  is
     equal  to  the constant CCCCAAAAEEEESSSSAAAARRRR____CCCCUUUURRRRRRRREEEENNNNTTTT____FFFFOOOORRRRMMMMAAAATTTT, the result is
     the value of the current edge list format. If  CCCCAAAAEEEESSSSAAAARRRR____FFFFOOOORRRRMMMMAAAATTTT



(C) INRIA     Last change: 2020/02/11 (version 1.6)            10






OPEN/CAESAR MANUAL                             caesar_edge(LOCAL)



     is  equal  to the constant CCCCAAAAEEEESSSSAAAARRRR____MMMMAAAAXXXXIIIIMMMMAAAALLLL____FFFFOOOORRRRMMMMAAAATTTT, the result
     is the maximal format value (i.e., 0). In all  other  cases,
     the effect of this function is undefined.

      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____MMMMAAAAXXXX____FFFFOOOORRRRMMMMAAAATTTT____EEEEDDDDGGGGEEEE____LLLLIIIISSSSTTTT

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____FFFFOOOORRRRMMMMAAAATTTT CCCCAAAAEEEESSSSAAAARRRR____MMMMAAAAXXXX____FFFFOOOORRRRMMMMAAAATTTT____EEEEDDDDGGGGEEEE____LLLLIIIISSSSTTTT (((())))
        {{{{ ............ }}}}

     Caution! This function is deprecated. It should no longer be
     used,  as  it  might  be removed from future versions of the
     _O_P_E_N/_C_A_E_S_A_R. Use function CCCCAAAAEEEESSSSAAAARRRR____FFFFOOOORRRRMMMMAAAATTTT____EEEEDDDDGGGGEEEE____LLLLIIIISSSSTTTT(((()))) instead,
     called with argument CCCCAAAAEEEESSSSAAAARRRR____MMMMAAAAXXXXIIIIMMMMAAAALLLL____FFFFOOOORRRRMMMMAAAATTTT.

     This function returns the maximal format value available for
     printing edge lists.

      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____PPPPRRRRIIIINNNNTTTT____EEEEDDDDGGGGEEEE____LLLLIIIISSSSTTTT

     vvvvooooiiiidddd CCCCAAAAEEEESSSSAAAARRRR____PPPPRRRRIIIINNNNTTTT____EEEEDDDDGGGGEEEE____LLLLIIIISSSSTTTT ((((CCCCAAAAEEEESSSSAAAARRRR____FFFFIIIILLLLEEEE,,,, CCCCAAAAEEEESSSSAAAARRRR____EEEE1111____EEEEnnnn))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____FFFFIIIILLLLEEEE CCCCAAAAEEEESSSSAAAARRRR____FFFFIIIILLLLEEEE;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____EEEEDDDDGGGGEEEE CCCCAAAAEEEESSSSAAAARRRR____EEEE1111____EEEEnnnn;;;;
        {{{{ ............ }}}}

     This procedure prints to file CCCCAAAAEEEESSSSAAAARRRR____FFFFIIIILLLLEEEE information  about
     the  contents  of  the  linked  list  of edges pointed to by
     CCCCAAAAEEEESSSSAAAARRRR____EEEE1111____EEEEnnnn. The nature of the information is determined by
     the  current  edge  format  and the current edge list format
     (see       procedures        CCCCAAAAEEEESSSSAAAARRRR____FFFFOOOORRRRMMMMAAAATTTT____EEEEDDDDGGGGEEEE(((())))        and
     CCCCAAAAEEEESSSSAAAARRRR____FFFFOOOORRRRMMMMAAAATTTT____EEEEDDDDGGGGEEEE____LLLLIIIISSSSTTTT(((()))) above).

     Before this procedure is called, CCCCAAAAEEEESSSSAAAARRRR____FFFFIIIILLLLEEEE must have  been
     properly opened, for instance using ffffooooppppeeeennnn((((3333)))).

      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____IIIITTTTEEEERRRRAAAATTTTEEEE____PPPPLLLLNNNNMMMM____EEEEDDDDGGGGEEEE____LLLLIIIISSSSTTTT

     ####ddddeeeeffffiiiinnnneeee CCCCAAAAEEEESSSSAAAARRRR____IIIITTTTEEEERRRRAAAATTTTEEEE____PPPPLLLLNNNNMMMM____EEEEDDDDGGGGEEEE____LLLLIIIISSSSTTTT((((CCCCAAAAEEEESSSSAAAARRRR____EEEE1111____EEEEnnnn,,,,CCCCAAAAEEEESSSSAAAARRRR____EEEE,,,,\\\\
                         CCCCAAAAEEEESSSSAAAARRRR____SSSS1111,,,,CCCCAAAAEEEESSSSAAAARRRR____LLLL,,,,CCCCAAAAEEEESSSSAAAARRRR____SSSS2222,,,,CCCCAAAAEEEESSSSAAAARRRR____MMMM)))) ............

     with parameters typed as follows:

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____EEEEDDDDGGGGEEEE CCCCAAAAEEEESSSSAAAARRRR____EEEE1111____EEEEnnnn;;;;
     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____EEEEDDDDGGGGEEEE CCCCAAAAEEEESSSSAAAARRRR____EEEE;;;;
     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSTTTTAAAATTTTEEEE CCCCAAAAEEEESSSSAAAARRRR____SSSS1111;;;;
     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____LLLLAAAABBBBEEEELLLL CCCCAAAAEEEESSSSAAAARRRR____LLLL;;;;
     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSTTTTAAAATTTTEEEE CCCCAAAAEEEESSSSAAAARRRR____SSSS2222;;;;



(C) INRIA     Last change: 2020/02/11 (version 1.6)            11






OPEN/CAESAR MANUAL                             caesar_edge(LOCAL)



     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____PPPPOOOOIIIINNNNTTTTEEEERRRR CCCCAAAAEEEESSSSAAAARRRR____MMMM;;;;

     This macro-definition is an iterator which can  be  used  in
     the  same  way  as  a  wwwwhhhhiiiilllleeee  ((((............))))  or  ffffoooorrrr ((((............;;;; ............;;;; ............))))
     instruction. It is therefore possible to write  an  instruc-
     tion such as:

             CCCCAAAAEEEESSSSAAAARRRR____IIIITTTTEEEERRRRAAAATTTTEEEE____PPPPLLLLNNNNMMMM____EEEEDDDDGGGGEEEE____LLLLIIIISSSSTTTT((((ccccaaaaeeeessssaaaarrrr____eeee1111____eeeennnn,,,,ccccaaaaeeeessssaaaarrrr____eeee,,,,
                         ccccaaaaeeeessssaaaarrrr____ssss1111,,,,ccccaaaaeeeessssaaaarrrr____llll,,,,ccccaaaaeeeessssaaaarrrr____ssss2222,,,,ccccaaaaeeeessssaaaarrrr____mmmm)))) {{{{
             ............
             bbbbooooddddyyyy ooooffff tttthhhheeee lllloooooooopppp,,,, ccccoooonnnnttttaaaaiiiinnnniiiinnnngggg ooooccccccccuuuurrrrrrrreeeennnncccceeeessss ooooffff vvvvaaaarrrriiiiaaaabbbblllleeeessss
             ccccaaaaeeeessssaaaarrrr____eeee,,,, ccccaaaaeeeessssaaaarrrr____ssss1111,,,, ccccaaaaeeeessssaaaarrrr____llll,,,, ccccaaaaeeeessssaaaarrrr____ssss2222,,,, aaaannnndddd ccccaaaaeeeessssaaaarrrr____mmmm
             ............
             }}}}

     CCCCAAAAEEEESSSSAAAARRRR____EEEE1111____EEEEnnnn is an expression (r-value) containing a pointer
     to the first item of a linked list of edges.

     CCCCAAAAEEEESSSSAAAARRRR____EEEE is a variable (l-value) which will be used  as  the
     induction  variable  in  the  body  of the loop. At the n-th
     iteration step, it points to the n-th  item  of  the  linked
     list.

     CCCCAAAAEEEESSSSAAAARRRR____SSSS1111 is a variable (l-value) which can also be used  as
     an induction variable. At the n-th iteration step, it points
     to the ``previous'' state field of  the  n-th  item  of  the
     linked  list.  If  this  field does not exist, the result is
     undefined. At each step, one has:

          CCCCAAAAEEEESSSSAAAARRRR____SSSS1111 == CCCCAAAAEEEESSSSAAAARRRR____PPPPRRRREEEEVVVVIIIIOOOOUUUUSSSS____SSSSTTTTAAAATTTTEEEE____EEEEDDDDGGGGEEEE ((((CCCCAAAAEEEESSSSAAAARRRR____EEEE))))


     CCCCAAAAEEEESSSSAAAARRRR____LLLL is a variable (l-value) which can also be  used  as
     an induction variable. At the n-th iteration step, it points
     to the label field of the n-th item of the linked  list.  If
     this  field does not exist, the result is undefined. At each
     step, one has:

               CCCCAAAAEEEESSSSAAAARRRR____LLLL == CCCCAAAAEEEESSSSAAAARRRR____LLLLAAAABBBBEEEELLLL____EEEEDDDDGGGGEEEE ((((CCCCAAAAEEEESSSSAAAARRRR____EEEE))))


     CCCCAAAAEEEESSSSAAAARRRR____SSSS2222 is a variable (l-value) which can also be used  as
     an induction variable. At the n-th iteration step, it points
     to the ``next'' state field of the n-th item of  the  linked
     list. If this field does not exist, the result is undefined.
     At each step, one has:

            CCCCAAAAEEEESSSSAAAARRRR____SSSS2222 == CCCCAAAAEEEESSSSAAAARRRR____NNNNEEEEXXXXTTTT____SSSSTTTTAAAATTTTEEEE____EEEEDDDDGGGGEEEE ((((CCCCAAAAEEEESSSSAAAARRRR____EEEE))))


     CCCCAAAAEEEESSSSAAAARRRR____MMMM is a variable (l-value) which can also be  used  as
     an induction variable. At the n-th iteration step, it points



(C) INRIA     Last change: 2020/02/11 (version 1.6)            12






OPEN/CAESAR MANUAL                             caesar_edge(LOCAL)



     to the mark field of the n-th item of the  linked  list.  If
     this  field does not exist, the result is undefined. At each
     step, one has:

               CCCCAAAAEEEESSSSAAAARRRR____MMMM == CCCCAAAAEEEESSSSAAAARRRR____MMMMAAAARRRRKKKK____EEEEDDDDGGGGEEEE ((((CCCCAAAAEEEESSSSAAAARRRR____EEEE))))


     The body of the loop can be any statement of the C language.
     In  particular, it may contain bbbbrrrreeeeaaaakkkk and ccccoooonnnnttttiiiinnnnuuuueeee statements
     with their usual semantics.

     This is the most general iterator on linked lists of  edges.
     There  are  also 15 other iterators derived from the general
     one. These iterators are simpler than the general one, since
     they deal with the cases where one or several of the follow-
     ing parameters:

             CCCCAAAAEEEESSSSAAAARRRR____SSSS1111,  CCCCAAAAEEEESSSSAAAARRRR____LLLL,  CCCCAAAAEEEESSSSAAAARRRR____SSSS2222,  CCCCAAAAEEEESSSSAAAARRRR____MMMM

     are omitted. These operators are used according to the needs
     (for  example,  the  four  aforementioned  parameters can be
     omitted if one only wants to compute the length of  an  edge
     list)  and also depending on the initialization values given
     to CCCCAAAAEEEESSSSAAAARRRR____IIIINNNNIIIITTTT____EEEEDDDDGGGGEEEE(((()))) (since one or several fields  may  not
     actually exist).

     The 15 derived iterators are listed below.


     ####ddddeeeeffffiiiinnnneeee CCCCAAAAEEEESSSSAAAARRRR____IIIITTTTEEEERRRRAAAATTTTEEEE____EEEEDDDDGGGGEEEE____LLLLIIIISSSSTTTT((((CCCCAAAAEEEESSSSAAAARRRR____EEEE1111____EEEEnnnn,,,,CCCCAAAAEEEESSSSAAAARRRR____EEEE)))) ............

     ####ddddeeeeffffiiiinnnneeee CCCCAAAAEEEESSSSAAAARRRR____IIIITTTTEEEERRRRAAAATTTTEEEE____PPPP____EEEEDDDDGGGGEEEE____LLLLIIIISSSSTTTT((((CCCCAAAAEEEESSSSAAAARRRR____EEEE1111____EEEEnnnn,,,,CCCCAAAAEEEESSSSAAAARRRR____EEEE,,,,CCCCAAAAEEEESSSSAAAARRRR____SSSS1111)))) ............

     ####ddddeeeeffffiiiinnnneeee CCCCAAAAEEEESSSSAAAARRRR____IIIITTTTEEEERRRRAAAATTTTEEEE____LLLL____EEEEDDDDGGGGEEEE____LLLLIIIISSSSTTTT((((CCCCAAAAEEEESSSSAAAARRRR____EEEE1111____EEEEnnnn,,,,CCCCAAAAEEEESSSSAAAARRRR____EEEE,,,,CCCCAAAAEEEESSSSAAAARRRR____LLLL)))) ............

     ####ddddeeeeffffiiiinnnneeee CCCCAAAAEEEESSSSAAAARRRR____IIIITTTTEEEERRRRAAAATTTTEEEE____NNNN____EEEEDDDDGGGGEEEE____LLLLIIIISSSSTTTT((((CCCCAAAAEEEESSSSAAAARRRR____EEEE1111____EEEEnnnn,,,,CCCCAAAAEEEESSSSAAAARRRR____EEEE,,,,CCCCAAAAEEEESSSSAAAARRRR____SSSS2222)))) ............

     ####ddddeeeeffffiiiinnnneeee CCCCAAAAEEEESSSSAAAARRRR____IIIITTTTEEEERRRRAAAATTTTEEEE____MMMM____EEEEDDDDGGGGEEEE____LLLLIIIISSSSTTTT((((CCCCAAAAEEEESSSSAAAARRRR____EEEE1111____EEEEnnnn,,,,CCCCAAAAEEEESSSSAAAARRRR____EEEE,,,,CCCCAAAAEEEESSSSAAAARRRR____MMMM)))) ............

     ####ddddeeeeffffiiiinnnneeee CCCCAAAAEEEESSSSAAAARRRR____IIIITTTTEEEERRRRAAAATTTTEEEE____PPPPLLLL____EEEEDDDDGGGGEEEE____LLLLIIIISSSSTTTT((((CCCCAAAAEEEESSSSAAAARRRR____EEEE1111____EEEEnnnn,,,,CCCCAAAAEEEESSSSAAAARRRR____EEEE,,,,CCCCAAAAEEEESSSSAAAARRRR____SSSS1111,,,,CCCCAAAAEEEESSSSAAAARRRR____LLLL)))) ............

     ####ddddeeeeffffiiiinnnneeee CCCCAAAAEEEESSSSAAAARRRR____IIIITTTTEEEERRRRAAAATTTTEEEE____PPPPNNNN____EEEEDDDDGGGGEEEE____LLLLIIIISSSSTTTT((((CCCCAAAAEEEESSSSAAAARRRR____EEEE1111____EEEEnnnn,,,,CCCCAAAAEEEESSSSAAAARRRR____EEEE,,,,CCCCAAAAEEEESSSSAAAARRRR____SSSS1111,,,,CCCCAAAAEEEESSSSAAAARRRR____SSSS2222)))) ............

     ####ddddeeeeffffiiiinnnneeee CCCCAAAAEEEESSSSAAAARRRR____IIIITTTTEEEERRRRAAAATTTTEEEE____PPPPMMMM____EEEEDDDDGGGGEEEE____LLLLIIIISSSSTTTT((((CCCCAAAAEEEESSSSAAAARRRR____EEEE1111____EEEEnnnn,,,,CCCCAAAAEEEESSSSAAAARRRR____EEEE,,,,CCCCAAAAEEEESSSSAAAARRRR____SSSS1111,,,,CCCCAAAAEEEESSSSAAAARRRR____MMMM)))) ............

     ####ddddeeeeffffiiiinnnneeee CCCCAAAAEEEESSSSAAAARRRR____IIIITTTTEEEERRRRAAAATTTTEEEE____LLLLNNNN____EEEEDDDDGGGGEEEE____LLLLIIIISSSSTTTT((((CCCCAAAAEEEESSSSAAAARRRR____EEEE1111____EEEEnnnn,,,,CCCCAAAAEEEESSSSAAAARRRR____EEEE,,,,CCCCAAAAEEEESSSSAAAARRRR____LLLL,,,,CCCCAAAAEEEESSSSAAAARRRR____SSSS2222)))) ............

     ####ddddeeeeffffiiiinnnneeee CCCCAAAAEEEESSSSAAAARRRR____IIIITTTTEEEERRRRAAAATTTTEEEE____LLLLMMMM____EEEEDDDDGGGGEEEE____LLLLIIIISSSSTTTT((((CCCCAAAAEEEESSSSAAAARRRR____EEEE1111____EEEEnnnn,,,,CCCCAAAAEEEESSSSAAAARRRR____EEEE,,,,CCCCAAAAEEEESSSSAAAARRRR____LLLL,,,,CCCCAAAAEEEESSSSAAAARRRR____MMMM)))) ............

     ####ddddeeeeffffiiiinnnneeee CCCCAAAAEEEESSSSAAAARRRR____IIIITTTTEEEERRRRAAAATTTTEEEE____NNNNMMMM____EEEEDDDDGGGGEEEE____LLLLIIIISSSSTTTT((((CCCCAAAAEEEESSSSAAAARRRR____EEEE1111____EEEEnnnn,,,,CCCCAAAAEEEESSSSAAAARRRR____EEEE,,,,CCCCAAAAEEEESSSSAAAARRRR____SSSS2222,,,,CCCCAAAAEEEESSSSAAAARRRR____MMMM)))) ............

     ####ddddeeeeffffiiiinnnneeee CCCCAAAAEEEESSSSAAAARRRR____IIIITTTTEEEERRRRAAAATTTTEEEE____PPPPLLLLNNNN____EEEEDDDDGGGGEEEE____LLLLIIIISSSSTTTT((((CCCCAAAAEEEESSSSAAAARRRR____EEEE1111____EEEEnnnn,,,,CCCCAAAAEEEESSSSAAAARRRR____EEEE,,,,CCCCAAAAEEEESSSSAAAARRRR____SSSS1111,,,,CCCCAAAAEEEESSSSAAAARRRR____LLLL,,,,CCCCAAAAEEEESSSSAAAARRRR____SSSS2222)))) ............



(C) INRIA     Last change: 2020/02/11 (version 1.6)            13






OPEN/CAESAR MANUAL                             caesar_edge(LOCAL)




     ####ddddeeeeffffiiiinnnneeee CCCCAAAAEEEESSSSAAAARRRR____IIIITTTTEEEERRRRAAAATTTTEEEE____PPPPLLLLMMMM____EEEEDDDDGGGGEEEE____LLLLIIIISSSSTTTT((((CCCCAAAAEEEESSSSAAAARRRR____EEEE1111____EEEEnnnn,,,,CCCCAAAAEEEESSSSAAAARRRR____EEEE,,,,CCCCAAAAEEEESSSSAAAARRRR____SSSS1111,,,,CCCCAAAAEEEESSSSAAAARRRR____LLLL,,,,CCCCAAAAEEEESSSSAAAARRRR____MMMM)))) ............

     ####ddddeeeeffffiiiinnnneeee CCCCAAAAEEEESSSSAAAARRRR____IIIITTTTEEEERRRRAAAATTTTEEEE____PPPPNNNNMMMM____EEEEDDDDGGGGEEEE____LLLLIIIISSSSTTTT((((CCCCAAAAEEEESSSSAAAARRRR____EEEE1111____EEEEnnnn,,,,CCCCAAAAEEEESSSSAAAARRRR____EEEE,,,,CCCCAAAAEEEESSSSAAAARRRR____SSSS1111,,,,CCCCAAAAEEEESSSSAAAARRRR____SSSS2222,,,,CCCCAAAAEEEESSSSAAAARRRR____MMMM)))) ............

     ####ddddeeeeffffiiiinnnneeee CCCCAAAAEEEESSSSAAAARRRR____IIIITTTTEEEERRRRAAAATTTTEEEE____LLLLNNNNMMMM____EEEEDDDDGGGGEEEE____LLLLIIIISSSSTTTT((((CCCCAAAAEEEESSSSAAAARRRR____EEEE1111____EEEEnnnn,,,,CCCCAAAAEEEESSSSAAAARRRR____EEEE,,,,CCCCAAAAEEEESSSSAAAARRRR____LLLL,,,,CCCCAAAAEEEESSSSAAAARRRR____SSSS2222,,,,CCCCAAAAEEEESSSSAAAARRRR____MMMM)))) ............


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____LLLLEEEENNNNGGGGTTTTHHHH____EEEEDDDDGGGGEEEE____LLLLIIIISSSSTTTT

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL CCCCAAAAEEEESSSSAAAARRRR____LLLLEEEENNNNGGGGTTTTHHHH____EEEEDDDDGGGGEEEE____LLLLIIIISSSSTTTT ((((CCCCAAAAEEEESSSSAAAARRRR____EEEE1111____EEEEnnnn))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____EEEEDDDDGGGGEEEE CCCCAAAAEEEESSSSAAAARRRR____EEEE1111____EEEEnnnn;;;;
        {{{{ ............ }}}}

     This function returns the number of items in the linked list
     pointed to by CCCCAAAAEEEESSSSAAAARRRR____EEEE1111____EEEEnnnn.

      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____IIIITTTTEEEEMMMM____EEEEDDDDGGGGEEEE____LLLLIIIISSSSTTTT

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____EEEEDDDDGGGGEEEE CCCCAAAAEEEESSSSAAAARRRR____IIIITTTTEEEEMMMM____EEEEDDDDGGGGEEEE____LLLLIIIISSSSTTTT ((((CCCCAAAAEEEESSSSAAAARRRR____EEEE1111____EEEEnnnn,,,, CCCCAAAAEEEESSSSAAAARRRR____NNNN))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____EEEEDDDDGGGGEEEE CCCCAAAAEEEESSSSAAAARRRR____EEEE1111____EEEEnnnn;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL CCCCAAAAEEEESSSSAAAARRRR____NNNN;;;;
        {{{{ ............ }}}}

     This function returns the CCCCAAAAEEEESSSSAAAARRRR____NNNN-th  item  in  the  linked
     list  pointed to by CCCCAAAAEEEESSSSAAAARRRR____EEEE1111____EEEEnnnn (the first item is numbered
     1). If CCCCAAAAEEEESSSSAAAARRRR____NNNN is equal to 0, or is greater than the actual
     length of the linked list, the result is undefined.

      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____RRRREEEEVVVVEEEERRRRSSSSEEEE____EEEEDDDDGGGGEEEE____LLLLIIIISSSSTTTT

     vvvvooooiiiidddd CCCCAAAAEEEESSSSAAAARRRR____RRRREEEEVVVVEEEERRRRSSSSEEEE____EEEEDDDDGGGGEEEE____LLLLIIIISSSSTTTT ((((CCCCAAAAEEEESSSSAAAARRRR____EEEE1111____EEEEnnnn))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____EEEEDDDDGGGGEEEE ****CCCCAAAAEEEESSSSAAAARRRR____EEEE1111____EEEEnnnn;;;;
        {{{{ ............ }}}}

     This procedure reverses the linked list of edges pointed  to
     by ****CCCCAAAAEEEESSSSAAAARRRR____EEEE1111____EEEEnnnn.

      ............................................................

AAAAUUUUTTTTHHHHOOOORRRR((((SSSS))))
     Hubert Garavel

FFFFIIIILLLLEEEESSSS
     $$$$CCCCAAAADDDDPPPP////iiiinnnnccccllll////ccccaaaaeeeessssaaaarrrr____ggggrrrraaaapppphhhh....hhhh     interface of the graph module
     $$$$CCCCAAAADDDDPPPP////iiiinnnnccccllll////ccccaaaaeeeessssaaaarrrr____****....hhhh         interfaces  of   the   storage



(C) INRIA     Last change: 2020/02/11 (version 1.6)            14






OPEN/CAESAR MANUAL                             caesar_edge(LOCAL)



                                   module
     $$$$CCCCAAAADDDDPPPP////bbbbiiiinnnn....````aaaarrrrcccchhhh````////lllliiiibbbbccccaaaaeeeessssaaaarrrr....aaaa  object  code  of  the  storage
                                   module
     $$$$CCCCAAAADDDDPPPP////ssssrrrrcccc////ooooppppeeeennnn____ccccaaaaeeeessssaaaarrrr////****....cccc     source   code    of    various
                                   exploration modules
     $$$$CCCCAAAADDDDPPPP////ccccoooommmm////lllloooottttoooossss....ooooppppeeeennnn          shell    script     to     run
                                   OPEN/CAESAR

SSSSEEEEEEEE AAAALLLLSSSSOOOO
     Reference Manuals of OPEN/CAESAR,  CAESAR,  and  CAESAR.ADT,
     lllloooottttoooossss....ooooppppeeeennnn(LOCAL), ccccaaaaeeeessssaaaarrrr(LOCAL), ccccaaaaeeeessssaaaarrrr....aaaaddddtttt(LOCAL)

     Additional information is available from the CADP  Web  page
     located at http://cadp.inria.fr

     Directives   for   installation   are   given    in    files
     $$$$CCCCAAAADDDDPPPP////IIIINNNNSSSSTTTTAAAALLLLLLLLAAAATTTTIIIIOOOONNNN____****....

     Recent  changes  and  improvements  to  this  software   are
     reported and commented in file $$$$CCCCAAAADDDDPPPP////HHHHIIIISSSSTTTTOOOORRRRYYYY....

BBBBUUUUGGGGSSSS
     Known  bugs  are  described  in  the  Reference  Manual   of
     OPEN/CAESAR.  Please report new bugs to cadp@inria.fr































(C) INRIA     Last change: 2020/02/11 (version 1.6)            15



