


CADP MANUAL PAGES                                NUPN_INFO(LOCAL)



NNNNAAAAMMMMEEEE
     nupn_info - query and transformation  of  Nested-Unit  Petri
     Nets


SSSSYYYYNNNNOOOOPPPPSSSSIIIISSSS
     nnnnuuuuppppnnnn____iiiinnnnffffoooo _o_p_t_i_o_n [ _f_i_l_e_n_a_m_e....nnnnuuuuppppnnnn ]


DDDDEEEESSSSCCCCRRRRIIIIPPPPTTTTIIIIOOOONNNN
     Taking as input _f_i_l_e_n_a_m_e....nnnnuuuuppppnnnn (or by  default  the  standard
     input),  which  contains  a  Nested-Unit  Petri  Net  (NUPN)
     encoded in the nnnnuuuuppppnnnn(LOCAL) format, nnnnuuuuppppnnnn____iiiinnnnffffoooo performs  vari-
     ous  analyses  or  transformations,  depending on the _o_p_t_i_o_n
     specified on the command-line, and writes the  corresponding
     results to the standard output.


OOOOPPPPTTTTIIIIOOOONNNNSSSS
     ----ccccaaaannnnoooonnnniiiiccccaaaallll----nnnnuuuuppppnnnn
          Simplify (if possible) the input NUPN to put it under a
          normal   form.    The   following  transformations  are
          applied: tabulations are replaced with spaces; empty or
          blank  lines are deleted; extra spaces are removed; the
          description of units and the description of transitions
          are sorted by increasing numbers; the list of sub-units
          of each unit is sorted by increasing numbers; the lists
          of  input  and  output  places  of  each transition are
          sorted by increasing numbers; any line of the following
          form  "iiiinnnniiiittttiiiiaaaallll  ppppllllaaaacccceeee  %%%%ddddPPPP""""  iiiissss  rrrreeeeppppllllaaaacccceeeedddd wwwwiiiitttthhhh """"iiiinnnniiiittttiiiiaaaallll
          ppppllllaaaacccceeeessss ####1111 %%%%ddddPPPP"""";;;; aaaannnnyyyy lllliiiinnnneeee ooooffff tttthhhheeee ffffoooolllllllloooowwwwiiiinnnngggg ffffoooorrrrmmmm  """"llllaaaabbbbeeeellllssss
          0000  0000  0000  %%%%ddddPPPP""""  iiiissss ddddeeeelllleeeetttteeeedddd;;;; tttthhhheeee mmmmaaaaxxxxiiiimmmmaaaallll lllleeeennnnggggtttthhhh ooooffff llllaaaabbbbeeeellllssss
          ((((4444tttthhhh aaaarrrrgggguuuummmmeeeennnntttt ooooffff tttthhhheeee """"llllaaaabbbbeeeellllssss"""" lllliiiinnnneeee)))) iiiissss  rrrreeeeccccoooommmmppppuuuutttteeeedddd  aaaannnndddd
          sssseeeetttt  ttttoooo  iiiittttssss  mmmmiiiinnnniiiimmmmaaaallll  vvvvaaaalllluuuueeee....  TTTThhhheeee  rrrreeeessssuuuullllttttiiiinnnngggg  NNNNUUUUPPPPNNNN  iiiissss
          ddddiiiissssppppllllaaaayyyyeeeedddd oooonnnn tttthhhheeee ssssttttaaaannnnddddaaaarrrrdddd oooouuuuttttppppuuuutttt....


     ----ppppllllaaaacccceeee----ffffuuuussssiiiioooonnnn
          Apply the place-fusion abstraction to the  input  NUPN,
          merging in each unit all the places of this unit into a
          single place. The resulting NUPN has as many places  as
          it  has  non-void  units.  Places  may be renumbered if
          merged places are deleted; unit and transition  numbers
          are kept unchanged.  The resulting NUPN is displayed on
          the standard output.


     ----rrrreeeedddduuuunnnnddddaaaannnntttt----rrrreeeemmmmoooovvvvaaaallll
          Eliminate all redundant  units  from  the  input  NUPN,
          i.e.,  units  containing  exactly one (directly nested)
          sub-unit. Units and places may be renumbered if  redun-
          dant  units  are  deleted;  transition numbers are kept



(C) INRIA            Last change: 2019/11/05                    1






CADP MANUAL PAGES                                NUPN_INFO(LOCAL)



          unchanged.  If the input NUPN has  no  redundant  unit,
          the  only changes applied are those performed by option
          ----ccccaaaannnnoooonnnniiiiccccaaaallll----nnnnuuuuppppnnnn. The resulting NUPN is displayed on the
          standard output.


     ----ttttrrrriiiivvvviiiiaaaallll----uuuunnnniiiittttssss
          Erase the existing unit structure of the input NUPN and
          replace  it  with  the trivial unit structure, in which
          each unit contains a  single  place,  except  the  root
          unit,  which  has  no  place and contains all the other
          units. The resulting NUPN has as many non-void units as
          it has places. Units may be renumbered if new units are
          added; place and transition numbers are kept unchanged.
          The resulting NUPN is displayed on the standard output.


     ----vvvvooooiiiidddd----rrrreeeemmmmoooovvvvaaaallll
          Eliminate all void  (non-root)  units  from  the  input
          NUPN, i.e., units containing no local places. Units may
          be renumbered if void  units  are  deleted;  place  and
          transition  numbers  are  kept  unchanged. If the input
          NUPN has no void  (non-root)  unit,  the  only  changes
          applied  are those performed by option ----ccccaaaannnnoooonnnniiiiccccaaaallll----nnnnuuuuppppnnnn.
          The resulting NUPN is displayed on the standard output.


     For performance reasons, nnnnuuuuppppnnnn____iiiinnnnffffoooo assumes that the contents
     of the input NUPN are correct.  When dealing with an unknown
     NUPN, it is therefore advisable to first  analyze  its  con-
     tents with the ----cccchhhheeeecccckkkk option of ccccaaaaeeeessssaaaarrrr....bbbbdddddddd(LOCAL).  However,
     certain  options  (especially  ----ccccaaaannnnoooonnnniiiiccccaaaallll----nnnnuuuuppppnnnn  aaaannnndddd   ----vvvvooooiiiidddd----
     rrrreeeemmmmoooovvvvaaaallll)))) mmmmaaaayyyy ttttrrrraaaannnnssssffffoooorrrrmmmm aaaannnn iiiinnnnccccoooorrrrrrrreeeecccctttt NNNNUUUUPPPPNNNN iiiinnnnttttoooo aaaa ccccoooorrrrrrrreeeecccctttt oooonnnneeee....


NNNNUUUUPPPPNNNN ((((NNNNEEEESSSSTTTTEEEEDDDD----UUUUNNNNIIIITTTT PPPPEEEETTTTRRRRIIII NNNNEEEETTTT)))) FFFFOOOORRRRMMMMAAAATTTT
     See the nnnnuuuuppppnnnn(LOCAL) manual page for a detailed definition of
     the NUPN file format.


EEEEXXXXIIIITTTT SSSSTTTTAAAATTTTUUUUSSSS
     The exit status of nnnnuuuuppppnnnn____iiiinnnnffffoooo is zero if execution went well;
     in  such  case, a valid NUPN file is written to the standard
     output. Otherwise, a non-zero exit status is returned and an
     error message may be displayed to the standard output.


AAAAUUUUTTTTHHHHOOOORRRR
     Hubert Garavel (INRIA Rhone-Alpes)






(C) INRIA            Last change: 2019/11/05                    2






CADP MANUAL PAGES                                NUPN_INFO(LOCAL)



FFFFIIIILLLLEEEESSSS
     _f_i_l_e_n_a_m_e....nnnnuuuuppppnnnn    Nested-Unit Petri Net (input)

BBBBIIIIBBBBLLLLIIIIOOOOGGGGRRRRAAAAPPPPHHHHYYYY
     [Gar19] Hubert Garavel. "Nested-Unit Petri  Nets".   Journal
     of  Logical  and Algebraic Methods in Programming, vol. 104,
     pages     60-85,     April     2019.     Available      from
     http://cadp.inria.fr/publications/Garavel-19.html

     [Gar15] Hubert Garavel.  "Nested-Unit Petri Nets:  A  Struc-
     tural Means to Increase Efficiency and Scalability of Verif-
     ication on Elementary Nets".  In R. Devillers  and  A.  Val-
     mari, editors, Proceedings of the 36th International Confer-
     ence on Application and Theory of Petri Nets and Concurrency
     (PETRI  NETS'15),  Brussels,  Belgium. Lecture Notes in Com-
     puter Science, vol.  9115,  Springer,  2015.  Superseded  by
     [Gar19].                    Available                   from
     http://cadp.inria.fr/publications/Garavel-15-a.html

SSSSEEEEEEEE AAAALLLLSSSSOOOO
     ccccaaaaeeeessssaaaarrrr....bbbbdddddddd(LOCAL), nnnnuuuuppppnnnn(LOCAL)

     Additional information is available from the CADP  Web  page
     located at http://cadp.inria.fr
     Directives   for   installation   are   given    in    files
     $$$$CCCCAAAADDDDPPPP////IIIINNNNSSSSTTTTAAAALLLLLLLLAAAATTTTIIIIOOOONNNN____****....
     Recent  changes  and  improvements  to  this  software   are
     reported and commented in file $$$$CCCCAAAADDDDPPPP////HHHHIIIISSSSTTTTOOOORRRRYYYY....
BBBBUUUUGGGGSSSS
     Please report new bugs to Hubert.Garavel@inria.fr

























(C) INRIA            Last change: 2019/11/05                    3



