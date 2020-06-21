


OPEN/CAESAR MANUAL                          caesar_version(LOCAL)



NNNNAAAAMMMMEEEE
     caesar_version - the ``version'' library of OPEN/CAESAR

PPPPUUUURRRRPPPPOOOOSSSSEEEE
     The ``version'' library allows to  access  and  control  the
     version  numbers  (also  called  release  numbers,  revision
     numbers)  of  the  tools  and  libraries   making   up   the
     _O_P_E_N/_C_A_E_S_A_R environment.

     It is be used to check whether a ssssppppeeeecccc....cccc file (generated from
     a  source  program)  is  up  to  date  with  respect  to the
     ccccaaaaeeeessssaaaarrrr____ggggrrrraaaapppphhhh,,,,hhhh file and other files  and  libraries  of  the
     _O_P_E_N/_C_A_E_S_A_R  environment. Version clashes between ssssppppeeeecccc....cccc and
     ccccaaaaeeeessssaaaarrrr____ggggrrrraaaapppphhhh,,,,hhhh can cause subtle  errors  very  difficult  to
     detect;  the  ``version''  library  aims  at preventing such
     clashes.


UUUUSSSSAAAAGGGGEEEE
     The ``version'' library consists of:

     -    a predefined header file ccccaaaaeeeessssaaaarrrr____vvvveeeerrrrssssiiiioooonnnn....hhhh;

     -    the precompiled library file lllliiiibbbbccccaaaaeeeessssaaaarrrr....aaaa, which  imple-
          ments the features described in ccccaaaaeeeessssaaaarrrr____vvvveeeerrrrssssiiiioooonnnn....hhhh.

     Note: The ``version'' library  is  a  software  layer  built
     above the primitives offered by the ``standard'' library.


FFFFEEEEAAAATTTTUUUURRRREEEESSSS
      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____VVVVEEEERRRRSSSSIIIIOOOONNNN

     ttttyyyyppppeeeeddddeeeeffff ddddoooouuuubbbblllleeee CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____VVVVEEEERRRRSSSSIIIIOOOONNNN;;;;

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____VVVVEEEERRRRSSSSIIIIOOOONNNN represents a version number, which is  a
     positive floating-point number with a single digit after the
     decimal point.

      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____LLLLIIIIBBBBRRRRAAAARRRRYYYY____VVVVEEEERRRRSSSSIIIIOOOONNNN

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____VVVVEEEERRRRSSSSIIIIOOOONNNN CCCCAAAAEEEESSSSAAAARRRR____LLLLIIIIBBBBRRRRAAAARRRRYYYY____VVVVEEEERRRRSSSSIIIIOOOONNNN (((())))
        {{{{ ............ }}}}

     This function returns the version number of the  _O_P_E_N/_C_A_E_S_A_R
     environment.  This  version number covers the ccccaaaaeeeessssaaaarrrr____ggggrrrraaaapppphhhh....hhhh
     file, as well as other ....hhhh, ....cccc and ....aaaa files contained in  the
     _O_P_E_N/_C_A_E_S_A_R distribution. All these files are supposed to be



(C) INRIA     Last change: 2020/02/11 (version 2.0)             1






OPEN/CAESAR MANUAL                          caesar_version(LOCAL)



     mutually up to date and compatible.

      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____CCCCOOOOMMMMPPPPAAAARRRREEEE____VVVVEEEERRRRSSSSIIIIOOOONNNN

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____BBBBOOOOOOOOLLLLEEEEAAAANNNN CCCCAAAAEEEESSSSAAAARRRR____CCCCOOOOMMMMPPPPAAAARRRREEEE____VVVVEEEERRRRSSSSIIIIOOOONNNN ((((CCCCAAAAEEEESSSSAAAARRRR____VVVV1111,,,, CCCCAAAAEEEESSSSAAAARRRR____VVVV2222))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____VVVVEEEERRRRSSSSIIIIOOOONNNN CCCCAAAAEEEESSSSAAAARRRR____VVVV1111;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____VVVVEEEERRRRSSSSIIIIOOOONNNN CCCCAAAAEEEESSSSAAAARRRR____VVVV2222;;;;
        {{{{ ............ }}}}

     This function returns CCCCAAAAEEEESSSSAAAARRRR____TTTTRRRRUUUUEEEE if  both  version  numbers
     CCCCAAAAEEEESSSSAAAARRRR____VVVV1111  and  CCCCAAAAEEEESSSSAAAARRRR____VVVV2222  are identical, or CCCCAAAAEEEESSSSAAAARRRR____FFFFAAAALLLLSSSSEEEE if
     they are not.

     Note: the standard C operator ======== should not be used for this
     purpose,  because of problems inherent to the floating-point
     representation. For instance, version number 1111....1111 will not be
     exactly  represented  as 1111....1111, but as 1111....11110000000000000000000000002222333388884444111188885555777799991111, so
     it is possible that 1111....1111 is not strictly equal to 1111....1111!  Func-
     tion CCCCAAAAEEEESSSSAAAARRRR____CCCCOOOOMMMMPPPPAAAARRRREEEE____VVVVEEEERRRRSSSSIIIIOOOONNNN solves this problem by comparing
     both version numbers with a limited precision (+/- 10^{-3}).

      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____MMMMAAAATTTTCCCCHHHH____VVVVEEEERRRRSSSSIIIIOOOONNNN

     CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____BBBBOOOOOOOOLLLLEEEEAAAANNNN CCCCAAAAEEEESSSSAAAARRRR____MMMMAAAATTTTCCCCHHHH____VVVVEEEERRRRSSSSIIIIOOOONNNN ((((CCCCAAAAEEEESSSSAAAARRRR____VVVV1111,,,, CCCCAAAAEEEESSSSAAAARRRR____VVVV2222))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____VVVVEEEERRRRSSSSIIIIOOOONNNN CCCCAAAAEEEESSSSAAAARRRR____VVVV1111;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____VVVVEEEERRRRSSSSIIIIOOOONNNN CCCCAAAAEEEESSSSAAAARRRR____VVVV2222;;;;
        {{{{ ............ }}}}

     This       function       returns       CCCCAAAAEEEESSSSAAAARRRR____TTTTRRRRUUUUEEEE       if
     CCCCAAAAEEEESSSSAAAARRRR____LLLLIIIIBBBBRRRRAAAARRRRYYYY____VVVVEEEERRRRSSSSIIIIOOOONNNN(((())))  is contained in the numeric inter-
     val  [CCCCAAAAEEEESSSSAAAARRRR____VVVV1111,  CCCCAAAAEEEESSSSAAAARRRR____VVVV2222],  or  CCCCAAAAEEEESSSSAAAARRRR____FFFFAAAALLLLSSSSEEEE   otherwise.
     CCCCAAAAEEEESSSSAAAARRRR____VVVV1111  and  CCCCAAAAEEEESSSSAAAARRRR____VVVV2222  can  be  equal: in this case, the
     result is CCCCAAAAEEEESSSSAAAARRRR____TTTTRRRRUUUUEEEE iff CCCCAAAAEEEESSSSAAAARRRR____LLLLIIIIBBBBRRRRAAAARRRRYYYY____VVVVEEEERRRRSSSSIIIIOOOONNNN(((()))) is  equal
     to CCCCAAAAEEEESSSSAAAARRRR____VVVV1111.

     The parameters CCCCAAAAEEEESSSSAAAARRRR____VVVV1111 and CCCCAAAAEEEESSSSAAAARRRR____VVVV2222 delimit the bounds of
     an  interval  of acceptable version numbers for the value of
     CCCCAAAAEEEESSSSAAAARRRR____LLLLIIIIBBBBRRRRAAAARRRRYYYY____VVVVEEEERRRRSSSSIIIIOOOONNNN(((()))), meaning that ssssppppeeeecccc....cccc can be  safely
     compiled  and  linked  with  any revision of the _O_P_E_N/_C_A_E_S_A_R
     library  whose  version  number  is  between  CCCCAAAAEEEESSSSAAAARRRR____VVVV1111  and
     CCCCAAAAEEEESSSSAAAARRRR____VVVV2222 (bounds included).

      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____CCCCHHHHEEEECCCCKKKK____VVVVEEEERRRRSSSSIIIIOOOONNNN

     vvvvooooiiiidddd CCCCAAAAEEEESSSSAAAARRRR____CCCCHHHHEEEECCCCKKKK____VVVVEEEERRRRSSSSIIIIOOOONNNN ((((CCCCAAAAEEEESSSSAAAARRRR____VVVV1111,,,, CCCCAAAAEEEESSSSAAAARRRR____VVVV2222))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____VVVVEEEERRRRSSSSIIIIOOOONNNN CCCCAAAAEEEESSSSAAAARRRR____VVVV1111;;;;



(C) INRIA     Last change: 2020/02/11 (version 2.0)             2






OPEN/CAESAR MANUAL                          caesar_version(LOCAL)



        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____VVVVEEEERRRRSSSSIIIIOOOONNNN CCCCAAAAEEEESSSSAAAARRRR____VVVV2222;;;;
        {{{{ ............ }}}}

     This procedure evaluates the following boolean expression:

             CCCCAAAAEEEESSSSAAAARRRR____MMMMAAAATTTTCCCCHHHH____VVVVEEEERRRRSSSSIIIIOOOONNNN ((((CCCCAAAAEEEESSSSAAAARRRR____VVVV1111,,,, CCCCAAAAEEEESSSSAAAARRRR____VVVV2222))))

     and aborts the execution if the result is equal to 0.

     Note: This function should be called in the ssssppppeeeecccc....cccc  program,
     for    instance    at    the    beginning    of    procedure
     CCCCAAAAEEEESSSSAAAARRRR____IIIINNNNIIIITTTT____GGGGRRRRAAAAPPPPHHHH(((()))).

      ............................................................

  CCCCAAAAEEEESSSSAAAARRRR____PPPPRRRRIIIINNNNTTTT____VVVVEEEERRRRSSSSIIIIOOOONNNN

     vvvvooooiiiidddd CCCCAAAAEEEESSSSAAAARRRR____PPPPRRRRIIIINNNNTTTT____VVVVEEEERRRRSSSSIIIIOOOONNNN ((((CCCCAAAAEEEESSSSAAAARRRR____FFFFIIIILLLLEEEE,,,, CCCCAAAAEEEESSSSAAAARRRR____VVVV))))
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____FFFFIIIILLLLEEEE CCCCAAAAEEEESSSSAAAARRRR____FFFFIIIILLLLEEEE;;;;
        CCCCAAAAEEEESSSSAAAARRRR____TTTTYYYYPPPPEEEE____VVVVEEEERRRRSSSSIIIIOOOONNNN CCCCAAAAEEEESSSSAAAARRRR____VVVV;;;;
        {{{{ ............ }}}}

     This procedure prints to file CCCCAAAAEEEESSSSAAAARRRR____FFFFIIIILLLLEEEE a character string
     representing the version number CCCCAAAAEEEESSSSAAAARRRR____VVVV.

     Before this procedure is called, CCCCAAAAEEEESSSSAAAARRRR____FFFFIIIILLLLEEEE must have  been
     properly opened, for instance using ffffooooppppeeeennnn((((3333)))).

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





(C) INRIA     Last change: 2020/02/11 (version 2.0)             3






OPEN/CAESAR MANUAL                          caesar_version(LOCAL)



     Directives   for   installation   are   given    in    files
     $$$$CCCCAAAADDDDPPPP////IIIINNNNSSSSTTTTAAAALLLLLLLLAAAATTTTIIIIOOOONNNN____****....

     Recent  changes  and  improvements  to  this  software   are
     reported and commented in file $$$$CCCCAAAADDDDPPPP////HHHHIIIISSSSTTTTOOOORRRRYYYY....

BBBBUUUUGGGGSSSS
     Known  bugs  are  described  in  the  Reference  Manual   of
     OPEN/CAESAR.  Please report new bugs to cadp@inria.fr














































(C) INRIA     Last change: 2020/02/11 (version 2.0)             4



