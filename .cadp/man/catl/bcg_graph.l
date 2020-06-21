


CADP MANUAL PAGES                                BCG_GRAPH(LOCAL)



NNNNAAAAMMMMEEEE
     bcg_graph - generate various kinds of useful BCG graphs


SSSSYYYYNNNNOOOOPPPPSSSSIIIISSSS
     bbbbccccgggg____ggggrrrraaaapppphhhh  [_b_c_g__o_p_t_i_o_n_s]   -cccchhhhaaaaoooossss   [_l_a_b_e_l_f_i_l_e   |   ----llllaaaabbbbeeeellllssss
     _n_u_m_b_e_r _p_a_t_t_e_r_n_1] [----mmmmoooonnnniiiittttoooorrrr] [----vvvveeeerrrrbbbboooosssseeee] _o_u_t_p_u_t [....bbbbccccgggg]


     or


     bbbbccccgggg____ggggrrrraaaapppphhhh  [_b_c_g__o_p_t_i_o_n_s]  -bbbbaaaagggg  _s_i_z_e  [_l_a_b_e_l_f_i_l_e  |  ----llllaaaabbbbeeeellllssss
     _n_u_m_b_e_r _p_a_t_t_e_r_n_1   _p_a_t_t_e_r_n_2]   [----mmmmoooonnnniiiittttoooorrrr]  [----vvvveeeerrrrbbbboooosssseeee]  _o_u_t_p_u_t
     [....bbbbccccgggg]


     or


     bbbbccccgggg____ggggrrrraaaapppphhhh [_b_c_g__o_p_t_i_o_n_s]  -ffffiiiiffffoooo  _s_i_z_e  [_l_a_b_e_l_f_i_l_e  |  ----llllaaaabbbbeeeellllssss
     _n_u_m_b_e_r _p_a_t_t_e_r_n_1  _p_a_t_t_e_r_n_2]  [----mmmmoooonnnniiiittttoooorrrr]  [----vvvveeeerrrrbbbboooosssseeee  ]  _o_u_t_p_u_t
     [....bbbbccccgggg]


DDDDEEEESSSSCCCCRRRRIIIIPPPPTTTTIIIIOOOONNNN
     This command produces  a  BCG  graph  named  _o_u_t_p_u_t....bbbbccccgggg  the
     structure of which is specified by the command-line options.
     At present, three kinds of graphs  can  be  generated  using
     this  command: chaos automata, bag buffers, and FIFO buffers
     (see below for detailed definitions).


     Note: Such particular graphs could be easily described in  a
     high-level   language   such  as  LOTOS  or  LNT,  and  then
     translated to BCG. However, the bbbbccccgggg____ggggrrrraaaapppphhhh tool contains spe-
     cialized  algorithms designed for time and memory efficiency
     and ensuring that each generated graph  is  minimal  wrt  to
     branching bisimulation.


     Note: Unless specified otherwise, bbbbccccgggg____ggggrrrraaaapppphhhh generates graphs
     that  are  minimal for strong equivalence (i.e., that do not
     contain redondant states or transitions). However, this pro-
     perty  is  only ensured if the specified labels are pairwise
     different.


GGGGEEEENNNNEEEERRRRAAAALLLL OOOOPPPPTTTTIIIIOOOONNNNSSSS
     The  following  _b_c_g__o_p_t_i_o_n_s  are  currently  supported:    ----
     vvvveeeerrrrssssiiiioooonnnn,  ----ttttmmmmpppp,  ----uuuunnnnccccoooommmmpppprrrreeeessssssss,  ----ccccoooommmmpppprrrreeeessssssss, ----rrrreeeeggggiiiisssstttteeeerrrr, ----sssshhhhoooorrrrtttt,
     ----mmmmeeeeddddiiiiuuuummmm, and ----ssssiiiizzzzeeee. See the bbbbccccgggg(LOCAL)  manual  page  for  a



(C) INRIA            Last change: 2014/07/11                    1






CADP MANUAL PAGES                                BCG_GRAPH(LOCAL)



     description of these options.

     See the bbbbccccgggg(LOCAL) manual page for a  description  of  these
     options.


PPPPAAAARRRRTTTTIIIICCCCUUUULLLLAAAARRRR OOOOPPPPTTTTIIIIOOOONNNNSSSS
     The following options and arguments are also supported:


     -cccchhhhaaaaoooossss
          Generate a chaos automaton.   This  option  must  occur
          immediately after _b_c_g__o_p_t_i_o_n_s on the command-line.


     -bbbbaaaagggg _s_i_z_e
          Generate a bag buffer with _s_i_z_e places  (with  _s_i_z_e  >=
          0).    This   option   must   occur  immediately  after
          _b_c_g__o_p_t_i_o_n_s on the command-line.


     -ffffiiiiffffoooo _s_i_z_e
          Generate a FIFO buffer with _s_i_z_e places (with  _s_i_z_e  >=
          0).    This   option   must   occur  immediately  after
          _b_c_g__o_p_t_i_o_n_s on the command-line.


     _l_a_b_e_l_f_i_l_e
          Specify that the labels  of  the  generated  graph  are
          listed  in file _l_a_b_e_l_f_i_l_e containing an exhaustive list
          of labels, one label per line. See Section LABEL DEFIN-
          ITIONS below for details.


     -llllaaaabbbbeeeellllssss _n_u_m_b_e_r _p_a_t_t_e_r_n_1 [[[[_p_a_t_t_e_r_n_2]]]]
          Specify that the labels  of  the  generated  graph  are
          defined  by  _p_a_t_t_e_r_n_1  (and  possibly _p_a_t_t_e_r_n_2) instan-
          tiated by  integers  in  the  range  [1.._n_u_m_b_e_r]  (with
          _n_u_m_b_e_r  >= 0).  See Section LABEL DEFINITIONS below for
          a definition of patterns.  This option is forbidden  if
          _l_a_b_e_l_f_i_l_e is given and mandatory otherwise.


     -mmmmoooonnnniiiittttoooorrrr
          Open a window for monitoring the  graph  generation  in
          real-time.  Not a default option.


     -vvvveeeerrrrbbbboooosssseeee
          Display the number of states  and  transitions  of  the
          generated graph.  Not a default option.




(C) INRIA            Last change: 2014/07/11                    2






CADP MANUAL PAGES                                BCG_GRAPH(LOCAL)



CCCCHHHHAAAAOOOOSSSS AAAAUUUUTTTTOOOOMMMMAAAATTTTAAAA
     Chaos automata (----cccchhhhaaaaoooossss option)  accept  all  messages  in  a
     given set of messages.

     A chaos automaton is determined by the number N (with  N  >=
     0)  of  different  messages  it  can handle. It has a single
     state and N looping transitions, each  labelled  by  a  dif-
     ferent message.


BBBBAAAAGGGG BBBBUUUUFFFFFFFFEEEERRRRSSSS
     Bag buffers (----bbbbaaaagggg option) model communication media that  do
     not  lose  messages but do not preserve the ordering of mes-
     sages (messages are reset in any order).

     A bag buffer is determined by its size  P  (with  P  >=  0),
     which  is  the maximal number of messages that can be stored
     into the buffer, and the number N (with N >= 0) of different
     messages (there are N labels corresponding to message inputs
     and N labels  corresponding  to  message  outputs;  see  the
     notions of get-label and put-label below).

     The number of states of a bag buffer is equal to
          (N+P)! / (N! * P!)
     The number of transitions of a bag buffer is equal to
          if N=0 or P=0 then 0 else 2*(N+P-1)!/((N-1)!*(P-1)!)


FFFFIIIIFFFFOOOO BBBBUUUUFFFFFFFFEEEERRRRSSSS
     FIFO buffers (----ffffiiiiffffoooo option) model communication  media  that
     do  not  lose messages and preserve the ordering of messages
     (messages  are  resent  in  the  same  order  as  they  were
     received).

     A FIFO buffer is determined by its size P  (with  P  >=  0),
     which  is  the maximal number of messages that can be stored
     into the buffer, and the number N (with N >= 0) of different
     messages (there are N labels corresponding to message inputs
     and N labels  corresponding  to  message  outputs;  see  the
     notions of get-label and put-label below).

     The number of states of a FIFO buffer is equal to
          sum_{k in 0..P} N^k
     or also
          if N=1 then P+1 else (N^(P+1)-1)/(N-1)
     The number of transitions of a FIFO buffer is equal to
          2 * N * sum_{k in 0..P-1} N^k
     or also
          if N=1 then 2*P else 2*N*(((N^P)-1)/(N-1))






(C) INRIA            Last change: 2014/07/11                    3






CADP MANUAL PAGES                                BCG_GRAPH(LOCAL)



LLLLAAAABBBBEEEELLLL DDDDEEEEFFFFIIIINNNNIIIITTTTIIIIOOOONNNNSSSS
     For some forms of graphs (such as -_c_h_a_o_s), a single list  of
     labels is needed.

     For other forms of graphs (such  as  -_b_a_g  and  -_f_i_f_o),  two
     lists of labels are needed: the get-labels (corresponding to
     input messages) and the put-labels (corresponding to  output
     messages).  There  is a pairwise correspondence between both
     lists, as each put-label emitted corresponds to a  get-label
     received previously.


  AAAA.... LLLLAAAABBBBEEEELLLLSSSS DDDDEEEEFFFFIIIINNNNEEEEDDDD UUUUSSSSIIIINNNNGGGG AAAA FFFFIIIILLLLEEEE
     A _l_a_b_e_l_f_i_l_e contains a list of labels separated with newline
     characters.   Labels  are strings of characters without new-
     line characters.  Labels  can  be  enclosed  between  double
     quotes,  which will be ignored, and may contain spaces.  For
     instance, AAAA, """"BBBB"""", and """"AAAA !!!!1111 !!!!CCCCOOOONNNNSSSS((((3333,,,, 4444))))"""" are  valid  labels.
     In the label definition file, lines that contain only spaces
     (including empty lines) are ignored.  On each line,  leading
     and trailing spaces are ignored, unless they are enclosed in
     quotes.

     For graphs requiring two lists of labels,  the  position  of
     each  label in the file determines whether it is a put-label
     or a get-label. In the  _l_a_b_e_l_f_i_l_e,  pairs  of  corresponding
     labels  alternate strictly. Each get-label occurs on an odd-
     numbered line and is followed by its corresponding put-label
     on  an  even-numbered  line  (empty  lines notwithstanding).
     Therefore, there must be an even number of labels in  _l_a_b_e_l_-
     _f_i_l_e.

     The degenerate case in which  _l_a_b_e_l_f_i_l_e  contains  no  label
     (e.g.,  the  file is empty) is permitted and no warning will
     be issued.


  BBBB.... LLLLAAAABBBBEEEELLLLSSSS DDDDEEEEFFFFIIIINNNNEEEEDDDD UUUUSSSSIIIINNNNGGGG PPPPAAAATTTTTTTTEEEERRRRNNNNSSSS
     A _p_a_t_t_e_r_n is a character string to be  used  as  the  _f_o_r_m_a_t
     argument  of  the  C  function  pppprrrriiiinnnnttttffff(((()))).  It should contain
     exactly one occurrence of "%d" (and no occurrence  of  other
     %-arguments  such  as  "%c", "%f", etc.). If needed, the "%"
     character can be specified as "%%".

     Patterns are used to  generate  labels,  the  "%d"  argument
     being substituted by an integer in the range [1.._n_u_m_b_e_r]. If
     _n_u_m_b_e_r is null, the generated set of labels is empty.

     For graphs requiring two lists of labels,  _p_a_t_t_e_r_n_1  defines
     the  get-labels  and  _p_a_t_t_e_r_n_2  defines the put-labels; each
     put-label is associated with the get-label instantiated with
     the same number.



(C) INRIA            Last change: 2014/07/11                    4






CADP MANUAL PAGES                                BCG_GRAPH(LOCAL)



EEEEXXXXAAAAMMMMPPPPLLLLEEEESSSS
     -    ``bbbbccccgggg____ggggrrrraaaapppphhhh ----ffffiiiiffffoooo 2222 llllaaaabbbbeeeellllffffiiiilllleeee  oooouuuuttttppppuuuutttt....bbbbccccgggg''  will  gen-
          erate  a graph named oooouuuuttttppppuuuutttt....bbbbccccgggg modeling a 2-place FIFO
          buffer whose get- and put-labels are defined in  llllaaaabbbbeeeellll----
          ffffiiiilllleeee.

     -    ``bbbbccccgggg____ggggrrrraaaapppphhhh ----cccchhhhaaaaoooossss ----llllaaaabbbbeeeellllssss 4444  """"AAAA%%%%dddd""""  oooouuuuttttppppuuuutttt....bbbbccccgggg''  will
          generate  a graph named oooouuuuttttppppuuuutttt....bbbbccccgggg consisting of a sin-
          gle state and four transitions labeled AAAA1111 through AAAA4444.

     -    ``bbbbccccgggg____ggggrrrraaaapppphhhh ----bbbbaaaagggg 2222 ----llllaaaabbbbeeeellllssss  3333  """"GGGGEEEETTTT  \\\\!!!!%%%%dddd""""  """"PPPPUUUUTTTT  \\\\!!!!%%%%dddd""""
          oooouuuuttttppppuuuutttt....bbbbccccgggg''  will  generate  a  graph named oooouuuuttttppppuuuutttt....bbbbccccgggg
          modeling a 2-place bag buffer whose  labels  are  named
          GGGGEEEETTTT  !!!!1111,  PPPPUUUUTTTT  !!!!1111,  GGGGEEEETTTT  !!!!2222, PPPPUUUUTTTT !!!!2222, GGGGEEEETTTT !!!!3333, and PPPPUUUUTTTT !!!!3333
          respectively. Note: the "!!!!" characters are escaped with
          backslashes  in  order  to avoid problems with csh/tcsh
          history substitution features.


LLLLIIIIMMMMIIIITTTTAAAATTTTIIIIOOOONNNNSSSS
     bbbbccccgggg____ggggrrrraaaapppphhhh cannot generate graphs with more than 2^32 transi-
     tions  (note that the number of transitions is always larger
     than the number of states).


     Moreover, if the available memory is unsufficient, bbbbccccgggg____ggggrrrraaaapppphhhh
     might  be  unable  to  generate large graphs (even with less
     than 2^32 transitions).


     bbbbccccgggg____ggggrrrraaaapppphhhh does not check if the specified labels  are  pair-
     wise different.


EEEENNNNVVVVIIIIRRRROOOONNNNMMMMEEEENNNNTTTT VVVVAAAARRRRIIIIAAAABBBBLLLLEEEESSSS
     See the bbbbccccgggg(LOCAL) manual page  for  a  description  of  the
     environment variables used by all the BCG application tools.


EEEEXXXXIIIITTTT SSSSTTTTAAAATTTTUUUUSSSS
     Exit status is 0 if everything is alright, 1 otherwise.


AAAAUUUUTTTTHHHHOOOORRRRSSSS
     Frederic Tronel, Frederic Lang, Hubert  Garavel,  and  David
     Champelovier


OOOOPPPPEEEERRRRAAAANNNNDDDDSSSS
     _l_a_b_e_l_f_i_l_e           Label definition file (optional input)
     _o_u_t_p_u_t....bbbbccccgggg          BCG graph (output)




(C) INRIA            Last change: 2014/07/11                    5






CADP MANUAL PAGES                                BCG_GRAPH(LOCAL)



FFFFIIIILLLLEEEESSSS
     $$$$CCCCAAAADDDDPPPP////bbbbiiiinnnn....````aaaarrrrcccchhhh````////bbbbccccgggg____ggggrrrraaaapppphhhh      ``bbbbccccgggg____ggggrrrraaaapppphhhh'' binary program

     See the bbbbccccgggg(LOCAL) manual page  for  a  description  of  the
     other files.


SSSSEEEEEEEE AAAALLLLSSSSOOOO
     bbbbccccgggg(LOCAL), bbbbccccgggg____iiiinnnnffffoooo(LOCAL)

     Additional information is available from the CADP  Web  page
     located at http://cadp.inria.fr

     Directives   for   installation   are   given    in    files
     $$$$CCCCAAAADDDDPPPP////IIIINNNNSSSSTTTTAAAALLLLLLLLAAAATTTTIIIIOOOONNNN____****.

     Recent  changes  and  improvements  to  this  software   are
     reported and commented in file $$$$CCCCAAAADDDDPPPP////HHHHIIIISSSSTTTTOOOORRRRYYYY.


BBBBUUUUGGGGSSSS
     Please report bugs to cadp@inria.fr

































(C) INRIA            Last change: 2014/07/11                    6



