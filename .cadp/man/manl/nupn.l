.\" @(#)nupn.l - VASY and CONVECS teams - 2020/03/21
.TH NUPN LOCAL "2020/03/21" "(C) INRIA" "CADP MANUAL PAGES"
.fp 4 CB
.lg 0
.SH NAME
nupn, NUPN \- Nested-Unit Petri Nets

.SH DESCRIPTION

.P
Nested-Unit Petri Nets (NUPN, for short) are a theoretical model of concurrency. Technically, they extend ordinary, one-safe Petri Nets with structure and locality, by grouping sets of places into hierarchically nested "units". This semantic model is particularly suitable when translating specifications written in high-level concurrent languages (such as process calculi), as structural information can be preserved to make later analyses more efficient and scalable. For further details, refer to the [Gar19] paper listed below in the BIBLIOGRAPHY section.

.P
In practice, the theoretical NUPN model is implemented in two different ways:
.IP -
An NUPN-specific extension of the standard PNML format has been proposed in December 2015. This extension is documented by the http://mcc.lip6.fr/nupn.php page and is supported by many model checkers, among which ITS-Tools (Paris), LTSmin (Twente), and PNMC (Toulouse). Models encoded using this extension of PNML are stored in files having the \fB.pnml\fP suffix.

.IP -
Alternately, a simple file format for representing NUPN models has been present in the CADP toolbox since July 2004 with gradual evoluations. This format was designed to be readable by humans, as well as easy to generate and parse using tools. Models encoded using this format are stored in files having the \fB.nupn\fP suffix.

.P
The remainder of this manual page defines the latter format, which is referred to as the "NUPN format".

.P
Conversion from PNML to NUPN can be done using the PNML2NUPN tool (see below), whereas conversion from NUPN to PNML (with NUPN-specific extension) can be achieved by invoking the
.BR caesar.bdd (LOCAL)
tool with its \fB-pnml\fP option.

.SH SYNTAX OF THE N\&U\&P\&N FORMAT

The format of \fIfilename\fP\fB.nupn\fP is defined by the following BNF 
grammar (where \fB<element>?\fP denotes zero or one ocurrences of 
\fB<element>\fP, where \fB<element>*\fP denotes zero or many occurrences
of \fB<element>\fP, and where "nb" stands for "number"): 

.nf
<nested-unit-petri-net> ::= 
   <pragma-description>*
   places #<nb-of-places> <min-place-nb>...<max-place-nb>\\n
   <initial-marking-description>
   units #<nb-of-units> <min-unit-nb>...<max-unit-nb>\\n
   root unit <root-unit-nb>\\n
   <unit-description>*\\n
   transitions #<nb-of-trans> <min-trans-nb>...<max-trans-nb>\\n
   <trans-description>*\\n
   <label-description>?
.fi

.nf
<pragma-description> ::= !<character-string>\\n
.fi

.nf
<initial-marking-description> ::=
   initial place <init-place-nb>\\n
 | initial places #<nb-of-initial-places> <initial-place-list>\\n
.fi

.nf
<unit-description> ::=
   U<unit-nb>
   #<nb-of-subplaces> <min-subplace-nb>...<max-subplace-nb>
   #<nb-of-subunits> <subunit-list>\\n
.fi

.nf
<trans-description> ::=
   T<trans-nb> 
   #<nb-of-input-places> <input-place-list>
   #<nb-of-output-places> <output-place-list>\\n
.fi

.nf
<label-description> ::=
   labels <place-flag> <trans-flag> <unit-flag> <label-length>\\n
   <place-label>*
   <trans-label>*
   <unit-label>*
.fi

.nf
<place-label> ::= p<place-nb> <label>\\n
<trans-label> ::= t<trans-nb> <label>\\n
<unit-label>  ::= u<unit-nb> <label>\\n
.fi

.nf
<initial-place-list>   ::= <place-nb>*
<input-place-list>     ::= <place-nb>*
<output-place-list>    ::= <place-nb>*
<subunit-list>         ::= <unit-nb>*
.fi

.nf
<nb-of-places>         ::= <unsigned-integer>
<min-place-nb>         ::= <unsigned-integer>
<max-place-nb>         ::= <unsigned-integer>
<init-place-nb>        ::= <unsigned-integer>
<place-nb>             ::= <unsigned-integer>
<nb-of-units>          ::= <unsigned-integer>
<min-unit-nb>          ::= <unsigned-integer>
<max-unit-nb>          ::= <unsigned-integer>
<root-unit-nb>         ::= <unsigned-integer>
<unit-nb>              ::= <unsigned-integer>
<nb-of-trans>          ::= <unsigned-integer>
<min-trans-nb>         ::= <unsigned-integer>
<max-trans-nb>         ::= <unsigned-integer>
<nb-of-subplaces>      ::= <unsigned-integer>
<min-subplace-nb>      ::= <unsigned-integer>
<max-subplace-nb>      ::= <unsigned-integer>
<nb-of-subunits>       ::= <unsigned-integer>
<trans-nb>             ::= <unsigned-integer>
<nb-of-input-places>   ::= <unsigned-integer>
<nb-of-output-places>  ::= <unsigned-integer>
<label-length>         ::= <unsigned-integer>
.fi

.nf
<place-flag>           ::= 0 | 1
<trans-flag>           ::= 0 | 1
<unit-flag>            ::= 0 | 1
.fi

.nf
<label>                ::= <character-string>
.fi

.P
In order to keep the NUPN format simple and easy to process using script languages (such as Awk), the rules for spacing are strict: tabulations are prohibited; multiple spaces are not allowed where a single space is; spaces are not permitted at the beginning or end of a line; empty or blank lines are forbidden.

.P
Note 1: inserting spaces just after "!" and "#", or around "..." is not 
permitted by the syntax. 

.P
Note 2: in <initial-marking-description>, the first form:
.nf
   initial place <init-place-nb>\\n
.fi
is a shorthand for the second form and, namely, is equivalent to:
.nf
   initial places #1 <init-place-nb>\\n
.fi
The first form is an early syntax, kept for backward compatibility reasons.
In the sequel, we may only consider the second form.

.P
Note 3: unless otherwise stated, all <unsigned-integer> values are assumed to be smaller than 2^31.

.SH STATIC SEMANTICS OF THE N\&U\&P\&N FORMAT
A few preliminary definitions are needed:
.IP -
Let Length (L) denote the length of a list L whose elements belong to the syntactic categories <place-nb> or <unit-nb>; the length of an empty list is zero.
.IP -
Let Unit (<place-nb>) be the <unit-nb> associated with the <unit-description> whose interval <min-subplace-nb>...<max-subplace-nb> contains <place-nb>.
.IP -
Let Sub (u1, u2) be the predicate that is true iff the unit numbered u1 is a sub-unit of the unit numbered u2, i.e., iff there exists a <unit-description> whose <unit-nb> is u2 and whose <subunit-list> contains u1.
.IP -
Let Sub* (u1, u2) be the transitive closure of Sub (u1, u2), i.e., the predicate that is true iff the unit numbered u1 is transitively included in (but not equal to) the unit numbered u2.
.IP -
Let Disjoint (u1, u2) be the predicate that is true iff both units numbered u1 and u2 are neither equal nor transitively included in each other, i.e., iff (u1 <> u2) and not Sub* (u1, u2) and not Sub* (u2, u1).

.P
A valid NUPN file should satisfy the following constraints:

.nf
In <nested-unit-petri-net>:
  1.  <nb-of-places> > 0     -- a net has at least one place
  2.  <max-place-nb> - <min-place-nb> + 1 = <nb-of-places>
  3.  <nb-of-units> > 0     -- a net has at least one unit
  4.  <max-unit-nb> - <min-unit-nb> + 1 = <nb-of-units>
  5.  <min-unit-nb> <= <root-unit-nb> <= <max-unit-nb>
  6.  <nb-of-trans> >= 0    -- a net may have zero transition
  7.  <nb-of-trans> = 0 => <min-trans-nb> = 1 and <max-trans-nb> = 0
      -- the empty interval of transitions is canonically noted 1...0
  8.  <max-trans-nb> - <min-trans-nb> + 1 = <nb-of-trans>
.fi

.nf
In <initial-marking-description>:
  9.  <min-place-nb> <= <init-place-nb> <= <max-place-nb>
 10.  0 <= <nb-of-initial-places> <= <nb-of-places>
 11.  Length (<initial-place-list>) = <nb-of-initial-places>
 12.  for each pair <place-nb> and <place-nb>' in <initial-place-list>
      one must have: Disjoint (Unit (<place-nb>), Unit (<place-nb>'))
      -- the initial places must belong to disjoint units (and are
      -- thus pairwise distinct); see discussion below about this rule
.fi

.nf
In each <unit-description>:
 13.  <min-unit-nb> <= <unit-nb> <= <max-unit-nb>
 14.  0 <= <nb-of-subplaces> <= <nb-of-places>
 15.  <nb-of-subplaces> = 0 => <min-subplace-nb> = 1
                           and <max-subplace-nb> = 0
      -- the empty interval of places is canonically noted 1...0
 16.  <min-place-nb> <= <min-subplace-nb> <= <max-place-nb>
 17.  <min-place-nb> <= <max-subplace-nb> <= <max-place-nb>
 18.  <max-subplace-nb> - <min-sublace-nb> + 1 = <nb-of-subplaces>
 19.  0 <= <nb-of-subunits> <= <nb-of-units>
 20.  Length (<subunit-list>) = <nb-of-subunits>
.fi

.nf
Globally to all <unit-description>s:
 21.  each <unit-nb> occurs once and only once after a "U"
 22.  the sum of all <nb-of-subplaces> is equal to <nb-of-places>
 23.  all intervals <min-subplace-nb>...<max-subplace-nb> form
      a partition of <min-place-nb>...<max-place-nb>
 24.  the sum of all <nb-of-subunits> is equal to <nb-of-units> - 1
 25.  <root-unit-number> and all non-empty <subunit-list>s form
      a partition of <min-unit-nb>...<max-unit-nb>
.fi

.nf
In each <subunit-list>:
 26.  <min-unit-nb> <= <unit-nb> <= <max-unit-nb>
 27.  <unit-nb> != <root-unit-nb> -- the root unit is not a
                                  -- sub-unit of any other unit
.fi

.nf
In each <trans-description>:
 28.  <min-trans-nb> <= <trans-nb> <= <max-trans-nb>
 29.  0 <= <nb-of-input-places> <= <nb-of-places>
 30.  Length (<input-place-list>) = <nb-of-input-places>
 31.  0 <= <nb-of-output-places> <= <nb-of-places>
 32.  Length (<output-place-list>) = <nb-of-output-places>
 33.  <input-place-list> is included in <output-place-list>
      => <input-place-list> is equal to <output-place-list>
      -- see discussion below about this rule
.fi

.nf
Globally to all <trans-description>s:
 34.  each <trans-nb> occurs once and only once after a "T"
.fi

.nf
In each <input-place-list> and each <output-place-list>:
 35.  <min-place-nb> <= <place-nb> <= <max-place-nb>
 36.  for each pair <place-nb> and <place-nb>' in the list, one
      must have: Disjoint (Unit (<place-nb>), Unit (<place-nb>'))
      -- the input (resp. output) places of each transition must
      -- belong to disjoint units (and are thus pairwise distinct);
      -- see discussion below about this rule
.fi

.nf
In <label-description>:
 37. if <place-flag> = 0, there are no occurrences of <place-label>
     -- places are not labelled
 38. if <place-flag> = 1, there are <nb-of-places> occurrences of
     <place-label> -- all places are labelled
 39. if <trans-flag> = 0, there are no occurrences of <trans-label>
     -- transitions are not labelled
 40. if <trans-flag> = 1, there are <nb-of-trans> occurrences of
     <trans-label> -- all transitions are labelled
 41. <nb-of-trans> = 0 => <trans-flag> = 0
 42. if <unit-flag> = 0, there are no occurrences of <unit-label>
     -- units are not labelled
 43. if <unit-flag> = 1, there are <nb-of-units> occurrences of
     <unit-label> -- all units are labelled
.fi

.nf
In each <place-label>:
 44. <min-place-nb> <= <place-nb> <= <max-place-nb>
.fi

.nf
Globally to all <place-label>s:
 45. each <place-nb> occurs once and only once after a "p"
     -- thus all <place-nb>s are pairwise distinct, but it is not
     -- required that all <character-string>s are pairwise distinct
.fi

.nf
In each <trans-label>:
 46. <min-trans-nb> <= <trans-nb> <= <max-trans-nb>
.fi

.nf
Globally to all <trans-label>s:
 47. each <trans-nb> occurs once and only once after a "t"
     -- thus all <trans-nb>s are pairwise distinct, but it is not
     -- required that all <character-string>s are pairwise distinct
.fi

.nf
In each <unit-label>:
 48. <min-unit-nb> <= <unit-nb> <= <max-unit-nb>
.fi

.nf
Globally to all <unit-label>s:
 49. each <unit-nb> occurs once and only once after a "u"
     -- thus all <unit-nb>s are pairwise distinct, but it is not
     -- required that all <character-string>s are pairwise distinct
.fi

.nf
In each <label>:
 50. strlen (<character-string>) <= <label-length>
.fi

.P
Note 1: It is possible that:
.nf
   <nb-of-units> <= <nb-of-places>
.fi
in the case, e.g., where all places are contained in one single unit.
Conversely, it is also possible that:
.nf
   <nb-of-places> <= <nb-of-units>
.fi
in the case, e.g., where each place is contained in a specific unit.

.P
Note 2: when there is a single initial place, it is often in the root unit, but this is not mandatory (this would be even impossible when the root unit has no local place).

.P
Note 3: as stated in constraints 46, 49, and 52, the labelling of places,
transitions, and units is not necessarily injective. For instance, several
transitions may share the same label (e.g., the label "i" used to denote 
internal transitions in concurrent languages such as LOTOS and LNT).

.SH DYNAMIC SEMANTICS OF THE N\&U\&P\&N FORMAT

The dynamic semantics of Nested-Unit Petri Nets follows the same rules as Petri Nets that are ordinary (i.e., all arcs have multiplicity one) and safe (i.e., each place contains at most one token):
.IP -
Initially, only the initial places (which are defined in the <initial-marking-description>) have a token.
.IP -
A transition can fire iff all its input places have a token.
.IP -
When a transition fires, its input places lose their token and its output place get a token.

.P
Additionally, each reachable marking M should satisfy the "unit safe" property, which is defined as follows:
.IP (1)
If M has a token in some place P, then M has no token in any other place P' local to the same unit as P, i.e., Unit (P) = Unit (P'). The particular case where P=P' prohibits having two tokens in the same place, thus implying that the net is one-safe.

.IP (2)
If M has a token in some place P local to U = Unit (P), there is no token in any place local to any other unit U' that transitively contains U or is transitively contained in U, i.e., Sub* (U, U') or Sub* (U', U). Said differently, if a unit is active, all its ancestor units and descendent units are inactive. 

.P
Conditions (1) and (2) can be summarized as follows: a marking M is unit safe iff for each pair of places P and P' marked in M, P <> P' => Disjoint (Unit (P), Unit (P')).

.P
Deciding whether all reachable markings of a NUPN model are unit safe requires, in general, to build the graph of reachable markings. However, some structural checks allow to detect, on the basis of sufficient conditions, certain NUPN models that are likely not to be unit safe. This is the case of three aforementioned rules of the static semantics:

.IP -
Rule 12 checks that the initial marking is unit safe.
.IP -
Rule 34 warns about transitions T whose input places are a strict subset of output places, as such transitions, if fireable, would accumulate an infinite number of tokens in their output places that are not input places.
.IP -
Rule 37 checks, for each transition T, that the set of input places of T is unit safe (otherwise, T could not fire from any unit safe marking) and that the set of output places of T is unit safe too (otherwise, firing T would produce markings that would not be unit safe).

.P
Note: it is neither required that a NUPN is connected, nor that all places can be reachable from the initial marking, nor that all transitions are quasi-live (i.e., can be fired from at least one reachable marking). However, 
.B caesar.bdd (LOCAL)
invoked with option
.B -check
warns about such situations.

.SH SUPPORTED PRAGMAS OF THE N\&U\&P\&N FORMAT
Pragmas provide optional information about a NUPN model. If present, pragmas occur at the very beginning of a NUPN file; they always start with the "!" character and terminate with the end of the line. The following pragmas are currently supported:

.SS PRAGMA "CREATOR"
The syntax of this pragma is:
.nf
   !creator <character-string>
.fi

.P
<character-string> should contain the name of the tool that produced the NUPN file, possibly followed by the version number of this tool and (if relevant) the command-line options given to this tool when it was invoked. This pragma is mostly intended for traceability.

.SS PRAGMA "UNIT_SAFE"
The syntax of this pragma is either:
.nf
   !unit_safe
.fi
or:
.nf
   !unit_safe <character-string>
.fi

.P

If present, this pragma certifies that all reachable markings of the NUPN model are unit safe. In the first form, unit safeness is certified by the creator tool (if the "!creator" pragma is present). In the second form, unit safeness has been certified by another tool, the name, version number, and (if relevant) command-line options are given in <character-string>.

.SS PRAGMA "MULTIPLE_INITIAL_TOKENS"
The syntax of this pragma is:
.nf
   !multiple_initial_tokens #<nb-tokens>
   #<nb-places> <min>...<max>
.fi
As for all pragmas, these syntactic elements must appear on one single line.

.P
<nb-tokens>, <min>, and <max> are unsigned integers that may be greater than 2^31 but must be smaller than 2^63.

.P
By inserting this pragma, the creator tool indicates that the NUPN model has been derived from a original Petri Net, in the initial marking of which certain places contain more than one token. In the NUPN model, the initial number of tokens in such places is implicitly reduced to one.

.P
Thus, this pragma and the \fBunit_safe\fP pragma are mutually exclusive.

.P
The arguments of this pragma are computed, on the original Petri Net, as follows:
.IP -
<nb-tokens> gives the sum of tokens initially contained in all the initial places (either marked with a single or multiple tokens).
.IP -
<nb-places> gives the number of places that initially contain multiple tokens.
.IP - 
<min> and <max> give respectively the minimum (greater than one) and maximum number of initial tokens present in the places that initially contain multiple tokens.

.P
The following constraints should hold, where <nb-of-initial-places> denotes the number of initial places given in the <initial-marking-description>:  
.nf
   <nb-of-initial-places> + <nb-places> * (<min> - 1)
   <= <nb-tokens> <=
   <nb-of-initial-places> + <nb-places> * (<max> - 1)
.fi

.SS PRAGMA "MULTIPLE_ARCS"
The syntax of this pragma is:
.nf
   !multiple_arcs
   #<nb-trans-in> #<nb-trans-out> #<nb-trans-inout>
   <min-in>...<max-in> <min-out>...<max-out>
   <min-diff>...<max-diff>
.fi
As for all pragmas, these syntactic elements must appear on one single line.

.P
By inserting this pragma, the creator tool indicates that the NUPN model has been derived from a original Petri Net that is not ordinary, i.e., in which certain input arcs (i.e., from a place to a transition) and/or output arcs (i.e., from a transition to a place) have a valuation (or "inscription", in PNML terminology) greater than one. Such arcs are called "multiple input arcs" and "multiple output arcs", respectively. In the NUPN model, there are no multiple arcs.

.P
Thus, this pragma and the \fBunit_safe\fP pragma are mutually exclusive.

.P
The arguments of this pragma are computed, on the original Petri Net, as follows:
.IP -
<nb-trans-in> gives the number of transitions having at least one multiple input arc and no multiple output arc.
.IP -
<nb-trans-out> gives the number of transitions having no multiple input arc and at least one multiple output arc. 
.IP -
<nb-trans-inout> gives the number of transitions having at least one multiple input arc and at least one multiple output arc. At least one among <nb-trans-in>, <nb-trans-out>, and <nb-trans-inout> must be non-null.
.IP -
<min-in> and <max-in> give respectively the minimum (greater than one) and maximum valuations of multiple input arcs. In absence of such arcs (i.e., when <nb-trans-in> and <nb-trans-inout> are both null), <min-in> and <max-in> must be equal to 1 and 0, respectively.
.IP -
<min-out> and <max-out> give respectively the minimum (greater than one) and maximum valuations of multiple output arcs. In absence of such arcs (i.e., when <nb-trans-out> and <nb-trans-inout> are both null), <min-out> and <max-out> must be equal to 1 and 0, respectively.
.IP -
<min-diff> and <max-diff> give the minimum and maximum, for all transitions T, of OutVal (T) - InVal (T), where InVal (T) and OutVal (T) denote the sum of the valuations of all input arcs arriving in T (respectively, all output arcs going out of T). Each arc that is not multiple is assumed to have a valuation equal to one. <min-diff> and <max-diff> are computed on the entire set of transitions of the original Petri Net (this set is necessarily non empty if this pragma is present).

.SH EXAMPLE OF A N\&U\&P\&N FILE

This is an example of a valid NUPN file:

.nf
   !creator caesar
   !unit_safe
   places #7 0...6
   initial place 0
   units #3 0...2
   root unit 0
   U1 #4 1...4 #0 
   U2 #2 5...6 #0 
   U0 #1 0...0 #2 1 2 
   transitions #5 0...4
   T0 #1 0 #2 1 5 
   T1 #2 3 6 #2 2 5 
   T2 #2 1 5 #2 4 6 
   T3 #1 2 #1 1 
   T4 #1 4 #1 3 
.fi

.SH HOW TO CREATE A N\&U\&P\&N FILE

At present, there are two ways of producing NUPN models:
.IP -
Using the \fB-nupn\fP option of the
.BR caesar (LOCAL)
compiler, which will generate a NUPN file corresponding to the control structure of a LOTOS specification (or any other specification, for instance, an LNT specification, that can be translated to LOTOS).
.IP -
Using the PNML2NUPN translator developed by Lom Messan Hillah - see http://pnml.lip6.fr/pnml2nupn
- which converts to NUPN a large subset of Petri Nets encoded in the PNML standard. 
Notice that PNML models containing arcs with multiple valuations (i.e., wih PNML "inscription" attributes greater than one) or initial places with more than one token (i.e., with PNML "initialMarking" attributes greater than one) cannot be easily expressed in NUPN.
Also, the models generated by PNML2NUPN are unstructured (technically, each place is contained in a particular NUPN unit).

.SH HOW TO READ A N\&U\&P\&N FILE

At present, there is one single CADP tool,
.BR caesar.bdd (LOCAL),
that reads and processes NUPN files. This tool, when invoked with its \fB-check\fP option, is the reference parser and semantic checker for the NUPN format.

.SH BIBLIOGRAPHY

[Gar19] Hubert Garavel. "Nested-Unit Petri Nets".
Journal of Logical and Algebraic Methods in Programming, vol. 104,
pages 60-85, April 2019. Available from
http://cadp.inria.fr/publications/Garavel-19.html

[Gar15] Hubert Garavel.
"Nested-Unit Petri Nets: A Structural Means to Increase Efficiency and
Scalability of Verification on Elementary Nets".
In R. Devillers and A. Valmari, editors, Proceedings of the 36th
International Conference on Application and Theory of Petri Nets and
Concurrency (PETRI NETS'15), Brussels, Belgium. Lecture Notes in Computer
Science, vol. 9115, Springer, 2015. Superseded by [Gar19]. Available from
http://cadp.inria.fr/publications/Garavel-15-a.html

.SH SEE ALSO
.BR caesar.bdd (LOCAL),
.BR caesar (LOCAL),
.BR nupn_info (LOCAL)

.P
Additional information is available from the CADP Web page located at
http://cadp.inria.fr
.P
Directives for installation are given in files \fB$CADP/INSTALLATION_*\fP.
.P
Recent changes and improvements to this software are reported
and commented in file \fB$CADP/HISTORY\fP.
.SH BUGS
Please report bugs to cadp@inria.fr


