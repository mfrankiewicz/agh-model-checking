###############################################################################
#                                C A D P
#------------------------------------------------------------------------------
#   INRIA - Unite de Recherche Rhone-Alpes
#   655, avenue de l'Europe
#   38330 Montbonnot Saint Martin
#   FRANCE
#------------------------------------------------------------------------------
#   Module             :       canonical_nupn.awk
#   Auteur             :       Hubert GARAVEL
#   Version            :       1.15
#   Date               :       2019/11/06 12:15:45
###############################################################################

# this script imports the variables COMMAND, INPUT, and LABEL_LENGTH

function NORMALIZE_BLANKS () {
	# replace tabulations with spaces
	gsub ("\t", " ", $0)
	gsub ("[ ][ ]*", " ", $0)
	sub ("^ ", "", $0)
	sub (" $", "", $0)
}

# -----------------------------------------------------------------------------

function PRINT_SORTED_LIST (LIST, PIPE) {
	N = split (LIST, ARRAY)
	if (N > 0) {
		asort (ARRAY)
		for (I = 1; I <= N; ++ I) {
			print " " ARRAY [I] | PIPE
		}
	}
}

# -----------------------------------------------------------------------------

/^[ \t]*$/ {
	# delete lines containing only blanks
	next
}

/^initial place/ {
	# here, $0 = initial place %d or initial places #%d {%d}+
	NORMALIZE_BLANKS()
	NORMALIZE_INITIAL_PLACES()
	next
}

/^root/ {
	# copy the current line to stdout after normalizing the blanks
	NORMALIZE_BLANKS()
	print $0

	# open a pipe for the subsequent "^U" lines
	UNIT_PIPE = "sort -n -k1.2"
	next
}

/^U/ {
        # here, $0 = U%d #%d %d...%d #%d{ %d}*
	NORMALIZE_BLANKS()
	ORS = ""
	print $1 " " $2 " " $3 " " $4 | UNIT_PIPE
        sub (".*#[0-9][0-9]*", "", $0)
        # here, $0 = { %d}*
	PRINT_SORTED_LIST($0, UNIT_PIPE)
	print "\n" | UNIT_PIPE
	ORS = "\n"
	next
}

/^transitions/ {
	# close the pipe for the "^U" lines
	close(UNIT_PIPE)

	# copy the current line to stdout after normalizing the blanks
	NORMALIZE_BLANKS()
	print $0

	# open a pipe for the subsequent "^T" lines
	TRANSITION_PIPE = "sort -n -k1.2"
	next
}

/^T/ {
	# here, $0 = T%d #%d{ %d}* #%d{ %d}*
	NORMALIZE_BLANKS()
	ORS = ""
	print $1 " " $2 | TRANSITION_PIPE

	sub ("^[^#]*#[0-9]* ", "", $0)
	# here, $0 = {%d}* #%d{ %d}*

	# extract the list of input places
	INPUT_PLACES = $0
	sub ("#.*$", "", INPUT_PLACES)
	# here, INPUT_PLACES = {%d}* or INPUT_PLACES = " " (no input place)
	PRINT_SORTED_LIST(INPUT_PLACES, TRANSITION_PIPE)

	sub ("^[^#]*", "", $0)
	# here, $0 = #%d{ %d}*
	print " " $1 | TRANSITION_PIPE

	# extract the list of output places
	OUTPUT_PLACES = $0
	sub ("#[0-9]*", "", OUTPUT_PLACES)
	# here, OUTPUT_PLACES = {%d}* or OUTPUT_PLACES = " " (no output place)
	PRINT_SORTED_LIST(OUTPUT_PLACES, TRANSITION_PIPE)

	print "\n" | TRANSITION_PIPE
	ORS = "\n"
	next
}

/^labels/ {
	if (($2 == "0") && ($3 == "0") && ($4 == "0")) {
		# drop the "labels" line as there are no labels actually
		next
	}

	# close the pipe for the "^T" lines
	close(TRANSITION_PIPE)

	# copy the current line to stdout after normalizing the blanks
	# and updating the 5th field (i.e., the maximal label length)
	NORMALIZE_BLANKS()
	$5 = LABEL_LENGTH
	print $0

	# prepare for the subsequent "^p", "^t", and "^u" lines
	PREVIOUS_LABEL = "-"
	next
}

/^p[0-9]/ {
	# one needs to avoid confusion between "^places" and "^p[0-9]" lines
	if (PREVIOUS_LABEL != "p") {
		PREVIOUS_LABEL = "p"
		LABEL_PIPE = "sort -n -k1.2"
	}
	print $0 | LABEL_PIPE
	next
}

/^t[0-9]/ {
	if (PREVIOUS_LABEL != "t") {
		close(LABEL_PIPE)
		PREVIOUS_LABEL = "t"
		LABEL_PIPE = "sort -n -k1.2"
	}
	print $0 | LABEL_PIPE
	next
}

/^u[0-9]/ {
	# one needs to avoid confusion between "^units" and "^u[0-9]" lines
	if (PREVIOUS_LABEL != "u") {
		close(LABEL_PIPE)
		PREVIOUS_LABEL = "u"
		LABEL_PIPE = "sort -n -k1.2"
	}
	print $0 | LABEL_PIPE
	next
}

{
	# anothing else is copied to stdout after normalizing the blanks
	NORMALIZE_BLANKS()
	print $0
}

END {
	if (PREVIOUS_LABEL == "") {
		# there was no label section
		# close the pipe for the "^T" lines
		close(TRANSITION_PIPE)
	} else if (PREVIOUS_LABEL != "-") {
		# close the pipe for the label lines
		close(LABEL_PIPE)
	}
	exit 0
}

