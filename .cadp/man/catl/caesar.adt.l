


CADP MANUAL PAGES                               CAESAR.ADT(LOCAL)



NNNNAAAAMMMMEEEE
     caesar.adt - translation of LOTOS abstract data types into C


SSSSYYYYNNNNOOOOPPPPSSSSIIIISSSS
     ccccaaaaeeeessssaaaarrrr....aaaaddddtttt [----cccccccc _o_p_t_i_o_n_s] [----ccccoooommmmmmmmeeeennnnttttssss] [----ddddeeeebbbbuuuugggg]  [----ddddeeeeppppeeeennnndddd]  [----
     eeeennnngggglllliiiisssshhhh]   [----eeeerrrrrrrroooorrrr]   [----eeeexxxxtttteeeerrrrnnnnaaaallll]   [----ffffoooorrrrcccceeee]   [----ffffrrrreeeennnncccchhhh]  [----
     ffffuuuunnnnccccttttiiiioooonnnnaaaalllliiiittttyyyy] [----iiiinnnnddddeeeennnntttt] [----iiiinnnnffffiiiixxxx] [----iiiissssoooo] [----mmmmaaaaccccrrrroooo] [----mmmmaaaapppp]  [----
     mmmmoooorrrreeee  _c_o_m_m_a_n_d]  [----nnnnuuuummmmeeeerrrraaaallll  _i_n_t_e_g_e_r]  [----pppprrrreeeeffffiiiixxxx]  [----ssssiiiilllleeeennnntttt] [----
     ttttrrrraaaacccceeee] [----vvvveeeerrrrbbbboooosssseeee] [----vvvveeeerrrrssssiiiioooonnnn] [----wwwwaaaarrrrnnnniiiinnnngggg] _f_i_l_e_n_a_m_e[....lllloooottttoooossss]


DDDDEEEESSSSCCCCRRRRIIIIPPPPTTTTIIIIOOOONNNN
     ccccaaaaeeeessssaaaarrrr....aaaaddddtttt [Gar89c,GT93] is a compiler that translates LOTOS
     abstract  data  types into executable code. Quite often, the
     code generated is given as input to the  ccccaaaaeeeessssaaaarrrr(LOCAL)  com-
     piler, but it can also be used for other purpose.


     Taking as  input  _f_i_l_e_n_a_m_e....lllloooottttoooossss,  which  contains  a  LOTOS
     specification,  optionally  accompanied by _f_i_l_e_n_a_m_e....tttt, which
     contains hand-written C code, ccccaaaaeeeessssaaaarrrr....aaaaddddtttt produces an  output
     file  _f_i_l_e_n_a_m_e....hhhh  that contains C types and functions imple-
     menting  the  LOTOS  sorts   and   operations   defined   in
     _f_i_l_e_n_a_m_e....lllloooottttoooossss.


     Refer  to  the  lllloooottttoooossss(LOCAL)  manual  page  for  a  detailed
     description   of   the   conventions   to   be  followed  by
     _f_i_l_e_n_a_m_e....lllloooottttoooossss and _f_i_l_e_n_a_m_e....tttt.


OOOOPPPPTTTTIIIIOOOONNNNSSSS
     ----cccccccc _o_p_t_i_o_n_s
          Pass _o_p_t_i_o_n_s to the C  compiler  when  it  is  invoked.
          _o_p_t_i_o_n_s  is  a  list  of  compiler options (enclosed in
          quotes or double quotes). These options are appended to
          the compiler options, if any, contained in the $$$$CCCCAAAADDDDPPPP____CCCCCCCC
          environment variable (see ENVIRONMENT VARIABLES below).
          Not a default option.

     ----ccccoooommmmmmmmeeeennnnttttssss
          Issue a warning message for each LOTOS sort  or  opera-
          tion  which  is not properly labelled by a special com-
          ment of the form ((((****!!!!............****)))).  Not a default option.

     ----ddddeeeebbbbuuuugggg
          Generate extra C code that helps to debug partial  non-
          constructor  definitions.  When  a  C  function  aborts
          because the corresponding LOTOS operation is  not  com-
          pletely defined by its equations, the name of the func-
          tion  and  the  actual  values  of  its  arguments  are



(C) INRIA            Last change: 2020/02/11                    1






CADP MANUAL PAGES                               CAESAR.ADT(LOCAL)



          displayed.  Not a default option.

     ----ddddeeeeppppeeeennnndddd
          Display the list of library files included (directly or
          transitively)  in  _f_i_l_e_n_a_m_e[....lllloooottttoooossss] and stop. This list
          may be incomplete if the LOTOS specification is syntac-
          tically incorrect.  Not a default option.

     ----eeeennnngggglllliiiisssshhhh
          Print messages in English. Opposite  of  ----ffffrrrreeeennnncccchhhh.  This
          option  overrides  the $$$$CCCCAAAADDDDPPPP____LLLLAAAANNNNGGGGUUUUAAAAGGGGEEEE environment vari-
          able (see ENVIRONMENT VARIABLES below).

     ----eeeerrrrrrrroooorrrr
          A file, _f_i_l_e_n_a_m_e....eeeerrrrrrrr, is generated  by  ccccaaaaeeeessssaaaarrrr....aaaaddddtttt....  It
          contains  detailed  error  diagnostics.  When  it  ter-
          minates, ccccaaaaeeeessssaaaarrrr....aaaaddddtttt displays the content of  this  file
          on  the  screen, using the $$$$CCCCAAAADDDDPPPP////ssssrrrrcccc////ccccoooommmm////ccccaaaaddddpppp____mmmmoooorrrreeee com-
          mand, unless ----eeeerrrrrrrroooorrrr option is set.

     ----eeeexxxxtttteeeerrrrnnnnaaaallll
          Generate a  skeleton  file  _f_i_l_e_n_a_m_e....tttt....pppprrrroooottttoooo  and/or  a
          skeleton  file _f_i_l_e_n_a_m_e....ffff....pppprrrroooottttoooo if the LOTOS specifica-
          tion  contains   sorts   and/or   operations   declared
          ((((****!!!! eeeexxxxtttteeeerrrrnnnnaaaallll ****)))).   These skeleton files are incomplete,
          but  form  a  basis  for   producing   _f_i_l_e_n_a_m_e....tttt   and
          _f_i_l_e_n_a_m_e....ffff.  They have to be completed manually (at the
          places marked "...") with an implementation  in  C  for
          external  sorts  and  constructors,  and/or operations.
          Also, it may be necessary to modify manually the  order
          of C type declarations in order to avoid forward refer-
          ences. Not a default option.

          Note:  if  _f_i_l_e_n_a_m_e....tttt....pppprrrroooottttoooo   and/or   _f_i_l_e_n_a_m_e....ffff....pppprrrroooottttoooo
          already exist in the current directory, ccccaaaaeeeessssaaaarrrr....aaaaddddtttt will
          not overwrite them, because they might have been  modi-
          fied manually.

     ----ffffoooorrrrcccceeee
          Force ccccaaaaeeeessssaaaarrrr....aaaaddddtttt to regenerate _f_i_l_e_n_a_m_e....hhhh even  if  not
          necessary.  Not a default option. By default ccccaaaaeeeessssaaaarrrr....aaaaddddtttt
          will attempt not to regenerate _f_i_l_e_n_a_m_e....hhhh if this  file
          already  exists in the current directory, and if it has
          been modified more recently than:
          (1)  the  corresponding  LOTOS  file   (_f_i_l_e_n_a_m_e....lllloooottttoooossss,
          _f_i_l_e_n_a_m_e....llllooootttt, or _f_i_l_e_n_a_m_e....llll),
          (2) than any LOTOS library transitively included (using
          the "library" clause) in this LOTOS file,
          (3) than any C  file  included  (using  the  "####iiiinnnncccclllluuuuddddeeee"
          clause) in _f_i_l_e_n_a_m_e....hhhh itself,
          (4) than the _f_i_l_e_n_a_m_e....tttt file if this file exists in the
          current directory, and



(C) INRIA            Last change: 2020/02/11                    2






CADP MANUAL PAGES                               CAESAR.ADT(LOCAL)



          (5) than the _f_i_l_e_n_a_m_e....ffff file if this file exists in the
          current directory.

     ----ffffrrrreeeennnncccchhhh
          Print messages in French. Opposite  of  ----eeeennnngggglllliiiisssshhhh.  This
          option  overrides  the $$$$CCCCAAAADDDDPPPP____LLLLAAAANNNNGGGGUUUUAAAAGGGGEEEE environment vari-
          able (see ENVIRONMENT VARIABLES below). Even when  this
          option  is set, some warning and error messages related
          to  lexical  and  syntactic  analysis  may   still   be
          displayed in English.

     ----ffffuuuunnnnccccttttiiiioooonnnnaaaalllliiiittttyyyy
          Do not check functionality  constraints  (``eeeexxxxiiiitttt''  and
          ``nnnnooooeeeexxxxiiiitttt''). Not a default option.

     ----iiiinnnnddddeeeennnntttt
          Do  not  format  using  the  shell-script  located   in
          $$$$CCCCAAAADDDDPPPP////ssssrrrrcccc////ccccoooommmm////ccccaaaaddddpppp____iiiinnnnddddeeeennnntttt     the     generated    file
          _f_i_l_e_n_a_m_e....hhhh,  nor   the   files   _f_i_l_e_n_a_m_e....ffff....pppprrrroooottttoooo   and
          _f_i_l_e_n_a_m_e....tttt....pppprrrroooottttoooo  generated  by  option ----eeeexxxxtttteeeerrrrnnnnaaaallll. This
          option can be useful when the iiiinnnnddddeeeennnntttt(1) program invoked
          by  ccccaaaaddddpppp____iiiinnnnddddeeeennnntttt  crashes  with  a  core  dump, although
          ccccaaaaddddpppp____iiiinnnnddddeeeennnntttt is designed to  recover  properly  in  such
          event. Not a default option.

     ----iiiinnnnffffiiiixxxx
          Generate C code to print  LOTOS  binary  operations  in
          infix form when appropriate. Not a default option.

     ----iiiissssoooo
          Use the standard LOTOS semantics as defined in  ISO/IEC
          International  Standard  8807,  disabling  the  various
          language enhancements mentioned in the  section  EXTEN-
          SIONS  TO  LOTOS  of  the  lllloooottttoooossss(LOCAL) manual page and
          implemented in ccccaaaaeeeessssaaaarrrr....aaaaddddtttt. Not a default  option.   Not
          to  be  used  when processing LOTOS specifications gen-
          erated by llllnnnntttt2222lllloooottttoooossss(LOCAL)


     ----mmmmaaaaccccrrrroooo
          Prevent LOTOS non-constructor operations to  be  imple-
          mented  by  C  macro-definitions  (####ddddeeeeffffiiiinnnneeee):  all LOTOS
          non-constructor operations will  be  implemented  as  C
          functions instead. Not a default option.

     ----mmmmaaaapppp
          Generate  _f_i_l_e_n_a_m_e....mmmmaaaapppp   which   gives   correspondence
          between   sort   and   operation   names   occuring  in
          _f_i_l_e_n_a_m_e....lllloooottttoooossss and C type and function  names  occuring
          in _f_i_l_e_n_a_m_e....hhhh.  Not a default option.

     ----mmmmoooorrrreeee _c_o_m_m_a_n_d



(C) INRIA            Last change: 2020/02/11                    3






CADP MANUAL PAGES                               CAESAR.ADT(LOCAL)



          Use _c_o_m_m_a_n_d to display the error messages,  instead  of
          "$$$$CCCCAAAADDDDPPPP////ssssrrrrcccc////ccccoooommmm////ccccaaaaddddpppp____mmmmoooorrrreeee" which is the default. _c_o_m_m_a_n_d
          is a shell command (preferably enclosed  in  quotes  or
          double  quotes)  containing  the pathname of the chosen
          pager, possibly followed by a list of  options.  Not  a
          default option.

     ----nnnnuuuummmmeeeerrrraaaallll _i_n_t_e_g_e_r
          Specify the range of values to be used for implementing
          numeral  sorts,  i.e.,  all  sorts _S that have two con-
          structor operations _F_1 : -> _S and _F_2 : _S -> _S, and  are
          thus  isomorphic  to  natural  numbers.   If _i_n_t_e_g_e_r is
          greater  than  zero,  the  range  of  values  will   be
          0...(_i_n_t_e_g_e_r-1).  If  _i_n_t_e_g_e_r  is  less  than zero, the
          range of values will  be  0...((2^(-_i_n_t_e_g_e_r))-1).  With
          64-bit  versions  of  ccccaaaaeeeessssaaaarrrr....aaaaddddtttt,  the highest positive
          values for _i_n_t_e_g_e_r  are  interpreted  as  the  negative
          numbers  -64,  -63,  ...,  -2,  -1. By default, numeral
          sorts are represented  using  a  single  byte  (default
          value of _i_n_t_e_g_e_r is 256). This option does not apply to
          those numeral sorts _S for which  _f_i_l_e_n_a_m_e.tttt  defines  a
          corresponding macro CCCCAAAAEEEESSSSAAAARRRR____AAAADDDDTTTT____HHHHAAAASSSSHHHH____.............

     ----pppprrrreeeeffffiiiixxxx
          Generate C code that  prints  LOTOS  binary  operations
          always in prefix form.  Default option.

     ----ssssiiiilllleeeennnntttt
          Execute silently. Opposite of ----vvvveeeerrrrbbbboooosssseeee. Default  option
          is ----vvvveeeerrrrbbbboooosssseeee.

     ----ttttrrrraaaacccceeee
          Generate extra C code that traces all calls and returns
          for  a  selected  set  of C functions. This option also
          sets the ----mmmmaaaaccccrrrroooo option. Not a default option.

     ----vvvveeeerrrrbbbboooosssseeee
          Print one line for each successive phase  performed  by
          ccccaaaaeeeessssaaaarrrr....aaaaddddtttt  to  inform  the  user about the progress of
          activities.  Opposite of  ----ssssiiiilllleeeennnntttt.  Default  option  is
          ----vvvveeeerrrrbbbboooosssseeee.

     ----vvvveeeerrrrssssiiiioooonnnn
          Display the current version number of the software  and
          stop.  Not a default option.

     ----wwwwaaaarrrrnnnniiiinnnngggg
          Suppress all warning messages,  keeping  (more  severe)
          error  messages,  at  the  risk  of  leaving undetected
          issues in  the  LOTOS  specification.   Not  a  default
          option.




(C) INRIA            Last change: 2020/02/11                    4






CADP MANUAL PAGES                               CAESAR.ADT(LOCAL)



TTTTRRRRAAAANNNNSSSSLLLLAAAATTTTIIIIOOOONNNN PPPPHHHHAAAASSSSEEEESSSS
     The architecture of ccccaaaaeeeessssaaaarrrr....aaaaddddtttt(LOCAL) follows the principles
     exposed  in  Section 1 of [GT93]. The translation from LOTOS
     to C proceeds in several successive phases:


     - syntax analysis phase
          The LOTOS specification is lexically and  syntactically
          analyzed  using  a  scanner and a parser that have been
          generated by the SYNTAX tool of INRIA,  which  produces
          analyzers  that  emit pertinent error messages and per-
          form, as much as possible,  automatic  error  recovery.
          Incorrect LOTOS specifications are rejected; otherwise,
          an abstract syntax tree is built. This phase is  shared
          with ccccaaaaeeeessssaaaarrrr(LOCAL)


     - semantic analysis phase
          The static semantics constraints of the standard  LOTOS
          definition  are  checked  on  the abstract syntax tree.
          This is done in several steps:  binding  of  processes,
          binding  of  gates,  binding of types, analysis of type
          signatures, binding of  sorts,  binding  of  variables,
          binding  of  operations,  and analysis of process func-
          tionality. The LOTOS specifications not matching  these
          constraints  are  rejected.  This  phase is also shared
          with ccccaaaaeeeessssaaaarrrr(LOCAL)


     - interface phase
          The abstract syntax tree is traversed and its  fragment
          that  represents the abstract data types defined in the
          source LOTOS specification is extracted and copied into
          the  _i_n_p_u_t _t_r_e_e, a simpler syntax tree, which is itself
          specified using LOTOS abstract data  types.  From  this
          point,  all the forthcoming translation steps are writ-
          ten in LOTOS, meaning that  the  ccccaaaaeeeessssaaaarrrr....aaaaddddtttt  translator
          compiles itself (i.e., is bootstrapped).


     - verification phase
          The additional static semantics constraints  listed  in
          the  section  "RESTRICTIONS  ON  THE  DATA PART" of the
          lllloooottttoooossss(LOCAL) manual page are  checked,  and  the  LOTOS
          specifications  not  satisfying  these  constraints are
          rejected.


     - type survey phase
          If a file named _f_i_l_e_n_a_m_e....tttt exists, an auxiliary C  pro-
          gram  that  includes  this file is generated, compiled,
          and  executed  so  as  to  obtain  information  on  how



(C) INRIA            Last change: 2020/02/11                    5






CADP MANUAL PAGES                               CAESAR.ADT(LOCAL)



          external  LOTOS  sorts  are  implemented in _f_i_l_e_n_a_m_e....tttt.
          This phase may fail if the contents of  _f_i_l_e_n_a_m_e....tttt  are
          incorrect or incomplete.


     - compilation phase
          The abstract sorts and operations  represented  in  the
          input tree are translated into concrete types and func-
          tions, which are stored in  the  _o_u_t_p_u_t  _t_r_e_e,  another
          syntax tree closer to imperative languages, such as C.


     - optimization phase
          Various transformations are applied to the output tree,
          so  as  to reduce the space taken by types and the time
          spent in functions.


     - C translation phase
          The output tree is traversed and decompiled to  produce
          C code stored in _f_i_l_e_n_a_m_e....hhhh.


     - indentation phase
          The shell-script ccccaaaaddddpppp____iiiinnnnddddeeeennnntttt is invoked to  format  the
          generated file _f_i_l_e_n_a_m_e....hhhh unless option ----iiiinnnnddddeeeennnntttt is set.


EEEENNNNVVVVIIIIRRRROOOONNNNMMMMEEEENNNNTTTT VVVVAAAARRRRIIIIAAAABBBBLLLLEEEESSSS
     $$$$CCCCAAAADDDDPPPP____LLLLAAAANNNNGGGGUUUUAAAAGGGGEEEE
          If this variable  is  set,  its  value  determines  the
          language in which diagnostic messages will be reported.
          Possible values are 'eeeennnngggglllliiiisssshhhh' and  'ffffrrrreeeennnncccchhhh'.  Incorrect
          values  will  be  ignored silently. If this variable is
          unset, it is given the default value 'eeeennnngggglllliiiisssshhhh'.

     $$$$CCCCAAAADDDDPPPP____CCCCCCCC
          If this variable is set, its value determines the  name
          of  the  C compiler that will be invoked by ccccaaaaeeeessssaaaarrrr....aaaaddddtttt.
          See file $$$$CCCCAAAADDDDPPPP////IIIINNNNSSSSTTTTAAAALLLLLLLLAAAATTTTIIIIOOOONNNN____2222 for detailed  information
          about  this  variable.  If  this variable is unset, the
          script-shell $$$$CCCCAAAADDDDPPPP////ssssrrrrcccc////ccccoooommmm////ccccaaaaddddpppp____cccccccc  will  automatically
          determine the C compiler to be used by default.

     $$$$CCCCAAAADDDDPPPP____TTTTMMMMPPPP
          If this variable  is  set,  its  value  determines  the
          directory in which temporary files are created. If this
          variable is  unset,  it  is  given  the  default  value
          '////ttttmmmmpppp'.

     $$$$PPPPAAAAGGGGEEEERRRR
          If this variable is set, its value will be used by  the



(C) INRIA            Last change: 2020/02/11                    6






CADP MANUAL PAGES                               CAESAR.ADT(LOCAL)



          script-shell  $$$$CCCCAAAADDDDPPPP////ssssrrrrcccc////ccccoooommmm////ccccaaaaddddpppp____mmmmoooorrrreeee  to display error
          and warning messages.


EEEEXXXXIIIITTTT SSSSTTTTAAAATTTTUUUUSSSS
     When the source is erroneous,  error  messages  are  issued.
     Exit status is 0 if everything is alright, 1 otherwise.


OOOOPPPPEEEERRRRAAAANNNNDDDDSSSS
     _f_i_l_e_n_a_m_e.lllloooottttoooossss    LOTOS specification (input)
     _f_i_l_e_n_a_m_e.tttt        external  C   implementation   for   types
                       (input)
     _f_i_l_e_n_a_m_e.tttt....pppprrrroooottttoooo  skeleton for _f_i_l_e_n_a_m_e.tttt (output)
     _f_i_l_e_n_a_m_e.ffff        external C  implementation  for  functions
                       (input)
     _f_i_l_e_n_a_m_e.ffff....pppprrrroooottttoooo  skeleton for _f_i_l_e_n_a_m_e.ffff (output)
     _f_i_l_e_n_a_m_e.hhhh        C implementation (output)
     _f_i_l_e_n_a_m_e.eeeerrrrrrrr      detailed error messages (output)
     _f_i_l_e_n_a_m_e.mmmmaaaapppp      ADT correspondence table (output)
     _l_i_b_n_a_m_e.lllliiiibbbb       user ADT library (input)


     For simplicity, the standard error stream is not  used;  all
     messages are written to the standard output stream, which is
     made unbuffered. The file _f_i_l_e_n_a_m_e.eeeerrrrrrrr  is  created  at  the
     beginning  of execution and removed, if empty, at the end of
     execution.


FFFFIIIILLLLEEEESSSS
     $$$$CCCCAAAADDDDPPPP////lllliiiibbbb////_l_i_b_n_a_m_e....lllliiiibbbb    predefined ADT library (input)
     $$$$CCCCAAAADDDDPPPP////ssssrrrrcccc////ccccoooommmm////ccccaaaaddddpppp____cccccccc    C compiler shell
     $$$$CCCCAAAADDDDPPPP////ssssrrrrcccc////ccccoooommmm////ccccaaaaddddpppp____mmmmoooorrrreeee  pager shell
     $$$$CCCCAAAADDDDPPPP////LLLLIIIICCCCEEEENNNNSSSSEEEE        license file
     $$$$CCCCAAAADDDDPPPP____TTTTMMMMPPPP////****....cccc        C code  generated  during  type  survey
                          (temporary)
     $$$$CCCCAAAADDDDPPPP____TTTTMMMMPPPP////****....xxxx        binary code for type survey (temporary)
     $$$$CCCCAAAADDDDPPPP____TTTTMMMMPPPP////****....ttttssssvvvv      results of type survey (temporary)


BBBBIIIIBBBBLLLLIIIIOOOOGGGGRRRRAAAAPPPPHHHHYYYY
     [Gar89c] Hubert Garavel.  Compilation of LOTOS Abstract Data
     Types.   In  Son  T.  Vuong,  editor, Proceedings of the 2nd
     International Conference on  Formal  Description  Techniques
     (FORTE'89), Vancouver, Canada. North Holland, pages 147-162,
     December           1989.           Available            from
     http://cadp.inria.fr/publications/Garavel-89-c.html

     [GT93] Hubert Garavel and Philippe Turlier.  CAESAR.ADT : un
     compilateur  pour les types abstraits algebriques du langage
     LOTOS.  In Rachida Dssouli and Gregor v. Bochmann,  editors,



(C) INRIA            Last change: 2020/02/11                    7






CADP MANUAL PAGES                               CAESAR.ADT(LOCAL)



     Actes  du  Colloque Francophone pour l'Ingenierie des Proto-
     coles (CFIP'93),  Montreal,  Canada,  1993.  Available  from
     http://cadp.inria.fr/publications/Garavel-Turlier-93.html


SSSSEEEEEEEE AAAALLLLSSSSOOOO
     ccccaaaaeeeessssaaaarrrr(LOCAL),      ccccaaaaeeeessssaaaarrrr....iiiinnnnddddeeeennnntttt(LOCAL),       lllloooottttoooossss(LOCAL)
     lllloooottttoooossss....ooooppppeeeennnn(LOCAL),

     Additional information is available from the CADP  Web  page
     located at http://cadp.inria.fr

     Directives   for   installation   are   given    in    files
     $$$$CCCCAAAADDDDPPPP////IIIINNNNSSSSTTTTAAAALLLLLLLLAAAATTTTIIIIOOOONNNN____****....

     Recent  changes  and  improvements  to  this  software   are
     reported and commented in file $$$$CCCCAAAADDDDPPPP////HHHHIIIISSSSTTTTOOOORRRRYYYY....


BBBBUUUUGGGGSSSS
     Please report bugs to cadp@inria.fr


































(C) INRIA            Last change: 2020/02/11                    8



