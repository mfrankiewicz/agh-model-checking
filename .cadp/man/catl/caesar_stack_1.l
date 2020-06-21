


OPEN/CAESAR MANUAL                          caesar_stack_1(LOCAL)



NNNNAAAAMMMMEEEE
     caesar_stack_1 - the ``stack_1'' library of OPEN/CAESAR

PPPPUUUURRRRPPPPOOOOSSSSEEEE
     The ``stack_1'' library provides primitives for  managing  a
     stack when performing depth-first search in the state graph.



UUUUSSSSAAAAGGGGEEEE
     The ``stack_1'' library consists of:

     -    a predefined header file ccccaaaaeeeessssaaaarrrr____ssssttttaaaacccckkkk____1111....hhhh;

     -    the precompiled library file lllliiiibbbbccccaaaaeeeessssaaaarrrr....aaaa, which  imple-
          ments the features described in ccccaaaaeeeessssaaaarrrr____ssssttttaaaacccckkkk____1111....hhhh.

     Note: The ``stack_1'' library  is  a  software  layer  built
     above   the  primitives  offered  by  the  ``standard''  and
     ``edge'' libraries, and by the _O_P_E_N/_C_A_E_S_A_R graph module.

     Note:  The  ``stack_1''  library  relies  on  the   ``edge''
     library.  Therefore,  when  using  the  ``stack_1'' library,
     there are restrictions concerning the use  of  the  ``edge''
     library  primitives.  These  restrictions  are listed in the
     sequel.



DDDDEEEESSSSCCCCRRRRIIIIPPPPTTTTIIIIOOOONNNN
     Each item in the stack is basically a tuple with 3 fields:

     -    (1) a ``label'' field containing a label,

     -    (2) a ``state'' field containing a state,

     -    (3) an ``edge'' field containing a list of  edges  (see
          the ``edge'' library).

     There is no constraint on the contents of these fields. Yet,
     if  the  stack is used for a depth-first search in the state
     graph (see below) it is likely that the following invariants
     hold:


     -    the state field of the stack base is the initial  state
          of the graph;

     -    the label field of the stack base is undefined;

     -    the state field of the stack top is the current state;




(C) INRIA     Last change: 2020/02/11 (version 1.6)             1






OPEN/CAESAR MANUAL                          caesar_stack_1(LOCAL)



     -    the label and state fields of the stack  determine  the
          path  leading  from  the  initial  state to the current
          state. If, for a given stack item (different  from  the
          top),  the state field is equal to S_1, and if, for the
          immediately above  stack  item,  the  label  and  state
          fields  are  respectively  equal  to  L  and  S_2, then
          ``(S_1, L, S_2)'' is an edge of the graph;

     -    if, for a given stack item, the state field is equal to
          S, then the ``edge'' field of this item contains a list
          of edges outgoing from state S; more precisely,  it  is
          the list of edges that have not been explored yet.

     -    the lists of edges associated to the  stack  items  are
          pairwise  disjoint.  Said  differently, the edge fields
          respectively attached to different stack items  do  not
          have shared items in common.

FFFFEEEEAAAATTTTUUUURRRREEEESSSS
      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSTTTTAAAACCCCKKKK____1111

     ttttyyyyppppeeeeddddeeeeffff CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____AAAABBBBSSSSTTTTRRRRAAAACCCCTTTT ((((............)))) CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSTTTTAAAACCCCKKKK____1111;;;;

     This type denotes a pointer to the  concrete  representation
     of  a  stack.  The  stack  representation  is supposed to be
     ``opaque''.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____OOOOVVVVEEEERRRRFFFFLLLLOOOOWWWW____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN____SSSSTTTTAAAACCCCKKKK____1111

     ttttyyyyppppeeeeddddeeeeffff vvvvooooiiiidddd ((((****CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____OOOOVVVVEEEERRRRFFFFLLLLOOOOWWWW____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN____SSSSTTTTAAAACCCCKKKK____1111)))) ((((CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSTTTTAAAACCCCKKKK____1111))));;;;

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____OOOOVVVVEEEERRRRFFFFLLLLOOOOWWWW____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN____SSSSTTTTAAAACCCCKKKK____1111 is the ``pointer to an
     overflow  procedure''  type used in the ``stack_1'' library.
     An  overflow  procedure  takes   one   parameter   of   type
     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSTTTTAAAACCCCKKKK____1111.  Examples  of  overflow  procedures are
     CCCCAAAAEEEESSSSAAAARRRR____OOOOVVVVEEEERRRRFFFFLLLLOOOOWWWW____SSSSIIIIGGGGNNNNAAAALLLL____SSSSTTTTAAAACCCCKKKK____1111(((()))),
     CCCCAAAAEEEESSSSAAAARRRR____OOOOVVVVEEEERRRRFFFFLLLLOOOOWWWW____AAAABBBBOOOORRRRTTTT____SSSSTTTTAAAACCCCKKKK____1111(((()))),                         and
     CCCCAAAAEEEESSSSAAAARRRR____OOOOVVVVEEEERRRRFFFFLLLLOOOOWWWW____IIIIGGGGNNNNOOOORRRREEEE____SSSSTTTTAAAACCCCKKKK____1111(((()))) defined below.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____OOOOVVVVEEEERRRRFFFFLLLLOOOOWWWW____SSSSIIIIGGGGNNNNAAAALLLL____SSSSTTTTAAAACCCCKKKK____1111

     vvvvooooiiiidddd CCCCAAAAEEEESSSSAAAARRRR____OOOOVVVVEEEERRRRFFFFLLLLOOOOWWWW____SSSSIIIIGGGGNNNNAAAALLLL____SSSSTTTTAAAACCCCKKKK____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____KKKK))))
         CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSTTTTAAAACCCCKKKK____1111 CCCCAAAAEEEESSSSAAAARRRR____KKKK;;;;
        {{{{ ............ }}}}



(C) INRIA     Last change: 2020/02/11 (version 1.6)             2






OPEN/CAESAR MANUAL                          caesar_stack_1(LOCAL)



     This procedure is a possible action that can be performed in
     case  the  stack  pointed  to by CCCCAAAAEEEESSSSAAAARRRR____KKKK overflows (because
     there is not enough memory to store new items).

     It first prints an error message to the standard output, and
     also  various  statistics  about  the  stack  (including the
     number of items that could not be stored in  memory).  Then,
     it  returns.  Practically,  this means that some portions of
     the graph will not be explored, but an error message will be
     issued.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____OOOOVVVVEEEERRRRFFFFLLLLOOOOWWWW____AAAABBBBOOOORRRRTTTT____SSSSTTTTAAAACCCCKKKK____1111

     vvvvooooiiiidddd CCCCAAAAEEEESSSSAAAARRRR____OOOOVVVVEEEERRRRFFFFLLLLOOOOWWWW____AAAABBBBOOOORRRRTTTT____SSSSTTTTAAAACCCCKKKK____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____KKKK))))
         CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSTTTTAAAACCCCKKKK____1111 CCCCAAAAEEEESSSSAAAARRRR____KKKK;;;;
        {{{{ ............ }}}}

     This procedure is a possible action that can be performed in
     case  the  stack  pointed  to by CCCCAAAAEEEESSSSAAAARRRR____KKKK overflows (because
     there is not enough memory to store new items).

     It first prints an error message to the standard output, and
     also  various  statistics  about  the  stack  (including the
     number of items that could not be stored in  memory).  Then,
     it  aborts  the  program  using  the C function eeeexxxxiiiitttt((((3333)))). The
     error code 1 is returned.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____OOOOVVVVEEEERRRRFFFFLLLLOOOOWWWW____IIIIGGGGNNNNOOOORRRREEEE____SSSSTTTTAAAACCCCKKKK____1111

     vvvvooooiiiidddd CCCCAAAAEEEESSSSAAAARRRR____OOOOVVVVEEEERRRRFFFFLLLLOOOOWWWW____IIIIGGGGNNNNOOOORRRREEEE____SSSSTTTTAAAACCCCKKKK____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____KKKK))))
         CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSTTTTAAAACCCCKKKK____1111 CCCCAAAAEEEESSSSAAAARRRR____KKKK;;;;
        {{{{ ............ }}}}

     This procedure is a possible action that can be performed in
     case  the  stack  pointed  to by CCCCAAAAEEEESSSSAAAARRRR____KKKK overflows (because
     there is not enough memory to store new items).

     This procedure does nothing and returns.  Practically,  this
     means  that some portions of the graph will not be explored;
     they are silently ignored.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____IIIINNNNIIIITTTT____SSSSTTTTAAAACCCCKKKK____1111




(C) INRIA     Last change: 2020/02/11 (version 1.6)             3






OPEN/CAESAR MANUAL                          caesar_stack_1(LOCAL)



     vvvvooooiiiidddd CCCCAAAAEEEESSSSAAAARRRR____IIIINNNNIIIITTTT____SSSSTTTTAAAACCCCKKKK____1111 (((())))
        {{{{ ............ }}}}

     This initialization procedure must be  called  before  using
     any other primitive of the ``stack_1'' library.

     This procedure calls internally the initialization procedure
     of the ``edge'' library; the call is done as follows:

 CCCCAAAAEEEESSSSAAAARRRR____IIIINNNNIIIITTTT____EEEEDDDDGGGGEEEE ((((0000,,,, 1111,,,, 1111,,,, CCCCAAAAEEEESSSSAAAARRRR____SSSSIIIIZZZZEEEE____PPPPOOOOIIIINNNNTTTTEEEERRRR(((()))),,,, CCCCAAAAEEEESSSSAAAARRRR____AAAALLLLIIIIGGGGNNNNMMMMEEEENNNNTTTT____PPPPOOOOIIIINNNNTTTTEEEERRRR(((())))))));;;;


     Consequently, when using the ``stack_1'' library, it is for-
     bidden:


     -    to call CCCCAAAAEEEESSSSAAAARRRR____IIIINNNNIIIITTTT____EEEEDDDDGGGGEEEE(((()))) directly (which would result
          in  several  calls  to  this  procedure  with undefined
          results);

     -    to use any primitive of the ``edge'' library relying on
          the existence of the ``previous state'' field.

      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTEEEE____SSSSTTTTAAAACCCCKKKK____1111

     vvvvooooiiiidddd CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTEEEE____SSSSTTTTAAAACCCCKKKK____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____KKKK,,,, CCCCAAAAEEEESSSSAAAARRRR____OOOORRRRDDDDEEEERRRR,,,, CCCCAAAAEEEESSSSAAAARRRR____OOOOVVVVEEEERRRRFFFFLLLLOOOOWWWW))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSTTTTAAAACCCCKKKK____1111 ****CCCCAAAAEEEESSSSAAAARRRR____KKKK;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL CCCCAAAAEEEESSSSAAAARRRR____OOOORRRRDDDDEEEERRRR;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____OOOOVVVVEEEERRRRFFFFLLLLOOOOWWWW____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN____SSSSTTTTAAAACCCCKKKK____1111 CCCCAAAAEEEESSSSAAAARRRR____OOOOVVVVEEEERRRRFFFFLLLLOOOOWWWW;;;;
        {{{{ ............ }}}}

     This procedure allocates a stack using  CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTEEEE(((())))  and
     assigns  its  address to ****CCCCAAAAEEEESSSSAAAARRRR____KKKK. If the allocation fails,
     the NNNNUUUULLLLLLLL value is assigned to ****CCCCAAAAEEEESSSSAAAARRRR____KKKK.

     Note: because CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSTTTTAAAACCCCKKKK____1111 is  a  pointer  type,  any
     variable  CCCCAAAAEEEESSSSAAAARRRR____KKKK of type CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSTTTTAAAACCCCKKKK____1111 must be allo-
     cated before used, for instance using:

               CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTEEEE____SSSSTTTTAAAACCCCKKKK____1111 ((((&&&&CCCCAAAAEEEESSSSAAAARRRR____KKKK,,,, ............))));;;;


     The actual value of the formal parameter  CCCCAAAAEEEESSSSAAAARRRR____OOOORRRRDDDDEEEERRRR  will
     be  stored  and  associated  to  the  stack  pointed  to  by
     ****CCCCAAAAEEEESSSSAAAARRRR____KKKK. This parameter follows the  same  conventions  as
     the     formal     parameter     CCCCAAAAEEEESSSSAAAARRRR____OOOORRRRDDDDEEEERRRR     of     the
     CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTEEEE____EEEEDDDDGGGGEEEE____LLLLIIIISSSSTTTT(((()))) procedure of the ``edge'' library.
     It  will  be used subsequently to determine the order of the
     list of edges contained in the ``edge'' fields of the  items
     of  the  stack  pointed  to by ****CCCCAAAAEEEESSSSAAAARRRR____KKKK. See below for more



(C) INRIA     Last change: 2020/02/11 (version 1.6)             4






OPEN/CAESAR MANUAL                          caesar_stack_1(LOCAL)



     details.

     The actual value of  the  formal  parameter  CCCCAAAAEEEESSSSAAAARRRR____OOOOVVVVEEEERRRRFFFFLLLLOOOOWWWW
     will  be  stored  and  associated to the stack pointed to by
     ****CCCCAAAAEEEESSSSAAAARRRR____KKKK. It will be used  subsequently  to  determine  the
     action  to  take  if the stack pointed to by ****CCCCAAAAEEEESSSSAAAARRRR____KKKK over-
     flows:  in  this  case,  the   procedure   pointed   to   by
     CCCCAAAAEEEESSSSAAAARRRR____OOOOVVVVEEEERRRRFFFFLLLLOOOOWWWW  will  be  called with the overflowing stack
     ****CCCCAAAAEEEESSSSAAAARRRR____KKKK passed as actual parameter.

     The   above   procedures   CCCCAAAAEEEESSSSAAAARRRR____OOOOVVVVEEEERRRRFFFFLLLLOOOOWWWW____SSSSIIIIGGGGNNNNAAAALLLL____SSSSTTTTAAAACCCCKKKK____1111(((()))),
     CCCCAAAAEEEESSSSAAAARRRR____OOOOVVVVEEEERRRRFFFFLLLLOOOOWWWW____AAAABBBBOOOORRRRTTTT____SSSSTTTTAAAACCCCKKKK____1111(((()))),                         and
     CCCCAAAAEEEESSSSAAAARRRR____OOOOVVVVEEEERRRRFFFFLLLLOOOOWWWW____IIIIGGGGNNNNOOOORRRREEEE____SSSSTTTTAAAACCCCKKKK____1111(((()))),  can  be  used  as  actual
     values for the formal parameter CCCCAAAAEEEESSSSAAAARRRR____OOOOVVVVEEEERRRRFFFFLLLLOOOOWWWW.

     If the actual value of the formal parameter  CCCCAAAAEEEESSSSAAAARRRR____OOOOVVVVEEEERRRRFFFFLLLLOOOOWWWW
     is   NNNNUUUULLLLLLLL,   it   is   replaced   by   the   default   value
     CCCCAAAAEEEESSSSAAAARRRR____OOOOVVVVEEEERRRRFFFFLLLLOOOOWWWW____SSSSIIIIGGGGNNNNAAAALLLL____SSSSTTTTAAAACCCCKKKK____1111.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____DDDDEEEELLLLEEEETTTTEEEE____SSSSTTTTAAAACCCCKKKK____1111

     vvvvooooiiiidddd CCCCAAAAEEEESSSSAAAARRRR____DDDDEEEELLLLEEEETTTTEEEE____SSSSTTTTAAAACCCCKKKK____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____KKKK))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSTTTTAAAACCCCKKKK____1111 ****CCCCAAAAEEEESSSSAAAARRRR____KKKK;;;;
        {{{{ ............ }}}}

     This procedure frees the memory space corresponding  to  the
     stack  pointed  to  by ****CCCCAAAAEEEESSSSAAAARRRR____KKKK using CCCCAAAAEEEESSSSAAAARRRR____DDDDEEEELLLLEEEETTTTEEEE(((()))). Each
     stack item is also freed,  as  well  as  each  item  of  the
     ``edge''  field  of  each  stack  item. Afterwards, the NNNNUUUULLLLLLLL
     value is assigned to ****CCCCAAAAEEEESSSSAAAARRRR____KKKK.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____PPPPUUUURRRRGGGGEEEE____SSSSTTTTAAAACCCCKKKK____1111

     vvvvooooiiiidddd CCCCAAAAEEEESSSSAAAARRRR____PPPPUUUURRRRGGGGEEEE____SSSSTTTTAAAACCCCKKKK____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____KKKK))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSTTTTAAAACCCCKKKK____1111 CCCCAAAAEEEESSSSAAAARRRR____KKKK;;;;
        {{{{ ............ }}}}

     This procedure empties the  stack  pointed  to  by  CCCCAAAAEEEESSSSAAAARRRR____KKKK
     without  deleting  it.  Each stack item is freed, as well as
     each item of the ``edge'' field of each stack  item.  After-
     wards,  the  stack is exactly in the same state as after its
     creation using CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTEEEE____SSSSTTTTAAAACCCCKKKK____1111(((()))).


      ............................................................




(C) INRIA     Last change: 2020/02/11 (version 1.6)             5






OPEN/CAESAR MANUAL                          caesar_stack_1(LOCAL)



  CCCCAAAAEEEESSSSAAAARRRR____CCCCOOOOPPPPYYYY____SSSSTTTTAAAACCCCKKKK____1111

     vvvvooooiiiidddd CCCCAAAAEEEESSSSAAAARRRR____CCCCOOOOPPPPYYYY____SSSSTTTTAAAACCCCKKKK____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____KKKK1111,,,, CCCCAAAAEEEESSSSAAAARRRR____KKKK2222,,,, CCCCAAAAEEEESSSSAAAARRRR____FFFFUUUULLLLLLLL))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSTTTTAAAACCCCKKKK____1111 CCCCAAAAEEEESSSSAAAARRRR____KKKK1111;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSTTTTAAAACCCCKKKK____1111 CCCCAAAAEEEESSSSAAAARRRR____KKKK2222;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____BBBBOOOOOOOOLLLLEEEEAAAANNNN CCCCAAAAEEEESSSSAAAARRRR____FFFFUUUULLLLLLLL;;;;
        {{{{ ............ }}}}

     This procedure empties the stack  pointed  to  by  CCCCAAAAEEEESSSSAAAARRRR____KKKK1111
     using  CCCCAAAAEEEESSSSAAAARRRR____PPPPUUUURRRRGGGGEEEE____SSSSTTTTAAAACCCCKKKK____1111(((()))).  This  stack  must  have been
     created previously using CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTEEEE____SSSSTTTTAAAACCCCKKKK____1111(((()))).

     Afterwards,  the  contents  of  the  stack  pointed  to   by
     CCCCAAAAEEEESSSSAAAARRRR____KKKK2222  are  copied to the stack pointed to by CCCCAAAAEEEESSSSAAAARRRR____KKKK1111.
     For each item of the stack pointed to by CCCCAAAAEEEESSSSAAAARRRR____KKKK2222, a dupli-
     cated  item is allocated and inserted into the stack pointed
     to by CCCCAAAAEEEESSSSAAAARRRR____KKKK1111. Said  differently,  after  the  copy,  both
     stacks do not have shared items in common.

     If CCCCAAAAEEEESSSSAAAARRRR____FFFFUUUULLLLLLLL is equal to zero, the ``edge'' fields of  all
     items  in the stack pointed to by CCCCAAAAEEEESSSSAAAARRRR____KKKK1111 are set to NULL;
     the ``edge'' fields of the items in the stack pointed to  by
     CCCCAAAAEEEESSSSAAAARRRR____KKKK2222  are  not duplicated. This is useful for storing a
     path leading from the initial state to the current state.

     In case of memory shortage, the overflow  procedure  associ-
     ated  with  CCCCAAAAEEEESSSSAAAARRRR____KKKK1111  is  called  with the actual parameter
     CCCCAAAAEEEESSSSAAAARRRR____KKKK1111.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____DDDDEEEEPPPPTTTTHHHH____SSSSTTTTAAAACCCCKKKK____1111

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL CCCCAAAAEEEESSSSAAAARRRR____DDDDEEEEPPPPTTTTHHHH____SSSSTTTTAAAACCCCKKKK____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____KKKK))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSTTTTAAAACCCCKKKK____1111 CCCCAAAAEEEESSSSAAAARRRR____KKKK;;;;
        {{{{ ............ }}}}

     This function returns the  number  of  items  in  the  stack
     pointed to by CCCCAAAAEEEESSSSAAAARRRR____KKKK. It returns 0 if this stack is empty.

     Note: the depth of a stack is the number of states (not  the
     number  of labels) stored in the stack. Even if a stack con-
     tains only a single state (in  a  depth-first  search,  this
     state  is  likely to be the initial state of the graph), the
     depth of the stack will be 1, not 0.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____BBBBRRRREEEEAAAADDDDTTTTHHHH____SSSSTTTTAAAACCCCKKKK____1111




(C) INRIA     Last change: 2020/02/11 (version 1.6)             6






OPEN/CAESAR MANUAL                          caesar_stack_1(LOCAL)



     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL CCCCAAAAEEEESSSSAAAARRRR____BBBBRRRREEEEAAAADDDDTTTTHHHH____SSSSTTTTAAAACCCCKKKK____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____KKKK))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSTTTTAAAACCCCKKKK____1111 CCCCAAAAEEEESSSSAAAARRRR____KKKK;;;;
        {{{{ ............ }}}}

     This function returns the number of items that have not been
     explored  yet in the stack pointed to by CCCCAAAAEEEESSSSAAAARRRR____KKKK. More pre-
     cisely, it returns the sum, for  all  stack  items,  of  the
     respective lengths of the ``edge'' fields of these items.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____TTTTOOOOPPPP____SSSSTTTTAAAATTTTEEEE____SSSSTTTTAAAACCCCKKKK____1111

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSTTTTAAAATTTTEEEE CCCCAAAAEEEESSSSAAAARRRR____TTTTOOOOPPPP____SSSSTTTTAAAATTTTEEEE____SSSSTTTTAAAACCCCKKKK____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____KKKK))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSTTTTAAAACCCCKKKK____1111 CCCCAAAAEEEESSSSAAAARRRR____KKKK;;;;
        {{{{ ............ }}}}

     This function returns a pointer to the  ``state''  field  of
     the  item on the top of the stack pointed to by CCCCAAAAEEEESSSSAAAARRRR____KKKK. If
     the stack is empty, the result is undefined.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____TTTTOOOOPPPP____LLLLAAAABBBBEEEELLLL____SSSSTTTTAAAACCCCKKKK____1111

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____LLLLAAAABBBBEEEELLLL CCCCAAAAEEEESSSSAAAARRRR____TTTTOOOOPPPP____LLLLAAAABBBBEEEELLLL____SSSSTTTTAAAACCCCKKKK____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____KKKK))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSTTTTAAAACCCCKKKK____1111 CCCCAAAAEEEESSSSAAAARRRR____KKKK;;;;
        {{{{ ............ }}}}

     This function returns a pointer to the  ``label''  field  of
     the  item on the top of the stack pointed to by CCCCAAAAEEEESSSSAAAARRRR____KKKK. If
     the stack is empty, the result is undefined.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____TTTTOOOOPPPP____EEEEDDDDGGGGEEEE____SSSSTTTTAAAACCCCKKKK____1111

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____EEEEDDDDGGGGEEEE CCCCAAAAEEEESSSSAAAARRRR____TTTTOOOOPPPP____EEEEDDDDGGGGEEEE____SSSSTTTTAAAACCCCKKKK____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____KKKK))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSTTTTAAAACCCCKKKK____1111 CCCCAAAAEEEESSSSAAAARRRR____KKKK;;;;
        {{{{ ............ }}}}

     This function returns a pointer to the ``edge'' field of the
     item  on the top of the stack pointed to by CCCCAAAAEEEESSSSAAAARRRR____KKKK. If the
     stack is empty, the result is undefined.


      ............................................................





(C) INRIA     Last change: 2020/02/11 (version 1.6)             7






OPEN/CAESAR MANUAL                          caesar_stack_1(LOCAL)



  CCCCAAAAEEEESSSSAAAARRRR____EEEEMMMMPPPPTTTTYYYY____SSSSTTTTAAAACCCCKKKK____1111

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____BBBBOOOOOOOOLLLLEEEEAAAANNNN CCCCAAAAEEEESSSSAAAARRRR____EEEEMMMMPPPPTTTTYYYY____SSSSTTTTAAAACCCCKKKK____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____KKKK))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSTTTTAAAACCCCKKKK____1111 CCCCAAAAEEEESSSSAAAARRRR____KKKK;;;;
        {{{{ ............ }}}}

     This function returns a value different from 0 if the  stack
     pointed   to   by   CCCCAAAAEEEESSSSAAAARRRR____KKKK  is  empty,  and  0  otherwise.
     CCCCAAAAEEEESSSSAAAARRRR____EEEEMMMMPPPPTTTTYYYY____SSSSTTTTAAAACCCCKKKK____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____KKKK)))) is always equivalent to:

                 CCCCAAAAEEEESSSSAAAARRRR____DDDDEEEEPPPPTTTTHHHH____SSSSTTTTAAAACCCCKKKK____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____KKKK)))) ======== 0000



      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____EEEEXXXXPPPPLLLLOOOORRRREEEEDDDD____SSSSTTTTAAAACCCCKKKK____1111

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____BBBBOOOOOOOOLLLLEEEEAAAANNNN CCCCAAAAEEEESSSSAAAARRRR____EEEEXXXXPPPPLLLLOOOORRRREEEEDDDD____SSSSTTTTAAAACCCCKKKK____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____KKKK))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSTTTTAAAACCCCKKKK____1111 CCCCAAAAEEEESSSSAAAARRRR____KKKK;;;;
        {{{{ ............ }}}}

     This function returns  a  value  different  from  0  if  the
     ``edge''  field  of the item on the top of the stack pointed
     to by CCCCAAAAEEEESSSSAAAARRRR____KKKK is equal to NNNNUUUULLLLLLLL (i.e., the empty edge list),
     and  0 otherwise. If the stack is empty, the result is unde-
     fined.   CCCCAAAAEEEESSSSAAAARRRR____EEEEXXXXPPPPLLLLOOOORRRREEEEDDDD____SSSSTTTTAAAACCCCKKKK____1111   ((((CCCCAAAAEEEESSSSAAAARRRR____KKKK))))   is    always
     equivalent to:

            ****((((CCCCAAAAEEEESSSSAAAARRRR____TTTTOOOOPPPP____EEEEDDDDGGGGEEEE____SSSSTTTTAAAACCCCKKKK____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____KKKK)))))))) ======== NNNNUUUULLLLLLLL



      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTEEEE____TTTTOOOOPPPP____EEEEDDDDGGGGEEEE____SSSSTTTTAAAACCCCKKKK____1111

     vvvvooooiiiidddd CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTEEEE____TTTTOOOOPPPP____EEEEDDDDGGGGEEEE____SSSSTTTTAAAACCCCKKKK____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____KKKK))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSTTTTAAAACCCCKKKK____1111 CCCCAAAAEEEESSSSAAAARRRR____KKKK;;;;
        {{{{ ............ }}}}

     This procedure computes the list of the edges going out from
     the  ``state''  field  of the top of the stack pointed to by
     CCCCAAAAEEEESSSSAAAARRRR____KKKK, and assigns the result to the  ``edge''  field  of
     the stack top.

     If the stack is empty, or if the ``edge'' field of the stack
     top  is  not  equal  to the empty list when the procedure is
     called, the result is undefined.

     This is done by calling the  CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTEEEE____EEEEDDDDGGGGEEEE____LLLLIIIISSSSTTTT(((())))  pro-
     cedure  of  the  ``edge'' library. The actual value given to



(C) INRIA     Last change: 2020/02/11 (version 1.6)             8






OPEN/CAESAR MANUAL                          caesar_stack_1(LOCAL)



     the formal parameter CCCCAAAAEEEESSSSAAAARRRR____OOOORRRRDDDDEEEERRRR of this procedure is equal
     to  the actual value of the formal parameter CCCCAAAAEEEESSSSAAAARRRR____OOOORRRRDDDDEEEERRRR at
     the     time     the     stack     was     created     using
     CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTEEEE____SSSSTTTTAAAACCCCKKKK____1111(((()))).

     In case of memory shortage, either when allocating  the  new
     item  or  the  list of its outgoing edges, the overflow pro-
     cedure associated with CCCCAAAAEEEESSSSAAAARRRR____KKKK is called  with  the  actual
     parameter CCCCAAAAEEEESSSSAAAARRRR____KKKK.

     The      functions      CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTIIIIOOOONNNN____EEEEDDDDGGGGEEEE____LLLLIIIISSSSTTTT(((())))      and
     CCCCAAAAEEEESSSSAAAARRRR____TTTTRRRRUUUUNNNNCCCCAAAATTTTIIIIOOOONNNN____EEEEDDDDGGGGEEEE____LLLLIIIISSSSTTTT(((())))  can  be  used in the overflow
     procedure.  They  can  also  be  used  after  any  call   to
     CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTEEEE____TTTTOOOOPPPP____EEEEDDDDGGGGEEEE____SSSSTTTTAAAACCCCKKKK____1111(((()))), assuming that the overflow
     procedure has not aborted the program.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____DDDDEEEELLLLEEEETTTTEEEE____TTTTOOOOPPPP____EEEEDDDDGGGGEEEE____SSSSTTTTAAAACCCCKKKK____1111

     vvvvooooiiiidddd CCCCAAAAEEEESSSSAAAARRRR____DDDDEEEELLLLEEEETTTTEEEE____TTTTOOOOPPPP____EEEEDDDDGGGGEEEE____SSSSTTTTAAAACCCCKKKK____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____KKKK))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSTTTTAAAACCCCKKKK____1111 CCCCAAAAEEEESSSSAAAARRRR____KKKK;;;;
        {{{{ ............ }}}}

     This procedure frees the list of the edges in  the  ``edge''
     field of the top of the stack pointed to by CCCCAAAAEEEESSSSAAAARRRR____KKKK. After-
     wards, the NNNNUUUULLLLLLLL value is assigned to the ``edge''  field  of
     the stack top.

     If the stack is empty, the result is undefined.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____PPPPUUUUSSSSHHHH____SSSSTTTTAAAACCCCKKKK____1111

     vvvvooooiiiidddd CCCCAAAAEEEESSSSAAAARRRR____PPPPUUUUSSSSHHHH____SSSSTTTTAAAACCCCKKKK____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____KKKK,,,, CCCCAAAAEEEESSSSAAAARRRR____LLLL,,,, CCCCAAAAEEEESSSSAAAARRRR____SSSS))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSTTTTAAAACCCCKKKK____1111 CCCCAAAAEEEESSSSAAAARRRR____KKKK;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____LLLLAAAABBBBEEEELLLL CCCCAAAAEEEESSSSAAAARRRR____LLLL;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSTTTTAAAATTTTEEEE CCCCAAAAEEEESSSSAAAARRRR____SSSS;;;;
        {{{{ ............ }}}}

     This procedure allocates a new item, using  CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTEEEE(((()))),
     and  pushes  it  onto  the  top  of  the stack pointed to by
     CCCCAAAAEEEESSSSAAAARRRR____KKKK.

     The  label  pointed  to  by  CCCCAAAAEEEESSSSAAAARRRR____LLLL  is  copied  into  the
     ``label''  field  of the new stack top. However, if CCCCAAAAEEEESSSSAAAARRRR____LLLL
     is equal to NNNNUUUULLLLLLLL, the ``label'' field of the new  stack  top
     is  left undefined (this is useful for pushing the base when
     the stack is still empty).



(C) INRIA     Last change: 2020/02/11 (version 1.6)             9






OPEN/CAESAR MANUAL                          caesar_stack_1(LOCAL)



     The  state  pointed  to  by  CCCCAAAAEEEESSSSAAAARRRR____SSSS  is  copied  into  the
     ``state''  field  of the new stack top. However, if CCCCAAAAEEEESSSSAAAARRRR____SSSS
     is equal to NNNNUUUULLLLLLLL, the ``state'' field of the new  stack  top
     is  left undefined (this is useful for pushing the base when
     the stack is still empty).

     The ``edge'' field of the new stack top  is  initialized  to
     NNNNUUUULLLLLLLL.

     In case of memory shortage when allocating the new item, the
     overflow  procedure  associated with CCCCAAAAEEEESSSSAAAARRRR____KKKK is called with
     the actual parameter CCCCAAAAEEEESSSSAAAARRRR____KKKK.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____PPPPOOOOPPPP____SSSSTTTTAAAACCCCKKKK____1111

     vvvvooooiiiidddd CCCCAAAAEEEESSSSAAAARRRR____PPPPOOOOPPPP____SSSSTTTTAAAACCCCKKKK____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____KKKK))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSTTTTAAAACCCCKKKK____1111 CCCCAAAAEEEESSSSAAAARRRR____KKKK;;;;
        {{{{ ............ }}}}

     This procedure pops the item on the top of the stack pointed
     to by CCCCAAAAEEEESSSSAAAARRRR____KKKK. This item is freed using CCCCAAAAEEEESSSSAAAARRRR____DDDDEEEELLLLEEEETTTTEEEE(((()))).

     If the stack is empty, or if the ``edge'' field of  the  old
     stack  top  is  not  equal  to the empty list, the result is
     undefined.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____SSSSWWWWAAAAPPPP____SSSSTTTTAAAACCCCKKKK____1111

     vvvvooooiiiidddd CCCCAAAAEEEESSSSAAAARRRR____SSSSWWWWAAAAPPPP____SSSSTTTTAAAACCCCKKKK____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____KKKK))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSTTTTAAAACCCCKKKK____1111 CCCCAAAAEEEESSSSAAAARRRR____KKKK;;;;
        {{{{ ............ }}}}

     This procedure removes the first item of the list  of  edges
     pointed  to  by  the  ``edge'' field of the top of the stack
     pointed to by CCCCAAAAEEEESSSSAAAARRRR____KKKK, and pushes it onto the  top  of  the
     stack.

     If the stack is empty, or if the ``edge'' field of  the  old
     stack  top  is  equal to the empty list, the result is unde-
     fined.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____RRRREEEEJJJJEEEECCCCTTTT____SSSSTTTTAAAACCCCKKKK____1111




(C) INRIA     Last change: 2020/02/11 (version 1.6)            10






OPEN/CAESAR MANUAL                          caesar_stack_1(LOCAL)



     vvvvooooiiiidddd CCCCAAAAEEEESSSSAAAARRRR____RRRREEEEJJJJEEEECCCCTTTT____SSSSTTTTAAAACCCCKKKK____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____KKKK))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSTTTTAAAACCCCKKKK____1111 CCCCAAAAEEEESSSSAAAARRRR____KKKK;;;;
        {{{{ ............ }}}}

     This procedure removes the first item of the list  of  edges
     pointed  to  by  the  ``edge'' field of the top of the stack
     pointed  to  by  CCCCAAAAEEEESSSSAAAARRRR____KKKK.  This   item   is   freed   using
     CCCCAAAAEEEESSSSAAAARRRR____DDDDEEEELLLLEEEETTTTEEEE(((()))).

     If the stack is empty, or if the ``edge'' field of  the  old
     stack  top  is  equal to the empty list, the result is unde-
     fined.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____FFFFOOOORRRRMMMMAAAATTTT____SSSSTTTTAAAACCCCKKKK____1111

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____FFFFOOOORRRRMMMMAAAATTTT CCCCAAAAEEEESSSSAAAARRRR____FFFFOOOORRRRMMMMAAAATTTT____SSSSTTTTAAAACCCCKKKK____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____KKKK,,,, CCCCAAAAEEEESSSSAAAARRRR____FFFFOOOORRRRMMMMAAAATTTT))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSTTTTAAAACCCCKKKK____1111 CCCCAAAAEEEESSSSAAAARRRR____KKKK;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____FFFFOOOORRRRMMMMAAAATTTT CCCCAAAAEEEESSSSAAAARRRR____FFFFOOOORRRRMMMMAAAATTTT;;;;
        {{{{ ............ }}}}

     This function allows to control the format under  which  the
     stack  pointed  to  by  CCCCAAAAEEEESSSSAAAARRRR____KKKK will be printed by the pro-
     cedure CCCCAAAAEEEESSSSAAAARRRR____PPPPRRRRIIIINNNNTTTT____SSSSTTTTAAAACCCCKKKK____1111(((()))) (see  below).  Currently,  the
     following formats are available:


     -    With format 0, statistical information about the  stack
          is displayed such as: current depth, memory size, etc.

     -    With format 1, the items are  printed  from  the  stack
          base  to  the  stack  top. For each item, the ``label''
          field is printed; however, the ``label'' field  of  the
          stack  base  is not printed, since it is supposed to be
          undefined. The ``state'' and ``edge''  fields  are  not
          printed.

          This format  can  be  used  to  display  the  execution
          sequence  leading from the initial state to the current
          state.

     -    With format 2, the items are  printed  from  the  stack
          base to the stack top. For each item, the ``label'' and
          ``state'' fields are printed;  however,  the  ``label''
          field  of  the  stack  base is not printed, since it is
          supposed to be undefined. The ``edge'' fields  are  not
          printed.

          This format is intended mainly for debugging purpose.




(C) INRIA     Last change: 2020/02/11 (version 1.6)            11






OPEN/CAESAR MANUAL                          caesar_stack_1(LOCAL)



     -    With format 3, the items are printed from the stack top
          to  the  stack  base.  For each item, the ``label'' and
          ``state'' fields are printed;  however,  the  ``label''
          field  of  the  stack  base is not printed, since it is
          supposed to be undefined. The ``edge'' fields  are  not
          printed.

          This format is intended mainly for debugging purpose.

     -    With format 4, the items are  printed  from  the  stack
          base  to  the  stack top. For each item, the ``label'',
          ``state'', and ``edge'' fields  are  printed;  however,
          the  ``label''  field of the stack base is not printed,
          since it is supposed to be undefined.

          This format is intended mainly for debugging purpose.

     -    With format 5, the items are printed from the stack top
          to  the  stack  base.  For  each  item,  the ``label'',
          ``state'', and ``edge'' fields  are  printed;  however,
          the  ``label''  field of the stack base is not printed,
          since it is supposed to be undefined.

          This format is intended mainly for debugging purpose.

     -    (no other format available yet).

     Note:  whatever  the  format  chosen,  the  stack  will   be
     displayed  in  a form compatible with the SEQ format defined
     in the sssseeeeqqqq manual page of CADP.

     By default, the current format of each stack is  initialized
     to 0.

     When called with CCCCAAAAEEEESSSSAAAARRRR____FFFFOOOORRRRMMMMAAAATTTT between 0 and 5,  this  fonc-
     tion  sets  the  current format of CCCCAAAAEEEESSSSAAAARRRR____KKKK to CCCCAAAAEEEESSSSAAAARRRR____FFFFOOOORRRRMMMMAAAATTTT
     and returns an undefined result.

     When called with another value of CCCCAAAAEEEESSSSAAAARRRR____FFFFOOOORRRRMMMMAAAATTTT, this  func-
     tion  does  not  modify  the  current format of CCCCAAAAEEEESSSSAAAARRRR____KKKK but
     returns a result defined as  follows.  If  CCCCAAAAEEEESSSSAAAARRRR____FFFFOOOORRRRMMMMAAAATTTT  is
     equal  to  the constant CCCCAAAAEEEESSSSAAAARRRR____CCCCUUUURRRRRRRREEEENNNNTTTT____FFFFOOOORRRRMMMMAAAATTTT, the result is
     the  value  of  the   current   format   of   CCCCAAAAEEEESSSSAAAARRRR____KKKK.   If
     CCCCAAAAEEEESSSSAAAARRRR____FFFFOOOORRRRMMMMAAAATTTT      is      equal     to     the     constant
     CCCCAAAAEEEESSSSAAAARRRR____MMMMAAAAXXXXIIIIMMMMAAAALLLL____FFFFOOOORRRRMMMMAAAATTTT, the  result  is  the  maximal  format
     value  (i.e.,  5).  In  all  other cases, the effect of this
     function is undefined.


      ............................................................





(C) INRIA     Last change: 2020/02/11 (version 1.6)            12






OPEN/CAESAR MANUAL                          caesar_stack_1(LOCAL)



  CCCCAAAAEEEESSSSAAAARRRR____MMMMAAAAXXXX____FFFFOOOORRRRMMMMAAAATTTT____SSSSTTTTAAAACCCCKKKK____1111

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____FFFFOOOORRRRMMMMAAAATTTT CCCCAAAAEEEESSSSAAAARRRR____MMMMAAAAXXXX____FFFFOOOORRRRMMMMAAAATTTT____SSSSTTTTAAAACCCCKKKK____1111 (((())))
        {{{{ ............ }}}}

     Caution! This function is deprecated. It should no longer be
     used,  as  it  might  be removed from future versions of the
     _O_P_E_N/_C_A_E_S_A_R. Use function  CCCCAAAAEEEESSSSAAAARRRR____FFFFOOOORRRRMMMMAAAATTTT____SSSSTTTTAAAACCCCKKKK____1111(((())))  instead,
     called with argument CCCCAAAAEEEESSSSAAAARRRR____MMMMAAAAXXXXIIIIMMMMAAAALLLL____FFFFOOOORRRRMMMMAAAATTTT.

     This function returns the maximal format value available for
     printing stacks.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____PPPPRRRRIIIINNNNTTTT____SSSSTTTTAAAACCCCKKKK____1111

     vvvvooooiiiidddd CCCCAAAAEEEESSSSAAAARRRR____PPPPRRRRIIIINNNNTTTT____SSSSTTTTAAAACCCCKKKK____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____FFFFIIIILLLLEEEE,,,, CCCCAAAAEEEESSSSAAAARRRR____KKKK))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____FFFFIIIILLLLEEEE CCCCAAAAEEEESSSSAAAARRRR____FFFFIIIILLLLEEEE;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSTTTTAAAACCCCKKKK____1111 CCCCAAAAEEEESSSSAAAARRRR____KKKK;;;;
        {{{{ ............ }}}}

     This procedure prints to file CCCCAAAAEEEESSSSAAAARRRR____FFFFIIIILLLLEEEE a text  containing
     information  about  the  stack  pointed  to by CCCCAAAAEEEESSSSAAAARRRR____KKKK. The
     nature of the information is determined by the current  for-
     mat of the stack pointed to by CCCCAAAAEEEESSSSAAAARRRR____KKKK.

     Before this procedure is called, CCCCAAAAEEEESSSSAAAARRRR____FFFFIIIILLLLEEEE must have  been
     properly opened, for instance using ffffooooppppeeeennnn((((3333)))).


EEEEXXXXAAAAMMMMPPPPLLLLEEEE
     The following  portion  of  C  code  implements  a  standard
     depth-first search using the above primitives:


     ####iiiinnnncccclllluuuuddddeeee """"ccccaaaaeeeessssaaaarrrr____ssssttttaaaacccckkkk____1111....hhhh""""

     iiiinnnntttt mmmmaaaaiiiinnnn (((())))
     {{{{
     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSTTTTAAAACCCCKKKK____1111 ccccaaaaeeeessssaaaarrrr____kkkk;;;;

     CCCCAAAAEEEESSSSAAAARRRR____IIIINNNNIIIITTTT____GGGGRRRRAAAAPPPPHHHH (((())));;;;
     CCCCAAAAEEEESSSSAAAARRRR____IIIINNNNIIIITTTT____SSSSTTTTAAAACCCCKKKK____1111 (((())));;;;

     CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTEEEE____SSSSTTTTAAAACCCCKKKK____1111 ((((&&&&ccccaaaaeeeessssaaaarrrr____kkkk,,,, 0000,,,, NNNNUUUULLLLLLLL))));;;;
     CCCCAAAAEEEESSSSAAAARRRR____PPPPUUUUSSSSHHHH____SSSSTTTTAAAACCCCKKKK____1111 ((((ccccaaaaeeeessssaaaarrrr____kkkk,,,, NNNNUUUULLLLLLLL,,,, NNNNUUUULLLLLLLL))));;;;
     CCCCAAAAEEEESSSSAAAARRRR____SSSSTTTTAAAARRRRTTTT____SSSSTTTTAAAATTTTEEEE ((((CCCCAAAAEEEESSSSAAAARRRR____TTTTOOOOPPPP____SSSSTTTTAAAATTTTEEEE____SSSSTTTTAAAACCCCKKKK____1111 ((((ccccaaaaeeeessssaaaarrrr____kkkk))))))));;;;
     CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTEEEE____TTTTOOOOPPPP____EEEEDDDDGGGGEEEE____SSSSTTTTAAAACCCCKKKK____1111 ((((ccccaaaaeeeessssaaaarrrr____kkkk))));;;;

     wwwwhhhhiiiilllleeee ((((!!!! CCCCAAAAEEEESSSSAAAARRRR____EEEEMMMMPPPPTTTTYYYY____SSSSTTTTAAAACCCCKKKK____1111 ((((ccccaaaaeeeessssaaaarrrr____kkkk)))))))) {{{{



(C) INRIA     Last change: 2020/02/11 (version 1.6)            13






OPEN/CAESAR MANUAL                          caesar_stack_1(LOCAL)



             iiiiffff ((((CCCCAAAAEEEESSSSAAAARRRR____EEEEXXXXPPPPLLLLOOOORRRREEEEDDDD____SSSSTTTTAAAACCCCKKKK____1111 ((((ccccaaaaeeeessssaaaarrrr____kkkk))))))))
                     CCCCAAAAEEEESSSSAAAARRRR____PPPPOOOOPPPP____SSSSTTTTAAAACCCCKKKK____1111 ((((ccccaaaaeeeessssaaaarrrr____kkkk))));;;;
             eeeellllsssseeee iiiiffff ////**** ffffiiiirrrrsssstttt ssssuuuucccccccceeeessssssssoooorrrr aaaallllrrrreeeeaaaaddddyyyy kkkknnnnoooowwwwnnnn ****////
                     CCCCAAAAEEEESSSSAAAARRRR____RRRREEEEJJJJEEEECCCCTTTT____SSSSTTTTAAAACCCCKKKK____1111 ((((ccccaaaaeeeessssaaaarrrr____kkkk))));;;;
             eeeellllsssseeee    {{{{
                     CCCCAAAAEEEESSSSAAAARRRR____SSSSWWWWAAAAPPPP____SSSSTTTTAAAACCCCKKKK____1111 ((((ccccaaaaeeeessssaaaarrrr____kkkk))));;;;
                     CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTEEEE____TTTTOOOOPPPP____EEEEDDDDGGGGEEEE____SSSSTTTTAAAACCCCKKKK____1111 ((((ccccaaaaeeeessssaaaarrrr____kkkk))));;;;
                     ////**** aaaadddddddd nnnneeeewwww ttttoooopppp iiiinnnn tttthhhheeee hhhheeeeaaaapppp ****////
                  }}}}
             }}}}
     eeeexxxxiiiitttt ((((0000))));;;;
     }}}}


      ............................................................

AAAAUUUUTTTTHHHHOOOORRRR((((SSSS))))
     Hubert Garavel

FFFFIIIILLLLEEEESSSS
     $$$$CCCCAAAADDDDPPPP////iiiinnnnccccllll////ccccaaaaeeeessssaaaarrrr____ggggrrrraaaapppphhhh....hhhh     interface of the graph module
     $$$$CCCCAAAADDDDPPPP////iiiinnnnccccllll////ccccaaaaeeeessssaaaarrrr____****....hhhh         interfaces  of   the   storage
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









(C) INRIA     Last change: 2020/02/11 (version 1.6)            14



