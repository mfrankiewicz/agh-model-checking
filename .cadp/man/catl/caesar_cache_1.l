


OPEN/CAESAR MANUAL                          caesar_cache_1(LOCAL)



NNNNAAAAMMMMEEEE
     caesar_cache_1 - the ``cache_1'' library of OPEN/CAESAR

PPPPUUUURRRRPPPPOOOOSSSSEEEE
     The ``cache_1''  library  provides  primitives  for  storing
     arbitrary  data  items  in  caches,  which  can be organized
     hierarchically. It can be used to speed up the execution  of
     applications that involve costly search operations (by stor-
     ing data items in caches for fast retrievals), and  also  to
     reduce  the  memory  consumption  of state space exploration
     algorithms  (by  storing  a  certain  amount  of  states  in
     caches).



UUUUSSSSAAAAGGGGEEEE
     The ``cache_1'' library consists of:

     -    a predefined header file ccccaaaaeeeessssaaaarrrr____ccccaaaacccchhhheeee____1111....hhhh;

     -    the precompiled library file lllliiiibbbbccccaaaaeeeessssaaaarrrr....aaaa, which  imple-
          ments the features described in ccccaaaaeeeessssaaaarrrr____ccccaaaacccchhhheeee____1111....hhhh.

     Note: The ``cache_1'' library  is  a  software  layer  built
     above   the   primitives   offered   by   the  ``standard'',
     ``area_1'', and ``hash'' libraries, and by  the  _O_P_E_N/_C_A_E_S_A_R
     graph module. It follows as close as possible the principles
     and features of the ``table_1'' library.



DDDDEEEESSSSCCCCRRRRIIIIPPPPTTTTIIIIOOOONNNN
     A ``cache'' is basically a set containing a fixed number  of
     items.

     Each item in the cache is basically a byte string  of  fixed
     size. All items in a given cache have the same size. An item
     can be considered as a tuple with two fields, whose size and
     contents are freely determined by the user:

     -    (1) a ``base'' field, that is a byte  string  of  fixed
          size.  In  a given cache, all base fields have the same
          size. This size must be greater than zero.

          Sometimes, the base field contains a state (as  defined
          in  the  graph module). However, this is not mandatory,
          and base fields  can  contain  other  information  than
          states.

     -    (2) a ``mark'' field, that is a byte string whose  size
          and  contents  are  freely determined by the user. In a
          given cache, all mark fields have the same size,  which



(C) INRIA     Last change: 2020/02/11 (version 1.2)             1






OPEN/CAESAR MANUAL                          caesar_cache_1(LOCAL)



          must  be  greater  or  equal  to zero. Pointers to mark
          fields  will  be   considered   as   values   of   type
          CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____PPPPOOOOIIIINNNNTTTTEEEERRRR;  mark fields are always aligned on
          appropriate boundaries so that the  user  can  put  any
          information in these fields without alignment problem.

     The user also determines the nature of the  data  stored  in
     these  fields,  which  is  not meaningful to the ``cache_1''
     library.

     A cache is organized as a collection of ``subcaches'',  each
     one  containing a fixed number of items. A cache can contain
     no more than a maximum of P subcaches, where currently  P  =
     256.  In  a  cache  containing N subcaches, each subcache is
     assigned an unique index in the range 0..N-1. The  subcaches
     are  linked hierarchically by a parent relation, which links
     a subcache to its ``children'' subcaches. The  parent  rela-
     tion  is an acyclic relation having as root element the sub-
     cache of index 0, denoted ``root subcache'' in  the  sequel.
     All the other subcaches are assumed to be descendants of the
     root subcache, i.e., they should be reachable from the  root
     subcache  via  the parent relation. A subcache without chil-
     dren subcaches is called a  ``leaf''  subcache.  The  parent
     relation linking the subcaches of a cache is not necessarily
     static, but can dynamically change during the usage  of  the
     cache.

     A cache can contain no more  than  a  maximum  of  M  items.
     Currently, M = 2^{29} = 536,870,912 on 32-bit machines and M
     = 2^{34} = 17,179,869,184 on 64-bit machines. But, for  each
     cache,  the  user can also limit the maximal number of items
     to a lesser bound K < M.

     To each cache is associated its current global  date,  which
     is the number of modifying operations performed on the cache
     since it was created. The operations modifying the status of
     a  cache  are the following: putting an item into the cache,
     ``hitting'' an item (i.e., searching and finding  the  item)
     in  the cache, deleting an item from the cache, and updating
     an item present in the cache. In the sequel,  whenever  this
     is  understood  from  the  context,  we  will  use  the term
     ``date'' to designate the current global date of a cache. To
     each  subcache  of  a  cache is associated its current local
     date, i.e., the date when the last modifying  operation  was
     performed on an item present in the subcache.

     To each item present in a cache are associated the following
     fields:

     -    the date when the item was put into the cache;

     -    the date of the last access to the item  by  a  put,  a



(C) INRIA     Last change: 2020/02/11 (version 1.2)             2






OPEN/CAESAR MANUAL                          caesar_cache_1(LOCAL)



          hit, or an update operation;

     -    the number of hits at the item since it  was  put  into
          the cache.

     All these fields can be accessed from  the  address  of  the
     item  (i.e., a pointer to the memory location where the item
     is stored in the cache).

     Invariant property 1: all items present in a cache have dif-
     ferent  dates  when they were put into the cache. Therefore,
     the date when an item was put into the cache  can  serve  as
     unique identification number for the item.

     Invariant property 2: all items present in a cache have dif-
     ferent  last  access  dates  (but several items may have the
     same number of hits).

     Invariant property 3: it is not allowed to modify  the  base
     field of any item in the cache. But it is possible to modify
     the mark field of any item.

     Each item of a cache can be accessed by using its address or
     its  base  field.  The  cache  data  structure establishes a
     correspondence between these two data. Indeed:

     -    given an address, one can retrieve the base  field  and
          the mark field of the corresponding item;

     -    given a base field, one can retrieve  the  address  and
          the mark field of the corresponding item.

     Retrieving the address  of  an  item  from  its  base  field
     involves  some associative search. To allow fast retrievals,
     a hash-table is associated to  each  cache.  This  is  quite
     transparent  from  the  user's  point of view. Only the base
     field is taken into account when  computing  the  hash-value
     and  comparing  items;  the mark field is not meaningful for
     the search.

     To each cache are  associated  two  counters  recording  the
     number  of search and hit operations performed on the cache,
     respectively. To each subcache of a cache  is  associated  a
     counter recording the number of hit operations at (items of)
     that subcache.

     The operation of putting an item E into a cache proceeds  as
     follows.  The  item is always put into the root subcache (of
     index 0). When  this  subcache  becomes  full,  the  item  E
     replaces  the  smallest  item  E1 contained in this subcache
     according to the order relation underlying  the  replacement
     strategy  associated  to  this  subcache. The item E1 is put



(C) INRIA     Last change: 2020/02/11 (version 1.2)             3






OPEN/CAESAR MANUAL                          caesar_cache_1(LOCAL)



     into one of the child subcaches (of index I1)  of  the  root
     subcache,  determined  by  the  parent relation between sub-
     caches and by the contents of the item E1. If  the  subcache
     of  index  I1  is  also  full, then the item E1 replaces the
     smallest item E2 contained in this subcache, and the item E2
     will  be  in turn put into a child subcache (of index I2) of
     the subcache of index I1, and so on. This process  continues
     along  a sequence of subcaches in the hierarchy until either
     it reaches a subcache of index Ij that is not full (and  can
     therefore  accept the current item Ej to be put into it), or
     it reaches a leaf subcache of index Ik that is full. In  the
     latter  case, the item Ek+1 replaced in the leaf subcache is
     stored temporarily in a field associated to the cache  until
     the next put operation on the cache causes another item El+1
     to be replaced in some leaf subcache of  index  Il  that  is
     already  full; the item Ek+1 is then deleted and replaced by
     El+1.

     The parent relation between the  subcaches  of  a  cache  is
     assumed to be acyclic (in order to ensure the termination of
     put operations), but this condition cannot be checked at the
     creation of the cache because the parent relation may change
     dynamically during execution.  Instead,  this  condition  is
     checked  at  each put operation, and if a cycle between sub-
     caches is detected, then the operation  is  stopped  and  an
     appropriate error code is set.

     The  ``cache_1''  library  supports  applications  involving
     dynamic  creation  of caches. When a put operation performed
     on a cache C1 causes a replacement to  take  place,  another
     cache  C2  can  be  created and the last item replaced in C1
     (which      can      be      inspected       using       the
     CCCCAAAAEEEESSSSAAAARRRR____LLLLAAAASSSSTTTT____IIIITTTTEEEEMMMM____RRRREEEEPPPPLLLLAAAACCCCEEEEDDDD____CCCCAAAACCCCHHHHEEEE____1111(((())))  procedure below) can be
     put into C2. This enables to  build  hierarchies  of  caches
     similar  to  the hierarchies of subcaches present in indivi-
     dual caches. It is the user's responsibility to ensure  that
     a put operation performed on a cache of a hierarchy does not
     cause a cycle of put operations on the other caches  of  the
     hierarchy.



FFFFEEEEAAAATTTTUUUURRRREEEESSSS
      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____CCCCAAAACCCCHHHHEEEE____1111

     ttttyyyyppppeeeeddddeeeeffff CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____AAAABBBBSSSSTTTTRRRRAAAACCCCTTTT ((((............)))) CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____CCCCAAAACCCCHHHHEEEE____1111;;;;

     This type denotes a pointer to the  concrete  representation
     of   a   cache.   This  representation  is  supposed  to  be
     ``opaque''.



(C) INRIA     Last change: 2020/02/11 (version 1.2)             4






OPEN/CAESAR MANUAL                          caesar_cache_1(LOCAL)



      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN____CCCCAAAACCCCHHHHEEEE____1111

     ttttyyyyppppeeeeddddeeeeffff CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL
        ((((****CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN____CCCCAAAACCCCHHHHEEEE____1111)))) ((((CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL))));;;;

     This type denotes a pointer to a  function  which  takes  as
     parameter a natural number (index of a subcache) and returns
     a natural number (size or percentage of the subcache).


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____OOOORRRRDDDDEEEERRRR____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN____CCCCAAAACCCCHHHHEEEE____1111

     ttttyyyyppppeeeeddddeeeeffff CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____IIIINNNNTTTTEEEEGGGGEEEERRRR
        ((((****CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____OOOORRRRDDDDEEEERRRR____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN____CCCCAAAACCCCHHHHEEEE____1111)))) ((((CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____CCCCAAAACCCCHHHHEEEE____1111,,,,
           CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____PPPPOOOOIIIINNNNTTTTEEEERRRR,,,, CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____PPPPOOOOIIIINNNNTTTTEEEERRRR))));;;;

     This type denotes a pointer to a  function  which  takes  as
     parameters a cache and two pointers to items (supposed to be
     contained in the cache), and returns an integer number indi-
     cating  whether the first item is smaller than, equal to, or
     greater than the second one modulo an order relation.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSUUUUBBBBCCCCAAAACCCCHHHHEEEE____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN____CCCCAAAACCCCHHHHEEEE____1111

     ttttyyyyppppeeeeddddeeeeffff CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL
        ((((****CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSUUUUBBBBCCCCAAAACCCCHHHHEEEE____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN____CCCCAAAACCCCHHHHEEEE____1111)))) ((((CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____CCCCAAAACCCCHHHHEEEE____1111,,,,
           CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL,,,, CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____PPPPOOOOIIIINNNNTTTTEEEERRRR))));;;;

     This type denotes a pointer to a  function  which  takes  as
     parameters  a  cache, a natural number (index of a subcache)
     and a pointer to an item (the last item replaced in the sub-
     cache),  and  returns  a  natural number (index of the child
     subcache in which the replaced item will be put).


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____CCCCLLLLEEEEAAAANNNNUUUUPPPP____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN____CCCCAAAACCCCHHHHEEEE____1111

     ttttyyyyppppeeeeddddeeeeffff vvvvooooiiiidddd
        ((((****CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____CCCCLLLLEEEEAAAANNNNUUUUPPPP____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN____CCCCAAAACCCCHHHHEEEE____1111)))) ((((CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____PPPPOOOOIIIINNNNTTTTEEEERRRR))));;;;

     This type denotes a pointer to a procedure  which  takes  as
     parameter a pointer to an item and cleans up the contents of
     the item (see the procedure CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTEEEE____CCCCAAAACCCCHHHHEEEE____1111(((()))) below).



(C) INRIA     Last change: 2020/02/11 (version 1.2)             5






OPEN/CAESAR MANUAL                          caesar_cache_1(LOCAL)



      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____EEEERRRRRRRROOOORRRR____CCCCAAAACCCCHHHHEEEE____1111

     ttttyyyyppppeeeeddddeeeeffff eeeennnnuuuummmm {{{{
          CCCCAAAAEEEESSSSAAAARRRR____NNNNOOOONNNNEEEE____CCCCAAAACCCCHHHHEEEE____1111,,,,
          CCCCAAAAEEEESSSSAAAARRRR____CCCCYYYYCCCCLLLLIIIICCCC____CCCCAAAACCCCHHHHEEEE____1111
     }}}}    CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____EEEERRRRRRRROOOORRRR____CCCCAAAACCCCHHHHEEEE____1111;;;;

     This enumerated type defines the error codes produced  as  a
     side  effect  by calls to the procedure CCCCAAAAEEEESSSSAAAARRRR____PPPPUUUUTTTT____CCCCAAAACCCCHHHHEEEE____1111(((())))
     or  to  the  function  CCCCAAAAEEEESSSSAAAARRRR____SSSSEEEEAAAARRRRCCCCHHHH____AAAANNNNDDDD____PPPPUUUUTTTT____CCCCAAAACCCCHHHHEEEE____1111(((())))  (see
     below), which put an item into a cache. The error codes have
     the following meaning:

     -    CCCCAAAAEEEESSSSAAAARRRR____NNNNOOOONNNNEEEE____CCCCAAAACCCCHHHHEEEE____1111 indicates that  the  put  operation
          was performed successfully.

     -    CCCCAAAAEEEESSSSAAAARRRR____CCCCYYYYCCCCLLLLIIIICCCC____CCCCAAAACCCCHHHHEEEE____1111  indicates  the  existence  of  a
          cycle  in  the parent relation between subcaches, which
          would cause the put operation to loop indefinitely when
          the subcaches present on that cycle are full.

     Note: The error code produced by a  call  to  the  procedure
     CCCCAAAAEEEESSSSAAAARRRR____PPPPUUUUTTTT____CCCCAAAACCCCHHHHEEEE____1111(((())))       or      to      the      function
     CCCCAAAAEEEESSSSAAAARRRR____SSSSEEEEAAAARRRRCCCCHHHH____AAAANNNNDDDD____PPPPUUUUTTTT____CCCCAAAACCCCHHHHEEEE____1111(((()))) can be obtained by using the
     function CCCCAAAAEEEESSSSAAAARRRR____SSSSTTTTAAAATTTTUUUUSSSS____PPPPUUUUTTTT____CCCCAAAACCCCHHHHEEEE____1111(((()))) (see below).


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____LLLLRRRRUUUU____OOOORRRRDDDDEEEERRRR____CCCCAAAACCCCHHHHEEEE____1111

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____IIIINNNNTTTTEEEEGGGGEEEERRRR CCCCAAAAEEEESSSSAAAARRRR____LLLLRRRRUUUU____OOOORRRRDDDDEEEERRRR____CCCCAAAACCCCHHHHEEEE____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____CCCC,,,, CCCCAAAAEEEESSSSAAAARRRR____BBBB1111,,,, CCCCAAAAEEEESSSSAAAARRRR____BBBB2222))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____CCCCAAAACCCCHHHHEEEE____1111 CCCCAAAAEEEESSSSAAAARRRR____CCCC;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____PPPPOOOOIIIINNNNTTTTEEEERRRR CCCCAAAAEEEESSSSAAAARRRR____BBBB1111;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____PPPPOOOOIIIINNNNTTTTEEEERRRR CCCCAAAAEEEESSSSAAAARRRR____BBBB2222;;;;
        {{{{ ............ }}}}

     This function returns an integer  number  which  is  smaller
     than, equal to, or greater than 0 depending whether the item
     pointed to by  CCCCAAAAEEEESSSSAAAARRRR____BBBB1111  is  smaller  than,  equal  to,  or
     greater  than  the item pointed to by CCCCAAAAEEEESSSSAAAARRRR____BBBB2222 according to
     the order relation underlying the  ``least  recently  used''
     (LRU) replacement strategy.

     According to this order relation, an item is  smaller  than,
     equal  to,  or  greater than another item if the date of the
     last access to the first item is smaller than, equal to,  or
     greater than the date of the last access to the second item,
     respectively.




(C) INRIA     Last change: 2020/02/11 (version 1.2)             6






OPEN/CAESAR MANUAL                          caesar_cache_1(LOCAL)



      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____MMMMRRRRUUUU____OOOORRRRDDDDEEEERRRR____CCCCAAAACCCCHHHHEEEE____1111

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____IIIINNNNTTTTEEEEGGGGEEEERRRR CCCCAAAAEEEESSSSAAAARRRR____MMMMRRRRUUUU____OOOORRRRDDDDEEEERRRR____CCCCAAAACCCCHHHHEEEE____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____CCCC,,,, CCCCAAAAEEEESSSSAAAARRRR____BBBB1111,,,, CCCCAAAAEEEESSSSAAAARRRR____BBBB2222))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____CCCCAAAACCCCHHHHEEEE____1111 CCCCAAAAEEEESSSSAAAARRRR____CCCC;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____PPPPOOOOIIIINNNNTTTTEEEERRRR CCCCAAAAEEEESSSSAAAARRRR____BBBB1111;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____PPPPOOOOIIIINNNNTTTTEEEERRRR CCCCAAAAEEEESSSSAAAARRRR____BBBB2222;;;;
        {{{{ ............ }}}}

     This function returns an integer  number  which  is  smaller
     than, equal to, or greater than 0 depending whether the item
     pointed to by  CCCCAAAAEEEESSSSAAAARRRR____BBBB1111  is  smaller  than,  equal  to,  or
     greater  than  the item pointed to by CCCCAAAAEEEESSSSAAAARRRR____BBBB2222 according to
     the order relation underlying  the  ``most  recently  used''
     (MRU) replacement strategy.

     According to this order relation, an item is  smaller  than,
     equal  to,  or  greater than another item if the date of the
     last access to the first item is greater than, equal to,  or
     smaller than the date of the last access to the second item,
     respectively.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____LLLLRRRRPPPP____OOOORRRRDDDDEEEERRRR____CCCCAAAACCCCHHHHEEEE____1111

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____IIIINNNNTTTTEEEEGGGGEEEERRRR CCCCAAAAEEEESSSSAAAARRRR____LLLLRRRRPPPP____OOOORRRRDDDDEEEERRRR____CCCCAAAACCCCHHHHEEEE____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____CCCC,,,, CCCCAAAAEEEESSSSAAAARRRR____BBBB1111,,,, CCCCAAAAEEEESSSSAAAARRRR____BBBB2222))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____CCCCAAAACCCCHHHHEEEE____1111 CCCCAAAAEEEESSSSAAAARRRR____CCCC;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____PPPPOOOOIIIINNNNTTTTEEEERRRR CCCCAAAAEEEESSSSAAAARRRR____BBBB1111;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____PPPPOOOOIIIINNNNTTTTEEEERRRR CCCCAAAAEEEESSSSAAAARRRR____BBBB2222;;;;
        {{{{ ............ }}}}

     This function returns an integer  number  which  is  smaller
     than, equal to, or greater than 0 depending whether the item
     pointed to by  CCCCAAAAEEEESSSSAAAARRRR____BBBB1111  is  smaller  than,  equal  to,  or
     greater  than  the item pointed to by CCCCAAAAEEEESSSSAAAARRRR____BBBB2222 according to
     the order relation underlying  the  ``least  recently  put''
     (LRP) replacement strategy.

     According to this order relation, an item is  smaller  than,
     equal  to, or greater than another item if the date when the
     first item was put into the cache is smaller than, equal to,
     or  greater  than the date when the second item was put into
     the cache, respectively.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____MMMMRRRRPPPP____OOOORRRRDDDDEEEERRRR____CCCCAAAACCCCHHHHEEEE____1111




(C) INRIA     Last change: 2020/02/11 (version 1.2)             7






OPEN/CAESAR MANUAL                          caesar_cache_1(LOCAL)



     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____IIIINNNNTTTTEEEEGGGGEEEERRRR CCCCAAAAEEEESSSSAAAARRRR____MMMMRRRRPPPP____OOOORRRRDDDDEEEERRRR____CCCCAAAACCCCHHHHEEEE____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____CCCC,,,, CCCCAAAAEEEESSSSAAAARRRR____BBBB1111,,,, CCCCAAAAEEEESSSSAAAARRRR____BBBB2222))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____CCCCAAAACCCCHHHHEEEE____1111 CCCCAAAAEEEESSSSAAAARRRR____CCCC;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____PPPPOOOOIIIINNNNTTTTEEEERRRR CCCCAAAAEEEESSSSAAAARRRR____BBBB1111;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____PPPPOOOOIIIINNNNTTTTEEEERRRR CCCCAAAAEEEESSSSAAAARRRR____BBBB2222;;;;
        {{{{ ............ }}}}

     This function returns an integer  number  which  is  smaller
     than, equal to, or greater than 0 depending whether the item
     pointed to by  CCCCAAAAEEEESSSSAAAARRRR____BBBB1111  is  smaller  than,  equal  to,  or
     greater  than  the item pointed to by CCCCAAAAEEEESSSSAAAARRRR____BBBB2222 according to
     the order relation  underlying  the  ``most  recently  put''
     (MRP) replacement strategy.

     According to this order relation, an item is  smaller  than,
     equal  to, or greater than another item if the date when the
     first item was put into the cache is greater than, equal to,
     or  smaller  than the date when the second item was put into
     the cache, respectively.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____LLLLFFFFUUUU____OOOORRRRDDDDEEEERRRR____CCCCAAAACCCCHHHHEEEE____1111

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____IIIINNNNTTTTEEEEGGGGEEEERRRR CCCCAAAAEEEESSSSAAAARRRR____LLLLFFFFUUUU____OOOORRRRDDDDEEEERRRR____CCCCAAAACCCCHHHHEEEE____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____CCCC,,,, CCCCAAAAEEEESSSSAAAARRRR____BBBB1111,,,, CCCCAAAAEEEESSSSAAAARRRR____BBBB2222))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____CCCCAAAACCCCHHHHEEEE____1111 CCCCAAAAEEEESSSSAAAARRRR____CCCC;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____PPPPOOOOIIIINNNNTTTTEEEERRRR CCCCAAAAEEEESSSSAAAARRRR____BBBB1111;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____PPPPOOOOIIIINNNNTTTTEEEERRRR CCCCAAAAEEEESSSSAAAARRRR____BBBB2222;;;;
        {{{{ ............ }}}}

     This function returns an integer  number  which  is  smaller
     than, equal to, or greater than 0 depending whether the item
     pointed to by  CCCCAAAAEEEESSSSAAAARRRR____BBBB1111  is  smaller  than,  equal  to,  or
     greater  than  the item pointed to by CCCCAAAAEEEESSSSAAAARRRR____BBBB2222 according to
     the order relation underlying the ``least frequently  used''
     (LFU) replacement strategy.

     According to this order relation, an item is  smaller  than,
     equal to, or greater than another item if the number of hits
     at the first item is smaller than, equal to, or greater than
     the number of hits at the second item, respectively.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____MMMMFFFFUUUU____OOOORRRRDDDDEEEERRRR____CCCCAAAACCCCHHHHEEEE____1111

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____IIIINNNNTTTTEEEEGGGGEEEERRRR CCCCAAAAEEEESSSSAAAARRRR____MMMMFFFFUUUU____OOOORRRRDDDDEEEERRRR____CCCCAAAACCCCHHHHEEEE____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____CCCC,,,, CCCCAAAAEEEESSSSAAAARRRR____BBBB1111,,,, CCCCAAAAEEEESSSSAAAARRRR____BBBB2222))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____CCCCAAAACCCCHHHHEEEE____1111 CCCCAAAAEEEESSSSAAAARRRR____CCCC;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____PPPPOOOOIIIINNNNTTTTEEEERRRR CCCCAAAAEEEESSSSAAAARRRR____BBBB1111;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____PPPPOOOOIIIINNNNTTTTEEEERRRR CCCCAAAAEEEESSSSAAAARRRR____BBBB2222;;;;
        {{{{ ............ }}}}



(C) INRIA     Last change: 2020/02/11 (version 1.2)             8






OPEN/CAESAR MANUAL                          caesar_cache_1(LOCAL)



     This function returns an integer  number  which  is  smaller
     than, equal to, or greater than 0 depending whether the item
     pointed to by  CCCCAAAAEEEESSSSAAAARRRR____BBBB1111  is  smaller  than,  equal  to,  or
     greater  than  the item pointed to by CCCCAAAAEEEESSSSAAAARRRR____BBBB2222 according to
     the order relation underlying the ``most  frequently  used''
     (MFU) replacement strategy.

     According to this order relation, an item is  smaller  than,
     equal to, or greater than another item if the number of hits
     at the first item is greater than, equal to, or smaller than
     the number of hits at the second item, respectively.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____RRRRNNNNDDDD____OOOORRRRDDDDEEEERRRR____CCCCAAAACCCCHHHHEEEE____1111

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____IIIINNNNTTTTEEEEGGGGEEEERRRR CCCCAAAAEEEESSSSAAAARRRR____RRRRNNNNDDDD____OOOORRRRDDDDEEEERRRR____CCCCAAAACCCCHHHHEEEE____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____CCCC,,,, CCCCAAAAEEEESSSSAAAARRRR____BBBB1111,,,, CCCCAAAAEEEESSSSAAAARRRR____BBBB2222))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____CCCCAAAACCCCHHHHEEEE____1111 CCCCAAAAEEEESSSSAAAARRRR____CCCC;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____PPPPOOOOIIIINNNNTTTTEEEERRRR CCCCAAAAEEEESSSSAAAARRRR____BBBB1111;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____PPPPOOOOIIIINNNNTTTTEEEERRRR CCCCAAAAEEEESSSSAAAARRRR____BBBB2222;;;;
        {{{{ ............ }}}}

     This function returns an integer  number  which  is  smaller
     than, equal to, or greater than 0 depending whether the item
     pointed to by  CCCCAAAAEEEESSSSAAAARRRR____BBBB1111  is  smaller  than,  equal  to,  or
     greater  than  the item pointed to by CCCCAAAAEEEESSSSAAAARRRR____BBBB2222 according to
     the order relation underlying the ``random'' (RND)  replace-
     ment strategy.

     This order relation is implemented by  computing  for  every
     item  a  random  cost,  i.e., a natural number randomly gen-
     erated by taking into account the  seed  associated  to  the
     cache   pointed   to   by   CCCCAAAAEEEESSSSAAAARRRR____CCCC   (see   the  procedure
     CCCCAAAAEEEESSSSAAAARRRR____SSSSEEEEEEEEDDDD____RRRRNNNNDDDD____CCCCAAAACCCCHHHHEEEE____1111(((()))) below), the current global date of
     the cache, and the base field of the item. According to this
     relation, an item is smaller than, equal to, or greater than
     another item if the random cost of the first item is smaller
     than, equal to, or greater  than  the  random  cost  of  the
     second item, respectively.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____LLLLFFFFUUUU____LLLLRRRRUUUU____OOOORRRRDDDDEEEERRRR____CCCCAAAACCCCHHHHEEEE____1111

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____IIIINNNNTTTTEEEEGGGGEEEERRRR CCCCAAAAEEEESSSSAAAARRRR____LLLLFFFFUUUU____LLLLRRRRUUUU____OOOORRRRDDDDEEEERRRR____CCCCAAAACCCCHHHHEEEE____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____CCCC,,,, CCCCAAAAEEEESSSSAAAARRRR____BBBB1111,,,, CCCCAAAAEEEESSSSAAAARRRR____BBBB2222))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____CCCCAAAACCCCHHHHEEEE____1111 CCCCAAAAEEEESSSSAAAARRRR____CCCC;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____PPPPOOOOIIIINNNNTTTTEEEERRRR CCCCAAAAEEEESSSSAAAARRRR____BBBB1111;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____PPPPOOOOIIIINNNNTTTTEEEERRRR CCCCAAAAEEEESSSSAAAARRRR____BBBB2222;;;;
        {{{{ ............ }}}}




(C) INRIA     Last change: 2020/02/11 (version 1.2)             9






OPEN/CAESAR MANUAL                          caesar_cache_1(LOCAL)



     This function returns an integer  number  which  is  smaller
     than, equal to, or greater than 0 depending whether the item
     pointed to by  CCCCAAAAEEEESSSSAAAARRRR____BBBB1111  is  smaller  than,  equal  to,  or
     greater  than  the item pointed to by CCCCAAAAEEEESSSSAAAARRRR____BBBB2222 according to
     the order relation underlying the ``least  frequently  used,
     then least recently used'' (LFU_LRU) replacement strategy.

     According to this order relation:

     -    an item is smaller than another item if the  number  of
          hits  at  the  first item is smaller than the number of
          hits at the second one, or the number of  hits  is  the
          same  for both items but the date of the last access to
          the first item is smaller than the  date  of  the  last
          access to the second one;

     -    an item is equal to another one if the number  of  hits
          and  the  date of the last access are the same for both
          items;

     -    an item is greater than another item if the  number  of
          hits  at  the  first item is greater than the number of
          hits at the second one, or the number of  hits  is  the
          same  for both items but the date of the last access to
          the first item is greater than the  date  of  the  last
          access to the second one.

     In other words, the LFU_LRU replacement strategy consists in
     applying first the LFU, then the LRU replacement strategies.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____LLLLFFFFUUUU____MMMMRRRRUUUU____OOOORRRRDDDDEEEERRRR____CCCCAAAACCCCHHHHEEEE____1111

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____IIIINNNNTTTTEEEEGGGGEEEERRRR CCCCAAAAEEEESSSSAAAARRRR____LLLLFFFFUUUU____MMMMRRRRUUUU____OOOORRRRDDDDEEEERRRR____CCCCAAAACCCCHHHHEEEE____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____CCCC,,,, CCCCAAAAEEEESSSSAAAARRRR____BBBB1111,,,, CCCCAAAAEEEESSSSAAAARRRR____BBBB2222))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____CCCCAAAACCCCHHHHEEEE____1111 CCCCAAAAEEEESSSSAAAARRRR____CCCC;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____PPPPOOOOIIIINNNNTTTTEEEERRRR CCCCAAAAEEEESSSSAAAARRRR____BBBB1111;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____PPPPOOOOIIIINNNNTTTTEEEERRRR CCCCAAAAEEEESSSSAAAARRRR____BBBB2222;;;;
        {{{{ ............ }}}}

     This function returns an integer  number  which  is  smaller
     than, equal to, or greater than 0 depending whether the item
     pointed to by  CCCCAAAAEEEESSSSAAAARRRR____BBBB1111  is  smaller  than,  equal  to,  or
     greater  than  the item pointed to by CCCCAAAAEEEESSSSAAAARRRR____BBBB2222 according to
     the order relation underlying the ``least  frequently  used,
     then most recently used'' (LFU_MRU) replacement strategy.

     According to this order relation:

     -    an item is smaller than another item if the  number  of
          hits  at  the  first item is smaller than the number of



(C) INRIA     Last change: 2020/02/11 (version 1.2)            10






OPEN/CAESAR MANUAL                          caesar_cache_1(LOCAL)



          hits at the second one, or the number of  hits  is  the
          same  for both items but the date of the last access to
          the first item is greater than the  date  of  the  last
          access to the second one;

     -    an item is equal to another one if the number  of  hits
          and  the  date of the last access are the same for both
          items;

     -    an item is greater than another item if the  number  of
          hits  at  the  first item is greater than the number of
          hits at the second one, or the number of  hits  is  the
          same  for both items but the date of the last access to
          the first item is smaller than the  date  of  the  last
          access to the second one.

     In other words, the LFU_MRU replacement strategy consists in
     applying first the LFU, then the MRU replacement strategies.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____LLLLFFFFUUUU____LLLLRRRRPPPP____OOOORRRRDDDDEEEERRRR____CCCCAAAACCCCHHHHEEEE____1111

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____IIIINNNNTTTTEEEEGGGGEEEERRRR CCCCAAAAEEEESSSSAAAARRRR____LLLLFFFFUUUU____LLLLRRRRPPPP____OOOORRRRDDDDEEEERRRR____CCCCAAAACCCCHHHHEEEE____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____CCCC,,,, CCCCAAAAEEEESSSSAAAARRRR____BBBB1111,,,, CCCCAAAAEEEESSSSAAAARRRR____BBBB2222))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____CCCCAAAACCCCHHHHEEEE____1111 CCCCAAAAEEEESSSSAAAARRRR____CCCC;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____PPPPOOOOIIIINNNNTTTTEEEERRRR CCCCAAAAEEEESSSSAAAARRRR____BBBB1111;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____PPPPOOOOIIIINNNNTTTTEEEERRRR CCCCAAAAEEEESSSSAAAARRRR____BBBB2222;;;;
        {{{{ ............ }}}}

     This function returns an integer  number  which  is  smaller
     than, equal to, or greater than 0 depending whether the item
     pointed to by  CCCCAAAAEEEESSSSAAAARRRR____BBBB1111  is  smaller  than,  equal  to,  or
     greater  than  the item pointed to by CCCCAAAAEEEESSSSAAAARRRR____BBBB2222 according to
     the order relation underlying the ``least  frequently  used,
     then least recently put'' (LFU_LRP) replacement strategy.

     According to this order relation:

     -    an item is smaller than another item if the  number  of
          hits  at  the  first item is smaller than the number of
          hits at the second one, or the number of  hits  is  the
          same  for  both  items but the date when the first item
          was put into the cache is smaller than  the  date  when
          the second one was put into the cache;

     -    an item is equal to another one if the number  of  hits
          and  the date when they were put into the cache are the
          same for both items;

     -    an item is greater than another item if the  number  of
          hits  at  the  first item is greater than the number of



(C) INRIA     Last change: 2020/02/11 (version 1.2)            11






OPEN/CAESAR MANUAL                          caesar_cache_1(LOCAL)



          hits at the second one, or the number of  hits  is  the
          same  for  both  items but the date when the first item
          was put into the cache is greater than  the  date  when
          the second one was put into the cache.

     In other words, the LFU_LRP replacement strategy consists in
     applying first the LFU, then the LRP replacement strategies.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____LLLLFFFFUUUU____MMMMRRRRPPPP____OOOORRRRDDDDEEEERRRR____CCCCAAAACCCCHHHHEEEE____1111

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____IIIINNNNTTTTEEEEGGGGEEEERRRR CCCCAAAAEEEESSSSAAAARRRR____LLLLFFFFUUUU____MMMMRRRRPPPP____OOOORRRRDDDDEEEERRRR____CCCCAAAACCCCHHHHEEEE____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____CCCC,,,, CCCCAAAAEEEESSSSAAAARRRR____BBBB1111,,,, CCCCAAAAEEEESSSSAAAARRRR____BBBB2222))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____CCCCAAAACCCCHHHHEEEE____1111 CCCCAAAAEEEESSSSAAAARRRR____CCCC;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____PPPPOOOOIIIINNNNTTTTEEEERRRR CCCCAAAAEEEESSSSAAAARRRR____BBBB1111;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____PPPPOOOOIIIINNNNTTTTEEEERRRR CCCCAAAAEEEESSSSAAAARRRR____BBBB2222;;;;
        {{{{ ............ }}}}

     This function returns an integer  number  which  is  smaller
     than, equal to, or greater than 0 depending whether the item
     pointed to by  CCCCAAAAEEEESSSSAAAARRRR____BBBB1111  is  smaller  than,  equal  to,  or
     greater  than  the item pointed to by CCCCAAAAEEEESSSSAAAARRRR____BBBB2222 according to
     the order relation underlying the ``least  frequently  used,
     then most recently put'' (LFU_MRP) replacement strategy.

     According to this order relation:

     -    an item is smaller than another item if the  number  of
          hits  at  the  first item is smaller than the number of
          hits at the second one, or the number of  hits  is  the
          same  for  both  items but the date when the first item
          was put into the cache is greater than  the  date  when
          the second one was put into the cache;

     -    an item is equal to another one if the number  of  hits
          and  the date when they were put into the cache are the
          same for both items;

     -    an item is greater than another item if the  number  of
          hits  at  the  first item is greater than the number of
          hits at the second one, or the number of  hits  is  the
          same  for  both  items but the date when the first item
          was put into the cache is smaller than  the  date  when
          the second one was put into the cache.

     In other words, the LFU_MRP replacement strategy consists in
     applying first the LFU, then the MRP replacement strategies.


      ............................................................




(C) INRIA     Last change: 2020/02/11 (version 1.2)            12






OPEN/CAESAR MANUAL                          caesar_cache_1(LOCAL)



  CCCCAAAAEEEESSSSAAAARRRR____MMMMFFFFUUUU____LLLLRRRRUUUU____OOOORRRRDDDDEEEERRRR____CCCCAAAACCCCHHHHEEEE____1111

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____IIIINNNNTTTTEEEEGGGGEEEERRRR CCCCAAAAEEEESSSSAAAARRRR____MMMMFFFFUUUU____LLLLRRRRUUUU____OOOORRRRDDDDEEEERRRR____CCCCAAAACCCCHHHHEEEE____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____CCCC,,,, CCCCAAAAEEEESSSSAAAARRRR____BBBB1111,,,, CCCCAAAAEEEESSSSAAAARRRR____BBBB2222))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____CCCCAAAACCCCHHHHEEEE____1111 CCCCAAAAEEEESSSSAAAARRRR____CCCC;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____PPPPOOOOIIIINNNNTTTTEEEERRRR CCCCAAAAEEEESSSSAAAARRRR____BBBB1111;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____PPPPOOOOIIIINNNNTTTTEEEERRRR CCCCAAAAEEEESSSSAAAARRRR____BBBB2222;;;;
        {{{{ ............ }}}}

     This function returns an integer  number  which  is  smaller
     than, equal to, or greater than 0 depending whether the item
     pointed to by  CCCCAAAAEEEESSSSAAAARRRR____BBBB1111  is  smaller  than,  equal  to,  or
     greater  than  the item pointed to by CCCCAAAAEEEESSSSAAAARRRR____BBBB2222 according to
     the order relation underlying the  ``most  frequently  used,
     then least recently used'' (MFU_LRU) replacement strategy.

     According to this order relation:

     -    an item is smaller than another item if the  number  of
          hits  at  the  first item is greater than the number of
          hits at the second one, or the number of  hits  is  the
          same  for both items but the date of the last access to
          the first item is smaller than the  date  of  the  last
          access to the second one;

     -    an item is equal to another one if the number  of  hits
          and  the  date of the last access are the same for both
          items;

     -    an item is greater than another item if the  number  of
          hits  at  the  first item is smaller than the number of
          hits at the second one, or the number of  hits  is  the
          same  for both items but the date of the last access to
          the first item is greater than the  date  of  the  last
          access to the second one.

     In other words, the MFU_LRU replacement strategy consists in
     applying first the MFU, then the LRU replacement strategies.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____MMMMFFFFUUUU____MMMMRRRRUUUU____OOOORRRRDDDDEEEERRRR____CCCCAAAACCCCHHHHEEEE____1111

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____IIIINNNNTTTTEEEEGGGGEEEERRRR CCCCAAAAEEEESSSSAAAARRRR____MMMMFFFFUUUU____MMMMRRRRUUUU____OOOORRRRDDDDEEEERRRR____CCCCAAAACCCCHHHHEEEE____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____CCCC,,,, CCCCAAAAEEEESSSSAAAARRRR____BBBB1111,,,, CCCCAAAAEEEESSSSAAAARRRR____BBBB2222))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____CCCCAAAACCCCHHHHEEEE____1111 CCCCAAAAEEEESSSSAAAARRRR____CCCC;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____PPPPOOOOIIIINNNNTTTTEEEERRRR CCCCAAAAEEEESSSSAAAARRRR____BBBB1111;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____PPPPOOOOIIIINNNNTTTTEEEERRRR CCCCAAAAEEEESSSSAAAARRRR____BBBB2222;;;;
        {{{{ ............ }}}}

     This function returns an integer  number  which  is  smaller
     than, equal to, or greater than 0 depending whether the item
     pointed to by  CCCCAAAAEEEESSSSAAAARRRR____BBBB1111  is  smaller  than,  equal  to,  or



(C) INRIA     Last change: 2020/02/11 (version 1.2)            13






OPEN/CAESAR MANUAL                          caesar_cache_1(LOCAL)



     greater  than  the item pointed to by CCCCAAAAEEEESSSSAAAARRRR____BBBB2222 according to
     the order relation underlying the  ``most  frequently  used,
     then most recently used'' (MFU_MRU) replacement strategy.

     According to this order relation:

     -    an item is smaller than another item if the  number  of
          hits  at  the  first item is greater than the number of
          hits at the second one, or the number of  hits  is  the
          same  for both items but the date of the last access to
          the first item is greater than the  date  of  the  last
          access to the second one;

     -    an item is equal to another one if the number  of  hits
          and  the  date of the last access are the same for both
          items;

     -    an item is greater than another item if the  number  of
          hits  at  the  first item is smaller than the number of
          hits at the second one, or the number of  hits  is  the
          same  for both items but the date of the last access to
          the first item is smaller than the  date  of  the  last
          access to the second one.

     In other words, the MFU_MRU replacement strategy consists in
     applying first the MFU, then the MRU replacement strategies.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____MMMMFFFFUUUU____LLLLRRRRPPPP____OOOORRRRDDDDEEEERRRR____CCCCAAAACCCCHHHHEEEE____1111

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____IIIINNNNTTTTEEEEGGGGEEEERRRR CCCCAAAAEEEESSSSAAAARRRR____MMMMFFFFUUUU____LLLLRRRRPPPP____OOOORRRRDDDDEEEERRRR____CCCCAAAACCCCHHHHEEEE____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____CCCC,,,, CCCCAAAAEEEESSSSAAAARRRR____BBBB1111,,,, CCCCAAAAEEEESSSSAAAARRRR____BBBB2222))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____CCCCAAAACCCCHHHHEEEE____1111 CCCCAAAAEEEESSSSAAAARRRR____CCCC;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____PPPPOOOOIIIINNNNTTTTEEEERRRR CCCCAAAAEEEESSSSAAAARRRR____BBBB1111;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____PPPPOOOOIIIINNNNTTTTEEEERRRR CCCCAAAAEEEESSSSAAAARRRR____BBBB2222;;;;
        {{{{ ............ }}}}

     This function returns an integer  number  which  is  smaller
     than, equal to, or greater than 0 depending whether the item
     pointed to by  CCCCAAAAEEEESSSSAAAARRRR____BBBB1111  is  smaller  than,  equal  to,  or
     greater  than  the item pointed to by CCCCAAAAEEEESSSSAAAARRRR____BBBB2222 according to
     the order relation underlying the  ``most  frequently  used,
     then least recently put'' (MFU_LRP) replacement strategy.

     According to this order relation:

     -    an item is smaller than another item if the  number  of
          hits  at  the  first item is greater than the number of
          hits at the second one, or the number of  hits  is  the
          same  for  both  items but the date when the first item
          was put into the cache is smaller than  the  date  when



(C) INRIA     Last change: 2020/02/11 (version 1.2)            14






OPEN/CAESAR MANUAL                          caesar_cache_1(LOCAL)



          the second one was put into the cache;

     -    an item is equal to another one if the number  of  hits
          and  the date when they were put into the cache are the
          same for both items;

     -    an item is greater than another item if the  number  of
          hits  at  the  first item is smaller than the number of
          hits at the second one, or the number of  hits  is  the
          same  for  both  items but the date when the first item
          was put into the cache is greater than  the  date  when
          the second one was put into the cache.

     In other words, the MFU_LRP replacement strategy consists in
     applying first the MFU, then the LRP replacement strategies.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____MMMMFFFFUUUU____MMMMRRRRPPPP____OOOORRRRDDDDEEEERRRR____CCCCAAAACCCCHHHHEEEE____1111

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____IIIINNNNTTTTEEEEGGGGEEEERRRR CCCCAAAAEEEESSSSAAAARRRR____MMMMFFFFUUUU____MMMMRRRRPPPP____OOOORRRRDDDDEEEERRRR____CCCCAAAACCCCHHHHEEEE____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____CCCC,,,, CCCCAAAAEEEESSSSAAAARRRR____BBBB1111,,,, CCCCAAAAEEEESSSSAAAARRRR____BBBB2222))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____CCCCAAAACCCCHHHHEEEE____1111 CCCCAAAAEEEESSSSAAAARRRR____CCCC;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____PPPPOOOOIIIINNNNTTTTEEEERRRR CCCCAAAAEEEESSSSAAAARRRR____BBBB1111;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____PPPPOOOOIIIINNNNTTTTEEEERRRR CCCCAAAAEEEESSSSAAAARRRR____BBBB2222;;;;
        {{{{ ............ }}}}

     This function returns an integer  number  which  is  smaller
     than, equal to, or greater than 0 depending whether the item
     pointed to by  CCCCAAAAEEEESSSSAAAARRRR____BBBB1111  is  smaller  than,  equal  to,  or
     greater  than  the item pointed to by CCCCAAAAEEEESSSSAAAARRRR____BBBB2222 according to
     the order relation underlying the  ``most  frequently  used,
     then most recently put'' (MFU_MRP) replacement strategy.

     According to this order relation:

     -    an item is smaller than another item if the  number  of
          hits  at  the  first item is greater than the number of
          hits at the second one, or the number of  hits  is  the
          same  for  both  items but the date when the first item
          was put into the cache is greater than  the  date  when
          the second one was put into the cache;

     -    an item is equal to another one if the number  of  hits
          and  the date when they were put into the cache are the
          same for both items;

     -    an item is greater than another item if the  number  of
          hits  at  the  first item is smaller than the number of
          hits at the second one, or the number of  hits  is  the
          same  for  both  items but the date when the first item
          was put into the cache is smaller than  the  date  when



(C) INRIA     Last change: 2020/02/11 (version 1.2)            15






OPEN/CAESAR MANUAL                          caesar_cache_1(LOCAL)



          the second one was put into the cache.

     In other words, the MFU_MRP replacement strategy consists in
     applying first the MFU, then the MRP replacement strategies.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____SSSSEEEEEEEEDDDD____RRRRNNNNDDDD____CCCCAAAACCCCHHHHEEEE____1111

     vvvvooooiiiidddd CCCCAAAAEEEESSSSAAAARRRR____SSSSEEEEEEEEDDDD____RRRRNNNNDDDD____CCCCAAAACCCCHHHHEEEE____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____CCCC,,,, CCCCAAAAEEEESSSSAAAARRRR____SSSSEEEEEEEEDDDD))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____CCCCAAAACCCCHHHHEEEE____1111 CCCCAAAAEEEESSSSAAAARRRR____CCCC;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL CCCCAAAAEEEESSSSAAAARRRR____SSSSEEEEEEEEDDDD;;;;
        {{{{ ............ }}}}

     This procedure initializes the seed for  the  random  number
     generator  associated  to  the  cache pointed to by CCCCAAAAEEEESSSSAAAARRRR____CCCC
     with the value of CCCCAAAAEEEESSSSAAAARRRR____SSSSEEEEEEEEDDDD. The seed is used for  comput-
     ing  the  random  costs associated to the items contained in
     the subcaches of the cache that are equipped  with  the  RND
     replacement strategy.

     Note: The value of the seed associated to a cache is set  by
     default  to 0 when the cache is created by invoking the pro-
     cedure CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTEEEE____CCCCAAAACCCCHHHHEEEE____1111(((()))) (see below).


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTEEEE____CCCCAAAACCCCHHHHEEEE____1111

     vvvvooooiiiidddd CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTEEEE____CCCCAAAACCCCHHHHEEEE____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____CCCC,,,,
                                 CCCCAAAAEEEESSSSAAAARRRR____NNNNUUUUMMMMBBBBEEEERRRR____OOOOFFFF____SSSSUUUUBBBBCCCCAAAACCCCHHHHEEEESSSS,,,,
                                 CCCCAAAAEEEESSSSAAAARRRR____LLLLIIIIMMMMIIIITTTT____SSSSIIIIZZZZEEEE,,,,
                                 CCCCAAAAEEEESSSSAAAARRRR____SSSSUUUUBBBBCCCCAAAACCCCHHHHEEEE____SSSSIIIIZZZZEEEE,,,,
                                 CCCCAAAAEEEESSSSAAAARRRR____SSSSUUUUBBBBCCCCAAAACCCCHHHHEEEE____PPPPEEEERRRRCCCCEEEENNNNTTTTAAAAGGGGEEEE,,,,
                                 CCCCAAAAEEEESSSSAAAARRRR____SSSSUUUUBBBBCCCCAAAACCCCHHHHEEEE____OOOORRRRDDDDEEEERRRR,,,,
                                 CCCCAAAAEEEESSSSAAAARRRR____SSSSUUUUBBBBCCCCAAAACCCCHHHHEEEE____CCCCHHHHIIIILLLLDDDD,,,,
                                 CCCCAAAAEEEESSSSAAAARRRR____BBBBAAAASSSSEEEE____AAAARRRREEEEAAAA,,,,
                                 CCCCAAAAEEEESSSSAAAARRRR____MMMMAAAARRRRKKKK____AAAARRRREEEEAAAA,,,,
                                 CCCCAAAAEEEESSSSAAAARRRR____HHHHAAAASSSSHHHH____SSSSIIIIZZZZEEEE,,,,
                                 CCCCAAAAEEEESSSSAAAARRRR____PPPPRRRRIIIIMMMMEEEE,,,,
                                 CCCCAAAAEEEESSSSAAAARRRR____CCCCOOOOMMMMPPPPAAAARRRREEEE,,,,
                                 CCCCAAAAEEEESSSSAAAARRRR____HHHHAAAASSSSHHHH,,,,
                                 CCCCAAAAEEEESSSSAAAARRRR____PPPPRRRRIIIINNNNTTTT,,,,
                                 CCCCAAAAEEEESSSSAAAARRRR____CCCCLLLLEEEEAAAANNNNUUUUPPPP,,,,
                                 CCCCAAAAEEEESSSSAAAARRRR____IIIINNNNFFFFOOOO))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____CCCCAAAACCCCHHHHEEEE____1111 ****CCCCAAAAEEEESSSSAAAARRRR____CCCC;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL CCCCAAAAEEEESSSSAAAARRRR____NNNNUUUUMMMMBBBBEEEERRRR____OOOOFFFF____SSSSUUUUBBBBCCCCAAAACCCCHHHHEEEESSSS;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL CCCCAAAAEEEESSSSAAAARRRR____LLLLIIIIMMMMIIIITTTT____SSSSIIIIZZZZEEEE;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN____CCCCAAAACCCCHHHHEEEE____1111 CCCCAAAAEEEESSSSAAAARRRR____SSSSUUUUBBBBCCCCAAAACCCCHHHHEEEE____SSSSIIIIZZZZEEEE;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN____CCCCAAAACCCCHHHHEEEE____1111 CCCCAAAAEEEESSSSAAAARRRR____SSSSUUUUBBBBCCCCAAAACCCCHHHHEEEE____PPPPEEEERRRRCCCCEEEENNNNTTTTAAAAGGGGEEEE;;;;



(C) INRIA     Last change: 2020/02/11 (version 1.2)            16






OPEN/CAESAR MANUAL                          caesar_cache_1(LOCAL)



        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____OOOORRRRDDDDEEEERRRR____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN____CCCCAAAACCCCHHHHEEEE____1111 ((((****CCCCAAAAEEEESSSSAAAARRRR____SSSSUUUUBBBBCCCCAAAACCCCHHHHEEEE____OOOORRRRDDDDEEEERRRR))))
           ((((CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL))));;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSUUUUBBBBCCCCAAAACCCCHHHHEEEE____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN____CCCCAAAACCCCHHHHEEEE____1111 ((((****CCCCAAAAEEEESSSSAAAARRRR____SSSSUUUUBBBBCCCCAAAACCCCHHHHEEEE____CCCCHHHHIIIILLLLDDDD))))
           ((((CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL))));;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____AAAARRRREEEEAAAA____1111 CCCCAAAAEEEESSSSAAAARRRR____BBBBAAAASSSSEEEE____AAAARRRREEEEAAAA;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____AAAARRRREEEEAAAA____1111 CCCCAAAAEEEESSSSAAAARRRR____MMMMAAAARRRRKKKK____AAAARRRREEEEAAAA;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL CCCCAAAAEEEESSSSAAAARRRR____HHHHAAAASSSSHHHH____SSSSIIIIZZZZEEEE;;;;
        CCCCAAAAEEEESSSSAAAARRRR____PPPPRRRROOOOMMMMOOOOTTTTEEEE____TTTTOOOO____IIIINNNNTTTT ((((CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____BBBBOOOOOOOOLLLLEEEEAAAANNNN)))) CCCCAAAAEEEESSSSAAAARRRR____PPPPRRRRIIIIMMMMEEEE;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____CCCCOOOOMMMMPPPPAAAARRRREEEE____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN CCCCAAAAEEEESSSSAAAARRRR____CCCCOOOOMMMMPPPPAAAARRRREEEE;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____HHHHAAAASSSSHHHH____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN CCCCAAAAEEEESSSSAAAARRRR____HHHHAAAASSSSHHHH;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____PPPPRRRRIIIINNNNTTTT____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN CCCCAAAAEEEESSSSAAAARRRR____PPPPRRRRIIIINNNNTTTT;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____CCCCLLLLEEEEAAAANNNNUUUUPPPP____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN____CCCCAAAACCCCHHHHEEEE____1111 CCCCAAAAEEEESSSSAAAARRRR____CCCCLLLLEEEEAAAANNNNUUUUPPPP;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____PPPPOOOOIIIINNNNTTTTEEEERRRR CCCCAAAAEEEESSSSAAAARRRR____IIIINNNNFFFFOOOO;;;;
        {{{{ ............ }}}}

     This procedure allocates a cache using  CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTEEEE(((())))  and
     assigns  its  address to ****CCCCAAAAEEEESSSSAAAARRRR____CCCC. If the allocation fails,
     the NNNNUUUULLLLLLLL value is assigned to ****CCCCAAAAEEEESSSSAAAARRRR____CCCC.

     Note: Because CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____CCCCAAAACCCCHHHHEEEE____1111 is  a  pointer  type,  any
     variable  CCCCAAAAEEEESSSSAAAARRRR____CCCC of type CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____CCCCAAAACCCCHHHHEEEE____1111 must be allo-
     cated before used, for instance using:

               CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTEEEE____CCCCAAAACCCCHHHHEEEE____1111 ((((&&&&CCCCAAAAEEEESSSSAAAARRRR____CCCC,,,, ............))));;;;


     The  value  of  CCCCAAAAEEEESSSSAAAARRRR____NNNNUUUUMMMMBBBBEEEERRRR____OOOOFFFF____SSSSUUUUBBBBCCCCAAAACCCCHHHHEEEESSSS  determines   the
     number  of  subcaches  contained in the cache. Each subcache
     will  be   assigned   an   unique   index   in   the   range
     0..CCCCAAAAEEEESSSSAAAARRRR____NNNNUUUUMMMMBBBBEEEERRRR____OOOOFFFF____SSSSUUUUBBBBCCCCAAAACCCCHHHHEEEESSSS   -   1.   If   the  value  of
     CCCCAAAAEEEESSSSAAAARRRR____NNNNUUUUMMMMBBBBEEEERRRR____OOOOFFFF____SSSSUUUUBBBBCCCCAAAACCCCHHHHEEEESSSS is zero or greater  than  P,  the
     effect is undefined.

     The value of CCCCAAAAEEEESSSSAAAARRRR____LLLLIIIIMMMMIIIITTTT____SSSSIIIIZZZZEEEE determines the maximal number
     of items that can be stored in the cache. It must be less or
     equal to M. If it is equal to zero, it is  replaced  by  the
     default value M.

     Note:   in   order   to   spare   memory,   the   value   of
     CCCCAAAAEEEESSSSAAAARRRR____LLLLIIIIMMMMIIIITTTT____SSSSIIIIZZZZEEEE  (which is an upper bound on the number of
     items to be inserted in the cache) should  be  as  small  as
     possible.  This  can  only  be  done  if  the  user has some
     knowledge about the way the cache will be used.

     The    actual    value    of    the     formal     parameter
     CCCCAAAAEEEESSSSAAAARRRR____SSSSUUUUBBBBCCCCAAAACCCCHHHHEEEE____SSSSIIIIZZZZEEEE  will  be  stored and associated to the
     cache pointed to by ****CCCCAAAAEEEESSSSAAAARRRR____CCCC. It will be used to assign  to
     each  subcache  its  corresponding  size,  i.e., the maximal
     number of items the subcache can contain.

     Precisely, the actual value of  CCCCAAAAEEEESSSSAAAARRRR____SSSSUUUUBBBBCCCCAAAACCCCHHHHEEEE____SSSSIIIIZZZZEEEE  should
     be  a  pointer  to  a function with a parameter ccccaaaaeeeessssaaaarrrr____iiiinnnnddddeeeexxxx



(C) INRIA     Last change: 2020/02/11 (version 1.2)            17






OPEN/CAESAR MANUAL                          caesar_cache_1(LOCAL)



     that returns the size of the subcache of index ccccaaaaeeeessssaaaarrrr____iiiinnnnddddeeeexxxx,
     where       ccccaaaaeeeessssaaaarrrr____iiiinnnnddddeeeexxxx      is      in      the      range
     0..CCCCAAAAEEEESSSSAAAARRRR____NNNNUUUUMMMMBBBBEEEERRRR____OOOOFFFF____SSSSUUUUBBBBCCCCAAAACCCCHHHHEEEESSSS - 1. If the value returned  by
     CCCCAAAAEEEESSSSAAAARRRR____SSSSUUUUBBBBCCCCAAAACCCCHHHHEEEE____SSSSIIIIZZZZEEEE  for some index ccccaaaaeeeessssaaaarrrr____iiiinnnnddddeeeexxxx is greater
     than  zero,  then  the  size  of  the  subcache   of   index
     ccccaaaaeeeessssaaaarrrr____iiiinnnnddddeeeexxxx  is set to this value. If the value returned is
     zero, the size of the  subcache  of  index  ccccaaaaeeeessssaaaarrrr____iiiinnnnddddeeeexxxx  is
     unspecified   and  will  be  determined  by  the  percentage
     returned by the  CCCCAAAAEEEESSSSAAAARRRR____SSSSUUUUBBBBCCCCAAAACCCCHHHHEEEE____PPPPEEEERRRRCCCCEEEENNNNTTTTAAAAGGGGEEEE  parameter  (see
     below).    The    sum    of    the    sizes    returned   by
     CCCCAAAAEEEESSSSAAAARRRR____SSSSUUUUBBBBCCCCAAAACCCCHHHHEEEE____SSSSIIIIZZZZEEEE for all subcaches,  noted  L,  must  be
     less or equal to CCCCAAAAEEEESSSSAAAARRRR____LLLLIIIIMMMMIIIITTTT____SSSSIIIIZZZZEEEE.

     The    actual    value    of    the     formal     parameter
     CCCCAAAAEEEESSSSAAAARRRR____SSSSUUUUBBBBCCCCAAAACCCCHHHHEEEE____PPPPEEEERRRRCCCCEEEENNNNTTTTAAAAGGGGEEEE  will be stored and associated to
     the cache pointed to by ****CCCCAAAAEEEESSSSAAAARRRR____CCCC. It will be used to assign
     to  each  subcache  its  corresponding  percentage,  i.e., a
     natural number in the range 0..100 determining the  size  of
     the  subcache  with  respect  to  the size of the other sub-
     caches.

     Precisely, the actual  value  of  CCCCAAAAEEEESSSSAAAARRRR____SSSSUUUUBBBBCCCCAAAACCCCHHHHEEEE____PPPPEEEERRRRCCCCEEEENNNNTTTTAAAAGGGGEEEE
     should   be  a  pointer  to  a  function  with  a  parameter
     ccccaaaaeeeessssaaaarrrr____iiiinnnnddddeeeexxxx that returns the percentage of the subcache  of
     index  ccccaaaaeeeessssaaaarrrr____iiiinnnnddddeeeexxxx,  where  ccccaaaaeeeessssaaaarrrr____iiiinnnnddddeeeexxxx  is  in  the range
     0..CCCCAAAAEEEESSSSAAAARRRR____NNNNUUUUMMMMBBBBEEEERRRR____OOOOFFFF____SSSSUUUUBBBBCCCCAAAACCCCHHHHEEEESSSS -  1.  Several  configurations
     are  possible,  enabling  the  setup  of subcache sizes in a
     flexible manner:

     -    If  the  value  returned  by  CCCCAAAAEEEESSSSAAAARRRR____SSSSUUUUBBBBCCCCAAAACCCCHHHHEEEE____SSSSIIIIZZZZEEEE   is
          greater  than  zero  for all subcaches, then the values
          returned  by  CCCCAAAAEEEESSSSAAAARRRR____SSSSUUUUBBBBCCCCAAAACCCCHHHHEEEE____PPPPEEEERRRRCCCCEEEENNNNTTTTAAAAGGGGEEEE  are   ignored
          because   all   subcache   sizes   are   determined  by
          CCCCAAAAEEEESSSSAAAARRRR____SSSSUUUUBBBBCCCCAAAACCCCHHHHEEEE____SSSSIIIIZZZZEEEE.

     -    If there is some subcache with unspecified size  (i.e.,
          for  which CCCCAAAAEEEESSSSAAAARRRR____SSSSUUUUBBBBCCCCAAAACCCCHHHHEEEE____SSSSIIIIZZZZEEEE returns zero), then the
          size of the cache pointed to by  ****CCCCAAAAEEEESSSSAAAARRRR____CCCC  is  set  to
          CCCCAAAAEEEESSSSAAAARRRR____LLLLIIIIMMMMIIIITTTT____SSSSIIIIZZZZEEEE.  Let  R  be  the number of subcaches
          with unspecified size. The sizes of these subcaches are
          determined   based   on  the  percentages  returned  by
          CCCCAAAAEEEESSSSAAAARRRR____SSSSUUUUBBBBCCCCAAAACCCCHHHHEEEE____PPPPEEEERRRRCCCCEEEENNNNTTTTAAAAGGGGEEEE.  Two situations are  possi-
          ble:

          (1) If the value returned by CCCCAAAAEEEESSSSAAAARRRR____SSSSUUUUBBBBCCCCAAAACCCCHHHHEEEE____PPPPEEEERRRRCCCCEEEENNNNTTTTAAAAGGGGEEEE
          is  zero  for all subcaches with unspecified size, then
          the  size  of  each  of  these  subcaches  is  set   to
          (CCCCAAAAEEEESSSSAAAARRRR____LLLLIIIIMMMMIIIITTTT____SSSSIIIIZZZZEEEE - L) / R.

          (2) If there is some cache with  unspecified  size  for
          which  the value returned by CCCCAAAAEEEESSSSAAAARRRR____SSSSUUUUBBBBCCCCAAAACCCCHHHHEEEE____PPPPEEEERRRRCCCCEEEENNNNTTTTAAAAGGGGEEEE
          is greater than zero, then the size of a subcache  with



(C) INRIA     Last change: 2020/02/11 (version 1.2)            18






OPEN/CAESAR MANUAL                          caesar_cache_1(LOCAL)



          percentage  F  is  set to (CCCCAAAAEEEESSSSAAAARRRR____LLLLIIIIMMMMIIIITTTT____SSSSIIIIZZZZEEEE - L) * F /
          100.    All     the     percentages     returned     by
          CCCCAAAAEEEESSSSAAAARRRR____SSSSUUUUBBBBCCCCAAAACCCCHHHHEEEE____PPPPEEEERRRRCCCCEEEENNNNTTTTAAAAGGGGEEEE   for   the  subcaches  with
          unspecified size must be greater than zero, and the sum
          of all these percentages must be equal to 100.

     The    actual    value    of    the     formal     parameter
     CCCCAAAAEEEESSSSAAAARRRR____SSSSUUUUBBBBCCCCAAAACCCCHHHHEEEE____OOOORRRRDDDDEEEERRRR  will  be stored and associated to the
     cache pointed to by ****CCCCAAAAEEEESSSSAAAARRRR____CCCC. It will be used to assign  to
     each  subcache  a  function  implementing the order relation
     underlying the replacement strategy associated to  the  sub-
     cache.

     Precisely, the actual value of CCCCAAAAEEEESSSSAAAARRRR____SSSSUUUUBBBBCCCCAAAACCCCHHHHEEEE____OOOORRRRDDDDEEEERRRR  should
     be  a  pointer  to  a function with a parameter ccccaaaaeeeessssaaaarrrr____iiiinnnnddddeeeexxxx
     that returns a  function  implementing  an  order  relation,
     where       ccccaaaaeeeessssaaaarrrr____iiiinnnnddddeeeexxxx      is      in      the      range
     0..CCCCAAAAEEEESSSSAAAARRRR____NNNNUUUUMMMMBBBBEEEERRRR____OOOOFFFF____SSSSUUUUBBBBCCCCAAAACCCCHHHHEEEESSSS - 1.  The  value  returned  by
     CCCCAAAAEEEESSSSAAAARRRR____SSSSUUUUBBBBCCCCAAAACCCCHHHHEEEE____OOOORRRRDDDDEEEERRRR should be a pointer to a function with
     three parameters ccccaaaaeeeessssaaaarrrr____ccccaaaacccchhhheeee, ccccaaaaeeeessssaaaarrrr____bbbbaaaasssseeee____1111, ccccaaaaeeeessssaaaarrrr____bbbbaaaasssseeee____2222.
     This  function  returns  a  value smaller than, equal to, or
     greater than 0 if the base field pointed to by ccccaaaaeeeessssaaaarrrr____bbbbaaaasssseeee____1111
     is  smaller  than,  equal to, or greater than the base field
     pointed to by ccccaaaaeeeessssaaaarrrr____bbbbaaaasssseeee____2222. The items whose base fields are
     pointed  to  by ccccaaaaeeeessssaaaarrrr____bbbbaaaasssseeee____1111 and ccccaaaaeeeessssaaaarrrr____bbbbaaaasssseeee____2222 are supposed
     to be contained in the cache  pointed  to  by  ccccaaaaeeeessssaaaarrrr____ccccaaaacccchhhheeee,
     which  is  always  set  to  the  value of ****CCCCAAAAEEEESSSSAAAARRRR____CCCC, i.e., a
     pointer to the cache currently created.  Examples  of  func-
     tions  that  can  be  returned  by CCCCAAAAEEEESSSSAAAARRRR____SSSSUUUUBBBBCCCCAAAACCCCHHHHEEEE____OOOORRRRDDDDEEEERRRR are
     those implementing the order relations underlying the prede-
     fined         replacement         strategies,         namely
     CCCCAAAAEEEESSSSAAAARRRR____LLLLRRRRUUUU____OOOORRRRDDDDEEEERRRR____CCCCAAAACCCCHHHHEEEE____1111(((()))), CCCCAAAAEEEESSSSAAAARRRR____MMMMRRRRUUUU____OOOORRRRDDDDEEEERRRR____CCCCAAAACCCCHHHHEEEE____1111(((()))), etc.

     The    actual    value    of    the     formal     parameter
     CCCCAAAAEEEESSSSAAAARRRR____SSSSUUUUBBBBCCCCAAAACCCCHHHHEEEE____CCCCHHHHIIIILLLLDDDD  will  be stored and associated to the
     cache pointed to by ****CCCCAAAAEEEESSSSAAAARRRR____CCCC. It will be used to assign  to
     each  subcache  a  function implementing the parent relation
     that defines the child subcaches of that subcache.

     Precisely, the actual value of CCCCAAAAEEEESSSSAAAARRRR____SSSSUUUUBBBBCCCCAAAACCCCHHHHEEEE____CCCCHHHHIIIILLLLDDDD  should
     be  a  pointer  to  a function with a parameter ccccaaaaeeeessssaaaarrrr____iiiinnnnddddeeeexxxx
     that returns a  function  implementing  a  parent  relation,
     where       ccccaaaaeeeessssaaaarrrr____iiiinnnnddddeeeexxxx      is      in      the      range
     0..CCCCAAAAEEEESSSSAAAARRRR____NNNNUUUUMMMMBBBBEEEERRRR____OOOOFFFF____SSSSUUUUBBBBCCCCAAAACCCCHHHHEEEESSSS - 1.  The  value  returned  by
     CCCCAAAAEEEESSSSAAAARRRR____SSSSUUUUBBBBCCCCAAAACCCCHHHHEEEE____CCCCHHHHIIIILLLLDDDD should be a pointer to a function with
     three parameters  ccccaaaaeeeessssaaaarrrr____ccccaaaacccchhhheeee,  ccccaaaaeeeessssaaaarrrr____iiiinnnnddddeeeexxxx,  ccccaaaaeeeessssaaaarrrr____bbbbaaaasssseeee.
     The  parameter  ccccaaaaeeeessssaaaarrrr____ccccaaaacccchhhheeee  is  always set to the value of
     ****CCCCAAAAEEEESSSSAAAARRRR____CCCC, i.e., a pointer to the cache  currently  created.
     The  parameter  ccccaaaaeeeessssaaaarrrr____bbbbaaaasssseeee  is  a  pointer to the last item
     replaced in the subcache  of  index  ccccaaaaeeeessssaaaarrrr____iiiinnnnddddeeeexxxx  when  the
     current  put  operation performed on the cache pointed to by
     ccccaaaaeeeessssaaaarrrr____ccccaaaacccchhhheeee entailed a put operation  on  the  subcache  of



(C) INRIA     Last change: 2020/02/11 (version 1.2)            19






OPEN/CAESAR MANUAL                          caesar_cache_1(LOCAL)



     index  ccccaaaaeeeessssaaaarrrr____iiiinnnnddddeeeexxxx,  which  was already full. This function
     returns, for the subcache of index ccccaaaaeeeessssaaaarrrr____iiiinnnnddddeeeexxxx,  the  index
     of  its  child  subcache  in  which  the  item pointed to by
     ccccaaaaeeeessssaaaarrrr____bbbbaaaasssseeee will be put. If the index returned by this func-
     tion is greater or equal to CCCCAAAAEEEESSSSAAAARRRR____NNNNUUUUMMMMBBBBEEEERRRR____OOOOFFFF____SSSSUUUUBBBBCCCCAAAACCCCHHHHEEEESSSS, then
     the subcache of index ccccaaaaeeeessssaaaarrrr____iiiinnnnddddeeeexxxx is  considered  to  be  a
     leaf  subcache,  and  the  last  item replaced pointed to by
     ccccaaaaeeeessssaaaarrrr____bbbbaaaasssseeee will be temporarily stored in  a  field  of  the
     cache  until  the  next replacement takes place in the cache
     (see   the   CCCCAAAAEEEESSSSAAAARRRR____LLLLAAAASSSSTTTT____IIIITTTTEEEEMMMM____RRRREEEEPPPPLLLLAAAACCCCEEEEDDDD____CCCCAAAACCCCHHHHEEEE____1111(((())))   procedure
     below).

     For example, the  following  function  implements  a  parent
     relation  corresponding  to  a  stream of subcaches, i.e., a
     hierarchy in which each subcache of index  I  has  a  single
     child subcache of index I+1:

        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL ccccaaaaeeeessssaaaarrrr____cccchhhhiiiilllldddd ((((ccccaaaaeeeessssaaaarrrr____ccccaaaacccchhhheeee,,,, ccccaaaaeeeessssaaaarrrr____iiiinnnnddddeeeexxxx,,,, ccccaaaaeeeessssaaaarrrr____bbbbaaaasssseeee))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____CCCCAAAACCCCHHHHEEEE____1111 ccccaaaaeeeessssaaaarrrr____ccccaaaacccchhhheeee;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL ccccaaaaeeeessssaaaarrrr____iiiinnnnddddeeeexxxx;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____PPPPOOOOIIIINNNNTTTTEEEERRRR ccccaaaaeeeessssaaaarrrr____bbbbaaaasssseeee;;;;
        {{{{
           rrrreeeettttuuuurrrrnnnn ((((ccccaaaaeeeessssaaaarrrr____iiiinnnnddddeeeexxxx ++++ 1111))));;;;
        }}}}

     This  function  does  not  use  the  ccccaaaaeeeessssaaaarrrr____ccccaaaacccchhhheeee  and   the
     ccccaaaaeeeessssaaaarrrr____bbbbaaaasssseeee  parameters. However, general user-defined func-
     tions can implement parent relations that may change dynami-
     cally  depending  on the current status of the cache pointed
     to by ccccaaaaeeeessssaaaarrrr____ccccaaaacccchhhheeee, the current status of  its  subcache  of
     index  ccccaaaaeeeessssaaaarrrr____iiiinnnnddddeeeexxxx  and/or the contents of the item pointed
     to by ccccaaaaeeeessssaaaarrrr____bbbbaaaasssseeee.

     The value of CCCCAAAAEEEESSSSAAAARRRR____BBBBAAAASSSSEEEE____AAAARRRREEEEAAAA determines the (constant) size
     and  (constant)  alignment  factor  of the base field in the
     cache. In the particular case where base fields are used  to
     store  states  (resp.  labels,  strings),  one must give the
     value  CCCCAAAAEEEESSSSAAAARRRR____SSSSTTTTAAAATTTTEEEE____AAAARRRREEEEAAAA____1111(((())))  (resp.  CCCCAAAAEEEESSSSAAAARRRR____LLLLAAAABBBBEEEELLLL____AAAARRRREEEEAAAA____1111(((()))),
     CCCCAAAAEEEESSSSAAAARRRR____SSSSTTTTRRRRIIIINNNNGGGG____AAAARRRREEEEAAAA____1111(((()))))     to    the    formal    parameter
     CCCCAAAAEEEESSSSAAAARRRR____BBBBAAAASSSSEEEE____AAAARRRREEEEAAAA.

     The value of CCCCAAAAEEEESSSSAAAARRRR____MMMMAAAARRRRKKKK____AAAARRRREEEEAAAA determines the (constant) size
     and  (constant) alignment factor of the mark field according
     to the specifications of the ``area_1'' library. In particu-
     lar,  if CCCCAAAAEEEESSSSAAAARRRR____MMMMAAAARRRRKKKK____AAAARRRREEEEAAAA is equal to CCCCAAAAEEEESSSSAAAARRRR____EEEEMMMMPPPPTTTTYYYY____AAAARRRREEEEAAAA____1111(((()))),
     there will be no mark field in the cache.

     Each item in the cache will be represented as a byte  string
     of  fixed  size ccccaaaaeeeessssaaaarrrr____iiiitttteeeemmmm____ssssiiiizzzzeeee, such that ccccaaaaeeeessssaaaarrrr____iiiitttteeeemmmm____ssssiiiizzzzeeee
     is greater or equal to ccccaaaaeeeessssaaaarrrr____bbbbaaaasssseeee____ssssiiiizzzzeeee +  ccccaaaaeeeessssaaaarrrr____mmmmaaaarrrrkkkk____ssssiiiizzzzeeee,
     where  ccccaaaaeeeessssaaaarrrr____bbbbaaaasssseeee____ssssiiiizzzzeeee  denotes  the size (in bytes) of the
     base field (i.e., CCCCAAAAEEEESSSSAAAARRRR____SSSSIIIIZZZZEEEE____AAAARRRREEEEAAAA____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____BBBBAAAASSSSEEEE____AAAARRRREEEEAAAA))))) and



(C) INRIA     Last change: 2020/02/11 (version 1.2)            20






OPEN/CAESAR MANUAL                          caesar_cache_1(LOCAL)



     where  ccccaaaaeeeessssaaaarrrr____mmmmaaaarrrrkkkk____ssssiiiizzzzeeee  denotes  the size (in bytes) of the
     mark    field,    if    any    (i.e.,     CCCCAAAAEEEESSSSAAAARRRR____SSSSIIIIZZZZEEEE____AAAARRRREEEEAAAA____1111
     ((((CCCCAAAAEEEESSSSAAAARRRR____MMMMAAAARRRRKKKK____AAAARRRREEEEAAAA))))).

     An item in the cache contains not only the  base  field  and
     the  mark  field,  but  also  ``padding''  bytes that may be
     inserted between the base and mark  fields  to  ensure  that
     these    fields   are   correctly   aligned   according   to
     CCCCAAAAEEEESSSSAAAARRRR____AAAALLLLIIIIGGGGNNNNMMMMEEEENNNNTTTT____AAAARRRREEEEAAAA____1111        ((((CCCCAAAAEEEESSSSAAAARRRR____BBBBAAAASSSSEEEE____AAAARRRREEEEAAAA))))        and
     CCCCAAAAEEEESSSSAAAARRRR____AAAALLLLIIIIGGGGNNNNMMMMEEEENNNNTTTT____AAAARRRREEEEAAAA____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____MMMMAAAARRRRKKKK____AAAARRRREEEEAAAA)))).

     The value  of  CCCCAAAAEEEESSSSAAAARRRR____HHHHAAAASSSSHHHH____SSSSIIIIZZZZEEEE  determines  the  number  of
     entries  in the hash-table associated to the cache. If it is
     equal to zero, it is replaced with a default  value  greater
     than zero.

     If the value of CCCCAAAAEEEESSSSAAAARRRR____PPPPRRRRIIIIMMMMEEEE is equal to CCCCAAAAEEEESSSSAAAARRRR____TTTTRRRRUUUUEEEE and  if
     the  value  of  CCCCAAAAEEEESSSSAAAARRRR____HHHHAAAASSSSHHHH____SSSSIIIIZZZZEEEE is not a prime number, this
     value will be replaced by the nearest smaller  prime  number
     (since  some  hash  functions require prime modulus). Other-
     wise, the value of CCCCAAAAEEEESSSSAAAARRRR____HHHHAAAASSSSHHHH____SSSSIIIIZZZZEEEE will be kept unchanged.

     The actual value of the formal parameter CCCCAAAAEEEESSSSAAAARRRR____CCCCOOOOMMMMPPPPAAAARRRREEEE will
     be  stored  and  associated  to  the  cache  pointed  to  by
     ****CCCCAAAAEEEESSSSAAAARRRR____CCCC. It will be used as a comparison function when  it
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
     stored  and associated to the cache pointed to by ****CCCCAAAAEEEESSSSAAAARRRR____CCCC.
     It will be used as a hash-function when it is  necessary  to
     compute  a  hash-value for searching or inserting an item in
     the cache.

     Precisely, the actual  value  of  CCCCAAAAEEEESSSSAAAARRRR____HHHHAAAASSSSHHHH  should  be  a
     pointer   to   a   hash   function   with   two   parameters
     ccccaaaaeeeessssaaaarrrr____ppppooooiiiinnnntttteeeerrrr and ccccaaaaeeeessssaaaarrrr____mmmmoooodddduuuulllluuuussss  that  returns  a  natural
     number in the range 0..ccccaaaaeeeessssaaaarrrr____mmmmoooodddduuuulllluuuussss - 1.




(C) INRIA     Last change: 2020/02/11 (version 1.2)            21






OPEN/CAESAR MANUAL                          caesar_cache_1(LOCAL)



     If the actual value of the formal parameter  CCCCAAAAEEEESSSSAAAARRRR____HHHHAAAASSSSHHHH  is
     NNNNUUUULLLLLLLL, it is replaced by a pointer to a default hash function
     that depends on the value of CCCCAAAAEEEESSSSAAAARRRR____BBBBAAAASSSSEEEE____AAAARRRREEEEAAAA and is  deter-
     mined   according   to  the  rules  specified  for  function
     CCCCAAAAEEEESSSSAAAARRRR____UUUUSSSSEEEE____HHHHAAAASSSSHHHH____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN____AAAARRRREEEEAAAA____1111(((()))) of the ``area_1'' library.

     The actual value of the formal parameter  CCCCAAAAEEEESSSSAAAARRRR____PPPPRRRRIIIINNNNTTTT  will
     be  stored  and  associated  to  the  cache  pointed  to  by
     ****CCCCAAAAEEEESSSSAAAARRRR____CCCC. It will be used subsequently to print  the  items
     of this cache.

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
     library.

     The actual value of the formal parameter CCCCAAAAEEEESSSSAAAARRRR____CCCCLLLLEEEEAAAANNNNUUUUPPPP will
     be  stored  and  associated  to  the  cache  pointed  to  by
     ****CCCCAAAAEEEESSSSAAAARRRR____CCCC. It will be used subsequently to clean up the con-
     tents of the items deleted from this cache.

     Precisely, the actual value of CCCCAAAAEEEESSSSAAAARRRR____CCCCLLLLEEEEAAAANNNNUUUUPPPP  should  be  a
     pointer  to  a procedure with one parameter ccccaaaaeeeessssaaaarrrr____iiiitttteeeemmmm that
     cleans up the contents (base field and mark field,  if  any)
     of  the  item pointed to by ccccaaaaeeeessssaaaarrrr____iiiitttteeeemmmm. This cleanup opera-
     tion is useful if the base and/or the mark fields  (if  any)
     of  items contain pointers to dynamic data structures (e.g.,
     lists, sets, etc.) that must be freed when those  items  are
     deleted  from the cache. For example, if the base field is a
     list of edges of type CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____EEEEDDDDGGGGEEEE that must not be kept
     in memory when items are deleted from the cache, a good can-
     didate   for   the   CCCCAAAAEEEESSSSAAAARRRR____CCCCLLLLEEEEAAAANNNNUUUUPPPP   parameter    is    the
     CCCCAAAAEEEESSSSAAAARRRR____DDDDEEEELLLLEEEETTTTEEEE____EEEEDDDDGGGGEEEE____LLLLIIIISSSSTTTT(((()))) procedure of the ``edge'' library,
     which deletes the list pointed to by the base field  of  the
     item  pointed  to  by  ccccaaaaeeeessssaaaarrrr____iiiitttteeeemmmm,  and then sets this base
     field to NNNNUUUULLLLLLLL.

     If the actual value of the formal  parameter  CCCCAAAAEEEESSSSAAAARRRR____CCCCLLLLEEEEAAAANNNNUUUUPPPP
     is NNNNUUUULLLLLLLL, there will be no cleanup operation performed on the
     contents of the items when these items are deleted from  the
     cache.



(C) INRIA     Last change: 2020/02/11 (version 1.2)            22






OPEN/CAESAR MANUAL                          caesar_cache_1(LOCAL)



     The actual value of the formal parameter CCCCAAAAEEEESSSSAAAARRRR____IIIINNNNFFFFOOOO will be
     stored  and associated to the cache pointed to by ****CCCCAAAAEEEESSSSAAAARRRR____CCCC.
     This value should be a pointer to some data  structure  con-
     taining  user-defined information that will be associated to
     this cache. The value of this pointer remains unchanged dur-
     ing the lifetime of the cache and can be inspected using the
     CCCCAAAAEEEESSSSAAAARRRR____IIIINNNNFFFFOOOO____CCCCAAAACCCCHHHHEEEE____1111(((()))) function (see below).


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____CCCCUUUURRRRRRRREEEENNNNTTTT____CCCCAAAACCCCHHHHEEEE____1111

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____CCCCAAAACCCCHHHHEEEE____1111 CCCCAAAAEEEESSSSAAAARRRR____CCCCUUUURRRRRRRREEEENNNNTTTT____CCCCAAAACCCCHHHHEEEE____1111 (((())))
        {{{{ ............ }}}}

     This function returns  a  pointer  to  the  cache  which  is
     currently  in use. It should be called only within the func-
     tions and procedures given as actual values for  the  formal
     parameters CCCCAAAAEEEESSSSAAAARRRR____SSSSUUUUBBBBCCCCAAAACCCCHHHHEEEE____SSSSIIIIZZZZEEEE, CCCCAAAAEEEESSSSAAAARRRR____SSSSUUUUBBBBCCCCAAAACCCCHHHHEEEE____PPPPEEEERRRRCCCCEEEENNNNTTTTAAAAGGGGEEEE,
     CCCCAAAAEEEESSSSAAAARRRR____CCCCOOOOMMMMPPPPAAAARRRREEEE,     CCCCAAAAEEEESSSSAAAARRRR____HHHHAAAASSSSHHHH,      CCCCAAAAEEEESSSSAAAARRRR____PPPPRRRRIIIINNNNTTTT,      and
     CCCCAAAAEEEESSSSAAAARRRR____CCCCLLLLEEEEAAAANNNNUUUUPPPP  of  procedure  CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTEEEE____CCCCAAAACCCCHHHHEEEE____1111(((())))  (see
     above); in this case, the result is a pointer to  the  cache
     created  by  the  call  to  CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTEEEE____CCCCAAAACCCCHHHHEEEE____1111(((()))). If this
     function is called anywhere else in the application program,
     the result is undefined.

     Note: This function allows to identify the  cache  to  which
     the  items  passed  as  arguments  to the six aforementioned
     functions and procedures belong, and thus  to  handle  these
     items  accordingly  (the  size  and  the  contents  of items
     belonging to different caches may differ). It is  especially
     useful  when  the  number  of  caches  is unknown statically
     (e.g., when new caches are created  dynamically  during  the
     execution of the application program).


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____CCCCUUUURRRRRRRREEEENNNNTTTT____SSSSUUUUBBBBCCCCAAAACCCCHHHHEEEE____CCCCAAAACCCCHHHHEEEE____1111

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL CCCCAAAAEEEESSSSAAAARRRR____CCCCUUUURRRRRRRREEEENNNNTTTT____SSSSUUUUBBBBCCCCAAAACCCCHHHHEEEE____CCCCAAAACCCCHHHHEEEE____1111 (((())))
        {{{{ ............ }}}}

     This function returns the index of  the  subcache  which  is
     currently  in use; this subcache is in turn contained in the
     cache which is currently in use, pointed to by the result of
     function  CCCCAAAAEEEESSSSAAAARRRR____CCCCUUUURRRRRRRREEEENNNNTTTT____CCCCAAAACCCCHHHHEEEE____1111(((()))) (see above). It should be
     called only within the functions  and  procedures  given  as
     actual      values     for     the     formal     parameters
     CCCCAAAAEEEESSSSAAAARRRR____SSSSUUUUBBBBCCCCAAAACCCCHHHHEEEE____OOOORRRRDDDDEEEERRRR,     CCCCAAAAEEEESSSSAAAARRRR____CCCCOOOOMMMMPPPPAAAARRRREEEE,      CCCCAAAAEEEESSSSAAAARRRR____HHHHAAAASSSSHHHH,
     CCCCAAAAEEEESSSSAAAARRRR____PPPPRRRRIIIINNNNTTTT,     and     CCCCAAAAEEEESSSSAAAARRRR____CCCCLLLLEEEEAAAANNNNUUUUPPPP     of    procedure



(C) INRIA     Last change: 2020/02/11 (version 1.2)            23






OPEN/CAESAR MANUAL                          caesar_cache_1(LOCAL)



     CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTEEEE____CCCCAAAACCCCHHHHEEEE____1111(((())))  (see  above);  in  this  case,  the
     result  is the index of the subcache, i.e., a natural number
     in the range 0..N-1, where N is the number of  subcaches  in
     the cache created by the call to CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTEEEE____CCCCAAAACCCCHHHHEEEE____1111(((()))). If
     this function is called anywhere  else  in  the  application
     program, the result is undefined.

     Note: This function allows to identify the subcache to which
     the  items  passed  as  arguments to the five aforementioned
     functions and procedures belong, and thus  to  handle  these
     items accordingly.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____DDDDEEEELLLLEEEETTTTEEEE____CCCCAAAACCCCHHHHEEEE____1111

     vvvvooooiiiidddd CCCCAAAAEEEESSSSAAAARRRR____DDDDEEEELLLLEEEETTTTEEEE____CCCCAAAACCCCHHHHEEEE____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____CCCC))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____CCCCAAAACCCCHHHHEEEE____1111 ****CCCCAAAAEEEESSSSAAAARRRR____CCCC;;;;
        {{{{ ............ }}}}

     This procedure frees the memory space corresponding  to  the
     cache pointed to by ****CCCCAAAAEEEESSSSAAAARRRR____CCCC using CCCCAAAAEEEESSSSAAAARRRR____DDDDEEEELLLLEEEETTTTEEEE(((()))). All the
     items currently present in the cache are freed  by  invoking
     first the cleanup function (if any) associated to the cache,
     and then CCCCAAAAEEEESSSSAAAARRRR____DDDDEEEELLLLEEEETTTTEEEE(((()))).  Afterwards,  the  NNNNUUUULLLLLLLL  value  is
     assigned to ****CCCCAAAAEEEESSSSAAAARRRR____CCCC.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____PPPPUUUURRRRGGGGEEEE____SSSSUUUUBBBBCCCCAAAACCCCHHHHEEEE____CCCCAAAACCCCHHHHEEEE____1111

     vvvvooooiiiidddd CCCCAAAAEEEESSSSAAAARRRR____PPPPUUUURRRRGGGGEEEE____SSSSUUUUBBBBCCCCAAAACCCCHHHHEEEE____CCCCAAAACCCCHHHHEEEE____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____CCCC,,,, CCCCAAAAEEEESSSSAAAARRRR____NNNN))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____CCCCAAAACCCCHHHHEEEE____1111 CCCCAAAAEEEESSSSAAAARRRR____CCCC;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL CCCCAAAAEEEESSSSAAAARRRR____NNNN;;;;
        {{{{ ............ }}}}

     This procedure reinitializes the information  associated  to
     the  subcache  of  index CCCCAAAAEEEESSSSAAAARRRR____NNNN of the cache pointed to by
     CCCCAAAAEEEESSSSAAAARRRR____CCCC. All the items currently present  in  the  subcache
     are  freed  by  invoking first the cleanup function (if any)
     associated to the cache, and  then  CCCCAAAAEEEESSSSAAAARRRR____DDDDEEEELLLLEEEETTTTEEEE(((()))).  After-
     wards,  the  subcache  is exactly in the same state as after
     the creation of the cache using CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTEEEE____CCCCAAAACCCCHHHHEEEE____1111(((()))).

     If the subcache index CCCCAAAAEEEESSSSAAAARRRR____NNNN is outside the  range  0..N-1
     (where  N  is  the  number  of  subcaches in the cache), the
     effect is undefined.






(C) INRIA     Last change: 2020/02/11 (version 1.2)            24






OPEN/CAESAR MANUAL                          caesar_cache_1(LOCAL)



      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____PPPPUUUURRRRGGGGEEEE____CCCCAAAACCCCHHHHEEEE____1111

     vvvvooooiiiidddd CCCCAAAAEEEESSSSAAAARRRR____PPPPUUUURRRRGGGGEEEE____CCCCAAAACCCCHHHHEEEE____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____CCCC))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____CCCCAAAACCCCHHHHEEEE____1111 CCCCAAAAEEEESSSSAAAARRRR____CCCC;;;;
        {{{{ ............ }}}}

     This procedure reinitializes the information  associated  to
     the  cache  pointed  to by CCCCAAAAEEEESSSSAAAARRRR____CCCC. All the items currently
     present in the cache are freed by invoking first the cleanup
     function   (if  any)  associated  to  the  cache,  and  then
     CCCCAAAAEEEESSSSAAAARRRR____DDDDEEEELLLLEEEETTTTEEEE(((()))). Afterwards, the cache  is  exactly  in  the
     same     state     as     after     its    creation    using
     CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTEEEE____CCCCAAAACCCCHHHHEEEE____1111(((()))).


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____SSSSEEEEAAAARRRRCCCCHHHH____CCCCAAAACCCCHHHHEEEE____1111

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____BBBBOOOOOOOOLLLLEEEEAAAANNNN CCCCAAAAEEEESSSSAAAARRRR____SSSSEEEEAAAARRRRCCCCHHHH____CCCCAAAACCCCHHHHEEEE____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____CCCC,,,, CCCCAAAAEEEESSSSAAAARRRR____BBBB,,,, CCCCAAAAEEEESSSSAAAARRRR____NNNN,,,, CCCCAAAAEEEESSSSAAAARRRR____PPPP))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____CCCCAAAACCCCHHHHEEEE____1111 CCCCAAAAEEEESSSSAAAARRRR____CCCC;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____PPPPOOOOIIIINNNNTTTTEEEERRRR CCCCAAAAEEEESSSSAAAARRRR____BBBB;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL ****CCCCAAAAEEEESSSSAAAARRRR____NNNN;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____PPPPOOOOIIIINNNNTTTTEEEERRRR ****CCCCAAAAEEEESSSSAAAARRRR____PPPP;;;;
        {{{{ ............ }}}}

     This function determines  if  there  exists,  in  the  cache
     pointed to by CCCCAAAAEEEESSSSAAAARRRR____CCCC, an item whose base field is equal to
     the byte string pointed to by  CCCCAAAAEEEESSSSAAAARRRR____BBBB.  Byte  string  com-
     parisons are performed using the comparison function associ-
     ated to the cache.  The  search  is  done  using  the  hash-
     function and hash-table associated to the cache.

     If so, this function returns CCCCAAAAEEEESSSSAAAARRRR____TTTTRRRRUUUUEEEE. In this case,  the
     index  of  the subcache containing the existing item and the
     address of the item are respectively assigned  to  ****CCCCAAAAEEEESSSSAAAARRRR____NNNN
     and  ****CCCCAAAAEEEESSSSAAAARRRR____PPPP. The number of searches and hits at the cache
     and the current global date of the  cache  are  incremented.
     The  number  of  hits at the subcache is incremented and the
     current local date of the subcache is  set  to  the  current
     global  date of the cache. The number of hits at the item is
     also incremented and the date of the last access to the item
     is  set  to  the  current global date of the cache (the item
     becomes the most recently accessed item in the cache).

     If not, this function returns CCCCAAAAEEEESSSSAAAARRRR____FFFFAAAALLLLSSSSEEEE.  In  this  case,
     both  variables  ****CCCCAAAAEEEESSSSAAAARRRR____NNNN and ****CCCCAAAAEEEESSSSAAAARRRR____PPPP are left unchanged.
     The number of searches in  the  cache  is  incremented.  The
     number  of  hits at the cache and the current global date of
     the cache are left unchanged.



(C) INRIA     Last change: 2020/02/11 (version 1.2)            25






OPEN/CAESAR MANUAL                          caesar_cache_1(LOCAL)



      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____PPPPUUUUTTTT____BBBBAAAASSSSEEEE____CCCCAAAACCCCHHHHEEEE____1111

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____PPPPOOOOIIIINNNNTTTTEEEERRRR CCCCAAAAEEEESSSSAAAARRRR____PPPPUUUUTTTT____BBBBAAAASSSSEEEE____CCCCAAAACCCCHHHHEEEE____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____CCCC))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____CCCCAAAACCCCHHHHEEEE____1111 CCCCAAAAEEEESSSSAAAARRRR____CCCC;;;;
        {{{{ ............ }}}}

     This function returns a pointer to the  base  field  of  the
     next item to be put into the cache pointed to by CCCCAAAAEEEESSSSAAAARRRR____CCCC.

     The   base   field   pointed   to   by   the    result    of
     CCCCAAAAEEEESSSSAAAARRRR____PPPPUUUUTTTT____BBBBAAAASSSSEEEE____CCCCAAAACCCCHHHHEEEE____1111(((()))) is initially undefined and must be
     assigned  before  calling  some  other  functions   of   the
     ``cache_1'' library (see below).

      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____PPPPUUUUTTTT____MMMMAAAARRRRKKKK____CCCCAAAACCCCHHHHEEEE____1111

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____PPPPOOOOIIIINNNNTTTTEEEERRRR CCCCAAAAEEEESSSSAAAARRRR____PPPPUUUUTTTT____MMMMAAAARRRRKKKK____CCCCAAAACCCCHHHHEEEE____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____CCCC))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____CCCCAAAACCCCHHHHEEEE____1111 CCCCAAAAEEEESSSSAAAARRRR____CCCC;;;;
        {{{{ ............ }}}}

     This function returns a pointer to the  mark  field  of  the
     next  item  to be put into the cache pointed to by CCCCAAAAEEEESSSSAAAARRRR____CCCC.
     If there are no mark fields in the cache (due  to  the  ini-
     tialization  parameters supplied to CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTEEEE____CCCCAAAACCCCHHHHEEEE____1111(((()))))
     the result is undefined.

     The   mark   field   pointed   to   by   the    result    of
     CCCCAAAAEEEESSSSAAAARRRR____PPPPUUUUTTTT____MMMMAAAARRRRKKKK____CCCCAAAACCCCHHHHEEEE____1111(((())))  is  always  initialized  to a bit
     string of 0's. It can be either consulted or modified.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____PPPPUUUUTTTT____CCCCAAAACCCCHHHHEEEE____1111

     vvvvooooiiiidddd CCCCAAAAEEEESSSSAAAARRRR____PPPPUUUUTTTT____CCCCAAAACCCCHHHHEEEE____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____CCCC))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____CCCCAAAACCCCHHHHEEEE____1111 CCCCAAAAEEEESSSSAAAARRRR____CCCC;;;;
        {{{{ ............ }}}}

     This procedure puts into the cache pointed  to  by  CCCCAAAAEEEESSSSAAAARRRR____CCCC
     the    item    whose   base   field   is   pointed   to   by
     CCCCAAAAEEEESSSSAAAARRRR____PPPPUUUUTTTT____BBBBAAAASSSSEEEE____CCCCAAAACCCCHHHHEEEE____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____CCCC)))) and whose mark field  (if
     any) is pointed to by CCCCAAAAEEEESSSSAAAARRRR____PPPPUUUUTTTT____MMMMAAAARRRRKKKK____CCCCAAAACCCCHHHHEEEE____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____CCCC)))).

     The base field must have been assigned before this procedure
     is called.

     This   procedure    also    sets    a    field    of    type



(C) INRIA     Last change: 2020/02/11 (version 1.2)            26






OPEN/CAESAR MANUAL                          caesar_cache_1(LOCAL)



     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____EEEERRRRRRRROOOORRRR____CCCCAAAACCCCHHHHEEEE____1111  associated to the cache, indicat-
     ing whether the put operation was carried  out  successfully
     or  not;  this  field  can  be  inspected using the function
     CCCCAAAAEEEESSSSAAAARRRR____SSSSTTTTAAAATTTTUUUUSSSS____PPPPUUUUTTTT____CCCCAAAACCCCHHHHEEEE____1111(((()))) (see below).

     The hash-table associated to the cache is  updated  to  take
     into account the new item. To compute the hash-value for the
     base field, the hash-function associated  to  the  cache  is
     used.

     If the put operation causes  another  item  E  contained  in
     (some  leaf subcache of) the cache to be replaced, this item
     is stored temporarily in a field  associated  to  the  cache
     until    a    future   call   to   CCCCAAAAEEEESSSSAAAARRRR____PPPPUUUUTTTT____CCCCAAAACCCCHHHHEEEE____1111(((())))   or
     CCCCAAAAEEEESSSSAAAARRRR____SSSSEEEEAAAARRRRCCCCHHHH____AAAANNNNDDDD____PPPPUUUUTTTT____CCCCAAAACCCCHHHHEEEE____1111(((()))) will cause another  replace-
     ment  to  take place. Meanwhile, the item E can be inspected
     by using the  CCCCAAAAEEEESSSSAAAARRRR____LLLLAAAASSSSTTTT____IIIITTTTEEEEMMMM____RRRREEEEPPPPLLLLAAAACCCCEEEEDDDD____CCCCAAAACCCCHHHHEEEE____1111(((())))  procedure
     (see  below).  When the next replacement takes place, if the
     item E has  not  been  inspected  meanwhile  by  a  call  to
     CCCCAAAAEEEESSSSAAAARRRR____LLLLAAAASSSSTTTT____IIIITTTTEEEEMMMM____RRRREEEEPPPPLLLLAAAACCCCEEEEDDDD____CCCCAAAACCCCHHHHEEEE____1111(((()))),   it   will   be  first
     cleaned up using the cleanup function (if any) associated to
     the  cache, and then freed using CCCCAAAAEEEESSSSAAAARRRR____DDDDEEEELLLLEEEETTTTEEEE(((()))); otherwise,
     the item E will not be cleaned up (because it is the  user's
     responsibility  to  manage the memory possibly referenced in
     the contents of this item), but freed using  CCCCAAAAEEEESSSSAAAARRRR____DDDDEEEELLLLEEEETTTTEEEE(((())))
     only.

     Note: the cache is implemented in  such  a  way  that  if  a
     memory shortage occurs during a put operation when the cache
     is not already full, all the  subcaches  are  considered  to
     become  full  and  their  associated  replacement strategies
     start to be used.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____SSSSEEEEAAAARRRRCCCCHHHH____AAAANNNNDDDD____PPPPUUUUTTTT____CCCCAAAACCCCHHHHEEEE____1111

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____BBBBOOOOOOOOLLLLEEEEAAAANNNN CCCCAAAAEEEESSSSAAAARRRR____SSSSEEEEAAAARRRRCCCCHHHH____AAAANNNNDDDD____PPPPUUUUTTTT____CCCCAAAACCCCHHHHEEEE____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____CCCC,,,, CCCCAAAAEEEESSSSAAAARRRR____NNNN,,,, CCCCAAAAEEEESSSSAAAARRRR____PPPP))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____CCCCAAAACCCCHHHHEEEE____1111 CCCCAAAAEEEESSSSAAAARRRR____CCCC;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL ****CCCCAAAAEEEESSSSAAAARRRR____NNNN;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____PPPPOOOOIIIINNNNTTTTEEEERRRR ****CCCCAAAAEEEESSSSAAAARRRR____PPPP;;;;
        {{{{ ............ }}}}

     This   function   is   a   combination   of   the   function
     CCCCAAAAEEEESSSSAAAARRRR____SSSSEEEEAAAARRRRCCCCHHHH____CCCCAAAACCCCHHHHEEEE____1111(((())))        and       the       procedure
     CCCCAAAAEEEESSSSAAAARRRR____PPPPUUUUTTTT____CCCCAAAACCCCHHHHEEEE____1111(((()))) defined above.

     The  base  field  pointed  to   by   CCCCAAAAEEEESSSSAAAARRRR____PPPPUUUUTTTT____BBBBAAAASSSSEEEE____CCCCAAAACCCCHHHHEEEE____1111
     ((((CCCCAAAAEEEESSSSAAAARRRR____CCCC))))  must  have been assigned before this function is
     called.




(C) INRIA     Last change: 2020/02/11 (version 1.2)            27






OPEN/CAESAR MANUAL                          caesar_cache_1(LOCAL)



     It first determines if there exists, in the cache pointed to
     by  CCCCAAAAEEEESSSSAAAARRRR____CCCC,  an item whose base field is equal to the base
     field of the  item  pointed  to  by  CCCCAAAAEEEESSSSAAAARRRR____PPPPUUUUTTTT____BBBBAAAASSSSEEEE____CCCCAAAACCCCHHHHEEEE____1111
     ((((CCCCAAAAEEEESSSSAAAARRRR____CCCC)))).  Byte string comparisons are performed using the
     comparison function associated to the cache. The  search  is
     done  using  the  hash-function and hash-table associated to
     the cache.

     If so, this function returns CCCCAAAAEEEESSSSAAAARRRR____TTTTRRRRUUUUEEEE. In this case,  the
     index  of  the subcache containing the existing item and the
     address of the item are respectively assigned  to  ****CCCCAAAAEEEESSSSAAAARRRR____NNNN
     and  ****CCCCAAAAEEEESSSSAAAARRRR____PPPP. The number of searches and hits at the cache
     and the current global date of the  cache  are  incremented.
     The  number  of  hits at the subcache is incremented and the
     current local date of the subcache is  set  to  the  current
     global  date of the cache. The number of hits at the item is
     also incremented and the date of the last access to the item
     is  set  to  the  current global date of the cache (the item
     becomes the most recently accessed item in the  cache).  The
     field  of  type  CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____EEEERRRRRRRROOOORRRR____CCCCAAAACCCCHHHHEEEE____1111 associated to the
     cache is set to CCCCAAAAEEEESSSSAAAARRRR____NNNNOOOONNNNEEEE____CCCCAAAACCCCHHHHEEEE____1111.

     If not, this function returns CCCCAAAAEEEESSSSAAAARRRR____FFFFAAAALLLLSSSSEEEE. In this case, it
     puts  into  the  cache pointed to by CCCCAAAAEEEESSSSAAAARRRR____CCCC the item whose
     base  field  is  pointed   to   by   CCCCAAAAEEEESSSSAAAARRRR____PPPPUUUUTTTT____BBBBAAAASSSSEEEE____CCCCAAAACCCCHHHHEEEE____1111
     ((((CCCCAAAAEEEESSSSAAAARRRR____CCCC))))  and  whose  mark field (if any) is pointed to by
     CCCCAAAAEEEESSSSAAAARRRR____PPPPUUUUTTTT____MMMMAAAARRRRKKKK____CCCCAAAACCCCHHHHEEEE____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____CCCC)))). The  hash-table  associ-
     ated  to  the  cache is updated to take into account the new
     item. The number of searches in the cache  and  the  current
     global date of the cache are incremented.

     The field of type  CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____EEEERRRRRRRROOOORRRR____CCCCAAAACCCCHHHHEEEE____1111  associated  to
     the  cache  is set to indicate whether the put operation was
     carried out successfully or not. If the put  operation  suc-
     ceeded,  variable  ****CCCCAAAAEEEESSSSAAAARRRR____NNNN  is assigned the value 0 (since
     the item was put into the root subcache,  of  index  0)  and
     variable  ****CCCCAAAAEEEESSSSAAAARRRR____PPPP  is  assigned  the  address of the item,
     which is now contained in the cache. If  the  put  operation
     failed  (because a cycle was detected in the parent relation
     between subcaches), the variables  ****CCCCAAAAEEEESSSSAAAARRRR____NNNN  and  ****CCCCAAAAEEEESSSSAAAARRRR____PPPP
     are left unchanged.

     If the put operation causes  another  item  E  contained  in
     (some  leaf subcache of) the cache to be replaced, this item
     is stored temporarily in a field  associated  to  the  cache
     until    a    future   call   to   CCCCAAAAEEEESSSSAAAARRRR____PPPPUUUUTTTT____CCCCAAAACCCCHHHHEEEE____1111(((())))   or
     CCCCAAAAEEEESSSSAAAARRRR____SSSSEEEEAAAARRRRCCCCHHHH____AAAANNNNDDDD____PPPPUUUUTTTT____CCCCAAAACCCCHHHHEEEE____1111(((()))) will cause another  replace-
     ment  to  take place. Meanwhile, the item E can be inspected
     by using the  CCCCAAAAEEEESSSSAAAARRRR____LLLLAAAASSSSTTTT____IIIITTTTEEEEMMMM____RRRREEEEPPPPLLLLAAAACCCCEEEEDDDD____CCCCAAAACCCCHHHHEEEE____1111(((())))  procedure
     (see  below).  When the next replacement takes place, if the
     item E has  not  been  inspected  meanwhile  by  a  call  to
     CCCCAAAAEEEESSSSAAAARRRR____LLLLAAAASSSSTTTT____IIIITTTTEEEEMMMM____RRRREEEEPPPPLLLLAAAACCCCEEEEDDDD____CCCCAAAACCCCHHHHEEEE____1111(((()))),   it   will   be  first



(C) INRIA     Last change: 2020/02/11 (version 1.2)            28






OPEN/CAESAR MANUAL                          caesar_cache_1(LOCAL)



     cleaned up using the cleanup function (if any) associated to
     the  cache, and then freed using CCCCAAAAEEEESSSSAAAARRRR____DDDDEEEELLLLEEEETTTTEEEE(((()))); otherwise,
     the item E will not be cleaned up (because it is the  user's
     responsibility  to  manage the memory possibly referenced in
     the contents of this item), but freed using  CCCCAAAAEEEESSSSAAAARRRR____DDDDEEEELLLLEEEETTTTEEEE(((())))
     only.

     Note: the cache is implemented in  such  a  way  that  if  a
     memory shortage occurs during a put operation when the cache
     is not already full, all the  subcaches  are  considered  to
     become  full  and  their  associated  replacement strategies
     start to be used.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____SSSSTTTTAAAATTTTUUUUSSSS____PPPPUUUUTTTT____CCCCAAAACCCCHHHHEEEE____1111

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____EEEERRRRRRRROOOORRRR____CCCCAAAACCCCHHHHEEEE____1111 CCCCAAAAEEEESSSSAAAARRRR____SSSSTTTTAAAATTTTUUUUSSSS____PPPPUUUUTTTT____CCCCAAAACCCCHHHHEEEE____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____CCCC))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____CCCCAAAACCCCHHHHEEEE____1111 CCCCAAAAEEEESSSSAAAARRRR____CCCC;;;;
        {{{{ ............ }}}}

     This function returns the status of the last  put  operation
     performed by a call to the procedure CCCCAAAAEEEESSSSAAAARRRR____PPPPUUUUTTTT____CCCCAAAACCCCHHHHEEEE____1111(((()))) or
     to the function CCCCAAAAEEEESSSSAAAARRRR____SSSSEEEEAAAARRRRCCCCHHHH____AAAANNNNDDDD____PPPPUUUUTTTT____CCCCAAAACCCCHHHHEEEE____1111(((()))) (see  above)
     on the cache pointed to by CCCCAAAAEEEESSSSAAAARRRR____CCCC.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____MMMMIIIINNNNIIIIMMMMAAAALLLL____IIIITTTTEEEEMMMM____CCCCAAAACCCCHHHHEEEE____1111

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____PPPPOOOOIIIINNNNTTTTEEEERRRR CCCCAAAAEEEESSSSAAAARRRR____MMMMIIIINNNNIIIIMMMMAAAALLLL____IIIITTTTEEEEMMMM____CCCCAAAACCCCHHHHEEEE____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____CCCC,,,, CCCCAAAAEEEESSSSAAAARRRR____NNNN))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____CCCCAAAACCCCHHHHEEEE____1111 CCCCAAAAEEEESSSSAAAARRRR____CCCC;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL CCCCAAAAEEEESSSSAAAARRRR____NNNN;;;;
        {{{{ ............ }}}}

     This function returns the address of the smallest item  con-
     tained  in  the  subcache  of  index  CCCCAAAAEEEESSSSAAAARRRR____NNNN  of the cache
     pointed to by CCCCAAAAEEEESSSSAAAARRRR____CCCC.  The  smallest  item  is  determined
     according  to  the order relation underlying the replacement
     strategy of the subcache of index CCCCAAAAEEEESSSSAAAARRRR____NNNN.

     If the index CCCCAAAAEEEESSSSAAAARRRR____NNNN is outside the range 0..N-1  (where  N
     is  the number of subcaches in the cache) or the subcache of
     index CCCCAAAAEEEESSSSAAAARRRR____NNNN is empty, the result is undefined.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____DDDDEEEELLLLEEEETTTTEEEE____IIIITTTTEEEEMMMM____CCCCAAAACCCCHHHHEEEE____1111




(C) INRIA     Last change: 2020/02/11 (version 1.2)            29






OPEN/CAESAR MANUAL                          caesar_cache_1(LOCAL)



     vvvvooooiiiidddd CCCCAAAAEEEESSSSAAAARRRR____DDDDEEEELLLLEEEETTTTEEEE____IIIITTTTEEEEMMMM____CCCCAAAACCCCHHHHEEEE____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____CCCC,,,, CCCCAAAAEEEESSSSAAAARRRR____NNNN,,,, CCCCAAAAEEEESSSSAAAARRRR____BBBB))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____CCCCAAAACCCCHHHHEEEE____1111 CCCCAAAAEEEESSSSAAAARRRR____CCCC;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL CCCCAAAAEEEESSSSAAAARRRR____NNNN;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____PPPPOOOOIIIINNNNTTTTEEEERRRR ****CCCCAAAAEEEESSSSAAAARRRR____BBBB;;;;
        {{{{ ............ }}}}

     This procedure deletes, for the subcache of  index  CCCCAAAAEEEESSSSAAAARRRR____NNNN
     of  the  cache  pointed  to by CCCCAAAAEEEESSSSAAAARRRR____CCCC, the item whose base
     field is pointed to by  ****CCCCAAAAEEEESSSSAAAARRRR____BBBB.  The  item  is  freed  by
     invoking  first  the cleanup function (if any) associated to
     the cache, and then CCCCAAAAEEEESSSSAAAARRRR____DDDDEEEELLLLEEEETTTTEEEE(((()))).  Afterwards,  the  NNNNUUUULLLLLLLL
     value is assigned to ****CCCCAAAAEEEESSSSAAAARRRR____BBBB.

     The number of items in the subcache of index CCCCAAAAEEEESSSSAAAARRRR____NNNN and in
     the  cache  is  decremented.  The current global date of the
     cache is incremented and the current local date of the  sub-
     cache of index CCCCAAAAEEEESSSSAAAARRRR____NNNN is set to the current global date of
     the cache.

     If no item stored in the subcache of index CCCCAAAAEEEESSSSAAAARRRR____NNNN  of  the
     cache  has  a  base field at address CCCCAAAAEEEESSSSAAAARRRR____BBBB, the effect is
     undefined.

     If the index CCCCAAAAEEEESSSSAAAARRRR____NNNN is outside the range 0..N-1  (where  N
     is  the number of subcaches in the cache) or the subcache of
     index CCCCAAAAEEEESSSSAAAARRRR____NNNN is empty, the effect is undefined.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____LLLLAAAASSSSTTTT____IIIITTTTEEEEMMMM____RRRREEEEPPPPLLLLAAAACCCCEEEEDDDD____CCCCAAAACCCCHHHHEEEE____1111

     vvvvooooiiiidddd CCCCAAAAEEEESSSSAAAARRRR____LLLLAAAASSSSTTTT____IIIITTTTEEEEMMMM____RRRREEEEPPPPLLLLAAAACCCCEEEEDDDD____CCCCAAAACCCCHHHHEEEE____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____CCCC,,,, CCCCAAAAEEEESSSSAAAARRRR____NNNN,,,, CCCCAAAAEEEESSSSAAAARRRR____BBBB))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____CCCCAAAACCCCHHHHEEEE____1111 CCCCAAAAEEEESSSSAAAARRRR____CCCC;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL ****CCCCAAAAEEEESSSSAAAARRRR____NNNN;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____PPPPOOOOIIIINNNNTTTTEEEERRRR ****CCCCAAAAEEEESSSSAAAARRRR____BBBB;;;;
        {{{{ ............ }}}}

     This  procedure  respectively  assigns  to   the   variables
     ****CCCCAAAAEEEESSSSAAAARRRR____NNNN  and  ****CCCCAAAAEEEESSSSAAAARRRR____BBBB  the index of the subcache and the
     address of the item that was replaced in that subcache  when
     the    last    call    to    CCCCAAAAEEEESSSSAAAARRRR____PPPPUUUUTTTT____CCCCAAAACCCCHHHHEEEE____1111(((())))    or   to
     CCCCAAAAEEEESSSSAAAARRRR____SSSSEEEEAAAARRRRCCCCHHHH____AAAANNNNDDDD____PPPPUUUUTTTT____CCCCAAAACCCCHHHHEEEE____1111(((()))) was performed on  the  cache
     pointed  to  by  CCCCAAAAEEEESSSSAAAARRRR____CCCC  and  caused a replacement to take
     place.

     This procedure also sets an  internal  field  of  the  cache
     indicating  that  the  last item replaced was inspected, and
     from now on it is the user's responsibility  to  manage  the
     memory  possibly  referenced  in  the  contents  of the item
     pointed to by ****CCCCAAAAEEEESSSSAAAARRRR____BBBB. Thus,  when  some  future  call  to
     CCCCAAAAEEEESSSSAAAARRRR____PPPPUUUUTTTT____CCCCAAAACCCCHHHHEEEE____1111(((())))  or  to CCCCAAAAEEEESSSSAAAARRRR____SSSSEEEEAAAARRRRCCCCHHHH____AAAANNNNDDDD____PPPPUUUUTTTT____CCCCAAAACCCCHHHHEEEE____1111(((())))



(C) INRIA     Last change: 2020/02/11 (version 1.2)            30






OPEN/CAESAR MANUAL                          caesar_cache_1(LOCAL)



     on the cache will cause another item  to  be  replaced,  the
     item  pointed  to  by  ****CCCCAAAAEEEESSSSAAAARRRR____BBBB  will  not be cleaned up by
     invoking the cleanup function (if  any)  associated  to  the
     cache,   but   its   contents  will  be  freed  by  invoking
     CCCCAAAAEEEESSSSAAAARRRR____DDDDEEEELLLLEEEETTTTEEEE(((()))) only.

     If none of the previous calls to CCCCAAAAEEEESSSSAAAARRRR____PPPPUUUUTTTT____CCCCAAAACCCCHHHHEEEE____1111(((()))) or  to
     CCCCAAAAEEEESSSSAAAARRRR____SSSSEEEEAAAARRRRCCCCHHHH____AAAANNNNDDDD____PPPPUUUUTTTT____CCCCAAAACCCCHHHHEEEE____1111(((()))) caused a replacement to take
     place, then the values N (where N is the number of subcaches
     in  the  cache)  and  NNNNUUUULLLLLLLL  are respectively assigned to the
     variables ****CCCCAAAAEEEESSSSAAAARRRR____NNNN and ****CCCCAAAAEEEESSSSAAAARRRR____BBBB.

     Note: The item pointed to by ****CCCCAAAAEEEESSSSAAAARRRR____BBBB can be handled in the
     same way as an ordinary item present in the cache, e.g., the
     address of  its  mark  field  can  be  retrieved  using  the
     CCCCAAAAEEEESSSSAAAARRRR____RRRREEEETTTTRRRRIIIIEEEEVVVVEEEE____BBBB____MMMM____CCCCAAAACCCCHHHHEEEE____1111(((()))) procedure.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____UUUUPPPPDDDDAAAATTTTEEEE____CCCCAAAACCCCHHHHEEEE____1111

     vvvvooooiiiidddd CCCCAAAAEEEESSSSAAAARRRR____UUUUPPPPDDDDAAAATTTTEEEE____CCCCAAAACCCCHHHHEEEE____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____CCCC,,,, CCCCAAAAEEEESSSSAAAARRRR____NNNN,,,, CCCCAAAAEEEESSSSAAAARRRR____BBBB))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____CCCCAAAACCCCHHHHEEEE____1111 CCCCAAAAEEEESSSSAAAARRRR____CCCC;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL CCCCAAAAEEEESSSSAAAARRRR____NNNN;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____PPPPOOOOIIIINNNNTTTTEEEERRRR CCCCAAAAEEEESSSSAAAARRRR____BBBB;;;;
        {{{{ ............ }}}}

     This procedure simulates, for the subcache of index CCCCAAAAEEEESSSSAAAARRRR____NNNN
     of the cache pointed to by CCCCAAAAEEEESSSSAAAARRRR____CCCC, a hit at the item whose
     base field is pointed to by CCCCAAAAEEEESSSSAAAARRRR____BBBB.

     The current global date of the cache is incremented and  the
     current  local date of the subcache of index CCCCAAAAEEEESSSSAAAARRRR____NNNN is set
     to the current global date of the cache.  The  date  of  the
     last access to the item pointed to by CCCCAAAAEEEESSSSAAAARRRR____BBBB is set to the
     current global date of the cache (the item becomes the  most
     recently  accessed item in the cache). The number of hits at
     the item is incremented. Finally, the  subcache  is  updated
     depending  whether  the  item  has become smaller or greater
     according to the order relation underlying  the  replacement
     strategy associated to the subcache.

     If no item stored in the subcache of index CCCCAAAAEEEESSSSAAAARRRR____NNNN  of  the
     cache  has  a  base field at address CCCCAAAAEEEESSSSAAAARRRR____BBBB, the effect is
     undefined.

     If the subcache index CCCCAAAAEEEESSSSAAAARRRR____NNNN is outside the  range  0..N-1
     (where  N  is  the  number  of  subcaches in the cache), the
     effect is undefined.

     Note: If the items of the cache contain mark fields, and  if



(C) INRIA     Last change: 2020/02/11 (version 1.2)            31






OPEN/CAESAR MANUAL                          caesar_cache_1(LOCAL)



     the  subcache  is  equipped  with a user-defined replacement
     strategy whose underlying order relation depends on the con-
     tents  of mark fields, this procedure should be called after
     any modification of the mark field of an item  of  the  sub-
     cache in order to bring the subcache to a consistent state.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____CCCCUUUURRRRRRRREEEENNNNTTTT____DDDDAAAATTTTEEEE____SSSSUUUUBBBBCCCCAAAACCCCHHHHEEEE____CCCCAAAACCCCHHHHEEEE____1111

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL CCCCAAAAEEEESSSSAAAARRRR____CCCCUUUURRRRRRRREEEENNNNTTTT____DDDDAAAATTTTEEEE____SSSSUUUUBBBBCCCCAAAACCCCHHHHEEEE____CCCCAAAACCCCHHHHEEEE____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____CCCC,,,, CCCCAAAAEEEESSSSAAAARRRR____NNNN))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____CCCCAAAACCCCHHHHEEEE____1111 CCCCAAAAEEEESSSSAAAARRRR____CCCC;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL CCCCAAAAEEEESSSSAAAARRRR____NNNN;;;;
        {{{{ ............ }}}}

     This function returns the date of the last modifying  opera-
     tion  performed  on an item present in the subcache of index
     CCCCAAAAEEEESSSSAAAARRRR____NNNN of the cache pointed to by CCCCAAAAEEEESSSSAAAARRRR____CCCC.

     If the subcache index CCCCAAAAEEEESSSSAAAARRRR____NNNN is outside the  range  0..N-1
     (where  N  is  the  number  of  subcaches in the cache), the
     result is undefined.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____CCCCUUUURRRRRRRREEEENNNNTTTT____DDDDAAAATTTTEEEE____CCCCAAAACCCCHHHHEEEE____1111

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL CCCCAAAAEEEESSSSAAAARRRR____CCCCUUUURRRRRRRREEEENNNNTTTT____DDDDAAAATTTTEEEE____CCCCAAAACCCCHHHHEEEE____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____CCCC))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____CCCCAAAACCCCHHHHEEEE____1111 CCCCAAAAEEEESSSSAAAARRRR____CCCC;;;;
        {{{{ ............ }}}}

     This function returns the current global date of  the  cache
     pointed to by CCCCAAAAEEEESSSSAAAARRRR____CCCC.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____NNNNUUUUMMMMBBBBEEEERRRR____OOOOFFFF____IIIITTTTEEEEMMMMSSSS____SSSSUUUUBBBBCCCCAAAACCCCHHHHEEEE____CCCCAAAACCCCHHHHEEEE____1111

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL CCCCAAAAEEEESSSSAAAARRRR____NNNNUUUUMMMMBBBBEEEERRRR____OOOOFFFF____IIIITTTTEEEEMMMMSSSS____SSSSUUUUBBBBCCCCAAAACCCCHHHHEEEE____CCCCAAAACCCCHHHHEEEE____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____CCCC,,,, CCCCAAAAEEEESSSSAAAARRRR____NNNN))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____CCCCAAAACCCCHHHHEEEE____1111 CCCCAAAAEEEESSSSAAAARRRR____CCCC;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL CCCCAAAAEEEESSSSAAAARRRR____NNNN;;;;
        {{{{ ............ }}}}

     This function returns the number  of  items  currently  con-
     tained  in  the  subcache  of  index  CCCCAAAAEEEESSSSAAAARRRR____NNNN  of the cache
     pointed to by CCCCAAAAEEEESSSSAAAARRRR____CCCC.

     If the subcache index CCCCAAAAEEEESSSSAAAARRRR____NNNN is outside the  range  0..N-1
     (where  N  is  the  number  of  subcaches in the cache), the



(C) INRIA     Last change: 2020/02/11 (version 1.2)            32






OPEN/CAESAR MANUAL                          caesar_cache_1(LOCAL)



     result is undefined.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____NNNNUUUUMMMMBBBBEEEERRRR____OOOOFFFF____IIIITTTTEEEEMMMMSSSS____CCCCAAAACCCCHHHHEEEE____1111

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL CCCCAAAAEEEESSSSAAAARRRR____NNNNUUUUMMMMBBBBEEEERRRR____OOOOFFFF____IIIITTTTEEEEMMMMSSSS____CCCCAAAACCCCHHHHEEEE____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____CCCC))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____CCCCAAAACCCCHHHHEEEE____1111 CCCCAAAAEEEESSSSAAAARRRR____CCCC;;;;
        {{{{ ............ }}}}

     This function returns the number  of  items  currently  con-
     tained in the cache pointed to by CCCCAAAAEEEESSSSAAAARRRR____CCCC.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____NNNNUUUUMMMMBBBBEEEERRRR____OOOOFFFF____SSSSEEEEAAAARRRRCCCCHHHHEEEESSSS____CCCCAAAACCCCHHHHEEEE____1111

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL CCCCAAAAEEEESSSSAAAARRRR____NNNNUUUUMMMMBBBBEEEERRRR____OOOOFFFF____SSSSEEEEAAAARRRRCCCCHHHHEEEESSSS____CCCCAAAACCCCHHHHEEEE____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____CCCC))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____CCCCAAAACCCCHHHHEEEE____1111 CCCCAAAAEEEESSSSAAAARRRR____CCCC;;;;
        {{{{ ............ }}}}

     This function returns the number of search  operations  per-
     formed on the cache pointed to by CCCCAAAAEEEESSSSAAAARRRR____CCCC.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____NNNNUUUUMMMMBBBBEEEERRRR____OOOOFFFF____HHHHIIIITTTTSSSS____SSSSUUUUBBBBCCCCAAAACCCCHHHHEEEE____CCCCAAAACCCCHHHHEEEE____1111

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL CCCCAAAAEEEESSSSAAAARRRR____NNNNUUUUMMMMBBBBEEEERRRR____OOOOFFFF____HHHHIIIITTTTSSSS____SSSSUUUUBBBBCCCCAAAACCCCHHHHEEEE____CCCCAAAACCCCHHHHEEEE____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____CCCC,,,, CCCCAAAAEEEESSSSAAAARRRR____NNNN))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____CCCCAAAACCCCHHHHEEEE____1111 CCCCAAAAEEEESSSSAAAARRRR____CCCC;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL CCCCAAAAEEEESSSSAAAARRRR____NNNN;;;;
        {{{{ ............ }}}}

     This function returns the number of hits at the subcache  of
     index CCCCAAAAEEEESSSSAAAARRRR____NNNN of the cache pointed to by CCCCAAAAEEEESSSSAAAARRRR____CCCC.

     If the subcache index CCCCAAAAEEEESSSSAAAARRRR____NNNN is outside the  range  0..N-1
     (where  N  is  the  number  of  subcaches in the cache), the
     result is undefined.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____NNNNUUUUMMMMBBBBEEEERRRR____OOOOFFFF____HHHHIIIITTTTSSSS____CCCCAAAACCCCHHHHEEEE____1111

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL CCCCAAAAEEEESSSSAAAARRRR____NNNNUUUUMMMMBBBBEEEERRRR____OOOOFFFF____HHHHIIIITTTTSSSS____CCCCAAAACCCCHHHHEEEE____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____CCCC))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____CCCCAAAACCCCHHHHEEEE____1111 CCCCAAAAEEEESSSSAAAARRRR____CCCC;;;;
        {{{{ ............ }}}}




(C) INRIA     Last change: 2020/02/11 (version 1.2)            33






OPEN/CAESAR MANUAL                          caesar_cache_1(LOCAL)



     This function returns  the  number  of  hits  at  the  cache
     pointed to by CCCCAAAAEEEESSSSAAAARRRR____CCCC.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____IIIITTTTEEEEMMMM____PPPPUUUUTTTT____DDDDAAAATTTTEEEE____CCCCAAAACCCCHHHHEEEE____1111

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL CCCCAAAAEEEESSSSAAAARRRR____IIIITTTTEEEEMMMM____PPPPUUUUTTTT____DDDDAAAATTTTEEEE____CCCCAAAACCCCHHHHEEEE____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____CCCC,,,, CCCCAAAAEEEESSSSAAAARRRR____BBBB))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____CCCCAAAACCCCHHHHEEEE____1111 CCCCAAAAEEEESSSSAAAARRRR____CCCC;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____PPPPOOOOIIIINNNNTTTTEEEERRRR CCCCAAAAEEEESSSSAAAARRRR____BBBB;;;;
        {{{{ ............ }}}}

     This function returns the date  when  the  item  whose  base
     field  is  pointed  to  by  CCCCAAAAEEEESSSSAAAARRRR____BBBB  was put into the cache
     pointed to by CCCCAAAAEEEESSSSAAAARRRR____CCCC.

     If no item stored in (some subcache of) the cache has a base
     field at address CCCCAAAAEEEESSSSAAAARRRR____BBBB, the result is undefined.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____IIIITTTTEEEEMMMM____CCCCUUUURRRRRRRREEEENNNNTTTT____DDDDAAAATTTTEEEE____CCCCAAAACCCCHHHHEEEE____1111

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL CCCCAAAAEEEESSSSAAAARRRR____IIIITTTTEEEEMMMM____CCCCUUUURRRRRRRREEEENNNNTTTT____DDDDAAAATTTTEEEE____CCCCAAAACCCCHHHHEEEE____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____CCCC,,,, CCCCAAAAEEEESSSSAAAARRRR____BBBB))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____CCCCAAAACCCCHHHHEEEE____1111 CCCCAAAAEEEESSSSAAAARRRR____CCCC;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____PPPPOOOOIIIINNNNTTTTEEEERRRR CCCCAAAAEEEESSSSAAAARRRR____BBBB;;;;
        {{{{ ............ }}}}

     This function returns, for the cache pointed to by CCCCAAAAEEEESSSSAAAARRRR____CCCC,
     the  date of the last access to the item whose base field is
     pointed to by CCCCAAAAEEEESSSSAAAARRRR____BBBB.

     If no item stored in (some subcache of) the cache has a base
     field at address CCCCAAAAEEEESSSSAAAARRRR____BBBB, the result is undefined.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____IIIITTTTEEEEMMMM____NNNNUUUUMMMMBBBBEEEERRRR____OOOOFFFF____HHHHIIIITTTTSSSS____CCCCAAAACCCCHHHHEEEE____1111

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL CCCCAAAAEEEESSSSAAAARRRR____IIIITTTTEEEEMMMM____NNNNUUUUMMMMBBBBEEEERRRR____OOOOFFFF____HHHHIIIITTTTSSSS____CCCCAAAACCCCHHHHEEEE____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____CCCC,,,, CCCCAAAAEEEESSSSAAAARRRR____BBBB))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____CCCCAAAACCCCHHHHEEEE____1111 CCCCAAAAEEEESSSSAAAARRRR____CCCC;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____PPPPOOOOIIIINNNNTTTTEEEERRRR CCCCAAAAEEEESSSSAAAARRRR____BBBB;;;;
        {{{{ ............ }}}}

     This function returns, for the cache pointed to by CCCCAAAAEEEESSSSAAAARRRR____CCCC,
     the  number  of hits at the item whose base field is pointed
     to by CCCCAAAAEEEESSSSAAAARRRR____BBBB.

     If no item stored in (some subcache of) the cache has a base



(C) INRIA     Last change: 2020/02/11 (version 1.2)            34






OPEN/CAESAR MANUAL                          caesar_cache_1(LOCAL)



     field at address CCCCAAAAEEEESSSSAAAARRRR____BBBB, the result is undefined.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____EEEEMMMMPPPPTTTTYYYY____SSSSUUUUBBBBCCCCAAAACCCCHHHHEEEE____CCCCAAAACCCCHHHHEEEE____1111

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____BBBBOOOOOOOOLLLLEEEEAAAANNNN CCCCAAAAEEEESSSSAAAARRRR____EEEEMMMMPPPPTTTTYYYY____SSSSUUUUBBBBCCCCAAAACCCCHHHHEEEE____CCCCAAAACCCCHHHHEEEE____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____CCCC,,,, CCCCAAAAEEEESSSSAAAARRRR____NNNN))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____CCCCAAAACCCCHHHHEEEE____1111 CCCCAAAAEEEESSSSAAAARRRR____CCCC;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL CCCCAAAAEEEESSSSAAAARRRR____NNNN;;;;
        {{{{ ............ }}}}

     This function returns a value different from 0 if  the  sub-
     cache  of index CCCCAAAAEEEESSSSAAAARRRR____NNNN of the cache pointed to by CCCCAAAAEEEESSSSAAAARRRR____CCCC
     is empty,  and  0  otherwise.  CCCCAAAAEEEESSSSAAAARRRR____EEEEMMMMPPPPTTTTYYYY____SSSSUUUUBBBBCCCCAAAACCCCHHHHEEEE____CCCCAAAACCCCHHHHEEEE____1111
     ((((CCCCAAAAEEEESSSSAAAARRRR____CCCC,,,, CCCCAAAAEEEESSSSAAAARRRR____NNNN)))) is always equivalent to:

  CCCCAAAAEEEESSSSAAAARRRR____NNNNUUUUMMMMBBBBEEEERRRR____OOOOFFFF____IIIITTTTEEEEMMMMSSSS____SSSSUUUUBBBBCCCCAAAACCCCHHHHEEEE____CCCCAAAACCCCHHHHEEEE____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____CCCC,,,, CCCCAAAAEEEESSSSAAAARRRR____NNNN)))) ======== 0000


     If the subcache index CCCCAAAAEEEESSSSAAAARRRR____NNNN is outside the  range  0..N-1
     (where  N  is  the  number  of  subcaches in the cache), the
     result is undefined.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____EEEEMMMMPPPPTTTTYYYY____CCCCAAAACCCCHHHHEEEE____1111

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____BBBBOOOOOOOOLLLLEEEEAAAANNNN CCCCAAAAEEEESSSSAAAARRRR____EEEEMMMMPPPPTTTTYYYY____CCCCAAAACCCCHHHHEEEE____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____CCCC))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____CCCCAAAACCCCHHHHEEEE____1111 CCCCAAAAEEEESSSSAAAARRRR____CCCC;;;;
        {{{{ ............ }}}}

     This function returns a value different from 0 if the  cache
     pointed   to   by   CCCCAAAAEEEESSSSAAAARRRR____CCCC  is  empty,  and  0  otherwise.
     CCCCAAAAEEEESSSSAAAARRRR____EEEEMMMMPPPPTTTTYYYY____CCCCAAAACCCCHHHHEEEE____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____CCCC)))) is always equivalent to:

            CCCCAAAAEEEESSSSAAAARRRR____NNNNUUUUMMMMBBBBEEEERRRR____OOOOFFFF____IIIITTTTEEEEMMMMSSSS____CCCCAAAACCCCHHHHEEEE____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____CCCC)))) ======== 0000



      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____FFFFUUUULLLLLLLL____SSSSUUUUBBBBCCCCAAAACCCCHHHHEEEE____CCCCAAAACCCCHHHHEEEE____1111

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____BBBBOOOOOOOOLLLLEEEEAAAANNNN CCCCAAAAEEEESSSSAAAARRRR____FFFFUUUULLLLLLLL____SSSSUUUUBBBBCCCCAAAACCCCHHHHEEEE____CCCCAAAACCCCHHHHEEEE____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____CCCC,,,, CCCCAAAAEEEESSSSAAAARRRR____NNNN))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____CCCCAAAACCCCHHHHEEEE____1111 CCCCAAAAEEEESSSSAAAARRRR____CCCC;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL CCCCAAAAEEEESSSSAAAARRRR____NNNN;;;;
        {{{{ ............ }}}}

     This function returns a value different from 0 if  the  sub-
     cache  of index CCCCAAAAEEEESSSSAAAARRRR____NNNN of the cache pointed to by CCCCAAAAEEEESSSSAAAARRRR____CCCC



(C) INRIA     Last change: 2020/02/11 (version 1.2)            35






OPEN/CAESAR MANUAL                          caesar_cache_1(LOCAL)



     is  full,  and  0  otherwise.   CCCCAAAAEEEESSSSAAAARRRR____FFFFUUUULLLLLLLL____SSSSUUUUBBBBCCCCAAAACCCCHHHHEEEE____CCCCAAAACCCCHHHHEEEE____1111
     ((((CCCCAAAAEEEESSSSAAAARRRR____CCCC,,,, CCCCAAAAEEEESSSSAAAARRRR____NNNN)))) is always equivalent to:

 CCCCAAAAEEEESSSSAAAARRRR____NNNNUUUUMMMMBBBBEEEERRRR____OOOOFFFF____IIIITTTTEEEEMMMMSSSS____SSSSUUUUBBBBCCCCAAAACCCCHHHHEEEE____CCCCAAAACCCCHHHHEEEE____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____CCCC,,,, CCCCAAAAEEEESSSSAAAARRRR____NNNN)))) ======== $$$$KKKK$$$$

     where K denotes the maximum number of items  that  the  sub-
     cache can contain.

     If the subcache index CCCCAAAAEEEESSSSAAAARRRR____NNNN is outside the  range  0..N-1
     (where  N  is  the  number  of  subcaches in the cache), the
     result is undefined.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____FFFFUUUULLLLLLLL____CCCCAAAACCCCHHHHEEEE____1111

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____BBBBOOOOOOOOLLLLEEEEAAAANNNN CCCCAAAAEEEESSSSAAAARRRR____FFFFUUUULLLLLLLL____CCCCAAAACCCCHHHHEEEE____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____CCCC))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____CCCCAAAACCCCHHHHEEEE____1111 CCCCAAAAEEEESSSSAAAARRRR____CCCC;;;;
        {{{{ ............ }}}}

     This function returns a value different from 0 if the  cache
     pointed   to   by   CCCCAAAAEEEESSSSAAAARRRR____CCCC   is  full,  and  0  otherwise.
     CCCCAAAAEEEESSSSAAAARRRR____FFFFUUUULLLLLLLL____CCCCAAAACCCCHHHHEEEE____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____CCCC)))) is always equivalent to:

           CCCCAAAAEEEESSSSAAAARRRR____NNNNUUUUMMMMBBBBEEEERRRR____OOOOFFFF____IIIITTTTEEEEMMMMSSSS____CCCCAAAACCCCHHHHEEEE____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____CCCC)))) ======== $$$$KKKK$$$$

     where K denotes the maximum number of items that  the  cache
     can contain.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____IIIINNNNFFFFOOOO____CCCCAAAACCCCHHHHEEEE____1111

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____PPPPOOOOIIIINNNNTTTTEEEERRRR CCCCAAAAEEEESSSSAAAARRRR____IIIINNNNFFFFOOOO____CCCCAAAACCCCHHHHEEEE____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____CCCC))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____CCCCAAAACCCCHHHHEEEE____1111 CCCCAAAAEEEESSSSAAAARRRR____CCCC;;;;
        {{{{ ............ }}}}

     This function returns the pointer to  the  user  information
     associated  to  the  cache  pointed to by CCCCAAAAEEEESSSSAAAARRRR____CCCC when this
     cache was created using CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTEEEE____CCCCAAAACCCCHHHHEEEE____1111(((()))).  Precisely,
     the  result  returned  by  this function is the value of the
     formal  parameter  CCCCAAAAEEEESSSSAAAARRRR____IIIINNNNFFFFOOOO  supplied  at  the  call   to
     CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTEEEE____CCCCAAAACCCCHHHHEEEE____1111(((()))).


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____RRRREEEETTTTRRRRIIIIEEEEVVVVEEEE____BBBB____MMMM____CCCCAAAACCCCHHHHEEEE____1111

     vvvvooooiiiidddd CCCCAAAAEEEESSSSAAAARRRR____RRRREEEETTTTRRRRIIIIEEEEVVVVEEEE____BBBB____MMMM____CCCCAAAACCCCHHHHEEEE____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____CCCC,,,, CCCCAAAAEEEESSSSAAAARRRR____BBBB,,,, CCCCAAAAEEEESSSSAAAARRRR____MMMM))))



(C) INRIA     Last change: 2020/02/11 (version 1.2)            36






OPEN/CAESAR MANUAL                          caesar_cache_1(LOCAL)



        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____CCCCAAAACCCCHHHHEEEE____1111 CCCCAAAAEEEESSSSAAAARRRR____CCCC;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____PPPPOOOOIIIINNNNTTTTEEEERRRR CCCCAAAAEEEESSSSAAAARRRR____BBBB;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____PPPPOOOOIIIINNNNTTTTEEEERRRR ****CCCCAAAAEEEESSSSAAAARRRR____MMMM;;;;
        {{{{ ............ }}}}

     This  procedure  computes,  for  the  cache  pointed  to  by
     CCCCAAAAEEEESSSSAAAARRRR____CCCC,  the  address  of the mark field of the item whose
     base field is  pointed  to  by  CCCCAAAAEEEESSSSAAAARRRR____BBBB.  This  address  is
     assigned to ****CCCCAAAAEEEESSSSAAAARRRR____MMMM.

     If no item stored in (some subcache of) the cache has a base
     field at address CCCCAAAAEEEESSSSAAAARRRR____BBBB, the effect is undefined.

     If there are no mark fields in the cache (due  to  the  ini-
     tialization parameters supplied to CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTEEEE____CCCCAAAACCCCHHHHEEEE____1111(((())))),
     the effect is undefined.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____RRRREEEETTTTRRRRIIIIEEEEVVVVEEEE____MMMM____BBBB____CCCCAAAACCCCHHHHEEEE____1111

     vvvvooooiiiidddd CCCCAAAAEEEESSSSAAAARRRR____RRRREEEETTTTRRRRIIIIEEEEVVVVEEEE____MMMM____BBBB____CCCCAAAACCCCHHHHEEEE____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____CCCC,,,, CCCCAAAAEEEESSSSAAAARRRR____MMMM,,,, CCCCAAAAEEEESSSSAAAARRRR____BBBB))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____CCCCAAAACCCCHHHHEEEE____1111 CCCCAAAAEEEESSSSAAAARRRR____CCCC;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____PPPPOOOOIIIINNNNTTTTEEEERRRR CCCCAAAAEEEESSSSAAAARRRR____MMMM;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____PPPPOOOOIIIINNNNTTTTEEEERRRR ****CCCCAAAAEEEESSSSAAAARRRR____BBBB;;;;
        {{{{ ............ }}}}

     This  procedure  computes,  for  the  cache  pointed  to  by
     CCCCAAAAEEEESSSSAAAARRRR____CCCC,  the  address  of the base field of the item whose
     mark field is  pointed  to  by  CCCCAAAAEEEESSSSAAAARRRR____MMMM.  This  address  is
     assigned to ****CCCCAAAAEEEESSSSAAAARRRR____BBBB.

     If no item stored in (some subcache of) the cache has a mark
     field at address CCCCAAAAEEEESSSSAAAARRRR____MMMM, the effect is undefined.

     If there are no mark fields in the cache (due  to  the  ini-
     tialization parameters supplied to CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTEEEE____CCCCAAAACCCCHHHHEEEE____1111(((())))),
     the effect is undefined.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____FFFFOOOORRRRMMMMAAAATTTT____CCCCAAAACCCCHHHHEEEE____1111

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____FFFFOOOORRRRMMMMAAAATTTT CCCCAAAAEEEESSSSAAAARRRR____FFFFOOOORRRRMMMMAAAATTTT____CCCCAAAACCCCHHHHEEEE____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____CCCC,,,, CCCCAAAAEEEESSSSAAAARRRR____FFFFOOOORRRRMMMMAAAATTTT))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____CCCCAAAACCCCHHHHEEEE____1111 CCCCAAAAEEEESSSSAAAARRRR____CCCC;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____FFFFOOOORRRRMMMMAAAATTTT CCCCAAAAEEEESSSSAAAARRRR____FFFFOOOORRRRMMMMAAAATTTT;;;;
        {{{{ ............ }}}}

     This function allows to control the format under  which  the
     cache  pointed  to  by  CCCCAAAAEEEESSSSAAAARRRR____CCCC  will  be  printed  by  the



(C) INRIA     Last change: 2020/02/11 (version 1.2)            37






OPEN/CAESAR MANUAL                          caesar_cache_1(LOCAL)



     procedure CCCCAAAAEEEESSSSAAAARRRR____PPPPRRRRIIIINNNNTTTT____CCCCAAAACCCCHHHHEEEE____1111(((()))) (see below). Currently, the
     following formats are available:


     -    With format 0, statistical information  concerning  the
          cache  is  displayed  such as: the number of items, the
          replacement strategy and the number of  hits  for  each
          subcache of the cache, the total number of searches and
          hits for the whole cache, etc.

     -    (no other format available yet)

     By default, the current format of each cache is  initialized
     to 0.

     When called with CCCCAAAAEEEESSSSAAAARRRR____FFFFOOOORRRRMMMMAAAATTTT between 0 and 0,  this  fonc-
     tion  sets  the  current format of CCCCAAAAEEEESSSSAAAARRRR____CCCC to CCCCAAAAEEEESSSSAAAARRRR____FFFFOOOORRRRMMMMAAAATTTT
     and returns an undefined result.

     When called with another value of CCCCAAAAEEEESSSSAAAARRRR____FFFFOOOORRRRMMMMAAAATTTT, this  func-
     tion  does  not  modify  the  current format of CCCCAAAAEEEESSSSAAAARRRR____CCCC but
     returns a result defined as  follows.  If  CCCCAAAAEEEESSSSAAAARRRR____FFFFOOOORRRRMMMMAAAATTTT  is
     equal  to  the constant CCCCAAAAEEEESSSSAAAARRRR____CCCCUUUURRRRRRRREEEENNNNTTTT____FFFFOOOORRRRMMMMAAAATTTT, the result is
     the  value  of  the   current   format   of   CCCCAAAAEEEESSSSAAAARRRR____CCCC.   If
     CCCCAAAAEEEESSSSAAAARRRR____FFFFOOOORRRRMMMMAAAATTTT      is      equal     to     the     constant
     CCCCAAAAEEEESSSSAAAARRRR____MMMMAAAAXXXXIIIIMMMMAAAALLLL____FFFFOOOORRRRMMMMAAAATTTT, the  result  is  the  maximal  format
     value  (i.e.,  0).  In  all  other cases, the effect of this
     function is undefined.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____MMMMAAAAXXXX____FFFFOOOORRRRMMMMAAAATTTT____CCCCAAAACCCCHHHHEEEE____1111

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____FFFFOOOORRRRMMMMAAAATTTT CCCCAAAAEEEESSSSAAAARRRR____MMMMAAAAXXXX____FFFFOOOORRRRMMMMAAAATTTT____CCCCAAAACCCCHHHHEEEE____1111 (((())))
        {{{{ ............ }}}}

     Caution! This function is deprecated. It should no longer be
     used,  as  it  might  be removed from future versions of the
     _O_P_E_N/_C_A_E_S_A_R. Use function  CCCCAAAAEEEESSSSAAAARRRR____FFFFOOOORRRRMMMMAAAATTTT____CCCCAAAACCCCHHHHEEEE____1111(((())))  instead,
     called with argument CCCCAAAAEEEESSSSAAAARRRR____MMMMAAAAXXXXIIIIMMMMAAAALLLL____FFFFOOOORRRRMMMMAAAATTTT.

     This function returns the maximal format value available for
     printing caches.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____PPPPRRRRIIIINNNNTTTT____CCCCAAAACCCCHHHHEEEE____1111

     vvvvooooiiiidddd CCCCAAAAEEEESSSSAAAARRRR____PPPPRRRRIIIINNNNTTTT____CCCCAAAACCCCHHHHEEEE____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____FFFFIIIILLLLEEEE,,,, CCCCAAAAEEEESSSSAAAARRRR____CCCC))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____FFFFIIIILLLLEEEE CCCCAAAAEEEESSSSAAAARRRR____FFFFIIIILLLLEEEE;;;;



(C) INRIA     Last change: 2020/02/11 (version 1.2)            38






OPEN/CAESAR MANUAL                          caesar_cache_1(LOCAL)



        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____CCCCAAAACCCCHHHHEEEE____1111 CCCCAAAAEEEESSSSAAAARRRR____CCCC;;;;
        {{{{ ............ }}}}

     This procedure prints on file CCCCAAAAEEEESSSSAAAARRRR____FFFFIIIILLLLEEEE an ASCII text con-
     taining  various  informations about the cache pointed to by
     CCCCAAAAEEEESSSSAAAARRRR____CCCC. The nature of these informations is determined  by
     the current format of the cache pointed to by CCCCAAAAEEEESSSSAAAARRRR____CCCC.

     Before this procedure is called, CCCCAAAAEEEESSSSAAAARRRR____FFFFIIIILLLLEEEE must have  been
     properly opened, for instance using ffffooooppppeeeennnn((((3333)))).


      ............................................................

AAAAUUUUTTTTHHHHOOOORRRR((((SSSS))))
     Radu Mateescu

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











(C) INRIA     Last change: 2020/02/11 (version 1.2)            39



