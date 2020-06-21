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
#   Module		:	text.tcl
#   Auteurs		:	Mark JORGENSEN, Aldo MAZZILLI, Hubert GARAVEL
#   Version		:	1.5
#   Date		: 	2013/09/04 11:28:30
##############################################################################

proc Insert_in_text_window {str_in} {
   global tag_num
   global str
   global ind

   set ind [string last "\n" $str_in ]
   set str [string range $str_in 0 [expr $ind - 1]]

   if [string match successor\ \#1:* $str] {
      foreach t [.xsimulator.output tag names] {
         .xsimulator.output tag remove $t 0.0 end
      }
   }

   regsub -all {[]} $str {} str_without_control_characters

   .xsimulator.output configure -state normal
   .xsimulator.output insert end " $str_without_control_characters " "$tag_num" 
   .xsimulator.output insert end "\n"
   .xsimulator.output see end

   if [string match successor\ \#*:* $str] {
      .xsimulator.output tag bind "$tag_num" <Any-Enter> \
	    ".xsimulator.output tag configure $tag_num \
	    -foreground white -background black"
      .xsimulator.output tag bind "$tag_num" <Any-Leave> \
	    ".xsimulator.output tag configure $tag_num \
	    -foreground {} -background {}"
      .xsimulator.output tag bind "$tag_num" <ButtonRelease-1> \
	    "caesar_S_next_3_Tcl [ lrange $str 0 1 ]
	     flush stdout"}
   .xsimulator.output configure -state disabled	 
   incr tag_num
   }

