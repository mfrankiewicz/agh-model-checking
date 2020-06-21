


OPEN/CAESAR MANUAL                          caesar_solve_1(LOCAL)



NNNNAAAAMMMMEEEE
     caesar_solve_1 - the ``solve_1'' library of OPEN/CAESAR

PPPPUUUURRRRPPPPOOOOSSSSEEEE
     The ``solve_1''  library  provides  primitives  for  solving
     alternation-free  boolean equation systems, which are either
     provided ``on the fly'' or given as a text file  encoded  in
     the  BBBBEEEESSSS  format. This library can be used as a back-end for
     various on the fly verification tools that  formulate  their
     corresponding  problems  (e.g.,  equivalence checking, model
     checking,  tau-confluence  reduction,  etc.)  in  terms   of
     boolean equation systems.



UUUUSSSSAAAAGGGGEEEE
     The ``solve_1'' library consists of:

     -    a predefined header file ccccaaaaeeeessssaaaarrrr____ssssoooollllvvvveeee____1111....hhhh;

     -    the precompiled library file lllliiiibbbbccccaaaaeeeessssaaaarrrr....aaaa, which  imple-
          ments the features described in ccccaaaaeeeessssaaaarrrr____ssssoooollllvvvveeee____1111....hhhh.

     Note: The ``solve_1'' library  is  a  software  layer  built
     above   the   primitives   offered   by   the  ``standard'',
     ``area_1'', ``table_1'', and ``hash'' libraries, and by  the
     _O_P_E_N/_C_A_E_S_A_R graph module.



BBBBOOOOOOOOLLLLEEEEAAAANNNN EEEEQQQQUUUUAAAATTTTIIIIOOOONNNN SSSSYYYYSSSSTTTTEEEEMMMMSSSS
     See the bbbbeeeessss manual page of CADP for:


     -    a definition of boolean equation systems and their ter-
          minology:  equation blocks, boolean variables, conjunc-
          tive and disjunctive formulas, conjunctive and disjunc-
          tive  variables, dependencies between variables, depen-
          dencies between blocks, alternation-free systems, block
          indexes, variable indexes, sign of a block, etc.

     -    a specification of the BBBBEEEESSSS format that is used to store
          boolean  equation  systems  in  text  files  having the
          extension ``.bes''.

OOOONNNN TTTTHHHHEEEE FFFFLLLLYYYY RRRREEEESSSSOOOOLLLLUUUUTTTTIIIIOOOONNNN
     Given a boolean equation system, the on the fly  (or  local)
     resolution problem consists in computing the value of a par-
     ticular variable defined in some block of the  system.  Con-
     trary  to global resolution, which consists in computing the
     values of all variables defined in the system (and therefore
     must  examine  all  equations  of  the  system),  on the fly



(C) INRIA     Last change: 2020/02/11 (version 1.3)             1






OPEN/CAESAR MANUAL                          caesar_solve_1(LOCAL)



     resolution computes the value of a variable  without  neces-
     sarily  examining  all equations of the system. This resolu-
     tion technique allows to construct the boolean equation sys-
     tem  in  a  demand-driven manner, and hence it is useful for
     building tools for on the fly  verification,  which  explore
     one or more labelled transition systems incrementally.

     The  on  the  fly  resolution  method  for  alternation-free
     boolean  equation  systems  implemented  in  the ``solve_1''
     library proceeds as follows. To each equation block  of  the
     system  is  associated  a resolution routine responsible for
     computing the values of the variables defined in the  block.
     When  the routine associated to a block is called to compute
     the value of a variable defined in that  block,  it  may  in
     turn call the routines associated to other blocks to compute
     the values of  other  variables  defined  in  those  blocks.
     Assuming  that  all  resolution  routines  associated to the
     blocks will eventually  terminate,  the  overall  resolution
     process  will  also  terminate, because the size of the call
     stack of resolution routines is bounded by the number  N  of
     blocks  in  the boolean equation system (since the system is
     alternation-free, there are no cyclic  dependencies  between
     blocks).



BBBBOOOOOOOOLLLLEEEEAAAANNNN GGGGRRRRAAAAPPPPHHHHSSSS
     The resolution routines associated to  the  equation  blocks
     are  easier  to  develop using a representation of blocks as
     boolean graphs, which provide a more intuitive view  of  the
     dependencies  between  boolean  variables. Given an equation
     block, its corresponding boolean graph is  defined  as  fol-
     lows:

     -    For each boolean variable occurring in the block, there
          is a vertex in the boolean graph.

     -    For each dependency from a boolean  variable  XXXXiiii  to  a
          boolean  variable  XXXXjjjj, there is an edge ``(XXXXiiii, XXXXjjjj)'' in
          the boolean graph.

     -    Each vertex of the boolean graph is labeled as disjunc-
          tive  or  conjunctive  according  to  the  kind  of the
          boolean variable it denotes.

     Boolean variables whose defining equations  have  right-hand
     side   formulas   identical   to   ffffaaaallllsssseeee  (resp.  ttttrrrruuuueeee)  are
     represented in the boolean graph as disjunctive (resp.  con-
     junctive)  vertices without successors. Dependencies between
     different equation blocks are represented as  edges  between
     the boolean graphs associated to the blocks.




(C) INRIA     Last change: 2020/02/11 (version 1.3)             2






OPEN/CAESAR MANUAL                          caesar_solve_1(LOCAL)



     The boolean graph associated to the boolean equation  system
     above  is  shown  below (edges are represented as couples of
     boolean variables, the kind of which  is  indicated  between
     brackets).

         ((((**** ggggrrrraaaapppphhhh ffffoooorrrr BBBB0000 ****))))
            ((((XXXX0000____0000 [[[[aaaannnndddd]]]],,,, XXXX1111____0000 [[[[oooorrrr]]]]))))
            ((((XXXX0000____0000 [[[[aaaannnndddd]]]],,,, XXXX2222____0000 [[[[aaaannnndddd]]]]))))
            ((((XXXX1111____0000 [[[[oooorrrr]]]],,,,  XXXX0000____0000 [[[[aaaannnndddd]]]]))))
            ((((XXXX1111____0000 [[[[oooorrrr]]]],,,,  XXXX1111____0000 [[[[oooorrrr]]]]))))
            ((((XXXX1111____0000 [[[[oooorrrr]]]],,,,  XXXX2222____0000 [[[[aaaannnndddd]]]]))))
            ((((XXXX2222____0000 [[[[aaaannnndddd]]]],,,, XXXX0000____1111 [[[[oooorrrr]]]]))))
            ((((XXXX2222____0000 [[[[aaaannnndddd]]]],,,, XXXX3333____0000 [[[[oooorrrr]]]]))))
            ((((XXXX3333____0000 [[[[oooorrrr]]]],,,,  XXXX1111____0000 [[[[oooorrrr]]]]))))
            ((((XXXX3333____0000 [[[[oooorrrr]]]],,,,  XXXX4444____0000 [[[[aaaannnndddd]]]]))))

         ((((**** ggggrrrraaaapppphhhh ffffoooorrrr BBBB1111 ****))))
            ((((XXXX0000____1111 [[[[oooorrrr]]]],,,,  XXXX1111____1111 [[[[oooorrrr]]]]))))
            ((((XXXX0000____1111 [[[[oooorrrr]]]],,,,  XXXX2222____1111 [[[[aaaannnndddd]]]]))))
            ((((XXXX2222____1111 [[[[aaaannnndddd]]]],,,, XXXX2222____1111 [[[[aaaannnndddd]]]]))))
            ((((XXXX2222____1111 [[[[aaaannnndddd]]]],,,, XXXX3333____1111 [[[[oooorrrr]]]]))))
            ((((XXXX3333____1111 [[[[oooorrrr]]]],,,,  XXXX0000____1111 [[[[oooorrrr]]]]))))
            ((((XXXX3333____1111 [[[[oooorrrr]]]],,,,  XXXX1111____1111 [[[[oooorrrr]]]]))))
            ((((XXXX3333____1111 [[[[oooorrrr]]]],,,,  XXXX3333____1111 [[[[oooorrrr]]]]))))

     For each equation block, its corresponding  resolution  rou-
     tine  will  explore  forward the boolean graph associated to
     the block and will propagate backward the values of  boolean
     variables  already  stabilized (i.e., the value of which has
     been determined). When solving a boolean variable, only  the
     part of the boolean graph relevant for deciding the value of
     the variable is explored. For  instance,  the  part  of  the
     boolean  graph  explored  for  solving  variable XXXX0000____0000 of the
     boolean equation system above is shown  below  (all  boolean
     variables  contained  in  this part of the boolean graph are
     false).

         ((((**** rrrreeeessssoooolllluuuuttttiiiioooonnnn ggggrrrraaaapppphhhh ffffoooorrrr BBBB0000 ****))))
            ((((XXXX0000____0000 [[[[aaaannnndddd]]]],,,, XXXX1111____0000 [[[[oooorrrr]]]]))))
            ((((XXXX0000____0000 [[[[aaaannnndddd]]]],,,, XXXX2222____0000 [[[[aaaannnndddd]]]]))))
            ((((XXXX1111____0000 [[[[oooorrrr]]]],,,,  XXXX0000____0000 [[[[aaaannnndddd]]]]))))
            ((((XXXX1111____0000 [[[[oooorrrr]]]],,,,  XXXX1111____0000 [[[[oooorrrr]]]]))))
            ((((XXXX1111____0000 [[[[oooorrrr]]]],,,,  XXXX2222____0000 [[[[aaaannnndddd]]]]))))
            ((((XXXX2222____0000 [[[[aaaannnndddd]]]],,,, XXXX0000____1111 [[[[oooorrrr]]]]))))

         ((((**** rrrreeeessssoooolllluuuuttttiiiioooonnnn ggggrrrraaaapppphhhh ffffoooorrrr BBBB1111 ****))))
            ((((XXXX0000____1111 [[[[oooorrrr]]]],,,,  XXXX1111____1111 [[[[oooorrrr]]]]))))
            ((((XXXX0000____1111 [[[[oooorrrr]]]],,,,  XXXX2222____1111 [[[[aaaannnndddd]]]]))))
            ((((XXXX2222____1111 [[[[aaaannnndddd]]]],,,, XXXX2222____1111 [[[[aaaannnndddd]]]]))))

     The resolution was carried out as follows.  After  exploring
     variables XXXX0000____0000 and XXXX1111____0000, the current unexplored successor of



(C) INRIA     Last change: 2020/02/11 (version 1.3)             3






OPEN/CAESAR MANUAL                          caesar_solve_1(LOCAL)



     XXXX0000____0000 is XXXX2222____0000. The exploration of XXXX2222____0000 is started by visiting
     variable  XXXX0000____1111,  which is defined in block BBBB1111. This variable
     depends on XXXX1111____1111, whose value is  false  (disjunctive  vertex
     without  successors)  and  XXXX2222____1111,  whose  value is also false
     (conjunctive vertex with a  self-loop  in  a  minimal  fixed
     point block). Thus, variable XXXX0000____1111 is false, and by propagat-
     ing its value backward, variables XXXX2222____0000 and XXXX0000____0000 become false
     (conjunctive vertices with a successor equal to false).



RRRREEEESSSSOOOOLLLLUUUUTTTTIIIIOOOONNNN MMMMOOOODDDDEEEESSSS
     The ``solve_1'' library implements various algorithms (named
     ``resolution  modes'')  to solve boolean equation systems by
     exploring their associated boolean  graphs.  For  efficiency
     reasons,  each  equation  block of the same boolean equation
     system may be solved using the most  appropriate  algorithm.
     Currently, the following resolution modes are available:


     -    Mode 0 corresponds to a resolution algorithm based upon
          a depth-first search of the boolean graph associated to
          the equation block. This algorithm can  be  applied  to
          any kind of equation block.

     -    Mode 1 corresponds to a resolution algorithm based upon
          a  breadth-first search of the boolean graph associated
          to the equation block. This algorithm can be applied to
          any  kind  of  equation block. In practice, it performs
          slightly slower than mode 0, but  produces  diagnostics
          of smaller depth.

     -    Mode 2 corresponds to a resolution algorithm based upon
          a depth-first search of the boolean graph associated to
          the equation block. This algorithm can be applied  only
          to acyclic equation blocks, i.e., without cyclic depen-
          dencies between variables.  In  practice,  it  consumes
          less memory than modes 0 and 1.

     -    Mode 3 corresponds to a resolution algorithm based upon
          a depth-first search of the boolean graph associated to
          the equation block. This algorithm can be applied  only
          to  disjunctive equation blocks, i.e., whose right-hand
          sides of equations are either (a) disjunctive formulas,
          or  (b)  conjunctive  formulas  whose operands are con-
          stants or variables defined in other blocks,  with  the
          possible  exception of the last operand, which may be a
          variable defined in the current block (e.g.,  ttttrrrruuuueeee  aaaannnndddd
          XXXX1111____jjjj aaaannnndddd ffffaaaallllsssseeee aaaannnndddd XXXX2222, where XXXX1111____jjjj is defined in another
          block of index jjjj and  XXXX2222  is  defined  in  the  current
          block). In practice, it consumes less memory than modes
          0 and 1.



(C) INRIA     Last change: 2020/02/11 (version 1.3)             4






OPEN/CAESAR MANUAL                          caesar_solve_1(LOCAL)



     -    Mode 4 corresponds to a resolution algorithm based upon
          a depth-first search of the boolean graph associated to
          the equation block. This algorithm can be applied  only
          to  conjunctive equation blocks, i.e., whose right-hand
          sides of equations are either (a) conjunctive formulas,
          or  (b)  disjunctive  formulas  whose operands are con-
          stants or variables defined in other blocks,  with  the
          possible  exception of the last operand, which may be a
          variable defined in the current block (e.g.,  ffffaaaallllsssseeee  oooorrrr
          XXXX1111____jjjj  oooorrrr  ttttrrrruuuueeee  oooorrrr XXXX2222, where XXXX1111____jjjj is defined in another
          block of index jjjj and  XXXX2222  is  defined  in  the  current
          block). In practice, it consumes less memory than modes
          0 and 1.

     -    Mode 5 corresponds to a resolution algorithm based upon
          a depth-first search of the boolean graph associated to
          the equation block. This algorithm can  be  applied  to
          any  kind of equation block. In practice, it exhibits a
          better performance than mode 0 when applied to equation
          blocks containing alternating dependencies between dis-
          junctive and conjunctive variables (e.g., the  equation
          blocks encoding equivalence checking problems).

     -    Mode 6 corresponds to a resolution algorithm based upon
          a  breadth-first search of the boolean graph associated
          to the equation block. This algorithm  can  be  applied
          only to disjunctive minimal fixed point equation blocks
          for which a single resolution was specified.  In  prac-
          tice,  it consumes less memory than mode 1 and produces
          diagnostics of smaller depth than mode 3.

     -    Mode 7 corresponds to a resolution algorithm based upon
          a  breadth-first search of the boolean graph associated
          to the equation block. This algorithm  can  be  applied
          only to conjunctive maximal fixed point equation blocks
          for which a single resolution was specified.  In  prac-
          tice,  it consumes less memory than mode 1 and produces
          diagnostics of smaller depth than mode 4.

     -    Mode 8 corresponds to a resolution algorithm based upon
          a depth-first search of the boolean graph associated to
          the equation block. This algorithm can  be  applied  to
          any  kind  of  equation block. In practice, it consumes
          less memory than modes 0 and 5, being especially useful
          for  solving  minimal (resp. maximal) fixed point equa-
          tion blocks containing many conjunctive (resp. disjunc-
          tive) variables.

     -    Mode 9 corresponds to a resolution algorithm based upon
          a  breadth-first search of the boolean graph associated
          to the equation block. This algorithm  can  be  applied
          only  to  acyclic equation blocks, i.e., without cyclic



(C) INRIA     Last change: 2020/02/11 (version 1.3)             5






OPEN/CAESAR MANUAL                          caesar_solve_1(LOCAL)



          dependencies between variables. When applied to an acy-
          clic block consisting of singular equations (i.e., hav-
          ing only  one  boolean  variable  in  their  right-hand
          sides),  whose  boolean graph is a sequence, this algo-
          rithm consumes a bounded amount of memory,  independent
          of  the number of equations in the block (length of the
          sequence).

     -    (no other resolution mode available yet)

IIIINNNNTTTTEEEERRRRNNNNAAAALLLL RRRREEEEPPPPRRRREEEESSSSEEEENNNNTTTTAAAATTTTIIIIOOOONNNN
     To enable on the fly exploration, the boolean graphs associ-
     ated to the equation blocks of a boolean equation system are
     represented in a generic, implicit  manner  using  a  scheme
     similar  to  the one defined by the _O_P_E_N/_C_A_E_S_A_R graph module
     for representing labelled transition systems. This represen-
     tation  roughly  consists  of the following ingredients (see
     procedure  CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTEEEE____SSSSOOOOLLLLVVVVEEEE____1111(((())))  below   for   additional
     details):

     -    Boolean variables (vertices of the boolean  graph)  are
          represented  as  pointers to memory areas of fixed size
          (for each equation block, all variables defined in that
          block  must have the same size). The precise meaning of
          the variable contents is  defined  by  the  application
          program  and  is  not relevant for the resolution algo-
          rithms.

     -    Each equation block is equipped with several  functions
          computing   various  information  about  the  variables
          defined in the block: a function returning the kind  of
          a  variable  (disjunctive or conjunctive), a comparison
          function, a hashing function, a printing function,  and
          an  iterator  procedure which enumerates the successors
          of a variable in the boolean graph.

     -    Application programs may also associate, to  each  edge
          of  the  boolean  graph, a specific information (label)
          represented as a pointer to a memory area. The contents
          of  these memory areas are not meaningful for the reso-
          lution algorithms, which  manipulate  the  pointers  to
          these areas only by copying them and (possibly) by com-
          paring them to NNNNUUUULLLLLLLL.

     To speed up the overall resolution  process,  each  equation
     block  of  the  boolean  equation  system  has associated an
     internal table which stores the  boolean  variables  already
     explored during the previous calls of the resolution routine
     associated to  the  block.  This  avoids  recomputations  of
     boolean variables by subsequent calls of the same resolution
     routine, leading to an overall resolution  process  of  time
     complexity linear in the size of the boolean equation system



(C) INRIA     Last change: 2020/02/11 (version 1.3)             6






OPEN/CAESAR MANUAL                          caesar_solve_1(LOCAL)



     (number of variables and operators).



DDDDIIIIAAAAGGGGNNNNOOOOSSSSTTTTIIIICCCC GGGGEEEENNNNEEEERRRRAAAATTTTIIIIOOOONNNN
     A diagnostic for a boolean variable is  a  boolean  subgraph
     rooted  at  the  vertex corresponding to the variable, which
     illustrates the truth value computed for  the  variable.  If
     the  boolean  variable is ttttrrrruuuueeee (resp. ffffaaaallllsssseeee), then the diag-
     nostic is called example (resp. counterexample). Disjunctive
     (resp.  conjunctive)  vertices  belonging to an example have
     only one successor (resp. all their successors) contained in
     the   example.   Disjunctive  (resp.  conjunctive)  vertices
     belonging to a  counterexample  have  all  their  successors
     (resp. only one successor) contained in the counterexample.

     The diagnostic of a boolean variable defined in an  equation
     block  is  always contained in the part of the boolean graph
     explored by the resolution routine associated to that  block
     when  it  solved the variable. A counterexample for variable
     XXXX0000____0000 of the boolean equation system above is shown below.

         ((((**** ddddiiiiaaaaggggnnnnoooossssttttiiiicccc ggggrrrraaaapppphhhh ffffoooorrrr XXXX0000____0000 iiiinnnn BBBB0000 ****))))
            ((((XXXX0000____0000 [[[[aaaannnndddd]]]],,,, XXXX2222____0000 [[[[aaaannnndddd]]]]))))
            ((((XXXX2222____0000 [[[[aaaannnndddd]]]],,,, XXXX0000____1111 [[[[oooorrrr]]]]))))

         ((((**** ddddiiiiaaaaggggnnnnoooossssttttiiiicccc ggggrrrraaaapppphhhh ffffoooorrrr XXXX0000____1111 iiiinnnn BBBB1111 ****))))
            ((((XXXX0000____1111 [[[[oooorrrr]]]],,,,  XXXX1111____1111 [[[[oooorrrr]]]]))))
            ((((XXXX0000____1111 [[[[oooorrrr]]]],,,,  XXXX2222____1111 [[[[aaaannnndddd]]]]))))
            ((((XXXX2222____1111 [[[[aaaannnndddd]]]],,,, XXXX2222____1111 [[[[aaaannnndddd]]]]))))

     To speed up the generation of diagnostics,  resolution  rou-
     tines  also  compute diagnostic-related information which is
     kept in the internal tables associated to the blocks.  Diag-
     nostics  are represented in a generic, implicit manner using
     a scheme similar to the one defined by the _O_P_E_N/_C_A_E_S_A_R graph
     module  for  representing  labelled transition systems. This
     representation is based  upon  an  iterator  procedure  that
     enumerates  the  successors  of  a variable contained in its
     diagnostic                  (see                   procedure
     CCCCAAAAEEEESSSSAAAARRRR____IIIITTTTEEEERRRRAAAATTTTEEEE____DDDDIIIIAAAAGGGGNNNNOOOOSSSSTTTTIIIICCCC____SSSSOOOOLLLLVVVVEEEE____1111(((()))) below).

     Application programs can generate diagnostics  by  exploring
     them  using  this  iterator  procedure. To spare memory, the
     successors of a boolean variable contained in its diagnostic
     are  provided by the iterator procedure as pointers to vari-
     ables that were stored in the internal tables when the vari-
     able         was         solved        (see        procedure
     CCCCAAAAEEEESSSSAAAARRRR____SSSSTTTTAAAARRRRTTTT____DDDDIIIIAAAAGGGGNNNNOOOOSSSSTTTTIIIICCCC____SSSSOOOOLLLLVVVVEEEE____1111(((())))   below).    Consequently,
     these variables should neither be modified, nor freed by the
     application program.




(C) INRIA     Last change: 2020/02/11 (version 1.3)             7






OPEN/CAESAR MANUAL                          caesar_solve_1(LOCAL)



     Note: Edges contained in diagnostics preserve  the  informa-
     tion  (label)  that was attached to the edges of the boolean
     graph   by   the   application   program   (see    procedure
     CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTEEEE____SSSSOOOOLLLLVVVVEEEE____1111(((()))) below).



DDDDEEEESSSSCCCCRRRRIIIIPPPPTTTTIIIIOOOONNNN
     The ``solve_1'' library allows to create and handle  boolean
     equation  systems on the fly, providing procedures for reso-
     lution, inspection, diagnostic generation, reading from, and
     writing to text files.



FFFFEEEEAAAATTTTUUUURRRREEEESSSS
      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSOOOOLLLLVVVVEEEE____1111

     ttttyyyyppppeeeeddddeeeeffff CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____AAAABBBBSSSSTTTTRRRRAAAACCCCTTTT ((((............)))) CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSOOOOLLLLVVVVEEEE____1111;;;;

     This type denotes a pointer to the  concrete  representation
     of  a  boolean  equation system. This representation is sup-
     posed to be ``opaque''.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____BBBBLLLLOOOOCCCCKKKK____SSSSIIIIGGGGNNNN____SSSSOOOOLLLLVVVVEEEE____1111

     ttttyyyyppppeeeeddddeeeeffff CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____BBBBOOOOOOOOLLLLEEEEAAAANNNN CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____BBBBLLLLOOOOCCCCKKKK____SSSSIIIIGGGGNNNN____SSSSOOOOLLLLVVVVEEEE____1111;;;;

     This type indicates  the  sign  (minimal  or  maximal  fixed
     point) associated to an equation block of a boolean equation
     system.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____MMMMIIIINNNNIIIIMMMMAAAALLLL____FFFFIIIIXXXXEEEEDDDD____PPPPOOOOIIIINNNNTTTT____SSSSOOOOLLLLVVVVEEEE____1111

     ####ddddeeeeffffiiiinnnneeee CCCCAAAAEEEESSSSAAAARRRR____MMMMIIIINNNNIIIIMMMMAAAALLLL____FFFFIIIIXXXXEEEEDDDD____PPPPOOOOIIIINNNNTTTT____SSSSOOOOLLLLVVVVEEEE____1111 \\\\
        ((((((((CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____BBBBLLLLOOOOCCCCKKKK____SSSSIIIIGGGGNNNN____SSSSOOOOLLLLVVVVEEEE____1111)))) CCCCAAAAEEEESSSSAAAARRRR____TTTTRRRRUUUUEEEE))))

     This constant denotes the minimal fixed point sign.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____MMMMAAAAXXXXIIIIMMMMAAAALLLL____FFFFIIIIXXXXEEEEDDDD____PPPPOOOOIIIINNNNTTTT____SSSSOOOOLLLLVVVVEEEE____1111




(C) INRIA     Last change: 2020/02/11 (version 1.3)             8






OPEN/CAESAR MANUAL                          caesar_solve_1(LOCAL)



     ####ddddeeeeffffiiiinnnneeee CCCCAAAAEEEESSSSAAAARRRR____MMMMAAAAXXXXIIIIMMMMAAAALLLL____FFFFIIIIXXXXEEEEDDDD____PPPPOOOOIIIINNNNTTTT____SSSSOOOOLLLLVVVVEEEE____1111 \\\\
        ((((((((CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____BBBBLLLLOOOOCCCCKKKK____SSSSIIIIGGGGNNNN____SSSSOOOOLLLLVVVVEEEE____1111)))) CCCCAAAAEEEESSSSAAAARRRR____FFFFAAAALLLLSSSSEEEE))))

     This constant denotes the maximal fixed point sign.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____VVVVAAAARRRRIIIIAAAABBBBLLLLEEEE____KKKKIIIINNNNDDDD____SSSSOOOOLLLLVVVVEEEE____1111

     ttttyyyyppppeeeeddddeeeeffff CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____BBBBOOOOOOOOLLLLEEEEAAAANNNN CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____VVVVAAAARRRRIIIIAAAABBBBLLLLEEEE____KKKKIIIINNNNDDDD____SSSSOOOOLLLLVVVVEEEE____1111;;;;

     This type indicates the kind  (disjunctive  or  conjunctive)
     associated to a boolean variable.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____DDDDIIIISSSSJJJJUUUUNNNNCCCCTTTTIIIIVVVVEEEE____VVVVAAAARRRRIIIIAAAABBBBLLLLEEEE____SSSSOOOOLLLLVVVVEEEE____1111

     ####ddddeeeeffffiiiinnnneeee CCCCAAAAEEEESSSSAAAARRRR____DDDDIIIISSSSJJJJUUUUNNNNCCCCTTTTIIIIVVVVEEEE____VVVVAAAARRRRIIIIAAAABBBBLLLLEEEE____SSSSOOOOLLLLVVVVEEEE____1111 \\\\
        ((((((((CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____VVVVAAAARRRRIIIIAAAABBBBLLLLEEEE____KKKKIIIINNNNDDDD____SSSSOOOOLLLLVVVVEEEE____1111)))) CCCCAAAAEEEESSSSAAAARRRR____TTTTRRRRUUUUEEEE))))

     This constant denotes the disjunctive variable kind.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____CCCCOOOONNNNJJJJUUUUNNNNCCCCTTTTIIIIVVVVEEEE____VVVVAAAARRRRIIIIAAAABBBBLLLLEEEE____SSSSOOOOLLLLVVVVEEEE____1111

     ####ddddeeeeffffiiiinnnneeee CCCCAAAAEEEESSSSAAAARRRR____CCCCOOOONNNNJJJJUUUUNNNNCCCCTTTTIIIIVVVVEEEE____VVVVAAAARRRRIIIIAAAABBBBLLLLEEEE____SSSSOOOOLLLLVVVVEEEE____1111 \\\\
        ((((((((CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____VVVVAAAARRRRIIIIAAAABBBBLLLLEEEE____KKKKIIIINNNNDDDD____SSSSOOOOLLLLVVVVEEEE____1111)))) CCCCAAAAEEEESSSSAAAARRRR____FFFFAAAALLLLSSSSEEEE))))

     This constant denotes the conjunctive variable kind.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____BBBBLLLLOOOOCCCCKKKK____SSSSIIIIGGGGNNNN____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN____SSSSOOOOLLLLVVVVEEEE____1111

     ttttyyyyppppeeeeddddeeeeffff CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____BBBBLLLLOOOOCCCCKKKK____SSSSIIIIGGGGNNNN____SSSSOOOOLLLLVVVVEEEE____1111
        ((((****CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____BBBBLLLLOOOOCCCCKKKK____SSSSIIIIGGGGNNNN____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN____SSSSOOOOLLLLVVVVEEEE____1111)))) ((((CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL))));;;;

     This type denotes a pointer to a  function  which  takes  as
     parameter  a natural number (index of an equation block) and
     returns the sign (minimal or maximal  fixed  point)  of  the
     block.


      ............................................................





(C) INRIA     Last change: 2020/02/11 (version 1.3)             9






OPEN/CAESAR MANUAL                          caesar_solve_1(LOCAL)



  CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____VVVVAAAARRRRIIIIAAAABBBBLLLLEEEE____KKKKIIIINNNNDDDD____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN____SSSSOOOOLLLLVVVVEEEE____1111

     ttttyyyyppppeeeeddddeeeeffff CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____VVVVAAAARRRRIIIIAAAABBBBLLLLEEEE____KKKKIIIINNNNDDDD____SSSSOOOOLLLLVVVVEEEE____1111
        ((((****CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____VVVVAAAARRRRIIIIAAAABBBBLLLLEEEE____KKKKIIIINNNNDDDD____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN____SSSSOOOOLLLLVVVVEEEE____1111)))) ((((CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____PPPPOOOOIIIINNNNTTTTEEEERRRR))));;;;

     This type denotes a pointer to a  function  which  takes  as
     parameter  a  pointer  to a boolean variable and returns the
     kind (disjunctive or conjunctive) of the variable.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____AAAARRRREEEEAAAA____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN____SSSSOOOOLLLLVVVVEEEE____1111

     ttttyyyyppppeeeeddddeeeeffff CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____AAAARRRREEEEAAAA____1111
        ((((****CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____AAAARRRREEEEAAAA____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN____SSSSOOOOLLLLVVVVEEEE____1111)))) ((((CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL))));;;;

     This type denotes a pointer to a  function  which  takes  as
     parameter  a natural number (index of an equation block) and
     returns the area (size and alignment) of the  boolean  vari-
     ables defined in that block.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____BBBBOOOOOOOOLLLLEEEEAAAANNNN____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN____SSSSOOOOLLLLVVVVEEEE____1111

     ttttyyyyppppeeeeddddeeeeffff CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____BBBBOOOOOOOOLLLLEEEEAAAANNNN
        ((((****CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____BBBBOOOOOOOOLLLLEEEEAAAANNNN____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN____SSSSOOOOLLLLVVVVEEEE____1111)))) ((((CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL))));;;;

     This type denotes a pointer to a  function  which  takes  as
     parameter a natural number and returns a boolean value.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN____SSSSOOOOLLLLVVVVEEEE____1111

     ttttyyyyppppeeeeddddeeeeffff CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL
        ((((****CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN____SSSSOOOOLLLLVVVVEEEE____1111)))) ((((CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL))));;;;

     This type denotes a pointer to a  function  which  takes  as
     parameter a natural number and returns a natural number.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____EEEERRRRRRRROOOORRRR____SSSSOOOOLLLLVVVVEEEE____1111

     ttttyyyyppppeeeeddddeeeeffff eeeennnnuuuummmm {{{{
          CCCCAAAAEEEESSSSAAAARRRR____NNNNOOOONNNNEEEE____SSSSOOOOLLLLVVVVEEEE____1111,,,,
          CCCCAAAAEEEESSSSAAAARRRR____MMMMUUUULLLLTTTTIIIIPPPPLLLLEEEE____RRRREEEESSSSOOOOLLLLUUUUTTTTIIIIOOOONNNN____SSSSOOOOLLLLVVVVEEEE____1111,,,,



(C) INRIA     Last change: 2020/02/11 (version 1.3)            10






OPEN/CAESAR MANUAL                          caesar_solve_1(LOCAL)



          CCCCAAAAEEEESSSSAAAARRRR____MMMMEEEEMMMMOOOORRRRYYYY____SSSSHHHHOOOORRRRTTTTAAAAGGGGEEEE____SSSSOOOOLLLLVVVVEEEE____1111,,,,
          CCCCAAAAEEEESSSSAAAARRRR____RRRREEEECCCCUUUURRRRSSSSIIIIVVVVEEEE____BBBBLLLLOOOOCCCCKKKK____SSSSOOOOLLLLVVVVEEEE____1111,,,,
          CCCCAAAAEEEESSSSAAAARRRR____CCCCYYYYCCCCLLLLIIIICCCC____BBBBLLLLOOOOCCCCKKKK____SSSSOOOOLLLLVVVVEEEE____1111,,,,
          CCCCAAAAEEEESSSSAAAARRRR____NNNNOOOOTTTT____DDDDIIIISSSSJJJJUUUUNNNNCCCCTTTTIIIIVVVVEEEE____BBBBLLLLOOOOCCCCKKKK____SSSSOOOOLLLLVVVVEEEE____1111,,,,
          CCCCAAAAEEEESSSSAAAARRRR____NNNNOOOOTTTT____CCCCOOOONNNNJJJJUUUUNNNNCCCCTTTTIIIIVVVVEEEE____BBBBLLLLOOOOCCCCKKKK____SSSSOOOOLLLLVVVVEEEE____1111,,,,
          CCCCAAAAEEEESSSSAAAARRRR____MMMMIIIINNNNIIIIMMMMAAAALLLL____FFFFIIIIXXXXEEEEDDDD____PPPPOOOOIIIINNNNTTTT____BBBBLLLLOOOOCCCCKKKK____SSSSOOOOLLLLVVVVEEEE____1111,,,,
          CCCCAAAAEEEESSSSAAAARRRR____MMMMAAAAXXXXIIIIMMMMAAAALLLL____FFFFIIIIXXXXEEEEDDDD____PPPPOOOOIIIINNNNTTTT____BBBBLLLLOOOOCCCCKKKK____SSSSOOOOLLLLVVVVEEEE____1111
     }}}}    CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____EEEERRRRRRRROOOORRRR____SSSSOOOOLLLLVVVVEEEE____1111;;;;

     This enumerated type defines the error codes produced  as  a
     side     effect     by     calls     to     the     function
     CCCCAAAAEEEESSSSAAAARRRR____CCCCOOOOMMMMPPPPUUUUTTTTEEEE____SSSSOOOOLLLLVVVVEEEE____1111(((()))) (see  below),  which  performs  the
     resolution  of  a  boolean  variable defined in a block of a
     boolean equation system. The error codes have the  following
     meaning:

     -    CCCCAAAAEEEESSSSAAAARRRR____NNNNOOOONNNNEEEE____SSSSOOOOLLLLVVVVEEEE____1111 indicates that the  resolution  was
          performed successfully.

     -    CCCCAAAAEEEESSSSAAAARRRR____MMMMUUUULLLLTTTTIIIIPPPPLLLLEEEE____RRRREEEESSSSOOOOLLLLUUUUTTTTIIIIOOOONNNN____SSSSOOOOLLLLVVVVEEEE____1111    indicates    that
          another  resolution  of  a  variable  of  the block was
          already performed,  whereas  at  the  creation  of  the
          boolean      equation     system     (see     procedure
          CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTEEEE____SSSSOOOOLLLLVVVVEEEE____1111(((()))) below) a single resolution  was
          specified  for  the  block.   If  one of the resolution
          algorithms 6 or 7,  dedicated  to  blocks  with  single
          resolution,  was  specified  for  the block, this error
          code is produced regardless of the fact that  a  single
          resolution was specified or not for the block.

     -    CCCCAAAAEEEESSSSAAAARRRR____MMMMEEEEMMMMOOOORRRRYYYY____SSSSHHHHOOOORRRRTTTTAAAAGGGGEEEE____SSSSOOOOLLLLVVVVEEEE____1111 indicates that a  memory
          allocation failed during the resolution.

     -    CCCCAAAAEEEESSSSAAAARRRR____RRRREEEECCCCUUUURRRRSSSSIIIIVVVVEEEE____BBBBLLLLOOOOCCCCKKKK____SSSSOOOOLLLLVVVVEEEE____1111 indicates  the  presence
          of  a  cyclic  dependency  between  the  blocks  of the
          boolean   equation   system,   which    violates    the
          alternation-free condition.

     -    CCCCAAAAEEEESSSSAAAARRRR____CCCCYYYYCCCCLLLLIIIICCCC____BBBBLLLLOOOOCCCCKKKK____SSSSOOOOLLLLVVVVEEEE____1111 indicates the presence of a
          cyclic  dependency between the variables defined in the
          block, whereas at the creation of the boolean  equation
          system  (see  procedure  CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTEEEE____SSSSOOOOLLLLVVVVEEEE____1111(((()))) below)
          the  resolution  algorithm  2,  dedicated  to   acyclic
          blocks, was specified for the block.

     -    CCCCAAAAEEEESSSSAAAARRRR____NNNNOOOOTTTT____DDDDIIIISSSSJJJJUUUUNNNNCCCCTTTTIIIIVVVVEEEE____BBBBLLLLOOOOCCCCKKKK____SSSSOOOOLLLLVVVVEEEE____1111 indicates that the
          current  block is not disjunctive, whereas at the crea-
          tion of the  boolean  equation  system  (see  procedure
          CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTEEEE____SSSSOOOOLLLLVVVVEEEE____1111(((())))  below)  one  of the resolution
          algorithms 3 or 6, dedicated to disjunctive blocks, was
          specified for the block.




(C) INRIA     Last change: 2020/02/11 (version 1.3)            11






OPEN/CAESAR MANUAL                          caesar_solve_1(LOCAL)



     -    CCCCAAAAEEEESSSSAAAARRRR____NNNNOOOOTTTT____CCCCOOOONNNNJJJJUUUUNNNNCCCCTTTTIIIIVVVVEEEE____BBBBLLLLOOOOCCCCKKKK____SSSSOOOOLLLLVVVVEEEE____1111 indicates that the
          current  block is not conjunctive, whereas at the crea-
          tion of the  boolean  equation  system  (see  procedure
          CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTEEEE____SSSSOOOOLLLLVVVVEEEE____1111(((())))  below)  one  of the resolution
          algorithms 4 or 7, dedicated to conjunctive blocks, was
          specified for the block.

     -    CCCCAAAAEEEESSSSAAAARRRR____MMMMIIIINNNNIIIIMMMMAAAALLLL____FFFFIIIIXXXXEEEEDDDD____PPPPOOOOIIIINNNNTTTT____BBBBLLLLOOOOCCCCKKKK____SSSSOOOOLLLLVVVVEEEE____1111 indicates that
          the  current  block  denotes  a  minimal  fixed  point,
          whereas at the creation of the boolean equation  system
          (see procedure CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTEEEE____SSSSOOOOLLLLVVVVEEEE____1111(((()))) below) the reso-
          lution algorithm 7, dedicated to  maximal  fixed  point
          blocks, was specified for the block.

     -    CCCCAAAAEEEESSSSAAAARRRR____MMMMAAAAXXXXIIIIMMMMAAAALLLL____FFFFIIIIXXXXEEEEDDDD____PPPPOOOOIIIINNNNTTTT____BBBBLLLLOOOOCCCCKKKK____SSSSOOOOLLLLVVVVEEEE____1111 indicates that
          the  current  block  denotes  a  maximal  fixed  point,
          whereas at the creation of the boolean equation  system
          (see procedure CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTEEEE____SSSSOOOOLLLLVVVVEEEE____1111(((()))) below) the reso-
          lution algorithm 6, dedicated to  minimal  fixed  point
          blocks, was specified for the block.

     Note:   The   error   code   produced   by   a    call    to
     CCCCAAAAEEEESSSSAAAARRRR____CCCCOOOOMMMMPPPPUUUUTTTTEEEE____SSSSOOOOLLLLVVVVEEEE____1111(((())))  can be obtained by using the func-
     tion CCCCAAAAEEEESSSSAAAARRRR____SSSSTTTTAAAATTTTUUUUSSSS____CCCCOOOOMMMMPPPPUUUUTTTTEEEE____SSSSOOOOLLLLVVVVEEEE____1111(((()))) (see below).


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTEEEE____SSSSOOOOLLLLVVVVEEEE____1111

     vvvvooooiiiidddd CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTEEEE____SSSSOOOOLLLLVVVVEEEE____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____BBBB,,,,
                                 CCCCAAAAEEEESSSSAAAARRRR____NNNNUUUUMMMMBBBBEEEERRRR____OOOOFFFF____BBBBLLLLOOOOCCCCKKKKSSSS,,,,
                                 CCCCAAAAEEEESSSSAAAARRRR____BBBBLLLLOOOOCCCCKKKK____SSSSIIIIGGGGNNNN,,,,
                                 CCCCAAAAEEEESSSSAAAARRRR____BBBBLLLLOOOOCCCCKKKK____UUUUNNNNIIIIQQQQUUUUEEEE____RRRREEEESSSSOOOOLLLLUUUUTTTTIIIIOOOONNNN,,,,
                                 CCCCAAAAEEEESSSSAAAARRRR____BBBBLLLLOOOOCCCCKKKK____SSSSOOOOLLLLVVVVEEEE____MMMMOOOODDDDEEEE,,,,
                                 CCCCAAAAEEEESSSSAAAARRRR____BBBBLLLLOOOOCCCCKKKK____VVVVAAAARRRRIIIIAAAABBBBLLLLEEEE____AAAARRRREEEEAAAA,,,,
                                 CCCCAAAAEEEESSSSAAAARRRR____BBBBLLLLOOOOCCCCKKKK____LLLLIIIIMMMMIIIITTTT____SSSSIIIIZZZZEEEE,,,,
                                 CCCCAAAAEEEESSSSAAAARRRR____BBBBLLLLOOOOCCCCKKKK____HHHHAAAASSSSHHHH____SSSSIIIIZZZZEEEE,,,,
                                 CCCCAAAAEEEESSSSAAAARRRR____BBBBLLLLOOOOCCCCKKKK____PPPPRRRRIIIIMMMMEEEE,,,,
                                 CCCCAAAAEEEESSSSAAAARRRR____VVVVAAAARRRRIIIIAAAABBBBLLLLEEEE____KKKKIIIINNNNDDDD,,,,
                                 CCCCAAAAEEEESSSSAAAARRRR____VVVVAAAARRRRIIIIAAAABBBBLLLLEEEE____CCCCOOOOMMMMPPPPAAAARRRREEEE,,,,
                                 CCCCAAAAEEEESSSSAAAARRRR____VVVVAAAARRRRIIIIAAAABBBBLLLLEEEE____HHHHAAAASSSSHHHH,,,,
                                 CCCCAAAAEEEESSSSAAAARRRR____VVVVAAAARRRRIIIIAAAABBBBLLLLEEEE____PPPPRRRRIIIINNNNTTTT,,,,
                                 CCCCAAAAEEEESSSSAAAARRRR____VVVVAAAARRRRIIIIAAAABBBBLLLLEEEE____IIIITTTTEEEERRRRAAAATTTTEEEE,,,,
                                 CCCCAAAAEEEESSSSAAAARRRR____IIIINNNNFFFFOOOO))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSOOOOLLLLVVVVEEEE____1111 ****CCCCAAAAEEEESSSSAAAARRRR____BBBB;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL CCCCAAAAEEEESSSSAAAARRRR____NNNNUUUUMMMMBBBBEEEERRRR____OOOOFFFF____BBBBLLLLOOOOCCCCKKKKSSSS;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____BBBBLLLLOOOOCCCCKKKK____SSSSIIIIGGGGNNNN____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN____SSSSOOOOLLLLVVVVEEEE____1111 CCCCAAAAEEEESSSSAAAARRRR____BBBBLLLLOOOOCCCCKKKK____SSSSIIIIGGGGNNNN;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____BBBBOOOOOOOOLLLLEEEEAAAANNNN____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN____SSSSOOOOLLLLVVVVEEEE____1111 CCCCAAAAEEEESSSSAAAARRRR____BBBBLLLLOOOOCCCCKKKK____UUUUNNNNIIIIQQQQUUUUEEEE____RRRREEEESSSSOOOOLLLLUUUUTTTTIIIIOOOONNNN;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN____SSSSOOOOLLLLVVVVEEEE____1111 CCCCAAAAEEEESSSSAAAARRRR____BBBBLLLLOOOOCCCCKKKK____SSSSOOOOLLLLVVVVEEEE____MMMMOOOODDDDEEEE;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____AAAARRRREEEEAAAA____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN____SSSSOOOOLLLLVVVVEEEE____1111 CCCCAAAAEEEESSSSAAAARRRR____BBBBLLLLOOOOCCCCKKKK____VVVVAAAARRRRIIIIAAAABBBBLLLLEEEE____AAAARRRREEEEAAAA;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN____SSSSOOOOLLLLVVVVEEEE____1111 CCCCAAAAEEEESSSSAAAARRRR____BBBBLLLLOOOOCCCCKKKK____LLLLIIIIMMMMIIIITTTT____SSSSIIIIZZZZEEEE;;;;



(C) INRIA     Last change: 2020/02/11 (version 1.3)            12






OPEN/CAESAR MANUAL                          caesar_solve_1(LOCAL)



        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN____SSSSOOOOLLLLVVVVEEEE____1111 CCCCAAAAEEEESSSSAAAARRRR____BBBBLLLLOOOOCCCCKKKK____HHHHAAAASSSSHHHH____SSSSIIIIZZZZEEEE;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____BBBBOOOOOOOOLLLLEEEEAAAANNNN____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN____SSSSOOOOLLLLVVVVEEEE____1111 CCCCAAAAEEEESSSSAAAARRRR____BBBBLLLLOOOOCCCCKKKK____PPPPRRRRIIIIMMMMEEEE;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____VVVVAAAARRRRIIIIAAAABBBBLLLLEEEE____KKKKIIIINNNNDDDD____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN____SSSSOOOOLLLLVVVVEEEE____1111 CCCCAAAAEEEESSSSAAAARRRR____VVVVAAAARRRRIIIIAAAABBBBLLLLEEEE____KKKKIIIINNNNDDDD;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____CCCCOOOOMMMMPPPPAAAARRRREEEE____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN CCCCAAAAEEEESSSSAAAARRRR____VVVVAAAARRRRIIIIAAAABBBBLLLLEEEE____CCCCOOOOMMMMPPPPAAAARRRREEEE;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____HHHHAAAASSSSHHHH____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN CCCCAAAAEEEESSSSAAAARRRR____VVVVAAAARRRRIIIIAAAABBBBLLLLEEEE____HHHHAAAASSSSHHHH;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____PPPPRRRRIIIINNNNTTTT____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN CCCCAAAAEEEESSSSAAAARRRR____VVVVAAAARRRRIIIIAAAABBBBLLLLEEEE____PPPPRRRRIIIINNNNTTTT;;;;
        vvvvooooiiiidddd ((((****CCCCAAAAEEEESSSSAAAARRRR____VVVVAAAARRRRIIIIAAAABBBBLLLLEEEE____IIIITTTTEEEERRRRAAAATTTTEEEE)))) ((((CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____PPPPOOOOIIIINNNNTTTTEEEERRRR,,,, CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____PPPPOOOOIIIINNNNTTTTEEEERRRR,,,,
           vvvvooooiiiidddd ((((****)))) ((((CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____PPPPOOOOIIIINNNNTTTTEEEERRRR,,,, CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL,,,, CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____PPPPOOOOIIIINNNNTTTTEEEERRRR))))))));;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____PPPPOOOOIIIINNNNTTTTEEEERRRR CCCCAAAAEEEESSSSAAAARRRR____IIIINNNNFFFFOOOO;;;;
        {{{{ ............ }}}}

     This procedure allocates a  boolean  equation  system  using
     CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTEEEE(((()))) and assigns its address to ****CCCCAAAAEEEESSSSAAAARRRR____BBBB. If the
     allocation fails, the NNNNUUUULLLLLLLL value is assigned to ****CCCCAAAAEEEESSSSAAAARRRR____BBBB.

     Note: Because CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSOOOOLLLLVVVVEEEE____1111 is  a  pointer  type,  any
     variable  CCCCAAAAEEEESSSSAAAARRRR____BBBB of type CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSOOOOLLLLVVVVEEEE____1111 must be allo-
     cated before used, for instance using:

               CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTEEEE____SSSSOOOOLLLLVVVVEEEE____1111 ((((&&&&CCCCAAAAEEEESSSSAAAARRRR____BBBB,,,, ............))));;;;


     The value of CCCCAAAAEEEESSSSAAAARRRR____NNNNUUUUMMMMBBBBEEEERRRR____OOOOFFFF____BBBBLLLLOOOOCCCCKKKKSSSS determines  the  number
     of equation blocks contained in the boolean equation system.
     Each equation block will be assigned an unique index in  the
     range  0..CCCCAAAAEEEESSSSAAAARRRR____NNNNUUUUMMMMBBBBEEEERRRR____OOOOFFFF____BBBBLLLLOOOOCCCCKKKKSSSS  -  1.  If  the  value  of
     CCCCAAAAEEEESSSSAAAARRRR____NNNNUUUUMMMMBBBBEEEERRRR____OOOOFFFF____BBBBLLLLOOOOCCCCKKKKSSSS is zero, the effect is undefined.

     The actual value of the formal  parameter  CCCCAAAAEEEESSSSAAAARRRR____BBBBLLLLOOOOCCCCKKKK____SSSSIIIIGGGGNNNN
     will be stored and associated to the boolean equation system
     pointed to by ****CCCCAAAAEEEESSSSAAAARRRR____BBBB. It will be used to assign  to  each
     equation  block  its  corresponding sign, indicating whether
     the block denotes a minimal or a maximal fixed point.

     Precisely, the actual value of CCCCAAAAEEEESSSSAAAARRRR____BBBBLLLLOOOOCCCCKKKK____SSSSIIIIGGGGNNNN should be a
     pointer  to  a  function  with a parameter ccccaaaaeeeessssaaaarrrr____bbbblllloooocccckkkk that
     returns      CCCCAAAAEEEESSSSAAAARRRR____MMMMIIIINNNNIIIIMMMMAAAALLLL____FFFFIIIIXXXXEEEEDDDD____PPPPOOOOIIIINNNNTTTT____SSSSOOOOLLLLVVVVEEEE____1111       (resp.
     CCCCAAAAEEEESSSSAAAARRRR____MMMMAAAAXXXXIIIIMMMMAAAALLLL____FFFFIIIIXXXXEEEEDDDD____PPPPOOOOIIIINNNNTTTT____SSSSOOOOLLLLVVVVEEEE____1111) if the equation block of
     index ccccaaaaeeeessssaaaarrrr____bbbblllloooocccckkkk denotes a minimal fixed  point  (resp.  a
     maximal  fixed  point),  where  ccccaaaaeeeessssaaaarrrr____bbbblllloooocccckkkk is in the range
     0..CCCCAAAAEEEESSSSAAAARRRR____NNNNUUUUMMMMBBBBEEEERRRR____OOOOFFFF____BBBBLLLLOOOOCCCCKKKKSSSS - 1.

     The    actual    value    of    the     formal     parameter
     CCCCAAAAEEEESSSSAAAARRRR____BBBBLLLLOOOOCCCCKKKK____UUUUNNNNIIIIQQQQUUUUEEEE____RRRREEEESSSSOOOOLLLLUUUUTTTTIIIIOOOONNNN will be stored and associated
     to the boolean equation system pointed to by  ****CCCCAAAAEEEESSSSAAAARRRR____BBBB.  It
     will  be  used  to  assign  to each equation block a boolean
     indicating whether only one variable (or several  variables)
     of the block will be solved.

     Precisely,        the        actual         value         of
     CCCCAAAAEEEESSSSAAAARRRR____BBBBLLLLOOOOCCCCKKKK____UUUUNNNNIIIIQQQQUUUUEEEE____RRRREEEESSSSOOOOLLLLUUUUTTTTIIIIOOOONNNN  should  be  a  pointer  to a
     function ccccaaaaeeeessssaaaarrrr____ffff with a parameter ccccaaaaeeeessssaaaarrrr____bbbblllloooocccckkkk that returns



(C) INRIA     Last change: 2020/02/11 (version 1.3)            13






OPEN/CAESAR MANUAL                          caesar_solve_1(LOCAL)



     CCCCAAAAEEEESSSSAAAARRRR____TTTTRRRRUUUUEEEE (resp. CCCCAAAAEEEESSSSAAAARRRR____FFFFAAAALLLLSSSSEEEE) if only one variable (resp.
     several  variables)  of  the   equation   block   of   index
     ccccaaaaeeeessssaaaarrrr____bbbblllloooocccckkkk  will  be  solved, where ccccaaaaeeeessssaaaarrrr____bbbblllloooocccckkkk is in the
     range 0..CCCCAAAAEEEESSSSAAAARRRR____NNNNUUUUMMMMBBBBEEEERRRR____OOOOFFFF____BBBBLLLLOOOOCCCCKKKKSSSS - 1.

     Note: If only one variable of a block will  be  solved,  the
     function   ccccaaaaeeeessssaaaarrrr____ffff   may   return  for  that  block  either
     CCCCAAAAEEEESSSSAAAARRRR____TTTTRRRRUUUUEEEE, or CCCCAAAAEEEESSSSAAAARRRR____FFFFAAAALLLLSSSSEEEE, without influencing the  reso-
     lution  result;  however, returning CCCCAAAAEEEESSSSAAAARRRR____TTTTRRRRUUUUEEEE may increase
     the performance of some resolution algorithms.

     Note: The  equation  blocks  encoding  equivalence  checking
     problems  are  typical examples of blocks for which only one
     variable must be solved, namely  the  variable  representing
     the  equivalence  between the initial states of two labelled
     transition systems.

     The    actual    value    of    the     formal     parameter
     CCCCAAAAEEEESSSSAAAARRRR____BBBBLLLLOOOOCCCCKKKK____SSSSOOOOLLLLVVVVEEEE____MMMMOOOODDDDEEEE will be stored and associated to the
     boolean equation system pointed to by ****CCCCAAAAEEEESSSSAAAARRRR____BBBB. It will  be
     used  to  assign  to  each  equation block its corresponding
     resolution mode, determining which algorithm will be used by
     the resolution routine associated to the block.

     Precisely,  the  actual  value  of   CCCCAAAAEEEESSSSAAAARRRR____BBBBLLLLOOOOCCCCKKKK____SSSSOOOOLLLLVVVVEEEE____MMMMOOOODDDDEEEE
     should  be a pointer to a function ccccaaaaeeeessssaaaarrrr____ffff with a parameter
     ccccaaaaeeeessssaaaarrrr____bbbblllloooocccckkkk that returns the resolution mode associated  to
     the equation block of index ccccaaaaeeeessssaaaarrrr____bbbblllloooocccckkkk, where ccccaaaaeeeessssaaaarrrr____bbbblllloooocccckkkk
     is in the range 0..CCCCAAAAEEEESSSSAAAARRRR____NNNNUUUUMMMMBBBBEEEERRRR____OOOOFFFF____BBBBLLLLOOOOCCCCKKKKSSSS - 1.

     If the resolution mode returned by ccccaaaaeeeessssaaaarrrr____ffff for  some  value
     of  ccccaaaaeeeessssaaaarrrr____bbbblllloooocccckkkk  is  not  among  the aforementioned list of
     available resolution modes, the effect is undefined.

     Note: The resolution algorithms denoted by modes 0, 1, 2, 3,
     and  4  are  described  in  the publications [Mat03,Mat06a],
     where they are named A1, A2, A3, and A4. The  correspondence
     between modes and the names of the algorithms is the follow-
     ing:  mode 0 corresponds to A1; mode 1  corresponds  to  A2;
     mode  2  corresponds  to  A3;  modes 3 and 4, which are sym-
     metric, correspond to A4.

     Note: If the boolean equation system pointed to by ****CCCCAAAAEEEESSSSAAAARRRR____BBBB
     contains  several equation blocks, each block may have asso-
     ciated a different resolution mode.  In  practice,  this  is
     useful for independently optimizing the resolution of blocks
     having a particular structure (e.g.,  acyclic,  disjunctive,
     conjunctive).

     The    actual    value    of    the     formal     parameter
     CCCCAAAAEEEESSSSAAAARRRR____BBBBLLLLOOOOCCCCKKKK____VVVVAAAARRRRIIIIAAAABBBBLLLLEEEE____AAAARRRREEEEAAAA  will be stored and associated to
     the boolean equation system pointed to by ****CCCCAAAAEEEESSSSAAAARRRR____BBBB. It will



(C) INRIA     Last change: 2020/02/11 (version 1.3)            14






OPEN/CAESAR MANUAL                          caesar_solve_1(LOCAL)



     be used to assign to each equation block the (constant) size
     and (constant) alignment factor  of  the  boolean  variables
     defined in the block.

     Precisely, the actual  value  of  CCCCAAAAEEEESSSSAAAARRRR____BBBBLLLLOOOOCCCCKKKK____VVVVAAAARRRRIIIIAAAABBBBLLLLEEEE____AAAARRRREEEEAAAA
     should   be  a  pointer  to  a  function  with  a  parameter
     ccccaaaaeeeessssaaaarrrr____bbbblllloooocccckkkk that returns  the  area  (which  indicates  the
     length  and  alignment  factor)  of  the  boolean  variables
     defined in the equation block of index  ccccaaaaeeeessssaaaarrrr____bbbblllloooocccckkkk,  where
     ccccaaaaeeeessssaaaarrrr____bbbblllloooocccckkkk is in the range 0..CCCCAAAAEEEESSSSAAAARRRR____NNNNUUUUMMMMBBBBEEEERRRR____OOOOFFFF____BBBBLLLLOOOOCCCCKKKKSSSS - 1.

     The    actual    value    of    the     formal     parameter
     CCCCAAAAEEEESSSSAAAARRRR____BBBBLLLLOOOOCCCCKKKK____LLLLIIIIMMMMIIIITTTT____SSSSIIIIZZZZEEEE will be stored and associated to the
     boolean equation system pointed to by ****CCCCAAAAEEEESSSSAAAARRRR____BBBB. It will  be
     used  to  assign  to  each  equation  block the maximal size
     (number of items) of the internal table  associated  to  the
     block.

     Precisely,  the  actual  value  of   CCCCAAAAEEEESSSSAAAARRRR____BBBBLLLLOOOOCCCCKKKK____LLLLIIIIMMMMIIIITTTT____SSSSIIIIZZZZEEEE
     should  be a pointer to a function ccccaaaaeeeessssaaaarrrr____ffff with a parameter
     ccccaaaaeeeessssaaaarrrr____bbbblllloooocccckkkk that returns the maximal size (number of items)
     of  the  internal  table associated to the equation block of
     index ccccaaaaeeeessssaaaarrrr____bbbblllloooocccckkkk,  where  ccccaaaaeeeessssaaaarrrr____bbbblllloooocccckkkk  is  in  the  range
     0..CCCCAAAAEEEESSSSAAAARRRR____NNNNUUUUMMMMBBBBEEEERRRR____OOOOFFFF____BBBBLLLLOOOOCCCCKKKKSSSS   -  1.  The  value  returned  by
     ccccaaaaeeeessssaaaarrrr____ffff must be less or equal to a predefined value M  (see
     the  ``table_1''  library).  If  it  is equal to zero, it is
     replaced by the default value M.

     The    actual    value    of    the     formal     parameter
     CCCCAAAAEEEESSSSAAAARRRR____BBBBLLLLOOOOCCCCKKKK____HHHHAAAASSSSHHHH____SSSSIIIIZZZZEEEE  will be stored and associated to the
     boolean equation system pointed to by ****CCCCAAAAEEEESSSSAAAARRRR____BBBB. It will  be
     used  to  assign  to each equation block the size (number of
     entries) of the hash-table accompanying the  internal  table
     associated to the block.

     Precisely, the actual value of CCCCAAAAEEEESSSSAAAARRRR____BBBBLLLLOOOOCCCCKKKK____HHHHAAAASSSSHHHH____SSSSIIIIZZZZEEEE should
     be  a  pointer  to  a  function  ccccaaaaeeeessssaaaarrrr____ffff  with  a parameter
     ccccaaaaeeeessssaaaarrrr____bbbblllloooocccckkkk that returns the size (number  of  entries)  of
     the hash-table accompanying the internal table associated to
     the equation block of index ccccaaaaeeeessssaaaarrrr____bbbblllloooocccckkkk, where ccccaaaaeeeessssaaaarrrr____bbbblllloooocccckkkk
     is in the range 0..CCCCAAAAEEEESSSSAAAARRRR____NNNNUUUUMMMMBBBBEEEERRRR____OOOOFFFF____BBBBLLLLOOOOCCCCKKKKSSSS - 1. If the value
     returned by ccccaaaaeeeessssaaaarrrr____ffff for some value of ccccaaaaeeeessssaaaarrrr____bbbblllloooocccckkkk is zero,
     it  is  replaced with a default value greater than zero (see
     the ``table_1'' library).

     The actual value of the formal parameter  CCCCAAAAEEEESSSSAAAARRRR____BBBBLLLLOOOOCCCCKKKK____PPPPRRRRIIIIMMMMEEEE
     will be stored and associated to the boolean equation system
     pointed to by ****CCCCAAAAEEEESSSSAAAARRRR____BBBB. It will be used to assign  to  each
     equation  block  a boolean value allowing to adjust the size
     of the hash-table accompanying the internal table associated
     to the block.




(C) INRIA     Last change: 2020/02/11 (version 1.3)            15






OPEN/CAESAR MANUAL                          caesar_solve_1(LOCAL)



     Precisely, the actual value of CCCCAAAAEEEESSSSAAAARRRR____BBBBLLLLOOOOCCCCKKKK____PPPPRRRRIIIIMMMMEEEE should  be
     a   pointer   to   a  function  ccccaaaaeeeessssaaaarrrr____ffff  with  a  parameter
     ccccaaaaeeeessssaaaarrrr____bbbblllloooocccckkkk that returns a  boolean  value  which  will  be
     stored  and  associated  to  the  equation  block  of  index
     ccccaaaaeeeessssaaaarrrr____bbbblllloooocccckkkk,   where   ccccaaaaeeeessssaaaarrrr____bbbblllloooocccckkkk   is   in   the   range
     0..CCCCAAAAEEEESSSSAAAARRRR____NNNNUUUUMMMMBBBBEEEERRRR____OOOOFFFF____BBBBLLLLOOOOCCCCKKKKSSSS  -  1.  If  the value returned by
     ccccaaaaeeeessssaaaarrrr____ffff  for  some  value  of  ccccaaaaeeeessssaaaarrrr____bbbblllloooocccckkkk  is  equal   to
     CCCCAAAAEEEESSSSAAAARRRR____TTTTRRRRUUUUEEEE     and     if    the    value    returned    by
     CCCCAAAAEEEESSSSAAAARRRR____BBBBLLLLOOOOCCCCKKKK____HHHHAAAASSSSHHHH____SSSSIIIIZZZZEEEE for that block is not a prime number,
     this  value  will  be  replaced by the nearest smaller prime
     number (since some hash functions  require  prime  modulus).
     Otherwise,  the value returned by CCCCAAAAEEEESSSSAAAARRRR____BBBBLLLLOOOOCCCCKKKK____HHHHAAAASSSSHHHH____SSSSIIIIZZZZEEEE for
     that block will  be  kept  unchanged  (see  the  ``table_1''
     library).

     The    actual    value    of    the     formal     parameter
     CCCCAAAAEEEESSSSAAAARRRR____VVVVAAAARRRRIIIIAAAABBBBLLLLEEEE____KKKKIIIINNNNDDDD  will  be  stored and associated to the
     boolean equation system pointed to by ****CCCCAAAAEEEESSSSAAAARRRR____BBBB. It will  be
     used  as  a function returning the kind (disjunctive or con-
     junctive) of the boolean variables defined  in  an  equation
     block of the system.

     Precisely, the actual value of  CCCCAAAAEEEESSSSAAAARRRR____VVVVAAAARRRRIIIIAAAABBBBLLLLEEEE____KKKKIIIINNNNDDDD  should
     be  a  pointer  to  a  function  ccccaaaaeeeessssaaaarrrr____ffff  with  a parameter
     ccccaaaaeeeessssaaaarrrr____vvvvaaaarrrriiiiaaaabbbblllleeee                 that                 returns
     CCCCAAAAEEEESSSSAAAARRRR____DDDDIIIISSSSJJJJUUUUNNNNCCCCTTTTIIIIVVVVEEEE____VVVVAAAARRRRIIIIAAAABBBBLLLLEEEE____SSSSOOOOLLLLVVVVEEEE____1111                   (resp.
     CCCCAAAAEEEESSSSAAAARRRR____CCCCOOOONNNNJJJJUUUUNNNNCCCCTTTTIIIIVVVVEEEE____VVVVAAAARRRRIIIIAAAABBBBLLLLEEEE____SSSSOOOOLLLLVVVVEEEE____1111) if the boolean variable
     pointed to by ccccaaaaeeeessssaaaarrrr____vvvvaaaarrrriiiiaaaabbbblllleeee is disjunctive (resp. conjunc-
     tive). The index of the equation block in which the  boolean
     variable  pointed  to  by  ccccaaaaeeeessssaaaarrrr____vvvvaaaarrrriiiiaaaabbbblllleeee is defined can be
     obtained   within   ccccaaaaeeeessssaaaarrrr____ffff   by   calling   the   function
     CCCCAAAAEEEESSSSAAAARRRR____CCCCUUUURRRRRRRREEEENNNNTTTT____BBBBLLLLOOOOCCCCKKKK____SSSSOOOOLLLLVVVVEEEE____1111(((()))) (see below). A pointer to the
     boolean equation system containing  this  block  (i.e.,  the
     value assigned to ****CCCCAAAAEEEESSSSAAAARRRR____BBBB) can be obtained within ccccaaaaeeeessssaaaarrrr____ffff
     by calling the function CCCCAAAAEEEESSSSAAAARRRR____CCCCUUUURRRRRRRREEEENNNNTTTT____SSSSYYYYSSSSTTTTEEEEMMMM____SSSSOOOOLLLLVVVVEEEE____1111(((()))) (see
     below).

     The    actual    value    of    the     formal     parameter
     CCCCAAAAEEEESSSSAAAARRRR____VVVVAAAARRRRIIIIAAAABBBBLLLLEEEE____CCCCOOOOMMMMPPPPAAAARRRREEEE will be stored and associated to the
     boolean equation system pointed to by ****CCCCAAAAEEEESSSSAAAARRRR____BBBB. It will  be
     used  as  a  comparison  function  for the boolean variables
     defined in an equation block of the system.

     Precisely,  the  actual  value  of   CCCCAAAAEEEESSSSAAAARRRR____VVVVAAAARRRRIIIIAAAABBBBLLLLEEEE____CCCCOOOOMMMMPPPPAAAARRRREEEE
     should  be  a pointer to a comparison function ccccaaaaeeeessssaaaarrrr____ffff with
     two parameters ccccaaaaeeeessssaaaarrrr____vvvvaaaarrrriiiiaaaabbbblllleeee____1111 and ccccaaaaeeeessssaaaarrrr____vvvvaaaarrrriiiiaaaabbbblllleeee____2222  that
     returns  CCCCAAAAEEEESSSSAAAARRRR____TTTTRRRRUUUUEEEE  (resp.  CCCCAAAAEEEESSSSAAAARRRR____FFFFAAAALLLLSSSSEEEE)  if  the boolean
     variables    pointed    to    by    ccccaaaaeeeessssaaaarrrr____vvvvaaaarrrriiiiaaaabbbblllleeee____1111    and
     ccccaaaaeeeessssaaaarrrr____vvvvaaaarrrriiiiaaaabbbblllleeee____2222  are equal (resp. different). The index of
     the equation block in which the boolean variables pointed to
     by  ccccaaaaeeeessssaaaarrrr____vvvvaaaarrrriiiiaaaabbbblllleeee____1111  and ccccaaaaeeeessssaaaarrrr____vvvvaaaarrrriiiiaaaabbbblllleeee____2222 are defined can
     be  obtained  within  ccccaaaaeeeessssaaaarrrr____ffff  by  calling   the   function



(C) INRIA     Last change: 2020/02/11 (version 1.3)            16






OPEN/CAESAR MANUAL                          caesar_solve_1(LOCAL)



     CCCCAAAAEEEESSSSAAAARRRR____CCCCUUUURRRRRRRREEEENNNNTTTT____BBBBLLLLOOOOCCCCKKKK____SSSSOOOOLLLLVVVVEEEE____1111(((()))) (see below). A pointer to the
     boolean equation system containing  this  block  (i.e.,  the
     value assigned to ****CCCCAAAAEEEESSSSAAAARRRR____BBBB) can be obtained within ccccaaaaeeeessssaaaarrrr____ffff
     by calling the function CCCCAAAAEEEESSSSAAAARRRR____CCCCUUUURRRRRRRREEEENNNNTTTT____SSSSYYYYSSSSTTTTEEEEMMMM____SSSSOOOOLLLLVVVVEEEE____1111(((()))) (see
     below).

     The    actual    value    of    the     formal     parameter
     CCCCAAAAEEEESSSSAAAARRRR____VVVVAAAARRRRIIIIAAAABBBBLLLLEEEE____HHHHAAAASSSSHHHH  will  be  stored and associated to the
     boolean equation system pointed to by ****CCCCAAAAEEEESSSSAAAARRRR____BBBB. It will  be
     used as a hash-function for the boolean variables defined in
     an equation block of the system.

     Precisely, the actual value of  CCCCAAAAEEEESSSSAAAARRRR____VVVVAAAARRRRIIIIAAAABBBBLLLLEEEE____HHHHAAAASSSSHHHH  should
     be a pointer to a hash function ccccaaaaeeeessssaaaarrrr____ffff with two parameters
     ccccaaaaeeeessssaaaarrrr____vvvvaaaarrrriiiiaaaabbbblllleeee and ccccaaaaeeeessssaaaarrrr____mmmmoooodddduuuulllluuuussss that returns a hash-value
     computed  on  the  byte  string  ccccaaaaeeeessssaaaarrrr____vvvvaaaarrrriiiiaaaabbbblllleeee  [[[[0000]]]]  up to
     ccccaaaaeeeessssaaaarrrr____vvvvaaaarrrriiiiaaaabbbblllleeee [[[[ccccaaaaeeeessssaaaarrrr____ssssiiiizzzzeeee ---- 1111]]]], where the actual value of
     ccccaaaaeeeessssaaaarrrr____ssssiiiizzzzeeee  will always be equal to the size of the boolean
     variable pointed to by ccccaaaaeeeessssaaaarrrr____vvvvaaaarrrriiiiaaaabbbblllleeee. This hash-value must
     belong  to  the  range 0..ccccaaaaeeeessssaaaarrrr____mmmmoooodddduuuulllluuuussss-1. The index of the
     equation block in which the boolean variable pointed  to  by
     ccccaaaaeeeessssaaaarrrr____vvvvaaaarrrriiiiaaaabbbblllleeee  is  defined can be obtained within ccccaaaaeeeessssaaaarrrr____ffff
     by calling the function CCCCAAAAEEEESSSSAAAARRRR____CCCCUUUURRRRRRRREEEENNNNTTTT____BBBBLLLLOOOOCCCCKKKK____SSSSOOOOLLLLVVVVEEEE____1111(((())))  (see
     below).  A pointer to the boolean equation system containing
     this block (i.e., the value assigned to  ****CCCCAAAAEEEESSSSAAAARRRR____BBBB)  can  be
     obtained   within   ccccaaaaeeeessssaaaarrrr____ffff   by   calling   the   function
     CCCCAAAAEEEESSSSAAAARRRR____CCCCUUUURRRRRRRREEEENNNNTTTT____SSSSYYYYSSSSTTTTEEEEMMMM____SSSSOOOOLLLLVVVVEEEE____1111(((()))) (see below).

     The    actual    value    of    the     formal     parameter
     CCCCAAAAEEEESSSSAAAARRRR____VVVVAAAARRRRIIIIAAAABBBBLLLLEEEE____PPPPRRRRIIIINNNNTTTT  will  be stored and associated to the
     boolean equation system pointed to by ****CCCCAAAAEEEESSSSAAAARRRR____BBBB. It will  be
     used  as  a  printing  procedure  for  the boolean variables
     defined in an equation block of the system.

     Precisely, the actual value of CCCCAAAAEEEESSSSAAAARRRR____VVVVAAAARRRRIIIIAAAABBBBLLLLEEEE____PPPPRRRRIIIINNNNTTTT  should
     be  a  pointer  to  a  printing  procedure ccccaaaaeeeessssaaaarrrr____pppp with two
     parameters ccccaaaaeeeessssaaaarrrr____ffffiiiilllleeee and ccccaaaaeeeessssaaaarrrr____vvvvaaaarrrriiiiaaaabbbblllleeee  that  prints  to
     file  ccccaaaaeeeessssaaaarrrr____ffffiiiilllleeee  information  about  the  contents  of the
     boolean variable pointed to by ccccaaaaeeeessssaaaarrrr____vvvvaaaarrrriiiiaaaabbbblllleeee. The index of
     the  equation block in which the boolean variable pointed to
     by  ccccaaaaeeeessssaaaarrrr____vvvvaaaarrrriiiiaaaabbbblllleeee  is  defined  can  be  obtained   within
     ccccaaaaeeeessssaaaarrrr____pppp        by        calling        the        function
     CCCCAAAAEEEESSSSAAAARRRR____CCCCUUUURRRRRRRREEEENNNNTTTT____BBBBLLLLOOOOCCCCKKKK____SSSSOOOOLLLLVVVVEEEE____1111(((()))) (see below). A pointer to the
     boolean  equation  system  containing  this block (i.e., the
     value assigned to ****CCCCAAAAEEEESSSSAAAARRRR____BBBB) can be obtained within ccccaaaaeeeessssaaaarrrr____pppp
     by calling the function CCCCAAAAEEEESSSSAAAARRRR____CCCCUUUURRRRRRRREEEENNNNTTTT____SSSSYYYYSSSSTTTTEEEEMMMM____SSSSOOOOLLLLVVVVEEEE____1111(((()))) (see
     below).

     The    actual    value    of    the     formal     parameter
     CCCCAAAAEEEESSSSAAAARRRR____VVVVAAAARRRRIIIIAAAABBBBLLLLEEEE____IIIITTTTEEEERRRRAAAATTTTEEEE will be stored and associated to the
     boolean equation system pointed to by ****CCCCAAAAEEEESSSSAAAARRRR____BBBB. It will  be
     used  as an iterator procedure enumerating all successors of



(C) INRIA     Last change: 2020/02/11 (version 1.3)            17






OPEN/CAESAR MANUAL                          caesar_solve_1(LOCAL)



     the boolean variables defined in an equation  block  of  the
     system.

     Any user-defined procedure ccccaaaaeeeessssaaaarrrr____pppp can be used as an actual
     value for formal parameter CCCCAAAAEEEESSSSAAAARRRR____VVVVAAAARRRRIIIIAAAABBBBLLLLEEEE____IIIITTTTEEEERRRRAAAATTTTEEEE, provided
     that its declaration has the form:

             vvvvooooiiiidddd ccccaaaaeeeessssaaaarrrr____pppp ((((ccccaaaaeeeessssaaaarrrr____vvvvaaaarrrriiiiaaaabbbblllleeee____1111,,,, ccccaaaaeeeessssaaaarrrr____vvvvaaaarrrriiiiaaaabbbblllleeee____2222,,,, ccccaaaaeeeessssaaaarrrr____lllloooooooopppp))))
                CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____PPPPOOOOIIIINNNNTTTTEEEERRRR ccccaaaaeeeessssaaaarrrr____vvvvaaaarrrriiiiaaaabbbblllleeee____1111;;;;
                CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____PPPPOOOOIIIINNNNTTTTEEEERRRR ccccaaaaeeeessssaaaarrrr____vvvvaaaarrrriiiiaaaabbbblllleeee____2222;;;;
                vvvvooooiiiidddd ((((****ccccaaaaeeeessssaaaarrrr____lllloooooooopppp)))) ((((CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____PPPPOOOOIIIINNNNTTTTEEEERRRR,,,, CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL,,,,
                   CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____PPPPOOOOIIIINNNNTTTTEEEERRRR))));;;;
                {{{{ ............ }}}}

     This procedure ccccaaaaeeeessssaaaarrrr____pppp enumerates  all  successors  of  the
     boolean  variable pointed to by ccccaaaaeeeessssaaaarrrr____vvvvaaaarrrriiiiaaaabbbblllleeee____1111. The index
     of the equation block in which the boolean variable  pointed
     to  by  ccccaaaaeeeessssaaaarrrr____vvvvaaaarrrriiiiaaaabbbblllleeee____1111  is defined can be obtained within
     ccccaaaaeeeessssaaaarrrr____pppp        by        calling        the        function
     CCCCAAAAEEEESSSSAAAARRRR____CCCCUUUURRRRRRRREEEENNNNTTTT____BBBBLLLLOOOOCCCCKKKK____SSSSOOOOLLLLVVVVEEEE____1111(((()))) (see below). A pointer to the
     boolean equation system containing  this  block  (i.e.,  the
     value assigned to ****CCCCAAAAEEEESSSSAAAARRRR____BBBB) can be obtained within ccccaaaaeeeessssaaaarrrr____pppp
     by calling the function CCCCAAAAEEEESSSSAAAARRRR____CCCCUUUURRRRRRRREEEENNNNTTTT____SSSSYYYYSSSSTTTTEEEEMMMM____SSSSOOOOLLLLVVVVEEEE____1111(((()))) (see
     below). At each iteration performed by ccccaaaaeeeessssaaaarrrr____pppp, two actions
     must be carried out:

     -    First,   the   boolean   variable   pointed    to    by
          ccccaaaaeeeessssaaaarrrr____vvvvaaaarrrriiiiaaaabbbblllleeee____2222  must  be  assigned a new value, such
          that ``(ccccaaaaeeeessssaaaarrrr____vvvvaaaarrrriiiiaaaabbbblllleeee____1111, ccccaaaaeeeessssaaaarrrr____vvvvaaaarrrriiiiaaaabbbblllleeee____2222)''  is  an
          edge of the boolean graph.

     -    Second, the procedure pointed to by ccccaaaaeeeessssaaaarrrr____lllloooooooopppp must be
          called.  The  actual  value  of  the  formal  parameter
          ccccaaaaeeeessssaaaarrrr____lllloooooooopppp is a procedure ccccaaaaeeeessssaaaarrrr____qqqq  whose  declaration
          has the form:

                  vvvvooooiiiidddd ccccaaaaeeeessssaaaarrrr____qqqq ((((ccccaaaaeeeessssaaaarrrr____llllaaaabbbbeeeellll,,,, ccccaaaaeeeessssaaaarrrr____bbbblllloooocccckkkk____2222,,,, ccccaaaaeeeessssaaaarrrr____vvvvaaaarrrriiiiaaaabbbblllleeee____2222))))
                     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____PPPPOOOOIIIINNNNTTTTEEEERRRR ccccaaaaeeeessssaaaarrrr____llllaaaabbbbeeeellll;;;;
                     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL ccccaaaaeeeessssaaaarrrr____bbbblllloooocccckkkk____2222;;;;
                     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____PPPPOOOOIIIINNNNTTTTEEEERRRR ccccaaaaeeeessssaaaarrrr____vvvvaaaarrrriiiiaaaabbbblllleeee____2222;;;;
                     {{{{ ............ }}}}

          Therefore, each call to the  procedure  pointed  to  by
          ccccaaaaeeeessssaaaarrrr____lllloooooooopppp must have the following parameters:

               ((((****ccccaaaaeeeessssaaaarrrr____lllloooooooopppp)))) ((((ccccaaaaeeeessssaaaarrrr____llllaaaabbbbeeeellll,,,, ccccaaaaeeeessssaaaarrrr____bbbblllloooocccckkkk____2222,,,, ccccaaaaeeeessssaaaarrrr____vvvvaaaarrrriiiiaaaabbbblllleeee____2222))))

          Parameter ccccaaaaeeeessssaaaarrrr____llllaaaabbbbeeeellll is either a pointer to a  memory
          area  containing  additional  information associated to
          the edge ``(ccccaaaaeeeessssaaaarrrr____vvvvaaaarrrriiiiaaaabbbblllleeee____1111, ccccaaaaeeeessssaaaarrrr____vvvvaaaarrrriiiiaaaabbbblllleeee____2222)''  of
          the  boolean  graph,  or  is  equal  to NNNNUUUULLLLLLLL if no such
          information is desired.   Parameter  ccccaaaaeeeessssaaaarrrr____bbbblllloooocccckkkk____2222  is



(C) INRIA     Last change: 2020/02/11 (version 1.3)            18






OPEN/CAESAR MANUAL                          caesar_solve_1(LOCAL)



          the index of the equation block where the boolean vari-
          able ccccaaaaeeeessssaaaarrrr____vvvvaaaarrrriiiiaaaabbbblllleeee____2222 is defined.

     Note:  The  memory  area  pointed  to   by   the   parameter
     ccccaaaaeeeessssaaaarrrr____vvvvaaaarrrriiiiaaaabbbblllleeee____1111  contains  a  boolean  variable and should
     neither be modified, nor freed by the procedure ccccaaaaeeeessssaaaarrrr____pppp.

     Note:  The  memory  area  pointed  to   by   the   parameter
     ccccaaaaeeeessssaaaarrrr____vvvvaaaarrrriiiiaaaabbbblllleeee____2222  is  already  allocated  and should not be
     freed by the procedure ccccaaaaeeeessssaaaarrrr____pppp.

     Note: The actual value passed to the parameter  ccccaaaaeeeessssaaaarrrr____llllaaaabbbbeeeellll
     when  the  procedure pointed to by ccccaaaaeeeessssaaaarrrr____lllloooooooopppp is invoked by
     ccccaaaaeeeessssaaaarrrr____pppp is meaningless with respect to  boolean  resolution
     (the  value  passed  to ccccaaaaeeeessssaaaarrrr____llllaaaabbbbeeeellll will only be copied and
     possibly compared to NNNNUUUULLLLLLLL by the resolution algorithms). The
     parameter ccccaaaaeeeessssaaaarrrr____llllaaaabbbbeeeellll allows to attach application-specific
     information to the edges going out of  a  boolean  variable;
     this  information  is  retrieved in the diagnostic generated
     for that variable. For instance, when using the  ``solve_1''
     library  for  model  checking,  ccccaaaaeeeessssaaaarrrr____llllaaaabbbbeeeellll  may  contain a
     pointer to a label of  the  labelled  transition  system  on
     which a temporal logic formula is verified. It is the users'
     responsibility to manage  the  memory  area  pointed  to  by
     ccccaaaaeeeessssaaaarrrr____llllaaaabbbbeeeellll;  in  particular, it is recommended not to free
     this memory area until the resolution of the  boolean  equa-
     tion system is finished.

     The value of CCCCAAAAEEEESSSSAAAARRRR____IIIINNNNFFFFOOOO has no effect on the  execution  of
     procedure  CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTEEEE____SSSSOOOOLLLLVVVVEEEE____1111(((()))). Parameter CCCCAAAAEEEESSSSAAAARRRR____IIIINNNNFFFFOOOO is
     intended to serve for future extensions of  this  procedure;
     when  using  the current version of the ``solve_1'' library,
     it is recommended to set this parameter to NNNNUUUULLLLLLLL.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____CCCCUUUURRRRRRRREEEENNNNTTTT____SSSSYYYYSSSSTTTTEEEEMMMM____SSSSOOOOLLLLVVVVEEEE____1111

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSOOOOLLLLVVVVEEEE____1111 CCCCAAAAEEEESSSSAAAARRRR____CCCCUUUURRRRRRRREEEENNNNTTTT____SSSSYYYYSSSSTTTTEEEEMMMM____SSSSOOOOLLLLVVVVEEEE____1111 (((())))
        {{{{ ............ }}}}

     This function returns a pointer to the boolean equation sys-
     tem which is currently under resolution. It should be called
     only within the functions and  procedures  given  as  actual
     values   for  the  formal  parameters  CCCCAAAAEEEESSSSAAAARRRR____VVVVAAAARRRRIIIIAAAABBBBLLLLEEEE____KKKKIIIINNNNDDDD,
     CCCCAAAAEEEESSSSAAAARRRR____VVVVAAAARRRRIIIIAAAABBBBLLLLEEEE____CCCCOOOOMMMMPPPPAAAARRRREEEE,               CCCCAAAAEEEESSSSAAAARRRR____VVVVAAAARRRRIIIIAAAABBBBLLLLEEEE____HHHHAAAASSSSHHHH,
     CCCCAAAAEEEESSSSAAAARRRR____VVVVAAAARRRRIIIIAAAABBBBLLLLEEEE____PPPPRRRRIIIINNNNTTTT,  and  CCCCAAAAEEEESSSSAAAARRRR____VVVVAAAARRRRIIIIAAAABBBBLLLLEEEE____IIIITTTTEEEERRRRAAAATTTTEEEE of pro-
     cedure CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTEEEE____SSSSOOOOLLLLVVVVEEEE____1111(((()))) (see above);  in  this  case,
     the  result  is  a  pointer  to  the boolean equation system
     created by the  call  to  CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTEEEE____SSSSOOOOLLLLVVVVEEEE____1111(((()))).  If  this
     function is called anywhere else in the application program,



(C) INRIA     Last change: 2020/02/11 (version 1.3)            19






OPEN/CAESAR MANUAL                          caesar_solve_1(LOCAL)



     the result is undefined.

     Note: This  function  allows  to  invoke,  within  the  five
     aforementioned  functions and procedures, various primitives
     of the ``solve_1'' library on the current  boolean  equation
     system (e.g., resolution, printing, etc.).


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____CCCCUUUURRRRRRRREEEENNNNTTTT____BBBBLLLLOOOOCCCCKKKK____SSSSOOOOLLLLVVVVEEEE____1111

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL CCCCAAAAEEEESSSSAAAARRRR____CCCCUUUURRRRRRRREEEENNNNTTTT____BBBBLLLLOOOOCCCCKKKK____SSSSOOOOLLLLVVVVEEEE____1111 (((())))
        {{{{ ............ }}}}

     This function returns the index of the equation block  which
     is  currently  under  resolution; this block is in turn con-
     tained in the boolean equation  system  which  is  currently
     under  resolution,  pointed  to  by  the  result of function
     CCCCAAAAEEEESSSSAAAARRRR____CCCCUUUURRRRRRRREEEENNNNTTTT____SSSSYYYYSSSSTTTTEEEEMMMM____SSSSOOOOLLLLVVVVEEEE____1111(((()))) (see above).  It  should  be
     called  only  within  the  functions and procedures given as
     actual     values     for     the     formal      parameters
     CCCCAAAAEEEESSSSAAAARRRR____VVVVAAAARRRRIIIIAAAABBBBLLLLEEEE____KKKKIIIINNNNDDDD,               CCCCAAAAEEEESSSSAAAARRRR____VVVVAAAARRRRIIIIAAAABBBBLLLLEEEE____CCCCOOOOMMMMPPPPAAAARRRREEEE,
     CCCCAAAAEEEESSSSAAAARRRR____VVVVAAAARRRRIIIIAAAABBBBLLLLEEEE____HHHHAAAASSSSHHHH,       CCCCAAAAEEEESSSSAAAARRRR____VVVVAAAARRRRIIIIAAAABBBBLLLLEEEE____PPPPRRRRIIIINNNNTTTT,       and
     CCCCAAAAEEEESSSSAAAARRRR____VVVVAAAARRRRIIIIAAAABBBBLLLLEEEE____IIIITTTTEEEERRRRAAAATTTTEEEE of procedure CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTEEEE____SSSSOOOOLLLLVVVVEEEE____1111(((())))
     (see above); in this case, the result is the  index  of  the
     block,  i.e.,  a natural number in the range 0..N-1, where N
     is the number of  blocks  in  the  boolean  equation  system
     created  by  the  call  to CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTEEEE____SSSSOOOOLLLLVVVVEEEE____1111(((()))).  If this
     function is called anywhere else in the application program,
     the result is undefined.

     Note: This function allows to identify the  block  in  which
     the  boolean  variable(s)  passed  as  arguments to the five
     aforementioned functions and  procedures  are  defined,  and
     thus to handle these variables accordingly (the size and the
     contents  of  variables  defined  in  different  blocks  may
     differ).  It  is especially useful when the number of blocks
     in the boolean equation system is unknown statically  (e.g.,
     when  using  the ``solve_1'' library for model checking, the
     number of blocks is inferred from a temporal  logic  formula
     read as input).


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____DDDDEEEELLLLEEEETTTTEEEE____SSSSOOOOLLLLVVVVEEEE____1111

     vvvvooooiiiidddd CCCCAAAAEEEESSSSAAAARRRR____DDDDEEEELLLLEEEETTTTEEEE____SSSSOOOOLLLLVVVVEEEE____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____BBBB))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSOOOOLLLLVVVVEEEE____1111 ****CCCCAAAAEEEESSSSAAAARRRR____BBBB;;;;
        {{{{ ............ }}}}




(C) INRIA     Last change: 2020/02/11 (version 1.3)            20






OPEN/CAESAR MANUAL                          caesar_solve_1(LOCAL)



     This procedure frees the memory space corresponding  to  the
     boolean  equation  system  pointed  to  by  ****CCCCAAAAEEEESSSSAAAARRRR____BBBB  using
     CCCCAAAAEEEESSSSAAAARRRR____DDDDEEEELLLLEEEETTTTEEEE(((()))). The boolean variables  stored  in  internal
     tables allocated during previous resolutions (if any) of the
     boolean equation system are also freed. Afterwards, the NNNNUUUULLLLLLLL
     value is assigned to ****CCCCAAAAEEEESSSSAAAARRRR____BBBB.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____PPPPUUUURRRRGGGGEEEE____BBBBLLLLOOOOCCCCKKKK____SSSSOOOOLLLLVVVVEEEE____1111

     vvvvooooiiiidddd CCCCAAAAEEEESSSSAAAARRRR____PPPPUUUURRRRGGGGEEEE____BBBBLLLLOOOOCCCCKKKK____SSSSOOOOLLLLVVVVEEEE____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____BBBB,,,, CCCCAAAAEEEESSSSAAAARRRR____IIII))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSOOOOLLLLVVVVEEEE____1111 CCCCAAAAEEEESSSSAAAARRRR____BBBB;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL CCCCAAAAEEEESSSSAAAARRRR____IIII;;;;
        {{{{ ............ }}}}

     This procedure reinitializes the information  associated  to
     the equation block of index CCCCAAAAEEEESSSSAAAARRRR____IIII of the boolean equation
     system pointed to by CCCCAAAAEEEESSSSAAAARRRR____BBBB.  The internal  table  associ-
     ated  to  the block is emptied using CCCCAAAAEEEESSSSAAAARRRR____PPPPUUUURRRRGGGGEEEE____TTTTAAAABBBBLLLLEEEE____1111(((()))).
     Afterwards, the block is exactly in the same state as  after
     the   creation   of   the   boolean  equation  system  using
     CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTEEEE____SSSSOOOOLLLLVVVVEEEE____1111(((()))).

     If the block index CCCCAAAAEEEESSSSAAAARRRR____IIII  is  outside  the  range  0..N-1
     (where  N is the number of blocks in the system), the result
     is undefined.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____CCCCOOOOMMMMPPPPUUUUTTTTEEEE____SSSSOOOOLLLLVVVVEEEE____1111

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____BBBBOOOOOOOOLLLLEEEEAAAANNNN CCCCAAAAEEEESSSSAAAARRRR____CCCCOOOOMMMMPPPPUUUUTTTTEEEE____SSSSOOOOLLLLVVVVEEEE____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____BBBB,,,, CCCCAAAAEEEESSSSAAAARRRR____IIII,,,, CCCCAAAAEEEESSSSAAAARRRR____VVVV))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSOOOOLLLLVVVVEEEE____1111 CCCCAAAAEEEESSSSAAAARRRR____BBBB;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL CCCCAAAAEEEESSSSAAAARRRR____IIII;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____PPPPOOOOIIIINNNNTTTTEEEERRRR CCCCAAAAEEEESSSSAAAARRRR____VVVV;;;;
        {{{{ ............ }}}}

     This function computes the value  of  the  boolean  variable
     pointed  to  by CCCCAAAAEEEESSSSAAAARRRR____VVVV, which must be defined in the equa-
     tion block of index CCCCAAAAEEEESSSSAAAARRRR____IIII of the boolean equation  system
     pointed  to  by  CCCCAAAAEEEESSSSAAAARRRR____BBBB.  It  also  sets  a  field of type
     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____EEEERRRRRRRROOOORRRR____SSSSOOOOLLLLVVVVEEEE____1111 associated to the block,  indicat-
     ing  whether  the resolution was carried out successfully or
     not;  this  field  can  be  inspected  using  the   function
     CCCCAAAAEEEESSSSAAAARRRR____SSSSTTTTAAAATTTTUUUUSSSS____CCCCOOOOMMMMPPPPUUUUTTTTEEEE____SSSSOOOOLLLLVVVVEEEE____1111(((()))) (see below).

     If the block index CCCCAAAAEEEESSSSAAAARRRR____IIII  is  outside  the  range  0..N-1
     (where  N is the number of blocks in the system), the result
     is undefined.



(C) INRIA     Last change: 2020/02/11 (version 1.3)            21






OPEN/CAESAR MANUAL                          caesar_solve_1(LOCAL)



      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____SSSSTTTTAAAATTTTUUUUSSSS____CCCCOOOOMMMMPPPPUUUUTTTTEEEE____SSSSOOOOLLLLVVVVEEEE____1111

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____EEEERRRRRRRROOOORRRR____SSSSOOOOLLLLVVVVEEEE____1111 CCCCAAAAEEEESSSSAAAARRRR____SSSSTTTTAAAATTTTUUUUSSSS____CCCCOOOOMMMMPPPPUUUUTTTTEEEE____SSSSOOOOLLLLVVVVEEEE____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____BBBB,,,, CCCCAAAAEEEESSSSAAAARRRR____IIII))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSOOOOLLLLVVVVEEEE____1111 CCCCAAAAEEEESSSSAAAARRRR____BBBB;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL CCCCAAAAEEEESSSSAAAARRRR____IIII;;;;
        {{{{ ............ }}}}

     This function returns the status of the last resolution per-
     formed  by  a  call to the function CCCCAAAAEEEESSSSAAAARRRR____CCCCOOOOMMMMPPPPUUUUTTTTEEEE____SSSSOOOOLLLLVVVVEEEE____1111(((())))
     (see above) on a boolean variable defined  in  the  equation
     block  of  index  CCCCAAAAEEEESSSSAAAARRRR____IIII  of  the  boolean equation system
     pointed to by CCCCAAAAEEEESSSSAAAARRRR____BBBB.

     If the block index CCCCAAAAEEEESSSSAAAARRRR____IIII  is  outside  the  range  0..N-1
     (where  N is the number of blocks in the system), the result
     is undefined.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____IIIITTTTEEEERRRRAAAATTTTEEEE____SSSSTTTTAAAABBBBLLLLEEEE____VVVVAAAARRRRIIIIAAAABBBBLLLLEEEE____SSSSOOOOLLLLVVVVEEEE____1111

     vvvvooooiiiidddd CCCCAAAAEEEESSSSAAAARRRR____IIIITTTTEEEERRRRAAAATTTTEEEE____SSSSTTTTAAAABBBBLLLLEEEE____VVVVAAAARRRRIIIIAAAABBBBLLLLEEEE____SSSSOOOOLLLLVVVVEEEE____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____BBBB,,,, CCCCAAAAEEEESSSSAAAARRRR____IIII,,,, CCCCAAAAEEEESSSSAAAARRRR____VVVV,,,,
                                                  CCCCAAAAEEEESSSSAAAARRRR____VVVVAAAALLLLUUUUEEEE,,,, CCCCAAAAEEEESSSSAAAARRRR____LLLLOOOOOOOOPPPP))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSOOOOLLLLVVVVEEEE____1111 CCCCAAAAEEEESSSSAAAARRRR____BBBB;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL CCCCAAAAEEEESSSSAAAARRRR____IIII;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____PPPPOOOOIIIINNNNTTTTEEEERRRR CCCCAAAAEEEESSSSAAAARRRR____VVVV;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____BBBBOOOOOOOOLLLLEEEEAAAANNNN ****CCCCAAAAEEEESSSSAAAARRRR____VVVVAAAALLLLUUUUEEEE;;;;
        vvvvooooiiiidddd ((((****CCCCAAAAEEEESSSSAAAARRRR____LLLLOOOOOOOOPPPP)))) ((((CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSOOOOLLLLVVVVEEEE____1111,,,, CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL,,,,
           CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____PPPPOOOOIIIINNNNTTTTEEEERRRR,,,, CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____BBBBOOOOOOOOLLLLEEEEAAAANNNN ****))));;;;
        {{{{ ............ }}}}

     This procedure provides an  iterator  which  enumerates  the
     boolean  variables  defined  in  the equation block of index
     CCCCAAAAEEEESSSSAAAARRRR____IIII of  the  boolean  equation  system  pointed  to  by
     CCCCAAAAEEEESSSSAAAARRRR____BBBB which are stable, i.e., whose value was computed by
     calls to the function CCCCAAAAEEEESSSSAAAARRRR____CCCCOOOOMMMMPPPPUUUUTTTTEEEE____SSSSOOOOLLLLVVVVEEEE____1111(((()))) (see  above).
     Only the variables computed since the last call of this pro-
     cedure (or, in the case of the first call of this procedure,
     since the creation of the boolean equation system pointed to
     by   CCCCAAAAEEEESSSSAAAARRRR____BBBB)   are   enumerated.   At   each    iteration,
     ****CCCCAAAAEEEESSSSAAAARRRR____VVVVAAAALLLLUUUUEEEE   and  the  boolean  variable  pointed  to  by
     CCCCAAAAEEEESSSSAAAARRRR____VVVV are assigned a new value,  such  that  CCCCAAAAEEEESSSSAAAARRRR____VVVV  is
     defined  in the block of index CCCCAAAAEEEESSSSAAAARRRR____IIII of the boolean equa-
     tion system pointed to by CCCCAAAAEEEESSSSAAAARRRR____BBBB and  the  value  computed
     for  CCCCAAAAEEEESSSSAAAARRRR____VVVV  is equal to ****CCCCAAAAEEEESSSSAAAARRRR____VVVVAAAALLLLUUUUEEEE. At each iteration,
     the procedure pointed to by CCCCAAAAEEEESSSSAAAARRRR____LLLLOOOOOOOOPPPP is invoked, with the
     following parameters:

     ((((****CCCCAAAAEEEESSSSAAAARRRR____LLLLOOOOOOOOPPPP)))) ((((CCCCAAAAEEEESSSSAAAARRRR____BBBB,,,, CCCCAAAAEEEESSSSAAAARRRR____IIII,,,, CCCCAAAAEEEESSSSAAAARRRR____VVVV,,,, CCCCAAAAEEEESSSSAAAARRRR____VVVVAAAALLLLUUUUEEEE))))



(C) INRIA     Last change: 2020/02/11 (version 1.3)            22






OPEN/CAESAR MANUAL                          caesar_solve_1(LOCAL)




     Therefore, any actual  parameter  supplied  for  the  formal
     parameter  CCCCAAAAEEEESSSSAAAARRRR____LLLLOOOOOOOOPPPP  must  be  a  pointer  to a procedure
     ccccaaaaeeeessssaaaarrrr____pppp whose declaration has the following form:

             vvvvooooiiiidddd ccccaaaaeeeessssaaaarrrr____pppp ((((ccccaaaaeeeessssaaaarrrr____bbbbeeeessss,,,, ccccaaaaeeeessssaaaarrrr____bbbblllloooocccckkkk,,,, ccccaaaaeeeessssaaaarrrr____vvvvaaaarrrriiiiaaaabbbblllleeee,,,, ccccaaaaeeeessssaaaarrrr____vvvvaaaalllluuuueeee))))
                CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSOOOOLLLLVVVVEEEE____1111 ccccaaaaeeeessssaaaarrrr____bbbbeeeessss;;;;
                CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL ccccaaaaeeeessssaaaarrrr____bbbblllloooocccckkkk;;;;
                CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____PPPPOOOOIIIINNNNTTTTEEEERRRR ccccaaaaeeeessssaaaarrrr____vvvvaaaarrrriiiiaaaabbbblllleeee;;;;
                CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____BBBBOOOOOOOOLLLLEEEEAAAANNNN ****ccccaaaaeeeessssaaaarrrr____vvvvaaaalllluuuueeee;;;;
                {{{{ ............ }}}}

     Note: Parameters CCCCAAAAEEEESSSSAAAARRRR____VVVV and  CCCCAAAAEEEESSSSAAAARRRR____VVVVAAAALLLLUUUUEEEE  must  point  to
     (distinct)   memory  locations  allocated  before  procedure
     CCCCAAAAEEEESSSSAAAARRRR____IIIITTTTEEEERRRRAAAATTTTEEEE____SSSSTTTTAAAABBBBLLLLEEEE____VVVVAAAARRRRIIIIAAAABBBBLLLLEEEE____SSSSOOOOLLLLVVVVEEEE____1111(((()))) is invoked.  In  no
     event   will   CCCCAAAAEEEESSSSAAAARRRR____IIIITTTTEEEERRRRAAAATTTTEEEE____SSSSTTTTAAAABBBBLLLLEEEE____VVVVAAAARRRRIIIIAAAABBBBLLLLEEEE____SSSSOOOOLLLLVVVVEEEE____1111(((())))  and
     CCCCAAAAEEEESSSSAAAARRRR____LLLLOOOOOOOOPPPP(((())))  allocate  memory  for  storing  CCCCAAAAEEEESSSSAAAARRRR____VVVV  and
     CCCCAAAAEEEESSSSAAAARRRR____VVVVAAAALLLLUUUUEEEE.

     Note: More often than not, this procedure  will  have  side-
     effects.  For  instance, this procedure may count the number
     of stable variables, store them in a list, a table, ...

     Note: It is probably a good programming style  to  keep  the
     body of this procedure as short as possible.

     Note:        The        code         that         implements
     CCCCAAAAEEEESSSSAAAARRRR____IIIITTTTEEEERRRRAAAATTTTEEEE____SSSSTTTTAAAABBBBLLLLEEEE____VVVVAAAARRRRIIIIAAAABBBBLLLLEEEE____SSSSOOOOLLLLVVVVEEEE____1111(((()))) in the current ver-
     sion of the ``solve_1'' library is  not  reentrant,  meaning
     that  nested iterations will not work properly. This implies
     that any actual procedure ccccaaaaeeeessssaaaarrrr____pppp passed as value for  for-
     mal parameter CCCCAAAAEEEESSSSAAAARRRR____LLLLOOOOOOOOPPPP must not call (directly, nor tran-
     sitively) CCCCAAAAEEEESSSSAAAARRRR____IIIITTTTEEEERRRRAAAATTTTEEEE____SSSSTTTTAAAABBBBLLLLEEEE____VVVVAAAARRRRIIIIAAAABBBBLLLLEEEE____SSSSOOOOLLLLVVVVEEEE____1111(((()))).

     Note: When invoked to solve  a  variable  of  interest,  the
     function   CCCCAAAAEEEESSSSAAAARRRR____CCCCOOOOMMMMPPPPUUUUTTTTEEEE____SSSSOOOOLLLLVVVVEEEE____1111(((())))   usually  explores  and
     solves other variables upon which the variable  of  interest
     depends.  This  implies that the set of variables enumerated
     by a  call  to  CCCCAAAAEEEESSSSAAAARRRR____IIIITTTTEEEERRRRAAAATTTTEEEE____SSSSTTTTAAAABBBBLLLLEEEE____VVVVAAAARRRRIIIIAAAABBBBLLLLEEEE____SSSSOOOOLLLLVVVVEEEE____1111(((())))  is
     usually  larger  than  the  set  of variables defined in the
     block of index CCCCAAAAEEEESSSSAAAARRRR____IIII of the system pointed to by CCCCAAAAEEEESSSSAAAARRRR____BBBB
     on which CCCCAAAAEEEESSSSAAAARRRR____CCCCOOOOMMMMPPPPUUUUTTTTEEEE____SSSSOOOOLLLLVVVVEEEE____1111(((()))) was invoked since the last
     call of CCCCAAAAEEEESSSSAAAARRRR____IIIITTTTEEEERRRRAAAATTTTEEEE____SSSSTTTTAAAABBBBLLLLEEEE____VVVVAAAARRRRIIIIAAAABBBBLLLLEEEE____SSSSOOOOLLLLVVVVEEEE____1111(((()))).

     If the block index CCCCAAAAEEEESSSSAAAARRRR____IIII  is  outside  the  range  0..N-1
     (where  N is the number of blocks in the system), the effect
     is undefined.


      ............................................................





(C) INRIA     Last change: 2020/02/11 (version 1.3)            23






OPEN/CAESAR MANUAL                          caesar_solve_1(LOCAL)



  CCCCAAAAEEEESSSSAAAARRRR____SSSSTTTTAAAARRRRTTTT____DDDDIIIIAAAAGGGGNNNNOOOOSSSSTTTTIIIICCCC____SSSSOOOOLLLLVVVVEEEE____1111

     vvvvooooiiiidddd CCCCAAAAEEEESSSSAAAARRRR____SSSSTTTTAAAARRRRTTTT____DDDDIIIIAAAAGGGGNNNNOOOOSSSSTTTTIIIICCCC____SSSSOOOOLLLLVVVVEEEE____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____BBBB,,,, CCCCAAAAEEEESSSSAAAARRRR____IIII,,,, CCCCAAAAEEEESSSSAAAARRRR____VVVV,,,,
                                           CCCCAAAAEEEESSSSAAAARRRR____MMMMIIIINNNNIIIIMMMMAAAALLLL,,,, CCCCAAAAEEEESSSSAAAARRRR____PPPP))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSOOOOLLLLVVVVEEEE____1111 CCCCAAAAEEEESSSSAAAARRRR____BBBB;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL CCCCAAAAEEEESSSSAAAARRRR____IIII;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____PPPPOOOOIIIINNNNTTTTEEEERRRR CCCCAAAAEEEESSSSAAAARRRR____VVVV;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____BBBBOOOOOOOOLLLLEEEEAAAANNNN CCCCAAAAEEEESSSSAAAARRRR____MMMMIIIINNNNIIIIMMMMAAAALLLL;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____PPPPOOOOIIIINNNNTTTTEEEERRRR ****CCCCAAAAEEEESSSSAAAARRRR____PPPP;;;;
        {{{{ ............ }}}}

     This procedure initializes the diagnostic generation for the
     boolean  variable  pointed  to  by  CCCCAAAAEEEESSSSAAAARRRR____VVVV,  which must be
     defined in the equation  block  of  index  CCCCAAAAEEEESSSSAAAARRRR____IIII  of  the
     boolean  equation  system pointed to by CCCCAAAAEEEESSSSAAAARRRR____BBBB. It must be
     called before starting to explore  the  diagnostic  for  the
     boolean       variable       using       the       procedure
     CCCCAAAAEEEESSSSAAAARRRR____IIIITTTTEEEERRRRAAAATTTTEEEE____DDDDIIIIAAAAGGGGNNNNOOOOSSSSTTTTIIIICCCC____SSSSOOOOLLLLVVVVEEEE____1111(((()))) (see below).

     Diagnostic information is computed by  the  resolution  rou-
     tines  and  kept  in  the  internal tables associated to the
     blocks. Therefore, diagnostics can  be  generated  only  for
     boolean  variables  that  were  already  solved  by calls to
     CCCCAAAAEEEESSSSAAAARRRR____CCCCOOOOMMMMPPPPUUUUTTTTEEEE____SSSSOOOOLLLLVVVVEEEE____1111(((()))) (see above). If the  boolean  vari-
     able  pointed  to  by  CCCCAAAAEEEESSSSAAAARRRR____VVVV  was  previously solved, the
     address of this boolean variable, which was  stored  in  the
     internal table associated to the block of index CCCCAAAAEEEESSSSAAAARRRR____IIII, is
     assigned to ****CCCCAAAAEEEESSSSAAAARRRR____PPPP. If the boolean variable pointed to by
     CCCCAAAAEEEESSSSAAAARRRR____VVVV  was  not  previously solved or a memory allocation
     failed during diagnostic recomputation (see below), the NNNNUUUULLLLLLLL
     value is assigned to ****CCCCAAAAEEEESSSSAAAARRRR____PPPP.

     Note: The memory area pointed to by ****CCCCAAAAEEEESSSSAAAARRRR____PPPP  must  neither
     be modified, nor freed by the application program.

     The value of CCCCAAAAEEEESSSSAAAARRRR____MMMMIIIINNNNIIIIMMMMAAAALLLL  influences  the  depth  of  the
     diagnostic (i.e., the length of the longest sequence without
     repeated vertices contained in the diagnostic) that will  be
     generated  for  the boolean variable pointed to by CCCCAAAAEEEESSSSAAAARRRR____VVVV.
     If the value of  CCCCAAAAEEEESSSSAAAARRRR____MMMMIIIINNNNIIIIMMMMAAAALLLL  is  CCCCAAAAEEEESSSSAAAARRRR____TTTTRRRRUUUUEEEE,  then  the
     diagnostic  of  the  boolean  variable will be recomputed in
     order to reduce its depth. If the value of CCCCAAAAEEEESSSSAAAARRRR____MMMMIIIINNNNIIIIMMMMAAAALLLL is
     CCCCAAAAEEEESSSSAAAARRRR____FFFFAAAALLLLSSSSEEEE, the diagnostic of the boolean variable will be
     left unchanged, i.e., as it was computed when  the  variable
     was solved.

     Note: Setting the value  of  CCCCAAAAEEEESSSSAAAARRRR____MMMMIIIINNNNIIIIMMMMAAAALLLL  to  CCCCAAAAEEEESSSSAAAARRRR____TTTTRRRRUUUUEEEE
     usually  increases diagnostic generation time, especially if
     the variable pointed to by CCCCAAAAEEEESSSSAAAARRRR____VVVV was solved using a reso-
     lution  mode based on depth-first search, such as resolution
     modes   0,   2,   3,    and    4    (see    the    procedure
     CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTEEEE____SSSSOOOOLLLLVVVVEEEE____1111(((()))) above).



(C) INRIA     Last change: 2020/02/11 (version 1.3)            24






OPEN/CAESAR MANUAL                          caesar_solve_1(LOCAL)



     If the block index CCCCAAAAEEEESSSSAAAARRRR____IIII  is  outside  the  range  0..N-1
     (where  N is the number of blocks in the system), the effect
     is undefined.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____IIIITTTTEEEERRRRAAAATTTTEEEE____DDDDIIIIAAAAGGGGNNNNOOOOSSSSTTTTIIIICCCC____SSSSOOOOLLLLVVVVEEEE____1111

     vvvvooooiiiidddd CCCCAAAAEEEESSSSAAAARRRR____IIIITTTTEEEERRRRAAAATTTTEEEE____DDDDIIIIAAAAGGGGNNNNOOOOSSSSTTTTIIIICCCC____SSSSOOOOLLLLVVVVEEEE____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____BBBB,,,, CCCCAAAAEEEESSSSAAAARRRR____IIII1111,,,, CCCCAAAAEEEESSSSAAAARRRR____VVVV1111,,,,
                                             CCCCAAAAEEEESSSSAAAARRRR____LLLL,,,, CCCCAAAAEEEESSSSAAAARRRR____IIII2222,,,, CCCCAAAAEEEESSSSAAAARRRR____VVVV2222,,,,
                                             CCCCAAAAEEEESSSSAAAARRRR____LLLLOOOOOOOOPPPP))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSOOOOLLLLVVVVEEEE____1111 CCCCAAAAEEEESSSSAAAARRRR____BBBB;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL CCCCAAAAEEEESSSSAAAARRRR____IIII1111;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____PPPPOOOOIIIINNNNTTTTEEEERRRR CCCCAAAAEEEESSSSAAAARRRR____VVVV1111;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____PPPPOOOOIIIINNNNTTTTEEEERRRR ****CCCCAAAAEEEESSSSAAAARRRR____LLLL;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL ****CCCCAAAAEEEESSSSAAAARRRR____IIII2222;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____PPPPOOOOIIIINNNNTTTTEEEERRRR ****CCCCAAAAEEEESSSSAAAARRRR____VVVV2222;;;;
        vvvvooooiiiidddd ((((****CCCCAAAAEEEESSSSAAAARRRR____LLLLOOOOOOOOPPPP)))) ((((CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSOOOOLLLLVVVVEEEE____1111,,,, CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL,,,,
           CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____PPPPOOOOIIIINNNNTTTTEEEERRRR,,,, CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____PPPPOOOOIIIINNNNTTTTEEEERRRR ****,,,,
           CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL ****,,,, CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____PPPPOOOOIIIINNNNTTTTEEEERRRR ****))));;;;
        {{{{ ............ }}}}

     This procedure provides an  iterator  which  enumerates  the
     successors  of  the boolean variable pointed to by CCCCAAAAEEEESSSSAAAARRRR____VVVV1111
     that are contained in the diagnostic of this  variable.  The
     variable  pointed  to  by  CCCCAAAAEEEESSSSAAAARRRR____VVVV1111  must be defined in the
     equation block of index CCCCAAAAEEEESSSSAAAARRRR____IIII1111 of  the  boolean  equation
     system pointed to by CCCCAAAAEEEESSSSAAAARRRR____BBBB. At each iteration, ****CCCCAAAAEEEESSSSAAAARRRR____IIII2222
     and ****CCCCAAAAEEEESSSSAAAARRRR____VVVV2222 are respectively assigned a block index and a
     pointer  to  a  boolean  variable  such  that  ``(CCCCAAAAEEEESSSSAAAARRRR____VVVV1111,
     ****CCCCAAAAEEEESSSSAAAARRRR____VVVV2222)'' is an edge of the diagnostic computed for  the
     boolean  variable pointed to by CCCCAAAAEEEESSSSAAAARRRR____VVVV1111. The boolean vari-
     able pointed to by ****CCCCAAAAEEEESSSSAAAARRRR____VVVV2222 is  defined  in  the  equation
     block  of  index  ****CCCCAAAAEEEESSSSAAAARRRR____IIII2222  and  is stored in the internal
     table associated to that block. Also, ****CCCCAAAAEEEESSSSAAAARRRR____LLLL is  assigned
     the   information   attached   to   the  edge  ``(CCCCAAAAEEEESSSSAAAARRRR____VVVV1111,
     ****CCCCAAAAEEEESSSSAAAARRRR____VVVV2222)'' by the procedure  pointed  to  by  ccccaaaaeeeessssaaaarrrr____lllloooooooopppp
     invoked  by  the  iterator procedure ccccaaaaeeeessssaaaarrrr____pppp given as value
     for  formal  parameter  CCCCAAAAEEEESSSSAAAARRRR____VVVVAAAARRRRIIIIAAAABBBBLLLLEEEE____IIIITTTTEEEERRRRAAAATTTTEEEE   when   the
     boolean  equation  system pointed to by CCCCAAAAEEEESSSSAAAARRRR____BBBB was created
     (see procedure CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTEEEE____SSSSOOOOLLLLVVVVEEEE____1111(((()))) above).

     Note: Parameter CCCCAAAAEEEESSSSAAAARRRR____VVVV1111 must  contain  the  address  of  a
     boolean  variable already stored in the internal table asso-
     ciated to  the  equation  block  of  index  CCCCAAAAEEEESSSSAAAARRRR____IIII1111.  Such
     addresses  of  boolean  variables  are  obtained  as  values
     assigned    to    the    ****CCCCAAAAEEEESSSSAAAARRRR____PPPP    parameter    of    the
     CCCCAAAAEEEESSSSAAAARRRR____SSSSTTTTAAAARRRRTTTT____DDDDIIIIAAAAGGGGNNNNOOOOSSSSTTTTIIIICCCC____SSSSOOOOLLLLVVVVEEEE____1111(((())))  procedure  (see above) or
     to      the      ****CCCCAAAAEEEESSSSAAAARRRR____VVVV2222      parameter      of       the
     CCCCAAAAEEEESSSSAAAARRRR____IIIITTTTEEEERRRRAAAATTTTEEEE____DDDDIIIIAAAAGGGGNNNNOOOOSSSSTTTTIIIICCCC____SSSSOOOOLLLLVVVVEEEE____1111(((())))  procedure. If parameter
     CCCCAAAAEEEESSSSAAAARRRR____VVVV1111 does  not  meet  this  condition,  the  effect  is



(C) INRIA     Last change: 2020/02/11 (version 1.3)            25






OPEN/CAESAR MANUAL                          caesar_solve_1(LOCAL)



     undefined.

     Note: The memory area pointed to by ****CCCCAAAAEEEESSSSAAAARRRR____VVVV2222  should  nei-
     ther be modified, nor freed by the application program.

     Note: The memory area pointed to by  ****CCCCAAAAEEEESSSSAAAARRRR____LLLL  is  entirely
     managed  by  the  application  program. The resolution algo-
     rithms manipulate the address of this memory  area  only  by
     copying  it  and  possibly by comparing it to NNNNUUUULLLLLLLL (see also
     procedure CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTEEEE____SSSSOOOOLLLLVVVVEEEE____1111(((()))) above).

     At each iteration, the procedure pointed to  by  CCCCAAAAEEEESSSSAAAARRRR____LLLLOOOOOOOOPPPP
     is invoked, with the following parameters:

             ((((****CCCCAAAAEEEESSSSAAAARRRR____LLLLOOOOOOOOPPPP)))) ((((CCCCAAAAEEEESSSSAAAARRRR____BBBB,,,, CCCCAAAAEEEESSSSAAAARRRR____IIII1111,,,, CCCCAAAAEEEESSSSAAAARRRR____VVVV1111,,,,
                             CCCCAAAAEEEESSSSAAAARRRR____LLLL,,,, CCCCAAAAEEEESSSSAAAARRRR____IIII2222,,,, CCCCAAAAEEEESSSSAAAARRRR____VVVV2222))))

     Therefore, any actual  parameter  supplied  for  the  formal
     parameter  CCCCAAAAEEEESSSSAAAARRRR____LLLLOOOOOOOOPPPP  must  be  a  pointer  to a procedure
     ccccaaaaeeeessssaaaarrrr____pppp whose declaration has the following form:

             vvvvooooiiiidddd ccccaaaaeeeessssaaaarrrr____pppp ((((ccccaaaaeeeessssaaaarrrr____bbbbeeeessss,,,, ccccaaaaeeeessssaaaarrrr____bbbblllloooocccckkkk____1111,,,, ccccaaaaeeeessssaaaarrrr____vvvvaaaarrrriiiiaaaabbbblllleeee____1111,,,,
                            ccccaaaaeeeessssaaaarrrr____llllaaaabbbbeeeellll,,,, ccccaaaaeeeessssaaaarrrr____bbbblllloooocccckkkk____2222,,,, ccccaaaaeeeessssaaaarrrr____vvvvaaaarrrriiiiaaaabbbblllleeee____2222))))
                CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSOOOOLLLLVVVVEEEE____1111 ccccaaaaeeeessssaaaarrrr____bbbbeeeessss;;;;
                CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL ccccaaaaeeeessssaaaarrrr____bbbblllloooocccckkkk____1111;;;;
                CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____PPPPOOOOIIIINNNNTTTTEEEERRRR ccccaaaaeeeessssaaaarrrr____vvvvaaaarrrriiiiaaaabbbblllleeee____1111;;;;
                CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____PPPPOOOOIIIINNNNTTTTEEEERRRR ****ccccaaaaeeeessssaaaarrrr____llllaaaabbbbeeeellll;;;;
                CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL ****ccccaaaaeeeessssaaaarrrr____bbbblllloooocccckkkk____2222;;;;
                CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____PPPPOOOOIIIINNNNTTTTEEEERRRR ****ccccaaaaeeeessssaaaarrrr____vvvvaaaarrrriiiiaaaabbbblllleeee____2222;;;;
                {{{{ ............ }}}}

     Note: Parameters CCCCAAAAEEEESSSSAAAARRRR____IIII2222 and CCCCAAAAEEEESSSSAAAARRRR____VVVV2222 must point to (dis-
     tinct)   memory   locations   allocated   before   procedure
     CCCCAAAAEEEESSSSAAAARRRR____IIIITTTTEEEERRRRAAAATTTTEEEE____DDDDIIIIAAAAGGGGNNNNOOOOSSSSTTTTIIIICCCC____SSSSOOOOLLLLVVVVEEEE____1111(((()))) is invoked. In no  event
     will  CCCCAAAAEEEESSSSAAAARRRR____IIIITTTTEEEERRRRAAAATTTTEEEE____DDDDIIIIAAAAGGGGNNNNOOOOSSSSTTTTIIIICCCC____SSSSOOOOLLLLVVVVEEEE____1111(((())))  and CCCCAAAAEEEESSSSAAAARRRR____LLLLOOOOOOOOPPPP(((())))
     allocate memory for storing CCCCAAAAEEEESSSSAAAARRRR____IIII2222 and CCCCAAAAEEEESSSSAAAARRRR____VVVV2222.

     Note: More often than not, this procedure  will  have  side-
     effects.  For  instance, this procedure may count the number
     of successors, store them in a list, a table, ...

     Note: It is probably a good programming style  to  keep  the
     body of this procedure as short as possible.

     Note:        The        code         that         implements
     CCCCAAAAEEEESSSSAAAARRRR____IIIITTTTEEEERRRRAAAATTTTEEEE____DDDDIIIIAAAAGGGGNNNNOOOOSSSSTTTTIIIICCCC____SSSSOOOOLLLLVVVVEEEE____1111(((())))  in  the current version
     of the ``solve_1'' library is not  reentrant,  meaning  that
     nested  iterations will not work properly. This implies that
     any actual procedure ccccaaaaeeeessssaaaarrrr____pppp passed  as  value  for  formal
     parameter  CCCCAAAAEEEESSSSAAAARRRR____LLLLOOOOOOOOPPPP  must not call (directly, nor transi-
     tively) CCCCAAAAEEEESSSSAAAARRRR____IIIITTTTEEEERRRRAAAATTTTEEEE____DDDDIIIIAAAAGGGGNNNNOOOOSSSSTTTTIIIICCCC____SSSSOOOOLLLLVVVVEEEE____1111(((()))).




(C) INRIA     Last change: 2020/02/11 (version 1.3)            26






OPEN/CAESAR MANUAL                          caesar_solve_1(LOCAL)



     Additionally, this procedure sets two fields ccccaaaaeeeessssaaaarrrr____ccccrrrreeeeaaaattttiiiioooonnnn
     and ccccaaaaeeeessssaaaarrrr____ttttrrrruuuunnnnccccaaaattttiiiioooonnnn of type CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL associated
     to the equation block of index CCCCAAAAEEEESSSSAAAARRRR____IIII1111. After any call  to
     CCCCAAAAEEEESSSSAAAARRRR____IIIITTTTEEEERRRRAAAATTTTEEEE____DDDDIIIIAAAAGGGGNNNNOOOOSSSSTTTTIIIICCCC____SSSSOOOOLLLLVVVVEEEE____1111(((()))),  these  fields  can  be
     inspected       using        the        two        functions
     CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTIIIIOOOONNNN____DDDDIIIIAAAAGGGGNNNNOOOOSSSSTTTTIIIICCCC____SSSSOOOOLLLLVVVVEEEE____1111(((())))                     and
     CCCCAAAAEEEESSSSAAAARRRR____TTTTRRRRUUUUNNNNCCCCAAAATTTTIIIIOOOONNNN____DDDDIIIIAAAAGGGGNNNNOOOOSSSSTTTTIIIICCCC____SSSSOOOOLLLLVVVVEEEE____1111(((())))  (see   below).   The
     values of these fields are set as follows:

     -    If   the   computation    normally    succeeds,    then
          ccccaaaaeeeessssaaaarrrr____ccccrrrreeeeaaaattttiiiioooonnnn  is  set to the number of successors of
          the variable pointed to by CCCCAAAAEEEESSSSAAAARRRR____VVVV1111 that are contained
          in    the    diagnostic    of    this    variable   and
          ccccaaaaeeeessssaaaarrrr____ttttrrrruuuunnnnccccaaaattttiiiioooonnnn is set to zero.

     -    If allocation fails  when  enumerating  the  successors
          (due to a lack of memory), only a subset of the succes-
          sors is enumerated. Then ccccaaaaeeeessssaaaarrrr____ccccrrrreeeeaaaattttiiiioooonnnn is set to  the
          number  of  successors enumerated and ccccaaaaeeeessssaaaarrrr____ttttrrrruuuunnnnccccaaaattttiiiioooonnnn
          is set to the number of successors that have  not  been
          enumerated (this number is greater than zero).

     If the block index CCCCAAAAEEEESSSSAAAARRRR____IIII1111 is  outside  the  range  0..N-1
     (where  N is the number of blocks in the system), the effect
     is undefined.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTIIIIOOOONNNN____DDDDIIIIAAAAGGGGNNNNOOOOSSSSTTTTIIIICCCC____SSSSOOOOLLLLVVVVEEEE____1111

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTIIIIOOOONNNN____DDDDIIIIAAAAGGGGNNNNOOOOSSSSTTTTIIIICCCC____SSSSOOOOLLLLVVVVEEEE____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____BBBB,,,, CCCCAAAAEEEESSSSAAAARRRR____IIII))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSOOOOLLLLVVVVEEEE____1111 CCCCAAAAEEEESSSSAAAARRRR____BBBB;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL CCCCAAAAEEEESSSSAAAARRRR____IIII;;;;
        {{{{ ............ }}}}

     This function returns the value of the field ccccaaaaeeeessssaaaarrrr____ccccrrrreeeeaaaattttiiiioooonnnn
     associated  to  the  equation block of index CCCCAAAAEEEESSSSAAAARRRR____IIII of the
     boolean equation system pointed to  by  CCCCAAAAEEEESSSSAAAARRRR____BBBB,  that  was
     computed       during       the       last      call      to
     CCCCAAAAEEEESSSSAAAARRRR____IIIITTTTEEEERRRRAAAATTTTEEEE____DDDDIIIIAAAAGGGGNNNNOOOOSSSSTTTTIIIICCCC____SSSSOOOOLLLLVVVVEEEE____1111(((()))) (see above). This  field
     can only be inspected using this function.

     If the block index CCCCAAAAEEEESSSSAAAARRRR____IIII  is  outside  the  range  0..N-1
     (where  N is the number of blocks in the system), the effect
     is undefined.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____TTTTRRRRUUUUNNNNCCCCAAAATTTTIIIIOOOONNNN____DDDDIIIIAAAAGGGGNNNNOOOOSSSSTTTTIIIICCCC____SSSSOOOOLLLLVVVVEEEE____1111




(C) INRIA     Last change: 2020/02/11 (version 1.3)            27






OPEN/CAESAR MANUAL                          caesar_solve_1(LOCAL)



     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL CCCCAAAAEEEESSSSAAAARRRR____TTTTRRRRUUUUNNNNCCCCAAAATTTTIIIIOOOONNNN____DDDDIIIIAAAAGGGGNNNNOOOOSSSSTTTTIIIICCCC____SSSSOOOOLLLLVVVVEEEE____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____BBBB,,,, CCCCAAAAEEEESSSSAAAARRRR____IIII))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSOOOOLLLLVVVVEEEE____1111 CCCCAAAAEEEESSSSAAAARRRR____BBBB;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL CCCCAAAAEEEESSSSAAAARRRR____IIII;;;;
        {{{{ ............ }}}}

     This   function   returns   the   value   of    the    field
     ccccaaaaeeeessssaaaarrrr____ttttrrrruuuunnnnccccaaaattttiiiioooonnnn  associated to the equation block of index
     CCCCAAAAEEEESSSSAAAARRRR____IIII of  the  boolean  equation  system  pointed  to  by
     CCCCAAAAEEEESSSSAAAARRRR____BBBB,   that  was  computed  during  the  last  call  to
     CCCCAAAAEEEESSSSAAAARRRR____IIIITTTTEEEERRRRAAAATTTTEEEE____DDDDIIIIAAAAGGGGNNNNOOOOSSSSTTTTIIIICCCC____SSSSOOOOLLLLVVVVEEEE____1111(((()))) (see above). This  field
     can only be inspected using this function.

     If the block index CCCCAAAAEEEESSSSAAAARRRR____IIII  is  outside  the  range  0..N-1
     (where  N is the number of blocks in the system), the effect
     is undefined.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____RRRREEEEAAAADDDD____SSSSOOOOLLLLVVVVEEEE____1111

     vvvvooooiiiidddd CCCCAAAAEEEESSSSAAAARRRR____RRRREEEEAAAADDDD____SSSSOOOOLLLLVVVVEEEE____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____BBBB,,,, CCCCAAAAEEEESSSSAAAARRRR____FFFFIIIILLLLEEEE,,,,
                               CCCCAAAAEEEESSSSAAAARRRR____BBBBLLLLOOOOCCCCKKKK____UUUUNNNNIIIIQQQQUUUUEEEE____RRRREEEESSSSOOOOLLLLUUUUTTTTIIIIOOOONNNN,,,,
                               CCCCAAAAEEEESSSSAAAARRRR____BBBBLLLLOOOOCCCCKKKK____SSSSOOOOLLLLVVVVEEEE____MMMMOOOODDDDEEEE))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSOOOOLLLLVVVVEEEE____1111 ****CCCCAAAAEEEESSSSAAAARRRR____BBBB;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____FFFFIIIILLLLEEEE CCCCAAAAEEEESSSSAAAARRRR____FFFFIIIILLLLEEEE;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____BBBBOOOOOOOOLLLLEEEEAAAANNNN____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN____SSSSOOOOLLLLVVVVEEEE____1111 CCCCAAAAEEEESSSSAAAARRRR____BBBBLLLLOOOOCCCCKKKK____UUUUNNNNIIIIQQQQUUUUEEEE____RRRREEEESSSSOOOOLLLLUUUUTTTTIIIIOOOONNNN;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN____SSSSOOOOLLLLVVVVEEEE____1111 CCCCAAAAEEEESSSSAAAARRRR____BBBBLLLLOOOOCCCCKKKK____SSSSOOOOLLLLVVVVEEEE____MMMMOOOODDDDEEEE;;;;
        {{{{ ............ }}}}

     This procedure allocates a  boolean  equation  system  using
     CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTEEEE____SSSSOOOOLLLLVVVVEEEE____1111(((())))   and   assigns   its   address   to
     ****CCCCAAAAEEEESSSSAAAARRRR____BBBB. If  the  allocation  fails,  the  NNNNUUUULLLLLLLL  value  is
     assigned to ****CCCCAAAAEEEESSSSAAAARRRR____BBBB.

     The value of CCCCAAAAEEEESSSSAAAARRRR____FFFFIIIILLLLEEEE determines the file from which  the
     boolean  equation  system (represented in textual form) will
     be read. Before this procedure is called,  CCCCAAAAEEEESSSSAAAARRRR____FFFFIIIILLLLEEEE  must
     have been properly opened, for instance using ffffooooppppeeeennnn((((3333)))).

     The boolean equation system file is parsed: its contents  is
     analyzed   and  stored  into  the  boolean  equation  system
     ****CCCCAAAAEEEESSSSAAAARRRR____BBBB.

     So doing, various error conditions may occur: CCCCAAAAEEEESSSSAAAARRRR____FFFFIIIILLLLEEEE is
     empty  or has syntax errors; it has semantic errors (such as
     block or variable indexes out of range), etc. In such  case,
     a   detailed   error   message   is   displayed   using  the
     CCCCAAAAEEEESSSSAAAARRRR____WWWWAAAARRRRNNNNIIIINNNNGGGG(((()))) procedure, and the NNNNUUUULLLLLLLL value  is  assigned
     to ****CCCCAAAAEEEESSSSAAAARRRR____BBBB.

     The actual values of the  two  remaining  formal  parameters



(C) INRIA     Last change: 2020/02/11 (version 1.3)            28






OPEN/CAESAR MANUAL                          caesar_solve_1(LOCAL)



     will be stored and associated to the boolean equation system
     pointed to by ****CCCCAAAAEEEESSSSAAAARRRR____BBBB.

     The value of CCCCAAAAEEEESSSSAAAARRRR____BBBBLLLLOOOOCCCCKKKK____UUUUNNNNIIIIQQQQUUUUEEEE____RRRREEEESSSSOOOOLLLLUUUUTTTTIIIIOOOONNNN determines,  for
     each  equation  block, whether only one variable (or several
     variables) of the block will be solved.   If  the  value  of
     CCCCAAAAEEEESSSSAAAARRRR____BBBBLLLLOOOOCCCCKKKK____UUUUNNNNIIIIQQQQUUUUEEEE____RRRREEEESSSSOOOOLLLLUUUUTTTTIIIIOOOONNNN  is  different  from NNNNUUUULLLLLLLL, it
     will be given to the corresponding parameter in the call  to
     CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTEEEE____SSSSOOOOLLLLVVVVEEEE____1111(((())))  used to create the boolean equation
     system  pointed  to  by  ****CCCCAAAAEEEESSSSAAAARRRR____BBBB.    If   the   value   of
     CCCCAAAAEEEESSSSAAAARRRR____BBBBLLLLOOOOCCCCKKKK____UUUUNNNNIIIIQQQQUUUUEEEE____RRRREEEESSSSOOOOLLLLUUUUTTTTIIIIOOOONNNN  is  NNNNUUUULLLLLLLL,  then the value of
     the    corresponding    parameter    in    the    call    to
     CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTEEEE____SSSSOOOOLLLLVVVVEEEE____1111(((())))  will  be determined by the contents
     of CCCCAAAAEEEESSSSAAAARRRR____FFFFIIIILLLLEEEE.

     The value of CCCCAAAAEEEESSSSAAAARRRR____BBBBLLLLOOOOCCCCKKKK____SSSSOOOOLLLLVVVVEEEE____MMMMOOOODDDDEEEE  determines,  for  each
     equation block, its corresponding resolution mode, determin-
     ing which algorithm will be used by the  resolution  routine
     associated    to    the    block.     If    the   value   of
     CCCCAAAAEEEESSSSAAAARRRR____BBBBLLLLOOOOCCCCKKKK____SSSSOOOOLLLLVVVVEEEE____MMMMOOOODDDDEEEE is different from NNNNUUUULLLLLLLL, it  will  be
     given   to  the  corresponding  parameter  in  the  call  to
     CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTEEEE____SSSSOOOOLLLLVVVVEEEE____1111(((()))) used to create the boolean  equation
     system   pointed   to   by   ****CCCCAAAAEEEESSSSAAAARRRR____BBBB.   If  the  value  of
     CCCCAAAAEEEESSSSAAAARRRR____BBBBLLLLOOOOCCCCKKKK____SSSSOOOOLLLLVVVVEEEE____MMMMOOOODDDDEEEE is  NNNNUUUULLLLLLLL,  then  the  value  of  the
     corresponding      parameter      in     the     call     to
     CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTEEEE____SSSSOOOOLLLLVVVVEEEE____1111(((()))) will be determined by  the  contents
     of CCCCAAAAEEEESSSSAAAARRRR____FFFFIIIILLLLEEEE.

     Note: These two parameters allow to overwrite the values  of
     the   corresponding  parameters  of  CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTEEEE____SSSSOOOOLLLLVVVVEEEE____1111(((())))
     determined by the contents of CCCCAAAAEEEESSSSAAAARRRR____FFFFIIIILLLLEEEE.  This  is  useful
     for  applying  last  minute changes on the resolution of the
     boolean equation system read from CCCCAAAAEEEESSSSAAAARRRR____FFFFIIIILLLLEEEE.

     The contents of the boolean variables defined in  the  equa-
     tion  blocks  of  the  system  pointed  to  by ****CCCCAAAAEEEESSSSAAAARRRR____BBBB are
     natural numbers, i.e., values of  type  CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL.
     Each  variable  XXXXiiii  defined  by an equation of the system is
     represented by the value iiii of its index. As an example,  the
     following  portion  of C code implements the resolution of a
     boolean equation system created using CCCCAAAAEEEESSSSAAAARRRR____RRRREEEEAAAADDDD____SSSSOOOOLLLLVVVVEEEE____1111(((()))):

             CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSOOOOLLLLVVVVEEEE____1111 ccccaaaaeeeessssaaaarrrr____bbbbeeeessss;;;;
             CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____FFFFIIIILLLLEEEE ccccaaaaeeeessssaaaarrrr____ffffiiiilllleeee;;;;
             CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL ccccaaaaeeeessssaaaarrrr____vvvvaaaarrrriiiiaaaabbbblllleeee;;;;
             CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____BBBBOOOOOOOOLLLLEEEEAAAANNNN ccccaaaaeeeessssaaaarrrr____vvvvaaaalllluuuueeee;;;;

             iiiiffff ((((((((ccccaaaaeeeessssaaaarrrr____ffffiiiilllleeee ==== ffffooooppppeeeennnn ((((""""ffffiiiilllleeee....bbbbeeeessss"""",,,, """"rrrr"""")))))))) !!!!==== NNNNUUUULLLLLLLL)))) {{{{
                CCCCAAAAEEEESSSSAAAARRRR____RRRREEEEAAAADDDD____SSSSOOOOLLLLVVVVEEEE____1111 ((((&&&&ccccaaaaeeeessssaaaarrrr____bbbbeeeessss,,,, ccccaaaaeeeessssaaaarrrr____ffffiiiilllleeee,,,, NNNNUUUULLLLLLLL,,,, NNNNUUUULLLLLLLL))));;;;
                iiiiffff ((((ccccaaaaeeeessssaaaarrrr____bbbbeeeessss !!!!==== NNNNUUUULLLLLLLL)))) {{{{
                   ////**** rrrreeeessssoooolllluuuuttttiiiioooonnnn ooooffff vvvvaaaarrrriiiiaaaabbbblllleeee 0000 ddddeeeeffffiiiinnnneeeedddd iiiinnnn tttthhhheeee bbbblllloooocccckkkk ooooffff iiiinnnnddddeeeexxxx 0000 ****////
                   ccccaaaaeeeessssaaaarrrr____vvvvaaaarrrriiiiaaaabbbblllleeee ==== 0000;;;;



(C) INRIA     Last change: 2020/02/11 (version 1.3)            29






OPEN/CAESAR MANUAL                          caesar_solve_1(LOCAL)



                   ccccaaaaeeeessssaaaarrrr____vvvvaaaalllluuuueeee ==== CCCCAAAAEEEESSSSAAAARRRR____CCCCOOOOMMMMPPPPUUUUTTTTEEEE____SSSSOOOOLLLLVVVVEEEE____1111 ((((ccccaaaaeeeessssaaaarrrr____bbbbeeeessss,,,, 0000,,,,
                                     ((((CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____PPPPOOOOIIIINNNNTTTTEEEERRRR)))) ((((&&&&ccccaaaaeeeessssaaaarrrr____vvvvaaaarrrriiiiaaaabbbblllleeee))))))));;;;
                }}}}
             }}}}



      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____WWWWRRRRIIIITTTTEEEE____SSSSOOOOLLLLVVVVEEEE____1111

     vvvvooooiiiidddd CCCCAAAAEEEESSSSAAAARRRR____WWWWRRRRIIIITTTTEEEE____SSSSOOOOLLLLVVVVEEEE____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____BBBB,,,, CCCCAAAAEEEESSSSAAAARRRR____IIII,,,, CCCCAAAAEEEESSSSAAAARRRR____VVVV,,,,
                                CCCCAAAAEEEESSSSAAAARRRR____FFFFIIIILLLLEEEE,,,, CCCCAAAAEEEESSSSAAAARRRR____DDDDIIIIAAAAGGGGNNNNOOOOSSSSTTTTIIIICCCC))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSOOOOLLLLVVVVEEEE____1111 CCCCAAAAEEEESSSSAAAARRRR____BBBB;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL CCCCAAAAEEEESSSSAAAARRRR____IIII;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____PPPPOOOOIIIINNNNTTTTEEEERRRR CCCCAAAAEEEESSSSAAAARRRR____VVVV;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____FFFFIIIILLLLEEEE CCCCAAAAEEEESSSSAAAARRRR____FFFFIIIILLLLEEEE;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____BBBBOOOOOOOOLLLLEEEEAAAANNNN CCCCAAAAEEEESSSSAAAARRRR____DDDDIIIIAAAAGGGGNNNNOOOOSSSSTTTTIIIICCCC;;;;
        {{{{ ............ }}}}

     This procedure writes a portion of the boolean equation sys-
     tem  pointed  to  by  CCCCAAAAEEEESSSSAAAARRRR____BBBB in textual form into the file
     CCCCAAAAEEEESSSSAAAARRRR____FFFFIIIILLLLEEEE. The portion written contains equations defining
     boolean variables upon which the boolean variable pointed to
     by CCCCAAAAEEEESSSSAAAARRRR____VVVV, which must be defined in the equation block  of
     index CCCCAAAAEEEESSSSAAAARRRR____IIII, depends either directly, or transitively.

     Before this procedure is called, CCCCAAAAEEEESSSSAAAARRRR____FFFFIIIILLLLEEEE must have  been
     properly opened, for instance using ffffooooppppeeeennnn((((3333)))).

     So doing, various error conditions may occur: CCCCAAAAEEEESSSSAAAARRRR____FFFFIIIILLLLEEEE is
     not writable; a memory allocation failed, etc. In such case,
     a  detailed   error   message   is   displayed   using   the
     CCCCAAAAEEEESSSSAAAARRRR____WWWWAAAARRRRNNNNIIIINNNNGGGG(((())))  procedure and the portion of boolean equa-
     tion system written into CCCCAAAAEEEESSSSAAAARRRR____FFFFIIIILLLLEEEE may be truncated.

     If the block index CCCCAAAAEEEESSSSAAAARRRR____IIII  is  outside  the  range  0..N-1
     (where  N is the number of blocks in the system), the effect
     is undefined.

     If the value of CCCCAAAAEEEESSSSAAAARRRR____DDDDIIIIAAAAGGGGNNNNOOOOSSSSTTTTIIIICCCC is equal to  CCCCAAAAEEEESSSSAAAARRRR____FFFFAAAALLLLSSSSEEEE,
     the   portion   of  boolean  equation  system  written  into
     CCCCAAAAEEEESSSSAAAARRRR____FFFFIIIILLLLEEEE will contain all equations defining the  boolean
     variables  upon  which  the  boolean  variable pointed to by
     CCCCAAAAEEEESSSSAAAARRRR____VVVV depends.  Otherwise, this portion will contain only
     the  equations defining the variables contained in the diag-
     nostic for the variable pointed to by CCCCAAAAEEEESSSSAAAARRRR____VVVV,  which  must
     have      been      solved      previously      by     using
     CCCCAAAAEEEESSSSAAAARRRR____CCCCOOOOMMMMPPPPUUUUTTTTEEEE____SSSSOOOOLLLLVVVVEEEE____1111(((()))); if this is not the case, an  error
     message  is  displayed  using the CCCCAAAAEEEESSSSAAAARRRR____WWWWAAAARRRRNNNNIIIINNNNGGGG(((()))) procedure
     and nothing is written into CCCCAAAAEEEESSSSAAAARRRR____FFFFIIIILLLLEEEE.




(C) INRIA     Last change: 2020/02/11 (version 1.3)            30






OPEN/CAESAR MANUAL                          caesar_solve_1(LOCAL)



     Note: This procedure does not perform the resolution of  the
     variable pointed to by CCCCAAAAEEEESSSSAAAARRRR____VVVV.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____FFFFOOOORRRRMMMMAAAATTTT____SSSSOOOOLLLLVVVVEEEE____1111

     CCCCAAAAEEEESSSSAAAARRRR____FFFFOOOORRRRMMMMAAAATTTT CCCCAAAAEEEESSSSAAAARRRR____FFFFOOOORRRRMMMMAAAATTTT____SSSSOOOOLLLLVVVVEEEE____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____BBBB,,,, CCCCAAAAEEEESSSSAAAARRRR____FFFFOOOORRRRMMMMAAAATTTT))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSOOOOLLLLVVVVEEEE____1111 CCCCAAAAEEEESSSSAAAARRRR____BBBB;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____FFFFOOOORRRRMMMMAAAATTTT CCCCAAAAEEEESSSSAAAARRRR____FFFFOOOORRRRMMMMAAAATTTT;;;;
        {{{{ ............ }}}}

     This function allows to control the format under  which  the
     boolean  equation  system  pointed  to  by  CCCCAAAAEEEESSSSAAAARRRR____BBBB will be
     printed by the procedure CCCCAAAAEEEESSSSAAAARRRR____PPPPRRRRIIIINNNNTTTT____SSSSOOOOLLLLVVVVEEEE____1111(((()))) (see below).
     Currently, the following formats are available:


     -    With format 0, statistical information  concerning  the
          boolean  equation system is displayed such as: the size
          of variables and resolution  modes  for  each  equation
          block  of  the  system, the number of boolean variables
          explored during resolution, etc.

     -    With format 1, statistical information  concerning  the
          internal  tables  associated  to the equation blocks of
          the   system   is   printed   using    the    procedure
          CCCCAAAAEEEESSSSAAAARRRR____PPPPRRRRIIIINNNNTTTT____TTTTAAAABBBBLLLLEEEE____1111(((()))).

     -    With format 2, the  contents  of  the  internal  tables
          associated  to  the  equation  blocks of the system are
          printed using the procedure CCCCAAAAEEEESSSSAAAARRRR____PPPPRRRRIIIINNNNTTTT____TTTTAAAABBBBLLLLEEEE____1111(((()))).

     -    (no other format available yet)

     By default, the current format of each boolean equation sys-
     tem is initialized to 0.

     When called with CCCCAAAAEEEESSSSAAAARRRR____FFFFOOOORRRRMMMMAAAATTTT between 0 and 2,  this  fonc-
     tion  sets  the  current format of CCCCAAAAEEEESSSSAAAARRRR____BBBB to CCCCAAAAEEEESSSSAAAARRRR____FFFFOOOORRRRMMMMAAAATTTT
     and returns an undefined result.

     When called with another value of CCCCAAAAEEEESSSSAAAARRRR____FFFFOOOORRRRMMMMAAAATTTT, this  func-
     tion  does  not  modify  the  current format of CCCCAAAAEEEESSSSAAAARRRR____BBBB but
     returns a result defined as  follows.  If  CCCCAAAAEEEESSSSAAAARRRR____FFFFOOOORRRRMMMMAAAATTTT  is
     equal  to  the constant CCCCAAAAEEEESSSSAAAARRRR____CCCCUUUURRRRRRRREEEENNNNTTTT____FFFFOOOORRRRMMMMAAAATTTT, the result is
     the  value  of  the   current   format   of   CCCCAAAAEEEESSSSAAAARRRR____BBBB.   If
     CCCCAAAAEEEESSSSAAAARRRR____FFFFOOOORRRRMMMMAAAATTTT      is      equal     to     the     constant
     CCCCAAAAEEEESSSSAAAARRRR____MMMMAAAAXXXXIIIIMMMMAAAALLLL____FFFFOOOORRRRMMMMAAAATTTT, the  result  is  the  maximal  format
     value  (i.e.,  2).  In  all  other cases, the effect of this
     function is undefined.



(C) INRIA     Last change: 2020/02/11 (version 1.3)            31






OPEN/CAESAR MANUAL                          caesar_solve_1(LOCAL)



      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____MMMMAAAAXXXX____FFFFOOOORRRRMMMMAAAATTTT____SSSSOOOOLLLLVVVVEEEE____1111

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____FFFFOOOORRRRMMMMAAAATTTT CCCCAAAAEEEESSSSAAAARRRR____MMMMAAAAXXXX____FFFFOOOORRRRMMMMAAAATTTT____SSSSOOOOLLLLVVVVEEEE____1111 (((())))
        {{{{ ............ }}}}

     Caution! This function is deprecated. It should no longer be
     used,  as  it  might  be removed from future versions of the
     _O_P_E_N/_C_A_E_S_A_R. Use function  CCCCAAAAEEEESSSSAAAARRRR____FFFFOOOORRRRMMMMAAAATTTT____SSSSOOOOLLLLVVVVEEEE____1111(((())))  instead,
     called with argument CCCCAAAAEEEESSSSAAAARRRR____MMMMAAAAXXXXIIIIMMMMAAAALLLL____FFFFOOOORRRRMMMMAAAATTTT.

     This function returns the maximal format value available for
     printing boolean equation systems.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____PPPPRRRRIIIINNNNTTTT____SSSSOOOOLLLLVVVVEEEE____1111

     vvvvooooiiiidddd CCCCAAAAEEEESSSSAAAARRRR____PPPPRRRRIIIINNNNTTTT____SSSSOOOOLLLLVVVVEEEE____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____FFFFIIIILLLLEEEE,,,, CCCCAAAAEEEESSSSAAAARRRR____BBBB))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____FFFFIIIILLLLEEEE CCCCAAAAEEEESSSSAAAARRRR____FFFFIIIILLLLEEEE;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSOOOOLLLLVVVVEEEE____1111 CCCCAAAAEEEESSSSAAAARRRR____BBBB;;;;
        {{{{ ............ }}}}

     This procedure prints on file CCCCAAAAEEEESSSSAAAARRRR____FFFFIIIILLLLEEEE an ASCII text con-
     taining various informations about the boolean equation sys-
     tem pointed to by CCCCAAAAEEEESSSSAAAARRRR____BBBB. The nature of these informations
     is  determined by the current format of the boolean equation
     system pointed to by CCCCAAAAEEEESSSSAAAARRRR____BBBB.

     Before this procedure is called, CCCCAAAAEEEESSSSAAAARRRR____FFFFIIIILLLLEEEE must have  been
     properly opened, for instance using ffffooooppppeeeennnn((((3333)))).


BBBBIIIIBBBBLLLLIIIIOOOOGGGGRRRRAAAAPPPPHHHHYYYY
     [Mat03] Radu Mateescu.   A  Generic  On-the-Fly  Solver  for
     Alternation-Free   Boolean   Equation  Systems.   In  Hubert
     Garavel and John Hatcliff, editors, Proceedings of  the  9th
     International  Conference  on  Tools  and Algorithms for the
     Construction and Analysis  of  Systems  TACAS'2003  (Warsaw,
     Poland),  Lecture Notes in Computer Science vol. 2619, pages
     81--96.  Springer  Verlag,  April   2003.   Available   from
     hhhhttttttttpppp::::////////ccccaaaaddddpppp....iiiinnnnrrrriiiiaaaa....ffffrrrr////ppppuuuubbbblllliiiiccccaaaattttiiiioooonnnnssss////MMMMaaaatttteeeeeeeessssccccuuuu----00003333----aaaa....hhhhttttmmmmllll

     [Mat06] Radu Mateescu.  CAESAR_SOLVE: A Generic Library  for
     On-the-Fly  Resolution  of Alternation-Free Boolean Equation
     Systems.  Springer International Journal on  Software  Tools
     for  Technology Transfer (STTT), 8(1):37--56, February 2006.
     Available  from  hhhhttttttttpppp::::////////ccccaaaaddddpppp....iiiinnnnrrrriiiiaaaa....ffffrrrr////ppppuuuubbbblllliiiiccccaaaattttiiiioooonnnnssss////MMMMaaaatttteeeeeeeessssccccuuuu----
     00006666----aaaa....hhhhttttmmmmllll




(C) INRIA     Last change: 2020/02/11 (version 1.3)            32






OPEN/CAESAR MANUAL                          caesar_solve_1(LOCAL)



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























(C) INRIA     Last change: 2020/02/11 (version 1.3)            33



