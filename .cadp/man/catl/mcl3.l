


CADP MANUAL PAGES                                     MCL3(LOCAL)



NNNNAAAAMMMMEEEE
     mcl, MCL  -  Model  Checking  Language  version  3  (regular
     alternation-free mu-calculus)


DDDDEEEESSSSCCCCRRRRIIIIPPPPTTTTIIIIOOOONNNN
     This manual page presents the version 3 of _M_C_L (_M_o_d_e_l _C_h_e_c_k_-
     _i_n_g _L_a_n_g_u_a_g_e), which is the temporal logic accepted as input
     by eeeevvvvaaaalllluuuuaaaattttoooorrrr3333(LOCAL).


     This temporal logic is also known as  "regular  alternation-
     free   mu-calculus".    A   description   of   the   regular
     alternation-free mu-calculus can be found  in  the  articles
     [MS03]  and  [Mat06],  which  also describe the verification
     methods implemented in versions 3.0 and  3.5  of  EVALUATOR,
     respectively.


     The regular alternation-free mu-calculus is an extension  of
     the  alternation-free  fragment  of  the  modal  mu-calculus
     [Koz83, EL86] with action predicates and regular expressions
     over  action  sequences.  In this setting, action labels are
     merely handled as character strings.


     Note: There exists an extended version of this  logic,  able
     to  express  temporal  properties involving data values; see
     the mmmmccccllll4444(LOCAL) manual page for details. This extended  ver-
     sion   is   supported   by   eeeevvvvaaaalllluuuuaaaattttoooorrrr4444(LOCAL)  but  not  by
     eeeevvvvaaaalllluuuuaaaattttoooorrrr3333(LOCAL).


     Regular alternation-free mu-calculus allows direct encodings
     of  "pure"  branching-time  logics  like _C_T_L [CES86] or _A_C_T_L
     [DV90], as well as of regular  logics  like  _P_D_L  [FL79]  or
     _P_D_L-_d_e_l_t_a  [Str82].   Moreover,  it  has  an efficient model
     checking algorithm, with a  linear-time  complexity  in  the
     size  of  the  formula (number of operators) and the size of
     the LTS model (number of states and transitions).  The logic
     is  built  from  three  types  of formulas, indicated in the
     table below.

                    ++++--------------------------------++++--------------------------------------------------------------------++++
                    |||| SSSSyyyymmmmbbbboooollll ||||   DDDDeeeessssccccrrrriiiippppttttiiiioooonnnn   ||||
                    ++++--------------------------------++++--------------------------------------------------------------------++++
                    ||||   _A    |||| aaaaccccttttiiiioooonnnn ffffoooorrrrmmmmuuuullllaaaa  ||||
                    ||||   _R    |||| rrrreeeegggguuuullllaaaarrrr ffffoooorrrrmmmmuuuullllaaaa ||||
                    ||||   _F    |||| ssssttttaaaatttteeee ffffoooorrrrmmmmuuuullllaaaa   ||||
                    ++++--------------------------------++++--------------------------------------------------------------------++++





(C) INRIA            Last change: 2018/05/29                    1






CADP MANUAL PAGES                                     MCL3(LOCAL)



     The BNF syntax and the informal semantics of these  formulas
     are  defined  below.  In  the  grammar, terminal symbols are
     written between double quotes.  The axiom of the grammar  is
     the FFFF symbol.

     Identifiers are built from letters, digits, and  underscores
     (beginning with a letter or an underscore). Keywords must be
     written in lowercase.  Comments are  enclosed  between  '((((****'
     and  '****))))'.  Nested  comments  are not allowed. eeeevvvvaaaalllluuuuaaaattttoooorrrr3333 is
     case-sensitive.

     The formulas are interpreted over an  LTS  <_S,  _A,  _T,  _s_0>,
     where:   _S  is  the  set  of _s_t_a_t_e_s, _A is the set of _a_c_t_i_o_n_s
     (transition labels), _T is the _t_r_a_n_s_i_t_i_o_n _r_e_l_a_t_i_o_n (a  subset
     of  _S  *  _A * _S), and _s_0 is the _i_n_i_t_i_a_l _s_t_a_t_e.  A transition
     (_s_1, _a, _s_2) of _T, also noted _s_1-_a->_s_2,  indicates  that  the
     program  from which the LTS has been generated can move from
     state _s_1 to state _s_2 by performing action _a.


AAAACCCCTTTTIIIIOOOONNNN FFFFOOOORRRRMMMMUUUULLLLAAAASSSS
     An _a_c_t_i_o_n _f_o_r_m_u_l_a is a  logical  formula  built  from  basic
     action  predicates and boolean connectives, according to the
     grammar below:

     _A    ::::::::====  _s_t_r_i_n_g
           ||||   _r_e_g_e_x_p
           ||||   """"ttttrrrruuuueeee""""
           ||||   """"ffffaaaallllsssseeee""""
           ||||   """"nnnnooootttt"""" _A
           ||||   _A_1 """"oooorrrr"""" _A_2
           ||||   _A_1 """"aaaannnndddd"""" _A_2
           ||||   _A_1 """"iiiimmmmpppplllliiiieeeessss"""" _A_2
           ||||   _A_1 """"eeeeqqqquuuu"""" _A_2

     A _s_t_r_i_n_g is a sequence of zero or more characters,  enclosed
     between  double  quotes  ('""""'), which denotes a label of the
     LTS. A string may contain any character  but  '\\\\nnnn'  (end-of-
     line).   Double  quotes  are  also allowed, if preceded by a
     backslash ('\\\\').  Strings  can  be  concatenated  using  the
     binary operator '####'.

     _s_t_r_i_n_g ::::::::==== """"((((_a_n_y _c_h_a_r _b_u_t _e_n_d-_o_f-_l_i_n_e))))****""""
             |   _s_t_r_i_n_g_1 "#" _s_t_r_i_n_g_2

     A transition label of the LTS satisfies a _s_t_r_i_n_g iff  it  is
     identical  to  the  corresponding character string (obtained
     after concatenation whenever needed).

     A _r_e_g_e_x_p is a UNIX regular expression (see the rrrreeeeggggeeeexxxxpppp(LOCAL)
     manual  page  for  a  detailed  description  of UNIX regular
     expressions), enclosed between single  quotes  (''''''),  which



(C) INRIA            Last change: 2018/05/29                    2






CADP MANUAL PAGES                                     MCL3(LOCAL)



     denotes  a predicate on the labels of the LTS.  Regexp's can
     be concatenated using the binary operator '####'.  Strings  can
     be  concatenated  to regexp's, in which case they are impli-
     citly converted into regexp's.

     _r_e_g_e_x_p ::::::::==== ''''_U_N_I_X__r_e_g_u_l_a_r__e_x_p_r_e_s_s_i_o_n''''
             |   _r_e_g_e_x_p_1 "#" _r_e_g_e_x_p_2
             |   _s_t_r_i_n_g_1 "#" _r_e_g_e_x_p_2
             |   _r_e_g_e_x_p_1 "#" _s_t_r_i_n_g_2

     A label of the LTS satisfies a  _r_e_g_e_x_p  if  it  matches  the
     corresponding  _U_N_I_X__r_e_g_u_l_a_r__e_x_p_r_e_s_s_i_o_n  (obtained after con-
     catenation whenever needed).

     Syntactically, all binary operators on action  formulas  are
     left-associative.  The  "nnnnooootttt"  operator has the highest pre-
     cedence, followed by "aaaannnndddd", followed by  "oooorrrr",  followed  by
     "iiiimmmmpppplllliiiieeeessss", followed by "eeeeqqqquuuu".

     The boolean operators have the usual semantics:  a label  of
     the LTS always satisfies "ttttrrrruuuueeee"; it never satisfies "ffffaaaallllsssseeee";
     it satisfies "nnnnooootttt _A" iff it does not satisfy _A; it satisfies
     "_A_1 oooorrrr _A_2" iff it satisfies _A_1 or it satisfies _A_2; it satis-
     fies "_A_1 aaaannnndddd _A_2" iff it satisfies both _A_1 and _A_2; it  satis-
     fies "_A_1 iiiimmmmpppplllliiiieeeessss _A_2" iff it does not satisfy _A_1 or it satis-
     fies _A_2; it satisfies "_A_1 eeeeqqqquuuu _A_2" iff  either  it  satisfies
     both _A_1 and _A_2, or none of them.


RRRREEEEGGGGUUUULLLLAAAARRRR FFFFOOOORRRRMMMMUUUULLLLAAAASSSS
     A _r_e_g_u_l_a_r _f_o_r_m_u_l_a is a logical  formula  built  from  action
     formulas  and  the traditional regular expression operators,
     according to the grammar below:

     _R ::::::::====  _A
        ||||   """"nnnniiiillll""""
        ||||   _R_1 """"...."""" _R_2
        ||||   _R_1 """"||||"""" _R_2
        ||||   _R """"????""""
        ||||   _R """"****""""
        ||||   _R """"++++""""

     where "nnnniiiillll" is the empty operator, "...." is the  concatenation
     operator,  "||||"  is  the  choice  operator, "????" is the option
     operator, "****" is the transitive and reflexive closure opera-
     tor, and "++++" is the transitive closure operator.

     Syntactically, all binary operators on regular formulas  are
     left-associative.  The  "????", "****", and "++++" operators have the
     highest precedence, followed by "....", followed by "||||".





(C) INRIA            Last change: 2018/05/29                    3






CADP MANUAL PAGES                                     MCL3(LOCAL)



     Note: In early versions of eeeevvvvaaaalllluuuuaaaattttoooorrrr3333(LOCAL), the "||||" opera-
     tor  had a higher precedence than "....".  To ensure that "old"
     MCL version  3  regular  formulas  are  interpreted  by  the
     current version of eeeevvvvaaaalllluuuuaaaattttoooorrrr3333(LOCAL) according to their ori-
     ginal intended meaning, it is recommended to add parentheses
     at  appropriate  places. For example, an "old" MCL version 3
     regular formula "R1 | R2 . R3" should be rewritten as "(R1 |
     R2)  .  R3"  to maintain its original meaning, otherwise the
     current version of eeeevvvvaaaalllluuuuaaaattttoooorrrr3333(LOCAL) would parse it as "R1 |
     (R2 . R3)".

     A regular formula _R denotes a sequence of (consecutive)  LTS
     transitions  such  that  the  word obtained by concatenating
     their labels belongs to the regular language defined by _R.

     The regular  operators  have  the  following  semantics:   a
     sequence  of LTS transitions satisfies _A iff it has the form
     _s_1-_a->_s_2, where the label _a  satisfies  the  formula  _A;  it
     satisfies  "nnnniiiillll" iff it is empty (i.e., it contains no tran-
     sition); it satisfies "_R_1 .... _R_2" iff it is the  concatenation
     of  two  sequences  satisfying  _R_1  and _R_2, respectively; it
     satisfies "_R_1 |||| _R_2" iff it satisfies _R_1 or it satisfies  _R_2;
     it  satisfies "_R ????"  iff it is either empty, or it satisfies
     _R; it satisfies "_R ****" iff it is the concatenation of zero or
     more  sequences  satisfying  _R; it satisfies "_R ++++" iff it is
     the concatenation of one or more sequences satisfying _R.


SSSSTTTTAAAATTTTEEEE FFFFOOOORRRRMMMMUUUULLLLAAAASSSS
     A _s_t_a_t_e _f_o_r_m_u_l_a is a logical  formula  built  from  boolean,
     modal,  and  fixed point operators, according to the grammar
     below:

     _F    ::::::::====  """"ttttrrrruuuueeee""""
           ||||   """"ffffaaaallllsssseeee""""
           ||||   """"nnnnooootttt"""" _F
           ||||   _F_1 """"oooorrrr"""" _F_2
           ||||   _F_1 """"aaaannnndddd"""" _F_2
           ||||   _F_1 """"iiiimmmmpppplllliiiieeeessss"""" _F_2
           ||||   _F_1 """"eeeeqqqquuuu"""" _F_2
           ||||   """"<<<<"""" _R """">>>>"""" _F
           ||||   """"[[[["""" _R """"]]]]"""" _F
           ||||   """"<<<<"""" _R """">>>>"""" """"@@@@""""
           ||||   """"[[[["""" _R """"]]]]"""" """"----||||""""
           ||||   _X
           ||||   """"mmmmuuuu"""" _X """"...."""" _F
           ||||   """"nnnnuuuu"""" _X """"...."""" _F

     where "<<<< _R >>>> _F" and "[[[[ _R ]]]] _F" are the possibility and neces-
     sity  modal  operators,  "<<<<  _R  >>>> @@@@" is the infinite looping
     operator, "[[[[ _R ]]]] ----||||" is the saturation operator, "mmmmuuuu _X ....  _F"
     and  "nnnnuuuu  _X  ....  _F"  are  the minimal and maximal fixed point



(C) INRIA            Last change: 2018/05/29                    4






CADP MANUAL PAGES                                     MCL3(LOCAL)



     operators, and _X is a _p_r_o_p_o_s_i_t_i_o_n_a_l _v_a_r_i_a_b_l_e.

     Syntactically, all binary operators on  state  formulas  are
     left-associative.  The  "nnnnooootttt",  "<<<< >>>>", "[[[[ ]]]]", "mmmmuuuu", and "nnnnuuuu"
     operators have the highest precedence,  followed  by  "aaaannnndddd",
     followed  by "oooorrrr", followed by "iiiimmmmpppplllliiiieeeessss", followed by "eeeeqqqquuuu".
     The fixed point operators act as binders for the variables _X
     in  a  way  similar  to quantifiers in first-order logic. In
     each meaningful "mmmmuuuu _X .... _F" or "nnnnuuuu _X .... _F" formula, _X is  sup-
     posed to have free occurrences inside _F.  State formulas are
     assumed to be _s_y_n_t_a_c_t_i_c_a_l_l_y _m_o_n_o_t_o_n_i_c (i.e., in  each  fixed
     point  formula "mmmmuuuu _X .... _F" or "nnnnuuuu _X .... _F", free occurrences of
     _X in _F may appear only under an  even  number  of  negations
     and/or left-hand sides of implications) and _a_l_t_e_r_n_a_t_i_o_n-_f_r_e_e
     (i.e., without mutually recursive minimal and maximal  fixed
     point variables).

     The boolean operators have the usual semantics:  a state  of
     the LTS always satisfies "ttttrrrruuuueeee"; it never satisfies "ffffaaaallllsssseeee";
     it satisfies "nnnnooootttt _F" iff it does not satisfy _F; it satisfies
     "_F_1 oooorrrr _F_2" iff it satisfies _F_1 or it satisfies _F_2; it satis-
     fies "_F_1 aaaannnndddd _F_2" iff it satisfies both _F_1 and _F_2; it  satis-
     fies "_F_1 iiiimmmmpppplllliiiieeeessss _F_2" iff it does not satisfy _F_1 or it satis-
     fies _F_2; it satisfies "_F_1 eeeeqqqquuuu _F_2" iff  either  it  satisfies
     both _F_1 and _F_2, or none of them.

     The modal operators have the following semantics:   a  state
     of  the  LTS satisfies "<<<< _R >>>> _F" iff there is (at least) one
     transition sequence starting at the state, satisfying _R, and
     leading  to a state satisfying _F; it satisfies "[[[[ _R ]]]] _F" iff
     all transition sequences starting at the state and  satisfy-
     ing _R are leading to states satisfying _F.

     The infinite looping and saturation operators have the  fol-
     lowing  semantics:   a  state of the LTS satisfies "<<<< _R >>>> @@@@"
     iff there is a transition sequence starting at the state and
     consisting  of an infinite concatenation of sequences satis-
     fying _R;  it  satisfies  "[[[[  _R  ]]]]  ----||||"  iff  all  transition
     sequences starting at the state and consisting of a concate-
     nation of sequences satisfying _R are finite.

     The fixed point operators have the following  semantics:   a
     state  satisfies  "mmmmuuuu  _X  .... _F" iff it belongs to the minimal
     solution of the fixed point equation  _X  =  _F  (_X),  and  it
     satisfies  "nnnnuuuu _X .... _F" iff it belongs to the maximal solution
     of the same equation, where  the  propositional  variable  _X
     denotes  a  set  of LTS states.  Intuitively, minimal (resp.
     maximal) fixed point operators allow to characterize  finite
     (resp. infinite) tree-like patterns in the LTS.

     An LTS satisfies a state formula _F iff its initial state  _s_0
     satisfies _F.



(C) INRIA            Last change: 2018/05/29                    5






CADP MANUAL PAGES                                     MCL3(LOCAL)



     Note:
          When writing complex formulas containing many operators
          (especially when mixing regular and boolean operators),
          it is safer to use parenthesis to  enclose  subformulas
          whenever  being  in doubt about the relative priorities
          of the operators. Otherwise, the  tool  may  parse  and
          evaluate  the  formulas  in  a  way  different from the
          user's intentions, leading to  erroneous  results  that
          may be quite difficult to track down.


     Note:
          Not all operators  defined  above  are  primitive  con-
          structs  of  the logic.  The boolean operators "ffffaaaallllsssseeee",
          "aaaannnndddd", "iiiimmmmpppplllliiiieeeessss", and "eeeeqqqquuuu" can be expressed  in  terms
          of  "ttttrrrruuuueeee", "oooorrrr", and "nnnnooootttt" in the usual way.  The dia-
          mond and box modalities are dual:

              [[[[ _R ]]]] _F ==== nnnnooootttt <<<< _R >>>> nnnnooootttt _F

          The same holds for  minimal  and  maximal  fixed  point
          operators:

              nnnnuuuu _X .... _F ==== nnnnooootttt mmmmuuuu _X .... nnnnooootttt _F ((((nnnnooootttt _X))))

          where _F ((((nnnnooootttt _X)))) denotes the syntactic substitution of _X
          by nnnnooootttt _X in _F.

          The saturation operator is the negation of the infinite
          looping operator:

              [[[[ _R ]]]] ----|||| ==== nnnnooootttt <<<< _R >>>> @@@@

          The  modalities  containing  regular  formulas  can  be
          translated  in  terms of boolean operators, fixed point
          operators, and modalities containing only action formu-
          las, by recursively applying the identities below:

              <<<< nnnniiiillll >>>> _F ==== <<<< ffffaaaallllsssseeee**** >>>> _F
              <<<< _R_1 .... _R_2 >>>> _F ==== <<<< _R_1 >>>> <<<< _R_2 >>>> _F
              <<<< _R_1 |||| _R_2 >>>> _F ==== <<<< _R_1 >>>> _F oooorrrr <<<< _R_2 >>>> _F
              <<<< _R???? >>>> _F ==== <<<< nnnniiiillll |||| _R >>>> _F
              <<<< _R**** >>>> _F ==== mmmmuuuu _X .... ((((_F oooorrrr <<<< _R >>>> _X))))
              <<<< _R++++ >>>> _F ==== <<<< _R .... _R**** >>>> _F

          where  _X  is  a  "fresh"  propositional  variable  (the
          corresponding   identities   for   box  modalities  are
          obtained by duality).

          The infinite looping operator is equivalent to the max-
          imal fixed point formula below:




(C) INRIA            Last change: 2018/05/29                    6






CADP MANUAL PAGES                                     MCL3(LOCAL)



              <<<< _R >>>> @@@@ ==== nnnnuuuu _X .... <<<< _R >>>> _X

          where _X is a "fresh" propositional variable.


     Note:
          Early  versions  of  eeeevvvvaaaalllluuuuaaaattttoooorrrr3333(LOCAL)  accepted   only
          alternation-free  formulas, meaning that infinite loop-
          ing operators "<<<< _R >>>> @@@@" were not allowed to contain "****"
          or  "++++"  operators  in  their  regular formulas _R.  The
          current version of  eeeevvvvaaaalllluuuuaaaattttoooorrrr3333(LOCAL)  accepts  regular
          formulas with "****" or "++++" in infinite looping operators,
          which are now able to characterize  complex  cycles  in
          the LTS (e.g., generalized Buchi accepting cycles).  An
          example of formula accepted by the current  version  of
          eeeevvvvaaaalllluuuuaaaattttoooorrrr3333(LOCAL)  but  not expressible in alternation-
          free mu-calculus is the following:

              <<<< ttttrrrruuuueeee**** .... """"AAAA"""" >>>> @@@@

          This formula is equivalent (by applying the  identities
          above) to a fixed point formula of alternation depth 2:

              nnnnuuuu _X .... mmmmuuuu _Y .... ((((<<<< """"AAAA"""" >>>> _X oooorrrr <<<< ttttrrrruuuueeee >>>> _Y))))

          Although the mu-calculus fragment of alternation  depth
          2  has  in general a quadratic-time model checking com-
          plexity in the size of the LTS, the alternation depth 2
          formulas  resulting  from  the  translation of infinite
          looping operators "<<<< _R  >>>>  @@@@"  containing  "****"  or  "++++"
          operators  in  their  regular formulas _R have a linear-
          time model checking complexity in the size of  the  LTS
          [MT08].


     Note:
          Early versions of eeeevvvvaaaalllluuuuaaaattttoooorrrr3333(LOCAL) accepted the syntax
          "@@@@  (((( _R ))))" for the infinite looping operator. This syn-
          tax  is   now   obsolete,   but   still   accepted   by
          eeeevvvvaaaalllluuuuaaaattttoooorrrr3333(LOCAL)  for  backward  compatibility.  It is
          recommended to use the new syntax "<<<< _R >>>> @@@@",  which  is
          closer  to  the  syntax  of  possibility modalities and
          reflects more intuitively the existence of an  infinite
          sequence,  terminated by a loop ("@") in a finite state
          LTS.


     A fixed point formula "mmmmuuuu _X .... _F" or "nnnnuuuu _X .... _F" is  _u_n_g_u_a_r_d_e_d
     [Koz83]  if  _F  contains  at  least one free occurrence of _X
     which is not preceded (not  necessarily  immediately)  by  a
     modality.  The  evaluation of an unguarded formula on an LTS
     may yield a BES with cyclic dependencies  between  variables



(C) INRIA            Last change: 2018/05/29                    7






CADP MANUAL PAGES                                     MCL3(LOCAL)



     even if the LTS is acyclic.

     A state formula containing regular  modalities  with  nested
     star  operators may yield after translation an unguarded mu-
     calculus formula.  For example, in the following formula:

         <<<< _A_1******** .... _A_2 >>>> ttttrrrruuuueeee ====
             mmmmuuuu _X_1 .... ((((<<<< _A_2 >>>> ttttrrrruuuueeee oooorrrr mmmmuuuu _X_2 .... ((((_X_1 oooorrrr <<<< _A_1 >>>> _X_2))))

     the free occurrence of _X_1 is not preceded by  any  modality,
     and hence the formula is unguarded.

     Unguarded occurrences of propositional variables can  always
     be eliminated from a mu-calculus formula, at the price of an
     increase in size [Koz83,Mat02].


EEEEXXXXAAAAMMMMPPPPLLLLEEEESSSS OOOOFFFF TTTTEEEEMMMMPPPPOOOORRRRAAAALLLL PPPPRRRROOOOPPPPEEEERRRRTTTTIIIIEEEESSSS
     The regular alternation-free mu-calculus allows  to  express
     concisely  various  interesting  properties. The most useful
     classes of temporal properties are illustrated below.


  SSSSAAAAFFFFEEEETTTTYYYY PPPPRRRROOOOPPPPEEEERRRRTTTTIIIIEEEESSSS
     Informally, a safety property expresses that "something  bad
     never happens".  Typical safety properties are those forbid-
     ding "bad" execution sequences in the LTS. These  properties
     can  be  naturally expressed using box modalities containing
     regular formulas. For  instance,  mutual  exclusion  can  be
     characterized by the following formula:

         [[[[ ttttrrrruuuueeee**** .... """"OOOOPPPPEEEENNNN !!!!1111"""" .... ((((nnnnooootttt """"CCCCLLLLOOOOSSSSEEEE !!!!1111""""))))**** .... """"OOOOPPPPEEEENNNN !!!!2222"""" ]]]] ffffaaaallllsssseeee

     which states that every time process 1 enters  its  critical
     section  (action "OPEN !1"), it is impossible that process 2
     also enters its critical section (action "OPEN  !2")  before
     process 1 has left its critical section (action "CLOSE !1").

     Other typical safety properties are the _i_n_v_a_r_i_a_n_t_s, express-
     ing  that  every state of the LTS satisfies some "good" pro-
     perty. For example, deadlock freedom can be expressed by the
     formula below:

         [[[[ ttttrrrruuuueeee**** ]]]] <<<< ttttrrrruuuueeee >>>> ttttrrrruuuueeee

     stating that every state has at least one successor.  Alter-
     nately, this formula may be expressed directly using a fixed
     point operator:

         nnnnuuuu _X .... ((((<<<< ttttrrrruuuueeee >>>> ttttrrrruuuueeee aaaannnndddd [[[[ ttttrrrruuuueeee ]]]] _X))))





(C) INRIA            Last change: 2018/05/29                    8






CADP MANUAL PAGES                                     MCL3(LOCAL)



     but less concisely than by using a regular formula.


  LLLLIIIIVVVVEEEENNNNEEEESSSSSSSS PPPPRRRROOOOPPPPEEEERRRRTTTTIIIIEEEESSSS
     Informally, a liveness property  expresses  that  "something
     good  eventually  happens".  Typical liveness properties are
     _p_o_t_e_n_t_i_a_l_i_t_y assertions (i.e., expressing  the  reachability
     on  a sequence) and _i_n_e_v_i_t_a_b_i_l_i_t_y assertions (i.e., express-
     ing the reachability on all sequences).

     Potentiality assertions can be directly expressed using dia-
     mond  modalities containing regular formulas.  For instance,
     the following formula:

         <<<< ttttrrrruuuueeee**** .... """"GGGGEEEETTTT !!!!0000"""" >>>> ttttrrrruuuueeee

     states that there exists a sequence leading to  a  "GET  !0"
     action  after  performing zero or more transitions.  Regular
     formulas allow to express  succinctly  complex  potentiality
     assertions, such as the formula below:

         <<<< ttttrrrruuuueeee**** .... """"SSSSEEEENNNNDDDD"""" .... ((((ttttrrrruuuueeee**** .... """"EEEERRRRRRRROOOORRRR""""))))**** .... ttttrrrruuuueeee**** .... """"RRRREEEECCCCVVVV"""" >>>> ttttrrrruuuueeee

     stating that there exists a sequence leading (after zero  or
     more transitions) to a "SEND" action, possibly followed by a
     sequence of "ERROR" actions  (possibly  separated  by  other
     actions)  and  leading (after zero or more transitions) to a
     "RECV" action.

     Inevitability assertions can be expressed using fixed  point
     operators.  For instance, the following formula:

         mmmmuuuu _X .... ((((<<<< ttttrrrruuuueeee >>>> ttttrrrruuuueeee aaaannnndddd [[[[ nnnnooootttt """"SSSSTTTTAAAARRRRTTTT"""" ]]]] _X))))

     states that all transition sequences starting at the current
     state  lead  to  "START"  actions  after  a finite number of
     steps.


  FFFFAAAAIIIIRRRRNNNNEEEESSSSSSSS PPPPRRRROOOOPPPPEEEERRRRTTTTIIIIEEEESSSS
     These are similar to liveness properties, except  that  they
     express  reachability  of  actions  by considering only _f_a_i_r
     execution sequences. One notion  of  fairness  that  can  be
     easily  encoded  in  the  logic is the "fair reachability of
     predicates"  defined  by  Queille  and  Sifakis  [QS83]:   a
     sequence is fair iff it does not infinitely often enable the
     reachability of a certain  state  without  infinitely  often
     reaching  it.  For instance, the following formula expresses
     that after every message emission (action "SEND"), all  fair
     execution  sequences  will lead to the reception of the mes-
     sage (action "RECV") after a finite number of steps:




(C) INRIA            Last change: 2018/05/29                    9






CADP MANUAL PAGES                                     MCL3(LOCAL)



         [[[[ ttttrrrruuuueeee**** .... """"SSSSEEEENNNNDDDD"""" .... ((((nnnnooootttt """"RRRREEEECCCCVVVV""""))))**** ]]]]
         <<<< ((((nnnnooootttt """"RRRREEEECCCCVVVV""""))))**** .... """"RRRREEEECCCCVVVV"""" >>>> ttttrrrruuuueeee

     Intuitively, the formula above considers the sequences  fol-
     lowing the "SEND" action by "skipping" the cycles of the LTS
     that do not contain "RECV"  actions:  it  states  that  from
     every  state  of  such  a  cycle,  there  is  still a finite
     sequence leading to a "RECV" action.


  AAAACCCCTTTTIIIIOOOONNNN PPPPRRRREEEEDDDDIIIICCCCAAAATTTTEEEESSSS
     The use of action formulas (and, in particular, of regexp's)
     may  be of considerable help when dealing with LOTOS actions
     having the same gate but different values in the offers. For
     instance, the following formula:

         <<<< ttttrrrruuuueeee**** .... ''''SSSSEEEENNNNDDDD !!!!1111....****'''' aaaannnndddd nnnnooootttt ''''SSSSEEEENNNNDDDD !!!!1111....****!!!!2222'''' >>>> ttttrrrruuuueeee

     states the potential reachability of an  action  having  the
     gate  SEND and the value of the first offer equal to 1, pos-
     sibly followed by other offers with values different from 2.
     Moreover,  action formulas combined with modalities allow to
     express invariants over actions (i.e., action formulas  that
     must  be satisfied by all transition labels of the LTS). For
     instance, the following formula:

         [[[[ ttttrrrruuuueeee**** ....
           nnnnooootttt ((((''''RRRREEEECCCCVVVV !!!!....**** !!!!....****'''' aaaannnndddd ''''RRRREEEECCCCVVVV !!!!\\\\((((....****\\\\)))) !!!!\\\\1111''''))))
         ]]]] ffffaaaallllsssseeee

     states that all message receptions  (actions  "RECV  !source
     !dest")  have  different  source and destination fields. The
     UNIX regular expression construct `\\\\(((( \\\\))))' enables to match a
     portion  of  a  string  and  to  re-use it later in the same
     regexp.


     Note:
          For efficiency reasons, when using fixed  point  opera-
          tors,  it  is  recommended to put the recursive call of
          the propositional variable at the  rightmost  place  in
          the  formula  (as  in  all  fixed  point formulas shown
          above). This reduces both the evaluation time  and  the
          size of the diagnostic generated for the formula.


MMMMAAAACCCCRRRROOOOSSSS AAAANNNNDDDD LLLLIIIIBBBBRRRRAAAARRRRIIIIEEEESSSS
     _e_v_a_l_u_a_t_o_r_3 allows to define  and  use  macros  for  temporal
     operators  parameterized  by  action  and/or state formulas.
     This feature is particularly useful for  constructing  reus-
     able  libraries encoding various temporal operators of other
     logics translatable in regular alternation-free  mu-calculus



(C) INRIA            Last change: 2018/05/29                   10






CADP MANUAL PAGES                                     MCL3(LOCAL)



     (like  CTL and ACTL). The _m_a_c_r_o-_d_e_f_i_n_i_t_i_o_n_s have the follow-
     ing syntax:

         """"mmmmaaaaccccrrrroooo"""" _M """"(((("""" _P_1"""",,,,"""" ............"""",,,,"""" _P_n """"))))"""" """"====""""
             <_t_e_x_t>
         """"eeeennnndddd____mmmmaaaaccccrrrroooo""""

     The above construct defines a macro _M having the  parameters
     _P_1,  ...,  _P_n  and  the  body  <_t_e_x_t>,  which is a string of
     alpha-numeric characters (normally)  containing  occurrences
     of  the  parameters  _P_1, ..., _P_n. For example, the following
     macro-definition:

         mmmmaaaaccccrrrroooo EEEEUUUU____AAAA ((((_F_1,,,, _A,,,, _F_2)))) ====
             mmmmuuuu _X .... ((((((((_F_2)))) oooorrrr ((((((((_F_1)))) aaaannnndddd <<<< _A >>>> _X))))))))
         eeeennnndddd____mmmmaaaaccccrrrroooo

     encodes the "Exists Until" operator of  ACTL,  which  states
     that  there  exists  a  sequence of transitions leading to a
     state  satisfying  F2  such  that  all  intermediate  states
     satisfy F1 and all intermediate labels satisfy A.

     The calls of a macro _M have the following form:

         _M """"(((("""" <_t_e_x_t_1>"""",,,,"""" ............"""",,,,"""" <_t_e_x_t_n> """"))))""""

     where the arguments <_t_e_x_t_1>, ..., <_t_e_x_t_n> are  strings.  The
     result  of  the  call  is  the body <text> of the macro _M in
     which all occurrences of the parameters _P_i have been syntac-
     tically  substituted  with  the arguments <_t_e_x_t_i>, for all i
     between 1 and n. For example, the following call:

         EEEEUUUU____AAAA ((((ttttrrrruuuueeee,,,, nnnnooootttt """"SSSSEEEENNNNDDDD"""",,,, <<<< """"RRRREEEECCCCVVVV"""" >>>> ttttrrrruuuueeee))))

     expands into the formula below:

         mmmmuuuu _X .... ((((((((<<<< """"RRRREEEECCCCVVVV"""" >>>> ttttrrrruuuueeee)))) oooorrrr ((((((((ttttrrrruuuueeee)))) aaaannnndddd <<<< nnnnooootttt """"SSSSEEEENNNNDDDD"""" >>>> _X))))))))

     A macro is visible from the point of  its  definition  until
     the  end  of  the  program.  The  macros  may be overloaded:
     several macros with the same name,  but  different  arities,
     may be defined in the same scope.

     Various macro-definitions (typically encoding the  operators
     of some particular temporal logic) can be grouped into files
     called _l_i_b_r_a_r_i_e_s. These files may be included in the  source
     program using the following command:

         """"lllliiiibbbbrrrraaaarrrryyyy""""
             <<<<_f_i_l_e_0....mmmmccccllll>>>>"""",,,,"""" ............"""",,,,"""" <<<<_f_i_l_e_n....mmmmccccllll>>>>
         """"eeeennnndddd____lllliiiibbbbrrrraaaarrrryyyy""""




(C) INRIA            Last change: 2018/05/29                   11






CADP MANUAL PAGES                                     MCL3(LOCAL)



     At the compilation of the program, the  above  construct  is
     syntactically  replaced  with  the  contents  of  the  files
     <_f_i_l_e_0....mmmmccccllll>, ..., <_f_i_l_e_n....mmmmccccllll>, placed one after the other in
     this order. For example, the following command:

         lllliiiibbbbrrrraaaarrrryyyy _a_c_t_l....mmmmccccllll eeeennnndddd____lllliiiibbbbrrrraaaarrrryyyy

     is syntactically replaced  with  the  content  of  the  file
     _a_c_t_l....mmmmccccllll,,,, which implements the ACTL operators.

     The included files are searched first in the current  direc-
     tory,  then  in  the  directory referenced by $CADP/src/xtl.
     Multiple inclusions of the same file are silently discarded.


BBBBIIIIBBBBLLLLIIIIOOOOGGGGRRRRAAAAPPPPHHHHYYYY
     [CES86]
          E.  M.  Clarke,  E.  A.  Emerson,  and  A.  P.  Sistla.
          "Automatic Verification of Finite-State Concurrent Sys-
          tems using Temporal Logic Specifications". ACM Transac-
          tions  on  Programming Languages and Systems, v. 8, no.
          2, p. 244-263, 1986.


     [DV90]
          R. De Nicola and  F.  W.  Vaandrager.   "Action  versus
          State  based  Logics for Transition Systems".  Proceed-
          ings Ecole de Printemps on  Semantics  of  Concurrency,
          LNCS v. 469, p. 407-419, 1990.


     [EL86]
          E. A. Emerson and C-L. Lei.  "Efficient Model  Checking
          in   Fragments   of   the  Propositional  Mu-Calculus".
          Proceedings of the 1st LICS, p. 267-278, 1986.


     [FL79]
          M. J. Fischer and R. E. Ladner.  "Propositional Dynamic
          Logic  of  Regular  Programs".  Journal of Computer and
          System Sciences, no. 18, p. 194-211, 1979.


     [Koz83]
          D. Kozen.  "Results on the Propositional  Mu-Calculus".
          Theoretical Computer Science, v. 27, p. 333-354, 1983.


     [Mat98]
          R. Mateescu.  "Verification des proprietes  temporelles
          des   programmes   paralleles".  PhD  Thesis,  Institut
          National  Polytechnique  de   Grenoble,   April   1998.



(C) INRIA            Last change: 2018/05/29                   12






CADP MANUAL PAGES                                     MCL3(LOCAL)



          Available                                          from
          http://cadp.inria.fr/publications/Mateescu-98-a.html


     [Mat02]
          R.  Mateescu.   "Local  Model-Checking  of  Modal   Mu-
          Calculus   on   Acyclic  Labeled  Transition  Systems".
          Proceedings of TACAS'02,  LNCS  v.  2280,  p.  281-295,
          2002.   Full version available as INRIA Research Report
          RR-4430.                 Available                 from
          http://cadp.inria.fr/publications/Mateescu-02.html


     [Mat06]
          R. Mateescu.  "CAESAR_SOLVE: A Generic Library for  On-
          the-Fly Resolution of Alternation-Free Boolean Equation
          Systems".  Springer International Journal  on  Software
          Tools  for  Technology Transfer (STTT), v. 8, no. 1, p.
          37-56, 2006. Full version available as  INRIA  Research
          Report         RR-5948.          Available         from
          http://cadp.inria.fr/publications/Mateescu-06-a.html


     [MS03]
          R. Mateescu and M. Sighireanu.   "Efficient  On-the-Fly
          Model-Checking   for   Regular   Alternation-Free   Mu-
          Calculus".  Science of Computer Programming, v. 46, no.
          3,     p.     255-281,     2003.      Available    from
          http://cadp.inria.fr/publications/Mateescu-Sighireanu-
          03.html


     [MT08]
          R.  Mateescu  and  D.  Thivolle.   "A  Model   Checking
          Language   for   Concurrent   Value-Passing   Systems".
          Proceedings of the 15th International Symposium on For-
          mal  Methods  FM'08,  LNCS  v.  5014, p. 148-164, 2008.
          Available                                          from
          http://cadp.inria.fr/publications/Mateescu-Thivolle-
          08.html


     [QS83]
          J-P. Queille and J.  Sifakis.   "Fairness  and  Related
          Properties  in Transition Systems - A Temporal Logic to
          Deal with Fairness".  Acta Informatica, v. 19, p.  195-
          220, 1983.


     [Str82]
          R. S. Streett.  "Propositional Dynamic Logic of Looping
          and  Converse".   Information  and  Control,  v. 54, p.



(C) INRIA            Last change: 2018/05/29                   13






CADP MANUAL PAGES                                     MCL3(LOCAL)



          121-141, 1982.


SSSSEEEEEEEE AAAALLLLSSSSOOOO
     eeeevvvvaaaalllluuuuaaaattttoooorrrr(LOCAL),   eeeevvvvaaaalllluuuuaaaattttoooorrrr3333(LOCAL),    eeeevvvvaaaalllluuuuaaaattttoooorrrr4444(LOCAL),
     mmmmccccllll(LOCAL), mmmmccccllll4444(LOCAL), rrrreeeeggggeeeexxxxpppp(LOCAL)

     Additional information is available from the CADP  Web  page
     located at http://cadp.inria.fr

     Directives   for   installation   are   given    in    files
     $$$$CCCCAAAADDDDPPPP////IIIINNNNSSSSTTTTAAAALLLLLLLLAAAATTTTIIIIOOOONNNN____****.

     Recent  changes  and  improvements  to  this  software   are
     reported and commented in file $$$$CCCCAAAADDDDPPPP////HHHHIIIISSSSTTTTOOOORRRRYYYY.


BBBBUUUUGGGGSSSS
     Please report bugs to Radu.Mateescu@inria.fr




































(C) INRIA            Last change: 2018/05/29                   14



