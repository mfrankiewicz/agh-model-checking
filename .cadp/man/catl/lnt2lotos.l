


CADP MANUAL PAGES                                LNT2LOTOS(LOCAL)



NNNNAAAAMMMMEEEE
     lnt2lotos - LNT to LOTOS translator


SSSSYYYYNNNNOOOOPPPPSSSSIIIISSSS
     llllnnnntttt2222lllloooottttoooossss [----ssssiiiilllleeeennnntttt | ----vvvveeeerrrrbbbboooosssseeee] [----vvvveeeerrrrssssiiiioooonnnn] [----ddddeeeeppppeeeennnndddd] [----ffffoooorrrrcccceeee]
     [----mmmmoooorrrreeee    _c_o_m_m_a_n_d]    [----ppppiiiiddddlllliiiisssstttt]    [----rrrrooooooootttt    _i_n_s_t_a_n_t_i_a_t_i_o_n]
     _f_i_l_e_n_a_m_e[....llllnnnntttt]


DDDDEEEESSSSCCCCRRRRIIIIPPPPTTTTIIIIOOOONNNN
     LNT (LOTOS New Technology, formerly noted LOTOS  NT)  is  an
     imperatively  styled  specification  language for concurrent
     processes. The llllnnnntttt2222lllloooottttoooossss program translates a LNT specifica-
     tion to a LOTOS specification.

     The input to llllnnnntttt2222lllloooottttoooossss is a LNT file, whose name should con-
     tain  only  letters, digits, and underscores, and which must
     have the extension ....llllnnnntttt. If the user does  not  specify  the
     extension  ....llllnnnntttt  on the command line, this extension will be
     appended  automatically,  so  that   llllnnnntttt2222lllloooottttoooossss   will   read
     _f_i_l_e_n_a_m_e....llllnnnntttt  as  input.  External C code can be provided by
     auxiliary files, namely _f_i_l_e_n_a_m_e....ttttnnnntttt for data  type  defini-
     tions and _f_i_l_e_n_a_m_e....ffffnnnntttt for function definitions.

     Typically, the input should have been pre-processed  by  llllpppppppp
     before  being passed to llllnnnntttt2222lllloooottttoooossss. The pre-processor expands
     extended notation such as literal numbers and strings, which
     is not accepted by llllnnnntttt2222lllloooottttoooossss directly.

     The principal output of llllnnnntttt2222lllloooottttoooossss is a  LOTOS  specification
     named  _f_i_l_e_n_a_m_e....lllloooottttoooossss (unless the ----rrrrooooooootttt nnnnuuuullllllll option is used,
     in which case a  LOTOS  library  _F_I_L_E_N_A_M_E....lllliiiibbbb  is  generated
     instead;  see  below  for  further  details).  Two auxiliary
     files are also generated, namely _f_i_l_e_n_a_m_e....tttt, which  contains
     C  code  for external data types, and _f_i_l_e_n_a_m_e....ffff, which con-
     tains C code for external functions.  Note  that  _f_i_l_e_n_a_m_e....tttt
     includes  _f_i_l_e_n_a_m_e....ttttnnnntttt  (if  present),  and  that _f_i_l_e_n_a_m_e....ffff
     includes _f_i_l_e_n_a_m_e....ffffnnnntttt (if present).

     To avoid confusion between source code and  generated  code,
     all  output  files  created by llllnnnntttt2222lllloooottttoooossss will be placed in a
     special directory that llllnnnntttt2222lllloooottttoooossss  creates  if  it  does  not
     exist  already.   If  the  creation  of the directory fails,
     llllnnnntttt2222lllloooottttoooossss issues an error message and stops.   The  name  of
     this  directory  is either given by the environment variable
     $$$$LLLLNNNNTTTTGGGGEEEENNNN, if this variable is set, or is ....////LLLLNNNNTTTTGGGGEEEENNNN by default.
     Note  that  ....////LLLLNNNNTTTTGGGGEEEENNNN (or $$$$LLLLNNNNTTTTGGGGEEEENNNN) is created relative to the
     directory from which the user calls llllnnnntttt2222lllloooottttoooossss, not  relative
     to the directory containing the input file.





(C) INRIA            Last change: 2019/01/16                    1






CADP MANUAL PAGES                                LNT2LOTOS(LOCAL)



     The name of the input file is used to construct the names of
     the  output files, with the particular rule that all letters
     are turned to upper case when constructing the names of ....lllliiiibbbb
     files.  For an input file eeeexxxxaaaammmmpppplllleeee....llllnnnntttt, llllnnnntttt2222lllloooottttoooossss creates the
     LOTOS  library  EEEEXXXXAAAAMMMMPPPPLLLLEEEE....lllliiiibbbb  or  the   LOTOS   specification
     eeeexxxxaaaammmmpppplllleeee....lllloooottttoooossss,   and   two  auxiliary  files  eeeexxxxaaaammmmpppplllleeee....tttt  and
     eeeexxxxaaaammmmpppplllleeee....ffff.

     To avoid clashes between generated  files  and  user-written
     files,  llllnnnntttt2222lllloooottttoooossss  writes  a special tag at the beginning of
     each generated file.  This tag is a comment  containing  the
     name  and  the version of llllnnnntttt2222lllloooottttoooossss that generated the file.
     llllnnnntttt2222lllloooottttoooossss uses this tag for two purposes:

     -    To prevent llllnnnntttt2222lllloooottttoooossss from overwriting a file  that  was
          not  generated  by  itself:  if the output file already
          exists but has no special tag or  has  an  invalid  tag
          indicating that the file was not generated by the right
          tool, llllnnnntttt2222lllloooottttoooossss issues an error message and stops.

     -    To avoid unnecessary compilations: llllnnnntttt2222lllloooottttoooossss recompiles
          a  LNT  file only if the source file was modified since
          the last translation, or if the output  file  was  gen-
          erated by an older version of llllnnnntttt2222lllloooottttoooossss.


OOOOPPPPTTTTIIIIOOOONNNNSSSS
     -ssssiiiilllleeeennnntttt
          Execute silently, reporting only errors.  This  is  the
          opposite of ----vvvveeeerrrrbbbboooosssseeee.  The default option is ----vvvveeeerrrrbbbboooosssseeee.

     -vvvveeeerrrrbbbboooosssseeee
          Report activities and progress,  including  errors,  to
          the  user's  screen.  This  is the opposite of ----ssssiiiilllleeeennnntttt.
          The default option is ----vvvveeeerrrrbbbboooosssseeee.

     -vvvveeeerrrrssssiiiioooonnnn
          Display the tool version and exit.

     -ddddeeeeppppeeeennnndddd
          List  all  the  LNT  files  transitively  included   in
          _f_i_l_e_n_a_m_e....llllnnnntttt and exit. Not a default option.

     -ffffoooorrrrcccceeee
          Overwrite the output files, even if they were edited by
          the user or do not need to be updated.

     ----mmmmoooorrrreeee _c_o_m_m_a_n_d
          Use _c_o_m_m_a_n_d to display the error messages,  instead  of
          "$$$$CCCCAAAADDDDPPPP////ssssrrrrcccc////ccccoooommmm////ccccaaaaddddpppp____mmmmoooorrrreeee",  which  is the default. _c_o_m_-
          _m_a_n_d is a shell command (preferably enclosed in  quotes
          or double quotes) containing the pathname of the chosen



(C) INRIA            Last change: 2019/01/16                    2






CADP MANUAL PAGES                                LNT2LOTOS(LOCAL)



          pager, possibly followed by a list of  options.  Not  a
          default option.

     -ppppiiiiddddlllliiiisssstttt
          List the names of all processes without  value  parame-
          ters  that  occur  in the input file and exit. In other
          words, list all processes that can be used  as  a  main
          process  having  no  value  parameter (by instantiation
          with the ----rrrrooooooootttt option). This  option  is  used  by  the
          EUCALYPTUS graphical user interface.

     -rrrrooooooootttt _i_n_s_t_a_n_t_i_a_t_i_o_n
          where _i_n_s_t_a_n_t_i_a_t_i_o_n can  take  three  different  forms:
          mmmmoooodddduuuulllleeee, nnnnuuuullllllll, or a character string of the form "_P [_G_1,
          ..., _G_m] (_V_1, ..., _V_n)" according to the syntax  for  a
          process  instantiation  given  in  the reference manual
          [Champelovier-Clerc-Garavel-et-al-10].  By default,  if
          the  "----rrrrooooooootttt"  option  is absent, it is assumed to be of
          the third form and identical to "----rrrrooooooootttt MMMMAAAAIIIINNNN".
          If the option "----rrrrooooooootttt mmmmoooodddduuuulllleeee"  is  specified,  llllnnnntttt2222lllloooottttoooossss
          will  generate  a  LOTOS  library  (i.e., a "....lllliiiibbbb" file
          without main behaviour). If the LNT specification  con-
          tains a process called MMMMAAAAIIIINNNN, it will be treated like an
          ordinary process.
          If the option "----rrrrooooooootttt nnnnuuuullllllll" is specified, llllnnnntttt2222lllloooottttoooossss will
          generate  a LOTOS specification whose main behaviour is
          "ssssttttoooopppp". If the LNT  specification  contains  a  process
          called  MMMMAAAAIIIINNNN,  it will be treated like an ordinary pro-
          cess.
          In the third case,  llllnnnntttt2222lllloooottttoooossss  will  generate  a  LOTOS
          specification whose main behaviour is the instantiation
          of process _P with actual gate identifiers [_G_1, ..., _G_m]
          and actual value parameters (_V_1, ..., _V_n).
          As processes cannot be overloaded in LNT, there must be
          at  most one process called _P in the LNT specification,
          either directly defined in _f_i_l_e_n_a_m_e....llllnnnntttt or defined in a
          included module included transitively.
          The list of actual gate parameters is optional; if this
          list  is missing and if _f_i_l_e_n_a_m_e....llllnnnntttt does not contain a
          process named _P, an empty list of  gate  parameters  is
          assumed;  if  this  list is missing and if _f_i_l_e_n_a_m_e....llllnnnntttt
          contains a process named _P, llllnnnntttt2222lllloooottttoooossss  will  replace  a
          missing  list  of actual gate parameters by the list of
          formal gate parameters of the process _P.  If process  _P
          is  defined  in  _f_i_l_e_n_a_m_e....llllnnnntttt,  the list of actual gate
          parameters can also be given using named-style  parame-
          ters (``====>>>>'') and ellipses (``............'').
          The list of actual value parameters is  also  optional;
          if this list is missing, an empty list of value parame-
          ters is assumed. It should only contain  algebraically-
          closed terms (i.e., contain no variables) and be compa-
          tible, in number and types, with the  list   of  formal



(C) INRIA            Last change: 2019/01/16                    3






CADP MANUAL PAGES                                LNT2LOTOS(LOCAL)



          variable parameters of process _P. Process _P should have
          only iiiinnnn parameters (i.e., no oooouuuutttt or  iiiinnnnoooouuuutttt  parameter).
          If  the  actual  value  parameters use rich-term syntax
          notations [Champelovier-Clerc-Garavel-et-al-10, chapter
          3],  these  notations  must be expanded before invoking
          llllnnnntttt2222lllloooottttoooossss;   this   is   automatically   performed   by
          llllnnnntttt....ooooppppeeeennnn(LOCAL)  which calls llllpppppppp(LOCAL) to expand rich-
          term syntax before invoking llllnnnntttt2222lllloooottttoooossss.


OOOOPPPPEEEERRRRAAAANNNNDDDDSSSS
     _f_i_l_e_n_a_m_e....llllnnnntttt             LNT specification (input)
     _f_i_l_e_n_a_m_e....ttttnnnntttt             C code for data types (input)
     _f_i_l_e_n_a_m_e....ffffnnnntttt             C code for functions (input)
     $$$$LLLLNNNNTTTTGGGGEEEENNNN////****....ssssiiiigggg            imported modules signatures (input)
     $$$$LLLLNNNNTTTTGGGGEEEENNNN////_f_i_l_e_n_a_m_e....lllloooottttoooossss   LOTOS code (optional output)
     $$$$LLLLNNNNTTTTGGGGEEEENNNN////_F_I_L_E_N_A_M_E....lllliiiibbbb     LOTOS code (optional output)
     $$$$LLLLNNNNTTTTGGGGEEEENNNN////_f_i_l_e_n_a_m_e....tttt       C code (output)
     $$$$LLLLNNNNTTTTGGGGEEEENNNN////_f_i_l_e_n_a_m_e....ffff       C code (output)
     $$$$LLLLNNNNTTTTGGGGEEEENNNN////_f_i_l_e_n_a_m_e....eeeerrrrrrrr     detailed error messages (output)
     $$$$LLLLNNNNTTTTGGGGEEEENNNN////_f_i_l_e_n_a_m_e....ssssiiiigggg     module signature (output)

FFFFIIIILLLLEEEESSSS
     $$$$CCCCAAAADDDDPPPP////lllliiiibbbb////LLLLNNNNTTTT____VVVV1111....lllliiiibbbb
                       LNT predefined library (LOTOS code)
     $$$$CCCCAAAADDDDPPPP////iiiinnnnccccllll////LLLLNNNNTTTT____VVVV1111....hhhh
                       LNT predefined library (C code)

EEEENNNNVVVVIIIIRRRROOOONNNNMMMMEEEENNNNTTTT VVVVAAAARRRRIIIIAAAABBBBLLLLEEEESSSS
     $$$$LLLLNNNNTTTTGGGGEEEENNNN
          The target directory of the output files.

EEEEXXXXIIIITTTT SSSSTTTTAAAATTTTUUUUSSSS
     If the translation was successful the exit status is 0, even
     if  warnings  were issued during the execution. If any error
     occurred during translation, the exit status is 1.

AAAAUUUUTTTTHHHHOOOORRRRSSSS
     David Champelovier, Xavier  Clerc,  Hubert  Garavel,  Gideon
     Smeding, Frederic Lang, Wendelin Serwe (INRIA Rhone-Alpes)

SSSSEEEEEEEE AAAALLLLSSSSOOOO
     ccccaaaaeeeessssaaaarrrr....aaaaddddtttt(LOCAL),       ccccaaaaeeeessssaaaarrrr(LOCAL),        lllloooottttoooossss(LOCAL),
     llllnnnntttt....ooooppppeeeennnn(LOCAL),  llllpppppppp(LOCAL),  and  the "Reference Manual of
     the   LNT    to    LOTOS    Translator"    available    from
     http://cadp.inria.fr/publications/Champelovier-Clerc-
     Garavel-et-al-10.html

     Additional information is available from the CADP  Web  page
     located at http://cadp.inria.fr
     Directives   for   installation   are   given    in    files
     $$$$CCCCAAAADDDDPPPP////IIIINNNNSSSSTTTTAAAALLLLLLLLAAAATTTTIIIIOOOONNNN____****.



(C) INRIA            Last change: 2019/01/16                    4






CADP MANUAL PAGES                                LNT2LOTOS(LOCAL)



     Recent  changes  and  improvements  to  this  software   are
     reported and commented in file $$$$CCCCAAAADDDDPPPP////HHHHIIIISSSSTTTTOOOORRRRYYYY.

BBBBUUUUGGGGSSSS
     The type system of llllnnnntttt2222lllloooottttoooossss  is  not  implemented  in  full
     detail,  hence, some incorrect LNT programs will be accepted
     by llllnnnntttt2222lllloooottttoooossss  and  translated  into  LOTOS.  However,  these
     errors  will  be  detected by the LOTOS compilers ccccaaaaeeeessssaaaarrrr and
     ccccaaaaeeeessssaaaarrrr....aaaaddddtttt.

     Please report any mistranslations  or  other  problems  with
     llllnnnntttt2222lllloooottttoooossss to cadp@inria.fr











































(C) INRIA            Last change: 2019/01/16                    5



