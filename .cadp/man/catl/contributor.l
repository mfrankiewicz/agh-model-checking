


CADP MANUAL PAGES                              CONTRIBUTOR(LOCAL)



NNNNAAAAMMMMEEEE
     contributor - CADP contribution assistant


SSSSYYYYNNNNOOOOPPPPSSSSIIIISSSS
     ccccoooonnnnttttrrrriiiibbbbuuuuttttoooorrrr


DDDDEEEESSSSCCCCRRRRIIIIPPPPTTTTIIIIOOOONNNN
     This program is a utility that you can use to contribute  to
     CADP testing, by sending files to be added to the regression
     test suite. You can use it to select files on your  computer
     and  to  send  them  by FTP transfer to the CADP development
     team. Your files will help our continuing efforts to improve
     quality and stability of CADP, and your contribution ensures
     that we will test features that are of  particular  interest
     to you.


     The files that you contribute are related to CADP,  such  as
     LOTOS  specifications,  BCG  graphs,  MCL  or  XTL formulas,
     Boolean equation systems, etc. They are treated as confiden-
     tial  and used only by the CADP team for testing future ver-
     sions of CADP.


     ccccoooonnnnttttrrrriiiibbbbuuuuttttoooorrrr runs on your local machine,  making  no  network
     connection except to send your contribution to the CADP team
     by FTP at the end of processing.


     You have complete control over  when  you  use  ccccoooonnnnttttrrrriiiibbbbuuuuttttoooorrrr.
     You  choose  the  directories that ccccoooonnnnttttrrrriiiibbbbuuuuttttoooorrrr is allowed to
     search, and the types  of  files  (by  specifying  the  file
     extensions)  that  ccccoooonnnnttttrrrriiiibbbbuuuuttttoooorrrr  is  allowed to consider.  To
     refine this set of directories and  files,  ccccoooonnnnttttrrrriiiibbbbuuuuttttoooorrrr  has
     also  built-in rules that attempt to select only those files
     that are relevant for testing CADP tools.


     Additionally, you have an opportunity to review the  set  of
     selected  files  and  to exclude any that you do not wish to
     send.


     ccccoooonnnnttttrrrriiiibbbbuuuuttttoooorrrr does not send files you have previously  contri-
     buted  (to avoid duplicates) nor files that you have already
     excluded during a previous invocation of ccccoooonnnnttttrrrriiiibbbbuuuuttttoooorrrr.


     Running ccccoooonnnnttttrrrriiiibbbbuuuuttttoooorrrr only takes a few minutes, and it has  no
     impact  on other CADP components. You are recommended to run



(C) INRIA            Last change: 2013/09/17                    1






CADP MANUAL PAGES                              CONTRIBUTOR(LOCAL)



     it every six months and on completion of  significant  work,
     which  will  help  the CADP team to keep the regression test
     suite up to date and in line with the needs of  CADP  users.
     Use  of  ccccoooonnnnttttrrrriiiibbbbuuuuttttoooorrrr  is completely optional, but is greatly
     appreciated.


PPPPRRRREEEEFFFFEEEERRRREEEENNNNCCCCEEEESSSS AAAANNNNDDDD RRRRUUUULLLLEEEESSSS
     Each time you use ccccoooonnnnttttrrrriiiibbbbuuuuttttoooorrrr,,,,  it  saves  (in  a  directory
     named   ~~~~////....ccccoooonnnnffffiiiigggg////ccccaaaaddddpppp////ccccoooonnnnttttrrrriiiibbbbuuuuttttoooorrrr)  information  about  the
     preferences you specified for ccccoooonnnnttttrrrriiiibbbbuuuuttttoooorrrr, such as the  list
     of  directories  to search, the file extensions to consider,
     the files you specifically excluded, the files already sent,
     etc.  This information is used the next time you use ccccoooonnnnttttrrrriiii----
     bbbbuuuuttttoooorrrr, but you can override it.


     ccccoooonnnnttttrrrriiiibbbbuuuuttttoooorrrr has a built-in set of rules that  exclude  files
     that  seem  unrelated  to CADP.  These rules are defined for
     each file extension. For example, a C program (with  a  "....cccc"
     or "....hhhh" file extension) will only be selected if it contains
     certain strings (e.g., the string "CCCCAAAAEEEESSSSAAAARRRR"). There are  also
     limits  on  the  size  of  files that can be selected.  User
     selection has precedence over the built-in rules, so you can
     decide  to  send any file, even if the rules would otherwise
     exclude it from the contribution.


UUUUSSSSAAAAGGGGEEEE
     There are five steps to using ccccoooonnnnttttrrrriiiibbbbuuuuttttoooorrrr:


     1111.... Select the  directories  where  the  files  to  send  are
     located.   If  you are using ccccoooonnnnttttrrrriiiibbbbuuuuttttoooorrrr for the first time,
     your home directory is included by default.
          see http://cadp.inria.fr/man/pictures/contrib1.gif


     2222.... Select the file types (file extensions) of the  files  to
     be sent.
          see http://cadp.inria.fr/man/pictures/contrib2.gif


     3333.... Based on your selection ccccoooonnnnttttrrrriiiibbbbuuuuttttoooorrrr computes  a  proposed
     list  of  files to be sent, by applying your preferences and
     the built-in rules, not selecting files  that  have  already
     been sent or files that you previously excluded.
          see http://cadp.inria.fr/man/pictures/contrib3.gif


     4444.... Review the proposed list, and add or exclude files to get
     the  final  list  you want to send to the CADP team. You can



(C) INRIA            Last change: 2013/09/17                    2






CADP MANUAL PAGES                              CONTRIBUTOR(LOCAL)



     view the content of a file by double-clicking on  its  name.
     Also, by checking the relevant boxes on the the right of the
     window, you can view the files that  are  excluded  by  your
     preferences   (user-excluded  files),  the  files  that  are
     excluded by the built-in rules (rules-excluded  files),  and
     the files that have already been sent.
          see http://cadp.inria.fr/man/pictures/contrib4.gif


     5555.... Using your final selection list,  ccccoooonnnnttttrrrriiiibbbbuuuuttttoooorrrr  creates  a
     ....ttttaaaarrrr....ggggzzzz archive containing all the files selected, and sends
     it by FTP to ffffttttpppp....iiiinnnnrrrriiiiaaaallllppppeeeessss....ffffrrrr.
          see http://cadp.inria.fr/man/pictures/contrib5.gif


     Note: This archive is stored in the directory  specified  by
     the $$$$CCCCAAAADDDDPPPP____TTTTMMMMPPPP environment variable, or in ////ttttmmmmpppp if this vari-
     able is undefined.  If  the  FTP  transfer  via  ccccoooonnnnttttrrrriiiibbbbuuuuttttoooorrrr
     fails,  retry  the  FTP  transfer manually. If this is still
     unsuccessful,  please  contact  the  CADP  team  to  arrange
     another method of transfering the file.


EEEEXXXXIIIITTTT SSSSTTTTAAAATTTTUUUUSSSS
     Exit status is 0 if everything is alright, 1 otherwise.


AAAAUUUUTTTTHHHHOOOORRRRSSSS
     Julien Henry, Hubert Garavel, and Christine  McKinty  (INRIA
     Rhone-Alpes)


FFFFIIIILLLLEEEESSSS
     ccccoooonnnnttttrrrriiiibbbbuuuuttttoooorrrr    is    a    shell    script     located     in
     $$$$CCCCAAAADDDDPPPP////ccccoooommmm////ccccoooonnnnttttrrrriiiibbbbuuuuttttoooorrrr  that  launches  a Tcl/Tk script to be
     executed by the wwwwiiiisssshhhh interpreter. The source files  of  ccccoooonnnn----
     ttttrrrriiiibbbbuuuuttttoooorrrr are available in directory $$$$CCCCAAAADDDDPPPP////ssssrrrrcccc////ccccoooonnnnttttrrrriiiibbbbuuuuttttoooorrrr


SSSSEEEEEEEE AAAALLLLSSSSOOOO
     Additional information is available from the CADP  Web  page
     located at http://cadp.inria.fr

     Directives   for   installation   are   given    in    files
     $$$$CCCCAAAADDDDPPPP////IIIINNNNSSSSTTTTAAAALLLLLLLLAAAATTTTIIIIOOOONNNN____****....

     Recent  changes  and  improvements  to  this  software   are
     reported and commented in file $$$$CCCCAAAADDDDPPPP////HHHHIIIISSSSTTTTOOOORRRRYYYY....


BBBBUUUUGGGGSSSS
     Please report new bugs to Hubert.Garavel@inria.fr



(C) INRIA            Last change: 2013/09/17                    3






CADP MANUAL PAGES                              CONTRIBUTOR(LOCAL)























































(C) INRIA            Last change: 2013/09/17                    4






