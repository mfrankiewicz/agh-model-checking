


CADP MANUAL PAGES                              DISTRIBUTOR(LOCAL)



NNNNAAAAMMMMEEEE
     distributor  -  state  space  generation  using  distributed
     reachability analysis


SSSSYYYYNNNNOOOOPPPPSSSSIIIISSSS
     bbbbccccgggg____ooooppppeeeennnn   [_b_c_g__o_p_t]   _s_p_e_c[....bbbbccccgggg]    [_c_c__o_p_t]    ddddiiiissssttttrrrriiiibbbbuuuuttttoooorrrr
     [_d_i_s_t_r_i_b_u_t_o_r__o_p_t]      _c_o_n_f_i_g_u_r_a_t_i_o_n[....ggggccccffff]      _r_e_s_u_l_t[....ppppbbbbgggg]
     [_g_l_o_b_a_l__o_p_t] [_i_n_s_t_a_n_c_e__o_p_t]

     or:

     eeeexxxxpppp....ooooppppeeeennnn   [_e_x_p__o_p_t]   _s_p_e_c[....eeeexxxxpppp]    [_c_c__o_p_t]    ddddiiiissssttttrrrriiiibbbbuuuuttttoooorrrr
     [_d_i_s_t_r_i_b_u_t_o_r__o_p_t]      _c_o_n_f_i_g_u_r_a_t_i_o_n[....ggggccccffff]      _r_e_s_u_l_t[....ppppbbbbgggg]
     [_g_l_o_b_a_l__o_p_t] [_i_n_s_t_a_n_c_e__o_p_t]

     or:

     ffffsssspppp....ooooppppeeeennnn   [_f_s_p__o_p_t]   _s_p_e_c[....llllttttssss]    [_c_c__o_p_t]    ddddiiiissssttttrrrriiiibbbbuuuuttttoooorrrr
     [_d_i_s_t_r_i_b_u_t_o_r__o_p_t]      _c_o_n_f_i_g_u_r_a_t_i_o_n[....ggggccccffff]      _r_e_s_u_l_t[....ppppbbbbgggg]
     [_g_l_o_b_a_l__o_p_t] [_i_n_s_t_a_n_c_e__o_p_t]

     or:

     llllnnnntttt....ooooppppeeeennnn   [_l_n_t__o_p_t]   _s_p_e_c[....llllnnnntttt]    [_c_c__o_p_t]    ddddiiiissssttttrrrriiiibbbbuuuuttttoooorrrr
     [_d_i_s_t_r_i_b_u_t_o_r__o_p_t]      _c_o_n_f_i_g_u_r_a_t_i_o_n[....ggggccccffff]      _r_e_s_u_l_t[....ppppbbbbgggg]
     [_g_l_o_b_a_l__o_p_t] [_i_n_s_t_a_n_c_e__o_p_t]

     or:

     lllloooottttoooossss....ooooppppeeeennnn  [_l_o_t_o_s__o_p_t]  _s_p_e_c[....lllloooottttoooossss]  [_c_c__o_p_t]  ddddiiiissssttttrrrriiiibbbbuuuuttttoooorrrr
     [_d_i_s_t_r_i_b_u_t_o_r__o_p_t]      _c_o_n_f_i_g_u_r_a_t_i_o_n[....ggggccccffff]      _r_e_s_u_l_t[....ppppbbbbgggg]
     [_g_l_o_b_a_l__o_p_t] [_i_n_s_t_a_n_c_e__o_p_t]

     or:

     sssseeeeqqqq....ooooppppeeeennnn   [_s_e_q__o_p_t]   _s_p_e_c[....sssseeeeqqqq]    [_c_c__o_p_t]    ddddiiiissssttttrrrriiiibbbbuuuuttttoooorrrr
     [_d_i_s_t_r_i_b_u_t_o_r__o_p_t]      _c_o_n_f_i_g_u_r_a_t_i_o_n[....ggggccccffff]      _r_e_s_u_l_t[....ppppbbbbgggg]
     [_g_l_o_b_a_l__o_p_t] [_i_n_s_t_a_n_c_e__o_p_t]


DDDDEEEESSSSCCCCRRRRIIIIPPPPTTTTIIIIOOOONNNN
     This program performs exhaustive reachability  analysis  and
     generates  the  Labelled  Transition System corresponding to
     the BCG graph _s_p_e_c....bbbbccccgggg, the composition expression _s_p_e_c....eeeexxxxpppp,
     the  FSP  program  _s_p_e_c....llllttttssss,  the  LNT program _s_p_e_c....llllnnnntttt, the
     LOTOS program _s_p_e_c....lllloooottttoooossss, or the SEQ file _s_p_e_c....sssseeeeqqqq.


     Additionally, this program can generate a  reduced  Labelled
     Transition   System  by  applying  tau-compression  or  tau-
     confluence reductions on the fly.



(C) INRIA            Last change: 2020/02/12                    1






CADP MANUAL PAGES                              DISTRIBUTOR(LOCAL)



     Compared to ggggeeeennnneeeerrrraaaattttoooorrrr(LOCAL) and rrrreeeedddduuuuccccttttoooorrrr(LOCAL), which  are
     sequential programs executing on a single machine, ddddiiiissssttttrrrriiiibbbbuuuu----
     ttttoooorrrr  implements  a  distributed  algorithm   (derived   from
     [GMS01])  that  runs  on several machines listed in the grid
     configuration file  _c_o_n_f_i_g_u_r_a_t_i_o_n....ggggccccffff;  see  ggggccccffff(LOCAL)  for
     information  about  the  GCF format. Each machine is used to
     generate and store a part of the Labelled Transition System.
     This  allows  ddddiiiissssttttrrrriiiibbbbuuuuttttoooorrrr to exploit the computing resources
     (memory and processors) provided by many machines.


     The current version of ddddiiiissssttttrrrriiiibbbbuuuuttttoooorrrr  does  not  handle  LOTOS
     programs  containing  dynamic  data  types  (such  as lists,
     trees, etc.) implemented using  pointers,  i.e.,  all  LOTOS
     programs such that the condition
        CAESAR_HASH_SIZE_STATE() < CAESAR_SIZE_STATE()
     is     verified,      where      the      two      functions
     CCCCAAAAEEEESSSSAAAARRRR____HHHHAAAASSSSHHHH____SSSSIIIIZZZZEEEE____SSSSTTTTAAAATTTTEEEE(((()))) and CCCCAAAAEEEESSSSAAAARRRR____SSSSIIIIZZZZEEEE____SSSSTTTTAAAATTTTEEEE(((()))) are defined
     in the ccccaaaaeeeessssaaaarrrr____ggggrrrraaaapppphhhh(LOCAL)  application  programming  inter-
     face.


     All the machines used by ddddiiiissssttttrrrriiiibbbbuuuuttttoooorrrr must have the same pro-
     cessor  and  operating  system; for instance, mixing little-
     endian and big-endian architectures is not allowed.


     As regards the communications between the machines,  ddddiiiissssttttrrrriiii----
     bbbbuuuuttttoooorrrr  does  not  make  strong assumptions and only requires
     standard TCP sockets to be available, together with at least
     one  standard remote connection protocol (such as "rsh/rcp",
     "ssh/scp", "krsh"/"kcp", etc.). In  particular,  ddddiiiissssttttrrrriiiibbbbuuuuttttoooorrrr
     does  not  require  the  existence  of  a common file system
     (e.g., NFS, Samba) shared between the machines.


     The machine on which ddddiiiissssttttrrrriiiibbbbuuuuttttoooorrrr is launched (using the com-
     mand line described in the SYNOPSIS section above) is called
     the _l_o_c_a_l machine. All  other  machines  are  called  _r_e_m_o_t_e
     machines.  Depending  on  the contents of _c_o_n_f_i_g_u_r_a_t_i_o_n....ggggccccffff,
     ddddiiiissssttttrrrriiiibbbbuuuuttttoooorrrr will launch  distributed  processes,  which  are
     called _i_n_s_t_a_n_c_e_s.


     Typically, each instance executes on one remote machine, but
     there  can  be  also several instances per remote machine as
     well as some instances executing on the local machine.


     The generated Labelled Transition System will be stored as a
     partitioned  BCG graph _r_e_s_u_l_t....ppppbbbbgggg; see ppppbbbbgggg(LOCAL) for infor-
     mation about the PBG format.  The  resulting  PBG  file  can



(C) INRIA            Last change: 2020/02/12                    2






CADP MANUAL PAGES                              DISTRIBUTOR(LOCAL)



     later  be  turned into a BCG file using the bbbbccccgggg____mmmmeeeerrrrggggeeee(LOCAL)
     tool.


OOOOPPPPTTTTIIIIOOOONNNNSSSS
     The options _b_c_g__o_p_t, if any, are passed to bbbbccccgggg____lllliiiibbbb(LOCAL).


     The options _e_x_p__o_p_t, if any, are passed to eeeexxxxpppp....ooooppppeeeennnn(LOCAL).


     The options _f_s_p__o_p_t, if any, are passed to ffffsssspppp....ooooppppeeeennnn(LOCAL).


     The options _l_n_t__o_p_t, if any, are passed to llllnnnntttt....ooooppppeeeennnn(LOCAL).


     The options _l_o_t_o_s__o_p_t, if any, are passed  to  ccccaaaaeeeessssaaaarrrr(LOCAL)
     and to ccccaaaaeeeessssaaaarrrr....aaaaddddtttt(LOCAL).


     The options _s_e_q__o_p_t, if any, are passed to sssseeeeqqqq....ooooppppeeeennnn(LOCAL).


     The options _c_c__o_p_t, if any, are passed to the C compiler.


     The following options _d_i_s_t_r_i_b_u_t_o_r__o_p_t are  currently  avail-
     able:


     ----ttttaaaauuuuccccoooommmmpppprrrreeeessssssssiiiioooonnnn
          Perform tau-compression on the  fly,  which  eliminates
          all  cycles  (i.e.,  strongly  connected components) of
          "internal" transitions; such  transitions  are  usually
          noted  "tau" in the scientific literature and displayed
          as the character string "iiii" by the various  BCG  tools.
          This elimination is usually fast (linear in the size of
          the state space) and preserves branching  bisimulation.
          Not a default option.


     ----ttttaaaauuuuccccoooonnnnfffflllluuuueeeennnncccceeee
          Perform tau-confluence on the fly, which is  a  partial
          order  reduction  preserving branching simulation. Tau-
          confluence subsumes tau-compression,  thus  leading  to
          potentially  stronger reductions, but it can be slower.
          Not a default option.


     ----mmmmoooonnnniiiittttoooorrrr
          Open  a  window  for  monitoring   in   real-time   the



(C) INRIA            Last change: 2020/02/12                    3






CADP MANUAL PAGES                              DISTRIBUTOR(LOCAL)



          distributed  generation  of the PBG, i.e., the progress
          status of each instance. The organization of the  moni-
          tor  window is described in section DISTRIBUTED MONITOR
          WINDOW below.  Not a default option.


     ----ddddiiiissssppppllllaaaayyyy _d_i_s_p_l_a_y
          Connect to the X server _d_i_s_p_l_a_y for opening the monitor
          window.  This option is only useful in conjunction with
          the ----mmmmoooonnnniiiittttoooorrrr option.  It overrides the  current  value,
          if  any,  of  the  $$$$DDDDIIIISSSSPPPPLLLLAAAAYYYY environment variable, which
          gives, by default, the X server for opening the monitor
          window.  An  erroneous value for _d_i_s_p_l_a_y may cause ddddiiiissss----
          ttttrrrriiiibbbbuuuuttttoooorrrr to abort. See XXXX(7) for details.  Not a default
          option.


     ----ssssttttaaaatttt
          Display various  statistics  during  graph  generation.
          Not a default option.


OOOOPPPPTTTTIIIIOOOONNNNSSSS AAAAFFFFFFFFEEEECCCCTTTTIIIINNNNGGGG TTTTHHHHEEEE GGGGCCCCFFFF IIIINNNNFFFFOOOORRRRMMMMAAAATTTTIIIIOOOONNNN
     To provide for last-minute changes, the contents of the grid
     configuration  file _c_o_n_f_i_g_u_r_a_t_i_o_n....ggggccccffff can be extended and/or
     modified on the command line using  the  options  _g_l_o_b_a_l__o_p_t
     and _i_n_s_t_a_n_c_e__o_p_t.


     The grid configuration file can even be empty, in which case
     _c_o_n_f_i_g_u_r_a_t_i_o_n....ggggccccffff should be replaced with "-" on the command
     line (in such case _i_n_s_t_a_n_c_e__o_p_t should not be empty).


     _g_l_o_b_a_l__o_p_t  has  the  same  syntax   as   the   non-terminal
     <<<<gggglllloooobbbbaaaallll____oooopppptttt>>>>  in the grammar of the ggggccccffff(LOCAL) format (keep-
     ing in mind that some characters  meaningful  to  the  shell
     must  be escaped or quoted properly). If it is non-empty, it
     is interpreted exactly as if its contents were  inserted  in
     the  grid configuration file, at the end of the <<<<gggglllloooobbbbaaaallll____oooopppptttt>>>>
     list and before the first <<<<iiiinnnnssssttttaaaannnncccceeee____oooopppptttt>>>>.


     _i_n_s_t_a_n_c_e__o_p_t has the same syntax as a possibly empty list of
     non-terminals   <<<<iiiinnnnssssttttaaaannnncccceeee____oooopppptttt>>>>   in   the   grammar  of  the
     ggggccccffff(LOCAL) format (keeping  in  mind  that  some  characters
     meaningful to the shell must be escaped or quoted properly).
     If it is non-empty, it is interpreted exactly as if its con-
     tents  were  appended  at  the end of the grid configuration
     file, after the last <<<<iiiinnnnssssttttaaaannnncccceeee____oooopppptttt>>>>.





(C) INRIA            Last change: 2020/02/12                    4






CADP MANUAL PAGES                              DISTRIBUTOR(LOCAL)



     Thus, the value of the GCF variables can be set in five dif-
     ferent ways, listed below by increasing precedence:


     -    default value,

     -    value given by <<<<gggglllloooobbbbaaaallll____oooopppptttt>>>> in the  grid  configuration
          file,

     -    value given by _g_l_o_b_a_l__o_p_t on the command line,

     -    value given by <<<<iiiinnnnssssttttaaaannnncccceeee____oooopppptttt>>>> in the grid configuration
          file,

     -    value given by _i_n_s_t_a_n_c_e__o_p_t on the command line.


DDDDIIIISSSSTTTTRRRRIIIIBBBBUUUUTTTTEEEEDDDD MMMMOOOONNNNIIIITTTTOOOORRRR WWWWIIIINNNNDDDDOOOOWWWW
     The distributed  monitor  window  started  by  the  ----mmmmoooonnnniiiittttoooorrrr
     option is divided into five tabs:


     -    The "Overview" tab gives, for each instance, the number
          of explored states, the number of remaining states, the
          number of transitions in the  corresponding  BCG  frag-
          ment,  and  the  remaining  state  variation.  Explored
          states are those for which ddddiiiissssttttrrrriiiibbbbuuuuttttoooorrrr has already com-
          puted   the  successors.  Remaining  states  are  those
          visited  by  ddddiiiissssttttrrrriiiibbbbuuuuttttoooorrrr  but  not  explored  yet.  The
          remaining  state variation is represented by a coloured
          box. A green box indicates that the number of remaining
          states is strictly increasing.  An orange box indicates
          that the number of remaining states  is  decreasing  or
          stable.  A red box indicates that the instance has fin-
          ished its computations (i.e., it is idle).  An instance
          which is currently idle may start computations again if
          it receives new messages from another  instance.   When
          all  instances  are idle and there are no more messages
          in transit, the distributed exploration algorithm  ter-
          minates.

          see http://cadp.inria.fr/man/pictures/distributor1.jpg
                  _O_v_e_r_v_i_e_w _t_a_b _o_f _t_h_e _d_i_s_t_r_i_b_u_t_e_d _m_o_n_i_t_o_r


     -    The "Labels" tab displays all different labels  encoun-
          tered   when  firing  transitions  during  state  space
          exploration.

          see http://cadp.inria.fr/man/pictures/distributor2.jpg
                   _L_a_b_e_l_s _t_a_b _o_f _t_h_e _d_i_s_t_r_i_b_u_t_e_d _m_o_n_i_t_o_r




(C) INRIA            Last change: 2020/02/12                    5






CADP MANUAL PAGES                              DISTRIBUTOR(LOCAL)



     -    The "Progress" tab displays, for each instance, a  pro-
          gress  bar indicating the number of states explored for
          this instance.

          see http://cadp.inria.fr/man/pictures/distributor3.jpg
                  _P_r_o_g_r_e_s_s _t_a_b _o_f _t_h_e _d_i_s_t_r_i_b_u_t_e_d _m_o_n_i_t_o_r


     -    The "Statistics" tab gives the total number of  visited
          states, of remaining states, etc.

          see http://cadp.inria.fr/man/pictures/distributor4.jpg
                 _S_t_a_t_i_s_t_i_c_s _t_a_b _o_f _t_h_e _d_i_s_t_r_i_b_u_t_e_d _m_o_n_i_t_o_r


     -    The "Resources" tab estimates, for each  instance,  the
          corresponding memory and CPU usage.

          see http://cadp.inria.fr/man/pictures/distributor5.jpg
                 _R_e_s_o_u_r_c_e_s _t_a_b _o_f _t_h_e _d_i_s_t_r_i_b_u_t_e_d _m_o_n_i_t_o_r


     It is worth keeping in mind that using the distributed moni-
     tor may slow down the state space generation.


EEEEXXXXIIIITTTT SSSSTTTTAAAATTTTUUUUSSSS
     Exit status is 0 if everything is alright, 1 otherwise.


DDDDIIIIAAAAGGGGNNNNOOOOSSSSTTTTIIIICCCCSSSS
     When the source is erroneous,  error  messages  are  issued.
     Additionally, ddddiiiissssttttrrrriiiibbbbuuuuttttoooorrrr leaves "....lllloooogggg" files in the working
     directories on each machine; these  files  may  help  under-
     standing the reason of a problem.


AAAAUUUUTTTTHHHHOOOORRRRSSSS
     Version  1.0  of  ddddiiiissssttttrrrriiiibbbbuuuuttttoooorrrr   was   developed   by   Irina
     Smarandache-Sturm (INRIA/VASY) along the lines of [GMS01].


     Version 2.0 of ddddiiiissssttttrrrriiiibbbbuuuuttttoooorrrr was  developed  by  Adrian  Curic
     (INRIA/VASY) and Gilles Stragier (INRIA/VASY).


     Version 3.0 of ddddiiiissssttttrrrriiiibbbbuuuuttttoooorrrr implements a  modified  algorithm
     by  Christophe  Joubert  (INRIA/VASY). It was rewritten from
     scratch by Nicolas Descoubes (INRIA/VASY). Damien  Bergamini
     (INRIA/VASY) made a few adaptations. Hubert Garavel and Radu
     Mateescu fixed various  issues  and  wrote  the  ddddiiiissssttttrrrriiiibbbbuuuuttttoooorrrr
     manual page.



(C) INRIA            Last change: 2020/02/12                    6






CADP MANUAL PAGES                              DISTRIBUTOR(LOCAL)



OOOOPPPPEEEERRRRAAAANNNNDDDDSSSS
     _s_p_e_c....bbbbccccgggg            BCG graph (input)
     _s_p_e_c....eeeexxxxpppp            network of communicating LTSs (input)
     _s_p_e_c....llllttttssss            FSP specification (input)
     _s_p_e_c....llllnnnntttt            LNT specification (input)
     _s_p_e_c....lllloooottttoooossss          LOTOS specification (input)
     _s_p_e_c....sssseeeeqqqq            SEQ file (input)
     _c_o_n_f_i_g_u_r_a_t_i_o_n....ggggccccffff   grid configuration file (input)
     _r_e_s_u_l_t....ppppbbbbgggg          partitioned BCG graph (output)
     _r_e_s_u_l_t----****....bbbbccccgggg        BCG fragments (outputs)
     ddddiiiissssttttrrrriiiibbbbuuuuttttoooorrrr----****....lllloooogggg   log files (outputs)


FFFFIIIILLLLEEEESSSS
     The   binary   code   of   ddddiiiissssttttrrrriiiibbbbuuuuttttoooorrrr   is   available   in
     $CADP/bin.`arch`/distributor.a


     The code for the distributed monitor window is available  in
     $CADP/src/monitor/distributor.tcl


SSSSEEEEEEEE AAAALLLLSSSSOOOO
     OPEN/CAESAR Reference Manual,  bbbbccccgggg(LOCAL),  bbbbccccgggg____ooooppppeeeennnn(LOCAL),
     bbbbccccgggg____mmmmeeeerrrrggggeeee(LOCAL),      ccccaaaaeeeessssaaaarrrr(LOCAL),     ccccaaaaeeeessssaaaarrrr....aaaaddddtttt(LOCAL),
     eeeexxxxpppp(LOCAL),        eeeexxxxpppp....ooooppppeeeennnn(LOCAL),         ffffsssspppp....ooooppppeeeennnn(LOCAL),
     ggggeeeennnneeeerrrraaaattttoooorrrr(LOCAL),       llllnnnntttt....ooooppppeeeennnn(LOCAL),       lllloooottttoooossss(LOCAL),
     lllloooottttoooossss....ooooppppeeeennnn(LOCAL), ppppbbbbgggg(LOCAL), sssseeeeqqqq(LOCAL), sssseeeeqqqq....ooooppppeeeennnn(LOCAL)


     Additional information is available from the CADP  Web  page
     located at http://cadp.inria.fr

     Directives   for   installation   are   given    in    files
     $$$$CCCCAAAADDDDPPPP////IIIINNNNSSSSTTTTAAAALLLLLLLLAAAATTTTIIIIOOOONNNN____****....

     Recent  changes  and  improvements  to  this  software   are
     reported and commented in file $$$$CCCCAAAADDDDPPPP////HHHHIIIISSSSTTTTOOOORRRRYYYY....


BBBBUUUUGGGGSSSS
     Please report bugs to cadp@inria.fr


BBBBIIIIBBBBLLLLIIIIOOOOGGGGRRRRAAAAPPPPHHHHYYYY
     [GMS01] Hubert Garavel, Radu  Mateescu,  and  Irina  Smaran-
     dache. Parallel State Space Construction for Model-Checking.
     In Matthew B. Dwyer, ed, Proceedings  of  the  8th  Interna-
     tional   SPIN   Workshop   on  Model  Checking  of  Software
     (SPIN'01), Toronto, Canada, LNCS  2057,  pp.   217-234,  May
     2001.  Revised  version  available  as INRIA Research Report
     RR-4341,      December      2001.       Available       from



(C) INRIA            Last change: 2020/02/12                    7






CADP MANUAL PAGES                              DISTRIBUTOR(LOCAL)



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
































(C) INRIA            Last change: 2020/02/12                    8



