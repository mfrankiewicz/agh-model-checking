###############################################################################
#                                C A D P
#------------------------------------------------------------------------------
#   INRIA - Unite de Recherche Rhone-Alpes
#   655, avenue de l'Europe
#   38330 Montbonnot Saint Martin
#   FRANCE
#------------------------------------------------------------------------------
#   Module             :       place_fusion.awk
#   Auteur             :       Hubert GARAVEL
#   Version            :       1.28
#   Date               :       2019/11/06 11:31:51
###############################################################################

# this script imports the variables COMMAND and INPUT

# this script includes "library.awk"

# -----------------------------------------------------------------------------

BEGIN {
	# step 1: check whether the net contains some void non-root unit
	CALL_CAESAR_BDD("-void-nonroot-units", INPUT)
	if (NF != 0) {
		# caesar.bdd detected some void non-root unit
		EXIT_STATUS = 1
		print COMMAND ": unexpected void non-root units " $0 > "/dev/stderr"
		exit		# i.e., jump to the END rule
	}

	# step 2: check whether the root unit is void or not
	# assert (NF == 0) && ($0  == "")
	CALL_CAESAR_BDD("-void-root-unit", INPUT)
	if (NF == 0) {
		ROOT_UNIT_IS_VOID = 0
	} else {
		ROOT_UNIT_IS_VOID = 1
	}
	EXIT_STATUS = 0
}

/^!creator/ {
	print $0 " -> nupn_info -place-fusion"
}

/^!unit_safe/ {
	# here, $0 = !unit_safe or !unit_safe %s
	# place-fusion abstraction does not preserve unit safeness
	# (no print)
}

/^!multiple/ {
	# place-fusion abstraction makes "multiple" pragmas irrelevant
	# (no print)
}

/^places/ {
	# here, $0 = places #%d %d...%d
	# this line is discarded and will be recalculated later
	# (no print yet)
}

/^initial place/ {
	# here, $0 = initial place %d or initial places #%d {%d}+
	# (no print yet)
	if ($2 == "place") {
		# here, $0 = initial place %d
		INITIAL_PLACES = $3
	} else {
		# here, $0 = initial places #%d {%d}+
		sub ("^[^#]*#[0-9]* ", "", $0)
		# here, $0 = {%d}+
		INITIAL_PLACES = $0
	}
}

/^units/ {
	# here, $0 = units #%d %d...%d
	# (no print yet)
	sub ("units #", "", $0)
	sub ("[.][.][.]", " ", $0)
	# here, $0 = %d %d %d
	NB_UNITS = $1
	MIN_UNIT = $2
	MAX_UNIT = $3
	# definition of places (one place per unit)
	NB_PLACES = NB_UNITS - ROOT_UNIT_IS_VOID
	MIN_PLACE = MIN_UNIT
	MAX_PLACE = MAX_UNIT - ROOT_UNIT_IS_VOID
}

/^root unit/ {
	# here, $0 = root unit %d
	# (no print yet)
	sub ("root unit ", "", $0)
	ROOT_UNIT = $0
}

/^U/ {
	# here, $0 = U%d #%d %d...%d #%d{ %d}*
	sub ("^U", "", $0)
	# here, $0 = %d #%d %d...%d #%d{ %d}*
	U = $1
	NEW_P = U
	if (ROOT_UNIT_IS_VOID && (U + 0 >= ROOT_UNIT + 0)) {
		# (adding 0 avoids string lexicographic comparison)
		-- NEW_P
	}
	sub ("^[^#]*#", "", $0)
	# here, $0 = %d %d...%d #%d{ %d}*
	sub ("[.][.][.]", " ", $0)
	# here, $0 = %d %d %d #%d{ %d}*
	NB_P = $1
	FIRST_P = $2
	LAST_P = $3
	# compute for each place P its representive place RENUMBER_PLACE [P]
	for (P = FIRST_P; P <= LAST_P; ++P) {
		RENUMBER_PLACE [P] = NEW_P
	}
	sub ("^[^#]*", "", $0)
	# here, $0 = #%d{ %d}*
	SUB_UNITS [U] = $0
}

/^transitions/ {
	# save the current line
	TRANSITIONS = $0

	# display the "places" line
	print "places #" NB_PLACES " " MIN_PLACE "..." MAX_PLACE

	# display the "initial places" line
	ORS = ""
	print "initial places"
	TRANSLATE_PLACE_LIST(INITIAL_PLACES)
	print "\n"
	ORS = "\n"

	# display the "units" line
	print "units #" NB_UNITS " " MIN_UNIT "..." MAX_UNIT

	# display the "root unit" line
	print "root unit " ROOT_UNIT

	# display the "U..." lines
	ORS = ""
	for (U = MIN_UNIT; U <= MAX_UNIT; ++U) {
		print "U" U " "
		# display (zero or one) local place
		if (! ROOT_UNIT_IS_VOID) {
			# the unique local place has the same number as U
			print "#1 " U "..." U
		} else if (U == ROOT_UNIT) {
			# the root unit has no local place
			print "#0 1...0"
		} else if (U + 0 < ROOT_UNIT + 0) {
			# (adding 0 avoids string lexicographic comparison)
			# each unit U below the root unit has a unique place,
			# which has the same number as U
			print "#1 " U "..." U
		} else {
			# each unit U above the root unit has a unique place,
			# which has the same number as U minus 1
			print "#1 " (U - 1) "..." (U - 1)
		}
		# display the sub-units of U
		print " " SUB_UNITS [U] "\n"
	}
	ORS = "\n"

	# display the "transitions" line
	print TRANSITIONS
}

/^T/ {
	# here, $0 = T%d #%d{ %d}* #%d{ %d}*
	TRANSLATE_TRANSITION()
}

/^labels/ {
	# here, $0 = labels %d %d %d %s
	# place labels (if any) are deleted
	$2 = "0"
	# transition labels and unit labels remain unchanged
	if (($2 != "0") || ($3 != "0") || ($4 != "0")) {
		# maximum label length might actually be smaller than $5
		print $0
	}
}

/^p[0-9]/ {
	# drop all place labels
}

/^t[0-9]/ {
	print $0
}

/^u[0-9]/ {
	print $0
}

END {
	exit EXIT_STATUS
}

