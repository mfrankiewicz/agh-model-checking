


CADP MANUAL PAGES                                 PBG_INFO(LOCAL)



NNNNAAAAMMMMEEEE
     pbg_info - display information about a partitioned BCG graph


SSSSYYYYNNNNOOOOPPPPSSSSIIIISSSS
     ppppbbbbgggg____iiiinnnnffffoooo [ -cccchhhheeeecccckkkk  ]  [  -llllaaaabbbbeeeellllssss  ]  [  -lllloooogggg  ]  [  -ssssiiiizzzzeeee  ]
     _f_i_l_e_n_a_m_e[[[[....ppppbbbbgggg]]]]


DDDDEEEESSSSCCCCRRRRIIIIPPPPTTTTIIIIOOOONNNN
     ppppbbbbgggg____iiiinnnnffffoooo  takes   as   input   the   partioned   BCG   graph
     _f_i_l_e_n_a_m_e....ppppbbbbgggg,,,,  encoded  in  the PBG format and, depending on
     the option  given  on  the  command-line,  displays  various
     information about _f_i_l_e_n_a_m_e....ppppbbbbgggg....


     Refer to the ggggccccffff(LOCAL)  and  ppppbbbbgggg(LOCAL)  manual  pages  for
     details about the GCF and PBG formats.


OOOOPPPPTTTTIIIIOOOONNNNSSSS
     -cccchhhheeeecccckkkk
          Check whether _f_i_l_e_n_a_m_e....ppppbbbbgggg is consistent, i.e.  whether
          all  local and remote files referred to in _f_i_l_e_n_a_m_e....ppppbbbbgggg
          exist and are readable.


     -llllaaaabbbbeeeellllssss
          Display the number of labels followed by  the  list  of
          labels present in _f_i_l_e_n_a_m_e....ppppbbbbgggg....


     -lllloooogggg
          Display the concatenation  of  all  the  log  fragments
          referred  to in _f_i_l_e_n_a_m_e....ppppbbbbgggg (these fragments generally
          are stored on remote machines).


     -ssssiiiizzzzeeee
          Print the total number of states and transitions of the
          labelled transition system described by _f_i_l_e_n_a_m_e....ppppbbbbgggg....


EEEEXXXXIIIITTTT SSSSTTTTAAAATTTTUUUUSSSS
     Exit status is 0 if everything is alright, 1 otherwise.


AAAAUUUUTTTTHHHHOOOORRRRSSSS
     Hubert Garavel and Wendelin Serwe (INRIA Rhone-Alpes).






(C) INRIA            Last change: 2015/11/26                    1






CADP MANUAL PAGES                                 PBG_INFO(LOCAL)



OOOOPPPPEEEERRRRAAAANNNNDDDDSSSS
     _f_i_l_e_n_a_m_e....ppppbbbbgggg  partitioned BCG graph (input)


FFFFIIIILLLLEEEESSSS
     The   binary   code   of   ppppbbbbgggg____iiiinnnnffffoooo    is    available    in
     $CADP/bin.`arch`/pbg_info.


SSSSEEEEEEEE AAAALLLLSSSSOOOO
     bbbbccccgggg(LOCAL),   ggggccccffff(LOCAL),   ppppbbbbgggg(LOCAL),    bbbbccccgggg____mmmmeeeerrrrggggeeee(LOCAL),
     ddddiiiissssttttrrrriiiibbbbuuuuttttoooorrrr(LOCAL),       ppppbbbbgggg____ccccpppp(LOCAL),      ppppbbbbgggg____mmmmvvvv(LOCAL),
     ppppbbbbgggg____ooooppppeeeennnn(LOCAL), ppppbbbbgggg____rrrrmmmm(LOCAL)


     Additional information is available from the CADP  Web  page
     located at http://cadp.inria.fr


     Directives   for   installation   are   given    in    files
     $$$$CCCCAAAADDDDPPPP////IIIINNNNSSSSTTTTAAAALLLLLLLLAAAATTTTIIIIOOOONNNN____****.


     Recent  changes  and  improvements  to  this  software   are
     reported and commented in file $$$$CCCCAAAADDDDPPPP////HHHHIIIISSSSTTTTOOOORRRRYYYY.


BBBBUUUUGGGGSSSS
     Please report bugs to cadp@inria.fr


























(C) INRIA            Last change: 2015/11/26                    2



