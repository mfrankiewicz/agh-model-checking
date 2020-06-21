


CADP MANUAL PAGES                                      AUT(LOCAL)



NNNNAAAAMMMMEEEE
     aut, AUT - simple file format for labelled  transition  sys-
     tems


DDDDEEEESSSSCCCCRRRRIIIIPPPPTTTTIIIIOOOONNNN
     The AUT format (where _A_U_T stands for _A_U_T_o_m_a_t_o_n), also called
     the ALDEBARAN format, is a simple file format for represent-
     ing labelled transition systems.


     The AUT format has been present in the  CADP  toolbox  since
     its origins (see the HISTORY section below for details about
     the chronology of the AUT format).


     Because of its simplicity and because it is human  readable,
     this  format  has  enjoyed some popularity in academia among
     developers of verification and testing tools.


     However, the AUT format suffers from three drawbacks:

     -    Because it is a text format, it is not  compact  enough
          to  efficiently  store  very  large transitions systems
          (both in terms of disk space and access time).

     -    Because the AUT format definition was kept as simple as
          possible,   the  various  implementations  would  often
          diverge, for instance, regarding the maximal length for
          label  strings,  the  places  where  white  spaces  are
          allowed, etc.

     -    There was a lot of redundant work across  these  imple-
          mentations,  as  each developer would have to implement
          the same functionalities, e.g.,  to  store  labels  and
          transitions in main memory.


     To address these issues (and others), the CADP  toolbox  has
     been,  since  1993, equipped with an alternative file format
     named BCG (see the bbbbccccgggg(LOCAL) manual page for details). Pro-
     gressively,  the BCG format has supplanted the AUT format in
     CADP, and most of the CADP tools nowadays that can  read  or
     write  the  AUT format do it by internal translation from/to
     BCG.


     Thus, it is advised to use the BCG format  rather  than  the
     AUT  format when developing new tools. The only exception to
     this general principle concerns those tools developed  using
     a programming language that can not bridge with the BCG code



(C) INRIA            Last change: 2016/04/02                    1






CADP MANUAL PAGES                                      AUT(LOCAL)



     libraries provided by the CADP toolbox.


SSSSPPPPEEEECCCCIIIIFFFFIIIICCCCAAAATTTTIIIIOOOONNNN OOOOFFFF TTTTHHHHEEEE AAAAUUUUTTTT FFFFOOOORRRRMMMMAAAATTTT ((((2222000011114444 VVVVEEEERRRRSSSSIIIIOOOONNNN))))
     Labelled transition systems encoded in the  AUT  format  are
     stored in files having the ....aaaauuuutttt suffix.


     In an AUT file, each  state  is  represented  by  a  natural
     (i.e., unsigned) number.


     Blanks (i.e., white spaces, tabulations,  etc.)  may  appear
     everywhere  between lexical tokens (i.e., keywords, numbers,
     strings, commas, parentheses, etc.), and also at the  begin-
     ning  or  end  of each line.  Blanks are not significant and
     can be discarded, except inside quoted labels.


     Line breaks are significant. Each line should be  terminated
     with a line-feed (LF) character, with the possible exception
     of the last line of the file.  To ensure compatibility  with
     Windows,  each  line-feed character may be preceded (or not)
     by a carriage-return (CR) character.


     The numbers of states and transitions  should  be  at  least
     32-bit  wide, which enables 4 billions of states and transi-
     tions. On 64-bit machines, wider numbers can  be  used,  but
     the  size  of  AUT files is likely to become prohibitive for
     large models (in such case, the BCG format is the option  of
     choice).


     In the AUT format, only 7-bit ASCII characters are accepted.
     This  is  currently  found to be sufficient for the study of
     concurrent systems.


     The first line of an AUT file has the following syntax:
        des (<initial-state>, <number-of-transitions>, <number-of-states>)
     The "ddddeeeessss" keywords stands for "descriptor". The  <<<<nnnnuuuummmmbbbbeeeerrrr----ooooffff----
     ssssttttaaaatttteeeessss>>>>  must  be  greater  or  equal to 1, because there is
     always at least one state, the initial state.  State numbers
     range  between  0 and <<<<nnnnuuuummmmbbbbeeeerrrr----ooooffff----ssssttttaaaatttteeeessss>>>> ---- 1111.  The <<<<iiiinnnniiiittttiiiiaaaallll----
     ssssttttaaaatttteeee>>>> is always equal to 0.


     The remainder of the AUT file consists of one line per tran-
     sition,  in  an arbitrary order. Each remaining line has the
     following syntax:
        (<from-state>, <label>, <to-state>)



(C) INRIA            Last change: 2016/04/02                    2






CADP MANUAL PAGES                                      AUT(LOCAL)



     where <<<<ffffrrrroooommmm----ssssttttaaaatttteeee>>>> and <<<<ttttoooo----ssssttttaaaatttteeee>>>>  are  state  numbers,  and
     where <label> can take two possible forms:


     -    <<<<uuuunnnnqqqquuuuooootttteeeedddd----llllaaaabbbbeeeellll>>>> consists of a character string  start-
          ing  with  a letter, and followed by zero, one, or many
          letters, digits, or underscore characters.   To  ensure
          backward  compatibility  with the version of AUT format
          used by the ttttggggvvvv(LOCAL) tool, the character string  con-
          sisting of a single '****' character is also accepted as a
          valid unquoted label.


     -    <<<<qqqquuuuooootttteeeedddd----llllaaaabbbbeeeellll>>>> consists of a character string  starting
          with  a  double  quote  and ending with a double quote.
          Between these two double quotes, there can be zero, one
          or  many  printable  characters; the meaning of "print-
          able" is given by the  POSIX  isprint()  function  with
          locale "C" (namely, ASCII characters with decimal codes
          in the range from 32  to  126,  bounds  included).   No
          other  assumption  should  be made about the characters
          present between these two double quotes. In particular,
          the  double  quote character itself may be present, and
          may not necessarily be "escaped"  in  some  way  (e.g.,
          preceded by a backslash, as in C).


     Any conformant implementation of the AUT  format  should  at
     least  handle  labels that are 5000-character long; handling
     labels of unbounded length is obviously better.


     An unquoted label (e.g., PPPPUUUUTTTT____1111) can also  be  written  as  a
     quoted  label  (e.g., """"PPPPUUUUTTTT____1111"""") without changing its meaning:
     both labels should be considered to be identical. This  rule
     also applies to the '****' label.


     The non-observable label (also called  invisible  label,  or
     hidden label, and usually noted "tau" in concurrency theory)
     is noted iiii in the AUT format, following a convention set  by
     the  ISO  International  Standard  8807  "LOTOS".  This same
     label can also be noted """"iiii"""", but the  unquoted  notation  is
     better  for  compactness.  Notice  that  there  is no way to
     express an observable label that would be noted iiii;  this  is
     not  a problem for languages such as LOTOS and LNT, in which
     iiii is a reserved keyword or a reserved gate identifier.


     By default, labels are  case  sensitive,  meaning  that  two
     labels  such  as  """"ppppuuuutttt"""" and """"PPPPUUUUTTTT"""" should be considered to be
     different.



(C) INRIA            Last change: 2016/04/02                    3






CADP MANUAL PAGES                                      AUT(LOCAL)



     If each label can semantically be seen as a tuple consisting
     of a communication port (or gate, channel, etc.) followed by
     zero, one, or many typed  values,  then  it  is  recommended
     (although  not  mandatory)  to write labels according to the
     syntax conventions defined in the LABEL PARSING  section  of
     the  bbbbccccgggg____wwwwrrrriiiitttteeee(LOCAL) manual page, and to enable label pars-
     ing when processing the AUT file using the CADP tools.


     When label parsing is enabled, two labels may be  considered
     to  be  the same even if they are not character-wise identi-
     cal. For instance, label """"PPPPUUUUTTTT!!!!ffffaaaallllsssseeee!!!!''''\\\\xxxx22223333''''"""" will  be  turned
     into  """"PPPPUUUUTTTT  !!!!FFFFAAAALLLLSSSSEEEE  !!!!''''####''''""""  by label parsing, and both labels
     will be considered to be the same.


EEEEXXXXAAAAMMMMPPPPLLLLEEEE OOOOFFFF AAAANNNN AAAAUUUUTTTT FFFFIIIILLLLEEEE
     This is an example of a valid AUT file:

        des (0, 5, 4)
        (0, PUT_6, 1)
        (0, "GET !true !7 !CONS (A, CONS (B, NIL))", 2)
        (1, i, 3)
        (2, "SEND !"hello" !"world"", 3)
        (3, "DUMP ... " ... \" ...", 0)

     The two latter transitions  illustrate  that  no  particular
     assumption should be made about occurrences of double quotes
     in labels: neither must they be systematically preceded by a
     backslash, nor must they occur an even number of times, etc.


HHHHOOOOWWWW TTTTOOOO CCCCRRRREEEEAAAATTTTEEEE AAAANNNN AAAAUUUUTTTT FFFFIIIILLLLEEEE
     At present, there are two CADP tools  that  directly  create
     AUT  files:   ccccaaaaeeeessssaaaarrrr(LOCAL) when invoked with its ----aaaallllddddeeeebbbbaaaarrrraaaannnn
     option, and bbbbccccgggg____iiiioooo(LOCAL).


     The easiest way to produce an AUT file is to first create  a
     BCG  file using the bbbbccccgggg____wwwwrrrriiiitttteeee(LOCAL) application programming
     interface, and then invoke the bbbbccccgggg____iiiioooo(LOCAL) tool to convert
     this BCG file into an AUT file.


     Otherwise, it is easy to produce AUT files directly by writ-
     ing  lines  to a file.  The only issue may be to produce the
     descriptor line if the total numbers of states and/or  tran-
     sitions  are not already known at the moment the AUT file is
     created. To solve this issue, ccccaaaaeeeessssaaaarrrr(LOCAL) writes  a  first
     line of the following form:
        des (0, ?, ?)_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _
     where the _'s denote a sufficient number  of  white  spaces,



(C) INRIA            Last change: 2016/04/02                    4






CADP MANUAL PAGES                                      AUT(LOCAL)



     and  then  proceeds  normally  writing  the subsequent lines
     corresponding to the transitions. When all transitions  have
     been  written,  the numbers of states and transitions should
     be known. One can then skip back to  the  beginning  of  the
     file, e.g., using the ftell() POSIX primitive, and overwrite
     the first line with the actual numbers.


     When an AUT file is generated directly, its correctness  can
     be  checked  by converting it to a BCG file, then back to an
     AUT file using the bbbbccccgggg____iiiioooo(LOCAL) tool.  If  the  former  AUT
     file  is  correct,  the  conversion should succeed. If label
     parsing is disabled during the conversion,  both  AUT  files
     should be character-wise identical (with the possible excep-
     tion of blanks that might have  been  inserted   or  removed
     outside labels). If label parsing is enabled, the conversion
     will additionally parse the contents of  each  label,  check
     its  correctness,  and  possibly turn some values into their
     normal form.


HHHHOOOOWWWW TTTTOOOO RRRREEEEAAAADDDD AAAANNNN AAAAUUUUTTTT FFFFIIIILLLLEEEE
     At present, there is one single  CADP  tool,  bbbbccccgggg____iiiioooo(LOCAL),
     that  directly reads AUT files. This is a design decision to
     stop maintaining multiple  parsers.   bbbbccccgggg____iiiioooo(LOCAL)  is  the
     reference  parser  for  the  AUT format. It has command-line
     options to enable or disable label parsing.


     The easiest way to read an AUT file is to first  convert  it
     to  BCG  using  the bbbbccccgggg____iiiioooo(LOCAL) tool, and then opening the
     resulting BCG file  using  the  bbbbccccgggg____rrrreeeeaaaadddd(LOCAL)  application
     programming  interface,  which  provides primitives and data
     structures for loading and accessing the labelled transition
     system in memory.


     Otherwise, it is always possible to write a new  parser  for
     the  AUT format.  The simplest approach is to write it manu-
     ally. There is yet an involved point: when  reading  an  AUT
     file, quoted labels should not be parsed from left to right,
     as it is not possible, upon occurrence  of  a  double  quote
     character,  to  immediately  decide  whether  this character
     marks the end of the label, or if it is just a double  quote
     present  in  the middle of the label (technically, this is a
     shift-reduce conflict in the grammar).


     The recommended way of parsing quoted labels is to read  the
     entire  transition line in a buffer and search for the left-
     most and rightmost double  quotes,  e.g.,  using  the  POSIX
     functions  strchr()  and  strrchr(). The quoted label is the



(C) INRIA            Last change: 2016/04/02                    5






CADP MANUAL PAGES                                      AUT(LOCAL)



     sub-string of characters located between  these  two  double
     quotes.


     As an alternative to manual writing, a parser generator  may
     be  used,  but  one  should keep in mind that the AUT format
     cannot be simply parsed from left to  right  because  double
     quotes  are  allowed inside labels. Using a parser generator
     will only work if the generated parser can perform lookahead
     and  take  decisions  based  upon  the right-hand context to
     resolve shift-reduce conflicts. If so, the double quote that
     terminates  a label can be characterized as any double quote
     that is followed by no other double quote before the end  of
     line.


HHHHIIIISSSSTTTTOOOORRRRYYYY OOOOFFFF TTTTHHHHEEEE AAAAUUUUTTTT FFFFOOOORRRRMMMMAAAATTTT
     An early version of the AUT format was defined in  1987,  as
     part  of the VENUS tool [Sor87] for the verification of com-
     municating systems. Because this tool was written in Prolog,
     the  file format for describing automata was naturally a set
     of Prolog clauses. For instance, the transition relation  of
     a given automaton _A was described as a set of clauses of the
     form:  _A (_s_t_a_t_e_1, _l_a_b_e_l, _s_t_a_t_e_2).


     The actual AUT format was defined in 1988, as  part  of  the
     ALDEBARAN tool [Fer88] for the verification of communicating
     processes. The Prolog-clause style of the VENUS  format  was
     kept  (for instance, on the first line), sometimes with sim-
     plifications (for instance, the automaton name _A was dropped
     from each transition clause).


     In 1989, Hubert Garavel  extended  the  syntax  with  labels
     between  double  quotes,  so  as  to provide support for the
     labelled transition  systems  generated  from  value-passing
     LOTOS specifications.


     The AUT format remained unchanged until September 2014, when
     Hubert Garavel introduced the explicit possibility of having
     double quotes in labels, so as to support concurrent  model-
     ling  languages  with rich data types, in particular the LNT
     and PseuCo languages that can pass character  string  values
     across  communication channels. The specification of the AUT
     format was revised and made more precise.


BBBBIIIIBBBBLLLLIIIIOOOOGGGGRRRRAAAAPPPPHHHHYYYY
     [Sor87] Amelia Soriano Montes. Venus: un outil d'aide  a  la
     verification  des  systemes communicants. These de doctorat,



(C) INRIA            Last change: 2016/04/02                    6






CADP MANUAL PAGES                                      AUT(LOCAL)



     Institut National Polytechnique de Grenoble, Jan. 1987.


     [Fer88] Jean-Claude Fernandez. Aldebaran  :  un  systeme  de
     verification  par reduction de processus communicants. These
     de doctorat, Universite Joseph  Fourier  (Grenoble  I),  May
     1988.


SSSSEEEEEEEE AAAALLLLSSSSOOOO
     aaaallllddddeeeebbbbaaaarrrraaaannnn(LOCAL),         bbbbccccgggg(LOCAL),         bbbbccccgggg____iiiioooo(LOCAL),
     bbbbccccgggg____wwwwrrrriiiitttteeee(LOCAL).


     Additional information is available from the CADP  Web  page
     located at http://cadp.inria.fr

     Directives   for   installation   are   given    in    files
     $$$$CCCCAAAADDDDPPPP////IIIINNNNSSSSTTTTAAAALLLLLLLLAAAATTTTIIIIOOOONNNN____****.

     Recent  changes  and  improvements  to  this  software   are
     reported and commented in file $$$$CCCCAAAADDDDPPPP////HHHHIIIISSSSTTTTOOOORRRRYYYY.

BBBBUUUUGGGGSSSS
     Please report bugs to cadp@inria.fr






























(C) INRIA            Last change: 2016/04/02                    7



