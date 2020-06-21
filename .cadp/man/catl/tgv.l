


TGV MANUAL PAGES                                       TGV(LOCAL)



NNNNAAAAMMMMEEEE
     tgv - Test Generation from transitions systems using Verifi-
     cation techniques


SSSSYYYYNNNNOOOOPPPPSSSSIIIISSSS
     bbbbccccgggg____ooooppppeeeennnn  [_b_c_g__o_p_t]  _s_p_e_c[....bbbbccccgggg]   [_c_c__o_p_t]   ttttggggvvvv   [_t_g_v__o_p_t]
     _t_p[....bbbbccccgggg|....aaaauuuutttt]

     or:

     eeeexxxxpppp....ooooppppeeeennnn  [_e_x_p__o_p_t]  _s_p_e_c[....eeeexxxxpppp]   [_c_c__o_p_t]   ttttggggvvvv   [_t_g_v__o_p_t]
     _t_p[....bbbbccccgggg|....aaaauuuutttt]

     or:

     ffffsssspppp....ooooppppeeeennnn  [_f_s_p__o_p_t]  _s_p_e_c[....llllttttssss]   [_c_c__o_p_t]   ttttggggvvvv   [_t_g_v__o_p_t]
     _t_p[....bbbbccccgggg|....aaaauuuutttt]

     or:

     llllnnnntttt....ooooppppeeeennnn  [_l_n_t__o_p_t]  _s_p_e_c[....llllnnnntttt]   [_c_c__o_p_t]   ttttggggvvvv   [_t_g_v__o_p_t]
     _t_p[....bbbbccccgggg|....aaaauuuutttt]

     or:

     lllloooottttoooossss....ooooppppeeeennnn [_l_o_t_o_s__o_p_t] _s_p_e_c[....lllloooottttoooossss] [_c_c__o_p_t]  ttttggggvvvv  [_t_g_v__o_p_t]
     _t_p[....bbbbccccgggg|....aaaauuuutttt]

     or:

     sssseeeeqqqq....ooooppppeeeennnn  [_s_e_q__o_p_t]  _s_p_e_c[....sssseeeeqqqq]   [_c_c__o_p_t]   ttttggggvvvv   [_t_g_v__o_p_t]
     _t_p[....bbbbccccgggg|....aaaauuuutttt]


DDDDEEEESSSSCCCCRRRRIIIIPPPPTTTTIIIIOOOONNNN
     TGV allows the generation of an abstract test  case  from  a
     specification  and  a  test  purpose. The generation is done
     "on-the-fly" on the synchronous product of the specification
     with  the  test  purpose. It is based on Tarjan's algorithm.
     During the depth-first search (DFS), TGV  performs  abstrac-
     tion and determinisation of this product. The DFS stops when
     an accepting state of test purpose is  reached.  During  the
     backtracking,  TGV  synthesizes  the transitions of the test
     case.

     The specification and the test  purpose  are  Inputs/Outputs
     Labeled  Transition  Systems  (IOLTS).  The specification is
     either the BCG graph _s_p_e_c....bbbbccccgggg,  the  composition  expression
     _s_p_e_c....eeeexxxxpppp,   the   FSP  program  _s_p_e_c....llllttttssss,  the  LNT  program
     _s_p_e_c....llllnnnntttt, the LOTOS program _s_p_e_c....lllloooottttoooossss, or the sequence file
     _s_p_e_c....sssseeeeqqqq.



(C) INRIA            Last change: 2020/02/12                    1






TGV MANUAL PAGES                                       TGV(LOCAL)



     The test purpose is described either in a BCG file _t_p....bbbbccccgggg or
     in an AAAAUUUUTTTT file _t_p....aaaauuuutttt.

     TGV uses the bbbbccccgggg____iiiioooo(LOCAL) tool to transparently  convert  a
     test  purpose  in  AUT  format  into  the BCG format, and to
     transform the generated test case  or  complete  test  graph
     into the AUT format.


BBBBCCCCGGGG FFFFOOOORRRRMMMMAAAATTTT
     See the bbbbccccgggg(LOCAL) manual page.


AAAAUUUUTTTT FFFFOOOORRRRMMMMAAAATTTT
     See the aaaauuuutttt(LOCAL) manual page.


TTTTEEEESSSSTTTT PPPPUUUURRRRPPPPOOOOSSSSEEEESSSS
     A test purpose is an abstract description of a subset of the
     specification,  allowing  to  choose  behaviors to test, and
     consequently allowing to reduce the  specification  explora-
     tion.  Final  states  of  the  test purpose graph are either
     accepting states (the purpose is reached) or refusing states
     (parts of the specification are rejected).

     Accepting (respectively refusing) states must  be  given  as
     loop-transitions  with the predefined label AAAACCCCCCCCEEEEPPPPTTTT or aaaacccccccceeeepppptttt
     (respectively RRRREEEEFFFFUUUUSSSSEEEE or rrrreeeeffffuuuusssseeee). The purpose  must  own  one
     accepting state at least.

     All action names are regular expressions (according  to  the
     definition   given   in   the   manual  page  of  the  POSIX
     rrrreeeeggggeeeexxxxpppp(LOCAL)).  The test purpose is written  in  accordance
     with the specification label names (before renaming and hid-
     ding). It can also have transitions labelled with  invisible
     actions of the specification.

     If the predefined  label  "****"  (which  means  ooootttthhhheeeerrrrwwwwiiiisssseeee)  is
     present  on  a  transition  leaving some state _s, this label
     represents all other actions than those already  present  on
     the outgoing transitions of state _s.

     So, for an AUT test purpose, a transition has the  following
     grammar:











(C) INRIA            Last change: 2020/02/12                    2






TGV MANUAL PAGES                                       TGV(LOCAL)



          <<<<ttttrrrraaaannnnssssiiiittttiiiioooonnnn>>>> ::::::::====
              ''''(((('''' <<<<ffffrrrroooommmm____ssssttttaaaatttteeee>>>> '''',,,,'''' <<<<aaaaccccttttiiiioooonnnn>>>> '''',,,,'''' <<<<ttttoooo____ssssttttaaaatttteeee>>>> ''''))))''''  ||||
              ''''(((('''' <<<<ssssttttaaaatttteeee>>>> '''',,,,'''' ''''AAAACCCCCCCCEEEEPPPPTTTT''''||||''''aaaacccccccceeeepppptttt'''' '''',,,,'''' <<<<ssssttttaaaatttteeee>>>> ''''))))'''' ||||
              ''''(((('''' <<<<ssssttttaaaatttteeee>>>> '''',,,,'''' ''''RRRREEEEFFFFUUUUSSSSEEEE''''||||''''rrrreeeeffffuuuusssseeee'''' '''',,,,'''' <<<<ssssttttaaaatttteeee>>>> ''''))))'''' ||||
              ''''(((('''' <<<<ffffrrrroooommmm____ssssttttaaaatttteeee>>>> '''',,,,'''' ''''****'''' '''',,,,'''' <<<<ttttoooo____ssssttttaaaatttteeee>>>> ''''))))''''

          <<<<aaaaccccttttiiiioooonnnn>>>> ::::::::==== <<<<UUUUNNNNIIIIXXXX____rrrreeeeggggeeeexxxxpppp>>>>
                    |||| ''''""""'''' <<<<UUUUNNNNIIIIXXXX____rrrreeeeggggeeeexxxxpppp>>>> ''''""""''''


     Note: if the extension of the test purpose filename is omit-
     ted  (or is different from ....bbbbccccgggg and ....aaaauuuutttt), the file is first
     searched with ....bbbbccccgggg extension and then with ....aaaauuuutttt extension.


TTTTEEEESSSSTTTT CCCCAAAASSSSEEEESSSS
     If  the  test  purpose  is  valid,  i.e.  allows  to  select
     sequences  of  the  specification  leading  to  an accepting
     state, TGV produces an LTS that is the  description  of  the
     test graph in the BCG format (....bbbbccccgggg) or AUT (....aaaauuuutttt) format.

     Actions labels of this LTS are based on those of the specif-
     ication,  plus  some  predefined labels as LLLLOOOOCCCCKKKK,,,, OOOOUUUUTTTTPPPPUUUUTTTTLLLLOOOOCCCCKKKK,,,,
     DDDDEEEEAAAADDDDLLLLOOOOCCCCKKKK,,,, LLLLIIIIVVVVEEEELLLLOOOOCCCCKKKK used in lock transitions. A tag (IIIINNNNPPPPUUUUTTTT or
     OOOOUUUUTTTTPPPPUUUUTTTT),  seen from the tester's viewpoint, is added to each
     label. In some transitions, a  verdict  (PPPPAAAASSSSSSSS)  or  PPPPAAAASSSSSSSS  or
     (IIIINNNNCCCCOOOONNNNCCCCLLLLUUUUSSSSIIIIVVVVEEEE) or IIIINNNNCCCCOOOONNNNCCCCLLLLUUUUSSSSIIIIVVVVEEEE is also added to the label.

     A PPPPAAAASSSSSSSS verdict on a  transition  means  that  in  the  state
     reached  by  this  transition,  the  tester  has detected no
     implementation error in the IUT.

     An  IIIINNNNCCCCOOOONNNNCCCCLLLLUUUUSSSSIIIIVVVVEEEE  verdict  is  present   on   a   transition
     corresponding to a possible output of the specification that
     leads to a sequence not satisfying the test purpose.

     There is no FFFFAAAAIIIILLLL verdict, as fail transitions  are  implicit
     (from  each  state,  unrecognized  actions  lead  to  a FFFFAAAAIIIILLLL
     state).

     A verdict not enclosed in parentheses means that the  tester
     has  reached  a  stable  state  from  which no output of the
     implementation under test (IUT) is expected.


OOOOPPPPTTTTIIIIOOOONNNNSSSS
     The options _b_c_g__o_p_t, if any, are passed to bbbbccccgggg____lllliiiibbbb(LOCAL).

     The options _e_x_p__o_p_t, if any, are passed to eeeexxxxpppp....ooooppppeeeennnn(LOCAL).

     The options _f_s_p__o_p_t, if any, are passed to ffffsssspppp....ooooppppeeeennnn(LOCAL).




(C) INRIA            Last change: 2020/02/12                    3






TGV MANUAL PAGES                                       TGV(LOCAL)



     The options _l_n_t__o_p_t, if any, are passed to llllnnnntttt....ooooppppeeeennnn(LOCAL).

     The options _l_o_t_o_s__o_p_t, if any, are passed  to  ccccaaaaeeeessssaaaarrrr(LOCAL)
     and to ccccaaaaeeeessssaaaarrrr....aaaaddddtttt(LOCAL).

     The options _s_e_q__o_p_t, if any, are passed to sssseeeeqqqq....ooooppppeeeennnn(LOCAL).

     The options _c_c__o_p_t, if any,  are passed to cccccccc(1).

     The options _t_g_v__o_p_t, if any, are passed to the TGV program.

TTTTGGGGVVVV OOOOPPPPTTTTIIIIOOOONNNNSSSS
     The following _t_g_v__o_p_t are currently available:

     ----vvvveeeerrrrbbbboooosssseeee
          Verbose mode: TGV displays information about the calcu-
          lations going on. Not a default option.

     ----iiiioooo _f_i_l_e[....iiiioooo]
          Specify  the  inputs/outputs  of   the   specification,
          according  to  _f_i_l_e[....iiiioooo]  (in  case  of  renaming  with
          ----rrrreeeennnnaaaammmmeeee option,  the  ....iiiioooo  file  must  contain  _r_e_n_a_m_e_d
          labels).

     ----rrrreeeennnnaaaammmmeeee _f_i_l_e[....rrrreeeennnn|....rrrreeeennnnaaaammmmeeee]
          Use the renaming rules defined in _f_i_l_e[....rrrreeeennnn|....rrrreeeennnnaaaammmmeeee] to
          rename the labels of the product SPEC x TP.

     ----hhhhiiiiddddeeee _f_i_l_e[....hhhhiiiidddd|....hhhhiiiiddddeeee]
          Use the hiding rules  defined  in  _f_i_l_e[....hhhhiiiidddd|....hhhhiiiiddddeeee]  to
          hide some labels of the product SPEC x TP.

     ----ttttpppppppprrrriiiioooorrrr
          Priority to actions of the test  purpose.  By  default,
          the actions of the specification are prior.

     ----oooouuuuttttpppprrrriiiioooorrrr
          Priority to the outputs. By  default,  the  inputs  are
          prior.

     ----sssseeeellllffff
          For each  state _s of the test purpose such that _s  does
          not  have,  for  each action _a of the specification, an
          outgoing transition labelled with _a,  and  _s  does  not
          have  an  outgoing  transition labelled with the prede-
          fined label "****", silently add on state  _s  a  self-loop
          transition  labelled with "****". By default, such a self-
          loop transition is added too, but a warning message  is
          emitted for each such state _s.

     ----hhhhaaaasssshhhh _n
          Fix the table hash size to _n (by default, 100000).



(C) INRIA            Last change: 2020/02/12                    4






TGV MANUAL PAGES                                       TGV(LOCAL)



     ----ddddeeeepppptttthhhh _n
          Fix the maximum preamble-body depth search to _n.

     ----oooouuuuttttppppuuuutttt _f_i_l_e[....bbbbccccgggg|....aaaauuuutttt] [----ppppaaaarrrrsssseeee|----uuuunnnnppppaaaarrrrsssseeee]
          Specify the name_f_i_l_e[....bbbbccccgggg|....aaaauuuutttt] of the output  file  in
          which  TGV  will display the test case. If the filename
          extension is ....aaaauuuutttt, the result is an  AUT  file.  Other-
          wise,  the  result  file  is  a  BCG file with the ....bbbbccccgggg
          extension. By default, the result is printed on the BCG
          file _t_g_v__r_e_s_u_l_t....bbbbccccgggg.

          If the produced test case is  in  BCG  format,  options
          ----ppppaaaarrrrsssseeee  and  ----uuuunnnnppppaaaarrrrsssseeee can be specified to control label
          parsing (see the bbbbccccgggg____wwwwrrrriiiitttteeee(LOCAL)  manual  page  for  a
          technical   discussion  about  label  parsing).  Option
          ----ppppaaaarrrrsssseeee enables label parsing and option  ----uuuunnnnppppaaaarrrrsssseeee  dis-
          ables  label  parsing.  By  default,  label  parsing is
          enabled.


     ----llllaaaabbbbeeeellll
          Display all fired labels. Notice  that  displaying  all
          labels  of  the  specification can be obtained by using
          this option with the following test purpose:
               ddddeeeessss ((((0000,,,, 3333,,,, 2222))))
               ((((0000,,,, ****,,,, 0000))))
               ((((0000,,,, """"dddduuuummmmmmmmyyyy::::"""",,,, 1111))))
               ((((1111,,,, AAAACCCCCCCCEEEEPPPPTTTT,,,, 1111)))).

     ----kkkkeeeeeeeepppplllloooocccckkkk
          By default, TGV computes lock  transitions  (LLLLOOOOCCCCKKKK)  and
          prints  those  that  remain  after  conflicts have been
          resolved. Use ----kkkkeeeeeeeepppplllloooocccckkkk (without ----ccccssssgggg) to keep all  the
          computed locks (the produced test graph is no more com-
          pletely controllable).

     ----uuuunnnnlllloooocccckkkk|----ddddiiiifffffffflllloooocccckkkk
          Avoid the printing  of  lock  transitions  with  option
          ----uuuunnnnlllloooocccckkkk. Make difference between lock tags (OOOOUUUUTTTTPPPPUUUUTTTTLLLLOOOOCCCCKKKK,,,,
          DDDDEEEEAAAADDDDLLLLOOOOCCCCKKKK,,,, LLLLIIIIVVVVEEEELLLLOOOOCCCCKKKK) with option ----ddddiiiifffffffflllloooocccckkkk.

     ----ccccssssgggg|----uuuunnnnlllloooooooopppp
          Compute the complete test graph (option ----ccccssssgggg)  or  com-
          pute  a  controllable  test  case  without loop (option
          ----uuuunnnnlllloooooooopppp). By default, TGV  computes  controllable  test
          cases with loops.


     ----ppppoooosssstttt
          Search a postamble from pass  and  inconclusive  states
          (i.e.  a path to stable states in which no message from
          the IUT is expected).



(C) INRIA            Last change: 2020/02/12                    5






TGV MANUAL PAGES                                       TGV(LOCAL)



     ----ppppoooossssttttddddeeeepppptttthhhh _n
          Fix the maximum postamble depth search to _n.

     ----rrrraaaannnnddddoooommmm
          Compute a random test case. Not a default option.

     ----rrrraaaannnnddddoooommmmsssseeeeeeeedddd _n
          Use _n as seed for random test-case generation.

     ----vvvveeeerrrriiiiffff
          Do not annotate transition labels with input or output,
          nor  with verdicts, but generate separate, self-looping
          verdict transitions for each verdict state. This option
          is  incompatible  with  options  ----ttttiiiimmmmeeeerrrr, ----ddddiiiifffffffflllloooocccckkkk, and
          ----uuuunnnnlllloooocccckkkk.


     ----ttttiiiimmmmeeeerrrr
          Produce a test case with test timers (TAC  and  TNOAC).
          TAC is started when the tester is waiting for an output
          from the IUT. TNOAC allows to detect a  lock  state  of
          the IUT.


     ----mmmmoooonnnniiiittttoooorrrr
          Open a window for monitoring in real-time  the  genera-
          tion  of  the  test case or complete test graph.  Not a
          default option.


     ----ppppaaaarrrrsssseeee
          Enable label parsing when reading files in the AUT for-
          mat  and/or  writing  files  in the BCG format (see the
          bbbbccccgggg____wwwwrrrriiiitttteeee(LOCAL) manual page for a technical discussion
          about  label  parsing).  Note that this also applies to
          the implicit conversions of command-line  arguments  in
          the AUT format.  Default option.


     ----uuuunnnnppppaaaarrrrsssseeee
          Disable label parsing when reading  files  in  the  AUT
          format  and/or writing files in the BCG format (see the
          bbbbccccgggg____wwwwrrrriiiitttteeee(LOCAL) manual page for a technical discussion
          about  label  parsing).  Note that this also applies to
          the implicit conversions of command-line  arguments  in
          the AUT format.  Not a default option.


IIII////OOOO FFFFIIIILLLLEEEE
     It is recommended to  write  an  ....iiiioooo  file,  to  distinguish
     between  inputs and outputs. The ....iiiioooo file describes a set of




(C) INRIA            Last change: 2020/02/12                    6






TGV MANUAL PAGES                                       TGV(LOCAL)



     actions, according to the following grammar:

            <<<<ffffiiiilllleeee....iiiioooo>>>> ::::::::==== ''''iiiinnnnppppuuuutttt'''' |||| ''''oooouuuuttttppppuuuutttt'''' \\\\nnnn <<<<rrrreeeeggggeeeexxxxpppp----lllliiiisssstttt>>>>

            <<<<rrrreeeeggggeeeexxxxpppp----lllliiiisssstttt>>>> ::::::::==== <<<<rrrreeeeggggeeeexxxxpppp>>>> \\\\nnnn <<<<rrrreeeeggggeeeexxxxpppp----lllliiiisssstttt>>>>
                            |||| """"<<<<rrrreeeeggggeeeexxxxpppp>>>>"""" \\\\nnnn <<<<rrrreeeeggggeeeexxxxpppp----lllliiiisssstttt>>>>
                            |||| <<<<eeeemmmmppppttttyyyy>>>>


     Semantically, if the first line is equal to  iiiinnnnppppuuuutttt  (respec-
     tively  oooouuuuttttppppuuuutttt),  the  body  of  the  file describes all the
     inputs actions (respectively all outputs actions).

     Note: If option ----iiiioooo is not given, TGV uses  by  default  the
     file $$$$CCCCAAAADDDDPPPP////ssssrrrrcccc////ttttggggvvvv////ddddeeeeffffaaaauuuulllltttt....iiiioooo the contents of which are:

                iiiinnnnppppuuuutttt
                [[[[^^^^!!!!]]]]****[[[[????]]]]....****

HHHHIIIIDDDDEEEE FFFFIIIILLLLEEEE
     This is an optional input file. See the ccccaaaaeeeessssaaaarrrr____hhhhiiiiddddeeee____1111(LOCAL)
     manual page for the grammar description and examples.


RRRREEEENNNNAAAAMMMMEEEE FFFFIIIILLLLEEEE
     This    is    an    optional    input    file.    See    the
     ccccaaaaeeeessssaaaarrrr____rrrreeeennnnaaaammmmeeee____1111(LOCAL)  manual page for the grammar descrip-
     tion and examples.

     Note 1: renaming patterns are  applied  _b_e_f_o_r_e  hiding  pat-
     terns.  Renaming  and  hiding patterns are applied after the
     synchronous product SPECxTP.

     Note 2: the ....iiiioooo file must be written in accordance with  the
     ....rrrreeeennnn  (or  ....rrrreeeennnnaaaammmmeeee ) and ....hhhhiiiidddd (or ....hhhhiiiiddddeeee ) files (because the
     ....iiiioooo file is read after the renaming and hiding).


TTTTGGGGVVVV MMMMEEEESSSSSSSSAAAAGGGGEEEESSSS
     If TGV produces a test case,  the  execution  finishes  with
     the  following message: "FFFFiiiilllleeee _f_i_l_e pppprrrroooodddduuuucccceeeedddd". Otherwise, the
     message "NNNNoooo tttteeeesssstttt ccccaaaasssseeee" is printed: may be it is because  the
     test  purpose  is  not  valid, or because of an error in the
     description of files ....iiiioooo or ....hhhhiiiidddd or ....rrrreeeennnn


AAAAUUUUTTTTHHHHOOOORRRRSSSS
     Thierry Jeron (Thierry.Jeron@irisa.fr),  Pierre  Morel,  and
     Severine  Simon.   A  few  patches  were brought by Wendelin
     Serwe and Hubert Garavel in December 2004. Since  then,  TGV
     has  been ported to 64-bit architectures and regularly main-
     tained by Wendelin Serwe and Hubert Garavel.



(C) INRIA            Last change: 2020/02/12                    7






TGV MANUAL PAGES                                       TGV(LOCAL)



SSSSEEEEEEEE AAAALLLLSSSSOOOO
     OPEN/CAESAR Reference Manual,  bbbbccccgggg(LOCAL),  bbbbccccgggg____ooooppppeeeennnn(LOCAL),
     ccccaaaaeeeessssaaaarrrr(LOCAL),         ccccaaaaeeeessssaaaarrrr....aaaaddddtttt(LOCAL),        eeeexxxxpppp(LOCAL),
     eeeexxxxpppp....ooooppppeeeennnn(LOCAL),      ffffsssspppp....ooooppppeeeennnn(LOCAL),      llllnnnntttt....ooooppppeeeennnn(LOCAL),
     lllloooottttoooossss(LOCAL), lllloooottttoooossss....ooooppppeeeennnn(LOCAL), sssseeeeqqqq(LOCAL), sssseeeeqqqq....ooooppppeeeennnn(LOCAL)


BBBBUUUUGGGGSSSS
     Please report any bug to cadp@inria.fr














































(C) INRIA            Last change: 2020/02/12                    8



