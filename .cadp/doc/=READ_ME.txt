--- CADP (CONSTRUCTION AND ANALYSIS OF DISTRIBUTED PROCESSES)
-- http://cadp.inria.fr

Selected publications about CADP
--------------------------------

This directory contains a selection of scientific papers related to the CADP
toolbox. This selection is also available from:
	http://cadp.inria.fr/publications

These papers are part of a much larger collection of CADP-related papers, 
the comprehensive list of which can be found at:
	http://cadp.inria.fr/publications/all.html

The selected papers are available in PDF format in the 'pdf' sub-directory. 
They can also be downloaded from the Internet (both in PDF and compressed
PostScript forms) at the following address:
	ftp://ftp.inrialpes.fr/pub/vasy/publications/cadp

The selected papers fall into various categories:
	- Overview papers about CADP
	- Papers about compilers for the LNT language
	- Papers about compilers for the LOTOS language
	- Papers about implicit state space manipulation using OPEN/CAESAR
	- Papers about explicit state space manipulation using BCG
	- Papers about equivalence checking using BISIMULATOR and REDUCTOR
	- Papers about model checking using EVALUATOR 3, 4, and 5
	- Papers about model checking using XTL
	- Papers about compositional verification
	- Papers about distributed verification
	- Papers about test generation
	- Papers about performance evaluation
	- Papers about concurrency models
	- Papers about translations for other languages
	- Papers about case studies and applications

Additional documentation (including tutorials, manual pages, case studies,
Frequently Asked Questions, etc.) can be found from the CADP Web page:
	http://cadp.inria.fr

The corresponding bibliographic references can be found in the `biblio.bib'
file, which is also available on-line at:
	ftp://ftp.inrialpes.fr/pub/vasy/publications/biblio.bib
This file contains BibTeX-like references, which can be used together with
the file `cortex.bst', i.e., the TeX file should contain the following lines:
	\bibliographystyle{cortex}
	\bibliography{biblio,other_biblios}

Overview papers about CADP
--------------------------

	[Garavel-Lang-Mateescu-Serwe-13]
		CADP 2011: a toolbox for the construction and analysis of
		distributed processes
		[21 pages]
		Abstract:
			CADP (Construction and Analysis of Distributed
		Processes) is a comprehensive software toolbox that implements
		the results of concurrency theory. Started in the mid-1980s,
		CADP has been continuously developed by adding new tools and
		enhancing existing ones. Today, CADP benefits from a worldwide
		user community, both in academia and industry. This paper
		presents the latest release, CADP 2011, which is the result
		of a considerable development effort spanning the last five
		years. The paper first describes the theoretical principles
		and the modular architecture of CADP, which has inspired
		several other recent model checkers. The paper then reviews
		the main features of CADP 2011, including compilers for
		various formal specification languages, equivalence checkers,
		model checkers, compositional verification tools, performance
		evaluation tools, and parallel verification tools running on
		clusters and grids. Finally, the paper surveys some
		significant case studies.

	Additional material is available from:
		http://cadp.inria.fr/tutorial

	See also the related manual pages at:
		http://cadp.inria.fr/man/installator.html
		http://cadp.inria.fr/man/svl.html
		http://cadp.inria.fr/man/tst.html
		http://cadp.inria.fr/man/xeuca.html

	Other related papers (not included in the CADP distribution):

	[Fernandez-Garavel-Mounier-Rasse-Rodriguez-Sifakis-91]: 
		Une boite a outils pour la verification de programmes LOTOS.
		[22 pages, in French]
		http://cadp.inria.fr/publications/Fernandez-Garavel-et-al-91.html

	[Fernandez-Garavel-Mounier-Rasse-Rodriguez-Sifakis-92]: 
		A Toolbox for the Verification of LOTOS programs.
		[14 pages]
		http://cadp.inria.fr/publications/Fernandez-Garavel-et-al-91.html

	[Fernandez-Garavel-Kerbrat-Mounier-Mateescu-Sighireanu-96]:
		CADP: A Protocol Validation and Verification Toolbox
		[4 pages]
		http://cadp.inria.fr/publications/Fernandez-Garavel-et-al-96.html

	[Garavel-96]: 
		An Overview of the Eucalyptus Toolbox
		[13 pages]
		http://cadp.inria.fr/publications/Garavel-96.html

	[Garavel-Jorgensen-Mateescu-Pecheur-Sighireanu-Vivien-97]:
		CADP'97 - Status, Applications, and Perspectives
		[6 pages]
		http://cadp.inria.fr/publications/Garavel-Jorgensen-et-al-97.html

	[Garavel-Lang-Mateescu-01]:
		An Overview of CADP 2001
		[15 pages]
		http://cadp.inria.fr/publications/Garavel-Lang-Mateescu-01.html

	[Garavel-Lang-Mateescu-Serwe-07]:
		CADP 2006: A Toolbox for the Construction and Analysis of
		Distributed Processes
		[5 pages]
		http://cadp.inria.fr/publications/Garavel-Lang-Mateescu-Serwe-07.html

	[Garavel-Lang-Mateescu-Serwe-11]:
		CADP 2010: A Toolbox for the Construction and Analysis
		of Distributed Processes
		[15 pages, subsumed by Garavel-Lang-Mateescu-Serwe-13]
		http://cadp.inria.fr/publications/Garavel-Lang-Mateescu-Serwe-11.html

-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

Papers about compilers for the LNT language
-------------------------------------------

Documentation about the LNT language itself is available from:
	http://cadp.inria.fr/tutorial/index.html#lnt

* Papers about sequential code generation

	[Champelovier-Clerc-Garavel-et-al-10]:
		Reference Manual of the LNT to LOTOS Translator
		(Formerly: Reference Manual of the LOTOS NT to LOTOS Translator)
		(regularly updated since 2005)
		[around 130 pages]
		Abstract:
			This report defines the LNT language (version 6.0),
		which is a simplified variant of E-LOTOS (International
		Standard ISO-15437:2001). In a nutshell, LNT provides the
		same expressiveness as LOTOS, but has more user-friendly and
		regular notations borrowed from imperative and functional
		programming languages. In particular, unlike LOTOS, the data
		type and process parts of LNT share many similar constructs,
		leading to a more uniform and easy-to-learn language than
		LOTOS. This report defines the syntax, static semantics, and
		dynamic semantics of LNT, and presents its associated tools:
		the LPP preprocessor, the LNT2LOTOS translator, and the
		LNT.OPEN script that interfaces with the OPEN/CAESAR framework
		so as to enable LNT specifications to be analyzed using the
		CADP toolbox.

	See also the related manual pages at:
		http://cadp.inria.fr/man/lnt.open.html
		http://cadp.inria.fr/man/lnt2lotos.html
		http://cadp.inria.fr/man/lpp.html

* Papers about distributed code generation

	[Evrard-Lang-17]:
		Automatic Distributed Code Generation from Formal Models
		of Asynchronous Concurrent Processes Interacting by Multiway
		Rendezvous

		[66 pages] 
		Abstract:
			Formal process languages inheriting the concurrency
		and communication features of process algebras are convenient
		formalisms to model distributed applications, especially when
		they are equipped with formal verification tools (e.g.,
		model checkers) to help hunting for bugs early in the
		development process. However, even starting from a fully
		verified formal model, bugs are likely to be introduced while
		translating (generally by hand) the concurrent model --which
		relies on high-level and expressive communication primitives--
		into the distributed implementation --which often relies on
		low-level communication primitives. In this paper, we present
		DLC, a compiler that enables distributed code to be generated
		from models written in a formal process language called LNT,
		which is equipped with a rich verification toolbox named CADP,
		and where processes interact by value-passing multiway
		rendezvous. The generated code uses an elaborate protocol to
		implement rendezvous, and can be either executed in an
		autonomous way (i.e., without requiring additional code to
		be defined by the user), or connected to external software
		through user-modifiable C functions. The protocol itself is
		modeled in LNT and verified using CADP. We present several
		experiments assessing the performance of DLC, including the
		Raft consensus algorithm.

* Papers about the motivation behind the design of LNT

	[Garavel-Sighireanu-98-a]: 
		Towards a Second Generation of Formal Description Techniques
                - Rationale for the Design of E-LOTOS	
		[28 pages]
		Abstract:
		        Process algebras are often advocated as suitable 
		formalisms for the specification of telecommunication protocols
		and distributed systems. However, despite their mathematical 
		basis, despite standardization attempts (most notably the
		Formal Description Technique LOTOS), and despite an ever 
		growing number of successful case-studies, process algebras 
		have not yet reached a wide acceptance in industry. On the 
		other hand, description languages such as PROMELA or SDL are 
		quite popular, although they lack a formal semantics, which 
		should prohibit their use for safety-critical systems.  
        		In this paper, we seek to merge the "best of both 
		worlds" by attempting to define a "second generation Formal 
		Description Technique" that would combine the strong 
		theoretical foundations of process algebras with language 
		features suitable for a wider industrial dissemination of 
		formal methods. Taking the international standard LOTOS as 
		a basis, we suggest several enhancements, which fall into 
		three categories: data part, behaviour part, and modules.
        		Our work was initiated in 1992 in the framework of 
		the ISO/IEC Committee for the revision of the LOTOS standard.
		Several of our suggestions have been accepted and will be 
		integrated into the revised standard E-LOTOS. The other 
		suggestions are considered in the context of LOTOS NT, a 
		variant of E-LOTOS for which a prototype compiler/model-checker
		is under development at INRIA. 

	[Garavel-03]:
		Défense et illustration des algèbres de processus
		[25 pages, in French]
		Abstract:
			Process algebras are a mathematical formalism for the
		description and study of concurrent systems. In this paper,
		we explain why the fundamental concepts of process algebras,
		when combined with appropriate languages for the description 
		of data types, provide technically better solutions than other
		formalisms. In particular, we underline the intrinsic 
		advantages of process algebras in four respects, which are
		generally antinomic: the expressiveness offered to users, the
		capability to model various types of applications, the
		possibility to generate prototype implementations 
		automatically, and the efficiency permitted to automated
		verification tools.

	[Garavel-07]:
		Reflections on the Future of Concurrency Theory in General and 
		Process Calculi in Particular
		[16 pages]
		Abstract:
			In this report we review the current state of 
		concurrency theory with respect to its industrial impact. This
		review is both retrospective and prospective, and naturally
		encompasses process calculi, which are a major vector for
		spreading concurrency theory concepts. Considering the
		achievements, but also the failures, we try to identify the
		causes that, so far, prevented a larger dissemination of
		process calculi. This suggests a new generation of formal
		specification languages that would combine the concurrent
		features of process calculi with the standard concepts present
		in algorithmic languages. Finally, we underline two major
		evolutions in the software and hardware industries that open
		new application domains for the concurrency theory community.

	[Garavel-Lang-Serwe-17]:
		From LOTOS to LNT
		[29 pages]
		Abstract:
			We revisit the early publications of Ed Brinksma
		devoted, on the one hand, to the definition of the formal
		description technique LOTOS (ISO International Standard
		8807:1989) for specifying communication protocols and
		distributed systems, and, on the other hand, to two proposals
		(Extended LOTOS and Modular LOTOS) for making LOTOS a simpler
		and more expressive language. We examine how this scientific
		agenda has been dealt with during the last decades. We review
		the successive enhancements of LOTOS that led to the definition
		of three languages: E-LOTOS (ISO International Standard
		15437:2001), then LOTOS NT, and finally LNT. We present the
		software implementations (compilers and translators) developed
		for these new languages and report about their use in various
		application domains.

* Papers about the semantic foundations of LNT

	[Garavel-95-a]: 
		On the Introduction of Gate Typing in E-LOTOS
		[16 pages]
		Abstract:
			The definition of the Formal Description Technique 
		LOTOS (ISO standard 8807) is currently under revision. This
		paper proposes a gate typing extension to LOTOS in order to 
		improve the current situation where gates are completely 
		typeless. This extension is simple and fully upward compatible.
		It is shown to increase both the reliability and modularity of
		formal descriptions. Moreover, gate type-checking can be
		performed statically and does not require any change in the
		dynamic semantics of LOTOS.

	[Garavel-Sighireanu-96-a]: 
		On the Introduction of Exceptions in E-LOTOS
		[16 pages]
		Abstract:
			The advantages of exception handling are well-known and
		several sequential or parallel programming languages provide
		exception handling mechanisms. Unfortunately, none of the three
		standardized Formal Description Techniques (ESTELLE, LOTOS, and
		SDL) supports exceptions.
			In 1992, Quemada and Azcorra pointed out the need for
		structuring protocol descriptions with exceptions and proposed
		to extend LOTOS with a so-called ``generalized termination and
		enabling'' mechanism. 
			In this paper, we show that their proposal is not fully
		appropriate for a compositional description of complex systems.
		We propose a simpler exception mechanism for LOTOS, for which 
		we provide a syntactic and semantic definition.
			We show that this exception mechanism is very 
		primitive, as it allows several existing LOTOS operators to be
		expressed as special cases. We also suggest additional 
		operators, such as symmetric sequential composition and 
		iteration, which can be derived from the exception mechanism.

	[Garavel-Sighireanu-99]:
		A Graphical Parallel Composition Operator for Process Algebras
		[18 pages]
		Abstract:
			Process algebras are suitable for describing networks
		of communicating processes. In most process algebras, the 
		description of such networks is achieved using parallel 
		composition operators. Noticing that the parallel composition 
		operators commonly found in process algebras are often limited
		in expressiveness and/or difficult for novice users, we propose
		a new parallel operator that allows networks of communicating
		processes to be described easily, in a simple and well-
		structured manner. We illustrate on various examples (token-
		ring network and client-server protocol) the theoretical and
		practical merits of this operator.

	[Garavel-15-b]
		Revisiting Sequential Composition in Process Calculi
		[40 pages]
		       The article reviews the various ways sequential
		composition is defined in traditional process calculi, and
		shows that such definitions are not optimal, thus limiting
		the dissemination of concurrency theory ideas among computer
		scientists. An alternative approach is proposed, based on a
		symmetric binary operator and write-many variables. This
		approach, which generalizes traditional process calculi, has
		been used to define the new LNT language implemented in the
		CADP toolbox. Feedback gained from university lectures and
		real-life case studies shows a high acceptance by computer-
		science students and industry engineers.

-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

Papers about compilers for the LOTOS language
---------------------------------------------

Documentation about the LOTOS language itself is available from:
	http://cadp.inria.fr/tutorial/index.html#lotos

* Papers about the CAESAR.ADT compiler for LOTOS data types:

	[Garavel-89-c]: 
		Compilation of LOTOS Abstract Data Types
		[20 pages, full revised version]
		Abstract:
			This article describes an experiment with the 
		compilation of the data part of LOTOS. Using a pattern-matching
		compiling algorithm described in [Schnoebelen-88-b], a tool 
		named CAESAR.ADT was developed. It enables LOTOS abstract types
		to be translated automatically into corresponding concrete
		types, implemented in the C language. This paper intends to 
		give a fair idea of the usefulness of this algorithm, when it 
		is combined with appropriate data representations. On several 
		case studies taken from OSI descriptions, this paper explains
		the basic principles of the translation and shows the great
		quality of the generated code, which is likely to have better
		performances than other existing approaches.

	[Garavel-Turlier-93]: 
		CAESAR.ADT: un compilateur pour les types algebriques 
		du langage LOTOS
		[15 pages, in French]
		Abstract:
			Cet article présente le compilateur CAESAR.ADT dont le
		rôle est de traduire en langage C les définitions de types 
		abstraits algébriques présents dans les programmes LOTOS. 
		Grâce à ce compilateur, il est possible d'exécuter une 
		spécification algébrique, ce qui autorise des applications
		immédiates pour le prototypage et la vérification formelle.  
		La rapidité de la traduction et l'efficacité du code 
		engendré permettent de traiter des programmes de taille 
		significative avec des performances réalistes.
 
	See also the related manual pages at:
		http://cadp.inria.fr/man/caesar.adt.html
		http://cadp.inria.fr/man/lotos.html

* Papers about the CAESAR compiler for LOTOS processes:

	[Garavel-89-b]
		Compilation et Vérification de Programmes LOTOS
		[PhD thesis, 265 pages, in French]
		See http://cadp.inria.fr/publications/Garavel-89-b.html

	[Garavel-Sifakis-90]: 
		Compilation and Verification of LOTOS specifications
		[18 pages, full revised version]
		Abstract:
			The ISO specification language LOTOS is a Formal 
		Description Technique for concurrent systems. This paper 
		presents the main features of the CAESAR system, intended for
		formal verification of LOTOS specifications by model-checking.
		This tool compiles a subset of LOTOS into extended Petri Nets,
		then into state graphs, which can be verified by using either
		temporal logics or automata equivalences.
			The design choices and the principles of functioning 
	        of CAESAR are described and compared to those of other LOTOS 
		tools. The paper also proposes ideas to deal with the state 
		explosion problem arising in verification by model-checking.

	[Garavel-Serwe-06]:
		State Space Reduction for Process Algebra Specifications 
		[24 pages]
		Abstract:
			Data-flow analysis to identify ``dead'' variables and
		reset them to an ``undefined'' value is an effective technique
		for fighting state explosion in the enumerative verification
		of concurrent systems. Although this technique is well-adapted
		to imperative languages, it is not directly applicable to
		value-passing process algebras, in which variables cannot be
		reset explicitly due to the single-assignment constraints of
		the functional programming style. This paper addresses this
		problem by performing data-flow analysis on an intermediate
		model (Petri nets extended with state variables) into which
		process algebra specifications can be translated automatically.
		It also addresses important issues, such as avoiding the
		introduction of useless reset operations and handling shared
		read-only variables that children processes inherit from their
		parents.

	See also the related manual pages at:
		http://cadp.inria.fr/man/caesar.html
		http://cadp.inria.fr/man/caesar.bdd.html
		http://cadp.inria.fr/man/caesar.indent.html
		http://cadp.inria.fr/man/lotos.html

	Other related papers (not included in the CADP distribution):

	[Garavel-89-b]: 
		Compilation et Verification de Programmes LOTOS	
		[thesis, in French, 265 pages]
		http://cadp.inria.fr/publications/Garavel-89-b.html

	[Garavel-Serwe-04]:
		State Space Reduction for Process Algebra Specifications 
		[17 pages, subsumed by Garavel-Serwe-06]
		http://cadp.inria.fr/publications/Garavel-Serwe-04.html

-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

Papers about implicit state space manipulation using OPEN/CAESAR
----------------------------------------------------------------

	[Garavel-98]:
		OPEN/CAESAR: An Open Software Architecture for Verification,
		Simulation, and Testing
		[18 pages]
		Abstract:
			This report presents the OPEN/CAESAR software
		architecture, which allows to integrate in a common framework 
		different languages/formalisms for the description of 
		concurrent systems, as well as tools with various 
		functionalities, such as random execution, interactive 
		simulation, on-the-fly and exhaustive verification, test 
		generation, etc.  These principles have been fully implemented,
		leading to an open, extensible, and well-documented programming
		environment, which allows tools to be developed in a modular 
		framework, independently from any particular description 
		language. 

	[Garavel-92-a]: 
		The OPEN/CAESAR Reference Manual 
		[200 pages approx.]
		Abstract:
			This report describes the OPEN/CAESAR environment for 
		developing specifications in LOTOS. The OPEN/CAESAR environment
		is build on the CAESAR tool. Although CAESAR is mainly intended
		for compilation and exhaustive verification of LOTOS
		specifications, the OPEN/CAESAR provides for interactive 
		simulation, random simulation, partial verification, on-the-fly
		verification, sequential code generation, test generation, etc.
		In a first part, the principles and the architecture of the 
		OPEN/CAESAR environment are explained. In a second part, the
		interfaces of OPEN/CAESAR modules and libraries and presented.

	[Garavel-Mateescu-04]:
		SEQ.OPEN: A Tool for Efficient Trace-Based Verification
		[6 pages]
		Abstract:
			We report about recent enhancements of the CADP
		verification tool set that allow to check the correctness
		of event traces obtained by simulating or executing complex,
		industrial-size systems. Correctness properties are expressed
		using either regular expressions or modal mu-calculus formulas,
		and verified efficiently on very large traces.

	[Mateescu-00-a]:
		Efficient Diagnostic Generation for Boolean Equation Systems
		[23 pages]
		Abstract:
			Boolean Equation Systems (BESs) provide a useful 
		framework for the verification of concurrent finite-state 
		systems. In practice, it is desirable that a BES resolution 
		also yields diagnostic information explaining, preferably in a 
		concise way, the truth value computed for a given variable of 
		the BES. Using a representation of BESs as extended boolean 
		graphs (EBGs), we propose a characterization of full 
		diagnostics (i.e., both examples and counterexamples) as a 
		particular class of subgraphs of the EBG associated to a BES. 
		We provide algorithms that compute examples and counterexamples
	 	in linear time and can be straightforwardly used to extend 
		known (global or local) BES resolution algorithms with 
		diagnostic generation facilities.

	[Mateescu-03-a]:
		A Generic On-the-Fly Solver for Alternation-Free Boolean
		Equation Systems
		[21 pages]
		Abstract:
			Boolean Equation Systems are a useful formalism
		for modeling various verification problems of finite-state
		concurrent systems, in particular the equivalence checking
		and the model checking problems. These problems can be solved
		on-the-fly (i.e., without constructing explicitly the state
		space of the system under analysis) by using a demand-driven
		construction and resolution of the corresponding boolean
		equation system. In this report, we present a generic software
		library dedicated to on-the-fly resolution of alternation-free
		boolean equation systems. Four resolution algorithms are
		currently provided by the library: A1 and A2 are general
		algorithms, the latter being optimized to produce small-depth
		diagnostics, whereas A3 and A4 are specialized algorithms for
		handling acyclic and disjunctive/conjunctive boolean equation
		systems in a memory-efficient way. The library is developed
		within the CADP verification toolbox and is used for both
		on-the-fly equivalence checking (five widely-used equivalence
		relations are supported) and for on-the-fly model checking of
		alternation-free modal mu-calculus.

	[Mateescu-06-a]:
		CAESAR_SOLVE: A Generic Library for On-the-Fly Resolution
		of Alternation-Free Boolean Equation Systems
		[39 pages]
		Abstract:
			Boolean Equation Systems (BESs) provide a useful
		framework for modeling various verification problems on
		finite-state concurrent systems, such as equivalence checking
		and model checking. These problems can be solved on-the-fly
		(i.e., without constructing explicitly the state space of the
		system under analysis) by using a demand-driven construction
		and resolution of the corresponding BES. In this report, we
		present a generic software library dedicated to on-the-fly
		resolution of alternation-free BESs (i.e., without mutually
		recursive minimal and maximal fixed point equations). Four
		resolution algorithms are currently provided by the library:
		algorithms A1 and A2 are general, the latter being optimized
		to produce small-depth diagnostics, whereas algorithms A3
		and A4 are specialized for handling acyclic and
		disjunctive/conjunctive BESs in a memory-efficient way.
		The library is developed within the CADP verification toolbox
		using the generic OPEN/CAESAR environment and is currently
		used for three purposes: on-the-fly equivalence checking
		modulo five widely-used equivalence relations, on-the-fly
		model checking of regular alternation-free mu-calculus, and
		on-the-fly reduction of state spaces based on tau-confluence.

	[Mateescu-Wijs-09-a]:
		Hierarchical Adaptive State Space Caching based on
		Level Sampling
		[15 pages]
		Abstract:
			In the past, several attempts have been made to deal
		with the state space explosion problem by equipping a depth-
		first search (DFS) algorithm with a state cache, or by
		avoiding collision detection, thereby keeping the state hash
		table at a fixed size. Most of these attempts are tailored
		specifically for DFS, and are often not guaranteed to terminate
		and/or to exhaustively visit all the states. In this paper, we
		propose a general framework of hierarchical caches which can
		also be used by breadth-first searches (BFS). Our method, based
		on an adequate sampling of BFS levels during the traversal,
		guarantees that the BFS terminates and traverses all
		transitions of the state space. We define several (static or
		adaptive) configurations of hierarchical caches and we study
		experimentally their effectiveness on benchmark examples of
		state spaces and on several communication protocols, using a
		generic implementation of the cache framework that we developed
		within the CADP toolbox.

	[Mateescu-Wijs-09-b]:
		Efficient On-the-Fly Computation of Weak Tau-Confluence
		[42 pages]
		Abstract:
			The notion of tau-confluence provides a form of partial
		order reduction of Labelled Transition Systems (LTSs), by
		allowing to identify the tau-transitions whose execution does
		not alter the observable behaviour of the system. Several forms
		of tau-confluence adequate with branching bisimulation were
		studied in the literature, ranging from strong to weak ones
		according to the length of tau-transition sequences considered.
		Weak tau-confluence is more complex to compute than strong
		tau-confluence, but provides better LTS reductions. In this
		report, we aim at devising an efficient detection of weak
		tau-confluent transitions during an on-the-fly exploration of
		LTSs. To this purpose, we define and prove new encodings of
		several weak tau-confluence variants using alternation-free
		boolean equation systems (BESs), and we apply efficient local
		BES resolution algorithms to perform the detection. The
		resulting reduction module, developed within the CADP toolbox
		using the generic OPEN/CAESAR environment for LTS exploration,
		was experimented on numerous examples of large LTSs underlying
		communication protocols and distributed systems. These
		experiments assessed the efficiency of the reduction and
		allowed us to identify the best variants of weak tau-confluence
		that are useful in practice.


	See also the manual pages of the OPEN/CAESAR-compliant compilers at:
		http://cadp.inria.fr/man/bcg_open.html
		http://cadp.inria.fr/man/exp.open.html
		http://cadp.inria.fr/man/fsp.open.html
		http://cadp.inria.fr/man/lnt.open.html
		http://cadp.inria.fr/man/lotos.open.html
		http://cadp.inria.fr/man/seq.open.html

	See also the manual pages of the OPEN/CAESAR application tools at:
		http://cadp.inria.fr/man/bisimulator.html
		http://cadp.inria.fr/man/cunctator.html
		http://cadp.inria.fr/man/declarator.html
		http://cadp.inria.fr/man/determinator.html
		http://cadp.inria.fr/man/distributor.html
		http://cadp.inria.fr/man/evaluator.html
		http://cadp.inria.fr/man/executor.html
		http://cadp.inria.fr/man/exhibitor.html
		http://cadp.inria.fr/man/generator.html
		http://cadp.inria.fr/man/ocis.html
		http://cadp.inria.fr/man/predictor.html
		http://cadp.inria.fr/man/projector.html
		http://cadp.inria.fr/man/reductor.html
		http://cadp.inria.fr/man/simulator.html
		http://cadp.inria.fr/man/terminator.html
		http://cadp.inria.fr/man/tgv.html
		http://cadp.inria.fr/man/xsimulator.html

	See also the manual pages of the OPEN/CAESAR libraries at:
		http://cadp.inria.fr/man/caesar_area_1.html
		http://cadp.inria.fr/man/caesar_bitmap.html
		http://cadp.inria.fr/man/caesar_diagnostic_1.html
		http://cadp.inria.fr/man/caesar_edge.html
		http://cadp.inria.fr/man/caesar_graph.html
		http://cadp.inria.fr/man/caesar_hash.html
		http://cadp.inria.fr/man/caesar_hide_1.html
		http://cadp.inria.fr/man/caesar_mask_1.html
		http://cadp.inria.fr/man/caesar_rename_1.html
		http://cadp.inria.fr/man/caesar_solve_1.html
		http://cadp.inria.fr/man/caesar_stack_1.html
		http://cadp.inria.fr/man/caesar_standard.html
		http://cadp.inria.fr/man/caesar_table_1.html
		http://cadp.inria.fr/man/caesar_version.html

	Other related papers (not included in the CADP distribution):

	[Mateescu-03-c]:
		On-the-Fly Verification using CADP
		[5 pages, subsumed by Garavel-Lang-Mateescu-15]
		http://cadp.inria.fr/publications/Mateescu-03-c.html

	[Mateescu-Poizat-Salaun-07]:
		Behavioral Adaptation of Component Compositions based on
		Process Algebra Encodings
		[25 pages]
		http://cadp.inria.fr/publications/Mateescu-Poizat-Salaun-07.html

	[Mateescu-Poizat-Salaun-08]:
		Adaptation of Service Protocols using Process Algebra and
		On-the-Fly Reduction Techniques
		[16 pages]
		http://cadp.inria.fr/publications/Mateescu-Poizat-Salaun-08.html

-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

Papers about explicit state space manipulation using BCG
--------------------------------------------------------

	[Tock-95]: 
		The BCG Postscript Format
		[12 pages]
		Abstract:
			This document describes the format of the Postscript
		files generated by bcg_draw and used in bcg_edit. Such files
		specify at once the structure of a BCG graph (states and 
		transitions) and its graphical representation printable on any
		postscript printer. Any graph coded using this format can be
		modified interactively using the WYSIWYG (What You See Is What
		You Get) BCG graph editor called bcg_edit.

	See also the manual pages of the BCG programming interfaces at:
		http://cadp.inria.fr/man/bcg.html
		http://cadp.inria.fr/man/bcg_read.html
		http://cadp.inria.fr/man/bcg_write.html

	See also the manual pages of the BCG tools at:
		http://cadp.inria.fr/man/bcg_draw.html
		http://cadp.inria.fr/man/bcg_edit.html
		http://cadp.inria.fr/man/bcg_graph.html
		http://cadp.inria.fr/man/bcg_info.html
		http://cadp.inria.fr/man/bcg_io.html
		http://cadp.inria.fr/man/bcg_labels.html
		http://cadp.inria.fr/man/bcg_lib.html
		http://cadp.inria.fr/man/bcg_merge.html
		http://cadp.inria.fr/man/bcg_min.html
		http://cadp.inria.fr/man/bcg_open.html
		http://cadp.inria.fr/man/bcg_steady.html
		http://cadp.inria.fr/man/bcg_transient.html

-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

Papers about equivalence checking using BISIMULATOR and REDUCTOR
----------------------------------------------------------------

        [Bergamini-Descoubes-Joubert-Mateescu-05]:
                BISIMULATOR: A Modular Tool for On-the-Fly Equivalence
                Checking.
                [5 pages]
                Abstract:
                        The equivalence checking problem consists in verifying
                that a system (e.g., a protocol) matches its abstract
                specification (e.g., a service) by comparing their Labeled
                Transition Systems (LTSs) modulo a given equivalence relation.
                Global verification requires to construct the two LTSs before
                comparison, whereas local (or on-the-fly) verification allows
                to explore them incrementally during comparison, thus being
                more suitable for detecting errors in large systems. In this
                paper, we present BISIMULATOR, an efficient on-the-fly
                equivalence checker with a highly modular architecture,
                developed within the CADP verification toolbox. The front-end
                of the tool encodes five widely-used equivalence relations in
                terms of Boolean Equation Systems (BESs) by using the
                OPEN/CAESAR and BCG environments of CADP, which provide
                powerful LTS exploration primitives. The back-end carries out
                the verification by using the generic CAESAR_SOLVE library of
                CADP, dedicated to (sequential and distributed) on-the-fly BES
                resolution and diagnostic generation. The sequential version
                of BISIMULATOR compares favourably with other specialized
                on-the-fly equivalence checking tools, and the distributed
                version exhibits linear speedups w.r.t. the sequential one.

	[Mateescu-05]:
		On-the-Fly State Space Reductions for Weak Equivalences
		[10 pages]
		Abstract:
			On-the-fly verification of concurrent finite-state
		systems consists in constructing and analysing their underlying
		state spaces in a demand-driven way. This technique is able to
		detect errors effectively in large systems; however, its
		performance can still be increased by reducing the state
		spaces incrementally in a way compatible with the verification
		problem. In this paper, we propose algorithms for three
		on-the-fly reductions of Labeled Transition Systems (LTSs),
		which preserve weak equivalence relations: tau-compression
		(collapsing of strongly connected components made of
		tau-transitions), tau-closure (transitive reflexive closure
		over tau-transitions), and tau-confluence (a form of partial
		order reduction). Each algorithm is described as a reductor
		module taking as input the successor function of an LTS and
		returning the successor function of the reduced LTS. The three
		reductors were implemented within the CADP toolbox using the
		generic OPEN/CAESAR environment, which makes them directly
		available for any on-the-fly verification tool connected to
		OPEN/CAESAR and compatible with the underlying reduction. Our
		experiments show that these reductors can improve significantly
		the performance of on-the-fly LTS generation, model checking,
		and equivalence checking.

	See also the related manual pages at:
		http://cadp.inria.fr/man/bisimulator.html
		http://cadp.inria.fr/man/reductor.html
		http://cadp.inria.fr/man/bcg_min.html

	Other related papers (not included in the CADP distribution):

	[Pace-Lang-Mateescu-03]:
		Calculating Tau-Confluence Compositionally.
		[23 pages]
		http://cadp.inria.fr/publications/Pace-Lang-Mateescu-03.html

	[Mateescu-Oudot-08-a]:
		Bisimulator 2.0: An On-the-Fly Equivalence Checker based on
		Boolean Equation Systems
		[2 pages]
		http://cadp.inria.fr/publications/Mateescu-Oudot-08-a.html

	[Mateescu-Oudot-08-b]:
		Improved On-the-Fly Equivalence Checking using Boolean
		Equation Systems
		[31 pages]
		http://cadp.inria.fr/publications/Mateescu-Oudot-08-b.html

-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

Papers about model checking using EVALUATOR 3, 4, AND 5
-------------------------------------------------------

	[Mateescu-98-b]:
		Local Model-Checking of an Alternation-Free Value-Based Modal
		Mu-Calculus
		[8 pages]
		Abstract:
			Programs written in value-passing description languages
		such as muCRL and LOTOS can be naturally translated into 
		Labelled Transition Systems (LTSs) containing data values. 
		In order to express temporal properties interpreted over these
		LTSs, we define a value-based alternation-free modal 
		mu-calculus built from typed variables, pattern-matching 
		modalities, and parameterised fixed point operators. The 
		verification of a temporal formula over a (finite) LTS is 
		reduced to the (partial) resolution of a Parameterised Boolean
		Equation System (PBES). We propose a resolution method for 
		PBESs that leads to a local model-checking algorithm, which 
		could also be applied in the framework of abstract 
		interpretation.

	[Mateescu-02]:
		Local Model-Checking of Modal Mu-Calculus on Acyclic Labeled
		Transition Systems
		[36 pages]
		Abstract:
			Model-checking is a popular technique for verifying
		finite-state concurrent systems, the behaviour of which can
		be modeled using Labeled Transition Systems (LTSs). In this
		report, we study the model-checking problem for the modal
		mu-calculus on acyclic LTSs. This has various applications
		of practical interest such as trace analysis, log information
		auditing, run-time monitoring, etc. We show that on acyclic
		LTSs, the full mu-calculus has the same expressive power as
		its alternation-free fragment. We also present two new
		algorithms for local model-checking of mu-calculus formulas
		on acyclic LTSs. Our algorithms are based upon a translation
		to boolean equation systems and exhibit a better performance
		than existing model-checking algorithms applied to acyclic
		LTSs. The first algorithm handles mu-calculus formulas F with
		alternation depth ad (F) >= 2 and has time complexity
		O (|F|^2 * (|S|+|T|)) and space complexity O (|F|^2 * |S|),
		where |S| and |T| are the number of states and transitions of
		the acyclic LTS and |F| is the number of operators in F.
		The second algorithm handles formulas F with alternation depth
		ad(F) = 1 and has time complexity O (|F| * (|S|+|T|)) and space
		complexity O (|F| * |S|).

	[Mateescu-03-b]:
		Logiques temporelles basées sur actions pour la vérification
		des systèmes asynchrones
		[39 pages, in French]
		Abstract:
			Formal verification is essential for ensuring the
		reliability of complex, critical applications such as
		communication protocols and distributed systems. The
		model-checking approach consists in translating the
		application into a labelled transition system model, on
		which the correctness properties, expressed as temporal
		logic formulas, are verified by means of specific algorithms.
		This article presents in a unified manner the action based
		temporal logics that are currently the most used in the
		framework of parallel asynchronous systems involving
		nondeterminism. The different logics described (modal,
		branching, regular, and fixed point based) are illustrated
		through various examples of typical properties of parallel
		asynchronous systems (safety, liveness, fairness) and are
		compared with respect to expressiveness, user-friendliness,
		and efficiency of the corresponding verification algorithms.

	[Mateescu-Sighireanu-03]:
		Efficient On-the-Fly Model-Checking for Regular Alternation-
		Free Mu-Calculus
		[32 pages]
		Abstract:
			Model-checking is a successful technique for 
		automatically verifying concurrent finite-state systems. 
		When designing a model-checker, a good compromise must be made 
		between the expressive power of the property description 
		formalism, the complexity of the model-checking problem, and 
		the user-friendliness of the interface. We present a temporal 
		logic and an associated model-checking method that attempt to 
		fulfill these criteria. The logic is an extension of the 
		alternation-free mu-calculus with ACTL-like action formulas 
		and  PDL-like regular expressions, allowing a concise and 
		intuitive description of safety, liveness, and fairness 
		properties over labeled transition systems. The model-checking
		method is based upon a succinct translation of the verification
		problem into a boolean equation system, which is solved by 
		means of an efficient local algorithm having a good average 
		complexity. The algorithm also allows to generate full 
		diagnostic information (examples and counterexamples) for 
		temporal formulas. This method is at the heart of the EVALUATOR
		3.0 model-checker that we implemented within the CADP toolbox
		using the generic OPEN/CAESAR environment for on-the-fly 
		verification.

	[Mateescu-Thivolle-08]:
		A Model Checking Language for Concurrent Value-Passing Systems
		[16 pages]
		Abstract:
			Modal mu-calculus is an expressive specification
		formalism for temporal properties of concurrent programs
		represented as Labeled Transition Systems (LTSs). However,
		its practical use is hampered by the complexity of the
		formulas, which makes the specification task difficult and
		error-prone. In this paper, we propose MCL (Model Checking
		Language), an enhancement of modal mu-calculus with high-level
		operators aimed at improving expressiveness and conciseness
		of formulas. The main MCL ingredients are parameterized fixed
		points, action patterns extracting data values from LTS
		actions, modalities on transition sequences described using
		extended regular expressions and programming language
		constructs, and an infinite looping operator specifying
		fairness. We also present a method for on-the-fly model
		checking of MCL formulas on finite LTSs, based on the local
		resolution of boolean equation systems, which has a linear-time
		complexity for alternation-free and fairness formulas. MCL is
		supported by the EVALUATOR 4.0 model checker developed within
		the CADP verification toolbox.

	[Mateescu-Wijs-11]:
		Property-Dependent Reductions for the Modal Mu-Calculus
		[30 pages]
		Abstract:
			When analyzing the behavior of finite-state concurrent
		systems by model checking, one way of fighting state explosion
		is to reduce the model as much as possible whilst preserving
		the properties under verification. We consider the framework
		of action-based systems, whose behaviors can be represented by
		labeled transition systems (LTSs), and whose temporal
		properties of interest can be formulated in modal mu-calculus
		(Lmu). First, we determine, for any Lmu formula, the maximal
		set of actions that can be hidden in the LTS without changing
		the interpretation of the formula. Then, we define dsbrLmu, a
		fragment of Lmu which is compatible with divergence-sensitive
		branching bisimulation. This enables us to apply the maximal
		hiding and to reduce the LTS on-the-fly using divergence-
		sensitive tau-confluence during the verification of any
		dsbrLmu formula. The experiments that we performed on various
		examples of communication protocols and distributed systems
		show that this reduction approach can significantly improve
		the performance of on-the-fly verification.

	[Mateescu-Requeno-18]:
		On-the-Fly Model Checking for Extended Action-Based
		Probabilistic Operators
		[24 pages]
		Abstract:
			The quantitative analysis of concurrent systems
		requires expressive and user-friendly property languages
		combining temporal, data handling, and quantitative aspects.
		In this paper, we aim at facilitating the quantitative
		analysis of systems modeled as PTSs (Probabilistic Transition
		Systems) labeled by actions containing data values and
		probabilities. We propose a new regular probabilistic operator
		that specifies the probability measure of a path described by
		a generalized regular formula involving arbitrary computations
		on data values. This operator, which subsumes the Until
		operators of PCTL and their action-based counterparts, can
		provide useful quantitative information about paths having
		certain (e.g., peak) cost values. We integrated the regular
		probabilistic operator into MCL (Model Checking Language) and
		we devised an associated on-the-fly model checking method,
		based on a combined local resolution of linear and Boolean
		equation systems. We implemented the method in the EVALUATOR
		model checker of the CADP toolbox and experimented it on
		realistic PTSs modeling concurrent systems.

	See also the related manual pages at:
		http://cadp.inria.fr/man/evaluator.html
		http://cadp.inria.fr/man/caesar_solve_1.html

	Other related papers (not included in the CADP distribution):

	[Mateescu-Monteiro-Dumas-deJong-08]:
		Computation Tree Regular Logic for Genetic Regulatory Networks
		[53 pages]
		http://cadp.inria.fr/publications/Mateescu-Monteiro-Dumas-deJong-08.html

-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

Papers about model checking using XTL
-------------------------------------

	[Mateescu-Garavel-98]:
		XTL: A Meta-Language and Tool for Temporal Logic Model-Checking
		[12 pages]
		Abstract:
			We present a temporal logic model-checking environment
		based on a new language called XTL (eXecutable Temporal 
		Language). XTL is a functional programming language designed
		to allow a compact description of various temporal logic 
		operators, which are evaluated over a Labelled Transition 
		System (LTS). XTL offers primitives to access the data values
		(possibly) contained in the states and labels of the LTS, as 
		well as to explore the transition relation. The temporal logic
		operators are implemented by means of iteration expressions 
		computing sets of states and sets of transitions. Various
		useful modal and temporal logics like HML, CTL, LTAC, and ACTL,
		have been implemented in XTL, and several industrial 
		case-studies, such as the BRP protocol designed by Philips, 
		the IEEE-1394 serial bus standardized by IEEE, and the CFS 
		protocol developed by Bull and INRIA, have been successfully
		validated using the XTL model-checker.

	See also the XTL manual page at:
		http://cadp.inria.fr/man/xtl.html

	Other related papers (not included in the CADP distribution):

	[Mateescu-98-a]:
		Verification des Proprietes Temporelles des Programmes
		Paralleles
                [thesis, in French, 273 pages]
                http://cadp.inria.fr/publications/Mateescu-98-a.html

-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

Papers about compositional verification
---------------------------------------

	[Garavel-Lang-Mateescu-15]:
		Compositional Verification of Asynchronous Concurrent Systems
		using CADP
		[68 pages]
		Abstract:
			During the last decades, concurrency theory
		successfully developed salient concepts to formally model and
		soundly reason about distributed and parallel systems. In
		practice, however, most attempts at analyzing large systems
		face severe complexity issues, especially state explosion,
		which prevents to exhaustively enumerate reachable state
		spaces. Compositionality is the most promising approach to
		fight state explosion. In this paper, we focus on finite-state
		verification techniques for asynchronous message-passing
		systems, highlighting the existence of multiple, diverse
		compositional techniques such as: compositional model
		generation, semi-composition and projection, automatic
		generation of projection interfaces, formula-dependent model
		generation, and partial model checking. These approaches have
		been implemented in the framework of the CADP (Construction
		and Analysis of Distributed Processes) software toolbox and
		applied to large-scale, industrial systems. A key point is the
	 	ability to combine several compositional techniques, as no
		single technique is sufficient to address all kinds of systems. 

	[Garavel-Lang-Mounier-18]:
		Compositional Verification in Action
		[27 pages]
		Abstract:
			Concurrent systems are intrinsically complex and
		their verification is hampered by the well-known ``state-space
		explosion'' issue. Compositional verification is a powerful
		approach, based on the divide-and-conquer paradigm, to address
		this issue. Despite impressive results, this approach is not
		used widely enough in practice, probably because it exists
		under multiple variants that make knowledge of the field hard
		to attain. In this article, we highlight the seminal results
		of Graf & Steffen and propose a survey of compositional
		verification techniques that exploit (or not) these results. 

The above publication provides a wide overview of compositional verification 
techniques using CADP; the publications below address more specialized topics.

	[Krimm-Mounier-97]:
		Compositional State Space Generation from Lotos Programs
		[20 pages]
		Abstract:
			This paper describes a compositional approach to
		gnerate the labeled transition system representing the 
		behaviour of a Lotos program by repeatedly alternating
		composition and reduction operations on subsets of its
		processes. To restrict the size of the intermediate LTSs
		generated, we generalize to the LOTOS parallel composition
		operator the results proposed in [Graf-Steffen-90], which
		consist in representing the environment of a process as an
		interface, i.e., a set of "autorized" execution sequences/
		This generalization allows to handle both user-given interfaces
		and automatically computed ones. This compositional method
		has been implemented within the CADP toolbox and experimented
		on several realistic case studies.

	[Garavel-Lang-01]:
		SVL: a Scripting Language for Compositional Verification
		[36 pages]
		Abstract:
			Compositional verification is a way to avoid state
		explosion for the enumerative verification of complex 
		concurrent systems. Process algebras such as LOTOS are suitable
		for compositional verification, because of their appropriate
		parallel composition operators and concurrency semantics.
		Extending prior work by Krimm and Mounier, this report presents
		the SVL language, which allows compositional verification of
		LOTOS descriptions to be performed simply and efficiently. A
		compiler for SVL has been implemented using an original
		compiler-generation technique based on the Enhanced LOTOS
		language. This compiler supports several formats and tools for
		handling Labeled Transition Systems. It is available as a
		component of the CADP toolbox and has been applied on various
		case-studies profitably.

	[Lang-02]:
		Compositional Verification using SVL Scripts
		[5 pages]
		Abstract:
			This paper presents SVL, a scripting language (and its
		compiler) for verification using the CADP and FC2 tools. It
		illustrates with two examples how concise scripts can be
		written in SVL to perform compositional verification.

	[Lang-05]:
		EXP.OPEN 2.0: A Flexible Tool Integrating Partial Order, 
		Compositional, and On-the-fly Verification Methods
		[21 pages]
		Abstract:
			It is desirable to integrate formal verification
		techniques applicable to different languages. We present 
		EXP.OPEN 2.0, a new tool of the CADP verification toolbox
		which combines several features. First, EXP.OPEN 2.0 allows
		to describe concurrent systems as a composition of finite
		state machines, using either synchronization vectors, or
		parallel composition, hiding, renaming, and cut operators
		from several process algebras (CCS, CSP, LOTOS, E-LOTOS,
		mCRL). Second, together with other tools of CADP, EXP.OPEN
		2.0 allows state space generation and on-the-fly exploration.
		Third, EXP.OPEN 2.0 implements on-the-fly partial order
		reductions to avoid the generation of irrelevant interleavings
		of independent transitions. Fourth, EXP.OPEN 2.0 allows to
		export models towards other tools using interchange formats
		such as automata networks and Petri nets. Finally, we show
		some practical applications and measure the efficiency of
		EXP.OPEN 2.0 on several	benchmarks.

	[Lang-06]:
		Refined Interfaces for Compositional Verification
		[22 pages]
		Abstract:
			The compositional verification approach of
		Graf & Steffen aims at avoiding state space explosion for
		individual processes of a concurrent system. It relies on
		interfaces that express the behavioural constraints imposed
		on each process by synchronization with the other processes,
		thus preventing the exploration of states and transitions
		that would not be reachable in the global state space. 
		Krimm & Mounier, and Cheung & Kramer proposed two techniques
		to generate such interfaces automatically. In this report,
		we propose a refined interface generation technique that
		derives the interface of a process automatically from the
		examination of (a subset of) concurrent processes. This
		technique is applicable to formalisms where concurrent
		processes are composed either using synchronization vectors
		or process algebra parallel composition operators (including
		those of CCS, CSP, muCRL, LOTOS, and E-LOTOS). We implemented
		this approach in the EXP.OPEN 2.0 tool of the CADP toolbox.
		Several experiments indicate state space reductions by more
		than two orders of magnitude for the largest processes.

	[Lang-Mateescu-09]:
		Partial Order Reductions using Compositional Confluence
		Detection
		[16 pages]
		Abstract:
			Explicit state methods have proven useful in verifying
		safety-critical systems containing concurrent processes that 
		run asynchronously and communicate. Such methods consist of 
		inspecting the states and transitions of a graph representation
		of the system. Their main limitation is state explosion, which
		happens when the graph is too large to be stored in the 
		available computer memory. Several techniques can be used
		to palliate state explosion, such as on-the-fly verification, 
		compositional verification, and partial order reductions. In 
		this paper, we propose a new technique of partial order 
		reductions based on compositional confluence detection (CCD), 
		which can be combined with the techniques mentioned above. 
		CCD is based upon a generalization of the notion of confluence
		defined by Milner and exploits the fact that synchronizing 
		transitions that are confluent in the individual processes 
		yield a confluent transition in the system graph. It thus 
		consists of analysing the transitions of the individual process
		graphs and the synchronization structure to identify
		such confluent transitions compositionally. Under some 
		additional conditions, the confluent transitions can be given 
		priority over the other transitions, thus enabling graph 
		reductions. We propose two such additional conditions: one 
		ensuring that the generated graph is equivalent to the original
		system graph modulo branching bisimulation, and one ensuring 
		that the generated graph contains the same deadlock states as 
		the original system graph. We also describe how CCD-based 
		reductions were implemented in the CADP toolbox, and present 
		examples and a case study in which adding CCD improves 
		reductions with respect to compositional verification and 
		other partial order reductions.

	[Crouzen-Lang-11]:
		Smart Reduction
		[15 pages]
		Abstract:
			Compositional aggregation is a technique to palliate 
		state explosion - the phenomenon that the behaviour graph of
		a parallel composition of asynchronous processes grows 
		exponentially with the number of processes - which is the
		main drawback of explicit-state verification. It consists in
		building the behaviour graph by incrementally composing and
		minimizing parts of the composition modulo an equivalence
		relation. Heuristics have been proposed for finding an
		appropriate composition order that keeps the size of the
		largest intermediate graph small enough. Yet the underlying
		composition models are not general enough for systems involving
		elaborate forms of synchronization, such as multiway and/or 
		nondeterministic synchronizations. We overcome this by
		proposing a generalization of compositional aggregation that
		applies to an expressive composition model based on
		synchronization vectors, subsuming many composition operators.
		Unlike some algebraic composition models, this model enables
		any composition order to be used. We also present an
		implementation of this approach within the CADP verification
		toolbox in the form of a new operator called smart reduction,
		as well as experimental results assessing the efficiency of
		smart reduction.

	See also the related manual pages at:
		http://cadp.inria.fr/man/exp.open.html
		http://cadp.inria.fr/man/exp2fc2.html
		http://cadp.inria.fr/man/projector.html
		http://cadp.inria.fr/man/svl.html
		http://cadp.inria.fr/man/reductor.html
		http://cadp.inria.fr/man/bcg_min.html

-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

Papers about distributed verification
-------------------------------------

	[Garavel-Mateescu-Smarandache-01]:
		Parallel State Space Construction for Model-Checking
		[20 pages]
		Abstract:
			The verification of concurrent finite-state systems by
           	model-checking often requires to generate (a large part of) the
		state space of the system under analysis. Because of the state
		explosion problem, this may be a resource-consuming operation,
		both in terms of memory and CPU time. In this report, we aim at
		improving the performances of state space construction by using
		parallelization techniques. We present parallel algorithms for
		constructing state spaces (or Labeled Transition Systems) on a
		network or a cluster of workstations. Each node in the network
		builds a part of the state space, all parts being merged to
		form the whole state space upon termination of the parallel
		computation. These algorithms have been implemented within the
		CADP verification tool set and experimented on various 
		concurrent applications specified in LOTOS. The results 
		obtained show linear speedups and a good load balancing
		between network nodes.

	[Joubert-Mateescu-05]:
		Distributed Local Resolution of Boolean Equation Systems
		[8 pages]
		Abstract:
			Boolean Equation Systems (BESs) allow to represent
		various problems encountered in the area of propositional
		logic programming and verification of concurrent systems.
		Several sequential algorithms for global and local BES
		resolution have been proposed so far, mainly in the field of
		verification; however, these algorithms do not scale up 
		satisfactorily as the size of BESs increases. In this paper,
		we propose a distributed algorithm, called DSOLVE, which
		performs the local resolution of a BES using a set of machines
		connected by a network. Our experiments for solving large BESs
		using clusters of PCs show linear speedups and a scalable
		behaviour of DSOLVE w.r.t. its sequential counterpart.

	[Garavel-Mateescu-Bergamini-et-al-06]:
		DISTRIBUTOR and BCG_MERGE: Tools for Distributed Explicit
		State Space Generation
		[5 pages]
		Abstract:
			The verification of complex finite-state systems, whose
		underlying state spaces may be prohibitively large, requires an
		important amount of memory and computation time. A natural way
		of scaling up the capabilities of verification tools is by
		exploiting the computing resources (memory and processors) of
		massively parallel machines, such as clusters and grids. This
		paper describes DISTRIBUTOR, a tool for generating state spaces
		in a distributed manner using a set of machines connected by a
		network. Each machine is responsible for generating and storing
		a part of the state space. Upon termination of the distributed
		generation, all parts generated by the machines are combined
		together using the BCG_MERGE tool in order to obtain the
		complete state space. DISTRIBUTOR was developed within the CADP
		verification toolbox using the generic OPEN/CAESAR environment
		for on-the-fly graph exploration. It exhibits good speedups
		compared to sequential tools, implements on-the-fly reductions
		of the state space, and provides graphical features for
		monitoring the distributed state space generation in real time.

	[Garavel-Mateescu-Serwe-12]:
		Large-scale Distributed Verification using CADP: Beyond
		Clusters to Grids
		[18 pages]
		Abstract:
			Distributed verification uses the resources of several
		computers to speed up the verification and, even more
		importantly, to access large amounts of memory beyond the
		capabilities of a single computer. In this paper, we describe
		the distributed verification tools provided by the CADP
		(Construction and Analysis of Distributed Processes) toolbox,
		especially focusing on its most recent tools for management,
		inspection, and on-the-fly exploration of distributed state
		spaces. We also report about large-scale experiments carried
		out using these tools on Grid'5000 using up to 512 distributed
		processes.

	See also the related manual pages at:
		http://cadp.inria.fr/man/distributor.html
		http://cadp.inria.fr/man/bcg_merge.html
		http://cadp.inria.fr/man/gcf.html
		http://cadp.inria.fr/man/pbg.html
		http://cadp.inria.fr/man/pbg.html
		http://cadp.inria.fr/man/pbg_cp.html
		http://cadp.inria.fr/man/pbg_info.html
		http://cadp.inria.fr/man/pbg_mv.html
		http://cadp.inria.fr/man/pbg_rm.html

-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

Papers about test generation
----------------------------

	[Fernandez-Jard-Jeron-et-al-96-a]:
		Using On-the-Fly Verification Techniques for the Generation
		of Test Suites
		[14 pages]
		Abstract:
			In this paper we attempt to demonstrate that on-the-fly
	        techniques, developed in the context of verification, can help
		in deriving test suites. Test purposes are used in practice to
		select test cases according to some properties of the
		specification. We define a consistency preorder linking test
		purposes and specifications. We give a set of rules to check
		this consistency and to derive a complete test case with
		preamble, postamble, verdicts and timers. The algorithm, 
		which implements the construction rules, is based on a depth
		first traversal of a synchronous product between the test
		purpose and the specification. We shortly relate our experience
		on an industrial protocol with TGV, a first prototype of the
		algorithm implemented as a component of the CADP toolbox.

	[Fernandez-Jard-Jeron-et-al-96-b]: 
		An Experiment in Automatic Generation of Test Suites for 
		Protocols with Verification Technology
		[23 pages]
		Abstract:
			In this report we describe an experiment in automatic
		generation of test suites for protocol testing. We report the
		results gained with generation of test suites based on advanced
		verification techniques applied to a real industrial protocol.
		In this experiment, several tools have been used: the
		commercial tool GEODE (VERILOG) was used for the generation of 
		finite state graph models from SDL specifications, the tool
		Aldebaran of the CADP toolbox for the minimization of 
		transition systems, and a prototype named TGV (for Test
		Generation using Verification techniques) for the generation 
		of test suites which has been developed in the CADP toolbox.
		TGV is based on verification techniques such as synchronous 
		product and on-the-fly verification. These tools have been 
		applied to an industrial protocol, the DREX protocol. The 
		comparison of produced test suites with hand written test 
		suites proves the relevance of the used techniques.

	[Jard-Jeron-05]:
		TGV: Theory, Principles and Algorithms - A Tool for the
		Automatic Synthesis of Conformance Test Cases for
		Non-Deterministic Reactive Systems
		[19 pages]
		Abstract:
			This paper presents the TGV tool, which allows for the
		automatic synthesis of conformance test cases from a formal
		specification of a (non-deterministic) reactive system. TGV
		was developed by Irisa Rennes and Verimag Grenoble, with the
		support of the Vasy team of Inria Rhone-Alpes. The paper
		describes the main elements of the underlying testing theory,
		which is based on a model of transitions system which
		distinguishes inputs, outputs and internal actions, and is
		based on the concept of conformance relation. The principles
		of the test synthesis process, as well as the main algorithms,
		are explained. We then describe the main characteristics of
		the TGV tool and refer to some industrial experiments that
		have been conducted to validate the approach. As a conclusion,
		we describe some ongoing work on test synthesis.

	See also the related manual pages at:
		http://cadp.inria.fr/man/tgv.html

	Other related papers (not included in the CADP distribution):

	[Kahlouche-Viho-Zendri-98]:
		An Industrial Experiment in Automatic Generation of Executable
		Test Suites for a Cache Coherency Protocol
		[16 pages]
		http://cadp.inria.fr/publications/Kahlouche-Viho-Zendri-98.html

	[Kahlouche-Viho-Zendri-99]:
		Hardware Testing using a Communication Protocol Conformance
		Testing Tool
		[15 pages]
		http://cadp.inria.fr/publications/Kahlouche-Viho-Zendri-99.html

	[Marsso-Mateescu-Serwe-18]:
		TESTOR: A Modular Tool for On-the-Fly Conformance Test Case
		Generation
		[17 pages]
		http://cadp.inria.fr/publications/Marsso-Mateescu-Serwe-18.html

-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

Papers about performance evaluation
-----------------------------------

	[Garavel-Hermanns-02]:
		On Combining Functional Verification and Performance 
		Evaluation using CADP
		[24 pages]
		Abstract:
			Considering functional correctness and performance
		evaluation in a common framework is desirable, both for
		scientific and economic reasons. In this paper, we describe
		how the CADP toolbox, originally designed for verifying the
		functional correctness of LOTOS specifications, can also be
		used for performance evaluation. We illustrate the proposed
		approach by the performance study of the SCSI-2 bus arbitration
		protocol. 

	[Hermanns-Joubert-03]:
		A  Set of Performance and Dependability Analysis Components 
		for CADP
		[6 pages]
		Abstract:
			This paper describes a set of analysis components that 
		open the way to perform performance and dependability analysis 
		with the CADP toolbox, originally designed for verifying the 
		functional correctness of LOTOS specifications. Three new 
		tools (named BCG_STEADY, BCG_TRANSIENT, and DETERMINATOR) have
		been added to the toolbox. The approach taken fits well within
		the existing architecture of CADP, which doesn't need to be 
		altered to enable performance evaluation.

	[Coste-Hermanns-Lantreibecq-Serwe-09]:
		Towards Performance Prediction of Compositional Models in
		Industrial GALS Designs
		[15 pages]
		Abstract:
			Systems and Networks on Chips (NoCs) are a prime design
		focus of many hardware manufacturers. In addition to functional
		verification, which is a difficult necessity, the chip
		designers are facing extremely demanding performance prediction
		challenges, such as the need to estimate the latency of memory
		accesses over the NoC. This paper attacks this problem in the
		setting of designing globally asynchronous, locally synchronous
		systems (GALS). We describe foundations and applications of a
		combination of compositional modeling, model checking, and
		Markov process theory, to arrive at a viable approach to 
		ompute performance quantities directly on industrial,
		functionally verified GALS models.

	[Coste-Garavel-Hermanns-et-al-10]:
		Ten Years of Performance Evaluation for Concurrent Systems
		Using CADP
		[15 pages]
		Abstract:
			This article comprehensively surveys the work
		accomplished during the past decade on an approach to analyze
		concurrent systems qualitatively and quantitatively, by
		combining functional verification and performance evaluation.
		This approach lays its foundations on semantic models, such
		as IMC (Interactive Markov Chain) and IPC (Interactive
		Probabilistic Chain), at the crossroads of concurrency theory
		and mathematical statistics. To support the approach, a number
		of software tools have been devised and integrated within the
		CADP (Construction and Analysis of Distributed Processes)
		toolbox. These tools provide various functionalities, ranging
		from state space generation (Caesar and Exp.Open), state space
		minimization (Bcg_Min and Determinator), numerical analysis
		(Bcg_Steady and Bcg_Transient), to simulation (Cunctator).
		Several applications of increasing complexity have been
		successfully handled using these tools, namely the Hubble 
		telescope lifetime prediction, performance comparison of mutual
		exclusion protocols, the SCSI-2 bus arbitration protocol, the
		Send/Receive and Barrier primitives of MPI (Message Passing
		Interface) implemented on a cache-coherent multiprocessor
		architecture, and the xSTream multiprocessor data-flow
		architecture for embedded multimedia streaming applications.

	See also the related manual pages at:
		http://cadp.inria.fr/man/bcg_min.html
		http://cadp.inria.fr/man/bcg_steady.html
		http://cadp.inria.fr/man/bcg_transient.html
		http://cadp.inria.fr/man/cunctator.html
		http://cadp.inria.fr/man/determinator.html
		http://cadp.inria.fr/man/evaluator5.html

        Other related papers (not included in the CADP distribution):

	[Coste-Garavel-Hermanns-et-al-08]:
		Quantitative Evaluation in Embedded System Design: Validation
                of Multiprocessor Multithreaded Architectures
		[2 pages, subsumed by Coste-Garavel-Hermanns-et-al-10]
		http://cadp.inria.fr/publications/Coste-Garavel-Hermanns-et-al-08.html

	[Chehaibar-Zidouni-Mateescu-09]: 
		Modeling Multiprocessor Cache Protocol Impact on MPI
		Performance
		[6 pages]
		http://cadp.inria.fr/publications/Chehaibar-Zidouni-Mateescu-09.html

-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

Papers about concurrency models
-------------------------------

	[Garavel-19]:
		Nested-Unit Petri Nets
		[51 pages]
		Abstract:
			Petri nets can express concurrency and nondeterminism
		but neither locality nor hierarchy. This article presents an
		extension of Petri nets, in which places can be grouped into
		so-called ``units'' expressing sequential components. Units
		can be recursively nested to reflect both the concurrent and
		hierarchical nature of complex systems. This model called
		NUPN (Nested-Unit Petri Nets) was originally developed for
		translating process calculi to Petri nets, but later found
		also useful beyond this setting. It allows significant savings
		in the memory representation of markings for both explicit-
		state and symbolic verification. Thirteen software tools
		already implement the NUPN model, which has also been adopted
		for the benchmarks of the Model Checking Contest (MCC) and
		the parallel problems of the Rigorous Examination of Reactive
		Systems (RERS) challenges.

	See also the related manual pages at:
		http://cadp.inria.fr/man/caesar.bdd.html
		http://cadp.inria.fr/man/nupn.html
		http://cadp.inria.fr/man/nupn_info.html

	Other related paper (not included in the CADP distribution):

	[Garavel-Lang-02]:
		NTIF: A General Symbolic Model for Communicating Sequential
		Processes with Data
		[30 pages]
		http://cadp.inria.fr/publications/Garavel-Lang-02.html

-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

Papers about translations for other languages
---------------------------------------------

* Papers about BPMN

	[Poizat-Salaun-Krishna-16]:
		Checking Business Process Evolution
		[18 pages]
		http://cadp.inria.fr/publications/Poizat-Salaun-Krishna-16.html

* Papers about CHP

	[Salaun-Serwe-05]:
		Translating Hardware Process Algebras into Standard Process
		Algebras - Illustration with CHP and LOTOS
		[25 pages, subsumed by Garavel-Salaun-Serwe-09]
		http://cadp.inria.fr/publications/Salaun-Serwe-05.html

	[Garavel-Salaun-Serwe-09]:
		On the Semantics of Communicating Hardware Processes and their
		Translation into LOTOS for the Verification of Asynchronous
		Circuits with CADP
		[35 pages]
		Abstract:
			Hardware process calculi, such as CHP (Communicating
		Hardware Processes), BALSA, or HASTE (formerly TANGRAM), are a
		natural approach for the description of asynchronous hardware
		architectures. These calculi are extensions of standard process
		calculi with particular synchronisation features implemented
		using handshake protocols.
			In this article, we first give a structural operational
		semantics for value-passing CHP. Compared to the existing
		semantics of CHP defined by translation into Petri nets, our
		semantics is general enough to handle value-passing CHP with
		communication channels open to the environment, and is also
		independent of any particular (2- or 4-phase) handshake
		protocol used for circuit implementation.
			We then describe the translation of CHP into the
		process calculus LOTOS (ISO standard 8807), in order to allow
		asynchronous hardware architectures expressed in CHP to be
		verified using the CADP verification toolbox for LOTOS. A
		translator from CHP to LOTOS has been implemented and
		successfully used for the compositional verification of two
		industrial case studies, namely an asynchronous implementation
		of the DES (Data Encryption Standard) and an asynchronous
		interconnect of a NoC (Network on Chip).

* Papers about FSP

	[Lang-Salaun-Herilier-et-al-10]
		Translating FSP into LOTOS and Networks of Automata
		[34 pages]
		Abstract:
			Many process calculi have been proposed since Robin
		Milner and Tony Hoare opened the way more than 25 years ago.
		Although they are based on the same kernel of operators, most
		of them are incompatible in practice. We aim at reducing the
		gap between process calculi, and especially making possible
		the joint use of underlying tool support. FSP is a widely-used
		calculus equipped with LTSA, a graphical and user-friendly
		tool. LOTOS is the only process calculus that has led to an
		international standard, and is supported by the CADP
		verification toolbox. We propose a translation of FSP
		sequential processes into LOTOS. Since FSP composite processes
		(i.e., parallel compositions of processes) are hard to encode
		directly in LOTOS, they are translated into networks of
		automata which are another input language accepted by CADP.
		Hence, it is possible to use jointly LTSA and CADP to validate
		FSP specifications. Our approach is completely automated by a
		translator tool.

* Papers about GALS

	[Garavel-Thivolle-09]:
		Verification of GALS Systems by Combining Synchronous
		Languages and Process Calculi
		[20 pages]
                http://cadp.inria.fr/publications/Garavel-Thivolle-09.html

* Papers about Pi-Calculus

	[Mateescu-Salaun-10]:
		Translating Pi-Calculus into LOTOS NT
		[16 pages]
                http://cadp.inria.fr/publications/Mateescu-Salaun-10.html

* Papers about SystemC/TLM

	[Helmstetter-Ponsini-08]:
		A Comparison of Two SystemC/TLM Semantics for Formal
		Verification 
		[10 pages]
		http://cadp.inria.fr/publications/Helmstetter-Ponsini-08.html

	[Ponsini-Serwe-08]:
		A Schedulerless Semantics of TLM Models Written in SystemC via
		Translation into LOTOS
		[16 pages]

	[Garavel-Helmstetter-Ponsini-Serwe-09]:
		Verification of an Industrial SystemC/TLM Model using LOTOS
		and CADP
		[10 pages]
		http://cadp.inria.fr/publications/Garavel-Helmstetter-Ponsini-Serwe-09.html

	[Helmstetter-09]: 
		TLM.OPEN: a SystemC/TLM Front-End for the CADP Verification
		Toolbox
		[9 pages]
                http://cadp.inria.fr/publications/Helmstetter-09.html

-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

Papers about case studies and applications
------------------------------------------

	Case-study papers are available from:
	http://cadp.inria.fr/case-studies

-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

Remarks
-------

- Because some of these technical papers were published long time ago, the
  author affiliations, addresses, phone/fax numbers, and e-mail addresses
  mentioned in these papers may have changed.

- Until November 2015, the present directory contained another sub-directory
  'ps' with the same papers in Adobe's PostScript format. The 'ps' directory
  was removed to save disk space, but the PostScript files can still be
  downloaded from ftp://ftp.inrialpes.fr/pub/vasy/publications/cadp

- In February 2016, to further save disk space, 73 papers in PDF format
  have been removed from the 'pdf' directory. These papers can still be
  downloaded from http://cadp.inria.fr/publications/all.html

-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

