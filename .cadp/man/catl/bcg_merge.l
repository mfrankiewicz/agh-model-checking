


CADP MANUAL PAGES                                BCG_MERGE(LOCAL)



NNNNAAAAMMMMEEEE
     bcg_merge - translation of a partitioned BCG graph into  one
     single BCG graph


SSSSYYYYNNNNOOOOPPPPSSSSIIIISSSS
     bbbbccccgggg____mmmmeeeerrrrggggeeee [_o_p_t_i_o_n_s] _i_n_p_u_t[[[[....ppppbbbbgggg]]]] [_o_u_t_p_u_t[....bbbbccccgggg]]  [_g_l_o_b_a_l__o_p_t]
     [_i_n_s_t_a_n_c_e__o_p_t]


DDDDEEEESSSSCCCCRRRRIIIIPPPPTTTTIIIIOOOONNNN
     bbbbccccgggg____mmmmeeeerrrrggggeeee is usually invoked  after  the  ddddiiiissssttttrrrriiiibbbbuuuuttttoooorrrr(LOCAL)
     tool of CCCCAAAADDDDPPPP for distributed state-space generation.


     bbbbccccgggg____mmmmeeeerrrrggggeeee  takes  as   input   a   partitioned   BCG   graph
     _i_n_p_u_t[[[[....ppppbbbbgggg]]]],,,,  usually  produced  by  ddddiiiissssttttrrrriiiibbbbuuuuttttoooorrrr(LOCAL)  and
     encoded in the PBG format (see the  ppppbbbbgggg(LOCAL)  manual  page
     for  details  about the PBG format), and produces one single
     BCG file _o_u_t_p_u_t[[[[....bbbbccccgggg]]]] that combines the various graph  frag-
     ments listed in _i_n_p_u_t[[[[....ppppbbbbgggg]]]]....


     If _o_u_t_p_u_t[[[[....bbbbccccgggg]]]] is not specified on the  command  line,  the
     output file will be named _i_n_p_u_t....bbbbccccgggg.


     These graph fragments are themselves encoded  as  BCG  files
     and usually located on different machines. The list of these
     machines is given in a  grid  configuration  file  (see  the
     ggggccccffff(LOCAL)  manual  page  for  details about the GCF format)
     referenced in _i_n_p_u_t[[[[....ppppbbbbgggg]]]]....


     bbbbccccgggg____mmmmeeeerrrrggggeeee renumbers the states contained in  the  BCG  files
     listed  in the input PBG file, in such a way that the states
     of the output BCG file are assigned contiguous  numbers  and
     that the initial state is assigned number 0.


OOOOPPPPTTTTIIIIOOOONNNNSSSS
     The following _o_p_t_i_o_n_s are currently supported:


     ----ccccoooommmmpppprrrreeeessssssss,,,, ----rrrreeeeggggiiiisssstttteeeerrrr,,,, ----sssshhhhoooorrrrtttt,,,, ----mmmmeeeeddddiiiiuuuummmm,,,, ----ssssiiiizzzzeeee,,,, ----uuuunnnnccccoooommmmpppprrrreeeessssssss
          These options control the  form  under  which  the  BCG
          graph  _o_u_t_p_u_t....bbbbccccgggg  is  generated.  See  the  bbbbccccgggg(LOCAL)
          manual page for a description of these options.


     -cccclllleeeeaaaannnn
          After generating the output BCG file, erase  the  input



(C) INRIA            Last change: 2018/05/17                    1






CADP MANUAL PAGES                                BCG_MERGE(LOCAL)



          PBG  file  together  with  its  BCG graph fragments and
          their  corresponding  BCG  dynamic  libraries.   Not  a
          default option.


     -ffffaaaasssstttt
          When building _o_u_t_p_u_t[[[[....bbbbccccgggg]]]],,,, sort, by increasing  source
          state  numbers  only,  the transitions belonging to the
          file fragments listed in _i_n_p_u_t[[[[....ppppbbbbgggg]]]]....  This is a faster
          sort than the default one, which sorts transitions lex-
          icographically, by  increasing  source  state  numbers,
          then  by increasing target state numbers; however, this
          faster sort may generate a larger  BCG  file  than  the
          lexicographic sort. Not a default option.


     -mmmmoooonnnniiiittttoooorrrr
          Open a window for monitoring in real-time  the  genera-
          tion of the BCG file _o_u_t_p_u_t....bbbbccccgggg. Not a default option.


     -ppppaaaarrrrsssseeee |||| ----uuuunnnnppppaaaarrrrsssseeee
          These options can be used to control label  parsing  in
          the  output  BCG graph (see the bbbbccccgggg____wwwwrrrriiiitttteeee(LOCAL) manual
          page for a technical discussion about  label  parsing).
          By default, or if option ----ppppaaaarrrrsssseeee is present, label pars-
          ing is enabled.  If option ----uuuunnnnppppaaaarrrrsssseeee is  present,  label
          parsing is disabled.


     -ssssttttaaaatttt
          Display various statistics obtained during graph  merg-
          ing,  such as the number of cross-border transitions in
          the partitioned BCG graph, and the network traffic with
          the remote machines. Not a default option.


     ----ttttmmmmpppp This option specifies the directory in which  temporary
          files  are to be stored. See the bbbbccccgggg(LOCAL) manual page
          for a description of this option.


     Finally, the list of options _g_l_o_b_a_l__o_p_t and _i_n_s_t_a_n_c_e__o_p_t can
     be  used for last-minute changes to the settings of the grid
     configuration  file  referenced  in  _i_n_p_u_t[[[[....ppppbbbbgggg]]]]....   See  the
     ddddiiiissssttttrrrriiiibbbbuuuuttttoooorrrr(LOCAL)  manual  page  for a description of these
     options.


EEEENNNNVVVVIIIIRRRROOOONNNNMMMMEEEENNNNTTTT VVVVAAAARRRRIIIIAAAABBBBLLLLEEEESSSS
     See the bbbbccccgggg(LOCAL) manual page  for  a  description  of  the
     environment variables used by all BCG application tools.



(C) INRIA            Last change: 2018/05/17                    2






CADP MANUAL PAGES                                BCG_MERGE(LOCAL)



EEEEXXXXIIIITTTT SSSSTTTTAAAATTTTUUUUSSSS
     Exit status is 0 if everything is alright, 1 otherwise.


AAAAUUUUTTTTHHHHOOOORRRRSSSS
     Version  1.0   of   bbbbccccgggg____mmmmeeeerrrrggggeeee   was   developed   by   Irina
     Smarandache-Sturm (INRIA/VASY) in 2000.

     Version 2.0 of bbbbccccgggg____mmmmeeeerrrrggggeeee  was  developed  by  Radu  Mateescu
     (INRIA/VASY) in 2001.

     Version 3.0 of bbbbccccgggg____mmmmeeeerrrrggggeeee was developed by Nicolas  Descoubes
     (INRIA/VASY)  in  2003, then revised by Damien Bergamini and
     Hubert Garavel (both at INRIA/VASY) in 2004.


OOOOPPPPEEEERRRRAAAANNNNDDDDSSSS
     _i_n_p_u_t....ppppbbbbgggg     partitioned BCG graph (input)
     _o_u_t_p_u_t....bbbbccccgggg    resulting BCG file after merging (output)


FFFFIIIILLLLEEEESSSS
     The   binary   code   of   bbbbccccgggg____mmmmeeeerrrrggggeeee   is    available    in
     $CADP/bin.`arch`/bcg_merge.


     During  the  execution  of  bbbbccccgggg____mmmmeeeerrrrggggeeee,   dynamic   libraries
     corresponding  to  the BCG files (i.e., the graph fragments)
     listed in the input PBG file may be generated if  necessary,
     and stored on the remote machines.


SSSSEEEEEEEE AAAALLLLSSSSOOOO
     bbbbccccgggg(LOCAL),  ggggccccffff(LOCAL),   ppppbbbbgggg(LOCAL),   ddddiiiissssttttrrrriiiibbbbuuuuttttoooorrrr(LOCAL),
     ppppbbbbgggg____ccccpppp(LOCAL), ppppbbbbgggg____iiiinnnnffffoooo(LOCAL), ppppbbbbgggg____mmmmvvvv(LOCAL), ppppbbbbgggg____rrrrmmmm(LOCAL)


     Additional information is available from the CADP  Web  page
     located at http://cadp.inria.fr

     Directives   for   installation   are   given    in    files
     $$$$CCCCAAAADDDDPPPP////IIIINNNNSSSSTTTTAAAALLLLLLLLAAAATTTTIIIIOOOONNNN____****....

     Recent  changes  and  improvements  to  this  software   are
     reported and commented in file $$$$CCCCAAAADDDDPPPP////HHHHIIIISSSSTTTTOOOORRRRYYYY....


BBBBUUUUGGGGSSSS
     Please report bugs to cadp@inria.fr






(C) INRIA            Last change: 2018/05/17                    3






CADP MANUAL PAGES                                BCG_MERGE(LOCAL)



BBBBIIIIBBBBLLLLIIIIOOOOGGGGRRRRAAAAPPPPHHHHYYYY
     [GMS01] Hubert Garavel, Radu  Mateescu,  and  Irina  Smaran-
     dache.    Parallel   State  Space  Construction  for  Model-
     Checking.  In Matthew B. Dwyer, ed, Proceedings of  the  8th
     International  SPIN  Workshop  on Model Checking of Software
     (SPIN'01), Toronto, Canada, LNCS  2057,  pp.   217-234,  May
     2001.  Revised  version  available  as INRIA Research Report
     RR-4341,      December      2001.       Available       from
     http://cadp.inria.fr/publications/Garavel-Mateescu-
     Smarandache-01.html


     [GMB+06] Hubert Garavel, Radu  Mateescu,  Damien  Bergamini,
     Adrian  Curic,  Nicolas Descoubes, Christophe Joubert, Irina
     Smarandache-Sturm, and  Gilles  Stragier.   DISTRIBUTOR  and
     BCG_MERGE:  Tools  for Distributed Explicit State Space Gen-
     eration.   In  Holger  Hermanns  and  Jens  Palberg,   eds.,
     Proceedings  of  the  12th International Conference on Tools
     and Algorithms for the Construction and Analysis of  Systems
     (TACAS'06),  Vienna, Austria, LNCS 3920, pp. 445-449, March-
     April            2006.            Available             from
     http://cadp.inria.fr/publications/Garavel-Mateescu-
     Bergamini-et-al-06.html


     [GMS12] Hubert Garavel, Radu Mateescu, and  Wendelin  Serwe.
     Large-scale  Distributed  Verification  using  CADP:  Beyond
     Clusters to Grids.  Electronic Notes in Theoretical Computer
     Science,  vol. 296, pp. 145-161, August 2012. Available from
     http://cadp.inria.fr/publications/Garavel-Mateescu-Serwe-
     12.html
























(C) INRIA            Last change: 2018/05/17                    4



