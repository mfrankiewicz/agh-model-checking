


CADP MANUAL PAGES                                      PBG(LOCAL)



NNNNAAAAMMMMEEEE
     pbg, PBG - Partitioned BCG File format


DDDDEEEESSSSCCCCRRRRIIIIPPPPTTTTIIIIOOOONNNN
     The PBG (Partitioned BCG File) format is a  software  imple-
     mentation   of   the  theoretical  concept  of  "Partitioned
     Labelled Transition System" introduced in [GMS01].


     A file in the PBG format has a ....ppppbbbbgggg extension and gathers  a
     collection  of  BCG  files,  called "fragments". Taken alto-
     gether, these fragments form a partition of a Labelled Tran-
     sition System, the states and transitions of which have been
     distributed among the various  fragments,  as  specified  in
     [GMS01].


     Note that, taken  individually,  each  fragment  is  usually
     meaningless;  in particular, it may be a disconnected graph,
     which is never the case with a state space  generated  using
     forward reachability exploration.


     The PBG format is currently undocumented, and may evolve  in
     the  future.  However, PBG files are text files easily read-
     able by humans.  Concretely, a PBG file is a text file  that
     contains  references to a GCF file and to BCG fragments. See
     ggggccccffff(LOCAL) and bbbbccccgggg(LOCAL) for further information about  the
     GCF and BCG formats.


     There is one BCG fragment per instance  listed  in  the  GCF
     file.   The  BCG  fragments  are  either stored on the local
     machine in case of a shared filesystem (e.g., NFS, etc.)  or
     stored  on remote machines in the working directories speci-
     fied in the GCF file.


HHHHOOOOWWWW TTTTOOOO CCCCRRRREEEEAAAATTTTEEEE,,,, RRRREEEEAAAADDDD,,,, AAAANNNNDDDD HHHHAAAANNNNDDDDLLLLEEEE PPPPBBBBGGGG FFFFIIIILLLLEEEESSSS
     A PBG file can be created using the ddddiiiissssttttrrrriiiibbbbuuuuttttoooorrrr(LOCAL) tool.


     A PBG file and its fragments can be recombined into a single
     BCG  file  using  the bbbbccccgggg____mmmmeeeerrrrggggeeee(LOCAL) tool,  which performs
     additional actions, such as state renumbering.


     PBG files and their BCG associated fragments can be  handled
     using the ppppbbbbgggg____ccccpppp(LOCAL), ppppbbbbgggg____iiiinnnnffffoooo(LOCAL), ppppbbbbgggg____mmmmvvvv(LOCAL), and
     ppppbbbbgggg____rrrrmmmm(LOCAL) tools.




(C) INRIA            Last change: 2018/05/17                    1






CADP MANUAL PAGES                                      PBG(LOCAL)



BBBBIIIIBBBBLLLLIIIIOOOOGGGGRRRRAAAAPPPPHHHHYYYY
     [GMS01] Hubert Garavel, Radu  Mateescu,  and  Irina  Smaran-
     dache. Parallel State Space Construction for Model-Checking.
     In Matthew B. Dwyer, ed, Proceedings  of  the  8th  Interna-
     tional   SPIN   Workshop   on  Model  Checking  of  Software
     (SPIN'01), Toronto, Canada, LNCS  2057,  pp.   217-234,  May
     2001.  Revised  version  available  as INRIA Research Report
     RR-4341,      December      2001.       Available       from
     http://cadp.inria.fr/publications/Garavel-Mateescu-
     Smarandache-01.html


     [GMB+06] Hubert Garavel, Radu  Mateescu,  Damien  Bergamini,
     Adrian  Curic,  Nicolas Descoubes, Christophe Joubert, Irina
     Smarandache-Sturm, and  Gilles  Stragier.   DISTRIBUTOR  and
     BCG_MERGE:  Tools  for Distributed Explicit State Space Gen-
     eration.   In  Holger  Hermanns  and  Jens  Palberg,   eds.,
     Proceedings  of  the  12th International Conference on Tools
     and Algorithms for the Construction and Analysis of  Systems
     (TACAS'06),  Vienna, Austria, LNCS 3920, pp. 445-449, March-
     April            2006.            Available             from
     http://cadp.inria.fr/publications/Garavel-Mateescu-
     Bergamini-et-al-06.html


     [GMS12] Hubert Garavel, Radu Mateescu, and  Wendelin  Serwe.
     Large-scale  Distributed  Verification  using  CADP:  Beyond
     Clusters to Grids.  Electronic Notes in Theoretical Computer
     Science,  vol. 296, pp. 145-161, August 2012. Available from
     http://cadp.inria.fr/publications/Garavel-Mateescu-Serwe-
     12.html


SSSSEEEEEEEE AAAALLLLSSSSOOOO
     bbbbccccgggg(LOCAL), ggggccccffff(LOCAL), bbbbccccgggg____mmmmeeeerrrrggggeeee(LOCAL) ddddiiiissssttttrrrriiiibbbbuuuuttttoooorrrr(LOCAL),
     ppppbbbbgggg____ccccpppp(LOCAL), ppppbbbbgggg____iiiinnnnffffoooo(LOCAL), ppppbbbbgggg____mmmmvvvv(LOCAL), ppppbbbbgggg____rrrrmmmm(LOCAL)


     Additional information is available from the CADP  Web  page
     located at http://cadp.inria.fr

     Directives   for   installation   are   given    in    files
     $$$$CCCCAAAADDDDPPPP////IIIINNNNSSSSTTTTAAAALLLLLLLLAAAATTTTIIIIOOOONNNN____****.

     Recent  changes  and  improvements  to  this  software   are
     reported and commented in file $$$$CCCCAAAADDDDPPPP////HHHHIIIISSSSTTTTOOOORRRRYYYY.


BBBBUUUUGGGGSSSS
     Please report bugs to cadp@inria.fr





(C) INRIA            Last change: 2018/05/17                    2






CADP MANUAL PAGES                                      PBG(LOCAL)























































(C) INRIA            Last change: 2018/05/17                    3






