


CADP MANUAL PAGES                               BCG_STEADY(LOCAL)



NNNNAAAAMMMMEEEE
     bcg_steady - steady-state numerical analysis  of  (extended)
     continuous-time Markov chains encoded in the BCG format


SSSSYYYYNNNNOOOOPPPPSSSSIIIISSSS
     bbbbccccgggg____sssstttteeeeaaaaddddyyyy [_b_c_g__o_p_t_i_o_n_s] [----eeeeppppssssiiiilllloooonnnn _e_p_s] [----ssssoooollll _s_o_l_u_t_i_o_n__f_i_l_e]
     [----tttthhhhrrrr  [----aaaappppppppeeeennnndddd]  _t_h_r_o_u_g_h_p_u_t__f_i_l_e]  [----mmmmaaaatttt _m_a_t_r_i_x__f_i_l_e] [----rrrreeeedddd
     _r_e_d_u_c_e_d__m_a_t_r_i_x__f_i_l_e]    [----lllloooogggg    _l_o_g__f_i_l_e]    _f_i_l_e_n_a_m_e[[[[....bbbbccccgggg]]]]
     [_p_a_r_a_m_e_t_e_r=_v_a_l_u_e ...]


     where _b_c_g__o_p_t_i_o_n_s is defined below (see GENERAL OPTIONS).


DDDDEEEESSSSCCCCRRRRIIIIPPPPTTTTIIIIOOOONNNN
     bbbbccccgggg____sssstttteeeeaaaaddddyyyy performs steady-state analysis  on  _f_i_l_e_n_a_m_e....bbbbccccgggg,
     which  is an (extended) continuous-time Markov chain encoded
     in the BCG format.


     bbbbccccgggg____sssstttteeeeaaaaddddyyyy first transforms _f_i_l_e_n_a_m_e....bbbbccccgggg  into  a  numerical
     matrix  indexed  by  states. Then, it reduces this matrix by
     normalizing probabilistic transitions, removing  unreachable
     states  and  "vanishing"  states,  keeping "tangible" states
     only (see section INPUT below  for  details  about  the  BCG
     graphs accepted by bbbbccccgggg____sssstttteeeeaaaaddddyyyy and the definition of tangible
     and vanishing states).  As  a  result,  the  reduced  matrix
     obtained is the generator matrix of a continuous-time Markov
     chain.  Finally,  bbbbccccgggg____sssstttteeeeaaaaddddyyyy  computes   the   corresponding
     equilibrium ("steady-state") probability distribution on the
     long  run  using  the  Gauss/Seidel  algorithm   (see   e.g.
     [Ste94]).  It  can  also compute throughputs for the transi-
     tions of the system.


GGGGEEEENNNNEEEERRRRAAAALLLL OOOOPPPPTTTTIIIIOOOONNNNSSSS
     The following _b_c_g__o_p_t_i_o_n_s are currently supported: ----vvvveeeerrrrssssiiiioooonnnn,
     ----ccccrrrreeeeaaaatttteeee, ----uuuuppppddddaaaatttteeee, ----rrrreeeemmmmoooovvvveeee, ----cccccccc, and ----ttttmmmmpppp. See the bbbbccccgggg(LOCAL)
     manual page for a description of these options.


PPPPAAAARRRRTTTTIIIICCCCUUUULLLLAAAARRRR OOOOPPPPTTTTIIIIOOOONNNNSSSS
     Taking as input _f_i_l_e_n_a_m_e....bbbbccccgggg, on the form of  which  various
     restrictions apply (see section INPUT below), bbbbccccgggg____sssstttteeeeaaaaddddyyyy can
     produce  five  kinds  of  output  files,  depending  on  the
     command-line options specified.


     The optional list of "_p_a_r_a_m_e_t_e_r=_v_a_l_u_e" arguments at the  end
     of the command-line (where _p_a_r_a_m_e_t_e_r is any character string
     that neither contain blanks nor the "=" character, and where



(C) INRIA            Last change: 2019/01/08                    1






CADP MANUAL PAGES                               BCG_STEADY(LOCAL)



     _v_a_l_u_e  is any character string that does not contain blanks)
     is only meaningful to option ----tttthhhhrrrr.  These arguments have  no
     influence  on  the  actual numerical computations, they only
     serve to add  columns  in  throughput  tables  (see  section
     OUTPUT-2 below).


     The following options are supported:


     ----eeeeppppssssiiiilllloooonnnn _e_p_s
          Set the precision of certain floating-point comparisons
          to  _e_p_s,  where _e_p_s is a real value. When _e_p_s is out of
          [0..1[, bbbbccccgggg____sssstttteeeeaaaaddddyyyy reports an error. Default value  for
          _e_p_s is 1E-6.


     ----ssssoooollll _s_o_l_u_t_i_o_n__f_i_l_e
          Write the probability vector, computed at  the  equili-
          brium   state,   to  file  _s_o_l_u_t_i_o_n__f_i_l_e  (see  section
          OUTPUT-1 below for a description of the  file  format).
          If  _s_o_l_u_t_i_o_n__f_i_l_e  already exists, its contents will be
          overwritten. If _s_o_l_u_t_i_o_n__f_i_l_e is equal to  the  special
          string  `-', the probability vector is displayed on the
          standard output. Not a default option.


     ----tttthhhhrrrr [----aaaappppppppeeeennnndddd] _t_h_r_o_u_g_h_p_u_t__f_i_l_e
          Write  the  transition  throughputs,  computed  at  the
          equilibrium  state, to file _t_h_r_o_u_g_h_p_u_t__f_i_l_e. The format
          of this file is determined by the  suffix  (i.e.,  file
          extension)  of  _t_h_r_o_u_g_h_p_u_t__f_i_l_e  (see  section OUTPUT-2
          below for a description of the available file formats).
          If _t_h_r_o_u_g_h_p_u_t__f_i_l_e already exists, its contents will be
          overwritten, unless the ----aaaappppppppeeeennnndddd option is specified, in
          which  case the transition throughputs will be added at
          the end of _t_h_r_o_u_g_h_p_u_t__f_i_l_e so as to form a proper  data
          table.   If   the   ----tttthhhhrrrr   option   is  missing  or  if
          _t_h_r_o_u_g_h_p_u_t__f_i_l_e is equal to the special string `-', the
          transition  throughputs  are  displayed on the standard
          output.  Option "----tttthhhhrrrr ----" is the default option when the
          command  line  does  not  contain  any of the following
          options: ----mmmmaaaatttt, ----rrrreeeedddd, ----ssssoooollll, and ----tttthhhhrrrr.


     ----mmmmaaaatttt _m_a_t_r_i_x__f_i_l_e
          Write the transposed  "raw"  matrix  (prior  to  matrix
          reduction) to file _m_a_t_r_i_x__f_i_l_e. The format of this file
          is determined by the suffix (i.e., file  extension)  of
          _m_a_t_r_i_x__f_i_l_e  (see section OUTPUT-3 below for a descrip-
          tion of the available  file  formats).  If  _m_a_t_r_i_x__f_i_l_e
          already  exists,  its  contents will be overwritten. If



(C) INRIA            Last change: 2019/01/08                    2






CADP MANUAL PAGES                               BCG_STEADY(LOCAL)



          _m_a_t_r_i_x__f_i_l_e is equal to the  special  string  `-',  the
          matrix  is  displayed  on  the  standard output.  Not a
          default option.


     ----rrrreeeedddd _r_e_d_u_c_e_d__m_a_t_r_i_x__f_i_l_e
          Write   the   reduced   transposed   matrix   to   file
          _r_e_d_u_c_e_d__m_a_t_r_i_x__f_i_l_e.  The format of this file is deter-
          mined  by  the  suffix  (i.e.,   file   extension)   of
          _r_e_d_u_c_e_d__m_a_t_r_i_x__f_i_l_e  (see  section OUTPUT-3 below for a
          description  of  the  available   file   formats).   If
          _r_e_d_u_c_e_d__m_a_t_r_i_x__f_i_l_e  already  exists, its contents will
          be overwritten.  If _r_e_d_u_c_e_d__m_a_t_r_i_x__f_i_l_e is equal to the
          special  string  `-',  the  matrix  is displayed on the
          standard output.  Not a default option.


     ----lllloooogggg _l_o_g__f_i_l_e
          Write various information  about  data  structures  and
          computations  to file _l_o_g__f_i_l_e. The format of this file
          is  undocumented  but  self-understandable,  and  might
          change  in  future  releases of _b_c_g__s_t_e_a_d_y. If _l_o_g__f_i_l_e
          already exists, its contents will  be  overwritten.  If
          _l_o_g__f_i_l_e  is  equal to the special string `-', informa-
          tion is  displayed  on  the  standard  output.   Not  a
          default option.


     The  files  _s_o_l_u_t_i_o_n__f_i_l_e,   _t_h_r_o_u_g_h_p_u_t__f_i_l_e,   _m_a_t_r_i_x__f_i_l_e,
     _r_e_d_u_c_e_d__m_a_t_r_i_x__f_i_l_e,  and  _l_o_g__f_i_l_e  should be pairwise dif-
     ferent; otherwise, the result is undefined.


IIIINNNNPPPPUUUUTTTT:::: TTTTHHHHEEEE BBBBCCCCGGGG GGGGRRRRAAAAPPPPHHHH
     The input of bbbbccccgggg____sssstttteeeeaaaaddddyyyy is an extended Markovian model  com-
     bining  features from discrete-time and continuous-time Mar-
     kov  chains.   In  order  to  be  accepted  by   bbbbccccgggg____sssstttteeeeaaaaddddyyyy,
     _f_i_l_e_n_a_m_e....bbbbccccgggg  must  satisfy several conditions, otherwise an
     error message will occur.

     All transition labels of _f_i_l_e_n_a_m_e....bbbbccccgggg must have one  of  the
     following forms:

     -    "rrrraaaatttteeee %_f" (called a stochastic transition),

     -    "_l_a_b_e_l;;;; rrrraaaatttteeee %_f" (called a labelled stochastic  transi-
          tion),

     -    "pppprrrroooobbbb %_p" (called a probabilistic transition), or

     -    "_l_a_b_e_l;;;; pppprrrroooobbbb %_p" (called a labelled probabilistic tran-
          sition),



(C) INRIA            Last change: 2019/01/08                    3






CADP MANUAL PAGES                               BCG_STEADY(LOCAL)



     where %%%%ffff denotes a strictly positive floating-point  number,
     %%%%pppp  denotes a floating-point number in the range ]0..1], and
     _l_a_b_e_l denotes a character string that does not  contain  the
     ";;;;"  character  (_l_a_b_e_l  may be equal to the internal action,
     often noted "i" or "tau").


     Note: transitions labelled with only "_l_a_b_e_l" are always for-
     bidden  by  bbbbccccgggg____sssstttteeeeaaaaddddyyyy,  including  the  case  where "_l_a_b_e_l"
     denotes the internal action.


     When constructing the "raw" matrix, all _l_a_b_e_ls occurring  in
     labelled probabilistic transitions are discarded.


     If there exists a (labelled) probabilistic transition from a
     state _S_1 to a state _S_2, then all (labelled) stochastic tran-
     sitions from _S_1 to any state (including  _S_2)  are  discarded
     when  constructing the "raw" matrix. This reflects that pro-
     babilistic transitions are instantaneous,  while  stochastic
     transitions are not.


     We classify states as being either _v_a_n_i_s_h_i_n_g if at least one
     (possibly  labelled)  probabilistic  transition  goes out of
     these states, or _t_a_n_g_i_b_l_e otherwise.


     The input BCG graph should contain  at  least  one  tangible
     state,  and  it  should  not contain cycles (including self-
     loops) of states connected  by  (possibly  labelled)  proba-
     bilistic transitions.


     Note: The sum of %%%%pppp values on all (possibly labelled) proba-
     bilistic  transitions leaving a vanishing state needs not be
     equal to 1; if this sum is different  from  1,  then  proba-
     bilistic  values  will  be normalized (i.e., divided by this
     sum).


     To build the reduced matrix, bbbbccccgggg____sssstttteeeeaaaaddddyyyy eliminates all  van-
     ishing  states, so that this matrix contains tangible states
     only. The input BCG graph should be such that, after  reduc-
     tion,  each  tangible  state possesses at least one outgoing
     transition (i.e., there is no deadlock state).


     See also bbbbccccgggg____mmmmiiiinnnn(LOCAL) for a discussion about  the  various
     probabilistic  and  stochastic models present in the litera-
     ture.



(C) INRIA            Last change: 2019/01/08                    4






CADP MANUAL PAGES                               BCG_STEADY(LOCAL)



OOOOUUUUTTTTPPPPUUUUTTTT----1111:::: TTTTHHHHEEEE SSSSOOOOLLLLUUUUTTTTIIIIOOOONNNN VVVVEEEECCCCTTTTOOOORRRR
     The format of the file generated using the  ----ssssoooollll  option  of
     bbbbccccgggg____sssstttteeeeaaaaddddyyyy  is the following. There is one line per tangible
     state.   Each  line  contains  two   numbers:   an   integer
     corresponding to the state number in the input BCG graph and
     a real number corresponding to the probability of  being  in
     this state on the long run (i.e., at the equilibrium).


OOOOUUUUTTTTPPPPUUUUTTTT----2222:::: TTTTHHHHEEEE TTTTRRRRAAAANNNNSSSSIIIITTTTIIIIOOOONNNN TTTTHHHHRRRROOOOUUUUGGGGHHHHPPPPUUUUTTTTSSSS
     The throughput table has  two  (possibly  empty)  groups  of
     columns:


     -    The first group contains one  column  for  each  option
          _p_a_r_a_m_e_t_e_r=_v_a_l_u_e   given   on  the  command-line.  These
          columns, if any, are useful when evaluating the perfor-
          mance  of a system parameterized with one or more vari-
          ables, namely to aggregate in the same table  the  dif-
          ferent  throughputs measures corresponding to different
          values of the parameters. Columns of  the  first  group
          appear  in  the same order as the corresponding options
          on the command-line.


     -    The second group contains one column per labelled  sto-
          chastic  transition  label  present  in  the  input BCG
          graph, precisely, one column for each  different  _l_a_b_e_l
          occurring on a transition of the form "_l_a_b_e_l;;;; rrrraaaatttteeee %%%%ffff".


     The throughput table starts with a first "header" line  fol-
     lowed by one or several "subsequent" lines.


     -    The header line contains the "titles" of columns. For a
          column   of   the   first   group   associated   to   a
          _p_a_r_a_m_e_t_e_r=_v_a_l_u_e  option,  the  corresponding  title  is
          _p_a_r_a_m_e_t_e_r.  For a column of the second group associated
          to a  label,  the  corresponding  title  is  the  label
          itself.


     -    The subsequent lines contain values. For  a  column  of
          the first group associated to a _p_a_r_a_m_e_t_e_r=_v_a_l_u_e option,
          the corresponding cell contains _v_a_l_u_e. For a column  of
          the second group associated to a _l_a_b_e_l, the correspond-
          ing cell contains the throughput for this label,  i.e.,
          the     sum,    for    each    stochastic    transition
          "_l_a_b_e_l;;;; rrrraaaatttteeee %%%%ffff", of the rate value  %_f  weighted  with
          the  probability  of being in the tangible source state
          of this transition, in the long run.



(C) INRIA            Last change: 2019/01/08                    5






CADP MANUAL PAGES                               BCG_STEADY(LOCAL)



     If the ----aaaappppppppeeeennnndddd option is absent, or if the  throughput  file
     is  equal  to  the  special string `-', or if the throughput
     file does not exist, or if it is empty, _b_c_g__s_t_e_a_d_y will gen-
     erate  automatically  the  header line and one single subse-
     quent line.


     Otherwise, the first line of the throughput file is expected
     to contain the titles of columns and will be parsed to iden-
     tify the correspondance between labels and columns. In  par-
     ticular,  bbbbccccgggg____sssstttteeeeaaaaddddyyyy  checks that the first group of columns
     corresponds to the parameters  given  on  the  command-line.
     After  parsing  the  header line, bbbbccccgggg____sssstttteeeeaaaaddddyyyy will append one
     single subsequent line at the end of the throughput file. As
     regards the second group of columns, if the label of a given
     column  title  does  not  occur  in  _f_i_l_e_n_a_m_e....bbbbccccgggg,  a   zero
     throughput  will  be  reported  in the corresponding column;
     conversely, labels of _f_i_l_e_n_a_m_e....bbbbccccgggg for  which  there  is  no
     corresponding column title will be ignored.


     Throughputs can be displayed in two different formats, which
     are  determined  according  to the suffix (i.e., file exten-
     sion) of the throughput file name.


     -    If  the  file  name  has  the  "....ccccssssvvvv"  extension,   the
          throughput  table  will be displayed in the CSV (Comma-
          Separated Values) exchange format  understood  by  most
          relational   data  base  applications  and  spreadsheet
          software (such as Microsoft Excel, etc.).


     -    Otherwise, if the file name has a different  extension,
          or  no  extension,  or  if  it  is the standard output,
          throughputs will be displayed in a human-readable  for-
          mat  that  is  essentially  the same format as CSV with
          commas replaced by spaces so as to align columns  prop-
          erly.  Note that this format is also understood by some
          data visualization tools such as Gnuplot.


OOOOUUUUTTTTPPPPUUUUTTTT----3333:::: TTTTHHHHEEEE ((((TTTTRRRRAAAANNNNSSSSPPPPOOOOSSSSEEEEDDDD)))) MMMMAAAATTTTRRRRIIIICCCCEEEESSSS
     Both the (transposed) "raw"  matrix  produced  using  option
     ----mmmmaaaatttt  and  the  (transposed)  reduced  matrix produced using
     option ----rrrreeeedddd follow the same format conventions.  The  essen-
     tial  difference  is  that the former contains vanishing and
     tangible states, whereas the latter only  contains  tangible
     states.  Also,  the  reduced  matrix  is  a  generator  of a
     continuous-time Markov chain.





(C) INRIA            Last change: 2019/01/08                    6






CADP MANUAL PAGES                               BCG_STEADY(LOCAL)



     For two different indexes _i and _j, the element (_i,_j) of  the
     matrix,  located at the _i-th row and the _j-th column, is the
     sum of all the  floating-point  numbers  associated  to  the
     (labelled)  stochastic  or  probabilistic  transitions going
     from the _j-th state to the _i-th state, where  floating-point
     numbers  associated to (labelled) stochastic transitions are
     interpreted  as  positive  numbers  whereas   floating-point
     numbers  associated  to (labelled) probabilistic transitions
     are interpreted as negative numbers between -1 and  0.  Note
     that  rates and probabilities are never mixed since, between
     two states, there cannot  be  stochastic  and  probabilistic
     transitions at the same time.


     The diagonal elements (_j,_j) are defined to be  the  negative
     sum of all matrix elements (_i,_j) with _i different from _j.


     Matrices can be displayed in three different formats,  which
     are  determined  according  to the suffix (i.e., file exten-
     sion) of the matrix file name.


     -    If the file name has the "....ccccssssvvvv" extension,  the  matrix
          will  be  displayed in the CSV (Comma-Separated Values)
          format mentioned above.  Each  raw  of  the  matrix  is
          displayed  on  one line of the output file, and on each
          line, the matrix elements are separated with commas.


     -    If the file name has the "....ssssppppmmmm" extension,  the  matrix
          will  be displayed in the format used by the Sparse 1.3
          software library (see the CREDITS section below).  This
          format  is  the  following.  The first line of the file
          contains the file name.  The second line  contains  the
          number of states, followed by the "rrrreeeeaaaallll" keyword. Then,
          there is one line per each non-zero  element  (_i,_j)  in
          the matrix. Each line contains two integers followed by
          one real number:  the value of _i, the value of  _j,  and
          the  value of matrix element (_i,_j).  The file ends with
          a "sentinel" line consisting of three zeros.


     -    Otherwise, if the file name has a different  extension,
          or  no  extension, or if it is the standard output, the
          matrix will be displayed in  a  human-readable  format.
          The  columns  of the matrix are split into "packets" so
          that the text fits on the  size  of  the  display.  The
          indexes of rows and columns are indicated and null ele-
          ments of the matrix are displayed as "..."  instead  of
          "0".   Statistics (such as matrix size, density, etc.),
          are displayed after the matrix.



(C) INRIA            Last change: 2019/01/08                    7






CADP MANUAL PAGES                               BCG_STEADY(LOCAL)



     Note: for graphs  with  many  states,  whatever  the  chosen
     matrix  format,  the  matrix  files can be large and writing
     them to disk may take time.


EEEENNNNVVVVIIIIRRRROOOONNNNMMMMEEEENNNNTTTT VVVVAAAARRRRIIIIAAAABBBBLLLLEEEESSSS
     See the bbbbccccgggg(LOCAL) manual page  for  a  description  of  the
     environment variables used by all the BCG application tools.


EEEEXXXXIIIITTTT SSSSTTTTAAAATTTTUUUUSSSS
     Exit status is 0 if everything is all right, 1 otherwise.


AAAAUUUUTTTTHHHHOOOORRRRSSSS
     The first version of bbbbccccgggg____sssstttteeeeaaaaddddyyyy was  written  by  Christophe
     Joubert  (INRIA/VASY)  and Holger Hermanns (Saarland Univer-
     sity and University of Twente). The  algorithm  for  steady-
     state  analysis  is based on a former implementation by Vas-
     silis Mertsiotakis (University  of  Erlangen).  Bruno  Ondet
     (INRIA/VASY) ported the tool to various architectures. David
     Champelovier and Hubert Garavel (both at INRIA/VASY)  deeply
     revised  the  bbbbccccgggg____sssstttteeeeaaaaddddyyyy code and manual page to allow their
     integration within CADP.  Holger Hermanns and Frederic  Lang
     (INRIA/VASY) proof-checked the manual page.


CCCCRRRREEEEDDDDIIIITTTTSSSS
     bbbbccccgggg____sssstttteeeeaaaaddddyyyy uses (an extended  version  of)  the  Sparse  1.3
     package   from   the  University  of  California,  Berkeley,
     developed by Kenneth S. Kundert  under  the  supervision  of
     Alberto Sangiovanni-Vincentelli.


OOOOPPPPEEEERRRRAAAANNNNDDDDSSSS
     _f_i_l_e_n_a_m_e....bbbbccccgggg        BCG graph (input)
     _f_i_l_e_n_a_m_e@@@@1111....oooo        dynamic library (input or output)


FFFFIIIILLLLEEEESSSS
     $$$$CCCCAAAADDDDPPPP////bbbbiiiinnnn....````aaaarrrrcccchhhh````////bbbbccccgggg____sssstttteeeeaaaaddddyyyy     ``bbbbccccgggg____sssstttteeeeaaaaddddyyyy'' program


     See the bbbbccccgggg(LOCAL) manual page  for  a  description  of  the
     other files.


SSSSEEEEEEEE AAAALLLLSSSSOOOO
     bbbbccccgggg(LOCAL),      bbbbccccgggg____mmmmiiiinnnn(LOCAL),       bbbbccccgggg____ttttrrrraaaannnnssssiiiieeeennnntttt(LOCAL),
     ddddeeeetttteeeerrrrmmmmiiiinnnnaaaattttoooorrrr(LOCAL)





(C) INRIA            Last change: 2019/01/08                    8






CADP MANUAL PAGES                               BCG_STEADY(LOCAL)



     Additional information is available from the CADP  Web  page
     located at http://cadp.inria.fr

     Directives   for   installation   are   given    in    files
     $$$$CCCCAAAADDDDPPPP////IIIINNNNSSSSTTTTAAAALLLLLLLLAAAATTTTIIIIOOOONNNN____****.

     Recent  changes  and  improvements  to  this  software   are
     reported and commented in file $$$$CCCCAAAADDDDPPPP////HHHHIIIISSSSTTTTOOOORRRRYYYY.


BBBBUUUUGGGGSSSS
     Please report bugs to cadp@inria.fr


BBBBIIIIBBBBLLLLIIIIOOOOGGGGRRRRAAAAPPPPHHHHYYYY
     [GH02] H. Garavel and H. Hermanns. On  Combining  Functional
     Verification  and  Performance  Evaluation  using  CADP.  In
     proceedings of FME'2002, LNCS 2391, pages 410-429,  Springer
     Verlag.  Full  version  available  as  INRIA Research Report
     4492.                     Available                     from
     http://cadp.inria.fr/publications/Garavel-Hermanns-02.html


     [HJ03] H. Hermanns and Ch. Joubert. A Set of Performance and
     Dependability  Analysis  Components for CADP. In proceedings
     of TACAS'2003, LNCS 2619, pages  425-430,  Springer  Verlag.
     Available  from  http://cadp.inria.fr/publications/Hermanns-
     Joubert-03.html


     [Mer98] V. Mertsiotakis. Approximate  Analysis  Methods  for
     Stochastic  Process  Algebras.  Ph.D  Thesis,  University of
     Erlangen (Germany), 1998.


     [Ste94] W. J. Stewart. Introduction to the  Numerical  Solu-
     tion of Markov Chains. Princeton University Press, 1994.


















(C) INRIA            Last change: 2019/01/08                    9



