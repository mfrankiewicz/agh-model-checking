


OPEN/CAESAR MANUAL                             caesar_hash(LOCAL)



NNNNAAAAMMMMEEEE
     caesar_hash - the ``hash'' library of OPEN/CAESAR

PPPPUUUURRRRPPPPOOOOSSSSEEEE
     The ``hash'' library provides primitives for computing vari-
     ous hashing functions on byte strings, states and labels.



UUUUSSSSAAAAGGGGEEEE
     The ``hash'' library consists of:

     -    a predefined header file ccccaaaaeeeessssaaaarrrr____hhhhaaaasssshhhh....hhhh;

     -    the precompiled library file lllliiiibbbbccccaaaaeeeessssaaaarrrr....aaaa, which  imple-
          ments the features described in ccccaaaaeeeessssaaaarrrr____hhhhaaaasssshhhh....hhhh.

     Note: The ``hash'' library is a software layer  built  above
     the  primitives  offered  by the ``standard'' library and by
     the _O_P_E_N/_C_A_E_S_A_R graph module.



FFFFEEEEAAAATTTTUUUURRRREEEESSSS
      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____PPPPRRRRIIIIMMMMEEEE____HHHHAAAASSSSHHHH

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____BBBBOOOOOOOOLLLLEEEEAAAANNNN CCCCAAAAEEEESSSSAAAARRRR____PPPPRRRRIIIIMMMMEEEE____HHHHAAAASSSSHHHH ((((CCCCAAAAEEEESSSSAAAARRRR____IIII))))
       CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL CCCCAAAAEEEESSSSAAAARRRR____IIII;;;;
       {{{{ ............ }}}}

     This function returns a value different from 0  if  CCCCAAAAEEEESSSSAAAARRRR____IIII
     is a prime number, or 0 otherwise.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____0000____HHHHAAAASSSSHHHH

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL CCCCAAAAEEEESSSSAAAARRRR____0000____HHHHAAAASSSSHHHH ((((CCCCAAAAEEEESSSSAAAARRRR____PPPP,,,, CCCCAAAAEEEESSSSAAAARRRR____SSSSIIIIZZZZEEEE,,,, CCCCAAAAEEEESSSSAAAARRRR____MMMMOOOODDDDUUUULLLLUUUUSSSS))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____PPPPOOOOIIIINNNNTTTTEEEERRRR CCCCAAAAEEEESSSSAAAARRRR____PPPP;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL CCCCAAAAEEEESSSSAAAARRRR____SSSSIIIIZZZZEEEE;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL CCCCAAAAEEEESSSSAAAARRRR____MMMMOOOODDDDUUUULLLLUUUUSSSS;;;;
        {{{{ ............ }}}}

     This function computes a hash-value for the byte  string  of
     length  CCCCAAAAEEEESSSSAAAARRRR____SSSSIIIIZZZZEEEE pointed to by CCCCAAAAEEEESSSSAAAARRRR____PPPP, and returns this
     value, which  is  in  the  range  0..(CCCCAAAAEEEESSSSAAAARRRR____MMMMOOOODDDDUUUULLLLUUUUSSSS-1).  If
     either  CCCCAAAAEEEESSSSAAAARRRR____SSSSIIIIZZZZEEEE  or  CCCCAAAAEEEESSSSAAAARRRR____MMMMOOOODDDDUUUULLLLUUUUSSSS  is  equal to 0, the
     result is undefined.




(C) INRIA     Last change: 2020/02/11 (version 1.3)             1






OPEN/CAESAR MANUAL                             caesar_hash(LOCAL)



     Note: The string is exactly CCCCAAAAEEEESSSSAAAARRRR____SSSSIIIIZZZZEEEE bytes long, starting
     from  CCCCAAAAEEEESSSSAAAARRRR____PPPP  [0] to CCCCAAAAEEEESSSSAAAARRRR____PPPP [CCCCAAAAEEEESSSSAAAARRRR____SSSSIIIIZZZZEEEE - 1]. It is not
     required that the byte string is terminated by a  null  byte
     (which  is not the case of character strings in C). The same
     remark applies to the other functions defined below.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____1111____HHHHAAAASSSSHHHH

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL CCCCAAAAEEEESSSSAAAARRRR____1111____HHHHAAAASSSSHHHH ((((CCCCAAAAEEEESSSSAAAARRRR____PPPP,,,, CCCCAAAAEEEESSSSAAAARRRR____SSSSIIIIZZZZEEEE,,,, CCCCAAAAEEEESSSSAAAARRRR____MMMMOOOODDDDUUUULLLLUUUUSSSS))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____PPPPOOOOIIIINNNNTTTTEEEERRRR CCCCAAAAEEEESSSSAAAARRRR____PPPP;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL CCCCAAAAEEEESSSSAAAARRRR____SSSSIIIIZZZZEEEE;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL CCCCAAAAEEEESSSSAAAARRRR____MMMMOOOODDDDUUUULLLLUUUUSSSS;;;;
        {{{{ ............ }}}}

     This function computes a hash-value for the byte  string  of
     length  CCCCAAAAEEEESSSSAAAARRRR____SSSSIIIIZZZZEEEE pointed to by CCCCAAAAEEEESSSSAAAARRRR____PPPP, and returns this
     value, which  is  in  the  range  0..(CCCCAAAAEEEESSSSAAAARRRR____MMMMOOOODDDDUUUULLLLUUUUSSSS-1).  If
     either  CCCCAAAAEEEESSSSAAAARRRR____SSSSIIIIZZZZEEEE  or  CCCCAAAAEEEESSSSAAAARRRR____MMMMOOOODDDDUUUULLLLUUUUSSSS  is  equal to 0, the
     result is undefined.

     Note: This  function  is  derived  from  the  hash  function
     ssss____hhhhaaaasssshhhh(((())))  formerly  used  in the SPIN validation system (see
     Gerard Holzmann's book ``Design and Validation  of  Computer
     Protocols'', 1991, page 307). The result of ssss____hhhhaaaasssshhhh(((()))) is also
     the same as the one returned in global variable  JJJJ1111  by  the
     other  hash function dddd____hhhhaaaasssshhhh(((()))).  The CCCCAAAAEEEESSSSAAAARRRR____1111____HHHHAAAASSSSHHHH(((()))) function
     is more general than ssss____hhhhaaaasssshhhh(((()))) since it was extended  to  64-
     bit  machines  and since it does not assume that CCCCAAAAEEEESSSSAAAARRRR____SSSSIIIIZZZZEEEE
     is a power of four and that CCCCAAAAEEEESSSSAAAARRRR____MMMMOOOODDDDUUUULLLLUUUUSSSS  is  a  power  of
     two. It also attempts to solve portability issues that occur
     in ssss____hhhhaaaasssshhhh(((()))). Yet, it may be slower than ssss____hhhhaaaasssshhhh(((()))).

     Note: The  result  returned  by  this  function  may  differ
     accross  different  machines,  since  it  depends on machine
     endianness.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____2222____HHHHAAAASSSSHHHH

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL CCCCAAAAEEEESSSSAAAARRRR____2222____HHHHAAAASSSSHHHH ((((CCCCAAAAEEEESSSSAAAARRRR____PPPP,,,, CCCCAAAAEEEESSSSAAAARRRR____SSSSIIIIZZZZEEEE,,,, CCCCAAAAEEEESSSSAAAARRRR____MMMMOOOODDDDUUUULLLLUUUUSSSS))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____PPPPOOOOIIIINNNNTTTTEEEERRRR CCCCAAAAEEEESSSSAAAARRRR____PPPP;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL CCCCAAAAEEEESSSSAAAARRRR____SSSSIIIIZZZZEEEE;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL CCCCAAAAEEEESSSSAAAARRRR____MMMMOOOODDDDUUUULLLLUUUUSSSS;;;;
        {{{{ ............ }}}}

     This function computes a hash-value for the byte  string  of
     length  CCCCAAAAEEEESSSSAAAARRRR____SSSSIIIIZZZZEEEE pointed to by CCCCAAAAEEEESSSSAAAARRRR____PPPP, and returns this



(C) INRIA     Last change: 2020/02/11 (version 1.3)             2






OPEN/CAESAR MANUAL                             caesar_hash(LOCAL)



     value, which  is  in  the  range  0..(CCCCAAAAEEEESSSSAAAARRRR____MMMMOOOODDDDUUUULLLLUUUUSSSS-1).  If
     either  CCCCAAAAEEEESSSSAAAARRRR____SSSSIIIIZZZZEEEE  or  CCCCAAAAEEEESSSSAAAARRRR____MMMMOOOODDDDUUUULLLLUUUUSSSS  is  equal to 0, the
     result is undefined.

     Note: This  function  is  derived  from  the  hash  function
     dddd____hhhhaaaasssshhhh(((())))  formerly  used  in the SPIN validation system (see
     Gerard Holzmann's book ``Design and Validation  of  Computer
     Protocols'',  1991,  page  307)  with  respect to the result
     returned in global variable JJJJ2222.  The  CCCCAAAAEEEESSSSAAAARRRR____2222____HHHHAAAASSSSHHHH(((())))  func-
     tion  is more general than dddd____hhhhaaaasssshhhh(((()))) since it was extended to
     64-bit  machines  and  since  it  does   not   assume   that
     CCCCAAAAEEEESSSSAAAARRRR____SSSSIIIIZZZZEEEE  is a power of four and that CCCCAAAAEEEESSSSAAAARRRR____MMMMOOOODDDDUUUULLLLUUUUSSSS is a
     power of two. It also attempts to solve  portability  issues
     that occur in dddd____hhhhaaaasssshhhh(((()))). Yet, it may be slower than dddd____hhhhaaaasssshhhh(((()))).

     Note: The  result  returned  by  this  function  may  differ
     accross  different  machines,  since  it  depends on machine
     endianness.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____3333____HHHHAAAASSSSHHHH

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL CCCCAAAAEEEESSSSAAAARRRR____3333____HHHHAAAASSSSHHHH ((((CCCCAAAAEEEESSSSAAAARRRR____PPPP,,,, CCCCAAAAEEEESSSSAAAARRRR____SSSSIIIIZZZZEEEE,,,, CCCCAAAAEEEESSSSAAAARRRR____MMMMOOOODDDDUUUULLLLUUUUSSSS))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____PPPPOOOOIIIINNNNTTTTEEEERRRR CCCCAAAAEEEESSSSAAAARRRR____PPPP;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL CCCCAAAAEEEESSSSAAAARRRR____SSSSIIIIZZZZEEEE;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL CCCCAAAAEEEESSSSAAAARRRR____MMMMOOOODDDDUUUULLLLUUUUSSSS;;;;
        {{{{ ............ }}}}

     This function computes a hash-value for the byte  string  of
     length  CCCCAAAAEEEESSSSAAAARRRR____SSSSIIIIZZZZEEEE pointed to by CCCCAAAAEEEESSSSAAAARRRR____PPPP, and returns this
     value, which  is  in  the  range  0..(CCCCAAAAEEEESSSSAAAARRRR____MMMMOOOODDDDUUUULLLLUUUUSSSS-1).  If
     either  CCCCAAAAEEEESSSSAAAARRRR____SSSSIIIIZZZZEEEE  or  CCCCAAAAEEEESSSSAAAARRRR____MMMMOOOODDDDUUUULLLLUUUUSSSS  is  equal to 0, the
     result is undefined.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____4444____HHHHAAAASSSSHHHH

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL CCCCAAAAEEEESSSSAAAARRRR____4444____HHHHAAAASSSSHHHH ((((CCCCAAAAEEEESSSSAAAARRRR____PPPP,,,, CCCCAAAAEEEESSSSAAAARRRR____SSSSIIIIZZZZEEEE,,,, CCCCAAAAEEEESSSSAAAARRRR____MMMMOOOODDDDUUUULLLLUUUUSSSS))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____PPPPOOOOIIIINNNNTTTTEEEERRRR CCCCAAAAEEEESSSSAAAARRRR____PPPP;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL CCCCAAAAEEEESSSSAAAARRRR____SSSSIIIIZZZZEEEE;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL CCCCAAAAEEEESSSSAAAARRRR____MMMMOOOODDDDUUUULLLLUUUUSSSS;;;;
        {{{{ ............ }}}}

     This function computes a hash-value for the byte  string  of
     length  CCCCAAAAEEEESSSSAAAARRRR____SSSSIIIIZZZZEEEE pointed to by CCCCAAAAEEEESSSSAAAARRRR____PPPP, and returns this
     value, which  is  in  the  range  0..(CCCCAAAAEEEESSSSAAAARRRR____MMMMOOOODDDDUUUULLLLUUUUSSSS-1).  If
     either  CCCCAAAAEEEESSSSAAAARRRR____SSSSIIIIZZZZEEEE  or  CCCCAAAAEEEESSSSAAAARRRR____MMMMOOOODDDDUUUULLLLUUUUSSSS  is  equal to 0, the
     result is undefined.



(C) INRIA     Last change: 2020/02/11 (version 1.3)             3






OPEN/CAESAR MANUAL                             caesar_hash(LOCAL)



     Note: This function is derived from the PJW algorithm  given
     in  "Compilers: Principles, Techniques, and Tools" by Alfred
     V. Aho, Ravi Sethi, and Jeffrey D.  Ullman,  [pp.  434-438],
     which  was  used primarly for compressing character strings.
     The CCCCAAAAEEEESSSSAAAARRRR____4444____HHHHAAAASSSSHHHH(((()))) function removes  a  limitation  of  the
     original PJW algorithm, which always returns a hash value on
     24 bits only. If CCCCAAAAEEEESSSSAAAARRRR____MMMMOOOODDDDUUUULLLLUUUUSSSS is larger than 24 bits,  the
     result of CCCCAAAAEEEESSSSAAAARRRR____4444____HHHHAAAASSSSHHHH(((()))) might be also larger than 24 bits.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____5555____HHHHAAAASSSSHHHH

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL CCCCAAAAEEEESSSSAAAARRRR____5555____HHHHAAAASSSSHHHH ((((CCCCAAAAEEEESSSSAAAARRRR____PPPP,,,, CCCCAAAAEEEESSSSAAAARRRR____SSSSIIIIZZZZEEEE,,,, CCCCAAAAEEEESSSSAAAARRRR____MMMMOOOODDDDUUUULLLLUUUUSSSS))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____PPPPOOOOIIIINNNNTTTTEEEERRRR CCCCAAAAEEEESSSSAAAARRRR____PPPP;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL CCCCAAAAEEEESSSSAAAARRRR____SSSSIIIIZZZZEEEE;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL CCCCAAAAEEEESSSSAAAARRRR____MMMMOOOODDDDUUUULLLLUUUUSSSS;;;;
        {{{{ ............ }}}}

     This function computes a hash-value for the byte  string  of
     length  CCCCAAAAEEEESSSSAAAARRRR____SSSSIIIIZZZZEEEE pointed to by CCCCAAAAEEEESSSSAAAARRRR____PPPP, and returns this
     value, which  is  in  the  range  0..(CCCCAAAAEEEESSSSAAAARRRR____MMMMOOOODDDDUUUULLLLUUUUSSSS-1).  If
     either  CCCCAAAAEEEESSSSAAAARRRR____SSSSIIIIZZZZEEEE  or  CCCCAAAAEEEESSSSAAAARRRR____MMMMOOOODDDDUUUULLLLUUUUSSSS  is  equal to 0, the
     result is undefined.

     Note: This function performs simple computations based  upon
     XOR operations and bit shifts.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____6666____HHHHAAAASSSSHHHH

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL CCCCAAAAEEEESSSSAAAARRRR____6666____HHHHAAAASSSSHHHH ((((CCCCAAAAEEEESSSSAAAARRRR____PPPP,,,, CCCCAAAAEEEESSSSAAAARRRR____SSSSIIIIZZZZEEEE,,,, CCCCAAAAEEEESSSSAAAARRRR____MMMMOOOODDDDUUUULLLLUUUUSSSS))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____PPPPOOOOIIIINNNNTTTTEEEERRRR CCCCAAAAEEEESSSSAAAARRRR____PPPP;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL CCCCAAAAEEEESSSSAAAARRRR____SSSSIIIIZZZZEEEE;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL CCCCAAAAEEEESSSSAAAARRRR____MMMMOOOODDDDUUUULLLLUUUUSSSS;;;;
        {{{{ ............ }}}}

     This function computes a hash-value for the byte  string  of
     length  CCCCAAAAEEEESSSSAAAARRRR____SSSSIIIIZZZZEEEE pointed to by CCCCAAAAEEEESSSSAAAARRRR____PPPP, and returns this
     value, which  is  in  the  range  0..(CCCCAAAAEEEESSSSAAAARRRR____MMMMOOOODDDDUUUULLLLUUUUSSSS-1).  If
     either  CCCCAAAAEEEESSSSAAAARRRR____SSSSIIIIZZZZEEEE  or  CCCCAAAAEEEESSSSAAAARRRR____MMMMOOOODDDDUUUULLLLUUUUSSSS  is  equal to 0, the
     result is undefined.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____7777____HHHHAAAASSSSHHHH

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL CCCCAAAAEEEESSSSAAAARRRR____7777____HHHHAAAASSSSHHHH ((((CCCCAAAAEEEESSSSAAAARRRR____PPPP,,,, CCCCAAAAEEEESSSSAAAARRRR____SSSSIIIIZZZZEEEE,,,, CCCCAAAAEEEESSSSAAAARRRR____MMMMOOOODDDDUUUULLLLUUUUSSSS))))



(C) INRIA     Last change: 2020/02/11 (version 1.3)             4






OPEN/CAESAR MANUAL                             caesar_hash(LOCAL)



        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____PPPPOOOOIIIINNNNTTTTEEEERRRR CCCCAAAAEEEESSSSAAAARRRR____PPPP;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL CCCCAAAAEEEESSSSAAAARRRR____SSSSIIIIZZZZEEEE;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL CCCCAAAAEEEESSSSAAAARRRR____MMMMOOOODDDDUUUULLLLUUUUSSSS;;;;
        {{{{ ............ }}}}

     This function computes a hash-value for the byte  string  of
     length  CCCCAAAAEEEESSSSAAAARRRR____SSSSIIIIZZZZEEEE pointed to by CCCCAAAAEEEESSSSAAAARRRR____PPPP, and returns this
     value, which  is  in  the  range  0..(CCCCAAAAEEEESSSSAAAARRRR____MMMMOOOODDDDUUUULLLLUUUUSSSS-1).  If
     either  CCCCAAAAEEEESSSSAAAARRRR____SSSSIIIIZZZZEEEE  or  CCCCAAAAEEEESSSSAAAARRRR____MMMMOOOODDDDUUUULLLLUUUUSSSS  is  equal to 0, the
     result is undefined.

     Note: This function is derived from the hash functions  pro-
     posed  by  Bob Jenkins, namely llllooooooookkkkuuuupppp2222(((()))) for 32-bit machines
     and llllooooooookkkkuuuupppp8888(((()))) for 64-bit machines.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____SSSSTTTTAAAATTTTEEEE____0000____HHHHAAAASSSSHHHH

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL CCCCAAAAEEEESSSSAAAARRRR____SSSSTTTTAAAATTTTEEEE____0000____HHHHAAAASSSSHHHH ((((CCCCAAAAEEEESSSSAAAARRRR____SSSS,,,, CCCCAAAAEEEESSSSAAAARRRR____MMMMOOOODDDDUUUULLLLUUUUSSSS))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSTTTTAAAATTTTEEEE CCCCAAAAEEEESSSSAAAARRRR____SSSS;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL CCCCAAAAEEEESSSSAAAARRRR____MMMMOOOODDDDUUUULLLLUUUUSSSS;;;;
        {{{{ ............ }}}}

     This function computes a hash-value for the state pointed to
     by  CCCCAAAAEEEESSSSAAAARRRR____SSSS  and  returns this value, which is in the range
     0..(CCCCAAAAEEEESSSSAAAARRRR____MMMMOOOODDDDUUUULLLLUUUUSSSS-1). If CCCCAAAAEEEESSSSAAAARRRR____MMMMOOOODDDDUUUULLLLUUUUSSSS is equal to 0,  the
     result is undefined.

     This function is defined by the following equality:


        CCCCAAAAEEEESSSSAAAARRRR____SSSSTTTTAAAATTTTEEEE____0000____HHHHAAAASSSSHHHH ((((CCCCAAAAEEEESSSSAAAARRRR____SSSS,,,, CCCCAAAAEEEESSSSAAAARRRR____MMMMOOOODDDDUUUULLLLUUUUSSSS)))) ====
        CCCCAAAAEEEESSSSAAAARRRR____HHHHAAAASSSSHHHH____SSSSTTTTAAAATTTTEEEE ((((CCCCAAAAEEEESSSSAAAARRRR____SSSS,,,, CCCCAAAAEEEESSSSAAAARRRR____MMMMOOOODDDDUUUULLLLUUUUSSSS))))

     where CCCCAAAAEEEESSSSAAAARRRR____HHHHAAAASSSSHHHH____SSSSTTTTAAAATTTTEEEE(((()))) is the hashing  function  exported
     by the graph module.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____SSSSTTTTAAAATTTTEEEE____1111____HHHHAAAASSSSHHHH

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL CCCCAAAAEEEESSSSAAAARRRR____SSSSTTTTAAAATTTTEEEE____1111____HHHHAAAASSSSHHHH ((((CCCCAAAAEEEESSSSAAAARRRR____SSSS,,,, CCCCAAAAEEEESSSSAAAARRRR____MMMMOOOODDDDUUUULLLLUUUUSSSS))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSTTTTAAAATTTTEEEE CCCCAAAAEEEESSSSAAAARRRR____SSSS;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL CCCCAAAAEEEESSSSAAAARRRR____MMMMOOOODDDDUUUULLLLUUUUSSSS;;;;
        {{{{ ............ }}}}

     This function computes a hash-value for the state pointed to
     by  CCCCAAAAEEEESSSSAAAARRRR____SSSS  and  returns this value, which is in the range
     0..(CCCCAAAAEEEESSSSAAAARRRR____MMMMOOOODDDDUUUULLLLUUUUSSSS-1). If CCCCAAAAEEEESSSSAAAARRRR____MMMMOOOODDDDUUUULLLLUUUUSSSS is equal to 0,  the



(C) INRIA     Last change: 2020/02/11 (version 1.3)             5






OPEN/CAESAR MANUAL                             caesar_hash(LOCAL)



     result is undefined.

     This function is defined by the following equality:


        CCCCAAAAEEEESSSSAAAARRRR____SSSSTTTTAAAATTTTEEEE____1111____HHHHAAAASSSSHHHH ((((CCCCAAAAEEEESSSSAAAARRRR____SSSS,,,, CCCCAAAAEEEESSSSAAAARRRR____MMMMOOOODDDDUUUULLLLUUUUSSSS)))) ====
        CCCCAAAAEEEESSSSAAAARRRR____1111____HHHHAAAASSSSHHHH ((((CCCCAAAAEEEESSSSAAAARRRR____SSSS,,,, CCCCAAAAEEEESSSSAAAARRRR____HHHHAAAASSSSHHHH____SSSSIIIIZZZZEEEE____SSSSTTTTAAAATTTTEEEE (((()))),,,, CCCCAAAAEEEESSSSAAAARRRR____MMMMOOOODDDDUUUULLLLUUUUSSSS))))

     Additional functions


        CCCCAAAAEEEESSSSAAAARRRR____SSSSTTTTAAAATTTTEEEE____2222____HHHHAAAASSSSHHHH ((((CCCCAAAAEEEESSSSAAAARRRR____SSSS,,,, CCCCAAAAEEEESSSSAAAARRRR____MMMMOOOODDDDUUUULLLLUUUUSSSS))))
        CCCCAAAAEEEESSSSAAAARRRR____SSSSTTTTAAAATTTTEEEE____3333____HHHHAAAASSSSHHHH ((((CCCCAAAAEEEESSSSAAAARRRR____SSSS,,,, CCCCAAAAEEEESSSSAAAARRRR____MMMMOOOODDDDUUUULLLLUUUUSSSS))))
        CCCCAAAAEEEESSSSAAAARRRR____SSSSTTTTAAAATTTTEEEE____4444____HHHHAAAASSSSHHHH ((((CCCCAAAAEEEESSSSAAAARRRR____SSSS,,,, CCCCAAAAEEEESSSSAAAARRRR____MMMMOOOODDDDUUUULLLLUUUUSSSS))))
        CCCCAAAAEEEESSSSAAAARRRR____SSSSTTTTAAAATTTTEEEE____5555____HHHHAAAASSSSHHHH ((((CCCCAAAAEEEESSSSAAAARRRR____SSSS,,,, CCCCAAAAEEEESSSSAAAARRRR____MMMMOOOODDDDUUUULLLLUUUUSSSS))))
        CCCCAAAAEEEESSSSAAAARRRR____SSSSTTTTAAAATTTTEEEE____6666____HHHHAAAASSSSHHHH ((((CCCCAAAAEEEESSSSAAAARRRR____SSSS,,,, CCCCAAAAEEEESSSSAAAARRRR____MMMMOOOODDDDUUUULLLLUUUUSSSS))))
        CCCCAAAAEEEESSSSAAAARRRR____SSSSTTTTAAAATTTTEEEE____7777____HHHHAAAASSSSHHHH ((((CCCCAAAAEEEESSSSAAAARRRR____SSSS,,,, CCCCAAAAEEEESSSSAAAARRRR____MMMMOOOODDDDUUUULLLLUUUUSSSS))))

     are defined in the same way as CCCCAAAAEEEESSSSAAAARRRR____SSSSTTTTAAAATTTTEEEE____1111____HHHHAAAASSSSHHHH(((()))).


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____LLLLAAAABBBBEEEELLLL____0000____HHHHAAAASSSSHHHH

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL CCCCAAAAEEEESSSSAAAARRRR____LLLLAAAABBBBEEEELLLL____0000____HHHHAAAASSSSHHHH ((((CCCCAAAAEEEESSSSAAAARRRR____LLLL,,,, CCCCAAAAEEEESSSSAAAARRRR____MMMMOOOODDDDUUUULLLLUUUUSSSS))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____LLLLAAAABBBBEEEELLLL CCCCAAAAEEEESSSSAAAARRRR____LLLL;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL CCCCAAAAEEEESSSSAAAARRRR____MMMMOOOODDDDUUUULLLLUUUUSSSS;;;;
        {{{{ ............ }}}}

     This function computes a hash-value for the label pointed to
     by  CCCCAAAAEEEESSSSAAAARRRR____LLLL  and  returns this value, which is in the range
     0..(CCCCAAAAEEEESSSSAAAARRRR____MMMMOOOODDDDUUUULLLLUUUUSSSS-1). If CCCCAAAAEEEESSSSAAAARRRR____MMMMOOOODDDDUUUULLLLUUUUSSSS is equal to 0,  the
     result is undefined.

     This function is defined by the following equality:


        CCCCAAAAEEEESSSSAAAARRRR____LLLLAAAABBBBEEEELLLL____0000____HHHHAAAASSSSHHHH ((((CCCCAAAAEEEESSSSAAAARRRR____LLLL,,,, CCCCAAAAEEEESSSSAAAARRRR____MMMMOOOODDDDUUUULLLLUUUUSSSS)))) ====
        CCCCAAAAEEEESSSSAAAARRRR____HHHHAAAASSSSHHHH____LLLLAAAABBBBEEEELLLL ((((CCCCAAAAEEEESSSSAAAARRRR____LLLL,,,, CCCCAAAAEEEESSSSAAAARRRR____MMMMOOOODDDDUUUULLLLUUUUSSSS))))

     where CCCCAAAAEEEESSSSAAAARRRR____HHHHAAAASSSSHHHH____LLLLAAAABBBBEEEELLLL(((()))) is the hashing  function  exported
     by the graph module.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____LLLLAAAABBBBEEEELLLL____1111____HHHHAAAASSSSHHHH

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL CCCCAAAAEEEESSSSAAAARRRR____LLLLAAAABBBBEEEELLLL____1111____HHHHAAAASSSSHHHH ((((CCCCAAAAEEEESSSSAAAARRRR____LLLL,,,, CCCCAAAAEEEESSSSAAAARRRR____MMMMOOOODDDDUUUULLLLUUUUSSSS))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____LLLLAAAABBBBEEEELLLL CCCCAAAAEEEESSSSAAAARRRR____LLLL;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL CCCCAAAAEEEESSSSAAAARRRR____MMMMOOOODDDDUUUULLLLUUUUSSSS;;;;



(C) INRIA     Last change: 2020/02/11 (version 1.3)             6






OPEN/CAESAR MANUAL                             caesar_hash(LOCAL)



        {{{{ ............ }}}}

     This function computes a hash-value for the label pointed to
     by  CCCCAAAAEEEESSSSAAAARRRR____LLLL  and  returns this value, which is in the range
     0..(CCCCAAAAEEEESSSSAAAARRRR____MMMMOOOODDDDUUUULLLLUUUUSSSS-1). If CCCCAAAAEEEESSSSAAAARRRR____MMMMOOOODDDDUUUULLLLUUUUSSSS is equal to 0,  the
     result is undefined.

     This function is defined by the following equality:


        CCCCAAAAEEEESSSSAAAARRRR____LLLLAAAABBBBEEEELLLL____1111____HHHHAAAASSSSHHHH ((((CCCCAAAAEEEESSSSAAAARRRR____LLLL,,,, CCCCAAAAEEEESSSSAAAARRRR____MMMMOOOODDDDUUUULLLLUUUUSSSS)))) ====
        CCCCAAAAEEEESSSSAAAARRRR____1111____HHHHAAAASSSSHHHH ((((CCCCAAAAEEEESSSSAAAARRRR____LLLL,,,, CCCCAAAAEEEESSSSAAAARRRR____HHHHAAAASSSSHHHH____SSSSIIIIZZZZEEEE____LLLLAAAABBBBEEEELLLL (((()))),,,, CCCCAAAAEEEESSSSAAAARRRR____MMMMOOOODDDDUUUULLLLUUUUSSSS))))

     Additional functions


        CCCCAAAAEEEESSSSAAAARRRR____LLLLAAAABBBBEEEELLLL____2222____HHHHAAAASSSSHHHH ((((CCCCAAAAEEEESSSSAAAARRRR____LLLL,,,, CCCCAAAAEEEESSSSAAAARRRR____MMMMOOOODDDDUUUULLLLUUUUSSSS))))
        CCCCAAAAEEEESSSSAAAARRRR____LLLLAAAABBBBEEEELLLL____3333____HHHHAAAASSSSHHHH ((((CCCCAAAAEEEESSSSAAAARRRR____LLLL,,,, CCCCAAAAEEEESSSSAAAARRRR____MMMMOOOODDDDUUUULLLLUUUUSSSS))))
        CCCCAAAAEEEESSSSAAAARRRR____LLLLAAAABBBBEEEELLLL____4444____HHHHAAAASSSSHHHH ((((CCCCAAAAEEEESSSSAAAARRRR____LLLL,,,, CCCCAAAAEEEESSSSAAAARRRR____MMMMOOOODDDDUUUULLLLUUUUSSSS))))
        CCCCAAAAEEEESSSSAAAARRRR____LLLLAAAABBBBEEEELLLL____5555____HHHHAAAASSSSHHHH ((((CCCCAAAAEEEESSSSAAAARRRR____LLLL,,,, CCCCAAAAEEEESSSSAAAARRRR____MMMMOOOODDDDUUUULLLLUUUUSSSS))))
        CCCCAAAAEEEESSSSAAAARRRR____LLLLAAAABBBBEEEELLLL____6666____HHHHAAAASSSSHHHH ((((CCCCAAAAEEEESSSSAAAARRRR____LLLL,,,, CCCCAAAAEEEESSSSAAAARRRR____MMMMOOOODDDDUUUULLLLUUUUSSSS))))
        CCCCAAAAEEEESSSSAAAARRRR____LLLLAAAABBBBEEEELLLL____7777____HHHHAAAASSSSHHHH ((((CCCCAAAAEEEESSSSAAAARRRR____LLLL,,,, CCCCAAAAEEEESSSSAAAARRRR____MMMMOOOODDDDUUUULLLLUUUUSSSS))))

     are defined in the same way as CCCCAAAAEEEESSSSAAAARRRR____LLLLAAAABBBBEEEELLLL____1111____HHHHAAAASSSSHHHH(((()))).


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____SSSSTTTTRRRRIIIINNNNGGGG____0000____HHHHAAAASSSSHHHH

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL CCCCAAAAEEEESSSSAAAARRRR____SSSSTTTTRRRRIIIINNNNGGGG____0000____HHHHAAAASSSSHHHH ((((CCCCAAAAEEEESSSSAAAARRRR____SSSS,,,, CCCCAAAAEEEESSSSAAAARRRR____MMMMOOOODDDDUUUULLLLUUUUSSSS))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSTTTTRRRRIIIINNNNGGGG CCCCAAAAEEEESSSSAAAARRRR____SSSS;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL CCCCAAAAEEEESSSSAAAARRRR____MMMMOOOODDDDUUUULLLLUUUUSSSS;;;;
        {{{{ ............ }}}}

     This function  computes  a  hash-value  for  the  (variable-
     length,  null-terminated)  character  string  pointed  to by
     CCCCAAAAEEEESSSSAAAARRRR____SSSS and returns this  value,  which  is  in  the  range
     0..(CCCCAAAAEEEESSSSAAAARRRR____MMMMOOOODDDDUUUULLLLUUUUSSSS-1).  If CCCCAAAAEEEESSSSAAAARRRR____MMMMOOOODDDDUUUULLLLUUUUSSSS is equal to 0, the
     result is undefined.

      ............................................................

AAAAUUUUTTTTHHHHOOOORRRR((((SSSS))))
     Hubert Garavel

FFFFIIIILLLLEEEESSSS
     $$$$CCCCAAAADDDDPPPP////iiiinnnnccccllll////ccccaaaaeeeessssaaaarrrr____ggggrrrraaaapppphhhh....hhhh     interface of the graph module
     $$$$CCCCAAAADDDDPPPP////iiiinnnnccccllll////ccccaaaaeeeessssaaaarrrr____****....hhhh         interfaces  of   the   storage
                                   module
     $$$$CCCCAAAADDDDPPPP////bbbbiiiinnnn....````aaaarrrrcccchhhh````////lllliiiibbbbccccaaaaeeeessssaaaarrrr....aaaa  object  code  of  the  storage
                                   module



(C) INRIA     Last change: 2020/02/11 (version 1.3)             7






OPEN/CAESAR MANUAL                             caesar_hash(LOCAL)



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


































(C) INRIA     Last change: 2020/02/11 (version 1.3)             8



