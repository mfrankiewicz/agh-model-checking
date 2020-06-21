


CADP MANUAL PAGES                                 BCG_OPEN(LOCAL)



NNNNAAAAMMMMEEEE
     bcg_open - OPEN/CAESAR connection for graphs encoded in  the
     BCG format


SSSSYYYYNNNNOOOOPPPPSSSSIIIISSSS
     bbbbccccgggg____ooooppppeeeennnn [_b_c_g__o_p_t_i_o_n_s] _f_i_l_e_n_a_m_e[....bbbbccccgggg] [_c_c__o_p_t_i_o_n_s]
     _p_r_o_g[....aaaa|....cccc|....oooo] [_p_r_o_g__o_p_t_i_o_n_s]


DDDDEEEESSSSCCCCRRRRIIIIPPPPTTTTIIIIOOOONNNN
     Taking as input a BCG graph _f_i_l_e_n_a_m_e....bbbbccccgggg and an  OPEN/CAESAR
     program  _p_r_o_g[....aaaa|....cccc|....oooo],  bbbbccccgggg____ooooppppeeeennnn  generates  an executable
     program _p_r_o_g performing appropriate calls to  the  BCG  pro-
     grams and the C compiler.  Finally, _p_r_o_g is executed.

     According to the principles of the OPEN/CAESAR architecture,
     _p_r_o_g is obtained by combining three different modules:


     -    the graph module is generated from _f_i_l_e_n_a_m_e....bbbbccccgggg
     -    the storage module is the standard OPEN/CAESAR library
     -    the exploration module is _p_r_o_g[....aaaa|....cccc|....oooo]


PPPPRRRROOOOCCCCEEEESSSSSSSSIIIINNNNGGGG OOOOFFFF TTTTHHHHEEEE GGGGRRRRAAAAPPPPHHHH MMMMOOOODDDDUUUULLLLEEEE
     A dynamic library corresponding to _f_i_l_e_n_a_m_e....bbbbccccgggg may be  gen-
     erated if necessary.


PPPPRRRROOOOCCCCEEEESSSSSSSSIIIINNNNGGGG OOOOFFFF TTTTHHHHEEEE EEEEXXXXPPPPLLLLOOOORRRRAAAATTTTIIIIOOOONNNN MMMMOOOODDDDUUUULLLLEEEE
     The exploration module _p_r_o_g[....aaaa|....cccc|....oooo] is supposed to contain
     an  OPEN/CAESAR  application  program,  such  as  eeeexxxxhhhhiiiibbbbiiiittttoooorrrr,
     eeeevvvvaaaalllluuuuaaaattttoooorrrr, tttteeeerrrrmmmmiiiinnnnaaaattttoooorrrr...

     The exploration module can be supplied  in  three  different
     forms. It can be either an archive file (with ....aaaa suffix), or
     a source C program (with ....cccc suffix) or an object  code  file
     (with ....oooo suffix).

     If _p_r_o_g....aaaa is not present in the current directory,  bbbbccccgggg____ooooppppeeeennnn
     attempts  to  fetch  it  in  the  OPEN/CAESAR binary library
     $$$$CCCCAAAADDDDPPPP////bbbbiiiinnnn....````aaaarrrrcccchhhh````.

     If _p_r_o_g....cccc is not present in the current directory,  bbbbccccgggg____ooooppppeeeennnn
     attempts  to  fetch  it  in  the  OPEN/CAESAR source library
     $$$$CCCCAAAADDDDPPPP////ssssrrrrcccc////ooooppppeeeennnn____ccccaaaaeeeessssaaaarrrr.

     If _p_r_o_g....oooo is not present in the current directory,  bbbbccccgggg____ooooppppeeeennnn
     attempts  to  fetch  it  in  the  OPEN/CAESAR binary library
     $$$$CCCCAAAADDDDPPPP////bbbbiiiinnnn....````aaaarrrrcccchhhh````.




(C) INRIA            Last change: 2020/02/11                    1






CADP MANUAL PAGES                                 BCG_OPEN(LOCAL)



     If no suffix (....aaaa, ....cccc, ....oooo) is specified on the  command  line
     for  the exploration module _p_r_o_g, bbbbccccgggg____ooooppppeeeennnn will make succes-
     sive attempts to fetch this exploration module: first, as  a
     source  C  program  with  ....cccc suffix; then as an archive file
     with ....aaaa suffix; finally as an object code file  with  suffix
     ....oooo.


DDDDEEEETTTTEEEERRRRMMMMIIIINNNNAAAATTTTIIIIOOOONNNN OOOOFFFF IIIINNNNCCCCLLLLUUUUDDDDEEEE OOOORRRR LLLLIIIINNNNKKKK MMMMOOOODDDDEEEE
     Only the  ``link  mode''  of  OPEN/CAESAR  is  supported  by
     bbbbccccgggg____ooooppppeeeennnn.


GGGGEEEENNNNEEEERRRRAAAALLLL OOOOPPPPTTTTIIIIOOOONNNNSSSS
     The following _b_c_g__o_p_t_i_o_n_s are currently supported: ----vvvveeeerrrrssssiiiioooonnnn,
     ----ccccrrrreeeeaaaatttteeee, ----uuuuppppddddaaaatttteeee, ----rrrreeeemmmmoooovvvveeee, ----cccccccc, and ----ttttmmmmpppp. See the bbbbccccgggg(LOCAL)
     manual page for a description of these options.


PPPPAAAARRRRTTTTIIIICCCCUUUULLLLAAAARRRR OOOOPPPPTTTTIIIIOOOONNNNSSSS
     The _c_c__o_p_t_i_o_n_s, if any, are passed to the C compiler.

     The _p_r_o_g__o_p_t_i_o_n_s, if any, are passed to _p_r_o_g.


EEEENNNNVVVVIIIIRRRROOOONNNNMMMMEEEENNNNTTTT VVVVAAAARRRRIIIIAAAABBBBLLLLEEEESSSS
     See the bbbbccccgggg(LOCAL) manual page  for  a  description  of  the
     environment variables used by all the BCG application tools.


EEEEXXXXIIIITTTT SSSSTTTTAAAATTTTUUUUSSSS
     Exit status is 0 if everything is alright, 1 otherwise.


AAAAUUUUTTTTHHHHOOOORRRRSSSS
     Renaud Ruffiot and Hubert Garavel


OOOOPPPPEEEERRRRAAAANNNNDDDDSSSS
     _f_i_l_e_n_a_m_e....bbbbccccgggg     BCG graph (input)
     _f_i_l_e_n_a_m_e@_1....oooo     dynamic library (input or output)
     _p_r_o_g....aaaa           exploration module (archive, input)
     _p_r_o_g....cccc           exploration module (source, input)
     _p_r_o_g....oooo           exploration module (object code, input)
     _p_r_o_g             executable program (output)


FFFFIIIILLLLEEEESSSS
     $$$$CCCCAAAADDDDPPPP////ccccoooommmm////bbbbccccgggg____ooooppppeeeennnn            ``bbbbccccgggg____ooooppppeeeennnn'' shell script
     $$$$CCCCAAAADDDDPPPP////bbbbiiiinnnn....````aaaarrrrcccchhhh````////lllliiiibbbbbbbbccccgggg____ooooppppeeeennnn....aaaa
                                   ``bcg_open'' static library
     $$$$CCCCAAAADDDDPPPP////iiiinnnnccccllll////ccccaaaaeeeessssaaaarrrr____****....hhhh         OPEN/CAESAR interfaces



(C) INRIA            Last change: 2020/02/11                    2






CADP MANUAL PAGES                                 BCG_OPEN(LOCAL)



     $$$$CCCCAAAADDDDPPPP////bbbbiiiinnnn....````aaaarrrrcccchhhh````////lllliiiibbbbccccaaaaeeeessssaaaarrrr....aaaa  OPEN/CAESAR library
     $$$$CCCCAAAADDDDPPPP////ssssrrrrcccc////ooooppppeeeennnn____ccccaaaaeeeessssaaaarrrr////****....cccc     exploration modules (source)
     $$$$CCCCAAAADDDDPPPP////bbbbiiiinnnn....````aaaarrrrcccchhhh````////****....aaaa          exploration modules (archive)
     $$$$CCCCAAAADDDDPPPP////bbbbiiiinnnn....````aaaarrrrcccchhhh````////****....oooo          exploration  modules   (object
                                   code)

     See the bbbbccccgggg(LOCAL) manual page bcg for a description of  the
     other files).


SSSSEEEEEEEE AAAALLLLSSSSOOOO
     bbbbccccgggg(LOCAL), lllloooottttoooossss....ooooppppeeeennnn(LOCAL)


     Additional information is available from the CADP  Web  page
     located at http://cadp.inria.fr

     Directives   for   installation   are   given    in    files
     $$$$CCCCAAAADDDDPPPP////IIIINNNNSSSSTTTTAAAALLLLLLLLAAAATTTTIIIIOOOONNNN____****.


     Recent  changes  and  improvements  to  this  software   are
     reported and commented in file $$$$CCCCAAAADDDDPPPP////HHHHIIIISSSSTTTTOOOORRRRYYYY.


BBBBUUUUGGGGSSSS
     Please report bugs to Hubert.Garavel@inria.fr




























(C) INRIA            Last change: 2020/02/11                    3



