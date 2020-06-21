


CADP MANUAL PAGES                                     OCIS(LOCAL)



NNNNAAAAMMMMEEEE
     ocis - Open/Caesar Interactive Simulator


SSSSYYYYNNNNOOOOPPPPSSSSIIIISSSS
     bbbbccccgggg____ooooppppeeeennnn [_b_c_g__o_p_t] _s_p_e_c[....bbbbccccgggg] [_c_c__o_p_t] oooocccciiiissss [_o_c_i_s__o_p_t]

     or:

     eeeexxxxpppp....ooooppppeeeennnn [_e_x_p__o_p_t] _s_p_e_c[....eeeexxxxpppp] [_c_c__o_p_t] oooocccciiiissss [_o_c_i_s__o_p_t]

     or:

     ffffsssspppp....ooooppppeeeennnn [_f_s_p__o_p_t] _s_p_e_c[....llllttttssss] [_c_c__o_p_t] oooocccciiiissss [_o_c_i_s__o_p_t]

     or:

     llllnnnntttt....ooooppppeeeennnn [_l_n_t__o_p_t] _s_p_e_c[....llllnnnntttt] [_c_c__o_p_t] oooocccciiiissss [_o_c_i_s__o_p_t]

     or:

     lllloooottttoooossss....ooooppppeeeennnn [_l_o_t_o_s__o_p_t] _s_p_e_c[....lllloooottttoooossss] [_c_c__o_p_t] oooocccciiiissss [_o_c_i_s__o_p_t]

     or:

     sssseeeeqqqq....ooooppppeeeennnn [_s_e_q__o_p_t] _s_p_e_c[....sssseeeeqqqq] [_c_c__o_p_t] oooocccciiiissss [_o_c_i_s__o_p_t]


DDDDEEEESSSSCCCCRRRRIIIIPPPPTTTTIIIIOOOONNNN
     OCIS (Open/Caesar Interactive Simulator) is an  interactive,
     graphical simulator for the CADP toolset. OCIS enables visu-
     alization and error detection during  the  design  phase  of
     systems  containing  parallelism and asynchronous communica-
     tion between tasks.


     OCIS was designed to be language-independent as much as pos-
     sible  and  should therefore be usable for any specification
     language or formalism interfaced with  the  Open/Caesar  API
     (version  1 or 2). For instance, to be simulated using OCIS,
     a system may be either specified as a BCG graph _s_p_e_c....bbbbccccgggg,  a
     composition  expression _s_p_e_c....eeeexxxxpppp, an FSP program _s_p_e_c....llllttttssss, a
     LNT program _s_p_e_c....llllnnnntttt,  a  LOTOS  program  _s_p_e_c....lllloooottttoooossss,  or  a
     sequence file _s_p_e_c....sssseeeeqqqq.


     The main features of OCIS are:


     -    VVVViiiissssuuuuaaaalllliiiizzzzaaaattttiiiioooonnnn ooooffff ssssiiiimmmmuuuullllaaaattttiiiioooonnnn sssscccceeeennnnaaaarrrriiiioooossss, which are  trees
          describing  the  execution  paths followed by the user.
          Scenarios  can  be  visualized  under  three  different



(C) INRIA            Last change: 2020/02/12                    1






CADP MANUAL PAGES                                     OCIS(LOCAL)



          forms:   execution  traces,  trees,  and  MSC  (_M_e_s_s_a_g_e
          _S_e_q_u_e_n_c_e _C_h_a_r_t_s) diagrams that reflect  the  communica-
          tions between parallel processes (emission/reception of
          messages, rendez-vous, diffusion, etc.)


     -    MMMMaaaannnniiiippppuuuullllaaaattttiiiioooonnnn ooooffff  ssssiiiimmmmuuuullllaaaattttiiiioooonnnn  sssscccceeeennnnaaaarrrriiiioooossss,  which  can  be
          edited,  saved  as  BCG graphs, and loaded again during
          another simulation session.


     -    MMMMaaaannnnuuuuaaaallll ((((sssstttteeeepppp bbbbyyyy sssstttteeeepppp)))) aaaannnndddd aaaauuuuttttoooommmmaaaattttiiiicccc nnnnaaaavvvviiiiggggaaaattttiiiioooonnnn  in  the
          system   under   simulation:  when  several  tasks  are
          involved, the navigation is done  on  the  communicated
          automata describing the whole system. Automatic naviga-
          tion is done in  two  ways.  The  first  way  uses  the
          Open/Caesar tool Exhibitor in order to find one or more
          execution sequences corresponding  to  regular  expres-
          sions  searched by the user. The second way consists in
          re-playing some parts of sequences obtained  in  former
          simulation sessions.


     -    SSSSoooouuuurrrrcccceeee----lllleeeevvvveeeellll ddddeeeebbbbuuuuggggggggiiiinnnngggg: The user can follow the  execu-
          tion  of the source code and the evolution of the state
          variables during simulation. The user can also focus on
          a  particular  parallel task, and on the evolution of a
          subset of the state variables.


     -    PPPPoooossssssssiiiibbbbiiiilllliiiittttyyyy ttttoooo mmmmooooddddiiiiffffyyyy tttthhhheeee ssssoooouuuurrrrcccceeee ccccooooddddeeee and to re-compile
          it  without  quitting  the  current simulation session.
          This is done in a transparent way, by trying to  replay
          the current simulation scenario with the updated system
          obtained after applying the changes in the source  code
          and recompiling.


OOOOPPPPTTTTIIIIOOOONNNNSSSS
     The options _b_c_g__o_p_t, if any, are passed to bbbbccccgggg____lllliiiibbbb(LOCAL).


     The options _e_x_p__o_p_t, if any, are passed to eeeexxxxpppp....ooooppppeeeennnn(LOCAL).


     The options _f_s_p__o_p_t, if any, are passed to ffffsssspppp....ooooppppeeeennnn(LOCAL).


     The options _l_n_t__o_p_t, if any, are passed to llllnnnntttt....ooooppppeeeennnn(LOCAL).






(C) INRIA            Last change: 2020/02/12                    2






CADP MANUAL PAGES                                     OCIS(LOCAL)



     The options _l_o_t_o_s__o_p_t, if any, are passed  to  ccccaaaaeeeessssaaaarrrr(LOCAL)
     and to ccccaaaaeeeessssaaaarrrr....aaaaddddtttt(LOCAL).


     The options _s_e_q__o_p_t, if any, are passed to sssseeeeqqqq....ooooppppeeeennnn(LOCAL).


     The options _c_c__o_p_t, if any, are passed to the C compiler.

     The following options _o_c_i_s__o_p_t are currently available:


     ----ttttttttyyyy Launch OCIS in non-graphical mode.


GGGGEEEENNNNEEEERRRRAAAALLLL OOOOVVVVEEEERRRRVVVVIIIIEEEEWWWW OOOOFFFF TTTTHHHHEEEE GGGGRRRRAAAAPPPPHHHHIIIICCCCAAAALLLL UUUUSSSSEEEERRRR----IIIINNNNTTTTEEEERRRRFFFFAAAACCCCEEEE
     The main window of OCIS is divided as follows (from  top  to
     bottom):


     -    On top, the MMMMeeeennnnuuuu (see description below)


     -    Just below, the MMMMeeeennnnuuuu bbbbaaaarrrr


     -    Then, the HHHHiiiissssttttoooorrrryyyy ssssuuuubbbb wwwwiiiinnnnddddoooowwww (see description below)


     -    The TTTTrrrraaaannnnssssiiiittttiiiioooonnnn ssssuuuubbbb----wwwwiiiinnnnddddoooowwww (see description below)


     -    On bottom, the OOOOnnnn----lllliiiinnnneeee hhhheeeellllpppp bbbbaaaarrrr


     Navigation through the entries of this menu may be  done  by
     using  the  mouse  or  using  "tab"  and the "space key" for
     selecting the button.

           see http://cadp.inria.fr/man/pictures/ocis1.jpg
                       _M_a_i_n _w_i_n_d_o_w _o_f _O_C_I_S


VVVVIIIIEEEEWWWWSSSS
  HHHHIIIISSSSTTTTOOOORRRRYYYY SSSSUUUUBBBB----WWWWIIIINNNNDDDDOOOOWWWW
     It is the upper part of the OCIS window.  It is dedicated to
     the  visualization  of  the scenario being simulated.  There
     are three visualization modes: the MSC view, the TEXT  view,
     and  the TREE view. Each of these views is activated through
     a thumbnail-index.





(C) INRIA            Last change: 2020/02/12                    3






CADP MANUAL PAGES                                     OCIS(LOCAL)



     -    MMMMSSSSCCCC vvvviiiieeeewwww: This visualization mode  shows  the  interac-
          tions between processes. Each task is shown as a verti-
          cal line. Each transition  is  shown  as  a  horizontal
          line.  If  a process synchronizes on this transition, a
          circle is shown at the intersection  of  the  2  lines.
          When  a  task  changes  its process, it is shown on the
          vertical line of this task, and the name of the process
          is displayed.


     -    TTTTEEEEXXXXTTTT vvvviiiieeeewwww: Display the current path as  a  sequence  of
          labels.


     -    TTTTRRRREEEEEEEE vvvviiiieeeewwww: Display the whole scenario as a  tree.  Each
          branch  in  the  tree represents a sequence of explored
          transitions in the automaton of the  simulated  system.
          In particular, the repetitive exploration of a cycle in
          this automaton results in  a  sequence  of  transitions
          which length is a multiple of the length of the cycle.


     MMMMoooouuuusssseeee iiiinnnntttteeeerrrraaaaccccttttiiiioooonnnnssss: In each of the three views, clicking  on
     a transition with the left button of the mouse permits to go
     back to this transition. In both TEXT and MSC views,  click-
     ing  on the right button of the mouse will popup a menu giv-
     ing information and source capabilities.

           see http://cadp.inria.fr/man/pictures/ocis2.jpg
                          _T_h_e _M_S_C _v_i_e_w

           see http://cadp.inria.fr/man/pictures/ocis3.jpg
                          _T_h_e _T_E_X_T _v_i_e_w

           see http://cadp.inria.fr/man/pictures/ocis4.jpg
                          _T_h_e _T_R_E_E _v_i_e_w


  TTTTRRRRAAAANNNNSSSSIIIITTTTIIIIOOOONNNN SSSSUUUUBBBB----WWWWIIIINNNNDDDDOOOOWWWW
     It is the lower part of the OCIS  window.  It  displays  the
     list  of  transitions  that  can  be  fired from the current
     state.  There are two visualization modes: the MSC view, and
     the TEXT view.


     -    MMMMSSSSCCCC vvvviiiieeeewwww: Display the list of the transitions that  can
          be fired from the current state as an MSC diagram.


     -    TTTTEEEEXXXXTTTT vvvviiiieeeewwww: Display the list of labels  of  the  transi-
          tions that can be fired from the current state.




(C) INRIA            Last change: 2020/02/12                    4






CADP MANUAL PAGES                                     OCIS(LOCAL)



     MMMMoooouuuusssseeee iiiinnnntttteeeerrrraaaaccccttttiiiioooonnnnssss: In both MSC and TEXT views, clicking  on
     a  transition  with  the left button of the mouse permits to
     put this transition in the history window (i.e.  follow  the
     transition).  Clicking on the right button of the mouse will
     popup a menu giving information and source capabilities.


MMMMEEEENNNNUUUUSSSS
           see http://cadp.inria.fr/man/pictures/ocis5.jpg
                    _T_h_e _m_e_n_u _a_n_d _b_u_t_t_o_n_s _b_a_r_s


     The following subsections describe each menu entry of OCIS.


  FFFFIIIILLLLEEEE
     -    RRRReeeesssseeeetttt: Clear the current scenario.


     -    NNNNeeeewwww:  Clear  the  current  scenario  and  open  a   new
          scenario.


     -    LLLLooooaaaadddd: Select and load an existing  simulation  scenario
          (....bbbbccccgggg file).


     -    SSSSaaaavvvveeee aaaassss: Select a name for  the  current  scenario  and
          save it.


     -    SSSSaaaavvvveeee: Save the current scenario (without  changing  the
          name,  by  default  uuuunnnnttttiiiittttlllleeeedddd....bbbbccccgggg).  Scenario  files are
          saved in the BCG file  format,  see  bbbbccccgggg(LOCAL).   Many
          other  tools  of the CADP toolkit can read the BCG file
          format. For instance, the program bbbbccccgggg____ddddrrrraaaawwww(LOCAL)  will
          draw  the tree of scenarios. Each label of the BCG tree
          contains 2 parts separated by a "#" symbol:  the  first
          is  a  list  of internal values for OCIS, the second is
          the labelled transition.



     -    SSSSaaaavvvveeee sssseeeeqqqquuuueeeennnncccceeee ttttrrrreeeeeeee: Select a file name (with  extension
          ....bbbbccccgggg) for the sub-tree of the current scenario (defined
          by the path starting at the initial state and ending at
          the  current state, and the sub-tree going out from the
          current state) and save it (in the BCG file format, see
          bbbbccccgggg(local) ).


     -    SSSSaaaavvvveeee aaaa sssseeeeqqqquuuueeeennnncccceeee ooooffff llllaaaabbbbeeeellllssss: Select  a  file  name  (with



(C) INRIA            Last change: 2020/02/12                    5






CADP MANUAL PAGES                                     OCIS(LOCAL)



          extension


     ----    PPPPrrrreeeevvvviiiieeeewwww PPPPoooossssttttSSSSccccrrrriiiipppptttt:  Show  a  preview  of  the  current
          scenario  (all  or  part  of it) in PostScript. Use the
          viewer   defined   by    the    environment    variable
          CCCCAAAADDDDPPPP____PPPPSSSS____VVVVIIIIEEEEWWWWEEEERRRR.

              see http://cadp.inria.fr/man/pictures/ocis6.jpg
          _T_h_e _p_r_i_n_t_i_n_g, _d_i_s_p_l_a_y, _a_n_d _P_o_s_t_S_c_r_i_p_t _g_e_n_e_r_a_t_i_o_n _s_e_l_e_c_t_o_r_s


     -    PPPPrrrriiiinnnntttt PPPPoooossssttttSSSSccccrrrriiiipppptttt: Print the current  scenario  (all  or
          part of it).


     -    SSSSaaaavvvveeee PPPPoooossssttttSSSSccccrrrriiiipppptttt: Save the current scenario (all or part
          of it) in the PostScript format.


     -    QQQQuuuuiiiitttt: Exit OCIS after verification of the status of the
          current  scenario.  If  the  scenario changed since the
          last saving, propose the user to save it  before  quit-
          ting.


  EEEEDDDDIIIITTTT
     -    SSSSeeeelllleeeecccctttt ccccuuuurrrrrrrreeeennnntttt ttttrrrraaaannnnssssiiiittttiiiioooonnnn ((((TTTTrrrreeeeeeee vvvviiiieeeewwww oooonnnnllllyyyy)))): Select  the
          current transition and highlight it.


          NNNNoooottttiiiicccceeee: Effective only in the Tree view.  This  command
          is  bound  to a click on the right button of the mouse,
          or to a click on the left button  of  the  mouse  while
          hitting the Shift key.


     -    SSSSeeeelllleeeecccctttt ssssppppeeeecccciiiiffffiiiicccc ttttrrrraaaannnnssssiiiittttiiiioooonnnnssss ((((TTTTrrrreeeeeeee vvvviiiieeeewwww  oooonnnnllllyyyy)))):  Open  a
          selection  menu  for  choosing  a  specific label to be
          searched and selected. The search can  start  from  the
          initial  or  the  current state. The number of selected
          transitions is given as a result in this selection win-
          dow.


          NNNNoooottttiiiicccceeee: Effective only in the Tree view.


     -    DDDDiiiissssaaaabbbblllleeee sssseeeelllleeeeccccttttiiiioooonnnn: Disable all the selected transitions
          and unhighlight them.





(C) INRIA            Last change: 2020/02/12                    6






CADP MANUAL PAGES                                     OCIS(LOCAL)



          NNNNoooottttiiiicccceeee: Effective only in the Tree view.


     -    CCCClllloooosssseeee sssseeeelllleeeecccctttteeeedddd ttttrrrraaaannnnssssiiiittttiiiioooonnnnssss: Close the selected  transi-
          tions which are visible in the Tree view.


          NNNNoooottttiiiicccceeee: Effective only in  the  Tree  view.  When  many
          transitions  are  selected  on  the same path, only the
          closest transition to the initial state is closed.


     -    OOOOppppeeeennnn sssseeeelllleeeecccctttteeeedddd ttttrrrraaaannnnssssiiiittttiiiioooonnnnssss: Open  the  selected  transi-
          tions which are invisible in the Tree view.


          NNNNoooottttiiiicccceeee: Effective only in the Tree view. All the closed
          selected transitions are open.


     -    CCCCuuuutttt sssseeeelllleeeecccctttteeeedddd ttttrrrraaaannnnssssiiiittttiiiioooonnnnssss: Cut the selected  transitions
          and  the  sub-trees  going out from them. The parent of
          the last cut selected transition  becomes  the  current
          transition.  (Information  on fireable transitions from
          this new transition is updated.)


     -    CCCCuuuutttt ccccuuuurrrrrrrreeeennnntttt ttttrrrraaaannnnssssiiiittttiiiioooonnnn: Cut the current transition  and
          the  sub-tree  going out from it. The parent transition
          of the cut one becomes the current transition.  (Infor-
          mation  on fireable transition from this new transition
          is updated).


     -    CCCCuuuutttt ddddoooowwwwnnnn ttttrrrreeeeeeee ooooffff ccccuuuurrrrrrrreeeennnntttt ttttrrrraaaannnnssssiiiittttiiiioooonnnn: Cut only the  sub-
          tree  going  out from the current transition. (Informa-
          tion on fireable transitions from this  new  transition
          is updated.)


     -    FFFFiiiinnnndddd rrrreeeegggguuuullllaaaarrrr eeeexxxxpppprrrreeeessssssssiiiioooonnnnssss: Popup an interface to  select
          options   and   ....sssseeeeqqqq   sequences   for   launching  the
          eeeexxxxhhhhiiiibbbbiiiittttoooorrrr(LOCAL) tool.

              see http://cadp.inria.fr/man/pictures/ocis7.jpg
                  _T_h_e _O_p_e_n/_C_a_e_s_a_r _E_x_h_i_b_i_t_o_r _s_e_l_e_c_t_o_r



  MMMMOOOOTTTTIIIIOOOONNNN
     -    BBBBaaaacccckkkkwwwwaaaarrrrdddd: Move backward  to  the  state  preceding  the
          current state.



(C) INRIA            Last change: 2020/02/12                    7






CADP MANUAL PAGES                                     OCIS(LOCAL)



     -    FFFFoooorrrrwwwwaaaarrrrdddd: Move forward to the last state  following  the
          current state.


     -    SSSShhhhoooowwww ccccuuuurrrrrrrreeeennnntttt ttttrrrraaaannnnssssiiiittttiiiioooonnnn: Make current transition  visi-
          ble.


     -    SSSShhhhoooowwww ttttoooopppp: Make the initial state visible.


  WWWWIIIINNNNDDDDOOOOWWWW
     -    EEEEddddiiiitttt ssssoooouuuurrrrcccceeee ffffiiiilllleeee: Select a file and edit it  using  the
          text  editor specified by the environment variable EEEEDDDDIIII----
          TTTTOOOORRRR.


     -    VVVViiiieeeewwwwiiiinnnngggg ssssoooouuuurrrrcccceeee ccccooooddddeeee: Display the  source  code  of  the
          current  specification and show the trace of the execu-
          tion by highlighting the code corresponding  to  firing
          the  current  transition.  The values of internal vari-
          ables are also displayed.


          NNNNoooottttiiiicccceeee: In the source window, the source line  concern-
          ing  the  selected  transition  is  highlighted and any
          variable name appearing on the line is left  clickable:
          by  clicking on it, the type and the value of the vari-
          able are displayed.  Each task is selectable separately
          by  clicking  on  the  visual tab on top of the window.
          The "Edit..." button allows to edit the file using  the
          text  editor specified by the environment variable EEEEDDDDIIII----
          TTTTOOOORRRR.


     -    RRRReeeeccccoooommmmppppiiiilllleeee: Open a window for  launching  re-compilation
          of the current specification with the Caesar compiler.


     -    OOOOppppeeeennnn sssshhhheeeellllllll wwwwiiiinnnnddddoooowwww: Open a  terminal  window  running  a
          shell interpreter.

              see http://cadp.inria.fr/man/pictures/ocis8.jpg
                 _T_h_e _s_o_u_r_c_e _c_o_d_e _v_i_s_u_a_l_i_z_a_t_i_o_n _w_i_n_d_o_w

              see http://cadp.inria.fr/man/pictures/ocis9.jpg
                _T_h_e _s_o_u_r_c_e _c_o_d_e _r_e-_c_o_m_p_i_l_a_t_i_o_n _w_i_n_d_o_w


  OOOOPPPPTTTTIIIIOOOONNNNSSSS
     -    AAAAuuuuttttoooo aaaaddddvvvvaaaannnncccceeee mmmmooooddddeeee: Expand  automatically  the  scenario
          each  time  a  single  transition can be fired from the



(C) INRIA            Last change: 2020/02/12                    8






CADP MANUAL PAGES                                     OCIS(LOCAL)



          current state.


     -    LLLLooooooooppppbbbbaaaacccckkkk cccchhhheeeecccckkkkiiiinnnngggg: Show loopback transitions.


          CCCCaaaauuuuttttiiiioooonnnn: This option may significantly  slow  down  the
          simulator when activated.


     -    EEEExxxxtttteeeennnnddddeeeedddd MMMMSSSSCCCC ffffoooorrrrmmmmaaaatttt: Display further information on the
          tasks involved in a given transition. (Effective on MSC
          view.)


     -    MMMMaaaakkkkeeee wwwwiiiinnnnddddoooowwwwssss ffffoooorrrreeeeggggrrrroooouuuunnnndddd: Raise automatically  to  fore-
          ground the window on which the mouse is located.


     -    SSSSaaaavvvveeee pppprrrreeeeffffeeeerrrreeeennnncccceeeessss iiiinnnn ccccuuuurrrrrrrreeeennnntttt ddddiiiirrrreeeeccccttttoooorrrryyyy: Save preferences
          in the ....oooocccciiiissssrrrrcccc file located in the directory where OCIS
          has been launched. This  file  is  read  when  OCIS  is
          launched.  If  this  file does not exist, OCIS searches
          instead for file $$$$HHHHOOOOMMMMEEEE////....ccccoooonnnnffffiiiigggg////ccccaaaaddddpppp////oooocccciiiissssrrrrcccc,  where  the
          environment  variable  $$$$HHHHOOOOMMMMEEEE  refers to the home direc-
          tory. If both files do not exist, OCIS uses  its  stan-
          dard preferences.


     -    SSSSaaaavvvveeee pppprrrreeeeffffeeeerrrreeeennnncccceeeessss iiiinnnn hhhhoooommmmeeee ddddiiiirrrreeeeccccttttoooorrrryyyy: Save preferences in
          file   $$$$HHHHOOOOMMMMEEEE////....ccccoooonnnnffffiiiigggg////ccccaaaaddddpppp////oooocccciiiissssrrrrcccc,  so  that  the  saved
          preferences can be reused in other simulation sessions.


     -    RRRReeeesssseeeetttt pppprrrreeeeffffeeeerrrreeeennnncccceeeessss: Erase the ....oooocccciiiissssrrrrcccc  file  located  in
          the current directory.


  HHHHEEEELLLLPPPP
     -    IIIInnnnddddeeeexxxx: Open a navigator providing  indexed  information
          about OCIS.


     -    AAAAbbbboooouuuutttt OOOOCCCCIIIISSSS: Show version and copyright information.


OOOOPPPPEEEERRRRAAAANNNNDDDDSSSS
     _s_p_e_c....bbbbccccgggg            BCG graph (input)
     _s_p_e_c....eeeexxxxpppp            network of communicating LTSs (input)
     _s_p_e_c....llllttttssss            FSP specification (input)
     _s_p_e_c....llllnnnntttt            LNT specification (input)
     _s_p_e_c....lllloooottttoooossss          LOTOS specification (input)



(C) INRIA            Last change: 2020/02/12                    9






CADP MANUAL PAGES                                     OCIS(LOCAL)



     _s_p_e_c....sssseeeeqqqq            sequence file (input)
     *._b_c_g               scenario    files    in    BCG    format
                         (input/output)
     *._p_s                PostScript files for printer (output)


FFFFIIIILLLLEEEESSSS
     The  binary  code  of  this  tool  is  available   in   file
     $$$$CCCCAAAADDDDPPPP////bbbbiiiinnnn....````aaaarrrrcccchhhh````////oooocccciiiissss....aaaa


     Auxiliary files are located in directory $$$$CCCCAAAADDDDPPPP////ssssrrrrcccc////oooocccciiiissss


AAAAUUUUTTTTHHHHOOOORRRRSSSS
     Ordered alphabetically:  Moez Cherif, Hubert Garavel,  Bruno
     Hondelatte, Pierre-Alexandre Kessler, Frederic Perret.


     Ocis benefited from the suggestions  of  Radu  Mateescu  and
     Nicolas Zuanon.


SSSSEEEEEEEE AAAALLLLSSSSOOOO
     OPEN/CAESAR Reference Manual,  bbbbccccgggg(LOCAL),  bbbbccccgggg____ooooppppeeeennnn(LOCAL),
     ccccaaaaeeeessssaaaarrrr(LOCAL),         ccccaaaaeeeessssaaaarrrr....aaaaddddtttt(LOCAL),        eeeexxxxpppp(LOCAL),
     eeeexxxxpppp....ooooppppeeeennnn(LOCAL),      ffffsssspppp....ooooppppeeeennnn(LOCAL),      llllnnnntttt....ooooppppeeeennnn(LOCAL),
     lllloooottttoooossss(LOCAL), lllloooottttoooossss....ooooppppeeeennnn(LOCAL), sssseeeeqqqq(LOCAL), sssseeeeqqqq....ooooppppeeeennnn(LOCAL)


     Additional information is available from the CADP  Web  page
     located at http://cadp.inria.fr

     Directives   for   installation   are   given    in    files
     $$$$CCCCAAAADDDDPPPP////IIIINNNNSSSSTTTTAAAALLLLLLLLAAAATTTTIIIIOOOONNNN____****.

     Recent  changes  and  improvements  to  this  software   are
     reported and commented in file $$$$CCCCAAAADDDDPPPP////HHHHIIIISSSSTTTTOOOORRRRYYYY.


BBBBUUUUGGGGSSSS
     Please report bugs to Hubert.Garavel@inria.fr













(C) INRIA            Last change: 2020/02/12                   10



