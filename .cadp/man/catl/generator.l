


CADP MANUAL PAGES                                GENERATOR(LOCAL)



NNNNAAAAMMMMEEEE
     generator - BCG graph generation using reachability analysis


SSSSYYYYNNNNOOOOPPPPSSSSIIIISSSS
     bbbbccccgggg____ooooppppeeeennnn    [_b_c_g__o_p_t]    _s_p_e_c[....bbbbccccgggg]    [_c_c__o_p_t]    ggggeeeennnneeeerrrraaaattttoooorrrr
     [_g_e_n_e_r_a_t_o_r__o_p_t] _r_e_s_u_l_t[....bbbbccccgggg]

     or:

     eeeexxxxpppp....ooooppppeeeennnn    [_e_x_p__o_p_t]    _s_p_e_c[....eeeexxxxpppp]    [_c_c__o_p_t]    ggggeeeennnneeeerrrraaaattttoooorrrr
     [_g_e_n_e_r_a_t_o_r__o_p_t] _r_e_s_u_l_t[....bbbbccccgggg]

     or:

     ffffsssspppp....ooooppppeeeennnn    [_f_s_p__o_p_t]    _s_p_e_c[....llllttttssss]    [_c_c__o_p_t]    ggggeeeennnneeeerrrraaaattttoooorrrr
     [_g_e_n_e_r_a_t_o_r__o_p_t] _r_e_s_u_l_t[....bbbbccccgggg]

     or:

     llllnnnntttt....ooooppppeeeennnn    [_l_n_t__o_p_t]    _s_p_e_c[....llllnnnntttt]    [_c_c__o_p_t]    ggggeeeennnneeeerrrraaaattttoooorrrr
     [_g_e_n_e_r_a_t_o_r__o_p_t] _r_e_s_u_l_t[....bbbbccccgggg]

     or:

     lllloooottttoooossss....ooooppppeeeennnn  [_l_o_t_o_s__o_p_t]  _s_p_e_c[....lllloooottttoooossss]   [_c_c__o_p_t]   ggggeeeennnneeeerrrraaaattttoooorrrr
     [_g_e_n_e_r_a_t_o_r__o_p_t] _r_e_s_u_l_t[....bbbbccccgggg]

     or:

     sssseeeeqqqq....ooooppppeeeennnn    [_s_e_q__o_p_t]    _s_p_e_c[....sssseeeeqqqq]    [_c_c__o_p_t]    ggggeeeennnneeeerrrraaaattttoooorrrr
     [_g_e_n_e_r_a_t_o_r__o_p_t] _r_e_s_u_l_t[....bbbbccccgggg]


DDDDEEEESSSSCCCCRRRRIIIIPPPPTTTTIIIIOOOONNNN
     This program performs exhaustive reachability  analysis  and
     generates  the  Labelled  Transition System corresponding to
     the BCG graph _s_p_e_c....bbbbccccgggg, the composition expression _s_p_e_c....eeeexxxxpppp,
     the  FSP  program  _s_p_e_c....llllttttssss,  the  LNT program _s_p_e_c....llllnnnntttt, the
     LOTOS program _s_p_e_c....lllloooottttoooossss, or the sequence file _s_p_e_c....sssseeeeqqqq.

     The resulting Labelled Transition System is encoded  in  the
     BCG format and stored into file _r_e_s_u_l_t....bbbbccccgggg.

     Note: In its first form (i.e., when applied to the BCG graph
     _s_p_e_c....bbbbccccgggg),  this program is not very useful, since the graph
     has already been generated.


OOOOPPPPTTTTIIIIOOOONNNNSSSS
     The options _b_c_g__o_p_t, if any, are passed to bbbbccccgggg____lllliiiibbbb(LOCAL).




(C) INRIA            Last change: 2020/02/12                    1






CADP MANUAL PAGES                                GENERATOR(LOCAL)



     The options _e_x_p__o_p_t, if any, are passed to eeeexxxxpppp....ooooppppeeeennnn(LOCAL).


     The options _f_s_p__o_p_t, if any, are passed to ffffsssspppp....ooooppppeeeennnn(LOCAL).


     The options _l_n_t__o_p_t, if any, are passed to llllnnnntttt....ooooppppeeeennnn(LOCAL).


     The options _l_o_t_o_s__o_p_t, if any, are passed  to  ccccaaaaeeeessssaaaarrrr(LOCAL)
     and to ccccaaaaeeeessssaaaarrrr....aaaaddddtttt(LOCAL).


     The options _s_e_q__o_p_t, if any, are passed to sssseeeeqqqq....ooooppppeeeennnn(LOCAL).


     The options _c_c__o_p_t, if any, are passed to the C compiler.


     The following options _g_e_n_e_r_a_t_o_r__o_p_t are currently available:

     ----mmmmoooonnnniiiittttoooorrrr
          Open a window for monitoring in real-time  the  genera-
          tion of _r_e_s_u_l_t....bbbbccccgggg.


     ----hhhhiiiiddddeeee [[[[ ----ttttoooottttaaaallll |||| ----ppppaaaarrrrttttiiiiaaaallll |||| ----ggggaaaatttteeee ]]]] _h_i_d_i_n_g__f_i_l_e_n_a_m_e
          Use the hiding rules defined in _h_i_d_i_n_g__f_i_l_e_n_a_m_e to hide
          (on the fly) the labels of the Labelled Transition Sys-
          tem  being  generated.  See  the   ccccaaaaeeeessssaaaarrrr____hhhhiiiiddddeeee____1111(LOCAL)
          manual page for a detailed description of the appropri-
          ate format for _h_i_d_i_n_g__f_i_l_e_n_a_m_e.

          The ----ttttoooottttaaaallll, ----ppppaaaarrrrttttiiiiaaaallll, and  ----ggggaaaatttteeee  options  specify  the
          "total  matching", "partial matching", and "gate match-
          ing"     semantics,     respectively.      See      the
          ccccaaaaeeeessssaaaarrrr____hhhhiiiiddddeeee____1111(LOCAL) manual page for more details about
          these semantics. Option ----ttttoooottttaaaallll is the default.

     ----rrrreeeennnnaaaammmmeeee [[[[----ttttoooottttaaaallll||||----ssssiiiinnnngggglllleeee||||----mmmmuuuullllttttiiiipppplllleeee||||----ggggaaaatttteeee]]]] _r_e_n_a_m_i_n_g__f_i_l_e_n_a_m_e
          Use the renaming rules defined in _r_e_n_a_m_i_n_g__f_i_l_e_n_a_m_e  to
          rename  (on the fly) the labels of the Labelled Transi-
          tion    System     being     generated.     See     the
          ccccaaaaeeeessssaaaarrrr____rrrreeeennnnaaaammmmeeee____1111(LOCAL)   manual  page  for  a  detailed
          description   of    the    appropriate    format    for
          _r_e_n_a_m_i_n_g__f_i_l_e_n_a_m_e.

          The  ----ttttoooottttaaaallll,  ----ssssiiiinnnngggglllleeee,  ----mmmmuuuullllttttiiiipppplllleeee,  and  ----ggggaaaatttteeee  options
          specify  the  "total  matching", "single partial match-
          ing", "multiple partial matching", and "gate  matching"
          semantics, respectively. See the ccccaaaaeeeessssaaaarrrr____rrrreeeennnnaaaammmmeeee____1111(LOCAL)
          manual page for more  details  about  these  semantics.



(C) INRIA            Last change: 2020/02/12                    2






CADP MANUAL PAGES                                GENERATOR(LOCAL)



          Option ----ttttoooottttaaaallll is the default.


          As  for  the  bbbbccccgggg____llllaaaabbbbeeeellllssss(LOCAL)  tool,  several  hiding
          and/or  renaming options can be present on the command-
          line, in which case they are  processed  from  left  to
          right.


     ----uuuunnnnccccoooommmmpppprrrreeeessssssss,,,, ----ccccoooommmmpppprrrreeeessssssss,,,, ----rrrreeeeggggiiiisssstttteeeerrrr,,,, ----sssshhhhoooorrrrtttt,,,, ----mmmmeeeeddddiiiiuuuummmm,,,, ----ssssiiiizzzzeeee
          These options control the  form  under  which  the  BCG
          graph  _r_e_s_u_l_t....bbbbccccgggg  is  generated.  See  the  bbbbccccgggg(LOCAL)
          manual page for a description of these options.


     ----uuuunnnnppppaaaarrrrsssseeee,,,, ----ppppaaaarrrrsssseeee
          These options control label parsing when the BCG  graph
          _r_e_s_u_l_t....bbbbccccgggg  is generated. Default option is ----ppppaaaarrrrsssseeee.... See
          the bbbbccccgggg____wwwwrrrriiiitttteeee(LOCAL) manual page for a  description  of
          label parsing.


     ----ttttmmmmpppp This option specifies the directory in which  temporary
          files  are to be stored. See the bbbbccccgggg(LOCAL) manual page
          for a description of this option.


EEEEXXXXIIIITTTT SSSSTTTTAAAATTTTUUUUSSSS
     Exit status is 0 if everything is alright, 1 otherwise.


DDDDIIIIAAAAGGGGNNNNOOOOSSSSTTTTIIIICCCCSSSS
     When the source is erroneous, error messages are issued.


AAAAUUUUTTTTHHHHOOOORRRR
     Hubert Garavel (INRIA Rhone-Alpes)


OOOOPPPPEEEERRRRAAAANNNNDDDDSSSS
     _s_p_e_c....bbbbccccgggg            BCG graph (input)
     _s_p_e_c....eeeexxxxpppp            network of communicating LTSs (input)
     _s_p_e_c....llllttttssss            FSP specification (input)
     _s_p_e_c....llllnnnntttt            LNT specification (input)
     _s_p_e_c....lllloooottttoooossss          LOTOS specification (input)
     _s_p_e_c....sssseeeeqqqq            sequence file (input)


FFFFIIIILLLLEEEESSSS
     The  source  code  of  this  tool  is  available   in   file
     $$$$CCCCAAAADDDDPPPP////ssssrrrrcccc////ooooppppeeeennnn____ccccaaaaeeeessssaaaarrrr////ggggeeeennnneeeerrrraaaattttoooorrrr....cccc




(C) INRIA            Last change: 2020/02/12                    3






CADP MANUAL PAGES                                GENERATOR(LOCAL)



     See   the   ccccaaaaeeeessssaaaarrrr____hhhhiiiiddddeeee____1111(LOCAL),    ccccaaaaeeeessssaaaarrrr____rrrreeeennnnaaaammmmeeee____1111(LOCAL),
     bbbbccccgggg____llllaaaabbbbeeeellllssss(LOCAL)  manual  pages for a description of hiding
     and renaming conventions.


SSSSEEEEEEEE AAAALLLLSSSSOOOO
     OPEN/CAESAR Reference Manual,  bbbbccccgggg(LOCAL),  bbbbccccgggg____ooooppppeeeennnn(LOCAL),
     ccccaaaaeeeessssaaaarrrr(LOCAL),         ccccaaaaeeeessssaaaarrrr....aaaaddddtttt(LOCAL),        eeeexxxxpppp(LOCAL),
     eeeexxxxpppp....ooooppppeeeennnn(LOCAL),      ffffsssspppp....ooooppppeeeennnn(LOCAL),      llllnnnntttt....ooooppppeeeennnn(LOCAL),
     lllloooottttoooossss(LOCAL), lllloooottttoooossss....ooooppppeeeennnn(LOCAL), sssseeeeqqqq(LOCAL), sssseeeeqqqq....ooooppppeeeennnn(LOCAL)


     Additional information is available from the CADP  Web  page
     located at http://cadp.inria.fr

     Directives   for   installation   are   given    in    files
     $$$$CCCCAAAADDDDPPPP////IIIINNNNSSSSTTTTAAAALLLLLLLLAAAATTTTIIIIOOOONNNN____****....

     Recent  changes  and  improvements  to  this  software   are
     reported and commented in file $$$$CCCCAAAADDDDPPPP////HHHHIIIISSSSTTTTOOOORRRRYYYY....


BBBBUUUUGGGGSSSS
     Please report new bugs to Hubert.Garavel@inria.fr































(C) INRIA            Last change: 2020/02/12                    4



