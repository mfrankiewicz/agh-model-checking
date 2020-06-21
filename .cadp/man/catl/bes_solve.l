


CADP MANUAL PAGES                                BES_SOLVE(LOCAL)



NNNNAAAAMMMMEEEE
     bes_solve - resolution of boolean equation systems


SSSSYYYYNNNNOOOOPPPPSSSSIIIISSSS
     bbbbeeeessss____ssssoooollllvvvveeee [_g_e_n_e_r_a_l__o_p_t_i_o_n_s] _i_n_p_u_t[....bbbbeeeessss[._e_x_t]]  [_b_e_s__o_p_t_i_o_n_s]
     [_b_l_o_c_k__o_p_t_i_o_n_s]       [----sssseeeeqqqquuuueeeennnnttttiiiiaaaallll|----ppppaaaarrrraaaalllllllleeeellll      _f_i_l_e[....ggggccccffff]
     [_g_l_o_b_a_l__o_p_t_i_o_n_s] [_i_n_s_t_a_n_c_e__o_p_t_i_o_n_s]]

     or:

     bbbbeeeessss____ssssoooollllvvvveeee  [_g_e_n_e_r_a_l__o_p_t_i_o_n_s]  _i_n_p_u_t[....rrrrbbbbcccc]   [_r_a_n_d_o_m__o_p_t_i_o_n_s]
     [_b_e_s__o_p_t_i_o_n_s]     [_b_l_o_c_k__o_p_t_i_o_n_s]     [----sssseeeeqqqquuuueeeennnnttttiiiiaaaallll|----ppppaaaarrrraaaalllllllleeeellll
     _f_i_l_e[....ggggccccffff] [_g_l_o_b_a_l__o_p_t_i_o_n_s] [_i_n_s_t_a_n_c_e__o_p_t_i_o_n_s]]


DDDDEEEESSSSCCCCRRRRIIIIPPPPTTTTIIIIOOOONNNN
     This program computes the value of one  or  several  boolean
     variables of interest defined in some equation block(s) of a
     Boolean Equation System (BES), by applying an algorithm  for
     local (or on-the-fly) resolution of BESs.  The value of each
     boolean variable of interest (TRUE or FALSE) is displayed on
     the  standard  output.  See the bbbbeeeessss(LOCAL) manual page for a
     definition of Boolean Equation Systems and  their  terminol-
     ogy.


     The resolution is performed using the sequential  algorithms
     provided by the ccccaaaaeeeessssaaaarrrr____ssssoooollllvvvveeee____1111(LOCAL) library of OPEN/CAESAR
     (see the corresponding manual page and the  article  [Mat06]
     for  details).   The  resolution can be also performed using
     the prototype distributed resolution algorithms described in
     [JM05,JM06].   Therefore,  bbbbeeeessss____ssssoooollllvvvveeee  allows to test, cross-
     check, and study the performance of various local BES  reso-
     lution algorithms.


     The BES under resolution can be represented in two different
     forms:

     -    Explicitly, as a textual BES file  _i_n_p_u_t....bbbbeeeessss,  possibly
          compressed  according to the extension ._e_x_t, containing
          all equations of the BES (see ccccaaaaeeeessssaaaarrrr____ssssoooollllvvvveeee____1111(LOCAL) for
          a  description  of  the  ....bbbbeeeessss format).  If the filename
          extension is missing for the _i_n_p_u_t  file,  the  default
          extension is ....bbbbeeeessss.  If present, the extension ._e_x_t must
          correspond to a known file  compression  format  (e.g.,
          ._Z,  ._g_z, ._b_z_2, etc.).  The list of currently supported
          extensions and compression  formats  is  given  by  the
          $$$$CCCCAAAADDDDPPPP////ssssrrrrcccc////ccccoooommmm////ccccaaaaddddpppp____zzzziiiipppp shell-script.

          In this case, bbbbeeeessss____ssssoooollllvvvveeee will first  read  all  the  BES



(C) INRIA            Last change: 2020/02/11                    1






CADP MANUAL PAGES                                BES_SOLVE(LOCAL)



          equations  contained in the _i_n_p_u_t....bbbbeeeessss file, and then it
          will solve the boolean variables  of  interest  on-the-
          fly.

          The BES representation using ....bbbbeeeessss files allows to study
          the  behaviour of local resolution algorithms either on
          (usually small) BESs constructed by hand, or  on  (usu-
          ally   large)  BESs  produced  by  eeeevvvvaaaalllluuuuaaaattttoooorrrr(LOCAL)  or
          bbbbiiiissssiiiimmmmuuuullllaaaattttoooorrrr(LOCAL) as a result of encoding model check-
          ing and equivalence checking problems, respectively.


     -    Implicitly,  as  a  random   BES   configuration   file
          _i_n_p_u_t....rrrrbbbbcccc  containing  various  parameters  allowing to
          generate  randomly  the  equations  of  the  BES   (see
          rrrrbbbbcccc(LOCAL) for a description of the RBC format).

          In this case, bbbbeeeessss____ssssoooollllvvvveeee  will  generate  a  random  BES
          according  to the parameters specified in _i_n_p_u_t....rrrrbbbbcccc and
          solve the variables of interest, both activities  being
          carried out on-the-fly.

          The BES representation using ....rrrrbbbbcccc files provides a very
          compact  encoding  for complex BESs with various forms.
          Moreover, since it consumes very  few  memory  and  CPU
          resources,  random BES generation allows to measure the
          performance  of  resolution  algorithms  accurately  on
          large examples of BESs.


BBBBOOOOOOOOLLLLEEEEAAAANNNN EEEEQQQQUUUUAAAATTTTIIIIOOOONNNN SSSSYYYYSSSSTTTTEEEEMMMMSSSS
     A BES is a collection of N  equation  blocks  having  unique
     numbers  in  the range [0..N-1].  A block is a set of recur-
     sive equations containing boolean variables in  their  left-
     hand  sides and boolean formulas (defined over variables and
     the boolean constants ttttrrrruuuueeee and ffffaaaallllsssseeee)  in  their  right-hand
     sides.


     A variable Xk defined in a block Bi depends upon a  variable
     Xl defined in a block Bj if Xl occurs in the right-hand side
     of the equation defining Xk. A block Bi depends upon a block
     Bj if some variable of Bi depends upon some variable of Bj.


     For further details on BESs, see  the  ccccaaaaeeeessssaaaarrrr____ssssoooollllvvvveeee____1111(LOCAL)
     manual page.


GGGGEEEENNNNEEEERRRRAAAALLLL OOOOPPPPTTTTIIIIOOOONNNNSSSS
     The following options specify various forms of  output,  but
     do not influence the resolution.



(C) INRIA            Last change: 2020/02/11                    2






CADP MANUAL PAGES                                BES_SOLVE(LOCAL)



     ----bbbbeeeessss _o_u_t_p_u_t[....bbbbeeeessss[._e_x_t]]
          If a single variable  of  interest  is  considered  for
          resolution   (see  option  ----vvvvaaaarrrriiiiaaaabbbblllleeee),  print  in  file
          _o_u_t_p_u_t[....bbbbeeeessss] the portion of the BES reachable from that
          variable along variable dependencies.  If several vari-
          ables of interest are considered, for each variable  of
          index  _i defined in the block of index _j, print in file
          _o_u_t_p_u_t__i__j[....bbbbeeeessss] the portion of the BES reachable  from
          that  variable  along  variable  dependencies.   If the
          extension ....bbbbeeeessss._e_x_t is present, the file containing  the
          BES  portion is compressed according to the correspond-
          ing format.  Not a default option.


     ----ddddiiiiaaaagggg _d_i_a_g[....bbbbeeeessss[._e_x_t]]
          If a single variable  of  interest  is  considered  for
          resolution   (see  option  ----vvvvaaaarrrriiiiaaaabbbblllleeee),  print  in  file
          _d_i_a_g[....bbbbeeeessss] a diagnostic (portion of the BES) explaining
          the truth value of that variable.  If several variables
          of interest are considered, for each variable of  index
          _i  defined  in  the  block  of  index  _j, print in file
          _d_i_a_g__i__j[....bbbbeeeessss]  a  diagnostic  (portion  of  the   BES)
          explaining  the  truth  value of that variable.  If the
          extension ....bbbbeeeessss._e_x_t is present, the file containing  the
          diagnostic is compressed according to the corresponding
          format.   This  option  is  mutually   exclusive   with
          ----nnnnoooossssoooollllvvvveeee.  Not a default option.


     -nnnnoooossssoooollllvvvveeee
          Do not perform the resolution of the BES.  This  option
          is  mutually  exclusive  with  ----ddddiiiiaaaagggg.   Not  a  default
          option.


     -ssssiiiilllleeeennnntttt
          Execute silently. Opposite of ----vvvveeeerrrrbbbboooosssseeee. Default option.


     -ssssttttaaaatttt
          Display statistical information about the resolution of
          the BES.  Not a default option.

          Note: The number of boolean variables and  dependencies
          displayed by the ----ssssttttaaaatttt option is generally smaller than
          the number of variables and  dependencies  of  the  BES
          contained  in  the  _o_u_t_p_u_t.bbbbeeeessss  file  created  with the
          ----nnnnoooossssoooollllvvvveeee option.  This is due to the on-the-fly  nature
          of  the  resolution algorithms, which terminate as soon
          as they have determined the value of the  variables  of
          interest.




(C) INRIA            Last change: 2020/02/11                    3






CADP MANUAL PAGES                                BES_SOLVE(LOCAL)



     -vvvveeeerrrrbbbboooosssseeee
          Animate the user's screen, telling what  is  going  on.
          Opposite of ----ssssiiiilllleeeennnntttt. Default option is ----ssssiiiilllleeeennnntttt.


     -vvvveeeerrrrssssiiiioooonnnn
          Display the current version  number  of  the  tool  and
          stop.  To be effective, this option should occur as the
          first argument on the command line. Subsequent  options
          and/or  arguments,  if  any,  will  be discarded. Not a
          default option.


     The following options specify how the resolution is  carried
     out.


     ----sssseeeeqqqquuuueeeennnnttttiiiiaaaallll
          Perform the resolution  of  the  BES  in  a  sequential
          manner,  by applying the resolution algorithms provided
          by the ccccaaaaeeeessssaaaarrrr____ssssoooollllvvvveeee____1111(LOCAL) library.  This  option  is
          mutually exclusive with ----ppppaaaarrrraaaalllllllleeeellll.  Default option.


     ----ppppaaaarrrraaaalllllllleeeellll _f_i_l_e[....ggggccccffff] [_g_l_o_b_a_l__o_p_t_i_o_n_s] [_i_n_s_t_a_n_c_e__o_p_t_i_o_n_s]
          Perform the resolution of  the  BES  in  a  distributed
          manner,  using several machines connected by a network.
          The list  of  these  machines,  together  with  various
          directives tuning the distributed computation, is given
          in the grid  configuration  file  _f_i_l_e[....ggggccccffff]  (see  the
          ddddiiiissssttttrrrriiiibbbbuuuuttttoooorrrr(LOCAL)  manual  page  for details about the
          GCF format).  The lists of options  _g_l_o_b_a_l__o_p_t_i_o_n_s  and
          _i_n_s_t_a_n_c_e__o_p_t_i_o_n_s can be used for last-minute changes to
          the settings of the grid configuration file _f_i_l_e[....ggggccccffff].
          See  the  ddddiiiissssttttrrrriiiibbbbuuuuttttoooorrrr(LOCAL) manual page for a descrip-
          tion  of  these  options.   This  option  is   mutually
          exclusive with ----sssseeeeqqqquuuueeeennnnttttiiiiaaaallll.  Not a default option.


     ----vvvvaaaarrrriiiiaaaabbbblllleeee _v_0 _b_0 ...  _v_n _b_n
          Indicates the indexes _v_0, ..., _v_n of the  variables  of
          interest  and  the  indexes _b_0, ..., _b_n of the equation
          blocks defining those variables (_n >= 0).  The  default
          value  for  _n is 0 (i.e., only one variable of interest
          is considered for resolution) and the default value for
          both _v_0 and _b_0 is 0. If some _b_i is the index of a block
          undefined in the BES, or if some _v_j is the index  of  a
          variable undefined in the block of index _b_j (where 0 <=
          _i, _j <= _n), then an error message  is  issued  and  the
          execution is aborted.  Not a default option.





(C) INRIA            Last change: 2020/02/11                    4






CADP MANUAL PAGES                                BES_SOLVE(LOCAL)



RRRRAAAANNNNDDDDOOOOMMMM,,,, BBBBEEEESSSS,,,, AAAANNNNDDDD BBBBLLLLOOOOCCCCKKKK OOOOPPPPTTTTIIIIOOOONNNNSSSS
     The options _r_a_n_d_o_m__o_p_t_i_o_n_s, _b_e_s__o_p_t_i_o_n_s,  and  _b_l_o_c_k__o_p_t_i_o_n_s
     are described in the rrrrbbbbcccc(LOCAL) manual page.


     When the input is a textual BES  file  _i_n_p_u_t....bbbbeeeessss,  the  only
     directives _b_e_s__o_p_t_i_o_n_s and _b_l_o_c_k__o_p_t_i_o_n_s that have effect on
     the equation blocks of the  BES  are  those  concerning  the
     variables uuuunnnniiiiqqqquuuueeee____rrrreeeessssoooolllluuuuttttiiiioooonnnn and ssssoooollllvvvveeee____mmmmooooddddeeee.


     To provide for last-minute changes, the contents of the  RBC
     file  can  be extended on the command line using the options
     _r_a_n_d_o_m__o_p_t_i_o_n_s, _b_e_s__o_p_t_i_o_n_s,  and  _b_l_o_c_k__o_p_t_i_o_n_s.   The  RBC
     file  can  even  be empty, in which case _i_n_p_u_t....rrrrbbbbcccc should be
     replaced with "-" on the command line.


EEEEXXXXIIIITTTT SSSSTTTTAAAATTTTUUUUSSSS
     Exit status is 0 if everything is alright, 1 otherwise.


DDDDIIIIAAAAGGGGNNNNOOOOSSSSTTTTIIIICCCCSSSS
     When the source is erroneous, error messages are issued.


BBBBIIIIBBBBLLLLIIIIOOOOGGGGRRRRAAAAPPPPHHHHYYYY
     [JM05] Ch. Joubert and R. Mateescu.  Distributed Local Reso-
     lution of Boolean Equation Systems.  In Francisco Tirado and
     Manuel Prieto (Eds.),  Proceedings  of  the  13th  Euromicro
     Conference  on  Parallel, Distributed and Network-Based Pro-
     cessing PDP'2005 (Lugano, Switzerland),  pp.  264-271.  IEEE
     Computer    Society,    February    2005.   Available   from
     http://cadp.inria.fr/publications/Joubert-Mateescu-05.html


     [JM06] Ch. Joubert and R. Mateescu.  Distributed  On-the-Fly
     Model  Checking  and Test Case Generation.  In Antti Valmari
     (Ed.), Proceedings of the  13th  International  Workshop  on
     Model Checking of Software SPIN'2006 (Vienna, Austria), Lec-
     ture Notes in  Computer  Science  vol.  3925,  pp.  126-145.
     Springer   Verlag,   March-April   2006.    Available   from
     http://cadp.inria.fr/publications/Joubert-Mateescu-06.html


     [Mat06] R. Mateescu.  CAESAR_SOLVE: A  Generic  Library  for
     On-the-Fly  Resolution  of Alternation-Free Boolean Equation
     Systems.  Springer International Journal on  Software  Tools
     for Technology Transfer (STTT), v. 8, no. 1, p. 37-56, 2006.
     Full version available as  INRIA  Research  Report  RR-5948.
     Available  from  http://cadp.inria.fr/publications/Mateescu-
     06-a.html



(C) INRIA            Last change: 2020/02/11                    5






CADP MANUAL PAGES                                BES_SOLVE(LOCAL)



AAAAUUUUTTTTHHHHOOOORRRRSSSS
     A prototype version of bbbbeeeessss____ssssoooollllvvvveeee was developed by Christophe
     Joubert and subsequently enhanced by Jerome Fereyre (both at
     INRIA/VASY).


     Version 1.0 of bbbbeeeessss____ssssoooollllvvvveeee was entirely  rewritten  and  docu-
     mented  by  Radu Mateescu (INRIA/VASY), who also defined and
     implemented the RBC file format.


     The option ----ppppaaaarrrraaaalllllllleeeellll invokes the distributed BES  resolution
     algorithm  proposed  in  [JM06].  The implementation of this
     algorithm was a long-term effort  carried  out  (chronologi-
     cally)   by   Christophe  Joubert,  Jerome  Fereyre,  Hubert
     Garavel, Remi Herilier, Wendelin Serwe, Iker  Bellicot,  and
     Radu Mateescu.


OOOOPPPPEEEERRRRAAAANNNNDDDDSSSS
     _i_n_p_u_t....rrrrbbbbcccc           random BES configuration file (input)
     _i_n_p_u_t....bbbbeeeessss[[[[....eeeexxxxtttt]]]]     BES text file (input)
     _o_u_t_p_u_t....bbbbeeeessss[[[[....eeeexxxxtttt]]]]    BES text file (output)
     _d_i_a_g....bbbbeeeessss[[[[....eeeexxxxtttt]]]]      diagnostic BES text file (output)


FFFFIIIILLLLEEEESSSS
     The   binary   code   of   bbbbeeeessss____ssssoooollllvvvveeee   is    available    in
     $CADP/bin.`arch`/bes_solve


     See the ccccaaaaeeeessssaaaarrrr____ssssoooollllvvvveeee____1111(LOCAL) manual page for a  description
     of the ....bbbbeeeessss files.


SSSSEEEEEEEE AAAALLLLSSSSOOOO
     OPEN/CAESAR       Reference       Manual,        bbbbeeeessss(LOCAL),
     bbbbiiiissssiiiimmmmuuuullllaaaattttoooorrrr(LOCAL), ccccaaaaeeeessssaaaarrrr____ssssoooollllvvvveeee____1111(LOCAL), eeeevvvvaaaalllluuuuaaaattttoooorrrr(LOCAL),
     lllloooottttoooossss....ooooppppeeeennnn(LOCAL), rrrrbbbbcccc(LOCAL)


     Additional information is available from the CADP  Web  page
     located at http://cadp.inria.fr

     Directives   for   installation   are   given    in    files
     $$$$CCCCAAAADDDDPPPP////IIIINNNNSSSSTTTTAAAALLLLLLLLAAAATTTTIIIIOOOONNNN____****....

     Recent  changes  and  improvements  to  this  software   are
     reported and commented in file $$$$CCCCAAAADDDDPPPP////HHHHIIIISSSSTTTTOOOORRRRYYYY....






(C) INRIA            Last change: 2020/02/11                    6






CADP MANUAL PAGES                                BES_SOLVE(LOCAL)



BBBBUUUUGGGGSSSS
     Please report bugs to Radu.Mateescu@inria.fr.





















































(C) INRIA            Last change: 2020/02/11                    7



