


CADP MANUAL PAGES                             DETERMINATOR(LOCAL)



NNNNAAAAMMMMEEEE
     determinator - elimination of nondeterminism for  stochastic
     systems


SSSSYYYYNNNNOOOOPPPPSSSSIIIISSSS
     bbbbccccgggg____ooooppppeeeennnn   [_b_c_g__o_p_t]   _s_p_e_c[....bbbbccccgggg]   [_c_c__o_p_t]    ddddeeeetttteeeerrrrmmmmiiiinnnnaaaattttoooorrrr
     [_d_e_t_e_r_m_i_n_a_t_o_r__o_p_t] _r_e_s_u_l_t[....bbbbccccgggg]

     or:

     eeeexxxxpppp....ooooppppeeeennnn   [_e_x_p__o_p_t]   _s_p_e_c[....eeeexxxxpppp]   [_c_c__o_p_t]    ddddeeeetttteeeerrrrmmmmiiiinnnnaaaattttoooorrrr
     [_d_e_t_e_r_m_i_n_a_t_o_r__o_p_t] _r_e_s_u_l_t[....bbbbccccgggg]

     or:

     ffffsssspppp....ooooppppeeeennnn   [_f_s_p__o_p_t]   _s_p_e_c[....llllttttssss]   [_c_c__o_p_t]    ddddeeeetttteeeerrrrmmmmiiiinnnnaaaattttoooorrrr
     [_d_e_t_e_r_m_i_n_a_t_o_r__o_p_t] _r_e_s_u_l_t[....bbbbccccgggg]

     or:

     llllnnnntttt....ooooppppeeeennnn   [_l_n_t__o_p_t]   _s_p_e_c[....llllnnnntttt]   [_c_c__o_p_t]    ddddeeeetttteeeerrrrmmmmiiiinnnnaaaattttoooorrrr
     [_d_e_t_e_r_m_i_n_a_t_o_r__o_p_t] _r_e_s_u_l_t[....bbbbccccgggg]

     or:

     lllloooottttoooossss....ooooppppeeeennnn [_l_o_t_o_s__o_p_t]  _s_p_e_c[....lllloooottttoooossss]  [_c_c__o_p_t]  ddddeeeetttteeeerrrrmmmmiiiinnnnaaaattttoooorrrr
     [_d_e_t_e_r_m_i_n_a_t_o_r__o_p_t] _r_e_s_u_l_t[....bbbbccccgggg]

     or:

     sssseeeeqqqq....ooooppppeeeennnn   [_s_e_q__o_p_t]   _s_p_e_c[....sssseeeeqqqq]   [_c_c__o_p_t]    ddddeeeetttteeeerrrrmmmmiiiinnnnaaaattttoooorrrr
     [_d_e_t_e_r_m_i_n_a_t_o_r__o_p_t] _r_e_s_u_l_t[....bbbbccccgggg]


DDDDEEEESSSSCCCCRRRRIIIIPPPPTTTTIIIIOOOONNNN
     Taking as input an extended Markovian model expressed either
     as  a BCG graph _s_p_e_c....bbbbccccgggg, a composition expression _s_p_e_c....eeeexxxxpppp,
     an FSP program _s_p_e_c....llllttttssss, a LNT  program  _s_p_e_c....llllnnnntttt,  a  LOTOS
     program  _s_p_e_c....lllloooottttoooossss,  or  a  SEQ file _s_p_e_c....sssseeeeqqqq, ddddeeeetttteeeerrrrmmmmiiiinnnnaaaattttoooorrrr
     generates a reduced model by removing  stochastic  nondeter-
     minism on-the-fly.


     Extended Markovian models are state-transition  models  con-
     taining  ordinary,  probabilistic  and/or stochastic transi-
     tions. Stochastic determinization consists in trying to con-
     vert  the  extended  Markovian model _s_p_e_c into a continuous-
     time Markov chain (CTMC) by removing local sources  of  non-
     determinism.  It might fail if _s_p_e_c does not satisfy certain
     conditions.  If  it  succeeds,  the  CTMC  is   written   to
     _r_e_s_u_l_t....bbbbccccgggg;  otherwise,  an  error  message  is  issued. See



(C) INRIA            Last change: 2020/02/12                    1






CADP MANUAL PAGES                             DETERMINATOR(LOCAL)



     section STOCHASTIC DETERMINIZATION below for details.


     Note: Since March 2006, determinization of ordinary Labelled
     Transition  Systems  is no longer supported by ddddeeeetttteeeerrrrmmmmiiiinnnnaaaattttoooorrrr.
     Option ----rrrraaaatttteeee becomes the default option. The formerly avail-
     able options ----nnnnoooorrrrmmmmaaaallll and ----ttttaaaauuuucccclllloooossssuuuurrrreeee are now deprecated. Use
     the rrrreeeedddduuuuccccttttoooorrrr(LOCAL) tool instead, as explained below.


OOOOPPPPTTTTIIIIOOOONNNNSSSS
     The options _b_c_g__o_p_t, if any, are passed to bbbbccccgggg____lllliiiibbbb(LOCAL).


     The options _e_x_p__o_p_t, if any, are passed to eeeexxxxpppp....ooooppppeeeennnn(LOCAL).


     The options _f_s_p__o_p_t, if any, are passed to ffffsssspppp....ooooppppeeeennnn(LOCAL).


     The options _l_n_t__o_p_t, if any, are passed to llllnnnntttt....ooooppppeeeennnn(LOCAL).


     The options _l_o_t_o_s__o_p_t, if any, are passed  to  ccccaaaaeeeessssaaaarrrr(LOCAL)
     and to ccccaaaaeeeessssaaaarrrr....aaaaddddtttt(LOCAL).


     The options _s_e_q__o_p_t, if any, are passed to sssseeeeqqqq....ooooppppeeeennnn(LOCAL).


     The options _c_c__o_p_t, if any, are passed to the C compiler.


     The following options _d_e_t_e_r_m_i_n_a_t_o_r__o_p_t are currently  avail-
     able:


     ----eeeeppppssssiiiilllloooonnnn _e_p_s
          Set the precision of certain floating-point comparisons
          to  _e_p_s,  where _e_p_s is a real value. When _e_p_s is out of
          [0..1[, ddddeeeetttteeeerrrrmmmmiiiinnnnaaaattttoooorrrr reports an  error.  Default  value
          for _e_p_s is 1E-6.


     ----ffffoooorrrrmmmmaaaatttt _f_o_r_m_a_t__s_t_r_i_n_g
          Use  _f_o_r_m_a_t__s_t_r_i_n_g  to  control  the  format   of   the
          floating-point  numbers  contained in transition labels
          (these numbers correspond to the occurrences of %%%%ffff  and
          %%%%pppp  mentioned  in  section  STOCHASTIC  DETERMINIZATION
          below). The value of _f_o_r_m_a_t__s_t_r_i_n_g should obey the same
          conventions   as   the  _f_o_r_m_a_t  parameter  of  function
          sssspppprrrriiiinnnnttttffff(3C) for values of type  ddddoooouuuubbbblllleeee.  Default  value



(C) INRIA            Last change: 2020/02/12                    2






CADP MANUAL PAGES                             DETERMINATOR(LOCAL)



          for  _f_o_r_m_a_t__s_t_r_i_n_g is """"%%%%gggg"""", meaning that floating-point
          numbers are printed with at most six digits  after  the
          "."  (i.e.,  the  radix character). Other values can be
          used, for instance """"%%%%....9999gggg"""" to obtain nine digits instead
          of six, or by replacing the """"%%%%gggg"""" flag with other flags,
          namely """"%%%%eeee"""", """"%%%%EEEE"""", """"%%%%ffff"""",  or  """"%%%%GGGG"""",  possibly  combined
          with additional flags (e.g., to specify precision).


     ----hhhhiiiiddddeeee [[[[ ----ttttoooottttaaaallll |||| ----ppppaaaarrrrttttiiiiaaaallll |||| ----ggggaaaatttteeee ]]]] _h_i_d_i_n_g__f_i_l_e_n_a_m_e
          Use the hiding rules defined in _h_i_d_i_n_g__f_i_l_e_n_a_m_e to hide
          (on  the  fly)  the labels of the CTMC being generated.
          See the ccccaaaaeeeessssaaaarrrr____hhhhiiiiddddeeee____1111(LOCAL) manual page for a detailed
          description    of    the    appropriate    format   for
          _h_i_d_i_n_g__f_i_l_e_n_a_m_e.

          The ----ttttoooottttaaaallll, ----ppppaaaarrrrttttiiiiaaaallll, and  ----ggggaaaatttteeee  options  specify  the
          "total  matching", "partial matching", and "gate match-
          ing"     semantics,     respectively.      See      the
          ccccaaaaeeeessssaaaarrrr____hhhhiiiiddddeeee____1111(LOCAL) manual page for more details about
          these semantics. Option ----ttttoooottttaaaallll is the default.


     ----rrrreeeennnnaaaammmmeeee [[[[----ttttoooottttaaaallll||||----ssssiiiinnnngggglllleeee||||----mmmmuuuullllttttiiiipppplllleeee||||----ggggaaaatttteeee]]]] _r_e_n_a_m_i_n_g__f_i_l_e_n_a_m_e
          Use the renaming rules defined in _r_e_n_a_m_i_n_g__f_i_l_e_n_a_m_e  to
          rename  (on  the fly) the labels of the CTMC being gen-
          erated. See the ccccaaaaeeeessssaaaarrrr____rrrreeeennnnaaaammmmeeee____1111(LOCAL) manual page  for
          a  detailed  description  of the appropriate format for
          _r_e_n_a_m_i_n_g__f_i_l_e_n_a_m_e.

          The  ----ttttoooottttaaaallll,  ----ssssiiiinnnngggglllleeee,  ----mmmmuuuullllttttiiiipppplllleeee,  and  ----ggggaaaatttteeee  options
          specify  the  "total  matching", "single partial match-
          ing", "multiple partial matching", and "gate  matching"
          semantics, respectively. See the ccccaaaaeeeessssaaaarrrr____rrrreeeennnnaaaammmmeeee____1111(LOCAL)
          manual page for more  details  about  these  semantics.
          Option ----ttttoooottttaaaallll is the default.

          As  for  the  bbbbccccgggg____llllaaaabbbbeeeellllssss(LOCAL)  tool,  several  hiding
          and/or  renaming options can be present on the command-
          line, in which case they are  processed  from  left  to
          right.


     ----mmmmoooonnnniiiittttoooorrrr
          Open a window for monitoring in real-time  the  genera-
          tion of _r_e_s_u_l_t....bbbbccccgggg. Not a default option.


     ----uuuunnnnccccoooommmmpppprrrreeeessssssss,,,, ----ccccoooommmmpppprrrreeeessssssss,,,, ----rrrreeeeggggiiiisssstttteeeerrrr,,,, ----sssshhhhoooorrrrtttt,,,, ----mmmmeeeeddddiiiiuuuummmm,,,, ----ssssiiiizzzzeeee
          These options control the  form  under  which  the  BCG
          graph  _r_e_s_u_l_t....bbbbccccgggg  is  generated.  See  the  bbbbccccgggg(LOCAL)
          manual page for a description of these options.



(C) INRIA            Last change: 2020/02/12                    3






CADP MANUAL PAGES                             DETERMINATOR(LOCAL)



     ----ttttmmmmpppp This option specifies the directory in which  temporary
          files  are to be stored. See the bbbbccccgggg(LOCAL) manual page
          for a description of this option.


DDDDEEEEPPPPRRRREEEECCCCAAAATTTTEEEEDDDD OOOOPPPPTTTTIIIIOOOONNNNSSSS
     ----rrrraaaatttteeee
          This option is supported for backward compatibility but
          has no effect.


     ----nnnnoooorrrrmmmmaaaallll
          This option triggers an error message.  Use  ``rrrreeeedddduuuuccccttttoooorrrr
          ----ttttrrrraaaacccceeee'' instead of ``ddddeeeetttteeeerrrrmmmmiiiinnnnaaaattttoooorrrr ----nnnnoooorrrrmmmmaaaallll''.


     ----ttttaaaauuuucccclllloooossssuuuurrrreeee
          This option triggers an error message.  Use  ``rrrreeeedddduuuuccccttttoooorrrr
          ----wwwweeeeaaaakkkkttttrrrraaaacccceeee'' instead of ``ddddeeeetttteeeerrrrmmmmiiiinnnnaaaattttoooorrrr ----nnnnoooorrrrmmmmaaaallll ----ttttaaaauuuucccclllloooo----
          ssssuuuurrrreeee''.


SSSSTTTTOOOOCCCCHHHHAAAASSSSTTTTIIIICCCC DDDDEEEETTTTEEEERRRRMMMMIIIINNNNIIIIZZZZAAAATTTTIIIIOOOONNNN
     The input of ddddeeeetttteeeerrrrmmmmiiiinnnnaaaattttoooorrrr is  an  extended  Markovian  model
     combining  features  from  discrete-time and continuous-time
     Markov chains. All transition labels must have  one  of  the
     following forms:

     -    "rrrraaaatttteeee %_f" (called a stochastic transition), or

     -    "_l_a_b_e_l;;;; rrrraaaatttteeee %_f" (called a labelled stochastic  transi-
          tion), or

     -    "pppprrrroooobbbb %_p" (called a probabilistic transition), or

     -    "_l_a_b_e_l;;;; pppprrrroooobbbb %_p" (called a labelled probabilistic tran-
          sition), or

     -    "_l_a_b_e_l" (called an ordinary transition).

     where %%%%ffff denotes a strictly positive floating-point  number,
     %%%%pppp  denotes a floating-point number in the range ]0..1], and
     _l_a_b_e_l denotes a character string that does not  contain  the
     ";;;;"  character  (_l_a_b_e_l  may be equal to the internal action,
     often noted "i" or "tau").


     On the opposite, the expected output of  ddddeeeetttteeeerrrrmmmmiiiinnnnaaaattttoooorrrr  is  a
     continuous-time  Markov chain, i.e., a model containing sto-
     chastic transitions only.





(C) INRIA            Last change: 2020/02/12                    4






CADP MANUAL PAGES                             DETERMINATOR(LOCAL)



     See also bbbbccccgggg____mmmmiiiinnnn(LOCAL) for a discussion about  the  various
     probabilistic  and  stochastic models present in the litera-
     ture.


     States are classified as follows:

     -    A state is called _d_e_c_i_s_i_o_n if it is the source state of
          at least one ordinary transition.

     -    A state is called _v_a_n_i_s_h_i_n_g if it is not  decision  and
          the  source  state  of at least one (possibly labelled)
          probabilistic transition.

     -    A state is called _t_a_n_g_i_b_l_e if it  is  neither  decision
          nor vanishing.


     Note: the bbbbccccgggg____sssstttteeeeaaaaddddyyyy(LOCAL) and  bbbbccccgggg____ttttrrrraaaannnnssssiiiieeeennnntttt(LOCAL)  tools
     rely  on  the same notions of vanishing and tangible states,
     but do not have to consider decision states as they  do  not
     accept ordinary transitions.


     In order to be accepted by  ddddeeeetttteeeerrrrmmmmiiiinnnnaaaattttoooorrrr,  the  input  model
     must  satisfy  two  conditions (otherwise, ddddeeeetttteeeerrrrmmmmiiiinnnnaaaattttoooorrrr will
     emit an error message and stop):

     -    No decision state can be the source state of a  (possi-
          bly labelled) probabilistic transition.

     -    The model may not contain  cycles  of  ordinary  and/or
          (possibly  labelled)  probabilistic transitions; conse-
          quently, it necessarily contains at least one  tangible
          state.


     Note that if  there  exists  an  ordinary  transition  or  a
     (labelled)  probabilistic  transition  from  a state _S_1 to a
     state _S_2, then all (labelled)  stochastic  transitions  from
     _S_1, if any, are discarded, thus expressing that ordinary and
     probabilistic transitions are instantaneous.


     Note: The sum of %%%%pppp values  on  (possibly  labelled)  proba-
     bilistic  transitions leaving a vanishing state needs not be
     equal to 1; if this sum is different  from  1,  then  proba-
     bilistic  values  will  be normalized (i.e., divided by this
     sum) during determinization.






(C) INRIA            Last change: 2020/02/12                    5






CADP MANUAL PAGES                             DETERMINATOR(LOCAL)



     The stochastic determinization algorithm used in  ddddeeeetttteeeerrrrmmmmiiiinnnnaaaa----
     ttttoooorrrr is a variant of Deavours-Sanders' algorithm [DS99]. In a
     nutshell, it starts from the  initial  state  of  the  input
     model  and  recursively explores tangible states as follows.
     When in a tangible state  _S_1,  the  algorithm  inspects  all
     states   _S_2  reachable  from  _S_1  by  following  one  single
     (labelled) stochastic transition, the rate of which will  be
     noted %%%%ffff:


     -    If _S_2 is a tangible state, then the transition from  _S_1
          to  _S_2  is  kept in _r_e_s_u_l_t....bbbbccccgggg, and _S_2 will be explored
          recursively;

     -    If _S_2 is a decision or  a  vanishing  state,  then  the
          algorithm  checks  a local confluence property, namely,
          for each tangible state  _S_3  reachable  following  only
          ordinary and probabilistic transitions, that the proba-
          bility %%%%pppp to reach _S_3 from _S_2 does not  depend  on  the
          choice  of  the ordinary transitions followed. If so, a
          new stochastic transition from _S_1 to _S_3 with rate %%%%pppp*%%%%ffff
          is  added to _r_e_s_u_l_t....bbbbccccgggg, and _S_3 will be explored recur-
          sively. If not, ddddeeeetttteeeerrrrmmmmiiiinnnnaaaattttoooorrrr stops with an  error  mes-
          sage.


     Note: if the initial state _S_0 is not tangible,  and  if  one
     single  tangible  state  _S is reachable from _S_0 by following
     ordinary and/or probabilistic transitions only, then _S  will
     form  the  initial state of _r_e_s_u_l_t....bbbbccccgggg.  Otherwise, for each
     tangible state _S reachable from  _S_0  by  following  ordinary
     and/or probabilistic transitions only, a probabilistic tran-
     sition from _S_0 to _S (labelled with the probability to  reach
     _S)  will  be created; this is the only case where _r_e_s_u_l_t....bbbbccccgggg
     will contain a vanishing state, i.e., the  only  case  where
     ddddeeeetttteeeerrrrmmmmiiiinnnnaaaattttoooorrrr  does  not  produce  a  continuous-time  Markov
     chain, strictly speaking.


EEEEXXXXIIIITTTT SSSSTTTTAAAATTTTUUUUSSSS
     Exit status is 0 if everything is alright, 1 otherwise.


DDDDIIIIAAAAGGGGNNNNOOOOSSSSTTTTIIIICCCCSSSS
     When the source is erroneous, error messages are issued.


AAAAUUUUTTTTHHHHOOOORRRRSSSS
     The first version  of  the  stochastic  determinization  was
     written  by  Christophe Joubert (INRIA/VASY) and Holger Her-
     manns  (Saarland  University  and  University  of   Twente).
     Frederic Lang (INRIA/VASY) deeply revised the code. Frederic



(C) INRIA            Last change: 2020/02/12                    6






CADP MANUAL PAGES                             DETERMINATOR(LOCAL)



     Lang and Hubert  Garavel  (both  at  INRIA/VASY)  wrote  the
     current ddddeeeetttteeeerrrrmmmmiiiinnnnaaaattttoooorrrr manual page.


OOOOPPPPEEEERRRRAAAANNNNDDDDSSSS
     _s_p_e_c....bbbbccccgggg            BCG graph (input)
     _s_p_e_c....eeeexxxxpppp            network of communicating LTSs (input)
     _s_p_e_c....llllttttssss            FSP specification (input)
     _s_p_e_c....llllnnnntttt            LNT specification (input)
     _s_p_e_c....lllloooottttoooossss          LOTOS specification (input)
     _s_p_e_c....sssseeeeqqqq            SEQ file (input)
     _r_e_s_u_l_t....bbbbccccgggg          BCG graph (output)


SSSSEEEEEEEE AAAALLLLSSSSOOOO
     OPEN/CAESAR Reference  Manual,  bbbbccccgggg(LOCAL),  bbbbccccgggg____mmmmiiiinnnn(LOCAL),
     bbbbccccgggg____ooooppppeeeennnn(LOCAL),   bbbbccccgggg____sssstttteeeeaaaaddddyyyy(LOCAL),  bbbbccccgggg____ttttrrrraaaannnnssssiiiieeeennnntttt(LOCAL),
     ccccaaaaeeeessssaaaarrrr(LOCAL),        ccccaaaaeeeessssaaaarrrr....aaaaddddtttt(LOCAL),         eeeexxxxpppp(LOCAL),
     eeeexxxxpppp....ooooppppeeeennnn(LOCAL),      ffffsssspppp....ooooppppeeeennnn(LOCAL),      llllnnnntttt....ooooppppeeeennnn(LOCAL),
     lllloooottttoooossss(LOCAL),         lllloooottttoooossss....ooooppppeeeennnn(LOCAL),         sssseeeeqqqq(LOCAL),
     sssseeeeqqqq....ooooppppeeeennnn(LOCAL), sssspppprrrriiiinnnnttttffff(3C)


     Additional information is available from the CADP  Web  page
     located at http://cadp.inria.fr

     Directives   for   installation   are   given    in    files
     $$$$CCCCAAAADDDDPPPP////IIIINNNNSSSSTTTTAAAALLLLLLLLAAAATTTTIIIIOOOONNNN____****.

     Recent  changes  and  improvements  to  this  software   are
     reported and commented in file $$$$CCCCAAAADDDDPPPP////HHHHIIIISSSSTTTTOOOORRRRYYYY.


BBBBUUUUGGGGSSSS
     Please report bugs to cadp@inria.fr


BBBBIIIIBBBBLLLLIIIIOOOOGGGGRRRRAAAAPPPPHHHHYYYY
     [DS99] D. Deavours  and  W.  Sanders.   An  Efficient  Well-
     Specified   Check.   In  Proceedings  of  the  International
     Workshop on Petri Nets  and  Performance  Models  (PNPM'99),
     pages 124-133. IEEE Computer Society Press, 1999.


     [HJ03] H. Hermanns and Ch. Joubert. A Set of Performance and
     Dependability  Analysis  Components for CADP. In Proceedings
     of TACAS'2003, LNCS 2619, pages  425-430,  Springer  Verlag.
     Available  from  http://cadp.inria.fr/publications/Hermanns-
     Joubert-03.html






(C) INRIA            Last change: 2020/02/12                    7



