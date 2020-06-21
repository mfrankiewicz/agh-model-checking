


CADP MANUAL PAGES                               LOTOS.OPEN(LOCAL)



NNNNAAAAMMMMEEEE
     lotos.open - OPEN/CAESAR connection for the LOTOS language


SSSSYYYYNNNNOOOOPPPPSSSSIIIISSSS
     lllloooottttoooossss....ooooppppeeeennnn [----lllliiiinnnnkkkk|----iiiinnnncccclllluuuuddddeeee]     [_l_o_t_o_s__o_p_t]     _s_p_e_c[....lllloooottttoooossss]
     [_c_c__o_p_t] _p_r_o_g[....aaaa|....cccc|....oooo] [_p_r_o_g__o_p_t]


DDDDEEEESSSSCCCCRRRRIIIIPPPPTTTTIIIIOOOONNNN
     Taking as input a  LOTOS  specification  _s_p_e_c....lllloooottttoooossss  and  an
     OPEN/CAESAR  program _p_r_o_g[....aaaa|....cccc|....oooo], lllloooottttoooossss....ooooppppeeeennnn generates an
     executable program  _p_r_o_g.  To  do  so,  lllloooottttoooossss....ooooppppeeeennnn  performs
     appropriate  calls  to ccccaaaaeeeessssaaaarrrr(LOCAL), ccccaaaaeeeessssaaaarrrr....aaaaddddtttt(LOCAL), and
     the C compiler, avoiding  recompilation  whenever  possible.
     Finally, _p_r_o_g is executed.

     According to the principles of the OPEN/CAESAR architecture,
     _p_r_o_g is obtained by combining three different modules:

     -    the graph module  is  generated  by  ccccaaaaeeeessssaaaarrrr(LOCAL)  for
          _s_p_e_c....lllloooottttoooossss

     -    the storage module is the standard OPEN/CAESAR library

     -    the exploration module is _p_r_o_g[....aaaa|....cccc|....oooo]


PPPPRRRROOOOCCCCEEEESSSSSSSSIIIINNNNGGGG OOOOFFFF TTTTHHHHEEEE GGGGRRRRAAAAPPPPHHHH MMMMOOOODDDDUUUULLLLEEEE
     lllloooottttoooossss....ooooppppeeeennnn automatically invokes ccccaaaaeeeessssaaaarrrr(LOCAL) if the  graph
     module _s_p_e_c....cccc does not exist or is out of date.

     lllloooottttoooossss....ooooppppeeeennnn automatically invokes  ccccaaaaeeeessssaaaarrrr....aaaaddddtttt(LOCAL)  if  the
     abstract  data  type implementation _s_p_e_c....hhhh does not exist or
     is out of date.  However, if _s_p_e_c....hhhh exists and has not  been
     generated  using ccccaaaaeeeessssaaaarrrr....aaaaddddtttt(LOCAL), it will not be overwrit-
     ten, even if it is out of date (in this case, a  warning  is
     issued).

     lllloooottttoooossss....ooooppppeeeennnn takes  into  account  the  dependencies  possibly
     created by _s_p_e_c....cccc, _s_p_e_c....hhhh, _s_p_e_c....tttt, and _s_p_e_c....ffff.


PPPPRRRROOOOCCCCEEEESSSSSSSSIIIINNNNGGGG OOOOFFFF TTTTHHHHEEEE EEEEXXXXPPPPLLLLOOOORRRRAAAATTTTIIIIOOOONNNN MMMMOOOODDDDUUUULLLLEEEE
     The exploration module _p_r_o_g[....aaaa|....cccc|....oooo] is supposed to contain
     an     OPEN/CAESAR     application    program,    such    as
     eeeexxxxhhhhiiiibbbbiiiittttoooorrrr(LOCAL), tttteeeerrrrmmmmiiiinnnnaaaattttoooorrrr(LOCAL), xxxxssssiiiimmmmuuuullllaaaattttoooorrrr(LOCAL)...

     The exploration module can be supplied  in  three  different
     forms. It can be either an archive file (with ....aaaa suffix), or
     a source C program (with ....cccc suffix) or an object  code  file
     (with ....oooo suffix).



(C) INRIA            Last change: 2020/02/12                    1






CADP MANUAL PAGES                               LOTOS.OPEN(LOCAL)



     If  _p_r_o_g....aaaa  is  not  present  in  the   current   directory,
     lllloooottttoooossss....ooooppppeeeennnn  attempts  to  fetch it in the OPEN/CAESAR binary
     library $$$$CCCCAAAADDDDPPPP////bbbbiiiinnnn....````aaaarrrrcccchhhh````....

     If  _p_r_o_g....cccc  is  not  present  in  the   current   directory,
     lllloooottttoooossss....ooooppppeeeennnn  attempts  to  fetch it in the OPEN/CAESAR source
     library $$$$CCCCAAAADDDDPPPP////ssssrrrrcccc////ooooppppeeeennnn____ccccaaaaeeeessssaaaarrrr.

     If  _p_r_o_g....oooo  is  not  present  in  the   current   directory,
     lllloooottttoooossss....ooooppppeeeennnn  attempts  to  fetch it in the OPEN/CAESAR binary
     library $$$$CCCCAAAADDDDPPPP////bbbbiiiinnnn....````aaaarrrrcccchhhh````.

     If no suffix (....aaaa, ....cccc, ....oooo) is specified on the  command  line
     for  the  exploration module _p_r_o_g, lllloooottttoooossss....ooooppppeeeennnn will make suc-
     cessive attempts to fetch this exploration module: first, as
     a  source  C program with ....cccc suffix; then as an archive file
     with ....aaaa suffix; finally as an object code file  with  suffix
     ....oooo.


DDDDEEEETTTTEEEERRRRMMMMIIIINNNNAAAATTTTIIIIOOOONNNN OOOOFFFF IIIINNNNCCCCLLLLUUUUDDDDEEEE OOOORRRR LLLLIIIINNNNKKKK MMMMOOOODDDDEEEE
     If the exploration module  is  in  source  form,  lllloooottttoooossss....ooooppppeeeennnn
     examines  _p_r_o_g....cccc in order to determine automatically whether
     link mode or include mode should be used.

     If the exploration module is in archive form  or  in  object
     code form, only the link mode is allowed.


OOOOPPPPTTTTIIIIOOOONNNNSSSS
     ----iiiinnnncccclllluuuuddddeeee
          Select include mode. Not a default option.


     ----lllliiiinnnnkkkk
          Select link mode. Default option.


     The options _l_o_t_o_s__o_p_t, if any, are passed  to  ccccaaaaeeeessssaaaarrrr(LOCAL)
     and to ccccaaaaeeeessssaaaarrrr....aaaaddddtttt(LOCAL).

     The options _c_c__o_p_t, if any, are passed to the C compiler.

     The options _p_r_o_g__o_p_t if any, are passed to _p_r_o_g.

     Examples:

     lllloooottttoooossss....ooooppppeeeennnn _s_p_e_c....lllloooottttoooossss ----OOOO _p_r_o_g....aaaa
     or
     lllloooottttoooossss....ooooppppeeeennnn _s_p_e_c....lllloooottttoooossss ----OOOO _p_r_o_g....cccc
     or
     lllloooottttoooossss....ooooppppeeeennnn _s_p_e_c....lllloooottttoooossss ----OOOO _p_r_o_g....oooo



(C) INRIA            Last change: 2020/02/12                    2






CADP MANUAL PAGES                               LOTOS.OPEN(LOCAL)



     or
     lllloooottttoooossss....ooooppppeeeennnn ----ccccoooommmmmmmmeeeennnnttttssss ----ggggcccc _s_p_e_c....lllloooottttoooossss _p_r_o_g ----ssssiiiizzzzeeee 1111000000000000


EEEEXXXXIIIITTTT SSSSTTTTAAAATTTTUUUUSSSS
     When the source is erroneous,  error  messages  are  issued.
     Exit status is 0 if everything is alright, 1 otherwise.


AAAAUUUUTTTTHHHHOOOORRRR
     Hubert Garavel (INRIA Rhone-Alpes)


NNNNAAAAMMMMEEEE
     Originally, this command was named  ccccaaaaeeeessssaaaarrrr....ooooppppeeeennnn;  this  name
     was  changed  to  lllloooottttoooossss....ooooppppeeeennnn  in February 2020 for increased
     clarity and consistency.


OOOOPPPPEEEERRRRAAAANNNNDDDDSSSS
     _s_p_e_c....lllloooottttoooossss       LOTOS specification (input)
     _s_p_e_c....hhhh           implementation in C of data types
     _s_p_e_c....tttt           external type C implementation
     _s_p_e_c....ffff           external function C implementation
     _s_p_e_c....cccc            graph   module   gen.   by   CAESAR   from
                      _s_p_e_c....lllloooottttoooossss
     _s_p_e_c....oooo           object code gen. by the C  compiler.   from
                      _s_p_e_c....cccc
     _p_r_o_g....aaaa           exploration module (archive, input)
     _p_r_o_g....cccc           exploration module (source, input)
     _p_r_o_g....oooo           exploration module (object code, input)
     _p_r_o_g             executable program (output)


FFFFIIIILLLLEEEESSSS
     ////ttttmmmmpppp////lllloooottttoooossss....ooooppppeeeennnn....****          temporary files
     $$$$CCCCAAAADDDDPPPP////iiiinnnnccccllll////ccccaaaaeeeessssaaaarrrr____ggggrrrraaaapppphhhh....hhhh  interface of the graph module
     $$$$CCCCAAAADDDDPPPP////iiiinnnnccccllll////ccccaaaaeeeessssaaaarrrr____****....hhhh      interfaces of the storage module
     $$$$CCCCAAAADDDDPPPP////bbbbiiiinnnn....````aaaarrrrcccchhhh````////lllliiiibbbbccccaaaaeeeessssaaaarrrr....aaaa
                                object code of the storage module
     $$$$CCCCAAAADDDDPPPP////ssssrrrrcccc////ooooppppeeeennnn____ccccaaaaeeeessssaaaarrrr////****....cccc  library  of  exploration  modules
                                (source)
     $$$$CCCCAAAADDDDPPPP////bbbbiiiinnnn....````aaaarrrrcccchhhh````////****....aaaa       library  of  exploration  modules
                                (archive)
     $$$$CCCCAAAADDDDPPPP////bbbbiiiinnnn....````aaaarrrrcccchhhh````////****....oooo       library  of  exploration  modules
                                (object code)


SSSSEEEEEEEE AAAALLLLSSSSOOOO
     OPEN/CAESAR      Reference      Manual,       ccccaaaaeeeessssaaaarrrr(LOCAL),
     ccccaaaaeeeessssaaaarrrr....aaaaddddtttt(LOCAL), lllloooottttoooossss(LOCAL)




(C) INRIA            Last change: 2020/02/12                    3






CADP MANUAL PAGES                               LOTOS.OPEN(LOCAL)



     Additional information is available from the CADP  Web  page
     located at http://cadp.inria.fr

     Directives   for   installation   are   given    in    files
     $$$$CCCCAAAADDDDPPPP////IIIINNNNSSSSTTTTAAAALLLLLLLLAAAATTTTIIIIOOOONNNN____****....

     Recent  changes  and  improvements  to  this  software   are
     reported and commented in file $$$$CCCCAAAADDDDPPPP////HHHHIIIISSSSTTTTOOOORRRRYYYY....


BBBBUUUUGGGGSSSS
     Please report new bugs to Hubert.Garavel@inria.fr











































(C) INRIA            Last change: 2020/02/12                    4



