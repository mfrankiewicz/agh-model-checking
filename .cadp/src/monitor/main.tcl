##############################################################################
#                                B C G
#-----------------------------------------------------------------------------
#   INRIA - Unite de Recherche Rhone-Alpes
#   655, avenue de l'Europe
#   38330 Montbonnot Saint Martin
#   FRANCE
#-----------------------------------------------------------------------------
#   Module             :       main.tcl
#   Auteurs            :       M. Jorgensen, H. Garavel, R. Mateescu, M. Cherif
#			       N. Descoubes
#   Version            :       1.17
#   Date               :       2019/02/13 12:52:54
##############################################################################

global FILENAME
global EXPLORED
global VAR_EXPLORED
global REMAINING
global VAR_REMAINING
global OLD_REMAINING
global TRANSITIONS
global PER_CENT_FACTOR
global LABEL_LIST
global SORT_LABELS

# -----------------------------------------------------------------------------

set EXPLORED 0
set REMAINING 0
set OLD_REMAINING -1
set TRANSITIONS 0
set SORT_LABELS 0
# $SORT_LABELS vaut 1 ssi on affiche les labels tries
set LABEL_LIST {}
# $LABEL_LIST contient les labels tries par ordre chronologique d'apparition

set tcl_precision 12

gets stdin FILENAME

wm title . "BCG monitor"
wm geometry . 55x10
wm minsize . 55 10

# -----------------------------------------------------------------------------

# le frame .f est la partie haute de la fentre qui contient la partie
# "graph construction ..." et les 4 lignes d'affichage
# correspondantes.  .f n'est extensible que selon l'axe des x.

frame .f

pack .f -fill x
label .f.l1 -text "Graph Construction Statistics for $FILENAME"
pack .f.l1 -side top -fill both 
pack .f.l1

# -----------------------------------------------------------------------------

proc CommandEntry { name label width args } {
	frame $name
	label $name.label -text $label -width $width -anchor w
	eval {entry $name.entry -relief sunken} $args
	pack $name.label -side left
	pack $name.entry -side right -fill x -expand true
	# Il faut interdire l'ecriture ?
	return $name.entry
}

CommandEntry .f.expstates "Current Number of Explored States" 38 \
	     -textvariable VAR_EXPLORED 

CommandEntry .f.remstates "Current Number of Remaining States" 38 \
	     -textvariable VAR_REMAINING 

CommandEntry .f.varstates "Current Variation of Remaining States" 38 \
	     -textvariable VARIATION 

CommandEntry .f.numtrans  "Current Number of Transitions" 38 \
	     -textvariable VAR_TRANSITIONS

pack .f.expstates .f.remstates .f.varstates .f.numtrans -expand yes -fill x

# -----------------------------------------------------------------------------

checkbutton .f.sort -text "Sort Labels Alphabetically" -variable SORT_LABELS -command \
            DisplayLabelList
pack .f.sort -side left

# -----------------------------------------------------------------------------

# le frame .f7 est la partie contenant l'affichage du texte et la
# barre de scrolling vertical. .scroll_x est la partie contenant la
# barre de scrolling horizontale. .f7 est extensible selon x et y.

frame .f7
pack .f7 -expand yes -fill both

text .f7.output -setgrid true -wrap none  -background white \
      -xscrollcommand ".scroll_x set" -width 55 -height 10 \
      -yscrollcommand ".f7.scroll_y set"  -width 55 -height 10

scrollbar .scroll_x -orient horiz -command ".f7.output xview"
scrollbar .f7.scroll_y -command ".f7.output yview"

pack .f7.output -expand 1 -fill both  -side left
pack .f7.scroll_y -fill y -side right

pack .scroll_x -fill x -side top

.f7.output configure -font -adobe-*-medium-r-normal-*-*-*-*-*-*-*-*-*

# -----------------------------------------------------------------------------

# le frame .f6 est la partie du bas qui contient le bouton stop/done

frame .f6 
button .f6.done -text "stop" -command exit 
pack .f6
pack .f6.done -side bottom

# -----------------------------------------------------------------------------

proc DisplayLabelList {} {
	global SORT_LABELS
	global LABEL_LIST
	if {[expr $SORT_LABELS == 1]} {
		# on trie la liste des labels par ordre alphabetique
		set DISPLAY_LABEL_LIST [lsort $LABEL_LIST]
	} else {
		# on conserve la liste des labels triee par ordre d'apparition
		set DISPLAY_LABEL_LIST $LABEL_LIST
	}
	.f7.output configure -state normal
	.f7.output delete 0.0 end
	foreach L $DISPLAY_LABEL_LIST {
		if [expr [string length $L] > 0] {
			.f7.output insert end " $L \n"
		}
	}
	.f7.output see end
	.f7.output configure -state disabled
}

# -----------------------------------------------------------------------------

proc TerminateInput {} {
	catch {close stdin}
	# l'instruction catch permet de ne pas ouvrir de fenetre d'erreur si
	# stdin est deja clos, c'est-a-dire si le processus qui generait le
	# fichier BCG s'est deja termine
	.f6.done configure -text "done"
}

# -----------------------------------------------------------------------------

# Cette fonction est appelee chaque fois que de nouvelles
# donnees a lire arrivent

proc ReadInput {} {
	global VARIATION TRANSITIONS EXPLORED REMAINING
	global OLD_REMAINING PER_CENT_FACTOR 
	global VAR_REMAINING VAR_EXPLORED VAR_TRANSITIONS 
	global LABEL_LIST

	gets stdin LINE
	if {[eof stdin]} {
		# il faut fermer le fichier d'entree car sinon, ReadInput
		# est appelee indefiniment.
		close stdin
		set LINE ""
	}

	switch -regexp $LINE {
		^$	{
			# ligne vide : le programme est mort abruptement
			set VARIATION "*** aborted ***"
			TerminateInput
			}
		^[.]$	{
			# ligne ".\n" : le programme s'est termine normalement
			set VARIATION "(completed)"
			TerminateInput
			}
		^[,].*	{
			# ligne ",%s\n" : nouveau label
			set LABEL [string range $LINE 1 end]
			lappend LABEL_LIST $LABEL
			DisplayLabelList
			}
		default {
			# ligne "%d %d %d\n": transitions, explored, remaining
			scan $LINE "%f %f %f" TRANSITIONS EXPLORED REMAINING
			
	
			if {[expr ($REMAINING - $OLD_REMAINING) > 0 ]} {
				set VARIATION increasing 
			} else {
				set VARIATION decreasing
			}
			set OLD_REMAINING $REMAINING

			set PER_CENT_FACTOR [expr 100.0 / ($EXPLORED + $REMAINING)]

			set VAR_REMAINING [format "%.0f (%.0f%%)" $REMAINING [expr round($REMAINING * $PER_CENT_FACTOR)]]
			set VAR_EXPLORED [format "%.0f (%.0f%%)" $EXPLORED [expr round($EXPLORED * $PER_CENT_FACTOR)]]
			set VAR_TRANSITIONS [format "%.0f" $TRANSITIONS ]

			}
	}
}

# -----------------------------------------------------------------------------

# Associe la fonction ReadInput aux evenements sur stdin
fileevent stdin readable ReadInput

