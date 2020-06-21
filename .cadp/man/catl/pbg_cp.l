


CADP MANUAL PAGES                                   PBG_CP(LOCAL)



NNNNAAAAMMMMEEEE
     pbg_cp - copy a partitioned BCG graph


SSSSYYYYNNNNOOOOPPPPSSSSIIIISSSS
     ppppbbbbgggg____ccccpppp [ -iiii ] _s_o_u_r_c_e[[[[....ppppbbbbgggg]]]] _t_a_r_g_e_t[[[[....ppppbbbbgggg]]]]


DDDDEEEESSSSCCCCRRRRIIIIPPPPTTTTIIIIOOOONNNN
     ppppbbbbgggg____ccccpppp copies _s_o_u_r_c_e....ppppbbbbgggg,,,, which is a partitioned  BCG  graph
     encoded  in  the  PBG  format,  into _t_a_r_g_e_t....ppppbbbbgggg....  Both names
     _s_o_u_r_c_e....ppppbbbbgggg and _t_a_r_g_e_t....ppppbbbbgggg must not designate the same  file.
     If  _t_a_r_g_e_t....ppppbbbbgggg  already exists, it is removed first, as well
     as all the BCG fragments and log fragments  referred  to  in
     _t_a_r_g_e_t....ppppbbbbgggg (these fragments being stored either on the local
     machine or on remote machines); however, the grid configura-
     tion  file referred to in _t_a_r_g_e_t....ppppbbbbgggg is not removed, as this
     file may be used by other PBG files than _t_a_r_g_e_t....ppppbbbbgggg....


     The difference between ppppbbbbgggg____ccccpppp and the  UNIX  command  ccccpppp  is
     that  ppppbbbbgggg____ccccpppp does a "deep" copy, whereas ccccpppp does a "shallow"
     copy (only _s_o_u_r_c_e....ppppbbbbgggg  is  copied  and  only  _t_a_r_g_e_t....ppppbbbbgggg  is
     removed if it exists already, but their associated fragments
     are kept unchanged).


     Refer to the ggggccccffff(LOCAL)  and  ppppbbbbgggg(LOCAL)  manual  pages  for
     details about the GCF and PBG formats.


OOOOPPPPTTTTIIIIOOOONNNNSSSS
     -iiii
          Prompt for overwrite confirmation  whenever  _t_a_r_g_e_t....ppppbbbbgggg
          already  exists.   Any  answer starting with 'y' or 'Y'
          means that the copy should proceed.  Any  other  answer
          prevents overwriting to take place.


EEEEXXXXIIIITTTT SSSSTTTTAAAATTTTUUUUSSSS
     Exit status is 0 if everything is alright, 1 otherwise.


AAAAUUUUTTTTHHHHOOOORRRRSSSS
     An early prototype was written by Jerome Fereyre and  Hubert
     Garavel.   The  current  version  was  developed by Wendelin
     Serwe and Hubert Garavel (INRIA Rhone-Alpes).


OOOOPPPPEEEERRRRAAAANNNNDDDDSSSS
     _s_o_u_r_c_e....ppppbbbbgggg    partitioned BCG graph (input)
     _t_a_r_g_e_t....ppppbbbbgggg    resulting partitioned BCG graph (output)



(C) INRIA            Last change: 2015/11/26                    1






CADP MANUAL PAGES                                   PBG_CP(LOCAL)



FFFFIIIILLLLEEEESSSS
     The   binary   code    of    ppppbbbbgggg____ccccpppp    is    available    in
     $CADP/bin.`arch`/pbg_cp.


SSSSEEEEEEEE AAAALLLLSSSSOOOO
     bbbbccccgggg(LOCAL),   ggggccccffff(LOCAL),   ppppbbbbgggg(LOCAL),    bbbbccccgggg____mmmmeeeerrrrggggeeee(LOCAL),
     ddddiiiissssttttrrrriiiibbbbuuuuttttoooorrrr(LOCAL),      ppppbbbbgggg____iiiinnnnffffoooo(LOCAL),     ppppbbbbgggg____mmmmvvvv(LOCAL),
     ppppbbbbgggg____ooooppppeeeennnn(LOCAL), ppppbbbbgggg____rrrrmmmm(LOCAL)


     Additional information is available from the CADP  Web  page
     located at http://cadp.inria.fr


     Directives   for   installation   are   given    in    files
     $$$$CCCCAAAADDDDPPPP////IIIINNNNSSSSTTTTAAAALLLLLLLLAAAATTTTIIIIOOOONNNN____****.


     Recent  changes  and  improvements  to  this  software   are
     reported and commented in file $$$$CCCCAAAADDDDPPPP////HHHHIIIISSSSTTTTOOOORRRRYYYY.


BBBBUUUUGGGGSSSS
     ppppbbbbgggg____ccccpppp was not designed to ensure atomic transactions. If an
     error  occurs  while  copying certain fragments, ppppbbbbgggg____ccccpppp will
     abort the copy and  try  to  remove  all  fragments  already
     copied.  However, if _t_a_r_g_e_t....ppppbbbbgggg already existed, its removal
     and the removal of its fragments cannot be undone.


     Please report other bugs to cadp@inria.fr























(C) INRIA            Last change: 2015/11/26                    2



