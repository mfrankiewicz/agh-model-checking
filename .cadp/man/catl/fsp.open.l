





























































(C) INRIA                                                       1






CADP MANUAL PAGES                                 FSP.OPEN(LOCAL)



NNNNAAAAMMMMEEEE
     fsp.open - OPEN/CAESAR connection for the FSP language


SSSSYYYYNNNNOOOOPPPPSSSSIIIISSSS
     ffffsssspppp....ooooppppeeeennnn  [----rrrrooooooootttt  _r_o_o_t-_p_r_o_c_e_s_s]  [----ssssiiiilllleeeennnntttt  |  ----vvvveeeerrrrbbbboooosssseeee]   [----
     vvvveeeerrrrssssiiiioooonnnn]     [_e_x_p__o_p_t_i_o_n_s]    _f_i_l_e_n_a_m_e[....llllttttssss]    [_c_c__o_p_t_i_o_n_s]
     _p_r_o_g[....aaaa|....cccc|....oooo] [_p_r_o_g__o_p_t_i_o_n_s]


DDDDEEEESSSSCCCCRRRRIIIIPPPPTTTTIIIIOOOONNNN
     Taking as input _f_i_l_e_n_a_m_e....llllttttssss (which describes a  process  in
     the  FSP  language of Magee & Kramer, Imperial College, Lon-
     don) and an  OPEN/CAESAR  program  _p_r_o_g[....aaaa|....cccc|....oooo],  ffffsssspppp....ooooppppeeeennnn
     operates as follows:

     -    First, it translates _f_i_l_e_n_a_m_e....llllttttssss into an EXP.OPEN net-
          work  of  automata _f_i_l_e_n_a_m_e....eeeexxxxpppp,,,, using ffffsssspppp2222lllloooottttoooossss(LOCAL)
          and ssssvvvvllll(LOCAL).  See ffffsssspppp2222lllloooottttoooossss(LOCAL) for more   infor-
          mation.

     -    Second, it calls ``eeeexxxxpppp....ooooppppeeeennnn  _f_i_l_e_n_a_m_e....eeeexxxxpppp  [_c_c__o_p_t_i_o_n_s]
          _p_r_o_g[....aaaa|....cccc|....oooo]  [_p_r_o_g__o_p_t_i_o_n_s]'',  passing  to eeeexxxxpppp....ooooppppeeeennnn
          appropriate options that depend on the  options  passed
          to  ffffsssspppp....ooooppppeeeennnn  (see below). See eeeexxxxpppp....ooooppppeeeennnn(LOCAL) for more
          information.
          However, if _p_r_o_g is the "-" string (instead of the name
          of  an  OPEN/CAESAR application program), ffffsssspppp....ooooppppeeeennnn will
          execute  only  the  first  step  (translation  into  an
          EXP.OPEN  network  of  automata)  and then stop without
          invoking eeeexxxxpppp....ooooppppeeeennnn.  In such case, the  files  generated
          during  the  first  step are not removed, thus allowing
          the generated EXP.OPEN network of automata to  be  used
          for other purpose than OPEN/CAESAR.


OOOOPPPPTTTTIIIIOOOONNNNSSSS
     ----rrrrooooooootttt _r_o_o_t-_p_r_o_c_e_s_s
          Use the process root-process as the main process.  This
          option    is    passed    to   ffffsssspppp2222lllloooottttoooossss(LOCAL).    See
          ffffsssspppp2222lllloooottttoooossss(LOCAL) for more information.

     ----ssssiiiilllleeeennnntttt
          Execute   silently.    This   option   is   passed   to
          eeeexxxxpppp....ooooppppeeeennnn(LOCAL)  and  ssssvvvvllll(LOCAL).   See eeeexxxxpppp....ooooppppeeeennnn(LOCAL)
          and ssssvvvvllll(LOCAL) for more information.

     ----vvvveeeerrrrbbbboooosssseeee
          Report activities and progress,  including  errors  and
          messages  emitted  by  auxiliary  tools,  to the user's
          screen.  This option is passed to  eeeexxxxpppp....ooooppppeeeennnn(LOCAL)  and
          ssssvvvvllll(LOCAL).   See  eeeexxxxpppp....ooooppppeeeennnn(LOCAL)  and  ssssvvvvllll(LOCAL) for



(C) INRIA            Last change: 2019/01/13                    1






CADP MANUAL PAGES                                 FSP.OPEN(LOCAL)



          more information.

     ----vvvveeeerrrrssssiiiioooonnnn
          Display the  version  number  of  ffffsssspppp2222lllloooottttoooossss(LOCAL)  and
          stop.


     _e_x_p__o_p_t_i_o_n_s
          if any, are passed to eeeexxxxpppp....ooooppppeeeennnn(LOCAL).

     _c_c__o_p_t_i_o_n_s
          if any, are passed to the C compiler.

     _p_r_o_g__o_p_t_i_o_n_s
          if any, are passed to _p_r_o_g.


OOOOPPPPEEEERRRRAAAANNNNDDDDSSSS
     _f_i_l_e_n_a_m_e....llllttttssss        FSP specification (input)
     _p_r_o_g....aaaa              exploration module (archive, input)
     _p_r_o_g....cccc              exploration module (source, input)
     _p_r_o_g....oooo              exploration module (object code, input)
     _p_r_o_g                executable program (output)

FFFFIIIILLLLEEEESSSS
     $$$$CCCCAAAADDDDPPPP____TTTTMMMMPPPP////ffffsssspppp....****     temporary files
     $$$$CCCCAAAADDDDPPPP////lllliiiibbbb////FFFFSSSSPPPP____VVVV1111....lllliiiibbbb
                         FSP predefined library (LOTOS code)
     $$$$CCCCAAAADDDDPPPP////iiiinnnnccccllll////FFFFSSSSPPPP____VVVV1111....hhhh FSP predefined library (C code)

EEEEXXXXIIIITTTT SSSSTTTTAAAATTTTUUUUSSSS
     When the source is erroneous,  error  messages  are  issued.
     Exit status is 0 if everything is alright, 1 otherwise.

AAAAUUUUTTTTHHHHOOOORRRRSSSS
     Remi Herilier and Frederic Lang (INRIA Rhone-Alpes).

SSSSEEEEEEEE AAAALLLLSSSSOOOO
     eeeexxxxpppp(LOCAL), eeeexxxxpppp....ooooppppeeeennnn(LOCAL), ffffsssspppp2222lllloooottttoooossss(LOCAL), lllloooottttoooossss(LOCAL),
     ssssvvvvllll(LOCAL), ssssvvvvllll----llllaaaannnngggg(LOCAL)

     Additional information is available from the CADP  Web  page
     located at http://cadp.inria.fr
     Directives   for   installation   are   given    in    files
     $$$$CCCCAAAADDDDPPPP////IIIINNNNSSSSTTTTAAAALLLLLLLLAAAATTTTIIIIOOOONNNN____****....
     Recent  changes  and  improvements  to  this  software   are
     reported and commented in file $$$$CCCCAAAADDDDPPPP////HHHHIIIISSSSTTTTOOOORRRRYYYY....

BBBBUUUUGGGGSSSS
     Please report any bug to cadp@inria.fr





(C) INRIA            Last change: 2019/01/13                    2



