###############################################################################
#                                C A D P
#------------------------------------------------------------------------------
#   INRIA - Unite de Recherche Rhone-Alpes
#   655, avenue de l'Europe
#   38330 Montbonnot Saint Martin
#   FRANCE
#------------------------------------------------------------------------------
#   Module             :       trivial_units.awk
#   Auteur             :       Hubert GARAVEL
#   Version            :       1.17
#   Date               :       2019/11/06 12:15:59
###############################################################################

# this script imports the variables COMMAND and INPUT

BEGIN {
	EXIT_STATUS = 0
}

/^!creator/ {
	print $0 " -> nupn_info -trivial-units"
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
	# definition of units (one unit per place, plus a root unit)
	NB_UNITS = NB_PLACES + 1
	MIN_UNIT = MIN_PLACE
	MAX_UNIT = MAX_PLACE
	ROOT_UNIT = MAX_PLACE + 1
}

/^initial place/ {
	# here, $0 = initial place %d or initial places #%d {%d}+
	NORMALIZE_INITIAL_PLACES()
}

/^units/ {
	print "units #" NB_UNITS " " MIN_UNIT "..." ROOT_UNIT
}

/^root unit/ {
	print "root unit " ROOT_UNIT
	# declare all units but the root unit
	for (U = MIN_UNIT; U <= MAX_UNIT; ++U) {
		print "U" U " #1 " U "..." U " #0"
	}
	# declare the root unit and its sub-units
	ORS = ""
	print "U" ROOT_UNIT " #0 1...0 #" (NB_UNITS - 1)
	for (U = MIN_UNIT; U <= MAX_UNIT; ++U) {
		print " " U
	}
	print "\n"
	ORS = "\n"
}

/^U/ {
	# here, $0 = U%d #%d %d...%d #%d{ %d}*
	# the new unit declarations have already been printed
}

/^transitions/ {
	print $0
}

/^T/ {
	print $0
}

/^labels/ {
	# here, $0 = labels %d %d %d %s
	# unit labels (if any) are deleted
	$4 = "0"
	# place labels and transition labels remain unchanged
	if (($2 != "0") || ($3 != "0") || ($4 != "0")) {
		# maximum label length might actually be smaller than $5
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
	# drop all unit labels
}

END {
	exit EXIT_STATUS
}

