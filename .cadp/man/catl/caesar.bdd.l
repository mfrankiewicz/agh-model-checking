


CADP MANUAL PAGES                               CAESAR.BDD(LOCAL)



NNNNAAAAMMMMEEEE
     caesar.bdd - structural and behavioural analysis of  Nested-
     Unit Petri Nets


SSSSYYYYNNNNOOOOPPPPSSSSIIIISSSS
     ccccaaaaeeeessssaaaarrrr....bbbbdddddddd _o_p_t_i_o_n [ _f_i_l_e_n_a_m_e....nnnnuuuuppppnnnn ]


DDDDEEEESSSSCCCCRRRRIIIIPPPPTTTTIIIIOOOONNNN
     Taking as input _f_i_l_e_n_a_m_e....nnnnuuuuppppnnnn (or by  default  the  standard
     input),  which  contains  a  Nested-Unit  Petri  Net  (NUPN)
     encoded in the nnnnuuuuppppnnnn(LOCAL) format, ccccaaaaeeeessssaaaarrrr....bbbbdddddddd performs vari-
     ous  structural  or  behavioural  analyses, depending on the
     _o_p_t_i_o_n  specified  on  the  command-line,  and  writes   the
     corresponding  results  to  the  standard  output. Error and
     warning messages, if any,  are  displayed  on  the  standard
     error.


     See the nnnnuuuuppppnnnn(LOCAL) manual page for a detailed definition of
     the NUPN file format.


     For performance reasons, most options of  ccccaaaaeeeessssaaaarrrr....bbbbdddddddd  assume
     that  the contents of _f_i_l_e_n_a_m_e....nnnnuuuuppppnnnn are correct.  When deal-
     ing with an unknown Nested-Unit Petri Net, it is thus advis-
     able  to first analyze its contents with ----cccchhhheeeecccckkkk before using
     any other option. Indeed, these other options often  perform
     less stringent verifications than ----cccchhhheeeecccckkkk, or even no verifi-
     cation at all. In particular, options  ----ddddeeeeaaaadddd----ppppllllaaaacccceeeessss,  ----ddddeeeeaaaadddd----
     ttttrrrraaaannnnssssiiiittttiiiioooonnnnssss,  ----ccccoooonnnnccccuuuurrrrrrrreeeennnntttt----ppppllllaaaacccceeeessss, and ----ccccoooonnnnccccuuuurrrrrrrreeeennnntttt----uuuunnnniiiittttssss rely
     on an optimized encoding of markings, which is only  correct
     if  markings  are  safe  or  unit-safe,  and may may produce
     invalid results if this is not the case.


     Also, most options of ccccaaaaeeeessssaaaarrrr....bbbbdddddddd do not  take  into  account
     the various pragmas that may be present in _f_i_l_e_n_a_m_e....nnnnuuuuppppnnnn. As
     a    general    rule,    the    pragmas    "!!!!mmmmuuuullllttttiiiipppplllleeee____aaaarrrrccccssss",
     "!!!!mmmmuuuullllttttiiiipppplllleeee____iiiinnnniiiittttiiiiaaaallll____ttttooookkkkeeeennnnssss",  and  "!!!!uuuunnnniiiitttt____ssssaaaaffffeeee" (see the sec-
     tion on pragmas in the nnnnuuuuppppnnnn(LOCAL)  format  definition)  are
     ignored, unless explicitly stated otherwise below.


OOOOPPPPTTTTIIIIOOOONNNNSSSS
     ----cccchhhheeeecccckkkk
          Perform syntactic, structural and behavioural  analysis
          of  the  Nested-Unit  Petri  Net  to verify whether the
          stated constraints of the NUPN  format  are  satisfied.
          The  ----cccchhhheeeecccckkkk option performs additional checks and warns
          about redundant or void units.  In  addition  to  these



(C) INRIA            Last change: 2020/05/13                    1






CADP MANUAL PAGES                               CAESAR.BDD(LOCAL)



          static  checks,  the  ----cccchhhheeeecccckkkk  option  also explores the
          marking graph using BDDs  (Binary  Decision  Diagrams),
          prints  the number of states reached at each iteration,
          and checks whether all reachable markings are one  safe
          and  unit  safe;  such  checks  are inconclusive if the
          marking graph is too large  for  being  generated.  The
          warning  and  error messages emitted by this option may
          differ depending on whether the "!!!!uuuunnnniiiitttt____ssssaaaaffffeeee" pragma  is
          present or absent.


     ----aaaarrrrccccssss
          Display the number of arcs  in  the  Nested-Unit  Petri
          Net.


     ----bbbbiiiittttssss
          Display the number of bits needed to encode (using  the
          best  encoding)  the  markings of the Nested-Unit Petri
          Net.


     ----ccccoooonnnnccccuuuurrrrrrrreeeennnntttt----ppppllllaaaacccceeeessss
          Explore the set of reachable markings to determine  the
          pairs  of "concurrent" places, i.e., pairs of places Pi
          and Pj such that Pi = Pj or there  exists  a  reachable
          marking  containing  both Pi and Pj. The exploration of
          the set of reachable markings may be  incomplete  if  a
          timeout  (see  below)  is  specified.   The  output  is
          defined as follows: Let P be the number  of  places  in
          the  Nested-Unit  Petri  Net;  ccccaaaaeeeessssaaaarrrr....bbbbdddddddd writes to the
          standard output a list of  P*(P+1)/2  character  values
          corresponding  to  the  lower  half of a matrix indexed
          according to increasing place  numbers;  this  list  of
          characters  is  displayed  as  a  sequence  of lines of
          increasing length; the upper half of the matrix is  not
          displayed  because  it  enjoys a symmetry property (see
          below).
          In a first approximation, the character written at  the
          intersection  of  row  i  and column j is either "1111" if
          places Pi and pj are concurrent, "0000"  if  these  places
          are not concurrent, or "...." if the answer is unknown.
          Actually, beyond these three values, there are six more
          possible   values:   "====",   "<<<<",  and  ">>>>",  which  are
          equivalent to "0000" (i.e., non-concurrent), and "~~~~", "[[[[",
          and "]]]]", which are equivalent to "...." (i.e., unknown).
          The meaning of these nine values is defined as follows.
          The NUPN is said to be "presumably unit safe" if either
          the exploration was complete and the NUPN was found  to
          be unit safe, or the exploration was incomplete and the
          "!!!!uuuunnnniiiitttt____ssssaaaaffffeeee" pragma is present.  Line i corresponds  to
          place  Pi  (belonging to unit Ui) and row j corresponds



(C) INRIA            Last change: 2020/05/13                    2






CADP MANUAL PAGES                               CAESAR.BDD(LOCAL)



          to place Pj (belonging  to  unit  Uj).   The  character
          written at the intersection of row i and column j (with
          i != j, i.e., for each non-diagonal element)  is  equal
          to:
          - "====": if the NUPN is presumably  unit  safe  and  both
          places belong to the same unit, i.e., Ui = Uj;
          - "<<<<": if the NUPN is presumably unit safe and the unit
          of  Pi  is contained in the unit of Pj, i.e., Sub* (Ui,
          Uj), where the  Sub*  predicate  is  specified  in  the
          nnnnuuuuppppnnnn(LOCAL) format definition;
          - ">>>>": if the NUPN is presumably unit safe and the unit
          of Pi contains the unit of Pj, i.e., Sub* (Uj, Ui);
          - "1111": if none of the above applies, and a marking con-
          taining both Pi and Pj was reached;
          - "~~~~": if the NUPN is not presumably unit safe and both
          places are different and belong to the same unit, i.e.,
          (Pi != Pj) and (Ui = Uj);
          - "[[[[": if the NUPN is not presumably unit safe and  the
          unit  of  Pi is contained in the unit of Pj, i.e., Sub*
          (Ui, Uj);
          - "]]]]": if the NUPN is not presumably unit safe and  the
          unit  of  Pi  contains  the unit of Pj, i.e., Sub* (Uj,
          Ui);
          - "0000": if none of the above applies, and  the  explora-
          tion was complete and no marking containing both Pi and
          Pj was reached;
          - "....": if none of the above applies, and  the  explora-
          tion  was  incomplete and no marking containing both Pi
          and Pj was reached.
          Concerning diagonal elements, the character written  at
          the intersection of row i and column i is equal to:
          - "1111": if a marking containing Pi was reached (i.e., Pi
          is not a dead place);
          - "0000": if the exploration was complete and  no  marking
          containing Pi was reached (i.e., Pi is a dead place);
          - "....": if the exploration was incomplete and no marking
          containing Pi was reached.
          The lower half and upper half of the  matrix  are  sym-
          metric  modulo  permutations of "<<<<" and ">>>>", and of "[[[["
          and "]]]]".  Each line of the lower half of the matrix  is
          compressed  using  the algorithm described below in the
          section entitled "COMPRESSION ALGORITHM".


     ----ccccoooonnnnccccuuuurrrrrrrreeeennnntttt----uuuunnnniiiittttssss
          Explore the set of reachable markings and determine the
          pairs  of  "concurrent"  units, i.e., pairs of units Ui
          and Uj that satisfy the  predicate  Disjoint  (Ui,  Uj)
          specified  in  the  nnnnuuuuppppnnnn(LOCAL)  format definition, and
          such that there exists at least one  reachable  marking
          containing one place of Ui and one place of Uj.




(C) INRIA            Last change: 2020/05/13                    3






CADP MANUAL PAGES                               CAESAR.BDD(LOCAL)



          The output is defined as follows: Let U be  the  number
          of  units  in  the  Nested-Unit  Petri  Net; ccccaaaaeeeessssaaaarrrr....bbbbdddddddd
          writes to the standard output a list of U*(U+1)/2 char-
          acter  values  corresponding  to  the  lower  half of a
          matrix indexed according to  increasing  unit  numbers;
          this  list  of characters is displayed as a sequence of
          lines of increasing  length;  the  upper  half  of  the
          matrix  is  not  displayed because it is symmetric; the
          character written at the  intersection  of  row  i  and
          column  j  is  either  "1111"  if units Ui and Uj are con-
          current, "0000" if these units are not concurrent, or  "...."
          if  the  answer  is  unknown because the exploration of
          reachable markings has been interrupted.  Each line  of
          the  lower  half  of the matrix is compressed using the
          algorithm  described  below  in  the  section  entitled
          "COMPRESSION ALGORITHM".


     ----ccccrrrreeeeaaaattttoooorrrr
          Display the name of the creator tool specified  by  the
          !!!!ccccrrrreeeeaaaattttoooorrrr  pragma  if  it  is present in the Nested-Unit
          Petri Net, or  the  empty  string  if  this  pragma  is
          absent.  This  pragma is specified in the "PRAGMA CREA-
          TOR" section of the nnnnuuuuppppnnnn(LOCAL) format definition.


     ----ddddeeeeaaaadddd----ppppllllaaaacccceeeessss
          Explore (parts of) the set  of  reachable  markings  to
          determine  the  set of "dead" places, i.e., places that
          do not belong to any reachable marking.  The output  is
          defined  as  follows:  Let P be the number of places in
          the Nested-Unit Petri Net;  ccccaaaaeeeessssaaaarrrr....bbbbdddddddd  writes  to  the
          standard   output   a   line   of  P  character  values
          corresponding to each place and  ordered  according  to
          increasing  place  numbers;  the  character written for
          each place is either "1111" if the place is dead,  "0000"  if
          the  place is not dead, or "...." if the answer is unknown
          because the exploration of reachable markings has  been
          interrupted. The !!!!uuuunnnniiiitttt____ssssaaaaffffeeee pragma, if present, is used
          to  speed  up  calculations.   The   output   line   is
          compressed  using  the algorithm described below in the
          section entitled "COMPRESSION ALGORITHM".


     ----ddddeeeeaaaadddd----ttttrrrraaaannnnssssiiiittttiiiioooonnnnssss
          Explore (parts of) the set  of  reachable  markings  to
          determine  the set of "dead" transitions, i.e., transi-
          tions that are not enabled in  any  reachable  marking.
          The  output  is defined as follows: Let T be the number
          of transitions in the Nested-Unit Petri Net; ccccaaaaeeeessssaaaarrrr....bbbbdddddddd
          writes  to  the  standard  output a line of T character
          values corresponding to  each  transition  and  ordered



(C) INRIA            Last change: 2020/05/13                    4






CADP MANUAL PAGES                               CAESAR.BDD(LOCAL)



          according to increasing transition numbers; the charac-
          ter written for each transition is either  "1111"  if  the
          transition  is  dead, "0000" if the transition is not dead
          (i.e., quasi-live), or "...."  if the  answer  is  unknown
          because  the exploration of reachable markings has been
          interrupted. The !!!!uuuunnnniiiitttt____ssssaaaaffffeeee pragma, if present, is used
          to   speed   up   calculations.   The  output  line  is
          compressed using the algorithm described below  in  the
          section entitled "COMPRESSION ALGORITHM".


     ----ddddeeeennnnssssiiiittttyyyy
          Display the density of the incidence matrice of the the
          Nested-Unit Petri Net, i.e., the number of arcs divided
          by twice the product of the number  of  places  by  the
          number  of transitions. The density is equal to zero if
          there are no transitions (hence, no arcs).


     ----eeeennnnccccooooddddiiiinnnnggggssss
          Display statistics about the number of bits required to
          represent  the  markings  of  the Nested-Unit Petri Net
          using various possible encodings, namely  those  encod-
          ings described in Section 6 of [Gar19].


     ----hhhheeeeiiiigggghhhhtttt
          Display the height of the unit tree of the  Nested-Unit
          Petri Net. All leaf units have height one, and the root
          unit only increases the height if this unit is not void
          (i.e., has at least one local place).


     ----hhhhwwwwbbbb Display the HWB code of the Nested-Unit Petri Net. This
          code  has  the  form _h_e_i_g_h_t-_w_i_d_t_h-_b_i_t_s, where the three
          fields are those numbers computed by  options  ----hhhheeeeiiiigggghhhhtttt,
          ----wwwwiiiiddddtttthhhh,  and  ----bbbbiiiittttssss,  respectively.  Fields  _h_e_i_g_h_t and
          _w_i_d_t_h are omitted if _w_i_d_t_h is equal to  the  number  of
          places, i.e., if the NUPN is trivial.


     ----iiiiddddlllleeee----uuuunnnniiiittttssss
          Display the list of idle units  (i.e.,  non-void  units
          that  have  no  local place in the initial marking, and
          such that all transitions having  an  output  place  in
          such  a  unit also have an input place in this unit) or
          the empty string if there are  no  such  units  in  the
          Nested-Unit  Petri Net. Idle units are thus a subset of
          dead units (i.e., non-void units having no local  place
          in any reachable marking).





(C) INRIA            Last change: 2020/05/13                    5






CADP MANUAL PAGES                               CAESAR.BDD(LOCAL)



     ----iiiinnnniiiittttiiiiaaaallll----ppppllllaaaacccceeeessss
          Display the list of places present in the initial mark-
          ing.


     ----iiiinnnniiiittttiiiiaaaallll----ttttooookkkkeeeennnnssss
          Display the number of tokens  present  in  the  initial
          marking.   If   present,  the  !!!!mmmmuuuullllttttiiiipppplllleeee____iiiinnnniiiittttiiiiaaaallll____ttttooookkkkeeeennnnssss
          pragma is taken into account.


     ----iiiinnnniiiittttiiiiaaaallll----uuuunnnniiiittttssss
          Display the list of initial  units  (i.e.,  units  that
          contain at least one place present in the initial mark-
          ing). This list is never empty. The same  unit  can  be
          displayed  multiple times if it contains several places
          in the initial marking, meaning  that  the  Nested-Unit
          Petri Net is not unit-safe.


     ----lllleeeeaaaaffff----uuuunnnniiiittttssss
          Display list of leaf units (i.e., units  that  have  no
          sub-unit) in the Nested-Unit Petri Net.


     ----mmmmaaaaxxxx----ccccoooonnnnccccuuuurrrrrrrreeeennnnccccyyyy
          Display (an over-approximation of) the upper bound  for
          the  maximal number of tokens in any reachable marking.
          This option is expected to quickly  compute  a  result,
          even  if  the  Nested-Unit  Petri  Net is large; conse-
          quently, no exhaustive exploration of  reachable  mark-
          ings  is done. This option assumes that the Nested-Unit
          Petri Net is safe, otherwise the  result  displayed  is
          undefined.  The  !!!!uuuunnnniiiitttt____ssssaaaaffffeeee pragma, if present, is used
          to speed up calculations.


     ----mmmmaaaaxxxx----ppppllllaaaacccceeee
          Display the highest place  number  in  the  Nested-Unit
          Petri Net.


     ----mmmmaaaaxxxx----ttttrrrraaaannnnssssiiiittttiiiioooonnnn
          Display the highest transition number  in  the  Nested-
          Unit  Petri Net; if there is no transition, this number
          is equal to zero.


     ----mmmmaaaaxxxx----uuuunnnniiiitttt
          Display the highest  unit  number  in  the  Nested-Unit
          Petri Net.




(C) INRIA            Last change: 2020/05/13                    6






CADP MANUAL PAGES                               CAESAR.BDD(LOCAL)



     ----mmmmcccccccc Undocumented option used to  prepare  or  complete  the
          model  forms of the Model Checking Contest. This option
          computes various structural and behavioural  properties
          of the Nested-Unit Petri Net. The !!!!uuuunnnniiiitttt____ssssaaaaffffeeee pragma, if
          present, is taken into account. If  the  !!!!mmmmuuuullllttttiiiipppplllleeee____aaaarrrrccccssss
          pragma   or   the  !!!!mmmmuuuullllttttiiiipppplllleeee____iiiinnnniiiittttiiiiaaaallll____ttttooookkkkeeeennnnssss  pragma  is
          present,  the  ----mmmmcccccccc  option  computes  structural   and
          behavioural  properties  for  the  original  (non safe)
          Petri Net rather than for the NUPN itself.


     ----mmmmiiiinnnn----ccccoooonnnnccccuuuurrrrrrrreeeennnnccccyyyy
          Display (an under-approximation of) the lower bound for
          the  maximal number of tokens in any reachable marking.
          This option is expected to quickly  compute  a  result,
          even  if  the  Nested-Unit  Petri  Net is large; conse-
          quently, no exhaustive exploration of  reachable  mark-
          ings  is done. This option assumes that the Nested-Unit
          Petri Net is safe, otherwise the  result  displayed  is
          undefined.  The  !!!!uuuunnnniiiitttt____ssssaaaaffffeeee pragma, if present, is used
          to speed up calculations.


     ----mmmmiiiinnnn----ppppllllaaaacccceeee
          Display the lowest  place  number  in  the  Nested-Unit
          Petri Net.


     ----mmmmiiiinnnn----ttttrrrraaaannnnssssiiiittttiiiioooonnnn
          Display the lowest transition number in the Nested-Unit
          Petri  Net;  if  there is no transition, this number is
          equal to one.


     ----mmmmiiiinnnn----uuuunnnniiiitttt
          Display the lowest unit number in the Nested-Unit Petri
          Net.


     ----mmmmuuuullllttttiiiipppplllleeee----aaaarrrrccccssss
          Display the arguments of the !!!!mmmmuuuullllttttiiiipppplllleeee____aaaarrrrccccssss  pragma  if
          it  is  present,  or the empty string if this pragma is
          absent.


     ----mmmmuuuullllttttiiiipppplllleeee----iiiinnnniiiittttiiiiaaaallll----ttttooookkkkeeeennnnssss
          Display the arguments of  the  !!!!mmmmuuuullllttttiiiipppplllleeee____iiiinnnniiiittttiiiiaaaallll____ttttooookkkkeeeennnnssss
          pragma  if  it  is present, or the empty string if this
          pragma is absent.


     ----ppppeeeerrrrmmmmaaaannnneeeennnntttt----uuuunnnniiiittttssss



(C) INRIA            Last change: 2020/05/13                    7






CADP MANUAL PAGES                               CAESAR.BDD(LOCAL)



          Display the list of permanent units (i.e.,  units  that
          have  a  local  place  in the initial marking, and such
          that all transitions having an input place  in  such  a
          unit  also  have  an  output place in this unit) or the
          empty string if there are no such units in the  Nested-
          Unit  Petri  Net.  Permanent units are thus a subset of
          initial units.


     ----ppppllllaaaacccceeeessss
          Display the number of places in the  Nested-Unit  Petri
          Net.


     ----ppppnnnnmmmmllll
          Write to the standard output the  translation  in  PNML
          (Petri  Net Markup Language) the network given as input
          in the NUPN format. The  PNML  output  will  contain  a
          "NUPN-toolspecific"   section   as   defined   on   the
          http://mcc.lip6.fr/nupn.php page.  If the  "!!!!uuuunnnniiiitttt____ssssaaaaffffeeee"
          pragma  is  present,  it is propagated to this section.
          If the input network contains errors,  the  translation
          may  stop prematurely, leaving an incomplete PNML file.
          It is therefore recommended to invoke the tool as  fol-
          lows:
          ccccaaaaeeeessssaaaarrrr....bbbbdddddddd ----ppppnnnnmmmmllll [ _f_i_l_e_n_a_m_e....nnnnuuuuppppnnnn ] >  _f_i_l_e_n_a_m_e....ppppnnnnmmmmllll  ||
          rm -f  _f_i_l_e_n_a_m_e....ppppnnnnmmmmllll


     ----rrrreeeedddduuuunnnnddddaaaannnntttt----uuuunnnniiiittttssss
          Display the list of redundant units (i.e.,  units  that
          have  a  single  sub-unit) or the empty string if there
          are no such units in the Nested-Unit Petri Net.


     ----rrrrooooooootttt----uuuunnnniiiitttt
          Display the number of the root unit of the  Nested-Unit
          Petri Net.


     ----ttttrrrraaaannnnssssiiiittttiiiioooonnnnssss
          Display the number of transitions  in  the  Nested-Unit
          Petri Net.


     ----ttttrrrriiiivvvviiiiaaaallll
          Display "1" if the Nested-Unit Petri Net is trivial, or
          "0" otherwise.


     ----uuuunnnniiiittttssss
          Display the number of units in  the  Nested-Unit  Petri



(C) INRIA            Last change: 2020/05/13                    8






CADP MANUAL PAGES                               CAESAR.BDD(LOCAL)



          Net.


     ----vvvveeeerrrrssssiiiioooonnnn
          Display the current version number of the software.


     ----vvvvooooiiiidddd----nnnnoooonnnnrrrrooooooootttt----uuuunnnniiiittttssss
          Display the list of void units (i.e., units  having  no
          local  place)  that are different from the root unit or
          the empty string if there are  no  such  units  in  the
          Nested-Unit Petri Net. If the net is correct, the empty
          string should be displayed.


     ----vvvvooooiiiidddd----rrrrooooooootttt----uuuunnnniiiitttt
          Display the number of the root unit  if  this  unit  is
          void  (i.e.,  has  no  local place) or the empty string
          otherwise.


     ----vvvvooooiiiidddd----uuuunnnniiiittttssss
          Display the list of void units (i.e., units  having  no
          local  place,  possibly including the root unit) or the
          empty string if there are no such units in the  Nested-
          Unit Petri Net.


     ----wwwwiiiiddddtttthhhh
          Display the width of the unit tree of  the  Nested-Unit
          Petri  Net.  This  width is equal to the number of leaf
          units.


IIIINNNNTTTTEEEERRRRRRRRUUUUPPPPTTTTSSSS
     ccccaaaaeeeessssaaaarrrr....bbbbdddddddd handles certain POSIX interrupt signals  (namely,
     SIGINT,   SIGQUIT,  SIGALRM,  and  SIGTERM)  and  adapt  its
     behaviour in consequence. Upon reception of such a signal:

     -    The execution of  options  ----cccchhhheeeecccckkkk,  ----ccccoooonnnnccccuuuurrrrrrrreeeennnntttt----ppppllllaaaacccceeeessss,
          ----ccccoooonnnnccccuuuurrrrrrrreeeennnntttt----uuuunnnniiiittttssss, ----ddddeeeeaaaadddd----ppppllllaaaacccceeeessss, ----ddddeeeeaaaadddd----ttttrrrraaaannnnssssiiiittttiiiioooonnnnssss, and
          ----mmmmcccccccc stops the BDD-based exploration of reachable mark-
          ings,   and  completes  using  pessimistic  assumptions
          (i.e., the fact that parts of the  marking  graph  have
          not been explored) delivering less precise, yet correct
          results.

     -    The execution of other options terminates  immediately,
          returning the exit code 5 (see below).






(C) INRIA            Last change: 2020/05/13                    9






CADP MANUAL PAGES                               CAESAR.BDD(LOCAL)



UUUUSSSSEEEERRRR----SSSSPPPPEEEECCCCIIIIFFFFIIIIEEEEDDDD TTTTIIIIMMMMEEEEOOOOUUUUTTTTSSSS
     The environment variable $$$$CCCCAAAAEEEESSSSAAAARRRR____BBBBDDDDDDDD____TTTTIIIIMMMMEEEEOOOOUUUUTTTT can be used  to
     specify a maximal duration for marking graph exploration. If
     this variable is set to a strictly positive integer  _N,  the
     exploration  of the marking graph will stop after _N seconds.
     If this variable is set to  zero,  the  exploration  of  the
     marking  graph is disabled, meaning only the initial marking
     is visited. If this variable  is  not  set  (or  set  to  an
     invalid  value,  such  as  "" or -1), the exploration of the
     marking graph is performed without timeout.  Upon expiration
     of a timeout:

     -    The execution of option ----cccchhhheeeecccckkkk terminates  immediately,
          returning the exit code 5 (see below).

     -    The   execution    of    options    ----ccccoooonnnnccccuuuurrrrrrrreeeennnntttt----ppppllllaaaacccceeeessss,
          ----ccccoooonnnnccccuuuurrrrrrrreeeennnntttt----uuuunnnniiiittttssss,  ----ddddeeeeaaaadddd----ppppllllaaaacccceeeessss, and ----ddddeeeeaaaadddd----ttttrrrraaaannnnssssiiiittttiiiioooonnnnssss
          stops the BDD-based exploration of reachable  markings,
          and completes using pessimistic assumptions.

     -    The execution of option  ----mmmmcccccccc  completes  by  computing
          behavioural  properties  using  faster  algorithms that
          rely on pessimistic assumptions.

     The functionality provided by this environment  variable  is
     not available on Windows.


CCCCOOOOMMMMPPPPRRRREEEESSSSSSSSIIIIOOOONNNN AAAALLLLGGGGOOOORRRRIIIITTTTHHHHMMMM
     The  output  of   the   four   options   ----ccccoooonnnnccccuuuurrrrrrrreeeennnntttt----ppppllllaaaacccceeeessss,
     ----ccccoooonnnnccccuuuurrrrrrrreeeennnntttt----uuuunnnniiiittttssss,  ----ddddeeeeaaaadddd----ppppllllaaaacccceeeessss,  and  ----ddddeeeeaaaadddd----ttttrrrraaaannnnssssiiiittttiiiioooonnnnssss is
     compressed using a  simple  algorithm  based  on  run-length
     encoding:  when  a  character  is  followed  by an integer _n
     greater than 3 enclosed between parentheses, it  means  that
     this  character must be repeated _n times, including its ini-
     tial occurrence.  For instance, the  following  sequence  of
     characters:
         01110000101100000011.0000000110011111011111110.10........001111
     is compressed as:
         01110(4)10110(6)11.0(7)11001(5)01(7)0.10.(8)001(4)


     The compression algorithm is implemented as follows in the C
     language:

     #include <stdio.h>
     int main ()
     {
         char C, PREVIOUS = '\0';
         int  N, REPEAT = 0;
         while (1) {
             C = getchar ();



(C) INRIA            Last change: 2020/05/13                   10






CADP MANUAL PAGES                               CAESAR.BDD(LOCAL)



             if (C == PREVIOUS) {
                 /* assert (C != '\0') && (C != EOF) && (C != '\n') */
                 ++ REPEAT;
             } else {
                 /* flush the repetition buffer, if any */
                 if (REPEAT > 3) {
                     printf ("(%d)", REPEAT);
                 } else if (REPEAT > 0) {
                     for (N = 1; N < REPEAT; ++ N)
                         putchar (PREVIOUS);
                 }
                 if (C == EOF)
                     return 0;
                 putchar (C);
                 if (C == '0) {
                     PREVIOUS = '\0';
                     REPEAT = 0;
                 } else {
                     PREVIOUS = C;
                     REPEAT = 1;
                 }
             }
         }
     }


     This algorithm enjoys three  nice  properties:  (1)  it  can
     operate  on  the fly (e.g., using coroutines, pipes, or data
     streams), meaning that it is not mandatory to  generate  the
     input  entirely before starting to compress it; (2) the size
     (in characters) of the compressed output is always  less  or
     equal  to  the size of the input; (3) compressing an already
     compressed input has no effect.


DDDDEEEECCCCOOOOMMMMPPPPRRRREEEESSSSSSSSIIIIOOOONNNN AAAALLLLGGGGOOOORRRRIIIITTTTHHHHMMMM
     The compressed  output  of  the  four  options  ----ccccoooonnnnccccuuuurrrrrrrreeeennnntttt----
     ppppllllaaaacccceeeessss,    ----ccccoooonnnnccccuuuurrrrrrrreeeennnntttt----uuuunnnniiiittttssss,   ----ddddeeeeaaaadddd----ppppllllaaaacccceeeessss,   and   ----ddddeeeeaaaadddd----
     ttttrrrraaaannnnssssiiiittttiiiioooonnnnssss is decompressed using a simple algorithm, imple-
     mented as follows in the C language:

     #include <stdio.h>
     int main ()
     {
         char C, PREVIOUS = '\0';
         int  REPEAT = 0;
         while (1) {
             if (REPEAT > 0) {
                 /* assert (PREVIOUS != '\0') && (PREVIOUS != '\n') */
                 putchar (PREVIOUS);
                 -- REPEAT;
             } else {



(C) INRIA            Last change: 2020/05/13                   11






CADP MANUAL PAGES                               CAESAR.BDD(LOCAL)



                 C = getchar ();
                 if (C == EOF)
                     return 0;
                 if (C != '(') {
                     putchar (C);
                     PREVIOUS = C;
                 } else {
                     scanf ("%d)", &REPEAT);
                     /* assert REPEAT > 3 */
                     -- REPEAT;
                 }
             }
         }
     }


     This algorithm can operate on the fly; for instance, one can
     compare  two  (or  more)  compressed files without having to
     decompress them entirely in advance.


EEEEXXXXIIIITTTT SSSSTTTTAAAATTTTUUUUSSSS
     The exit status of ccccaaaaeeeessssaaaarrrr....bbbbdddddddd may take the following values:
       0:   normal termination (everything is alright)
       1:   memory shortage (Petri Net and/or BDDs are too large)
       2:   incorrect command-line arguments for ccccaaaaeeeessssaaaarrrr....bbbbdddddddd
       3:   _f_i_l_e_n_a_m_e....nnnnuuuuppppnnnn does not exist or is unreadable
       4:   syntax or semantic error in _f_i_l_e_n_a_m_e....nnnnuuuuppppnnnn
       5:   ccccaaaaeeeessssaaaarrrr....bbbbdddddddd terminated by the user (SIGINT or SIGQUIT)
            or upon timeout (SIGALRM or SIGTERM)
       6:   the net given in _f_i_l_e_n_a_m_e....nnnnuuuuppppnnnn is  not  safe  or  not
            unit safe
     Any other value corresponds to an unexpected error.

AAAAUUUUTTTTHHHHOOOORRRRSSSS
     Damien Bergamini and Hubert Garavel (INRIA Rhone-Alpes)

FFFFIIIILLLLEEEESSSS
     _f_i_l_e_n_a_m_e....nnnnuuuuppppnnnn    Nested-Unit Petri Net (input)

CCCCRRRREEEEDDDDIIIITTTTSSSS
     To perform its behavioural  analyses,  ccccaaaaeeeessssaaaarrrr....bbbbdddddddd  uses  the
     Binary Decision Diagram package CUDD (Release 3.0) developed
     by Fabio Somenzi at the University of Colorado (Boulder, CO,
     USA).

BBBBIIIIBBBBLLLLIIIIOOOOGGGGRRRRAAAAPPPPHHHHYYYY
     [Gar19] Hubert Garavel. "Nested-Unit Petri  Nets".   Journal
     of  Logical  and Algebraic Methods in Programming, vol. 104,
     pages     60-85,     April     2019.     Available      from
     http://cadp.inria.fr/publications/Garavel-19.html




(C) INRIA            Last change: 2020/05/13                   12






CADP MANUAL PAGES                               CAESAR.BDD(LOCAL)



     [Gar15] Hubert Garavel.  "Nested-Unit Petri Nets:  A  Struc-
     tural Means to Increase Efficiency and Scalability of Verif-
     ication on Elementary Nets".  In R. Devillers  and  A.  Val-
     mari, editors, Proceedings of the 36th International Confer-
     ence on Application and Theory of Petri Nets and Concurrency
     (PETRI  NETS'15),  Brussels,  Belgium. Lecture Notes in Com-
     puter Science, vol.  9115,  Springer,  2015.  Superseded  by
     [Gar19].                    Available                   from
     http://cadp.inria.fr/publications/Garavel-15-a.html

SSSSEEEEEEEE AAAALLLLSSSSOOOO
     ccccaaaaeeeessssaaaarrrr(LOCAL), nnnnuuuuppppnnnn(LOCAL), nnnnuuuuppppnnnn____iiiinnnnffffoooo(LOCAL)

     Additional information is available from the CADP  Web  page
     located at http://cadp.inria.fr
     Directives   for   installation   are   given    in    files
     $$$$CCCCAAAADDDDPPPP////IIIINNNNSSSSTTTTAAAALLLLLLLLAAAATTTTIIIIOOOONNNN____****....
     Recent  changes  and  improvements  to  this  software   are
     reported and commented in file $$$$CCCCAAAADDDDPPPP////HHHHIIIISSSSTTTTOOOORRRRYYYY....
BBBBUUUUGGGGSSSS
     Please report new bugs to Hubert.Garavel@inria.fr


































(C) INRIA            Last change: 2020/05/13                   13



