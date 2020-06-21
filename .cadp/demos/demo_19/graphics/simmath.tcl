
####################################################################
#
# Datei simmath.tcl
#
# Autor : 	   Artur Brauer
# Erstellzetraum : November 1992 bis Maerz 1993
#
# Diese Datei enthaelt die Maximum- und Minimumfunktion
# 
####################################################################

proc minimum {a b} {
if {$a <= $b} {return $a} else {return $b}
}

proc maximum {a b} {
if {$a >= $b} {return $a} else {return $b}
}

################
# proc line_intersect 
#
# test wether to lines which are given by their 
# start- and endpoint do intersect
# the prcedure returns 1 if the lines intersect;
# 0 else
###############

proc line_intersect {line1 line2} {


#The constant epsilon is used to check parralel lines 
#that are closed to each other
set epsilon 5


set ax [lindex $line1 0]
set ay [lindex $line1 1]
set bx [lindex $line1 2]
set by [lindex $line1 3]

set cx [lindex $line2 0]
set cy [lindex $line2 1]
set dx [lindex $line2 2]
set dy [lindex $line2 3]


set axminbx [expr $ax-$bx]
set cxmindx [expr $cx-$dx]



#First Case: both lines don't have an infinite gradient
if { ($axminbx != 0) && ($cxmindx != 0)} {

     set grad1 [expr ($ay-$by)/$axminbx]
     set offs1 [expr $ay-$grad1*$ax]

     set grad2 [expr ($cy-$dy)/$cxmindx]
     set offs2 [expr $cy-$grad2*$cx]


     set graddiff [expr $grad1-$grad2]

     #Test whether the lines are parallel
     if { $graddiff != 0 } {

          #The variable x1 contains the x-value of the intersection point
	  set x1 [expr ($offs2-$offs1)/($grad1-$grad2)]


          
          #Test wether the x-value of the intersection point lies between the 
          #x-coordinates of both lines
	  if { ($x1 <= [maximum $ax $bx]) && ($x1 >= [minimum $ax $bx]) \
		 && ($x1 <= [maximum $cx $dx]) && ($x1 >= [minimum $cx $dx])}  {

		 #Lines Do intersect

		 return 1

	       } else {

		 #Lines don't intersect
		 return 0
	       }

         
         } else {
	   #The lines are parallel
	   
	   #Test wether the lines lie both on the same line and whether 
	   #they have common points
	   if { ($ay <= [expr $grad2*$ax+$offs2+$epsilon]) &&\
		 ($ay >= [expr $grad2*$ax+$offs2-$epsilon]) &&\
		  ( (($ax <= [maximum $cx $dx]) && ($ax >= [minimum $cx $dx])) \
		    || (($bx <= [maximum $cx $dx]) && ($bx >= [minimum $cx $dx]))  ) } {
	     

	     #Lines have common point
	     return 1

	   } else {
	     #The Lines are parallel but don't have common points
	     return 0
	   }
	 }
          
     } 


#Second case: just line1 has an in infinite gradient
if { ($axminbx == 0) && ($cxmindx != 0) } {
  if {($ax <= [maximum $cx $dx]) && ($ax >= [minimum $cx $dx])} { 


	 return 1
       } else {
	 return 0
       }
}


#Third case: just line2 has an in infinite gradient
if { ($axminbx != 0) && ($cxmindx == 0) } {
  if { ($cx <= [maximum $ax $bx]) && ($cx >= [minimum $ax $bx])} { 


	 return 1
       } else { 
	 return 0
       }
}


#Forth case: both lines have  an in infinite gradient
if { ($ax == $cx) && ( (( $ay >= [minimum $cy $dy]) && ( $ay <= [maximum $cy $dy])) \
			 ||(($by >= [minimum $cy $dy]) && ($by <= [maximum $cy $dy])) ) } {


	 return 1
       }
   


return 0

#END Proc
}


##############
# proc blanks_intersect
#
# tests wether two blanks do intersect
# returns 1 if they do; 0 else
##############

proc blanks_intersect {blank1 blank2} {

global canv 

set halfwidth_blank 5
set length_blank 70.0

set faktor $halfwidth_blank/$length_blank

#Get coordinates of the first blank
   set coord_blank1 [$canv coords $blank1]

   set blnk1ax [lindex $coord_blank1 0]
   set blnk1ay [lindex $coord_blank1 1]
   set blnk1bx [lindex $coord_blank1 2]
   set blnk1by [lindex $coord_blank1 3]

   #Compute the normal to the blank
   set nrm1x [expr ($blnk1by-$blnk1ay)*$faktor]
   set nrm1y [expr -($blnk1bx-$blnk1ax)*$faktor]


   #Compute the two long sides of a blank
   set line1blank1 "[expr $blnk1ax+$nrm1x] [expr $blnk1ay+$nrm1y]\
 	[expr $blnk1bx+$nrm1x] [expr $blnk1by+$nrm1y]"
   set line2blank1 "[expr $blnk1ax-$nrm1x] [expr $blnk1ay-$nrm1y]\
 	[expr $blnk1bx-$nrm1x] [expr $blnk1by-$nrm1y]"



#Get coordinates of the second blank
   set coord_blank2 [$canv coords $blank2]

   set blnk2ax [lindex $coord_blank2 0]
   set blnk2ay [lindex $coord_blank2 1]
   set blnk2bx [lindex $coord_blank2 2]
   set blnk2by [lindex $coord_blank2 3]

   #Compute the normal to the blank
   set nrm2x [expr ($blnk2by-$blnk2ay)*$faktor]
   set nrm2y [expr -($blnk2bx-$blnk2ax)*$faktor]

   #Compute the two long sides of a blank
   set line1blank2 "[expr $blnk2ax+$nrm2x] [expr $blnk2ay+$nrm2y]\
 	[expr $blnk2bx+$nrm2x] [expr $blnk2by+$nrm2y]"
   set line2blank2 "[expr $blnk2ax-$nrm2x] [expr $blnk2ay-$nrm2y]\
 	[expr $blnk2bx-$nrm2x] [expr $blnk2by-$nrm2y]"




if {  [line_intersect $line1blank1 $line1blank2] || [line_intersect $line1blank1 $line2blank2] \
	|| [line_intersect $line2blank1 $line1blank2] || [line_intersect $line2blank1 $line2blank2]} {

	return 1
	} else {
	return 0
	}
}

