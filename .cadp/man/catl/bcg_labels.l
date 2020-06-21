


CADP MANUAL PAGES                               BCG_LABELS(LOCAL)



NNNNAAAAMMMMEEEE
     bcg_labels - modify the labels of graphs encoded in the  BCG
     format


SSSSYYYYNNNNOOOOPPPPSSSSIIIISSSS
     bbbbccccgggg____llllaaaabbbbeeeellllssss [_b_c_g__o_p_t_i_o_n_s] [----ppppaaaarrrrsssseeee | ----uuuunnnnppppaaaarrrrsssseeee] _a_c_t_i_o_n_1 _a_c_t_i_o_n_2
     ...  _i_n_p_u_t....bbbbccccgggg [_o_u_t_p_u_t....bbbbccccgggg]

     where each _a_c_t_i_o_n in the list _a_c_t_i_o_n_1 _a_c_t_i_o_n_2 ... is  either
     a "hiding action", defined as:

     _a_c_t_i_o_n  ::=  ----hhhhiiiiddddeeee  [  ----ttttoooottttaaaallll   |   ----ppppaaaarrrrttttiiiiaaaallll   |   ----ggggaaaatttteeee   ]
     _h_i_d_i_n_g__f_i_l_e_n_a_m_e

     or a "renaming action", defined as:

     _a_c_t_i_o_n ::= ----rrrreeeennnnaaaammmmeeee [ ----ttttoooottttaaaallll | ----ssssiiiinnnngggglllleeee | ----mmmmuuuullllttttiiiipppplllleeee | ----ggggaaaatttteeee  ]
     _r_e_n_a_m_i_n_g__f_i_l_e_n_a_m_e

     or a "scrambling action", defined as:

     _a_c_t_i_o_n ::= ----ssssccccrrrraaaammmmbbbblllleeee _p_a_t_t_e_r_n

     There can be as many actions as needed  (possibly  none)  on
     the  command  line except in the latter case, where the list
     _a_c_t_i_o_n_1 _a_c_t_i_o_n_2 ...  should contain only one element,  mean-
     ing  that  a  scrambling action may not be combined with any
     other action.


DDDDEEEESSSSCCCCRRRRIIIIPPPPTTTTIIIIOOOONNNN
     This command modifies the labels of a BCG graph. It takes as
     input the BCG graph _i_n_p_u_t....bbbbccccgggg and writes the resulting graph
     to _o_u_t_p_u_t....bbbbccccgggg, replacing _i_n_p_u_t....bbbbccccgggg if _o_u_t_p_u_t....bbbbccccgggg is omitted.

     This command applies to the labels of _i_n_p_u_t....bbbbccccgggg, the hiding,
     renaming  and/or scrambling operations specified by the list
     of actions given on the command line.


     These operations are performed in  the  same  order  as  the
     actions  occur  on  the  command-line  (the leftmost actions
     being applied first, and the rightmost  ones  being  applied
     last).  For instance, if bbbbccccgggg____llllaaaabbbbeeeellllssss is called with arguments
     -rrrreeeennnnaaaammmmeeee _f_i_l_e_1 ----hhhhiiiiddddeeee _f_i_l_e_2,,,, renaming will be  applied  before
     hiding.

     A dynamic library corresponding to  _i_n_p_u_t....bbbbccccgggg  may  be  gen-
     erated if necessary.





(C) INRIA            Last change: 2013/09/09                    1






CADP MANUAL PAGES                               BCG_LABELS(LOCAL)



GGGGEEEENNNNEEEERRRRAAAALLLL OOOOPPPPTTTTIIIIOOOONNNNSSSS
     The following _b_c_g__o_p_t_i_o_n_s are currently supported: ----vvvveeeerrrrssssiiiioooonnnn,
     ----ccccrrrreeeeaaaatttteeee,   ----uuuuppppddddaaaatttteeee,   ----rrrreeeemmmmoooovvvveeee,   ----cccccccc,   ----ttttmmmmpppp,   ----uuuunnnnccccoooommmmpppprrrreeeessssssss,
     ----ccccoooommmmpppprrrreeeessssssss, ----rrrreeeeggggiiiisssstttteeeerrrr, ----sssshhhhoooorrrrtttt, ----mmmmeeeeddddiiiiuuuummmm, and  ----ssssiiiizzzzeeee.  See  the
     bbbbccccgggg(LOCAL) manual page for a description of these options.


PPPPAAAARRRRTTTTIIIICCCCUUUULLLLAAAARRRR OOOOPPPPTTTTIIIIOOOONNNNSSSS
     The following options are supported:


      ----hhhhiiiiddddeeee [[[[----ttttoooottttaaaallll||||----ppppaaaarrrrttttiiiiaaaallll||||----ggggaaaatttteeee]]]] _h_i_d_i_n_g__f_i_l_e_n_a_m_e

          Use the hiding rules defined in _h_i_d_i_n_g__f_i_l_e_n_a_m_e to hide
          the  labels  in _i_n_p_u_t....bbbbccccgggg. See the ccccaaaaeeeessssaaaarrrr____hhhhiiiiddddeeee____1111(LOCAL)
          manual page for a detailed description of the appropri-
          ate format for _h_i_d_i_n_g__f_i_l_e_n_a_m_e.

          The ----ttttoooottttaaaallll, ----ppppaaaarrrrttttiiiiaaaallll, and  ----ggggaaaatttteeee  options  specify  the
          "total  matching", "partial matching", and "gate match-
          ing"     semantics,     respectively.      See      the
          ccccaaaaeeeessssaaaarrrr____hhhhiiiiddddeeee____1111(LOCAL) manual page for more details about
          these semantics. Option ----ttttoooottttaaaallll is the default.

      ----rrrreeeennnnaaaammmmeeee [[[[----ttttoooottttaaaallll||||----ssssiiiinnnngggglllleeee||||----mmmmuuuullllttttiiiipppplllleeee||||----ggggaaaatttteeee]]]] _r_e_n_a_m_i_n_g__f_i_l_e_n_a_m_e

          Use the renaming rules defined in _r_e_n_a_m_i_n_g__f_i_l_e_n_a_m_e  to
          rename    the    labels    in    _i_n_p_u_t._b_c_g.   See   the
          ccccaaaaeeeessssaaaarrrr____rrrreeeennnnaaaammmmeeee____1111(LOCAL)  manual  page  for  a   detailed
          description    of    the    appropriate    format   for
          _r_e_n_a_m_i_n_g__f_i_l_e_n_a_m_e.

          The  ----ttttoooottttaaaallll,  ----ssssiiiinnnngggglllleeee,  ----mmmmuuuullllttttiiiipppplllleeee,  and  ----ggggaaaatttteeee  options
          specify  the  "total  matching", "single partial match-
          ing", "multiple partial matching", and "gate  matching"
          semantics, respectively. See the ccccaaaaeeeessssaaaarrrr____rrrreeeennnnaaaammmmeeee____1111(LOCAL)
          manual page for more  details  about  these  semantics.
          Option ----ttttoooottttaaaallll is the default.


      ----ssssccccrrrraaaammmmbbbblllleeee _p_a_t_t_e_r_n

          Rename each label string (except the hidden label  "i",
          which  is  kept  as is) so as to remove any information
          contained  in  the  string;  in   essence,   scrambling
          replaces  all  label  strings  by unique numbers in the
          range 1..N, where N is the number of labels.

          The _p_a_t_t_e_r_n is a character string to  be  used  as  the
          format  argument  of the C function printf(). It should
          contain exactly one occurrence of "%d".  The scrambling
          action renames each label string into _p_a_t_t_e_r_n, the "%d"



(C) INRIA            Last change: 2013/09/09                    2






CADP MANUAL PAGES                               BCG_LABELS(LOCAL)



          of which being replaced  by  the  unique  integer  that
          identifies  the  label.  The _p_a_t_t_e_r_n should not contain
          other %-arguments than "%d", such as "%c",  "%f",  etc.
          If needed, the "%" character can be specified as "%%".


      ----ppppaaaarrrrsssseeee |||| ----uuuunnnnppppaaaarrrrsssseeee

          Options ----ppppaaaarrrrsssseeee and ----uuuunnnnppppaaaarrrrsssseeee  can  be  used  to  control
          label  parsing  in _o_u_t_p_u_t....bbbbccccgggg (see the bbbbccccgggg____wwwwrrrriiiitttteeee(LOCAL)
          manual page for  a  technical  discussion  about  label
          parsing).   By default, or if option ----ppppaaaarrrrsssseeee is present,
          label  parsing  is  enabled.   If  option  ----uuuunnnnppppaaaarrrrsssseeee  is
          present, label parsing is disabled.


EEEENNNNVVVVIIIIRRRROOOONNNNMMMMEEEENNNNTTTT VVVVAAAARRRRIIIIAAAABBBBLLLLEEEESSSS
     See the bbbbccccgggg(LOCAL) manual page  for  a  description  of  the
     environment variables used by all the BCG application tools.


EEEEXXXXIIIITTTT SSSSTTTTAAAATTTTUUUUSSSS
     Exit status is 0 if everything is alright, 1 otherwise.


AAAAUUUUTTTTHHHHOOOORRRRSSSS
     Christophe Discours, Hubert Garavel, and Frederic Lang.


OOOOPPPPEEEERRRRAAAANNNNDDDDSSSS
     _i_n_p_u_t....bbbbccccgggg                BCG graph (input)
     _o_u_t_p_u_t....bbbbccccgggg               BCG graph (output)
     _i_n_p_u_t@@@@1111....oooo                dynamic library (input or output)
     _h_i_d_i_n_g__f_i_l_e_n_a_m_e          set of hiding rules (input)
     _r_e_n_a_m_i_n_g__f_i_l_e_n_a_m_e        set of renaming rules (input)


FFFFIIIILLLLEEEESSSS
     $$$$CCCCAAAADDDDPPPP////bbbbiiiinnnn....````aaaarrrrcccchhhh````////bbbbccccgggg____llllaaaabbbbeeeellllssss   ``bbbbccccgggg____llllaaaabbbbeeeellllssss'' binary program


     See the bbbbccccgggg(LOCAL) manual page  for  a  description  of  the
     other files.


SSSSEEEEEEEE AAAALLLLSSSSOOOO
     bbbbccccgggg(LOCAL), ccccaaaaeeeessssaaaarrrr____hhhhiiiiddddeeee____1111(LOCAL), ccccaaaaeeeessssaaaarrrr____rrrreeeennnnaaaammmmeeee____1111(LOCAL)


     Additional information is available from the CADP  Web  page
     located at http://cadp.inria.fr




(C) INRIA            Last change: 2013/09/09                    3






CADP MANUAL PAGES                               BCG_LABELS(LOCAL)



     Directives   for   installation   are   given    in    files
     $$$$CCCCAAAADDDDPPPP////IIIINNNNSSSSTTTTAAAALLLLLLLLAAAATTTTIIIIOOOONNNN____****.

     Recent  changes  and  improvements  to  this  software   are
     reported and commented in file $$$$CCCCAAAADDDDPPPP////HHHHIIIISSSSTTTTOOOORRRRYYYY.


BBBBUUUUGGGGSSSS
     Please report bugs to Hubert.Garavel@inria.fr














































(C) INRIA            Last change: 2013/09/09                    4



