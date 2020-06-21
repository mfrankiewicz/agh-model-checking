


CADP MANUAL PAGES                                PROJECTOR(LOCAL)



NNNNAAAAMMMMEEEE
     projector -  semi-composition  and  generation  of  Labelled
     Transition Systems


SSSSYYYYNNNNOOOOPPPPSSSSIIIISSSS
     bbbbccccgggg____ooooppppeeeennnn    [_b_c_g__o_p_t]    _s_p_e_c[....bbbbccccgggg]    [_c_c__o_p_t]    pppprrrroooojjjjeeeeccccttttoooorrrr
     [_p_r_o_j_e_c_t_o_r__o_p_t] _i_n_t_e_r_f_a_c_e[....bbbbccccgggg] _r_e_s_u_l_t[....bbbbccccgggg]

     or:

     eeeexxxxpppp....ooooppppeeeennnn    [_e_x_p__o_p_t]    _s_p_e_c[....eeeexxxxpppp]    [_c_c__o_p_t]    pppprrrroooojjjjeeeeccccttttoooorrrr
     [_p_r_o_j_e_c_t_o_r__o_p_t] _i_n_t_e_r_f_a_c_e[....bbbbccccgggg] _r_e_s_u_l_t[....bbbbccccgggg]

     or:

     ffffsssspppp....ooooppppeeeennnn    [_f_s_p__o_p_t]    _s_p_e_c[....llllttttssss]    [_c_c__o_p_t]    pppprrrroooojjjjeeeeccccttttoooorrrr
     [_p_r_o_j_e_c_t_o_r__o_p_t] _i_n_t_e_r_f_a_c_e[....bbbbccccgggg] _r_e_s_u_l_t[....bbbbccccgggg]

     or:

     llllnnnntttt....ooooppppeeeennnn    [_l_n_t__o_p_t]    _s_p_e_c[....llllnnnntttt]    [_c_c__o_p_t]    pppprrrroooojjjjeeeeccccttttoooorrrr
     [_p_r_o_j_e_c_t_o_r__o_p_t] _i_n_t_e_r_f_a_c_e[....bbbbccccgggg] _r_e_s_u_l_t[....bbbbccccgggg]

     or:

     lllloooottttoooossss....ooooppppeeeennnn  [_l_o_t_o_s__o_p_t]  _s_p_e_c[....lllloooottttoooossss]   [_c_c__o_p_t]   pppprrrroooojjjjeeeeccccttttoooorrrr
     [_p_r_o_j_e_c_t_o_r__o_p_t] _i_n_t_e_r_f_a_c_e[....bbbbccccgggg] _r_e_s_u_l_t[....bbbbccccgggg]

     or:

     sssseeeeqqqq....ooooppppeeeennnn    [_s_e_q__o_p_t]    _s_p_e_c[....sssseeeeqqqq]    [_c_c__o_p_t]    pppprrrroooojjjjeeeeccccttttoooorrrr
     [_p_r_o_j_e_c_t_o_r__o_p_t] _i_n_t_e_r_f_a_c_e[....bbbbccccgggg] _r_e_s_u_l_t[....bbbbccccgggg]


DDDDEEEESSSSCCCCRRRRIIIIPPPPTTTTIIIIOOOONNNN
     pppprrrroooojjjjeeeeccccttttoooorrrr takes two different inputs:


     -    A Labelled Transition System (LTS), expressed either as
          a   BCG   graph   _s_p_e_c....bbbbccccgggg,,,,  a  composition  expression
          _s_p_e_c....eeeexxxxpppp,,,, an  FSP  program  _s_p_e_c....llllttttssss,,,,  an  LNT  program
          _s_p_e_c....llllnnnntttt,,,,  a  LOTOS  program  _s_p_e_c....lllloooottttoooossss,,,, or a sequence
          file _s_p_e_c....sssseeeeqqqq....


     -    An LTS contained in the file _i_n_t_e_r_f_a_c_e[....bbbbccccgggg].


     pppprrrroooojjjjeeeeccccttttoooorrrr performs the semi-composition of _s_p_e_c with respect
     to  the LTS _i_n_t_e_r_f_a_c_e and using a synchronization set deter-
     mined by the ----ssssyyyynnnncccc option.



(C) INRIA            Last change: 2020/02/12                    1






CADP MANUAL PAGES                                PROJECTOR(LOCAL)



     The resulting LTS is stored in _r_e_s_u_l_t, in BCG format.

     The semantics of the semi-composition operator is  given  in
     $$$$CCCCAAAADDDDPPPP////ddddoooocccc////****////KKKKrrrriiiimmmmmmmm----MMMMoooouuuunnnniiiieeeerrrr----99997777....**** and in Section FFFFOOOORRRRMMMMAAAALLLL DDDDEEEEFFFFIIIINNNNIIII----
     TTTTIIIIOOOONNNN OOOOFFFF SSSSEEEEMMMMIIII----CCCCOOOOMMMMPPPPOOOOSSSSIIIITTTTIIIIOOOONNNN below.

     In a few words, pppprrrroooojjjjeeeeccccttttoooorrrr reduces the LTS _s_p_e_c by  suppress-
     ing  the transitions that are not possible when _s_p_e_c is syn-
     chronized with _i_n_t_e_r_f_a_c_e, with respect to a given synchroni-
     zation set (see ----ssssyyyynnnncccc option below). The way transitions are
     suppressed depends on  the  nature  of  the  interface.  See
     option ----uuuusssseeeerrrriiiinnnntttteeeerrrrffffaaaacccceeee for details.


OOOOPPPPTTTTIIIIOOOONNNNSSSS
     _b_c_g__o_p_t
          if any, are passed to bbbbccccgggg____lllliiiibbbb(LOCAL).

     _e_x_p__o_p_t
          if any, are passed to eeeexxxxpppp....ooooppppeeeennnn(LOCAL).

     _f_s_p__o_p_t
          if any, are passed to ffffsssspppp....ooooppppeeeennnn(LOCAL).

     _l_n_t__o_p_t
          if any, are passed to llllnnnntttt....ooooppppeeeennnn(LOCAL).

     _l_o_t_o_s__o_p_t
          if   any,   are    passed    to    ccccaaaaeeeessssaaaarrrr(LOCAL)    and
          ccccaaaaeeeessssaaaarrrr....aaaaddddtttt(LOCAL).

     _s_e_q__o_p_t
          if any, are passed to sssseeeeqqqq....ooooppppeeeennnn(LOCAL).

     _c_c__o_p_t
          if any, are passed to the C compiler.

     The following options _p_r_o_j_e_c_t_o_r__o_p_t are currently available:


     -mmmmoooonnnniiiittttoooorrrr
          Open a window for monitoring in real-time  the  genera-
          tion of _r_e_s_u_l_t._b_c_g.  This is not a default option.


     ----ssssyyyynnnncccc  [[[[----ttttoooottttaaaallll||||----ppppaaaarrrrttttiiiiaaaallll||||----ggggaaaatttteeee]]]] _s_y_n_c-_f_i_l_e
          Use the synchronization rules defined in _s_y_n_c-_f_i_l_e. The
          ----ttttoooottttaaaallll,  ----ppppaaaarrrrttttiiiiaaaallll, and ----ggggaaaatttteeee options specify the "total
          matching",  "partial  matching",  and  "gate  matching"
          semantics, respectively.

          In "total matching" semantics, the regular  expressions



(C) INRIA            Last change: 2020/02/12                    2






CADP MANUAL PAGES                                PROJECTOR(LOCAL)



          contained  in _s_y_n_c-_f_i_l_e denote full labels (i.e., gates
          possibly followed by experiment offers).  Each  transi-
          tion of _s_p_e_c carrying a label that matches some rule in
          _s_y_n_c-_f_i_l_e must be synchronized  with  a  transition  of
          _i_n_t_e_r_f_a_c_e carrying the same label.

          In "partial matching" semantics,  the  regular  expres-
          sions  contained  in  _s_y_n_c-_f_i_l_e  denote  substrings  of
          labels. Each transition of _s_p_e_c  carrying  a  label,  a
          substring of which matches some rule in _s_y_n_c-_f_i_l_e, must
          be synchronized with a transition of _i_n_t_e_r_f_a_c_e carrying
          the same label.

          At last, in  "gate  matching"  semantics,  the  regular
          expressions  contained  in _s_y_n_c-_f_i_l_e denote gates. Each
          transition of _s_p_e_c carrying a label, the first word  of
          which  (called  gate)  matches  some rule in _s_y_n_c-_f_i_l_e,
          must be synchronized with  a  transition  of  _i_n_t_e_r_f_a_c_e
          carrying the same label.  In this case, regular expres-
          sions in the synchronization  set  should  not  contain
          characters  forbidden  in  gate identifiers (e.g., " ",
          "(", or "!").

          Option ----ttttoooottttaaaallll is the default.


     ----hhhhiiiiddddeeee [[[[ ----ttttoooottttaaaallll |||| ----ppppaaaarrrrttttiiiiaaaallll |||| ----ggggaaaatttteeee ]]]] _h_i_d_i_n_g__f_i_l_e_n_a_m_e
          Use the hiding rules defined in _h_i_d_i_n_g__f_i_l_e_n_a_m_e to hide
          (on the fly) the labels of the LTS being generated. See
          the ccccaaaaeeeessssaaaarrrr____hhhhiiiiddddeeee____1111(LOCAL) manual  page  for  a  detailed
          description    of    the    appropriate    format   for
          _h_i_d_i_n_g__f_i_l_e_n_a_m_e.

          The ----ttttoooottttaaaallll, ----ppppaaaarrrrttttiiiiaaaallll, and  ----ggggaaaatttteeee  options  specify  the
          "total  matching", "partial matching", and "gate match-
          ing"     semantics,     respectively.      See      the
          ccccaaaaeeeessssaaaarrrr____hhhhiiiiddddeeee____1111(LOCAL) manual page for more details about
          these semantics. Option ----ttttoooottttaaaallll is the default.

          Note that label hiding does not operate on _s_p_e_c, but on
          the  LTS  resulting  from  the semi-composition of _s_p_e_c
          with respect to _i_n_t_e_r_f_a_c_e.bbbbccccgggg.


     ----rrrreeeennnnaaaammmmeeee [[[[----ttttoooottttaaaallll||||----ssssiiiinnnngggglllleeee||||----mmmmuuuullllttttiiiipppplllleeee||||----ggggaaaatttteeee]]]] _r_e_n_a_m_i_n_g__f_i_l_e_n_a_m_e

          Use the renaming rules defined in _r_e_n_a_m_i_n_g__f_i_l_e_n_a_m_e  to
          rename  (on  the  fly) the labels of the LTS being gen-
          erated. See the ccccaaaaeeeessssaaaarrrr____rrrreeeennnnaaaammmmeeee____1111(LOCAL) manual page  for
          a  detailed  description  of the appropriate format for
          _r_e_n_a_m_i_n_g__f_i_l_e_n_a_m_e.




(C) INRIA            Last change: 2020/02/12                    3






CADP MANUAL PAGES                                PROJECTOR(LOCAL)



          The  ----ttttoooottttaaaallll,  ----ssssiiiinnnngggglllleeee,  ----mmmmuuuullllttttiiiipppplllleeee,  and  ----ggggaaaatttteeee  options
          specify  the  "total  matching", "single partial match-
          ing", "multiple partial matching", and "gate  matching"
          semantics, respectively. See the ccccaaaaeeeessssaaaarrrr____rrrreeeennnnaaaammmmeeee____1111(LOCAL)
          manual page for more  details  about  these  semantics.
          Option ----ttttoooottttaaaallll is the default.

          As  for  the  bbbbccccgggg____llllaaaabbbbeeeellllssss(LOCAL)  tool,  several  hiding
          and/or  renaming options can be present on the command-
          line, in which case they are  processed  from  left  to
          right.   However,  the  semi-composition  (synchroniza-
          tions) is always performed before hiding and/or  renam-
          ing.   Note  that  hiding  and renaming only affect the
          part of refused labels that follow the "fail: " string.

          Note that label renaming does not operate on _s_p_e_c,  but
          on  the LTS resulting from the semi-composition of _s_p_e_c
          with respect to _i_n_t_e_r_f_a_c_e.bbbbccccgggg.


     -uuuusssseeeerrrriiiinnnntttteeeerrrrffffaaaacccceeee |||| ----iiiinnnntttteeeerrrrffffaaaacccceeeeuuuusssseeeerrrr
          This option is used when _i_n_t_e_r_f_a_c_e  is  a  "user-given"
          interface,  in which case pppprrrroooojjjjeeeeccccttttoooorrrr computes validation
          predicate in the form of _r_e_f_u_s_e_d _t_r_a_n_s_i_t_i_o_n_s, in  order
          to  check  the  validity  of this interface.  A refused
          transition is identified by  its  label,  which  begins
          with  the  string "fail: ". Such a label may be present
          in _s_p_e_c, but not in _i_n_t_e_r_f_a_c_e. When  -uuuusssseeeerrrriiiinnnntttteeeerrrrffffaaaacccceeee  is
          specified,  pppprrrroooojjjjeeeeccccttttoooorrrr  may  produce new refused transi-
          tions in addition to those already existing in _s_p_e_c.

          Note that this option does not make  sense  outside  an
          entire  compositional  generation  process  and  it  is
          mainly used by the ssssvvvvllll tool. The validation  predicates
          are  checked  by the eeeexxxxpppp....ooooppppeeeennnn tool, with ----iiiinnnntttteeeerrrrffffaaaacccceeeeuuuusssseeeerrrr
          option.  This is not a default option.


     ----uuuunnnnccccoooommmmpppprrrreeeessssssss,,,, ----ccccoooommmmpppprrrreeeessssssss,,,, ----rrrreeeeggggiiiisssstttteeeerrrr,,,, ----sssshhhhoooorrrrtttt,,,, ----mmmmeeeeddddiiiiuuuummmm,,,, ----ssssiiiizzzzeeee
          These options control the  form  under  which  the  BCG
          graph  _r_e_s_u_l_t....bbbbccccgggg  is  generated.  See  the  bbbbccccgggg(LOCAL)
          manual page for a description of these options.


     ----ttttmmmmpppp This option specifies the directory in which  temporary
          files  are to be stored. See the bbbbccccgggg(LOCAL) manual page
          for a description of this option.


PPPPRRRROOOOJJJJEEEECCCCTTTTOOOORRRR UUUUSSSSAAAAGGGGEEEE
     Even if pppprrrroooojjjjeeeeccccttttoooorrrr may be used by the command line  described
     in  the  SSSSYYYYNNNNOOOOPPPPSSSSIIIISSSS  section,  it is mainly used by ssssvvvvllll(_L_O_C_A_L)



(C) INRIA            Last change: 2020/02/12                    4






CADP MANUAL PAGES                                PROJECTOR(LOCAL)



     with ssssvvvvllll script lines like:

     """"ssssppppeeeecccc....lllloooottttoooossss"""" ----|||||||| """"iiiinnnntttteeeerrrrffffaaaacccceeee....bbbbccccgggg""""
     """"ssssppppeeeecccc....lllloooottttoooossss"""" ----||||[[[[GGGG1111,,,, GGGG2222]]]]|||| """"iiiinnnntttteeeerrrrffffaaaacccceeee....bbbbccccgggg""""

FFFFOOOORRRRMMMMAAAATTTT FFFFOOOORRRR IIIINNNNPPPPUUUUTTTT LLLLAAAABBBBEEEELLLLLLLLEEEEDDDD TTTTRRRRAAAANNNNSSSSIIIITTTTIIIIOOOONNNN SSSSYYYYSSSSTTTTEEEEMMMMSSSS
     The LTS expressed by _s_p_e_c does not have any restriction.  In
     particular, it may contain refused transitions (i.e., labels
     prefixed by the special marker "fail: ").


     The LTS contained in _i_n_t_e_r_f_a_c_e may not contain refused tran-
     sitions.  No  other  constraint is imposed (for instance, it
     may have non deterministic transitions).

     Note: Minimizing _i_n_t_e_r_f_a_c_e for safety equivalence after hid-
     ing  all labels that are not accepted by the synchronization
     set is likely to improve the time and space performances  of
     pppprrrroooojjjjeeeeccccttttoooorrrr,  while  not  changing  the resulting LTS. In ssssvvvvllll,
     those two operations are automatically performed before cal-
     ling pppprrrroooojjjjeeeeccccttttoooorrrr.


FFFFOOOORRRRMMMMAAAATTTT FFFFOOOORRRR OOOOUUUUTTTTPPPPUUUUTTTT LLLLAAAABBBBEEEELLLLLLLLEEEEDDDD TTTTRRRRAAAANNNNSSSSIIIITTTTIIIIOOOONNNN SSSSYYYYSSSSTTTTEEEEMMMM
     The resulting LTS (_r_e_s_u_l_t[....bbbbccccgggg]) may contain refused transi-
     tions.  Such  refused transitions form a loop from one state
     to the same state with a label prefixed by "fail: ".


FFFFOOOORRRRMMMMAAAATTTT FFFFOOOORRRR SSSSYYYYNNNNCCCCHHHHRRRROOOONNNNIIIIZZZZAAAATTTTIIIIOOOONNNN SSSSEEEETTTTSSSS
     The description of the synchronization set is made through a
     file, which must respect the following grammar:


     <<<<ssssyyyynnnncccc----sssseeeetttt>>>>        ::::::::====  <<<<ppppoooossssiiiittttiiiivvvveeee----hhhheeeeaaaaddddeeeerrrr>>>> ''''\\\\nnnn'''' <<<<llllaaaabbbbeeeellll----lllliiiisssstttt>>>>
                        ||||   <<<<nnnneeeeggggaaaattttiiiivvvveeee----hhhheeeeaaaaddddeeeerrrr>>>> ''''\\\\nnnn'''' <<<<llllaaaabbbbeeeellll----lllliiiisssstttt>>>>
     <<<<llllaaaabbbbeeeellll----lllliiiisssstttt>>>>      ::::::::====  <<<<llllaaaabbbbeeeellll>>>>
                        ||||   <<<<llllaaaabbbbeeeellll>>>> ''''\\\\nnnn'''' <<<<llllaaaabbbbeeeellll----lllliiiisssstttt>>>>
     <<<<llllaaaabbbbeeeellll>>>>           ::::::::====  <<<<rrrreeeeggggeeeexxxxpppp----ddddeeeennnnoooottttiiiinnnngggg----aaaa----llllaaaabbbbeeeellll>>>>
     <<<<ppppoooossssiiiittttiiiivvvveeee----hhhheeeeaaaaddddeeeerrrr>>>> ::::::::====  ''''SSSSyyyynnnncccc''''
                        ||||   ''''ssssyyyynnnncccc''''
     <<<<nnnneeeeggggaaaattttiiiivvvveeee----hhhheeeeaaaaddddeeeerrrr>>>> ::::::::====  ''''SSSSyyyynnnncccc aaaallllllll bbbbuuuutttt''''
                        ||||   ''''ssssyyyynnnncccc aaaallllllll bbbbuuuutttt''''


     If the header is a positive header,  any  label  matching  a
     regular  expression  of  the  file  will  be  considered  as
     accepted by the synchronization set. On the contrary, if the
     header  is  a negative header, any label that does not match
     any regular expression of the file  will  be  considered  as
     accepted by the synchronization set.




(C) INRIA            Last change: 2020/02/12                    5






CADP MANUAL PAGES                                PROJECTOR(LOCAL)



     The synchronization set should not accept any label prefixed
     by "fail: " if there is any in the graph module. The special
     label "i" should not be accepted by the synchronization set.
     If it does, a warning is issued but "i" is not synchronized.

     When no synchronisation set is given, the synchronisation is
     performed  on  all  labels of _s_p_e_c and _i_n_t_e_r_f_a_c_e, except the
     hidden label "i".


FFFFOOOORRRRMMMMAAAALLLL DDDDEEEEFFFFIIIINNNNIIIITTTTIIIIOOOONNNN OOOOFFFF SSSSEEEEMMMMIIII----CCCCOOOOMMMMPPPPOOOOSSSSIIIITTTTIIIIOOOONNNN
     First of all, remind that an LTS is defined  formally  as  a
     tuple  (Q,  A,  T, q0), where Q is the set of states, A is a
     set of actions, T is the transition relation between states,
     and q0 is the initial state.

     Let S1 and S2 be two LTSs, and SYNC be a set of labels  (the
     synchronization  set).  We write (S1 |[SYNC]| S2) the paral-
     lel composition of S1 and S2, using an  extension  of  LOTOS
     parallel   composition,  where  SYNC  contains  full  labels
     instead of gates.

     The semi-composition (S1 -|[SYNC]| S2) is the LTS (Q, A,  T,
     q0) defined as follows:

     -    Q is the set of states p1 of  S1  such  that  for  some
          state  p2  of S2, (p1, p2) is reachable in (S1 |[SYNC]|
          S2).

     -    T is the set of transitions (p1, a, q1) of S1 such that
          for  some states p2, q2 of S2 there exists a transition
          ((p1, p2), a, (q1, q2)) in (S1 |[SYNC]| S2).

     -    q0 is the initial state of S1.


FFFFRRRREEEEQQQQUUUUEEEENNNNTTTTLLLLYYYY AAAASSSSKKKKEEEEDDDD QQQQUUUUEEEESSSSTTTTIIIIOOOONNNNSSSS AAAABBBBOOOOUUUUTTTT SSSSEEEEMMMMIIII----CCCCOOOOMMMMPPPPOOOOSSSSIIIITTTTIIIIOOOONNNN
     In the sequel, we describe LTSs as sets  of  transitions  of
     the  form  q  -a->  q'.  The initial state will be generally
     noted q0, and sets of  states  and  actions  can  be  easily
     reconstructed from the transition relation.

     Q:   Does (S1 -|[SYNC]| S2)  have  always  less  states  and
          transitions than S1?

     A:   Yes. One can see from the mathematical definition  that
          (S1  -|[SYNC]| S2) cannot have more than the states and
          transitions of S1.

     Q:   If LTS S1 is minimal  modulo  an  equivalence  relation
          (e.g., strong, branching, etc.), will (S1 -|[SYNC]| S2)
          be also a minimal LTS?



(C) INRIA            Last change: 2020/02/12                    6






CADP MANUAL PAGES                                PROJECTOR(LOCAL)



     A:   No, as shows the following example.  Take  the  minimal
          LTS  S1  =  {q0  -a->  q1, q0 -a-> q2, q1 -b-> q3}. The
          semi-composition (S1 -|[b]| S2), where  S2  contains  a
          unique state and no transition, results in {q0 -a-> q1,
          q0 -a-> q2}, which  is  not  minimal  (q1  and  q2  are
          equivalent states).

     Q:   Starting from an LTS  S1,  I  made  the  following  two
          experiments: (1) simply minimize S1; (2) first restrict
          S1 by semi-composition and then  minimize  the  result.
          Amazingly the LTS obtained by experiment (2) was larger
          than that obtained by experiment (1). Is this normal?

     A:   Yes, this may happen, for instance, if semi-composition
          breaks  some symmetry in S1.  Take S1 = {q0 -a-> q1, q1
          -a-> q2, q2 -a-> q0}. Experiment (1), i.e.,  minimizing
          S1  yields S2 = {q0 -a-> q0}.  Experiment (2) using (S1
          -|[a]| S3) with S3 =  {q0 -a-> q1, q1 -a->  q2}  yields
          S3,  which  is  minimal.  S3 is effectively larger than
          S2.

     Q:   Are standard equivalence relations congruences for  the
          semi-composition operator.

     A:   No. Take LTSs S1, S2, and S3 defined in previous  exam-
          ple.  S1  and  S2  are  equivalent,  but (S1 -|[a]| S3)
          (which is equal to S3) is not equivalent to (S2  -|[a]|
          S3)  (which is equal to S2).  However, most equivalence
          relations (strong,  branching,  observational,  tau*.a,
          safety)  are  semi-congruences for semi-composition, in
          the sense that minimizing the interface will not  alter
          the result of semi-composition.


EEEEXXXXIIIITTTT SSSSTTTTAAAATTTTUUUUSSSS
     Exit status is 0 if everything is alright, 1 otherwise.


DDDDIIIIAAAAGGGGNNNNOOOOSSSSTTTTIIIICCCCSSSS
     When the source is erroneous, error messages are issued.


BBBBIIIIBBBBLLLLIIIIOOOOGGGGRRRRAAAAPPPPHHHHYYYY
     -    Jean-Pierre Krimm. Une Approche Pratique pour la Verif-
          ication  Compositionnelle  de Programmes LOTOS. Memoire
          de Magistere, September 1996. (In French.)

     -    Jean-Pierre Krimm and  Laurent  Mounier.  Compositional
          State Space Generation from Lotos Programs. In Proceed-
          ings of TACAS'97, Tools and  Algorithms  for  the  Con-
          struction   and  Analysis  of  Systems  (University  of
          Twente,  Enschede,  The   Netherlands),   April   1997.



(C) INRIA            Last change: 2020/02/12                    7






CADP MANUAL PAGES                                PROJECTOR(LOCAL)



          Available                                          from
          http://cadp.inria.fr/publications/Krimm-Mounier-97.html

     -    Hubert Garavel. OPEN/CAESAR: An Open Software Architec-
          ture  for  Verification,  Simulation,  and  Testing. In
          Proceedings of the First  International  Conference  on
          Tools  and Algorithms for the Construction and Analysis
          of  Systems  TACAS'98,  March  1998.   Available   from
          http://cadp.inria.fr/publications/Garavel-98.html

     -    Hubert  Garavel,  Frederic  Lang.  SVL:   a   Scripting
          Language for Compositional Verification. In Proceedings
          of the 21st IFIP WG  6.1  International  Conference  on
          Formal Techniques for Networked and Distributed Systems
          FORTE'2001 (Cheju Island, Korea), August 2001.   Avail-
          able   from  http://cadp.inria.fr/publications/Garavel-
          Lang-01.html


AAAAUUUUTTTTHHHHOOOORRRRSSSS
     Version 1.x of pppprrrroooojjjjeeeeccccttttoooorrrr was developped by Jean-Pierre Krimm
     using  an  algorithm  written by Laurent Mounier and himself
     (VERIMAG).

     Version 2.x of pppprrrroooojjjjeeeeccccttttoooorrrr was totally rewritten from  scratch
     by Gordon Pace, Bruno Ondet, Nicolas Descoubes, and Frederic
     Lang (INRIA Rhone-Alpes/VASY).

     Version 3.x of pppprrrroooojjjjeeeeccccttttoooorrrr was  partially  rewritten  by  Remi
     Herilier and Frederic Lang (INRIA Rhone-Alpes/VASY).


OOOOPPPPEEEERRRRAAAANNNNDDDDSSSS
     _s_p_e_c....bbbbccccgggg          BCG graph (input)
     _s_p_e_c....eeeexxxxpppp          network of communicating LTSs (input)
     _s_p_e_c....llllttttssss          FSP specification (input)
     _s_p_e_c....llllnnnntttt          LNT specification (input)
     _s_p_e_c....lllloooottttoooossss        LOTOS specification (input)
     _s_p_e_c....sssseeeeqqqq          sequence file (input)
     _i_n_t_e_r_f_a_c_e....bbbbccccgggg     interface LTS (input)
     _s_y_n_c-_f_i_l_e....ssssyyyynnnncccc    set of synchronization labels (input)
     _r_e_s_u_l_t....bbbbccccgggg        BCG graph (output)

FFFFIIIILLLLEEEESSSS
     The   binary   code   of   pppprrrroooojjjjeeeeccccttttoooorrrr   is    available    in
     $$$$CCCCAAAADDDDPPPP////bbbbiiiinnnn....````aaaarrrrcccchhhh````////pppprrrroooojjjjeeeeccccttttoooorrrr....aaaa

SSSSEEEEEEEE AAAALLLLSSSSOOOO
     CAESAR  Reference  Manual,  OPEN/CAESAR  Reference   Manual,
     bbbbccccgggg(LOCAL),      bbbbccccgggg____ooooppppeeeennnn(LOCAL),      ccccaaaaeeeessssaaaarrrr____hhhhiiiiddddeeee____1111(LOCAL),
     ccccaaaaeeeessssaaaarrrr____rrrreeeennnnaaaammmmeeee____1111(LOCAL),  ccccaaaaeeeessssaaaarrrr(LOCAL),   ccccaaaaeeeessssaaaarrrr....aaaaddddtttt(LOCAL),
     eeeexxxxpppp(LOCAL),         eeeexxxxpppp....ooooppppeeeennnn(LOCAL),        ffffsssspppp....ooooppppeeeennnn(LOCAL),



(C) INRIA            Last change: 2020/02/12                    8






CADP MANUAL PAGES                                PROJECTOR(LOCAL)



     llllnnnntttt....ooooppppeeeennnn(LOCAL),      lllloooottttoooossss(LOCAL),       lllloooottttoooossss....ooooppppeeeennnn(LOCAL),
     sssseeeeqqqq(LOCAL), sssseeeeqqqq....ooooppppeeeennnn(LOCAL), ssssvvvvllll(LOCAL)


     Additional information is available from the CADP  Web  page
     located at http://cadp.inria.fr

     Directives   for   installation   are   given    in    files
     $$$$CCCCAAAADDDDPPPP////IIIINNNNSSSSTTTTAAAALLLLLLLLAAAATTTTIIIIOOOONNNN____****....

     Recent  changes  and  improvements  to  this  software   are
     reported and commented in file $$$$CCCCAAAADDDDPPPP////HHHHIIIISSSSTTTTOOOORRRRYYYY....


BBBBUUUUGGGGSSSS
     Please report new bugs to cadp@inria.fr







































(C) INRIA            Last change: 2020/02/12                    9



