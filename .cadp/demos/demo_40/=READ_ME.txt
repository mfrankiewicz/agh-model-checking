-- CADP (CONSTRUCTION AND ANALYSIS OF DISTRIBUTED PROCESSES)
-- http://cadp.inria.fr

[Last updated: Thu Sep  7 18:11:21 CEST 2017]

This directory contains two examples of Web services specified in LOTOS
and verified using CAESAR.ADT, CAESAR, EVALUATOR, and SVL. The first example,
described in [Chirichiello-Salaun-05], is a stock management system. The
second one, described in [Salaun-Ferrara-Chirichiello-04], describes an
on-line book auction. See
   http://cadp.inria.fr/case-studies/04-d-web-services.html

[Chirichiello-Salaun-05]
   Antonella Chirichiello and Gwen Salaün. "Encoding Abstract Descriptions into
   Executable Web Services: Towards a Formal Development Negotiation among Web
   Services using LOTOS/CADP." In Proceedings of the 2005 IEEE/WIC/ACM
   International Conference on Web Intelligence WI'2005 (Compiègne, France),
   September 2005.
   http://cadp.inria.fr/publications/Chirichiello-Salaun-05.html

[Salaun-Ferrara-Chirichiello-04]
   Gwen Salaün, Andrea Ferrara, and Antonella Chirichiello. "Negotiation among
   Web Services using LOTOS/CADP." In Liang-Jie Zhang (editor), Proceedings of
   the European Conference on Web Services ECOWS'04 (Erfurt, Germany), Lecture
   Notes in Computer Science, vol. 3250, pp. 198-212, Springer Verlag,
   September 2004.

The BPEL description of the stock management system is included in the
present demo (see files *.bpel and *.wsdl in the doc directory).
This description can be used for simulation using, e.g., the Oracle BPEL
Process Manager 2.0 and Microsoft Access. Screenshots from such a simulation
are given in file "doc/screenshots.pdf".

The whole verification scenario is described and commented in the file 
"demo.svl". It can be executed by typing:
$	svl demo
or even simply 
$	svl

After execution of the SVL scenario, all generated files can be removed by 
typing
$	svl -clean demo
or even simply
$	svl -clean


