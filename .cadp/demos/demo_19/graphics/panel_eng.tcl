
####################################################################
#
# Datei panel_eng
#
# Autor : 	   Artur Brauer
# Erstellzetraum : 30.03.93
#
# Diese Datei enthaelt die Aufbauroutinen fuer den Steuerblock der 
# Fertigungszellen-Simulation (englische Version)
#
####################################################################


############
#proc build
#
#Parameter ist der Pfadname fuer das Widget in dem das Frame aufgebaut wird
#Die Prozedur baut den Steuerblock fuer die Fertigungszellensimulation auf
############

proc build {bedfr} {
global color_rob_a1 color_rob_a2 color_b1_rand color_b2_rand color_press color_tab
global color_schwarzweiss

frame $bedfr -relief sunken -borderwidth 1 


#Wenn die Darstellung auf einem Schwarzweissmonitor erfolgt
#die Hintergrundfarben auf weiss waehlen

#
#

case $color_schwarzweiss in { 
 {color} {
    set color_rob_a1_neu  $color_rob_a1
    set color_rob_a1_mag  $color_rob_a1
    set color_rob_a2_neu  $color_rob_a2
    set color_rob_a2_mag  $color_rob_a2
    set color_b1_rand_neu $color_b1_rand
    set color_b2_rand_neu $color_b2_rand
    set color_press_neu 	 $color_press
    set color_tab_neu 	 $color_tab
   } 
  {schwarzweiss} {
    #Defaulthintergrundfarbe feststellen
    set color_default [lindex [$bedfr configure -background] 4]
    set color_rob_a1_neu  $color_default
    set color_rob_a1_mag  black
    set color_rob_a2_neu  $color_default
    set color_rob_a2_mag  black
    set color_b1_rand_neu $color_default
    set color_b2_rand_neu $color_default
    set color_press_neu   $color_default
    set color_tab_neu 	  $color_default
   }
 }

frame $bedfr.roboter -relief raised -borderwidth 1
######
#Arm1
######
frame $bedfr.roboter.arm1 -relief raised -borderwidth 1
label $bedfr.roboter.arm1.name -relief flat -text "ARM 1" -background $color_rob_a1_neu
frame $bedfr.roboter.arm1.links -relief flat
button $bedfr.roboter.arm1.links.f1 -relief raised -borderwidth 1 -text "forward" \
	-command "schreibe arm1_forward"
button $bedfr.roboter.arm1.links.f2 -relief raised -borderwidth 1 -text "stop" \
	-command "schreibe arm1_stop"
button $bedfr.roboter.arm1.links.f3 -relief raised -borderwidth 1 -text "backward" \
	-command "schreibe arm1_backward"
frame $bedfr.roboter.arm1.rechts -relief flat
label $bedfr.roboter.arm1.rechts.maglab -relief flat -text "magnet" 
checkbutton $bedfr.roboter.arm1.rechts.magnet -relief raised -borderwidth 1   \
	-command "arm1_mag" -variable a1_mag -selectcolor $color_rob_a1_mag
pack append $bedfr.roboter.arm1.links \
		$bedfr.roboter.arm1.links.f1 {top fillx} \
	        $bedfr.roboter.arm1.links.f2 {top fillx} \
		$bedfr.roboter.arm1.links.f3 {top fillx}
pack append $bedfr.roboter.arm1.rechts \
		$bedfr.roboter.arm1.rechts.maglab {top fillx} \
	        $bedfr.roboter.arm1.rechts.magnet {top} 

pack append $bedfr.roboter.arm1 $bedfr.roboter.arm1.name {top fillx} \
		$bedfr.roboter.arm1.links {left fillx} \
	        $bedfr.roboter.arm1.rechts {right fillx} 
#####
#Arm2
#####
frame $bedfr.roboter.arm2 -relief raised -borderwidth 1
label $bedfr.roboter.arm2.name -relief flat -text "ARM 2" -background $color_rob_a2_neu
frame $bedfr.roboter.arm2.links -relief flat
button $bedfr.roboter.arm2.links.f1 -relief raised -borderwidth 1 -text "forward" \
	-command "schreibe arm2_forward"
button $bedfr.roboter.arm2.links.f2 -relief raised -borderwidth 1 -text "stop" \
	-command "schreibe arm2_stop"
button $bedfr.roboter.arm2.links.f3 -relief raised -borderwidth 1 -text "backward" \
	-command "schreibe arm2_backward" 
frame $bedfr.roboter.arm2.rechts -relief flat
label $bedfr.roboter.arm2.rechts.maglab -relief flat -text "magnet" 
checkbutton $bedfr.roboter.arm2.rechts.magnet -relief raised -borderwidth 1   \
	-command "arm2_mag" -variable a2_mag -selectcolor $color_rob_a2_mag
pack append $bedfr.roboter.arm2.links \
		$bedfr.roboter.arm2.links.f1 {top fillx} \
	        $bedfr.roboter.arm2.links.f2 {top fillx} \
		$bedfr.roboter.arm2.links.f3 {top fillx}
pack append $bedfr.roboter.arm2.rechts \
		$bedfr.roboter.arm2.rechts.maglab {top} \
	        $bedfr.roboter.arm2.rechts.magnet {top} 

pack append $bedfr.roboter.arm2 $bedfr.roboter.arm2.name {top fillx} \
		$bedfr.roboter.arm2.links {left fillx} \
	        $bedfr.roboter.arm2.rechts {right fillx} 

########
#Roboter
########
frame $bedfr.roboter.rob -relief raised -borderwidth 1
label $bedfr.roboter.rob.name -relief flat -text "ROBOT" 
button $bedfr.roboter.rob.f1 -relief raised -borderwidth 1 -text "left" -command "schreibe robot_left"
button $bedfr.roboter.rob.f2 -relief raised -borderwidth 1 -text "stop" \
	-command "schreibe robot_stop"
button $bedfr.roboter.rob.f3 -relief raised -borderwidth 1 -text "right" \
	-command "schreibe robot_right"
pack append $bedfr.roboter.rob $bedfr.roboter.rob.name {top fillx} \
	$bedfr.roboter.rob.f1 {left fillx expand}\
	$bedfr.roboter.rob.f2 {left fillx expand}\
	$bedfr.roboter.rob.f3 {left fillx expand}


pack append $bedfr.roboter $bedfr.roboter.rob {top fillx} \
			   $bedfr.roboter.arm2 {right} \
			   $bedfr.roboter.arm1 {right}


######
#Band2
######
frame $bedfr.band2 -relief raised -borderwidth 1 
message $bedfr.band2.name -relief flat -text "UPPER\nBELT"\
		 -background $color_b2_rand_neu -justify center

button $bedfr.band2.f1 -relief raised -borderwidth 1 -text "start" \
	-command "schreibe belt2_start"
button $bedfr.band2.f2 -relief raised -borderwidth 1 -text "stop" \
	-command "schreibe belt2_stop"
pack append $bedfr.band2 $bedfr.band2.name {top fillx} \
	$bedfr.band2.f1 {top fillx} $bedfr.band2.f2 {top fillx} 

######
#Band1
######
frame $bedfr.band1 -relief raised -borderwidth 1 
message $bedfr.band1.name -relief flat -text "LOWER\nBELT" -background $color_b1_rand_neu\
				-justify center
button $bedfr.band1.f1 -relief raised -borderwidth 1 -text "start" \
	-command "schreibe belt1_start"
button $bedfr.band1.f2 -relief raised -borderwidth 1 -text "stop" \
	-command "schreibe belt1_stop"
pack append $bedfr.band1 $bedfr.band1.name {top fillx} $bedfr.band1.f1 {top fillx}\
	 $bedfr.band1.f2 {top fillx} 

#######
#Presse
#######1z
frame $bedfr.press -relief raised -borderwidth 1
label $bedfr.press.name -relief flat -text "PRESS" -background $color_press_neu
button $bedfr.press.f1 -relief raised -borderwidth 1 -text "press"\
				 -command "schreibe press_upward"
button $bedfr.press.f2 -relief raised -borderwidth 1 -text "stop" \
	-command "schreibe press_stop"
button $bedfr.press.f3 -relief raised -borderwidth 1 -text "open"\
				 -command "schreibe press_downward"
pack append $bedfr.press $bedfr.press.name {top fillx} \
	 $bedfr.press.f1 {top fillx} $bedfr.press.f2 {top fillx}\
	 $bedfr.press.f3 {top fillx} 


###################
#Hub- und Drehtisch
###################
frame $bedfr.tisch -relief raised -borderwidth 1
label $bedfr.tisch.name -relief flat -text "TABLE" -background $color_tab_neu
frame $bedfr.tisch.links -relief flat 
button $bedfr.tisch.links.f1 -relief raised -borderwidth 1 -text "left" \
	-command "schreibe table_left"
button $bedfr.tisch.links.f2 -relief raised -borderwidth 1 -text "stop" \
	-command "schreibe table_stop_h"
button $bedfr.tisch.links.f3 -relief raised -borderwidth 1 -text "right" \
	-command "schreibe table_right"
frame $bedfr.tisch.rechts -relief flat 
button $bedfr.tisch.rechts.f1 -relief raised -borderwidth 1 -text "up" \
	-command "schreibe table_upward"
button $bedfr.tisch.rechts.f2 -relief raised -borderwidth 1 -text "stop" \
	-command "schreibe table_stop_v"
button $bedfr.tisch.rechts.f3 -relief raised -borderwidth 1 -text "down" \
	-command "schreibe table_downward"


pack append $bedfr.tisch.links $bedfr.tisch.links.f1 {left fillx}\
	 $bedfr.tisch.links.f2 {left fillx} $bedfr.tisch.links.f3 {left fillx}
pack append $bedfr.tisch.rechts  $bedfr.tisch.rechts.f1 {top fillx}\
	 $bedfr.tisch.rechts.f2 {top fillx} $bedfr.tisch.rechts.f3 {top fillx}
pack append $bedfr.tisch $bedfr.tisch.name {top fillx} \
	 $bedfr.tisch.links {top fillx filly pady 5}\
	 $bedfr.tisch.rechts {top  filly padx 10} 


##################
#Handhabungsgeraet 
##################
frame $bedfr.hhger -relief raised -borderwidth 1
label $bedfr.hhger.name -relief flat -text "CRANE"

frame $bedfr.hhger.mitte -relief flat
frame $bedfr.hhger.mitte.links -relief flat 
button $bedfr.hhger.mitte.links.f1 -relief raised -borderwidth 1 -text "up" \
	-command "schreibe crane_to_belt2"
button $bedfr.hhger.mitte.links.f2 -relief raised -borderwidth 1 -text "stop" \
	-command "schreibe crane_stop_h"
button $bedfr.hhger.mitte.links.f3 -relief raised -borderwidth 1 -text "down" \
	-command "schreibe crane_to_belt1"
frame $bedfr.hhger.mitte.rechts -relief flat 
button $bedfr.hhger.mitte.rechts.f1 -relief raised -borderwidth 1 -text "lift" \
	-command "schreibe crane_lift"
button $bedfr.hhger.mitte.rechts.f2 -relief raised -borderwidth 1 -text "stop" \
	-command "schreibe crane_stop_v"
button $bedfr.hhger.mitte.rechts.f3 -relief raised -borderwidth 1 -text "lower" \
	-command "schreibe crane_lower"
frame $bedfr.hhger.unten -relief flat
label $bedfr.hhger.unten.maglab -relief flat -text "magnet" 
checkbutton $bedfr.hhger.unten.magnet -relief raised -borderwidth 1   \
	-command "crane_mag" -variable hg_mag -selectcolor red


pack append $bedfr.hhger.unten $bedfr.hhger.unten.maglab {top } \
				$bedfr.hhger.unten.magnet {top fillx}

pack append $bedfr.hhger.mitte.links $bedfr.hhger.mitte.links.f1 {top fillx}\
	 $bedfr.hhger.mitte.links.f2 {top fillx} $bedfr.hhger.mitte.links.f3 {top fillx}

pack append $bedfr.hhger.mitte.rechts  $bedfr.hhger.mitte.rechts.f1 {top fillx}\
	 $bedfr.hhger.mitte.rechts.f2 {top fillx} $bedfr.hhger.mitte.rechts.f3 {top fillx}

pack append $bedfr.hhger.mitte $bedfr.hhger.mitte.links {left} \
				$bedfr.hhger.mitte.rechts {left}

pack append $bedfr.hhger $bedfr.hhger.name {top fillx} \
	 $bedfr.hhger.mitte {top} \
	 $bedfr.hhger.unten  {bottom pady 10}

#####
#Teile
#####
frame $bedfr.teile -relief flat
button $bedfr.teile.add -relief raised -borderwidth 1 -text "BLANK" \
			-command "schreibe blank_add"

button $bedfr.teile.get -relief raised -borderwidth 1 -text "COLLECT" \
			-command "schreibe blanks_collect"

button $bedfr.teile.demo -relief raised -borderwidth 1 -text "DEMO" \
			-command "schreibe system_demo"

button $bedfr.teile.rest -relief raised -borderwidth 1 -text "RESTORE" \
			-command "schreibe system_restore"

pack append $bedfr.teile $bedfr.teile.add {top fillx} \
			 $bedfr.teile.get {top fillx} \
			 $bedfr.teile.demo {top fillx} \
			 $bedfr.teile.rest {top fillx}


#####
#Stop
#####
button $bedfr.stop -relief raised -borderwidth 1 -text "STOP" \
	-command "schreibe system_stop"

####
#Aus
####
button $bedfr.aus -relief raised -borderwidth 1 -text "QUIT" -command "quit"


pack append $bedfr \
    $bedfr.roboter {top right padx 5 pady 5} \
    $bedfr.tisch {top right padx 5 filly} \
    $bedfr.press {top right padx 5 filly} \
    $bedfr.band2 {top right padx 5 filly} \
    $bedfr.band1 {top right padx 5 filly} \
    $bedfr.hhger {top right padx 5 filly} \
    $bedfr.teile {top right padx 5} \
    $bedfr.stop {top right filly padx 10} \
    $bedfr.aus {top left filly}

#   $bedfr.arm1 {top right padx 5} \
#   $bedfr.arm2 {top right padx 5} \
#    $bedfr.rob {top right padx 5} \


}

proc arm1_mag {} {
global a1_mag
if {$a1_mag == 1 } {
	schreibe arm1_mag_on} else {
	  schreibe arm1_mag_off}
}
proc arm2_mag {} {
global a2_mag
if {$a2_mag == 1 } {
	schreibe arm2_mag_on} else {
	  schreibe arm2_mag_off}
}
proc crane_mag {} {
global hg_mag
if {$hg_mag == 1 } {
	schreibe crane_mag_on} else {
	  schreibe crane_mag_off}
}
proc schreibe {text} {
puts stdout $text
flush stdout
}

proc quit {} {
puts stdout system_quit
flush stdout

destroy .
}


