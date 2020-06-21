


CADP MANUAL PAGES                                      GCF(LOCAL)



NNNNAAAAMMMMEEEE
     gcf, GCF - Grid Configuration File format


DDDDEEEESSSSCCCCRRRRIIIIPPPPTTTTIIIIOOOONNNN
     A file in the GCF (Grid Configuration  File)  format  has  a
     ....ggggccccffff  extension  and  specifies a list of "instances" (i.e.,
     distributed processes) to be launched by the CADP tools pro-
     viding distributed verification, such as ddddiiiissssttttrrrriiiibbbbuuuuttttoooorrrr(LOCAL),
     bbbbccccgggg____mmmmeeeerrrrggggeeee(LOCAL), and the PBG tools as well:  ppppbbbbgggg____ccccpppp(LOCAL),
     ppppbbbbgggg____iiiinnnnffffoooo(LOCAL), etc. Such a tool will be called the "parent
     program" in the sequel.  The GCF format also  specifies  the
     various   variables   used  for  launching,  connecting  and
     parameterizing instances on remote machines.


     Each instance corresponds to a  pair  (_m_a_c_h_i_n_e,  _d_i_r_e_c_t_o_r_y).
     For  each  instance,  a  distributed  process  executing  on
     _m_a_c_h_i_n_e will be launched by the parent program. This distri-
     buted  process  will store its files in _d_i_r_e_c_t_o_r_y located on
     some filesystem of _m_a_c_h_i_n_e. _d_i_r_e_c_t_o_r_y is called the "working
     directory" of the instance.


     Instances may or may not be launched on the  local  machine,
     depending  on  the  constraints on grid usage. For instance,
     clusters often distinguish between one frontal  node  (i.e.,
     the  local  machine) used to submit jobs to the cluster, and
     many computing nodes (i.e., the remote machines)  that  per-
     form distributed computations.


     Each instance is given a unique number greater or  equal  to
     1.  Numbers  are  assigned  in  the  same order as instances
     appear in the grid configuration file. Number 0 is  reserved
     for the process corresponding to the execution of the parent
     program on the local machine.


     If the grid configuration file contains duplicated instances
     (i.e.,  same  machine and same directory), only the last one
     is considered, the previous ones being entirely discarded.


     There should be at least two different  instances.   Several
     instances  may  execute  on  the same machine, provided that
     their working directories are  different.  Also,  a  working
     directory  may  be  either  local  to  its machine or shared
     between several machines (using NFS, Samba, etc.).






(C) INRIA            Last change: 2016/12/07                    1






CADP MANUAL PAGES                                      GCF(LOCAL)



     The grid configuration file  also  specifies  the  value  of
     (predefined) variables used to control the way instances are
     launched and communicate with each other.


SSSSYYYYNNNNTTTTAAAAXXXX OOOOFFFF TTTTHHHHEEEE GGGGCCCCFFFF FFFFOOOORRRRMMMMAAAATTTT
     The grid configuration file has the following syntax:

        <gcf>          ::= <global_opt> <instance_opt>*
        <global_opt>   ::= <directive>*
        <instance_opt> ::= <machine> <machine>* <directive>*
        <machine>      ::= <address-or-name> "\n"
        <directive>    ::= <variable> "=" <value> "\n"
        <variable>     ::= "buffer_size" | "cadp" | "connect_timeout"
                        |  "directory" | "files" | "hash" | "memory"
                        |  "port" |  "rcp" | "rsh" | "time" | "user"
        <value>        ::= <character-string>


     where:


     -    <<<<gggglllloooobbbbaaaallll____oooopppptttt>>>> is a (possibly empty) list  of  directives
          applicable to every instance.


     -    <<<<iiiinnnnssssttttaaaannnncccceeee____oooopppptttt>>>>  defines  one   or   several   instances
          together  with  a  (possibly  empty) list of directives
          applicable to these instances exclusively.


     -    <<<<mmmmaaaacccchhhhiiiinnnneeee>>>> is the name of a (local or  remote)  machine,
          either   given   as   a  numerical  IP  address  (e.g.,
          "138.96.146.2") or as an Internet machine  name  (e.g.,
          "vasy.inria.fr"), followed by a newline character.


     -    <<<<ddddiiiirrrreeeeccccttttiiiivvvveeee>>>> is an assignment of a <<<<vvvvaaaalllluuuueeee>>>> to  a  <<<<vvvvaaaarrrriiii----
          aaaabbbblllleeee>>>>, followed by a newline character.


     Any line starting with the "#" character is considered as  a
     comment  and ignored. Spaces and tabulations can be inserted
     before, between, or after terminal symbols.


GGGGCCCCFFFF VVVVAAAARRRRIIIIAAAABBBBLLLLEEEESSSS
     Variables can be modified by directives as  follows.  First,
     some  variables  have  a  default  value, which will be used
     unless overriden by some directive.  A <<<<ddddiiiirrrreeeeccccttttiiiivvvveeee>>>> occurring
     in  the  <<<<gggglllloooobbbbaaaallll____oooopppptttt>>>>  list  assigns  its <<<<vvvvaaaarrrriiiiaaaabbbblllleeee>>>> for all
     machines. A directive occurring  in  a  <<<<iiiinnnnssssttttaaaannnncccceeee____oooopppptttt>>>>  list



(C) INRIA            Last change: 2016/12/07                    2






CADP MANUAL PAGES                                      GCF(LOCAL)



     assigns  its  <<<<vvvvaaaarrrriiiiaaaabbbblllleeee>>>>  only for the machines mentioned in
     this <<<<iiiinnnnssssttttaaaannnncccceeee____oooopppptttt>>>>, possibly overriding the value specified
     for this <<<<vvvvaaaarrrriiiiaaaabbbblllleeee>>>> in the <<<<gggglllloooobbbbaaaallll____oooopppptttt>>>> list.


     The meaning of the different variables is the following:


     bbbbuuuuffffffffeeeerrrr____ssssiiiizzzzeeee:
          This variable specifies the size (in bytes) of the com-
          munication  buffers  used between instances (either for
          incoming data or outgoing data). This variable can only
          be  set in the <<<<gggglllloooobbbbaaaallll____oooopppptttt>>>> list, meaning that all com-
          munication buffers must have  the  same  size.  Maximal
          value is 2,147,483,648.  Default value is 65536.


     ccccaaaaddddpppp:
          This variable specifies the pathname of  the  directory
          in  which  the CADP toolbox is installed. This pathname
          must be an absolute one, i.e., it must start with a "/"
          character.  It  may  contain  spaces  provided that the
          entire pathname is enclosed between double quotes.

          The pathname may be the same for all machines (e.g., if
          the  CADP  toolbox  is installed on a common filesystem
          shared between all machines) or  may  be  different  on
          each  machine.  In any case, the CADP toolbox should be
          properly installed on the local  and  remote  machines.
          Default  value  is given by the $$$$CCCCAAAADDDDPPPP environment vari-
          able.


     ccccoooonnnnnnnneeeecccctttt____ttttiiiimmmmeeeeoooouuuutttt:
          This  variable  specifies  the  timeout  (in   seconds)
          allowed  for  establishing  a  connection  to  a remote
          machine.  This  variable  can  only  be  set   in   the
          <<<<gggglllloooobbbbaaaallll____oooopppptttt>>>>  list,  meaning  that each connection must
          succeed within the specified timeout.  Default value is
          20 seconds.


     ddddiiiirrrreeeeccccttttoooorrrryyyy:
          This variable specifies the  pathname  of  the  working
          directory in which an instance will place all the files
          needed for its execution or created during  its  execu-
          tion  (e.g.,  a  copy  of the binary code of the parent
          program, a copy of the GCF file, a generated  BCG  file
          fragment, log files, etc.).  If the specified directory
          does not exist, it will be created.

          This pathname can be either an absolute  one  (starting



(C) INRIA            Last change: 2016/12/07                    3






CADP MANUAL PAGES                                      GCF(LOCAL)



          with  a "/" character) or a relative one, in which case
          it is interpreted with respect to the current directory
          on  the  local machine and to the user's home directory
          on remote machines. It may contain spaces provided that
          the  entire pathname is enclosed between double quotes.
          It should not contain the tilde character "~".  Default
          value is the user's home directory (which is not recom-
          mended unless when using a cluster of machines).


     ffffiiiilllleeeessss:
          This variable specifies a set of files to be copied  to
          the  remote  machines (in the working directory) before
          launching the different instances. Setting  this  vari-
          able provides to instances executing on remote machines
          additional input files needed for their execution. This
          allows  to  take  into account "hidden" dependences, as
          these input files may or may not be  mentioned  on  the
          command line used to invoke the parent program.

          For  instance,  when   running   the   parent   program
          ddddiiiissssttttrrrriiiibbbbuuuuttttoooorrrr(LOCAL)  using bbbbccccgggg____ooooppppeeeennnn(LOCAL), the _s_p_e_c....bbbbccccgggg
          file must be present on  the  remote  machines.   Simi-
          larly,    when    running    ddddiiiissssttttrrrriiiibbbbuuuuttttoooorrrr(LOCAL)   using
          eeeexxxxpppp....ooooppppeeeennnn(LOCAL),  all  the  BCG  files  referenced   in
          _s_p_e_c....eeeexxxxpppp must also be present on the remote machines.

          This variable may specify either a single filename or a
          set  of  filenames  separated  by spaces. Filenames may
          contain the wildcard characters ("*",  "?",  "[",  "]",
          ...)   according   to  the  Bourne  shell  conventions.
          Default value is empty.


     hhhhaaaasssshhhh:
          This variable specifies the hash function  to  be  used
          for  partitioning  states between machines (see [GMS01]
          for details). Its value is an integer _n between 0 and 7
          denoting        the        corresponding       function
          CCCCAAAAEEEESSSSAAAARRRR____SSSSTTTTAAAATTTTEEEE_____n____HHHHAAAASSSSHHHH(((()))) of the ccccaaaaeeeessssaaaarrrr____hhhhaaaasssshhhh(LOCAL) library
          of  OPEN/CAESAR.  This  variable can only be set in the
          <<<<gggglllloooobbbbaaaallll____oooopppptttt>>>> list, meaning that all instances  use  the
          same hash function.  Default value is 3.


     mmmmeeeemmmmoooorrrryyyy:
          This variable has currently no effect. It  is  reserved
          for future use.


     ppppoooorrrrtttt:
          This variable specifies the TCP port  to  be  used  for



(C) INRIA            Last change: 2016/12/07                    4






CADP MANUAL PAGES                                      GCF(LOCAL)



          communicating  with  the  instance.  Usually, it is not
          necessary to set this  variable  explicitly  unless  to
          comply  with  firewall  restrictions.  A TCP port is an
          integer value in the range 1...65,535. Using a TCP port
          lower than 1024 is not recommended and may require spe-
          cial privileges (such as being the super-user  on  Unix
          systems).  By default, or in case of failure when open-
          ing the  specified  port,  the  port  value  is  chosen
          automatically.


     rrrrccccpppp: This variable specifies the command used to copy  files
          from  the  local  machine to the working directories on
          the remote machines.  This command must be  present  in
          one  of  the directories given by the $$$$PPPPAAAATTTTHHHH environment
          variable. Its command line syntax should be the same as
          for the rrrrccccpppp(1) command, i.e.,
             rrrrccccpppp _l_o_c_a_l__f_i_l_e_s _u_s_e_r_n_a_m_e@_h_o_s_t_n_a_m_e:_d_i_r_e_c_t_o_r_y

          Default value is rrrrccccpppp. Other possible  values  are  ssssccccpppp,
          kkkkccccpppp, or any similar variant of rrrrccccpppp(1).  Remote machines
          should be configured in such a way that remote copy can
          be  done automatically without asking for a password or
          a passphrase;  this  is  usually  done  by  setting  an
          appropriate  ".rhosts"  or  ".ssh/authorized_keys" file
          and/or launching an SSH agent before running the parent
          program.

          There is also a special value nnnnffffssss, which indicates that
          all  instances  have  the  same  working directory on a
          filesystem shared between  all  machines  (e.g.,  using
          NFS),  so  that  no  remote copy is necessary.  Setting
          variable rrrrccccpppp to the value nnnnffffssss can only be done  in  the
          <<<<gggglllloooobbbbaaaallll____oooopppptttt>>>> list.


     rrrrsssshhhh: This variable  specifies  the  command  used  to  lauch
          instances  on  remote  machines from the local machine.
          This command must be present in one of the  directories
          given  by  the  $$$$PPPPAAAATTTTHHHH environment variable. Its command
          line syntax should be the same as for the  rrrrsssshhhh(1)  com-
          mand, i.e.,
             rrrrsssshhhh ----llll _u_s_e_r_n_a_m_e _h_o_s_t_n_a_m_e "_s_h_e_l_l__c_o_m_m_a_n_d ..."

          Default value is rrrrsssshhhh. Other possible  values  are  sssssssshhhh,
          kkkkrrrrsssshhhh,   or  any  similar  variant  of  rrrrsssshhhh(1).   Remote
          machines should be configured in such a way that remote
          authentication can be done automatically without asking
          for a password or a passphrase; this is usually done by
          setting      an      appropriate      ".rhosts"      or
          ".ssh/authorized_keys" file  and/or  launching  an  SSH
          agent before running the parent program.



(C) INRIA            Last change: 2016/12/07                    5






CADP MANUAL PAGES                                      GCF(LOCAL)



          It  is  possible  to  supply  options  to  the  command
          assigned  to  the _r_s_h variable (such as rrrrsssshhhh====sssssssshhhh ----6666) but
          certain options (e.g., sssssssshhhh ----vvvv) program.


     ttttiiiimmmmeeee:
          This variable, if set, contains  a  Unix  command  name
          that will be inserted before the shell commands used to
          launch instances on remote machines.   Possible  values
          of  this variable are "/usr/bin/time", "memtime", "val-
          grind", etc. It is therefore possible  to  monitor  the
          time,  memory,  etc.  used by remote instances on these
          machines. Default value is the empty string.

          Alternatively, one can obtain the same effect  by  set-
          ting  the  (undocumented)  $$$$CCCCAAAADDDDPPPP____TTTTIIIIMMMMEEEE environment vari-
          able; this is equivalent to setting in the ".gcf"  file
          the "time" variable for all remote instances.


     uuuusssseeeerrrr:
          This variable specifies the user login name (or account
          name)  to be used for authentication when connecting to
          the remote machine(s).  Default value is  the  name  of
          the  user  running  the  parent  program  on  the local
          machine.


EEEEXXXXAAAAMMMMPPPPLLLLEEEESSSS OOOOFFFF GGGGCCCCFFFF FFFFIIIILLLLEEEESSSS
     In its simplest form, a grid configuration file  may  simply
     list the remote machines to be used:

        machine1
        machine2
        machine3
        machine4


     It is also possible to write a grid configuration file  with
     several instances on the same machine:

        machine1
           directory=/tmp/instance1
        machine1
           directory=/tmp/instance2
        machine1
           directory=/tmp/instance3


     This is a more complex example involving  all  the  features
     described above:




(C) INRIA            Last change: 2016/12/07                    6






CADP MANUAL PAGES                                      GCF(LOCAL)



        buffer_size = 32768
        cadp = /usr/local/cadp
        connect_timeout = 10
        directory = /home/vasy/distributor
        files = graph-*.bcg
        hash = 4
        port = 8016
        rcp = scp
        rsh = ssh
        user = inria
        machine1.domain.org
        machine2.domain.org
           user = vasy
        machine3.domain.org
           directory = /users/inria/distributor


     Notice that the directive "uuuusssseeeerrrr  ====  vvvvaaaassssyyyy"  applies  to  both
     mmmmaaaacccchhhhiiiinnnneeee1111 and mmmmaaaacccchhhhiiiinnnneeee2222.


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



(C) INRIA            Last change: 2016/12/07                    7






CADP MANUAL PAGES                                      GCF(LOCAL)



SSSSEEEEEEEE AAAALLLLSSSSOOOO
     bbbbccccgggg(LOCAL), ppppbbbbgggg(LOCAL), bbbbccccgggg____mmmmeeeerrrrggggeeee(LOCAL) ddddiiiissssttttrrrriiiibbbbuuuuttttoooorrrr(LOCAL),
     ppppbbbbgggg____ccccpppp(LOCAL), ppppbbbbgggg____iiiinnnnffffoooo(LOCAL), ppppbbbbgggg____mmmmvvvv(LOCAL), ppppbbbbgggg____rrrrmmmm(LOCAL)


     Additional information is available from the CADP  Web  page
     located at http://cadp.inria.fr

     Directives   for   installation   are   given    in    files
     $$$$CCCCAAAADDDDPPPP////IIIINNNNSSSSTTTTAAAALLLLLLLLAAAATTTTIIIIOOOONNNN____****.

     Recent  changes  and  improvements  to  this  software   are
     reported and commented in file $$$$CCCCAAAADDDDPPPP////HHHHIIIISSSSTTTTOOOORRRRYYYY.

BBBBUUUUGGGGSSSS
     Please report bugs to cadp@inria.fr







































(C) INRIA            Last change: 2016/12/07                    8



