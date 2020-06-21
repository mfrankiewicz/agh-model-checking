


CADP MANUAL PAGES                                    LOTOS(LOCAL)



NNNNAAAAMMMMEEEE
     lotos, LOTOS - Language of Temporal Ordering Specification


DDDDEEEESSSSCCCCRRRRIIIIPPPPTTTTIIIIOOOONNNN
     LOTOS [BB88] is a formal specification language to  describe
     communication protocols and distributed systems. It has been
     standardized by ISO/IEC in 1989 [ISO89]. The design of LOTOS
     was  motivated  by  the  need  for  a  language  with a high
     abstraction level and strong mathematical bases  that  would
     allow  complex systems to be described precisely and unambi-
     guously, then analyzed using  formal  methods  supported  by
     appropriate  software  tools.  LOTOS  features  two  clearly
     separated parts:


     -    The _d_a_t_a _p_a_r_t  of  LOTOS,  intended  to  describe  data
          structures,  is  based  on  the theory of abstract data
          types  and  algebraic  specifications  (especially  the
          ActOne  language  defined  by  Ehrig and Mahr). In this
          approach, data structures are described by LOTOS _s_o_r_t_s,
          which  represent  value  domains, and LOTOS _o_p_e_r_a_t_i_o_n_s,
          which  are  mathematical  functions  defined  on  these
          domains.  The meaning of operations is defined by alge-
          braic _e_q_u_a_t_i_o_n_s. Value expressions  are  strongly-typed
          algebraic  terms  built  from variables and operations.
          Sorts, operations, and equations are grouped in modules
          called  _t_y_p_e_s,  which  can  be  combined together using
          importation  (with  multiple  inheritance),   renaming,
          parametrization,   and  actualization.  The  underlying
          semantics is that of initial algebras.


     -    The _c_o_n_t_r_o_l _p_a_r_t of LOTOS  is  meant  to  describe  the
          behaviour  of  concurrent processes that execute simul-
          taneously, synchronize, and communicate using  message-
          passing rendezvous. LOTOS is based on the process alge-
          bra approach for concurrency,  and  combines  the  best
          features  of  Milner's CCS and Hoare's CSP process cal-
          culi. It relies on a  small  set  of  basic  operators,
          which  express  primitive  concepts  such as sequential
          composition, non-deterministic choice, guard,  parallel
          composition,  rendezvous, etc. These operators are used
          to build _b_e_h_a_v_i_o_u_r  _e_x_p_r_e_s_s_i_o_n_s,  which  are  algebraic
          terms  that  describe  the behaviour of concurrent sys-
          tems, complex behaviours being  obtained  by  combining
          simpler  ones.  The  communication ports for rendezvous
          are called _g_a_t_e_s. Any behaviour expression can be given
          a  name  and  reused several times by enclosing it in a
          _p_r_o_c_e_s_s definition.





(C) INRIA            Last change: 2020/02/11                    1






CADP MANUAL PAGES                                    LOTOS(LOCAL)



     A comprehensive list of documents about the  LOTOS  language
     is available from http://cadp.inria.fr/tutorial


     The remainder of  this  page  is  devoted  to  CADP-specific
     information  about  LOTOS. It gathers many technical details
     that, so far, were only known by CADP experts.


     Note: LOTOS is a powerful yet involved language. Today,  new
     users  who  do  not  know  LOTOS  already may prefer instead
     learning LNT  (LOTOS  New  Technology),  a  modern  language
     designed to be a replacement for LOTOS, simpler to learn but
     equally  expressive.  The  present  manual  can  yet  be  of
     interest to LNT users as well, since LNT is currently imple-
     mented by translation to LOTOS.


CCCCAAAADDDDPPPP TTTTOOOOOOOOLLLLSSSS FFFFOOOORRRR LLLLOOOOTTTTOOOOSSSS
     The CADP toolbox provides four main tools  to  handle  LOTOS
     specifications:


     -    ccccaaaaeeeessssaaaarrrr....aaaaddddtttt(LOCAL) is a compiler for the  data  part  of
          LOTOS. It translates LOTOS to C by generating an imple-
          mentation for all the sorts and operations defined in a
          LOTOS specification.


     -    ccccaaaaeeeessssaaaarrrr(LOCAL) is a compiler for  the  control  part  of
          LOTOS. It translates LOTOS to Petri nets, and then to C
          code that can be used for, at  least,  three  different
          purposes:   (i)   exhaustively   explore  all  possible
          behaviours  and  generate  the  corresponding  Labelled
          Transition  System  encoded in aaaauuuutttt(LOCAL) or bbbbccccgggg(LOCAL)
          format; (ii) explore possible behaviours on the fly  by
          interfacing  with  the  OPEN/CAESAR  framework of CADP;
          (iii) connect the LOTOS specification to  its  environ-
          ment  by  interfacing with the EXEC/CAESAR framework of
          CADP, e.g., to pilot an external device using the LOTOS
          specification as a controller.


     -    ccccaaaaeeeessssaaaarrrr....iiiinnnnddddeeeennnntttt(LOCAL) is a pretty-printer that automati-
          cally reformats and indents LOTOS specifications.


     -    lllloooottttoooossss....ooooppppeeeennnn(LOCAL) is a tool  that  allows  running  the
          OPEN/CAESAR  application  programs  on LOTOS specifica-
          tions. This  tool  is  actually  a  shell  script  that
          invokes ccccaaaaeeeessssaaaarrrr....aaaaddddtttt and ccccaaaaeeeessssaaaarrrr.




(C) INRIA            Last change: 2020/02/11                    2






CADP MANUAL PAGES                                    LOTOS(LOCAL)



     For historical reasons, and because the data part  and  con-
     trol  part of LOTOS are largely orthogonal, they are handled
     separately by the ccccaaaaeeeessssaaaarrrr....aaaaddddtttt and ccccaaaaeeeessssaaaarrrr  compilers,  respec-
     tively.  The  landscape  is  however not so simple, as close
     connections exist between both compilers:


     -    Both compilers share a common front-end, which performs
          lexical and syntactic analyses, abstract tree construc-
          tion, and static  semantics  checks  (e.g.,  identifier
          binding,  type  checking,  etc.).  After  these common,
          preliminary steps, each  compiler  performs  additional
          checks for either the data or control part.


     -    The ccccaaaaeeeessssaaaarrrr compiler requires a _c_o_n_c_r_e_t_e  implementation
          in  C  for  each _a_b_s_t_r_a_c_t sort and operation defined in
          the LOTOS specification. Such an implementation can  be
          automatically generated using ccccaaaaeeeessssaaaarrrr....aaaaddddtttt or be manually
          written by the user.

          In most cases, it is advised to let ccccaaaaeeeessssaaaarrrr....aaaaddddtttt  produce
          the C code automatically, as the generated code will be
          both correct and, in most cases, highly efficient.  For
          the  most common classes of types (Booleans, enumerated
          types, bounded integers, records, unions, lists, trees,
          bit  vectors,  etc.),  ccccaaaaeeeessssaaaarrrr....aaaaddddtttt will generate optimal
          code (according to model checking demands, i.e., memory
          space first, then speed).

          On the other hand, manual writing gives full control on
          all  implementation  details  and may thus be preferred
          for particular data structures, such as  floating-point
          numbers,  character  strings, matrices, variable-length
          data with special encodings, etc. Manual  writing  also
          allows  to reuse efficient C or C++ code libraries that
          already exist and can be imported in a LOTOS specifica-
          tion just by redeclaring their interface in the form of
          LOTOS abstract data types. Manual writing  also  allows
          to  define  functions that can perform "short-circuits"
          when evaluating their arguments (see the section  below
          on CALL-BY-NEED EVALUATION).

          Both approaches can be combined, in the sense that cer-
          tain  LOTOS  sorts and/or operations can be declared as
          _e_x_t_e_r_n_a_l by the user and implemented manually; in  such
          case,  ccccaaaaeeeessssaaaarrrr....aaaaddddtttt  will  only  generate  C code for the
          non-external sorts and/or operations, and  will  import
          the  C  code  implementing  those external sorts and/or
          operations.

          In any case, manual  writing  requires  great  care  in



(C) INRIA            Last change: 2020/02/11                    3






CADP MANUAL PAGES                                    LOTOS(LOCAL)



          order  to  produce correct implementations. There exist
          naming and interfacing  conventions  (described  below)
          that   must   be  strictly  respected.  Certain  macro-
          definitions must be provided  by  the  user  to  inform
          ccccaaaaeeeessssaaaarrrr....aaaaddddtttt  about key properties of the external sorts.
          Moreover, manually-written C functions are not  allowed
          to have side effects, except in a very limited way (see
          the section below on SIDE EFFECTS for  details).  Exam-
          ples  of manually-written C code for the standard LOTOS
          types declared in the "$$$$CCCCAAAADDDDPPPP////lllliiiibbbb" directory (see  files
          "XXXX____****....lllliiiibbbb")  can  be found in the "$$$$CCCCAAAADDDDPPPP////iiiinnnnccccllll" directory
          (see files "XXXX____****....hhhh" and "aaaaddddtttt____****....hhhh").


     -    Yet, the C  code  generated  by  ccccaaaaeeeessssaaaarrrr....aaaaddddtttt  for  LOTOS
          specifications can also be used in a standalone manner,
          independently  from  the  ccccaaaaeeeessssaaaarrrr  compiler.   In   this
          approach, LOTOS is only used as a higher-level language
          for  describing  data  structures  with  their  related
          operations,  from which ccccaaaaeeeessssaaaarrrr....aaaaddddtttt produces lower-level
          C code.

          This idea has been applied in two large  projects:  the
          development  of  ccccaaaaeeeessssaaaarrrr....aaaaddddtttt  (version  4.0 and higher),
          most of which is written in LOTOS data types and  which
          bootstraps   itself,   and   the   development  of  the
          xxxxttttllll(LOCAL) compiler, the largest part of which consists
          of LOTOS code too.


     -    Note that both ccccaaaaeeeessssaaaarrrr and ccccaaaaeeeessssaaaarrrr....aaaaddddtttt take great care to
          generate C code that does not cause warnings when given
          to C compilers with demanding compiling options. So, if
          warnings  are  emitted while compiling some C code gen-
          erated by the CADP tools, it is likely that these warn-
          ings  have  their  origin  in  the  LOTOS specification
          itself (e.g., unused  operations  or  unused  operation
          parameters)  or  in  the C code manually written by the
          user.


TTTTOOOOOOOOLLLLSSSS GGGGEEEENNNNEEEERRRRAAAATTTTIIIINNNNGGGG LLLLOOOOTTTTOOOOSSSS CCCCOOOODDDDEEEE
     The CADP toolbox provides two tools that produce LOTOS code:


     -    ffffsssspppp2222lllloooottttoooossss(LOCAL) takes specifications written in  Magee
          and  Kramer's FSP (Finite State Processes) language and
          translates them into LOTOS.


     -    llllnnnntttt2222lllloooottttoooossss(LOCAL) takes specifications  written  in  LNT
          (LOTOS New Technology) and translates them into LOTOS.



(C) INRIA            Last change: 2020/02/11                    4






CADP MANUAL PAGES                                    LOTOS(LOCAL)



     Other tools have been developed, but not distributed as part
     of CADP:


     -    cccchhhhpppp2222lllloooottttoooossss takes specifications written in Martin's  CHP
          (Communicating  Hardware  Processes) and translate them
          into  LOTOS.  See   http://cadp.inria.fr/software/05-b-
          chp2lotos.html for details.


     -    ffffllllaaaacccc takes models written in the FIACRE  formalism  and
          translates       them       into       LOTOS.       See
          http://cadp.inria.fr/software/11-d-flac.html        for
          details.


     Note: Following the above remark that LOTOS is  an  involved
     language  for humans, it is involved for translators too. In
     practice, it is much easier to generate LNT code rather than
     LOTOS  code,  and  let  the llllnnnntttt2222lllloooottttoooossss(LOCAL) translator cope
     with the intricacies of generating correct LOTOS code.


RRRREEEESSSSTTTTRRRRIIIICCCCTTTTIIIIOOOONNNNSSSS OOOONNNN TTTTHHHHEEEE DDDDAAAATTTTAAAA PPPPAAAARRRRTTTT OOOOFFFF LLLLOOOOTTTTOOOOSSSS
     Abstract data types, as they exist in LOTOS,  are  a  rather
     unconstrained  formalism  that is difficult to execute effi-
     ciently and from which it is difficult to  generate  execut-
     able  code.  To handle algebraic specifications, there exist
     techniques based on rewriting or  symbolic  evaluation,  but
     they  are  often  slow and memory-intensive. This is a major
     problem in a  model-checking  context,  because  state-space
     exploration is especially demanding in terms of performance.

     Therefore, in order to enable the use  of  ccccaaaaeeeessssaaaarrrr....aaaaddddtttt(LOCAL)
     for  translating  LOTOS  abstract  data  types  into  C code
     automatically, the following  restrictions  have  been  set,
     which  turn algebraic specifications into (more operational)
     term-rewrite  systems  with  priorities  (see  [Gar89c]  and
     [GT93] for details).

     These restrictions also introduce a suitable  discipline  in
     LOTOS,  which,  even  if it is a strongly-typed language and
     owns a system of  modules,  remains  poorly  structured  and
     hardly  readable,  as  sorts,  operations, and equations may
     appear in arbitrary order, with no guarantee that operations
     related  to  the  same sort or equations related to the same
     operation will be gathered in the same module.


  DDDDIIIISSSSTTTTIIIINNNNCCCCTTTTIIIIOOOONNNN BBBBEEEETTTTWWWWEEEEEEEENNNN CCCCOOOONNNNSSSSTTTTRRRRUUUUCCCCTTTTOOOORRRRSSSS AAAANNNNDDDD NNNNOOOONNNN----CCCCOOOONNNNSSSSTTTTRRRRUUUUCCCCTTTTOOOORRRRSSSS
     The user must split LOTOS operations into two  classes:  the
     _c_o_n_s_t_r_u_c_t_o_r_s,  which  are primitive operations, and the _n_o_n-



(C) INRIA            Last change: 2020/02/11                    5






CADP MANUAL PAGES                                    LOTOS(LOCAL)



     _c_o_n_s_t_r_u_c_t_o_r_s, which  are  non-primitive  operations  defined
     using equations. To this aim, the user must explicitly indi-
     cate which operations are constructors by attaching  a  spe-
     cial  comment to them (see below the section on SPECIAL COM-
     MENTS FOR OPERATIONS).


     The distinction enables LOTOS  abstract  data  types  to  be
     efficiently  implemented. However, this distinction does not
     exist in the standard definition of the language [ISO89], so
     that new constraints on the syntax and static semantics must
     be added.


  CCCCOOOONNNNSSSSTTTTRRRRAAAAIIIINNNNTTTTSSSS OOOONNNN EEEEQQQQUUUUAAAATTTTIIIIOOOONNNNSSSS
     To be accepted by ccccaaaaeeeessssaaaarrrr....aaaaddddtttt, each equation must  match  the
     non-terminal symbol E that is the axiom of the following BNF
     grammar:
        E ::= [ G, ..., G ====>>>> ] F ((((P, ..., P)))) ==== V
        G ::= V | V ==== V
        P ::= X | C | P C P | C ((((P, ..., P)))) | P ooooffff S | ((((P))))
        V ::= X | C | V C V | C ((((V, ..., V))))
                | F | V F V | F ((((V, ..., V)))) | V ooooffff S | ((((V))))
     where:

     -    square  brackets  denote  an  optional  element  (here,
          premisses)

     -    C is a terminal symbol denoting a constructor  identif-
          ier (either constant, infix binary, or prefix)

     -    E is a non-terminal symbol denoting a well-formed equa-
          tion

     -    F is a terminal symbol denoting a non-constructor iden-
          tifier (either constant, infix binary, or prefix)

     -    G is a non-terminal symbol denoting an equation premiss
          (either a Boolean guard or an equality test)

     -    P is a non-terminal symbol denoting a pattern (i.e.,  a
          value   expression  that  does  not  contain  any  non-
          constructor identifier)

     -    S is a terminal symbol denoting a sort identifier

     -    V is a non-terminal symbol denoting a value expression

     -    X is a terminal  symbol  denoting  a  value  identifier
          (i.e., a variable)





(C) INRIA            Last change: 2020/02/11                    6






CADP MANUAL PAGES                                    LOTOS(LOCAL)



     Any variable occurring in a guard G  or  in  the  right-hand
     side  expression  V must also occur in (at least one of) the
     left-hand side patterns P.


     In such case, one says that  equation  E  _d_e_f_i_n_e_s  the  non-
     constructor F.


     All constructors must be _f_r_e_e, meaning that the above syntax
     does not allow constructors to be defined by equations.


     If a specification contains non-free constructors, it can be
     transformed into an equivalent specification containing only
     free-constructors. This can be done in a systematic way (see
     Section 1.7 of [Gar89c]).


  CCCCOOOONNNNSSSSTTTTRRRRAAAAIIIINNNNTTTTSSSS OOOONNNN SSSSOOOORRRRTTTTSSSS AAAANNNNDDDD CCCCOOOONNNNSSSSTTTTRRRRUUUUCCCCTTTTOOOORRRRSSSS
     -    If a sort _S is not external, there must exist at  least
          one  constructor  returning  a result of sort _S. Other-
          wise, a compiler warning will be emitted and ccccaaaaeeeessssaaaarrrr....aaaaddddtttt
          will consider that _S is implicitly external, so that no
          C code will be generated to implement this sort.


     -    If a sort _S is not external, then all the  constructors
          returning  a  result  of  sort _S should be non-external
          operations.


     -    If a sort _S is  external,  then  all  the  constructors
          returning  a result of sort _S should be external opera-
          tions.


     -    To enforce a modular  specification  style  that  LOTOS
          does not encourage by default, each constructor return-
          ing a result of sort _S should be declared in  the  same
          LOTOS type as _S, or a compiler warning will be emitted.


     -    Each sort _S must be _p_r_o_d_u_c_t_i_v_e, i.e., there must  exist
          at  least  one _g_r_o_u_n_d _t_e_r_m that is _w_e_l_l-_t_y_p_e_d (a ground
          term being an an algebraic term that contains only con-
          structors,   and   neither   free  variables  nor  non-
          constructors). For instance, a sort  _S  with  only  one
          constructor  defined as "_S_u_c_c :::: _S ---->>>> _S" is unproductive
          (technically, its initial algebra is empty).





(C) INRIA            Last change: 2020/02/11                    7






CADP MANUAL PAGES                                    LOTOS(LOCAL)



  CCCCOOOONNNNSSSSTTTTRRRRAAAAIIIINNNNTTTTSSSS OOOONNNN NNNNOOOONNNN----CCCCOOOONNNNSSSSTTTTRRRRUUUUCCCCTTTTOOOORRRRSSSS AAAANNNNDDDD EEEEQQQQUUUUAAAATTTTIIIIOOOONNNNSSSS
     -    If a non-constructor _F is not  external,  there  should
          exist  at  least  one equation defining _F. Otherwise, a
          compiler warning will be emitted, and  ccccaaaaeeeessssaaaarrrr....aaaaddddtttt  will
          consider  that  _F  is implicitly external, so that no C
          code will be generated to implement this operation.


     -    If non-constructor _F is  external,  then  no  equations
          should  define  _F  (if such equations have already been
          written, it is advised to preserve them  by  commenting
          them out rather than simply deleting them).


     -    To enforce a modular  specification  style  that  LOTOS
          does not encourage by default, each equation defining a
          non-constructor _F should be located in the  same  LOTOS
          type as _F, or a compiler warning will be emitted.


  CCCCOOOONNNNSSSSTTTTRRRRAAAAIIIINNNNTTTTSSSS OOOONNNN RRRREEEENNNNAAAAMMMMIIIINNNNGGGG
     -    Sort renaming is supported as follows.  If  a  sort  _S_2
          renames  a sort _S_1, then ccccaaaaeeeessssaaaarrrr....aaaaddddtttt generates no C code
          for implementing _S_2, and the CADP tools simply  replace
          all  occurrences  of  _S_2  by _S_1 in the C code they gen-
          erate, meaning that both sorts share the same implemen-
          tation in C.


     -    Consequently, it is forbidden  to  define  constructors
          that  return  a result of the renaming sort _S_2, meaning
          that one cannot modify a renamed sort  by  adding  con-
          structors  to  its  renaming  sort(s). See item #903 in
          file "$$$$CCCCAAAADDDDPPPP////HHHHIIIISSSSTTTTOOOORRRRYYYY" for details.


     -    Operation renaming  is  supported  as  follows.  If  an
          operation  _F_2  renames an operation _F_1, then ccccaaaaeeeessssaaaarrrr....aaaaddddtttt
          generates no C code for implementing _F_2, and  the  CADP
          tools simply replace all occurrences of _F_2 by _F_1 in the
          C code they  generate,  meaning  that  both  operations
          share the same implementation in C.


     -    Consequently, it is forbidden to write  equations  that
          define the result of the renaming operation _F_2, meaning
          that one cannot modify  a  renamed  non-constructor  by
          adding equations to its renaming operation(s). See item
          #2190 in file "$$$$CCCCAAAADDDDPPPP////HHHHIIIISSSSTTTTOOOORRRRYYYY" for details.






(C) INRIA            Last change: 2020/02/11                    8






CADP MANUAL PAGES                                    LOTOS(LOCAL)



  CCCCOOOONNNNSSSSTTTTRRRRAAAAIIIINNNNTTTTSSSS OOOONNNN AAAACCCCTTTTUUUUAAAALLLLIIIIZZZZAAAATTTTIIIIOOOONNNN
     -    Type actualization (i.e.,  on  the  one  hand,  generic
          types parameterized by formal sorts, formal operations,
          and/or formal equations, and, on the other hand,  actu-
          alized  types  obtained by instantiating generic types)
          is supported only in a  partial  way.  The  CADP  tools
          indeed  parse  and  statically  check such type defini-
          tions, but ccccaaaaeeeessssaaaarrrr....aaaaddddtttt later ignores them  silently  and
          generates no C code to implement them.


     -    As a consequence, ccccaaaaeeeessssaaaarrrr....aaaaddddtttt does  not  handle  certain
          types  of the LOTOS standard library (e.g., _E_l_e_m_e_n_t and
          _S_e_t). To address this limitation, the user has to flat-
          ten  actualized  types  manually  by  making  a copy of
          parameterized and substituting all formal  elements  by
          the corresponding actual ones.


  RRRREEEEWWWWRRRRIIIITTTTEEEE SSSSTTTTRRRRAAAATTTTEEEEGGGGYYYY
     The C code generated  by  ccccaaaaeeeessssaaaarrrr....aaaaddddtttt  for  evaluating  LOTOS
     value  expressions  uses a term-rewrite strategy that can be
     characterized by the two following rules:


     _c_a_l_l-_b_y-_v_a_l_u_e (or functional evaluation):
          When several subterms can be rewritten  simultaneously,
          the innermost ones are rewritten first.


     _d_e_c_r_e_a_s_i_n_g _p_r_i_o_r_i_t_y _b_e_t_w_e_e_n _e_q_u_a_t_i_o_n_s:
          When, for a  given  subterm,  several  equations  apply
          simultaneously,  the  equation that occurs first in the
          LOTOS source text is chosen.


     Notice that such strategy is not fully deterministic,  since
     it  does  not  specify  in  which order subterms at the same
     nesting level (e.g., the various actual arguments of a func-
     tion  call)  will  be evaluated. The decision is deferred to
     the C compiler, which may take advantage of such  degree  of
     freedom  to optimize machine-code generation. Therefore, the
     user should not expect leftmost  subterms  to  be  rewritten
     first.


     When needed, the call-by-value strategy can be changed to  a
     call-by-need  one  by  using external functions and C macro-
     definitions (see the section below on  CALL-BY-NEED  EVALUA-
     TION).





(C) INRIA            Last change: 2020/02/11                    9






CADP MANUAL PAGES                                    LOTOS(LOCAL)



     With respect to the well-known theory of  term-rewrite  sys-
     tems, the following remarks can be made:


     Completeness:
          The issue of completeness arises  when  there  are  _n_o_t
          _e_n_o_u_g_h  equations  to  define  a  non-constructor.  For
          instance, let _F be a non-constructor defined by a  sin-
          gle  equation  "_F ((((_t_r_u_e)))) = _t_r_u_e"; the value "_F ((((_f_a_l_s_e))))"
          remains undefined. In standard LOTOS, this value cannot
          be  reduced  and is added to the initial algebra of the
          _B_o_o_l sort, thus leading to Booleans  having  more  than
          two values.  This problem is avoided in the CADP tools,
          as the C code generated by ccccaaaaeeeessssaaaarrrr....aaaaddddtttt raises a run-time
          error  when  trying  to  evaluate  a  call  to  a  non-
          constructor whose result is not defined by any equation
          matching  the  values of the actual parameters supplied
          with the call. The ----ddddeeeebbbbuuuugggg option of ccccaaaaeeeessssaaaarrrr....aaaaddddtttt  can  be
          used  to  print  these  values  when  a  run-time error
          occurs. Therefore, ccccaaaaeeeessssaaaarrrr....aaaaddddtttt extends  LOTOS  with  the
          concept   of  partially-defined  functions,  which  are
          implemented using (uncatchable) exceptions.


     Confluence:
          The issue of confluence arises when there are _t_o_o  _m_a_n_y
          equations  to  define  a non-constructor. For instance,
          let _F be a non-constructor defined by the two following
          equations  "_F ((((_x)))) = _t_r_u_e" and "_F ((((_x)))) = _x"; the value "_F
          ((((_f_a_l_s_e))))" can be rewritten either to _t_r_u_e or  _f_a_l_s_e.  In
          standard  LOTOS,  such  a  definition of _F implies that
          both values _t_r_u_e and _f_a_l_s_e are equal, thus  leading  to
          Booleans having a single value. This problem is avoided
          with the decreasing priority between equations enforced
          by  ccccaaaaeeeessssaaaarrrr....aaaaddddtttt,  which  ensures  that the evaluation of
          value   expressions   is    deterministic.    Moreover,
          ccccaaaaeeeessssaaaarrrr....aaaaddddtttt  warns  about  equations that are never used
          because they  are  overriden  by  equations  of  higher
          priority  (note  that,  when  premisses  are used, such
          detection of unused equations cannot be done systemati-
          cally).


     Termination:
          The LOTOS equations are expected to satisfy the  termi-
          nation  property,  but  ccccaaaaeeeessssaaaarrrr....aaaaddddtttt  makes no attempt to
          check this property (anyway, only sufficient conditions
          for  termination  could be checked). If the user writes
          non-terminating equations such as "_F (_X) ==== _F (_X)",  the
          generated  C  code  will  loop forever or cause a stack
          overflow when executed. In such case,  the  C  debugger
          and/or  the  ----ttttrrrraaaacccceeee option of ccccaaaaeeeessssaaaarrrr....aaaaddddtttt can be used to



(C) INRIA            Last change: 2020/02/11                   10






CADP MANUAL PAGES                                    LOTOS(LOCAL)



          understand the reason of the problem.


     In principle, if the LOTOS equations are written to be  con-
     fluent and terminating, then all rewrite strategies (includ-
     ing the one implemented by ccccaaaaeeeessssaaaarrrr....aaaaddddtttt)  should  produce  the
     same  result  when  evaluating a given term. However, in the
     case of partially-defined non-constructors, there will be  a
     difference  as  ccccaaaaeeeessssaaaarrrr....aaaaddddtttt  will  trigger  a run-time error.
     Moreover, seeking for confluent equations prevents from tak-
     ing  advantage  of  priority  between  equations, i.e., from
     using the "if-then-else" facility offered by priority, which
     often  leads  to  shorter  specifications and more efficient
     implementations. A  striking  example  of  the  benefits  of
     priority  is  the ability to define an equality operation _e_q
     for any sort _S using only two equations:
          ffffoooorrrraaaallllllll x, y :::: _S
          ooooffffssssoooorrrrtttt _B_o_o_l
             x _e_q x = _t_r_u_e ;;;;
             x _e_q y = _f_a_l_s_e


     Examples of issues that may arise when adding new operations
     to existing LOTOS sorts are given in Section 2.a of [Gar13].


RRRREEEESSSSTTTTRRRRIIIICCCCTTTTIIIIOOOONNNNSSSS OOOONNNN TTTTHHHHEEEE CCCCOOOONNNNTTTTRRRROOOOLLLL PPPPAAAARRRRTTTT OOOOFFFF LLLLOOOOTTTTOOOOSSSS
     The CADP tools accept a very large class of LOTOS  behaviour
     expressions  and process definitions: all behavioural opera-
     tors are accepted and value expressions are handled as well.
     However, there are a few restrictions dictated either by the
     need to produce finite-state transition systems, or  by  the
     efficiency  of the translation algorithms. Some restrictions
     also   depend   on   the   kind   of   analysis    performed
     (e.g.,exhaustive  state-space  exploration  vs  sequential C
     code generation).


  SSSSTTTTAAAATTTTIIIICCCC----CCCCOOOONNNNTTTTRRRROOOOLLLL CCCCOOOONNNNSSSSTTTTRRRRAAAAIIIINNNNTTTTSSSS
     For efficiency reasons (namely, to ensure  that  the  inter-
     preted  Petri nets generated by the translation have at most
     one token per place), the CADP  tools  lay  additional  con-
     straints  on  LOTOS behaviour expressions.  Only a subset of
     LOTOS behaviour expressions is accepted, those that  satisfy
     the so-called _s_t_a_t_i_c _c_o_n_t_r_o_l property: any recursive call to
     a process is prohibited if it occurs in any of the five fol-
     lowing contexts:


     -    on the left- or on the right-hand side  of  a  parallel
          composition operator ("||||||||", "||||||||||||", "||||[[[[...]]]]||||")




(C) INRIA            Last change: 2020/02/11                   11






CADP MANUAL PAGES                                    LOTOS(LOCAL)



     -    through a "ppppaaaarrrr" operator

     -    through a "hhhhiiiiddddeeee" operator

     -    on the left-hand side of a ">>>>>>>>" (enable) operator

     -    on the left-hand side of a "[[[[>>>>" (disable) operator


     See Section 3.1 of  [Gar89b]  for  a  formal  definition  of
     static  control constraints, illustrated with detailed exam-
     ples. Notice that a call  to  a  recursive  process  is  not
     necessarily  a recursive process call (although the converse
     is true).


     In practice, LOTOS specifications that do not satisfy  these
     constraints often exhibit a non-regular behaviour and, thus,
     cannot be translated to finite-state transition systems.


  FFFFIIIINNNNIIIITTTTEEEE----DDDDOOOOMMMMAAAAIIIINNNN CCCCOOOONNNNSSSSTTTTRRRRAAAAIIIINNNNTTTTSSSS
     The three following LOTOS behaviour  expressions  require  a
     nondeterministic selection, in the domain of sort _S, of some
     value to be stored in variable _x:

     -    "cccchhhhooooiiiicccceeee _x::::_S [[[[]]]] ..."

     -    "eeeexxxxiiiitttt ((((aaaannnnyyyy _S))))"

     -    "_G ????_x::::_S ;;;; ..." (provided that this input action on  the
          visible gate _G is not synchronized with an ouput action
          "_G !!!!_v ;;;; ..." that would impose value _v to _x).


     In general, to execute such behaviour expressions, the  CADP
     tools  enumerate all possible values in the domain of sort S
     and try all possible execution paths, one  for  each  value.
     That  is,  these tools perform _c_o_n_c_r_e_t_e rather than _s_y_m_b_o_l_i_c
     execution.


     Enumerating the domain of sort _S is only  possible  if  this
     domain  is finite or, in the case of infinite sorts (such as
     lists, strings, trees, etc.), if  the  enumeration  is  res-
     tricted  to  a  finite  subset (e.g., only those lists whose
     length is less than five).


     If the domain of sort _S is infinite, or if it  is  so  large
     that  the  user  wants to restrict it to a smaller subset in
     order to avoid state-space explosion issues, or if _S  is  an



(C) INRIA            Last change: 2020/02/11                   12






CADP MANUAL PAGES                                    LOTOS(LOCAL)



     external sort, the user must provide an _i_t_e_r_a_t_o_r for sort S,
     i.e., a fragment of C code that enables a variable _x of sort
     _S to enumerate all possible values in the chosen subset.


     If sort _S is never  used  in  any  of  the  three  kinds  of
     behaviour  expressions  listed  above,  then no iterator for
     sort _S  is  required,  as  the  domain  of  _S  will  not  be
     enumerated.  Thus,  sorts with infinite or large domains are
     perfectly accepted,  as  long  as  no  attempt  is  made  at
     enumerating  their  domains.  Notice  also that, by default,
     _c_a_e_s_a_r._a_d_t automatically generates iterators for all finite,
     non-external  sorts  (and  bounded  iterators  for infinite,
     non-external sorts isomorphic to natural numbers).


     Notice that, if a LOTOS specification satisfies the  static-
     control  property  and the finite-domain constraints for all
     its sorts that must be enumerated, then its labelled transi-
     tion  system  is necessarily finite. However, even if finite
     in theory, it may still be too  large  to  be  generated  in
     practice.


  CCCCLLLLOOOOSSSSEEEEDDDD----WWWWOOOORRRRLLLLDDDD MMMMOOOODDDDEEEELLLLLLLLIIIINNNNGGGG
     As mentioned in the previous section, in the particular case
     of  an  input action "_G ????_x::::_S ;;;; ..." not synchronized, on the
     visible gate _G, with a corresponding output action, the CADP
     tools  will  enumerate  all possible values in the domain of
     sort _S. Such  enumeration  is  indeed  conformant  with  the
     operational  semantics of LOTOS, in which both terms "_G ????_x::::_S
     ;;;; _B" and "cccchhhhooooiiiicccceeee _x::::_S [[[[]]]] _G !!!!_x  ;;;;  _B"  are  equivalent  modulo
     strong bisimulation.


     Note: in certain cases, value enumeration could be  avoided.
     For instance, the LOTOS terms "_G ????_x::::_S [[[[_x====_v]]]] ;;;; _B" and "_G ????_x::::_S
     ;;;; [[[[_x====_v]]]] ---->>>> _B" are strongly equivalent to the term "_G !!!!_v ;;;; _B"
     and thus do not require enumerating all values in the domain
     of sort _S. However, such optimizations are  not  yet  imple-
     mented in the ccccaaaaeeeessssaaaarrrr compiler.


     To be precise, value enumeration only takes place when  per-
     forming  exhaustive  state-space  exploration  (namely, when
     using  ccccaaaaeeeessssaaaarrrr  to  generate  a  Labelled  Transition  System
     encoded,  e.g.,  in the aaaauuuutttt(LOCAL) or bbbbccccgggg(LOCAL) format), or
     when performing on-the-fly  exploration  using  one  of  the
     tools  based  upon  the OPEN/CAESAR framework. However, when
     ccccaaaaeeeessssaaaarrrr is used to generate C code that will be connected  to
     a  real  environment  using  the EXEC/CAESAR framework, such
     iteration does not take place and is replaced by a call to a



(C) INRIA            Last change: 2020/02/11                   13






CADP MANUAL PAGES                                    LOTOS(LOCAL)



     so-called  "gate  function" that will actually input a value
     from the real environment, rather than enumerating all  pos-
     sible values that could be input.


     To  restrict   value   enumeration   on   an   infinite   or
     excessively-large  sort domain, the definition (or redefini-
     tion) of an ad-hoc iterator (mentioned in the previous  sec-
     tion) is sometimes non feasible, because it would affect all
     other places in the LOTOS specification where this  sort  is
     used. In such case, alternative techniques must be used.


     If the sort  domain  is  finite  or  isomorphic  to  natural
     numbers  (which  ccccaaaaeeeessssaaaarrrr....aaaaddddtttt implements using a finite inter-
     val), the enumeration can be straightforwardly restricted by
     adding a predicate to the input action, i.e., "_G ????_x::::_S [[[[_f(_x)]]]]
     ;;;; ...", so that only those values _v satisfying _f(_x) will  be
     selected.  This may cause an overhead in CPU time, but it is
     usually negligible.


     Another technique to restrict the enumeration is to synchon-
     ize each input action with one or many output actions defin-
     ing the possible values that can be  sent  by  the  external
     environment  in  which  the LOTOS specification is evolving.
     This requires to introduce, in the LOTOS  specification,  an
     extra  process  that  runs in parallel with the remainder of
     the  specification  and  synchronizes  on  input  gates  (at
     least). This added process describes scenarios of input (and
     possibly,  output)  actions  exchanged  between  the  system
     described by the LOTOS specification and its environment. In
     model-checking terminology, a specification extended with  a
     model  of  the  environment  is  often called a _c_l_o_s_e_d-_w_o_r_l_d
     description, as opposed to an _o_p_e_n-_w_o_r_l_d description,  where
     no  assumption  is  made about the environment. In the LOTOS
     literature, using parallel composition as a logical conjunc-
     tion   to  specify  additional  properties  is  known  as  a
     _c_o_n_s_t_r_a_i_n_t-_o_r_i_e_n_t_e_d specification style.


OOOOTTTTHHHHEEEERRRR EEEEXXXXTTTTEEEENNNNSSSSIIIIOOOONNNNSSSS TTTTOOOO LLLLOOOOTTTTOOOOSSSS
     For convenience, a  few  enhancements  to  LOTOS  have  been
     implemented in the CADP tools. These extensions deviate from
     the standard definition of LOTOS [ISO89]  but  they  can  be
     disabled  by  giving  the  command-line option "----iiiissssoooo", which
     enforces the standard definition of LOTOS. These  extensions
     are the following:


     1.   In standard LOTOS, "i" and "I" are  reserved  keywords,
          which  forbids  to  declare any identifier named "i" or



(C) INRIA            Last change: 2020/02/11                   14






CADP MANUAL PAGES                                    LOTOS(LOCAL)



          "I". The CADP tools relax this  constraint  by  turning
          "i"  and  "I" into reserved identifiers for gates only.
          This makes it possible to declare, e.g.,  variables  or
          operations  named  "i"  or  "I". See item #1512 in file
          "$$$$CCCCAAAADDDDPPPP////HHHHIIIISSSSTTTTOOOORRRRYYYY" for details.


     2.   In standard LOTOS, the sorts of formal variable parame-
          ters are not used to resolve overloading ambiguities in
          actual value expressions of process instantiations. For
          instance,  if  a  process  P  is declared with a formal
          variable parameter X of sort Nat, invoking this process
          with the actual value zero requires to write "0 of Nat"
          rather than simply "0" if sorts Nat and Int both have a
          constant  0.  To address this issue, the CADP tools use
          extended type-checking rules that allow to write simply
          "0"  rather than "0 of Nat", because the declaration of
          X is taken into account to infer that 0 has  sort  Nat.
          See item #1803 in file "$$$$CCCCAAAADDDDPPPP////HHHHIIIISSSSTTTTOOOORRRRYYYY" for details.


     3.   In standard LOTOS, the sorts of  the  value  parameters
          and exit results of the top-level specification must be
          declared in the section of global definitions  (located
          before  the  "behaviour" keyword). When this section is
          empty, the CADP tools look into the  local  definitions
          (located  after  the  "behaviour"  keyword) to find the
          declaration of these sorts.  See  item  #1875  in  file
          "$$$$CCCCAAAADDDDPPPP////HHHHIIIISSSSTTTTOOOORRRRYYYY" for details.


     4.   The CADP tools use a modified semantics for  flattening
          parameterized  types,  rather  than the standard (seem-
          ingly questionable) semantics of LOTOS.   The  modified
          semantics  is  described  in [GS95a]; in practice, how-
          ever, the differences between both semantics should not
          matter too much, given that parameterized types are not
          fully implemented by the CADP tools.  See item #346  in
          file "$$$$CCCCAAAADDDDPPPP////HHHHIIIISSSSTTTTOOOORRRRYYYY" for details.


     5.   The CADP tools recognize a special comment of the  form
          "((((****!!!!  aaaattttoooommmmiiiicccc ****))))" that, if present in a LOTOS specifica-
          tion (usually, after some ">>" operator),  removes  all
          hidden  transitions  (labelled "iiii") created by the ">>"
          operators. Such special comment is mostly used for  the
          translation  of  LNT  to LOTOS, and purposedly deviates
          from  the  standard  operational  semantics  of   LOTOS
          behaviour   expressions.   See   item   #1327  in  file
          "$$$$CCCCAAAADDDDPPPP////HHHHIIIISSSSTTTTOOOORRRRYYYY" for details.





(C) INRIA            Last change: 2020/02/11                   15






CADP MANUAL PAGES                                    LOTOS(LOCAL)



OOOOTTTTHHHHEEEERRRR DDDDEEEEVVVVIIIIAAAATTTTIIIIOOOONNNNSSSS FFFFRRRROOOOMMMM TTTTHHHHEEEE LLLLOOOOTTTTOOOOSSSS SSSSTTTTAAAANNNNDDDDAAAARRRRDDDD
     This section lists a few minor differences between the LOTOS
     standard  [ISO89]  and the way it is implemented in the CADP
     tools:


     -    In the labelled transition  systems  generated  by  the
          CADP tools, the auxiliary gate used for sequential com-
          position, which is noted using the Greek letter "delta"
          in  the  standard  semantics  of LOTOS, is noted "eeeexxxxiiiitttt"
          (always in lower case). This decision is  justified  by
          the  need  to  use  Latin-alphabet letters only, by the
          fact that gate "delta" can  only  be  produced  by  the
          "eeeexxxxiiiitttt"  operator  of  LOTOS,  and  by  the fact that no
          user-defined gate can be named "eeeexxxxiiiitttt" since  this  name
          is  a  reserved keyword of LOTOS (which is not the case
          of "delta").


     -    In the labelled transition  systems  generated  by  the
          CADP  tools, the invisible (or internal) gate, which is
          usually noted using  the  Greek  letter  "tau"  in  the
          scientific  literature,  is  noted "iiii" (always in lower
          case).  The standard  semantics of LOTOS also uses  the
          same "iiii" notation.


     -    When a LOTOS specification is defined with formal vari-
          able  parameters,  the standard semantics of LOTOS does
          not say much on how these parameters should be handled.
          Certain  LOTOS  implementations  (e.g.,  the TOPO tool)
          reject  such  parameterized  specifications.  The  CADP
          tools  (namely, ccccaaaaeeeessssaaaarrrr) also reject them, unless the "----
          rrrrooooooootttt" option is used to provide  actual  value  expres-
          sions that instantiate the formal variable parameters.

          Note: Earlier versions of ccccaaaaeeeessssaaaarrrr handled  formal  vari-
          able  parameters  by  enumerating  the domains of their
          respective sorts, but this is no longer the  case.  See
          item #2014 in file "$$$$CCCCAAAADDDDPPPP////HHHHIIIISSSSTTTTOOOORRRRYYYY" for details.


     -    The CADP tools may differ from  [ISO89]  when  handling
          process calls in which two (or more) actual gate param-
          eters  are  identical.  For  instance,  the   following
          behavior:
                _P [[[[_c, _c]]]]
             wwwwhhhheeeerrrreeee
                pppprrrroooocccceeeessssssss _P [[[[_a, _b]]]] :::: nnnnooooeeeexxxxiiiitttt ::::====
                   _a ;;;; ssssttttoooopppp |||||||| _b ;;;; ssssttttoooopppp
                eeeennnnddddpppprrrroooocccc
          is strongly  equivalent  to  "ssssttttoooopppp"  according  to  the



(C) INRIA            Last change: 2020/02/11                   16






CADP MANUAL PAGES                                    LOTOS(LOCAL)



          standard  semantics  of LOTOS, because the body of pro-
          cess _P is evaluated _a_f_t_e_r applying the gate relabelling
          function  that  maps  _a  to _c and _b to _c. However, this
          behaviour is equivalent to "_c ;;;; ssssttttoooopppp" according to  the
          CADP tools because the expansion phase of ccccaaaaeeeessssaaaarrrr imple-
          ments a _c_a_l_l-_b_y-_v_a_l_u_e semantics that applies  the  gate
          relabelling  function  _b_e_f_o_r_e evaluating the body of _P,
          which becomes therefore "_c ;;;; ssssttttoooopppp |||||||| _c  ;;;;  ssssttttoooopppp".  Both
          semantics  coincide in most cases, and may only diverge
          if a process  is  called  with  identical  actual  gate
          parameters and if some of the corresponding formal gate
          parameters are synchronized together in the body of the
          process.  ccccaaaaeeeessssaaaarrrr  always emits a warning message if the
          relabelling function is not injective; in  the  absence
          of such a warning, the call-by-value semantics conforms
          to the standard LOTOS semantics.


     There are a few other subtle differences, which  should  not
     matter to most users:


     -    When declaring an infix operation "_____F____ :::: _S_1, ..., _S_n ---->>>>
          _S",  the  standard  syntax of LOTOS allows spaces to be
          inserted between _F and its two surrounding  underscores
          (see  _o_p_e_r_a_t_o_r-_d_e_s_c_r_i_p_t_o_r in Section 6.2.5 of [ISO89]).
          Such syntax is difficult to parse; at  the  expense  of
          internal  complexity,  the CADP tools parse it properly
          but do not check that identifier _F is  not  a  reserved
          keyword.  Though it may be possible to declare an infix
          operation  whose  name  is  a  keyword,   any   further
          occurrences  of  this  operation  will be syntactically
          rejected.


     -    In Section 7.3.3 of [ISO89], it  is  acknowledged  that
          the  syntax of LOTOS is ambiguous, as it does not allow
          to make the difference between a variable (i.e.,  value
          identifier) and a nullary operation occuring in a value
          expression. The disambiguation can only be  done  later
          using  static  semantics information, but the remainder
          of the section does not state clearly how  to  bind  an
          identifier  _x when both a variable and a nullary opera-
          tion exist with both  the  same  name  _x  and  both  an
          appropriate sort.

          The CADP tools proceed in two steps. First, they search
          whether  a variable named _x exists; if so, the identif-
          ier _x is bound to this variable, whatever the  sort  of
          the variable (a type-checking error will occur later if
          the variable does not have the proper sort). Second, if
          no  variable  named  _x  exists,  they perform operation



(C) INRIA            Last change: 2020/02/11                   17






CADP MANUAL PAGES                                    LOTOS(LOCAL)



          binding and overloading resolution, which will have the
          effect of binding the identifier to a nullary operation
          _x if it exists with an appropriate sort. Thus,  prefer-
          ence  is  always given to variables over nullary opera-
          tions, which seems compatible  with  the  principle  of
          binding  with  the  innermost operation definition when
          resolving operation overloading.


     -    In Section 7.3.4.5.e of [ISO89], requirement  (e1)  was
          strengthened   to   state   that,   when   the   clause
          "aaaacccccccceeeepppptttt...iiiinnnn" is missing, the behaviour  expression  _B_1
          occurring  in  "_B_1  >>>>>>>>  _B_2" must have the functionality
          "_e_x_i_t".


     -    The decision to  implement  the  "lllliiiibbbbrrrraaaarrrryyyy"  declaration
          using  file inclusion (see below the section on LIBRARY
          FILES) leads to slightly different rules for the  visi-
          bility of identifiers declared in libraries.


FFFFIIIILLLLEEEENNNNAAAAMMMMEEEESSSS
     This section describes the various files  related  to  LOTOS
     specifications and their implementation.


  LLLLOOOOTTTTOOOOSSSS FFFFIIIILLLLEEEESSSS
     The files containing  LOTOS  specifications  should  have  a
     "....lllloooottttoooossss"  suffix.   This  is  the  preferred convention when
     using CADP. However, to ease the use of non-CADP tools,  the
     alternative  suffixes  "....llllooootttt"  and  "....llll" are also tolerated,
     i.e., properly recognized by the CADP tools.


  LLLLIIIIBBBBRRRRAAAARRRRYYYY FFFFIIIILLLLEEEESSSS
     The directive "lllliiiibbbbrrrraaaarrrryyyy _f_1, ..., _f_n eeeennnnddddlllliiiibbbb" that  is  present
     in  the  standard  LOTOS  definition [BB88] without explicit
     meaning is implemented using  file  inclusion  by  the  CADP
     tools,  as  follows:  when such a clause is encountered, the
     CADP tools look for  files  named  "_F_1....lllliiiibbbb",  ...,  "_F_n....lllliiiibbbb"
     (where the strings "_F_1, ..., _F_n" are obtained from "_f_1, ...,
     _f_n" by turning lower-case letters to upper case, since LOTOS
     identifiers  are  case  insensitive  whereas  file names are
     often case sensitive)  and  include  these  files,  in  that
     order,  at  the  place  where the directive "lllliiiibbbbrrrraaaarrrryyyy" occurs
     (the directive itself is replaced by  the  contents  of  the
     files). This is similar to the effect of a "####iiiinnnncccclllluuuuddddeeee" direc-
     tive with the C preprocessor.

     The "....lllliiiibbbb" files are searched first in  the  current  direc-
     tory,  or  else in the $$$$CCCCAAAADDDDPPPP////lllliiiibbbb directory, which contains a



(C) INRIA            Last change: 2020/02/11                   18






CADP MANUAL PAGES                                    LOTOS(LOCAL)



     collection of predefined LOTOS libraries. If a  file  cannot
     be  found  using  these  search  rules,  a  fatal  error  is
     reported. More elaborate search rules  can  be  obtained  by
     creating  symbolic  links  to  library  files in the current
     directory.

     Library inclusion can be  transitive,  meaning  that  "....lllliiiibbbb"
     files  may contain "lllliiiibbbbrrrraaaarrrryyyy" directives. Circular inclusions
     are prohibited.

     Contrary  to  the  standard  LOTOS  definition   [BB88],   a
     "lllliiiibbbbrrrraaaarrrryyyy"  directive  may occur at any place (i.e., not only
     in data-type definitions) and may  contain  arbitrary  LOTOS
     code  fragments (e.g., process definitions, rather than type
     definitions only). These  extensions  help  splitting  large
     LOTOS  specifications  into  several files and enable one to
     develop reusable  libraries  of  processes  (e.g.,  buffers,
     shared variables, etc.).


  IIIINNNNCCCCLLLLUUUUDDDDEEEE FFFFIIIILLLLEEEESSSS
     To be processed by the CADP  tools,  a  LOTOS  specification
     contained   in  a  given  file  _f_i_l_e_n_a_m_e....lllloooottttoooossss  should  come
     together with an implementation (in the C language)  of  the
     LOTOS  sorts  and  operations.   This implementation must be
     provided in a file named _f_i_l_e_n_a_m_e....hhhh located in  the  current
     directory.

     This file can be either written  by  hand  or  automatically
     generated using ccccaaaaeeeessssaaaarrrr....aaaaddddtttt(LOCAL).  In the latter case, both
     approaches can be combined, as  the  user  may  (optionally)
     provide two additional files:


     -    a file named _f_i_l_e_n_a_m_e....tttt (where "....tttt" stands for "types")
          that  contains manually-written C code for implementing
          certain LOTOS sorts,

     -    a file named _f_i_l_e_n_a_m_e....ffff (where "....ffff" stands  for  "func-
          tions")  that  contains  manually-written  C  code  for
          implementing certain LOTOS operations.


     Each of these files, if present in the current directory  at
     the  moment when ccccaaaaeeeessssaaaarrrr....aaaaddddtttt is invoked, will be #included in
     the _f_i_l_e_n_a_m_e....hhhh file generated by ccccaaaaeeeessssaaaarrrr....aaaaddddtttt. If  both  files
     are present, _f_i_l_e_n_a_m_e....tttt will be included before _f_i_l_e_n_a_m_e....ffff.


     The motivation behind the "....tttt" and "....ffff" files  is  to  offer
     the  possibility  to  introduce  manually-written C code for
     certain sorts and/or operations, and also to customize the C



(C) INRIA            Last change: 2020/02/11                   19






CADP MANUAL PAGES                                    LOTOS(LOCAL)



     code  produced  by ccccaaaaeeeessssaaaarrrr....aaaaddddtttt without modifying the contents
     of the "....hhhh" file generated by ccccaaaaeeeessssaaaarrrr....aaaaddddtttt.


     In particular, the files "$$$$CCCCAAAADDDDPPPP////iiiinnnnccccllll////XXXX____****....hhhh",  which  contain
     manually-written  C  code to implement standard LOTOS types,
     should be included (using a  "####iiiinnnncccclllluuuuddddeeee"  directive)  in  the
     "....tttt" file if the LOTOS specification imports the correspond-
     ing types defined in "$$$$CCCCAAAADDDDPPPP////lllliiiibbbb////XXXX____****....lllliiiibbbb".


     The CADP tools generate auxiliary C  programs  that  include
     the  "....hhhh", "....tttt", and "....ffff" files, then compile these programs
     and execute them  to  obtain  information  about  the  types
     defined  in these files. To be more precise, ccccaaaaeeeessssaaaarrrr....aaaaddddtttt com-
     piles only the "....tttt" file if it exists, while ccccaaaaeeeessssaaaarrrr compiles
     only  the  "....hhhh"  file if it exists (keeping in mind that, if
     the "....hhhh" file has been generated using ccccaaaaeeeessssaaaarrrr....aaaaddddtttt, it should
     include the "....tttt", and "....ffff" files if they were present at the
     time ccccaaaaeeeessssaaaarrrr....aaaaddddtttt was invoked).


     So doing, the CADP tools check that the  manually-written  C
     code  contained  in  these  files  is valid according to the
     definition of the C language. However, the CADP tools cannot
     verify whether this C code correctly implements the intended
     meaning of the sorts and operations  defined  in  the  LOTOS
     specification.  In  practice, such mistakes can be difficult
     to detect. When debugging  such  problems,  one  can  safely
     assume that the errors are in the C code manually written by
     the user, rather than in the C code generated  by  the  CADP
     tools.


     Notice that the "----eeeexxxxtttteeeerrrrnnnnaaaallll" option of ccccaaaaeeeessssaaaarrrr....aaaaddddtttt is helpful,
     as  it  generates,  for  the "....tttt", and "....ffff" files, skeletons
     that can be later filled in by the user.


TTTTAAAAIIIILLLLOOOORRRREEEEDDDD CCCCOOOODDDDEEEE GGGGEEEENNNNEEEERRRRAAAATTTTIIIIOOOONNNN FFFFOOOORRRR DDDDAAAATTTTAAAA TTTTYYYYPPPPEEEESSSS
     ccccaaaaeeeessssaaaarrrr....aaaaddddtttt analyzes LOTOS sorts and their  constructors  and
     recognizes  various classes of sorts that can be implemented
     efficiently, if not optimally [Gar89c,GT93].  These  classes
     are the following:


     _s_i_n_g_l_e_t_o_n _s_o_r_t_s:
          They have only one element; such sorts often arise when
          performing value abstraction, i.e., replacing a complex
          sort by a singleton.





(C) INRIA            Last change: 2020/02/11                   20






CADP MANUAL PAGES                                    LOTOS(LOCAL)



     _e_n_u_m_e_r_a_t_i_o_n _s_o_r_t_s:
          They correspond  to  the  usual  notion  of  enumerated
          types.


     _n_u_m_e_r_a_l _s_o_r_t_s:
          They correspond  to  the  usual  notion  of  (infinite)
          natural numbers, which ccccaaaaeeeessssaaaarrrr....aaaaddddtttt restricts to a finite
          range 0...(_n-1).  The value of _n is determined as  fol-
          lows:  if the macro CCCCAAAAEEEESSSSAAAARRRR____AAAADDDDTTTT____HHHHAAAASSSSHHHH_____N is defined in the
          "....tttt" file (see below the section on SPECIAL SYMBOLS for
          details),  then  _n is given by the value of this macro;
          else if ccccaaaaeeeessssaaaarrrr....aaaaddddtttt is  invoked  with  option  ----nnnnuuuummmmeeeerrrraaaallll,
          then  _n  is  given  by the integer value following this
          option; otherwise _n is set to  256  (meaning  that,  by
          default,  values  of  a numeral sort are stored using a
          single byte to avoid wasting memory during  state-space
          exploration).


     _t_u_p_l_e _s_o_r_t_s:
          They correspond to the usual notion of record types.


     _o_r_d_i_n_a_r_y _s_o_r_t_s:
          They correspond to the usual  notion  of  discriminated
          union types.


     Even when automatic code generation is  used,  it  is  still
     possible  to instruct ccccaaaaeeeessssaaaarrrr....aaaaddddtttt to adapt its C code genera-
     tion to particular requirements. This can be  done  in  four
     (non mutually exclusive) ways:


     -    By passing specific options on the command line  (e.g.,
          ----ddddeeeebbbbuuuugggg,  ----iiiinnnnffffiiiixxxx, ----mmmmaaaaccccrrrroooo, ----pppprrrreeeeffffiiiixxxx, ----ttttrrrraaaacccceeee) to modify the
          generated C code;


     -    By declaring certain LOTOS sorts as _e_x_t_e_r_n_a_l  (see  the
          section  below  on SPECIAL COMMENTS FOR SORTS) and pro-
          viding the  C  code  that  implements  these  sorts  in
          _f_i_l_e_n_a_m_e....tttt.


     -    By declaring certain LOTOS operations as _e_x_t_e_r_n_a_l  (see
          the  section  below on SPECIAL COMMENTS FOR OPERATIONS)
          and providing the C code that implements  these  opera-
          tions in _f_i_l_e_n_a_m_e....ffff.





(C) INRIA            Last change: 2020/02/11                   21






CADP MANUAL PAGES                                    LOTOS(LOCAL)



     -    By inserting, in the  aforementioned  file  _f_i_l_e_n_a_m_e....tttt,
          various directives that influence the way certain LOTOS
          sorts are implemented in C.  See below the  section  on
          SPECIAL SYMBOLS for details.


LLLLOOOOTTTTOOOOSSSS AAAANNNNDDDD CCCC IIIIDDDDEEEENNNNTTTTIIIIFFFFIIIIEEEERRRRSSSS
     To  execute  LOTOS  specifications,  one  must  establish  a
     correspondence  between  _a_b_s_t_r_a_c_t  data  types  (i.e., LOTOS
     sorts and operations)  and  their  _c_o_n_c_r_e_t_e  implementations
     (i.e., C types and functions or macro-definitions). There is
     no direct, one-to-one correspondence,  because:   (i)  LOTOS
     operation  identifiers may contain special characters (e.g.,
     "#", "@", etc.) that are not allowed in C identifiers;  (ii)
     LOTOS allows a sort and an operation to share the same iden-
     tifier, whereas types and functions must have distinct iden-
     tifiers  in  C;  (iii)  a  LOTOS operation identifier may be
     overloaded and thus be implemented by different C  functions
     or  macro-definitions,  each of which must have unique iden-
     tifier in C.  Notice also that, although  LOTOS  identifiers
     are case-insensitive, C identifiers are case-sensitive.

     In the sequel, a _v_a_l_i_d _C _i_d_e_n_t_i_f_i_e_r denotes  any  identifier
     that  obeys  the rules of the C language; such an identifier
     must be different from the reserved  keywords  of  C  (i.e.,
     "iiiiffff",  "wwwwhhhhiiiilllleeee",  etc.),  but  should  also be different from
     POSIX  names  (e.g.,  "eeeexxxxiiiitttt",  "FFFFIIIILLLLEEEE",  "ffffooooppppeeeennnn",   "mmmmaaaalllllllloooocccc",
     "pppprrrriiiinnnnttttffff", etc.). Moreover, it should not start with a prefix
     used by the CADP tools, among which "AAAADDDDTTTT____, "aaaaddddtttt____, "CCCCAAAAEEEESSSSAAAARRRR____",
     "ccccaaaaeeeessssaaaarrrr____",  "BBBBCCCCGGGG____",  "bbbbccccgggg____",  "XXXXTTTTLLLL____",  and "xxxxttttllll____". It may be
     worth that users choose another prefix and use it systemati-
     cally before their own C identifiers.


     The standard definition of LOTOS makes no provision for map-
     ping abstract data types to concrete ones, so that interface
     conventions often differ across tools that implement  LOTOS.
     The  next  section  describes the conventions adopted by the
     CADP tools for LOTOS.


SSSSPPPPEEEECCCCIIIIAAAALLLL CCCCOOOOMMMMMMMMEEEENNNNTTTTSSSS
     Mapping  information  is  inserted  directly  in  the  LOTOS
     specifications  by  means  of _s_p_e_c_i_a_l _c_o_m_m_e_n_t_s. Such special
     comments have the following syntax "((((****!!!! ............ ****))))" and are thus
     a subset of ordinary LOTOS comments "((((**** ............ ****))))". But, unlike
     ordinary comments, their content is meaningful and parsed.

     Note: users should carefully respect the syntax  of  special
     comments  because  they are scanned at a lexical rather than
     syntactic level. Thus, in case of syntax errors in a special
     comment,  the error-recovery actions performed by the SYNTAX



(C) INRIA            Last change: 2020/02/11                   22






CADP MANUAL PAGES                                    LOTOS(LOCAL)



     compiler-generator system used to build the CADP  tools  may
     be  less intuitive than usually, yielding a cascade of cryp-
     tic error messages.

     There are  two  main  classes  of  special  comments:  those
     attached  to  LOTOS  operations, and those attached to LOTOS
     sorts.  Unless  stated  otherwise,  special   comments   are
     optional.  If present, they must occur immediately after the
     declaration of the sort or the operation they  are  attached
     to.

     It is not permitted to attach a special comment to  a  LOTOS
     sort  or  operation  defined  by  renaming  an other sort or
     operation,  because  ccccaaaaeeeessssaaaarrrr....aaaaddddtttt  generates  no  C  code  for
     renamed  sorts  and operations, and just implements these as
     synonyms of the sorts and operations they rename.

     It is not permitted to attach a special comment to  a  LOTOS
     sort  or  operation that is either formal (i.e., generic) or
     defined by actualizing an other sort or  operation,  because
     ccccaaaaeeeessssaaaarrrr....aaaaddddtttt  generates  no  C code to implement parameterized
     data types.

     Numerous examples of special comments can be found  by  exa-
     mining the predefined LOTOS libraries contained in directory
     "$$$$CCCCAAAADDDDPPPP////lllliiiibbbb".  The simplest example is probably the _B_I_T  type
     declared   in   "$$$$CCCCAAAADDDDPPPP////lllliiiibbbb////XXXX____BBBBIIIITTTT....lllliiiibbbb"   and  implemented  in
     "$$$$CCCCAAAADDDDPPPP////iiiinnnnccccllll////XXXX____BBBBIIIITTTT....hhhh".


  SSSSPPPPEEEECCCCIIIIAAAALLLL CCCCOOOOMMMMMMMMEEEENNNNTTTTSSSS FFFFOOOORRRR SSSSOOOORRRRTTTTSSSS
     A special comment attached to the  declaration  of  a  LOTOS
     sort  _S has the following syntax (where square brackets mean
     optional elements):

        ((((****!!!!
           [ iiiimmmmpppplllleeeemmmmeeeennnntttteeeeddddbbbbyyyy _N ]
           [ ccccoooommmmppppaaaarrrreeeeddddbbbbyyyy _N_1 ]
           [ iiiitttteeeerrrraaaatttteeeeddddbbbbyyyy _N_2 aaaannnndddd _N_3 ]
           [ pppprrrriiiinnnntttteeeeddddbbbbyyyy _N_4 ]
           [ lllliiiisssstttt ]
           [ eeeexxxxtttteeeerrrrnnnnaaaallll ]
        ****))))


     where _N, _N_1, _N_2, _N_3, and _N_4 are valid C identifiers. Even if
     these elements are optional, their order cannot be modified.
     Spaces and blanks are allowed inside special comments.   All
     letters  in  the  words  "iiiimmmmpppplllleeeemmmmeeeennnntttteeeeddddbbbbyyyy", "ccccoooommmmppppaaaarrrreeeeddddbbbbyyyy", ...,
     "eeeexxxxtttteeeerrrrnnnnaaaallll" can be either in  lower  or  upper  case;  it  is
     advised to use the lower case only.




(C) INRIA            Last change: 2020/02/11                   23






CADP MANUAL PAGES                                    LOTOS(LOCAL)



     The meaning of special comments is the following:


     -    The attribute "iiiimmmmpppplllleeeemmmmeeeennnntttteeeeddddbbbbyyyy _N", if present,  indicates
          that the abstract LOTOS sort _S is implemented by a con-
          crete C type named _N. The simplest way is to declare  _N
          using  a  "ttttyyyyppppeeeeddddeeeeffff"  instruction,  but declaring _N as a
          macro-definition is also possible.

          Type _N can be any C type whose values  occupy  a  fixed
          number  of bits, so that values of type _N can be copied
          using a standard C assignment operator "====". This  obvi-
          ously allows (signed and unsigned) integers and charac-
          ters, reals, and enums. This  also  allows  struct  and
          union  types, for which assignment is also permitted in
          C; the CADP tools take into account the case of certain
          C  compilers that copy each field of structs or unions,
          but do not copy the padding bits that may exist between
          these  fields:  in such case, assignment is replaced by
          a call to  the  mmmmeeeemmmmccccppppyyyy(((())))  function  to  avoid  creating
          uncanonical  values  (i.e.,  identical  struct or union
          values having a different  representation  in  memory).
          Array  types  are not allowed because assignment is not
          permitted for them. Finally, pointer types  (to,  e.g.,
          vectors,  matrices,  linked  lists, binary trees, etc.)
          are also allowed, provided that  the  allocated  memory
          cells  to  which  they point are assigned only once and
          not modified later. Thus, any function with an argument
          of  pointer  type  should not modify this  argument but
          first make a copy of it  and  modify  this  copy  only.
          Under this condition, structural sharing (i.e., several
          pointers referring to the same memory cell)  will  work
          correctly.   See  below  the section on SPECIAL SYMBOLS
          for a discussion on  structural  sharing,  as  well  as
          other points such as bit fields.

          If the attribute "iiiimmmmpppplllleeeemmmmeeeennnntttteeeeddddbbbbyyyy" is  absent,  the  CADP
          tools  will  generate  a  unique  C  identifier for the
          implementation of _S. Nothing  else  should  be  assumed
          about  this  identifier.  In  particular, it may change
          with future versions of the CADP tools.

          The option ----ccccoooommmmmmmmeeeennnnttttssss of the CADP tools emits a  warning
          for each unspecified "iiiimmmmpppplllleeeemmmmeeeennnntttteeeeddddbbbbyyyy" attribute.

          The option ----mmmmaaaapppp of the CADP tools produces a file  that
          gives  the  name  correspondence between abstract LOTOS
          sorts and concrete C types.


     -    The attribute "ccccoooommmmppppaaaarrrreeeeddddbbbbyyyy _N_1",  if  present,  indicates
          that  the  equality  comparison  between  two  abstract



(C) INRIA            Last change: 2020/02/11                   24






CADP MANUAL PAGES                                    LOTOS(LOCAL)



          values of sort _S is implemented by a concrete  C  func-
          tion  (or  macro-definition)  named  _N_1.  This function
          takes two arguments of type _N and returns a  result  of
          type iiiinnnntttt, which is zero if both arguments are equal, or
          non-zero (yet not necessarily one)  if  both  arguments
          are different.

          If the attribute "ccccoooommmmppppaaaarrrreeeeddddbbbbyyyy" is  absent,  a  unique  C
          identifier  is  generated for _N_1, with no other guaran-
          tee.

          Notice that function _N_1 should always  exist,  even  if
          sort  _S  has  no associated comparison operation (e.g.,
          "_e_q :::: _S, _S ---->>>> _B_o_o_l") defined explicitly  in  the  LOTOS
          specification.  Indeed, one must compare values of sort
          _S whenever they occur in equation  premisses  ("_X====_Y  ====>>>>
          ..."),  in  Boolean guards ("[[[[_X====_Y]]]] ---->>>> ..."), or in ren-
          dezvous with value matching ("_G!!!!_X ... |||||||| _G!!!!_Y ...").

          For simple types (e.g., integers or enumerated  types),
          function  _N_1  is often a mere equality test (noted "========"
          in C). However, for more  complex  types,  computations
          may  be  more  involved,  e.g.,  comparison of two real
          numbers up to a given precision, or deep comparison  of
          linked data structures.

          The definition of function _N_1 should always  take  into
          account the cases where one or both of its arguments is
          equal to a bit pattern consisting only of  zeros,  even
          if  such a bit-zero pattern does not normally belong to
          the admissible values of type _N (for instance, if _N  is
          a  pointer  type denoting C character strings, the case
          of the NNNNUUUULLLLLLLL value should nevertheless  be  considered).
          This  is  due  to  the fact that ccccaaaaeeeessssaaaarrrr initializes all
          simulator variables to an undefined  value  represented
          by  a  bit-zero  pattern,  and also resets variables to
          this undefined value as soon  as  they  are  no  longer
          used.


     -    The attribute "iiiitttteeeerrrraaaatttteeeeddddbbbbyyyy _N_2 aaaannnndddd _N_3", if present, indi-
          cates  that the enumeration of all values in the domain
          of sort _S (or in a finite  subset  if  this  domain  is
          infinite  or  too  large)  is implemented by two macro-
          definitions named _N_2 and _N_3 (see above the  section  on
          FINITE-DOMAIN  CONSTRAINTS  for  a discussion on itera-
          tors). The macro _N_2 has no argument and returns a  con-
          stant value of type _N, which is the "first" value to be
          enumerated in the domain of _S. The macro _N_3  takes  one
          argument,  which is an l-value of type _N, and returns a
          result of type iiiinnnntttt; _N_3 tries to advance its argument to
          the  "next" value in the domain of _S and returns a non-



(C) INRIA            Last change: 2020/02/11                   25






CADP MANUAL PAGES                                    LOTOS(LOCAL)



          zero result if such a next  value  exists,  or  a  zero
          result  if the argument was already equal to the "last"
          value in the domain of _S.  Therefore,  enumerating  the
          domain  of  _S can be achieved using the following frag-
          ment of C code:

             _N x;
             x = _N_2;
             ddddoooo {
                ...
             } wwwwhhhhiiiilllleeee (_N_3 (x));

          For an external sort, the iteration macros  _N_2  and  _N_3
          have  to  be  provided  by  the  user in the "....tttt" file.
          Notice that, for the external sorts  _B_i_t,  _B_o_o_l,  _C_h_a_r,
          _I_n_t,  and _N_a_t defined in the "$$$$CCCCAAAADDDDPPPP////lllliiiibbbb////XXXX____****....lllliiiibbbb" files,
          manually-written  iterators   are   provided   in   the
          corresponding           "$$$$CCCCAAAADDDDPPPP////iiiinnnnccccllll////XXXX____****....hhhh"          and
          "$$$$CCCCAAAADDDDPPPP////iiiinnnnccccllll////aaaaddddtttt____****....hhhh" files. For the two  latter  sorts,
          the  bounds of the iterator can be modified by defining
          the  macros  AAAADDDDTTTT____IIIINNNNFFFF____NNNNAAAATTTT,   AAAADDDDTTTT____SSSSUUUUPPPP____NNNNAAAATTTT,   AAAADDDDTTTT____IIIINNNNFFFF____IIIINNNNTTTT,
          and/or AAAADDDDTTTT____SSSSUUUUPPPP____IIIINNNNTTTT before including the "XXXX____****....hhhh" file.

          For a non-external sort,  these  macros  are  generated
          automatically  by  ccccaaaaeeeessssaaaarrrr....aaaaddddtttt if and only if the domain
          of the sort is finite; however, these macros  are  also
          generated  for  numeral  sorts,  even  if the domain of
          these sorts is infinite, but ccccaaaaeeeessssaaaarrrr....aaaaddddtttt  restricts  the
          iterations to a finite range (by default, 0...255).

          Even  when  the  iteration  macros  are  generated   by
          ccccaaaaeeeessssaaaarrrr....aaaaddddtttt,  the  user  can  still  provide alternative
          definitions for these macros (e.g., to  enumerate  only
          prime  numbers below 1000). This can be done by insert-
          ing, in the "....tttt" file, the following directives:

             #undef _N_2
             #define _N_2 ...
             #undef _N_3
             #define _N_3(...) ...

          For numeral sorts, a simpler way to restrict the itera-
          tions  to  the  range  0...(_n-1) is to define the macro
          CCCCAAAAEEEESSSSAAAARRRR____AAAADDDDTTTT____HHHHAAAASSSSHHHH_____N to _n (see below the section  on  SPE-
          CIAL SYMBOLS for details).

          If the attribute "iiiitttteeeerrrraaaatttteeeeddddbbbbyyyy" is absent, unique C iden-
          tifiers  are  generated  for  _N_2  and _N_3, with no other
          guarantee.

          Note: the  attribute  "iiiitttteeeerrrraaaatttteeeeddddbbbbyyyy"  was  introduced  in
          April  2004;  earlier  versions  of the CADP tools used



(C) INRIA            Last change: 2020/02/11                   26






CADP MANUAL PAGES                                    LOTOS(LOCAL)



          another attribute "eeeennnnuuuummmmeeeerrrraaaatttteeeeddddbbbbyyyy" that is now deprecated
          as  it  could not provide iteration for "complex" LOTOS
          sorts.  See  item  #903  in  file  "$$$$CCCCAAAADDDDPPPP////HHHHIIIISSSSTTTTOOOORRRRYYYY"  for
          details  and comparison between old-style and new-style
          iterators.


     -    The attribute "pppprrrriiiinnnntttteeeeddddbbbbyyyy  _N_4",  if  present,  indicates
          that  the  abstract  values  of sort _S can be displayed
          using a concrete C function (or macro-definition) named
          _N_4.  This  function takes two arguments, a POSIX stream
          (of type "FFFFIIIILLLLEEEE ****") and a value of type _N, and returns a
          result  of  type  vvvvooooiiiidddd  (i.e.,  no result at all). This
          function prints the value to the  stream  as  a  human-
          readable  character  string, on a single line and using
          printable characters only (carriage-return or line-feed
          character  are  forbidden, and non-printable characters
          must be escaped).

          If the attribute "pppprrrriiiinnnntttteeeeddddbbbbyyyy"  is  absent,  a  unique  C
          identifier  is  generated for _N_4, with no other guaran-
          tee.

          The definition of function _N_4 should always  take  into
          account  the case where the value to print is undefined
          (i.e., equal to a bit-zero pattern).


     -    The attribute "lllliiiisssstttt", if present, signals that  sort  _S
          is  a  list  data structure and instructs ccccaaaaeeeessssaaaarrrr....aaaaddddtttt to
          generate a  printing  function  _N_4  that  displays  the
          values  of  this  sort  as  lists rather than algebraic
          terms, e.g., "{_x, _y, _y}" rather than "CONS (_x, CONS (_y,
          CONS   (_z,   NIL)))".    See   item   #1475   in   file
          "$$$$CCCCAAAADDDDPPPP////HHHHIIIISSSSTTTTOOOORRRRYYYY" for details.


     -    The  attribute  "eeeexxxxtttteeeerrrrnnnnaaaallll",   if   present,   instructs
          ccccaaaaeeeessssaaaarrrr....aaaaddddtttt  not  to generate C code for _S, which has to
          be implemented manually.  For this sort, the user  must
          provide,  in  the "....tttt" file, the corresponding C type _N
          that implements _S,  the  comparison  function  _N_1,  the
          iteration  macros _N_2 and _N_3 (if needed), and the print-
          ing function _N_4.

          If a sort is declared to be  external,  the  attributes
          "iiiimmmmpppplllleeeemmmmeeeennnntttteeeeddddbbbbyyyy",    "ccccoooommmmppppaaaarrrreeeeddddbbbbyyyy",    "iiiitttteeeerrrraaaatttteeeeddddbbbbyyyy"   (if
          needed), and "pppprrrriiiinnnntttteeeeddddbbbbyyyy" should be present, so that the
          names  _N,  ... _N_4 are fixed and will not change even if
          the LOTOS specification is  modified  or  if  the  CADP
          tools are upgraded to a new version.




(C) INRIA            Last change: 2020/02/11                   27






CADP MANUAL PAGES                                    LOTOS(LOCAL)



          Other constraints on external sorts  have  been  listed
          above  in the section entitled CONSTRAINTS ON SORTS AND
          CONSTRUCTORS.


  SSSSPPPPEEEECCCCIIIIAAAALLLL CCCCOOOOMMMMMMMMEEEENNNNTTTTSSSS FFFFOOOORRRR OOOOPPPPEEEERRRRAAAATTTTIIIIOOOONNNNSSSS
     A special comment attached to the  declaration  of  a  LOTOS
     operation  _F has the following syntax (where square brackets
     mean optional elements):

        ((((****!!!!
           [ iiiimmmmpppplllleeeemmmmeeeennnntttteeeeddddbbbbyyyy _N ]
           [ ccccoooonnnnssssttttrrrruuuuccccttttoooorrrr ]
           [ eeeexxxxtttteeeerrrrnnnnaaaallll ]
        ****))))


     where _N is a valid C identifier.  Even if these elements are
     optional, their order cannot be modified.  Spaces and blanks
     are allowed inside special  comments.  All  letters  in  the
     words  "iiiimmmmpppplllleeeemmmmeeeennnntttteeeeddddbbbbyyyy",  "ccccoooonnnnssssttttrrrruuuuccccttttoooorrrr",  "eeeexxxxtttteeeerrrrnnnnaaaallll"  can  be
     either in lower or upper case; it  is  advised  to  use  the
     lower case only.


     The meaning of special comments is the following:


     -    The attribute "iiiimmmmpppplllleeeemmmmeeeennnntttteeeeddddbbbbyyyy _N", if present,  indicates
          that the abstract LOTOS operation _F is implemented by a
          concrete C function or macro-definition named  _N.   The
          parameters  and  result  of  _N  must be compatible with
          those of _F.

          If _F is a LOTOS constant (i.e., an operation with arity
          zero)  and if _N is a C macro-definition, then _N must be
          defined to be followed by  parentheses  surrounding  an
          empty  list  of arguments, so that any call to _N should
          be written "_N()" rather than "_N".

          If the attribute "iiiimmmmpppplllleeeemmmmeeeennnntttteeeeddddbbbbyyyy" is  absent,  the  CADP
          tools  will  generate  a  unique  C  identifier for the
          implementation of _F. Nothing  else  should  be  assumed
          about  this  identifier.  In  particular, it may change
          with future versions of the CADP tools.

          The option ----ccccoooommmmmmmmeeeennnnttttssss of the CADP tools emits a  warning
          for each unspecified "iiiimmmmpppplllleeeemmmmeeeennnntttteeeeddddbbbbyyyy" attribute.

          The option ----mmmmaaaapppp of the CADP tools produces a file  that
          gives  the  name  correspondence between abstract LOTOS
          operations and concrete C functions.



(C) INRIA            Last change: 2020/02/11                   28






CADP MANUAL PAGES                                    LOTOS(LOCAL)



     -    The  attribute  "ccccoooonnnnssssttttrrrruuuuccccttttoooorrrr",  if  present,  instructs
          ccccaaaaeeeessssaaaarrrr....aaaaddddtttt  that  _F  is a constructor operation. Other-
          wise,  ccccaaaaeeeessssaaaarrrr....aaaaddddtttt  will  assume  that  _F  is   a   non-
          constructor,   i.e.,  an  operation  whose  meaning  is
          defined by the algebraical equations contained  in  the
          LOTOS specification.


     -    The  attribute  "eeeexxxxtttteeeerrrrnnnnaaaallll",   if   present,   instructs
          ccccaaaaeeeessssaaaarrrr....aaaaddddtttt  not  to generate C code for _F, which has to
          be implemented manually.

          If _F is a non-constructor, the user  must  provide,  in
          the  "....ffff"  file, the corresponding C function or macro-
          definition _N that implements _F.

          If _F is a constructor, the user must  provide,  in  the
          "....tttt"  file,  the  corresponding  C  function  or macro-
          definition _N that implements _F, a  _t_e_s_t_e_r  function  _N_0
          taking  one  argument  _x of type _N and returning a non-
          zero result if _x matches at its top level the construc-
          tor _F, and _n _s_e_l_e_c_t_o_r functions _N_1, ..., _N_n (where _n is
          the arity of _F) taking one argument _x of  type  _N  that
          satisfies  _N_0 (_x) != 0 and returning, respectively, the
          values _x_1, ..., _x_n such that _x = _N (_x_1, ..., _x_n).

          If an operation is declared to be external, the  attri-
          bute  "iiiimmmmpppplllleeeemmmmeeeennnntttteeeeddddbbbbyyyy"  should  be  present, so that the
          name _N of the implementation  is  fixed  and  will  not
          change  even  if the LOTOS specification is modified or
          if the CADP tools are upgraded to a new version.

          If the operation is a  constructor,  attributes  should
          exist  for  fixing the names of the tester and selector
          functions, but such attributes are not implemented yet.

          Other constraints on external sorts  have  been  listed
          above  in  the  section  entitled  CONSTRAINTS  ON NON-
          CONSTRUCTORS AND EQUATIONS.


SSSSIIIIDDDDEEEE EEEEFFFFFFFFEEEECCCCTTTTSSSS IIIINNNN EEEEXXXXTTTTEEEERRRRNNNNAAAALLLL FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNNSSSS
     As a general principle, any C function implementing a  (con-
     structor or non-constructor) LOTOS operation should not per-
     form side effects because these are not present in the  for-
     mal semantics of LOTOS abstract data types.

     When the manually-written C code is to be used together with
     ccccaaaaeeeessssaaaarrrr  (i.e.,  mixed with C code automatically generated by
     ccccaaaaeeeessssaaaarrrr for state-space  exploration),  the  above  principle
     holds  quite strictly. In practice, side effects may be pos-
     sible but only under very  limited  forms:   allocating  new



(C) INRIA            Last change: 2020/02/11                   29






CADP MANUAL PAGES                                    LOTOS(LOCAL)



     memory cells, storing data values in a unique way using hash
     tables, or writing information to files (e.g., traces on log
     files).  All  other forms of side effects are prohibited. In
     particular, certain optimizations performed  by  ccccaaaaeeeessssaaaarrrr  may
     become incorrect in presence of external functions with side
     effects.


     When the manually-written C code is not to be used with ccccaaaaeeee----
     ssssaaaarrrr, the aforementioned prohibition can be relaxed, so as to
     obtain the same features as monads in functional  languages.
     It becomes even possible to provide manually-written C func-
     tions that keep  internal  variables  or  modify  previously
     allocated  data structures (e.g., update certain fields of a
     linked list).

     This is a risky practice that requires care and insight.  An
     example of monads can be found by inspecting the _A_C_T_I_O_N type
     declared  in  "$$$$CCCCAAAADDDDPPPP////lllliiiibbbb////XXXX____AAAACCCCTTTTIIIIOOOONNNN....lllliiiibbbb"  and  implemented  in
     "$$$$CCCCAAAADDDDPPPP////iiiinnnnccccllll////XXXX____AAAACCCCTTTTIIIIOOOONNNN....hhhh".


CCCCAAAALLLLLLLL----BBBBYYYY----NNNNEEEEEEEEDDDD EEEEVVVVAAAALLLLUUUUAAAATTTTIIIIOOOONNNN IIIINNNN EEEEXXXXTTTTEEEERRRRNNNNAAAALLLL FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNNSSSS
     When implemented manually as  C  macro-definitions,  certain
     LOTOS  operations  can  avoid  the  call-by-value  semantics
     enforced by ccccaaaaeeeessssaaaarrrr....aaaaddddtttt (i.e.,  the  actual  arguments  of  a
     function  are always evaluated before calling this function)
     and rely on call-by-need semantics instead.

     A first example is given by the _a_n_d__t_h_e_n and _o_r__e_l_s_e  opera-
     tors  declared  in $$$$CCCCAAAADDDDPPPP////lllliiiibbbb////XXXX____BBBBOOOOOOOOLLLLEEEEAAAANNNN....lllliiiibbbb". These operators
     are  implemented  in  "$$$$CCCCAAAADDDDPPPP////iiiinnnnccccllll////XXXX____BBBBOOOOOOOOLLLLEEEEAAAANNNN....hhhh"   as   macro-
     definitions  that  expand  to the C operators "&&&&&&&&" and "||||||||".
     Depending on the value of their first argument, these opera-
     tors  may  skip evaluating their second argument (performing
     so-called "short-circuits").

     A second example is given by the  _i_f__t_h_e_n  and  _i_f__t_h_e_n__e_l_s_e
     operators declared in "$$$$CCCCAAAADDDDPPPP////lllliiiibbbb////XXXX____AAAACCCCTTTTIIIIOOOONNNN....lllliiiibbbb". These opera-
     tors are implemented in  "$$$$CCCCAAAADDDDPPPP////iiiinnnnccccllll////XXXX____AAAACCCCTTTTIIIIOOOONNNN....hhhh"  as  macro-
     definitions   that   expand   to   the  C  ternary  operator
     "(...????...::::...)". The value of the first argument  determines
     which one of the remaining arguments will be evaluated.


MMMMEEEEMMMMOOOORRRRYYYY CCCCOOOONNNNCCCCEEEERRRRNNNNSSSS WWWWIIIITTTTHHHH DDDDAAAATTTTAAAA TTTTYYYYPPPPEEEESSSS
     Saving memory is of utmost importance when  using  verifica-
     tion  techniques based on state-space exploration. This sec-
     tion presents some effective ways to save memory when  using
     LOTOS abstract data types with the CADP tools.





(C) INRIA            Last change: 2020/02/11                   30






CADP MANUAL PAGES                                    LOTOS(LOCAL)



     Let _C be a constructor that may allocate memory when invoked
     (for  instance, _C can be the _c_o_n_s operator of linked lists).
     Any call to _C in the patterns on the left-hand  side  of  an
     equation will not allocate memory. However, any call to _C in
     a premiss or on the right-hand  side  of  an  equation  will
     allocate  memory,  so one should be careful about such calls
     if memory space needs to be optimized.


     Dynamically-allocated data types are expensive. By  default,
     ccccaaaaeeeessssaaaarrrr....aaaaddddtttt  tries  to reduce their use by introducing as few
     pointer types as  needed  in  the  generated  C  code,  only
     resorting  to  pointers  where  they  are necessary to break
     dependencies between circular types, or where the  user  has
     explicitly  asked  for  pointers  (see the CCCCAAAAEEEESSSSAAAARRRR____AAAADDDDTTTT____HHHHAAAASSSSHHHH_____N
     symbol below).


     For a dynamically-allocated type that needs pointers  (e.g.,
     a  list  type),  the  user  can  request  (still  using  the
     CCCCAAAAEEEESSSSAAAARRRR____AAAADDDDTTTT____HHHHAAAASSSSHHHH_____N symbol) to store all the  values  of  this
     type in a hash table, meaning that each value is represented
     by its index in the table. Different  types  have  different
     hash  tables,  meaning  that  the  sizes  of  tables and the
     numbers of bits for indexes  can  be  tuned  for  each  type
     independently.  The  user  has to predict a maximal size for
     each table, i.e., an upper bound on  the  number  of  values
     that  will  be inserted. The advantages of this approach are
     twofold:  (i) memory consumption is  significantly  reduced,
     as identical values are stored in memory only once; and (ii)
     the CPU overhead required for insertion and lookup  in  hash
     tables  is  usually  compensated  by  the  gain in comparing
     values, because only indexes have to be compared (it  is  no
     longer  necessary to perform "deep" structural comparison of
     algebraic terms). Because the  "ccccaaaaeeeessssaaaarrrr____ttttaaaabbbblllleeee____1111"  library  of
     OPEN/CAESAR  is  used  to handle these hash tables, any "....hhhh"
     file generated by ccccaaaaeeeessssaaaarrrr....aaaaddddtttt must be linked, if it uses hash
     tables,  against  the  "lllliiiibbbbccccaaaaeeeessssaaaarrrr....aaaa"  library of OPEN/CAESAR
     and, possibly, the complement library "lllliiiibbbbccccaaaaeeeessssaaaarrrr____pppplllluuuugggg....aaaa".


     Finally,  for  dynamically-allocated  types  not  stored  in
     tables,  it is also possible to activate a conservative gar-
     bage collector,  using  the  "CCCCAAAAEEEESSSSAAAARRRR____AAAADDDDTTTT____GGGGAAAARRRRBBBBAAAAGGGGEEEE____CCCCOOOOLLLLLLLLEEEECCCCTTTTIIIIOOOONNNN"
     macro defined below.


SSSSPPPPEEEECCCCIIIIAAAALLLL SSSSYYYYMMMMBBBBOOOOLLLLSSSS UUUUSSSSEEEEDDDD IIIINNNN TTTTHHHHEEEE CCCC CCCCOOOODDDDEEEE
     A number of variables, functions, and macro-definitions  may
     or  must be used to exploit at its best the C code generated
     by ccccaaaaeeeessssaaaarrrr....aaaaddddtttt.  Here are the  most  important  ones,  sorted
     into different categories.



(C) INRIA            Last change: 2020/02/11                   31






CADP MANUAL PAGES                                    LOTOS(LOCAL)



  VVVVEEEERRRRSSSSIIIIOOOONNNN CCCCHHHHEEEECCCCKKKKIIIINNNNGGGG
     The four following symbols are used for checking versions:


     CCCCAAAAEEEESSSSAAAARRRR____AAAADDDDTTTT
          This macro is defined in any  "....hhhh"  file  generated  by
          ccccaaaaeeeessssaaaarrrr....aaaaddddtttt  and  is  equal  to  the  version  number of
          ccccaaaaeeeessssaaaarrrr....aaaaddddtttt (e.g., 5.4) at the time the  file  was  pro-
          duced. This macro can be consulted in the "....ffff" and "....tttt"
          files written by the user.


     CCCCAAAAEEEESSSSAAAARRRR____AAAADDDDTTTT____EEEEXXXXPPPPEEEERRRRTTTT
          In any "....hhhh" file not generated by ccccaaaaeeeessssaaaarrrr....aaaaddddtttt  and  con-
          taining manually-written C code to be used with ccccaaaaeeeessssaaaarrrr,
          the user should insert a macro-definition of  the  fol-
          lowing form:
               ####ddddeeeeffffiiiinnnneeee CCCCAAAAEEEESSSSAAAARRRR____AAAADDDDTTTT____EEEEXXXXPPPPEEEERRRRTTTT x.y
          where x.y is the version number of  ccccaaaaeeeessssaaaarrrr....aaaaddddtttt  at  the
          time  the  file  was  written.  ccccaaaaeeeessssaaaarrrr  will check this
          number  and,  should  the  conventions  evolve  in  the
          future, use it to ensure backward compatibility or warn
          about deprecated contents. See items #622 and #1033  in
          file "$$$$CCCCAAAADDDDPPPP////HHHHIIIISSSSTTTTOOOORRRRYYYY" for details.


     CCCCAAAAEEEESSSSAAAARRRR____AAAADDDDTTTT____EEEEXXXXPPPPEEEERRRRTTTT____FFFF
          In any "....ffff" file,  the  user  should  insert  a  macro-
          definition of the following form:
               ####ddddeeeeffffiiiinnnneeee CCCCAAAAEEEESSSSAAAARRRR____AAAADDDDTTTT____EEEEXXXXPPPPEEEERRRRTTTT____FFFF x.y
          where x.y is the version number of  ccccaaaaeeeessssaaaarrrr....aaaaddddtttt  at  the
          time  the  file was written. ccccaaaaeeeessssaaaarrrr and ccccaaaaeeeessssaaaarrrr....aaaaddddtttt will
          check this number and, should the conventions evolve in
          the  future, use it to ensure backward compatibility or
          warn about deprecated  contents.  See  items  #622  and
          #1033 in file "$$$$CCCCAAAADDDDPPPP////HHHHIIIISSSSTTTTOOOORRRRYYYY" for details.


     CCCCAAAAEEEESSSSAAAARRRR____AAAADDDDTTTT____EEEEXXXXPPPPEEEERRRRTTTT____TTTT
          In any "....tttt" file,  the  user  should  insert  a  macro-
          definition of the following form:
               ####ddddeeeeffffiiiinnnneeee CCCCAAAAEEEESSSSAAAARRRR____AAAADDDDTTTT____EEEEXXXXPPPPEEEERRRRTTTT____TTTT x.y
          where x.y is the version number of  ccccaaaaeeeessssaaaarrrr....aaaaddddtttt  at  the
          time  the  file was written. ccccaaaaeeeessssaaaarrrr and ccccaaaaeeeessssaaaarrrr....aaaaddddtttt will
          check this number and, should the conventions evolve in
          the  future, use it to ensure backward compatibility or
          warn about deprecated  contents.  See  items  #622  and
          #1033 in file "$$$$CCCCAAAADDDDPPPP////HHHHIIIISSSSTTTTOOOORRRRYYYY" for details.


  IIIINNNNTTTTEEEERRRRFFFFAAAACCCCIIIINNNNGGGG
     The following symbol determines the usage of a "....hhhh" file:



(C) INRIA            Last change: 2020/02/11                   32






CADP MANUAL PAGES                                    LOTOS(LOCAL)



     CCCCAAAAEEEESSSSAAAARRRR____AAAADDDDTTTT____IIIINNNNTTTTEEEERRRRFFFFAAAACCCCEEEE
          The "....hhhh" file generated by  ccccaaaaeeeessssaaaarrrr....aaaaddddtttt  often  contains
          more  than mere interface declarations, as it also con-
          tains definitions of variables and functions. Thus, the
          "....hhhh" file can be included only once, in one single "....cccc"
          file, otherwise double definitions will ensue at  link-
          edit  time.  The  CCCCAAAAEEEESSSSAAAARRRR____AAAADDDDTTTT____IIIINNNNTTTTEEEERRRRFFFFAAAACCCCEEEE macro-definition
          addresses this issue. If this macro is  defined  before
          including the "....hhhh" file, i.e.:
               ####ddddeeeeffffiiiinnnneeee CCCCAAAAEEEESSSSAAAARRRR____AAAADDDDTTTT____IIIINNNNTTTTEEEERRRRFFFFAAAACCCCEEEE
               ####iiiinnnncccclllluuuuddddeeee """"_f_i_l_e_n_a_m_e....hhhh""""
          only   the   interface   declarations   contained    in
          "_f_i_l_e_n_a_m_e....hhhh"  will  be  included. See item #859 in file
          "$$$$CCCCAAAADDDDPPPP////HHHHIIIISSSSTTTTOOOORRRRYYYY" for details.


  IIIINNNNIIIITTTTIIIIAAAALLLLIIIIZZZZAAAATTTTIIIIOOOONNNN AAAANNNNDDDD TTTTEEEERRRRMMMMIIIINNNNAAAATTTTIIIIOOOONNNN
     The two following symbols perform initialization and  termi-
     nation:


     CCCCAAAAEEEESSSSAAAARRRR____AAAADDDDTTTT____IIIINNNNIIIITTTT(((())))
          The "....hhhh" file generated by ccccaaaaeeeessssaaaarrrr....aaaaddddtttt defines  a  func-
          tion  named  CCCCAAAAEEEESSSSAAAARRRR____AAAADDDDTTTT____IIIINNNNIIIITTTT(((())))  that  must  be  invoked
          before using any other primitive contained in the  "....hhhh"
          file.   See  items  #212,  #1253,  and  #1914  in  file
          "$$$$CCCCAAAADDDDPPPP////HHHHIIIISSSSTTTTOOOORRRRYYYY" for details.


     CCCCAAAAEEEESSSSAAAARRRR____AAAADDDDTTTT____TTTTEEEERRRRMMMM((((............))))
          The "....hhhh" file generated by ccccaaaaeeeessssaaaarrrr....aaaaddddtttt defines  a  func-
          tion  named  CCCCAAAAEEEESSSSAAAARRRR____AAAADDDDTTTT____TTTTEEEERRRRMMMM(((()))) that can be (optionally)
          invoked by the user when the other primitives contained
          in  the  "....hhhh"  file  will  not be called any more. This
          function takes a single parameter of type "FFFFIIIILLLLEEEE ****" and,
          if  this parameter is not NNNNUUUULLLLLLLL, prints to this file the
          contents of the hash tables for which the user has pro-
          vided    a    format    by   means   of   the   symbols
          CCCCAAAAEEEESSSSAAAARRRR____AAAADDDDTTTT____FFFFOOOORRRRMMMMAAAATTTT_____N or CCCCAAAAEEEESSSSAAAARRRR____AAAADDDDTTTT____FFFFOOOORRRRMMMMAAAATTTT defined below.
          This  function  then  deletes all the hash tables allo-
          cated in memory. See item #1250 in file "$$$$CCCCAAAADDDDPPPP////HHHHIIIISSSSTTTTOOOORRRRYYYY"
          for details.


  TTTTYYYYPPPPEEEE TTTTUUUUNNNNIIIINNNNGGGG
     The following symbols enable the representation of types  to
     be modified:


     AAAADDDDTTTT____BBBBIIIITTTTSSSS____NNNNAAAATTTT
          If defined to a natural value _n  before  including  the
          file   "$$$$CCCCAAAADDDDPPPP////iiiinnnnccccllll////XXXX____NNNNAAAATTTTUUUURRRRAAAALLLL....hhhh"   that  implements  the



(C) INRIA            Last change: 2020/02/11                   33






CADP MANUAL PAGES                                    LOTOS(LOCAL)



          natural numbers defined in the "XXXX____NNNNAAAATTTTUUUURRRRAAAALLLL....lllliiiibbbb" library,
          this  macro  indicates  that natural numbers are imple-
          mented  on  _n  bits  only.  See  item  #1584  in   file
          "$$$$CCCCAAAADDDDPPPP////HHHHIIIISSSSTTTTOOOORRRRYYYY" for details.


     AAAADDDDTTTT____BBBBIIIITTTTSSSS____IIIINNNNTTTT
          If defined to a natural value _n  before  including  the
          file   "$$$$CCCCAAAADDDDPPPP////iiiinnnnccccllll////XXXX____IIIINNNNTTTTEEEEGGGGEEEERRRR....hhhh"   that  implements  the
          integer numbers defined in the "XXXX____IIIINNNNTTTTEEEEGGGGEEEERRRR....lllliiiibbbb" library,
          this  macro  indicates  that integer numbers are imple-
          mented  on  _n  bits  only.  See  item  #1584  in   file
          "$$$$CCCCAAAADDDDPPPP////HHHHIIIISSSSTTTTOOOORRRRYYYY" for details.


     CCCCAAAAEEEESSSSAAAARRRR____AAAADDDDTTTT____BBBBIIIITTTTSSSS_____N
          If defined, this macro indicates  that  the  C  type  _N
          implementing  some  LOTOS sort _S can be stored as a bit
          field in a C struct or union type.  The  value  of  the
          macro should have the following form ": _n" (without the
          surrounding double quotes), where _n is  the  number  of
          bits  needed for representing type _N, knowing that _n <=
          ssssiiiizzzzeeeeooooffff (_N).  For  non-external  sorts,  this  macro  is
          automatically  defined by ccccaaaaeeeessssaaaarrrr....aaaaddddtttt, and, for external
          sorts, it can be manually defined by the  user  in  the
          "....tttt"   file;  forgetting  to  define  this  macro  when
          appropriate is harmless though less efficient, as  more
          memory will be used than needed.


     CCCCAAAAEEEESSSSAAAARRRR____AAAADDDDTTTT____HHHHAAAASSSSHHHH_____N
          If defined by the user in the "....tttt" file as  an  integer
          value  _n,  this  macro specifies the way in which the C
          type _N implementing a LOTOS sort _S must be defined.  If
          _S  is  not  external,  then ccccaaaaeeeessssaaaarrrr....aaaaddddtttt takes this macro
          into account to generate the C code for type _N. If _S is
          external, then ccccaaaaeeeessssaaaarrrr....aaaaddddtttt takes this macro into account
          to implement or optimize the  sorts  that  transitively
          depend on _S.

          Setting _n > 1 means that  the  values  of  sort  _S  are
          stored  in a hash table that can contain at most _n ele-
          ments. Type _N will be implemented as an  index  ranging
          between  0  and  (_n-1) that gives access to this table.
          ccccaaaaeeeessssaaaarrrr....aaaaddddtttt checks that the value of _n is not too large.
          _S  should  be  a  tuple, an ordinary, an external, or a
          numeral sort (the latter case will be detailed  below).
          If  _S  is a singleton or an enumeration sort, a warning
          will be emitted and the definition of CCCCAAAAEEEESSSSAAAARRRR____AAAADDDDTTTT____HHHHAAAASSSSHHHH_____N
          will be ignored.  If the limit of _n values is exceeded,
          the execution will stop with a  SSSSIIIIGGGGTTTTEEEERRRRMMMM  signal  unless
          the  user has specified a different error handler using



(C) INRIA            Last change: 2020/02/11                   34






CADP MANUAL PAGES                                    LOTOS(LOCAL)



          the CCCCAAAAEEEESSSSAAAARRRR____AAAADDDDTTTT____OOOOVVVVEEEERRRRFFFFLLLLOOOOWWWW_____N macro defined below.

          Setting _n < 0 means that  the  values  of  sort  _S  are
          stored  in a hash table that can contain at most (2^-_n)
          elements. This case is similar  to  the  previous  one,
          noticing  that  values of type _N will be implemented on
          (-_n) bits exactly. ccccaaaaeeeessssaaaarrrr....aaaaddddtttt checks that the value  of
          _n is not too small.

          Setting _n = 1 means that the values of sort _S should be
          implemented  using  pointers  to  structs  or to unions
          (i.e., they should  have  a  _b_o_x_e_d  representation).  _S
          should  be a tuple, an ordinary, or a numeral sort (the
          latter case will be detailed below). If _S is a  single-
          ton,  an  enumeration,  or  an external sort, a warning
          will be emitted and the definition of CCCCAAAAEEEESSSSAAAARRRR____AAAADDDDTTTT____HHHHAAAASSSSHHHH_____N
          will be ignored.

          Setting _n = 0 means that the values of  sort  _S  should
          neither  be  implemented  using  pointers  (i.e.,  they
          should have an _u_n_b_o_x_e_d representation) nor be stored in
          a  hash  table. _S can be a singleton, an enumeration, a
          tuple, or an ordinary sort; in the two latter cases, an
          error is reported if there are cyclic dependencies that
          cannot be resolved by  introducing  pointers  or  table
          indexes  because  the  user  has  forbidden to do so by
          requiring _n = 0 for the mutually recursive types. If  _S
          is  a numeral, an error message is also emitted as hav-
          ing _n = 0 would be meaningless. If  _S  is  an  external
          sort,  taking  _n  =  0  has  no  effect  and is ignored
          silently.

          As a  consequence  of  the  above,  for  singleton  and
          enumeration  sorts,  the CCCCAAAAEEEESSSSAAAARRRR____AAAADDDDTTTT____HHHHAAAASSSSHHHH_____N macro should
          either be undefined or have its value _n set to zero.

          In the case of numeral sorts,  hash  tables  are  never
          used, whatever which value is given to _n. Setting _n > 0
          means that type _N will represent  the  natural  numbers
          ranging  between 0 and (_n-1).  Setting _n < 0 means that
          type _N will represent the natural numbers coded on (-_n)
          bits.

          Finally, if the CCCCAAAAEEEESSSSAAAARRRR____AAAADDDDTTTT____HHHHAAAASSSSHHHH_____N macro  is  undefined,
          ccccaaaaeeeessssaaaarrrr....aaaaddddtttt  automatically  chooses the most appropriate
          implementation corresponding to either _n = 0 or _n =  1;
          ccccaaaaeeeessssaaaarrrr....aaaaddddtttt will do its best efforts to avoid implement-
          ing _N as a pointer type (i.e., choosing _n =  0)  unless
          this  is necessary to break circular type dependencies.
          Hence, by default, no LOTOS sort will  have  its  value
          stored in a hash table unless specifically requested by
          the user.



(C) INRIA            Last change: 2020/02/11                   35






CADP MANUAL PAGES                                    LOTOS(LOCAL)



          See items #623,  #1250,  #1251,  #1255,  #1332,  #1435,
          #1494, and #1498 in file "$$$$CCCCAAAADDDDPPPP////HHHHIIIISSSSTTTTOOOORRRRYYYY" for details.


     CCCCAAAAEEEESSSSAAAARRRR____AAAADDDDTTTT____HHHHAAAASSSSHHHH____AAAADDDDTTTT____SSSSTTTTRRRRIIIINNNNGGGG
          If defined to an integer value _n before  including  the
          file   "$$$$CCCCAAAADDDDPPPP////iiiinnnnccccllll////XXXX____SSSSTTTTRRRRIIIINNNNGGGG....hhhh"   that   implements  the
          (variable-length)  character  strings  defined  in  the
          "XXXX____SSSSTTTTRRRRIIIINNNNGGGG....lllliiiibbbb"  library,  this  macro  modifies the way
          strings are stored in memory. By default,  strings  are
          allocated  dynamically  using  mmmmaaaalllllllloooocccc(((()))),  which  can be
          memory-inefficient. If _n > 1, strings are stored  in  a
          hash  table  with  _n entries at most. If _n < 0, strings
          are stored in a hash table with 2^(-_n) entries at most.
          See item #1495 in file "$$$$CCCCAAAADDDDPPPP////HHHHIIIISSSSTTTTOOOORRRRYYYY" for details.


     CCCCAAAAEEEESSSSAAAARRRR____AAAADDDDTTTT____SSSSCCCCAAAALLLLAAAARRRR_____N
          If defined, this macro indicates that  the  constant  0
          belongs to the C type _N implementing some LOTOS sort _S,
          so that variables of this type can be reset  simply  by
          assigning  zero  to  them.  In  the  C  language,  this
          corresponds to the usual notion of _s_c_a_l_a_r  type,  which
          includes (signed and unsigned) integers and characters,
          reals,  enums,  and  pointers,  but  excludes   arrays,
          structs, and unions. For non-external sorts, this macro
          is automatically defined by ccccaaaaeeeessssaaaarrrr....aaaaddddtttt, and, for exter-
          nal  sorts,  it  can be manually defined by the user in
          the "....tttt" file; forgetting to  define  this  macro  when
          appropriate  is  usually  harmless though slightly less
          efficient, as variables will be reset using a  call  to
          mmmmeeeemmmmsssseeeetttt(((()))) rather than an assignment; however, the proper
          definition of this macro for external sorts is required
          when  using  the  ----eeeexxxxtttteeeerrrrnnnnaaaallll  option of CAESAR. See item
          #493 in file "$$$$CCCCAAAADDDDPPPP////HHHHIIIISSSSTTTTOOOORRRRYYYY" for details.


     CCCCAAAAEEEESSSSAAAARRRR____AAAADDDDTTTT____UUUUNNNNCCCCAAAANNNNOOOONNNNIIIICCCCAAAALLLL_____N
          If defined, this macro indicates that the values of the
          C  type  _N  implementing  some  LOTOS  sort  _S  are not
          represented under a canonical form,  meaning  that  two
          concrete  C values stored in memory using two different
          bit strings may still denote the  same  abstract  LOTOS
          value. This can occur if _N is a pointer type (e.g., two
          pointers referring to two different memory cells having
          the same contents), but in other cases as well (e.g., a
          struct or union type with  uninitialized  padding  bits
          between  its fields, or a struct or union type contain-
          ing pointer fields, and so on  recursively).  For  non-
          external  sorts, this macro is automatically defined by
          ccccaaaaeeeessssaaaarrrr....aaaaddddtttt, and, for external sorts, it must  be  manu-
          ally  defined  by the user in the "....tttt" file; forgetting



(C) INRIA            Last change: 2020/02/11                   36






CADP MANUAL PAGES                                    LOTOS(LOCAL)



          to define this macro when appropriate is harmful as  it
          leads  to  incorrect  comparison  and  hashing  on  bit
          strings. For this reason, the values  of  non-canonical
          sorts  should never be stored in hash tables. See items
          #623 and #1494 in file "$$$$CCCCAAAADDDDPPPP////HHHHIIIISSSSTTTTOOOORRRRYYYY" for details.


     CCCCAAAAEEEESSSSAAAARRRR____AAAADDDDTTTT____CCCCOOOOLLLLLLLLIIIISSSSIIIIOOOONNNNSSSS_____N

     CCCCAAAAEEEESSSSAAAARRRR____AAAADDDDTTTT____CCCCOOOOLLLLLLLLIIIISSSSIIIIOOOONNNNSSSS
          These two macros can be used to reduce the memory  size
          of  the  hash  table storing the values of the C type _N
          that implements some  LOTOS  sort.   By  default,  this
          table has as many hash entries as its maximal number of
          elements specified using the  CCCCAAAAEEEESSSSAAAARRRR____AAAADDDDTTTT____HHHHAAAASSSSHHHH_____N  macro,
          meaning  that  the average length of collision lists is
          expected to be one if the table is entirely filled. The
          number  of hash entries can be reduced, thus decreasing
          memory while potentially increasing access time. If the
          former  macro,  or  else the latter macro is defined in
          the "....tttt" file as an integer value _n >= 1, the number of
          hash  entries  will  be  the maximal number of elements
          divided by _n, meaning that the average length of colli-
          sion lists is expected to be _n if the table is entirely
          filled. The latter macro applies  to  all  types  whose
          values  are  stored in hash tables, but it is overriden
          by the former macro as far as type _N is concerned.  See
          item #1250 in file "$$$$CCCCAAAADDDDPPPP////HHHHIIIISSSSTTTTOOOORRRRYYYY" for details.


     CCCCAAAAEEEESSSSAAAARRRR____AAAADDDDTTTT____CCCCRRRREEEEAAAATTTTEEEE_____N(((())))

     CCCCAAAAEEEESSSSAAAARRRR____AAAADDDDTTTT____DDDDEEEELLLLEEEETTTTEEEE_____N(((())))

     CCCCAAAAEEEESSSSAAAARRRR____AAAADDDDTTTT____SSSSHHHHOOOOWWWW_____N((((............))))
          For each external LOTOS sort S implemented by a C  type
          _N,  if  the  user  has  specified (by setting the macro
          CCCCAAAAEEEESSSSAAAARRRR____AAAADDDDTTTT____CCCCRRRREEEEAAAATTTTEEEE_____N to a value different from 0 and  1)
          that the values of type _N are canonical and stored in a
          hash table, the user has to implement this table  manu-
          ally  and  provide  the corresponding implementation in
          the "....tttt" file; ccccaaaaeeeessssaaaarrrr....aaaaddddtttt cannot generate code for this
          table  because  the implementation in C of the elements
          of this table is not  known  at  the  LOTOS  level;  to
          implement   this   table,   the   user  may  reuse  the
          ccccaaaaeeeessssaaaarrrr____ttttaaaabbbblllleeee____1111 library of OPEN/CAESAR.  Whatever  which
          implementation  is  chosen for the table, the user must
          provide, in the "....tttt" file,  the  three  above  symbols,
          which  must be implemented as macro-definitions, not as
          functions.  The two former macros respectively allocate
          and  deallocate the hash table; the latter macro prints
          the table contents  to  a  file  pointer  passed  as  a



(C) INRIA            Last change: 2020/02/11                   37






CADP MANUAL PAGES                                    LOTOS(LOCAL)



          parameter.     These     macros    are    invoked    by
          CCCCAAAAEEEESSSSAAAARRRR____AAAADDDDTTTT____IIIINNNNIIIITTTT(((()))) and  CCCCAAAAEEEESSSSAAAARRRR____AAAADDDDTTTT____TTTTEEEERRRRMMMM(((()))).  Examples  of
          such  macros  based  upon the ccccaaaaeeeessssaaaarrrr____ttttaaaabbbblllleeee____1111 library of
          OPEN/CAESAR can be found by examining  the  definitions
          of                      CCCCAAAAEEEESSSSAAAARRRR____AAAADDDDTTTT____CCCCRRRREEEEAAAATTTTEEEE____AAAADDDDTTTT____SSSSTTTTRRRRIIIINNNNGGGG(((()))),
          CCCCAAAAEEEESSSSAAAARRRR____AAAADDDDTTTT____DDDDEEEELLLLEEEETTTTEEEE____AAAADDDDTTTT____SSSSTTTTRRRRIIIINNNNGGGG(((()))),                     and
          CCCCAAAAEEEESSSSAAAARRRR____AAAADDDDTTTT____SSSSHHHHOOOOWWWW____AAAADDDDTTTT____SSSSTTTTRRRRIIIINNNNGGGG(((())))      given     in     file
          "$$$$CCCCAAAADDDDPPPP////iiiinnnnccccllll////XXXX____SSSSTTTTRRRRIIIINNNNGGGG....hhhh".  See  item   #1498   in   file
          "$$$$CCCCAAAADDDDPPPP////HHHHIIIISSSSTTTTOOOORRRRYYYY" for details.


  VVVVAAAALLLLUUUUEEEE PPPPRRRRIIIINNNNTTTTIIIINNNNGGGG
     The following symbols modify the way terms can be printed:


     CCCCAAAAEEEESSSSAAAARRRR____AAAADDDDTTTT____IIIINNNNFFFFIIIIXXXX
          If defined, this macro indicates that the  values  con-
          taining constructor operations declared as infix in the
          LOTOS specification (i.e., "_____F____ :::: _S, _S ---->>>>  _S'")  should
          be  printed  in  the infix form "x _F y" rather than the
          prefix form "_F (x, y)", the latter being  the  default.
          This  macro  is normally set by the options ----pppprrrreeeeffffiiiixxxx and
          ----iiiinnnnffffiiiixxxx of ccccaaaaeeeessssaaaarrrr....aaaaddddtttt, but the user can also define this
          macro  before  including  the  "....hhhh"  file  generated by
          ccccaaaaeeeessssaaaarrrr....aaaaddddtttt.  See  items   #080   and   #208   in   file
          "$$$$CCCCAAAADDDDPPPP////HHHHIIIISSSSTTTTOOOORRRRYYYY" for details.


     CCCCAAAAEEEESSSSAAAARRRR____AAAADDDDTTTT____PPPPRRRRIIIINNNNTTTT____OOOOPPPPEEEENNNN_____N

     CCCCAAAAEEEESSSSAAAARRRR____AAAADDDDTTTT____PPPPRRRRIIIINNNNTTTT____CCCCLLLLOOOOSSSSEEEE_____N
          These two macros determine how a constructor  operation
          _F  implemented  by a C function named _N and returning a
          result of some  record  (or  even  singleton)  sort  is
          printed.  By  default,  these macros are defined in the
          "....hhhh" file generated by ccccaaaaeeeessssaaaarrrr....aaaaddddtttt unless the user  pro-
          vides  alternative  definitions  before  including this
          file. For instance, values of type _N can be printed  as
          "[x1,  x2, ..., xn]" rather than "_F (x1, x2, ..., xn)".
          See item #1561 in file "$$$$CCCCAAAADDDDPPPP////HHHHIIIISSSSTTTTOOOORRRRYYYY" for details.


     CCCCAAAAEEEESSSSAAAARRRR____AAAADDDDTTTT____FFFFOOOORRRRMMMMAAAATTTT_____N

     CCCCAAAAEEEESSSSAAAARRRR____AAAADDDDTTTT____FFFFOOOORRRRMMMMAAAATTTT
          These two macros determine whether the hash table stor-
          ing  the  values  of  the C type _N that implements some
          LOTOS sort will be displayed in case  the  table  over-
          flows  (because  it  cannot  contain  as many values as
          necessary) or when the  CCCCAAAAEEEESSSSAAAARRRR____AAAADDDDTTTT____TTTTEEEERRRRMMMM(((())))  function  is
          executed. If none of these two macros is defined before
          including the "....hhhh" file generated  by  ccccaaaaeeeessssaaaarrrr....aaaaddddtttt,  the



(C) INRIA            Last change: 2020/02/11                   38






CADP MANUAL PAGES                                    LOTOS(LOCAL)



          table  will  not  be displayed. If the former macro, or
          else the latter macro is defined in the "....tttt" file as an
          integer value _n, the table for type _N will be displayed
          under  format  _n,  following  the  conventions  of  the
          CCCCAAAAEEEESSSSAAAARRRR____PPPPRRRRIIIINNNNTTTT____TTTTAAAABBBBLLLLEEEE____1111(((())))  primitive  of  OPEN/CAESAR. The
          latter macro applies to  all  types  whose  values  are
          stored  in  hash  tables,  but  it  is overriden by the
          former macro as far as type _N is  concerned.  See  item
          #1250 in file "$$$$CCCCAAAADDDDPPPP////HHHHIIIISSSSTTTTOOOORRRRYYYY" for details.


  DDDDYYYYNNNNAAAAMMMMIIIICCCC MMMMEEEEMMMMOOOORRRRYYYY
     The following symbols control dynamic memory allocation  and
     reclaim:


     CCCCAAAAEEEESSSSAAAARRRR____AAAADDDDTTTT____AAAALLLLLLLLOOOOCCCC((((............))))
          This macro allocates a memory cell to contain  a  value
          of a given type and assigns the address of this cell to
          a given variable. If the  allocation  fails,  an  error
          message  is  displayed and the execution is interrupted
          by a SSSSIIIIGGGGTTTTEEEERRRRMMMM signal. By default, this macro is  defined
          in  the  "....hhhh"  file  generated by ccccaaaaeeeessssaaaarrrr....aaaaddddtttt unless the
          user provides an alternative definition before  includ-
          ing this file.


     CCCCAAAAEEEESSSSAAAARRRR____AAAADDDDTTTT____GGGGAAAARRRRBBBBAAAAGGGGEEEE____CCCCOOOOLLLLLLLLEEEECCCCTTTTIIIIOOOONNNN
          The "....hhhh" file generated by ccccaaaaeeeessssaaaarrrr....aaaaddddtttt checks whether  a
          macro  named  CCCCAAAAEEEESSSSAAAARRRR____AAAADDDDTTTT____GGGGAAAARRRRBBBBAAAAGGGGEEEE____CCCCOOOOLLLLLLLLEEEECCCCTTTTIIIIOOOONNNN is defined.
          If so, the memory allocation primitive  of  the  Boehm-
          Demers  garbage  collector will be used rather than the
          standard mmmmaaaalllllllloooocccc(((()))) primitive; this will require  linking
          with  the  "$$$$CCCCAAAADDDDPPPP////ggggcccc////bbbbiiiinnnn....****////lllliiiibbbbggggcccc....aaaa" library. This macro
          can be defined by the user when compiling the "....hhhh" file
          generated   by  ccccaaaaeeeessssaaaarrrr....aaaaddddtttt,  but  it  is  automatically
          defined by ccccaaaaeeeessssaaaarrrr when invoked with its  "----ggggcccc"  option.
          See item #653 in file "$$$$CCCCAAAADDDDPPPP////HHHHIIIISSSSTTTTOOOORRRRYYYY" for details.


  EEEERRRRRRRROOOORRRR HHHHAAAANNNNDDDDLLLLIIIINNNNGGGG
     The following symbols determine how erroneous situations are
     handled:


     AAAADDDDTTTT____CCCCHHHHEEEECCCCKKKK____NNNNAAAATTTT
          If    defined     before     including     the     file
          "$$$$CCCCAAAADDDDPPPP////iiiinnnnccccllll////XXXX____NNNNAAAATTTTUUUURRRRAAAALLLL....hhhh"  that  implements  the natural
          numbers defined in the  "XXXX____NNNNAAAATTTTUUUURRRRAAAALLLL....lllliiiibbbb"  library,  this
          macro  activates  systematic  checks  for overflows and
          underflows, which could  otherwise  remain  undetected.
          See item #1584 in file "$$$$CCCCAAAADDDDPPPP////HHHHIIIISSSSTTTTOOOORRRRYYYY" for details.



(C) INRIA            Last change: 2020/02/11                   39






CADP MANUAL PAGES                                    LOTOS(LOCAL)



     AAAADDDDTTTT____CCCCHHHHEEEECCCCKKKK____IIIINNNNTTTT
          If    defined     before     including     the     file
          "$$$$CCCCAAAADDDDPPPP////iiiinnnnccccllll////XXXX____IIIINNNNTTTTEEEEGGGGEEEERRRR....hhhh"  that  implements  the natural
          numbers defined in the  "XXXX____IIIINNNNTTTTEEEEGGGGEEEERRRR....lllliiiibbbb"  library,  this
          macro  activates  systematic  checks  for overflows and
          underflows, which could  otherwise  remain  undetected.
          See item #1584 in file "$$$$CCCCAAAADDDDPPPP////HHHHIIIISSSSTTTTOOOORRRRYYYY" for details.


     CCCCAAAAEEEESSSSAAAARRRR____AAAADDDDTTTT____EEEERRRRRRRROOOORRRR((((............))))
          This macro is invoked  when  a  partially-defined  non-
          constructor  is  called  with  actual  parameters whose
          values are not matched by any equation; an  error  mes-
          sage is displayed and the execution is interrupted by a
          SSSSIIIIGGGGTTTTEEEERRRRMMMM signal. By default, this macro  is  defined  in
          the  "....hhhh"  file generated by ccccaaaaeeeessssaaaarrrr....aaaaddddtttt unless the user
          provides an  alternative  definition  before  including
          this file.


     CCCCAAAAEEEESSSSAAAARRRR____AAAADDDDTTTT____OOOOVVVVEEEERRRRFFFFLLLLOOOOWWWW_____N((((............))))
          If defined before including the "....hhhh" file generated  by
          ccccaaaaeeeessssaaaarrrr....aaaaddddtttt,  this macro provides an "overflow" function
          to be invoked when the hash table storing the values of
          the  C  type _N that implements some LOTOS sort is full.
          If the user does not define this macro, ccccaaaaeeeessssaaaarrrr....aaaaddddtttt gen-
          erates  a standard overflow function automatically. See
          item #1250 in file "$$$$CCCCAAAADDDDPPPP////HHHHIIIISSSSTTTTOOOORRRRYYYY" for details.


  FFFFUUUUNNNNCCCCTTTTIIIIOOOONNNN TTTTRRRRAAAACCCCIIIINNNNGGGG
     The following symbols enable functions to be traced  at  run
     time:


     CCCCAAAAEEEESSSSAAAARRRR____AAAADDDDTTTT____TTTTRRRRAAAACCCCEEEE_____N
          When invoked with its "----ttttrrrraaaacccceeee" option, ccccaaaaeeeessssaaaarrrr....aaaaddddtttt  will
          generate, for each LOTOS operation _F implemented by a C
          function named _N, additional C code  that  is  executed
          when  entering  and  exiting  _N.  Compared to the usual
          function-tracing features offered by C debuggers,  this
          code  can  print  the  values  of actual parameters and
          returned results using the same  notations  as  in  the
          source  LOTOS specification. The execution of this code
          can be enabled or disabled, for  each  LOTOS  operation
          considered  individually,  using  an  integer  variable
          named CCCCAAAAEEEESSSSAAAARRRR____AAAADDDDTTTT____TTTTRRRRAAAACCCCEEEE_____N, which is initialized to zero.
          Setting this variable to one (either at compile time by
          manually  patching   the   "....hhhh"   file   generated   by
          ccccaaaaeeeessssaaaarrrr....aaaaddddtttt,  or  at  run time by assigning the variable
          directly from a debugger) allows the code  to  be  exe-
          cuted  when  function _N is called and returns. See item



(C) INRIA            Last change: 2020/02/11                   40






CADP MANUAL PAGES                                    LOTOS(LOCAL)



          #180 in file "$$$$CCCCAAAADDDDPPPP////HHHHIIIISSSSTTTTOOOORRRRYYYY" for details.


     CCCCAAAAEEEESSSSAAAARRRR____AAAADDDDTTTT____AAAARRRRGGGGUUUUMMMMEEEENNNNTTTT____TTTTRRRRAAAACCCCEEEE((((............))))
          This macro prints the actual parameters passed to func-
          tions  under  trace.   By default, it is defined in the
          "....hhhh" file generated by ccccaaaaeeeessssaaaarrrr....aaaaddddtttt unless the user  pro-
          vides  an  alternative definition before including this
          file. See items #180 and #181 in  file  "$$$$CCCCAAAADDDDPPPP////HHHHIIIISSSSTTTTOOOORRRRYYYY"
          for details.


     CCCCAAAAEEEESSSSAAAARRRR____AAAADDDDTTTT____EEEENNNNTTTTRRRRYYYY____TTTTRRRRAAAACCCCEEEE((((............))))
          This macro prints the name and depth level of functions
          under  trace  when  they are entered. By default, it is
          defined in the "....hhhh" file generated by ccccaaaaeeeessssaaaarrrr....aaaaddddtttt unless
          the  user  provides  an  alternative  definition before
          including this file.  See items #180 and #181  in  file
          "$$$$CCCCAAAADDDDPPPP////HHHHIIIISSSSTTTTOOOORRRRYYYY" for details.


     CCCCAAAAEEEESSSSAAAARRRR____AAAADDDDTTTT____EEEEXXXXIIIITTTT____TTTTRRRRAAAACCCCEEEE((((............))))
          This macro prints the name and depth level of functions
          under  trace  when  they  are exited. By default, it is
          defined in the "....hhhh" file generated by ccccaaaaeeeessssaaaarrrr....aaaaddddtttt unless
          the  user  provides  an  alternative  definition before
          including this file.  See items #180 and #181  in  file
          "$$$$CCCCAAAADDDDPPPP////HHHHIIIISSSSTTTTOOOORRRRYYYY" for details.


     CCCCAAAAEEEESSSSAAAARRRR____AAAADDDDTTTT____RRRREEEESSSSUUUULLLLTTTT____TTTTRRRRAAAACCCCEEEE((((............))))
          This macro prints the  results  returned  by  functions
          under  trace.   By  default,  it is defined in the "....hhhh"
          file generated by ccccaaaaeeeessssaaaarrrr....aaaaddddtttt unless the  user  provides
          an  alternative  definition before including this file.
          See items #180 and #181  in  file  "$$$$CCCCAAAADDDDPPPP////HHHHIIIISSSSTTTTOOOORRRRYYYY"  for
          details.


  DDDDEEEEPPPPRRRREEEECCCCAAAATTTTEEEEDDDD SSSSYYYYMMMMBBBBOOOOLLLLSSSS
     The following symbols are no longer supported:


     CCCCAAAAEEEESSSSAAAARRRR____AAAADDDDTTTT____NNNNOOOORRRRMMMMAAAALLLL____FFFFOOOORRRRMMMM
          See items #059, #082, and #235 in file  "$$$$CCCCAAAADDDDPPPP////HHHHIIIISSSSTTTTOOOORRRRYYYY"
          for details.


     CCCCAAAAEEEESSSSAAAARRRR____AAAADDDDTTTT____PPPPOOOOIIIINNNNTTTTEEEERRRR_____N
          See items #235 and #623  in  file  "$$$$CCCCAAAADDDDPPPP////HHHHIIIISSSSTTTTOOOORRRRYYYY"  for
          details.




(C) INRIA            Last change: 2020/02/11                   41






CADP MANUAL PAGES                                    LOTOS(LOCAL)



     CCCCAAAAEEEESSSSAAAARRRR____IIIINNNNFFFFIIIIXXXX____FFFFOOOORRRRMMMM____PPPPRRRRIIIINNNNTTTTIIIINNNNGGGG
          See items #080 and #208  in  file  "$$$$CCCCAAAADDDDPPPP////HHHHIIIISSSSTTTTOOOORRRRYYYY"  for
          details.


BBBBIIIIBBBBLLLLIIIIOOOOGGGGRRRRAAAAPPPPHHHHYYYY
     [BB88] Tommaso Bolognesi and Ed Brinksma.   Introduction  to
     the ISO Specification Language LOTOS.  Computer Networks and
     ISDN Systems, vol. 14, num. 1, pages 25-59, January 1988.

     [Gar89b] Hubert Garavel.   Compilation  et  verification  de
     programmes  LOTOS.   These  de  doctorat,  Universite Joseph
     Fourier,   Grenoble,   November   1989.    Available    from
     http://cadp.inria.fr/publications/Garavel-89-b.html

     [Gar89c] Hubert Garavel.  Compilation of LOTOS Abstract Data
     Types.   In  Son  T.  Vuong,  editor, Proceedings of the 2nd
     International Conference on  Formal  Description  Techniques
     (FORTE'89), Vancouver, Canada. North Holland, pages 147-162,
     December           1989.           Available            from
     http://cadp.inria.fr/publications/Garavel-89-c.html

     [Gar13] Hubert Garavel et al.  25 Years of  Compositionality
     Issues in CADP: An Overview.  Lecture at the Workshop on the
     25  Years  of  Combining  Compositionality  and  Concurrency
     (WS25CCC),  Koenigswinter, Germany, August 6-9, 2013. Avail-
     able                                                    from
     ftp://ftp.inrialpes.fr/pub/vasy/presentations/Garavel-
     25CCC-13.pdf

     [GS95a]  Hubert  Garavel  and  Mihaela  Sighireanu.   Defect
     Report Concerning ISO International Standard 8807 and Propo-
     sal for a Correct Flatenning of  LOTOS  Parametrized  Types.
     Rapport   SPECTRE,   95-11,  VERIMAG,  Grenoble,  July  1995
     http://cadp.inria.fr/publications/Garavel-Sighireanu-95-
     a.html

     [GT93] Hubert Garavel and Philippe Turlier.  CAESAR.ADT : un
     compilateur  pour les types abstraits algebriques du langage
     LOTOS. In Rachida Dssouli and Gregor v.  Bochmann,  editors,
     Actes  du  Colloque Francophone pour l'Ingenierie des Proto-
     coles (CFIP'93),  Montreal,  Canada,  1993.  Available  from
     http://cadp.inria.fr/publications/Garavel-Turlier-93.html

     [ISO89] ISO/IEC International Standard 8807:1989.  LOTOS - A
     Formal  Description Technique Based on the Temporal Ordering
     of Observational Behaviour.  International Organization  for
     Standardization,  Information  Processing Systems, Open Sys-
     tems Interconnection, Geneva, September 1989.






(C) INRIA            Last change: 2020/02/11                   42






CADP MANUAL PAGES                                    LOTOS(LOCAL)



SSSSEEEEEEEE AAAALLLLSSSSOOOO
     ccccaaaaeeeessssaaaarrrr(LOCAL),   ccccaaaaeeeessssaaaarrrr....aaaaddddtttt(LOCAL),    ccccaaaaeeeessssaaaarrrr....iiiinnnnddddeeeennnntttt(LOCAL),
     lllloooottttoooossss....ooooppppeeeennnn(LOCAL), ffffsssspppp2222lllloooottttoooossss(LOCAL), llllnnnntttt2222lllloooottttoooossss(LOCAL)

     Additional information is available from the CADP  Web  page
     located at http://cadp.inria.fr

     Directives   for   installation   are   given    in    files
     $$$$CCCCAAAADDDDPPPP////IIIINNNNSSSSTTTTAAAALLLLLLLLAAAATTTTIIIIOOOONNNN____****....

     Recent  changes  and  improvements  to  this  software   are
     reported and commented in file $$$$CCCCAAAADDDDPPPP////HHHHIIIISSSSTTTTOOOORRRRYYYY....


BBBBUUUUGGGGSSSS
     Please report bugs to cadp@inria.fr







































(C) INRIA            Last change: 2020/02/11                   43



