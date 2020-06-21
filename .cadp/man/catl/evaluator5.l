


CADP MANUAL PAGES                               EVALUATOR5(LOCAL)



NNNNAAAAMMMMEEEE
     evaluator5 - on-the-fly model checking of MCL v5 formulas


SSSSYYYYNNNNOOOOPPPPSSSSIIIISSSS
     bbbbccccgggg____ooooppppeeeennnn   [_b_c_g__o_p_t]    _s_p_e_c[....bbbbccccgggg]    [_c_c__o_p_t]    eeeevvvvaaaalllluuuuaaaattttoooorrrr5555
     [_e_v_a_l_u_a_t_o_r__o_p_t] _p_r_o_p[....mmmmccccllll]

     or:

     eeeexxxxpppp....ooooppppeeeennnn  _s_p_e_c[....eeeexxxxpppp]  [_c_c__o_p_t]  eeeevvvvaaaalllluuuuaaaattttoooorrrr5555   [_e_v_a_l_u_a_t_o_r__o_p_t]
     _p_r_o_p[....mmmmccccllll]

     or:

     ffffsssspppp....ooooppppeeeennnn   [_f_s_p__o_p_t]    _s_p_e_c[....llllttttssss]    [_c_c__o_p_t]    eeeevvvvaaaalllluuuuaaaattttoooorrrr5555
     [_e_v_a_l_u_a_t_o_r__o_p_t] _p_r_o_p[....mmmmccccllll]

     or:

     llllnnnntttt....ooooppppeeeennnn   [_l_n_t__o_p_t]    _s_p_e_c[....llllnnnntttt]    [_c_c__o_p_t]    eeeevvvvaaaalllluuuuaaaattttoooorrrr5555
     [_e_v_a_l_u_a_t_o_r__o_p_t] _p_r_o_p[....mmmmccccllll]

     or:

     lllloooottttoooossss....ooooppppeeeennnn  [_l_o_t_o_s__o_p_t]  _s_p_e_c[....lllloooottttoooossss]  [_c_c__o_p_t]   eeeevvvvaaaalllluuuuaaaattttoooorrrr5555
     [_e_v_a_l_u_a_t_o_r__o_p_t] _p_r_o_p[....mmmmccccllll]

     or:

     sssseeeeqqqq....ooooppppeeeennnn  _s_p_e_c[....sssseeeeqqqq]  [_c_c__o_p_t]  eeeevvvvaaaalllluuuuaaaattttoooorrrr5555   [_e_v_a_l_u_a_t_o_r__o_p_t]
     _p_r_o_p[....mmmmccccllll]


DDDDEEEESSSSCCCCRRRRIIIIPPPPTTTTIIIIOOOONNNN
     eeeevvvvaaaalllluuuuaaaattttoooorrrr5555 takes two inputs:


     -    A Probabilistic  Transition  System  (PTS  for  short),
          expressed either as a BCG graph _s_p_e_c....bbbbccccgggg,,,, a composition
          expression _s_p_e_c....eeeexxxxpppp,,,, an FSP program  _s_p_e_c....llllttttssss,,,,  an  LNT
          program  _s_p_e_c....llllnnnntttt,,,,  a  LOTOS  program  _s_p_e_c....lllloooottttoooossss,,,, or a
          sequence file _s_p_e_c....sssseeeeqqqq....   See  the  mmmmccccllll5555(LOCAL)  manual
          page for the definition of the PTS model.


     -    A  temporal  logic  property,  contained  in  the  file
          _p_r_o_p[....mmmmccccllll], expressed as a formula in the _M_C_L version 5
          language. See the mmmmccccllll5555(LOCAL) manual page  for  a  com-
          plete definition of the _M_C_L version 5 language.





(C) INRIA            Last change: 2020/02/12                    1






CADP MANUAL PAGES                               EVALUATOR5(LOCAL)



     eeeevvvvaaaalllluuuuaaaattttoooorrrr5555 performs an on-the-fly verification of  the  tem-
     poral property on the given PTS.  The result of this verifi-
     cation (TRUE or FALSE, preceded by the values of  probabili-
     ties  if  they  are requested by the probabilistic operators
     contained in _p_r_o_p[....mmmmccccllll]) is displayed.

     The verification method underlying eeeevvvvaaaalllluuuuaaaattttoooorrrr5555 is based  upon
     a  translation  of  the probabilistic model checking problem
     into the resolutions of a Linear Equation System (LES) and a
     Parameterized  Boolean  Equation System (PBES), as described
     in [MR18].  These resolutions are carried out simultaneously
     and  on  the  fly,  using  the  algorithms  provided  by the
     ccccaaaaeeeessssaaaarrrr____ssssoooollllvvvveeee____1111(LOCAL) and ccccaaaaeeeessssaaaarrrr____ssssoooollllvvvveeee____2222(LOCAL) libraries of
     OPEN/CAESAR  (see  the  corresponding  manual  pages and the
     articles [Mat06,MR18] for details).


OOOOPPPPTTTTIIIIOOOONNNNSSSS
     The options _b_c_g__o_p_t, if any, are passed to bbbbccccgggg____lllliiiibbbb(LOCAL).

     The options _e_x_p__o_p_t, if any, are passed to eeeexxxxpppp....ooooppppeeeennnn(LOCAL).

     The options _f_s_p__o_p_t, if any, are passed to ffffsssspppp....ooooppppeeeennnn(LOCAL).

     The options _l_n_t__o_p_t, if any, are passed to llllnnnntttt....ooooppppeeeennnn(LOCAL).

     The options _l_o_t_o_s__o_p_t, if any, are passed  to  ccccaaaaeeeessssaaaarrrr(LOCAL)
     and to ccccaaaaeeeessssaaaarrrr....aaaaddddtttt(LOCAL).

     The options _s_e_q__o_p_t, if any, are passed to sssseeeeqqqq....ooooppppeeeennnn(LOCAL).

     The options _c_c__o_p_t, if any, are passed to the C compiler.

     The options _e_v_a_l_u_a_t_o_r__o_p_t are the same as those  of  evalua-
     tor4  (see the eeeevvvvaaaalllluuuuaaaattttoooorrrr4444(LOCAL) manual page), with the fol-
     lowing addition:


     ----eeeeppppssssiiiilllloooonnnn _e_p_s
          Set the precision of certain floating-point comparisons
          to  _e_p_s,  where _e_p_s is a real value. When _e_p_s is out of
          [0..1[, eeeevvvvaaaalllluuuuaaaattttoooorrrr5555 reports an error. Default value  for
          _e_p_s is 1E-6.


EEEEXXXXIIIITTTT SSSSTTTTAAAATTTTUUUUSSSS
     Exit status is 0 if everything is alright, 1 otherwise.


DDDDIIIIAAAAGGGGNNNNOOOOSSSSTTTTIIIICCCCSSSS
     When the source file _p_r_o_p[....mmmmccccllll] is erroneous, error messages
     are issued.



(C) INRIA            Last change: 2020/02/12                    2






CADP MANUAL PAGES                               EVALUATOR5(LOCAL)



BBBBIIIIBBBBLLLLIIIIOOOOGGGGRRRRAAAAPPPPHHHHYYYY
     [Mat06]
          R. Mateescu.  "CAESAR_SOLVE: A Generic Library for  On-
          the-Fly Resolution of Alternation-Free Boolean Equation
          Systems."  Springer International Journal  on  Software
          Tools  for Technology Transfer (STTT) 8(1):37-56, 2006.
          Full version available as  INRIA  Research  Report  RR-
          5948.                   Available                  from
          http://cadp.inria.fr/publications/Mateescu-06-a.html


     [MR18]
          R. Mateescu  and  J.  I.  Requeno.   "On-the-Fly  Model
          Checking for Extended Action-Based Probabilistic Opera-
          tors."   Springer  International  Journal  on  Software
          Tools  for  Technology  Transfer  (STTT) 20(5):563-587,
          2018.     Available    from    http://hal.inria.fr/hal-
          01862754/en


AAAAUUUUTTTTHHHHOOOORRRRSSSS
     Version 5.0 of  EVALUATOR  handles  version  5  of  the  _M_C_L
     language.     It    was   implemented   by   Radu   Mateescu
     (INRIA/CONVECS).


     For the previous versions of EVALUATOR, see the AUTHORS sec-
     tion of the eeeevvvvaaaalllluuuuaaaattttoooorrrr(LOCAL) manual page.


OOOOPPPPEEEERRRRAAAANNNNDDDDSSSS
     _s_p_e_c....bbbbccccgggg            BCG graph (input)
     _s_p_e_c....eeeexxxxpppp            network of communicating LTSs (input)
     _s_p_e_c....llllttttssss            FSP specification (input)
     _s_p_e_c....llllnnnntttt            LNT specification (input)
     _s_p_e_c....lllloooottttoooossss          LOTOS specification (input)
     _s_p_e_c....sssseeeeqqqq            sequence file (input)
     _p_r_o_p....mmmmccccllll            MCL version 5 formula (input)
     _d_i_a_g....bbbbccccgggg            diagnostic in BCG format (output)
     _f_i_l_e....bbbbeeeessss            BES in textual format (output)


FFFFIIIILLLLEEEESSSS
     $$$$CCCCAAAADDDDPPPP////ssssrrrrcccc////xxxxttttllll////****._m_c_l      predefined libraries (input)


SSSSEEEEEEEE AAAALLLLSSSSOOOO
     bbbbccccgggg(LOCAL),       bbbbccccgggg____ooooppppeeeennnn(LOCAL),        ccccaaaaeeeessssaaaarrrr....aaaaddddtttt(LOCAL),
     ccccaaaaeeeessssaaaarrrr____ggggrrrraaaapppphhhh(LOCAL),                  ccccaaaaeeeessssaaaarrrr____ssssoooollllvvvveeee____1111(LOCAL),
     ccccaaaaeeeessssaaaarrrr____ssssoooollllvvvveeee____2222(LOCAL),   ccccaaaaeeeessssaaaarrrr(LOCAL),   eeeevvvvaaaalllluuuuaaaattttoooorrrr4444(LOCAL),
     eeeexxxxhhhhiiiibbbbiiiittttoooorrrr(LOCAL),        eeeexxxxpppp(LOCAL),        eeeexxxxpppp....ooooppppeeeennnn(LOCAL),
     ffffsssspppp....ooooppppeeeennnn(LOCAL),       llllnnnntttt....ooooppppeeeennnn(LOCAL),        lllloooottttoooossss(LOCAL),



(C) INRIA            Last change: 2020/02/12                    3






CADP MANUAL PAGES                               EVALUATOR5(LOCAL)



     lllloooottttoooossss....ooooppppeeeennnn(LOCAL),  mmmmccccllll(LOCAL),  rrrreeeeggggeeeexxxxpppp(LOCAL),  sssseeeeqqqq(LOCAL),
     sssseeeeqqqq....ooooppppeeeennnn(LOCAL)

     Additional information is available from the CADP  Web  page
     located at http://cadp.inria.fr

     Directives   for   installation   are   given    in    files
     $$$$CCCCAAAADDDDPPPP////IIIINNNNSSSSTTTTAAAALLLLLLLLAAAATTTTIIIIOOOONNNN____****.

     Recent  changes  and  improvements  to  this  software   are
     reported and commented in file $$$$CCCCAAAADDDDPPPP////HHHHIIIISSSSTTTTOOOORRRRYYYY.


BBBBUUUUGGGGSSSS
     Please report bugs to Radu.Mateescu@inria.fr








































(C) INRIA            Last change: 2020/02/12                    4



