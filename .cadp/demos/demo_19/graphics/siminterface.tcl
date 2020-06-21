
####################################################################
#
# Datei siminterface.tcl
#
# Autor : 	 Artur Brauer
# Erstelldatum : 23.03.93
#
#Diese Datei enthaelt die Schnittstelle zur Steuerung der Simulation
#Die einzelnen Befehle sind in der Datei doc/protocol beschrieben
#
# Letzte Aenderung: 3.05.95
# Grund: Einfuehrung der Moeglichkeit alle empfangenen Kommados in einer
#        Datei, zusammen mit der Durchlaufnummer abspeichern zu koennen.
####################################################################


#Die Konstante REC_COM muss auf 1 gesetzt werden wenn die Aufzeichnung 
#von Kommandos, die die Simulation empaengt, gewuenscht wird
set REC_COM 0
 
#Initialisierung des Files fuer die Aufzeichnung der Kommandos
if {$REC_COM} {
  set rec_com_file [open commands.rec w]
}

############
#
#proc record_command
#schreibt die Kommandos in die Datei 
#commands.rec, dazu wird die Nummer des Durchlaufs
#der Simulation mit notiert. 
############

proc record_command {comm} {
  global REC_COM
  global passings rec_com_file
  if {$REC_COM} {
    puts $rec_com_file "$passings $comm"
    flush $rec_com_file 
  }
}
  

############
#Roboter
#########
proc arm1_forward {} {
global move_rob
global prod_a1

record_command arm1_forward

set move_rob 1
set prod_a1 [lreplace $prod_a1 1 1 2]
}
proc arm1_stop {} {
global move_rob
global prod_a2 prod_a1

record_command arm1_stop

if {(![lindex $prod_a2 0]) && (![lindex $prod_a2 1])} {
  set move_rob 0}
set prod_a1 [lreplace $prod_a1 1 1 0]
}
proc arm1_backward {} {
global move_rob
global prod_a1

record_command arm1_backward

set move_rob 1
set prod_a1 [lreplace $prod_a1 1 1 1]
}

proc arm1_mag_on {} {
global prod_a1 a1_mag

record_command arm1_mag_on

set a1_mag 1
set prod_a1 [lreplace $prod_a1 2 2 1]
}
proc arm1_mag_off {} {
global prod_a1 a1_mag

record_command arm1_mag_off

set a1_mag 0
set prod_a1 [lreplace $prod_a1 2 2 0]
}

proc arm2_forward {} {
global move_rob
global prod_a2

record_command arm2_forward

set move_rob 1
set prod_a2 [lreplace $prod_a2 1 1 2]
}
proc arm2_stop {} {
global move_rob
global prod_a2 prod_a1

record_command arm2_stop

if {(![lindex $prod_a1 0]) && (![lindex $prod_a1 1])} {
  set move_rob 0}
set prod_a2 [lreplace $prod_a2 1 1 0]

}
proc arm2_backward {} {
global move_rob
global prod_a2

record_command arm2_backward

set move_rob 1
set prod_a2 [lreplace $prod_a2 1 1 1]
}

proc arm2_mag_on {} {
global prod_a2 a2_mag

record_command arm2_mag_on

set a2_mag 1
set prod_a2 [lreplace $prod_a2 2 2 1]
}
proc arm2_mag_off {} {
global prod_a2 a2_mag

record_command arm2_mag_off

set a2_mag 0
set prod_a2 [lreplace $prod_a2 2 2 0]
}

proc robot_left {} {
global prod_a2 prod_a1
global move_rob

record_command robot_left

set move_rob 1
set prod_a2 [lreplace $prod_a2 0 0 1]
set prod_a1 [lreplace $prod_a1 0 0 1]
}
proc robot_stop {} {
global prod_a2 prod_a1
global move_rob

record_command robot_stop

if {(![lindex $prod_a2 1]) && (![lindex $prod_a1 1])} {
  set move_rob 0}
set prod_a2 [lreplace $prod_a2 0 0 0]
set prod_a1 [lreplace $prod_a1 0 0 0]
}
proc robot_right {} {
global prod_a2 prod_a1
global move_rob

record_command robot_right

set move_rob 1
set prod_a2 [lreplace $prod_a2 0 0 2]
set prod_a1 [lreplace $prod_a1 0 0 2]
}
##########
#Tisch
##########
proc table_left {} {
global move_tb prod_tb

record_command table_left

set move_tb 1
set prod_tb [lreplace $prod_tb 0 0 1]
}
proc table_stop_h {} {
global move_tb prod_tb

record_command table_stop_h

set prod_tb [lreplace $prod_tb 0 0 0]
if {![lindex $prod_tb 1]} { set move_tb 0}
}
proc table_right {} {
global move_tb prod_tb

record_command table_right

set move_tb 1
set prod_tb [lreplace $prod_tb 0 0 2]
}
proc table_upward {} {
global move_tb prod_tb

record_command table_upward

set move_tb 1
set prod_tb [lreplace $prod_tb 1 1 2]
}
proc table_stop_v {} {
global move_tb prod_tb

record_command table_stop_v

set prod_tb [lreplace $prod_tb 1 1 0]
if {![lindex $prod_tb 0]} { set move_tb 0}
}
proc table_downward {} {
global move_tb prod_tb

record_command table_downward

set move_tb 1
set prod_tb [lreplace $prod_tb 1 1 1]
}
##################
#Handhabungsgeraet
##################
proc crane_to_belt2 {} {
global move_cr prod_cr

record_command crane_to_belt2

set move_cr 1
set prod_cr [lreplace $prod_cr 0 0 1]
}
proc crane_stop_h {} {
global move_cr prod_cr

record_command crane_stop_h

set prod_cr [lreplace $prod_cr 0 0 0]
if {![lindex $prod_cr 1]} { set move_cr 0}
}
proc crane_to_belt1 {} {
global move_cr prod_cr

record_command crane_to_belt1

set move_cr 1
set prod_cr [lreplace $prod_cr 0 0 2]
}
proc crane_lift {} {
global move_cr prod_cr

record_command crane_lift

set move_cr 1
set prod_cr [lreplace $prod_cr 1 1 2]
}
proc crane_stop_v {} {
global move_cr prod_cr

record_command crane_stop_v

set prod_cr [lreplace $prod_cr 1 1 0]
if {![lindex $prod_cr 0]} { set move_cr 0}
}
proc crane_lower {} {
global move_cr prod_cr

record_command crane_lower

set move_cr 1
set prod_cr [lreplace $prod_cr 1 1 1]
}

proc crane_mag_on {} {
global prod_cr hg_mag

record_command crane_mag_on

set hg_mag 1
set prod_cr [lreplace $prod_cr 3 3 1]
}

proc crane_mag_off {} {
global prod_cr hg_mag

record_command crane_mag_off

set hg_mag 0
set prod_cr [lreplace $prod_cr 3 3 0]
}
###########
#Presse
###########
proc press_upward {} {
global move_pr prod_pr

record_command press_upward

set move_pr 1
set prod_pr [lreplace $prod_pr 0 0 2]
}

proc press_stop {} {
global move_pr prod_pr

record_command press_stop

set prod_pr [lreplace $prod_pr 0 0 0]
set move_pr 0
}

proc press_downward {} {
global move_pr prod_pr

record_command press_downward

set move_pr 1
set prod_pr [lreplace $prod_pr 0 0 1]
}

########
#Baender
########
proc belt2_start {} {
global move_b2 prod_b2

record_command belt2_start

set move_b2 1
set prod_b2 [lreplace $prod_b2 0 0 1]
}
proc belt2_stop {} {
global move_b2 prod_b2

record_command belt2_stop

set move_b2 0
set prod_b2 [lreplace $prod_b2 0 0 0]
}
proc belt1_start {} {
global move_b1  prod_b1

record_command belt1_start

set move_b1 1
set prod_b1 [lreplace $prod_b1 0 0 1]
}
proc belt1_stop {} {
global move_b1   prod_b1

record_command belt1_stop

set move_b1 0
set prod_b1 [lreplace $prod_b1 0 0 0]
}

###############
#proc blank_add
#
#ein Teil in den Kreislauf aufnehmen
########
proc blank_add {} {
global add_blank 


record_command blank_add

 set add_blank 1

}

#############
#proc blanks_collect
#
#sammelt alle runtergefallenen Teile auf (Status -1)
#############
 
proc blanks_collect {} {
 
return_dropped_blanks
}

################
#proc system_demo
#
#Fuehrt eine Demonstration der Fertigungszelle durch
################
proc system_demo {} {
global demo lauf_demo

record_command system_demo

system_restore
set demo 1
set lauf_demo 0
}
################
#proc system_cont_demo
#
#Setzt die Demonstration der Fertigungszelle weiter
################
proc system_cont_demo {} {
global demo 


set demo 1

}

############
#proc system_restore {}
#versetzt das Bild wieder in den Originalzustand
#es wird keine Sicherheitsabfrage durchgefuehrt
###########
proc system_restore {} {
global canv 
global loc_blanks add_blank
global color_hintergrund
global max_blanks

record_command system_restore

#Stoppen aller Geraete
system_stop

#Wiederherstellen der Teile-Initialisierung
set add_blank 0
unset loc_blanks
for {set i 1} {$i <= $max_blanks} {incr i} {lappend loc_blanks 0} 

#Aufgeben und neues Herstellen des Bildes
 destroy $canv
 canvas .canfr.bild -width 820 -height 480 -background $color_hintergrund
 pack append .canfr .canfr.bild { top  } 
 create_scene

}
#############
# proc system_stop 
#
# stoppt alle Produktionsabschnitte auf ein mal
#############

proc system_stop {} {
global move_rob prod_a2 prod_a1
global move_tb  prod_tb
global move_b2 move_b1 prod_b2 prod_b1
global move_cr prod_cr
global move_pr prod_pr
global demo

record_command system_stop

set demo 0

set move_rob 0
set prod_a2 [lreplace $prod_a2 0 1 0 0]
set prod_a1 [lreplace $prod_a1 0 1 0 0]

set move_tb 0
set prod_tb [lreplace $prod_tb 0 1 0 0]

set move_pr 0
set prod_pr [lreplace $prod_pr 0 0 0]

set move_cr 0
set prod_cr [lreplace $prod_cr	 0 1 0 0]

set move_b2 0
set prod_b2 [lreplace $prod_b2 0 0 0]

set move_b1 0
set prod_b1 [lreplace $prod_b1 0 0 0]
}

#############
# proc system_quit
#
# beendet die Simulation
###############


proc system_quit {} {
global stop

set stop 1
after 1 destroy .

}


###############
# proc get_status 
# 
# setzt das Flag, dass Statusausgabe gewuenscht wird 
# dieses wird in der Haupschleife geprueft und dann
# entsprechend do_get_status augerufen
###############

proc get_status {} {
global status_flag

record_command get_status

set status_flag 1

}

###############
# proc do_get_status 
#
# schreibt einen Statusvektor wie in der Datei protocol beschrien
# auf STDOUT
################

proc do_get_status {} {
global prod_b1 prod_b2 prod_a1 prod_a2 
global prod_tb prod_pr prod_cr
global errorlist

set toleranz_klein 3
set toleranz_gross 10

#Presse
if {[lindex $prod_pr 1] >= [lindex $prod_pr 4] } { set a1 1 } {set a1 0}
if {([lindex $prod_pr 1] >= [lindex $prod_pr 6]) &&
	([lindex $prod_pr 1] <= [expr [lindex $prod_pr 6]+$toleranz_klein])} \
	{ set a2 1 } {set a2 0}
if {[lindex $prod_pr 1] <= 0} { set a3 1 } {set a3 0}

#Roboter
   #Extension of arm 1
   set bewa1 [expr [lindex $prod_a1 11]-[lindex $prod_a1 12]]
   set help [expr [lindex $prod_a1 4]-[lindex $prod_a1 12]]
   if {$help <= 0} {
	   set a4 0} else {
	      if {$help >= $bewa1} {
		   set a4 1} else { set a4 [string range [expr $help/$bewa1.0] 0 5] }
	      }
   #Extension of arm 2
   set bewa1 [expr [lindex $prod_a2 11]-[lindex $prod_a2 12]]
   set help [expr [lindex $prod_a2 4]-[lindex $prod_a2 12]]
   if {$help <= 0} {
	   set a5 0} else {
	      if {$help >= $bewa1} {
		   set a5 1} else { set a5 [string range [expr $help/$bewa1.0] 0 5 ]}
	      }
   #Rotation 	
   set a6 [lindex $prod_a1 3]


#Hubdrehtisch
   set hochtb [lindex $prod_tb 3]
   set tbunten [lindex $prod_tb 10]
   if {($hochtb >= $tbunten) &&
		   ($hochtb <= [expr $tbunten+$toleranz_gross])} { set a7 1 } {set a7 0}
   if {($hochtb <= $toleranz_klein)} { set a8 1 } {set a8 0}

   set a9 [lindex $prod_tb 2]


#Handhabubgsgeraet
   set pos [lindex $prod_cr 2]
   if {($pos >= [lindex $prod_cr 19])&&($pos <= [lindex $prod_cr 20])} {set a10 1} {set a10 0} 
   if {($pos >= [lindex $prod_cr 21])&&($pos <= [lindex $prod_cr 22])} {set a11 1} {set a11 0} 

   set hochhg [lindex $prod_cr 4]
   if {$hochhg <= 1 } {
      set a12 0} else {
	   if {$hochhg >= [lindex $prod_cr 5]} {
		   set a12 1} else {
			   set a12 [string range [expr $hochhg/[lindex $prod_cr 5].0] 0 5]
			   }
		   }

   set a13 [lindex $prod_b1 6]
   set a14 [lindex $prod_b2 6]


set a15 $errorlist
set errorlist 0

puts stdout "$a1 \n$a2 \n$a3 \n$a4 \n$a5 \n$a6 \n$a7 \n$a8 \n$a9 \n$a10 \n$a11 \n$a12 \n$a13 \n$a14 \n\{$a15\}"
flush stdout 


}
###############
# proc get_status_intern
#
# gibt einen Statusvektor wie in der Datei protocol beschrien
# zurueck, wird fuer die programminterne Statusabfrage verwendet,
# da nichts auf STDOUT geschrieben wird,
# entspricht ansonsten voll der Prozedur get_status
################

proc get_status_intern {} {
global prod_b1 prod_b2 prod_a1 prod_a2 
global prod_tb prod_pr prod_cr
global errorlist

set toleranz_klein 3
set toleranz_gross 10


#Presse
  if {[lindex $prod_pr 1] >= [lindex $prod_pr 4] } { set a1 1 } {set a1 0}
  if {([lindex $prod_pr 1] >= [lindex $prod_pr 6]) &&
	  ([lindex $prod_pr 1] <= [expr [lindex $prod_pr 6]+$toleranz_klein])} \
	  { set a2 1 } {set a2 0}
  if {[lindex $prod_pr 1] <= 0} { set a3 1 } {set a3 0}

#Roboter
    #Extension of arm 1
    set bewa1 [expr [lindex $prod_a1 11]-[lindex $prod_a1 12]]
    set help [expr [lindex $prod_a1 4]-[lindex $prod_a1 12]]
    if {$help <= 0} {
	    set a4 0} else {
	       if {$help >= $bewa1} {
		    set a4 1} else { set a4 [string range [expr $help/$bewa1.0] 0 5] }
	       }
    #Extension of arm 2
    set bewa1 [expr [lindex $prod_a2 11]-[lindex $prod_a2 12]]
    set help [expr [lindex $prod_a2 4]-[lindex $prod_a2 12]]
    if {$help <= 0} {
	    set a5 0} else {
	       if {$help >= $bewa1} {
		    set a5 1} else { set a5 [string range [expr $help/$bewa1.0] 0 5] }
	       }
    #Robot's angle
    set a6 [lindex $prod_a1 3]

#Hubdrehtisch
    set hochtb [lindex $prod_tb 3]
    set tbunten [lindex $prod_tb 10]
    if {($hochtb >= $tbunten) &&
		    ($hochtb <= [expr $tbunten+$toleranz_gross])} { set a7 1 } {set a7 0}
    if {($hochtb <= $toleranz_klein)} { set a8 1 } {set a8 0}

    set a9 [lindex $prod_tb 2]

#Handhabubgsgeraet
    set pos [lindex $prod_cr 2]
    if {($pos >= [lindex $prod_cr 19])&&($pos <= [lindex $prod_cr 20])} {set a10 1} {set a10 0} 
    if {($pos >= [lindex $prod_cr 21])&&($pos <= [lindex $prod_cr 22])} {set a11 1} {set a11 0} 

    set hochhg [lindex $prod_cr 4]
    if {$hochhg <= 1 } {
       set a12 0} else {
	    if {$hochhg >= [lindex $prod_cr 5]} {
		    set a12 1} else {
			    set a12 [string range [expr $hochhg/[lindex $prod_cr 5].0] 0 5]
			    }
		    }

    set a13 [lindex $prod_b1 6]
    set a14 [lindex $prod_b2 6]


set a15 $errorlist
set errorlist 0

return "$a1 $a2 $a3 $a4 $a5 $a6 $a7 $a8 $a9 $a10 $a11 $a12 $a13 $a14 \{$a15\}"


}

##############
# proc get_passings 
#
# aktiviert den passings_flag,
# so dass aus der Haupschleife do_get_passings
# aufgerufen werden kann
##############

proc get_passings {} {
global passings_flag

record_command get_passings

set passings_flag 1
}

##############
#proc do_get_passings
#
# Die Prozedur gibt die Anzahl der Durchlaeufe der Hauptschleife 
# modulo 10000 nach aussen bekannt
# Damit kann eine gewisse Synchronisation vorgenommen werden
#############

proc do_get_passings {} {
global passings

puts stdout $passings
flush stdout
}

#############
#proc new_guard
#
# nimmt in die Waechteliste einen neuen Waechter auf
#############
proc new_guard {nummer_sensor operator zielwert operation} {
global guardslist 

set waechter "$nummer_sensor $operator $zielwert $operation"
lappend guardslist $waechter
}
