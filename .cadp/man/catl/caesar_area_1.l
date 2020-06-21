


OPEN/CAESAR MANUAL                           caesar_area_1(LOCAL)



NNNNAAAAMMMMEEEE
     caesar_area_1 - the ``area_1'' library of OPEN/CAESAR

PPPPUUUURRRRPPPPOOOOSSSSEEEE
     The ``area_1''  library  provides  primitives  for  managing
     ``areas'',  which  are  memory  chunks  of various sizes and
     alignment factors. This library provides for  genericity  by
     allowing   different   objects  (states,  labels,  character
     strings, user-defined memory  chunks)  to  be  handled  uni-
     formly.



UUUUSSSSAAAAGGGGEEEE
     The ``area_1'' library consists of:

     -    a predefined header file ccccaaaaeeeessssaaaarrrr____aaaarrrreeeeaaaa____1111....hhhh;

     -    the precompiled library file lllliiiibbbbccccaaaaeeeessssaaaarrrr....aaaa, which  imple-
          ments the features described in ccccaaaaeeeessssaaaarrrr____aaaarrrreeeeaaaa____1111....hhhh.

     Note: The ``area_1'' library is a software layer built above
     the  primitives  offered  by  the  ``standard'' and ``hash''
     libraries, and by the _O_P_E_N/_C_A_E_S_A_R graph module.



DDDDEEEESSSSCCCCRRRRIIIIPPPPTTTTIIIIOOOONNNN
     An ``area'' is basically a memory chunk (i.e., a sequence of
     contiguous  bytes) characterized by its (fixed) size and its
     alignment     factor     (see     the     description     of
     CCCCAAAAEEEESSSSAAAARRRR____AAAALLLLIIIIGGGGNNNNMMMMEEEENNNNTTTT____PPPPOOOOIIIINNNNTTTTEEEERRRR(((()))) in the ``standard'' library for a
     definition of the alignment factor).

     There are five different kinds of areas:

     -    an ``ordinary area'' may contain any kind of data;  the
          precise  contents  of  an  ordinary area is left to the
          user and  is  not  specified  in  the  context  of  the
          ``area_1'' library;

     -    an ``empty area'' is a special area of zero bytes;

     -    a ``state area'' is a special area dedicated to contain
          a  state,  as  described  in  the graph module, i.e., a
          value of type CCCCAAAAEEEESSSSAAAARRRR____BBBBOOOODDDDYYYY____SSSSTTTTAAAATTTTEEEE;

     -    a ``label area'' is a special area dedicated to contain
          a  label,  as  described  in  the graph module, i.e., a
          value of type CCCCAAAAEEEESSSSAAAARRRR____BBBBOOOODDDDYYYY____LLLLAAAABBBBEEEELLLL;

     -    a ``string  area''  is  a  special  area  dedicated  to



(C) INRIA     Last change: 2020/02/11 (version 1.1)             1






OPEN/CAESAR MANUAL                           caesar_area_1(LOCAL)



          contain   a  pointer  to  a  null-terminated  character
          string,  i.e.,  a  value  of  type  CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSTTTTRRRRIIIINNNNGGGG.
          Notice  that a string area does not contain a (variable
          length) character string but a (fixed  length)  pointer
          to a (variable length) character string.

FFFFEEEEAAAATTTTUUUURRRREEEESSSS
      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____AAAARRRREEEEAAAA____1111

     ttttyyyyppppeeeeddddeeeeffff CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____AAAARRRREEEEAAAA____1111;;;;
     ####ddddeeeeffffiiiinnnneeee CCCCAAAAEEEESSSSAAAARRRR____EEEEXXXXPPPPOOOONNNNEEEENNNNTTTT____EEEEMMMMPPPPTTTTYYYY____AAAARRRREEEEAAAA____1111     0000
     ####ddddeeeeffffiiiinnnneeee CCCCAAAAEEEESSSSAAAARRRR____EEEEXXXXPPPPOOOONNNNEEEENNNNTTTT____SSSSTTTTAAAATTTTEEEE____AAAARRRREEEEAAAA____1111     1111
     ####ddddeeeeffffiiiinnnneeee CCCCAAAAEEEESSSSAAAARRRR____EEEEXXXXPPPPOOOONNNNEEEENNNNTTTT____LLLLAAAABBBBEEEELLLL____AAAARRRREEEEAAAA____1111     2222
     ####ddddeeeeffffiiiinnnneeee CCCCAAAAEEEESSSSAAAARRRR____EEEEXXXXPPPPOOOONNNNEEEENNNNTTTT____SSSSTTTTRRRRIIIINNNNGGGG____AAAARRRREEEEAAAA____1111    3333

     Concretely, the type CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____AAAARRRREEEEAAAA____1111 is represented as  a
     numerical type (32-bit or 64-bit natural number depending on
     the  machine  architecture).  Logically,  a  value  of  type
     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____AAAARRRREEEEAAAA____1111 is a pair (length field, exponent field),
     where:


     -    the exponent field is an unsigned natural number  coded
          on the 4 highest bits (thus, in the range 0..15), and

     -    the length field is an unsigned natural number coded on
          the  remaining  (all  but  4) lowest bits, i.e., either
          coded  on   28   bits   (and   thus,   in   the   range
          0...268,435,455)  on  32-bit  machines,  or coded on 60
          bits      (and      thus,      in       the       range
          0...1,152,921,504,606,846,975) on 64-bit machines.

     The different kinds of areas are represented as follows:


     -    for an ordinary area, the  length  field  is  different
          from  zero  and  represents  the size (in bytes) of the
          area; if the exponent field is equal to a value f  dif-
          ferent  from  zero,  the alignment factor (in bytes) of
          the area is equal to 2^{f-1}; the  case  in  which  the
          exponent  field is equal to zero corresponds to a back-
          ward compatibility situation, which is now obsolete and
          in  which  the  alignment factor is guessed empirically
          from the value of the length field (see the  definition
          of CCCCAAAAEEEESSSSAAAARRRR____AAAALLLLIIIIGGGGNNNNMMMMEEEENNNNTTTT____AAAARRRREEEEAAAA____1111(((()))) below);

     -    for an empty area, the length field is  equal  to  zero
          and  the  exponent  field  is  equal  to  the  constant
          CCCCAAAAEEEESSSSAAAARRRR____EEEEXXXXPPPPOOOONNNNEEEENNNNTTTT____EEEEMMMMPPPPTTTTYYYY____AAAARRRREEEEAAAA____1111;




(C) INRIA     Last change: 2020/02/11 (version 1.1)             2






OPEN/CAESAR MANUAL                           caesar_area_1(LOCAL)



     -    for a state area, the length field is equal to zero and
          the   exponent   field   is   equal   to  the  constant
          CCCCAAAAEEEESSSSAAAARRRR____EEEEXXXXPPPPOOOONNNNEEEENNNNTTTT____SSSSTTTTAAAATTTTEEEE____AAAARRRREEEEAAAA____1111;

     -    for a label area, the length field is equal to zero and
          the   exponent   field   is   equal   to  the  constant
          CCCCAAAAEEEESSSSAAAARRRR____EEEEXXXXPPPPOOOONNNNEEEENNNNTTTT____LLLLAAAABBBBEEEELLLL____AAAARRRREEEEAAAA____1111;

     -    for a string area, the length field is  equal  to  zero
          and  the  exponent  field  is  equal  to  the  constant
          CCCCAAAAEEEESSSSAAAARRRR____EEEEXXXXPPPPOOOONNNNEEEENNNNTTTT____SSSSTTTTRRRRIIIINNNNGGGG____AAAARRRREEEEAAAA____1111;

     -    any other case in which the length field  is  equal  to
          zero is undefined.

      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____LLLLEEEENNNNGGGGTTTTHHHH____AAAARRRREEEEAAAA____1111

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL CCCCAAAAEEEESSSSAAAARRRR____LLLLEEEENNNNGGGGTTTTHHHH____AAAARRRREEEEAAAA____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____AAAARRRREEEEAAAA))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____AAAARRRREEEEAAAA____1111 CCCCAAAAEEEESSSSAAAARRRR____AAAARRRREEEEAAAA;;;;
        {{{{ ............ }}}}

     This  function  returns  the  length  field  of   the   area
     CCCCAAAAEEEESSSSAAAARRRR____AAAARRRREEEEAAAA.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____EEEEXXXXPPPPOOOONNNNEEEENNNNTTTT____AAAARRRREEEEAAAA____1111

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL CCCCAAAAEEEESSSSAAAARRRR____EEEEXXXXPPPPOOOONNNNEEEENNNNTTTT____AAAARRRREEEEAAAA____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____AAAARRRREEEEAAAA))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____AAAARRRREEEEAAAA____1111 CCCCAAAAEEEESSSSAAAARRRR____AAAARRRREEEEAAAA;;;;
        {{{{ ............ }}}}

     This  function  returns  the  exponent  field  of  the  area
     CCCCAAAAEEEESSSSAAAARRRR____AAAARRRREEEEAAAA.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____AAAARRRREEEEAAAA____1111

     CCCCAAAAEEEESSSSAAAARRRR____AAAARRRREEEEAAAA____1111 CCCCAAAAEEEESSSSAAAARRRR____AAAARRRREEEEAAAA____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____LLLLEEEENNNNGGGGTTTTHHHH,,,, CCCCAAAAEEEESSSSAAAARRRR____EEEEXXXXPPPPOOOONNNNEEEENNNNTTTT))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL CCCCAAAAEEEESSSSAAAARRRR____LLLLEEEENNNNGGGGTTTTHHHH;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL CCCCAAAAEEEESSSSAAAARRRR____EEEEXXXXPPPPOOOONNNNEEEENNNNTTTT;;;;
        {{{{ ............ }}}}

     This function returns the area with a length field equal  to
     CCCCAAAAEEEESSSSAAAARRRR____LLLLEEEENNNNGGGGTTTTHHHH    and    an    exponent    field   equal   to
     CCCCAAAAEEEESSSSAAAARRRR____EEEEXXXXPPPPOOOONNNNEEEENNNNTTTT.




(C) INRIA     Last change: 2020/02/11 (version 1.1)             3






OPEN/CAESAR MANUAL                           caesar_area_1(LOCAL)



     Note: this function does not check that its  parameters  are
     consistent,  e.g.,  that  for an ordinary area the alignment
     (specified by the exponent field) is an exact divider of the
     size (specified by the length field).


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____EEEEMMMMPPPPTTTTYYYY____AAAARRRREEEEAAAA____1111

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____AAAARRRREEEEAAAA____1111 CCCCAAAAEEEESSSSAAAARRRR____EEEEMMMMPPPPTTTTYYYY____AAAARRRREEEEAAAA____1111 (((())))
        {{{{ ............ }}}}

     This function returns the area with a length field equal  to
     0      and      an      exponent      field     equal     to
     CCCCAAAAEEEESSSSAAAARRRR____EEEEXXXXPPPPOOOONNNNEEEENNNNTTTT____EEEEMMMMPPPPTTTTYYYY____AAAARRRREEEEAAAA____1111  (i.e.,  corresponding  to   an
     empty area).

     Note:     For      backward      compatibility      reasons,
     CCCCAAAAEEEESSSSAAAARRRR____EEEEMMMMPPPPTTTTYYYY____AAAARRRREEEEAAAA____1111(((()))) is equal to 0.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____SSSSTTTTAAAATTTTEEEE____AAAARRRREEEEAAAA____1111

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____AAAARRRREEEEAAAA____1111 CCCCAAAAEEEESSSSAAAARRRR____SSSSTTTTAAAATTTTEEEE____AAAARRRREEEEAAAA____1111 (((())))
        {{{{ ............ }}}}

     This function returns the area with a length field equal  to
     0      and      an      exponent      field     equal     to
     CCCCAAAAEEEESSSSAAAARRRR____EEEEXXXXPPPPOOOONNNNEEEENNNNTTTT____SSSSTTTTAAAATTTTEEEE____AAAARRRREEEEAAAA____1111 (i.e., corresponding to a state
     area).


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____LLLLAAAABBBBEEEELLLL____AAAARRRREEEEAAAA____1111

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____AAAARRRREEEEAAAA____1111 CCCCAAAAEEEESSSSAAAARRRR____LLLLAAAABBBBEEEELLLL____AAAARRRREEEEAAAA____1111 (((())))
        {{{{ ............ }}}}

     This function returns the area with a length field equal  to
     0      and      an      exponent      field     equal     to
     CCCCAAAAEEEESSSSAAAARRRR____EEEEXXXXPPPPOOOONNNNEEEENNNNTTTT____LLLLAAAABBBBEEEELLLL____AAAARRRREEEEAAAA____1111 (i.e., corresponding to a label
     area).


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____SSSSTTTTRRRRIIIINNNNGGGG____AAAARRRREEEEAAAA____1111




(C) INRIA     Last change: 2020/02/11 (version 1.1)             4






OPEN/CAESAR MANUAL                           caesar_area_1(LOCAL)



     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____AAAARRRREEEEAAAA____1111 CCCCAAAAEEEESSSSAAAARRRR____SSSSTTTTRRRRIIIINNNNGGGG____AAAARRRREEEEAAAA____1111 (((())))
        {{{{ ............ }}}}

     This function returns the area with a length field equal  to
     0      and      an      exponent      field     equal     to
     CCCCAAAAEEEESSSSAAAARRRR____EEEEXXXXPPPPOOOONNNNEEEENNNNTTTT____SSSSTTTTRRRRIIIINNNNGGGG____AAAARRRREEEEAAAA____1111  (i.e.,  corresponding  to   a
     string area).


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____BBBBYYYYTTTTEEEE____AAAARRRREEEEAAAA____1111

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____AAAARRRREEEEAAAA____1111 CCCCAAAAEEEESSSSAAAARRRR____BBBBYYYYTTTTEEEE____AAAARRRREEEEAAAA____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____LLLLEEEENNNNGGGGTTTTHHHH))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL CCCCAAAAEEEESSSSAAAARRRR____LLLLEEEENNNNGGGGTTTTHHHH;;;;
        {{{{ ............ }}}}

     This function returns the area with a length field equal  to
     CCCCAAAAEEEESSSSAAAARRRR____LLLLEEEENNNNGGGGTTTTHHHH  and an exponent field corresponding to a byte
     or a character (i.e., a memory area with an alignment of 1).


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____NNNNAAAATTTTUUUURRRRAAAALLLL____AAAARRRREEEEAAAA____1111

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____AAAARRRREEEEAAAA____1111 CCCCAAAAEEEESSSSAAAARRRR____NNNNAAAATTTTUUUURRRRAAAALLLL____AAAARRRREEEEAAAA____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____LLLLEEEENNNNGGGGTTTTHHHH))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL CCCCAAAAEEEESSSSAAAARRRR____LLLLEEEENNNNGGGGTTTTHHHH;;;;
        {{{{ ............ }}}}

     This function returns the area with a length field equal  to
     CCCCAAAAEEEESSSSAAAARRRR____LLLLEEEENNNNGGGGTTTTHHHH  and  an  exponent  field  corresponding  to a
     natural or integer number  (i.e.,  a  memory  area  with  an
     alignment  suitable  for a value of type CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL
     or CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____IIIINNNNTTTTEEEEGGGGEEEERRRR).

     Note:  In  principle,  such  an  area  should  not   contain
     pointers.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____PPPPOOOOIIIINNNNTTTTEEEERRRR____AAAARRRREEEEAAAA____1111

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____AAAARRRREEEEAAAA____1111 CCCCAAAAEEEESSSSAAAARRRR____PPPPOOOOIIIINNNNTTTTEEEERRRR____AAAARRRREEEEAAAA____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____LLLLEEEENNNNGGGGTTTTHHHH))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL CCCCAAAAEEEESSSSAAAARRRR____LLLLEEEENNNNGGGGTTTTHHHH;;;;
        {{{{ ............ }}}}

     This function returns the area with a length field equal  to
     CCCCAAAAEEEESSSSAAAARRRR____LLLLEEEENNNNGGGGTTTTHHHH  and  an  exponent  field  corresponding  to a
     pointer (i.e., a memory area  with  an  alignment  equal  to
     CCCCAAAAEEEESSSSAAAARRRR____AAAALLLLIIIIGGGGNNNNMMMMEEEENNNNTTTT____PPPPOOOOIIIINNNNTTTTEEEERRRR(((())))).



(C) INRIA     Last change: 2020/02/11 (version 1.1)             5






OPEN/CAESAR MANUAL                           caesar_area_1(LOCAL)



     Note: In principle, such an area should contain at least one
     pointer,  because pointers usually have the strongest align-
     ment constraints.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____SSSSIIIIZZZZEEEE____AAAARRRREEEEAAAA____1111

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL CCCCAAAAEEEESSSSAAAARRRR____SSSSIIIIZZZZEEEE____AAAARRRREEEEAAAA____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____AAAARRRREEEEAAAA))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____AAAARRRREEEEAAAA____1111 CCCCAAAAEEEESSSSAAAARRRR____AAAARRRREEEEAAAA;;;;
        {{{{ ............ }}}}

     This function returns  the  size  (in  bytes)  of  the  area
     CCCCAAAAEEEESSSSAAAARRRR____AAAARRRREEEEAAAA:

     -    for an ordinary area, this size is equal to the  length
          field of CCCCAAAAEEEESSSSAAAARRRR____AAAARRRREEEEAAAA;

     -    for an empty area, this size is equal to zero;

     -    for  a  state  area,  this  size  is   given   by   the
          CCCCAAAAEEEESSSSAAAARRRR____SSSSIIIIZZZZEEEE____SSSSTTTTAAAATTTTEEEE(((())))  function  exported  by  the  graph
          module;

     -    for  a  label  area,  this  size  is   given   by   the
          CCCCAAAAEEEESSSSAAAARRRR____SSSSIIIIZZZZEEEE____LLLLAAAABBBBEEEELLLL(((())))  function  exported  by  the  graph
          module;

     -    for  a   string   area,   this   size   is   equal   to
          CCCCAAAAEEEESSSSAAAARRRR____SSSSIIIIZZZZEEEE____PPPPOOOOIIIINNNNTTTTEEEERRRR(((()))) (which corresponds to the size of
          a character string pointer).

      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____HHHHAAAASSSSHHHH____SSSSIIIIZZZZEEEE____AAAARRRREEEEAAAA____1111

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL CCCCAAAAEEEESSSSAAAARRRR____HHHHAAAASSSSHHHH____SSSSIIIIZZZZEEEE____AAAARRRREEEEAAAA____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____AAAARRRREEEEAAAA))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____AAAARRRREEEEAAAA____1111 CCCCAAAAEEEESSSSAAAARRRR____AAAARRRREEEEAAAA;;;;
        {{{{ ............ }}}}

     This function returns the ``hashable'' size  (in  bytes)  of
     the area CCCCAAAAEEEESSSSAAAARRRR____AAAARRRREEEEAAAA:

     -    for an ordinary area, this size is equal to the  length
          field  of CCCCAAAAEEEESSSSAAAARRRR____AAAARRRREEEEAAAA (this is an arbitrary definition,
          since the actual contents of CCCCAAAAEEEESSSSAAAARRRR____AAAARRRREEEEAAAA are unknown);

     -    for an empty area, this size is equal  to  zero  (which
          expresses  the fact that an empty area is not appropri-
          ate for hashing);




(C) INRIA     Last change: 2020/02/11 (version 1.1)             6






OPEN/CAESAR MANUAL                           caesar_area_1(LOCAL)



     -    for  a  state  area,  this  size  is   given   by   the
          CCCCAAAAEEEESSSSAAAARRRR____HHHHAAAASSSSHHHH____SSSSIIIIZZZZEEEE____SSSSTTTTAAAATTTTEEEE(((()))) function exported by the graph
          module;

     -    for  a  label  area,  this  size  is   given   by   the
          CCCCAAAAEEEESSSSAAAARRRR____HHHHAAAASSSSHHHH____SSSSIIIIZZZZEEEE____LLLLAAAABBBBEEEELLLL(((()))) function exported by the graph
          module;

     -    for a string area, this size is equal  to  zero  (which
          expresses  the  fact  that  a character string pointer,
          i.e., a value of type ((((CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSTTTTRRRRIIIINNNNGGGG  ****)))),  is  not
          directly appropriate for hashing).

      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____AAAALLLLIIIIGGGGNNNNMMMMEEEENNNNTTTT____AAAARRRREEEEAAAA____1111

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL CCCCAAAAEEEESSSSAAAARRRR____AAAALLLLIIIIGGGGNNNNMMMMEEEENNNNTTTT____AAAARRRREEEEAAAA____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____AAAARRRREEEEAAAA))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____AAAARRRREEEEAAAA____1111 CCCCAAAAEEEESSSSAAAARRRR____AAAARRRREEEEAAAA;;;;
        {{{{ ............ }}}}

     This function returns the alignment factor (in bytes) of the
     area CCCCAAAAEEEESSSSAAAARRRR____AAAARRRREEEEAAAA:

     -    for an ordinary area whose exponent  field  f  is  dif-
          ferent  from  zero,  the  alignment  factor is equal to
          2^{f-1};

     -    for an ordinary area whose exponent field is  equal  to
          zero  (backward compatibility case), the alignment fac-
          tor is guessed empirically from the size of CCCCAAAAEEEESSSSAAAARRRR____AAAARRRREEEEAAAA
          (precisely,  the  alignment  factor will be the largest
          value in the set {1, 2, 4, 8} that divides the size  of
          CCCCAAAAEEEESSSSAAAARRRR____AAAARRRREEEEAAAA  exactly;  this is an arbitrary definition,
          since the actual contents of CCCCAAAAEEEESSSSAAAARRRR____AAAARRRREEEEAAAA are unknown);

     -    for an empty area, this alignment factor  is  equal  to
          one (which expresses the fact that an empty area has no
          specific alignment constraint);

     -    for a state area, this alignment factor is given by the
          CCCCAAAAEEEESSSSAAAARRRR____AAAALLLLIIIIGGGGNNNNMMMMEEEENNNNTTTT____SSSSTTTTAAAATTTTEEEE(((()))) function exported by the graph
          module;

     -    for a label area, this alignment factor is given by the
          CCCCAAAAEEEESSSSAAAARRRR____AAAALLLLIIIIGGGGNNNNMMMMEEEENNNNTTTT____LLLLAAAABBBBEEEELLLL(((()))) function exported by the graph
          module;

     -    for a string area, this alignment factor  is  equal  to
          CCCCAAAAEEEESSSSAAAARRRR____AAAALLLLIIIIGGGGNNNNMMMMEEEENNNNTTTT____PPPPOOOOIIIINNNNTTTTEEEERRRR(((())))  (which  corresponds  to the
          alignment factor of a character string pointer).




(C) INRIA     Last change: 2020/02/11 (version 1.1)             7






OPEN/CAESAR MANUAL                           caesar_area_1(LOCAL)



      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____CCCCOOOOPPPPYYYY____AAAARRRREEEEAAAA____1111

     vvvvooooiiiidddd CCCCAAAAEEEESSSSAAAARRRR____CCCCOOOOPPPPYYYY____AAAARRRREEEEAAAA____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____PPPP1111,,,, CCCCAAAAEEEESSSSAAAARRRR____PPPP2222,,,, CCCCAAAAEEEESSSSAAAARRRR____SSSSIIIIZZZZEEEE))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____PPPPOOOOIIIINNNNTTTTEEEERRRR CCCCAAAAEEEESSSSAAAARRRR____PPPP1111;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____PPPPOOOOIIIINNNNTTTTEEEERRRR CCCCAAAAEEEESSSSAAAARRRR____PPPP2222;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL CCCCAAAAEEEESSSSAAAARRRR____SSSSIIIIZZZZEEEE;;;;
        {{{{ ............ }}}}

     This procedure copies the memory area (of CCCCAAAAEEEESSSSAAAARRRR____SSSSIIIIZZZZEEEE bytes)
     pointed  to  by  CCCCAAAAEEEESSSSAAAARRRR____PPPP2222  to  the  location  pointed to by
     CCCCAAAAEEEESSSSAAAARRRR____PPPP1111.

     Note: This function is implemented as a simple  wrapper  for
     the POSIX function mmmmeeeemmmmccccppppyyyy((((3333)))).


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____CCCCOOOOMMMMPPPPAAAARRRREEEE____EEEEMMMMPPPPTTTTYYYY____AAAARRRREEEEAAAA____1111

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____BBBBOOOOOOOOLLLLEEEEAAAANNNN CCCCAAAAEEEESSSSAAAARRRR____CCCCOOOOMMMMPPPPAAAARRRREEEE____EEEEMMMMPPPPTTTTYYYY____AAAARRRREEEEAAAA____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____PPPP1111,,,, CCCCAAAAEEEESSSSAAAARRRR____PPPP2222))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____PPPPOOOOIIIINNNNTTTTEEEERRRR CCCCAAAAEEEESSSSAAAARRRR____PPPP1111;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____PPPPOOOOIIIINNNNTTTTEEEERRRR CCCCAAAAEEEESSSSAAAARRRR____PPPP2222;;;;
        {{{{ ............ }}}}

     This function is intended to compare two  empty  areas  and,
     thus,  always  returns a value different from 0 (since there
     is only one empty area).

     Note:     this     function     is     used      by      the
     CCCCAAAAEEEESSSSAAAARRRR____UUUUSSSSEEEE____CCCCOOOOMMMMPPPPAAAARRRREEEE____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN____AAAARRRREEEEAAAA____1111(((())))    function   described
     below.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____CCCCOOOOMMMMPPPPAAAARRRREEEE____SSSSTTTTRRRRIIIINNNNGGGG____AAAARRRREEEEAAAA____1111

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____BBBBOOOOOOOOLLLLEEEEAAAANNNN CCCCAAAAEEEESSSSAAAARRRR____CCCCOOOOMMMMPPPPAAAARRRREEEE____SSSSTTTTRRRRIIIINNNNGGGG____AAAARRRREEEEAAAA____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____SSSS1111,,,, CCCCAAAAEEEESSSSAAAARRRR____SSSS2222))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSTTTTRRRRIIIINNNNGGGG ****CCCCAAAAEEEESSSSAAAARRRR____SSSS1111;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSTTTTRRRRIIIINNNNGGGG ****CCCCAAAAEEEESSSSAAAARRRR____SSSS2222;;;;
        {{{{ ............ }}}}

     This function returns a value different from 0 if both char-
     acter  strings  pointed  to by ****CCCCAAAAEEEESSSSAAAARRRR____SSSS1111 and ****CCCCAAAAEEEESSSSAAAARRRR____SSSS2222 are
     identical, or 0 if they are not.

     Note: This function uses the POSIX function ssssttttrrrrccccmmmmpppp((((3333)))).

     Note:     this     function     is     used      by      the



(C) INRIA     Last change: 2020/02/11 (version 1.1)             8






OPEN/CAESAR MANUAL                           caesar_area_1(LOCAL)



     CCCCAAAAEEEESSSSAAAARRRR____UUUUSSSSEEEE____CCCCOOOOMMMMPPPPAAAARRRREEEE____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN____AAAARRRREEEEAAAA____1111(((())))    function   described
     below.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____UUUUSSSSEEEE____CCCCOOOOMMMMPPPPAAAARRRREEEE____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN____AAAARRRREEEEAAAA____1111

     vvvvooooiiiidddd CCCCAAAAEEEESSSSAAAARRRR____UUUUSSSSEEEE____CCCCOOOOMMMMPPPPAAAARRRREEEE____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN____AAAARRRREEEEAAAA____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____AAAARRRREEEEAAAA,,,, CCCCAAAAEEEESSSSAAAARRRR____CCCCOOOOMMMMPPPPAAAARRRREEEE____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____AAAARRRREEEEAAAA____1111 CCCCAAAAEEEESSSSAAAARRRR____AAAARRRREEEEAAAA;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____CCCCOOOOMMMMPPPPAAAARRRREEEE____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN ****CCCCAAAAEEEESSSSAAAARRRR____CCCCOOOOMMMMPPPPAAAARRRREEEE____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN;;;;
        {{{{ ............ }}}}

     This procedure modifies the (function pointer) value pointed
     to  by  ****CCCCAAAAEEEESSSSAAAARRRR____CCCCOOOOMMMMPPPPAAAARRRREEEE____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN  (possibly  to  assign this
     function pointer a default value if  it  is  equal  to  NNNNUUUULLLLLLLL
     before the procedure is invoked) in the following cases:


     -    if   CCCCAAAAEEEESSSSAAAARRRR____AAAARRRREEEEAAAA   is   an   empty    area    and    if
          ****CCCCAAAAEEEESSSSAAAARRRR____CCCCOOOOMMMMPPPPAAAARRRREEEE____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN  is  equal  to  NNNNUUUULLLLLLLL, then the
          CCCCAAAAEEEESSSSAAAARRRR____CCCCOOOOMMMMPPPPAAAARRRREEEE____EEEEMMMMPPPPTTTTYYYY____AAAARRRREEEEAAAA____1111(((())))  function  defined  above
          will be assigned to ****CCCCAAAAEEEESSSSAAAARRRR____CCCCOOOOMMMMPPPPAAAARRRREEEE____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN;

          Note: it is not  allowed  to  call  this  procedure  if
          CCCCAAAAEEEESSSSAAAARRRR____AAAARRRREEEEAAAA     is    an    empty    area,    and    if
          ****CCCCAAAAEEEESSSSAAAARRRR____CCCCOOOOMMMMPPPPAAAARRRREEEE____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN is different  from  both  NNNNUUUULLLLLLLL
          and  CCCCAAAAEEEESSSSAAAARRRR____CCCCOOOOMMMMPPPPAAAARRRREEEE____EEEEMMMMPPPPTTTTYYYY____AAAARRRREEEEAAAA____1111(((()))),  since in this case
          CCCCAAAAEEEESSSSAAAARRRR____CCCCOOOOMMMMPPPPAAAARRRREEEE____EEEEMMMMPPPPTTTTYYYY____AAAARRRREEEEAAAA____1111(((()))) is the only sensible com-
          parison function;

     -    if   CCCCAAAAEEEESSSSAAAARRRR____AAAARRRREEEEAAAA   is   a    state    area    and    if
          ****CCCCAAAAEEEESSSSAAAARRRR____CCCCOOOOMMMMPPPPAAAARRRREEEE____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN  is  equal  to  NNNNUUUULLLLLLLL, then the
          CCCCAAAAEEEESSSSAAAARRRR____CCCCOOOOMMMMPPPPAAAARRRREEEE____SSSSTTTTAAAATTTTEEEE(((()))) function  of  the  graph  module
          will be assigned to ****CCCCAAAAEEEESSSSAAAARRRR____CCCCOOOOMMMMPPPPAAAARRRREEEE____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN;

          Note: it is not  allowed  to  call  this  procedure  if
          CCCCAAAAEEEESSSSAAAARRRR____AAAARRRREEEEAAAA     is     a    state    area,    and    if
          ****CCCCAAAAEEEESSSSAAAARRRR____CCCCOOOOMMMMPPPPAAAARRRREEEE____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN is different  from  both  NNNNUUUULLLLLLLL
          and   CCCCAAAAEEEESSSSAAAARRRR____CCCCOOOOMMMMPPPPAAAARRRREEEE____SSSSTTTTAAAATTTTEEEE(((()))),  and  if  the  result  of
          CCCCAAAAEEEESSSSAAAARRRR____HHHHAAAASSSSHHHH____SSSSIIIIZZZZEEEE____SSSSTTTTAAAATTTTEEEE(((())))  is  strictly  less  than  the
          result  of  CCCCAAAAEEEESSSSAAAARRRR____SSSSIIIIZZZZEEEE____SSSSTTTTAAAATTTTEEEE(((()))),  since  in  this  case
          CCCCAAAAEEEESSSSAAAARRRR____CCCCOOOOMMMMPPPPAAAARRRREEEE____SSSSTTTTAAAATTTTEEEE(((()))) is the only sensible  comparison
          function;

     -    if   CCCCAAAAEEEESSSSAAAARRRR____AAAARRRREEEEAAAA   is   a    label    area    and    if
          ****CCCCAAAAEEEESSSSAAAARRRR____CCCCOOOOMMMMPPPPAAAARRRREEEE____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN  is  equal  to  NNNNUUUULLLLLLLL, then the
          CCCCAAAAEEEESSSSAAAARRRR____CCCCOOOOMMMMPPPPAAAARRRREEEE____LLLLAAAABBBBEEEELLLL(((()))) function  of  the  graph  module
          will be assigned to ****CCCCAAAAEEEESSSSAAAARRRR____CCCCOOOOMMMMPPPPAAAARRRREEEE____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN;

          Note: it is not  allowed  to  call  this  procedure  if
          CCCCAAAAEEEESSSSAAAARRRR____AAAARRRREEEEAAAA     is     a    label    area,    and    if



(C) INRIA     Last change: 2020/02/11 (version 1.1)             9






OPEN/CAESAR MANUAL                           caesar_area_1(LOCAL)



          ****CCCCAAAAEEEESSSSAAAARRRR____CCCCOOOOMMMMPPPPAAAARRRREEEE____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN is different  from  both  NNNNUUUULLLLLLLL
          and   CCCCAAAAEEEESSSSAAAARRRR____CCCCOOOOMMMMPPPPAAAARRRREEEE____LLLLAAAABBBBEEEELLLL(((()))),  and  if  the  result  of
          CCCCAAAAEEEESSSSAAAARRRR____HHHHAAAASSSSHHHH____SSSSIIIIZZZZEEEE____LLLLAAAABBBBEEEELLLL(((())))  is  strictly  less  than  the
          result  of  CCCCAAAAEEEESSSSAAAARRRR____SSSSIIIIZZZZEEEE____LLLLAAAABBBBEEEELLLL(((()))),  since  in  this  case
          CCCCAAAAEEEESSSSAAAARRRR____CCCCOOOOMMMMPPPPAAAARRRREEEE____LLLLAAAABBBBEEEELLLL(((()))) is the only sensible  comparison
          function;

     -    if   CCCCAAAAEEEESSSSAAAARRRR____AAAARRRREEEEAAAA   is   a   string    area    and    if
          ****CCCCAAAAEEEESSSSAAAARRRR____CCCCOOOOMMMMPPPPAAAARRRREEEE____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN  is  equal  to  NNNNUUUULLLLLLLL, then the
          CCCCAAAAEEEESSSSAAAARRRR____CCCCOOOOMMMMPPPPAAAARRRREEEE____SSSSTTTTRRRRIIIINNNNGGGG____AAAARRRREEEEAAAA____1111(((()))) function  defined  above
          will be assigned to ****CCCCAAAAEEEESSSSAAAARRRR____CCCCOOOOMMMMPPPPAAAARRRREEEE____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN.

     In  any  other  case,   ****CCCCAAAAEEEESSSSAAAARRRR____CCCCOOOOMMMMPPPPAAAARRRREEEE____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN   is   kept
     unchanged.



      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____CCCCOOOOMMMMPPPPAAAARRRREEEE____AAAARRRREEEEAAAA____1111

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____BBBBOOOOOOOOLLLLEEEEAAAANNNN CCCCAAAAEEEESSSSAAAARRRR____CCCCOOOOMMMMPPPPAAAARRRREEEE____AAAARRRREEEEAAAA____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____CCCCOOOOMMMMPPPPAAAARRRREEEE____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN,,,,
                                                CCCCAAAAEEEESSSSAAAARRRR____PPPP1111,,,, CCCCAAAAEEEESSSSAAAARRRR____PPPP2222,,,, CCCCAAAAEEEESSSSAAAARRRR____SSSSIIIIZZZZEEEE))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____CCCCOOOOMMMMPPPPAAAARRRREEEE____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN CCCCAAAAEEEESSSSAAAARRRR____CCCCOOOOMMMMPPPPAAAARRRREEEE____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____PPPPOOOOIIIINNNNTTTTEEEERRRR CCCCAAAAEEEESSSSAAAARRRR____PPPP1111;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____PPPPOOOOIIIINNNNTTTTEEEERRRR CCCCAAAAEEEESSSSAAAARRRR____PPPP2222;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL CCCCAAAAEEEESSSSAAAARRRR____SSSSIIIIZZZZEEEE;;;;
        {{{{ ............ }}}}

     This function compares the two memory areas (of  CCCCAAAAEEEESSSSAAAARRRR____SSSSIIIIZZZZEEEE
     bytes)  pointed  to  by CCCCAAAAEEEESSSSAAAARRRR____PPPP1111 and CCCCAAAAEEEESSSSAAAARRRR____PPPP2222 using either
     CCCCAAAAEEEESSSSAAAARRRR____CCCCOOOOMMMMPPPPAAAARRRREEEE____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN if  this  function  pointer  is  not
     NNNNUUUULLLLLLLL,  or the POSIX function mmmmeeeemmmmccccmmmmpppp((((3333)))) otherwise. The result
     is CCCCAAAAEEEESSSSAAAARRRR____TTTTRRRRUUUUEEEE if and only if both memory areas are found to
     be equal.  Note: Before calling CCCCAAAAEEEESSSSAAAARRRR____CCCCOOOOMMMMPPPPAAAARRRREEEE____AAAARRRREEEEAAAA____1111(((()))), the
     actual value of CCCCAAAAEEEESSSSAAAARRRR____CCCCOOOOMMMMPPPPAAAARRRREEEE____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN should have been set
     by  calling  the  CCCCAAAAEEEESSSSAAAARRRR____UUUUSSSSEEEE____CCCCOOOOMMMMPPPPAAAARRRREEEE____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN____AAAARRRREEEEAAAA____1111(((()))) func-
     tion.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____HHHHAAAASSSSHHHH____EEEEMMMMPPPPTTTTYYYY____AAAARRRREEEEAAAA____1111

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____BBBBOOOOOOOOLLLLEEEEAAAANNNN CCCCAAAAEEEESSSSAAAARRRR____HHHHAAAASSSSHHHH____EEEEMMMMPPPPTTTTYYYY____AAAARRRREEEEAAAA____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____PPPP,,,, CCCCAAAAEEEESSSSAAAARRRR____MMMMOOOODDDDUUUULLLLUUUUSSSS))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____PPPPOOOOIIIINNNNTTTTEEEERRRR CCCCAAAAEEEESSSSAAAARRRR____PPPP;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL CCCCAAAAEEEESSSSAAAARRRR____MMMMOOOODDDDUUUULLLLUUUUSSSS;;;;
        {{{{ ............ }}}}

     This function is intended to compute an hash-value on  empty
     areas  and,  thus, always returns 0 (since there is only one
     empty area). If CCCCAAAAEEEESSSSAAAARRRR____MMMMOOOODDDDUUUULLLLUUUUSSSS is equal to 0, the result  is



(C) INRIA     Last change: 2020/02/11 (version 1.1)            10






OPEN/CAESAR MANUAL                           caesar_area_1(LOCAL)



     undefined.

     Note:     this     function     is     used      by      the
     CCCCAAAAEEEESSSSAAAARRRR____UUUUSSSSEEEE____HHHHAAAASSSSHHHH____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN____AAAARRRREEEEAAAA____1111(((()))) function described below.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____HHHHAAAASSSSHHHH____SSSSTTTTRRRRIIIINNNNGGGG____AAAARRRREEEEAAAA____1111

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____BBBBOOOOOOOOLLLLEEEEAAAANNNN CCCCAAAAEEEESSSSAAAARRRR____HHHHAAAASSSSHHHH____SSSSTTTTRRRRIIIINNNNGGGG____AAAARRRREEEEAAAA____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____PPPP,,,, CCCCAAAAEEEESSSSAAAARRRR____MMMMOOOODDDDUUUULLLLUUUUSSSS))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____PPPPOOOOIIIINNNNTTTTEEEERRRR CCCCAAAAEEEESSSSAAAARRRR____PPPP;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL CCCCAAAAEEEESSSSAAAARRRR____MMMMOOOODDDDUUUULLLLUUUUSSSS;;;;
        {{{{ ............ }}}}

     This function is intended to compute an hash-value on string
     areas.  It  returns a value in the range 0..(CCCCAAAAEEEESSSSAAAARRRR____MMMMOOOODDDDUUUULLLLUUUUSSSS-
     1),  computed  from  the  character  string  pointed  to  by
     ****CCCCAAAAEEEESSSSAAAARRRR____PPPP  (and  not by CCCCAAAAEEEESSSSAAAARRRR____PPPP, as CCCCAAAAEEEESSSSAAAARRRR____PPPP is expected to
     be of type ((((CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSTTTTRRRRIIIINNNNGGGG ****)))), not CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSTTTTRRRRIIIINNNNGGGG).

     Note: to compute the hash-value, this function  invokes  the
     CCCCAAAAEEEESSSSAAAARRRR____SSSSTTTTRRRRIIIINNNNGGGG____0000____HHHHAAAASSSSHHHH(((()))) function of the ``hash'' library.

     Note:     this     function     is     used      by      the
     CCCCAAAAEEEESSSSAAAARRRR____UUUUSSSSEEEE____HHHHAAAASSSSHHHH____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN____AAAARRRREEEEAAAA____1111(((()))) function described below.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____UUUUSSSSEEEE____HHHHAAAASSSSHHHH____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN____AAAARRRREEEEAAAA____1111

     vvvvooooiiiidddd CCCCAAAAEEEESSSSAAAARRRR____UUUUSSSSEEEE____HHHHAAAASSSSHHHH____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN____AAAARRRREEEEAAAA____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____AAAARRRREEEEAAAA,,,, CCCCAAAAEEEESSSSAAAARRRR____HHHHAAAASSSSHHHH____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____AAAARRRREEEEAAAA____1111 CCCCAAAAEEEESSSSAAAARRRR____AAAARRRREEEEAAAA;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____HHHHAAAASSSSHHHH____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN ****CCCCAAAAEEEESSSSAAAARRRR____HHHHAAAASSSSHHHH____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN;;;;
        {{{{ ............ }}}}

     This procedure modifies the (function pointer) value pointed
     to  by  ****CCCCAAAAEEEESSSSAAAARRRR____HHHHAAAASSSSHHHH____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN (possibly to assign this func-
     tion pointer a default value if it is equal to  NNNNUUUULLLLLLLL  before
     the procedure is invoked) in the following cases:


     -    if   CCCCAAAAEEEESSSSAAAARRRR____AAAARRRREEEEAAAA   is   an   empty    area    and    if
          ****CCCCAAAAEEEESSSSAAAARRRR____HHHHAAAASSSSHHHH____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN   is  equal  to  NNNNUUUULLLLLLLL,  then  the
          CCCCAAAAEEEESSSSAAAARRRR____HHHHAAAASSSSHHHH____EEEEMMMMPPPPTTTTYYYY____AAAARRRREEEEAAAA____1111(((()))) function defined above  will
          be assigned to ****CCCCAAAAEEEESSSSAAAARRRR____HHHHAAAASSSSHHHH____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN;

          Note: it is not  allowed  to  call  this  procedure  if
          CCCCAAAAEEEESSSSAAAARRRR____AAAARRRREEEEAAAA     is    an    empty    area,    and    if
          ****CCCCAAAAEEEESSSSAAAARRRR____HHHHAAAASSSSHHHH____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN is different from both  NNNNUUUULLLLLLLL  and
          CCCCAAAAEEEESSSSAAAARRRR____HHHHAAAASSSSHHHH____EEEEMMMMPPPPTTTTYYYY____AAAARRRREEEEAAAA____1111(((()))),    since   in   this   case



(C) INRIA     Last change: 2020/02/11 (version 1.1)            11






OPEN/CAESAR MANUAL                           caesar_area_1(LOCAL)



          CCCCAAAAEEEESSSSAAAARRRR____HHHHAAAASSSSHHHH____EEEEMMMMPPPPTTTTYYYY____AAAARRRREEEEAAAA____1111(((()))) is the only sensible hashing
          function;

     -    if   CCCCAAAAEEEESSSSAAAARRRR____AAAARRRREEEEAAAA   is   a    state    area    and    if
          ****CCCCAAAAEEEESSSSAAAARRRR____HHHHAAAASSSSHHHH____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN   is  equal  to  NNNNUUUULLLLLLLL,  then  the
          CCCCAAAAEEEESSSSAAAARRRR____HHHHAAAASSSSHHHH____SSSSTTTTAAAATTTTEEEE(((()))) function of the graph  module  will
          be assigned to ****CCCCAAAAEEEESSSSAAAARRRR____HHHHAAAASSSSHHHH____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN;

          Note: it is not  allowed  to  call  this  procedure  if
          CCCCAAAAEEEESSSSAAAARRRR____AAAARRRREEEEAAAA     is     a    state    area,    and    if
          ****CCCCAAAAEEEESSSSAAAARRRR____HHHHAAAASSSSHHHH____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN is different from both  NNNNUUUULLLLLLLL  and
          CCCCAAAAEEEESSSSAAAARRRR____HHHHAAAASSSSHHHH____SSSSTTTTAAAATTTTEEEE(((()))),    and    if    the    result   of
          CCCCAAAAEEEESSSSAAAARRRR____HHHHAAAASSSSHHHH____SSSSIIIIZZZZEEEE____SSSSTTTTAAAATTTTEEEE(((()))) is equal  to  zero,  since  in
          this  case  CCCCAAAAEEEESSSSAAAARRRR____HHHHAAAASSSSHHHH____SSSSTTTTAAAATTTTEEEE(((())))  is  the  only sensible
          hashing function;

     -    if   CCCCAAAAEEEESSSSAAAARRRR____AAAARRRREEEEAAAA   is   a    label    area    and    if
          ****CCCCAAAAEEEESSSSAAAARRRR____HHHHAAAASSSSHHHH____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN   is  equal  to  NNNNUUUULLLLLLLL,  then  the
          CCCCAAAAEEEESSSSAAAARRRR____HHHHAAAASSSSHHHH____LLLLAAAABBBBEEEELLLL(((()))) function of the graph  module  will
          be assigned to ****CCCCAAAAEEEESSSSAAAARRRR____HHHHAAAASSSSHHHH____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN;

          Note: it is not  allowed  to  call  this  procedure  if
          CCCCAAAAEEEESSSSAAAARRRR____AAAARRRREEEEAAAA     is     a    label    area,    and    if
          ****CCCCAAAAEEEESSSSAAAARRRR____HHHHAAAASSSSHHHH____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN is different from both  NNNNUUUULLLLLLLL  and
          CCCCAAAAEEEESSSSAAAARRRR____HHHHAAAASSSSHHHH____LLLLAAAABBBBEEEELLLL(((()))),    and    if    the    result   of
          CCCCAAAAEEEESSSSAAAARRRR____HHHHAAAASSSSHHHH____SSSSIIIIZZZZEEEE____LLLLAAAABBBBEEEELLLL(((()))) is equal  to  zero,  since  in
          this  case  CCCCAAAAEEEESSSSAAAARRRR____HHHHAAAASSSSHHHH____LLLLAAAABBBBEEEELLLL(((())))  is  the  only sensible
          hashing function;

     -    if   CCCCAAAAEEEESSSSAAAARRRR____AAAARRRREEEEAAAA   is   a   string    area    and    if
          ****CCCCAAAAEEEESSSSAAAARRRR____HHHHAAAASSSSHHHH____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN   is  equal  to  NNNNUUUULLLLLLLL,  then  the
          CCCCAAAAEEEESSSSAAAARRRR____HHHHAAAASSSSHHHH____SSSSTTTTRRRRIIIINNNNGGGG____AAAARRRREEEEAAAA____1111(((()))) function  of  the  ``hash''
          library will be assigned to ****CCCCAAAAEEEESSSSAAAARRRR____HHHHAAAASSSSHHHH____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN.

     In any other case, ****CCCCAAAAEEEESSSSAAAARRRR____HHHHAAAASSSSHHHH____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN is kept unchanged.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____HHHHAAAASSSSHHHH____AAAARRRREEEEAAAA____1111

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL CCCCAAAAEEEESSSSAAAARRRR____HHHHAAAASSSSHHHH____AAAARRRREEEEAAAA____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____HHHHAAAASSSSHHHH____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN,,,, CCCCAAAAEEEESSSSAAAARRRR____PPPP,,,,
                                             CCCCAAAAEEEESSSSAAAARRRR____HHHHAAAASSSSHHHH____SSSSIIIIZZZZEEEE,,,, CCCCAAAAEEEESSSSAAAARRRR____MMMMOOOODDDDUUUULLLLUUUUSSSS))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____HHHHAAAASSSSHHHH____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN CCCCAAAAEEEESSSSAAAARRRR____HHHHAAAASSSSHHHH____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____PPPPOOOOIIIINNNNTTTTEEEERRRR CCCCAAAAEEEESSSSAAAARRRR____PPPP;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL CCCCAAAAEEEESSSSAAAARRRR____HHHHAAAASSSSHHHH____SSSSIIIIZZZZEEEE;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL CCCCAAAAEEEESSSSAAAARRRR____MMMMOOOODDDDUUUULLLLUUUUSSSS;;;;
        {{{{ ............ }}}}

     This function computes a hash  value  for  the  memory  area
     pointed  to by CCCCAAAAEEEESSSSAAAARRRR____PPPP using either CCCCAAAAEEEESSSSAAAARRRR____HHHHAAAASSSSHHHH____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN if
     this   function   pointer   is   not   NNNNUUUULLLLLLLL,   or   function



(C) INRIA     Last change: 2020/02/11 (version 1.1)            12






OPEN/CAESAR MANUAL                           caesar_area_1(LOCAL)



     CCCCAAAAEEEESSSSAAAARRRR____0000____HHHHAAAASSSSHHHH(((())))  of the ``hash'' library otherwise.  Hashing
     is performed on the CCCCAAAAEEEESSSSAAAARRRR____HHHHAAAASSSSHHHH____SSSSIIIIZZZZEEEE  first  bytes  and  the
     hash value returned is in the range 0..(CCCCAAAAEEEESSSSAAAARRRR____MMMMOOOODDDDUUUULLLLUUUUSSSS-1).

     Note: Before calling CCCCAAAAEEEESSSSAAAARRRR____HHHHAAAASSSSHHHH____AAAARRRREEEEAAAA____1111(((()))), the actual  value
     of  CCCCAAAAEEEESSSSAAAARRRR____HHHHAAAASSSSHHHH____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN should have been set by calling the
     CCCCAAAAEEEESSSSAAAARRRR____UUUUSSSSEEEE____HHHHAAAASSSSHHHH____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN____AAAARRRREEEEAAAA____1111(((()))) function.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____CCCCOOOONNNNVVVVEEEERRRRTTTT____EEEEMMMMPPPPTTTTYYYY____AAAARRRREEEEAAAA____1111

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSTTTTRRRRIIIINNNNGGGG CCCCAAAAEEEESSSSAAAARRRR____CCCCOOOONNNNVVVVEEEERRRRTTTT____EEEEMMMMPPPPTTTTYYYY____AAAARRRREEEEAAAA____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____PPPP))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____PPPPOOOOIIIINNNNTTTTEEEERRRR CCCCAAAAEEEESSSSAAAARRRR____PPPP;;;;
        {{{{ ............ }}}}

     This function returns a  constant,  user-readable  character
     string representing the empty area.

     Note: It is not  allowed  to  modify  the  character  string
     returned  by  CCCCAAAAEEEESSSSAAAARRRR____CCCCOOOONNNNVVVVEEEERRRRTTTT____EEEEMMMMPPPPTTTTYYYY____AAAARRRREEEEAAAA____1111(((())))  nor to free it,
     for instance using ffffrrrreeeeeeee((((3333)))).

     Note:     this     function     is     used      by      the
     CCCCAAAAEEEESSSSAAAARRRR____UUUUSSSSEEEE____CCCCOOOONNNNVVVVEEEERRRRTTTT____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN____AAAARRRREEEEAAAA____1111(((())))    function   described
     below.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____CCCCOOOONNNNVVVVEEEERRRRTTTT____SSSSTTTTRRRRIIIINNNNGGGG____AAAARRRREEEEAAAA____1111

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSTTTTRRRRIIIINNNNGGGG CCCCAAAAEEEESSSSAAAARRRR____CCCCOOOONNNNVVVVEEEERRRRTTTT____SSSSTTTTRRRRIIIINNNNGGGG____AAAARRRREEEEAAAA____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____SSSS))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSTTTTRRRRIIIINNNNGGGG ****CCCCAAAAEEEESSSSAAAARRRR____SSSS;;;;
        {{{{ ............ }}}}

     This function returns the character  string  pointed  to  by
     ****CCCCAAAAEEEESSSSAAAARRRR____SSSS.

     Note:     this     function     is     used      by      the
     CCCCAAAAEEEESSSSAAAARRRR____UUUUSSSSEEEE____CCCCOOOONNNNVVVVEEEERRRRTTTT____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN____AAAARRRREEEEAAAA____1111(((())))    function   described
     below.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____CCCCOOOONNNNVVVVEEEERRRRTTTT____BBBBIIIINNNNAAAARRRRYYYY____AAAARRRREEEEAAAA____1111

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSTTTTRRRRIIIINNNNGGGG CCCCAAAAEEEESSSSAAAARRRR____CCCCOOOONNNNVVVVEEEERRRRTTTT____BBBBIIIINNNNAAAARRRRYYYY____AAAARRRREEEEAAAA____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____PPPP,,,, CCCCAAAAEEEESSSSAAAARRRR____SSSSIIIIZZZZEEEE))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____PPPPOOOOIIIINNNNTTTTEEEERRRR CCCCAAAAEEEESSSSAAAARRRR____PPPP;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL CCCCAAAAEEEESSSSAAAARRRR____SSSSIIIIZZZZEEEE;;;;



(C) INRIA     Last change: 2020/02/11 (version 1.1)            13






OPEN/CAESAR MANUAL                           caesar_area_1(LOCAL)



        {{{{ ............ }}}}

     This function  returns  a  pointer  to  a  character  string
     corresponding  to  the  hexadecimal  representation  for the
     CCCCAAAAEEEESSSSAAAARRRR____SSSSIIIIZZZZEEEE bytes-long memory chunk pointed to by CCCCAAAAEEEESSSSAAAARRRR____PPPP.

     Note: It is not  allowed  to  modify  the  character  string
     returned  by  CCCCAAAAEEEESSSSAAAARRRR____CCCCOOOONNNNVVVVEEEERRRRTTTT____BBBBIIIINNNNAAAARRRRYYYY____AAAARRRREEEEAAAA____1111(((()))) nor to free it,
     for instance using ffffrrrreeeeeeee((((3333)))).

     Note: this function is used by  the  CCCCAAAAEEEESSSSAAAARRRR____CCCCOOOONNNNVVVVEEEERRRRTTTT____AAAARRRREEEEAAAA____1111(((())))
     function described below.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____UUUUSSSSEEEE____CCCCOOOONNNNVVVVEEEERRRRTTTT____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN____AAAARRRREEEEAAAA____1111

     vvvvooooiiiidddd CCCCAAAAEEEESSSSAAAARRRR____UUUUSSSSEEEE____CCCCOOOONNNNVVVVEEEERRRRTTTT____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN____AAAARRRREEEEAAAA____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____AAAARRRREEEEAAAA,,,, CCCCAAAAEEEESSSSAAAARRRR____CCCCOOOONNNNVVVVEEEERRRRTTTT____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____AAAARRRREEEEAAAA____1111 CCCCAAAAEEEESSSSAAAARRRR____AAAARRRREEEEAAAA;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____CCCCOOOONNNNVVVVEEEERRRRTTTT____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN ****CCCCAAAAEEEESSSSAAAARRRR____CCCCOOOONNNNVVVVEEEERRRRTTTT____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN;;;;
        {{{{ ............ }}}}

     This procedure modifies the (function pointer) value pointed
     to  by  ****CCCCAAAAEEEESSSSAAAARRRR____CCCCOOOONNNNVVVVEEEERRRRTTTT____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN  (possibly  to  assign this
     function pointer a default value if  it  is  equal  to  NNNNUUUULLLLLLLL
     before the procedure is invoked) in the following cases:


     -    if   CCCCAAAAEEEESSSSAAAARRRR____AAAARRRREEEEAAAA   is   an   empty    area    and    if
          ****CCCCAAAAEEEESSSSAAAARRRR____CCCCOOOONNNNVVVVEEEERRRRTTTT____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN  is  equal  to  NNNNUUUULLLLLLLL, then the
          CCCCAAAAEEEESSSSAAAARRRR____CCCCOOOONNNNVVVVEEEERRRRTTTT____EEEEMMMMPPPPTTTTYYYY____AAAARRRREEEEAAAA____1111(((())))  function  defined  above
          will be assigned to ****CCCCAAAAEEEESSSSAAAARRRR____CCCCOOOONNNNVVVVEEEERRRRTTTT____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN;

     -    if   CCCCAAAAEEEESSSSAAAARRRR____AAAARRRREEEEAAAA   is   a    state    area    and    if
          ****CCCCAAAAEEEESSSSAAAARRRR____CCCCOOOONNNNVVVVEEEERRRRTTTT____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN  is  equal  to  NNNNUUUULLLLLLLL, then the
          effect of this procedure is undefined;

     -    if   CCCCAAAAEEEESSSSAAAARRRR____AAAARRRREEEEAAAA   is   a    label    area    and    if
          ****CCCCAAAAEEEESSSSAAAARRRR____CCCCOOOONNNNVVVVEEEERRRRTTTT____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN  is  equal  to  NNNNUUUULLLLLLLL, then the
          CCCCAAAAEEEESSSSAAAARRRR____SSSSTTTTRRRRIIIINNNNGGGG____LLLLAAAABBBBEEEELLLL(((()))) function of the graph module will
          be assigned to ****CCCCAAAAEEEESSSSAAAARRRR____CCCCOOOONNNNVVVVEEEERRRRTTTT____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN;

     -    if   CCCCAAAAEEEESSSSAAAARRRR____AAAARRRREEEEAAAA   is   a   string    area    and    if
          ****CCCCAAAAEEEESSSSAAAARRRR____CCCCOOOONNNNVVVVEEEERRRRTTTT____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN  is  equal  to  NNNNUUUULLLLLLLL, then the
          CCCCAAAAEEEESSSSAAAARRRR____CCCCOOOONNNNVVVVEEEERRRRTTTT____SSSSTTTTRRRRIIIINNNNGGGG____AAAARRRREEEEAAAA____1111(((()))) function  defined  above
          will be assigned to ****CCCCAAAAEEEESSSSAAAARRRR____CCCCOOOONNNNVVVVEEEERRRRTTTT____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN.

     In  any  other  case,   ****CCCCAAAAEEEESSSSAAAARRRR____CCCCOOOONNNNVVVVEEEERRRRTTTT____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN   is   kept
     unchanged.





(C) INRIA     Last change: 2020/02/11 (version 1.1)            14






OPEN/CAESAR MANUAL                           caesar_area_1(LOCAL)



      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____CCCCOOOONNNNVVVVEEEERRRRTTTT____AAAARRRREEEEAAAA____1111

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSTTTTRRRRIIIINNNNGGGG CCCCAAAAEEEESSSSAAAARRRR____CCCCOOOONNNNVVVVEEEERRRRTTTT____AAAARRRREEEEAAAA____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____CCCCOOOONNNNVVVVEEEERRRRTTTT____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN,,,, CCCCAAAAEEEESSSSAAAARRRR____PPPP,,,,
                                               CCCCAAAAEEEESSSSAAAARRRR____SSSSIIIIZZZZEEEE))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____CCCCOOOONNNNVVVVEEEERRRRTTTT____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN CCCCAAAAEEEESSSSAAAARRRR____CCCCOOOONNNNVVVVEEEERRRRTTTT____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____PPPPOOOOIIIINNNNTTTTEEEERRRR CCCCAAAAEEEESSSSAAAARRRR____PPPP;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL CCCCAAAAEEEESSSSAAAARRRR____SSSSIIIIZZZZEEEE;;;;
        {{{{ ............ }}}}

     This function  converts  the  memory  area  (of  CCCCAAAAEEEESSSSAAAARRRR____SSSSIIIIZZZZEEEE
     bytes)  pointed to by CCCCAAAAEEEESSSSAAAARRRR____PPPP into a character string using
     either CCCCAAAAEEEESSSSAAAARRRR____CCCCOOOONNNNVVVVEEEERRRRTTTT____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN if this function  pointer  is
     not  NNNNUUUULLLLLLLL, or function CCCCAAAAEEEESSSSAAAARRRR____CCCCOOOONNNNVVVVEEEERRRRTTTT____BBBBIIIINNNNAAAARRRRYYYY____AAAARRRREEEEAAAA____1111(((()))) other-
     wise.

     Note: Before  calling  CCCCAAAAEEEESSSSAAAARRRR____CCCCOOOONNNNVVVVEEEERRRRTTTT____AAAARRRREEEEAAAA____1111(((()))),  the  actual
     value  of  CCCCAAAAEEEESSSSAAAARRRR____CCCCOOOONNNNVVVVEEEERRRRTTTT____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN  should  have been set by
     calling the CCCCAAAAEEEESSSSAAAARRRR____UUUUSSSSEEEE____CCCCOOOONNNNVVVVEEEERRRRTTTT____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN____AAAARRRREEEEAAAA____1111(((()))) function.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____PPPPRRRRIIIINNNNTTTT____EEEEMMMMPPPPTTTTYYYY____AAAARRRREEEEAAAA____1111

     vvvvooooiiiidddd CCCCAAAAEEEESSSSAAAARRRR____PPPPRRRRIIIINNNNTTTT____EEEEMMMMPPPPTTTTYYYY____AAAARRRREEEEAAAA____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____FFFFIIIILLLLEEEE,,,, CCCCAAAAEEEESSSSAAAARRRR____PPPP))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____FFFFIIIILLLLEEEE CCCCAAAAEEEESSSSAAAARRRR____FFFFIIIILLLLEEEE;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____PPPPOOOOIIIINNNNTTTTEEEERRRR CCCCAAAAEEEESSSSAAAARRRR____PPPP;;;;
        {{{{ ............ }}}}

     This procedure prints to file CCCCAAAAEEEESSSSAAAARRRR____FFFFIIIILLLLEEEE a constant,  user-
     readable character string representing the empty area.

     Before this procedure is called, CCCCAAAAEEEESSSSAAAARRRR____FFFFIIIILLLLEEEE must have  been
     properly opened, for instance using ffffooooppppeeeennnn((((3333)))).

     Note:     this     function     is     used      by      the
     CCCCAAAAEEEESSSSAAAARRRR____UUUUSSSSEEEE____PPPPRRRRIIIINNNNTTTT____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN____AAAARRRREEEEAAAA____1111(((()))) function described below.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____PPPPRRRRIIIINNNNTTTT____SSSSTTTTRRRRIIIINNNNGGGG____AAAARRRREEEEAAAA____1111

     vvvvooooiiiidddd CCCCAAAAEEEESSSSAAAARRRR____PPPPRRRRIIIINNNNTTTT____SSSSTTTTRRRRIIIINNNNGGGG____AAAARRRREEEEAAAA____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____FFFFIIIILLLLEEEE,,,, CCCCAAAAEEEESSSSAAAARRRR____SSSS))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____FFFFIIIILLLLEEEE CCCCAAAAEEEESSSSAAAARRRR____FFFFIIIILLLLEEEE;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSTTTTRRRRIIIINNNNGGGG ****CCCCAAAAEEEESSSSAAAARRRR____SSSS;;;;
        {{{{ ............ }}}}

     This procedure prints  to  file  CCCCAAAAEEEESSSSAAAARRRR____FFFFIIIILLLLEEEE  the  character
     string pointed to by ****CCCCAAAAEEEESSSSAAAARRRR____SSSS.



(C) INRIA     Last change: 2020/02/11 (version 1.1)            15






OPEN/CAESAR MANUAL                           caesar_area_1(LOCAL)



     Before this procedure is called, CCCCAAAAEEEESSSSAAAARRRR____FFFFIIIILLLLEEEE must have  been
     properly opened, for instance using ffffooooppppeeeennnn((((3333)))).

     Note:     this     function     is     used      by      the
     CCCCAAAAEEEESSSSAAAARRRR____UUUUSSSSEEEE____PPPPRRRRIIIINNNNTTTT____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN____AAAARRRREEEEAAAA____1111(((()))) function described below.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____PPPPRRRRIIIINNNNTTTT____BBBBIIIINNNNAAAARRRRYYYY____AAAARRRREEEEAAAA____1111

     vvvvooooiiiidddd CCCCAAAAEEEESSSSAAAARRRR____PPPPRRRRIIIINNNNTTTT____BBBBIIIINNNNAAAARRRRYYYY____AAAARRRREEEEAAAA____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____FFFFIIIILLLLEEEE,,,, CCCCAAAAEEEESSSSAAAARRRR____PPPP,,,, CCCCAAAAEEEESSSSAAAARRRR____SSSSIIIIZZZZEEEE))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____FFFFIIIILLLLEEEE CCCCAAAAEEEESSSSAAAARRRR____FFFFIIIILLLLEEEE;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____PPPPOOOOIIIINNNNTTTTEEEERRRR CCCCAAAAEEEESSSSAAAARRRR____PPPP;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL CCCCAAAAEEEESSSSAAAARRRR____SSSSIIIIZZZZEEEE;;;;
        {{{{ ............ }}}}

     This procedure prints  to  file  CCCCAAAAEEEESSSSAAAARRRR____FFFFIIIILLLLEEEE  the  character
     string  corresponding  to the hexadecimal representation for
     the  CCCCAAAAEEEESSSSAAAARRRR____SSSSIIIIZZZZEEEE  bytes-long  memory  chunk  pointed  to  by
     CCCCAAAAEEEESSSSAAAARRRR____PPPP.

     Before this procedure is called, CCCCAAAAEEEESSSSAAAARRRR____FFFFIIIILLLLEEEE must have  been
     properly opened, for instance using ffffooooppppeeeennnn((((3333)))).

     Note: this function is  used  by  the  CCCCAAAAEEEESSSSAAAARRRR____PPPPRRRRIIIINNNNTTTT____AAAARRRREEEEAAAA____1111(((())))
     function described below.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____UUUUSSSSEEEE____PPPPRRRRIIIINNNNTTTT____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN____AAAARRRREEEEAAAA____1111

     vvvvooooiiiidddd CCCCAAAAEEEESSSSAAAARRRR____UUUUSSSSEEEE____PPPPRRRRIIIINNNNTTTT____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN____AAAARRRREEEEAAAA____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____AAAARRRREEEEAAAA,,,, CCCCAAAAEEEESSSSAAAARRRR____PPPPRRRRIIIINNNNTTTT____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____AAAARRRREEEEAAAA____1111 CCCCAAAAEEEESSSSAAAARRRR____AAAARRRREEEEAAAA;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____PPPPRRRRIIIINNNNTTTT____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN ****CCCCAAAAEEEESSSSAAAARRRR____PPPPRRRRIIIINNNNTTTT____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN;;;;
        {{{{ ............ }}}}

     This procedure modifies the (function pointer) value pointed
     to  by ****CCCCAAAAEEEESSSSAAAARRRR____PPPPRRRRIIIINNNNTTTT____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN (possibly to assign this func-
     tion pointer a default value if it is equal to  NNNNUUUULLLLLLLL  before
     the procedure is invoked) in the following cases:


     -    if   CCCCAAAAEEEESSSSAAAARRRR____AAAARRRREEEEAAAA   is   an   empty    area    and    if
          ****CCCCAAAAEEEESSSSAAAARRRR____PPPPRRRRIIIINNNNTTTT____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN  is  equal  to  NNNNUUUULLLLLLLL,  then  the
          CCCCAAAAEEEESSSSAAAARRRR____PPPPRRRRIIIINNNNTTTT____EEEEMMMMPPPPTTTTYYYY____AAAARRRREEEEAAAA____1111(((()))) function defined above will
          be assigned to ****CCCCAAAAEEEESSSSAAAARRRR____PPPPRRRRIIIINNNNTTTT____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN;

     -    if   CCCCAAAAEEEESSSSAAAARRRR____AAAARRRREEEEAAAA   is   a    state    area    and    if
          ****CCCCAAAAEEEESSSSAAAARRRR____PPPPRRRRIIIINNNNTTTT____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN  is  equal  to  NNNNUUUULLLLLLLL,  then  the
          CCCCAAAAEEEESSSSAAAARRRR____PPPPRRRRIIIINNNNTTTT____SSSSTTTTAAAATTTTEEEE(((()))) function of the graph module  will



(C) INRIA     Last change: 2020/02/11 (version 1.1)            16






OPEN/CAESAR MANUAL                           caesar_area_1(LOCAL)



          be assigned to ****CCCCAAAAEEEESSSSAAAARRRR____PPPPRRRRIIIINNNNTTTT____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN;

     -    if   CCCCAAAAEEEESSSSAAAARRRR____AAAARRRREEEEAAAA   is   a    label    area    and    if
          ****CCCCAAAAEEEESSSSAAAARRRR____PPPPRRRRIIIINNNNTTTT____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN  is  equal  to  NNNNUUUULLLLLLLL,  then  the
          CCCCAAAAEEEESSSSAAAARRRR____PPPPRRRRIIIINNNNTTTT____LLLLAAAABBBBEEEELLLL(((()))) function of the graph module  will
          be assigned to ****CCCCAAAAEEEESSSSAAAARRRR____PPPPRRRRIIIINNNNTTTT____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN;

     -    if   CCCCAAAAEEEESSSSAAAARRRR____AAAARRRREEEEAAAA   is   a   string    area    and    if
          ****CCCCAAAAEEEESSSSAAAARRRR____PPPPRRRRIIIINNNNTTTT____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN  is  equal  to  NNNNUUUULLLLLLLL,  then  the
          CCCCAAAAEEEESSSSAAAARRRR____PPPPRRRRIIIINNNNTTTT____SSSSTTTTRRRRIIIINNNNGGGG____AAAARRRREEEEAAAA____1111(((())))  function  defined   above
          will be assigned to ****CCCCAAAAEEEESSSSAAAARRRR____PPPPRRRRIIIINNNNTTTT____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN.

     In any other case, ****CCCCAAAAEEEESSSSAAAARRRR____PPPPRRRRIIIINNNNTTTT____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN is kept unchanged.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____PPPPRRRRIIIINNNNTTTT____AAAARRRREEEEAAAA____1111

     vvvvooooiiiidddd CCCCAAAAEEEESSSSAAAARRRR____PPPPRRRRIIIINNNNTTTT____AAAARRRREEEEAAAA____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____PPPPRRRRIIIINNNNTTTT____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN,,,, CCCCAAAAEEEESSSSAAAARRRR____FFFFIIIILLLLEEEE,,,, CCCCAAAAEEEESSSSAAAARRRR____PPPP,,,,
                               CCCCAAAAEEEESSSSAAAARRRR____SSSSIIIIZZZZEEEE))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____PPPPRRRRIIIINNNNTTTT____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN CCCCAAAAEEEESSSSAAAARRRR____PPPPRRRRIIIINNNNTTTT____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____FFFFIIIILLLLEEEE CCCCAAAAEEEESSSSAAAARRRR____FFFFIIIILLLLEEEE;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____PPPPOOOOIIIINNNNTTTTEEEERRRR CCCCAAAAEEEESSSSAAAARRRR____PPPP;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL CCCCAAAAEEEESSSSAAAARRRR____SSSSIIIIZZZZEEEE;;;;
        {{{{ ............ }}}}

     This function prints to file CCCCAAAAEEEESSSSAAAARRRR____FFFFIIIILLLLEEEE a character  string
     representing  the memory area (of CCCCAAAAEEEESSSSAAAARRRR____SSSSIIIIZZZZEEEE bytes) pointed
     to   by   CCCCAAAAEEEESSSSAAAARRRR____PPPP.   Printing   is   done   using    either
     CCCCAAAAEEEESSSSAAAARRRR____PPPPRRRRIIIINNNNTTTT____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN  if this function pointer is not NNNNUUUULLLLLLLL,
     or function CCCCAAAAEEEESSSSAAAARRRR____PPPPRRRRIIIINNNNTTTT____BBBBIIIINNNNAAAARRRRYYYY____AAAARRRREEEEAAAA____1111(((()))) otherwise.

     Before this procedure is called, CCCCAAAAEEEESSSSAAAARRRR____FFFFIIIILLLLEEEE must have  been
     properly opened, for instance using ffffooooppppeeeennnn((((3333)))).

     Note: Before calling CCCCAAAAEEEESSSSAAAARRRR____PPPPRRRRIIIINNNNTTTT____AAAARRRREEEEAAAA____1111(((()))), the actual value
     of CCCCAAAAEEEESSSSAAAARRRR____PPPPRRRRIIIINNNNTTTT____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN should have been set by calling the
     CCCCAAAAEEEESSSSAAAARRRR____UUUUSSSSEEEE____PPPPRRRRIIIINNNNTTTT____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN____AAAARRRREEEEAAAA____1111(((()))) function.


      ............................................................

AAAAUUUUTTTTHHHHOOOORRRR((((SSSS))))
     Hubert Garavel

FFFFIIIILLLLEEEESSSS
     $$$$CCCCAAAADDDDPPPP////iiiinnnnccccllll////ccccaaaaeeeessssaaaarrrr____ggggrrrraaaapppphhhh....hhhh     interface of the graph module
     $$$$CCCCAAAADDDDPPPP////iiiinnnnccccllll////ccccaaaaeeeessssaaaarrrr____****....hhhh         interfaces  of   the   storage
                                   module
     $$$$CCCCAAAADDDDPPPP////bbbbiiiinnnn....````aaaarrrrcccchhhh````////lllliiiibbbbccccaaaaeeeessssaaaarrrr....aaaa  object  code  of  the  storage
                                   module



(C) INRIA     Last change: 2020/02/11 (version 1.1)            17






OPEN/CAESAR MANUAL                           caesar_area_1(LOCAL)



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


































(C) INRIA     Last change: 2020/02/11 (version 1.1)            18



