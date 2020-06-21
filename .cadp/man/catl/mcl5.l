


CADP MANUAL PAGES                                     MCL5(LOCAL)



NNNNAAAAMMMMEEEE
     mcl, MCL - Model Checking Language version 5  (probabilistic
     value-passing modal mu-calculus)


DDDDEEEESSSSCCCCRRRRIIIIPPPPTTTTIIIIOOOONNNN
     This manual page presents the version 5 of _M_C_L (_M_o_d_e_l _C_h_e_c_k_-
     _i_n_g _L_a_n_g_u_a_g_e), which is the temporal logic accepted as input
     by eeeevvvvaaaalllluuuuaaaattttoooorrrr5555(LOCAL).  _M_C_L version 5 conservatively  extends
     _M_C_L  version  4 with a probabilistic operator specifying the
     probability measure of transition sequences characterized by
     regular  formulas.   In  the  remainder  of this page, "_M_C_L"
     denotes version 5 of _M_C_L; see mmmmccccllll(LOCAL) for other  versions
     of _M_C_L.

     A description of the probabilistic operator of  _M_C_L  can  be
     found  in  article [MR18], which also presents the verifica-
     tion method implemented in version 5.0 of  EVALUATOR.   This
     method  is based on translating the problem into the resolu-
     tion of a Linear Equation System (LES) and  a  Parameterized
     Boolean Equation System (PBES), which are carried out simul-
     taneously on the fly.

     _M_C_L formulas are interpreted over a PTS (Probabilistic Tran-
     sition System) [LS91] <_S, _A, _T, _P, _s_0>, where:  _S is the set
     of _s_t_a_t_e_s, _A is the set of _a_c_t_i_o_n_s (transition labels), _T is
     the  _t_r_a_n_s_i_t_i_o_n  _r_e_l_a_t_i_o_n  (a subset of _S * _A * _S), _P is the
     _p_r_o_b_a_b_i_l_i_t_y  _l_a_b_e_l_i_n_g  (a  function  from  _T  to  the  range
     ]0..1]),  and _s_0 is the _i_n_i_t_i_a_l _s_t_a_t_e.  A transition (_s_1, _a,
     _s_2) of _T, also written _s_1-_a->_s_2, indicates that  the  system
     can  move  from  state _s_1 to state _s_2 by performing action _a
     with probability _P (_s_1, _a, _s_2).  For each state _s,  the  sum
     of  the probabilities associated to its outgoing transitions
     (_s, _a, _s') is equal to 1.  Note that this forbids the  pres-
     ence  of  sink  states  (deadlocks)  in the PTS, i.e., every
     state must have at least one outgoing transition.

     The PTS must contain only labelled probabilistic transitions
     of  the  form "_l_a_b_e_l;;;; pppprrrroooobbbb %_p", where %_p denotes a floating-
     point number in the range ]0..1] (see the  bbbbccccgggg____sssstttteeeeaaaaddddyyyy(LOCAL)
     manual  page  for  details).  An LTS can be converted into a
     PTS on the fly by renaming its transition labels  using  the
     ----rrrreeeennnnaaaammmmeeee  option  of  eeeevvvvaaaalllluuuuaaaattttoooorrrr5555(LOCAL) to append ";;;; pppprrrroooobbbb %_p"
     suffixes.  If after renaming transition labels, the  sum  of
     the probabilities associated to the transitions going out of
     a state is different from 1, these probabilities are normal-
     ized to bring this sum to 1.  If no ----rrrreeeennnnaaaammmmeeee option is given,
     the LTS is converted into a PTS  by  considering  that,  for
     every  state, all its outgoing transitions have equal proba-
     bilities, the sum of which is 1.





(C) INRIA            Last change: 2019/04/05                    1






CADP MANUAL PAGES                                     MCL5(LOCAL)



PPPPRRRROOOOBBBBAAAABBBBIIIILLLLIIIISSSSTTTTIIIICCCC OOOOPPPPEEEERRRRAAAATTTTOOOORRRR
     The probabilistic operator belongs to the _s_t_a_t_e _f_o_r_m_u_l_a_s  of
     MCL.  Its syntax is defined by the following grammar:

         "prob"
              _R
         "is"
              _o_p [ "?" ] _E
         "end" "prob"


     where _R is a regular formula on transition sequences, _o_p  is
     a comparison operator among "<", "<=", ">", ">=", "=", "<>",
     and _E is a data expression of type rrrreeeeaaaallll denoting a probabil-
     ity.

     Let _m (_s, _R) be the probability measure  of  the  transition
     sequences  going out of a state _s and having a prefix satis-
     fying the regular formula _R. A state _s of the PTS  satisfies
     the "prob" formula above iff _m (_s, _R) _o_p _v holds, where _v is
     the value of expression _E.

     If the optional "?" clause is present, the evaluation of the
     "prob"  formula  on  a state _s will also display the value _m
     (_s, _R) in addition to the Boolean verdict  (TRUE  or  FALSE)
     displayed by eeeevvvvaaaalllluuuuaaaattttoooorrrr5555(LOCAL).

     The regular formula _R  and  the  expression  _E  may  contain
     occurrences  of  free  data  variables  defined  outside the
     "prob" formula.  The data variables exported by _R  are  nei-
     ther  visible  in  _E,  nor exported outside the whole "prob"
     formula.


EEEEXXXXAAAAMMMMPPPPLLLLEEEESSSS OOOOFFFF PPPPRRRROOOOBBBBAAAABBBBIIIILLLLIIIISSSSTTTTIIIICCCC PPPPRRRROOOOPPPPEEEERRRRTTTTIIIIEEEESSSS
  DDDDAAAATTTTAAAALLLLEEEESSSSSSSS PPPPRRRROOOOPPPPEEEERRRRTTTTIIIIEEEESSSS
     The "prob" operator expresses constraints on the probability
     of  certain  sequences described using regular formulas. The
     formula below specifies that the probability to send a  mes-
     sage  along  an  unreliable  channel  and receive it finally
     (possibly after a finite number of retries) is at least 90%:

         pppprrrroooobbbb
             SSSSEEEENNNNDDDD .... ((((ttttrrrruuuueeee**** .... RRRREEEETTTTRRRRYYYY))))**** .... RRRREEEECCCCVVVV
         iiiissss
             >>>>==== 0000....9999
         eeeennnndddd pppprrrroooobbbb

     By combining the modalities of PDL and the "prob"  operator,
     one  can  express quantitative response properties. The for-
     mula below specifies that every request to access a resource
     will be granted with probability 1 (i.e., almost surely):



(C) INRIA            Last change: 2019/04/05                    2






CADP MANUAL PAGES                                     MCL5(LOCAL)



         [[[[ ttttrrrruuuueeee**** .... RRRREEEEQQQQUUUUEEEESSSSTTTT ]]]]
             pppprrrroooobbbb
                 ttttrrrruuuueeee**** .... GGGGRRRRAAAANNNNTTTT
             iiiissss
                 >>>>==== 1111
             eeeennnndddd pppprrrroooobbbb


  DDDDAAAATTTTAAAA----HHHHAAAANNNNDDDDLLLLIIIINNNNGGGG PPPPRRRROOOOPPPPEEEERRRRTTTTIIIIEEEESSSS
     MCL enables  the  formulation  of  probabilistic  properties
     involving  data  values, for instance using regular formulas
     with counting.  The formula below,  concerning  the  Bounded
     Retransmission  Protocol  (BRP) [DJJL01,MR18], evaluates the
     probability  that  the  sender   reports   an   unsuccessful
     transmission (action INPUT_NOK) after more than eight chunks
     of the packet have been transmitted (action REC_L):

         pppprrrroooobbbb
             ((((((((nnnnooootttt RRRREEEECCCC____LLLL))))**** .... RRRREEEECCCC____LLLL)))) {{{{ 8888 ............ }}}} ....
             ((((nnnnooootttt ((((RRRREEEECCCC____LLLL oooorrrr IIIINNNNPPPPUUUUTTTT____NNNNOOOOKKKK))))))))**** .... IIIINNNNPPPPUUUUTTTT____NNNNOOOOKKKK
         iiiissss
             >>>>==== ???? 0000
         eeeennnndddd pppprrrroooobbbb

     where the regular subformula "_R  {  8  ...  }"  denotes  the
     repetition  of  _R  at  least  8  times  (see mmmmccccllll4444(LOCAL) for
     details).  This  formula  will  be  evaluated  to  TRUE  and
     eeeevvvvaaaalllluuuuaaaattttoooorrrr5555(LOCAL)  will display the computed probability, as
     required by the "?" clause.

     More complex properties about  transition  sequences  having
     certain cumulated costs can be expressed using data-handling
     action predicates and the general iteration operator  "loop"
     on  regular  formulas.   The  following example deals with a
     mutual exclusion protocol that manages  the  accesses  of  _n
     processes _P_1, ..., _P_n to a shared resource [MS13,MR18].  The
     MCL formula below computes the probability that a process _P_i
     performs memory accesses of a total cost _m_a_x before entering
     its critical section (_P_i and _m_a_x are assumed to  be  defined
     outside  of  the  formula). The regular subformula expresses
     that, after executing its non critical section for the first
     time  (action predicate "{ NCS !i }"), process _P_i begins its
     entry section and, after a number of memory accesses (action
     predicate  "{ MU ... ?c:nat !i }"), enters its critical sec-
     tion (action predicate "{ CS !"ENTER" !i }"):

         pppprrrroooobbbb
             ((((nnnnooootttt {{{{ NNNNCCCCSSSS !!!!iiii }}}}))))**** .... {{{{ NNNNCCCCSSSS !!!!iiii }}}} ....
             lllloooooooopppp ((((ttttoooottttaaaallll____ccccoooosssstttt::::nnnnaaaatttt::::====0000)))) iiiinnnn
                 ((((nnnnooootttt (((({{{{ MMMMUUUU ............ !!!!iiii }}}} oooorrrr {{{{ CCCCSSSS !!!!""""EEEENNNNTTTTEEEERRRR"""" !!!!iiii }}}}))))))))**** ....
                 iiiiffff ttttoooottttaaaallll____ccccoooosssstttt <<<< mmmmaaaaxxxx tttthhhheeeennnn
                     {{{{ MMMMUUUU ............ ????cccc::::nnnnaaaatttt !!!!iiii }}}} ....



(C) INRIA            Last change: 2019/04/05                    3






CADP MANUAL PAGES                                     MCL5(LOCAL)



                     ccccoooonnnnttttiiiinnnnuuuueeee ((((ttttoooottttaaaallll____ccccoooosssstttt ++++ cccc))))
                 eeeellllsssseeee
                     eeeexxxxiiiitttt
                 eeeennnndddd iiiiffff
             eeeennnndddd lllloooooooopppp ....
             {{{{ CCCCSSSS !!!!""""EEEENNNNTTTTEEEERRRR"""" !!!!iiii }}}}
         iiiissss
             >>>>==== ???? 0000
         eeeennnndddd pppprrrroooobbbb

     The "loop" subformula captures the entry section of  _P_i  and
     requires  that  it  terminates  when  the cost of all memory
     accesses performed by _P_i (accumulated in the iteration vari-
     able  _t_o_t_a_l__c_o_s_t)  exceeds  a  given  value  _m_a_x.  The costs
     present on transitions are captured in the _c variable of the
     action  predicate  "{  MU  ...  ?c:nat !i }" and used in the
     "continue" subformula to update  the  value  of  _t_o_t_a_l__c_o_s_t.
     The other processes can execute freely during the entry sec-
     tion of _P_i, in particular they can overtake _P_i by  accessing
     their critical sections before it.


RRRREEEELLLLAAAATTTTIIIIOOOONNNN TTTTOOOO OOOOTTTTHHHHEEEERRRR PPPPRRRROOOOBBBBAAAABBBBIIIILLLLIIIISSSSTTTTIIIICCCC LLLLOOOOGGGGIIIICCCCSSSS
     The "prob" operator of MCL generalizes naturally  the  Until
     operators  of classical probabilistic branching-time logics.
     The Until operator of PCTL (Probabilistic  Computation  Tree
     Logic)  [HJ94] without discrete time can be expressed in MCL
     as follows:

         [[[[ _F_1 UUUU _F_2 ]]]]{{{{>>>>==== _p}}}} ====
             pppprrrroooobbbb
                 ((((HHHHOOOOLLLLDDDDSSSS ((((_F_1)))) .... ttttrrrruuuueeee))))**** .... HHHHOOOOLLLLDDDDSSSS ((((_F_2))))
             iiiissss
                 >>>>==== _p
             eeeennnndddd pppprrrroooobbbb

     where "HOLDS (_F)" is the testing operator of  PDL  (Proposi-
     tional  Dynamic  Logic)  [FL79],  defined by the MCL regular
     formula below:

         HHHHOOOOLLLLDDDDSSSS ((((_F)))) ==== iiiiffff nnnnooootttt ((((_F)))) tttthhhheeeennnn ffffaaaallllsssseeee eeeennnndddd iiiiffff

     Similarly, probabilistic versions of the two Until operators
     of  ACTL (Action-based Computation Tree Logic) [DV90] can be
     defined in MCL as follows:

         [[[[ _F_1{{{{_A_1}}}} UUUU _F_2 ]]]]{{{{>>>>==== _p}}}} ====
             pppprrrroooobbbb
                 ((((HHHHOOOOLLLLDDDDSSSS ((((_F_1)))) .... _A_1))))**** .... HHHHOOOOLLLLDDDDSSSS ((((_F_2))))
             iiiissss
                 >>>>==== _p
             eeeennnndddd pppprrrroooobbbb



(C) INRIA            Last change: 2019/04/05                    4






CADP MANUAL PAGES                                     MCL5(LOCAL)



         [[[[ _F_1{{{{_A_1}}}} UUUU{{{{_A_2}}}} _F_2 ]]]]{{{{>>>>==== _p}}}} ====
             pppprrrroooobbbb
                 ((((HHHHOOOOLLLLDDDDSSSS ((((_F_1)))) .... _A_1))))**** .... HHHHOOOOLLLLDDDDSSSS ((((_F_1)))) .... _A_2 .... HHHHOOOOLLLLDDDDSSSS ((((_F_2))))
             iiiissss
                 >>>>==== _p
             eeeennnndddd pppprrrroooobbbb

     The full Until operator of PCTL, as well as its action-based
     counterparts  derived from ACTL, can be expressed as follows
     (where _t >= 0 is the number of ticks until _F_2 holds):

         [[[[ _F_1 UUUU{{{{<<<<==== _t}}}} _F_2 ]]]]{{{{>>>>==== _p}}}} ====
             pppprrrroooobbbb
                 ((((HHHHOOOOLLLLDDDDSSSS ((((_F_1)))) .... ttttrrrruuuueeee)))) {{{{ 0000 ............ _t }}}} .... HHHHOOOOLLLLDDDDSSSS ((((_F_2))))
             iiiissss
                 >>>>==== _p
             eeeennnndddd pppprrrroooobbbb

         [[[[ _F_1{{{{_A_1}}}} UUUU{{{{<<<<==== _t}}}} _F_2 ]]]]{{{{>>>>==== _p}}}} ====
             pppprrrroooobbbb
                 ((((HHHHOOOOLLLLDDDDSSSS ((((_F_1)))) .... _A_1)))) {{{{ 0000 ............ _t }}}} .... HHHHOOOOLLLLDDDDSSSS ((((_F_2))))
             iiiissss
                 >>>>==== _p
             eeeennnndddd pppprrrroooobbbb

         [[[[ _F_1{{{{_A_1}}}} UUUU{{{{<<<<==== _t}}}}{{{{_A_2}}}} _F_2 ]]]]{{{{>>>>==== _p}}}} ====
             pppprrrroooobbbb
                 ((((HHHHOOOOLLLLDDDDSSSS ((((_F_1)))) .... _A_1)))) {{{{ 0000 ............ _t }}}} ....
                 HHHHOOOOLLLLDDDDSSSS ((((_F_1)))) .... _A_2 .... HHHHOOOOLLLLDDDDSSSS ((((_F_2))))
             iiiissss
                 >>>>==== _p
             eeeennnndddd pppprrrroooobbbb

     where the regular subformula "_R { 0 ... _t }" denotes  inter-
     val  counting,  i.e.,  the  repetition  of _R between 0 and _t
     times (see mmmmccccllll4444(LOCAL) for details).


DDDDEEEETTTTEEEERRRRMMMMIIIINNNNIIIIZZZZAAAATTTTIIIIOOOONNNN OOOOFFFF PPPPRRRROOOOBBBBAAAABBBBIIIILLLLIIIISSSSTTTTIIIICCCC FFFFOOOORRRRMMMMUUUULLLLAAAASSSS
     To ensure that the verification of a "prob" formula on a PTS
     is  translated  correctly  into the resolution of a LES, the
     regular subformula _R must be _d_e_t_e_r_m_i_n_i_s_t_i_c, meaning that  it
     must satisfy two conditions:

     (a)  if _R matches a transition sequence in the PTS, it  can-
          not match also one of its prefixes.

     (b)  if _R matches a transition sequence in the PTS, it  does
          this in a unique manner.

     We illustrate these two conditions by considering  the  fol-
     lowing PTS:



(C) INRIA            Last change: 2019/04/05                    5






CADP MANUAL PAGES                                     MCL5(LOCAL)



                                             ________________________________________________________
                                            ||||              ||||
              AAAA;;;; pppprrrroooobbbb 1111        AAAA;;;; pppprrrroooobbbb 1111    ||||   BBBB;;;; pppprrrroooobbbb 1111  ||||
         ssss0000 ------------------------------------------------>>>> ssss1111 ------------------------------------------------>>>> ssss2222 <<<<------------------------------------------------////

     For condition (a), consider the following formula:

         pppprrrroooobbbb
             ttttrrrruuuueeee**** .... AAAA
         iiiissss
             >>>>==== 0000
         eeeennnndddd pppprrrroooobbbb

     The regular subformula  "true*  .  A"  is  nondeterministic,
     since  it  matches  both the sequence s0--A-->s1--A-->s2 and
     its proper prefix s0--A-->s1.  A  deterministic  version  of
     this regular subformula is "(not A)* . A".

     For condition (b), consider the following formula:

         pppprrrroooobbbb
             AAAA**** .... ((((nnnnooootttt BBBB))))**** .... BBBB
         iiiissss
             >>>>==== 0000
         eeeennnndddd pppprrrroooobbbb

     The regular subformula "A* . (not B)* . B" is nondeterminis-
     tic,  since  it  matches  the  sequence  s0--A-->s1--A-->s2-
     -B-->s2 both as "A* . B" and as "(not B)*  .  B".  A  deter-
     ministic version of this regular subformula is "A* . (not (A
     or B))* . B".

     The eeeevvvvaaaalllluuuuaaaattttoooorrrr5555(LOCAL) model checker  determinizes  automati-
     cally the dataless formulas, and thus the two formulas above
     are correctly handled.  However, the  tool  in  its  current
     version  does  not  determinize  data-handling formulas, but
     only detects the presence of nondeterminism and  signals  it
     by a specific warning message. It is the user's responsibil-
     ity to constrain the regular subformulas of "prob" operators
     so as to remove all warning messages concerning nondetermin-
     ism, and thus to ensure the correctness of verification.

     To illustrate the warning messages  concerning  nondetermin-
     ism, consider the following PTS modeling a simple communica-
     tion protocol:

               RRRRCCCCVVVV;;;; pppprrrroooobbbb 1111
          ////------------------------------------------------------------------------ ssss3333
          ||||                    ^^^^
          ||||                    |||| TTTTRRRRAAAANNNNSSSS;;;; pppprrrroooobbbb 0000....9999
          ||||                    ||||
          vvvv    SSSSNNNNDDDD;;;; pppprrrroooobbbb 1111     ||||   EEEERRRRRRRR;;;; pppprrrroooobbbb 0000....1111



(C) INRIA            Last change: 2019/04/05                    6






CADP MANUAL PAGES                                     MCL5(LOCAL)



         ssss0000 ---------------------------------------------------------------->>>> ssss1111 ---------------------------------------------------------------->>>> ssss2222
                               ^^^^                    ||||
                               ||||                    ||||
                               ||||                    ||||
                               ||||   RRRREEEETTTTRRRRYYYY;;;; pppprrrroooobbbb 1111    ||||
                               \\\\--------------------------------------------------------------------------------////

     and the MCL formula  below,  supposedly  stored  in  a  file
     "p.mcl" (with the line numbers indicated for clarity):

      1111  pppprrrroooobbbb
      2222      SSSSNNNNDDDD ....
      3333      ((((
      4444          ((((nnnnooootttt ((((RRRREEEETTTTRRRRYYYY oooorrrr RRRRCCCCVVVV))))))))**** ....
      5555          RRRREEEETTTTRRRRYYYY
      6666      )))) {{{{ 0000 ............ 2222 }}}} ....
      7777      ((((nnnnooootttt RRRRCCCCVVVV))))**** ....
      8888      RRRRCCCCVVVV
      9999  iiiissss
     11110000      <<<< ???? 0000....9999999999999999
     11111111  eeeennnndddd pppprrrroooobbbb

     This formula expresses that the probability that  a  message
     sent (action SND) is received (action RCV) after at most two
     retries (action RETRY) caused by transmission errors is less
     than 99,99%.  The invocation of eeeevvvvaaaalllluuuuaaaattttoooorrrr5555(LOCAL) for check-
     ing this formula on the PTS  above  produces  the  following
     output:

         wwwwaaaarrrrnnnniiiinnnngggg dddduuuurrrriiiinnnngggg ooooppppttttiiiimmmmiiiissssaaaattttiiiioooonnnn pppphhhhaaaasssseeee::::
             ppppoooossssssssiiiibbbbllllyyyy nnnnoooonnnnddddeeeetttteeeerrrrmmmmiiiinnnniiiissssttttiiiicccc pppprrrroooobbbbaaaabbbbiiiilllliiiissssttttiiiicccc ffffoooorrrrmmmmuuuullllaaaa;;;;
             cccchhhheeeecccckkkk tttthhhhaaaatttt tttthhhheeee ttttwwwwoooo sssseeeeqqqquuuueeeennnncccceeeessss bbbbeeeelllloooowwww ddddoooo nnnnooootttt oooovvvveeeerrrrllllaaaapppp
             ((((aaaannnndddd,,,, iiiiffff nnnneeeeeeeeddddeeeedddd,,,, eeeennnnssssuuuurrrreeee tttthhhhiiiissss bbbbyyyy aaaaddddddddiiiinnnngggg ccccoooonnnnssssttttrrrraaaaiiiinnnnttttssss
             oooonnnn aaaaccccttttiiiioooonnnn ffffoooorrrrmmmmuuuullllaaaassss))))::::

         SSSSNNNNDDDD .... ((((**** [[[[pppp....mmmmccccllll::::2222]]]] ****))))
           nnnnooootttt ((((RRRRCCCCVVVV)))) ((((**** [[[[pppp....mmmmccccllll::::7777]]]] ****))))

         SSSSNNNNDDDD .... ((((**** [[[[pppp....mmmmccccllll::::2222]]]] ****))))
           RRRREEEETTTTRRRRYYYY ((((**** [[[[pppp....mmmmccccllll::::5555]]]] ****))))

         1111....11111111

         FFFFAAAALLLLSSSSEEEE

     The warning message above indicates that the regular subfor-
     mula  can  match  a  transition  sequence  s0--SND--> ... --
     RETRY-->s1 in two different ways, caused by  the  fact  that
     the  action predicates "not (RCV)" and "RETRY" overlap (they
     are both satisfied by the RETRY action).  Indeed,  the  fol-
     lowing transition sequence:




(C) INRIA            Last change: 2019/04/05                    7






CADP MANUAL PAGES                                     MCL5(LOCAL)



         s0--SND-->s1--ERR-->s2--RETRY-->s1--TRANS-->s3--RCV-->s0

     in the PTS is matched by the regular  subformula  either  as
     "SND  . (not RCV)* . RCV" (corresponding to 0 retries) or as
     "SND . (not (RETRY or RCV))* . RETRY .  (not  RCV)*  .  RCV"
     (corresponding to one retry).

     This nondeterminism makes  the  probabilities  labeling  the
     actions  of  this sequence to be counted twice, which yields
     an incorrect value 1.11 of the probability.

     A deterministic version of the formula above is obtained  by
     replacing the subformula "(not RCV)*" by the more constrain-
     ing formula "(not (RETRY  or  RCV))*",  which  reflects  the
     intended meaning of the initial property (i.e., a message is
     received after a number of retries between 0  and  2,  these
     retries  being  captured  by  the  "((not (RETRY or RCV))* .
     RETRY) { 0 ... 2 }" subformula).  This  revised  formula  is
     verified correctly, without any warning message, producing a
     probability value of 0.999 and a verdict TRUE.

     Note:  If a "prob" formula triggers  warning  messages  con-
     cerning  nondeterminism,  it  is  important to eliminate _a_l_l
     these warnings to achieve a  correct  verification.  Indeed,
     even  if  the computed probability is less than 1, the pres-
     ence of such warnings indicates an ambiguity in the formula,
     and  thus  the  risk of having computed a probability higher
     than the real one.


BBBBIIIIBBBBLLLLIIIIOOOOGGGGRRRRAAAAPPPPHHHHYYYY
     [DJJL01]
          P. D'Argenio, B. Jeannet, H.  Jensen,  and  K.  Larsen.
          "Reachability Analysis of Probabilistic Systems by Suc-
          cessive Refinements."  Proceedings of the Joint  Intet-
          national  Workshop on Process Algebra and Probabilistic
          Methods,   Performance   Modeling   and    Verification
          PAPM/PROBMIV'01, LNCS v. 2165, p. 39-56, 2001.


     [DV90]
          R. De Nicola and  F.  W.  Vaandrager.   "Action  versus
          State  based  Logics for Transition Systems."  Proceed-
          ings Ecole de Printemps on  Semantics  of  Concurrency,
          LNCS v. 469, p. 407-419, 1990.


     [EL86]
          E. A. Emerson and C-L. Lei.  "Efficient Model  Checking
          in   Fragments   of   the  Propositional  Mu-Calculus."
          Proceedings of the 1st LICS, p. 267-278, 1986.




(C) INRIA            Last change: 2019/04/05                    8






CADP MANUAL PAGES                                     MCL5(LOCAL)



     [FL79]
          M. J. Fischer and R. E. Ladner.  "Propositional Dynamic
          Logic  of  Regular  Programs."  Journal of Computer and
          System Sciences, no. 18, p. 194-211, 1979.


     [HJ94]
          H. Hansson and B.  Jonsson.   "A  Logic  for  Reasoning
          about Time and Reliability."  Formal Aspects of Comput-
          ing, v. 6, no. 5, p. 512-535, 1994.


     [Koz83]
          D. Kozen.  "Results on the Propositional  Mu-Calculus."
          Theoretical Computer Science, v. 27, p. 333-354, 1983.


     [LS91]
          K. G. Larsen and A. Skou.  "Bisimulation through Proba-
          bilistic Testing."  Information and Computation, v. 94,
          no. 1, p. 1-28, 1991.


     [Mat06]
          R. Mateescu.  "CAESAR_SOLVE: A Generic Library for  On-
          the-Fly Resolution of Alternation-Free Boolean Equation
          Systems."  Springer International Journal  on  Software
          Tools  for  Technology Transfer (STTT), v. 8, no. 1, p.
          37-56, 2006. Full version available as  INRIA  Research
          Report         RR-5948.          Available         from
          http://cadp.inria.fr/publications/Mateescu-06-a.html


     [MR18]
          R. Mateescu  and  J.  I.  Requeno.   "On-the-Fly  Model
          Checking for Extended Action-Based Probabilistic Opera-
          tors."   Springer  International  Journal  on  Software
          Tools  for Technology Transfer (STTT), v. 20, no. 5, p.
          563-587, 2018.


     [MS13]
          R. Mateescu and W. Serwe.  "Model Checking and  Perfor-
          mance Evaluation with CADP Illustrated on Shared-Memory
          Mutual Exclusion Protocols."  Science of Computer  Pro-
          gramming v. 78, no. 7, p. 843-861, 2013.


     [MT08]
          R.  Mateescu  and  D.  Thivolle.   "A  Model   Checking
          Language   for   Concurrent   Value-Passing   Systems."
          Proceedings of  the  15th  International  Symposium  on



(C) INRIA            Last change: 2019/04/05                    9






CADP MANUAL PAGES                                     MCL5(LOCAL)



          Formal  Methods  FM'08, LNCS v. 5014, p. 148-164, 2008.
          Available                                          from
          http://cadp.inria.fr/publications/Mateescu-Thivolle-
          08.html


     [Str82]
          R. S. Streett.  "Propositional Dynamic Logic of Looping
          and  Converse."   Information  and  Control,  v. 54, p.
          121-141, 1982.


SSSSEEEEEEEE AAAALLLLSSSSOOOO
     bbbbccccgggg____sssstttteeeeaaaaddddyyyy(LOCAL),   eeeevvvvaaaalllluuuuaaaattttoooorrrr(LOCAL),    eeeevvvvaaaalllluuuuaaaattttoooorrrr3333(LOCAL),
     eeeevvvvaaaalllluuuuaaaattttoooorrrr4444(LOCAL),       eeeevvvvaaaalllluuuuaaaattttoooorrrr5555(LOCAL),      mmmmccccllll(LOCAL),
     mmmmccccllll3333(LOCAL), mmmmccccllll4444(LOCAL), rrrreeeeggggeeeexxxxpppp(LOCAL)

     Additional information is available from the CADP  Web  page
     located at http://cadp.inria.fr

     Directives   for   installation   are   given    in    files
     $$$$CCCCAAAADDDDPPPP////IIIINNNNSSSSTTTTAAAALLLLLLLLAAAATTTTIIIIOOOONNNN____****.

     Recent  changes  and  improvements  to  this  software   are
     reported and commented in file $$$$CCCCAAAADDDDPPPP////HHHHIIIISSSSTTTTOOOORRRRYYYY.


BBBBUUUUGGGGSSSS
     Please report bugs to Radu.Mateescu@inria.fr


























(C) INRIA            Last change: 2019/04/05                   10



