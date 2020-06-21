


CADP MANUAL PAGES                                  BCG_LIB(LOCAL)



NNNNAAAAMMMMEEEE
     bcg_lib - generate dynamic libraries for graphs  encoded  in
     the BCG format


SSSSYYYYNNNNOOOOPPPPSSSSIIIISSSS
     bbbbccccgggg____lllliiiibbbb [_b_c_g__o_p_t_i_o_n_s] [----nnnn _i_n_t_e_g_e_r] [----cccc] [----hhhh] _f_i_l_e_n_a_m_e[....bbbbccccgggg]


DDDDEEEESSSSCCCCRRRRIIIIPPPPTTTTIIIIOOOONNNN
     This command takes as input the BCG graph  _f_i_l_e_n_a_m_e....bbbbccccgggg  and
     generates  the  corresponding library, which is contained in
     file _f_i_l_e_n_a_m_e@@@@iiiinnnntttteeeeggggeeeerrrr....oooo. This command is not supposed to  be
     invoked directly by end-users.


GGGGEEEENNNNEEEERRRRAAAALLLL OOOOPPPPTTTTIIIIOOOONNNNSSSS
     The following _b_c_g__o_p_t_i_o_n_s are currently supported: ----vvvveeeerrrrssssiiiioooonnnn,
     ----ccccrrrreeeeaaaatttteeee,  ----uuuuppppddddaaaatttteeee,  ----cccccccc, and ----ttttmmmmpppp. See the bbbbccccgggg(LOCAL) manual
     page for a description of these options.


PPPPAAAARRRRTTTTIIIICCCCUUUULLLLAAAARRRR OOOOPPPPTTTTIIIIOOOONNNNSSSS
     The following options are also suported:


     -nnnn _i_n_t_e_g_e_r
          Determine the number of the dynamic library to be  gen-
          erated. By default _i_n_t_e_g_e_r is equal to 1.

     -cccc
          Do  not  generate  the  dynamic  library,  but  display
          instead  its source code on the standard output. Debug-
          ging option, not  available  in  official  releases  of
          CADP.

     -hhhh
          Do not  generate  the  dynamic  library,  but  generate
          instead   its   interface,  the  generic  include  file
          bbbbccccgggg____ddddyyyynnnnaaaammmmiiiicccc____lllliiiibbbb____iiiinnnntttteeeeggggeeeerrrr....hhhh. Debugging option, not avail-
          able in official releases of CADP.


EEEENNNNVVVVIIIIRRRROOOONNNNMMMMEEEENNNNTTTT VVVVAAAARRRRIIIIAAAABBBBLLLLEEEESSSS
     See the bbbbccccgggg(LOCAL) manual page  for  a  description  of  the
     environment variables used by all the BCG application tools.


EEEEXXXXIIIITTTT SSSSTTTTAAAATTTTUUUUSSSS
     Exit status is 0 if everything is alright, 1 otherwise.





(C) INRIA            Last change: 2013/09/09                    1






CADP MANUAL PAGES                                  BCG_LIB(LOCAL)



AAAAUUUUTTTTHHHHOOOORRRRSSSS
     Renaud Ruffiot and Hubert Garavel


OOOOPPPPEEEERRRRAAAANNNNDDDDSSSS
     _f_i_l_e_n_a_m_e....bbbbccccgggg                  BCG graph (input)
     _f_i_l_e_n_a_m_e@@@@iiiinnnntttteeeeggggeeeerrrr....oooo            dynamic library (output)


FFFFIIIILLLLEEEESSSS
     bbbbccccgggg____ddddyyyynnnnaaaammmmiiiicccc____lllliiiibbbb____iiiinnnntttteeeeggggeeeerrrr....hhhh     dynamic   library    interface
                                   (output)
     $$$$CCCCAAAADDDDPPPP////bbbbiiiinnnn....````aaaarrrrcccchhhh````////bbbbccccgggg____lllliiiibbbb      ``bbbbccccgggg____lllliiiibbbb'' binary program

     See the bbbbccccgggg(LOCAL) manual page  for  a  description  of  the
     other files).


SSSSEEEEEEEE AAAALLLLSSSSOOOO
     bbbbccccgggg(LOCAL)

     Additional information is available from the CADP  Web  page
     located at http://cadp.inria.fr

     Directives   for   installation   are   given    in    files
     $$$$CCCCAAAADDDDPPPP////IIIINNNNSSSSTTTTAAAALLLLLLLLAAAATTTTIIIIOOOONNNN____****.

     Recent  changes  and  improvements  to  this  software   are
     reported and commented in file $$$$CCCCAAAADDDDPPPP////HHHHIIIISSSSTTTTOOOORRRRYYYY.


BBBBUUUUGGGGSSSS
     Please report bugs to Hubert.Garavel@inria.fr






















(C) INRIA            Last change: 2013/09/09                    2



