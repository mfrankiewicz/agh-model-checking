


CADP MANUAL PAGES                                   PBG_RM(LOCAL)



NNNNAAAAMMMMEEEE
     pbg_rm - remove a partitioned BCG graph


SSSSYYYYNNNNOOOOPPPPSSSSIIIISSSS
     ppppbbbbgggg____rrrrmmmm _f_i_l_e_n_a_m_e[[[[....ppppbbbbgggg]]]]


DDDDEEEESSSSCCCCRRRRIIIIPPPPTTTTIIIIOOOONNNN
     ppppbbbbgggg____rrrrmmmm removes _f_i_l_e_n_a_m_e....ppppbbbbgggg,,,,  which  is  a  partitioned  BCG
     graph encoded in the PBG format. It also removes all the BCG
     fragments and log  fragments  referred  to  in  _f_i_l_e_n_a_m_e....ppppbbbbgggg
     (these fragments being stored either on the local machine or
     on remote machines).


     The grid configuration file referred to in  _f_i_l_e_n_a_m_e....ppppbbbbgggg  is
     not  removed,  as  this  file may be used by other PBG files
     than _f_i_l_e_n_a_m_e....ppppbbbbgggg....


     The difference between ppppbbbbgggg____rrrrmmmm and the  UNIX  command  rrrrmmmm  is
     that  ppppbbbbgggg____rrrrmmmm does a "deep" removal, whereas rrrrmmmm does a "shal-
     low" removal (only _f_i_l_e_n_a_m_e....ppppbbbbgggg  is  removed,  but  not  its
     associated fragments).


     Refer to the ggggccccffff(LOCAL)  and  ppppbbbbgggg(LOCAL)  manual  pages  for
     details about the GCF and PBG formats.


EEEEXXXXIIIITTTT SSSSTTTTAAAATTTTUUUUSSSS
     Exit status is 0 if everything is alright, 1 otherwise.


AAAAUUUUTTTTHHHHOOOORRRRSSSS
     An early prototype was written by Jerome Fereyre and  Hubert
     Garavel.   The  current  version  was  developed by Wendelin
     Serwe and Hubert Garavel (INRIA Rhone-Alpes).


OOOOPPPPEEEERRRRAAAANNNNDDDDSSSS
     _f_i_l_e_n_a_m_e....ppppbbbbgggg  partitioned BCG graph (input)


FFFFIIIILLLLEEEESSSS
     The   binary   code    of    ppppbbbbgggg____rrrrmmmm    is    available    in
     $CADP/bin.`arch`/pbg_rm.


SSSSEEEEEEEE AAAALLLLSSSSOOOO
     bbbbccccgggg(LOCAL),   ggggccccffff(LOCAL),   ppppbbbbgggg(LOCAL),    bbbbccccgggg____mmmmeeeerrrrggggeeee(LOCAL),



(C) INRIA            Last change: 2015/11/26                    1






CADP MANUAL PAGES                                   PBG_RM(LOCAL)



     ddddiiiissssttttrrrriiiibbbbuuuuttttoooorrrr(LOCAL),      ppppbbbbgggg____ccccpppp(LOCAL),     ppppbbbbgggg____iiiinnnnffffoooo(LOCAL),
     ppppbbbbgggg____mmmmvvvv(LOCAL), ppppbbbbgggg____ooooppppeeeennnn(LOCAL)


     Additional information is available from the CADP  Web  page
     located at http://cadp.inria.fr


     Directives   for   installation   are   given    in    files
     $$$$CCCCAAAADDDDPPPP////IIIINNNNSSSSTTTTAAAALLLLLLLLAAAATTTTIIIIOOOONNNN____****.


     Recent  changes  and  improvements  to  this  software   are
     reported and commented in file $$$$CCCCAAAADDDDPPPP////HHHHIIIISSSSTTTTOOOORRRRYYYY.


BBBBUUUUGGGGSSSS
     ppppbbbbgggg____rrrrmmmm was not designed to ensure atomic transactions. If an
     error  occurs  while removing certain fragments, other frag-
     ments might nevertheless be removed.  In  such  case,  error
     messages  will  be  displayed  on  the  standard output, and
     _f_i_l_e_n_a_m_e....ppppbbbbgggg will in  general  be  no  longer  usable  after
     invoking ppppbbbbgggg____rrrrmmmm....


     Please report other bugs to cadp@inria.fr





























(C) INRIA            Last change: 2015/11/26                    2



