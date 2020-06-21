


CADP MANUAL PAGES                                PREDICTOR(LOCAL)



NNNNAAAAMMMMEEEE
     predictor - predict the feasability of reachability analysis


SSSSYYYYNNNNOOOOPPPPSSSSIIIISSSS
     bbbbccccgggg____ooooppppeeeennnn [_b_c_g__o_p_t] _s_p_e_c[....bbbbccccgggg] [_c_c__o_p_t] pppprrrreeeeddddiiiiccccttttoooorrrr

     or:

     eeeexxxxpppp....ooooppppeeeennnn [_e_x_p__o_p_t] _s_p_e_c[....eeeexxxxpppp] [_c_c__o_p_t] pppprrrreeeeddddiiiiccccttttoooorrrr

     or:

     ffffsssspppp....ooooppppeeeennnn [_f_s_p__o_p_t] _s_p_e_c[....llllttttssss] [_c_c__o_p_t] pppprrrreeeeddddiiiiccccttttoooorrrr

     or:

     llllnnnntttt....ooooppppeeeennnn [_l_n_t__o_p_t] _s_p_e_c[....llllnnnntttt] [_c_c__o_p_t] pppprrrreeeeddddiiiiccccttttoooorrrr

     or:

     lllloooottttoooossss....ooooppppeeeennnn [_l_o_t_o_s__o_p_t] _s_p_e_c[....lllloooottttoooossss] [_c_c__o_p_t] pppprrrreeeeddddiiiiccccttttoooorrrr

     or:

     sssseeeeqqqq....ooooppppeeeennnn [_s_e_q__o_p_t] _s_p_e_c[....sssseeeeqqqq] [_c_c__o_p_t] pppprrrreeeeddddiiiiccccttttoooorrrr


DDDDEEEESSSSCCCCRRRRIIIIPPPPTTTTIIIIOOOONNNN
     This program gives some  predictive  estimations  concerning
     the  feasability  of reachability analysis for the BCG graph
     _s_p_e_c....bbbbccccgggg, the composition expression _s_p_e_c....eeeexxxxpppp, the FSP  pro-
     gram  _s_p_e_c....llllttttssss,  the LNT program _s_p_e_c....llllnnnntttt, the LOTOS program
     _s_p_e_c....lllloooottttoooossss, or the sequence file _s_p_e_c....sssseeeeqqqq.  It displays:


     -    The state size (in bytes). Notice that this  size  only
          refers  to  the  "static" part of the state vector; the
          "dynamic" part (dynamic data structures such as  lists,
          trees, etc.) cannot be taken into account.


     -    One or several estimations  of  the  amount  of  memory
          available  on  the  current machine. If the environment
          variable $$$$CCCCAAAADDDDPPPP____MMMMEEEEMMMMOOOORRRRYYYY (see  below)  is  set,  then  its
          value  is used. Otherwise, pppprrrreeeeddddiiiiccccttttoooorrrr invokes an auxili-
          ary program named ccccaaaaddddpppp____mmmmeeeemmmmoooorrrryyyy to determine  a  relevant
          value  or, whenever possible, three values of interest:
          (1) the amount of free memory currently available,  (2)
          the  total amount of memory physically installed on the
          current machine, and (3) the sum  of  free  memory  and
          free swap currently available.



(C) INRIA            Last change: 2020/02/12                    1






CADP MANUAL PAGES                                PREDICTOR(LOCAL)



          Notice that  relying  on  the  swap  may  significantly
          decrease the performance of model checking algorithms.


          Also, on 32-bit machines  or  64-bit  machines  running
          processes  in  32-bit mode, these estimations take into
          account the fact that, even if 4  gigabytes  of  memory
          are  physically  available,  only a part of it (e.g., 3
          gigabytes) can be used by application programs.


     -    For each estimation of the amount of memory  available,
          an upper bound on the number of states that can be gen-
          erated exhaustively  (e.g.,  using  "standard"  CAESAR,
          OPEN/CAESAR's Generator, etc.). Notice that this number
          is not merely the quotient  of  the  amount  of  memory
          available  divided by the state size, because auxiliary
          data structures must also be considered.


          Notice, however, that this  number  is  only  an  upper
          bound,  since the amount of memory required for dynamic
          data types, hash tables,  and  other  data  structures,
          etc., is not taken into account.


     Note: the predictor program is not very useful when  applied
     to BCG graphs, since the graph has already been generated.


OOOOPPPPTTTTIIIIOOOONNNNSSSS
     The options _b_c_g__o_p_t, if any, are passed to bbbbccccgggg____lllliiiibbbb(LOCAL).


     The options _e_x_p__o_p_t, if any, are passed to eeeexxxxpppp....ooooppppeeeennnn(LOCAL).


     The options _f_s_p__o_p_t, if any, are passed to ffffsssspppp....ooooppppeeeennnn(LOCAL).


     The options _l_n_t__o_p_t, if any, are passed to llllnnnntttt....ooooppppeeeennnn(LOCAL).


     The options _l_o_t_o_s__o_p_t, if any, are passed  to  ccccaaaaeeeessssaaaarrrr(LOCAL)
     and to ccccaaaaeeeessssaaaarrrr....aaaaddddtttt(LOCAL).


     The options _s_e_q__o_p_t, if any, are passed to sssseeeeqqqq....ooooppppeeeennnn(LOCAL).


     The options _c_c__o_p_t, if any, are passed to the C compiler.




(C) INRIA            Last change: 2020/02/12                    2






CADP MANUAL PAGES                                PREDICTOR(LOCAL)



EEEENNNNVVVVIIIIRRRROOOONNNNMMMMEEEENNNNTTTT VVVVAAAARRRRIIIIAAAABBBBLLLLEEEESSSS
     $$$$CCCCAAAADDDDPPPP____MMMMEEEEMMMMOOOORRRRYYYY
          If this variable is set, its value gives an  estimation
          of  the  amount  of  memory  (in kilobytes) that can be
          allocated by a process on the current machine; if  this
          variable is not set, a default value will be determined
          automatically. See the  $$$$CCCCAAAADDDDPPPP////IIIINNNNSSSSTTTTAAAALLLLLLLLAAAATTTTIIIIOOOONNNN____2222  file  for
          details.


EEEEXXXXIIIITTTT SSSSTTTTAAAATTTTUUUUSSSS
     Exit status is 0 if everything is alright, 1 otherwise.


DDDDIIIIAAAAGGGGNNNNOOOOSSSSTTTTIIIICCCCSSSS
     When the source is erroneous, error messages are issued.


AAAAUUUUTTTTHHHHOOOORRRR
     Hubert Garavel (INRIA Rhone-Alpes)


OOOOPPPPEEEERRRRAAAANNNNDDDDSSSS
     _s_p_e_c....bbbbccccgggg            BCG graph (input)
     _s_p_e_c....eeeexxxxpppp            network of communicating LTSs (input)
     _s_p_e_c....llllttttssss            FSP specification (input)
     _s_p_e_c....llllnnnntttt            LNT specification (input)
     _s_p_e_c....lllloooottttoooossss          LOTOS specification (input)
     _s_p_e_c....sssseeeeqqqq            sequence file (input)


FFFFIIIILLLLEEEESSSS
     The  source  code  of  this  tool  is  available   in   file
     $$$$CCCCAAAADDDDPPPP////ssssrrrrcccc////ooooppppeeeennnn____ccccaaaaeeeessssaaaarrrr////pppprrrreeeeddddiiiiccccttttoooorrrr....cccc

SSSSEEEEEEEE AAAALLLLSSSSOOOO
     OPEN/CAESAR Reference Manual,  bbbbccccgggg(LOCAL),  bbbbccccgggg____ooooppppeeeennnn(LOCAL),
     ccccaaaaeeeessssaaaarrrr(LOCAL),         ccccaaaaeeeessssaaaarrrr....aaaaddddtttt(LOCAL),        eeeexxxxpppp(LOCAL),
     eeeexxxxpppp....ooooppppeeeennnn(LOCAL),      ffffsssspppp....ooooppppeeeennnn(LOCAL),      llllnnnntttt....ooooppppeeeennnn(LOCAL),
     lllloooottttoooossss(LOCAL), lllloooottttoooossss....ooooppppeeeennnn(LOCAL), sssseeeeqqqq(LOCAL), sssseeeeqqqq....ooooppppeeeennnn(LOCAL)


     Additional information is available from the CADP  Web  page
     located at http://cadp.inria.fr


     Directives   for   installation   are   given    in    files
     $$$$CCCCAAAADDDDPPPP////IIIINNNNSSSSTTTTAAAALLLLLLLLAAAATTTTIIIIOOOONNNN____****....

     Recent  changes  and  improvements  to  this  software   are
     reported and commented in file $$$$CCCCAAAADDDDPPPP////HHHHIIIISSSSTTTTOOOORRRRYYYY....




(C) INRIA            Last change: 2020/02/12                    3






CADP MANUAL PAGES                                PREDICTOR(LOCAL)



BBBBUUUUGGGGSSSS
     Please report new bugs to Hubert.Garavel@inria.fr





















































(C) INRIA            Last change: 2020/02/12                    4



