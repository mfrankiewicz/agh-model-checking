


CADP MANUAL PAGES                                      MCL(LOCAL)



NNNNAAAAMMMMEEEE
     mcl, MCL - Model Checking Language (versions 3, 4, and 5)


DDDDEEEESSSSCCCCRRRRIIIIPPPPTTTTIIIIOOOONNNN
     _M_C_L  (_M_o_d_e_l   _C_h_e_c_k_i_n_g   _L_a_n_g_u_a_g_e)   is   an   action-based,
     branching-time  temporal  logic suitable for expressing pro-
     perties  of  concurrent  systems.   _M_C_L  is  interpreted  on
     Labelled Transition Systems (LTSs).


     Three versions of _M_C_L are currently available:


     -    _M_C_L version 3  (regular  alternation-free  mu-calculus)
          [MS03,  Mat06]  is an extension of the alternation-free
          fragment of the modal mu-calculus  [Koz83,  EL86]  with
          action  predicates  similar to those of _A_C_T_L [DV90] and
          regular expressions over action  sequences  similar  to
          those  of  _P_D_L [FL79].  In the temporal formulas of _M_C_L
          version  3,  the  LTS  actions  are  merely   character
          strings.

          A description of _M_C_L version 3  can  be  found  in  the
          mmmmccccllll3333(LOCAL) manual page.

          _M_C_L version 3 is  supported  by  the  eeeevvvvaaaalllluuuuaaaattttoooorrrr3333(LOCAL)
          on-the-fly model checker.


     -    _M_C_L version 4 (value-passing modal mu-calculus)  [MT08]
          is  an  extension  of  _M_C_L version 3 with data-handling
          constructs (data variables, expressions,  parameterized
          fixed point operators, programming language constructs)
          and an infinite looping operator  similar  to  that  of
          _P_D_L-_d_e_l_t_a [Str82], able to express fairness properties.
          In the temporal formulas of  _M_C_L  version  4,  the  LTS
          actions  are  tuples  containing channel names and data
          values, which can be extracted  and  used  in  calcula-
          tions,   as  originally  proposed  in  the  RICO  logic
          [Gar89].

          A description of _M_C_L version 4  can  be  found  in  the
          mmmmccccllll4444(LOCAL) manual page.

          _M_C_L version 4 is  supported  by  the  eeeevvvvaaaalllluuuuaaaattttoooorrrr4444(LOCAL)
          on-the-fly model checker.


     -    _M_C_L version 5 (probabilistic  value-passing  modal  mu-
          calculus)  [MR18] is an extension of _M_C_L version 4 with
          a probabilistic operator specifying the probability  of



(C) INRIA            Last change: 2019/04/01                    1






CADP MANUAL PAGES                                      MCL(LOCAL)



          transition  sequences described using generalized regu-
          lar formulas.  _M_C_L version 5 is interpreted  on  Proba-
          bilistic  Transition Systems (PTSs) [LS91], whose tran-
          sitions  are  labeled  by  actions  containing  channel
          names, data values, and probabilities.

          A description of _M_C_L version 5  can  be  found  in  the
          mmmmccccllll5555(LOCAL) manual page.

          _M_C_L version 5 is  supported  by  the  eeeevvvvaaaalllluuuuaaaattttoooorrrr5555(LOCAL)
          on-the-fly model checker.


BBBBIIIIBBBBLLLLIIIIOOOOGGGGRRRRAAAAPPPPHHHHYYYY
     [DV90]
          R. De Nicola and  F.  W.  Vaandrager.   "Action  versus
          State  based  Logics for Transition Systems."  Proceed-
          ings Ecole de Printemps on  Semantics  of  Concurrency,
          LNCS v. 469, p. 407-419, 1990.


     [EL86]
          E. A. Emerson and C-L. Lei.  "Efficient Model  Checking
          in   Fragments   of   the  Propositional  Mu-Calculus."
          Proceedings of the 1st LICS, p. 267-278, 1986.


     [FL79]
          M. J. Fischer and R. E. Ladner.  "Propositional Dynamic
          Logic  of  Regular  Programs."  Journal of Computer and
          System Sciences, no. 18, p. 194-211, 1979.


     [Gar89]
          H. Garavel. Chapter 9 of "Compilation  et  verification
          de  programmes  LOTOS."  PhD thesis, Universite Joseph-
          Fourier     Grenoble,     1989.      Available     from
          http://cadp.inria.fr/publications/Garavel-89-b.html


     [Koz83]
          D. Kozen.  "Results on the Propositional  Mu-Calculus."
          Theoretical Computer Science, v. 27, p. 333-354, 1983.


     [LS91]
          K. G. Larsen and A. Skou.  "Bisimulation through Proba-
          bilistic Testing."  Information and Computation, v. 94,
          no. 1, p. 1-28, 1991.


     [MR18]



(C) INRIA            Last change: 2019/04/01                    2






CADP MANUAL PAGES                                      MCL(LOCAL)



          R. Mateescu  and  J.  I.  Requeno.   "On-the-Fly  Model
          Checking for Extended Action-Based Probabilistic Opera-
          tors."   Springer  International  Journal  on  Software
          Tools  for Technology Transfer (STTT), v. 20, no. 5, p.
          563-587, 2018.


     [MS03]
          R. Mateescu and M. Sighireanu.   "Efficient  On-the-Fly
          Model-Checking   for   Regular   Alternation-Free   Mu-
          Calculus."  Science of Computer Programming, v. 46, no.
          3,     p.     255-281,     2003.      Available    from
          http://cadp.inria.fr/publications/Mateescu-Sighireanu-
          03.html


     [MT08]
          R.  Mateescu  and  D.  Thivolle.   "A  Model   Checking
          Language   for   Concurrent   Value-Passing   Systems."
          Proceedings of the 15th International Symposium on For-
          mal  Methods  FM'08,  LNCS  v.  5014, p. 148-164, 2008.
          Available                                          from
          http://cadp.inria.fr/publications/Mateescu-Thivolle-
          08.html


     [Str82]
          R. S. Streett.  "Propositional Dynamic Logic of Looping
          and  Converse."   Information  and  Control,  v. 54, p.
          121-141, 1982.


SSSSEEEEEEEE AAAALLLLSSSSOOOO
     eeeevvvvaaaalllluuuuaaaattttoooorrrr(LOCAL),   eeeevvvvaaaalllluuuuaaaattttoooorrrr3333(LOCAL),    eeeevvvvaaaalllluuuuaaaattttoooorrrr4444(LOCAL),
     mmmmccccllll3333(LOCAL), mmmmccccllll4444(LOCAL), rrrreeeeggggeeeexxxxpppp(LOCAL)

     Additional information is available from the CADP  Web  page
     located at http://cadp.inria.fr

     Directives   for   installation   are   given    in    files
     $$$$CCCCAAAADDDDPPPP////IIIINNNNSSSSTTTTAAAALLLLLLLLAAAATTTTIIIIOOOONNNN____****.

     Recent  changes  and  improvements  to  this  software   are
     reported and commented in file $$$$CCCCAAAADDDDPPPP////HHHHIIIISSSSTTTTOOOORRRRYYYY.


BBBBUUUUGGGGSSSS
     Please report bugs to Radu.Mateescu@inria.fr







(C) INRIA            Last change: 2019/04/01                    3



