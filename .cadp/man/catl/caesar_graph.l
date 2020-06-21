


OPEN/CAESAR MANUAL                            caesar_graph(LOCAL)



NNNNAAAAMMMMEEEE
     caesar_graph - the ``graph'' library of OPEN/CAESAR

PPPPUUUURRRRPPPPOOOOSSSSEEEE
     The ``graph module'' provides a  C  representation  for  the
     states  and  the  labels  of the transition system generated
     from the source program. It provides  primitives  to  handle
     those states and labels.

     It also provides primitives to compute the transition  rela-
     tion  (i.e., primitives to compute the initial state and the
     successors of any given state).

     The application programming interface specified by the graph
     module  is  language-independent:  various  languages can be
     implemented so as to comply with the ``graph module'' inter-
     face.

     Note: The functions and procedures  specified  below  should
     not  perform  input/output  operations on the standard input
     and standard output, especially reading  from  the  standard
     input  or writing to the standard output. As a general prin-
     ciple, access to  standard  input  and  standard  output  is
     reserved to the _O_P_E_N/_C_A_E_S_A_R application programs (and not to
     the graph module).  If the functions  of  the  graph  module
     want  to emit debugging information, this information should
     be sent to the standard error or, preferably,  to  a  named,
     unbuffered log file. Otherwise, some _O_P_E_N/_C_A_E_S_A_R application
     programs that rely on the standard input and standard output
     (e.g.,  the  _O_P_E_N/_C_A_E_S_A_R  Interactive  Simulator)  might not
     function properly if the graph module  performs  conflicting
     accesses to the standard input or the standard output.


UUUUSSSSAAAAGGGGEEEE
     The graph module consists of:


     -    A predefined header file ccccaaaaeeeessssaaaarrrr____ggggrrrraaaapppphhhh....hhhh, which  can  be
          found  in  the  _O_P_E_N/_C_A_E_S_A_R  package.  This  file is an
          interface specification describing a set  of  C  types,
          procedures, and functions. Conceptually, it can be seen
          as an abstract data type, with sorts and operations.

     -    A C file ssssppppeeeecccc....cccc, which is  generated  from  the  source
          program  (where  ssssppppeeeecccc  can  be any valid filename). For
          instance, in the case of a  LOTOS  program  ssssppppeeeecccc....lllloooottttoooossss,
          file  ssssppppeeeecccc....cccc  is  generated  by  _C_A_E_S_A_R  with the ----ooooppppeeeennnn
          option. The ssssppppeeeecccc....cccc file provides an implementation  for
          all the features described in ccccaaaaeeeessssaaaarrrr____ggggrrrraaaapppphhhh....hhhh.





(C) INRIA     Last change: 2020/02/11 (version 2.4)             1






OPEN/CAESAR MANUAL                            caesar_graph(LOCAL)



     The ssssppppeeeecccc....cccc must start with the two following directives:


              ####ddddeeeeffffiiiinnnneeee CCCCAAAAEEEESSSSAAAARRRR____GGGGRRRRAAAAPPPPHHHH____IIIIMMMMPPPPLLLLEEEEMMMMEEEENNNNTTTTAAAATTTTIIIIOOOONNNN ............
              ####iiiinnnncccclllluuuuddddeeee """"ccccaaaaeeeessssaaaarrrr____ggggrrrraaaapppphhhh....hhhh""""

     where  ............  should  be  replaced  by   an   integer   number
     corresponding  to  the version of the graph module interface
     for which ssssppppeeeecccc....cccc has been produced. As far as possible, this
     integer number will be used to preserve backward compatibil-
     ity in case of future  modifications  of  the  graph  module
     interface.   Concretely,  this integer number is obtained by
     taking the version number given for _O_P_E_N/_C_A_E_S_A_R at the  bot-
     tom  of  file  $$$$CCCCAAAADDDDPPPP////VVVVEEEERRRRSSSSIIIIOOOONNNN, then by multiplying by 10 this
     version number (considered as real number) in order to  turn
     it  into  an  integer  number (since the C preprocessor only
     handles  integers).  For  instance,  if   the   version   of
     _O_P_E_N/_C_A_E_S_A_R   is   2.4   in  the  $$$$CCCCAAAADDDDPPPP////VVVVEEEERRRRSSSSIIIIOOOONNNN  file,  then
     CCCCAAAAEEEESSSSAAAARRRR____GGGGRRRRAAAAPPPPHHHH____IIIIMMMMPPPPLLLLEEEEMMMMEEEENNNNTTTTAAAATTTTIIIIOOOONNNN should be set to 24.

     The features  defined  in  `ccccaaaaeeeessssaaaarrrr____ggggrrrraaaapppphhhh....hhhh''  are  described
     below.

     Note: The graph module uses the primitives  offered  by  the
     ``standard'' and ``version'' libraries.


GGGGEEEENNNNEEEERRRRAAAALLLL FFFFEEEEAAAATTTTUUUURRRREEEESSSS
      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____GGGGRRRRAAAAPPPPHHHH____CCCCOOOOMMMMPPPPIIIILLLLEEEERRRR

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSTTTTRRRRIIIINNNNGGGG CCCCAAAAEEEESSSSAAAARRRR____GGGGRRRRAAAAPPPPHHHH____CCCCOOOOMMMMPPPPIIIILLLLEEEERRRR (((())))
        {{{{ ............ }}}}

     This function returns a character string containing the name
     (in upper case letters) of the compiler tool which generated
     the C program ssssppppeeeecccc....cccc. For instance, if ssssppppeeeecccc....cccc  is  generated
     by  _C_A_E_S_A_R  from  a  LOTOS  program,  the result of function
     CCCCAAAAEEEESSSSAAAARRRR____GGGGRRRRAAAAPPPPHHHH____CCCCOOOOMMMMPPPPIIIILLLLEEEERRRR(((()))) is the character string """"CCCCAAAAEEEESSSSAAAARRRR"""".

     Note: It is not  allowed  to  modify  the  character  string
     returned  by  CCCCAAAAEEEESSSSAAAARRRR____GGGGRRRRAAAAPPPPHHHH____CCCCOOOOMMMMPPPPIIIILLLLEEEERRRR(((())))  nor  to  free it, for
     instance using ffffrrrreeeeeeee((((3333)))).

     Note: The contents  of  the  character  string  returned  by
     CCCCAAAAEEEESSSSAAAARRRR____GGGGRRRRAAAAPPPPHHHH____CCCCOOOOMMMMPPPPIIIILLLLEEEERRRR(((())))  may  be  destroyed  by a subsequent
     call to this function.

      ............................................................





(C) INRIA     Last change: 2020/02/11 (version 2.4)             2






OPEN/CAESAR MANUAL                            caesar_graph(LOCAL)



  CCCCAAAAEEEESSSSAAAARRRR____GGGGRRRRAAAAPPPPHHHH____VVVVEEEERRRRSSSSIIIIOOOONNNN

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____VVVVEEEERRRRSSSSIIIIOOOONNNN CCCCAAAAEEEESSSSAAAARRRR____GGGGRRRRAAAAPPPPHHHH____VVVVEEEERRRRSSSSIIIIOOOONNNN (((())))
        {{{{ ............ }}}}

     This function returns the version  number  of  the  compiler
     tool which generated the C program ssssppppeeeecccc....cccc.

      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____IIIINNNNIIIITTTT____GGGGRRRRAAAAPPPPHHHH

     vvvvooooiiiidddd CCCCAAAAEEEESSSSAAAARRRR____IIIINNNNIIIITTTT____GGGGRRRRAAAAPPPPHHHH (((())))
        {{{{ ............ }}}}

     This procedure contains initialization actions for the graph
     module.  It must be invoked once before using any routine of
     this module.

     Implementation  note:  This  procedure  should  invoke   the
     CCCCAAAAEEEESSSSAAAARRRR____CCCCHHHHEEEECCCCKKKK____VVVVEEEERRRRSSSSIIIIOOOONNNN(((())))   procedure  (see  the  corresponding
     description in the ``version'' library) in order  to  detect
     version clashes between ssssppppeeeecccc....cccc and ccccaaaaeeeessssaaaarrrr____ggggrrrraaaapppphhhh....hhhh.

SSSSTTTTAAAATTTTEEEE FFFFEEEEAAAATTTTUUUURRRREEEESSSS
      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____BBBBOOOODDDDYYYY____SSSSTTTTAAAATTTTEEEE

     ttttyyyyppppeeeeddddeeeeffff ssssttttrrrruuuucccctttt CCCCAAAAEEEESSSSAAAARRRR____SSSSTTTTRRRRUUUUCCCCTTTT____SSSSTTTTAAAATTTTEEEE {{{{ ............ }}}} CCCCAAAAEEEESSSSAAAARRRR____BBBBOOOODDDDYYYY____SSSSTTTTAAAATTTTEEEE;;;;

     This type denotes the actual implementation of states in the
     labelled  transition  system.   Each  state  is  basically a
     structure named CCCCAAAAEEEESSSSAAAARRRR____SSSSTTTTRRRRUUUUCCCCTTTT____SSSSTTTTAAAATTTTEEEE. Thus, each state can be
     seen   as   a  byte  string  of  fixed  size  (see  function
     CCCCAAAAEEEESSSSAAAARRRR____SSSSIIIIZZZZEEEE____SSSSTTTTAAAATTTTEEEE(((())))  below)  with  definite  alignment  con-
     straints  (see function CCCCAAAAEEEESSSSAAAARRRR____AAAALLLLIIIIGGGGNNNNMMMMEEEENNNNTTTT____SSSSTTTTAAAATTTTEEEE(((()))) below), and
     all the states have the same size.

     State definition is ``opaque'': the detailed  definition  of
     CCCCAAAAEEEESSSSAAAARRRR____SSSSTTTTRRRRUUUUCCCCTTTT____SSSSTTTTAAAATTTTEEEE  and CCCCAAAAEEEESSSSAAAARRRR____BBBBOOOODDDDYYYY____SSSSTTTTAAAATTTTEEEE is only available
     in include mode, but not in  link  mode.  Therefore,  making
     assumptions     about     the     fields     of    structure
     CCCCAAAAEEEESSSSAAAARRRR____SSSSTTTTRRRRUUUUCCCCTTTT____SSSSTTTTAAAATTTTEEEE is not advisable.

      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSTTTTAAAATTTTEEEE

     ttttyyyyppppeeeeddddeeeeffff CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____AAAABBBBSSSSTTTTRRRRAAAACCCCTTTT ((((............)))) CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSTTTTAAAATTTTEEEE;;;;

     This type denotes a pointer to the  (opaque)  representation



(C) INRIA     Last change: 2020/02/11 (version 2.4)             3






OPEN/CAESAR MANUAL                            caesar_graph(LOCAL)



     of  states.  It  is  given  an  abstract  definition in file
     ccccaaaaeeeessssaaaarrrr____ggggrrrraaaapppphhhh....hhhh and should be redefined in ssssppppeeeecccc....cccc.

     Concretely, CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSTTTTAAAATTTTEEEE should be defined as a pointer
     to a structure named CCCCAAAAEEEESSSSAAAARRRR____SSSSTTTTRRRRUUUUCCCCTTTT____SSSSTTTTAAAATTTTEEEE or, equivalently, a
     pointer to type CCCCAAAAEEEESSSSAAAARRRR____BBBBOOOODDDDYYYY____SSSSTTTTAAAATTTTEEEE (see above).

      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____SSSSIIIIZZZZEEEE____SSSSTTTTAAAATTTTEEEE

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL CCCCAAAAEEEESSSSAAAARRRR____SSSSIIIIZZZZEEEE____SSSSTTTTAAAATTTTEEEE (((())))
        {{{{ ............ }}}}

     This function returns the state size (in  bytes),  which  is
     always greater than 0.

     Implementation note: Practically, in  ccccaaaaeeeessssaaaarrrr____ggggrrrraaaapppphhhh....hhhh,  func-
     tion CCCCAAAAEEEESSSSAAAARRRR____SSSSIIIIZZZZEEEE____SSSSTTTTAAAATTTTEEEE(((()))) is defined as follows:

              ####ddddeeeeffffiiiinnnneeee CCCCAAAAEEEESSSSAAAARRRR____SSSSIIIIZZZZEEEE____SSSSTTTTAAAATTTTEEEE(((()))) CCCCAAAAEEEESSSSAAAARRRR____HHHHIIIINNNNTTTT____SSSSIIIIZZZZEEEE____SSSSTTTTAAAATTTTEEEE

     where CCCCAAAAEEEESSSSAAAARRRR____HHHHIIIINNNNTTTT____SSSSIIIIZZZZEEEE____SSSSTTTTAAAATTTTEEEE is a variable defined by:

              eeeexxxxtttteeeerrrrnnnn CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL CCCCAAAAEEEESSSSAAAARRRR____HHHHIIIINNNNTTTT____SSSSIIIIZZZZEEEE____SSSSTTTTAAAATTTTEEEE;;;;

     This variable should be defined, properly  initialized,  and
     exported  by  ssssppppeeeecccc....cccc. It should neither be used nor assigned
     in any other program than  ssssppppeeeecccc....cccc.  This  variable  is  only
     introduced  for  efficiency reasons, i.e., to avoid the cost
     of a function call.

      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____HHHHAAAASSSSHHHH____SSSSIIIIZZZZEEEE____SSSSTTTTAAAATTTTEEEE

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL CCCCAAAAEEEESSSSAAAARRRR____HHHHAAAASSSSHHHH____SSSSIIIIZZZZEEEE____SSSSTTTTAAAATTTTEEEE (((())))
        {{{{ ............ }}}}

     This function returns a number of bytes N such that, for any
     state  pointed  to by a variable CCCCAAAAEEEESSSSAAAARRRR____SSSS, one can compute a
     hash function which takes into account the value of the fol-
     lowing  bytes:  CCCCAAAAEEEESSSSAAAARRRR____SSSS [0], CCCCAAAAEEEESSSSAAAARRRR____SSSS [1], ... and CCCCAAAAEEEESSSSAAAARRRR____SSSS
     [N-1].

     Note: It is always true that:

        0 < CCCCAAAAEEEESSSSAAAARRRR____HHHHAAAASSSSHHHH____SSSSIIIIZZZZEEEE____SSSSTTTTAAAATTTTEEEE (((()))) <= CCCCAAAAEEEESSSSAAAARRRR____SSSSIIIIZZZZEEEE____SSSSTTTTAAAATTTTEEEE (((())))

     but it is possible that:

           CCCCAAAAEEEESSSSAAAARRRR____HHHHAAAASSSSHHHH____SSSSIIIIZZZZEEEE____SSSSTTTTAAAATTTTEEEE (((()))) < CCCCAAAAEEEESSSSAAAARRRR____SSSSIIIIZZZZEEEE____SSSSTTTTAAAATTTTEEEE (((())))



(C) INRIA     Last change: 2020/02/11 (version 2.4)             4






OPEN/CAESAR MANUAL                            caesar_graph(LOCAL)




     especially if the state vector contains variables of pointer
     types.  By  using  this  function, users can write their own
     hash functions.

     Implementation note: Practically, in  ccccaaaaeeeessssaaaarrrr____ggggrrrraaaapppphhhh....hhhh,  func-
     tion CCCCAAAAEEEESSSSAAAARRRR____HHHHAAAASSSSHHHH____SSSSIIIIZZZZEEEE____SSSSTTTTAAAATTTTEEEE(((()))) is defined as follows:

              ####ddddeeeeffffiiiinnnneeee CCCCAAAAEEEESSSSAAAARRRR____HHHHAAAASSSSHHHH____SSSSIIIIZZZZEEEE____SSSSTTTTAAAATTTTEEEE(((()))) CCCCAAAAEEEESSSSAAAARRRR____HHHHIIIINNNNTTTT____HHHHAAAASSSSHHHH____SSSSIIIIZZZZEEEE____SSSSTTTTAAAATTTTEEEE

     where CCCCAAAAEEEESSSSAAAARRRR____HHHHIIIINNNNTTTT____HHHHAAAASSSSHHHH____SSSSIIIIZZZZEEEE____SSSSTTTTAAAATTTTEEEE is a variable defined by:

              eeeexxxxtttteeeerrrrnnnn CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL CCCCAAAAEEEESSSSAAAARRRR____HHHHIIIINNNNTTTT____HHHHAAAASSSSHHHH____SSSSIIIIZZZZEEEE____SSSSTTTTAAAATTTTEEEE;;;;

     This variable should be defined, properly  initialized,  and
     exported  by  ssssppppeeeecccc....cccc. It should neither be used nor assigned
     in any other program than  ssssppppeeeecccc....cccc.  This  variable  is  only
     introduced  for  efficiency reasons, i.e., to avoid the cost
     of a function call.

      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____AAAALLLLIIIIGGGGNNNNMMMMEEEENNNNTTTT____SSSSTTTTAAAATTTTEEEE

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL CCCCAAAAEEEESSSSAAAARRRR____AAAALLLLIIIIGGGGNNNNMMMMEEEENNNNTTTT____SSSSTTTTAAAATTTTEEEE (((())))
        {{{{ ............ }}}}

     This function returns the alignment factor  (in  bytes)  for
     states.  The alignment factor is always a power of two, usu-
     ally 1, 2, 4, or 8. Any byte  string  representing  a  state
     must  be  aligned  on a boundary that is an even multiple of
     the alignment factor.

     Implementation note: Practically, in  ccccaaaaeeeessssaaaarrrr____ggggrrrraaaapppphhhh....hhhh,  func-
     tion CCCCAAAAEEEESSSSAAAARRRR____AAAALLLLIIIIGGGGNNNNMMMMEEEENNNNTTTT____SSSSTTTTAAAATTTTEEEE(((()))) is defined as follows:

              ####ddddeeeeffffiiiinnnneeee CCCCAAAAEEEESSSSAAAARRRR____AAAALLLLIIIIGGGGNNNNMMMMEEEENNNNTTTT____SSSSTTTTAAAATTTTEEEE(((()))) CCCCAAAAEEEESSSSAAAARRRR____HHHHIIIINNNNTTTT____AAAALLLLIIIIGGGGNNNNMMMMEEEENNNNTTTT____SSSSTTTTAAAATTTTEEEE

     where CCCCAAAAEEEESSSSAAAARRRR____HHHHIIIINNNNTTTT____AAAALLLLIIIIGGGGNNNNMMMMEEEENNNNTTTT____SSSSTTTTAAAATTTTEEEE is a variable defined by:

              eeeexxxxtttteeeerrrrnnnn CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL CCCCAAAAEEEESSSSAAAARRRR____HHHHIIIINNNNTTTT____AAAALLLLIIIIGGGGNNNNMMMMEEEENNNNTTTT____SSSSTTTTAAAATTTTEEEE;;;;

     This variable should be defined, properly  initialized,  and
     exported  by  ssssppppeeeecccc....cccc. It should neither be used nor assigned
     in any other program than  ssssppppeeeecccc....cccc.  This  variable  is  only
     introduced  for  efficiency reasons, i.e., to avoid the cost
     of a function call.

      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTEEEE____SSSSTTTTAAAATTTTEEEE




(C) INRIA     Last change: 2020/02/11 (version 2.4)             5






OPEN/CAESAR MANUAL                            caesar_graph(LOCAL)



     vvvvooooiiiidddd CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTEEEE____SSSSTTTTAAAATTTTEEEE ((((CCCCAAAAEEEESSSSAAAARRRR____SSSS))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSTTTTAAAATTTTEEEE ****CCCCAAAAEEEESSSSAAAARRRR____SSSS;;;;
        {{{{ ............ }}}}

     This  procedure  allocates   a   byte   string   of   length
     CCCCAAAAEEEESSSSAAAARRRR____SSSSIIIIZZZZEEEE____SSSSTTTTAAAATTTTEEEE(((())))  using  CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTEEEE(((())))  and assigns its
     address to ****CCCCAAAAEEEESSSSAAAARRRR____SSSS. If  the  allocation  fails,  the  NNNNUUUULLLLLLLL
     value is assigned to ****CCCCAAAAEEEESSSSAAAARRRR____SSSS.

     Note: because CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSTTTTAAAATTTTEEEE is a pointer type, any vari-
     able  CCCCAAAAEEEESSSSAAAARRRR____SSSS  of  type CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSTTTTAAAATTTTEEEE must be allocated
     before used, for instance using:

                   CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTEEEE____SSSSTTTTAAAATTTTEEEE ((((&&&&CCCCAAAAEEEESSSSAAAARRRR____SSSS))));;;;

     However, it is not necessary to use CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTEEEE____SSSSTTTTAAAATTTTEEEE(((()))) to
     perform  the  allocation. Instead, users can allocate states
     into their own data structures (tables, lists, ...)

     Implementation  note:  It  is  not   necessary   to   define
     CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTEEEE____SSSSTTTTAAAATTTTEEEE(((())))   in   ssssppppeeeecccc....cccc  because  ccccaaaaeeeessssaaaarrrr____ggggrrrraaaapppphhhh....hhhh
     already implements this procedure using a macro-definition.

      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____DDDDEEEELLLLEEEETTTTEEEE____SSSSTTTTAAAATTTTEEEE

     vvvvooooiiiidddd CCCCAAAAEEEESSSSAAAARRRR____DDDDEEEELLLLEEEETTTTEEEE____SSSSTTTTAAAATTTTEEEE ((((CCCCAAAAEEEESSSSAAAARRRR____SSSS))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSTTTTAAAATTTTEEEE ****CCCCAAAAEEEESSSSAAAARRRR____SSSS;;;;
        {{{{ ............ }}}}

     This   procedure   frees   the   byte   string   of   length
     CCCCAAAAEEEESSSSAAAARRRR____SSSSIIIIZZZZEEEE____SSSSTTTTAAAATTTTEEEE(((())))    pointed   to   by   ****CCCCAAAAEEEESSSSAAAARRRR____SSSS   using
     CCCCAAAAEEEESSSSAAAARRRR____DDDDEEEELLLLEEEETTTTEEEE(((()))). Afterwards, the NNNNUUUULLLLLLLL value is  assigned  to
     ****CCCCAAAAEEEESSSSAAAARRRR____SSSS.

     Implementation  note:  It  is  not   necessary   to   define
     CCCCAAAAEEEESSSSAAAARRRR____DDDDEEEELLLLEEEETTTTEEEE____SSSSTTTTAAAATTTTEEEE(((())))   in   ssssppppeeeecccc....cccc  because  ccccaaaaeeeessssaaaarrrr____ggggrrrraaaapppphhhh....hhhh
     already implements this procedure using a macro-definition.

      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____CCCCOOOOPPPPYYYY____SSSSTTTTAAAATTTTEEEE

     vvvvooooiiiidddd CCCCAAAAEEEESSSSAAAARRRR____CCCCOOOOPPPPYYYY____SSSSTTTTAAAATTTTEEEE ((((CCCCAAAAEEEESSSSAAAARRRR____SSSS1111,,,, CCCCAAAAEEEESSSSAAAARRRR____SSSS2222))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSTTTTAAAATTTTEEEE CCCCAAAAEEEESSSSAAAARRRR____SSSS1111;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSTTTTAAAATTTTEEEE CCCCAAAAEEEESSSSAAAARRRR____SSSS2222;;;;
        {{{{ ............ }}}}

     This procedure copies the state pointed to by CCCCAAAAEEEESSSSAAAARRRR____SSSS2222 onto
     the state pointed to by CCCCAAAAEEEESSSSAAAARRRR____SSSS1111.




(C) INRIA     Last change: 2020/02/11 (version 2.4)             6






OPEN/CAESAR MANUAL                            caesar_graph(LOCAL)



     Note: Parameter CCCCAAAAEEEESSSSAAAARRRR____SSSS2222 must point to  a  memory  location
     allocated before procedure CCCCAAAAEEEESSSSAAAARRRR____CCCCOOOOPPPPYYYY____SSSSTTTTAAAATTTTEEEE(((()))) is invoked.

     Implementation  note:  It  is  not   necessary   to   define
     CCCCAAAAEEEESSSSAAAARRRR____CCCCOOOOPPPPYYYY____SSSSTTTTAAAATTTTEEEE(((()))) in ssssppppeeeecccc....cccc because ccccaaaaeeeessssaaaarrrr____ggggrrrraaaapppphhhh....hhhh already
     implements this procedure using a macro-definition.

      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____CCCCOOOOMMMMPPPPAAAARRRREEEE____SSSSTTTTAAAATTTTEEEE

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____BBBBOOOOOOOOLLLLEEEEAAAANNNN CCCCAAAAEEEESSSSAAAARRRR____CCCCOOOOMMMMPPPPAAAARRRREEEE____SSSSTTTTAAAATTTTEEEE ((((CCCCAAAAEEEESSSSAAAARRRR____SSSS1111,,,, CCCCAAAAEEEESSSSAAAARRRR____SSSS2222))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSTTTTAAAATTTTEEEE CCCCAAAAEEEESSSSAAAARRRR____SSSS1111;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSTTTTAAAATTTTEEEE CCCCAAAAEEEESSSSAAAARRRR____SSSS2222;;;;
        {{{{ ............ }}}}

     This function returns a  value  different  from  0  if  both
     states  pointed to by CCCCAAAAEEEESSSSAAAARRRR____SSSS1111 and CCCCAAAAEEEESSSSAAAARRRR____SSSS2222 are identical,
     or 0 if they are not.

      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____HHHHAAAASSSSHHHH____SSSSTTTTAAAATTTTEEEE

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL CCCCAAAAEEEESSSSAAAARRRR____HHHHAAAASSSSHHHH____SSSSTTTTAAAATTTTEEEE ((((CCCCAAAAEEEESSSSAAAARRRR____SSSS,,,, CCCCAAAAEEEESSSSAAAARRRR____MMMMOOOODDDDUUUULLLLUUUUSSSS))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSTTTTAAAATTTTEEEE CCCCAAAAEEEESSSSAAAARRRR____SSSS;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL CCCCAAAAEEEESSSSAAAARRRR____MMMMOOOODDDDUUUULLLLUUUUSSSS;;;;
        {{{{ ............ }}}}

     This function computes  a  hash-code  value  for  the  state
     pointed to by CCCCAAAAEEEESSSSAAAARRRR____SSSS and returns this value, which must be
     in the range 0..CCCCAAAAEEEESSSSAAAARRRR____MMMMOOOODDDDUUUULLLLUUUUSSSS-1.

      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____FFFFOOOORRRRMMMMAAAATTTT____SSSSTTTTAAAATTTTEEEE

     vvvvooooiiiidddd CCCCAAAAEEEESSSSAAAARRRR____FFFFOOOORRRRMMMMAAAATTTT____SSSSTTTTAAAATTTTEEEE ((((CCCCAAAAEEEESSSSAAAARRRR____FFFFOOOORRRRMMMMAAAATTTT))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____FFFFOOOORRRRMMMMAAAATTTT CCCCAAAAEEEESSSSAAAARRRR____FFFFOOOORRRRMMMMAAAATTTT;;;;
        {{{{ ............ }}}}

     This procedure allows to  control  the  format  under  which
     states        are        printed        by        procedures
     CCCCAAAAEEEESSSSAAAARRRR____PPPPRRRRIIIINNNNTTTT____SSSSTTTTAAAATTTTEEEE____HHHHEEEEAAAADDDDEEEERRRR(((()))),    CCCCAAAAEEEESSSSAAAARRRR____PPPPRRRRIIIINNNNTTTT____SSSSTTTTAAAATTTTEEEE(((()))),    and
     CCCCAAAAEEEESSSSAAAARRRR____DDDDEEEELLLLTTTTAAAA____SSSSTTTTAAAATTTTEEEE(((())))  (see  below). Currently, the following
     formats are available:


     -    If the current state format is 0, each state is printed
          on  a  single line, which should not be terminated by a
          new-line character (``\nnnn'').




(C) INRIA     Last change: 2020/02/11 (version 2.4)             7






OPEN/CAESAR MANUAL                            caesar_graph(LOCAL)



          _C_A_E_S_A_R-specific note: states generated from LOTOS  pro-
          grams  are  printed  as  a pair consisting of a marking
          part (marked places in the parallel components)  and  a
          context part (values of state variables).

          _C_A_E_S_A_R-specific note: only one state  format  (numbered
          0) is available.

     -    (no other format available yet).

     By default, the current state format is initialized to 0.

     When called with CCCCAAAAEEEESSSSAAAARRRR____FFFFOOOORRRRMMMMAAAATTTT between  0  and  the  maximal
     format value supported, this fonction sets the current state
     format to CCCCAAAAEEEESSSSAAAARRRR____FFFFOOOORRRRMMMMAAAATTTT and returns an undefined result.

     When called with another value of CCCCAAAAEEEESSSSAAAARRRR____FFFFOOOORRRRMMMMAAAATTTT, this  func-
     tion  does not modify the current state format but returns a
     result defined as follows. If CCCCAAAAEEEESSSSAAAARRRR____FFFFOOOORRRRMMMMAAAATTTT is equal to  the
     constant  CCCCAAAAEEEESSSSAAAARRRR____CCCCUUUURRRRRRRREEEENNNNTTTT____FFFFOOOORRRRMMMMAAAATTTT,  the result is the value of
     the current state format. If CCCCAAAAEEEESSSSAAAARRRR____FFFFOOOORRRRMMMMAAAATTTT is equal  to  the
     constant  CCCCAAAAEEEESSSSAAAARRRR____MMMMAAAAXXXXIIIIMMMMAAAALLLL____FFFFOOOORRRRMMMMAAAATTTT,  the  result is the maximal
     format value (e.g., 0 in the case of _C_A_E_S_A_R). In  all  other
     cases, the effect of this function is undefined.

      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____MMMMAAAAXXXX____FFFFOOOORRRRMMMMAAAATTTT____SSSSTTTTAAAATTTTEEEE

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____FFFFOOOORRRRMMMMAAAATTTT CCCCAAAAEEEESSSSAAAARRRR____MMMMAAAAXXXX____FFFFOOOORRRRMMMMAAAATTTT____SSSSTTTTAAAATTTTEEEE (((())))
        {{{{ ............ }}}}

     Caution! This function is deprecated. It should no longer be
     used,  as  it  might  be removed from future versions of the
     _O_P_E_N/_C_A_E_S_A_R.  Use  function  CCCCAAAAEEEESSSSAAAARRRR____FFFFOOOORRRRMMMMAAAATTTT____SSSSTTTTAAAATTTTEEEE(((())))  instead,
     called with argument CCCCAAAAEEEESSSSAAAARRRR____MMMMAAAAXXXXIIIIMMMMAAAALLLL____FFFFOOOORRRRMMMMAAAATTTT.

     This function returns the highest format available for state
     printing, i.e., the highest acceptable value for the parame-
     ter CCCCAAAAEEEESSSSAAAARRRR____FFFFOOOORRRRMMMMAAAATTTT of function CCCCAAAAEEEESSSSAAAARRRR____FFFFOOOORRRRMMMMAAAATTTT____SSSSTTTTAAAATTTTEEEE(((()))).

      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____PPPPRRRRIIIINNNNTTTT____SSSSTTTTAAAATTTTEEEE____HHHHEEEEAAAADDDDEEEERRRR

     vvvvooooiiiidddd CCCCAAAAEEEESSSSAAAARRRR____PPPPRRRRIIIINNNNTTTT____SSSSTTTTAAAATTTTEEEE____HHHHEEEEAAAADDDDEEEERRRR ((((CCCCAAAAEEEESSSSAAAARRRR____FFFFIIIILLLLEEEE))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____FFFFIIIILLLLEEEE CCCCAAAAEEEESSSSAAAARRRR____FFFFIIIILLLLEEEE;;;;
        {{{{ ............ }}}}

     This procedure prints to file CCCCAAAAEEEESSSSAAAARRRR____FFFFIIIILLLLEEEE information  about
     the  structure  of  states. The nature of the information is
     determined  by  the  current  state  format  (see  procedure



(C) INRIA     Last change: 2020/02/11 (version 2.4)             8






OPEN/CAESAR MANUAL                            caesar_graph(LOCAL)



     CCCCAAAAEEEESSSSAAAARRRR____FFFFOOOORRRRMMMMAAAATTTT____SSSSTTTTAAAATTTTEEEE(((())))  above).  This procedure is to be used
     in conjunction with the next one.

     Before this procedure is called, CCCCAAAAEEEESSSSAAAARRRR____FFFFIIIILLLLEEEE must have  been
     properly opened, for instance using ffffooooppppeeeennnn((((3333)))).

      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____PPPPRRRRIIIINNNNTTTT____SSSSTTTTAAAATTTTEEEE

     vvvvooooiiiidddd CCCCAAAAEEEESSSSAAAARRRR____PPPPRRRRIIIINNNNTTTT____SSSSTTTTAAAATTTTEEEE ((((CCCCAAAAEEEESSSSAAAARRRR____FFFFIIIILLLLEEEE,,,, CCCCAAAAEEEESSSSAAAARRRR____SSSS))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____FFFFIIIILLLLEEEE CCCCAAAAEEEESSSSAAAARRRR____FFFFIIIILLLLEEEE;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSTTTTAAAATTTTEEEE CCCCAAAAEEEESSSSAAAARRRR____SSSS;;;;
        {{{{ ............ }}}}

     This procedure prints to file CCCCAAAAEEEESSSSAAAARRRR____FFFFIIIILLLLEEEE information  about
     the contents of the state pointed to by CCCCAAAAEEEESSSSAAAARRRR____SSSS. The nature
     of the information is determined by the current state format
     (see procedure CCCCAAAAEEEESSSSAAAARRRR____FFFFOOOORRRRMMMMAAAATTTT____SSSSTTTTAAAATTTTEEEE(((()))) above).

     Before this procedure is called, CCCCAAAAEEEESSSSAAAARRRR____FFFFIIIILLLLEEEE must have  been
     properly opened, for instance using ffffooooppppeeeennnn((((3333)))).

      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____DDDDEEEELLLLTTTTAAAA____SSSSTTTTAAAATTTTEEEE

     vvvvooooiiiidddd CCCCAAAAEEEESSSSAAAARRRR____DDDDEEEELLLLTTTTAAAA____SSSSTTTTAAAATTTTEEEE ((((CCCCAAAAEEEESSSSAAAARRRR____FFFFIIIILLLLEEEE,,,, CCCCAAAAEEEESSSSAAAARRRR____SSSS1111,,,, CCCCAAAAEEEESSSSAAAARRRR____SSSS2222))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____FFFFIIIILLLLEEEE CCCCAAAAEEEESSSSAAAARRRR____FFFFIIIILLLLEEEE;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSTTTTAAAATTTTEEEE CCCCAAAAEEEESSSSAAAARRRR____SSSS1111;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSTTTTAAAATTTTEEEE CCCCAAAAEEEESSSSAAAARRRR____SSSS2222;;;;
        {{{{ ............ }}}}

     This procedure prints to file CCCCAAAAEEEESSSSAAAARRRR____FFFFIIIILLLLEEEE information  about
     the  differences  (``delta'') between both states pointed to
     by CCCCAAAAEEEESSSSAAAARRRR____SSSS1111 and CCCCAAAAEEEESSSSAAAARRRR____SSSS2222 respectively. The nature  of  the
     information  is  determined by the current state format (see
     procedure CCCCAAAAEEEESSSSAAAARRRR____FFFFOOOORRRRMMMMAAAATTTT____SSSSTTTTAAAATTTTEEEE(((()))) above).

     Before this procedure is called, CCCCAAAAEEEESSSSAAAARRRR____FFFFIIIILLLLEEEE must have  been
     properly opened, for instance using ffffooooppppeeeennnn((((3333)))).

LLLLAAAABBBBEEEELLLL FFFFEEEEAAAATTTTUUUURRRREEEESSSS
      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____BBBBOOOODDDDYYYY____LLLLAAAABBBBEEEELLLL

     ttttyyyyppppeeeeddddeeeeffff ssssttttrrrruuuucccctttt CCCCAAAAEEEESSSSAAAARRRR____SSSSTTTTRRRRUUUUCCCCTTTT____LLLLAAAABBBBEEEELLLL {{{{ ............ }}}} CCCCAAAAEEEESSSSAAAARRRR____BBBBOOOODDDDYYYY____LLLLAAAABBBBEEEELLLL;;;;

     This type denotes the actual implementation of labels in the
     labelled  transition  system.   Each  label  is  basically a
     structure named CCCCAAAAEEEESSSSAAAARRRR____SSSSTTTTRRRRUUUUCCCCTTTT____LLLLAAAABBBBEEEELLLL. Thus, each label  is  a



(C) INRIA     Last change: 2020/02/11 (version 2.4)             9






OPEN/CAESAR MANUAL                            caesar_graph(LOCAL)



     byte  string of fixed size (see function CCCCAAAAEEEESSSSAAAARRRR____SSSSIIIIZZZZEEEE____LLLLAAAABBBBEEEELLLL(((())))
     below) with definite  alignment  constraints  (see  function
     CCCCAAAAEEEESSSSAAAARRRR____AAAALLLLIIIIGGGGNNNNMMMMEEEENNNNTTTT____LLLLAAAABBBBEEEELLLL(((()))) below), and all the labels have the
     same size.  In a first approach, the label representation is
     supposed  to  be  ``opaque'':  the  detailed  definition  of
     CCCCAAAAEEEESSSSAAAARRRR____SSSSTTTTRRRRUUUUCCCCTTTT____LLLLAAAABBBBEEEELLLL and CCCCAAAAEEEESSSSAAAARRRR____BBBBOOOODDDDYYYY____LLLLAAAABBBBEEEELLLL is only  available
     in  include  mode,  but  not in link mode. Therefore, making
     assumptions    about     the     fields     of     structure
     CCCCAAAAEEEESSSSAAAARRRR____SSSSTTTTRRRRUUUUCCCCTTTT____LLLLAAAABBBBEEEELLLL is not advisable.

     In a refined approach, it is assumed  that  labels  have  an
     internal structure consisting of a _g_a_t_e (i.e., an identifier
     representing the name of a communication port) and a  finite
     list  of  _e_x_p_e_r_i_m_e_n_t  _o_f_f_e_r_s  (i.e.,  typed  data parameters
     exchanged on the gate).  This  assumption  is  made  without
     loss  of  generality: although the names _g_a_t_e and _e_x_p_e_r_i_m_e_n_t
     _o_f_f_e_r are borrowed from the LOTOS  vocabulary,  most  formal
     description  techniques  for  concurrent systems make a dis-
     tinction between communication ports and the parameters sent
     or received on these ports.

     Implementation note: If the transition system generated from
     the  source  program  has only a single state and no transi-
     tion, there are no labels at all.  In such case, the C  pro-
     gram  ssssppppeeeecccc....cccc  generated by the compiler tool shall neverthe-
     less provide an implementation for all types, functions, and
     procedures  defined  in  this section and related to labels.
     Such an implementation will not be used (since there are  no
     labels)  but it is needed to ensure that everything compiles
     properly. The implementation details are left undefined: any
     implementation  that  complies  with the requirements stated
     below, is acceptable.

      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____LLLLAAAABBBBEEEELLLL

     ttttyyyyppppeeeeddddeeeeffff CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____AAAABBBBSSSSTTTTRRRRAAAACCCCTTTT ((((............)))) CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____LLLLAAAABBBBEEEELLLL;;;;

     This type denotes a pointer to the  (opaque)  representation
     of  labels.  It  is  given  an  abstract  definition in file
     ccccaaaaeeeessssaaaarrrr____ggggrrrraaaapppphhhh....hhhh and should be redefined in ssssppppeeeecccc....cccc.

     Concretely, CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____LLLLAAAABBBBEEEELLLL should be defined as a pointer
     to a structure named CCCCAAAAEEEESSSSAAAARRRR____SSSSTTTTRRRRUUUUCCCCTTTT____LLLLAAAABBBBEEEELLLL or, equivalently, a
     pointer to type CCCCAAAAEEEESSSSAAAARRRR____BBBBOOOODDDDYYYY____LLLLAAAABBBBEEEELLLL (see above).

      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____SSSSIIIIZZZZEEEE____LLLLAAAABBBBEEEELLLL

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL CCCCAAAAEEEESSSSAAAARRRR____SSSSIIIIZZZZEEEE____LLLLAAAABBBBEEEELLLL (((())))



(C) INRIA     Last change: 2020/02/11 (version 2.4)            10






OPEN/CAESAR MANUAL                            caesar_graph(LOCAL)



        {{{{ ............ }}}}

     This function returns the label size (in  bytes),  which  is
     always greater than 0.

     Implementation note: Practically, in  ccccaaaaeeeessssaaaarrrr____ggggrrrraaaapppphhhh....hhhh,  func-
     tion CCCCAAAAEEEESSSSAAAARRRR____SSSSIIIIZZZZEEEE____LLLLAAAABBBBEEEELLLL(((()))) is defined as follows:

              ####ddddeeeeffffiiiinnnneeee CCCCAAAAEEEESSSSAAAARRRR____SSSSIIIIZZZZEEEE____LLLLAAAABBBBEEEELLLL(((()))) CCCCAAAAEEEESSSSAAAARRRR____HHHHIIIINNNNTTTT____SSSSIIIIZZZZEEEE____LLLLAAAABBBBEEEELLLL

     where CCCCAAAAEEEESSSSAAAARRRR____HHHHIIIINNNNTTTT____SSSSIIIIZZZZEEEE____LLLLAAAABBBBEEEELLLL is a variable defined by:

              eeeexxxxtttteeeerrrrnnnn CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL CCCCAAAAEEEESSSSAAAARRRR____HHHHIIIINNNNTTTT____SSSSIIIIZZZZEEEE____LLLLAAAABBBBEEEELLLL;;;;

     This variable should be defined, properly  initialized,  and
     exported  by  ssssppppeeeecccc....cccc. It should neither be used nor assigned
     in any other program than  ssssppppeeeecccc....cccc.  This  variable  is  only
     introduced  for  efficiency reasons, i.e., to avoid the cost
     of a function call.

      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____HHHHAAAASSSSHHHH____SSSSIIIIZZZZEEEE____LLLLAAAABBBBEEEELLLL

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL CCCCAAAAEEEESSSSAAAARRRR____HHHHAAAASSSSHHHH____SSSSIIIIZZZZEEEE____LLLLAAAABBBBEEEELLLL (((())))
        {{{{ ............ }}}}

     This function returns a number of bytes N such that, for any
     label  pointed  to by a variable CCCCAAAAEEEESSSSAAAARRRR____LLLL, one can compute a
     hash function which takes into account the value of the fol-
     lowing  bytes:  CCCCAAAAEEEESSSSAAAARRRR____LLLL [0], CCCCAAAAEEEESSSSAAAARRRR____LLLL [1], ... and CCCCAAAAEEEESSSSAAAARRRR____LLLL
     [N-1].

     Note: It is always true that:

        0 < CCCCAAAAEEEESSSSAAAARRRR____HHHHAAAASSSSHHHH____SSSSIIIIZZZZEEEE____LLLLAAAABBBBEEEELLLL (((()))) <= CCCCAAAAEEEESSSSAAAARRRR____SSSSIIIIZZZZEEEE____LLLLAAAABBBBEEEELLLL (((())))

     but it is possible that:

           CCCCAAAAEEEESSSSAAAARRRR____HHHHAAAASSSSHHHH____SSSSIIIIZZZZEEEE____LLLLAAAABBBBEEEELLLL (((()))) < CCCCAAAAEEEESSSSAAAARRRR____SSSSIIIIZZZZEEEE____LLLLAAAABBBBEEEELLLL (((())))

     especially if the label vector contains variables of pointer
     types.  By  using  this  function, users can write their own
     hash functions.

     Implementation note: Practically, in  ccccaaaaeeeessssaaaarrrr____ggggrrrraaaapppphhhh....hhhh,  func-
     tion CCCCAAAAEEEESSSSAAAARRRR____HHHHAAAASSSSHHHH____SSSSIIIIZZZZEEEE____LLLLAAAABBBBEEEELLLL(((()))) is defined as follows:

              ####ddddeeeeffffiiiinnnneeee CCCCAAAAEEEESSSSAAAARRRR____HHHHAAAASSSSHHHH____SSSSIIIIZZZZEEEE____LLLLAAAABBBBEEEELLLL(((()))) CCCCAAAAEEEESSSSAAAARRRR____HHHHIIIINNNNTTTT____HHHHAAAASSSSHHHH____SSSSIIIIZZZZEEEE____LLLLAAAABBBBEEEELLLL

     where CCCCAAAAEEEESSSSAAAARRRR____HHHHIIIINNNNTTTT____HHHHAAAASSSSHHHH____SSSSIIIIZZZZEEEE____LLLLAAAABBBBEEEELLLL is a variable defined by:




(C) INRIA     Last change: 2020/02/11 (version 2.4)            11






OPEN/CAESAR MANUAL                            caesar_graph(LOCAL)



              eeeexxxxtttteeeerrrrnnnn CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL CCCCAAAAEEEESSSSAAAARRRR____HHHHIIIINNNNTTTT____HHHHAAAASSSSHHHH____SSSSIIIIZZZZEEEE____LLLLAAAABBBBEEEELLLL;;;;

     This variable should be defined, properly  initialized,  and
     exported  by  ssssppppeeeecccc....cccc. It should neither be used nor assigned
     in any other program than  ssssppppeeeecccc....cccc.  This  variable  is  only
     introduced  for  efficiency reasons, i.e., to avoid the cost
     of a function call.

      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____AAAALLLLIIIIGGGGNNNNMMMMEEEENNNNTTTT____LLLLAAAABBBBEEEELLLL

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL CCCCAAAAEEEESSSSAAAARRRR____AAAALLLLIIIIGGGGNNNNMMMMEEEENNNNTTTT____LLLLAAAABBBBEEEELLLL (((())))
        {{{{ ............ }}}}

     This function returns the alignment factor  (in  bytes)  for
     labels.  The alignment factor is always a power of two, usu-
     ally 1, 2, 4, or 8. Any byte  string  representing  a  label
     must  be  aligned  on a boundary that is an even multiple of
     the alignment factor.

     Implementation note: Practically, in  ccccaaaaeeeessssaaaarrrr____ggggrrrraaaapppphhhh....hhhh,  func-
     tion CCCCAAAAEEEESSSSAAAARRRR____AAAALLLLIIIIGGGGNNNNMMMMEEEENNNNTTTT____LLLLAAAABBBBEEEELLLL(((()))) is defined as follows:

              ####ddddeeeeffffiiiinnnneeee CCCCAAAAEEEESSSSAAAARRRR____AAAALLLLIIIIGGGGNNNNMMMMEEEENNNNTTTT____LLLLAAAABBBBEEEELLLL(((()))) CCCCAAAAEEEESSSSAAAARRRR____HHHHIIIINNNNTTTT____AAAALLLLIIIIGGGGNNNNMMMMEEEENNNNTTTT____LLLLAAAABBBBEEEELLLL

     where CCCCAAAAEEEESSSSAAAARRRR____HHHHIIIINNNNTTTT____AAAALLLLIIIIGGGGNNNNMMMMEEEENNNNTTTT____LLLLAAAABBBBEEEELLLL is a variable defined by:

              eeeexxxxtttteeeerrrrnnnn CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL CCCCAAAAEEEESSSSAAAARRRR____HHHHIIIINNNNTTTT____AAAALLLLIIIIGGGGNNNNMMMMEEEENNNNTTTT____LLLLAAAABBBBEEEELLLL;;;;

     This variable should be defined, properly  initialized,  and
     exported  by  ssssppppeeeecccc....cccc. It should neither be used nor assigned
     in any other program than  ssssppppeeeecccc....cccc.  This  variable  is  only
     introduced  for  efficiency reasons, i.e., to avoid the cost
     of a function call.

      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTEEEE____LLLLAAAABBBBEEEELLLL

     vvvvooooiiiidddd CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTEEEE____LLLLAAAABBBBEEEELLLL ((((CCCCAAAAEEEESSSSAAAARRRR____LLLL))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____LLLLAAAABBBBEEEELLLL ****CCCCAAAAEEEESSSSAAAARRRR____LLLL;;;;
        {{{{ ............ }}}}

     This  procedure  allocates   a   byte   string   of   length
     CCCCAAAAEEEESSSSAAAARRRR____SSSSIIIIZZZZEEEE____LLLLAAAABBBBEEEELLLL(((())))  using  CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTEEEE(((())))  and assigns its
     address to ****CCCCAAAAEEEESSSSAAAARRRR____LLLL. If  the  allocation  fails,  the  NNNNUUUULLLLLLLL
     value is assigned to ****CCCCAAAAEEEESSSSAAAARRRR____LLLL.

     Note: because CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____LLLLAAAABBBBEEEELLLL is a pointer type, any vari-
     able  CCCCAAAAEEEESSSSAAAARRRR____LLLL  of  type CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____LLLLAAAABBBBEEEELLLL must be allocated
     before used, for instance using:



(C) INRIA     Last change: 2020/02/11 (version 2.4)            12






OPEN/CAESAR MANUAL                            caesar_graph(LOCAL)




                   CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTEEEE____LLLLAAAABBBBEEEELLLL ((((&&&&CCCCAAAAEEEESSSSAAAARRRR____LLLL))));;;;

     However, it is not necessary to use  CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTEEEE____LLLLAAAABBBBEEEELLLL  to
     perform  the  allocation. Instead, users can allocate labels
     into their own data structures (tables, lists, ...)

     Implementation  note:  It  is  not   necessary   to   define
     CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTEEEE____LLLLAAAABBBBEEEELLLL(((())))   in   ssssppppeeeecccc....cccc  because  ccccaaaaeeeessssaaaarrrr____ggggrrrraaaapppphhhh....hhhh
     already implements this procedure using a macro-definition.

      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____DDDDEEEELLLLEEEETTTTEEEE____LLLLAAAABBBBEEEELLLL

     vvvvooooiiiidddd CCCCAAAAEEEESSSSAAAARRRR____DDDDEEEELLLLEEEETTTTEEEE____LLLLAAAABBBBEEEELLLL ((((CCCCAAAAEEEESSSSAAAARRRR____LLLL))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____LLLLAAAABBBBEEEELLLL ****CCCCAAAAEEEESSSSAAAARRRR____LLLL;;;;
        {{{{ ............ }}}}

     This   procedure   frees   the   byte   string   of   length
     CCCCAAAAEEEESSSSAAAARRRR____SSSSIIIIZZZZEEEE____LLLLAAAABBBBEEEELLLL(((())))    pointed   to   by   ****CCCCAAAAEEEESSSSAAAARRRR____LLLL   using
     CCCCAAAAEEEESSSSAAAARRRR____DDDDEEEELLLLEEEETTTTEEEE(((()))). Afterwards, the NNNNUUUULLLLLLLL value is  assigned  to
     ****CCCCAAAAEEEESSSSAAAARRRR____LLLL.

     Implementation  note:  It  is  not   necessary   to   define
     CCCCAAAAEEEESSSSAAAARRRR____DDDDEEEELLLLEEEETTTTEEEE____LLLLAAAABBBBEEEELLLL(((())))   in   ssssppppeeeecccc....cccc  because  ccccaaaaeeeessssaaaarrrr____ggggrrrraaaapppphhhh....hhhh
     already implements this procedure using a macro-definition.

      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____VVVVIIIISSSSIIIIBBBBLLLLEEEE____LLLLAAAABBBBEEEELLLL

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____BBBBOOOOOOOOLLLLEEEEAAAANNNN CCCCAAAAEEEESSSSAAAARRRR____VVVVIIIISSSSIIIIBBBBLLLLEEEE____LLLLAAAABBBBEEEELLLL ((((CCCCAAAAEEEESSSSAAAARRRR____LLLL))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____LLLLAAAABBBBEEEELLLL CCCCAAAAEEEESSSSAAAARRRR____LLLL;;;;
        {{{{ ............ }}}}

     This function returns a value different from 0 if the  label
     pointed to by CCCCAAAAEEEESSSSAAAARRRR____LLLL is visible, or 0 if it is not visible
     (i.e., ``tau'').

      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____GGGGAAAATTTTEEEE____LLLLAAAABBBBEEEELLLL

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSTTTTRRRRIIIINNNNGGGG CCCCAAAAEEEESSSSAAAARRRR____GGGGAAAATTTTEEEE____LLLLAAAABBBBEEEELLLL ((((CCCCAAAAEEEESSSSAAAARRRR____LLLL))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____LLLLAAAABBBBEEEELLLL CCCCAAAAEEEESSSSAAAARRRR____LLLL;;;;
        {{{{ ............ }}}}

     This function returns a pointer to a character  string  con-
     taining  the  name  of  the  gate  associated with the label
     pointed to by CCCCAAAAEEEESSSSAAAARRRR____LLLL. If this label is not visible  (i.e.,
     ``tau''), a pointer to the constant string iiii is returned.



(C) INRIA     Last change: 2020/02/11 (version 2.4)            13






OPEN/CAESAR MANUAL                            caesar_graph(LOCAL)



     Note: in order to determine if the gate of the label pointed
     to by CCCCAAAAEEEESSSSAAAARRRR____LLLL is not ``tau'', using:

                   CCCCAAAAEEEESSSSAAAARRRR____VVVVIIIISSSSIIIIBBBBLLLLEEEE____LLLLAAAABBBBEEEELLLL ((((CCCCAAAAEEEESSSSAAAARRRR____LLLL))))

     is more efficient than performing a string comparison:

           ssssttttrrrrccccmmmmpppp ((((CCCCAAAAEEEESSSSAAAARRRR____GGGGAAAATTTTEEEE____LLLLAAAABBBBEEEELLLL ((((CCCCAAAAEEEESSSSAAAARRRR____LLLL)))),,,, """"iiii"""")))) !!!!==== 0000


     Note: It is not  allowed  to  modify  the  character  string
     returned by CCCCAAAAEEEESSSSAAAARRRR____GGGGAAAATTTTEEEE____LLLLAAAABBBBEEEELLLL(((()))) nor to free it, for instance
     using ffffrrrreeeeeeee((((3333)))).

     Note: The contents  of  the  character  string  returned  by
     CCCCAAAAEEEESSSSAAAARRRR____GGGGAAAATTTTEEEE____LLLLAAAABBBBEEEELLLL(((()))) may be destroyed by a subsequent call to
     this function.

      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____CCCCAAAARRRRDDDDIIIINNNNAAAALLLL____LLLLAAAABBBBEEEELLLL

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL CCCCAAAAEEEESSSSAAAARRRR____CCCCAAAARRRRDDDDIIIINNNNAAAALLLL____LLLLAAAABBBBEEEELLLL ((((CCCCAAAAEEEESSSSAAAARRRR____LLLL))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____LLLLAAAABBBBEEEELLLL CCCCAAAAEEEESSSSAAAARRRR____LLLL;;;;
        {{{{ ............ }}}}

     This function returns the number of experiment offers  asso-
     ciated  with  the  label  pointed  to  by CCCCAAAAEEEESSSSAAAARRRR____LLLL. The gate
     itself does not count.

      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____CCCCOOOOPPPPYYYY____LLLLAAAABBBBEEEELLLL

     vvvvooooiiiidddd CCCCAAAAEEEESSSSAAAARRRR____CCCCOOOOPPPPYYYY____LLLLAAAABBBBEEEELLLL ((((CCCCAAAAEEEESSSSAAAARRRR____LLLL1111,,,, CCCCAAAAEEEESSSSAAAARRRR____LLLL2222))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____LLLLAAAABBBBEEEELLLL CCCCAAAAEEEESSSSAAAARRRR____LLLL1111;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____LLLLAAAABBBBEEEELLLL CCCCAAAAEEEESSSSAAAARRRR____LLLL2222;;;;
        {{{{ ............ }}}}

     This procedure copies the label pointed to by CCCCAAAAEEEESSSSAAAARRRR____LLLL2222 onto
     the label pointed to by CCCCAAAAEEEESSSSAAAARRRR____LLLL1111.

     Note: Parameter CCCCAAAAEEEESSSSAAAARRRR____LLLL2222 must point to  a  memory  location
     allocated before procedure CCCCAAAAEEEESSSSAAAARRRR____CCCCOOOOPPPPYYYY____LLLLAAAABBBBEEEELLLL(((()))) is invoked.

     Implementation  note:  It  is  not   necessary   to   define
     CCCCAAAAEEEESSSSAAAARRRR____CCCCOOOOPPPPYYYY____LLLLAAAABBBBEEEELLLL(((()))) in ssssppppeeeecccc....cccc because ccccaaaaeeeessssaaaarrrr____ggggrrrraaaapppphhhh....hhhh already
     implements this procedure using a macro-definition.

      ............................................................





(C) INRIA     Last change: 2020/02/11 (version 2.4)            14






OPEN/CAESAR MANUAL                            caesar_graph(LOCAL)



  CCCCAAAAEEEESSSSAAAARRRR____CCCCOOOOMMMMPPPPAAAARRRREEEE____LLLLAAAABBBBEEEELLLL

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____BBBBOOOOOOOOLLLLEEEEAAAANNNN CCCCAAAAEEEESSSSAAAARRRR____CCCCOOOOMMMMPPPPAAAARRRREEEE____LLLLAAAABBBBEEEELLLL ((((CCCCAAAAEEEESSSSAAAARRRR____LLLL1111,,,, CCCCAAAAEEEESSSSAAAARRRR____LLLL2222))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____LLLLAAAABBBBEEEELLLL CCCCAAAAEEEESSSSAAAARRRR____LLLL1111;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____LLLLAAAABBBBEEEELLLL CCCCAAAAEEEESSSSAAAARRRR____LLLL2222;;;;
        {{{{ ............ }}}}

     This function returns a  value  different  from  0  if  both
     labels  pointed to by CCCCAAAAEEEESSSSAAAARRRR____LLLL1111 and CCCCAAAAEEEESSSSAAAARRRR____LLLL2222 are identical,
     or 0 if they are not.

      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____HHHHAAAASSSSHHHH____LLLLAAAABBBBEEEELLLL

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL CCCCAAAAEEEESSSSAAAARRRR____HHHHAAAASSSSHHHH____LLLLAAAABBBBEEEELLLL ((((CCCCAAAAEEEESSSSAAAARRRR____LLLL,,,, CCCCAAAAEEEESSSSAAAARRRR____MMMMOOOODDDDUUUULLLLUUUUSSSS))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____LLLLAAAABBBBEEEELLLL CCCCAAAAEEEESSSSAAAARRRR____LLLL;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL CCCCAAAAEEEESSSSAAAARRRR____MMMMOOOODDDDUUUULLLLUUUUSSSS;;;;
        {{{{ ............ }}}}

     This function computes  a  hash-code  value  for  the  label
     pointed to by CCCCAAAAEEEESSSSAAAARRRR____LLLL and returns this value, which must be
     in the range 0..CCCCAAAAEEEESSSSAAAARRRR____MMMMOOOODDDDUUUULLLLUUUUSSSS-1.

      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____PPPPRRRRIIIINNNNTTTT____LLLLAAAABBBBEEEELLLL

     vvvvooooiiiidddd CCCCAAAAEEEESSSSAAAARRRR____PPPPRRRRIIIINNNNTTTT____LLLLAAAABBBBEEEELLLL ((((CCCCAAAAEEEESSSSAAAARRRR____FFFFIIIILLLLEEEE,,,, CCCCAAAAEEEESSSSAAAARRRR____LLLL))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____FFFFIIIILLLLEEEE CCCCAAAAEEEESSSSAAAARRRR____FFFFIIIILLLLEEEE;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____LLLLAAAABBBBEEEELLLL CCCCAAAAEEEESSSSAAAARRRR____LLLL;;;;
        {{{{ ............ }}}}

     This procedure prints to file CCCCAAAAEEEESSSSAAAARRRR____FFFFIIIILLLLEEEE a character string
     describing the contents of the label pointed to by CCCCAAAAEEEESSSSAAAARRRR____LLLL.
     This string should not contain the special  characters  new-
     line  (``\nnnn'')  or carriage-return (``\rrrr''). If the label is
     not visible, the string printed is iiii.

     Before this procedure is called, CCCCAAAAEEEESSSSAAAARRRR____FFFFIIIILLLLEEEE must have  been
     properly opened, for instance using ffffooooppppeeeennnn((((3333)))).

      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____SSSSTTTTRRRRIIIINNNNGGGG____LLLLAAAABBBBEEEELLLL

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSTTTTRRRRIIIINNNNGGGG CCCCAAAAEEEESSSSAAAARRRR____SSSSTTTTRRRRIIIINNNNGGGG____LLLLAAAABBBBEEEELLLL ((((CCCCAAAAEEEESSSSAAAARRRR____LLLL))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____LLLLAAAABBBBEEEELLLL CCCCAAAAEEEESSSSAAAARRRR____LLLL;;;;
        {{{{ ............ }}}}

     This function returns a pointer to a character string  (ter-
     minated  by  the  ````\0000'''' character) describing the contents of



(C) INRIA     Last change: 2020/02/11 (version 2.4)            15






OPEN/CAESAR MANUAL                            caesar_graph(LOCAL)



     the label pointed to by CCCCAAAAEEEESSSSAAAARRRR____LLLL.  This  string  should  not
     contain   the   special   characters  new-line  (``\nnnn'')  or
     carriage-return (``\rrrr''). If the label is not  visible,  the
     string returned is iiii.

     Note: It is not  allowed  to  modify  the  character  string
     returned  by  CCCCAAAAEEEESSSSAAAARRRR____SSSSTTTTRRRRIIIINNNNGGGG____LLLLAAAABBBBEEEELLLL(((())))  nor  to  free  it,  for
     instance using ffffrrrreeeeeeee((((3333)))).

     Note: The contents  of  the  character  string  returned  by
     CCCCAAAAEEEESSSSAAAARRRR____SSSSTTTTRRRRIIIINNNNGGGG____LLLLAAAABBBBEEEELLLL(((())))  may be destroyed by a subsequent call
     to this function.

      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____FFFFOOOORRRRMMMMAAAATTTT____LLLLAAAABBBBEEEELLLL

     vvvvooooiiiidddd CCCCAAAAEEEESSSSAAAARRRR____FFFFOOOORRRRMMMMAAAATTTT____LLLLAAAABBBBEEEELLLL ((((CCCCAAAAEEEESSSSAAAARRRR____FFFFOOOORRRRMMMMAAAATTTT))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____FFFFOOOORRRRMMMMAAAATTTT CCCCAAAAEEEESSSSAAAARRRR____FFFFOOOORRRRMMMMAAAATTTT;;;;
        {{{{ ............ }}}}

     This procedure allows to control the format under which  the
     information attached to labels is displayed by the procedure
     CCCCAAAAEEEESSSSAAAARRRR____IIIINNNNFFFFOOOORRRRMMMMAAAATTTTIIIIOOOONNNN____LLLLAAAABBBBEEEELLLL(((()))) (see below).

     _C_A_E_S_A_R-specific note: 3 different  label  formats  (numbered
     from 0 to 2) are available.

     By default, the current label format is initialized to 0.

     When called with CCCCAAAAEEEESSSSAAAARRRR____FFFFOOOORRRRMMMMAAAATTTT between  0  and  the  maximal
     format value supported, this fonction sets the current label
     format to CCCCAAAAEEEESSSSAAAARRRR____FFFFOOOORRRRMMMMAAAATTTT and returns an undefined result.

     When called with another value of CCCCAAAAEEEESSSSAAAARRRR____FFFFOOOORRRRMMMMAAAATTTT, this  func-
     tion  does not modify the current label format but returns a
     result defined as follows. If CCCCAAAAEEEESSSSAAAARRRR____FFFFOOOORRRRMMMMAAAATTTT is equal to  the
     constant  CCCCAAAAEEEESSSSAAAARRRR____CCCCUUUURRRRRRRREEEENNNNTTTT____FFFFOOOORRRRMMMMAAAATTTT,  the result is the value of
     the current label format. If CCCCAAAAEEEESSSSAAAARRRR____FFFFOOOORRRRMMMMAAAATTTT is equal  to  the
     constant  CCCCAAAAEEEESSSSAAAARRRR____MMMMAAAAXXXXIIIIMMMMAAAALLLL____FFFFOOOORRRRMMMMAAAATTTT,  the  result is the maximal
     format value (e.g., 2 in the case of _C_A_E_S_A_R). In  all  other
     cases, the effect of this function is undefined.

      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____MMMMAAAAXXXX____FFFFOOOORRRRMMMMAAAATTTT____LLLLAAAABBBBEEEELLLL

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____FFFFOOOORRRRMMMMAAAATTTT CCCCAAAAEEEESSSSAAAARRRR____MMMMAAAAXXXX____FFFFOOOORRRRMMMMAAAATTTT____LLLLAAAABBBBEEEELLLL (((())))
        {{{{ ............ }}}}

     Caution! This function is deprecated. It should no longer be
     used,  as  it  might  be removed from future versions of the



(C) INRIA     Last change: 2020/02/11 (version 2.4)            16






OPEN/CAESAR MANUAL                            caesar_graph(LOCAL)



     _O_P_E_N/_C_A_E_S_A_R.  Use  function  CCCCAAAAEEEESSSSAAAARRRR____FFFFOOOORRRRMMMMAAAATTTT____LLLLAAAABBBBEEEELLLL(((())))  instead,
     called with argument CCCCAAAAEEEESSSSAAAARRRR____MMMMAAAAXXXXIIIIMMMMAAAALLLL____FFFFOOOORRRRMMMMAAAATTTT.

     This function returns the highest format available for label
     printing, i.e., the highest acceptable value for the parame-
     ter CCCCAAAAEEEESSSSAAAARRRR____FFFFOOOORRRRMMMMAAAATTTT of function CCCCAAAAEEEESSSSAAAARRRR____FFFFOOOORRRRMMMMAAAATTTT____LLLLAAAABBBBEEEELLLL(((()))).

      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____IIIINNNNFFFFOOOORRRRMMMMAAAATTTTIIIIOOOONNNN____LLLLAAAABBBBEEEELLLL

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSTTTTRRRRIIIINNNNGGGG CCCCAAAAEEEESSSSAAAARRRR____IIIINNNNFFFFOOOORRRRMMMMAAAATTTTIIIIOOOONNNN____LLLLAAAABBBBEEEELLLL ((((CCCCAAAAEEEESSSSAAAARRRR____LLLL))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____LLLLAAAABBBBEEEELLLL CCCCAAAAEEEESSSSAAAARRRR____LLLL;;;;
        {{{{ ............ }}}}

     This function returns a character  string  containing  addi-
     tional  information  about the label pointed to by CCCCAAAAEEEESSSSAAAARRRR____LLLL.
     The nature of the information is determined by  the  current
     label format (see procedure CCCCAAAAEEEESSSSAAAARRRR____FFFFOOOORRRRMMMMAAAATTTT____LLLLAAAABBBBEEEELLLL(((()))) above). If
     the current label format is null, this function returns  the
     empty string ``''.

     Note: It is not  allowed  to  modify  the  character  string
     returned  by  CCCCAAAAEEEESSSSAAAARRRR____IIIINNNNFFFFOOOORRRRMMMMAAAATTTTIIIIOOOONNNN____LLLLAAAABBBBEEEELLLL(((()))) nor to free it, for
     instance using ffffrrrreeeeeeee((((3333)))).

     Note: The contents  of  the  character  string  returned  by
     CCCCAAAAEEEESSSSAAAARRRR____IIIINNNNFFFFOOOORRRRMMMMAAAATTTTIIIIOOOONNNN____LLLLAAAABBBBEEEELLLL(((())))  may be destroyed by a subsequent
     call to this function.

     _C_A_E_S_A_R-specific note: Currently, the following  formats  are
     available:


     -    If the current label format is 0: the empty string ``''
          is returned.

     -    If the current label  format  is  1:  if  the  label  L
          pointed  to  by  CCCCAAAAEEEESSSSAAAARRRR____LLLL  is visible, the empty string
          ``'' is returned; if L is not visible and derives  from
          some  gate  G hidden by a hhhhiiiiddddeeee instruction, a character
          string containing the name of G,  its  definition  file
          and  definition  line  is returned; if L is not visible
          and derives from an eeeexxxxiiiitttt statement, the constant  char-
          acter  string eeeexxxxiiiitttt is returned; if L is not visible and
          derives from an iiii;;;; ............ statement, the constant  charac-
          ter string iiii is returned.

     -    If the current label format is 2:  a  character  string
          containing the (unique) number of the Petri Net transi-
          tion corresponding to the edge whose label  is  pointed
          to  by  CCCCAAAAEEEESSSSAAAARRRR____LLLL  is  returned.  This transition can be



(C) INRIA     Last change: 2020/02/11 (version 2.4)            17






OPEN/CAESAR MANUAL                            caesar_graph(LOCAL)



          found in the ....nnnneeeetttt file generated by _C_A_E_S_A_R  with  ----nnnneeeetttt----
          wwwwoooorrrrkkkk option.

EEEEDDDDGGGGEEEE FFFFEEEEAAAATTTTUUUURRRREEEESSSS
      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____SSSSTTTTAAAARRRRTTTT____SSSSTTTTAAAATTTTEEEE

     vvvvooooiiiidddd CCCCAAAAEEEESSSSAAAARRRR____SSSSTTTTAAAARRRRTTTT____SSSSTTTTAAAATTTTEEEE ((((CCCCAAAAEEEESSSSAAAARRRR____SSSS))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSTTTTAAAATTTTEEEE CCCCAAAAEEEESSSSAAAARRRR____SSSS;;;;
        {{{{ ............ }}}}

     This procedure copies into the state pointed to by  CCCCAAAAEEEESSSSAAAARRRR____SSSS
     the contents of the initial state of the labelled transition
     system.

     Note: Parameter CCCCAAAAEEEESSSSAAAARRRR____SSSS must point  to  a  memory  location
     allocated before procedure CCCCAAAAEEEESSSSAAAARRRR____SSSSTTTTAAAARRRRTTTT____SSSSTTTTAAAATTTTEEEE(((()))) is invoked.

      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____IIIITTTTEEEERRRRAAAATTTTEEEE____SSSSTTTTAAAATTTTEEEE

     vvvvooooiiiidddd CCCCAAAAEEEESSSSAAAARRRR____IIIITTTTEEEERRRRAAAATTTTEEEE____SSSSTTTTAAAATTTTEEEE ((((CCCCAAAAEEEESSSSAAAARRRR____SSSS1111,,,, CCCCAAAAEEEESSSSAAAARRRR____LLLL,,,, CCCCAAAAEEEESSSSAAAARRRR____SSSS2222,,,, CCCCAAAAEEEESSSSAAAARRRR____LLLLOOOOOOOOPPPP))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSTTTTAAAATTTTEEEE CCCCAAAAEEEESSSSAAAARRRR____SSSS1111;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____LLLLAAAABBBBEEEELLLL CCCCAAAAEEEESSSSAAAARRRR____LLLL;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSTTTTAAAATTTTEEEE CCCCAAAAEEEESSSSAAAARRRR____SSSS2222;;;;
        vvvvooooiiiidddd ((((****CCCCAAAAEEEESSSSAAAARRRR____LLLLOOOOOOOOPPPP)))) ((((CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSTTTTAAAATTTTEEEE,,,, CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____LLLLAAAABBBBEEEELLLL,,,,
           CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSTTTTAAAATTTTEEEE))));;;;
        {{{{ ............ }}}}

     This procedure provides an  iterator  which  enumerates  all
     successors  of  the  state  pointed to by CCCCAAAAEEEESSSSAAAARRRR____SSSS1111. At each
     iteration, the label pointed to by CCCCAAAAEEEESSSSAAAARRRR____LLLL  and  the  state
     pointed  to by CCCCAAAAEEEESSSSAAAARRRR____SSSS2222 are assigned a new value, such that
     ``(CCCCAAAAEEEESSSSAAAARRRR____SSSS1111, CCCCAAAAEEEESSSSAAAARRRR____LLLL,  CCCCAAAAEEEESSSSAAAARRRR____SSSS2222)''  is  an  edge  of  the
     labelled  transition  system. At each iteration, the C func-
     tion pointed to by CCCCAAAAEEEESSSSAAAARRRR____LLLLOOOOOOOOPPPP is invoked, with the  follow-
     ing parameters:

           ((((****CCCCAAAAEEEESSSSAAAARRRR____LLLLOOOOOOOOPPPP)))) ((((CCCCAAAAEEEESSSSAAAARRRR____SSSS1111,,,, CCCCAAAAEEEESSSSAAAARRRR____LLLL,,,, CCCCAAAAEEEESSSSAAAARRRR____SSSS2222))))



     Therefore, any actual  parameter  supplied  for  the  formal
     parameter  CCCCAAAAEEEESSSSAAAARRRR____LLLLOOOOOOOOPPPP  must be a pointer to a function, say
     ccccaaaaeeeessssaaaarrrr____ffff, whose declaration is:


             vvvvooooiiiidddd ccccaaaaeeeessssaaaarrrr____ffff ((((ccccaaaaeeeessssaaaarrrr____ssss1111,,,, ccccaaaaeeeessssaaaarrrr____llll,,,, ccccaaaaeeeessssaaaarrrr____ssss2222))))
                CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSTTTTAAAATTTTEEEE ccccaaaaeeeessssaaaarrrr____ssss1111;;;;
                CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____LLLLAAAABBBBEEEELLLL ccccaaaaeeeessssaaaarrrr____llll;;;;



(C) INRIA     Last change: 2020/02/11 (version 2.4)            18






OPEN/CAESAR MANUAL                            caesar_graph(LOCAL)



                CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSTTTTAAAATTTTEEEE ccccaaaaeeeessssaaaarrrr____ssss2222;;;;
                {{{{............}}}}

     Note: Parameters CCCCAAAAEEEESSSSAAAARRRR____SSSS1111,  CCCCAAAAEEEESSSSAAAARRRR____LLLL,  and  CCCCAAAAEEEESSSSAAAARRRR____SSSS2222  must
     point  to  (distinct) memory locations allocated before pro-
     cedure CCCCAAAAEEEESSSSAAAARRRR____IIIITTTTEEEERRRRAAAATTTTEEEE____SSSSTTTTAAAATTTTEEEE(((()))) is invoked. In no  event  will
     CCCCAAAAEEEESSSSAAAARRRR____IIIITTTTEEEERRRRAAAATTTTEEEE____SSSSTTTTAAAATTTTEEEE(((()))) and CCCCAAAAEEEESSSSAAAARRRR____LLLLOOOOOOOOPPPP(((()))) allocate memory for
     storing CCCCAAAAEEEESSSSAAAARRRR____LLLL and CCCCAAAAEEEESSSSAAAARRRR____SSSS2222.

     Note: More often than not, this  function  will  have  side-
     effects. For instance, this function may count the number of
     successors, or store them in a list, a table, ...

     Note: It is probably a good programming style  to  keep  the
     body of this function as short as possible.

     Note: The C code that implements  CCCCAAAAEEEESSSSAAAARRRR____IIIITTTTEEEERRRRAAAATTTTEEEE____SSSSTTTTAAAATTTTEEEE(((())))  in
     ssssppppeeeecccc....cccc may be not reentrant. In such case, nested iterations
     will not work properly. This implies that any actual parame-
     ter  ccccaaaaeeeessssaaaarrrr____ffff  supplied to formal parameter CCCCAAAAEEEESSSSAAAARRRR____LLLLOOOOOOOOPPPP must
     not call (directly, nor transitively)  CCCCAAAAEEEESSSSAAAARRRR____IIIITTTTEEEERRRRAAAATTTTEEEE____SSSSTTTTAAAATTTTEEEE.
     Practically, this restriction has no effect on breadth-first
     explorations. However, it affects the way of writing  depth-
     first  explorations:  for  a  given state S, it is necessary
     first to compute all successors of S and to  store  them  in
     some  data  structure, before starting to explore these suc-
     cessors.

     _C_A_E_S_A_R-specific note: The C code  generated  by  _C_A_E_S_A_R  for
     CCCCAAAAEEEESSSSAAAARRRR____IIIITTTTEEEERRRRAAAATTTTEEEE____SSSSTTTTAAAATTTTEEEE(((())))  is  not  reentrant  (at least in the
     current version).

OOOOBBBBSSSSOOOOLLLLEEEETTTTEEEE FFFFEEEEAAAATTTTUUUURRRREEEESSSS
      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____DDDDUUUUMMMMPPPP____LLLLAAAABBBBEEEELLLL

     vvvvooooiiiidddd CCCCAAAAEEEESSSSAAAARRRR____DDDDUUUUMMMMPPPP____LLLLAAAABBBBEEEELLLL ((((CCCCAAAAEEEESSSSAAAARRRR____SSSSTTTTRRRRIIIINNNNGGGG,,,, CCCCAAAAEEEESSSSAAAARRRR____LLLL))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSTTTTRRRRIIIINNNNGGGG CCCCAAAAEEEESSSSAAAARRRR____SSSSTTTTRRRRIIIINNNNGGGG;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____LLLLAAAABBBBEEEELLLL CCCCAAAAEEEESSSSAAAARRRR____LLLL;;;;
        {{{{ ............ }}}}

     This procedure has been removed from  the  ``graph  module''
     application programming interface in October 2002 and should
     no longer be implemented, nor used in  _O_P_E_N/_C_A_E_S_A_R  applica-
     tion programs.

      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____RRRRAAAANNNNKKKK____LLLLAAAABBBBEEEELLLL

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL CCCCAAAAEEEESSSSAAAARRRR____RRRRAAAANNNNKKKK____LLLLAAAABBBBEEEELLLL ((((CCCCAAAAEEEESSSSAAAARRRR____LLLL))))



(C) INRIA     Last change: 2020/02/11 (version 2.4)            19






OPEN/CAESAR MANUAL                            caesar_graph(LOCAL)



        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____LLLLAAAABBBBEEEELLLL CCCCAAAAEEEESSSSAAAARRRR____LLLL;;;;
        {{{{ ............ }}}}

     This function has been removed  from  the  ``graph  module''
     application programming interface in October 2002 and should
     no longer be implemented, nor used in  _O_P_E_N/_C_A_E_S_A_R  applica-
     tion programs.

      ............................................................

AAAAUUUUTTTTHHHHOOOORRRR((((SSSS))))
     Hubert Garavel

FFFFIIIILLLLEEEESSSS
     $$$$CCCCAAAADDDDPPPP////iiiinnnnccccllll////ccccaaaaeeeessssaaaarrrr____ggggrrrraaaapppphhhh....hhhh     interface of the graph module
     $$$$CCCCAAAADDDDPPPP////iiiinnnnccccllll////ccccaaaaeeeessssaaaarrrr____****....hhhh         interfaces  of   the   storage
                                   module
     $$$$CCCCAAAADDDDPPPP////bbbbiiiinnnn....````aaaarrrrcccchhhh````////lllliiiibbbbccccaaaaeeeessssaaaarrrr....aaaa  object  code  of  the  storage
                                   module
     $$$$CCCCAAAADDDDPPPP////ssssrrrrcccc////ooooppppeeeennnn____ccccaaaaeeeessssaaaarrrr////****....cccc     source   code    of    various
                                   exploration modules
     $$$$CCCCAAAADDDDPPPP////ccccoooommmm////lllloooottttoooossss....ooooppppeeeennnn          shell    script     to     run
                                   OPEN/CAESAR

SSSSEEEEEEEE AAAALLLLSSSSOOOO
     Reference Manuals of OPEN/CAESAR,  CAESAR,  and  CAESAR.ADT,
     lllloooottttoooossss....ooooppppeeeennnn(LOCAL), ccccaaaaeeeessssaaaarrrr(LOCAL), ccccaaaaeeeessssaaaarrrr....aaaaddddtttt(LOCAL)

     Additional information is available from the CADP  Web  page
     located at http://cadp.inria.fr

     Directives   for   installation   are   given    in    files
     $$$$CCCCAAAADDDDPPPP////IIIINNNNSSSSTTTTAAAALLLLLLLLAAAATTTTIIIIOOOONNNN____****....

     Recent  changes  and  improvements  to  this  software   are
     reported and commented in file $$$$CCCCAAAADDDDPPPP////HHHHIIIISSSSTTTTOOOORRRRYYYY....

BBBBUUUUGGGGSSSS
     Known  bugs  are  described  in  the  Reference  Manual   of
     OPEN/CAESAR.  Please report new bugs to cadp@inria.fr















(C) INRIA     Last change: 2020/02/11 (version 2.4)            20



