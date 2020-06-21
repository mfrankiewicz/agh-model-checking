


CADP MANUAL PAGES                                 EXP.OPEN(LOCAL)



NNNNAAAAMMMMEEEE
     exp.open - OPEN/CAESAR connection for EXP networks  of  com-
     municating automata


SSSSYYYYNNNNOOOOPPPPSSSSIIIISSSS
     eeeexxxxpppp....ooooppppeeeennnn [----bbbbrrrraaaannnncccchhhhiiiinnnngggg | ----ddddeeeeaaaaddddpppprrrreeeesssseeeerrrrvvvviiiinnnngggg |  ----ssssttttrrrroooonnnngggg  |  ----wwwweeeeaaaakkkk----
     ttttrrrraaaacccceeee]  [----ccccaaaasssseeee]  [----ddddeeeebbbbuuuugggg]  [----lllloooottttoooossss | ----eeeelllloooottttoooossss | ----ccccccccssss | ----ccccsssspppp |
     ----mmmmccccrrrrllll] [----hhhhiiiiddddddddeeeennnn  _s_t_r_i_n_g]  [----tttteeeerrrrmmmmiiiinnnnaaaattttiiiioooonnnn  _s_t_r_i_n_g]  [----ccccooooaaaaccccttttiiiioooonnnn
     _s_t_r_i_n_g]  [----ddddeeeeppppeeeennnndddd]  [----hhhhiiiissssttttoooorrrryyyy] [----iiiinnnnffffoooo] [----iiiinnnnlllliiiinnnneeee] [----iiiinnnntttteeeerrrrffffaaaacccceeee
     _i_n_t_e_r_f_a_c_e__d_i_r_e_c_t_i_v_e_s] [----iiiinnnntttteeeerrrrffffaaaacccceeeeuuuusssseeeerrrr]  [----llllaaaabbbbeeeellllssss]  [----nnnneeeettttwwwwoooorrrrkkkk
     _f_o_r_m_a_t]  [----nnnnoooocccchhhheeeecccckkkk]  [----pppprrrroooobbbb] [----rrrraaaatttteeee] [----ssssiiiilllleeeennnntttt | ----vvvveeeerrrrbbbboooosssseeee] [----
     uuuunnnnppppaaaarrrrsssseeee]     [----vvvveeeerrrrssssiiiioooonnnn]     _f_i_l_e_n_a_m_e[....eeeexxxxpppp]      [_c_c__o_p_t_i_o_n_s]
     _p_r_o_g[....aaaa|....cccc|....oooo] [_p_r_o_g__o_p_t_i_o_n_s]


DDDDEEEESSSSCCCCRRRRIIIIPPPPTTTTIIIIOOOONNNN
     Taking as input _f_i_l_e_n_a_m_e....eeeexxxxpppp,,,, which describes a  network  of
     communicating  automata  in the EXP 2.0, see eeeexxxxpppp(LOCAL), and
     an OPEN/CAESAR program _p_r_o_g[....aaaa|....cccc|....oooo], eeeexxxxpppp....ooooppppeeeennnn generates an
     OPEN/CAESAR graph module _f_i_l_e_n_a_m_e....cccc.  This file is then com-
     piled into _f_i_l_e_n_a_m_e....oooo and an executable program _p_r_o_g result-
     ing from the combination of _f_i_l_e_n_a_m_e....oooo and _p_r_o_g[....aaaa|....cccc|....oooo] is
     produced.  Finally, _p_r_o_g is executed.

     According to the principles of the OPEN/CAESAR architecture,
     _p_r_o_g is obtained by combining three different modules:


     -    the graph module is generated from _f_i_l_e_n_a_m_e....eeeexxxxpppp


     -    the storage module is the standard OPEN/CAESAR library


     -    the exploration module is _p_r_o_g[....aaaa|....cccc|....oooo]


PPPPRRRROOOOCCCCEEEESSSSSSSSIIIINNNNGGGG OOOOFFFF TTTTHHHHEEEE EEEEXXXXPPPPLLLLOOOORRRRAAAATTTTIIIIOOOONNNN MMMMOOOODDDDUUUULLLLEEEE
     The exploration module _p_r_o_g[....aaaa|....cccc|....oooo] is supposed to contain
     an     OPEN/CAESAR     application    program,    such    as
     eeeevvvvaaaalllluuuuaaaattttoooorrrr(LOCAL), ggggeeeennnneeeerrrraaaattttoooorrrr(LOCAL), oooocccciiiissss(LOCAL)...

     The exploration module can be supplied  in  three  different
     forms. It can be either an archive file (with ....aaaa suffix), or
     a source C program (with ....cccc suffix) or an object  code  file
     (with ....oooo suffix).

     If _p_r_o_g....aaaa is not present in the current directory,  eeeexxxxpppp....ooooppppeeeennnn
     attempts  to  fetch  it  in  the  OPEN/CAESAR binary library
     $$$$CCCCAAAADDDDPPPP////bbbbiiiinnnn....````aaaarrrrcccchhhh````.




(C) INRIA            Last change: 2020/02/11                    1






CADP MANUAL PAGES                                 EXP.OPEN(LOCAL)



     If _p_r_o_g....cccc is not present in the current directory,  eeeexxxxpppp....ooooppppeeeennnn
     attempts  to  fetch  it  in  the  OPEN/CAESAR source library
     $$$$CCCCAAAADDDDPPPP////ssssrrrrcccc////ooooppppeeeennnn____ccccaaaaeeeessssaaaarrrr.

     If _p_r_o_g....oooo is not present in the current directory,  eeeexxxxpppp....ooooppppeeeennnn
     attempts  to  fetch  it  in  the  OPEN/CAESAR binary library
     $$$$CCCCAAAADDDDPPPP////bbbbiiiinnnn....````aaaarrrrcccchhhh````.

     If no suffix (....aaaa, ....cccc, ....oooo) is specified on the  command  line
     for  the exploration module _p_r_o_g, eeeexxxxpppp....ooooppppeeeennnn will make succes-
     sive attempts to fetch this exploration module: first, as  a
     source  C  program  with  ....cccc suffix; then as an archive file
     with ....aaaa suffix; finally as an object code file with ....oooo  suf-
     fix.


OOOOPPPPTTTTIIIIOOOONNNNSSSS
     ----bbbbrrrraaaannnncccchhhhiiiinnnngggg
          Perform  on-the-fly  partial  order  reduction   modulo
          branching   bisimulation.    This  yields  a  generally
          smaller graph, which  is  equivalent  modulo  branching
          bisimulation  to  the  graph obtained using the ----ssssttttrrrroooonnnngggg
          option. The used technique is based  on  prioritization
          of   so-called  _t_a_u-_c_o_n_f_l_u_e_n_t  transitions  [Pace-Lang-
          Mateescu-03]. This is not a default option.

          If the ----bbbbrrrraaaannnncccchhhhiiiinnnngggg option is used  in  combination  with
          ----rrrraaaatttteeee,  then  also  attempt  on-the-fly  partial  order
          reduction  modulo  stochastic  branching   bisimulation
          (which  is weaker than branching bisimulation), by giv-
          ing priority to hidden actions over stochastic  transi-
          tions  (see  the  ----rrrraaaatttteeee  option  below), thus taking an
          account of the maximal progress of hidden actions.


     ----ccccaaaasssseeee
          Force the distinction between lowercase  and  uppercase
          characters  in  labels  occurring  within the operators
          used in _f_i_l_e_n_a_m_e....eeeexxxxpppp.  This is the default option if no
          reference  language  is  selected  or  if the reference
          language is E-LOTOS or mCRL.  In  other  cases,  labels
          occurring within the operators used in _f_i_l_e_n_a_m_e....eeeexxxxpppp are
          automatically turned to uppercase.   Therefore,  labels
          in  LTSs  should also be uppercase, except possibly the
          strings  representing  the  hidden  label,  termination
          label, co-action prefix, and the "prob" and "rate" key-
          words used to denote probabilistic and stochastic tran-
          sitions (see the ----pppprrrroooobbbb and ----rrrraaaatttteeee options below).


     ----ccccccccssss
          Set CCS as  the  reference  language.  This  is  not  a



(C) INRIA            Last change: 2020/02/11                    2






CADP MANUAL PAGES                                 EXP.OPEN(LOCAL)



          default  option.   See  Section  LANGUAGE PARAMETERS of
          eeeexxxxpppp(LOCAL) for details.


     ----ccccooooaaaaccccttttiiiioooonnnn _s_t_r_i_n_g
          Set _s_t_r_i_n_g so as to prefix CCS co-action labels; _s_t_r_i_n_g
          is  named  _c_o-_a_c_t_i_o_n  _p_r_e_f_i_x.  See Section CCS PARALLEL
          COMPOSITION of eeeexxxxpppp(LOCAL) for  more  information  about
          the co-action prefix.


     ----ccccsssspppp
          Set CSP as  the  reference  language.  This  is  not  a
          default  option.   See  Section  LANGUAGE PARAMETERS of
          eeeexxxxpppp(LOCAL) for details.


     ----ddddeeeeaaaaddddpppprrrreeeesssseeeerrrrvvvviiiinnnngggg
          Perform on-the-fly partial order  reduction  preserving
          deadlocks. This yields a generally smaller graph, which
          contains the same deadlocks as the graph obtained using
          the ----ssssttttrrrroooonnnngggg option. This is not a default option.


     ----ddddeeeebbbbuuuugggg
          Undocumented option.


     ----ddddeeeeppppeeeennnndddd
          Display the list of EXP  files  included  (directly  or
          transitively)  in _f_i_l_e_n_a_m_e....eeeexxxxpppp, followed by the list of
          communicating automata, hide,  rename,  and  cut  files
          used  in  the EXP behaviour and stop.  This list may be
          incomplete  if  the  EXP  behaviour  is   syntactically
          incorrect.  Not a default option.


     ----eeeelllloooottttoooossss
          Set E-LOTOS as the reference language. This  is  not  a
          default  option.   See  Section  LANGUAGE PARAMETERS of
          eeeexxxxpppp(LOCAL) for details.


     ----hhhhiiiiddddddddeeeennnn _s_t_r_i_n_g
          Set _s_t_r_i_n_g as denoting the hidden label in BCG files of
          both  the  communicating  automata and of the automaton
          corresponding to their composition.  The default  value
          depends on the reference language, see Section LANGUAGE
          PARAMETERS of eeeexxxxpppp(LOCAL) for details.

          Note  that  many  CADP  tools  (such  as  for  instance
          bbbbccccgggg____mmmmiiiinnnn(LOCAL),  aaaallllddddeeeebbbbaaaarrrraaaannnn(LOCAL),  etc.)  require  the



(C) INRIA            Last change: 2020/02/11                    3






CADP MANUAL PAGES                                 EXP.OPEN(LOCAL)



          hidden label to be written "i".  If it is written  dif-
          ferently, e.g., "tau", then one may use the "-hidden i"
          option and hide "tau" in each communicating  automaton,
          by using the hiding operator of EXP 2.0.

          Note also that the  hidden  label  is  usually  written
          "tau"  in  the  FC2 format.  During conversion from FC2
          communicating  automata  into  BCG,  "tau"  labels  are
          automatically  renamed  into  "i"  by the bbbbccccgggg____iiiioooo(LOCAL)
          tool.  Therefore, since bcg_io is systematically called
          to  translate  FC2  components into the BCG format, the
          hidden label should be set to "i", using  "-hidden  i",
          even  though  some component is in the FC2 format, with
          "tau" denoting the hidden label.


     ----hhhhiiiissssttttoooorrrryyyy
          Record a history of each label.   The  history  can  be
          read using the CAESAR_INFORMATION_LABEL function of the
          OPEN/CAESAR API. With the ----hhhhiiiissssttttoooorrrryyyy option, it is possi-
          ble to set FORMAT_LABEL (see the OPEN/CAESAR manual) to
          a natural number up to 3 (instead of 2 otherwise):

          o  The  behaviour  of   CAESAR_INFORMATION_LABEL   with
          FORMAT_LABEL  set  to  0  or  1  is  described  in  the
          OPEN/CAESAR documentation.

          o If FORMAT_LABEL is equal to 2, then information about
          the  synchronisations  involved  in  the computation of
          each label is displayed under the form of a  _s_y_n_c_h_r_o_n_i_-
          _s_a_t_i_o_n _v_e_c_t_o_r.

          o If FORMAT_LABEL is equal to  3,  then  the  displayed
          synchronisation  vector  is  extended  with information
          about hidings and renamings performed  to  produce  the
          label.

          This is not a default option.


     ----iiiinnnnffffoooo
          Print structural information about the LTSs  referenced
          in  _f_i_l_e_n_a_m_e....eeeexxxxpppp and stop. See bbbbccccgggg____iiiinnnnffffoooo(LOCAL) for more
          information.


     ----iiiinnnnlllliiiinnnneeee
          Generate an OPEN/CAESAR  graph  module  that  does  not
          depend  on  BCG  files.  This option cannot be combined
          with ----bbbbrrrraaaannnncccchhhhiiiinnnngggg,  ----ddddeeeeaaaaddddpppprrrreeeesssseeeerrrrvvvviiiinnnngggg,  ----wwwweeeeaaaakkkkttttrrrraaaacccceeee,  and/or
          the priority operator.  Debugging option, not available
          in official releases of CADP.



(C) INRIA            Last change: 2020/02/11                    4






CADP MANUAL PAGES                                 EXP.OPEN(LOCAL)



     ----iiiinnnntttteeeerrrrffffaaaacccceeee _i_n_t_e_r_f_a_c_e__d_i_r_e_c_t_i_v_e_s
          This option allows to generate a refined  interface  as
          explained in the article [Lang-06].

          This option assumes that the composition of LTSs stored
          in  _f_i_l_e_n_a_m_e....eeeexxxxpppp  corresponds to a system of concurrent
          processes _S as follows: The concurrent architecture  of
          _f_i_l_e_n_a_m_e....eeeexxxxpppp is the same as the concurrent architecture
          of _S, and each LTS in  _f_i_l_e_n_a_m_e....eeeexxxxpppp  represents  either
          the  state  space (named concrete LTS in the sequel) or
          simply the set of labels (named  abstract  LTS  in  the
          sequel)  of  the corresponding process in _S; States and
          transitions of abstract LTSs are irrelevant.

          Consider processes _P_0, _P_1, ..., _P_m of _S, such that,  in
          _f_i_l_e_n_a_m_e....eeeexxxxpppp,  the  LTS corresponding to _P_0 is abstract
          and the LTSs corresponding to _P_1, ..., _P_m are concrete.
          The ----iiiinnnntttteeeerrrrffffaaaacccceeee option allows to synthesize an interface
          representing the synchronization constraints imposed on
          _P_0  by  _P_1, ..., _P_m.  This interface has the form of an
          OPEN/CAESAR  graph  module  stored  in  a  file   named
          _f_i_l_e_n_a_m_e....cccc  and a list of synchronisation labels stored
          in a file named _f_i_l_e_n_a_m_e....ssssyyyynnnncccc.  The graph module can be
          translated    into    an   explicit   LTS   using   the
          ggggeeeennnneeeerrrraaaattttoooorrrr(LOCAL) tool.  The resulting LTS can  then  be
          given,    together    with    _f_i_l_e_n_a_m_e....ssssyyyynnnncccc,   to   the
          pppprrrroooojjjjeeeeccccttttoooorrrr(LOCAL) tool so as to restrict  the  behaviour
          of _P_0.

          The  _i_n_t_e_r_f_a_c_e__d_i_r_e_c_t_i_v_e_s   argument   has   the   form
          "_n_a_t:_n_a_t__l_i_s_t",  where  _n_a_t  is  a  natural  number and
          _n_a_t__l_i_s_t is a list  of  natural  numbers  separated  by
          blank  characters.  Each of these natural numbers is an
          index corresponding to the rank of occurrence of an LTS
          in  _f_i_l_e_n_a_m_e....eeeexxxxpppp  (once  eventual  ....eeeexxxxpppp file names have
          been  substituted  by  the  expression  stored  in  the
          corresponding  ....eeeexxxxpppp  files).   Index  1  represents the
          leftmost LTS.  The left-hand side of ":" is  the  index
          of the LTS corresponding to _P_0.  The right-hand side of
          ":" is the list of indices of the LTSs corresponding to
          _P_1,  ..., _P_m.  _i_n_t_e_r_f_a_c_e__d_i_r_e_c_t_i_v_e_s must be parsed as a
          single argument on the command line and  thus  must  be
          enclosed in quotes.


     ----iiiinnnntttteeeerrrrffffaaaacccceeeeuuuusssseeeerrrr
          Indicate that some of the automata in _f_i_l_e_n_a_m_e....eeeexxxxpppp have
          been  obtained  by  semi-composition  with "user-given"
          restriction  interfaces,  and  compute  the  associated
          validation  predicates.  Note that this option does not
          make sense outside a compositional verification process
          using restriction interfaces.  See pppprrrroooojjjjeeeeccccttttoooorrrr(LOCAL) and



(C) INRIA            Last change: 2020/02/11                    5






CADP MANUAL PAGES                                 EXP.OPEN(LOCAL)



          ssssvvvvllll(LOCAL) for more information about using restriction
          interfaces.  This is not a default option.


     ----llllaaaabbbbeeeellllssss
          Display the number of labels followed by  the  list  of
          labels  potentially occurring in the state space of the
          input network of communicating automata and  stop.   If
          the  ----iiiinnnntttteeeerrrrffffaaaacccceeeeuuuusssseeeerrrr  option  is  set,  do not print the
          labels representing validation predicates (see  ----iiiinnnntttteeeerrrr----
          ffffaaaacccceeeeuuuusssseeeerrrr option).


     ----lllloooottttoooossss
          Set LOTOS as the reference  language.  This  is  not  a
          default  option.   See  Section  LANGUAGE PARAMETERS of
          eeeexxxxpppp(LOCAL) for details.


     ----mmmmccccrrrrllll
          Set mCRL as the  reference  language.  This  is  not  a
          default  option.   See  Section  LANGUAGE PARAMETERS of
          eeeexxxxpppp(LOCAL) for details.


     ----nnnneeeettttwwwwoooorrrrkkkk _f_o_r_m_a_t
          Generate a network equivalent to _f_i_l_e_n_a_m_e....eeeexxxxpppp in one of
          "nupn", "pep", "tina", "fc2", or "txt" _f_o_r_m_a_t and stop:

          If _f_o_r_m_a_t is "nupn", eeeexxxxpppp....ooooppppeeeennnn generates  a  file  named
          _f_i_l_e_n_a_m_e....nnnnuuuuppppnnnn,  containing  a  Petri  net  in  the NUPN
          (_N_e_s_t_e_d _U_n_i_t _P_e_t_r_i _N_e_t) file format [Garavel-15-a] (see
          ccccaaaaeeeessssaaaarrrr....bbbbdddddddd(LOCAL)  for  a  description of the NUPN for-
          mat);

          If _f_o_r_m_a_t is "pep", eeeexxxxpppp....ooooppppeeeennnn  generates  a  file  named
          _f_i_l_e_n_a_m_e....llllllll____nnnneeeetttt,  containing  a  Petri  net in the low-
          level PEP file format [Best-Grahlmann-98];

          If _f_o_r_m_a_t is "tina", eeeexxxxpppp....ooooppppeeeennnn generates  a  file  named
          _f_i_l_e_n_a_m_e....ttttppppnnnn,  containing  a  Petri  net in the ``tpn''
          format of the TINA toolbox  [Berthomieu-Ribet-Vernadat-
          04];

          If _f_o_r_m_a_t is "fc2", eeeexxxxpppp....ooooppppeeeennnn  generates  a  file  named
          _f_i_l_e_n_a_m_e....ffffcccc2222,  containing  a network of automata in the
          FC2 format [Bouali-Ressouche-Roy-deSimone-96].

          If _f_o_r_m_a_t is "txt", eeeexxxxpppp....ooooppppeeeennnn  generates  a  file  named
          _f_i_l_e_n_a_m_e....ttttxxxxtttt,  containing  a description of the network
          of automata in an undocumented  textual  format.   This
          description  includes  the list of files containing the



(C) INRIA            Last change: 2020/02/11                    6






CADP MANUAL PAGES                                 EXP.OPEN(LOCAL)



          communicating automata, the list of labels  potentially
          occurring  in the product and, for each label, the list
          of synchronization vectors.

          The bbbbccccgggg____iiiioooo(LOCAL) and ffffcccc2222lllliiiinnnnkkkk tools are  called  inter-
          nally  to  make  the  conversion from EXP to FC2.  Note
          however that ffffcccc2222lllliiiinnnnkkkk is not provided  within  CADP  but
          belongs  to  the  Fc2Tools  distribution,  which can be
          downloaded                at                http://www-
          sop.inria.fr/meije/verification.

          Moreover, when converting EXP to FC2, the hidden  event
          must  be written "i" (see ----hhhhiiiiddddddddeeeennnn option above and Sec-
          tion LANGUAGE PARAMETERS  of  eeeexxxxpppp(LOCAL)  for  details)
          because this is required by bbbbccccgggg____iiiioooo(LOCAL) and ffffcccc2222lllliiiinnnnkkkk.

          This option does not  require  an  exploration  module.
          This is not a default option.

          This option is not available if _f_i_l_e_n_a_m_e....eeeexxxxpppp contains a
          priority operator.


     ----nnnnoooocccchhhheeeecccckkkk
          Parsing of EXP behaviours is generally  followed  by  a
          static  semantics  verification  phase  to  verify that
          behaviours are well-formed.  Option ----nnnnoooocccchhhheeeecccckkkk skips this
          verification  phase.   This  option should be used with
          caution since the semantics of ill-formed behaviours is
          undefined.  This is not a default option.


     ----pppprrrroooobbbb
          Consider the LTSs composed in _f_i_l_e_n_a_m_e....eeeexxxxpppp  as  "proba-
          bilistic  LTSs" (see the bbbbccccgggg____mmmmiiiinnnn(LOCAL) manual page for
          details about probabilistic LTSs).  Labels of the  form
          "prob  %p"  or  "_l_a_b_e_l;  prob  %p",  where %p denotes a
          floating-point number in the  range  ]0..1]  and  _l_a_b_e_l
          denotes  a   character string that does not contain the
          ";" character, are  interpreted  as  "special"  transi-
          tions, named "probabilistic".  With this option, proba-
          bilistic transitions can always execute asynchronously.
          If  a parallel composition attempts to synchronize pro-
          babilistic transitions explicitly, then eeeexxxxpppp....ooooppppeeeennnn issues
          a warning message.


     ----rrrraaaatttteeee
          Consider the LTSs composed in _f_i_l_e_n_a_m_e....eeeexxxxpppp as "stochas-
          tic  LTSs"  (see  the  bbbbccccgggg____mmmmiiiinnnn(LOCAL)  manual  page for
          details about stochastic LTSs).   Labels  of  the  form
          "rate  %f"  or  "_l_a_b_e_l;  rate  %f",  where %f denotes a



(C) INRIA            Last change: 2020/02/11                    7






CADP MANUAL PAGES                                 EXP.OPEN(LOCAL)



          stricly  positive  floating-point  number   and   _l_a_b_e_l
          denotes  a   character string that does not contain the
          ";" character, are  interpreted  as  "special"  transi-
          tions,  named "stochastic".  With this option, stochas-
          tic transitions can always execute asynchronously.   If
          a parallel composition attempts to synchronize stochas-
          tic transitions  explicitly,  then  eeeexxxxpppp....ooooppppeeeennnn  issues  a
          warning message.


     ----rrrraaaatttteeeebbbbrrrraaaannnncccchhhhiiiinnnngggg
          This option is obsolete and should be replaced  by  the
          combination of options ----rrrraaaatttteeee ----bbbbrrrraaaannnncccchhhhiiiinnnngggg.


     ----ssssiiiilllleeeennnntttt
          Execute silently. Opposite of ----vvvveeeerrrrbbbboooosssseeee. Default  option
          is ----vvvveeeerrrrbbbboooosssseeee.


     ----ssssttttrrrroooonnnngggg
          Do not perform partial order reduction  of  the  graph.
          This is a default option.


     ----tttteeeerrrrmmmmiiiinnnnaaaattttiiiioooonnnn _s_t_r_i_n_g
          Set  _s_t_r_i_n_g  as  denoting  the  gate  used  to  express
          behaviour  termination.   The  default value depends on
          the reference language, see Section LANGUAGE PARAMETERS
          of eeeexxxxpppp(LOCAL) for details.


     ----uuuunnnnppppaaaarrrrsssseeee
          Use the "----bbbbccccgggg ----uuuunnnnppppaaaarrrrsssseeee" options of  bbbbccccgggg____iiiioooo  while  con-
          verting LTSs in AUT, FC2, or SEQ formats into BCG.  See
          the bbbbccccgggg____iiiioooo(LOCAL) manual page for details  about  these
          options.


     ----vvvveeeerrrrbbbboooosssseeee
          Report activities and progress,  including  errors,  to
          the  user's  screen.   Opposite  of  ----ssssiiiilllleeeennnntttt.   Default
          option is ----vvvveeeerrrrbbbboooosssseeee.


     ----vvvveeeerrrrssssiiiioooonnnn
          Display the version number and stop.


     ----wwwweeeeaaaakkkkttttrrrraaaacccceeee
          Perform on-the-fly partial order reduction modulo  weak
          trace  equivalence.   This  yields  a generally smaller



(C) INRIA            Last change: 2020/02/11                    8






CADP MANUAL PAGES                                 EXP.OPEN(LOCAL)



          graph,  which   is   equivalent   modulo   weak   trace
          equivalence  to  the  graph  obtained using the ----ssssttttrrrroooonnnngggg
          option.  This is not a default option.


     _c_c__o_p_t_i_o_n_s
          if any, are passed to the C compiler.

     _p_r_o_g__o_p_t_i_o_n_s
          if any, are passed to _p_r_o_g.


EEEEXXXXIIIITTTT SSSSTTTTAAAATTTTUUUUSSSS
     Exit status is 0 if everything is all right, > 0 otherwise.


BBBBIIIIBBBBLLLLIIIIOOOOGGGGRRRRAAAAPPPPHHHHYYYY
     [Berthomieu-Ribet-Vernadat-04]
          B. Berthomieu, P.-O. Ribet, and F. Vernadat.  The  tool
          TINA  - Construction of Abstract State Spaces for Petri
          Nets and Time Petri Nets.  In International Journal  of
          Production Research, Vol. 42, No 14, July 2004.


     [Best-Grahlmann-98]
          Eike Best and Bernd Grahlmann.  "PEP Documentation  and
          User       Guide."        http://parsys.informatik.uni-
          oldenburg.de/~pep/paper.html. 1998."


     [Bouali-Ressouche-Roy-deSimone-96]
          Amar Bouali, Annie Ressouche, Valerie Roy,  and  Robert
          de Simone.  The Fc2Tools set: a Toolset for the Verifi-
          cation of Concurrent Systems.   In  R.  Alur  and  T.A.
          Henzinger,  editors,  Proceedings of the 8th Conference
          on Computer-Aided Verification (New Brunswick, New Jer-
          sey,  USA).  Lecture  Notes  in Computer Science volume
          1102, Springer-Verlag, 1996.


     [Brookes-Hoare-Roscoe-84]
          S. D. Brookes, C. A. R. Hoare, and A.  W.  Roscoe.   "A
          Theory  of  Communicating  Sequential  Processes."   In
          Journal of the ACM, vol. 31, number 3,  pages  560-599.
          ACM, 1984.


     [Garavel-15-a]
          Hubert Garavel.  "Nested-Unit Petri Nets: A  Structural
          Means to Increase Efficiency and Scalability of Verifi-
          cation on Elementary Nets."  In  R.  Devillers  and  A.
          Valmari, editors, Proceedings of the 36th International



(C) INRIA            Last change: 2020/02/11                    9






CADP MANUAL PAGES                                 EXP.OPEN(LOCAL)



          Conference on Application and Theory of Petri Nets  and
          Concurrency  (Brussels, Belgium). Lecture Notes in Com-
          puter  Science  volume  9115,  Springer-Verlag,   2015.
          Available                                          from
          http://cadp.inria.fr/publications/Garavel-15-a.html


     [Garavel-Sighireanu-99]
          Hubert Garavel and Mihaela  Sighireanu.   "A  Graphical
          Parallel Composition Operator for Process Algebras." In
          J. Wu, Q. Gao, and S.T. Chanson,  editors,  Proceedings
          of   the   Joint  International  Conference  on  Formal
          Description Techniques for Distributed Systems and Com-
          munication Protocols, and Protocol Specification, Test-
          ing, and Verification FORTE/PSTV'99  (Beijing,  China).
          Kluwer   Academic  Publishers,  1999.   Available  from
          http://cadp.inria.fr/publications/Garavel-Sighireanu-
          99.html


     [Groote-Ponse-90]
          J.F. Groote and A. Ponse.  "The syntax and semantics of
          mCRL."  In A. Ponse, C. Verhoef and S.F.M. van Vlijmen,
          editors,  Algebra  of  Communicating   Processes   '94,
          Workshops  in  Computing  Series,  Springer-Verlag, pp.
          26-62, 1995.  Also appeared as:  Technical  Report  CS-
          R9076, CWI, Amsterdam, 1990.


     [ISO-89]
          ISO/IEC.  "LOTOS ---  A  Formal  Description  Technique
          Based   on   the  Temporal  Ordering  of  Observational
          Behaviour."  International Organization for  Standardi-
          zation --- Information Processing Systems --- Open Sys-
          tems Interconnection.   International  Standard  number
          8807.  Geneva, September 1989.


     [ISO-01]
          ISO/IEC.  "Enhancements to LOTOS (E-LOTOS)."   Interna-
          tional Organization for Standardization --- Information
          Technology.  International Standard number  15437:2001.
          Geneva, September 2001.


     [Lang-05]
          Frederic  Lang.   "EXP.OPEN  2.0:   A   Flexible   Tool
          Integrating  Partial  Order, Compositional, and On-the-
          fly Verification Methods."  In J. van de Pol, J. Romijn
          and  G. Smith, editors, Proceedings of the 5th Interna-
          tional Conference on Integrated Formal Methods IFM'2005
          (Eindhoven,   The   Netherlands).    Lecture  Notes  in



(C) INRIA            Last change: 2020/02/11                   10






CADP MANUAL PAGES                                 EXP.OPEN(LOCAL)



          Computer Science volume  3771,  Springer-Verlag,  2005.
          Available  from http://cadp.inria.fr/publications/Lang-
          05.html


     [Lang-06]
          Frederic Lang.  "Refined Interfaces  for  Compositional
          Verification."   In  E. Najm, J.-F. Pradat-Peyre and V.
          Viguie Donzeau-Gouge, editors, Proceedings of the  26th
          IFIP  WG  6.1  International Conference on Formal Tech-
          niques for Networked and Distributed Systems FORTE'2006
          (Paris,  France).   Lecture  Notes  in Computer Science
          volume 4229,  Springer-Verlag,  2006.   Available  from
          http://cadp.inria.fr/publications/Lang-06.html


     [Milner-89]
          Robin   Milner.   "Communication   and    Concurrency."
          Prentice-Hall, 1989.


     [Pace-Lang-Mateescu-03]
          Gordon Pace, Frederic Lang, and Radu Mateescu.  "Calcu-
          lating  tau-confluence  compositionally."  In W.A. Hunt
          Jr. and F. Somenzi, editors, 15th Computer-Aided Verif-
          ication  conference  (CAV  2003), Lecture Notes in Com-
          puter  Science  volume  2725,  Springer-Verlag,   2003.
          Available  from http://cadp.inria.fr/publications/Pace-
          Lang-Mateescu-03.html


AAAAUUUUTTTTHHHHOOOORRRRSSSS
     Versions  1.*:  Marius  Bozga,  Jean-Claude  Fernandez,  and
     Laurent Mounier.

     Versions 2.*: Frederic Lang and Hubert Garavel.


OOOOPPPPEEEERRRRAAAANNNNDDDDSSSS
     _f_i_l_e_n_a_m_e....eeeexxxxpppp        network   of   communicating    automata
                         (input)
     _f_i_l_e_n_a_m_e....cccc          graph module for filename.exp (output)
     _f_i_l_e_n_a_m_e....ffffcccc2222        FC2 network (output, with  ----nnnneeeettttwwwwoooorrrrkkkk  ffffcccc2222
                         option)
     _f_i_l_e_n_a_m_e....llllllll____nnnneeeetttt     low level PEP Petri  net  (output,  with
                         ----nnnneeeettttwwwwoooorrrrkkkk ppppeeeepppp option)
     _f_i_l_e_n_a_m_e....nnnnuuuuppppnnnn       NUPN Petri net  (output,  with  ----nnnneeeettttwwwwoooorrrrkkkk
                         nnnnuuuuppppnnnn option)
     _f_i_l_e_n_a_m_e....ttttppppnnnn        TINA Petri net  (output,  with  ----nnnneeeettttwwwwoooorrrrkkkk
                         ttttiiiinnnnaaaa option)
     _p_r_o_g....aaaa              exploration module (archive, input)
     _p_r_o_g....cccc              exploration module (source, input)



(C) INRIA            Last change: 2020/02/11                   11






CADP MANUAL PAGES                                 EXP.OPEN(LOCAL)



     _p_r_o_g....oooo              exploration module (object code, input)
     _p_r_o_g                executable program (output)


FFFFIIIILLLLEEEESSSS
     $$$$CCCCAAAADDDDPPPP////ccccoooommmm////eeeexxxxpppp....ooooppppeeeennnn             ``exp.open'' shell script
     $$$$CCCCAAAADDDDPPPP////bbbbiiiinnnn....````aaaarrrrcccchhhh````////lllliiiibbbbeeeexxxxpppp____ooooppppeeeennnn....aaaa ``exp.open'' static library
     $$$$CCCCAAAADDDDPPPP////bbbbiiiinnnn....````aaaarrrrcccchhhh````////eeeexxxxpppp2222cccc         ``exp.open''   graph   module
                                    generator
     $$$$CCCCAAAADDDDPPPP////iiiinnnnccccllll////ccccaaaaeeeessssaaaarrrr____****....hhhh          OPEN/CAESAR interfaces
     $$$$CCCCAAAADDDDPPPP////bbbbiiiinnnn....````aaaarrrrcccchhhh````////lllliiiibbbbccccaaaaeeeessssaaaarrrr....aaaa   OPEN/CAESAR library
     $$$$CCCCAAAADDDDPPPP////ssssrrrrcccc////ooooppppeeeennnn____ccccaaaaeeeessssaaaarrrr////****....cccc      exploration modules (source)
     $$$$CCCCAAAADDDDPPPP////bbbbiiiinnnn....````aaaarrrrcccchhhh````////****....aaaa           exploration modules (archive)
     $$$$CCCCAAAADDDDPPPP////bbbbiiiinnnn....````aaaarrrrcccchhhh````////****....oooo           exploration  modules  (object
                                    code)


SSSSEEEEEEEE AAAALLLLSSSSOOOO
     aaaallllddddeeeebbbbaaaarrrraaaannnn(LOCAL),  aaaauuuutttt(LOCAL),  bbbbccccgggg(LOCAL),   bbbbccccgggg____iiiioooo(LOCAL),
     ccccaaaaeeeessssaaaarrrr____hhhhiiiiddddeeee____1111(LOCAL),   ccccaaaaeeeessssaaaarrrr____rrrreeeennnnaaaammmmeeee____1111(LOCAL),  eeeexxxxpppp(LOCAL),
     lllloooottttoooossss....ooooppppeeeennnn(LOCAL),     pppprrrroooojjjjeeeeccccttttoooorrrr(LOCAL),      rrrreeeeggggeeeexxxxpppp(LOCAL),
     sssseeeeqqqq(LOCAL), ssssvvvvllll(LOCAL)

     Additional information is available from the CADP  Web  page
     located at http://cadp.inria.fr

     Directives   for   installation   are   given    in    files
     $$$$CCCCAAAADDDDPPPP////IIIINNNNSSSSTTTTAAAALLLLLLLLAAAATTTTIIIIOOOONNNN____****....

     Recent  changes  and  improvements  to  this  software   are
     reported and commented in file $$$$CCCCAAAADDDDPPPP////HHHHIIIISSSSTTTTOOOORRRRYYYY....


BBBBUUUUGGGGSSSS
     Please report bugs to cadp@inria.fr




















(C) INRIA            Last change: 2020/02/11                   12



