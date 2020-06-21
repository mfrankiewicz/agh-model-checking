


OPEN/CAESAR MANUAL                           caesar_bitmap(LOCAL)



NNNNAAAAMMMMEEEE
     caesar_bitmap - the ``bitmap'' library of OPEN/CAESAR

PPPPUUUURRRRPPPPOOOOSSSSEEEE
     The ``bitmap'' library provides primitives for  implementing
     the  ``bit  state space'' verification technique proposed by
     Gerard Holzmann.


UUUUSSSSAAAAGGGGEEEE
     The ``bitmap'' library consists of:

     -    a predefined header file ccccaaaaeeeessssaaaarrrr____bbbbiiiittttmmmmaaaapppp....hhhh;

     -    the precompiled library file lllliiiibbbbccccaaaaeeeessssaaaarrrr....aaaa, which  imple-
          ments the features described in ccccaaaaeeeessssaaaarrrr____bbbbiiiittttmmmmaaaapppp....hhhh.

     Note: The ``bitmap'' library is a software layer built above
     the  primitives  offered  by  the  ``standard'' and ``hash''
     libraries.


DDDDEEEESSSSCCCCRRRRIIIIPPPPTTTTIIIIOOOONNNN
     A ``bitmap'' of size N is basically an array of N bits  num-
     bered  from 0 to N-1. The value of N is usually large (e.g.,
     some tenth million states).

     Additionally, statistics are attached to each bitmap.  These
     statistics  consist  of  a ``success counter'' (which counts
     how many bits equal to 1 have been  read)  and  a  ``failure
     counter''  (which  counts how many bits equal to 0 have been
     read).


FFFFEEEEAAAATTTTUUUURRRREEEESSSS
      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____BBBBIIIITTTTMMMMAAAAPPPP

     ttttyyyyppppeeeeddddeeeeffff CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____AAAABBBBSSSSTTTTRRRRAAAACCCCTTTT ((((............)))) CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____BBBBIIIITTTTMMMMAAAAPPPP;;;;

     This type denotes a pointer to the  concrete  representation
     of a bitmap, which is supposed to be ``opaque''.

      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTEEEE____BBBBIIIITTTTMMMMAAAAPPPP

     vvvvooooiiiidddd CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTEEEE____BBBBIIIITTTTMMMMAAAAPPPP ((((CCCCAAAAEEEESSSSAAAARRRR____BBBB,,,, CCCCAAAAEEEESSSSAAAARRRR____SSSSIIIIZZZZEEEE,,,, CCCCAAAAEEEESSSSAAAARRRR____PPPPRRRRIIIIMMMMEEEE))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____BBBBIIIITTTTMMMMAAAAPPPP ****CCCCAAAAEEEESSSSAAAARRRR____BBBB;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL CCCCAAAAEEEESSSSAAAARRRR____SSSSIIIIZZZZEEEE;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____BBBBOOOOOOOOLLLLEEEEAAAANNNN CCCCAAAAEEEESSSSAAAARRRR____PPPPRRRRIIIIMMMMEEEE;;;;



(C) INRIA     Last change: 2020/02/11 (version 1.5)             1






OPEN/CAESAR MANUAL                           caesar_bitmap(LOCAL)



        {{{{ ............ }}}}

     This procedure allocates a bitmap using CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTEEEE(((())))  and
     assigns  its address to ****CCCCAAAAEEEESSSSAAAARRRR____BBBB. The size N of this bitmap
     is determined by the values of formal parameters CCCCAAAAEEEESSSSAAAARRRR____SSSSIIIIZZZZEEEE
     and  CCCCAAAAEEEESSSSAAAARRRR____PPPPRRRRIIIIMMMMEEEE,  and  also by the amount of memory avail-
     able.

     Note: because CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____BBBBIIIITTTTMMMMAAAAPPPP  is  a  pointer  type,  any
     variable  CCCCAAAAEEEESSSSAAAARRRR____BBBB  of type CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____BBBBIIIITTTTMMMMAAAAPPPP must be allo-
     cated before used, for instance using:

                CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTEEEE____BBBBIIIITTTTMMMMAAAAPPPP ((((&&&&CCCCAAAAEEEESSSSAAAARRRR____BBBB,,,, ............))))


     If the value of CCCCAAAAEEEESSSSAAAARRRR____SSSSIIIIZZZZEEEE is different from  0,  then  the
     number N of bits in the bitmap will be CCCCAAAAEEEESSSSAAAARRRR____SSSSIIIIZZZZEEEE.

     If the value of CCCCAAAAEEEESSSSAAAARRRR____SSSSIIIIZZZZEEEE is equal to 0, then  N  will  be
     given a default value as large as possible.

     Note: in this case, the bitmap will fill most of the  memory
     space  available  for  the  current  process.  Therefore, if
     CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTEEEE____BBBBIIIITTTTMMMMAAAAPPPP(((()))) is to be called with CCCCAAAAEEEESSSSAAAARRRR____SSSSIIIIZZZZEEEE = 0,
     it  should  be  called  only  after having allocated all the
     other data structures (e.g., stacks, ...),  otherwise  there
     may be not enough memory for these data structures.

     In both cases, the value of N can be reduced  to  a  smaller
     value as to fit into the amount of available memory.

     If the value of CCCCAAAAEEEESSSSAAAARRRR____PPPPRRRRIIIIMMMMEEEE is different from 0, the  value
     of  N  can  also be reduced to the immediately smaller prime
     number (since some hash functions require prime modulus). If
     the  value  of CCCCAAAAEEEESSSSAAAARRRR____PPPPRRRRIIIIMMMMEEEE is equal to 0, the value of N is
     not changed.

     If (in spite of various attempts) the allocation fails,  the
     NNNNUUUULLLLLLLL value is assigned to ****CCCCAAAAEEEESSSSAAAARRRR____BBBB.

     If the allocation succeeds, the final  value  of  N  can  be
     known using the function CCCCAAAAEEEESSSSAAAARRRR____SSSSIIIIZZZZEEEE____BBBBIIIITTTTMMMMAAAAPPPP(((()))) (see below).

     If the allocation succeeds, the N bits  of  the  bitmap  are
     initialized  to 0. The success and failure counters attached
     to the bitmap are also initialized to 0.

     Note:  since  variable  CCCCAAAAEEEESSSSAAAARRRR____SSSSIIIIZZZZEEEE  is  a  value  of   type
     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL,  a  bitmap can contain at most 2^{8n}-1
     bits, where:

                   n = ssssiiiizzzzeeeeooooffff ((((CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL))))



(C) INRIA     Last change: 2020/02/11 (version 1.5)             2






OPEN/CAESAR MANUAL                           caesar_bitmap(LOCAL)




     It  is  assumed  that  n  >=  4.  For  n  =  4,  this  makes
     4,294,967,295  bits,  that is approximately 537 Megabytes of
     memory, which is currently enough.

      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____DDDDEEEELLLLEEEETTTTEEEE____BBBBIIIITTTTMMMMAAAAPPPP

     vvvvooooiiiidddd CCCCAAAAEEEESSSSAAAARRRR____DDDDEEEELLLLEEEETTTTEEEE____BBBBIIIITTTTMMMMAAAAPPPP ((((CCCCAAAAEEEESSSSAAAARRRR____BBBB))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____BBBBIIIITTTTMMMMAAAAPPPP ****CCCCAAAAEEEESSSSAAAARRRR____BBBB;;;;
        {{{{ ............ }}}}

     This procedure frees the memory space corresponding  to  the
     bitmap pointed to by ****CCCCAAAAEEEESSSSAAAARRRR____BBBB using CCCCAAAAEEEESSSSAAAARRRR____DDDDEEEELLLLEEEETTTTEEEE(((()))). After-
     wards, the NNNNUUUULLLLLLLL value is assigned to ****CCCCAAAAEEEESSSSAAAARRRR____BBBB.

      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____PPPPUUUURRRRGGGGEEEE____BBBBIIIITTTTMMMMAAAAPPPP

     vvvvooooiiiidddd CCCCAAAAEEEESSSSAAAARRRR____PPPPUUUURRRRGGGGEEEE____BBBBIIIITTTTMMMMAAAAPPPP ((((CCCCAAAAEEEESSSSAAAARRRR____BBBB))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____BBBBIIIITTTTMMMMAAAAPPPP CCCCAAAAEEEESSSSAAAARRRR____BBBB;;;;
        {{{{ ............ }}}}

     This procedure empties the bitmap  pointed  to  by  CCCCAAAAEEEESSSSAAAARRRR____BBBB
     without  deleting  it. Afterwards, this bitmap is exactly in
     the   same   state   as    after    its    creation    using
     CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTEEEE____BBBBIIIITTTTMMMMAAAAPPPP(((()))). Its size remains unchanged.

      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____SSSSIIIIZZZZEEEE____BBBBIIIITTTTMMMMAAAAPPPP

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL CCCCAAAAEEEESSSSAAAARRRR____SSSSIIIIZZZZEEEE____BBBBIIIITTTTMMMMAAAAPPPP ((((CCCCAAAAEEEESSSSAAAARRRR____BBBB))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____BBBBIIIITTTTMMMMAAAAPPPP CCCCAAAAEEEESSSSAAAARRRR____BBBB;;;;
        {{{{ ............ }}}}

     This function returns the size (i.e., number of bits) of the
     bitmap  pointed to by CCCCAAAAEEEESSSSAAAARRRR____BBBB. This size is determined when
     the  bitmap  is  created  using  CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTEEEE____BBBBIIIITTTTMMMMAAAAPPPP(((())))  and
     remains constant.

      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____SSSSEEEETTTT____BBBBIIIITTTTMMMMAAAAPPPP

     vvvvooooiiiidddd CCCCAAAAEEEESSSSAAAARRRR____SSSSEEEETTTT____BBBBIIIITTTTMMMMAAAAPPPP ((((CCCCAAAAEEEESSSSAAAARRRR____BBBB,,,, CCCCAAAAEEEESSSSAAAARRRR____IIII))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____BBBBIIIITTTTMMMMAAAAPPPP CCCCAAAAEEEESSSSAAAARRRR____BBBB;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL CCCCAAAAEEEESSSSAAAARRRR____IIII;;;;
        {{{{ ............ }}}}




(C) INRIA     Last change: 2020/02/11 (version 1.5)             3






OPEN/CAESAR MANUAL                           caesar_bitmap(LOCAL)



     This procedure sets to 1 the CCCCAAAAEEEESSSSAAAARRRR____IIII-th bit of  the  bitmap
     pointed to by CCCCAAAAEEEESSSSAAAARRRR____BBBB. The value of CCCCAAAAEEEESSSSAAAARRRR____IIII is such that:

            0 <= CCCCAAAAEEEESSSSAAAARRRR____IIII <= CCCCAAAAEEEESSSSAAAARRRR____SSSSIIIIZZZZEEEE____BBBBIIIITTTTMMMMAAAAPPPP ((((CCCCAAAAEEEESSSSAAAARRRR____BBBB))))

     It is usually the result of some hash-code computation.

      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____RRRREEEESSSSEEEETTTT____BBBBIIIITTTTMMMMAAAAPPPP

     vvvvooooiiiidddd CCCCAAAAEEEESSSSAAAARRRR____RRRREEEESSSSEEEETTTT____BBBBIIIITTTTMMMMAAAAPPPP ((((CCCCAAAAEEEESSSSAAAARRRR____BBBB,,,, CCCCAAAAEEEESSSSAAAARRRR____IIII))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____BBBBIIIITTTTMMMMAAAAPPPP CCCCAAAAEEEESSSSAAAARRRR____BBBB;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL CCCCAAAAEEEESSSSAAAARRRR____IIII;;;;
        {{{{ ............ }}}}

     This procedure sets to 0 the CCCCAAAAEEEESSSSAAAARRRR____IIII-th bit of  the  bitmap
     pointed to by CCCCAAAAEEEESSSSAAAARRRR____BBBB. The value of CCCCAAAAEEEESSSSAAAARRRR____IIII is such that:

            0 <= CCCCAAAAEEEESSSSAAAARRRR____IIII <= CCCCAAAAEEEESSSSAAAARRRR____SSSSIIIIZZZZEEEE____BBBBIIIITTTTMMMMAAAAPPPP ((((CCCCAAAAEEEESSSSAAAARRRR____BBBB))))

     It is usually the result of some hash-code computation.

      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____TTTTEEEESSSSTTTT____BBBBIIIITTTTMMMMAAAAPPPP

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____BBBBOOOOOOOOLLLLEEEEAAAANNNN CCCCAAAAEEEESSSSAAAARRRR____TTTTEEEESSSSTTTT____BBBBIIIITTTTMMMMAAAAPPPP ((((CCCCAAAAEEEESSSSAAAARRRR____BBBB,,,, CCCCAAAAEEEESSSSAAAARRRR____IIII))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____BBBBIIIITTTTMMMMAAAAPPPP CCCCAAAAEEEESSSSAAAARRRR____BBBB;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL CCCCAAAAEEEESSSSAAAARRRR____IIII;;;;
        {{{{ ............ }}}}

     This function returns 0 if the CCCCAAAAEEEESSSSAAAARRRR____IIII-th bit of the bitmap
     pointed  to  by CCCCAAAAEEEESSSSAAAARRRR____BBBB is equal to 0, or a value different
     from 0 if this bit is equal to 1. The value of  CCCCAAAAEEEESSSSAAAARRRR____IIII  is
     such that:

            0 <= CCCCAAAAEEEESSSSAAAARRRR____IIII <= CCCCAAAAEEEESSSSAAAARRRR____SSSSIIIIZZZZEEEE____BBBBIIIITTTTMMMMAAAAPPPP ((((CCCCAAAAEEEESSSSAAAARRRR____BBBB))))

     It is usually the result of some hash-code computation.

     A return value of 0 increments the failure counter  attached
     to the bitmap pointed to by CCCCAAAAEEEESSSSAAAARRRR____BBBB, whereas a return value
     of 1 increments the success counter.

      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____TTTTEEEESSSSTTTT____AAAANNNNDDDD____SSSSEEEETTTT____BBBBIIIITTTTMMMMAAAAPPPP

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____BBBBOOOOOOOOLLLLEEEEAAAANNNN CCCCAAAAEEEESSSSAAAARRRR____TTTTEEEESSSSTTTT____AAAANNNNDDDD____SSSSEEEETTTT____BBBBIIIITTTTMMMMAAAAPPPP ((((CCCCAAAAEEEESSSSAAAARRRR____BBBB,,,, CCCCAAAAEEEESSSSAAAARRRR____IIII))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____BBBBIIIITTTTMMMMAAAAPPPP CCCCAAAAEEEESSSSAAAARRRR____BBBB;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL CCCCAAAAEEEESSSSAAAARRRR____IIII;;;;



(C) INRIA     Last change: 2020/02/11 (version 1.5)             4






OPEN/CAESAR MANUAL                           caesar_bitmap(LOCAL)



        {{{{ ............ }}}}

     This function returns 0 if the CCCCAAAAEEEESSSSAAAARRRR____IIII-th bit of the bitmap
     pointed  to  by CCCCAAAAEEEESSSSAAAARRRR____BBBB is equal to 0, or a value different
     from 0 if this bit is equal to 1. The value of  CCCCAAAAEEEESSSSAAAARRRR____IIII  is
     such that:

            0 <= CCCCAAAAEEEESSSSAAAARRRR____IIII <= CCCCAAAAEEEESSSSAAAARRRR____SSSSIIIIZZZZEEEE____BBBBIIIITTTTMMMMAAAAPPPP ((((CCCCAAAAEEEESSSSAAAARRRR____BBBB))))

     It is usually the result of some hash-code computation.

     The CCCCAAAAEEEESSSSAAAARRRR____IIII-th bit of the bitmap pointed to by CCCCAAAAEEEESSSSAAAARRRR____BBBB  is
     set to 1 if it was equal to 0.

     A return value of 0 increments the failure counter  attached
     to the bitmap pointed to by CCCCAAAAEEEESSSSAAAARRRR____BBBB, whereas a return value
     of 1 increments the success counter.

      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____TTTTEEEESSSSTTTT____AAAANNNNDDDD____RRRREEEESSSSEEEETTTT____BBBBIIIITTTTMMMMAAAAPPPP

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____BBBBOOOOOOOOLLLLEEEEAAAANNNN CCCCAAAAEEEESSSSAAAARRRR____TTTTEEEESSSSTTTT____AAAANNNNDDDD____RRRREEEESSSSEEEETTTT____BBBBIIIITTTTMMMMAAAAPPPP ((((CCCCAAAAEEEESSSSAAAARRRR____BBBB,,,, CCCCAAAAEEEESSSSAAAARRRR____IIII))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____BBBBIIIITTTTMMMMAAAAPPPP CCCCAAAAEEEESSSSAAAARRRR____BBBB;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL CCCCAAAAEEEESSSSAAAARRRR____IIII;;;;
        {{{{ ............ }}}}

     This function returns 0 if the CCCCAAAAEEEESSSSAAAARRRR____IIII-th bit of the bitmap
     pointed  to  by CCCCAAAAEEEESSSSAAAARRRR____BBBB is equal to 0, or a value different
     from 0 if this bit is equal to 1. The value of  CCCCAAAAEEEESSSSAAAARRRR____IIII  is
     such that:

            0 <= CCCCAAAAEEEESSSSAAAARRRR____IIII <= CCCCAAAAEEEESSSSAAAARRRR____SSSSIIIIZZZZEEEE____BBBBIIIITTTTMMMMAAAAPPPP ((((CCCCAAAAEEEESSSSAAAARRRR____BBBB))))

     It is usually the result of some hash-code computation.

     The CCCCAAAAEEEESSSSAAAARRRR____IIII-th bit of the bitmap pointed to by CCCCAAAAEEEESSSSAAAARRRR____BBBB  is
     set to 0 if it was equal to 1.

     A return value of 0 increments the failure counter  attached
     to the bitmap pointed to by CCCCAAAAEEEESSSSAAAARRRR____BBBB, whereas a return value
     of 1 increments the success counter.

      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____ZZZZEEEERRRROOOO____BBBBIIIITTTTMMMMAAAAPPPP

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL CCCCAAAAEEEESSSSAAAARRRR____ZZZZEEEERRRROOOO____BBBBIIIITTTTMMMMAAAAPPPP ((((CCCCAAAAEEEESSSSAAAARRRR____BBBB))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____BBBBIIIITTTTMMMMAAAAPPPP CCCCAAAAEEEESSSSAAAARRRR____BBBB;;;;
        {{{{ ............ }}}}

     This function returns the number of bits which are equal  to



(C) INRIA     Last change: 2020/02/11 (version 1.5)             5






OPEN/CAESAR MANUAL                           caesar_bitmap(LOCAL)



     0 in the bitmap pointed to by CCCCAAAAEEEESSSSAAAARRRR____BBBB.

      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____OOOONNNNEEEE____BBBBIIIITTTTMMMMAAAAPPPP

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL CCCCAAAAEEEESSSSAAAARRRR____OOOONNNNEEEE____BBBBIIIITTTTMMMMAAAAPPPP ((((CCCCAAAAEEEESSSSAAAARRRR____BBBB))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____BBBBIIIITTTTMMMMAAAAPPPP CCCCAAAAEEEESSSSAAAARRRR____BBBB;;;;
        {{{{ ............ }}}}

     This function returns the number of bits which are equal  to
     1 in the bitmap pointed to by CCCCAAAAEEEESSSSAAAARRRR____BBBB.

     Note: for any bitmap CCCCAAAAEEEESSSSAAAARRRR____BBBB:

     CCCCAAAAEEEESSSSAAAARRRR____ZZZZEEEERRRROOOO____BBBBIIIITTTTMMMMAAAAPPPP ((((CCCCAAAAEEEESSSSAAAARRRR____BBBB)))) + CCCCAAAAEEEESSSSAAAARRRR____OOOONNNNEEEE____BBBBIIIITTTTMMMMAAAAPPPP ((((CCCCAAAAEEEESSSSAAAARRRR____BBBB))))

     is equal to:

                    CCCCAAAAEEEESSSSAAAARRRR____SSSSIIIIZZZZEEEE____BBBBIIIITTTTMMMMAAAAPPPP ((((CCCCAAAAEEEESSSSAAAARRRR____BBBB))))


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____FFFFAAAAIIIILLLLUUUURRRREEEE____BBBBIIIITTTTMMMMAAAAPPPP

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL CCCCAAAAEEEESSSSAAAARRRR____FFFFAAAAIIIILLLLUUUURRRREEEE____BBBBIIIITTTTMMMMAAAAPPPP ((((CCCCAAAAEEEESSSSAAAARRRR____BBBB))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____BBBBIIIITTTTMMMMAAAAPPPP CCCCAAAAEEEESSSSAAAARRRR____BBBB;;;;
        {{{{ ............ }}}}

     This function returns the value of the  failure  counter  of
     the  bitmap  pointed  to  by  CCCCAAAAEEEESSSSAAAARRRR____BBBB,  i.e., the number of
     searches that failed  (see  functions  CCCCAAAAEEEESSSSAAAARRRR____TTTTEEEESSSSTTTT____BBBBIIIITTTTMMMMAAAAPPPP(((()))),
     CCCCAAAAEEEESSSSAAAARRRR____TTTTEEEESSSSTTTT____AAAANNNNDDDD____SSSSEEEETTTT____BBBBIIIITTTTMMMMAAAAPPPP(((()))),   and  CCCCAAAAEEEESSSSAAAARRRR____TTTTEEEESSSSTTTT____AAAANNNNDDDD____RRRREEEESSSSEEEETTTT(((())))
     above).

      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____SSSSUUUUCCCCCCCCEEEESSSSSSSS____BBBBIIIITTTTMMMMAAAAPPPP

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL CCCCAAAAEEEESSSSAAAARRRR____SSSSUUUUCCCCCCCCEEEESSSSSSSS____BBBBIIIITTTTMMMMAAAAPPPP ((((CCCCAAAAEEEESSSSAAAARRRR____BBBB))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____BBBBIIIITTTTMMMMAAAAPPPP CCCCAAAAEEEESSSSAAAARRRR____BBBB;;;;
        {{{{ ............ }}}}

     This function returns the value of the  success  counter  of
     the  bitmap  pointed  to  by  CCCCAAAAEEEESSSSAAAARRRR____BBBB,  i.e., the number of
     searches that succeeded (see functions CCCCAAAAEEEESSSSAAAARRRR____TTTTEEEESSSSTTTT____BBBBIIIITTTTMMMMAAAAPPPP(((()))),
     CCCCAAAAEEEESSSSAAAARRRR____TTTTEEEESSSSTTTT____AAAANNNNDDDD____SSSSEEEETTTT____BBBBIIIITTTTMMMMAAAAPPPP(((()))),   and  CCCCAAAAEEEESSSSAAAARRRR____TTTTEEEESSSSTTTT____AAAANNNNDDDD____RRRREEEESSSSEEEETTTT(((())))
     above).

      ............................................................




(C) INRIA     Last change: 2020/02/11 (version 1.5)             6






OPEN/CAESAR MANUAL                           caesar_bitmap(LOCAL)



  CCCCAAAAEEEESSSSAAAARRRR____FFFFOOOORRRRMMMMAAAATTTT____BBBBIIIITTTTMMMMAAAAPPPP

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____FFFFOOOORRRRMMMMAAAATTTT CCCCAAAAEEEESSSSAAAARRRR____FFFFOOOORRRRMMMMAAAATTTT____BBBBIIIITTTTMMMMAAAAPPPP ((((CCCCAAAAEEEESSSSAAAARRRR____BBBB,,,, CCCCAAAAEEEESSSSAAAARRRR____FFFFOOOORRRRMMMMAAAATTTT))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____BBBBIIIITTTTMMMMAAAAPPPP CCCCAAAAEEEESSSSAAAARRRR____BBBB;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____FFFFOOOORRRRMMMMAAAATTTT CCCCAAAAEEEESSSSAAAARRRR____FFFFOOOORRRRMMMMAAAATTTT;;;;
        {{{{ ............ }}}}

     This function allows to control the format under  which  the
     bitmap  pointed  to  by CCCCAAAAEEEESSSSAAAARRRR____BBBB will be printed by the pro-
     cedure CCCCAAAAEEEESSSSAAAARRRR____PPPPRRRRIIIINNNNTTTT____BBBBIIIITTTTMMMMAAAAPPPP(((())))  (see  below).  Currently,  the
     following formats are available:


     -    With format 0, statistical information about the bitmap
          is  displayed such as: the size in bytes, the number of
          bits, the number of bits equal to 0, the number of bits
          equal  to  1, the success counter, the failure counter,
          etc.

     -    With format 1, the contents of the bitmap  are  printed
          in  hexadecimal.  This can be useful for debugging bit-
          maps of small size.

     -    With format 2, the list of bits which are equal to 0 is
          printed.  This can be useful for debugging bitmaps with
          almost all bits equal to 1.

     -    With format 3, the list of bits which are equal to 1 is
          printed.  This can be useful for debugging bitmaps with
          almost all bits equal to 0.

     -    (no other format available yet).

     By default, the current format of each bitmap is initialized
     to 0.

     When called with CCCCAAAAEEEESSSSAAAARRRR____FFFFOOOORRRRMMMMAAAATTTT between 0 and 3,  this  fonc-
     tion  sets  the  current format of CCCCAAAAEEEESSSSAAAARRRR____BBBB to CCCCAAAAEEEESSSSAAAARRRR____FFFFOOOORRRRMMMMAAAATTTT
     and returns an undefined result.

     When called with another value of CCCCAAAAEEEESSSSAAAARRRR____FFFFOOOORRRRMMMMAAAATTTT, this  func-
     tion  does  not  modify  the  current format of CCCCAAAAEEEESSSSAAAARRRR____BBBB but
     returns a result defined as  follows.  If  CCCCAAAAEEEESSSSAAAARRRR____FFFFOOOORRRRMMMMAAAATTTT  is
     equal  to  the constant CCCCAAAAEEEESSSSAAAARRRR____CCCCUUUURRRRRRRREEEENNNNTTTT____FFFFOOOORRRRMMMMAAAATTTT, the result is
     the  value  of  the   current   format   of   CCCCAAAAEEEESSSSAAAARRRR____BBBB.   If
     CCCCAAAAEEEESSSSAAAARRRR____FFFFOOOORRRRMMMMAAAATTTT      is      equal     to     the     constant
     CCCCAAAAEEEESSSSAAAARRRR____MMMMAAAAXXXXIIIIMMMMAAAALLLL____FFFFOOOORRRRMMMMAAAATTTT, the  result  is  the  maximal  format
     value  (i.e.,  3).  In  all  other cases, the effect of this
     function is undefined.

      ............................................................




(C) INRIA     Last change: 2020/02/11 (version 1.5)             7






OPEN/CAESAR MANUAL                           caesar_bitmap(LOCAL)



  CCCCAAAAEEEESSSSAAAARRRR____MMMMAAAAXXXX____FFFFOOOORRRRMMMMAAAATTTT____BBBBIIIITTTTMMMMAAAAPPPP

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____FFFFOOOORRRRMMMMAAAATTTT CCCCAAAAEEEESSSSAAAARRRR____MMMMAAAAXXXX____FFFFOOOORRRRMMMMAAAATTTT____BBBBIIIITTTTMMMMAAAAPPPP (((())))
        {{{{ ............ }}}}

     Caution! This function is deprecated. It should no longer be
     used,  as  it  might  be removed from future versions of the
     _O_P_E_N/_C_A_E_S_A_R. Use  function  CCCCAAAAEEEESSSSAAAARRRR____FFFFOOOORRRRMMMMAAAATTTT____BBBBIIIITTTTMMMMAAAAPPPP(((())))  instead,
     called with argument CCCCAAAAEEEESSSSAAAARRRR____MMMMAAAAXXXXIIIIMMMMAAAALLLL____FFFFOOOORRRRMMMMAAAATTTT.

     This function returns the maximal format value available for
     printing bitmaps.

      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____PPPPRRRRIIIINNNNTTTT____BBBBIIIITTTTMMMMAAAAPPPP

     vvvvooooiiiidddd CCCCAAAAEEEESSSSAAAARRRR____PPPPRRRRIIIINNNNTTTT____BBBBIIIITTTTMMMMAAAAPPPP ((((CCCCAAAAEEEESSSSAAAARRRR____FFFFIIIILLLLEEEE,,,, CCCCAAAAEEEESSSSAAAARRRR____BBBB))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____FFFFIIIILLLLEEEE CCCCAAAAEEEESSSSAAAARRRR____FFFFIIIILLLLEEEE;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____BBBBIIIITTTTMMMMAAAAPPPP CCCCAAAAEEEESSSSAAAARRRR____BBBB;;;;
        {{{{ ............ }}}}

     This procedure prints to file CCCCAAAAEEEESSSSAAAARRRR____FFFFIIIILLLLEEEE a character string
     containing  information  about  the  bitmap  pointed  to  by
     CCCCAAAAEEEESSSSAAAARRRR____BBBB. The nature of the information is determined by the
     current format of the bitmap pointed to by CCCCAAAAEEEESSSSAAAARRRR____BBBB.

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

     Additional information is available from the CADP  Web  page
     located at http://cadp.inria.fr



(C) INRIA     Last change: 2020/02/11 (version 1.5)             8






OPEN/CAESAR MANUAL                           caesar_bitmap(LOCAL)



     Directives   for   installation   are   given    in    files
     $$$$CCCCAAAADDDDPPPP////IIIINNNNSSSSTTTTAAAALLLLLLLLAAAATTTTIIIIOOOONNNN____****....

     Recent  changes  and  improvements  to  this  software   are
     reported and commented in file $$$$CCCCAAAADDDDPPPP////HHHHIIIISSSSTTTTOOOORRRRYYYY....

BBBBUUUUGGGGSSSS
     Known  bugs  are  described  in  the  Reference  Manual   of
     OPEN/CAESAR.  Please report new bugs to cadp@inria.fr














































(C) INRIA     Last change: 2020/02/11 (version 1.5)             9



