


CADP MANUAL PAGES                                 BCG_READ(LOCAL)



NNNNAAAAMMMMEEEE
     bcg_read - a simple interface to read a BCG graph

DDDDEEEESSSSCCCCRRRRIIIIPPPPTTTTIIIIOOOONNNN
     This interface reads a BCG graph from an application program
     written  in  C or C++. To keep things simple, this interface
     views states as unsigned integer numbers and labels as char-
     acter strings. Note: this subset of BCG is equivalent to the
     ....aaaauuuutttt format described in the aaaallllddddeeeebbbbaaaarrrraaaannnn(LOCAL)  manual  page,
     although it is much more compact.

UUUUSSSSAAAAGGGGEEEE
     The application program  should  start  with  the  following
     directive:

        ####iiiinnnncccclllluuuuddddeeee """"bbbbccccgggg____uuuusssseeeerrrr....hhhh""""

     Then the BCG library should be initialized by  invoking  the
     following function:

        BBBBCCCCGGGG____IIIINNNNIIIITTTT (((())));;;;

     Not invoking this function might  cause  a  run-time  error,
     e.g.,  a  segmentation  fault. Invoking BBBBCCCCGGGG____IIIINNNNIIIITTTT(((()))) more than
     once is harmless, although not recommended.


DDDDAAAATTTTAAAA TTTTYYYYPPPPEEEESSSS
     In order to read a BCG graph, declare a data structure  hav-
     ing  the  type BBBBCCCCGGGG____TTTTYYYYPPPPEEEE____OOOOBBBBJJJJEEEECCCCTTTT____TTTTRRRRAAAANNNNSSSSIIIITTTTIIIIOOOONNNN (this type is pro-
     vided by the "bcg_user.h" file), which contains  information
     related  to  the  graph.   Assuming that this data structure
     will be named _b_c_g__g_r_a_p_h, this declaration will have the fol-
     lowing form:

         BBBBCCCCGGGG____TTTTYYYYPPPPEEEE____OOOOBBBBJJJJEEEECCCCTTTT____TTTTRRRRAAAANNNNSSSSIIIITTTTIIIIOOOONNNN _b_c_g__g_r_a_p_h;;;;

     Note: this interface is reentrant, in the sense that several
     BCG  graphs can be read concurrently, provided that each BCG
     graph is associated with a distinct data structure  of  type
     BBBBCCCCGGGG____TTTTYYYYPPPPEEEE____OOOOBBBBJJJJEEEECCCCTTTT____TTTTRRRRAAAANNNNSSSSIIIITTTTIIIIOOOONNNN.

     The functions of this  interface  also  use  the  followings
     types,  whose  definitions  are provided by the "bcg_user.h"
     file:

         BBBBCCCCGGGG____TTTTYYYYPPPPEEEE____BBBBOOOOOOOOLLLLEEEEAAAANNNN

         BBBBCCCCGGGG____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL

         BBBBCCCCGGGG____TTTTYYYYPPPPEEEE____CCCC____SSSSTTTTRRRRIIIINNNNGGGG




(C) INRIA            Last change: 2013/09/09                    1






CADP MANUAL PAGES                                 BCG_READ(LOCAL)



         BBBBCCCCGGGG____TTTTYYYYPPPPEEEE____FFFFIIIILLLLEEEE____NNNNAAAAMMMMEEEE

         BBBBCCCCGGGG____TTTTYYYYPPPPEEEE____SSSSTTTTAAAATTTTEEEE____NNNNUUUUMMMMBBBBEEEERRRR

         BBBBCCCCGGGG____TTTTYYYYPPPPEEEE____LLLLAAAABBBBEEEELLLL____NNNNUUUUMMMMBBBBEEEERRRR

         BBBBCCCCGGGG____TTTTYYYYPPPPEEEE____EEEEDDDDGGGGEEEE____NNNNUUUUMMMMBBBBEEEERRRR


FFFFEEEEAAAATTTTUUUURRRREEEESSSS
      ............................................................

  BBBBCCCCGGGG____OOOOTTTT____RRRREEEEAAAADDDD____BBBBCCCCGGGG____BBBBEEEEGGGGIIIINNNN

      BBBBCCCCGGGG____OOOOTTTT____RRRREEEEAAAADDDD____BBBBCCCCGGGG____BBBBEEEEGGGGIIIINNNN ((((_f_i_l_e_n_a_m_e,,,, _b_c_g__g_r_a_p_h,,,, _a_c_c_e_s_s__m_o_d_e))))

       BBBBCCCCGGGG____TTTTYYYYPPPPEEEE____FFFFIIIILLLLEEEE____NNNNAAAAMMMMEEEE         _f_i_l_e_n_a_m_e;;;;
       BBBBCCCCGGGG____TTTTYYYYPPPPEEEE____OOOOBBBBJJJJEEEECCCCTTTT____TTTTRRRRAAAANNNNSSSSIIIITTTTIIIIOOOONNNN ****_b_c_g__g_r_a_p_h;;;;
       BBBBCCCCGGGG____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL           _a_c_c_e_s_s__m_o_d_e;;;;
       {{{{ ............ }}}}

     This function opens a BCG file.

     _f_i_l_e_n_a_m_e
          is a character string containing the path name  of  the
          BCG file to be read. It should contain the  "....bbbbccccgggg" suf-
          fix (if the "....bbbbccccgggg" suffix is missing, it will be  added
          automatically);

     _b_c_g__g_r_a_p_h
          is a pointer to the data structure  which  will  become
          associated  with  the BCG graph and into which informa-
          tion about the BCG graph will be stored;

     _a_c_c_e_s_s__m_o_d_e
          is an integer indicating which kind of  primitives  are
          expected  for  exploring the transition relation of the
          BCG graph.

     There are several possible values for _a_c_c_e_s_s__m_o_d_e:

     0:   should be used when it is only necessary  to  enumerate
          the edges in the BCG graph.

     1:   should be used when one has to enumerate the successors
          of a given state.

     2:   should be used when one has to enumerate the  predeces-
          sors of a given state.

     3:   should be used when one has to enumerate both the  suc-
          cessors and predecessors of a given state.



(C) INRIA            Last change: 2013/09/09                    2






CADP MANUAL PAGES                                 BCG_READ(LOCAL)



     4:   is similar to value 3, but uses a different data struc-
          ture.

     By default,  if  _f_i_l_e_n_a_m_e  cannot  be  opened  for  reading,
     BBBBCCCCGGGG____OOOOTTTT____RRRREEEEAAAADDDD____BBBBCCCCGGGG____BBBBEEEEGGGGIIIINNNN(((())))  will emit an error message and exit
     the program. However, if the following function call:

         BBBBCCCCGGGG____OOOOTTTT____RRRREEEEAAAADDDD____BBBBCCCCGGGG____SSSSUUUURRRRVVVVIIIIVVVVEEEE ((((BBBBCCCCGGGG____TTTTRRRRUUUUEEEE))));;;;

     has occured before the call to BBBBCCCCGGGG____OOOOTTTT____RRRREEEEAAAADDDD____BBBBCCCCGGGG____BBBBEEEEGGGGIIIINNNN(((()))), then
     BBBBCCCCGGGG____OOOOTTTT____RRRREEEEAAAADDDD____BBBBCCCCGGGG____BBBBEEEEGGGGIIIINNNN(((())))  will  neither emit an error message
     nor exit the program, but return normally with its _b_c_g__g_r_a_p_h
     parameter  set  to  NNNNUUUULLLLLLLL  if  and only if _f_i_l_e_n_a_m_e cannot be
     opened.

     Below, we assume that the *_b_c_g__g_r_a_p_h data structure has been
     properly  assigned  after  a  successful  invocation  of the
     BBBBCCCCGGGG____OOOOTTTT____RRRREEEEAAAADDDD____BBBBCCCCGGGG____BBBBEEEEGGGGIIIINNNN(((()))) function.

      ............................................................

  BBBBCCCCGGGG____OOOOTTTT____RRRREEEEAAAADDDD____BBBBCCCCGGGG____SSSSUUUURRRRVVVVIIIIVVVVEEEE

      BBBBCCCCGGGG____OOOOTTTT____RRRREEEEAAAADDDD____BBBBCCCCGGGG____SSSSUUUURRRRVVVVIIIIVVVVEEEE ((((_m_o_d_e))))

       BBBBCCCCGGGG____TTTTYYYYPPPPEEEE____BBBBOOOOOOOOLLLLEEEEAAAANNNN _m_o_d_e;;;;
       {{{{ ............ }}}}

     This function controls how the BBBBCCCCGGGG____OOOOTTTT____RRRREEEEAAAADDDD____BBBBCCCCGGGG____BBBBEEEEGGGGIIIINNNN(((()))) func-
     tion  defined  above  will  behave if the BCG file cannot be
     opened for writing:

     -    If _m_o_d_e equals BBBBCCCCGGGG____FFFFAAAALLLLSSSSEEEE, then  BBBBCCCCGGGG____OOOOTTTT____RRRREEEEAAAADDDD____BBBBCCCCGGGG____BBBBEEEEGGGGIIIINNNN(((())))
          will  emit  an error message and exit the program. This
          is the default behaviour.

     -    If _m_o_d_e equals BBBBCCCCGGGG____TTTTRRRRUUUUEEEE,  then  BBBBCCCCGGGG____OOOOTTTT____RRRREEEEAAAADDDD____BBBBCCCCGGGG____BBBBEEEEGGGGIIIINNNN(((())))
          will  neither  emit  an error message nor exit the pro-
          gram,  but  return  a  boolean  result.   The   default
          behaviour can be restored by calling:

         BBBBCCCCGGGG____OOOOTTTT____RRRREEEEAAAADDDD____BBBBCCCCGGGG____SSSSUUUURRRRVVVVIIIIVVVVEEEE ((((BBBBCCCCGGGG____FFFFAAAALLLLSSSSEEEE))));;;;

      ............................................................

  BBBBCCCCGGGG____OOOOTTTT____IIIINNNNIIIITTTTIIIIAAAALLLL____SSSSTTTTAAAATTTTEEEE

      BBBBCCCCGGGG____TTTTYYYYPPPPEEEE____SSSSTTTTAAAATTTTEEEE____NNNNUUUUMMMMBBBBEEEERRRR BBBBCCCCGGGG____OOOOTTTT____IIIINNNNIIIITTTTIIIIAAAALLLL____SSSSTTTTAAAATTTTEEEE ((((_b_c_g__g_r_a_p_h))))

       BBBBCCCCGGGG____TTTTYYYYPPPPEEEE____OOOOBBBBJJJJEEEECCCCTTTT____TTTTRRRRAAAANNNNSSSSIIIITTTTIIIIOOOONNNN _b_c_g__g_r_a_p_h;;;;
       {{{{ ............ }}}}




(C) INRIA            Last change: 2013/09/09                    3






CADP MANUAL PAGES                                 BCG_READ(LOCAL)



     This function returns the number of the initial state of the
     BCG graph.

      ............................................................

  BBBBCCCCGGGG____OOOOTTTT____NNNNBBBB____SSSSTTTTAAAATTTTEEEESSSS

      BBBBCCCCGGGG____SSSSTTTTAAAATTTTEEEE____NNNNUUUUMMMMBBBBEEEERRRR BBBBCCCCGGGG____OOOOTTTT____NNNNBBBB____SSSSTTTTAAAATTTTEEEESSSS ((((_b_c_g__g_r_a_p_h))))

       BBBBCCCCGGGG____TTTTYYYYPPPPEEEE____OOOOBBBBJJJJEEEECCCCTTTT____TTTTRRRRAAAANNNNSSSSIIIITTTTIIIIOOOONNNN _b_c_g__g_r_a_p_h;;;;
       {{{{ ............ }}}}

     This function returns the number of states of the BCG graph.
     States   are   given  unique  numbers  in  the  range  0000  to
     BBBBCCCCGGGG____OOOOTTTT____NNNNBBBB____SSSSTTTTAAAATTTTEEEESSSS ((((_b_c_g__g_r_a_p_h)))) ---- 1111.

      ............................................................

  BBBBCCCCGGGG____OOOOTTTT____NNNNBBBB____EEEEDDDDGGGGEEEESSSS

      BBBBCCCCGGGG____TTTTYYYYPPPPEEEE____EEEEDDDDGGGGEEEE____NNNNUUUUMMMMBBBBEEEERRRR BBBBCCCCGGGG____OOOOTTTT____NNNNBBBB____EEEEDDDDGGGGEEEESSSS ((((_b_c_g__g_r_a_p_h))))

       BBBBCCCCGGGG____TTTTYYYYPPPPEEEE____OOOOBBBBJJJJEEEECCCCTTTT____TTTTRRRRAAAANNNNSSSSIIIITTTTIIIIOOOONNNN _b_c_g__g_r_a_p_h;;;;
       {{{{ ............ }}}}

     This function returns the number  of  edges  (i.e.,  transi-
     tions)  of  the BCG graph. Edges are given unique numbers in
     the range 0000 to BBBBCCCCGGGG____OOOOTTTT____NNNNBBBB____EEEEDDDDGGGGEEEESSSS ((((_b_c_g__g_r_a_p_h)))) ---- 1111.

      ............................................................

  BBBBCCCCGGGG____OOOOTTTT____NNNNBBBB____LLLLAAAABBBBEEEELLLLSSSS

      BBBBCCCCGGGG____TTTTYYYYPPPPEEEE____LLLLAAAABBBBEEEELLLL____NNNNUUUUMMMMBBBBEEEERRRR BBBBCCCCGGGG____OOOOTTTT____NNNNBBBB____LLLLAAAABBBBEEEELLLLSSSS ((((_b_c_g__g_r_a_p_h))))

       BBBBCCCCGGGG____TTTTYYYYPPPPEEEE____OOOOBBBBJJJJEEEECCCCTTTT____TTTTRRRRAAAANNNNSSSSIIIITTTTIIIIOOOONNNN _b_c_g__g_r_a_p_h;;;;
       {{{{ ............ }}}}

     This function returns the number of labels of the BCG graph.
     Labels   are   given  unique  numbers  in  the  range  0000  to
     BBBBCCCCGGGG____OOOOTTTT____NNNNBBBB____LLLLAAAABBBBEEEELLLLSSSS ((((_b_c_g__g_r_a_p_h)))) ---- 1111.

      ............................................................

  BBBBCCCCGGGG____OOOOTTTT____LLLLAAAABBBBEEEELLLL____SSSSTTTTRRRRIIIINNNNGGGG

      BBBBCCCCGGGG____TTTTYYYYPPPPEEEE____CCCC____SSSSTTTTRRRRIIIINNNNGGGG BBBBCCCCGGGG____OOOOTTTT____LLLLAAAABBBBEEEELLLL____SSSSTTTTRRRRIIIINNNNGGGG ((((_b_c_g__g_r_a_p_h,
                                             _b_c_g__l_a_b_e_l__n_u_m_b_e_r))))

       BBBBCCCCGGGG____TTTTYYYYPPPPEEEE____OOOOBBBBJJJJEEEECCCCTTTT____TTTTRRRRAAAANNNNSSSSIIIITTTTIIIIOOOONNNN _b_c_g__g_r_a_p_h;;;;
       BBBBCCCCGGGG____TTTTYYYYPPPPEEEE____LLLLAAAABBBBEEEELLLL____NNNNUUUUMMMMBBBBEEEERRRR      _b_c_g__l_a_b_e_l__n_u_m_b_e_r;;;;
       {{{{ ............ }}}}



(C) INRIA            Last change: 2013/09/09                    4






CADP MANUAL PAGES                                 BCG_READ(LOCAL)



     This function returns a character string denoting the  label
     whose     index    is    _b_c_g__l_a_b_e_l__n_u_m_b_e_r.     It    assumes
     _b_c_g__l_a_b_e_l__n_u_m_b_e_r belongs to the range 0000 to  BBBBCCCCGGGG____OOOOTTTT____NNNNBBBB____LLLLAAAABBBBEEEELLLLSSSS
     ((((_b_c_g__g_r_a_p_h)))) ---- 1111.

      ............................................................

  BBBBCCCCGGGG____OOOOTTTT____LLLLAAAABBBBEEEELLLL____VVVVIIIISSSSIIIIBBBBLLLLEEEE

      BBBBCCCCGGGG____TTTTYYYYPPPPEEEE____BBBBOOOOOOOOLLLLEEEEAAAANNNN BBBBCCCCGGGG____OOOOTTTT____LLLLAAAABBBBEEEELLLL____VVVVIIIISSSSIIIIBBBBLLLLEEEE ((((_b_c_g__g_r_a_p_h,
                                             _b_c_g__l_a_b_e_l__n_u_m_b_e_r))))

       BBBBCCCCGGGG____TTTTYYYYPPPPEEEE____OOOOBBBBJJJJEEEECCCCTTTT____TTTTRRRRAAAANNNNSSSSIIIITTTTIIIIOOOONNNN _b_c_g__g_r_a_p_h;;;;
       BBBBCCCCGGGG____TTTTYYYYPPPPEEEE____LLLLAAAABBBBEEEELLLL____NNNNUUUUMMMMBBBBEEEERRRR      _b_c_g__l_a_b_e_l__n_u_m_b_e_r;;;;
       {{{{ ............ }}}}

     This function returns a boolean that is equal  to  BBBBCCCCGGGG____FFFFAAAALLLLSSSSEEEE
     if the label whose index is _b_c_g__l_a_b_e_l__n_u_m_b_e_r is not visible,
     or  BBBBCCCCGGGG____TTTTRRRRUUUUEEEE  if  this  label  is   visible.    It   assumes
     _b_c_g__l_a_b_e_l__n_u_m_b_e_r  belongs to the range 0000 to BBBBCCCCGGGG____OOOOTTTT____NNNNBBBB____LLLLAAAABBBBEEEELLLLSSSS
     ((((_b_c_g__g_r_a_p_h)))) ---- 1111.

      ............................................................

  BBBBCCCCGGGG____OOOOTTTT____LLLLAAAABBBBEEEELLLL____GGGGAAAATTTTEEEE

      BBBBCCCCGGGG____TTTTYYYYPPPPEEEE____CCCC____SSSSTTTTRRRRIIIINNNNGGGG BBBBCCCCGGGG____OOOOTTTT____LLLLAAAABBBBEEEELLLL____GGGGAAAATTTTEEEE ((((_b_c_g__g_r_a_p_h,
                                             _b_c_g__l_a_b_e_l__n_u_m_b_e_r))))

       BBBBCCCCGGGG____TTTTYYYYPPPPEEEE____OOOOBBBBJJJJEEEECCCCTTTT____TTTTRRRRAAAANNNNSSSSIIIITTTTIIIIOOOONNNN _b_c_g__g_r_a_p_h;;;;
       BBBBCCCCGGGG____TTTTYYYYPPPPEEEE____LLLLAAAABBBBEEEELLLL____NNNNUUUUMMMMBBBBEEEERRRR      _b_c_g__l_a_b_e_l__n_u_m_b_e_r;;;;
       {{{{ ............ }}}}

     This function returns a character string that  is  equal  to
     """"iiii""""  if  the  label  whose  index is _b_c_g__l_a_b_e_l__n_u_m_b_e_r is not
     visible, or to the gate (i.e., first element) of this  label
     if  this  label  is  visible.   It  assumes _b_c_g__l_a_b_e_l__n_u_m_b_e_r
     belongs to the range 0000 to BBBBCCCCGGGG____OOOOTTTT____NNNNBBBB____LLLLAAAABBBBEEEELLLLSSSS ((((_b_c_g__g_r_a_p_h)))) ---- 1111.

      ............................................................

  BBBBCCCCGGGG____OOOOTTTT____LLLLAAAABBBBEEEELLLL____HHHHIIIIDDDDDDDDEEEENNNN____GGGGAAAATTTTEEEE

      BBBBCCCCGGGG____TTTTYYYYPPPPEEEE____CCCC____SSSSTTTTRRRRIIIINNNNGGGG BBBBCCCCGGGG____OOOOTTTT____LLLLAAAABBBBEEEELLLL____HHHHIIIIDDDDDDDDEEEENNNN____GGGGAAAATTTTEEEE ((((_b_c_g__g_r_a_p_h,
                                             _b_c_g__l_a_b_e_l__n_u_m_b_e_r))))

       BBBBCCCCGGGG____TTTTYYYYPPPPEEEE____OOOOBBBBJJJJEEEECCCCTTTT____TTTTRRRRAAAANNNNSSSSIIIITTTTIIIIOOOONNNN _b_c_g__g_r_a_p_h;;;;
       BBBBCCCCGGGG____TTTTYYYYPPPPEEEE____LLLLAAAABBBBEEEELLLL____NNNNUUUUMMMMBBBBEEEERRRR      _b_c_g__l_a_b_e_l__n_u_m_b_e_r;;;;
       {{{{ ............ }}}}

     This function returns a character string that is equal to """"""""
     if  the label whose index is _b_c_g__l_a_b_e_l__n_u_m_b_e_r is visible, or



(C) INRIA            Last change: 2013/09/09                    5






CADP MANUAL PAGES                                 BCG_READ(LOCAL)



     to the gate (i.e., first element) of  this  label  (if  any)
     before  it  was hidden.  It assumes _b_c_g__l_a_b_e_l__n_u_m_b_e_r belongs
     to the range 0000 to BBBBCCCCGGGG____OOOOTTTT____NNNNBBBB____LLLLAAAABBBBEEEELLLLSSSS ((((_b_c_g__g_r_a_p_h)))) ---- 1111.

      ............................................................

  BBBBCCCCGGGG____OOOOTTTT____LLLLAAAABBBBEEEELLLL____CCCCAAAARRRRDDDDIIIINNNNAAAALLLL

      BBBBCCCCGGGG____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL BBBBCCCCGGGG____OOOOTTTT____LLLLAAAABBBBEEEELLLL____CCCCAAAARRRRDDDDIIIINNNNAAAALLLL ((((_b_c_g__g_r_a_p_h,
                                             _b_c_g__l_a_b_e_l__n_u_m_b_e_r))))

       BBBBCCCCGGGG____TTTTYYYYPPPPEEEE____OOOOBBBBJJJJEEEECCCCTTTT____TTTTRRRRAAAANNNNSSSSIIIITTTTIIIIOOOONNNN _b_c_g__g_r_a_p_h;;;;
       BBBBCCCCGGGG____TTTTYYYYPPPPEEEE____LLLLAAAABBBBEEEELLLL____NNNNUUUUMMMMBBBBEEEERRRR      _b_c_g__l_a_b_e_l__n_u_m_b_e_r;;;;
       {{{{ ............ }}}}

     This function returns a natural number that is equal to  the
     number   of   elements   in   the   label   whose  index  is
     _b_c_g__l_a_b_e_l__n_u_m_b_e_r (this number is always equal to  1  if  the
     label  is not visible).  It assumes _b_c_g__l_a_b_e_l__n_u_m_b_e_r belongs
     to the range 0000 to BBBBCCCCGGGG____OOOOTTTT____NNNNBBBB____LLLLAAAABBBBEEEELLLLSSSS ((((_b_c_g__g_r_a_p_h)))) ---- 1111.

      ............................................................

  BBBBCCCCGGGG____OOOOTTTT____IIIITTTTEEEERRRRAAAATTTTEEEE____PPPPLLLLNNNN


       BBBBCCCCGGGG____TTTTYYYYPPPPEEEE____OOOOBBBBJJJJEEEECCCCTTTT____TTTTRRRRAAAANNNNSSSSIIIITTTTIIIIOOOONNNN _b_c_g__g_r_a_p_h;;;;
       BBBBCCCCGGGG____TTTTYYYYPPPPEEEE____SSSSTTTTAAAATTTTEEEE____NNNNUUUUMMMMBBBBEEEERRRR      _b_c_g__s_t_a_t_e__1;;;;
       BBBBCCCCGGGG____TTTTYYYYPPPPEEEE____LLLLAAAABBBBEEEELLLL____NNNNUUUUMMMMBBBBEEEERRRR      _b_c_g__l_a_b_e_l__n_u_m_b_e_r;;;;
       BBBBCCCCGGGG____TTTTYYYYPPPPEEEE____SSSSTTTTAAAATTTTEEEE____NNNNUUUUMMMMBBBBEEEERRRR      _b_c_g__s_t_a_t_e__2;;;;

       BBBBCCCCGGGG____OOOOTTTT____IIIITTTTEEEERRRRAAAATTTTEEEE____PPPPLLLLNNNN ((((_b_c_g__g_r_a_p_h, _b_c_g__s_t_a_t_e__1,
                             _b_c_g__l_a_b_e_l__n_u_m_b_e_r, _b_c_g__s_t_a_t_e__2))))
       {{{{
       ////**** lllloooooooopppp bbbbooooddddyyyy ****////
       }}}} BBBBCCCCGGGG____OOOOTTTT____EEEENNNNDDDD____IIIITTTTEEEERRRRAAAATTTTEEEE;;;;

     This iterator enumerates all the  edges  in  the  BCG  graph
     associated to _b_c_g__g_r_a_p_h.

     _b_c_g__s_t_a_t_e__1 is the number of the origin state of  the  edge,
     _b_c_g__s_t_a_t_e__2  is  the  number of the destination state of the
     edge, and _b_c_g__l_a_b_e_l__n_u_m_b_e_r is the number of the label of the
     edge.  These  three  variables are assigned by the iterator.
     They are visible in the loop body, where they  can  be  read
     but not assigned.

     For each edge (_b_c_g__s_t_a_t_e__1, _b_c_g__l_a_b_e_l__n_u_m_b_e_r,  _b_c_g__s_t_a_t_e__2),
     the  loop  body is executed. The loop body can be any state-
     ment block of the C language. In particular, it may  contain
     "bbbbrrrreeeeaaaakkkk"  and  "ccccoooonnnnttttiiiinnnnuuuueeee"  statements with their usual seman-
     tics.  The order in which the edges are enumerated  by  this



(C) INRIA            Last change: 2013/09/09                    6






CADP MANUAL PAGES                                 BCG_READ(LOCAL)



     iterator is left unspecified.

     This iterator is  available  whatever  value  was  given  to
     _a_c_c_e_s_s__m_o_d_e  when  the  BCG file associated to _b_c_g__g_r_a_p_h was
     opened using BBBBCCCCGGGG____OOOOTTTT____RRRREEEEAAAADDDD____BBBBCCCCGGGG____BBBBEEEEGGGGIIIINNNN(((()))).

     There is also a whole family of  iterators  that  allow  the
     enumeration  of  all  the edges for which _b_c_g__s_t_a_t_e__1 and/or
     _b_c_g__l_a_b_e_l__n_u_m_b_e_r and/or _b_c_g__s_t_a_t_e__2 are given fixed  values.
     The  availability  of these iterators depends upon the value
     given  to  _a_c_c_e_s_s__m_o_d_e  when  the  BCG  file  associated  to
     _b_c_g__g_r_a_p_h  was  opened.  We  describe below a representative
     iterator (named BBBBCCCCGGGG____OOOOTTTT____IIIITTTTEEEERRRRAAAATTTTEEEE____PPPP____LLLLNNNN) in this family.

      ............................................................

  BBBBCCCCGGGG____OOOOTTTT____IIIITTTTEEEERRRRAAAATTTTEEEE____PPPP____LLLLNNNN


       BBBBCCCCGGGG____TTTTYYYYPPPPEEEE____OOOOBBBBJJJJEEEECCCCTTTT____TTTTRRRRAAAANNNNSSSSIIIITTTTIIIIOOOONNNN _b_c_g__g_r_a_p_h;;;;
       BBBBCCCCGGGG____TTTTYYYYPPPPEEEE____SSSSTTTTAAAATTTTEEEE____NNNNUUUUMMMMBBBBEEEERRRR      _b_c_g__s_t_a_t_e__1;;;;
       BBBBCCCCGGGG____TTTTYYYYPPPPEEEE____LLLLAAAABBBBEEEELLLL____NNNNUUUUMMMMBBBBEEEERRRR      _b_c_g__l_a_b_e_l__n_u_m_b_e_r;;;;
       BBBBCCCCGGGG____TTTTYYYYPPPPEEEE____SSSSTTTTAAAATTTTEEEE____NNNNUUUUMMMMBBBBEEEERRRR      _b_c_g__s_t_a_t_e__2;;;;

       BBBBCCCCGGGG____OOOOTTTT____IIIITTTTEEEERRRRAAAATTTTEEEE____PPPP____LLLLNNNN ((((_b_c_g__g_r_a_p_h, _b_c_g__s_t_a_t_e__1,
                              _b_c_g__l_a_b_e_l__n_u_m_b_e_r, _b_c_g__s_t_a_t_e__2))))
       {{{{
       ////**** lllloooooooopppp bbbbooooddddyyyy ****////
       }}}} BBBBCCCCGGGG____OOOOTTTT____EEEENNNNDDDD____IIIITTTTEEEERRRRAAAATTTTEEEE;;;;

     This iterator enumerates all the edges in the BCG graph with
     origin state equal to _b_c_g__s_t_a_t_e__1. _b_c_g__s_t_a_t_e__1 is a variable
     or an expression whose value is evaluated when the  iterator
     is started.  _b_c_g__s_t_a_t_e__1 is not assigned by the iterator.

     _b_c_g__s_t_a_t_e__2 is the number of the destination  state  of  the
     edge, and _b_c_g__l_a_b_e_l__n_u_m_b_e_r is the number of the label of the
     edge.  These two variables are  assigned  by  the  iterator.
     They  are  visible  in the loop body, where they can be read
     but not assigned.

     For each edge (_b_c_g__s_t_a_t_e__1, _b_c_g__l_a_b_e_l__n_u_m_b_e_r,  _b_c_g__s_t_a_t_e__2),
     the  loop  body is executed. The loop body can be any state-
     ment block of the C language. In particular, it may  contain
     "bbbbrrrreeeeaaaakkkk"  and  "ccccoooonnnnttttiiiinnnnuuuueeee"  statements with their usual seman-
     tics.  The order in which the edges going  out  of  a  given
     state  _b_c_g__s_t_a_t_e__1  are  enumerated by this iterator is left
     unspecified.

     This iterator is available  if  _a_c_c_e_s_s__m_o_d_e  was  given  the
     value  1,  3, or 4 when the BCG file associated to _b_c_g__g_r_a_p_h
     was opened using BBBBCCCCGGGG____OOOOTTTT____RRRREEEEAAAADDDD____BBBBCCCCGGGG____BBBBEEEEGGGGIIIINNNN(((()))).



(C) INRIA            Last change: 2013/09/09                    7






CADP MANUAL PAGES                                 BCG_READ(LOCAL)



     There are  several  others  iterators  available.  They  are
     defined in file "$$$$CCCCAAAADDDDPPPP////iiiinnnnccccllll////bbbbccccgggg____iiiitttteeeerrrraaaattttoooorrrr....hhhh".

      ............................................................

  BBBBCCCCGGGG____OOOOTTTT____RRRREEEEAAAADDDD____BBBBCCCCGGGG____EEEENNNNDDDD

      BBBBCCCCGGGG____TTTTYYYYPPPPEEEE____BBBBOOOOOOOOLLLLEEEEAAAANNNN BBBBCCCCGGGG____OOOOTTTT____RRRREEEEAAAADDDD____BBBBCCCCGGGG____EEEENNNNDDDD ((((_b_c_g__g_r_a_p_h))));;;;
      BBBBCCCCGGGG____TTTTYYYYPPPPEEEE____OOOOBBBBJJJJEEEECCCCTTTT____TTTTRRRRAAAANNNNSSSSIIIITTTTIIIIOOOONNNN *_b_c_g__g_r_a_p_h;;;;
       {{{{ ............ }}}}

     This function closes a BCG graph and erases the contents  of
     the *_b_c_g__g_r_a_p_h data structure.

      ............................................................

EEEEXXXXAAAAMMMMPPPPLLLLEEEE
     #include "bcg_user.h"

     /* The following function prints information about a BCG graph */

     void bcg_print_info (bcg_graph)
     BCG_TYPE_OBJECT_TRANSITION bcg_graph;
     {
        printf ("initial state = %lu\n", BCG_OT_INITIAL_STATE (bcg_graph));
        printf ("nb states = %lu\n", BCG_OT_NB_STATES (bcg_graph));
        printf ("nb edges = %lu\n", BCG_OT_NB_EDGES (bcg_graph));
        printf ("nb labels = %u\n", BCG_OT_NB_LABELS (bcg_graph));
     }


























(C) INRIA            Last change: 2013/09/09                    8






CADP MANUAL PAGES                                 BCG_READ(LOCAL)



     /* The following function displays an edge */

     void bcg_print_edge (bcg_graph, bcg_state_1, bcg_label_number, bcg_state_2)
     BCG_TYPE_OBJECT_TRANSITION bcg_graph;
     BCG_TYPE_STATE_NUMBER bcg_state_1;
     BCG_TYPE_LABEL_NUMBER bcg_label_number;
     BCG_TYPE_STATE_NUMBER bcg_state_2;
     {
        BCG_TYPE_C_STRING bcg_label_string;
        BCG_TYPE_BOOLEAN bcg_visible;
        BCG_TYPE_NATURAL bcg_cardinal;
        BCG_TYPE_C_STRING bcg_gate;

        bcg_label_string = BCG_OT_LABEL_STRING (bcg_graph, bcg_label_number);
        bcg_visible = BCG_OT_LABEL_VISIBLE (bcg_graph, bcg_label_number);
        bcg_cardinal = BCG_OT_LABEL_CARDINAL (bcg_graph, bcg_label_number);

        printf ("transition from state %lu to state %lu\n",
                bcg_state_1, bcg_state_2);
        printf ("label unique number = %u\n", bcg_label_number);
        printf ("label string = %s\n", bcg_label_string);
        printf ("label cardinal = %u\n", bcg_cardinal);
        if (bcg_visible) {
           bcg_gate = BCG_OT_LABEL_GATE (bcg_graph, bcg_label_number);
           printf ("visible label (gate = %s)\n", bcg_gate);
        } else {
           bcg_gate = BCG_OT_LABEL_HIDDEN_GATE (bcg_graph, bcg_label_number);
           printf ("hidden label (hidden gate = %s)\n", bcg_gate);
        }
     }

     int main ()
     {
        BCG_TYPE_OBJECT_TRANSITION bcg_graph;
        BCG_TYPE_STATE_NUMBER bcg_s1;
        BCG_TYPE_LABEL_NUMBER bcg_label_number;
        BCG_TYPE_STATE_NUMBER bcg_s2;
        BCG_TYPE_STATE_NUMBER bcg_nb_states;

        BCG_INIT ();

        /* The following fragment of code reads and prints all the edges
           of a BCG graph, in an undefined order */

        BCG_OT_READ_BCG_BEGIN ("test.bcg", &bcg_graph, 0);
        bcg_print_info (bcg_graph);
        BCG_OT_ITERATE_PLN (bcg_graph, bcg_s1, bcg_label_number, bcg_s2) {
           bcg_print_edge (bcg_graph, bcg_s1, bcg_label_number, bcg_s2);
        } BCG_OT_END_ITERATE;
        BCG_OT_READ_BCG_END (&bcg_graph);





(C) INRIA            Last change: 2013/09/09                    9






CADP MANUAL PAGES                                 BCG_READ(LOCAL)



        /* The following fragment of code reads and prints all the edges
           of a BCG graph, sorted by origin states in increasing order */

        BCG_OT_READ_BCG_BEGIN ("test.bcg", &bcg_graph, 1);
        bcg_print_info (bcg_graph);
        bcg_nb_states = BCG_OT_NB_STATES (bcg_graph);
        for (bcg_s1 = 0; bcg_s1 < bcg_nb_states; bcg_s1++) {
           printf ("successors of state %lu:\n", bcg_s1);
           BCG_OT_ITERATE_P_LN (bcg_graph, bcg_s1, bcg_label_number, bcg_s2) {
             bcg_print_edge (bcg_graph, bcg_s1, bcg_label_number, bcg_s2);
           } BCG_OT_END_ITERATE;
        }
        BCG_OT_READ_BCG_END (&bcg_graph);
        exit (0);
     }


CCCCOOOOMMMMPPPPIIIILLLLIIIINNNNGGGG AAAANNNNDDDD LLLLIIIINNNNKKKK EEEEDDDDIIIITTTTIIIINNNNGGGG
     To compile the application tool, the following options  must
     be passed to the C or C++ compiler:

     ----IIII$$$$CCCCAAAADDDDPPPP////iiiinnnnccccllll ----LLLL$$$$CCCCAAAADDDDPPPP////bbbbiiiinnnn....````$$$$CCCCAAAADDDDPPPP////ccccoooommmm////aaaarrrrcccchhhh```` ----llllBBBBCCCCGGGG____IIIIOOOO ----llllBBBBCCCCGGGG ----llllmmmm

     as in, e.g.,

        $CADP/src/com/cadp_cc tool.c -o tool -I$CADP/incl \
        -L$CADP/bin.`$CADP/com/arch` -lBCG_IO -lBCG -lm


EEEEXXXXIIIITTTT SSSSTTTTAAAATTTTUUUUSSSS
     Application tools share common conventions with  respect  to
     diagnostics.   Exit  status is 0 if everything is alright, 1
     otherwise.


AAAAUUUUTTTTHHHHOOOORRRRSSSS
     Hubert Garavel (definition of the  BCG  format)  and  Renaud
     Ruffiot (implementation of the BCG environment).


FFFFIIIILLLLEEEESSSS
     See the bbbbccccgggg(LOCAL) manual page  for  a  description  of  the
     files.


SSSSEEEEEEEE AAAALLLLSSSSOOOO
     bbbbccccgggg(LOCAL)

     Additional information is available from the CADP  Web  page
     located at http://cadp.inria.fr





(C) INRIA            Last change: 2013/09/09                   10






CADP MANUAL PAGES                                 BCG_READ(LOCAL)



     Directives   for   installation   are   given    in    files
     $$$$CCCCAAAADDDDPPPP////IIIINNNNSSSSTTTTAAAALLLLLLLLAAAATTTTIIIIOOOONNNN____****....

     Recent  changes  and  improvements  to  this  software   are
     reported and commented in file $$$$CCCCAAAADDDDPPPP////HHHHIIIISSSSTTTTOOOORRRRYYYY....


BBBBUUUUGGGGSSSS
     Please report bugs to Hubert.Garavel@inria.fr














































(C) INRIA            Last change: 2013/09/09                   11



