


OPEN/CAESAR MANUAL                           caesar_mask_1(LOCAL)



NNNNAAAAMMMMEEEE
     caesar_mask_1 - the ``mask_1'' library of OPEN/CAESAR

PPPPUUUURRRRPPPPOOOOSSSSEEEE
     The ``mask_1''  library  provides  primitives  for  applying
     sequences  of hiding and renaming operations to memory areas
     (such as labels) converted to character strings. In particu-
     lar, this allows to hide and/or rename labels on the fly.



UUUUSSSSAAAAGGGGEEEE
     The ``mask_1'' library consists of:

     -    a predefined header file ccccaaaaeeeessssaaaarrrr____mmmmaaaasssskkkk____1111....hhhh;

     -    the precompiled library file lllliiiibbbbccccaaaaeeeessssaaaarrrr....aaaa, which  imple-
          ments the features described in ccccaaaaeeeessssaaaarrrr____mmmmaaaasssskkkk____1111....hhhh.

     Note: The ``mask_1'' library is a software layer built above
     the  primitives  offered  by  the  ``standard'', ``area_1'',
     ``hide_1'', and ``rename_1'' libraries.



DDDDEEEESSSSCCCCRRRRIIIIPPPPTTTTIIIIOOOONNNN
     The ``mask_1'' library allows to apply successive operations
     to  memory  areas  (for  instance, labels). These operations
     are, first, the conversion of a memory area to  a  character
     string, and then a sequence of hiding and/or renaming opera-
     tions on the resulting character string.

     Hiding a character string consists in renaming it  into  the
     internal  action  ``i''  (or  tau)  according  to a ``hiding
     file'', which contains a list of  regular  expressions.  The
     format  of  ``hiding  files''  is  defined in the ``hide_1''
     library.

     Renaming consists in applying string substitutions according
     to  a  ``renaming file'', which contains a list of substitu-
     tion patterns defined using regular expressions. The  format
     of   ``renaming  files''  is  defined  in  the  ``rename_1''
     library.

     The ``mask_1'' library targets at  efficiency.  Each  hiding
     file and each renaming file is parsed and checked only once.
     In addition, a hash-based cache table is available to  speed
     up  performance;  this  table  stores  the character strings
     resulting from prior operations  performed  by  the  masking
     object, so as to avoid multiple, redundant computations.

     The ``mask_1'' library introduces the concept  of  ``masking



(C) INRIA     Last change: 2020/02/11 (version 1.1)             1






OPEN/CAESAR MANUAL                           caesar_mask_1(LOCAL)



     object'',  which  is  an  abstract data structure containing
     (among others) the following information:

     -    a description of the  memory  areas  to  be  processed,
          including  their  size, hash size, comparison function,
          hashing function,  conversion  function,  and  printing
          procedure;

     -    a (possibly empty) ordered list of hiding and  renaming
          operations  to  be  applied  sequentially;  hiding  and
          renaming operations can be intertwined arbitrarily;

     -    an (optional) hash-based cache table and  (if  applica-
          ble) statistical data about caching efficiency.

FFFFEEEEAAAATTTTUUUURRRREEEESSSS
      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____MMMMAAAASSSSKKKK____1111

     ttttyyyyppppeeeeddddeeeeffff CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____AAAABBBBSSSSTTTTRRRRAAAACCCCTTTT ((((............)))) CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____MMMMAAAASSSSKKKK____1111;;;;

     This type denotes a pointer to the  concrete  representation
     of a masking object, which is supposed to be ``opaque''.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTEEEE____MMMMAAAASSSSKKKK____1111

     vvvvooooiiiidddd CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTEEEE____MMMMAAAASSSSKKKK____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____MMMM,,,, CCCCAAAAEEEESSSSAAAARRRR____AAAARRRREEEEAAAA,,,, CCCCAAAAEEEESSSSAAAARRRR____CCCCAAAACCCCHHHHEEEE,,,,
                                CCCCAAAAEEEESSSSAAAARRRR____CCCCAAAACCCCHHHHEEEE____SSSSIIIIZZZZEEEE,,,, CCCCAAAAEEEESSSSAAAARRRR____PPPPRRRRIIIIMMMMEEEE,,,, CCCCAAAAEEEESSSSAAAARRRR____CCCCOOOOMMMMPPPPAAAARRRREEEE,,,,
                                CCCCAAAAEEEESSSSAAAARRRR____HHHHAAAASSSSHHHH,,,, CCCCAAAAEEEESSSSAAAARRRR____CCCCOOOONNNNVVVVEEEERRRRTTTT,,,, CCCCAAAAEEEESSSSAAAARRRR____HHHHIIIISSSSTTTTOOOORRRRYYYY))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____MMMMAAAASSSSKKKK____1111 ****CCCCAAAAEEEESSSSAAAARRRR____MMMM;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____AAAARRRREEEEAAAA____1111 CCCCAAAAEEEESSSSAAAARRRR____AAAARRRREEEEAAAA;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____BBBBOOOOOOOOLLLLEEEEAAAANNNN CCCCAAAAEEEESSSSAAAARRRR____CCCCAAAACCCCHHHHEEEE;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL CCCCAAAAEEEESSSSAAAARRRR____CCCCAAAACCCCHHHHEEEE____SSSSIIIIZZZZEEEE;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____BBBBOOOOOOOOLLLLEEEEAAAANNNN CCCCAAAAEEEESSSSAAAARRRR____PPPPRRRRIIIIMMMMEEEE;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____CCCCOOOOMMMMPPPPAAAARRRREEEE____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN CCCCAAAAEEEESSSSAAAARRRR____CCCCOOOOMMMMPPPPAAAARRRREEEE;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____HHHHAAAASSSSHHHH____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN CCCCAAAAEEEESSSSAAAARRRR____HHHHAAAASSSSHHHH;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____CCCCOOOONNNNVVVVEEEERRRRTTTT____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN CCCCAAAAEEEESSSSAAAARRRR____CCCCOOOONNNNVVVVEEEERRRRTTTT;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____BBBBOOOOOOOOLLLLEEEEAAAANNNN CCCCAAAAEEEESSSSAAAARRRR____HHHHIIIISSSSTTTTOOOORRRRYYYY;;;;
        {{{{ ............ }}}}

     This   procedure   allocates   a   masking   object    using
     CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTEEEE(((()))) and assigns its address to ****CCCCAAAAEEEESSSSAAAARRRR____MMMM. If the
     allocation fails or if any error occurs in  this  procedure,
     the NNNNUUUULLLLLLLL value is assigned to ****CCCCAAAAEEEESSSSAAAARRRR____MMMM.

     Note: because CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____MMMMAAAASSSSKKKK____1111  is  a  pointer  type,  any
     variable  CCCCAAAAEEEESSSSAAAARRRR____MMMM  of type CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____MMMMAAAASSSSKKKK____1111 must be allo-
     cated before used, for instance using:



(C) INRIA     Last change: 2020/02/11 (version 1.1)             2






OPEN/CAESAR MANUAL                           caesar_mask_1(LOCAL)




                CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTEEEE____MMMMAAAASSSSKKKK____1111 ((((&&&&CCCCAAAAEEEESSSSAAAARRRR____MMMM,,,, ............))));;;;


     The value of CCCCAAAAEEEESSSSAAAARRRR____AAAARRRREEEEAAAA specifies the kind of memory  areas
     that  can  be processed by the masking object to be created.
     All the memory areas handled using a  given  masking  object
     must  be  of the same kind and have the same size and align-
     ment.

     The (optional) hash-based cache table is enabled if and only
     if CCCCAAAAEEEESSSSAAAARRRR____CCCCAAAACCCCHHHHEEEE is equal to CCCCAAAAEEEESSSSAAAARRRR____TTTTRRRRUUUUEEEE.

     If the cache table is disabled,  the  four  next  parameters
     CCCCAAAAEEEESSSSAAAARRRR____CCCCAAAACCCCHHHHEEEE____SSSSIIIIZZZZEEEE,    CCCCAAAAEEEESSSSAAAARRRR____PPPPRRRRIIIIMMMMEEEE,    CCCCAAAAEEEESSSSAAAARRRR____CCCCOOOOMMMMPPPPAAAARRRREEEE,   and
     CCCCAAAAEEEESSSSAAAARRRR____HHHHAAAASSSSHHHH are unused and must be equal to 0, CCCCAAAAEEEESSSSAAAARRRR____FFFFAAAALLLLSSSSEEEE,
     NNNNUUUULLLLLLLL,  and NNNNUUUULLLLLLLL, respectively; otherwise, the effect of this
     procedure is undefined. In the sequel, we only consider  the
     case where the cache table is enabled.

     Note:  If   the   value   of   CCCCAAAAEEEESSSSAAAARRRR____AAAARRRREEEEAAAA   is   equal   to
     CCCCAAAAEEEESSSSAAAARRRR____SSSSTTTTRRRRIIIINNNNGGGG____AAAARRRREEEEAAAA____1111  (((()))), the character strings that will be
     stored in the masking object pointed to by ****CCCCAAAAEEEESSSSAAAARRRR____MMMM may  be
     of arbitrary length. If the cache table is enabled, the con-
     tents of these character strings should remain constant,  in
     the  sense that, after a character string is passed as argu-
     ment to the function  CCCCAAAAEEEESSSSAAAARRRR____AAAAPPPPPPPPLLLLYYYY____MMMMAAAASSSSKKKK____1111(((())))  defined  below,
     its  contents  should  no  longer  be modified (as the cache
     table stores only the string pointer,  but  not  the  string
     contents).

     The value of CCCCAAAAEEEESSSSAAAARRRR____CCCCAAAACCCCHHHHEEEE____SSSSIIIIZZZZEEEE determines the maximal number
     of  areas  that  can  be  stored simultaneously in the cache
     table, together with the  corresponding  characters  strings
     obtained  after applying conversion, hiding, and/or renaming
     operations.  Whenever a new area is inserted  in  the  cache
     table  and an existing area is already present with the same
     hash value as the new area, the new area  will  replace  the
     existing  area.   If the value of CCCCAAAAEEEESSSSAAAARRRR____CCCCAAAACCCCHHHHEEEE____SSSSIIIIZZZZEEEE is equal
     to zero, it is replaced with a default  value  greater  than
     zero.

     If the value of CCCCAAAAEEEESSSSAAAARRRR____PPPPRRRRIIIIMMMMEEEE is equal to CCCCAAAAEEEESSSSAAAARRRR____TTTTRRRRUUUUEEEE and  if
     the  value  of CCCCAAAAEEEESSSSAAAARRRR____CCCCAAAACCCCHHHHEEEE____SSSSIIIIZZZZEEEE is not a prime number, this
     value will be replaced by the nearest smaller  prime  number
     (since  some  hash  functions require prime modulus). Other-
     wise, the value of CCCCAAAAEEEESSSSAAAARRRR____CCCCAAAACCCCHHHHEEEE____SSSSIIIIZZZZEEEE will be kept unchanged.

     The actual value of the formal parameter CCCCAAAAEEEESSSSAAAARRRR____CCCCOOOOMMMMPPPPAAAARRRREEEE will
     be stored and associated to the masking object pointed to by
     ****CCCCAAAAEEEESSSSAAAARRRR____MMMM. It will be used as a comparison function when  it
     is necessary to decide whether two memory areas are equal or



(C) INRIA     Last change: 2020/02/11 (version 1.1)             3






OPEN/CAESAR MANUAL                           caesar_mask_1(LOCAL)



     not.  If the actual value of CCCCAAAAEEEESSSSAAAARRRR____CCCCOOOOMMMMPPPPAAAARRRREEEE is NNNNUUUULLLLLLLL, it  may
     be  replaced  by  a  non-NNNNUUUULLLLLLLL default value depending on the
     value of CCCCAAAAEEEESSSSAAAARRRR____AAAARRRREEEEAAAA and according to  the  rules  specified
     for  function  CCCCAAAAEEEESSSSAAAARRRR____UUUUSSSSEEEE____CCCCOOOOMMMMPPPPAAAARRRREEEE____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN____AAAARRRREEEEAAAA____1111(((())))  of  the
     ``area_1'' library.  In both  cases,  all  area  comparisons
     will be done using the CCCCAAAAEEEESSSSAAAARRRR____CCCCOOOOMMMMPPPPAAAARRRREEEE____AAAARRRREEEEAAAA____1111(((()))) macro defined
     in the ``area_1'' library.

     The actual value of the formal parameter CCCCAAAAEEEESSSSAAAARRRR____HHHHAAAASSSSHHHH will be
     stored  and  associated  to the masking object pointed to by
     ****CCCCAAAAEEEESSSSAAAARRRR____MMMM. It will be used as a hashing function when it  is
     necessary to compute a hash-value for a memory area.  If the
     actual value of CCCCAAAAEEEESSSSAAAARRRR____HHHHAAAASSSSHHHH is NNNNUUUULLLLLLLL, it may be replaced by a
     non-NNNNUUUULLLLLLLL default value depending on the value of CCCCAAAAEEEESSSSAAAARRRR____AAAARRRREEEEAAAA
     and  according  to  the   rules   specified   for   function
     CCCCAAAAEEEESSSSAAAARRRR____UUUUSSSSEEEE____HHHHAAAASSSSHHHH____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN____AAAARRRREEEEAAAA____1111(((()))) of the ``area_1'' library.
     In  both  cases,  area  hashing  will  be  done  using   the
     CCCCAAAAEEEESSSSAAAARRRR____HHHHAAAASSSSHHHH____AAAARRRREEEEAAAA____1111(((())))   macro   defined   in  the  ``area_1''
     library.

     The actual value of the formal parameter CCCCAAAAEEEESSSSAAAARRRR____CCCCOOOONNNNVVVVEEEERRRRTTTT will
     be stored and associated to the masking object pointed to by
     ****CCCCAAAAEEEESSSSAAAARRRR____MMMM. It will be used as a conversion function when  it
     is  necessary  to  translate  a memory area into a character
     string.  If the actual value of CCCCAAAAEEEESSSSAAAARRRR____CCCCOOOONNNNVVVVEEEERRRRTTTT is  NNNNUUUULLLLLLLL,  it
     may be replaced by a non-NNNNUUUULLLLLLLL default value depending on the
     value of CCCCAAAAEEEESSSSAAAARRRR____AAAARRRREEEEAAAA and according to  the  rules  specified
     for  function  CCCCAAAAEEEESSSSAAAARRRR____UUUUSSSSEEEE____CCCCOOOONNNNVVVVEEEERRRRTTTT____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN____AAAARRRREEEEAAAA____1111(((())))  of  the
     ``area_1'' library.  In both  cases,  all  area  conversions
     will be done using the CCCCAAAAEEEESSSSAAAARRRR____CCCCOOOONNNNVVVVEEEERRRRTTTT____AAAARRRREEEEAAAA____1111(((()))) macro defined
     in the ``area_1'' library.

     The value of the formal  parameter  CCCCAAAAEEEESSSSAAAARRRR____HHHHIIIISSSSTTTTOOOORRRRYYYY  must  be
     equal  to  CCCCAAAAEEEESSSSAAAARRRR____TTTTRRRRUUUUEEEE  if  the  user  wants  to  invoke the
     CCCCAAAAEEEESSSSAAAARRRR____HHHHIIIISSSSTTTTOOOORRRRYYYY____MMMMAAAASSSSKKKK____1111(((()))) function defined below.

     Note: the list of hiding and renaming operations  associated
     to  the masking object pointed to by ****CCCCAAAAEEEESSSSAAAARRRR____MMMM is not speci-
     fied at the time the masking object is  created  but  later,
     using              the             CCCCAAAAEEEESSSSAAAARRRR____UUUUSSSSEEEE____HHHHIIIIDDDDEEEE____MMMMAAAASSSSKKKK____1111(((()))),
     CCCCAAAAEEEESSSSAAAARRRR____UUUUSSSSEEEE____RRRREEEENNNNAAAAMMMMEEEE____MMMMAAAASSSSKKKK____1111(((()))), and CCCCAAAAEEEESSSSAAAARRRR____PPPPAAAARRRRSSSSEEEE____OOOOPPPPTTTTIIIIOOOONNNN____MMMMAAAASSSSKKKK____1111(((())))
     primitives defined below.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____DDDDEEEELLLLEEEETTTTEEEE____MMMMAAAASSSSKKKK____1111

     vvvvooooiiiidddd CCCCAAAAEEEESSSSAAAARRRR____DDDDEEEELLLLEEEETTTTEEEE____MMMMAAAASSSSKKKK____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____MMMM))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____MMMMAAAASSSSKKKK____1111 ****CCCCAAAAEEEESSSSAAAARRRR____MMMM;;;;
        {{{{ ............ }}}}




(C) INRIA     Last change: 2020/02/11 (version 1.1)             4






OPEN/CAESAR MANUAL                           caesar_mask_1(LOCAL)



     This procedure frees the memory space corresponding  to  the
     masking    object    pointed    to    by   ****CCCCAAAAEEEESSSSAAAARRRR____MMMM   using
     CCCCAAAAEEEESSSSAAAARRRR____DDDDEEEELLLLEEEETTTTEEEE(((()))). Afterwards, the NNNNUUUULLLLLLLL value is  assigned  to
     ****CCCCAAAAEEEESSSSAAAARRRR____MMMM.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____UUUUSSSSEEEE____HHHHIIIIDDDDEEEE____MMMMAAAASSSSKKKK____1111

     vvvvooooiiiidddd CCCCAAAAEEEESSSSAAAARRRR____UUUUSSSSEEEE____HHHHIIIIDDDDEEEE____MMMMAAAASSSSKKKK____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____MMMM,,,, CCCCAAAAEEEESSSSAAAARRRR____PPPPAAAATTTTHHHHNNNNAAAAMMMMEEEE,,,, CCCCAAAAEEEESSSSAAAARRRR____KKKKIIIINNNNDDDD,,,,
                                  CCCCAAAAEEEESSSSAAAARRRR____FFFFAAAAIIIILLLLEEEEDDDD))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____MMMMAAAASSSSKKKK____1111 CCCCAAAAEEEESSSSAAAARRRR____MMMM;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSTTTTRRRRIIIINNNNGGGG CCCCAAAAEEEESSSSAAAARRRR____PPPPAAAATTTTHHHHNNNNAAAAMMMMEEEE;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL CCCCAAAAEEEESSSSAAAARRRR____KKKKIIIINNNNDDDD;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____BBBBOOOOOOOOLLLLEEEEAAAANNNN ****CCCCAAAAEEEESSSSAAAARRRR____FFFFAAAAIIIILLLLEEEEDDDD;;;;
        {{{{ ............ }}}}

     This function adds a new hiding operation at the end of  the
     (initially  empty)  list  of  hiding and renaming operations
     associated to the masking object pointed to by CCCCAAAAEEEESSSSAAAARRRR____MMMM.

     The hiding operation is specified by the  actual  values  of
     the  formal  parameters CCCCAAAAEEEESSSSAAAARRRR____PPPPAAAATTTTHHHHNNNNAAAAMMMMEEEE and CCCCAAAAEEEESSSSAAAARRRR____KKKKIIIINNNNDDDD, the
     signification  of  which  is  the  same  as   for   function
     CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTEEEE____HHHHIIIIDDDDEEEE____1111(((()))) of the ``hide_1'' library.

     Note:      the      additional       formal       parameters
     CCCCAAAAEEEESSSSAAAARRRR____PPPPOOOOSSSSIIIITTTTIIIIVVVVEEEE____HHHHEEEEAAAADDDDEEEERRRR    and    CCCCAAAAEEEESSSSAAAARRRR____NNNNEEEEGGGGAAAATTTTIIIIVVVVEEEE____HHHHEEEEAAAADDDDEEEERRRR   of
     CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTEEEE____HHHHIIIIDDDDEEEE____1111(((())))    are    not    accessible     using
     CCCCAAAAEEEESSSSAAAARRRR____UUUUSSSSEEEE____HHHHIIIIDDDDEEEE____MMMMAAAASSSSKKKK____1111(((()))); their default values will be used,
     meaning that the hiding file referred to by  CCCCAAAAEEEESSSSAAAARRRR____PPPPAAAATTTTHHHHNNNNAAAAMMMMEEEE
     must  start  with  either hhhhiiiiddddeeee (positive header) or hhhhiiiiddddeeee aaaallllllll
     bbbbuuuutttt (negative header).

     If  the  call  to  CCCCAAAAEEEESSSSAAAARRRR____UUUUSSSSEEEE____HHHHIIIIDDDDEEEE____MMMMAAAASSSSKKKK____1111(((())))  fails,   (e.g.,
     because  the  hiding file is incorrect), the boolean pointed
     to by ****CCCCAAAAEEEESSSSAAAARRRR____FFFFAAAAIIIILLLLEEEEDDDD is set to  CCCCAAAAEEEESSSSAAAARRRR____TTTTRRRRUUUUEEEE,  and  an  error
     message  is  printed  to the standard output. Otherwise, the
     boolean  pointed  to  by  ****CCCCAAAAEEEESSSSAAAARRRR____FFFFAAAAIIIILLLLEEEEDDDD  it   is   set   to
     CCCCAAAAEEEESSSSAAAARRRR____FFFFAAAALLLLSSSSEEEE.

     If the cache table is enabled, its contents are erased after
     any  call  to CCCCAAAAEEEESSSSAAAARRRR____UUUUSSSSEEEE____HHHHIIIIDDDDEEEE____MMMMAAAASSSSKKKK____1111(((()))), since the results of
     previous hiding and/or renaming operations performed so  far
     can  no  longer  be  reused  after a new hiding operation is
     added.  This  allows  to   invoke   CCCCAAAAEEEESSSSAAAARRRR____UUUUSSSSEEEE____HHHHIIIIDDDDEEEE____MMMMAAAASSSSKKKK____1111(((())))
     safely,    even    after    a    call    to   the   function
     CCCCAAAAEEEESSSSAAAARRRR____AAAAPPPPPPPPLLLLYYYY____MMMMAAAASSSSKKKK____1111(((()))) defined below.






(C) INRIA     Last change: 2020/02/11 (version 1.1)             5






OPEN/CAESAR MANUAL                           caesar_mask_1(LOCAL)



      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____UUUUSSSSEEEE____RRRREEEENNNNAAAAMMMMEEEE____MMMMAAAASSSSKKKK____1111

     vvvvooooiiiidddd CCCCAAAAEEEESSSSAAAARRRR____UUUUSSSSEEEE____RRRREEEENNNNAAAAMMMMEEEE____MMMMAAAASSSSKKKK____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____MMMM,,,, CCCCAAAAEEEESSSSAAAARRRR____PPPPAAAATTTTHHHHNNNNAAAAMMMMEEEE,,,, CCCCAAAAEEEESSSSAAAARRRR____KKKKIIIINNNNDDDD,,,,
                                    CCCCAAAAEEEESSSSAAAARRRR____FFFFAAAAIIIILLLLEEEEDDDD))))
         CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____MMMMAAAASSSSKKKK____1111 CCCCAAAAEEEESSSSAAAARRRR____MMMM;;;;
         CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSTTTTRRRRIIIINNNNGGGG CCCCAAAAEEEESSSSAAAARRRR____PPPPAAAATTTTHHHHNNNNAAAAMMMMEEEE;;;;
         CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL CCCCAAAAEEEESSSSAAAARRRR____KKKKIIIINNNNDDDD;;;;
         CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____BBBBOOOOOOOOLLLLEEEEAAAANNNN ****CCCCAAAAEEEESSSSAAAARRRR____FFFFAAAAIIIILLLLEEEEDDDD;;;;
         {{{{ ............ }}}}

     This function adds a new renaming operation at  the  end  of
     the (initially empty) list of hiding and renaming operations
     associated to the masking object pointed to by CCCCAAAAEEEESSSSAAAARRRR____MMMM.

     The renaming operation is specified by the actual values  of
     the  formal  parameters CCCCAAAAEEEESSSSAAAARRRR____PPPPAAAATTTTHHHHNNNNAAAAMMMMEEEE and CCCCAAAAEEEESSSSAAAARRRR____KKKKIIIINNNNDDDD, the
     signification  of  which  is  the  same  as   for   function
     CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTEEEE____RRRREEEENNNNAAAAMMMMEEEE____1111(((()))) of the ``rename_1'' library.

     Note:  the  additional  formal  parameter  CCCCAAAAEEEESSSSAAAARRRR____HHHHEEEEAAAADDDDEEEERRRR  of
     CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTEEEE____RRRREEEENNNNAAAAMMMMEEEE____1111(((())))    is    not    accessible    using
     CCCCAAAAEEEESSSSAAAARRRR____UUUUSSSSEEEE____RRRREEEENNNNAAAAMMMMEEEE____MMMMAAAASSSSKKKK____1111(((()))); its default value will be  used,
     meaning    that   the   renaming   file   referred   to   by
     CCCCAAAAEEEESSSSAAAARRRR____PPPPAAAATTTTHHHHNNNNAAAAMMMMEEEE must start with rrrreeeennnnaaaammmmeeee.

     If the  call  to  CCCCAAAAEEEESSSSAAAARRRR____UUUUSSSSEEEE____RRRREEEENNNNAAAAMMMMEEEE____MMMMAAAASSSSKKKK____1111(((())))  fails,  (e.g.,
     because the renaming file is incorrect), the boolean pointed
     to by ****CCCCAAAAEEEESSSSAAAARRRR____FFFFAAAAIIIILLLLEEEEDDDD is set to  CCCCAAAAEEEESSSSAAAARRRR____TTTTRRRRUUUUEEEE,  and  an  error
     message  is  printed  to the standard output. Otherwise, the
     boolean  pointed  to  by  ****CCCCAAAAEEEESSSSAAAARRRR____FFFFAAAAIIIILLLLEEEEDDDD  it   is   set   to
     CCCCAAAAEEEESSSSAAAARRRR____FFFFAAAALLLLSSSSEEEE.

     If the cache table is enabled, its contents are erased after
     any call to CCCCAAAAEEEESSSSAAAARRRR____UUUUSSSSEEEE____RRRREEEENNNNAAAAMMMMEEEE____MMMMAAAASSSSKKKK____1111(((()))), since the results of
     previous hiding and/or renaming operations performed so  far
     can  no  longer  be reused after a new renaming operation is
     added.  This  allows  to  invoke  CCCCAAAAEEEESSSSAAAARRRR____UUUUSSSSEEEE____RRRREEEENNNNAAAAMMMMEEEE____MMMMAAAASSSSKKKK____1111(((())))
     safely,    even    after    a    call    to   the   function
     CCCCAAAAEEEESSSSAAAARRRR____AAAAPPPPPPPPLLLLYYYY____MMMMAAAASSSSKKKK____1111(((()))) defined below.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____PPPPAAAARRRRSSSSEEEE____OOOOPPPPTTTTIIIIOOOONNNN____MMMMAAAASSSSKKKK____1111

     vvvvooooiiiidddd CCCCAAAAEEEESSSSAAAARRRR____PPPPAAAARRRRSSSSEEEE____OOOOPPPPTTTTIIIIOOOONNNN____MMMMAAAASSSSKKKK____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____MMMM,,,, CCCCAAAAEEEESSSSAAAARRRR____AAAARRRRGGGGCCCC,,,, CCCCAAAAEEEESSSSAAAARRRR____AAAARRRRGGGGVVVV,,,,
                                      CCCCAAAAEEEESSSSAAAARRRR____NNNNBBBB____TTTTOOOOKKKKEEEENNNNSSSS))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____MMMMAAAASSSSKKKK____1111 CCCCAAAAEEEESSSSAAAARRRR____MMMM;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____AAAARRRRGGGGCCCC CCCCAAAAEEEESSSSAAAARRRR____AAAARRRRGGGGCCCC;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____AAAARRRRGGGGVVVV CCCCAAAAEEEESSSSAAAARRRR____AAAARRRRGGGGVVVV;;;;



(C) INRIA     Last change: 2020/02/11 (version 1.1)             6






OPEN/CAESAR MANUAL                           caesar_mask_1(LOCAL)



        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____GGGGEEEENNNNUUUUIIIINNNNEEEE____IIIINNNNTTTT ****CCCCAAAAEEEESSSSAAAARRRR____NNNNBBBB____TTTTOOOOKKKKEEEENNNNSSSS;;;;
        {{{{ ............ }}}}

     This procedure parses the command-line options specified  by
     parameters  CCCCAAAAEEEESSSSAAAARRRR____AAAARRRRGGGGCCCC  and  CCCCAAAAEEEESSSSAAAARRRR____AAAARRRRGGGGVVVV  and,  if specific
     options defining a hiding or renaming operation  are  recog-
     nized,  the  corresponding  hiding  or renaming operation is
     added to the masking object pointed  to  by  CCCCAAAAEEEESSSSAAAARRRR____MMMM;  this
     addition is done by invoking the CCCCAAAAEEEESSSSAAAARRRR____UUUUSSSSEEEE____HHHHIIIIDDDDEEEE____MMMMAAAASSSSKKKK____1111(((()))) or
     CCCCAAAAEEEESSSSAAAARRRR____UUUUSSSSEEEE____RRRREEEENNNNAAAAMMMMEEEE____MMMMAAAASSSSKKKK____1111(((()))) procedure internally.

     The parameters CCCCAAAAEEEESSSSAAAARRRR____AAAARRRRGGGGCCCC and CCCCAAAAEEEESSSSAAAARRRR____AAAARRRRGGGGVVVV specify a list of
     character  strings (named options). They follow the standard
     conventions regarding the aaaarrrrggggcccc and aaaarrrrggggvvvv  parameters  of  the
     mmmmaaaaiiiinnnn(((())))  function  of any C program.  CCCCAAAAEEEESSSSAAAARRRR____AAAARRRRGGGGCCCC denotes the
     number of options and  CCCCAAAAEEEESSSSAAAARRRR____AAAARRRRGGGGVVVV  is  a  character  string
     array containing the options.

     A hiding operation is defined by the following  sequence  of
     command-line options:

         ----hhhhiiiiddddeeee [[[[ ----ttttoooottttaaaallll |||| ----ppppaaaarrrrttttiiiiaaaallll |||| ----ggggaaaatttteeee ]]]] _h_i_d_i_n_g__f_i_l_e_n_a_m_e

     where _h_i_d_i_n_g__f_i_l_e_n_a_m_e is the pathname of a hiding file  (the
     format of this file is described in the ``hide_1'' library),
     and where the optional ----ttttoooottttaaaallll, ----ppppaaaarrrrttttiiiiaaaallll, and  ----ggggaaaatttteeee  options
     correspond,  respectively, to the ``total matching'', ``par-
     tial matching'', and ``gate matching'' semantics defined  in
     the  documentation  of the ``hide_1'' library; option ----ttttoooottttaaaallll
     is the default.

     A renaming operation is defined by the following sequence of
     command-line options:

  ----rrrreeeennnnaaaammmmeeee [[[[ ----ttttoooottttaaaallll |||| ----ssssiiiinnnngggglllleeee |||| ----mmmmuuuullllttttiiiipppplllleeee |||| ----ggggaaaatttteeee ]]]] _r_e_n_a_m_i_n_g__f_i_l_e_n_a_m_e

     where _r_e_n_a_m_i_n_g__f_i_l_e_n_a_m_e is the pathname of a  renaming  file
     (the  format  of  this file is described in the ``rename_1''
     library), and where the optional ----ttttoooottttaaaallll, ----ssssiiiinnnngggglllleeee, ----mmmmuuuullllttttiiiipppplllleeee,
     and  ----ggggaaaatttteeee  options correspond, respectively, to the ``total
     matching'', ``single partial matching'', ``multiple  partial
     matching'',  and  ``gate matching'' semantics defined in the
     documentation of the ``rename_1'' library; option ----ttttoooottttaaaallll  is
     the default.

     The   CCCCAAAAEEEESSSSAAAARRRR____PPPPAAAARRRRSSSSEEEE____OOOOPPPPTTTTIIIIOOOONNNN____MMMMAAAASSSSKKKK____1111(((())))    procedure    processes
     command-line  options from left to right. One single call to
     CCCCAAAAEEEESSSSAAAARRRR____PPPPAAAARRRRSSSSEEEE____OOOOPPPPTTTTIIIIOOOONNNN____MMMMAAAASSSSKKKK____1111(((()))) recognizes at most one  (hiding
     or  renaming)  operation. Thus, CCCCAAAAEEEESSSSAAAARRRR____PPPPAAAARRRRSSSSEEEE____OOOOPPPPTTTTIIIIOOOONNNN____MMMMAAAASSSSKKKK____1111(((())))
     should be used within a program loop in which CCCCAAAAEEEESSSSAAAARRRR____AAAARRRRGGGGCCCC is
     decremented  and  CCCCAAAAEEEESSSSAAAARRRR____AAAARRRRGGGGVVVV  is  incremented  as hiding or
     renaming options are recognized.



(C) INRIA     Last change: 2020/02/11 (version 1.1)             7






OPEN/CAESAR MANUAL                           caesar_mask_1(LOCAL)



     An integer value is assigned to ****CCCCAAAAEEEESSSSAAAARRRR____NNNNBBBB____TTTTOOOOKKKKEEEENNNNSSSS  in  order
     to  indicate  how many command-line options have been recog-
     nized and processed. The conventions are the following:


     -    If ****CCCCAAAAEEEESSSSAAAARRRR____NNNNBBBB____TTTTOOOOKKKKEEEENNNNSSSS is a strictly positive integer  N,
          the  N-th first options have been recognized as forming
          either a hiding operation or a renaming  operation.  In
          this case, CCCCAAAAEEEESSSSAAAARRRR____AAAARRRRGGGGCCCC will need to be decremented by N
          and CCCCAAAAEEEESSSSAAAARRRR____AAAARRRRGGGGVVVV will need to be incremented by N.

     -    If ****CCCCAAAAEEEESSSSAAAARRRR____NNNNBBBB____TTTTOOOOKKKKEEEENNNNSSSS is equal  to  0,  then  the  first
          option  of CCCCAAAAEEEESSSSAAAARRRR____AAAARRRRGGGGVVVV has not been recognized as form-
          ing either a hiding operation or a renaming operation.

     -    If ****CCCCAAAAEEEESSSSAAAARRRR____NNNNBBBB____TTTTOOOOKKKKEEEENNNNSSSS is strictly  negative,  the  first
          options  have been recognized as forming (at least, the
          beginning of) either a  hiding  operation  or  renaming
          operation,  but  some  error  occured  while processing
          these options (e.g., incorrect option  syntax,  unread-
          able hiding or renaming file, memory shortage, ...). In
          this case, an error message  will  be  printed  to  the
          standard  output.  This situation is usually considered
          as a fatal error.

      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____AAAAPPPPPPPPLLLLYYYY____MMMMAAAASSSSKKKK____1111

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSTTTTRRRRIIIINNNNGGGG CCCCAAAAEEEESSSSAAAARRRR____AAAAPPPPPPPPLLLLYYYY____MMMMAAAASSSSKKKK____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____MMMM,,,, CCCCAAAAEEEESSSSAAAARRRR____PPPP))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____MMMMAAAASSSSKKKK____1111 CCCCAAAAEEEESSSSAAAARRRR____MMMM;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____PPPPOOOOIIIINNNNTTTTEEEERRRR CCCCAAAAEEEESSSSAAAARRRR____PPPP;;;;
        {{{{ ............ }}}}

     This function first converts the memory area pointed  to  by
     CCCCAAAAEEEESSSSAAAARRRR____PPPP  into  a  character  string  S using the conversion
     function associated to the  masking  object  pointed  to  by
     CCCCAAAAEEEESSSSAAAARRRR____MMMM.

     Then, this function applies, in sequence, to S the  list  of
     hiding  and/or renaming operations associated to the masking
     object pointed to by  CCCCAAAAEEEESSSSAAAARRRR____MMMM  and  returns  the  resulting
     character string.

     Note: hiding is done using the CCCCAAAAEEEESSSSAAAARRRR____TTTTEEEESSSSTTTT____HHHHIIIIDDDDEEEE____1111(((()))) function
     of  the  ``hide_1'' library, a hidden character string being
     renamed into the constant character string """"iiii"""".

     Note: renaming  is  done  using  the  CCCCAAAAEEEESSSSAAAARRRR____TTTTEEEESSSSTTTT____RRRREEEENNNNAAAAMMMMEEEE____1111(((())))
     operation of the ``rename_1'' library.

     The order in which hiding  and/or  renaming  operations  are



(C) INRIA     Last change: 2020/02/11 (version 1.1)             8






OPEN/CAESAR MANUAL                           caesar_mask_1(LOCAL)



     applied  is  the  same  as the order in which the procedures
     CCCCAAAAEEEESSSSAAAARRRR____UUUUSSSSEEEE____HHHHIIIIDDDDEEEE____MMMMAAAASSSSKKKK____1111(((())))  and/or  CCCCAAAAEEEESSSSAAAARRRR____UUUUSSSSEEEE____RRRREEEENNNNAAAAMMMMEEEE____MMMMAAAASSSSKKKK____1111(((())))
     have  been  called,  successively,  for  the  masking object
     pointed to by CCCCAAAAEEEESSSSAAAARRRR____MMMM.  If the list of operations is  empty
     (i.e.,   if   no   calls   to   CCCCAAAAEEEESSSSAAAARRRR____UUUUSSSSEEEE____HHHHIIIIDDDDEEEE____1111(((())))  nor  to
     CCCCAAAAEEEESSSSAAAARRRR____UUUUSSSSEEEE____RRRREEEENNNNAAAAMMMMEEEE____1111(((()))) have occurred),  then  the  result  is
     simply S.

     Note: if enabled, the cache table will be used to  speed  up
     the execution of CCCCAAAAEEEESSSSAAAARRRR____AAAAPPPPPPPPLLLLYYYY____MMMMAAAASSSSKKKK____1111(((()))).

     Note: if the cache table  is  enabled  and  if  the  masking
     object  was created to handle string areas, meaning that the
     CCCCAAAAEEEESSSSAAAARRRR____AAAARRRREEEEAAAA parameter of CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTEEEE____MMMMAAAASSSSKKKK____1111(((()))) was equal to
     CCCCAAAAEEEESSSSAAAARRRR____SSSSTTTTRRRRIIIINNNNGGGG____AAAARRRREEEEAAAA____1111(((()))),  then  ****CCCCAAAAEEEESSSSAAAARRRR____PPPP  is  a pointer to a
     null-terminated  character  string.  The  contents  of  this
     string must remain constant, i.e., it is forbidden to modify
     them after invoking of CCCCAAAAEEEESSSSAAAARRRR____AAAAPPPPPPPPLLLLYYYY____MMMMAAAASSSSKKKK____1111{{{{} until the mask-
     ing object is deleted.

     Note: as regards side effects, the contents of CCCCAAAAEEEESSSSAAAARRRR____MMMM  and
     CCCCAAAAEEEESSSSAAAARRRR____PPPP  are not modified, except for the cache table asso-
     ciated to CCCCAAAAEEEESSSSAAAARRRR____MMMM, if any, which might  be  modified  by  a
     call to to CCCCAAAAEEEESSSSAAAARRRR____AAAAPPPPPPPPLLLLYYYY____MMMMAAAASSSSKKKK____1111(((()))).

     Note: it is not  allowed  to  modify  the  character  string
     returned  by  CCCCAAAAEEEESSSSAAAARRRR____AAAAPPPPPPPPLLLLYYYY____MMMMAAAASSSSKKKK____1111(((())))  nor  to  free  it,  for
     instance using ffffrrrreeeeeeee((((3333)))).

     Note: the contents  of  the  character  string  returned  by
     CCCCAAAAEEEESSSSAAAARRRR____AAAAPPPPPPPPLLLLYYYY____MMMMAAAASSSSKKKK____1111(((())))  may be destroyed by a subsequent call
     to this function.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____LLLLAAAABBBBEEEELLLL____HHHHIIIIDDDDEEEE____FFFFOOOORRRRMMMMAAAATTTT____MMMMAAAASSSSKKKK____1111

     ####ddddeeeeffffiiiinnnneeee CCCCAAAAEEEESSSSAAAARRRR____LLLLAAAABBBBEEEELLLL____HHHHIIIIDDDDEEEE____FFFFOOOORRRRMMMMAAAATTTT____MMMMAAAASSSSKKKK____1111 """"   wwwwiiiitttthhhh llllaaaabbbbeeeellllssss hhhhiiiiddddddddeeeennnn uuuussssiiiinnnngggg \\\\""""%%%%ssss\\\\""""""""

     This macro-definition returns the default value used for the
     parameter        CCCCAAAAEEEESSSSAAAARRRR____HHHHIIIIDDDDEEEE____FFFFOOOORRRRMMMMAAAATTTT        of       function
     CCCCAAAAEEEESSSSAAAARRRR____HHHHIIIISSSSTTTTOOOORRRRYYYY____MMMMAAAASSSSKKKK____1111(((()))) when the actual value given to  this
     parameter is NNNNUUUULLLLLLLL.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____LLLLAAAABBBBEEEELLLL____RRRREEEENNNNAAAAMMMMEEEE____FFFFOOOORRRRMMMMAAAATTTT____MMMMAAAASSSSKKKK____1111

     ####ddddeeeeffffiiiinnnneeee CCCCAAAAEEEESSSSAAAARRRR____LLLLAAAABBBBEEEELLLL____RRRREEEENNNNAAAAMMMMEEEE____FFFFOOOORRRRMMMMAAAATTTT____MMMMAAAASSSSKKKK____1111 """"   wwwwiiiitttthhhh llllaaaabbbbeeeellllssss rrrreeeennnnaaaammmmeeeedddd uuuussssiiiinnnngggg \\\\""""%%%%ssss\\\\""""""""




(C) INRIA     Last change: 2020/02/11 (version 1.1)             9






OPEN/CAESAR MANUAL                           caesar_mask_1(LOCAL)



     This macro-definition returns the default value used for the
     parameter       CCCCAAAAEEEESSSSAAAARRRR____RRRREEEENNNNAAAAMMMMEEEE____FFFFOOOORRRRMMMMAAAATTTT       of       function
     CCCCAAAAEEEESSSSAAAARRRR____HHHHIIIISSSSTTTTOOOORRRRYYYY____MMMMAAAASSSSKKKK____1111(((()))) when the actual value given to  this
     parameter is NNNNUUUULLLLLLLL.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____HHHHIIIISSSSTTTTOOOORRRRYYYY____MMMMAAAASSSSKKKK____1111

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSTTTTRRRRIIIINNNNGGGG CCCCAAAAEEEESSSSAAAARRRR____HHHHIIIISSSSTTTTOOOORRRRYYYY____MMMMAAAASSSSKKKK____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____MMMM,,,, CCCCAAAAEEEESSSSAAAARRRR____PPPPRRRREEEEFFFFIIIIXXXX,,,,
                                               CCCCAAAAEEEESSSSAAAARRRR____HHHHIIIIDDDDEEEE____FFFFOOOORRRRMMMMAAAATTTT,,,,
                                               CCCCAAAAEEEESSSSAAAARRRR____RRRREEEENNNNAAAAMMMMEEEE____FFFFOOOORRRRMMMMAAAATTTT,,,,
                                               CCCCAAAAEEEESSSSAAAARRRR____SSSSUUUUFFFFFFFFIIIIXXXX,,,, CCCCAAAAEEEESSSSAAAARRRR____SSSSEEEEPPPPAAAARRRRAAAATTTTOOOORRRR))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____MMMMAAAASSSSKKKK____1111 CCCCAAAAEEEESSSSAAAARRRR____MMMM;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSTTTTRRRRIIIINNNNGGGG CCCCAAAAEEEESSSSAAAARRRR____PPPPRRRREEEEFFFFIIIIXXXX;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSTTTTRRRRIIIINNNNGGGG CCCCAAAAEEEESSSSAAAARRRR____HHHHIIIIDDDDEEEE____FFFFOOOORRRRMMMMAAAATTTT;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSTTTTRRRRIIIINNNNGGGG CCCCAAAAEEEESSSSAAAARRRR____RRRREEEENNNNAAAAMMMMEEEE____FFFFOOOORRRRMMMMAAAATTTT;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSTTTTRRRRIIIINNNNGGGG CCCCAAAAEEEESSSSAAAARRRR____SSSSUUUUFFFFFFFFIIIIXXXX;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSTTTTRRRRIIIINNNNGGGG CCCCAAAAEEEESSSSAAAARRRR____SSSSEEEEPPPPAAAARRRRAAAATTTTOOOORRRR;;;;
        {{{{ ............ }}}}

     If the masking object pointed to by CCCCAAAAEEEESSSSAAAARRRR____MMMM was created  by
     a  call  to CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTEEEE____MMMMAAAASSSSKKKK____1111(((()))) in which the value of the
     CCCCAAAAEEEESSSSAAAARRRR____HHHHIIIISSSSTTTTOOOORRRRYYYY parameter  was  equal  to  CCCCAAAAEEEESSSSAAAARRRR____FFFFAAAALLLLSSSSEEEE,  the
     effect of this function is undefined.

     Otherwise, this function allocates and returns  a  character
     string  S  summarizing  the  list  of hiding and/or renaming
     operations associated to the masking object  pointed  to  by
     CCCCAAAAEEEESSSSAAAARRRR____MMMM. If allocation fails, then S will be equal to NNNNUUUULLLLLLLL;
     if not, S will consist of several components:


     -    If the character string pointed to by CCCCAAAAEEEESSSSAAAARRRR____PPPPRRRREEEEFFFFIIIIXXXX  is
          different  from  NNNNUUUULLLLLLLL, it will form the first component
          of S.

     -    Then, for each hiding or renaming operation  associated
          to  the  masking object, a corresponding component will
          be appended to S; these operations  are  considered  in
          the  order  in  which  the CCCCAAAAEEEESSSSAAAARRRR____UUUUSSSSEEEE____HHHHIIIIDDDDEEEE____MMMMAAAASSSSKKKK____1111(((()))) and
          CCCCAAAAEEEESSSSAAAARRRR____UUUUSSSSEEEE____RRRREEEENNNNAAAAMMMMEEEE____MMMMAAAASSSSKKKK____1111(((()))) procedures have been called.

          For a hiding operation, the corresponding component  is
          given   by   the   character   string   pointed  to  by
          CCCCAAAAEEEESSSSAAAARRRR____HHHHIIIIDDDDEEEE____FFFFOOOORRRRMMMMAAAATTTT. This character string  follows  the
          same  conventions  as  a  format  string  given  to the
          pppprrrriiiinnnnttttffff((((3333)))) function.  However, this string  may  contain
          at  most  one  %%%%ssss pattern, which will be substituted by
          the pathname of  the  hiding  file  associated  to  the
          operation. It should not contain any other pattern such



(C) INRIA     Last change: 2020/02/11 (version 1.1)            10






OPEN/CAESAR MANUAL                           caesar_mask_1(LOCAL)



          as %%%%dddd, %%%%xxxx, or even %%%%33332222ssss. If CCCCAAAAEEEESSSSAAAARRRR____HHHHIIIIDDDDEEEE____FFFFOOOORRRRMMMMAAAATTTT is equal
          to  NNNNUUUULLLLLLLL,  it  will  be  replaced  by its default value
          CCCCAAAAEEEESSSSAAAARRRR____LLLLAAAABBBBEEEELLLL____HHHHIIIIDDDDEEEE____FFFFOOOORRRRMMMMAAAATTTT____MMMMAAAASSSSKKKK____1111.

          For a renaming operation, the  corresponding  component
          is   given  by  the  character  string  pointed  to  by
          CCCCAAAAEEEESSSSAAAARRRR____RRRREEEENNNNAAAAMMMMEEEE____FFFFOOOORRRRMMMMAAAATTTT. This character string follows the
          same  conventions  as  a  format  string  given  to the
          pppprrrriiiinnnnttttffff((((3333)))) function.  However, this string  may  contain
          at  most  one  %%%%ssss pattern, which will be substituted by
          the pathname of the renaming  file  associated  to  the
          operation. It should not contain any other pattern such
          as %%%%dddd, %%%%xxxx, or even  %%%%33332222ssss.  If  CCCCAAAAEEEESSSSAAAARRRR____RRRREEEENNNNAAAAMMMMEEEE____FFFFOOOORRRRMMMMAAAATTTT  is
          equal to NNNNUUUULLLLLLLL, it will be replaced by its default value
          CCCCAAAAEEEESSSSAAAARRRR____LLLLAAAABBBBEEEELLLL____RRRREEEENNNNAAAAMMMMEEEE____FFFFOOOORRRRMMMMAAAATTTT____MMMMAAAASSSSKKKK____1111.

     -    If the character string pointed to by CCCCAAAAEEEESSSSAAAARRRR____SSSSUUUUFFFFFFFFIIIIXXXX  is
          different from NNNNUUUULLLLLLLL, it will form the last component of
          S.

     -    The character string  pointed  to  by  CCCCAAAAEEEESSSSAAAARRRR____SSSSEEEEPPPPAAAARRRRAAAATTTTOOOORRRR
          (or,  if  CCCCAAAAEEEESSSSAAAARRRR____SSSSEEEEPPPPAAAARRRRAAAATTTTOOOORRRR  is NNNNUUUULLLLLLLL, the default string
          """"\nnnn"""") will be inserted as a separator between every two
          components of S.

     Note: The resulting character string S  is  allocated  using
     CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTEEEE(((())))  and  should  be  freed  as soon as possible
     using CCCCAAAAEEEESSSSAAAARRRR____DDDDEEEELLLLEEEETTTTEEEE(((()))).


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____FFFFAAAAIIIILLLLUUUURRRREEEE____MMMMAAAASSSSKKKK____1111

     vvvvooooiiiidddd CCCCAAAAEEEESSSSAAAARRRR____FFFFAAAAIIIILLLLUUUURRRREEEE____MMMMAAAASSSSKKKK____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____MMMM))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____MMMMAAAASSSSKKKK____1111 CCCCAAAAEEEESSSSAAAARRRR____MMMM;;;;
        {{{{ ............ }}}}

     This function returns  the  value  of  the  failure  counter
     (i.e.,  the  number  of  searches  that failed) of the cache
     table  associated  to  the  masking  object  pointed  to  by
     CCCCAAAAEEEESSSSAAAARRRR____MMMM.

     If the cache table is not enabled in the masking object, the
     effect of this function is undefined.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____SSSSUUUUCCCCCCCCEEEESSSSSSSS____MMMMAAAASSSSKKKK____1111

     vvvvooooiiiidddd CCCCAAAAEEEESSSSAAAARRRR____SSSSUUUUCCCCCCCCEEEESSSSSSSS____MMMMAAAASSSSKKKK____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____MMMM))))



(C) INRIA     Last change: 2020/02/11 (version 1.1)            11






OPEN/CAESAR MANUAL                           caesar_mask_1(LOCAL)



        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____MMMMAAAASSSSKKKK____1111 CCCCAAAAEEEESSSSAAAARRRR____MMMM;;;;
        {{{{ ............ }}}}

     This function returns  the  value  of  the  success  counter
     (i.e.,  the  number of searches that succeeded) of the cache
     table  associated  to  the  masking  object  pointed  to  by
     CCCCAAAAEEEESSSSAAAARRRR____MMMM.

     If the cache table is not enabled in the masking object, the
     effect of this function is undefined.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____FFFFOOOORRRRMMMMAAAATTTT____MMMMAAAASSSSKKKK____1111

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____FFFFOOOORRRRMMMMAAAATTTT CCCCAAAAEEEESSSSAAAARRRR____FFFFOOOORRRRMMMMAAAATTTT____MMMMAAAASSSSKKKK____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____MMMM,,,, CCCCAAAAEEEESSSSAAAARRRR____FFFFOOOORRRRMMMMAAAATTTT))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____MMMMAAAASSSSKKKK____1111 CCCCAAAAEEEESSSSAAAARRRR____MMMM;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____FFFFOOOORRRRMMMMAAAATTTT CCCCAAAAEEEESSSSAAAARRRR____FFFFOOOORRRRMMMMAAAATTTT;;;;
        {{{{ ............ }}}}

     This function allows to control the format under  which  the
     masking object pointed to by CCCCAAAAEEEESSSSAAAARRRR____MMMM will be printed by the
     procedure CCCCAAAAEEEESSSSAAAARRRR____PPPPRRRRIIIINNNNTTTT____MMMMAAAASSSSKKKK____1111(((()))) (see below). Currently,  the
     following formats are available:


     -    With format 0, statistical information about the  mask-
          ing  object  is  displayed  such  as: the area size (in
          bytes), the area hashable size  (in  bytes),  the  area
          comparison  function,  the area hash function, the area
          conversion  function,  etc.  The  cache  size  is  also
          displayed  together with, if it is different from zero,
          the number of searches that failed and succeeded.

     -    With format 1, the list of operations performed by  the
          masking   object  is  displayed  using  the  procedures
          CCCCAAAAEEEESSSSAAAARRRR____PPPPRRRRIIIINNNNTTTT____HHHHIIIIDDDDEEEE____1111(((())))    and    CCCCAAAAEEEESSSSAAAARRRR____PPPPRRRRIIIINNNNTTTT____RRRREEEENNNNAAAAMMMMEEEE____1111(((())))
          exported  by  the ``hide_1'' and ``rename_1'' libraries
          (these procedures are called with their respective for-
          mats set to 0).

     -    With format 2, the contents  of  the  cache  table  are
          displayed if the cache table is enabled.

     -    (no other format available yet).

     By default, the current format of  each  masking  object  is
     initialized to 0.

     When called with CCCCAAAAEEEESSSSAAAARRRR____FFFFOOOORRRRMMMMAAAATTTT between 0 and 2,  this  fonc-
     tion  sets  the  current format of CCCCAAAAEEEESSSSAAAARRRR____MMMM to CCCCAAAAEEEESSSSAAAARRRR____FFFFOOOORRRRMMMMAAAATTTT



(C) INRIA     Last change: 2020/02/11 (version 1.1)            12






OPEN/CAESAR MANUAL                           caesar_mask_1(LOCAL)



     and returns an undefined result.

     When called with another value of CCCCAAAAEEEESSSSAAAARRRR____FFFFOOOORRRRMMMMAAAATTTT, this  func-
     tion  does  not  modify  the  current format of CCCCAAAAEEEESSSSAAAARRRR____MMMM but
     returns a result defined as  follows.  If  CCCCAAAAEEEESSSSAAAARRRR____FFFFOOOORRRRMMMMAAAATTTT  is
     equal  to  the constant CCCCAAAAEEEESSSSAAAARRRR____CCCCUUUURRRRRRRREEEENNNNTTTT____FFFFOOOORRRRMMMMAAAATTTT, the result is
     the  value  of  the   current   format   of   CCCCAAAAEEEESSSSAAAARRRR____MMMM.   If
     CCCCAAAAEEEESSSSAAAARRRR____FFFFOOOORRRRMMMMAAAATTTT      is      equal     to     the     constant
     CCCCAAAAEEEESSSSAAAARRRR____MMMMAAAAXXXXIIIIMMMMAAAALLLL____FFFFOOOORRRRMMMMAAAATTTT, the  result  is  the  maximal  format
     value  (i.e.,  2).  In  all  other cases, the effect of this
     function is undefined.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____MMMMAAAAXXXX____FFFFOOOORRRRMMMMAAAATTTT____MMMMAAAASSSSKKKK____1111

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____FFFFOOOORRRRMMMMAAAATTTT CCCCAAAAEEEESSSSAAAARRRR____MMMMAAAAXXXX____FFFFOOOORRRRMMMMAAAATTTT____MMMMAAAASSSSKKKK____1111 (((())))
        {{{{ ............ }}}}

     Caution! This function is deprecated. It should no longer be
     used,  as  it  might  be removed from future versions of the
     _O_P_E_N/_C_A_E_S_A_R. Use  function  CCCCAAAAEEEESSSSAAAARRRR____FFFFOOOORRRRMMMMAAAATTTT____MMMMAAAASSSSKKKK____1111(((())))  instead,
     called with argument CCCCAAAAEEEESSSSAAAARRRR____MMMMAAAAXXXXIIIIMMMMAAAALLLL____FFFFOOOORRRRMMMMAAAATTTT.

     This function returns the maximal format value available for
     printing masking objects.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____PPPPRRRRIIIINNNNTTTT____MMMMAAAASSSSKKKK____1111

     vvvvooooiiiidddd CCCCAAAAEEEESSSSAAAARRRR____PPPPRRRRIIIINNNNTTTT____MMMMAAAASSSSKKKK____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____FFFFIIIILLLLEEEE,,,, CCCCAAAAEEEESSSSAAAARRRR____MMMM))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____FFFFIIIILLLLEEEE CCCCAAAAEEEESSSSAAAARRRR____FFFFIIIILLLLEEEE;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____MMMMAAAASSSSKKKK____1111 CCCCAAAAEEEESSSSAAAARRRR____MMMM;;;;
        {{{{ ............ }}}}

     This procedure prints to file CCCCAAAAEEEESSSSAAAARRRR____FFFFIIIILLLLEEEE a text  containing
     information about the masking object pointed to by CCCCAAAAEEEESSSSAAAARRRR____MMMM.
     The nature of the information is determined by  the  current
     format of the masking object pointed to by CCCCAAAAEEEESSSSAAAARRRR____MMMM.

     Before this procedure is called, CCCCAAAAEEEESSSSAAAARRRR____FFFFIIIILLLLEEEE must have  been
     properly opened, for instance using ffffooooppppeeeennnn((((3333)))).


      ............................................................

AAAAUUUUTTTTHHHHOOOORRRR((((SSSS))))
     Nicolas Descoubes and Hubert Garavel




(C) INRIA     Last change: 2020/02/11 (version 1.1)            13






OPEN/CAESAR MANUAL                           caesar_mask_1(LOCAL)



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




























(C) INRIA     Last change: 2020/02/11 (version 1.1)            14



