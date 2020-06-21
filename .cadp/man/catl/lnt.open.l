


CADP MANUAL PAGES                                 LNT.OPEN(LOCAL)



NNNNAAAAMMMMEEEE
     lnt.open - OPEN/CAESAR connection for the LNT language


SSSSYYYYNNNNOOOOPPPPSSSSIIIISSSS
     llllnnnntttt....ooooppppeeeennnn [----ddddeeeeppppeeeennnndddd] [----ffffoooorrrrcccceeee] [----rrrrooooooootttt _r_o_o_t-_p_r_o_c_e_s_s] [----ssssiiiilllleeeennnntttt  |
     ----vvvveeeerrrrbbbboooosssseeee]    [----vvvveeeerrrrssssiiiioooonnnn]    [_l_o_t_o_s__o_p_t_i_o_n_s]    _f_i_l_e_n_a_m_e[....llllnnnntttt]
     [_c_c__o_p_t_i_o_n_s] _p_r_o_g[....aaaa|....cccc|....oooo] [_p_r_o_g__o_p_t_i_o_n_s]


DDDDEEEESSSSCCCCRRRRIIIIPPPPTTTTIIIIOOOONNNN
     Taking as input _f_i_l_e_n_a_m_e....llllnnnntttt (which contains  the  principal
     module  of  a  LNT specification) and an OPEN/CAESAR program
     _p_r_o_g[....aaaa|....cccc|....oooo], llllnnnntttt....ooooppppeeeennnn operates as follows:

     -    First, it pre-processes _f_i_l_e_n_a_m_e....llllnnnntttt  and  all  transi-
          tively   imported   modules   using   llllpppppppp(LOCAL).   See
          llllpppppppp(LOCAL) for more information.

     -    Second, it translates the pre-processed LNT  specifica-
          tion  _f_i_l_e_n_a_m_e....llllnnnntttt (including all transitively imported
          modules)   into    a    LOTOS    specification    using
          llllnnnntttt2222lllloooottttoooossss(LOCAL).    See   llllnnnntttt2222lllloooottttoooossss(LOCAL)   for  more
          information.

     -    Third,    it    calls    ``lllloooottttoooossss....ooooppppeeeennnn    _f_i_l_e_n_a_m_e....lllloooottttoooossss
          [_c_c__o_p_t_i_o_n_s]  _p_r_o_g[....aaaa|....cccc|....oooo]  [_p_r_o_g__o_p_t_i_o_n_s]'', passing
          to lllloooottttoooossss....ooooppppeeeennnn (and, transitively, ccccaaaaeeeessssaaaarrrr....aaaaddddtttt  and  ccccaaaaeeee----
          ssssaaaarrrr)  appropriate  options  that  depend on the options
          passed to llllnnnntttt....ooooppppeeeennnn (see below). See  lllloooottttoooossss....ooooppppeeeennnn(LOCAL),
          ccccaaaaeeeessssaaaarrrr....aaaaddddtttt(LOCAL),  and ccccaaaaeeeessssaaaarrrr(LOCAL) for more informa-
          tion.

          However, if _p_r_o_g is the "-" string (instead of the name
          of  an  OPEN/CAESAR application program), llllnnnntttt....ooooppppeeeennnn will
          execute only the first two  steps  (pre-processing  and
          translation  into  a LOTOS specification) and then stop
          without invoking lllloooottttoooossss....ooooppppeeeennnn. In such  case,  the  files
          generated  during  the first two steps are not removed,
          thus allowing the generated LOTOS specification  to  be
          used  for  other  purposes  than OPEN/CAESAR (e.g., for
          rapid prototying with EXEC/CAESAR).


OOOOPPPPTTTTIIIIOOOONNNNSSSS
     -ddddeeeeppppeeeennnndddd
          List  all  the  LNT  files  transitively  included   in
          _f_i_l_e_n_a_m_e....llllnnnntttt and exit. Not a default option.

     ----ffffoooorrrrcccceeee
          Overwrite output files, even if they were edited by the
          user  or  do  not  need  to be updated.  This option is



(C) INRIA            Last change: 2020/02/12                    1






CADP MANUAL PAGES                                 LNT.OPEN(LOCAL)



          passed    to    llllpppppppp(LOCAL),    llllnnnntttt2222lllloooottttoooossss(LOCAL),    and
          lllloooottttoooossss....ooooppppeeeennnn(LOCAL).   See  llllpppppppp(LOCAL), llllnnnntttt2222lllloooottttoooossss(LOCAL),
          and lllloooottttoooossss....ooooppppeeeennnn(LOCAL) for more information.

     -rrrrooooooootttt _p_r_o_c_e_s_s-_i_n_s_t_a_n_t_i_a_t_i_o_n
          Use the process _p_r_o_c_e_s_s-_i_n_s_t_a_n_t_i_a_t_i_o_n as the main  pro-
          cess.  It is an error if the LNT specification does not
          contain  a  corresponding  process  definition.    This
          option    is    passed    to   llllnnnntttt2222lllloooottttoooossss(LOCAL).    See
          llllnnnntttt2222lllloooottttoooossss(LOCAL) for more information.

     ----ssssiiiilllleeeennnntttt
          Execute silently.  This option is passed to llllpppppppp(LOCAL),
          llllnnnntttt2222lllloooottttoooossss(LOCAL),     and    lllloooottttoooossss....ooooppppeeeennnn(LOCAL).     See
          llllpppppppp(LOCAL), llllnnnntttt2222lllloooottttoooossss(LOCAL), and lllloooottttoooossss....ooooppppeeeennnn(LOCAL) for
          more information.

     ----vvvveeeerrrrbbbboooosssseeee
          Report in detail  activities  and  progress,  including
          errors  and messages emitted by auxiliary tools, to the
          user's screen.  This option is  passed  to  llllpppppppp(LOCAL),
          llllnnnntttt2222lllloooottttoooossss(LOCAL),     and    lllloooottttoooossss....ooooppppeeeennnn(LOCAL).     See
          llllpppppppp(LOCAL), llllnnnntttt2222lllloooottttoooossss(LOCAL), and lllloooottttoooossss....ooooppppeeeennnn(LOCAL) for
          more information.

     ----vvvveeeerrrrssssiiiioooonnnn
          Display the  version  number  of  llllnnnntttt2222lllloooottttoooossss(LOCAL)  and
          stop.


     _l_o_t_o_s__o_p_t_i_o_n_s
          if any, are passed to lllloooottttoooossss....ooooppppeeeennnn(LOCAL).

     _c_c__o_p_t_i_o_n_s
          if any, are passed to the C compiler.

     _p_r_o_g__o_p_t_i_o_n_s
          if any, are passed to _p_r_o_g.


OOOOPPPPEEEERRRRAAAANNNNDDDDSSSS
     _f_i_l_e_n_a_m_e....llllnnnntttt        LNT specification (input)
     _f_i_l_e_n_a_m_e....ttttnnnntttt        C code for data types (source, input)
     _f_i_l_e_n_a_m_e....ffffnnnntttt        C code for functions (source, input)
     _f_i_l_e_n_a_m_e....oooo          object code (output)
     _f_i_l_e_n_a_m_e....eeeerrrrrrrr        detailed error messages (output)
     _p_r_o_g....aaaa              exploration module (archive, input)
     _p_r_o_g....cccc              exploration module (source, input)
     _p_r_o_g....oooo              exploration module (object code, input)
     _p_r_o_g                executable program (output)





(C) INRIA            Last change: 2020/02/12                    2






CADP MANUAL PAGES                                 LNT.OPEN(LOCAL)



FFFFIIIILLLLEEEESSSS
     $$$$CCCCAAAADDDDPPPP____TTTTMMMMPPPP////llllnnnntttt....****     temporary files
     $$$$CCCCAAAADDDDPPPP////lllliiiibbbb////LLLLNNNNTTTT____VVVV1111....lllliiiibbbb
                         LNT predefined library (LOTOS code)
     $$$$CCCCAAAADDDDPPPP////iiiinnnnccccllll////LLLLNNNNTTTT____VVVV1111....hhhh LNT predefined library (C code)

EEEEXXXXIIIITTTT SSSSTTTTAAAATTTTUUUUSSSS
     When the source is erroneous,  error  messages  are  issued.
     Exit status is 0 if everything is alright, 1 otherwise.

AAAAUUUUTTTTHHHHOOOORRRRSSSS
     Hubert Garavel, Wendelin Serwe, and  Gideon  Smeding  (INRIA
     Rhone-Alpes).

SSSSEEEEEEEE AAAALLLLSSSSOOOO
     ccccaaaaeeeessssaaaarrrr(LOCAL),       ccccaaaaeeeessssaaaarrrr....aaaaddddtttt(LOCAL),        lllloooottttoooossss(LOCAL),
     lllloooottttoooossss....ooooppppeeeennnn(LOCAL),  llllnnnntttt2222lllloooottttoooossss(LOCAL),  llllpppppppp(LOCAL),  and  the
     "Reference Manual of the LNT to LOTOS Translator"  available
     from   http://cadp.inria.fr/publications/Champelovier-Clerc-
     Garavel-et-al-10.html

     Additional information is available from the CADP  Web  page
     located at http://cadp.inria.fr
     Directives   for   installation   are   given    in    files
     $$$$CCCCAAAADDDDPPPP////IIIINNNNSSSSTTTTAAAALLLLLLLLAAAATTTTIIIIOOOONNNN____****.
     Recent  changes  and  improvements  to  this  software   are
     reported and commented in file $$$$CCCCAAAADDDDPPPP////HHHHIIIISSSSTTTTOOOORRRRYYYY.

BBBBUUUUGGGGSSSS
     Please report any bug to cadp@inria.fr

























(C) INRIA            Last change: 2020/02/12                    3



