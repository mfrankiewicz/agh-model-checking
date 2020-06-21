###############################################################################
#                                C A D P
#------------------------------------------------------------------------------
#   INRIA - Unite de Recherche Rhone-Alpes
#   655, avenue de l'Europe
#   38330 Montbonnot Saint Martin
#   FRANCE
#------------------------------------------------------------------------------
#   Module             :       label_length.awk
#   Auteur             :       Hubert GARAVEL
#   Version            :       1.1
#   Date               :       2019/06/03 10:46:37
##############################################################################

# this script display the maximal length of place, transition, and unit
# labels (if any)

BEGIN {
	MAX_LENGTH = 0
}

/^[ptu][0-9]/ {
	sub ("^[^ ]* ", "", $0)
	if (length > MAX_LENGTH)
		MAX_LENGTH = length
}

END {
	print MAX_LENGTH
}
