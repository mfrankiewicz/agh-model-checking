


CADP MANUAL PAGES                                ALDEBARAN(LOCAL)



NNNNAAAAMMMMEEEE
     aldebaran - minimization and comparison of labelled  transi-
     tions systems


IIIIMMMMPPPPOOOORRRRTTTTAAAANNNNTTTT NNNNOOOOTTTTIIIICCCCEEEE
     As of July 2008, aaaallllddddeeeebbbbaaaarrrraaaannnn is a  deprecated  tool  of  CADP.
     Instead  of aaaallllddddeeeebbbbaaaarrrraaaannnn it is highly recommended to invoke the
     following tools of CADP (either directly or indirectly using
     SVL):

     -    bbbbccccgggg____ccccmmmmpppp(LOCAL)

     -    bbbbccccgggg____iiiinnnnffffoooo(LOCAL)

     -    bbbbccccgggg____iiiioooo(LOCAL)

     -    bbbbccccgggg____llllaaaabbbbeeeellllssss(LOCAL)

     -    bbbbccccgggg____mmmmiiiinnnn(LOCAL)

     -    bbbbccccgggg____ooooppppeeeennnn(LOCAL)

     -    bbbbiiiissssiiiimmmmuuuullllaaaattttoooorrrr(LOCAL)

     -    ccccaaaaeeeessssaaaarrrr____hhhhiiiiddddeeee____1111(LOCAL)

     -    ccccaaaaeeeessssaaaarrrr____rrrreeeennnnaaaammmmeeee____1111(LOCAL)

     -    eeeevvvvaaaalllluuuuaaaattttoooorrrr(LOCAL)

     -    eeeexxxxpppp....ooooppppeeeennnn(LOCAL)

     -    eeeexxxxhhhhiiiibbbbiiiittttoooorrrr(LOCAL)

     -    ggggeeeennnneeeerrrraaaattttoooorrrr(LOCAL)

     -    rrrreeeedddduuuuccccttttoooorrrr(LOCAL)


     From version 1.0 (January  1990)  to  version  6.6  (October
     2005),  aaaallllddddeeeebbbbaaaarrrraaaannnn  has  been a binary executable (located in
     "$CADP/bin.`arch`/aldebaran"       and       later        in
     "$CADP/bin.`arch`/aldebaran.old").  It  performed  minimiza-
     tions and comparisons of labelled transition systems,  using
     the  Paige  &  Tarjan algorithm, the Fernandez & Mounier on-
     the-fly algorithm, the Minimal Model  Generation  algorithm,
     and  algorithms  based  on Binary Decision Diagrams (BDD for
     short).  Because aaaallllddddeeeebbbbaaaarrrraaaannnn was no longer maintained  by  its
     authors and  was known to contain bugs (including false ver-
     dicts about equivalence or  preorder  comparisons),  it  was
     marked  as  deprecated  in  CADP  2006. In July 2008, it was



(C) INRIA            Last change: 2019/01/09                    1






CADP MANUAL PAGES                                ALDEBARAN(LOCAL)



     eventually removed from CADP because it would no longer com-
     pile  using gcc/g++ 3.4.*  and no one volunteered to port it
     to 64-bit platforms.


     Version 7.* of aaaallllddddeeeebbbbaaaarrrraaaannnn is a shell-script (located in  file
     "$CADP/com/aldebaran")  that  has been introduced in October
     2005. This shell-script invokes  the  CADP  tools  mentioned
     above and does not rely on aaaallllddddeeeebbbbaaaarrrraaaannnn 6.6. It provides exten-
     sive backward compatibility with previous versions of  aaaallllddddeeee----
     bbbbaaaarrrraaaannnn by supporting all their commands/options but ----ddddeeeeqqqquuuu. It
     also removes many limitations that existed in  the  previous
     versions of aaaallllddddeeeebbbbaaaarrrraaaannnn.


SSSSYYYYNNNNOOOOPPPPSSSSIIIISSSS
     aaaallllddddeeeebbbbaaaarrrraaaannnn _c_o_m_m_a_n_d [_o_p_t_i_o_n_s]
     aaaallllddddeeeebbbbaaaarrrraaaannnn _c_o_m_m_a_n_d [_o_p_t_i_o_n_s] _f_i_l_e_n_a_m_e_1
     aaaallllddddeeeebbbbaaaarrrraaaannnn _c_o_m_m_a_n_d [_o_p_t_i_o_n_s] _f_i_l_e_n_a_m_e_1 _f_i_l_e_n_a_m_e_2

     where _f_i_l_e_n_a_m_e can be either  a  file  in  Aldebaran  format
     (with suffix ....aaaauuuutttt), a file in BCG format (with suffix ....bbbbccccgggg),
     or a file describing  a  system  of  communicating  automata
     (with suffix ....eeeexxxxpppp).


DDDDEEEESSSSCCCCRRRRIIIIPPPPTTTTIIIIOOOONNNN
     aaaallllddddeeeebbbbaaaarrrraaaannnn allows the minimization or comparison of  Labelled
     Transitions  Systems (LTS for short) with respect to various
     equivalence and preorder relations. It can be applied:

     -    either to completely generated LTSs, which are  usually
          contained  in  files  with the ....aaaauuuutttt or ....bbbbccccgggg suffix. See
          the  aaaauuuutttt(LOCAL)  and  bbbbccccgggg(LOCAL)  manual  pages  for  a
          description  of  the  ....aaaauuuutttt  and ....bbbbccccgggg formats. aaaallllddddeeeebbbbaaaarrrraaaannnn
          also accepts other LTSs formats (such as ....ffffcccc2222  or  ....sssseeeeqqqq
          files):  in  such case, the bbbbccccgggg____iiiioooo tool is used to per-
          form silently the translation of  these  other  formats
          into the BCG format.

     -    or to networks of communicating LTSs,  which  are  con-
          tained   in   files  with  the  ....eeeexxxxpppp  suffix.  See  the
          eeeexxxxpppp(LOCAL) manual page for a description of  this  for-
          mat.


CCCCOOOOMMMMMMMMAAAANNNNDDDDSSSS
     The followings _c_o_m_m_a_n_ds are currently available:


     ----ddddeeeeaaaadddd
          Print the set of deadlock states (sinks) for a LTS or a



(C) INRIA            Last change: 2019/01/09                    2






CADP MANUAL PAGES                                ALDEBARAN(LOCAL)



          network of communicating LTSs.


     ----ddddeeeetttt
          Determinize a LTS and display the result as a new LTS.


     ----hhhheeeellllpppp
          Display the help file and stop.


     ----iiiinnnnffffoooo
          Print various graph structure information for  the  LTS
          contained in _f_i_l_e_n_a_m_e_1....((((aaaauuuutttt,,,,bbbbccccgggg)))) or the network of com-
          municating LTSs contained in  _f_i_l_e_n_a_m_e_1....eeeexxxxpppp.  See  also
          the  bbbbccccgggg____iiiinnnnffffoooo(LOCAL) tool, which provides more complete
          structure information on a BCG graph.


     ----lllliiiivvvveeee
          Check whether there are livelock states (tau  circuits)
          in  the  LTS or network of communicating LTSs stored in
          _f_i_l_e_n_a_m_e_1....((((aaaauuuutttt,,,,bbbbccccgggg,,,,eeeexxxxpppp)))).   If  so,  generate  in   file
          aaaallllddddeeeebbbbaaaarrrraaaannnn....bbbbccccgggg  a  diagnostic,  which  is  a subgraph of
          _f_i_l_e_n_a_m_e_1 that exhibits both a livelock and a  path  to
          the livelock, starting from the initial state.


     ----oooouuuuttttppppuuuutttt _f_i_l_e_n_a_m_e[....aaaauuuutttt|....bbbbccccgggg]
          Specify the name (either _f_i_l_e_n_a_m_e....aaaauuuutttt or  _f_i_l_e_n_a_m_e....bbbbccccgggg)
          and  the format (either ALDEBARAN format or BCG format)
          of the output file in which aaaallllddddeeeebbbbaaaarrrraaaannnn will display  its
          results  (for  those aaaallllddddeeeebbbbaaaarrrraaaannnn commands that produce an
          LTS). By default, if no ----oooouuuuttttppppuuuutttt command is  given,  the
          result  is  printed on the standard output in ALDEBARAN
          format.


     ----ppppaaaatttthhhh _n_b
          Compute in a LTS a path from the initial state  to  the
          state _n_b.  Display the result on the standard output as
          an LTS encoded in the sssseeeeqqqq(LOCAL) format (see the  DIAG-
          NOSTICS section below).


     ----ssssoooorrrrtttt
          Sort the LTS. Sorting is done with the source state  of
          transitions  as primary key, and the label as secondary
          key. The LTS descriptor remains at the beginning of the
          file.





(C) INRIA            Last change: 2019/01/09                    3






CADP MANUAL PAGES                                ALDEBARAN(LOCAL)



     ----vvvveeeerrrrssssiiiioooonnnn
          Display the current version number of the software  and
          stop.


     The remaining commands have the following syntax:

        ----<_r_e_l_a_t_i_o_n><_a_c_t_i_o_n>

     where <_r_e_l_a_t_i_o_n> is a one-character string, either bbbb, iiii,  oooo,
     pppp, or ssss:

     *    ````bbbb'''' : use the strong bisimulation equivalence [Park-81]
          or the corresponding preorder

     *    ````iiii'''' : use the tau*.a  bisimulation  [Fernandez-Mounier-
          90]  or the corresponding preorder (tau is written i in
          LOTOS)

     *    ````oooo'''' : use the observational relation [Milner-80]

     *    ````pppp'''' : use the branching bisimulation [R.J. Van Glabbeek
          and W.P. Weijland]

     *    ````ssss''''  :   use   the   safety   relation   [Rodriguez-88]
          [Bouajjani-Fernandez-Graf-Rodriguez-Sifakis-91]  or the
          corresponding preorder

     and where <_a_c_t_i_o_n> is a character string, either  mmmmiiiinnnn,  ccccllllaaaa,
     eeeeqqqquuuu or oooorrrrdddd:

     *    ````mmmmiiiinnnn''''    :    minimize    the    LTS    contained    in
          _f_i_l_e_n_a_m_e_1....((((aaaauuuutttt,,,,bbbbccccgggg)))),  or  the  network of communicating
          LTSs represented  by  _f_i_l_e_n_a_m_e_1....eeeexxxxpppp,  with  respect  to
          <_r_e_l_a_t_i_o_n> and display the minimized LTS

     *    ````ccccllllaaaa'''' : same as  above,  but  display  the  equivalence
          classes  on the standard output (instead of the reduced
          LTS)

     *    ````eeeeqqqquuuu''''   :    compare    both    LTSs    contained    in
          _f_i_l_e_n_a_m_e_1....((((aaaauuuutttt,,,,bbbbccccgggg))))  and  _f_i_l_e_n_a_m_e_2....((((aaaauuuutttt,,,,bbbbccccgggg)))),  or  the
          network of communicating LTSs _f_i_l_e_n_a_m_e_1....eeeexxxxpppp to the  LTS
          _f_i_l_e_n_a_m_e_2....((((aaaauuuutttt,,,,bbbbccccgggg)))),  or  the  network of communicating
          LTSs _f_i_l_e_n_a_m_e_2....eeeexxxxpppp  to  LTS  _f_i_l_e_n_a_m_e_1....((((aaaauuuutttt,,,,bbbbccccgggg)))),  with
          respect  to <_r_e_l_a_t_i_o_n>, using _a_l_g_o_r_i_t_h_m. The result can
          be either TTTTRRRRUUUUEEEE (both LTSs are equivalent) or FFFFAAAALLLLSSSSEEEE;  in
          the latter case, aaaallllddddeeeebbbbaaaarrrraaaannnn issues a diagnostic consist-
          ing  either  of  a  set  of  discriminating   sequences
          displayed  on standard output (see the DIAGNOSTICS sec-
          tion below), or of an acyclic BCG graph stored in  file
          aaaallllddddeeeebbbbaaaarrrraaaannnn....bbbbccccgggg  (see the ----ddddiiiiaaaagggg options of bbbbccccgggg____ccccmmmmpppp(LOCAL)



(C) INRIA            Last change: 2019/01/09                    4






CADP MANUAL PAGES                                ALDEBARAN(LOCAL)



          and bbbbiiiissssiiiimmmmuuuullllaaaattttoooorrrr(LOCAL) for details about diagnostics in
          the BCG format).

     *    ````oooorrrrdddd'''' : same  as  eeeeqqqquuuu,  but  use  a  preorder  relation
          instead of the equivalence relation


     In version 7.* of aaaallllddddeeeebbbbaaaarrrraaaannnn, the method is selected automat-
     ically as follows:

     -    As regards  tau*.a  and  safety  minimizations  (----iiiimmmmiiiinnnn,
          ----iiiiccccllllaaaa,  ----ppppmmmmiiiinnnn,  and  ----ppppccccllllaaaa  options),  the LTS is first
          pre-reduced on the fly using rrrreeeedddduuuuccccttttoooorrrr,  then  minimized
          modulo   strong  bisimulation  following  the  standard
          method using bbbbccccgggg____mmmmiiiinnnn.

     -    As regards strong and branching  minimizations  (----bbbbmmmmiiiinnnn,
          ----bbbbccccllllaaaa,  ----ppppmmmmiiiinnnn,  ----ppppccccllllaaaa),  the LTS is first generated (if
          needed) using ggggeeeennnneeeerrrraaaattttoooorrrr and  then  minimized  following
          the standard method using bbbbccccgggg____mmmmiiiinnnn.

     -    As regards comparisons modulo strong, branching, obser-
          vational,   tau*.a,  and  safety  equivalences  (----bbbbeeeeqqqquuuu,
          ----bbbboooorrrrdddd, ----ppppeeeeqqqquuuu, ----ppppoooorrrrdddd, ----ooooeeeeqqqquuuu, ----oooooooorrrrdddd, ----iiiieeeeqqqquuuu, ----iiiioooorrrrdddd, ----sssseeeeqqqquuuu,
          and  ----ssssoooorrrrdddd  options),  they are performed using bbbbccccgggg____ccccmmmmpppp
          or, if not possible, using bbbbiiiissssiiiimmmmuuuullllaaaattttoooorrrr.

     Note: options ----iiiioooorrrrdddd and ----ssssoooorrrrdddd are identical, since both com-
     pute the same preorder relation.


OOOOPPPPTTTTIIIIOOOONNNNSSSS
     The following _o_p_t_i_o_n_s are currently available:


     ----ssssttttaaaatttt
          Print various statistics.


     ----hhhhiiiiddddeeee _f_i_l_e_n_a_m_e
          Use the hiding rules defined in _f_i_l_e_n_a_m_e  to  hide  the
          labels  contained  in files _f_i_l_e_n_a_m_e_1....((((aaaauuuutttt,,,,bbbbccccgggg,,,,eeeexxxxpppp)))) and
          possibly     _f_i_l_e_n_a_m_e_2....((((aaaauuuutttt,,,,bbbbccccgggg,,,,eeeexxxxpppp)))).      See      the
          ccccaaaaeeeessssaaaarrrr____hhhhiiiiddddeeee____1111(LOCAL)   manual   page   for  a  detailed
          description of the  appropriate  format  for  _f_i_l_e_n_a_m_e.
          There  is  no required extension for _f_i_l_e_n_a_m_e; however,
          extensions "....hhhhiiiidddd" or "....hhhhiiiiddddeeee" are recommended for  using
          the  SVL  compiler  and  the EUCALYPTUS graphical user-
          interface.


     ----rrrreeeennnnaaaammmmeeee _f_i_l_e_n_a_m_e



(C) INRIA            Last change: 2019/01/09                    5






CADP MANUAL PAGES                                ALDEBARAN(LOCAL)



          Use the renaming rules defined in  _f_i_l_e_n_a_m_e  to  rename
          the  labels  contained in files _f_i_l_e_n_a_m_e_1....((((aaaauuuutttt,,,,bbbbccccgggg,,,,eeeexxxxpppp))))
          and   possibly   _f_i_l_e_n_a_m_e_2....((((aaaauuuutttt,,,,bbbbccccgggg,,,,eeeexxxxpppp)))).    See    the
          ccccaaaaeeeessssaaaarrrr____rrrreeeennnnaaaammmmeeee____1111(LOCAL) manual page for a description of
          the  appropriate  format  for  _f_i_l_e_n_a_m_e.  There  is  no
          required  extension  for  _f_i_l_e_n_a_m_e; however, extensions
          "....rrrreeeennnn" or "....rrrreeeennnnaaaammmmeeee" are recommended for using  the  SVL
          compiler and the EUCALYPTUS graphical user-interface.


     Renaming and hiding patterns are applied  in  the  order  in
     which they occur on the command line.


DDDDIIIIAAAAGGGGNNNNOOOOSSSSTTTTIIIICCCCSSSS
     aaaallllddddeeeebbbbaaaarrrraaaannnn produces diagnostics to explain why two  LTSs  are
     not  related  (eeeeqqqquuuu  or  oooorrrrdddd  commands). In the general case,
     these diagnostics are directed acyclic subgraphs (encoded in
     the BCG format) containing all sequences that, when executed
     simultaneously in  the  two  LTSs,  lead  to  non-equivalent
     states.  In the particular case where diagnostics are just a
     single sequence, aaaallllddddeeeebbbbaaaarrrraaaannnn displays this sequence using  the
     sssseeeeqqqq(LOCAL)  format,  in  the  same way as bbbbccccgggg____ccccmmmmpppp(LOCAL) and
     bbbbiiiissssiiiimmmmuuuullllaaaattttoooorrrr(LOCAL) do.


EEEEXXXXIIIITTTT SSSSTTTTAAAATTTTUUUUSSSS
     When the source is erroneous,  error  messages  are  issued.
     Exit status is 0 if everything is alright, 1 otherwise.


AAAAUUUUTTTTHHHHOOOORRRRSSSS
     Versions up to 6.6  of  aaaallllddddeeeebbbbaaaarrrraaaannnn  have  been  developed  by
     Jean-Claude Fernandez,  Laurent Mounier,  Alain Kerbrat, and
     Aline Senart (IMAG), with various bug fixes by Marc Herbert,
     Hubert Garavel, and Frederic Lang (INRIA Rhone-Alpes).


     Version 7.* of aaaallllddddeeeebbbbaaaarrrraaaannnn  was  developed  by  Frederic  Lang
     (INRIA Rhone-Alpes).


OOOOPPPPEEEERRRRAAAANNNNDDDDSSSS
     _f_i_l_e_n_a_m_e....aaaauuuutttt         LTS in the Aldebaran format  (input  or
                          output)
     _f_i_l_e_n_a_m_e....bbbbccccgggg         LTS in the BCG format (input or output)
     _f_i_l_e_n_a_m_e....eeeexxxxpppp         network of communicating LTSs (input)
     _f_i_l_e_n_a_m_e....hhhhiiiiddddeeee        list of labels to hide (input)
     _f_i_l_e_n_a_m_e....rrrreeeennnnaaaammmmeeee      list of labels to rename (input)






(C) INRIA            Last change: 2019/01/09                    6






CADP MANUAL PAGES                                ALDEBARAN(LOCAL)



FFFFIIIILLLLEEEESSSS
     $$$$CCCCAAAADDDDPPPP////LLLLIIIICCCCEEEENNNNSSSSEEEE                   license file
     $$$$CCCCAAAADDDDPPPP////ccccoooommmm////aaaallllddddeeeebbbbaaaarrrraaaannnn             shell-script (version 7.*)
     aaaallllddddeeeebbbbaaaarrrraaaannnn....bbbbccccgggg                   diagnostic file


SSSSEEEEEEEE AAAALLLLSSSSOOOO
     ALDEBARAN   Reference   Manual,   aaaauuuutttt(LOCAL),    bbbbccccgggg(LOCAL),
     bbbbccccgggg____ccccmmmmpppp(LOCAL),        bbbbccccgggg____iiiinnnnffffoooo(LOCAL),       bbbbccccgggg____iiiioooo(LOCAL),
     bbbbccccgggg____llllaaaabbbbeeeellllssss(LOCAL),     bbbbccccgggg____mmmmiiiinnnn(LOCAL),      bbbbccccgggg____ooooppppeeeennnn(LOCAL),
     bbbbiiiissssiiiimmmmuuuullllaaaattttoooorrrr(LOCAL),                    ccccaaaaeeeessssaaaarrrr____hhhhiiiiddddeeee____1111(LOCAL),
     ccccaaaaeeeessssaaaarrrr____rrrreeeennnnaaaammmmeeee____1111(LOCAL),    eeeevvvvaaaalllluuuuaaaattttoooorrrr(LOCAL),     eeeexxxxpppp(LOCAL),
     eeeexxxxpppp....ooooppppeeeennnn(LOCAL),     eeeexxxxhhhhiiiibbbbiiiittttoooorrrr(LOCAL),     ggggeeeennnneeeerrrraaaattttoooorrrr(LOCAL),
     rrrreeeedddduuuuccccttttoooorrrr(LOCAL), sssseeeeqqqq(LOCAL)

     Additional information is available from the CADP  Web  page
     located at http://cadp.inria.fr

     Directives   for   installation   are   given    in    files
     $$$$CCCCAAAADDDDPPPP////IIIINNNNSSSSTTTTAAAALLLLLLLLAAAATTTTIIIIOOOONNNN____****....

     Recent  changes  and  improvements  to  this  software   are
     reported and commented in file $$$$CCCCAAAADDDDPPPP////HHHHIIIISSSSTTTTOOOORRRRYYYY....


BBBBUUUUGGGGSSSS
     Please report any bug to cadp@inria.fr




























(C) INRIA            Last change: 2019/01/09                    7



