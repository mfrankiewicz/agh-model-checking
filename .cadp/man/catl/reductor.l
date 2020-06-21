


CADP MANUAL PAGES                                 REDUCTOR(LOCAL)



NNNNAAAAMMMMEEEE
     reductor - BCG graph generation using reachability  analysis
     combined with on-the-fly reduction


SSSSYYYYNNNNOOOOPPPPSSSSIIIISSSS
     bbbbccccgggg____ooooppppeeeennnn    [_b_c_g__o_p_t]    _s_p_e_c[....bbbbccccgggg]    [_c_c__o_p_t]     rrrreeeedddduuuuccccttttoooorrrr
     [_r_e_d_u_c_t_o_r__o_p_t] _r_e_s_u_l_t[....bbbbccccgggg]

     or:

     eeeexxxxpppp....ooooppppeeeennnn    [_e_x_p__o_p_t]    _s_p_e_c[....eeeexxxxpppp]    [_c_c__o_p_t]     rrrreeeedddduuuuccccttttoooorrrr
     [_r_e_d_u_c_t_o_r__o_p_t] _r_e_s_u_l_t[....bbbbccccgggg]

     or:

     ffffsssspppp....ooooppppeeeennnn    [_f_s_p__o_p_t]    _s_p_e_c[....llllttttssss]    [_c_c__o_p_t]     rrrreeeedddduuuuccccttttoooorrrr
     [_r_e_d_u_c_t_o_r__o_p_t] _r_e_s_u_l_t[....bbbbccccgggg]

     or:

     llllnnnntttt....ooooppppeeeennnn    [_l_n_t__o_p_t]    _s_p_e_c[....llllnnnntttt]    [_c_c__o_p_t]     rrrreeeedddduuuuccccttttoooorrrr
     [_r_e_d_u_c_t_o_r__o_p_t] _r_e_s_u_l_t[....bbbbccccgggg]

     or:

     lllloooottttoooossss....ooooppppeeeennnn  [_l_o_t_o_s__o_p_t]   _s_p_e_c[....lllloooottttoooossss]   [_c_c__o_p_t]   rrrreeeedddduuuuccccttttoooorrrr
     [_r_e_d_u_c_t_o_r__o_p_t] _r_e_s_u_l_t[....bbbbccccgggg]

     or:

     sssseeeeqqqq....ooooppppeeeennnn    [_s_e_q__o_p_t]    _s_p_e_c[....sssseeeeqqqq]    [_c_c__o_p_t]     rrrreeeedddduuuuccccttttoooorrrr
     [_r_e_d_u_c_t_o_r__o_p_t] _r_e_s_u_l_t[....bbbbccccgggg]


DDDDEEEESSSSCCCCRRRRIIIIPPPPTTTTIIIIOOOONNNN
     This program performs exhaustive reachability  analysis  and
     generates  the  Labelled  Transition System corresponding to
     the BCG graph _s_p_e_c....bbbbccccgggg, the composition expression _s_p_e_c....eeeexxxxpppp,
     the  FSP  program  _s_p_e_c....llllttttssss,  the  LNT program _s_p_e_c....llllnnnntttt, the
     LOTOS program _s_p_e_c....lllloooottttoooossss, or the sequence file _s_p_e_c....sssseeeeqqqq.

     During the generation, this Labelled  Transition  System  is
     reduced  on-the-fly  with respect to a relation chosen among
     strong equivalence,  tau-divergence,  tau-compression,  tau-
     confluence,  tau*.a  equivalence,  safety equivalence, trace
     equivalence,  or  weak  trace  equivalence.   The  resulting
     Labelled  Transition System is encoded in the BCG format and
     stored into file _r_e_s_u_l_t....bbbbccccgggg.

     For most of the above relations, the  rrrreeeedddduuuuccccttttoooorrrr  tool  allows
     two levels of reduction:



(C) INRIA            Last change: 2020/02/12                    1






CADP MANUAL PAGES                                 REDUCTOR(LOCAL)



     -    _P_a_r_t_i_a_l _r_e_d_u_c_t_i_o_n  just  compresses,  cuts,  or  merges
          transitions  of  _s_p_e_c in a way that preserves the given
          relation. In general, partial reduction does not  yield
          a minimal Labelled Transition System.

     -    _T_o_t_a_l  _r_e_d_u_c_t_i_o_n  additionally  merges  on-the-fly  all
          strongly  bisimilar  states  of  the  partially reduced
          Labelled Transition System into a unique representative
          state.  Total  reduction thus yields a Labelled Transi-
          tion System that is minimal modulo strong bisimulation.
          In  general, total reduction does not necessarily yield
          a Labelled Transition System that is minimal modulo the
          chosen  relation,  except  in some cases such as tau*.a
          and safety equivalences.

     By default, rrrreeeedddduuuuccccttttoooorrrr performs only partial reduction.  Total
     reduction  can  be done using the ----ttttoooottttaaaallll option (see OPTIONS
     below).

     Note: The eight relations implemented in rrrreeeedddduuuuccccttttoooorrrr  are  par-
     tially  ordered  from the strongest (strong bisimulation) to
     the weakest (weak trace equivalence) as follows. We  include
     branching bisimulation and observational equivalence in this
     picture, although they are not implemented in rrrreeeedddduuuuccccttttoooorrrr.


                              strong
                                 |
                           +-----+-----+
                           |           |
                           |     tau-divergence
                           |           |
                           |     tau-compression
                           |           |
                           |     tau-confluence
                           |           |
                         trace    (branching)
                           |           |
                           |      +----+----+
                           |      |         |
                           |   tau*.a (observational)
                           |      |         |
                           |      +----+----+
                           |           |
                           |        safety
                           |           |
                           +-----+-----+
                                 |
                             weak trace

     Note: The above order shows that branching bisimulation (and
     weaker  relations)  is  preserved  by  tau-divergence,  tau-



(C) INRIA            Last change: 2020/02/12                    2






CADP MANUAL PAGES                                 REDUCTOR(LOCAL)



     compression, and tau-confluence. Although branching  bisimu-
     lation  is not implemented in rrrreeeedddduuuuccccttttoooorrrr, tau-divergence, tau-
     compression and tau-confluence can thus be used  as  prepro-
     cessing steps for branching bisimulation minimization, which
     itself can be done using bbbbccccgggg____mmmmiiiinnnn(LOCAL).

     Note:  The   tau-divergence,   tau-compression,   and   tau-
     confluence  reductions  remove  some of the internal transi-
     tions, and the tau*.a, safety,  and  weak  trace  reductions
     remove  all  internal  transitions  present  in the Labelled
     Transition System.  These  transitions  are  usually  called
     tau-transitions  in the literature, and are displayed as the
     character string "i" by the various BCG tools.

     Note: Although they reduce the number  of  states  and  they
     eliminate  all tau-transitions, the tau*.a and safety reduc-
     tions may increase the total number of transitions. The weak
     trace reduction may even increase the total number of states
     as it determinizes the Labelled Transition System.


OOOOPPPPTTTTIIIIOOOONNNNSSSS
     The options _b_c_g__o_p_t, if any, are passed to bbbbccccgggg____lllliiiibbbb(LOCAL).


     The options _e_x_p__o_p_t, if any, are passed to eeeexxxxpppp....ooooppppeeeennnn(LOCAL).


     The options _f_s_p__o_p_t, if any, are passed to ffffsssspppp....ooooppppeeeennnn(LOCAL).


     The options _l_n_t__o_p_t, if any, are passed to llllnnnntttt....ooooppppeeeennnn(LOCAL).


     The options _l_o_t_o_s__o_p_t, if any, are passed  to  ccccaaaaeeeessssaaaarrrr(LOCAL)
     and to ccccaaaaeeeessssaaaarrrr....aaaaddddtttt(LOCAL).


     The options _s_e_q__o_p_t, if any, are passed to sssseeeeqqqq....ooooppppeeeennnn(LOCAL).


     The options _c_c__o_p_t, if any, are passed to the C compiler.


     The options _r_e_d_u_c_t_o_r__o_p_t currently available  are  described
     below.

     The options below specify the equivalence relation used  for
     reducing (partially or totally) _s_p_e_c.

     ----ssssaaaaffffeeeettttyyyy
          Generate in _r_e_s_u_l_t....bbbbccccgggg  a  Labelled  Transition  System



(C) INRIA            Last change: 2020/02/12                    3






CADP MANUAL PAGES                                 REDUCTOR(LOCAL)



          (partially    or   totally)   reduced   modulo   safety
          equivalence [BFG+91].  Partial  safety  reduction  both
          eliminates  the  tau-transitions and cuts the _r_e_d_u_n_d_a_n_t
          transitions (as defined in [Mou92]) of _s_p_e_c.  See  also
          the bbbbiiiissssiiiimmmmuuuullllaaaattttoooorrrr(LOCAL) manual page for a formal defini-
          tion of safety equivalence. Not a default option.


     ----ssssttttrrrroooonnnngggg
          Generate in _r_e_s_u_l_t....bbbbccccgggg  a  Labelled  Transition  System
          (partially    or   totally)   reduced   modulo   strong
          equivalence [Par81]. Partial strong reduction  replaces
          duplicate  transitions  (i.e.,  transitions  with  same
          source state, target state,  and  label)  by  a  single
          transition. See also the bbbbiiiissssiiiimmmmuuuullllaaaattttoooorrrr(LOCAL) manual page
          for a formal definition of strong bisimulation.  Not  a
          default option.


     ----ttttaaaauuuuccccoooommmmpppprrrreeeessssssssiiiioooonnnn
          Generate in _r_e_s_u_l_t....bbbbccccgggg  a  Labelled  Transition  System
          (partially  or totally) reduced modulo tau-compression.
          Partial  tau-compression   reduction   eliminates   all
          strongly connected components of tau-transitions.

          Partial  tau-compression  reduction  is  usually   fast
          (linear in the size of the Labelled Transition System).
          Tau-compression reduction preserves branching bisimula-
          tion. Not a default option.


     ----ttttaaaauuuuccccoooonnnnfffflllluuuueeeennnncccceeee
          Generate in _r_e_s_u_l_t....bbbbccccgggg  a  Labelled  Transition  System
          (partially  or  totally)  reduced modulo tau-confluence
          [PLM03], which is a partial order reduction  preserving
          branching  bisimulation.  Tau-confluence  subsumes tau-
          compression,  thus  leading  to  potentially   stronger
          reductions, but it can be slower. Not a default option.


     ----ttttaaaauuuuddddiiiivvvveeeerrrrggggeeeennnncccceeee
          Generate in _r_e_s_u_l_t....bbbbccccgggg  a  Labelled  Transition  System
          (partially  or  totally) reduced modulo tau-divergence.
          Partial tau-divergence reduction replaces each strongly
          connected  component  of  tau-transitions  by  a  self-
          looping tau-transition.

          Partial  tau-divergence  reduction  is   usually   fast
          (linear in the size of the Labelled Transition System).
          Tau-divergence  reduction  preserves   both   branching
          bisimulation and the livelocks of _s_p_e_c.




(C) INRIA            Last change: 2020/02/12                    4






CADP MANUAL PAGES                                 REDUCTOR(LOCAL)



     ----ttttaaaauuuussssttttaaaarrrr
          Generate in _r_e_s_u_l_t....bbbbccccgggg  a  Labelled  Transition  System
          reduced   modulo  tau*.a  equivalence  [FM91].  Partial
          tau*.a  reduction  eliminates  the  tau-transitions  of
          _s_p_e_c. See also the bbbbiiiissssiiiimmmmuuuullllaaaattttoooorrrr(LOCAL) manual page for a
          formal definition of tau*.a equivalence. Default option
          (for backward compatibility with versions 1.* to 3.* of
          rrrreeeedddduuuuccccttttoooorrrr).


     ----ttttrrrraaaacccceeee
          Generate in _r_e_s_u_l_t....bbbbccccgggg  a  Labelled  Transition  System
          reduced  modulo trace equivalence. Partial trace reduc-
          tion  determinizes  _s_p_e_c  using  a  classical  automata
          determinization  algorithm, see section ABOUT TRACE AND
          WEAK TRACE EQUIVALENCES below for  more  details.  This
          option  is  not  compatible  with ----ttttoooottttaaaallll. Not a default
          option.


     ----wwwweeeeaaaakkkkttttrrrraaaacccceeee
          Generate in _r_e_s_u_l_t....bbbbccccgggg  a  Labelled  Transition  System
          reduced  modulo  weak  trace  equivalence. Partial weak
          trace reduction eliminates the tau-transitions of  _s_p_e_c
          and  determinizes  it using a classical automata deter-
          minization algorithm, see section TRACE AND WEAK  TRACE
          EQUIVALENCES below for more details. This option is not
          compatible with ----ttttoooottttaaaallll. Not a default option.


     The options below specify the kind of reduction of _s_p_e_c.

     ----ppppaaaarrrrttttiiiiaaaallll
          Perform partial reduction. Default option.


     ----ttttoooottttaaaallll [ ----ccccllllaaaassssssss ]
          Perform total reduction instead of  partial  reduction.
          The  Labelled Transition System generated in _r_e_s_u_l_t....bbbbccccgggg
          is thus both partially reduced for the chosen  relation
          and minimized modulo strong bisimulation.

          If the ----ccccllllaaaassssssss option is set,  display  the  classes  of
          strongly  bisimilar  states  of  the  partially reduced
          Labelled Transition System on standard output.   Not  a
          default option.

          Note: Although it  yields  generally  smaller  Labelled
          Transition Systems, the ----ttttoooottttaaaallll option often slowers the
          generation.





(C) INRIA            Last change: 2020/02/12                    5






CADP MANUAL PAGES                                 REDUCTOR(LOCAL)



     The options below  specify  various  features  available  in
     addition to the reduction of _s_p_e_c.


     ----mmmmoooonnnniiiittttoooorrrr
          Open a window for monitoring in real-time  the  genera-
          tion of _r_e_s_u_l_t....bbbbccccgggg.


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

          Note that label hiding does not operate on _s_p_e_c, but on
          the Labeled Transition System resulting from the reduc-
          tion of _s_p_e_c. As a consequence, _r_e_s_u_l_t.bbbbccccgggg may  be  not
          minimal with respect to the chosen relation.


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

          Note that label renaming does not operate on _s_p_e_c,  but
          on  the  Labeled  Transition  System resulting from the
          reduction of _s_p_e_c. As a consequence, _r_e_s_u_l_t.bbbbccccgggg may  be
          not minimal with respect to the chosen relation.


          As  for  the  bbbbccccgggg____llllaaaabbbbeeeellllssss(LOCAL)  tool,  several  hiding
          and/or  renaming options can be present on the command-
          line, in which case they are  processed  from  left  to



(C) INRIA            Last change: 2020/02/12                    6






CADP MANUAL PAGES                                 REDUCTOR(LOCAL)



          right.


     ----uuuunnnnccccoooommmmpppprrrreeeessssssss,,,, ----ccccoooommmmpppprrrreeeessssssss,,,, ----rrrreeeeggggiiiisssstttteeeerrrr,,,, ----sssshhhhoooorrrrtttt,,,, ----mmmmeeeeddddiiiiuuuummmm,,,, ----ssssiiiizzzzeeee
          These options control the  form  under  which  the  BCG
          graph  _r_e_s_u_l_t....bbbbccccgggg  is  generated.  See  the  bbbbccccgggg(LOCAL)
          manual page for a description of these options.


     ----ttttmmmmpppp This option specifies the directory in which  temporary
          files  are to be stored. See the bbbbccccgggg(LOCAL) manual page
          for a description of this option.


AAAABBBBOOOOUUUUTTTT TTTTRRRRAAAACCCCEEEE AAAANNNNDDDD WWWWEEEEAAAAKKKK TTTTRRRRAAAACCCCEEEE EEEEQQQQUUUUIIIIVVVVAAAALLLLEEEENNNNCCCCEEEESSSS
     The algorithm used to reduce  _s_p_e_c  modulo  trace  and  weak
     trace  equivalences  is  the classical "subset construction"
     algorithm used to determinize finite automata [ASU86].  Each
     state  _S  of  _r_e_s_u_l_t....bbbbccccgggg corresponds to a set of states {_s_1,
     ..., _s_n} belonging to the input Labelled  Transition  System
     _s_p_e_c.

     Starting from the initial state of _r_e_s_u_l_t....bbbbccccgggg, which is  the
     singleton  set  containing  the  initial  state of _s_p_e_c, the
     transitions going out of each state _S of _r_e_s_u_l_t....bbbbccccgggg are com-
     puted as follows:


     -    In case of trace reduction, for  each  label  _L,  there
          exists a transition _S--_L-->_S' if and only if the set _S'
          = { _s' | exists _s in _S such that  _s--_L-->_s'  }  is  not
          empty.

          In this case, _r_e_s_u_l_t....bbbbccccgggg is  a  deterministic  Labelled
          Transition System, which is trace equivalent to _s_p_e_c.


     -    In case of weak trace reduction, for each visible label
          _L,  there  exists a transition _S--_L-->_S' if and only if
          the set _S' = { _s' | exists _s in _S such that  _s--tau*._L-
          ->_s'  } is not empty, where "tau" denotes the invisible
          label. This definition expresses that  each  transition
          in _r_e_s_u_l_t....bbbbccccgggg results from zero or more invisible tran-
          sitions followed by a visible one.

          In this case, _r_e_s_u_l_t....bbbbccccgggg is  a  deterministic  Labelled
          Transition  System,  does not contain invisible transi-
          tions, and is weakly trace equivalent to _s_p_e_c (i.e., it
          contains  the same transition sequences as _s_p_e_c by con-
          sidering only visible transitions).





(C) INRIA            Last change: 2020/02/12                    7






CADP MANUAL PAGES                                 REDUCTOR(LOCAL)



EEEEXXXXIIIITTTT SSSSTTTTAAAATTTTUUUUSSSS
     Exit status is 0 if everything is alright, 1 otherwise.


DDDDIIIIAAAAGGGGNNNNOOOOSSSSTTTTIIIICCCCSSSS
     When the source is erroneous, error messages are issued.


BBBBIIIIBBBBLLLLIIIIOOOOGGGGRRRRAAAAPPPPHHHHYYYY
     [ASU86]
          A. V. Aho, R. Sethi, and J. D. Ullman. Compilers: Prin-
          ciples, Techniques and Tools. Addison-Wesley, 1986.


     [BFG+91]
          A. Bouajjani, J-C. Fernandez, S.  Graf,  C.  Rodriguez,
          and  J.  Sifakis.  Safety for Branching Time Semantics.
          In Proceedings of 18th  ICALP.  Springer  Verlag,  July
          1991.


     [FM91]
          J-C. Fernandez and L. Mounier. ``On the Fly'' Verifica-
          tion  of  Behavioural Equivalences and Preorders. In K.
          G. Larsen and A. Skou (Eds.), Proceedings  of  the  3rd
          Workshop  on  Computer-Aided  Verification CAV'91 (Aal-
          borg, Denmark), Lecture Notes in Computer Science  vol.
          575. Springer Verlag, July 1991.


     [Mou92]
          Laurent Mounier. Methodes de verification de specifica-
          tions  comportementales :  etude et mise en oeuvre. PhD
          thesis, Universite Joseph Fourier, Grenoble 1, 1992.


     [Par81]
          D.  Park.  Concurrency   and   Automata   on   Infinite
          Sequences. In Peter Deussen (Ed.), Theoretical Computer
          Science, Lecture Notes in Computer Science  vol.   104,
          pages 167-183. Springer Verlag, March 1981.


     [PLM03]
          G. Pace, F. Lang, and  R.  Mateescu.  Calculating  Tau-
          Confluence  Compositionally.   In  W.A.  Hunt Jr and F.
          Somenzi (Eds.), Proceedings of the 15th  Computer-Aided
          Verification  conference  CAV'2003  (Boulder, Colorado,
          USA), Lecture Notes  in  Computer  Science  vol.  2725.
          Springer    Verlag,    July    2003.   Available   from
          http://cadp.inria.fr/publications/Pace-Lang-Mateescu-
          03.html



(C) INRIA            Last change: 2020/02/12                    8






CADP MANUAL PAGES                                 REDUCTOR(LOCAL)



AAAAUUUUTTTTHHHHOOOORRRRSSSS
     Versions 1.*, 2.*, and 3.* of rrrreeeedddduuuuccccttttoooorrrr have  been  developed
     by Hubert Garavel.

     Version 4.* of rrrreeeedddduuuuccccttttoooorrrr was developed by Frederic  Lang  and
     Radu Mateescu (INRIA Rhone-Alpes).

     Version 5.* of rrrreeeedddduuuuccccttttoooorrrr, merging features previously belong-
     ing  to ddddeeeetttteeeerrrrmmmmiiiinnnnaaaattttoooorrrr(LOCAL), was developed by Frederic Lang,
     with advices of Hubert Garavel and Radu Mateescu.


OOOOPPPPEEEERRRRAAAANNNNDDDDSSSS
     _s_p_e_c....bbbbccccgggg            BCG graph (input)
     _s_p_e_c....eeeexxxxpppp            network of communicating LTSs (input)
     _s_p_e_c....llllttttssss            FSP specification (input)
     _s_p_e_c....llllnnnntttt            LNT specification (input)
     _s_p_e_c....lllloooottttoooossss          LOTOS specification (input)
     _s_p_e_c....sssseeeeqqqq            sequence file (input)


FFFFIIIILLLLEEEESSSS
     The   binary   code   of   rrrreeeedddduuuuccccttttoooorrrr    is    available    in
     $CADP/bin.`arch`/reductor.a


     See   the   ccccaaaaeeeessssaaaarrrr____hhhhiiiiddddeeee____1111(LOCAL),    ccccaaaaeeeessssaaaarrrr____rrrreeeennnnaaaammmmeeee____1111(LOCAL),
     bbbbccccgggg____llllaaaabbbbeeeellllssss(LOCAL)  manual  pages for a description of hiding
     and renaming conventions.


SSSSEEEEEEEE AAAALLLLSSSSOOOO
     OPEN/CAESAR Reference Manual,  bbbbccccgggg(LOCAL),  bbbbccccgggg____ooooppppeeeennnn(LOCAL),
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
     Please report new bugs to cadp@inria.fr




(C) INRIA            Last change: 2020/02/12                    9






CADP MANUAL PAGES                                 REDUCTOR(LOCAL)























































(C) INRIA            Last change: 2020/02/12                   10






