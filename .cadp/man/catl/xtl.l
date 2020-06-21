


CADP MANUAL PAGES                                      XTL(LOCAL)



NNNNAAAAMMMMEEEE
     xtl - evaluation of value-based temporal logic formulas


SSSSYYYYNNNNOOOOPPPPSSSSIIIISSSS
     xxxxttttllll [ ----cccccccc _o_p_t_i_o_n_s ] [----ccccrrrreeeeaaaatttteeee] [----ddddeeeeppppeeeennnndddd] [----eeeennnngggglllliiiisssshhhh] [----eeeexxxxppppaaaannnndddd]
     [----ffffrrrreeeennnncccchhhh]  [----rrrreeeemmmmoooovvvveeee]  [----ssssiiiilllleeeennnntttt]  [  ----ssssoooouuuurrrrcccceeee _f_i_l_e:_l_i_n_e  ] [ ----
     ttttmmmmpppp _d_i_r_e_c_t_o_r_y ] [----uuuuppppddddaaaatttteeee] [----vvvveeeerrrrbbbboooosssseeee]  [----vvvveeeerrrrssssiiiioooonnnn]  [----wwwwaaaarrrrnnnniiiinnnngggg]
     _f_i_l_e_1[....xxxxttttllll] _f_i_l_e_2[....bbbbccccgggg]


DDDDEEEESSSSCCCCRRRRIIIIPPPPTTTTIIIIOOOONNNN
     xtl takes as input _f_i_l_e_1[....xxxxttttllll], which is a  program  written
     in  XTL  (eXecutable Temporal Language), and evaluates it on
     _f_i_l_e_2[....bbbbccccgggg], which contains an LTS (Labelled Transition Sys-
     tem) encoded in the BCG (Binary Coded Graph) format.

     The XTL tool offers the following features:


     -    XTL  supports  several  temporal  logics  widely  used.
          Currently, the following temporal logics are supported:
          HML, CTL, ACTL, LTAC, as well as the modal mu-calculus.
          All of them can be directly used by end-users to verify
          properties on BCG graphs.


     -    Compared to other model-checkers, XTL is  more  expres-
          sive,  because it allows to handle the data values con-
          tained in states and transition  labels.  These  values
          can  be  used  in  temporal formulas, assigned to vari-
          ables, etc.


     -    Moreover, XTL is extensible. A user can define  his/her
          own  temporal  logic, as a library of operators written
          in XTL.  This is the way in which the currently  avail-
          able  formalisms  (HML,  CTL,  ACTL, LTAC and modal mu-
          calculus) are implemented.


     A detailed description of the XTL language is  available  in
     the xxxxttttllll----llllaaaannnngggg(LOCAL) manual page.


OOOOPPPPTTTTIIIIOOOONNNNSSSS
     ----cccccccc _o_p_t_i_o_n_s
          Pass _o_p_t_i_o_n_s to the C  compiler  when  it  is  invoked.
          _o_p_t_i_o_n_s  is  a  list  of  compiler options (enclosed in
          quotes or double quotes). These options are appended to
          the compiler options, if any, contained in the $$$$CCCCAAAADDDDPPPP____CCCCCCCC
          environment variable (see ENVIRONMENT VARIABLES below).



(C) INRIA            Last change: 2018/07/06                    1






CADP MANUAL PAGES                                      XTL(LOCAL)



          Not a default option.


     ----ccccrrrreeeeaaaatttteeee
          Force the dynamic library of  file  _f_i_l_e_2[....bbbbccccgggg]  to  be
          created,  even  if  it  already  exists  in the current
          directory and  if  it  is  up-to-date.  Not  a  default
          option.


     ----ddddeeeeppppeeeennnndddd
          Display the list of library files included (directly or
          transitively)  in  the  file _f_i_l_e_1[....xxxxttttllll] and stop. This
          list may be incomplete if the XTL program is  syntacti-
          cally incorrect. If present, this option has precedence
          over all the other options. Not a default option.


     ----eeeennnngggglllliiiisssshhhh
          Print messages in English. Opposite  of  ----ffffrrrreeeennnncccchhhh.  This
          option  overrides  the $$$$CCCCAAAADDDDPPPP____LLLLAAAANNNNGGGGUUUUAAAAGGGGEEEE environment vari-
          able (see ENVIRONMENT VARIABLES below).


     ----eeeexxxxppppaaaannnndddd
          Expand the macro definitions and the XTL  source  files
          included  as libraries in the file _f_i_l_e_1[....xxxxttttllll], produc-
          ing as output a file _f_i_l_e_1....xxxxpppp, and  stop.  This  option
          may  be  useful  for  debugging purposes. Not a default
          option.


     ----ffffrrrreeeennnncccchhhh
          Print messages in French. Opposite  of  ----eeeennnngggglllliiiisssshhhh.  This
          option  overrides  the $$$$CCCCAAAADDDDPPPP____LLLLAAAANNNNGGGGUUUUAAAAGGGGEEEE environment vari-
          able (see ENVIRONMENT VARIABLES below).


     ----rrrreeeemmmmoooovvvveeee
          Remove the dynamic library of  file  _f_i_l_e_2[....bbbbccccgggg]  after
          usage.  Not a default option.


     ----ssssiiiilllleeeennnntttt
          Execute silently. Opposite of ----vvvveeeerrrrbbbboooosssseeee. Default  option
          is ----vvvveeeerrrrbbbboooosssseeee.


     ----ssssoooouuuurrrrcccceeee _f_i_l_e:_l_i_n_e
          Change the file name and line number displayed in error
          messages  as  if  the XTL program was contained in file
          _f_i_l_e starting at line _l_i_n_e (instead of starting at line



(C) INRIA            Last change: 2018/07/06                    2






CADP MANUAL PAGES                                      XTL(LOCAL)



          1 in file _f_i_l_e_1[....xxxxttttllll]).  This option has effect only on
          the messages triggered by the errors occurring  in  the
          top-level  file  _f_i_l_e_1[....xxxxttttllll]. The messages triggered by
          the errors occurring in the included libraries (if any)
          are left unchanged.


     ----ttttmmmmpppp _d_i_r_e_c_t_o_r_y
          Use _d_i_r_e_c_t_o_r_y to store the temporary files. This option
          overrides   the  environment  variable  $$$$CCCCAAAADDDDPPPP____TTTTMMMMPPPP  (see
          ENVIRONMENT VARIABLES below).  Not a default option.


     ----uuuuppppddddaaaatttteeee
          Do not create the dynamic library of  file  _f_i_l_e_2[....bbbbccccgggg]
          if it already exists in the current directory and if it
          is up-to-date.  Default option.


     ----vvvveeeerrrrbbbboooosssseeee
          Animate the user's screen, telling what  is  going  on.
          Opposite of ----ssssiiiilllleeeennnntttt.  Default option.


     ----vvvveeeerrrrssssiiiioooonnnn
          Display the current version number of the XTL tool  and
          stop.  To be effective, this option should occur as the
          first argument on the command line. Subsequent  options
          and/or arguments, if any, will be discarded.


     ----wwwwaaaarrrrnnnniiiinnnngggg
          Print extra warning messages. Not a default option.


EEEENNNNVVVVIIIIRRRROOOONNNNMMMMEEEENNNNTTTT VVVVAAAARRRRIIIIAAAABBBBLLLLEEEESSSS
     The following environment variables are used:


     $$$$CCCCAAAADDDDPPPP,,,, $$$$CCCCAAAADDDDPPPP____LLLLAAAANNNNGGGGUUUUAAAAGGGGEEEE,,,, $$$$CCCCAAAADDDDPPPP____CCCCCCCC,,,, $$$$CCCCAAAADDDDPPPP____TTTTMMMMPPPP
          The meaning  of  these  variables  is  defined  in  the
          $$$$CCCCAAAADDDDPPPP////IIIINNNNSSSSTTTTAAAALLLLLLLLAAAATTTTIIIIOOOONNNN____2222 file.


     $$$$XXXXTTTTLLLL
          If this variable is set, its value should reference the
          directory  in  which  the  XTL package in installed. By
          default, this variable is supposed to be unset: the XTL
          package  is  normally installed in the directory refer-
          enced by the environment variable  $$$$CCCCAAAADDDDPPPP.  Setting  the
          $$$$XXXXTTTTLLLL  variable  should be avoided in official distribu-
          tions of the XTL package, since it may cause problems.



(C) INRIA            Last change: 2018/07/06                    3






CADP MANUAL PAGES                                      XTL(LOCAL)



EEEEXXXXIIIITTTT SSSSTTTTAAAATTTTUUUUSSSS
     Exit status is 0 if everything is alright, 1 otherwise.


DDDDIIIIAAAAGGGGNNNNOOOOSSSSTTTTIIIICCCCSSSS
     When the source XTL file  _f_i_l_e_1[....xxxxttttllll]  is  erroneous,  error
     messages are issued.


AAAAUUUUTTTTHHHHOOOORRRR
     Radu Mateescu (INRIA Rhone-Alpes / VASY)


OOOOPPPPEEEERRRRAAAANNNNDDDDSSSS
     _f_i_l_e_n_a_m_e....xxxxttttllll             XTL source program (input)
     _f_i_l_e_n_a_m_e....bbbbccccgggg             LTS in BCG format (input)
     _f_i_l_e_n_a_m_e....xxxxpppp              XTL expanded program (output)


FFFFIIIILLLLEEEESSSS
     _f_i_l_e_n_a_m_e....oooo               object file (temporary)
     _f_i_l_e_n_a_m_e@@@@1111....oooo             dynamic BCG library (auxiliary)
     $$$$CCCCAAAADDDDPPPP////LLLLIIIICCCCEEEENNNNSSSSEEEE            license file
     $$$$CCCCAAAADDDDPPPP////ssssrrrrcccc////ccccoooommmm////ccccaaaaddddpppp____cccccccc    C compiler shell
     $$$$CCCCAAAADDDDPPPP////ssssrrrrcccc////xxxxttttllll////****....xxxxttttllll      predefined XTL library (input)
     $$$$CCCCAAAADDDDPPPP____TTTTMMMMPPPP////xxxxttttllll____****....cccc        intermediate C code (temporary)
     $$$$CCCCAAAADDDDPPPP____TTTTMMMMPPPP////xxxxttttllll____****....xxxx        binary code (temporary)


SSSSEEEEEEEE AAAALLLLSSSSOOOO
     bbbbccccgggg(LOCAL), bbbbccccgggg____iiiioooo(LOCAL), xxxxttttllll(LOCAL).

     Additional information is available from the CADP  Web  page
     located at http://cadp.inria.fr

     Directives   for   installation   are   given    in    files
     $$$$CCCCAAAADDDDPPPP////IIIINNNNSSSSTTTTAAAALLLLLLLLAAAATTTTIIIIOOOONNNN____****.

     Recent  changes  and  improvements  to  this  software   are
     reported and commented in file $$$$CCCCAAAADDDDPPPP////HHHHIIIISSSSTTTTOOOORRRRYYYY.


BBBBUUUUGGGGSSSS
     Please report bugs to Radu.Mateescu@inria.fr











(C) INRIA            Last change: 2018/07/06                    4



