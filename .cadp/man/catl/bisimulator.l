


CADP MANUAL PAGES                              BISIMULATOR(LOCAL)



NNNNAAAAMMMMEEEE
     bisimulator - on-the-fly equivalence/preorder checking


SSSSYYYYNNNNOOOOPPPPSSSSIIIISSSS
     bbbbccccgggg____ooooppppeeeennnn   [_b_c_g__o_p_t]   _l_t_s_1[....bbbbccccgggg]    [_c_c__o_p_t]    bbbbiiiissssiiiimmmmuuuullllaaaattttoooorrrr
     [_b_i_s_i_m_u_l_a_t_o_r__o_p_t] _l_t_s_2[....bbbbccccgggg]

     or:

     eeeexxxxpppp....ooooppppeeeennnn   [_e_x_p__o_p_t]   _l_t_s_1[....eeeexxxxpppp]    [_c_c__o_p_t]    bbbbiiiissssiiiimmmmuuuullllaaaattttoooorrrr
     [_b_i_s_i_m_u_l_a_t_o_r__o_p_t] _l_t_s_2[....bbbbccccgggg]

     or:

     ffffsssspppp....ooooppppeeeennnn   [_f_s_p__o_p_t]   _l_t_s_1[....llllttttssss]    [_c_c__o_p_t]    bbbbiiiissssiiiimmmmuuuullllaaaattttoooorrrr
     [_b_i_s_i_m_u_l_a_t_o_r__o_p_t] _l_t_s_2[....bbbbccccgggg]

     or:

     llllnnnntttt....ooooppppeeeennnn   [_l_n_t__o_p_t]   _l_t_s_1[....llllnnnntttt]    [_c_c__o_p_t]    bbbbiiiissssiiiimmmmuuuullllaaaattttoooorrrr
     [_b_i_s_i_m_u_l_a_t_o_r__o_p_t] _l_t_s_2[....bbbbccccgggg]

     or:

     lllloooottttoooossss....ooooppppeeeennnn  [_l_o_t_o_s__o_p_t]  _l_t_s_1[....lllloooottttoooossss]  [_c_c__o_p_t]  bbbbiiiissssiiiimmmmuuuullllaaaattttoooorrrr
     [_b_i_s_i_m_u_l_a_t_o_r__o_p_t] _l_t_s_2[....bbbbccccgggg]

     or:

     sssseeeeqqqq....ooooppppeeeennnn   [_s_e_q__o_p_t]   _l_t_s_1[....sssseeeeqqqq]    [_c_c__o_p_t]    bbbbiiiissssiiiimmmmuuuullllaaaattttoooorrrr
     [_b_i_s_i_m_u_l_a_t_o_r__o_p_t] _l_t_s_2[....bbbbccccgggg]


DDDDEEEESSSSCCCCRRRRIIIIPPPPTTTTIIIIOOOONNNN
     bbbbiiiissssiiiimmmmuuuullllaaaattttoooorrrr takes as inputs two Labelled Transition  Systems
     (LTSs),  the  first  one  being  represented either as a BCG
     graph _l_t_s_1....bbbbccccgggg, a composition expression  _l_t_s_1....eeeexxxxpppp,  an  FSP
     program  _l_t_s_1....llllttttssss,  an LNT program _l_t_s_1....llllnnnntttt, a LOTOS program
     _l_t_s_1....lllloooottttoooossss, or a sequence file _l_t_s_1....sssseeeeqqqq, and the second  one
     being  represented  as a BCG graph _l_t_s_2....bbbbccccgggg.  Traditionally,
     _l_t_s_1  represents  the  behaviour  of  a  _p_r_o_t_o_c_o_l  and  _l_t_s_2
     represents the behaviour of its _s_e_r_v_i_c_e.


     bbbbiiiissssiiiimmmmuuuullllaaaattttoooorrrr performs an on-the-fly  comparison  of  the  two
     LTSs _l_t_s_1 and _l_t_s_2 modulo a given equivalence/preorder rela-
     tion (see EQUIVALENCE RELATIONS below). The result  of  this
     verification  (TRUE  or  FALSE) is displayed on the standard
     output, possibly accompanied by a  diagnostic  (see  OPTIONS
     below).




(C) INRIA            Last change: 2020/02/12                    1






CADP MANUAL PAGES                              BISIMULATOR(LOCAL)



     Note: The verification method underlying the current version
     of   bbbbiiiissssiiiimmmmuuuullllaaaattttoooorrrr   is   based  upon  a  translation  of  the
     equivalence/preorder checking problem into the resolution of
     a  Boolean Equation System (BES), which is performed on-the-
     fly    using    the    algorithms    provided     by     the
     ccccaaaaeeeessssaaaarrrr____ssssoooollllvvvveeee____1111(LOCAL)   library   of  OPEN/CAESAR  (see  the
     corresponding  manual  page  and  the  article  [Mat06]  for
     details).


OOOOPPPPTTTTIIIIOOOONNNNSSSS
     The options _b_c_g__o_p_t, if any, are passed to bbbbccccgggg____lllliiiibbbb(LOCAL).

     The options _e_x_p__o_p_t, if any, are passed to eeeexxxxpppp....ooooppppeeeennnn(LOCAL).

     The options _f_s_p__o_p_t, if any, are passed to ffffsssspppp....ooooppppeeeennnn(LOCAL).

     The options _l_n_t__o_p_t, if any, are passed to llllnnnntttt....ooooppppeeeennnn(LOCAL).

     The options _l_o_t_o_s__o_p_t, if any, are passed  to  ccccaaaaeeeessssaaaarrrr(LOCAL)
     and to ccccaaaaeeeessssaaaarrrr....aaaaddddtttt(LOCAL).

     The options _s_e_q__o_p_t, if any, are passed to sssseeeeqqqq....ooooppppeeeennnn(LOCAL).

     The options _c_c__o_p_t, if any, are passed to the C compiler.


     The  options   _b_i_s_i_m_u_l_a_t_o_r__o_p_t   currently   available   are
     described below.


     The options below specify the equivalence relation used  for
     comparing _l_t_s_1 and _l_t_s_2.


     -bbbbrrrraaaannnncccchhhhiiiinnnngggg
          Use  branching  equivalence  (resp.  its  corresponding
          preorder)  as equivalence (resp. preorder) relation for
          comparing _l_t_s_1 and _l_t_s_2.  Not a default option.


     -oooobbbbsssseeeerrrrvvvvaaaattttiiiioooonnnnaaaallll
          Use observational equivalence (resp. its  corresponding
          preorder)  as equivalence (resp. preorder) relation for
          comparing _l_t_s_1 and _l_t_s_2.  Not a default option.


     -ssssaaaaffffeeeettttyyyy
          Use  safety  equivalence   (resp.   its   corresponding
          preorder)  as equivalence (resp. preorder) relation for
          comparing _l_t_s_1 and _l_t_s_2.  Not a default option.




(C) INRIA            Last change: 2020/02/12                    2






CADP MANUAL PAGES                              BISIMULATOR(LOCAL)



     -ssssttttrrrroooonnnngggg
          Use  strong  equivalence   (resp.   its   corresponding
          preorder)  as equivalence (resp. preorder) relation for
          comparing _l_t_s_1 and _l_t_s_2.  Default option.


     -ttttaaaauuuussssttttaaaarrrr
          Use  _t_a_u*._a  equivalence   (resp.   its   corresponding
          preorder)  as equivalence (resp. preorder) relation for
          comparing _l_t_s_1 and _l_t_s_2.  Not a default option.


     -ttttrrrraaaacccceeee
          Use  trace   equivalence   (resp.   its   corresponding
          preorder)  as equivalence (resp. preorder) relation for
          comparing _l_t_s_1 and _l_t_s_2.  Not a default option.


     -wwwweeeeaaaakkkkttttrrrraaaacccceeee
          Use weak trace  equivalence  (resp.  its  corresponding
          preorder)  as equivalence (resp. preorder) relation for
          comparing _l_t_s_1 and _l_t_s_2.  Not a default option.


     The options below specify the  kind  of  comparison  between
     _l_t_s_1 and _l_t_s_2.


     -ssssmmmmaaaalllllllleeeerrrr
          Check whether _l_t_s_1  is  included  in  _l_t_s_2  modulo  the
          preorder corresponding to the equivalence relation con-
          sidered (if the two LTSs are equivalent, they are  also
          included  one  into  the other modulo the corresponding
          preorder). Not a default option.


     -eeeeqqqquuuuaaaallll
          Check whether _l_t_s_1 is equivalent  to  _l_t_s_2  modulo  the
          equivalence relation considered. Default option.


     -ggggrrrreeeeaaaatttteeeerrrr
          Check whether _l_t_s_2  is  included  in  _l_t_s_1  modulo  the
          preorder corresponding to the equivalence relation con-
          sidered (if the two LTSs are equivalent, they are  also
          included  one  into  the other modulo the corresponding
          preorder). Not a default option.


     The options below specify the algorithm used  for  comparing
     _l_t_s_1 and _l_t_s_2.




(C) INRIA            Last change: 2020/02/12                    3






CADP MANUAL PAGES                              BISIMULATOR(LOCAL)



     -bbbbffffssss Compare _l_t_s_1 and  _l_t_s_2  using  a  breadth-first  search
          algorithm.  Compared  to ----ddddffffssss, this option is generally
          slower, but produces counterexamples of smaller  depth.
          Not a default option.


     -ddddffffssss Compare _l_t_s_1 and _l_t_s_2 using a depth-first search  algo-
          rithm.  Compared  to  ----bbbbffffssss,  this option produces coun-
          terexamples of greater depth, but is  generally  faster
          and  consumes less memory if _l_t_s_2 is deterministic (for
          strong equivalence) and has no invisible  actions  (for
          weak equivalences). Default option.


     The options below  specify  various  features  available  in
     addition to the comparison of _l_t_s_1 and _l_t_s_2.


     ----bbbbeeeessss [ _f_i_l_e[....bbbbeeeessss[._e_x_t]] ]
          Print in _f_i_l_e[....bbbbeeeessss] or, if the file  name  argument  is
          missing, in file bbbbiiiissssiiiimmmmuuuullllaaaattttoooorrrr....bbbbeeeessss, a textual description
          of the BES corresponding to the comparison of _l_t_s_1  and
          _l_t_s_2  modulo  the  equivalence/preorder  relation  con-
          sidered.   If  present,   the   extension   ._e_x_t   must
          correspond  to  a  known file compression format (e.g.,
          ._Z, ._g_z, ._b_z_2, etc.).  In this case, the file  contain-
          ing  the BES is compressed according to the correspond-
          ing format.  The list of currently supported extensions
          and    compression    formats    is    given   by   the
          $$$$CCCCAAAADDDDPPPP////ssssrrrrcccc////ccccoooommmm////ccccaaaaddddpppp____zzzziiiipppp shell-script.  This option  does
          not influence the comparison between the two LTSs.  Not
          a default option.


     ----ddddiiiiaaaagggg [ ----mmmmiiiinnnniiiimmmmaaaallll ] [ _d_i_a_g[....bbbbccccgggg] ]
          When the comparison of _l_t_s_1 and _l_t_s_2 yields FALSE, gen-
          erate  a diagnostic (counterexample) in BCG format (see
          the bbbbccccgggg(LOCAL) manual page for details) explaining this
          result.   The  diagnostic  is  generated  in  the  file
          _d_i_a_g.bbbbccccgggg or, if the file name argument is  missing,  in
          file  bbbbiiiissssiiiimmmmuuuullllaaaattttoooorrrr....bbbbccccgggg.  This  option has no effect when
          the comparison of _l_t_s_1 and _l_t_s_2 yields TRUE,  since  in
          this  case the diagnostic would be larger than _l_t_s_1 and
          _l_t_s_2, and would not bring any useful  information.  The
          BCG  file  containing  the diagnostic can be visualized
          using the bbbbccccgggg____ddddrrrraaaawwww(LOCAL) and bbbbccccgggg____eeeeddddiiiitttt(LOCAL) tools  of
          CADP (see respective manual pages for details).

          The diagnostic is a  directed  acyclic  graph  included
          (modulo  the  preorder corresponding to the equivalence
          relation considered) both in _l_t_s_1 and _l_t_s_2. Each  state
          _p  of  the diagnostic corresponds to a couple of states



(C) INRIA            Last change: 2020/02/12                    4






CADP MANUAL PAGES                              BISIMULATOR(LOCAL)



          (_q, _r) belonging to _l_t_s_1 and  _l_t_s_2,  respectively;  the
          portion  of  diagnostic  going out of _p illustrates why
          the  two  corresponding  states  _q  and   _r   are   not
          equivalent.  The terminal states of the diagnostic have
          additional "error" outgoing transitions with labels  of
          the  form  "Present  in  lts2.bcg:  _b"  or  "Absent  in
          lts2.bcg: _b", indicating that the  action  _b  does  not
          occur  either  in _l_t_s_1, or in _l_t_s_2, respectively (_b can
          be either a visible action,  or  the  invisible  action
          _t_a_u, see EQUIVALENCE RELATIONS below for naming conven-
          tions). Intuitively, all transition sequences contained
          in the diagnostic lead, when executed simultaneously in
          _l_t_s_1 and _l_t_s_2, to states which are unrelated modulo the
          equivalence/preorder relation considered. Note that for
          weak equivalences, any  transition  _p_1--_b-->_p_2  in  the
          diagnostic  may correspond to sequences of the form _q_1-
          -_t_a_u*._b-->_q_2 and _r_1--_t_a_u*._b-->_r_2 contained in _l_t_s_1  and
          _l_t_s_2,  respectively.  Also, any transition _p_1--_t_a_u-->_p_2
          in the diagnostic may correspond  to  a  sequence  _q_1--
          _t_a_u-->_q_2  contained  in _l_t_s_1 and possibly to a sequence
          _r_1--_t_a_u*-->_r_2 contained in _l_t_s_2, or vice-versa.

          In the case of branching  equivalence,  the  diagnostic
          may  also  contain some transitions of the form _p_1--_b--
          >_p_2  leading  to  sink  states.  Considering  that   _p_1
          corresponds  to  the  couple of states (_q_1, _r_1), such a
          transition indicates the existence of two sequences  of
          the  form  _q_1--_t_a_u*-->_q_2--_b-->_q_3 and _r_1--_t_a_u*-->_r_2--_b--
          >_r_3 in _l_t_s_1  and  _l_t_s_2,  respectively,  such  that  the
          states _q_2 and _r_2 are not branching equivalent. For each
          transition _p_1--_b-->_p_2 leading to a sink  state  in  the
          diagnostic,  the  remainder of the diagnostic going out
          of _p_1 illustrates the non equivalence of the states  _q_2
          and   _r_2.    This   specific   handling   of  branching
          equivalence is due to  the  nature  of  this  relation,
          which  (at  the  opposite  of  other relations, such as
          strong, observational,  _t_a_u*._a,  and  safety)  requires
          that  not  only  the  target states of transitions, but
          also their source states are equivalent.

          If the  additional  option  ----mmmmiiiinnnniiiimmmmaaaallll  is  specified,  a
          small-depth  diagnostic  is  generated  (the  depth  is
          guaranteed to be minimal only when the diagnostic is  a
          tree).

          If the diagnostic is a sequence of transitions, it will
          also be displayed on standard output using the SEQ for-
          mat (see the sssseeeeqqqq(LOCAL) manual page for the  definition
          of this format). Not a default option.


     -ssssttttaaaatttt



(C) INRIA            Last change: 2020/02/12                    5






CADP MANUAL PAGES                              BISIMULATOR(LOCAL)



          Display statistical information about the resolution of
          the  BES  corresponding  to  the comparison of _l_t_s_1 and
          _l_t_s_2  modulo  the  equivalence/preorder  relation  con-
          sidered. Not a default option.


     -ttttaaaauuuuccccoooonnnnfffflllluuuueeeennnncccceeee
          Reduce _l_t_s_1 on-the-fly modulo tau-confluence (a form of
          partial   order   reduction  that  preserves  branching
          equivalence) while performing the comparison with _l_t_s_2.
          This  option  can  be  used  only  in  conjunction with
          options ----bbbbrrrraaaannnncccchhhhiiiinnnngggg  and  ----oooobbbbsssseeeerrrrvvvvaaaattttiiiioooonnnnaaaallll,  and  in  some
          cases  it may improve speed and memory consumption sig-
          nificantly.  Not a default option.


EEEEQQQQUUUUIIIIVVVVAAAALLLLEEEENNNNCCCCEEEE RRRREEEELLLLAAAATTTTIIIIOOOONNNNSSSS
     An LTS is a quadruple _M = (_Q, _A, _T, _q_0), where: _Q is the set
     of  _s_t_a_t_e_s,  _A  is the set of _a_c_t_i_o_n_s (transition labels), _T
     included in _Q * _A * _Q is the _t_r_a_n_s_i_t_i_o_n _r_e_l_a_t_i_o_n, and _q_0  is
     the  _i_n_i_t_i_a_l _s_t_a_t_e.  The set _A contains the invisible action
     _t_a_u, which denotes internal (unobservable) activity. A tran-
     sition  (_p,  _a, _q) in _T (also noted _p--_a-->_q) means that the
     system can evolve from state _p  to  state  _q  by  performing
     action  _a.  If _L is a language included in _A*, then _p--_L-->_q
     denotes a transition  sequence  _p--_a_1-->_q_2--_a_2-->...--_a_n-->_q
     such  that the word _a_1_a_2..._a_n belongs to _L.  All states _q of
     _Q are assumed to be reachable from the initial state _q_0  via
     sequences  of  transitions  in  _T (i.e., _q_0--_A*-->_q). In the
     sequel, visible actions of _A are denoted  by  _a,  and  (both
     visible  and  invisible)  actions of _A are denoted by _b. The
     transitive and reflexive closure of _T is denoted by _T*.


     Two LTSs _M_1 = (_Q_1, _A, _T_1, _q_0_1) and _M_2 = (_Q_2, _A, _T_2, _q_0_2) are
     related  modulo an equivalence relation _R (noted _M_1 _R _M_2) if
     and only if their initial states are related modulo _R (noted
     _q_0_1 _R _q_0_2). The equivalence relations currently supported by
     bbbbiiiissssiiiimmmmuuuullllaaaattttoooorrrr are defined below.  For each equivalence  _R__e_q_u,
     the  corresponding  preorder relation _I__e_q_u, which indicates
     whether a state _p is ``simulated'' by a state _q (resp. _q  is
     ``simulated''  by _p) is obtained by keeping only condition 1
     (resp. 2) in the definition of _R__e_q_u.


     SSSSttttrrrroooonnnngggg eeeeqqqquuuuiiiivvvvaaaalllleeeennnncccceeee [[[[PPPPaaaarrrr88881111]]]]
          This is the largest relation _R__s_t_r such that two states
          _p  and _q are related modulo strong equivalence (_p _R__s_t_r
          _q) if and only if:

          1. for each transition _p--_b-->_p' in _T_1
             there is a transition _q--_b-->_q' in _T_2



(C) INRIA            Last change: 2020/02/12                    6






CADP MANUAL PAGES                              BISIMULATOR(LOCAL)



             such that _p' _R__s_t_r _q'

          2. for each transition _q--_b-->_q' in _T_2
             there is a transition _p--_b-->_p' in _T_1
             such that _p' _R__s_t_r _q'


     BBBBrrrraaaannnncccchhhhiiiinnnngggg eeeeqqqquuuuiiiivvvvaaaalllleeeennnncccceeee [[[[GGGGWWWW88889999]]]]
          This is the largest relation _R__b_r_a such that two states
          _p  and  _q  are  related modulo branching equivalence (_p
          _R__b_r_a _q) if and only if:

          1. for each transition _p--_b-->_p' in _T_1
             a. either _b = _t_a_u and _p' _R__b_r_a _q, or
             b. there is a sequence _q--_t_a_u*-->_q'--_b-->_q'' in _T_2*
                such that _p _R__b_r_a _q' and _p' _R__b_r_a _q''

          2. for each transition _q--_b-->_q' in _T_2
             a. either _b = _t_a_u and _p _R__b_r_a _q', or
             b. there is a sequence _p--_t_a_u*-->_p'--_b-->_p'' in _T_1*
                such that _p' _R__b_r_a _q and _p'' _R__b_r_a _q'


     OOOObbbbsssseeeerrrrvvvvaaaattttiiiioooonnnnaaaallll eeeeqqqquuuuiiiivvvvaaaalllleeeennnncccceeee [[[[MMMMiiiillll88889999]]]]
          This is the largest relation _R__o_b_s such that two states
          _p and _q are related modulo observational equivalence (_p
          _R__o_b_s _q) if and only if:

          1. a. for each transition _p--_t_a_u-->_p' in _T_1
                there is a sequence _q--_t_a_u*-->_q' in _T_2*
                such that _p' _R__o_b_s _q'
             b. for each transition _p--_a-->_p' in _T_1
                there is a sequence _q--_t_a_u*._a._t_a_u*-->_q' in _T_2*
                such that _p' _R__o_b_s _q'

          2. a. for each transition _q--_t_a_u-->_q' in _T_2
                there is a sequence _p--_t_a_u*-->_p' in _T_1*
                such that _p' _R__o_b_s _q'
             b. for each transition _q--_a-->_q' in _T_2
                there is a sequence _p--_t_a_u*._a._t_a_u*-->_p' in _T_1*
                such that _p' _R__o_b_s _q'


     TTTTaaaauuuu****....aaaa eeeeqqqquuuuiiiivvvvaaaalllleeeennnncccceeee [[[[FFFFMMMM99991111]]]]
          This is the largest relation _R__t_a_u such that two states
          _p  and _q are related modulo _t_a_u*._a equivalence (_p _R__t_a_u
          _q) if and only if:

          1. for each sequence _p--_t_a_u*._a-->_p' in _T_1*
             there is a sequence _q--_t_a_u*._a-->_q' in _T_2*
             such that _p' _R__t_a_u _q'




(C) INRIA            Last change: 2020/02/12                    7






CADP MANUAL PAGES                              BISIMULATOR(LOCAL)



          2. for each transition _q--_t_a_u*._a-->_q' in _T_2*
             there is a sequence _p--_t_a_u*._a-->_p' in _T_1*
             such that _p' _R__t_a_u _q'


     SSSSaaaaffffeeeettttyyyy eeeeqqqquuuuiiiivvvvaaaalllleeeennnncccceeee [[[[BBBBFFFFGGGG++++99991111]]]]
          This is the largest relation _R__s_a_f such that two states
          _p  and _q are related modulo safety equivalence (_p _R__s_a_f
          _q) if and only if:

          1. _p _I__t_a_u _q

          2. _q _I__t_a_u _p

          Safety equivalence is defined in terms  of  the  _t_a_u*._a
          preorder  _I__t_a_u.  It is a _s_i_m_u_l_a_t_i_o_n _e_q_u_i_v_a_l_e_n_c_e rather
          than a _b_i_s_i_m_u_l_a_t_i_o_n (e.g.,  like  _t_a_u*._a  equivalence),
          because  it  only  requires  that  states  _p  and _q are
          included one into the other modulo _I__t_a_u, and does  not
          require  that  each  _t_a_u*._a-successor of _p (resp. _q) is
          equivalent to a  corresponding  _t_a_u*._a-successor  of  _q
          (resp.  _p).   Therefore,  safety  equivalence is weaker
          than _t_a_u*._a equivalence (see the note  below),  but  it
          has the same associated preorder (i.e., _I__s_a_f = _I__t_a_u).


     TTTTrrrraaaacccceeee eeeeqqqquuuuiiiivvvvaaaalllleeeennnncccceeee ((((aaaa....kkkk....aaaa.... llllaaaannnngggguuuuaaaaggggeeee eeeeqqqquuuuiiiivvvvaaaalllleeeennnncccceeee))))
          This is the largest relation _R__t_r_a such that two states
          _p  and  _q are related modulo trace equivalence (_p _R__t_r_a
          _q) if and only if:

          1. for each sequence _p--_b_1..._b_n-->_p' in _T_1*
             there is a sequence _q--_b_1..._b_n-->_q' in _T_2*

          2. for each sequence _q--_b_1..._b_n-->_q' in _T_2*
             there is a sequence _p--_b_1..._b_n-->_p' in _T_1*


     WWWWeeeeaaaakkkk ttttrrrraaaacccceeee eeeeqqqquuuuiiiivvvvaaaalllleeeennnncccceeee [[[[BBBBHHHHRRRR88884444]]]]
          Two states _p  and  _q  are  related  modulo  weak  trace
          equivalence (_p _R__w_t_r _q) if and only if:

          1. for each sequence _p--_t_a_u*._a_1..._t_a_u*._a_n-->_p' in _T_1*
             there is a sequence _q--_t_a_u*._a_1..._t_a_u*._a_n-->_q' in _T_2*

          2. for each sequence _q--_t_a_u*._a_1..._t_a_u*._a_n-->_q' in _T_2*
             there is a sequence _p--_t_a_u*._a_1..._t_a_u*._a_n-->_p' in _T_1*


     Note: A relation _R_1 is said  to  be  _s_t_r_o_n_g_e_r  than  another
     relation  _R_2  (noted _R_1 <= _R_2) iff _p _R_1 _q implies _p _R_2 _q for
     any states _p, _q.  The relations  above  are  ordered  w.r.t.



(C) INRIA            Last change: 2020/02/12                    8






CADP MANUAL PAGES                              BISIMULATOR(LOCAL)



     their strength as follows:

          _R__s_t_r <= _R__b_r_a <= _R__o_b_s <= _R__s_a_f <= _R__w_t_r

          _R__s_t_r <= _R__t_r_a <= _R__w_t_r

          _R__b_r_a <= _R__t_a_u <= _R__s_a_f

     As  opposed  to  _R__s_t_r  and  _R__t_r_a  (the  strong  and  trace
     equivalences),  which  handle  all  transition labels in the
     same way, the relations  _R__b_r_a,  _R__o_b_s,  _R__t_a_u,  _R__s_a_f,  and
     _R__w_t_r  are called _w_e_a_k equivalences, since each of them per-
     forms a kind of abstraction over invisible actions.


     Note: To obtain maximal performance, it  is  recommended  to
     put  the  ``bigger'' LTS (the protocol) in argument _l_t_s_1 and
     the ``smaller'' LTS (the service) in argument _l_t_s_2. In addi-
     tion,  the  service  LTS  _l_t_s_2  can be minimized before com-
     parison,  either  modulo  strong  equivalence  (when  strong
     equivalence  is  considered for comparing _l_t_s_1 and _l_t_s_2), or
     modulo branching equivalence (if a weak equivalence is  con-
     sidered)  using  the  bbbbccccgggg____mmmmiiiinnnn(LOCAL)  tool  of CADP (see the
     corresponding manual page  for  details).  This  restriction
     will be eliminated in a future version of bbbbiiiissssiiiimmmmuuuullllaaaattttoooorrrr.


EEEEXXXXIIIITTTT SSSSTTTTAAAATTTTUUUUSSSS
     Exit status is 0 if everything is alright, 1 otherwise.


BBBBIIIIBBBBLLLLIIIIOOOOGGGGRRRRAAAAPPPPHHHHYYYY
     [BHR84]
          S. D. Brookes, C. A. R. Hoare, and  A.  W.  Roscoe.   A
          Theory  of Communicating Sequential Processes.  Journal
          of the ACM 31(3):560-599, July 1984.


     [BDJ+05]
          D.  Bergamini,  N.  Descoubes,  C.  Joubert,   and   R.
          Mateescu.   BISIMULATOR:  A Modular Tool for On-the-Fly
          Equivalence Checking.  In  N.  Halbwachs  and  L.  Zuck
          (Eds.),  Proceedings  of the 11th International Confer-
          ence on Tools and Algorithms for the  Construction  and
          Analysis  of  Systems  TACAS'2005 (Edinburgh, Scotland,
          UK), Lecture Notes in Computer Science  vol.  3440,  p.
          581-585.  Springer  Verlag,  April 2005. Available from
          http://cadp.inria.fr/publications/Bergamini-Descoubes-
          Joubert-Mateescu-05.html


     [BFG+91]



(C) INRIA            Last change: 2020/02/12                    9






CADP MANUAL PAGES                              BISIMULATOR(LOCAL)



          A. Bouajjani, J-C. Fernandez, S.  Graf,  C.  Rodriguez,
          and  J.  Sifakis.  Safety for Branching Time Semantics.
          In Proceedings of 18th  ICALP.  Springer  Verlag,  July
          1991.


     [FM91]
          J-C. Fernandez and L. Mounier.  ``On the Fly''  Verifi-
          cation  of  Behavioural Equivalences and Preorders.  In
          K. G. Larsen and A. Skou (Eds.), Proceedings of the 3rd
          Workshop  on  Computer-Aided  Verification CAV'91 (Aal-
          borg, Denmark), Lecture Notes in Computer Science  vol.
          575. Springer Verlag, July 1991.


     [GW89]
          R. J. van Glabbeek and W. P. Weijland.   Branching-Time
          and Abstraction in Bisimulation Semantics.  In Proceed-
          ings of the IFIP  11th  World  Computer  Congress  (San
          Francisco, USA), 1989.


     [Mat06]
          R. Mateescu.  CAESAR_SOLVE: A Generic Library  for  On-
          the-Fly Resolution of Alternation-Free Boolean Equation
          Systems.  Springer International  Journal  on  Software
          Tools for Technology Transfer (STTT), 8(1):37-56, 2006.
          Full version available as  INRIA  Research  Report  RR-
          5948.                   Available                  from
          http://cadp.inria.fr/publications/Mateescu-06-a.html


     [Mil89]
          R. Milner.  Communication and  Concurrency.   Prentice-
          Hall, 1989.


     [Par81]
          D.  Park.   Concurrency  and   Automata   on   Infinite
          Sequences.   In  Peter  Deussen (Ed.), Theoretical Com-
          puter Science, Lecture Notes in Computer  Science  vol.
          104, p. 167-183.  Springer Verlag, March 1981.


AAAAUUUUTTTTHHHHOOOORRRRSSSS
     Radu Mateescu, with the help of Damien  Bergamini  (both  at
     INRIA/VASY), who implemented a first version of the encoding
     of branching equivalence in terms of boolean  equation  sys-
     tems.






(C) INRIA            Last change: 2020/02/12                   10






CADP MANUAL PAGES                              BISIMULATOR(LOCAL)



OOOOPPPPEEEERRRRAAAANNNNDDDDSSSS
     _l_t_s_1....bbbbccccgggg            BCG graph (input)
     _l_t_s_1....eeeexxxxpppp            network of communicating LTSs (input)
     _l_t_s_1....llllttttssss            FSP specification (input)
     _l_t_s_1....llllnnnntttt            LNT specification (input)
     _l_t_s_1....lllloooottttoooossss          LOTOS specification (input)
     _l_t_s_1....sssseeeeqqqq            sequence file (input)
     _l_t_s_2....bbbbccccgggg            BCG graph (input)
     _d_i_a_g....bbbbccccgggg            diagnostic in BCG format (output)
     _f_i_l_e....bbbbeeeessss            BES in textual format (output)


FFFFIIIILLLLEEEESSSS
     The   binary   code   of   bbbbiiiissssiiiimmmmuuuullllaaaattttoooorrrr   is   available   in
     $CADP/bin.`arch`/bisimulator.a


SSSSEEEEEEEE AAAALLLLSSSSOOOO
     bbbbccccgggg(LOCAL),  bbbbccccgggg____ooooppppeeeennnn(LOCAL),  eeeexxxxpppp(LOCAL),  eeeexxxxpppp....ooooppppeeeennnn(LOCAL),
     ffffsssspppp....ooooppppeeeennnn(LOCAL),     llllnnnntttt....ooooppppeeeennnn(LOCAL),     lllloooottttoooossss....ooooppppeeeennnn(LOCAL),
     sssseeeeqqqq(LOCAL), sssseeeeqqqq....ooooppppeeeennnn(LOCAL)

     Additional information is available from the CADP  Web  page
     located at http://cadp.inria.fr

     Directives   for   installation   are   given    in    files
     $$$$CCCCAAAADDDDPPPP////IIIINNNNSSSSTTTTAAAALLLLLLLLAAAATTTTIIIIOOOONNNN____****....

     Recent  changes  and  improvements  to  this  software   are
     reported and commented in file $$$$CCCCAAAADDDDPPPP////HHHHIIIISSSSTTTTOOOORRRRYYYY....


BBBBUUUUGGGGSSSS
     Please report bugs to Radu.Mateescu@inria.fr





















(C) INRIA            Last change: 2020/02/12                   11



