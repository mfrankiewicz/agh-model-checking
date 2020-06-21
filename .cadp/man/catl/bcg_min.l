


CADP MANUAL PAGES                                  BCG_MIN(LOCAL)



NNNNAAAAMMMMEEEE
     bcg_min - minimization of normal, probabilistic, or stochas-
     tic  labeled  transitions  systems  (LTS) encoded in the BCG
     format


SSSSYYYYNNNNOOOOPPPPSSSSIIIISSSS
     bbbbccccgggg____mmmmiiiinnnn [_b_c_g__o_p_t_i_o_n_s] [----ssssttttrrrroooonnnngggg | ----bbbbrrrraaaannnncccchhhhiiiinnnngggg |  ----ddddiiiivvvvbbbbrrrraaaannnncccchhhhiiiinnnngggg
     |  ----oooobbbbsssseeeerrrrvvvvaaaattttiiiioooonnnnaaaallll]  [----nnnnoooorrrrmmmmaaaallll  |  ----pppprrrroooobbbb  |  ----rrrraaaatttteeee [----sssseeeellllffff]] [----
     eeeeppppssssiiiilllloooonnnn _e_p_s]  [----ffffoooorrrrmmmmaaaatttt  _f_o_r_m_a_t__s_t_r_i_n_g]  [----ccccllllaaaassssssss  _c_l_a_s_s__f_i_l_e]
     _i_n_p_u_t....bbbbccccgggg [_o_u_t_p_u_t....bbbbccccgggg]

     where _b_c_g__o_p_t_i_o_n_s is defined below (see GENERAL OPTIONS).

     bbbbccccgggg____mmmmiiiinnnn takes as input the BCG  graph  _i_n_p_u_t....bbbbccccgggg,  minimizes
     this  graph  according  to  some  bisimulation relation, and
     writes the resulting reduced graph to _o_u_t_p_u_t....bbbbccccgggg,  replacing
     _i_n_p_u_t....bbbbccccgggg if _o_u_t_p_u_t....bbbbccccgggg is omitted.


DDDDEEEESSSSCCCCRRRRIIIIPPPPTTTTIIIIOOOONNNN
     bbbbccccgggg____mmmmiiiinnnn implements various algorithms to  perform  minimiza-
     tion of graphs encoded in the BCG format according to strong
     bisimulation, branching  bisimulation,  divergence-sensitive
     branching  bisimulation,  or  observational  equivalence.  A
     graph input or output by bbbbccccgggg____mmmmiiiinnnn can be:


     -    either a "normal" LTS,  whose  transitions  are  either
          labelled  with  "normal"  labels or with the "internal"
          label (usually noted "tau" in the scientific literature
          and  displayed as the character string "iiii" by the vari-
          ous BCG tools),


     -    or a "probabilistic LTS": these are LTS  with  "normal"
          labelled transitions, as well as "special" transitions,
          whose labels  are  either  of  the  form  "pppprrrroooobbbb %%%%pppp"  or
          "_l_a_b_e_l;;;; pppprrrroooobbbb %%%%pppp",  where  %%%%pppp  denotes  a floating-point
          number in the range ]0..1] and _l_a_b_e_l denotes a  charac-
          ter string that does not contain the ";;;;" character. For
          each state, the sum of "%%%%pppp" values on  special  transi-
          tions  leaving  the  state must be less or equal than 1
          (see ANNEX 1 below for a discussion on how  the  proba-
          bilistic   LTS   model  of  bbbbccccgggg____mmmmiiiinnnn  generalizes  other
          theoretical models published in the literature),


     -    or a "stochastic LTS":  these  are  LTS  with  "normal"
          labelled transitions, as well as "special" transitions,
          whose labels  are  either  of  the  form  "rrrraaaatttteeee %%%%ffff"  or
          "_l_a_b_e_l;;;; rrrraaaatttteeee %%%%ffff",  where %%%%ffff denotes a strictly positive



(C) INRIA            Last change: 2016/04/12                    1






CADP MANUAL PAGES                                  BCG_MIN(LOCAL)



          floating-point number and  _l_a_b_e_l  denotes  a  character
          string  that  does  not  contain the ";;;;" character (see
          ANNEX 2 below for a discussion on  how  the  stochastic
          LTS  model  of  bbbbccccgggg____mmmmiiiinnnn  generalizes  other theoretical
          models published in the literature).


GGGGEEEENNNNEEEERRRRAAAALLLL OOOOPPPPTTTTIIIIOOOONNNNSSSS
     The  following  _b_c_g__o_p_t_i_o_n_s  are  currently  supported:    ----
     vvvveeeerrrrssssiiiioooonnnn,  ----ccccrrrreeeeaaaatttteeee, ----uuuuppppddddaaaatttteeee, ----rrrreeeemmmmoooovvvveeee, ----cccccccc, ----ttttmmmmpppp, ----uuuunnnnccccoooommmmpppprrrreeeessssssss,
     ----ccccoooommmmpppprrrreeeessssssss, ----rrrreeeeggggiiiisssstttteeeerrrr, ----sssshhhhoooorrrrtttt, ----mmmmeeeeddddiiiiuuuummmm, and  ----ssssiiiizzzzeeee.  See  the
     bbbbccccgggg(LOCAL) manual page for a description of these options.


PPPPAAAARRRRTTTTIIIICCCCUUUULLLLAAAARRRR OOOOPPPPTTTTIIIIOOOONNNNSSSS
     The following options are also supported:


     ----ssssttttrrrroooonnnngggg
          Perform LTS reduction according to strong bisimulation.
          On  (Discrete  or Continuous Time) Markov Chains and on
          Markov Reward Models, this reduction agrees with lumpa-
          bility  of [KS76] (see ANNEX 1, ANNEX 2, and BIBLIOGRA-
          PHY below). Default option.


     ----bbbbrrrraaaannnncccchhhhiiiinnnngggg
          Perform LTS reduction according to branching  bisimula-
          tion.   It is worth noticing that the notion of branch-
          ing bisimulation is rather meaningless for  probabilis-
          tic systems. Not a default option.


     ----ddddiiiivvvvbbbbrrrraaaannnncccchhhhiiiinnnngggg
          Perform LTS reduction according to divergence-sensitive
          branching  bisimulation  [GW96].   Divergence-sensitive
          branching bisimulation differs from branching bisimula-
          tion  only  in  the  way cycles of internal transitions
          (also called divergences) are treated. It is known that
          all states traversed by a cycle of internal transitions
          belong to the same branching equivalence  class.  While
          divergences  are  eliminated  in  the  LTS  obtained by
          reduction modulo  ordinary  branching  bisimulation,  a
          self-looping  internal  transition is kept in each such
          equivalence class in the LTS  obtained  by  divergence-
          sensitive   branching  bisimulation.  Unlike  branching
          bisimulation, divergence-sensitive branching  bisimula-
          tion preserves inevitability properties. Like branching
          bisimulation, it is worth noticing that the  notion  of
          divergence-sensitive  branching  bisimulation is rather
          meaningless for probabilistic systems.  Not  a  default
          option.



(C) INRIA            Last change: 2016/04/12                    2






CADP MANUAL PAGES                                  BCG_MIN(LOCAL)



     ----oooobbbbsssseeeerrrrvvvvaaaattttiiiioooonnnnaaaallll
          Perform  LTS  reduction  according   to   observational
          equivalence  [Mil89].  It is worth noticing that obser-
          vational equivalence is computationally more  expensive
          than branching bisimulation, so that reduction may fail
          even  for  graphs  containing  only  few  thousands  of
          states.  To reduce the risk of failure, in a first step
          the input graph is automatically reduced  according  to
          branching bisimulation. This is sound because branching
          bisimulation is a graph relation stronger than observa-
          tional  equivalence.  However, this optimisation is not
          applied if the ----ccccllllaaaassssssss option is set,  so  that  bbbbccccgggg____mmmmiiiinnnn
          can  print  the  equivalence  classes relatively to the
          states of the input graph, instead of the states of the
          branching  minimal  intermediate  graph produced in the
          first step. This option cannot be combined with neither
          ----pppprrrroooobbbb nor ----rrrraaaatttteeee options. Not a default option.


     ----nnnnoooorrrrmmmmaaaallll
          Consider _i_n_p_u_t....bbbbccccgggg as a normal LTS. With  this  option,
          labels  of  the  form  "rrrraaaatttteeee %%%%ffff" or "_l_a_b_e_l;;;; rrrraaaatttteeee %%%%ffff" or
          "pppprrrroooobbbb %%%%pppp" or "_l_a_b_e_l;;;; pppprrrroooobbbb %%%%pppp" are processed as ordinary
          labels,   without  special  meaning  attached.  Default
          option.


     ----pppprrrroooobbbb
          Consider _i_n_p_u_t....bbbbccccgggg as a probabilistic  LTS.  With  this
          option,   each   label   of   the   form  "pppprrrroooobbbb %%%%pppp"  or
          "_l_a_b_e_l;;;; pppprrrroooobbbb %%%%pppp" is recognized  as  denoting  a  proba-
          bilistic  transition with probability %%%%pppp.  bbbbccccgggg____mmmmiiiinnnn will
          stop with an error message if, for  some  probabilistic
          transition,  %%%%pppp is out of ]0..1], or if the probabilis-
          tic transitions going out of  the  same  state  have  a
          cumulated  sum  strictly  greater  than  1.  With  this
          option,   labels   of    the    form    "rrrraaaatttteeee %%%%ffff"    or
          "_l_a_b_e_l;;;; rrrraaaatttteeee %%%%ffff"  are processed as ordinary labels. Not
          a default option.


     ----rrrraaaatttteeee [ ----sssseeeellllffff ]
          Consider _i_n_p_u_t....bbbbccccgggg  as  a  stochastic  LTS.  With  this
          option,   each   label   of   the   form  "rrrraaaatttteeee %%%%ffff"  or
          "_l_a_b_e_l;;;; rrrraaaatttteeee %%%%ffff" is recognized as denoting a stochastic
          transition  with  rate  %%%%ffff.  bbbbccccgggg____mmmmiiiinnnn  will stop with an
          error message if, for some stochastic transition, %%%%ffff is
          less   or  equal  to  0.   If  the  ----bbbbrrrraaaannnncccchhhhiiiinnnngggg  or  the
          ----ddddiiiivvvvbbbbrrrraaaannnncccchhhhiiiinnnngggg option is selected, and  some  state  has
          both  an outgoing stochastic transition and an outgoing
          internal (i.e., "tau") transition, bbbbccccgggg____mmmmiiiinnnn will print a
          warning  and  remove the stochastic transition in order



(C) INRIA            Last change: 2016/04/12                    3






CADP MANUAL PAGES                                  BCG_MIN(LOCAL)



          to preserve the notion of maximal progress.  With  this
          option,    labels    of    the    form   "pppprrrroooobbbb %%%%pppp"   or
          "_l_a_b_e_l;;;; pppprrrroooobbbb %%%%pppp" are processed as ordinary labels.  Not
          a default option.
          If ----sssseeeellllffff sub-option is given,  all  self  loops  (i.e.,
          transitions  that  remain  within  the same equivalence
          class) having labels of the form "rrrraaaatttteeee %%%%ffff" are removed.
          This   implements   the   weak  Markovian  equivalences
          described in [Bra02] and [BHKW05].  Not a default  sub-
          option.


     ----eeeeppppssssiiiilllloooonnnn _e_p_s
          Set the precision of floating-point comparisons to _e_p_s,
          where  _e_p_s  is a real value. When _e_p_s is out of [0..1[,
          bbbbccccgggg____mmmmiiiinnnn reports an error. Default value for _e_p_s is  1E-
          6.


     ----ffffoooorrrrmmmmaaaatttt _f_o_r_m_a_t__s_t_r_i_n_g
          Use  _f_o_r_m_a_t__s_t_r_i_n_g  to  control  the  format   of   the
          floating-point  numbers  contained in transition labels
          (these numbers correspond to the occurrences of %%%%ffff  and
          %%%%pppp  mentioned  in section DESCRIPTION above). The value
          of _f_o_r_m_a_t__s_t_r_i_n_g should obey the  same  conventions  as
          the _f_o_r_m_a_t parameter of function sssspppprrrriiiinnnnttttffff(3C) for values
          of type ddddoooouuuubbbblllleeee.  Default  value  for  _f_o_r_m_a_t__s_t_r_i_n_g  is
          """"%%%%gggg"""",  meaning  that floating-point numbers are printed
          with at most six digits after the "." (i.e., the  radix
          character).  Other  values  can  be  used, for instance
          """"%%%%....9999gggg"""" to obtain nine digits  instead  of  six,  or  by
          replacing  the """"%%%%gggg"""" flag with other flags, namely """"%%%%eeee"""",
          """"%%%%EEEE"""", """"%%%%ffff"""", """"%%%%GGGG"""",  possibly  combined  with  additional
          flags (e.g., to specify precision).


     ----ccccllllaaaassssssss _c_l_a_s_s__f_i_l_e
          If _c_l_a_s_s__f_i_l_e is the character '-',  then  display  the
          equivalence  classes on the standard output. Otherwise,
          display  the  equivalence  classes  in  a  file   named
          _c_l_a_s_s__f_i_l_e. Not a default option.


     Note: In bbbbccccgggg____mmmmiiiinnnn versions up to 2.1, option ----ccccllllaaaassssssss  was  not
     followed  by  a  _c_l_a_s_s__f_i_l_e argument and equivalence classes
     were always displayed on the standard output. The _c_l_a_s_s__f_i_l_e
     argument was introduced in bbbbccccgggg____mmmmiiiinnnn version 2.2. Because such
     evolution breaks backward compatibility, bbbbccccgggg____mmmmiiiinnnn  issues  an
     error  message  and  stops  if the argument following option
     ----ccccllllaaaassssssss is either an option (i.e., starts with a hyphen) or a
     file name with extension ....bbbbccccgggg, which prevents overwriting an
     existing BCG file.



(C) INRIA            Last change: 2016/04/12                    4






CADP MANUAL PAGES                                  BCG_MIN(LOCAL)



     Note: Options ----ssssttttrrrroooonnnngggg,  ----bbbbrrrraaaannnncccchhhhiiiinnnngggg,  and  ----ddddiiiivvvvbbbbrrrraaaannnncccchhhhiiiinnnngggg  are
     mutually  exclusive.   If  they  occur simultaneously on the
     command-line, the option occurring last is selected.


     Note: Options ----nnnnoooorrrrmmmmaaaallll, ----pppprrrroooobbbb, and  ----rrrraaaatttteeee  (with  or  without
     ----sssseeeellllffff  sub-option)  are  mutually  exclusive.  If they occur
     simultaneously on the  command-line,  the  option  occurring
     last is selected.


EEEENNNNVVVVIIIIRRRROOOONNNNMMMMEEEENNNNTTTT VVVVAAAARRRRIIIIAAAABBBBLLLLEEEESSSS
     See the bbbbccccgggg(LOCAL) manual page  for  a  description  of  the
     environment variables used by all the BCG application tools.


EEEEXXXXIIIITTTT SSSSTTTTAAAATTTTUUUUSSSS
     Exit status is 0 if everything is alright, 1 otherwise.


AAAAUUUUTTTTHHHHOOOORRRRSSSS
     Version 1.* of bbbbccccgggg____mmmmiiiinnnn was  developed  by  Damien  Bergamini
     (INRIA/VASY),   Moez  Cherif  (INRIA/VASY),  Hubert  Garavel
     (INRIA/VASY) and Holger  Hermanns  (University  of  Twente).
     Pepijn  Crouzen  added  ----sssseeeellllffff  sub-option.   Version  1.* of
     bbbbccccgggg____mmmmiiiinnnn used the following algorithms:

     -    It used the  algorithm  of  [KS90]  to  compute  strong
          bisimulation on a normal LTS.

     -    It used the  algorithm  of  [HS99]  to  compute  strong
          bisimulation on probabilistic and stochastic LTS.

     -    It used the algorithm of [GV90]  to  compute  branching
          bisimulation  on  a  normal  LTS. The implementation in
          bbbbccccgggg____mmmmiiiinnnn was derived from a Pascal  program  written  by
          Jan Friso Groote (CWI).

     -    It used a variant of the algorithm of [HS99] to compute
          branching  bisimulation  on  a stochastic (resp. proba-
          bilistic) LTS: the branching bisimulation condition was
          applied only to the "normal" fragment of the transition
          relation, while the  stochastic  (resp.  probabilistic)
          fragments were mimimized with respect to strong bisimu-
          lation.

     Version 2.*  of  bbbbccccgggg____mmmmiiiinnnn  was  developed  by  Frederic  Lang
     (INRIA/VASY).    It   uses   (sequential)  variants  of  the
     signature-based  algorithm  of  [BO03]  to  compute  strong,
     branching,  and  divergence-sensitive vranching bisimulation
     on normal, probabilistic and stochastic LTS.




(C) INRIA            Last change: 2016/04/12                    5






CADP MANUAL PAGES                                  BCG_MIN(LOCAL)



OOOOPPPPEEEERRRRAAAANNNNDDDDSSSS
     _i_n_p_u_t....bbbbccccgggg           BCG graph (input)
     _o_u_t_p_u_t....bbbbccccgggg          BCG graph (output)
     _i_n_p_u_t@@@@1111....oooo           dynamic library (input or output)


FFFFIIIILLLLEEEESSSS
     $$$$CCCCAAAADDDDPPPP////bbbbiiiinnnn....````aaaarrrrcccchhhh````////bbbbccccgggg____mmmmiiiinnnn        ``bbbbccccgggg____mmmmiiiinnnn'' binary program


     See the bbbbccccgggg(LOCAL) manual page  for  a  description  of  the
     other files.


SSSSEEEEEEEE AAAALLLLSSSSOOOO
     bbbbccccgggg(LOCAL), sssspppprrrriiiinnnnttttffff(3C)


     Additional information is available from the CADP  Web  page
     located at http://cadp.inria.fr

     Directives   for   installation   are   given    in    files
     $$$$CCCCAAAADDDDPPPP////IIIINNNNSSSSTTTTAAAALLLLLLLLAAAATTTTIIIIOOOONNNN____****.

     Recent  changes  and  improvements  to  this  software   are
     reported and commented in file $$$$CCCCAAAADDDDPPPP////HHHHIIIISSSSTTTTOOOORRRRYYYY.


BBBBUUUUGGGGSSSS
     Please report bugs to Hubert.Garavel@inria.fr.


AAAANNNNNNNNEEEEXXXX 1111 ---- PPPPRRRROOOOBBBBAAAABBBBIIIILLLLIIIISSSSTTTTIIIICCCC MMMMOOOODDDDEEEELLLLSSSS
     The probabilistic LTS  model  used  in  bbbbccccgggg____mmmmiiiinnnn  is  general
     enough  to  support  the following models, which can be con-
     sidered as special cases of probabilistic LTS:

     DDDDiiiissssccccrrrreeeetttteeee TTTTiiiimmmmeeee MMMMaaaarrrrkkkkoooovvvv CCCChhhhaaaaiiiinnnnssss [Nor97]
          The graph contains transitions of  the  form  "pppprrrroooobbbb %%%%pppp"
          only.

     DDDDiiiissssccccrrrreeeetttteeee TTTTiiiimmmmeeee MMMMaaaarrrrkkkkoooovvvv RRRReeeewwwwaaaarrrrdddd MMMMooooddddeeeellllssss [How71]
          The graph contains transitions of the form "pppprrrroooobbbb %%%%pppp" to
          represent  transitions not obtaining an impulse reward.
          State rewards are  associated  to  states  by  "normal"
          transitions with source and target states being identi-
          cal. The label  indicates  the  state  reward  such  as
          "rrrreeeewwwwaaaarrrrdddd 5555".  Impulse  rewards  are associated to proba-
          bilistic transitions by prefixing the  "pppprrrroooobbbb %%%%pppp"  label
          with  a  label indicating the reward obtained by taking
          this transition, as in "iiiimmmmppppuuuullllsssseeee 4444;;;; pppprrrroooobbbb %%%%pppp".




(C) INRIA            Last change: 2016/04/12                    6






CADP MANUAL PAGES                                  BCG_MIN(LOCAL)



     AAAAlllltttteeeerrrrnnnnaaaattttiiiinnnngggg PPPPrrrroooobbbbaaaabbbbiiiilllliiiissssttttiiiicccc LLLLTTTTSSSS [Han91]
          The graph contains transitions of the  form  "pppprrrroooobbbb %%%%pppp",
          as  well as normal transitions in such a way that there
          is no state possessing both normal as well as "pppprrrroooobbbb %%%%pppp"
          transitions.

     DDDDiiiissssccccrrrreeeetttteeee TTTTiiiimmmmeeee MMMMaaaarrrrkkkkoooovvvv DDDDeeeecccciiiissssiiiioooonnnn PPPPrrrroooocccceeeesssssssseeeessss [Put94]
          The graph contains transitions of the  form  "pppprrrroooobbbb %%%%pppp",
          as  well as normal transitions in such a way that there
          is no state possessing both normal as well as "pppprrrroooobbbb %%%%pppp"
          transitions.   Normal   and  probabilistic  transitions
          strictly alternate, i.e. normal (resp. "pppprrrroooobbbb %%%%pppp") tran-
          sitions  are  not  directly  followed  by normal (resp.
          "pppprrrroooobbbb %%%%pppp") transitions. Uses an  encoding  of  Discrete
          Time  Markov Decision Processes into strictly Alternat-
          ing Probabilistic LTS proposed in [Arg00].

     GGGGeeeennnneeeerrrraaaattttiiiivvvveeee PPPPrrrroooobbbbaaaabbbbiiiilllliiiissssttttiiiicccc LLLLTTTTSSSS [GSS95]
          The   graph   contains   transitions   of   the    type
          "_l_a_b_e_l;;;; pppprrrroooobbbb %%%%pppp"  only,  and  for each state the sum of
          "%%%%pppp" values leaving a state is  equal  to  (or  smaller
          than) 1.

     RRRReeeeaaaaccccttttiiiivvvveeee PPPPrrrroooobbbbaaaabbbbiiiilllliiiissssttttiiiicccc LLLLTTTTSSSS [GSS95]
          The   graph   contains   transitions   of   the    type
          "_l_a_b_e_l;;;; pppprrrroooobbbb %%%%pppp"  only,  and  for  each  state and each
          "_l_a_b_e_l" the sum of "%%%%pppp" values leaving a state is equal
          to (or smaller than) 1.

     SSSSttttrrrraaaattttiiiiffffiiiieeeedddd PPPPrrrroooobbbbaaaabbbbiiiilllliiiissssttttiiiicccc LLLLTTTTSSSS [GSS95]
          The graph contains transitions of the  form  "pppprrrroooobbbb %%%%pppp",
          as  well as normal transitions in such a way that there
          is no state possessing both normal as well as "pppprrrroooobbbb %%%%pppp"
          transitions.  Normal  transitions are not directly fol-
          lowed by normal transitions.


AAAANNNNNNNNEEEEXXXX 2222 ---- SSSSTTTTOOOOCCCCHHHHAAAASSSSTTTTIIIICCCC MMMMOOOODDDDEEEELLLLSSSS
     The stochastic LTS model used in bbbbccccgggg____mmmmiiiinnnn is  general  enough
     to  support the following models, which can be considered as
     special cases of stochastic LTS:

     CCCCoooonnnnttttiiiinnnnuuuuoooouuuussss TTTTiiiimmmmeeee MMMMaaaarrrrkkkkoooovvvv CCCChhhhaaaaiiiinnnnssss [Nor97]
          The graph contains transitions of  the  form  "rrrraaaatttteeee %%%%ffff"
          only.

     CCCCoooonnnnttttiiiinnnnuuuuoooouuuussss TTTTiiiimmmmeeee MMMMaaaarrrrkkkkoooovvvv RRRReeeewwwwaaaarrrrdddd MMMMooooddddeeeellllssss [How71]
          The graph contains transitions of the form "rrrraaaatttteeee %%%%ffff" to
          represent  transitions not obtaining an impulse reward.
          State rewards are assigned to states by "normal"  tran-
          sitions  with source and target states being identical.
          The label indicates the state reward  such  as  "rrrreeeewwwwaaaarrrrdddd



(C) INRIA            Last change: 2016/04/12                    7






CADP MANUAL PAGES                                  BCG_MIN(LOCAL)



          5555". Impulse rewards are assigned to probabilistic tran-
          sitions by prefixing the "rrrraaaatttteeee %%%%ffff" label with  a  label
          indicating   the   reward   obtained,  as  in  "iiiimmmmppppuuuullllsssseeee
          4444;;;; rrrraaaatttteeee %%%%ffff".

     CCCCoooonnnnttttiiiinnnnuuuuoooouuuussss TTTTiiiimmmmeeee MMMMaaaarrrrkkkkoooovvvv DDDDeeeecccciiiissssiiiioooonnnn PPPPrrrroooocccceeeesssssssseeeessss [Put94]
          The graph contains transitions of the  form  "rrrraaaatttteeee %%%%ffff",
          as  well as normal transitions in such a way that there
          is no state possessing both normal as well as "rrrraaaatttteeee %%%%ffff"
          transitions. Normal and stochastic transitions strictly
          alternate, meaning that normal (resp. "rrrraaaatttteeee %%%%ffff")  tran-
          sitions  are  not  directly  followed  by normal (resp.
          "rrrraaaatttteeee %%%%ffff") transitions. Inspired by  an  encoding  pro-
          posed in [Arg00].

     IIIInnnntttteeeerrrraaaaccccttttiiiivvvveeee MMMMaaaarrrrkkkkoooovvvv CCCChhhhaaaaiiiinnnnssss [Her98]
          The graph contains transitions of the  form  "rrrraaaatttteeee %%%%ffff",
          as well as normal transitions.

     TTTTiiiimmmmeeeedddd PPPPrrrroooocccceeeesssssssseeeessss ffffoooorrrr PPPPeeeerrrrffffoooorrrrmmmmaaaannnncccceeee ((((TTTTIIIIPPPPPPPP)))) MMMMooooddddeeeellllssss [HHM98]
          The   graph   contains   transitions   of   the    form
          "_l_a_b_e_l;;;; rrrraaaatttteeee %%%%ffff", as well as normal transitions.

     PPPPeeeerrrrffffoooorrrrmmmmaaaannnncccceeee EEEEvvvvaaaalllluuuuaaaattttiiiioooonnnn PPPPrrrroooocccceeeessssssss AAAAllllggggeeeebbbbrrrraaaa ((((PPPPEEEEPPPPAAAA)))) MMMMooooddddeeeellllssss [Hil96]
          The   graph   contains   transitions   of   the    form
          "_l_a_b_e_l;;;; rrrraaaatttteeee %%%%ffff"   only.    Passsive   transitions  are
          represented by abuse of the "rrrraaaatttteeee" keyword.  The  tran-
          sition  label of a passive transition is augmented by a
          distinguishing string to indicate that the  rate  value
          has  to be interpreted as a weight, such as in "TTTTHHHHIIIISSSS IIIISSSS
          AAAA PPPPAAAASSSSSSSSIIIIVVVVEEEE TTTTRRRRAAAANNNNSSSSIIIITTTTIIIIOOOONNNN LLLLAAAABBBBEEEELLLLLLLLEEEEDDDD _l_a_b_e_l WWWWIIIITTTTHHHH  WWWWEEEEIIIIGGGGHHHHTTTT;;;;  rrrraaaatttteeee
          %%%%ffff".  The  actual  distinguishing  string used for this
          purpose is of no importance for bbbbccccgggg____mmmmiiiinnnn,  but  it  must
          not  contain  ";;;;"  and  must not start with the keyword
          "rrrraaaatttteeee".


     EEEExxxxtttteeeennnnddddeeeedddd MMMMaaaarrrrkkkkoooovvvviiiiaaaannnn PPPPrrrroooocccceeeessssssss AAAAllllggggeeeebbbbrrrraaaa ((((EEEEMMMMPPPPAAAA)))) MMMMooooddddeeeellllssss [BG98]
          The   graph   contains   transitions   of   the    form
          "_l_a_b_e_l;;;; rrrraaaatttteeee %%%%ffff"  only.   Passive and immediate transi-
          tions are represented by abuse of the  "rrrraaaatttteeee"  keyword.
          The  transition  label  of a passive transition is aug-
          mented by a distinguishing string to indicate that  the
          rate  value  has to be interpreted as a weight, such as
          in "TTTTHHHHIIIISSSS IIIISSSS AAAA PPPPAAAASSSSSSSSIIIIVVVVEEEE TTTTRRRRAAAANNNNSSSSIIIITTTTIIIIOOOONNNN LLLLAAAABBBBEEEELLLLLLLLEEEEDDDD   _l_a_b_e_l  WWWWIIIITTTTHHHH
          PPPPRRRRIIIIOOOORRRRIIIITTTTYYYY _p AAAANNNNDDDD  WWWWEEEEIIIIGGGGHHHHTTTT;;;; rrrraaaatttteeee %%%%ffff".  The transition label
          of an immediate transition is augmented  in  a  similar
          way,   as   in   "TTTTHHHHIIIISSSS   IIIISSSS   AAAANNNN  IIIIMMMMMMMMEEEEDDDDIIIIAAAATTTTEEEE  TTTTRRRRAAAANNNNSSSSIIIITTTTIIIIOOOONNNN
          LLLLAAAABBBBEEEELLLLLLLLEEEEDDDD _l_a_b_e_l WWWWIIIITTTTHHHH PPPPRRRRIIIIOOOORRRRIIIITTTTYYYY _p AAAANNNNDDDD  WWWWEEEEIIIIGGGGHHHHTTTT;;;;  rrrraaaatttteeee  %%%%ffff".
          The  actual  distinguishing strings used for these pur-
          poses are of no importance for bbbbccccgggg____mmmmiiiinnnn, but  they  must
          not  contain  ";;;;"  and  must not start with the keyword



(C) INRIA            Last change: 2016/04/12                    8






CADP MANUAL PAGES                                  BCG_MIN(LOCAL)



          "rrrraaaatttteeee".


BBBBIIIIBBBBLLLLIIIIOOOOGGGGRRRRAAAAPPPPHHHHYYYY
     [Arg00] P. R. D'Argenio (2000). On the relation  among  dif-
     ferent  probabilistic  transition  systems and probabilistic
     bisimulations. CTIT Tech Report, to appear 2000.

     [BG98] M. Bernardo and R. Gorrieri (1998).   A  Tutorial  on
     EMPA:  A Theory of Concurrent Processes with Nondeterminism,
     Priorities, Probabilities and  Time.   Theoretical  Computer
     Science 202, pp. 1-54, 1998.

     [BHKW05] C. Baier, H. Hermanns, J.P. Katoen, V.  Wolf.  Com-
     parative  branching-time semantics for Markov chains. Infor-
     mation and Computation, vol. 200(2), pp.  149-214, 2005.

     [BO03] S. Blom, S. Orzan. Distributed State Space  Minimiza-
     tion. Electronic Notes in Theoretical Computer Science, vol.
     80, 2003.

     [Bra02] M. Bravetti. Revisiting Interactive  Markov  Chains.
     Electronic  Notes  on  Theoretical  Computer  Science,  vol.
     68(5), 2002.

     [GH02] H. Garavel and H. Hermanns (2002). On Combining Func-
     tional  Verification  and Performance Evaluation using CADP.
     Proc. 11th Int. Symp.  of  Formal  Methods  Europe  FME'2002
     (Copenhagen,  Denmark), LNCS 2391, July 2002. Available from
     http://cadp.inria.fr/publications/Garavel-Hermanns-02.html

     [GSS95] R. J. van Glabbeek, S. A.  Smolka,  and  B.  Steffen
     (1995).  Reactive, generative, and stratified models of pro-
     babilistic processes. Information and Computation  121,  pp.
     59-80, 1995.

     [GW96] R.J. van Glabbeek and W.P. Weijland (1996). Branching
     Time  and  Abstraction in Bisimulation Semantics. Journal of
     the ACM 43(3):555-600.

     [GV90] J. F. Groote and F. Vaandrager (1990).  An  efficient
     algorithm   for   branching   bisimulation   and  stuttering
     equivalence. Proceedings of the 17th ICALP  (Warwick),  LNCS
     443, pp. 626-638, 1990.

     [Han91] H. A. Hansson (1991). Time and Probability in Formal
     Design  of  Distributed  Systems.  PhD thesis, University of
     Uppsala, 1991.

     [Her98] H. Hermanns (1998). Interactive Markov Chains. Ph.D.
     Thesis, University of Erlangen-Nuernberg, Germany, 1998.




(C) INRIA            Last change: 2016/04/12                    9






CADP MANUAL PAGES                                  BCG_MIN(LOCAL)



     [HHM98] H. Hermanns, U. Herzog, and V. Mertsiotakis  (1998).
     Stochastic  Process  Algebras  -  Between  LOTOS  and Markov
     Chains.  Computer Networks and ISDN Systems 30, pp. 901-924,
     1998.

     [Hil96] J. Hillston (1996).   A  Compositional  Approach  to
     Performance Modelling. Cambridge University Press, 1996.

     [How71] R. A. Howard (1971). Dynamic Probabilistic  Systems,
     Vol II: Semi-Markov and Decision Processes. Wiley, 1971.

     [HS99] H. Hermanns and M. Siegle (1999). Bisimulation  algo-
     rithms  for  stochastic process algebras and their BDD-based
     implementation. Proceedings of the 5th ARTS, LNCS 1601,  pp.
     244-265, 1999.

     [KS76] J. G. Kemeny and J. L. Snell (1976).   Finite  Markov
     Chains. Springer, 1976.

     [KS90] P. C. Kanellakis and S. A. Smolka (1990). CCS expres-
     sions,   finite  state  processes,  and  three  problems  of
     equivalence. Information and Computation 86(1),  pp.  43-68,
     May 1990.

     [Mil89] R. Milner  (1989).  Communication  and  Concurrency.
     Prentice-Hall, 1989.

     [Nor97]  J.  R.  Norris  (1997).  Markov  Chains.  Cambridge
     University Press, 1997.

     [Put94] M. L. Puterman (1994).  Markov  Decision  Processes:
     Discrete  Stochastic  Dynamic  Programming. Wiley, New York,
     NY, 1994.






















(C) INRIA            Last change: 2016/04/12                   10



