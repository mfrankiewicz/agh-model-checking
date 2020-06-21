


CADP MANUAL PAGES                                EXHIBITOR(LOCAL)



NNNNAAAAMMMMEEEE
     exhibitor - search for execution sequences matching a  given
     pattern


SSSSYYYYNNNNOOOOPPPPSSSSIIIISSSS
     bbbbccccgggg____ooooppppeeeennnn    [_b_c_g__o_p_t]    _s_p_e_c[....bbbbccccgggg]    [_c_c__o_p_t]    eeeexxxxhhhhiiiibbbbiiiittttoooorrrr
     [_e_x_h_i_b_i_t_o_r__o_p_t]

     or:

     eeeexxxxpppp....ooooppppeeeennnn    [_e_x_p__o_p_t]    _s_p_e_c[....eeeexxxxpppp]    [_c_c__o_p_t]    eeeexxxxhhhhiiiibbbbiiiittttoooorrrr
     [_e_x_h_i_b_i_t_o_r__o_p_t]

     or:

     ffffsssspppp....ooooppppeeeennnn    [_f_s_p__o_p_t]    _s_p_e_c[....llllttttssss]    [_c_c__o_p_t]    eeeexxxxhhhhiiiibbbbiiiittttoooorrrr
     [_e_x_h_i_b_i_t_o_r__o_p_t]

     or:

     llllnnnntttt....ooooppppeeeennnn    [_l_n_t__o_p_t]    _s_p_e_c[....llllnnnntttt]    [_c_c__o_p_t]    eeeexxxxhhhhiiiibbbbiiiittttoooorrrr
     [_e_x_h_i_b_i_t_o_r__o_p_t]

     or:

     lllloooottttoooossss....ooooppppeeeennnn  [_l_o_t_o_s__o_p_t]  _s_p_e_c[....lllloooottttoooossss]   [_c_c__o_p_t]   eeeexxxxhhhhiiiibbbbiiiittttoooorrrr
     [_e_x_h_i_b_i_t_o_r__o_p_t]

     or:

     sssseeeeqqqq....ooooppppeeeennnn    [_s_e_q__o_p_t]    _s_p_e_c[....sssseeeeqqqq]    [_c_c__o_p_t]    eeeexxxxhhhhiiiibbbbiiiittttoooorrrr
     [_e_x_h_i_b_i_t_o_r__o_p_t]


DDDDEEEESSSSCCCCRRRRIIIIPPPPTTTTIIIIOOOONNNN
     eeeexxxxhhhhiiiibbbbiiiittttoooorrrr takes two different inputs:


     -    A Labelled Transition System, expressed either as a BCG
          graph  _s_p_e_c....bbbbccccgggg,  a composition expression _s_p_e_c....eeeexxxxpppp, an
          FSP program _s_p_e_c....llllttttssss, a LNT program _s_p_e_c....llllnnnntttt,  a  LOTOS
          program _s_p_e_c....lllloooottttoooossss, or a sequence file _s_p_e_c....sssseeeeqqqq.


     -    A "pattern" (or "goal"), expressed in the full SEQ for-
          mat   described  in  the  sssseeeeqqqq(LOCAL)  manual  page.  By
          default, this pattern is read from the  standard  input
          (under  UNIX,  the  input  stream  should end up with a
          'control-D' character; under  Windows,  it  should  end
          with a 'control-Z' character). Alternately, the pattern
          can be stored in a file, e.g., _f_i_l_e_n_a_m_e....sssseeeeqqqq (the "....sssseeeeqqqq"



(C) INRIA            Last change: 2020/02/12                    1






CADP MANUAL PAGES                                EXHIBITOR(LOCAL)



          suffix  is  not  mandatory, but strongly advisable), in
          which case this file can be passed to eeeexxxxhhhhiiiibbbbiiiittttoooorrrr  (under
          UNIX,  the stream redirection notation "<<<< _f_i_l_e_n_a_m_e....sssseeeeqqqq"
          can be used for this purpose).

     eeeexxxxhhhhiiiibbbbiiiittttoooorrrr performs an  on-the-fly  search  in  the  Labelled
     Transition  System  (LTS),  looking  for execution sequences
     (also called "diagnostic sequences")  that  start  from  the
     initial state and match the specified pattern.


     eeeexxxxhhhhiiiibbbbiiiittttoooorrrr displays on the standard output, in the simple SEQ
     format,  the  diagnostic  sequence(s)  found,  if any. If no
     diagnostic sequence has been found,  eeeexxxxhhhhiiiibbbbiiiittttoooorrrr  displays  an
     empty  result  (this  case is covered by the simple SEQ for-
     mat).


     If the input pattern is empty (which is allowed by the  syn-
     tax of the full SEQ format), eeeexxxxhhhhiiiibbbbiiiittttoooorrrr stops immediately, as
     no diagnostic sequence can be found.


     If the input pattern contains more than  one  sssseeeeqqqquuuueeeennnncccceeee  (see
     the  sssseeeeqqqq(LOCAL)  manual  page  for  details), eeeexxxxhhhhiiiibbbbiiiittttoooorrrr only
     searches for a single one, according to the number  supplied
     with the ----sssseeeeqqqqnnnnoooo option.


     In the CADP toolbox, the SEQ format is the  standard  format
     for  diagnostic sequences. Many CADP tools take their inputs
     and/or deliver their outputs in this format.  Unfortunately,
     such  diagnostic  sequences  are not necessarily as short as
     possible and some information might have  been  lost  (e.g.,
     sequences  of  iiii-transitions  have  been  compacted or elim-
     inated,  the  original  gate  names  corresponding   to   iiii-
     transitions have vanished, etc.).

     In many cases, eeeexxxxhhhhiiiibbbbiiiittttoooorrrr solves these problems  by  allowing
     to  find  the shortest sequence matching a given pattern and
     by providing the source-level  information  which  has  been
     lost.   It is also useful for verification and test purpose,
     because it can search and display automatically an execution
     scenario defined by a given pattern.



SSSSEEEEAAAARRRRCCCCHHHH AAAALLLLGGGGOOOORRRRIIIITTTTHHHHMMMMSSSS
     eeeexxxxhhhhiiiibbbbiiiittttoooorrrr implements two different  search  algorithms,  one
     based  on a breadth-first search (BFS) and another one based
     on a depth-first search (DFS). Both  algorithms  have  their
     own merits. Here is a brief comparison:



(C) INRIA            Last change: 2020/02/12                    2






CADP MANUAL PAGES                                EXHIBITOR(LOCAL)



     -    The BFS algorithm always produces the shortest diagnos-
          tic sequence(s) (if any) that match the given pattern.


     -    The DFS algorithm  does  not  necessarily  produce  the
          shortest  diagnostic  sequence  (because in '*'-groups,
          the states are visited only once).  Moreover,  as  this
          algorithm  is  programmed using a recursive C function,
          eeeexxxxhhhhiiiibbbbiiiittttoooorrrr may abort with a core dump if  the  execution
          stack overflows. In such case, the maximal depth should
          be limited using the ----ddddeeeepppptttthhhh option (see below).

     Two small examples will illustrate the  differences  between
     both algorithms.  Let S be the sequence ''''<<<<uuuunnnnttttiiiillll>>>> """"eeeexxxxiiiitttt""""''''.


     -    Let's consider  the  LTS  corresponding  to  the  LOTOS
          behaviour:
                  LLLL1111;;;; LLLL2222;;;; eeeexxxxiiiitttt [[[[]]]] LLLL3333;;;; eeeexxxxiiiitttt

          The BFS algorithm will find the optimal solution:
                  LLLL3333;;;; eeeexxxxiiiitttt
          in a few steps, whereas the DFS  algorithm  might  very
          well explore entirely the longest path:
                  LLLL1111;;;; LLLL2222;;;; eeeexxxxiiiitttt
          before finding a better solution. Also,  if  there  are
          *-s  in the sequence to be searched and circuits in the
          LTS, the sequence found by the DFS algorithm might  not
          be minimal.


     -    Let's  consider the  LTS  corresponding  to  the  LOTOS
          behaviour:
                  LLLL1111;;;; eeeexxxxiiiitttt |||||||||||| LLLL2222;;;; eeeexxxxiiiitttt |||||||||||| ............ |||||||||||| LLLLnnnn;;;; eeeexxxxiiiitttt

          The DFS algorithm will directly find a solution in  n+1
          steps,  whereas  the BFS will have to explore and store
          all the 2^n possible interleavings of  transitions  LLLL1111,,,,
          ............,,,, LLLLnnnn before finding a solution.


OOOOPPPPTTTTIIIIOOOONNNNSSSS
     The options _b_c_g__o_p_t, if any, are passed to bbbbccccgggg____lllliiiibbbb(LOCAL).


     The options _e_x_p__o_p_t, if any, are passed to eeeexxxxpppp....ooooppppeeeennnn(LOCAL).


     The options _f_s_p__o_p_t, if any, are passed to ffffsssspppp....ooooppppeeeennnn(LOCAL).






(C) INRIA            Last change: 2020/02/12                    3






CADP MANUAL PAGES                                EXHIBITOR(LOCAL)



     The options _l_n_t__o_p_t, if any, are passed to llllnnnntttt....ooooppppeeeennnn(LOCAL).


     The options _l_o_t_o_s__o_p_t, if any, are passed  to  ccccaaaaeeeessssaaaarrrr(LOCAL)
     and to ccccaaaaeeeessssaaaarrrr....aaaaddddtttt(LOCAL).


     The options _s_e_q__o_p_t, if any, are passed to sssseeeeqqqq....ooooppppeeeennnn(LOCAL).


     The options _c_c__o_p_t, if any, are passed to the C compiler.

     The following options _e_x_h_i_b_i_t_o_r__o_p_t_i_o_n_s are currently avail-
     able:


     ----sssseeeeqqqqnnnnoooo _n_u_m_b_e_r
          Select the _n_u_m_b_e_r-th sequence in the  input  stream  as
          the  pattern  to  be  searched  for. _n_u_m_b_e_r should be a
          non-zero, positive integer.  It should be less than  or
          equal to the number of sequences contained in the input
          stream.  By  default,  the  first  sequence   will   be
          selected.


     ----ddddeeeepppptttthhhh _d_e_p_t_h
          Consider only execution sequences whose number of tran-
          sitions  is less than or equal to _d_e_p_t_h (where _d_e_p_t_h is
          greater than zero). Prune the exploration of the  graph
          when  the  distance  from  the  initial  state  becomes
          greater than _d_e_p_t_h transitions.  By  default  (if  this
          option  is not present on the command-line) or if _d_e_p_t_h
          is equal to zero, all sequences will be considered.


     ----ccccoooonnnnfffflllliiiicccctttt
          When the search is done, print information about  those
          labels  that  created non-determinism conflicts, solved
          in a deterministic way (see the sssseeeeqqqq(LOCAL) manual  page
          for details). Not a default option.


     ----ccccaaaasssseeee
          Preserve   case-sensitivity   in   the   ssssttttrrrriiiinnnnggggs    and
          rrrreeeegggguuuullllaaaarrrr____eeeexxxxpppprrrreeeessssssssiiiioooonnnns  specified in the input stream. Not
          a default option. By default,  all  lower-case  letters
          contained in ssssttttrrrriiiinnnnggggs and rrrreeeegggguuuullllaaaarrrr____eeeexxxxpppprrrreeeessssssssiiiioooonnnns are turned
          to upper case, except for the  special  gates  """"iiii""""  and
          """"eeeexxxxiiiitttt""""  (see the sssseeeeqqqq(LOCAL) manual page for details).


     ----bbbbffffssss



(C) INRIA            Last change: 2020/02/12                    4






CADP MANUAL PAGES                                EXHIBITOR(LOCAL)



          Use the breadth-first search algorithm. Default option.


     ----ddddffffssss
          Use the depth-first search  algorithm.  Not  a  default
          option.


     ----nnnnoooonnnneeee
          Don't print any  diagnostic  sequence.  Not  a  default
          option.


     ----aaaallllllll
          Print all diagnostic sequences. With the BFS algorithm,
          all  the  printed  sequences are minimal. Not a default
          option.


     ----ffffiiiirrrrsssstttt
          Print the first  diagnostic  sequence  encountered  and
          stop just after. Not a default option for the DFS algo-
          rithm.


     ----ddddeeeeccccrrrr
          For the BFS algorithm:  this  option  is  identical  to
          ----ffffiiiirrrrsssstttt.

          For the DFS  algorithm:  print  only  those  diagnostic
          sequences  which  are  shorter than the last diagnostic
          sequence previously displayed. Prune the exploration of
          the  graph  in  order  to  find diagnostic sequences of
          decreasing sizes. It is not guaranteed that  the  final
          sequence is minimal (some shorter sequence might exist,
          which can not be found by the  DFS  algorithm).  Not  a
          default option for the DFS algorithm.


     _b_y _d_e_f_a_u_l_t
          (in absence of ----nnnnoooonnnneeee, ----aaaallllllll, ----ffffiiiirrrrsssstttt, ----ddddeeeeccccrrrr) For the  BFS
          algorithm: default is identical to ----ffffiiiirrrrsssstttt.

          For the DFS algorithm: print only the shortest diagnos-
          tic  sequence  obtained.  Prune  the exploration of the
          graph in order to find diagnostic sequences of decreas-
          ing sizes. It is not guaranteed that the final sequence
          is minimal (some shorter sequence  might  exist,  which
          can not be found by the program).






(C) INRIA            Last change: 2020/02/12                    5






CADP MANUAL PAGES                                EXHIBITOR(LOCAL)



EEEEXXXXIIIITTTT SSSSTTTTAAAATTTTUUUUSSSS
     When the source is erroneous,  error  messages  are  issued.
     Exit status is 0 if everything is alright, 1 otherwise.


AAAAUUUUTTTTHHHHOOOORRRRSSSS
     Version 1 of  eeeexxxxhhhhiiiibbbbiiiittttoooorrrr  was  developed  by  Hubert  Garavel
     (INRIA Rhone-Alpes).

     Version 2 of eeeexxxxhhhhiiiibbbbiiiittttoooorrrr was developed by Hubert  Garavel  and
     Xavier Etchevers, with the help of Radu Mateescu.


OOOOPPPPEEEERRRRAAAANNNNDDDDSSSS
     _s_p_e_c....bbbbccccgggg            BCG graph (input)
     _s_p_e_c....eeeexxxxpppp            network of communicating LTSs (input)
     _s_p_e_c....llllttttssss            FSP specification (input)
     _s_p_e_c....llllnnnntttt            LNT specification (input)
     _s_p_e_c....lllloooottttoooossss          LOTOS specification (input)
     _s_p_e_c....sssseeeeqqqq            sequence file (input)
     (_s_t_a_n_d_a_r_d _i_n_p_u_t)    pattern in SEQ format (input)

FFFFIIIILLLLEEEESSSS
     The   binary   code   of   eeeexxxxhhhhiiiibbbbiiiittttoooorrrr   is    available    in
     $CADP/bin.`arch`/exhibitor.a

SSSSEEEEEEEE AAAALLLLSSSSOOOO
     OPEN/CAESAR Reference Manual,  bbbbccccgggg(LOCAL),  bbbbccccgggg____ooooppppeeeennnn(LOCAL),
     ccccaaaaeeeessssaaaarrrr(LOCAL),    ccccaaaaeeeessssaaaarrrr....aaaaddddtttt(LOCAL),    ccccaaaaeeeessssaaaarrrr____ggggrrrraaaapppphhhh(LOCAL),
     eeeexxxxpppp(LOCAL),        eeeexxxxpppp....ooooppppeeeennnn(LOCAL),         ffffsssspppp....ooooppppeeeennnn(LOCAL),
     llllnnnntttt....ooooppppeeeennnn(LOCAL),       lllloooottttoooossss(LOCAL),      lllloooottttoooossss....ooooppppeeeennnn(LOCAL),
     sssseeeeqqqq(LOCAL), sssseeeeqqqq....ooooppppeeeennnn(LOCAL)


     Additional information is available from the CADP  Web  page
     located at http://cadp.inria.fr

     Directives   for   installation   are   given    in    files
     $$$$CCCCAAAADDDDPPPP////IIIINNNNSSSSTTTTAAAALLLLLLLLAAAATTTTIIIIOOOONNNN____****....


     Recent  changes  and  improvements  to  this  software   are
     reported and commented in file $$$$CCCCAAAADDDDPPPP////HHHHIIIISSSSTTTTOOOORRRRYYYY....


BBBBUUUUGGGGSSSS
     Please report new bugs to Hubert.Garavel@inria.fr








(C) INRIA            Last change: 2020/02/12                    6



