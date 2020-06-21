


OPEN/CAESAR MANUAL                     caesar_diagnostic_1(LOCAL)



NNNNAAAAMMMMEEEE
     caesar_diagnostic_1  -  the  ``diagnostic_1''   library   of
     OPEN/CAESAR

PPPPUUUURRRRPPPPOOOOSSSSEEEE
     The ``diagnostic_1'' library provides primitives for  manag-
     ing diagnostics.


UUUUSSSSAAAAGGGGEEEE
     The ``diagnostic_1'' library consists of:

     -    a predefined header file ccccaaaaeeeessssaaaarrrr____ddddiiiiaaaaggggnnnnoooossssttttiiiicccc____1111....hhhh;

     -    the precompiled library file lllliiiibbbbccccaaaaeeeessssaaaarrrr....aaaa, which  imple-
          ments the features described in ccccaaaaeeeessssaaaarrrr____ddddiiiiaaaaggggnnnnoooossssttttiiiicccc____1111....hhhh.

     Note: The ``diagnostic_1'' library is a software layer built
     above  the  primitives offered by the ``standard'', ``edge''
     and ``stack_1'' libraries,  and  by  the  _O_P_E_N/_C_A_E_S_A_R  graph
     module.

     Note: The ``diagnostic_1'' library relies  on  the  ``edge''
     and ``stack_1'' libraries. Therefore, when using the ``diag-
     nostic_1'' library, there are  restrictions  concerning  the
     use  of  the  ``edge''  and  ``stack_1'' library primitives.
     These restrictions are listed in the sequel.


DDDDEEEESSSSCCCCRRRRIIIIPPPPTTTTIIIIOOOONNNN
     A ``diagnostic'' is an execution sequence, i.e., a  list  of
     states  and  transitions  starting from the initial state of
     the graph and leading to a given state.

     The ``size'' of a diagnostic is defined to be the number  of
     states  (not the number of transitions) in the corresponding
     execution sequence. This definition is compatible  with  the
     convention used for function CCCCAAAAEEEESSSSAAAARRRR____DDDDEEEEPPPPTTTTHHHH____SSSSTTTTAAAACCCCKKKK____1111(((()))).

     Diagnostics are to be used during depth-first graph explora-
     tion.  For this reason, this library uses (and is compatible
     with) stacks provided by the ``stack_1'' library. Let's con-
     sider,  for  instance,  an  _O_P_E_N/_C_A_E_S_A_R  user  program  that
     searches for deadlocks.  Every  time  a  deadlock  state  is
     detected,  the appropriate diagnostic is the contents of the
     stack, i.e., the execution sequence leading from the initial
     state to the current deadlock state.

     The ``diagnostic_1'' allows to control the  way  diagnostics
     are  printed.  For  instance,  it allows to display only the
     shortest diagnostic sequence detected. Other  ``strategies''
     are  also  available.  The  data  structure  used  to  store



(C) INRIA     Last change: 2020/02/11 (version 1.1)             1






OPEN/CAESAR MANUAL                     caesar_diagnostic_1(LOCAL)



     diagnostics and related information is called a ``diagnostic
     structure''.


FFFFEEEEAAAATTTTUUUURRRREEEESSSS
      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____DDDDIIIIAAAAGGGGNNNNOOOOSSSSTTTTIIIICCCC____1111

     ttttyyyyppppeeeeddddeeeeffff CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____AAAABBBBSSSSTTTTRRRRAAAACCCCTTTT ((((............)))) CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____DDDDIIIIAAAAGGGGNNNNOOOOSSSSTTTTIIIICCCC____1111;;;;

     This type denotes a pointer to the  concrete  representation
     of   a   diagnostic  structure,  which  is  supposed  to  be
     ``opaque''.

      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSTTTTRRRRAAAATTTTEEEEGGGGYYYY____DDDDIIIIAAAAGGGGNNNNOOOOSSSSTTTTIIIICCCC____1111

     ttttyyyyppppeeeeddddeeeeffff eeeennnnuuuummmm {{{{
          CCCCAAAAEEEESSSSAAAARRRR____NNNNOOOONNNNEEEE____DDDDIIIIAAAAGGGGNNNNOOOOSSSSTTTTIIIICCCC____1111,,,,
          CCCCAAAAEEEESSSSAAAARRRR____AAAALLLLLLLL____DDDDIIIIAAAAGGGGNNNNOOOOSSSSTTTTIIIICCCC____1111,,,,
          CCCCAAAAEEEESSSSAAAARRRR____FFFFIIIIRRRRSSSSTTTT____DDDDIIIIAAAAGGGGNNNNOOOOSSSSTTTTIIIICCCC____1111,,,,
          CCCCAAAAEEEESSSSAAAARRRR____DDDDEEEECCCCRRRREEEEAAAASSSSIIIINNNNGGGG____DDDDIIIIAAAAGGGGNNNNOOOOSSSSTTTTIIIICCCC____1111,,,,
          CCCCAAAAEEEESSSSAAAARRRR____SSSSHHHHOOOORRRRTTTTEEEESSSSTTTT____DDDDIIIIAAAAGGGGNNNNOOOOSSSSTTTTIIIICCCC____1111
     }}}}    CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSTTTTRRRRAAAATTTTEEEEGGGGYYYY____DDDDIIIIAAAAGGGGNNNNOOOOSSSSTTTTIIIICCCC____1111;;;;

     This enumerated type defines the ``strategy'' used to  print
     diagnostics  during  graph  exploration. Two steps are to be
     distinguished: every time an execution sequence of  interest
     is     detected,    it    is    ``recorded''    using    the
     CCCCAAAAEEEESSSSAAAARRRR____RRRREEEECCCCOOOORRRRDDDD____DDDDIIIIAAAAGGGGNNNNOOOOSSSSTTTTIIIICCCC____1111(((()))) function  defined  below.  When
     the   depth-first  exploration  is  completed,  a  ``summary
     request''        is        performed        using        the
     CCCCAAAAEEEESSSSAAAARRRR____SSSSUUUUMMMMMMMMAAAARRRRIIIIZZZZEEEE____DDDDIIIIAAAAGGGGNNNNOOOOSSSSTTTTIIIICCCC____1111(((())))  function defined below. The
     effect of these two functions depends on  the  chosen  stra-
     tegy:


     -    With CCCCAAAAEEEESSSSAAAARRRR____NNNNOOOONNNNEEEE____DDDDIIIIAAAAGGGGNNNNOOOOSSSSTTTTIIIICCCC____1111, only the result  of  the
          exploration  is printed (i.e., some diagnostic has been
          found or not). Diagnostics themselves are not printed.

     -    With  CCCCAAAAEEEESSSSAAAARRRR____AAAALLLLLLLL____DDDDIIIIAAAAGGGGNNNNOOOOSSSSTTTTIIIICCCC____1111,  all   diagnostics   are
          printed when they are recorded.

     -    With CCCCAAAAEEEESSSSAAAARRRR____FFFFIIIIRRRRSSSSTTTT____DDDDIIIIAAAAGGGGNNNNOOOOSSSSTTTTIIIICCCC____1111, only the first diagnos-
          tic  is printed when it is recorded; the next ones will
          not be printed.

     -    With CCCCAAAAEEEESSSSAAAARRRR____DDDDEEEECCCCRRRREEEEAAAASSSSIIIINNNNGGGG____DDDDIIIIAAAAGGGGNNNNOOOOSSSSTTTTIIIICCCC____1111, the first diagnos-
          tic  is printed when it is recorded; the next ones will



(C) INRIA     Last change: 2020/02/11 (version 1.1)             2






OPEN/CAESAR MANUAL                     caesar_diagnostic_1(LOCAL)



          be printed iff their size is strictly smaller than  all
          previously recorded diagnostics.

     -    With CCCCAAAAEEEESSSSAAAARRRR____SSSSHHHHOOOORRRRTTTTEEEESSSSTTTT____DDDDIIIIAAAAGGGGNNNNOOOOSSSSTTTTIIIICCCC____1111, diagnostics are  not
          printed when they are recorded, but the diagnostic with
          the smallest size is stored in a diagnostic  structure.
          This  shortest diagnostic (if any) will be printed when
          a summary request is emitted.

      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTEEEE____DDDDIIIIAAAAGGGGNNNNOOOOSSSSTTTTIIIICCCC____1111

     vvvvooooiiiidddd CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTEEEE____DDDDIIIIAAAAGGGGNNNNOOOOSSSSTTTTIIIICCCC____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____DDDD,,,, CCCCAAAAEEEESSSSAAAARRRR____SSSSTTTTRRRRAAAATTTTEEEEGGGGYYYY,,,,
                                      CCCCAAAAEEEESSSSAAAARRRR____DDDDEEEEPPPPTTTTHHHH,,,, CCCCAAAAEEEESSSSAAAARRRR____FFFFIIIILLLLEEEE,,,,
                                      CCCCAAAAEEEESSSSAAAARRRR____PPPPRRRROOOOGGGGRRRREEEESSSSSSSS,,,, CCCCAAAAEEEESSSSAAAARRRR____HHHHEEEEAAAADDDDEEEERRRR,,,,
                                      CCCCAAAAEEEESSSSAAAARRRR____FFFFOOOOOOOOTTTTEEEERRRR,,,, CCCCAAAAEEEESSSSAAAARRRR____SSSSEEEEPPPPAAAARRRRAAAATTTTOOOORRRR,,,,
                                      CCCCAAAAEEEESSSSAAAARRRR____RRRREEEEPPPPOOOORRRRTTTT))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____DDDDIIIIAAAAGGGGNNNNOOOOSSSSTTTTIIIICCCC____1111 ****CCCCAAAAEEEESSSSAAAARRRR____DDDD;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSTTTTRRRRAAAATTTTEEEEGGGGYYYY____DDDDIIIIAAAAGGGGNNNNOOOOSSSSTTTTIIIICCCC____1111 CCCCAAAAEEEESSSSAAAARRRR____SSSSTTTTRRRRAAAATTTTEEEEGGGGYYYY;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL CCCCAAAAEEEESSSSAAAARRRR____DDDDEEEEPPPPTTTTHHHH;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____FFFFIIIILLLLEEEE CCCCAAAAEEEESSSSAAAARRRR____FFFFIIIILLLLEEEE;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSTTTTRRRRIIIINNNNGGGG CCCCAAAAEEEESSSSAAAARRRR____PPPPRRRROOOOGGGGRRRREEEESSSSSSSS;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSTTTTRRRRIIIINNNNGGGG CCCCAAAAEEEESSSSAAAARRRR____HHHHEEEEAAAADDDDEEEERRRR;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSTTTTRRRRIIIINNNNGGGG CCCCAAAAEEEESSSSAAAARRRR____FFFFOOOOOOOOTTTTEEEERRRR;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSTTTTRRRRIIIINNNNGGGG CCCCAAAAEEEESSSSAAAARRRR____SSSSEEEEPPPPAAAARRRRAAAATTTTOOOORRRR;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSTTTTRRRRIIIINNNNGGGG CCCCAAAAEEEESSSSAAAARRRR____RRRREEEEPPPPOOOORRRRTTTT;;;;
        {{{{ ............ }}}}

     This  procedure  allocates  a  diagnostic  structure   using
     CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTEEEE(((()))) and assigns its address to ****CCCCAAAAEEEESSSSAAAARRRR____DDDD. If the
     allocation fails, the NNNNUUUULLLLLLLL value is assigned to ****CCCCAAAAEEEESSSSAAAARRRR____DDDD.

     Note: because CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____DDDDIIIIAAAAGGGGNNNNOOOOSSSSTTTTIIIICCCC____1111 is  a  pointer  type,
     any  variable CCCCAAAAEEEESSSSAAAARRRR____DDDD of type CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____DDDDIIIIAAAAGGGGNNNNOOOOSSSSTTTTIIIICCCC____1111 must
     be allocated before used, for instance using:

             CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTEEEE____DDDDIIIIAAAAGGGGNNNNOOOOSSSSTTTTIIIICCCC____1111 ((((&&&&CCCCAAAAEEEESSSSAAAARRRR____DDDD,,,, ............))));;;;


     Note:     Before     calling     this     procedure,     the
     CCCCAAAAEEEESSSSAAAARRRR____IIIINNNNIIIITTTT____SSSSTTTTAAAACCCCKKKK____1111(((())))  procedure  of the ``stack_1'' library
     should  have  been  invoked  (because  the  ``diagnostic_1''
     library  uses  the  ``stack_1'' library). Also, the restric-
     tions concerning the CCCCAAAAEEEESSSSAAAARRRR____IIIINNNNIIIITTTT____SSSSTTTTAAAACCCCKKKK____1111(((()))) procedure  should
     be observed.

     The actual values of the remaining formal parameters will be
     stored and associated to the diagnostic structure pointed to
     by ****CCCCAAAAEEEESSSSAAAARRRR____DDDD.

     The value of CCCCAAAAEEEESSSSAAAARRRR____SSSSTTTTRRRRAAAATTTTEEEEGGGGYYYY determines  the  strategy  used



(C) INRIA     Last change: 2020/02/11 (version 1.1)             3






OPEN/CAESAR MANUAL                     caesar_diagnostic_1(LOCAL)



     for this diagnostic structure.

     The value of CCCCAAAAEEEESSSSAAAARRRR____DDDDEEEEPPPPTTTTHHHH determines the  ``maximal  depth''
     used  for this diagnostic structure, i.e., an upper bound on
     the sizes of the diagnostics. If CCCCAAAAEEEESSSSAAAARRRR____DDDDEEEEPPPPTTTTHHHH  is  equal  to
     zero, there is no upper bound.

     The value of CCCCAAAAEEEESSSSAAAARRRR____FFFFIIIILLLLEEEE determines the output file to which
     the  diagnostics  will  be printed. Before any diagnostic is
     printed, CCCCAAAAEEEESSSSAAAARRRR____FFFFIIIILLLLEEEE must have  been  properly  opened,  for
     instance using ffffooooppppeeeennnn((((3333)))).

     The values of CCCCAAAAEEEESSSSAAAARRRR____PPPPRRRROOOOGGGGRRRREEEESSSSSSSS, CCCCAAAAEEEESSSSAAAARRRR____HHHHEEEEAAAADDDDEEEERRRR, CCCCAAAAEEEESSSSAAAARRRR____FFFFOOOOOOOOTTTTEEEERRRR,
     CCCCAAAAEEEESSSSAAAARRRR____SSSSEEEEPPPPAAAARRRRAAAATTTTOOOORRRR, and CCCCAAAAEEEESSSSAAAARRRR____RRRREEEEPPPPOOOORRRRTTTT are character strings to
     be used for printing the diagnostics. The exact semantics of
     these  parameters  will not be defined here. For interopera-
     bility with the other tools of the CADP toolset (see the sssseeeeqqqq
     manual  page  for  a  definition  of  the SEQ format), it is
     advised to use the following actual values:


        CCCCAAAAEEEESSSSAAAARRRR____PPPPRRRROOOOGGGGRRRREEEESSSSSSSS  ==== """"************ sssseeeeqqqquuuueeeennnncccceeee((((ssss)))) ffffoooouuuunnnndddd aaaatttt ddddeeeepppptttthhhh """"
        CCCCAAAAEEEESSSSAAAARRRR____HHHHEEEEAAAADDDDEEEERRRR    ==== """"************ sssseeeeqqqquuuueeeennnncccceeee ffffoooouuuunnnndddd aaaatttt ddddeeeepppptttthhhh %%%%uuuu\\\\nnnn\\\\nnnn\\\\000000001111<<<<iiiinnnniiiittttiiiiaaaallll ssssttttaaaatttteeee>>>>\\\\000000002222\\\\nnnn""""
        CCCCAAAAEEEESSSSAAAARRRR____FFFFOOOOOOOOTTTTEEEERRRR    ==== """"\\\\000000001111<<<<ggggooooaaaallll ssssttttaaaatttteeee>>>>\\\\000000002222\\\\nnnn\\\\nnnn""""
        CCCCAAAAEEEESSSSAAAARRRR____SSSSEEEEPPPPAAAARRRRAAAATTTTOOOORRRR ==== """"[[[[]]]]\\\\nnnn\\\\nnnn""""
        CCCCAAAAEEEESSSSAAAARRRR____RRRREEEEPPPPOOOORRRRTTTT    ==== """"************ nnnnoooo sssseeeeqqqquuuueeeennnncccceeee ffffoooouuuunnnndddd\\\\nnnn\\\\nnnn""""

     or, depending on the context:


         CCCCAAAAEEEESSSSAAAARRRR____PPPPRRRROOOOGGGGRRRREEEESSSSSSSS  ==== """"************ ddddeeeeaaaaddddlllloooocccckkkk((((ssss)))) ffffoooouuuunnnndddd aaaatttt ddddeeeepppptttthhhh """"
         CCCCAAAAEEEESSSSAAAARRRR____HHHHEEEEAAAADDDDEEEERRRR    ==== """"************ ddddeeeeaaaaddddlllloooocccckkkk ffffoooouuuunnnndddd aaaatttt ddddeeeepppptttthhhh %%%%uuuu\\\\nnnn\\\\nnnn\\\\000000001111<<<<iiiinnnniiiittttiiiiaaaallll ssssttttaaaatttteeee>>>>\\\\000000002222\\\\nnnn""""
         CCCCAAAAEEEESSSSAAAARRRR____FFFFOOOOOOOOTTTTEEEERRRR    ==== """"<<<<ddddeeeeaaaaddddlllloooocccckkkk>>>>\\\\nnnn\\\\nnnn""""
         CCCCAAAAEEEESSSSAAAARRRR____SSSSEEEEPPPPAAAARRRRAAAATTTTOOOORRRR ==== """"[[[[]]]]\\\\nnnn\\\\nnnn""""
         CCCCAAAAEEEESSSSAAAARRRR____RRRREEEEPPPPOOOORRRRTTTT    ==== """"************ nnnnoooo ddddeeeeaaaaddddlllloooocccckkkk ffffoooouuuunnnndddd\\\\nnnn\\\\nnnn""""


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____DDDDEEEELLLLEEEETTTTEEEE____DDDDIIIIAAAAGGGGNNNNOOOOSSSSTTTTIIIICCCC____1111

     vvvvooooiiiidddd CCCCAAAAEEEESSSSAAAARRRR____DDDDEEEELLLLEEEETTTTEEEE____DDDDIIIIAAAAGGGGNNNNOOOOSSSSTTTTIIIICCCC____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____DDDD))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____DDDDIIIIAAAAGGGGNNNNOOOOSSSSTTTTIIIICCCC____1111 ****CCCCAAAAEEEESSSSAAAARRRR____DDDD;;;;
        {{{{ ............ }}}}

     This procedure frees the memory space corresponding  to  the
     diagnostic   structure   pointed   to   by  ****CCCCAAAAEEEESSSSAAAARRRR____DDDD  using
     CCCCAAAAEEEESSSSAAAARRRR____DDDDEEEELLLLEEEETTTTEEEE(((()))). Afterwards, the NNNNUUUULLLLLLLL value is  assigned  to
     ****CCCCAAAAEEEESSSSAAAARRRR____DDDD.

      ............................................................




(C) INRIA     Last change: 2020/02/11 (version 1.1)             4






OPEN/CAESAR MANUAL                     caesar_diagnostic_1(LOCAL)



  CCCCAAAAEEEESSSSAAAARRRR____RRRREEEECCCCOOOORRRRDDDD____DDDDIIIIAAAAGGGGNNNNOOOOSSSSTTTTIIIICCCC____1111

     vvvvooooiiiidddd CCCCAAAAEEEESSSSAAAARRRR____RRRREEEECCCCOOOORRRRDDDD____DDDDIIIIAAAAGGGGNNNNOOOOSSSSTTTTIIIICCCC____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____DDDD,,,, CCCCAAAAEEEESSSSAAAARRRR____KKKK))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____DDDDIIIIAAAAGGGGNNNNOOOOSSSSTTTTIIIICCCC____1111 CCCCAAAAEEEESSSSAAAARRRR____DDDD;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSTTTTAAAACCCCKKKK____1111 CCCCAAAAEEEESSSSAAAARRRR____KKKK;;;;
        {{{{ ............ }}}}

     This procedure records into the diagnostic structure pointed
     to  by  ****CCCCAAAAEEEESSSSAAAARRRR____DDDD  the  diagnostic  contained  in  the stack
     pointed to by ****CCCCAAAAEEEESSSSAAAARRRR____KKKK. The stack pointed to  by  ****CCCCAAAAEEEESSSSAAAARRRR____KKKK
     should  contain  at least one item (the initial state of the
     sequence); if it is empty,  the  result  is  undefined.  The
     effects of this procedure depend on the strategy and maximal
     depth associated with the diagnostic structure:


     -    With CCCCAAAAEEEESSSSAAAARRRR____NNNNOOOONNNNEEEE____DDDDIIIIAAAAGGGGNNNNOOOOSSSSTTTTIIIICCCC____1111, the  diagnostic  is  not
          printed but stored into the diagnostic structure.

     -    With CCCCAAAAEEEESSSSAAAARRRR____AAAALLLLLLLL____DDDDIIIIAAAAGGGGNNNNOOOOSSSSTTTTIIIICCCC____1111, the diagnostic is immedi-
          ately printed.

     -    With  CCCCAAAAEEEESSSSAAAARRRR____FFFFIIIIRRRRSSSSTTTT____DDDDIIIIAAAAGGGGNNNNOOOOSSSSTTTTIIIICCCC____1111,  the   diagnostic   is
          immediately  printed  if  it  is  the  first  one to be
          recorded; otherwise nothing is done.

     -    With CCCCAAAAEEEESSSSAAAARRRR____DDDDEEEECCCCRRRREEEEAAAASSSSIIIINNNNGGGG____DDDDIIIIAAAAGGGGNNNNOOOOSSSSTTTTIIIICCCC____1111, the diagnostic  is
          immediately  printed  if its size is less or equal than
          the maximal depth (if the maximal depth is not equal to
          zero)  and  strictly  less than the sizes of all previ-
          ously recorded diagnostics.

     -    With CCCCAAAAEEEESSSSAAAARRRR____SSSSHHHHOOOORRRRTTTTEEEESSSSTTTT____DDDDIIIIAAAAGGGGNNNNOOOOSSSSTTTTIIIICCCC____1111,  the  diagnostic  is
          not printed but stored into the diagnostic structure if
          its size os less or equal than the  maximal  depth  (if
          the  maximal  depth  is not equal to zero) and strictly
          less than the sizes of all previously recorded diagnos-
          tics.   If  the character string CCCCAAAAEEEESSSSAAAARRRR____PPPPRRRROOOOGGGGRRRREEEESSSSSSSS speci-
          fied for ****CCCCAAAAEEEESSSSAAAARRRR____DDDD is  not  the  NNNNUUUULLLLLLLL  pointer,  it  is
          printed,  together  with the size of the recorded diag-
          nostic.

      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____SSSSUUUUMMMMMMMMAAAARRRRIIIIZZZZEEEE____DDDDIIIIAAAAGGGGNNNNOOOOSSSSTTTTIIIICCCC____1111

     vvvvooooiiiidddd CCCCAAAAEEEESSSSAAAARRRR____SSSSUUUUMMMMMMMMAAAARRRRIIIIZZZZEEEE____DDDDIIIIAAAAGGGGNNNNOOOOSSSSTTTTIIIICCCC____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____DDDD))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____DDDDIIIIAAAAGGGGNNNNOOOOSSSSTTTTIIIICCCC____1111 CCCCAAAAEEEESSSSAAAARRRR____DDDD;;;;
        {{{{ ............ }}}}

     This procedure summarizes the current status of the diagnos-
     tic  structure  pointed to by ****CCCCAAAAEEEESSSSAAAARRRR____DDDD. The effects of this



(C) INRIA     Last change: 2020/02/11 (version 1.1)             5






OPEN/CAESAR MANUAL                     caesar_diagnostic_1(LOCAL)



     procedure depends on the strategy associated with the  diag-
     nostic structure:


     -    With  CCCCAAAAEEEESSSSAAAARRRR____NNNNOOOONNNNEEEE____DDDDIIIIAAAAGGGGNNNNOOOOSSSSTTTTIIIICCCC____1111,  the  result   of   the
          exploration  is  displayed:  if  diagnostics  have been
          recorded, the size of the most recently recorded one is
          printed;  otherwise, the character string CCCCAAAAEEEESSSSAAAARRRR____RRRREEEEPPPPOOOORRRRTTTT
          is printed if no diagnostic has been recorded into  the
          diagnostic structure.

     -    With  CCCCAAAAEEEESSSSAAAARRRR____AAAALLLLLLLL____DDDDIIIIAAAAGGGGNNNNOOOOSSSSTTTTIIIICCCC____1111,  the  character   string
          CCCCAAAAEEEESSSSAAAARRRR____RRRREEEEPPPPOOOORRRRTTTT is printed if no diagnostic has been pre-
          viously recorded into the diagnostic structure.

     -    With    CCCCAAAAEEEESSSSAAAARRRR____FFFFIIIIRRRRSSSSTTTT____DDDDIIIIAAAAGGGGNNNNOOOOSSSSTTTTIIIICCCC____1111,    same    as    for
          CCCCAAAAEEEESSSSAAAARRRR____AAAALLLLLLLL____DDDDIIIIAAAAGGGGNNNNOOOOSSSSTTTTIIIICCCC____1111.

     -    With  CCCCAAAAEEEESSSSAAAARRRR____DDDDEEEECCCCRRRREEEEAAAASSSSIIIINNNNGGGG____DDDDIIIIAAAAGGGGNNNNOOOOSSSSTTTTIIIICCCC____1111,   same   as   for
          CCCCAAAAEEEESSSSAAAARRRR____AAAALLLLLLLL____DDDDIIIIAAAAGGGGNNNNOOOOSSSSTTTTIIIICCCC____1111.

     -    With CCCCAAAAEEEESSSSAAAARRRR____SSSSHHHHOOOORRRRTTTTEEEESSSSTTTT____DDDDIIIIAAAAGGGGNNNNOOOOSSSSTTTTIIIICCCC____1111, the  shortest  diag-
          nostic  recorded  is  printed,  or the character string
          CCCCAAAAEEEESSSSAAAARRRR____RRRREEEEPPPPOOOORRRRTTTT is printed  if  no  diagnostic  has  been
          recorded into the diagnostic structure.

      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____EEEEMMMMPPPPTTTTYYYY____DDDDIIIIAAAAGGGGNNNNOOOOSSSSTTTTIIIICCCC____1111

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____BBBBOOOOOOOOLLLLEEEEAAAANNNN CCCCAAAAEEEESSSSAAAARRRR____EEEEMMMMPPPPTTTTYYYY____DDDDIIIIAAAAGGGGNNNNOOOOSSSSTTTTIIIICCCC____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____DDDD))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____DDDDIIIIAAAAGGGGNNNNOOOOSSSSTTTTIIIICCCC____1111 CCCCAAAAEEEESSSSAAAARRRR____DDDD;;;;
        {{{{ ............ }}}}

     This function returns the boolean value CCCCAAAAEEEESSSSAAAARRRR____TTTTRRRRUUUUEEEE  iff  at
     least one diagnostic has been previously recorded (using the
     CCCCAAAAEEEESSSSAAAARRRR____RRRREEEECCCCOOOORRRRDDDD____DDDDIIIIAAAAGGGGNNNNOOOOSSSSTTTTIIIICCCC____1111(((()))) function) into  the  diagnostic
     structure pointed to by ****CCCCAAAAEEEESSSSAAAARRRR____DDDD.

      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____BBBBAAAACCCCKKKKTTTTRRRRAAAACCCCKKKK____DDDDIIIIAAAAGGGGNNNNOOOOSSSSTTTTIIIICCCC____1111

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____BBBBOOOOOOOOLLLLEEEEAAAANNNN CCCCAAAAEEEESSSSAAAARRRR____BBBBAAAACCCCKKKKTTTTRRRRAAAACCCCKKKK____DDDDIIIIAAAAGGGGNNNNOOOOSSSSTTTTIIIICCCC____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____DDDD,,,, CCCCAAAAEEEESSSSAAAARRRR____DDDDEEEEPPPPTTTTHHHH))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____DDDDIIIIAAAAGGGGNNNNOOOOSSSSTTTTIIIICCCC____1111 CCCCAAAAEEEESSSSAAAARRRR____DDDD;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL CCCCAAAAEEEESSSSAAAARRRR____DDDDEEEEPPPPTTTTHHHH;;;;
        {{{{ ............ }}}}

     This function returns the boolean value CCCCAAAAEEEESSSSAAAARRRR____TTTTRRRRUUUUEEEE iff  the
     exploration  should  stop  and backtrack when reaching depth
     CCCCAAAAEEEESSSSAAAARRRR____DDDDEEEEPPPPTTTTHHHH. For instance, in  a  depth-first  search,  the
     actual  value of CCCCAAAAEEEESSSSAAAARRRR____DDDDEEEEPPPPTTTTHHHH should be equal to the current



(C) INRIA     Last change: 2020/02/11 (version 1.1)             6






OPEN/CAESAR MANUAL                     caesar_diagnostic_1(LOCAL)



     depth of the stack. The result depends on the  strategy  and
     maximal  depth  associated  with  the  diagnostic  structure
     pointed to by ****CCCCAAAAEEEESSSSAAAARRRR____DDDD:


     -    With   CCCCAAAAEEEESSSSAAAARRRR____NNNNOOOONNNNEEEE____DDDDIIIIAAAAGGGGNNNNOOOOSSSSTTTTIIIICCCC____1111,    the    result    is
          CCCCAAAAEEEESSSSAAAARRRR____TTTTRRRRUUUUEEEE  iff  CCCCAAAAEEEESSSSAAAARRRR____DDDDEEEEPPPPTTTTHHHH is strictly greater than
          the maximal depth (if the maximal depth is not equal to
          zero).

     -    With    CCCCAAAAEEEESSSSAAAARRRR____AAAALLLLLLLL____DDDDIIIIAAAAGGGGNNNNOOOOSSSSTTTTIIIICCCC____1111,    same     as     for
          CCCCAAAAEEEESSSSAAAARRRR____NNNNOOOONNNNEEEE____DDDDIIIIAAAAGGGGNNNNOOOOSSSSTTTTIIIICCCC____1111.

     -    With   CCCCAAAAEEEESSSSAAAARRRR____FFFFIIIIRRRRSSSSTTTT____DDDDIIIIAAAAGGGGNNNNOOOOSSSSTTTTIIIICCCC____1111,   the    result    is
          CCCCAAAAEEEESSSSAAAARRRR____TTTTRRRRUUUUEEEE  iff  CCCCAAAAEEEESSSSAAAARRRR____DDDDEEEEPPPPTTTTHHHH is strictly greater than
          the maximal depth (if the maximal depth is not equal to
          zero)   or  if  some  diagnostic  has  been  previously
          recorded into the diagnostic structure.

     -    With  CCCCAAAAEEEESSSSAAAARRRR____DDDDEEEECCCCRRRREEEEAAAASSSSIIIINNNNGGGG____DDDDIIIIAAAAGGGGNNNNOOOOSSSSTTTTIIIICCCC____1111,  the  result   is
          CCCCAAAAEEEESSSSAAAARRRR____TTTTRRRRUUUUEEEE  iff  CCCCAAAAEEEESSSSAAAARRRR____DDDDEEEEPPPPTTTTHHHH is strictly greater than
          the maximal depth (if the maximal depth is not equal to
          zero)  or if it is greater or equal to the size of some
          previously recorded diagnostic.

     -    With   CCCCAAAAEEEESSSSAAAARRRR____SSSSHHHHOOOORRRRTTTTEEEESSSSTTTT____DDDDIIIIAAAAGGGGNNNNOOOOSSSSTTTTIIIICCCC____1111,   same   as    for
          CCCCAAAAEEEESSSSAAAARRRR____DDDDEEEECCCCRRRREEEEAAAASSSSIIIINNNNGGGG____DDDDIIIIAAAAGGGGNNNNOOOOSSSSTTTTIIIICCCC____1111.

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





(C) INRIA     Last change: 2020/02/11 (version 1.1)             7






OPEN/CAESAR MANUAL                     caesar_diagnostic_1(LOCAL)



     Directives   for   installation   are   given    in    files
     $$$$CCCCAAAADDDDPPPP////IIIINNNNSSSSTTTTAAAALLLLLLLLAAAATTTTIIIIOOOONNNN____****....

     Recent  changes  and  improvements  to  this  software   are
     reported and commented in file $$$$CCCCAAAADDDDPPPP////HHHHIIIISSSSTTTTOOOORRRRYYYY....

BBBBUUUUGGGGSSSS
     Known  bugs  are  described  in  the  Reference  Manual   of
     OPEN/CAESAR.  Please report new bugs to cadp@inria.fr














































(C) INRIA     Last change: 2020/02/11 (version 1.1)             8



