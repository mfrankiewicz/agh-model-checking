


CADP MANUAL PAGES                                   BCG_IO(LOCAL)



NNNNAAAAMMMMEEEE
     bcg_io - convert graphs from and into the BCG format


SSSSYYYYNNNNOOOOPPPPSSSSIIIISSSS
     bbbbccccgggg____iiiioooo [ _b_c_g__o_p_t_i_o_n_s__1 ] [ _i_n_p_u_t__o_p_t_i_o_n_s ] _i_n_p_u_t__f_i_l_e_n_a_m_e  [
     _b_c_g__o_p_t_i_o_n_s__2 ] [ _o_u_t_p_u_t__o_p_t_i_o_n_s ] _o_u_t_p_u_t__f_i_l_e_n_a_m_e


DDDDEEEESSSSCCCCRRRRIIIIPPPPTTTTIIIIOOOONNNN
     This  command  takes  as  input   a   graph   contained   in
     _i_n_p_u_t__f_i_l_e_n_a_m_e   and   generates   as   output  a  graph  in
     _o_u_t_p_u_t__f_i_l_e_n_a_m_e. This command is mostly used to perform for-
     mat   conversion,  in  the  case  where  _i_n_p_u_t__f_i_l_e_n_a_m_e  and
     _o_u_t_p_u_t__f_i_l_e_n_a_m_e are not encoded in the same graph formats.

     The following ``input formats''  are  currently  implemented
     and available for _i_n_p_u_t__f_i_l_e_n_a_m_e:

     - BCG   Binary Coded Graphs format
     - AUT   ALDEBARAN graph format
     - FC2   ESPRIT project CONCUR2 format (INRIA, Sophia)
     - SEQ   CADP common trace format

     The following ``output formats'' are  currently  implemented
     and available for _o_u_t_p_u_t__f_i_l_e_n_a_m_e:

     - BCG         Binary Coded Graphs format
     - ASCII       ASCII dump of the BCG format
     - AUT         ALDEBARAN graph format
     - AUTO        AUTO and MEIJE graph format (INRIA, Sophia)
     - CWB         Concurrency Workbench (LFCS, Edinburgh)
     - ETMCC       Erlangen-Twente Markov Chain Checker
     - FC2         ESPRIT project CONCUR2 format (INRIA, Sophia)
     - GML         Graph Modelling Language (Univ. Passau)
     - GRAPHVIZ    DOT format of the GRAPHVIZ tools (ATT)
     - LOTOS       pseudo-LOTOS format
     - MEC         MEC graph format (LaBRI, Bordeaux)
     - PIPN        PIPN graph format (LAAS, Toulouse)
     - SCAN        SCAN format (BULL)
     - SEQ         CADP common trace format
     - SQUIGGLES   SQUIGGLES graph format (CNUCE, Pisa)
     - VCG         Vizualization of Compiler Graphs (Univ. Saarlandes)
     - VISCOPE     VISCOPE graph format (IRISA, Rennes)
     - XESAR       XESAR graph format (LGI-IMAG, Grenoble)

     Conversions are allowed from any input format into any  out-
     put format.

     When converting from the BCG format into  a  non-BCG  output
     format,  the dynamic library corresponding to _i_n_p_u_t__f_i_l_e_n_a_m_e
     may be generated if necessary.



(C) INRIA            Last change: 2019/01/09                    1






CADP MANUAL PAGES                                   BCG_IO(LOCAL)



     When converting a non-BCG input format into a non-BCG output
     format, a BCG graph and its dynamic library may be generated
     as intermediate forms. This is normally transparent  to  the
     end-user.

     Conversion from an input format to itself are  allowed,  but
     are  useless  except in the case of the BCG format: compres-
     sion parameters (see below) can be modified this way.


GGGGEEEENNNNEEEERRRRAAAALLLL OOOOPPPPTTTTIIIIOOOONNNNSSSS
     Two   groups   of   general   options,   _b_c_g__o_p_t_i_o_n_s__1   and
     _b_c_g__o_p_t_i_o_n_s__2, are currently supported.

     Options _b_c_g__o_p_t_i_o_n_s__1 can appear at  the  beginning  of  the
     command-line. These options are: ----vvvveeeerrrrssssiiiioooonnnn, ----ccccrrrreeeeaaaatttteeee, ----uuuuppppddddaaaatttteeee,
     ----rrrreeeemmmmoooovvvveeee, ----cccccccc, ----ttttmmmmpppp.

     Options _b_c_g__o_p_t_i_o_n_s__2 can appear on the  command-line  after
     _i_n_p_u_t__f_i_l_e_n_a_m_e.  These  options are: ----uuuunnnnccccoooommmmpppprrrreeeessssssss, ----ccccoooommmmpppprrrreeeessssssss,
     ----rrrreeeeggggiiiisssstttteeeerrrr, ----sssshhhhoooorrrrtttt, ----mmmmeeeeddddiiiiuuuummmm, and ----ssssiiiizzzzeeee.

     See the bbbbccccgggg(LOCAL) manual page for a  description  of  these
     options.


PPPPAAAARRRRTTTTIIIICCCCUUUULLLLAAAARRRR OOOOPPPPTTTTIIIIOOOONNNNSSSS
     bbbbccccgggg____iiiioooo is very flexible with respect  to  options  and  file
     suffixes  (i.e.,  file extensions). Options or file suffixes
     can be omitted, provided that there is no ambiguity.  bbbbccccgggg____iiiioooo
     does  its  best to guess the user's intentions and automati-
     cally supplies the missing options and suffixes.

     An option can be omitted iff the file suffix is present and,
     reciprocally, a file suffix can be omitted iff the option is
     present.

     If _i_n_p_u_t__f_i_l_e is equal to ``-'', then it is considered to be
     the  standard  input.  In  such  case,  the  option  must be
     present.

     If _o_u_t_p_u_t__f_i_l_e is equal to ``-'', then it is  considered  to
     be  the  standard  output.  In such case, the option must be
     present.

     Note: if the output option ``-'' is given for producing  the
     BCG,  FC2,  or  XESAR  formats,  the  standard output of the
     bbbbccccgggg____iiiioooo should be a regular file (not a pipe), because  these
     formats  require either that an explicit output file name is
     given (XESAR), or that the file  can  be  accessed  randomly
     using the llllsssseeeeeeeekkkk(2) system call (BCG and FC2).




(C) INRIA            Last change: 2019/01/09                    2






CADP MANUAL PAGES                                   BCG_IO(LOCAL)



     For example, the conversion of an AUT file into a  FC2  file
     is normally done as follows:
        bbbbccccgggg____iiiioooo ----aaaallllddddeeeebbbbaaaarrrraaaannnn _i_n_p_u_t__f_i_l_e....aaaauuuutttt ----ffffcccc2222 _o_u_t_p_u_t__f_i_l_e....ffffcccc2222
     but equivalent synopses are allowed, such as:
        bbbbccccgggg____iiiioooo ----aaaallllddddeeeebbbbaaaarrrraaaannnn _i_n_p_u_t__f_i_l_e ----ffffcccc2222 _o_u_t_p_u_t__f_i_l_e
     or:
        bbbbccccgggg____iiiioooo _i_n_p_u_t__f_i_l_e....aaaauuuutttt _o_u_t_p_u_t__f_i_l_e....ffffcccc2222
     or (assuming that _o_u_t_p_u_t__f_i_l_e....ffffcccc2222 is a regular file):
      bbbbccccgggg____iiiioooo ----aaaallllddddeeeebbbbaaaarrrraaaannnn ---- ----ffffcccc2222 ---- <<<<_i_n_p_u_t__f_i_l_e....aaaauuuutttt >>>>_o_u_t_p_u_t__f_i_l_e....ffffcccc2222

     If _o_u_t_p_u_t__f_i_l_e is omitted and has only its suffix mentioned,
     it is assumed to be equal to _i_n_p_u_t_f_i_l_e. For example:
        bbbbccccgggg____iiiioooo _f_i_l_e_n_a_m_e....aaaauuuutttt ....ffffcccc2222
     is equivalent to:
        bbbbccccgggg____iiiioooo _f_i_l_e_n_a_m_e....aaaauuuutttt _f_i_l_e_n_a_m_e....ffffcccc2222

     If the input and output files are both in BCG format, e.g.:
        bbbbccccgggg____iiiioooo _i_n_p_u_t__f_i_l_e....bbbbccccgggg _o_u_t_p_u_t__f_i_l_e....bbbbccccgggg
     then the input file,  if encoded using an old version of the
     BCG  format,  is systematically converted to the latest ver-
     sion of the BCG format and stored in the output file.

     Finally, uncompressing or compressing a BCG file can be done
     as follows:
        bbbbccccgggg____iiiioooo _i_n_p_u_t__f_i_l_e....bbbbccccgggg ----uuuunnnnccccoooommmmpppprrrreeeessssssss _o_u_t_p_u_t__f_i_l_e....bbbbccccgggg
     or
      bbbbccccgggg____iiiioooo _i_n_p_u_t__f_i_l_e....bbbbccccgggg ----ccccoooommmmpppprrrreeeessssssss ----ssssiiiizzzzeeee 2222 2222 4444 _o_u_t_p_u_t__f_i_l_e....bbbbccccgggg

     The following associations  of  options  and  filenames  are
     currently available, for input and/or output:

     ----bbbbccccgggg _i_n_p_u_t__f_i_l_e_n_a_m_e[....bbbbccccgggg]
          Read _i_n_p_u_t__f_i_l_e_n_a_m_e....bbbbccccgggg encoded in the BCG  graph  for-
          mat.


     -bbbbccccgggg [----ppppaaaarrrrsssseeee |||| ----uuuunnnnppppaaaarrrrsssseeee] _o_u_t_p_u_t__f_i_l_e_n_a_m_e[....bbbbccccgggg]
          Write _o_u_t_p_u_t__f_i_l_e_n_a_m_e....bbbbccccgggg encoded in the BCG graph for-
          mat.   General  options ----uuuunnnnccccoooommmmpppprrrreeeessssssss, ----ccccoooommmmpppprrrreeeessssssss, ----rrrreeeeggggiiiissss----
          tttteeeerrrr, ----sssshhhhoooorrrrtttt, ----mmmmeeeeddddiiiiuuuummmm, and ----ssssiiiizzzzeeee can be used to  control
          the  contents  of  _o_u_t_p_u_t__f_i_l_e_n_a_m_e....bbbbccccgggg.  Options ----ppppaaaarrrrsssseeee
          and ----uuuunnnnppppaaaarrrrsssseeee can be used to control  label  parsing  in
          _o_u_t_p_u_t__f_i_l_e_n_a_m_e....bbbbccccgggg  (see  the  bbbbccccgggg____wwwwrrrriiiitttteeee(LOCAL) manual
          page for a technical discussion about  label  parsing).
          By default, or if option ----ppppaaaarrrrsssseeee is present, label pars-
          ing is enabled.  If option ----uuuunnnnppppaaaarrrrsssseeee is  present,  label
          parsing  is  disabled. If the input file is also in BCG
          format,  options  ----ppppaaaarrrrsssseeee  and  ----uuuunnnnppppaaaarrrrsssseeee  will  have  no
          effect,  as  the  status  of  label parsing used in the
          input    BCG    file    will    be     preserved     in
          _o_u_t_p_u_t__f_i_l_e_n_a_m_e....bbbbccccgggg.




(C) INRIA            Last change: 2019/01/09                    3






CADP MANUAL PAGES                                   BCG_IO(LOCAL)



     -aaaasssscccciiiiiiii [----ssssmmmmaaaallllllll] _o_u_t_p_u_t__f_i_l_e_n_a_m_e[....aaaasssscccciiiiiiii]
          Write _o_u_t_p_u_t__f_i_l_e_n_a_m_e....aaaasssscccciiiiiiii encoded in the  ASCII  dump
          format.   If  option  ----ssssmmmmaaaallllllll is present, do not display
          the contents of the state area, the edge area, and  the
          class area. By default, these areas are displayed.


     ----aaaauuuuttttoooo _o_u_t_p_u_t__f_i_l_e_n_a_m_e[....mmmm0000]
          Write _o_u_t_p_u_t__f_i_l_e_n_a_m_e....mmmm0000 encoded in the AUTO graph for-
          mat.


     -aaaallllddddeeeebbbbaaaarrrraaaannnn _i_n_p_u_t__f_i_l_e_n_a_m_e[....aaaauuuutttt]
          Read _i_n_p_u_t__f_i_l_e_n_a_m_e....aaaauuuutttt encoded in the AUT graph format
          (see  the  aaaauuuutttt(LOCAL)  manual page for a description of
          this format).


     -aaaallllddddeeeebbbbaaaarrrraaaannnn _o_u_t_p_u_t__f_i_l_e_n_a_m_e[....aaaauuuutttt]
          Write _o_u_t_p_u_t__f_i_l_e_n_a_m_e....aaaauuuutttt encoded in the AUT graph for-
          mat.


     ----ccccwwwwbbbb _o_u_t_p_u_t__f_i_l_e_n_a_m_e[....ccccwwwwbbbb]
          Write _o_u_t_p_u_t__f_i_l_e_n_a_m_e....ccccwwwwbbbb encoded in the CWB graph for-
          mat.


     ----eeeettttmmmmcccccccc [----ffffoooorrrrmmmmaaaatttt _f_o_r_m_a_t__s_t_r_i_n_g] _o_u_t_p_u_t__f_i_l_e_n_a_m_e[....ttttrrrraaaa]
          Write _o_u_t_p_u_t__f_i_l_e_n_a_m_e....ttttrrrraaaa encoded in  the  ETMCC  graph
          format.  If option ----ffffoooorrrrmmmmaaaatttt _f_o_r_m_a_t__s_t_r_i_n_g is present, it
          specifies the form under which  floating-point  numbers
          are  printed  to the output file See the bbbbccccgggg____mmmmiiiinnnn(LOCAL)
          and ddddeeeetttteeeerrrrmmmmiiiinnnnaaaattttoooorrrr(LOCAL) manual  pages  for  a  detailed
          description  of  _f_o_r_m_a_t__s_t_r_i_n_g.  By  default,  i.e., if
          option  ----ffffoooorrrrmmmmaaaatttt  is  absent,  the  default   value   of
          _f_o_r_m_a_t__s_t_r_i_n_g is """"%%%%gggg"""".


     ----ffffcccc2222 [----nnnneeeetttt _n_u_m_b_e_r] _i_n_p_u_t__f_i_l_e_n_a_m_e[....ffffcccc2222]
          Read _i_n_p_u_t__f_i_l_e_n_a_m_e....ffffcccc2222 encoded in the FC2  graph  for-
          mat.   If  option  ----nnnneeeetttt  _n_u_m_b_e_r  is present, select the
          _n_u_m_b_e_r-th automaton contained in _i_n_p_u_t__f_i_l_e_n_a_m_e....ffffcccc2222. If
          option  ----nnnneeeetttt  is  not  specified,  _n_u_m_b_e_r  is given the
          default 0.


     ----ffffcccc2222 [----vvvveeeerrrrbbbboooosssseeee] _o_u_t_p_u_t__f_i_l_e_n_a_m_e[....ffffcccc2222]
          Write _o_u_t_p_u_t__f_i_l_e_n_a_m_e....ffffcccc2222 encoded in the FC2 graph for-
          mat.   If  option  ----vvvveeeerrrrbbbboooosssseeee is present, use the verbose
          form of FC2 (by default, the compact  form  of  FC2  is
          used).



(C) INRIA            Last change: 2019/01/09                    4






CADP MANUAL PAGES                                   BCG_IO(LOCAL)



     -ggggmmmmllll _o_u_t_p_u_t__f_i_l_e_n_a_m_e[....ggggmmmmllll]
          Write _o_u_t_p_u_t__f_i_l_e_n_a_m_e....ggggmmmmllll encoded in the GML graph for-
          mat.


     -ggggrrrraaaapppphhhhvvvviiiizzzz _o_u_t_p_u_t__f_i_l_e_n_a_m_e[....ddddooootttt]
          Write _o_u_t_p_u_t__f_i_l_e_n_a_m_e....ddddooootttt encoded in the DOT graph for-
          mat of the GRAPHVIZ tools.


     -lllloooottttoooossss _o_u_t_p_u_t__f_i_l_e_n_a_m_e[....lllloooottttoooossss]
          Write _o_u_t_p_u_t__f_i_l_e_n_a_m_e....lllloooottttoooossss in pseudo-LOTOS format.


     -mmmmeeeecccc _o_u_t_p_u_t__f_i_l_e_n_a_m_e[....mmmmeeeecccc]
          Write _o_u_t_p_u_t__f_i_l_e_n_a_m_e....mmmmeeeecccc encoded in the MEC graph for-
          mat.


     -ppppiiiippppnnnn _o_u_t_p_u_t__f_i_l_e_n_a_m_e[....aaaauuuuttttoooo....pppprrrroooo]
          Write  _o_u_t_p_u_t__f_i_l_e_n_a_m_e....aaaauuuuttttoooo....pppprrrroooo  encoded  in  the  PIPN
          graph format.


     -ssssccccaaaannnn _o_u_t_p_u_t__f_i_l_e_n_a_m_e[....ssssccccaaaannnn]
          Write _o_u_t_p_u_t__f_i_l_e_n_a_m_e....ssssccccaaaannnn encoded in  the  SCAN  graph
          format.


     -sssseeeeqqqquuuueeeennnncccceeee _i_n_p_u_t__f_i_l_e_n_a_m_e[....sssseeeeqqqq]
          Read _i_n_p_u_t__f_i_l_e_n_a_m_e....sssseeeeqqqq encoded in the simple SEQ  for-
          mat  (see  the sssseeeeqqqq(LOCAL) manual page for a description
          of this format).


     -sssseeeeqqqquuuueeeennnncccceeee _o_u_t_p_u_t__f_i_l_e_n_a_m_e[....sssseeeeqqqq]
          Write _o_u_t_p_u_t__f_i_l_e_n_a_m_e....sssseeeeqqqq encoded  in  the  simple  SEQ
          format.   Translating a graph to the SEQ format is only
          possible if the graph has no circuits and  if  all  its
          states  (with  the  possible  exception  of the initial
          state) have at most one outgoing edge.


     -ssssqqqquuuuiiiigggggggglllleeeessss _o_u_t_p_u_t__f_i_l_e_n_a_m_e[....ggggrrrraaaapppphhhh]
          Write _o_u_t_p_u_t__f_i_l_e_n_a_m_e....ggggrrrraaaapppphhhh encoded  in  the  SQUIGGLES
          graph format.


     -vvvvccccgggg _o_u_t_p_u_t__f_i_l_e_n_a_m_e[....vvvvccccgggg]
          Write _o_u_t_p_u_t__f_i_l_e_n_a_m_e....vvvvccccgggg encoded in the VCG graph for-
          mat.




(C) INRIA            Last change: 2019/01/09                    5






CADP MANUAL PAGES                                   BCG_IO(LOCAL)



     -vvvviiiissssccccooooppppeeee _o_u_t_p_u_t__f_i_l_e_n_a_m_e[....ttttrrrraaaannnnssss]
          Write  _o_u_t_p_u_t__f_i_l_e_n_a_m_e....ttttrrrraaaannnnssss  encoded  in  the  VISCOPE
          graph format.


     ----xxxxeeeessssaaaarrrr [----oooolllldddd] _o_u_t_p_u_t__f_i_l_e_n_a_m_e[....ggggrrrraaaa]
          Write _o_u_t_p_u_t__f_i_l_e_n_a_m_e....ggggrrrraaaa encoded in  the  XESAR  graph
          format.   Three  auxiliary  files (_o_u_t_p_u_t__f_i_l_e_n_a_m_e....ddddpppp3333,
          _o_u_t_p_u_t__f_i_l_e_n_a_m_e....ggggeeee3333, and _o_u_t_p_u_t__f_i_l_e_n_a_m_e....ttttaaaaiiii) are  also
          generated.   If  option  ----oooolllldddd  is  present, use the old
          XESAR format (this format is now obsolete and does  not
          work  for  graphs  with  more  than  65536  states). By
          default, the new XESAR format is used.


NNNNOOOOTTTTEEEESSSS
     The letters ``io'' in bbbbccccgggg____iiiioooo stand for input/output.


EEEENNNNVVVVIIIIRRRROOOONNNNMMMMEEEENNNNTTTT VVVVAAAARRRRIIIIAAAABBBBLLLLEEEESSSS
     See the bbbbccccgggg(LOCAL) manual page  for  a  description  of  the
     environment variables used by all the BCG application tools.


EEEEXXXXIIIITTTT SSSSTTTTAAAATTTTUUUUSSSS
     Exit status is 0 if everything is alright, 1 otherwise.


AAAAUUUUTTTTHHHHOOOORRRRSSSS
     Renaud Ruffiot, Hubert Garavel,  Radu  Mateescu,  and  David
     Jacquemin.


AAAACCCCKKKKNNNNOOOOWWWWLLLLEEEEDDDDGGGGEEEEMMMMEEEENNNNTTTTSSSS
     Acknowledgements are due to Patrick Ernberg  (SICS,  Sweden)
     for suggesting a conversion scheme to the CWB format.


OOOOPPPPEEEERRRRAAAANNNNDDDDSSSS
     _f_i_l_e_n_a_m_e....bbbbccccgggg             BCG graph (input or output)
     _f_i_l_e_n_a_m_e@@@@1111....oooo             dynamic library (input or output)
     _f_i_l_e_n_a_m_e....aaaasssscccciiiiiiii           ASCII dump (output)
     _f_i_l_e_n_a_m_e....mmmm0000              AUTO graph (output)
     _f_i_l_e_n_a_m_e....aaaauuuutttt             AUT graph (input or output)
     _f_i_l_e_n_a_m_e....ccccwwwwbbbb             CWB graph (output)
     _f_i_l_e_n_a_m_e....ttttrrrraaaa             ETMCC graph (output)
     _f_i_l_e_n_a_m_e....ffffcccc2222             FC2 graph (input or output)
     _f_i_l_e_n_a_m_e....ggggmmmmllll             GML graph (output)
     _f_i_l_e_n_a_m_e....ddddooootttt             GRAPHVIZ graph (output)
     _f_i_l_e_n_a_m_e....lllloooottttoooossss           pseudo-LOTOS (output)
     _f_i_l_e_n_a_m_e....mmmmeeeecccc             MEC graph (output)
     _f_i_l_e_n_a_m_e....aaaauuuuttttoooo....pppprrrroooo        PIPN graph (output)



(C) INRIA            Last change: 2019/01/09                    6






CADP MANUAL PAGES                                   BCG_IO(LOCAL)



     _f_i_l_e_n_a_m_e....ssssccccaaaannnn            SCAN graph (output)
     _f_i_l_e_n_a_m_e....sssseeeeqqqq             SEQ trace (input or output)
     _f_i_l_e_n_a_m_e....ggggrrrraaaapppphhhh           SQUIGGLES graph (output)
     _f_i_l_e_n_a_m_e....vvvvccccgggg             VCG graph (output)
     _f_i_l_e_n_a_m_e....ttttrrrraaaannnnssss           VISCOPE graph (output)
     _f_i_l_e_n_a_m_e....ggggrrrraaaa             XESAR graph (output)
     _f_i_l_e_n_a_m_e....ddddpppp3333             XESAR graph (output)
     _f_i_l_e_n_a_m_e....ggggeeee3333             XESAR graph (output)
     _f_i_l_e_n_a_m_e....ttttaaaaiiii             XESAR graph (output)


FFFFIIIILLLLEEEESSSS
     $$$$CCCCAAAADDDDPPPP////bbbbiiiinnnn....````aaaarrrrcccchhhh````////bbbbccccgggg____iiiioooo         ``bbbbccccgggg____iiiioooo'' binary program
     $$$$CCCCAAAADDDDPPPP////bbbbiiiinnnn....````aaaarrrrcccchhhh````////lllliiiibbbbBBBBCCCCGGGG____IIIIOOOO....aaaa    ``bbbbccccgggg____iiiioooo'' static library #1
     $$$$CCCCAAAADDDDPPPP////bbbbiiiinnnn....````aaaarrrrcccchhhh````////lllliiiibbbbbbbbccccgggg____iiiiooooddddyyyynnnn....aaaa ``bbbbccccgggg____iiiioooo'' static library #2

     See the bbbbccccgggg(LOCAL) manual page  for  a  description  of  the
     other files.


SSSSEEEEEEEE AAAALLLLSSSSOOOO
     aaaauuuutttt(LOCAL),  bbbbccccgggg(LOCAL),  bbbbccccgggg____mmmmiiiinnnn(LOCAL),  bbbbccccgggg____wwwwrrrriiiitttteeee(LOCAL),
     ddddeeeetttteeeerrrrmmmmiiiinnnnaaaattttoooorrrr(LOCAL), eeeexxxxhhhhiiiibbbbiiiittttoooorrrr(LOCAL), sssseeeeqqqq(LOCAL)


     Additional information is available from the CADP  Web  page
     located at http://cadp.inria.fr

     Directives   for   installation   are   given    in    files
     $$$$CCCCAAAADDDDPPPP////IIIINNNNSSSSTTTTAAAALLLLLLLLAAAATTTTIIIIOOOONNNN____****....

     Recent  changes  and  improvements  to  this  software   are
     reported and commented in file $$$$CCCCAAAADDDDPPPP////HHHHIIIISSSSTTTTOOOORRRRYYYY....


BBBBUUUUGGGGSSSS
     Please report bugs to Hubert.Garavel@inria.fr


















(C) INRIA            Last change: 2019/01/09                    7



