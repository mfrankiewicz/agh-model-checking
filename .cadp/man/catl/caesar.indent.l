


CADP MANUAL PAGES                            CAESAR.INDENT(LOCAL)



NNNNAAAAMMMMEEEE
     caesar.indent - LOTOS specifications pretty-printer


SSSSYYYYNNNNOOOOPPPPSSSSIIIISSSS
     ccccaaaaeeeessssaaaarrrr....iiiinnnnddddeeeennnntttt  [----kkkkwwwwuuuucccc | ----kkkkeeeeyyyywwwwoooorrrrddddssss____iiiinnnn____uuuuppppppppeeeerrrr____ccccaaaasssseeee]  [----kkkkwwwwllllcccc | ----
     kkkkeeeeyyyywwwwoooorrrrddddssss____iiiinnnn____lllloooowwwweeeerrrr____ccccaaaasssseeee]                           [----kkkkwwwwcccciiii | ----
     kkkkeeeeyyyywwwwoooorrrrddddssss____ccccaaaappppiiiittttaaaalllliiiisssseeeedddd____iiiinnnniiiittttiiiiaaaallll]    [----vvvv | ----vvvveeeerrrrbbbboooosssseeee]    [----nnnnvvvv | ----
     nnnnoooovvvveeeerrrrbbbboooosssseeee]  [----llllllll  _n_u_m  | ----lllliiiinnnneeee____lllleeeennnnggggtttthhhh _n_u_m] [----ttttaaaabbbbssss] [----nnnnoooottttaaaabbbbssss]
     [----eeeevvvveeeerrrryyyy _n_u_m] [----mmmm _n_u_m |  ----mmmmaaaarrrrggggiiiinnnn  _n_u_m]  [----ssssttttrrrruuuucccctttt]  [----nnnnssssttttrrrruuuucccctttt]
     _f_i_l_e_n_a_m_e


DDDDEEEESSSSCCCCRRRRIIIIPPPPTTTTIIIIOOOONNNN
     Taking as input  _f_i_l_e_n_a_m_e  which  is  a  file  (with  suffix
     ....lllloooottttoooossss,   ....llllooootttt,   or   ....llll),   containing  a  LOTOS  program,
     ccccaaaaeeeessssaaaarrrr....iiiinnnnddddeeeennnntttt saves _f_i_l_e_n_a_m_e as _f_i_l_e_n_a_m_e....bbbbaaaakkkk checks its syn-
     tax  and  pretty-prints  the program in file _f_i_l_e_n_a_m_e.  This
     allows to read more easily LOTOS programs.


OOOOPPPPTTTTIIIIOOOONNNNSSSS
     ----kkkkwwwwuuuucccc | ----kkkkeeeeyyyywwwwoooorrrrddddssss____iiiinnnn____uuuuppppppppeeeerrrr____ccccaaaasssseeee
          Print all the LOTOS  keywords  in  upper  case.  Not  a
          default option.


     ----kkkkwwwwllllcccc | ----kkkkeeeeyyyywwwwoooorrrrddddssss____iiiinnnn____lllloooowwwweeeerrrr____ccccaaaasssseeee
          Print all the LOTOS keywords in lower case. This  is  a
          default option.


     ----kkkkwwwwcccciiii | ----kkkkeeeeyyyywwwwoooorrrrddddssss____ccccaaaappppiiiittttaaaalllliiiisssseeeedddd____iiiinnnniiiittttiiiiaaaallll
          Print all the LOTOS keywords with the first  letter  in
          upper-case,  the  others  in  lower-case. Not a default
          option.


     ----vvvv | ----vvvveeeerrrrbbbboooosssseeee
          Display progress information, in addition to errors, on
          the  user's  screen.   Opposite  of ----nnnnoooovvvveeeerrrrbbbboooosssseeee. Default
          option is ----nnnnoooovvvveeeerrrrbbbboooosssseeee.


     ----nnnnvvvv | ----nnnnoooovvvveeeerrrrbbbboooosssseeee
          Do not  display  progress  information  on  the  user's
          screen.   Opposite  of  ----vvvveeeerrrrbbbboooosssseeee.  This  is the default
          option.


     ----llllllll _n_u_m | ----lllliiiinnnneeee____lllleeeennnnggggtttthhhh _n_u_m
          Set the maximum line length to _n_u_m. The  default  value



(C) INRIA            Last change: 2016/03/29                    1






CADP MANUAL PAGES                            CAESAR.INDENT(LOCAL)



          is 500.


     ----ttttaaaabbbbssss
          Replace spaces by tabs. Not a default option.


     ----nnnnoooottttaaaabbbbssss
          Do not replace  spaces  by  tabs.  This  is  a  default
          option.


     ----eeeevvvveeeerrrryyyy _n_u_m
          Set the number of spaces that make up a tabulation. The
          default value is 8.


     ----mmmm _n_u_m | ----mmmmaaaarrrrggggiiiinnnn _n_u_m
          Set the maximum  length  of  the  margin  to  _n_u_m.  The
          default value is 460.


     ----ssssttttrrrruuuucccctttt
          Preserve the structure of nested blocks  when  cutting.
          This is a default option.


     ----nnnnssssttttrrrruuuucccctttt
          Do not preserve the structure  of  nested  blocks  when
          cutting.  Not a default option.



EEEEXXXXIIIITTTT SSSSTTTTAAAATTTTUUUUSSSS
     When the source is erroneous,  error  messages  are  issued.
     Exit status is 0 if everything is alright, 1 otherwise.


AAAAUUUUTTTTHHHHOOOORRRRSSSS
     Bruno Vivien (INRIA Rhone-Alpes)
     Adaptation by Mark Jorgensen (INRIA Rhone-Alpes)


OOOOPPPPEEEERRRRAAAANNNNDDDDSSSS
     _f_i_l_e_n_a_m_e            LOTOS specification (input/output)
     _f_i_l_e_n_a_m_e....bbbbaaaakkkk        Backup of input (output)


SSSSEEEEEEEE AAAALLLLSSSSOOOO
     ccccaaaaeeeessssaaaarrrr....aaaaddddtttt(LOCAL), ccccaaaaeeeessssaaaarrrr(LOCAL), lllloooottttoooossss(LOCAL)





(C) INRIA            Last change: 2016/03/29                    2






CADP MANUAL PAGES                            CAESAR.INDENT(LOCAL)



     Additional information is available from the CADP  Web  page
     located at http://cadp.inria.fr

     Directives   for   installation   are   given    in    files
     $$$$CCCCAAAADDDDPPPP////IIIINNNNSSSSTTTTAAAALLLLLLLLAAAATTTTIIIIOOOONNNN____****....

     Recent  changes  and  improvements  to  this  software   are
     reported and commented in file $$$$CCCCAAAADDDDPPPP////HHHHIIIISSSSTTTTOOOORRRRYYYY....


BBBBUUUUGGGGSSSS
     Please report new bugs to cadp@inria.fr











































(C) INRIA            Last change: 2016/03/29                    3



