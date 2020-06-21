


CADP MANUAL PAGES                                 XTL-LANG(LOCAL)



NNNNAAAAMMMMEEEE
     xtl - language for value-based temporal logic formulas


DDDDEEEESSSSCCCCRRRRIIIIPPPPTTTTIIIIOOOONNNN
     XTL (eXecutable Temporal Language) is a functional  program-
     ming  language  interpreted  over  LTSs (Labelled Transition
     Systems) encoded in the BCG (Binary Coded Graph)  file  for-
     mat.

     XTL can typically be used for  implementing  temporal  logic
     operators,  by  describing  their  fixed  point semantics as
     iterative or recursive computations over sets of states.

     More generally, XTL enables one to perform  any  computation
     on  a  BCG graph: for instance, it can compute the branching
     factor of a graph, print its list of labels, etc.

     XTL programs are compiled and evaluated  on  BCG  graphs  by
     using the xxxxttttllll(LOCAL) model checker.


LLLLTTTTSSSS MMMMOOOODDDDEEEELLLL
     An XTL program is evaluated over an LTS model generated from
     a  source program to be verified. This LTS, encoded in a BCG
     file, contains the following elements:


     -    a set of _s_t_a_t_e_s of  the  source  program.  A  state  is
          represented as a tuple containing the values of all the
          variables of the program  (the  so-called  "state  vec-
          tor").


     -    a set of _l_a_b_e_l_s performed by the program. An  label  is
          represented  as  a  list  of typed values. In BCG files
          generated from LOTOS programs, the labels have the form
          _G _v_1 ... _v_m (with m >= 0), where _G is a gate name.


     -    a _t_r_a_n_s_i_t_i_o_n _r_e_l_a_t_i_o_n between the states  of  the  pro-
          gram.  A  transition,  represented  as a triple (_s_1, _a,
          _s_2), means that the program can move from state  _s_1  to
          state _s_2 by performing a transition labelled with _a.


     -    the _i_n_i_t_i_a_l _s_t_a_t_e of the program.


SSSSYYYYNNNNTTTTAAAAXXXX AAAANNNNDDDD SSSSEEEEMMMMAAAANNNNTTTTIIIICCCCSSSS OOOOFFFF XXXXTTTTLLLL
     The syntax of each XTL construct is defined by a BNF grammar
     and  the semantics is described informally. Terminal symbols



(C) INRIA            Last change: 2019/05/29                    1






CADP MANUAL PAGES                                 XTL-LANG(LOCAL)



     are  enclosed  in  double  quotes.  Optional  elements   are
     enclosed  in  square brackets. Suspension points are used to
     denote zero or more repetitions of an element.  The  meaning
     of grammar symbols is given in the table below. The axiom of
     the grammar is the non-terminal symbol _P_G.

              +--------+-------------------------------+
              | Symbol |          Description          |
              +========+===============================+
              |   _K    | constant                      |
              |   _x    | variable                      |
              |   _T    | simple type                   |
              |   _G    | gate                          |
              |   _F    | function                      |
              |   _M    | macro                         |
              |   _P    | macro parameter               |
              |   _E    | expression                    |
              |   _O    | offer                         |
              |   _D    | variable declaration          |
              |   _R_T   | result type                   |
              |   _O_P   | operator                      |
              |   _F_D   | function definition           |
              |   _M_D   | macro definition              |
              |   _L_I   | library inclusion             |
              |   _E_T_D  | external type declaration     |
              |   _E_F_D  | external function declaration |
              |   _E_I_D  | external include directive    |
              |   _E_L_D  | external compile directive    |
              |   _P_G   | program                       |
              +--------+-------------------------------+


  LLLLEEEEXXXXIIIICCCCAAAALLLL EEEELLLLEEEEMMMMEEEENNNNTTTTSSSS
     The lexical units of  XTL  are:  _k_e_y_w_o_r_d_s,  _i_d_e_n_t_i_f_i_e_r_s  and
     _s_e_p_a_r_a_t_o_r_s.  The  keywords, listed below, must be written in
     lower-case letters.

               aaaannnnyyyy          eeeennnndddd____ddddeeeeffff      eeeexxxxiiiissssttttssss   ooooffff
               aaaappppppppllllyyyy        eeeennnndddd____eeeexxxxiiiissssttttssss   ffffoooorrrr      oooonnnn
               aaaasssssssseeeerrrrtttt       eeeennnndddd____ffffoooorrrr      ffffoooorrrraaaallllllll   tttthhhheeeennnn
               ddddeeeeffff          eeeennnndddd____ffffoooorrrraaaallllllll   ffffrrrroooommmm     ttttoooo
               eeeellllsssseeee         eeeennnndddd____iiiiffff       iiiiffff       uuuusssseeee
               eeeellllsssseeee____iiiiffff      eeeennnndddd____lllleeeetttt      iiiinnnn       wwwwhhhheeeerrrreeee
               eeeennnndddd____aaaasssssssseeeerrrrtttt   eeeennnndddd____uuuusssseeee      lllleeeetttt

     The identifiers are grouped into two classes:


     -    _e_x_t_e_r_n_a_l _i_d_e_n_t_i_f_i_e_r_s denote the objects defined in  the
          source  program  to be verified (these objects are con-
          tained in the BCG  file).   These  identifiers  may  be
          written  like the internal ones, as long as there is no



(C) INRIA            Last change: 2019/05/29                    2






CADP MANUAL PAGES                                 XTL-LANG(LOCAL)



          clash between them and the normal  identifiers  or  the
          XTL  keywords. In the latter case, external identifiers
          must be preceded by a dollar character (e.g., $$$$lllleeeetttt)  to
          avoid clashes.


     -    _i_n_t_e_r_n_a_l _i_d_e_n_t_i_f_i_e_r_s denote the objects defined in  the
          XTL  program (or predefined in the XTL language). These
          identifiers may be  either  _n_o_r_m_a_l,  i.e.,  built  from
          letters,  digits  and  underscores  (beginning  with  a
          letter or an underscore), or _s_p_e_c_i_a_l, i.e., built  from
          the  characters  #, %, &, *, +, -, ., /, >, =, <, @, \,
          ^, and ~. In normal identifiers, no difference is  made
          between  lower-  and  uppercase  letters.   The special
          identifiers are useful for mathematical and/or  logical
          notations (e.g., '+', '/\', etc.).


     The separators are sequences containing space, tab, and new-
     line  characters,  as  well as _c_o_m_m_e_n_t_s, enclosed between ((((****
     and ****)))).


  IIIINNNNTTTTEEEERRRRNNNNAAAALLLL AAAANNNNDDDD EEEEXXXXTTTTEEEERRRRNNNNAAAALLLL TTTTYYYYPPPPEEEESSSS
     XTL is a strongly-typed language: every object  used  in  an
     XTL  program  must  have  a unique type, which is statically
     determined. XTL does not provide a mechanism for type defin-
     ition,  although  anonymous  tuple  types (see below) can be
     implicitly created. The types allowed in XTL fall  into  the
     following classes:


     -    _e_x_t_e_r_n_a_l _t_y_p_e_s are imported from the source program  to
          be  verified.   These  types  are contained in the type
          area of the BCG file and can be referenced in XTL  pro-
          grams  using  external  identifiers.  Other  externally
          defined types can be included in the  XTL  programs  by
          means of special directives (see DIRECTIVES below).

     -    _i_n_t_e_r_n_a_l _t_y_p_e_s are either predefined in  the  language,
          or defined by the user.


  IIIINNNNTTTTEEEERRRRNNNNAAAALLLL AAAANNNNDDDD EEEEXXXXTTTTEEEERRRRNNNNAAAALLLL FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNNSSSS
     The functions (also called _o_p_e_r_a_t_o_r_s) that can be used in an
     XTL program fall into the following classes:


     -    _e_x_t_e_r_n_a_l _f_u_n_c_t_i_o_n_s are defined in the source program to
          be  verified.   They are contained in the function area
          of the BCG file and can be referenced in  XTL  programs
          using external identifiers.



(C) INRIA            Last change: 2019/05/29                    3






CADP MANUAL PAGES                                 XTL-LANG(LOCAL)



     -    _i_n_t_e_r_n_a_l _f_u_n_c_t_i_o_n_s are either predefined in XTL (a list
          of the predefined functions has been given in the above
          paragraphs), or user-defined (see FUNCTIONS  below  for
          the syntax of function definitions).


     In XTL, functions can be _o_v_e_r_l_o_a_d_e_d,  i.e.,  have  the  same
     identifier  but  different  types for their arguments and/or
     result. The XTL  compiler  resolves  overloading  statically
     (i.e.,  at  compile-time)  or issues an error message if the
     context does not permit  to  resolve  overloading  (in  such
     case,  the "ooooffff" operator can be used to supply typing infor-
     mation).


     In XTL, a function _F can be either _p_r_e_f_i_x_e_d, i.e., its calls
     are  written  "_F (_E_1, ..., _E_n)", or _i_n_f_i_x_e_d, i.e., _F has two
     arguments and its calls are written "_E_1 _F _E_2".


     Most predefined functions are infixed, except "eeeexxxxttttrrrraaaacccctttt"  and
     "rrrreeeeppppllllaaaacccceeee".  For  user-defined functions, the prefix or infix
     nature is specified when the function is declared.

     Also, unary minus operators must be  written  in  functional
     notation, i.e., ----((((1111)))) instead of ----1111, ----((((XXXX)))) instead of ----XXXX, etc.


  BBBBOOOOOOOOLLLLEEEEAAAANNNN TTTTYYYYPPPPEEEE AAAANNNNDDDD FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNNSSSS
     The Boolean type is named bbbboooooooolllleeeeaaaannnn.   The  Boolean  constants
     ttttrrrruuuueeee  and  ffffaaaallllsssseeee  are defined as 0-ary functions.  The table
     below gives the predefined functions for this type:

     +----------------------------------------+--------------------------+
     |                Operator                |         Meaning          |
     +========================================+==========================+
     | true, false : -> boolean               | boolean constants        |
     | not : boolean -> boolean               | negation                 |
     | or, and, implies,                      | connectors and           |
     |   =, <> : boolean, boolean -> boolean  |   relational operators   |
     | replace : boolean, boolean -> boolean  | replacement operator     |
     +----------------------------------------+--------------------------+

     The "rrrreeeeppppllllaaaacccceeee" operator (which is overloaded for  all  types)
     takes  two arguments of the same type and returns the second
     one. It is useful for use within the "ffffoooorrrr" expressions  (see
     EXPRESSIONS below).


  IIIINNNNTTTTEEEEGGGGEEEERRRR TTTTYYYYPPPPEEEE AAAANNNNDDDD FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNNSSSS
     The signed integer type is named iiiinnnntttteeeeggggeeeerrrr.  Integer constants
     are  noted  with a C-like syntax and should be preceded of a



(C) INRIA            Last change: 2019/05/29                    4






CADP MANUAL PAGES                                 XTL-LANG(LOCAL)



     sign "++++" or "----", e.g., ----111122223333, ++++111122223333, ++++0000, etc.  The table below
     gives the predefined functions for this type:

     +----------------------------------------+--------------------------+
     |                Operator                |         Meaning          |
     +========================================+==========================+
     | -, +    : integer, integer -> integer  | binary minus, plus       |
     | -       : integer -> integer           | unary minus              |
     | *, div  : integer, integer -> integer  | multiplication, division |
     | mod     : integer, integer -> integer  | modulo                   |
     | **      : integer, integer -> integer  | power                    |
     | integer : real -> integer              | real to integer          |
     | integer : character -> integer         | character to integer     |
     | <, <=, >, >=, =, <> :                  | relational operators     |
     |     integer, integer -> boolean        |                          |
     | replace : integer, integer -> integer  | replacement operator     |
     +----------------------------------------+--------------------------+


  NNNNAAAATTTTUUUURRRRAAAALLLL TTTTYYYYPPPPEEEE AAAANNNNDDDD FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNNSSSS
     The unsigned integer type is named  nnnnaaaattttuuuurrrraaaallll.   Natural  con-
     stants  are  noted  with a C-like syntax and should never be
     preceded of a sign, e.g., 111122223333,  0000,  etc.   The  table  below
     gives the predefined functions for this type:

     +----------------------------------------+--------------------------+
     |                Operator                |         Meaning          |
     +========================================+==========================+
     | -, +    : natural, natural -> natural  | binary minus, plus       |
     | *, div  : natural, natural -> natural  | multiplication, division |
     | mod     : natural, natural -> natural  | modulo                   |
     | **      : natural, natural -> natural  | power                    |
     | natural : real -> natural              | real to integer          |
     | natural : character -> natural         | character to natural     |
     | <, <=, >, >=, =, <> :                  | relational operators     |
     |     natural, natural -> boolean        |                          |
     | replace : natural, natural -> natural  | replacement operator     |
     +----------------------------------------+--------------------------+


     By default, an unsigned number 111122223333 denotes either a value of
     type  nnnnaaaattttuuuurrrraaaallll  or  a value of type iiiinnnntttteeeeggggeeeerrrr. Such overloading
     can be resolved explicitly by the user (using an "ooooffff" opera-
     tor)  or  implicitly  by  the context (for instance, in ((((XXXX ++++
     111122223333)))), the type of XXXX will determine the type of 111122223333). If  the
     context  does  not  permit  to resolve overloading, then the
     constant will ultimately be given the type Natural. To  sum-
     marize:
     - ++++111122223333 has the iiiinnnntttteeeeggggeeeerrrr type.
     - ----111122223333 has the iiiinnnntttteeeeggggeeeerrrr type.
     - 111122223333 ooooffff iiiinnnntttteeeeggggeeeerrrr has the iiiinnnntttteeeeggggeeeerrrr type.
     - 111122223333 ooooffff nnnnaaaattttuuuurrrraaaallll has the nnnnaaaattttuuuurrrraaaallll type.



(C) INRIA            Last change: 2019/05/29                    5






CADP MANUAL PAGES                                 XTL-LANG(LOCAL)



     - 111122223333 has either the nnnnaaaattttuuuurrrraaaallll or iiiinnnntttteeeeggggeeeerrrr type (with  a  final
     priority for nnnnaaaattttuuuurrrraaaallll).


  RRRREEEEAAAALLLL TTTTYYYYPPPPEEEE AAAANNNNDDDD FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNNSSSS
     The floating-point number type is  named  rrrreeeeaaaallll.   Real  con-
     stants  are  noted  with  a  C-like  syntax,  e.g.,  3333....1111444411116666,
     ----9999....99998888EEEE----6666, etc.  The table below gives the  predefined  func-
     tions for this type:

     +----------------------------------------+--------------------------+
     |                Operator                |         Meaning          |
     +========================================+==========================+
     | -, + : real, real -> real              | binary minus, plus       |
     | -    : real -> real                    | unary minus              |
     | *, / : real, real -> real              | multiplication, division |
     | **   : real, real -> real              | power                    |
     | real : integer -> real                 | integer to real          |
     | <, <=, >, >=, =, <> :                  | relational operators     |
     |     real, real -> boolean              |                          |
     | replace : real, real -> real           | replacement operator     |
     +----------------------------------------+--------------------------+


  CCCCHHHHAAAARRRRAAAACCCCTTTTEEEERRRR TTTTYYYYPPPPEEEE AAAANNNNDDDD FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNNSSSS
     The character type is named cccchhhhaaaarrrraaaacccctttteeeerrrr.  Character  constants
     are  noted  with  a  C-like syntax, e.g., ''''aaaa'''', ''''\\\\nnnn'''', ''''\\\\000011112222'''',
     ''''\\\\xxxx1111AAAA'''', etc.  The table below gives the predefined functions
     for this type:

     +----------------------------------------+--------------------------+
     |                Operator                |         Meaning          |
     +========================================+==========================+
     | -, + : character, integer -> character | subtract, add integer    |
     | character : integer -> character       | integer to character     |
     | <, <=, >, >=, =, <> :                  | relational operators     |
     |     character, character -> boolean    |                          |
     | replace :                              |                          |
     |     character, character -> character  | replacement operator     |
     +----------------------------------------+--------------------------+


  SSSSTTTTRRRRIIIINNNNGGGG TTTTYYYYPPPPEEEE AAAANNNNDDDD FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNNSSSS
     The character-string type is named ssssttttrrrriiiinnnngggg.  String constants
     are   noted  with  a  C-like  syntax,  e.g.,  """"aaaabbbbcccc"""",  """"111122223333"""",
     """"HHHHeeeelllllllloooo\\\\nnnn"""", etc.  The table below gives the predefined  func-
     tions for this type:








(C) INRIA            Last change: 2019/05/29                    6






CADP MANUAL PAGES                                 XTL-LANG(LOCAL)



     +----------------------------------------+--------------------------+
     |                Operator                |         Meaning          |
     +========================================+==========================+
     | null    : -> string                    | empty string             |
     | length  : string -> integer            | string length            |
     | extract : string, integer -> character | character extraction     |
     | =, <>   : string, string -> boolean    | relational operators     |
     | replace : string, string -> string     | replacement operator     |
     +----------------------------------------+--------------------------+


  RRRRAAAAWWWW TTTTYYYYPPPPEEEE AAAANNNNDDDD FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNNSSSS
     The rrrraaaawwww type represents a byte string that denotes  a  value
     of  unknown  type,  i.e., whose type is not one of the other
     predefined types.  Raw constants are  noted  with  a  C-like
     syntax but using backquotes rather than double quotes, e.g.,
     ````ffffoooooooo````, ````CCCCOOOONNNNSSSS ((((0000,,,, NNNNIIIILLLL))))````, or ````{{{{0000,,,, 1111}}}}````, etc.  The  table  below
     gives the predefined functions for this type:

     +----------------------------------------+--------------------------+
     |                Operator                |         Meaning          |
     +========================================+==========================+
     | null    : -> raw                       | empty raw data           |
     | length  : raw -> integer               | raw data length          |
     | extract : raw, integer -> character    | character extraction     |
     | =, <>   : raw, raw -> boolean          | relational operators     |
     | replace : raw, raw -> raw              | replacement operator     |
     +----------------------------------------+--------------------------+


     By default, the string notation """"............"""" denotes either a value
     of  type ssssttttrrrriiiinnnngggg or a value of type rrrraaaawwww. Such overloading can
     be resolved explicitly by the user (using an "ooooffff"  operator)
     or  implicitly by the context (for instance, in ((((XXXX ==== """"ffffoooooooo"""")))),
     the type of XXXX will determine the type of """"aaaabbbbcccc""""). If the con-
     text  does  not permit to resolve overloading, then the con-
     stant will ultimately be given the type String.  To  summar-
     ize:
     - ````ffffoooooooo```` has the rrrraaaawwww type.
     - """"ffffoooooooo"""" ooooffff ssssttttrrrriiiinnnngggg has the ssssttttrrrriiiinnnngggg type.
     - """"ffffoooooooo"""" ooooffff rrrraaaawwww has the rrrraaaawwww type.
     - """"ffffoooooooo"""" has either the ssssttttrrrriiiinnnngggg or  rrrraaaawwww  type  (with  a  final
     priority for ssssttttrrrriiiinnnngggg).


  MMMMEEEETTTTAAAA----TTTTYYYYPPPPEEEESSSS AAAANNNNDDDD FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNNSSSS
     The  types  ssssttttaaaatttteeee,  llllaaaabbbbeeeellll,  eeeeddddggggeeee,  ssssttttaaaatttteeeesssseeeetttt,  llllaaaabbbbeeeellllsssseeeetttt,  and
     eeeeddddggggeeeesssseeeetttt  (also  called  _m_e_t_a-_t_y_p_e_s because they refer to the
     LTS model rather than to the objects defined in  the  source
     program  to  be  verified) denote the states, labels, edges,
     sets of states, sets of labels, and sets  of  edges  of  the
     LTS, respectively.



(C) INRIA            Last change: 2019/05/29                    7






CADP MANUAL PAGES                                 XTL-LANG(LOCAL)



     The table below gives the predefined  operators  over  these
     types   ("sssseeeetttt"   denoting   either  ssssttttaaaatttteeeesssseeeetttt,  llllaaaabbbbeeeellllsssseeeetttt,  or
     eeeeddddggggeeeesssseeeetttt). These operators allow to explore  (forward  and/or
     backward)  the  transition  relation  of the LTS, to combine
     sets of states, labels and edges, and also to obtain  infor-
     mation about the LTS.

     +-----------------------------------+-------------------------+
     |             Operator              |         Meaning         |
     +===================================+=========================+
     | init   : -> state                 | initial state           |
     | succ   : state -> stateset        | successor states        |
     | pred   : state -> stateset        | predecessor states      |
     | out    : state -> edgeset         | successor transitions   |
     | in     : state -> edgeset         | predecessor transitions |
     | =, <>  : state, state -> boolean  | comparison operators    |
     | replace : state, state -> state   | replacement operator    |
     +-----------------------------------+-------------------------+
     | visible : label -> boolean        | visibility test         |
     | string  : label -> string         | label to string         |
     | =, <>   : label, label -> boolean | comparison operators    |
     | replace : label, label -> label   | replacement operator    |
     +-----------------------------------+-------------------------+
     | source : edge -> state            | transition source state |
     | target : edge -> state            | transition target state |
     | label  : edge -> label            | transition label        |
     | succ   : edge -> edgeset          | successor transitions   |
     | pred   : edge -> edgeset          | predecessor transitions |
     | =, <>  : edge, edge -> boolean    | comparison operators    |
     | replace : edge, edge -> edge      | replacement operator    |
     +-----------------------------------+-------------------------+
     | empty, false : -> set             | empty set               |
     | full, true   : -> set             | full set                |
     | comp, not  : set -> set           | complementation         |
     | union, or  : set, set -> set      | union                   |
     | inter, and : set, set -> set      | intersection            |
     | implies    : set, set -> set      | implication             |
     | iff        : set, set -> set      | equivalence             |
     | diff       : set, set -> set      | difference              |
     | includes   : set, set -> boolean  | inclusion test          |
     | insert, remove : set, elem -> set | insertion, removal      |
     | among : elem, set -> boolean      | membership              |
     | card  : set -> number             | cardinal                |
     | =, <> : set, set -> boolean       | comparison operators    |
     | replace : set, set -> set         | replacement operator    |
     +-----------------------------------+-------------------------+

     For convenience, some of the operators above are  overloaded
     (see  FUNCTIONS below). Also, some of the set operators have
     synonyms (e.g., uuuunnnniiiioooonnnn has the synonym oooorrrr)  allowing  a  more
     intuitive writing of boolean properties.




(C) INRIA            Last change: 2019/05/29                    8






CADP MANUAL PAGES                                 XTL-LANG(LOCAL)



  NNNNUUUUMMMMBBBBEEEERRRR TTTTYYYYPPPPEEEE AAAANNNNDDDD FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNNSSSS
     The BCG file format associates  a  unique  number  to  every
     state, label, and edge of the LTS. The XTL language provides
     the nnnnuuuummmmbbbbeeeerrrr type for the manipulation of  state,  label,  and
     edge numbers. The table below gives the predefined operators
     of type nnnnuuuummmmbbbbeeeerrrr.

     +------------------------------------+--------------------------+
     |             Operator               |       Meaning            |
     +====================================+==========================+
     | number_of_states : -> number       | number of states         |
     | number_of_labels : -> number       | number of labels         |
     | number_of_edges  : -> number       | number of edges          |
     | number : state -> number           | state number             |
     | number : label -> number           | label number             |
     | number : edge -> number            | edge number              |
     +------------------------------------+--------------------------+
     | -, +   : number, number -> number  | binary minus, plus       |
     | *, div : number, number -> number  | multiplication, division |
     | mod    : number, number -> number  | modulo                   |
     | **     : number, number -> number  | power                    |
     | number : character -> number       | conversion from/to       |
     | character : number -> character    |   character              |
     | number : integer -> number         | conversion from/to       |
     | integer : number -> integer        |   integer                |
     | number : real -> number            | conversion from/to       |
     | real : number -> real              |   real                   |
     | <, <=, >, >=, =, <> :              | relational operators     |
     |     number, number -> boolean      |                          |
     | replace : number, number -> number | replacement operator     |
     +------------------------------------+--------------------------+

     All arithmetic operators (except unary minus) and relational
     operators  of  type  iiiinnnntttteeeeggggeeeerrrr  are  also  available  for type
     nnnnuuuummmmbbbbeeeerrrr.  Moreover, the values belonging to these  two  types
     can be freely mixed within arithmetic and relational expres-
     sions. The main difference between these two types  concerns
     the manipulation of large numbers: the maximum value of type
     iiiinnnntttteeeeggggeeeerrrr is 2222^^^^33331111----1111 = 2222,,,,111144447777,,,,444488883333,,,,666644447777  on  32-bit  machines  and
     2222^^^^66663333----1111   =  9999,,,,222222223333,,,,333377772222,,,,000033336666,,,,888855554444,,,,777777775555,,,,888800007777  on  64-bit  machines,
     whereas the  maximum  value  of  type  nnnnuuuummmmbbbbeeeerrrr  is  2222^^^^33332222----1111  =
     4444,,,,222299994444,,,,999966667777,,,,222299995555    on    32-bit    machines   and   2222^^^^66664444----1111   =
     11118888,,,,444444446666,,,,777744444444,,,,000077773333,,,,777700009999,,,,555555551111,,,,666611115555 on 64-bit  machines.   Therefore,
     for large LTSs, any information concerning the LTS structure
     (e.g.,    cardinality    of    state/edge/label     subsets,
     depth/breadth  of  the  LTS, number of breadth-first levels,
     etc.) should be manipulated  using  values  of  type  nnnnuuuummmmbbbbeeeerrrr
     instead of type iiiinnnntttteeeeggggeeeerrrr in order to avoid overflows.

     Conversion operators between the nnnnuuuummmmbbbbeeeerrrr type and  the  types
     cccchhhhaaaarrrraaaacccctttteeeerrrr, iiiinnnntttteeeeggggeeeerrrr, and rrrreeeeaaaallll are also provided. Constants of
     type nnnnuuuummmmbbbbeeeerrrr are written in decimal notation  preceded  by  a



(C) INRIA            Last change: 2019/05/29                    9






CADP MANUAL PAGES                                 XTL-LANG(LOCAL)



     ''''####''''  character  (e.g.,  ####4444222299994444999966667777222299995555).  An alternative way of
     representing constants of type nnnnuuuummmmbbbbeeeerrrr that fit in the  range
     of  type iiiinnnntttteeeeggggeeeerrrr is by means of the conversion operator from
     iiiinnnntttteeeeggggeeeerrrr to nnnnuuuummmmbbbbeeeerrrr (e.g., the values  nnnnuuuummmmbbbbeeeerrrr((((2222111144447777444488883333666644447777))))  and
     ####2222111144447777444488883333666644447777 are the same).


  AAAACCCCTTTTIIIIOOOONNNN TTTTYYYYPPPPEEEE AAAANNNNDDDD FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNNSSSS
     The XTL language  has  an  action  type  associated  to  XTL
     expressions  that  return no value but perform side effects.
     These are used to print data values on  the  POSIX  standard
     output stream (ssssttttddddoooouuuutttt). The table below gives the predefined
     operators of type aaaaccccttttiiiioooonnnn (T may be any type).

     The  pppprrrriiiinnnntttt  and  pppprrrriiiinnnnttttffff  operators  behave  differently   on
     strings:   pppprrrriiiinnnntttt  prints  the string enclosed between double
     quotes  and  converts  unprintable  characters  and   escape
     sequences to three-digit octal notation, whereas pppprrrriiiinnnnttttffff does
     not add double quotes and interprets execute sequences.  For
     instance,  pppprrrriiiinnnntttt ((((""""HHHHeeeelllllllloooo!!!!\\\\nnnn"""")))) displays """"HHHHeeeelllllllloooo!!!!\\\\000011112222"""", whereas
     pppprrrriiiinnnnttttffff ((((""""HHHHeeeelllllllloooo!!!!\\\\nnnn"""")))) displays HHHHeeeelllllllloooo!!!! followed by a line-feed.
     So,  pppprrrriiiinnnntttt  should  be  used to display string values (e.g.,
     label offers of the string type), whereas pppprrrriiiinnnnttttffff  should  be
     used to display messages.

     +--------------------------------+---------------------------+
     |            Operator            |        Meaning            |
     +================================+===========================+
     | nop : -> action                | inaction                  |
     | fby : action, action -> action | sequential composition    |
     | print : T -> action            | value printing            |
     | printf : string -> action      | string formatted printing |
     +--------------------------------+---------------------------+


  AAAANNNNOOOONNNNYYYYMMMMOOOOUUUUSSSS TTTTUUUUPPPPLLLLEEEE TTTTYYYYPPPPEEEESSSS
     These types denote structures containing fields of different
     types.  The  fields  can be of any type (including anonymous
     tuples, which enables nesting of tuples).  These  types  are
     noted  "("  _T_0","  ..."," _T_n ")" and are essentially used in
     situations when several values must be computed and returned
     simultaneously.  The  equivalence  of tuple types is defined
     structurally.  The tuple values are noted "("  _E_0","  ...","
     _E_n ")" (see EXPRESSIONS below).


  EEEEXXXXPPPPRRRREEEESSSSSSSSIIIIOOOONNNNSSSS
     The expressions allowed in XTL use the  following  auxiliary
     constructs.


     Offers



(C) INRIA            Last change: 2019/05/29                   10






CADP MANUAL PAGES                                 XTL-LANG(LOCAL)



          An _o_f_f_e_r is a construct allowing to match a value  con-
          tained  in a transition label. The offers have the fol-
          lowing syntax:

          _O       ::=  "?" _x ":" _T

                   |   "!" _E

                   |   "_"

          An offer "?" _x ":" _T matches a value _v iff  _v  has  the
          type  _T;  in  case  of matching, the variable _x is also
          assigned the value _v. An offer "!" _E matches a value  _v
          iff  the  expression  _E  evaluates  to  _v. An offer "_"
          (wildcard) matches a value _v of any type.

     Result types
          The  result  types  denote  either  simple  types,   or
          anonymous tuple types.  They have the following syntax:

          _R_T      ::= _T

                   |  "(" _R_T_0"," ..."," _R_T_n ")"

          These types may occur in variable declarations (see the
          next  paragraph)  as  well  as in function declarations
          (see FUNCTIONS below).

     Variable declarations
          The variable declarations have the following syntax:

          _D ::= _x ":" _R_T

             |  "any" _R_T

             |  "(" _D_0"," ..."," _D_n ")"

          A declaration _x ":" _R_T defines the variable _x  of  type
          _R_T.  A  declaration  "any" _R_T, which is meaningful only
          inside a declaration of anonymous tuple type, defines a
          placeholder  of  type  _R_T  standing  for a field of the
          tuple. Declarations of the form "any" _R_T can occur only
          in  the  "let"  expressions (see below).  A declaration
          "(" _D_0"," ..."," _D_n ")" defines a  tuple  whose  fields
          are denoted by the variables and placeholders occurring
          inside _D_0, ..., _D_n.

     Operators
          The operators  occur  in  the  "ffffoooorrrr"  expressions  (see
          below);  they  denote  calls of binary functions on two
          arguments. They have the following syntax:




(C) INRIA            Last change: 2019/05/29                   11






CADP MANUAL PAGES                                 XTL-LANG(LOCAL)



          _O_P        ::= _F

                     |  "(" _O_P_0"," ..."," _O_P_n ")"

          An _F operator denotes a call of the binary function  _F.
          An "(" _O_P_0"," ..."," _O_P_n ")" operator denotes a call of
          a binary function on two arguments of tuple  type;  the
          result  is  a tuple whose fields are the results of the
          calls of _O_P_0, ..., _O_P_n on the corresponding  fields  of
          the  arguments.  There is a static semantics constraint
          on the operators _O_P: their left arguments must have the
          same types as their results.











































(C) INRIA            Last change: 2019/05/29                   12






CADP MANUAL PAGES                                 XTL-LANG(LOCAL)



     The syntax of expressions is given by the following grammar:

     _E ::=  _K

        |   _F "(" _E_0"," ..."," _E_n ")"

        |   _E_0 "of" _R_T

        |   _E_0 "->" "[" _O_0 ... _O_n [ "..." ] [ "where" _E_1 ] "]"

        |   "{" _E_0"," ..."," _E_n "}"

        |   "(" _E_0"," ..."," _E_n ")"

        |   "let" _D_0 "=" _E_0"," ..."," _D_n "=" _E_n "in"
                _E_n+_1
            "end_let"

        |   "if" _E_0 "then" _E'_0
                "else_if" _E_1 "then" _E'_1
                ...
                "else_if" _E_n "then" _E'_n
                "else" _E'_n+_1
            "end_if"

        |   "assert" _E_0"," ..."," _E_n "in"
                _E_n+_1
            "end_assert"

        |   "use" _x_0"," ..."," _x_n "in"
                _E
            "end_use"

        |   "for" [ _x_0 ":" _T_0 [ "among" _E_0 ]"," ...","
                    _x_n ":" _T_n [ "among" _E_n ] ]
                [ "in" _D ]
                [ "while" _E'_1 ]
                [ "where" _E'_2 ]
                "apply" _O_P
                "from" _E'_3
                "to" _E'_4
            "end_for"













(C) INRIA            Last change: 2019/05/29                   13






CADP MANUAL PAGES                                 XTL-LANG(LOCAL)



        |   "forall" _x_0 ":" _T_0 [ "among" _E_0 ]"," ...","
                     _x_n ":" _T_n [ "among" _E_n ]
            "in"
                _E_n+_1
            "end_forall"

        |   "exists" _x_0 ":" _T_0 [ "among" _E_0 ]"," ...","
                     _x_n ":" _T_n [ "among" _E_n ]
            "in"
                _E_n+_1
            "end_exists"

        |   "<|" _O_P "on" _x_0 ":" _T_0 [ "among" _E_0 ]"," ...","
                         _x_n ":" _T_n [ "among" _E_n ]
                 [ "where" _E' ]
            "|>" _E_n+_1

        |   "{" _x ":" _T [ "among" _E_0 ] "where" _E_1 "}"

     The semantics of expressions is described informally below.

     _K

          is a literal constant of a predefined type (see  TYPES,
          FUNCTIONS AND CONSTANTS above).

     _F "(" _E_0"," ..."," _E_n ")"

          denotes a call of the function _F on the  arguments  _E_0,
          ...,  _E_n.  The  arguments must be compatible (in number
          and types) with the  formal  parameters  given  in  the
          definition of _F (see FUNCTIONS below).

     _E_0 "of" _R_T

          specifies that expression _E_0 has type _R_T. This  mechan-
          ism  allows  to solve ambiguities that may be caused by
          function overloading (see FUNCTIONS below).

     _E_0 "->" "[" _O_0 ... _O_n [ "..." ] [ "where" _E_1 ] "]"

          is an  expression  of  type  bbbboooooooolllleeeeaaaannnn,  called  matching
          expression.  _E_0 must be of type llllaaaabbbbeeeellll or eeeeddddggggeeee. The con-
          struct between "[[[[" and "]]]]" is called an label  pattern:
          it  allows to match the content of the label denoted by
          _E_0 (if _E_0 is of type llllaaaabbbbeeeellll) or by llllaaaabbbbeeeellll (_E_0) (if _E_0  is
          of  type  eeeeddddggggeeee),  possibly extracting the values of its
          different fields. The optional construct "..."  matches
          a sequence of zero or more values of any type.

          For convenience, in the verification of LOTOS programs,
          the  first  offer  _O_0 (intended to match a gate) can be



(C) INRIA            Last change: 2019/05/29                   14






CADP MANUAL PAGES                                 XTL-LANG(LOCAL)



          simply written _G (i.e., without the "!!!!" sign).

          The variables contained in _O_0, ...,  _O_n  (if  any)  are
          visible in the optional expression _E_1, which must be of
          type bbbboooooooolllleeeeaaaannnn.

          The XTL compiler examines the labels present in the BCG
          graph  to  check if there exist labels that correspond,
          in the number of fields and types of their  fields,  to
          the  list  of  offers _O_0, ..., _O_n.  If no such label is
          found, then the compiler issues a warning message (this
          is a form of _v_a_c_u_i_t_y _c_h_e_c_k_i_n_g).

          The compiler also uses the types  of  field  labels  to
          resolve overloading ambiguities (if any) in offers. For
          instance, the offer 1111 in the label pattern "GGGG !!!!1111"  will
          be  considered  of  iiiinnnntttteeeeggggeeeerrrr  if only integer values are
          passed on gate GGGG in the BCG graph on which the XTL pro-
          gram is evaluated.

          A matching expression matches a label _G _v_1 ... _v_m  iff:
          m  =  n  if  "..."  is  absent, or m >= n otherwise; _O_0
          matches _G; _O_1, ...,  _O_n  match  _v_1,  ...,  _v_n;  _E_1,  if
          present,  evaluates to ttttrrrruuuueeee in the context of the vari-
          ables assigned in the  offers.  A  matching  expression
          evaluates  to  ttttrrrruuuueeee in case of successful matching of a
          label (in this case, all the variables contained in the
          offers have been initialized) and to ffffaaaallllsssseeee otherwise.

     "{" _E_0"," ..."," _E_n "}"

          denotes a value of type set defined  explicitly  (i.e.,
          by  enumerating  all its elements). The expressions _E_0,
          ..., _E_n must all be  of  type  ssssttttaaaatttteeeesssseeeetttt,  llllaaaabbbbeeeellllsssseeeetttt,  or
          eeeeddddggggeeeesssseeeetttt.

     "(" _E_0"," ..."," _E_n ")"

          denotes a value of  type  tuple,  containing  n  fields
          whose values are given by _E_0, ..., _E_n.

     "let" _D_0 "=" _E_0"," ..."," _D_n "=" _E_n "in"
         _E_n+_1
     "end_let"

          allows to declare and initialize variables.  The  types
          of  the  initialization expressions _E_0, ..., _E_n must be
          compatible with the types corresponding to the declara-
          tions  _D_0,  ..., _D_n. All the variables occurring in the
          declarations _D_i are initialized with the values of  _E_i,
          and  are  visible  in  the  expression _E_n+_1.  The "lllleeeetttt"
          expression also allows to extract the fields  of  tuple



(C) INRIA            Last change: 2019/05/29                   15






CADP MANUAL PAGES                                 XTL-LANG(LOCAL)



          values and to assign them to variables.

     "if" _E_0 "then" _E'_0
         "else_if" _E_1 "then" _E'_1
          ...
         "else_if" _E_n "then" _E'_n
         "else" _E'_n+_1
     "end_if"

          allows the conditional evaluation of  expressions.  The
          expressions  _E_0,  ...,  _E_n  must  be  of  type bbbboooooooolllleeeeaaaannnn,
          whereas _E'_0, ..., _E'_n+_1 must be of the same type (which
          is  also  the type of the "if" expression). The evalua-
          tion of an "if" expression  proceeds  as  follows:  the
          conditions  _E_i  are evaluated (for 1 <= i <= n) and the
          value of the "if" expression is equal to the  value  of
          the first _E'_i for which _E_i is true. If none of the con-
          ditions evaluates to true, the resulting value is given
          by  _E'_n+_1.   If  a condition _E_i is a matching operator,
          the variables assigned by  the  offers  inside  _E_i  are
          visible only in the corresponding expression _E'_i.

     "assert" _E_0"," ..."," _E_n "in"
         _E_n+_1
     "end_assert"

          allows to stop the execution of an  XTL  program  if  a
          given condition does not hold. The expressions _E_0, ...,
          _E_n must be of  type  bbbboooooooolllleeeeaaaannnn.  If  all  the  assertions
          evaluate  to ttttrrrruuuueeee, the value of the "assert" expression
          is equal to the value of _E_n+_1; otherwise, the execution
          of  the XTL program is interrupted and an error message
          is  displayed  on  the  POSIX  standard  output  stream
          (ssssttttddddoooouuuutttt).

     "use" _x_0"," ..."," _x_n "in"
         _E
     "end_use"

          uses the values of variables _x_0, ..., _x_n without chang-
          ing  their  value  and then evaluates the expression _E.
          The "use" expression allows to write  XTL  programs  in
          which  every variable defined is used, which avoids the
          warnings of the form "variable set but not used" issued
          during  compilation  of  the  C  code generated by XTL.
          Although the usage of the "use" expression is  harmless
          and  does  not  impact in any way the evaluation of XTL
          expressions, it should be employed only in  the  (rare)
          situations where it is really needed.






(C) INRIA            Last change: 2019/05/29                   16






CADP MANUAL PAGES                                 XTL-LANG(LOCAL)



     "for" [ _x_0 ":" _T_0 [ "among" _E_0 ]"," ...","
             _x_n ":" _T_n [ "among" _E_n ] ]
         [ "in" _D ]
         [ "while" _E'_1 ]
         [ "where" _E'_2 ]
         "apply" _O_P
         "from" _E'_3
         "to" _E'_4
     "end_for"

          allows the iterative  evaluation  of  expressions.  The
          _i_t_e_r_a_t_i_o_n  _v_a_r_i_a_b_l_e_s  _x_0, ..., _x_n range over the itera-
          tion domains _T_0 [ "among" _E_0 ], ..., _T_n [ "among" _E_n ],
          respectively.  The  expressions _E_i must be of type "sssseeeetttt
          ooooffff _T_i": thus, iterations over sets of  states,  labels,
          or  edges are allowed. There is an exception concerning
          integer  numbers  and  characters:  for  these   types,
          domains  of  the form "{" _E_1 "..."  _E_2 "}", meaning all
          the integers (resp. characters) between _E_1 and _E_2,  are
          also  allowed.  The  variables  declared  in the "in" _D
          declaration (if present) are called _a_c_c_u_m_u_l_a_t_o_r_s.  Both
          iteration variables and accumulators are visible in the
          expressions _E'_1, _E'_2 (if present), and _E'_4, but not  in
          _E'_3.   The  expressions  _E'_1  and  _E'_2  must be of type
          bbbboooooooolllleeeeaaaannnn.

          Assuming that all the optional constructs are  present,
          the  evaluation  of a "ffffoooorrrr" expression proceeds as fol-
          lows. The accumulators are initialized to the value  of
          _E'_3.  Let us note _v the current values of the accumula-
          tors (_v may be of type tuple). Then, for each value  of
          the iteration variables in their corresponding domains,
          the expression _v _O_P _E'_4 is evaluated and its result  is
          stored  in  the  accumulators.  The  value of the "ffffoooorrrr"
          expression is equal to the value  of  the  accumulators
          obtained  after  the last iteration. The "where" clause
          allows to perform only those iterations for  which  the
          expression  _E'_2  evaluates  to ttttrrrruuuueeee. The "while" clause
          allows to stop the iterations when the  expression  _E'_1
          becomes ffffaaaallllsssseeee.

          Particular cases of "ffffoooorrrr" expressions may  be  obtained
          by  eliminating  some  (or  all)  of  the optional con-
          structs. If the iteration  variables  are  absent,  the
          "ffffoooorrrr"  becomes  an  infinite  loop:  in  this case, the
          "wwwwhhhhiiiilllleeee" clause must be present in  order  to  stop  the
          evaluation.  If  the  "iiiinnnn"  declaration  is absent, the
          accumulator is implicit: it is used internally to store
          the  results  of intermediate iterations, but it cannot
          be used in _E'_1, _E'_2, nor _E'_4.

          The  "ffffoooorrrr"  expressions  are  useful   for   describing



(C) INRIA            Last change: 2019/05/29                   17






CADP MANUAL PAGES                                 XTL-LANG(LOCAL)



          iterative  computations.  For  instance, the expression
          below displays on the standard output the  sequence  of
          Fibonacci numbers smaller than 1000:

          for
              in    (xn_plus_1, xn: integer, a:action)
              while xn < 1000
              apply (replace, replace, fby)
              from  (1, 1, nop)
              to    (xn_plus_1 + xn, xn_plus_1,
                     print (xn) fby printf ("\n"))
          end_for


     "forall" _x_0 ":" _T_0 [ "among" _E_0 ]"," ...","
              _x_n ":" _T_n [ "among" _E_n ]
     "in"
         _E_n+_1
     "end_forall"

          is the universal quantifier. It is  equivalent  to  the
          following "ffffoooorrrr" expression:

          "for" _x_0 ":" _T_0 [ "among" _E_0 ]"," ...","
                _x_n ":" _T_n [ "among" _E_n ]
              "apply" and
              "from"  true
              "to"    _E_n+_1
          "end_for"

          The type of  _E_n+_1  may  be  either  bbbboooooooolllleeeeaaaannnn,  ssssttttaaaatttteeeesssseeeetttt,
          llllaaaabbbbeeeellllsssseeeetttt,  or  eeeeddddggggeeeesssseeeetttt.  In the three latter cases, the
          ttttrrrruuuueeee and aaaannnndddd operators correspond to full set  and  set
          intersection,  respectively  (see  TYPES, FUNCTIONS AND
          CONSTANTS above).

     "exists" _x_0 ":" _T_0 [ "among" _E_0 ]"," ...","
              _x_n ":" _T_n [ "among" _E_n ]
     "in"
         _E_n+_1
     "end_exists"

          is the existential quantifier. It is equivalent to  the
          following "ffffoooorrrr" expression:

          "for" _x_0 ":" _T_0 [ "among" _E_0 ]"," ...","
                _x_n ":" _T_n [ "among" _E_n ]
              "apply" or
              "from"  false
              "to"    _E_n+_1
          "end_for"




(C) INRIA            Last change: 2019/05/29                   18






CADP MANUAL PAGES                                 XTL-LANG(LOCAL)



          The type of  _E_n+_1  may  be  either  bbbboooooooolllleeeeaaaannnn,  ssssttttaaaatttteeeesssseeeetttt,
          llllaaaabbbbeeeellllsssseeeetttt,  or  eeeeddddggggeeeesssseeeetttt.  In the three latter cases, the
          ffffaaaallllsssseeee and oooorrrr operators correspond to empty set and  set
          union, respectively (see TYPES, FUNCTIONS AND CONSTANTS
          above).

     "<|" _O_P "on" _x_0 ":" _T_0 [ "among" _E_0 ]"," ...","
                  _x_n ":" _T_n [ "among" _E_n ]
          [ "where" _E' ]
     "|>" _E_n+_1

          is an abbreviated form of the "ffffoooorrrr" expression,  called
          _i_t_e_r_a_t_o_r.   It  is  equivalent  to  the following "ffffoooorrrr"
          expression:

          "for" _x_0 ":" _T_0 [ "among" _E_0 ]"," ...","
                _x_n ":" _T_n [ "among" _E_n ]
              [ "where" _E' ]
              "apply" _O_P
              "from"  _i_n_i_t__O_P
              "to"    _E_n+_1
          "end_for"

          Here _i_n_i_t__O_P is a "start" value associated  by  default
          to  the  operator _O_P. Only the binary predefined opera-
          tors that have initial values assigned by  default  can
          be  used  in  the iterators.  These operators, together
          with their initial values, are given in the table below
          (where  "_s_e_t"  denotes  either  ssssttttaaaatttteeeesssseeeetttt,  llllaaaabbbbeeeellllsssseeeetttt, or
          eeeeddddggggeeeesssseeeetttt).

          +-----------------------------------+---------------+
          |            Operator _O_P            |    _i_n_i_t__O_P    |
          +===================================+===============+
          | or  : boolean, boolean -> boolean | false         |
          | and : boolean, boolean -> boolean | true          |
          | + : integer, integer -> integer   | 0             |
          | * : integer, integer -> integer   | 1             |
          | union, or  : set, set -> set      | empty, false  |
          | inter, and : set, set -> set      | full, true    |
          | diff       : set, set -> set      | full          |
          | insert : set, elem -> set         | empty         |
          | remove : set, elem -> set         | full          |
          | fby : action, action -> action    | nop           |
          +-----------------------------------+---------------+

          The iterators allow to express  iterative  computations
          in a form close to the mathematical notation. For exam-
          ple, the sum of the integer numbers from 1 to  100  may
          be computed with the following iterator:

              <| + on K:integer among { 1 ... 100 } |> K



(C) INRIA            Last change: 2019/05/29                   19






CADP MANUAL PAGES                                 XTL-LANG(LOCAL)



          Similarly, the  number  of  transitions  labelled  with
          "SEND" labels may be computed as follows:

              <| + on T:edge where T -> [ SEND ... ] |> 1


     "{" _x ":" _T [ "among" _E_0 ] "where" _E_1 "}"

          is a set value defined by  specifying  a  predicate  _E_1
          characterizing  the elements of the set. This construct
          is also a particular case of "ffffoooorrrr" expression:

              "for" _x ":" _T [ "among" _E_0 ]
                  "where" _E_1
                  "apply" union
                  "from"  empty
                  "to"    "{" _x "}"
              "end_for"

          The implicitly defined sets allow to  compute  sets  of
          states,  labels  or  transitions in a form close to the
          mathematical notation. For example, the set of deadlock
          states  (i.e., states having no successors) can be com-
          puted by the XTL expression below:

              { S:state where succ (S) = empty }


  FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNNSSSS
     The XTL language allows to define  and  use  functions.  The
     syntax  of  function  definitions  is  given  by the grammar
     below:

     _F_D      ::=  "def" _F "(" _x_1 ":" _T_1"," ..."," _x_n ":" _T_n ")" ":" _R_T "="
                      [ _F_D_1 ... _F_D_m ]
                      _E
                      [ "where" _F_D_m+_1 ... _F_D_m+_p ]
                  "end_def"

              |   "def" "_" _F "_" "(" _x_1 ":" _T_1"," _x_2 ":" _T_2 ")" ":" _R_T "="
                      [ _F_D_1 ... _F_D_m ]
                      _E
                      [ "where" _F_D_m+_1 ... _F_D_m+_p ]
                  "end_def"

     The first construct above defines a function  _F  having  the
     parameters _x_1, ..., _x_n of types _T_1, ..., _T_n, the body _E, and
     returning a result of type _R_T. The calls of _F have the form:

             _F "(" _E_1"," ..."," _E_n ")"

     where the arguments _E_1,  ...,  _E_n  must  be  compatible  (in



(C) INRIA            Last change: 2019/05/29                   20






CADP MANUAL PAGES                                 XTL-LANG(LOCAL)



     number  and  types)  with the parameters of _F. The result of
     the call is equal to the value of _E computed in a context in
     which  the  parameters  _x_i are assigned the values of _E_i for
     all i between 1 and n.  The  body  of  _F  may  also  contain
     definitions  of  local functions, placed either before _E, or
     after _E and the keyword "wwwwhhhheeeerrrreeee".  These functions are  visi-
     ble  only  in  the  expression  _E.  Recursive  functions are
     allowed. Also, functions can be  overloaded:  several  func-
     tions  with  the  same  name, but different profiles, may be
     defined in the same scope.  In case of ambiguity of the type
     of  a function call, the "ooooffff" expression may be used to pre-
     cise a unique type (see EXPRESSIONS above).

     The second construct above defines a binary infixed function
     _F  having the parameters _x_1, _x_2 of types _T_1, _T_2, and return-
     ing a result of type _R_T. The  function  _F  behaves  like  an
     ordinary binary function, except that its calls may be writ-
     ten either in the form _F "(" _E_1"," _E_2 ")", or in the form _E_1
     _F  _E_2.  This  kind  of  functions allow to write expressions
     involving infixed operators using  a  syntax  close  to  the
     mathematical  notation. For example, the predefined function
     "++++" over integers is in fact an infixed operator:  the  user
     may  write  either + (1, 2), or 1 + 2. The infixed operators
     (both predefined and  user-defined)  are  right-associative:
     e.g., the expression 1 + 2 + 3 is parsed as 1 + (2 + 3).

     Functions can be, of course, recursive (either directly,  or
     transitively).   For  example,  the recursive function below
     computes the factorial of an integer number:

     def fact (n:integer) : integer =
         assert n >= 0 in
             if n = 0 then
                 1
             else
                 n * fact (n - 1)
             end_if
         end_assert
     end_def

     This function also checks whether its argument is greater or
     equal  to 0 using an "aaaasssssssseeeerrrrtttt" expression; if this is not the
     case, the program execution is aborted with  an  appropriate
     error message.











(C) INRIA            Last change: 2019/05/29                   21






CADP MANUAL PAGES                                 XTL-LANG(LOCAL)



  MMMMAAAACCCCRRRROOOOSSSS
     The XTL compiler allows to define and use macros. The syntax
     of macro-definitions is given by the following grammar:

     _M_D        ::=  "macro" _M "(" _P_1"," ..."," _P_n ")" "="
                      <text>
                    "end_macro"

     The above construct defines a macro _M having the  parameters
     _P_1,  ..., _P_n and the body <text>, which is a portion of text
     built using the characters allowed by the XTL language  (see
     LEXICAL ELEMENTS above). The calls of _M have the form:

             _M "(" <text1>"," ..."," <textn> ")"

     where the arguments <text1>, ..., <textn>  are  portions  of
     XTL  text. The result of the call is <text> in which all the
     occurrences of the parameters  _P_i  have  been  syntactically
     substituted  with the arguments <texti>, for all i between 1
     and n. The following syntactic restriction  must  be  satis-
     fied:  the  keywords contained in each <texti> argument must
     be well-bracketed, i.e., if <texti> contains a keyword open-
     ing an expression (e.g., "ffffoooorrrr"), then <texti> must also con-
     tain the corresponding keyword closing the expression (e.g.,
     "eeeennnndddd____ffffoooorrrr"). This also applies to the non-alphabetic keywords
     such as "((((", "))))", "[[[[", "]]]]", "{{{{", "}}}}".  A  macro  is  visible
     from  the  point  of its definition until the end of the XTL
     program. The macros may be overloaded: several  macros  with
     the  same name, but different arities, may be defined in the
     same scope.


  LLLLIIIIBBBBRRRRAAAARRRRIIIIEEEESSSS
     There is also possible to include in the text of an XTL pro-
     gram external libraries, typically containing definitions of
     temporal operators. The inclusion command has the  following
     syntax:

     _L_I        ::=  "library" <file0.xtl>"," ..."," <filen.xtl>
                    "end_library"

     At the compilation of the program, the  above  construct  is
     syntactically  replaced  with  the  contents  of  the  files
     <file0.xtl>, ..., <filen.xtl>, placed one after the other in
     this  order.  The  XTL  compiler searches the included files
     first in the current directory, then in the directory refer-
     enced  by  $$$$CCCCAAAADDDDPPPP////ssssrrrrcccc////xxxxttttllll.   Multiple  inclusions of the same
     file are silently discarded, unless the ----wwwwaaaarrrrnnnniiiinnnngggg  option  is
     passed  to  the compiler; in this case, appropriate messages
     are issued.





(C) INRIA            Last change: 2019/05/29                   22






CADP MANUAL PAGES                                 XTL-LANG(LOCAL)



  DDDDIIIIRRRREEEECCCCTTTTIIIIVVVVEEEESSSS
     The XTL compiler allows to declare and use in an XTL program
     data  types  and  functions implemented externally in C. The
     directive for an external type declaration has the following
     syntax:

     _E_T_D  ::::::::====  """"ttttyyyyppppeeee"""" _T
                     [[[[ """"!!!!"""" """"iiiimmmmpppplllleeeemmmmeeeennnntttteeeeddddbbbbyyyy"""" """"<<<<CCCC____ttttyyyyppppeeee>>>>"""" ]]]]
                     [[[[ """"!!!!"""" """"ccccoooommmmppppaaaarrrreeeeddddbbbbyyyy"""" """"<<<<CCCC____ccccoooommmmppppaaaarrrreeee>>>>"""" ]]]]
                     [[[[ """"!!!!"""" """"eeeennnnuuuummmmeeeerrrraaaatttteeeeddddbbbbyyyy"""" """"<<<<CCCC____iiiitttteeeerrrraaaatttteeee>>>>"""" ]]]]
                     [[[[ """"!!!!"""" """"pppprrrriiiinnnntttteeeeddddbbbbyyyy"""" """"<<<<CCCC____pppprrrriiiinnnntttt>>>>"""" ]]]]
               """"eeeennnndddd____ttttyyyyppppeeee""""

     where _T is the identifier  of  the  declared  type  and  the
     optional  pragmas preceded by "!" refer to the C implementa-
     tion of _T:  <C_type> is the identifier of the C type  imple-
     menting  _T;  <C_compare>  is  an  operator for comparing two
     values of type _T; <C_iterate> is a macro allowing to iterate
     over all values of type _T; and <C_print> is a printing func-
     tion for values of type _T.  The C names  declared  by  these
     pragmas  cannot be used directly in the XTL program, but are
     used in the C code generated by the XTL compiler.

     The directive for an external function declaration  has  the
     following syntax:

     _E_F_D  ::::::::====  """"ffffuuuunnnncccc"""" _F """"(((("""" _T_1"""",,,,"""" ............"""",,,,"""" _T_n """"))))"""" """"::::"""" _R_T
                     [[[[ """"!!!!"""" """"iiiimmmmpppplllleeeemmmmeeeennnntttteeeeddddbbbbyyyy"""" """"<<<<CCCC____ffffuuuunnnncccc>>>>"""" ]]]]
               """"eeeennnndddd____ffffuuuunnnncccc""""

     where _F is the identifier of the declared function, _T_1, ...,
     _T_n  are  the  types of its parameters, and _R_T is the type of
     its result. The optional pragma "implementedby" declares the
     name <C_func> of the C function implementing _F. This C iden-
     tifier cannot be used in the XTL program, but is used in the
     C code generated by the XTL compiler.

     The external types and functions declared using  the  direc-
     tives  above  may  be  implemented  in (one or more) C files
     file1.c, ..., filen.c that must be included in  the  C  code
     generated  by  the XTL compiler. This is done using the fol-
     lowing external include directive:

     _E_I_D  ::::::::====  """"iiiinnnncccclllluuuuddddeeee"""" """"<<<<ffffiiiilllleeee1111>>>>"""",,,, ............,,,, """"<<<<ffffiiiilllleeeennnn>>>>"""" """"eeeennnndddd____iiiinnnncccclllluuuuddddeeee""""

     where <file1>, ..., <filen> are the names of  the  C  source
     files  (".c" and/or ".h") that must be included. This direc-
     tive  is  translated  into  corresponding  "#include"   pre-
     processor  commands  in the C code generated by the XTL com-
     piler.

     The compilation and linkediting of the  C  modules  included



(C) INRIA            Last change: 2019/05/29                   23






CADP MANUAL PAGES                                 XTL-LANG(LOCAL)



     may  require  specific parameters. These can be indicated to
     the XTL compiler using the following external compile direc-
     tive:

     _E_L_D  ::::::::====  """"ffffllllaaaagggg"""" """"<<<<CCCC____ccccoooommmmppppiiiilllleeeerrrr____ddddiiiirrrreeeeccccttttiiiivvvveeeessss>>>>"""" """"eeeennnndddd____ffffllllaaaagggg""""

     where <C_compiler_directives> is a portion  of  command-line
     for  invoking  the C compiler (typically containing "-I", "-
     L", and "-l" options) that specifies the desired compilation
     parameters.  This portion of command-line is used by the XTL
     compiler when creating the binary file of  the  generated  C
     code.

     As an example, the XTL program below uses the CAESAR_ERROR()
     function for error handling, which is declared externally in
     the "caesar_standard.h" file and defined in the  OPEN/CAESAR
     library libcaesar.a. Upon execution, the program will output
     the error message and stop.

         iiiinnnncccclllluuuuddddeeee
           """"ccccaaaaeeeessssaaaarrrr____ssssttttaaaannnnddddaaaarrrrdddd....hhhh""""
         eeeennnndddd____iiiinnnncccclllluuuuddddeeee

         ffffllllaaaagggg
           """"----IIII////ccccoooommmmmmmmoooonnnn////CCCCaaaaddddpppp////iiiinnnnccccllll ----LLLL////ccccoooommmmmmmmoooonnnn////CCCCaaaaddddpppp////bbbbiiiinnnn....ssssuuuunnnn5555 ----llllccccaaaaeeeessssaaaarrrr""""
         eeeennnndddd____ffffllllaaaagggg

         ffffuuuunnnncccc eeeerrrrrrrroooorrrr ((((ssssttttrrrriiiinnnngggg)))) :::: aaaaccccttttiiiioooonnnn
           !!!! iiiimmmmpppplllleeeemmmmeeeennnntttteeeeddddbbbbyyyy """"CCCCAAAAEEEESSSSAAAARRRR____EEEERRRRRRRROOOORRRR""""
         eeeennnndddd____ffffuuuunnnncccc

         eeeerrrrrrrroooorrrr ((((""""HHHHeeeerrrreeee ooooccccccccuuuurrrrssss aaaa ffffaaaattttaaaallll eeeerrrrrrrroooorrrr.... FFFFaaaarrrreeeewwwweeeellllllll....""""))))


  PPPPRRRROOOOGGGGRRRRAAAAMMMM
     The syntax of an XTL program is given by the following gram-
     mar:

     _P_G  ::::::::====  [[[[ (((( _F_D_1 |||| _E_T_D_1 |||| _E_F_D_1 |||| _E_I_D_1 |||| _E_L_D_1 ))))
                ............
                (((( _F_D_m |||| _E_T_D_m |||| _E_F_D_m |||| _E_I_D_m |||| _E_L_D_m )))) ]]]]
              [[[[ _M_D_1 ............ _M_D_p ]]]]
              [[[[ _L_I_1 ............ _L_I_r ]]]]
                  _E
              [[[[ """"wwwwhhhheeeerrrreeee""""
                 [[[[ _M_D_p+_1 ............ _M_D_p+_q ]]]]
                 [[[[ _L_I_r+_1 ............ _L_I_r+_s ]]]]
                 (((( _F_D_m+_1 |||| _E_T_D_m+_1 |||| _E_F_D_m+_1 |||| _E_I_D_m+_1 |||| _E_L_D_m+_1 ))))
                 ............
                 (((( _F_D_m+_n |||| _E_T_D_m+_n |||| _E_F_D_m+_n |||| _E_I_D_m+_n |||| _E_L_D_m+_n )))) ]]]]

     The expression _E is the body of the program. There may  also



(C) INRIA            Last change: 2019/05/29                   24






CADP MANUAL PAGES                                 XTL-LANG(LOCAL)



     be lists of function definitions, external directives, macro
     definitions, and/or library inclusions, placed in the  front
     of the program or at its end, after the "wwwwhhhheeeerrrreeee" keyword. The
     functions defined by _F_D_1, ..., _F_D_m+_n are visible in the body
     _E of the program, as well as in all their bodies.


HHHHOOOOWWWW TTTTOOOO CCCCRRRREEEEAAAATTTTEEEE AAAA XXXXTTTTLLLL FFFFIIIILLLLEEEE
     At present, XTL files must be written by hand.


HHHHOOOOWWWW TTTTOOOO RRRREEEEAAAADDDD AAAA XXXXTTTTLLLL FFFFIIIILLLLEEEE
     At present, there is one single CADP tool, xxxxttttllll(LOCAL),  that
     reads and processes XTL files.


BBBBIIIIBBBBLLLLIIIIOOOOGGGGRRRRAAAAPPPPHHHHYYYY
     [MG98] R. Mateescu and H. Garavel.  XTL:  Meta-Language  and
     Tool for Temporal Logic Model-Checking.  Proc. of the Inter-
     national Workshop on Software Tools for Technology  Transfer
     STTT'98  (Aalborg, Denmark). BRICS Notes Series NS-98-4, pp.
     33-42,           1998.             Available            from
     http://cadp.inria.fr/publications/Mateescu-Garavel-98.html


     [GLMS13] H. Garavel, F. Lang, R.  Mateescu,  and  W.  Serwe.
     CADP  2011:  A  Toolbox for the Construction and Analysis of
     Distributed Processes.  Springer  International  Journal  on
     Software Tools for Technology Transfer (STTT), 15(2):89-107,
     2013.        http://cadp.inria.fr/publications/Garavel-Lang-
     Mateescu-Serwe-13.html


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







(C) INRIA            Last change: 2019/05/29                   25



