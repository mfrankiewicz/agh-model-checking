


CADP MANUAL PAGES                              INSTALLATOR(LOCAL)



NNNNAAAAMMMMEEEE
     installator - CADP installation assistant


SSSSYYYYNNNNOOOOPPPPSSSSIIIISSSS
     iiiinnnnssssttttaaaallllllllaaaattttoooorrrr [----bbbbeeeettttaaaa]


DDDDEEEESSSSCCCCRRRRIIIIPPPPTTTTIIIIOOOONNNN
     This program installs CADP on  one  machine  or  on  several
     machines  connected  by a Local Area Network. It can also be
     used  to  upgrade  an  existing  version  of  CADP   already
     installed. Installator takes in charge the following tasks:

     -    Inquiry about the latest version of CADP  available  on
          the FTP site of CADP,

     -    Download of the latest version of CADP available  using
          the FTP protocol,

     -    Archive extraction and  installation  of  CADP  on  the
          local machine or network,

     -    Registration of CADP using the Request For License pro-
          cedure.


     Although a manual installation of CADP also exists, the  use
     of  iiiinnnnssssttttaaaallllllllaaaattttoooorrrr  is strongly recommended, as it ensures that
     the installation will be done correctly and automatically.

          see http://cadp.inria.fr/man/pictures/install1.gif
          see http://cadp.inria.fr/man/pictures/install2.gif
          see http://cadp.inria.fr/man/pictures/install3.gif
          see http://cadp.inria.fr/man/pictures/install4.gif
                 _A _f_e_w _s_n_a_p_s_h_o_t_s _o_f _I_n_s_t_a_l_l_a_t_o_r


OOOOPPPPTTTTIIIIOOOONNNNSSSS
     ----bbbbeeeettttaaaa
          download a beta-version of CADP (instead  of  a  plain,
          stable version). Do not use this option unless you have
          been specifically advised to do so by the CADP develop-
          ment team.


EEEEXXXXIIIITTTT SSSSTTTTAAAATTTTUUUUSSSS
     Exit status is 0 if everything is alright, 1 otherwise.


AAAAUUUUTTTTHHHHOOOORRRRSSSS
     Hubert Garavel, Aldo Mazzilli, Patrick Wendel (INRIA  Rhone-



(C) INRIA            Last change: 2013/11/08                    1






CADP MANUAL PAGES                              INSTALLATOR(LOCAL)



     Alpes)


FFFFIIIILLLLEEEESSSS
     iiiinnnnssssttttaaaallllllllaaaattttoooorrrr    is    a    shell    script     located     in
     $$$$CCCCAAAADDDDPPPP////ccccoooommmm////iiiinnnnssssttttaaaallllllllaaaattttoooorrrr  that  launches  a Tcl/Tk script to be
     executed by the wwwwiiiisssshhhh interpreter. The source files  of  iiiinnnnssss----
     ttttaaaallllllllaaaattttoooorrrr are available in directory $$$$CCCCAAAADDDDPPPP////ssssrrrrcccc////iiiinnnnssssttttaaaallllllllaaaattttoooorrrr


SSSSEEEEEEEE AAAALLLLSSSSOOOO
     ttttsssstttt(LOCAL)


     Additional information is available from the CADP  Web  page
     located at http://cadp.inria.fr

     Directives   for   installation   are   given    in    files
     $$$$CCCCAAAADDDDPPPP////IIIINNNNSSSSTTTTAAAALLLLLLLLAAAATTTTIIIIOOOONNNN____****....

     Recent  changes  and  improvements  to  this  software   are
     reported and commented in file $$$$CCCCAAAADDDDPPPP////HHHHIIIISSSSTTTTOOOORRRRYYYY....


BBBBUUUUGGGGSSSS
     Please report new bugs to Hubert.Garavel@inria.fr





























(C) INRIA            Last change: 2013/11/08                    2



