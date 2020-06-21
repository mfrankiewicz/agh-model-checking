


CADP MANUAL PAGES                                SCRUTATOR(LOCAL)



NNNNAAAAMMMMEEEE
     scrutator - pruning of Labelled Transition Systems


SSSSYYYYNNNNOOOOPPPPSSSSIIIISSSS
     bbbbccccgggg____ooooppppeeeennnn    [_b_c_g__o_p_t]    _s_p_e_c[....bbbbccccgggg]    [_c_c__o_p_t]    ssssccccrrrruuuuttttaaaattttoooorrrr
     [_s_c_r_u_t_a_t_o_r__o_p_t] _l_t_s[....bbbbccccgggg]

     or:

     eeeexxxxpppp....ooooppppeeeennnn    [_e_x_p__o_p_t]    _s_p_e_c[....eeeexxxxpppp]    [_c_c__o_p_t]    ssssccccrrrruuuuttttaaaattttoooorrrr
     [_s_c_r_u_t_a_t_o_r__o_p_t] _l_t_s[....bbbbccccgggg]

     or:

     ffffsssspppp....ooooppppeeeennnn    [_f_s_p__o_p_t]    _s_p_e_c[....llllttttssss]    [_c_c__o_p_t]    ssssccccrrrruuuuttttaaaattttoooorrrr
     [_s_c_r_u_t_a_t_o_r__o_p_t] _l_t_s[....bbbbccccgggg]

     or:

     llllnnnntttt....ooooppppeeeennnn    [_l_n_t__o_p_t]    _s_p_e_c[....llllnnnntttt]    [_c_c__o_p_t]    ssssccccrrrruuuuttttaaaattttoooorrrr
     [_s_c_r_u_t_a_t_o_r__o_p_t] _l_t_s[....bbbbccccgggg]

     or:

     lllloooottttoooossss....ooooppppeeeennnn  [_l_o_t_o_s__o_p_t]  _s_p_e_c[....lllloooottttoooossss]   [_c_c__o_p_t]   ssssccccrrrruuuuttttaaaattttoooorrrr
     [_s_c_r_u_t_a_t_o_r__o_p_t] _l_t_s[....bbbbccccgggg]

     or:

     sssseeeeqqqq....ooooppppeeeennnn    [_s_e_q__o_p_t]    _s_p_e_c[....sssseeeeqqqq]    [_c_c__o_p_t]    ssssccccrrrruuuuttttaaaattttoooorrrr
     [_s_c_r_u_t_a_t_o_r__o_p_t] _l_t_s[....bbbbccccgggg]


DDDDEEEESSSSCCCCRRRRIIIIPPPPTTTTIIIIOOOONNNN
     ssssccccrrrruuuuttttaaaattttoooorrrr takes as input a Labelled Transition System  (LTS)
     represented  either  as  a BCG graph _s_p_e_c....bbbbccccgggg, a composition
     expression _s_p_e_c....eeeexxxxpppp, an FSP program _s_p_e_c....llllttttssss, an LNT program
     _s_p_e_c....llllnnnntttt,  a  LOTOS  program  _s_p_e_c....lllloooottttoooossss, or a sequence file
     _s_p_e_c....sssseeeeqqqq.


     ssssccccrrrruuuuttttaaaattttoooorrrr performs an on-the-fly exploration of the LTS _s_p_e_c
     and  prunes certain parts of it according to the options and
     arguments specified (see OPTIONS below). The resulting  LTS,
     represented as a BCG graph, is stored in the file _l_t_s....bbbbccccgggg.


     Additionally, ssssccccrrrruuuuttttaaaattttoooorrrr can also reduce the LTS on  the  fly
     according to various relations (see OPTIONS below).





(C) INRIA            Last change: 2020/02/12                    1






CADP MANUAL PAGES                                SCRUTATOR(LOCAL)



     Note: The method implemented in the current version of ssssccccrrrruuuu----
     ttttaaaattttoooorrrr (described in [MPS07,MPS12]) is based on a translation
     of the pruning problem into  the  resolution  of  a  Boolean
     Equation  System  (BES), which is performed on the fly using
     the algorithms provided by the ccccaaaaeeeessssaaaarrrr____ssssoooollllvvvveeee____1111(LOCAL) library
     of  OPEN/CAESAR  (see  the corresponding manual page and the
     article [Mat06] for details).


OOOOPPPPTTTTIIIIOOOONNNNSSSS
     The options _b_c_g__o_p_t, if any, are passed to bbbbccccgggg____lllliiiibbbb(LOCAL).

     The options _e_x_p__o_p_t, if any, are passed to eeeexxxxpppp....ooooppppeeeennnn(LOCAL).

     The options _f_s_p__o_p_t, if any, are passed to ffffsssspppp....ooooppppeeeennnn(LOCAL).

     The options _l_n_t__o_p_t, if any, are passed to llllnnnntttt....ooooppppeeeennnn(LOCAL).

     The options _l_o_t_o_s__o_p_t, if any, are passed  to  ccccaaaaeeeessssaaaarrrr(LOCAL)
     and to ccccaaaaeeeessssaaaarrrr....aaaaddddtttt(LOCAL).

     The options _s_e_q__o_p_t, if any, are passed to sssseeeeqqqq....ooooppppeeeennnn(LOCAL).

     The options _c_c__o_p_t, if any, are passed to the C compiler.


     The following options _s_c_r_u_t_a_t_o_r__o_p_t are currently available:


     ----nnnnooooddddeeeeaaaaddddlllloooocccckkkk
          Prune _s_p_e_c by keeping only the transitions whose target
          states do not eventually lead to deadlock states.

          Formally, a transition s--L-->s' is kept in _l_t_s....bbbbccccgggg iff
          state s' satisfies the following CTL formula:
              nnnnooootttt ((((AAAAFFFF ddddeeeeaaaaddddlllloooocccckkkk))))
          or the equivalent mu-calculus formula:
              nnnnuuuu XXXX .... <<<<ttttrrrruuuueeee>>>> XXXX
          This kind of  pruning  corresponds  to  the  adaptation
          technique  proposed  in  [CPS06],  the difference being
          that the pruning is performed on-the-fly.  This  option
          is  mutually exclusive with the ----ppppooootttteeeennnnttttiiiiaaaallll and ----iiiinnnneeeevvvviiiitttt----
          aaaabbbblllleeee options.  Default option.


     ----ppppooootttteeeennnnttttiiiiaaaallll [[[[ ----ttttoooottttaaaallll |||| ----ppppaaaarrrrttttiiiiaaaallll |||| ----ggggaaaatttteeee ]]]] _m_a_t_c_h_i_n_g__f_i_l_e_n_a_m_e
          Prune _s_p_e_c by keeping only the transitions whose target
          states  potentially  lead  to states having an outgoing
          transition labelled by an  action  matching  the  rules
          defined in _m_a_t_c_h_i_n_g__f_i_l_e_n_a_m_e.

          The format of  _m_a_t_c_h_i_n_g__f_i_l_e_n_a_m_e  is  the  same  as  of



(C) INRIA            Last change: 2020/02/12                    2






CADP MANUAL PAGES                                SCRUTATOR(LOCAL)



          hiding files defined in the ccccaaaaeeeessssaaaarrrr____hhhhiiiiddddeeee____1111(LOCAL) manual
          page, except that the keyword "match" is  used  instead
          of  "hide".   The  ----ttttoooottttaaaallll,  ----ppppaaaarrrrttttiiiiaaaallll, and ----ggggaaaatttteeee options
          specify the "total matching", "partial  matching",  and
          "gate   matching"  semantics,  respectively.   See  the
          ccccaaaaeeeessssaaaarrrr____hhhhiiiiddddeeee____1111(LOCAL) manual page for more details about
          these semantics. Option ----ttttoooottttaaaallll is the default.

          Formally, a transition s--L-->s' is kept in _l_t_s....bbbbccccgggg iff
          state s' satisfies the following CTL formula:
              EEEEFFFF <<<<_a_c_t_i_o_n>>>> ttttrrrruuuueeee
          or the equivalent mu-calculus formula:
              mmmmuuuu XXXX .... <<<<_a_c_t_i_o_n>>>> ttttrrrruuuueeee oooorrrr <<<<ttttrrrruuuueeee>>>> XXXX
          where  _a_c_t_i_o_n  denotes  an  action  (transition  label)
          matching  the  rules  specified  in  _m_a_t_c_h_i_n_g__f_i_l_e_n_a_m_e.
          This kind of  pruning  corresponds  to  the  adaptation
          technique  proposed  in  [MPS07,MPS12].  This option is
          mutually exclusive with the ----nnnnooooddddeeeeaaaaddddlllloooocccckkkk and ----iiiinnnneeeevvvviiiittttaaaabbbblllleeee
          options.  Not a default option.


     ----iiiinnnneeeevvvviiiittttaaaabbbblllleeee [[[[ ----ttttoooottttaaaallll |||| ----ppppaaaarrrrttttiiiiaaaallll |||| ----ggggaaaatttteeee ]]]] _m_a_t_c_h_i_n_g__f_i_l_e_n_a_m_e
          Prune _s_p_e_c by keeping only the transitions whose target
          states  eventually  lead  to  states having an outgoing
          transition labelled by an  action  matching  the  rules
          defined in _m_a_t_c_h_i_n_g__f_i_l_e_n_a_m_e.

          The format of _m_a_t_c_h_i_n_g__f_i_l_e_n_a_m_e is the same as of  hid-
          ing  files  defined  in the ccccaaaaeeeessssaaaarrrr____hhhhiiiiddddeeee____1111(LOCAL) manual
          page, except that the keyword "match" is  used  instead
          of  "hide".   The  ----ttttoooottttaaaallll,  ----ppppaaaarrrrttttiiiiaaaallll, and ----ggggaaaatttteeee options
          specify the "total matching", "partial  matching",  and
          "gate   matching"  semantics,  respectively.   See  the
          ccccaaaaeeeessssaaaarrrr____hhhhiiiiddddeeee____1111(LOCAL) manual page for more details about
          these semantics. Option ----ttttoooottttaaaallll is the default.

          Formally, a transition s--L-->s' is kept in _l_t_s....bbbbccccgggg iff
          state s' satisfies the following CTL formula:
              AAAAFFFF <<<<_a_c_t_i_o_n>>>> ttttrrrruuuueeee
          or the equivalent mu-calculus formula:
              mmmmuuuu XXXX .... <<<<_a_c_t_i_o_n>>>> ttttrrrruuuueeee oooorrrr ((((<<<<ttttrrrruuuueeee>>>> ttttrrrruuuueeee aaaannnndddd [[[[ttttrrrruuuueeee]]]] XXXX))))
          where  _a_c_t_i_o_n  denotes  an  action  (transition  label)
          matching  the  rules  specified  in  _m_a_t_c_h_i_n_g__f_i_l_e_n_a_m_e.
          This option is mutually exclusive with the  ----nnnnooooddddeeeeaaaaddddlllloooocccckkkk
          and ----ppppooootttteeeennnnttttiiiiaaaallll options.  Not a default option.


     ----ccccaaaacccchhhheeee _n
          Use a cache of size _n for storing the  states  of  _s_p_e_c
          during  the  pruning.  This  option allows to trade off
          memory  consumption  against  execution  time.   Not  a
          default option.



(C) INRIA            Last change: 2020/02/12                    3






CADP MANUAL PAGES                                SCRUTATOR(LOCAL)



     ----ssssttttaaaatttt
          Display statistical information about the resolution of
          the  BES  corresponding  to  the pruning of _s_p_e_c. Not a
          default option.


     ----vvvveeeerrrrssssiiiioooonnnn
          Display the current version  number  of  the  tool  and
          stop.  To be effective, this option should occur as the
          first argument on the command line. Subsequent  options
          and/or  arguments,  if  any,  will  be discarded. Not a
          default option.


     The options below specify additional reductions that can  be
     applied on-the-fly during the pruning of the LTS:


     ----ttttaaaauuuuccccoooonnnnfffflllluuuueeeennnncccceeee
          Reduce the LTS on the fly modulo tau-confluence (a form
          of  partial  order  reduction  that preserves branching
          equivalence).  This option can be used  in  conjunction
          with options ----ttttaaaauuuussssttttaaaarrrr and ----wwwweeeeaaaakkkkttttrrrraaaacccceeee, and in some cases
          it may reduce the execution time and  the  memory  con-
          sumption significantly.  Not a default option.


     ----ttttaaaauuuussssttttaaaarrrr
          Reduce the LTS on the fly  modulo  tau*.a  equivalence.
          This  reduction  eliminates  all  internal  transitions
          (labelled by the "i" action) in _l_t_s....bbbbccccgggg.  Not a default
          option.


     ----wwwweeeeaaaakkkkttttrrrraaaacccceeee
          Reduce  the  LTS  on  the   fly   modulo   weak   trace
          equivalence.  This  reduction  eliminates  all internal
          transitions and determinizes _l_t_s....bbbbccccgggg.   Not  a  default
          option.


     Note: The reduction options above  replace  the  divergences
     (cycles of tau-transitions) present in the LTS with deadlock
     states.  This may influence the inevitable  reachability  of
     certain  states  (e.g.,  deadlock states or states having an
     outgoing transition labelled by a given action), and  there-
     fore may trigger a more drastic pruning of the LTS when used
     in conjunction with the ----nnnnooooddddeeeeaaaaddddlllloooocccckkkk and ----iiiinnnneeeevvvviiiittttaaaabbbblllleeee options.


EEEEXXXXIIIITTTT SSSSTTTTAAAATTTTUUUUSSSS
     Exit status is 0 if everything is alright, 1 otherwise.



(C) INRIA            Last change: 2020/02/12                    4






CADP MANUAL PAGES                                SCRUTATOR(LOCAL)



BBBBIIIIBBBBLLLLIIIIOOOOGGGGRRRRAAAAPPPPHHHHYYYY
     [CPS06]
          C. Canal, P.  Poizat,  and  G.  Salaun.   Synchronizing
          Behavioural   Mismatch  in  Software  Composition.   In
          Roberto Gorrieri and Heike Wehrheim (Eds.), Proceedings
          of  the  8th  IFIP  International  Conference on Formal
          Methods  for  Open  Object-Based  Distributed   Systems
          FMOODS'2006 (Bologna, Italy), Lecture Notes in Computer
          Science vol. 4037, pp.  63-77.  Springer  Verlag,  June
          2006.


     [Mat06]
          R. Mateescu.  CAESAR_SOLVE: A Generic Library  for  On-
          the-Fly Resolution of Alternation-Free Boolean Equation
          Systems.  Springer International  Journal  on  Software
          Tools  for Technology Transfer (STTT) 8(1):37-56, 2006.
          Full version available as  INRIA  Research  Report  RR-
          5948.


     [MPS07]
          R. Mateescu, P.  Poizat,  and  G.  Salaun.   On-the-Fly
          Adaptation  of  Component Compositions based on Process
          Algebra Encodings. In Alexander Egyed and Bernd Fischer
          (Eds.),  Proceedings of the 22nd IEEE/ACM International
          Conference on  Automated  Software  Engineering  ASE'07
          (Atlanta,  Georgia,  USA), pp. 385-388. ACM Press, Nov.
          2007.  Full version available as INRIA Research  Report
          RR-6362.


     [MPS12]
          R. Mateescu, P. Poizat, and G. Salaun.   Adaptation  of
          Service  Protocols Using Process Algebra and On-the-Fly
          Reduction Techniques.  IEEE  Transactions  on  Software
          Engineering 38(4):755-777, 2012.


AAAAUUUUTTTTHHHHOOOORRRRSSSS
     Radu Mateescu (INRIA/CONVECS).


OOOOPPPPEEEERRRRAAAANNNNDDDDSSSS
     _s_p_e_c....bbbbccccgggg            BCG graph (input)
     _s_p_e_c....eeeexxxxpppp            network of communicating LTSs (input)
     _s_p_e_c....llllttttssss            FSP specification (input)
     _s_p_e_c....llllnnnntttt            LNT specification (input)
     _s_p_e_c....lllloooottttoooossss          LOTOS specification (input)
     _s_p_e_c....sssseeeeqqqq            sequence file (input)
     _l_t_s....bbbbccccgggg             BCG graph (output)




(C) INRIA            Last change: 2020/02/12                    5






CADP MANUAL PAGES                                SCRUTATOR(LOCAL)



FFFFIIIILLLLEEEESSSS
     The   binary   code   of   ssssccccrrrruuuuttttaaaattttoooorrrr   is    available    in
     $CADP/bin.`arch`/scrutator.a


SSSSEEEEEEEE AAAALLLLSSSSOOOO
     bbbbccccgggg(LOCAL),  bbbbccccgggg____ooooppppeeeennnn(LOCAL),  eeeexxxxpppp(LOCAL),  eeeexxxxpppp....ooooppppeeeennnn(LOCAL),
     ffffsssspppp....ooooppppeeeennnn(LOCAL),        llllnnnntttt....ooooppppeeeennnn(LOCAL),       lllloooottttoooossss(LOCAL),
     lllloooottttoooossss....ooooppppeeeennnn(LOCAL), sssseeeeqqqq(LOCAL) sssseeeeqqqq....ooooppppeeeennnn(LOCAL)

     Additional information is available from the CADP  Web  page
     located at http://cadp.inria.fr

     Directives   for   installation   are   given    in    files
     $$$$CCCCAAAADDDDPPPP////IIIINNNNSSSSTTTTAAAALLLLLLLLAAAATTTTIIIIOOOONNNN____****.

     Recent  changes  and  improvements  to  this  software   are
     reported and commented in file $$$$CCCCAAAADDDDPPPP////HHHHIIIISSSSTTTTOOOORRRRYYYY.


BBBBUUUUGGGGSSSS
     Please report bugs to Radu.Mateescu@inria.fr

































(C) INRIA            Last change: 2020/02/12                    6



