


OPEN/CAESAR MANUAL                         caesar_standard(LOCAL)



NNNNAAAAMMMMEEEE
     caesar_standard - the ``standard'' library of OPEN/CAESAR

PPPPUUUURRRRPPPPOOOOSSSSEEEE
     The ``standard'' library provides basic types and  notations
     shared by all _O_P_E_N/_C_A_E_S_A_R modules.



UUUUSSSSAAAAGGGGEEEE
     The ``standard''  library  only  consists  of  a  predefined
     header file ccccaaaaeeeessssaaaarrrr____ssssttttaaaannnnddddaaaarrrrdddd....hhhh.



FFFFEEEEAAAATTTTUUUURRRREEEESSSS
      ............................................................

     ####iiiinnnncccclllluuuuddddeeee <<<<ssssttttddddlllliiiibbbb....hhhh>>>>
     ####iiiinnnncccclllluuuuddddeeee <<<<ssssttttddddiiiioooo....hhhh>>>>
     ####iiiinnnncccclllluuuuddddeeee <<<<mmmmeeeemmmmoooorrrryyyy....hhhh>>>>
     ####iiiinnnncccclllluuuuddddeeee <<<<ssssiiiiggggnnnnaaaallll....hhhh>>>>

     Various standard C libraries  are  imported,  notably  those
     providing   functions   for   dynamic   memory   allocation,
     input/output, byte string facilities, and software  signals.
     In  particular,  the  FFFFIIIILLLLEEEE type and file handling primitives
     are imported.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL

     ttttyyyyppppeeeeddddeeeeffff uuuunnnnssssiiiiggggnnnneeeedddd lllloooonnnngggg CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL;;;;

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL is the unsigned  integer  type  used  in
     _O_P_E_N/_C_A_E_S_A_R.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____IIIINNNNTTTTEEEEGGGGEEEERRRR

     ttttyyyyppppeeeeddddeeeeffff lllloooonnnngggg CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____IIIINNNNTTTTEEEEGGGGEEEERRRR;;;;

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____IIIINNNNTTTTEEEEGGGGEEEERRRR is  the  signed  integer  type  used  in
     _O_P_E_N/_C_A_E_S_A_R.


      ............................................................




(C) INRIA     Last change: 2020/02/11 (version 1.3)             1






OPEN/CAESAR MANUAL                         caesar_standard(LOCAL)



  CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____BBBBOOOOOOOOLLLLEEEEAAAANNNN

     ttttyyyyppppeeeeddddeeeeffff uuuunnnnssssiiiiggggnnnneeeedddd cccchhhhaaaarrrr CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____BBBBOOOOOOOOLLLLEEEEAAAANNNN;;;;

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____BBBBOOOOOOOOLLLLEEEEAAAANNNN is the boolean type used in _O_P_E_N/_C_A_E_S_A_R.
     It  follows the usual conventions of the C language: 0 means
     ``false'' and any value different from 0 means ``true''.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____FFFFAAAALLLLSSSSEEEE

     ####ddddeeeeffffiiiinnnneeee CCCCAAAAEEEESSSSAAAARRRR____FFFFAAAALLLLSSSSEEEE ((((((((CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____BBBBOOOOOOOOLLLLEEEEAAAANNNN)))) 0000))))

     CCCCAAAAEEEESSSSAAAARRRR____FFFFAAAALLLLSSSSEEEE is the ``false'' boolean value.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____TTTTRRRRUUUUEEEE

     ####ddddeeeeffffiiiinnnneeee CCCCAAAAEEEESSSSAAAARRRR____TTTTRRRRUUUUEEEE ((((((((CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____BBBBOOOOOOOOLLLLEEEEAAAANNNN)))) 1111))))

     CCCCAAAAEEEESSSSAAAARRRR____TTTTRRRRUUUUEEEE is one possible ``true'' boolean value.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____BBBBYYYYTTTTEEEE

     ttttyyyyppppeeeeddddeeeeffff uuuunnnnssssiiiiggggnnnneeeedddd cccchhhhaaaarrrr CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____BBBBYYYYTTTTEEEE;;;;

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____BBBBYYYYTTTTEEEE is the byte type used in _O_P_E_N/_C_A_E_S_A_R.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSTTTTRRRRIIIINNNNGGGG

     ttttyyyyppppeeeeddddeeeeffff cccchhhhaaaarrrr ****CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSTTTTRRRRIIIINNNNGGGG;;;;

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSTTTTRRRRIIIINNNNGGGG is the string type (pointer to a  charac-
     ter   string   termined   by   a  null  character)  used  in
     _O_P_E_N/_C_A_E_S_A_R.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____FFFFIIIILLLLEEEE

     ttttyyyyppppeeeeddddeeeeffff FFFFIIIILLLLEEEE ****CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____FFFFIIIILLLLEEEE;;;;



(C) INRIA     Last change: 2020/02/11 (version 1.3)             2






OPEN/CAESAR MANUAL                         caesar_standard(LOCAL)



     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____FFFFIIIILLLLEEEE is the file type (pointer to a  POSIX  file
     descriptor) used in _O_P_E_N/_C_A_E_S_A_R.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____PPPPOOOOIIIINNNNTTTTEEEERRRR

     ttttyyyyppppeeeeddddeeeeffff uuuunnnnssssiiiiggggnnnneeeedddd cccchhhhaaaarrrr ****CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____PPPPOOOOIIIINNNNTTTTEEEERRRR;;;;

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____PPPPOOOOIIIINNNNTTTTEEEERRRR is a pointer to a (generic) byte string.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____GGGGEEEENNNNUUUUIIIINNNNEEEE____IIIINNNNTTTT

     ttttyyyyppppeeeeddddeeeeffff iiiinnnntttt CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____GGGGEEEENNNNUUUUIIIINNNNEEEE____IIIINNNNTTTT;;;;

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____GGGGEEEENNNNUUUUIIIINNNNEEEE____IIIINNNNTTTT is a 32-bit integer type; its  usage
     is   discouraged,   except  at  specific  places  where  the
     C~standard explicitly requires an ``int'' type to be used.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____AAAARRRRGGGGCCCC

     ttttyyyyppppeeeeddddeeeeffff CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____GGGGEEEENNNNUUUUIIIINNNNEEEE____IIIINNNNTTTT CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____AAAARRRRGGGGCCCC;;;;

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____AAAARRRRGGGGCCCC is a 32-bit integer type;  it  is  used  to
     declare  the  aaaarrrrggggcccc  parameter  of the mmmmaaaaiiiinnnn(((()))) function of a C
     program.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____AAAARRRRGGGGVVVV

     ttttyyyyppppeeeeddddeeeeffff cccchhhhaaaarrrr ********CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____AAAARRRRGGGGVVVV;;;;

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____AAAARRRRGGGGVVVV is a pointer to an array of strings; it  is
     used to declare the aaaarrrrggggvvvv parameter of the mmmmaaaaiiiinnnn(((()))) function of
     a C program.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____SSSSIIIIZZZZEEEE____PPPPOOOOIIIINNNNTTTTEEEERRRR

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL CCCCAAAAEEEESSSSAAAARRRR____SSSSIIIIZZZZEEEE____PPPPOOOOIIIINNNNTTTTEEEERRRR (((())))
        {{{{ ............ }}}}



(C) INRIA     Last change: 2020/02/11 (version 1.3)             3






OPEN/CAESAR MANUAL                         caesar_standard(LOCAL)



     This function returns the size (in bytes) of a value of type
     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____PPPPOOOOIIIINNNNTTTTEEEERRRR.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____AAAALLLLIIIIGGGGNNNNMMMMEEEENNNNTTTT____PPPPOOOOIIIINNNNTTTTEEEERRRR

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL CCCCAAAAEEEESSSSAAAARRRR____AAAALLLLIIIIGGGGNNNNMMMMEEEENNNNTTTT____PPPPOOOOIIIINNNNTTTTEEEERRRR (((())))
        {{{{ ............ }}}}

     This function returns the alignment factor (in bytes) for  a
     value of type CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____PPPPOOOOIIIINNNNTTTTEEEERRRR.

     Note: The alignment  factor  is  often  dependent  from  the
     machine  architecture.  For  any  memory  area (and not only
     those of type CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____PPPPOOOOIIIINNNNTTTTEEEERRRR), the alignment factor  is
     always a power of two (1, 2, 4, ...) and is an exact divider
     of the size of the area.  Whatever the machine architecture,
     any  memory  area must start at a machine address that is an
     even multiple of the alignment factor for  that  area,  this
     constraint  stating  that  areas must be properly aligned on
     machine word boundaries. In general, one has  only  to  care
     about  alignment  constraints  when creating structures con-
     taining areas with different alignment factors.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____GGGGEEEENNNNEEEERRRRIIIICCCC____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN

     ttttyyyyppppeeeeddddeeeeffff vvvvooooiiiidddd ((((****CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____GGGGEEEENNNNEEEERRRRIIIICCCC____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN)))) (((())));;;;

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____GGGGEEEENNNNEEEERRRRIIIICCCC____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN is the  ``pointer  to  a  func-
     tion''  type  used  in _O_P_E_N/_C_A_E_S_A_R. The number of parameters
     for this function, the types of these  parameters  (if  any)
     and the result type for this function are not specified.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____CCCCOOOOMMMMPPPPAAAARRRREEEE____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN

     ttttyyyyppppeeeeddddeeeeffff CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____BBBBOOOOOOOOLLLLEEEEAAAANNNN ((((****CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____CCCCOOOOMMMMPPPPAAAARRRREEEE____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN))))
        ((((CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____PPPPOOOOIIIINNNNTTTTEEEERRRR,,,, CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____PPPPOOOOIIIINNNNTTTTEEEERRRR))));;;;

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____CCCCOOOOMMMMPPPPAAAARRRREEEE____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN is  the  ``pointer  to  a  com-
     parison  function''  type  used in _O_P_E_N/_C_A_E_S_A_R. A comparison
     function takes two parameters (two pointers to data  of  the
     same  type)  and  returns a boolean value, depending whether
     both pointers refer to identical data or not.




(C) INRIA     Last change: 2020/02/11 (version 1.3)             4






OPEN/CAESAR MANUAL                         caesar_standard(LOCAL)



      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____HHHHAAAASSSSHHHH____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN

     ttttyyyyppppeeeeddddeeeeffff CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL ((((****CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____HHHHAAAASSSSHHHH____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN))))
        ((((CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____PPPPOOOOIIIINNNNTTTTEEEERRRR,,,, CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____NNNNAAAATTTTUUUURRRRAAAALLLL))));;;;

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____HHHHAAAASSSSHHHH____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN is the ``pointer to a  hash  func-
     tion''  type  used in _O_P_E_N/_C_A_E_S_A_R. A hash function takes two
     parameters (a pointer to data and a natural  number  N)  and
     returns a natural number in the range 0..N-1.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____CCCCOOOONNNNVVVVEEEERRRRTTTT____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN

     ttttyyyyppppeeeeddddeeeeffff CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSTTTTRRRRIIIINNNNGGGG ((((****CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____CCCCOOOONNNNVVVVEEEERRRRTTTT____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN))))
        ((((CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____PPPPOOOOIIIINNNNTTTTEEEERRRR))));;;;

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____HHHHAAAASSSSHHHH____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN is the ``pointer to  a  conversion
     function''  type  used in _O_P_E_N/_C_A_E_S_A_R. A conversion function
     takes one parameter (a pointer to data) and returns a  char-
     acter string containing the data under some printable form.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____PPPPRRRRIIIINNNNTTTT____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN

     ttttyyyyppppeeeeddddeeeeffff vvvvooooiiiidddd ((((****CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____PPPPRRRRIIIINNNNTTTT____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN))))
        ((((CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____FFFFIIIILLLLEEEE,,,, CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____PPPPOOOOIIIINNNNTTTTEEEERRRR))));;;;

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____PPPPRRRRIIIINNNNTTTT____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN is the ``pointer  to  a  printing
     procedure''  type  used in _O_P_E_N/_C_A_E_S_A_R. A printing procedure
     takes two parameters (a pointer to a file and a  pointer  to
     data) and prints the latter to the former.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____FFFFOOOORRRRMMMMAAAATTTT

     ttttyyyyppppeeeeddddeeeeffff uuuunnnnssssiiiiggggnnnneeeedddd cccchhhhaaaarrrr CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____FFFFOOOORRRRMMMMAAAATTTT;;;;

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____FFFFOOOORRRRMMMMAAAATTTT is the type used to control the output of
     the  various  printing functions (i.e., functions whose name
     starts with  CCCCAAAAEEEESSSSAAAARRRR____PPPPRRRRIIIINNNNTTTT____)  specified  in  the  _O_P_E_N/_C_A_E_S_A_R
     ``graph  module''  interface  or provided by the _O_P_E_N/_C_A_E_S_A_R
     library.

     Many of these functions can display  a  given  object  under



(C) INRIA     Last change: 2020/02/11 (version 1.3)             5






OPEN/CAESAR MANUAL                         caesar_standard(LOCAL)



     various  formats with different degree of information (e.g.,
     a concise format vs a verbose format).

     Each  format  is  represented  by  a  small  value  of  type
     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____FFFFOOOORRRRMMMMAAAATTTT, e.g., 0, 1, 2, etc.

     The format to be used by a printing function is  not  passed
     to  this  function as an argument (this would be too heavy);
     instead, the format is stored either in a global variable or
     in a field contained in the object to be printed.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____IIIINNNNVVVVAAAALLLLIIIIDDDD____FFFFOOOORRRRMMMMAAAATTTT

     ####ddddeeeeffffiiiinnnneeee CCCCAAAAEEEESSSSAAAARRRR____IIIINNNNVVVVAAAALLLLIIIIDDDD____FFFFOOOORRRRMMMMAAAATTTT ((((((((CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____FFFFOOOORRRRMMMMAAAATTTT)))) 222255555555))))

     CCCCAAAAEEEESSSSAAAARRRR____IIIINNNNVVVVAAAALLLLIIIIDDDD____FFFFOOOORRRRMMMMAAAATTTT  is  a  special  value  of  the   type
     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____FFFFOOOORRRRMMMMAAAATTTT.  It can be returned as a result by func-
     tion CCCCAAAAEEEESSSSAAAARRRR____HHHHAAAANNNNDDDDLLLLEEEE____FFFFOOOORRRRMMMMAAAATTTT(((()))) when this  function  is  invoked
     with an incorrect argument.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____CCCCUUUURRRRRRRREEEENNNNTTTT____FFFFOOOORRRRMMMMAAAATTTT

     ####ddddeeeeffffiiiinnnneeee CCCCAAAAEEEESSSSAAAARRRR____CCCCUUUURRRRRRRREEEENNNNTTTT____FFFFOOOORRRRMMMMAAAATTTT ((((((((CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____FFFFOOOORRRRMMMMAAAATTTT)))) 222255554444))))

     CCCCAAAAEEEESSSSAAAARRRR____CCCCUUUURRRRRRRREEEENNNNTTTT____FFFFOOOORRRRMMMMAAAATTTT  is  a  special  value  of  the   type
     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____FFFFOOOORRRRMMMMAAAATTTT. It can be passed as an argument to func-
     tion CCCCAAAAEEEESSSSAAAARRRR____HHHHAAAANNNNDDDDLLLLEEEE____FFFFOOOORRRRMMMMAAAATTTT(((()))) and  to  the  various  functions
     whose  name  starts  with  CCCCAAAAEEEESSSSAAAARRRR____FFFFOOOORRRRMMMMAAAATTTT____ so as to query the
     current value of the global variable or  object  field  that
     stores  the  format used by the corresponding printing func-
     tion.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____MMMMAAAAXXXXIIIIMMMMAAAALLLL____FFFFOOOORRRRMMMMAAAATTTT

     ####ddddeeeeffffiiiinnnneeee CCCCAAAAEEEESSSSAAAARRRR____MMMMAAAAXXXXIIIIMMMMAAAALLLL____FFFFOOOORRRRMMMMAAAATTTT ((((((((CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____FFFFOOOORRRRMMMMAAAATTTT)))) 222255553333))))

     CCCCAAAAEEEESSSSAAAARRRR____MMMMAAAAXXXXIIIIMMMMAAAALLLL____FFFFOOOORRRRMMMMAAAATTTT  is  a  special  value  of  the   type
     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____FFFFOOOORRRRMMMMAAAATTTT. It can be passed as an argument to func-
     tion CCCCAAAAEEEESSSSAAAARRRR____HHHHAAAANNNNDDDDLLLLEEEE____FFFFOOOORRRRMMMMAAAATTTT(((()))) and  to  the  various  functions
     whose  name  starts  with  CCCCAAAAEEEESSSSAAAARRRR____FFFFOOOORRRRMMMMAAAATTTT____ so as to query the
     largest format value supported by the corresponding printing
     function.




(C) INRIA     Last change: 2020/02/11 (version 1.3)             6






OPEN/CAESAR MANUAL                         caesar_standard(LOCAL)



      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____PPPPRRRRIIIINNNNTTTT____FFFFOOOORRRRMMMMAAAATTTT

     vvvvooooiiiidddd CCCCAAAAEEEESSSSAAAARRRR____PPPPRRRRIIIINNNNTTTT____FFFFOOOORRRRMMMMAAAATTTT ((((CCCCAAAAEEEESSSSAAAARRRR____FFFFIIIILLLLEEEE,,,, CCCCAAAAEEEESSSSAAAARRRR____FFFFOOOORRRRMMMMAAAATTTT))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____FFFFIIIILLLLEEEE CCCCAAAAEEEESSSSAAAARRRR____FFFFIIIILLLLEEEE;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____FFFFOOOORRRRMMMMAAAATTTT CCCCAAAAEEEESSSSAAAARRRR____FFFFOOOORRRRMMMMAAAATTTT;;;;
        {{{{ ............ }}}}

     This procedure prints  to  file  CCCCAAAAEEEESSSSAAAARRRR____FFFFIIIILLLLEEEE  the  value  of
     CCCCAAAAEEEESSSSAAAARRRR____FFFFOOOORRRRMMMMAAAATTTT. If CCCCAAAAEEEESSSSAAAARRRR____FFFFOOOORRRRMMMMAAAATTTT is equal to one of the three
     special values CCCCAAAAEEEESSSSAAAARRRR____IIIINNNNVVVVAAAALLLLIIIIDDDD____FFFFOOOORRRRMMMMAAAATTTT, CCCCAAAAEEEESSSSAAAARRRR____CCCCUUUURRRRRRRREEEENNNNTTTT____FFFFOOOORRRRMMMMAAAATTTT,
     or  CCCCAAAAEEEESSSSAAAARRRR____MMMMAAAAXXXXIIIIMMMMAAAALLLL____FFFFOOOORRRRMMMMAAAATTTT, its value is printed symbolically
     rather than numerically.

     Before this procedure is called, CCCCAAAAEEEESSSSAAAARRRR____FFFFIIIILLLLEEEE must have  been
     properly opened, for instance using ffffooooppppeeeennnn((((3333)))).


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____HHHHAAAANNNNDDDDLLLLEEEE____FFFFOOOORRRRMMMMAAAATTTT

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____FFFFOOOORRRRMMMMAAAATTTT CCCCAAAAEEEESSSSAAAARRRR____HHHHAAAANNNNDDDDLLLLEEEE____FFFFOOOORRRRMMMMAAAATTTT ((((CCCCAAAAEEEESSSSAAAARRRR____VVVVAAAARRRRIIIIAAAABBBBLLLLEEEE,,,, CCCCAAAAEEEESSSSAAAARRRR____VVVVAAAALLLLUUUUEEEE,,,,
                                              CCCCAAAAEEEESSSSAAAARRRR____MMMMAAAAXXXXIIIIMMMMAAAALLLL____VVVVAAAALLLLUUUUEEEE))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____FFFFOOOORRRRMMMMAAAATTTT ****CCCCAAAAEEEESSSSAAAARRRR____VVVVAAAARRRRIIIIAAAABBBBLLLLEEEE;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____FFFFOOOORRRRMMMMAAAATTTT CCCCAAAAEEEESSSSAAAARRRR____VVVVAAAALLLLUUUUEEEE;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____FFFFOOOORRRRMMMMAAAATTTT CCCCAAAAEEEESSSSAAAARRRR____MMMMAAAAXXXXIIIIMMMMAAAALLLL____VVVVAAAALLLLUUUUEEEE;;;;
        {{{{ ............ }}}}

     This function is an auxiliary function that should  be  used
     to  define  all the various functions whose name starts with
     CCCCAAAAEEEESSSSAAAARRRR____FFFFOOOORRRRMMMMAAAATTTT____. Examples of the proper use of this  function
     can be found by inspecting the C~code generated by _C_A_E_S_A_R or
     _E_X_P._O_P_E_N.

     This function consults or modifies the format value  pointed
     to  by  CCCCAAAAEEEESSSSAAAARRRR____VVVVAAAARRRRIIIIAAAABBBBLLLLEEEE, which is expected to be the address
     of the global variable or object field that stores the  for-
     mat used by the corresponding printing function.

     If CCCCAAAAEEEESSSSAAAARRRR____VVVVAAAALLLLUUUUEEEE  is  equal  to  CCCCAAAAEEEESSSSAAAARRRR____CCCCUUUURRRRRRRREEEENNNNTTTT____FFFFOOOORRRRMMMMAAAATTTT,  this
     function  returns the current value of the format pointed to
     by CCCCAAAAEEEESSSSAAAARRRR____VVVVAAAARRRRIIIIAAAABBBBLLLLEEEE.

     If CCCCAAAAEEEESSSSAAAARRRR____VVVVAAAALLLLUUUUEEEE  is  equal  to  CCCCAAAAEEEESSSSAAAARRRR____MMMMAAAAXXXXIIIIMMMMAAAALLLL____FFFFOOOORRRRMMMMAAAATTTT,  this
     function  returns CCCCAAAAEEEESSSSAAAARRRR____MMMMAAAAXXXXIIIIMMMMAAAALLLL____VVVVAAAALLLLUUUUEEEE, which is expected to
     be the largest format value supported by  the  corresponding
     printing function.

     If CCCCAAAAEEEESSSSAAAARRRR____VVVVAAAALLLLUUUUEEEE is less or  equal  to  CCCCAAAAEEEESSSSAAAARRRR____MMMMAAAAXXXXIIIIMMMMAAAALLLL____VVVVAAAALLLLUUUUEEEE,
     then  the  value of the format pointed to by CCCCAAAAEEEESSSSAAAARRRR____VVVVAAAARRRRIIIIAAAABBBBLLLLEEEE



(C) INRIA     Last change: 2020/02/11 (version 1.3)             7






OPEN/CAESAR MANUAL                         caesar_standard(LOCAL)



     is modified and set to  CCCCAAAAEEEESSSSAAAARRRR____VVVVAAAALLLLUUUUEEEE.  In  such  case,  this
     function returns an undefined value.

     In    all    other    cases,    this    function     returns
     CCCCAAAAEEEESSSSAAAARRRR____IIIINNNNVVVVAAAALLLLIIIIDDDD____FFFFOOOORRRRMMMMAAAATTTT.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____AAAABBBBSSSSTTTTRRRRAAAACCCCTTTT

     ####ddddeeeeffffiiiinnnneeee CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____AAAABBBBSSSSTTTTRRRRAAAACCCCTTTT((((CCCCAAAAEEEESSSSAAAARRRR____NNNNAAAAMMMMEEEE)))) ssssttttrrrruuuucccctttt CCCCAAAAEEEESSSSAAAARRRR____NNNNAAAAMMMMEEEE ****

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____AAAABBBBSSSSTTTTRRRRAAAACCCCTTTT ((((CCCCAAAAEEEESSSSAAAARRRR____NNNNAAAAMMMMEEEE)))) is a pointer to a  struc-
     ture of name CCCCAAAAEEEESSSSAAAARRRR____NNNNAAAAMMMMEEEE.

     Usually, the definition of CCCCAAAAEEEESSSSAAAARRRR____NNNNAAAAMMMMEEEE is not available,  so
     that  CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____AAAABBBBSSSSTTTTRRRRAAAACCCCTTTT ((((............)))) is a ``generic'' pointer to
     some data structure, the internal representation of which is
     not   pertinent   to   the  user.  This  data  structure  is
     ``abstract'', in the sense that one should  not  rely  on  a
     particular implementation.

     If CCCCAAAAEEEESSSSAAAARRRR____XXXX is an expression  of  type  CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____AAAABBBBSSSSTTTTRRRRAAAACCCCTTTT
     ((((............)))),  dereferencing CCCCAAAAEEEESSSSAAAARRRR____XXXX (e.g., ****CCCCAAAAEEEESSSSAAAARRRR____XXXX or CCCCAAAAEEEESSSSAAAARRRR____XXXX----
     >>>>............) is not allowed.  Note: if CCCCAAAAEEEESSSSAAAARRRR____XXXX is an expression of
     type  CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____AAAABBBBSSSSTTTTRRRRAAAACCCCTTTT  ((((............)))),  its  value usually obeys
     alignment constraints (for instance, it can  be  an  address
     multiple of 4).


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTEEEE

     ####ddddeeeeffffiiiinnnneeee CCCCAAAAEEEESSSSAAAARRRR____CCCCRRRREEEEAAAATTTTEEEE((((CCCCAAAAEEEESSSSAAAARRRR____AAAADDDDDDDDRRRREEEESSSSSSSS,,,,CCCCAAAAEEEESSSSAAAARRRR____SSSSIIIIZZZZEEEE,,,,CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE)))) \\\\
             ((((CCCCAAAAEEEESSSSAAAARRRR____AAAADDDDDDDDRRRREEEESSSSSSSS)))) ==== ((((CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE)))) mmmmaaaalllllllloooocccc ((((CCCCAAAAEEEESSSSAAAARRRR____SSSSIIIIZZZZEEEE))))

     This macro-definition encapsulates the C function mmmmaaaalllllllloooocccc((((3333)))).
     It  allocates a memory area of CCCCAAAAEEEESSSSAAAARRRR____SSSSIIIIZZZZEEEE bytes and assigns
     its address to variable CCCCAAAAEEEESSSSAAAARRRR____AAAADDDDDDDDRRRREEEESSSSSSSS, which should  be  of
     type  CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE.  If  allocation  fails, a NNNNUUUULLLLLLLL pointer is
     assigned to CCCCAAAAEEEESSSSAAAARRRR____AAAADDDDDDDDRRRREEEESSSSSSSS.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____DDDDEEEELLLLEEEETTTTEEEE

     ####ddddeeeeffffiiiinnnneeee CCCCAAAAEEEESSSSAAAARRRR____DDDDEEEELLLLEEEETTTTEEEE((((CCCCAAAAEEEESSSSAAAARRRR____AAAADDDDDDDDRRRREEEESSSSSSSS)))) \\\\
             ffffrrrreeeeeeee ((((((((cccchhhhaaaarrrr ****)))) ((((CCCCAAAAEEEESSSSAAAARRRR____AAAADDDDDDDDRRRREEEESSSSSSSS))))))))




(C) INRIA     Last change: 2020/02/11 (version 1.3)             8






OPEN/CAESAR MANUAL                         caesar_standard(LOCAL)



     This macro-definition encapsulates the C  function  ffffrrrreeeeeeee((((3333)))).
     It frees the memory area pointed to by CCCCAAAAEEEESSSSAAAARRRR____AAAADDDDDDDDRRRREEEESSSSSSSS.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____TTTTOOOOOOOOLLLL

     eeeexxxxtttteeeerrrrnnnn CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSTTTTRRRRIIIINNNNGGGG CCCCAAAAEEEESSSSAAAARRRR____TTTTOOOOOOOOLLLL;;;;

     The global variable CCCCAAAAEEEESSSSAAAARRRR____TTTTOOOOOOOOLLLL is a pointer to a  character
     string  which  should  contain  the  name of the _O_P_E_N/_C_A_E_S_A_R
     application program. By default, CCCCAAAAEEEESSSSAAAARRRR____TTTTOOOOOOOOLLLL is always  ini-
     tialized to the empty string """""""". Although this default value
     can be left unchanged, it is advisable for each  application
     program  to  give a meaningful value to CCCCAAAAEEEESSSSAAAARRRR____TTTTOOOOOOOOLLLL. This is
     generally done by the first instruction of the  mmmmaaaaiiiinnnn(((())))  rou-
     tine:


             iiiinnnntttt mmmmaaaaiiiinnnn ((((aaaarrrrggggcccc,,,, aaaarrrrggggvvvv))))
             iiiinnnntttt  aaaarrrrggggcccc;;;;
             cccchhhhaaaarrrr ****aaaarrrrggggvvvv[[[[]]]];;;;
             {{{{
             ////**** aaaaddddddddiiiittttiiiioooonnnnaaaallll ddddeeeeccccllllaaaarrrraaaattttiiiioooonnnnssss ****////
             CCCCAAAAEEEESSSSAAAARRRR____TTTTOOOOOOOOLLLL ==== aaaarrrrggggvvvv[[[[0000]]]];;;;
             ////**** ooootttthhhheeeerrrr iiiinnnnssssttttrrrruuuuccccttttiiiioooonnnnssss ****////
             }}}}



      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____WWWWAAAARRRRNNNNIIIINNNNGGGG

     vvvvooooiiiidddd CCCCAAAAEEEESSSSAAAARRRR____WWWWAAAARRRRNNNNIIIINNNNGGGG ((((CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSTTTTRRRRIIIINNNNGGGG CCCCAAAAEEEESSSSAAAARRRR____FFFFOOOORRRRMMMMAAAATTTT,,,, ............))))
        {{{{ ............ }}}}

     This function displays a (non-fatal) warning message to  the
     standard  output.  The  warning  message is specified by the
     actual parameters passed to the function.  These  parameters
     follow  the  same  conventions  as  for  pppprrrriiiinnnnttttffff((((3333)))) and their
     number can be variable. The warning message will be prefixed
     by the value of the global variable CCCCAAAAEEEESSSSAAAARRRR____TTTTOOOOOOOOLLLL, unless this
     value is the  empty  string.  The  format  string  given  by
     CCCCAAAAEEEESSSSAAAARRRR____FFFFOOOORRRRMMMMAAAATTTT  should  not  be  suffixed with an end-of-line
     character, as CCCCAAAAEEEESSSSAAAARRRR____WWWWAAAARRRRNNNNIIIINNNNGGGG(((()))) will add one automatically.


      ............................................................





(C) INRIA     Last change: 2020/02/11 (version 1.3)             9






OPEN/CAESAR MANUAL                         caesar_standard(LOCAL)



  CCCCAAAAEEEESSSSAAAARRRR____EEEERRRRRRRROOOORRRR

     vvvvooooiiiidddd CCCCAAAAEEEESSSSAAAARRRR____EEEERRRRRRRROOOORRRR ((((CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSTTTTRRRRIIIINNNNGGGG CCCCAAAAEEEESSSSAAAARRRR____FFFFOOOORRRRMMMMAAAATTTT,,,, ............))))
        {{{{ ............ }}}}

     This function displays a (fatal) error message to the  stan-
     dard  output  and stops using eeeexxxxiiiitttt ((((1111)))). The error message is
     specified by the actual parameters passed to  the  function.
     These   parameters   follow  the  same  conventions  as  for
     pppprrrriiiinnnnttttffff((((3333)))) and their number can be variable. The  error  mes-
     sage  will  be  prefixed by the value of the global variable
     CCCCAAAAEEEESSSSAAAARRRR____TTTTOOOOOOOOLLLL, unless this value is the empty string. The for-
     mat  string  given  by  CCCCAAAAEEEESSSSAAAARRRR____FFFFOOOORRRRMMMMAAAATTTT should not be suffixed
     with an end-of-line character, as  CCCCAAAAEEEESSSSAAAARRRR____EEEERRRRRRRROOOORRRR(((())))  will  add
     one automatically.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____PPPPRRRROOOOTTTTEEEESSSSTTTT

     ####ddddeeeeffffiiiinnnneeee CCCCAAAAEEEESSSSAAAARRRR____PPPPRRRROOOOTTTTEEEESSSSTTTT(((()))) ............

     This macro-definition displays an error message  (containing
     the  current  file  name and current line number) and stops.
     This macro-definition should be used only  to  report  about
     unexpected,  internal  errors. If a more detailed error mes-
     sage  should  be  displayed,  then  function  CCCCAAAAEEEESSSSAAAARRRR____EEEERRRRRRRROOOORRRR(((())))
     should be used instead.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____AAAASSSSSSSSEEEERRRRTTTT

     ####ddddeeeeffffiiiinnnneeee CCCCAAAAEEEESSSSAAAARRRR____AAAASSSSSSSSEEEERRRRTTTT((((CCCCAAAAEEEESSSSAAAARRRR____AAAASSSSSSSSEEEERRRRTTTTIIIIOOOONNNN)))) \\\\
             {{{{ iiiiffff ((((!!!!((((CCCCAAAAEEEESSSSAAAARRRR____AAAASSSSSSSSEEEERRRRTTTTIIIIOOOONNNN)))))))) CCCCAAAAEEEESSSSAAAARRRR____PPPPRRRROOOOTTTTEEEESSSSTTTT(((())));;;; }}}}

     This  macro-definition  evaluates  the  boolean   expression
     CCCCAAAAEEEESSSSAAAARRRR____AAAASSSSSSSSEEEERRRRTTTTIIIIOOOONNNN  and,  if  the result is false, displays an
     error message (containing the current file name and  current
     line number) and stops. This macro-definition should be used
     only to check assertions and report about unexpected, inter-
     nal  errors.  If  a  more  detailed  error message should be
     displayed,  then  function  CCCCAAAAEEEESSSSAAAARRRR____EEEERRRRRRRROOOORRRR(((())))  should  be  used
     instead.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSIIIIGGGGNNNNAAAALLLL____HHHHAAAANNNNDDDDLLLLEEEERRRR




(C) INRIA     Last change: 2020/02/11 (version 1.3)            10






OPEN/CAESAR MANUAL                         caesar_standard(LOCAL)



     ttttyyyyppppeeeeddddeeeeffff vvvvooooiiiidddd ((((****CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSIIIIGGGGNNNNAAAALLLL____HHHHAAAANNNNDDDDLLLLEEEERRRR)))) ((((iiiinnnntttt))));;;;

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSIIIIGGGGNNNNAAAALLLL____HHHHAAAANNNNDDDDLLLLEEEERRRR is the  ``pointer  to  a  signal-
     handler  procedure''  type  used  in  _O_P_E_N/_C_A_E_S_A_R. A signal-
     handler procedure takes one parameter, which a POSIX  signal
     number.  The type CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSIIIIGGGGNNNNAAAALLLL____HHHHAAAANNNNDDDDLLLLEEEERRRR is identical to
     the type ssssiiiigggghhhhaaaannnnddddlllleeeerrrr____tttt that exists in certain Unix  distribu-
     tions. See the ssssiiiiggggnnnnaaaallll manual page for further details.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____SSSSEEEETTTT____SSSSIIIIGGGGNNNNAAAALLLLSSSS

     vvvvooooiiiidddd CCCCAAAAEEEESSSSAAAARRRR____SSSSEEEETTTT____SSSSIIIIGGGGNNNNAAAALLLLSSSS ((((CCCCAAAAEEEESSSSAAAARRRR____HHHHAAAANNNNDDDDLLLLEEEERRRR))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSIIIIGGGGNNNNAAAALLLL____HHHHAAAANNNNDDDDLLLLEEEERRRR CCCCAAAAEEEESSSSAAAARRRR____HHHHAAAANNNNDDDDLLLLEEEERRRR;;;;
        {{{{ ............ }}}}

     This  procedure   sets   the   POSIX   signal   handler   to
     CCCCAAAAEEEESSSSAAAARRRR____HHHHAAAANNNNDDDDLLLLEEEERRRR  for  the  following signals: SSSSIIIIGGGGHHHHUUUUPPPP, SSSSIIIIGGGGIIIINNNNTTTT,
     SSSSIIIIGGGGQQQQUUUUIIIITTTT, SSSSIIIIGGGGIIIILLLLLLLL, SSSSIIIIGGGGAAAABBBBRRRRTTTT, SSSSIIIIGGGGFFFFPPPPEEEE, SSSSIIIIGGGGBBBBUUUUSSSS,  SSSSIIIIGGGGSSSSEEEEGGGGVVVV,  SSSSIIIIGGGGSSSSYYYYSSSS,
     SSSSIIIIGGGGTTTTEEEERRRRMMMM,  and  SSSSIIIIGGGGPPPPIIIIPPPPEEEE (whenever these signals are supported
     by the operating system implementation). In particular,  the
     signal handler CCCCAAAAEEEESSSSAAAARRRR____HHHHAAAANNNNDDDDLLLLEEEERRRR can be equal to the predefined
     values SSSSIIIIGGGG____IIIIGGGGNNNN or SSSSIIIIGGGG____DDDDFFFFLLLL. See the ssssiiiiggggnnnnaaaallll  manual  page  for
     further details.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____RRRREEEESSSSEEEETTTT____SSSSIIIIGGGGNNNNAAAALLLLSSSS

     vvvvooooiiiidddd CCCCAAAAEEEESSSSAAAARRRR____RRRREEEESSSSEEEETTTT____SSSSIIIIGGGGNNNNAAAALLLLSSSS (((())))
        {{{{ ............ }}}}

     This procedure resets the POSIX signal handler for the  fol-
     lowing  signals:  SSSSIIIIGGGGHHHHUUUUPPPP,  SSSSIIIIGGGGIIIINNNNTTTT, SSSSIIIIGGGGQQQQUUUUIIIITTTT, SSSSIIIIGGGGIIIILLLLLLLL, SSSSIIIIGGGGAAAABBBBRRRRTTTT,
     SSSSIIIIGGGGFFFFPPPPEEEE, SSSSIIIIGGGGBBBBUUUUSSSS, SSSSIIIIGGGGSSSSEEEEGGGGVVVV, SSSSIIIIGGGGSSSSYYYYSSSS, SSSSIIIIGGGGTTTTEEEERRRRMMMM, and SSSSIIIIGGGGPPPPIIIIPPPPEEEE (when-
     ever  these  signals  are  supported by the operating system
     implementation). If  the  procedure  CCCCAAAAEEEESSSSAAAARRRR____SSSSEEEETTTT____SSSSIIIIGGGGNNNNAAAALLLLSSSS  has
     been  invoked  (at  least  once)  and  if  no  invocation of
     CCCCAAAAEEEESSSSAAAARRRR____RRRREEEESSSSEEEETTTT____SSSSIIIIGGGGNNNNAAAALLLLSSSS occurred after the most recent  invoca-
     tion  of CCCCAAAAEEEESSSSAAAARRRR____SSSSEEEETTTT____SSSSIIIIGGGGNNNNAAAALLLLSSSS, this signal handler is reset to
     the value of the CCCCAAAAEEEESSSSAAAARRRR____HHHHAAAANNNNDDDDLLLLEEEERRRR argument passed to the  most
     recent  invocation  of  CCCCAAAAEEEESSSSAAAARRRR____SSSSEEEETTTT____SSSSIIIIGGGGNNNNAAAALLLLSSSS. If the procedure
     CCCCAAAAEEEESSSSAAAARRRR____SSSSEEEETTTT____SSSSIIIIGGGGNNNNAAAALLLLSSSS  has  never  been  invoked  or  not  been
     invoked    after    the    most    recent    invocation   of
     CCCCAAAAEEEESSSSAAAARRRR____RRRREEEESSSSEEEETTTT____SSSSIIIIGGGGNNNNAAAALLLLSSSS,  this  signal  handler  is  reset   to
     SSSSIIIIGGGG____DDDDFFFFLLLL.






(C) INRIA     Last change: 2020/02/11 (version 1.3)            11






OPEN/CAESAR MANUAL                         caesar_standard(LOCAL)



      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____TTTTEEEEMMMMPPPPOOOORRRRAAAARRRRYYYY____FFFFIIIILLLLEEEE

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSTTTTRRRRIIIINNNNGGGG CCCCAAAAEEEESSSSAAAARRRR____TTTTEEEEMMMMPPPPOOOORRRRAAAARRRRYYYY____FFFFIIIILLLLEEEE ((((CCCCAAAAEEEESSSSAAAARRRR____TTTTEEEEMMMMPPPPOOOORRRRAAAARRRRYYYY____SSSSUUUUFFFFFFFFIIIIXXXX))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSTTTTRRRRIIIINNNNGGGG CCCCAAAAEEEESSSSAAAARRRR____TTTTEEEEMMMMPPPPOOOORRRRAAAARRRRYYYY____SSSSUUUUFFFFFFFFIIIIXXXX;;;;
        {{{{ ............ }}}}

     This function returns a character string that can safely  be
     used  as  a  file  name for a temporary file.  The prefix of
     this file name (i.e., the directory in which  the  temporary
     file  will  be  created)  is either given by the environment
     variable $$$$CCCCAAAADDDDPPPP____TTTTMMMMPPPP if this variable is defined, or is  equal
     to  """"////ttttmmmmpppp"""" otherwise.  The suffix of this file name is given
     by CCCCAAAAEEEESSSSAAAARRRR____TTTTEEEEMMMMPPPPOOOORRRRAAAARRRRYYYY____SSSSUUUUFFFFFFFFIIIIXXXX, which is usually a  file  exten-
     sion  starting  with  a  dot.  If the allocation of the file
     name fails (due to a lack of memory)  or  if  the  temporary
     file  cannot  not  be  created in the directory specified by
     $$$$CCCCAAAADDDDPPPP____TTTTMMMMPPPP (e.g., because this directory does not  exist,  is
     write-protected,  or  belongs to a file system with unsuffi-
     cient disk space to create new files),  the  NNNNUUUULLLLLLLL  value  is
     returned.

     The  contents  of   the   character   string   returned   by
     CCCCAAAAEEEESSSSAAAARRRR____TTTTEEEEMMMMPPPPOOOORRRRAAAARRRRYYYY____FFFFIIIILLLLEEEE(((())))  differs at every call to this func-
     tion.

     Note: It is not  allowed  to  modify  the  character  string
     returned  by  CCCCAAAAEEEESSSSAAAARRRR____TTTTEEEEMMMMPPPPOOOORRRRAAAARRRRYYYY____FFFFIIIILLLLEEEE(((())))  nor  to  free it, for
     instance using ffffrrrreeeeeeee((((3333)))).

     Note: The contents  of  the  character  string  returned  by
     CCCCAAAAEEEESSSSAAAARRRR____TTTTEEEEMMMMPPPPOOOORRRRAAAARRRRYYYY____FFFFIIIILLLLEEEE(((())))  may  be  destroyed  by a subsequent
     call to this function.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____OOOOPPPPEEEENNNN____CCCCOOOOMMMMPPPPRRRREEEESSSSSSSSEEEEDDDD____FFFFIIIILLLLEEEE

     vvvvooooiiiidddd CCCCAAAAEEEESSSSAAAARRRR____OOOOPPPPEEEENNNN____CCCCOOOOMMMMPPPPRRRREEEESSSSSSSSEEEEDDDD____FFFFIIIILLLLEEEE ((((CCCCAAAAEEEESSSSAAAARRRR____FFFFIIIILLLLEEEE,,,, CCCCAAAAEEEESSSSAAAARRRR____FFFFIIIILLLLEEEENNNNAAAAMMMMEEEE,,,, CCCCAAAAEEEESSSSAAAARRRR____MMMMOOOODDDDEEEE))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____FFFFIIIILLLLEEEE ****CCCCAAAAEEEESSSSAAAARRRR____FFFFIIIILLLLEEEE;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSTTTTRRRRIIIINNNNGGGG CCCCAAAAEEEESSSSAAAARRRR____FFFFIIIILLLLEEEENNNNAAAAMMMMEEEE;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSTTTTRRRRIIIINNNNGGGG CCCCAAAAEEEESSSSAAAARRRR____MMMMOOOODDDDEEEE;;;;
        {{{{ ............ }}}}

     This function opens (for reading or  writing)  a  file,  the
     pathname   of   which   is  CCCCAAAAEEEESSSSAAAARRRR____FFFFIIIILLLLEEEENNNNAAAAMMMMEEEE.  The  value  of
     CCCCAAAAEEEESSSSAAAARRRR____MMMMOOOODDDDEEEE, which must be equal to """"rrrr"""" or  """"wwww"""",  determines
     whether  this  file  is  opened for reading (""""rrrr"""") or writing
     (""""wwww"""").




(C) INRIA     Last change: 2020/02/11 (version 1.3)            12






OPEN/CAESAR MANUAL                         caesar_standard(LOCAL)



     If the suffix of  CCCCAAAAEEEESSSSAAAARRRR____FFFFIIIILLLLEEEENNNNAAAAMMMMEEEE  corresponds  to  a  known
     compression  format  (""""....ZZZZ"""",  """"....ggggzzzz"""",  """"....bbbbzzzz2222"""", etc.), the file
     will be treated as a compressed file.  Otherwise,  the  file
     will  not be compressed and treated as an ordinary file. The
     list of supported suffixes and compression formats is  given
     by  the  ccccaaaaddddpppp____zzzziiiipppp shell-script provided within the CADP dis-
     tribution.

     If the file can be opened, the value of ****CCCCAAAAEEEESSSSAAAARRRR____FFFFIIIILLLLEEEE is  set
     to  a  POSIX stream descriptor from (respectively, to) which
     data can be read (respectively, written) using the  standard
     input  (respectively,  output)  routines available in POSIX,
     e.g., ffffggggeeeettttssss((((3333)))), ffffpppprrrriiiinnnnttttffff((((3333)))), ffffppppuuuuttttssss((((3333)))), ffffssssccccaaaannnnffff((((3333)))),  etc.  Data
     compression,  if  any,  is  performed transparently, meaning
     that the data sent or read to a compressed file are  exactly
     the same as if the file was not compressed.

     If the file cannot be opened, the value of  ****CCCCAAAAEEEESSSSAAAARRRR____FFFFIIIILLLLEEEE  is
     set to NNNNUUUULLLLLLLL.

     Note: Since type CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____FFFFIIIILLLLEEEE  is  defined  as  FFFFIIIILLLLEEEE  ****,
     variable CCCCAAAAEEEESSSSAAAARRRR____FFFFIIIILLLLEEEE is actually of type FFFFIIIILLLLEEEE ********, where FFFFIIIILLLLEEEE
     is the type of a POSIX file descriptor.

     Note:   Function    CCCCAAAAEEEESSSSAAAARRRR____OOOOPPPPEEEENNNN____CCCCOOOOMMMMPPPPRRRREEEESSSSSSSSEEEEDDDD____FFFFIIIILLLLEEEE(((())))    invokes
     ffffooooppppeeeennnn((((3333)))) to open an uncompressed file and ppppooooppppeeeennnn((((3333)))) to open a
     compressed file.


      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____CCCCLLLLOOOOSSSSEEEE____CCCCOOOOMMMMPPPPRRRREEEESSSSSSSSEEEEDDDD____FFFFIIIILLLLEEEE

     vvvvooooiiiidddd CCCCAAAAEEEESSSSAAAARRRR____CCCCLLLLOOOOSSSSEEEE____CCCCOOOOMMMMPPPPRRRREEEESSSSSSSSEEEEDDDD____FFFFIIIILLLLEEEE ((((CCCCAAAAEEEESSSSAAAARRRR____FFFFIIIILLLLEEEE))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____FFFFIIIILLLLEEEE ****CCCCAAAAEEEESSSSAAAARRRR____FFFFIIIILLLLEEEE;;;;
        {{{{ ............ }}}}

     This function closes the file pointed  to  by  ****CCCCAAAAEEEESSSSAAAARRRR____FFFFIIIILLLLEEEE,
     which  must  have  been  opened  previously by a call to the
     CCCCAAAAEEEESSSSAAAARRRR____OOOOPPPPEEEENNNN____CCCCOOOOMMMMPPPPRRRREEEESSSSSSSSEEEEDDDD____FFFFIIIILLLLEEEE(((()))) function. After  the  file  is
     closed, the value of ****CCCCAAAAEEEESSSSAAAARRRR____FFFFIIIILLLLEEEE is set to NNNNUUUULLLLLLLL.

     Note: Since type CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____FFFFIIIILLLLEEEE  is  defined  as  FFFFIIIILLLLEEEE  ****,
     variable CCCCAAAAEEEESSSSAAAARRRR____FFFFIIIILLLLEEEE is actually of type FFFFIIIILLLLEEEE ********, where FFFFIIIILLLLEEEE
     is the type of a POSIX file descriptor.

     Note: Function CCCCAAAAEEEESSSSAAAARRRR____CCCCLLLLOOOOSSSSEEEE____CCCCOOOOMMMMPPPPRRRREEEESSSSSSSSEEEEDDDD____FFFFIIIILLLLEEEE(((()))) invokes either
     ffffcccclllloooosssseeee((((3333)))) or ppppcccclllloooosssseeee((((3333)))) to close the file.


      ............................................................




(C) INRIA     Last change: 2020/02/11 (version 1.3)            13






OPEN/CAESAR MANUAL                         caesar_standard(LOCAL)



  CCCCAAAAEEEESSSSAAAARRRR____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN____NNNNAAAAMMMMEEEE

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____SSSSTTTTRRRRIIIINNNNGGGG CCCCAAAAEEEESSSSAAAARRRR____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN____NNNNAAAAMMMMEEEE ((((CCCCAAAAEEEESSSSAAAARRRR____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN))))
        vvvvooooiiiidddd ((((****CCCCAAAAEEEESSSSAAAARRRR____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN)))) (((())));;;;
        {{{{ ............ }}}}

     This function returns a printable character string identify-
     ing the function CCCCAAAAEEEESSSSAAAARRRR____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN. If CCCCAAAAEEEESSSSAAAARRRR____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN belongs
     to a predefined set of functions of the _O_P_E_N/_C_A_E_S_A_R library,
     the  character  string  contains  the  name of this function
     (e.g.,          CCCCAAAAEEEESSSSAAAARRRR____0000____HHHHAAAASSSSHHHH,           CCCCAAAAEEEESSSSAAAARRRR____PPPPRRRRIIIINNNNTTTT____SSSSTTTTAAAATTTTEEEE,
     CCCCAAAAEEEESSSSAAAARRRR____CCCCOOOOMMMMPPPPAAAARRRREEEE____LLLLAAAABBBBEEEELLLL, etc.); otherwise, the character string
     contains the  hexadecimal  value  of  the  function  pointer
     CCCCAAAAEEEESSSSAAAARRRR____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN.

     Note: It is not  allowed  to  modify  the  character  string
     returned  by  CCCCAAAAEEEESSSSAAAARRRR____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN____NNNNAAAAMMMMEEEE(((())))  nor  to  free  it, for
     instance using ffffrrrreeeeeeee((((3333)))).

     Note: In fact, CCCCAAAAEEEESSSSAAAARRRR____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN____NNNNAAAAMMMMEEEE(((()))) is  implemented  as  a
     macro-definition  that  invokes  an auxiliary function. This
     avoids the need for inserting a type cast before any parame-
     ter given to CCCCAAAAEEEESSSSAAAARRRR____FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN____NNNNAAAAMMMMEEEE(((()))).


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





(C) INRIA     Last change: 2020/02/11 (version 1.3)            14






OPEN/CAESAR MANUAL                         caesar_standard(LOCAL)



     Recent  changes  and  improvements  to  this  software   are
     reported and commented in file $$$$CCCCAAAADDDDPPPP////HHHHIIIISSSSTTTTOOOORRRRYYYY....

BBBBUUUUGGGGSSSS
     Known  bugs  are  described  in  the  Reference  Manual   of
     OPEN/CAESAR.  Please report new bugs to cadp@inria.fr

















































(C) INRIA     Last change: 2020/02/11 (version 1.3)            15



