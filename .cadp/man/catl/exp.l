


CADP MANUAL PAGES                                      EXP(LOCAL)



NNNNAAAAMMMMEEEE
     exp, EXP - language for describing networks of communicating
     automata


DDDDEEEESSSSCCCCRRRRIIIIPPPPTTTTIIIIOOOONNNN
     This manual page presents EXP 2.0, which is  a  conservative
     extension  of  a  previous  version EXP 1.0.  EXP 2.0 allows
     networks of communicating automata (also  called  _b_e_h_a_v_i_o_u_r_s
     in  the  sequel)  to  be modelled using operators of several
     languages.

     In addition to LOTOS parallel composition and  hiding  [ISO-
     89], already implemented in EXP 1.0, EXP 2.0 contains opera-
     tors taken from E-LOTOS [ISO-01] and LNT,  CCS  [Milner-89],
     CSP  [Brookes-Hoare-Roscoe-84],  and mCRL [Groote-Ponse-90],
     as well as parallel composition using  synchronisation  vec-
     tors,  and generalized operators for label hiding, renaming,
     and cutting (also called restriction in CCS or encapsulation
     in  mCRL).   EXP2.0  also  contains a priority operator that
     allows priorities between transitions to be defined.

     Since these operators are taken from various languages  that
     are not always compatible (for instance, the hidden event is
     written "i" in LOTOS, E-LOTOS, and LNT, "t" in CCS and  CSP,
     "tau"  in mCRL), eeeexxxxpppp....ooooppppeeeennnn allows the graph module to be cus-
     tomized with respect to a particular  language  (called  the
     _r_e_f_e_r_e_n_c_e _l_a_n_g_u_a_g_e).

     The customization operates on the following parameters:


     -    The string representing hidden events.


     -    The  string  representing  the  gate  used  to  express
          behaviour  termination (e.g., "exit" in LOTOS, E-LOTOS,
          and LNT, "delta" in CSP, irrelevant in CCS and mCRL).


     -    Case sensitivity, i.e., whether labels in the EXP  file
          should be turned to upper-case or not.


     -    The meaning of symbols existing in different  languages
          with  different  semantics ("\" in CCS and CSP, "||" in
          LOTOS and mCRL).

     See eeeexxxxpppp....ooooppppeeeennnn(LOCAL) for options  enabling  a  definition  of
     these  parameters.  When these options are not used, default
     values are associated to each of these parameters, depending
     on   the   reference   language   selected.   For   backward



(C) INRIA            Last change: 2020/02/11                    1






CADP MANUAL PAGES                                      EXP(LOCAL)



     compatibility  reasons,  there  is  no  reference   language
     selected  by  default.  See  Section LANGUAGE PARAMETERS for
     details.

     Beware that the aaaallllddddeeeebbbbaaaarrrraaaannnn(LOCAL) tool only  works  with  EXP
     1.0  descriptions  and  that  the eeeexxxxpppp2222ffffcccc2222 tool is now depre-
     cated.


     The publication [Lang-05] provides an overview  of  eeeexxxxpppp....ooooppppeeeennnn
     2.0 and its input language.


SSSSYYYYNNNNTTTTAAAAXXXX OOOOFFFF EEEEXXXXPPPP 2222....0000
     The syntax of EXP 2.0 is presented using a  grammar  in  the
     Extended Backus-Naur Form (EBNF):


     -    Non-terminal symbols are written using capital  letters
          (e.g., _B).


     -    Keywords are written using lowercase characters  (e.g.,
          hide, par, in, etc.).


     -    Key symbols are written between double quotes to  avoid
          ambiguities with EBNF symbols (in particular, "|", "(",
          "[", "*", etc.). However, the quotes may be omitted for
          non-ambiguous symbols (",", "<-", etc.)


     -    Definitions in natural language are enclosed in  angles
          (e.g., <filename>).


     -    Optional  sequences  of  symbols  are  written  between
          square brackets.


     -    Star (*) denotes repetition zero or more times  of  the
          preceding EBNF expression.


     -    Plus (+) denotes repetition one or more  times  of  the
          preceding EBNF expression.


     -    Operators * and  +  have  precedence  over  other  EBNF
          operators.  Parentheses are used to associate sequences
          of symbols (e.g., "_G (, _G)*").




(C) INRIA            Last change: 2020/02/11                    2






CADP MANUAL PAGES                                      EXP(LOCAL)



     The  EXP  2.0  grammar  is  presented  in   several   parts,
     corresponding  to  the  different  languages  supported.  We
     write "_B ::= ... | _e_x_p_r_e_s_s_i_o_n" to express that  the  defini-
     tion  of  _B is extended with _e_x_p_r_e_s_s_i_o_n.  The entry point of
     the grammar is the non-terminal symbol _A_X_I_O_M.

     The following productions are common to all languages.   _I_D_F
     stands  for any sequence of letters, digits, and underscores
     ("_"), which begins with a letter and does not end  with  an
     underscore.   _L_T_S  stands for files containing an automaton,
     _F_I_L_E for other files, _G for gates, _G_L for gate lists, _L  for
     labels, and _L_L for label lists.

     Comments of the form
         (* <any text on one or several lines> *)
     and
         -- <any text on one line>
     are allowed in EXP 2.0 behaviours.

     _L_T_S ::= "<filename>"
          | _I_D_F                 (* automaton without extension *)
          | "<filename>.bcg"
          | _I_D_F.bcg             (* automaton in BCG format *)
          | "<filename>.aut"
          | _I_D_F.aut             (* automaton in AUT format *)
          | "<filename>.seq"
          | _I_D_F.seq             (* automaton in SEQ format *)
          | "<filename>.fc2
          | _I_D_F.fc2             (* automaton in FC2 format *)
          | "<filename>.exp"    (* include file in EXP format *)

     _F_I_L_E ::= "<filename>"
           | _I_D_F                (* file without extension *)
           | "<filename>(.hid|.hide)"
           | _I_D_F(.hid|.hide)    (* hide file *)
           | "<filename>(.ren|.rename)"
           | _I_D_F(.ren|.rename)  (* rename file *)
           | "<filename>.cut"
           | _I_D_F.cut            (* cut file *)

     _G ::= _I_D_F                  (* gate *)
        |  "<string denoting a gate>"

     _G_L ::= [_G (, _G)*]          (* gate list *)

     _L ::= _G                    (* label *)
        |  "<gate with offers>"
        |  "<regular expression denoting a gate>"
        |  "<regular expression denoting a gate with offers>"

     _L_L ::= [_L (, _L)*]          (* label list *)




(C) INRIA            Last change: 2020/02/11                    3






CADP MANUAL PAGES                                      EXP(LOCAL)



     Note that _L can be a gate, or a gate followed by  experiment
     offers,  or  a  regular  expression denoting a gate possibly
     followed by experiment offers.  (See the definition of regu-
     lar expressions in the rrrreeeeggggeeeexxxxpppp(LOCAL) man page.)  The gate of
     a label _L is the sub-string starting at the beginning  of  _L
     and ending at the first character !, ?, (, space, or tabula-
     tion, if any, or at the end of _L otherwise.

     For instance, "G", "G.*", "G  !1",  "G(1)",  "G.*  !.*"  are
     labels,  among  which  "G"  is  a  gate,  "G.*" is a regular
     expression denoting a gate or a gate with offers, "G !1"  is
     a  gate  with  offers, and "G.* !.*" is a regular expression
     denoting a gate with offers (following LOTOS  syntax).  Note
     that  the syntax of offers is not restricted to LOTOS: "G(1,
     2)" also denotes a gate with offers.

     Double quotes around a label can be omitted if and  only  if
     the  label  is a gate satisfying the syntax of _I_D_F, but they
     are mandatory to avoid syntactic ambiguities when a gate has
     the  same name as a reserved EXP keyword (e.g. "cut", "all",
     etc.) or when a label contains special characters.

     Note: all escape character sequences defined in the specifi-
     cation  of ANSI C character constants, except octal numbers,
     hexadecimal numbers, and '\n', are  allowed  in  labels  and
     filenames enclosed in double quotes.  These escape character
     sequences are replaced by a  single  character  accordingly.
     Every '\' character that does not belong to an ANSI C escape
     character sequence is kept unchanged.   For  instance,  '\"'
     and  '\\'  are replaced respectively by '"' and '\', whereas
     '\p' and '\(' are kept unchanged.


  LLLLOOOOTTTTOOOOSSSS OOOOPPPPEEEERRRRAAAATTTTOOOORRRRSSSS
     _A_X_I_O_M ::= [[lotos] (behaviour | behavior)] _B

     _B ::= _L_T_S
        |  hide _G_L in _B
        |  _B "||" _B
        |  _B "|||" _B
        |  _B "|[" _G_L "]|" _B
        |  (_B)

     Note that the LOTOS syntax corresponds exactly to  EXP  1.0,
     except the "lotos" keyword, which was absent in EXP 1.0.  In
     EXP 2.0, LOTOS operators are subsumed by E-LOTOS/LNT  opera-
     tors,  but they are kept for backward compatibility with EXP
     1.0.


  EEEE----LLLLOOOOTTTTOOOOSSSS////LLLLNNNNTTTT OOOOPPPPEEEERRRRAAAATTTTOOOORRRRSSSS
     _A_X_I_O_M ::= ...



(C) INRIA            Last change: 2020/02/11                    4






CADP MANUAL PAGES                                      EXP(LOCAL)



            |  [[elotos] (behaviour | behavior)] _B

     _B ::= ...

        |  [gate | total | partial] hide
           ([all but] _L_L | using _F_I_L_E) in _B end hide

        |  [gate | total | single | multiple] rename
           (_L -> _L (, _L -> _L)* | using _F_I_L_E) in _B
           end rename

        | [gate | label] par [(all | _S) in]
          [_S ->] _B ("||" [_S ->] _B)+ end par

     _S ::= [_L [# _N] (, _L [# _N])*]

     _N ::= <natural number>


  CCCCCCCCSSSS OOOOPPPPEEEERRRRAAAATTTTOOOORRRRSSSS
     _A_X_I_O_M ::= ...
            |  [[ccs] (behaviour | behavior)] _B

     _B ::= ...
        |  _B "|" _B
        |  _B \ _L
        |  _B \ "{" _L_L "}"
        |  _B "[" _L / _L (, _L / _L)* "]"


  CCCCSSSSPPPP OOOOPPPPEEEERRRRAAAATTTTOOOORRRRSSSS
     _A_X_I_O_M ::= ...
            |  [[csp] (behaviour | behavior)] _B

     _B ::= ...
        |  _B "|||" _B
        |  _B "[|" "{" _G_L "}" "|]" _B
        |  _B "[" "{" _G_L "}" "||" "{" _G_L "}" "]" _B
        |  _B \ _L
        |  _B \ "{" _L_L "}"
        |  _B "[[" _L <- _L (, _L <- _L)* "]]"


  MMMMCCCCRRRRLLLL OOOOPPPPEEEERRRRAAAATTTTOOOORRRRSSSS
     _A_X_I_O_M ::= ...
            |  [[mcrl] (behaviour | behavior)]
               [comm _C (, _C)* end comm] _B

     _C ::= _G "|" _G "=" _G

     _B ::= ...
        |  _B "||" _B



(C) INRIA            Last change: 2020/02/11                    5






CADP MANUAL PAGES                                      EXP(LOCAL)



     The mCRL operators "hide", "rename", and "encaps"  are  sub-
     sumed by the operators "hide", "rename", and "cut" presented
     in Sections "E-LOTOS/LNT OPERATORS" above and "OTHER  OPERA-
     TORS" below.


  OOOOTTTTHHHHEEEERRRR OOOOPPPPEEEERRRRAAAATTTTOOOORRRRSSSS
     _B ::= ...

        |  [gate | total | partial] cut
           ([all but] _L_L | using _F_I_L_E) in _B end cut

        |  [gate | total | partial] prio
           ([all but] _L_L (> [all but] _L_L)+)+
           in _B end prio

        |  [gate | label] par using
           _S_V (, _S_V)* in _B ("||" _B)* end par

     _R ::=

     _S_V ::= (_L |  _) ("*" (_L |  _))* -> _L
         |  (_L |  _) ("||" (_L |  _))* -> _L

  SSSSYYYYNNNNTTTTAAAAXXXX CCCCOOOONNNNVVVVEEEENNNNTTTTIIIIOOOONNNNSSSS
     EXP 2.0 satisfies the following precedence and associativity
     rules:


     -    LOTOS "hide" gives precedence to infix parallel  opera-
          tors (same as in LOTOS).  For instance, the behaviour:
                  _h_i_d_e _G _i_n "_f_1._b_c_g" ||| "_f_2._b_c_g"
          is parsed as:
                  _h_i_d_e _G _i_n ("_f_1._b_c_g" ||| "_f_2._b_c_g")

     -    Infix parallel operators associate to the  right.   For
          instance, the behaviour:
                  "_f_1._b_c_g" ||| "_f_2._b_c_g" |[_G]| "_f_3._b_c_g"
          is parsed as:
                  "_f_1._b_c_g" ||| ("_f_2._b_c_g" |[_G]| "_f_3._b_c_g")


     -    Postfix operators have precedence over all other opera-
          tors.  For instance, the behaviour:
                  "_f_1._b_c_g" | "_f_2._b_c_g" \ _G
          is parsed as:
                  "_f_1._b_c_g" | ("_f_2._b_c_g" \ _G)


     The syntax of EXP 2.0 is the union of all  EBNF  productions
     presented above, with
      the following exceptions:



(C) INRIA            Last change: 2020/02/11                    6






CADP MANUAL PAGES                                      EXP(LOCAL)



     -    Inside "par" operators, behaviours using infix parallel
          operators  are enclosed in parenthesis or parenthesized
          operators (hide...end hide, rename...end rename, etc.).
          For  instance, the following behaviour is not syntacti-
          cally correct:
                  _p_a_r _G _i_n
                     "_f_1._b_c_g" ||| "_f_2._b_c_g"
                  || "_f_3._b_c_g"
                  _e_n_d _p_a_r
          whereas  the  following  behaviours  are  syntactically
          correct:
                  _p_a_r _G _i_n
                     ("_f_1._b_c_g" ||| "_f_2._b_c_g")
                  || "_f_3._b_c_g"
                  _e_n_d _p_a_r

                  _p_a_r _G _i_n
                     _h_i_d_e _H _i_n "_f_1._b_c_g" ||| "_f_2._b_c_g" _e_n_d _h_i_d_e
                  || "_f_3._b_c_g"
                  _e_n_d _p_a_r
          Note in particular that the  following  two  behaviours
          have different semantics:
                  _p_a_r _G _i_n
                     "_f_1._b_c_g"
                  || "_f_2._b_c_g"
                  || "_f_3._b_c_g"
                  _e_n_d _p_a_r
          and
                  _p_a_r _G _i_n
                     ("_f_1._b_c_g" || "_f_2._b_c_g")
                  || "_f_3._b_c_g"
                  _e_n_d _p_a_r
          In  the  latter  case,  the  "||"  occurring   in   the
          parentheses  corresponds  to the LOTOS or mCRL parallel
          composition operator, whereas all other occurrences  of
          "||" correspond to the E-LOTOS/LNT parallel symbol.


     -    Similarly, the "hide" operator must be  ended  by  "end
          hide"  (recommended)  or  enclosed  in parentheses when
          used inside parenthesized operators.


SSSSEEEEMMMMAAAANNNNTTTTIIIICCCCSSSS OOOOFFFF EEEEXXXXPPPP 2222....0000
     This section describes the semantics of  all  EXP  2.0  con-
     structs.


  LLLLAAAABBBBEEEELLLLLLLLEEEEDDDD TTTTRRRRAAAANNNNSSSSIIIITTTTIIIIOOOONNNN SSSSYYYYSSSSTTTTEEEEMMMMSSSS
     _L_T_S may be the name of a file containing an automaton in one
     of  the  AUT  (extension  ....aaaauuuutttt),  BCG  (extension ....bbbbccccgggg), FC2
     (extension ....ffffcccc2222), or SEQ (extension ....sssseeeeqqqq) file formats.



(C) INRIA            Last change: 2020/02/11                    7






CADP MANUAL PAGES                                      EXP(LOCAL)



     All automaton files must have a known  extension.   However,
     the extension may be omitted in the behaviour description if
     the automaton is in the BCG or in the AUT  format.   If  _L_T_S
     has  not a known extension, then eeeexxxxpppp....ooooppppeeeennnn will first attempt
     to open _L_T_S....bbbbccccgggg. If _L_T_S....bbbbccccgggg does not exist  in  the  current
     directory, eeeexxxxpppp....ooooppppeeeennnn will then attempt to open _L_T_S....aaaauuuutttt.

     Use of the BCG format is  recommended  since  eeeexxxxpppp....ooooppppeeeennnn  will
     automatically   convert  other  formats  to  BCG  using  the
     bbbbccccgggg____iiiioooo(LOCAL) tool.


  EEEEXXXXPPPP FFFFIIIILLLLEEEE IIIINNNNCCCCLLLLUUUUSSSSIIIIOOOONNNN
     _L_T_S may also be the name of an  EXP  file  (extension  ....eeeexxxxpppp)
     within  double  quotes.   In this case, the contents of this
     EXP file is simply copied inside the current EXP expression.
     This  allows  large expressions to be split into a hierarchy
     of EXP files.

     Example: The expression
        "a.exp" || "b.bcg"
     where file "a.exp" contains the expression
        hide A in "a.bcg"
     is equivalent to
        hide A in "a.bcg" || "b.bcg"
     Note that this is parsed as
        hide A in ("a.bcg" || "b.bcg")
     hence parentheses may be required to avoid  lexical  scoping
     issues.


  GGGGEEEENNNNEEEERRRRAAAALLLLIIIIZZZZEEEEDDDD HHHHIIIIDDDDIIIINNNNGGGG
       [gate | total | partial] hide [all but] _L_L in _B end hide

     | [gate | total | partial] hide using _F_I_L_E in _B end hide

     will hide the labels found  in  _B  using  the  given  hiding
     rules.   These  rules  can  be specified either as a list of
     labels (first form), or using an external file _F_I_L_E  (second
     form).

     In the first case, eeeexxxxpppp....ooooppppeeeennnn builds a temporary file,  filled
     with  the  given  labels.  In the second case, the hide file
     must be provided by the user.  No  particular  extension  is
     required,  but  the  filename must be written between double
     quotes if it does not  have  the  form  _I_D_F,   _I_D_F....hhhhiiiiddddeeee,  or
     _I_D_F....hhhhiiiidddd.  See the ccccaaaaeeeessssaaaarrrr____hhhhiiiiddddeeee____1111(LOCAL) man page for a defin-
     ition of the hide file format.

     The "all but" keywords modify the semantics  of  the  hiding
     rules:  all  the  labels, except the labels specified in the
     list of labels, are hidden.



(C) INRIA            Last change: 2020/02/11                    8






CADP MANUAL PAGES                                      EXP(LOCAL)



     The keywords  "total",  "partial",  and  "gate"  modify  the
     matching  mode,  that is the way the hiding rules are inter-
     preted.  See the ccccaaaaeeeessssaaaarrrr____hhhhiiiiddddeeee____1111(LOCAL) man  page.   See  also
     Section SYNTAX OF EXP 2.0 above, which explains how the gate
     of a label is recognized.  If no matching mode is specified,
     then  the default is "gate", which implements the LOTOS hid-
     ing operator  extended  with  regular  expressions  denoting
     gates.

     For every  hiding  with  "gate"  matching,  eeeexxxxpppp....ooooppppeeeennnn  checks
     whether  the  gates  to be hidden have an appropriate syntax
     and issues a warning if they appear  to  contain  experiment
     offers  (which  is  a  common mistake for novice users). For
     instance,
             hide "G !1"
     will trigger a warning message because of the occurrence  of
     "!1".

     EEEExxxxaaaammmmpppplllleeeessss:

             total hide "G"
     hides every label equal to "G",

             gate hide "G"
     hides every label whose gate is G, e.g., "G !1", "G !2",

             gate hide ".*G.*"
     hides every label whose gate contains the character G and

             partial hide "G"
     hides every label whose gate or offers contain the character
     G.

     See the ccccaaaaeeeessssaaaarrrr____hhhhiiiiddddeeee____1111(LOCAL) man page for  more  information
     on  matching  mode  semantics.   rrrreeeeggggeeeexxxxpppp(LOCAL)  man page for
     information about regular expression syntax.

     The semantics of LOTOS "hide" is compatible with that of  E-
     LOTOS/LNT, i.e.,
             hide _G_L in _B
     is equivalent to
             gate hide _G_L in _B end hide


  GGGGEEEENNNNEEEERRRRAAAALLLLIIIIZZZZEEEEDDDD RRRREEEENNNNAAAAMMMMIIIINNNNGGGG
       [gate | total | single | multiple] rename
             _L -> _L (, _L -> _L)* in _B end rename

     | [gate | total | single | multiple] rename
             using _F_I_L_E in _B end rename

     will rename the labels of _B using the given renaming  rules.



(C) INRIA            Last change: 2020/02/11                    9






CADP MANUAL PAGES                                      EXP(LOCAL)



     These  rules  can  be specified either as a list of items of
     the form _L -> _L (first form), or using an external file _F_I_L_E
     (second form).

     In the first case eeeexxxxpppp....ooooppppeeeennnn builds a temporary  file,  filled
     with  the  given  substitution  rules.   In  the second case
     eeeexxxxpppp....ooooppppeeeennnn uses the given renaming file.  No particular exten-
     sion  is  required, but the filename must be written between
     double quotes if it does not have the form _I_D_F,  _I_D_F....rrrreeeennnnaaaammmmeeee,
     or  _I_D_F....rrrreeeennnn.   See the ccccaaaaeeeessssaaaarrrr____rrrreeeennnnaaaammmmeeee____1111(LOCAL) man page for a
     definition of the hide file format.

     See also Section SYNTAX OF EXP 2.0 above, which explains how
     the  gate  of  a label is recognized.  The keywords "total",
     "single", "multiple", and "gate" modify the  way  the  left-
     hand  sides  of  the renaming rules are interpreted, see the
     ccccaaaaeeeessssaaaarrrr____rrrreeeennnnaaaammmmeeee____1111(LOCAL) man page.  If  no  matching  mode  is
     specified, then the default is "gate".

     For every renaming with  "gate"  matching,  eeeexxxxpppp....ooooppppeeeennnn  checks
     whether  the  gates to be renamed have an appropriate syntax
     and issues a warning if they appear  to  contain  experiment
     offers  (which  is  a  common mistake for novice users). For
     instance,
             rename "G !1" -> "G !2"
     will trigger a warning message because of the occurrence  of
     "!1" in the left-hand side. Note however that
             rename "G" -> "G !1"
     is correct.

     EEEExxxxaaaammmmpppplllleeeessss:

             total rename "G" -> "H"
     renames to "H" every label equal to "G",

             gate rename "G" -> "H"
     renames to "H" every gate equal to  "G",  e.g.,  "G  !1"  is
     renamed to "H !1",

             gate rename ".*G.*" -> "H"
     renames to "H" every gate that contains a G character,

             single rename "G" -> "H"
     replaces the first occurrence of "G" by "H" in  every  label
     whose gate or offers contain a G character,

             multiple rename "G" -> "H"
     replaces every occurrence of "G" by "H" in every label whose
     gate or offers contain a G character, and

             total rename "\([a-zA-Z0-9]*\) \(!.*\)" -> "\1 !1 \2"
     inserts "!1" between every gate  (sequence  of  letters  and



(C) INRIA            Last change: 2020/02/11                   10






CADP MANUAL PAGES                                      EXP(LOCAL)



     digits) and its offers (prefixed with !).

     See the ccccaaaaeeeessssaaaarrrr____rrrreeeennnnaaaammmmeeee____1111(LOCAL) man page for more information
     on  matching mode semantics.  See also the rrrreeeeggggeeeexxxxpppp(LOCAL) man
     page for more information on regular expressions.


  GGGGEEEENNNNEEEERRRRAAAALLLLIIIIZZZZEEEEDDDD CCCCUUUUTTTT
       [gate | total | partial] cut [all but] _L_L in _B end cut

     | [gate | total | partial] cut using _F_I_L_E in _B end cut

     is a generalization of mCRL encapsulation, on the same prin-
     ciples as the generalized "hide" operator.  Instead of being
     converted into silent transitions as does the "hide"  opera-
     tor,  transitions  whose  label  matches  the  given regular
     expressions are simply cut off.

     Cut files have the following syntax:

     _A_X_I_O_M ::= <blanks> cut <blanks> \n _L_A_B_E_L_S
            |  <blanks> cut all but <blanks> \n _L_A_B_E_L_S

     _L_A_B_E_L_S ::= (<blanks> _L <blanks> \n)*

     where _L is a label, and <blanks> is any sequence of  spaces,
     tabulations,  carriage  returns,  newlines, vertical tabula-
     tion, or form feeds; these characters are  those  recognized
     by the POSIX function isspace(); they are always skipped and
     ignored.


  GGGGEEEENNNNEEEERRRRAAAALLLLIIIIZZZZEEEEDDDD PPPPRRRRIIIIOOOORRRRIIIITTTTYYYY
       [gate | total | partial] prio
           ([all but] _L_L (> [all but] _L_L)+)+
       in _B end prio

     sets priorities between the transitions of _B.  In each state
     of  _B,  a transition may be executed only if all transitions
     of higher priority are not ready for execution.

     Priorities between  transitions  (or  equivalently,  between
     labels)  are defined by a set of priority rules _X_1 > ... _X_n,
     where each _X_i has the form [all but] _L_L_i and _L_L_1,  ...,  _L_L_n
     are  lists  of regular expressions denoting gates or labels.
     The "all but" keywords that may precede some _L_L_i  means  all
     gates or labels but those matching _L_L_i.

     Such priority rules define a  transitive  relation  ">>"  on
     labels as follows:

     -    if _X > _X', the visible label _L of _B matches _X, and  the



(C) INRIA            Last change: 2020/02/11                   11






CADP MANUAL PAGES                                      EXP(LOCAL)



          visible label _L' of _B matches _X' then _L >> _L'

     -    if _L >> _L' and _L' >> _L'' then _L >> _L''

     _L >> _L' means that any transition  labeled  _L  has  priority
     over any transition labeled _L' or, equivalently, any transi-
     tion labeled _L' yields priority to any transition labeled _L.

     The relation ">>" must be a strict partial order: _B must not
     contain  any  label  _L  such  that _L >> _L.  If ">>" is not a
     strict partial order, eeeexxxxpppp....ooooppppeeeennnn will issue an  error  message
     and exit.

     Beware that the rules _X  >  _X'  and  _X'  >  _X''  (which  are
     equivalent  to  _X  >  _X' > _X'') imply _X > _X'' if and only if
     some label of _B matches  _X'.   Therefore,  to  avoid  tricky
     errors,   eeeexxxxpppp....ooooppppeeeennnn  checks  that  every  individual  regular
     expression _L in _L_L_1, ..., _L_L_n matches some label of  _B.   If
     not, then eeeexxxxpppp....ooooppppeeeennnn will issue a warning.

     The optional "gate", "total", and "partial" keywords  define
     the  matching  mode,  in  the same way as for the "hide" and
     "cut" operators.  The matching mode by default is "gate".

     EEEExxxxaaaammmmpppplllleeeessss::::

     -    The following expression:

          gate prio
              "A.*" > B > all but "A.*", B
          in
              "f.bcg"
          end prio

          defines an LTS in which  every  transition  whose  gate
          starts  with  the  letter  "A"  has priority over every
          transition whose gate is  "B",  which  themselves  have
          priority over all other transitions.

     -    The following expression:

          partial prio
              "A" > all but "A"
          in
              "f.bcg"
          end prio

          defines an LTS in which every  transition  whose  label
          contains the letter "A" has priority over every transi-
          tion whose  label  does  not  contain  the  letter  "A"
          (including hidden transitions).




(C) INRIA            Last change: 2020/02/11                   12






CADP MANUAL PAGES                                      EXP(LOCAL)



     -    The following expression:

          total prio
              "A" > "B" > "C"
              "D" > "E" > "F"
              "A" > "D"
              "B" > "E"
              "C" > "F"
          in
              "f.bcg"
          end prio

          defines an LTS in which A has priority over B, C, D, E,
          and  F, B has priority over C, E, and F, C has priority
          over F, D has priority over E and F, and E has priority
          over F.

     Note: Strong bisimulation is a congruence for  all  eeeexxxxpppp....ooooppppeeeennnn
     operators,  including  "prio".  However, branching, observa-
     tional, and safety  equivalences  are  congruences  for  all
     eeeexxxxpppp....ooooppppeeeennnn hiding, cutting, renaming, and parallel composition
     operators, but not for "prio".  It should also be noted that
     tau*.a equivalence is not a congruence for parallel composi-
     tion.


  GGGGEEEENNNNEEEERRRRAAAALLLLIIIIZZZZEEEEDDDD PPPPAAAARRRRAAAALLLLLLLLEEEELLLL
       [gate | label] par [(all | _S) in]
         [_S ->] _B ("||" [_S ->] _B)+ end par

     is an extension of the E-LOTOS/LNT generalized parallel com-
     position  operator presented in [Garavel-Sighireanu-99].  It
     denotes the concurrent execution of parallel behaviours fol-
     lowing synchronisation rules expressed using:

     -    the keyword "all" or the list _S that follows  the  key-
          word  "par",  called  _g_l_o_b_a_l _s_y_n_c_h_r_o_n_i_s_a_t_i_o_n _i_n_t_e_r_f_a_c_e,
          and

     -    the lists _S that precede the symbols "->", called _l_o_c_a_l
          _s_y_n_c_h_r_o_n_i_s_a_t_i_o_n _i_n_t_e_r_f_a_c_e_s.

     Synchronisation interfaces _S are  lists  of  synchronisation
     elements  of the form _L or _L#_N, where _L is a gate or a label
     and _N is a natural number called _s_y_n_c_h_r_o_n_i_s_a_t_i_o_n _d_e_g_r_e_e.

     The semantics of synchronisation rules  is  defined  in  the
     following paragraphs.

     The "gate" or "label" keywords indicate the  _s_y_n_c_h_r_o_n_i_s_a_t_i_o_n
     _m_o_d_e,  which  influences the way synchronisation rules apply
     to transition labels.  We say that a  transition  matches  a



(C) INRIA            Last change: 2020/02/11                   13






CADP MANUAL PAGES                                      EXP(LOCAL)



     synchronisation  element of the form _L or _L#_N in the follow-
     ing cases:

     -    In "gate" synchronisation mode, a transition matches  _L
          or  _L#_N  if  the  gate  of  the  transition label is _L.
          Therefore, for every  synchronisation  element  of  the
          form _L or _L#_N occurring in a synchronisation interface,
          _L must be a gate without offers.  See Section SYNTAX OF
          EXP 2.0 above, which explains how the gate of a transi-
          tion is extracted from its label.

     -    In "label" synchronisation mode, a transition matches _L
          or  _L#_N  if  the transition label is _L.  Therefore, for
          every synchronisation element of  the  form  _L  or  _L#_N
          occurring  in  a synchronisation interface, _L must be a
          full label (i.e., a gate possibly followed by offers).

     Unlike "hide", "cut", and "rename", regular expressions  are
     not  allowed in synchronisation elements.  If not specified,
     the synchronisation mode by default is "gate".

     The keyword "all" is a shorthand  notation  for  the  global
     synchronisation  set  consisting of all synchronisation ele-
     ments _L (without degree) such that _L is the gate (in  "gate"
     synchronisation  mode) or the label (in "label" synchronisa-
     tion mode) of a transition in at least one of  the  parallel
     behaviours, except hidden and termination labels.

     Synchronisation elements have the following meaning:

     -    A  synchronisation  element  of  the  form  _L  (without
          degree)  occurring in the global synchronisation inter-
          face indicates that all parallel  behaviours  may  syn-
          chronise all together on transitions that match _L.

     -    A  synchronisation  element  of  the  form  _L  (without
          degree)  occurring in a local synchronisation interface
          indicates that all parallel behaviours that  contain  _L
          in  their synchronisation interface may synchronise all
          together on transitions that match _L.

     -    A synchronisation element of the form _L#_N occurring  in
          the  global  synchronisation interface indicates that _N
          behaviours among the parallel behaviours may  synchron-
          ise together on transitions that match _L.

     -    A synchronisation element of the form _L#_N occurring  in
          a  local  synchronisation  interface  indicates  that _N
          behaviours among the parallel behaviours  that  contain
          _L#_N  in their synchronisation interface may synchronise
          on transitions that match _L.




(C) INRIA            Last change: 2020/02/11                   14






CADP MANUAL PAGES                                      EXP(LOCAL)



     -    A transition in a parallel behaviour may execute  asyn-
          chronously if both the global synchronisation interface
          and  the  local  synchronisation  interface   of   that
          behaviour  do  not contain any element of the form _L or
          _L#_N such that the transition matches _L....

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

     Note that synchronisation interfaces can neither contain the
     hidden  gate  nor  the  termination gate.  Behaviours always
     synchronise on labels whose gate is the termination gate and
     never synchronise on hidden transitions.

     Before generating the graph  module,  eeeexxxxpppp....ooooppppeeeennnn  checks  that
     generalized parallel operators are well-formed, i.e.:

     -    If the global synchronisation interface contains a syn-
          chronisation  element  of the form _L#_N with _N > 0, then
          the parallel composition must contain at least _N paral-
          lel behaviours.

     -    If the global synchronisation interface contains a syn-
          chronisation element of the form _L#_0, then no synchron-
          isation element of the form _L or _L#_N with same _L and  _N
          >  0  should occur in the global synchronisation inter-
          face or in any local synchronisation interface.

     -    If a local synchronisation interface  contains  a  syn-
          chronisation  element  of  the form _L (without degree),
          then at  least  two  local  synchronisation  interfaces
          (this   one   included)   should   contain   the   same



(C) INRIA            Last change: 2020/02/11                   15






CADP MANUAL PAGES                                      EXP(LOCAL)



          synchronisation element.  However, if the intention  is
          to  explicitly  indicate  that the behaviour should not
          synchronise on _L, then the synchronisation element  can
          be  written  in the form _L#_1.  Synchronisation elements
          of the form _L#_1 can also be used in the  global  inter-
          face  to  indicate  that all transitions matching _L may
          execute asynchronously in all behaviours  that  contain
          _L.

     -    If a local synchronisation interface  contains  a  syn-
          chronisation  element  of the form _L#_N with _N > 0, then
          at least _N local synchronisation interfaces  (this  one
          included)  should contain the same synchronisation ele-
          ment.

     -    If a local synchronisation interface  contains  a  syn-
          chronisation element of the form _L#_0, then no synchron-
          isation element of the form _L or _L#_N with same _L and  _N
          >  0  should occur in the global synchronisation inter-
          face or in the same local synchronisation interface.

     -    If the global synchronisation interface contains a syn-
          chronisation  element  of the form _L, then all parallel
          behaviours must contain a label matching _L.

     -    If the global synchronisation interface contains a syn-
          chronisation  element  of the form _L#_N, then at least _N
          parallel behaviours must contain a label matching _L.

     -    If a local synchronisation interface  contains  a  syn-
          chronisation  element  of  the  form _L or _L#_N, then the
          corresponding parallel behaviours must contain a  label
          matching _L.

     Warnings are issued if those conditions are  not  satisfied.
     These  checks  can be discarded by using the ----nnnnoooocccchhhheeeecccckkkk option
     of eeeexxxxpppp....ooooppppeeeennnn(LOCAL).  This is not recommended because  errors
     may lead to unpredictable behaviours.

     EEEExxxxaaaammmmpppplllleeeessss::::
     gate par G#2 in
        G4, G1 -> "f1.bcg"
     || G1, G2 -> "f2.bcg"
     || G2, G3 -> "f3.bcg"
     || G3, G4 -> "f4.bcg"
     end par

     represents an automaton such that:

     -    any two automata among  "f1.bcg",  "f2.bcg",  "f3.bcg",
          and "f4.bcg" synchronise on transitions whose gate is _G




(C) INRIA            Last change: 2020/02/11                   16






CADP MANUAL PAGES                                      EXP(LOCAL)



     -    "f1.bcg" and "f2.bcg" synchronise on transitions  whose
          gate is _G_1

     -    "f2.bcg" and "f3.bcg" synchronise on transitions  whose
          gate is _G_2

     -    "f3.bcg" and "f4.bcg" synchronise on transitions  whose
          gate is _G_3

     -    "f4.bcg" and "f1.bcg" synchronise on transitions  whose
          gate is _G_4

     -    "f1.bcg" executes transitions whose gate is neither  _G,
          _G_1, _G_4, nor the termination gate, without synchronising
          with others

     -    etc.

     gate par G#2, G#3 in
        "f1.bcg"
     || "f2.bcg"
     || "f3.bcg"
     || "f4.bcg"
     end par

     represents an automaton such that:

     -    any two or three  automata  among  "f1.bcg",  "f2.bcg",
          "f3.bcg", and "f4.bcg" synchronise on transitions whose
          gate is _G

     -    any of "f1.bcg", "f2.bcg", "f3.bcg", or  "f4.bcg"  exe-
          cutes  transitions whose gate is neither _G nor the ter-
          mination gate, without synchronising with others

     gate par G in
        G1#2, G2 -> "f1.bcg"
     || G1#2 -> "f2.bcg"
     || G1#2 -> "f3.bcg"
     || G2 -> "f4.bcg"
     end par

     represents an automaton such that:

     -    all automata "f1.bcg", "f2.bcg", "f3.bcg", and "f4.bcg"
          synchronise on transitions whose gate is _G

     -    any two automata among "f1.bcg", "f2.bcg", and "f3.bcg"
          synchronise on transitions whose gate is _G_1

     -    "f1.bcg" and "f4.bcg" synchronise on transitions  whose
          gate is _G_2



(C) INRIA            Last change: 2020/02/11                   17






CADP MANUAL PAGES                                      EXP(LOCAL)



     -    "f1.bcg" executes transitions whose gate is neither  _G,
          _G_1, _G_2, nor the termination gate, without synchronising
          with others

     -    etc.

     gate par
        G#1, G#2 -> "f1.bcg"
     || G#1, G#2 -> "f2.bcg"
     || G#1, G#2 -> "f3.bcg"
     end par

     represents an automaton such that transitions  of  "f1.bcg",
     "f2.bcg",  and "f3.bcg" whose gate is _G may either synchron-
     ise by pair, or execute asynchronously.


  PPPPAAAARRRRAAAALLLLLLLLEEEELLLL WWWWIIIITTTTHHHH SSSSYYYYNNNNCCCCHHHHRRRROOOONNNNIIIISSSSAAAATTTTIIIIOOOONNNN VVVVEEEECCCCTTTTOOOORRRRSSSS
       [gate | label] par using _S_V (, _S_V)* in _B ("||" _B)* end par

     is parallel composition with  _s_y_n_c_h_r_o_n_i_s_a_t_i_o_n  _v_e_c_t_o_r_s.   It
     denotes  the  concurrent  execution  of behaviours following
     synchronisation rules, expressed using vectors of gates  (in
     "gate" synchronisation mode) or labels (in "label" synchron-
     isation mode).

     A synchronisation vector _S_V has the form "_E_1 || ... || _E_n ->
     L", or equivalently "_E_1 * ... * _E_n -> L", where each _E_i (_i =
     _1.._n) is either a visible gate  without  offers  (in  "gate"
     synchronisation  mode),  a visible label, i.e., visible gate
     with offers (in "label" synchronisation mode), or  the  spe-
     cial  symbol "_" (in both synchronisation modes).  Note that
     gates and labels must not be defined using  regular  expres-
     sions.   If it is not specified, the synchronisation mode by
     default is "gate".  See Section SYNTAX  OF  EXP  2.0  above,
     which explains how the gate of a label is recognized.

     The left-hand side (left of the arrow) of each  synchronisa-
     tion vector must have as many gates (or labels) and "_" sym-
     bols as there are behaviours _B  in  parallel.   A  gate  (or
     label)  _G  as nth component of a vector left-hand side means
     that the nth behaviour in the parallel composition can  per-
     form a transition whose gate is _G only if all behaviours can
     perform simultaneously as specified by the same vector, pos-
     sibly  on  different  gates, but with same offers (in "gate"
     synchronisation mode).  "_"  means  that  no  transition  is
     required  for  the  corresponding  behaviour.  The resulting
     transition is labelled with the right-hand side of the  vec-
     tor (in "label" synchronisation mode) or with the right-hand
     side of the vector, followed  by  the  offers,  if  any  (in
     "gate"  synchronisation mode).  The hidden string is forbid-
     den in the left-hand side of a synchronisation vector.



(C) INRIA            Last change: 2020/02/11                   18






CADP MANUAL PAGES                                      EXP(LOCAL)



     Transitions that do not fit any vector are  blocked,  except
     hidden transitions, which always perform asynchronously.  In
     particular, if one wants to let visible transitions  perform
     asynchronously,  it  is  necessary  to  define vectors whose
     left-hand side contain only "_" but one visible gate.

     EEEExxxxaaaammmmpppplllleeee::::
     gate par using
       G1 || _  || G3 -> G13,
       G1 || G2 || _  -> G12,
       G1 || _  || _  -> G1
       H  || _  || _  -> H
     in
       "f1.bcg" || "f2.bcg" || "f3.bcg"
     end par

     represents the automaton defined as follows:

     1):  if "f1.bcg" can perform a transition whose gate is  G1,
          possibly   followed  with  experiment  offers  (written
          _O_1..._O_n), then a transition labelled "G1 _O_1...  _O_n"  is
          created  in  the  resulting automaton due to the vector
          "G1 || _ || _ -> G1"

     2):  if, additionally to 1), "f3.bcg" can perform a  transi-
          tion  labelled "G3 _O_1..._O_n", then a transition labelled
          "G13 _O_1..._O_n" is created in the resulting automaton due
          to the vector "G1 || _ || G3 -> G13"

     3):  if, additionally to 1), "f2.bcg" can perform a  transi-
          tion  labelled "G2 _O_1..._O_n", then a transition labelled
          "G12 _O_1..._O_n" is created in the resulting automaton due
          to the vector "G1 || G2 || _ -> G12"

     4):  if "f1.bcg" can perform a transition whose gate  is  H,
          then  the  same  transition is created in the resulting
          automaton, due to the vector "H || _ || _ -> H"

     5):  all  other  transitions  of  "f1.bcg",   "f2.bcg"   and
          "f3.bcg"  do not create any transition in the resulting
          automaton.


  LLLLOOOOTTTTOOOOSSSS PPPPAAAARRRRAAAALLLLLLLLEEEELLLL
       _B "||" _B

     | _B "|||" _B

     | _B "|[" _G_L "]|" _B

     have the same semantics as, respectively:
     gate par all in _B "||" _B end par



(C) INRIA            Last change: 2020/02/11                   19






CADP MANUAL PAGES                                      EXP(LOCAL)



     gate par _B "||" _B end par
     gate par _G_L in _B "||" _B end par
     Note that in mCRL mode, "||" has a different semantics  (see
     MCRL  PARALLEL).   Note  also that the "|||" operator of CSP
     has the same semantics as in LOTOS.


  CCCCCCCCSSSS PPPPAAAARRRRAAAALLLLLLLLEEEELLLL
       _B "|" _B

     is the parallel composition operator of CCS.

     Transitions of both behaviours may either perform  asynchro-
     nously, or may synchronise, resulting in a hidden event.

     Synchronisation is possible only if the corresponding  tran-
     sition  labels are _c_o-_a_c_t_i_o_n_s, i.e., they have the same gate
     and offers, but one of the gates is prefixed  with  the  co-
     action  prefix.   The co-action prefix by default is "'" but
     can   be   modified   using   the   ----ccccooooaaaaccccttttiiiioooonnnn   option    of
     eeeexxxxpppp....ooooppppeeeennnn(LOCAL).   Note that (1) the co-action prefix should
     not contain !, ?, (, space, and tabulation characters, which
     are  used  to  delimit  a gate from its offer, and (2) there
     should not be any space or tabulation between the  co-action
     prefix  and  the  gate identifier (see Section SYNTAX OF EXP
     2.0 above, which explains how the gate of a label is  recog-
     nized).

     For instance, transitions labelled "G"  and  "'G"  may  syn-
     chronise,  as well as transitions labelled "G O" and "'G O".
     In both cases, the resulting label after synchronisation  is
     the hidden label.

     Note that hidden transitions perform asynchronously and that
     there is no termination label in CCS.


  CCCCSSSSPPPP PPPPAAAARRRRAAAALLLLLLLLEEEELLLL
       _B "|||" _B

     | _B "[|" "{" _G_L "}" "|]" _B

     | _B "[" "{" _G_L "}" "||" "{" _G_L "}" "]" _B

     denote parallel composition in CSP.

     -    "|||" has the same semantics as  in  LOTOS  (see  LOTOS
          PARALLEL above).

     -    "[|" "{" _G_L "}" "|]" has the same  semantics  as  LOTOS
          "|[" _G_L "]|" (see LOTOS PARALLEL above).




(C) INRIA            Last change: 2020/02/11                   20






CADP MANUAL PAGES                                      EXP(LOCAL)



     -    In "_B_1 [{_G_L_1}||{_G_L_2}] _B_2", transitions of  _B_1  (respec-
          tively  _B_2)  perform asynchronously if their gate is in
          _G_L_1 (respectively _G_L_2) but  not  in  _G_L_2  (respectively
          _G_L_1).   Transitions  of  _B_1  and _B_2 synchronise if they
          have the same label, the gate of which is  either  both
          in _G_L_1 and _G_L_2 or the termination gate (usually written
          "delta" in CSP).  Other transitions are  cut  off.   As
          usual,  hidden transitions perform asynchronously.  See
          Section SYNTAX OF EXP 2.0 above, which explains how the
          gate of a label is recognized.


  MMMMCCCCRRRRLLLL PPPPAAAARRRRAAAALLLLLLLLEEEELLLL
       _B "||" _B

     denotes parallel composition in mCRL.

     In "_B_1 || _B_2",  transitions  may  either  perform  asynchro-
     nously,  or  they  may  synchronise  following communication
     rules, that must be defined in the preamble of the EXP  file
     ("comm"  keyword).   A communication rule has the form "_G_1 |
     _G_2 = _G_3", where _G_1, _G_2, and  _G_3  are  gates.   Communication
     rules  are commutative, i.e., there is no difference between
     "_G_1 | _G_2 = _G_3" and "_G_2 | _G_1 = _G_3".  Such a rule  means  that
     if an operand (_B_1 or _B_2) may perform a transition whose gate
     is _G_1 and the other operand may perform a  transition  whose
     gate  is  _G_2, and both transitions carry the same experiment
     offers _O, then a synchronisation is possible and results  in
     a transition labelled "_G_3 _O".  See Section SYNTAX OF EXP 2.0
     above, which explains how the gate of a label is recognized.

     Note that hidden transitions  must  perform  asynchronously,
     and  that  there  must be at most one communication rule for
     each pair of gates occurring in the left-hand  side  of  the
     "=" symbol.  For instance, the following is not allowed:
     comm G1 | G2 = G3, G2 | G1 = G4 end comm

     Note that the reference language must be mCRL in  order  for
     the  "||"  operator  to have mCRL semantics instead of LOTOS
     semantics.  If the  reference  language  is  different  from
     mCRL, then any "comm" definition is useless and irrelevant.


  CCCCCCCCSSSS RRRREEEESSSSTTTTRRRRIIIICCCCTTTTIIIIOOOONNNN
       _B \ "{" _L (, _L)* "}"

     | _B \ _L

     denotes  the  CCS  restriction  operator,  except  when  the
     language  option  is  set  to  CSP  (see  Section CSP HIDING
     below).  In the first form, the behaviour  _B  is  restricted
     with  respect  to several labels, whereas in the second form



(C) INRIA            Last change: 2020/02/11                   21






CADP MANUAL PAGES                                      EXP(LOCAL)



     it is restricted with respect to a single label.

     CCS restriction is similar to cut (in gate  matching  mode),
     except  that  co-action labels are also affected by the res-
     triction  whenever  the  corresponding   action   label   is
     affected.

     For instance, in "_B \ _G", transitions  of  _B  labelled  "_G",
     "'_G"  (where  "'"  stands  for  the co-action prefix), "_G _O"
     (where _O denotes any communication offer), and  "'_G  O"  are
     cut  off.   See  Section  SYNTAX  OF  EXP  2.0  above, which
     explains how the gate of a label is recognized.

     Note that labels in  the  restriction  set  can  be  regular
     expressions  denoting  gates, but should not have offers and
     should not start with the co-action prefix.


  CCCCSSSSPPPP HHHHIIIIDDDDIIIINNNNGGGG
       _B \ "{" _L (, _L)* "}"

     | _B \ _L

     denotes the CSP hiding operator when the language option  is
     set  to CSP (otherwise it denotes the CCS restriction opera-
     tor, see Section CCS RESTRICTION  above).   Both  forms  are
     equivalent to
     gate hide _L (, _L)* in _B end hide

     gate hide _L in _B end hide
     respectively.


  CCCCCCCCSSSS RRRREEEELLLLAAAABBBBEEEELLLLIIIINNNNGGGG
       _B "[" _L / _L (, _L / _L)* "]"

     denotes the CCS relabeling operator.  It is similar  to  the
     renaming  operator  (in  gate matching mode) except that the
     co-action prefix is preserved by renaming.

     For instance, in "_B [_G_1/_G_2]", the labels "_G_2", "'_G_2"  (where
     "'"  stands  for  the  co-action  prefix),  "_G_2  _O" (where _O
     denotes any communication offer), and "'_G_2  _O"  are  renamed
     respectively  into  "_G_1",  "'_G_1",  "_G_1 _O", and "'_G_1 _O".  See
     Section SYNTAX OF EXP 2.0 above, which explains how the gate
     of a label is recognized.

     Note that labels can be regular expressions denoting  gates,
     but  should  not  have  offers and should not start with the
     co-action prefix.





(C) INRIA            Last change: 2020/02/11                   22






CADP MANUAL PAGES                                      EXP(LOCAL)



  CCCCSSSSPPPP RRRREEEELLLLAAAABBBBEEEELLLLIIIINNNNGGGG
       _B "[[" _L <- _L (, _L <- _L)* "]]"

     denotes the CSP relabeling operator.

     The behaviour
     _B [[ _G_1 <- _G_2, ..., _G_2_n+_1 <- _G_2_n+_2 ]]
     is equivalent to
     _g_a_t_e _r_e_n_a_m_e _G_1 -> _G_2, ..., _G_2_n+_1 -> _G_2_n+_2 _i_n _B

     (Note the opposite direction of the arrows.)

     Note that, as a consequence, labels can be  regular  expres-
     sions denoting gates, but should not have offers.


LLLLAAAANNNNGGGGUUUUAAAAGGGGEEEE PPPPAAAARRRRAAAAMMMMEEEETTTTEEEERRRRSSSS
     There are two means to select a reference language:

     -    Using eeeexxxxpppp....ooooppppeeeennnn(LOCAL) with a  command  line  option  (----
          lllloooottttoooossss, ----eeeelllloooottttoooossss, ----ccccccccssss, ----ccccsssspppp, or ----mmmmccccrrrrllll), or

     -    Specifying the language in the EXP file header  ("lotos
          behaviour",   "elotos  behaviour",  etc.).   Note  that
          "behaviour" or "behavior" alone is equivalent to "lotos
          behaviour" when no language option is set.  The absence
          of the "behaviour" or "behavior" keyword means that  no
          reference language is set.

     If the EXP file header and the command line  option  specify
     different reference languages, then a warning is issued.  It
     is not allowed to specify more than one language  option  on
     the command line.

     The following table summarizes the default parameter  values
     according  to  reference  languages.  Note that these values
     (in particular lines labelled none and LOTOS) are compatible
     with eeeexxxxpppp....ooooppppeeeennnn version 1.0.

















(C) INRIA            Last change: 2020/02/11                   23






CADP MANUAL PAGES                                      EXP(LOCAL)



     +----------+--------+--------+-------------+------+-------+
     | language | hidden | termin.|    case     | sem. | sem.  |
     |          | event  |  gate  | sensitivity | of \ | of || |
     +----------+--------+--------+-------------+------+-------+
     | none     |   "i"  | "exit" |  sensitive  | CCS  | LOTOS |
     +----------+--------+--------+-------------+------+-------+
     | LOTOS    |   "i"  | "exit" | insensitive | CCS  | LOTOS |
     +----------+--------+--------+-------------+------+-------+
     | E-LOTOS* |   "i"  | "exit" |  sensitive  | CCS  | LOTOS |
     +----------+--------+--------+-------------+------+-------+
     | CCS      |   "t"  |  N/A   | insensitive | CCS  | LOTOS |
     +----------+--------+--------+-------------+------+-------+
     | CSP      |   "t"  | "delta"| insensitive | CSP  | LOTOS |
     +----------+--------+--------+-------------+------+-------+
     | mCRL     |  "tau" |  N/A   |  sensitive  | CCS  | mCRL  |
     +----------+--------+--------+-------------+------+-------+
     where N/A stands for _N_o_t _A_p_p_l_i_c_a_b_l_e.

     * The parameters associated to E-LOTOS are subject to modif-
     ications  in the future, depending on implementation choices
     still to be made.

     Note that the hidden string (written either "i", "t", "tau",
     or  anything  else)  should not be followed by communication
     offers, whereas the termination string may.


HHHHOOOOWWWW TTTTOOOO CCCCRRRREEEEAAAATTTTEEEE AAAANNNN EEEEXXXXPPPP FFFFIIIILLLLEEEE
     At present, EXP files can be either written by hand or  pro-
     duced  automatically by ssssvvvvllll(LOCAL) from SVL scripts contain-
     ing some parallel composition operator.


HHHHOOOOWWWW TTTTOOOO RRRREEEEAAAADDDD AAAANNNN EEEEXXXXPPPP FFFFIIIILLLLEEEE
     At present, there is one single CADP tool,  eeeexxxxpppp....ooooppppeeeennnn(LOCAL),
     that reads and processes EXP files.


BBBBIIIIBBBBLLLLIIIIOOOOGGGGRRRRAAAAPPPPHHHHYYYY
     [Berthomieu-Ribet-Vernadat-04]
          B. Berthomieu, P.-O. Ribet, and F. Vernadat.  The  tool
          TINA  - Construction of Abstract State Spaces for Petri
          Nets and Time Petri Nets.  In International Journal  of
          Production Research, Vol. 42, No 14, July 2004.


     [Best-Grahlmann-98]
          Eike Best and Bernd Grahlmann.  "PEP Documentation  and
          User       Guide."        http://parsys.informatik.uni-
          oldenburg.de/~pep/paper.html. 1998."





(C) INRIA            Last change: 2020/02/11                   24






CADP MANUAL PAGES                                      EXP(LOCAL)



     [Bouali-Ressouche-Roy-deSimone-96]
          Amar Bouali, Annie Ressouche, Valerie Roy,  and  Robert
          de Simone.  The Fc2Tools set: a Toolset for the Verifi-
          cation of Concurrent Systems.   In  R.  Alur  and  T.A.
          Henzinger,  editors,  Proceedings of the 8th Conference
          on Computer-Aided Verification (New Brunswick, New Jer-
          sey,  USA).  Lecture  Notes  in Computer Science volume
          1102, Springer-Verlag, 1996.


     [Brookes-Hoare-Roscoe-84]
          S. D. Brookes, C. A. R. Hoare, and A.  W.  Roscoe.   "A
          Theory  of  Communicating  Sequential  Processes."   In
          Journal of the ACM, vol. 31, number 3,  pages  560-599.
          ACM, 1984.


     [Garavel-15-a]
          Hubert Garavel.  "Nested-Unit Petri Nets: A  Structural
          Means to Increase Efficiency and Scalability of Verifi-
          cation on Elementary Nets."  In  R.  Devillers  and  A.
          Valmari, editors, Proceedings of the 36th International
          Conference on Application and Theory of Petri Nets  and
          Concurrency  (Brussels, Belgium). Lecture Notes in Com-
          puter  Science  volume  9115,  Springer-Verlag,   2015.
          Available                                          from
          http://cadp.inria.fr/publications/Garavel-15-a.html


     [Garavel-Sighireanu-99]
          Hubert Garavel and Mihaela  Sighireanu.   "A  Graphical
          Parallel  Composition  Operator  for Process Algebras."
          In J. Wu, Q. Gao, and S.T. Chanson,  editors,  Proceed-
          ings  of  the  Joint International Conference on Formal
          Description Techniques for Distributed Systems and Com-
          munication Protocols, and Protocol Specification, Test-
          ing, and Verification FORTE/PSTV'99  (Beijing,  China).
          Kluwer   Academic  Publishers,  1999.   Available  from
          http://cadp.inria.fr/publications/Garavel-Sighireanu-
          99.html


     [Groote-Ponse-90]
          J.F. Groote and A. Ponse.  "The syntax and semantics of
          mCRL."  In A. Ponse, C. Verhoef and S.F.M. van Vlijmen,
          editors,  Algebra  of  Communicating   Processes   '94,
          Workshops  in  Computing  Series,  Springer-Verlag, pp.
          26-62, 1995.  Also appeared as:  Technical  Report  CS-
          R9076, CWI, Amsterdam, 1990.


     [ISO-89]



(C) INRIA            Last change: 2020/02/11                   25






CADP MANUAL PAGES                                      EXP(LOCAL)



          ISO/IEC.  "LOTOS ---  A  Formal  Description  Technique
          Based   on   the  Temporal  Ordering  of  Observational
          Behaviour."  International Organization for  Standardi-
          zation --- Information Processing Systems --- Open Sys-
          tems Interconnection.   International  Standard  number
          8807.  Geneva, September 1989.


     [ISO-01]
          ISO/IEC.  "Enhancements to LOTOS (E-LOTOS)."   Interna-
          tional Organization for Standardization --- Information
          Technology.  International Standard number  15437:2001.
          Geneva, September 2001.


     [Lang-05]
          Frederic  Lang.   "EXP.OPEN  2.0:   A   Flexible   Tool
          Integrating  Partial  Order, Compositional, and On-the-
          fly Verification Methods."  In J. van de Pol, J. Romijn
          and  G. Smith, editors, Proceedings of the 5th Interna-
          tional Conference on Integrated Formal Methods IFM'2005
          (Eindhoven,  The  Netherlands).   Lecture Notes in Com-
          puter  Science  volume  3771,  Springer-Verlag,   2005.
          Available  from http://cadp.inria.fr/publications/Lang-
          05.html


     [Lang-06]
          Frederic Lang.  "Refined Interfaces  for  Compositional
          Verification."   In  E. Najm, J.-F. Pradat-Peyre and V.
          Viguie Donzeau-Gouge, editors, Proceedings of the  26th
          IFIP  WG  6.1  International Conference on Formal Tech-
          niques for Networked and Distributed Systems FORTE'2006
          (Paris,  France).   Lecture  Notes  in Computer Science
          volume 4229,  Springer-Verlag,  2006.   Available  from
          http://cadp.inria.fr/publications/Lang-06.html


     [Milner-89]
          Robin   Milner.    "Communication   and   Concurrency."
          Prentice-Hall, 1989.


     [Pace-Lang-Mateescu-03]
          Gordon Pace, Frederic Lang, and Radu Mateescu.  "Calcu-
          lating  tau-confluence  compositionally."  In W.A. Hunt
          Jr. and F. Somenzi, editors, 15th Computer-Aided Verif-
          ication  conference  (CAV  2003), Lecture Notes in Com-
          puter  Science  volume  2725,  Springer-Verlag,   2003.
          Available  from http://cadp.inria.fr/publications/Pace-
          Lang-Mateescu-03.html




(C) INRIA            Last change: 2020/02/11                   26






CADP MANUAL PAGES                                      EXP(LOCAL)



SSSSEEEEEEEE AAAALLLLSSSSOOOO
     aaaallllddddeeeebbbbaaaarrrraaaannnn(LOCAL),  aaaauuuutttt(LOCAL),  bbbbccccgggg(LOCAL),   bbbbccccgggg____iiiioooo(LOCAL),
     ccccaaaaeeeessssaaaarrrr____hhhhiiiiddddeeee____1111(LOCAL),                ccccaaaaeeeessssaaaarrrr____rrrreeeennnnaaaammmmeeee____1111(LOCAL),
     eeeexxxxpppp....ooooppppeeeennnn(LOCAL),    lllloooottttoooossss....ooooppppeeeennnn(LOCAL),     pppprrrroooojjjjeeeeccccttttoooorrrr(LOCAL),
     rrrreeeeggggeeeexxxxpppp(LOCAL), sssseeeeqqqq(LOCAL), ssssvvvvllll(LOCAL)

     Additional information is available from the CADP  Web  page
     located at http://cadp.inria.fr

     Directives   for   installation   are   given    in    files
     $$$$CCCCAAAADDDDPPPP////IIIINNNNSSSSTTTTAAAALLLLLLLLAAAATTTTIIIIOOOONNNN____****....

     Recent  changes  and  improvements  to  this  software   are
     reported and commented in file $$$$CCCCAAAADDDDPPPP////HHHHIIIISSSSTTTTOOOORRRRYYYY....


BBBBUUUUGGGGSSSS
     Please report bugs to cadp@inria.fr





































(C) INRIA            Last change: 2020/02/11                   27



