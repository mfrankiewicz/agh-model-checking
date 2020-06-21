###############################################################################
#                                C A D P
#------------------------------------------------------------------------------
#   INRIA - Unite de Recherche Rhone-Alpes
#   655, avenue de l'Europe
#   38330 Montbonnot Saint Martin
#   FRANCE
#------------------------------------------------------------------------------
#   Module             :       redundant_removal.awk
#   Auteur             :       Hubert GARAVEL
#   Version            :       1.21
#   Date               :       2019/06/03 10:46:12
###############################################################################

# this script imports the variables COMMAND and INPUT

# this script includes "library.awk"

# -----------------------------------------------------------------------------

BEGIN {
	CALL_CAESAR_BDD("-redundant-units", INPUT)
	if (NF == 0) {
		# the net has no redundant unit
		EXIT_STATUS = 2		# output will be identical to input
		exit			# i.e., jump to the END rule
	} else {
		# the net has redundant units
		EXIT_STATUS = 0
	}
}

/^!creator/ {
	print $0 " -> nupn_info -redundant-removal"
}

/^!unit_safe/ {
	# here, $0 = !unit_safe or !unit_safe %s
	print $0
}

/^!multiple/ {
	print $0
}

/^places/ {
	print $0
	# here, $0 = places #%d %d...%d
	sub ("places #", "", $0)
	sub ("[.][.][.]", " ", $0)
	# here, $0 = %d %d %d
	NB_PLACES = $1
	MIN_PLACE = $2
	MAX_PLACE = $3
}

/^initial place/ {
	# here, $0 = initial place %d or initial places #%d {%d}+
	print $0
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
	# initialize the array of removable units
	for (U = MIN_UNITS; U <= MAX_UNITS; ++U)
		REMOVABLE_UNIT [U] = 0
	}

/^root unit/ {
	# here, $0 = root unit %d
	# (no print yet)
	ROOT_UNIT = $3
}

/^U/ {
	# here, $0 = U%d #%d %d...%d #%d{ %d}*
	sub ("^U", "", $0)
	# here, $0 = %d #%d %d...%d #%d{ %d}*
	U = $1
	sub ("^[^#]*#[0-9]* ", "", $0)
	# here, $0 =  %d...%d #%d{ %d}*
	PLACE_LIST = $0
	sub ("#.*$", "", PLACE_LIST)
	# here, PLACE_LIST = %d...%d
	MIN_P = PLACE_LIST
	sub ("[.].*$", "", MIN_P)
	MAX_P = PLACE_LIST
	sub ("^.*[.]", MAX_P)
	for (P = MIN_P; P <= MAX_P; ++P) {
		UNIT [P] = U
	}
	sub ("^[^#]*#", "", $0)
	# here, $0 = %d{ %d}*
	NB_SUB_UNITS = $1
	sub ("^[0-9]*[ ]?", "", $0)	# there is no space after #0
	# here, $0 = {%d}*
	SUB_UNITS [U] = " " $0 " "
	if (NB_SUB_UNITS == 1) {
		# here, U is a redundant unit; the sub-unit SUB_U of U will
		# be removed
		SUB_U = $0
		REMOVABLE_UNIT [SUB_U] = 1
	}
	# assert REMOVABLE_UNIT [ROOT_UNIT] == 0
}

/^transitions/ {
	# delete removable units from the unit tree
	for (U1 = MIN_UNIT; U1 <= MAX_UNIT; ++U1) {
		if (REMOVABLE_UNIT [U1]) {
			for (U2 = MIN_UNIT; U2 <= MAX_UNIT; ++U2) {
				# in the list of the sub-units of U2, try to
				# replace U1, if present, by the list of its 
				# sub-units
				FOUND = sub (" " U1 " ", SUB_UNITS [U1], SUB_UNITS [U2])
				if (FOUND) {
					# substitution succeeded, meaning that
					# U2 is the parent unit of U1; first,
					# U1 loses its sub-units
					SUB_UNITS [U1] = ""
					# then, the local places of U1 become
					# local places of U2
					for (P = MIN_PLACE; P <= MAX_PLACE; ++P)
						if (UNIT [P] == U1)
							UNIT [P] = U2
					break
				}
			}
		}
	}

	# renumber places
	NEW_P = MIN_PLACE
	for (U = MIN_UNIT; U <= MAX_UNIT; ++U) {
		for (P = MIN_PLACE; P <= MAX_PLACE; ++P) {
			if (UNIT [P] == U) {
				RENUMBER_PLACE [P] = NEW_P
				++ NEW_P
			}
		}
	}

	# renumber non-redundant units
	N = MIN_UNIT
	NB_REMOVED_UNITS = 0
	for (U = MIN_UNIT; U <= MAX_UNIT; ++U) {
		if (REMOVABLE_UNIT [U]) {
			++ NB_REMOVED_UNITS
		} else {
			RENUMBER_UNIT [U] = N
			++ N
		}
	}

	# display the "units" line
	print "units #" (NB_UNITS - NB_REMOVED_UNITS) " " MIN_UNIT "..." (MAX_UNIT - NB_REMOVED_UNITS)

	# display the "root unit" line
	print "root unit " RENUMBER_UNIT [ROOT_UNIT]

	# declare all non-redundant units
	for (U = MIN_UNIT; U <= MAX_UNIT; ++U) {
		if (!REMOVABLE_UNIT [U]) {
			ORS = ""
			# declare the unit
			print "U" RENUMBER_UNIT [U] " " PLACES [U]
			# declare the local places
			N = 0
			MIN_P = MAX_PLACE + 1
			MAX_P = MIN_PLACE - 1
			for (P = MIN_PLACE; P <= MAX_PLACE; ++P) {
				if (UNIT [P] == U) {
					++N
					NEW_P = RENUMBER_PLACE [P]
					if (NEW_P < MIN_P)
						MIN_P = NEW_P
					if (NEW_P > MAX_P)
						MAX_P = NEW_P
				}
			}
			print "#" N " " MIN_P "..." MAX_P " "
			# declare the sub-units
			N = split (SUB_UNITS [U], ARRAY)
			print "#" N
			if (N > 0) {
				for (I in ARRAY) {
					print " " RENUMBER_UNIT [ARRAY [I]]
				}
			}
			print "\n"
			ORS = "\n"
		}
	}

	# display the "transitions" line
	print $0
}

/^T/ {
	# here, $0 = T%d #%d{ %d}* #%d{ %d}*
	TRANSLATE_TRANSITION()
}

/^labels/ {
	# here, $0 = labels %d %d %d %s
	# place labels and transition labels remain unchanged
	# unit labels (if any) are updated
	if (($2 != "0") || ($3 != "0") || ($4 != "0")) {
		# the maximum label length (i.e., $5) will be adjusted later
		# using "nupn_info -canonical-nupn"
		print $0
	}
}

/^p[0-9]/ {
	print $0
}

/^t[0-9]/ {
	print $0
}

/^u[0-9]/ {
	# here, $0 = u%d label
	U = $1
	sub ("^u", "", U)
	if (!REMOVABLE_UNIT [U]) {
		LABEL = $0
		sub ("^u[0-9]* ", "", LABEL)
		print "u" RENUMBER_UNIT [U] " " LABEL
	}
}

END {
	exit EXIT_STATUS
}

