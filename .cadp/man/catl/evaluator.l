


CADP MANUAL PAGES                                EVALUATOR(LOCAL)



NNNNAAAAMMMMEEEE
     evaluator - a family of on-the-fly model checkers


DDDDEEEESSSSCCCCRRRRIIIIPPPPTTTTIIIIOOOONNNN
     eeeevvvvaaaalllluuuuaaaattttoooorrrr denotes a family of on-the-fly model  checkers  of
     CADP  based  on  the  modal mu-calculus. These tools take as
     inputs a Labelled Transition System  (LTS)  and  a  temporal
     logic  formula,  and  produce as output a verdict indicating
     whether the LTS satisfies the  formula  or  not,  optionally
     accompanied by a diagnostic (fragment of the LTS) illustrat-
     ing the verdict.


     On the theoretical side, these model checkers  rely  on  the
     resolution  of Boolean Equation Systems (BES), Parameterized
     Boolean Equation Systems (PBES), and Linear Equation Systems
     (LES).   On  the  practical side, they are implemented using
     the OPEN/CAESAR framework of CADP for  on-the-fly  verifica-
     tion.


     Three versions of eeeevvvvaaaalllluuuuaaaattttoooorrrr are currently available:


     -    eeeevvvvaaaalllluuuuaaaattttoooorrrr3333 ((((sssseeeeeeee tttthhhheeee eeeevvvvaaaalllluuuuaaaattttoooorrrr3333(LOCAL) manual  page)  is
          an  on-the-fly  model  checker  for  _M_C_L  version 3, an
          extension  of  the  alternation-free  mu-calculus  with
          action  predicates  and regular expressions over action
          sequences. In the temporal formulas of _M_C_L  version  3,
          LTS  actions  are  merely  character  strings.  See the
          mmmmccccllll3333(LOCAL) manual page for details.



     -    eeeevvvvaaaalllluuuuaaaattttoooorrrr4444 ((((sssseeeeeeee tttthhhheeee eeeevvvvaaaalllluuuuaaaattttoooorrrr4444(LOCAL) manual  page)  is
          an  on-the-fly  model  checker  for  _M_C_L  version 4, an
          extension of _M_C_L  version  3  with  data-handling  con-
          structs  (data  variables,  expressions,  parameterized
          fixed point operators, programming language constructs)
          and  an infinite looping operator able to express fair-
          ness properties. In the temporal formulas of  _M_C_L  ver-
          sion 4, LTS actions are tuples containing channel names
          and data values, which can be  extracted  and  used  in
          calculations.  See  the  mmmmccccllll4444(LOCAL)  manual  page  for
          details.


     -    eeeevvvvaaaalllluuuuaaaattttoooorrrr5555 ((((sssseeeeeeee tttthhhheeee eeeevvvvaaaalllluuuuaaaattttoooorrrr5555(LOCAL) manual  page)  is
          an  on-the-fly  model  checker  for  _M_C_L  version 5, an
          extension of _M_C_L version 4 with a probabilistic  opera-
          tor  specifying the probability of transition sequences



(C) INRIA            Last change: 2019/04/10                    1






CADP MANUAL PAGES                                EVALUATOR(LOCAL)



          characterized by  generalized  regular  formulas.  This
          probabilistic  operator is interpreted on Probabilistic
          Transition Systems (PTSs), which are LTSs whose actions
          contain  channel names, data values, and probabilities.
          See the mmmmccccllll5555(LOCAL) manual page for details.


     Note: Currently, for backward compatibility reasons, eeeevvvvaaaalllluuuuaaaa----
     ttttoooorrrr  (located in $$$$CCCCAAAADDDDPPPP////bbbbiiiinnnn....****////eeeevvvvaaaalllluuuuaaaattttoooorrrr....aaaa) is a shorthand for
     eeeevvvvaaaalllluuuuaaaattttoooorrrr3333 (located in $$$$CCCCAAAADDDDPPPP////bbbbiiiinnnn....****////eeeevvvvaaaalllluuuuaaaattttoooorrrr3333....aaaa).


HHHHIIIISSSSTTTTOOOORRRRYYYY AAAANNNNDDDD AAAAUUUUTTTTHHHHOOOORRRRSSSS
     Versions 1.x and 2.x of EVALUATOR were developed  by  Marius
     Dorel  Bozga  (IMAG)  and  used an on-the-fly BES resolution
     algorithm proposed by J-C. Fernandez and L.  Mounier.  These
     versions,  which  accepted  as  input alternation-free modal
     mu-calculus (without regular  expressions),  are  no  longer
     available.

     Version 3.0 of EVALUATOR was developed by Radu Mateescu  and
     Mihaela  Sighireanu  (both  at  INRIA/VASY)  and used a com-
     pletely new on-the-fly  BES  resolution  algorithm.   Hubert
     Garavel  (INRIA/VASY)  suggested  the  enhancement of action
     formulas with the string concatenation operator,  which  was
     implemented by David Champelovier (INRIA/VASY).

     Versions 3.5 and 3.6 of EVALUATOR replaced the dedicated BES
     resolution  algorithm  by the more general algorithms avail-
     able in the ccccaaaaeeeessssaaaarrrr____ssssoooollllvvvveeee____1111(LOCAL) library of OPEN/CAESAR for
     on-the-fly  BES  resolution.  All of this was implemented by
     Radu Mateescu (INRIA/VASY).

     Version 4.0 of  EVALUATOR  handles  version  4  of  the  _M_C_L
     language.   It  was  implemented by Radu Mateescu and Damien
     Thivolle (both at INRIA/VASY).

     Version 5.0 of  EVALUATOR  handles  version  5  of  the  _M_C_L
     language.     It    was   implemented   by   Radu   Mateescu
     (INRIA/CONVECS).


SSSSEEEEEEEE AAAALLLLSSSSOOOO
     eeeevvvvaaaalllluuuuaaaattttoooorrrr3333(LOCAL),   eeeevvvvaaaalllluuuuaaaattttoooorrrr4444(LOCAL),   eeeevvvvaaaalllluuuuaaaattttoooorrrr5555(LOCAL),
     mmmmccccllll(LOCAL), mmmmccccllll3333(LOCAL), mmmmccccllll4444(LOCAL), mmmmccccllll5555(LOCAL)

     Additional information is available from the CADP  Web  page
     located at http://cadp.inria.fr

     Directives   for   installation   are   given    in    files
     $$$$CCCCAAAADDDDPPPP////IIIINNNNSSSSTTTTAAAALLLLLLLLAAAATTTTIIIIOOOONNNN____****.




(C) INRIA            Last change: 2019/04/10                    2






CADP MANUAL PAGES                                EVALUATOR(LOCAL)



     Recent  changes  and  improvements  to  this  software   are
     reported and commented in file $$$$CCCCAAAADDDDPPPP////HHHHIIIISSSSTTTTOOOORRRRYYYY.


BBBBUUUUGGGGSSSS
     Please report bugs to Radu.Mateescu@inria.fr

















































(C) INRIA            Last change: 2019/04/10                    3



