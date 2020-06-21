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
#   Module		:	windows.tcl
#   Auteur		:	Mark JORGENSEN, Jean-Michel FRUME, H. GARAVEL
#   Version		:	1.5
#   Date		: 	2013/09/04 11:28:30
##############################################################################

proc Make_Window_Buttons {Wind List} {
global Space_Inside
global Space_Outside
global Number
global File_Name

   set i 0
   foreach Characteristic $List {
      set Array($i) $Characteristic
      incr i
   }

    switch $Array(0) {

       Label {
	  if [info exists Array(2)] then {
          label $Wind.label[incr Number] \
                -text [subst $Array(1)] \
		-font [subst $Array(2)] \
		-background VioletRed1 \
		-foreground White \
	       } else {	
          label $Wind.label[incr Number] \
                -text [subst $Array(1)] \
		-background SlateBlue1 \
		-foreground White \
	      }
          pack $Wind.label$Number \
               -side top  -padx $Space_Outside -pady $Space_Outside
       }

       Button {
          button $Wind.button[incr Number] \
                 -width 10 \
                 -height 3 \
		 -background SlateBlue1 \
		 -foreground White \
		 -highlightthickness 0 \
                 -text $Array(1) \
                 -command $Array(2)
          pack $Wind.button$Number \
               -fill x \
	       -padx 3 -pady 3 \
               -side top
       }

       Frame {
         frame $Wind.frame[incr Number] \
 		-relief raised \
                -borderwidth 1 \
		-background SlateBlue1
         pack $Wind.frame$Number -fill y -side $Array(1) -padx $Space_Outside -pady $Space_Outside -ipadx $Space_Inside -ipady $Space_Inside
         set Number_Frame $Number
         foreach Button $Array(2) {
              Make_Window_Buttons $Wind.frame$Number_Frame $Button 
         }
       } 

       Colored_Frame {
         frame $Wind.frame[incr Number] -background $Array(2)
         pack $Wind.frame$Number -side $Array(1) 
         set Number_Frame $Number
         foreach Button $Array(3) {
              Make_Window_Buttons $Wind.frame$Number_Frame $Button 
         }
       } 

       Empty_Frame {
         frame $Wind.frame[incr Number] -background VioletRed1
         pack $Wind.frame$Number -side $Array(1)
         set Number_Frame $Number
         foreach Button $Array(2) {
              Make_Window_Buttons $Wind.frame$Number_Frame $Button 
         }
       } 

       Radiobutton {global $Array(2)
                    radiobutton $Wind.radiobutton[incr Number]\
                               -text $Array(1) \
			       -background SlateBlue1 \
			       -foreground White \
			       -highlightthickness 0 \
			       -variable $Array(2) \
                               -value [subst [subst $Array(3)]] \
                               -command $Array(5)
                    pack $Wind.radiobutton$Number -side top -anchor w
                         if { $Array(4) == 1} then {
                              set $Array(2) $Array(3)
                         }
                        }

       Logo {
	    global env
            canvas $Wind.logo -confine 1 \
		-width 130 -height 120 \
		-background White \
		-highlightthickness 0 \
		-borderwidth 0
            pack $Wind.logo -side left
            image create photo $Wind.inria -format GIF -file $env(CADP)/src/xsimulator/logo_inria.gif
            $Wind.logo create image 52 60 -image $Wind.inria
	    }

       Checkbutton {
		   global [Array_Name $Array(2)]
		   if {$Array(5) == 1} then {
		       set $Array(2) $Array(3)
		   } else {
		       set $Array(2) $Array(4)
		   }
		   checkbutton $Wind.checkbutton[incr Number]\
			 -text $Array(1) \
			 -variable $Array(2) \
			 -onvalue $Array(3) \
			 -offvalue $Array(4) 
		  pack $Wind.checkbutton$Number -side top -anchor w 
      }

    }
}

proc Make_Window_with_Buttons {Tool} {

    global Number
    global Window
    global Wind
    set Wind ".xsimulator" 
    foreach Widget $Window($Tool) {
       Make_Window_Buttons $Wind $Widget
    }
}

