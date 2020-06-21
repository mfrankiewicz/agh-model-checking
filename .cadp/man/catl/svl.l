


CADP MANUAL PAGES                                      SVL(LOCAL)



NNNNAAAAMMMMEEEE
     svl - compilation and execution of SVL scripts


SSSSYYYYNNNNOOOOPPPPSSSSIIIISSSS
     ssssvvvvllll _o_p_t_i_o_n_s [ _f_i_l_e[....ssssvvvvllll] [_s_c_r_i_p_t-_p_a_r_a_m_e_t_e_r_s]]
     ssssvvvvllll -script _o_p_t_i_o_n_s [ _f_i_l_e_1[....ssssvvvvllll] ] [ -output _f_i_l_e_2 ]
     ssssvvvvllll -expand [-case] [-indent _n] [ _f_i_l_e_1[....ssssvvvvllll]  ]]]]  [[[[  ----oooouuuuttttppppuuuutttt
     _f_i_l_e_2 ]]]]
     ssssvvvvllll ----cccclllleeeeaaaannnn [[[[ _f_i_l_e[[[[....ssssvvvvllll]]]] ]]]]
     ssssvvvvllll ----sssswwwweeeeeeeepppp [[[[ _f_i_l_e[[[[....ssssvvvvllll]]]] ]]]]
     ssssvvvvllll ----hhhheeeellllpppp
     ssssvvvvllll ----vvvveeeerrrrssssiiiioooonnnn
     wwwwhhhheeeerrrreeee tttthhhheeee ffffoooolllllllloooowwwwiiiinnnngggg _o_p_t_i_o_n_s aaaarrrreeee aaaavvvvaaaaiiiillllaaaabbbblllleeee::::
     ----ccccaaaasssseeee,,,,  ----ddddeeeebbbbuuuugggg,,,,  ----iiiiggggnnnnoooorrrreeee,,,,  ----sssshhhh   _s_h-_o_p_t_i_o_n_s,,,,   ----ssssiiiilllleeeennnntttt,,,,   ----vvvv
     _v_a_r_i_a_b_l_e====_v_a_l_u_e....


DDDDEEEESSSSCCCCRRRRIIIIPPPPTTTTIIIIOOOONNNN
     In the simplest form (first line of the synopsis), taking as
     input  _f_i_l_e....ssssvvvvllll, which contains a verification script in SVL
     (Script Verification Language), ssssvvvvllll produces actions  invok-
     ing  CADP  tools.   See ssssvvvvllll----llllaaaannnngggg(LOCAL) for a description of
     the SVL language.

     ssssvvvvllll runs a given script through the following steps:

     -    The program is compiled to a Bourne  shell-script  that
          contains  a  sequence of invocations to the appropriate
          CADP tools.

     -    The generated script is executed with optional  _s_c_r_i_p_t-
          _p_a_r_a_m_e_t_e_r_s,  which can be used within the SVL script as
          Bourne shell parameters $1, $2, ...

     -    Finally, the generated script is erased.

     During  script  execution,  several  temporary  intermediate
     files  may  be  created,  and removed as soon as possible in
     order to minimize disk space consumption. ssssvvvvllll also maintains
     a log file named _f_i_l_e....lllloooogggg that contains a full diagnostic of
     the script execution.


CCCCOOOOMMMMMMMMAAAANNNNDDDDSSSS
     ssssvvvvllll can also be used for alternative actions, using the com-
     mands described below:








(C) INRIA            Last change: 2020/02/12                    1






CADP MANUAL PAGES                                      SVL(LOCAL)



     ----ssssccccrrrriiiipppptttt
          Stop after generation of the Bourne  shell  script.  If
          the  parameter  _f_i_l_e_2 is specified, then write the gen-
          erated script to this file. Otherwise display it on the
          standard output.


     ----eeeexxxxppppaaaannnndddd
          Stop after the expansion phase i.e., after  propagating
          meta-operators  inside  expressions.  If  the parameter
          _f_i_l_e_2 is specified, then write the expanded SVL program
          to this file. Otherwise display the expanded program on
          the standard output.


     ----cccclllleeeeaaaannnn
          Remove the generated shell script and all files created
          during  the  latest  execution  of  _f_i_l_e....ssssvvvvllll. Note that
          dynamic libraries of BCG files are erased at  the  same
          time  as  the  BCG  files  themselves,  and  that files
          created by user written shell commands are not removed.
          For  this  command  to  be effective, both _f_i_l_e....lllloooogggg and
          _f_i_l_e....ssssvvvvllll must exist in the current directory.


     ----sssswwwweeeeeeeepppp
          Remove temporary files reminiscent of a run  in  ----ddddeeeebbbbuuuugggg
          mode  (see  options  below). Note that files created by
          user written shell commands are not  removed.  The  log
          file and the output files are not removed either.


     ----hhhheeeellllpppp
          Display the available options of ssssvvvvllll.


     ----vvvveeeerrrrssssiiiioooonnnn
          Display the current version number of ssssvvvvllll.

     Note that _f_i_l_e....ssssvvvvllll (or _f_i_l_e_1....ssssvvvvllll) can be  omitted  if  there
     exists  a  unique  file  with  extension ....ssssvvvvllll in the current
     directory, in which case this  file  is  considered  as  the
     input.


OOOOPPPPTTTTIIIIOOOONNNNSSSS
     The following options are currently available:


     ----ccccaaaasssseeee
          The default behaviour of  ssssvvvvllll  is  to  not  distinguish
          lowercase  and uppercase characters in identifiers that



(C) INRIA            Last change: 2020/02/12                    2






CADP MANUAL PAGES                                      SVL(LOCAL)



          are not enclosed in double quotes (all  characters  are
          turned  to uppercase). The ----ccccaaaasssseeee option forces the dis-
          tinction.


     ----ddddeeeebbbbuuuugggg
          Stop execution has soon as an invoked  tool  returns  a
          non-zero  exit status.  Do not erase intermediate files
          during execution of the generated script,  and  do  not
          erase  the  script  file  after  execution. Use command
          ----sssswwwweeeeeeeepppp or ----cccclllleeeeaaaannnn to erase these files afterwards.


     ----iiiiggggnnnnoooorrrreeee
          Do not stop execution of the script after an  error  is
          issued,  continue  execution  until all instructions of
          the script are executed (possibly with errors).


     ----iiiinnnnddddeeeennnntttt _n
          Set indentation to _n blank characters for expanded  SVL
          script  display (command ----eeeexxxxppppaaaannnndddd).  Default value for _n
          is 3.


     ----sssshhhh _s_h-_o_p_t_i_o_n_s
          Pass _s_h-_o_p_t_i_o_n_s to the Bourne shell interpreter of  the
          generated  script. Note that _s_h-_o_p_t_i_o_n_s must count as a
          single argument, hence  it  may  be  necessary  to  use
          quotes to group several options.


     ----ssssiiiilllleeeennnntttt
          Do not comment actions of the script during  execution.
          This is not a default option.


     ----vvvv _v_a_r_i_a_b_l_e====_v_a_l_u_e
          Add the shell variable definition ``_v_a_r_i_a_b_l_e=_v_a_l_u_e'' to
          the  generated  shell script.  This variable definition
          will occur just after the  inclusion  of  the  ssssttttaaaannnnddddaaaarrrrdddd
          file (see Section ENVIRONMENT VARIABLES below), so that
          the initializations done in ssssttttaaaannnnddddaaaarrrrdddd  cannot  overwrite
          the definition of _v_a_r_i_a_b_l_e.
          Option ----vvvv can be used multiple times on the  same  com-
          mand line.  The corresponding variable definitions will
          then occur in the generated shell script  in  the  same
          order as they occur on the command line.
          Note that if _v_a_l_u_e contains  shell-interpreted  charac-
          ters  that should be left unchanged by the command-line
          interpreter, then it should either be  written  between
          single  quotes,  or  every  shell-interpreted character



(C) INRIA            Last change: 2020/02/12                    3






CADP MANUAL PAGES                                      SVL(LOCAL)



          should be escaped by a backslash (`\') character.
          See  Section  LOCAL  SHELL  VARIABLES   in   the   ssssvvvvllll----
          llllaaaannnngggg(LOCAL)  manual  page  for  a  complete list of the
          shell variables used by SVL scripts.


EEEENNNNVVVVIIIIRRRROOOONNNNMMMMEEEENNNNTTTT VVVVAAAARRRRIIIIAAAABBBBLLLLEEEESSSS
     The following environment variables are used:


     $$$$CCCCAAAADDDDPPPP
          Needed. This variable contains the  path  of  directory
          where CADP is installed.


     $$$$CCCCAAAADDDDPPPP////ccccoooommmm
          This directory should be put in the $$$$PPPPAAAATTTTHHHH variable.


     $$$$SSSSVVVVLLLL Optional. The first action of the generated  script  is
          to  include the file $$$$CCCCAAAADDDDPPPP////ssssrrrrcccc////ssssvvvvllll////ssssttttaaaannnnddddaaaarrrrdddd, containing
          a list of predefined  shell  functions  and  variables.
          However,  if  the  environment variable SSSSVVVVLLLL is defined,
          the included file is  $$$$SSSSVVVVLLLL////ssssrrrrcccc////ssssvvvvllll////ssssttttaaaannnnddddaaaarrrrdddd.  Moreover,
          the  kernel  program  ssssvvvvllll____kkkkeeeerrrrnnnneeeellll  will  be  searched in
          $$$$SSSSVVVVLLLL////bbbbiiiinnnn....````aaaarrrrcccchhhh```` instead of $$$$CCCCAAAADDDDPPPP////bbbbiiiinnnn....````aaaarrrrcccchhhh````.


EEEEXXXXIIIITTTT SSSSTTTTAAAATTTTUUUUSSSS
     When the source is erroneous,  error  messages  are  issued.
     Exit status is 0 if everything is alright, 1 otherwise.


AAAAUUUUTTTTHHHHOOOORRRRSSSS
     ssssvvvvllll version 2.0 and later: Hubert  Garavel,  Frederic  Lang,
     Marc Herbert.

     ssssvvvvllll versions 1.0 to 1.6 (kept for  internal  use  and  never
     distributed    officially):   Mark   Jorgensen,   Christophe
     Discours, Hubert Garavel.

     The authors owe thanks to Radu Mateescu and Charles  Pecheur
     for  their feedback about ssssvvvvllll 1.* and to Laurent Mounier for
     his useful advices.











(C) INRIA            Last change: 2020/02/12                    4






CADP MANUAL PAGES                                      SVL(LOCAL)



FFFFIIIILLLLEEEESSSS
     The following files  and  extensions  are  handled  by  ssssvvvvllll,
     either  as  inputs,  outputs,  or  as temporary intermediate
     files.
     +--------------+-------------------------+-----+-----+-----+
     |  Extension   |       Description       | In  | Out | Tmp |
     +--------------+-------------------------+-----+-----+-----+
     | ....llllnnnntttt         | LNT program             |  X  |     |     |
     | ....lllloooottttoooossss ....llllooootttt  | LOTOS program           |  X  |     |     |
     | ....llllttttssss         | FSP program             |  X  |     |     |
     | ....aaaauuuutttt         | LTS in AUT format |  X  |  X  |  X  |
     | ....bbbbccccgggg         | LTS in BCG format       |  X  |  X  |  X  |
     | ....ffffcccc2222         | LTS in FC2 format       |  X  |  X  |  X  |
     | ....sssseeeeqqqq         | LTS in sequence format  |  X  |  X  |     |
     | ....eeeexxxxpppp         | network of LTSs         |  X  |  X  |  X  |
     | ....hhhhiiiiddddeeee ....hhhhiiiidddd   | labels to hide          |  X  |     |  X  |
     | ....ccccuuuutttt         | labels to cut           |  X  |     |  X  |
     | ....rrrreeeennnnaaaammmmeeee ....rrrreeeennnn | labels to rename        |  X  |     |  X  |
     | ....ssssyyyynnnncccc        | labels to synchronize   |  X  |     |  X  |
     | ....mmmmccccllll         | temporal logic formula  |  X  |     |     |
     | ....lllloooogggg         | log of execution        |     |  X  |     |
     +--------------+-------------------------+-----+-----+-----+

     Note: ssssvvvvllll generates temporary files in  the  current  direc-
     tory.  To avoid clashes with existing files, file names gen-
     erated by ssssvvvvllll  are  prefixed  with  a  string  of  the  form
     ssssvvvvllll_x_x_x____,  where _x_x_x is a 3 digits number. Hence it is recom-
     mended to avoid naming user files this way.


BBBBIIIIBBBBLLLLIIIIOOOOGGGGRRRRAAAAPPPPHHHHYYYY
     [GL01] Hubert Garavel and Frederic Lang.  SVL:  a  Scripting
     Language  for Compositional Verification.  In Myungchul Kim,
     Byoungmoon Chin, Sungwon Kang, and Danhyung  Lee  (editors),
     Proceedings  of  the 21st International Conference on Formal
     Techniques for Networked and Distributed Systems  FORTE'2001
     (Cheju  Island,  Korea),  IFIP Conference Proceedings volume
     197, pages 377-394, Kluwer,  August  2001.   Available  from
     http://cadp.inria.fr/publications/Garavel-Lang-01.html

     [GLM15] Hubert Garavel, Frederic Lang,  and  Radu  Mateescu.
     Compositional  Verification  of Asynchronous Concurrent Sys-
     tems using CADP.  Acta Informatica, Special Issue on Combin-
     ing  Compositionality  and Concurrency: Part 2, 52(4-5):337-
     392,            2015.             Available             from
     http://cadp.inria.fr/publications/Garavel-Lang-Mateescu-
     15.html

     [KM97] Jean-Pierre Krimm and Laurent Mounier.  Compositional
     State  Space Generation from LOTOS Programs.  In Ed Brinksma
     (editor), Proceedings of TACAS'97 Tools and  Algorithms  for
     the  Construction  and  Analysis  of  Systems (University of



(C) INRIA            Last change: 2020/02/12                    5






CADP MANUAL PAGES                                      SVL(LOCAL)



     Twente, Enschede, The Netherlands), Lecture  Notes  in  Com-
     puter  Science volume 1217, Springer, April 1997.  Available
     from http://cadp.inria.fr/publications/Krimm-Mounier-97.html

     [Lan02] Frederic Lang.  Compositional Verification using SVL
     Scripts.   In  Joost-Pieter Katoen and Perdita Stevens (edi-
     tors), Proceedings of the International Conference on  Tools
     and  Algorithms  for  Construction  and  Analysis of Systems
     TACAS'2002 (Grenoble, France),  Lecture  Notes  in  Computer
     Science  volume  2280,  pages 465-469, Springer, April 2002.
     Available    from    http://cadp.inria.fr/publications/Lang-
     02.html


SSSSEEEEEEEE AAAALLLLSSSSOOOO
     aaaallllddddeeeebbbbaaaarrrraaaannnn(LOCAL),  aaaauuuutttt(LOCAL),  bbbbccccgggg(LOCAL),  bbbbccccgggg____ccccmmmmpppp(LOCAL),
     bbbbccccgggg____ggggrrrraaaapppphhhh(LOCAL),      bbbbccccgggg____iiiioooo(LOCAL),     bbbbccccgggg____llllaaaabbbbeeeellllssss(LOCAL),
     bbbbccccgggg____mmmmiiiinnnn(LOCAL),       bbbbccccgggg____ooooppppeeeennnn(LOCAL),        ccccaaaaeeeessssaaaarrrr(LOCAL),
     ccccaaaaeeeessssaaaarrrr....aaaaddddtttt(LOCAL),                     ccccaaaaeeeessssaaaarrrr____hhhhiiiiddddeeee____1111(LOCAL),
     ccccaaaaeeeessssaaaarrrr____rrrreeeennnnaaaammmmeeee____1111(LOCAL), eeeevvvvaaaalllluuuuaaaattttoooorrrr(LOCAL), eeeevvvvaaaalllluuuuaaaattttoooorrrr3333(LOCAL),
     eeeevvvvaaaalllluuuuaaaattttoooorrrr4444(LOCAL),    eeeevvvvaaaalllluuuuaaaattttoooorrrr5555(LOCAL),   eeeexxxxhhhhiiiibbbbiiiittttoooorrrr(LOCAL),
     eeeexxxxpppp(LOCAL),        eeeexxxxpppp....ooooppppeeeennnn(LOCAL),        ggggeeeennnneeeerrrraaaattttoooorrrr(LOCAL),
     llllnnnntttt....ooooppppeeeennnn(LOCAL), lllloooottttoooossss....ooooppppeeeennnn(LOCAL), mmmmccccllll(LOCAL), mmmmccccllll3333(LOCAL),
     mmmmccccllll4444(LOCAL), mmmmccccllll5555(LOCAL), pppprrrroooojjjjeeeeccccttttoooorrrr(LOCAL), rrrreeeedddduuuuccccttttoooorrrr(LOCAL),
     rrrreeeeggggeeeexxxxpppp(LOCAL), sssseeeeqqqq(LOCAL), sssseeeeqqqq....ooooppppeeeennnn(LOCAL), ssssvvvvllll----llllaaaannnngggg(LOCAL),
     xxxxttttllll(LOCAL), xxxxttttllll----llllaaaannnngggg(LOCAL)

     Directives   for   installation   are   given    in    files
     $$$$CCCCAAAADDDDPPPP////IIIINNNNSSSSTTTTAAAALLLLLLLLAAAATTTTIIIIOOOONNNN____****.

     Recent  changes  and  improvements  to  this  software   are
     reported and commented in file $$$$CCCCAAAADDDDPPPP////HHHHIIIISSSSTTTTOOOORRRRYYYY.


BBBBUUUUGGGGSSSS
     Please report any bug to cadp@inria.fr



















(C) INRIA            Last change: 2020/02/12                    6



