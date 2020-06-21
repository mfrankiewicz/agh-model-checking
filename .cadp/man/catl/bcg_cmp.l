


CADP MANUAL PAGES                                  BCG_CMP(LOCAL)



NNNNAAAAMMMMEEEE
     bcg_cmp - equivalence comparison of  normal,  probabilistic,
     or  stochastic  labeled transitions systems (LTS) encoded in
     the BCG format


SSSSYYYYNNNNOOOOPPPPSSSSIIIISSSS
     bbbbccccgggg____ccccmmmmpppp [_b_c_g__o_p_t_i_o_n_s] [----ssssttttrrrroooonnnngggg | ----bbbbrrrraaaannnncccchhhhiiiinnnngggg |  ----ddddiiiivvvvbbbbrrrraaaannnncccchhhhiiiinnnngggg
     |  ----oooobbbbsssseeeerrrrvvvvaaaattttiiiioooonnnnaaaallll]  [----nnnnoooorrrrmmmmaaaallll  |  ----pppprrrroooobbbb  |  ----rrrraaaatttteeee [----sssseeeellllffff]] [----
     eeeeppppssssiiiilllloooonnnn _e_p_s] [----ffffoooorrrrmmmmaaaatttt _f_o_r_m_a_t__s_t_r_i_n_g] [----ccccllllaaaassssssss _c_l_a_s_s__f_i_l_e]  [----
     ddddiiiiaaaagggg _d_i_a_g__f_i_l_e....bbbbccccgggg] _i_n_p_u_t__1....bbbbccccgggg _i_n_p_u_t__2....bbbbccccgggg

     where _b_c_g__o_p_t_i_o_n_s is defined below (see GENERAL OPTIONS).

     bbbbccccgggg____ccccmmmmpppp takes as  inputs  the  BCG  graphs  _i_n_p_u_t__1....bbbbccccgggg  and
     _i_n_p_u_t__2....bbbbccccgggg,  and  compares  these  graphs according to some
     bisimulation relation.


DDDDEEEESSSSCCCCRRRRIIIIPPPPTTTTIIIIOOOONNNN
     bbbbccccgggg____ccccmmmmpppp implements various algorithms to perform  comparison
     of  graphs  encoded  in  the  BCG format according to strong
     bisimulation, branching  bisimulation,  divergence-sensitive
     branching  bisimulation,  or  observational  equivalence.  A
     graph input by bbbbccccgggg____ccccmmmmpppp can be:


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
          (see ANNEX 1 of the bbbbccccgggg____mmmmiiiinnnn(LOCAL) manual  page  for  a
          discussion  on how the probabilistic LTS model general-
          izes other theoretical models published in the  litera-
          ture),


     -    or a "stochastic LTS":  these  are  LTS  with  "normal"
          labelled transitions, as well as "special" transitions,
          whose labels  are  either  of  the  form  "rrrraaaatttteeee %%%%ffff"  or
          "_l_a_b_e_l;;;; rrrraaaatttteeee %%%%ffff",  where %%%%ffff denotes a strictly positive



(C) INRIA            Last change: 2019/01/09                    1






CADP MANUAL PAGES                                  BCG_CMP(LOCAL)



          floating-point number and  _l_a_b_e_l  denotes  a  character
          string  that  does  not  contain the ";;;;" character (see
          ANNEX 2 of the bbbbccccgggg____mmmmiiiinnnn(LOCAL) manual page for a discus-
          sion  on  how  the stochastic LTS model of bbbbccccgggg____mmmmiiiinnnn gen-
          eralizes other  theoretical  models  published  in  the
          literature).


GGGGEEEENNNNEEEERRRRAAAALLLL OOOOPPPPTTTTIIIIOOOONNNNSSSS
     The  following  _b_c_g__o_p_t_i_o_n_s  are  currently  supported:    ----
     vvvveeeerrrrssssiiiioooonnnn,  ----ccccrrrreeeeaaaatttteeee, ----uuuuppppddddaaaatttteeee, ----rrrreeeemmmmoooovvvveeee, ----cccccccc, ----ttttmmmmpppp, ----uuuunnnnccccoooommmmpppprrrreeeessssssss,
     ----ccccoooommmmpppprrrreeeessssssss, ----rrrreeeeggggiiiisssstttteeeerrrr, ----sssshhhhoooorrrrtttt, ----mmmmeeeeddddiiiiuuuummmm, and  ----ssssiiiizzzzeeee.  See  the
     bbbbccccgggg(LOCAL) manual page for a description of these options.


PPPPAAAARRRRTTTTIIIICCCCUUUULLLLAAAARRRR OOOOPPPPTTTTIIIIOOOONNNNSSSS
     The following options are also supported:


     ----ssssttttrrrroooonnnngggg
          Perform LTS comparison according  to  strong  bisimula-
          tion.  On  (Discrete  or Continuous Time) Markov Chains
          and on Markov Reward Models,  this  equivalence  agrees
          with  lumpability  of [KS76] (see ANNEX 1, ANNEX 2, and
          BIBLIOGRAPHY  of  the  bbbbccccgggg____mmmmiiiinnnn(LOCAL)   manual   page).
          Default option.


     ----bbbbrrrraaaannnncccchhhhiiiinnnngggg
          Perform LTS comparison according to branching bisimula-
          tion.   It is worth noticing that the notion of branch-
          ing bisimulation is rather meaningless for  probabilis-
          tic systems. Not a default option.


     ----ddddiiiivvvvbbbbrrrraaaannnncccchhhhiiiinnnngggg
          Perform  LTS  comparison   according   to   divergence-
          sensitive  branching  bisimulation [GW96].  Divergence-
          sensitive branching bisimulation differs from branching
          bisimulation only in the way cycles of internal transi-
          tions (also called  divergences)  are  treated.  It  is
          known  that all states traversed by a cycle of internal
          transitions belong to the  same  branching  equivalence
          class.   While  divergences  are  ignored  by  ordinary
          branching  bisimulation,  they  are  assimilated  to  a
          self-looping   internal   transition   in   each   such
          equivalence  class  by  divergence-sensitive  branching
          bisimulation.     Unlike     branching    bisimulation,
          divergence-sensitive branching  bisimulation  preserves
          inevitability properties.  Like branching bisimulation,
          it is worth noticing that  the  notion  of  divergence-
          sensitive  branching bisimulation is rather meaningless



(C) INRIA            Last change: 2019/01/09                    2






CADP MANUAL PAGES                                  BCG_CMP(LOCAL)



          for probabilistic systems. Not a default option.


     ----oooobbbbsssseeeerrrrvvvvaaaattttiiiioooonnnnaaaallll
          Perform  LTS  comparison  according  to   observational
          equivalence  [Mil89].  It is worth noticing that obser-
          vational equivalence is computationally more  expensive
          than  branching  bisimulation,  so  that comparison may
          fail even for graphs containing only few  thousands  of
          states.  To reduce the risk of failure, in a first step
          the input graphs are automatically reduced according to
          branching bisimulation. This is sound because branching
          bisimulation is a graph relation stronger than observa-
          tional  equivalence.  However, this optimisation is not
          applied if the ----ccccllllaaaassssssss option is set,  so  that  bbbbccccgggg____ccccmmmmpppp
          can  print  the  equivalence  classes relatively to the
          states of the input graphs, instead of  the  states  of
          the  branching  minimal  intermediate graph produced in
          the first step. This option  cannot  be  combined  with
          neither ----pppprrrroooobbbb nor ----rrrraaaatttteeee options. Not a default option.


     ----nnnnoooorrrrmmmmaaaallll
          Consider _i_n_p_u_t__1....bbbbccccgggg and _i_n_p_u_t__2....bbbbccccgggg  as  normal  LTSs.
          With  this  option,  labels  of  the  form "rrrraaaatttteeee %%%%ffff" or
          "_l_a_b_e_l;;;; rrrraaaatttteeee %%%%ffff" or "pppprrrroooobbbb %%%%pppp" or  "_l_a_b_e_l;;;; pppprrrroooobbbb %%%%pppp"  are
          processed  as  ordinary labels, without special meaning
          attached. Default option.


     ----pppprrrroooobbbb
          Consider _i_n_p_u_t__1....bbbbccccgggg and _i_n_p_u_t__2....bbbbccccgggg  as  probabilistic
          LTSs.   With  this  option,  each  label  of  the  form
          "pppprrrroooobbbb %%%%pppp" or "_l_a_b_e_l;;;; pppprrrroooobbbb %%%%pppp" is recognized as denoting
          a probabilistic transition with probability %%%%pppp. bbbbccccgggg____ccccmmmmpppp
          will stop with an error message  if,  for  some  proba-
          bilistic  transition,  %%%%pppp  is  out of ]0..1], or if the
          probabilistic transitions going out of the  same  state
          have a cumulated sum strictly greater than 1. With this
          option,   labels   of    the    form    "rrrraaaatttteeee %%%%ffff"    or
          "_l_a_b_e_l;;;; rrrraaaatttteeee %%%%ffff"  are processed as ordinary labels. Not
          a default option.


     ----rrrraaaatttteeee [ ----sssseeeellllffff ]
          Consider  _i_n_p_u_t__1....bbbbccccgggg  and  _i_n_p_u_t__2....bbbbccccgggg  as  stochastic
          LTSs.   With  this  option,  each  label  of  the  form
          "rrrraaaatttteeee %%%%ffff" or "_l_a_b_e_l;;;; rrrraaaatttteeee %%%%ffff" is recognized as denoting
          a stochastic transition with rate %%%%ffff. bbbbccccgggg____ccccmmmmpppp will stop
          with an error message if, for some  stochastic  transi-
          tion,  %%%%ffff  is less or equal to 0.  If the ----bbbbrrrraaaannnncccchhhhiiiinnnngggg or
          the ----ddddiiiivvvvbbbbrrrraaaannnncccchhhhiiiinnnngggg option is selected,  and  some  state



(C) INRIA            Last change: 2019/01/09                    3






CADP MANUAL PAGES                                  BCG_CMP(LOCAL)



          has  both an outgoing stochastic transition and an out-
          going internal (i.e., "tau") transition,  bbbbccccgggg____ccccmmmmpppp  will
          print a warning and ignore the stochastic transition in
          order to preserve the notion of maximal progress.  With
          this   option,   labels   of   the  form  "pppprrrroooobbbb %%%%pppp"  or
          "_l_a_b_e_l;;;; pppprrrroooobbbb %%%%pppp" are processed as ordinary labels.  Not
          a default option.
          If ----sssseeeellllffff sub-option is given,  all  self  loops  (i.e.,
          transitions  that  remain  within  the same equivalence
          class) having labels of the form "rrrraaaatttteeee %%%%ffff" are ignored.
          This   implements   the   weak  Markovian  equivalences
          described in [Bra02] and [BHKW05].  Not a default  sub-
          option.


     ----eeeeppppssssiiiilllloooonnnn _e_p_s
          Set the precision of floating-point comparisons to _e_p_s,
          where  _e_p_s  is a real value. When _e_p_s is out of [0..1[,
          bbbbccccgggg____ccccmmmmpppp reports an error. Default value for _e_p_s is  1E-
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
          equivalence  classes  on  standard  output.  Otherwise,
          display  the  equivalence  classes  in  a  file   named
          _c_l_a_s_s__f_i_l_e. Not a default option.


     ----ddddiiiiaaaagggg _d_i_a_g__f_i_l_e....bbbbccccgggg
          When the  comparison  of  _i_n_p_u_t__1  and  _i_n_p_u_t__2  yields
          FALSE,  generate  a  diagnostic (counterexample) in BCG
          format (see the bbbbccccgggg(LOCAL)  manual  page  for  details)
          explaining  this result. The diagnostic is generated in
          the file _d_i_a_g....bbbbccccgggg. This option has no effect  when  the



(C) INRIA            Last change: 2019/01/09                    4






CADP MANUAL PAGES                                  BCG_CMP(LOCAL)



          comparison of input_1 aaaannnndddd _i_n_p_u_t__2 yyyyiiiieeeellllddddssss TTTTRRRRUUUUEEEE,,,, ssssiiiinnnncccceeee iiiinnnn
          tttthhhhiiiissss ccccaaaasssseeee tttthhhheeee ddddiiiiaaaaggggnnnnoooossssttttiiiicccc wwwwoooouuuulllldddd bbbbeeee llllaaaarrrrggggeeeerrrr  tttthhhhaaaannnn  _i_n_p_u_t__1
          aaaannnndddd  _i_n_p_u_t__2,,,,  aaaannnndddd  wwwwoooouuuulllldddd nnnnooootttt bbbbrrrriiiinnnngggg aaaannnnyyyy uuuusssseeeeffffuuuullll iiiinnnnffffoooorrrrmmmmaaaa----
          ttttiiiioooonnnn.... TTTThhhheeee BBBBCCCCGGGG ffffiiiilllleeee ccccoooonnnnttttaaaaiiiinnnniiiinnnngggg  tttthhhheeee  ddddiiiiaaaaggggnnnnoooossssttttiiiicccc  ccccaaaannnn  bbbbeeee
          vvvviiiissssuuuuaaaalllliiiizzzzeeeedddd     uuuussssiiiinnnngggg     tttthhhheeee     bbbbccccgggg____ddddrrrraaaawwww(LOCAL)    and
          bbbbccccgggg____eeeeddddiiiitttt(LOCAL) tools of CADP  (see  respective  manual
          pages for details).

          The diagnostic is a  directed  acyclic  graph  included
          (modulo  the  preorder corresponding to the equivalence
          relation considered) both in _i_n_p_u_t__1 and _i_n_p_u_t__2.

          If the diagnostic is a sequence of transitions, it will
          also  be  displayed on standard output using the simple
          SEQ format (see the  sssseeeeqqqq(LOCAL)  manual  page  for  the
          definition of this format). Not a default option.


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
     bbbbccccgggg____ccccmmmmpppp was developped by Frederic Lang (INRIA/CONVECS).  It
     shares  a  substantial amount of code with bbbbccccgggg____mmmmiiiinnnn.  See the
     bbbbccccgggg____mmmmiiiinnnn(LOCAL) manual page for more information.


OOOOPPPPEEEERRRRAAAANNNNDDDDSSSS
     _i_n_p_u_t__1....bbbbccccgggg         BCG graph (input)
     _i_n_p_u_t__2....bbbbccccgggg         BCG graph (input)
     _i_n_p_u_t__1@@@@1111....oooo         dynamic library (input or output)
     _i_n_p_u_t__2@@@@1111....oooo         dynamic library (input or output)






(C) INRIA            Last change: 2019/01/09                    5






CADP MANUAL PAGES                                  BCG_CMP(LOCAL)



FFFFIIIILLLLEEEESSSS
     $$$$CCCCAAAADDDDPPPP////bbbbiiiinnnn....````aaaarrrrcccchhhh````////bbbbccccgggg____ccccmmmmpppp        ``bbbbccccgggg____ccccmmmmpppp'' binary program


     See the bbbbccccgggg(LOCAL) manual page  for  a  description  of  the
     other files.


SSSSEEEEEEEE AAAALLLLSSSSOOOO
     bbbbccccgggg(LOCAL), bbbbccccgggg____mmmmiiiinnnn(LOCAL), sssseeeeqqqq(LOCAL), sssspppprrrriiiinnnnttttffff(3C)


     Additional information is available from the CADP  Web  page
     located at http://cadp.inria.fr

     Directives   for   installation   are   given    in    files
     $$$$CCCCAAAADDDDPPPP////IIIINNNNSSSSTTTTAAAALLLLLLLLAAAATTTTIIIIOOOONNNN____****.

     Recent  changes  and  improvements  to  this  software   are
     reported and commented in file $$$$CCCCAAAADDDDPPPP////HHHHIIIISSSSTTTTOOOORRRRYYYY.


BBBBUUUUGGGGSSSS
     Please report bugs to cadp@inria.fr.































(C) INRIA            Last change: 2019/01/09                    6



