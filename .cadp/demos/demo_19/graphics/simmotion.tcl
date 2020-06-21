
####################################################################
#
# Datei simmotion.tcl
#
# VERSION: 9.1
# Autor : 	    Artur Brauer
# Erstellzetraum :  November 1992 bis November 1993
# letzte Aenderung: April 94 
#
# Diese Datei enthaelt die Graphikaktualisierungs- und
# Graphikverwaltungsfunktionen
#
####################################################################


#*******************************
# proc update_robot {}
# dreht den Roboter 
# um den Punkt (umx,umy)
# um einen festen Winkel weiter
#*******************************
proc update_robot {umx umy} {
global canv
global prod_a2 prod_a1 prod_pr prod_tb
global move_rob
global winkelr cosr sinr
global arms_extension_speed

#Initialisierung
set stop_rob 0
set anschlag_links -100
set anschlag_rechts 70

set gedreht [lindex $prod_a2 3]
set gefahren_a2 [lindex $prod_a2 4]
set gefahren_a1 [lindex $prod_a1 4]

set posx1_a2 [lindex $prod_a2 6]
set posy1_a2 [lindex $prod_a2 7]
set posx2_a2 [lindex $prod_a2 8]
set posy2_a2 [lindex $prod_a2 9]


set posx1_a1 [lindex $prod_a1 6]
set posy1_a1 [lindex $prod_a1 7]
set posx2_a1 [lindex $prod_a1 8]
set posy2_a1 [lindex $prod_a1 9]


#Init Teil
set stat_a1 [lindex $prod_a1 10]
set stat_a2 [lindex $prod_a2 10]

foreach i "$stat_a2 $stat_a1" {
 set poslist [$canv coord $i]
 set posx1($i) [lindex $poslist 0]
 set posy1($i) [lindex $poslist 1]
 set posx2($i) [lindex $poslist 2]
 set posy2($i) [lindex $poslist 3]
}

#Berechnung

#Transformieren
set posx2_a2 [expr $posx2_a2-$umx]
set posy2_a2 [expr $posy2_a2-$umy]
set posx2_a1 [expr $posx2_a1-$umx]
set posy2_a1 [expr $posy2_a1-$umy]
set posx1_a2 [expr $posx1_a2-$umx]
set posy1_a2 [expr $posy1_a2-$umy]
set posx1_a1 [expr $posx1_a1-$umx]
set posy1_a1 [expr $posy1_a1-$umy]
#Teile transformieren
foreach i "$stat_a2 $stat_a1" {
 set posx1($i) [expr $posx1($i)-$umx]
 set posy1($i) [expr $posy1($i)-$umy]
 set posx2($i) [expr $posx2($i)-$umx]
 set posy2($i) [expr $posy2($i)-$umy]
}



 #Drehen von Roboter und Teilen

if {([lindex $prod_a2 0] == 1) && ($gedreht > $anschlag_links)} {

 #Drehung nach links
 set posx2_a2_neu [expr $cosr*$posx2_a2+$sinr*$posy2_a2]
 set posy2_a2_neu [expr -$sinr*$posx2_a2+$cosr*$posy2_a2]
 set posx2_a1_neu [expr $cosr*$posx2_a1+$sinr*$posy2_a1]
 set posy2_a1_neu [expr -$sinr*$posx2_a1+$cosr*$posy2_a1]
 set posx1_a2_neu [expr $cosr*$posx1_a2+$sinr*$posy1_a2]
 set posy1_a2_neu [expr -$sinr*$posx1_a2+$cosr*$posy1_a2]
 set posx1_a1_neu [expr $cosr*$posx1_a1+$sinr*$posy1_a1]
 set posy1_a1_neu [expr -$sinr*$posx1_a1+$cosr*$posy1_a1]

 #Teil mitdrehen
 foreach i "$stat_a2 $stat_a1" {
  set posx2_neu($i) [expr $cosr*$posx2($i)+$sinr*$posy2($i)]
  set posy2_neu($i) [expr -$sinr*$posx2($i)+$cosr*$posy2($i)]
  set posx1_neu($i) [expr $cosr*$posx1($i)+$sinr*$posy1($i)]
  set posy1_neu($i) [expr -$sinr*$posx1($i)+$cosr*$posy1($i)]
  }

 #Test ob Anschlag erreicht ist
 set gedreht [expr $gedreht-$winkelr]
 if {$gedreht <= $anschlag_links} {
	   # Armbewegung anhalten, da Anschlag erreicht
	   # "Roboter - linker Anschlag"
	   report_message 4
	   if {(![lindex $prod_a1 1]) && (![lindex $prod_a2 1])} {
	      set stop_rob 1}
	   set prod_a2 [lreplace $prod_a2 0 0 0]
	   set prod_a1 [lreplace $prod_a1 0 0 0]
	  }


} else {


if {([lindex $prod_a1 0] == 2) && ($gedreht < $anschlag_rechts) } {

#Drehung nach rechts
 set posx2_a2_neu [expr $cosr*$posx2_a2-$sinr*$posy2_a2]
 set posy2_a2_neu [expr $sinr*$posx2_a2+$cosr*$posy2_a2]
 set posx2_a1_neu [expr $cosr*$posx2_a1-$sinr*$posy2_a1]
 set posy2_a1_neu [expr $sinr*$posx2_a1+$cosr*$posy2_a1]
 set posx1_a2_neu [expr $cosr*$posx1_a2-$sinr*$posy1_a2]
 set posy1_a2_neu [expr $sinr*$posx1_a2+$cosr*$posy1_a2]
 set posx1_a1_neu [expr $cosr*$posx1_a1-$sinr*$posy1_a1]
 set posy1_a1_neu [expr $sinr*$posx1_a1+$cosr*$posy1_a1]
 
 #Teil mitdrehen
 foreach i "$stat_a2 $stat_a1" {
 set posx2_neu($i) [expr $cosr*$posx2($i)-$sinr*$posy2($i)]
 set posy2_neu($i) [expr $sinr*$posx2($i)+$cosr*$posy2($i)]
 set posx1_neu($i) [expr $cosr*$posx1($i)-$sinr*$posy1($i)]
 set posy1_neu($i) [expr $sinr*$posx1($i)+$cosr*$posy1($i)]
 }	

 #Test ob Roboter anschlag erreicht hat
  set gedreht [expr $gedreht+$winkelr]
  if {$gedreht >= $anschlag_rechts} {
	    #Armbewegung anhalten, da Anschlag erreicht
	    # "Roboter - rechter Anschlag"
	    report_message 5
	    if {(![lindex $prod_a1 1]) && (![lindex $prod_a2 1])} {
	       set stop_rob 1}
	    set prod_a2 [lreplace $prod_a2 0 0 0]
	    set prod_a1 [lreplace $prod_a1 0 0 0]
	   }

 } else {

 #Dieser Fall ist von Interesse wenn die Arme nur geschoben werden
 set posx2_a2_neu $posx2_a2
 set posy2_a2_neu $posy2_a2
 set posx2_a1_neu $posx2_a1
 set posy2_a1_neu $posy2_a1
 set posx1_a2_neu $posx1_a2
 set posy1_a2_neu $posy1_a2
 set posx1_a1_neu $posx1_a1
 set posy1_a1_neu $posy1_a1
#Teile
 foreach i "$stat_a2 $stat_a1" {
  set posx2_neu($i) $posx2($i)
  set posy2_neu($i) $posy2($i)
  set posx1_neu($i) $posx1($i)
  set posy1_neu($i) $posy1($i)
  }

 }
}



#Schieben der beiden Arme nach vorn bzw. nach hinten
#Arm2
if {[lindex $prod_a2 1] == 1} {

 #Bewegung rueckwaerts
 if {$gefahren_a2 >= [lindex $prod_a2 12]} {
         set norm1 [lindex $prod_a2 5 ]
	 set faktor [expr $arms_extension_speed/$norm1]
	 set trx [expr ($posx1_a2_neu-$posx2_a2_neu)*$faktor]
	 set try [expr ($posy1_a2_neu-$posy2_a2_neu)*$faktor]
	 set posx2_a2_neu [expr $posx2_a2_neu+$trx]
	 set posy2_a2_neu [expr $posy2_a2_neu+$try]
	 set posx1_a2_neu [expr $posx1_a2_neu+$trx]
	 set posy1_a2_neu [expr $posy1_a2_neu+$try]
	 set gefahren_a2 [expr $gefahren_a2-$arms_extension_speed]

 	#Teile
	 foreach i "$stat_a2" {
	  set posx2_neu($i) [expr $posx2_neu($i)+$trx]
	  set posy2_neu($i) [expr $posy2_neu($i)+$try]
	  set posx1_neu($i) [expr $posx1_neu($i)+$trx]
	  set posy1_neu($i) [expr $posy1_neu($i)+$try]
	  }

	} else {
	   #Armbewegung anhalten, da Anschlag erreicht
	   if {(![lindex $prod_a1 0]) && (![lindex $prod_a1 1])} {
	      set stop_rob 1}
	   set prod_a2 [lreplace $prod_a2 1 1 0]
	  }

} else { if {[lindex $prod_a2 1] == 2} {

 #Bewegung vorwaerts
 if {$gefahren_a2 <= [lindex $prod_a2 11]} {
         set norm1 [lindex $prod_a2 5 ]
	 set faktor [expr $arms_extension_speed/$norm1]
	 set trx [expr ($posx2_a2_neu-$posx1_a2_neu)*$faktor]
	 set try [expr ($posy2_a2_neu-$posy1_a2_neu)*$faktor]
	 set posx2_a2_neu [expr $posx2_a2_neu+$trx]
	 set posy2_a2_neu [expr $posy2_a2_neu+$try]
	 set posx1_a2_neu [expr $posx1_a2_neu+$trx]
	 set posy1_a2_neu [expr $posy1_a2_neu+$try]
	 set gefahren_a2 [expr $gefahren_a2+$arms_extension_speed]

 	#Teile
	 foreach i "$stat_a2" {
	  set posx2_neu($i) [expr $posx2_neu($i)+$trx]
	  set posy2_neu($i) [expr $posy2_neu($i)+$try]
	  set posx1_neu($i) [expr $posx1_neu($i)+$trx]
	  set posy1_neu($i) [expr $posy1_neu($i)+$try]
	}

    
	} else {
	   #Armbewegung anhalten, da Anschlag erreicht
	   if {(![lindex $prod_a1 0]) && (![lindex $prod_a1 1])} {
	       set stop_rob 1}
	   set prod_a2 [lreplace $prod_a2 1 1 0]
	  }
      }
}

#Arm1
if {[lindex $prod_a1 1] == 1} {

 #Bewegung rueckwaerts
 if {$gefahren_a1 >= [lindex $prod_a1 12]} {
         set norm1 [lindex $prod_a1 5 ]
	 set faktor [expr $arms_extension_speed/$norm1]
	 set trx [expr ($posx1_a1_neu-$posx2_a1_neu)*$faktor]
	 set try [expr ($posy1_a1_neu-$posy2_a1_neu)*$faktor]
	 set posx2_a1_neu [expr $posx2_a1_neu+$trx]
	 set posy2_a1_neu [expr $posy2_a1_neu+$try]
	 set posx1_a1_neu [expr $posx1_a1_neu+$trx]
	 set posy1_a1_neu [expr $posy1_a1_neu+$try]
	 set gefahren_a1 [expr $gefahren_a1-$arms_extension_speed]

 	#Teile
	 foreach i "$stat_a1" {
	  set posx2_neu($i) [expr $posx2_neu($i)+$trx]
	  set posy2_neu($i) [expr $posy2_neu($i)+$try]
	  set posx1_neu($i) [expr $posx1_neu($i)+$trx]
	  set posy1_neu($i) [expr $posy1_neu($i)+$try]
	  }
	} else {
	    #Armbewegung anhalten, da Anschlag erreicht
	    if {(![lindex $prod_a2 0]) && (![lindex $prod_a2 1])} {
                 set stop_rob 1}
            set prod_a1 [lreplace $prod_a1 1 1 0]
	  }

} else { if {[lindex $prod_a1 1] == 2} {

 #Bewegung vorwaerts von Arm1
 if {$gefahren_a1 <= [lindex $prod_a1 11]} {
         set norm1 [lindex $prod_a1 5 ]
	 set faktor [expr $arms_extension_speed/$norm1]
	 set trx [expr ($posx2_a1_neu-$posx1_a1_neu)*$faktor]
	 set try [expr ($posy2_a1_neu-$posy1_a1_neu)*$faktor]
	 set posx2_a1_neu [expr $posx2_a1_neu+$trx]
	 set posy2_a1_neu [expr $posy2_a1_neu+$try]
	 set posx1_a1_neu [expr $posx1_a1_neu+$trx]
	 set posy1_a1_neu [expr $posy1_a1_neu+$try]
	 set gefahren_a1 [expr $gefahren_a1+$arms_extension_speed]

 	#Teile
	 foreach i "$stat_a1" {
	  set posx2_neu($i) [expr $posx2_neu($i)+$trx]
	  set posy2_neu($i) [expr $posy2_neu($i)+$try]
	  set posx1_neu($i) [expr $posx1_neu($i)+$trx]
	  set posy1_neu($i) [expr $posy1_neu($i)+$try]
	  }


	} else {
	    #Armbewegung anhalten, da Anschlag erreicht
	    if {(![lindex $prod_a2 0]) && (![lindex $prod_a2 1])} {
                 set stop_rob 1}
            set prod_a1 [lreplace $prod_a1 1 1 0]
	  }
  }
}

#Zuruecktransformieren
set posx2_a2_neu [expr $posx2_a2_neu+$umx]
set posy2_a2_neu [expr $posy2_a2_neu+$umy]
set posx2_a1_neu [expr $posx2_a1_neu+$umx]
set posy2_a1_neu [expr $posy2_a1_neu+$umy]
set posx1_a2_neu [expr $posx1_a2_neu+$umx]
set posy1_a2_neu [expr $posy1_a2_neu+$umy]
set posx1_a1_neu [expr $posx1_a1_neu+$umx]
set posy1_a1_neu [expr $posy1_a1_neu+$umy]

#ZrTransf Teil
foreach i "$stat_a2 $stat_a1" {
 set posx2_neu($i) [expr $posx2_neu($i)+$umx]
 set posy2_neu($i) [expr $posy2_neu($i)+$umy]
 set posx1_neu($i) [expr $posx1_neu($i)+$umx]
 set posy1_neu($i) [expr $posy1_neu($i)+$umy]
} 


#Darstellen

if { $move_rob } {
 $canv coord arm2_tg $posx1_a2_neu $posy1_a2_neu $posx2_a2_neu $posy2_a2_neu
 $canv coord arm1_tg $posx1_a1_neu $posy1_a1_neu $posx2_a1_neu $posy2_a1_neu

 foreach i "$stat_a2 $stat_a1" {
  $canv coord $i $posx1_neu($i) $posy1_neu($i) $posx2_neu($i) $posy2_neu($i)
 }

########KOLLISIONSABFRAGE#####################

  #Kollisionsabfrage zwischen Roboter und Presse
    set rect  [$canv coords prs_tg]
    set items [eval $canv find overlapping $rect]
    #fuer Arm1:
     set arm1_item [$canv find withtag arm1_tg]
     if { ([lsearch $items $arm1_item] != -1) && \
	    ([lindex $prod_pr 1] < [lindex $prod_pr 6])} {
	# "Roboter - Kollision von Arm 1 mit der Presse "
	report_message 7
	set prod_a1 [lreplace $prod_a1 0 1 0 0 ]
	set prod_a2 [lreplace $prod_a2 0 1 0 0 ]
	set move_rob 0
	} else {
     #fuer Arm2:
     set arm2_item [$canv find withtag arm2_tg]
       if { ([lsearch $items $arm2_item] != -1) && \
	    ( [lindex $prod_pr 1] < [lindex $prod_pr 4] ) && \
	    ( [lindex $prod_pr 1] > [lindex $prod_pr 5] ) } {
	 # "Roboter - Kollision von Arm 2 mit der Presse "
	 report_message 9
	 set prod_a1 [lreplace $prod_a1 0 1 0 0 ]
	 set prod_a2 [lreplace $prod_a2 0 1 0 0 ]
	 set move_rob 0
	 } 
       }

#======================
# Kollisionserkennung, sind Teile auf dem
# Tisch mit dem Teil am Roboterarm kollidiert ?
#======================

#die Variable toleranz enthaelt die Hoehe bei der die Teile 
#immer noch kollidieren, ist also die hoehe eines Teiles

set toleranz 4
set hoch [lindex $prod_tb 3]

 if { ($hoch <= $toleranz) && ([set robotblank [lindex $prod_a1 10]] != "") }\
   then {
#   echo bin beim testen
   foreach blank [lindex $prod_tb 8] {
     if { [blanks_intersect $blank $robotblank]} {

       # Teile sind kollidiert 
       report_message 16
	 set prod_a1 [lreplace $prod_a1 0 1 0 0 ]
	 set prod_a2 [lreplace $prod_a2 0 1 0 0 ]
	 set move_rob 0
     }
   }
 }


 #Statusvariable aktualisieren
 set prod_a2 [lreplace $prod_a2 3 4 $gedreht $gefahren_a2] 
 set prod_a1 [lreplace $prod_a1 3 4 $gedreht $gefahren_a1] 

 set prod_a2 [lreplace $prod_a2 6 9 $posx1_a2_neu $posy1_a2_neu\
		$posx2_a2_neu $posy2_a2_neu]
 set prod_a1 [lreplace $prod_a1 6 9 $posx1_a1_neu $posy1_a1_neu\
		$posx2_a1_neu $posy2_a1_neu]

 }

#END proc
}


#**************************
# proc update_belt2 {}
# bewegt das Band2 in Canvas "canv" nach links 
#**************************
proc update_belt2 {} {
global prod_b2  canv
global color_b2_led_an color_b2_led_aus
global belt2_speed


set marks [lindex $prod_b2 3]
set gelaufen [lindex $prod_b2 1]

if {$gelaufen <= [lindex $prod_b2 2]} {
  foreach i $marks {
   $canv addtag blt2_tg withtag $i
   }
  $canv move blt2_tg $belt2_speed 0
  set prod_b2 [lreplace $prod_b2 1 1 [expr $gelaufen-$belt2_speed]]
 } else { 
  foreach i $marks {
   $canv dtag $i blt2_tg
   $canv move $i $belt2_speed 0
   }
  $canv move blt2_tg $gelaufen 0
  set prod_b2 [lreplace $prod_b2 1 1 [expr $gelaufen-[lindex $prod_b2 1]]]
  }

#Lichtschranke auf leer schalten ??
if {[lindex $prod_b2 6]} {
  set drin 0
  set tlist [lindex $prod_b2 3]
  set schrl [lindex $prod_b2 4]
  set schrr [lindex $prod_b2 5]
  foreach teil $tlist {
    set kord [$canv coord $teil]
    set k1 [lindex $kord 0]
    set k2 [lindex $kord 2]
    set kmin [minimum $k1 $k2]
    set kmax [maximum $k1 $k2]

    if { ($kmax >= $schrl) && ($kmin <= $schrr) } {
	set drin 1
	break
        }
    }
  
  if {!$drin } {
        set prod_b2 [lreplace $prod_b2 6 6 0]
	$canv itemconfigure blt2led_tg -fill $color_b2_led_aus
	}
    
 }

#Lichtschranke auf unterbrochen schalten ??
if {![lindex $prod_b2 6]} {
  set tlist [lindex $prod_b2 3]
  set schrr [lindex $prod_b2 5]
  foreach teil $tlist {
    set kord [$canv coord $teil]
    set k1 [lindex $kord 0]
    set k2 [lindex $kord 2]
    set kmin [minimum $k1 $k2]
    set kmax [maximum $k1 $k2]
    if {( $kmin <= $schrr) && ($kmax > $schrr)} {
        set prod_b2 [lreplace $prod_b2 6 6 1]
	$canv itemconfigure blt2led_tg -fill $color_b2_led_an
	break
	}
    }
 }


#End PROC
}


#**************************
# proc update_belt1 {}
# bewegt das Band2 in Canvas "canv" nach rechts
#**************************
proc update_belt1 {} {
global prod_b1 canv
global color_b1_led_an color_b1_led_aus
global belt1_speed


set marks [lindex $prod_b1 3]
set gelaufen [lindex $prod_b1 1]

if {$gelaufen <= [lindex $prod_b1 2]} {
  foreach i $marks {
   $canv addtag blt1_tg withtag $i
   }
  $canv move blt1_tg $belt1_speed 0
  set prod_b1 [lreplace $prod_b1 1 1 [expr $gelaufen+$belt1_speed]]
 } else { 
  foreach i $marks {
   $canv dtag $i blt1_tg
   $canv move $i $belt1_speed 0
   }
  $canv move blt1_tg -$gelaufen 0
  set prod_b1 [lreplace $prod_b1 1 1 [expr $gelaufen-[lindex $prod_b1 1]]]
   }

#Lichtschranke auf leer schalten ??
if {[lindex $prod_b1 6]} {
  set drin 0
  set tlist [lindex $prod_b1 3]
  set schrl [lindex $prod_b1 4]
  foreach teil $tlist {
    set kord [$canv coord $teil]
    set k1 [lindex $kord 0]
    set k2 [lindex $kord 2]
    set kmax [maximum $k1 $k2]

    if {$kmax >= $schrl} {
	set drin 1
	break
        }
    }
  
  if {!$drin } {
        set prod_b1 [lreplace $prod_b1 6 6 0]
	$canv itemconfigure blt1led_tg -fill $color_b1_led_aus
	}
    
 }

#Lichtschranke auf unterbrochen schalten ??
if {![lindex $prod_b1 6]} {
  set tlist [lindex $prod_b1 3]
  set schrl [lindex $prod_b1 4]
  foreach teil $tlist {
    set kord [$canv coord $teil]
    set k1 [lindex $kord 0]
    set k2 [lindex $kord 2]
    set kmax [maximum $k1 $k2]
    if {$kmax >= $schrl} {
        set prod_b1 [lreplace $prod_b1 6 6 1]
	$canv itemconfigure blt1led_tg -fill $color_b1_led_an
	break
	}
    }
 }

 
}

#*******************************
# proc update_table {}
# dreht den Hub- Dreh- Tisch 
# um den Punkt (umx,umy)
# um einen festen Winkel weiter
#*******************************
proc update_table {umx umy} {
global canv 
global prod_tb move_tb prod_a1
global winkelt cost sint
global table_height_speed

#ist Drehung noetig ?? 
if { [lindex $prod_tb 0]} {

#Initialisierung Tisch
set posx1_tab [lindex $prod_tb 4]
set posy1_tab [lindex $prod_tb 5]
set posx2_tab [lindex $prod_tb 6]
set posy2_tab [lindex $prod_tb 7]

#Init Teil
set stat_t2 [lindex $prod_tb 8]
foreach i $stat_t2 {
 set poslist [$canv coord $i]
 set posx1($i) [lindex $poslist 0]
 set posy1($i) [lindex $poslist 1]
 set posx2($i) [lindex $poslist 2]
 set posy2($i) [lindex $poslist 3]
}

#Berechnung

#Transformieren
set posx2_tab [expr $posx2_tab-$umx]
set posy2_tab [expr $posy2_tab-$umy]
set posx1_tab [expr $posx1_tab-$umx]
set posy1_tab [expr $posy1_tab-$umy]

#Trans Teile
foreach i $stat_t2 {
 set posx2($i) [expr $posx2($i)-$umx]
 set posy2($i) [expr $posy2($i)-$umy]
 set posx1($i) [expr $posx1($i)-$umx]
 set posy1($i) [expr $posy1($i)-$umy]
}

#Drehen
if {[lindex $prod_tb 0] == 1} {
  set posx2_tab_neu [expr $cost*$posx2_tab+$sint*$posy2_tab]
  set posy2_tab_neu [expr -$sint*$posx2_tab+$cost*$posy2_tab]
  set posx1_tab_neu [expr $cost*$posx1_tab+$sint*$posy1_tab]
  set posy1_tab_neu [expr -$sint*$posx1_tab+$cost*$posy1_tab]
  set gedreht [expr [lindex $prod_tb 2]-$winkelt]
  set prod_tb [lreplace $prod_tb 2 2 $gedreht]
  #Teil mitdrehen
  foreach i $stat_t2 {
   set posx2_neu($i) [expr $cost*$posx2($i)+$sint*$posy2($i)]
   set posy2_neu($i) [expr -$sint*$posx2($i)+$cost*$posy2($i)]
   set posx1_neu($i) [expr $cost*$posx1($i)+$sint*$posy1($i)]
   set posy1_neu($i) [expr -$sint*$posx1($i)+$cost*$posy1($i)]
   }
  if {$gedreht < 0 } {
	# "Hubdrehtisch - Kollision mit Band1"
	report_message 2
	set prod_tb [lreplace $prod_tb 0 1 0 0]
	set move_tb 0
   }
} else {
if {[lindex $prod_tb 0] == 2} {
 set posx2_tab_neu [expr $cost*$posx2_tab-$sint*$posy2_tab]
 set posy2_tab_neu [expr $sint*$posx2_tab+$cost*$posy2_tab]
 set posx1_tab_neu [expr $cost*$posx1_tab-$sint*$posy1_tab]
 set posy1_tab_neu [expr $sint*$posx1_tab+$cost*$posy1_tab]
 set gedreht [expr [lindex $prod_tb 2]+$winkelt]
 set prod_tb [lreplace $prod_tb 2 2 $gedreht]
#Teil mitderehen
 foreach i $stat_t2 {
  set posx2_neu($i) [expr $cost*$posx2($i)-$sint*$posy2($i)]
  set posy2_neu($i) [expr $sint*$posx2($i)+$cost*$posy2($i)]
  set posx1_neu($i) [expr $cost*$posx1($i)-$sint*$posy1($i)]
  set posy1_neu($i) [expr $sint*$posx1($i)+$cost*$posy1($i)]
  }
  if {$gedreht >= 90 } {
	# "Hubdrehtisch - Anschlag"
	report_message 3
	set prod_tb [lreplace $prod_tb 0 1 0 0]
	set move_tb 0
   }
 } 

} 


#Zuruecktransformieren
set posx2_tab_neu [expr $posx2_tab_neu+$umx]
set posy2_tab_neu [expr $posy2_tab_neu+$umy]
set posx1_tab_neu [expr $posx1_tab_neu+$umx]
set posy1_tab_neu [expr $posy1_tab_neu+$umy]

#ZrTransf Teil
foreach i $stat_t2 {
 set posx2_neu($i) [expr $posx2_neu($i)+$umx]
 set posy2_neu($i) [expr $posy2_neu($i)+$umy]
 set posx1_neu($i) [expr $posx1_neu($i)+$umx]
 set posy1_neu($i) [expr $posy1_neu($i)+$umy]
} 

#Darstellen
$canv coord tab_tg $posx1_tab_neu $posy1_tab_neu $posx2_tab_neu $posy2_tab_neu
set prod_tb [lreplace $prod_tb 4 7 $posx1_tab_neu $posy1_tab_neu \
				   $posx2_tab_neu $posy2_tab_neu]

foreach i $stat_t2 {
   $canv coord $i $posx1_neu($i) $posy1_neu($i) $posx2_neu($i) $posy2_neu($i)
  }

}
#Drehung abgeschlossen


#=============================
#Ist Heben oder Senken noetig ??
#=============================

if { [lindex $prod_tb 1] } {
#Die Schrittweite beim Heben/Senken des Tisches ist in der Variablen tb_hschritte


  set hoch [lindex $prod_tb 3] 
  if {([lindex $prod_tb 1] == 2) && ($hoch > 0) } {
  #Hochbewegung
   $canv move tabhgt_tg 0 -$table_height_speed
   set hoch [expr $hoch-$table_height_speed]
  } else {  

    if {([lindex $prod_tb 1] == 1) && ($hoch < [lindex $prod_tb 9])} {
    #Tiefbewegung
    $canv move tabhgt_tg 0 $table_height_speed
    set hoch [expr $hoch+$table_height_speed]
    } else {
	set prod_tb [lreplace $prod_tb 1 1 0]
	if {![lindex $prod_tb 0]} { set move_tb 0}
     }
  }
  set prod_tb [lreplace $prod_tb 3 3 $hoch]
  }

#======================
# Kollisionserkennung, sind Teile auf dem
# Tisch mit dem Teil am Roboterarm kollidiert ?
#======================

#die Variable toleranz enthaelt die Hoehe bei der die Teile 
#immer noch kollidieren, ist also die hoehe eines Teiles

set toleranz 4
set hoch [lindex $prod_tb 3]

 if { ($hoch <= $toleranz) && ([set robotblank [lindex $prod_a1 10]] != "") }\
   then {
#   echo bin beim testen
   foreach blank [lindex $prod_tb 8] {
     if { [blanks_intersect $blank $robotblank]} {

       # Teile sind kollidiert 
       report_message 16
       set prod_tb [lreplace $prod_tb 0 1 0 0]
       set move_tb 0
     }
   }
 }

#END proc
}


################
#
#proc update_press {}
#bewegt die Hoehenanzeige der Presse
#
#################
proc update_press {} {
global prod_pr prod_a2 prod_a1
global canv
global color_press color_press_zu
global press_speed


set hoch [lindex $prod_pr 1]
set hoch_a2_u [lindex $prod_pr 4]
set hoch_a2_o [lindex $prod_pr 5]
set hoch_a1   [lindex $prod_pr 6]

if { ([lindex $prod_pr 0] == 2) && ($hoch > 0)} {
 #Bewegung nach oben
 ###################

  set hoch [expr $hoch-$press_speed]
  $canv move prshgt_tg 0 -$press_speed

  #Befindet sich die Presse in der Hoehe des zweiten Armes ??
  if { ( $hoch < $hoch_a2_u ) && ($hoch > $hoch_a2_o) } {

	#Befindet sich der Arm 2 im Bereich der Presse ??
	set rect  [$canv coords prs_tg]
	set items [eval $canv find overlapping $rect]
	set arm2_item [$canv find withtag arm2_tg]
	if { [lsearch $items $arm2_item] != -1 } {
	  # "Presse - Kollision mit Arm 2 "
    	  report_message 9
	  set move_pr 0
	  set prod_pr [lreplace $prod_pr 0 0 0]	
	 }
     } 
   #Befindet sich die Presse in der Hoehe des ersten Armes ??
   if { $hoch < $hoch_a1 } {

	#Befindet sich der Arm 1 im Bereich der Presse ??
	set rect  [$canv coords prs_tg]
	set items [eval $canv find overlapping $rect]
	set arm1_item [$canv find withtag arm1_tg]
	if { [lsearch $items $arm1_item] != -1 } {
	# "Presse - Kollision mit Arm 1"
    	report_message 7
	set move_pr 0
	set prod_pr [lreplace $prod_pr 0 0 0]
	}
      }
        
  #Wenn noetig Presse ueber den zweiten Arm zeichnen
  if {($hoch <= $hoch_a2_o) && ( $hoch+$press_speed >= $hoch_a2_o)} {
	$canv lower [lindex $prod_a2 10] prs_tg
	$canv lower arm2_tg prs_tg 
	}

  if {$hoch <= 0} {$canv itemconfigure prs_tg -fill $color_press_zu}



 } else {

  if { ([lindex $prod_pr 0] == 1) && ($hoch < [lindex $prod_pr 3])} {
    #Bewegung nach unten
    ####################

    if {$hoch <= 0} {$canv itemconfigure prs_tg -fill $color_press}
    set hoch [expr $hoch+$press_speed]
    $canv move prshgt_tg 0 $press_speed

    #Kollisionsabfrage mit Arm 2
    if { ( $hoch > $hoch_a2_o ) && ( $hoch < $hoch_a2_u )} {

	#Befindet sich der Arm 2 im Bereich der Presse ??
	set rect  [$canv coords prs_tg]
	set items [eval $canv find overlapping $rect]
	set arm2_item [$canv find withtag arm2_tg]
	if { [lsearch $items $arm2_item] != -1 } {

	  # "Presse - Kollision mit Arm 2 "
    	  report_message 9
	  set move_pr 0
	  set prod_pr [lreplace $prod_pr 0 0 0]	
	 }

	} else {
	    #Wenn noetig Presse unter den zweiten Arm zeichnen
	    if {($hoch >= $hoch_a2_u ) && ($hoch-$press_speed <= $hoch_a2_u)} {
		$canv lower arm2_tg arm1_tg
		if {[lindex $prod_a2 10] != ""} {
		   $canv lower [lindex $prod_a2 10] arm1_tg}
		}
	}

   } else {
	set move_pr 0 
	set prod_pr [lreplace $prod_pr 0 0 0]
        }
  }


set prod_pr [lreplace $prod_pr 1 1 $hoch]
}


################
#
#proc update_crane
#
#Aktualisiert das Handhabungsgeraet
#
#######
proc update_crane {} {
global prod_cr move_cr
global canv
global color_hg_led_an color_hg_led_aus
global crane_horizontal_speed crane_vertical_speed


#Die Grenzen in y-Richtung der beiden Baender
set b2g 35
set b2gg 105
set b1g 250
set b1gg 320


$canv addtag crn_tg withtag [lindex $prod_cr 16 ]

set flag [lindex $prod_cr 0]
set pos [lindex $prod_cr 2]
set anschlag_oben [lindex $prod_cr 17]
set anschlag_unten [lindex $prod_cr 18]
if {$flag == 1} {
#Bewegung nach oben  
 if {$pos > $anschlag_oben} {

   $canv move crn_tg 0 -$crane_horizontal_speed
   set pos [expr $pos-$crane_horizontal_speed]

   #Befindet sich der Greifer im Bereich der Lichtschranke ueber Band 2 ??
   if {($pos >= [lindex $prod_cr 19]) && ($pos <= [lindex $prod_cr 20])} {
		$canv itemconfigure crnled1_tg -fill $color_hg_led_an } else {
			$canv itemconfigure crnled1_tg -fill $color_hg_led_aus }
   #Befindet sich der Greifer im Bereich der Lichtschranke ueber Band 1 ??
   if {($pos >= [lindex $prod_cr 21]) && ($pos <= [lindex $prod_cr 22])} {
		$canv itemconfigure crnled2_tg -fill $color_hg_led_an } else {
			$canv itemconfigure crnled2_tg -fill $color_hg_led_aus }

   set prod_cr [lreplace $prod_cr 2 2 $pos]
   set prod_cr [lreplace $prod_cr 9 9 $pos]
   set prod_cr [lreplace $prod_cr 11 11 $pos]

   # Schwenkt der Greifer in den Bereich ueber Band 2 ??
   if {($pos <= $b2gg) && ($pos >= $b2g)} {
     if {[lindex $prod_cr 6] < [lindex $prod_cr 4]} {
      # "Handhabungsgeraet - Kollision mit Band 2"
      report_message  11
      set prod_cr [lreplace $prod_cr 0 1 0 0]
      set move_cr 0
     }
   } else {
    # Schwenkt der Greifer in den Bereich ueber Band 1 ??
    if {($pos <= $b1gg) && ($pos >= $b1g)} {
      if {[lindex $prod_cr 7] < [lindex $prod_cr 4]} {
       # "Handhabungsgeraet - Kollision mit Band 1 "
       report_message 12
       set prod_cr [lreplace $prod_cr 0 1 0 0]
       set move_cr 0
      }
    }
   }

   if {$pos <= $anschlag_oben}  {
		# "Handhabungsgeraet - Anschlag am oberen Rand"
		report_message 15 }
   } else {
 set prod_cr [lreplace $prod_cr 0 0 0]
 if {![lindex $prod_cr 1]} {set move_cr 0}
 }
} else {

#Bewegung nach unten
if {$flag == 2} {
  if {$pos < $anschlag_unten} {

   $canv move crn_tg 0 $crane_horizontal_speed
   set pos [expr $pos+$crane_horizontal_speed]

   #Befindet sich der Greifer im Bereich der Lichtschranke ueber Band 2 ??
   if {($pos >= [lindex $prod_cr 19]) && ($pos <= [lindex $prod_cr 20])} {
		$canv itemconfigure crnled1_tg -fill $color_hg_led_an } else {
			$canv itemconfigure crnled1_tg -fill $color_hg_led_aus }

   #Befindet sich der Greifer im Bereich der Lichtschranke ueber Band 1 ??
   if {($pos >= [lindex $prod_cr 21]) && ($pos <= [lindex $prod_cr 22])} {
		$canv itemconfigure crnled2_tg -fill $color_hg_led_an } else {
			$canv itemconfigure crnled2_tg -fill $color_hg_led_aus }

   set prod_cr [lreplace $prod_cr 2 2 $pos]
   set prod_cr [lreplace $prod_cr 9 9 $pos]
   set prod_cr [lreplace $prod_cr 11 11 $pos]

    # Schwenkt der Greifer in den Bereich ueber Band 1 ??
   if {($pos <= $b1gg) && ($pos >= $b1g)} {
     if {[lindex $prod_cr 7] < [lindex $prod_cr 4]} {
      # "Handhabungsgeraet - Kollision mit Band 1"
      report_message 12
      set prod_cr [lreplace $prod_cr 0 1 0 0]
      set move_cr 0
     }
   }

   if {$pos >= $anschlag_unten} {
		# "Handhabungsgeraet - Anschlag am unteren Rand"
		report_message 14 }
   } else {
  set prod_cr [lreplace $prod_cr 0 0 0]
  if {![lindex $prod_cr 1]} {set move_cr 0}
  }
 }
}

########
# Die Hoehenanzeige des Handhabungsgeraets aktualisieren
########
set hoch [lindex $prod_cr 4]
set maxim [lindex $prod_cr 5]
if { ([lindex $prod_cr 1] == 2) && ($hoch > 1)} {
  #Bewegung nach oben

  set hoch [expr $hoch-$crane_vertical_speed]
  set koord1 [lindex $prod_cr 12]
  set koord2 [lindex $prod_cr 13]
  set koord3 [lindex $prod_cr 15]
  set koord3 [expr $koord3-$crane_vertical_speed]
  $canv coord crnhgt_tg $koord1 $koord2 $koord1 $koord3
  set prod_cr [lreplace $prod_cr 15 15 $koord3]
 } else {
  if { ([lindex $prod_cr 1] == 1) && ($hoch < $maxim)} {
    #Bewegung nach unten

    set hoch [expr $hoch+$crane_vertical_speed]
    set koord1 [lindex $prod_cr 12]
    set koord2 [lindex $prod_cr 13]
    set koord3 [lindex $prod_cr 15]
    set koord3 [expr $koord3+$crane_vertical_speed]
    $canv coord crnhgt_tg $koord1 $koord2 $koord1 $koord3
    set prod_cr [lreplace $prod_cr 15 15 $koord3]

    #Abfrage auf Kollisionen mit :
    #Band 2
    if {($pos <= $b2gg) && ($pos >= $b2g)} {
      if {[lindex $prod_cr 6] < [lindex $prod_cr 4]} {
       # "Handhabungsgeraet - Kollision mit Band 2"
       report_message 11
       set prod_cr [lreplace $prod_cr 0 1 0 0]
       set move_cr 0
      }
    } else {
     #Band 1
     if {($pos <= $b1gg) && ($pos >= $b1g)} {
       if {[lindex $prod_cr 7] < [lindex $prod_cr 4]} {
	# "Handhabungsgeraet - Kollision mit Band 1"
        report_message 12
        set prod_cr [lreplace $prod_cr 0 1 0 0]
        set move_cr 0
       }
     }
    }


   } else {
	if {![lindex $prod_cr 0] } {set move_cr 0 }
	set prod_cr [lreplace $prod_cr 1 1 0]
        }
  }


set prod_cr [lreplace $prod_cr 4 4 $hoch]
}


###############
#proc manage_blanks
#
#verwaltet die Teile 
#
##############
proc manage_blanks {} {
global canv 
global loc_blanks add_blank max_blanks
global prod_a2 prod_a1 prod_b2 prod_b1 prod_tb prod_pr prod_cr
global color_teil color_teil_angehoben color_teil_error

#Laenge eines Teiles
global blank_length 

#die x-Grenze ab der ein Teil von Band 1 runter ist
set px1 355
#die x-Grenze ab der ein Teil von Band 2 runter ist
set px2 50
#Toleranz bei der Hoehe
set toleranz 3

for {set i 0} {$i < $max_blanks} {incr i} {
  set posit [lindex $loc_blanks $i]
  if {$posit} {
    case $posit in {
	    {1} {
		#Band 1
		set mark blank[expr $i]_tg
		set posx [minimum [lindex [$canv coord  $mark ] 0] \
			         [lindex [$canv coord  $mark ] 2]]
		if {$posx > $px1} {
			if {([lindex $prod_tb 2] <= 15) &&
				 ([lindex $prod_tb 3] >= [lindex $prod_tb 10])} {

			set stat_t1 [lindex $prod_b1 3]
			set ind [lsearch $stat_t1 $mark]
			set stat_t1 [lreplace $stat_t1 $ind $ind]
			set prod_b1 [lreplace $prod_b1 3 3 $stat_t1]
			set stat_tb [lindex $prod_tb 8]
			lappend stat_tb $mark
			set prod_tb [lreplace $prod_tb 8 8 $stat_tb]
			set loc_blanks [lreplace $loc_blanks $i $i 2]
			$canv dtag $mark blt1_tg
			} else {
			    #Fehlerhafte Ablage
			    set loc_blanks [lreplace $loc_blanks $i $i -1]
			    set stat_t1 [lindex $prod_b1 3]
			    set ind [lsearch $stat_t1 $mark]
			    set stat_t1 [lreplace $stat_t1 $ind $ind]
			    set prod_b1 [lreplace $prod_b1 3 3 $stat_t1]
		   	    lappend stat_err $mark
			    #  "Hubdrehtisch - Teil heruntergefallen"
			    report_message 1
			    $canv dtag $mark blt1_tg
			    $canv itemconfigure $mark -fill $color_teil_error			  
			    $canv coord $mark 363 287 416 332}
		} else {
		 if {([lindex $prod_cr 3]) && ($posx < 200) \
					&& ([lindex $prod_cr 16 ] == {})} {
			set hoch [lindex $prod_cr 4]
			set hoch_b1 [lindex $prod_cr 7]
			set toler [expr $hoch_b1-$toleranz]

			if { ($hoch <= $hoch_b1) && ($hoch >= $toler) } {
			set tind1 [$canv find withtag $mark]
			set spnktx [expr [lindex $prod_cr 8]+10]
			set spnktx2 [expr [lindex $prod_cr 10]-10]
			set spnkty [expr [lindex $prod_cr 9]-5]
			set spnkty2 [expr [lindex $prod_cr 9]+5]
			set lind  [$canv find overlapping $spnktx $spnkty $spnktx2 $spnkty2]
			if {[lsearch $lind $tind1] != -1} {
			#Aufnahme auf Handhabungsgeraet
			  set loc_blanks [lreplace $loc_blanks $i $i 7]
			  set prod_cr  [lreplace $prod_cr 16 16 $mark]
			  set stat_b1 [lindex $prod_b1 3]
			  set ind [lsearch $stat_b1 $mark]
			  set stat_b1 [lreplace $stat_b1 $ind $ind ]
			  set prod_b1 [lreplace $prod_b1 3 3 $stat_b1]
			  $canv itemconfigure $mark -fill $color_teil_angehoben
			  $canv dtag $mark blt1_tg
			}
		       }
		    } 
		  }
		}	           
            {2} {
		#Hub- Drehtisch
		if {[lindex $prod_a1 2] && ([lindex $prod_a1 10] == "") && \
					([lindex $prod_tb 3] <= $toleranz) } {
			set mark blank[expr $i]_tg
			set tind [$canv find withtag $mark]
			set spnktx [lindex $prod_a1 8]
			set spnkty [lindex $prod_a1 9]
			set lind [$canv find overlapping $spnktx $spnkty $spnktx $spnkty]
			if {[lsearch $lind $tind] != -1} {
			  #Aufnahme auf Arm 1
			  set loc_blanks [lreplace $loc_blanks $i $i 3]
			  set stat_tb [lindex $prod_tb 8]
			  set ind [lsearch $stat_tb $mark]
			  set stat_tb [lreplace $stat_tb $ind $ind]
			  set prod_tb [lreplace $prod_tb 8 8 $stat_tb]
			  set stat_t3 [lindex $prod_a1 10]			  	
			  lappend stat_t3 $mark
			  set prod_a1 [lreplace $prod_a1 10 10 $stat_t3]
			  $canv itemconfigure $mark -fill $color_teil_angehoben
			  #Teil ueber alle anderen Teile zeichnen
			  $canv raise $mark allblnks_tg
			  }
		       }
		}
	    {3} {
		#Arm 1
		if {![lindex $prod_a1 2] } {
		       	set mark blank[expr $i]_tg
			set tind1 [$canv find withtag tab_tg]
			set spnktx [lindex $prod_a1 8]
			set spnkty [lindex $prod_a1 9]
			set lind  [$canv find overlapping $spnktx $spnkty $spnktx $spnkty]
			if {[lsearch $lind $tind1] != -1} {

			#Ablage auf den Tisch
			  set loc_blanks [lreplace $loc_blanks $i $i 2]
			  set prod_a1 [lreplace $prod_a1 10 10 {}]
			  set stat_tb [lindex $prod_tb 8]
			  lappend stat_tb $mark
			  set prod_tb [lreplace $prod_tb 8 8 $stat_tb]
			  $canv itemconfigure $mark -fill $color_teil
			} else {
			set tind2 [$canv find withtag prs_tg]
			if {[lsearch $lind $tind2] != -1} {

			#Ablage in die Presse
			  set loc_blanks [lreplace $loc_blanks $i $i 4]
			  set prod_a1 [lreplace $prod_a1 10 10 {}]
			  set stat_pr [lindex $prod_pr 2]
			  lappend stat_pr $mark
			  set prod_pr [lreplace $prod_pr 2 2 $stat_pr]
			  $canv itemconfigure $mark -fill $color_teil
			} else {

			    #Fehlerhafte Ablage
			    set loc_blanks [lreplace $loc_blanks $i $i -1]
			    set prod_a1 [lreplace $prod_a1 10 10 {}]
		   	    lappend stat_err $mark
			    # "Arm 1 - Teil ungueltig abgelegt"
			    report_message 6
			    $canv itemconfigure $mark -fill $color_teil_error
			     }
			    }
			 }
		  }
		
	    {4} {
		#Presse
		if {[lindex $prod_a2 2] && ([lindex $prod_a2 10] == "")} {
			set mark blank[expr $i]_tg
			set tind [$canv find withtag $mark]
			set spnktx [lindex $prod_a2 8]
			set spnkty [lindex $prod_a2 9]		   
			set lind [$canv find overlapping $spnktx $spnkty $spnktx $spnkty]
			if {[lsearch $lind $tind] != -1} {
			#Uebernahme auf Arm 1
			  set loc_blanks [lreplace $loc_blanks $i $i 5]
			  set stat_pr [lindex $prod_pr 2]
			  set ind [lsearch $stat_pr $mark]
			  set stat_pr [lreplace $stat_pr $ind $ind]
			  set prod_pr [lreplace $prod_pr 2 2 $stat_pr]
			  set stat_a2 [lindex $prod_a2 10]			  	
			  lappend stat_a2 $mark
			  set prod_a2 [lreplace $prod_a2 10 10 $stat_a2]
			  $canv itemconfigure $mark -fill $color_teil_angehoben

			  #Teil ueber alle anderen Teile zeichnen
			  $canv raise $mark allblnks_tg
			 }
		     } else {
		       if {[lindex $prod_a1 2] && ([lindex $prod_a1 10] == "")} {
			  set mark blank[expr $i]_tg
			  set tind [$canv find withtag $mark]
			  set spnktx [lindex $prod_a1 8]
			  set spnkty [lindex $prod_a1 9]		   
			  set lind [$canv find overlapping $spnktx $spnkty $spnktx $spnkty]
			  if {[lsearch $lind $tind] != -1} {
			  #Uebernahme auf Arm 2
			    set loc_blanks [lreplace $loc_blanks $i $i 3]
			    set stat_pr [lindex $prod_pr 2]
			    set ind [lsearch $stat_pr $mark]
			    set stat_pr [lreplace $stat_pr $ind $ind]
			    set prod_pr [lreplace $prod_pr 2 2 $stat_pr]
			    set stat_a1 [lindex $prod_a1 10]			  	
			    lappend stat_a1 $mark
			    set prod_a1 [lreplace $prod_a1 10 10 $stat_a1]
			    $canv itemconfigure $mark -fill $color_teil_angehoben

			    #Teil ueber alle anderen Teile zeichnen
			    $canv raise $mark allblnks_tg
			   }
			 }
		  }
		}
	    {5} {
		#Arm 2
		if {![lindex $prod_a2 2] } {
		       	set mark blank[expr $i]_tg
			set tind1 [$canv find withtag blt2pad_tg]
			set tind2 [$canv find withtag prs_tg]
			set spnktx [lindex $prod_a2 8]
			set spnkty [lindex $prod_a2 9]
			set lind  [$canv find overlapping $spnktx $spnkty $spnktx $spnkty]
			if {[lsearch $lind $tind1] != -1} {
			#Ablage auf das Band
			  set loc_blanks [lreplace $loc_blanks $i $i 6]
			  set prod_a2 [lreplace $prod_a2 10 10 {}]
			  set stat_b2 [lindex $prod_b2 3]
			  lappend stat_b2 $mark
			  set prod_b2 [lreplace $prod_b2 3 3 $stat_b2]
			  set xrand [lindex [$canv coord blt2pad_tg] 1]
			  set xrand [expr $xrand+0.5*[lindex [$canv itemconfigure $mark -width] 4]]
			  set koordt [$canv coord $mark]
			  set kx1 [lindex $koordt 0]
			  set ky1 [lindex $koordt 1]
			  set kx2 [lindex $koordt 2]
			  set ky2 [lindex $koordt 3]
			  set ky1 $xrand
			  set kx1 [minimum $kx1 $kx2]
			  set kx2 [expr $kx1+$blank_length]
			  $canv coord $mark $kx1 $ky1 $kx2 $ky1
			  $canv itemconfigure $mark -fill $color_teil
			} else {
			if {([lsearch $lind $tind2] != -1) &&\
				 ([lindex $prod_pr 1] >= [lindex $prod_pr 4]) } {
			#Ablage in die Presse
			  set loc_blanks [lreplace $loc_blanks $i $i 4]
			  set prod_a2 [lreplace $prod_a2 10 10 {}]
			  set stat_pr [lindex $prod_pr 2]
			  lappend stat_pr $mark
			  set prod_pr [lreplace $prod_pr 2 2 $stat_pr]
			  $canv itemconfigure $mark -fill $color_teil
			  } else {
			    #Fehlerhafte Ablage
			    set loc_blanks [lreplace $loc_blanks $i $i -1]
			    set prod_a2 [lreplace $prod_a2 10 10 {}]
		   	    lappend stat_err $mark
			    # "Arm 2 - Teil ungueltig abgelegt"
			    report_message 8
			    $canv itemconfigure $mark -fill $color_teil_error
			     }
			 }
		    }		 
		}
	    {6} {
		#Band2
		set mark blank[expr $i]_tg
		set posx [maximum [lindex [$canv coord $mark] 0] \
			         [lindex [$canv coord $mark] 2]]
		if {$posx < $px2} {

			set loc_blanks [lreplace $loc_blanks $i $i -1]
			set stat_b2 [lindex $prod_b2 3 ]
			set tind    [lsearch $stat_b2 $mark]
			set stat_b2 [lreplace $stat_b2 $tind $tind]
			set prod_b2 [lreplace $prod_b2 3 3 $stat_b2]

			$canv itemconfigure $mark -fill $color_teil_error
			# "Band 2 - Teil runtergefallen"
			report_message 10
			$canv dtag $mark blt2_tg
		} else {
		if {([lindex $prod_cr 3]) && ($posx < 200) \
				&& ([lindex $prod_cr 16 ] == {}) } {
			set hoch [lindex $prod_cr 4]
			set hoch_b2 [lindex $prod_cr 6]
			set toler [expr $hoch_b2-$toleranz]

			if { ($hoch <= $hoch_b2) && ($hoch >= $toler) } {
			set tind1 [$canv find withtag $mark]
			set spnktx [expr [lindex $prod_cr 8]+10]
			set spnktx2 [expr [lindex $prod_cr 10]-10]
			set spnkty [expr [lindex $prod_cr 9]-5]
			set spnkty2 [expr [lindex $prod_cr 9]+5]
			set lind  [$canv find overlapping $spnktx $spnkty $spnktx2 $spnkty2]
			if {[lsearch $lind $tind1] != -1} {
			#Aufnahme auf Handhabungsgeraet
			  set loc_blanks [lreplace $loc_blanks $i $i 7]
			  set prod_cr  [lreplace $prod_cr 16 16 $mark]
			  $canv raise $mark allblnks_tg
			  set stat_b2 [lindex $prod_b2 3]
			  set ind [lsearch $stat_b2 $mark]
			  set stat_b2 [lreplace $stat_b2 $ind $ind ]
			  set prod_b2 [lreplace $prod_b2 3 3 $stat_b2]
			  $canv itemconfigure $mark -fill $color_teil_angehoben
			  $canv dtag $mark blt2_tg
			}
		       }
		    } 
		 }
		}
	    {7} {
		#Handhabungsgeraet
		if {(![lindex $prod_cr 3])} {
			set mark blank[expr $i]_tg
		        #Bestimme den Index der Flaeche von Band 1
			set tind1 [$canv find withtag blt2pad_tg]
		        #Bestimme den Index der Flaeche von Band 2
			set tind2 [$canv find withtag blt1pad_tg]
		        #Bestimme die Koordinaten des Mittelpunkts des Magnets
			set spnktx [expr 0.5*([lindex $prod_cr 8]+[lindex $prod_cr 10])]
			set spnkty [lindex $prod_cr 9]
		        #Bestimme die Items, die sich unter dem Magnet befinden
			set lind  [$canv find overlapping $spnktx $spnkty $spnktx $spnkty]

			if {[lsearch $lind $tind1] != -1} {
			#Ablage auf Band2
			 set hoch [lindex $prod_cr 4]
			 set hoch_b2 [lindex $prod_cr 6]

			 if { ($hoch <= $hoch_b2) } {
			   set loc_blanks [lreplace $loc_blanks $i $i 6]
			   set prod_cr  [lreplace $prod_cr 16 16 {}]
			   set stat_b2 [lindex $prod_b2 3]
			   lappend stat_b2 $mark
			   set prod_b2 [lreplace $prod_b2 3 3 $stat_b2]
			   $canv itemconfigure $mark -fill $color_teil
			   $canv dtag $mark crn_tg
			   }
			 } else {
			
			if {[lsearch $lind $tind2] != -1} {
			#Ablage auf Band1
			   set loc_blanks [lreplace $loc_blanks $i $i 1]
			   set prod_cr  [lreplace $prod_cr 16 16 {}]
			   set stat_b1 [lindex $prod_b1 3]
			   lappend stat_b1 $mark
			   set prod_b1 [lreplace $prod_b1 3 3 $stat_b1]
			   $canv itemconfigure $mark -fill $color_teil
			   $canv dtag $mark crn_tg

			 } else {
			 #fehlerhafte Ablage
			  set loc_blanks [lreplace $loc_blanks $i $i -1]
			  set prod_cr [lreplace $prod_cr 16 16 {}]
			  $canv itemconfigure $mark -fill $color_teil_error
			  $canv dtag $mark crn_tg   	
			  # "Handhabungsgeraet - Teil wurde ungueltig abgelegt"
			  report_message 13
			 }
		        }
		 }
		}

#weitere Faelle

    }
  }
 }
}

############
#Fuegt wenn noetig ein Teil in der Szene dazu
############
proc put_blank {} {

global canv loc_blanks add_blank prod_b1
global max_blanks

    for {set i 0} {$i < $max_blanks} {incr i} {
        if {![lindex $loc_blanks $i]} {
		set loc_blanks [lreplace $loc_blanks $i $i 1]
		set stat_t1 [lindex $prod_b1 3]
		lappend stat_t1 blank[expr $i]_tg
		set prod_b1 [lreplace $prod_b1 3 3 $stat_t1] 
		$canv coord blank[expr $i]_tg 55 285 125 285
		break
		}
   }

 set add_blank 0
}

############
#proc return_dropped_blanks {}
#
#Sammelt alle heruntergefallene Teile auf
############
proc return_dropped_blanks {} {

global canv loc_blanks max_blanks blank_length
global color_teil

    for {set i 0} {$i < $max_blanks } {incr i} {
        if {[lindex $loc_blanks $i] == -1} {
		set teily1 365
		set teily2 [expr $teily1+$blank_length]
		set loc_blanks [lreplace $loc_blanks $i $i 0]
		set teilx [expr 20+($max_blanks-1-$i)*30]
		$canv coord blank[expr $i]_tg $teilx $teily1 $teilx $teily2
		$canv itemconfigure blank[expr $i]_tg -fill $color_teil 
		}
   }
}

#######
#proc report_message 
#
#gibt eine Meldung an den Benutzer aus
##########
proc report_message {nummer} {

global errorlist
#Die Fehlermeldungen sind in dem Array name_error gespeichert
global name_error name_message
global UnknownCommand


  if {$errorlist == 0} {set errorlist ""}

  if {$nummer == 17} {
   set message_text "$name_error($nummer) $UnknownCommand"
   } {
   set message_text $name_error($nummer)
   lappend errorlist $nummer
   }

  



.codlog configure -text "$name_message:       $message_text" -foreground red
after 7000 .codlog configure -text "$name_message: " -foreground black
}
########
#proc choose_angle_rob 
#
#bestimmmt den Winkel mit dem der Roboter gedreht wird
########
proc choose_angle_rob {winkel} {
global winkelr
global cosr sinr

set winkelr $winkel
case $winkel in {
		{1} {
		     set cosr 0.9998477
		     set sinr 0.017452406
		    }
		{2} {
		     set cosr 0.99939083
		     set sinr 0.034899497
		    }
		{3} {
		     set cosr 0.99862953
		     set sinr 0.052335956
		    }
		{4} {
		     set cosr 0.99756405
		     set sinr 0.069756474
		    }
		{5} {
		     set cosr 0.9961947
		     set sinr 0.087155743
		    }
	}
}
########
#proc choose_angle_tab {winkel}  
#
#bestimmmt den Winkel mit dem der Hubdrehtisch gedreht wird
########
proc choose_angle_tab {winkel} {
global winkelt
global cost sint

set winkelt $winkel
case $winkel in {
		{1} {
		     set cost 0.9998477
		     set sint 0.017452406
		    }
		{2} {
		     set cost 0.99939083
		     set sint 0.034899497
		    }
		{3} {
		     set cost 0.99862953
		     set sint 0.052335956
		    }
		{4} {
		     set cost 0.99756405
		     set sint 0.069756474
		    }
		{5} {
		     set cost 0.9961947
		     set sint 0.087155743
		    }
	}
}

#################
#proc demonstration 
#
#Fuehrt eine Demonstraition durch
#################
proc demonstration {} {
global prod_b1 prod_b2 prod_tb prod_a1 prod_a2
global prod_pr prod_cr
global canv

global lauf_demo 

if {$lauf_demo == 0} {
	blank_add
	belt1_start
	arm2_backward
	set lauf_demo 1
        return
	}

if {$lauf_demo == 1} {
  #Wenn Teil runter von Band 1
  if {[lindex $prod_tb 8] != ""} {
		belt1_stop
		table_right
		table_upward
		}
  #Wenn Arm 2 weit genug zurueckgeschoben
  if {[lindex $prod_a2 4 ] <= 128 } {
		robot_right
		}
  #Wenn Roboter weit genug nach rechts gedreht
  if {[lindex $prod_a1 3] >= 50} {
		robot_stop
		arm2_stop
		arm1_forward
		}
   #Wenn Tisch weit genug nach rechts gedreht
  if {[lindex $prod_tb 2] >= 50} {
		table_stop_h
		}
  #Wenn Arm 1 weit genug vorgeschoben
  if {[lindex $prod_a1 4] >=142} {
		arm1_stop
		arm1_mag_on
		}
  #Wenn Teil an Arm 1
  if {[lindex $prod_a1 10] != "" } {
		table_stop_v
		robot_left
		table_left
		table_downward
		set lauf_demo 2
		return
		}
}

if {$lauf_demo == 2 } {

  #Wenn Robot weit genug gedreht
  if { [lindex $prod_a1 3] <= -90} {
		robot_stop
		arm1_forward
                }
  #Wenn Tisch zurueckgedreht
  if { [lindex $prod_tb 2] <= 0} {
		table_stop_h
		}
  #Wenn Tisch runtergefahren
  if {[lindex $prod_tb 3] > [lindex $prod_tb 10]} {
		table_stop_v
		}
  #Wenn Arm 1 weit genug in der Presse ist
  if {[lindex $prod_a1 4] >= 155.5} {
		arm1_stop
		arm1_mag_off
		robot_right
		set lauf_demo 3
		return
		}
 }

if {$lauf_demo == 3} {
  #Wenn Tisch runtergefahren
  if {[lindex $prod_tb 3] > [lindex $prod_tb 10]} {
		table_stop_v
		}
  #Wenn Roboter aus der Presse
  if {[lindex $prod_a1 3] >= -65} {
		robot_stop
		press_upward
		set lauf_demo 4
		return
		}
 }

if {$lauf_demo == 4} {

  #Wenn Teil gepresst
  if {[lindex $prod_pr 1] <= 0} {
		after 1000
		press_downward
		robot_right
		}
  #Wenn Arm 2 vor der Presse steht
  if {[lindex $prod_a1 3] >= 35} {
		robot_stop
		set lauf_demo 5
		return
		}
}

if {$lauf_demo == 5} {

  #Wenn Presse weit genug unten
  if {[lindex $prod_pr 1] > [lindex $prod_pr 4]} {
		press_stop
		arm2_forward
		}
  #Wenn Arm 2 weit genug vorne
  if {[lindex $prod_a2 4] >= 147.25} {
		arm2_stop
		arm2_mag_on
		robot_left
		set lauf_demo 6
		return
		}
}

if {$lauf_demo == 6} {

  #Wenn Roboter genug gedreht 
  if { [lindex $prod_a1 3] <= -55} {
		robot_stop
		press_upward
		arm2_backward
		}
  #Wenn Presse hoch genug 
  if { [lindex $prod_pr 1] <= [expr [lindex $prod_pr 6]+3]} {
		press_stop
		} 
  #Wenn Arm 2 weit genug zurueckgefahren
  if { [lindex $prod_a2 4] <= 129.25} {
		arm2_stop
		arm2_mag_off
		belt2_start
		crane_to_belt2
		set lauf_demo 7
		return
		}
 }

if {$lauf_demo == 7} {

  #Wenn HHger weit genug oben
  if {[lindex $prod_cr 2] <= 58} {
		crane_stop_h
		}

  #Wenn Presse hoch genug 
  if { [lindex $prod_pr 1] <= [expr [lindex $prod_pr 6]+3]} {
		press_stop
		} 
  #Wenn Lichtschranke signalisiert
  if {[lindex $prod_b2 6]} {
		set lauf_demo 8
		return
		}
 }

if {$lauf_demo == 8} {

  #Wenn die Lichtschranke wieder freigibt
  if {![lindex $prod_b2 6]} {
		belt2_stop
		}
  #Wenn HHger weit genug oben
  if {[lindex $prod_cr 2] <= 58} {
		crane_stop_h
		crane_mag_on
		crane_lower
		robot_right
		arm1_backward
		set lauf_demo 9
		return
		}
 }

if {$lauf_demo == 9} {

  #Wenn Roboter wieder in Ausgansposiotion
  if {[lindex $prod_a1 3] >=0} {
		robot_stop
		}
  #Wenn Arm 1 weit genug zurueck
  if {[lindex $prod_a1 4] <= 127.5} {
		arm1_stop
		}
  #Wenn die Lichtschranke wieder freigibt
  if {![lindex $prod_b2 6]} {
		belt2_stop
		}
  #Wenn Teil an HHger
  if {[lindex $prod_cr 16] != ""} {
		crane_stop_v
		crane_to_belt1
		crane_lift
		set lauf_demo 10
		return
		}
}

if {$lauf_demo == 10} {

  #Wenn Roboter wieder in Ausgansposiotion
  if {[lindex $prod_a1 3] >=0} {
		robot_stop
		}
  #Wenn Arm 1 weit genug zurueck
  if {[lindex $prod_a1 4] <= 127.5} {
		arm1_stop
		}
  #Wenn HHger hoch genug
  if {[lindex $prod_cr 4] < [lindex $prod_cr 7]} {
		crane_stop_v
		}
  #Wenn HHger ueber Band 1
  if {[lindex $prod_cr 2] >= 286} {
		crane_stop_h
		crane_mag_off
		set kord [$canv coord [lindex $prod_cr 16]]
		set k1 [lindex $kord 0]
		set k2 [lindex $kord 2]
		$canv coord [lindex $prod_cr 16] $k1 285 $k2 285
		arm2_backward
		belt1_start
		set lauf_demo 1
		return
		}
		
 }

}
#################
#proc manage_guards
#
#Verwaltet die Waechter die zur Erreichung der 
#richtigen Posiotion der verschiedenen Produktionsabschnitte
#################

proc manage_guards {} {
global guardslist


set status [get_status_intern]
set zaehler 0
foreach element $guardslist {
 set nummer [expr [lindex $element 0]-1]
 set akt_wert [lindex $status $nummer]
 set operator [lindex $element 1]
 set vergleich [expr $akt_wert$operator[lindex $element 2]]

 if {$vergleich} {
	eval [lindex $element 3]
	set guardslist [lreplace $guardslist $zaehler $zaehler] 
	} 
incr zaehler
 }
}


######################################
# neu ab Version 9.1
#####################################



#Prozeduren fuer das Ziehen der Teile

###################
#
# proc item_start_drag {c x y}
#
# merkt sich die Canvas-Koordinaten  
# in dem Canvas c unter den Screen-Koordinaten (x,y) 
# in den globalen Variablen lastX lastY
###################

proc item_start_drag {c x y} {
    global lastX lastY
    global item_tag loc_blanks color_teil_angehoben

    #Defaulteinstellung fuer das Teil das gerade gewaehlt wird
    set item_tag ""


    set current_item_tag [lindex [lindex [$c itemconfigure current -tags ] 4] 0]

    #Wenn das Item unter dem Cursor ein Teil ist, 
    #kommt es in Betrach bewegt zu werden
    if { [string range $current_item_tag 0 4 ] == "blank" } {

	#Die Liste der Gueltigen Geraete, gibt an von welchem Geraet die
	#Teile abgehoben werden duerfen	
	set liste_gueltiger_geraete {-1 0 1 2 4 6 }
 	set blank_num [string range $current_item_tag 5 5]
	set blank_loc [lindex $loc_blanks $blank_num]

	#Wenn sich das aktuelle Teil in der auf einem gueltigen 
	#Geraet befindet, wird es mitbewegt
	if {[lsearch $liste_gueltiger_geraete $blank_loc] != -1} {

	   #Das Teil wird dem aktuellen Geraet entzogen
	   blank_remove_from_dev $blank_num $blank_loc

	   #Die Koordinaten von wo an gezogen wird, werden hier gespeichert
      	   set lastX [$c canvasx $x]
	   set lastY [$c canvasy $y]

	   #Das Teil wird umgefaerbt und als oberstes Teil gezeichnet
	   $c itemconfigure current -fill $color_teil_angehoben
#	   $c raise current allblnks_tg
          
	   #Die Variable item_tag, die in den Prozeduren item_release und
	   #item_drag benutzt wird, wird hier auf das aktuelle Teil gesetzt
	   set item_tag $current_item_tag
        }
   }

}

###################
#
# proc item_drag {c x y}
#
# zieht das Blank in dem Canvas c
# unter den Screenkoordinaten (x,y)
# mit dem Mauszeiger
#####################

proc item_drag {c x y} {
    global lastX lastY
    global item_tag

    if {$item_tag != "" } {
	   set x [$c canvasx $x]
	   set y [$c canvasy $y]
	   $c move $item_tag [expr $x-$lastX] [expr $y-$lastY]
	   set lastX $x
	   set lastY $y
    }      

}

###################
# proc blank_remove_from_dev { blank_number current_device}
# 
# loescht den Blank mit der Nummer blank_number
# von dem Gereat mit der Nummer current_device
###################


proc blank_remove_from_dev {blank_num current_device} {

 global canv loc_blanks
 global prod_a1 prod_a2 prod_b1 prod_b2 
 global prod_tb prod_cr prod_pr


  case $current_device in {

	{-1}  {
		set loc_blanks [lreplace $loc_blanks $blank_num $blank_num 0]
		return
	      }

	{0}   {
		#keine Aktion notwendig
		return
              }

	{1}   {#Von Band 1 loeschen
		set teile [lindex $prod_b1 3]
		set ind [lsearch $teile blank${blank_num}_tg]
		set teile [lreplace $teile $ind $ind]
		set prod_b1 [lreplace $prod_b1 3 3 $teile]
		$canv dtag blank${blank_num}_tg blt1_tg
		set loc_blanks [lreplace $loc_blanks $blank_num $blank_num 0]
		return
	      }

	{2}   {#Vom Hubdrehtisch loeschen
		set teile [lindex $prod_tb 8]
		set ind [lsearch $teile blank${blank_num}_tg]
		set teile [lreplace $teile $ind $ind]
		set prod_tb [lreplace $prod_tb 8 8 $teile]
		set loc_blanks [lreplace $loc_blanks $blank_num $blank_num 0]
		return
	      }

	{4}   {#Von der Presse loeschen
		set teile [lindex $prod_pr 2]
		set ind [lsearch $teile blank${blank_num}_tg]
		set teile [lreplace $teile $ind $ind]
		set prod_pr [lreplace $prod_pr 2 2 $teile]
		set loc_blanks [lreplace $loc_blanks $blank_num $blank_num 0]
		return
	      }

	{6}   {#Von Band 2 loeschen
		set teile [lindex $prod_b2 3]
		set ind [lsearch $teile blank${blank_num}_tg]
		set teile [lreplace $teile $ind $ind]
		set prod_b2 [lreplace $prod_b2 3 3 $teile]
		$canv dtag blank${blank_num}_tg blt2_tg
		set loc_blanks [lreplace $loc_blanks $blank_num $blank_num 0]
		return
	      }


	#END case
        }

# END proc blank_remove_from_dev
}

###################
# proc blank_assign_to_dev { blank_number current_device}
# 
# fuegt den Blank mit der Nummer blank_number
# zu dem Gereat mit der Nummer current_device hinzu
###################

proc blank_assign_to_dev {blank_num assign_device} {

 global prod_a1 prod_a2 prod_b1 prod_b2 
 global prod_tb prod_cr prod_pr
 global loc_blanks

  set blank_name blank${blank_num}_tg
  case $assign_device in {

	{-1}  {
		set loc_blanks [lreplace $loc_blanks $blank_num $blank_num -1]
	      }

	{0}   {
		#keine Aktion notwendig
              }

	{1}   {
		#Teil zu Band 1 zufuegen
                set loc_blanks [lreplace $loc_blanks $blank_num $blank_num 1]
		set blanks [lindex $prod_b1 3]
		lappend blanks $blank_name
		set prod_b1 [lreplace $prod_b1 3 3 $blanks]
	      }


	{2}   {
		#Teil zu Tisch zufuegen
                set loc_blanks [lreplace $loc_blanks $blank_num $blank_num 2]
		set blanks [lindex $prod_tb 8]
		lappend blanks $blank_name
		set prod_tb [lreplace $prod_tb 8 8 $blanks]
	      }

	{4}   {
		#Teil zu Presse zufuegen
                set loc_blanks [lreplace $loc_blanks $blank_num $blank_num 4]
		set blanks [lindex $prod_pr 2]
		lappend blanks $blank_name
		set prod_pr [lreplace $prod_pr 2 2 $blanks]
	      }

	{6}   {
		#Teil zu Band 2 zufuegen
                set loc_blanks [lreplace $loc_blanks $blank_num $blank_num 6]
		set blanks [lindex $prod_b2 3]
		lappend blanks $blank_name
		set prod_b2 [lreplace $prod_b2 3 3 $blanks]
	      }	

        }

# END proc blank_remove_from_dev
}


############
# proc item_release {}
#
# sorgt dafuer, dass das Teil nach dem Ziehen richtig 
# abgelegt wird
##############

proc item_release {} {

  ################
  #Hilfsprozeduren
  ################
  # transf {vek um}
  # transformiert den vektor "vek" um den vektor "um"
  ################
  proc transf {vektor um} {

  set index 0
  set ergebinis {}
  foreach elem $vektor {
     lappend ergebniss [expr $elem+[lindex $um $index ]]
     incr index
    }
  return $ergebniss
  }
  
  ################
  # mult_vekt {vek skal}
  # multipliziert den vektor "vek" mit dem Skalar "skal"
  ################
  proc mult_vekt {vektor skal} {

  set ergebinis {}
  foreach elem $vektor {
     lappend ergebniss [expr $elem*$skal]
    }
  return $ergebniss
  }

  ################
  # norm_vekt {vek}
  # berechnet die Norm des Vektors "vek"
  ################
  proc norm_vekt {vektor} {

  set ergebniss 0
  foreach elem $vektor {
     set ergebniss [expr $ergebniss+$elem*$elem]
    }
  return [sqrt $ergebniss]
  }

  ################
  # spiegel_vekt {vek}
  # spiegelt "vek" am Ursprung 
  ################
  proc spiegel_vekt {vektor} {

  set ergebinis {}
  foreach elem $vektor {
     lappend ergebniss [expr -$elem]
    }
  return  $ergebniss
  }


############# ENDE HILFSPROZEDUREN ########################

 global canv item_tag blank_length
 global loc_blanks max_blanks color_teil color_teil_error
 global prod_tb prod_a1

if {$item_tag != "" } {
   #Wenn ein Teil bewegt wurde:


   #Um welches Teil handelt es sich dabei ?
   set teil_nummer [string range $item_tag 5 5]
   set teil_in_geraet [lindex $loc_blanks $teil_nummer]


 # 1. Fall
   #Ist das Teil ueber Band 1 losgelassen worden ?
     set unterlage [$canv coords blt1pad_tg]
     set teile_liste [eval $canv find overlapping $unterlage ]
     set teil_index  [$canv find withtag $item_tag]

     if { [lsearch $teile_liste $teil_index] != -1} {

	#Wenn das Teil ueber Band 1 losgelassen wurde 
	#wird es entsprechend abgelegt
	set koordx1 [lindex [$canv coords $item_tag] 0]
	set koordx2 [lindex [$canv coords $item_tag] 2]
	set koordx1 [expr 0.5*($koordx1+$koordx2-$blank_length)]
	set koordx2 [expr $koordx1+$blank_length]
	set koordy1 [expr 0.5*([lindex $unterlage 1]+[lindex $unterlage 3])]
	$canv coords $item_tag $koordx1 $koordy1 $koordx2 $koordy1
	$canv itemconfigure $item_tag -fill $color_teil

	#Hier wird das Teil zum neuen Gereat zugeordnet
	 blank_assign_to_dev   $teil_nummer 1
	 return
      } 


 # 2. Fall
   #Ist das Teil ueber dem Hubdrehtisch losgelassen worden ?
     set unterlage   [$canv coords tab_tg]
     set kx1 	     [lindex $unterlage 0]
     set ky1 	     [expr [lindex $unterlage 1]-20]
     set kx2 	     [lindex $unterlage 2]
     set ky2 	     [expr [lindex $unterlage 3]+20]
     set teile_liste [$canv find overlapping $kx1 $ky1 $kx2 $ky2]
     set teil_index  [$canv find withtag $item_tag]

     if { [lsearch $teile_liste $teil_index] != -1} {

	#Wenn das Teil ueber dem Hubdrehtisch losgelassen wurde 
	#wird es entsprechend abgelegt
	# 1. den Mittelpunkt auf dem Hubdrehtisch bestimmen
	  set koordx1 [lindex $unterlage 0]
	  set koordx2 [lindex $unterlage 2]
	  set koordy1 [lindex $unterlage 1]
	  set koordy2 [lindex $unterlage 3]
	  set richtvektor [transf "$koordx2 $koordy2" "-$koordx1 -$koordy1"]
	  set mittel_vektor [transf [mult_vekt $richtvektor 0.5] "$koordx1 $koordy1"]

	#Den Vektor der die Richtung des Teils angibt bestimmen
	  set laenge [norm_vekt $richtvektor]
	  set teil_vek1 [mult_vekt $richtvektor 0.5*$blank_length/$laenge]
	  set teil_vek2 [spiegel_vekt $teil_vek1]

	#Vektoren wieder zuruecktransformieren
	  set teil_vek1 [transf $teil_vek1 $mittel_vektor]
	  set teil_vek2 [transf $teil_vek2 $mittel_vektor]


	#Teil als hoechstes auf dem Tisch plazieren, d.h. direkt unter dem
	#Roboterarm
	if {[lindex $prod_a1 10] != "" } {
	   set under_item [lindex $prod_a1 10]
	} else {
	   set under_item arm1_tg
	}
	$canv lower $item_tag $under_item


	#Teil neu zeichnen
	  eval $canv coords $item_tag $teil_vek1 $teil_vek2
	  $canv itemconfigure $item_tag -fill $color_teil

	#Hier wird das Teil zum neuen Gereat zugeordnet
	 blank_assign_to_dev   $teil_nummer 2

	 return
      }



 # 3. Fall
   #Ist das Teil ueber der Presse  losgelassen worden ?
     set unterlage [$canv coords prs_tg]
     set teile_liste [eval $canv find overlapping $unterlage ]
     set teil_index  [$canv find withtag $item_tag]

     if { [lsearch $teile_liste $teil_index] != -1} {

	#Wenn das Teil ueber der Presse  losgelassen wurde 
	#wird es entsprechend abgelegt
	set koordx1 [lindex $unterlage 0]
	set koordx2 [lindex $unterlage 2]
	set koordx1 [expr 0.5*($koordx1+$koordx2)]

	set koordy1 [expr 0.5*([lindex $unterlage 1]+[lindex $unterlage 3]-$blank_length)]
	set koordy2 [expr $koordy1+$blank_length]

	$canv coords $item_tag $koordx1 $koordy1 $koordx1 $koordy2
	$canv itemconfigure $item_tag -fill $color_teil

	#Hier wird das Teil zum neuen Gereat zugeordnet
	 blank_assign_to_dev   $teil_nummer 4
	 return
      } 


   
 # 4. Fall
   #Ist das Teil ueber Band 2 losgelassen worden ?
     set unterlage [$canv coords blt2pad_tg]
     set teile_liste [eval $canv find overlapping $unterlage ]
     set teil_index  [$canv find withtag $item_tag]

     if { [lsearch $teile_liste $teil_index] != -1} {

	#Wenn das Teil ueber Band 2 losgelassen wurde 
	#wird es entsprechend abgelegt
	set koordx1 [lindex [$canv coords $item_tag] 0]
	set koordx2 [lindex [$canv coords $item_tag] 2]
	set koordx1 [expr 0.5*($koordx1+$koordx2-$blank_length)]
	set koordx2 [expr $koordx1+$blank_length]
	set koordy1 [expr [lindex $unterlage 1]+5]

	$canv coords $item_tag $koordx1 $koordy1 $koordx2 $koordy1
	$canv itemconfigure $item_tag -fill $color_teil
	#Das Teil wird ueber den hoechsten Punkt von Band 2 gezeichnet,
        #damit aber auch gleichzeitg uner die Presse und Arm 2
	$canv lower $item_tag allblnks_tg

	#Hier wird das Teil zum neuen Gereat zugeordnet
	 blank_assign_to_dev   $teil_nummer 6
	 return
      } 

 # 5. Fall 
   # Ist das Teil ueber dem Teilelager  losgelassen worden ?
     set koordx1 [lindex [$canv coords $item_tag] 0]
     set koordx2 [lindex [$canv coords $item_tag] 2]
     set koordx1 [minimum $koordx1 $koordx2]
     set koordy1 [lindex [$canv coords $item_tag] 1]
     set koordy2 [lindex [$canv coords $item_tag] 3]
     set koordy1 [maximum $koordy1 $koordy2]

     if { ($koordx1 <= 290) && ($koordy1 >= 320) } {

	 set teilx [expr 20+($max_blanks-$teil_nummer-1)*30]
	 set teily1 365
	 set teily2 [expr $teily1+$blank_length]
	 $canv coords $item_tag  $teilx $teily1 $teilx $teily2 
	 $canv itemconfigure $item_tag -fill $color_teil 
	 return
	}

 # 6. Fall Wenn der Interpreter bis hierher kommt dann ist das Teil 
 # in kein gueltiges Geraet abgelegt worden; also wird es fehlerhaft 
 # abgelegt
     $canv itemconfigure $item_tag -fill $color_teil_error
     blank_assign_to_dev $teil_nummer -1

 #END IF {$item_tag != "" }
 } 


# END proc item_release
}



