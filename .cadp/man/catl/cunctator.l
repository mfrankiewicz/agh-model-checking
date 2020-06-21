


CADP MANUAL PAGES                                CUNCTATOR(LOCAL)



NNNNAAAAMMMMEEEE
     cunctator   -   on-the-fly   steady-state   simulation    of
     continuous-time Markov chains


SSSSYYYYNNNNOOOOPPPPSSSSIIIISSSS
     bbbbccccgggg____ooooppppeeeennnn    [_b_c_g__o_p_t]    _s_p_e_c[....bbbbccccgggg]    [_c_c__o_p_t]    ccccuuuunnnnccccttttaaaattttoooorrrr
     [_c_u_n_c_t_a_t_o_r__o_p_t]

     or:

     eeeexxxxpppp....ooooppppeeeennnn    [_e_x_p__o_p_t]    _s_p_e_c[....eeeexxxxpppp]    [_c_c__o_p_t]    ccccuuuunnnnccccttttaaaattttoooorrrr
     [_c_u_n_c_t_a_t_o_r__o_p_t]

     or:

     ffffsssspppp....ooooppppeeeennnn    [_f_s_p__o_p_t]    _s_p_e_c[....llllttttssss]    [_c_c__o_p_t]    ccccuuuunnnnccccttttaaaattttoooorrrr
     [_c_u_n_c_t_a_t_o_r__o_p_t]

     or:

     llllnnnntttt....ooooppppeeeennnn    [_l_n_t__o_p_t]    _s_p_e_c[....llllnnnntttt]    [_c_c__o_p_t]    ccccuuuunnnnccccttttaaaattttoooorrrr
     [_c_u_n_c_t_a_t_o_r__o_p_t]

     or:

     lllloooottttoooossss....ooooppppeeeennnn  [_l_o_t_o_s__o_p_t]  _s_p_e_c[....lllloooottttoooossss]   [_c_c__o_p_t]   ccccuuuunnnnccccttttaaaattttoooorrrr
     [_c_u_n_c_t_a_t_o_r__o_p_t]

     or:

     sssseeeeqqqq....ooooppppeeeennnn    [_s_e_q__o_p_t]    _s_p_e_c[....sssseeeeqqqq]    [_c_c__o_p_t]    ccccuuuunnnnccccttttaaaattttoooorrrr
     [_c_u_n_c_t_a_t_o_r__o_p_t]


DDDDEEEESSSSCCCCRRRRIIIIPPPPTTTTIIIIOOOONNNN
     ccccuuuunnnnccccttttaaaattttoooorrrr (from the Latin, the one who temporises) takes  as
     input  a  continuous-time  Markov  chain  (CTMC),  expressed
     either as a BCG graph  _s_p_e_c....bbbbccccgggg,,,,  a  composition  expression
     _s_p_e_c....eeeexxxxpppp,,,,  an FSP program _s_p_e_c....llllttttssss,,,, an LNT program _s_p_e_c....llllnnnntttt,,,,
     a LOTOS program _s_p_e_c....lllloooottttoooossss,,,, or a sequence file _s_p_e_c....sssseeeeqqqq....


     ccccuuuunnnnccccttttaaaattttoooorrrr performs an on-the-fly random  simulation  of  the
     CTMC, by a forward traversal of a transition sequence in the
     CTMC, and computes, for certain specified transitions, their
     throughput at the equilibrium ("steady-state").  The simula-
     tion terminates either when some  convergence  criterion  is
     met  (see  OPTIONS below), or when the user aborts it (e.g.,
     by typing a Ctrl-C).  Upon termination  of  the  simulation,
     the  values of the throughputs, accompanied by other simula-
     tion statistics, are displayed on standard output.



(C) INRIA            Last change: 2020/02/12                    1






CADP MANUAL PAGES                                CUNCTATOR(LOCAL)



     All transition labels of the CTMC must have one of the  fol-
     lowing forms:

     -    "rrrraaaatttteeee %_f" (called a stochastic transition),

     -    "_a_c_t_i_o_n;;;; rrrraaaatttteeee %_f" (called a labelled stochastic transi-
          tion), or

     -    "_i" (called an internal transition),

     where %%%%ffff denotes a strictly positive floating-point  number,
     and  _a_c_t_i_o_n denotes a character string that does not contain
     the ";;;;" character.


     If the graph specified  by  _s_p_e_c  also  contains  transition
     labels  of  other  forms than the aforementioned ones, these
     labels must be hidden or renamed using  the  ----hhhhiiiiddddeeee  and  the
     ----rrrreeeennnnaaaammmmeeee  options  (see  OPTIONS below) in order to turn _s_p_e_c
     into a CTMC.


     A state is called _s_t_a_b_l_e if  it  has  no  outgoing  internal
     transitions and is called _u_n_s_t_a_b_l_e otherwise.


     The simulation  algorithm  used  by  ccccuuuunnnnccccttttaaaattttoooorrrr  applies  the
     notion  of maximal progress: every time an unstable state is
     encountered, all its  outgoing  stochastic  transitions  are
     ignored  and  the simulation sequence is advanced along some
     of its outgoing internal transitions.


     The CTMC is assumed not  to  contain  nondeterminism,  which
     means that all internal transitions going out of an unstable
     state must lead to states that are  equivalent  modulo  sto-
     chastic  branching  bisimulation.   For  efficiency reasons,
     ccccuuuunnnnccccttttaaaattttoooorrrr does  not  attempt  to  perform  this  check,  but
     instead  it displays among the simulation statistics whether
     potential  nondeterminism  was  encountered  or  not,  i.e.,
     whether  a state having at least two outgoing internal tran-
     sitions was reached during simulation. The tool also  offers
     several  ways  of  choosing internal transitions by means of
     the ----sssscccchhhheeeedddduuuulllleeeerrrr option (see OPTIONS below) in order to  study
     whether they yield the same throughputs (which indicates the
     possible absence of nondeterminism) or not (which  indicates
     the necessary presence of nondeterminism).


     See also bbbbccccgggg____mmmmiiiinnnn(LOCAL) for a discussion about  the  various
     probabilistic  and  stochastic models present in the litera-
     ture.



(C) INRIA            Last change: 2020/02/12                    2






CADP MANUAL PAGES                                CUNCTATOR(LOCAL)



OOOOPPPPTTTTIIIIOOOONNNNSSSS
     The options _b_c_g__o_p_t, if any, are passed to bbbbccccgggg____lllliiiibbbb(LOCAL).

     The options _e_x_p__o_p_t, if any, are passed to eeeexxxxpppp....ooooppppeeeennnn(LOCAL).

     The options _f_s_p__o_p_t, if any, are passed to ffffsssspppp....ooooppppeeeennnn(LOCAL).

     The options _l_n_t__o_p_t, if any, are passed to llllnnnntttt....ooooppppeeeennnn(LOCAL).

     The options _l_o_t_o_s__o_p_t, if any, are passed  to  ccccaaaaeeeessssaaaarrrr(LOCAL)
     and to ccccaaaaeeeessssaaaarrrr....aaaaddddtttt(LOCAL).

     The options _s_e_q__o_p_t, if any, are passed to sssseeeeqqqq....ooooppppeeeennnn(LOCAL).

     The options _c_c__o_p_t, if any, are passed to the C compiler.

     The following options _c_u_n_c_t_a_t_o_r__o_p_t are currently available:


     ----aaaaccccttttiiiioooonnnn _a_c_t_i_o_n__1 ... _a_c_t_i_o_n__n
          Specify the actions contained in the labels of stochas-
          tic  transitions  "_a_c_t_i_o_n__i;;;; rrrraaaatttteeee %_f" (for 1111 <<<<==== iiii <<<<==== nnnn)
          of the CTMC for which the throughput must be  computed.
          All  the  stochastic  transitions  of  the  CTMC having
          labels other than "_a_c_t_i_o_n__i;;;; rrrraaaatttteeee %_f" (for 1111 <<<<==== iiii <<<<==== nnnn)
          are  considered as purely stochastic transitions (i.e.,
          their actions are ignored  and  only  their  rates  are
          taken  into  account)  during  the  simulation. If this
          option is absent, the throughput is  computed  for  all
          the actions contained in the labels of stochastic tran-
          sitions of the CTMC.

          To obtain useful results, each of the actions  _a_c_t_i_o_n__i
          (for  1111 <<<<==== iiii <<<<==== nnnn) must be contained in the label of at
          least one stochastic transition of the CTMC.  This  can
          be  ensured  by  taking  care that the options ----aaaaccccttttiiiioooonnnn,
          ----hhhhiiiiddddeeee, and ----rrrreeeennnnaaaammmmeeee  are  compatible.   If  some  action
          _a_c_t_i_o_n__i  is  absent from the CTMC, its throughput will
          be always equal to 0.0 regardless of the other  parame-
          ters of the simulation.

          Note: For efficiency reasons, it is recommended to  use
          this   option   whenever  the  actions  for  which  the
          throughput must be computed are known.


     ----hhhhiiiiddddeeee [[[[ ----ttttoooottttaaaallll |||| ----ppppaaaarrrrttttiiiiaaaallll |||| ----ggggaaaatttteeee ]]]] _h_i_d_i_n_g__f_i_l_e_n_a_m_e
          Use the hiding rules defined in _h_i_d_i_n_g__f_i_l_e_n_a_m_e to hide
          (on-the-fly)    the    labels    of   _s_p_e_c.   See   the
          ccccaaaaeeeessssaaaarrrr____hhhhiiiiddddeeee____1111(LOCAL)  manual  page   for   a   detailed
          description    of    the    appropriate    format   for
          _h_i_d_i_n_g__f_i_l_e_n_a_m_e.



(C) INRIA            Last change: 2020/02/12                    3






CADP MANUAL PAGES                                CUNCTATOR(LOCAL)



          The ----ttttoooottttaaaallll, ----ppppaaaarrrrttttiiiiaaaallll, and  ----ggggaaaatttteeee  options  specify  the
          "total  matching", "partial matching", and "gate match-
          ing"     semantics,     respectively.      See      the
          ccccaaaaeeeessssaaaarrrr____hhhhiiiiddddeeee____1111(LOCAL) manual page for more details about
          these semantics. Option ----ttttoooottttaaaallll is the default.


     ----rrrreeeennnnaaaammmmeeee [[[[----ttttoooottttaaaallll||||----ssssiiiinnnngggglllleeee||||----mmmmuuuullllttttiiiipppplllleeee||||----ggggaaaatttteeee]]]] _r_e_n_a_m_i_n_g__f_i_l_e_n_a_m_e
          Use the renaming rules defined in _r_e_n_a_m_i_n_g__f_i_l_e_n_a_m_e  to
          rename   (on-the-fly)  the  labels  of  _s_p_e_c.  See  the
          ccccaaaaeeeessssaaaarrrr____rrrreeeennnnaaaammmmeeee____1111(LOCAL)  manual  page  for  a   detailed
          description    of    the    appropriate    format   for
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

          The hiding and renaming options are useful for convert-
          ing  the  transition labels of _s_p_e_c on-the-fly in order
          to transform it into a CTMC.  If (one of) these options
          and the ----aaaaccccttttiiiioooonnnn option are present on the command-line,
          the hiding and renaming options will be applied  before
          the ----aaaaccccttttiiiioooonnnn option is taken into account.


     ----ccccaaaacccchhhheeee _s_i_z_e _r_e_p_l
          Trigger the use of an internal  cache  for  storing  at
          most  _s_i_z_e  states  in  order to speed up simulation by
          avoiding the  recomputation  of  certain  sequences  of
          internal  transitions. When the cache is full and a new
          state must be inserted in it, some other state  present
          in  the  cache  is deleted and replaced by the new one.
          The choice of the state to be deleted is made according
          to the replacement strategy _r_e_p_l, which can take one of
          the following values:  LRU (_L_e_a_s_t _R_e_c_e_n_t_l_y  _U_s_e_d),  MRU
          (_M_o_s_t  _R_e_c_e_n_t_l_y _U_s_e_d), LFU (_L_e_a_s_t _F_r_e_q_u_e_n_t_l_y _U_s_e_d), MFU
          (_M_o_s_t _F_r_e_q_u_e_n_t_l_y _U_s_e_d), and RND (_R_a_n_d_o_m).  This  option
          can be used only for the schedulers 0 and 1 (see option
          ----sssscccchhhheeeedddduuuulllleeeerrrr below). By default, the size of the cache is
          0  (i.e.,  no  caching is performed during simulation).
          Not a default option.




(C) INRIA            Last change: 2020/02/12                    4






CADP MANUAL PAGES                                CUNCTATOR(LOCAL)



     ----ddddeeeepppptttthhhh _d_e_p_t_h
          Specify  the  maximum  number  of  transitions  of  the
          sequence  traversed  during simulation. When the number
          of  transitions  of  the  current  simulation  sequence
          becomes  equal  to  the  natural number _d_e_p_t_h, then the
          simulation terminates and the statistics are  reported.
          A value 0 of _d_e_p_t_h means no limit, i.e., the simulation
          will run for ever unless  aborted  by  the  user.   The
          default value of _d_e_p_t_h is 0.


     ----ttttiiiimmmmeeee _t_i_m_e
          Specify the maximum simulation time, which is  the  sum
          of  all  durations  spent  in  the stable states of the
          transition sequence traversed during  simulation.  When
          the current simulation time (the sum of durations spent
          in  the  stable  states  of  the   current   simulation
          sequence)  becomes  equal  to  or greater than the real
          number _t_i_m_e, then the  simulation  terminates  and  the
          statistics  are  reported. A value 0.0 of _t_i_m_e means no
          limit, i.e., the simulation will run  for  ever  unless
          aborted by the user. The default value of _t_i_m_e is 0.0.

          If both options ----ddddeeeepppptttthhhh and ----ttttiiiimmmmeeee  are  present  on  the
          command-line,  the option ----ddddeeeepppptttthhhh is ignored in favor of
          ----ttttiiiimmmmeeee.


     ----sssscccchhhheeeedddduuuulllleeeerrrr _n
          Specify the way an internal transition going out of  an
          unstable  state is chosen during simulation in order to
          apply the notion of maximal progress.  When the current
          state has several outgoing internal transitions, choos-
          ing a particular one  as  the  next  transition  to  be
          traversed  amounts to model a particular scheduler. The
          following  values  are  currently  available  for   the
          scheduler _n:

          - 0: Choose the first internal  transition  encountered
          while  scanning  the  transitions  going  out  from the
          current state.

          - 1: Choose the last  internal  transition  encountered
          while  scanning  the  transitions  going  out  from the
          current state.

          - 2: Choose randomly (with equal  probability)  one  of
          the  internal  transitions  going  out from the current
          state.

          This option enables the user to experiment with several
          schedulers  in  order  to  study  their  effect  on the



(C) INRIA            Last change: 2020/02/12                    5






CADP MANUAL PAGES                                CUNCTATOR(LOCAL)



          throughputs computed by simulation. Several simulations
          differing  only  in the scheduler used and yielding the
          same throughputs indicate the possible absence of  non-
          determinism  in  the  CTMC.   Two simulations differing
          only  in  their  scheduler   and   yielding   different
          throughputs  indicate  the  necessary  presence of non-
          determinism in the CTMC.  The default value of _n is 0.


     ----rrrrnnnngggg _n
          Specify the random number generator used for  computing
          the  current  simulation time and to select the transi-
          tions of the simulation sequence.  Four  random  number
          generators  are  currently  available (_n = 0, 1, 2, 3).
          The default value of _n is 3.


     ----sssseeeeeeeedddd _s_e_e_d
          Specify the seed of the random  number  generator  used
          during simulation.  The default value of _s_e_e_d is 1.


     ----rrrraaaatttteeee
          Trigger  the  CTMC  simulation   and   computation   of
          throughputs.

          Note: This option is currently superfluous  (if  it  is
          absent  from  the  command-line,  a  warning message is
          issued but the functioning of ccccuuuunnnnccccttttaaaattttoooorrrr is  unchanged),
          its current purpose being to anticipate possible future
          extensions of the tool.


     ----ssssaaaavvvveeee _c_o_n_t_e_x_t__f_i_l_e
          Save the context reached at  the  end  of  the  current
          simulation  in a binary file _c_o_n_t_e_x_t__f_i_l_e, which can be
          reused by a future invocation  of  ccccuuuunnnnccccttttaaaattttoooorrrr  with  the
          ----rrrreeeessssttttoooorrrreeee  option  in  order to start another simulation
          exactly from the point at which the current  simulation
          terminated. Not a default option.

          The context stored in _c_o_n_t_e_x_t__f_i_l_e upon termination  of
          the  current simulation includes the following informa-
          tion: the state of the CTMC, the number of  transitions
          of  the sequence traversed during simulation, the simu-
          lation time, and the state of the random number genera-
          tor  (which  will  be used to restart the random number
          generator in the future invocations of  ccccuuuunnnnccccttttaaaattttoooorrrr  with
          ----rrrreeeessssttttoooorrrreeee    that    reuse   the   context   stored   in
          _c_o_n_t_e_x_t__f_i_l_e).  The format of _c_o_n_t_e_x_t__f_i_l_e  is  undocu-
          mented and subject to future changes.




(C) INRIA            Last change: 2020/02/12                    6






CADP MANUAL PAGES                                CUNCTATOR(LOCAL)



     ----rrrreeeessssttttoooorrrreeee _c_o_n_t_e_x_t__f_i_l_e
          Restore the context stored in _c_o_n_t_e_x_t__f_i_l_e by a  previ-
          ous  invocation  of ccccuuuunnnnccccttttaaaattttoooorrrr with the ----ssssaaaavvvveeee option and
          start a  new  simulation  from  that  context.   Not  a
          default option.

          If option ----ddddeeeepppptttthhhh is present on  the  command-line,  the
          current  simulation  will  terminate  according  to the
          _d_e_p_t_h indicated by this option. The number of new tran-
          sitions explored during the current simulation is equal
          to the difference between _d_e_p_t_h and the number of tran-
          sitions  _d  of the sequence restored from _c_o_n_t_e_x_t__f_i_l_e.
          In other words, the current simulation  will  terminate
          when  the  total number of transitions traversed during
          this simulation  and  during  the  previous  simulation
          whose  termination  context  was stored in _c_o_n_t_e_x_t__f_i_l_e
          becomes equal to  _d_e_p_t_h.   If  _d_e_p_t_h  <=  _d,  then  the
          current simulation terminates immediately and a warning
          message is issued. Option ----ttttiiiimmmmeeee is handled similarly.

          If the option ----aaaaccccttttiiiioooonnnn is present on  the  command-line,
          it  is  ignored  in  favor of the corresponding actions
          restored from _c_o_n_t_e_x_t__f_i_l_e.

          If the options ----sssseeeeeeeedddd or ----sssscccchhhheeeedddduuuulllleeeerrrr are present  on  the
          command-line,  they  have  higher  precedence  than the
          corresponding values restored from  _c_o_n_t_e_x_t__f_i_l_e.  This
          makes possible two kinds of simulation scenarios:

          - One can perform a first  simulation  _s_i_m_1,  save  its
          context _C, and start one or several simulations from _C,
          but with seed and scheduler parameters  different  than
          those  of  _s_i_m_1.  This  is  useful, e.g., when the _s_i_m_1
          simulation is intended to go over some  initial  "tran-
          sient"  behaviour  of  the  system, after which several
          simulations, with different seed and scheduler  parame-
          ters,  can  be performed in order to study the "steady"
          behaviour of the system.

          - If one must ensure that the former  simulation  whose
          termination  context  is  stored  in  _c_o_n_t_e_x_t__f_i_l_e is a
          proper prefix  of  the  current  simulation,  then  the
          options  ----sssseeeeeeeedddd  and  ----sssscccchhhheeeedddduuuulllleeeerrrr must be absent from the
          command-line. In this way, a simulation _s_i_m_1  terminat-
          ing in context _C followed by a simulation _s_i_m_2 starting
          from _C yields the same results as a  single  simulation
          _s_i_m having the same seed and scheduler as _s_i_m_1 and hav-
          ing the same termination conditions (depth or time)  as
          _s_i_m_2.

          If the options ----hhhhiiiiddddeeee or ----rrrreeeennnnaaaammmmeeee  were  present  on  the
          command-line  of  the  previous invocation of ccccuuuunnnnccccttttaaaattttoooorrrr



(C) INRIA            Last change: 2020/02/12                    7






CADP MANUAL PAGES                                CUNCTATOR(LOCAL)



          which produced _c_o_n_t_e_x_t__f_i_l_e, they must also be  present
          (with  exactly  the same arguments) on the command-line
          of the current invocation  of  ccccuuuunnnnccccttttaaaattttoooorrrr  in  order  to
          ensure that the former simulation is a proper prefix of
          the current simulation.

          Note: When the options ----ssssaaaavvvveeee and  ----rrrreeeessssttttoooorrrreeee  are  simul-
          taneously present on the command-line, they can use the
          same file _c_o_n_t_e_x_t__f_i_l_e.  This file will be  first  read
          in  order to restore the context from which the current
          simulation is started, then rewritten upon  termination
          of  the simulation in order to save the context reached
          at that point.


     -vvvveeeerrrrbbbboooosssseeee
          Animate the user's screen, telling what  is  going  on.
          Not a default option.


     -vvvveeeerrrrssssiiiioooonnnn
          Display the current version  number  of  the  tool  and
          stop.  To be effective, this option should occur as the
          first argument on the command line. Subsequent  options
          and/or  arguments,  if  any,  will  be discarded. Not a
          default option.


EEEEXXXXIIIITTTT SSSSTTTTAAAATTTTUUUUSSSS
     Exit status is 0 if everything is alright, 1 otherwise.


DDDDIIIIAAAAGGGGNNNNOOOOSSSSTTTTIIIICCCCSSSS
     When the transition labels of the CTMC _s_p_e_c do not have  the
     right format, error messages are issued.


AAAAUUUUTTTTHHHHOOOORRRRSSSS
     The tool was  developed  and  documented  by  Radu  Mateescu
     (INRIA/VASY),   with   the   advice   of   Holger   Hermanns
     (INRIA/VASY).  It is derived  from  the  _g_e_n_e_r_a_t_o_r  tool  of
     CADP,  developed  by  Hubert  Garavel  (INRIA/VASY).  Meriem
     Zidouni (Bull and INRIA/VASY) suggested various improvements
     (such as the computation of throughputs for several actions)
     concerning the prototype version 0.5 of the tool.


OOOOPPPPEEEERRRRAAAANNNNDDDDSSSS
     _s_p_e_c....bbbbccccgggg            BCG graph (input)
     _s_p_e_c....eeeexxxxpppp            network of communicating LTSs (input)
     _s_p_e_c....llllttttssss            FSP specification (input)
     _s_p_e_c....llllnnnntttt            LNT specification (input)



(C) INRIA            Last change: 2020/02/12                    8






CADP MANUAL PAGES                                CUNCTATOR(LOCAL)



     _s_p_e_c....lllloooottttoooossss          LOTOS specification (input)
     _s_p_e_c....sssseeeeqqqq            sequence file (input)

SSSSEEEEEEEE AAAALLLLSSSSOOOO
     bbbbccccgggg(LOCAL),         bbbbccccgggg____ooooppppeeeennnn(LOCAL),          ccccaaaaeeeessssaaaarrrr(LOCAL),
     ccccaaaaeeeessssaaaarrrr....aaaaddddtttt(LOCAL),                      ccccaaaaeeeessssaaaarrrr____ggggrrrraaaapppphhhh(LOCAL),
     ccccaaaaeeeessssaaaarrrr____hhhhiiiiddddeeee____1111(LOCAL),  ccccaaaaeeeessssaaaarrrr____rrrreeeennnnaaaammmmeeee____1111(LOCAL),   eeeexxxxpppp(LOCAL),
     eeeexxxxpppp....ooooppppeeeennnn(LOCAL),      ffffsssspppp....ooooppppeeeennnn(LOCAL),      llllnnnntttt....ooooppppeeeennnn(LOCAL),
     lllloooottttoooossss(LOCAL),         lllloooottttoooossss....ooooppppeeeennnn(LOCAL),         sssseeeeqqqq(LOCAL),
     sssseeeeqqqq....ooooppppeeeennnn(LOCAL), rrrreeeeggggeeeexxxxpppp(LOCAL)

     A related CTMC simulator for studying biological models  was
     developed by Verena Wolf (Saarland University).

     Additional information is available from the CADP  Web  page
     located at http://cadp.inria.fr
     Directives   for   installation   are   given    in    files
     $$$$CCCCAAAADDDDPPPP////IIIINNNNSSSSTTTTAAAALLLLLLLLAAAATTTTIIIIOOOONNNN____****....
     Recent  changes  and  improvements  to  this  software   are
     reported and commented in file $$$$CCCCAAAADDDDPPPP////HHHHIIIISSSSTTTTOOOORRRRYYYY....

BBBBUUUUGGGGSSSS
     Please report bugs to Radu.Mateescu@inria.fr
































(C) INRIA            Last change: 2020/02/12                    9



