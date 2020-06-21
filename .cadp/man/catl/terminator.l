


CADP MANUAL PAGES                               TERMINATOR(LOCAL)



NNNNAAAAMMMMEEEE
     terminator - deadlock detection


SSSSYYYYNNNNOOOOPPPPSSSSIIIISSSS
     bbbbccccgggg____ooooppppeeeennnn   [_b_c_g__o_p_t]    _s_p_e_c[....bbbbccccgggg]    [_c_c__o_p_t]    tttteeeerrrrmmmmiiiinnnnaaaattttoooorrrr
     [_t_e_r_m_i_n_a_t_o_r__o_p_t] _t_e_r_m_i_n_a_t_o_r__p_a_r_a_m

     or:

     eeeexxxxpppp....ooooppppeeeennnn   [_e_x_p__o_p_t]    _s_p_e_c[....eeeexxxxpppp]    [_c_c__o_p_t]    tttteeeerrrrmmmmiiiinnnnaaaattttoooorrrr
     [_t_e_r_m_i_n_a_t_o_r__o_p_t] _t_e_r_m_i_n_a_t_o_r__p_a_r_a_m

     or:

     ffffsssspppp....ooooppppeeeennnn   [_f_s_p__o_p_t]    _s_p_e_c[....llllttttssss]    [_c_c__o_p_t]    tttteeeerrrrmmmmiiiinnnnaaaattttoooorrrr
     [_t_e_r_m_i_n_a_t_o_r__o_p_t] _t_e_r_m_i_n_a_t_o_r__p_a_r_a_m

     or:

     llllnnnntttt....ooooppppeeeennnn   [_l_n_t__o_p_t]    _s_p_e_c[....llllnnnntttt]    [_c_c__o_p_t]    tttteeeerrrrmmmmiiiinnnnaaaattttoooorrrr
     [_t_e_r_m_i_n_a_t_o_r__o_p_t] _t_e_r_m_i_n_a_t_o_r__p_a_r_a_m

     or:

     lllloooottttoooossss....ooooppppeeeennnn  [_l_o_t_o_s__o_p_t]  _s_p_e_c[....lllloooottttoooossss]  [_c_c__o_p_t]   tttteeeerrrrmmmmiiiinnnnaaaattttoooorrrr
     [_t_e_r_m_i_n_a_t_o_r__o_p_t] _t_e_r_m_i_n_a_t_o_r__p_a_r_a_m

     or:

     sssseeeeqqqq....ooooppppeeeennnn   [_s_e_q__o_p_t]    _s_p_e_c[....sssseeeeqqqq]    [_c_c__o_p_t]    tttteeeerrrrmmmmiiiinnnnaaaattttoooorrrr
     [_t_e_r_m_i_n_a_t_o_r__o_p_t] _t_e_r_m_i_n_a_t_o_r__p_a_r_a_m


DDDDEEEESSSSCCCCRRRRIIIIPPPPTTTTIIIIOOOONNNN
     This program  attempts  to  detect  deadlocks  (i.e.  states
     without  successors) in the BCG graph _s_p_e_c....bbbbccccgggg, the composi-
     tion expression _s_p_e_c....eeeexxxxpppp, the FSP program _s_p_e_c....llllttttssss, the  LNT
     program  _s_p_e_c....llllnnnntttt,  the  LOTOS  program  _s_p_e_c....lllloooottttoooossss,  or the
     sequence file _s_p_e_c....sssseeeeqqqq.  It is  based  on  the  ``bit  state
     space'' verification technique proposed by Gerard Holzmann.

     When the program detects deadlock states, it displays  diag-
     nostic sequences, i.e., execution sequences leading from the
     initial state to the deadlock states.  Diagnostic  sequences
     are   displayed   using  the  simple  SEQ  format  (see  the
     sssseeeeqqqq(LOCAL) man page for a description of this format).

     Note: the deadlock detection performed using this  technique
     is  partial:  due  to  potential  hash-code collisions, some
     states may not be visited. Therefore, this program is likely
     to  find  only  a subset of the existing deadlocks. It might



(C) INRIA            Last change: 2020/02/12                    1






CADP MANUAL PAGES                               TERMINATOR(LOCAL)



     even fail to find deadlocks when they exist.

     Note: in its first form (i.e., when applied to the BCG graph
     _s_p_e_c....bbbbccccgggg), this program is probably not the best way to per-
     form deadlock detection.

     Note: the eeeexxxxhhhhiiiibbbbiiiittttoooorrrr(LOCAL) program can also be used to  find
     the shortest sequence leading to a deadlock.


OOOOPPPPTTTTIIIIOOOONNNNSSSS
     The options _b_c_g__o_p_t, if any, are passed to bbbbccccgggg____lllliiiibbbb(LOCAL).


     The options _e_x_p__o_p_t, if any, are passed to eeeexxxxpppp....ooooppppeeeennnn(LOCAL).


     The options _f_s_p__o_p_t, if any, are passed to ffffsssspppp....ooooppppeeeennnn(LOCAL).


     The options _l_n_t__o_p_t, if any, are passed to llllnnnntttt....ooooppppeeeennnn(LOCAL).


     The options _l_o_t_o_s__o_p_t, if any, are passed  to  ccccaaaaeeeessssaaaarrrr(LOCAL)
     and to ccccaaaaeeeessssaaaarrrr....aaaaddddtttt(LOCAL).


     The options _s_e_q__o_p_t, if any, are passed to sssseeeeqqqq....ooooppppeeeennnn(LOCAL).


     The options _c_c__o_p_t, if any, are passed to the C compiler.


     The following _t_e_r_m_i_n_a_t_o_r__o_p_t_i_o_n_s are currently available:


     ----ddddeeeepppptttthhhh _d_e_p_t_h
          Consider only execution sequences whose number of tran-
          sitions  is  less  or  equal than _d_e_p_t_h (where _d_e_p_t_h is
          greater than zero). Prune the exploration of the  graph
          when  the  distance  from  the  initial  state  becomes
          greater than _d_e_p_t_h transitions.  By  default  (if  this
          option  is not present on the command-line) or if _d_e_p_t_h
          is equal to zero, all sequences will be considered.

     ----nnnnoooonnnneeee
          Don't print any  diagnostic  sequence.  Not  a  default
          option.

     ----aaaallllllll
          Print all diagnostic sequences. Not a default option.




(C) INRIA            Last change: 2020/02/12                    2






CADP MANUAL PAGES                               TERMINATOR(LOCAL)



     ----ffffiiiirrrrsssstttt
          Print the first  diagnostic  sequence  encountered  and
          stop just after.  Not a default option.

     ----ddddeeeeccccrrrr
          Print only those diagnostic sequences which are shorter
          than  the last diagnostic sequence previously diplayed.
          Prune the exploration of the graph  in  order  to  find
          diagnostic  sequences  of  decreasing sizes.  It is not
          guaranteed that the final  sequence  is  minimal  (some
          shorter sequence might exist, which can not be found by
          the program).

     _b_y _d_e_f_a_u_l_t
          (in absence of ----nnnnoooonnnneeee, ----aaaallllllll, ----ffffiiiirrrrsssstttt, ----ddddeeeeccccrrrr)
          Print only the shortest diagnostic  sequence  obtained.
          Prune  the  exploration  of  the graph in order to find
          diagnostic sequences of decreasing sizes.   It  is  not
          guaranteed  that  the  final  sequence is minimal (some
          shorter sequence might exist, which can not be found by
          the program).

     The parameters _t_e_r_m_i_n_a_t_o_r__p_a_r_a_m have the following  formats,
     where  _o_r_d_e_r  is  an integer denoting the order in which the
     transitions     will     be     fired     (see     functions
     CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTEEEE____EEEEDDDDGGGGEEEE____LLLLIIIISSSSTTTT(((())))  and  CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTEEEE____SSSSTTTTAAAACCCCKKKK____1111(((()))),  in
     the  ccccaaaaeeeessssaaaarrrr____eeeeddddggggeeee(LOCAL)  and  ccccaaaaeeeessssaaaarrrr____ssssttttaaaacccckkkk____1111(LOCAL)   manual
     pages),  and  where  _s_i_z_e,  _s_i_z_e__1,  and  _s_i_z_e__2 are integer
     numbers denoting the sizes of bitmap tables:

     *    If _t_e_r_m_i_n_a_t_o_r__p_a_r_a_m = _o_r_d_e_r _s_i_z_e
          => automatic search using a single  bitmap  table  with
          _s_i_z_e  entries.  If _s_i_z_e is equal to zero, then the bit-
          map table will be as large as possible, within the lim-
          its of the available computer memory.

     *    If _t_e_r_m_i_n_a_t_o_r__p_a_r_a_m = _o_r_d_e_r _s_i_z_e__1 _s_i_z_e__2
          => automatic search using two bitmap tables with _s_i_z_e__1
          and _s_i_z_e__2 entries, respectively.

     *    If _t_e_r_m_i_n_a_t_o_r__p_a_r_a_m is empty
          => interactive mode.


EEEEXXXXIIIITTTT SSSSTTTTAAAATTTTUUUUSSSS
     Exit status is 0 if everything is alright, 1 otherwise.


DDDDIIIIAAAAGGGGNNNNOOOOSSSSTTTTIIIICCCCSSSS
     When the source is erroneous, error messages are issued.





(C) INRIA            Last change: 2020/02/12                    3






CADP MANUAL PAGES                               TERMINATOR(LOCAL)



AAAAUUUUTTTTHHHHOOOORRRR
     Hubert Garavel (INRIA Rhone-Alpes)


OOOOPPPPEEEERRRRAAAANNNNDDDDSSSS
     _s_p_e_c....bbbbccccgggg            BCG graph (input)
     _s_p_e_c....eeeexxxxpppp            network of communicating LTSs (input)
     _s_p_e_c....llllttttssss            FSP specification (input)
     _s_p_e_c....llllnnnntttt            LNT specification (input)
     _s_p_e_c....lllloooottttoooossss          LOTOS specification (input)
     _s_p_e_c....sssseeeeqqqq            sequence file (input)


FFFFIIIILLLLEEEESSSS
     The  source  code  of  this  tool  is  available   in   file
     $$$$CCCCAAAADDDDPPPP////ssssrrrrcccc////ooooppppeeeennnn____ccccaaaaeeeessssaaaarrrr////tttteeeerrrrmmmmiiiinnnnaaaattttoooorrrr....cccc

SSSSEEEEEEEE AAAALLLLSSSSOOOO
     OPEN/CAESAR Reference Manual,  bbbbccccgggg(LOCAL),  bbbbccccgggg____ooooppppeeeennnn(LOCAL),
     ccccaaaaeeeessssaaaarrrr(LOCAL),      ccccaaaaeeeessssaaaarrrr....aaaaddddtttt(LOCAL),     eeeexxxxhhhhiiiibbbbiiiittttoooorrrr(LOCAL),
     eeeexxxxpppp(LOCAL),        eeeexxxxpppp....ooooppppeeeennnn(LOCAL),         ffffsssspppp....ooooppppeeeennnn(LOCAL),
     llllnnnntttt....ooooppppeeeennnn(LOCAL),       lllloooottttoooossss(LOCAL),      lllloooottttoooossss....ooooppppeeeennnn(LOCAL),
     sssseeeeqqqq(LOCAL), sssseeeeqqqq....ooooppppeeeennnn(LOCAL)


     Additional information is available from the CADP  Web  page
     located at http://cadp.inria.fr

     Directives   for   installation   are   given    in    files
     $$$$CCCCAAAADDDDPPPP////IIIINNNNSSSSTTTTAAAALLLLLLLLAAAATTTTIIIIOOOONNNN____****....

     Recent  changes  and  improvements  to  this  software   are
     reported and commented in file $$$$CCCCAAAADDDDPPPP////HHHHIIIISSSSTTTTOOOORRRRYYYY....


BBBBUUUUGGGGSSSS
     Please report new bugs to Hubert.Garavel@inria.fr


















(C) INRIA            Last change: 2020/02/12                    4



