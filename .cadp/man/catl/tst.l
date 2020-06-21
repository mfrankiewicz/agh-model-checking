


CADP MANUAL PAGES                                      TST(LOCAL)



NNNNAAAAMMMMEEEE
     tst - CADP installation and configuration auto-test facility


SSSSYYYYNNNNOOOOPPPPSSSSIIIISSSS
     ttttsssstttt [_a_r_c_h]


DDDDEEEESSSSCCCCRRRRIIIIPPPPTTTTIIIIOOOONNNN
     This program checks the way CADP is installed and configured
     on  the  current  machine in order to detect potential prob-
     lems.  Many  verifications  are  performed,  most  of  which
     derived from common problems reported by CADP users.


     This program should  be  run  after  every  installation  or
     upgrade  of  CADP,  as  well  as every time a problem occurs
     (especially when reporting a bug to the developers of CADP).


OOOOPPPPTTTTIIIIOOOONNNNSSSS
     Depending on the optional parameter _a_r_c_h, ttttsssstttt has  two  dif-
     ferent usages.


     If _a_r_c_h is absent, then ttttsssstttt will check the  current  machine
     on  which  CADP  is installed. In such case, the environment
     variable $$$$CCCCAAAADDDDPPPP should point to the directory in  which  CADP
     is installed.


     If _a_r_c_h is present, then ttttsssstttt will check the current  machine
     on  which  CADP is supposed not to be installed yet. In such
     case, _a_r_c_h should be equal to the name of  the  architecture
     of the current machine, for instance "sun4", "sun5", "iX86",
     "win32"... The list of architecture names supported by  CADP
     is defined in file $$$$CCCCAAAADDDDPPPP////IIIINNNNSSSSTTTTAAAALLLLLLLLAAAATTTTIIIIOOOONNNN____2222....


EEEEXXXXIIIITTTT SSSSTTTTAAAATTTTUUUUSSSS
     Exit status is 0 if everything is alright, 1 otherwise.


AAAAUUUUTTTTHHHHOOOORRRR
     Hubert Garavel (INRIA Rhone-Alpes)


FFFFIIIILLLLEEEESSSS
     The source code (Bourne shell script) of this tool is avail-
     able in file $$$$CCCCAAAADDDDPPPP////ccccoooommmm////ttttsssstttt





(C) INRIA            Last change: 2013/09/09                    1






CADP MANUAL PAGES                                      TST(LOCAL)



SSSSEEEEEEEE AAAALLLLSSSSOOOO
     Additional information is available from the CADP  Web  page
     located at http://cadp.inria.fr

     Directives   for   installation   are   given    in    files
     $$$$CCCCAAAADDDDPPPP////IIIINNNNSSSSTTTTAAAALLLLLLLLAAAATTTTIIIIOOOONNNN____****....

     Recent  changes  and  improvements  to  this  software   are
     reported and commented in file $$$$CCCCAAAADDDDPPPP////HHHHIIIISSSSTTTTOOOORRRRYYYY....


BBBBUUUUGGGGSSSS
     Please report new bugs to Hubert.Garavel@inria.fr










































(C) INRIA            Last change: 2013/09/09                    2



