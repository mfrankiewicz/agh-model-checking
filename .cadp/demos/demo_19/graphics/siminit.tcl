
####################################################################
#
# Datei siminit_eng.tcl
#
# Autor : 	   Artur Brauer
# Erstellzetraum : November 1992 bis Maerz 1993
#
# Diese Datei enthaelt die Funktionen zum Initialisieren der Graphik
# der Fertigungszellen-Simulation
# englische Version
####################################################################

#------------------------------------------------------------------------------
# This file was modified by Hubert Garavel - Tue Sep 24 10:28:13 CEST 2013
#------------------------------------------------------------------------------
# This file was modified by Wendelin Serwe - Mon Sep 30 15:36:04 CEST 2013
#------------------------------------------------------------------------------

#*********************************************
# Prozedur zum Erzeugen von Laufband 2 (das obere Band),
# als Parameter dienen das Canvas,
# die Laenge und Hoehe des Bandes,
# sowie die Breite eines Elementes
# und der Abstand zwischen den Elementen
# ebenso der linke obere Punkt des Bandes zur Positionierung
#
#**********************************************
proc create_belt2 {canv lang hoch xpos ypos} {
#Statusvariable
global prod_b2

#Farbvariablen aus der Farbtabelle
global color_b2_unterlage color_b2_rand color_b2_markierung color_b2_schranke
global color_b2_schranke_aussen color_b2_led_an color_b2_led_aus color_b2_led_aussen


set rand 15
set anf 10
set breit_abschl 10 
set unsichtbar [lindex [$canv configure -background] 4]

#Unterlage
set posy [expr $hoch+$ypos]
$canv create rect $xpos $ypos [expr $xpos+$lang] $posy -fill $color_b2_unterlage \
			-outline $color_b2_unterlage -tags blt2pad_tg
#Bandmarkierung, diese wird bewegt
set posx [expr $xpos+$lang-$anf]
$canv create line $posx $ypos $posx $posy -width 1 -fill $color_b2_markierung \
		-tags blt2_tg


#Abschluesse
$canv create rect [expr $xpos-$breit_abschl] [expr $ypos-$rand] [expr $xpos] \
	[expr $ypos+$hoch+$rand] -outline $unsichtbar -fill $unsichtbar
$canv create rect [expr $xpos+$lang] [expr $ypos-$rand] [expr $xpos+$lang+$breit_abschl]\
	[expr $ypos+$hoch+$rand] -outline $unsichtbar -fill $unsichtbar

#Rand oben
set h1 $xpos
set h2 [expr $ypos-$rand]
set h3 [expr $xpos+$lang]
set h4 $ypos
$canv create rect $h1 $h2 $h3 $h4 \
		 -outline $color_b2_rand -fill $color_b2_rand -tags blt2mrg_tg

#Lichtschranke auf oberen Rand 
set h1 [expr $h1+100]
set h2 [expr $h2-5]
set h3 [expr $h1+100]
set h4 [expr $h2+15]
$canv create rect $h1 $h2 $h3 $h4 -fill $color_b2_schranke -outline $color_b2_schranke_aussen
#LED der Lichtschranke
set h1 [expr $h1+45]
set h2 [expr $h2+2]
set h3 [expr $h1+10]
set h4 [expr $h2+10]
$canv create oval $h1 $h2 $h3 $h4 -fill $color_b2_led_aus \
	-outline $color_b2_led_aussen -tags blt2led_tg

#Rand unten
set h1 $xpos
set h2 [expr $ypos+$hoch]
set h3 [expr $xpos+$lang]
set h4 [expr $ypos+$hoch+$rand]
$canv create rect $h1 $h2 $h3  $h4\
	 -outline $color_b2_rand -fill $color_b2_rand -tags blt2mrg_tg
#Lichtschranke auf unterem Rand 
set h1 [expr $h1+100]
set h2 [expr $h2+5]
set h3 [expr $h1+100]
set h4 [expr $h2+5]
$canv create rect $h1 $h2 $h3 $h4 -fill $color_b2_schranke -outline $color_b2_schranke_aussen


#Statusvariable erzeugen 
set bew 0
set bewegt $anf
set absolute_laenge $lang
set teile {}
set prod_b2 [list $bew $bewegt $absolute_laenge $teile $h1 $h3 0]
}
#*********************************************
# Prozedur zum Erzeugen von Laufband 1 (das untere Band),
# als Parameter dienen das Canvas,
# die Laenge und Hoehe des Bandes,
# sowie die Breite eines Elementes
# und der Abstand zwischen den Elementen
# ebenso der linke obere Punkt des Bandes zur Positionierung
#**********************************************
proc create_belt1 {canv lang hoch xpos ypos} {
#Statusvariable
global prod_b1

#Globale Farbwerte
global color_b1_unterlage color_b1_rand color_b1_markierung color_b1_schranke
global color_b1_schranke_aussen color_b1_led_an color_b1_led_aus color_b1_led_aussen

set rand 15
set anf 10
set unsichtbar [lindex [$canv configure -background] 4]
set breit_abschl    10
set lschranke_lang  50
set lschranke_breit 15
set lschranke_led   10

#Unterlage
 set posy [expr $hoch+$ypos]
 $canv create rect $xpos $ypos [expr $xpos+$lang]  $posy -fill $color_b1_unterlage\
		 -outline $color_b1_unterlage -tags blt1pad_tg

#Bandmarkierung, diese wird bewegt
 set posx [expr $xpos+$anf ]	
 $canv create line $posx $ypos $posx $posy -width 1 -fill $color_b1_markierung \
		-tags blt1_tg


#Abschluesse
 $canv create rect [expr $xpos-$breit_abschl] [expr $ypos-$rand] [expr $xpos] \
	[expr $ypos+$hoch+$rand] -outline $unsichtbar -fill $unsichtbar
 $canv create rect [expr $xpos+$lang] [expr $ypos-$rand] [expr $xpos+$breit_abschl+$lang] \
        [expr $ypos+$hoch+$rand] -outline $unsichtbar -fill $unsichtbar


#Oberer Rand des Bandes
 $canv create rect [expr $xpos] [expr $ypos-$rand] [expr $xpos+$lang]\
	[expr $ypos] -outline $color_b1_rand -fill $color_b1_rand -tags blt1mrg_tg

#LichtschrankeUnterbau auf oberem Rand
 set begin_schrx [expr $xpos+$lang-$lschranke_lang]
 set begin_schry [expr $ypos-$rand-5]
 set ende_schrx  [expr $xpos+$lang]
 set ende_schry  [expr $begin_schry+$lschranke_breit]
 $canv create rect $begin_schrx $begin_schry $ende_schrx $ende_schry \
	-fill $color_b1_schranke -outline $color_b1_schranke_aussen

#LED der Lichtschranke
 set begin_ledx [expr $begin_schrx+0.5*($lschranke_lang-$lschranke_led)]
 set begin_ledy [expr $begin_schry+0.5*($lschranke_breit-$lschranke_led)]
 set ende_ledx  [expr $begin_ledx+$lschranke_led]
 set ende_ledy  [expr $begin_ledy+$lschranke_led]
 $canv create oval $begin_ledx $begin_ledy $ende_ledx $ende_ledy \
	-fill $color_b1_led_aus -outline $color_b1_led_aussen -tags blt1led_tg

#Unterer Rand
 $canv create rect [expr $xpos] [expr $ypos+$hoch] [expr $xpos+$lang]\
	[expr $ypos+$hoch+$rand] -outline $color_b1_rand \
	-fill $color_b1_rand -tags blt1mrg_tg

#LichtschrankenUnterbau auf unterem Rand
 set begin_schry [expr $ypos+$hoch+0.5*($rand-5)]
 set ende_schry  [expr $begin_schry+5]
 $canv create rect $begin_schrx $begin_schry $ende_schrx $ende_schry \
		-fill $color_b1_schranke -outline $color_b1_schranke_aussen


#Statusvariable erzeugen 
 set bew 0
 set bewegt $anf
 set absolute_laenge $lang
 set teile {}
 set prod_b1 [list $bew $bewegt $absolute_laenge $teile $begin_schrx $ende_schrx 0]

}

#*******************************
# proc create_rob_tab {}
# erzuegt einen Roboter mit zwei Armen
# einen Hub- Dreh- Tisch
# und die Produktionsteile
# in dem Canvas "canv" 
# an der Position (x,y)
# Arm 1 hat dabei Laenge "lang1"
# Arm 2 hat dabei Laenge "lang2"
# Tisch hat die Laenge "lang_tisch"
# und die Breite "breit"
#*******************************
proc create_rob_tab {canv x y lang1 lang2 lang_tisch breit} {

 global prod_a2 prod_a1 prod_tb prod_pr
 global max_blanks path_name

#Farbwerte
 global color_rob_unterbau color_rob_unterbau_aussen color_rob_a1 color_rob_a2
 global color_tab color_tab_aussen
 global color_press color_press_aussen color_press_hoehe
 global color_b1_rand color_b2_rand color_teil
 global color_schwarzweiss

#Die Laenge eines Teiles wird als globale Groesse gefuehrt,
#da sie noch von manage_blanks und itemRelease verwendet wird
 global blank_length

#Die Nahmen der Geraete, die von der gewaehlten Sprache abhaengen
 global name_press name_table 

#Laenge der Teile
 set blank_length 70

#Groesse des Unterbaus des Roboters
 set gr_kreis 60


#Parameter fuer die Presse
 set abstandx_pr 135
 set abstandy_pr 0
 set presse_gr 60
 set moeglich_pr_hoch 104
 set hoch_a2_u 100
 set hoch_a2_o 44
 set hoch_a1 52

#Parameter fuer den Tisch
 set abstandx_tisch -200
 set abstandy_tisch [expr 64+0.5*$breit]
 set abstandx_tisch_hoch 30
 set abstandy_tisch_hoch 50
 set moeglich_bew_tisch 108 
 set hoch_b1 40

#***************************************
#Aufbau
#***************************************

#Roboterunterbau
 set bbx1 [expr $x-$gr_kreis]
 set bby1 [expr $y-$gr_kreis]
 set bbx2 [expr $x+$gr_kreis]
 set bby2 [expr $y+$gr_kreis]
 $canv create oval $bbx1 $bby1 $bbx2 $bby2 -outline $color_rob_unterbau_aussen \
		-fill $color_rob_unterbau

#Hub- und Drehtisch
 set bbx1 [expr $x+$abstandx_tisch]
 set bby1 [expr $y+$abstandy_tisch]
 set bbx2 [expr $bbx1+$lang_tisch]
 $canv create line $bbx1 $bby1 $bbx2 $bby1 -width $breit -fill $color_tab \
		-tags tab_tg 

#Wenn die Darstellung auf einem Schwarzweiss-Monitor erfolgt wird der Hubdrehtish
#mit einer Bitmap gefuellt
 if {$color_schwarzweiss == "schwarzweiss" } { 
  $canv itemconfigure tab_tg -stipple @${path_name}bitmap_grey.xbm
  }

#Hoehenanzeige des Tisches 
#hx hy bezeichnen den Ausgangspunkt fuer die Hoehenanzeige
 set hx [expr $bbx1+$abstandx_tisch_hoch]
 set hy [expr $bby1+$abstandy_tisch_hoch]
 $canv create text $hx $hy -text $name_table -justify center

#(hx hy bezeichnen den Ausgangspunkt fuer die Hoehenanzeige)
 set hy [expr $hy+20]

#Markierung fuer Arm1
 set breit_ma1 4
 set mx1 $hx
 set my1 [expr $hy-0.5*$breit_ma1]
 set mx2 [expr $hx+30]
 $canv create line $mx1 +$my1 $mx2 $my1 -fill $color_rob_a1 -width $breit_ma1

#Markierung fuer Band1
 set mx1 [expr  $hx-30]
 set my1 [expr $hy+$hoch_b1+0.5*$breit_ma1]
 set mx2 [expr $mx1-30]
 $canv create line $mx1 $my1 $mx2 $my1 -width $breit_ma1 -fill $color_b1_rand

#Tischmarkierung
 set lang_ht 40
 set breit_ht 6
 set mx1 [expr $mx1+2]
 set mx2 [expr $mx1+$lang_ht]
 set my1 [expr $hy+$hoch_b1+0.5*$breit_ht]
 $canv create line $mx1 $my1 $mx2 $my1 -width $breit_ht -fill $color_tab \
						       -tags tabhgt_tg
#Hub- und Drehtisch Statusvariable erzeugen
 set prod_tb "0 0 0 $hoch_b1 $bbx1 $bby1 $bbx2 $bby1 {} $moeglich_bew_tisch $hoch_b1"

# PRESSE
#######

 set bbx1 [expr $x+$abstandx_pr]
 set bby1 [expr $y-$abstandy_pr]
 set bbx2 [expr $bbx1+$presse_gr]
 set bby2 [expr $bby1+$presse_gr]

 #Presse zeichnen
 $canv create rect $bbx1 $bby1 $bbx2 $bby2 -outline $color_press_aussen \
				 -fill $color_press -tags prs_tg

#Aufbau der Hoehenanzeige der Presse 
 set hx [expr $bbx2+30]
 set hy [expr $bby1-30]
 $canv create text $hx $hy -text $name_press
 set hy [expr $hy+15]

#Anzeigebalken
 set breit_pr 30
 set breit_mark 10
 set prx1 [expr $hx-0.5*$breit_pr]
 set pry1 [expr $hy+$hoch_a1]
 set prx2 [expr $hx+$breit_pr]
 $canv create line  $prx1 $pry1 $prx2 $pry1 -width 4 \
	-fill $color_press_hoehe -tags prshgt_tg

 set bbx1 [expr $hx-0.5*$breit_mark]
 set bbx2 [expr $hx+$breit_mark]
 set bby1 $hy
 $canv create line  $bbx1 $bby1 $bbx2 $bby1 \
				-width 3 
#Markierung fuer Arm 1
 set bbx1 [expr $hx-0.5*$breit_mark]
 set bbx2 [expr $hx+$breit_mark]
 set bby1 [expr $hy+$hoch_a1]
 $canv create line  $bbx1 $bby1 $bbx2 $bby1 \
				 -width 3 -fill $color_rob_a1

#Markierung fuer Arm 2
 set bbx1 [expr $hx-0.5*$breit_mark]
 set bbx2 [expr $hx+$breit_mark]
 set bby1 [expr $hy+$hoch_a2_u]
 $canv create line  $bbx1 $bby1 $bbx2 $bby1 \
				 -width 3 -fill $color_rob_a2
#Statusvariable fuer Presse erzeugen
 set prod_pr "0 $hoch_a1 {} $moeglich_pr_hoch $hoch_a2_u $hoch_a2_o $hoch_a1 "


#Teile
######
  for {set i 0} {$i < $max_blanks} {incr i} {
   set mark blank[expr $max_blanks-1-$i]_tg
   set teilx [expr 20+$i*31]
   set teily1 365
   set teily2 [expr $teily1+$blank_length]

   #das Tag "allblnks_tg" das alle Teile zusaetzlich erhalten,
   #erlaubt es ein Teil, wenn es am Ende von Band 2 auf das Handhabubgsgereat 
   #uebernommen wird, als obhalb aller anderen Teile 

   $canv create line $teilx $teily1 $teilx $teily2 -width 10 -fill $color_teil \
	   -tags "$mark allblnks_tg"
  }

#Roboter-Arme
  set anschlaga2_h  107
  set anschlaga2_v  160

  set posx1 [expr $x-0.25*$lang1]
  set posy1 [expr $y-60]
  set posx2 [expr $x+0.75*$lang1]
  set posy2 [expr $y-60]
  $canv create line $posx1 $posy1 $posx2 $posy2 -width 20 -tags arm2_tg \
   -fill $color_rob_a2

#Status von Arm 2 aufbauen
  set bew 0
  set richtung 0
  set magnet 0
  set grad 0
  set norm [expr 0.75*$lang1]
  set lang $lang1.0
  set prod_a2 [list $bew $richtung $magnet $grad $norm $lang $posx1 $posy1\
   $posx2 $posy2 {} $anschlaga2_v $anschlaga2_h]

#Arm 1
    set anschlaga1_h  80
    set anschlaga1_v  200

    set posx1 [expr $x-26]
    set posy1 [expr $y-0.5*$lang2]
    set posx2 [expr $x-26]
    set posy2 [expr $y+0.5*$lang2]
    $canv create line $posx1 $posy1 $posx2 $posy2  -width 20 -tags arm1_tg \
     -fill $color_rob_a1

#Status von Arm 1 aufbauen
    set bew 0
    set richtung 0
    set magnet 0
    set grad 0
    set norm [expr 0.5*$lang2]
    set lang $lang2.0
    set prod_a1 [list $bew $richtung $magnet $grad $norm $lang $posx1 $posy1\
     $posx2 $posy2 {} $anschlaga1_v $anschlaga1_h]

#Wenn die Ausganshoehe des zweiten Armes unter der Hoehe der Presse ist 
#wird der Arm unter die Presse geschoben
    if {[lindex $prod_pr 1] <= [lindex $prod_pr 5]} {
			$canv lower arm2_tg prs_tg }

}

####################
#proc create_crane
#
#Erzeugt das Handhabungsgeraet
#####################

proc create_crane {} {
global canv 
global prod_cr

#Farbwerte 
global color_hg color_hg_schiene color_hg_schiene_aussen
global color_hg_led_an color_hg_led_aus color_hg_led_aussen
global color_hg_hoehe

#Nahmen des Handhabungsgeraetes
global name_crane

#Koordinaten der Bewegungsschiene
set px1 120
set py1 3
set px2 140 
set py2 406

#Groesse des Greifers
set hhger_lang 40
set hhger_breit 20

# y-Anfangskoordinate des Greifers
set anfang 130

#Groesse der Anschlag LED's
set anschl 10

#Relative Position des Ausgangspunktes der Hoehenanzeige
set anzeige_x 40
set anzeige_y 127

#Hoehe der beiden Baender
set band1 60
set band2 86

#Breite der Markierungen bei der Hoehenanzeige
set breit_markierung 20

#Arm
set hx1 [expr $px1-$hhger_lang]
set hy1 $anfang
set hx2 $px1
set hy2 $anfang
$canv create line $hx1 $hy1 $hx2 $hy2 -fill $color_hg \
		 -width $hhger_breit -tags crn_tg
#Schiene
$canv create rect $px1 $py1 $px2 $py2 -fill $color_hg_schiene \
	-outline $color_hg_schiene_aussen
#Anschlag LED's
set kx1 [expr $px1+0.5*$anschl]
set ky1 [expr $py1+0.5*$anschl]
set kx2 [expr $kx1+$anschl]
set ky2 [expr $ky1+$anschl]
$canv create oval $kx1 $ky1 $kx2 $ky2 -tags crnled1_tg -fill $color_hg_led_aus \
		-outline $color_hg_led_aussen
set kx1 [expr $px1+0.5*$anschl]
set ky1 [expr $py2-0.5*$anschl]
set kx2 [expr $kx1+$anschl]
set ky2 [expr $ky1-$anschl]
$canv create oval $kx1 $ky1 $kx2 $ky2 -tags crnled2_tg -fill $color_hg_led_aus \
		-outline $color_hg_led_aussen
#Hoehenanzeige
#Text
set kx1 [expr $px2+$anzeige_x]
set ky1 [expr $py1+$anzeige_y]
$canv create text $kx1 $ky1 -text $name_crane

set ypos [expr $py1+$anzeige_y+15]
#erste Markierung
set farbe [lindex [$canv itemconfigure blt1mrg_tg -fill] 4]
set kx1 [expr $kx1-0.5*$breit_markierung]
set ky1 [expr $ypos+$band1]
set kx2 [expr $kx1+$breit_markierung]
$canv create line $kx1 $ky1 $kx2 $ky1 -width 3 -fill $farbe

#zweite Markierung
set farbe [lindex [$canv itemconfigure blt2mrg_tg -fill] 4]
set ky1 [expr $ypos+$band2]
$canv create line $kx1 $ky1 $kx2 $ky1 -width 3 -fill $farbe

#Darstellungs-Balken
set kx1 [expr $px2+$anzeige_x]
set ky1 $ypos
set ky2 [expr $ypos+$band1]
$canv  create line $kx1 $ky1 $kx1 $ky2 -tags crnhgt_tg -fill $color_hg_hoehe \
		-width 5

set moeglich_hoch [expr $band2+5]
set hoch $band1
set anschlag_oben 30
set anschlag_unten 360
set schranke_oben_y1 [lindex [$canv coord blt2pad_tg] 1]
set schranke_oben_y2 [expr $schranke_oben_y1+0.5*[lindex [$canv itemconfigure crn_tg -width] 4]]
set schranke_unten_y1 [expr 0.5*([lindex [$canv coord blt1pad_tg] 1]+[lindex [$canv coord blt1pad_tg] 3])]
set schranke_unten_y2 [expr $schranke_unten_y1+0.5*[lindex [$canv itemconfigure crn_tg -width] 4]]

set prod_cr "0 0 $anfang 0 $hoch $moeglich_hoch $band2 $band1 \
$hx1 $hy2 $hx2 $hy2 $kx1 $ky1 $kx1 $ky2 {} \
$anschlag_oben $anschlag_unten \
$schranke_oben_y1 $schranke_oben_y2 \
$schranke_unten_y1 $schranke_unten_y2"
}

##############
#
# proc create_widgets
#
# Erzeugt die fuer die Simulation noetigen
# Widgets, fuer Darstellung und Fehlermeldungen
############## 
proc create_widgets {} {

global name_simulation color_hintergrund 
global path_name

wm title . $name_simulation
wm geometry . +0+175
wm iconbitmap . @${path_name}bitmap_icon.xbm

# Canvas - Platz
frame  .canfr -relief sunken -borderwidth 1 
canvas .canfr.bild -width 820 -height 480 -background $color_hintergrund

#Ausgabe
message .codlog -relief sunken -borderwidth 1 -justify left\
			-width 820 -anchor w

pack append .canfr .canfr.bild { top  } 
pack append . .canfr { bottom fillx} .codlog {top fillx}

}

#****************
#Bildschirmaufbau
#baut das Bild der Fertigungsezelle auf 
#****************
proc create_scene {} {
global env
global canv
global color_hintergrund color_fzilogo
global path_name

set canv .canfr.bild

set band2x 50
set band2y 50
set band1x 50
set band1y 265
set robmidx 555
set robmidy 205

$canv create bitmap 700 430 -background $color_hintergrund \
	 -foreground $color_fzilogo \
	 -bitmap @${path_name}bitmap_fzi.xbm
$canv create text 700 465 -text "FZI" -tags fzi \
   -font $env(FZI_TITLE_FONT)

set cadp_logo [image create photo box -format GIF -file ${path_name}/cadp.gif]
$canv create text 776 385 -text "powered by" -justify center
$canv create image 776 435 -image $cadp_logo 

create_belt2  .canfr.bild 620 40 $band2x $band2y 
create_belt1  .canfr.bild 302 40 $band1x $band1y 
create_rob_tab .canfr.bild $robmidx $robmidy 175 255 121 40
create_crane


#Binding fuer das definierte beenden der Simulation ueber den close Button
wm protocol . WM_DELETE_WINDOW {system_quit}


#Bindings fuer das Ziehen und Ablegen der Teile
    bind $canv <1>         "item_start_drag $canv %x %y"
    bind $canv <B1-Motion> "item_drag $canv %x %y"
    bind $canv <B1-ButtonRelease> "item_release"
}



proc unknown {arg} {

global UnknownCommand

set UnknownCommand $arg

#Report Message : Unknown Command
report_message 17

}
