


CADP MANUAL PAGES                                      RBC(LOCAL)



NNNNAAAAMMMMEEEE
     rbc, RBC - textual file format for random BES (Boolean Equa-
     tion Systems) configuration


DDDDEEEESSSSCCCCRRRRIIIIPPPPTTTTIIIIOOOONNNN
     An RBC (Random BES Configuration) file  _f_i_l_e_n_a_m_e....rrrrbbbbcccc  speci-
     fies  a  set of parameters controlling the random generation
     of a Boolean  Equation  System  (BES).  See  the  bbbbeeeessss(LOCAL)
     manual page for a definition of Boolean Equation Systems and
     their terminology.


     The BES specified by the  RBC  file  can  be  generated  and
     solved  on  the  fly  using the bbbbeeeessss____ssssoooollllvvvveeee(LOCAL) tool, which
     computes the value of one or several  boolean  variables  of
     interest defined in some equation block(s) of the BES.


SSSSYYYYNNNNTTTTAAAAXXXX OOOOFFFF TTTTHHHHEEEE RRRRBBBBCCCC FFFFOOOORRRRMMMMAAAATTTT
     The format of _f_i_l_e_n_a_m_e....rrrrbbbbcccc is defined by the  following  BNF
     grammar:

        <rbc>              ::= <random_options>
                               <bes_options>
                               <block_options>*
        <random_options>   ::= <random_directive>*
        <random_directive> ::= <random_variable> "=" <value> "\n"
        <random_variable>  ::= "number_of_blocks"
                            |  "alternation_free"
                            |  "strategy"
        <bes_options>      ::= <directive>*
        <block_options>    ::= <block_set>+ <directive>*
        <block_set>        ::= <interval>+ "\n"
        <interval>         ::= <block_index>
                            |  "["<block_index>".."<block_index>"]"
        <directive>        ::= <variable> "=" <value> "\n"
        <variable>         ::= "sign"
                            |  "unique_resolution"
                            |  "solve_mode"
                            |  "number_of_variables"
                            |  "equation_length"
                            |  "variable_ratio"
                            |  "local_variable_ratio"
                            |  "or_variable_ratio"
                            |  "or_variable_alternation"
                            |  "false_constant_ratio"
                            |  "shape"
        <value>            ::= <character-string>






(C) INRIA            Last change: 2020/02/11                    1






CADP MANUAL PAGES                                      RBC(LOCAL)



     where:


     -    <<<<rrrraaaannnnddddoooommmm____ooooppppttttiiiioooonnnnssss>>>> is a (possibly empty) list  of  direc-
          tives applicable to the BES.


     -    <<<<bbbbeeeessss____ooooppppttttiiiioooonnnnssss>>>> is a (possibly empty) list of  directives
          applicable to every equation block of the BES.


     -    <<<<bbbblllloooocccckkkk____ooooppppttttiiiioooonnnnssss>>>> defines a set of block indexes together
          with  a  (possibly empty) list of directives applicable
          to these blocks exclusively.


     -    <<<<iiiinnnntttteeeerrrrvvvvaaaallll>>>> is an interval on natural numbers denoting a
          set  of  indexes  of  equation  blocks  of  the BES. An
          <<<<iiiinnnntttteeeerrrrvvvvaaaallll>>>> can contain either a single index  specified
          as <<<<bbbblllloooocccckkkk____iiiinnnnddddeeeexxxx>>>>, or a range of block indexes specified
          as "[[[["<<<<bbbblllloooocccckkkk____iiiinnnnddddeeeexxxx>>>>".."<<<<bbbblllloooocccckkkk____iiiinnnnddddeeeexxxx>>>>"]]]]".


     -    <<<<bbbblllloooocccckkkk____iiiinnnnddddeeeexxxx>>>> is a natural number denoting the index of
          an equation block of the BES.


     -    <<<<rrrraaaannnnddddoooommmm____ddddiiiirrrreeeeccccttttiiiivvvveeee>>>> (resp. <<<<ddddiiiirrrreeeeccccttttiiiivvvveeee>>>>) is an assignment
          of  a  <<<<vvvvaaaalllluuuueeee>>>>  to  a <<<<rrrraaaannnnddddoooommmm____vvvvaaaarrrriiiiaaaabbbblllleeee>>>> (resp. a <<<<vvvvaaaarrrriiii----
          aaaabbbblllleeee>>>>), followed by a newline character.


     Any line starting with the "#" character is considered as  a
     comment  and ignored. Spaces and tabulations can be inserted
     before, between, or after terminal symbols.


SSSSEEEEMMMMAAAANNNNTTTTIIIICCCCSSSS OOOOFFFF TTTTHHHHEEEE RRRRBBBBCCCC FFFFOOOORRRRMMMMAAAATTTT
     Variables can be modified by directives as  follows.  First,
     all  variables  have  a  default  value,  which will be used
     unless overriden by some  directive.   A  <<<<rrrraaaannnnddddoooommmm____ddddiiiirrrreeeeccccttttiiiivvvveeee>>>>
     occurring   in   the   <<<<rrrraaaannnnddddoooommmm____ooooppppttttiiiioooonnnnssss>>>>   list   assigns   a
     <<<<rrrraaaannnnddddoooommmm____vvvvaaaarrrriiiiaaaabbbblllleeee>>>> associated  to  the  BES.   A  <<<<ddddiiiirrrreeeeccccttttiiiivvvveeee>>>>
     occurring  in  the <<<<bbbbeeeessss____ooooppppttttiiiioooonnnnssss>>>> list assigns its <<<<vvvvaaaarrrriiiiaaaabbbblllleeee>>>>
     for all equation blocks of the BES. A <<<<ddddiiiirrrreeeeccccttttiiiivvvveeee>>>>  occurring
     in  a  <<<<bbbblllloooocccckkkk____ooooppppttttiiiioooonnnnssss>>>>  list assigns its <<<<vvvvaaaarrrriiiiaaaabbbblllleeee>>>> only for
     the blocks mentioned in this <<<<bbbblllloooocccckkkk____ooooppppttttiiiioooonnnnssss>>>>, possibly over-
     riding  the  value  specified  for  this  <<<<vvvvaaaarrrriiiiaaaabbbblllleeee>>>>  in the
     <<<<bbbbeeeessss____ooooppppttttiiiioooonnnnssss>>>> list.  If  a  variable  is  assigned  multiple
     times,  the  value  assigned by the last directive overrides
     the previous ones.




(C) INRIA            Last change: 2020/02/11                    2






CADP MANUAL PAGES                                      RBC(LOCAL)



     The meaning of the different <<<<rrrraaaannnnddddoooommmm____vvvvaaaarrrriiiiaaaabbbblllleeee>>>>s is the  fol-
     lowing:


     nnnnuuuummmmbbbbeeeerrrr____ooooffff____bbbblllloooocccckkkkssss
          This variable specifies the number  N  of  blocks  con-
          tained  in the BES.  N must be greater than 0.  Default
          value is 1.

          Note: Due to the hazard of random generation, it is not
          guaranteed that all block indexes in the range [0..N-1]
          will be present in the BES.


     aaaalllltttteeeerrrrnnnnaaaattttiiiioooonnnn____ffffrrrreeeeeeee
          This   variable   indicates   whether   the   BES    is
          alternation-free  (value  ttttrrrruuuueeee)  or  not (value ffffaaaallllsssseeee).
          Default value is ttttrrrruuuueeee.

          Note: The current version of the  ccccaaaaeeeessssaaaarrrr____ssssoooollllvvvveeee____1111(LOCAL)
          library  handles only alternation-free BESs. Therefore,
          specifying the  value  ffffaaaallllsssseeee  for  this  variable  will
          trigger  error  messages issued by the resolution algo-
          rithms, which detect the presence of  cyclic  dependen-
          cies between blocks.


     ssssttttrrrraaaatttteeeeggggyyyy
          This variable specifies the value of the seed  initial-
          izing  the  random number generator used for generating
          the BES. The value 0 means that an  arbitrary  seed  is
          chosen  automatically  at  each  execution  of the tool
          (nondeterministic case). A value greater than 0 is used
          as  the  seed,  which will entail the generation of the
          same BES at each execution of the  tool  (deterministic
          case).  Default value is 1.


     The meaning of the different <<<<vvvvaaaarrrriiiiaaaabbbblllleeee>>>>s is the following:


     ssssiiiiggggnnnn This variable specifies the probability (given in  per-
          cent,  as  a  natural  number in the interval [0..100])
          that the sign of the current block is  mmmmuuuu  rather  than
          nnnnuuuu.  A  value of 0 (resp. 100) will fix the sign of the
          block to nnnnuuuu (resp. mmmmuuuu).  Default value is 50.


     uuuunnnniiiiqqqquuuueeee____rrrreeeessssoooolllluuuuttttiiiioooonnnn
          This variable indicates whether the current block  will
          be  solved  only  once  (value  ttttrrrruuuueeee)  or several times
          (value ffffaaaallllsssseeee).  Default value is ffffaaaallllsssseeee.



(C) INRIA            Last change: 2020/02/11                    3






CADP MANUAL PAGES                                      RBC(LOCAL)



          Note: Setting this variable in the _b_e_s__o_p_t_i_o_n_s  section
          of  the command line will also act on a BES provided as
          a file _i_n_p_u_t.bbbbeeeessss.  For technical reasons, if this vari-
          able  is  set  on the command line for a set _L of block
          indexes, all  the  remaining  blocks  of  the  BES  (of
          indexes not belonging to _L) will have this variable set
          to  the  default  value  ffffaaaallllsssseeee.  If  another  value  is
          required  for  the remaining blocks, this may be speci-
          fied either using additional  uuuunnnniiiiqqqquuuueeee____rrrreeeessssoooolllluuuuttttiiiioooonnnn  direc-
          tives on the command line, or by explicitly editing the
          _i_n_p_u_t.bbbbeeeessss file.


     ssssoooollllvvvveeee____mmmmooooddddeeee
          This variable specifies the  index  of  the  resolution
          algorithm  (see  the ccccaaaaeeeessssaaaarrrr____ssssoooollllvvvveeee____1111(LOCAL) manual page)
          used for  solving  boolean  variables  defined  in  the
          current block.  Default value is 0.

          Note: Setting this variable in the _b_e_s__o_p_t_i_o_n_s  section
          of  the command line will also act on a BES provided as
          a file _i_n_p_u_t.bbbbeeeessss.  For technical reasons, if this vari-
          able  is  set  on the command line for a set _L of block
          indexes, all  the  remaining  blocks  of  the  BES  (of
          indexes  not  belonging  to _L) will be solved using the
          default resolution algorithm 0. If  another  resolution
          algorithm  is  required  for the remaining blocks, this
          may be specified  either  using  additional  ssssoooollllvvvveeee____mmmmooooddddeeee
          directives  on the command line, or by explicitly edit-
          ing the _i_n_p_u_t.bbbbeeeessss file.

          Note: If the value set  to  this  variable  denotes  an
          unexisting  resolution  algorithm  (e.g., 100), then an
          error message is issued and the execution is aborted.


     nnnnuuuummmmbbbbeeeerrrr____ooooffff____vvvvaaaarrrriiiiaaaabbbblllleeeessss
          This variable specifies the number M of  boolean  vari-
          ables  that  may be defined in the current block (i.e.,
          that may occur in the left-hand side  of  equations  of
          the block). M must be greater than 0.  Default value is
          1.

          Note: Due to the hazard of random generation, it is not
          guaranteed  that  all  variable  indexes  in  the range
          [0..M-1] will be defined by equations of the block.


     eeeeqqqquuuuaaaattttiiiioooonnnn____lllleeeennnnggggtttthhhh
          This variable specifies the maximum length L (number of
          operands)  of  the  boolean  formulas  occurring in the
          right-hand sides of equations of the current  block.  L



(C) INRIA            Last change: 2020/02/11                    4






CADP MANUAL PAGES                                      RBC(LOCAL)



          must  be  greater  than 0. The length of the right-hand
          side of an equation will  be  chosen  randomly  in  the
          interval [1..L].  Default value is 1.


     vvvvaaaarrrriiiiaaaabbbblllleeee____rrrraaaattttiiiioooo
          This variable specifies the percentage (natural  number
          in  the  interval  [0..100]) of boolean variables among
          the operands in the right-hand sides  of  equations  of
          the  current  block (the remaining operands are boolean
          constants).  Default value is 50.


     llllooooccccaaaallll____vvvvaaaarrrriiiiaaaabbbblllleeee____rrrraaaattttiiiioooo
          This variable specifies the percentage (natural  number
          in  the  interval  [0..100])  of local variables (i.e.,
          defined in the current block) among  the  variables  in
          the  right-hand sides of equations of the current block
          (the remaining variables are defined in other  blocks).
          In   an  alternation-free  BES  containing  N  equation
          blocks, this variable must be set to 100 for the  block
          of index N-1, since this block does not depend upon any
          other blocks of  the  BES.   Default  value  is  chosen
          automatically  such that the variables occurring in the
          right-hand sides of equations are randomly spread  over
          the blocks of the BES.


     oooorrrr____vvvvaaaarrrriiiiaaaabbbblllleeee____rrrraaaattttiiiioooo
          This variable specifies the percentage (natural  number
          in  the interval [0..100]) of disjunctive boolean vari-
          ables among the local variables in the right-hand sides
          of  equations of the current block (the remaining local
          variables in the right-hand sides of equations are con-
          junctive). Due to the way equations are generated, this
          variable will also correspond to the percentage of dis-
          junctive  boolean  variables occurring in the left-hand
          sides of equations of the current block.  Default value
          is 50.


     oooorrrr____vvvvaaaarrrriiiiaaaabbbblllleeee____aaaalllltttteeeerrrrnnnnaaaattttiiiioooonnnn
          This   variable   modifies   the   interpretation    of
          oooorrrr____vvvvaaaarrrriiiiaaaabbbblllleeee____rrrraaaattttiiiioooo   according  to  the  binary  boolean
          operators occurring in  the  right-hand  sides  of  the
          equations  of  the  current block.  If this variable is
          set to ttttrrrruuuueeee, then all local variables occuring  in  the
          right-hand  sides of purely disjunctive (resp. conjunc-
          tive) equations are forced  to  be  conjunctive  (resp.
          disjunctive).  Said  differently, the type of variables
          must strictly alternate between the left-hand side  and
          the  right-hand  side  of  each  equation. However, the



(C) INRIA            Last change: 2020/02/11                    5






CADP MANUAL PAGES                                      RBC(LOCAL)



          total percentage of disjunctive  boolean  variables  in
          all   right-hand   sides   of  equations  will  roughly
          correspond to the value of oooorrrr____vvvvaaaarrrriiiiaaaabbbblllleeee____rrrraaaattttiiiioooo.  If  this
          variable  is  set to ffffaaaallllsssseeee, then the amount of disjunc-
          tive variables among the local variables  occurring  in
          the  right-hand  side  of  each  equation is determined
          according to the value of  oooorrrr____vvvvaaaarrrriiiiaaaabbbblllleeee____rrrraaaattttiiiioooo.   Default
          value is ffffaaaallllsssseeee.


     ffffaaaallllsssseeee____ccccoooonnnnssssttttaaaannnntttt____rrrraaaattttiiiioooo
          This variable specifies the percentage (natural  number
          in  the interval [0..100]) of ffffaaaallllsssseeee among the constants
          in the right-hand sides of  equations  of  the  current
          block  (the  remaining  constants  are  ttttrrrruuuueeee).  Default
          value is 50.


     sssshhhhaaaappppeeee
          This variable specifies the shape of the current block,
          i.e., the structure of the dependency graph between the
          boolean  variables  defined  in  the  block  (see   the
          ccccaaaaeeeessssaaaarrrr____ssssoooollllvvvveeee____1111(LOCAL)   manual  page).   The  following
          values are available for this variable:  ggggeeeennnneeeerrrraaaallll  indi-
          cates  no constraint on dependencies; aaaaccccyyyycccclllliiiicccc indicates
          the absence of cyclic dependencies; ddddiiiissssjjjjuuuunnnnccccttttiiiivvvveeee  (resp.
          ccccoooonnnnjjjjuuuunnnnccccttttiiiivvvveeee)  indicates  that  the block is disjunctive
          (resp. conjunctive) according to the  definition  given
          in bbbbeeeessss(LOCAL).  Default value is ggggeeeennnneeeerrrraaaallll.


EEEEXXXXAAAAMMMMPPPPLLLLEEEESSSS OOOOFFFF RRRRBBBBCCCC FFFFIIIILLLLEEEESSSS
     The RBC file below specifies a  random  BES  with  a  single
     equation  block  of maximal fixed point, which contains only
     conjunctive variables and does not contain any constant:

        sign = 0
        number_of_variables = 1000
        equation_length = 10
        variable_ratio = 100
        or_variable_ratio = 0

     This kind of BES is typically encountered by translating the
     model  checking  of  satisfied  safety  properties  (see the
     eeeevvvvaaaalllluuuuaaaattttoooorrrr(LOCAL) manual page).  The local resolution of  any
     variable  of  this  BES  will  yield TRUE, since there is no
     ffffaaaallllsssseeee constant reachable from that variable.


     The RBC file below specifies a random BES with a single max-
     imal fixed point block with a small amount of constants, and
     in which  disjunctive  and  conjunctive  variables  strictly



(C) INRIA            Last change: 2020/02/11                    6






CADP MANUAL PAGES                                      RBC(LOCAL)



     alternate along dependencies:

        strategy = 2
        sign = 0
        number_of_variables = 10000
        equation_length = 10
        variable_ratio = 98
        or_variable_alternation = true

     This kind of  BES  typically  underlies  the  comparison  of
     equivalent  nondeterministic LTSs modulo strong bisimulation
     (see the bbbbiiiissssiiiimmmmuuuullllaaaattttoooorrrr(LOCAL) manual page).  The local resolu-
     tion of the variable of index 0 of this BES will yield TRUE.


     Finally, the RBC file below describes a random BES  contain-
     ing  two  equation blocks, the first one being a conjunctive
     maximal fixed point and the second one a disjunctive minimal
     fixed point:

        number_of_blocks = 2
        variable_ratio = 90

        # conjunctive nu-block
        0
        sign = 0
        solve_mode = 4
        number_of_variables = 1000
        equation_length = 20
        or_variable_ratio = 5
        false_constant_ratio = 0
        shape = conjunctive

        # disjunctive mu-block
        1
        sign = 100
        solve_mode = 3
        number_of_variables = 2000
        equation_length = 10
        or_variable_ratio = 95
        false_constant_ratio = 80
        shape = disjunctive

     This kind of BES corresponds to the model checking  of  cer-
     tain  fairness properties, such as the "fair reachability of
     predicates" (see the  eeeevvvvaaaalllluuuuaaaattttoooorrrr(LOCAL)  manual  page).   The
     local  resolution of a variable of the first block may yield
     TRUE or FALSE, depending on the chosen strategy.  The  stra-
     tegy  is  set  by  default to 1; setting it to 0 would yield
     different BESs at each execution of the tool.





(C) INRIA            Last change: 2020/02/11                    7






CADP MANUAL PAGES                                      RBC(LOCAL)



HHHHOOOOWWWW TTTTOOOO CCCCRRRREEEEAAAATTTTEEEE AAAA RRRRBBBBCCCC FFFFIIIILLLLEEEE
     At present, RBC files must be written by hand.


     The contents of an  RBC  file  passed  as  argument  to  the
     bbbbeeeessss____ssssoooollllvvvveeee(LOCAL) tool can also be extended using the options
     _r_a_n_d_o_m__o_p_t_i_o_n_s, _b_e_s__o_p_t_i_o_n_s, and _b_l_o_c_k__o_p_t_i_o_n_s.  Each  argu-
     ment   contained   in   _r_a_n_d_o_m__o_p_t_i_o_n_s,   _b_e_s__o_p_t_i_o_n_s,   and
     _b_l_o_c_k__o_p_t_i_o_n_s corresponds to a line in the RBC file.


     -    _r_a_n_d_o_m__o_p_t_i_o_n_s has the same syntax as the  non-terminal
          <<<<rrrraaaannnnddddoooommmm____ooooppppttttiiiioooonnnnssss>>>>  in  the RBC grammar (except that some
          characters meaningful to the shell must be  escaped  or
          quoted properly). If it is non-empty, it is interpreted
          exactly as if its contents were  inserted  in  the  RBC
          file,  at  the  end  of  the  <<<<rrrraaaannnnddddoooommmm____ooooppppttttiiiioooonnnnssss>>>> list and
          before the first <<<<bbbbeeeessss____ooooppppttttiiiioooonnnnssss>>>>.


     -    _b_e_s__o_p_t_i_o_n_s has the same  syntax  as  the  non-terminal
          <<<<bbbbeeeessss____ooooppppttttiiiioooonnnnssss>>>>  in  the  RBC  grammar  (except that some
          characters meaningful to the shell must be  escaped  or
          quoted properly). If it is non-empty, it is interpreted
          exactly as if its contents were  inserted  in  the  RBC
          file,  at  the end of the <<<<bbbbeeeessss____ooooppppttttiiiioooonnnnssss>>>> list and before
          the first <<<<bbbblllloooocccckkkk____ooooppppttttiiiioooonnnnssss>>>>.


     -    _b_l_o_c_k__o_p_t_i_o_n_s has the same syntax as a  possibly  empty
          list of non-terminals <<<<bbbblllloooocccckkkk____ooooppppttttiiiioooonnnnssss>>>> (except that some
          characters meaningful to the shell must be  escaped  or
          quoted properly). If it is non-empty, it is interpreted
          exactly as if its contents were appended at the end  of
          the RBC file, after the last <<<<bbbblllloooocccckkkk____ooooppppttttiiiioooonnnnssss>>>>.


     Thus, the value of <<<<rrrraaaannnnddddoooommmm____vvvvaaaarrrriiiiaaaabbbblllleeee>>>>s can be  set  in  three
     different ways, listed below by increasing precedence:


     -    default value,

     -    value given by <<<<rrrraaaannnnddddoooommmm____ooooppppttttiiiioooonnnnssss>>>> in the RBC file,

     -    value given by _r_a_n_d_o_m__o_p_t_i_o_n_s on the command line.


     The value of <<<<vvvvaaaarrrriiiiaaaabbbblllleeee>>>>s can be set in five different  ways,
     listed below by increasing precedence:





(C) INRIA            Last change: 2020/02/11                    8






CADP MANUAL PAGES                                      RBC(LOCAL)



     -    default value,

     -    value given by <<<<bbbbeeeessss____ooooppppttttiiiioooonnnnssss>>>> in the RBC file,

     -    value given by _b_e_s__o_p_t_i_o_n_s on the command line,

     -    value given by <<<<bbbblllloooocccckkkk____ooooppppttttiiiioooonnnnssss>>>> in the RBC file,

     -    value given by _b_l_o_c_k__o_p_t_i_o_n_s on the command line.


HHHHOOOOWWWW TTTTOOOO RRRREEEEAAAADDDD AAAA RRRRBBBBCCCC FFFFIIIILLLLEEEE
     At present, there is one single CADP tool, bbbbeeeessss____ssssoooollllvvvveeee(LOCAL),
     that reads and processes RBC files.


BBBBIIIIBBBBLLLLIIIIOOOOGGGGRRRRAAAAPPPPHHHHYYYY
     [Mat06] R. Mateescu.  CAESAR_SOLVE: A  Generic  Library  for
     On-the-Fly  Resolution  of Alternation-Free Boolean Equation
     Systems.  Springer International Journal on  Software  Tools
     for  Technology Transfer (STTT), 8(1):37-56, 2006. Full ver-
     sion available as INRIA Research Report  RR-5948.  Available
     from http://cadp.inria.fr/publications/Mateescu-06-a.html


     [GLMS13] H. Garavel, F. Lang, R.  Mateescu,  and  W.  Serwe.
     CADP  2011:  A  Toolbox for the Construction and Analysis of
     Distributed Processes.  Springer  International  Journal  on
     Software Tools for Technology Transfer (STTT), 15(2):89-107,
     2013.                     Available                     from
     http://cadp.inria.fr/publications/Garavel-Lang-Mateescu-
     Serwe-13.html


SSSSEEEEEEEE AAAALLLLSSSSOOOO
     OPEN/CAESAR Reference Manual, bbbbeeeessss(LOCAL),  bbbbeeeessss____ssssoooollllvvvveeee(LOCAL),
     bbbbiiiissssiiiimmmmuuuullllaaaattttoooorrrr(LOCAL), ccccaaaaeeeessssaaaarrrr____ssssoooollllvvvveeee____1111(LOCAL), eeeevvvvaaaalllluuuuaaaattttoooorrrr(LOCAL),
     lllloooottttoooossss....ooooppppeeeennnn(LOCAL)


     Additional information is available from the CADP  Web  page
     located at http://cadp.inria.fr

     Directives   for   installation   are   given    in    files
     $$$$CCCCAAAADDDDPPPP////IIIINNNNSSSSTTTTAAAALLLLLLLLAAAATTTTIIIIOOOONNNN____****....

     Recent  changes  and  improvements  to  this  software   are
     reported and commented in file $$$$CCCCAAAADDDDPPPP////HHHHIIIISSSSTTTTOOOORRRRYYYY....


BBBBUUUUGGGGSSSS
     Please report bugs to Radu.Mateescu@inria.fr.



(C) INRIA            Last change: 2020/02/11                    9






CADP MANUAL PAGES                                      RBC(LOCAL)























































(C) INRIA            Last change: 2020/02/11                   10






