


OPEN/CAESAR MANUAL                          caesar_table_1(LOCAL)



NNNNAAAAMMMMEEEE
     caesar_table_1 - the ``table_1'' library of OPEN/CAESAR

PPPPUUUURRRRPPPPOOOOSSSSEEEE
     The ``table_1'' library provides primitives for  managing  a
     ``state  space''. It can be used either for breadth-first or
     depth-first search in the state graph.



UUUUSSSSAAAAGGGGEEEE
     The ``table_1'' library consists of:

     -    a predefined header file ccccaaaaeeeessssaaaarrrr____ttttaaaabbbblllleeee____1111....hhhh;

     -    the precompiled library file lllliiiibbbbccccaaaaeeeessssaaaarrrr....aaaa, which  imple-
          ments the features described in ccccaaaaeeeessssaaaarrrr____ttttaaaabbbblllleeee____1111....hhhh.

     Note: The ``table_1'' library  is  a  software  layer  built
     above   the   primitives   offered   by   the  ``standard'',
     ``area_1'', and ``hash'' libraries, and by  the  _O_P_E_N/_C_A_E_S_A_R
     graph module.



DDDDEEEESSSSCCCCRRRRIIIIPPPPTTTTIIIIOOOONNNN
     A ``table'' is basically a set of items.

     Each item in the table is basically a byte string  of  fixed
     size. All items in a given table have the same size. An item
     can be considered as a tuple with two fields, whose size and
     contents are freely determined by the user:

     -    (1) a ``base'' field, that is a byte  string  of  fixed
          size.  In  a given table, all base fields have the same
          size. This size must be greater than zero.

          More often than not, the base field  contains  a  state
          (as  defined in the graph module). However, this is not
          mandatory, and base fields can contain  other  informa-
          tion than states.

     -    (2) a ``mark'' field, that is a byte string whose  size
          and  contents  are  freely determined by the user. In a
          given table, all mark fields have the same size,  which
          must  be  greater  or  equal to zero.  Pointers to mark
          fields  will  be   considered   as   values   of   type
          CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____PPPPOOOOIIIINNNNTTTTEEEERRRR; ``mark'' fields are always aligned
          on appropriate boundaries so that the user can put  any
          information in these fields without alignment problem.





(C) INRIA     Last change: 2020/02/11 (version 1.1)             1






OPEN/CAESAR MANUAL                          caesar_table_1(LOCAL)



     The user also determines the nature of the  data  stored  in
     these  fields,  which  is  not meaningful to the ``table_1''
     library.

     Invariant property 1: the table is organized in such  a  way
     that all items have different base fields. Said differently,
     two items in a given table cannot have identical base fields
     (but they can have identical mark fields).

     Invariant property 2: the number of items in a  given  table
     never  decreases.  New  items  can be inserted in the table,
     existing items can be replaced by new ones, but no item  can
     be  removed  if it is not replaced by another one. Exception
     to this rule: it is possible to purge the  table,  i.e.,  to
     remove simultaneously all its items.

     Invariant property 3: it is not allowed to modify  the  base
     field of any item in the table (except if this item is to be
     replaced by another one  that  has  exactly  the  same  hash
     value,  which is unlikely). But it is possible to modify the
     mark field of any item.

     Each item in a table is given a unique identification number
     (``index'')  which  is a natural number. A table can contain
     no more than a maximum of M items, with  indexes  between  0
     and  M  -  1.  Currently, M = 2^{29} = 536,870,912 on 32-bit
     machines and M = 2^{34} = 17,179,869,184 on 64-bit machines.
     But,  for  each  table,  the user can also limit the maximal
     number of items to a lesser bound N <= M.

     When the table overflows (either because the maximum  number
     of  items is reached or because there is no enough memory to
     store new items), an action chosen by the user (e.g., abort,
     recovery, etc.) is performed.

     Each item in the table can be accessed  in  three  different
     ways:

     -    (1) by using its address (i.e., a pointer to the memory
          location where it is stored in the table),

     -    (2) by using its index,

     -    (3) by using its base field.

     The  table  data  structure  establishes  a   correspondence
     between these three data. Indeed:

     -    given an address, one can retrieve the index, the  base
          field, and the mark field of the corresponding item;

     -    given an index, one can retrieve the address, the  base



(C) INRIA     Last change: 2020/02/11 (version 1.1)             2






OPEN/CAESAR MANUAL                          caesar_table_1(LOCAL)



          field, and the mark field of the corresponding item;

     -    given a base field, one can retrieve the  address,  the
          index, and the mark field of the corresponding item.

     Retrieving the address and the index of  an  item  from  its
     base  field  involves some associative search. To allow fast
     retrievals, an hash-table is associated to each table.  This
     is quite transparent from the user's point of view. Only the
     base field is taken into account when  computing  the  hash-
     value  and comparing items; the mark field is not meaningful
     for the search.

     Two special variables are associated to a given table:

     -    the ``put index'' corresponds to the last item inserted
          in  the  table.  Initialized  to zero, the put index is
          incremented each time a new item  is  inserted.  There-
          fore,  the  first item is numbered 0, the second one is
          numbered 1, etc.

          The ``put index'' is always useful,  whatever  the  way
          the graph is explored: breadth-first, depth-first, etc.

     -    the ``get index'' is associated to the last  item  con-
          sulted in the table. Initialized to zero, the get index
          is incremented each time a new item is consulted. Since
          only  the items previously inserted in the table can be
          consulted, the get index is always less or equal to the
          put index.

          The ``get index'' can be used to  consult  sequentially
          all  the  items,  in  the  same order as they have been
          inserted in the table. Therefore it  can  be  used  for
          (pseudo)  breadth-first exploration, but not for depth-
          first exploration.

     Additionally, statistics are attached to each  table.  These
     statistics  consist of a ``success counter'' and a ``failure
     counter'', which  respectively  count  how  many  retrievals
     (given the base field) have succeeded and failed.



FFFFEEEEAAAATTTTUUUURRRREEEESSSS
      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____TTTTAAAABBBBLLLLEEEE____1111

     ttttyyyyppppeeeeddddeeeeffff CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____AAAABBBBSSSSTTTTRRRRAAAACCCCTTTT ((((............)))) CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____TTTTAAAABBBBLLLLEEEE____1111;;;;

     This type denotes a pointer to the  concrete  representation



(C) INRIA     Last change: 2020/02/11 (version 1.1)             3






OPEN/CAESAR MANUAL                          caesar_table_1(LOCAL)



     of  a  table.  The  table  representation  is supposed to be
     ``opaque''.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____IIIINNNNDDDDEEEEXXXX____TTTTAAAABBBBLLLLEEEE____1111

     ttttyyyyppppeeeeddddeeeeffff CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____IIIINNNNDDDDEEEEXXXX____TTTTAAAABBBBLLLLEEEE____1111;;;;

     This type denotes an index, which is a natural number.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____NNNNUUUULLLLLLLL____IIIINNNNDDDDEEEEXXXX____TTTTAAAABBBBLLLLEEEE____1111

     ####ddddeeeeffffiiiinnnneeee CCCCAAAAEEEESSSSAAAARRRR____NNNNUUUULLLLLLLL____IIIINNNNDDDDEEEEXXXX____TTTTAAAABBBBLLLLEEEE____1111 ((((((((CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____IIIINNNNDDDDEEEEXXXX____TTTTAAAABBBBLLLLEEEE____1111)))) ----1111LLLL))))

     This constant denotes a special index value corresponding to
     the  largest unsigned integer. Since item indexes are always
     in  the  range  0..M-1,  no  item  index  can  be  equal  to
     CCCCAAAAEEEESSSSAAAARRRR____NNNNUUUULLLLLLLL____IIIINNNNDDDDEEEEXXXX____TTTTAAAABBBBLLLLEEEE____1111.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____MMMMAAAAXXXX____IIIINNNNDDDDEEEEXXXX____TTTTAAAABBBBLLLLEEEE____1111

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____IIIINNNNDDDDEEEEXXXX____TTTTAAAABBBBLLLLEEEE____1111 CCCCAAAAEEEESSSSAAAARRRR____MMMMAAAAXXXX____IIIINNNNDDDDEEEEXXXX____TTTTAAAABBBBLLLLEEEE____1111 (((())))
        {{{{ ............ }}}}

     This function returns the value  of  M,  i.e.,  the  maximal
     number  of  items  that can be stored in a table. Since item
     indexes are always in the range 0..M-1, no item index can be
     equal to CCCCAAAAEEEESSSSAAAARRRR____MMMMAAAAXXXX____IIIINNNNDDDDEEEEXXXX____TTTTAAAABBBBLLLLEEEE____1111(((()))).


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____OOOOVVVVEEEERRRRFFFFLLLLOOOOWWWW____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN____TTTTAAAABBBBLLLLEEEE____1111

     ttttyyyyppppeeeeddddeeeeffff vvvvooooiiiidddd ((((****CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____OOOOVVVVEEEERRRRFFFFLLLLOOOOWWWW____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN____TTTTAAAABBBBLLLLEEEE____1111)))) ((((CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____TTTTAAAABBBBLLLLEEEE____1111))));;;;

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____OOOOVVVVEEEERRRRFFFFLLLLOOOOWWWW____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN____TTTTAAAABBBBLLLLEEEE____1111 is the ``pointer to an
     overflow  procedure''  type used in the ``table_1'' library.
     An  overflow  procedure  takes   one   parameter   of   type
     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____TTTTAAAABBBBLLLLEEEE____1111.  Examples  of  overflow  procedures are
     CCCCAAAAEEEESSSSAAAARRRR____OOOOVVVVEEEERRRRFFFFLLLLOOOOWWWW____SSSSIIIIGGGGNNNNAAAALLLL____TTTTAAAABBBBLLLLEEEE____1111(((()))),
     CCCCAAAAEEEESSSSAAAARRRR____OOOOVVVVEEEERRRRFFFFLLLLOOOOWWWW____AAAABBBBOOOORRRRTTTT____TTTTAAAABBBBLLLLEEEE____1111(((()))),                         and
     CCCCAAAAEEEESSSSAAAARRRR____OOOOVVVVEEEERRRRFFFFLLLLOOOOWWWW____IIIIGGGGNNNNOOOORRRREEEE____TTTTAAAABBBBLLLLEEEE____1111(((()))) defined below.




(C) INRIA     Last change: 2020/02/11 (version 1.1)             4






OPEN/CAESAR MANUAL                          caesar_table_1(LOCAL)



      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____OOOOVVVVEEEERRRRFFFFLLLLOOOOWWWW____SSSSIIIIGGGGNNNNAAAALLLL____TTTTAAAABBBBLLLLEEEE____1111

     vvvvooooiiiidddd CCCCAAAAEEEESSSSAAAARRRR____OOOOVVVVEEEERRRRFFFFLLLLOOOOWWWW____SSSSIIIIGGGGNNNNAAAALLLL____TTTTAAAABBBBLLLLEEEE____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____TTTT))))
         CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____TTTTAAAABBBBLLLLEEEE____1111 CCCCAAAAEEEESSSSAAAARRRR____TTTT;;;;
        {{{{ ............ }}}}

     This procedure is a possible action that can be performed in
     case  the  table  pointed  to  by CCCCAAAAEEEESSSSAAAARRRR____TTTT overflows (either
     because the maximum number of items for CCCCAAAAEEEESSSSAAAARRRR____TTTT is  reached
     or because there is no enough memory to store new items).

     It first prints an error message to the standard output, and
     also  various  statistics about the table. Then, it returns.
     Practically, if the table is used for state  space  explora-
     tion, this means that some portions of the graph will not be
     explored, but an error message will be issued.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____OOOOVVVVEEEERRRRFFFFLLLLOOOOWWWW____AAAABBBBOOOORRRRTTTT____TTTTAAAABBBBLLLLEEEE____1111

     vvvvooooiiiidddd CCCCAAAAEEEESSSSAAAARRRR____OOOOVVVVEEEERRRRFFFFLLLLOOOOWWWW____AAAABBBBOOOORRRRTTTT____TTTTAAAABBBBLLLLEEEE____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____TTTT))))
         CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____TTTTAAAABBBBLLLLEEEE____1111 CCCCAAAAEEEESSSSAAAARRRR____TTTT;;;;
        {{{{ ............ }}}}

     This procedure is a possible action that can be performed in
     case  the  table  pointed  to  by CCCCAAAAEEEESSSSAAAARRRR____TTTT overflows (either
     because the maximum number of items for CCCCAAAAEEEESSSSAAAARRRR____TTTT is  reached
     or because there is no enough memory to store new items).

     It first prints an error message to the standard output, and
     also various statistics about the table. Then, it aborts the
     program using the C function eeeexxxxiiiitttt((((3333)))). The error  code  1  is
     returned.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____OOOOVVVVEEEERRRRFFFFLLLLOOOOWWWW____IIIIGGGGNNNNOOOORRRREEEE____TTTTAAAABBBBLLLLEEEE____1111

     vvvvooooiiiidddd CCCCAAAAEEEESSSSAAAARRRR____OOOOVVVVEEEERRRRFFFFLLLLOOOOWWWW____IIIIGGGGNNNNOOOORRRREEEE____TTTTAAAABBBBLLLLEEEE____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____TTTT))))
         CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____TTTTAAAABBBBLLLLEEEE____1111 CCCCAAAAEEEESSSSAAAARRRR____TTTT;;;;
        {{{{ ............ }}}}

     This procedure is a possible action that can be performed in
     case  the  table  pointed  to  by CCCCAAAAEEEESSSSAAAARRRR____TTTT overflows (either
     because the maximum number of items for CCCCAAAAEEEESSSSAAAARRRR____TTTT is  reached
     or because there is no enough memory to store new items).




(C) INRIA     Last change: 2020/02/11 (version 1.1)             5






OPEN/CAESAR MANUAL                          caesar_table_1(LOCAL)



     It does nothing and returns. Practically, if  the  table  is
     used  for state space exploration, this means that some por-
     tions of the graph will not be explored; they  are  silently
     ignored.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTEEEE____TTTTAAAABBBBLLLLEEEE____1111

     vvvvooooiiiidddd CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTEEEE____TTTTAAAABBBBLLLLEEEE____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____TTTT,,,, CCCCAAAAEEEESSSSAAAARRRR____BBBBAAAASSSSEEEE____AAAARRRREEEEAAAA,,,, CCCCAAAAEEEESSSSAAAARRRR____MMMMAAAARRRRKKKK____AAAARRRREEEEAAAA,,,,
                                 CCCCAAAAEEEESSSSAAAARRRR____LLLLIIIIMMMMIIIITTTT____SSSSIIIIZZZZEEEE,,,, CCCCAAAAEEEESSSSAAAARRRR____HHHHAAAASSSSHHHH____SSSSIIIIZZZZEEEE,,,,
                                 CCCCAAAAEEEESSSSAAAARRRR____PPPPRRRRIIIIMMMMEEEE,,,, CCCCAAAAEEEESSSSAAAARRRR____CCCCOOOOMMMMPPPPAAAARRRREEEE,,,, CCCCAAAAEEEESSSSAAAARRRR____HHHHAAAASSSSHHHH,,,,
                                 CCCCAAAAEEEESSSSAAAARRRR____PPPPRRRRIIIINNNNTTTT,,,, CCCCAAAAEEEESSSSAAAARRRR____OOOOVVVVEEEERRRRFFFFLLLLOOOOWWWW))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____TTTTAAAABBBBLLLLEEEE____1111 ****CCCCAAAAEEEESSSSAAAARRRR____TTTT;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____AAAARRRREEEEAAAA____1111 CCCCAAAAEEEESSSSAAAARRRR____BBBBAAAASSSSEEEE____AAAARRRREEEEAAAA;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____AAAARRRREEEEAAAA____1111 CCCCAAAAEEEESSSSAAAARRRR____MMMMAAAARRRRKKKK____AAAARRRREEEEAAAA;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL CCCCAAAAEEEESSSSAAAARRRR____LLLLIIIIMMMMIIIITTTT____SSSSIIIIZZZZEEEE;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL CCCCAAAAEEEESSSSAAAARRRR____HHHHAAAASSSSHHHH____SSSSIIIIZZZZEEEE;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____BBBBOOOOOOOOLLLLEEEEAAAANNNN CCCCAAAAEEEESSSSAAAARRRR____PPPPRRRRIIIIMMMMEEEE;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____CCCCOOOOMMMMPPPPAAAARRRREEEE____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN CCCCAAAAEEEESSSSAAAARRRR____CCCCOOOOMMMMPPPPAAAARRRREEEE;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____HHHHAAAASSSSHHHH____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN CCCCAAAAEEEESSSSAAAARRRR____HHHHAAAASSSSHHHH;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____PPPPRRRRIIIINNNNTTTT____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN CCCCAAAAEEEESSSSAAAARRRR____PPPPRRRRIIIINNNNTTTT;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____OOOOVVVVEEEERRRRFFFFLLLLOOOOWWWW____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN____TTTTAAAABBBBLLLLEEEE____1111 CCCCAAAAEEEESSSSAAAARRRR____OOOOVVVVEEEERRRRFFFFLLLLOOOOWWWW;;;;
        {{{{ ............ }}}}

     This procedure allocates a table using  CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTEEEE(((())))  and
     assigns  its  address to ****CCCCAAAAEEEESSSSAAAARRRR____TTTT. If the allocation fails,
     the NNNNUUUULLLLLLLL value is assigned to ****CCCCAAAAEEEESSSSAAAARRRR____TTTT.

     Note: when it is called, this procedure does not allocate at
     once all the memory needed to represent the table: the table
     will grow progressively as new items  are  inserted.  Conse-
     quently,  if  CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTEEEE____TTTTAAAABBBBLLLLEEEE____1111(((())))  returns  a value dif-
     ferent from NNNNUUUULLLLLLLL, this does not mean that no  overflow  will
     occur in the future.

     Note: because CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____TTTTAAAABBBBLLLLEEEE____1111 is  a  pointer  type,  any
     variable  CCCCAAAAEEEESSSSAAAARRRR____TTTT of type CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____TTTTAAAABBBBLLLLEEEE____1111 must be allo-
     cated before used, for instance using:

               CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTEEEE____TTTTAAAABBBBLLLLEEEE____1111 ((((&&&&CCCCAAAAEEEESSSSAAAARRRR____TTTT,,,, ............))));;;;


     The value of CCCCAAAAEEEESSSSAAAARRRR____BBBBAAAASSSSEEEE____AAAARRRREEEEAAAA determines the (constant) size
     and  (constant)  alignment  factor  of the base field in the
     table.  In the particular case where base fields are used to
     store  states  (resp.  labels,  strings),  one must give the
     value  CCCCAAAAEEEESSSSAAAARRRR____SSSSTTTTAAAATTTTEEEE____AAAARRRREEEEAAAA____1111(((())))  (resp.  CCCCAAAAEEEESSSSAAAARRRR____LLLLAAAABBBBEEEELLLL____AAAARRRREEEEAAAA____1111(((()))),
     CCCCAAAAEEEESSSSAAAARRRR____SSSSTTTTRRRRIIIINNNNGGGG____AAAARRRREEEEAAAA____1111(((()))))     to    the    formal    parameter
     CCCCAAAAEEEESSSSAAAARRRR____BBBBAAAASSSSEEEE____AAAARRRREEEEAAAA.




(C) INRIA     Last change: 2020/02/11 (version 1.1)             6






OPEN/CAESAR MANUAL                          caesar_table_1(LOCAL)



     Note:    For    backward    compatibility    reasons,     if
     CCCCAAAAEEEESSSSAAAARRRR____BBBBAAAASSSSEEEE____AAAARRRREEEEAAAA  is equal to CCCCAAAAEEEESSSSAAAARRRR____EEEEMMMMPPPPTTTTYYYY____AAAARRRREEEEAAAA____1111(((()))), it will
     be treated exactly like CCCCAAAAEEEESSSSAAAARRRR____SSSSTTTTAAAATTTTEEEE____AAAARRRREEEEAAAA____1111(((()))), i.e.,  speci-
     fying  an  empty  area  for  the base field is equivalent to
     specifying a state area. However, relying on this feature is
     not  recommended  and this case will no longer be considered
     in the sequel of this manual.

     The value of CCCCAAAAEEEESSSSAAAARRRR____MMMMAAAARRRRKKKK____AAAARRRREEEEAAAA determines the (constant) size
     and  (constant) alignment factor of the mark field according
     to the specifications of the ``area_1'' library. In particu-
     lar,  if CCCCAAAAEEEESSSSAAAARRRR____MMMMAAAARRRRKKKK____AAAARRRREEEEAAAA is equal to CCCCAAAAEEEESSSSAAAARRRR____EEEEMMMMPPPPTTTTYYYY____AAAARRRREEEEAAAA____1111(((()))),
     there will be no mark field in the table.

     Each item in the table will be represented as a byte  string
     of  fixed  size ccccaaaaeeeessssaaaarrrr____iiiitttteeeemmmm____ssssiiiizzzzeeee, such that ccccaaaaeeeessssaaaarrrr____iiiitttteeeemmmm____ssssiiiizzzzeeee
     is    strictly    greater    than     ccccaaaaeeeessssaaaarrrr____bbbbaaaasssseeee____ssssiiiizzzzeeee     ++++
     ccccaaaaeeeessssaaaarrrr____mmmmaaaarrrrkkkk____ssssiiiizzzzeeee,  where  ccccaaaaeeeessssaaaarrrr____bbbbaaaasssseeee____ssssiiiizzzzeeee  denotes the size
     (in bytes)  of  the  base  field  (i.e.,  CCCCAAAAEEEESSSSAAAARRRR____SSSSIIIIZZZZEEEE____AAAARRRREEEEAAAA____1111
     ((((CCCCAAAAEEEESSSSAAAARRRR____BBBBAAAASSSSEEEE____AAAARRRREEEEAAAA)))))  and  where ccccaaaaeeeessssaaaarrrr____mmmmaaaarrrrkkkk____ssssiiiizzzzeeee denotes the
     size  (in  bytes)  of  the  mark  field,   if   any   (i.e.,
     CCCCAAAAEEEESSSSAAAARRRR____SSSSIIIIZZZZEEEE____AAAARRRREEEEAAAA____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____MMMMAAAARRRRKKKK____AAAARRRREEEEAAAA))))).

     An item in the table contains not only the  base  field  and
     the  mark  field, but also additional information needed for
     internal management. Also, ``padding'' bytes may be inserted
     around  the base and mark fields to ensure that these fields
     are correctly aligned according  to  CCCCAAAAEEEESSSSAAAARRRR____AAAALLLLIIIIGGGGNNNNMMMMEEEENNNNTTTT____AAAARRRREEEEAAAA____1111
     ((((CCCCAAAAEEEESSSSAAAARRRR____BBBBAAAASSSSEEEE____AAAARRRREEEEAAAA))))        and        CCCCAAAAEEEESSSSAAAARRRR____AAAALLLLIIIIGGGGNNNNMMMMEEEENNNNTTTT____AAAARRRREEEEAAAA____1111
     ((((CCCCAAAAEEEESSSSAAAARRRR____MMMMAAAARRRRKKKK____AAAARRRREEEEAAAA)))).

     The value of CCCCAAAAEEEESSSSAAAARRRR____LLLLIIIIMMMMIIIITTTT____SSSSIIIIZZZZEEEE determines the maximal number
     of  items  that can be stored in the table; all indexes will
     consequently be in the range 0..CCCCAAAAEEEESSSSAAAARRRR____LLLLIIIIMMMMIIIITTTT____SSSSIIIIZZZZEEEE  -  1.  It
     must  be  less  or equal to M. If it is equal to zero, it is
     replaced by the default value M.

     Note:   in   order   to   spare   memory,   the   value   of
     CCCCAAAAEEEESSSSAAAARRRR____LLLLIIIIMMMMIIIITTTT____SSSSIIIIZZZZEEEE  (which is an upper bound on the number of
     items to be inserted in the table) should  be  as  small  as
     possible.  This  can  only  be  done  if  the  user has some
     knowledge about the way the table will be used. The value of
     CCCCAAAAEEEESSSSAAAARRRR____LLLLIIIIMMMMIIIITTTT____SSSSIIIIZZZZEEEE (or its default value if CCCCAAAAEEEESSSSAAAARRRR____LLLLIIIIMMMMIIIITTTT____SSSSIIIIZZZZEEEE
     is equal to zero)  might  be  reduced  automatically  if  it
     exceeds  the number of all possible different base fields or
     if it exceeds the amount of physical memory available (which
     is either specified by the environment variable $$$$CCCCAAAADDDDPPPP____MMMMEEEEMMMMOOOORRRRYYYY
     or determined automatically by the ccccaaaaddddpppp____mmmmeeeemmmmoooorrrryyyy program).

     The value  of  CCCCAAAAEEEESSSSAAAARRRR____HHHHAAAASSSSHHHH____SSSSIIIIZZZZEEEE  determines  the  number  of
     entries  in  the  hash-table  associated  to  the  table. If
     CCCCAAAAEEEESSSSAAAARRRR____HHHHAAAASSSSHHHH____SSSSIIIIZZZZEEEE is different from zero, it remains constant



(C) INRIA     Last change: 2020/02/11 (version 1.1)             7






OPEN/CAESAR MANUAL                          caesar_table_1(LOCAL)



     during  the  entire  existence  of the table (static hashing
     scheme).  If  CCCCAAAAEEEESSSSAAAARRRR____HHHHAAAASSSSHHHH____SSSSIIIIZZZZEEEE  is  equal  to  zero,  it  is
     replaced  with  a default value greater than zero that might
     increase automatically when a sufficiently large  number  of
     items  have  been  inserted  into the table (dynamic hashing
     scheme).

     Note:   in   order   to   spare   memory,   the   value   of
     CCCCAAAAEEEESSSSAAAARRRR____HHHHAAAASSSSHHHH____SSSSIIIIZZZZEEEE  (or  its default value if CCCCAAAAEEEESSSSAAAARRRR____HHHHAAAASSSSHHHH____SSSSIIIIZZZZEEEE
     is equal to zero)  might  be  reduced  automatically  if  it
     exceeds  the  value  of CCCCAAAAEEEESSSSAAAARRRR____LLLLIIIIMMMMIIIITTTT____SSSSIIIIZZZZEEEE, i.e., the maximal
     number of items that can be stored in the table,  or  if  it
     exceeds the maximal number of different hash values that can
     be obtained taking into account  the  ``hashable''  size  of
     CCCCAAAAEEEESSSSAAAARRRR____BBBBAAAASSSSEEEE____AAAARRRREEEEAAAA.

     If the value of CCCCAAAAEEEESSSSAAAARRRR____PPPPRRRRIIIIMMMMEEEE is equal to CCCCAAAAEEEESSSSAAAARRRR____TTTTRRRRUUUUEEEE and  if
     the  value  of  CCCCAAAAEEEESSSSAAAARRRR____HHHHAAAASSSSHHHH____SSSSIIIIZZZZEEEE is not a prime number, this
     value will be replaced by the nearest smaller  prime  number
     (since  some  hash  functions require prime modulus). Other-
     wise, the value of CCCCAAAAEEEESSSSAAAARRRR____HHHHAAAASSSSHHHH____SSSSIIIIZZZZEEEE will be kept unchanged.

     The actual value of the formal parameter CCCCAAAAEEEESSSSAAAARRRR____CCCCOOOOMMMMPPPPAAAARRRREEEE will
     be  stored  and  associated  to  the  table  pointed  to  by
     ****CCCCAAAAEEEESSSSAAAARRRR____TTTT. It will be used as a comparison function when  it
     is  necessary to decide whether two base fields are equal or
     not.

     Precisely, the actual value of CCCCAAAAEEEESSSSAAAARRRR____CCCCOOOOMMMMPPPPAAAARRRREEEE  should  be  a
     pointer   to  a  comparison  function  with  two  parameters
     ccccaaaaeeeessssaaaarrrr____bbbbaaaasssseeee____1111 and ccccaaaaeeeessssaaaarrrr____bbbbaaaasssseeee____2222 that returns CCCCAAAAEEEESSSSAAAARRRR____TTTTRRRRUUUUEEEE  if
     the   two  base  fields  pointed  to  by  ccccaaaaeeeessssaaaarrrr____bbbbaaaasssseeee____1111  and
     ccccaaaaeeeessssaaaarrrr____bbbbaaaasssseeee____2222 are equal.

     If the actual value of the formal  parameter  CCCCAAAAEEEESSSSAAAARRRR____CCCCOOOOMMMMPPPPAAAARRRREEEE
     is NNNNUUUULLLLLLLL, it is replaced by a pointer to a default comparison
     function that depends on the value of  CCCCAAAAEEEESSSSAAAARRRR____BBBBAAAASSSSEEEE____AAAARRRREEEEAAAA  and
     is  determined according to the rules specified for function
     CCCCAAAAEEEESSSSAAAARRRR____UUUUSSSSEEEE____CCCCOOOOMMMMPPPPAAAARRRREEEE____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN____AAAARRRREEEEAAAA____1111(((())))   of   the   ``area_1''
     library.

     The actual value of the formal parameter CCCCAAAAEEEESSSSAAAARRRR____HHHHAAAASSSSHHHH will be
     stored  and associated to the table pointed to by ****CCCCAAAAEEEESSSSAAAARRRR____TTTT.
     It will be used as a hash-function when it is  necessary  to
     compute  a  hash-value for searching or inserting an item in
     the table.

     Precisely, the actual  value  of  CCCCAAAAEEEESSSSAAAARRRR____HHHHAAAASSSSHHHH  should  be  a
     pointer   to   a   hash   function   with   two   parameters
     ccccaaaaeeeessssaaaarrrr____ppppooooiiiinnnntttteeeerrrr and ccccaaaaeeeessssaaaarrrr____mmmmoooodddduuuulllluuuussss  that  returns  a  natural
     number in the range 0..ccccaaaaeeeessssaaaarrrr____mmmmoooodddduuuulllluuuussss-1.




(C) INRIA     Last change: 2020/02/11 (version 1.1)             8






OPEN/CAESAR MANUAL                          caesar_table_1(LOCAL)



     If the actual value of the formal parameter  CCCCAAAAEEEESSSSAAAARRRR____HHHHAAAASSSSHHHH  is
     NNNNUUUULLLLLLLL, it is replaced by a pointer to a default hash function
     that depends on the value of CCCCAAAAEEEESSSSAAAARRRR____BBBBAAAASSSSEEEE____AAAARRRREEEEAAAA and is  deter-
     mined   according   to  the  rules  specified  for  function
     CCCCAAAAEEEESSSSAAAARRRR____UUUUSSSSEEEE____HHHHAAAASSSSHHHH____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN____AAAARRRREEEEAAAA____1111(((()))) of the ``area_1'' library.

     Note: for backward compatibility reasons, the current imple-
     mentation  of  CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTEEEE____TTTTAAAABBBBLLLLEEEE____1111(((())))  tries  to handle the
     case where CCCCAAAAEEEESSSSAAAARRRR____HHHHAAAASSSSHHHH points to an hash function with three
     parameters  (such  as  the CCCCAAAAEEEESSSSAAAARRRR____0000____HHHHAAAASSSSHHHH(((()))), CCCCAAAAEEEESSSSAAAARRRR____1111____HHHHAAAASSSSHHHH(((()))),
     ... functions provided by the ``hash'' library)  instead  of
     two.   However,  this  support for hash functions with three
     parameters only occurs  under  very  specific  circumstances
     (e.g.,  if  CCCCAAAAEEEESSSSAAAARRRR____BBBBAAAASSSSEEEE____AAAARRRREEEEAAAA has a null exponent field and a
     non-null length field).  Relying  on  this  feature  is  not
     recommended  and  this  case will no longer be considered in
     the sequel of this manual.

     The actual value of the formal parameter  CCCCAAAAEEEESSSSAAAARRRR____PPPPRRRRIIIINNNNTTTT  will
     be  stored  and  associated  to  the  table  pointed  to  by
     ****CCCCAAAAEEEESSSSAAAARRRR____TTTT. It will be used subsequently to print  the  items
     of this table.

     Precisely, the actual value  of  CCCCAAAAEEEESSSSAAAARRRR____PPPPRRRRIIIINNNNTTTT  should  be  a
     pointer   to   a  printing  procedure  with  two  parameters
     ccccaaaaeeeessssaaaarrrr____ffffiiiilllleeee and ccccaaaaeeeessssaaaarrrr____iiiitttteeeemmmm that prints to file  ccccaaaaeeeessssaaaarrrr____ffffiiiilllleeee
     information  about  the  contents  (base  field  and/or mark
     field, if any) of the item pointed to by ccccaaaaeeeessssaaaarrrr____iiiitttteeeemmmm.

     If the actual value of the formal parameter CCCCAAAAEEEESSSSAAAARRRR____PPPPRRRRIIIINNNNTTTT  is
     NNNNUUUULLLLLLLL,  it  is  replaced  by a pointer to a default procedure
     that prints the base field and the mark field, if  any.  The
     printing  procedure  used  for the base field (respectively,
     the mark field) depends on  the  value  of  CCCCAAAAEEEESSSSAAAARRRR____BBBBAAAASSSSEEEE____AAAARRRREEEEAAAA
     (resp.  CCCCAAAAEEEESSSSAAAARRRR____MMMMAAAARRRRKKKK____AAAARRRREEEEAAAA) and is determined according to the
     rules           specified            for            function
     CCCCAAAAEEEESSSSAAAARRRR____UUUUSSSSEEEE____PPPPRRRRIIIINNNNTTTT____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN____AAAARRRREEEEAAAA____1111(((())))    of    the   ``area_1''
     library.   The  actual  value  of   the   formal   parameter
     CCCCAAAAEEEESSSSAAAARRRR____OOOOVVVVEEEERRRRFFFFLLLLOOOOWWWW  will  be stored and associated to the table
     pointed to by ****CCCCAAAAEEEESSSSAAAARRRR____TTTT. It will  be  used  subsequently  to
     determine  the  action  to  take  if the table pointed to by
     ****CCCCAAAAEEEESSSSAAAARRRR____TTTT overflows: in this case, the procedure pointed  to
     by CCCCAAAAEEEESSSSAAAARRRR____OOOOVVVVEEEERRRRFFFFLLLLOOOOWWWW will be called with the overflowing table
     ****CCCCAAAAEEEESSSSAAAARRRR____TTTT passed as actual parameter.

     The   above   procedures   CCCCAAAAEEEESSSSAAAARRRR____OOOOVVVVEEEERRRRFFFFLLLLOOOOWWWW____SSSSIIIIGGGGNNNNAAAALLLL____TTTTAAAABBBBLLLLEEEE____1111(((()))),
     CCCCAAAAEEEESSSSAAAARRRR____OOOOVVVVEEEERRRRFFFFLLLLOOOOWWWW____AAAABBBBOOOORRRRTTTT____TTTTAAAABBBBLLLLEEEE____1111(((()))),                         and
     CCCCAAAAEEEESSSSAAAARRRR____OOOOVVVVEEEERRRRFFFFLLLLOOOOWWWW____IIIIGGGGNNNNOOOORRRREEEE____TTTTAAAABBBBLLLLEEEE____1111(((()))),  can  be  used  as  actual
     values  for  the  formal  parameter CCCCAAAAEEEESSSSAAAARRRR____OOOOVVVVEEEERRRRFFFFLLLLOOOOWWWW.  If the
     actual value of  the  formal  parameter  CCCCAAAAEEEESSSSAAAARRRR____OOOOVVVVEEEERRRRFFFFLLLLOOOOWWWW  is
     NNNNUUUULLLLLLLL,    it    is    replaced    by    the   default   value
     CCCCAAAAEEEESSSSAAAARRRR____OOOOVVVVEEEERRRRFFFFLLLLOOOOWWWW____SSSSIIIIGGGGNNNNAAAALLLL____TTTTAAAABBBBLLLLEEEE____1111.



(C) INRIA     Last change: 2020/02/11 (version 1.1)             9






OPEN/CAESAR MANUAL                          caesar_table_1(LOCAL)



     The table  is  initially  empty.  The  success  and  failure
     counters attached to the table are both initialized to 0.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____DDDDEEEELLLLEEEETTTTEEEE____TTTTAAAABBBBLLLLEEEE____1111

     vvvvooooiiiidddd CCCCAAAAEEEESSSSAAAARRRR____DDDDEEEELLLLEEEETTTTEEEE____TTTTAAAABBBBLLLLEEEE____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____TTTT))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____TTTTAAAABBBBLLLLEEEE____1111 ****CCCCAAAAEEEESSSSAAAARRRR____TTTT;;;;
        {{{{ ............ }}}}

     This procedure frees the memory space corresponding  to  the
     table  pointed  to  by  ****CCCCAAAAEEEESSSSAAAARRRR____TTTT using CCCCAAAAEEEESSSSAAAARRRR____DDDDEEEELLLLEEEETTTTEEEE(((()))). The
     items contained in the table and its  associated  hash-table
     are  also  freed.  Afterwards, the NNNNUUUULLLLLLLL value is assigned to
     ****CCCCAAAAEEEESSSSAAAARRRR____TTTT.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____PPPPUUUURRRRGGGGEEEE____TTTTAAAABBBBLLLLEEEE____1111

     vvvvooooiiiidddd CCCCAAAAEEEESSSSAAAARRRR____PPPPUUUURRRRGGGGEEEE____TTTTAAAABBBBLLLLEEEE____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____TTTT))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____TTTTAAAABBBBLLLLEEEE____1111 CCCCAAAAEEEESSSSAAAARRRR____TTTT;;;;
        {{{{ ............ }}}}

     This procedure empties the  table  pointed  to  by  CCCCAAAAEEEESSSSAAAARRRR____TTTT
     without  deleting  it.  Each  item contained in the table is
     freed  using  CCCCAAAAEEEESSSSAAAARRRR____DDDDEEEELLLLEEEETTTTEEEE(((()))).  Afterwards,  this  table  is
     exactly  in  the  same  state  as  after  its creation using
     CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTEEEE____TTTTAAAABBBBLLLLEEEE____1111(((()))).


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____PPPPUUUUTTTT____IIIINNNNDDDDEEEEXXXX____TTTTAAAABBBBLLLLEEEE____1111

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____IIIINNNNDDDDEEEEXXXX____TTTTAAAABBBBLLLLEEEE____1111 CCCCAAAAEEEESSSSAAAARRRR____PPPPUUUUTTTT____IIIINNNNDDDDEEEEXXXX____TTTTAAAABBBBLLLLEEEE____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____TTTT))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____TTTTAAAABBBBLLLLEEEE____1111 CCCCAAAAEEEESSSSAAAARRRR____TTTT;;;;
        {{{{ ............ }}}}

     This function returns the number of items that have been put
     in  the table pointed to by CCCCAAAAEEEESSSSAAAARRRR____TTTT, which is also equal to
     the index of the next item to be  put  in  the  table.  This
     number  is initialized to 0 and it is incremented every time
     the CCCCAAAAEEEESSSSAAAARRRR____PPPPUUUUTTTT____TTTTAAAABBBBLLLLEEEE____1111(((()))) function (see below) is called.

     Note: This number is always less or equal to N, where  N  is
     the maximal number of items that can be stored in the table;
     the value of N depends on the actual value given to the for-
     mal  parameter  CCCCAAAAEEEESSSSAAAARRRR____LLLLIIIIMMMMIIIITTTT____SSSSIIIIZZZZEEEE when the table was created



(C) INRIA     Last change: 2020/02/11 (version 1.1)            10






OPEN/CAESAR MANUAL                          caesar_table_1(LOCAL)



     using CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTEEEE____TTTTAAAABBBBLLLLEEEE____1111(((()))).

     Note: When the table is empty, the result returned  by  this
     function  is  equal  to  zero.  When  the table is full, the
     result returned by this function is equal to N.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____PPPPUUUUTTTT____BBBBAAAASSSSEEEE____TTTTAAAABBBBLLLLEEEE____1111

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____PPPPOOOOIIIINNNNTTTTEEEERRRR CCCCAAAAEEEESSSSAAAARRRR____PPPPUUUUTTTT____BBBBAAAASSSSEEEE____TTTTAAAABBBBLLLLEEEE____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____TTTT))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____TTTTAAAABBBBLLLLEEEE____1111 CCCCAAAAEEEESSSSAAAARRRR____TTTT;;;;
        {{{{ ............ }}}}

     If the table pointed to by CCCCAAAAEEEESSSSAAAARRRR____TTTT is not full, this  func-
     tion returns a pointer to the base field of the next item to
     be put in the table. This base field is initially  undefined
     and  must be assigned before calling some other functions of
     the ``table_1'' library (see below).

     If the table pointed to by CCCCAAAAEEEESSSSAAAARRRR____TTTT is full,  this  function
     returns  a  pointer  to  the  base  field  of a special item
     located beyond the table. It is  permitted  to  modify  (and
     subsequently  consult)  the contents of this base field, but
     invoking the CCCCAAAAEEEESSSSAAAARRRR____PPPPUUUUTTTT____TTTTAAAABBBBLLLLEEEE____1111(((()))) function (see below)  will
     cause an overflow.



      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____PPPPUUUUTTTT____MMMMAAAARRRRKKKK____TTTTAAAABBBBLLLLEEEE____1111

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____PPPPOOOOIIIINNNNTTTTEEEERRRR CCCCAAAAEEEESSSSAAAARRRR____PPPPUUUUTTTT____MMMMAAAARRRRKKKK____TTTTAAAABBBBLLLLEEEE____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____TTTT))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____TTTTAAAABBBBLLLLEEEE____1111 CCCCAAAAEEEESSSSAAAARRRR____TTTT;;;;
        {{{{ ............ }}}}

     If there are no mark fields in the table (due  to  the  ini-
     tialization parameters supplied to CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTEEEE____TTTTAAAABBBBLLLLEEEE____1111(((())))),
     the result returned by CCCCAAAAEEEESSSSAAAARRRR____PPPPUUUUTTTT____MMMMAAAARRRRKKKK____TTTTAAAABBBBLLLLEEEE____1111(((())))  is  always
     undefined.

     If the table pointed to by CCCCAAAAEEEESSSSAAAARRRR____TTTT is not full, this  func-
     tion returns a pointer to the mark field of the next item to
     be put in the table. This mark field is  always  initialized
     to a bit string of 0's. It can be consulted and modified.

     If the table pointed to by CCCCAAAAEEEESSSSAAAARRRR____TTTT is full,  this  function
     returns  a  pointer  to  the  mark  field  of a special item
     located beyond the table. It is permitted to modify and con-
     sult  the  contents  of  this  mark  field, but invoking the



(C) INRIA     Last change: 2020/02/11 (version 1.1)            11






OPEN/CAESAR MANUAL                          caesar_table_1(LOCAL)



     CCCCAAAAEEEESSSSAAAARRRR____PPPPUUUUTTTT____TTTTAAAABBBBLLLLEEEE____1111(((()))) function  (see  below)  will  cause  an
     overflow.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____PPPPUUUUTTTT____TTTTAAAABBBBLLLLEEEE____1111

     vvvvooooiiiidddd CCCCAAAAEEEESSSSAAAARRRR____PPPPUUUUTTTT____TTTTAAAABBBBLLLLEEEE____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____TTTT))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____TTTTAAAABBBBLLLLEEEE____1111 CCCCAAAAEEEESSSSAAAARRRR____TTTT;;;;
        {{{{ ............ }}}}

     This procedure puts into the table pointed  to  by  CCCCAAAAEEEESSSSAAAARRRR____TTTT
     the    item    whose   base   field   is   pointed   to   by
     CCCCAAAAEEEESSSSAAAARRRR____PPPPUUUUTTTT____BBBBAAAASSSSEEEE____TTTTAAAABBBBLLLLEEEE____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____TTTT)))) and whose mark field  (if
     any) is pointed to by CCCCAAAAEEEESSSSAAAARRRR____PPPPUUUUTTTT____MMMMAAAARRRRKKKK____TTTTAAAABBBBLLLLEEEE____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____TTTT)))).

     The base field must have been assigned before this procedure
     is called.

     This procedure assumes that no other item in the  table  has
     the  same base field. There is no attempt to check the vali-
     dity of this assumption.  It  is  therefore  of  the  user's
     responsibility  to  ensure that this assumption is true. See
     also function CCCCAAAAEEEESSSSAAAARRRR____SSSSEEEEAAAARRRRCCCCHHHH____AAAANNNNDDDD____PPPPUUUUTTTT____TTTTAAAABBBBLLLLEEEE____1111(((()))) below.

     The hash-table associated to the table is  updated  to  take
     into account the new item. To compute the hash-value for the
     base field, the hash-function associated with the  table  is
     used.

     If the maximum number of items  in  the  table  was  already
     reached  when the procedure CCCCAAAAEEEESSSSAAAARRRR____PPPPUUUUTTTT____TTTTAAAABBBBLLLLEEEE____1111(((()))) was called,
     or in case of memory shortage, the overflow procedure  asso-
     ciated  with  CCCCAAAAEEEESSSSAAAARRRR____TTTT  is  called with the actual parameter
     CCCCAAAAEEEESSSSAAAARRRR____TTTT.

     Finally, CCCCAAAAEEEESSSSAAAARRRR____PPPPUUUUTTTT____IIIINNNNDDDDEEEEXXXX____TTTTAAAABBBBLLLLEEEE____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____TTTT)))) is incremented;
     CCCCAAAAEEEESSSSAAAARRRR____PPPPUUUUTTTT____BBBBAAAASSSSEEEE____TTTTAAAABBBBLLLLEEEE____1111            ((((CCCCAAAAEEEESSSSAAAARRRR____TTTT))))            and
     CCCCAAAAEEEESSSSAAAARRRR____PPPPUUUUTTTT____MMMMAAAARRRRKKKK____TTTTAAAABBBBLLLLEEEE____1111  ((((CCCCAAAAEEEESSSSAAAARRRR____TTTT))))  are  advanced,  respec-
     tively, to the base field and the mark field (if any) of the
     next free item.

     Note:  the  table  is  implemented  in  such  a   way   that
     CCCCAAAAEEEESSSSAAAARRRR____PPPPUUUUTTTT____BBBBAAAASSSSEEEE____TTTTAAAABBBBLLLLEEEE____1111(((())))    and   CCCCAAAAEEEESSSSAAAARRRR____PPPPUUUUTTTT____MMMMAAAARRRRKKKK____TTTTAAAABBBBLLLLEEEE____1111(((())))
     always return a valid pointer, even if the table is  already
     full.  Overflow  can only occur when CCCCAAAAEEEESSSSAAAARRRR____PPPPUUUUTTTT____TTTTAAAABBBBLLLLEEEE____1111(((()))) is
     called,   but   not   when   CCCCAAAAEEEESSSSAAAARRRR____PPPPUUUUTTTT____BBBBAAAASSSSEEEE____TTTTAAAABBBBLLLLEEEE____1111(((())))    or
     CCCCAAAAEEEESSSSAAAARRRR____PPPPUUUUTTTT____MMMMAAAARRRRKKKK____TTTTAAAABBBBLLLLEEEE____1111(((()))) are called.






(C) INRIA     Last change: 2020/02/11 (version 1.1)            12






OPEN/CAESAR MANUAL                          caesar_table_1(LOCAL)



      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____SSSSEEEEAAAARRRRCCCCHHHH____TTTTAAAABBBBLLLLEEEE____1111

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____BBBBOOOOOOOOLLLLEEEEAAAANNNN CCCCAAAAEEEESSSSAAAARRRR____SSSSEEEEAAAARRRRCCCCHHHH____TTTTAAAABBBBLLLLEEEE____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____TTTT,,,, CCCCAAAAEEEESSSSAAAARRRR____BBBB,,,, CCCCAAAAEEEESSSSAAAARRRR____IIII,,,, CCCCAAAAEEEESSSSAAAARRRR____PPPP))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____TTTTAAAABBBBLLLLEEEE____1111 CCCCAAAAEEEESSSSAAAARRRR____TTTT;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____PPPPOOOOIIIINNNNTTTTEEEERRRR CCCCAAAAEEEESSSSAAAARRRR____BBBB;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____IIIINNNNDDDDEEEEXXXX____TTTTAAAABBBBLLLLEEEE____1111 ****CCCCAAAAEEEESSSSAAAARRRR____IIII;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____PPPPOOOOIIIINNNNTTTTEEEERRRR ****CCCCAAAAEEEESSSSAAAARRRR____PPPP;;;;
        {{{{ ............ }}}}

     This function determines  if  there  exists,  in  the  table
     pointed to by CCCCAAAAEEEESSSSAAAARRRR____TTTT, an item whose base field is equal to
     the byte string pointed to by  CCCCAAAAEEEESSSSAAAARRRR____BBBB.  Byte  string  com-
     parisons are performed using the comparison function associ-
     ated to the table.  The  search  is  done  using  the  hash-
     function and hash-table associated to the table.

     If so, this function returns CCCCAAAAEEEESSSSAAAARRRR____TTTTRRRRUUUUEEEE. In this case,  the
     index  and the address of the item are respectively assigned
     to ****CCCCAAAAEEEESSSSAAAARRRR____IIII and ****CCCCAAAAEEEESSSSAAAARRRR____PPPP. The success counter attached  to
     the  table  is  incremented.   If not, this function returns
     CCCCAAAAEEEESSSSAAAARRRR____FFFFAAAALLLLSSSSEEEE. In this case,  both  variables  ****CCCCAAAAEEEESSSSAAAARRRR____IIII  and
     ****CCCCAAAAEEEESSSSAAAARRRR____PPPP  are  left unchanged. The failure counter attached
     to the table is incremented.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____SSSSEEEEAAAARRRRCCCCHHHH____AAAANNNNDDDD____PPPPUUUUTTTT____TTTTAAAABBBBLLLLEEEE____1111

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____BBBBOOOOOOOOLLLLEEEEAAAANNNN CCCCAAAAEEEESSSSAAAARRRR____SSSSEEEEAAAARRRRCCCCHHHH____AAAANNNNDDDD____PPPPUUUUTTTT____TTTTAAAABBBBLLLLEEEE____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____TTTT,,,, CCCCAAAAEEEESSSSAAAARRRR____IIII,,,, CCCCAAAAEEEESSSSAAAARRRR____PPPP))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____TTTTAAAABBBBLLLLEEEE____1111 CCCCAAAAEEEESSSSAAAARRRR____TTTT;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____IIIINNNNDDDDEEEEXXXX____TTTTAAAABBBBLLLLEEEE____1111 ****CCCCAAAAEEEESSSSAAAARRRR____IIII;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____PPPPOOOOIIIINNNNTTTTEEEERRRR ****CCCCAAAAEEEESSSSAAAARRRR____PPPP;;;;
         {{{{ ............ }}}}

     This   function   is   a   combination   of   the   function
     CCCCAAAAEEEESSSSAAAARRRR____SSSSEEEEAAAARRRRCCCCHHHH____TTTTAAAABBBBLLLLEEEE____1111(((())))        and       the       procedure
     CCCCAAAAEEEESSSSAAAARRRR____PPPPUUUUTTTT____TTTTAAAABBBBLLLLEEEE____1111(((()))) defined above.  The base field  pointed
     to  by  CCCCAAAAEEEESSSSAAAARRRR____PPPPUUUUTTTT____BBBBAAAASSSSEEEE____TTTTAAAABBBBLLLLEEEE____1111  ((((CCCCAAAAEEEESSSSAAAARRRR____TTTT))))  must  have been
     assigned before this function is called.

     It first determines if there exists, in the table pointed by
     CCCCAAAAEEEESSSSAAAARRRR____TTTT,  an  item  whose  base  field is equal to the base
     field of the  item  pointed  to  by  CCCCAAAAEEEESSSSAAAARRRR____PPPPUUUUTTTT____BBBBAAAASSSSEEEE____TTTTAAAABBBBLLLLEEEE____1111
     ((((CCCCAAAAEEEESSSSAAAARRRR____TTTT)))).  Byte string comparisons are performed using the
     comparison function associated to the table. The  search  is
     done  using  the  hash-function and hash-table associated to
     the table.

     If so, this function returns CCCCAAAAEEEESSSSAAAARRRR____TTTTRRRRUUUUEEEE. In this case,  the



(C) INRIA     Last change: 2020/02/11 (version 1.1)            13






OPEN/CAESAR MANUAL                          caesar_table_1(LOCAL)



     index  and the address of the existing item are respectively
     assigned to ****CCCCAAAAEEEESSSSAAAARRRR____IIII and  ****CCCCAAAAEEEESSSSAAAARRRR____PPPP.  The  success  counter
     attached to the table is incremented.  If not, this function
     returns CCCCAAAAEEEESSSSAAAARRRR____FFFFAAAALLLLSSSSEEEE. In this case, it puts into  the  table
     pointed  to by CCCCAAAAEEEESSSSAAAARRRR____TTTT the item whose base field is pointed
     to by  CCCCAAAAEEEESSSSAAAARRRR____PPPPUUUUTTTT____BBBBAAAASSSSEEEE____TTTTAAAABBBBLLLLEEEE____1111  ((((CCCCAAAAEEEESSSSAAAARRRR____TTTT))))  and  whose  mark
     field  (if  any)  is  pointed  to by CCCCAAAAEEEESSSSAAAARRRR____PPPPUUUUTTTT____MMMMAAAARRRRKKKK____TTTTAAAABBBBLLLLEEEE____1111
     ((((CCCCAAAAEEEESSSSAAAARRRR____TTTT)))).  The  hash-table  associated  to  the  table  is
     updated to take into account the new item. The overflow pro-
     cedure associated with  the  table  is  called  if  overflow
     occurs.

     CCCCAAAAEEEESSSSAAAARRRR____PPPPUUUUTTTT____IIIINNNNDDDDEEEEXXXX____TTTTAAAABBBBLLLLEEEE____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____TTTT)))) is copied into ****CCCCAAAAEEEESSSSAAAARRRR____IIII
     and  then incremented. CCCCAAAAEEEESSSSAAAARRRR____PPPPUUUUTTTT____BBBBAAAASSSSEEEE____TTTTAAAABBBBLLLLEEEE____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____TTTT)))) is
     copied into ****CCCCAAAAEEEESSSSAAAARRRR____PPPP and then advanced to the base field of
     the  next  free  item.  The  failure counter attached to the
     table is incremented.

     Note:      formally      the      body      of      function
     CCCCAAAAEEEESSSSAAAARRRR____SSSSEEEEAAAARRRRCCCCHHHH____AAAANNNNDDDD____PPPPUUUUTTTT____TTTTAAAABBBBLLLLEEEE____1111(((()))) could be defined as follows:

             {{{{
             CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____BBBBOOOOOOOOLLLLEEEEAAAANNNN ccccaaaaeeeessssaaaarrrr____ffffoooouuuunnnndddd;;;;
             ccccaaaaeeeessssaaaarrrr____ffffoooouuuunnnndddd ==== CCCCAAAAEEEESSSSAAAARRRR____SSSSEEEEAAAARRRRCCCCHHHH____TTTTAAAABBBBLLLLEEEE____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____TTTT,,,,
                     CCCCAAAAEEEESSSSAAAARRRR____PPPPUUUUTTTT____BBBBAAAASSSSEEEE____TTTTAAAABBBBLLLLEEEE____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____TTTT)))),,,, CCCCAAAAEEEESSSSAAAARRRR____IIII,,,, CCCCAAAAEEEESSSSAAAARRRR____PPPP))));;;;
             iiiiffff ((((!!!! ccccaaaaeeeessssaaaarrrr____ffffoooouuuunnnndddd))))
                     {{{{
                     ****CCCCAAAAEEEESSSSAAAARRRR____IIII ==== CCCCAAAAEEEESSSSAAAARRRR____PPPPUUUUTTTT____IIIINNNNDDDDEEEEXXXX____TTTTAAAABBBBLLLLEEEE____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____TTTT))));;;;
                     ****CCCCAAAAEEEESSSSAAAARRRR____PPPP ==== CCCCAAAAEEEESSSSAAAARRRR____PPPPUUUUTTTT____BBBBAAAASSSSEEEE____TTTTAAAABBBBLLLLEEEE____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____TTTT))));;;;
                     CCCCAAAAEEEESSSSAAAARRRR____PPPPUUUUTTTT____TTTTAAAABBBBLLLLEEEE____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____TTTT))));;;;
                     }}}}
             }}}}

     Practically, it is implemented differently,  for  efficiency
     reasons  (the  computation  of the hash-value and the access
     through the hash-table are performed only once, not twice).


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____GGGGEEEETTTT____IIIINNNNDDDDEEEEXXXX____TTTTAAAABBBBLLLLEEEE____1111

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____IIIINNNNDDDDEEEEXXXX____TTTTAAAABBBBLLLLEEEE____1111 CCCCAAAAEEEESSSSAAAARRRR____GGGGEEEETTTT____IIIINNNNDDDDEEEEXXXX____TTTTAAAABBBBLLLLEEEE____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____TTTT))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____TTTTAAAABBBBLLLLEEEE____1111 CCCCAAAAEEEESSSSAAAARRRR____TTTT;;;;
        {{{{ ............ }}}}

     This function returns the number of items that have been got
     from  the  table  pointed  to by CCCCAAAAEEEESSSSAAAARRRR____TTTT, which is also the
     index of the next item to be got from the table. This number
     is  initialized  to  0  and it is incremented every time the
     CCCCAAAAEEEESSSSAAAARRRR____GGGGEEEETTTT____TTTTAAAABBBBLLLLEEEE____1111(((()))) function (see below) is called.




(C) INRIA     Last change: 2020/02/11 (version 1.1)            14






OPEN/CAESAR MANUAL                          caesar_table_1(LOCAL)



     Note: This number is always  less  or  equal  to  the  value
     returned by CCCCAAAAEEEESSSSAAAARRRR____PPPPUUUUTTTT____IIIINNNNDDDDEEEEXXXX____TTTTAAAABBBBLLLLEEEE____1111(((()))).


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____GGGGEEEETTTT____BBBBAAAASSSSEEEE____TTTTAAAABBBBLLLLEEEE____1111

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____PPPPOOOOIIIINNNNTTTTEEEERRRR CCCCAAAAEEEESSSSAAAARRRR____GGGGEEEETTTT____BBBBAAAASSSSEEEE____TTTTAAAABBBBLLLLEEEE____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____TTTT))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____TTTTAAAABBBBLLLLEEEE____1111 CCCCAAAAEEEESSSSAAAARRRR____TTTT;;;;
        {{{{ ............ }}}}

     This function returns a pointer to the  base  field  of  the
     next item to be got in the table pointed to by CCCCAAAAEEEESSSSAAAARRRR____TTTT.

     This pointer can only be  used  if  CCCCAAAAEEEESSSSAAAARRRR____GGGGEEEETTTT____IIIINNNNDDDDEEEEXXXX____TTTTAAAABBBBLLLLEEEE____1111
     ((((CCCCAAAAEEEESSSSAAAARRRR____TTTT))))  is  strictly  less than CCCCAAAAEEEESSSSAAAARRRR____PPPPUUUUTTTT____IIIINNNNDDDDEEEEXXXX____TTTTAAAABBBBLLLLEEEE____1111
     ((((CCCCAAAAEEEESSSSAAAARRRR____TTTT)))). In the opposite case, the result of  this  func-
     tion  is  undefined  (since  it is not possible to get items
     that have not been put yet).

     The   base   field   pointed   to   by   the    result    of
     CCCCAAAAEEEESSSSAAAARRRR____GGGGEEEETTTT____BBBBAAAASSSSEEEE____TTTTAAAABBBBLLLLEEEE____1111(((())))  can  be  consulted, but not modi-
     fied.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____GGGGEEEETTTT____MMMMAAAARRRRKKKK____TTTTAAAABBBBLLLLEEEE____1111

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____PPPPOOOOIIIINNNNTTTTEEEERRRR CCCCAAAAEEEESSSSAAAARRRR____GGGGEEEETTTT____MMMMAAAARRRRKKKK____TTTTAAAABBBBLLLLEEEE____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____TTTT))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____TTTTAAAABBBBLLLLEEEE____1111 CCCCAAAAEEEESSSSAAAARRRR____TTTT;;;;
        {{{{ ............ }}}}

     This function returns a pointer to the  mark  field  of  the
     next  item to be got in the table pointed to by CCCCAAAAEEEESSSSAAAARRRR____TTTT. If
     there are no mark fields in the table (due to the  initiali-
     zation  parameters  supplied to CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTEEEE____TTTTAAAABBBBLLLLEEEE____1111(((())))) the
     result is undefined.

     This pointer can only be  used  if  CCCCAAAAEEEESSSSAAAARRRR____GGGGEEEETTTT____IIIINNNNDDDDEEEEXXXX____TTTTAAAABBBBLLLLEEEE____1111
     ((((CCCCAAAAEEEESSSSAAAARRRR____TTTT))))  is  strictly  less than CCCCAAAAEEEESSSSAAAARRRR____PPPPUUUUTTTT____IIIINNNNDDDDEEEEXXXX____TTTTAAAABBBBLLLLEEEE____1111
     ((((CCCCAAAAEEEESSSSAAAARRRR____TTTT)))). In the opposite case, the result of  this  func-
     tion  is  undefined  (since  it is not possible to get items
     that have not been put yet).

     The   mark   field   pointed   to   by   the    result    of
     CCCCAAAAEEEESSSSAAAARRRR____GGGGEEEETTTT____MMMMAAAARRRRKKKK____TTTTAAAABBBBLLLLEEEE____1111(((())))  can  be either consulted or modi-
     fied.






(C) INRIA     Last change: 2020/02/11 (version 1.1)            15






OPEN/CAESAR MANUAL                          caesar_table_1(LOCAL)



      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____GGGGEEEETTTT____TTTTAAAABBBBLLLLEEEE____1111

     vvvvooooiiiidddd CCCCAAAAEEEESSSSAAAARRRR____GGGGEEEETTTT____TTTTAAAABBBBLLLLEEEE____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____TTTT))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____TTTTAAAABBBBLLLLEEEE____1111 CCCCAAAAEEEESSSSAAAARRRR____TTTT;;;;
        {{{{ ............ }}}}

     This    procedure    increments     CCCCAAAAEEEESSSSAAAARRRR____GGGGEEEETTTT____IIIINNNNDDDDEEEEXXXX____TTTTAAAABBBBLLLLEEEE____1111
     ((((CCCCAAAAEEEESSSSAAAARRRR____TTTT))));         it        advances,        respectively,
     CCCCAAAAEEEESSSSAAAARRRR____GGGGEEEETTTT____BBBBAAAASSSSEEEE____TTTTAAAABBBBLLLLEEEE____1111            ((((CCCCAAAAEEEESSSSAAAARRRR____TTTT))))            and
     CCCCAAAAEEEESSSSAAAARRRR____GGGGEEEETTTT____MMMMAAAARRRRKKKK____TTTTAAAABBBBLLLLEEEE____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____TTTT)))) to the base field and the
     mark field (if any) of the next free item.

     If   CCCCAAAAEEEESSSSAAAARRRR____GGGGEEEETTTT____IIIINNNNDDDDEEEEXXXX____TTTTAAAABBBBLLLLEEEE____1111   ((((CCCCAAAAEEEESSSSAAAARRRR____TTTT))))   is   equal   to
     CCCCAAAAEEEESSSSAAAARRRR____PPPPUUUUTTTT____IIIINNNNDDDDEEEEXXXX____TTTTAAAABBBBLLLLEEEE____1111   ((((CCCCAAAAEEEESSSSAAAARRRR____TTTT))))   when  the  procedure
     CCCCAAAAEEEESSSSAAAARRRR____GGGGEEEETTTT____TTTTAAAABBBBLLLLEEEE____1111(((()))) is called, the result is undefined.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____EEEEMMMMPPPPTTTTYYYY____TTTTAAAABBBBLLLLEEEE____1111

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____BBBBOOOOOOOOLLLLEEEEAAAANNNN CCCCAAAAEEEESSSSAAAARRRR____EEEEMMMMPPPPTTTTYYYY____TTTTAAAABBBBLLLLEEEE____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____TTTT))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____TTTTAAAABBBBLLLLEEEE____1111 CCCCAAAAEEEESSSSAAAARRRR____TTTT;;;;
        {{{{ ............ }}}}

     This function returns a value different from 0 if the  table
     pointed   to   by   CCCCAAAAEEEESSSSAAAARRRR____TTTT  is  empty,  and  0  otherwise.
     CCCCAAAAEEEESSSSAAAARRRR____EEEEMMMMPPPPTTTTYYYY____TTTTAAAABBBBLLLLEEEE____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____TTTT)))) is always equivalent to:

               CCCCAAAAEEEESSSSAAAARRRR____PPPPUUUUTTTT____IIIINNNNDDDDEEEEXXXX____TTTTAAAABBBBLLLLEEEE____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____TTTT)))) ======== 0000



      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____FFFFUUUULLLLLLLL____TTTTAAAABBBBLLLLEEEE____1111

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____BBBBOOOOOOOOLLLLEEEEAAAANNNN CCCCAAAAEEEESSSSAAAARRRR____FFFFUUUULLLLLLLL____TTTTAAAABBBBLLLLEEEE____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____TTTT))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____TTTTAAAABBBBLLLLEEEE____1111 CCCCAAAAEEEESSSSAAAARRRR____TTTT;;;;
        {{{{ ............ }}}}

     This function returns a value different from 0 if the  table
     pointed   to   by   CCCCAAAAEEEESSSSAAAARRRR____TTTT   is  full,  and  0  otherwise.
     CCCCAAAAEEEESSSSAAAARRRR____FFFFUUUULLLLLLLL____TTTTAAAABBBBLLLLEEEE____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____TTTT)))) is always equivalent to:

              CCCCAAAAEEEESSSSAAAARRRR____PPPPUUUUTTTT____IIIINNNNDDDDEEEEXXXX____TTTTAAAABBBBLLLLEEEE____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____TTTT)))) ======== $$$$NNNN$$$$

     where N denotes the maximum number of items that  the  table
     can  contain;  the  value  of  N depends on the actual value
     given to the formal  parameter  CCCCAAAAEEEESSSSAAAARRRR____LLLLIIIIMMMMIIIITTTT____SSSSIIIIZZZZEEEE  when  the



(C) INRIA     Last change: 2020/02/11 (version 1.1)            16






OPEN/CAESAR MANUAL                          caesar_table_1(LOCAL)



     table was created using CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTEEEE____TTTTAAAABBBBLLLLEEEE____1111(((()))).


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____EEEEXXXXPPPPLLLLOOOORRRREEEEDDDD____TTTTAAAABBBBLLLLEEEE____1111

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____BBBBOOOOOOOOLLLLEEEEAAAANNNN CCCCAAAAEEEESSSSAAAARRRR____EEEEXXXXPPPPLLLLOOOORRRREEEEDDDD____TTTTAAAABBBBLLLLEEEE____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____TTTT))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____TTTTAAAABBBBLLLLEEEE____1111 CCCCAAAAEEEESSSSAAAARRRR____TTTT;;;;
        {{{{ ............ }}}}

     This function returns a value different from 0  if  the  get
     index  and  the  put  index  are  identical, or 0 otherwise.
     CCCCAAAAEEEESSSSAAAARRRR____EEEEXXXXPPPPLLLLOOOORRRREEEEDDDD____TTTTAAAABBBBLLLLEEEE____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____TTTT)))) is always equivalent to:

 CCCCAAAAEEEESSSSAAAARRRR____GGGGEEEETTTT____IIIINNNNDDDDEEEEXXXX____TTTTAAAABBBBLLLLEEEE____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____TTTT)))) ======== CCCCAAAAEEEESSSSAAAARRRR____PPPPUUUUTTTT____IIIINNNNDDDDEEEEXXXX____TTTTAAAABBBBLLLLEEEE____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____TTTT))))



      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____RRRREEEETTTTRRRRIIIIEEEEVVVVEEEE____IIII____BBBB____TTTTAAAABBBBLLLLEEEE____1111

     vvvvooooiiiidddd CCCCAAAAEEEESSSSAAAARRRR____RRRREEEETTTTRRRRIIIIEEEEVVVVEEEE____IIII____BBBB____TTTTAAAABBBBLLLLEEEE____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____TTTT,,,, CCCCAAAAEEEESSSSAAAARRRR____IIII,,,, CCCCAAAAEEEESSSSAAAARRRR____BBBB))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____TTTTAAAABBBBLLLLEEEE____1111 CCCCAAAAEEEESSSSAAAARRRR____TTTT;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____IIIINNNNDDDDEEEEXXXX____TTTTAAAABBBBLLLLEEEE____1111 CCCCAAAAEEEESSSSAAAARRRR____IIII;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____PPPPOOOOIIIINNNNTTTTEEEERRRR ****CCCCAAAAEEEESSSSAAAARRRR____BBBB;;;;
        {{{{ ............ }}}}

     This procedure computes the address of the base field of the
     item  with  index  CCCCAAAAEEEESSSSAAAARRRR____IIII  in  the  table  pointed  to  by
     CCCCAAAAEEEESSSSAAAARRRR____TTTT. This address is assigned to ****CCCCAAAAEEEESSSSAAAARRRR____BBBB.

     If CCCCAAAAEEEESSSSAAAARRRR____IIII is greater or equal to  the  value  returned  by
     CCCCAAAAEEEESSSSAAAARRRR____PPPPUUUUTTTT____IIIINNNNDDDDEEEEXXXX____TTTTAAAABBBBLLLLEEEE____1111(((()))),  a  NNNNUUUULLLLLLLL  pointer is assigned to
     ****CCCCAAAAEEEESSSSAAAARRRR____BBBB.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____RRRREEEETTTTRRRRIIIIEEEEVVVVEEEE____IIII____MMMM____TTTTAAAABBBBLLLLEEEE____1111

     vvvvooooiiiidddd CCCCAAAAEEEESSSSAAAARRRR____RRRREEEETTTTRRRRIIIIEEEEVVVVEEEE____IIII____MMMM____TTTTAAAABBBBLLLLEEEE____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____TTTT,,,, CCCCAAAAEEEESSSSAAAARRRR____IIII,,,, CCCCAAAAEEEESSSSAAAARRRR____MMMM))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____TTTTAAAABBBBLLLLEEEE____1111 CCCCAAAAEEEESSSSAAAARRRR____TTTT;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____IIIINNNNDDDDEEEEXXXX____TTTTAAAABBBBLLLLEEEE____1111 CCCCAAAAEEEESSSSAAAARRRR____IIII;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____PPPPOOOOIIIINNNNTTTTEEEERRRR ****CCCCAAAAEEEESSSSAAAARRRR____MMMM;;;;
        {{{{ ............ }}}}

     This procedure computes the address of the mark field of the
     item  with  index  CCCCAAAAEEEESSSSAAAARRRR____IIII  in  the  table  pointed  to  by
     CCCCAAAAEEEESSSSAAAARRRR____TTTT. This address is assigned to ****CCCCAAAAEEEESSSSAAAARRRR____MMMM.




(C) INRIA     Last change: 2020/02/11 (version 1.1)            17






OPEN/CAESAR MANUAL                          caesar_table_1(LOCAL)



     If CCCCAAAAEEEESSSSAAAARRRR____IIII is greater or equal to  the  value  returned  by
     CCCCAAAAEEEESSSSAAAARRRR____PPPPUUUUTTTT____IIIINNNNDDDDEEEEXXXX____TTTTAAAABBBBLLLLEEEE____1111(((()))),  a  NNNNUUUULLLLLLLL  pointer is assigned to
     ****CCCCAAAAEEEESSSSAAAARRRR____MMMM.

     If there are no mark fields in the table (due  to  the  ini-
     tialization  parameters supplied to CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTEEEE____TTTTAAAABBBBLLLLEEEE____1111(((()))))
     the effect of this procedure is undefined.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____RRRREEEETTTTRRRRIIIIEEEEVVVVEEEE____IIII____BBBBMMMM____TTTTAAAABBBBLLLLEEEE____1111

     vvvvooooiiiidddd CCCCAAAAEEEESSSSAAAARRRR____RRRREEEETTTTRRRRIIIIEEEEVVVVEEEE____IIII____BBBBMMMM____TTTTAAAABBBBLLLLEEEE____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____TTTT,,,, CCCCAAAAEEEESSSSAAAARRRR____IIII,,,, CCCCAAAAEEEESSSSAAAARRRR____BBBB,,,, CCCCAAAAEEEESSSSAAAARRRR____MMMM))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____TTTTAAAABBBBLLLLEEEE____1111 CCCCAAAAEEEESSSSAAAARRRR____TTTT;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____IIIINNNNDDDDEEEEXXXX____TTTTAAAABBBBLLLLEEEE____1111 CCCCAAAAEEEESSSSAAAARRRR____IIII;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____PPPPOOOOIIIINNNNTTTTEEEERRRR ****CCCCAAAAEEEESSSSAAAARRRR____BBBB;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____PPPPOOOOIIIINNNNTTTTEEEERRRR ****CCCCAAAAEEEESSSSAAAARRRR____MMMM;;;;
        {{{{ ............ }}}}

     This procedure computes the address of the base field of the
     item  with  index  CCCCAAAAEEEESSSSAAAARRRR____IIII  in  the  table  pointed  to  by
     CCCCAAAAEEEESSSSAAAARRRR____TTTT. This address is assigned to ****CCCCAAAAEEEESSSSAAAARRRR____BBBB.

     It also computes the address of the mark field of  the  item
     with  index  CCCCAAAAEEEESSSSAAAARRRR____IIII  in  the table pointed to by CCCCAAAAEEEESSSSAAAARRRR____TTTT.
     This address is assigned to ****CCCCAAAAEEEESSSSAAAARRRR____MMMM.

     If CCCCAAAAEEEESSSSAAAARRRR____IIII is greater or equal to  the  value  returned  by
     CCCCAAAAEEEESSSSAAAARRRR____PPPPUUUUTTTT____IIIINNNNDDDDEEEEXXXX____TTTTAAAABBBBLLLLEEEE____1111(((()))),  a  NNNNUUUULLLLLLLL  pointer is assigned to
     ****CCCCAAAAEEEESSSSAAAARRRR____BBBB and ****CCCCAAAAEEEESSSSAAAARRRR____MMMM.

     If there are no mark fields in the table (due  to  the  ini-
     tialization  parameters supplied to CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTEEEE____TTTTAAAABBBBLLLLEEEE____1111(((()))))
     the effect of this procedure is undefined.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____RRRREEEETTTTRRRRIIIIEEEEVVVVEEEE____BBBB____IIII____TTTTAAAABBBBLLLLEEEE____1111

     vvvvooooiiiidddd CCCCAAAAEEEESSSSAAAARRRR____RRRREEEETTTTRRRRIIIIEEEEVVVVEEEE____BBBB____IIII____TTTTAAAABBBBLLLLEEEE____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____TTTT,,,, CCCCAAAAEEEESSSSAAAARRRR____BBBB,,,, CCCCAAAAEEEESSSSAAAARRRR____IIII))))
     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____TTTTAAAABBBBLLLLEEEE____1111 CCCCAAAAEEEESSSSAAAARRRR____TTTT;;;;
     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____PPPPOOOOIIIINNNNTTTTEEEERRRR CCCCAAAAEEEESSSSAAAARRRR____BBBB;;;;
     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____IIIINNNNDDDDEEEEXXXX____TTTTAAAABBBBLLLLEEEE____1111 ****CCCCAAAAEEEESSSSAAAARRRR____IIII;;;;
        {{{{ ............ }}}}

     This procedure computes the index of  the  item  whose  base
     field, in the table pointed to by CCCCAAAAEEEESSSSAAAARRRR____TTTT, is pointed to by
     CCCCAAAAEEEESSSSAAAARRRR____BBBB. This index is assigned to ****CCCCAAAAEEEESSSSAAAARRRR____IIII.

     If no item stored in the table has a base field  at  address



(C) INRIA     Last change: 2020/02/11 (version 1.1)            18






OPEN/CAESAR MANUAL                          caesar_table_1(LOCAL)



     CCCCAAAAEEEESSSSAAAARRRR____BBBB, the CCCCAAAAEEEESSSSAAAARRRR____NNNNUUUULLLLLLLL____IIIINNNNDDDDEEEEXXXX____TTTTAAAABBBBLLLLEEEE____1111 value is assigned to
     ****CCCCAAAAEEEESSSSAAAARRRR____IIII.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____RRRREEEETTTTRRRRIIIIEEEEVVVVEEEE____MMMM____IIII____TTTTAAAABBBBLLLLEEEE____1111

     vvvvooooiiiidddd CCCCAAAAEEEESSSSAAAARRRR____RRRREEEETTTTRRRRIIIIEEEEVVVVEEEE____MMMM____IIII____TTTTAAAABBBBLLLLEEEE____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____TTTT,,,, CCCCAAAAEEEESSSSAAAARRRR____MMMM,,,, CCCCAAAAEEEESSSSAAAARRRR____IIII))))
     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____TTTTAAAABBBBLLLLEEEE____1111 CCCCAAAAEEEESSSSAAAARRRR____TTTT;;;;
     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____PPPPOOOOIIIINNNNTTTTEEEERRRR CCCCAAAAEEEESSSSAAAARRRR____MMMM;;;;
     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____IIIINNNNDDDDEEEEXXXX____TTTTAAAABBBBLLLLEEEE____1111 ****CCCCAAAAEEEESSSSAAAARRRR____IIII;;;;
        {{{{ ............ }}}}

     This procedure computes the index of  the  item  whose  mark
     field, in the table pointed to by CCCCAAAAEEEESSSSAAAARRRR____TTTT, is pointed to by
     CCCCAAAAEEEESSSSAAAARRRR____MMMM. This index is assigned to ****CCCCAAAAEEEESSSSAAAARRRR____IIII.

     If no item stored in the table has a mark field  at  address
     CCCCAAAAEEEESSSSAAAARRRR____MMMM, the CCCCAAAAEEEESSSSAAAARRRR____NNNNUUUULLLLLLLL____IIIINNNNDDDDEEEEXXXX____TTTTAAAABBBBLLLLEEEE____1111 value is assigned to
     ****CCCCAAAAEEEESSSSAAAARRRR____IIII.

     If there are no mark fields in the table (due  to  the  ini-
     tialization  parameters supplied to CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTEEEE____TTTTAAAABBBBLLLLEEEE____1111(((()))))
     the effect of this procedure is undefined.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____RRRREEEETTTTRRRRIIIIEEEEVVVVEEEE____BBBB____MMMM____TTTTAAAABBBBLLLLEEEE____1111

     vvvvooooiiiidddd CCCCAAAAEEEESSSSAAAARRRR____RRRREEEETTTTRRRRIIIIEEEEVVVVEEEE____BBBB____MMMM____TTTTAAAABBBBLLLLEEEE____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____TTTT,,,, CCCCAAAAEEEESSSSAAAARRRR____BBBB,,,, CCCCAAAAEEEESSSSAAAARRRR____MMMM))))
     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____TTTTAAAABBBBLLLLEEEE____1111 CCCCAAAAEEEESSSSAAAARRRR____TTTT;;;;
     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____PPPPOOOOIIIINNNNTTTTEEEERRRR CCCCAAAAEEEESSSSAAAARRRR____BBBB;;;;
     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____PPPPOOOOIIIINNNNTTTTEEEERRRR ****CCCCAAAAEEEESSSSAAAARRRR____MMMM;;;;
        {{{{ ............ }}}}

     This  procedure  computes,  for  the  table  pointed  to  by
     CCCCAAAAEEEESSSSAAAARRRR____TTTT,  the  address  of the mark field of the item whose
     base field is  pointed  to  by  CCCCAAAAEEEESSSSAAAARRRR____BBBB.  This  address  is
     assigned to ****CCCCAAAAEEEESSSSAAAARRRR____MMMM.

     If no item stored in the table has a base field  at  address
     CCCCAAAAEEEESSSSAAAARRRR____BBBB, the effect of this procedure is undefined.

     If there are no mark fields in the table (due  to  the  ini-
     tialization  parameters supplied to CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTEEEE____TTTTAAAABBBBLLLLEEEE____1111(((()))))
     the effect of this procedure is undefined.


      ............................................................




(C) INRIA     Last change: 2020/02/11 (version 1.1)            19






OPEN/CAESAR MANUAL                          caesar_table_1(LOCAL)



  CCCCAAAAEEEESSSSAAAARRRR____RRRREEEETTTTRRRRIIIIEEEEVVVVEEEE____MMMM____BBBB____TTTTAAAABBBBLLLLEEEE____1111

     vvvvooooiiiidddd CCCCAAAAEEEESSSSAAAARRRR____RRRREEEETTTTRRRRIIIIEEEEVVVVEEEE____MMMM____BBBB____TTTTAAAABBBBLLLLEEEE____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____TTTT,,,, CCCCAAAAEEEESSSSAAAARRRR____MMMM,,,, CCCCAAAAEEEESSSSAAAARRRR____BBBB))))
     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____TTTTAAAABBBBLLLLEEEE____1111 CCCCAAAAEEEESSSSAAAARRRR____TTTT;;;;
     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____PPPPOOOOIIIINNNNTTTTEEEERRRR CCCCAAAAEEEESSSSAAAARRRR____MMMM;;;;
     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____PPPPOOOOIIIINNNNTTTTEEEERRRR ****CCCCAAAAEEEESSSSAAAARRRR____BBBB;;;;
        {{{{ ............ }}}}

     This  procedure  computes,  for  the  table  pointed  to  by
     CCCCAAAAEEEESSSSAAAARRRR____TTTT,  the  address  of the base field of the item whose
     mark field is  pointed  to  by  CCCCAAAAEEEESSSSAAAARRRR____MMMM.  This  address  is
     assigned to ****CCCCAAAAEEEESSSSAAAARRRR____BBBB.

     If no item stored in the table has a mark field  at  address
     CCCCAAAAEEEESSSSAAAARRRR____MMMM, the effect of this procedure is undefined.

     If there are no mark fields in the table (due  to  the  ini-
     tialization  parameters supplied to CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTEEEE____TTTTAAAABBBBLLLLEEEE____1111(((()))))
     the effect of this procedure is undefined.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____FFFFAAAAIIIILLLLUUUURRRREEEE____TTTTAAAABBBBLLLLEEEE____1111

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL CCCCAAAAEEEESSSSAAAARRRR____FFFFAAAAIIIILLLLUUUURRRREEEE____TTTTAAAABBBBLLLLEEEE____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____TTTT))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____TTTTAAAABBBBLLLLEEEE____1111 CCCCAAAAEEEESSSSAAAARRRR____TTTT;;;;
        {{{{ ............ }}}}

     This function returns the value of the  failure  counter  of
     the  table  pointed  to  by  CCCCAAAAEEEESSSSAAAARRRR____TTTT,  i.e.,  the number of
     searches that failed.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____SSSSUUUUCCCCCCCCEEEESSSSSSSS____TTTTAAAABBBBLLLLEEEE____1111

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL CCCCAAAAEEEESSSSAAAARRRR____SSSSUUUUCCCCCCCCEEEESSSSSSSS____TTTTAAAABBBBLLLLEEEE____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____TTTT))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____TTTTAAAABBBBLLLLEEEE____1111 CCCCAAAAEEEESSSSAAAARRRR____TTTT;;;;
        {{{{ ............ }}}}

     This function returns the value of the  success  counter  of
     the  table  pointed  to  by  CCCCAAAAEEEESSSSAAAARRRR____TTTT,  i.e.,  the number of
     searches that succeeded.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____FFFFOOOORRRRMMMMAAAATTTT____TTTTAAAABBBBLLLLEEEE____1111

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____FFFFOOOORRRRMMMMAAAATTTT CCCCAAAAEEEESSSSAAAARRRR____FFFFOOOORRRRMMMMAAAATTTT____TTTTAAAABBBBLLLLEEEE____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____TTTT,,,, CCCCAAAAEEEESSSSAAAARRRR____FFFFOOOORRRRMMMMAAAATTTT))))



(C) INRIA     Last change: 2020/02/11 (version 1.1)            20






OPEN/CAESAR MANUAL                          caesar_table_1(LOCAL)



        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____TTTTAAAABBBBLLLLEEEE____1111 CCCCAAAAEEEESSSSAAAARRRR____TTTT;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____FFFFOOOORRRRMMMMAAAATTTT CCCCAAAAEEEESSSSAAAARRRR____FFFFOOOORRRRMMMMAAAATTTT;;;;
        {{{{ ............ }}}}

     This function allows to control the format under  which  the
     table  pointed  to  by  CCCCAAAAEEEESSSSAAAARRRR____TTTT will be printed by the pro-
     cedure CCCCAAAAEEEESSSSAAAARRRR____PPPPRRRRIIIINNNNTTTT____TTTTAAAABBBBLLLLEEEE____1111(((()))) (see below).

     Currently, the following formats are available:

     -    With format 0, statistical information about the  table
          is  displayed  such  as:  the  number of items put, the
          number of items got, the size  in  bytes,  the  success
          counter, the failure counter, etc.

     -    With format 1, all items  in  the  table  are  printed,
          sorted  by  increasing  indexes.  For  each  item,  the
          corresponding index is displayed; the  base  field  and
          the  mark  field  (if any) are also displayed using the
          printing procedure associated to the table.

     -    With format 2, all items  in  the  table  are  printed,
          sorted by increasing indexes. For each item, the index,
          the  address,  and  the  corresponding  hash-value  are
          displayed;  the  base field and the mark field (if any)
          are also displayed using the printing procedure associ-
          ated  to the table. Informations concerning the associ-
          ated hash-table are  also  displayed.  This  format  is
          mainly intended for debugging purpose.

     -    (no other format available yet)

     By default, the current format of each table is  initialized
     to 0.

     When called with CCCCAAAAEEEESSSSAAAARRRR____FFFFOOOORRRRMMMMAAAATTTT between 0 and 2,  this  fonc-
     tion  sets  the  current format of CCCCAAAAEEEESSSSAAAARRRR____TTTT to CCCCAAAAEEEESSSSAAAARRRR____FFFFOOOORRRRMMMMAAAATTTT
     and returns an undefined result.

     When called with another value of CCCCAAAAEEEESSSSAAAARRRR____FFFFOOOORRRRMMMMAAAATTTT, this  func-
     tion  does  not  modify  the  current format of CCCCAAAAEEEESSSSAAAARRRR____TTTT but
     returns a result defined as  follows.  If  CCCCAAAAEEEESSSSAAAARRRR____FFFFOOOORRRRMMMMAAAATTTT  is
     equal  to  the constant CCCCAAAAEEEESSSSAAAARRRR____CCCCUUUURRRRRRRREEEENNNNTTTT____FFFFOOOORRRRMMMMAAAATTTT, the result is
     the  value  of  the   current   format   of   CCCCAAAAEEEESSSSAAAARRRR____TTTT.   If
     CCCCAAAAEEEESSSSAAAARRRR____FFFFOOOORRRRMMMMAAAATTTT      is      equal     to     the     constant
     CCCCAAAAEEEESSSSAAAARRRR____MMMMAAAAXXXXIIIIMMMMAAAALLLL____FFFFOOOORRRRMMMMAAAATTTT, the  result  is  the  maximal  format
     value  (i.e.,  2).  In  all  other cases, the effect of this
     function is undefined.







(C) INRIA     Last change: 2020/02/11 (version 1.1)            21






OPEN/CAESAR MANUAL                          caesar_table_1(LOCAL)



      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____MMMMAAAAXXXX____FFFFOOOORRRRMMMMAAAATTTT____TTTTAAAABBBBLLLLEEEE____1111

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____FFFFOOOORRRRMMMMAAAATTTT CCCCAAAAEEEESSSSAAAARRRR____MMMMAAAAXXXX____FFFFOOOORRRRMMMMAAAATTTT____TTTTAAAABBBBLLLLEEEE____1111 (((())))
        {{{{ ............ }}}}

     Caution! This function is deprecated. It should no longer be
     used,  as  it  might  be removed from future versions of the
     _O_P_E_N/_C_A_E_S_A_R. Use function  CCCCAAAAEEEESSSSAAAARRRR____FFFFOOOORRRRMMMMAAAATTTT____TTTTAAAABBBBLLLLEEEE____1111(((())))  instead,
     called with argument CCCCAAAAEEEESSSSAAAARRRR____MMMMAAAAXXXXIIIIMMMMAAAALLLL____FFFFOOOORRRRMMMMAAAATTTT.

     This function returns the maximal format value available for
     printing tables.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____PPPPRRRRIIIINNNNTTTT____TTTTAAAABBBBLLLLEEEE____1111

     vvvvooooiiiidddd CCCCAAAAEEEESSSSAAAARRRR____PPPPRRRRIIIINNNNTTTT____TTTTAAAABBBBLLLLEEEE____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____FFFFIIIILLLLEEEE,,,, CCCCAAAAEEEESSSSAAAARRRR____TTTT))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____FFFFIIIILLLLEEEE CCCCAAAAEEEESSSSAAAARRRR____FFFFIIIILLLLEEEE;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____TTTTAAAABBBBLLLLEEEE____1111 CCCCAAAAEEEESSSSAAAARRRR____TTTT;;;;
        {{{{ ............ }}}}

     This procedure prints to file CCCCAAAAEEEESSSSAAAARRRR____FFFFIIIILLLLEEEE a text  containing
     information  about  the  table  pointed  to by CCCCAAAAEEEESSSSAAAARRRR____TTTT. The
     nature of the information is determined by the current  for-
     mat of the table pointed to by CCCCAAAAEEEESSSSAAAARRRR____TTTT.

     Before this procedure is called, CCCCAAAAEEEESSSSAAAARRRR____FFFFIIIILLLLEEEE must have  been
     properly opened, for instance using ffffooooppppeeeennnn((((3333)))).

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



(C) INRIA     Last change: 2020/02/11 (version 1.1)            22






OPEN/CAESAR MANUAL                          caesar_table_1(LOCAL)



     Additional information is available from the CADP  Web  page
     located at http://cadp.inria.fr

     Directives   for   installation   are   given    in    files
     $$$$CCCCAAAADDDDPPPP////IIIINNNNSSSSTTTTAAAALLLLLLLLAAAATTTTIIIIOOOONNNN____****....

     Recent  changes  and  improvements  to  this  software   are
     reported and commented in file $$$$CCCCAAAADDDDPPPP////HHHHIIIISSSSTTTTOOOORRRRYYYY....

BBBBUUUUGGGGSSSS
     Known  bugs  are  described  in  the  Reference  Manual   of
     OPEN/CAESAR.  Please report new bugs to cadp@inria.fr











































(C) INRIA     Last change: 2020/02/11 (version 1.1)            23



