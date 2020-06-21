


CADP MANUAL PAGES                                 EXECUTOR(LOCAL)



NNNNAAAAMMMMEEEE
     executor - random execution


SSSSYYYYNNNNOOOOPPPPSSSSIIIISSSS
     bbbbccccgggg____ooooppppeeeennnn    [_b_c_g__o_p_t]    _s_p_e_c[....bbbbccccgggg]    [_c_c__o_p_t]     eeeexxxxeeeeccccuuuuttttoooorrrr
     [_e_x_e_c_u_t_o_r__o_p_t] _e_x_e_c_u_t_o_r__p_a_r_a_m

     or:

     eeeexxxxpppp....ooooppppeeeennnn    [_e_x_p__o_p_t]    _s_p_e_c[....eeeexxxxpppp]    [_c_c__o_p_t]     eeeexxxxeeeeccccuuuuttttoooorrrr
     [_e_x_e_c_u_t_o_r__o_p_t] _e_x_e_c_u_t_o_r__p_a_r_a_m

     or:

     ffffsssspppp....ooooppppeeeennnn    [_f_s_p__o_p_t]    _s_p_e_c[....llllttttssss]    [_c_c__o_p_t]     eeeexxxxeeeeccccuuuuttttoooorrrr
     [_e_x_e_c_u_t_o_r__o_p_t] _e_x_e_c_u_t_o_r__p_a_r_a_m

     or:

     llllnnnntttt....ooooppppeeeennnn    [_l_n_t__o_p_t]    _s_p_e_c[....llllnnnntttt]    [_c_c__o_p_t]     eeeexxxxeeeeccccuuuuttttoooorrrr
     [_e_x_e_c_u_t_o_r__o_p_t] _e_x_e_c_u_t_o_r__p_a_r_a_m

     or:

     lllloooottttoooossss....ooooppppeeeennnn  [_l_o_t_o_s__o_p_t]   _s_p_e_c[....lllloooottttoooossss]   [_c_c__o_p_t]   eeeexxxxeeeeccccuuuuttttoooorrrr
     [_e_x_e_c_u_t_o_r__o_p_t] _e_x_e_c_u_t_o_r__p_a_r_a_m

     or:

     sssseeeeqqqq....ooooppppeeeennnn    [_s_e_q__o_p_t]    _s_p_e_c[....sssseeeeqqqq]    [_c_c__o_p_t]     eeeexxxxeeeeccccuuuuttttoooorrrr
     [_e_x_e_c_u_t_o_r__o_p_t] _e_x_e_c_u_t_o_r__p_a_r_a_m


DDDDEEEESSSSCCCCRRRRIIIIPPPPTTTTIIIIOOOONNNN
     This  program  explores  the  labelled   transition   system
     corresponding  to  the  BCG  graph _s_p_e_c....bbbbccccgggg, the composition
     expression _s_p_e_c....eeeexxxxpppp, the FSP program _s_p_e_c....llllttttssss, the LNT  pro-
     gram _s_p_e_c....llllnnnntttt, the LOTOS program _s_p_e_c....lllloooottttoooossss, or the sequence
     file _s_p_e_c....sssseeeeqqqq, and produces a random execution sequence.

     Visible labels in the execution sequence  are  displayed  as
     the  corresponding  transitions  are fired. Invisible labels
     (noted ``iiii'') are not displayed.

     The execution sequence is displayed using the full SEQ  for-
     mat  (see  the sssseeeeqqqq(LOCAL) man page for a description of this
     format).

     Various strategies are currently  available  to  solve  non-
     determinism:




(C) INRIA            Last change: 2020/02/12                    1






CADP MANUAL PAGES                                 EXECUTOR(LOCAL)



     (1): Non-determinism is not allowed. The program  will  stop
          if the current state has more than one successor.


     (2): Non-determinism is allowed. If the  current  state  has
          several  successors,  one  of  them is selected using a
          pseudo-random number generator. The seed of the genera-
          tor is initialized using the system clock.


     (3): Same as strategy (2), except that the seed of the  gen-
          erator  is  provided  by  the  user, in order to obtain
          reproducible execution sequences.


OOOOPPPPTTTTIIIIOOOONNNNSSSS
     The options _b_c_g__o_p_t, if any, are passed to bbbbccccgggg____lllliiiibbbb(LOCAL).


     The options _e_x_p__o_p_t, if any, are passed to eeeexxxxpppp....ooooppppeeeennnn(LOCAL).


     The options _f_s_p__o_p_t, if any, are passed to ffffsssspppp....ooooppppeeeennnn(LOCAL).


     The options _l_n_t__o_p_t, if any, are passed to llllnnnntttt....ooooppppeeeennnn(LOCAL).


     The options _l_o_t_o_s__o_p_t, if any, are passed  to  ccccaaaaeeeessssaaaarrrr(LOCAL)
     and to ccccaaaaeeeessssaaaarrrr....aaaaddddtttt(LOCAL).


     The options _s_e_q__o_p_t, if any, are passed to sssseeeeqqqq....ooooppppeeeennnn(LOCAL).


     The options _c_c__o_p_t, if any, are passed to the C compiler.


     The following options _e_x_e_c_u_t_o_r__o_p_t are currently available:

     ----hhhhiiiiddddeeee [[[[ ----ttttoooottttaaaallll |||| ----ppppaaaarrrrttttiiiiaaaallll |||| ----ggggaaaatttteeee ]]]] _h_i_d_i_n_g__f_i_l_e_n_a_m_e
          Use the hiding rules defined in _h_i_d_i_n_g__f_i_l_e_n_a_m_e to hide
          (on the fly) the labels of the Labelled Transition Sys-
          tem  being  generated.  See  the   ccccaaaaeeeessssaaaarrrr____hhhhiiiiddddeeee____1111(LOCAL)
          manual page for a detailed description of the appropri-
          ate format for _h_i_d_i_n_g__f_i_l_e_n_a_m_e.

          The ----ttttoooottttaaaallll, ----ppppaaaarrrrttttiiiiaaaallll, and  ----ggggaaaatttteeee  options  specify  the
          "total  matching", "partial matching", and "gate match-
          ing"     semantics,     respectively.      See      the
          ccccaaaaeeeessssaaaarrrr____hhhhiiiiddddeeee____1111(LOCAL) manual page for more details about
          these semantics. Option ----ttttoooottttaaaallll is the default.



(C) INRIA            Last change: 2020/02/12                    2






CADP MANUAL PAGES                                 EXECUTOR(LOCAL)



     ----rrrreeeennnnaaaammmmeeee [[[[----ttttoooottttaaaallll||||----ssssiiiinnnngggglllleeee||||----mmmmuuuullllttttiiiipppplllleeee||||----ggggaaaatttteeee]]]] _r_e_n_a_m_i_n_g__f_i_l_e_n_a_m_e
          Use the renaming rules defined in _r_e_n_a_m_i_n_g__f_i_l_e_n_a_m_e  to
          rename  (on the fly) the labels of the Labelled Transi-
          tion    System     being     generated.     See     the
          ccccaaaaeeeessssaaaarrrr____rrrreeeennnnaaaammmmeeee____1111(LOCAL)   manual  page  for  a  detailed
          description   of    the    appropriate    format    for
          _r_e_n_a_m_i_n_g__f_i_l_e_n_a_m_e.

          The  ----ttttoooottttaaaallll,  ----ssssiiiinnnngggglllleeee,  ----mmmmuuuullllttttiiiipppplllleeee,  and  ----ggggaaaatttteeee  options
          specify  the  "total  matching", "single partial match-
          ing", "multiple partial matching", and "gate  matching"
          semantics, respectively. See the ccccaaaaeeeessssaaaarrrr____rrrreeeennnnaaaammmmeeee____1111(LOCAL)
          manual page for more  details  about  these  semantics.
          Option ----ttttoooottttaaaallll is the default.


     The parameters _e_x_e_c_u_t_o_r__p_a_r_a_m have  the  following  formats,
     where  _d_e_p_t_h  is  an  integer denoting the maximal number of
     transitions to be fired (if _d_e_p_t_h = 0,  no  upper  bound  is
     fixed)  and  where  _s_e_e_d is an integer denoting the value of
     the chosen seed:


     *    If _e_x_e_c_u_t_o_r__p_a_r_a_m =  _d_e_p_t_h 1111
          => strategy (1): deterministic execution

     *    If _e_x_e_c_u_t_o_r__p_a_r_a_m =  _d_e_p_t_h 2222
          => strategy (2): non-deterministic with random seed

     *    If _e_x_e_c_u_t_o_r__p_a_r_a_m =  _d_e_p_t_h 3333 _s_e_e_d
          => strategy (3): non-deterministic with chosen seed

     *    If _e_x_e_c_u_t_o_r__p_a_r_a_m is empty
          => interactive mode.


EEEEXXXXIIIITTTT SSSSTTTTAAAATTTTUUUUSSSS
     When the source is erroneous,  error  messages  are  issued.
     Exit status is 0 if everything is alright, 1 otherwise.


AAAAUUUUTTTTHHHHOOOORRRR
     Hubert Garavel (INRIA Rhone-Alpes)


FFFFIIIILLLLEEEESSSS
     _s_p_e_c....bbbbccccgggg            BCG graph (input)
     _s_p_e_c....eeeexxxxpppp            network of communicating LTSs (input)
     _s_p_e_c....llllttttssss            FSP specification (input)
     _s_p_e_c....llllnnnntttt            LNT specification (input)
     _s_p_e_c....lllloooottttoooossss          LOTOS specification (input)
     _s_p_e_c....sssseeeeqqqq            sequence file (input)



(C) INRIA            Last change: 2020/02/12                    3






CADP MANUAL PAGES                                 EXECUTOR(LOCAL)



     The  source  code  of  this  tool  is  available   in   file
     $$$$CCCCAAAADDDDPPPP////ssssrrrrcccc////ooooppppeeeennnn____ccccaaaaeeeessssaaaarrrr////eeeexxxxeeeeccccuuuuttttoooorrrr....cccc

SSSSEEEEEEEE AAAALLLLSSSSOOOO
     OPEN/CAESAR Reference Manual,  bbbbccccgggg____ooooppppeeeennnn(LOCAL),  bbbbccccgggg(LOCAL),
     ccccaaaaeeeessssaaaarrrr(LOCAL),         ccccaaaaeeeessssaaaarrrr....aaaaddddtttt(LOCAL),        eeeexxxxpppp(LOCAL),
     eeeexxxxpppp....ooooppppeeeennnn(LOCAL),      ffffsssspppp....ooooppppeeeennnn(LOCAL),      llllnnnntttt....ooooppppeeeennnn(LOCAL),
     lllloooottttoooossss(LOCAL), lllloooottttoooossss....ooooppppeeeennnn(LOCAL), sssseeeeqqqq(LOCAL), sssseeeeqqqq....ooooppppeeeennnn(LOCAL)

     Additional information is available from the CADP  Web  page
     located at http://cadp.inria.fr

     Directives   for   installation   are   given    in    files
     $$$$CCCCAAAADDDDPPPP////IIIINNNNSSSSTTTTAAAALLLLLLLLAAAATTTTIIIIOOOONNNN____****....

     Recent  changes  and  improvements  to  this  software   are
     reported and commented in file $$$$CCCCAAAADDDDPPPP////HHHHIIIISSSSTTTTOOOORRRRYYYY....


BBBBUUUUGGGGSSSS
     Please report new bugs to Hubert.Garavel@inria.fr


































(C) INRIA            Last change: 2020/02/12                    4



