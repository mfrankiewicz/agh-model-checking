


CADP MANUAL PAGES                               EVALUATOR4(LOCAL)



NNNNAAAAMMMMEEEE
     evaluator4 - on-the-fly model checking of MCL v4 formulas


SSSSYYYYNNNNOOOOPPPPSSSSIIIISSSS
     bbbbccccgggg____ooooppppeeeennnn   [_b_c_g__o_p_t]    _s_p_e_c[....bbbbccccgggg]    [_c_c__o_p_t]    eeeevvvvaaaalllluuuuaaaattttoooorrrr4444
     [_e_v_a_l_u_a_t_o_r__o_p_t] _p_r_o_p[....mmmmccccllll]

     or:

     eeeexxxxpppp....ooooppppeeeennnn  _s_p_e_c[....eeeexxxxpppp]  [_c_c__o_p_t]  eeeevvvvaaaalllluuuuaaaattttoooorrrr4444   [_e_v_a_l_u_a_t_o_r__o_p_t]
     _p_r_o_p[....mmmmccccllll]

     or:

     ffffsssspppp....ooooppppeeeennnn   [_f_s_p__o_p_t]    _s_p_e_c[....llllttttssss]    [_c_c__o_p_t]    eeeevvvvaaaalllluuuuaaaattttoooorrrr4444
     [_e_v_a_l_u_a_t_o_r__o_p_t] _p_r_o_p[....mmmmccccllll]

     or:

     llllnnnntttt....ooooppppeeeennnn   [_l_n_t__o_p_t]    _s_p_e_c[....llllnnnntttt]    [_c_c__o_p_t]    eeeevvvvaaaalllluuuuaaaattttoooorrrr4444
     [_e_v_a_l_u_a_t_o_r__o_p_t] _p_r_o_p[....mmmmccccllll]

     or:

     lllloooottttoooossss....ooooppppeeeennnn  [_l_o_t_o_s__o_p_t]  _s_p_e_c[....lllloooottttoooossss]  [_c_c__o_p_t]   eeeevvvvaaaalllluuuuaaaattttoooorrrr4444
     [_e_v_a_l_u_a_t_o_r__o_p_t] _p_r_o_p[....mmmmccccllll]

     or:

     sssseeeeqqqq....ooooppppeeeennnn  _s_p_e_c[....sssseeeeqqqq]  [_c_c__o_p_t]  eeeevvvvaaaalllluuuuaaaattttoooorrrr4444   [_e_v_a_l_u_a_t_o_r__o_p_t]
     _p_r_o_p[....mmmmccccllll]


DDDDEEEESSSSCCCCRRRRIIIIPPPPTTTTIIIIOOOONNNN
     eeeevvvvaaaalllluuuuaaaattttoooorrrr4444 takes two inputs:


     -    A Labelled Transition System, expressed either as a BCG
          graph  _s_p_e_c....bbbbccccgggg,,,,  a composition expression _s_p_e_c....eeeexxxxpppp,,,, an
          FSP program _s_p_e_c....llllttttssss,,,, an LNT program _s_p_e_c....llllnnnntttt,,,, a  LOTOS
          program _s_p_e_c....lllloooottttoooossss,,,, or a sequence file _s_p_e_c....sssseeeeqqqq....


     -    A  temporal  logic  property,  contained  in  the  file
          _p_r_o_p[....mmmmccccllll], expressed as a formula in the _M_C_L version 4
          language. See the mmmmccccllll(LOCAL) manual page for a complete
          definition of the _M_C_L version 4 language.

     eeeevvvvaaaalllluuuuaaaattttoooorrrr4444 performs an on-the-fly verification of  the  tem-
     poral  property on the given Labelled Transition System (LTS
     for short).  The result of this verification (TRUE or FALSE)



(C) INRIA            Last change: 2020/02/12                    1






CADP MANUAL PAGES                               EVALUATOR4(LOCAL)



     is  displayed,  possibly  accompanied  by  a diagnostic (see
     OPTIONS below).

     The verification method underlying eeeevvvvaaaalllluuuuaaaattttoooorrrr4444 is based  upon
     a translation of the model checking problem into the resolu-
     tion of  a  Parameterized  Boolean  Equation  System  (PBES)
     [Mat98a], which is carried out by combining two simultaneous
     on-the-fly activities:

     -    Instantiation of the PBES  to  yield  a  plain  Boolean
          Equation  System  (BES), using the approach proposed in
          [Mat98b].


     -    Resolution of the resulting BES, using  the  algorithms
          provided   by   the  ccccaaaaeeeessssaaaarrrr____ssssoooollllvvvveeee____1111(LOCAL)  library  of
          OPEN/CAESAR (see the corresponding manual page and  the
          article [Mat06] for details).


OOOOPPPPTTTTIIIIOOOONNNNSSSS
     The options _b_c_g__o_p_t, if any, are passed to bbbbccccgggg____lllliiiibbbb(LOCAL).

     The options _e_x_p__o_p_t, if any, are passed to eeeexxxxpppp....ooooppppeeeennnn(LOCAL).

     The options _f_s_p__o_p_t, if any, are passed to ffffsssspppp....ooooppppeeeennnn(LOCAL).

     The options _l_n_t__o_p_t, if any, are passed to llllnnnntttt....ooooppppeeeennnn(LOCAL).

     The options _l_o_t_o_s__o_p_t, if any, are passed  to  ccccaaaaeeeessssaaaarrrr(LOCAL)
     and to ccccaaaaeeeessssaaaarrrr....aaaaddddtttt(LOCAL).

     The options _s_e_q__o_p_t, if any, are passed to sssseeeeqqqq....ooooppppeeeennnn(LOCAL).

     The options _c_c__o_p_t, if any, are passed to the C compiler.

     The following options _e_v_a_l_u_a_t_o_r__o_p_t are currently available:


     ----bbbbeeeessss [ _f_i_l_e[....bbbbeeeessss[._e_x_t]] ]
          Print in _f_i_l_e[....bbbbeeeessss] or, if the file  name  argument  is
          missing,  in  file eeeevvvvaaaalllluuuuaaaattttoooorrrr....bbbbeeeessss, a textual description
          of the BES corresponding to the evaluation of the  for-
          mula  on  the LTS.  If present, the extension ._e_x_t must
          correspond to a known file  compression  format  (e.g.,
          ._Z,  ._g_z, ._b_z_2, etc.).  In this case, the file contain-
          ing the BES is compressed according to the  correspond-
          ing format.  The list of currently supported extensions
          and   compression   formats    is    given    by    the
          $$$$CCCCAAAADDDDPPPP////ssssrrrrcccc////ccccoooommmm////ccccaaaaddddpppp____zzzziiiipppp  shell-script.  This option does
          not influence the evaluation of  the  formula.   Not  a
          default option.



(C) INRIA            Last change: 2020/02/12                    2






CADP MANUAL PAGES                               EVALUATOR4(LOCAL)



     -bbbblllloooocccckkkk
          Assume that the property is specified as  a  system  of
          modal equations in a file _f_i_l_e[....bbbbllllkkkk] that must be given
          as argument to eeeevvvvaaaalllluuuuaaaattttoooorrrr4444 instead of  _p_r_o_p[....mmmmccccllll].  This
          option  is  mainly intended for debugging purposes. The
          format of the input file is undocumented and subject to
          future changes. Not a default option.


     -aaaaccccyyyycccclllliiiicccc
          Evaluate the formula on  the  LTS  using  an  algorithm
          optimized  for  acyclic  graphs.   If  option  ----ddddffffssss  is
          present (which is the case by default), the tool checks
          during verification whether the LTS contains cycles; if
          this is the case, an error message is displayed and the
          execution  is  aborted.  If option ----bbbbffffssss is present, the
          tool may not always detect the presence  of  cycles  in
          the  LTS,  and  hence it may enter an infinite loop; in
          this case, it is the user's  responsibility  to  ensure
          that  the  LTS is acyclic.  If the formula is unguarded
          (see Section REMARKS of the  mmmmccccllll(LOCAL)  manual  page),
          which  may yield a BES with cyclic dependencies between
          variables even if the LTS is acyclic, an error  message
          is  displayed  and  the  execution  is  aborted.  Not a
          default option.


     -bbbbffffssss Evaluate the formula on the LTS using  a  breadth-first
          search  algorithm.   Compared  to  ----ddddffffssss, this option is
          generally slower, but produces diagnostics  of  smaller
          depth.   If  option  ----aaaaccccyyyycccclllliiiicccc  is present, the breadth-
          first search algorithm is optimized for reducing memory
          consumption:  in  particular,  if the LTS is a sequence
          and the formula is dataless, the memory used for verif-
          ication  is  bounded by the size of the formula (number
          of operators) and independent  of  the  length  of  the
          sequence   (number  of  transitions).   Not  a  default
          option.


     -ddddffffssss Evaluate the formula on the  LTS  using  a  depth-first
          search  algorithm.   Compared to ----bbbbffffssss, this option pro-
          duces diagnostics of greater depth,  but  is  generally
          faster  and consumes less memory for certain classes of
          formulas (such as those shown in EXAMPLES  OF  TEMPORAL
          PROPERTIES below).  Default option.


     ----ddddiiiiaaaagggg [ _d_i_a_g[....bbbbccccgggg] ]
          Generate a diagnostic in BCG format (see the bbbbccccgggg(LOCAL)
          manual  page for details) explaining the truth value of
          the formula. The diagnostic is generated  in  the  file



(C) INRIA            Last change: 2020/02/12                    3






CADP MANUAL PAGES                               EVALUATOR4(LOCAL)



          _d_i_a_g[....bbbbccccgggg] or, if the file name argument is missing, in
          the file eeeevvvvaaaalllluuuuaaaattttoooorrrr....bbbbccccgggg.  The BCG files containing diag-
          nostics can be visualized using the bbbbccccgggg____ddddrrrraaaawwww(LOCAL) and
          bbbbccccgggg____eeeeddddiiiitttt(LOCAL)  tools  of  CADP  (see  the  respective
          manual  pages  for  details).  Diagnostics are (usually
          small) portions of the LTS on which the formula  yields
          the  same  result  as when it is evaluated on the whole
          LTS.  If the diagnostic is a sequence  of  LTS  transi-
          tions,  it  will also be displayed using the SEQ format
          (see the sssseeeeqqqq(LOCAL) manual page for the  definition  of
          this format). Not a default option.


     -ddddeeeeppppeeeennnndddd
          Display the list of library files included (directly or
          transitively)  in  the  file  _p_r_o_p[....mmmmccccllll] and stop. This
          list may be incomplete if the _M_C_L formula is  syntacti-
          cally incorrect. If present, this option has precedence
          over all the other options. Not a default option.


     -eeeexxxxppppaaaannnndddd
          Expand the  macro  definitions  and  the  source  files
          included as libraries in the file _p_r_o_p[....mmmmccccllll], producing
          as output a file _p_r_o_p....xxxxmmmm, and stop. This option is use-
          ful for debugging purposes. Not a default option.


     ----hhhhiiiiddddeeee [[[[ ----ttttoooottttaaaallll |||| ----ppppaaaarrrrttttiiiiaaaallll |||| ----ggggaaaatttteeee ]]]] _h_i_d_i_n_g__f_i_l_e_n_a_m_e
          Use the hiding rules defined in _h_i_d_i_n_g__f_i_l_e_n_a_m_e to hide
          (on-the-fly)    the    labels    of   _s_p_e_c.   See   the
          ccccaaaaeeeessssaaaarrrr____hhhhiiiiddddeeee____1111(LOCAL)  manual  page   for   a   detailed
          description    of    the    appropriate    format   for
          _h_i_d_i_n_g__f_i_l_e_n_a_m_e.

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



(C) INRIA            Last change: 2020/02/12                    4






CADP MANUAL PAGES                               EVALUATOR4(LOCAL)



          semantics, respectively. See the ccccaaaaeeeessssaaaarrrr____rrrreeeennnnaaaammmmeeee____1111(LOCAL)
          manual page for more  details  about  these  semantics.
          Option ----ttttoooottttaaaallll is the default.

          As  for  the  bbbbccccgggg____llllaaaabbbbeeeellllssss(LOCAL)  tool,  several  hiding
          and/or  renaming  options can be present on the command
          line, in which case they are  processed  from  left  to
          right.

          The hiding and renaming options are useful for convert-
          ing  the  transition labels of _s_p_e_c on-the-fly in order
          to make them compatible with the LTS model on which _M_C_L
          formulas  are  interpreted (see Section OVERVIEW OF THE
          MCL LANGUAGE of the mmmmccccllll(LOCAL) manual page).


     -llllaaaabbbbeeeellllssss
          Display a list of UNIX  regular  expressions  (see  the
          rrrreeeeggggeeeexxxxpppp(LOCAL) manual page for a detailed description of
          UNIX regular expressions), which  over-approximate  the
          set of visible LTS actions (transition labels) satisfy-
          ing the action predicates occurring in the formula.  In
          other  words,  if  an  action  _a  satisfies some action
          predicate, then there exists a regular expression among
          those  displayed by this option such that _a matches it.
          Each regular expression is written on a  separate  line
          and  is enclosed between double quotes, thus being com-
          patible with the format of labels in hiding and  renam-
          ing    files    (see    the   ccccaaaaeeeessssaaaarrrr____hhhhiiiiddddeeee____1111(LOCAL)   or
          ccccaaaaeeeessssaaaarrrr____rrrreeeennnnaaaammmmeeee____1111(LOCAL) manual pages for  a  description
          of these files).

          The formula is not evaluated on _s_p_e_c.   Not  a  default
          option.


     -ssssiiiilllleeeennnntttt
          Execute silently. Opposite of ----vvvveeeerrrrbbbboooosssseeee. Default option.


     ----ssssoooouuuurrrrcccceeee _f_i_l_e:_l_i_n_e
          Change the file name and line number displayed in error
          messages  as  if the formula was contained in file _f_i_l_e
          starting at line _l_i_n_e (instead of starting at line 1 in
          file  _p_r_o_p[....mmmmccccllll]).   This option has effect only on the
          messages triggered by the errors occurring in the  top-
          level  file  _p_r_o_p[....mmmmccccllll].  The messages triggered by the
          errors occurring in the included libraries (if any) are
          left unchanged.


     -ssssttttaaaatttt



(C) INRIA            Last change: 2020/02/12                    5






CADP MANUAL PAGES                               EVALUATOR4(LOCAL)



          Display statistical information about the resolution of
          the  BES corresponding to the evaluation of the formula
          on the LTS.  Not a default option.


     -ttttaaaauuuuccccoooonnnnfffflllluuuueeeennnncccceeee
          Reduce the LTS on the fly modulo tau-confluence (a form
          of  partial  order  reduction  that preserves branching
          equivalence) while evaluating the formula. This  option
          can be safely used only for verifying formulas adequate
          w.r.t. branching equivalence,  i.e.,  whose  evaluation
          yields  the  same  result  on  all branching equivalent
          LTSs. For example, formulas belonging to  the  fragment
          ACTL-X (i.e., ACTL without the next time operators) are
          adequate w.r.t. branching equivalence [DV90].  In  some
          cases,  this  option  may improve speed and memory con-
          sumption significantly.  Not a default option.


     -vvvveeeerrrrbbbboooosssseeee
          Animate the user's screen, telling what  is  going  on.
          Opposite of ----ssssiiiilllleeeennnntttt. Default option is ----ssssiiiilllleeeennnntttt.


     -vvvveeeerrrrssssiiiioooonnnn
          Display the current version  number  of  the  tool  and
          stop.  To be effective, this option should occur as the
          first argument in the _e_v_a_l_u_a_t_o_r__o_p_t section of the com-
          mand  line.   Subsequent  options  and/or arguments, if
          any, will be discarded.  Not a default option.


     -wwwwaaaarrrrnnnniiiinnnngggg
          Suppress all warning diagnostics, at the risk of  leav-
          ing  actual issues in the _M_C_L formula undetected. Not a
          default option.


EEEEXXXXIIIITTTT SSSSTTTTAAAATTTTUUUUSSSS
     Exit status is 0 if everything is alright, 1 otherwise.


DDDDIIIIAAAAGGGGNNNNOOOOSSSSTTTTIIIICCCCSSSS
     When the source file _p_r_o_p[....mmmmccccllll] is erroneous, error messages
     are issued.


BBBBIIIIBBBBLLLLIIIIOOOOGGGGRRRRAAAAPPPPHHHHYYYY
     [DV90]
          R. De Nicola and  F.  W.  Vaandrager.   "Action  versus
          State  based  Logics for Transition Systems."  Proceed-
          ings Ecole de Printemps on  Semantics  of  Concurrency,



(C) INRIA            Last change: 2020/02/12                    6






CADP MANUAL PAGES                               EVALUATOR4(LOCAL)



          LNCS v. 469, p. 407-419, 1990.


     [Mat98a]
          R. Mateescu.  "Verification des proprietes  temporelles
          des   programmes   paralleles."  PhD  Thesis,  Institut
          National Polytechnique de Grenoble, April 1998.  Avail-
          able  from  http://cadp.inria.fr/publications/Mateescu-
          98-a.html


     [Mat98b]
          R. Mateescu.  "Local Model-Checking of an  Alternation-
          Free  Value-Based  Modal  Mu-Calculus."  Proceedings of
          the 2nd International Workshop on  Verification,  Model
          Checking  and  Abstract  Interpretation VMCAI'98, 1998.
          Available                                          from
          http://cadp.inria.fr/publications/Mateescu-98-b.html


     [Mat06]
          R. Mateescu.  "CAESAR_SOLVE: A Generic Library for  On-
          the-Fly Resolution of Alternation-Free Boolean Equation
          Systems."  Springer International Journal  on  Software
          Tools  for  Technology Transfer (STTT), v. 8, no. 1, p.
          37-56, 2006. Full version available as  INRIA  Research
          Report         RR-5948.          Available         from
          http://cadp.inria.fr/publications/Mateescu-06-a.html


AAAAUUUUTTTTHHHHOOOORRRRSSSS
     See the AUTHORS section of the eeeevvvvaaaalllluuuuaaaattttoooorrrr(LOCAL) manual page.


OOOOPPPPEEEERRRRAAAANNNNDDDDSSSS
     _s_p_e_c....bbbbccccgggg            BCG graph (input)
     _s_p_e_c....eeeexxxxpppp            network of communicating LTSs (input)
     _s_p_e_c....llllttttssss            FSP specification (input)
     _s_p_e_c....llllnnnntttt            LNT specification (input)
     _s_p_e_c....lllloooottttoooossss          LOTOS specification (input)
     _s_p_e_c....sssseeeeqqqq            sequence file (input)
     _p_r_o_p....mmmmccccllll            regular mu-calculus formula (input)
     _d_i_a_g....bbbbccccgggg            diagnostic in BCG format (output)
     _f_i_l_e....bbbbeeeessss            BES in textual format (output)


FFFFIIIILLLLEEEESSSS
     $$$$CCCCAAAADDDDPPPP////ssssrrrrcccc////xxxxttttllll////****._m_c_l      predefined libraries (input)


SSSSEEEEEEEE AAAALLLLSSSSOOOO
     bbbbccccgggg(LOCAL),       bbbbccccgggg____ooooppppeeeennnn(LOCAL),        ccccaaaaeeeessssaaaarrrr....aaaaddddtttt(LOCAL),



(C) INRIA            Last change: 2020/02/12                    7






CADP MANUAL PAGES                               EVALUATOR4(LOCAL)



     ccccaaaaeeeessssaaaarrrr____ggggrrrraaaapppphhhh(LOCAL),  ccccaaaaeeeessssaaaarrrr____ssssoooollllvvvveeee____1111(LOCAL),  ccccaaaaeeeessssaaaarrrr(LOCAL),
     eeeevvvvaaaalllluuuuaaaattttoooorrrr(LOCAL),    eeeevvvvaaaalllluuuuaaaattttoooorrrr3333(LOCAL),    eeeexxxxhhhhiiiibbbbiiiittttoooorrrr(LOCAL),
     eeeexxxxpppp(LOCAL),         eeeexxxxpppp....ooooppppeeeennnn(LOCAL),        ffffsssspppp....ooooppppeeeennnn(LOCAL),
     llllnnnntttt....ooooppppeeeennnn(LOCAL),      lllloooottttoooossss(LOCAL),       lllloooottttoooossss....ooooppppeeeennnn(LOCAL),
     mmmmccccllll(LOCAL),    mmmmccccllll3333(LOCAL),    mmmmccccllll4444(LOCAL),   rrrreeeeggggeeeexxxxpppp(LOCAL),
     sssseeeeqqqq(LOCAL), sssseeeeqqqq....ooooppppeeeennnn(LOCAL)

     Additional information is available from the CADP  Web  page
     located at http://cadp.inria.fr

     Directives   for   installation   are   given    in    files
     $$$$CCCCAAAADDDDPPPP////IIIINNNNSSSSTTTTAAAALLLLLLLLAAAATTTTIIIIOOOONNNN____****.

     Recent  changes  and  improvements  to  this  software   are
     reported and commented in file $$$$CCCCAAAADDDDPPPP////HHHHIIIISSSSTTTTOOOORRRRYYYY.


BBBBUUUUGGGGSSSS
     Please report bugs to Radu.Mateescu@inria.fr




































(C) INRIA            Last change: 2020/02/12                    8



