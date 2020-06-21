


CADP MANUAL PAGES                                      BES(LOCAL)



NNNNAAAAMMMMEEEE
     bes, BES - text file format for Boolean Equation Systems


DDDDEEEESSSSCCCCRRRRIIIIPPPPTTTTIIIIOOOONNNN
     The acronym _B_E_S stands for _Boolean _Equation _System.  It is a
     mathematical  formalism used to solve verification problems,
     such as model checking and equivalence checking.

     In CADP, BES is also a text file format to represent Boolean
     Equation Systems.


BBBBOOOOOOOOLLLLEEEEAAAANNNN EEEEQQQQUUUUAAAATTTTIIIIOOOONNNN SSSSYYYYSSSSTTTTEEEEMMMMSSSS
     A BES is a non-empty set of equation blocks. Each block is a
     (possibly  empty)  set of equations. Each equation contains,
     on its left-hand side,  a  boolean  variable,  and,  on  its
     right-hand side, a boolean formula built using boolean vari-
     ables (noted _X, _X',  etc.),  constants  (ttttrrrruuuueeee,  ffffaaaallllsssseeee),  and
     binary operators of disjunction (oooorrrr) and conjunction (aaaannnndddd).


     Without loss of generality, it is assumed that each  boolean
     formula is either purely disjunctive (i.e., contains only oooorrrr
     operators), or purely conjunctive (i.e., contains  only  aaaannnndddd
     operators). Formulas containing both operators can be easily
     eliminated by introducing auxiliary variables.  The  formula
     ffffaaaallllsssseeee  (resp.  ttttrrrruuuueeee)  is  considered as a disjunctive (resp.
     conjunctive) formula.


     A boolean variable is said to be defined by an  equation  if
     this variable occurs on the left-hand side of this equation.
     A boolean variable is said to be defined in a block if it is
     defined by an equation of this block.


     Each boolean variable occurring on the right-hand side of an
     equation  in  a BES must be defined by some equation of this
     BES (but not necessarily in the same block).


     Multiple definitions of a variable are  forbidden,  i.e.,  a
     variable is defined by at most one equation.


     Recursive definitions of a variable  are  allowed  (e.g.,  a
     variable occurs both on the left- and right-hand side of the
     same equation).






(C) INRIA            Last change: 2019/01/14                    1






CADP MANUAL PAGES                                      BES(LOCAL)



     A boolean variable defined by  an  equation  is  disjunctive
     (resp. conjunctive) if the boolean formula on the right-hand
     side of this equation is purely disjunctive (resp.  conjunc-
     tive).


     If a variable _X' occurs on the right-hand side of the  equa-
     tion  defining  a  variable  _X, then _X (directly) depends on
     variable _X'.


     If a variable defined in a block _B  depends  on  a  variable
     defined  in  a  block _B', then block _B (directly) depends on
     block _B'.


     A BES is said alternation-free if there are no cyclic depen-
     dencies  between  its blocks (but there can be cyclic depen-
     dencies between variables inside blocks).


     Each equation block has a sign, which is equal to mmmmuuuu  (resp.
     nnnnuuuu)  if  the block denotes the minimal (resp. maximal) fixed
     point of the functional induced  by  the  equations  of  the
     block;  see  [Mat06]  for  a mathematical definition of this
     functional.


BBBBEEEESSSS NNNNOOOOTTTTAAAATTTTIIIIOOOONNNN
     BES can be either represented in binary  form  (in  internal
     memory) using the ccccaaaaeeeessssaaaarrrr____ssssoooollllvvvveeee(LOCAL) library, or in textual
     form  (in  files  with  ....bbbbeeeessss  extension)  using  the  syntax
     described below.


  LLLLEEEEXXXXIIIICCCCAAAALLLL CCCCOOOONNNNVVVVEEEENNNNTTTTIIIIOOOONNNNSSSS
     In a BES file,  lexical  tokens  may  be  separated  by  any
     sequence of spaces, tabulations, carriage returns, newlines,
     vertical tabulations, form feeds (these characters are those
     recognized  by  the  POSIX function iiiissssssssppppaaaacccceeee(((())))), or comments,
     which are enclosed between ((((**** and ****))));  these  sequences  are
     always skipped and ignored.

     BES files  are  case-sensitive:  upper-case  and  lower-case
     letters are considered to be different.


  SSSSYYYYNNNNTTTTAAAAXXXX DDDDEEEEFFFFIIIINNNNIIIITTTTIIIIOOOONNNN
     The textual syntax of BES files is described by the  follow-
     ing  context-free  grammar,  where <<<<eeeemmmmppppttttyyyy>>>> denotes the empty
     sequence  of  symbols  and  <<<<nnnnaaaatttt>>>>  denotes  a   non-negative
     integer:



(C) INRIA            Last change: 2019/01/14                    2






CADP MANUAL PAGES                                      BES(LOCAL)



      <<<<aaaaxxxxiiiioooommmm>>>> ::::::::==== <<<<bbbblllloooocccckkkk----lllliiiisssstttt>>>>

      <<<<bbbblllloooocccckkkk----lllliiiisssstttt>>>> ::::::::==== <<<<bbbblllloooocccckkkk>>>>
                    ||||  <<<<bbbblllloooocccckkkk>>>> <<<<bbbblllloooocccckkkk----lllliiiisssstttt>>>>

      <<<<bbbblllloooocccckkkk>>>> ::::::::==== bbbblllloooocccckkkk <<<<ssssiiiiggggnnnn>>>> <<<<bbbblllloooocccckkkk----iiiiddddffff>>>> <<<<uuuunnnniiiiqqqquuuueeee>>>> <<<<mmmmooooddddeeee>>>> iiiissss
                      <<<<eeeeqqqquuuuaaaattttiiiioooonnnn----lllliiiisssstttt>>>>
                  eeeennnndddd bbbblllloooocccckkkk

      <<<<ssssiiiiggggnnnn>>>> ::::::::==== mmmmuuuu
              ||||  nnnnuuuu

      <<<<bbbblllloooocccckkkk----iiiiddddffff>>>> ::::::::==== BBBB<<<<nnnnaaaatttt>>>>

      <<<<uuuunnnniiiiqqqquuuueeee>>>> ::::::::==== <<<<eeeemmmmppppttttyyyy>>>>
                ||||  uuuunnnniiiiqqqquuuueeee

      <<<<mmmmooooddddeeee>>>> ::::::::==== <<<<eeeemmmmppppttttyyyy>>>>
              ||||  mmmmooooddddeeee <<<<nnnnaaaatttt>>>>

      <<<<eeeeqqqquuuuaaaattttiiiioooonnnn----lllliiiisssstttt>>>> ::::::::==== <<<<eeeeqqqquuuuaaaattttiiiioooonnnn>>>>
                       ||||  <<<<eeeeqqqquuuuaaaattttiiiioooonnnn>>>> <<<<eeeeqqqquuuuaaaattttiiiioooonnnn----lllliiiisssstttt>>>>

      <<<<eeeeqqqquuuuaaaattttiiiioooonnnn>>>> ::::::::==== <<<<llllooooccccaaaallll----vvvvaaaarrrriiiiaaaabbbblllleeee----iiiiddddffff>>>> ==== <<<<ffffoooorrrrmmmmuuuullllaaaa>>>>

      <<<<llllooooccccaaaallll----vvvvaaaarrrriiiiaaaabbbblllleeee----iiiiddddffff>>>> ::::::::==== XXXX<<<<nnnnaaaatttt>>>>

      <<<<gggglllloooobbbbaaaallll----vvvvaaaarrrriiiiaaaabbbblllleeee----iiiiddddffff>>>> ::::::::==== XXXX<<<<nnnnaaaatttt>>>>____<<<<nnnnaaaatttt>>>>

      <<<<ffffoooorrrrmmmmuuuullllaaaa>>>> ::::::::==== <<<<aaaattttoooommmmiiiicccc----ffffoooorrrrmmmm>>>>
                 ||||  <<<<ddddiiiissssjjjjuuuunnnnccccttttiiiivvvveeee----ffffoooorrrrmmmm>>>>
                 ||||  <<<<ccccoooonnnnjjjjuuuunnnnccccttttiiiivvvveeee----ffffoooorrrrmmmm>>>>

      <<<<aaaattttoooommmmiiiicccc----ffffoooorrrrmmmm>>>> ::::::::==== ffffaaaallllsssseeee
                     ||||  ttttrrrruuuueeee
                     ||||  <<<<llllooooccccaaaallll----vvvvaaaarrrriiiiaaaabbbblllleeee----iiiiddddffff>>>>
                     ||||  <<<<gggglllloooobbbbaaaallll----vvvvaaaarrrriiiiaaaabbbblllleeee----iiiiddddffff>>>>

      <<<<ddddiiiissssjjjjuuuunnnnccccttttiiiivvvveeee----ffffoooorrrrmmmm>>>> ::::::::==== <<<<aaaattttoooommmmiiiicccc----ffffoooorrrrmmmm>>>> oooorrrr <<<<aaaattttoooommmmiiiicccc----ffffoooorrrrmmmm>>>>
                          ||||  <<<<aaaattttoooommmmiiiicccc----ffffoooorrrrmmmm>>>> oooorrrr <<<<ddddiiiissssjjjjuuuunnnnccccttttiiiivvvveeee----ffffoooorrrrmmmm>>>>

      <<<<ccccoooonnnnjjjjuuuunnnnccccttttiiiivvvveeee----ffffoooorrrrmmmm>>>> ::::::::==== <<<<aaaattttoooommmmiiiicccc----ffffoooorrrrmmmm>>>> aaaannnndddd <<<<aaaattttoooommmmiiiicccc----ffffoooorrrrmmmm>>>>
                          ||||  <<<<aaaattttoooommmmiiiicccc----ffffoooorrrrmmmm>>>> aaaannnndddd <<<<ccccoooonnnnjjjjuuuunnnnccccttttiiiivvvveeee----ffffoooorrrrmmmm>>>>


  BBBBLLLLOOOOCCCCKKKK IIIIDDDDEEEENNNNTTTTIIIIFFFFIIIIEEEERRRRSSSS
     In a BES file, each block has a  unique  identifier  of  the
     form  BBBB<<<<nnnnaaaatttt>>>>,  where <<<<nnnnaaaatttt>>>> is called the block index. Blocks
     may occur in the file in any order w.r.t. their indexes, and
     these  indexes  are  not necessarily contiguous (i.e., there
     may be ``holes'' in the block numbering). If for some  index
     iiii there is no block BBBBiiii defined in the file, it is considered



(C) INRIA            Last change: 2019/01/14                    3






CADP MANUAL PAGES                                      BES(LOCAL)



     that the block BBBBiiii is empty.


  VVVVAAAARRRRIIIIAAAABBBBLLLLEEEE IIIIDDDDEEEENNNNTTTTIIIIFFFFIIIIEEEERRRRSSSS
     In each equation block, each boolean variable defined by  an
     equation  (i.e., occurring on the left-hand side of an equa-
     tion) has an identifier of the form XXXX<<<<nnnnaaaatttt>>>>, which is  unique
     in  the  block,  where  <<<<nnnnaaaatttt>>>>  is called the variable index.
     Variables may be defined in the block in  any  order  w.r.t.
     their  indexes,  and  these indexes are not necessarily con-
     tiguous (i.e.,  there  may  be  ``holes''  in  the  variable
     numbering).


     Variable identifiers occurring in formulas have two forms:


     -    XXXX<<<<nnnnaaaatttt1111>>>>____<<<<nnnnaaaatttt2222>>>> is a global identifier that denotes  the
          variable  XXXX<<<<nnnnaaaatttt1111>>>>  defined in the block BBBB<<<<nnnnaaaatttt2222>>>>. Global
          identifiers can be used for any variable  occurring  on
          the right-hand side of an equation.


     -    XXXX<<<<nnnnaaaatttt>>>> is a local identifier that denotes the  variable
          XXXX<<<<nnnnaaaatttt>>>> defined in the current block.


  MMMMOOOODDDDEEEE CCCCLLLLAAAAUUUUSSSSEEEE
     One can attach an optional clause mmmmooooddddeeee <<<<nnnnaaaatttt>>>> to  each  equa-
     tion  block.   Such  a  clause  specifies that the variables
     defined in this equation block should be computed using  the
     resolution     algorithm     named     A<<<<nnnnaaaatttt>>>>     of     the
     ccccaaaaeeeessssaaaarrrr____ssssoooollllvvvveeee____1111(LOCAL) library. The value <<<<nnnnaaaatttt>>>> is called the
     resolution  mode of the block. If the mmmmooooddddeeee clause is absent,
     the resolution mode is set to 0 by default, meaning that the
     resolution algorithm A0 will be used.


  UUUUNNNNIIIIQQQQUUUUEEEE CCCCLLLLAAAAUUUUSSSSEEEE
     Since the ccccaaaaeeeessssaaaarrrr____ssssoooollllvvvveeee____1111(LOCAL)  library  does  not  operate
     globally,  but  locally, to compute a given variable defined
     in a given equation block, the same equation  block  may  be
     solved  several  times,  each time for computing a different
     variable of this block.  Of course, caching is used to avoid
     recomputing variables already calculated.


     It is however possible to help the solver  by  attaching  an
     optional  clause  uuuunnnniiiiqqqquuuueeee to an equation block. Such a clause
     indicates that the block will be solved only  once,  meaning
     that  the  value  of  a single variable defined in the block
     will be computed. This increases the memory  performance  of



(C) INRIA            Last change: 2019/01/14                    4






CADP MANUAL PAGES                                      BES(LOCAL)



     certain  resolution algorithms. Any attempt at solving twice
     an equation block having the uuuunnnniiiiqqqquuuueeee clause  will  trigger  a
     run-time  error. By default, if the uuuunnnniiiiqqqquuuueeee clause it absent,
     one assumes that several variables  of  the  equation  block
     will need to be computed.


BBBBEEEESSSS FFFFIIIILLLLEEEE EEEEXXXXAAAAMMMMPPPPLLLLEEEE
     An example of a boolean equation system containing two equa-
     tion blocks is shown below:
        bbbblllloooocccckkkk nnnnuuuu BBBB0000 iiiissss
            XXXX0000 ==== XXXX1111 aaaannnndddd XXXX2222
            XXXX1111 ==== XXXX0000 oooorrrr XXXX1111 oooorrrr XXXX2222
            XXXX2222 ==== XXXX0000____1111 aaaannnndddd XXXX3333
            XXXX3333 ==== XXXX1111 oooorrrr XXXX4444
            XXXX4444 ==== ttttrrrruuuueeee
         eeeennnndddd bbbblllloooocccckkkk

         bbbblllloooocccckkkk mmmmuuuu BBBB1111 iiiissss
            XXXX0000 ==== XXXX1111 oooorrrr XXXX2222
            XXXX1111 ==== ffffaaaallllsssseeee
            XXXX2222 ==== XXXX2222 aaaannnndddd XXXX3333
            XXXX3333 ==== XXXX0000 oooorrrr XXXX1111 oooorrrr XXXX3333
         eeeennnndddd bbbblllloooocccckkkk


     The global variable XXXX0000____1111, which is present on the right-hand
     side  of  the  equation  defining  variable  XXXX2222 in block BBBB0000,
     references the variable XXXX0000 defined in block BBBB1111.


HHHHOOOOWWWW TTTTOOOO CCCCRRRREEEEAAAATTTTEEEE AAAA BBBBEEEESSSS FFFFIIIILLLLEEEE
     One can produce a BES file manually, using a text editor.


     BES files can also be generated using option  ----ddddiiiiaaaagggg  of  the
     tool  bbbbeeeessss____ssssoooollllvvvveeee(LOCAL),  or  using  option ----bbbbeeeessss of the tools
     bbbbeeeessss____ssssoooollllvvvveeee(LOCAL), bbbbiiiissssiiiimmmmuuuullllaaaattttoooorrrr(LOCAL), eeeevvvvaaaalllluuuuaaaattttoooorrrr3333(LOCAL), and
     eeeevvvvaaaalllluuuuaaaattttoooorrrr4444(LOCAL).


HHHHOOOOWWWW TTTTOOOO RRRREEEEAAAADDDD AAAA BBBBEEEESSSS FFFFIIIILLLLEEEE
     BES   files   can   be   read   and   resolved   using   the
     bbbbeeeessss____ssssoooollllvvvveeee(LOCAL) tool.  They can also be loaded in memory in
     binary internal form using  the  CCCCAAAAEEEESSSSAAAARRRR____RRRREEEEAAAADDDD____SSSSOOOOLLLLVVVVEEEE____1111(((())))  pro-
     cedure of the ccccaaaaeeeessssaaaarrrr____ssssoooollllvvvveeee(LOCAL) library.


BBBBIIIIBBBBLLLLIIIIOOOOGGGGRRRRAAAAPPPPHHHHYYYY
     [Mat06] R. Mateescu.  "CAESAR_SOLVE: A Generic  Library  for
     On-the-Fly  Resolution  of Alternation-Free Boolean Equation
     Systems."  Springer International Journal on Software  Tools



(C) INRIA            Last change: 2019/01/14                    5






CADP MANUAL PAGES                                      BES(LOCAL)



     for Technology Transfer (STTT), v. 8, no. 1, p. 37-56, 2006.
     Full version available as  INRIA  Research  Report  RR-5948.
     Available  from  http://cadp.inria.fr/publications/Mateescu-
     06-a.html


SSSSEEEEEEEE AAAALLLLSSSSOOOO
     bbbbeeeessss____ssssoooollllvvvveeee(LOCAL), bbbbiiiissssiiiimmmmuuuullllaaaattttoooorrrr(LOCAL), ccccaaaaeeeessssaaaarrrr____ssssoooollllvvvveeee____1111(LOCAL),
     eeeevvvvaaaalllluuuuaaaattttoooorrrr(LOCAL),    eeeevvvvaaaalllluuuuaaaattttoooorrrr3333(LOCAL),   eeeevvvvaaaalllluuuuaaaattttoooorrrr4444(LOCAL),
     rrrrbbbbcccc(LOCAL), ssssccccrrrruuuuttttaaaattttoooorrrr(LOCAL)


     Additional information is available from the CADP  Web  page
     located at http://cadp.inria.fr

     Directives   for   installation   are   given    in    files
     $$$$CCCCAAAADDDDPPPP////IIIINNNNSSSSTTTTAAAALLLLLLLLAAAATTTTIIIIOOOONNNN____****....


     Recent  changes  and  improvements  to  this  software   are
     reported and commented in file $$$$CCCCAAAADDDDPPPP////HHHHIIIISSSSTTTTOOOORRRRYYYY....


BBBBUUUUGGGGSSSS
     Please report any bug to cadp@inria.fr






























(C) INRIA            Last change: 2019/01/14                    6



