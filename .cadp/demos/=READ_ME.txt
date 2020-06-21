-- CADP (CONSTRUCTION AND ANALYSIS OF DISTRIBUTED PROCESSES)
-- http://cadp.inria.fr

This directory contains various examples that explain how the CADP 
tools can be used on various examples. More details are given in the 
demo_*/=READ_ME.txt files.

The examples are listed below:

	- demo_01:  Alternating bit without data part 
		    [Hubert Garavel, Radu Mateescu, Severine Simon, and
		    Frederic Lang]
		    Tools used: CAESAR, BISIMULATOR, EVALUATOR, SVL, TGV, XTL

	- demo_02:  Alternating bit with data part 
		    [Hubert Garavel, Radu Mateescu, Laurent Mounier, and
		    Frederic Lang]
		    Tools used: CAESAR, CAESAR.ADT, BCG_MIN, BISIMULATOR,
		    EVALUATOR, SVL, XTL

	- demo_03:  (left temporarily empty)

	- demo_04:  Systolic arrays for convolution product 
		    [Hubert Garavel]
		    Tools used: CAESAR, CAESAR.ADT, ALDEBARAN, SVL

	- demo_05:  Airplane-ground communication protocol
		    [Damien Thivolle, Hubert Garavel, and Frederic Lang]
		    Tools used:  CAESAR, CAESAR.ADT, BCG_MIN, EVALUATOR,
		    EXP.OPEN, LNT2LOTOS, PROJECTOR, SVL

	- demo_06:  Transport Layer Security (LTS 1.3) handshake protocol
		    [Lina Marsso]
		    Tools used: CAESAR, CAESAR.ADT, BCG_MIN, LNT2LOTOS,
		    SVL, TGV

	- demo_07:  Car overtaking protocol 
		    [P. Ernberg, L. Fredlund, B. Jonsson (SICS)]
		    Tools used: CAESAR, CAESAR.ADT, BCG_MIN, BISIMULATOR,
		    OPEN/CAESAR, SVL

	- demo_08:  rel/REL protocol 
		    [Laurent Mounier, Hubert Garavel, and Frederic Lang]
		    Tools used: CAESAR, CAESAR.ADT, BCG_MIN, BISIMULATOR,
		    OPEN/CAESAR, SVL

	- demo_09:  INRES protocol 
		    [Ana Cavalli et al., Hubert Garavel, Severine Simon]
		    Tools used: CAESAR, CAESAR.ADT, BISIMULATOR, OPEN/CAESAR,
		    TGV

	- demo_10:  (left temporarily empty)

	- demo_11:  Dynamic Task Dispatcher
		    [Etienne Lantreibecq and Wendelin Serwe]
		    Tools used: BCG_MIN, EVALUATOR 4.0, LNT.OPEN, SVL

	- demo_12:  Message Authenticator Algorithm, ISO standard 8731-2
		    formally described by Harold Munster (NPL) 
		    [Hubert Garavel, Philippe Turlier, Radu Mateescu,
		    Wendelin Serwe, and Lina Marsso]
		    Tools used: LNT2LOTOS, CAESAR.ADT

	- demo_13:  Collection of BCG graphs to be displayed using BCG_DRAW
		    [Radu Mateescu and Hubert Garavel]
		    Tools used: BCG_DRAW

	- demo_14:  Plain Old Telephony System (POTS), specified by Patrick
		    Ernberg (SICS)
		    [Laurent Mounier, Radu Mateescu, Frederic Lang, and
		    Hubert Garavel]
		    Tools used: LNT2LOTOS, CAESAR, CAESAR.ADT, BCG_MIN,
		    OPEN/CAESAR, BISIMULATOR, EVALUATOR, SVL

	- demo_15:  (left temporarily empty)

	- demo_16:  Philips' Bounded Retransmission Protocol specified in
		    LOTOS and verified using ACTL temporal logic formulas
		    [Radu Mateescu, Hubert Garavel, Julien Jacques Maurer,
		    and Jose-Ignacio Requeno]
		    Tools used: LNT2LOTOS, CAESAR, CAESAR.ADT, BCG,
		    BISIMULATOR, SVL, XTL

	- demo_17:  Distributed Leader Election Algorithms
		    [Hubert Garavel, Laurent Mounier, Frederic Lang, and
		    Wendelin Serwe]
		    Tools used: CAESAR, CAESAR.ADT, LNT.OPEN, BCG_MIN,
		    OPEN/CAESAR, BISIMULATOR, EXHIBITOR, TERMINATOR, SVL.

	- demo_18:  Transit Node message router
		    [Laurent Mounier, Frederic Lang, and Hubert Garavel]
		    Tools used: CAESAR, CAESAR.ADT, BCG_MIN, EXP.OPEN,
		    LNT2LOTOS, SVL

	- demo_19:  Production Cell case-study, where a formal description
		    is used to control a metal plant simulated by a Tcl/Tk
		    animated interface 
		    [Hubert Garavel, Mark Jorgensen, and Wendelin Serwe]
		    Tools used: CAESAR, CAESAR.ADT, EXEC/CAESAR, LNT2LOTOS

	- demo_20:  rel/REL protocol (see demo_08) but with
		    four stations verified compositionally
		    [Laurent Mounier, Radu Mateescu, and Frederic Lang]
		    Tools used: BCG, BISIMULATOR, CAESAR, CAESAR.ADT,
		    EVALUATOR, OPEN/CAESAR, PROJECTOR, SVL

	- demo_21:  Peterson's mutual exclusion algorithm specified in
		    LOTOS and verified using LTAC temporal logic formulas
		    [Radu Mateescu, Frederic Lang, Hubert Garavel, and
		    Gianluca Barbon]
		    Tools used: CAESAR, CAESAR.ADT, EVALUATOR, LNT2LOTOS,
		    SVL, XTL

	- demo_22:  Dekker's mutual exclusion algorithm specified in
		    LOTOS and verified using LTAC temporal logic formulas
		    [Radu Mateescu, Frederic Lang, Hubert Garavel, and
		    Gianluca Barbon]
		    Tools used: CAESAR, CAESAR.ADT, EVALUATOR, LNT2LOTOS,
		    SVL, XTL

	- demo_23:  IEEE 1394 high performance serial bus ("Firewire")
		    specified in LOTOS
		    [Mihaela Sighireanu, Radu Mateescu, and Frederic Lang]
		    Tools used: CAESAR, CAESAR.ADT, BCG, SVL, XTL

	- demo_24:  CO4 protocol for distributed knowledge bases specified 
		    in LOTOS
		    [Charles Pecheur and Frederic Lang]
		    Tools used: CAESAR, CAESAR.ADT, ALDEBARAN, EXHIBITOR, 
		    TERMINATOR, BCG_DRAW, SVL

	- demo_25:  Cluster File System (CFS) specified in LOTOS
		    [Charles Pecheur, Frederic Lang, and Hubert Garavel]
		    Tools used: BCG_MIN, CAESAR, CAESAR.ADT, EXP.OPEN, SVL, XTL

	- demo_26:  Invoicing case study specified in LOTOS
		    [Mihaela Sighireanu, Ken Turner, and Frederic Lang]
		    Tools used: CAESAR, CAESAR.ADT, BCG_MIN, BISIMULATOR, SVL,
		    XTL

	- demo_27:  HAVi (Home Audio-Video) leader election protocol 
		    [Judi Romijn, Radu Mateescu, and Frederic Lang]
		    Tools used: CAESAR, EXP.OPEN, BCG_MIN, SVL, XTL

	- demo_28:  Directory-based cache coherency protocol
		    [Massimo Zendri, Hubert Garavel, Frederic Lang, Abderahman
		    Kriouile, and Wendelin Serwe]
		    Tools used: BCG_MIN, CAESAR, CAESAR.ADT, LNT2LOTOS, SVL

	- demo_29:  Dynamic reconfiguration protocol for mobile agents
		    [Manuel Aguilar Cornejo, Hubert Garavel, Radu Mateescu,
		    and Noel de Palma]
		    Tools used: BCG_MIN, BISIMULATOR, CAESAR, CAESAR.ADT,
		    EVALUATOR, LNT2LOTOS, SVL

	- demo_30:  Hubble space telescope lifetime
		    [Holger Hermanns, Christophe Joubert, Hubert Garavel, and
		    Wendelin Serwe]
		    Tools used: CAESAR, CAESAR.ADT, BCG_MIN, BCG_TRANSIENT,
		    LNT2LOTOS, SVL

	- demo_31:  SCSI-2 bus arbitration protocol
		    [Hubert Garavel, Holger Hermanns, Radu Mateescu,
		    Christophe Joubert, David Champelovier, and Frederic Lang]
		    Tools used: CAESAR, CAESAR.ADT, BCG_MIN, BCG_STEADY,
		    DETERMINATOR, EVALUATOR, LNT2LOTOS, SVL

	- demo_32:  Sequentially consistent, distributed cache memory
		    [Susanne Graf, Wendelin Serwe, Abderahman Kriouile, and
		    Hubert Garavel]
		    Tools used: CAESAR, CAESAR.ADT, LNT2LOTOS, BISIMULATOR,
		    BCG_MIN, SVL 	

	- demo_33:  Randomized binary distributed consensus protocol
		    [Frederic Tronel and Frederic Lang]
		    Tools used: CAESAR, CAESAR.ADT, BCG_GRAPH, BISIMULATOR,
		    PROJECTOR, SVL

	- demo_34:  Computer integrated manufacturing (CIM) architecture
		    [Radu Mateescu]
		    Tools used: BCG_MIN, CAESAR, CAESAR.ADT, EVALUATOR, SVL

	- demo_35:  Distributed summation algorithm using "n among m"
                    synchronization
		    [Frederic Lang, Marius Hollinger, Hubert Garavel]
		    Tools used: BCG_MIN, CAESAR, CAESAR.ADT, EXP.OPEN,
		    LNT2LOTOS, SVL

	- demo_36:  Distributed Erathostenes sieve
		    [Frederic Lang, Hubert Garavel, Gianluca Barbon, and
		    Radu Mateescu]
		    Tools used: BCG_LABELS, BCG_MIN, BISIMULATOR, CAESAR,
		    CAESAR.ADT, EVALUATOR4, EXP.OPEN, LNT2LOTOS, SVL

	- demo_37:  ODP (Open Distributed Processing) trader
		    [Frederic Lang]
		    Tools used: BCG_MIN, BISIMULATOR, CAESAR.ADT, CAESAR,
		    EXP.OPEN, PROJECTOR, SVL

	- demo_38:  Asynchronous circuit for the DES (Data Encryption Standard)
		    [Wendelin Serwe and Hubert Garavel]
		    Tool used: BCG_MIN, BISIMULATOR, CAESAR.ADT, CAESAR,
		    EXEC/CAESAR, EXP.OPEN, LNT2LOTOS, PROJECTOR, SVL

        - demo_39:  Turntable system for drilling products
                    [Radu Mateescu]
                    Tools used: BCG_MIN, BCG_STEADY, BISIMULATOR, CAESAR,
		    CAESAR.ADT, DETERMINATOR, EVALUATOR, SVL

	- demo_40:  Web services for stock management and on-line book auction
                    [Antonella Chirichiello, Gwen Salaun, and Wendelin Serwe]
                    Tools used: CAESAR, CAESAR.ADT, EVALUATOR, SVL

