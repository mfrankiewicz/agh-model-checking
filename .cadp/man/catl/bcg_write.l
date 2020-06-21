


CADP MANUAL PAGES                                BCG_WRITE(LOCAL)



NNNNAAAAMMMMEEEE
     bcg_write - a simple interface to produce a BCG graph

DDDDEEEESSSSCCCCRRRRIIIIPPPPTTTTIIIIOOOONNNN
     This interface generates a BCG  graph  from  an  application
     program  written  in  C  or C++. To keep things simple, this
     interface does not give access to the whole BCG format,  but
     only to a subset, in which states are assumed to be unsigned
     integer numbers and labels of the edges are  assumed  to  be
     character  strings.   Note: this subset of BCG is equivalent
     to the ....aaaauuuutttt format described in the aaaallllddddeeeebbbbaaaarrrraaaannnn(LOCAL)  manual
     page, although it is much more compact.

UUUUSSSSAAAAGGGGEEEE
     The application program  should  start  with  the  following
     directive:

        ####iiiinnnncccclllluuuuddddeeee """"bbbbccccgggg____uuuusssseeeerrrr....hhhh""""

     Then the BCG library should be initialized by  invoking  the
     following function:

        BBBBCCCCGGGG____IIIINNNNIIIITTTT (((())));;;;

     Not invoking this function might  cause  a  run-time  error,
     e.g.,  a  segmentation  fault. Invoking BBBBCCCCGGGG____IIIINNNNIIIITTTT(((()))) more than
     once is harmless, although not recommended.


DDDDAAAATTTTAAAA TTTTYYYYPPPPEEEESSSS
     The functions of this interface use  the  followings  types,
     whose definitions are provided by the "bcg_user.h" file:

     -    BBBBCCCCGGGG____TTTTYYYYPPPPEEEE____BBBBOOOOOOOOLLLLEEEEAAAANNNN

     -    BBBBCCCCGGGG____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL

     -    BBBBCCCCGGGG____TTTTYYYYPPPPEEEE____CCCC____SSSSTTTTRRRRIIIINNNNGGGG

     -    BBBBCCCCGGGG____TTTTYYYYPPPPEEEE____FFFFIIIILLLLEEEE____NNNNAAAAMMMMEEEE

     -    BBBBCCCCGGGG____TTTTYYYYPPPPEEEE____LLLLAAAABBBBEEEELLLL____SSSSTTTTRRRRIIIINNNNGGGG

     -    BBBBCCCCGGGG____TTTTYYYYPPPPEEEE____SSSSTTTTAAAATTTTEEEE____NNNNUUUUMMMMBBBBEEEERRRR

     -    BBBBCCCCGGGG____TTTTYYYYPPPPEEEE____DDDDAAAATTTTAAAA____FFFFOOOORRRRMMMMAAAATTTT


FFFFEEEEAAAATTTTUUUURRRREEEESSSS
      ............................................................





(C) INRIA            Last change: 2016/06/13                    1






CADP MANUAL PAGES                                BCG_WRITE(LOCAL)



  BBBBCCCCGGGG____IIIIOOOO____WWWWRRRRIIIITTTTEEEE____BBBBCCCCGGGG____BBBBEEEEGGGGIIIINNNN

      BBBBCCCCGGGG____TTTTYYYYPPPPEEEE____BBBBOOOOOOOOLLLLEEEEAAAANNNN BBBBCCCCGGGG____IIIIOOOO____WWWWRRRRIIIITTTTEEEE____BBBBCCCCGGGG____BBBBEEEEGGGGIIIINNNN ((((_f_i_l_e_n_a_m_e,,,,
                   _i_n_i_t_i_a_l__s_t_a_t_e,,,, _f_o_r_m_a_t,,,, _c_o_m_m_e_n_t,,,, _m_o_n_i_t_o_r))))

       BBBBCCCCGGGG____TTTTYYYYPPPPEEEE____FFFFIIIILLLLEEEE____NNNNAAAAMMMMEEEE                    _f_i_l_e_n_a_m_e;;;;
       BBBBCCCCGGGG____TTTTYYYYPPPPEEEE____SSSSTTTTAAAATTTTEEEE____NNNNUUUUMMMMBBBBEEEERRRR                 _i_n_i_t_i_a_l__s_t_a_t_e;;;;
       BBBBCCCCGGGG____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL                      _f_o_r_m_a_t;;;;
       BBBBCCCCGGGG____TTTTYYYYPPPPEEEE____CCCC____SSSSTTTTRRRRIIIINNNNGGGG                     _c_o_m_m_e_n_t;;;;
       BBBBCCCCGGGG____TTTTYYYYPPPPEEEE____BBBBOOOOOOOOLLLLEEEEAAAANNNN                      _m_o_n_i_t_o_r;;;;
       {{{{ ............ }}}}

     This function opens a BCG file. Its arguments have the  fol-
     lowing meaning:

     _f_i_l_e_n_a_m_e
          is a character string containing the path name  of  the
          BCG  file  to be written. It should contain the  "....bbbbccccgggg"
          suffix (if the "....bbbbccccgggg" suffix is  missing,  it  will  be
          added automatically).

     _i_n_i_t_i_a_l__s_t_a_t_e
          is the number of the initial state (usually 0).

     _f_o_r_m_a_t
          is equal to 2 if, in the forthcoming successive invoca-
          tions of function BBBBCCCCGGGG____IIIIOOOO____WWWWRRRRIIIITTTTEEEE____BBBBCCCCGGGG____EEEEDDDDGGGGEEEE(((()))), the sequence
          of actual  values  given  to  the  _s_t_a_t_e_1  argument  of
          BBBBCCCCGGGG____IIIIOOOO____WWWWRRRRIIIITTTTEEEE____BBBBCCCCGGGG____EEEEDDDDGGGGEEEE(((())))  will increase monotonically or
          equal to 1 otherwise. The format 1 applies  in  general
          but  is  less  efficient  in  terms of time or BCG file
          compression.  The format 2 is more efficient  but  only
          applies to specific situations (in particular, when the
          BCG graph is generated in a breadth-first search).

     _c_o_m_m_e_n_t
          is a character string containing information about  the
          application  tool  which  is creating the BCG graph. If
          _c_o_m_m_e_n_t is equal to NULL, then it will be replaced with
          a default string.

     _m_o_n_i_t_o_r
          should be equal to BBBBCCCCGGGG____TTTTRRRRUUUUEEEE if a Tcl/Tk  window  should
          be opened for monitoring in real-time the generation of
          the BCG graph or equal to BBBBCCCCGGGG____FFFFAAAALLLLSSSSEEEE otherwise.

     By default,  if  _f_i_l_e_n_a_m_e  cannot  be  opened  for  writing,
     BBBBCCCCGGGG____IIIIOOOO____WWWWRRRRIIIITTTTEEEE____BBBBCCCCGGGG____BBBBEEEEGGGGIIIINNNN(((()))) will emit an error message and exit
     the program. However, if the following function call:

         BBBBCCCCGGGG____IIIIOOOO____WWWWRRRRIIIITTTTEEEE____BBBBCCCCGGGG____SSSSUUUURRRRVVVVIIIIVVVVEEEE ((((BBBBCCCCGGGG____TTTTRRRRUUUUEEEE))));;;;




(C) INRIA            Last change: 2016/06/13                    2






CADP MANUAL PAGES                                BCG_WRITE(LOCAL)



     has occured before  the  call  to  BBBBCCCCGGGG____IIIIOOOO____WWWWRRRRIIIITTTTEEEE____BBBBCCCCGGGG____BBBBEEEEGGGGIIIINNNN(((()))),
     then  BBBBCCCCGGGG____IIIIOOOO____WWWWRRRRIIIITTTTEEEE____BBBBCCCCGGGG____BBBBEEEEGGGGIIIINNNN(((())))  will  neither  emit an error
     message nor exit the program, but return normally a  boolean
     result  that  is  equal  to BBBBCCCCGGGG____TTTTRRRRUUUUEEEE if and only if _f_i_l_e_n_a_m_e
     cannot be opened.

     Below, we assume that the BBBBCCCCGGGG____IIIIOOOO____WWWWRRRRIIIITTTTEEEE____BBBBCCCCGGGG____BBBBEEEEGGGGIIIINNNN(((())))  function
     has returned successfully.

      ............................................................

  BBBBCCCCGGGG____IIIIOOOO____WWWWRRRRIIIITTTTEEEE____BBBBCCCCGGGG____SSSSUUUURRRRVVVVIIIIVVVVEEEE

      BBBBCCCCGGGG____IIIIOOOO____WWWWRRRRIIIITTTTEEEE____BBBBCCCCGGGG____SSSSUUUURRRRVVVVIIIIVVVVEEEE ((((_m_o_d_e))))

       BBBBCCCCGGGG____TTTTYYYYPPPPEEEE____BBBBOOOOOOOOLLLLEEEEAAAANNNN _m_o_d_e;;;;
       {{{{ ............ }}}}

     This  function  controls  how  the  BBBBCCCCGGGG____IIIIOOOO____WWWWRRRRIIIITTTTEEEE____BBBBCCCCGGGG____BBBBEEEEGGGGIIIINNNN(((())))
     function defined above will behave if the BCG file cannot be
     opened for writing:

     -    If _m_o_d_e equals BBBBCCCCGGGG____FFFFAAAALLLLSSSSEEEE, then BBBBCCCCGGGG____IIIIOOOO____WWWWRRRRIIIITTTTEEEE____BBBBCCCCGGGG____BBBBEEEEGGGGIIIINNNN(((())))
          will  emit  an error message and exit the program. This
          is the default behaviour.

     -    If _m_o_d_e equals BBBBCCCCGGGG____TTTTRRRRUUUUEEEE, then  BBBBCCCCGGGG____IIIIOOOO____WWWWRRRRIIIITTTTEEEE____BBBBCCCCGGGG____BBBBEEEEGGGGIIIINNNN(((())))
          will  neither  emit  an error message nor exit the pro-
          gram,  but  return  a  boolean  result.   The   default
          behaviour can be restored by calling:

         BBBBCCCCGGGG____IIIIOOOO____WWWWRRRRIIIITTTTEEEE____BBBBCCCCGGGG____SSSSUUUURRRRVVVVIIIIVVVVEEEE ((((BBBBCCCCGGGG____FFFFAAAALLLLSSSSEEEE))));;;;

      ............................................................

  BBBBCCCCGGGG____IIIIOOOO____WWWWRRRRIIIITTTTEEEE____BBBBCCCCGGGG____EEEEDDDDGGGGEEEE

      BBBBCCCCGGGG____IIIIOOOO____WWWWRRRRIIIITTTTEEEE____BBBBCCCCGGGG____EEEEDDDDGGGGEEEE ((((_s_t_a_t_e_1,,,, _l_a_b_e_l,,,, _s_t_a_t_e_2))))

       BBBBCCCCGGGG____TTTTYYYYPPPPEEEE____SSSSTTTTAAAATTTTEEEE____NNNNUUUUMMMMBBBBEEEERRRR _s_t_a_t_e_1;;;;
       BBBBCCCCGGGG____TTTTYYYYPPPPEEEE____LLLLAAAABBBBEEEELLLL____SSSSTTTTRRRRIIIINNNNGGGG _l_a_b_e_l;;;;
       BBBBCCCCGGGG____TTTTYYYYPPPPEEEE____SSSSTTTTAAAATTTTEEEE____NNNNUUUUMMMMBBBBEEEERRRR _s_t_a_t_e_2;;;;
       {{{{ ............ }}}}

     This function must be invoked  once  for  each  edge  to  be
     created  in  the  BCG  graph.   It  writes in the previously
     opened BCG file an edge such that _s_t_a_t_e_1 is  the  number  of
     the  origin  state,  _s_t_a_t_e_2 is the number of the destination
     state, and _l_a_b_e_l is a character string containing the label.

     Note: _l_a_b_e_l should not contain the characters newline (''''\\\\nnnn'''')
     or carriage return (''''\\\\rrrr'''').



(C) INRIA            Last change: 2016/06/13                    3






CADP MANUAL PAGES                                BCG_WRITE(LOCAL)



     Note: the invisible (also known as hidden, or tau) label  is
     represented  by  the character string """"iiii"""" (as it is the case
     in LOTOS).

      ............................................................

  BBBBCCCCGGGG____IIIIOOOO____WWWWRRRRIIIITTTTEEEE____BBBBCCCCGGGG____PPPPAAAARRRRSSSSIIIINNNNGGGG

      BBBBCCCCGGGG____IIIIOOOO____WWWWRRRRIIIITTTTEEEE____BBBBCCCCGGGG____PPPPAAAARRRRSSSSIIIINNNNGGGG ((((_d_a_t_a__f_o_r_m_a_t))))

       BBBBCCCCGGGG____TTTTYYYYPPPPEEEE____DDDDAAAATTTTAAAA____FFFFOOOORRRRMMMMAAAATTTT _d_a_t_a__f_o_r_m_a_t;;;;
       {{{{ ............ }}}}

     This function can be (optionally) invoked to modify the  way
     labels are parsed.  For details about label parsing, see the
     LLLLAAAABBBBEEEELLLL PPPPAAAARRRRSSSSIIIINNNNGGGG section below.

     Calling BBBBCCCCGGGG____IIIIOOOO____WWWWRRRRIIIITTTTEEEE____BBBBCCCCGGGG____PPPPAAAARRRRSSSSIIIINNNNGGGG(((()))) with _d_a_t_a__f_o_r_m_a_t equal to
     the  constant  value  BBBBCCCCGGGG____UUUUNNNNPPPPAAAARRRRSSSSEEEEDDDD____DDDDAAAATTTTAAAA____FFFFOOOORRRRMMMMAAAATTTT  disables the
     parsing of labels.

     Calling BBBBCCCCGGGG____IIIIOOOO____WWWWRRRRIIIITTTTEEEE____BBBBCCCCGGGG____PPPPAAAARRRRSSSSIIIINNNNGGGG(((()))) with _d_a_t_a__f_o_r_m_a_t equal to
     the  constant  value  BBBBCCCCGGGG____SSSSTTTTAAAANNNNDDDDAAAARRRRDDDD____DDDDAAAATTTTAAAA____FFFFOOOORRRRMMMMAAAATTTT  enables  the
     parsing of labels.

     By  default  (i.e.,  if  BBBBCCCCGGGG____IIIIOOOO____WWWWRRRRIIIITTTTEEEE____BBBBCCCCGGGG____PPPPAAAARRRRSSSSIIIINNNNGGGG(((())))  is  not
     invoked),  label  parsing  is  enabled.  In order to improve
     inter-operability between tools, we recommend to leave label
     parsing enabled.

     The call to BBBBCCCCGGGG____IIIIOOOO____WWWWRRRRIIIITTTTEEEE____BBBBCCCCGGGG____PPPPAAAARRRRSSSSIIIINNNNGGGG(((()))) must  be  done  after
     invoking       BBBBCCCCGGGG____IIIINNNNIIIITTTT(((())))      and      before      invoking
     BBBBCCCCGGGG____IIIIOOOO____WWWWRRRRIIIITTTTEEEE____BBBBCCCCGGGG____BBBBEEEEGGGGIIIINNNN(((()))).

      ............................................................

  BBBBCCCCGGGG____IIIIOOOO____WWWWRRRRIIIITTTTEEEE____BBBBCCCCGGGG____EEEENNNNDDDD

      BBBBCCCCGGGG____IIIIOOOO____WWWWRRRRIIIITTTTEEEE____BBBBCCCCGGGG____EEEENNNNDDDD (((())))

       {{{{ ............ }}}}

     This function properly closes the BCG file.

      ............................................................

  BBBBCCCCGGGG____IIIIOOOO____WWWWRRRRIIIITTTTEEEE____BBBBCCCCGGGG____AAAABBBBOOOORRRRTTTT

      BBBBCCCCGGGG____IIIIOOOO____WWWWRRRRIIIITTTTEEEE____BBBBCCCCGGGG____AAAABBBBOOOORRRRTTTT (((())))

       {{{{ ............ }}}}




(C) INRIA            Last change: 2016/06/13                    4






CADP MANUAL PAGES                                BCG_WRITE(LOCAL)



     This function stops the generation  of  the  BCG  file,  and
     removes  this file.  This function should be invoked in case
     of a fatal error, so as not to leave an unfinished,  invalid
     BCG file.

      ............................................................

EEEEXXXXAAAAMMMMPPPPLLLLEEEE
     The following piece of C code creates a BCG  graph  with  an
     initial state numbered 0:
     #include "bcg_user.h"
     int main ()
     {
        BCG_TYPE_STATE_NUMBER S1;
        BCG_TYPE_LABEL_STRING L;
        BCG_TYPE_STATE_NUMBER S2;

        BCG_INIT ();
        BCG_IO_WRITE_BCG_BEGIN ("test.bcg", 0, 2, "created by tool", 1);
        /* for each transition labelled with L from state S1 to state S2 */
        {
           BCG_IO_WRITE_BCG_EDGE (S1, L, S2);
        }
        BCG_IO_WRITE_BCG_END ();
        return (0);
     }


LLLLAAAABBBBEEEELLLL PPPPAAAARRRRSSSSIIIINNNNGGGG
     The _l_a_b_e_l argument  passed  to  the  BBBBCCCCGGGG____IIIIOOOO____WWWWRRRRIIIITTTTEEEE____BBBBCCCCGGGG____EEEEDDDDGGGGEEEE(((())))
     function  is  a  character  string  that should only contain
     printable characters; the meaning of "printable" is given by
     the  POSIX isprint() function with locale "C" (namely, ASCII
     characters with decimal codes in the range from 32  to  126,
     bounds  included).  Otherwise,  the  effect is undefined. In
     particular, a label string should  not  be  terminated  with
     line-feed and/or carriage-return characters. Wide characters
     (e.g., UTF-8, UTF-16, etc.) are not supported because  their
     usefulness  for  concurrency  theory  may not be worth their
     complexity.


     The _l_a_b_e_l arguments can  be  interpreted  in  two  different
     ways, depending whether label parsing is enabled or not.


     If label parsing is disabled, each label is  stored  in  the
     generated  BCG file as a 1-tuple (L) whose unique field L is
     exactly the character string passed to  BBBBCCCCGGGG____IIIIOOOO____WWWWRRRRIIIITTTTEEEE____EEEEDDDDGGGGEEEE(((()))).
     In  the  generated  BCG  file, this unique field has the RAW
     type (see the FIELD PARSING section  below  for  information
     about this type).



(C) INRIA            Last change: 2016/06/13                    5






CADP MANUAL PAGES                                BCG_WRITE(LOCAL)



     Note: In legacy BCG files generated by CADP versions  up  to
     2014-h included, this unique field had the STRING type; this
     situation is detected by more recent versions of CADP, which
     automatically  convert  that field to the RAW type to ensure
     backward compatibility.


     The remainder of this section discusses the case where label
     parsing is enabled.


     In such case, each label string is assumed to a notation for
     a  tuple  of  typed  data  values  (V0,  V1, ..., V_n) called
     _f_i_e_l_d_s. The number _n is not necessarily  the  same  for  all
     labels,  meaning  that each label can have its own number of
     fields.


     Therefore, function BBBBCCCCGGGG____IIIIOOOO____WWWWRRRRIIIITTTTEEEE____BBBBCCCCGGGG____EEEEDDDDGGGGEEEE(((()))) will attempt  at
     parsing  its  _l_a_b_e_l  argument  to  cut it into a sequence of
     fields, and analyze each field to infer its type and extract
     its  value.  In  the  resulting  BCG  file,  labels  will be
     represented as tuple of field values.


     Parsing labels is not  mandatory,  but  it  is  recommended,
     because  it  enables  certain model checkers of CADP, namely
     eeeevvvvaaaalllluuuuaaaattttoooorrrr4444(LOCAL) and xxxxttttllll(LOCAL) to  know  about  the  types
     present  in labels and to use field values to express power-
     ful temporal logic properties.


     There are other CADP tools that treat labels as mere charac-
     ter  strings, and do not attempt at considering fields indi-
     vidually.  For  such  tools,  label  parsing  can  still  be
     enabled, as it is (almost) transparent: each label string is
     parsed and stored in the BCG  file  as  a  tuple  of  binary
     fields;  this tuple can later be converted back into a label
     string by those tools that do not  examine  fields.  Notice,
     however,  that this latter label string can be slightly dif-
     ferent from the former one, because of various _n_o_r_m_a_l_i_z_a_t_i_o_n
     actions that will be described below.


     As a tribute to tradition, parsed labels are  not  noted  as
     mathematical  tuples:   """"((((VVVV0000,,,, VVVV1111,,,, VVVV2222,,,, ............,,,, VVVVnnnn))))"""", but use the
     notation for labels established by the CSP and LOTOS process
     algebras: """"VVVV0000 !!!!VVVV1111 !!!!VVVV2222 !!!!............ !!!!VVVVnnnn"""". If there is only one field,
     the label is noted """"VVVV0000"""".






(C) INRIA            Last change: 2016/06/13                    6






CADP MANUAL PAGES                                BCG_WRITE(LOCAL)



     It is recommended to leave one space before the '!!!!'  charac-
     ter  and no space after. Labels that do not follow this con-
     vention will still be parsed properly, but will  be  normal-
     ized under the recommended form if converted back to charac-
     ter strings.


     Rules for label parsing  continue  with  the  next  section,
     which specifically discusses the parsing of label fields.


FFFFIIIIEEEELLLLDDDD PPPPAAAARRRRSSSSIIIINNNNGGGG
     Fields can  be  of  eight  possible  types:  GATE,  BOOLEAN,
     NATURAL, INTEGER, REAL, CHARACTER, STRING, and RAW.


     Note: BCG files generated with versions 1.0 or  1.1  of  the
     BCG  format  (namely, before September 2014) had only six of
     these types. The NATURAL and RAW  types  were  not  defined;
     these files did not contain any value of the CHARACTER type,
     and their STRING type behaved as the current RAW type.


     For some of these eight types, there can be  multiple  field
     notations that lead to the same value. For instance, the two
     different fields """"1111"""" and """"00001111"""" express the same number.  Nor-
     malization also applies to fields and puts them under canon-
     ical textual representation.


     The rules for parsing fields are applied  in  the  following
     order:


     (1)  If the first field V0 of a label starts with  a  letter
          that  is  followed  by  any  number of letters, digits,
          and/or underscore characters, then it is recognized and
          inserted  in  the BCG file as a value of the GATE type.
          This type is an enumerated type that  gathers  all  the
          gate  identifiers contained in the labels of the graph.
          For each  gate  identifier,  a  corresponding  constant
          function of type GATE is inserted in the BCG file.  The
          precise rules  for  translating  fields  denoting  GATE
          values  into  binary  values stored in memory, and vice
          versa, are given by two functions  bbbbccccgggg____ggggaaaatttteeee____ssssccccaaaannnn(((())))  and
          bbbbccccgggg____ggggaaaatttteeee____pppprrrriiiinnnntttt(((()))) defined in file $$$$CCCCAAAADDDDPPPP////iiiinnnnccccllll////aaaaddddtttt____ggggaaaatttteeee....hhhh.


     (2)  If a field is equal to "TTTTRRRRUUUUEEEE" or "FFFFAAAALLLLSSSSEEEE" (or  to  their
          case-insensitive   variants  "ttttrrrruuuueeee",  "ffffaaaallllsssseeee",  "TTTTrrrruuuueeee",
          "FFFFaaaallllsssseeee", etc.), then it is recognized and  inserted  in
          the  BCG  file  as  a  value  of  the BOOLEAN type. The



(C) INRIA            Last change: 2016/06/13                    7






CADP MANUAL PAGES                                BCG_WRITE(LOCAL)



          precise rules for translating fields  denoting  BOOLEAN
          values  into  binary  values stored in memory, and vice
          versa, are given by  two  functions  bbbbccccgggg____bbbboooooooolllleeeeaaaannnn____ssssccccaaaannnn(((())))
          and     bbbbccccgggg____bbbboooooooolllleeeeaaaannnn____pppprrrriiiinnnntttt(((())))     defined     in     file
          $$$$CCCCAAAADDDDPPPP////iiiinnnnccccllll////aaaaddddtttt____bbbboooooooolllleeeeaaaannnn....hhhh.     Normalization    converts
          BOOLEAN  values to upper-case letters, either "TTTTRRRRUUUUEEEE" or
          "FFFFAAAALLLLSSSSEEEE".


     (3)  If a field denotes an unsigned integer number (e.g., 0000,
          1111,  9999999999999999,  etc.), then it is recognized and inserted in
          the BCG file as a value of the NATURAL type. The syntax
          of  NATURAL  fields  is  the  one accepted by the POSIX
          function ssssttttrrrrttttoooouuuullll(3).  The number must not  be  prefixed
          with  a  '++++'  sign.  At  present,  only 32-bit unsigned
          integers are recognized as values of the NATURAL  type;
          larger numbers will be considered as values of the REAL
          type.  The precise rules for translating fields  denot-
          ing NATURAL values into binary values stored in memory,
          and  vice   versa,   are   given   by   two   functions
          bbbbccccgggg____nnnnaaaattttuuuurrrraaaallll____ssssccccaaaannnn(((())))  and  bbbbccccgggg____nnnnaaaattttuuuurrrraaaallll____pppprrrriiiinnnntttt(((()))) defined in
          file $$$$CCCCAAAADDDDPPPP////iiiinnnnccccllll////aaaaddddtttt____nnnnaaaattttuuuurrrraaaallll....hhhh.   Normalization  removes
          leading zeros in NATURAL values.


     (4)  If a field  denotes  a  signed  integer  number  (e.g.,
          -9999,  ++++0000, ++++1111, ++++9999999999999999, etc.), then it is recognized and
          inserted in the BCG file as  a  value  of  the  INTEGER
          type.  The syntax of INTEGER fields is the one accepted
          by the POSIX function ssssttttrrrrttttoooollll(3).  The number  (even  if
          it  is  zero) must be prefixed with either a '++++' or '----'
          sign. At  present,  only  32-bit  signed  integers  are
          recognized  as  values  of the INTEGER type; smaller or
          larger numbers will be considered as values of the REAL
          type.   The precise rules for translating fields denot-
          ing INTEGER values into binary values stored in memory,
          and   vice   versa,   are   given   by   two  functions
          bbbbccccgggg____iiiinnnntttteeeeggggeeeerrrr____ssssccccaaaannnn(((()))) and bbbbccccgggg____iiiinnnntttteeeeggggeeeerrrr____pppprrrriiiinnnntttt(((())))  defined  in
          file  $$$$CCCCAAAADDDDPPPP////iiiinnnnccccllll////aaaaddddtttt____iiiinnnntttteeeeggggeeeerrrr....hhhh.   Normalization removes
          leading zeros in INTEGER values.


     (5)  If a  field  denotes  a  floating-point  number  (e.g.,
          3333....1111444411115555,  ----1111....2222EEEE++++11110000,  etc.),  then  it  is recognized and
          inserted in the BCG file as a value of the  REAL  type.
          The  syntax  of  REAL fields is the one accepted by the
          POSIX  function  ssssttttrrrrttttoooodddd(3).   The  precise  rules   for
          translating  fields  denoting  REAL  values into binary
          values stored in memory, and vice versa, are  given  by
          two   functions  bbbbccccgggg____rrrreeeeaaaallll____ssssccccaaaannnn(((())))  and  bbbbccccgggg____rrrreeeeaaaallll____pppprrrriiiinnnntttt(((())))
          defined in file  $$$$CCCCAAAADDDDPPPP////iiiinnnnccccllll////aaaaddddtttt____rrrreeeeaaaallll....hhhh.   Normalization
          removes  leading  zeros  and  may add trailing zeros to



(C) INRIA            Last change: 2016/06/13                    8






CADP MANUAL PAGES                                BCG_WRITE(LOCAL)



          REAL values.


     (6)  If a  field  denotes  a  character  value  (e.g.,  ''''aaaa'''',
          ''''\\\\000011112222'''',  ''''\\\\xxxx0000AAAA'''', ''''\\\\nnnn'''', etc.), then it is recognized and
          inserted in the BCG file as a value  of  the  CHARACTER
          type.  The  syntax  of CHARACTER fields is a simplified
          subset  of  the  C  language  syntax:  characters   are
          enclosed between single quotes; any printable character
          _c different from the single quote and backslash charac-
          ters  can  be used to form a value '_c'; the octal nota-
          tion '\_o_o_o' (where  _o_o_o  denotes  exactly  three  octal
          digits)  and  the hexadecimal notation '\x_h_h' (where _h_h
          denotes exactly two hexadecimal digits) are  supported;
          the  standard C notations ''''\\\\0000'''', ''''\\\\aaaa'''', ''''\\\\bbbb'''', ''''\\\\ffff'''', ''''\\\\nnnn'''',
          ''''\\\\rrrr'''', ''''\\\\tttt'''', ''''\\\\vvvv'''', ''''\\\\""""'''', ''''\\\\\\\\'''', ''''\\\\'''''''' and ''''\\\\????''''   are  also
          supported;  notice  that the single quote and backslash
          characters must be always be escaped with a  backslash,
          whereas the double quote and interrogation mark charac-
          ters may be escaped or not, e.g.,  ''''""""''''  or  ''''\\\\""""''''.   The
          precise rules for translating fields denoting CHARACTER
          values into binary values stored in  memory,  and  vice
          versa,  are given by two functions bbbbccccgggg____cccchhhhaaaarrrraaaacccctttteeeerrrr____ssssccccaaaannnn(((())))
          and    bbbbccccgggg____cccchhhhaaaarrrraaaacccctttteeeerrrr____pppprrrriiiinnnntttt(((())))    defined     in     file
          $$$$CCCCAAAADDDDPPPP////iiiinnnnccccllll////aaaaddddtttt____cccchhhhaaaarrrraaaacccctttteeeerrrr....hhhh.  Normalization converts any
          unprintable CHARACTER value (the  meaning   of  "print-
          able" being given  by the POSIX isprint() function with
          locale "C") into three-digit octal notation;  printable
          CHARACTER  values  are displayed as such; for instance,
          ''''\\\\nnnn'''' and ''''\\\\xxxx22223333''''  are  normalized  as  ''''\\\\000011112222''''  and  ''''####'''',
          respectively.


     (7)  If  a  field  denotes  a  string   value   (e.g.,   """""""",
          """"aaaa\\\\000011112222\\\\xxxx00004444\\\\nnnn"""",   etc.),   then  it  is  recognized  and
          inserted in the BCG file as a value of the STRING type.
          The  syntax of STRING fields is a subset of that of the
          C language:  characters  are  enclosed  between  double
          quotes and follow the same notations as for the CHARAC-
          TER type. The only two differences are  the  following:
          single  quotes (which are always escaped in characters)
          can be escaped or not in strings, while  double  quotes
          (which  can  be  escaped  or not in characters) must be
          escaped in strings. The precise rules  for  translating
          fields denoting STRING values into binary values stored
          in memory, and vice versa, are given by  two  functions
          bbbbccccgggg____ssssttttrrrriiiinnnngggg____ssssccccaaaannnn(((())))  and  bbbbccccgggg____ssssttttrrrriiiinnnngggg____pppprrrriiiinnnntttt(((())))  defined  in
          file  $$$$CCCCAAAADDDDPPPP////iiiinnnnccccllll////aaaaddddtttt____ssssttttrrrriiiinnnngggg....hhhh.   Normalization  follows
          the  same  rules  as  for the CHARACTER type. If a null
          character (noted '\\\\0000', '\\\\000000000000', or '\\\\xxxx00000000') occurs in the
          middle  of  a  field,  the remaining characters of this
          field will be ignored.



(C) INRIA            Last change: 2016/06/13                    9






CADP MANUAL PAGES                                BCG_WRITE(LOCAL)



     (8)  If a field does not match any of the rules above (e.g.,
          xxxx++++yyyy,  ccccoooonnnnssss  ((((1111,,,,  nnnniiiillll)))),  etc.), then it is considered as
          "raw data" and inserted in the BCG file as a  value  of
          the  RAW  type. This type gathers all values whose type
          cannot be determined easily. In particular,  any  empty
          field  is considered as a value of type RAW. A field of
          type RAW may  also  contain  "embedded"  character  and
          string  values  (e.g.,  ppppaaaaiiiirrrr  ((((""""nnnnaaaammmmeeee"""",,,, ''''kkkk'''',,,, 22228888)))), etc.).
          Characters in RAW fields follow the same  notations  as
          for  the  CHARACTER type. The '!!!!' character, which usu-
          ally signals the end  of  the  current  field  and  the
          beginning of a new field, may occur in a RAW field pro-
          vided that it is escaped (i.e., noted '\\\\!!!!', '\\\\000044441111',  or
          '\\\\xxxx22221111');  however,  this  character does not need to be
          escaped if it occurs in an  embedded  character  or  an
          embedded  string.  Values of the RAW type are stored in
          memory  as  byte  strings.   The  precise   rules   for
          translating  fields  denoting  RAW  values  into binary
          values stored in memory, and vice versa, are  given  by
          two   functions   bbbbccccgggg____rrrraaaawwww____ssssccccaaaannnn(((())))   and  bbbbccccgggg____rrrraaaawwww____pppprrrriiiinnnntttt(((())))
          defined in file $$$$CCCCAAAADDDDPPPP////iiiinnnnccccllll////aaaaddddtttt____rrrraaaawwww....hhhh.


     To summarize the effects of label parsing and  normalization
     on  one  example,  the following label string """"   GGGG!!!!  ttttrrrruuuueeee !!!!
     000000003333!!!!++++00001111EEEE++++0000   """" passed  to  function  BBBBCCCCGGGG____IIIIOOOO____WWWWRRRRIIIITTTTEEEE____BBBBCCCCGGGG____EEEEDDDDGGGGEEEE(((())))
     will be stored in the BCG file as a tuple (G, TRUE, 3, 1.0).
     If converted back to a character string, it will display  as
     "G !TRUE !3 !1.000000".


CCCCOOOOMMMMPPPPIIIILLLLIIIINNNNGGGG AAAANNNNDDDD LLLLIIIINNNNKKKK EEEEDDDDIIIITTTTIIIINNNNGGGG
     To compile the application tool, the following options  must
     be passed to the C or C++ compiler:

     ----IIII$$$$CCCCAAAADDDDPPPP////iiiinnnnccccllll ----LLLL$$$$CCCCAAAADDDDPPPP////bbbbiiiinnnn....````$$$$CCCCAAAADDDDPPPP////ccccoooommmm////aaaarrrrcccchhhh```` ----llllBBBBCCCCGGGG____IIIIOOOO ----llllBBBBCCCCGGGG ----llllmmmm

     as in, e.g.,

          $CADP/src/com/cadp_cc tool.c -o tool -I$CADP/incl \
          -L$CADP/bin.`$CADP/com/arch` -lBCG_IO -lBCG -lm


EEEEXXXXIIIITTTT SSSSTTTTAAAATTTTUUUUSSSS
     Application tools share common conventions with  respect  to
     diagnostics.   Exit  status is 0 if everything is alright, 1
     otherwise.


AAAAUUUUTTTTHHHHOOOORRRRSSSS
     Hubert Garavel (definition of the  BCG  format)  and  Renaud
     Ruffiot (implementation of the BCG environment).



(C) INRIA            Last change: 2016/06/13                   10






CADP MANUAL PAGES                                BCG_WRITE(LOCAL)



FFFFIIIILLLLEEEESSSS
     See the bbbbccccgggg(LOCAL) manual page  for  a  description  of  the
     files.


SSSSEEEEEEEE AAAALLLLSSSSOOOO
     bbbbccccgggg(LOCAL)

     Additional information is available from the CADP  Web  page
     located at http://cadp.inria.fr

     Directives   for   installation   are   given    in    files
     $$$$CCCCAAAADDDDPPPP////IIIINNNNSSSSTTTTAAAALLLLLLLLAAAATTTTIIIIOOOONNNN____****....

     Recent  changes  and  improvements  to  this  software   are
     reported and commented in file $$$$CCCCAAAADDDDPPPP////HHHHIIIISSSSTTTTOOOORRRRYYYY....


BBBBUUUUGGGGSSSS
     Please report bugs to Hubert.Garavel@inria.fr



































(C) INRIA            Last change: 2016/06/13                   11



