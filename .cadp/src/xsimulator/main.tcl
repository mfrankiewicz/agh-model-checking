###############################################################################
#   			O P E N / C A E S A R
#-----------------------------------------------------------------------------
#   INRIA
#   Unite de Recherche Rhone-Alpes
#   Zirst
#   655, avenue de l'Europe
#   38330 Montbonnot Saint Martin
#   FRANCE
#-----------------------------------------------------------------------------
#   Module		:	main.tcl
#   Auteur		:	Mark JORGENSEN
#   Version		:	1.7
#   Date		: 	2004/06/17 15:24:18
##############################################################################

set Space_Inside 5
set Space_Outside 5

source $env(CADP)/src/xsimulator/text.tcl
source $env(CADP)/src/xsimulator/windows.tcl
source $env(CADP)/src/xsimulator/xsimulator.tcl

set File_Name ""

set Number 0
set File_Id 0

frame .xsimulator -background White
pack .xsimulator

proc Execute_Tool {Tool} {
   global Window
   global Menus
   if [expr [llength $Window($Tool)] > 0] {
	Make_Window_with_Buttons $Tool
	global tag_num
	set tag_num 0
	text .xsimulator.output \
	    -setgrid true \
	    -wrap word \
	    -background Thistle1 \
	    -yscrollcommand ".xsimulator.scroll set"

	 scrollbar .xsimulator.scroll\
	    -command ".xsimulator.output yview"

	 pack .xsimulator.output -side top 
	 pack .xsimulator.scroll \
		-fill y \
		-side right 

	 pack .xsimulator.output \
	    -expand 1 \
	    -fill both \
	    -side left 
	 .xsimulator.output configure -font -adobe-*-medium-r-normal-*-*-*-*-*-*-*-*-*

   } 
}

Execute_Tool Xsimulator

set Xsim_Label_Format $env(XSIM_LABEL_FORMAT)
set Xsim_State_Format $env(XSIM_STATE_FORMAT)

