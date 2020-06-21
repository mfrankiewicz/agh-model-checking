


CADP MANUAL PAGES                                      SVL(LOCAL)



NNNNAAAAMMMMEEEE
     svl, SVL - script language for verification scenarios


DDDDEEEESSSSCCCCRRRRIIIIPPPPTTTTIIIIOOOONNNN
     SVL (_S_c_r_i_p_t _V_e_r_i_f_i_c_a_t_i_o_n _L_a_n_g_u_a_g_e) offers a way to  describe
     (compositional and on-the-fly) verification scenarios, under
     the form of sequences of statements of several kinds:

     -    assignment statements, which produce a file  containing
          a representation of a given expression;

     -    comparison statements, which  compare  two  expressions
          modulo some equivalence or preorder relation;

     -    statements for verifying a temporal logic formula in an
          expression;

     -    statements for checking livelocks or  deadlocks  in  an
          expression.

     Expressions are built upon the following components:

     -    behaviour systems  represented  either  implicitly  (as
          LNT,  LOTOS,  or FSP programs, processes in LNT, LOTOS,
          or FSP programs, or networks of communicating  automata
          in  the EXP format), or explicitly (as Labelled Transi-
          tion Systems in one of the formats provided with  CADP,
          namely BCG, AUT, sequential FC2, or SEQ); note that the
          parallel FC2 format is no longer supported;

     -    LNT and LOTOS like parallel operators, enabling  paral-
          lel composition of expressions;

     -    label hiding, label cutting, and label renaming  opera-
          tors;

     -    operators of abstraction of an expression with  respect
          to some interface;

     -    operators for generating the explicit LTS of an expres-
          sion;

     -    operators of (total or partial) reduction  modulo  some
          equivalence relation;

     -    so-called _m_e_t_a-_o_p_e_r_a_t_o_r_s of (total or  partial)  reduc-
          tion, that apply to SVL abstract trees during a prelim-
          inary compilation phase called "expansion";  the  meta-
          operators implement several useful compositional reduc-
          tion strategies.




(C) INRIA            Last change: 2020/02/12                    1






CADP MANUAL PAGES                                      SVL(LOCAL)



     Moreover, SVL offers a way to invoke Bourne  shell  commands
     and  to  parameterize expressions with respect to particular
     tools and methods of CADP.


SSSSYYYYNNNNTTTTAAAAXXXX DDDDEEEESSSSCCCCRRRRIIIIPPPPTTTTIIIIOOOONNNN
     The syntax of SVL is  described  using  productions  in  the
     Extended Bachus-Naur Form (EBNF).

     Terminal symbols are written between double  quotes,  except
     for the double quote itself, which is written between single
     quotes. The newline character is written "\n".  Non-terminal
     symbols are written in italic. Optional parts of productions
     are enclosed between square brackets, and parts that can  be
     iterated zero or more times are written between braces.

     The following table sums up  the  non-terminal  symbols  and
     their meaning.

        ++++--------------------------------------------++++--------------------------------------------------------------------------------------------------------------------------------------------------------++++
        |||| SSSSyyyymmmmbbbboooollll    ||||            DDDDeeeessssccccrrrriiiippppttttiiiioooonnnn               ||||
        ++++--------------------------------------------++++--------------------------------------------------------------------------------------------------------------------------------------------------------++++
        |||| _P         |||| pppprrrrooooggggrrrraaaammmm,,,, sssseeeeqqqquuuueeeennnncccceeee ooooffff ssssttttaaaatttteeeemmmmeeeennnnttttssss      ||||
        |||| _S, _S_1, _S_2 |||| ssssttttaaaatttteeeemmmmeeeennnntttt                            ||||
        |||| _F         |||| ffffiiiilllleeee                                 ||||
        |||| _E_X_T       |||| ffffiiiilllleeee eeeexxxxtttteeeennnnssssiiiioooonnnn                       ||||
        |||| _B         |||| bbbbeeeehhhhaaaavvvviiiioooouuuurrrr eeeexxxxpppprrrreeeessssssssiiiioooonnnn                 ||||
        |||| _S_P_E_C      |||| bbbbeeeehhhhaaaavvvviiiioooouuuurrrr ssssppppeeeecccciiiiffffiiiiccccaaaattttiiiioooonnnn              ||||
        |||| _E         |||| eeeeqqqquuuuiiiivvvvaaaalllleeeennnncccceeee rrrreeeellllaaaattttiiiioooonnnn                 ||||
        |||| _M         |||| vvvveeeerrrriiiiffffiiiiccccaaaattttiiiioooonnnn mmmmeeeetttthhhhoooodddd                  ||||
        |||| _T         |||| vvvveeeerrrriiiiffffiiiiccccaaaattttiiiioooonnnn ttttoooooooollll                    ||||
        |||| _R_E        |||| rrrreeeessssuuuulllltttt aaaannnndddd////oooorrrr eeeexxxxppppeeeecccctttteeeedddd vvvvaaaalllluuuueeee         ||||
        |||| _L_L        |||| lllliiiisssstttt ooooffff llllaaaabbbbeeeellllssss                       ||||
        |||| _L         |||| llllaaaabbbbeeeellll                                ||||
        |||| _G_P_L       |||| lllliiiisssstttt ooooffff ggggaaaatttteeee ppppaaaarrrraaaammmmeeeetttteeeerrrrssss              ||||
        |||| _G         |||| ggggaaaatttteeee                                 ||||
        |||| _A_L        |||| lllliiiisssstttt ooooffff ddddaaaattttaaaa ppppaaaarrrraaaammmmeeeetttteeeerrrrssss ((((pppprrrroooocccceeeessssssss))))    ||||
        |||| _A         |||| ddddaaaattttaaaa ppppaaaarrrraaaammmmeeeetttteeeerrrr ((((pppprrrroooocccceeeessssssss))))             ||||
        |||| _T_L        |||| lllliiiisssstttt ooooffff ((((ppppoooossssssssiiiibbbbllllyyyy ttttyyyyppppeeeedddd)))) llllaaaabbbbeeeellllssss      ||||
        |||| _L_D        |||| lllliiiisssstttt ooooffff ssssyyyynnnncccchhhhrrrroooonnnniiiizzzzaaaattttiiiioooonnnn ddddeeeeffffiiiinnnniiiittttiiiioooonnnnssss  ||||
        |||| _R_L        |||| lllliiiisssstttt ooooffff rrrreeeennnnaaaammmmiiiinnnngggg rrrruuuulllleeeessss               ||||
        |||| _L_P        |||| llllaaaabbbbeeeellll ppppaaaatttttttteeeerrrrnnnn                        ||||
        |||| _P_I_D       |||| pppprrrroooocccceeeessssssss////pppprrrrooooppppeeeerrrrttttyyyy iiiiddddeeeennnnttttiiiiffffiiiieeeerrrr          ||||
        |||| _C         |||| LLLLNNNNTTTT cccchhhhaaaannnnnnnneeeellll iiiiddddeeeennnnttttiiiiffffiiiieeeerrrr               ||||
        |||| _O         |||| ddddaaaattttaaaa ooooppppeeeerrrraaaattttoooorrrr                        ||||
        ++++--------------------------------------------++++--------------------------------------------------------------------------------------------------------------------------------------------------------++++


SSSSYYYYNNNNTTTTAAAAXXXX OOOOFFFF PPPPRRRROOOOGGGGRRRRAAAAMMMMSSSS
     A program is a sequence  of  statements,  separated  in  two
     categories:  _S_1  and  _S_2.   Statements  in  _S_2  are composed
     sequentially  with  subsequent  statements  using  the   ";"



(C) INRIA            Last change: 2020/02/12                    2






CADP MANUAL PAGES                                      SVL(LOCAL)



     character.   Statements  in  _S_1  have  their own terminating
     character and do not need a ";" separator.

         _P  ::= <_e_m_p_t_y>
             |  _S_1 [ _P ]
             |  _S_2 [ ";" _P ]

     Statements are either  assignments,  behaviour  comparisons,
     temporal   logic  verifications,  deadlock/livelock  checks,
     Bourne shell commands,  property  definitions,  or  property
     checks.   A  property definition can embed other statements.
     It is given a name, optional parameters, comments, and  pos-
     sibly  an  expected  result  that  must  be attached to each
     embedded verification statement, namely behaviour  comparis-
     ons,  temporal  logic  verifications,  and deadlock/livelock
     checks.  An expected result may also be attached  optionally
     to Bourne shell commands.

     Comparisons  can  be  parameterized  modulo   a   particular
     equivalence  relation  (_E), with a particular CADP tool (_T),
     and using a particular exploration method  provided  by  the
     selected tool (_M).

     Temporal logic formulas can be either stored in  a  file  or
     inlined in the SVL script.

     Deadlock/livelock checks can be parameterized with a partic-
     ular CADP tool.

     Comparisons,    temporal    logic     verifications,     and
     deadlock/livelock checks may produce diagnostic files.

     Assignments produce LTS files.

     Using the keyword "result _r_e_s_u_l_t-_i_d", one can associate to a
     comparison,  temporal  logic verification, deadlock/livelock
     verification, or  Bourne  shell  command  a  shell  variable
     _r_e_s_u_l_t-_i_d in which the result (of the verification or Bourne
     shell command) will be stored.  Such shell-variables can  be
     used to guide the script execution depending on verification
     results, using Bourne shell commands.

         _S_1 ::= "%" _s_h_e_l_l-_l_i_n_e "\n"

             |  "property" _P_I_D ["("_p_a_r_a_m"," ..."," _p_a_r_a_m")"]
                    ['"'_c_o_m_m_e_n_t'"' ... '"'_c_o_m_m_e_n_t'"']
                "is"
                    _P
                "end property"

             |  [_F "="] _B "|=" ["using" _M] ["with" _T] _f_o_r_m_u_l_a ";"




(C) INRIA            Last change: 2020/02/12                    3






CADP MANUAL PAGES                                      SVL(LOCAL)



         _S_2 ::= "%" _s_h_e_l_l-_l_i_n_e "\n"
                    _R_E

             | _F "=" _B

             |  "check" _P_I_D "(" _a_r_g "," ... "," _a_r_g ")"

             |  [_F "="] [_E]  ["probabilistic" | "stochastic"]
                    "comparison" ["using" _M] ["with" _T]
                    _B ("==" | ">=" | "<=") _B [ ";" _R_E ]

             |  [_F "="] "verify" _F ["using" _M] ["with" _T] "in"
                    _B [ ";" _R_E ]

             |  [_F "="] "deadlock" ["with" _T] "of"
                    _B [ ";" _R_E ]

             |  [_F "="] "livelock" ["with" _T] "of"
                    _B [ ";" _R_E ]

             |  [_F "="] _B "|=" ["using" _M] ["with" _T] _f_o_r_m_u_l_a ";"
                    _R_E

         _R_E ::= "result" _L_1
             |  "expected" _L_2
             |  "result" _L_1 "expected" _L_2

         _E  ::= "strong" | "observational" | "branching"
             |  "divbranching" | "tau*.a" | "safety" | "trace"
             |  "weak trace" | "tau-confluence"
             |  "tau-compression" | "tau-divergence"

         _M  ::= "std" | "bdd" | "fly" | "bfs" | "dfs"
             |  "acyclic"

         _T  ::= "aldebaran" | "bcg_min" | "bcg_cmp"
             |  "bisimulator" | "evaluator" | "evaluator3"
             |  "evaluator4" | "evaluator5" | "exhibitor"
             |  "reductor"

     Note that the keyword "expected"  is  only  allowed  in  the
     scope of a "property" statement.

     Note that ffffcccc2222ttttoooooooollllssss are no longer supported.

     Files are written between double quotes, and must specify  a
     valid  extension.  Not  all extensions are valid in all con-
     texts, as stated more precisely in the  sections  describing
     the particular statements and behaviours.

         _F   ::= '"'_p_r_e_f_i_x._E_X_T'"' | '"'_f_i_l_e_n_a_m_e'"'




(C) INRIA            Last change: 2020/02/12                    4






CADP MANUAL PAGES                                      SVL(LOCAL)



         _E_X_T ::= "aut" | "bcg" | "fc2" | "seq"
              |  "lnt" | "lotos" | "lot" | "lts" | "exp"
              |  "hide" | "hid" | "cut" | "rename" | "ren" | "sync"
              |  "mcl" | "xtl"

     A file _p_r_e_f_i_x is any string satisfying the  syntax  of  file
     names in the current operating system.


SSSSYYYYNNNNTTTTAAAAXXXX OOOOFFFF BBBBEEEEHHHHAAAAVVVVIIIIOOOOUUUURRRR EEEEXXXXPPPPRRRREEEESSSSSSSSIIIIOOOONNNNSSSS
     Behaviour expressions are  built  from  elementary  systems,
     that  are  combined  together  using  the  various operators
     described below.

         _B   ::= _S_P_E_C

              |  "stop"

              |  "generation" "of" _B

              |  ["leaf" | "root" | "root leaf" | "node" | "smart"]
                 ["total" | "partial"]
                 [_E] ["probabilistic" | "stochastic"]
                 "reduction" ["using" _M] ["with" _T]
                 "of" _B

              |  ["total" | "partial" | "gate"] "hide"
                 (["all" "but"] [_T_L] | "using" _F) "in" _B
                 ["end" "hide"]

              |  ["total" | "partial" | "gate"] "cut"
                 (["all" "but"] [_T_L] | "using" _F) "in" _B
                 ["end" "cut"]

              |  ["total" | "partial" | "gate"] "prio"
                 (["all" "but"] _L_L (">" ["all" "but"] _L_L)+)+
                 "in" _B
                 ["end" "prio"]

              |  ["total" | "single" | "multiple" | "gate"]
                 "rename" (_R_L | "using" _F) "in" _B
                 ["end" "rename"]

              |  ["total" | "partial" | "gate"]
                 ["user"] "abstraction" _B
                 ["sync" ([_L_L] | "using" _F)] "of" _B

              |  "refined" ["user"] "abstraction" _L_L
                 ["using" _B] "of" _B

              | "chaos" ( "with" _L_L
                        | "with" _n "labels" _L_P



(C) INRIA            Last change: 2020/02/12                    5






CADP MANUAL PAGES                                      SVL(LOCAL)



                        | "using" _F )

              | "bag" _m ( "with" _L_L
                        | "with" _n "labels" _L_P "," _L_P
                        | "using" _F )

              | "fifo" _m ( "with" _L_L
                         | "with" _n "labels" _L_P "," _L_P
                         | "using" _F )

              | ["label" | "gate"] "par" [("all" | _L_D) "in"]
                [_L_D "->"] _B ("||" [_L_D "->"] _B)+
                "end par"

              |  _B "||" _B

              |  _B "|||" _B

              |  _B "|[" [_L_L] "]|" _B

              |  _B "-||"["?"] _B

              |  _B "-|||"["?"] _B

              |  _B "-|[" [_L_L] "]|"["?"] _B

              |  "(" _B ")"

         _S_P_E_C ::= _F
               |  [_F ":"] _L ["[" _G_P_L "]"] ["(" _A_L ")"]

         _L_L ::= _L [ "," _L_L ]
             |  "{"_s_t_r_i_n_g"}"

         _G_P_L ::= _L [ "," _G_P_L ]
             |  _L "=>" _L [ "," _G_P_L ]
             |  "..."
             |  "{"_s_t_r_i_n_g"}"

         _A_L ::= _A [ "," _A_L ]

         _T_L ::= _L [ ":" _C ] [ "," _T_L ]
             |  "{"_s_t_r_i_n_g"}"

         _L_D ::= _L [ "," _L_D ]
             |  _L "#" _n [ "," _L_D ]
             |  "{"_s_t_r_i_n_g"}"

         _R_L ::= _L "->" _L [ "," _R_L ]
             |  "{"_s_t_r_i_n_g"}"

         _L ::= _G | '"'_s_t_r_i_n_g'"'



(C) INRIA            Last change: 2020/02/12                    6






CADP MANUAL PAGES                                      SVL(LOCAL)



         _L_P ::= '"'_s_t_r_i_n_g-_w_i_t_h-%_d'"'

         _G, _P_I_D, _C ::= _l_o_t_o_s-_i_d_e_n_t_i_f_i_e_r
          | _l_n_t-_i_d_e_n_t_i_f_i_e_r

         _A ::= _O ["(" _A_L ")"]
             | _A _O _A
             | _A "of" _L
             | ["+" | "-"] _n
             | "'"_c_h_a_r"'"

         _O ::= _l_o_t_o_s-_i_d_e_n_t_i_f_i_e_r
             | _l_n_t-_i_d_e_n_t_i_f_i_e_r
             | _s_p_e_c_i_a_l-_i_d_e_n_t_i_f_i_e_r

     where _n denotes a natural number greater or equal to 2.


     A _l_o_t_o_s-_i_d_e_n_t_i_f_i_e_r or  an  _l_n_t-_i_d_e_n_t_i_f_i_e_r  is  a  word  that
     starts  with  a  letter  and  contains  letters, digits, and
     underscores, and is not a keyword. Underscore can not be the
     last   character   of  a  _l_o_t_o_s-_i_d_e_n_t_i_f_i_e_r  or  of  an  _l_n_t-
     _i_d_e_n_t_i_f_i_e_r.

     A _s_p_e_c_i_a_l-_i_d_e_n_t_i_f_i_e_r is a word consisting of the  characters
     '#',  '&', '*', '+', '-', '.', '/', '>', '=', '<', '@', '\',
     '^', '~', '{', and '}', that is not a  key  symbol  of  SVL.
     Note that if the sequence starts with character '{', then it
     must finish with character '}'.


PPPPRRRREEEECCCCEEEEDDDDEEEENNNNCCCCEEEE AAAANNNNDDDD AAAASSSSSSSSOOOOCCCCIIIIAAAATTTTIIIIVVVVIIIITTTTYYYY OOOOFFFF OOOOPPPPEEEERRRRAAAATTTTOOOORRRRSSSS
     -    Parallel composition operators ("||", "|||",  and  "|["
          _L_L "]|") associate to the right. For instance,
          """"aaaa....bbbbccccgggg"""" |||||||||||| """"bbbb....aaaauuuutttt"""" ||||[[[[AAAA]]]]|||| """"cccc....ffffcccc2222"""" ||||[[[[BBBB]]]]|||| """"dddd....sssseeeeqqqq""""
          reads
          """"aaaa....bbbbccccgggg"""" |||||||||||| ((((""""bbbb....aaaauuuutttt"""" ||||[[[[AAAA]]]]|||| ((((""""cccc....ffffcccc2222"""" ||||[[[[BBBB]]]]|||| """"dddd....sssseeeeqqqq""""))))))))

     -    On the opposite, infix abstraction operators  associate
          to the left. For instance,
          """"aaaa....bbbbccccgggg"""" ----|||||||||||| """"bbbb....aaaauuuutttt"""" ----||||[[[[AAAA]]]]|||| """"cccc....ffffcccc2222"""" ----||||[[[[BBBB]]]]|||| """"dddd....sssseeeeqqqq""""
          reads
          ((((((((""""aaaa....bbbbccccgggg"""" ----|||||||||||| """"bbbb....aaaauuuutttt"""")))) ----||||[[[[AAAA]]]]|||| """"cccc....ffffcccc2222"""")))) ----||||[[[[BBBB]]]]|||| """"dddd....sssseeeeqqqq""""

     -    Infix abstraction has a higher priority  than  parallel
          composition. For instance,
          """"aaaa....bbbbccccgggg"""" ----|||||||| """"iiii....bbbbccccgggg"""" |||||||||||| """"cccc....bbbbccccgggg"""" ----|||||||| """"iiii....bbbbccccgggg""""
          reads
          ((((""""aaaa....bbbbccccgggg"""" ----|||||||| """"iiii....bbbbccccgggg"""")))) |||||||||||| ((((""""cccc....bbbbccccgggg"""" ----|||||||| """"iiii....bbbbccccgggg""""))))

     -    The lexical scope of "hide", "cut",  "prio",  "rename",
          "generation",  "reduction",  and  "abstraction" (prefix



(C) INRIA            Last change: 2020/02/12                    7






CADP MANUAL PAGES                                      SVL(LOCAL)



          operators) extends as far as possible to the  right  of
          the expression. For instance,
          hhhhiiiiddddeeee AAAA iiiinnnn """"aaaa....bbbbccccgggg"""" |||||||| """"bbbb....bbbbccccgggg""""
          is the same as
          hhhhiiiiddddeeee AAAA iiiinnnn ((((""""aaaa....bbbbccccgggg"""" |||||||| """"bbbb....bbbbccccgggg""""))))

     EEEExxxxaaaammmmpppplllleeeessss:

     """"aaaa....bbbbccccgggg"""" |||||||| """"bbbb....bbbbccccgggg"""" ----|||||||| hhhhiiiiddddeeee GGGG iiiinnnn """"cccc....bbbbccccgggg"""" |||||||||||| """"dddd....bbbbccccgggg""""
     reads
     """"aaaa....bbbbccccgggg"""" |||||||| ((((""""bbbb....bbbbccccgggg"""" ----|||||||| hhhhiiiiddddeeee GGGG iiiinnnn ((((""""cccc....bbbbccccgggg"""" |||||||||||| """"dddd....bbbbccccgggg""""))))))))

     ppppaaaarrrr AAAA####2222 iiiinnnn """"aaaa....bbbbccccgggg"""" |||||||| rrrreeeedddduuuuccccttttiiiioooonnnn ooooffff """"bbbb....bbbbccccgggg"""" |||||||| """"cccc....bbbbccccgggg"""" eeeennnndddd ppppaaaarrrr
     reads
     ppppaaaarrrr AAAA####2222 iiiinnnn """"aaaa....bbbbccccgggg"""" |||||||| rrrreeeedddduuuuccccttttiiiioooonnnn ooooffff ((((""""bbbb....bbbbccccgggg"""" |||||||| """"cccc....bbbbccccgggg"""")))) eeeennnndddd ppppaaaarrrr


SSSSEEEEMMMMAAAANNNNTTTTIIIICCCCSSSS OOOOFFFF BBBBEEEEHHHHAAAAVVVVIIIIOOOOUUUURRRR EEEEXXXXPPPPRRRREEEESSSSSSSSIIIIOOOONNNNSSSS
     The semantics of behaviours is defined as follows:


  BBBBEEEEHHHHAAAAVVVVIIIIOOOOUUUURRRR SSSSYYYYSSSSTTTTEEEEMMMMSSSS
     _S_P_E_C may be the name of a file containing a Labelled Transi-
     tion  System  (LTS)  in one of the AUT (extension ....aaaauuuutttt), BCG
     (extension ....bbbbccccgggg), FC2 (extension ....ffffcccc2222),  or  SEQ  (extension
     ....sssseeeeqqqq) file formats.  BCG files may define stochastic or pro-
     babilistic LTSs as explained in  the  bbbbccccgggg____mmmmiiiinnnn(LOCAL)  manual
     page.

     _S_P_E_C may also be the name of a file containing a network  of
     LTSs in the EXP file format (extension ....eeeexxxxpppp). See a descrip-
     tion of the .exp format in the aaaallllddddeeeebbbbaaaarrrraaaannnn(LOCAL) manual page

     At last, _S_P_E_C may also be the name of an LNT, LOTOS, or  FSP
     file,  or an instanciation of a process in an LNT, LOTOS, or
     FSP file.  In the latter case, the syntax is as follows:
     [_F ":"] _L ["[" _G_P_L "]"] ["(" _A_L ")"]
     where _F is the name  of  the  LNT  (extension  ....llllnnnntttt),  LOTOS
     (extension  ....lllloooottttoooossss or ....llllooootttt), or FSP (extension ....llllttttssss) file, _L
     is a label denoting the name of the invoked process, _G_P_L  is
     an  optional  list of gate parameters of the process, and _A_L
     is an optional  list  of  arguments  representing  the  data
     parameters  of  the  process.  For an FSP process instancia-
     tion, _G_P_L and _A_L must remain empty.   For  a  LOTOS  process
     instanciation, _G_P_L must contain a list of gates.  For an LNT
     process instanciation, _G_P_L may use the  dot  notation  "..."
     and  the  named notation GGGG1111 ====>>>> GGGG2222, where GGGG1111 is a formal gate
     parameter of the process, and _G_2 is the corresponding actual
     parameter.  See  the LNT user manual for details.  Note that
     _L, _G_P_L, and _A_L may contain Bourne Shell variables (see  Sec-
     tion  USING  SHELL  VARIABLES  IN  EXPRESSIONS for details).
     Those Bourne Shell variables can only  occur  inside  double



(C) INRIA            Last change: 2020/02/12                    8






CADP MANUAL PAGES                                      SVL(LOCAL)



     quotes.   As a consequence, the double quotes in _A_L must not
     be interpreted as the delimiter of a LOTOS or LNT  character
     string.   For  arguments  of  type string, the double quotes
     must be escaped, as in the following example:
     PPPP [[[[AAAA,,,, BBBB]]]] ((((""""$$$$XXXX"""" ooooffff NNNNaaaatttt,,,, """"\\\\""""tttthhhhiiiissss iiiissss aaaa ssssttttrrrriiiinnnngggg\\\\""""""""))))

     The filename _F is optional. If it is not mentioned, the pro-
     cess will be searched in the default LNT, LOTOS, or FSP file
     assigned to the shell  variable  DDDDEEEEFFFFAAAAUUUULLLLTTTT____PPPPRRRROOOOCCCCEEEESSSSSSSS____FFFFIIIILLLLEEEE  on  a
     shell  line  preceding  the  expression  (see  Section SHELL
     LINES).

     Note that SVL relies uniquely  on  extensions  to  recognize
     file formats. All files describing the behaviour of a system
     must therefore have a valid extension.


  SSSSTTTTOOOOPPPP
     "stop" represents a Labelled Transition  System  which  con-
     tains a single state and no transitions.


  HHHHIIIIDDDDIIIINNNNGGGG
     ["total" | "partial" | "gate"] "hide" ["all" "but"] [_T_L] "in"
        _B
     ["end" "hide"]
     and
     ["total" | "partial" | "gate"] "hide" "using" _F "in"
        _B
     ["end" "hide"]
     will hide the labels found  in  _B  using  the  given  hiding
     rules.  These  rules can be specified either as a list _T_L of
     (possibly typed) labels (first form), or using  an  external
     file _F (second form).

     In the first case, the types (usually channel names  defined
     in  an  LNT  program)  are purely ignored. SVL builds a tem-
     porary file with  extension  ....hhhhiiiidddd,  filled  with  the  given
     labels.  In  the second case, the hide file must be provided
     by the user, with extension ....hhhhiiiiddddeeee or ....hhhhiiiidddd.

     A label can be  a  gate  (possibly  followed  by  experiment
     offers)  or  a  regular expression denoting a gate (possibly
     followed by experiment offers). For instance, "G", "G.*", "G
     !1", "G. !.*" are labels. Among them, only "G" is a gate.  A
     channel name can be any LNT identifier (see <lnt-identifier>
     in  Section  BEHAVIOUR  EXPRESSIONS  above),  or  any string
     between double quotes.

     Double quotes around a label can be omitted if and  only  if
     the label is a gate (therefore, the syntax of the LOTOS hid-
     ing operator is accepted as a particular case  of  the  more



(C) INRIA            Last change: 2020/02/12                    9






CADP MANUAL PAGES                                      SVL(LOCAL)



     general  SVL  hiding  operator).  However, for compatibility
     with LOTOS syntax,  gates  that  are  not  enclosed  between
     quotes  are  systematically  turned to uppercase, unless the
     ----ccccaaaasssseeee option of ssssvvvvllll(LOCAL) is used. Note that double  quotes
     are mandatory to avoid syntactic ambiguities when a gate has
     the same name as a reserved SVL keyword  (e.g.  "reduction",
     "all",  etc.).  They are also mandatory to enable the use of
     shell variables denoting gates or  labels  as  described  in
     Section USING SHELL VARIABLES IN EXPRESSIONS.

     The "all but" keywords modify the semantics  of  the  hiding
     rules:  all  the labels, except the labels specified in list
     _T_L, are hidden in the given behaviour.

     The keywords  "total",  "partial",  and  "gate"  modify  the
     matching  mode,  that is the way the hiding rules are inter-
     preted, see the  ccccaaaaeeeessssaaaarrrr____hhhhiiiiddddeeee____1111(LOCAL)  manual  page.  If  no
     matching  mode  is  specified,  then  the default is "gate",
     which  implements  the  LOTOS  hiding   operator   (possibly
     extended by the use of regular expressions on gate names).

     For every hiding with "gate" matching,  SVL  checks  whether
     the gates to be hidden have an appropriate syntax and emit a
     warning if they appear to contain experiment  offers  (which
     is a common mistake for novice users). For instance,
             hide "G !1"
     will trigger a warning message because of the  occurence  of
     "!1".

     EEEExxxxaaaammmmpppplllleeeessss:
             ttttoooottttaaaallll hhhhiiiiddddeeee """"GGGG""""
     hides every label equal to "G",
             ggggaaaatttteeee hhhhiiiiddddeeee """"GGGG""""
     hides every label whose gate is G, e.g., "G !1", "G !2",
             ggggaaaatttteeee hhhhiiiiddddeeee """"....****GGGG....****""""
     hides every label whose gate contains the character G and
             ppppaaaarrrrttttiiiiaaaallll hhhhiiiiddddeeee """"GGGG""""
     hides every label whose gate or offers contain the character
     G.

     See the bbbbccccgggg____llllaaaabbbbeeeellllssss(LOCAL) and ccccaaaaeeeessssaaaarrrr____hhhhiiiiddddeeee____1111(LOCAL) man pages
     for  more  information  on  the hide file format, and on the
     semantics  of  the  different  matching   modes.   See   the
     rrrreeeeggggeeeexxxxpppp(LOCAL)  man  page for information about the syntax of
     regular expression.










(C) INRIA            Last change: 2020/02/12                   10






CADP MANUAL PAGES                                      SVL(LOCAL)



  CCCCUUUUTTTTTTTTIIIINNNNGGGG
     ["total" | "partial" | "gate"] "cut" ["all" "but"] [_T_L] "in"
        _B
     ["end" "cut"]
     and
     ["total" | "partial" | "gate"] "cut" "using" _F "in"
        _B
     ["end" "cut"]
     will cut the labels found  in  _B  using  the  given  cutting
     rules.  These  rules  can  be  specified either as a list of
     (possibly typed) labels (first form), or using  an  external
     file _F (second form).

     In the first case, the types (usually channel names  defined
     in  an  LNT  program)  are purely ignored. SVL builds a tem-
     porary file with  extension  ....ccccuuuutttt,  filled  with  the  given
     labels.   In  the second case, the cut file must be provided
     by the user, with extension ....ccccuuuutttt.

     A label can be  a  gate  (possibly  followed  by  experiment
     offers)  or  a  regular expression denoting a gate (possibly
     followed by experiment offers). For instance, "G", "G.*", "G
     !1", "G. !.*" are labels. Among them, only "G" is a gate.  A
     channel name can be any LNT identifier (see <lnt-identifier>
     in  Section  BEHAVIOUR  EXPRESSIONS  above),  or  any string
     between double quotes.

     Double quotes around a label can be omitted if and  only  if
     the  label  is a gate. However, for compatibility with LOTOS
     syntax, gates that are not enclosed between quotes are  sys-
     tematically  turned to uppercase, unless the ----ccccaaaasssseeee option of
     ssssvvvvllll(LOCAL) is used. Note that double quotes are mandatory to
     avoid syntactic ambiguities when a gate has the same name as
     a reserved SVL  keyword  (e.g.  "reduction",  "all",  etc.).
     They are also mandatory to enable the use of shell variables
     denoting gates or labels as described in Section USING SHELL
     VARIABLES IN EXPRESSIONS.

     The "all but" keywords modify the semantics of  the  cutting
     rules:  all  the labels, except the labels specified in list
     _T_L, are cut in the given behaviour.

     The keywords  "total",  "partial",  and  "gate"  modify  the
     matching  mode, that is the way the cutting rules are inter-
     preted, see the eeeexxxxpppp....ooooppppeeeennnn(LOCAL) manual page. If no  matching
     mode is specified, then the default is "gate".

     For every cutting with "gate" matching, SVL  checks  whether
     the  gates  to  be cut have an appropriate syntax and emit a
     warning if they appear to contain experiment  offers  (which
     is a common mistake for novice users). For instance,
             ccccuuuutttt """"GGGG !!!!1111""""



(C) INRIA            Last change: 2020/02/12                   11






CADP MANUAL PAGES                                      SVL(LOCAL)



     will trigger a warning message because of the  occurence  of
     "!1".

     EEEExxxxaaaammmmpppplllleeeessss:

             ttttoooottttaaaallll ccccuuuutttt """"GGGG""""
     cuts every label equal to "G",
             ggggaaaatttteeee ccccuuuutttt """"GGGG""""
     cuts every label whose gate is G, e.g., "G !1", "G !2",
             ggggaaaatttteeee ccccuuuutttt """"....****GGGG....****""""
     cuts every label whose gate contains the character G and
             ppppaaaarrrrttttiiiiaaaallll ccccuuuutttt """"GGGG""""
     cuts every label whose gate or offers contain the  character
     G.

     See the eeeexxxxpppp....ooooppppeeeennnn(LOCAL) man page for more information on the
     cut  file  format,  and  on  the  semantics of the different
     matching modes. See the rrrreeeeggggeeeexxxxpppp(LOCAL) man page for  informa-
     tion about the syntax of regular expression.

  PPPPRRRRIIIIOOOORRRRIIIITTTTYYYY
     ["total" | "partial" | "gate"] "prio"
        (["all" "but"] [_L_L] (">" ["all" "but"] [_L_L])+)+ "in" _B
     ["end" "prio"]
     sets priorities between the transitions of _B.  In each state
     of  _B,  a transition may be executed only if all transitions
     of higher priority are not ready for execution.

     Priorities between  transitions  (or  equivalently,  between
     labels)  are  defined by a set of priority rules of the form
     _X_1 > ... > _X_n, where each _X_i (for _i ranging in 1..n) has the
     form  [all but] _L_L_i and _L_L_i is a list of regular expressions
     denoting gates or labels.  The "all but" keywords  that  may
     precede  some _L_L_i means all gates or labels but those match-
     ing _L_L_i.

     Such priority rules define a  transitive  relation  ">>"  on
     labels as follows:

     -    if _X > _X', the visible label _L of _B matches _X, and  the
          visible label _L' of _B matches _X' then _L >> _L'

     -    if _L >> _L' and _L' >> _L'' then _L >> _L''

     _L >> _L' means that any transition  labeled  _L  has  priority
     over any transition labeled _L' or, equivalently, any transi-
     tion labeled _L' yields priority to any transition labeled _L.

     The relation ">>" must be a strict partial order: _B must not
     contain  any  label  _L  such  that _L >> _L.  If ">>" is not a
     strict partial order, then the eeeexxxxpppp....ooooppppeeeennnn tool will  issue  an
     error message and then exit.



(C) INRIA            Last change: 2020/02/12                   12






CADP MANUAL PAGES                                      SVL(LOCAL)



     Beware that the rules _X  >  _X'  and  _X'  >  _X''  (which  are
     equivalent to _X > _X' > _X'') imply _X > _X'' only if some label
     of  _B  matches  _X'.   Therefore,  to  avoid  tricky  errors,
     eeeexxxxpppp....ooooppppeeeennnn  checks  that every individual regular expression _L
     in _L_L_1, ..., _L_L_n matches some label  of  _B.   If  not,  then
     eeeexxxxpppp....ooooppppeeeennnn will issue a warning.

     The optional "gate", "total", and "partial" keywords  define
     the  matching  mode,  in  the same way as for the "hide" and
     "cut" operators.  The matching mode by default is "gate".

     See the eeeexxxxpppp....ooooppppeeeennnn(LOCAL) manual page for details.

     EEEExxxxaaaammmmpppplllleeeessss:
             ggggaaaatttteeee pppprrrriiiioooo
                 """"AAAA....****"""" >>>> BBBB >>>> aaaallllllll bbbbuuuutttt """"AAAA....****"""",,,, BBBB
             iiiinnnn
                 """"ffff....bbbbccccgggg""""
             eeeennnndddd pppprrrriiiioooo
     defines an LTS in which every transition whose  gate  starts
     with the letter "A" has priority over every transition whose
     gate is "B", which themselves have priority over  all  other
     transitions.
             ppppaaaarrrrttttiiiiaaaallll pppprrrriiiioooo
                 """"AAAA"""" >>>> aaaallllllll bbbbuuuutttt """"AAAA""""
             iiiinnnn
                 """"ffff....bbbbccccgggg""""
             eeeennnndddd pppprrrriiiioooo
     defines an LTS in which every transition  whose  label  con-
     tains  the  letter  "A"  has  priority over every transition
     whose label does not contain the letter "A" (including  hid-
     den transitions).
             ttttoooottttaaaallll pppprrrriiiioooo
                 """"AAAA"""" >>>> """"BBBB"""" >>>> """"CCCC""""
                 """"DDDD"""" >>>> """"EEEE"""" >>>> """"FFFF""""
                 """"AAAA"""" >>>> """"DDDD""""
                 """"BBBB"""" >>>> """"EEEE""""
                 """"CCCC"""" >>>> """"FFFF""""
             iiiinnnn
                 """"ffff....bbbbccccgggg""""
             eeeennnndddd pppprrrriiiioooo
     defines an LTS in which:

     -    A has priority over B, C, D, E, and F,

     -    B has priority over C, E, and F,

     -    C has priority over F,

     -    D has priority over E and F, and

     -    E has priority over F.



(C) INRIA            Last change: 2020/02/12                   13






CADP MANUAL PAGES                                      SVL(LOCAL)



     Note: Strong bisimulation is a congruence for all  ssssvvvvllll  hid-
     ing,  cutting,  renaming, priority, and parallel composition
     operators  operators.   However,  branching,   divbranching,
     observational,  and  safety equivalences are congruences for
     all ssssvvvvllll hiding, cutting, renaming, and parallel  composition
     operators,  but  not  for priority.  It should also be noted
     that tau*.a equivalence is not  a  congruence  for  parallel
     composition.


  RRRREEEENNNNAAAAMMMMIIIINNNNGGGG
     ["total" | "single" | "multiple" | "gate"] "rename" _R_L "in"
        _B
     ["end" "rename"]
     and
     ["total" | "single" | "multiple" | "gate"] "rename"
        "using" _F "in" _B
     ["end" "rename"]
     will rename the labels of _B using the given renaming  rules.
     These  rules  can  be specified either as a list of rules of
     the form _L_1 "->" _L_2, where _L_1, _L_2 denote any  labels  (first
     form), or using an external file _F (second form).

     In the first case SVL builds a temporary file with extension
     ....rrrreeeennnn,  filled  with  the  given  substitution  rules. In the
     second case SVL uses the given renaming file,  whose  exten-
     sion must be ....rrrreeeennnn or ....rrrreeeennnnaaaammmmeeee.

     A label can be  a  gate  (possibly  followed  by  experiment
     offers)  or  a  regular expression denoting a gate (possibly
     followed by experiment offers). For instance, "G", "G.*", "G
     !1", "G. !.*" are labels. Among them, only "G" is a gate.

     Double quotes around a label can be omitted if and  only  if
     the label is a standard LOTOS gate. However, for compatibil-
     ity with LOTOS syntax, gates which are not enclosed  between
     quotes  are  systematically  turned to uppercase, unless the
     ----ccccaaaasssseeee option of ssssvvvvllll(local) is used. Note that double  quotes
     are mandatory to avoid syntactic ambiguities when a gate has
     the same name as a reserved SVL keyword  (e.g.  "reduction",
     "all", etc.) and that they enable the use of shell variables
     denoting gates or labels as described in Section USING SHELL
     VARIABLES IN EXPRESSIONS.

     The  keywords  "total",  "single",  "multiple",  and  "gate"
     modify the way the left hand sides of the renaming rules are
     interpreted, see the ccccaaaaeeeessssaaaarrrr____rrrreeeennnnaaaammmmeeee____1111(LOCAL) manual page.  If
     no matching mode is specified, then the default is "gate".

     For every renaming with "gate" matching, SVL checks  whether
     the  gates to be renamed have an appropriate syntax and emit
     a warning if they appear to contain experiment offers (which



(C) INRIA            Last change: 2020/02/12                   14






CADP MANUAL PAGES                                      SVL(LOCAL)



     is a common mistake for novice users). For instance,
             rrrreeeennnnaaaammmmeeee """"GGGG !!!!1111"""" ---->>>> """"GGGG !!!!2222""""
     will trigger a warning message because of the  occurence  of
     "!1". Note however that
             rrrreeeennnnaaaammmmeeee """"GGGG"""" ---->>>> """"GGGG !!!!1111""""
     is correct.

     EEEExxxxaaaammmmpppplllleeeessss:

             ttttoooottttaaaallll rrrreeeennnnaaaammmmeeee """"GGGG"""" ---->>>> """"HHHH""""
     renames to "H" every label equal to "G",
             ggggaaaatttteeee rrrreeeennnnaaaammmmeeee """"GGGG"""" ---->>>> """"HHHH""""
     renames to "H" the gate of every  label  whose  gate  is  G,
     e.g., "G !1", "G !2",
             ggggaaaatttteeee rrrreeeennnnaaaammmmeeee """"....****GGGG....****"""" ---->>>> """"HHHH""""
     renames to "H" the gate of every label whose gate contains a
     G,
             ssssiiiinnnngggglllleeee rrrreeeennnnaaaammmmeeee """"GGGG"""" ---->>>> """"HHHH""""
     replaces the first occurrence of "G" by "H" in  every  label
     whose gate or offers contain a G,
             mmmmuuuullllttttiiiipppplllleeee rrrreeeennnnaaaammmmeeee """"GGGG"""" ---->>>> """"HHHH""""
     replaces every occurrence of "G" by "H" in every label whose
     gate or offers contain a G, and
             ttttoooottttaaaallll rrrreeeennnnaaaammmmeeee """"\\\\(((([[[[AAAA----ZZZZ0000----9999]]]]****\\\\)))) \\\\((((!!!!....****\\\\))))"""" ---->>>> """"\\\\1111 !!!!1111 \\\\2222""""
     inserts "!1" between every gate and its first offer.

     See the bbbbccccgggg____llllaaaabbbbeeeellllssss(LOCAL) and ccccaaaaeeeessssaaaarrrr____rrrreeeennnnaaaammmmeeee____1111(LOCAL)  manual
     pages  for more information on these options and on the for-
     mat of renaming rules.  See also  the  rrrreeeeggggeeeexxxxpppp(LOCAL)  manual
     page for more information on regular expressions.


  RRRROOOOOOOOTTTT RRRREEEEDDDDUUUUCCCCTTTTIIIIOOOONNNN
     "root" ["total" | "partial"]
        [_E] ["probabilistic" | "stochastic"] "reduction"
        ["using" _M] ["with" _T] "of" _B
     or more simply
     ["total" | "partial"]
        [_E] ["probabilistic" | "stochastic"] "reduction"
        ["using" _M] ["with" _T] "of" _B
     will generate the behaviour _B (totally or partially) reduced
     modulo  the  reduction  relation _E, and possibly taking into
     account the probabilistic or stochastic information  present
     in  _B.  The  reduction is done with the tool _T and using the
     method _M.

     _T, _M, _E, "total", "partial", "probabilistic", and  "stochas-
     tic" are optional:

     -    Partial reduction is an incomplete form  of  reduction.
          Compared  to  total reduction, it generally generates a
          larger LTS but in a shorter time.  If  the  "total"  or



(C) INRIA            Last change: 2020/02/12                   15






CADP MANUAL PAGES                                      SVL(LOCAL)



          "partial"  keyword is not specified, then the reduction
          will be total.

     -    The "probabilistic"  and  "stochastic"  reductions  are
          only  available for strong, branching, and divbranching
          bisimulations with bcg_min and using the std method. In
          this  case, the behaviour _B must denote an explicit LTS
          containing probabilistic or stochastic information. See
          the bbbbccccgggg____mmmmiiiinnnn(LOCAL) manual page for more information.

     -    The default value for _E is "strong" and can be  changed
          via the shell variable DDDDEEEEFFFFAAAAUUUULLLLTTTT____RRRREEEEDDDDUUUUCCCCTTTTIIIIOOOONNNN____RRRREEEELLLLAAAATTTTIIIIOOOONNNN.

     -    The default value for  _M  depends  on  the  equivalence
          relation     considered.      The     shell    variable
          DDDDEEEEFFFFAAAAUUUULLLLTTTT____RRRREEEEDDDDUUUUCCCCTTTTIIIIOOOONNNN____MMMMEEEETTTTHHHHOOOODDDD can be set in the SVL file  to
          enforce a particular default value.

     -    The default value for _T depends on the relation  _E  and
          whether  the  reduction is partial or total, as summar-
          ized in the following table:

          +------------------+------------------+---------------+
          | relation         |      total       |    partial    |
          +------------------+------------------+---------------+
          | strong           |     bbbbccccgggg____mmmmiiiinnnn      |   rrrreeeedddduuuuccccttttoooorrrr    |
          | strong stoch.    |     bbbbccccgggg____mmmmiiiinnnn      | not available |
          | strong prob.     |     bbbbccccgggg____mmmmiiiinnnn      | not available |
          | tau-divergence   | rrrreeeedddduuuuccccttttoooorrrr+bbbbccccgggg____mmmmiiiinnnn |   rrrreeeedddduuuuccccttttoooorrrr    |
          | tau-compression  | rrrreeeedddduuuuccccttttoooorrrr+bbbbccccgggg____mmmmiiiinnnn |   rrrreeeedddduuuuccccttttoooorrrr    |
          | tau-confluence   | rrrreeeedddduuuuccccttttoooorrrr+bbbbccccgggg____mmmmiiiinnnn |   rrrreeeedddduuuuccccttttoooorrrr    |
          | branching        |     bbbbccccgggg____mmmmiiiinnnn      | not available |
          | branching stoch. |     bbbbccccgggg____mmmmiiiinnnn      | not available |
          | branching prob.  |     bbbbccccgggg____mmmmiiiinnnn      | not available |
          | divbranching     |     bbbbccccgggg____mmmmiiiinnnn      | not available |
          | divbr. stoch.    |     bbbbccccgggg____mmmmiiiinnnn      | not available |
          | divbr. prob.     |     bbbbccccgggg____mmmmiiiinnnn      | not available |
          | observational    |   aaaallllddddeeeebbbbaaaarrrraaaannnn      | not available |
          | tau*.a           | rrrreeeedddduuuuccccttttoooorrrr+bbbbccccgggg____mmmmiiiinnnn |   rrrreeeedddduuuuccccttttoooorrrr    |
          | safety           | rrrreeeedddduuuuccccttttoooorrrr+bbbbccccgggg____mmmmiiiinnnn |   rrrreeeedddduuuuccccttttoooorrrr    |
          | trace            | rrrreeeedddduuuuccccttttoooorrrr+bbbbccccgggg____mmmmiiiinnnn |   rrrreeeedddduuuuccccttttoooorrrr    |
          | weak trace       | rrrreeeedddduuuuccccttttoooorrrr+bbbbccccgggg____mmmmiiiinnnn |   rrrreeeedddduuuuccccttttoooorrrr    |
          +------------------+------------------+---------------+
          where "rrrreeeedddduuuuccccttttoooorrrr+bbbbccccgggg____mmmmiiiinnnn" means that the total _E  reduc-
          tion is done by first applying partial _E reduction with
          rrrreeeedddduuuuccccttttoooorrrr,  followed  by  total  strong  reduction  with
          bbbbccccgggg____mmmmiiiinnnn.

          The shell variable DDDDEEEEFFFFAAAAUUUULLLLTTTT____RRRREEEEDDDDUUUUCCCCTTTTIIIIOOOONNNN____TTTTOOOOOOOOLLLL can be set in
          the  SVL file to enforce a particular default value for
          _T.




(C) INRIA            Last change: 2020/02/12                   16






CADP MANUAL PAGES                                      SVL(LOCAL)



     EEEExxxxaaaammmmpppplllleeee::::

     %%%% DDDDEEEEFFFFAAAAUUUULLLLTTTT____RRRREEEEDDDDUUUUCCCCTTTTIIIIOOOONNNN____TTTTOOOOOOOOLLLL====""""rrrreeeedddduuuuccccttttoooorrrr""""
     %%%% DDDDEEEEFFFFAAAAUUUULLLLTTTT____RRRREEEEDDDDUUUUCCCCTTTTIIIIOOOONNNN____RRRREEEELLLLAAAATTTTIIIIOOOONNNN====""""ttttaaaauuuu****....aaaa""""
     """"aaaa____rrrreeeedddd....aaaauuuutttt"""" ==== ttttoooottttaaaallll rrrreeeedddduuuuccccttttiiiioooonnnn ooooffff """"aaaa....aaaauuuutttt""""

     will induce the total reduction modulo tau*.a of a.aut  with
     rrrreeeedddduuuuccccttttoooorrrr, and store the result in file a_red.aut.

     When a combination of total/partial reduction, tool, method,
     and  relation is not available, SVL tries to change (at run-
     time) some parameters to perform a (total or partial) reduc-
     tion  as  close  as possible to what appears to be expected,
     trying to preserve the parameters in the following  priority
     order:  stochastic  or  probabilistic  reduction,  reduction
     relation, reduction tool, reduction method, and  then  total
     or partial reduction.

     Moreover, if the reduction fails (for  instance  because  of
     memory exhaustion) then SVL tries to achieve it another way.
     For instance, using another tool, or performing a  reduction
     modulo a stronger equivalence relation to reduce the size of
     the LTS to reducee before re-attempting  the  weaker  reduc-
     tion. When all attempts fail, then the verification proceeds
     with the non reduced behaviour.

     Note: In some versions  of  CADP,  the  aaaallllddddeeeebbbbaaaarrrraaaannnn....oooolllldddd  tool,
     which  performs "observational reduction", may be not avail-
     able.  If this is the case, then SVL replaces "observational
     reduction"   by  "branching  reduction"  (performed  by  the
     bbbbccccgggg____mmmmiiiinnnn tool) and issues a warning message.


  LLLLEEEEAAAAFFFF RRRREEEEDDDDUUUUCCCCTTTTIIIIOOOONNNN
     "leaf" ["total" | "partial"]
        [_E] ["probabilistic" | "stochastic"] "reduction"
        ["using" _M] ["with" _T] "of" _B
     is a meta-operator that will (totally or  partially)  reduce
     the  LTSs  generated  as components of _B. As above, _T, _M, _E,
     the "total" and "partial" keywords and  the  "probabilistic"
     and  "stochastic" keywords are optional parameters (see RRRROOOOOOOOTTTT
     RRRREEEEDDDDUUUUCCCCTTTTIIIIOOOONNNN). The final result of a "leaf  reduction"  is  not
     necessarily  as  small  as  that obtained with "root", "root
     leaf", and "node reduction" since only components of  _B  are
     reduced.










(C) INRIA            Last change: 2020/02/12                   17






CADP MANUAL PAGES                                      SVL(LOCAL)



     The expansion rules of "leaf reduction" are the following:
     leaf reduction of _B = lRed (_B)

     lRed (_B_1 |_o_p| _B_2) = lRed (_B_1) |_o_p| lRed (_B_2)
     lRed (Hide (_X, _B_1 |_o_p| _B_2)) = Hide (_X, lRed (_B_1 |_o_p| _B_2))
     lRed (Hide (_X, _B)) = Red (Hide (_X, lRed (_B)))
                          (other cases)
     lRed (Cut (_X, _B_1 |_o_p| _B_2)) = Cut (_X, lRed (_B_1 |_o_p| _B_2))
     lRed (Cut (_X, _B)) = Red (Cut (_X, lRed (_B)))
                          (other cases)
     lRed (Prio (_X, _B_1 |_o_p| _B_2)) = Prio (_X, lRed (_B_1 |_o_p| _B_2))
     lRed (Prio (_X, _B)) = Red (Prio (_X, lRed (_B)))
                          (other cases)
     lRed (Ren (_X, _B_1 |_o_p| _B_2)) = Ren (_X, lRed (_B_1) |_o_p| lRed (_B_2))
     lRed (Ren (_X, _B)) = Red (Ren (_X, lRed (_B)))
                          (other cases)
     lRed (Abs (_B_1, _X, _B_2)) = Red (Abs (_B_1, _X, lRed(_B_2)))
     lRed (Gen (_B)) = Red (Gen (lRed (B)))
     lRed (_B) = Red (_B) otherwise
     where Red means  reduction,  Ren  means  rename,  Abs  means
     abstraction or refined abstraction (its first operand is the
     interface, and its third operand is  the  body),  Gen  means
     generation, _B, _B_1, _B_2 denote any behaviour, _X denotes either
     a file or a list of items (labels or  renaming  rules),  and
     |_o_p| denotes any parallel composition operator.

     Note  that  expansion  does  not  propagate  meta-operations
     across "reduction" operations, nor inside the interface part
     of the "abstraction" operation.

     Note also that, at the  end  of  the  expansion  phase,  the
     obtained  abstract  tree  is  cleaned to optimize execution.
     Therefore some "reduction" operators inserted  by  the  lRed
     function  are  then  removed  by  the cleaning function. For
     instance, any "reduction" operation inserted at the root  of
     the  body  of  an "abstraction" operation will be systemati-
     cally deleted to avoid the (useless and  expensive)  genera-
     tion of the behaviour to be abstracted. See Section CLEANING
     below.


  RRRROOOOOOOOTTTT LLLLEEEEAAAAFFFF RRRREEEEDDDDUUUUCCCCTTTTIIIIOOOONNNN
     "root leaf" ["total" | "partial"]
        [_E] ["probabilistic" | "stochastic"] "reduction"
        ["using" _M] ["with" _T] "of" _B
     is a meta-operator, which has  the  same  meaning  as  "root
     reduction of leaf reduction of _B".


  NNNNOOOODDDDEEEE RRRREEEEDDDDUUUUCCCCTTTTIIIIOOOONNNN
     "node" ["total" | "partial"]
        [_E] ["probabilistic" | "stochastic"] "reduction"



(C) INRIA            Last change: 2020/02/12                   18






CADP MANUAL PAGES                                      SVL(LOCAL)



        ["using" _M] ["with" _T] "of" _B
     is a meta-operator that will generate _B in  a  compositional
     way.  The  only  difference  between  "root  leaf" and "node
     reduction" is that "node reduction" performs also  reduction
     at  each  parallel  composition  node, and that hide and cut
     operators are propagated  as  far  as  possible  inside  the
     behaviour  expression.  As  above,  _T, _M, _E, the "total" and
     "partial" keywords and the "probabilistic" and  "stochastic"
     keywords are optional parameters (see RRRROOOOOOOOTTTT RRRREEEEDDDDUUUUCCCCTTTTIIIIOOOONNNN).

     The expansion rules of "node reduction" are the following:
     node reduction of B = Red (nRed (B))

     nRed (_B_1 |_o_p| _B_2) = Red (nRed (_B_1) |_o_p| nRed (_B_2))
     nRed (Hide (_X, _B)) = Red (Hide (_X, nRed (_B)))
     nRed (Cut (_X, _B)) = Red (Cut (_X, nRed (_B)))
     nRed (Prio (_X, _B)) = Red (Prio (_X, nRed (_B)))
     nRed (Ren (_X, _B)) = Red (Ren (_X, nRed (_B)))
     nRed (Abs (_B_1, _X, _B_2)) = Red (Abs (_B_1, _X, lRed (_B_2)))
     nRed (Gen (_B)) = Red (Gen (lRed (_B)))
     nRed (_B) = Red (_B) otherwise
     where Red means  reduction,  Ren  means  rename,  Abs  means
     abstraction or refined abstraction (its first operand is the
     interface, and its third operand is  the  body),  Gen  means
     generation, _B, _B_1, _B_2 denote any behaviour, _X denotes either
     a file or a list of items (labels or  renaming  rules),  and
     |_o_p| denotes any parallel composition operator.

     Note  that  expansion  does  not  propagate  meta-operations
     across "reduction" operations, nor inside the interface part
     of  the  "abstraction"  operation.   The  "node   reduction"
     becomes a "leaf reduction" (lRed) once it has passed through
     an "abstraction",  "refined  abstraction",  or  "generation"
     operator.

     Note also that, at the  end  of  the  expansion  phase,  the
     obtained  abstract  tree  is  cleaned to optimize execution.
     Therefore some "reduction" operators inserted  by  the  nRed
     function  are  then  removed  by  the cleaning function. For
     instance, any "reduction" operation inserted at the root  of
     the  body  of  an "abstraction" operation will be systemati-
     cally deleted to avoid the (useless and  expensive)  genera-
     tion of the behaviour to be abstracted. See Section CLEANING
     below.


  SSSSMMMMAAAARRRRTTTT RRRREEEEDDDDUUUUCCCCTTTTIIIIOOOONNNN
     "smart" ["total" | "partial"]
        [_E] ["probabilistic" | "stochastic"] "reduction"
        ["using" _M] ["with" _T] "of" _B
     is an operator that will generate _B in a  compositional  way
     using  a  smart  heuristic,  the  aim  being to try to avoid



(C) INRIA            Last change: 2020/02/12                   19






CADP MANUAL PAGES                                      SVL(LOCAL)



     generating too large intermediate LTSs.

     To do so, _B is first turned into a network  whose  LTSs  are
     minimized.  Then, SVL executes the following loop until this
     network contains only a single LTS:

     1    Automatically select several LTSs in the network;  this
          step  relies  on a heuristic metric (computed by exp2c)
          that depends on an estimate rate of hidden  transitions
          and an estimate rate of interleaved transitions belong-
          ing to the product of selected LTSs.

     2    Compose the selected LTSs in parallel.

     3    Generate  the  LTS  corresponding  to  the  composition
          obtained in step 2 and minimize it.

     4    Replace in the network the LTSs selected in step  1  by
          the LTS resulting from step 3; continue in step 1.

     The LTS corresponding to the  obtained  network  is  finally
     generated,  minimized, and returned as the LTS corresponding
     to _B.

     The maximal number of LTSs that can be selected in step 1 is
     bounded.  By default, the limit is set to 4.  This limit can
     be changed by assigning a different value  to  the  variable
     _D_E_F_A_U_L_T__S_M_A_R_T__L_I_M_I_T.

     Note: Unlike other meta-operations, "smart reduction" is not
     expanded.   Indeed,  the  expansion phase is static, whereas
     the order in which the LTSs in  _B  are  composed  by  "smart
     reduction" is determined at run time.


  GGGGEEEENNNNEEEERRRRAAAATTTTIIIIOOOONNNN
     "generation" "of" _B
     will force the generation of an explicit LTS  representation
     of _B. More precisely, if _B is an LNT, LOTOS, or FSP program,
     this program will be compiled, and  if  _B  has  an  implicit
     representation as a network of communicating automata in the
     EXP format, then an explicit representation  of  _B  will  be
     generated.

     There are some cases where  the  "generation"  operation  is
     implicit:

     -    generation of the body of a "hide", "cut", or  "rename"
          operation when it is a LNT, LOTOS, or FSP file;

     -    generation of the interface of an "abstraction"  opera-
          tion;



(C) INRIA            Last change: 2020/02/12                   20






CADP MANUAL PAGES                                      SVL(LOCAL)



     -    generation of the body of a "reduction" operation;

     Note that, during the expansion phase, meta-operators do not
     propagate  across  "generation"  operations  in the abstract
     syntax tree.


  PPPPAAAARRRRAAAALLLLLLLLEEEELLLL CCCCOOOOMMMMPPPPOOOOSSSSIIIITTTTIIIIOOOONNNN
     _B "||" _B
     and
     _B "|||" _B
     and
     _B "|[" [_L_L] "]|" _B
     have the LOTOS  semantics  of  parallel  composition:  "|||"
     denotes  parallel composition with synchronization on termi-
     nation only, "||" denotes  parallel  composition  with  syn-
     chronization  on  all  gates,  and  at  last  "|[" [_L_L] "]|"
     denotes parallel composition with synchronization on  termi-
     nation and on gates specified in the optional list of labels
     _L_L.


  GGGGEEEENNNNEEEERRRRAAAALLLLIIIIZZZZEEEEDDDD PPPPAAAARRRRAAAALLLLLLLLEEEELLLL
     ["label" | "gate"] "par" [("all" | _L_D) "in"]
        [_L_D "->"] _B ("||" [_L_D "->"] _B)+
     "end par"
     is an extension of the E-LOTOS/LNT generalized parallel com-
     position  operator.   It denotes the concurrent execution of
     parallel   behaviours   following   synchronisation    rules
     expressed using:

     -    the keyword "all" or the list  "_L_D"  that  follows  the
          keyword "par", called _g_l_o_b_a_l _s_y_n_c_h_r_o_n_i_s_a_t_i_o_n _i_n_t_e_r_f_a_c_e,
          and

     -    the lists _L_D that  precede  the  symbols  "->",  called
          _l_o_c_a_l _s_y_n_c_h_r_o_n_i_s_a_t_i_o_n _i_n_t_e_r_f_a_c_e_s.

     Synchronisation interfaces _L_D are lists  of  synchronisation
     elements  of the form _L or _L#_N, where _L is a gate or a label
     and _N is a natural number called _s_y_n_c_h_r_o_n_i_s_a_t_i_o_n _d_e_g_r_e_e.

     The semantics of synchronisation rules are  defined  in  the
     following paragraphs.

     -    The "gate" or "label" keywords indicate the  _s_y_n_c_h_r_o_n_i_-
          _s_a_t_i_o_n  _m_o_d_e,  which influences the way synchronisation
          rules apply to transition labels.  We say that a  tran-
          sition  matches a synchronisation element of the form _L
          or _L#_N in the following cases:
          In "gate" synchronisation mode, a transition matches  _L
          or  _L#_N  if  the  gate  of  the  transition label is _L.



(C) INRIA            Last change: 2020/02/12                   21






CADP MANUAL PAGES                                      SVL(LOCAL)



          Therefore, for every  synchronisation  element  of  the
          form _L or _L#_N occurring in a synchronisation interface,
          _L must be a gate without offers.
          In "label" synchronisation mode, a transition matches _L
          or  _L#_N  if  the transition label is _L.  Therefore, for
          every synchronisation element of  the  form  _L  or  _L#_N
          occurring  in  a synchronisation interface, _L must be a
          full label (i.e., a gate possibly followed by offers).
          Unlike "hide", "cut", and "rename", regular expressions
          are  not  allowed  in synchronisation elements.  If not
          specified,  the  synchronisation  mode  by  default  is
          "gate".

     -    The keyword "all" is a shorthand notation for the  glo-
          bal  synchronisation set consisting of all synchronisa-
          tion elements _L (without degree) such  that  _L  is  the
          gate  (in "gate" synchronisation mode) or the label (in
          "label" synchronisation mode) of  a  transition  in  at
          least  one  of  the parallel behaviours, except transi-
          tions carrying hidden events.

     Synchronisation elements have the following meaning:

     -    A  synchronisation  element  of  the  form  _L  (without
          degree)  occurring in the global synchronisation inter-
          face indicates that all parallel  behaviours  may  syn-
          chronize all together on transitions that match _L.

     -    A  synchronisation  element  of  the  form  _L  (without
          degree)  occurring in a local synchronisation interface
          indicates that all parallel behaviours that  contain  _L
          in  their synchronisation interface may synchronize all
          together on transitions that match _L.

     -    A synchronisation element of the form _L#_N occurring  in
          the  global  synchronisation interface indicates that _N
          behaviours among the parallel behaviours may  synchron-
          ize together on transitions that match _L.

     -    A synchronisation element of the form _L#_N occurring  in
          a  local  synchronisation  interface  indicates  that _N
          behaviours among the parallel behaviours  that  contain
          _L#_N  in their synchronisation interface may synchronize
          on transitions that match _L.

     -    A transition in a parallel behaviour may execute  asyn-
          chronously if both the global synchronization interface
          and  the  local  synchronization  interface   of   that
          behaviour  do  not contain any element of the form _L or
          _L#_N such that the transition matches _L....





(C) INRIA            Last change: 2020/02/12                   22






CADP MANUAL PAGES                                      SVL(LOCAL)



     Note that both  the  global  synchronisation  interface  and
     local  synchronisation  interfaces  may contain several syn-
     chronisation elements with same label _L but  different  syn-
     chronisation  degrees.  In this case, the corresponding syn-
     chronisation rules apply nondeterministically.

     Following the above meaning of synchronisation elements,  it
     is  possible  to prevent the execution of particular transi-
     tions matching _L by using synchronisation  elements  of  the
     form  _L#_0,  either  in  the global synchronisation interface
     (thus preventing execution of transitions matching _L in  all
     parallel  behaviours) or in local synchronisation interfaces
     (thus preventing execution  of  transitions  matching  _L  in
     those  behaviours  containing  _L#_0 in their interface), pro-
     vided the (global  or  local)  interface  does  not  contain
     another  occurrence  of  _L or _L#_N with _N a strictly positive
     number.

     Transition synchronisation is a generalization of LOTOS ren-
     dezvous:  synchronisation requires that all transitions have
     exactly the same label (i.e.,  gate  and  possible  offers),
     which is also the label of the resulting transition.

     Note that synchronization interfaces can neither contain the
     hidden  gate  nor  the  termination gate.  Behaviours always
     synchronize on labels whose gate is the termination gate and
     never synchronize on hidden events.

     The   following   syntactic   restrictions    (checked    by
     eeeexxxxpppp....ooooppppeeeennnn(LOCAL))sssshhhhoooouuuullllddddhold:

     -    If the global synchronisation interface contains a syn-
          chronisation  element  of the form _L#_N with _N > 0, then
          the parallel composition must contain at least _N paral-
          lel behaviours.

     -    If the global synchronisation interface contains a syn-
          chronisation element of the form _L#_0, then no synchron-
          isation element of the form _L or _L#_N with same _L and  _N
          >  0  should occur in the global synchronization inter-
          face or in any local synchronization interface.

     -    If a local synchronisation interface  contains  a  syn-
          chronisation  element  of  the form _L (without degree),
          then at  least  two  local  synchronisation  interfaces
          (this  one included) should contain the same synchroni-
          sation element.

     -    If a local synchronisation interface  contains  a  syn-
          chronisation  element  of the form _L#_N with _N > 0, then
          at least _N local synchronisation interfaces  (this  one
          included)   should  contain  the  same  synchronisation



(C) INRIA            Last change: 2020/02/12                   23






CADP MANUAL PAGES                                      SVL(LOCAL)



          element.

     -    If a local synchronisation interface  contains  a  syn-
          chronisation element of the form _L#_0, then no synchron-
          isation element of the form _L or _L#_N with same _L and  _N
          >  0  should occur in the global synchronization inter-
          face or in the same local synchronization interface.

  AAAABBBBSSSSTTTTRRRRAAAACCCCTTTTIIIIOOOONNNN
     ["total" | "partial" | "gate"] ["user"] "abstraction" _B
        "sync" [_L_L] "of" _B
     and
     ["total" | "partial" | "gate"] ["user"] "abstraction" _B
        "sync" "using" _F "of" _B
     and
     ["total" | "partial" | "gate"] ["user"] "abstraction" _B
        "of" _B
     denote abstraction using an  interface,  also  called  semi-
     composition.  It  allows to restrict the rightmost behaviour
     with respect to its environment i.e., an  expression  called
     the interface and a synchronization set.

     Interfaces can be either ``exact'' interfaces i.e., parts of
     the  syntactic  environment of the sub-expression to be res-
     tricted, or ``user-given'' interfaces i.e., expressions that
     are  supposed to correctly approximate this environment. The
     second case must be expressed with the "user"  keyword  that
     involves the generation of some validation predicates in the
     produced LTS. These predicates are checked afterwards,  when
     the  components obtained by user abstractions are recomposed
     together. SVL issues a warning message if the check fails.

     Similarly to hide, cut, and rename operators, the synchroni-
     zation  set  can  be given explicitly as a list of labels in
     the abstraction expression, or in  a  ....ssssyyyynnnncccc  file.  See  the
     pppprrrroooojjjjeeeeccccttttoooorrrr(LOCAL)  manual  page  for  more information on the
     sync file format.

     A label can be  a  gate  (possibly  followed  by  experiment
     offers)  or  a  regular expression denoting a gate (possibly
     followed by experiment offers). For instance, "G", "G.*", "G
     !1", "G. !.*" are labels. Among them, only "G" is a gate.

     Double quotes around a label can be omitted if and  only  if
     the  label  is a gate . However, gates that are not enclosed
     between  quotes  are  systematically  turned  to  uppercase,
     unless  the  ----ccccaaaasssseeee  option  of ssssvvvvllll(LOCAL) is used. Note that
     double quotes are mandatory to avoid  syntactic  ambiguities
     when  a  gate  has  the  same name as a reserved SVL keyword
     (e.g. "reduction", "all", etc.).  They are also mandatory to
     enable  the  use of shell variables denoting gates or labels
     as  described  in   Section   USING   SHELL   VARIABLES   IN



(C) INRIA            Last change: 2020/02/12                   24






CADP MANUAL PAGES                                      SVL(LOCAL)



     EXPRESSIONS.

     The "all but" keywords modify the semantics of the synchron-
     ization  rules:  all the labels, except the labels specified
     in list _L_L, must be used in the synchronization between  the
     given behaviour and its interface.

     The keywords  "total",  "partial",  and  "gate"  modify  the
     matching mode, that is the way the synchronization rules are
     interpreted, see the pppprrrroooojjjjeeeeccccttttoooorrrr(LOCAL)  manual  page.  If  no
     matching mode is specified, then the default is "gate".

     If no synchronization set is given (no "sync" keyword),  the
     synchronization is done as follows:

     -    In "gate" matching mode, synchronization is done on all
          gates visible in the interface.

     -    In "total" or "partial" matching mode,  synchronization
          is done on all labels visible in the interface.

     For every  abstraction  with  "gate"  matching,  SVL  checks
     whether  the  gates  to  be synchronized have an appropriate
     syntax and emit a warning if they appear to contain  experi-
     ment  offers  (which  is a common mistake for novice users).
     For instance,
             aaaabbbbssssttttrrrraaaaccccttttiiiioooonnnn ............ ssssyyyynnnncccc """"GGGG !!!!1111""""
     will trigger a warning message because of the  occurence  of
     "!1".

     EEEExxxxaaaammmmpppplllleeeessss:

             ttttoooottttaaaallll aaaabbbbssssttttrrrraaaaccccttttiiiioooonnnn ............ ssssyyyynnnncccc """"GGGG""""
     synchronizes every label equal to "G",
             ggggaaaatttteeee aaaabbbbssssttttrrrraaaaccccttttiiiioooonnnn ............ ssssyyyynnnncccc """"GGGG""""
     synchronizes every label whose gate is G, e.g., "G  !1",  "G
     !2",
             ggggaaaatttteeee aaaabbbbssssttttrrrraaaaccccttttiiiioooonnnn ............ ssssyyyynnnncccc """"....****GGGG....****""""
     synchronizes every label whose gate contains the character G
     and
             ppppaaaarrrrttttiiiiaaaallll aaaabbbbssssttttrrrraaaaccccttttiiiioooonnnn ............ ssssyyyynnnncccc """"GGGG""""
     synchronizes every label whose gate or  offers  contain  the
     character G.

     See the pppprrrroooojjjjeeeeccccttttoooorrrr(LOCAL) man page for  more  information  on
     the  sync file format, and on the semantics of the different
     matching modes. See the rrrreeeeggggeeeexxxxpppp(LOCAL) man page for  informa-
     tion about the syntax of regular expression.

     Before doing the semi-composition, SVL does the following to
     optimize verification efficiency:




(C) INRIA            Last change: 2020/02/12                   25






CADP MANUAL PAGES                                      SVL(LOCAL)



     -    It hides in the interface all gates or labels  (depend-
          ing  on  the  matching mode), except those which are in
          the synchronization list.

     -    It reduces the interface modulo safety equivalence.


  IIIINNNNFFFFIIIIXXXX AAAABBBBSSSSTTTTRRRRAAAACCCCTTTTIIIIOOOONNNN OOOOPPPPEEEERRRRAAAATTTTOOOORRRRSSSS
     _B_1 "-||" ["?"] _B_2
     and
     _B_1 "-|||" ["?"] _B_2
     and
     _B_1 "-|[" [_L_L] "]|" ["?"] _B_2
     are shorthand notations for, respectively,
     ["user"] "abstraction" _B_2 "of" _B_1
     and
     ["user"] "abstraction" _B_2 "sync" "of" _B_1
     and
     ["user"] "abstraction" _B_2 "sync" [_L_L] "of" _B_1
     where the "?" symbol has the same meaning as the "user" key-
     word.


  RRRREEEEFFFFIIIINNNNEEEEDDDD AAAABBBBSSSSTTTTRRRRAAAACCCCTTTTIIIIOOOONNNN
     "refined" ["user"] "abstraction" _L_L ["using" _B] "of" _B
     allows to restrict the rightmost behaviour  expression  (the
     _b_o_d_y)  with  respect to some of its neighbours (specified in
     the list _L_L).

     The neighbours are those behaviour systems (LTS files, files
     containing  networks  of  LTSs, LNT, LOTOS, or FSP files, or
     processes in LNT, LOTOS, or  FSP  files)  that  are  in  the
     environment  of  (i.e., composed in parallel with) the body.
     The identifier of a neighbour is  either  its  process  name
     (without  offer parameters) in the case of a process, or its
     filename (with extension and between quotes)  in  all  other
     cases.   Each  label in _L_L must be the identifier of exactly
     one neighbour (see examples below).

     The behaviour expression that follows the  "using"  keyword,
     if  present,  should provide a set of labels, which includes
     all labels that can be fired by the body.   Its  states  and
     transitions  are simply ignored.  These labels allow to com-
     pute the possible synchronizations between the body and  its
     environment,  without having to generate the LTS correspond-
     ing to the body.  This expression is required if the body is
     an LNT, LOTOS, or FSP file or a process in an LNT, LOTOS, or
     FSP file and can be omitted otherwise.  If  the  body  is  a
     parallel  composition expression (encoded in an EXP file) or
     an EXP file, this set is computed  automatically  using  the
     eeeexxxxpppp....ooooppppeeeennnn(LOCAL) tool.  If the body is neither an LNT, LOTOS,
     or FSP file, a process in an LNT,  LOTOS,  or  FSP  file,  a



(C) INRIA            Last change: 2020/02/12                   26






CADP MANUAL PAGES                                      SVL(LOCAL)



     parallel  composition  expression, nor an EXP file, then its
     LTS is generated and serves as label set.

     The "user" keyword should  be  used  when  the  user  cannot
     guarantee  that  the  label  set provided by this expression
     includes all labels that can be fired by the body.  In  this
     case, validation predicates will be generated in the result-
     ing LTS, and warning messages will be issued if the  valida-
     tion predicates are not satisfied.

     Refined abstraction executes in two steps:  in a first step,
     an  interface  and  a  synchronization set will be generated
     automatically from the  behaviours  of  neighbours  and  the
     environment  of  the  expression,  using the eeeexxxxpppp....ooooppppeeeennnn(LOCAL)
     tool; during this step, the LTSs of  neighbours  in  _L_L  are
     automatically  minimized modulo safety equivalence, so as to
     generate as small an interface  as  possible;  in  a  second
     step,  the interface and synchronization set obtained during
     the first step are used to  restrict  the  body,  using  the
     pppprrrroooojjjjeeeeccccttttoooorrrr(LOCAL) tool.

     EEEExxxxaaaammmmpppplllleeeessss::::

     The following expressions are examples of correct  usage  of
     the "refined abstraction" operator:
     """"aaaa....bbbbccccgggg"""" ==== nnnnooooddddeeee ssssttttrrrroooonnnngggg rrrreeeedddduuuuccccttttiiiioooonnnn ooooffff
       ((((
         PPPP
       ||||||||
         ((((
           ((((rrrreeeeffffiiiinnnneeeedddd aaaabbbbssssttttrrrraaaaccccttttiiiioooonnnn PPPP,,,, """"rrrr....bbbbccccgggg"""" uuuussssiiiinnnngggg """"qqqq....bbbbccccgggg"""" ooooffff QQQQ))))
         ||||||||
           hhhhiiiiddddeeee AAAA iiiinnnn """"rrrr....bbbbccccgggg""""
         ))))
       ))))
     """"aaaa....bbbbccccgggg"""" ==== ggggeeeennnneeeerrrraaaattttiiiioooonnnn ooooffff
       ((((
         PPPP
       ||||||||
         ((((
           rrrreeeeffffiiiinnnneeeedddd aaaabbbbssssttttrrrraaaaccccttttiiiioooonnnn PPPP ooooffff
             ((((
               QQQQ
             ||||||||
               ((((rrrreeeeffffiiiinnnneeeedddd aaaabbbbssssttttrrrraaaaccccttttiiiioooonnnn PPPP,,,, QQQQ uuuussssiiiinnnngggg """"rrrr....bbbbccccgggg"""" ooooffff RRRR))))
             ))))
         ))))
       ))))

     The following expression is an example of incorrect usage of
     the  "refined  abstraction" operator, where Q has two neigh-
     bours  whose  identifier  is  P,  and  no  neighbour   whose



(C) INRIA            Last change: 2020/02/12                   27






CADP MANUAL PAGES                                      SVL(LOCAL)



     identifier is R:
     """"aaaa....bbbbccccgggg"""" ==== ggggeeeennnneeeerrrraaaattttiiiioooonnnn ooooffff
       ((((
         PPPP
       ||||||||
         ((((
           ((((rrrreeeeffffiiiinnnneeeedddd aaaabbbbssssttttrrrraaaaccccttttiiiioooonnnn PPPP,,,, RRRR uuuussssiiiinnnngggg """"qqqq....bbbbccccgggg"""" ooooffff QQQQ))))
         ||||||||
           hhhhiiiiddddeeee AAAA iiiinnnn PPPP
         ))))
       ))))


  CCCCHHHHAAAAOOOOSSSS AAAAUUUUTTTTOOOOMMMMAAAATTTTAAAA
     "chaos" "using" _F
     and
     "chaos" "with" _L_L
     and
     "chaos" "with" _n "labels" _L_P
     generate an LTS with a single state and looping transitions,
     using the bcg_graph tool.

     There are several ways to define the transition labels:

     -    Using a file _F (first form): _F must be the full name of
          an   existing   file,  no  particular  extension  being
          required.  Each  label  in  _F  must  be  written  on  a
          separate  line,  and  may  be enclosed in double quotes
          that are removed in the generated LTS.

     -    Using a label list _L_L (second form):  _L_L is a  list  of
          any  length.  In  this  case, SVL generates a temporary
          file used by bcg_graph.

     -    Using a label pattern _L_P and a number _n  (third  form):
          _L_P  must  be enclosed between double quotes and contain
          exactly one occurrence of  the  substring  "%d".   This
          pattern denotes exactly _n different labels, obtained by
          replacing the occurrence of  "%d"  by  numbers  in  the
          range  1.._n.   _n  must be a natural number (sequence of
          digits), possibly enclosed between  double  quotes.  It
          can  also  be  defined using a shell variable (in which
          case double quotes are mandatory), such as  e.g.,  "$N"
          and "${N}0".

     See the bbbbccccgggg____ggggrrrraaaapppphhhh(LOCAL) manual page for more information.

     EEEExxxxaaaammmmpppplllleeee::::

     If "labels" is a file containing three labels  A1,  A2,  and
     A3,  then  the  following  three  behaviours denote the same
     explicit  LTS  that  contains  a  unique  state  and   three



(C) INRIA            Last change: 2020/02/12                   28






CADP MANUAL PAGES                                      SVL(LOCAL)



     transitions  from  and  to this state, labelled respectively
     A1, A2, and A3.

         cccchhhhaaaaoooossss uuuussssiiiinnnngggg """"llllaaaabbbbeeeellllssss""""
         cccchhhhaaaaoooossss wwwwiiiitttthhhh 3333 llllaaaabbbbeeeellllssss """"AAAA%%%%dddd""""
         cccchhhhaaaaoooossss wwwwiiiitttthhhh """"AAAA1111"""",,,, """"AAAA2222"""",,,, """"AAAA3333""""


  BBBBAAAAGGGGSSSS AAAANNNNDDDD FFFFIIIIFFFFOOOO BBBBUUUUFFFFFFFFEEEERRRRSSSS
     "bag" _m "using" _F
     and
     "bag" _m "with" _L_L
     and
     "bag" _m "with" _n "labels" _L_P_1 "," _L_P_2
     and
     "fifo" _m "using" _F
     and
     "fifo" _m "with" _L_L
     and
     "fifo" _m "with" _n "labels" _L_P_1 "," _L_P_2
     generate an LTS modeling a communication buffer of  size  _m,
     which  can  be either a bag (i.e., a communication buffer in
     which the ordering of messages is not enforced)  or  a  FIFO
     (First In/First Out) buffer.

     _m must be a natural number (sequence  of  digits),  possibly
     enclosed between double quotes. it can also be defined using
     shell variables (in which case double quotes are mandatory),
     such as e.g., "$N" and "${N}0".

     Buffers distinguish between  two  kinds  of  labels,  namely
     _i_n_p_u_t_s  and  _o_u_t_p_u_t_s,  modeling respectively the ingoing and
     outgoing  messages.   Each  _i_n_p_u_t   is   paired   with   the
     corresponding _o_u_t_p_u_t.

     There are several ways to define the labels handled  by  the
     buffer:

     -    Using a file _F (first and fourth forms): _F must be  the
          full  name of an existing file, no particular extension
          being required.  Each label in file _F must  be  written
          on  a  separate  line,  and  may  be enclosed in double
          quotes that are removed in the generated  LTS.   Labels
          occurring  in  odd (respectively even) positions in the
          file denote _i_n_p_u_t_s (respectively _o_u_t_p_u_t_s).  Each  _i_n_p_u_t
          is paired with the following _o_u_t_p_u_t label in the file.

     -    Using a label list _L_L (second and fifth forms):  _L_L  is
          a list of even length. Labels occurring in odd (respec-
          tively  even)  positions  in  the  list  denote  _i_n_p_u_t_s
          (respectively  _o_u_t_p_u_t_s).  Each _i_n_p_u_t is paired with the
          following _o_u_t_p_u_t in the label list.  In this case,  SVL



(C) INRIA            Last change: 2020/02/12                   29






CADP MANUAL PAGES                                      SVL(LOCAL)



          generates a temporary label file used by bcg_graph.

     -    Using two label patterns _L_P_1, _L_P_2 and a number _n (third
          and  sixth forms): Each of _L_P_1 and _L_P_2 must be enclosed
          between  double  quotes   and   contain   exactly   one
          occurrence  of  the  substring  "%d".   These  patterns
          denote exactly 2_n different labels, obtained by replac-
          ing  the  occurrences  of  "%d" by numbers in the range
          1.._n.  _L_P_1  (respectively  _L_P_2)  defines  the  form  of
          _i_n_p_u_t_s  (respectively _o_u_t_p_u_t_s).  _i_n_p_u_t_s and _o_u_t_p_u_t_s are
          paired when they are obtained by instanciating _L_P_1  and
          _L_P_2  with  the same number.  _n must be a natural number
          (sequence of digits), possibly enclosed between  double
          quotes.  It  can  also be defined using shell variables
          (in which case double quotes are  mandatory),  such  as
          e.g., "$N" and "${N}0".

     See the bbbbccccgggg____ggggrrrraaaapppphhhh(LOCAL) manual page for more information.

     EEEExxxxaaaammmmpppplllleeee::::

     If "labels" is a file containing four labels INPUT1, INPUT2,
     OUTPUT1,  and  OUTPUT2,  then the following three behaviours
     denote the same explicit LTS that models a FIFO buffer  with
     4 places and exchanging 2 different messages.

         ffffiiiiffffoooo 4444 uuuussssiiiinnnngggg """"llllaaaabbbbeeeellllssss""""
         ffffiiiiffffoooo 4444 wwwwiiiitttthhhh 2222 llllaaaabbbbeeeellllssss """"IIIINNNNPPPPUUUUTTTT%%%%dddd"""",,,, """"OOOOUUUUTTTTPPPPUUUUTTTT%%%%dddd""""
         ffffiiiiffffoooo 4444 wwwwiiiitttthhhh """"IIIINNNNPPPPUUUUTTTT1111"""",,,, """"OOOOUUUUTTTTPPPPUUUUTTTT1111"""",,,, """"IIIINNNNPPPPUUUUTTTT2222"""",,,, """"OOOOUUUUTTTTPPPPUUUUTTTT2222""""


  CCCCLLLLEEEEAAAANNNNIIIINNNNGGGG
     Since the expansion phase may generate some redundant opera-
     tions, the tree of the behaviour is always cleaned using the
     following clean function:




















(C) INRIA            Last change: 2020/02/12                   30






CADP MANUAL PAGES                                      SVL(LOCAL)



     clean (Gen (Gen (_B))) = clean (Gen(_B))
     clean (Gen (_S_P_E_C)) =
             Gen (_S_P_E_C) if LNT, LOTOS, FSP, or EXP
             _S_P_E_C       otherwise
     clean (Gen (Stop)) = Stop
     clean (Gen (Abs (_B_1, _L, _B_2))) = clean (Abs(_B_1, _L, _B_2))
     clean (Gen (Red (_B))) = clean (Red (_B))
     clean (Gen (_B)) = Gen (clean (_B))
     clean (Hide (_L, Hide (_L', _B)) = clean (Hide (_L u _L', _B))
                               if matching modes are the same
     clean (Hide (_X, Stop)) = Stop
     clean (Hide (_X, _B)) = Hide (_X, clean (_B))
     clean (Cut (_L, Cut (_L', _B)) = clean (Cut (_L u _L', _B))
                               if matching modes are the same
     Clean (Cut (_L, Stop)) = Stop
     clean (Cut (_X, _B)) = Cut (_X, clean (_B))
     clean (Prio (_X, _B)) = Prio (_X, clean (_B))
     clean (_B_1 |_o_p| _B_2) = clean (_B_1) |_o_p| clean (_B_2)
     clean (Abs (Stop, _L, _B_2)) = Stop
     clean (Abs (_B_1, _L, _B_2)) = Abs (clean (_B_1), _L, clean (_B_2))
     clean (Red (Red' (_B))) = clean (Red' (_B)) if Red' <= Red
     clean (Red (Gen (Red (_B)))) = clean (Red (Gen (_B)))
     clean (Red (Abs (_B_1, _L, Red (_B_2)))) =
                                   clean (Red (Abs (_B_1, _L, _B_2)))
     clean (Red (Hide (_L, Red (_B)))) = clean (Red (Hide (_L, _B)))
     clean (Red (Cut (_L, Red (_B)))) = clean (Red (Cut (_L, _B)))
     clean (Red (Ren (_X, Red (_B)))) = clean (Red (Ren (_X, _B)))
     clean (Red (Stop)) = Stop
     clean (Red (_B)) = Red (clean (_B))
     clean (Ren (_X, Stop)) = Stop
     clean (Ren (_X, _B)) = Ren (_X, clean (_B))
     clean (_B) = _B otherwise
     where Red <= Red'  means  Red  denotes  reduction  modulo  a
     weaker  (<)  or  equal  (=)  reduction relation than this of
     Red'. The "weaker" (partial order) relation  is  represented
     by the diagram below, where an arrow goes from R to R' if R'



















(C) INRIA            Last change: 2020/02/12                   31






CADP MANUAL PAGES                                      SVL(LOCAL)



     < R:

                        ssssttttrrrroooonnnngggg
                           ||||
                     ++++--------------------++++--------------------++++
                     ||||           ||||
                     ||||     ttttaaaauuuu----ddddiiiivvvveeeerrrrggggeeeennnncccceeee --------------------------------++++
                     ||||           ||||                ||||
                     ||||     ttttaaaauuuu----ccccoooommmmpppprrrreeeessssssssiiiioooonnnn        ||||
                     ||||           ||||          ddddiiiivvvvbbbbrrrraaaannnncccchhhhiiiinnnngggg
                     ||||     ttttaaaauuuu----ccccoooonnnnfffflllluuuueeeennnncccceeee         ||||
                     ||||           ||||                ||||
                   ttttrrrraaaacccceeee     bbbbrrrraaaannnncccchhhhiiiinnnngggg --------------------------------------------++++
                     ||||           ||||
                     ||||      ++++----------------++++----------------++++
                     ||||      ||||         ||||
                     ||||   ttttaaaauuuu****....aaaa  oooobbbbsssseeeerrrrvvvvaaaattttiiiioooonnnnaaaallll
                     ||||      ||||         ||||
                     ||||      ++++----------------++++----------------++++
                     ||||           ||||
                     ||||        ssssaaaaffffeeeettttyyyy
                     ||||           ||||
                     ++++--------------------++++--------------------++++
                           ||||
                       wwwweeeeaaaakkkk ttttrrrraaaacccceeee


SSSSEEEEMMMMAAAANNNNTTTTIIIICCCCSSSS OOOOFFFF SSSSTTTTAAAATTTTEEEEMMMMEEEENNNNTTTTSSSS
     The semantics of statements is defined as follows:


  AAAASSSSSSSSIIIIGGGGNNNNMMMMEEEENNNNTTTT
     _F "=" _B
     will store in file _F the system resulting from the behaviour
     expression  _B, with possibly format conversion. _F is created
     in the current directory.

     The file format of _F  can  be  LOTOS  (extension  ....lllloooottttoooossss  or
     ....llllooootttt),  BCG  (extension  ....bbbbccccgggg),  AUT  (extension  ....aaaauuuutttt), SEQ
     (extension ....sssseeeeqqqq), FC2 (extension ....ffffcccc2222),  or  EXP  (extension
     ....eeeexxxxpppp).  The following rules apply:

     -    If the file format of _F is LOTOS, then _B must be an LNT
          file  (extension ....llllnnnntttt).  In this case, the LOTOS file _F
          is the result of translating the LNT file _B into  LOTOS
          using llllnnnntttt....ooooppppeeeennnn.  Note that _F can only be overwritten by
          a subsequent assignment statement having  explicitly  _F
          as left-hand side.  Therefore, an error message will be
          issued and the script execution will be stopped  if  an
          attempt  is made at overwriting _F in another way, i.e.,
          if an LNT file with same prefix as _F is used in  subse-
          quent behaviour expressions.



(C) INRIA            Last change: 2020/02/12                   32






CADP MANUAL PAGES                                      SVL(LOCAL)



     -    If _B is an LNT, LOTOS, or FSP file, or if _B is  a  net-
          work  of  communicating  automata (parallel composition
          expression) and the format of _F is this of an  explicit
          LTS,  then  SVL  issues  a  warning  message  since the
          behaviour _B should be generated before being  assigned.
          However, the generation is done automatically by SVL.

     Assignment to EXP files must be used  cautiously,  as  shows
     the following example.

     Consider the following program, where <<<<BBBB1111>>>>, <<<<BBBB2222>>>>,  and  <<<<BBBB3333>>>>
     are arbitrary behaviours.
     """"aaaa....bbbbccccgggg"""" ==== <<<<BBBB1111>>>>;;;;
     """"cccc....bbbbccccgggg"""" ==== <<<<BBBB2222>>>>;;;;
     """"bbbb....eeeexxxxpppp"""" ==== """"aaaa....bbbbccccgggg"""" |||||||||||| """"cccc....bbbbccccgggg"""";;;;
     """"aaaa....bbbbccccgggg"""" ==== <<<<BBBB3333>>>>;;;;
     """"dddd....bbbbccccgggg"""" ==== ggggeeeennnneeeerrrraaaattttiiiioooonnnn ooooffff """"bbbb....eeeexxxxpppp""""

     It must be clear that the  automaton  described  in  "d.bcg"
     represents  the  behaviour <<<<BBBB3333>>>> |||||||||||| <<<<BBBB2222>>>> instead of <<<<BBBB1111>>>> ||||||||||||
     <<<<BBBB2222>>>> since at the time  "b.exp"  is  evaluated,  "a.bcg"  is
     bound to <<<<BBBB3333>>>>.

     On the contrary, in the following program,
     """"aaaa....bbbbccccgggg"""" ==== <<<<BBBB1111>>>>;;;;
     """"cccc....bbbbccccgggg"""" ==== <<<<BBBB2222>>>>;;;;
     """"bbbb....eeeexxxxpppp"""" ==== ((((rrrreeeedddduuuuccccttttiiiioooonnnn ooooffff """"aaaa....bbbbccccgggg"""")))) |||||||||||| """"cccc....bbbbccccgggg"""";;;;
     """"aaaa....bbbbccccgggg"""" ==== <<<<BBBB3333>>>>;;;;
     """"dddd....bbbbccccgggg"""" ==== ggggeeeennnneeeerrrraaaattttiiiioooonnnn ooooffff """"bbbb....eeeexxxxpppp""""

     the automaton described in "d.bcg" represents the  behaviour
     ((((rrrreeeedddduuuuccccttttiiiioooonnnn  ooooffff  <<<<BBBB1111>>>>))))  ||||||||||||  <<<<BBBB2222>>>>,  since  the  reduction  is
     evaluated at the time "b.exp" is created.


  CCCCOOOOMMMMPPPPAAAARRRRIIIISSSSOOOONNNN
     [_F "="] [_E] ["probabilistic" | "stochastic"] "comparison"
        ["using" _M] ["with" _T]
        _B ("==" | "<=" | ">=") _B
     allows  to  compare  two  behaviours.  Symbol   "=="   means
     "equivalence"  whereas  "<="  and  "=>" denote relation pre-
     orders. The optional file _F must have extension ....aaaauuuutttt,  ....bbbbccccgggg,
     ....ffffcccc2222,  or  ....sssseeeeqqqq.  It is created in the current directory and
     may contain a diagnostic of the comparison if the result  is
     FALSE.

     Some combinations of tool,  method,  and  relation  are  not
     available. In this case, SVL tries to change some parameters
     to perform a comparison as close as possible to  what  seems
     to  be  expected. As much as possible, SVL tries to preserve
     the parameters in the following  priority  order:  relation,
     tool, and then method.



(C) INRIA            Last change: 2020/02/12                   33






CADP MANUAL PAGES                                      SVL(LOCAL)



     _T, _M, _E, "probabilistic", and "stochastic" are optional:

     -    The "probabilistic" and  "stochastic"  comparisons  are
          only  available for strong, branching, and divbranching
          bisimulations with bcg_cmp and using the std method. In
          this  case,  the behaviours _B must denote explicit LTSs
          containing probabilistic or stochastic information. See
          the bbbbccccgggg____ccccmmmmpppp(LOCAL) manual page for more information.

     -    The default value for _E is "strong" and can be  changed
          via the shell variable DDDDEEEEFFFFAAAAUUUULLLLTTTT____CCCCOOOOMMMMPPPPAAAARRRRIIIISSSSOOOONNNN____RRRREEEELLLLAAAATTTTIIIIOOOONNNN.

     -    The default value for  _M  depends  on  the  equivalence
          relation     considered.      The     shell    variable
          DDDDEEEEFFFFAAAAUUUULLLLTTTT____CCCCOOOOMMMMPPPPAAAARRRRIIIISSSSOOOONNNN____MMMMEEEETTTTHHHHOOOODDDD can be set in the SVL file to
          enforce a particular default value.

     -    The default value for _T depends on  the  type  of  com-
          parison  (pre-order or equivalence), on the relation _E,
          and on whether at least one behaviour _B is an  implicit
          LTS  or  not.   For  pre-order comparisons, the default
          value for _T is _b_i_s_i_m_u_l_a_t_o_r.  For equivalence  comparis-
          ons,  the  default  value for _T is determined as in the
          following table:

          +------------------+---------------+---------------+
          | relation         | both explicit |   implicit    |
          +------------------+---------------+---------------+
          | strong           |    bbbbccccgggg____ccccmmmmpppp    |  bbbbiiiissssiiiimmmmuuuullllaaaattttoooorrrr  |
          | strong stoch.    |    bbbbccccgggg____ccccmmmmpppp    | not available |
          | strong prob.     |    bbbbccccgggg____ccccmmmmpppp    | not available |
          | tau-divergence   |         not available         |
          | tau-compression  |         not available         |
          | tau-confluence   |         not available         |
          | branching        |    bbbbccccgggg____ccccmmmmpppp    |  bbbbiiiissssiiiimmmmuuuullllaaaattttoooorrrr  |
          | branching stoch. |    bbbbccccgggg____ccccmmmmpppp    | not available |
          | branching prob.  |    bbbbccccgggg____ccccmmmmpppp    | not available |
          | divbranching     |    bbbbccccgggg____ccccmmmmpppp    | not available |
          | divbr. stoch.    |    bbbbccccgggg____ccccmmmmpppp    | not available |
          | divbr. prob.     |    bbbbccccgggg____ccccmmmmpppp    | not available |
          | observational    |    bbbbccccgggg____ccccmmmmpppp    | not available |
          | tau*.a           |          bbbbiiiissssiiiimmmmuuuullllaaaattttoooorrrr          |
          | safety           |          bbbbiiiissssiiiimmmmuuuullllaaaattttoooorrrr          |
          | trace            |          bbbbiiiissssiiiimmmmuuuullllaaaattttoooorrrr          |
          | weak trace       |          bbbbiiiissssiiiimmmmuuuullllaaaattttoooorrrr          |
          +------------------+---------------+---------------+

          If a relation is not available for implicit LTSs,  then
          a warning is issued and the LTSs are automatically con-
          verted into explicit LTSs.

          The shell variable DDDDEEEEFFFFAAAAUUUULLLLTTTT____CCCCOOOOMMMMPPPPAAAARRRRIIIISSSSOOOONNNN____TTTTOOOOOOOOLLLL can  be  set



(C) INRIA            Last change: 2020/02/12                   34






CADP MANUAL PAGES                                      SVL(LOCAL)



          in  the  SVL file to enforce a particular default value
          for _T.


  VVVVEEEERRRRIIIIFFFFIIIICCCCAAAATTTTIIIIOOOONNNN
     [_F_1 "="] "verify" _F_2 ["using" _M] ["with" _T] "in" _B
     allows  to  evaluate  a  formula  on   a   behaviour,   with
     eeeevvvvaaaalllluuuuaaaattttoooorrrr3333(LOCAL),  eeeevvvvaaaalllluuuuaaaattttoooorrrr4444(LOCAL), eeeevvvvaaaalllluuuuaaaattttoooorrrr5555(LOCAL), or
     xxxxttttllll(LOCAL), and using method _M. The formula must be  written
     in  file _F_2, either in MCL (Model Checking Language) version
     3 (regular alternation-free mu-calculus, see the mmmmccccllll3333(LOCAL)
     manual  page),  in  MCL  version  4 (value-passing modal mu-
     calculus, see the mmmmccccllll4444(LOCAL) manual page), in MCL version 5
     (probabilistic  value-passing  modal  mu-calculus,  see  the
     mmmmccccllll5555(LOCAL) manual page), or  in  XTL  (eXecutable  Temporal
     Language, see the xxxxttttllll----llllaaaannnngggg(LOCAL) manual page).  If the for-
     mula is written in (dataless or full) MCL, then the file  _F_2
     must have extension ....mmmmccccllll.  If the formula is written in XTL,
     then the file _F_2 must have extension ....xxxxttttllll.

     The "with _T" clause is optional.  _T may be one  of  "evalua-
     tor3"   (corresponding   to   the  tool  eeeevvvvaaaalllluuuuaaaattttoooorrrr3333(LOCAL)),
     "evaluator4" (corresponding to the tool  eeeevvvvaaaalllluuuuaaaattttoooorrrr4444(LOCAL)),
     "evaluator5"  (corresponding to the tool eeeevvvvaaaalllluuuuaaaattttoooorrrr5555(LOCAL)),
     "evaluator" (corresponding to the tool  eeeevvvvaaaalllluuuuaaaattttoooorrrr(LOCAL)),oooorrrr
     "xtl"   (corresponding   to   the   tool  xxxxttttllll(LOCAL)).   See
     eeeevvvvaaaalllluuuuaaaattttoooorrrr(LOCAL) for  details  on  the  differences  between
     "evaluator", "evaluator3", "evaluator4", and "evaluator5".

     If the "with _T" clause is not present, then:

     -    If the file _F_2 has extension ....xxxxttttllll,  then  the  tool  is
          xxxxttttllll.

     -    If the file _F_2 has extension ....mmmmccccllll,  then  the  tool  is
          given  by the shell variable DDDDEEEEFFFFAAAAUUUULLLLTTTT____VVVVEEEERRRRIIIIFFFFYYYY____TTTTOOOOOOOOLLLL, which
          is set to "evaluator" by default.  Note  that  in  this
          case,  DDDDEEEEFFFFAAAAUUUULLLLTTTT____VVVVEEEERRRRIIIIFFFFYYYY____TTTTOOOOOOOOLLLL should not have value "xtl".
          If the file _F_2 has extension ....xxxxttttllll, then  the  value  of
          the shell variable DDDDEEEEFFFFAAAAUUUULLLLTTTT____VVVVEEEERRRRIIIIFFFFYYYY____TTTTOOOOOOOOLLLL is irrelevant.

     The "using _M" clause is optional, and irrelevant in the case
     of  an XTL formula.  In the case of an MCL formula, _M may be
     one   of   "dfs",   "bfs",   or    "acyclic".     See    the
     eeeevvvvaaaalllluuuuaaaattttoooorrrr(LOCAL),  eeeevvvvaaaalllluuuuaaaattttoooorrrr3333(LOCAL),  eeeevvvvaaaalllluuuuaaaattttoooorrrr4444(LOCAL), or
     eeeevvvvaaaalllluuuuaaaattttoooorrrr5555(LOCAL)  manual  pages  for  details  about  these
     methods.   If  the "using _M" clause is not present, then the
     method is given by the shell variable DDDDEEEEFFFFAAAAUUUULLLLTTTT____VVVVEEEERRRRIIIIFFFFYYYY____MMMMEEEETTTTHHHHOOOODDDD,
     which is set to "dfs" by default.

     File _F_1 is optional and  must  have  extension  ....aaaauuuutttt,  ....bbbbccccgggg,
     ....ffffcccc2222,  or ....sssseeeeqqqq.  If present, it will contain a diagnostic of



(C) INRIA            Last change: 2020/02/12                   35






CADP MANUAL PAGES                                      SVL(LOCAL)



     the verification in the case  of  an  MCL  formula.   It  is
     irrelevant in the case of an XTL formula, since the tool xxxxttttllll
     does not generate counter-examples.


  VVVVEEEERRRRIIIIFFFFIIIICCCCAAAATTTTIIIIOOOONNNN OOOOFFFF IIIINNNNLLLLIIIINNNNEEEE FFFFOOOORRRRMMMMUUUULLLLAAAASSSS
     [_F "="] _B "|=" ["using" _M] ["with" _T] _f_o_r_m_u_l_a ";"
     is  similar  to  "verify"  (see  Section  VERIFICATION   for
     details),  except  that the formula is not stored in a file,
     but inlined in the SVL script.

     The formula (defined by symbol _f_o_r_m_u_l_a in the syntax  above)
     is  defined  as the sequence of characters starting from the
     first character following "|=" (or  following  the  optional
     "using  _M"  and "with _T", if any, where _M ranges over "std",
     "dfs", "bfs", and "acyclic", and _T ranges over  "evaluator",
     "evaluator3",  "evaluator4",  "evaluator5",  and  "xtl") and
     ending at the last character preceding the next ";", includ-
     ing all spaces and comments.  Therefore, ";" must be present
     at the end of this statement, even if it is the last  state-
     ment of the SVL script.

     MCL or XTL libraries can be included by default in the  for-
     mulas,   by   using   the   variables  DDDDEEEEFFFFAAAAUUUULLLLTTTT____MMMMCCCCLLLL____LLLLIIIIBBBBRRRRAAAARRRRIIIIEEEESSSS
     (libraries  included  by  default  in  all  MCL   formulas),
     DDDDEEEEFFFFAAAAUUUULLLLTTTT____EEEEVVVVAAAALLLLUUUUAAAATTTTOOOORRRR3333____LLLLIIIIBBBBRRRRAAAARRRRIIIIEEEESSSS  (libraries included by default
     in dataless  MCL  formulas  checked  by  eeeevvvvaaaalllluuuuaaaattttoooorrrr3333(LOCAL)),
     DDDDEEEEFFFFAAAAUUUULLLLTTTT____EEEEVVVVAAAALLLLUUUUAAAATTTTOOOORRRR4444____LLLLIIIIBBBBRRRRAAAARRRRIIIIEEEESSSS  (libraries included by default
     in  full   MCL  formulas  checked   by   eeeevvvvaaaalllluuuuaaaattttoooorrrr4444(LOCAL)),
     DDDDEEEEFFFFAAAAUUUULLLLTTTT____EEEEVVVVAAAALLLLUUUUAAAATTTTOOOORRRR5555____LLLLIIIIBBBBRRRRAAAARRRRIIIIEEEESSSS  (libraries included by default
     in full  MCL formulas  checked  by  eeeevvvvaaaalllluuuuaaaattttoooorrrr5555(LOCAL)),  and
     DDDDEEEEFFFFAAAAUUUULLLLTTTT____XXXXTTTTLLLL____LLLLIIIIBBBBRRRRAAAARRRRIIIIEEEESSSS  (libraries included by default in all
     XTL formulas). These variables may be either empty, or  con-
     tain  a  list  of MCL or XTL library names (with extensions)
     separated by commas.  They are initially empty, meaning that
     no library is included by default.

     The formula (together with its included libraries) is stored
     in  an  intermediate file and parsed by the appropriate tool
     only during script execution.  Therefore,  syntactic  errors
     in  the  formula  (or  in  the  included  libraries) will be
     detected only at runtime, details being reported in the  log
     file.

     If the "with _T" clause is absent, then the tool is given  by
     the  shell  variable  DDDDEEEEFFFFAAAAUUUULLLLTTTT____VVVVEEEERRRRIIIIFFFFYYYY____TTTTOOOOOOOOLLLL,  which  is set to
     "evaluator" by default.  Therefore, by default  the  formula
     is supposed to be a dataless MCL formula.

     Note that shell variables are substituted in formulas.





(C) INRIA            Last change: 2020/02/12                   36






CADP MANUAL PAGES                                      SVL(LOCAL)



     EEEExxxxaaaammmmpppplllleeeessss::::

     %%%% AAAACCCCTTTTIIIIOOOONNNN====AAAA
     """"ddddiiiiaaaagggg....bbbbccccgggg"""" ==== """"mmmmooooddddeeeellll....llllnnnntttt"""" ||||==== uuuussssiiiinnnngggg ddddffffssss <<<< ''''$$$$AAAACCCCTTTTIIIIOOOONNNN'''' >>>> ttttrrrruuuueeee;;;;

     %%%% DDDDEEEEFFFFAAAAUUUULLLLTTTT____XXXXTTTTLLLL____LLLLIIIIBBBBRRRRAAAARRRRIIIIEEEESSSS====""""aaaaccccttttllll....xxxxttttllll""""

     """"mmmmooooddddeeeellll....bbbbccccgggg"""" ||||==== wwwwiiiitttthhhh xxxxttttllll
          lllleeeetttt PPPPUUUUTTTT :::: llllaaaabbbbeeeellllsssseeeetttt ==== EEEEVVVVAAAALLLL____AAAA ((((PPPPUUUUTTTT)))) iiiinnnn
               PPPPRRRRIIIINNNNTTTT____FFFFOOOORRRRMMMM ((((AAAAGGGG____AAAA ((((nnnnooootttt ((((PPPPUUUUTTTT)))),,,, EEEEFFFF ((((DDDDiiiiaaaa ((((PPPPUUUUTTTT,,,, ttttrrrruuuueeee))))))))))))))))
               nnnnoooopppp
          eeeennnndddd____lllleeeetttt;;;;

     ((((**** tttthhhheeee ffffoooolllllllloooowwwwiiiinnnngggg iiiissss eeeeqqqquuuuiiiivvvvaaaalllleeeennnntttt ttttoooo tttthhhheeee aaaabbbboooovvvveeee ****))))
     %%%% DDDDEEEEFFFFAAAAUUUULLLLTTTT____VVVVEEEERRRRIIIIFFFFYYYY____TTTTOOOOOOOOLLLL====xxxxttttllll
     """"mmmmooooddddeeeellll....bbbbccccgggg"""" ||||====
          lllleeeetttt PPPPUUUUTTTT :::: llllaaaabbbbeeeellllsssseeeetttt ==== EEEEVVVVAAAALLLL____AAAA ((((PPPPUUUUTTTT)))) iiiinnnn
               PPPPRRRRIIIINNNNTTTT____FFFFOOOORRRRMMMM ((((AAAAGGGG____AAAA ((((nnnnooootttt ((((PPPPUUUUTTTT)))),,,, EEEEFFFF ((((DDDDiiiiaaaa ((((PPPPUUUUTTTT,,,, ttttrrrruuuueeee))))))))))))))))
               nnnnoooopppp
          eeeennnndddd____lllleeeetttt;;;;


  DDDDEEEEAAAADDDDLLLLOOOOCCCCKKKK AAAANNNNDDDD LLLLIIIIVVVVEEEELLLLOOOOCCCCKKKK CCCCHHHHEEEECCCCKKKKIIIINNNNGGGG
     [_F "="] "deadlock" ["with" _T] "of" _B
     and
     [_F "="] "livelock" ["with" _T] "of" _B
     allow to search  deadlocks,  respectively  livelocks,  in  a
     behaviour.  They  return  TRUE if the behaviour has at least
     one deadlock, respectively likelock,  and  FALSE  otherwise.
     The optional file _F must have extension ....aaaauuuutttt, ....bbbbccccgggg, ....ffffcccc2222, or
     ....sssseeeeqqqq. It is created in the current directory and may contain
     a  diagnostic  of the search, if such a diagnostic is avail-
     able.

     The tool _T  is  an  optional  parameter,  similar  to  those
     described  above  for  the  reductions and comparisons.  The
     default value may be modified via the following variables:

     -    DDDDEEEEFFFFAAAAUUUULLLLTTTT____DDDDEEEEAAAADDDDLLLLOOOOCCCCKKKK____TTTTOOOOOOOOLLLL, whose initial value is  "exhibi-
          tor".  This variable can alternatively be set to "alde-
          baran",  "evaluator",  "evaluator3",  "evaluator4",  or
          "evaluator5".

     -    DDDDEEEEFFFFAAAAUUUULLLLTTTT____LLLLIIIIVVVVEEEELLLLOOOOCCCCKKKK____TTTTOOOOOOOOLLLL, whose initial value is  "evalua-
          tor".   This  variable  can  alternatively  be  set  to
          "evaluator3",  "evaluator4",  "evaluator5",  or  "alde-
          baran".

     Those  two  shell  variables  replace  the  shell   variable
     DDDDEEEEFFFFAAAAUUUULLLLTTTT____LLLLOOOOCCCCKKKK____TTTTOOOOOOOOLLLL,  which was present in earlier versions of
     SVL and is now obsolete.




(C) INRIA            Last change: 2020/02/12                   37






CADP MANUAL PAGES                                      SVL(LOCAL)



     Note that ffffcccc2222ttttoooooooollllssss are no longer supported.


  PPPPRRRROOOOPPPPEEEERRRRTTTTYYYY
     "property" _P_I_D ["("_p_a_r_a_m"," ..."," _p_a_r_a_m")"]
        ['"'_c_o_m_m_e_n_t'"' ... '"'_c_o_m_m_e_n_t'"'] "is" _P
     "end property"
     is the "property" statement, which allows a  set  of  state-
     ments to be attached the following attributes:

     -    The property has a name, defined by the identifier _P_I_D.
          It  is  a string that starts with a letter and contains
          letters, digits, and underscores, but does not end with
          an underscore.

     -    The property may be  parameterized  with  an  arbitrary
          number of parameters.  Each parameter _p_a_r_a_m is an iden-
          tifier satisfying the same syntax as property  identif-
          iers.   Distinct  parameters  of the same property must
          have distinct identifiers.  Inside the property,  every
          parameter   _p_a_r_a_m  can  be  expanded  using  $_p_a_r_a_m  or
          ${_p_a_r_a_m} as ordinary shell variables.   In  particular,
          if  the  property contains inline formulas, the parame-
          ters are expanded in the formulas.

     -    The property may have comments consisting of a  (possi-
          bly empty) sequence of character strings, each enclosed
          in double quotes.  Note that  parameters  can  be  used
          inside comments.

     The body _P of the property consists of  a  (possibly  empty)
     sequence  of  statements.  Among those statements, _v_e_r_i_f_i_c_a_-
     _t_i_o_n _s_t_a_t_e_m_e_n_t_s are the behaviour comparison statement  (see
     Section  COMPARISON), the temporal logic verification state-
     ment (see Sections VERIFICATION and VERIFICATION  OF  INLINE
     FORMULAS), and the deadlock and livelock checking statements
     (see Section DEADLOCK AND LIVELOCK CHECKING).

     Each verification statement (if any) embedded  in  the  pro-
     perty  can  be  followed  by an expected result, in the form
     "expected _L", where _L is either an identifier  (e.g.,  TRUE,
     FALSE, ...) or an arbitrary string, which may be a Unix reg-
     ular expression (see the rrrreeeeggggeeeexxxxpppp(5) manual page  for  details
     about regular expressions).  A verification statement can be
     followed by an expected result if and only if all  verifica-
     tion statements occurring in the same property are also fol-
     lowed by an expected result.  Note that expected results are
     not allowed outside a property.

     Note that for a comparison, a deadlock or livelock checking,
     or  the verification of a formula using eeeevvvvaaaalllluuuuaaaattttoooorrrr3333(LOCAL) or
     eeeevvvvaaaalllluuuuaaaattttoooorrrr4444(LOCAL), the result is either TRUE or FALSE.   For



(C) INRIA            Last change: 2020/02/12                   38






CADP MANUAL PAGES                                      SVL(LOCAL)



     the  verification  of a formula using eeeevvvvaaaalllluuuuaaaattttoooorrrr5555(LOCAL), the
     TRUE or FALSE result may be preceded by  probability  values
     if requested by the probabilistic operators contained in the
     formula.  The probability values are not considered part  of
     the  result, only the TRUE or FALSE result being considered.
     For the verification of a formula using xxxxttttllll(LOCAL), the for-
     mat  of the result depends on the XTL program; SVL only con-
     siders the last non-empty line printed by XTL as  being  the
     result.   In all cases, we say that the result satisfies the
     expected result if the expected result  matches  the  result
     entirely,  using  the egrep command (see the eeeeggggrrrreeeepppp(1) manual
     page for details).

     If a property has no parameter, then it is checked automati-
     cally.   Otherwise,  it must be instanciated using a "check"
     statement of the following form:
     "check" _P_I_D "(" _a_r_g "," ... "," _a_r_g ")"
     where each _a_r_g is an argument, which may be any  identifier,
     string (in double quotes), or natural number (i.e., sequence
     of digits), and where the number of arguments must be  equal
     to the number of parameters.

     When checking a property, SVL  will  display  the  following
     information to the user:

     -    the name of the property, together  with  the  argument
          values

     -    the comments (one line per comment)

     -    if expected results are defined, a PASS  or  FAIL  ver-
          dict;  PASS  indicates that all verification statements
          met the expected results; otherwise,  the  verdict  has
          either  the form FAIL if the property contains a single
          verification statement, or the form "FAIL  (_N/_M)"  such
          that  _M  (where _M > 1) is the total number of verifica-
          tion statements contained in the property and _N  (where
          0  <=  _N  < _M) is the number of verification statements
          that met the expected results

     -    if expected results are not  defined,  the  results  of
          verifications in sequence, in the order of statements

     More details of the verifications can be  displayed  if  the
     user  sets  the  shell  variable  PPPPRRRROOOOPPPPEEEERRRRTTTTYYYY____DDDDIIIISSSSPPPPLLLLAAAAYYYY____MMMMOOOODDDDEEEE to a
     non-zero value.

     EEEExxxxaaaammmmpppplllleeeessss::::

     pppprrrrooooppppeeeerrrrttttyyyy NNNNoooo____DDDDeeeeaaaaddddlllloooocccckkkk
         """"TTTThhhheeeerrrreeee sssshhhhoooouuuulllldddd bbbbeeee nnnnoooo ddddeeeeaaaaddddlllloooocccckkkk iiiinnnn tttthhhheeee ssssppppeeeecccciiiiffffiiiiccccaaaattttiiiioooonnnn""""
     iiiissss



(C) INRIA            Last change: 2020/02/12                   39






CADP MANUAL PAGES                                      SVL(LOCAL)



         """"ddddiiiiaaaagggg....sssseeeeqqqq"""" ==== ddddeeeeaaaaddddlllloooocccckkkk ooooffff """"ssssppppeeeecccc....bbbbccccgggg"""";;;;
             eeeexxxxppppeeeecccctttteeeedddd FFFFAAAALLLLSSSSEEEE
     eeeennnndddd pppprrrrooooppppeeeerrrrttttyyyy ((((**** cccchhhheeeecccckkkkeeeedddd aaaauuuuttttoooommmmaaaattttiiiiccccaaaallllllllyyyy ****))))

     pppprrrrooooppppeeeerrrrttttyyyy EEEExxxxiiiisssstttt ((((AAAA,,,, SSSSPPPPEEEECCCC))))
         """"AAAAccccttttiiiioooonnnn \\\\""""$$$$AAAA\\\\"""" sssshhhhoooouuuulllldddd bbbbeeee rrrreeeeaaaacccchhhhaaaabbbblllleeee iiiinnnn tttthhhheeee ssssppppeeeecccciiiiffffiiiiccccaaaattttiiiioooonnnn""""
     iiiissss
         """"ddddiiiiaaaagggg____$$$$AAAA____$$$$SSSSPPPPEEEECCCC....sssseeeeqqqq"""" ====
             """"$$$$SSSSPPPPEEEECCCC....bbbbccccgggg"""" ||||==== <<<< ttttrrrruuuueeee**** .... ''''$$$$AAAA'''' >>>> ttttrrrruuuueeee;;;;
                 eeeexxxxppppeeeecccctttteeeedddd TTTTRRRRUUUUEEEE
     eeeennnndddd pppprrrrooooppppeeeerrrrttttyyyy

     cccchhhheeeecccckkkk EEEExxxxiiiisssstttt ((((""""GGGG"""",,,, """"mmmmyyyy____ssssppppeeeecccc""""))));;;;
     cccchhhheeeecccckkkk EEEExxxxiiiisssstttt ((((""""HHHH"""",,,, """"mmmmyyyy____ssssppppeeeecccc""""))))


     The display of comments can be parameterized  by  the  user.
     SVL provides two means to do so:

     -    Either   redefine    the    three    shell    variables
          PPPPRRRROOOOPPPPEEEERRRRTTTTYYYY____CCCCOOOOMMMMMMMMEEEENNNNTTTT____OOOOPPPPEEEENNNN,   PPPPRRRROOOOPPPPEEEERRRRTTTTYYYY____CCCCOOOOMMMMMMMMEEEENNNNTTTT____MMMMIIIIDDDDDDDDLLLLEEEE,   and
          PPPPRRRROOOOPPPPEEEERRRRTTTTYYYY____CCCCOOOOMMMMMMMMEEEENNNNTTTT____CCCCLLLLOOOOSSSSEEEE, which specify the open  comment
          symbol  (printed on one separate line if different from
          the empty string), middle comment  symbol  (which  will
          start  every  comment  line),  and close comment symbol
          (printed on one separate line  if  different  from  the
          empty string). See examples below.

     -    Or use one of the predefined comment styles by  calling
          the  shell function SSSSVVVVLLLL____SSSSEEEETTTT____PPPPRRRROOOOPPPPEEEERRRRTTTTYYYY____CCCCOOOOMMMMMMMMEEEENNNNTTTT____SSSSTTTTYYYYLLLLEEEE with
          a parameter among ssssiiiilllleeeennnntttt (comments are not  displayed),
          nnnnoooonnnneeee, ssssttttaaaannnnddddaaaarrrrdddd (style by default), iiiinnnnddddeeeennnntttt, aaaaddddaaaa, cccc, ppppaaaassss----
          ccccaaaallll, or sssshhhh. Styles are  illustrated  in  the  following
          table:





















(C) INRIA            Last change: 2020/02/12                   40






CADP MANUAL PAGES                                      SVL(LOCAL)



          ++++----------------------------------------++++----------------------------------------------------++++------------------------------------------------++++--------------------------------------------------------++++
          |||| ssssttttyyyylllleeee    |||| ooooppppeeeennnn ssssyyyymmmmbbbboooollll |||| mmmmiiiidddd ssssyyyymmmmbbbboooollll |||| cccclllloooosssseeee ssssyyyymmmmbbbboooollll ||||
          ++++----------------------------------------++++----------------------------------------------------++++------------------------------------------------++++--------------------------------------------------------++++
          |||| nnnnoooonnnneeee     ||||             ||||            ||||              ||||
          ++++----------------------------------------++++----------------------------------------------------++++------------------------------------------------++++--------------------------------------------------------++++
          |||| ssssttttaaaannnnddddaaaarrrrdddd ||||             |||| """" |||| """"      ||||              ||||
          ++++----------------------------------------++++----------------------------------------------------++++------------------------------------------------++++--------------------------------------------------------++++
          |||| iiiinnnnddddeeeennnntttt   ||||             |||| """"   """"      ||||              ||||
          ++++----------------------------------------++++----------------------------------------------------++++------------------------------------------------++++--------------------------------------------------------++++
          |||| aaaaddddaaaa      ||||             |||| """"-------- """"      ||||              ||||
          ++++----------------------------------------++++----------------------------------------------------++++------------------------------------------------++++--------------------------------------------------------++++
          |||| cccc        |||| """"////****""""        |||| """" **** """"      |||| """" ****////""""        ||||
          ++++----------------------------------------++++----------------------------------------------------++++------------------------------------------------++++--------------------------------------------------------++++
          |||| ppppaaaassssccccaaaallll   |||| """"((((****""""        |||| """" **** """"      |||| """" ****))))""""        ||||
          ++++----------------------------------------++++----------------------------------------------------++++------------------------------------------------++++--------------------------------------------------------++++
          |||| sssshhhh       ||||             |||| """" #### """"      ||||              ||||
          ++++----------------------------------------++++----------------------------------------------------++++------------------------------------------------++++--------------------------------------------------------++++

     EEEExxxxaaaammmmpppplllleeee::::

     The following SVL code:

     %%%% PPPPRRRROOOOPPPPEEEERRRRTTTTYYYY____CCCCOOOOMMMMMMMMEEEENNNNTTTT____OOOOPPPPEEEENNNN====""""((((++++""""
     %%%% PPPPRRRROOOOPPPPEEEERRRRTTTTYYYY____CCCCOOOOMMMMMMMMEEEENNNNTTTT____MMMMIIIIDDDDDDDDLLLLEEEE===="""" ++++ """"
     %%%% PPPPRRRROOOOPPPPEEEERRRRTTTTYYYY____CCCCOOOOMMMMMMMMEEEENNNNTTTT____CCCCLLLLOOOOSSSSEEEE===="""" ++++))))""""

     pppprrrrooooppppeeeerrrrttttyyyy PPPP
         """"tttthhhhiiiissss iiiissss aaaa ccccoooommmmmmmmeeeennnntttt ffffoooorrrr pppprrrrooooppppeeeerrrrttttyyyy PPPP""""
     iiiissss
         ssssttttoooopppp ||||==== <<<< AAAA >>>> ttttrrrruuuueeee;;;;
     eeeennnndddd pppprrrrooooppppeeeerrrrttttyyyy

     will execute as follows:

     pppprrrrooooppppeeeerrrrttttyyyy PPPP
     ((((++++
      ++++ tttthhhhiiiissss iiiissss aaaa ccccoooommmmmmmmeeeennnntttt ffffoooorrrr pppprrrrooooppppeeeerrrrttttyyyy PPPP
      ++++))))

     FFFFAAAALLLLSSSSEEEE

     EEEExxxxaaaammmmpppplllleeee::::

     The following SVL code:

     %%%% SSSSVVVVLLLL____SSSSEEEETTTT____PPPPRRRROOOOPPPPEEEERRRRTTTTYYYY____CCCCOOOOMMMMMMMMEEEENNNNTTTT____SSSSTTTTYYYYLLLLEEEE aaaaddddaaaa

     pppprrrrooooppppeeeerrrrttttyyyy PPPP
         """"tttthhhhiiiissss iiiissss aaaa ccccoooommmmmmmmeeeennnntttt ffffoooorrrr pppprrrrooooppppeeeerrrrttttyyyy PPPP""""
     iiiissss
         ssssttttoooopppp ||||==== <<<< AAAA >>>> ttttrrrruuuueeee;;;;
     eeeennnndddd pppprrrrooooppppeeeerrrrttttyyyy



(C) INRIA            Last change: 2020/02/12                   41






CADP MANUAL PAGES                                      SVL(LOCAL)



     will execute as follows:

     pppprrrrooooppppeeeerrrrttttyyyy PPPP
     -------- tttthhhhiiiissss iiiissss aaaa ccccoooommmmmmmmeeeennnntttt ffffoooorrrr pppprrrrooooppppeeeerrrrttttyyyy PPPP

     FFFFAAAALLLLSSSSEEEE

  SSSSHHHHEEEELLLLLLLL LLLLIIIINNNNEEEESSSS
     SVL offers the facility to insert shell lines between state-
     ments.   Such lines must start with the symbol "%", and fin-
     ish with the end of the line.

     Of course, SVL operates no static control of the validity of
     inserted  shell lines. Hence, erroneous shell scripts may be
     generated by SVL due to syntax errors made by the  user,  or
     to shell lines breaking the consistency of SVL execution.


  CCCCOOOOMMMMMMMMEEEENNNNTTTTSSSS
     SVL accepts two kinds of comments:

     -    Every sequence of characters delimited by "(*" and "*)"
          is a comment. This notation is inherited from LOTOS and
          also available in LNT.

     -    Every sequence of characters from "--" until  the  next
          newline character is a comment. This notation is inher-
          ited from LNT.

     Comments are ignored (i.e., considered as a blank character)
     at any place in an SVL script, except:

     -    within character strings (delimited by double  quotes),
          and

     -    in shell lines (starting with "%"),  where  shell  com-
          ments (starting with "#") should be used instead.


SSSSTTTTOOOORRRRIIIINNNNGGGG SSSSTTTTAAAATTTTEEEEMMMMEEEENNNNTTTT RRRREEEESSSSUUUULLLLTTTTSSSS IIIINNNN SSSSHHHHEEEELLLLLLLL VVVVAAAARRRRIIIIAAAABBBBLLLLEEEESSSS
     SVL allows the result of some statements  to  be  stored  in
     shell  variables  using  the  keyword "result" followed by a
     label, which denotes a shell expression that  expands  to  a
     shell  variable identifier.  The statements whose result can
     be stored are Bourne shell commands, comparison  statements,
     temporal      logic     verification     statements,     and
     deadlock/livelock  checking  statements.   If  a   statement
     (e.g.,  a  Bourne shell command or an XTL property) produces
     several lines of output, then only the contents of the  last
     non-empty line is stored in the shell variable.





(C) INRIA            Last change: 2020/02/12                   42






CADP MANUAL PAGES                                      SVL(LOCAL)



     EEEExxxxaaaammmmpppplllleeee 1111::::

     """"aaaa....bbbbccccgggg"""" ==== ccccoooommmmppppaaaarrrriiiissssoooonnnn """"ssssppppeeeecccc....bbbbccccgggg"""" ======== """"sssseeeerrrrvvvv....bbbbccccgggg"""";;;;
             rrrreeeessssuuuulllltttt RRRR;;;;

     %%%% iiiiffff [[[[ """"$$$$RRRR"""" ==== FFFFAAAALLLLSSSSEEEE ]]]]
     %%%% tttthhhheeeennnn
             -------- ooootttthhhheeeerrrr vvvveeeerrrriiiiffffiiiiccccaaaattttiiiioooonnnnssss
             ............
     %%%% ffffiiii

     EEEExxxxaaaammmmpppplllleeee 2222::::

     pppprrrrooooppppeeeerrrrttttyyyy PPPP1111 ((((RRRR1111))))
         """"aaaa pppprrrrooooppppeeeerrrrttttyyyy""""
     iiiissss
         -------- eeeeqqqquuuuiiiivvvvaaaalllleeeennnncccceeee cccchhhheeeecccckkkkiiiinnnngggg
         """"aaaa....bbbbccccgggg"""" ==== ccccoooommmmppppaaaarrrriiiissssoooonnnn """"ssssppppeeeecccc....bbbbccccgggg"""" ======== """"sssseeeerrrrvvvv....bbbbccccgggg"""";;;;
             rrrreeeessssuuuulllltttt """"$$$$RRRR1111"""" eeeexxxxppppeeeecccctttteeeedddd TTTTRRRRUUUUEEEE;;;;

         -------- ooootttthhhheeeerrrr vvvveeeerrrriiiiffffiiiiccccaaaattttiiiioooonnnnssss
         ............
     eeeennnndddd pppprrrrooooppppeeeerrrrttttyyyy

     pppprrrrooooppppeeeerrrrttttyyyy PPPP2222 ((((RRRR2222))))
         """"aaaannnnooootttthhhheeeerrrr pppprrrrooooppppeeeerrrrttttyyyy rrrreeeeuuuussssiiiinnnngggg ppppaaaarrrrtttt ooooffff tttthhhheeee pppprrrreeeevvvviiiioooouuuussss oooonnnneeee""""
     iiiissss
         -------- uuuusssseeee $$$$RRRR2222 ttttoooo aaaavvvvooooiiiidddd cccchhhheeeecccckkkkiiiinnnngggg eeeeqqqquuuuiiiivvvvaaaalllleeeennnncccceeee aaaaggggaaaaiiiinnnn
         %%%% eeeecccchhhhoooo """"$$$$RRRR2222""""
             eeeexxxxppppeeeecccctttteeeedddd TTTTRRRRUUUUEEEE;;;;

         -------- ooootttthhhheeeerrrr vvvveeeerrrriiiiffffiiiiccccaaaattttiiiioooonnnnssss
         ............
     eeeennnndddd pppprrrrooooppppeeeerrrrttttyyyy

     cccchhhheeeecccckkkk PPPP1111 ((((""""RRRReeeessssuuuulllltttt""""))));;;; -------- aaaassssssssiiiiggggnnnnssss vvvvaaaarrrriiiiaaaabbbblllleeee RRRReeeessssuuuulllltttt
     cccchhhheeeecccckkkk PPPP2222 ((((""""$$$$RRRReeeessssuuuulllltttt"""")))) -------- uuuusssseeeessss tttthhhheeee vvvvaaaalllluuuueeee aaaassssssssiiiiggggnnnneeeedddd ttttoooo RRRReeeessssuuuulllltttt

     Note that "result"  can  be  used  in  any  context,  unlike
     "expected",  which  cannot  be used outside the context of a
     "property".  Also, if a statement  uses  both  "result"  and
     "expected", then:

     -    the "result" part  must  occur  before  the  "expected"
          part, and

     -    the "result" and "expected" parts must not be separated
          by a semicolon.

     See the syntax of non-terminal _R_E in Section SYNTAX OF  PRO-
     GRAMS AND EXPRESSIONS above.




(C) INRIA            Last change: 2020/02/12                   43






CADP MANUAL PAGES                                      SVL(LOCAL)



UUUUSSSSIIIINNNNGGGG SSSSHHHHEEEELLLLLLLL VVVVAAAARRRRIIIIAAAABBBBLLLLEEEESSSS IIIINNNN EEEEXXXXPPPPRRRREEEESSSSSSSSIIIIOOOONNNNSSSS
     Every string between double quotes may  use  defined  Bourne
     shell  variables ("$"_d_e_f_i_n_e_d-_s_h_e_l_l-_v_a_r_i_a_b_l_e).  This includes
     the shell variables defined using the "result" keyword  (see
     Section  STORING STATEMENT RESULTS IN SHELL VARIABLES above)
     and the special Bourne shell  variables  "$#",  "$*",  "$@",
     "$1",  "$2",  ...  which can be used to refer to the _s_c_r_i_p_t-
     _p_a_r_a_m_e_t_e_r_s passed to the generated script.

     However, remember that when using filenames, extensions must
     always be explicitly mentioned, for the following reasons:

     -    They permit to determine at compile-time the  resulting
          format of a behaviour;

     -    They permit to distinguish between a file  name  and  a
          process  name,  as  illustrated in some of the examples
          below.

     EEEExxxxaaaammmmpppplllleeeessss::::

     %%%% ffffoooorrrr FFFFNNNNAAAAMMMMEEEE iiiinnnn aaaa bbbb cccc
     %%%% ddddoooo
     """"rrrreeeedddduuuucccceeeedddd----$$$$FFFFNNNNAAAAMMMMEEEE....aaaauuuutttt"""" ==== rrrreeeedddduuuuccccttttiiiioooonnnn ooooffff """"$$$$FFFFNNNNAAAAMMMMEEEE....aaaauuuutttt""""
     %%%% ddddoooonnnneeee

     is correct, but

     %%%% ffffoooorrrr FFFFNNNNAAAAMMMMEEEE iiiinnnn aaaa....aaaauuuutttt bbbb....aaaauuuutttt cccc....aaaauuuutttt
     %%%% ddddoooo
     """"rrrreeeedddduuuucccceeeedddd----$$$$FFFFNNNNAAAAMMMMEEEE"""" ==== rrrreeeedddduuuuccccttttiiiioooonnnn ooooffff """"$$$$FFFFNNNNAAAAMMMMEEEE""""
     %%%% ddddoooonnnneeee

     is not correct (a run-time error is issued) because "$FNAME"
     is  interpreted  at  compile-time  as  a  process whereas it
     denotes a file name.   However,  the  following  example  is
     correct:

     %%%% DDDDEEEEFFFFAAAAUUUULLLLTTTT____PPPPRRRROOOOCCCCEEEESSSSSSSS____FFFFIIIILLLLEEEE====""""aaaa....lllloooottttoooossss""""
     %%%% ffffoooorrrr PPPPNNNNAAAAMMMMEEEE iiiinnnn """"PPPP1111[[[[GGGG1111,,,, GGGG2222]]]]"""" PPPP2222
     %%%% ddddoooo
     """"rrrreeeedddduuuucccceeeedddd----$$$$PPPPNNNNAAAAMMMMEEEE"""" ==== rrrreeeedddduuuuccccttttiiiioooonnnn ooooffff ggggeeeennnneeeerrrraaaattttiiiioooonnnn ooooffff """"$$$$PPPPNNNNAAAAMMMMEEEE
     %%%% ddddoooonnnneeee

     This loop reduces in turn the LTSs of processes  PPPP1111[[[[GGGG1111,,,,  GGGG2222]]]]
     and PPPP2222 found in file """"aaaa....lllloooottttoooossss"""".

     Shell variables can also be used to denote gates  or  labels
     as in the following example:

     %%%% ffffoooorrrr GGGG iiiinnnn PPPPUUUUTTTT GGGGEEEETTTT
     %%%% ddddoooo



(C) INRIA            Last change: 2020/02/12                   44






CADP MANUAL PAGES                                      SVL(LOCAL)



       """"PPPP____$$$$GGGG....eeeexxxxpppp"""" ====
           """"ssssppppeeeecccc....lllloooottttoooossss""""::::PPPP [[[[""""$$$$GGGG""""]]]]
           ||||[[[[""""$$$$GGGG""""]]]]||||
           """"ssssppppeeeecccc....lllloooottttoooossss""""::::PPPP [[[[""""$$$$GGGG""""]]]];;;;
     %%%% ddddoooonnnneeee

     This loop generates  in  turn  two  composition  expressions
     stored  in  EXP files, corresponding to """"ssssppppeeeecccc....lllloooottttoooossss""""::::PPPP [[[[PPPPUUUUTTTT]]]]
     ||||[[[[PPPPUUUUTTTT]]]]||||  """"ssssppppeeeecccc....lllloooottttoooossss""""::::PPPP  [[[[PPPPUUUUTTTT]]]]  and   """"ssssppppeeeecccc....lllloooottttoooossss""""::::PPPP   [[[[GGGGEEEETTTT]]]]
     ||||[[[[GGGGEEEETTTT]]]]|||| """"ssssppppeeeecccc....lllloooottttoooossss""""::::PPPP [[[[GGGGEEEETTTT]]]].

     Note also that shell variables and expressions can  be  used
     to  denote  lists of labels, gates, or renaming rules, using
     the braced notation.  A  shell  expression  written  between
     braces  will be interpreted as a list of labels instead of a
     single label, thus differentiating from the quoted notation.

     For instance, one may write
     %%%% LLLL1111====""""AAAA,,,,
     """"ffff1111....bbbbccccgggg"""" ==== ttttoooottttaaaallll hhhhiiiiddddeeee DDDD,,,, {{{{$$$$LLLL1111}}}} iiiinnnn """"ffff2222....bbbbccccgggg"""";;;;

     %%%% LLLL2222====""""AAAA,,,, BBBB,,,, CCCC""""
     """"ffff3333....bbbbccccgggg"""" ==== """"ffff4444....bbbbccccgggg"""" ||||[[[[ {{{{$$$$LLLL2222}}}} ]]]]|||| """"ffff5555....lllloooottttoooossss""""::::PPPP [[[[""""DDDD"""",,,, {{{{$$$$LLLL2222}}}}]]]];;;;

     %%%% LLLL3333====""""
     %%%% LLLL4444====""""CCCC ---->>>> AAAA,,,, BBBB ---->>>> CCCC""""
     """"ffff6666....bbbbccccgggg"""" ==== ttttoooottttaaaallll rrrreeeennnnaaaammmmeeee """"DDDD"""" ---->>>> """"EEEE"""",,,, {{{{$$$$LLLL3333,,,, $$$$LLLL4444}}}} iiiinnnn """"ffff7777....bbbbccccgggg"""";;;;
     to express that $A, $B, $C must not be interpreted as single
     labels  or rules (as it would be in "$A", "$B", "$C") but as
     lists of labels or rules.

     Note that the label and rule separator is the coma. However,
     comas  between  parentheses  are not interpreted as label or
     rule separators, as long as parentheses are well-balanced.


LLLLOOOOCCCCAAAALLLL SSSSHHHHEEEELLLLLLLL VVVVAAAARRRRIIIIAAAABBBBLLLLEEEESSSS
     SVL provides several shell variables  that  allow  users  to
     fine-tune  their  verification scripts.  Those variables may
     be modified (carefully) by the user, in  a  shell  line,  as
     already mentionned.

     Use of variables whose  name  starts  with  SSSSVVVVLLLL____  should  be
     avoided.  This syntax is reserved to functions and variables
     defined internally by SVL.


  DDDDEEEEFFFFAAAAUUUULLLLTTTT VVVVEEEERRRRIIIIFFFFIIIICCCCAAAATTTTIIIIOOOONNNN PPPPAAAARRRRAAAAMMMMEEEETTTTEEEERRRRSSSS
     The following table lists the user-redefinable  shell  vari-
     ables relative to the choice of tools, verification methods,
     equivalence relations, etc.,  together  with  their  default
     values.



(C) INRIA            Last change: 2020/02/12                   45






CADP MANUAL PAGES                                      SVL(LOCAL)



     +-----------------------------+-----------+----------------+
     |           Variable          |  Default  |  Alternative   |
     +-----------------------------+-----------+----------------+
     | DDDDEEEEFFFFAAAAUUUULLLLTTTT____RRRREEEEDDDDUUUUCCCCTTTTIIIIOOOONNNN____TTTTOOOOOOOOLLLL      | See Sect. | aldebaran      |
     |                             | REDUCTION | bcg_min        |
     |                             | above     | reductor       |
     +-----------------------------+-----------+----------------+
     | DDDDEEEEFFFFAAAAUUUULLLLTTTT____CCCCOOOOMMMMPPPPAAAARRRRIIIISSSSOOOONNNN____TTTTOOOOOOOOLLLL     | See Sect. | aldebaran      |
     |                             | COMPARISON| bcg_cmp        |
     |                             | above     | bisimulator    |
     +-----------------------------+-----------+----------------+
     | DDDDEEEEFFFFAAAAUUUULLLLTTTT____VVVVEEEERRRRIIIIFFFFYYYY____TTTTOOOOOOOOLLLL         | See Sect. | evaluator      |
     |                             | VERIFY    | evaluator3     |
     |                             | above     | evaluator4     |
     |                             |           | evaluator5     |
     |                             |           | xtl            |
     +-----------------------------+-----------+----------------+
     | DDDDEEEEFFFFAAAAUUUULLLLTTTT____DDDDEEEEAAAADDDDLLLLOOOOCCCCKKKK____TTTTOOOOOOOOLLLL       | exhibitor | aldebaran      |
     |                             |           | evaluator      |
     |                             |           | evaluator3     |
     |                             |           | evaluator4     |
     |                             |           | evaluator5     |
     +-----------------------------+-----------+----------------+
     | DDDDEEEEFFFFAAAAUUUULLLLTTTT____LLLLIIIIVVVVEEEELLLLOOOOCCCCKKKK____TTTTOOOOOOOOLLLL       | evaluator | evaluator3     |
     |                             |           | evaluator4     |
     |                             |           | evaluator5     |
     |                             |           | aldebaran      |
     +-----------------------------+-----------+----------------+
     | DDDDEEEEFFFFAAAAUUUULLLLTTTT____RRRREEEEDDDDUUUUCCCCTTTTIIIIOOOONNNN____MMMMEEEETTTTHHHHOOOODDDD    | std       | bdd fly        |
     +-----------------------------+-----------+----------------+
     | DDDDEEEEFFFFAAAAUUUULLLLTTTT____CCCCOOOOMMMMPPPPAAAARRRRIIIISSSSOOOONNNN____MMMMEEEETTTTHHHHOOOODDDD   | dfs       | std bdd fly    |
     |                             |           | bfs dfs        |
     +-----------------------------+-----------+----------------+
     | DDDDEEEEFFFFAAAAUUUULLLLTTTT____VVVVEEEERRRRIIIIFFFFYYYY____MMMMEEEETTTTHHHHOOOODDDD       | dfs       | bfs acyclic    |
     +-----------------------------+-----------+----------------+
     | DDDDEEEEFFFFAAAAUUUULLLLTTTT____RRRREEEEDDDDUUUUCCCCTTTTIIIIOOOONNNN____RRRREEEELLLLAAAATTTTIIIIOOOONNNN  | strong    | observational  |
     |                             |           | tau*.a         |
     |                             |           | branching      |
     |                             |           | divbranching   |
     |                             |           | safety         |
     |                             |           | tau-compression|
     |                             |           | tau-divergence |
     |                             |           | tau-confluence |
     |                             |           | trace          |
     |                             |           | weak trace     |
     +-----------------------------+-----------+----------------+
     | DDDDEEEEFFFFAAAAUUUULLLLTTTT____CCCCOOOOMMMMPPPPAAAARRRRIIIISSSSOOOONNNN____RRRREEEELLLLAAAATTTTIIIIOOOONNNN | strong    | observational  |
     |                             |           | tau*.a         |
     |                             |           | branching      |
     |                             |           | divbranching   |
     |                             |           | safety         |
     |                             |           | trace          |



(C) INRIA            Last change: 2020/02/12                   46






CADP MANUAL PAGES                                      SVL(LOCAL)



     |                             |           | weak trace     |
     +-----------------------------+-----------+----------------+
     | DDDDEEEEFFFFAAAAUUUULLLLTTTT____PPPPRRRROOOOCCCCEEEESSSSSSSS____FFFFIIIILLLLEEEE        | not set   |                |
     +-----------------------------+-----------+----------------+
     | DDDDEEEEFFFFAAAAUUUULLLLTTTT____SSSSMMMMAAAARRRRTTTT____LLLLIIIIMMMMIIIITTTT         | 4         | any nat > 1    |
     +-----------------------------+-----------+----------------+
     | DDDDEEEEFFFFAAAAUUUULLLLTTTT____MMMMCCCCLLLL____LLLLIIIIBBBBRRRRAAAARRRRIIIIEEEESSSS       | ""        | comma-separated|
     |                             |           | MCL lib list   |
     +-----------------------------+-----------+----------------+
     | DDDDEEEEFFFFAAAAUUUULLLLTTTT____EEEEVVVVAAAALLLLUUUUAAAATTTTOOOORRRR3333____LLLLIIIIBBBBRRRRAAAARRRRIIIIEEEESSSS| ""        | comma-separated|
     |                             |           | MCL3 lib list  |
     +-----------------------------+-----------+----------------+
     | DDDDEEEEFFFFAAAAUUUULLLLTTTT____EEEEVVVVAAAALLLLUUUUAAAATTTTOOOORRRR4444____LLLLIIIIBBBBRRRRAAAARRRRIIIIEEEESSSS| ""        | comma-separated|
     |                             |           | MCL4 lib list  |
     +-----------------------------+-----------+----------------+
     | DDDDEEEEFFFFAAAAUUUULLLLTTTT____EEEEVVVVAAAALLLLUUUUAAAATTTTOOOORRRR5555____LLLLIIIIBBBBRRRRAAAARRRRIIIIEEEESSSS| ""        | comma-separated|
     |                             |           | MCL5 lib list  |
     +-----------------------------+-----------+----------------+
     | DDDDEEEEFFFFAAAAUUUULLLLTTTT____XXXXTTTTLLLL____LLLLIIIIBBBBRRRRAAAARRRRIIIIEEEESSSS       | ""        | comma-separated|
     |                             |           | XTL lib list   |
     +-----------------------------+-----------+----------------+

     Note: Variable DDDDEEEEFFFFAAAAUUUULLLLTTTT____LLLLOOOOTTTTOOOOSSSS____FFFFIIIILLLLEEEE is  deprecated.   Instead,
     it  is recommended to use DDDDEEEEFFFFAAAAUUUULLLLTTTT____PPPPRRRROOOOCCCCEEEESSSSSSSS____FFFFIIIILLLLEEEE, which can be
     any file containing a LOTOS (extensions  ....llllooootttt  and  ....lllloooottttoooossss),
     LNT (extension ....llllnnnntttt), or FSP (extension ....llllttttssss) program.  How-
     ever, scripts using DDDDEEEEFFFFAAAAUUUULLLLTTTT____LLLLOOOOTTTTOOOOSSSS____FFFFIIIILLLLEEEE  should  continue  to
     work correctly.


  TTTTOOOOOOOOLLLL OOOOPPPPTTTTIIIIOOOONNNNSSSS
     The following table lists user-redefinable  shell  variables
     that  may  be assigned options that are passed to tools.  By
     default, these variables are empty.  See the respective tool
     manual pages for information about the available options.

     +------------------------+---------------------------------+
     |      Variable          |              Role               |
     +------------------------+---------------------------------+
     | AAAALLLLDDDDEEEEBBBBAAAARRRRAAAANNNN____OOOOPPPPTTTTIIIIOOOONNNNSSSS      | options passed to aaaallllddddeeeebbbbaaaarrrraaaannnn     |
     +------------------------+---------------------------------+
     | BBBBCCCCGGGG____CCCCMMMMPPPP____OOOOPPPPTTTTIIIIOOOONNNNSSSS        | options passed to bbbbccccgggg____ccccmmmmpppp       |
     +------------------------+---------------------------------+
     | BBBBCCCCGGGG____GGGGRRRRAAAAPPPPHHHH____OOOOPPPPTTTTIIIIOOOONNNNSSSS      | options passed to bbbbccccgggg____ggggrrrraaaapppphhhh     |
     +------------------------+---------------------------------+
     | BBBBCCCCGGGG____IIIIOOOO____OOOOPPPPTTTTIIIIOOOONNNNSSSS____IIIINNNNPPPPUUUUTTTT   | input options passed to bbbbccccgggg____iiiioooo  |
     +------------------------+---------------------------------+
     | BBBBCCCCGGGG____IIIIOOOO____OOOOPPPPTTTTIIIIOOOONNNNSSSS____OOOOUUUUTTTTPPPPUUUUTTTT  | output options passed to bbbbccccgggg____iiiioooo |
     +------------------------+---------------------------------+
     | BBBBCCCCGGGG____LLLLAAAABBBBEEEELLLLSSSS____OOOOPPPPTTTTIIIIOOOONNNNSSSS     | options passed to bbbbccccgggg____llllaaaabbbbeeeellllssss    |
     +------------------------+---------------------------------+
     | BBBBCCCCGGGG____MMMMIIIINNNN____OOOOPPPPTTTTIIIIOOOONNNNSSSS        | options passed to bbbbccccgggg____mmmmiiiinnnn       |



(C) INRIA            Last change: 2020/02/12                   47






CADP MANUAL PAGES                                      SVL(LOCAL)



     +------------------------+---------------------------------+
     | BBBBCCCCGGGG____OOOOPPPPEEEENNNN____OOOOPPPPTTTTIIIIOOOONNNNSSSS       | options passed to bbbbccccgggg____ooooppppeeeennnn      |
     +------------------------+---------------------------------+
     | BBBBCCCCGGGG____OOOOPPPPEEEENNNN____CCCCCCCC____OOOOPPPPTTTTIIIIOOOONNNNSSSS    | C compiler options passed by    |
     |                        | bbbbccccgggg____ooooppppeeeennnn                        |
     +------------------------+---------------------------------+
     | CCCCAAAAEEEESSSSAAAARRRR____AAAADDDDTTTT____OOOOPPPPTTTTIIIIOOOONNNNSSSS     | options passed to ccccaaaaeeeessssaaaarrrr....aaaaddddtttt    |
     +------------------------+---------------------------------+
     | CCCCAAAAEEEESSSSAAAARRRR____OOOOPPPPTTTTIIIIOOOONNNNSSSS         | options passed to ccccaaaaeeeessssaaaarrrr        |
     +------------------------+---------------------------------+
     | EEEEVVVVAAAALLLLUUUUAAAATTTTOOOORRRR____OOOOPPPPTTTTIIIIOOOONNNNSSSS      | options passed to eeeevvvvaaaalllluuuuaaaattttoooorrrr     |
     +------------------------+---------------------------------+
     | EEEEVVVVAAAALLLLUUUUAAAATTTTOOOORRRR4444____OOOOPPPPTTTTIIIIOOOONNNNSSSS     | options passed to eeeevvvvaaaalllluuuuaaaattttoooorrrr4444    |
     +------------------------+---------------------------------+
     | EEEEVVVVAAAALLLLUUUUAAAATTTTOOOORRRR5555____OOOOPPPPTTTTIIIIOOOONNNNSSSS     | options passed to eeeevvvvaaaalllluuuuaaaattttoooorrrr5555    |
     +------------------------+---------------------------------+
     | EEEEXXXXHHHHIIIIBBBBIIIITTTTOOOORRRR____OOOOPPPPTTTTIIIIOOOONNNNSSSS      | options passed to eeeexxxxhhhhiiiibbbbiiiittttoooorrrr     |
     +------------------------+---------------------------------+
     | EEEEXXXXPPPP____OOOOPPPPEEEENNNN____OOOOPPPPTTTTIIIIOOOONNNNSSSS       | options passed to eeeexxxxpppp....ooooppppeeeennnn      |
     +------------------------+---------------------------------+
     | EEEEXXXXPPPP____OOOOPPPPEEEENNNN____CCCCCCCC____OOOOPPPPTTTTIIIIOOOONNNNSSSS    | C compiler options passed by    |
     |                        | eeeexxxxpppp....ooooppppeeeennnn                        |
     +------------------------+---------------------------------+
     | FFFFSSSSPPPP____OOOOPPPPEEEENNNN____OOOOPPPPTTTTIIIIOOOONNNNSSSS       | options passed to ffffsssspppp....ooooppppeeeennnn      |
     +------------------------+---------------------------------+
     | FFFFSSSSPPPP____OOOOPPPPEEEENNNN____CCCCCCCC____OOOOPPPPTTTTIIIIOOOONNNNSSSS    | C compiler options passed by    |
     |                        | ffffsssspppp....ooooppppeeeennnn                        |
     +------------------------+---------------------------------+
     | GGGGEEEENNNNEEEERRRRAAAATTTTOOOORRRR____OOOOPPPPTTTTIIIIOOOONNNNSSSS      | options passed to ggggeeeennnneeeerrrraaaattttoooorrrr     |
     +------------------------+---------------------------------+
     | LLLLNNNNTTTT____OOOOPPPPEEEENNNN____OOOOPPPPTTTTIIIIOOOONNNNSSSS       | options passed to llllnnnntttt....ooooppppeeeennnn      |
     +------------------------+---------------------------------+
     | LLLLNNNNTTTT____OOOOPPPPEEEENNNN____CCCCCCCC____OOOOPPPPTTTTIIIIOOOONNNNSSSS    | C compiler options passed by    |
     |                        | llllnnnntttt....ooooppppeeeennnn                        |
     +------------------------+---------------------------------+
     | LLLLOOOOTTTTOOOOSSSS____OOOOPPPPEEEENNNN____OOOOPPPPTTTTIIIIOOOONNNNSSSS     | options passed to lllloooottttoooossss....ooooppppeeeennnn    |
     +------------------------+---------------------------------+
     | LLLLOOOOTTTTOOOOSSSS____OOOOPPPPEEEENNNN____CCCCCCCC____OOOOPPPPTTTTIIIIOOOONNNNSSSS  | C compiler options passed by    |
     |                        | lllloooottttoooossss....ooooppppeeeennnn                      |
     +------------------------+---------------------------------+
     | PPPPRRRROOOOJJJJEEEECCCCTTTTOOOORRRR____OOOOPPPPTTTTIIIIOOOONNNNSSSS      | options passed to pppprrrroooojjjjeeeeccccttttoooorrrr     |
     +------------------------+---------------------------------+
     | RRRREEEEDDDDUUUUCCCCTTTTOOOORRRR____OOOOPPPPTTTTIIIIOOOONNNNSSSS       | options passed to rrrreeeedddduuuuccccttttoooorrrr      |
     +------------------------+---------------------------------+
     | SSSSEEEEQQQQ____OOOOPPPPEEEENNNN____OOOOPPPPTTTTIIIIOOOONNNNSSSS       | options passed to sssseeeeqqqq....ooooppppeeeennnn      |
     +------------------------+---------------------------------+
     | SSSSEEEEQQQQ____OOOOPPPPEEEENNNN____CCCCCCCC____OOOOPPPPTTTTIIIIOOOONNNNSSSS    | C compiler options passed by    |
     |                        | sssseeeeqqqq....ooooppppeeeennnn                        |
     +------------------------+---------------------------------+
     | XXXXTTTTLLLL____OOOOPPPPTTTTIIIIOOOONNNNSSSS            | options passed to xxxxttttllll           |
     +------------------------+---------------------------------+




(C) INRIA            Last change: 2020/02/12                   48






CADP MANUAL PAGES                                      SVL(LOCAL)



     As of February 2020, the variables  CCCCAAAAEEEESSSSAAAARRRR____OOOOPPPPEEEENNNN____OOOOPPPPTTTTIIIIOOOONNNNSSSS  and
     CCCCAAAAEEEESSSSAAAARRRR____OOOOPPPPEEEENNNN____CCCCCCCC____OOOOPPPPTTTTIIIIOOOONNNNSSSS   are   obsolete   and   replaced  by
     LLLLOOOOTTTTOOOOSSSS____OOOOPPPPEEEENNNN____OOOOPPPPTTTTIIIIOOOONNNNSSSS and LLLLOOOOTTTTOOOOSSSS____OOOOPPPPEEEENNNN____CCCCCCCC____OOOOPPPPTTTTIIIIOOOONNNNSSSS, respectively.

     In general, SVL does not check the contents of  these  vari-
     ables  before  passing them to the corresponding tools. How-
     ever, there  is  a  notable  exception  concerning  variable
     EEEEXXXXPPPP____OOOOPPPPEEEENNNN____OOOOPPPPTTTTIIIIOOOONNNNSSSS:

     -    Before    calling    eeeexxxxpppp....ooooppppeeeennnn,    SVL    checks    that
          $$$$EEEEXXXXPPPP____OOOOPPPPEEEENNNN____OOOOPPPPTTTTIIIIOOOONNNNSSSS contains at most one option among the
          partial order reduction options available in  eeeexxxxpppp....ooooppppeeeennnn,
          namely ----bbbbrrrraaaannnncccchhhhiiiinnnngggg, ----ddddeeeeaaaaddddpppprrrreeeesssseeeerrrrvvvviiiinnnngggg, ----ssssttttrrrroooonnnngggg, and ----wwwweeeeaaaakkkk----
          ttttrrrraaaacccceeee.  Otherwise  it  issues  an  error  message.  See
          eeeexxxxpppp....ooooppppeeeennnn(LOCAL) manual page for more details about par-
          tial order reduction options.

     -    In normal functioning, SVL tries  to  infer  a  partial
          order reduction option from the context of the composi-
          tion expression in the  SVL  program,  and  then  calls
          eeeexxxxpppp....ooooppppeeeennnn with this option. However, this is not done if
          $$$$EEEEXXXXPPPP____OOOOPPPPEEEENNNN____OOOOPPPPTTTTIIIIOOOONNNNSSSS  already  contains  a  partial  order
          reduction option, which is thus given priority over the
          one that could be inferred.


  LLLLOOOOCCCCAAAATTTTIIIIOOOONNNN OOOOFFFF EEEEXXXXEEEECCCCUUUUTTTTAAAABBBBLLLLEEEESSSS
     The following table lists user-redefinable  shell  variables
     that  may  be  assigned a path to a different version of the
     executable file related to a given tool.

     +------------------------+---------------------------------+
     |        Variable        |         Default value           |
     +------------------------+---------------------------------+
     | AAAALLLLDDDDEEEEBBBBAAAARRRRAAAANNNN____EEEEXXXXEEEECCCCUUUUTTTTAAAABBBBLLLLEEEE   | aaaallllddddeeeebbbbaaaarrrraaaannnn                       |
     +------------------------+---------------------------------+
     | BBBBCCCCGGGG____CCCCMMMMPPPP____EEEEXXXXEEEECCCCUUUUTTTTAAAABBBBLLLLEEEE     | bbbbccccgggg____ccccmmmmpppp                         |
     +------------------------+---------------------------------+
     | BBBBCCCCGGGG____GGGGRRRRAAAAPPPPHHHH____EEEEXXXXEEEECCCCUUUUTTTTAAAABBBBLLLLEEEE   | bbbbccccgggg____ggggrrrraaaapppphhhh                       |
     +------------------------+---------------------------------+
     | BBBBCCCCGGGG____IIIIOOOO____EEEEXXXXEEEECCCCUUUUTTTTAAAABBBBLLLLEEEE      | bbbbccccgggg____iiiioooo                          |
     +------------------------+---------------------------------+
     | BBBBCCCCGGGG____LLLLAAAABBBBEEEELLLLSSSS____EEEEXXXXEEEECCCCUUUUTTTTAAAABBBBLLLLEEEE  | bbbbccccgggg____llllaaaabbbbeeeellllssss                      |
     +------------------------+---------------------------------+
     | BBBBCCCCGGGG____MMMMIIIINNNN____EEEEXXXXEEEECCCCUUUUTTTTAAAABBBBLLLLEEEE     | bbbbccccgggg____mmmmiiiinnnn                         |
     +------------------------+---------------------------------+
     | BBBBCCCCGGGG____OOOOPPPPEEEENNNN____EEEEXXXXEEEECCCCUUUUTTTTAAAABBBBLLLLEEEE    | bbbbccccgggg____ooooppppeeeennnn                        |
     +------------------------+---------------------------------+
     | BBBBIIIISSSSIIIIMMMMUUUULLLLAAAATTTTOOOORRRR____EEEEXXXXEEEECCCCUUUUTTTTAAAABBBBLLLLEEEE | bbbbiiiissssiiiimmmmuuuullllaaaattttoooorrrr                     |
     +------------------------+---------------------------------+
     | CCCCAAAAEEEESSSSAAAARRRR____AAAADDDDTTTT____EEEEXXXXEEEECCCCUUUUTTTTAAAABBBBLLLLEEEE  | ccccaaaaeeeessssaaaarrrr....aaaaddddtttt                      |
     +------------------------+---------------------------------+



(C) INRIA            Last change: 2020/02/12                   49






CADP MANUAL PAGES                                      SVL(LOCAL)



     | CCCCAAAAEEEESSSSAAAARRRR____EEEEXXXXEEEECCCCUUUUTTTTAAAABBBBLLLLEEEE      | ccccaaaaeeeessssaaaarrrr                          |
     +------------------------+---------------------------------+
     | EEEEVVVVAAAALLLLUUUUAAAATTTTOOOORRRR____EEEEXXXXEEEECCCCUUUUTTTTAAAABBBBLLLLEEEE   | eeeevvvvaaaalllluuuuaaaattttoooorrrr                       |
     +------------------------+---------------------------------+
     | EEEEVVVVAAAALLLLUUUUAAAATTTTOOOORRRR3333____EEEEXXXXEEEECCCCUUUUTTTTAAAABBBBLLLLEEEE  | eeeevvvvaaaalllluuuuaaaattttoooorrrr3333                      |
     +------------------------+---------------------------------+
     | EEEEVVVVAAAALLLLUUUUAAAATTTTOOOORRRR4444____EEEEXXXXEEEECCCCUUUUTTTTAAAABBBBLLLLEEEE  | eeeevvvvaaaalllluuuuaaaattttoooorrrr4444                      |
     +------------------------+---------------------------------+
     | EEEEVVVVAAAALLLLUUUUAAAATTTTOOOORRRR5555____EEEEXXXXEEEECCCCUUUUTTTTAAAABBBBLLLLEEEE  | eeeevvvvaaaalllluuuuaaaattttoooorrrr5555                      |
     +------------------------+---------------------------------+
     | EEEEXXXXHHHHIIIIBBBBIIIITTTTOOOORRRR____EEEEXXXXEEEECCCCUUUUTTTTAAAABBBBLLLLEEEE   | eeeexxxxhhhhiiiibbbbiiiittttoooorrrr                       |
     +------------------------+---------------------------------+
     | EEEEXXXXPPPP____OOOOPPPPEEEENNNN____EEEEXXXXEEEECCCCUUUUTTTTAAAABBBBLLLLEEEE    | eeeexxxxpppp....ooooppppeeeennnn                        |
     +------------------------+---------------------------------+
     | FFFFSSSSPPPP____OOOOPPPPEEEENNNN____EEEEXXXXEEEECCCCUUUUTTTTAAAABBBBLLLLEEEE    | ffffsssspppp....ooooppppeeeennnn                        |
     +------------------------+---------------------------------+
     | GGGGEEEENNNNEEEERRRRAAAATTTTOOOORRRR____EEEEXXXXEEEECCCCUUUUTTTTAAAABBBBLLLLEEEE   | ggggeeeennnneeeerrrraaaattttoooorrrr                       |
     +------------------------+---------------------------------+
     | LLLLNNNNTTTT____DDDDEEEEPPPPEEEENNNNDDDD____EEEEXXXXEEEECCCCUUUUTTTTAAAABBBBLLLLEEEE  | llllnnnntttt____ddddeeeeppppeeeennnndddd                      |
     +------------------------+---------------------------------+
     | LLLLNNNNTTTT____OOOOPPPPEEEENNNN____EEEEXXXXEEEECCCCUUUUTTTTAAAABBBBLLLLEEEE    | llllnnnntttt....ooooppppeeeennnn                        |
     +------------------------+---------------------------------+
     | LLLLOOOOTTTTOOOOSSSS____OOOOPPPPEEEENNNN____EEEEXXXXEEEECCCCUUUUTTTTAAAABBBBLLLLEEEE  | lllloooottttoooossss....ooooppppeeeennnn                      |
     +------------------------+---------------------------------+
     | PPPPRRRROOOOJJJJEEEECCCCTTTTOOOORRRR____EEEEXXXXEEEECCCCUUUUTTTTAAAABBBBLLLLEEEE   | pppprrrroooojjjjeeeeccccttttoooorrrr                       |
     +------------------------+---------------------------------+
     | RRRREEEEDDDDUUUUCCCCTTTTOOOORRRR____EEEEXXXXEEEECCCCUUUUTTTTAAAABBBBLLLLEEEE    | rrrreeeedddduuuuccccttttoooorrrr                        |
     +------------------------+---------------------------------+
     | SSSSEEEEQQQQ____OOOOPPPPEEEENNNN____EEEEXXXXEEEECCCCUUUUTTTTAAAABBBBLLLLEEEE    | sssseeeeqqqq....ooooppppeeeennnn                        |
     +------------------------+---------------------------------+
     | XXXXTTTTLLLL____EEEEXXXXEEEECCCCUUUUTTTTAAAABBBBLLLLEEEE         | xxxxttttllll                             |
     +------------------------+---------------------------------+

     As of February 2020, the variable CCCCAAAAEEEESSSSAAAARRRR____OOOOPPPPEEEENNNN____EEEEXXXXEEEECCCCUUUUTTTTAAAABBBBLLLLEEEE  is
     obsolete and replaced by LLLLOOOOTTTTOOOOSSSS____OOOOPPPPEEEENNNN____EEEEXXXXEEEECCCCUUUUTTTTAAAABBBBLLLLEEEE.


  PPPPRRRROOOOPPPPEEEERRRRTTTTYYYY DDDDIIIISSSSPPPPLLLLAAAAYYYY PPPPAAAARRRRAAAAMMMMEEEETTTTEEEERRRRSSSS
     The following table  lists  the  user-redefinable  variables
     that  may  be  used  to  parameterize  the  way messages are
     printed when evaluating properties. See Section PROPERTY for
     details.

     +-------------------------+------------------------+-------+
     |        Variable         |          Role          | Value |
     +-------------------------+------------------------+-------+
     | PPPPRRRROOOOPPPPEEEERRRRTTTTYYYY____DDDDIIIISSSSPPPPLLLLAAAAYYYY____MMMMOOOODDDDEEEE   | displayed information  |  0/1  |
     +-------------------------+------------------------+-------+
     | PPPPRRRROOOOPPPPEEEERRRRTTTTYYYY____CCCCOOOOMMMMMMMMEEEENNNNTTTT____OOOOPPPPEEEENNNN   | comment opening symbol |  any  |
     +-------------------------+------------------------+-------+
     | PPPPRRRROOOOPPPPEEEERRRRTTTTYYYY____CCCCOOOOMMMMMMMMEEEENNNNTTTT____MMMMIIIIDDDDDDDDLLLLEEEE | comment middle symbol  |  any  |
     +-------------------------+------------------------+-------+



(C) INRIA            Last change: 2020/02/12                   50






CADP MANUAL PAGES                                      SVL(LOCAL)



     | PPPPRRRROOOOPPPPEEEERRRRTTTTYYYY____CCCCOOOOMMMMMMMMEEEENNNNTTTT____CCCCLLLLOOOOSSSSEEEE  | comment closing symbol |  any  |
     +-------------------------+------------------------+-------+


EEEENNNNVVVVIIIIRRRROOOONNNNMMMMEEEENNNNTTTT VVVVAAAARRRRIIIIAAAABBBBLLLLEEEESSSS
     The following environment variables are used:


     $$$$CCCCAAAADDDDPPPP
          Needed. This variable contains the  path  of  directory
          where CADP is installed.


     $$$$CCCCAAAADDDDPPPP////ccccoooommmm
          This directory should be put in the $$$$PPPPAAAATTTTHHHH variable.


     $$$$SSSSVVVVLLLL Optional. The first action of the generated  script  is
          to  include the file $$$$CCCCAAAADDDDPPPP////ssssrrrrcccc////ssssvvvvllll////ssssttttaaaannnnddddaaaarrrrdddd, containing
          a list of predefined  shell  functions  and  variables.
          However,  if  the  environment variable SSSSVVVVLLLL is defined,
          the included file is  $$$$SSSSVVVVLLLL////ssssrrrrcccc////ssssvvvvllll////ssssttttaaaannnnddddaaaarrrrdddd.  Moreover,
          the  kernel  program  ssssvvvvllll____kkkkeeeerrrrnnnneeeellll  will  be  searched in
          $$$$SSSSVVVVLLLL////bbbbiiiinnnn....````aaaarrrrcccchhhh```` instead of $$$$CCCCAAAADDDDPPPP////bbbbiiiinnnn....````aaaarrrrcccchhhh````.


HHHHOOOOWWWW TTTTOOOO RRRREEEEAAAADDDD AAAANNNN SSSSVVVVLLLL FFFFIIIILLLLEEEE
     The tool ssssvvvvllll(LOCAL) reads and processes SVL files.



BBBBIIIIBBBBLLLLIIIIOOOOGGGGRRRRAAAAPPPPHHHHYYYY
     [GL01] Hubert Garavel and Frederic Lang.  SVL:  a  Scripting
     Language  for Compositional Verification.  In Myungchul Kim,
     Byoungmoon Chin, Sungwon Kang, and Danhyung  Lee  (editors),
     Proceedings  of  the 21st International Conference on Formal
     Techniques for Networked and Distributed Systems  FORTE'2001
     (Cheju  Island,  Korea),  IFIP Conference Proceedings volume
     197, pages 377-394, Kluwer,  August  2001.   Available  from
     http://cadp.inria.fr/publications/Garavel-Lang-01.html

     [GLM15] Hubert Garavel, Frederic Lang,  and  Radu  Mateescu.
     Compositional  Verification  of Asynchronous Concurrent Sys-
     tems using CADP.  Acta Informatica, Special Issue on Combin-
     ing  Compositionality  and Concurrency: Part 2, 52(4-5):337-
     392,            2015.             Available             from
     http://cadp.inria.fr/publications/Garavel-Lang-Mateescu-
     15.html

     [KM97] Jean-Pierre Krimm and Laurent Mounier.  Compositional
     State  Space Generation from LOTOS Programs.  In Ed Brinksma
     (editor), Proceedings of TACAS'97 Tools and  Algorithms  for



(C) INRIA            Last change: 2020/02/12                   51






CADP MANUAL PAGES                                      SVL(LOCAL)



     the  Construction  and  Analysis  of  Systems (University of
     Twente, Enschede, The Netherlands), Lecture  Notes  in  Com-
     puter  Science volume 1217, Springer, April 1997.  Available
     from http://cadp.inria.fr/publications/Krimm-Mounier-97.html

     [Lan02] Frederic Lang.  Compositional Verification using SVL
     Scripts.   In  Joost-Pieter Katoen and Perdita Stevens (edi-
     tors), Proceedings of the International Conference on  Tools
     and  Algorithms  for  Construction  and  Analysis of Systems
     TACAS'2002 (Grenoble, France),  Lecture  Notes  in  Computer
     Science  volume  2280,  pages 465-469, Springer, April 2002.
     Available    from    http://cadp.inria.fr/publications/Lang-
     02.html


SSSSEEEEEEEE AAAALLLLSSSSOOOO
     aaaallllddddeeeebbbbaaaarrrraaaannnn(LOCAL),  aaaauuuutttt(LOCAL),  bbbbccccgggg(LOCAL),  bbbbccccgggg____ccccmmmmpppp(LOCAL),
     bbbbccccgggg____ggggrrrraaaapppphhhh(LOCAL),      bbbbccccgggg____iiiioooo(LOCAL),     bbbbccccgggg____llllaaaabbbbeeeellllssss(LOCAL),
     bbbbccccgggg____mmmmiiiinnnn(LOCAL),       bbbbccccgggg____ooooppppeeeennnn(LOCAL),        ccccaaaaeeeessssaaaarrrr(LOCAL),
     ccccaaaaeeeessssaaaarrrr....aaaaddddtttt(LOCAL),                     ccccaaaaeeeessssaaaarrrr____hhhhiiiiddddeeee____1111(LOCAL),
     ccccaaaaeeeessssaaaarrrr____rrrreeeennnnaaaammmmeeee____1111(LOCAL), eeeevvvvaaaalllluuuuaaaattttoooorrrr(LOCAL), eeeevvvvaaaalllluuuuaaaattttoooorrrr3333(LOCAL),
     eeeevvvvaaaalllluuuuaaaattttoooorrrr4444(LOCAL),    eeeevvvvaaaalllluuuuaaaattttoooorrrr5555(LOCAL),   eeeexxxxhhhhiiiibbbbiiiittttoooorrrr(LOCAL),
     eeeexxxxpppp(LOCAL),        eeeexxxxpppp....ooooppppeeeennnn(LOCAL),        ggggeeeennnneeeerrrraaaattttoooorrrr(LOCAL),
     llllnnnntttt....ooooppppeeeennnn(LOCAL), lllloooottttoooossss....ooooppppeeeennnn(LOCAL), mmmmccccllll(LOCAL), mmmmccccllll3333(LOCAL),
     mmmmccccllll4444(LOCAL), mmmmccccllll5555(LOCAL), pppprrrroooojjjjeeeeccccttttoooorrrr(LOCAL), rrrreeeedddduuuuccccttttoooorrrr(LOCAL),
     rrrreeeeggggeeeexxxxpppp(LOCAL),   sssseeeeqqqq(LOCAL),   sssseeeeqqqq....ooooppppeeeennnn(LOCAL),  ssssvvvvllll(LOCAL),
     xxxxttttllll(LOCAL), xxxxttttllll----llllaaaannnngggg(LOCAL)

     Directives   for   installation   are   given    in    files
     $$$$CCCCAAAADDDDPPPP////IIIINNNNSSSSTTTTAAAALLLLLLLLAAAATTTTIIIIOOOONNNN____****.

     Recent  changes  and  improvements  to  this  software   are
     reported and commented in file $$$$CCCCAAAADDDDPPPP////HHHHIIIISSSSTTTTOOOORRRRYYYY.


BBBBUUUUGGGGSSSS
     Please report any bug to cadp@inria.fr


















(C) INRIA            Last change: 2020/02/12                   52



