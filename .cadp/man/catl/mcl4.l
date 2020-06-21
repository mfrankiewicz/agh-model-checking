


CADP MANUAL PAGES                                     MCL4(LOCAL)



NNNNAAAAMMMMEEEE
     mcl, MCL - Model Checking Language version 4  (value-passing
     modal mu-calculus)


DDDDEEEESSSSCCCCRRRRIIIIPPPPTTTTIIIIOOOONNNN
     This manual page presents the version 4 of _M_C_L (_M_o_d_e_l _C_h_e_c_k_-
     _i_n_g _L_a_n_g_u_a_g_e), which is the temporal logic accepted as input
     by eeeevvvvaaaalllluuuuaaaattttoooorrrr4444(LOCAL).  In the remainder of this page,  "_M_C_L"
     denotes  version 4 of _M_C_L; see mmmmccccllll(LOCAL) for other versions
     of _M_C_L.


     A description of _M_C_L can be found in article  [MT08],  which
     also  describes  the verification method implemented in ver-
     sion 4.0 of EVALUATOR.


     The _M_C_L language  attempts  to  make  a  compromise  between
     expressiveness,  user-friendliness,  and efficiency of model
     checking for temporal  properties  involving  data.  _M_C_L  is
     based  on  the  alternation-free  fragment  of the modal mu-
     calculus [Koz83, EL86], to which  it  brings  two  kinds  of
     extensions:


     -    Action predicates  equipped  with  data  variables  and
          expressions,  modalities  containing  extended  regular
          expressions over action sequences, parameterized  fixed
          point  operators, and data-handling constructs inspired
          from the RICO temporal logic [Gar89] and from  program-
          ming languages.

     -    An infinite looping operator (of alternation depth  two
          [EL86]) similar to the one present in _P_D_L-_d_e_l_t_a (Propo-
          sitional Dynamic Logic  with  Looping)  [Str82],  which
          enables   the  expression  of  fairness  properties  by
          characterizing complex unfair cycles of transitions  in
          the LTS.

     An overview of the _M_C_L language  is  presented  below.   The
     abstract  syntax  of each language construct is defined by a
     BNF grammar and the semantics is described  informally.   In
     the  grammar,  terminal  symbols  are written between double
     quotes. Optional  constructs  are  enclosed  between  square
     brackets.  The axiom of the grammar is the _F symbol.

     The following convention is adopted for the lists of symbols
     occurring in the grammar rules: the index _n of the last sym-
     bol in the list is always greater or  equal  to  0,  meaning
     that  if  the index of the first symbol is 0 (e.g., _E_0, ...,
     _E_n), then the list must contain at least one symbol, and  if



(C) INRIA            Last change: 2018/05/25                    1






CADP MANUAL PAGES                                     MCL4(LOCAL)



     the index of the first symbol is 1 (e.g., _E_1, ..., _E_n), then
     the list may be empty.

     When referring to a certain construct of  the  grammar,  the
     term  "enclosing  formula"  denotes the (action, regular, or
     state) formula immediately surrounding that construct.

                       ++++--------------------------------++++------------------------------------------------------------------------------------------------++++
                       |||| SSSSyyyymmmmbbbboooollll ||||      DDDDeeeessssccccrrrriiiippppttttiiiioooonnnn       ||||
            ++++----------------------------------------++++--------------------------------++++------------------------------------------------------------------------------------------------++++
            ||||          ||||   _E    |||| eeeexxxxpppprrrreeeessssssssiiiioooonnnn             ||||
            ||||          ||||   _P    |||| ppppaaaatttttttteeeerrrrnnnn                ||||
            ||||          ||||   _O    |||| ooooffffffffeeeerrrr                  ||||
            |||| NNNNoooonnnn----     ||||   _A_P   |||| aaaaccccttttiiiioooonnnn ppppaaaatttttttteeeerrrrnnnn         ||||
            |||| tttteeeerrrrmmmmiiiinnnnaaaallll ||||   _A    |||| aaaaccccttttiiiioooonnnn ffffoooorrrrmmmmuuuullllaaaa         ||||
            ||||          ||||   _R    |||| rrrreeeegggguuuullllaaaarrrr ffffoooorrrrmmmmuuuullllaaaa        ||||
            ||||          ||||   _F    |||| ssssttttaaaatttteeee ffffoooorrrrmmmmuuuullllaaaa          ||||
            ++++----------------------------------------++++--------------------------------++++------------------------------------------------------------------------------------------------++++
            ||||          ||||   _K    |||| ccccoooonnnnssssttttaaaannnntttt               ||||
            ||||          ||||   _X    |||| ddddaaaattttaaaa vvvvaaaarrrriiiiaaaabbbblllleeee          ||||
            |||| TTTTeeeerrrrmmmmiiiinnnnaaaallll ||||   _Y    |||| pppprrrrooooppppoooossssiiiittttiiiioooonnnnaaaallll vvvvaaaarrrriiiiaaaabbbblllleeee ||||
            ||||          ||||   _H    |||| ffffuuuunnnnccccttttiiiioooonnnn oooorrrr ooooppppeeeerrrraaaattttoooorrrr   ||||
            ||||          ||||   _T    |||| ttttyyyyppppeeee                   ||||
            ++++----------------------------------------++++--------------------------------++++------------------------------------------------------------------------------------------------++++

     The formulas _A, _R, _F are interpreted over an LTS <_S,  _A,  _T,
     _s_0>, where:  _S is the set of _s_t_a_t_e_s, _A is the set of _a_c_t_i_o_n_s
     (transition labels), _T is the _t_r_a_n_s_i_t_i_o_n _r_e_l_a_t_i_o_n (a  subset
     of  _S  *  _A * _S), and _s_0 is the _i_n_i_t_i_a_l _s_t_a_t_e.  A transition
     (_s_1, _a, _s_2) of _T, also written _s_1-_a->_s_2, indicates that  the
     system  can  move  from  state  _s_1 to state _s_2 by performing
     action _a.  An action _a has the following structure:

         _G _v_1 ............ _v_n

     where _G is the name of a gate  (communication  channel)  and
     _v_1,  ...,  _v_n are the values exchanged on _G when the rendez-
     vous underlying action _a was  executed.  In  the  case  that
     there  are  no values exchanged, the action is simply a gate
     name.  There is an invisible action (named _i  in  LOTOS  and
     _t_a_u in other process algebras).

     Note: Actions are also  represented  as  character  strings,
     which  is  useful  for  expressing certain action predicates
     (see ACTION FORMULAS below).  The character string represen-
     tation of actions depends on the language from which the LTS
     _s_p_e_c is generated. For example, if the input is given  as  a
     LOTOS  program  _s_p_e_c[....lllloooottttoooossss], an action having the structure
     shown above will be represented as the character  string  "_G
     !_v_1 ... !_v_n".





(C) INRIA            Last change: 2018/05/25                    2






CADP MANUAL PAGES                                     MCL4(LOCAL)



LLLLEEEEXXXXIIIICCCCAAAALLLL EEEELLLLEEEEMMMMEEEENNNNTTTTSSSS
     Identifiers are built from letters, digits, and  underscores
     (beginning  with  a  letter or an underscore). eeeevvvvaaaalllluuuuaaaattttoooorrrr4444 is
     case-sensitive, except for  the  identifiers  of  predefined
     types  and  functions  (see  TYPES,  FUNCTIONS AND CONSTANTS
     below). Keywords must be written in lowercase.  Comments are
     enclosed  between  '((((****'  and  '****))))'.  Nested comments are not
     allowed. The keywords of _M_C_L are listed below.

                  aaaammmmoooonnnngggg      eeeeqqqquuuu       iiiinnnn     rrrreeeeppppeeeeaaaatttt
                  aaaannnndddd        eeeexxxxiiiissssttttssss    lllleeeetttt    sssstttteeeepppp
                  aaaannnnyyyy        eeeexxxxiiiitttt      lllloooooooopppp   ttttaaaauuuu
                  ccccaaaasssseeee       eeeexxxxppppoooorrrrtttt    mmmmuuuu     tttthhhheeeennnn
                  cccchhhhooooiiiicccceeee     ffffaaaallllsssseeee     nnnniiiillll    ttttoooo
                  ccccoooonnnnttttiiiinnnnuuuueeee   ffffoooorrrr       nnnnooootttt    ttttrrrruuuueeee
                  ddddoooo         ffffoooorrrraaaallllllll    nnnnuuuu     uuuunnnnttttiiiillll
                  eeeellllsssseeee       ffffrrrroooommmm      ooooffff     wwwwhhhheeeerrrreeee
                  eeeellllssssiiiiffff      iiiiffff        oooonnnn     wwwwhhhhiiiilllleeee
                  eeeennnndddd        iiiimmmmpppplllliiiieeeessss   oooorrrr     xxxxoooorrrr


TTTTYYYYPPPPEEEESSSS,,,, FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNNSSSS AAAANNNNDDDD CCCCOOOONNNNSSSSTTTTAAAANNNNTTTTSSSS
     _M_C_L is a strongly-typed language: every variable used in  an
     _M_C_L  formula  must  have  a unique type, which is statically
     determined. In its current version, the  language  does  not
     provide  a  mechanism  for  type or function definition. _M_C_L
     predefines  the  usual  types  encountered  in   programming
     languages  (bbbboooooooollll,  nnnnaaaatttt,  nnnnaaaattttsssseeeetttt,  iiiinnnntttt,  rrrreeeeaaaallll, cccchhhhaaaarrrr, ssssttttrrrriiiinnnngggg),
     equipped with the standard functions  and  operators  listed
     below.

     +--------------------------------+--------------------------+
     |                Operator        |         Meaning          |
     +--------------------------------+--------------------------+
     | false, true : -> bool          | boolean constants        |
     | not : bool -> bool             | negation                 |
     | or, and, implies, equ, xor :   | binary boolean operators |
     |     bool, bool -> bool         |                          |
     | <, <=, >, >=, =, <> :          | comparison operators     |
     |     bool, bool -> bool         |                          |
     +--------------------------------+--------------------------+
     | succ : nat -> nat              | successor                |
     | - : nat -> int                 | unary minus              |
     | +, - : nat, nat -> nat         | addition, subtraction    |
     | *, / : nat, nat -> nat         | multiplication, division |
     | % : nat, nat -> nat            | modulo                   |
     | ^ : nat, nat -> nat            | power                    |
     | string : nat -> string         | convert to string        |
     | <, <=, >, >=, =, <> :          | comparison operators     |
     |     nat, nat -> bool           |                          |
     +--------------------------------+--------------------------+
     | empty : -> natset              | empty set                |



(C) INRIA            Last change: 2018/05/25                    3






CADP MANUAL PAGES                                     MCL4(LOCAL)



     | insert : nat, natset -> natset | element insertion        |
     | remove : nat, natset -> natset | element deletion         |
     | isin : nat, natset -> bool     | membership               |
     | union, inter, diff :           | binary set operators     |
     |     natset, natset -> natset   |                          |
     | <, <=, >, >=, =, <> :          | comparison operators     |
     |     natset, natset -> bool     |                          |
     +--------------------------------+--------------------------+
     | succ : int -> int              | successor                |
     | abs : int -> nat               | absolute value           |
     | sign : int -> int              | returns -1, 0, 1 if arg. |
     |                                |     is < 0, = 0, > 0     |
     | - : int -> int                 | unary minus              |
     | +, - : int, int -> int         | addition, subtraction    |
     | *, / : int, int -> int         | multiplication, division |
     | % : int, int -> int            | modulo                   |
     | ^ : int, nat -> int            | power                    |
     | string : int -> string         | convert to string        |
     | <, <=, >, >=, =, <> :          | comparison operators     |
     |     int, int -> bool           |                          |
     +--------------------------------+--------------------------+
     | - : real -> real               | unary minus              |
     | +, - : real, real -> real      | addition, subtraction    |
     | *, / : real, real -> real      | multiplication, division |
     | ^ : real, real -> real         | power                    |
     | string : real -> string        | convert to string        |
     | <, <=, >, >=, =, <> :          | comparison operators     |
     |     real, real -> bool         |                          |
     +--------------------------------+--------------------------+
     | tolower, toupper :             | convert letter to lower- |
     |     char -> char               |     or upper-case        |
     | islower, isupper :             | test if lower- or upper- |
     |     char -> bool               |     case letter          |
     | isalpha, isdigit, isalnum :    | test if letter, digit,   |
     |     char -> bool               |     letter or digit      |
     | isxdigit :                     | test if hexadecimal      |
     |     char -> bool               |     digit                |
     | string : char -> string        | convert to string        |
     | <, <=, >, >=, =, <> :          | comparison operators     |
     |     char, char -> bool         |                          |
     +--------------------------------+--------------------------+
     | length : string -> nat         | length (number of chars) |
     | empty : string -> bool         | test if empty string     |
     | concat :                       | concatenation            |
     |     string, string -> string   |                          |
     | index, rindex :                | index of the first/last  |
     |     string, string -> nat      |     occurrence of the    |
     |                                |     2nd arg. in the 1st  |
     | prefix, suffix :               | prefix/suffix of given   |
     |     string, nat -> string      |     length               |
     | nth : string, nat -> char      | nth character            |
     | substr :                       | substring starting at an |



(C) INRIA            Last change: 2018/05/25                    4






CADP MANUAL PAGES                                     MCL4(LOCAL)



     |     string, nat, nat -> string |     index and having a   |
     |                                |     given length         |
     | <, <=, >, >=, =, <> :          | comparison operators     |
     |     string, string -> bool     |                          |
     +--------------------------------+--------------------------+

     The numerical, character, and string constants have a C-like
     syntax  (e.g.,  11113333,  ----1111,  1111....666611118888,  ''''aaaa'''',  ''''\\\\000000007777'''', ''''\\\\nnnn'''', """"hhhheeeelllllllloooo
     wwwwoooorrrrlllldddd\\\\nnnn""""). In order  to  allow  implicit  type  conversions,
     numerical constants are overloaded as follows: a constant of
     type nnnnaaaatttt can also be of type iiiinnnntttt or rrrreeeeaaaallll, and a constant  of
     type iiiinnnntttt can also be of type rrrreeeeaaaallll.

     The names of the operators of type  bbbboooooooollll  (constants,  nega-
     tion,  and binary operators) that coincide with the keywords
     operating on formulas must be written in lowercase.

     The binary boolean  operators,  binary  set  and  membership
     operators,  the arithmetic operators (of types nnnnaaaatttt, iiiinnnntttt, and
     rrrreeeeaaaallll), and all  comparison  operators  must  be  written  in
     infixed form (e.g., 1111 ++++ 2222,  XXXX iiiinnnntttteeeerrrr YYYY, 1111....0000 <<<< 2222....0000, etc.). All
     the other operators must be written in prefixed form  (e.g.,
     iiiinnnnsssseeeerrrrtttt ((((0000,,,, eeeemmmmppppttttyyyy)))), ccccoooonnnnccccaaaatttt ((((""""aaaa"""",,,, """"bbbb"""")))), etc.).

     The operands of the binary operators  of  type  bbbboooooooollll  ("oooorrrr",
     "aaaannnndddd",  "iiiimmmmpppplllliiiieeeessss",  "eeeeqqqquuuu", "xxxxoooorrrr") are evaluated from left to
     right in  a  lazy  way,  i.e.,  the  right  operand  is  not
     evaluated if the value of the left operand can determine the
     value of the whole expression.

     All the binary operators of the predefined types shown above
     are  left-associative. Unary operators have the highest pre-
     cedence, followed by binary operators. In the  current  ver-
     sion  of  the tool all binary operators are considered to be
     of equal precedence; parentheses must be used for imposing a
     desired parsing/evaluation order.


EEEEXXXXPPPPRRRREEEESSSSSSSSIIIIOOOONNNNSSSS
     The syntax of _M_C_L expressions is defined  by  the  following
     grammar:

     _E       ::::::::====  _K

              ||||   _X

              ||||   _H _E

              ||||   _E_1 _H _E_2

              ||||   _H """"(((("""" _E_1"""",,,,"""" ............"""",,,,"""" _E_n """"))))""""




(C) INRIA            Last change: 2018/05/25                    5






CADP MANUAL PAGES                                     MCL4(LOCAL)



              ||||   _E """"ooooffff"""" _T

              ||||   """"(((("""" _E """"))))""""

     The semantics of _M_C_L  expressions  is  described  informally
     below.   The  evaluation  of  an  expression  _E in a context
     assigning values to all data variables occurring in _E yields
     a unique value.

     _K

          is a literal constant of a predefined type (see  TYPES,
          FUNCTIONS AND CONSTANTS above).

     _X

          is a data variable (see DECLARATIONS below).

     _H _E

          denotes a call of the unary prefixed operator _H on  the
          argument  _E.   The argument must be of the same type as
          the formal parameter of _H.

     _E_1 _H _E_2

          denotes a call of the binary infixed operator _H on  the
          arguments  _E_1 and _E_2. The arguments must be of the same
          types as the corresponding formal parameters of _H.

     _H "(" _E_1"," ..."," _E_n ")"

          denotes a call of the function _F on the  arguments  _E_1,
          ...,  _E_n.   The arguments must be compatible (in number
          and type) with the formal parameters of _H.

     _E "of" _T

          specifies that expression _E has type _T. This  mechanism
          makes  it  possible  to  solve  ambiguities that may be
          caused by the overloading of  operators  and  constants
          (see TYPES, FUNCTIONS AND CONSTANTS above).

     "(" _E ")"

          has the same meaning as the expression  _E.  Parentheses
          are  useful  for imposing an evaluation order of subex-
          pressions different from the order given by the associ-
          ativity  and  precedence of operators. For example, xxxx ++++
          ((((yyyy //// 2222)))) is different from xxxx ++++ yyyy //// 2222, which is evaluated
          by  default  as  ((((xxxx ++++ yyyy)))) //// 2222 since all binary operators
          have the same precedence.



(C) INRIA            Last change: 2018/05/25                    6






CADP MANUAL PAGES                                     MCL4(LOCAL)



DDDDEEEECCCCLLLLAAAARRRRAAAATTTTIIIIOOOONNNNSSSS
     Similarly to classical functional programming languages, _M_C_L
     provides  mechanisms  for  declaring  and  initializing data
     variables.  Declarations (without initialization)  have  the
     following general form:

         _x_0_1 """",,,,"""" ............ """",,,,"""" _x_0_m_0 """"::::"""" _T_0
         """",,,,"""" ............ """",,,,""""
         _x_n_1 """",,,,"""" ............ """",,,,"""" _x_n_m_n """"::::"""" _T_n

     which declares the data variables _x_i_1, ..., _x_i_m_i of type  _T_i
     for  each  0  <= _i <= _n. This general form of declaration is
     equivalent to the simplified form below, which will be  used
     in the remainder of this manual page:

         _x_0_1 """"::::"""" _T_0 """",,,,"""" ............ """",,,,"""" _x_0_m_0 """"::::"""" _T_0
         """",,,,"""" ............ """",,,,""""
         _x_n_1 """"::::"""" _T_n """",,,,"""" ............ """",,,,"""" _x_n_m_n """"::::"""" _T_n

     In the same way, declarations with initialization  have  the
     following general form:

         _x_0_1 """",,,,"""" ............ """",,,,"""" _x_0_m_0 """"::::"""" _T_0 """"::::===="""" _E_0
         """",,,,"""" ............ """",,,,""""
         _x_n_1 """",,,,"""" ............ """",,,,"""" _x_n_m_n """"::::"""" _T_n """"::::===="""" _E_n

     which declares the data variables _x_i_1, ..., _x_i_m_i of type  _T_i
     and initializes them with the value of the expression _E_i for
     each 0 <= _i <= _n. This general form of declaration with ini-
     tialization  is  equivalent  to  the  simplified form below,
     which will be used in the remainder of this manual page:

         _x_0_1 """"::::"""" _T_0 """"::::===="""" _E_0 """",,,,"""" ............ """",,,,"""" _x_0_m_0 """"::::"""" _T_0 """"::::===="""" _E_0
         """",,,,"""" ............ """",,,,""""
         _x_n_1 """"::::"""" _T_n """"::::===="""" _E_n """",,,,"""" ............ """",,,,"""" _x_n_m_n """"::::"""" _T_n """"::::===="""" _E_n


PPPPAAAATTTTTTTTEEEERRRRNNNNSSSS
     _M_C_L allows the manipulation of data values by matching  them
     against  patterns  and  storing  them in data variables. The
     syntax of _M_C_L patterns is defined by the following grammar:

     _P       ::::::::====  """"aaaannnnyyyy""""

              ||||   _K

              ||||   _X """"::::"""" _T

              ||||   _P """"ooooffff"""" _T

              ||||   _P_1 """"||||"""" _P_2




(C) INRIA            Last change: 2018/05/25                    7






CADP MANUAL PAGES                                     MCL4(LOCAL)



     The semantics of _M_C_L patterns is described informally below.

     "any"

          is the "wildcard" pattern, which matches any  value  of
          any type.

     _K

          is the constant pattern, which matches a value  identi-
          cal to _K.

     _X ":" _T

          matches any value of type _T and stores it  in  variable
          _X,  which  is  exported  to (i.e., made visible in) the
          enclosing formula.

     _P "of" _T

          removes ambiguities (caused, e.g., by overloaded  func-
          tions)  by  imposing  that  a value can be matched by _P
          only if it is of type _T.

     _P_1 "|" _P_2

          matches a value if either _P_1 or  _P_2  matches  it.   The
          patterns  _P_1  and  _P_2  must declare the same data vari-
          ables, all of which are exported to the enclosing  for-
          mula.


OOOOFFFFFFFFEEEERRRRSSSS
     Expressions and patterns can be used in offers, which enable
     one  to  match  a  given  value  against an expression or to
     extract and store it in  a  variable.   The  syntax  of  _M_C_L
     offers is defined by the following grammar:

     _O       ::::::::====  """"????"""" _P

              ||||   """"!!!!"""" _E

     The semantics of _M_C_L offers is described informally below.

     "?" _P

          is a pattern offer, which matches a value iff the  pat-
          tern  _P matches that value. All variables declared in _P
          are exported to the enclosing formula.

     "!" _E




(C) INRIA            Last change: 2018/05/25                    8






CADP MANUAL PAGES                                     MCL4(LOCAL)



          is an expression offer, which matches a value  iff  the
          evaluation of the expression _E yields that value, which
          also means that _E and that value must be  of  the  same
          type.

          Note: Pattern and expression offers involving constants
          have  the  same semantics, e.g., ???? 3333....1111444411116666 is equivalent
          to !!!! 3333....1111444411116666.


AAAACCCCTTTTIIIIOOOONNNN PPPPAAAATTTTTTTTEEEERRRRNNNNSSSS
     An action pattern _A_P specifies that a certain action  (tran-
     sition  label) of the LTS matches a list of offers. The syn-
     tax of _M_C_L action patterns is defined by the following gram-
     mar:

     _A_P      ::::::::====  """"{{{{"""" _O_0 ............ _O_n [[[[ """"wwwwhhhheeeerrrreeee"""" _E ]]]] """"}}}}""""

              ||||   """"{{{{"""" _O_1 ............ _O_n """"............"""" _O'_1 ............ _O'_m [[[[ """"wwwwhhhheeeerrrreeee"""" _E ]]]] """"}}}}""""

     Action patterns inspect the structure of actions  _G  _v_1  ...
     _v_n  by  matching  values  _v_i  against  expression  offers or
     extracting them using pattern offers.  The  optional  clause
     "wwwwhhhheeeerrrreeee"  defines  a boolean expression _E (a guard) that must
     evaluate to true for the action pattern to match the action.
     All  variables  declared  by the offers of an action pattern
     are visible in  the  guard  _E  (if  present)  and  are  also
     exported to the enclosing formula.

     The gate name _G can be matched by  the  first  offer  of  an
     action pattern in three different ways:

     -    As a character string  constant,  using  an  expression
          offer (e.g., !!!!""""SSSSeeeennnndddd"""");

     -    As a  gate  identifier,  using  a  particular  form  of
          expression  offer  without  the  "!!!!" mark (e.g., SSSSeeeennnndddd).
          This form of matching can be applied only when the gate
          name  has  a  syntax  compatible with the syntax of _M_C_L
          identifiers;

     -    As a character string  value,  using  a  pattern  offer
          (e.g., ????ggggaaaatttteeee::::ssssttttrrrriiiinnnngggg).

     The semantics of _M_C_L action patterns is described informally
     below.

     "{" _O_0 ... _O_m [ "where" _E ] "}"

          matches an action _G _v_1 ... _v_n iff _m = _n, the  offer  _O_0
          matches  _G,  each  offer  _O_i (for _i = 1.._n) matches its
          corresponding  value  _v_i,  and  the  expression  _E  (if



(C) INRIA            Last change: 2018/05/25                    9






CADP MANUAL PAGES                                     MCL4(LOCAL)



          present)  evaluates  to  true in a context in which all
          variables declared  in  the  offers  _O_0,  ...,  _O_m  are
          replaced with the corresponding values.

          This is the basic action pattern, in which  all  values
          present in the action are explicitly matched by offers.
          The matching of the gate name _G by the offer _O_0 can  be
          done in one of the three ways indicated above.

          The simplest action pattern of this form consists of  a
          gate  name (e.g., {{{{ SSSSeeeennnndddd }}}}). For conciseness, the curly
          braces can be omitted in this case: one can write  sim-
          ply SSSSeeeennnndddd in order to match an action consisting only of
          a gate name SSSSeeeennnndddd.

     "{" _O_1 ... _O_m "..." _O'_1 ... _O'_p [ "where" _E ] "}"

          matches an action _G _v_1 ... _v_n iff _m+_p <= _n,  the  offer
          _O_1  (if  present, i.e., if _m > 0) matches _G, each offer
          _O_i (for _i = 1.._m) matches its corresponding  value  _v_i,
          each offer _O'_j (for _j = 1.._p) matches its corresponding
          value _v_n-(_p-_j),  and  the  expression  _E  (if  present)
          evaluates  to  true in a context in which all variables
          declared in the offers _O_1, ..., _O_m, _O'_1, ...,  _O'_p  are
          replaced with the corresponding values.

          This is a form of action pattern that enables  matching
          only  the first _m and the last _p values contained in an
          action, and skipping the other values (if any)  in  the
          middle. The matching of the gate name _G by the offer _O_1
          can be done in one of the three ways  indicated  above.
          Either  one, or both groups of offers _O_1 ... _O_m and _O'_1
          ... _O'_p can be absent (i.e., _m = 0 or/and _p = 0).   The
          simplest  action  pattern of this form (which is always
          matched by any action) is {{{{ ............ }}}}.


AAAACCCCTTTTIIIIOOOONNNN FFFFOOOORRRRMMMMUUUULLLLAAAASSSS
     An _a_c_t_i_o_n _f_o_r_m_u_l_a is a logical  formula  built  from  action
     predicates (which can be action patterns, character strings,
     regular expressions over character strings,  and  the  "ttttaaaauuuu"
     constant  operator) and boolean operators. The syntax of _M_C_L
     action formulas is defined by the following grammar:

     _A       ::::::::====  _A_P

              ||||   _a_c_t_i_o_n__s_t_r_i_n_g

              ||||   _a_c_t_i_o_n__r_e_g_e_x_p

              ||||   """"ttttaaaauuuu""""




(C) INRIA            Last change: 2018/05/25                   10






CADP MANUAL PAGES                                     MCL4(LOCAL)



              ||||   """"ttttrrrruuuueeee""""

              ||||   """"ffffaaaallllsssseeee""""

              ||||   """"nnnnooootttt"""" _A

              ||||   _A_1 """"oooorrrr"""" _A_2

              ||||   _A_1 """"xxxxoooorrrr"""" _A_2

              ||||   _A_1 """"aaaannnndddd"""" _A_2

              ||||   _A_1 """"iiiimmmmpppplllliiiieeeessss"""" _A_2

              ||||   _A_1 """"eeeeqqqquuuu"""" _A_2

              ||||   """"(((("""" _A """"))))""""

     Syntactically, all binary operators on action  formulas  are
     left-associative.  The  "nnnnooootttt"  operator has the highest pre-
     cedence, followed by "aaaannnndddd", followed by "oooorrrr" and "xxxxoooorrrr", fol-
     lowed by "iiiimmmmpppplllliiiieeeessss", followed by "eeeeqqqquuuu".

     An action formula defines a predicate over  the  actions  of
     the  LTS.  The semantics of _M_C_L action formulas is described
     informally below.

     _A_P

          an action (transition label) of the  LTS  satisfies  an
          action  pattern _A_P if the content of the action matches
          the pattern. In this case, all  variables  declared  by
          the offers of _A_P are initialized with the corresponding
          values extracted from the action and are also  exported
          to the enclosing formula.

     _a_c_t_i_o_n__s_t_r_i_n_g

          an _a_c_t_i_o_n__s_t_r_i_n_g is a sequence of 0 or more characters,
          enclosed  between double quotes ('""""'), which denotes an
          action of the LTS.  A string may contain any  character
          but   '\\\\nnnn'   (end-of-line).   Double  quotes  are  also
          allowed, if preceded by a backslash ('\\\\').  Strings can
          be concatenated using the binary operator '####' according
          to the grammar below:

          _a_c_t_i_o_n__s_t_r_i_n_g ::::::::==== """"((((_a_n_y _c_h_a_r _b_u_t _e_n_d-_o_f-_l_i_n_e))))****""""

                  |   _a_c_t_i_o_n__s_t_r_i_n_g_1 "#" _a_c_t_i_o_n__s_t_r_i_n_g_2

          An action of the LTS satisfies an _a_c_t_i_o_n__s_t_r_i_n_g iff its
          string representation is identical to the corresponding



(C) INRIA            Last change: 2018/05/25                   11






CADP MANUAL PAGES                                     MCL4(LOCAL)



          character string (obtained after concatenation whenever
          needed).

     _a_c_t_i_o_n__r_e_g_e_x_p

          an _a_c_t_i_o_n__r_e_g_e_x_p is a UNIX regular expression (see  the
          rrrreeeeggggeeeexxxxpppp(LOCAL) manual page for a detailed description of
          UNIX  regular  expressions),  enclosed  between  single
          quotes  (''''''), which denotes a predicate on the actions
          of the LTS.  Regexps  can  be  concatenated  using  the
          binary  operator  '####'  according  to the grammar below.
          Strings can be concatenated to regexps, in  which  case
          they are implicitly converted into regexps.

          _a_c_t_i_o_n__r_e_g_e_x_p ::::::::==== ''''_U_N_I_X__r_e_g_u_l_a_r__e_x_p_r_e_s_s_i_o_n''''

                  |   _a_c_t_i_o_n__r_e_g_e_x_p_1 "#" _a_c_t_i_o_n__r_e_g_e_x_p_2

                  |   _a_c_t_i_o_n__s_t_r_i_n_g_1 "#" _a_c_t_i_o_n__r_e_g_e_x_p_2

                  |   _a_c_t_i_o_n__r_e_g_e_x_p_1 "#" _a_c_t_i_o_n__s_t_r_i_n_g_2

          An action of the LTS satisfies an _a_c_t_i_o_n__r_e_g_e_x_p iff its
          string   representation   matches   the   corresponding
          _U_N_I_X__r_e_g_u_l_a_r__e_x_p_r_e_s_s_i_o_n (obtained  after  concatenation
          whenever needed).

     "tau"

          an action of the LTS satisfies this action formula  iff
          it is the invisible action.

     "true"

          an action of the LTS always satisfies this formula.

     "false"

          an action of the LTS never satisfies this formula.

     "not" _A

          an action of the LTS satisfies this formula iff it does
          not satisfy _A.

     _A_1 "or" _A_2

          an action of the LTS  satisfies  this  formula  iff  it
          satisfies _A_1 or it satisfies _A_2.

     _A_1 "xor" _A_2




(C) INRIA            Last change: 2018/05/25                   12






CADP MANUAL PAGES                                     MCL4(LOCAL)



          an action of the LTS  satisfies  this  formula  iff  it
          satisfies exactly one of _A_1 and _A_2.

     _A_1 "and" _A_2

          an action of the LTS  satisfies  this  formula  iff  it
          satisfies both _A_1 and _A_2.

     _A_1 "implies" _A_2

          an action of the LTS satisfies this formula iff it does
          not satisfy _A_1 or it satisfies _A_2.

     _A_1 "equ" _A_2

          an action of the LTS satisfies this formula iff  either
          it satisfies both _A_1 and _A_2, or neither of them.

     "(" _A ")"

          an action of the LTS  satisfies  this  formula  iff  it
          satisfies  _A.   Parentheses  are useful for imposing an
          evaluation order  of  subformulas  different  from  the
          order  given  by  the  associativity  and precedence of
          operators.

     If an action pattern _A_P occurs as  operand  of  a  unary  or
     binary boolean operator, none of the data variables declared
     by the pattern offers of _A_P is  exported  to  the  enclosing
     formula (e.g., action formula nnnnooootttt {{{{ SSSSeeeennnndddd ????mmmmssssgggg::::nnnnaaaatttt }}}} does not
     export variable _m_s_g to  the  enclosing  formula).  In  other
     words,  only  the  action formulas consisting of action pat-
     terns can export data variables  to  the  enclosing  formula
     (see also REGULAR FORMULAS and the description of modalities
     in STATE FORMULAS below).


RRRREEEEGGGGUUUULLLLAAAARRRR FFFFOOOORRRRMMMMUUUULLLLAAAASSSS
     A _r_e_g_u_l_a_r _f_o_r_m_u_l_a is a logical  formula  built  from  action
     formulas, traditional and extended regular expression opera-
     tors, and data-handling constructs inspired from  functional
     programming  languages.   The syntax of _M_C_L regular formulas
     is defined by the following grammar:

     _R       ::::::::====  _A

              ||||   """"nnnniiiillll""""

              ||||   _R_1 """"...."""" _R_2

              ||||   _R_1 """"||||"""" _R_2




(C) INRIA            Last change: 2018/05/25                   13






CADP MANUAL PAGES                                     MCL4(LOCAL)



              ||||   _R """"****""""

              ||||   _R """"++++""""

              ||||   _R """"????""""

              ||||   _R """"{{{{"""" _E """"}}}}""""

              ||||   _R """"{{{{"""" _E """"............"""" """"}}}}""""

              ||||   _R """"{{{{"""" _E """",,,,"""" """"}}}}""""

              ||||   _R """"{{{{"""" _E_1 """"............"""" _E_2 """"}}}}""""

              ||||   _R """"{{{{"""" _E_1 """",,,,"""" _E_2 """"}}}}""""

              ||||   """"lllleeeetttt"""" _X_0 """"::::"""" _T_0 """"::::===="""" _E_0 """",,,,"""" ............ """",,,,"""" _X_n """"::::"""" _T_n """"::::===="""" _E_n """"iiiinnnn""""
                      _R
                  """"eeeennnndddd"""" """"lllleeeetttt""""

              ||||   """"iiiiffff"""" _F_0 """"tttthhhheeeennnn""""
                      _R_0
                  [[[[ """"eeeellllssssiiiiffff"""" _F_1 """"tttthhhheeeennnn""""
                      _R_1
                    ............
                    """"eeeellllssssiiiiffff"""" _F_n """"tttthhhheeeennnn""""
                      _R_n
                    """"eeeellllsssseeee""""
                      _R_n+_1 ]]]]
                  """"eeeennnndddd"""" """"iiiiffff""""

              ||||   """"ccccaaaasssseeee"""" _E """"iiiinnnn""""
                      _P_0 [[[[ """"wwwwhhhheeeerrrreeee"""" _E_0 ]]]] """"---->>>>"""" _R_0
                      ............
                  """"||||"""" _P_n [[[[ """"wwwwhhhheeeerrrreeee"""" _E_n ]]]] """"---->>>>"""" _R_n
                  """"eeeennnndddd"""" """"ccccaaaasssseeee""""

              ||||   """"cccchhhhooooiiiicccceeee"""" _X_0 """"::::"""" _T_0 [[[[ """"aaaammmmoooonnnngggg"""" """"{{{{"""" _E_0_1 """"............"""" _E_0_2 """"}}}}"""" ]]]]
                           """",,,,"""" ............ """",,,,""""
                           _X_n """"::::"""" _T_n [[[[ """"aaaammmmoooonnnngggg"""" """"{{{{"""" _E_n_1 """"............"""" _E_n_2 """"}}}}"""" ]]]]
                  """"iiiinnnn""""
                      _R
                  """"eeeennnndddd"""" """"cccchhhhooooiiiicccceeee""""

              ||||   """"wwwwhhhhiiiilllleeee"""" _F """"ddddoooo""""
                      _R
                  """"eeeennnndddd"""" """"wwwwhhhhiiiilllleeee""""

              ||||   """"rrrreeeeppppeeeeaaaatttt""""
                      _R
                  """"uuuunnnnttttiiiillll"""" _F """"eeeennnndddd"""" """"rrrreeeeppppeeeeaaaatttt""""




(C) INRIA            Last change: 2018/05/25                   14






CADP MANUAL PAGES                                     MCL4(LOCAL)



              ||||   """"ffffoooorrrr"""" _X """"::::"""" _T """"ffffrrrroooommmm"""" _E_1 """"ttttoooo"""" _E_2 [[[[ """"sssstttteeeepppp"""" _E_3 ]]]] """"ddddoooo""""
                      _R
                  """"eeeennnndddd"""" """"ffffoooorrrr""""

              ||||   """"lllloooooooopppp"""" [[[[ """"(((("""" _X_0 """"::::"""" _T_0 """"::::===="""" _E_0 """",,,,"""" ............ """",,,,"""" _X_n """"::::"""" _T_n """"::::===="""" _E_n """"))))"""" ]]]]
                         [[[[ """"::::"""" """"(((("""" _X'_0 """"::::"""" _T'_0 """",,,,"""" ............ """",,,,"""" _X'_m """"::::"""" _T'_m """"))))"""" ]]]]
                  """"iiiinnnn""""
                      _R
                  """"eeeennnndddd"""" """"lllloooooooopppp""""

              ||||   """"ccccoooonnnnttttiiiinnnnuuuueeee"""" [[[[ """"(((("""" _E_0 """",,,,"""" ............"""",,,,"""" _E_n """"))))"""" ]]]]

              ||||   """"eeeexxxxiiiitttt"""" [[[[ """"(((("""" _E_0 """",,,,"""" ............ """",,,,"""" _E_m """"))))"""" ]]]]

              ||||   """"eeeexxxxppppoooorrrrtttt"""" """"(((("""" _X_0 """"::::"""" _T_0 """"::::===="""" _E_0 """",,,,"""" ............ """",,,,"""" _X_n """"::::"""" _T_n """"::::===="""" _E_n """"))))""""

              ||||   """"(((("""" _R """"))))""""

     Syntactically, all binary operators on regular formulas  are
     left-associative. The "****", "++++", "????", and "{{{{ ... }}}}" operators
     have the highest precedence, followed by  "....",  followed  by
     "||||".

     A regular formula _R denotes a sequence (represented  by  the
     couple  of  its source and target states) of consecutive LTS
     transitions such that the word obtained by concatenating the
     actions  labeling  them  belongs  to  the  regular  language
     defined by _R.

     A transition sequence _w_e_a_k_l_y _s_a_t_i_s_f_i_e_s a regular  formula  _R
     iff,  by  deleting  some  of  its invisible transitions, the
     resulting sub-sequence satisfies  _R.  In  other  words,  the
     transitions of the sequence matched by the action predicates
     of _R (which can denote either visible or invisible  actions)
     can  be interspersed with sub-sequences of 0 or more invisi-
     ble transitions.

     The semantics of _M_C_L regular formulas  is  described  infor-
     mally below.

     _A

          is the action regular formula, which  denotes  one-step
          transition sequences.  It is satisfied by a sequence of
          LTS transitions iff this sequence consists of a  single
          transition  labeled  by an action satisfying the action
          formula _A.

          All data variables exported by _A are also  exported  to
          the enclosing formula.





(C) INRIA            Last change: 2018/05/25                   15






CADP MANUAL PAGES                                     MCL4(LOCAL)



     "nil"

          is the null regular formula, which denotes empty  tran-
          sition  sequences.   It is satisfied by any sequence of
          LTS transitions that is empty,  i.e.,  it  contains  no
          transitions. An empty sequence has identical source and
          target states.

     _R_1 "." _R_2

          is the concatenation regular formula, which denotes the
          concatenation of two transition sequences. It is satis-
          fied by a sequence of LTS transitions iff this sequence
          consists  of  a  first sub-sequence concatenated with a
          second one (the target state of the first  sub-sequence
          being  the  source  state of the second one), the first
          sub-sequence satisfying _R_1 and the second one  satisfy-
          ing _R_2.

          All data variables exported by _R_1 are  visible  in  _R_2.
          For  each  data  variable _X exported by both _R_1 and _R_2,
          the occurrence of _X exported by _R_2 is also exported  to
          the   enclosing   formula   (i.e.,   it  overrides  the
          occurrence of _X possibly exported by _R_1). All the other
          data  variables (i.e., those exported by _R_1 only and by
          _R_2 only) are also exported to the enclosing formula.

     _R_1 "|" _R_2

          is the choice regular formula, which denotes the choice
          between  two transition sequences. It is satisfied by a
          sequence of LTS transitions iff this sequence satisfies
          _R_1 or it satisfies _R_2.

          None of the data variables exported by _R_1 (resp. by _R_2)
          is  visible  in  _R_2  (resp.  in _R_1). All data variables
          exported both by _R_1 and by _R_2 are also exported to  the
          enclosing formula.

     _R "*"

          is the repetition regular formula,  which  denotes  the
          repetition  of  a  transition  sequence 0 or more times
          (transitive reflexive closure).  It is satisfied  by  a
          sequence  of LTS transitions iff this sequence consists
          of the concatenation of 0 or more  sub-sequences,  each
          of  them  satisfying  _R.  Note  that any empty sequence
          satisfies the repetition formula.

          None of the data variables exported by _R is exported to
          the  enclosing  formula,  since none of these variables
          will be initialized  when  the  repetition  formula  is



(C) INRIA            Last change: 2018/05/25                   16






CADP MANUAL PAGES                                     MCL4(LOCAL)



          satisfied by an empty sequence.

     _R "+"

          is the strict repetition regular formula, which denotes
          the repetition of a transition sequence 1 or more times
          (transitive closure). It is satisfied by a sequence  of
          LTS  transitions iff this sequence consists of the con-
          catenation of 1 or more  sub-sequences,  each  of  them
          satisfying _R.

          All data variables exported by _R are also  exported  to
          the  enclosing  formula, since _R is always satisfied by
          at least one sub-sequence of the current sequence.

     _R "?"

          is  the  option  regular  formula,  which  denotes  the
          optional occurrence of a transition sequence (i.e., its
          repetition 0 or 1 times). It is satisfied by a sequence
          of  LTS  transitions  iff  this sequence is empty or it
          satisfies _R.

          None of the data variables exported by _R is exported to
          the  enclosing  formula,  since none of these variables
          will be initialized when the option formula  is  satis-
          fied by an empty sequence.

     _R "{" _E "}"

          is the counting  regular  formula,  which  denotes  the
          repetition  of  a  transition sequence _E times, where _E
          must be of type nnnnaaaatttt. It is satisfied by a  sequence  of
          LTS  transitions iff this sequence is the concatenation
          of exactly _E sub-sequences, each of them satisfying _R.

          None of the data variables exported by _R is exported to
          the  enclosing  formula,  since none of these variables
          will be initialized when the value of  _E  is  0  (i.e.,
          when  the  counting  formula  is  satisfied by an empty
          sequence).

     _R "{" _E "..." "}"
     or
     _R "{" _E "," "}"

          is the left interval counting  regular  formula,  which
          denotes  the  repetition  of  a  transition sequence at
          least _E times, where _E must  be  of  type  nnnnaaaatttt.  It  is
          satisfied  by  a  sequence  of LTS transitions iff this
          sequence  is  the  concatenation  of  _E  or  more  sub-
          sequences, each of them satisfying _R.



(C) INRIA            Last change: 2018/05/25                   17






CADP MANUAL PAGES                                     MCL4(LOCAL)



          None of the data variables exported by _R is exported to
          the  enclosing  formula,  since none of these variables
          will be initialized when the value of  _E  is  0  (i.e.,
          when the left interval counting formula is satisfied by
          an empty sequence).

     _R "{" _E_1 "..." _E_2 "}"
     or
     _R "{" _E_1 "," _E_2 "}"

          is the interval counting regular formula, which denotes
          the  repetition  of  a  transition sequence at least _E_1
          times and at most _E_2 times, where _E_1 and _E_2 must be  of
          type  nnnnaaaatttt. It is satisfied by a sequence of LTS transi-
          tions iff this sequence is the concatenation of  _E_1  or
          more (but not more than _E_2) sub-sequences, each of them
          satisfying _R.

          If the value of _E_1 is equal to the  value  of  _E_2,  the
          regular formula is equivalent to _R {{{{ _E_1 }}}}.

          If the value of _E_1 is larger than the value of _E_2,  the
          regular formula is equivalent to nnnniiiillll.

          None of the data variables exported by _R is exported to
          the  enclosing  formula,  since none of these variables
          will be initialized when the value of _E_1  is  0  (i.e.,
          when  the  interval counting formula is satisfied by an
          empty sequence).

     "let" _X_0 ":" _T_0 ":=" _E_0 "," ... "," _X_n ":" _T_n ":=" _E_n "in"
         _R
     "end" "let"

          is  the  variable  definition  regular  formula,  which
          declares  and  initializes data variables. It is satis-
          fied by a sequence of LTS transitions iff this sequence
          satisfies   the   regular   formula   _R  in  which  all
          occurrences of variables _X_0, ...,  _X_n  are  substituted
          with the values of the expressions _E_0, ..., _E_n, respec-
          tively. Each expression _E_i must be of type _T_i for 0  <=
          _i <= _n.

          Variables _X_0, ..., _X_n are visible in _R but not  in  the
          enclosing formula. All data variables exported by _R are
          also exported to the enclosing formula  (regardless  of
          whether  or not they are identical to some of the vari-
          ables _X_0, ..., _X_n).

     "if" _F_0 "then"
         _R_0
     [ "elsif" _F_1 "then"



(C) INRIA            Last change: 2018/05/25                   18






CADP MANUAL PAGES                                     MCL4(LOCAL)



         _R_1
       ...
       "elsif" _F_n "then"
         _R_n
       "else"
         _R_n+_1 ]
     "end" "if"

          is the conditional regular formula, which  denotes  the
          conditional branching between several alternative tran-
          sition sequences depending whether their source  states
          satisfy or not certain state formulas.  It is satisfied
          by a sequence of LTS transitions iff the  source  state
          of  this  sequence satisfies _F_0 and the sequence satis-
          fies _R_0, or the source state of this sequence satisfies
          _F_1  (if present) and the sequence satisfies _R_1, ..., or
          the source state of  this  sequence  satisfies  _F_n  (if
          present) and the sequence satisfies _R_n, or the sequence
          satisfies _R_n+_1 (if present).

          All state formulas _F_0, ..., _F_n occurring as  conditions
          of  the  branches must be propositionally closed (i.e.,
          they cannot contain free occurrences  of  propositional
          variables,  but  may  contain  free occurrences of data
          variables) in order to ensure the  syntactic  monotoni-
          city condition (see STATE FORMULAS below) for the whole
          _M_C_L formula.

          The branches "eeeellllssssiiiiffff" and "eeeellllsssseeee" are optional;  if  they
          are  all  absent  and  the source state of the sequence
          does not satisfy _F_0, then the empty sequence consisting
          of  that  state  satisfies  the conditional formula. In
          other words, the following equality holds:

              "if" _F "then" _R "end if"

              =

              "if" _F "then" _R "else" "nil" "end" "if"

          If the "eeeellllsssseeee" clause is absent, none of the data  vari-
          ables  exported  by the regular formulas _R_0, ..., _R_n is
          exported to the enclosing formula, since none of  these
          variables will be initialized when the conditional for-
          mula is satisfied by an empty sequence. If  the  "eeeellllsssseeee"
          clause  is  present, each data variable exported simul-
          taneously by all regular formulas _R_0, ..., _R_n+_1 is also
          exported to the enclosing formula.

     "case" _E "in"
         _P_0 [ "where" _E_0 ] "->" _R_0
         ...



(C) INRIA            Last change: 2018/05/25                   19






CADP MANUAL PAGES                                     MCL4(LOCAL)



     "|" _P_n [ "where" _E_n ] "->" _R_n
     "end" "case"

          is the selection regular  formula,  which  denotes  the
          selection   between   several   alternative  transition
          sequences depending whether the value _v of _E matches or
          not certain patterns.  It is satisfied by a sequence of
          LTS transitions iff this sequence matches  one  of  the
          branches  0, ..., _n of the selection, in this order.  A
          sequence matches a branch _i iff  the  following  condi-
          tions hold:

          - _v matches the pattern _P_i;

          - the boolean expression _E_i (if present)  evaluates  to
          true in a context in which all variables declared in _P_i
          are replaced with the  corresponding  values  extracted
          from _v;

          - the sequence satisfies _R_i in the same context.

          If the value of _E does not match any  of  the  patterns
          _P_0,  ...,  _P_n,  then  an  empty  sequence satisfies the
          selection formula. In other words,  in  this  case  the
          selection formula becomes equivalent to "nnnniiiillll".

          If some pattern _P_i for some 0 <= _i <= _n  is  aaaannnnyyyy,  then
          each data variable exported simultaneously by all regu-
          lar formulas _R_0,  ...,  _R_i  is  also  exported  to  the
          enclosing  formula, since at least one of these regular
          formulas will be satisfied by the current sequence.  If
          none  of  the patterns _P_i is aaaannnnyyyy, then none of the data
          variables exported by the regular formulas _R_0, ...,  _R_n
          is  exported  to  the  enclosing formula, since none of
          these variables will be initialized when the  selection
          formula is satisfied by an empty sequence.

          Note: For technical reasons (syntactic  ambiguity  con-
          cerning  the "||||" symbol occurring both as choice opera-
          tor and as branch separator), formulas _R_0, ..., _R_n must
          _n_o_t   contain   the  "||||"  operator  at  top-level.  For
          instance, the following formula is illegal:
              case E in
                  P0 -> R1 | R2
              |   P1 -> R3
              end case
          If regular formulas with the "||||" operator at  top-level
          are  required  as branches of a selection formula, then
          they must be surrounded by parentheses, as in the  for-
          mula below:
              case E in
                  P0 -> (R1 | R2)



(C) INRIA            Last change: 2018/05/25                   20






CADP MANUAL PAGES                                     MCL4(LOCAL)



              |   P1 -> R3
              end case
          which is legal.

     "choice" _X_0 ":" _T_0 [ "among" "{" _E_0_1 "..." _E_0_2 "}" ]
              "," ... ","
              _X_n ":" _T_n [ "among" "{" _E_n_1 "..." _E_n_2 "}" ]
     "in"
         _R
     "end" "choice"

          is  the  generalized  choice  regular  formula,   which
          denotes the choice among several alternative transition
          sequences depending whether data  variables  belong  or
          not  to  certain domains. It is satisfied by a sequence
          of LTS transitions iff for each  0  <=  _i  <=  _n  there
          exists  at  least  a  value _v_i of type _T_i in the domain
          delimited by the values of _E_i_1  and  _E_i_2  (if  present)
          such  that the sequence satisfies the regular formula _R
          in which all occurrences of variables _X_0, ...,  _X_n  are
          substituted  with the values _v_0, ..., _v_n, respectively.
          The optional expressions _E_i_1 and _E_i_2 must be of type _T_i
          for  0  <=  _i  <=  _n.   Only the types bbbboooooooollll and nnnnaaaatttt are
          allowed currently as _T_is.

          All data variables exported by _R are also  exported  to
          the  enclosing  formula  (regardless  of whether or not
          they are identical to some of the  variables  _X_0,  ...,
          _X_n).

     "while" _F "do"
         _R
     "end" "while"

          is the initial condition loop  regular  formula,  which
          denotes  the  repetition  of  a regular sub-sequence as
          long as its source state satisfies a certain state for-
          mula.  It is satisfied by a sequence of LTS transitions
          iff this sequence consists of the concatenation of 0 or
          more  sub-sequences  such that the source state of each
          sub-sequence satisfies _F and each  sub-sequence  satis-
          fies _R.

          None of the data variables exported by _R is exported to
          the  enclosing  formula,  since none of these variables
          will be initialized when  the  initial  condition  loop
          formula is satisfied by an empty sequence (whose source
          state does not satisfy _F).

     "repeat"
         _R
     "until" _F "end" "repeat"



(C) INRIA            Last change: 2018/05/25                   21






CADP MANUAL PAGES                                     MCL4(LOCAL)



          is the final  condition  loop  regular  formula,  which
          denotes  the repetition of a regular sub-sequence until
          its target state satisfies a certain state formula.  It
          is  satisfied by a sequence of LTS transitions iff this
          sequence consists of the concatenation  of  1  or  more
          sub-sequences  such  that the target state of each sub-
          sequence satisfies _F and each sub-sequence satisfies _R.

          All data variables exported by _R are also  exported  to
          the  enclosing  formula, since _R is always satisfied by
          at least one sub-sequence of the current sequence  (the
          body of the final condition loop formula is repeated at
          least once).

     "for" _X ":" _T "from" _E_1 "to" _E_2 [ "step" _E_3 ] "do"
         _R
     "end" "for"

          is the bounded loop regular formula, which denotes  the
          repetition  of  a regular sub-sequence depending on the
          values taken by variable  _X  in  an  interval.   It  is
          satisfied  by  a  sequence  of LTS transitions iff this
          sequence consists of the concatenation  of  0  or  more
          sub-sequences,  such  that  each sub-sequence satisfies
          the regular formula _R for the current value of variable
          _X  (which  may occur or not in _R).  The expressions _E_1,
          _E_2, and _E_3 must be of type _T.  At the  first  iteration
          of  the loop, _X is initialized with the value of _E_1. At
          each sub-sequent iteration, _X is incremented either  by
          the  value  of  _E_3  if  the  optional  clause "step" is
          present, or by 1 otherwise. The loop terminates when  _X
          becomes strictly greater than the value of _E_2.

          None of the data variables exported by _R is exported to
          the  enclosing  formula,  since none of these variables
          will be initialized when the bounded  loop  formula  is
          satisfied by an empty sequence.

          The type _T of the iteration variable can  be  currently
          the nnnnaaaatttt type only.

     "loop" [ "(" _X_0 ":" _T_0 ":=" _E_0 "," ... "," _X_n ":" _T_n ":=" _E_n ")" ]
            [ ":" "(" _X'_0 ":" _T'_0 "," ... "," _X'_m ":" _T'_m ")" ]
     "in"
         _R
     "end" "loop"

          is the general loop regular formula, which denotes  the
          repetition  of  a  regular  sub-sequence  satisfying  _R
          depending on the values of the optional  input  parame-
          ters  _X_0,  ..., _X_n. These parameters are initialized at
          the start of the loop with the  values  of  expressions



(C) INRIA            Last change: 2018/05/25                   22






CADP MANUAL PAGES                                     MCL4(LOCAL)



          _E_0,  ...,  _E_n,  which  must  be  of  types _T_0, ..., _T_n,
          respectively.   Upon  termination  of  the  loop,   the
          optional  output  parameters _X'_0, ..., _X'_m are assigned
          appropriate values and are exported  to  the  enclosing
          formula.

          An iteration of the loop is triggered when the  evalua-
          tion  of  _R  on  a sub-sequence of the current sequence
          leads to the evaluation of a "continue" subformula of _R
          (see  below),  which  must  assign  values to the input
          parameters _X_0, ..., _X_n.  The loop terminates  when  the
          evaluation  of  _R  on  a  sub-sequence  of  the current
          sequence either does not lead to the  evaluation  of  a
          "continue"  subformula  (in this case the loop must not
          have output parameters), or it leads to the  evaluation
          of  an  "exit"  subformula of _R (see below), which must
          assign values to the output parameters _X'_0, ..., _X'_m.

          None of the data variables exported by _R is exported to
          the  enclosing  formula,  since none of these variables
          will be initialized when the general  loop  formula  is
          satisfied by an empty sequence.

     "continue" [ "(" _E_0 "," ..."," _E_n ")" ]

          is the continuation regular formula, which denotes  the
          general  loop  repetition.   It  can  occur only in the
          scope of a "loop"  regular  formula.  If  present,  the
          optional  expressions  _E_0,  ..., _E_n must be of the same
          types _T_0, ..., _T_n as the input parameters _X_0,  ...,  _X_n
          of  the  immediately enclosing "loop" formula. The con-
          tinuation  formula  is  always  satisfied  by  an   LTS
          sequence  and  triggers an iteration of the immediately
          enclosing "loop" formula, the input parameters of which
          are assigned the values of the expressions _E_0, ..., _E_n,
          respectively.

     "exit" [ "(" _E_0 "," ... "," _E_m ")" ]

          is the termination regular formula, which  denotes  the
          general  loop  termination.   It  can occur only in the
          scope of a "loop"  regular  formula.  If  present,  the
          optional  expressions  _E_0,  ..., _E_m must be of the same
          types _T'_0, ..., _T'_m as the output parameters _X'_0,  ...,
          _X'_m  of  the  immediately enclosing "loop" formula. The
          termination formula  is  always  satisfied  by  an  LTS
          sequence  and  triggers  the termination of the immedi-
          ately enclosing "loop" formula, the  output  parameters
          of  which  are  exported to the enclosing formula after
          being assigned the values of the expressions  _E_0,  ...,
          _E_m, respectively.




(C) INRIA            Last change: 2018/05/25                   23






CADP MANUAL PAGES                                     MCL4(LOCAL)



     "export" "(" _X_0 ":" _T_0 ":=" _E_0 "," ... "," _X_n ":" _T_n ":=" _E_n ")"

          is the exporting regular  formula,  which  assigns  the
          values of expressions _E_0, ..., _E_n to variables _X_0, ...,
          _X_n and exports  them  to  the  enclosing  formula.  The
          expressions  _E_0,  ..., _E_n must be of types _T_0, ..., _T_n,
          respectively. The exporting formula is satisfied by any
          LTS  sequence.  It  is an abbreviation of the following
          "loop" formula:

              "loop" "(" _X_0 ":" _T_0"," ... "," _X_n ":" _T_n ")" "in"
                  "exit" "(" _E_0 "," ... "," _E_n ")"
              "end" "loop"

          Note:  The  "let"  regular  formula  (see  above)  also
          assigns  values  to  variables, but these variables are
          visible only in the regular  subformula  of  the  "let"
          formula and are not exported to the enclosing formula.

     "(" _R ")"

          a sequence of LTS transitions  satisfies  this  formula
          iff  it satisfies _R.  Parentheses are useful for impos-
          ing an evaluation order of subformulas  different  from
          the  order given by the associativity and precedence of
          operators.


SSSSTTTTAAAATTTTEEEE FFFFOOOORRRRMMMMUUUULLLLAAAASSSS
     A _s_t_a_t_e _f_o_r_m_u_l_a is a  logical  formula  built  from  boolean
     operators,  modalities,  fixed  point  operators,  and data-
     handling constructs  inspired  from  functional  programming
     languages.  The  syntax  of _M_C_L state formulas is defined by
     the following grammar:

     _F       ::::::::====  _E

              ||||   """"ttttrrrruuuueeee""""

              ||||   """"ffffaaaallllsssseeee""""

              ||||   """"nnnnooootttt"""" _F

              ||||   _F_1 """"oooorrrr"""" _F_2

              ||||   _F_1 """"xxxxoooorrrr"""" _F_2

              ||||   _F_1 """"aaaannnndddd"""" _F_2

              ||||   _F_1 """"iiiimmmmpppplllliiiieeeessss"""" _F_2

              ||||   _F_1 """"eeeeqqqquuuu"""" _F_2



(C) INRIA            Last change: 2018/05/25                   24






CADP MANUAL PAGES                                     MCL4(LOCAL)



              ||||   """"<<<<"""" _R """">>>>"""" _F

              ||||   """"<<<<<<<<"""" _R """">>>>>>>>"""" _F

              ||||   """"[[[["""" _R """"]]]]"""" _F

              ||||   """"[[[[[[[["""" _R """"]]]]]]]]"""" _F

              ||||   """"<<<<"""" _R """">>>>"""" """"@@@@""""

              ||||   """"<<<<<<<<"""" _R """">>>>>>>>"""" """"@@@@""""

              ||||   """"[[[["""" _R """"]]]]"""" """"----||||""""

              ||||   """"[[[[[[[["""" _R """"]]]]]]]]"""" """"----||||""""

              ||||   _Y [[[[ """"(((("""" _E_0 """",,,,"""" ............ """",,,,"""" _E_n """"))))"""" ]]]]

              ||||   """"mmmmuuuu"""" _Y [[[[ """"(((("""" _X_0 """"::::"""" _T_0 """"::::===="""" _E_0 """",,,,"""" ............ """",,,,""""
                               _X_n """"::::"""" _T_n """"::::===="""" _E_n """"))))"""" ]]]]
                  """"...."""" _F

              ||||   """"nnnnuuuu"""" _Y [[[[ """"(((("""" _X_0 """"::::"""" _T_0 """"::::===="""" _E_0 """",,,,"""" ............ """",,,,""""
                               _X_n """"::::"""" _T_n """"::::===="""" _E_n """"))))"""" ]]]]
                  """"...."""" _F

              ||||   """"eeeexxxxiiiissssttttssss"""" _X_0 """"::::"""" _T_0 [[[[ """"aaaammmmoooonnnngggg"""" """"{{{{"""" _E_0_1 """"............"""" _E_0_2 """"}}}}"""" ]]]]
                          """",,,,"""" ............ """",,,,""""
                           _X_n """"::::"""" _T_n [[[[ """"aaaammmmoooonnnngggg"""" """"{{{{"""" _E_n_1 """"............"""" _E_n_2 """"}}}}"""" ]]]]
                  """"...."""" _F

              ||||   """"ffffoooorrrraaaallllllll"""" _X_0 """"::::"""" _T_0 [[[[ """"aaaammmmoooonnnngggg"""" """"{{{{"""" _E_0_1 """"............"""" _E_0_2 """"}}}}"""" ]]]]
                           """",,,,"""" ............ """",,,,""""
                           _X_n """"::::"""" _T_n [[[[ """"aaaammmmoooonnnngggg"""" """"{{{{"""" _E_n_1 """"............"""" _E_n_2 """"}}}}"""" ]]]]
                  """"...."""" _F

              ||||   """"lllleeeetttt"""" _X_0 """"::::"""" _T_0 """"::::===="""" _E_0 """",,,,"""" ............ """",,,,"""" _X_n """"::::"""" _T_n """"::::===="""" _E_n """"iiiinnnn""""
                      _F
                  """"eeeennnndddd"""" """"lllleeeetttt""""

              ||||   """"iiiiffff"""" _F_0 """"tttthhhheeeennnn""""
                      _F'_0
                  [[[[ """"eeeellllssssiiiiffff"""" _F_1 """"tttthhhheeeennnn""""
                      _F'_1
                    ............
                    """"eeeellllssssiiiiffff"""" _F_n """"tttthhhheeeennnn""""
                      _F'_n
                    """"eeeellllsssseeee""""
                      _F_n+_1 ]]]]
                  """"eeeennnndddd"""" """"iiiiffff""""

              ||||   """"ccccaaaasssseeee"""" _E """"iiiinnnn""""



(C) INRIA            Last change: 2018/05/25                   25






CADP MANUAL PAGES                                     MCL4(LOCAL)



                      _P_0 [[[[ """"wwwwhhhheeeerrrreeee"""" _E_0 ]]]] """"---->>>>"""" _F_0
                      ............
                  """"||||"""" _P_n [[[[ """"wwwwhhhheeeerrrreeee"""" _E_n ]]]] """"---->>>>"""" _F_n
                  """"eeeennnndddd"""" """"ccccaaaasssseeee""""

              ||||   """"(((("""" _F """"))))""""


     Syntactically, all binary operators on  state  formulas  are
     left-associative.   The  unary  operators  "nnnnooootttt", "<"...">",
     "<<"...">>", "["..."]", "[["..."]]", "mu",  "nu",  "exists",
     and "forall" have the highest precedence, followed by "aaaannnndddd",
     followed by "oooorrrr" and "xxxxoooorrrr", followed by "iiiimmmmpppplllliiiieeeessss",  followed
     by "eeeeqqqquuuu".

     The minimal and maximal fixed point operators "mu" and  "nu"
     act  as  binders  for the propositional variables _Y in a way
     that is similar to quantifiers  in  first-order  logic.   In
     each  meaningful  "mmmmuuuu  _Y ((((...)))) .... _F" or "nnnnuuuu _Y ((((...)))) .... _F" for-
     mula, _Y is assumed to have free occurrences inside _F.

     State formulas must satisfy the following two syntactic con-
     ditions:

     -    _S_y_n_t_a_c_t_i_c _m_o_n_o_t_o_n_i_c_i_t_y [Koz83] means that in each fixed
          point  formula  "mmmmuuuu  _Y  ((((...)))) .... _F" or "nnnnuuuu _Y ((((...)))) .... _F",
          free occurrences of the propositional variable _Y  in  _F
          may  appear  only  under  an  even  number of negations
          and/or left-hand sides of implications.


     -    _A_l_t_e_r_n_a_t_i_o_n-_f_r_e_e_n_e_s_s [EL86] means that each fixed point
          formula   "mmmmuuuu   _Y   ((((...))))  ....  _F"  cannot  contain  free
          occurrences of propositional variables  _Y'  defined  by
          "nnnnuuuu"  operators,  and  each  fixed  point formula "nnnnuuuu _Y
          ((((...)))) .... _F" cannot contain free occurrences of  proposi-
          tional  variables  _Y'  defined  by "mmmmuuuu" operators. When
          checking this condition on a formula, strong  possibil-
          ity  (resp. necessity) modalities whose regular subfor-
          mulas contain an iteration operator, and weak possibil-
          ity  (resp.  necessity)  modalities  are interpreted as
          "hidden" minimal (resp. maximal) fixed point operators.
          Note  that the state formulas corresponding to infinite
          looping and saturation operators  do  not  satisfy  the
          alternation-freeness condition (see REMARKS below).

     A state formula defines a predicate over the states  of  the
     LTS.   The  semantics  of  _M_C_L  state  formulas is described
     informally below.

     _E




(C) INRIA            Last change: 2018/05/25                   26






CADP MANUAL PAGES                                     MCL4(LOCAL)



          a state of the LTS satisfies a boolean expression _E iff
          _E evaluates to ttttrrrruuuueeee.

     "true"

          a state of the LTS always satisfies this formula.

     "false"

          a state of the LTS never satisfies this formula.

     "not" _F

          a state of the LTS satisfies this formula iff  it  does
          not satisfy _F.

     _F_1 "or" _F_2

          a state of the LTS satisfies this formula iff it satis-
          fies _F_1 or it satisfies _F_2.

     _F_1 "xor" _F_2

          a state of the LTS satisfies this formula iff it satis-
          fies exactly one of _F_1 and _F_2.

     _F_1 "and" _F_2

          a state of the LTS satisfies this formula iff it satis-
          fies both _F_1 and _F_2.

     _F_1 "implies" _F_2

          a state of the LTS satisfies this formula iff  it  does
          not satisfy _F_1 or it satisfies _F_2.

     _F_1 "equ" _F_2

          a state of the LTS satisfies this formula iff either it
          satisfies both _F_1 and _F_2, or neither of them.

     "<" _R ">" _F

          is the possibility modality. It is satisfied by a state
          of  the LTS iff there is some transition sequence going
          out of this state that satisfies the regular formula  _R
          and leads to a state satisfying the state formula _F.

          The evaluation of _F on the target state of the  transi-
          tion  sequence is carried out in a context in which all
          data variables exported by _R are initialized  with  the
          corresponding  values  extracted from the sequence.  If



(C) INRIA            Last change: 2018/05/25                   27






CADP MANUAL PAGES                                     MCL4(LOCAL)



          there is no transition sequence satisfying _R, then  the
          whole  possibility  modality  is  false  and  _F  is not
          evaluated at all.

          All data variables exported by _R are visible in _F,  but
          none  of them is exported outside the whole possibility
          modality.

     "<<" _R ">>" _F

          is the weak possibility modality. It is satisfied by  a
          state  of the LTS iff there is some transition sequence
          going out of this state that weakly satisfies the regu-
          lar formula _R and leads to a state satisfying the state
          formula _F.

          The evaluation of _F on the target state of the  transi-
          tion  sequence is carried out in a context in which all
          data variables exported by _R are initialized  with  the
          corresponding  values  extracted from the sequence.  If
          there is no transition sequence  weakly  satisfying  _R,
          then the whole weak possibility modality is false and _F
          is not evaluated at all.

          All data variables exported by _R are visible in _F,  but
          none  of them is exported outside the whole weak possi-
          bility modality.

          The regular formula _R must not contain  any  occurrence
          of the ttttaaaauuuu action formula.

     "[" _R "]" _F

          is the necessity modality. It is satisfied by  a  state
          of  the  LTS iff for each transition sequence going out
          of this state, if this sequence satisfies  the  regular
          formula  _R, then it must lead to a state satisfying the
          state formula _F.

          The evaluation of _F on the target state of each transi-
          tion  sequence is carried out in a context in which all
          data variables exported by _R are initialized  with  the
          corresponding  values extracted from that sequence.  If
          there is no transition sequence satisfying _R, then  the
          whole necessity modality is true and _F is not evaluated
          at all.

          All data variables exported by _R are visible in _F,  but
          none  of  them  is exported outside the whole necessity
          modality.





(C) INRIA            Last change: 2018/05/25                   28






CADP MANUAL PAGES                                     MCL4(LOCAL)



     "[[" _R "]]" _F

          is the weak necessity modality. It is  satisfied  by  a
          state of the LTS iff for each transition sequence going
          out of this state, if this  sequence  weakly  satisfies
          the  regular  formula  _R,  then it must lead to a state
          satisfying the state formula _F.

          The evaluation of _F on the target state of each transi-
          tion  sequence is carried out in a context in which all
          data variables exported by _R are initialized  with  the
          corresponding  values extracted from that sequence.  If
          there is no transition sequence  weakly  satisfying  _R,
          then the whole weak necessity modality is true and _F is
          not evaluated at all.

          All data variables exported by _R are visible in _F,  but
          none  of them is exported outside the whole weak neces-
          sity modality.

          The regular formula _R must not contain  any  occurrence
          of the ttttaaaauuuu action formula.

     "<" _R ">" "@"

          is the infinite looping formula. It is satisfied  by  a
          state  of the LTS iff there is some transition sequence
          going out of this state and consisting of  an  infinite
          concatenation of sub-sequences that satisfy the regular
          formula _R.

          None of the data variables exported by  _R  is  exported
          outside of the infinite looping formula.

     "<<" _R ">>" "@"

          is the weak infinite looping formula. It  is  satisfied
          by  a  state  of  the  LTS iff there is some transition
          sequence going out of this state and consisting  of  an
          infinite  concatenation  of  sub-sequences  that weakly
          satisfy the regular formula _R.

          None of the data variables exported by  _R  is  exported
          outside of the weak infinite looping formula.

          The regular formula _R must not contain  any  occurrence
          of the ttttaaaauuuu action formula.

     "[" _R "]" "-|"

          is the finite saturation formula. It is satisfied by  a
          state of the LTS iff for each transition sequence going



(C) INRIA            Last change: 2018/05/25                   29






CADP MANUAL PAGES                                     MCL4(LOCAL)



          out of this state, if this sequence consists of a  con-
          catenation  of  sub-sequences  that satisfy the regular
          formula _R, then the sequence must be finite.

          None of the data variables exported by  _R  is  exported
          outside of the finite saturation formula.

     "[[" _R "]]" "-|"

          is the weak finite saturation formula. It is  satisfied
          by  a state of the LTS iff for each transition sequence
          going out of this state, if this sequence consists of a
          concatenation  of sub-sequences that weakly satisfy the
          regular formula _R, then the sequence must be finite.

          None of the data variables exported by  _R  is  exported
          outside of the weak finite saturation formula.

          The regular formula _R must not contain  any  occurrence
          of the ttttaaaauuuu action formula.

     _Y [ "(" _E_0 "," ... "," _E_n ")" ]

          is a call of the propositional variable _Y. It can occur
          only  in the scope of a fixed point formula defining _Y.
          If present, the optional expressions _E_0, ...,  _E_n  must
          be  of the same types _T_0, ..., _T_n as the parameters _X_0,
          ..., _X_n of the corresponding fixed point  formula.  The
          propositional  variable  call formula is satisfied by a
          state of the LTS iff this state belongs to the solution
          _Y  of the corresponding fixed point equation, evaluated
          by assigning the values of the expressions _E_0, ...,  _E_n
          to the parameters _X_0, ..., _X_n, respectively.

     "mu" _Y [ "(" _X_0 ":" _T_0 ":=" _E_0 "," ... ","
                  _X_n ":" _T_n ":=" _E_n ")" ]
     "." _F

          is the parameterized minimal fixed point formula defin-
          ing  the  propositional variable _Y. The expressions _E_0,
          ..., _E_n must be of types _T_0, ..., _T_n, respectively. The
          formula  is  satisfied  by  a state of the LTS iff this
          state belongs to the  minimal  solution  of  the  fixed
          point  equation  _Y  (_X_0,  ...,  _X_n)  =  _F, evaluated by
          assigning the values of the expressions _E_0, ..., _E_n  to
          the  parameters  _X_0, ..., _X_n, respectively. The parame-
          ters _X_0, ..., _X_n are visible only  in  _F  and  are  not
          exported outside the minimal fixed point formula.

          Intuitively, a parameterized minimal fixed  point  for-
          mula  characterizes  finite  subgraphs contained in the
          LTS. The parameters enable  one  to  perform  arbitrary



(C) INRIA            Last change: 2018/05/25                   30






CADP MANUAL PAGES                                     MCL4(LOCAL)



          computations  during  a  forward  traversal of the sub-
          graphs.

     "nu" _Y [ "(" _X_0 ":" _T_0 ":=" _E_0 "," ... ","
                  _X_n ":" _T_n ":=" _E_n ")" ]
     "." _F

          is the parameterized maximal fixed point formula defin-
          ing  the  propositional variable _Y. The expressions _E_0,
          ..., _E_n must be of types _T_0, ..., _T_n, respectively. The
          formula  is  satisfied  by  a state of the LTS iff this
          state belongs to the  maximal  solution  of  the  fixed
          point  equation  _Y  (_X_0,  ...,  _X_n)  =  _F, evaluated by
          assigning the values of the expressions _E_0, ..., _E_n  to
          the  parameters  _X_0, ..., _X_n, respectively. The parame-
          ters _X_0, ..., _X_n are visible only  in  _F  and  are  not
          exported outside the maximal fixed point formula.

          Intuitively, a parameterized maximal fixed  point  for-
          mula  characterizes infinite subgraphs contained in the
          LTS. The parameters enable  one  to  perform  arbitrary
          computations  during  a  forward  traversal of the sub-
          graphs.

     "exists" _X_0 ":" _T_0 [ "among" "{" _E_0_1 "..." _E_0_2 "}" ]
              "," ... ","
              _X_n ":" _T_n [ "among" "{" _E_n_1 "..." _E_n_2 "}" ]
     "." _F

          is the existential quantification  over  variables  _X_0,
          ...,  _X_n.   It  is  satisfied by a state of the LTS iff
          there exists  a  combination  of  values  _v_0,  ...,  _v_n
          belonging to the types _T_0, ..., _T_n (possibly restricted
          to the optional domains delimited by the values of _E_0_1,
          _E_0_2,  ...,  _E_n_1,  _E_n_2  if present) such that this state
          satisfies the state formula _F in which all  occurrences
          of  variables  _X_0,  ...,  _X_n  are  substituted with the
          values _v_0, ..., _v_n, respectively. The optional  expres-
          sions  _E_i_1  and _E_i_2 must be of type _T_i for 0 <= _i <= _n.
          Only the types bbbboooooooollll and nnnnaaaatttt are  allowed  currently  as
          _T_is.

          The variables _X_0, ..., _X_n are visible only in _F and are
          not  exported  outside  the  existential quantification
          formula.

          Note:  The  existential  quantifier  is  not,  strictly
          speaking,  a  primitive operator of _M_C_L. It can be seen
          as an abbreviation of the disjunction operator.  Assum-
          ing that the domain of variable _X_i is {{{{ _v_i_0, ... _v_i_m_i }}}}
          for 0 <= _i <= _n, the existential quantification formula
          is equivalent to the disjunction below:



(C) INRIA            Last change: 2018/05/25                   31






CADP MANUAL PAGES                                     MCL4(LOCAL)



              _F (_v_0_0, ..., _v_n_0) or ... or _F (_v_0_0, ..., _v_n_m_n)
              or ... or
              _F (_v_0_m_0, ..., _v_n_0) or ... or _F (_v_0_m_0, ..., _v_n_m_n)

          where _F (_v_0_j, ..., _v_n_k) denotes the state formula _F  in
          which all occurrences of variables _X_0, ..., _X_n are sub-
          stituted with the values _v_0_j, ...,  _v_n_k,  respectively.
          In  practice,  the  usage of the existential quantifier
          may yield much more concise formulations of  properties
          than its equivalent disjunctive formulation.

     "forall" _X_0 ":" _T_0 [ "among" "{" _E_0_1 "..." _E_0_2 "}" ]
              "," ... ","
              _X_n ":" _T_n [ "among" "{" _E_n_1 "..." _E_n_2 "}" ]
     "." _F

          is the universal quantification over variables _X_0, ...,
          _X_n.   It  is  satisfied  by  a state of the LTS iff for
          every combination of values _v_0, ...,  _v_n  belonging  to
          the  types  _T_0,  ...,  _T_n  (possibly  restricted to the
          optional domains delimited by the values of  _E_0_1,  _E_0_2,
          ...,  _E_n_1,  _E_n_2  if  present), this state satisfies the
          state formula _F in which all occurrences  of  variables
          _X_0,  ...,  _X_n  are substituted with the values _v_0, ...,
          _v_n, respectively. The optional expressions _E_i_1 and  _E_i_2
          must  be  of  type  _T_i for 0 <= _i <= _n.  Only the types
          bbbboooooooollll and nnnnaaaatttt are allowed currently as _T_is.

          The variables _X_0, ..., _X_n are visible only in _F and are
          not  exported outside the universal quantification for-
          mula.

          Note: The universal quantifier is not, strictly  speak-
          ing,  a primitive operator of _M_C_L. It can be seen as an
          abbreviation of  the  conjunction  operator.   Assuming
          that the domain of variable _X_i is {{{{ _v_i_0, ... _v_i_m_i }}}} for
          0 <= _i <= _n, the universal  quantification  formula  is
          equivalent to the conjunction below:

              _F (_v_0_0, ..., _v_n_0) and ... and _F (_v_0_0, ..., _v_n_m_n)
              and ... and
              _F (_v_0_m_0, ..., _v_n_0) and ... and _F (_v_0_m_0, ..., _v_n_m_n)

          where _F (_v_0_j, ..., _v_n_k) denotes the state formula _F  in
          which all occurrences of variables _X_0, ..., _X_n are sub-
          stituted with the values _v_0_j, ...,  _v_n_k,  respectively.
          In  practice, the usage of the universal quantifier may
          yield much more concise formulations of properties than
          its equivalent conjunctive formulation.

     "let" _X_0 ":" _T_0 ":=" _E_0 "," ... "," _X_n ":" _T_n ":=" _E_n "in"
           _F



(C) INRIA            Last change: 2018/05/25                   32






CADP MANUAL PAGES                                     MCL4(LOCAL)



     "end" "let"

          is  the  variable  definition  state   formula,   which
          declares  and initializes data variables.  It is satis-
          fied by a state of the LTS iff this state satisfies the
          state  formula  _F in which all occurrences of variables
          _X_0, ..., _X_n are substituted  with  the  values  of  the
          expressions  _E_0, ..., _E_n, respectively. Each expression
          _E_i must be of type _T_i for 0 <= _i <= _n.

          The variables _X_0, ..., _X_n are visible only in _F and are
          not exported outside the variable definition formula.

     "if" _F_0 "then"
          _F'_0
     [ "elsif" _F_1 "then"
          _F'_1
       ...
       "elsif" _F_n "then"
          _F'_n
       "else"
          _F_n+_1 ]
     "end" "if"

          is the conditional state  formula,  which  denotes  the
          branching  according  to certain state formulas.  It is
          satisfied by a state of the LTS iff either  this  state
          satisfies  _F_0  and it also satisfies _F'_0, or this state
          satisfies _F_1 (if present) and it  also  satisfies  _F'_1,
          ...,  or  this  state  satisfies _F_n (if present) and it
          also satisfies _F'_n, or this state  satisfies  _F_n+_1  (if
          present).

          All state formulas _F_0, ..., _F_n occurring as  conditions
          of  the  branches must be propositionally closed (i.e.,
          they cannot contain free occurrences  of  propositional
          variables,  but  may  contain  free occurrences of data
          variables) in order to ensure the  syntactic  monotoni-
          city condition for the whole _M_C_L formula.

          The branches "eeeellllssssiiiiffff" and "eeeellllsssseeee" are optional;  if  they
          are  all absent and the state does not satisfy _F_0, then
          this state satisfies the conditional formula.  In other
          words, the following equality holds:

              "if" _F_0 "then" _F'_0 "end if"

              =

              "if" _F_0 "then" _F'_0 "else" "true" "end" "if"





(C) INRIA            Last change: 2018/05/25                   33






CADP MANUAL PAGES                                     MCL4(LOCAL)



     "case" _E "in"
         _P_0 [ "where" _E_0 ] "->" _F_0
         ...
     "|" _P_n [ "where" _E_n ] "->" _F_n
     "end" "case"

          is the  selection  state  formula,  which  denotes  the
          selection  between  several  alternatives  depending on
          whether the value _v of _E matches or  not  certain  pat-
          terns.   It is satisfied by a state of the LTS iff this
          state matches one of the branches  0,  ...,  _n  of  the
          selection,  in  this order.  A state matches a branch _i
          iff the following conditions hold:

          - _v matches the pattern _P_i;

          - the boolean expression _E_i (if present)  evaluates  to
          true in a context in which all variables declared in _P_i
          are replaced with the  corresponding  values  extracted
          from _v;

          - the state satisfies _F_i in the same context.

          If the value of _E does not match any  of  the  patterns
          _P_0, ..., _P_n, then the selection formula is true.

     "(" _F ")"

          a state of the LTS satisfies this formula iff it satis-
          fies _F.  Parentheses are useful for imposing an evalua-
          tion order of  subformulas  different  from  the  order
          given by the associativity and precedence of operators.

     An LTS satisfies a state formula _F iff its initial state  _s_0
     satisfies _F.


RRRREEEEMMMMAAAARRRRKKKKSSSS
     When writing  complex  formulas  containing  many  operators
     (especially  when  mixing regular and boolean operators), it
     is safer to use parentheses to enclose subformulas  whenever
     being  in  doubt about the relative precedence of the opera-
     tors. Otherwise, the tool may parse and evaluate the  formu-
     las  in  a way different from the user's intentions, leading
     to erroneous results that may be quite  difficult  to  track
     down.

     Not all operators defined above are primitive constructs  of
     the logic.  The boolean operators "ffffaaaallllsssseeee", "aaaannnndddd", "iiiimmmmpppplllliiiieeeessss",
     and "eeeeqqqquuuu" can be expressed in terms  of  "ttttrrrruuuueeee",  "oooorrrr",  and
     "nnnnooootttt"  in the usual way.  The diamond and box modalities are
     dual:



(C) INRIA            Last change: 2018/05/25                   34






CADP MANUAL PAGES                                     MCL4(LOCAL)



         [[[[ _R ]]]] _F   ==== nnnnooootttt <<<< _R >>>>   nnnnooootttt _F
         [[[[[[[[ _R ]]]]]]]] _F ==== nnnnooootttt <<<<<<<< _R >>>>>>>> nnnnooootttt _F

     The same holds for minimal and maximal fixed point operators
     (only parameterless versions are illustrated below):

         nnnnuuuu _Y .... _F ==== nnnnooootttt mmmmuuuu _Y .... nnnnooootttt _F ((((nnnnooootttt _Y))))

     where _F ((((nnnnooootttt _Y)))) denotes the syntactic substitution of  _Y  by
     nnnnooootttt _Y in _F.

     The infinite looping  operator  and  the  finite  saturation
     operator are opposites:

         <<<< _R >>>> @@@@   ==== nnnnooootttt [[[[ _R ]]]]   ----||||
         <<<<<<<< _R >>>>>>>> @@@@ ==== nnnnooootttt [[[[[[[[ _R ]]]]]]]] ----||||

     The modalities containing regular formulas can be translated
     in  terms  of  boolean operators, fixed point operators, and
     modalities containing only action formulas (see  [MS03,MT08]
     for details).

     The  infinite  looping  and  finite   saturation   operators
     correspond  to  fixed  point  formulas  belonging to the mu-
     calculus fragment of alternation depth two [EL86]. In  prac-
     tice,  this  means  that one can write formulas "<<<< _R >>>> @@@@" in
     which the regular subformula _R contains iteration operators.
     This  feature is supported by eeeevvvvaaaalllluuuuaaaattttoooorrrr4444, but was not avail-
     able in eeeevvvvaaaalllluuuuaaaattttoooorrrr3333, which accepted only "<<<< _R >>>>  @@@@"  formulas
     containing iteration-free regular subformulas _R.

     eeeevvvvaaaalllluuuuaaaattttoooorrrr4444 handles the equivalent fixed  point  formulations
     of  infinite  looping and saturation operators, which can be
     used directly instead of these operators:

         <<<< _R >>>> @@@@    ==== nnnnuuuu _Y .... <<<< _R >>>> _Y
         <<<<<<<< _R >>>>>>>> @@@@  ==== nnnnuuuu _Y .... <<<<<<<< _R >>>>>>>> _Y
         [[[[ _R ]]]] ----||||   ==== mmmmuuuu _Y .... [[[[ _R ]]]] _Y
         [[[[[[[[ _R ]]]]]]]] ----|||| ==== mmmmuuuu _Y .... [[[[[[[[ _R ]]]]]]]] _Y

     Moreover, in the fixed point formulas equivalent to infinite
     looping  and saturation operators, eeeevvvvaaaalllluuuuaaaattttoooorrrr4444 accepts propo-
     sitional variables _Y parameterized by data values (see FAIR-
     NESS PROPERTIES below).

     For efficiency reasons, when using fixed point operators, it
     is  recommended  to  put  the recursive call of the proposi-
     tional variable at the rightmost place in the formula (as in
     all fixed point formulas shown above). This reduces both the
     evaluation time and the size of the diagnostic generated for
     the formula.




(C) INRIA            Last change: 2018/05/25                   35






CADP MANUAL PAGES                                     MCL4(LOCAL)



     A fixed point formula "mmmmuuuu" _X "...."  _F  or  "nnnnuuuu"  _X  "...."  _F  is
     _u_n_g_u_a_r_d_e_d [Koz83] if _F contains at least one free occurrence
     of _X which is not preceded (not necessarily immediately)  by
     a modality. The evaluation of an unguarded formula on an LTS
     may yield a BES with cyclic dependencies  between  variables
     even if the LTS is acyclic.

     Note that a state formula containing regular modalities with
     nested   star  operators  may  yield  after  translation  an
     unguarded mu-calculus formula.  For example, in the  follow-
     ing formula:

         <<<< _A_1******** .... _A_2 >>>> ttttrrrruuuueeee ====
             mmmmuuuu _X_1 .... ((((<<<< _A_2 >>>> ttttrrrruuuueeee oooorrrr mmmmuuuu _X_2 .... ((((_X_1 oooorrrr <<<< _A_1 >>>> _X_2))))

     the free occurrence of _X_1 is not preceded by  any  modality,
     and hence the formula is unguarded.

     Unguarded occurrences of propositional variables can  always
     be eliminated from a mu-calculus formula, at the price of an
     increase in size [Koz83,Mat02].


EEEEXXXXAAAAMMMMPPPPLLLLEEEESSSS OOOOFFFF TTTTEEEEMMMMPPPPOOOORRRRAAAALLLL PPPPRRRROOOOPPPPEEEERRRRTTTTIIIIEEEESSSS
     _M_C_L allows to express concisely various interesting  proper-
     ties.   The  most  useful classes of temporal properties are
     illustrated below.


  SSSSAAAAFFFFEEEETTTTYYYY PPPPRRRROOOOPPPPEEEERRRRTTTTIIIIEEEESSSS
     Informally, a _s_a_f_e_t_y property specifies that "something  bad
     never happens."  Typical safety properties are those forbid-
     ding "bad" execution sequences in the LTS. These  properties
     can  be  naturally expressed using box modalities containing
     regular formulas. For  instance,  mutual  exclusion  can  be
     characterized by the following formula:

         [[[[ ttttrrrruuuueeee**** .... """"EEEENNNNTTTTEEEERRRR !!!!1111"""" .... ((((nnnnooootttt """"LLLLEEEEAAAAVVVVEEEE !!!!1111""""))))**** .... """"EEEENNNNTTTTEEEERRRR !!!!2222"""" ]]]] ffffaaaallllsssseeee

     which states that every time process 1 enters  its  critical
     section (action """"EEEENNNNTTTTEEEERRRR !!!!1111""""), it is impossible that process 2
     also enters its critical section (action """"EEEENNNNTTTTEEEERRRR !!!!2222"""")  before
     process 1 has left its critical section (action """"LLLLEEEEAAAAVVVVEEEE !!!!1111"""").

     Note that this formula does not make  any  assumption  about
     the  fact  that  a  process  enters/leaves several times its
     critical  section,  i.e.,  the  formula  does   not   forbid
     sequences  of  the  form  """"EEEENNNNTTTTEEEERRRR  !!!!1111 .... EEEENNNNTTTTEEEERRRR !!!!1111 .... LLLLEEEEAAAAVVVVEEEE !!!!1111 ....
     LLLLEEEEAAAAVVVVEEEE !!!!1111"""".

     The above formula can be made parametric w.r.t.  the  number
     of  processes  in  the  system,  by  using action predicates



(C) INRIA            Last change: 2018/05/25                   36






CADP MANUAL PAGES                                     MCL4(LOCAL)



     equipped with data variables:

         [[[[ ttttrrrruuuueeee**** .... {{{{ EEEENNNNTTTTEEEERRRR ????mmmm::::NNNNaaaatttt }}}} .... ((((nnnnooootttt {{{{ LLLLEEEEAAAAVVVVEEEE !!!!mmmm }}}}))))**** ....
           {{{{ EEEENNNNTTTTEEEERRRR ????nnnn::::NNNNaaaatttt wwwwhhhheeeerrrreeee mmmm <<<<>>>> nnnn }}}} ]]]] ffffaaaallllsssseeee

     where the values of mmmm, nnnn captured by the action predicates {{{{
     _E_N_T_E_R  ?_m:Nat  }}}}  and {{{{ _E_N_T_E_R ?_n:Nat }}}} are propagated to the
     enclosing formula in order to ensure that a process  _n  dif-
     ferent  from _m cannot enter its critical section before pro-
     cess _m has left it (action predicate {{{{ _L_E_A_V_E !_m }).

     Regular formulas equipped with  counters  provide  a  useful
     means  for  describing  safety properties depending on data.
     The formula below expresses (part of) the  safety  of  a  _n-
     place buffer:

         [[[[ ((((IIIINNNNPPPPUUUUTTTT .... ((((nnnnooootttt OOOOUUUUTTTTPPPPUUUUTTTT))))****)))) {{{{ nnnn ++++ 1111 }}}} ]]]] ffffaaaallllsssseeee

     by forbidding the existence of a  sequence  containing  more
     than  _n  insertions of elements in the buffer (action _I_N_P_U_T)
     without any deletions of elements in  between  (action  _O_U_T_-
     _P_U_T).

     A more precise formulation of  the  above  property  can  be
     obtained  by using a fixed point operator parameterized by a
     counter _c, which stores the number of elements (initially 0)
     currently present in the buffer:

         nnnnuuuu BBBBuuuuffffffffeeeerrrr ((((cccc::::NNNNaaaatttt ::::==== 0000)))) .... ((((
             [[[[ IIIINNNNPPPPUUUUTTTT ]]]] ((((((((cccc <<<< nnnn)))) aaaannnndddd BBBBuuuuffffffffeeeerrrr ((((cccc ++++ 1111))))))))
             aaaannnndddd
             [[[[ OOOOUUUUTTTTPPPPUUUUTTTT ]]]] ((((((((cccc >>>> 0000)))) aaaannnndddd BBBBuuuuffffffffeeeerrrr ((((cccc ---- 1111))))))))
             aaaannnndddd
             [[[[ nnnnooootttt ((((IIIINNNNPPPPUUUUTTTT oooorrrr OOOOUUUUTTTTPPPPUUUUTTTT)))) ]]]] BBBBuuuuffffffffeeeerrrr ((((cccc))))
         ))))

     The number of elements _c in  the  buffer  is  equal  to  the
     difference  between  the  number  of  elements  inserted and
     deleted from the buffer, and for a  _n-place  buffer  _c  must
     belong to 0.._n.

     Other typical safety properties are the _i_n_v_a_r_i_a_n_t_s, express-
     ing  that  every state of the LTS satisfies some "good" pro-
     perty. For example, deadlock freedom can be expressed by the
     formula below:

         [[[[ ttttrrrruuuueeee**** ]]]] <<<< ttttrrrruuuueeee >>>> ttttrrrruuuueeee

     stating that every state has at least one successor.  Alter-
     nately, this formula may be expressed directly using a fixed
     point operator:




(C) INRIA            Last change: 2018/05/25                   37






CADP MANUAL PAGES                                     MCL4(LOCAL)



         nnnnuuuu _X .... ((((<<<< ttttrrrruuuueeee >>>> ttttrrrruuuueeee aaaannnndddd [[[[ ttttrrrruuuueeee ]]]] _X))))

     but less concisely than by using a regular formula.

     The "nnnnaaaattttsssseeeetttt" type is useful for expressing the occurrence of
     a  set  of actions in any order. For instance, the fact that
     natural numbers inserted in a bag (initially empty)  can  be
     retrieved  in  any order can be expressed by the _M_C_L formula
     below:

         nnnnuuuu BBBBaaaagggg ((((bbbb::::NNNNaaaattttSSSSeeeetttt ::::==== eeeemmmmppppttttyyyy)))) .... ((((
             [[[[ {{{{ PPPPUUUUTTTT ????nnnn::::nnnnaaaatttt }}}} ]]]] BBBBaaaagggg ((((iiiinnnnsssseeeerrrrtttt ((((nnnn,,,, bbbb))))))))
             aaaannnndddd
             [[[[ {{{{ GGGGEEEETTTT ????nnnn::::nnnnaaaatttt }}}} ]]]] ((((((((nnnn iiiissssiiiinnnn bbbb)))) aaaannnndddd BBBBaaaagggg ((((rrrreeeemmmmoooovvvveeee ((((nnnn,,,, bbbb))))))))))))
             aaaannnndddd
             [[[[ nnnnooootttt (((({{{{ PPPPUUUUTTTT ............ }}}} oooorrrr {{{{ GGGGEEEETTTT ............ }}}})))) ]]]] BBBBaaaagggg ((((bbbb))))
         ))))

     Here the action predicates {{{{ _P_U_T ?_n:Nat }}}} and {{{{ _G_E_T ?_n:Nat }}}}
     denote  the  insertion  and  retrieval  of  a natural number
     into/from the bag, respectively.


  LLLLIIIIVVVVEEEENNNNEEEESSSSSSSS PPPPRRRROOOOPPPPEEEERRRRTTTTIIIIEEEESSSS
     Informally, a _l_i_v_e_n_e_s_s property  specifies  that  "something
     good  eventually  happens."  Typical liveness properties are
     _p_o_t_e_n_t_i_a_l_i_t_y assertions (i.e., expressing  the  reachability
     on  a sequence) and _i_n_e_v_i_t_a_b_i_l_i_t_y assertions (i.e., express-
     ing the reachability on all sequences).

     Potentiality assertions can be directly expressed using dia-
     mond  modalities containing regular formulas.  For instance,
     the following formula:

         <<<< ttttrrrruuuueeee**** .... {{{{ PPPPUUUUTTTT ????nnnn::::NNNNaaaatttt }}}} .... ttttrrrruuuueeee**** .... {{{{ GGGGEEEETTTT !!!!nnnn }}}} >>>> ttttrrrruuuueeee

     states that there exists a sequence that passes (after 0  or
     more  transitions)  through  a _P_U_T _n action for some natural
     number _n, and then leads (after 0 or more transitions) to  a
     _G_E_T _n action.

     Regular formulas allow to express succinctly complex  poten-
     tiality assertions, such as the formula below:

         <<<< ttttrrrruuuueeee**** .... SSSSEEEENNNNDDDD .... ((((ttttrrrruuuueeee**** .... RRRREEEETTTTRRRRYYYY)))) {{{{ 0000 ............ mmmmaaaaxxxx }}}} ....
           ttttrrrruuuueeee**** .... RRRREEEECCCCVVVV >>>> ttttrrrruuuueeee

     stating that there exists a sequence  leading  (after  0  or
     more  transitions)  to a _S_E_N_D action, possibly followed by a
     sequence of at most _m_a_x _R_E_T_R_Y actions (possibly separated by
     other  actions) and leading (after 0 or more transitions) to
     a _R_E_C_V action.



(C) INRIA            Last change: 2018/05/25                   38






CADP MANUAL PAGES                                     MCL4(LOCAL)



     Inevitability assertions can be expressed using fixed  point
     operators.  For instance, the following formula:

         mmmmuuuu _X .... ((((<<<< ttttrrrruuuueeee >>>> ttttrrrruuuueeee aaaannnndddd [[[[ nnnnooootttt SSSSTTTTAAAARRRRTTTT ]]]] _X))))

     states that all transition sequences starting at the current
     state lead to _S_T_A_R_T actions after a finite number of steps.

     Similarly, temporal properties containing  both  safety  and
     liveness  aspects  can be expressed by combining box modali-
     ties and inevitability operators.  For example, the _r_e_s_p_o_n_s_e
     property  stating  that  every emission of a message must be
     inevitably followed in the future by the  reception  of  the
     same message can be expressed by the _M_C_L formula below:

         [[[[ ttttrrrruuuueeee**** .... {{{{ SSSSEEEENNNNDDDD ????nnnn::::NNNNaaaatttt }}}} ]]]]
             mmmmuuuu _X .... ((((<<<< ttttrrrruuuueeee >>>> ttttrrrruuuueeee aaaannnndddd [[[[ nnnnooootttt {{{{ RRRREEEECCCCVVVV !!!!nnnn }}}} ]]]] _X))))

     Note how variable _n is assigned in the box modality by  cap-
     turing  the value of a message sent (action predicate {{{{ _S_E_N_D
     ?_n:Nat }}}}) and is used later in the body of the  fixed  point
     formula (action predicate {{{{ _R_E_C_V !_n }}}}).


  FFFFAAAAIIIIRRRRNNNNEEEESSSSSSSS PPPPRRRROOOOPPPPEEEERRRRTTTTIIIIEEEESSSS
     These are similar to liveness properties, except  that  they
     express  reachability  of  actions  by considering only _f_a_i_r
     execution sequences. One simple notion of fairness that  can
     be easily encoded in _M_C_L is the "fair reachability of predi-
     cates" defined by Queille and Sifakis [QS83]: a sequence  is
     fair  iff it does not infinitely often enable the reachabil-
     ity of a certain state without infinitely often reaching it.
     For  instance,  the  following  formula specifies that after
     every message emission (action  SEND),  all  fair  execution
     sequences  will lead to the reception of the message (action
     RECV) after a finite number of steps:

         [[[[ ttttrrrruuuueeee**** .... SSSSEEEENNNNDDDD .... ((((nnnnooootttt RRRREEEECCCCVVVV))))**** ]]]] <<<< ((((nnnnooootttt RRRREEEECCCCVVVV))))**** .... RRRREEEECCCCVVVV >>>> ttttrrrruuuueeee

     Intuitively, the formula above considers the sequences  fol-
     lowing the _S_E_N_D action by "skipping" the circuits of the LTS
     that do not contain _R_E_C_V actions: it states that from  every
     state  of  such  a circuit, there is still a finite sequence
     leading to a _R_E_C_V action.

     More elaborated forms of fairness can be expressed by speci-
     fying  the  absence of _u_n_f_a_i_r execution sequences, which can
     be characterized using the infinite  looping  operator.  For
     example,  the formula _M_C_L below expresses that after process
     _i has requested access to a resource, it cannot be  indefin-
     itely preempted by another process _j:




(C) INRIA            Last change: 2018/05/25                   39






CADP MANUAL PAGES                                     MCL4(LOCAL)



         [[[[ ttttrrrruuuueeee**** .... {{{{ RRRREEEEQQQQUUUUEEEESSSSTTTT ????iiii::::NNNNaaaatttt }}}} ]]]]
           nnnnooootttt <<<< ((((nnnnooootttt {{{{ GGGGRRRRAAAANNNNTTTT !!!!iiii }}}}))))**** .... {{{{ RRRREEEEQQQQUUUUEEEESSSSTTTT ????jjjj::::NNNNaaaatttt wwwwhhhheeeerrrreeee jjjj <<<<>>>> iiii }}}} ....
                 ((((nnnnooootttt {{{{ GGGGRRRRAAAANNNNTTTT !!!!iiii }}}}))))**** .... {{{{ GGGGRRRRAAAANNNNTTTT !!!!jjjj }}}} >>>> @@@@

     This formula can be expressed more concisely by  propagating
     the  negation  in front of the infinite looping operator and
     using the saturation operator:

         [[[[ ttttrrrruuuueeee**** .... {{{{ RRRREEEEQQQQUUUUEEEESSSSTTTT ????iiii::::NNNNaaaatttt }}}} ]]]]
           [[[[ ((((nnnnooootttt {{{{ GGGGRRRRAAAANNNNTTTT !!!!iiii }}}}))))**** .... {{{{ RRRREEEEQQQQUUUUEEEESSSSTTTT ????jjjj::::NNNNaaaatttt wwwwhhhheeeerrrreeee jjjj <<<<>>>> iiii }}}} ....
             ((((nnnnooootttt {{{{ GGGGRRRRAAAANNNNTTTT !!!!iiii }}}}))))**** .... {{{{ GGGGRRRRAAAANNNNTTTT !!!!jjjj }}}} ]]]] ----||||

     The existence of complex cycles can be specified  using  the
     fixed point formulation of the infinite looping operator, in
     which the propositional variable has  data  parameters.  The
     formula  below  expresses  the existence of a cycle on which
     the pairs emission-reception of  messages  nnnn====0000........4444  occur  in
     this order:
         nnnnuuuu _Y ((((nnnn::::NNNNaaaatttt ::::==== 0000)))) ....
           <<<< ttttrrrruuuueeee**** .... {{{{ PPPPUUUUTTTT !!!!nnnn }}}} .... ttttrrrruuuueeee**** .... {{{{ GGGGEEEETTTT !!!!nnnn }}}} >>>>
             _Y ((((((((nnnn ++++ 1111)))) %%%% 5555))))

     Other, more elaborated examples of fairness  properties  can
     be found in [MT08,MS10].


  AAAACCCCTTTTIIIIOOOONNNN PPPPRRRREEEEDDDDIIIICCCCAAAATTTTEEEESSSS
     The use of action formulas (and, in particular, of  regexps)
     may be of considerable help when dealing with actions having
     the same gate  but  different  values  in  the  offers.  For
     instance, the following formula:

         <<<< ttttrrrruuuueeee**** .... ''''SSSSEEEENNNNDDDD !!!!1111....****'''' aaaannnndddd nnnnooootttt ''''SSSSEEEENNNNDDDD !!!!1111....****!!!!2222....****'''' >>>> ttttrrrruuuueeee

     states the potential reachability of an  action  having  the
     gate  _S_E_N_D  followed  by  the  value 1, possibly followed by
     other values different from 2.

     Moreover, action formulas combined with modalities allow  to
     express  invariants over actions (i.e., action formulas that
     must be satisfied by all transition labels of the LTS).  For
     instance, the following formula:

         [[[[ ttttrrrruuuueeee**** .... {{{{ RRRREEEECCCCVVVV ????ssssrrrrcccc::::NNNNaaaatttt ????ddddeeeesssstttt::::NNNNaaaatttt wwwwhhhheeeerrrreeee ssssrrrrcccc <<<<>>>> ddddeeeesssstttt }}}} ]]]] ffffaaaallllsssseeee

     states that all message receptions have different source and
     destination fields. Another way of formulating this property
     is by using regexps on character strings:

         [[[[ ttttrrrruuuueeee**** ....
           nnnnooootttt ((((''''RRRREEEECCCCVVVV !!!!....**** !!!!....****'''' aaaannnndddd ''''RRRREEEECCCCVVVV !!!!\\\\((((....****\\\\)))) !!!!\\\\1111''''))))
         ]]]] ffffaaaallllsssseeee



(C) INRIA            Last change: 2018/05/25                   40






CADP MANUAL PAGES                                     MCL4(LOCAL)



     Note the use of the UNIX regular  expression  construct  `\\\\((((
     \\\\))))'  allowing to match a portion of a string and to reuse it
     later in the same regexp.


MMMMAAAACCCCRRRROOOOSSSS AAAANNNNDDDD LLLLIIIIBBBBRRRRAAAARRRRIIIIEEEESSSS
     _e_v_a_l_u_a_t_o_r_4 allows to define  and  use  macros  for  temporal
     operators  parameterized  by  action  and/or state formulas.
     This feature is particularly useful for  constructing  reus-
     able  libraries encoding various temporal operators of other
     logics translatable in regular alternation-free  mu-calculus
     (like  CTL and ACTL). The _m_a_c_r_o-_d_e_f_i_n_i_t_i_o_n_s have the follow-
     ing syntax:

         """"mmmmaaaaccccrrrroooo"""" _M """"(((("""" _P_1"""",,,,"""" ............"""",,,,"""" _P_n """"))))"""" """"====""""
             <_t_e_x_t>
         """"eeeennnndddd____mmmmaaaaccccrrrroooo""""

     The above construct defines a macro _M having the  parameters
     _P_1,  ...,  _P_n  and  the  body  <_t_e_x_t>,  which is a string of
     alpha-numeric characters (normally)  containing  occurrences
     of  the  parameters  _P_1, ..., _P_n. For example, the following
     macro-definition:

         mmmmaaaaccccrrrroooo EEEEUUUU____AAAA ((((_F_1,,,, _A,,,, _F_2)))) ====
             mmmmuuuu _X .... ((((((((_F_2)))) oooorrrr ((((((((_F_1)))) aaaannnndddd <<<< _A >>>> _X))))))))
         eeeennnndddd____mmmmaaaaccccrrrroooo

     encodes the "Exists Until" operator of  ACTL,  which  states
     that  there  exists  a  sequence of transitions leading to a
     state  satisfying  F2  such  that  all  intermediate  states
     satisfy F1 and all intermediate labels satisfy A.

     The calls of a macro _M have the following form:

         _M """"(((("""" <_t_e_x_t_1>"""",,,,"""" ............"""",,,,"""" <_t_e_x_t_n> """"))))""""

     where the arguments <_t_e_x_t_1>, ..., <_t_e_x_t_n> are  strings.  The
     result  of  the  call  is  the body <text> of the macro _M in
     which all occurrences of the parameters _P_i have been syntac-
     tically  substituted  with  the arguments <_t_e_x_t_i>, for all i
     between 1 and n. For example, the following call:

         EEEEUUUU____AAAA ((((ttttrrrruuuueeee,,,, nnnnooootttt """"SSSSEEEENNNNDDDD"""",,,, <<<< """"RRRREEEECCCCVVVV"""" >>>> ttttrrrruuuueeee))))

     expands into the formula below:

         mmmmuuuu _X .... ((((((((<<<< """"RRRREEEECCCCVVVV"""" >>>> ttttrrrruuuueeee)))) oooorrrr ((((((((ttttrrrruuuueeee)))) aaaannnndddd <<<< nnnnooootttt """"SSSSEEEENNNNDDDD"""" >>>> _X))))))))

     A macro is visible from the point of  its  definition  until
     the  end  of  the formula. Macros may be overloaded: several
     macros with the same name, but  different  arities,  may  be



(C) INRIA            Last change: 2018/05/25                   41






CADP MANUAL PAGES                                     MCL4(LOCAL)



     defined in the same scope.

     Various macro-definitions (typically encoding the  operators
     of some particular temporal logic) can be grouped into files
     called _l_i_b_r_a_r_i_e_s. These files may be included in the  source
     program using the following command:

         """"lllliiiibbbbrrrraaaarrrryyyy""""
             <<<<_f_i_l_e_0....mmmmccccllll>>>>"""",,,,"""" ............"""",,,,"""" <<<<_f_i_l_e_n....mmmmccccllll>>>>
         """"eeeennnndddd____lllliiiibbbbrrrraaaarrrryyyy""""

     At the compilation of the program, the  above  construct  is
     syntactically  replaced  with  the  contents  of  the  files
     <_f_i_l_e_0....mmmmccccllll>, ..., <_f_i_l_e_n....mmmmccccllll>, placed one after the other in
     this order. For example, the following command:

         lllliiiibbbbrrrraaaarrrryyyy _a_c_t_l....mmmmccccllll eeeennnndddd____lllliiiibbbbrrrraaaarrrryyyy

     is syntactically replaced with  the  contents  of  the  file
     _a_c_t_l....mmmmccccllll,,,, which implements the ACTL operators.

     The included files are searched first in the current  direc-
     tory,  then  in  the  directory referenced by $CADP/src/xtl.
     Multiple inclusions of the same file are silently discarded.


EEEEXXXXPPPPRRRREEEESSSSSSSSIIIIVVVVEEEENNNNEEEESSSSSSSS
     _M_C_L  enables  direct  and  succinct  encodings   of   "pure"
     branching-time  logics  like  _C_T_L  (Computation  Tree Logic)
     [CES86] or _A_C_T_L (Action-based CTL) [DV90],  as  well  as  of
     regular logics like _P_D_L (Propositional Dynamic Logic) [FL79]
     or _P_D_L-_d_e_l_t_a [Str82].

     The infinite looping operator, whenever it is applied  to  a
     regular  subformula  containing iteration operators, belongs
     to the mu-calculus fragment of alternation depth two [EL86].
     It  is able to express the existence of complex cycles (con-
     taining regular sub-sequences) in the LTS, which  cannot  be
     expressed  using  the  other  operators  of _M_C_L because they
     belong to the alternation-free fragment  of  the  modal  mu-
     calculus.   In particular, the infinite looping operator can
     express the existence of accepting cycles in Büchi automata,
     which underlies the classical verification procedure for _L_T_L
     (Linear Time Logic) [CGP00].

     Therefore, _M_C_L strictly subsumes both  _C_T_L  and  _L_T_L,  since
     these  two logics are not comparable w.r.t. their expressive
     power (each of them is able to express properties  that  the
     other  one  cannot).   _M_C_L  also syntactically subsumes _P_D_L-
     _d_e_l_t_a, which was shown  to  be  more  expressive  than  _C_T_L*
     [Wol82].




(C) INRIA            Last change: 2018/05/25                   42






CADP MANUAL PAGES                                     MCL4(LOCAL)



     When dealing with finite state LTS models, the  presence  of
     data-handling   constructs   does  not,  strictly  speaking,
     increase the expressiveness of _M_C_L because one  can  instan-
     tiate  all parameters present in an _M_C_L formula based on the
     finite set of values contained in the transition  labels  of
     the  LTS.  However, in practice the data-handling constructs
     lead to significant simplifications and reductions  in  size
     of   the   formulas,  thus  facilitating  the  specification
     activity and reducing the risk of errors.


MMMMOOOODDDDEEEELLLL CCCCHHHHEEEECCCCKKKKIIIINNNNGGGG CCCCOOOOMMMMPPPPLLLLEEEEXXXXIIIITTTTYYYY
     The dataless part of _M_C_L has an efficient  on-the-fly  model
     checking  algorithm, with a space and time complexity linear
     in the size of the formula (number  of  operators)  and  the
     size  of  the  LTS model (number of states and transitions).
     Despite the fact that it belongs to the mu-calculus fragment
     of   alternation   depth  two  (which  has  theoretically  a
     quadratic-time model checking complexity [EL86]), the infin-
     ite  looping  operator can be evaluated in linear-time using
     the algorithm proposed in [MT08].  The evaluation of _C_T_L and
     _P_D_L-_d_e_l_t_a operators, which cover the quasi-totality of prac-
     tical needs, stores in memory only the states, and  not  the
     transitions of the LTS.

     Note: The linear-time model checking complexity obtained for
     _P_D_L-_d_e_l_t_a  does  not imply a similar result for _L_T_L or _C_T_L*,
     since the translations of these logics in _P_D_L-_d_e_l_t_a are  not
     guaranteed to be succinct.

     The evaluation of fixed points having parameters of infinite
     types  (e.g., nnnnaaaatttt, ssssttttrrrriiiinnnngggg, etc.) may diverge when the number
     of fixed point variable instances is unbounded.   Therefore,
     parameterized fixed points should be used with the same care
     as recursive functions in programming languages  (note  how-
     ever  that  cycles _Y (_v_0, ..., _v_n) -> ... -> _Y (_v_0, ..., _v_n)
     do no harm,  since  BES  resolution  algorithms  can  handle
     cyclic  dependencies  between  variables). The evaluation of
     all  extended  regular  operators  involving   counters   is
     guaranteed  to  converge, because it always creates a finite
     number of fixed point variable  instances,  bounded  by  the
     values of counters and/or the number of LTS states.


BBBBIIIIBBBBLLLLIIIIOOOOGGGGRRRRAAAAPPPPHHHHYYYY
     [CES86]
          E.  M.  Clarke,  E.  A.  Emerson,  and  A.  P.  Sistla.
          "Automatic Verification of Finite-State Concurrent Sys-
          tems using Temporal Logic Specifications." ACM Transac-
          tions  on  Programming Languages and Systems, v. 8, no.
          2, p. 244-263, 1986.




(C) INRIA            Last change: 2018/05/25                   43






CADP MANUAL PAGES                                     MCL4(LOCAL)



     [CGP00]
          E. M. Clarke, O. Grumberg, and D. Peled.  "Model Check-
          ing." MIT Press, 2000.


     [DV90]
          R. De Nicola and  F.  W.  Vaandrager.   "Action  versus
          State  based  Logics for Transition Systems."  Proceed-
          ings Ecole de Printemps on  Semantics  of  Concurrency,
          LNCS v. 469, p. 407-419, 1990.


     [EL86]
          E. A. Emerson and C-L. Lei.  "Efficient Model  Checking
          in   Fragments   of   the  Propositional  Mu-Calculus."
          Proceedings of the 1st LICS, p. 267-278, 1986.


     [FL79]
          M. J. Fischer and R. E. Ladner.  "Propositional Dynamic
          Logic  of  Regular  Programs."  Journal of Computer and
          System Sciences, no. 18, p. 194-211, 1979.


     [Gar89]
          H. Garavel. Chapter 9 of "Compilation  et  verification
          de  programmes  LOTOS."  PhD thesis, Universite Joseph-
          Fourier     Grenoble,     1989.      Available     from
          http://cadp.inria.fr/publications/Garavel-89-b.html


     [Koz83]
          D. Kozen.  "Results on the Propositional  Mu-Calculus."
          Theoretical Computer Science, v. 27, p. 333-354, 1983.


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




(C) INRIA            Last change: 2018/05/25                   44






CADP MANUAL PAGES                                     MCL4(LOCAL)



     [Mat02]
          R.  Mateescu.   "Local  Model-Checking  of  Modal   Mu-
          Calculus   on   Acyclic  Labeled  Transition  Systems".
          Proceedings of  the  8th  International  Conference  on
          Tools  and Algorithms for the Construction and Analysis
          of Systems TACAS'02, LNCS v. 2280,  p.  281-295,  2002.
          Full  version  available  as  INRIA Research Report RR-
          4430.                   Available                  from
          http://cadp.inria.fr/publications/Mateescu-02.html


     [Mat06]
          R. Mateescu.  "CAESAR_SOLVE: A Generic Library for  On-
          the-Fly Resolution of Alternation-Free Boolean Equation
          Systems."  Springer International Journal  on  Software
          Tools  for  Technology Transfer (STTT), v. 8, no. 1, p.
          37-56, 2006. Full version available as  INRIA  Research
          Report         RR-5948.          Available         from
          http://cadp.inria.fr/publications/Mateescu-06-a.html


     [MS03]
          R. Mateescu and M. Sighireanu.   "Efficient  On-the-Fly
          Model-Checking   for   Regular   Alternation-Free   Mu-
          Calculus."  Science of Computer Programming, v. 46, no.
          3,     p.     255-281,     2003.      Available    from
          http://cadp.inria.fr/publications/Mateescu-Sighireanu-
          03.html


     [MS10]
          R. Mateescu and W. Serwe.  "A  Study  of  Shared-Memory
          Mutual Exclusion Protocols using CADP."  Proceedings of
          the 15th International Workshop on Formal  Methods  for
          Industrial  Critical Systems FMICS'10, LNCS v. 6371, p.
          180-197,         2010.          Available          from
          http://cadp.inria.fr/publications/Mateescu-Serwe-
          10.html


     [MT08]
          R.  Mateescu  and  D.  Thivolle.   "A  Model   Checking
          Language   for   Concurrent   Value-Passing   Systems."
          Proceedings of the 15th International Symposium on For-
          mal  Methods  FM'08,  LNCS  v.  5014, p. 148-164, 2008.
          Available                                          from
          http://cadp.inria.fr/publications/Mateescu-Thivolle-
          08.html


     [QS83]
          J-P. Queille and J.  Sifakis.   "Fairness  and  Related



(C) INRIA            Last change: 2018/05/25                   45






CADP MANUAL PAGES                                     MCL4(LOCAL)



          Properties  in Transition Systems - A Temporal Logic to
          Deal with Fairness."  Acta Informatica, v. 19, p.  195-
          220, 1983.


     [Str82]
          R. S. Streett.  "Propositional Dynamic Logic of Looping
          and  Converse."   Information  and  Control,  v. 54, p.
          121-141, 1982.


     [Wol82]
          P. Wolper.  "A Translation  from  Full  Branching  Time
          Temporal  Logic  to  One  Letter  Propositional Dynamic
          Logic with Looping."  Unpublished manuscript, 1982.


SSSSEEEEEEEE AAAALLLLSSSSOOOO
     eeeevvvvaaaalllluuuuaaaattttoooorrrr(LOCAL),   eeeevvvvaaaalllluuuuaaaattttoooorrrr3333(LOCAL),    eeeevvvvaaaalllluuuuaaaattttoooorrrr4444(LOCAL),
     mmmmccccllll(LOCAL), mmmmccccllll3333(LOCAL), rrrreeeeggggeeeexxxxpppp(LOCAL)

     Additional information is available from the CADP  Web  page
     located at http://cadp.inria.fr

     Directives   for   installation   are   given    in    files
     $$$$CCCCAAAADDDDPPPP////IIIINNNNSSSSTTTTAAAALLLLLLLLAAAATTTTIIIIOOOONNNN____****.

     Recent  changes  and  improvements  to  this  software   are
     reported and commented in file $$$$CCCCAAAADDDDPPPP////HHHHIIIISSSSTTTTOOOORRRRYYYY.


BBBBUUUUGGGGSSSS
     Please report bugs to Radu.Mateescu@inria.fr






















(C) INRIA            Last change: 2018/05/25                   46



