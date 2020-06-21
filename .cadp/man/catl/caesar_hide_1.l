


OPEN/CAESAR MANUAL                           caesar_hide_1(LOCAL)



NNNNAAAAMMMMEEEE
     caesar_hide_1 - the ``hide_1'' library of OPEN/CAESAR

PPPPUUUURRRRPPPPOOOOSSSSEEEE
     The ``hide_1'' library provides  primitives  for  processing
     ``hiding  files''.  These  files  specify  which labels of a
     graph should be hidden  (i.e.,  renamed  into  the  internal
     action ``i'', or tau) using a set of regular expressions.


UUUUSSSSAAAAGGGGEEEE
     The ``hide_1'' library consists of:

     -    a predefined header file ccccaaaaeeeessssaaaarrrr____hhhhiiiiddddeeee____1111....hhhh;

     -    the precompiled library file lllliiiibbbbccccaaaaeeeessssaaaarrrr....aaaa, which  imple-
          ments the features described in ccccaaaaeeeessssaaaarrrr____hhhhiiiiddddeeee____1111....hhhh.

     Note: The ``hide_1'' library is a software layer built above
     the primitives offered by the ``standard'' library.


HHHHIIIIDDDDIIIINNNNGGGG FFFFIIIILLLLEEEESSSS
     In this section, we define the format of  hiding  files,  as
     they  are  used  in the _C_A_D_P toolbox. The next sections will
     explain how the ``hide_1'' library of  _O_P_E_N/_C_A_E_S_A_R  supports
     (and extends) this format.

     A hiding file is a text file containing a  set  of  ``hiding
     patterns''.  There is no mandatory suffix (i.e., file exten-
     sion) for hiding files: any file name can be used;  however,
     it  is  recommended  to  use  one  of the following suffixes
     ``.hid'' (recommended) or ``.hide''.

     The syntax of hiding files is  described  by  the  following
     context-free grammar:


          <<<<aaaaxxxxiiiioooommmm>>>> ::::::::==== <<<<bbbbllllaaaannnnkkkkssss>>>> <<<<ppppoooossssiiiittttiiiivvvveeee----hhhheeeeaaaaddddeeeerrrr>>>> <<<<bbbbllllaaaannnnkkkkssss>>>> \\\\nnnn <<<<ppppaaaatttttttteeeerrrrnnnn----lllliiiisssstttt>>>>
                   ||||  <<<<bbbbllllaaaannnnkkkkssss>>>> <<<<nnnneeeeggggaaaattttiiiivvvveeee----hhhheeeeaaaaddddeeeerrrr>>>> <<<<bbbbllllaaaannnnkkkkssss>>>> \\\\nnnn <<<<ppppaaaatttttttteeeerrrrnnnn----lllliiiisssstttt>>>>

          <<<<ppppoooossssiiiittttiiiivvvveeee----hhhheeeeaaaaddddeeeerrrr>>>> ::::::::==== hhhhiiiiddddeeee

          <<<<nnnneeeeggggaaaattttiiiivvvveeee----hhhheeeeaaaaddddeeeerrrr>>>> ::::::::==== hhhhiiiiddddeeee aaaallllllll bbbbuuuutttt

          <<<<ppppaaaatttttttteeeerrrrnnnn----lllliiiisssstttt>>>> ::::::::==== <<<<eeeemmmmppppttttyyyy>>>>
                          ||||  <<<<ppppaaaatttttttteeeerrrrnnnn>>>> <<<<ppppaaaatttttttteeeerrrrnnnn----lllliiiisssstttt>>>>

          <<<<ppppaaaatttttttteeeerrrrnnnn>>>> ::::::::==== <<<<bbbbllllaaaannnnkkkkssss>>>> <<<<rrrreeeeggggeeeexxxxpppp>>>> <<<<bbbbllllaaaannnnkkkkssss>>>> \\\\nnnn
                     ||||  <<<<bbbbllllaaaannnnkkkkssss>>>> """"<<<<rrrreeeeggggeeeexxxxpppp>>>>"""" <<<<bbbbllllaaaannnnkkkkssss>>>> \\\\nnnn

     where:



(C) INRIA     Last change: 2020/02/11 (version 1.1)             1






OPEN/CAESAR MANUAL                           caesar_hide_1(LOCAL)



     -    \nnnn denotes the newline character;

     -    <<<<bbbbllllaaaannnnkkkkssss>>>> is any sequence of spaces,  tabulations,  car-
          riage  returns, newlines, vertical tabulations, or form
          feeds; these characters are  those  recognized  by  the
          POSIX  function  iiiissssssssppppaaaacccceeee(((()))); they are always skipped and
          ignored;

     -    <<<<eeeemmmmppppttttyyyy>>>> denotes the empty sequence;

     -    <<<<rrrreeeeggggeeeexxxxpppp>>>> is a character  string  specifying  a  regular
          expression  according  to  the  definition given in the
          rrrreeeeggggeeeexxxxpppp(LOCAL) manual page. The <<<<rrrreeeeggggeeeexxxxpppp>>>> may be enclosed
          between  double  quotes,  which  will  be  removed  and
          ignored.

     Note:  hiding  files  are  case  sensitive:  upper-case  and
     lower-case letters are considered to be different.

     Note: in the <<<<ppppaaaatttttttteeeerrrrnnnn----lllliiiisssstttt>>>>, lines that are empty or contain
     only blanks will be ignored.

     Semantically, a hiding file  behaves  as  a  predicate  that
     decides  whether a character string (presumably representing
     the label of a transition) belongs to  a  set  of  patterns.
     Depending  on the first line of the hiding file (positive or
     negative header), a label will be hidden (i.e., renamed into
     the  internal action ``i'', often referred to as ``tau'') if
     recognized (or vice-versa). More precisely, the effect of  a
     hiding file F is defined as follows:


     -    If the first line of F is equal  to  """"hhhhiiiiddddeeee"""",  then  any
          character   string   S   that  matches  one  (or  more)
          <<<<rrrreeeeggggeeeexxxxpppp>>>>(s) contained in F will be hidden; if S matches
          no <<<<rrrreeeeggggeeeexxxxpppp>>>>, it will be kept unchanged.

     -    If the first line of F is equal to """"hhhhiiiiddddeeee aaaallllllll bbbbuuuutttt"""", then
          any  character  string  S that matches no <<<<rrrreeeeggggeeeexxxxpppp>>>> con-
          tained in F will be hidden; if S matches one (or  more)
          <<<<rrrreeeeggggeeeexxxxpppp>>>>(s), it will be kept unchanged.

     For instance, the following file:


        hhhhiiiiddddeeee
        GGGGEEEETTTT
        """"AAAACCCCKKKK !!!!ffffaaaallllsssseeee ....****""""

     will hide all character strings equal to """"GGGGEEEETTTT""""  or  prefixed
     with """"AAAACCCCKKKK !!!!ffffaaaallllsssseeee """". Similarly, the following file:




(C) INRIA     Last change: 2020/02/11 (version 1.1)             2






OPEN/CAESAR MANUAL                           caesar_hide_1(LOCAL)




        hhhhiiiiddddeeee aaaallllllll bbbbuuuutttt
        """"PPPPUUUUTTTT ....****""""

     will hide all character strings except those  prefixed  with
     """"PPPPUUUUTTTT """".


GGGGEEEENNNNEEEERRRRAAAALLLLIIIIZZZZEEEEDDDD HHHHIIIIDDDDIIIINNNNGGGG FFFFIIIILLLLEEEESSSS
     The above format for hiding files is the  one  used  in  the
     _C_A_D_P  toolbox  for hiding labels selectively. The ``hide_1''
     library of _O_P_E_N/_C_A_E_S_A_R supports this format, while providing
     additional flexibility, in several directions:


     -    The ``hide_1'' library does not hide labels itself:  it
          simply  implements  the  predicate function that deter-
          mines whether a character string (representing a label)
          matches  or  not  some of the <<<<rrrreeeeggggeeeexxxxpppp>>>>'s contained in a
          file  F.  On  the  basis  of  this   information,   the
          _O_P_E_N/_C_A_E_S_A_R  programmer  is  free to hide the label, or
          perform any other  action  (for  instance,  distinguish
          between input and output labels).

     -    The  ``hide_1''  library  allows  to  parameterize  the
          definition  of <<<<ppppoooossssiiiittttiiiivvvveeee----hhhheeeeaaaaddddeeeerrrr>>>> and <<<<nnnneeeeggggaaaattttiiiivvvveeee----hhhheeeeaaaaddddeeeerrrr>>>>.
          These symbols can be different from  """"hhhhiiiiddddeeee""""  and  """"hhhhiiiiddddeeee
          aaaallllllll  bbbbuuuutttt"""";  for  instance,  they  could  be replaced by
          """"iiiinnnnppppuuuutttt"""" and """"oooouuuuttttppppuuuutttt"""". The values  of  <<<<ppppoooossssiiiittttiiiivvvveeee----hhhheeeeaaaaddddeeeerrrr>>>>
          and  <<<<nnnneeeeggggaaaattttiiiivvvveeee----hhhheeeeaaaaddddeeeerrrr>>>>  are  determined  by two regular
          expressions   passed   as   parameters   to    function
          CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTEEEE____HHHHIIIIDDDDEEEE____1111(((()))) (see below).

     -    The  ``hide_1''  library  also  allows  files   without
          <<<<ppppoooossssiiiittttiiiivvvveeee----hhhheeeeaaaaddddeeeerrrr>>>>  nor  <<<<nnnneeeeggggaaaattttiiiivvvveeee----hhhheeeeaaaaddddeeeerrrr>>>>. This special
          case is obtained  by  giving  the  NNNNUUUULLLLLLLL  value  to  the
          corresponding        parameters       in       function
          CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTEEEE____HHHHIIIIDDDDEEEE____1111(((()))). In such case,  the  <<<<aaaaxxxxiiiioooommmm>>>>  of
          the  grammar  is  simply  defined  as <<<<ppppaaaatttttttteeeerrrrnnnn----lllliiiisssstttt>>>>. A
          character string S will be recognized if it matches one
          of the <<<<rrrreeeeggggeeeexxxxpppp>>>>'s contained in the file.

     -    The ``hide_1'' library allows three  possibilities  for
          deciding   whether  a  character  string  S  matches  a
          <<<<rrrreeeeggggeeeexxxxpppp>>>> R: _t_o_t_a_l _m_a_t_c_h_i_n_g (S should match R entirely),
          _p_a_r_t_i_a_l  _m_a_t_c_h_i_n_g  (S  should contain a sub-string that
          matches R), or _g_a_t_e _m_a_t_c_h_i_n_g  (the  first  word  of  S,
          should  match R entirely, the remaining part of S being
          ignored; the first word of S is the sub-string starting
          at the beginning of S and ending at the first character
          !!!!, ????, ((((, space, or tabulation, if any, or at the end of
          S  otherwise; in the case where S is a LOTOS label, the



(C) INRIA     Last change: 2020/02/11 (version 1.1)             3






OPEN/CAESAR MANUAL                           caesar_hide_1(LOCAL)



          first word of S denotes a LOTOS gate identifier).   The
          choice between these possibilities is determined by the
          value  of  an  actual  parameter  passed  to   function
          CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTEEEE____HHHHIIIIDDDDEEEE____1111(((()))).  The  hiding  files used in the
          _C_A_D_P toolbox follow the total match semantics.

DDDDEEEESSSSCCCCRRRRIIIIPPPPTTTTIIIIOOOONNNN
     The ``hide_1'' library allows to process one or several hid-
     ing files at the same time. Each hiding file is read, parsed
     and checked; if correct, its contents are  stored  (under  a
     compiled form) in a data structure called ``hiding object''.
     Afterwards, the hiding file will only be handled  through  a
     pointer to its corresponding hiding object.


FFFFEEEEAAAATTTTUUUURRRREEEESSSS
      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____HHHHIIIIDDDDEEEE____1111

     ttttyyyyppppeeeeddddeeeeffff CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____AAAABBBBSSSSTTTTRRRRAAAACCCCTTTT ((((............)))) CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____HHHHIIIIDDDDEEEE____1111;;;;

     This type denotes a pointer to the  concrete  representation
     of a hiding object, which is supposed to be ``opaque''.

      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTEEEE____HHHHIIIIDDDDEEEE____1111

     vvvvooooiiiidddd CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTEEEE____HHHHIIIIDDDDEEEE____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____HHHH,,,, CCCCAAAAEEEESSSSAAAARRRR____PPPPAAAATTTTHHHHNNNNAAAAMMMMEEEE,,,, CCCCAAAAEEEESSSSAAAARRRR____PPPPOOOOSSSSIIIITTTTIIIIVVVVEEEE____HHHHEEEEAAAADDDDEEEERRRR,,,,
                                CCCCAAAAEEEESSSSAAAARRRR____NNNNEEEEGGGGAAAATTTTIIIIVVVVEEEE____HHHHEEEEAAAADDDDEEEERRRR,,,, CCCCAAAAEEEESSSSAAAARRRR____KKKKIIIINNNNDDDD))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____HHHHIIIIDDDDEEEE____1111 ****CCCCAAAAEEEESSSSAAAARRRR____HHHH;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSTTTTRRRRIIIINNNNGGGG CCCCAAAAEEEESSSSAAAARRRR____PPPPAAAATTTTHHHHNNNNAAAAMMMMEEEE;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSTTTTRRRRIIIINNNNGGGG CCCCAAAAEEEESSSSAAAARRRR____PPPPOOOOSSSSIIIITTTTIIIIVVVVEEEE____HHHHEEEEAAAADDDDEEEERRRR;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSTTTTRRRRIIIINNNNGGGG CCCCAAAAEEEESSSSAAAARRRR____NNNNEEEEGGGGAAAATTTTIIIIVVVVEEEE____HHHHEEEEAAAADDDDEEEERRRR;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL CCCCAAAAEEEESSSSAAAARRRR____KKKKIIIINNNNDDDD;;;;
        {{{{ ............ }}}}

     This   procedure   allocates   a   hiding    object    using
     CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTEEEE(((()))) and assigns its address to ****CCCCAAAAEEEESSSSAAAARRRR____HHHH. If the
     allocation fails, the NNNNUUUULLLLLLLL value is assigned to ****CCCCAAAAEEEESSSSAAAARRRR____HHHH.

     Note: because CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____HHHHIIIIDDDDEEEE____1111  is  a  pointer  type,  any
     variable  CCCCAAAAEEEESSSSAAAARRRR____HHHH  of type CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____HHHHIIIIDDDDEEEE____1111 must be allo-
     cated before used, for instance using:

                CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTEEEE____HHHHIIIIDDDDEEEE____1111 ((((&&&&CCCCAAAAEEEESSSSAAAARRRR____HHHH,,,, ............))));;;;


     The actual value of  the  formal  parameter  CCCCAAAAEEEESSSSAAAARRRR____PPPPAAAATTTTHHHHNNNNAAAAMMMMEEEE
     denotes  a  character string containing the file name of the
     hiding file. If the file name has a suffix (see above for  a



(C) INRIA     Last change: 2020/02/11 (version 1.1)             4






OPEN/CAESAR MANUAL                           caesar_hide_1(LOCAL)



     discussion  about  suffixes  for  hiding files), this suffix
     should be part of the character string  CCCCAAAAEEEESSSSAAAARRRR____PPPPAAAATTTTHHHHNNNNAAAAMMMMEEEE  (no
     suffix  will  be added implicitly). The hiding file referred
     to by CCCCAAAAEEEESSSSAAAARRRR____PPPPAAAATTTTHHHHNNNNAAAAMMMMEEEE should exist and be readable.

     As a special case, if CCCCAAAAEEEESSSSAAAARRRR____PPPPAAAATTTTHHHHNNNNAAAAMMMMEEEE is equal to NNNNUUUULLLLLLLL, then
     the hiding file will be read from the standard input.

     The    actual    value    of    the     formal     parameter
     CCCCAAAAEEEESSSSAAAARRRR____PPPPOOOOSSSSIIIITTTTIIIIVVVVEEEE____HHHHEEEEAAAADDDDEEEERRRR denotes a character string containing
     a regular expression according to the  definition  given  in
     the  manual  page  of  the POSIX rrrreeeeggggeeeexxxxpppp((((LLLLOOOOCCCCAAAALLLL)))) command. This
     regular expression specifies the <<<<ppppoooossssiiiittttiiiivvvveeee----hhhheeeeaaaaddddeeeerrrr>>>> that  may
     occur at the first line of the hiding file.

     The    actual    value    of    the     formal     parameter
     CCCCAAAAEEEESSSSAAAARRRR____NNNNEEEEGGGGAAAATTTTIIIIVVVVEEEE____HHHHEEEEAAAADDDDEEEERRRR denotes a character string containing
     a regular expression according to the  definition  given  in
     the  manual  page  of  the POSIX rrrreeeeggggeeeexxxxpppp((((LLLLOOOOCCCCAAAALLLL)))) command. This
     regular expression specifies the <<<<nnnneeeeggggaaaattttiiiivvvveeee----hhhheeeeaaaaddddeeeerrrr>>>> that  may
     occur at the first line of the hiding file.

     As  a  special  case,  if  both  CCCCAAAAEEEESSSSAAAARRRR____PPPPOOOOSSSSIIIITTTTIIIIVVVVEEEE____HHHHEEEEAAAADDDDEEEERRRR  and
     CCCCAAAAEEEESSSSAAAARRRR____NNNNEEEEGGGGAAAATTTTIIIIVVVVEEEE____HHHHEEEEAAAADDDDEEEERRRR  are  equal  to NNNNUUUULLLLLLLL, then the hiding
     file   should    have    no    header    line.    Otherwise,
     CCCCAAAAEEEESSSSAAAARRRR____PPPPOOOOSSSSIIIITTTTIIIIVVVVEEEE____HHHHEEEEAAAADDDDEEEERRRR   and  CCCCAAAAEEEESSSSAAAARRRR____NNNNEEEEGGGGAAAATTTTIIIIVVVVEEEE____HHHHEEEEAAAADDDDEEEERRRR  should
     both be different from NNNNUUUULLLLLLLL.

     Note: if the regular expressions CCCCAAAAEEEESSSSAAAARRRR____PPPPOOOOSSSSIIIITTTTIIIIVVVVEEEE____HHHHEEEEAAAADDDDEEEERRRR  and
     CCCCAAAAEEEESSSSAAAARRRR____NNNNEEEEGGGGAAAATTTTIIIIVVVVEEEE____HHHHEEEEAAAADDDDEEEERRRR are not exclusive (i.e., there exists
     at least one character  string  that  matches  both  regular
     expressions), then the effect is undefined.

     The actual value of the formal parameter CCCCAAAAEEEESSSSAAAARRRR____KKKKIIIINNNNDDDD  should
     be  equal to 0 if total matching is desired, to 1 if partial
     matching is desired, or to 2 if  gate  matching  is  desired
     (see above for a definition of these terms).

     The hiding file is parsed: its <<<<rrrreeeeggggeeeexxxxpppp>>>>'s are  analyzed  and
     stored  (under  a  compiled  form)  into  the  hiding object
     ****CCCCAAAAEEEESSSSAAAARRRR____HHHH.

     So doing, various error conditions  may  occur:  the  hiding
     file can not be open; it is empty, or the first line matches
     neither the header specified by  CCCCAAAAEEEESSSSAAAARRRR____PPPPOOOOSSSSIIIITTTTIIIIVVVVEEEE____HHHHEEEEAAAADDDDEEEERRRR  nor
     the     one     specified     by     CCCCAAAAEEEESSSSAAAARRRR____NNNNEEEEGGGGAAAATTTTIIIIVVVVEEEE____HHHHEEEEAAAADDDDEEEERRRR;
     CCCCAAAAEEEESSSSAAAARRRR____PPPPOOOOSSSSIIIITTTTIIIIVVVVEEEE____HHHHEEEEAAAADDDDEEEERRRR (resp. CCCCAAAAEEEESSSSAAAARRRR____NNNNEEEEGGGGAAAATTTTIIIIVVVVEEEE____HHHHEEEEAAAADDDDEEEERRRR) is not
     a  valid  regular  expression;  the  hiding  file has syntax
     errors; it contains some <<<<rrrreeeeggggeeeexxxxpppp>>>> that is not a valid  regu-
     lar  expression; etc. In such case, a detailed error message
     is displayed using the CCCCAAAAEEEESSSSAAAARRRR____WWWWAAAARRRRNNNNIIIINNNNGGGG(((()))) procedure,  and  the
     NNNNUUUULLLLLLLL value is assigned to ****CCCCAAAAEEEESSSSAAAARRRR____HHHH.



(C) INRIA     Last change: 2020/02/11 (version 1.1)             5






OPEN/CAESAR MANUAL                           caesar_hide_1(LOCAL)



      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____PPPPOOOOSSSSIIIITTTTIIIIVVVVEEEE____HHHHEEEEAAAADDDDEEEERRRR____HHHHIIIIDDDDEEEE____1111

     ####ddddeeeeffffiiiinnnneeee CCCCAAAAEEEESSSSAAAARRRR____PPPPOOOOSSSSIIIITTTTIIIIVVVVEEEE____HHHHEEEEAAAADDDDEEEERRRR____HHHHIIIIDDDDEEEE____1111 """"hhhhiiiiddddeeee""""

     This macro-definition returns the standard  positive  header
     for  the  hiding files used in the _C_A_D_P toolbox (see above).
     In such case, this macro-definition should  be  used  as  an
     actual   value  for  parameter  CCCCAAAAEEEESSSSAAAARRRR____PPPPOOOOSSSSIIIITTTTIIIIVVVVEEEE____HHHHEEEEAAAADDDDEEEERRRR  when
     invoking function CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTEEEE____HHHHIIIIDDDDEEEE____1111.

      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____NNNNEEEEGGGGAAAATTTTIIIIVVVVEEEE____HHHHEEEEAAAADDDDEEEERRRR____HHHHIIIIDDDDEEEE____1111

     ####ddddeeeeffffiiiinnnneeee CCCCAAAAEEEESSSSAAAARRRR____NNNNEEEEGGGGAAAATTTTIIIIVVVVEEEE____HHHHEEEEAAAADDDDEEEERRRR____HHHHIIIIDDDDEEEE____1111 """"hhhhiiiiddddeeee[[[[ \\\\tttt]]]][[[[ \\\\tttt]]]]****aaaallllllll[[[[ \\\\tttt]]]][[[[ \\\\tttt]]]]****bbbbuuuutttt""""

     This macro-definition returns the standard  negative  header
     for  the  hiding files used in the _C_A_D_P toolbox (see above).
     In such case, this macro-definition should  be  used  as  an
     actual   value  for  parameter  CCCCAAAAEEEESSSSAAAARRRR____NNNNEEEEGGGGAAAATTTTIIIIVVVVEEEE____HHHHEEEEAAAADDDDEEEERRRR  when
     invoking function CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTEEEE____HHHHIIIIDDDDEEEE____1111.

      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____DDDDEEEELLLLEEEETTTTEEEE____HHHHIIIIDDDDEEEE____1111

     vvvvooooiiiidddd CCCCAAAAEEEESSSSAAAARRRR____DDDDEEEELLLLEEEETTTTEEEE____HHHHIIIIDDDDEEEE____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____HHHH))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____HHHHIIIIDDDDEEEE____1111 ****CCCCAAAAEEEESSSSAAAARRRR____HHHH;;;;
        {{{{ ............ }}}}

     This procedure frees the memory space corresponding  to  the
     hiding object pointed to by ****CCCCAAAAEEEESSSSAAAARRRR____HHHH using CCCCAAAAEEEESSSSAAAARRRR____DDDDEEEELLLLEEEETTTTEEEE(((()))).
     Afterwards, the NNNNUUUULLLLLLLL value is assigned to ****CCCCAAAAEEEESSSSAAAARRRR____HHHH.

      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____TTTTEEEESSSSTTTT____HHHHIIIIDDDDEEEE____1111

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____BBBBOOOOOOOOLLLLEEEEAAAANNNN CCCCAAAAEEEESSSSAAAARRRR____TTTTEEEESSSSTTTT____HHHHIIIIDDDDEEEE____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____HHHH,,,, CCCCAAAAEEEESSSSAAAARRRR____SSSS))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____HHHHIIIIDDDDEEEE____1111 CCCCAAAAEEEESSSSAAAARRRR____HHHH;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSTTTTRRRRIIIINNNNGGGG CCCCAAAAEEEESSSSAAAARRRR____SSSS;;;;
        {{{{ ............ }}}}

     This function returns CCCCAAAAEEEESSSSAAAARRRR____TTTTRRRRUUUUEEEE if  the  character  string
     CCCCAAAAEEEESSSSAAAARRRR____SSSS  is  recognized  by the hiding object pointed to by
     CCCCAAAAEEEESSSSAAAARRRR____HHHH (according to  the  semantics  defined  above),  or
     CCCCAAAAEEEESSSSAAAARRRR____FFFFAAAALLLLSSSSEEEE otherwise.

      ............................................................




(C) INRIA     Last change: 2020/02/11 (version 1.1)             6






OPEN/CAESAR MANUAL                           caesar_hide_1(LOCAL)



  CCCCAAAAEEEESSSSAAAARRRR____FFFFOOOORRRRMMMMAAAATTTT____HHHHIIIIDDDDEEEE____1111

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____FFFFOOOORRRRMMMMAAAATTTT CCCCAAAAEEEESSSSAAAARRRR____FFFFOOOORRRRMMMMAAAATTTT____HHHHIIIIDDDDEEEE____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____HHHH,,,, CCCCAAAAEEEESSSSAAAARRRR____FFFFOOOORRRRMMMMAAAATTTT))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____HHHHIIIIDDDDEEEE____1111 CCCCAAAAEEEESSSSAAAARRRR____HHHH;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____FFFFOOOORRRRMMMMAAAATTTT CCCCAAAAEEEESSSSAAAARRRR____FFFFOOOORRRRMMMMAAAATTTT;;;;
        {{{{ ............ }}}}

     This function allows to control the format under  which  the
     hiding  object pointed to by CCCCAAAAEEEESSSSAAAARRRR____HHHH will be printed by the
     procedure CCCCAAAAEEEESSSSAAAARRRR____PPPPRRRRIIIINNNNTTTT____HHHHIIIIDDDDEEEE____1111(((()))) (see below). Currently,  the
     following format is available:


     -    With format 0, information about the hiding  object  is
          displayed  such  as:  the pathname of the corresponding
          hiding file, the positive header (if any), the negative
          header  (if  any),  the number of patterns, the list of
          patterns, etc.

     -    (no other format available yet).

     By default, the current format of each hiding object is ini-
     tialized to 0.

     When called with CCCCAAAAEEEESSSSAAAARRRR____FFFFOOOORRRRMMMMAAAATTTT between 0 and 0,  this  fonc-
     tion  sets  the  current format of CCCCAAAAEEEESSSSAAAARRRR____HHHH to CCCCAAAAEEEESSSSAAAARRRR____FFFFOOOORRRRMMMMAAAATTTT
     and returns an undefined result.

     When called with another value of CCCCAAAAEEEESSSSAAAARRRR____FFFFOOOORRRRMMMMAAAATTTT, this  func-
     tion  does  not  modify  the  current format of CCCCAAAAEEEESSSSAAAARRRR____HHHH but
     returns a result defined as  follows.  If  CCCCAAAAEEEESSSSAAAARRRR____FFFFOOOORRRRMMMMAAAATTTT  is
     equal  to  the constant CCCCAAAAEEEESSSSAAAARRRR____CCCCUUUURRRRRRRREEEENNNNTTTT____FFFFOOOORRRRMMMMAAAATTTT, the result is
     the  value  of  the   current   format   of   CCCCAAAAEEEESSSSAAAARRRR____HHHH.   If
     CCCCAAAAEEEESSSSAAAARRRR____FFFFOOOORRRRMMMMAAAATTTT      is      equal     to     the     constant
     CCCCAAAAEEEESSSSAAAARRRR____MMMMAAAAXXXXIIIIMMMMAAAALLLL____FFFFOOOORRRRMMMMAAAATTTT, the  result  is  the  maximal  format
     value  (i.e.,  0).  In  all  other cases, the effect of this
     function is undefined.

      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____MMMMAAAAXXXX____FFFFOOOORRRRMMMMAAAATTTT____HHHHIIIIDDDDEEEE____1111

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____FFFFOOOORRRRMMMMAAAATTTT CCCCAAAAEEEESSSSAAAARRRR____MMMMAAAAXXXX____FFFFOOOORRRRMMMMAAAATTTT____HHHHIIIIDDDDEEEE____1111 (((())))
        {{{{ ............ }}}}

     Caution! This function is deprecated. It should no longer be
     used,  as  itmight  be  removed  from future versions of the
     _O_P_E_N/_C_A_E_S_A_R. Use  function  CCCCAAAAEEEESSSSAAAARRRR____FFFFOOOORRRRMMMMAAAATTTT____HHHHIIIIDDDDEEEE____1111(((())))  instead,
     called with argument CCCCAAAAEEEESSSSAAAARRRR____MMMMAAAAXXXXIIIIMMMMAAAALLLL____FFFFOOOORRRRMMMMAAAATTTT.

     This function returns the maximal format value available for
     printing hiding objects.



(C) INRIA     Last change: 2020/02/11 (version 1.1)             7






OPEN/CAESAR MANUAL                           caesar_hide_1(LOCAL)



      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____PPPPRRRRIIIINNNNTTTT____HHHHIIIIDDDDEEEE____1111

     vvvvooooiiiidddd CCCCAAAAEEEESSSSAAAARRRR____PPPPRRRRIIIINNNNTTTT____HHHHIIIIDDDDEEEE____1111 ((((CCCCAAAAEEEESSSSAAAARRRR____FFFFIIIILLLLEEEE,,,, CCCCAAAAEEEESSSSAAAARRRR____HHHH))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____FFFFIIIILLLLEEEE CCCCAAAAEEEESSSSAAAARRRR____FFFFIIIILLLLEEEE;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____HHHHIIIIDDDDEEEE____1111 CCCCAAAAEEEESSSSAAAARRRR____HHHH;;;;
        {{{{ ............ }}}}

     This procedure prints to file CCCCAAAAEEEESSSSAAAARRRR____FFFFIIIILLLLEEEE a text  containing
     information  about the hiding object pointed to by CCCCAAAAEEEESSSSAAAARRRR____HHHH.
     The nature of the information is determined by  the  current
     format of the hiding object pointed to by CCCCAAAAEEEESSSSAAAARRRR____HHHH.

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
     OPEN/CAESAR.  Please report new bugs to cadp@inria.fr






(C) INRIA     Last change: 2020/02/11 (version 1.1)             8



