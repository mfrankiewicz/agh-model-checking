###############################################################################
#                                C A D P
#------------------------------------------------------------------------------
#   INRIA - Unite de Recherche Rhone-Alpes
#   655, avenue de l'Europe
#   38330 Montbonnot Saint Martin
#   FRANCE
#------------------------------------------------------------------------------
#   Module             :       library.awk
#   Auteur             :       Hubert GARAVEL
#   Version            :       1.4
#   Date               :       2019/11/06 12:14:26
###############################################################################

function CALL_CAESAR_BDD (OPTION, INPUT) {
	# this function may modify $0 and EXIT_STATUS
	CMD = "caesar.bdd " OPTION " " INPUT
	CMD | getline
	STATUS = close (CMD)
	if (STATUS != 0) {
		EXIT_STATUS = 1
		print COMMAND ": call to \"caesar.bdd " OPTION "\" failed" > "/dev/stderr"
		exit		# i.e., jump to the END rule
	}
}

# -----------------------------------------------------------------------------

function NORMALIZE_INITIAL_PLACES() {
	# here, $0 = initial place %d or initial places #%d {%d}+
	# note : this function performs no place renumbering
	if ($2 == "place") {
		# here, $0 = initial place %d
		# convert the old-style syntax into the new-style one
		print "initial places #1 " $3
	} else {
		# here, $0 = initial places #%d {%d}+
		print $0
	}
}

# -----------------------------------------------------------------------------

function TRANSLATE_PLACE_LIST (OLD_LIST) {
	# compute and display NEW_LIST = {PLACE_RENUMBER [P] | P in OLD_LIST},
	# avoiding potential duplicates if PLACE_RENUMBER is not injective
	CARDINAL = 0
	delete NEW_LIST
	split (OLD_LIST, OLD_ARRAY)
	for (N in OLD_ARRAY) {
		P = RENUMBER_PLACE [OLD_ARRAY [N]]
		if (!(P in NEW_LIST)) {
			++CARDINAL
			NEW_LIST [P] = 1
		}
	}
	print " #" CARDINAL
	for (P in NEW_LIST) {
		print " " P
	}
}

# -----------------------------------------------------------------------------

function TRANSLATE_TRANSITION() {
	# here, $0 = T%d #%d{ %d}* #%d{ %d}*
	ORS = ""
	print $1

	# extract the lists of input and output places
	sub ("^[^#]*#[0-9]* ", "", $0)
	# here, $0 = {%d}* #%d{ %d}*

	INPUT_PLACES = $0
	sub ("#.*$", "", INPUT_PLACES)
	# here, INPUT_PLACES = {%d}* or INPUT_PLACES = " " (no input place)

	OUTPUT_PLACES = $0
	sub ("^[^#]*#[0-9]*", "", OUTPUT_PLACES)
	# here, OUTPUT_PLACES = {%d}* or OUTPUT_PLACES = " " (no output place)

	TRANSLATE_PLACE_LIST(INPUT_PLACES)
	TRANSLATE_PLACE_LIST(OUTPUT_PLACES)
	print "\n"
	ORS = "\n"
}

# -----------------------------------------------------------------------------


