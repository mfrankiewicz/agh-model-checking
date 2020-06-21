


CADP MANUAL PAGES                                      SEQ(LOCAL)



NNNNAAAAMMMMEEEE
     seq, SEQ - CADP common format for execution sequences (i.e.,
     traces)


DDDDEEEESSSSCCCCRRRRIIIIPPPPTTTTIIIIOOOONNNN
     The SEQ format (where _S_E_Q stands for _S_E_Q_u_e_n_c_e)  is  used  to
     specify a finite set (possibly empty) of execution sequences
     belonging to a Labelled Transition  System  (LTS).  Each  of
     these  sequences is finite and starts from the initial state
     of the LTS. Thus, a SEQ file specifies  a  subgraph  of  the
     LTS;  in this subgraph, only the initial state may have more
     than one successor  state  (namely,  if  there  are  several
     sequences).


     The SEQ format has been  carefully  designed  so  as  to  be
     easily  readable  and  writable  by both humans and computer
     programs. For this reason, it is a  character-based  format.
     Files  in  the SEQ format are expected to have a ....sssseeeeqqqq exten-
     sion.


     There are two versions of the SEQ format:


     -    In the _s_i_m_p_l_e _f_o_r_m_a_t, execution  sequences  are  merely
          specified  as  lists  of  transition labels; labels are
          specified as character strings.


     -    In the _f_u_l_l _f_o_r_m_a_t, execution sequences  are  specified
          in a more sophisticated way, using regular expressions;
          labels are represented either as character  strings  or
          regular expressions.


     Both versions of the SEQ format are compatible in the  sense
     that  the  simple  format  is  a  subset of the full format.
     Therefore, the simple format can  be  used  at  every  place
     where the full format is allowed.


BBBBNNNNFFFF----LLLLIIIIKKKKEEEE NNNNOOOOTTTTAAAATTTTIIIIOOOONNNN
     The syntax of the SEQ format  is  described  below  using  a
     notation  similar  to  the  BNF (Backus-Naur Form) notation.
     However, as the angle brackets <<<< and >>>> used in BNF are  also
     meaningful  in  the  SEQ  format, there are some differences
     with respect to the standard BNF notation:


     -    Terminal symbols are enclosed in simple quotes, whether



(C) INRIA            Last change: 2019/01/14                    1






CADP MANUAL PAGES                                      SEQ(LOCAL)



          they  are one or several characters long (for instance:
          ''''++++'''', ''''""""'''', ''''<<<<wwwwhhhhiiiilllleeee>>>>'''', etc.).  In  particular,  ''''\\\\nnnn''''  and
          ''''\\\\tttt'''' denote the newline and tabulation characters.


     -    Non-terminal symbols are written as alphabetic identif-
          iers  (for  instance,  sssseeeeqqqquuuueeeennnncccceeee,  sssseeeeqqqquuuueeeennnncccceeee____lllliiiisssstttt, etc.).
          Contrary to the  standard  BNF  notation,  non-terminal
          symbols are not enclosed within angle brackets.


     -    The following meta symbols are used, with  their  usual
          meaning:   parentheses  for grouping, star (****) for zero
          or more repeated occurrences, and vertical bar (||||)  for
          alternates.


     Note: it should be understood that **** and ''''****'''' do not have the
     same   meaning:  the  former  is  the  meta-symbol  denoting
     repeated occurrences, whereas the latter denotes the  termi-
     nal character "star".


LLLLEEEEXXXXIIIICCCCAAAALLLL DDDDEEEEFFFFIIIINNNNIIIITTTTIIIIOOOONNNNSSSS
  SSSSTTTTRRRRIIIINNNNGGGGSSSS
     A ssssttttrrrriiiinnnngggg is a sequence of characters, enclosed between  dou-
     ble quotes characters ''''""""'''', that denotes a label of the LTS:

      ssssttttrrrriiiinnnngggg ::::::::==== ''''""""'''' vvvvaaaalllliiiidddd____cccchhhhaaaarrrraaaacccctttteeeerrrr**** ''''""""''''

     where vvvvaaaalllliiiidddd____cccchhhhaaaarrrraaaacccctttteeeerrrr denotes any character  different  from
     double  quote  (''''""""'''')  and  from  end-of-line  (''''\\\\nnnn''''). Conse-
     quently, a ssssttttrrrriiiinnnngggg cannot encompass several  lines;  however,
     there  can  be  several ssssttttrrrriiiinnnnggggs on the same line (see, e.g.,
     llllaaaabbbbeeeellll and llllaaaabbbbeeeellll____ggggrrrroooouuuupppp below).


     The ssssttttrrrriiiinnnnggggs can be used in both the simple and full SEQ for-
     mat, with the same lexical conventions.


  RRRREEEEGGGGUUUULLLLAAAARRRR EEEEXXXXPPPPRRRREEEESSSSSSSSIIIIOOOONNNNSSSS
     A rrrreeeegggguuuullllaaaarrrr____eeeexxxxpppprrrreeeessssssssiiiioooonnnn is a notation for a set of labels.  The
     rrrreeeegggguuuullllaaaarrrr____eeeexxxxpppprrrreeeessssssssiiiioooonnnns  of  the  SEQ format are based upon UNIX
     basic   regular   expressions   (see   the   rrrreeeeggggeeeexxxxpppp(5)   and
     rrrreeeeggggeeeexxxxpppp(LOCAL) manual page for a detailed description of UNIX
     basic    regular     expressions).      Syntactically,     a
     rrrreeeegggguuuullllaaaarrrr____eeeexxxxpppprrrreeeessssssssiiiioooonnnn of the SEQ format is a UNIX basic regular
     expression enclosed between square brackets ''''[[[['''' and '''']]]]'''':

      rrrreeeegggguuuullllaaaarrrr____eeeexxxxpppprrrreeeessssssssiiiioooonnnn ::::::::==== ''''[[[['''' UUUUNNNNIIIIXXXX____bbbbaaaassssiiiicccc____rrrreeeegggguuuullllaaaarrrr____eeeexxxxpppprrrreeeessssssssiiiioooonnnn '''']]]]''''




(C) INRIA            Last change: 2019/01/14                    2






CADP MANUAL PAGES                                      SEQ(LOCAL)



     Unlike  standard  UNIX  basic  regular   expressions,   each
     rrrreeeegggguuuullllaaaarrrr____eeeexxxxpppprrrreeeessssssssiiiioooonnnn must satisfy two additional restrictions:


     -    First,  it  should  not  be   empty   (otherwise,   the
          rrrreeeegggguuuullllaaaarrrr____eeeexxxxpppprrrreeeessssssssiiiioooonnnn would be confused with another mean-
          ingful token ''''[[[[]]]]'''').


     -    Second, there should be exactly the same numbers of ''''[[[[''''
          and  '''']]]]''''  characters  in UUUUNNNNIIIIXXXX____bbbbaaaassssiiiicccc____rrrreeeegggguuuullllaaaarrrr____eeeexxxxpppprrrreeeessssssssiiiioooonnnn.
          This precludes  the  use  of  very  particular  regular
          expressions  such  as  ''''aaaa[[[[^^^^]]]]]]]]bbbb'''' or ''''aaaa[[[[]]]]bbbbcccc]]]]dddd''''. This res-
          triction should not be a problem for OPEN/CAESAR users.


     Like ssssttttrrrriiiinnnnggggs, rrrreeeegggguuuullllaaaarrrr____eeeexxxxpppprrrreeeessssssssiiiioooonnnns cannot  encompass  several
     lines;  however, there can be several rrrreeeegggguuuullllaaaarrrr____eeeexxxxpppprrrreeeessssssssiiiioooonnnns on
     the same line (see, e.g., llllaaaabbbbeeeellll and llllaaaabbbbeeeellll____ggggrrrroooouuuupppp below).


     Note: the choice operator ''''||||'''' is not supported in UNIX basic
     regular expressions. For instance,
           [[[[PPPPUUUUTTTT....****||||GGGGEEEETTTT....****]]]]
     will search for a label of  the  form  """"PPPPUUUUTTTT....****||||GGGGEEEETTTT....****""""  rather
     than  for  either  """"PPPPUUUUTTTT....****"""" or """"GGGGEEEETTTT....****"""". However, the intended
     meaning can be obtained using the choice operator  available
     in the syntax of llllaaaabbbbeeeelllls (see below):
           [[[[PPPPUUUUTTTT....****]]]] |||| [[[[GGGGEEEETTTT....****]]]]


     The rrrreeeegggguuuullllaaaarrrr eeeexxxxpppprrrreeeessssssssiiiioooonnnns can only be used  in  the  full  SEQ
     format.


  BBBBLLLLAAAANNNNKKKKSSSS
     A bbbbllllaaaannnnkkkk is a (possibly empty) sequence of  space  characters
     '''' '''' and/or tab ''''\\\\tttt'''' characters:

       bbbbllllaaaannnnkkkk ::::::::==== (((( '''' '''' |||| ''''\\\\tttt'''' ))))****

     BBBBllllaaaannnnkkkks can appear anywhere, at the beginning of a  line,  at
     the  end  of a line, or between two tokens. They are ignored
     (except, of course, in ssssttttrrrriiiinnnnggggs and rrrreeeegggguuuullllaaaarrrr eeeexxxxpppprrrreeeessssssssiiiioooonnnns).

     Note: end-of-line characters (''''\\\\nnnn'''') are not part of  bbbbllllaaaannnnkkkks.
     On  the  contrary,  they are meaningful in the SEQ format as
     they are used in the definition of  many  non-terminal  sym-
     bols.

     Both versions of the SEQ format share the same lexical  con-
     ventions for bbbbllllaaaannnnkkkks.



(C) INRIA            Last change: 2019/01/14                    3






CADP MANUAL PAGES                                      SEQ(LOCAL)



  CCCCOOOOMMMMMMMMEEEENNNNTTTTSSSS
     A ccccoooommmmmmmmeeeennnntttt is a sequence of characters  that  is  meaningless
     and ignored. There are two kinds of ccccoooommmmmmmmeeeennnntttts:


     -    Any sequence of characters that begins with the special
          character  ''''\\\\000000001111''''  (control-A)  and  that ends with the
          special character ''''\\\\000000002222'''' (control-B) is a  ccccoooommmmmmmmeeeennnntttt.   A
          ccccoooommmmmmmmeeeennnntttt  of  this  form  may encompass several lines of
          text.  The  characters  ''''\\\\000000001111''''  and  ''''\\\\000000002222''''  have  been
          selected because they are not visible by the user.


     -    Any line  whose  first  non-blank  character  does  not
          belong  to  the  following list of reserved characters:
          ''''[[[['''', ''''(((('''', ''''<<<<'''', ''''""""'''', ''''~~~~'''', ''''\\\\000000001111'''' is a ccccoooommmmmmmmeeeennnntttt. This ccccoooommmm----
          mmmmeeeennnntttt  extends  up  to  the end-of-line. This definition
          includes the case of lines  that  contain  nothing  but
          bbbbllllaaaannnnkkkkssss.


     Both versions of the SEQ format share the same lexical  con-
     ventions for ccccoooommmmmmmmeeeennnntttts.


SSSSYYYYNNNNTTTTAAAAXXXX OOOOFFFF TTTTHHHHEEEE SSSSIIIIMMMMPPPPLLLLEEEE FFFFOOOORRRRMMMMAAAATTTT
     The following BNF-like grammar defines  the  syntax  of  the
     simple   SEQ   format.   The   axiom   of   the  grammar  is
     sssseeeeqqqquuuueeeennnncccceeee____lllliiiisssstttt.

     sssseeeeqqqquuuueeeennnncccceeee____lllliiiisssstttt     ::::::::==== ''''''''
                        ||||  sssseeeeqqqquuuueeeennnncccceeee
                        ||||  sssseeeeqqqquuuueeeennnncccceeee ''''[[[[]]]]'''' ''''\\\\nnnn'''' sssseeeeqqqquuuueeeennnncccceeee____lllliiiisssstttt

     sssseeeeqqqquuuueeeennnncccceeee          ::::::::==== ssssttttrrrriiiinnnngggg ''''\\\\nnnn''''
                        ||||  ssssttttrrrriiiinnnngggg ''''\\\\nnnn'''' sssseeeeqqqquuuueeeennnncccceeee
                        ||||  ''''<<<<ddddeeeeaaaaddddlllloooocccckkkk>>>>'''' ''''\\\\nnnn''''

     Note: this grammar defines a regular language.


SSSSYYYYNNNNTTTTAAAAXXXX OOOOFFFF TTTTHHHHEEEE FFFFUUUULLLLLLLL FFFFOOOORRRRMMMMAAAATTTT
     The following BNF-like grammar defines  the  syntax  of  the
     full SEQ format. The axiom of the grammar is sssseeeeqqqquuuueeeennnncccceeee____lllliiiisssstttt.

     sssseeeeqqqquuuueeeennnncccceeee____lllliiiisssstttt     ::::::::==== ''''''''
                        ||||  sssseeeeqqqquuuueeeennnncccceeee
                        ||||  sssseeeeqqqquuuueeeennnncccceeee ''''[[[[]]]]'''' ''''\\\\nnnn'''' sssseeeeqqqquuuueeeennnncccceeee____lllliiiisssstttt

     sssseeeeqqqquuuueeeennnncccceeee          ::::::::==== llllaaaabbbbeeeellll____ggggrrrroooouuuupppp ''''\\\\nnnn''''
                        ||||  llllaaaabbbbeeeellll____ggggrrrroooouuuupppp ''''\\\\nnnn'''' sssseeeeqqqquuuueeeennnncccceeee
                        ||||  ''''<<<<ddddeeeeaaaaddddlllloooocccckkkk>>>>'''' ''''\\\\nnnn''''



(C) INRIA            Last change: 2019/01/14                    4






CADP MANUAL PAGES                                      SEQ(LOCAL)



     llllaaaabbbbeeeellll____ggggrrrroooouuuupppp       ::::::::==== llllaaaabbbbeeeellll
                        ||||  llllaaaabbbbeeeellll ''''****''''
                        ||||  llllaaaabbbbeeeellll ''''++++''''
                        ||||  ''''<<<<wwwwhhhhiiiilllleeee>>>>'''' llllaaaabbbbeeeellll
                        ||||  ''''<<<<uuuunnnnttttiiiillll>>>>'''' llllaaaabbbbeeeellll
                        ||||  ''''<<<<wwwwhhhhiiiilllleeee>>>>'''' llllaaaabbbbeeeellll ''''<<<<uuuunnnnttttiiiillll>>>>'''' llllaaaabbbbeeeellll

     llllaaaabbbbeeeellll             ::::::::==== ssssiiiimmmmpppplllleeee____llllaaaabbbbeeeellll
                        ||||  llllaaaabbbbeeeellll ''''&&&&'''' ssssiiiimmmmpppplllleeee____llllaaaabbbbeeeellll
                        ||||  llllaaaabbbbeeeellll ''''||||'''' ssssiiiimmmmpppplllleeee____llllaaaabbbbeeeellll
                        ||||  llllaaaabbbbeeeellll ''''^^^^'''' ssssiiiimmmmpppplllleeee____llllaaaabbbbeeeellll

     ssssiiiimmmmpppplllleeee____llllaaaabbbbeeeellll      ::::::::==== ''''<<<<aaaannnnyyyy>>>>''''
                        ||||  ssssttttrrrriiiinnnngggg
                        ||||  rrrreeeegggguuuullllaaaarrrr____eeeexxxxpppprrrreeeessssssssiiiioooonnnn
                        ||||  ''''~~~~'''' ssssiiiimmmmpppplllleeee____llllaaaabbbbeeeellll
                        ||||  ''''(((('''' llllaaaabbbbeeeellll ''''))))''''

     Note: each llllaaaabbbbeeeellll____ggggrrrroooouuuupppp  (and  consequently  each  llllaaaabbbbeeeellll  and
     ssssiiiimmmmpppplllleeee____llllaaaabbbbeeeellll) appears on a single line of text.

     Note: from the grammar, the postfix operators ''''++++''''  and  ''''****'''',
     and  the  ''''<<<<wwwwhhhhiiiilllleeee>>>>''''  and ''''<<<<uuuunnnnttttiiiillll>>>>'''' operators have the lowest
     priority. Then, the binary operators ''''&&&&'''', ''''||||'''', and ''''^^^^''''  have
     the same, intermediate priority.  Finally, the prefix opera-
     tor ''''~~~~'''' has the highest priority.


     Note: the simple SEQ format is the subset of  the  full  SEQ
     format in which each llllaaaabbbbeeeellll____ggggrrrroooouuuupppp is constrained to be simply
     a ssssttttrrrriiiinnnngggg.


SSSSEEEEMMMMAAAANNNNTTTTIIIICCCCSSSS OOOOFFFF TTTTHHHHEEEE FFFFUUUULLLLLLLL FFFFOOOORRRRMMMMAAAATTTT
     The semantics of the full format is defined by induction  on
     its  syntax;  the  semantics  of  the  simple  format can be
     derived as a special case.


     Let (S0 T1 ... Tn Sn) be an execution sequence  that  starts
     from some state S0 (not necessarily the initial state of the
     LTS) and that reaches some state Sn by applying n successive
     transitions  T1, ..., Tn. The number n of transitions can be
     null.


     A SEQ file contains a finite list  of  execution  sssseeeeqqqquuuueeeennnncccceeees,
     separated  by  the  ''''[[[[]]]]'''' keyword. This list can be empty, as
     specified by the ''''''''  token  in  the  BNF-like  grammar.  The
     semantics  of  the  full  format is only defined for a given
     sssseeeeqqqquuuueeeennnncccceeee:




(C) INRIA            Last change: 2019/01/14                    5






CADP MANUAL PAGES                                      SEQ(LOCAL)



     -    If this list is empty, then the SEQ file  only  matches
          the empty execution sequence (S0), where S0 is equal to
          the initial state of the LTS.


     -    If this list contains more than  one  element,  then  a
          particular sssseeeeqqqquuuueeeennnncccceeee must be selected; for instance, the
          ----sssseeeeqqqqnnnnoooo of the eeeexxxxhhhhiiiibbbbiiiittttoooorrrr(LOCAL) tool enables the user to
          indicate  which  sssseeeeqqqquuuueeeennnncccceeee  is to be considered. In such
          case, the semantics of the full format is  the  set  of
          all  execution sequences (S0 T1 ... Tn Sn) such that S0
          is equal to the initial state of the LTS and such  that
          the sequence-matching relation "(S0 T1 ... Tn Sn) |====
          sssseeeeqqqquuuueeeennnncccceeee" defined hereafter is satisfied.


  DDDDEEEEFFFFIIIINNNNIIIITTTTIIIIOOOONNNN OOOOFFFF SSSSIIIIMMMMPPPPLLLLEEEE LLLLAAAABBBBEEEELLLL MMMMAAAATTTTCCCCHHHHIIIINNNNGGGG
     For any transition T of the LTS, let L(T) denote the charac-
     ter string generated from the label of transition T.


     Let "T |= ssssiiiimmmmpppplllleeee____llllaaaabbbbeeeellll" be a relation  expressing  that  the
     transition   T  "matches"  ssssiiiimmmmpppplllleeee____llllaaaabbbbeeeellll.  This  relation  is
     defined by induction on the syntax of ssssiiiimmmmpppplllleeee____llllaaaabbbbeeeellll and it is
     mutually  recursive  with the relation "T |== llllaaaabbbbeeeellll" defined
     in the next subsection.


     T |= ''''<<<<aaaannnnyyyy>>>>''''
          is always true


     T |= ssssttttrrrriiiinnnngggg
          iff L(T) is equal to ssssttttrrrriiiinnnngggg


     T |= rrrreeeegggguuuullllaaaarrrr____eeeexxxxpppprrrreeeessssssssiiiioooonnnn
          iff L(T) matches rrrreeeegggguuuullllaaaarrrr____eeeexxxxpppprrrreeeessssssssiiiioooonnnn


     T |= ''''~~~~'''' ssssiiiimmmmpppplllleeee____llllaaaabbbbeeeellll
          iff not T |= ssssiiiimmmmpppplllleeee____llllaaaabbbbeeeellll


     T |= ''''(((('''' llllaaaabbbbeeeellll ''''))))''''
          iff T |== llllaaaabbbbeeeellll


  DDDDEEEEFFFFIIIINNNNIIIITTTTIIIIOOOONNNN OOOOFFFF LLLLAAAABBBBEEEELLLL MMMMAAAATTTTCCCCHHHHIIIINNNNGGGG
     Let "T |== llllaaaabbbbeeeellll" be a relation expressing that the  transi-
     tion  T  "matches" llllaaaabbbbeeeellll. This relation is defined by induc-
     tion on the syntax of llllaaaabbbbeeeellll.



(C) INRIA            Last change: 2019/01/14                    6






CADP MANUAL PAGES                                      SEQ(LOCAL)



     T |== ssssiiiimmmmpppplllleeee____llllaaaabbbbeeeellll
          iff T |= ssssiiiimmmmpppplllleeee____llllaaaabbbbeeeellll


     T |== llllaaaabbbbeeeellll ''''&&&&'''' ssssiiiimmmmpppplllleeee____llllaaaabbbbeeeellll
          iff T |== llllaaaabbbbeeeellll and T |= ssssiiiimmmmpppplllleeee____llllaaaabbbbeeeellll


     T |== llllaaaabbbbeeeellll ''''||||'''' ssssiiiimmmmpppplllleeee____llllaaaabbbbeeeellll
          iff T |== llllaaaabbbbeeeellll or T |= ssssiiiimmmmpppplllleeee____llllaaaabbbbeeeellll


     T |== llllaaaabbbbeeeellll ''''^^^^'''' ssssiiiimmmmpppplllleeee____llllaaaabbbbeeeellll
          iff T |== llllaaaabbbbeeeellll exclusive-or T |= ssssiiiimmmmpppplllleeee____llllaaaabbbbeeeellll

     Note: rrrreeeegggguuuullllaaaarrrr____eeeexxxxpppprrrreeeessssssssiiiioooonnnns apply  to  _e_n_t_i_r_e  llllaaaabbbbeeeellll  strings,
     from  the  first  character to the last one, and not to sub-
     strings. For instance, the llllaaaabbbbeeeellll ''''PPPPUUUUTTTT  !!!!0000''''  will  match  the
     regular  expression  ''''PPPPUUUUTTTT....****'''',  but not ''''PPPPUUUUTTTT''''.  Consequently,
     the special characters ''''^^^^'''' and ''''$$$$''''  of  UNIX  basic  regular
     expressions are useless in the SEQ format, and should not be
     used.


  DDDDEEEEFFFFIIIINNNNIIIITTTTIIIIOOOONNNN OOOOFFFF LLLLAAAABBBBEEEELLLL GGGGRRRROOOOUUUUPPPP MMMMAAAATTTTCCCCHHHHIIIINNNNGGGG
     Let "(S0 T1 ... Tn  Sn)  |===  llllaaaabbbbeeeellll____ggggrrrroooouuuupppp"  be  a  relation
     expressing  that  the  execution  sequence (S0 T1 ... Tn Sn)
     matches llllaaaabbbbeeeellll____ggggrrrroooouuuupppp. This relation is defined  by  induction
     on the syntax of llllaaaabbbbeeeellll____ggggrrrroooouuuupppp.


     (S0 T1 ... Tn Sn) |=== llllaaaabbbbeeeellll
          iff n = 1 and T1 |== llllaaaabbbbeeeellll


     (S0 T1 ... Tn Sn) |=== llllaaaabbbbeeeellll ''''****''''
          iff for all i in {1 ... n} Ti |== llllaaaabbbbeeeellll


     The remaining constructs ''''++++'''', ''''<<<<wwwwhhhhiiiilllleeee>>>>'''', and ''''<<<<uuuunnnnttttiiiillll>>>>''''  used
     in   the  syntactic  definition  of  llllaaaabbbbeeeellll____ggggrrrroooouuuupppp  are merely
     shorthand notations introduced for  user  convenience.  They
     are defined as follows:


     -    The construct:
                llllaaaabbbbeeeellll ''''++++''''
          is equivalent to:
                llllaaaabbbbeeeellll ''''\\\\nnnn''''
                llllaaaabbbbeeeellll ''''****''''
          It denotes a sequence of one or more transitions match-
          ing llllaaaabbbbeeeellll.



(C) INRIA            Last change: 2019/01/14                    7






CADP MANUAL PAGES                                      SEQ(LOCAL)



     -    The construct:
                ''''<<<<wwwwhhhhiiiilllleeee>>>>'''' llllaaaabbbbeeeellll
          is equivalent to:
                llllaaaabbbbeeeellll '*'
          It denotes a  sequence  of  zero  or  more  transitions
          matching llllaaaabbbbeeeellll.


     -    The construct:
                ''''<<<<uuuunnnnttttiiiillll>>>>'''' llllaaaabbbbeeeellll
          is equivalent to:
                ''''((((~~~~'''' llllaaaabbbbeeeellll ''''))))****'''' ''''\\\\nnnn''''
                llllaaaabbbbeeeellll
          It denotes a sequence of zero or more transitions  that
          do  not  match llllaaaabbbbeeeellll, followed by a transition matching
          llllaaaabbbbeeeellll.


     -    The construct:
                ''''<<<<wwwwhhhhiiiilllleeee>>>>'''' llllaaaabbbbeeeellll1111 ''''<<<<uuuunnnnttttiiiillll>>>>'''' llllaaaabbbbeeeellll2222
          is equivalent to:
                ''''(((('''' llllaaaabbbbeeeellll1111 ''''&&&& ~~~~'''' llllaaaabbbbeeeellll2222 ''''))))****'''' ''''\\\\nnnn''''
                llllaaaabbbbeeeellll2222
          It denotes a sequence of zero or more transitions  that
          match  llllaaaabbbbeeeellll1111  and  do  not match llllaaaabbbbeeeellll2222, followed by a
          transition matching llllaaaabbbbeeeellll2222.


  DDDDEEEEFFFFIIIINNNNIIIITTTTIIIIOOOONNNN OOOOFFFF SSSSEEEEQQQQUUUUEEEENNNNCCCCEEEE MMMMAAAATTTTCCCCHHHHIIIINNNNGGGG
     Let "(S0 T1  ...  Tn  Sn)  |====  sssseeeeqqqquuuueeeennnncccceeee"  be  a  relation
     expressing  that  the  execution  sequence (S0 T1 ... Tn Sn)
     matches sssseeeeqqqquuuueeeennnncccceeee.  This relation is defined by induction  on
     the syntax of sssseeeeqqqquuuueeeennnncccceeee.


     (S0 T1 ... Tn Sn) |==== llllaaaabbbbeeeellll____ggggrrrroooouuuupppp ''''\\\\nnnn''''
          iff (S0 T1 ... Tn Sn) |=== llllaaaabbbbeeeellll____ggggrrrroooouuuupppp


     (S0 T1 ... Tn Sn) |==== llllaaaabbbbeeeellll____ggggrrrroooouuuupppp ''''\\\\nnnn'''' sssseeeeqqqquuuueeeennnncccceeee
          iff there exists some state Sm in the sequence  (S0  T1
          ... Tn Sn) such that:
          (S0 T1 ... Tm Sm) |=== llllaaaabbbbeeeellll____ggggrrrroooouuuupppp and
          (Sm Tm+1 ... Tn Sn) |==== sssseeeeqqqquuuueeeennnncccceeee


     (S0 T1 ... Tn Sn) |==== ''''<<<<ddddeeeeaaaaddddlllloooocccckkkk>>>>'''' ''''\\\\nnnn''''
          iff n = 0 (the sequence is reduced to a  single  state)
          and
          S0 is a sink state (no transition goes out from S0)





(C) INRIA            Last change: 2019/01/14                    8






CADP MANUAL PAGES                                      SEQ(LOCAL)



EEEEXXXXHHHHIIIIBBBBIIIITTTTOOOORRRR''''SSSS SSSSEEEEMMMMAAAANNNNTTTTIIIICCCC CCCCOOOONNNNVVVVEEEENNNNTTTTIIIIOOOONNNNSSSS
     The current version of eeeexxxxhhhhiiiibbbbiiiittttoooorrrr(LOCAL) interprets the  full
     SEQ format in particular ways, described hereafter.


  TTTTRRRRAAAANNNNSSSSIIIITTTTIIIIOOOONNNN LLLLAAAABBBBEEEELLLLSSSS
     Since eeeexxxxhhhhiiiibbbbiiiittttoooorrrr(LOCAL) operates on the fly and is  based  on
     the  OPEN/CAESAR's graph module, it implements the aforemen-
     tioned T(L) notation by invoking  the  CCCCAAAAEEEESSSSAAAARRRR____SSSSTTTTRRRRIIIINNNNGGGG____LLLLAAAABBBBEEEELLLL(((())))
     function (see the ccccaaaaeeeessssaaaarrrr____ggggrrrraaaapppphhhh(LOCAL) manual page).


  CCCCAAAASSSSEEEE IIIINNNNSSSSEEEENNNNSSSSIIIITTTTIIIIVVVVIIIITTTTYYYY
     In order to be  compatible  with  the  conventions  used  by
     ccccaaaaeeeessssaaaarrrr(LOCAL) when printing labels as character strings, all
     lower-case    letters    contained    in     ssssttttrrrriiiinnnnggggs     and
     rrrreeeegggguuuullllaaaarrrr____eeeexxxxpppprrrreeeessssssssiiiioooonnnns  are  turned to upper case. However, the
     ssssttttrrrriiiinnnnggggs and rrrreeeegggguuuullllaaaarrrr____eeeexxxxpppprrrreeeessssssssiiiioooonnnns  (case-insensitively)  equal
     to  """"iiii"""" or """"eeeexxxxiiiitttt"""" are recognized as special values (denoting
     the internal gate and the termination gate)  and  turned  to
     lower case.


     This is the default option, but it can  be  overriden  using
     the  ----ccccaaaasssseeee  option  of  eeeexxxxhhhhiiiibbbbiiiittttoooorrrr(LOCAL) if case sensitivity
     needs to be preserved.


  DDDDEEEETTTTEEEERRRRMMMMIIIINNNNIIIIZZZZAAAATTTTIIIIOOOONNNN SSSSTTTTRRRRAAAATTTTEEEEGGGGYYYY
     Given  a  sssseeeeqqqquuuueeeennnncccceeee,  eeeexxxxhhhhiiiibbbbiiiittttoooorrrr  will  search  for  execution
     sequences  (S0  T1  ...  Tn Sn) such that S0 is equal to the
     initial state of the LTS and such that (S0  T1  ...  Tn  Sn)
     |==== sssseeeeqqqquuuueeeennnncccceeee.


     In the above second semantic rule defining sequence matching
     (namely,   "(S0   T1  ...  Tn  Sn)  |====  llllaaaabbbbeeeellll____ggggrrrroooouuuupppp  ''''\\\\nnnn''''
     sssseeeeqqqquuuueeeennnncccceeee"), if there exist several states Sm, the  one  with
     the  greatest  index  m  is selected. By doing so, eeeexxxxhhhhiiiibbbbiiiittttoooorrrr
     reduces potentially non-deterministic sequences into  deter-
     ministic  ones.   Intuitively, every time that eeeexxxxhhhhiiiibbbbiiiittttoooorrrr has
     the choice between remaining in a '*'-group or  leaving  it,
     it  will remain in the '*'-group. For instance, if the label
     """"BBBB"""" has to be matched against the sequence:
           ((((~~~~ """"AAAA"""")))) ****
           """"BBBB""""
     there is a conflict, since """"BBBB"""" matches  both  lines  of  the
     sequence.  In such case, the sequence will not be recognized
     successfully, since the label """"BBBB"""" will be used to match  the
     first  line  of  the  sequence  instead  of the second line.
     Therefore, the determinization strategy  gives  priority  to
     the longest match.



(C) INRIA            Last change: 2019/01/14                    9






CADP MANUAL PAGES                                      SEQ(LOCAL)



     The ----ccccoooonnnnfffflllliiiicccctttt option of eeeexxxxhhhhiiiibbbbiiiittttoooorrrr (see the  eeeexxxxhhhhiiiibbbbiiiittttoooorrrr(LOCAL)
     manual page for a detailed decription of this option) can be
     used to display the list of all conflicts  which  have  been
     solved using this determinization strategy.

     The solution to this problem consists in avoiding  the  con-
     flict by making the sequence more precise:
           ((((~~~~ """"AAAA"""" &&&& ~~~~ """"BBBB"""")))) ****
           """"BBBB""""

     Similarly, the sequence:
           <<<<aaaannnnyyyy>>>>****
           """"AAAA""""
     will never be recognized, because of  the  conflict  between
     <<<<aaaannnnyyyy>>>> and """"AAAA"""".  It should be written instead:
           ((((~~~~ """"AAAA"""")))) ****
           """"AAAA""""

     Note: translating the llllaaaabbbbeeeellll____ggggrrrroooouuuupppp construct:
           llllaaaabbbbeeeellll ''''++++''''
     to:
           llllaaaabbbbeeeellll ''''****'''' ''''\\\\nnnn''''
           llllaaaabbbbeeeellll
     would not be correct because,  due  to  the  determinization
     strategy,  this  sequence  is  never  recognized (one always
     remains in the '*'-group).


  SSSSEEEEQQQQUUUUEEEENNNNCCCCEEEE RRRREEEEDDDDUUUUCCCCTTTTIIIIOOOONNNN
     eeeexxxxhhhhiiiibbbbiiiittttoooorrrr removes all trailing '*'-groups at the end of  the
     sequence  to  be searched, because these groups are meaning-
     less. For instance, the following sequence:
           """"AAAA""""
           """"BBBB""""****
           """"CCCC""""****
     is reduced to:
           """"AAAA""""

     If the sequence becomes empty due to this reduction, eeeexxxxhhhhiiiibbbbiiii----
     ttttoooorrrr emits a warning and stops.


EEEEXXXXAAAAMMMMPPPPLLLLEEEESSSS OOOOFFFF PPPPAAAATTTTTTTTEEEERRRRNNNNSSSS
     The following sequence:
          """"iiii"""" ****
          """"PPPPUUUUTTTT""""
          """"iiii"""" ****
          """"GGGGEEEETTTT""""
     searches for an action """"PPPPUUUUTTTT"""", followed by an  action  """"GGGGEEEETTTT"""",
     with any number of invisible actions """"iiii"""" before and between.





(C) INRIA            Last change: 2019/01/14                   10






CADP MANUAL PAGES                                      SEQ(LOCAL)



     The following sequence:
          <<<<uuuunnnnttttiiiillll>>>> [[[[PPPPUUUUTTTT !!!!TTTTRRRRUUUUEEEE !!!!....****]]]]
          <<<<uuuunnnnttttiiiillll>>>> [[[[GGGGEEEETTTT !!!!FFFFAAAALLLLSSSSEEEE !!!!....****]]]]
     searches for an action of the form """"PPPPUUUUTTTT !!!!TTTTRRRRUUUUEEEE !!!!....****"""", followed
     by  an  action of the form """"GGGGEEEETTTT !!!!FFFFAAAALLLLSSSSEEEE !!!!....****"""", with any number
     of visible or invisible actions before and between.

     The following sequence:
             <<<<uuuunnnnttttiiiillll>>>> (((([[[[SSSSEEEENNNNDDDD !!!!....****]]]] &&&& ~~~~ """"SSSSEEEENNNNDDDD !!!!NNNNUUUULLLLLLLL""""))))
     searches for an action of the form """"SSSSEEEENNNNDDDD !!!!....****"""" such that  the
     offer associated with gate """"SSSSEEEENNNNDDDD"""" is different from """"NNNNUUUULLLLLLLL"""".

     The following sequence:
          <<<<uuuunnnnttttiiiillll>>>> """"OOOOPPPPEEEENNNN !!!!1111""""
          <<<<wwwwhhhhiiiilllleeee>>>> ~~~~ """"CCCCLLLLOOOOSSSSEEEE !!!!1111"""" <<<<uuuunnnnttttiiiillll>>>> """"OOOOPPPPEEEENNNN !!!!2222""""
     searches for an action """"OOOOPPPPEEEENNNN  !!!!1111"""",  followed  by  an  action
     """"OOOOPPPPEEEENNNN !!!!2222"""" without any """"CCCCLLLLOOOOSSSSEEEE !!!!1111"""" action between them.

     The following sequence:
           <<<<aaaannnnyyyy>>>>****
           <<<<ddddeeeeaaaaddddlllloooocccckkkk>>>>
     searches for deadlocks. Thus, eeeexxxxhhhhiiiibbbbiiiittttoooorrrr can be  used  as  an
     alternative  to  tttteeeerrrrmmmmiiiinnnnaaaattttoooorrrr(LOCAL),  although  it implements
     totally different algorithms.


HHHHOOOOWWWW TTTTOOOO CCCCRRRREEEEAAAATTTTEEEE AAAA SSSSEEEEQQQQ FFFFIIIILLLLEEEE
     It is easy to create a SEQ file manually, using a text  edi-
     tor.  It  is  also  possible to produce a SEQ file automati-
     cally, using the bbbbccccgggg____iiiioooo(LOCAL) tool, which converts  to  the
     simple SEQ format a graph (encoded in various other formats)
     consisting of a set of sequences all starting from the  ini-
     tial  state.  Finally, many CADP tools for simulation, model
     checking, equivalence checking, etc. generate  their  output
     in SEQ format when such output denotes an execution sequence
     or a set of execution sequences (as opposed to more  general
     labelled transition systems).


HHHHOOOOWWWW TTTTOOOO RRRREEEEAAAADDDD AAAA SSSSEEEEQQQQ FFFFIIIILLLLEEEE
     The tool sssseeeeqqqq....ooooppppeeeennnn(LOCAL) reads a SEQ file in the simple  SEQ
     format.


     The tool eeeexxxxhhhhiiiibbbbiiiittttoooorrrr(LOCAL) reads a SEQ file in the  full  SEQ
     format.


     SEQ files can be converted to many other graph formats using
     the bbbbccccgggg____iiiioooo(LOCAL) tool.





(C) INRIA            Last change: 2019/01/14                   11






CADP MANUAL PAGES                                      SEQ(LOCAL)



AAAAUUUUTTTTHHHHOOOORRRRSSSS
     The SEQ  format  was  developed  by  Hubert  Garavel  (INRIA
     Rhone-Alpes).


SSSSEEEEEEEE AAAALLLLSSSSOOOO
     bbbbccccgggg____iiiioooo(LOCAL), eeeexxxxhhhhiiiibbbbiiiittttoooorrrr(LOCAL), sssseeeeqqqq....ooooppppeeeennnn(LOCAL)


     Additional information is available from the CADP  Web  page
     located at http://cadp.inria.fr

     Directives   for   installation   are   given    in    files
     $$$$CCCCAAAADDDDPPPP////IIIINNNNSSSSTTTTAAAALLLLLLLLAAAATTTTIIIIOOOONNNN____****....


     Recent  changes  and  improvements  to  this  software   are
     reported and commented in file $$$$CCCCAAAADDDDPPPP////HHHHIIIISSSSTTTTOOOORRRRYYYY....


BBBBUUUUGGGGSSSS
     Please report any bug to cadp@inria.fr

































(C) INRIA            Last change: 2019/01/14                   12



