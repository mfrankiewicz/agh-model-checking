


OPEN/CAESAR MANUAL                         caesar_rename_1(LOCAL)



NNNNAAAAMMMMEEEE
     caesar_rename_1 - the ``rename_1'' library of OPEN/CAESAR

PPPPUUUURRRRPPPPOOOOSSSSEEEE
     The ``rename_1'' library provides primitives for  processing
     ``renaming  files''.  These  files specify which labels of a
     graph should be renamed, and how to rename them, using a set
     of regular expressions.


UUUUSSSSAAAAGGGGEEEE
     The ``rename_1'' library consists of:

     -    a predefined header file ccccaaaaeeeessssaaaarrrr____rrrreeeennnnaaaammmmeeee____1111....hhhh;

     -    the precompiled library file lllliiiibbbbccccaaaaeeeessssaaaarrrr....aaaa, which  imple-
          ments the features described in ccccaaaaeeeessssaaaarrrr____rrrreeeennnnaaaammmmeeee____1111....hhhh.

     Note: The ``rename_1'' library is  a  software  layer  built
     above the primitives offered by the ``standard'' library.


RRRREEEENNNNAAAAMMMMIIIINNNNGGGG FFFFIIIILLLLEEEESSSS
     In this section, we define the format of renaming files,  as
     they  are  used  in the _C_A_D_P toolbox. The next sections will
     explain how the ``renaming_1'' library of  _O_P_E_N/_C_A_E_S_A_R  sup-
     ports (and extends) this format.

     A renaming file is a text file containing a set of  ``renam-
     ing  patterns''.  There  is  no mandatory suffix (i.e., file
     extension) for renaming files: any file name  can  be  used;
     however,  it is recommended to use one of the following suf-
     fixes ``.ren'' (recommended) or ``.rename''.

     The syntax of renaming files is described by  the  following
     context-free grammar:


          <<<<aaaaxxxxiiiioooommmm>>>> ::::::::==== <<<<bbbbllllaaaannnnkkkkssss>>>> <<<<hhhheeeeaaaaddddeeeerrrr>>>> <<<<bbbbllllaaaannnnkkkkssss>>>> \\\\nnnn <<<<rrrreeeennnnaaaammmmiiiinnnngggg----lllliiiisssstttt>>>>

          <<<<hhhheeeeaaaaddddeeeerrrr>>>> ::::::::==== rrrreeeennnnaaaammmmeeee

          <<<<rrrreeeennnnaaaammmmiiiinnnngggg----lllliiiisssstttt>>>> ::::::::==== <<<<eeeemmmmppppttttyyyy>>>>
                           ||||  <<<<rrrreeeennnnaaaammmmiiiinnnngggg>>>> <<<<rrrreeeennnnaaaammmmiiiinnnngggg----lllliiiisssstttt>>>>

          <<<<rrrreeeennnnaaaammmmiiiinnnngggg>>>> ::::::::==== <<<<lllleeeefffftttt----ppppaaaatttttttteeeerrrrnnnn>>>> ---->>>> <<<<rrrriiiigggghhhhtttt----ppppaaaatttttttteeeerrrrnnnn>>>> \\\\nnnn

          <<<<lllleeeefffftttt----ppppaaaatttttttteeeerrrrnnnn>>>> ::::::::==== <<<<bbbbllllaaaannnnkkkkssss>>>> <<<<lllleeeefffftttt----rrrreeeeggggeeeexxxxpppp>>>> <<<<bbbbllllaaaannnnkkkkssss>>>>
                          ||||  <<<<bbbbllllaaaannnnkkkkssss>>>> """"<<<<lllleeeefffftttt----rrrreeeeggggeeeexxxxpppp>>>>"""" <<<<bbbbllllaaaannnnkkkkssss>>>>

          <<<<rrrriiiigggghhhhtttt----ppppaaaatttttttteeeerrrrnnnn>>>> ::::::::==== <<<<bbbbllllaaaannnnkkkkssss>>>> <<<<rrrriiiigggghhhhtttt----rrrreeeeggggeeeexxxxpppp>>>> <<<<bbbbllllaaaannnnkkkkssss>>>>
                           ||||  <<<<bbbbllllaaaannnnkkkkssss>>>> """"<<<<rrrriiiigggghhhhtttt----rrrreeeeggggeeeexxxxpppp>>>>"""" <<<<bbbbllllaaaannnnkkkkssss>>>>



(C) INRIA     Last change: 2020/02/11 (version 1.1)             1






OPEN/CAESAR MANUAL                         caesar_rename_1(LOCAL)



     where:


     -    \nnnn denotes the newline character;

     -    <<<<bbbbllllaaaannnnkkkkssss>>>> is any sequence of spaces,  tabulations,  car-
          riage  returns, newlines, vertical tabulations, or form
          feeds; these characters are  those  recognised  by  the
          POSIX  function  iiiissssssssppppaaaacccceeee(((()))); they are always skipped and
          ignored;

     -    <<<<eeeemmmmppppttttyyyy>>>> denotes the empty sequence;

     -    <<<<lllleeeefffftttt----rrrreeeeggggeeeexxxxpppp>>>> is a character string specifying a  regu-
          lar expression according to the definition given in the
          rrrreeeeggggeeeexxxxpppp(LOCAL) manual page.  The  <<<<lllleeeefffftttt----rrrreeeeggggeeeexxxxpppp>>>>  may  be
          enclosed  between  double quotes, which will be removed
          and ignored.

     -    <<<<rrrriiiigggghhhhtttt----rrrreeeeggggeeeexxxxpppp>>>>  is  a  character  string  specifying  a
          ``replacement''  expression according to the definition
          given in the manual page  of  the  POSIX  rrrreeeeggggeeeexxxxpppp((((LLLLOOOOCCCCAAAALLLL))))
          command. The <<<<rrrriiiigggghhhhtttt----rrrreeeeggggeeeexxxxpppp>>>> can be surrounded by double
          quotes, which will be removed and ignored.

     Note: renaming files  are  case  sensitive:  upper-case  and
     lower-case letters are considered to be different.

     Note: in the <<<<rrrreeeennnnaaaammmmiiiinnnngggg----lllliiiisssstttt>>>>, lines that are empty  or  con-
     tain only blanks will be ignored.

     Semantically, a renaming file behaves as function that  maps
     a character string S (presumably representing the label of a
     transition) to another character string (the renamed label).

     More precisely, the effect of a renaming file F on a charac-
     ter string S is defined as follows. The <<<<rrrreeeennnnaaaammmmiiiinnnngggg----lllliiiisssstttt>>>> of S
     is scanned from top to bottom  in  order  to  determine  the
     first <<<<lllleeeefffftttt----rrrreeeeggggeeeexxxxpppp>>>> matched by S. If this <<<<lllleeeefffftttt----rrrreeeeggggeeeexxxxpppp>>>> does
     not exist, S is kept unchanged. If  it  exists,  S  will  be
     renamed  into  the corresponding <<<<rrrriiiigggghhhhtttt----rrrreeeeggggeeeexxxxpppp>>>>. Renaming is
     performed according to the conventions for text substitution
     defined in the POSIX command rrrreeeeggggeeeexxxxpppp((((LLLLOOOOCCCCAAAALLLL)))).

     Note: If S matches several <<<<lllleeeefffftttt----rrrreeeeggggeeeexxxxpppp>>>>s,  only  the  first
     one  is  taken  into  account.  Renamings  do  not  cumulate
     (although such behaviour can  be  explicitly  programmed  by
     invoking function CCCCAAAAEEEESSSSAAAARRRR____AAAAPPPPPPPPLLLLYYYY____RRRREEEENNNNAAAAMMMMEEEE____1111(((()))) several times).

     For instance, the following file:





(C) INRIA     Last change: 2020/02/11 (version 1.1)             2






OPEN/CAESAR MANUAL                         caesar_rename_1(LOCAL)



        rrrreeeennnnaaaammmmeeee
        GGGGEEEETTTT ---->>>> PPPPUUUUTTTT
        PPPPUUUUTTTT ---->>>> GGGGEEEETTTT

     will swap the labels named """"GGGGEEEETTTT"""" and """"PPPPUUUUTTTT"""".  Similarly,  the
     following file:


        rrrreeeennnnaaaammmmeeee
        """"PPPPUUUUTTTT !!!!\\\\(((([[[[AAAA----ZZZZ]]]]****\\\\)))) !!!!\\\\(((([[[[AAAA----ZZZZ]]]]****\\\\))))"""" ---->>>> """"PPPPUUUUTTTT !!!!\\\\2222 !!!!\\\\1111""""

     will swap the offers of """"PPPPUUUUTTTT"""" labels, e.g., """"PPPPUUUUTTTT !!!!AAAABBBBCCCC  !!!!XXXXYYYYZZZZ""""
     will be renamed into """"PPPPUUUUTTTT !!!!XXXXYYYYZZZZ !!!!AAAABBBBCCCC"""".


GGGGEEEENNNNEEEERRRRAAAALLLLIIIIZZZZEEEEDDDD RRRREEEENNNNAAAAMMMMIIIINNNNGGGG FFFFIIIILLLLEEEESSSS
     The above format for renaming files is the one used  in  the
     _C_A_D_P   toolbox   for   renaming   labels   selectively.  The
     ``rename_1'' library of _O_P_E_N/_C_A_E_S_A_R  supports  this  format,
     while  providing  additional  flexibility, in several direc-
     tions:


     -    The ``rename_1'' library  allows  to  parameterize  the
          definition  of  <<<<hhhheeeeaaaaddddeeeerrrr>>>>,  which  can therefore be dif-
          ferent from """"rrrreeeennnnaaaammmmeeee"""". The value of <<<<hhhheeeeaaaaddddeeeerrrr>>>>  is  deter-
          mined  by  a  regular expression passed as parameter to
          function CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTEEEE____RRRREEEENNNNAAAAMMMMEEEE____1111(((()))) (see below).

     -    The ``rename_1''  library  also  allows  files  without
          <<<<hhhheeeeaaaaddddeeeerrrr>>>>.  This  special case is obtained by giving the
          NNNNUUUULLLLLLLL value to the corresponding parameter  in  function
          CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTEEEE____RRRREEEENNNNAAAAMMMMEEEE____1111(((()))).  In such case, the <<<<aaaaxxxxiiiioooommmm>>>> of
          the grammar is simply defined as <<<<rrrreeeennnnaaaammmmiiiinnnngggg----lllliiiisssstttt>>>>, which
          does not change the semantics.

     -    The ``rename_1'' library allows four possibilities  for
          renaming  a  character  string  S according to a <<<<lllleeeefffftttt----
          rrrreeeeggggeeeexxxxpppp>>>> R: _t_o_t_a_l _m_a_t_c_h_i_n_g (S should match  R  entirely,
          otherwise  renaming  does  not  occur),  _s_i_n_g_l_e _p_a_r_t_i_a_l
          _m_a_t_c_h_i_n_g (renaming is  performed  for  the  first  sub-
          string  of S that matches R), _m_u_l_t_i_p_l_e _p_a_r_t_i_a_l _m_a_t_c_h_i_n_g
          (renaming is performed for every sub-string of  S  that
          matches  R),  or  _g_a_t_e  _m_a_t_c_h_i_n_g (renaming is only per-
          formed for the first word of S and only if  this  first
          word matches R, the remaining part of S being unchanged
          in any case; the first word  of  S  is  the  sub-string
          starting  at the beginning of S and ending at the first
          character !!!!, ????, ((((, space, or tabulation, if any, or  at
          the  end of S otherwise; in the case where S is a LOTOS
          label, the first word of S denotes a LOTOS  gate  iden-
          tifier).   The  choice  between  these possibilities is



(C) INRIA     Last change: 2020/02/11 (version 1.1)             3






OPEN/CAESAR MANUAL                         caesar_rename_1(LOCAL)



          determined by the value of an actual  parameter  passed
          to   function  CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTEEEE____RRRREEEENNNNAAAAMMMMEEEE____1111(((()))).  The  renaming
          files used in the _C_A_D_P toolbox follow the  total  match
          semantics.

DDDDEEEESSSSCCCCRRRRIIIIPPPPTTTTIIIIOOOONNNN
     The ``rename_1'' library allows to process  one  or  several
     renaming files at the same time. Each renaming file is read,
     parsed and checked; if  correct,  its  contents  are  stored
     (under  a compiled form) in a data structure called ``renam-
     ing object''. Afterwards, the renaming  file  will  only  be
     handled  through  a  pointer  to  its corresponding renaming
     object.


FFFFEEEEAAAATTTTUUUURRRREEEESSSS
      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____RRRREEEENNNNAAAAMMMMEEEE____1111

     ttttyyyyppppeeeeddddeeeeffff CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____AAAABBBBSSSSTTTTRRRRAAAACCCCTTTT ((((............)))) CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____RRRREEEENNNNAAAAMMMMEEEE____1111;;;;

     This type denotes a pointer to the  concrete  representation
     of a renaming object, which is supposed to be ``opaque''.

      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTEEEE____RRRREEEENNNNAAAAMMMMEEEE____1111

     vvvvooooiiiidddd CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTEEEE____RRRREEEENNNNAAAAMMMMEEEE____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____RRRR,,,, CCCCAAAAEEEESSSSAAAARRRR____PPPPAAAATTTTHHHHNNNNAAAAMMMMEEEE,,,, CCCCAAAAEEEESSSSAAAARRRR____HHHHEEEEAAAADDDDEEEERRRR,,,,
                                  CCCCAAAAEEEESSSSAAAARRRR____KKKKIIIINNNNDDDD))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____RRRREEEENNNNAAAAMMMMEEEE____1111 ****CCCCAAAAEEEESSSSAAAARRRR____RRRR;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSTTTTRRRRIIIINNNNGGGG CCCCAAAAEEEESSSSAAAARRRR____PPPPAAAATTTTHHHHNNNNAAAAMMMMEEEE;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSTTTTRRRRIIIINNNNGGGG CCCCAAAAEEEESSSSAAAARRRR____HHHHEEEEAAAADDDDEEEERRRR;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL CCCCAAAAEEEESSSSAAAARRRR____KKKKIIIINNNNDDDD;;;;
        {{{{ ............ }}}}

     This   procedure   allocates   a   renaming   object   using
     CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTEEEE(((()))) and assigns its address to ****CCCCAAAAEEEESSSSAAAARRRR____RRRR. If the
     allocation fails, the NNNNUUUULLLLLLLL value is assigned to ****CCCCAAAAEEEESSSSAAAARRRR____RRRR.

     Note: because CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____RRRREEEENNNNAAAAMMMMEEEE____1111 is a  pointer  type,  any
     variable CCCCAAAAEEEESSSSAAAARRRR____RRRR of type CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____RRRREEEENNNNAAAAMMMMEEEE____1111 must be allo-
     cated before used, for instance using:

               CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTEEEE____RRRREEEENNNNAAAAMMMMEEEE____1111 ((((&&&&CCCCAAAAEEEESSSSAAAARRRR____RRRR,,,, ............))));;;;


     The actual value of  the  formal  parameter  CCCCAAAAEEEESSSSAAAARRRR____PPPPAAAATTTTHHHHNNNNAAAAMMMMEEEE
     denotes  a  character string containing the file name of the
     renaming file. If the file name has a suffix (see above  for
     a discussion about suffixes for renaming files), this suffix



(C) INRIA     Last change: 2020/02/11 (version 1.1)             4






OPEN/CAESAR MANUAL                         caesar_rename_1(LOCAL)



     should be part of the character string  CCCCAAAAEEEESSSSAAAARRRR____PPPPAAAATTTTHHHHNNNNAAAAMMMMEEEE  (no
     suffix will be added implicitly). The renaming file referred
     to by CCCCAAAAEEEESSSSAAAARRRR____PPPPAAAATTTTHHHHNNNNAAAAMMMMEEEE should exist and be readable.

     As a special case, if CCCCAAAAEEEESSSSAAAARRRR____PPPPAAAATTTTHHHHNNNNAAAAMMMMEEEE is equal to NNNNUUUULLLLLLLL, then
     the renaming file will be read from the standard input.

     The actual  value  of  the  formal  parameter  CCCCAAAAEEEESSSSAAAARRRR____HHHHEEEEAAAADDDDEEEERRRR
     denotes  a  character string containing a regular expression
     according to the definition given in the manual page of  the
     POSIX  rrrreeeeggggeeeexxxxpppp((((LLLLOOOOCCCCAAAALLLL)))) command. This regular expression speci-
     fies the <<<<hhhheeeeaaaaddddeeeerrrr>>>> that must occur at the first line  of  the
     renaming file.

     As a special case, if CCCCAAAAEEEESSSSAAAARRRR____HHHHEEEEAAAADDDDEEEERRRR is equal to  NNNNUUUULLLLLLLL,  then
     the renaming file should have no header line.

     The actual value of the formal parameter CCCCAAAAEEEESSSSAAAARRRR____KKKKIIIINNNNDDDD  should
     be equal to 0 if total matching is desired, to 1 if multiple
     partial matching is desired, to 2 if single partial matching
     is  desired,  or to 3 if gate matching is desired (see above
     for a definition of these terms).

     The  renaming  file  is  parsed:  its  <<<<lllleeeefffftttt----rrrreeeeggggeeeexxxxpppp>>>>'s   and
     <<<<rrrriiiigggghhhhtttt----rrrreeeeggggeeeexxxxpppp>>>>'s  are  analyzed and stored (under a compiled
     form) into the renaming object ****CCCCAAAAEEEESSSSAAAARRRR____RRRR.

     So doing, various error conditions may occur:  the  renaming
     file  can  not  be open; it is empty, or the first line does
     not   match   the   header   specified   by   CCCCAAAAEEEESSSSAAAARRRR____HHHHEEEEAAAADDDDEEEERRRR;
     CCCCAAAAEEEESSSSAAAARRRR____HHHHEEEEAAAADDDDEEEERRRR  is not a valid regular expression; the renam-
     ing file has syntax errors; it contains  some  <<<<lllleeeefffftttt----rrrreeeeggggeeeexxxxpppp>>>>
     (resp.  some  rrrriiiigggghhhhtttt----rrrreeeeggggeeeexxxxpppp>>>>  that  is  not  a  valid regular
     expression  (resp.  replacement);  etc.  In  such  case,   a
     detailed    error    message    is   displayed   using   the
     CCCCAAAAEEEESSSSAAAARRRR____WWWWAAAARRRRNNNNIIIINNNNGGGG(((()))) procedure, and the NNNNUUUULLLLLLLL value  is  assigned
     to ****CCCCAAAAEEEESSSSAAAARRRR____RRRR.

      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____HHHHEEEEAAAADDDDEEEERRRR____RRRREEEENNNNAAAAMMMMEEEE____1111

     ####ddddeeeeffffiiiinnnneeee CCCCAAAAEEEESSSSAAAARRRR____HHHHEEEEAAAADDDDEEEERRRR____RRRREEEENNNNAAAAMMMMEEEE____1111 """"rrrreeeennnnaaaammmmeeee""""

     This macro-definition returns the standard  header  for  the
     renaming files used in the _C_A_D_P toolbox (see above). In such
     case, this macro-definition should  be  used  as  an  actual
     value  for  parameter  CCCCAAAAEEEESSSSAAAARRRR____HHHHEEEEAAAADDDDEEEERRRR  when invoking function
     CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTEEEE____RRRREEEENNNNAAAAMMMMEEEE____1111.

      ............................................................




(C) INRIA     Last change: 2020/02/11 (version 1.1)             5






OPEN/CAESAR MANUAL                         caesar_rename_1(LOCAL)



  CCCCAAAAEEEESSSSAAAARRRR____DDDDEEEELLLLEEEETTTTEEEE____RRRREEEENNNNAAAAMMMMEEEE____1111

     vvvvooooiiiidddd CCCCAAAAEEEESSSSAAAARRRR____DDDDEEEELLLLEEEETTTTEEEE____RRRREEEENNNNAAAAMMMMEEEE____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____RRRR))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____RRRREEEENNNNAAAAMMMMEEEE____1111 ****CCCCAAAAEEEESSSSAAAARRRR____RRRR;;;;
        {{{{ ............ }}}}

     This procedure frees the memory space corresponding  to  the
     renaming    object    pointed    to   by   ****CCCCAAAAEEEESSSSAAAARRRR____RRRR   using
     CCCCAAAAEEEESSSSAAAARRRR____DDDDEEEELLLLEEEETTTTEEEE(((()))). Afterwards, the NNNNUUUULLLLLLLL value is  assigned  to
     ****CCCCAAAAEEEESSSSAAAARRRR____RRRR.

      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____AAAAPPPPPPPPLLLLYYYY____RRRREEEENNNNAAAAMMMMEEEE____1111

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSTTTTRRRRIIIINNNNGGGG CCCCAAAAEEEESSSSAAAARRRR____AAAAPPPPPPPPLLLLYYYY____RRRREEEENNNNAAAAMMMMEEEE____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____RRRR,,,, CCCCAAAAEEEESSSSAAAARRRR____SSSS))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____RRRREEEENNNNAAAAMMMMEEEE____1111 CCCCAAAAEEEESSSSAAAARRRR____RRRR;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSTTTTRRRRIIIINNNNGGGG CCCCAAAAEEEESSSSAAAARRRR____SSSS;;;;
        {{{{ ............ }}}}

     This  function  attempts  to  rename  the  character  string
     CCCCAAAAEEEESSSSAAAARRRR____SSSS  according  to  the  renaming  object pointed to by
     CCCCAAAAEEEESSSSAAAARRRR____RRRR.

     If renaming succeeds,  this  function  returns  a  character
     string  containing  the  renamed string. The address of this
     character string is left unspecified, but it is  assumed  to
     be different from CCCCAAAAEEEESSSSAAAARRRR____SSSS.

     If renaming fails, this function  returns  CCCCAAAAEEEESSSSAAAARRRR____SSSS.  It  is
     therefore  possible  to decide whether renaming succeeded or
     not, by comparing the result to the second parameter  passed
     to CCCCAAAAEEEESSSSAAAARRRR____AAAAPPPPPPPPLLLLYYYY____RRRREEEENNNNAAAAMMMMEEEE____1111.

     Note: in any case, the contents  of  CCCCAAAAEEEESSSSAAAARRRR____SSSS  will  not  be
     modified (there is no side effect).

     Note: when renaming succeeds, it is not  allowed  to  modify
     the character string returned by CCCCAAAAEEEESSSSAAAARRRR____AAAAPPPPPPPPLLLLYYYY____RRRREEEENNNNAAAAMMMMEEEE____1111(((()))) nor
     to free it, for instance using ffffrrrreeeeeeee((((3333)))).

     Note: when renaming succeeds, the contents of the  character
     string  returned by CCCCAAAAEEEESSSSAAAARRRR____AAAAPPPPPPPPLLLLYYYY____RRRREEEENNNNAAAAMMMMEEEE____1111(((()))) may be destroyed
     by a subsequent call to this function. In particular, it  is
     forbidden  to  call  CCCCAAAAEEEESSSSAAAARRRR____AAAAPPPPPPPPLLLLYYYY____RRRREEEENNNNAAAAMMMMEEEE____1111(((())))  by  giving  to
     CCCCAAAAEEEESSSSAAAARRRR____SSSS  the  value  returned   by   a   former   call   to
     CCCCAAAAEEEESSSSAAAARRRR____AAAAPPPPPPPPLLLLYYYY____RRRREEEENNNNAAAAMMMMEEEE____1111(((())))  for  which  renaming succeeded. For
     instance, the following call is  forbidden  in  the  general
     case:


    CCCCAAAAEEEESSSSAAAARRRR____AAAAPPPPPPPPLLLLYYYY____RRRREEEENNNNAAAAMMMMEEEE____1111 ((((............,,,, CCCCAAAAEEEESSSSAAAARRRR____AAAAPPPPPPPPLLLLYYYY____RRRREEEENNNNAAAAMMMMEEEE____1111 ((((............,,,, ............))))))));;;;



(C) INRIA     Last change: 2020/02/11 (version 1.1)             6






OPEN/CAESAR MANUAL                         caesar_rename_1(LOCAL)





      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____FFFFOOOORRRRMMMMAAAATTTT____RRRREEEENNNNAAAAMMMMEEEE____1111

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____FFFFOOOORRRRMMMMAAAATTTT CCCCAAAAEEEESSSSAAAARRRR____FFFFOOOORRRRMMMMAAAATTTT____RRRREEEENNNNAAAAMMMMEEEE____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____RRRR,,,, CCCCAAAAEEEESSSSAAAARRRR____FFFFOOOORRRRMMMMAAAATTTT))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____RRRREEEENNNNAAAAMMMMEEEE____1111 CCCCAAAAEEEESSSSAAAARRRR____RRRR;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____FFFFOOOORRRRMMMMAAAATTTT CCCCAAAAEEEESSSSAAAARRRR____FFFFOOOORRRRMMMMAAAATTTT;;;;
        {{{{ ............ }}}}

     This function allows to control the format under  which  the
     renaming  object  pointed  to by CCCCAAAAEEEESSSSAAAARRRR____RRRR will be printed by
     the   procedure   CCCCAAAAEEEESSSSAAAARRRR____PPPPRRRRIIIINNNNTTTT____RRRREEEENNNNAAAAMMMMEEEE____1111(((())))    (see    below).
     Currently, the following formats are available:


     -    With format 0, information about the renaming object is
          displayed  such  as:  the pathname of the corresponding
          renaming file, the header (if any), the number of  pat-
          terns, the list of left and right patterns, etc.

     -    (no other format available yet).

     By default, the current format of each  renaming  object  is
     initialized to 0.

     When called with CCCCAAAAEEEESSSSAAAARRRR____FFFFOOOORRRRMMMMAAAATTTT between 0 and 0,  this  fonc-
     tion  sets  the  current format of CCCCAAAAEEEESSSSAAAARRRR____RRRR to CCCCAAAAEEEESSSSAAAARRRR____FFFFOOOORRRRMMMMAAAATTTT
     and returns an undefined result.

     When called with another value of CCCCAAAAEEEESSSSAAAARRRR____FFFFOOOORRRRMMMMAAAATTTT, this  func-
     tion  does  not  modify  the  current format of CCCCAAAAEEEESSSSAAAARRRR____RRRR but
     returns a result defined as  follows.  If  CCCCAAAAEEEESSSSAAAARRRR____FFFFOOOORRRRMMMMAAAATTTT  is
     equal  to  the constant CCCCAAAAEEEESSSSAAAARRRR____CCCCUUUURRRRRRRREEEENNNNTTTT____FFFFOOOORRRRMMMMAAAATTTT, the result is
     the  value  of  the   current   format   of   CCCCAAAAEEEESSSSAAAARRRR____RRRR.   If
     CCCCAAAAEEEESSSSAAAARRRR____FFFFOOOORRRRMMMMAAAATTTT      is      equal     to     the     constant
     CCCCAAAAEEEESSSSAAAARRRR____MMMMAAAAXXXXIIIIMMMMAAAALLLL____FFFFOOOORRRRMMMMAAAATTTT, the  result  is  the  maximal  format
     value  (i.e.,  0).  In  all  other cases, the effect of this
     function is undefined.

      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____MMMMAAAAXXXX____FFFFOOOORRRRMMMMAAAATTTT____RRRREEEENNNNAAAAMMMMEEEE____1111

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____FFFFOOOORRRRMMMMAAAATTTT CCCCAAAAEEEESSSSAAAARRRR____MMMMAAAAXXXX____FFFFOOOORRRRMMMMAAAATTTT____RRRREEEENNNNAAAAMMMMEEEE____1111 (((())))
        {{{{ ............ }}}}

     Caution! This function is deprecated. It should no longer be
     used,  as  it  might  be removed from future versions of the
     _O_P_E_N/_C_A_E_S_A_R. Use function CCCCAAAAEEEESSSSAAAARRRR____FFFFOOOORRRRMMMMAAAATTTT____RRRREEEENNNNAAAAMMMMEEEE____1111(((())))  instead,
     called with argument CCCCAAAAEEEESSSSAAAARRRR____MMMMAAAAXXXXIIIIMMMMAAAALLLL____FFFFOOOORRRRMMMMAAAATTTT.



(C) INRIA     Last change: 2020/02/11 (version 1.1)             7






OPEN/CAESAR MANUAL                         caesar_rename_1(LOCAL)



     This function returns the maximal format value available for
     printing renaming objects.

      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____PPPPRRRRIIIINNNNTTTT____RRRREEEENNNNAAAAMMMMEEEE____1111

     vvvvooooiiiidddd CCCCAAAAEEEESSSSAAAARRRR____PPPPRRRRIIIINNNNTTTT____RRRREEEENNNNAAAAMMMMEEEE____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____FFFFIIIILLLLEEEE,,,, CCCCAAAAEEEESSSSAAAARRRR____RRRR))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____FFFFIIIILLLLEEEE CCCCAAAAEEEESSSSAAAARRRR____FFFFIIIILLLLEEEE;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____RRRREEEENNNNAAAAMMMMEEEE____1111 CCCCAAAAEEEESSSSAAAARRRR____RRRR;;;;
        {{{{ ............ }}}}

     This procedure prints to file CCCCAAAAEEEESSSSAAAARRRR____FFFFIIIILLLLEEEE a text  containing
     information   about   the  renaming  object  pointed  to  by
     CCCCAAAAEEEESSSSAAAARRRR____RRRR. The nature of the information is determined by the
     current   format  of  the  renaming  object  pointed  to  by
     CCCCAAAAEEEESSSSAAAARRRR____RRRR.

     Before this procedure is called, CCCCAAAAEEEESSSSAAAARRRR____FFFFIIIILLLLEEEE must have  been
     properly opened, for instance using ffffooooppppeeeennnn((((3333)))).

      ............................................................

AAAAUUUUTTTTHHHHOOOORRRR((((SSSS))))
     Hubert Garavel

FFFFIIIILLLLEEEESSSS
     $$$$CCCCAAAADDDDPPPP////iiiinnnnccccllll////ccccaaaaeeeessssaaaarrrr____ggggrrrraaaapppphhhh....hhhh     interface of the graph module
     $$$$CCCCAAAADDDDPPPP////iiiinnnnccccllll////ccccaaaaeeeessssaaaarrrr____****....hhhh         interfaces  of   the   storage
                                   module
     $$$$CCCCAAAADDDDPPPP////bbbbiiiinnnn....````aaaarrrrcccchhhh````////lllliiiibbbbccccaaaaeeeessssaaaarrrr....aaaa  object  code  of  the  storage
                                   module
     $$$$CCCCAAAADDDDPPPP////ssssrrrrcccc////ooooppppeeeennnn____ccccaaaaeeeessssaaaarrrr////****....cccc     source   code    of    various
                                   exploration modules
     $$$$CCCCAAAADDDDPPPP////ccccoooommmm////lllloooottttoooossss....ooooppppeeeennnn          shell    script     to     run
                                   OPEN/CAESAR

SSSSEEEEEEEE AAAALLLLSSSSOOOO
     Reference Manuals of OPEN/CAESAR,  CAESAR,  and  CAESAR.ADT,
     lllloooottttoooossss....ooooppppeeeennnn(LOCAL), ccccaaaaeeeessssaaaarrrr(LOCAL), ccccaaaaeeeessssaaaarrrr....aaaaddddtttt(LOCAL)

     Additional information is available from the CADP  Web  page
     located at http://cadp.inria.fr

     Directives   for   installation   are   given    in    files
     $$$$CCCCAAAADDDDPPPP////IIIINNNNSSSSTTTTAAAALLLLLLLLAAAATTTTIIIIOOOONNNN____****....

     Recent  changes  and  improvements  to  this  software   are
     reported and commented in file $$$$CCCCAAAADDDDPPPP////HHHHIIIISSSSTTTTOOOORRRRYYYY....

BBBBUUUUGGGGSSSS
     Known  bugs  are  described  in  the  Reference  Manual   of



(C) INRIA     Last change: 2020/02/11 (version 1.1)             8






OPEN/CAESAR MANUAL                         caesar_rename_1(LOCAL)



     OPEN/CAESAR.  Please report new bugs to cadp@inria.fr






















































(C) INRIA     Last change: 2020/02/11 (version 1.1)             9



