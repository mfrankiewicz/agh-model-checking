


OPEN/CAESAR MANUAL                          caesar_solve_2(LOCAL)



NNNNAAAAMMMMEEEE
     caesar_solve_2 - the ``solve_2'' library of OPEN/CAESAR

PPPPUUUURRRRPPPPOOOOSSSSEEEE
     The ``solve_2''  library  provides  primitives  for  solving
     linear  equation systems, which are provided ``on the fly''.
     This library can be used as a back-end for  various  on  the
     fly  verification  tools  that formulate their corresponding
     problems (e.g.,  probabilistic  verification)  in  terms  of
     linear equation systems.



UUUUSSSSAAAAGGGGEEEE
     The ``solve_2'' library consists of:

     -    a predefined header file ccccaaaaeeeessssaaaarrrr____ssssoooollllvvvveeee____2222....hhhh;

     -    the precompiled library file lllliiiibbbbccccaaaaeeeessssaaaarrrr....aaaa, which  imple-
          ments the features described in ccccaaaaeeeessssaaaarrrr____ssssoooollllvvvveeee____2222....hhhh.

     Note: The ``solve_2'' library  is  a  software  layer  built
     above   the   primitives   offered   by   the  ``standard'',
     ``area_1'',  and   ``table_1''   libraries,   and   by   the
     _O_P_E_N/_C_A_E_S_A_R graph module.



LLLLIIIINNNNEEEEAAAARRRR EEEEQQQQUUUUAAAATTTTIIIIOOOONNNN SSSSYYYYSSSSTTTTEEEEMMMMSSSS
     A ``linear equation system'' is a set  of  (possibly  recur-
     sive)  equations with numerical variables on their left-hand
     sides and linear algebraic expressions on  their  right-hand
     sides.

     The expressions on the right-hand  sides  of  equations  are
     built  from  numerical  variables  (XXXX1111,  XXXX2222,  etc.) and real
     numbers (3333....1111444411116666, ----0000....5555, etc.) using arithmetic operators  (++++,
     ****).

     Equations are of the following form:

         XXXXiiii ==== CCCCiiii1111 **** XXXX1111 ++++ ............ ++++ CCCCiiiinnnn **** XXXXnnnn ++++ BBBBiiii

     where the real numbers CCCCiiiijjjj are the coefficients of variables
     XXXXjjjj and the real numbers BBBBiiii are constants, for i, j between 1
     and n.  If a coefficient CCCCiiiijjjj is equal to 0, the term  CCCCiiiijjjj  ****
     XXXXjjjj is omitted.

     A variable is defined in a  linear  equation  system  if  it
     occurs  as left-hand side in an equation of the system. Mul-
     tiple definitions of a variable are forbidden, i.e., a vari-
     able  can occur as left-hand side in at most one equation of



(C) INRIA     Last change: 2020/02/11 (version 1.1)             1






OPEN/CAESAR MANUAL                          caesar_solve_2(LOCAL)



     a linear equation system. Each  variable  occurring  on  the
     right-hand  side  of an equation in a linear equation system
     must be defined by some equation of the system.

     If the formula on the right-hand side of the equation defin-
     ing  a  variable XXXXiiii contains another variable XXXXjjjj, there is a
     dependency from XXXXiiii to XXXXjjjj.

     An example of a linear equation system containing four equa-
     tions is shown below.

         XXXX1111 ==== 0000....4444 **** XXXX2222 ++++ 0000....6666 **** XXXX3333
         XXXX2222 ==== 0000....5555 **** XXXX1111 ++++ 0000....2222
         XXXX3333 ==== 0000....3333

     This system contains a cyclic dependency  between  variables
     XXXX1111 and XXXX2222.



OOOONNNN TTTTHHHHEEEE FFFFLLLLYYYY RRRREEEESSSSOOOOLLLLUUUUTTTTIIIIOOOONNNN
     Given a linear equation system, the on the  fly  (or  local)
     resolution problem consists in computing the value of a par-
     ticular variable defined in the system. Contrary  to  global
     resolution,  which  consists  in computing the values of all
     variables defined in the system (and therefore must  examine
     all equations of the system), on the fly resolution computes
     the value of a variable without  necessarily  examining  all
     equations of the system. This resolution technique allows to
     construct the linear  equation  system  in  a  demand-driven
     manner, and hence it is useful for building tools for on the
     fly verification, which explore one or more labelled transi-
     tion systems incrementally.

     The on the fly resolution method for linear equation systems
     implemented in the ``solve_2'' library (see [MR18]) proceeds
     as follows. Each system has an associated resolution routine
     responsible  for  computing  the  values  of  the  variables
     defined in the system.

     The resolution routine associated to a linear equation  sys-
     tem  is easier to develop using a representation of the sys-
     tem as a dependency graph (also known as Signal Flow Graph),
     which  provides  a  more  intuitive view of the dependencies
     between variables. Given an equation system, its correspond-
     ing dependency graph is defined as follows:

     -    For each variable XXXXiiii occurring in the system, there  is
          a vertex XXXXiiii in the dependency graph.

     -    For each dependency from a variable XXXXiiii to a variable XXXXjjjj
          such  that  the  term CCCCiiiijjjj **** XXXXjjjj occurs on the right-hand



(C) INRIA     Last change: 2020/02/11 (version 1.1)             2






OPEN/CAESAR MANUAL                          caesar_solve_2(LOCAL)



          side of the equation defining  XXXXiiii,  there  is  an  edge
          ``(XXXXiiii, CCCCiiiijjjj, XXXXjjjj)'' in the dependency graph.

     -    There is a special sink vertex XXXX0000  (i.e.,  without  any
          outgoing transitions), which denotes the constant 1111....0000.

     To construct its dependency graph, the linear equation  sys-
     tem   shown   above  must  be  first  transformed  into  the
     equivalent form below, by replacing each constant  BBBBiiii  by  a
     term BBBBiiii **** XXXX0000 and adding the equation XXXX0000 ==== 1111....0000:

         XXXX0000 ==== 1111....0000
         XXXX1111 ==== 0000....4444 **** XXXX2222 ++++ 0000....6666 **** XXXX3333
         XXXX2222 ==== 0000....5555 **** XXXX1111 ++++ 0000....2222 **** XXXX0000
         XXXX3333 ==== 0000....3333 **** XXXX0000

     Its dependency graph is the following:

         ((((XXXX1111,,,, 0000....4444,,,, XXXX2222))))
         ((((XXXX1111,,,, 0000....6666,,,, XXXX3333))))
         ((((XXXX2222,,,, 0000....5555,,,, XXXX1111))))
         ((((XXXX2222,,,, 0000....2222,,,, XXXX0000))))
         ((((XXXX3333,,,, 0000....3333,,,, XXXX0000))))

     The resolution routine associated to a linear equation  sys-
     tem  will explore forward the corresponding dependency graph
     and will propagate backward the values of variables  already
     stabilized  (i.e.,  the value of which has been determined).
     When solving a variable, only the  part  of  the  dependency
     graph  relevant  for  computing the value of the variable is
     explored. For example, solving the variable XXXX3333 of the system
     above  requires  to  explore only the dependency ``(XXXX3333, 0000....3333,
     XXXX0000)'', yielding the value 0000....3333 for  XXXX3333.   The  resolution  of
     variables  XXXX1111  and  XXXX2222,  which are present on a cycle of the
     dependency graph, is carried out  by  a  traditional  linear
     resolution algorithm (e.g., an iterative algorithm) executed
     on the equations defining XXXX1111 and  XXXX2222,  yielding  the  values
     0.325 and 0.3625, respectively.

     To enable on the  fly  exploration,  the  dependency  graphs
     associated  to  linear equation systems are represented in a
     generic, implicit manner using a scheme similar to  the  one
     defined  by  the  _O_P_E_N/_C_A_E_S_A_R  graph module for representing
     labelled transition  systems.  This  representation  roughly
     consists   of   the  following  ingredients  (see  procedure
     CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTEEEE____SSSSOOOOLLLLVVVVEEEE____2222(((()))) below for additional details):

     -    Variables  (vertices  of  the  dependency  graph)   are
          represented  as pointers to memory areas of fixed size.
          The precise meaning of the variable contents is defined
          by  the application program and is not relevant for the
          resolution algorithms.



(C) INRIA     Last change: 2020/02/11 (version 1.1)             3






OPEN/CAESAR MANUAL                          caesar_solve_2(LOCAL)



     -    A linear equation system is equipped with several func-
          tions computing various information about the variables
          defined in the system: a comparison function, a hashing
          function,  a  printing  function,  and an iterator pro-
          cedure which enumerates the successors of a variable in
          the dependency graph.

     To speed up the resolution process, a linear equation system
     has  associated an internal table which stores the variables
     already explored during the previous calls of the resolution
     routine associated to the system. This avoids recomputations
     of variables by subsequent calls of the resolution  routine,
     leading  (for the sparse linear equation systems encountered
     in verification problems) to an overall  resolution  process
     of  time complexity linear in the size of the system (number
     of variables and operators).



DDDDEEEESSSSCCCCRRRRIIIIPPPPTTTTIIIIOOOONNNN
     The ``solve_2'' library allows to create and  handle  linear
     equation  systems on the fly, providing procedures for reso-
     lution, inspection, and writing information to text files.



FFFFEEEEAAAATTTTUUUURRRREEEESSSS
      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSOOOOLLLLVVVVEEEE____2222

     ttttyyyyppppeeeeddddeeeeffff CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____AAAABBBBSSSSTTTTRRRRAAAACCCCTTTT ((((............)))) CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSOOOOLLLLVVVVEEEE____2222;;;;

     This type denotes a pointer to the  concrete  representation
     of a linear equation system. This representation is supposed
     to be ``opaque''.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____RRRREEEEAAAALLLL

     ttttyyyyppppeeeeddddeeeeffff ddddoooouuuubbbblllleeee CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____RRRREEEEAAAALLLL;;;;

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____RRRREEEEAAAALLLL  is  the  real  number  type  used  in  the
     ``solve_2'' library.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____EEEERRRRRRRROOOORRRR____SSSSOOOOLLLLVVVVEEEE____2222




(C) INRIA     Last change: 2020/02/11 (version 1.1)             4






OPEN/CAESAR MANUAL                          caesar_solve_2(LOCAL)



     ttttyyyyppppeeeeddddeeeeffff eeeennnnuuuummmm {{{{
          CCCCAAAAEEEESSSSAAAARRRR____NNNNOOOONNNNEEEE____SSSSOOOOLLLLVVVVEEEE____2222,,,,
          CCCCAAAAEEEESSSSAAAARRRR____MMMMUUUULLLLTTTTIIIIPPPPLLLLEEEE____RRRREEEESSSSOOOOLLLLUUUUTTTTIIIIOOOONNNN____SSSSOOOOLLLLVVVVEEEE____2222,,,,
          CCCCAAAAEEEESSSSAAAARRRR____MMMMEEEEMMMMOOOORRRRYYYY____SSSSHHHHOOOORRRRTTTTAAAAGGGGEEEE____SSSSOOOOLLLLVVVVEEEE____2222,,,,
          CCCCAAAAEEEESSSSAAAARRRR____SSSSIIIINNNNGGGGUUUULLLLAAAARRRR____SSSSOOOOLLLLVVVVEEEE____2222
     }}}}    CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____EEEERRRRRRRROOOORRRR____SSSSOOOOLLLLVVVVEEEE____2222;;;;

     This enumerated type defines the error codes produced  as  a
     side     effect     by     calls     to     the     function
     CCCCAAAAEEEESSSSAAAARRRR____CCCCOOOOMMMMPPPPUUUUTTTTEEEE____SSSSOOOOLLLLVVVVEEEE____2222(((()))) (see  below),  which  performs  the
     resolution  of  a variable defined in a linear equation sys-
     tem. The error codes have the following meaning:

     -    CCCCAAAAEEEESSSSAAAARRRR____NNNNOOOONNNNEEEE____SSSSOOOOLLLLVVVVEEEE____2222 indicates that the  resolution  was
          performed successfully.

     -    CCCCAAAAEEEESSSSAAAARRRR____MMMMUUUULLLLTTTTIIIIPPPPLLLLEEEE____RRRREEEESSSSOOOOLLLLUUUUTTTTIIIIOOOONNNN____SSSSOOOOLLLLVVVVEEEE____2222    indicates    that
          another  resolution  of  a  variable  of the system was
          already performed,  whereas  at  the  creation  of  the
          linear      equation      system     (see     procedure
          CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTEEEE____SSSSOOOOLLLLVVVVEEEE____2222(((()))) below) a single resolution  was
          specified for the system.

     -    CCCCAAAAEEEESSSSAAAARRRR____MMMMEEEEMMMMOOOORRRRYYYY____SSSSHHHHOOOORRRRTTTTAAAAGGGGEEEE____SSSSOOOOLLLLVVVVEEEE____2222 indicates that a  memory
          allocation failed during the resolution.

     -    CCCCAAAAEEEESSSSAAAARRRR____SSSSIIIINNNNGGGGUUUULLLLAAAARRRR____SSSSOOOOLLLLVVVVEEEE____2222 indicates that the linear equa-
          tion system contains singularities, i.e., either it has
          no solution, or it does not have a unique solution.

     Note:   The   error   code   produced   by   a    call    to
     CCCCAAAAEEEESSSSAAAARRRR____CCCCOOOOMMMMPPPPUUUUTTTTEEEE____SSSSOOOOLLLLVVVVEEEE____2222(((())))  can be obtained by using the func-
     tion CCCCAAAAEEEESSSSAAAARRRR____SSSSTTTTAAAATTTTUUUUSSSS____CCCCOOOOMMMMPPPPUUUUTTTTEEEE____SSSSOOOOLLLLVVVVEEEE____2222(((()))) (see below).


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTEEEE____SSSSOOOOLLLLVVVVEEEE____2222

     vvvvooooiiiidddd CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTEEEE____SSSSOOOOLLLLVVVVEEEE____2222 ((((CCCCAAAAEEEESSSSAAAARRRR____LLLL,,,,
                                 CCCCAAAAEEEESSSSAAAARRRR____UUUUNNNNIIIIQQQQUUUUEEEE____RRRREEEESSSSOOOOLLLLUUUUTTTTIIIIOOOONNNN,,,,
                                 CCCCAAAAEEEESSSSAAAARRRR____SSSSOOOOLLLLVVVVEEEE____MMMMOOOODDDDEEEE,,,,
                                 CCCCAAAAEEEESSSSAAAARRRR____EEEEPPPPSSSSIIIILLLLOOOONNNN,,,,
                                 CCCCAAAAEEEESSSSAAAARRRR____VVVVAAAARRRRIIIIAAAABBBBLLLLEEEE____AAAARRRREEEEAAAA,,,,
                                 CCCCAAAAEEEESSSSAAAARRRR____LLLLIIIIMMMMIIIITTTT____SSSSIIIIZZZZEEEE,,,,
                                 CCCCAAAAEEEESSSSAAAARRRR____HHHHAAAASSSSHHHH____SSSSIIIIZZZZEEEE,,,,
                                 CCCCAAAAEEEESSSSAAAARRRR____PPPPRRRRIIIIMMMMEEEE,,,,
                                 CCCCAAAAEEEESSSSAAAARRRR____VVVVAAAARRRRIIIIAAAABBBBLLLLEEEE____CCCCOOOOMMMMPPPPAAAARRRREEEE,,,,
                                 CCCCAAAAEEEESSSSAAAARRRR____VVVVAAAARRRRIIIIAAAABBBBLLLLEEEE____HHHHAAAASSSSHHHH,,,,
                                 CCCCAAAAEEEESSSSAAAARRRR____VVVVAAAARRRRIIIIAAAABBBBLLLLEEEE____PPPPRRRRIIIINNNNTTTT,,,,
                                 CCCCAAAAEEEESSSSAAAARRRR____VVVVAAAARRRRIIIIAAAABBBBLLLLEEEE____IIIITTTTEEEERRRRAAAATTTTEEEE,,,,
                                 CCCCAAAAEEEESSSSAAAARRRR____IIIINNNNFFFFOOOO))))



(C) INRIA     Last change: 2020/02/11 (version 1.1)             5






OPEN/CAESAR MANUAL                          caesar_solve_2(LOCAL)



        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSOOOOLLLLVVVVEEEE____2222 ****CCCCAAAAEEEESSSSAAAARRRR____LLLL;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____BBBBOOOOOOOOLLLLEEEEAAAANNNN CCCCAAAAEEEESSSSAAAARRRR____UUUUNNNNIIIIQQQQUUUUEEEE____RRRREEEESSSSOOOOLLLLUUUUTTTTIIIIOOOONNNN;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL CCCCAAAAEEEESSSSAAAARRRR____SSSSOOOOLLLLVVVVEEEE____MMMMOOOODDDDEEEE;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____RRRREEEEAAAALLLL CCCCAAAAEEEESSSSAAAARRRR____EEEEPPPPSSSSIIIILLLLOOOONNNN;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____AAAARRRREEEEAAAA____1111 CCCCAAAAEEEESSSSAAAARRRR____VVVVAAAARRRRIIIIAAAABBBBLLLLEEEE____AAAARRRREEEEAAAA;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL CCCCAAAAEEEESSSSAAAARRRR____LLLLIIIIMMMMIIIITTTT____SSSSIIIIZZZZEEEE;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL CCCCAAAAEEEESSSSAAAARRRR____HHHHAAAASSSSHHHH____SSSSIIIIZZZZEEEE;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____BBBBOOOOOOOOLLLLEEEEAAAANNNN CCCCAAAAEEEESSSSAAAARRRR____PPPPRRRRIIIIMMMMEEEE;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____CCCCOOOOMMMMPPPPAAAARRRREEEE____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN CCCCAAAAEEEESSSSAAAARRRR____VVVVAAAARRRRIIIIAAAABBBBLLLLEEEE____CCCCOOOOMMMMPPPPAAAARRRREEEE;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____HHHHAAAASSSSHHHH____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN CCCCAAAAEEEESSSSAAAARRRR____VVVVAAAARRRRIIIIAAAABBBBLLLLEEEE____HHHHAAAASSSSHHHH;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____PPPPRRRRIIIINNNNTTTT____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN CCCCAAAAEEEESSSSAAAARRRR____VVVVAAAARRRRIIIIAAAABBBBLLLLEEEE____PPPPRRRRIIIINNNNTTTT;;;;
        vvvvooooiiiidddd ((((****CCCCAAAAEEEESSSSAAAARRRR____VVVVAAAARRRRIIIIAAAABBBBLLLLEEEE____IIIITTTTEEEERRRRAAAATTTTEEEE)))) ((((CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____PPPPOOOOIIIINNNNTTTTEEEERRRR,,,, CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____PPPPOOOOIIIINNNNTTTTEEEERRRR,,,,
           vvvvooooiiiidddd ((((****)))) ((((CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____RRRREEEEAAAALLLL,,,, CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____PPPPOOOOIIIINNNNTTTTEEEERRRR))))))));;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____PPPPOOOOIIIINNNNTTTTEEEERRRR CCCCAAAAEEEESSSSAAAARRRR____IIIINNNNFFFFOOOO;;;;
        {{{{ ............ }}}}

     This procedure allocates  a  linear  equation  system  using
     CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTEEEE(((()))) and assigns its address to ****CCCCAAAAEEEESSSSAAAARRRR____LLLL. If the
     allocation fails, the NNNNUUUULLLLLLLL value is assigned to ****CCCCAAAAEEEESSSSAAAARRRR____LLLL.

     Note: Because CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSOOOOLLLLVVVVEEEE____2222 is  a  pointer  type,  any
     variable  CCCCAAAAEEEESSSSAAAARRRR____LLLL of type CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSOOOOLLLLVVVVEEEE____2222 must be allo-
     cated before used, for instance using:

               CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTEEEE____SSSSOOOOLLLLVVVVEEEE____2222 ((((&&&&CCCCAAAAEEEESSSSAAAARRRR____LLLL,,,, ............))));;;;


     The    actual    value    of    the     formal     parameter
     CCCCAAAAEEEESSSSAAAARRRR____UUUUNNNNIIIIQQQQUUUUEEEE____RRRREEEESSSSOOOOLLLLUUUUTTTTIIIIOOOONNNN  will  be  stored and associated to
     the linear equation system pointed to by ****CCCCAAAAEEEESSSSAAAARRRR____LLLL. It  will
     be  used  to  assign  a  boolean indicating whether only one
     variable (or  several  variables)  of  the  system  will  be
     solved.

     The actual value of the formal  parameter  CCCCAAAAEEEESSSSAAAARRRR____SSSSOOOOLLLLVVVVEEEE____MMMMOOOODDDDEEEE
     will  be stored and associated to the linear equation system
     pointed to by ****CCCCAAAAEEEESSSSAAAARRRR____LLLL. It will be used to assign the reso-
     lution mode, determining which algorithm will be used by the
     resolution routine associated to the system.

     Currently, the following resolution modes are available:

     -    Mode 0 corresponds to a resolution algorithm based upon
          a depth-first search of the dependency graph associated
          to the system, with  detection  of  strongly  connected
          components (SCCs) and iterative resolution of the vari-
          ables contained in the SCCs [MR18].   This  mode  works
          only  for  stochastic  linear  equation  systems, whose
          equations XXXXiiii = CCCCiiii1111 **** XXXX1111 + ... + CCCCiiiinnnn **** XXXXnnnn + BBBBiiii are  such
          that all coefficients CCCCiiiijjjj and constant BBBBiiii are positive,
          and their sum CCCCiiii1111 + ... + CCCCiiiinnnn +  BBBBiiii  is  less  than  or
          equal to 1.0.



(C) INRIA     Last change: 2020/02/11 (version 1.1)             6






OPEN/CAESAR MANUAL                          caesar_solve_2(LOCAL)



     -    (no other resolution mode available yet)

     If the resolution mode given  by  CCCCAAAAEEEESSSSAAAARRRR____SSSSOOOOLLLLVVVVEEEE____MMMMOOOODDDDEEEE  is  not
     among  the  resolution  modes  above, or the linear equation
     system does not have the form expected  by  that  resolution
     mode, the effect is undefined.

     The actual value of the formal parameter CCCCAAAAEEEESSSSAAAARRRR____EEEEPPPPSSSSIIIILLLLOOOONNNN will
     be  stored  and  associated  to  the  linear equation system
     pointed to by ****CCCCAAAAEEEESSSSAAAARRRR____LLLL. It will be used to assign the  pre-
     cision  of comparisons between real numbers during the reso-
     lution.  If this value is equal to zero, it is  replaced  by
     the default value 1111EEEE----6666.

     The    actual    value    of    the     formal     parameter
     CCCCAAAAEEEESSSSAAAARRRR____VVVVAAAARRRRIIIIAAAABBBBLLLLEEEE____AAAARRRREEEEAAAA  will  be  stored and associated to the
     linear equation system pointed to by ****CCCCAAAAEEEESSSSAAAARRRR____LLLL. It  will  be
     used  to assign the (constant) size and (constant) alignment
     factor of the variables defined in the system.

     The actual value of the formal  parameter  CCCCAAAAEEEESSSSAAAARRRR____LLLLIIIIMMMMIIIITTTT____SSSSIIIIZZZZEEEE
     will  be stored and associated to the linear equation system
     pointed to by ****CCCCAAAAEEEESSSSAAAARRRR____LLLL. It will be used to assign the maxi-
     mal  size (number of items) of the internal table associated
     to the system.  This value must be less or equal to a prede-
     fined  value M (see the ``table_1'' library). If it is equal
     to zero, it is replaced by the default value M.

     The actual value of the  formal  parameter  CCCCAAAAEEEESSSSAAAARRRR____HHHHAAAASSSSHHHH____SSSSIIIIZZZZEEEE
     will  be stored and associated to the linear equation system
     pointed to by ****CCCCAAAAEEEESSSSAAAARRRR____LLLL. It will be used to assign the  size
     (number  of  entries)  of  the  hash-table  accompanying the
     internal table associated to the system.  If this  value  is
     equal  to  zero,  it  is replaced by a default value greater
     than zero (see the ``table_1'' library).

     The actual value of the formal parameter  CCCCAAAAEEEESSSSAAAARRRR____PPPPRRRRIIIIMMMMEEEE  will
     be  stored  and  associated  to  the  linear equation system
     pointed to by ****CCCCAAAAEEEESSSSAAAARRRR____LLLL. It will be used to assign a boolean
     value  allowing  to adjust the size of the hash-table accom-
     panying the internal table associated  to  the  system.   If
     this  value  is  equal  to  CCCCAAAAEEEESSSSAAAARRRR____TTTTRRRRUUUUEEEE  and if the value of
     CCCCAAAAEEEESSSSAAAARRRR____HHHHAAAASSSSHHHH____SSSSIIIIZZZZEEEE is not a prime number, this value  will  be
     replaced  by  the  nearest  smaller prime number (since some
     hash functions require prime modulus). Otherwise, the  value
     of   CCCCAAAAEEEESSSSAAAARRRR____HHHHAAAASSSSHHHH____SSSSIIIIZZZZEEEE   will  be  kept  unchanged  (see  the
     ``table_1'' library).

     The    actual    value    of    the     formal     parameter
     CCCCAAAAEEEESSSSAAAARRRR____VVVVAAAARRRRIIIIAAAABBBBLLLLEEEE____CCCCOOOOMMMMPPPPAAAARRRREEEE will be stored and associated to the
     linear equation system pointed to by ****CCCCAAAAEEEESSSSAAAARRRR____LLLL. It  will  be
     used  as  a comparison function for the variables defined in



(C) INRIA     Last change: 2020/02/11 (version 1.1)             7






OPEN/CAESAR MANUAL                          caesar_solve_2(LOCAL)



     the system.

     Precisely,  the  actual  value  of   CCCCAAAAEEEESSSSAAAARRRR____VVVVAAAARRRRIIIIAAAABBBBLLLLEEEE____CCCCOOOOMMMMPPPPAAAARRRREEEE
     should  be  a pointer to a comparison function ccccaaaaeeeessssaaaarrrr____ffff with
     two parameters ccccaaaaeeeessssaaaarrrr____vvvvaaaarrrriiiiaaaabbbblllleeee____1111 and ccccaaaaeeeessssaaaarrrr____vvvvaaaarrrriiiiaaaabbbblllleeee____2222  that
     returns  CCCCAAAAEEEESSSSAAAARRRR____TTTTRRRRUUUUEEEE  (resp.  CCCCAAAAEEEESSSSAAAARRRR____FFFFAAAALLLLSSSSEEEE) if the variables
     pointed to by ccccaaaaeeeessssaaaarrrr____vvvvaaaarrrriiiiaaaabbbblllleeee____1111  and  ccccaaaaeeeessssaaaarrrr____vvvvaaaarrrriiiiaaaabbbblllleeee____2222  are
     equal  (resp.  different).  A pointer to the linear equation
     system (i.e.,  the  value  assigned  to  ****CCCCAAAAEEEESSSSAAAARRRR____BBBB)  can  be
     obtained   within   ccccaaaaeeeessssaaaarrrr____ffff   by   calling   the   function
     CCCCAAAAEEEESSSSAAAARRRR____CCCCUUUURRRRRRRREEEENNNNTTTT____SSSSYYYYSSSSTTTTEEEEMMMM____SSSSOOOOLLLLVVVVEEEE____1111(((()))) (see below).

     The    actual    value    of    the     formal     parameter
     CCCCAAAAEEEESSSSAAAARRRR____VVVVAAAARRRRIIIIAAAABBBBLLLLEEEE____HHHHAAAASSSSHHHH  will  be  stored and associated to the
     linear equation system pointed to by ****CCCCAAAAEEEESSSSAAAARRRR____LLLL. It  will  be
     used  as  a  hash-function  for the variables defined in the
     system.

     Precisely, the actual value of  CCCCAAAAEEEESSSSAAAARRRR____VVVVAAAARRRRIIIIAAAABBBBLLLLEEEE____HHHHAAAASSSSHHHH  should
     be a pointer to a hash function ccccaaaaeeeessssaaaarrrr____ffff with two parameters
     ccccaaaaeeeessssaaaarrrr____vvvvaaaarrrriiiiaaaabbbblllleeee and ccccaaaaeeeessssaaaarrrr____mmmmoooodddduuuulllluuuussss that returns a hash-value
     computed  on  the  byte  string  ccccaaaaeeeessssaaaarrrr____vvvvaaaarrrriiiiaaaabbbblllleeee  [[[[0000]]]]  up to
     ccccaaaaeeeessssaaaarrrr____vvvvaaaarrrriiiiaaaabbbblllleeee [[[[ccccaaaaeeeessssaaaarrrr____ssssiiiizzzzeeee ---- 1111]]]], where the actual value of
     ccccaaaaeeeessssaaaarrrr____ssssiiiizzzzeeee will always be equal to the size of the variable
     pointed to by ccccaaaaeeeessssaaaarrrr____vvvvaaaarrrriiiiaaaabbbblllleeee. This hash-value  must  belong
     to  the  range 0..ccccaaaaeeeessssaaaarrrr____mmmmoooodddduuuulllluuuussss-1.  A pointer to the linear
     equation system (i.e., the value assigned to ****CCCCAAAAEEEESSSSAAAARRRR____LLLL)  can
     be   obtained   within  ccccaaaaeeeessssaaaarrrr____ffff  by  calling  the  function
     CCCCAAAAEEEESSSSAAAARRRR____CCCCUUUURRRRRRRREEEENNNNTTTT____SSSSYYYYSSSSTTTTEEEEMMMM____SSSSOOOOLLLLVVVVEEEE____2222(((()))) (see below).

     The    actual    value    of    the     formal     parameter
     CCCCAAAAEEEESSSSAAAARRRR____VVVVAAAARRRRIIIIAAAABBBBLLLLEEEE____PPPPRRRRIIIINNNNTTTT  will  be stored and associated to the
     linear equation system pointed to by ****CCCCAAAAEEEESSSSAAAARRRR____LLLL. It  will  be
     used  as  a  printing procedure for the variables defined in
     the system.

     Precisely, the actual value of CCCCAAAAEEEESSSSAAAARRRR____VVVVAAAARRRRIIIIAAAABBBBLLLLEEEE____PPPPRRRRIIIINNNNTTTT  should
     be  a  pointer  to  a  printing  procedure ccccaaaaeeeessssaaaarrrr____pppp with two
     parameters ccccaaaaeeeessssaaaarrrr____ffffiiiilllleeee and ccccaaaaeeeessssaaaarrrr____vvvvaaaarrrriiiiaaaabbbblllleeee  that  prints  to
     file ccccaaaaeeeessssaaaarrrr____ffffiiiilllleeee information about the contents of the vari-
     able pointed to by ccccaaaaeeeessssaaaarrrr____vvvvaaaarrrriiiiaaaabbbblllleeee.  A pointer to the linear
     equation  system (i.e., the value assigned to ****CCCCAAAAEEEESSSSAAAARRRR____LLLL) can
     be  obtained  within  ccccaaaaeeeessssaaaarrrr____pppp  by  calling   the   function
     CCCCAAAAEEEESSSSAAAARRRR____CCCCUUUURRRRRRRREEEENNNNTTTT____SSSSYYYYSSSSTTTTEEEEMMMM____SSSSOOOOLLLLVVVVEEEE____2222(((()))) (see below).

     The    actual    value    of    the     formal     parameter
     CCCCAAAAEEEESSSSAAAARRRR____VVVVAAAARRRRIIIIAAAABBBBLLLLEEEE____IIIITTTTEEEERRRRAAAATTTTEEEE will be stored and associated to the
     linear equation system pointed to by ****CCCCAAAAEEEESSSSAAAARRRR____LLLL. It  will  be
     used  as an iterator procedure enumerating all successors of
     the variables defined in the system.

     Any user-defined procedure ccccaaaaeeeessssaaaarrrr____pppp can be used as an actual



(C) INRIA     Last change: 2020/02/11 (version 1.1)             8






OPEN/CAESAR MANUAL                          caesar_solve_2(LOCAL)



     value for formal parameter CCCCAAAAEEEESSSSAAAARRRR____VVVVAAAARRRRIIIIAAAABBBBLLLLEEEE____IIIITTTTEEEERRRRAAAATTTTEEEE, provided
     that its declaration has the form:

             vvvvooooiiiidddd ccccaaaaeeeessssaaaarrrr____pppp ((((ccccaaaaeeeessssaaaarrrr____vvvvaaaarrrriiiiaaaabbbblllleeee____1111,,,, ccccaaaaeeeessssaaaarrrr____vvvvaaaarrrriiiiaaaabbbblllleeee____2222,,,, ccccaaaaeeeessssaaaarrrr____lllloooooooopppp))))
                CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____PPPPOOOOIIIINNNNTTTTEEEERRRR ccccaaaaeeeessssaaaarrrr____vvvvaaaarrrriiiiaaaabbbblllleeee____1111;;;;
                CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____PPPPOOOOIIIINNNNTTTTEEEERRRR ccccaaaaeeeessssaaaarrrr____vvvvaaaarrrriiiiaaaabbbblllleeee____2222;;;;
                vvvvooooiiiidddd ((((****ccccaaaaeeeessssaaaarrrr____lllloooooooopppp)))) ((((CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____RRRREEEEAAAALLLL,,,, CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____PPPPOOOOIIIINNNNTTTTEEEERRRR))));;;;
                {{{{ ............ }}}}

     This procedure ccccaaaaeeeessssaaaarrrr____pppp enumerates  all  successors  of  the
     variable  pointed to by ccccaaaaeeeessssaaaarrrr____vvvvaaaarrrriiiiaaaabbbblllleeee____1111.  A pointer to the
     linear  equation  system  (i.e.,  the  value   assigned   to
     ****CCCCAAAAEEEESSSSAAAARRRR____LLLL)  can  be  obtained within ccccaaaaeeeessssaaaarrrr____pppp by calling the
     function  CCCCAAAAEEEESSSSAAAARRRR____CCCCUUUURRRRRRRREEEENNNNTTTT____SSSSYYYYSSSSTTTTEEEEMMMM____SSSSOOOOLLLLVVVVEEEE____2222(((())))  (see  below).  At
     each  iteration  performed  by ccccaaaaeeeessssaaaarrrr____pppp, two actions must be
     carried out:

     -    First, the variable  pointed  to  by  ccccaaaaeeeessssaaaarrrr____vvvvaaaarrrriiiiaaaabbbblllleeee____2222
          must    be    assigned   a   new   value,   such   that
          ccccaaaaeeeessssaaaarrrr____vvvvaaaarrrriiiiaaaabbbblllleeee____1111 and ccccaaaaeeeessssaaaarrrr____vvvvaaaarrrriiiiaaaabbbblllleeee____2222 are the  source
          and target vertices of an edge in the dependency graph.

     -    Second, the procedure pointed to by ccccaaaaeeeessssaaaarrrr____lllloooooooopppp must be
          called.  The  actual  value  of  the  formal  parameter
          ccccaaaaeeeessssaaaarrrr____lllloooooooopppp is a procedure ccccaaaaeeeessssaaaarrrr____qqqq  whose  declaration
          has the form:

                  vvvvooooiiiidddd ccccaaaaeeeessssaaaarrrr____qqqq ((((ccccaaaaeeeessssaaaarrrr____ccccooooeeeeffffffffiiiicccciiiieeeennnntttt____2222,,,, ccccaaaaeeeessssaaaarrrr____vvvvaaaarrrriiiiaaaabbbblllleeee____2222))))
                     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____RRRREEEEAAAALLLL ccccaaaaeeeessssaaaarrrr____ccccooooeeeeffffffffiiiicccciiiieeeennnntttt____2222;;;;
                     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____PPPPOOOOIIIINNNNTTTTEEEERRRR ccccaaaaeeeessssaaaarrrr____vvvvaaaarrrriiiiaaaabbbblllleeee____2222;;;;
                     {{{{ ............ }}}}

          Therefore, each call to the  procedure  pointed  to  by
          ccccaaaaeeeessssaaaarrrr____lllloooooooopppp must have the following parameters:

               ((((****ccccaaaaeeeessssaaaarrrr____lllloooooooopppp)))) ((((ccccaaaaeeeessssaaaarrrr____ccccooooeeeeffffffffiiiicccciiiieeeennnntttt____2222,,,, ccccaaaaeeeessssaaaarrrr____vvvvaaaarrrriiiiaaaabbbblllleeee____2222))))

          Parameter ccccaaaaeeeessssaaaarrrr____ccccooooeeeeffffffffiiiicccciiiieeeennnntttt____2222 represents  the  coeffi-
          cient  of  the variable ccccaaaaeeeessssaaaarrrr____vvvvaaaarrrriiiiaaaabbbblllleeee____2222 on the right-
          hand side of the equation  defining  ccccaaaaeeeessssaaaarrrr____vvvvaaaarrrriiiiaaaabbbblllleeee____1111,
          i.e.,    ``(ccccaaaaeeeessssaaaarrrr____vvvvaaaarrrriiiiaaaabbbblllleeee____1111,    ccccaaaaeeeessssaaaarrrr____ccccooooeeeeffffffffiiiicccciiiieeeennnntttt____2222,
          ccccaaaaeeeessssaaaarrrr____vvvvaaaarrrriiiiaaaabbbblllleeee____2222)'' represents an edge of  the  depen-
          dency graph.

     Note:  The  memory  area  pointed  to   by   the   parameter
     ccccaaaaeeeessssaaaarrrr____vvvvaaaarrrriiiiaaaabbbblllleeee____1111  contains a variable and should neither be
     modified, nor freed by the procedure ccccaaaaeeeessssaaaarrrr____pppp.

     Note:  The  memory  area  pointed  to   by   the   parameter
     ccccaaaaeeeessssaaaarrrr____vvvvaaaarrrriiiiaaaabbbblllleeee____2222  is  already  allocated  and should not be
     freed by the procedure ccccaaaaeeeessssaaaarrrr____pppp.




(C) INRIA     Last change: 2020/02/11 (version 1.1)             9






OPEN/CAESAR MANUAL                          caesar_solve_2(LOCAL)



     The value of CCCCAAAAEEEESSSSAAAARRRR____IIIINNNNFFFFOOOO has no effect on the  execution  of
     procedure  CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTEEEE____SSSSOOOOLLLLVVVVEEEE____2222(((()))). Parameter CCCCAAAAEEEESSSSAAAARRRR____IIIINNNNFFFFOOOO is
     intended to serve for future extensions of  this  procedure;
     when  using  the current version of the ``solve_2'' library,
     it is recommended to set this parameter to NNNNUUUULLLLLLLL.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____CCCCUUUURRRRRRRREEEENNNNTTTT____SSSSYYYYSSSSTTTTEEEEMMMM____SSSSOOOOLLLLVVVVEEEE____2222

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSOOOOLLLLVVVVEEEE____2222 CCCCAAAAEEEESSSSAAAARRRR____CCCCUUUURRRRRRRREEEENNNNTTTT____SSSSYYYYSSSSTTTTEEEEMMMM____SSSSOOOOLLLLVVVVEEEE____2222 (((())))
        {{{{ ............ }}}}

     This function returns a pointer to the linear equation  sys-
     tem which is currently under resolution. It should be called
     only within the functions and  procedures  given  as  actual
     values  for  the  formal parameters CCCCAAAAEEEESSSSAAAARRRR____VVVVAAAARRRRIIIIAAAABBBBLLLLEEEE____CCCCOOOOMMMMPPPPAAAARRRREEEE,
     CCCCAAAAEEEESSSSAAAARRRR____VVVVAAAARRRRIIIIAAAABBBBLLLLEEEE____HHHHAAAASSSSHHHH,       CCCCAAAAEEEESSSSAAAARRRR____VVVVAAAARRRRIIIIAAAABBBBLLLLEEEE____PPPPRRRRIIIINNNNTTTT,       and
     CCCCAAAAEEEESSSSAAAARRRR____VVVVAAAARRRRIIIIAAAABBBBLLLLEEEE____IIIITTTTEEEERRRRAAAATTTTEEEE of procedure CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTEEEE____SSSSOOOOLLLLVVVVEEEE____2222(((())))
     (see above); in this case, the result is a  pointer  to  the
     linear    equation   system   created   by   the   call   to
     CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTEEEE____SSSSOOOOLLLLVVVVEEEE____2222(((()))). If this function is called anywhere
     else in the application program, the result is undefined.

     Note: This  function  allows  to  invoke,  within  the  five
     aforementioned  functions and procedures, various primitives
     of the ``solve_2'' library on the  current  linear  equation
     system (e.g., resolution, printing, etc.).


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____DDDDEEEELLLLEEEETTTTEEEE____SSSSOOOOLLLLVVVVEEEE____2222

     vvvvooooiiiidddd CCCCAAAAEEEESSSSAAAARRRR____DDDDEEEELLLLEEEETTTTEEEE____SSSSOOOOLLLLVVVVEEEE____2222 ((((CCCCAAAAEEEESSSSAAAARRRR____LLLL))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSOOOOLLLLVVVVEEEE____2222 ****CCCCAAAAEEEESSSSAAAARRRR____LLLL;;;;
        {{{{ ............ }}}}

     This procedure frees the memory space corresponding  to  the
     linear   equation  system  pointed  to  by  ****CCCCAAAAEEEESSSSAAAARRRR____LLLL  using
     CCCCAAAAEEEESSSSAAAARRRR____DDDDEEEELLLLEEEETTTTEEEE(((()))). The variables stored in the internal  table
     allocated during previous resolutions (if any) of the linear
     equation system are also freed. Afterwards, the  NNNNUUUULLLLLLLL  value
     is assigned to ****CCCCAAAAEEEESSSSAAAARRRR____LLLL.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____PPPPUUUURRRRGGGGEEEE____SSSSOOOOLLLLVVVVEEEE____2222

     vvvvooooiiiidddd CCCCAAAAEEEESSSSAAAARRRR____PPPPUUUURRRRGGGGEEEE____SSSSOOOOLLLLVVVVEEEE____2222 ((((CCCCAAAAEEEESSSSAAAARRRR____LLLL))))



(C) INRIA     Last change: 2020/02/11 (version 1.1)            10






OPEN/CAESAR MANUAL                          caesar_solve_2(LOCAL)



        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSOOOOLLLLVVVVEEEE____2222 CCCCAAAAEEEESSSSAAAARRRR____LLLL;;;;
        {{{{ ............ }}}}

     This procedure reinitializes the information  associated  to
     the  linear  equation  system  pointed  to by CCCCAAAAEEEESSSSAAAARRRR____LLLL.  The
     internal table associated to the  system  is  emptied  using
     CCCCAAAAEEEESSSSAAAARRRR____PPPPUUUURRRRGGGGEEEE____TTTTAAAABBBBLLLLEEEE____1111(((()))).   Afterwards,  the  linear  equation
     system is exactly in the same state as  after  its  creation
     using CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTEEEE____SSSSOOOOLLLLVVVVEEEE____2222(((()))).


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____CCCCOOOOMMMMPPPPUUUUTTTTEEEE____SSSSOOOOLLLLVVVVEEEE____2222

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____RRRREEEEAAAALLLL CCCCAAAAEEEESSSSAAAARRRR____CCCCOOOOMMMMPPPPUUUUTTTTEEEE____SSSSOOOOLLLLVVVVEEEE____2222 ((((CCCCAAAAEEEESSSSAAAARRRR____LLLL,,,, CCCCAAAAEEEESSSSAAAARRRR____VVVV))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSOOOOLLLLVVVVEEEE____2222 CCCCAAAAEEEESSSSAAAARRRR____LLLL;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____PPPPOOOOIIIINNNNTTTTEEEERRRR CCCCAAAAEEEESSSSAAAARRRR____VVVV;;;;
        {{{{ ............ }}}}

     This function computes the value of the variable pointed  to
     by  CCCCAAAAEEEESSSSAAAARRRR____VVVV,  which  must be defined in the linear equation
     system pointed to by CCCCAAAAEEEESSSSAAAARRRR____LLLL. It also sets a field of  type
     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____EEEERRRRRRRROOOORRRR____SSSSOOOOLLLLVVVVEEEE____2222 associated to the system, indicat-
     ing whether the resolution was carried out  successfully  or
     not;   this  field  can  be  inspected  using  the  function
     CCCCAAAAEEEESSSSAAAARRRR____SSSSTTTTAAAATTTTUUUUSSSS____CCCCOOOOMMMMPPPPUUUUTTTTEEEE____SSSSOOOOLLLLVVVVEEEE____2222(((()))) (see below).


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____SSSSTTTTAAAATTTTUUUUSSSS____CCCCOOOOMMMMPPPPUUUUTTTTEEEE____SSSSOOOOLLLLVVVVEEEE____2222

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____EEEERRRRRRRROOOORRRR____SSSSOOOOLLLLVVVVEEEE____2222 CCCCAAAAEEEESSSSAAAARRRR____SSSSTTTTAAAATTTTUUUUSSSS____CCCCOOOOMMMMPPPPUUUUTTTTEEEE____SSSSOOOOLLLLVVVVEEEE____2222 ((((CCCCAAAAEEEESSSSAAAARRRR____LLLL))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSOOOOLLLLVVVVEEEE____2222 CCCCAAAAEEEESSSSAAAARRRR____LLLL;;;;
        {{{{ ............ }}}}

     This function returns the status of the last resolution per-
     formed  by  a  call to the function CCCCAAAAEEEESSSSAAAARRRR____CCCCOOOOMMMMPPPPUUUUTTTTEEEE____SSSSOOOOLLLLVVVVEEEE____2222(((())))
     (see above) on a variable defined  in  the  linear  equation
     system pointed to by CCCCAAAAEEEESSSSAAAARRRR____LLLL.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____FFFFOOOORRRRMMMMAAAATTTT____SSSSOOOOLLLLVVVVEEEE____2222

     CCCCAAAAEEEESSSSAAAARRRR____FFFFOOOORRRRMMMMAAAATTTT CCCCAAAAEEEESSSSAAAARRRR____FFFFOOOORRRRMMMMAAAATTTT____SSSSOOOOLLLLVVVVEEEE____2222 ((((CCCCAAAAEEEESSSSAAAARRRR____LLLL,,,, CCCCAAAAEEEESSSSAAAARRRR____FFFFOOOORRRRMMMMAAAATTTT))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSOOOOLLLLVVVVEEEE____2222 CCCCAAAAEEEESSSSAAAARRRR____LLLL;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____FFFFOOOORRRRMMMMAAAATTTT CCCCAAAAEEEESSSSAAAARRRR____FFFFOOOORRRRMMMMAAAATTTT;;;;
        {{{{ ............ }}}}




(C) INRIA     Last change: 2020/02/11 (version 1.1)            11






OPEN/CAESAR MANUAL                          caesar_solve_2(LOCAL)



     This function allows to control the format under  which  the
     linear  equation  system  pointed  to  by  CCCCAAAAEEEESSSSAAAARRRR____LLLL  will be
     printed by the procedure CCCCAAAAEEEESSSSAAAARRRR____PPPPRRRRIIIINNNNTTTT____SSSSOOOOLLLLVVVVEEEE____2222(((()))) (see below).
     Currently, the following formats are available:


     -    With format 0, statistical information  concerning  the
          linear  equation system is displayed, such as: the size
          of variables and resolution mode, the number  of  vari-
          ables explored during resolution, etc.

     -    With format 1, statistical information  concerning  the
          internal  table  associated  to  the  system is printed
          using the procedure CCCCAAAAEEEESSSSAAAARRRR____PPPPRRRRIIIINNNNTTTT____TTTTAAAABBBBLLLLEEEE____1111(((()))).

     -    With format 2, the contents of the internal table asso-
          ciated  to  the  system  is printed using the procedure
          CCCCAAAAEEEESSSSAAAARRRR____PPPPRRRRIIIINNNNTTTT____TTTTAAAABBBBLLLLEEEE____1111(((()))).

     -    (no other format available yet)

     By default, the current format of each linear equation  sys-
     tem is initialized to 0.

     When called with CCCCAAAAEEEESSSSAAAARRRR____FFFFOOOORRRRMMMMAAAATTTT between 0 and 2,  this  func-
     tion  sets  the  current format of CCCCAAAAEEEESSSSAAAARRRR____LLLL to CCCCAAAAEEEESSSSAAAARRRR____FFFFOOOORRRRMMMMAAAATTTT
     and returns an undefined result.

     When called with another value of CCCCAAAAEEEESSSSAAAARRRR____FFFFOOOORRRRMMMMAAAATTTT, this  func-
     tion  does  not  modify  the  current format of CCCCAAAAEEEESSSSAAAARRRR____LLLL but
     returns a result defined as  follows.  If  CCCCAAAAEEEESSSSAAAARRRR____FFFFOOOORRRRMMMMAAAATTTT  is
     equal  to  the constant CCCCAAAAEEEESSSSAAAARRRR____CCCCUUUURRRRRRRREEEENNNNTTTT____FFFFOOOORRRRMMMMAAAATTTT, the result is
     the  value  of  the   current   format   of   CCCCAAAAEEEESSSSAAAARRRR____LLLL.   If
     CCCCAAAAEEEESSSSAAAARRRR____FFFFOOOORRRRMMMMAAAATTTT      is      equal     to     the     constant
     CCCCAAAAEEEESSSSAAAARRRR____MMMMAAAAXXXXIIIIMMMMAAAALLLL____FFFFOOOORRRRMMMMAAAATTTT, the  result  is  the  maximal  format
     value  (i.e.,  2).  In  all  other cases, the effect of this
     function is undefined.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____PPPPRRRRIIIINNNNTTTT____SSSSOOOOLLLLVVVVEEEE____2222

     vvvvooooiiiidddd CCCCAAAAEEEESSSSAAAARRRR____PPPPRRRRIIIINNNNTTTT____SSSSOOOOLLLLVVVVEEEE____2222 ((((CCCCAAAAEEEESSSSAAAARRRR____FFFFIIIILLLLEEEE,,,, CCCCAAAAEEEESSSSAAAARRRR____LLLL))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____FFFFIIIILLLLEEEE CCCCAAAAEEEESSSSAAAARRRR____FFFFIIIILLLLEEEE;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSOOOOLLLLVVVVEEEE____2222 CCCCAAAAEEEESSSSAAAARRRR____LLLL;;;;
        {{{{ ............ }}}}

     This procedure prints on file CCCCAAAAEEEESSSSAAAARRRR____FFFFIIIILLLLEEEE an ASCII text con-
     taining  various informations about the linear equation sys-
     tem pointed to by CCCCAAAAEEEESSSSAAAARRRR____LLLL. The nature of these informations
     is  determined  by the current format of the linear equation



(C) INRIA     Last change: 2020/02/11 (version 1.1)            12






OPEN/CAESAR MANUAL                          caesar_solve_2(LOCAL)



     system pointed to by CCCCAAAAEEEESSSSAAAARRRR____LLLL.

     Before this procedure is called, CCCCAAAAEEEESSSSAAAARRRR____FFFFIIIILLLLEEEE must have  been
     properly opened, for instance using ffffooooppppeeeennnn((((3333)))).


BBBBIIIIBBBBLLLLIIIIOOOOGGGGRRRRAAAAPPPPHHHHYYYY
     [MR18] Radu Mateescu and Jose Ignacio  Requeno.   On-the-Fly
     Model   Checking  for  Extended  Action-Based  Probabilistic
     Operators.  Springer International Journal on Software Tools
     for  Technology  Transfer  (STTT),  20(5):563--587,  October
     2018. Available from hhhhttttttttpppp::::////////hhhhaaaallll....iiiinnnnrrrriiiiaaaa....ffffrrrr////hhhhaaaallll----00001111888866662222777755554444////eeeennnn


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









(C) INRIA     Last change: 2020/02/11 (version 1.1)            13



