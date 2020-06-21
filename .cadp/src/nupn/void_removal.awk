###############################################################################
#                                C A D P
#------------------------------------------------------------------------------
#   INRIA - Unite de Recherche Rhone-Alpes
#   655, avenue de l'Europe
#   38330 Montbonnot Saint Martin
#   FRANCE
#------------------------------------------------------------------------------
#   Module             :       void_removal.awk
#   Auteur             :       Hubert GARAVEL
#   Version            :       1.20
#   Date               :       2019/06/03 10:46:12
###############################################################################

# this script imports the variables COMMAND and INPUT

# this script includes "library.awk"

BEGIN {
	CALL_CAESAR_BDD("-void-nonroot-units", INPUT)
	if (NF == 0) {
		# the net has no void unit
		EXIT_STATUS = 2		# output will be identical to input
		exit			# i.e., jump to the END rule
	} else {
		# the net has void units
		EXIT_STATUS = 0
	}
}

/^!creator/ {
	print $0 " -> nupn_info -void-removal"
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
	sub ("^[^#]*#", "", $0)
	# here, $0 = %d %d...%d #%d{ %d}*
	NB_PLACES = $1
	PLACE_LIST = $0
	sub ("#.*$", "", PLACE_LIST)
	# here, PLACE_LIST = %d %d...%d
	PLACES [U] = "#" PLACE_LIST
	sub ("^[^#]*#[0-9]*[ ]?", "", $0)	# there is no space after #0
	# here, $0 = {%d}*
	SUB_UNITS [U] = " " $0 " "

	if ((NB_PLACES == 0) && (U != ROOT_UNIT)) {
		# here, U is a void unit
		REMOVABLE_UNIT [U] = 1
	} else {
		REMOVABLE_UNIT [U] = 0
	}
	# assert REMOVABLE_UNIT [ROOT_UNIT] == 0
}

/^transitions/ {
	# delete void units from the unit tree
	for (U1 = MIN_UNIT; U1 <= MAX_UNIT; ++U1) {
		if (REMOVABLE_UNIT [U1]) {
			for (U2 = MIN_UNIT; U2 <= MAX_UNIT; ++U2) {
				# in the list of the sub-units of U2, try to
				# replace U1, if present, by the list of its 
				# sub-units
				FOUND = sub (" " U1 " ", SUB_UNITS [U1], SUB_UNITS [U2])
				if (FOUND) {
					# substitution succeeded, meaning that
					# U2 is the parent unit of U1
					break
				}
			}
		}
	}

	# renumber non-void units
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

	# declare all non-void units
	for (U = MIN_UNIT; U <= MAX_UNIT; ++U) {
		if (!REMOVABLE_UNIT [U]) {
			ORS = ""
			# declare the unit and its local places
			print "U" RENUMBER_UNIT [U] " " PLACES [U] 
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
	print $0
}

/^labels/ {
	# here, $0 = labels %d %d %d %s
	# unit labels (if any) are updated
	# place labels and transition labels remain unchanged
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

