


CADP MANUAL PAGES                                SIMULATOR(LOCAL)



NNNNAAAAMMMMEEEE
     simulator - interactive simulator  with  ASCII  command-line
     interface


SSSSYYYYNNNNOOOOPPPPSSSSIIIISSSS
     bbbbccccgggg____ooooppppeeeennnn [_b_c_g__o_p_t] _s_p_e_c[....bbbbccccgggg] [_c_c__o_p_t] ssssiiiimmmmuuuullllaaaattttoooorrrr

     or:

     eeeexxxxpppp....ooooppppeeeennnn [_e_x_p__o_p_t] _s_p_e_c[....eeeexxxxpppp] [_c_c__o_p_t] ssssiiiimmmmuuuullllaaaattttoooorrrr

     or:

     ffffsssspppp....ooooppppeeeennnn [_f_s_p__o_p_t] _s_p_e_c[....llllttttssss] [_c_c__o_p_t] ssssiiiimmmmuuuullllaaaattttoooorrrr

     or:

     llllnnnntttt....ooooppppeeeennnn [_l_n_t__o_p_t] _s_p_e_c[....llllnnnntttt] [_c_c__o_p_t] ssssiiiimmmmuuuullllaaaattttoooorrrr

     or:

     lllloooottttoooossss....ooooppppeeeennnn [_l_o_t_o_s__o_p_t] _s_p_e_c[....lllloooottttoooossss] [_c_c__o_p_t] ssssiiiimmmmuuuullllaaaattttoooorrrr

     or:

     sssseeeeqqqq....ooooppppeeeennnn [_s_e_q__o_p_t] _s_p_e_c[....sssseeeeqqqq] [_c_c__o_p_t] ssssiiiimmmmuuuullllaaaattttoooorrrr


DDDDEEEESSSSCCCCRRRRIIIIPPPPTTTTIIIIOOOONNNN
     This program provides interactive  simulation  for  the  BCG
     graph _s_p_e_c....bbbbccccgggg, the composition expression _s_p_e_c....eeeexxxxpppp, the FSP
     program _s_p_e_c....llllttttssss, the LNT program _s_p_e_c....llllnnnntttt, the  LOTOS  pro-
     gram _s_p_e_c....lllloooottttoooossss, or the sequence file _s_p_e_c....sssseeeeqqqq.

     It performs an infinite interpreter loop,  reading  commands
     on  the standard input, executing these commands, and print-
     ing the result on the standard output.

     A stack is used to maintain the execution sequence  starting
     from  the  initial  state  and leading to the current state,
     thus making backtrack possible.

     The list of available commands can  be  obtained  by  typing
     "help" or "?".


OOOOPPPPTTTTIIIIOOOONNNNSSSS
     The options _b_c_g__o_p_t, if any, are passed to bbbbccccgggg____lllliiiibbbb(LOCAL).






(C) INRIA            Last change: 2020/02/12                    1






CADP MANUAL PAGES                                SIMULATOR(LOCAL)



     The options _e_x_p__o_p_t, if any, are passed to eeeexxxxpppp....ooooppppeeeennnn(LOCAL).


     The options _f_s_p__o_p_t, if any, are passed to ffffsssspppp....ooooppppeeeennnn(LOCAL).


     The options _l_n_t__o_p_t, if any, are passed to llllnnnntttt....ooooppppeeeennnn(LOCAL).


     The options _l_o_t_o_s__o_p_t, if any, are passed  to  ccccaaaaeeeessssaaaarrrr(LOCAL)
     and to ccccaaaaeeeessssaaaarrrr....aaaaddddtttt(LOCAL).


     The options _s_e_q__o_p_t, if any, are passed to sssseeeeqqqq....ooooppppeeeennnn(LOCAL).


     The options _c_c__o_p_t, if any, are passed to the C compiler.


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
     $$$$CCCCAAAADDDDPPPP////ssssrrrrcccc////ooooppppeeeennnn____ccccaaaaeeeessssaaaarrrr////{ssssiiiimmmmuuuullllaaaattttoooorrrr....cccc,,,,ssssiiiimmmmuuuullllaaaattttoooorrrr....iiii}

SSSSEEEEEEEE AAAALLLLSSSSOOOO
     OPEN/CAESAR Reference Manual,  bbbbccccgggg(LOCAL),  bbbbccccgggg____ooooppppeeeennnn(LOCAL),
     ccccaaaaeeeessssaaaarrrr(LOCAL),         ccccaaaaeeeessssaaaarrrr....aaaaddddtttt(LOCAL),        eeeexxxxpppp(LOCAL),
     eeeexxxxpppp....ooooppppeeeennnn(LOCAL),      ffffsssspppp....ooooppppeeeennnn(LOCAL),      llllnnnntttt....ooooppppeeeennnn(LOCAL),
     lllloooottttoooossss(LOCAL), lllloooottttoooossss....ooooppppeeeennnn(LOCAL), sssseeeeqqqq(LOCAL), sssseeeeqqqq....ooooppppeeeennnn(LOCAL)






(C) INRIA            Last change: 2020/02/12                    2






CADP MANUAL PAGES                                SIMULATOR(LOCAL)



     Additional information is available from the CADP  Web  page
     located at http://cadp.inria.fr

     Directives   for   installation   are   given    in    files
     $$$$CCCCAAAADDDDPPPP////IIIINNNNSSSSTTTTAAAALLLLLLLLAAAATTTTIIIIOOOONNNN____****....

     Recent  changes  and  improvements  to  this  software   are
     reported and commented in file $$$$CCCCAAAADDDDPPPP////HHHHIIIISSSSTTTTOOOORRRRYYYY....


BBBBUUUUGGGGSSSS
     Please report new bugs to Hubert.Garavel@inria.fr











































(C) INRIA            Last change: 2020/02/12                    3



