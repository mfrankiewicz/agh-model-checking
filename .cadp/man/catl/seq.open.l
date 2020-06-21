


CADP MANUAL PAGES                                 SEQ.OPEN(LOCAL)



NNNNAAAAMMMMEEEE
     seq.open - OPEN/CAESAR connection for traces encoded in  the
     SEQ format


SSSSYYYYNNNNOOOOPPPPSSSSIIIISSSS
     sssseeeeqqqq....ooooppppeeeennnn [_s_e_q__o_p_t_i_o_n_s] _f_i_l_e_n_a_m_e[....sssseeeeqqqq] [_c_c__o_p_t_i_o_n_s]
     _p_r_o_g[....aaaa|....cccc|....oooo] [_p_r_o_g__o_p_t_i_o_n_s]


DDDDEEEESSSSCCCCRRRRIIIIPPPPTTTTIIIIOOOONNNN
     Taking as input the graph _f_i_l_e_n_a_m_e....sssseeeeqqqq, which  represents  a
     set  of  one  or more execution traces encoded in the simple
     SEQ format (see the sssseeeeqqqq(LOCAL) manual page for a  definition
     of  this format), and an OPEN/CAESAR program _p_r_o_g[....aaaa|....cccc|....oooo],
     sssseeeeqqqq....ooooppppeeeennnn generates an executable program _p_r_o_g by  performing
     appropriate  calls  to the C compiler. Finally, _p_r_o_g is exe-
     cuted.

     According to the principles of the OPEN/CAESAR architecture,
     _p_r_o_g is obtained by combining three different modules:


     -    the graph module is obtained by scanning _f_i_l_e_n_a_m_e....sssseeeeqqqq
     -    the storage module is the standard OPEN/CAESAR library
     -    the exploration module is _p_r_o_g[....aaaa|....cccc|....oooo]


     The sssseeeeqqqq....ooooppppeeeennnn tool was designed to handle very  large  execu-
     tion traces, such as those obtained by a random execution of
     a real system. For this reason, sssseeeeqqqq....ooooppppeeeennnn  works  on-the-fly,
     without   storing   in   memory   the   entire  contents  of
     _f_i_l_e_n_a_m_e....sssseeeeqqqq. In order  to  speed  up  the  exploration,  an
     hash-based cache table of bounded size is used to avoid mul-
     tiple computations of label strings  and  successor  transi-
     tions.


PPPPRRRROOOOCCCCEEEESSSSSSSSIIIINNNNGGGG OOOOFFFF TTTTHHHHEEEE EEEEXXXXPPPPLLLLOOOORRRRAAAATTTTIIIIOOOONNNN MMMMOOOODDDDUUUULLLLEEEE
     The exploration module _p_r_o_g[....aaaa|....cccc|....oooo] is supposed to contain
     an  OPEN/CAESAR  application  program,  such  as  eeeexxxxhhhhiiiibbbbiiiittttoooorrrr,
     eeeevvvvaaaalllluuuuaaaattttoooorrrr, tttteeeerrrrmmmmiiiinnnnaaaattttoooorrrr...

     The exploration module can be supplied  in  three  different
     forms. It can be either an archive file (with ....aaaa suffix), or
     a source C program (with ....cccc suffix) or an object  code  file
     (with ....oooo suffix).

     If _p_r_o_g....aaaa is not present in the current directory,  sssseeeeqqqq....ooooppppeeeennnn
     attempts  to  fetch  it  in  the  OPEN/CAESAR binary library
     $$$$CCCCAAAADDDDPPPP////bbbbiiiinnnn....````aaaarrrrcccchhhh````.




(C) INRIA            Last change: 2020/02/11                    1






CADP MANUAL PAGES                                 SEQ.OPEN(LOCAL)



     If _p_r_o_g....cccc is not present in the current directory,  sssseeeeqqqq....ooooppppeeeennnn
     attempts  to  fetch  it  in  the  OPEN/CAESAR source library
     $$$$CCCCAAAADDDDPPPP////ssssrrrrcccc////ooooppppeeeennnn____ccccaaaaeeeessssaaaarrrr.

     If _p_r_o_g....oooo is not present in the current directory,  sssseeeeqqqq....ooooppppeeeennnn
     attempts  to  fetch  it  in  the  OPEN/CAESAR binary library
     $$$$CCCCAAAADDDDPPPP////bbbbiiiinnnn....````aaaarrrrcccchhhh````.

     If no suffix (....aaaa, ....cccc, ....oooo) is specified on the  command  line
     for  the exploration module _p_r_o_g, sssseeeeqqqq....ooooppppeeeennnn will make succes-
     sive attempts to fetch this exploration module: first, as  a
     source  C  program  with  ....cccc suffix; then as an archive file
     with ....aaaa suffix; finally as an object code file  with  suffix
     ....oooo.


DDDDEEEETTTTEEEERRRRMMMMIIIINNNNAAAATTTTIIIIOOOONNNN OOOOFFFF IIIINNNNCCCCLLLLUUUUDDDDEEEE OOOORRRR LLLLIIIINNNNKKKK MMMMOOOODDDDEEEE
     Only the  ``link  mode''  of  OPEN/CAESAR  is  supported  by
     sssseeeeqqqq....ooooppppeeeennnn.


OOOOPPPPTTTTIIIIOOOONNNNSSSS
     The _c_c__o_p_t_i_o_n_s, if any, are passed to the C compiler.

     The _p_r_o_g__o_p_t_i_o_n_s, if any, are passed to _p_r_o_g.

     The following options _s_e_q__o_p_t_i_o_n_s are currently available:

     ----sssseeeeqqqqnnnnoooo _n_u_m_b_e_r
          Select the _n_u_m_b_e_r-th sequence in  _f_i_l_e_n_a_m_e....sssseeeeqqqq  as  the
          only  sequence  to  be  considered  during exploration.
          _n_u_m_b_e_r should be a positive  integer.  By  default  (if
          this  option  is not present on the command-line) or if
          _s_e_q_n_o is equal to  zero,  all  sequences  contained  in
          _f_i_l_e_n_a_m_e....sssseeeeqqqq  will  be considered. If _f_i_l_e_n_a_m_e....sssseeeeqqqq only
          contains a single sequence, using option `----sssseeeeqqqqnnnnoooo 1' may
          speed  up  the execution by avoiding a preliminary scan
          of the sequence file.


     ----ccccaaaacccchhhheeee _n_u_m_b_e_r
          Select the size of the hash-based cache table  used  to
          avoid  recomputations  of  label  strings and successor
          transitions. This size defines the number of entries in
          the  cache  table. If _n_u_m_b_e_r is not a prime, it will be
          replaced by the closest higher prime number. By default
          (if  this  option  is not present on the command-line),
          the cache size will be 49999.


     ----ssssttttaaaatttt
          Print statistics about the usage of cache, such as  the



(C) INRIA            Last change: 2020/02/11                    2






CADP MANUAL PAGES                                 SEQ.OPEN(LOCAL)



          number of failures (the requested data is not stored in
          the cache) and the number of successes  (the  requested
          data  is  already  in cache) every time a sink state is
          reached (i.e., at the end  of  each  sequence).  Not  a
          default option.


EEEEXXXXIIIITTTT SSSSTTTTAAAATTTTUUUUSSSS
     Exit status is 0 if everything is alright, 1 otherwise.


AAAAUUUUTTTTHHHHOOOORRRRSSSS
     Hubert  GARAVEL,  Radu  MATEESCU,  and  Bruno  ONDET  (INRIA
     Rhone-Alpes / VASY)


OOOOPPPPEEEERRRRAAAANNNNDDDDSSSS
     _f_i_l_e_n_a_m_e....sssseeeeqqqq         sequence graph (input)
     _p_r_o_g....aaaa               exploration module (archive, input)
     _p_r_o_g....cccc               exploration module (source, input)
     _p_r_o_g....oooo               exploration module (object code, input)
     _p_r_o_g                 executable program (output)


FFFFIIIILLLLEEEESSSS
     $$$$CCCCAAAADDDDPPPP////ccccoooommmm////sssseeeeqqqq....ooooppppeeeennnn             ``seq.open'' shell script
     $$$$CCCCAAAADDDDPPPP////bbbbiiiinnnn....````aaaarrrrcccchhhh````////lllliiiibbbbsssseeeeqqqq____ooooppppeeeennnn....aaaa ``seq.open'' static library
     $$$$CCCCAAAADDDDPPPP////iiiinnnnccccllll////ccccaaaaeeeessssaaaarrrr____****....hhhh          OPEN/CAESAR interfaces
     $$$$CCCCAAAADDDDPPPP////bbbbiiiinnnn....````aaaarrrrcccchhhh````////lllliiiibbbbccccaaaaeeeessssaaaarrrr....aaaa   OPEN/CAESAR library
     $$$$CCCCAAAADDDDPPPP////ssssrrrrcccc////ooooppppeeeennnn____ccccaaaaeeeessssaaaarrrr////****....cccc      exploration modules (source)
     $$$$CCCCAAAADDDDPPPP////bbbbiiiinnnn....````aaaarrrrcccchhhh````////****....aaaa           exploration modules (archive)
     $$$$CCCCAAAADDDDPPPP////bbbbiiiinnnn....````aaaarrrrcccchhhh````////****....oooo           exploration  modules  (object
                                    code)

SSSSEEEEEEEE AAAALLLLSSSSOOOO
     sssseeeeqqqq(LOCAL), lllloooottttoooossss....ooooppppeeeennnn(LOCAL), eeeexxxxhhhhiiiibbbbiiiittttoooorrrr(LOCAL)

     Additional information is available from the CADP  Web  page
     located at http://cadp.inria.fr

     Directives   for   installation   are   given    in    files
     $$$$CCCCAAAADDDDPPPP////IIIINNNNSSSSTTTTAAAALLLLLLLLAAAATTTTIIIIOOOONNNN____****.

     Recent  changes  and  improvements  to  this  software   are
     reported and commented in file $$$$CCCCAAAADDDDPPPP////HHHHIIIISSSSTTTTOOOORRRRYYYY.

BBBBUUUUGGGGSSSS
     Please report bugs to Hubert.Garavel@inria.fr







(C) INRIA            Last change: 2020/02/11                    3



