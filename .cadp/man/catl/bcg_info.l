


CADP MANUAL PAGES                                 BCG_INFO(LOCAL)



NNNNAAAAMMMMEEEE
     bcg_info - display information about graphs encoded  in  the
     BCG format


SSSSYYYYNNNNOOOOPPPPSSSSIIIISSSS
     bbbbccccgggg____iiiinnnnffffoooo [ _b_c_g__o_p_t_i_o_n_s ] [ -bbbbrrrraaaannnncccchhhhiiiinnnngggg  ]  [  -ddddeeeeaaaaddddlllloooocccckkkk  ]  [
     -ffffoooorrrrmmmmaaaatttt  ]  [  -hhhhiiiiddddddddeeeennnn  ]  [  -llllaaaabbbbeeeellllssss  ] [ -nnnnoooonnnnddddeeeetttteeeerrrrmmmmiiiinnnniiiissssttttiiiicccc
     _l_a_b_e_l__n_u_m_b_e_r ] [ -oooorrrrddddeeeerrrr ] [ -ppppaaaatttthhhh _s_t_a_t_e__n_u_m_b_e_r ] [ -pppprrrrooooffffiiiilllleeeessss
     ] [ -ssssiiiizzzzeeee ] [ -uuuunnnnrrrreeeeaaaacccchhhhaaaabbbblllleeee ] [ -ccccoooommmmppppaaaacccctttt |||| -vvvveeeerrrrbbbboooosssseeee |||| -lllliiiinnnneeee ]
     _f_i_l_e_n_a_m_e[[[[....bbbbccccgggg]]]]


DDDDEEEESSSSCCCCRRRRIIIIPPPPTTTTIIIIOOOONNNN
     This command takes as input the BCG graph  _f_i_l_e_n_a_m_e....bbbbccccgggg  and
     displays  various  information  (number of states, number of
     transitions, number of labels, etc.) about this graph.

     A dynamic library corresponding to _f_i_l_e_n_a_m_e....bbbbccccgggg may be  gen-
     erated if necessary.


GGGGEEEENNNNEEEERRRRAAAALLLL OOOOPPPPTTTTIIIIOOOONNNNSSSS
     The following _b_c_g__o_p_t_i_o_n_s are currently supported: ----vvvveeeerrrrssssiiiioooonnnn,
     ----ccccrrrreeeeaaaatttteeee, ----uuuuppppddddaaaatttteeee, ----rrrreeeemmmmoooovvvveeee, ----cccccccc, and ----ttttmmmmpppp. See the bbbbccccgggg(LOCAL)
     manual page for a description of these options.


PPPPAAAARRRRTTTTIIIICCCCUUUULLLLAAAARRRR OOOOPPPPTTTTIIIIOOOONNNNSSSS
     The following options are also supported:


     -bbbbrrrraaaannnncccchhhhiiiinnnngggg
          Display statistics about the  branching  factor,  i.e.,
          the average, minimal, and maximal number of transitions
          going out of the states.


     -ddddeeeeaaaaddddlllloooocccckkkk
          Display the list of deadlock states. The output of this
          command can be controlled using the ----ccccoooommmmppppaaaacccctttt, ----vvvveeeerrrrbbbboooosssseeee,
          and ----lllliiiinnnneeee options (see below).


     -ffffoooorrrrmmmmaaaatttt
          Display the BCG format version number (e.g., 1.0,  1.1)
          used for _f_i_l_e_n_a_m_e[[[[....bbbbccccgggg]]]]


     -hhhhiiiiddddddddeeeennnn
          Display the number of hidden (i.e., `tau') transitions.




(C) INRIA            Last change: 2019/01/09                    1






CADP MANUAL PAGES                                 BCG_INFO(LOCAL)



     -llllaaaabbbbeeeellllssss
          Display the number of labels followed by  the  list  of
          labels.


     -nnnnoooonnnnddddeeeetttteeeerrrrmmmmiiiinnnniiiissssttttiiiicccc _l_a_b_e_l__s_t_r_i_n_g
          Display the list of states in which there is  nondeter-
          minism  for  label  _l_a_b_e_l__s_t_r_i_n_g,  i.e.,  the states in
          which there  are  at  least  two  outgoing  transitions
          labelled  by  _l_a_b_e_l__s_t_r_i_n_g. If _l_a_b_e_l__s_t_r_i_n_g is equal to
          the special string `-',  then  nondeterministic  states
          are searched for each label. The output of this command
          can be controlled using  the  ----ccccoooommmmppppaaaacccctttt,  ----vvvveeeerrrrbbbboooosssseeee,  and
          ----lllliiiinnnneeee options (see below).


     -oooorrrrddddeeeerrrr
          Display information about the order  in  which  transi-
          tions  are sorted (depending on source states, destina-
          tion states and label numbers)


     -ppppaaaatttthhhh _s_t_a_t_e__n_u_m_b_e_r
          Display the shortest path from the initial state to the
          state  given  by  _s_t_a_t_e__n_u_m_b_e_r.  The  path is displayed
          using the simple SEQ format  (see  the  sssseeeeqqqq(LOCAL)  man
          page for a description of this format).


     -pppprrrrooooffffiiiilllleeeessss
          Undocumented option.


     -ssssiiiizzzzeeee
          Display the number of states and transitions on a  sin-
          gle line.


     -uuuunnnnrrrreeeeaaaacccchhhhaaaabbbblllleeee
          Display the list of states that cannot be reached  from
          the  initial  state  of  the graph (this list should be
          empty if the graph is connected). The  output  of  this
          command can be controlled using the ----ccccoooommmmppppaaaacccctttt, ----vvvveeeerrrrbbbboooosssseeee,
          and ----lllliiiinnnneeee options (see below).


     -ccccoooommmmppppaaaacccctttt
          Display lists of states in a  user-friendly,  synthetic
          form.  There  are about ten state numbers per line and,
          whenever possible, a shorthand notation `_M  ...  _N'  is
          used to indicate all state numbers in the range between
          _M and _N. Default option.



(C) INRIA            Last change: 2019/01/09                    2






CADP MANUAL PAGES                                 BCG_INFO(LOCAL)



     -vvvveeeerrrrbbbboooosssseeee
          Similar to -compact option, except that  the  shorthand
          notation `...' is not used. Not a default option.


     -lllliiiinnnneeee
          Display lists of states in a simple form, with only one
          state number per line. Not a default option.


EEEENNNNVVVVIIIIRRRROOOONNNNMMMMEEEENNNNTTTT VVVVAAAARRRRIIIIAAAABBBBLLLLEEEESSSS
     See the bbbbccccgggg(LOCAL) manual page  for  a  description  of  the
     environment variables used by all the BCG application tools.



EEEEXXXXIIIITTTT SSSSTTTTAAAATTTTUUUUSSSS
     Exit status is 0 if everything is alright, 1 otherwise.


AAAAUUUUTTTTHHHHOOOORRRRSSSS
     Hubert Garavel, Bruno Ondet, and Damien Bergamini


OOOOPPPPEEEERRRRAAAANNNNDDDDSSSS
     _f_i_l_e_n_a_m_e....bbbbccccgggg             BCG graph (input)
     _f_i_l_e_n_a_m_e@@@@1111....oooo             dynamic library (input or output)


FFFFIIIILLLLEEEESSSS
     $$$$CCCCAAAADDDDPPPP////ccccoooommmm////bbbbccccgggg____iiiinnnnffffoooo              ``bbbbccccgggg____iiiinnnnffffoooo'' shell script
     $$$$CCCCAAAADDDDPPPP////bbbbiiiinnnn....````aaaarrrrcccchhhh````////lllliiiibbbbbbbbccccgggg____iiiinnnnffffoooo....aaaa  ``bbbbccccgggg____iiiinnnnffffoooo'' static library

     See the bbbbccccgggg(LOCAL) manual page  for  a  description  of  the
     other files.


SSSSEEEEEEEE AAAALLLLSSSSOOOO
     bbbbccccgggg(LOCAL), bbbbccccgggg____rrrreeeeaaaadddd(LOCAL), sssseeeeqqqq(LOCAL)

     Additional information is available from the CADP  Web  page
     located at http://cadp.inria.fr

     Directives   for   installation   are   given    in    files
     $$$$CCCCAAAADDDDPPPP////IIIINNNNSSSSTTTTAAAALLLLLLLLAAAATTTTIIIIOOOONNNN____****.

     Recent  changes  and  improvements  to  this  software   are
     reported and commented in file $$$$CCCCAAAADDDDPPPP////HHHHIIIISSSSTTTTOOOORRRRYYYY.


BBBBUUUUGGGGSSSS
     Please report bugs to Hubert.Garavel@inria.fr



(C) INRIA            Last change: 2019/01/09                    3



