###############################################################################
#                 O C I S (OPEN/CAESAR Interactive Simulator)
#-----------------------------------------------------------------------------
#   INRIA
#   Unite de Recherche Rhone-Alpes
#   655, avenue de l'Europe
#   38330 Montbonnot Saint Martin
#   FRANCE
#-----------------------------------------------------------------------------
#   Module              :       ocis.tcl
#   Auteurs             :       D. Champelovier, M. Cherif, H. Garavel, 
#				B. Hondelatte, P. Kessler
#   Version             :       1.10
#   Date                :       2013/09/06 16:28:15
###############################################################################

package require Tix

set Ocis_Version		1.2

set Fg_Color			red
set Title_Color			#FFFF77

set Pane_Border_Width		0
set Pane_Relief			flat
set Handle_Active_Bg		red
set Separator_Bg		gray50 
set global_bg_color		#EEFFFF
set global_menu_bg_color	#7AC0DA
set global_heure_courante	0
set Xterm_Options		"-geometry 80x40"
set Screen_Width		600
set Screen_Height		760
set Screen_MinWidth		400
set Screen_MinHeight		400
set Screen_X_Position		0
set Screen_Y_Position		0

set Error_Win_Width		350
set Error_Win_Height		160

set Warning_General_Win_Width	320
set Warning_General_Win_Height	150

set Warning_Width		350
set Warning_Height		100

set Selection_Filebox_Width	300
set Selection_Filebox_Height	300

set Pref_Main_Win_Type		3
set Pref_Trans_Win_Type		2

set Height_Msc_View		300 
set Height_Trans_View		250

set Width_Time_View		50
set Width_TextTrace_View	200
set Width_Processes_View	50

set Width_Win_Source		400 
set Height_Win_Source		800
set Win_Source_X_Position	0
set Win_Source_Y_Position	0

set Auto_Advance_Option		0
set Auto_Advance_Max_Steps	50
set Loopback_Option		0
set global_proc_names		0

set Viewing_Source_Code		0

set Width_Win_Recompile		420
set Height_Win_Recompile	400
set Recompile_X_Position	0
set Recompile_Y_Position	0

set Width_Win_Exhibitor		400
set Height_Win_Exhibitor	600
set Win_Exhibitor_X_Position	0
set Win_Exhibitor_Y_Position	0
set Exhibitor_Width_Label	18

set Width_Win_Help		700
set Height_Win_Help		700
set Win_Help_X_Position		0
set Win_Help_Y_Position		0

set Exhibitor_Starting_State	1
set Exhibitor_Case_Sensitive	0
set Exhibitor_Conflict		0
set Exhibitor_Exploration_Mode	1
set Exhibitor_Strategy		1
set Exhibitor_Type_Sequence	0
set Exhibitor_Depth_Search	1000
set Exhibitor_Text_Input_Sequence ""
set Exhibitor_File_Input_Sequence ""
set Exhibitor_File_Result	  ""

set Font_Msc_Label "-Adobe-Helvetica-Bold-R-Normal-*-10-*"
set Font_Msc_Info_Process "-Adobe-Helvetica-Medium-R-Normal-*-10-*"
set Font_Msc_Title_Tasks "-Adobe-Helvetica-Bold-R-Normal-*-16-*"
set Font_Vue_Texte_Label "-Adobe-Helvetica-Medium-R-Normal-*-10-*"
set Font_Code_Source_Title "-Adobe-Helvetica-Medium-R-Normal-*-10-*"
set Font_Code_Source_Texte "-Adobe-Helvetica-Medium-R-Normal-*-10-*"
set Font_Tree_Label "-Adobe-Helvetica-Medium-R-Normal-*-10-*"
set Font_Texte_Fenetre_Recompilation "-Adobe-Helvetica-Medium-R-Normal-*-10-*"

set Font_Bold_8	"-Adobe-Helvetica-Bold-R-Normal-*-8-*"
set Font_Bold_9	"-Adobe-Helvetica-Bold-R-Normal-*-9-*"
set Font_Bold_10 "-Adobe-Helvetica-Bold-R-Normal-*-10-*"
set Font_Bold_12 "-Adobe-Helvetica-Bold-R-Normal-*-12-*"
set Font_Bold_24 "-Adobe-Helvetica-Bold-R-Normal-*-24-*"

proc Widget_Time {liste} {
  global fenetres
  return $fenetres($liste.1)
}

proc Widget_Main {liste} {
  global fenetres
  return $fenetres($liste.2)
}

proc Widget_Process {liste} {
  global fenetres
  return $fenetres($liste.3)
}

proc Widget_Fired {liste} {
  global fenetres
  return $fenetres($liste.4)
}

proc Afficher_Prochaine_Transition_Vues_Msc_Et_Texte {status indice type porte etat procs time} {
    global Fenetres_Transition 
    global Nombre_Descendants_Transition_Courante 
    global Transition_Courante_Vue_Tree

    set chemin_transition_successeur "$Transition_Courante_Vue_Tree/$indice"

    global Arbre_Vue_Tree
    if { ![$Arbre_Vue_Tree info exists $chemin_transition_successeur]} {
	set couleur 2
    } else {
	set couleur [Determiner_Numero_Couleur_Transition \
		$chemin_transition_successeur]

	if {$couleur == 2} {
	    set couleur 0
	}
    }

    set Nombre_Descendants_Transition_Courante $indice 

    Afficher_Transition_Vue_Texte $indice "" $porte $procs $time \
	    $couleur $Fenetres_Transition 
    Afficher_Transition_Vue_Msc $indice "" $porte $procs $time \
	    $couleur $Fenetres_Transition $status
}

proc Lire_Prochaines_Transitions {} {
    global channel_id
    global Fenetres_Transition 
    global Nombre_Descendants_Transition_Courante 
    global global_next_event_time 
    global global_info_temps
    global DEBUG_MODE_PROTOCOL_EXTENSIVE

    set Nombre_Descendants_Transition_Courante 0

    while {1} {
	set ligne [gets $channel_id]
	if {$DEBUG_MODE_PROTOCOL_EXTENSIVE == 1} {
	    puts stdout "   TRANSITIONS $ligne"
	}

	if {$ligne == "END_TRANSITIONS"} then {
	    break
	}

	Afficher_Prochaine_Transition_Vues_Msc_Et_Texte [lindex $ligne 0] \
		[lindex $ligne 1] [lindex $ligne 2] \
		[lindex $ligne 3] [lindex $ligne 4] \
		[lindex $ligne 5] [lindex $ligne 6] 
    }

    if {$Nombre_Descendants_Transition_Courante > 0} then {

	Etablir_Bindings_Transition_Vue_Texte $Fenetres_Transition\
		"Afficher_Transition_Selectionnee_Vue_Texte"\
		"Afficher_Menu_Texte_Transition_Bouton_Droit \
		.popup_menu_trans_texte {$Fenetres_Transition}"\
		$Nombre_Descendants_Transition_Courante 

	Etablir_Bindings_Transition_Vue_Msc $Fenetres_Transition\
		"Afficher_Transition_Selectionnee"\
		"Afficher_Menu_Msc_Transition_Bouton_Droit \
		.popup_menu_trans_texte {$Fenetres_Transition}"\
		$Nombre_Descendants_Transition_Courante
    } else {

	if {$global_info_temps == 0} then {
	    affichage_sink_state $Fenetres_Transition 1
	} else {
	    if {$global_next_event_time == 0} then {

		affichage_block_state $Fenetres_Transition 1
	    }
	}
    }

    Realiser_Focus_Premiere_Ligne_Vue_Msc $Fenetres_Transition

}

proc Ajouter_Tag_Et_Couleur_Ligne_Texte {nom_colonne_widget numero_ligne couleur} {

    $nom_colonne_widget configure -state normal
    set Couleur_Reelle [Generer_Couleur_Reelle $couleur]

    set contenu_texte [$nom_colonne_widget get "$numero_ligne.0 linestart" "$numero_ligne.0 lineend"]
    $nom_colonne_widget delete "$numero_ligne.0 linestart" \
	    "$numero_ligne.0 lineend"
    $nom_colonne_widget insert $numero_ligne.0 $contenu_texte

    switch -exact -- $couleur {
	0 {

	    $nom_colonne_widget tag add $nom_colonne_widget.couleur0 \
		    "$numero_ligne.0 linestart" "$numero_ligne.0 lineend"
	    $nom_colonne_widget tag configure \
		    $nom_colonne_widget.couleur0 -foreground $Couleur_Reelle
	}
	1 {

	    $nom_colonne_widget tag add $nom_colonne_widget.couleur1 \
		    "$numero_ligne.0 linestart" "$numero_ligne.0 lineend"
	    $nom_colonne_widget tag configure \
		    $nom_colonne_widget.couleur1 -foreground $Couleur_Reelle
	}
	2 {

	    $nom_colonne_widget tag add $nom_colonne_widget.couleur2 \
		    "$numero_ligne.0 linestart" "$numero_ligne.0 lineend"
	    $nom_colonne_widget tag configure \
		    $nom_colonne_widget.couleur2 -foreground $Couleur_Reelle
	}
	3 { 

	    $nom_colonne_widget tag add $nom_colonne_widget.couleur3 \
		    "$numero_ligne.0 linestart" "$numero_ligne.0 lineend"
	    $nom_colonne_widget tag configure \
		    $nom_colonne_widget.couleur3 -foreground $Couleur_Reelle
	}
	4 { 

	    global Couleur_Background_Transition_Sink
	    $nom_colonne_widget tag add $nom_colonne_widget.couleur4 \
		    "$numero_ligne.0 linestart" "$numero_ligne.0 lineend"
	    $nom_colonne_widget tag configure \
		    $nom_colonne_widget.couleur4 -foreground $Couleur_Reelle \
		    -background $Couleur_Background_Transition_Sink
	}
	5 { 

	    global Couleur_Background_Transition_Selection
	    $nom_colonne_widget tag add $nom_colonne_widget.couleur5 \
		    "$numero_ligne.0 linestart" "$numero_ligne.0 lineend"
	    $nom_colonne_widget tag configure \
		    $nom_colonne_widget.couleur5 -foreground $Couleur_Reelle\
		    -background $Couleur_Background_Transition_Selection
	    
	}
    }

    $nom_colonne_widget configure -state disabled

}   

proc Afficher_Temps_Ecoule_Dans_Colonne_Time {indice time couleur widget_vue} {
    global global_info_temps 
    global Fenetres_Affichage 
    global Font_Vue_Texte_Label

    if {$global_info_temps} then {
	set fen_time [Widget_Time $widget_vue]
	$fen_time configure -state normal

	set Fenetre_Courante [lrange [split $widget_vue .] 0 0]
	if {$Fenetre_Courante == $Fenetres_Affichage} {
	    if {$indice == 1} {
		$fen_time insert $indice.0 "$time"
	    } else {
		if {[$fen_time get $indice.0] == ""} {
		    $fen_time insert $indice.0 "\n$time"
		} else {
		    $fen_time insert $indice.0 "$time\n"
		}
	    }
	} else {
	    $fen_time insert $indice.0 "$time\n"
	}

	$fen_time configure -font $Font_Vue_Texte_Label
	Ajouter_Tag_Et_Couleur_Ligne_Texte $fen_time $indice $couleur  
	$fen_time configure -state disabled
    }

}

proc Afficher_Liste_Taches_Dans_Colonne_Tasks {indice procs couleur widget_vue} {
    global global_info_temps 
    global Fenetres_Affichage 
    global Font_Vue_Texte_Label

    global Afficher_Colonne_Taches

    if {$Afficher_Colonne_Taches == 1} then {

	set fen_proc [Widget_Process $widget_vue]
	$fen_proc configure -state normal

	set Fenetre_Courante [lrange [split $widget_vue .] 0 0]
	if {$Fenetre_Courante == $Fenetres_Affichage} {
	    if {$indice == 1} {
		$fen_proc insert $indice.0 "$procs"
	    } else {
		if {[$fen_proc get $indice.0] == ""} {
		    $fen_proc insert $indice.0 "\n$procs"
		} else {
		    $fen_proc insert $indice.0 "$procs\n"
		}
	    }
	} else {
	    $fen_proc insert $indice.0 "$procs\n"
	}

	$fen_proc configure -font $Font_Vue_Texte_Label 
	Ajouter_Tag_Et_Couleur_Ligne_Texte $fen_proc $indice $couleur
	$fen_proc configure -state disabled
    }
}

proc Afficher_Informations_Mise_A_Feu {indice fired couleur widget_vue} {
    global global_info_temps 
    global Fenetres_Affichage 
    global Font_Vue_Texte_Label

    set fen_fired [Widget_Fired $widget_vue]
    $fen_fired configure -state normal

    set Fenetre_Courante [lrange [split $widget_vue .] 0 0]
    if {$Fenetre_Courante == $Fenetres_Affichage} {
	if {$indice == 1} {
	    $fen_fired insert $indice.0 "$fired"
	} else {
	    if {[$fen_fired get $indice.0] == ""} {
		$fen_fired insert $indice.0 "\n$fired"
	    } else {
		$fen_fired insert $indice.0 "$fired\n"
	    }
	}
    } else {
	$fen_fired insert $indice.0 "$fired\n"
    }

    $fen_fired configure -font $Font_Vue_Texte_Label 
    Ajouter_Tag_Et_Couleur_Ligne_Texte $fen_fired $indice $couleur
    $fen_fired configure -state disabled
}

proc Ouvrir_Noeud_Courant_Vue_Tree {} {

    Envoi_Message "open_current_node"

    global tree_path
    global Transition_Courante_Vue_Tree

    set mode_node [$tree_path getmode $Transition_Courante_Vue_Tree]
    if {$mode_node == "open"} {
	Commande_Ouverture_Transition_Vue_Tree 0 $Transition_Courante_Vue_Tree
    }
    $tree_path setmode $Transition_Courante_Vue_Tree close

}

proc Afficher_Transition_Selectionnee {ligne} {
    global Fenetres_Transition 
    global Fenetres_Affichage 
    global global_info_temps 
    global global_info_process 
    global global_heure_courante
    global Numero_Transition_Courante 
    global Chemin_Backward Chemin_Forward
    global global_info_rebouclage 
    global Nombre_Descendants_Transition_Courante
    global Auto_Advance_Option
    global global_next_event_time
    global Auto_Advance_Max_Steps
    global Auto_Advance_Current_Step

    global global_nb_tache 
    global Compile_Mode
    global Noms_Taches_Actives_Courantes

    if {$Compile_Mode == 1} {
	return
    }

    set frame_texte $Fenetres_Transition.2
    set fen_texte [Widget_Main $frame_texte]

    set texte [$fen_texte get $ligne.0 "$ligne.0 lineend"]

    set pos_deb [string first " " $texte]
    set pos_fin [string length $texte]
    set porte [string range $texte $pos_deb $pos_fin]
    set procs ""
    set time ""

    global Afficher_Colonne_Taches
    if {$Afficher_Colonne_Taches == 1} then {
	set fen_proc [Widget_Process $frame_texte]
	set procs [$fen_proc get $ligne.0 "$ligne.0 lineend"]
    } else {
	set procs "0"
    }

    incr Numero_Transition_Courante 1

    Effacer_Transition $Fenetres_Transition 1

    Ouvrir_Noeud_Courant_Vue_Tree

    global Error_Detected
    set Error_Detected 0

    Envoi_Message "next $ligne" 

    Lire_Reponse 

    lappend Chemin_Backward $ligne

    set Chemin_Forward ""  

    if {$global_info_temps} then {

	Envoi_Message "clock"

	Lire_Reponse 

	set time $global_heure_courante
    }

    if {[info exists global_info_rebouclage] && $global_info_rebouclage != "" && $global_info_rebouclage} then {
	set porte "$porte : Loopback \[Step $global_info_rebouclage\]"
    }

    update idle

    if {$Error_Detected == 1} {
	incr Numero_Transition_Courante -1
	return
    }

    global Transition_Courante_Vue_Tree
    set Type_Transition [Lire_Type_Transition $Transition_Courante_Vue_Tree]

    set couleur [Determiner_Numero_Couleur_Transition $Transition_Courante_Vue_Tree]

    global Pref_Main_Win_Type
    if {$Pref_Main_Win_Type != 3} {

	global Arbre_Vue_Tree
	Mettre_A_Jour_Couleur_Et_Texte_Transition $Pref_Main_Win_Type [expr $Numero_Transition_Courante -1] [$Arbre_Vue_Tree info parent $Transition_Courante_Vue_Tree]

	global Numero_Ligne_Transition_Parent_Vue_Tree
	Mettre_A_Jour_Couleur_Et_Texte_Transition 3 $Numero_Ligne_Transition_Parent_Vue_Tree [$Arbre_Vue_Tree info parent $Transition_Courante_Vue_Tree]
    }

    if {$Pref_Main_Win_Type == 2} {
	Afficher_Transition_Vue_Texte $Numero_Transition_Courante \
		$Transition_Courante_Vue_Tree \
		$porte $procs $time $couleur $Fenetres_Affichage 

	Realiser_Focus_Ligne_Texte TEXT $Fenetres_Affichage $Numero_Transition_Courante

	Etablir_Bindings_Transition_Vue_Texte \
		$Fenetres_Affichage "affichage_selection_back" \
		"Afficher_Menu_Texte_Transition_Bouton_Droit \
		.popup_menu_main_texte {$Fenetres_Affichage}"\
		$Numero_Transition_Courante

    } elseif {$Pref_Main_Win_Type == 1}  {
	Afficher_Transition_Vue_Msc $Numero_Transition_Courante \
		$Transition_Courante_Vue_Tree \
		$porte $procs $time $couleur $Fenetres_Affichage  ""

	Etablir_Bindings_Transition_Vue_Msc \
		$Fenetres_Affichage "Effectuer_Retour_Arriere"\
		"Afficher_Menu_Msc_Transition_Bouton_Droit \
		.popup_menu_main_texte {$Fenetres_Affichage}"\
		$Numero_Transition_Courante 
    }

    Lire_Reponse 

    Recuperer_Information_Backcode Non_Historique

    if {$Auto_Advance_Option && $Nombre_Descendants_Transition_Courante == 1} then {
	incr Auto_Advance_Current_Step 1
	if {$Auto_Advance_Current_Step < $Auto_Advance_Max_Steps} then {

	    update
	    Afficher_Transition_Selectionnee 1 
	} else {
	    set Auto_Advance_Current_Step 0
	}
    }

    if {$Auto_Advance_Option && $global_info_temps && \
	    $Nombre_Descendants_Transition_Courante == 0 && $global_next_event_time != 0} then {

	update
	Executer_Wait
    }

}

proc Lire_Type_Transition {Chemin_Transition} {
    global Arbre_Vue_Tree

    set data_transition [$Arbre_Vue_Tree info data $Chemin_Transition]
    return [lindex [lindex $data_transition 0] 1]
}

proc Determiner_Numero_Couleur_Transition {chemin_transition} {
    global Arbre_Vue_Tree

    if { ![$Arbre_Vue_Tree info exists $chemin_transition]} {
	return 2
    }

    global Liste_Transitions_Selectionnees
    if {[expr [lsearch -exact $Liste_Transitions_Selectionnees \
	    $chemin_transition] >= 0]} {
	return 5
    }

    set data_transition [$Arbre_Vue_Tree info data $chemin_transition]
    set type_transition [lindex [lindex $data_transition 0] 1]
    set nbr_fils [lindex [lindex $data_transition 2] 0]
    set nbr_fils_generes 0
    set nbr_fils_generes_wait 0

    set liste_fils [$Arbre_Vue_Tree info children $chemin_transition]
    foreach chemin_fils $liste_fils {
	set data_fils [lindex [$Arbre_Vue_Tree info data $chemin_fils] 0]
	set type_fils [lindex $data_fils 1]
	if {$type_fils == "N"} {
	    incr nbr_fils_generes 1
	} elseif {$type_fils == "T"} {
	    incr nbr_fils_generes_wait 1
	}
    }

    if {$nbr_fils == 0} {

	set couleur 4
    } elseif {$nbr_fils == $nbr_fils_generes} {

	set couleur 1
    } elseif {$type_transition == "T"} {

	set couleur 3
    } elseif {[expr $nbr_fils_generes + $nbr_fils_generes_wait] == 0} {

	set couleur 2
    } else {

	set couleur 0
    }
    return $couleur
}

proc Generer_Couleur_Reelle {couleur} {

    switch -exact -- $couleur {
	0 { 

	    global Couleur_Transition_Exploree
	    set couleur_reelle $Couleur_Transition_Exploree
	} 
	1 {

	    global Couleur_Transition_Completement_Exploree
	    set couleur_reelle $Couleur_Transition_Completement_Exploree
	} 
	2 {

	    global Couleur_Transition_Feuille
	    set couleur_reelle $Couleur_Transition_Feuille
	} 
	3 {

	    global Couleur_Transition_Temporelle
	    set couleur_reelle $Couleur_Transition_Temporelle
	}
	4 {

	    global Couleur_Transition_Sink
	    set couleur_reelle $Couleur_Transition_Sink
	}
	5 {

	    global Couleur_Transition_Selectionnee
	    set couleur_reelle $Couleur_Transition_Selectionnee
	}
    }
    return $couleur_reelle
}

proc Label_Colonne_Fired {chemin_transition} {

    if {$chemin_transition == ""} {
	return "0"
    }

    global Arbre_Vue_Tree

    set data_transition [$Arbre_Vue_Tree info data $chemin_transition]
    set nbr_fils [lindex [lindex $data_transition 2] 0]

    if {$nbr_fils == 0} {
	return "SINK"
    } else {
	set nbr_fils_generes 0
	set nbr_fils_generes_wait 0

	set liste_fils [$Arbre_Vue_Tree info children $chemin_transition]
	foreach chemin_fils $liste_fils {
	    set data_fils [lindex [$Arbre_Vue_Tree info data $chemin_fils] 0]
	    set type_fils [lindex $data_fils 1]
	    if {$type_fils == "N"} {
		incr nbr_fils_generes 1
	    } elseif {$type_fils == "T"} {
		incr nbr_fils_generes_wait 1
	    }
	}

	set Label_Fired "[expr $nbr_fils_generes]/[expr $nbr_fils]"
	if {$nbr_fils_generes_wait != 0} {
	    set Label_Fired "$Label_Fired + [subst $nbr_fils_generes_wait]xT"
	}
	return $Label_Fired
    }
}

proc Mettre_A_Jour_Couleur_Et_Texte_Transition {Numero_Vue Numero_Ligne_Transition Chemin_Transition} {

    global Fenetres_Affichage
    global Arbre_Vue_Tree

    set Label_Fired [Label_Colonne_Fired $Chemin_Transition]
    set Type_Transition [Lire_Type_Transition $Chemin_Transition]
    set couleur [Determiner_Numero_Couleur_Transition $Chemin_Transition]

    if {$Numero_Vue == 1} {

	Changer_Texte_Colonne_Vue_Msc \
		[Widget_Fired $Fenetres_Affichage.1] \
		$Numero_Ligne_Transition $Label_Fired

	set couleur_reelle [Generer_Couleur_Reelle $couleur]

	global global_info_temps
	if {$global_info_temps} {
	    Changer_Couleur_Colonne_Vue_Msc \
		    [Widget_Time $Fenetres_Affichage.1] \
		    $Numero_Ligne_Transition $couleur_reelle
	}

	Changer_Couleur_Colonne_Vue_Msc \
		[Widget_Main $Fenetres_Affichage.1] \
		$Numero_Ligne_Transition $couleur_reelle

	global Afficher_Colonne_Taches
	if {$Afficher_Colonne_Taches == 1} then {
	    Changer_Couleur_Colonne_Vue_Msc \
		    [Widget_Process $Fenetres_Affichage.1] \
		    $Numero_Ligne_Transition $couleur_reelle
	}
	    

	Changer_Couleur_Colonne_Vue_Msc \
		[Widget_Fired $Fenetres_Affichage.1] \
		$Numero_Ligne_Transition $couleur_reelle
    } elseif {$Numero_Vue == 2 || $Numero_Vue == 3} {

	set fen_fired_parent [Widget_Fired $Fenetres_Affichage.$Numero_Vue]
	$fen_fired_parent configure -state normal

	$fen_fired_parent delete "$Numero_Ligne_Transition.0 linestart" \
		"$Numero_Ligne_Transition.0 lineend"
	if {$Numero_Vue == 2} {
	   $fen_fired_parent insert $Numero_Ligne_Transition.0 "$Label_Fired\n"
	} else {
	   $fen_fired_parent insert $Numero_Ligne_Transition.0 "$Label_Fired"
	}
	
	$fen_fired_parent configure -state disabled
	    

	global global_info_temps
	if {$global_info_temps} {
	    set fen_time_parent [Widget_Time $Fenetres_Affichage.$Numero_Vue]
	    Ajouter_Tag_Et_Couleur_Ligne_Texte \
		    $fen_time_parent $Numero_Ligne_Transition $couleur
	}

	if {$Numero_Vue == 2} {

	    set fen_texte_parent [Widget_Main $Fenetres_Affichage.$Numero_Vue]
	    Ajouter_Tag_Et_Couleur_Ligne_Texte \
		    $fen_texte_parent $Numero_Ligne_Transition $couleur
	}

	global Afficher_Colonne_Taches
	if {$Afficher_Colonne_Taches == 1} then {
	    set fen_procs_parent [Widget_Process $Fenetres_Affichage.$Numero_Vue]
	    Ajouter_Tag_Et_Couleur_Ligne_Texte \
		    $fen_procs_parent $Numero_Ligne_Transition $couleur
	}
	    

	Ajouter_Tag_Et_Couleur_Ligne_Texte \
		$fen_fired_parent $Numero_Ligne_Transition $couleur
    }

}

proc Afficher_HighLight_Ligne {widget_colonne ligne couleur} {
    global anc_y

    if {[info exists anc_y($widget_colonne)]} then {
	$widget_colonne tag configure $widget_colonne.highlight -background {}
	$widget_colonne tag remove $widget_colonne.highlight $anc_y($widget_colonne) "$anc_y($widget_colonne) lineend"
    }
    $widget_colonne tag add $widget_colonne.highlight \
	    $ligne.0 "$ligne.0 lineend" 
    $widget_colonne tag configure $widget_colonne.highlight \
	    -background $couleur -relief flat

    set anc_y($widget_colonne) $ligne.0 
}

proc Afficher_HighLight_Position {type_view x y fenetre} { 
    global global_info_temps 
    global Couleur_Highlight

    if {$type_view == "MSC"} {
	set frame_texte $fenetre.1
	set fen_time [Widget_Fired $frame_texte]

	set pos [$fen_time index @0,$y]
	scan $pos "%d.%d" ligne colonne

    } elseif {$type_view == "TEXT"} {
	set frame_texte $fenetre.2
	set fen_texte [Widget_Main $frame_texte]

	set pos [$fen_texte index @0,$y]
	scan $pos "%d.%d" ligne colonne
  	Afficher_HighLight_Ligne $fen_texte $ligne $Couleur_Highlight
	
    } elseif {$type_view == "TREE"} {
	set frame_texte $fenetre.3
	set fen_time [Widget_Fired $frame_texte]

	set pos [$fen_time index @0,$y]
	scan $pos "%d.%d" ligne colonne

    } else {
	return
    }

    if {$global_info_temps} then {
	set fen_time [Widget_Time $frame_texte]
	Afficher_HighLight_Ligne $fen_time $ligne $Couleur_Highlight
    }

    global Afficher_Colonne_Taches
    if {$Afficher_Colonne_Taches == 1} then {
	set fen_proc [Widget_Process $frame_texte]
	Afficher_HighLight_Ligne $fen_proc $ligne $Couleur_Highlight
    }

    global Fenetres_Affichage
    if {$fenetre == $Fenetres_Affichage} then {
	set fen_fired [Widget_Fired $frame_texte]
	Afficher_HighLight_Ligne $fen_fired $ligne $Couleur_Highlight
    }

}

proc Eliminer_Highlight_Ligne {widget_colonne ligne} {

    $widget_colonne tag configure $widget_colonne.highlight -background {}
}

proc Eliminer_Highlight_Position {type_view x y fenetre} {
    global global_info_temps 

    if {$type_view == "MSC"} {
	set frame_texte $fenetre.1
	set fen_time [Widget_Fired $frame_texte]

	set pos [$fen_time index @0,$y]
	scan $pos "%d.%d" ligne colonne

    } elseif {$type_view == "TEXT"} {
	set frame_texte $fenetre.2
	set fen_texte [Widget_Main $frame_texte]

	set pos [$fen_texte index @0,$y]
	scan $pos "%d.%d" ligne colonne
	Eliminer_Highlight_Ligne $fen_texte $ligne
	
    } elseif {$type_view == "TREE"} {
	set frame_texte $fenetre.3
	set fen_time [Widget_Fired $frame_texte]

	set pos [$fen_time index @0,$y]
	scan $pos "%d.%d" ligne colonne

    } else {
	return
    }

    if {$global_info_temps} then {
	set fen_time [Widget_Time $frame_texte]
	Eliminer_Highlight_Ligne $fen_time $ligne
    }

    global Afficher_Colonne_Taches
    if {$Afficher_Colonne_Taches == 1} then {
	set fen_proc [Widget_Process $frame_texte]
	Eliminer_Highlight_Ligne $fen_proc $ligne
    }

    global Fenetres_Affichage
    if {$fenetre == $Fenetres_Affichage} then {
	set fen_fired [Widget_Fired $frame_texte]
	Eliminer_Highlight_Ligne $fen_fired $ligne
    }
}

proc affichage_selection_back {x y} {
  global Fenetres_Affichage  

  set frame_texte $Fenetres_Affichage.2
  set fen_texte [Widget_Main $frame_texte]

  set pos [$fen_texte index @0,$y]
  scan $pos "%d.%d" ligne colonne

  Effectuer_Retour_Arriere $ligne
}

proc msc_add_sink_block_state {w val y text} {
  global Ordonnees_X_Taches_Vues_Msc Msc_Vertical_Distance ystart 

  set start [expr [lindex $Ordonnees_X_Taches_Vues_Msc 0]-50]

  set end [expr [lindex $Ordonnees_X_Taches_Vues_Msc end]+50]

  set mean [expr ($start+$end)/2]

  set yreal [expr $Msc_Vertical_Distance*$y+$ystart]

  set ymin [expr $yreal-$Msc_Vertical_Distance]
  set ymax [expr $yreal+$Msc_Vertical_Distance]

  global Couleur_Transition_Sink
  global Couleur_Background_Transition_Sink
  $w create rectangle $start [expr $yreal-7] $end [expr $yreal+7] \
	  -fill $Couleur_Background_Transition_Sink -tags item_all
  $w create text $mean $yreal -text "$text" -fill $Couleur_Transition_Sink -tags item_all

}

proc affichage_sink_state {fenetre ligne} {
  global global_info_process

  Afficher_Transition_Vue_Texte $ligne "" "SINK STATE" "" "" \
	  4 $fenetre 
  if {$global_info_process} then {
    msc_add_sink_block_state [Widget_Main $fenetre.1] \
	    $fenetre $ligne "SINK STATE" 
  }
}

proc affichage_block_state {fenetre ligne} {
  global global_info_process

  Afficher_Transition_Vue_Texte $ligne "" "<BLOCK STATE>" "" "" 1 \
  			     $fenetre 
  if {$global_info_process} then {
    msc_add_sink_block_state [Widget_Main $fenetre.1] \
    		       $fenetre $ligne "BLOCK STATE" 
  }
}

proc msc_add_initial_state {fenetre label status_list couleur} {
    global global_nb_tache

    set l {}
    for {set i 0} {$i < $global_nb_tache} {incr i 1} {
	lappend l $i 
    }
    foreach {chgt etat nom} $status_list {
	set nom ""
    }
    Ajouter_Transition_Format_Msc_Fenetre $fenetre "0" 1 $l $label $status_list 0.000 $couleur
}

proc Initialiser_Et_Afficher_Etat_Initial_Arbre_Vue_Tree {tree_path} {
    global Arbre_Vue_Tree 
    global wait_tree_image
    global global_bg_color global_menu_bg_color
    global Transition_Courante_Vue_Tree
    global Font_Tree_Label
    global changement_transition
    global nbr_fils_etat_initial
    global Noms_Taches
    global Heure_Etat_Initial
    global Label_Etat_Initial

    set Commentaire_Transition $Label_Etat_Initial
    $Arbre_Vue_Tree add 0 -text $Commentaire_Transition \
	    -data "{{} {T} {$Label_Etat_Initial} Explored {$Noms_Taches} \
	    {$Heure_Etat_Initial}} \
	    {$changement_transition} {$nbr_fils_etat_initial}" \
	    -itemtype imagetext -image $wait_tree_image

    $Arbre_Vue_Tree configure -font $Font_Tree_Label

    set Transition_Courante_Vue_Tree 0

    global Fenetres_Affichage
    Afficher_Temps_Ecoule_Dans_Colonne_Time 1 0.000 3 $Fenetres_Affichage.3
    Afficher_Liste_Taches_Dans_Colonne_Tasks 1 $Noms_Taches 3 $Fenetres_Affichage.3
    Afficher_Informations_Mise_A_Feu 1 "0/$nbr_fils_etat_initial" 3 $Fenetres_Affichage.3

}

proc Affichage_Etat_Initial {} {
    global Fenetres_Affichage Numero_Transition_Courante global_info_process 
    global changement_transition
    global fenetres
    global global_nb_tache
    global Label_Etat_Initial

    set all_process 0
    for {set i 1} {$i < $global_nb_tache} {incr i 1} {
	set all_process "$all_process $i"
    }

    Initialiser_Et_Afficher_Etat_Initial_Arbre_Vue_Tree $fenetres(1.3.2)

    if {$global_info_process} then {
	msc_add_initial_state $Fenetres_Affichage\
		$Label_Etat_Initial $changement_transition 3
    }

    Afficher_Transition_Vue_Texte 1 "0" $Label_Etat_Initial $all_process "0.000" 3 \
	    $Fenetres_Affichage 

    set Numero_Transition_Courante 1
}

proc msc_del_ref {widget_colonne y} {
    global Msc_Vertical_Distance ystart

    set yreal [expr ($y-1)*$Msc_Vertical_Distance+$ystart -10 +$Msc_Vertical_Distance/2]
    set bb [$widget_colonne bbox item_all]
    set xmin [lindex $bb 0]
    set xmax [lindex $bb 2]
    set canvas_height [expr [lindex $bb 3]+$Msc_Vertical_Distance/2]
    foreach i [$widget_colonne find enclose $xmin $yreal $xmax $canvas_height] {
	$widget_colonne delete $i 
    } 

}

proc Effacer_Transition {fenetre ligne} {

    Effacer_Transition_Vue_Texte $fenetre $ligne
    Effacer_Transition_Vue_Msc $fenetre $ligne

}

proc Effacer_Transition_Vue_Msc {fenetre ligne} {
    global global_info_process

    if {$global_info_process} then {
	msc_del_ref [Widget_Main $fenetre.1] $ligne
	Realiser_Focus_Ligne_Courante_Vue_Msc $fenetre

	global global_info_temps
	if {$global_info_temps} then {
	    msc_del_ref [Widget_Time $fenetre.1] $ligne
	}
	global Afficher_Colonne_Taches
	if {$Afficher_Colonne_Taches == 1} then {
	    msc_del_ref [Widget_Process $fenetre.1] $ligne
	}
	global Fenetres_Affichage
	if {$fenetre == $Fenetres_Affichage} {
	    msc_del_ref [Widget_Fired $fenetre.1] $ligne
	}
    }

}

proc Effacer_Transition_Vue_Texte {fenetre ligne} {

    set frame_texte $fenetre.2
    set fen_texte [Widget_Main $frame_texte]

    Effacer_Ligne_Texte $fen_texte $ligne

    Effacer_Transition_Colonne_Time $fenetre.2 $ligne
    Effacer_Transition_Colonne_Tasks $fenetre.2 $ligne
    global Fenetres_Affichage
    if {$fenetre == $Fenetres_Affichage} {
	Effacer_Transition_Colonne_Fired $fenetre.2 $ligne
    }
}

proc Effacer_Transition_Colonne_Time {fenetre_vue ligne} {
    global global_info_temps 

    set fen_time [Widget_Time $fenetre_vue]
    if {$global_info_temps} then {

	Effacer_Ligne_Texte $fen_time $ligne
    }
}

proc Effacer_Transition_Colonne_Tasks {fenetre_vue ligne} {
    global Afficher_Colonne_Taches

    if {$Afficher_Colonne_Taches == 1} then {
	set fen_proc [Widget_Process $fenetre_vue]
	Effacer_Ligne_Texte $fen_proc $ligne
    }
}

proc Effacer_Transition_Colonne_Fired {fenetre_vue ligne} {

    set fen_fired [Widget_Fired $fenetre_vue]
    Effacer_Ligne_Texte $fen_fired $ligne
}

proc Effacer_Sequence_Transitions_Colonne_Time {fenetre_vue ligne1 ligne2} {
    global global_info_temps 

    set fen_time [Widget_Time $fenetre_vue]
    if {$global_info_temps} then {

	Effacer_Texte_Entre_Deux_Lignes $fen_time $ligne1 $ligne2
    }
}

proc Effacer_Sequence_Transitions_Colonne_Tasks {fenetre_vue ligne1 ligne2} {
    global Afficher_Colonne_Taches

    if {$Afficher_Colonne_Taches == 1} then {
	set fen_proc [Widget_Process $fenetre_vue]
	Effacer_Texte_Entre_Deux_Lignes $fen_proc $ligne1 $ligne2
    }
}

proc Effacer_Sequence_Transitions_Colonne_Fired {fenetre_vue ligne1 ligne2} {

    set fen_fired [Widget_Fired $fenetre_vue]
    Effacer_Texte_Entre_Deux_Lignes $fen_fired $ligne1 $ligne2
}

proc Realiser_Focus_Ligne_Texte {type_vue fenetre ligne} {
    global global_info_temps 
    global Fenetres_Affichage

    if {$type_vue == "TEXT"} {
	set frame_texte $fenetre.2

	set fen_texte [Widget_Main $frame_texte]

	$fen_texte see $ligne.0 
    } elseif {$type_vue == "TREE"} {
	set frame_texte $fenetre.3
    }

    if {$global_info_temps} then {
	set fen_time [Widget_Time $frame_texte]
	$fen_time see $ligne.0 
    }

    global Afficher_Colonne_Taches
    if {$Afficher_Colonne_Taches == 1} then {
	set fen_proc [Widget_Process $frame_texte]
	$fen_proc see $ligne.0 
    }

    if {$fenetre == $Fenetres_Affichage} then {
	set fen_fired [Widget_Fired $frame_texte]
	$fen_fired see $ligne.0 
    }

}

proc Effacer_Texte_Entre_Deux_Lignes {frame_texte ligne1 ligne2} {
    global Nombre_Tags_Par_Frame_Texte
    global Nombre_Lignes_Par_Frame_Texte 

    if {$frame_texte ==""} then {
	return -1
    } 
    $frame_texte configure -state normal

    for {set i $ligne1} {$i <= $ligne2} {incr i 1} {
	$frame_texte tag delete $frame_texte.$i.0 
    }

    $frame_texte delete $ligne1.0 [expr $ligne2 + 1].0

    $frame_texte configure -state  disabled
}

proc Extraire_Chemin_Noeud {num_node chaine_chemin} {

    set temp_chaine_chemin $chaine_chemin
    set temp_chaine_chemin [split $temp_chaine_chemin /]
    set chaine_path_courant ""
    set i 0
    while {$i < $num_node} {
	if {$i == 0} {
	    set chaine_path_courant "[lindex $temp_chaine_chemin $i]"
	} else {
	    set chaine_path_courant \
		    "$chaine_path_courant/[lindex $temp_chaine_chemin $i]"
	}
	incr i 1
    }
    return $chaine_path_courant
}
	

proc Afficher_Active_Path_Vue_Msc_Ou_Texte {Type_Vue} {
    global Fenetres_Affichage
    global Transition_Courante_Vue_Tree
    global Numero_Transition_Courante
    global Arbre_Vue_Tree
    global Initial_State_Changement_Transition 
    global changement_transition 
    global Chemin_Backward
    global global_info_rebouclage

    set Chemin_Backward ""

    .main configure -cursor watch

    if {$Type_Vue == "Msc"} {
	Effacer_Transition_Vue_Msc $Fenetres_Affichage 1
    } elseif {$Type_Vue == "Text"} {

	Effacer_Transition_Vue_Texte $Fenetres_Affichage 1  
    }

    set ancienne_transition_courante $Transition_Courante_Vue_Tree
    set ancien_numero_transition_courante $Numero_Transition_Courante

    set Numero_Transition_Courante 1

    while {$Numero_Transition_Courante <= $ancien_numero_transition_courante} {

	set temp_current_node_path \
		[eval "Extraire_Chemin_Noeud $Numero_Transition_Courante \
		$ancienne_transition_courante"]
	set temp_data_current_node [$Arbre_Vue_Tree info data $temp_current_node_path]
	set ligne_infos_noeud [lindex $temp_data_current_node 0]
	set ligne_infos_noeud_list_status [lindex $temp_data_current_node 1]
	set ligne_infos_transitions_tirees [lindex $temp_data_current_node 2]

	if {$Numero_Transition_Courante == 1} {
	    set changement_transition $Initial_State_Changement_Transition 
	} else {
	    set changement_transition "$ligne_infos_noeud_list_status"
	}

	set global_info_rebouclage [lindex $ligne_infos_noeud 6]

	if {$global_info_rebouclage != "" && $global_info_rebouclage != 0} then {
	    set porte "[lindex $ligne_infos_noeud 2] : Loopback \[Step $global_info_rebouclage\]"
	} else {
	    set porte [lindex $ligne_infos_noeud 2]
	}

	if {$Type_Vue == "Msc"} {
	    Charger_Transition_Vue_Msc $temp_current_node_path

	} elseif {$Type_Vue == "Text"} {
	    Charger_Transition_Vue_Texte  $temp_current_node_path 

	}

	incr Numero_Transition_Courante 1
    }

    incr Numero_Transition_Courante -1

    if {$Type_Vue == "Msc"} {
	Etablir_Bindings_Transition_Vue_Msc $Fenetres_Affichage \
		"Effectuer_Retour_Arriere"\
		"Afficher_Menu_Msc_Transition_Bouton_Droit \
		.popup_menu_main_texte \
		{$Fenetres_Affichage}" $Numero_Transition_Courante
    } elseif {$Type_Vue == "Text"} {
	Etablir_Bindings_Transition_Vue_Texte $Fenetres_Affichage \
		"affichage_selection_back"\
		"Afficher_Menu_Texte_Transition_Bouton_Droit \
		.popup_menu_main_texte\
		{$Fenetres_Affichage}" $Numero_Transition_Courante
    }

    Realiser_Focus_Ligne_Texte \
	    TEXT $Fenetres_Affichage $Numero_Transition_Courante

    .main configure -cursor left_ptr
}

proc Join {Directory File} {
   if {[string compare $Directory "/"] == 0} {

      return "/$File"
   } else {
      if {[string compare $File ".."] == 0} {
	return [file dirname $Directory]
      } else {
	return "$Directory/$File"
      }
   }
}

proc Justify_fullpath {fullpathlabel} {
   set font [$fullpathlabel cget -font]
   set text [$fullpathlabel cget -text]
   set labeltextwidth [font measure $font $text]
   set parentwidth [winfo width [winfo parent $fullpathlabel]]
   if {$labeltextwidth > $parentwidth} {

     $fullpathlabel configure -anchor e
   } else {

     $fullpathlabel configure -anchor center
   }
}

proc Bind_Click {Nom_Fenetre Listbox Fbox New_Item Directory_Change Nom_Bouton_Commande} {

    global Selected_Directory_Index
    global Selected_Directory_Name
    global Selected_File_Index
    global Selected_File_Name

    if [expr $Directory_Change == 1] then {
	set Selected_Directory_Index($Fbox) [$Listbox nearest $New_Item]
	set New_Directory [$Listbox get $Selected_Directory_Index($Fbox)]
	set Selected_Directory_Name($Fbox) [Join $Selected_Directory_Name($Fbox) $New_Directory]
	Refresh_Files_Listbox $Fbox
	set Selected_File_Index($Fbox) 0
	set Selected_File_Name($Fbox) ""
    } else {
	set Selected_File_Index($Fbox) [$Listbox nearest $New_Item]
	set Selected_File_Name($Fbox) [$Listbox get $Selected_File_Index($Fbox)]
    }

    set Base_Name [Extraire_Base_Name_Fichier $Selected_File_Name($Fbox)]

    [$Nom_Fenetre.frame.entree_fichier.entry subwidget entry] delete 0 end
    [$Nom_Fenetre.frame.entree_fichier.entry subwidget entry] insert 1 $Base_Name

    if {[winfo exists $Nom_Bouton_Commande]} {
	$Nom_Bouton_Commande configure -state normal
    }

}

proc Fill_List {Listbox Items_List} {

    $Listbox delete 0 [$Listbox size ] 
    foreach Item $Items_List {
	$Listbox insert [$Listbox size] $Item 
    }
}

proc List_Files {Path} {

    set Files {}
    foreach File [glob -nocomplain $Path] {
	if [expr [file isfile $File] && [file readable $File]] then {
	    lappend Files [file tail $File]
	}
    }
   return [lsort $Files]
}

proc Refresh_Files_Listbox {Files_Listbox} {

    global Filter
    global Selected_Directory_Name
    global Directory_Widget
    global File_Widget
    Fill_List $Directory_Widget($Files_Listbox) \
	    [List_Directories $Selected_Directory_Name($Files_Listbox)]
    Fill_List $File_Widget($Files_Listbox) \
	    [List_Files [Join $Selected_Directory_Name($Files_Listbox) $Filter($Files_Listbox)]]
}

proc List_Directories {Path} {

    if [string compare $Path /] then {
	set Dirs {..}
    } else {
	set Dirs {}
    }
    foreach Dir [glob -nocomplain [Join $Path *]] {
	if [expr [file isdirectory $Dir]  && [file readable $Dir]] then {
	    lappend Dirs [file tail $Dir]
	}
    }
    return [lsort $Dirs]
}

proc Ouvrir_Selection_Fichier {Nom_Fenetre Type_Fichiers Index_Fichier Nom_Bouton_Commande} {

    global global_menu_bg_color
    global Titre_Fenetres 
    global Font_Bold_9

    if {[winfo exists $Nom_Fenetre.frame]} then {
	set frame_princ $Nom_Fenetre.frame 
    } else {
	set frame_princ [frame $Nom_Fenetre.frame -bg $global_menu_bg_color]
	pack $frame_princ -side top -fill both -expand yes 
    }

    frame $frame_princ.framefiles -relief raised -borderwidth 1 -bg $global_menu_bg_color
    pack $frame_princ.framefiles -side top -fill both -expand yes 

    set Wind $Nom_Fenetre.frame.framefiles
    set Number 1

    label $Wind.fullpath -font $Font_Bold_9 -bg $global_menu_bg_color
    pack $Wind.fullpath -side top -fill x

    bind $Wind.fullpath <Map> [subst {Justify_fullpath $Wind.fullpath}]

    frame $Wind.frame[incr Number] -relief raised -borderwidth 1 -bg $global_menu_bg_color
    pack $Wind.frame$Number -side left -fill both -expand yes

    label $Wind.frame$Number.label -text "Directories" \
	    -font $Font_Bold_9 -bg $global_menu_bg_color
    pack $Wind.frame$Number.label -side top

    listbox $Wind.frame$Number.listbox \
	    -exportselection false \
	    -yscrollcommand "$Wind.frame$Number.scrollbar set" -font $Font_Bold_9 
    pack $Wind.frame$Number.listbox -side left -fill both -expand yes

    scrollbar $Wind.frame$Number.scrollbar -relief raised \
	    -command "$Wind.frame$Number.listbox yview" -bg $global_menu_bg_color
    pack $Wind.frame$Number.scrollbar -side right -fill y 

    global Directory_Widget
    global Selected_Directory_Index
    global Selected_Directory_Name

    set Directory_Widget($Index_Fichier) $Wind.frame$Number.listbox
    $Wind.frame$Number.listbox selection set 0
    set Selected_Directory_Index($Index_Fichier) 0

    if {![info exists Selected_Directory_Name($Index_Fichier)]} {
      set Selected_Directory_Name($Index_Fichier) "[pwd]"
    }

    set Selected_Directory_Name("Ancienne_Valeur") $Selected_Directory_Name($Index_Fichier)

    $Wind.fullpath configure -textvariable Selected_Directory_Name($Index_Fichier)

    bind $Wind.frame$Number.listbox  <1> \
	    [subst {Bind_Click $Nom_Fenetre %W $Index_Fichier %y 1 \
             $Nom_Bouton_Commande; Justify_fullpath $Wind.fullpath}]

    frame $Wind.frame[incr Number] -relief raised -borderwidth 1 -bg $global_menu_bg_color
    pack $Wind.frame$Number -side right -fill both -expand yes

    label $Wind.frame$Number.label -text "Files" \
	    -font $Font_Bold_9 -bg $global_menu_bg_color
    pack $Wind.frame$Number.label -side top 

    listbox $Wind.frame$Number.listbox \
	    -exportselection false \
	    -yscrollcommand "$Wind.frame$Number.scrollbar set" -font $Font_Bold_9  
    pack $Wind.frame$Number.listbox -side left -fill both -expand yes

    scrollbar $Wind.frame$Number.scrollbar -relief raised \
	    -command "$Wind.frame$Number.listbox yview" -bg $global_menu_bg_color
    pack $Wind.frame$Number.scrollbar -side right -fill y

    global File_Widget
    global Selected_File_Index
    global Selected_File_Name
    global Filter

    set File_Widget($Index_Fichier) $Wind.frame$Number.listbox
    $Wind.frame$Number.listbox selection set 0
    set Selected_File_Index($Index_Fichier) 0
    set Selected_File_Name($Index_Fichier) ""

    set Filter($Index_Fichier) $Type_Fichiers

    Refresh_Files_Listbox $Index_Fichier
    bind $Wind.frame$Number.listbox  <1> \
	    [subst {Bind_Click $Nom_Fenetre %W $Index_Fichier %y 0 $Nom_Bouton_Commande}]

    set entree_fichier [frame $frame_princ.entree_fichier -bg $global_menu_bg_color]
    label $entree_fichier.label -text "Selected file: " -font $Font_Bold_9 \
	    -bg $global_menu_bg_color 
    tixLabelEntry $entree_fichier.entry -bg $global_menu_bg_color
    [$entree_fichier.entry subwidget entry] configure -font $Font_Bold_9

    pack $entree_fichier  -side top -fill both -expand yes -padx 3 -pady 3
    pack $entree_fichier.label -side left -fill x
    pack $entree_fichier.entry -side left -expand yes -fill x 

    bind [$entree_fichier.entry subwidget entry] <Any-Key> \
	  [subst { 
	    if {\[winfo exists $Nom_Bouton_Commande\]} {          
	      $Nom_Bouton_Commande configure -state normal
	    }
	  }]

}

proc Ouvrir_Fenetre_Selection_Fichier {Nom_Fenetre Titre Type_Fichiers Label_Fonction Fonction_A_Executer Index_Fichier} {

    global global_menu_bg_color
    global Titre_Fenetres 
    global Fichier_A_Ete_Selectionne
    global Selection_Filebox_Width Selection_Filebox_Height
    global Font_Bold_9

    if {[winfo exists $Nom_Fenetre]} then {
	wm deiconify $Nom_Fenetre
	raise $Nom_Fenetre
	return -1
    } 

    ComputeRulesWinMain

    global Screen_Width Screen_Height Screen_X_Position Screen_Y_Position

    set Selection_Filebox_X_Pos [expr $Screen_X_Position + $Screen_Width /2 - $Selection_Filebox_Width /2]
    set Selection_Filebox_Y_Pos [expr $Screen_Y_Position + $Screen_Height /2 - $Selection_Filebox_Height /2]

    toplevel $Nom_Fenetre
    wm geometry $Nom_Fenetre ${Selection_Filebox_Width}x${Selection_Filebox_Height}+${Selection_Filebox_X_Pos}+${Selection_Filebox_Y_Pos}
    wm title $Nom_Fenetre "$Titre_Fenetres ... $Titre"
    bind $Nom_Fenetre <Enter> "raise $Nom_Fenetre"
    bind $Nom_Fenetre <FocusOut> "raise $Nom_Fenetre"
    bind $Nom_Fenetre <Configure> ComputeRulesSelectionFilebox
    focus $Nom_Fenetre
    grab $Nom_Fenetre

    set frame_princ [frame $Nom_Fenetre.frame -bg $global_menu_bg_color]
    pack $frame_princ -side top -fill both -expand yes 

    set frame_label [frame $frame_princ.label -bg $global_menu_bg_color]
    label $frame_label.label -text $Titre -font $Font_Bold_9 -bg $global_menu_bg_color
    pack $frame_label -side top -fill both -expand yes -padx 3 -pady 3 
    pack $frame_label.label  -side top 

    Ouvrir_Selection_Fichier $Nom_Fenetre $Type_Fichiers $Index_Fichier $frame_princ.buttons.frame.command

    tixLabelFrame $frame_princ.buttons -labelside none -bg $global_menu_bg_color
    [$frame_princ.buttons subwidget frame] configure -bg $global_menu_bg_color

    set frame_buttons [$frame_princ.buttons subwidget frame]

    button $frame_buttons.command -text $Label_Fonction -font $Font_Bold_9 \
	    -command [subst {if {\[Lire_Nom_Fichier $Nom_Fenetre $Index_Fichier \
	    $Nom_Fenetre.frame.buttons.frame.command\] != ""} {grab release $Nom_Fenetre ; \
	    destroy $Nom_Fenetre; set Fichier_A_Ete_Selectionne 1 ; \
	    $Fonction_A_Executer $Index_Fichier}}] \
	    -bg $global_menu_bg_color -highlightcolor $global_menu_bg_color \
	    -highlightbackground $global_menu_bg_color 

    button $frame_buttons.cancel -text "Cancel" -font $Font_Bold_9 \
	    -command [subst {set Selected_Directory_Name($Index_Fichier) \
            \$Selected_Directory_Name("Ancienne_Valeur"); \
            grab release $Nom_Fenetre ; destroy $Nom_Fenetre ; \
	    set Fichier_A_Ete_Selectionne 2}] \
	    -bg $global_menu_bg_color -highlightcolor $global_menu_bg_color \
	    -highlightbackground $global_menu_bg_color

    pack $frame_princ.buttons -side bottom -fill x -expand yes -padx 3 -pady 3 
    pack $frame_buttons.command -side left -expand yes -fill x -padx 5 -pady 5 
    pack $frame_buttons.cancel -side left -expand yes -fill x -padx 5 -pady 5 
}

proc Lire_Nom_Fichier {Nom_Fenetre Index_Fichier Nom_Bouton_Commande} {

    global Selected_File_Name
    global Selected_Directory_Name

    set fichier "[[$Nom_Fenetre.frame.entree_fichier.entry subwidget entry] get]"
    if {$fichier == ""} {

	return ""
    }

    set directory_name $Selected_Directory_Name($Index_Fichier)
    if {$directory_name == ""} {

	Afficher_Message_Erreur "Command \"dirname $Selected_File_Name($Index_Fichier)\" failed" {}
	return 
    }

    set Selected_File_Name($Index_Fichier) $fichier
    return [Join $directory_name $fichier]

}

proc Reactualiser_Profondeur_Exhibitor_Format_Texte {Depth_Widget Depth_Value} {

    $Depth_Widget.frame_entry_scale.entry delete 0 end
    $Depth_Widget.frame_entry_scale.entry insert 1 $Depth_Value

}

proc Lire_Profondeur_Exhibitor_Sur_Entry {Depth_Widget} {
    global Value_Exhibitor_Scale

    if [catch {set Depth_Value [$Depth_Widget.frame_entry_scale.entry get]} \
	    resultat_get] {
	Afficher_Message_Erreur "Irregular value of depth" {}
	return -1
    } elseif [catch {set temp [expr $Depth_Value + 0.0]} resultat_expr] {

	Afficher_Message_Erreur "Value of depth $Depth_Value\nis not real" {}
	return -1
    } elseif {$Depth_Value < 0.0} {
	Afficher_Message_Erreur "Value of depth $Depth_Value\nis negative" {}
	return -1
    }

    set Value_Exhibitor_Scale $Depth_Value
    $Depth_Widget.frame_entry_scale.scale set $Value_Exhibitor_Scale

    return $Depth_Value
}

proc Creer_Et_Ouvrir_Fenetre_Exhibitor {} {
    global Exhibitor_Exploration_Mode Exhibitor_Strategy 
    global Exhibitor_Case_Sensitive Exhibitor_Starting_State 
    global Numero_Transition_Courante 
    global global_menu_bg_color global_bg_color
    global Width_Win_Exhibitor Height_Win_Exhibitor 
    global Win_Exhibitor_X_Position Win_Exhibitor_Y_Position
    global Exhibitor_Depth_Search
    global Exhibitor_File_Result
    global Exhibitor_Text_Input_Sequence
    global Exhibitor_File_Input_Sequence
    global Exhibitor_Width_Label
    global Exhibitor_Check_Text_Input_Sequence
    global Titre_Fenetres
    global Selected_File_Name
    global Value_Exhibitor_Scale
    global Foreground_Windows
    global Font_Bold_9 Font_Bold_12

    if {[winfo exists .fenetre_exhibitor]} then {
	wm deiconify .fenetre_exhibitor
	raise .fenetre_exhibitor
	return -1
    } 

  toplevel .fenetre_exhibitor
  wm geometry .fenetre_exhibitor ${Width_Win_Exhibitor}x${Height_Win_Exhibitor}+${Win_Exhibitor_X_Position}+${Win_Exhibitor_Y_Position}
  bind .fenetre_exhibitor <Configure> ComputeRulesWinExhibitor

  if {$Foreground_Windows == 1} {
      bind .fenetre_exhibitor <Enter> "raise .fenetre_exhibitor"
  }

  wm title .fenetre_exhibitor "$Titre_Fenetres ... Exhibitor options"

  frame .fenetre_exhibitor.frame -bg $global_menu_bg_color 

  bind .fenetre_exhibitor <Control-c> "destroy .fenetre_exhibitor"
				    
  set frame_princ .fenetre_exhibitor.frame
  $frame_princ configure -bg $global_menu_bg_color \
	  -highlightcolor $global_menu_bg_color -highlightbackground $global_menu_bg_color

  pack $frame_princ -side top -expand yes -fill both

  set frame_label [frame $frame_princ.label -bg $global_menu_bg_color]
  label $frame_label.label -text "Exhibitor options" -font $Font_Bold_12 -bg $global_menu_bg_color
  pack $frame_label -side top -fill both -expand yes -padx 3 -pady 3 
  pack $frame_label.label  -side top 

  label $frame_label.label2 -text "File containing the searched sequence" \
	  -font $Font_Bold_9 -bg $global_menu_bg_color
  pack $frame_label.label2  -side top 

  Ouvrir_Selection_Fichier .fenetre_exhibitor *.seq Fichier_Sequence_Exhibitor\
	  $frame_princ.cmd.frame.forward 

  set frame_input_sequence [frame $frame_princ.input_sequence \
	  -bg $global_menu_bg_color]
	
  $frame_input_sequence configure -borderwidth 1 -relief raised
  checkbutton $frame_input_sequence.check_button \
	  -text "Input sequence:"\
	  -font $Font_Bold_9 \
	  -onvalue 1 -offvalue 0 -variable Exhibitor_Check_Text_Input_Sequence\
	  -bg $global_menu_bg_color -highlightcolor $global_menu_bg_color\
	  -highlightbackground $global_menu_bg_color

  entry $frame_input_sequence.entry -relief sunken -font $Font_Bold_9

  pack $frame_input_sequence -side top -fill x -expand yes
  pack $frame_input_sequence.check_button -side left -padx 3
  pack $frame_input_sequence.entry -side left -fill x -expand yes

  set frame_expl_mode [frame $frame_princ.expl_mode -bg $global_menu_bg_color]
  $frame_expl_mode configure -borderwidth 1 -relief raised
  label $frame_expl_mode.label -text "Search algorithms" -font $Font_Bold_9 \
	  -bg $global_menu_bg_color
  radiobutton $frame_expl_mode.bfs -text "Breadth first search" -font $Font_Bold_9 \
	  -value 1 -variable Exhibitor_Exploration_Mode\
	  -bg $global_menu_bg_color -highlightcolor $global_menu_bg_color\
	  -highlightbackground $global_menu_bg_color
  radiobutton $frame_expl_mode.dfs -text "Depth first search" -font $Font_Bold_9 \
	  -value 0 -variable Exhibitor_Exploration_Mode\
	  -bg $global_menu_bg_color -highlightcolor $global_menu_bg_color\
	  -highlightbackground $global_menu_bg_color 

  set frame_depth [frame $frame_princ.depth -bg $global_menu_bg_color]
  $frame_depth configure -borderwidth 1 -relief raised
  label $frame_depth.label -text "Maximal depth (0 means infinity):" \
	  -font $Font_Bold_9 -bg $global_menu_bg_color -width 30

  frame $frame_depth.frame_entry_scale -bg $global_menu_bg_color
  scale $frame_depth.frame_entry_scale.scale -from 0 -to 100000 -length 400 \
	  -variable Value_Exhibitor_Scale \
	  -orient horizontal -font $Font_Bold_9  \
	  -bg $global_menu_bg_color \
	  -borderwidth 0 -troughcolor white -showvalue 0\
	  -command [subst {Reactualiser_Profondeur_Exhibitor_Format_Texte $frame_depth}] 
  entry $frame_depth.frame_entry_scale.entry -background $global_bg_color \
	  -font $Font_Bold_9 

  set frame_case [frame $frame_princ.case -bg $global_menu_bg_color]
  $frame_case configure -borderwidth 1 -relief raised
  checkbutton $frame_case.case_sens -text "Differentiate lower/upper case"\
	  -font $Font_Bold_9 \
	  -onvalue 1 -offvalue 0 -variable Exhibitor_Case_Sensitive\
	  -bg $global_menu_bg_color -highlightcolor $global_menu_bg_color\
	  -highlightbackground $global_menu_bg_color

  set frame_conflict [frame $frame_princ.conflict -bg $global_menu_bg_color]
  $frame_conflict configure -borderwidth 1 -relief raised
  checkbutton $frame_conflict.conflict -text "Detect conflict" \
	  -font $Font_Bold_9 \
	  -onvalue 1 -offvalue 0 -variable Exhibitor_Conflict\
	  -bg $global_menu_bg_color -highlightcolor $global_menu_bg_color\
	  -highlightbackground $global_menu_bg_color

  set frame_start [frame $frame_princ.start -bg $global_menu_bg_color]
  $frame_start configure -borderwidth 1 -relief raised
  label $frame_start.label -text "Starting state" -font $Font_Bold_9 \
	  -bg $global_menu_bg_color 
  radiobutton $frame_start.init -text "Initial State" -value 0 \
	  -font $Font_Bold_9 \
	  -variable Exhibitor_Starting_State \
	  -bg $global_menu_bg_color -highlightcolor $global_menu_bg_color\
	  -highlightbackground $global_menu_bg_color
  radiobutton $frame_start.step -text "Current state" -value 1 \
	  -font $Font_Bold_9 \
	  -variable Exhibitor_Starting_State\
	  -bg $global_menu_bg_color -highlightcolor $global_menu_bg_color\
	  -highlightbackground $global_menu_bg_color

  set frame_str [frame $frame_princ.str -bg $global_menu_bg_color]
  $frame_str configure -borderwidth 1 -relief raised
  label $frame_str.label -text "Selected sequence(s)" \
	  -font $Font_Bold_9 \
	  -bg $global_menu_bg_color
  radiobutton $frame_str.first -text "First sequence" \
	  -font $Font_Bold_9 \
	  -value 0 -variable Exhibitor_Strategy\
	  -bg $global_menu_bg_color -highlightcolor $global_menu_bg_color\
	  -highlightbackground $global_menu_bg_color
  radiobutton $frame_str.all -text "All sequences" -font $Font_Bold_9 \
	  -value 1 -variable Exhibitor_Strategy\
	  -bg $global_menu_bg_color -highlightcolor $global_menu_bg_color\
	  -highlightbackground $global_menu_bg_color
	

  set frame_output [frame $frame_princ.output -bg $global_menu_bg_color]
  $frame_output configure -borderwidth 1 -relief raised
  label $frame_output.label -text "Diagnostic output file: " \
	  -font $Font_Bold_9 -bg $global_menu_bg_color
  entry $frame_output.entry -relief sunken -font $Font_Bold_9

  tixLabelFrame $frame_princ.cmd -labelside none -bg $global_menu_bg_color
  [$frame_princ.cmd subwidget frame] configure -bg $global_menu_bg_color

  set frame_button [$frame_princ.cmd subwidget frame]
  button $frame_button.forward -text "OK" -font $Font_Bold_9 \
	  -command Executer_Exhibitor -bg $global_menu_bg_color
  button $frame_button.cancel -text "Cancel" -font $Font_Bold_9 \
	  -command "destroy .fenetre_exhibitor" -bg $global_menu_bg_color
  button $frame_button.abort -text "Abort" -font $Font_Bold_9 \
	  -command "destroy .fenetre_exhibitor" -foreground red -bg $global_menu_bg_color

  pack $frame_princ.cmd -side bottom -fill both -expand yes -padx 3 -pady 3 

  pack $frame_expl_mode -side top -fill both -expand yes
  pack $frame_expl_mode.label -side top 
  pack $frame_expl_mode.bfs -side left 
  pack $frame_expl_mode.dfs -side right 

  pack $frame_depth -side top -fill x -expand yes
  pack $frame_depth.label -side left -padx 6
  pack $frame_depth.frame_entry_scale -side left -fill x -expand yes  
  pack $frame_depth.frame_entry_scale.entry -side top -fill x -expand yes -padx 3
  pack $frame_depth.frame_entry_scale.scale -side bottom -fill x -expand yes -padx 3

  pack $frame_case -side top -fill both -expand yes
  pack $frame_case.case_sens -side left 

  pack $frame_conflict -side top -fill both -expand yes
  pack $frame_conflict.conflict -side left 

  pack $frame_start -side top -fill both -expand yes
  pack $frame_start.label -side top
  pack $frame_start.init -side left
  pack $frame_start.step -side right

  pack $frame_str -side top -fill both -expand yes
  pack $frame_str.label -side top
  pack $frame_str.first -side left
  pack $frame_str.all -side right

  pack $frame_output -side top -fill x -expand yes
  pack $frame_output.label -side left -padx 6
  pack $frame_output.entry -side left -fill x -expand yes

  pack $frame_button.forward $frame_button.cancel \
	  -side left  -expand yes -fill x -padx 5 -pady 5 

  if {([info exists Exhibitor_File_Input_Sequence]) && ($Exhibitor_File_Input_Sequence != "")} {
      [.fenetre_exhibitor.frame.entree_fichier.entry subwidget entry] \
	      delete 0 end
      [.fenetre_exhibitor.frame.entree_fichier.entry subwidget entry] \
	      insert 1 [Extraire_Base_Name_Fichier $Exhibitor_File_Input_Sequence]

      set Selected_File_Name(Fichier_Sequence_Exhibitor) \
	      [Extraire_Base_Name_Fichier $Exhibitor_File_Input_Sequence]

      $frame_button.forward configure -state normal
  }

  if {[info exists Exhibitor_Text_Input_Sequence]} {
      $frame_input_sequence.entry delete 0 end
      $frame_input_sequence.entry insert 1 "$Exhibitor_Text_Input_Sequence"
  }

  if {$Exhibitor_Exploration_Mode == 1} {
      $frame_expl_mode.bfs invoke 
  } else {
      $frame_expl_mode.dfs invoke
  }

  if {$Exhibitor_Starting_State == 1} {
      $frame_start.step invoke
  } else {
      $frame_start.init invoke 
  }

  $frame_depth.frame_entry_scale.scale set $Exhibitor_Depth_Search

  if {[info exists Exhibitor_File_Result]} {
      $frame_output.entry delete 0 end
      $frame_output.entry insert 1 $Exhibitor_File_Result
  }

  if {$Exhibitor_Strategy == 1} {
      $frame_str.all invoke
  } else {
      $frame_str.first invoke 
  }
}

proc Executer_Exhibitor {} {
    global Exhibitor_Exploration_Mode 
    global Exhibitor_Case_Sensitive Exhibitor_Starting_State
    global Exhibitor_Conflict Exhibitor_Strategy seqno env
    global fenetres Numero_Transition_Courante 
    global Pref_Main_Win_Type
    global w_pane_top
    global Exhibitor_Depth_Search
    global Exhibitor_File_Result
    global Exhibitor_Text_Input_Sequence
    global Exhibitor_File_Input_Sequence
    global Exhibitor_Check_Text_Input_Sequence
    global ocis_temporary_exhibitor_output_log 
    global ocis_temporary_exhibitor_output_seq
    global Value_Exhibitor_Scale
    global Selected_File_Name

    focus .fenetre_exhibitor
    grab .fenetre_exhibitor

    set frame_princ .fenetre_exhibitor.frame 
    set frame_output $frame_princ.output

    if {$Exhibitor_Check_Text_Input_Sequence} {

	set input_file $ocis_temporary_exhibitor_output_seq
	
	if {[catch {open $input_file "w"} id] == 1} {
	    Afficher_Message_Erreur "Temporary file \"$input_file\" unwritable" {}
	    return 
	}
	set Exhibitor_Text_Input_Sequence "[$frame_princ.input_sequence.entry get]"
	if {$Exhibitor_Text_Input_Sequence != ""} {
	    puts $id $Exhibitor_Text_Input_Sequence
	} else {
	    puts $id " "
	}
	close $id
    } else {

	set Exhibitor_File_Input_Sequence \
		[eval Lire_Nom_Fichier .fenetre_exhibitor Fichier_Sequence_Exhibitor \
		$frame_princ.cmd.frame.forward ]

	if {$Exhibitor_File_Input_Sequence != ""} {
	    set input_file $Exhibitor_File_Input_Sequence
	} else {
	    set Selected_File_Name(Fichier_Sequence_Exhibitor) ""
	    return
	}
    }

    set Exhibitor_Depth_Search [eval Lire_Profondeur_Exhibitor_Sur_Entry $frame_princ.depth]

    if {$Exhibitor_Depth_Search < 0} {
	return
    }

    set seqno 1

    if {$Exhibitor_Starting_State == 1} then {
	set back 0
    } else {

	set back [expr $Numero_Transition_Courante - 1]
    }

    set Exhibitor_File_Result "[$frame_output.entry get]" 
    if {$Exhibitor_File_Result == ""} {
	set Exhibitor_File_Result $ocis_temporary_exhibitor_output_log
    }

    if {[catch {open $input_file r} fichier_id] == 0} then {
	close $fichier_id

	global Transition_Courante_Vue_Tree
	set Ancien_Active_Path $Transition_Courante_Vue_Tree

	.fenetre_exhibitor configure -cursor watch
	.main configure -cursor watch
	[$frame_princ.cmd subwidget frame].forward configure -state disabled
	[$frame_princ.cmd subwidget frame].cancel configure -state disabled

	Activer_Desactiver_Boutons_Et_Bindings_Souris_Autres_fenetres 0

	update

	Envoi_Message "exhibitor $input_file $back $Exhibitor_Case_Sensitive \
		$Exhibitor_Exploration_Mode $Exhibitor_Depth_Search \
		$Exhibitor_Strategy $Exhibitor_Conflict \
		$seqno $Exhibitor_File_Result"

	Lire_Reponse
	update

	global Arbre_Vue_Tree
	if {[$Arbre_Vue_Tree info exists $Ancien_Active_Path]} {
	    Effectuer_Goto_Vue_Tree $Ancien_Active_Path
	}

	Recuperer_Information_Backcode Historique

    } else {
	Afficher_Message_Erreur "$input_file: No such exhibitor sequence file" {}
    }

    .fenetre_exhibitor configure -cursor left_ptr
    .main configure -cursor left_ptr
    [$frame_princ.cmd subwidget frame].forward configure -state normal
    [$frame_princ.cmd subwidget frame].cancel configure -state normal

    Activer_Desactiver_Boutons_Et_Bindings_Souris_Autres_fenetres 1

    set Pref_Main_Win_Type 3
    $w_pane_top.note raise $Pref_Main_Win_Type

    grab release .fenetre_exhibitor
}

proc Msc_Impression_Ajouter_Page {id x y c numero} {
    global ocis_other_temporary_postscript

    $c postscript -file $ocis_other_temporary_postscript -pageheight 25c \
	    -pagewidth 18c -height 990 -width 700 -x $x -y $y

    Msc_Impression_Extraire_Page $ocis_other_temporary_postscript $id $numero
}

proc Msc_Impression_Creer_Entete {c fichier nb_page x y} {
    global ocis_other_temporary_postscript

    $c postscript -file $ocis_other_temporary_postscript -pageheight 25c \
	    -pagewidth 18c -height 990 -width 700 -x $x -y $y
    return [Msc_Impression_Extraire_Entete_Fichier $ocis_other_temporary_postscript \
	    $fichier $nb_page]
}

proc Msc_Impression_Creer_Fichier {c tag fichier} {

    set region [$c bbox $tag]

    set x_origine [lindex $region 0]
    set y_origine [lindex $region 1]
    set hauteur [expr [lindex $region 3] - [lindex $region 1]]
    set largeur [expr [lindex $region 2] - [lindex $region 0]]
    set hauteur_page 990 
    set largeur_page 700
    set nb_page_y [expr $hauteur/$hauteur_page+1]
    set nb_page_x [expr $largeur/$largeur_page+1]
    set nb_page [expr $nb_page_x * $nb_page_y]

    set id [Msc_Impression_Creer_Entete $c $fichier $nb_page $x_origine $y_origine]

    for {set i 0} {$i < $nb_page_y} {incr i 1} {
	for {set j 0} {$j < $nb_page_x} {incr j 1} {
	    Msc_Impression_Ajouter_Page $id \
		    [expr $j * $largeur_page+$x_origine]\
		    [expr $i * $hauteur_page+$y_origine]\
		    $c [expr $i*$nb_page_x+1+$j]
	}
    }

    puts $id "%%Trailer\nend\n%%EOF"
    flush $id
    close $id
}

proc Msc_Impression_Extraire_Entete_Fichier {fichier_source fichier_dest nb_page} {

    if [catch {open "$fichier_source" "r"} id_source] then {
	Afficher_Message_Erreur "File $fichier_source unreadable" {}
	return 
    }

    if [catch {open "$fichier_dest" "w"} id_dest] then {
	Afficher_Message_Erreur "File $fichier_dest unwritable" {}
	return 
    }

    while {[eof $id_source] == 0} {
	gets $id_source ligne

	if {$ligne == "%%Pages: 1"} then {
	    puts $id_dest "%%Pages: $nb_page"
	    gets $id_source ligne
	}

	if {$ligne == "%%Page: 1 1"} {
	    break 
	}
	puts $id_dest $ligne
    }
    close $id_source
    flush $id_dest
    return $id_dest
}

proc Msc_Impression_Extraire_Page {fichier_source id_cible num_page} {

    if [catch {open "$fichier_source" "r"} id_source] then {
	Afficher_Message_Erreur "File $fichier_source unreadable" {}
	return 
    }

    while {[eof $id_source] == 0} {
	gets $id_source ligne
	if {$ligne == "%%Page: 1 1"} then {

	    break
	}
    }

    puts $id_cible "%%Page: $num_page $num_page"

    while {[eof $id_source] == 0} {
	gets $id_source ligne
	if {$ligne == "restore showpage"} then {

	    break
	}
	puts $id_cible $ligne
    }
    close $id_source
    puts $id_cible "gsave\n\n/Courier findfont 10 scalefont ISOEncode setfont\n\
	    0.000 0.000 0.000 setrgbcolor AdjustColor\n\
	    750 980 \[\n($num_page)\n\] 17 -0 0 0 false DrawText\ngrestore\n\
	    restore showpage"
    flush $id_cible
}
proc Activer_Desactiver_Boutons_Et_Bindings_Souris_Autres_fenetres {activer} {
    global w_hist w_trans

    global Note_Book_Path Note_Book_Trans
    global Note_Book_Path_Msc Note_Book_Path_Text Note_Book_Path_Tree 
    global Note_Book_Trans_Msc Note_Book_Trans_Text Note_Book_Trans_Wait 

    if {$activer == 1} {

	.main.frame.scenario configure -state normal
	.main.frame.edit configure -state normal
	.main.frame.run configure -state normal
	.main.frame.backcode configure -state normal
	.main.frame.simulation_options configure -state normal
	.main.frame.new_functions configure -state normal
	

	.main.top.buttons.new configure -state normal
	.main.top.buttons.load configure -state normal
	.main.top.buttons.save configure -state normal
	.main.top.buttons.back configure -state normal
	.main.top.buttons.forward configure -state normal
	.main.top.buttons.reset configure -state normal
	.main.top.buttons.ap_print configure -state normal
	.main.top.buttons.print configure -state normal
	.main.top.buttons.recompile configure -state normal
	.main.top.buttons.edit configure -state normal

	.main.top.buttons.exhibitor configure -state normal

	 if {[winfo exists .fenetre_exhibitor]} then {
	     .fenetre_exhibitor.frame.cmd.frame.forward configure -state normal
	 }

    } else {
	.main.frame.scenario configure -state disabled
	.main.frame.edit configure -state disabled
	.main.frame.run configure -state disabled
	.main.frame.backcode configure -state disabled
	.main.frame.simulation_options configure -state disabled
	.main.frame.new_functions configure -state disabled

	.main.top.buttons.new configure -state disabled
	.main.top.buttons.load configure -state disabled
	.main.top.buttons.save configure -state disabled
	.main.top.buttons.back configure -state disabled
	.main.top.buttons.forward configure -state disabled
	.main.top.buttons.reset configure -state disabled
	.main.top.buttons.ap_print configure -state disabled
	.main.top.buttons.print configure -state disabled
	.main.top.buttons.recompile configure -state disabled
	.main.top.buttons.edit configure -state disabled

	.main.top.buttons.exhibitor configure -state disabled 

	 if {[winfo exists .fenetre_exhibitor]} then {
	     .fenetre_exhibitor.frame.cmd.frame.forward configure -state disabled
	 }

	 set tab_1 [$Note_Book_Path subwidget 1]
	 set tab_1 [$Note_Book_Path subwidget 2]
	 set tab_1 [$Note_Book_Path subwidget 3]

    }	
}

proc Preparer_Recompilation {} {
    global Compile_Mode

    set Compile_Mode 1

    Activer_Desactiver_Boutons_Et_Bindings_Souris_Autres_fenetres 0

    set frame_princ .fenetre_compilation.frame

    $frame_princ.buttons.frame.compile configure -state disabled 
    $frame_princ.buttons.frame.clear configure -state  disabled
    $frame_princ.buttons.frame.close configure -state  disabled

    $frame_princ configure -cursor watch
    set texte [$frame_princ.texte subwidget text]
    $texte configure -cursor watch
    .main configure -cursor watch
}

proc Executer_Processus_Recompilation {} {
    global env
    global channel_recompile
    global Font_Texte_Fenetre_Recompilation
    global Compile_Mode
    global channel_id
    global DEBUG_MODE_PROTOCOL
    global DEBUG_MODE_RECOMPILE

    if {$DEBUG_MODE_RECOMPILE == 1} {
	puts stdout "envoi de la commande $env(OCIS_RESTART_COMMAND)"
    }
    if [catch {open "|$env(OCIS_RESTART_COMMAND)" "r"} channel_recompile] then {

	protocol_signal_failure 02 ""
    }
    if {$DEBUG_MODE_PROTOCOL == 1} {
	puts stdout "pipe de recompilation (channel_recompile): $channel_recompile"
    }

    if {$DEBUG_MODE_RECOMPILE == 1} {
	puts stdout "apres l'envoi de la commande ..."
    }

    set frame_princ .fenetre_compilation.frame

    set texte [$frame_princ.texte subwidget text]
    while {[eof $channel_recompile] == 0} {
	update
	set ligne [gets $channel_recompile]
	$texte insert end "$ligne\n"
	$texte configure -font $Font_Texte_Fenetre_Recompilation
	$texte see end
    }

    $frame_princ.buttons.frame.compile configure -state normal
    $frame_princ.buttons.frame.clear configure -state normal
    $frame_princ.buttons.frame.close configure -state normal

}

proc Terminer_Recompilation {} {
    global channel_recompile
    global Compile_Mode

    set frame_princ .fenetre_compilation.frame
    set texte [$frame_princ.texte subwidget text]
    $frame_princ configure -cursor left_ptr
    $texte configure -cursor xterm
    .main configure -cursor left_ptr

    Activer_Desactiver_Boutons_Et_Bindings_Souris_Autres_fenetres 1

    set Compile_Mode 0
}

proc Executer_Recompilation {} {
    global env channel_id
    global Numero_Transition_Courante
    global ocis_temporary_bcg_file
    global ocis_temporary_o_file
    global Transition_Courante_Vue_Tree
    global Pref_Main_Win_Type
    global Loopback_Option
    global Ouverture_Fichier_Reussie
    global Fenetres_Affichage Fenetres_Transition
    global Transition_Courante_Vue_Tree 
    global DEBUG_MODE_RECOMPILE

    focus .fenetre_compilation
    grab .fenetre_compilation

    Preparer_Recompilation

    set Ancien_Active_Path $Transition_Courante_Vue_Tree

    Envoi_Message "save $ocis_temporary_bcg_file"

    Lire_Reponse 

    if {[catch {open $ocis_temporary_bcg_file r} fichier_id] == 0} then {
	close $fichier_id
    } else {

	Afficher_Message_Erreur "error in saving the current \
		scenario\ntry to compile your source code later" {}
	Terminer_Recompilation
	return
    } 

    Envoi_Message "quit"

    close $channel_id

    Executer_Processus_Recompilation

    if {$DEBUG_MODE_RECOMPILE == 1} {
	puts stdout "avant le la creation d'un nouveau processus ocis: \
		$env(OCIS_START_COMMAND)"
    }
    if [catch {open "|$env(OCIS_START_COMMAND)" "r+"} channel_id] then {

	protocol_signal_failure 01 ""
    }
    if {$DEBUG_MODE_RECOMPILE == 1} {
	puts stdout "nouveau pipe apres la recompilation (channel_id): \
		$channel_id"
	puts stdout "apres la creation d'un nouveau processus ocis: \
		$env(OCIS_START_COMMAND)"
    }

    Reset_Scenario 0

    Envoi_Message "set_loopback $Loopback_Option"

    set Numero_Transition_Courante 1

    global Mode_Lecture_Fichier
    set Mode_Lecture_Fichier 1

    Envoi_Message "load $ocis_temporary_bcg_file"

    Lire_Reponse

    update
    if {$Ouverture_Fichier_Reussie == "1"} {

	Effacer_Transition $Fenetres_Transition 1

	Lire_Reponse

	Lire_Reponse

	set Numero_Transition_Courante 1
	set Transition_Courante_Vue_Tree 0

	global Arbre_Vue_Tree
	if {[$Arbre_Vue_Tree info exists $Ancien_Active_Path]} {
	    Effectuer_Goto_Vue_Tree $Ancien_Active_Path
	}
    }

    set Mode_Lecture_Fichier 0
    set Ouverture_Fichier_Reussie 1

    if {$Pref_Main_Win_Type == 1} {
	Afficher_Active_Path_Vue_Msc_Ou_Texte "Msc"
    } elseif  {$Pref_Main_Win_Type == 2} {
	Afficher_Active_Path_Vue_Msc_Ou_Texte "Text"
    }

    Envoi_Message "shell rm $ocis_temporary_bcg_file $ocis_temporary_o_file"
	

    Lire_Reponse

    grab release .fenetre_compilation
    Terminer_Recompilation

}

proc Creer_Et_Ouvrir_Fenetre_Recompilation {} {
    global channel_recompile global_menu_bg_color
    global Width_Win_Recompile Height_Win_Recompile 
    global Recompile_X_Position Recompile_Y_Position
    global Font_Texte_Fenetre_Recompilation
    global Titre_Fenetres
    global Foreground_Windows
    global Font_Bold_9 Font_Bold_10

    if {[winfo exists .fenetre_compilation]} then {
	wm deiconify .fenetre_compilation
	raise .fenetre_compilation
	return -1
    } 

    toplevel .fenetre_compilation
    wm title .fenetre_compilation "$Titre_Fenetres ... Compiling"
    wm geometry .fenetre_compilation ${Width_Win_Recompile}x${Height_Win_Recompile}+${Recompile_X_Position}+${Recompile_Y_Position}
    bind .fenetre_compilation <Configure> ComputeRulesWinRecompile
    if {$Foreground_Windows == 1} {
	bind .fenetre_compilation <Enter> "raise .fenetre_compilation"
    }

    set frame_princ [frame .fenetre_compilation.frame -bg $global_menu_bg_color]
    pack $frame_princ -side top -fill both -expand yes 

    set frame_label [frame $frame_princ.label -bg $global_menu_bg_color]
    label $frame_label.label -text "Compiling lotos programs with Caesar" -font $Font_Bold_10 -bg $global_menu_bg_color

    pack $frame_label -side top -fill both -expand yes -padx 3 -pady 3 
    pack $frame_label.label  -side top 

    tixLabelFrame $frame_princ.buttons -labelside none -bg $global_menu_bg_color
    [$frame_princ.buttons subwidget frame] configure -bg $global_menu_bg_color

    set frame_buttons [$frame_princ.buttons subwidget frame]
    button $frame_buttons.compile -text "Compile" -font $Font_Bold_9 \
	    -command Executer_Recompilation -bg $global_menu_bg_color\
	    -highlightcolor $global_menu_bg_color \
	    -highlightbackground $global_menu_bg_color

    button $frame_buttons.clear -text "Clear"  \
	    -font $Font_Bold_9 -bg $global_menu_bg_color \
	    -command {set frame_princ .fenetre_compilation.frame ; set texte [$frame_princ.texte subwidget text] ; $texte delete 1.0 end}

    button $frame_buttons.close -text "Cancel" -font $Font_Bold_9 \
	    -command {catch {close $channel_recompile}; \
	    destroy .fenetre_compilation} -bg $global_menu_bg_color\
	    -highlightcolor $global_menu_bg_color \
	    -highlightbackground $global_menu_bg_color

    pack $frame_princ.buttons -side top -fill x -expand yes -padx 3 -pady 3 
    pack $frame_buttons.compile $frame_buttons.clear $frame_buttons.close \
	    -side left -expand yes -fill x -padx 5 -pady 5 

    tixScrolledText $frame_princ.texte -bg $global_menu_bg_color\
	    -highlightcolor $global_menu_bg_color\
	    -highlightbackground $global_menu_bg_color 

    [$frame_princ.texte subwidget text] configure \
	    -highlightbackground $global_menu_bg_color \
	    -yscrollcommand [subst {[$frame_princ.texte subwidget vsb] set}]
    [$frame_princ.texte subwidget hsb] configure -background $global_menu_bg_color
    [$frame_princ.texte subwidget vsb] configure -background $global_menu_bg_color -command [subst {[$frame_princ.texte subwidget text] yview}]

    pack .fenetre_compilation.frame.texte -expand yes \
	    -fill both -padx 5 -pady 5

}

proc init_dynamic_backcode_trace_cmd {ligne} {
    global current_list_procs

    set current_list_procs "" 
    menu_dynamic_backcode trace $ligne
}

proc init_dynamic_backcode_trans_cmd {} {
    global current_list_procs

    set current_list_procs "" 
    menu_dynamic_backcode trans 0

}

proc open_dynamic_backcode_window {} {
    global Width_Win_Source Height_Win_Source 
    global Win_Source_X_Position Win_Source_Y_Position
    global Titre_Fenetres

    Initialiser_Notebook_Fenetre_Code_Source .fenetre_code_source \
	    "$Titre_Fenetres ... Source code" $Width_Win_Source $Height_Win_Source \
	    $Win_Source_X_Position $Win_Source_Y_Position
    bind .fenetre_code_source <Configure> ComputeRulesWinSource
    if {[info exists liste_tache_onglets]} {
	unset liste_tache_onglets
    }
}

proc menu_dynamic_backcode {type ligne} {
    global Numero_Ligne_Transition_Courante_Vue_Msc_Et_Text
    global Numero_Transition_Courante
    global global_nb_tache
    global Viewing_Source_Code
    global env
    global Fichier_Open_Caesar

    if {![info exists env(OPEN_CAESAR_FILE)] && $Fichier_Open_Caesar == ""} {
	set Viewing_Source_Code 0
	Afficher_Message_Erreur "Displaying the source code is disabled\nSet the environment variable\nOPEN_CAESAR_FILE\nto the name of the LOTOS file opened with lotos.open" {Ouvrir_Fenetre_Selection_Fichier .selection_filebox {Selecting OPEN CAESAR FILE} \
		{*.lot*} Set Set_Current_Caesar_File {Fichier_Open_Caesar}}
	tkwait variable Fichier_Open_Caesar
	set Viewing_Source_Code 1
    }

    open_dynamic_backcode_window

    if {$type == "trace"} {
	if {$ligne == 0} {
	    set back 0
	} else {
	    set back [expr $Numero_Transition_Courante - $Numero_Ligne_Transition_Courante_Vue_Msc_Et_Text]
	}
    } else {
	if {$type == "trans"} then {
	    set back $Numero_Ligne_Transition_Courante_Vue_Msc_Et_Text
	}
    }

    for {set i 0} {$i < $global_nb_tache} {incr i 1} {

	if {$type == "trace"} {
	    Envoi_Message "taskinfo $type $i"
	} else {
	    Envoi_Message "taskinfo $type $back $i"
	}

	Lire_Reponse 

	Envoi_Message "backcode $type $back $i"
	

	Lire_Reponse 
    }

}

proc Initialiser_Notebook_Fenetre_Code_Source {nom titre width height x_pos y_pos} {
    global global_menu_bg_color
    global Foreground_Windows

    if {[winfo exists $nom]} then {
	wm deiconify $nom
    } else {
	toplevel $nom
	wm geometry $nom ${width}x${height}+${x_pos}+${y_pos}
	wm title $nom $titre
	if {$Foreground_Windows == 1} {
	    bind $nom <Enter> "raise $nom"
	}
	if {[winfo exists $nom.nb]} then {
	    destroy $nom.nb
	}
    }

    if {![winfo exists $nom.nb]} {
	tixNoteBook $nom.nb -bg $global_menu_bg_color -dynamicgeometry yes   
	$nom.nb subwidget nbframe configure -bg $global_menu_bg_color \
		-backpagecolor $global_menu_bg_color \
		-inactivebackground $global_menu_bg_color 
	
	pack $nom.nb -expand yes -fill both
    }

    return $nom.nb
}

proc Creer_Page_Fenetre_Code_Source {nom_page numero_tache} {
    global global_bg_color global_menu_bg_color 
    global Viewing_Source_Code
    global liste_tache_onglets
    global Backcode_History_Local_Variables
    global Font_Code_Source_Title
    global Font_Bold_9

    label $nom_page.label -text "Source code >>>" \
	    -font $Font_Code_Source_Title -background white

    tixScrolledText $nom_page.sw -bg $global_menu_bg_color 
    $nom_page.sw.text configure -state disabled -wrap none \
	    -background $global_bg_color -cursor [. cget -cursor]

    Initialiser_Ecriture_Page_Texte $nom_page.sw.text
    [$nom_page.sw subwidget hsb] configure -background $global_menu_bg_color
    [$nom_page.sw subwidget vsb] configure -background $global_menu_bg_color

    label $nom_page.label_localvariables -text "Variables >>>" \
	    -font $Font_Code_Source_Title -background white
    tixScrolledText $nom_page.text_localvariables -bg $global_menu_bg_color 
    $nom_page.text_localvariables.text configure -state disabled -wrap none \
	    -background $global_bg_color -cursor [. cget -cursor]

    Initialiser_Ecriture_Page_Texte $nom_page.text_localvariables.text
    [$nom_page.text_localvariables subwidget hsb] configure -background $global_menu_bg_color
    [$nom_page.text_localvariables subwidget vsb] configure -background $global_menu_bg_color

    frame $nom_page.frame -bd 1 -relief sunken -background $global_menu_bg_color

    button $nom_page.frame.b_close -text "Close" -font $Font_Bold_9 \
	    -command {set Viewing_Source_Code 0; unset liste_tache_onglets ; destroy .fenetre_code_source.nb ; wm withdraw .fenetre_code_source} \
	    -background $global_menu_bg_color 

    button $nom_page.frame.b_edit -state normal -text "Edit source file" \
	    -font $Font_Bold_9 -background $global_menu_bg_color

    checkbutton $nom_page.frame.b_localvariables_history \
	    -text "Show variable history" \
	    -font $Font_Bold_9 \
	    -variable Backcode_History_Local_Variables($numero_tache) \
	    -background $global_menu_bg_color \
	    -command Afficher_History_Variables_Locales

    pack $nom_page.frame -side bottom -expand yes -fill both -padx 4 -pady 4
    pack $nom_page.label -side top -expand yes -fill both -padx 2 -pady 2
    pack $nom_page.sw  -side top -expand yes -fill both -padx 2 -pady 2
    pack $nom_page.label_localvariables -expand yes  -side top -fill both -padx 2 -pady 2
    pack $nom_page.text_localvariables -expand yes  -side top -fill both -padx 2 -pady 2

    pack $nom_page.frame.b_edit $nom_page.frame.b_localvariables_history \
	    $nom_page.frame.b_close -side left -expand yes -fill both -padx 5 -pady 5 

    return $nom_page.sw.text
}

proc Activer_Page_Fenetre_Code_Source {raised_onglet} {
    global liste_current_onglet_fichier_ligne_texte_tache
    global global_menu_bg_color
    global env
    global Font_Code_Source_Texte

    Recuperer_Information_Backcode Non_Historique

    set fichier [lindex $liste_current_onglet_fichier_ligne_texte_tache($raised_onglet) 0]
    set ligne   [lindex $liste_current_onglet_fichier_ligne_texte_tache($raised_onglet) 1]
    set texte   [lindex $liste_current_onglet_fichier_ligne_texte_tache($raised_onglet) 2]
    set tache   [lindex $liste_current_onglet_fichier_ligne_texte_tache($raised_onglet) 3]

    set page [.fenetre_code_source.nb subwidget $raised_onglet]
    $page configure -background $global_menu_bg_color
    $page.label configure -text "Source code >>>    Task $tache, line $ligne in $fichier" -font $Font_Code_Source_Texte
    $page.label_localvariables configure -text "Variables >>>    Task $tache" -font $Font_Code_Source_Texte
	
    Afficher_Fichier_Code_Source $fichier $ligne $texte $tache

}

proc Lancer_Edition_Fichier {Index_Fichier} {

    global env
    global Selected_File_Name

    if [info exists Selected_File_Name($Index_Fichier)] {
	set fichier $Selected_File_Name($Index_Fichier)
    } else {
	set fichier ""
    }

    if {$fichier != ""} {
	set edit_command "$env(CADP)/src/com/cadp_edit $fichier"
    } else {
	set edit_command "$env(CADP)/src/com/cadp_edit"
    }

    if [catch {eval exec sh -c {$edit_command} &}] {
	Afficher_Message_Erreur "Command \"edit_command\" failed" {}
	return
    }
}

proc Editer_Et_Pointer_Ligne_Fichier_Code_Source {fichier ligne} {
    global env 
    global Selected_File_Name

    set Commande_Edition $fichier
    if {[info exists env(CADP_EDITOR_CMD_FLAG)] && [info exists env(CADP_EDITOR_CMD_PLACEMENT)]} then {
	set Commande_Edition "$env(CADP_EDITOR_CMD_FLAG) \"$env(CADP_EDITOR_CMD_PLACEMENT)$ligne $fichier\""
    }

    set Selected_File_Name(Fichier_Code_Source) $fichier
    Lancer_Edition_Fichier Fichier_Code_Source
}

proc Afficher_Contenu_Variables_Code_Source {nom} {
    global Info_Variable_Code_Source
    global Num_Info_Variable_Code_Source
    global Info_Tache_Fichier_Code_Source
    global Info_Tache_Ligne_Code_Source

    if {$Num_Info_Variable_Code_Source > 0} then {
	Ecrire_Nouvelle_Ligne_Texte $nom "Location : " black 0
	Ecrire_Nouvelle_Ligne_Texte $nom "$Info_Variable_Code_Source(0)" red 0
	Ecrire_Nouvelle_Ligne_Vide $nom
    }

    if {$Num_Info_Variable_Code_Source <= 1} then {
	Ecrire_Nouvelle_Ligne_Texte $nom "No local variable" black 0
	Ecrire_Nouvelle_Ligne_Vide $nom
    } 

    for {set i 1} {$i < $Num_Info_Variable_Code_Source} {incr i 1} { 
	set tag [Ecrire_Nouvelle_Ligne_Texte $nom "$Info_Variable_Code_Source($i)" black 0]
	Associer_Tag_Ligne_Texte $nom $tag <1> \
		"Editer_Et_Pointer_Ligne_Fichier_Code_Source $Info_Tache_Fichier_Code_Source($i) \
		$Info_Tache_Ligne_Code_Source($i)"
	Ecrire_Nouvelle_Ligne_Vide $nom 
    }

    Ecrire_Nouvelle_Ligne_Texte $nom  " " black 1
    Ecrire_Nouvelle_Ligne_Vide $nom 
}

proc Ajouter_Page_Variables_Fenetre_Code_Source {nom_notebook num_transition} {
    global Backcode_History_Local_Variables
    global Label_Transition_Courante
    global backcode_raised_onglet

    set page [$nom_notebook subwidget $backcode_raised_onglet]
    set texte_localvariables $page.text_localvariables.text

    if {$Backcode_History_Local_Variables($backcode_raised_onglet) == 0} {

	Effacer_Ligne_Texte $texte_localvariables 1
    }

    if {[info exists Label_Transition_Courante]} {
	Ecrire_Nouvelle_Ligne_Texte $texte_localvariables ">>> $num_transition ... " blue 0
	Ecrire_Nouvelle_Ligne_Texte $texte_localvariables "Fired transition: " black 0
	Ecrire_Nouvelle_Ligne_Texte $texte_localvariables "$Label_Transition_Courante" blue 0
	Ecrire_Nouvelle_Ligne_Vide $texte_localvariables
    }

    Afficher_Contenu_Variables_Code_Source $texte_localvariables

}

proc Ajouter_Mise_A_Jour_Page_Tache_Fenetre_Code_Source {nom tache fichier ligne} {
    global env
    global global_menu_bg_color
    global liste_tache_onglets
    global liste_current_onglet_fichier_ligne_texte_tache
    global backcode_raised_onglet
    global Font_Code_Source_Texte
    global Fichier_Open_Caesar

    if {$fichier == ""} {
	if {[info exists env(OPEN_CAESAR_FILE)]} {
	    set fichier $env(OPEN_CAESAR_FILE)
	} elseif {$Fichier_Open_Caesar != ""} {
	    set fichier $Fichier_Open_Caesar
	}
    }

    if {![info exists liste_tache_onglets] || ![info exists liste_tache_onglets($tache)]} {

	$nom add $tache -label "Task $tache" \
		-raisecmd {set backcode_raised_onglet [.fenetre_code_source.nb raised] ; \
		Activer_Page_Fenetre_Code_Source $backcode_raised_onglet}
	set liste_tache_onglets($tache) $tache

	set page [$nom subwidget $tache]
	$page configure -background $global_menu_bg_color

	set texte [Creer_Page_Fenetre_Code_Source $page $tache]
	set texte_localvariables $page.text_localvariables.text

        $page.frame.b_edit configure -command [subst {Editer_Et_Pointer_Ligne_Fichier_Code_Source $fichier $ligne}]

    } else {
	set page [$nom subwidget $tache]
	$page configure -background $global_menu_bg_color

	set texte $page.sw.text	
	set texte_localvariables $page.text_localvariables.text
    }

    set liste_current_onglet_fichier_ligne_texte_tache($tache) \
	    "$fichier $ligne $texte $tache"

    if {$ligne > 0} {
	$page.label configure -text "Source code >>>    Task $tache, line $ligne in $fichier" -font $Font_Code_Source_Texte
	$page.label_localvariables configure -text "Variables >>>    Task $tache" -font $Font_Code_Source_Texte
    } else {
	set backcode_raised_onglet [.fenetre_code_source.nb raised]
    }
    if {![string compare $backcode_raised_onglet $tache]} {
	Afficher_Fichier_Code_Source $fichier $ligne $texte $tache
    }
}

proc Afficher_Valeur_Variable_Code_Source {var x y} {
  if {[winfo exists .popup_menu_valeur]} then {
    destroy .popup_menu_valeur
  }
  lib_gestion_menu_cree_menu .popup_menu_valeur "{{} {[lindex $var 1]}\
  normal} {{} {[lindex $var 2]} normal}"
  tk_popup .popup_menu_valeur $x $y
}

proc Fin_Fichier_Code_Source {id} {
  if {$id == -1} then {
    return 1
  }
  return [eof $id]
}

proc Analyser_Ligne_Source_Code {texte loc tache fichier ligne} {
    global Info_Variable_Code_Source
    global Num_Info_Variable_Code_Source

    set Num_Variable $Num_Info_Variable_Code_Source

    Ecrire_Nouvelle_Ligne_Texte $loc " " black 0

    set long [llength $texte]
    for {set i 0} {$i < $long} {incr i 1} {

	set tag [Ecrire_Nouvelle_Ligne_Texte $loc "[lindex $texte $i] "\
		"yellow blue4" 0]

	for {set j 1} {$j < $Num_Variable} {incr j 1} {
	    if {[regexp [lindex $Info_Variable_Code_Source($j) 0] \
		    [lindex $texte $i]]} then {

		Associer_Tag_Ligne_Texte $loc $tag <1> \
	  		"Afficher_Valeur_Variable_Code_Source\
			{$Info_Variable_Code_Source($j)}\
			%X %Y"

		break
	    }
	}
    }
    Ecrire_Nouvelle_Ligne_Texte $loc "     >>> Task $tache, line $ligne in $fichier" red 0

}

proc Afficher_Fichier_Code_Source {fichier ligne loc tache} {

    Effacer_Ligne_Texte $loc 1

    set height_loc [$loc cget -height]

    if {$fichier == ""} then {

	set id_source -1
    } elseif {[file exists $fichier] == 0} then {

	set id_source -1
    } else {
	if [catch {open "$fichier" "r"} id_source] {
	    Afficher_Message_Erreur "File $fichier unreadable" {}
	    return
	}
    }

    if {[Fin_Fichier_Code_Source $id_source]} then {

	Ecrire_Nouvelle_Ligne_Texte $loc "No file to edit ..." red 1
    }

    set couleur black
    set nb_ligne 0
    set focus_done 0
    while {[Fin_Fichier_Code_Source $id_source] != 1} {

	if {$id_source == -1} then {
	    set texte ""
	} else {
	    set texte [gets $id_source]
	}

	set focus 0
	incr nb_ligne 1
	if {$nb_ligne == $ligne} then {

	    Analyser_Ligne_Source_Code $texte $loc $tache $fichier $ligne
	    Ecrire_Nouvelle_Ligne_Vide $loc

	} else {
	    if {$nb_ligne == [expr $ligne +10]} then {
		set focus_done 1
		set focus 1 
	    }
	    Ecrire_Nouvelle_Ligne_Texte $loc "$texte " $couleur $focus
	    Ecrire_Nouvelle_Ligne_Vide $loc
	}
    }

    if {$focus_done == 0} {

	Ecrire_Nouvelle_Ligne_Texte $loc " " $couleur 1
	Ecrire_Nouvelle_Ligne_Vide $loc
    }
	

    if {$id_source != -1} then {
	close $id_source
    }
}

proc Ecrire_Nouvelle_Ligne_Texte {frame_texte texte couleur focus} {
 global Nombre_Tags_Par_Frame_Texte
 global Nombre_Lignes_Par_Frame_Texte
 global Nombre_Tags_Par_Ligne_Texte
 global bold
 global normal
 global Font_Code_Source_Texte

 if {$frame_texte ==""} then {
    return -1
 }

 $frame_texte configure -state normal

 set tag $frame_texte.$Nombre_Lignes_Par_Frame_Texte($frame_texte).$Nombre_Tags_Par_Frame_Texte($frame_texte)

 $frame_texte insert end $texte $tag 

 incr Nombre_Tags_Par_Frame_Texte($frame_texte) 1
 incr Nombre_Tags_Par_Ligne_Texte($frame_texte,$Nombre_Lignes_Par_Frame_Texte($frame_texte)) 1

 $frame_texte tag configure $tag -foreground [lindex $couleur 0] \
				 -background {} -font $Font_Code_Source_Texte
 if {[lindex $couleur 1] != ""} then {
   $frame_texte tag configure $tag -background [lindex $couleur 1]
 }

 $frame_texte configure -state disabled 

 if {$focus} then {
     $frame_texte see $tag.first 
 }

 return $tag 
}

proc Associer_Tag_Ligne_Texte {frame_texte tag event action} {
  global bold
  global normal

  if {$frame_texte ==""} then {
    return -1
  }

  $frame_texte tag bind $tag <Any-Enter> "$frame_texte tag  configure $tag $bold"

  set couleur [$frame_texte tag cget $tag -foreground]
  set bg_couleur [$frame_texte tag cget $tag -background]

  $frame_texte tag bind $tag <Any-Leave> "$frame_texte tag  configure $tag $normal -foreground $couleur -background {$bg_couleur}"
  set tmp "$action"

  $frame_texte tag bind $tag $event $tmp
}

proc Ecrire_Nouvelle_Ligne_Vide {frame_texte} {
  global Nombre_Tags_Par_Frame_Texte
  global Nombre_Tags_Par_Ligne_Texte
  global Nombre_Lignes_Par_Frame_Texte 

  if {$frame_texte ==""} then {
    return -1
  } 

  $frame_texte configure -state normal
  $frame_texte insert end "\n"
  $frame_texte configure -state disabled

  set tmp $Nombre_Lignes_Par_Frame_Texte($frame_texte)
  incr Nombre_Lignes_Par_Frame_Texte($frame_texte) 1 
  set tmp $Nombre_Lignes_Par_Frame_Texte($frame_texte)
  set Nombre_Tags_Par_Ligne_Texte($frame_texte,$tmp) 0
  set Nombre_Tags_Par_Frame_Texte($frame_texte) 0
}

proc Effacer_Ligne_Texte {frame_texte n} {
    global Nombre_Tags_Par_Frame_Texte
    global Nombre_Lignes_Par_Frame_Texte 

    if {$frame_texte ==""} then {
	return -1
    } 
    $frame_texte configure -state normal

    $frame_texte tag delete $frame_texte.$n.0 

    $frame_texte delete $n.0 end

    set Nombre_Lignes_Par_Frame_Texte($frame_texte) $n
    set Nombre_Tags_Par_Frame_Texte($frame_texte) 0

    $frame_texte configure -state  disabled
}

proc Initialiser_Ecriture_Page_Texte {frame_texte} {
    global Nombre_Lignes_Par_Frame_Texte
    global Nombre_Tags_Par_Frame_Texte
    global Nombre_Tags_Par_Ligne_Texte

    set Nombre_Lignes_Par_Frame_Texte($frame_texte) 1
    set Nombre_Tags_Par_Frame_Texte($frame_texte) 0
    set Nombre_Tags_Par_Ligne_Texte($frame_texte,1) 0
}

proc Recuperer_Information_Backcode {Flag_Affichage} {
    global Viewing_Source_Code
    global global_nb_tache
    global current_list_procs
    global backcode_raised_onglet
    global Numero_Transition_Courante

    if {$Viewing_Source_Code == 1} {
	set i 0
	while {[lindex $current_list_procs $i] != ""} {
	    if {$backcode_raised_onglet == [lindex $current_list_procs $i]} {
		break
	    }
	    incr i 1
	}
	if {[lindex $current_list_procs $i] != ""} {

	    Envoi_Message "backcode trace 0 $backcode_raised_onglet"

	    Lire_Reponse 
	}

	if {$Flag_Affichage == "Historique"} {
	    Afficher_History_Variables_Locales 
	} elseif {$Flag_Affichage == "Non_Historique"} {

	    Envoi_Message "taskinfo trace $backcode_raised_onglet"

	    Lire_Reponse 

	    Ajouter_Page_Variables_Fenetre_Code_Source .fenetre_code_source.nb \
		    $Numero_Transition_Courante
	}
    }
}

proc Afficher_History_Variables_Locales {} {
    global backcode_raised_onglet
    global Numero_Transition_Courante
    global Transition_Courante_Vue_Tree
    global Backcode_History_Local_Variables

    if {$Backcode_History_Local_Variables($backcode_raised_onglet) == 1} {
	set page [.fenetre_code_source.nb subwidget $backcode_raised_onglet]
	set texte_localvariables $page.text_localvariables.text

	Effacer_Ligne_Texte $texte_localvariables 1

	Envoi_Message "local_variables_history $backcode_raised_onglet \
		$Transition_Courante_Vue_Tree"

	set i 1
	while {$i <= $Numero_Transition_Courante} {
	    Lire_Reponse
	    incr i 1
	    Ajouter_Page_Variables_Fenetre_Code_Source .fenetre_code_source.nb [expr $i -1]
	}
    } else {

	Envoi_Message "taskinfo trace $backcode_raised_onglet"

	Lire_Reponse 
	
	Ajouter_Page_Variables_Fenetre_Code_Source .fenetre_code_source.nb \
		$Numero_Transition_Courante
		
    }
}

proc ocis_menu_batch_scn {file} {
    global ocis_temporary_bcg_file
    global Transition_Courante_Vue_Tree
    global Arbre_Vue_Tree 
    global wait_tree_image
    global Numero_Transition_Courante
    global Pref_Main_Win_Type
    global w_pane_top
    global Fenetres_Transition
    global Fenetres_Affichage
    global nbr_fils_etat_initial
    global Noms_Taches
    global Heure_Etat_Initial
    global Selected_File_Name
    global Label_Etat_Initial

    if {$file == ""} then {
	return -1
    }

    if {[catch {open "$file" "r"} fichier_id] == 0} then {
	close $fichier_id

	set Ancien_Active_Path $Transition_Courante_Vue_Tree

	Envoi_Message "batch $file $ocis_temporary_bcg_file"

	.main configure -cursor watch

	$Arbre_Vue_Tree delete all
	$Arbre_Vue_Tree add 0 -text $Label_Etat_Initial -data "{{} {T} {START} Explored {$Noms_Taches} {$Heure_Etat_Initial}} {} {$nbr_fils_etat_initial 0 0 0 0}" -itemtype imagetext -image $wait_tree_image

	Effacer_Transition $Fenetres_Transition 1
	Effacer_Transition $Fenetres_Affichage 2

	Afficher_Transition_Vue_Texte "" "" "" "" "" 0 $Fenetres_Affichage
	set Numero_Transition_Courante 1

	Envoi_Message "load $ocis_temporary_bcg_file"

	Lire_Reponse

	Lire_Reponse

	set Numero_Transition_Courante 1
	set Transition_Courante_Vue_Tree 0

	.main configure -cursor left_ptr
	    

	set Pref_Main_Win_Type 3
	$w_pane_top.note raise $Pref_Main_Win_Type

    } else {
	Afficher_Message_Erreur file "$file: No such batch file" {}
    }
}

proc ocis_batch_cmd {} {
    global env channel_id

    if {[winfo exists .fichier_batch_scn]} then {
	.fichier_batch_scn popup
	raise .fichier_batch_scn
    }

}

proc ocis_menu_sequence_scn {file} {
    global Numero_Transition_Courante
    global Transition_Courante_Vue_Tree

    if {$file == ""} then {
	return -1
    }

    if {[catch {open "$file" "r"} fichier_id] == 0} then {
	close $fichier_id
	set Ancien_Active_Path $Transition_Courante_Vue_Tree

	Envoi_Message "sequence $file"

	Lire_Reponse
    } else {
	Afficher_Message_Erreur "$file: No such sequence path file" {}
    }
}

proc ocis_menu_save_history_scn {file} {

  if {$file == ""} then {
    return -1
  }

  Envoi_Message "save_hist $file"

}

proc ocis_save_history_cmd {} {
    global env channel_id

    if {[winfo exists .fichier_save_history_scn]} then {
	.fichier_save_history_scn popup
	raise .fichier_save_history_scn
    }

}

proc Afficher_Warning_General {type_warning message} {

    global global_menu_bg_color
    global Warning_General_Win_Width 
    global Warning_General_Win_Height 
    global Titre_Fenetres
    global Flag_Execution_Commande
    global Scenario_Courant_Deja_Sauvegarde
    global Nom_Scenario_Courant
    global Choix_Effectue 
    global Font_Bold_9

    switch -exact -- $type_warning {
	SAVE_SCENARIO {

	    Envoi_Message "scenario $Nom_Scenario_Courant"
	    Lire_Reponse
	    if {$Scenario_Courant_Deja_Sauvegarde == 1} {
		set Flag_Execution_Commande 1
		return
	    }
	}
	
	CUT_DOWN_TREE {
	    break
	}
    }

    if [winfo exists .warning_general] then {
	destroy .warning_general
    }

    ComputeRulesWinMain

    global Screen_Width Screen_Height Screen_X_Position Screen_Y_Position

    set Warning_General_Win_X_Pos [expr $Screen_X_Position + $Screen_Width /2 - $Warning_General_Win_Width /2]
    set Warning_General_Win_Y_Pos [expr $Screen_Y_Position + $Screen_Height /2 - $Warning_General_Win_Height /2]

    toplevel .warning_general
    wm geometry .warning_general ${Warning_General_Win_Width}x${Warning_General_Win_Height}+${Warning_General_Win_X_Pos}+${Warning_General_Win_Y_Pos}
    wm title .warning_general "$Titre_Fenetres ... Warning" 
    bind .warning_general <Configure> ComputeRulesWinWarningGeneral
    bind .warning_general <Enter> "raise .warning_general"

    focus .warning_general
    grab .warning_general

    frame .warning_general.frame -bg $global_menu_bg_color
    pack .warning_general.frame -side top -expand yes -fill both

    label .warning_general.frame.message -text "$message" \
	    -font $Font_Bold_9 -bg $global_menu_bg_color \
	    -highlightcolor $global_menu_bg_color -highlightbackground $global_menu_bg_color
    pack .warning_general.frame.message -side top -expand yes

    tixLabelFrame .warning_general.frame.buttons -labelside none -bg $global_menu_bg_color
    [.warning_general.frame.buttons subwidget frame] configure -bg $global_menu_bg_color

    set frame_button [.warning_general.frame.buttons subwidget frame]
    button $frame_button.save -text "Yes" -font $Font_Bold_9 \
	    -command {set Flag_Execution_Commande 0; \
	    set Choix_Effectue "okay"} \
	    -bg $global_menu_bg_color -fg red \
	    -highlightcolor $global_menu_bg_color \
	    -highlightbackground $global_menu_bg_color

    button $frame_button.ignore -text "No" -font $Font_Bold_9 \
	    -command {set Flag_Execution_Commande 1; \
	    set Choix_Effectue "okay"} \
	    -bg $global_menu_bg_color -highlightcolor $global_menu_bg_color \
	    -highlightbackground $global_menu_bg_color
    button $frame_button.cancel -text "Cancel" -font $Font_Bold_9 \
	    -command {set Flag_Execution_Commande 2; set Choix_Effectue "okay"} \
	    -bg $global_menu_bg_color -highlightcolor $global_menu_bg_color \
	    -highlightbackground $global_menu_bg_color

    pack .warning_general.frame.buttons -side top -fill both -expand yes  
    pack $frame_button.save $frame_button.ignore $frame_button.cancel \
	    -side left -expand yes -padx 5 -pady 5 -fill x

    bind .warning_general <Return> [subst {$frame_button.save invoke}]

    set Choix_Effectue ""
    tkwait variable Choix_Effectue
    if {[winfo exists .warning_general]} {
	grab release .warning_general
	destroy .warning_general
    }
}

proc Afficher_Message_Erreur {message Fonction_A_Executer} {
    global global_menu_bg_color
    global Error_Win_Width 
    global Error_Win_Height 
    global Titre_Fenetres
    global Font_Bold_9

    if [winfo exists .file_opening_failure] then {
	destroy .file_opening_failure
    }

    ComputeRulesWinMain

    global Screen_Width Screen_Height Screen_X_Position Screen_Y_Position

    set Error_Win_X_Pos [expr $Screen_X_Position + $Screen_Width /2 - $Error_Win_Width /2]
    set Error_Win_Y_Pos [expr $Screen_Y_Position + $Screen_Height /2 - $Error_Win_Height /2]

    toplevel .file_opening_failure
    wm geometry .file_opening_failure ${Error_Win_Width}x${Error_Win_Height}+${Error_Win_X_Pos}+${Error_Win_Y_Pos}
    wm title .file_opening_failure "$Titre_Fenetres ... Warning" 
    bind .file_opening_failure <Configure> ComputeRulesWinError
    bind .file_opening_failure <Control-c> "destroy .file_opening_failure"
    bind .file_opening_failure <Enter> "raise .file_opening_failure"
    focus .file_opening_failure

    frame .file_opening_failure.frame -bg $global_menu_bg_color
    pack .file_opening_failure.frame -side top -expand yes -fill both

    label .file_opening_failure.frame.message -text "$message" \
	    -font $Font_Bold_9 -bg $global_menu_bg_color \
	    -bg $global_menu_bg_color -highlightcolor $global_menu_bg_color \
	    -highlightbackground $global_menu_bg_color
    pack .file_opening_failure.frame.message -side top -expand yes

    button .file_opening_failure.frame.okay -text "OK" \
	    -font $Font_Bold_9 -bg $global_menu_bg_color -fg red \
	    -highlightcolor $global_menu_bg_color \
	    -highlightbackground $global_menu_bg_color

    if {$Fonction_A_Executer == ""} {
	.file_opening_failure.frame.okay configure \
		-command {grab release .file_opening_failure; \
		destroy .file_opening_failure}
    } else {
	.file_opening_failure.frame.okay configure \
		-command [subst {grab release .file_opening_failure; \
		destroy .file_opening_failure; $Fonction_A_Executer}]
    }

    pack .file_opening_failure.frame.okay -side top -expand yes

    bind .file_opening_failure <Return> {.file_opening_failure.frame.okay invoke}

}

proc Creer_Boite_Selection_Fichier {nom cmd file_type ext} {
  global global_menu_bg_color

  if {[winfo exists $nom]} then {
    return 0
  }

  tixExFileSelectDialog $nom -command $cmd -bg $global_menu_bg_color
  [$nom subwidget fsbox] configure -filetypes $file_type -pattern $ext -bg $global_menu_bg_color
  bind $nom <Control-c> "$nom popdown"
  return 1
}

proc Initialiser_Boites_Selection {} {

    set res3 [Creer_Boite_Selection_Fichier .fichier_batch_scn ocis_menu_batch_scn \
	    {{{*.bat} "BAT File"}} {*.bat}] 

    set res5 [Creer_Boite_Selection_Fichier .fichier_save_history_scn ocis_menu_save_history_scn \
	    {{{*.bat} "BAT File"}} {*.bat}] 

    if {$res3 && $res5} then {
    } else {
	puts stderr "Initializing the selection boxes has failed."
    }
}

proc Detruire_Fichiers_Temporaires {} {
    global ocis_temporary_postscript
    global ocis_other_temporary_postscript
    global ocis_temporary_bcg_file
    global ocis_temporary_o_file
    global ocis_temporary_exhibitor_output_log 
    global ocis_temporary_exhibitor_output_seq
    global ocis_all_temporary_files

    Envoi_Message "shell rm \
	    $ocis_temporary_postscript \
	    $ocis_other_temporary_postscript \
	    $ocis_temporary_bcg_file \
	    $ocis_temporary_o_file \
	    $ocis_temporary_exhibitor_output_log \
	    $ocis_temporary_exhibitor_output_seq \
	    $ocis_all_temporary_files"

    Lire_Reponse

}

proc Quitter_Proprement_Ocis {} {
    global Flag_Execution_Commande

    Afficher_Warning_General "SAVE_SCENARIO" "Save the current simulation\nscenario before exiting OCIS?"

    if {$Flag_Execution_Commande == 2} {
	return 1
    }

    if {$Flag_Execution_Commande == 0} {
      Sauvegarde_Et_Attend
    }

    Detruire_Fichiers_Temporaires 

    Envoi_Message "quit"
    exit 0
}

proc Sauvegarde_Et_Attend {} {
  global Fichier_A_Ete_Selectionne
  global Error_Detected

  set Fichier_A_Ete_Selectionne 0

  Sauvegarder_Scenario 1

  while { 1 } {

    if {[winfo exists .selection_filebox]} {
      tkwait window .selection_filebox
    }

    if { $Fichier_A_Ete_Selectionne == 2 || $Error_Detected == 0 } { 
      break
    }

  }
}

proc Extraire_Base_Name_Fichier {Nom_Fichier} {

    set Basename_Fichier [file tail $Nom_Fichier]
    if {$Basename_Fichier == ""} {

	return $Nom_Fichier
    } else {
	return $Basename_Fichier
    }
}

proc Creer_Nouveau_Scenario {} {
    global Nom_Scenario_Courant
    global Flag_Execution_Commande
    global Prefix_Scenario_Par_Defaut
    global Titre_Fenetres

    Afficher_Warning_General "SAVE_SCENARIO" "Save the current simulation scenario\nbefore creating a new one?"

    if {$Flag_Execution_Commande == 2} {
	return 1
    }

    if {$Flag_Execution_Commande == 0} {
      Sauvegarde_Et_Attend
    }

    set Nom_Scenario_Courant "$Prefix_Scenario_Par_Defaut.bcg"
    wm title .main "$Titre_Fenetres ($Nom_Scenario_Courant)"
    Reset_Scenario 0
}

proc Bcg_Load_Refresh_Init {} {
  global Bcg_Load_Counter 
  set Bcg_Load_Counter 0
} 

proc Bcg_Load_Refresh_Update {} {
  global Bcg_Load_Counter Bcg_Load_Counter_Limit Bcg_Load_Counter_Step
  incr Bcg_Load_Counter 1
  if {($Bcg_Load_Counter < $Bcg_Load_Counter_Limit) || \
	  (($Bcg_Load_Counter % $Bcg_Load_Counter_Step) == 0)} {
      update idle
  }
}

proc Charger_Scenario {Index_Fichier} {

    global Flag_Execution_Commande

    Afficher_Warning_General "SAVE_SCENARIO" "Save the current simulation scenario\nbefore opening a new one?"

    if {$Flag_Execution_Commande == 0} { # Choix == "Ok"
        Sauvegarde_Et_Attend
    }

    if {$Flag_Execution_Commande != 2} { # Choix != "Cancel"

	  if {[winfo exists .selection_filebox]} {
	    tkwait window .selection_filebox
	  }
	  Ouvrir_Fenetre_Selection_Fichier .selection_filebox \
	    {Opening scenario} \
	    {*.bcg} Load Effectuer_Chargement $Index_Fichier	    
    }
}

proc Effectuer_Chargement {Index_Fichier} {

    global Nom_Scenario_Courant
    global Arbre_Vue_Tree 
    global Numero_Transition_Courante
    global Transition_Courante_Vue_Tree
    global Pref_Main_Win_Type
    global w_pane_top
    global Fenetres_Transition
    global Fenetres_Affichage
    global Selected_File_Name
    global Selected_Directory_Name
    global Titre_Fenetres

    set Selected_Directory_Name(Fichier_Bcg_A_Sauvegarder) \
                  $Selected_Directory_Name(Fichier_Bcg_A_Ouvrir)

    set fichier [Join $Selected_Directory_Name($Index_Fichier) \
                      $Selected_File_Name($Index_Fichier)]

    if {[catch {open $fichier r} fichier_id] == 0} then {
	close $fichier_id
	.main configure -cursor watch
	global  Ouverture_Fichier_Reussie
	set Ouverture_Fichier_Reussie 1

	Envoi_Message "load $fichier"

	Lire_Reponse

	if {$Ouverture_Fichier_Reussie == "0"} {
	    .main configure -cursor left_ptr
	    return
	}

	Activer_Desactiver_Boutons_Et_Bindings_Souris_Autres_fenetres 0

	global Liste_Transitions_Selectionnees
	global Liste_Transitions_Cachees
	set Liste_Transitions_Selectionnees ""
	set Liste_Transitions_Cachees ""

	Effacer_Transition $Fenetres_Transition 1

	Effacer_Transition $Fenetres_Affichage 1

	$Arbre_Vue_Tree delete all

	Effacer_Transition_Colonne_Time $Fenetres_Affichage.3 1
	Effacer_Transition_Colonne_Tasks $Fenetres_Affichage.3 1
	Effacer_Transition_Colonne_Fired $Fenetres_Affichage.3 1

	set Numero_Transition_Courante 1

	Affichage_Etat_Initial

	set Nom_Scenario_Courant [Extraire_Base_Name_Fichier $fichier]

	global Mode_Lecture_Fichier
	set Mode_Lecture_Fichier 1

	set Pref_Main_Win_Type 3
	$w_pane_top.note raise $Pref_Main_Win_Type

	Lire_Reponse

	Lire_Reponse

	set Numero_Transition_Courante 1
	set Transition_Courante_Vue_Tree 0

	wm title .main "$Titre_Fenetres ([Extraire_Base_Name_Fichier \
                                          $fichier])"
  	.main configure -cursor left_ptr
	    

	Montrer_Transition_Courante

	set Mode_Lecture_Fichier 0

	Activer_Desactiver_Boutons_Et_Bindings_Souris_Autres_fenetres 1
    } else {
	Afficher_Message_Erreur "$fichier: No such scenario file" {}
    }

    Recuperer_Information_Backcode Historique
}

proc Sauvegarder_Scenario_Sous {} {

    global Nom_Scenario_Courant
    global Selected_File_Name
    global Prefix_Scenario_Par_Defaut

    Ouvrir_Fenetre_Selection_Fichier .selection_filebox {Saving scenario} {*.bcg} Save {Sauvegarder_Scenario_Courant} {Fichier_Bcg_A_Sauvegarder}

    if {[winfo exists .selection_filebox]} then {

	if {$Nom_Scenario_Courant != "$Prefix_Scenario_Par_Defaut.bcg"} {

	   [.selection_filebox.frame.entree_fichier.entry subwidget entry] delete 0 end
	   [.selection_filebox.frame.entree_fichier.entry subwidget entry] insert 1 $Nom_Scenario_Courant
	   .selection_filebox.frame.buttons.frame.command configure -state normal
        }
    }
}

proc Sauvegarder_Scenario_Courant {Index_Fichier} {

    global Nom_Scenario_Courant
    global Selected_File_Name
    global Selected_Directory_Name
    global Titre_Fenetres
    global Error_Detected

    set Error_Detected 0

    Envoi_Message "save [Join $Selected_Directory_Name($Index_Fichier) \
                              $Selected_File_Name($Index_Fichier)]"

    Lire_Reponse 

    if { $Error_Detected == 0 } { # Pas d'erreur
      set Nom_Scenario_Courant $Selected_File_Name($Index_Fichier)
      wm title .main "$Titre_Fenetres ([Extraire_Base_Name_Fichier \
                                        $Nom_Scenario_Courant])"
    } else {

      if {[winfo exists .file_opening_failure]} {
        tkwait window .file_opening_failure
      }

      Sauvegarder_Scenario 0
    }
}

proc Sauvegarder_Scenario { Sauvegarde_Scenario_Courant } {

    global Nom_Scenario_Courant
    global Prefix_Scenario_Par_Defaut
    global Selected_File_Name

    if {$Sauvegarde_Scenario_Courant == 0} {
        Sauvegarder_Scenario_Sous
    } else {
        if {$Nom_Scenario_Courant == "$Prefix_Scenario_Par_Defaut.bcg"} {
            Sauvegarder_Scenario_Sous
        } else {
            set Selected_File_Name(Fichier_Bcg_A_Sauvegarder) $Nom_Scenario_Courant
	    Sauvegarder_Scenario_Courant Fichier_Bcg_A_Sauvegarder
        }
    }
}

proc Ouvrir_Selection_Format_Vue {Nom_Fenetre Titre Nom_Variable_Bouton} {
    global global_menu_bg_color
    global Format_Postscript
    global Format_Impression
    global Format_Preview
    global Font_Bold_9 Font_Bold_10

    set frame_princ $Nom_Fenetre.frame

    set frame_label [frame $frame_princ.label -bg $global_menu_bg_color]
    label $frame_label.label -text $Titre \
	    -font $Font_Bold_10 -bg $global_menu_bg_color
    pack $frame_label -side top -fill both -expand yes -padx 3 -pady 3 
    pack $frame_label.label  -side top 

    set frame_format [frame $frame_princ.format -bg $global_menu_bg_color]
    $frame_format configure -borderwidth 1 -relief raised
    label $frame_format.label -text "Source format" -font $Font_Bold_9 \
	    -bg $global_menu_bg_color
    radiobutton $frame_format.msc -text "MSC" -font $Font_Bold_9 \
	    -value 1 -variable [subst {$Nom_Variable_Bouton}] -bg $global_menu_bg_color\
	    -highlightbackground $global_menu_bg_color -highlightcolor $global_menu_bg_color
    radiobutton $frame_format.text -text "Text" -font $Font_Bold_9 \
	  -value 0 -variable [subst {$Nom_Variable_Bouton}] -bg $global_menu_bg_color\
	    -highlightbackground $global_menu_bg_color -highlightcolor $global_menu_bg_color
    radiobutton $frame_format.tree -text "Tree" -font $Font_Bold_9 \
	  -value 2 -variable [subst {$Nom_Variable_Bouton}] -bg $global_menu_bg_color\
	    -highlightbackground $global_menu_bg_color -highlightcolor $global_menu_bg_color

    pack $frame_princ -side top -expand yes -fill both

    pack $frame_format -side top -fill both -expand yes -pady 3
    pack $frame_format.label  -side top
    pack $frame_format.msc -side left -fill both -expand yes
    pack $frame_format.text -side left -fill both -expand yes
    pack $frame_format.tree -side right -fill both -expand yes

}

proc Sauvegarder_Postscript_Fenetre_Principale {} {
    global Format_Postscript
    global global_info_process 
    global global_menu_bg_color
    global Titre_Fenetres
    global Foreground_Windows
    global Font_Bold_9

    if [winfo exists .choose_psfile] then {
	wm deiconify .choose_psfile
	raise .choose_psfile
	return 0
    }
    toplevel .choose_psfile

    wm title .choose_psfile "$Titre_Fenetres ... Save PS file"
    bind .choose_psfile <Control-c> "destroy .choose_psfile"
    if {$Foreground_Windows == 1} {
	bind .choose_psfile <Enter> "raise .choose_psfile"
    }

    frame .choose_psfile.frame -bg $global_menu_bg_color 
    set frame_princ .choose_psfile.frame

    Ouvrir_Selection_Format_Vue .choose_psfile "Postscript generation" Format_Postscript

    set frame_listfiles [frame $frame_princ.listfiles -bg $global_menu_bg_color]
    label $frame_listfiles.label -text "\nList of postscript files" \
	    -font $Font_Bold_9 -bg $global_menu_bg_color

    pack $frame_listfiles -side top -fill both -expand yes
    pack $frame_listfiles.label  -side top -pady 3

    Ouvrir_Selection_Fichier .choose_psfile {*.ps} Fichier_Postscript \
	    .choose_psfile.frame.buttons.frame.command

    tixLabelFrame $frame_princ.buttons -labelside none -bg $global_menu_bg_color
    [$frame_princ.buttons subwidget frame] configure -bg $global_menu_bg_color

    set frame_buttons [$frame_princ.buttons subwidget frame]

    button $frame_buttons.command -text "Generate" -font $Font_Bold_9 \
	    -command {if {"[[.choose_psfile.frame.entree_fichier.entry\
	    subwidget entry] get]" != ""} {
	    Sauvegarder_Postscript .choose_psfile Fichier_Postscript \
	    $Format_Postscript ; destroy .choose_psfile}} -bg $global_menu_bg_color\
	    -highlightcolor $global_menu_bg_color -highlightbackground $global_menu_bg_color

    button $frame_buttons.cancel -text "Cancel" -font $Font_Bold_9 \
	    -command {destroy .choose_psfile} -bg $global_menu_bg_color\
	    -highlightcolor $global_menu_bg_color -highlightbackground $global_menu_bg_color

    pack $frame_princ.buttons -side top -fill both -expand yes -padx 3 -pady 3 
    pack $frame_buttons.command $frame_buttons.cancel -side left -expand yes -fill x -padx 5 -pady 5 

    set frame_format $frame_princ.format
    $frame_format.text invoke

    if {$global_info_process == 0} then {
	$frame_format.msc configure -state disabled
    }

    bind .choose_psfile.frame <Map> {pack propagate .choose_psfile false}
}

proc Ouvrir_Fenetre_Preview {} {
    global global_info_process 
    global global_menu_bg_color
    global env
    global Titre_Fenetres
    global Foreground_Windows
    global Font_Bold_9

    if [winfo exists .choose_preview] then {
	wm deiconify .choose_preview
	raise .choose_preview
	return 0
    }
    toplevel .choose_preview

    wm title .choose_preview "$Titre_Fenetres ... Preview panel"
    bind .choose_preview <Control-c> "destroy .choose_preview"
    if {$Foreground_Windows == 1} {
	bind .choose_preview <Enter> "raise .choose_preview"
    }

    frame .choose_preview.frame -bg $global_menu_bg_color 
    set frame_princ .choose_preview.frame

    Ouvrir_Selection_Format_Vue .choose_preview "Postscript preview" Format_Preview

    tixLabelFrame $frame_princ.buttons -labelside none -bg $global_menu_bg_color
    [$frame_princ.buttons subwidget frame] configure -bg $global_menu_bg_color

    set frame_buttons [$frame_princ.buttons subwidget frame]
    button $frame_buttons.command -text "Preview" -font $Font_Bold_9 \
	    -command {Afficher_Apercu_Fichier Format_Preview} -bg $global_menu_bg_color\
	    -highlightcolor $global_menu_bg_color -highlightbackground $global_menu_bg_color

    button $frame_buttons.cancel -text "Cancel" -font $Font_Bold_9 \
	    -command {destroy .choose_preview} -bg $global_menu_bg_color\
	    -highlightcolor $global_menu_bg_color -highlightbackground $global_menu_bg_color

    pack $frame_princ.buttons -side top -fill both -expand yes -padx 3 -pady 3 
    pack $frame_buttons.command $frame_buttons.cancel -side left -expand yes -fill x -padx 5 -pady 5 

    set frame_format $frame_princ.format
    $frame_format.text invoke

    if {$global_info_process == 0} then {
	$frame_format.msc configure -state disabled
    }

}

proc Ouvrir_Fenetre_Imprimante {} {
    global imprimante 
    global imprimante_cmd 
    global Format_Impression
    global global_info_process 
    global global_menu_bg_color
    global Titre_Fenetres
    global Foreground_Windows
    global Font_Bold_9

    if [winfo exists .choose_printer] then {
	wm deiconify .choose_printer
	raise .choose_printer
	return 0
    }
    toplevel .choose_printer

    wm title .choose_printer "$Titre_Fenetres ... Print panel"
    bind .choose_printer <Control-c> "destroy .choose_printer"
    if {$Foreground_Windows == 1} {
	bind .choose_printer <Enter> "raise .choose_printer"
    }

    frame .choose_printer.frame -bg $global_menu_bg_color 
    set frame_princ .choose_printer.frame

    Ouvrir_Selection_Format_Vue .choose_printer "Postscript printing" Format_Impression

    set frame_format $frame_princ.format
    $frame_format.text invoke

    if {$global_info_process == 0} then {
	$frame_format.msc configure -state disabled
    }

    set frame_printer [frame $frame_princ.printer -bg $global_menu_bg_color]

    pack $frame_printer -side top -fill both -expand yes -padx 3 -pady 3 

    tixComboBox $frame_printer.nameprinter -editable true -label "Selected printer" \
	    -prunehistory true 
    [$frame_printer.nameprinter subwidget arrow] configure \
	    -bg $global_menu_bg_color -highlightbackground $global_menu_bg_color\
	    -highlightcolor $global_menu_bg_color

    [$frame_printer.nameprinter subwidget entry] configure \
	    -highlightbackground $global_menu_bg_color -highlightcolor $global_menu_bg_color \
	     -font $Font_Bold_9 

    [$frame_printer.nameprinter subwidget label] configure \
	    -bg $global_menu_bg_color -highlightbackground $global_menu_bg_color\
	    -highlightcolor $global_menu_bg_color -font $Font_Bold_9 

    [[$frame_printer.nameprinter subwidget slistbox] subwidget vsb] \
	    configure -bg $global_menu_bg_color 

    [$frame_printer.nameprinter subwidget listbox] configure \
	    -bg white -font $Font_Bold_9 

    pack $frame_printer.nameprinter -side left -expand yes -fill both -padx 3 -pady 3

    set frame_printcommand [frame $frame_princ.printcommand -bg $global_menu_bg_color]
    label $frame_printcommand.label -text "Print command" -font $Font_Bold_9 -bg $global_menu_bg_color

    pack $frame_printcommand -side top -fill both -expand yes -padx 3 -pady 3 
    pack $frame_printcommand.label  -side left 

    entry $frame_printcommand.printcommand -relief sunken -font $Font_Bold_9
    pack $frame_printcommand.printcommand -side left -fill x -expand yes  -padx 3 -pady 3

    tixLabelFrame $frame_princ.buttons -labelside none -bg $global_menu_bg_color
    [$frame_princ.buttons subwidget frame] configure -bg $global_menu_bg_color

    set frame_buttons [$frame_princ.buttons subwidget frame]

    button $frame_buttons.command -text "Print" \
	    -command [subst {Imprimer_Fichier Fichier_Temp_A_Imprimer}] \
	    -font $Font_Bold_9 -bg $global_menu_bg_color \
	    -highlightcolor $global_menu_bg_color -highlightbackground $global_menu_bg_color

    button $frame_buttons.preview -text "Preview" \
	    -command {Afficher_Apercu_Fichier Format_Preview} \
	    -font $Font_Bold_9 -bg $global_menu_bg_color\
	    -highlightcolor $global_menu_bg_color -highlightbackground $global_menu_bg_color
			  
    button $frame_buttons.cancel -text "Cancel" -command {destroy .choose_printer} \
	    -font $Font_Bold_9 -bg $global_menu_bg_color\
	    -highlightcolor $global_menu_bg_color -highlightbackground $global_menu_bg_color

    pack $frame_princ.buttons -side top -fill both -expand yes -padx 3 -pady 3 
    pack $frame_buttons.command $frame_buttons.cancel -side left -expand yes -fill x -padx 5 -pady 5 

    if [catch {exec lpc status | grep : | sort | tr ":" " "} liste_imprimante] {
	Afficher_Message_Erreur "Command \"lpc status | grep ...\" failed" {}
	return
    }

    set nb_imprimante [llength "$liste_imprimante"]

    for {set i 0} {$i < $nb_imprimante} {incr i 1} {  
	set ligne "[lindex $liste_imprimante $i]"
	$frame_printer.nameprinter insert end "$ligne"
    }

    $frame_printcommand.printcommand insert end $imprimante_cmd 
    $frame_printer.nameprinter insert end $imprimante
}

proc Sauvegarder_Postscript {Nom_Fenetre Index_Fichier Format_Vue} {

    global Format_Postscript
    global fenetres
    global Selected_Directory_Name
    global Selected_File_Name 
    global Numero_Transition_Courante

    if {$Nom_Fenetre != ""} {
	Lire_Nom_Fichier $Nom_Fenetre $Index_Fichier $Nom_Fenetre.frame.buttons.frame.command

    }
    set fichier [Join $Selected_Directory_Name($Index_Fichier) \
                      $Selected_File_Name($Index_Fichier)]

    if {$Format_Vue == 1} {

	Afficher_Active_Path_Vue_Msc_Ou_Texte "Msc"

	Msc_Impression_Creer_Fichier $fenetres(1.1.2) item_all $fichier
    }

    if {$Format_Vue == 0} {
	Envoi_Message "save_ps $fichier $Numero_Transition_Courante"
    }

    if {$Format_Vue == 2} {
	Envoi_Message "save_tree_txt $fichier"
    }
}

proc Imprimer_Fichier {Index_Fichier} {

    global imprimante imprimante_cmd 
    global env 
    global Format_Impression
    global fenetres 
    global ocis_temporary_postscript  
    global Selected_File_Name

    set Selected_File_Name($Index_Fichier) $ocis_temporary_postscript
    Sauvegarder_Postscript "" $Index_Fichier $Format_Impression

    set imprimante [[.choose_printer.frame.printer.nameprinter subwidget entry] get]
    set imprimante_cmd [.choose_printer.frame.printcommand.printcommand get]

    if {$imprimante != "" && $imprimante_cmd !=""} then {
	if [catch {eval exec $imprimante_cmd -P$imprimante $ocis_temporary_postscript} res] then {
	    Afficher_Message_Erreur "Printing command \n$imprimante_cmd\nfailed" {}
	} else {
	    Afficher_Message_Erreur "File $ocis_temporary_postscript is being printed" {}
	}

    } else {
	if {$imprimante == ""} {
	    Afficher_Message_Erreur "Unknown printer" {}
	} else {
	    Afficher_Message_Erreur "Unknown command" {}
	}
    }

    destroy .choose_printer
}

proc Afficher_Apercu_Fichier {Index_Fichier} {

    global Format_Preview 
    global env 
    global fenetres
    global ocis_temporary_postscript  
    global Selected_File_Name

    destroy .choose_preview

    if {$Format_Preview == 2} {
	Afficher_Message_Erreur "Previewing \"Tree\" format of current scenario\nis not implemented" {}
	return 0
    }

    set Selected_File_Name($Index_Fichier) $ocis_temporary_postscript
    Sauvegarder_Postscript "" $Index_Fichier $Format_Preview

    set view_command "$env(CADP)/src/com/cadp_postscript $ocis_temporary_postscript"
    if [catch {eval exec sh -c {$view_command} & } resultat] {
	Afficher_Message_Erreur "Command \"$env(CADP)/src/com/cadp_postscript $ocis_temporary_postscript\" failed" {}
	return
    }

}

proc Display_Top_Path_Of_Transition {Index_Fichier} {

    global Arbre_Vue_Tree
    global Transition_Courante_Vue_Tree
    global Numero_Transition_Courante
    global Selected_Directory_Name
    global Selected_File_Name

    set fichier [Join $Selected_Directory_Name($Index_Fichier) \
                      $Selected_File_Name($Index_Fichier)]

    set temp_data_current_node [$Arbre_Vue_Tree info data $Transition_Courante_Vue_Tree]
    set ligne_infos_noeud [lindex $temp_data_current_node 0]

    Envoi_Message "top_path $fichier $Numero_Transition_Courante"

    Lire_Reponse

}

proc Cut_Down_Tree_Of_Transition {} {
    global Arbre_Vue_Tree
    global Transition_Courante_Vue_Tree 
    global Numero_Transition_Courante
    global Nom_Scenario_Courant
    global Flag_Execution_Commande
    global Fenetres_Affichage

    set list_children [$Arbre_Vue_Tree info children $Transition_Courante_Vue_Tree]
    if {[llength $list_children] == 0} {
	return
    }

    set temp_data_current_node [$Arbre_Vue_Tree info data $Transition_Courante_Vue_Tree]
    set ligne_infos_noeud [lindex $temp_data_current_node 0]

    Envoi_Message "number_of_children"
    Lire_Reponse

    global Numero_Ligne_Transition_Courante_Vue_Tree
    global Nombre_Descendants_Transition_Courante

    Effacer_Sequence_Transitions_Colonne_Time $Fenetres_Affichage.3 \
	    $Numero_Ligne_Transition_Courante_Vue_Tree \
	    [expr $Numero_Ligne_Transition_Courante_Vue_Tree + \
	    $Nombre_Descendants_Transition_Courante]
    Effacer_Sequence_Transitions_Colonne_Tasks $Fenetres_Affichage.3 \
	    $Numero_Ligne_Transition_Courante_Vue_Tree \
	    [expr $Numero_Ligne_Transition_Courante_Vue_Tree + \
	    $Nombre_Descendants_Transition_Courante]
    Effacer_Sequence_Transitions_Colonne_Fired $Fenetres_Affichage.3 \
	    $Numero_Ligne_Transition_Courante_Vue_Tree \
	    [expr $Numero_Ligne_Transition_Courante_Vue_Tree + \
	    $Nombre_Descendants_Transition_Courante]

    Envoi_Message "cut_down_tree"

    Lire_Reponse

    Effacer_Descendants_Selectionnes $Transition_Courante_Vue_Tree

    Effacer_Descendants_Caches $Transition_Courante_Vue_Tree

    $Arbre_Vue_Tree delete entry $Transition_Courante_Vue_Tree 

    set temporary_path [eval Enlever_0_Du_Chemin $Transition_Courante_Vue_Tree]

    Envoi_Message "goto $Numero_Transition_Courante $temporary_path"

    Lire_Reponse

    global Pref_Main_Win_Type
    Mettre_A_Jour_Couleur_Et_Texte_Transition $Pref_Main_Win_Type $Numero_Transition_Courante $Transition_Courante_Vue_Tree

    global Numero_Ligne_Transition_Parent_Vue_Tree
    Mettre_A_Jour_Couleur_Et_Texte_Transition 3 $Numero_Ligne_Transition_Courante_Vue_Tree $Transition_Courante_Vue_Tree

}

proc Cut_Current_Transition {} {
    global Arbre_Vue_Tree
    global Transition_Courante_Vue_Tree 
    global Nom_Scenario_Courant
    global Flag_Execution_Commande
    global blue_tree_image leaf_tree_image wait_tree_image
    global Font_Tree_Label
    global Nom_Scenario_Courant
    global Flag_Execution_Commande
    global Pref_Main_Win_Type
    global Fenetres_Affichage
    global Numero_Transition_Courante
    global global_info_temps

    if {$Transition_Courante_Vue_Tree == "0"} {
	return
    }

    global Liste_Transitions_Selectionnees
    set temp_data_current_node [$Arbre_Vue_Tree info data $Transition_Courante_Vue_Tree]
    set ligne_infos_noeud [lindex $temp_data_current_node 0]
    set type_current_transition [lindex $ligne_infos_noeud 1]

    Effacer_Descendants_Selectionnes $Transition_Courante_Vue_Tree

    Effacer_Descendants_Caches $Transition_Courante_Vue_Tree

    Envoi_Message "number_of_children"
    Lire_Reponse

    global Numero_Ligne_Transition_Courante_Vue_Tree
    global Nombre_Descendants_Transition_Courante

    Effacer_Sequence_Transitions_Colonne_Time $Fenetres_Affichage.3 \
	    $Numero_Ligne_Transition_Courante_Vue_Tree \
	    [expr $Numero_Ligne_Transition_Courante_Vue_Tree + \
	    $Nombre_Descendants_Transition_Courante]
    Effacer_Sequence_Transitions_Colonne_Tasks $Fenetres_Affichage.3 \
	    $Numero_Ligne_Transition_Courante_Vue_Tree \
	    [expr $Numero_Ligne_Transition_Courante_Vue_Tree + \
	    $Nombre_Descendants_Transition_Courante]
    Effacer_Sequence_Transitions_Colonne_Fired $Fenetres_Affichage.3 \
	    $Numero_Ligne_Transition_Courante_Vue_Tree \
	    [expr $Numero_Ligne_Transition_Courante_Vue_Tree + \
	    $Nombre_Descendants_Transition_Courante]

    Envoi_Message "cut_current_transition"

    Lire_Reponse

    set father [$Arbre_Vue_Tree info parent $Transition_Courante_Vue_Tree]

    $Arbre_Vue_Tree delete entry $Transition_Courante_Vue_Tree

    set temporary_path [eval Enlever_0_Du_Chemin $father]

    Envoi_Message "goto $Numero_Transition_Courante $temporary_path"

    Lire_Reponse

    Recuperer_Information_Backcode Historique

    if {$Pref_Main_Win_Type == 1} {
	Effacer_Transition_Vue_Msc $Fenetres_Affichage [expr $Numero_Transition_Courante +1]
    } elseif  {$Pref_Main_Win_Type == 2} {
	Effacer_Transition_Vue_Texte $Fenetres_Affichage [expr $Numero_Transition_Courante +1]
	Afficher_Transition_Vue_Texte [expr $Numero_Transition_Courante +1] "" "" "" "" 0 $Fenetres_Affichage 
    }

    set data_node [$Arbre_Vue_Tree info data $Transition_Courante_Vue_Tree]
    set data_transitions_tirees [lindex $data_node 2]

    set type_father [lindex [lindex $data_node 0] 1]
    $Arbre_Vue_Tree entryconfigure $Transition_Courante_Vue_Tree \
	    -data $data_node

    if {$type_father == "T"} {
	$Arbre_Vue_Tree entryconfigure $Transition_Courante_Vue_Tree \
		-image $wait_tree_image
    } else { 
	if {$type_father == "N"} {
	    if {[$Arbre_Vue_Tree info children $Transition_Courante_Vue_Tree] == ""} {

		$Arbre_Vue_Tree entryconfigure $Transition_Courante_Vue_Tree \
			-image $leaf_tree_image
	    } else {

		$Arbre_Vue_Tree entryconfigure $Transition_Courante_Vue_Tree \
			-image $blue_tree_image
	    }
	}
    }

    global Pref_Main_Win_Type
    Mettre_A_Jour_Couleur_Et_Texte_Transition $Pref_Main_Win_Type $Numero_Transition_Courante $Transition_Courante_Vue_Tree

    global Numero_Ligne_Transition_Parent_Vue_Tree
    Mettre_A_Jour_Couleur_Et_Texte_Transition 3 $Numero_Ligne_Transition_Courante_Vue_Tree $Transition_Courante_Vue_Tree

}

proc Save_Sequence_Tree {Index_Fichier} {

    global Transition_Courante_Vue_Tree
    global Selected_Directory_Name
    global Selected_File_Name

    set fichier [Join $Selected_Directory_Name($Index_Fichier) \
                      $Selected_File_Name($Index_Fichier)]

    Envoi_Message "save_sequence $Transition_Courante_Vue_Tree $fichier"

    Lire_Reponse

}

proc Set_Current_Caesar_File {Index_Fichier} {

    global Selected_Directory_Name
    global Selected_File_Name
    global Fichier_Open_Caesar

    set Fichier_Open_Caesar [Join $Selected_Directory_Name($Index_Fichier) \
                                  $Selected_File_Name($Index_Fichier)]
}

proc Changer_Couleur_Entry_Colonne_Tree {entry couleur_entry} {
    global Arbre_Vue_Tree

    switch -exact -- $couleur_entry {
	0 {
	    global blue_tree_image 
	    $Arbre_Vue_Tree entryconfigure $entry -image $blue_tree_image
	}
	1 {
	    global all_fired_tree_image 
	    $Arbre_Vue_Tree entryconfigure $entry -image $all_fired_tree_image
	}
	2 {
	    global leaf_tree_image 
	    $Arbre_Vue_Tree entryconfigure $entry -image $leaf_tree_image
	}
	3 {
	    global wait_tree_image 
	    $Arbre_Vue_Tree entryconfigure $entry -image $wait_tree_image
	}
	4 {
	    global sink_tree_image 
	    $Arbre_Vue_Tree entryconfigure $entry -image $sink_tree_image
	}
	5 {
	    global selection_tree_image 
	    $Arbre_Vue_Tree entryconfigure $entry -image $selection_tree_image
	}
    }
}

proc Colorier_Transition_Selectionnee {entry} {
    global Numero_Transition_Courante
    global Numero_Ligne_Transition_Selectionnee_Vue_Tree

    set temporary_path [eval Enlever_0_Du_Chemin $entry]
    Envoi_Message "line_number_transition $Numero_Transition_Courante $temporary_path"

    Lire_Reponse

    Mettre_A_Jour_Couleur_Et_Texte_Transition 3 $Numero_Ligne_Transition_Selectionnee_Vue_Tree $entry

}

proc Debut_Selection {pos_x pos_y} {
    global Arbre_Vue_Tree
    global Liste_Transitions_Selectionnees

    global Select_Region_Mode
    set Select_Region_Mode 1

    set entry [$Arbre_Vue_Tree nearest $pos_y]

    set entry_index [lsearch -exact $Liste_Transitions_Selectionnees $entry]
    if {$entry_index == -1} {

	lappend Liste_Transitions_Selectionnees $entry

	Changer_Couleur_Entry_Colonne_Tree $entry 5

    } else {

	set Liste_Transitions_Selectionnees \
		[lreplace $Liste_Transitions_Selectionnees \
		$entry_index $entry_index]

	set couleur_entry [Determiner_Numero_Couleur_Transition $entry]
	Changer_Couleur_Entry_Colonne_Tree $entry $couleur_entry

    }

    Colorier_Transition_Selectionnee $entry

}

proc Bouger_Selection {pos_x pos_y} {
    global Arbre_Vue_Tree
    global Liste_Transitions_Selectionnees

    set entry [$Arbre_Vue_Tree nearest $pos_y]

    set entry_index [lsearch -exact $Liste_Transitions_Selectionnees $entry]
    if {$entry_index == -1} {

	lappend Liste_Transitions_Selectionnees $entry

	Changer_Couleur_Entry_Colonne_Tree $entry 5

	Colorier_Transition_Selectionnee $entry
    }
}

proc Lister_Transitions_Selectionnees {} {
    global Liste_Transitions_Selectionnees

    puts stdout "Liste des transitions selectionnees"

    for {set num_element_liste 0} \
	    {$num_element_liste < [llength $Liste_Transitions_Selectionnees]}\
	    {incr num_element_liste 1} {
	set element_liste [lrange $Liste_Transitions_Selectionnees \
		$num_element_liste $num_element_liste]
	puts stdout "*** element $num_element_liste: $element_liste"
    }
}

proc Lister_Transitions_Cachees {} {
    global Liste_Transitions_Cachees

    puts stdout "Liste des transitions cachees"

    for {set num_element_liste 0} \
	    {$num_element_liste < [llength $Liste_Transitions_Cachees]}\
	    {incr num_element_liste 1} {
	set element_liste [lrange $Liste_Transitions_Cachees \
		$num_element_liste $num_element_liste]
	puts stdout "*** element $num_element_liste: $element_liste"
    }
}

proc Selectionner_Transition_Courante {} {
    global Transition_Courante_Vue_Tree
    global Numero_Transition_Courante

    global Pref_Main_Win_Type
    if {$Pref_Main_Win_Type != 3} {

	return
    } else {

	Selectionner_Transition $Transition_Courante_Vue_Tree 0
    }
}

proc Selectionner_Transition {Chemin_Transition Ligne_Cliquee} {
    global Liste_Transitions_Selectionnees
    global Arbre_Vue_Tree
    global Transition_Courante_Vue_Tree
    global Numero_Ligne_Transition_Courante_Vue_Tree
    global Pref_Main_Win_Type

    set entry_index [lsearch -exact $Liste_Transitions_Selectionnees $Chemin_Transition]
    if {$entry_index == -1} {

	lappend Liste_Transitions_Selectionnees $Chemin_Transition

	Changer_Couleur_Entry_Colonne_Tree $Chemin_Transition 5

	if {$Chemin_Transition == $Transition_Courante_Vue_Tree} {
	    Mettre_A_Jour_Couleur_Et_Texte_Transition 3 $Numero_Ligne_Transition_Courante_Vue_Tree $Transition_Courante_Vue_Tree

	    if {$Pref_Main_Win_Type != 3} {
		Mettre_A_Jour_Couleur_Et_Texte_Transition $Pref_Main_Win_Type $Ligne_Cliquee $Transition_Courante_Vue_Tree

	    }
	} else {
	    
	    Colorier_Transition_Selectionnee $Chemin_Transition

	    if {$Pref_Main_Win_Type != 3} {
		Mettre_A_Jour_Couleur_Et_Texte_Transition $Pref_Main_Win_Type $Ligne_Cliquee $Chemin_Transition
	    }
	}
    }
}

proc Liberer_Transitions_Selectionnees {} {
    global Liste_Transitions_Selectionnees
    global Liste_Transitions_Cachees
    global Arbre_Vue_Tree

    global Pref_Main_Win_Type
    if {$Pref_Main_Win_Type != 3} {

	return
    }

    set entry_index 0
    while {[expr [llength $Liste_Transitions_Selectionnees] > 0]} {
	set entry [lrange $Liste_Transitions_Selectionnees \
		$entry_index $entry_index]

	set Liste_Transitions_Selectionnees \
		[lreplace $Liste_Transitions_Selectionnees \
		$entry_index $entry_index]

	set couleur_entry [Determiner_Numero_Couleur_Transition $entry]
	Changer_Couleur_Entry_Colonne_Tree $entry $couleur_entry

	Colorier_Transition_Selectionnee $entry
    }

    set Liste_Transitions_Cachees ""

}

proc Fermer_Transitions_Selectionnees {} {
    global Liste_Transitions_Selectionnees
    global Liste_Transitions_Cachees
    global Pref_Main_Win_Type w_pane_top
    global Transition_Courante_Vue_Tree

    global Select_Region_Mode 
    set Select_Region_Mode 0

    set Pref_Main_Win_Type 3
    $w_pane_top.note raise $Pref_Main_Win_Type

    set Orig_Transition_Courante_Vue_Tree $Transition_Courante_Vue_Tree

    set Liste_Transitions_Selectionnees \
	    [lsort -increasing $Liste_Transitions_Selectionnees]

    set Orig_Liste_Transitions_Selectionnees $Liste_Transitions_Selectionnees

    set Liste_Transitions_Selectionnees {}

    set i 0
    set j 0
    while {[expr ($i < [llength $Orig_Liste_Transitions_Selectionnees]) && \
	    ($j < [llength $Orig_Liste_Transitions_Selectionnees])]} {

	lappend Liste_Transitions_Selectionnees \
		[lindex $Orig_Liste_Transitions_Selectionnees $i]
	set j [expr $i+1]
	while {[expr $j < [llength $Orig_Liste_Transitions_Selectionnees]]} {

	    if {[expr [string first [lindex $Orig_Liste_Transitions_Selectionnees $i] [lindex $Orig_Liste_Transitions_Selectionnees $j]] == 0]} {
		incr j 1
	    } else {
		set i $j
		break
	    }
	}
    }

    global DEBUG_MODE_PROTOCOL
    if {$DEBUG_MODE_PROTOCOL == 1} {
	Lister_Transitions_Selectionnees
    }

    for {set num_element_liste 0} \
	    {$num_element_liste < [llength $Liste_Transitions_Selectionnees]}\
	    {incr num_element_liste 1} {
	set element_liste [lrange $Liste_Transitions_Selectionnees \
		$num_element_liste $num_element_liste]

	if [expr [lsearch -exact $Liste_Transitions_Cachees $element_liste] == -1] {
	    set Liste_Transitions_Cachees \
		[lappend Liste_Transitions_Cachees $element_liste]
	}

	set temp_list [split $element_liste /]
	set profondeur_element_liste [llength $temp_list]

	set temporary_path [eval Enlever_0_Du_Chemin $element_liste]

	global Numero_Transition_Courante
	Envoi_Message "goto $Numero_Transition_Courante $temporary_path"

	Lire_Reponse

	Recuperer_Information_Backcode Historique

	global tree_path
	set mode_element_liste [$tree_path getmode $element_liste]
	if {$mode_element_liste == "close"} {
	    Commande_Fermeture_Transition_Vue_Tree 0 $element_liste
	}
    }

    set Liste_Transitions_Selectionnees $Orig_Liste_Transitions_Selectionnees

    for {set num_element_liste 0} \
	    {$num_element_liste < [llength $Liste_Transitions_Cachees]}\
	    {incr num_element_liste 1} {
	set element_liste [lrange $Liste_Transitions_Cachees \
		$num_element_liste $num_element_liste]
	if {[expr [string first $element_liste $Orig_Transition_Courante_Vue_Tree] == 0]} {
	    set Orig_Transition_Courante_Vue_Tree $element_liste
	    break
	}
    }

    if {$Orig_Transition_Courante_Vue_Tree != $Transition_Courante_Vue_Tree} {

	set Orig_Transition_Courante_Vue_Tree \
		[eval Enlever_0_Du_Chemin $Orig_Transition_Courante_Vue_Tree]

	global Numero_Transition_Courante
	Envoi_Message "goto $Numero_Transition_Courante \
		$Orig_Transition_Courante_Vue_Tree"

	Lire_Reponse

	Recuperer_Information_Backcode Historique
    }

}

proc Ouvrir_Transitions_Selectionnees {} {
    global Liste_Transitions_Cachees
    global Pref_Main_Win_Type w_pane_top
    global Numero_Transition_Courante
    global Transition_Courante_Vue_Tree

    global Select_Region_Mode
    set Select_Region_Mode 0

    set Pref_Main_Win_Type 3
    $w_pane_top.note raise $Pref_Main_Win_Type

    set Orig_Transition_Courante_Vue_Tree $Transition_Courante_Vue_Tree

    set Temp_Liste_Transitions_Cachees \
	    [lsort $Liste_Transitions_Cachees]    

    global DEBUG_MODE_PROTOCOL
    if {$DEBUG_MODE_PROTOCOL == 1} {
	Lister_Transitions_Cachees
    }

    set Liste_Transitions_Cachees "" 

    for {set num_element_liste 0} \
	    {$num_element_liste < [llength $Temp_Liste_Transitions_Cachees]}\
	    {incr num_element_liste 1} {

	set element_liste [lrange $Temp_Liste_Transitions_Cachees \
		$num_element_liste $num_element_liste]

	set temp_list [split $element_liste /]
	set profondeur_element_liste [llength $temp_list]

	set temporary_path [eval Enlever_0_Du_Chemin $element_liste]

	global Numero_Transition_Courante
	Envoi_Message "goto $Numero_Transition_Courante $temporary_path"

	Lire_Reponse

	Recuperer_Information_Backcode Historique

	global tree_path
	global Arbre_Vue_Tree
	set Ouverture_Possible 1
	set father $element_liste
	while {$father != "0"} {
	    set father [$Arbre_Vue_Tree info parent $father]
	    if {([lsearch -exact $Temp_Liste_Transitions_Cachees $father] <0) &&  ([$tree_path getmode $father] == "open")} {
		set Ouverture_Possible 0
		break
	    }
	}

	set mode_element_liste [$tree_path getmode $element_liste]
	if {$Ouverture_Possible == 1 && $mode_element_liste == "open"} {
	    Commande_Ouverture_Transition_Vue_Tree 0 $element_liste
	} else {

	    set Liste_Transitions_Cachees \
		    [lappend Liste_Transitions_Cachees $element_liste]
	}

    }

    global DEBUG_MODE_PROTOCOL
    if {$DEBUG_MODE_PROTOCOL == 1} {
	Lister_Transitions_Cachees
    }

    if {$Orig_Transition_Courante_Vue_Tree != $Transition_Courante_Vue_Tree} {

	set Orig_Transition_Courante_Vue_Tree \
		[eval Enlever_0_Du_Chemin $Orig_Transition_Courante_Vue_Tree]

	global Numero_Transition_Courante
	Envoi_Message "goto $Numero_Transition_Courante \
		$Orig_Transition_Courante_Vue_Tree"

	Lire_Reponse

	Recuperer_Information_Backcode Historique
    }

}

proc Selectionner_Transitions_Specifiques {entry} {
    global Liste_Transitions_Selectionnees
    global Arbre_Vue_Tree
    global Label_A_Selectionner
    global Number_Selected_Specific_Transitions

    set data_entry [$Arbre_Vue_Tree info data $entry]
    set label_entry [lindex $data_entry 0]
    set label_entry [lindex $label_entry 2]

    if {$Label_A_Selectionner == $label_entry} {

	incr Number_Selected_Specific_Transitions 1

	set entry_index [lsearch -exact $Liste_Transitions_Selectionnees \
		$entry]
	if {$entry_index == -1} {

	    lappend Liste_Transitions_Selectionnees $entry

	    Changer_Couleur_Entry_Colonne_Tree $entry 5

	    Colorier_Transition_Selectionnee $entry
	}
    }

    set liste_fils [$Arbre_Vue_Tree info children $entry]
    foreach fils $liste_fils {
	Selectionner_Transitions_Specifiques $fils
    }
}

proc Effacer_Descendants_Selectionnes {entree_courante} {
    global Liste_Transitions_Selectionnees
    global Arbre_Vue_Tree

    if {[llength $Liste_Transitions_Selectionnees] == 0} {
	return
    }

    set entry_index [lsearch -exact $Liste_Transitions_Selectionnees $entree_courante]
    if {$entry_index >= 0} {

	set Liste_Transitions_Selectionnees \
		[lreplace $Liste_Transitions_Selectionnees \
		$entry_index $entry_index]
    }

    set liste_fils [$Arbre_Vue_Tree info children $entree_courante]
    foreach fils $liste_fils {
	Effacer_Descendants_Selectionnes $fils
    }
}

proc Effacer_Descendants_Caches {entree_courante} {
    global Liste_Transitions_Cachees
    global Arbre_Vue_Tree

    if {[llength $Liste_Transitions_Cachees] == 0} {
	return
    }

    set entry_index [lsearch -exact $Liste_Transitions_Cachees $entree_courante]
    if {$entry_index >= 0} {

	set Liste_Transitions_Cachees \
		[lreplace $Liste_Transitions_Cachees \
		$entry_index $entry_index]
    }

    set liste_fils [$Arbre_Vue_Tree info children $entree_courante]
    foreach fils $liste_fils {
	Effacer_Descendants_Caches $fils
    }
}

proc Ouvrir_Fenetre_Selection_Label {} {
    global Titre_Fenetres
    global Foreground_Windows
    global global_menu_bg_color global_bg_color
    global Font_Bold_9 Font_Bold_10

    if [winfo exists .selection_label] then {
	wm deiconify .selection_label
	raise .selection_label
	return 0
    }
    toplevel .selection_label
    wm geometry .selection_label 300x200
    wm title .selection_label "$Titre_Fenetres ... Selecting a label"
    bind .selection_label <Control-c> "destroy .selection_label"
    if {$Foreground_Windows == 1} {
	bind .selection_label <Enter> "raise .selection_label"
    }

    frame .selection_label.frame -bg $global_menu_bg_color 
    set frame_princ .selection_label.frame
    $frame_princ configure -bg $global_menu_bg_color \
	    -highlightcolor $global_menu_bg_color \
	    -highlightbackground $global_menu_bg_color
    pack $frame_princ -side top -expand yes -fill both

    set frame_label [frame $frame_princ.label -bg $global_menu_bg_color]
    label $frame_label.label -text "Selecting specific transitions" \
	    -font $Font_Bold_10 -bg $global_menu_bg_color
    pack $frame_label -side top -fill both -expand yes -padx 3 -pady 3 
    pack $frame_label.label  -side top

    set frame_entree [frame $frame_princ.entree -bg $global_menu_bg_color]
    $frame_entree configure -borderwidth 1 -relief raised
    label $frame_entree.label -text "Label to be selected: " \
	    -font $Font_Bold_9 -bg $global_menu_bg_color
    entry $frame_entree.entry -relief sunken -font $Font_Bold_9
    pack $frame_entree -side top -fill x -expand yes
    pack $frame_entree.label -side left -padx 6
    pack $frame_entree.entry -side left -fill x -expand yes

    global Label_Selection_Starting_State

    set frame_start [frame $frame_princ.start -bg $global_menu_bg_color]
    $frame_start configure -borderwidth 1 -relief raised
    label $frame_start.label -text "Starting state" \
	    -font $Font_Bold_9 -bg $global_menu_bg_color 
    radiobutton $frame_start.init -text "Initial State" -value 0 \
	    -font $Font_Bold_9 -variable Label_Selection_Starting_State \
	    -bg $global_menu_bg_color -highlightcolor $global_menu_bg_color\
	    -highlightbackground $global_menu_bg_color
    radiobutton $frame_start.step -text "Current state" -value 1 \
	    -font $Font_Bold_9 \
	    -variable Label_Selection_Starting_State\
	    -bg $global_menu_bg_color -highlightcolor $global_menu_bg_color\
	    -highlightbackground $global_menu_bg_color
    pack $frame_start -side top -fill both -expand yes
    pack $frame_start.label -side top
    pack $frame_start.init -side left
    pack $frame_start.step -side right

    if {$Label_Selection_Starting_State == 1} {
	$frame_start.step invoke
    } else {
	$frame_start.init invoke 
    }

    tixLabelFrame $frame_princ.buttons -labelside none \
	    -bg $global_menu_bg_color
    [$frame_princ.buttons subwidget frame] configure -bg $global_menu_bg_color
    set frame_buttons [$frame_princ.buttons subwidget frame]
    button $frame_buttons.select -text "Select" -font $Font_Bold_9 \
	    -command {Commande_Selectionner_Transitions_Specifiques .selection_label.frame.entree.entry .selection_label.frame.result.label} \
		    -bg $global_menu_bg_color
    button $frame_buttons.cancel -text "Close" -font $Font_Bold_9 \
	    -command "destroy .selection_label" -bg $global_menu_bg_color
    pack $frame_princ.buttons -side top -fill both -expand yes -padx 3 -pady 3 
    pack $frame_buttons.select $frame_buttons.cancel \
	    -side left  -expand yes -fill x -padx 5 -pady 5 

    set frame_result [frame $frame_princ.result -bg $global_menu_bg_color]
    $frame_result configure -borderwidth 1 -relief raised
    label $frame_result.label -text "Number of selected transitions: " \
	    -font $Font_Bold_9 -width 30 -bg $global_menu_bg_color
    pack $frame_result -side top -fill x -expand yes
    pack $frame_result.label -side left -padx 6 -pady 3

}

proc Commande_Selectionner_Transitions_Specifiques {widget_entry widget_result} {
    global Label_A_Selectionner
    global Transition_Courante_Vue_Tree
    global Label_A_Selectionner
    global Label_Selection_Starting_State
    global Number_Selected_Specific_Transitions

    global Pref_Main_Win_Type w_pane_top
    set Pref_Main_Win_Type 3
    $w_pane_top.note raise $Pref_Main_Win_Type

    set Label_A_Selectionner [$widget_entry get]

    set Number_Selected_Specific_Transitions 0

    if {$Label_Selection_Starting_State == 1} {

	Selectionner_Transitions_Specifiques $Transition_Courante_Vue_Tree
    } else {

	Selectionner_Transitions_Specifiques 0
    }

    $widget_result configure -text "Number of selected transitions: \
	    $Number_Selected_Specific_Transitions"

}

proc Ouvrir_Parents_Transition {entry_courante} {
    global Arbre_Vue_Tree
    global tree_path
    global Numero_Transition_Courante

    if {$entry_courante != "0"} {

	set list_open_parents {}
	set father [$Arbre_Vue_Tree info parent $entry_courante]

	while {$father != ""} {
	    set mode_father [$tree_path getmode $father]
	    if {$mode_father == "open"} {
		set list_open_parents [linsert $list_open_parents 0 $father]
	    }
	    set father [$Arbre_Vue_Tree info parent $father]
	}

	for {set index_father 0} \
		{$index_father < [llength $list_open_parents]} \
		{incr index_father 1} {

	    set father [lindex $list_open_parents $index_father]

	    set temporary_father [eval Enlever_0_Du_Chemin $father]

	    Envoi_Message "goto $Numero_Transition_Courante $temporary_father"
	    Lire_Reponse
	    Commande_Ouverture_Transition_Vue_Tree 0 $father
	}
    }
}

proc Couper_Transitions_Selectionnees {} {
    global Liste_Transitions_Selectionnees
    global Numero_Transition_Courante

    if {[llength $Liste_Transitions_Selectionnees] == 0} {

	return 
    } else {

	set entry_courante [lindex $Liste_Transitions_Selectionnees 0]

	if {$entry_courante == "0"} {
	    return
	}

	Ouvrir_Parents_Transition $entry_courante

	set temp_list [split $entry_courante /]
	set profondeur_entry_courante [llength $temp_list]

	set temporary_path [eval Enlever_0_Du_Chemin $entry_courante]

	Envoi_Message "goto $Numero_Transition_Courante $temporary_path"

	Lire_Reponse

	if {[eval Cut_Current_Transition] == 1} {
	    return
	}

	Couper_Transitions_Selectionnees

    }

}

proc Enlever_0_Du_Chemin {chemin} {

    set temporary_path $chemin
    set ligne1 [split $temporary_path /]
    set ligne2 [lreplace $ligne1 0 0]
    if {[llength $ligne2 ] >= 1} then { 
	set ligne3 [join $ligne2 /]
	set temporary_path $ligne3
    } 
    return $temporary_path
}

proc Initialiser_Menu_Help {w} {

    global menu_help
    global w_m_scenario 
    global w_m_edit
    global w_m_backcode
    global w_m_run 
    global w_m_simulation_options
    global w_m_help

    global env

    set menu_help($w_m_scenario#)   "File"
    set menu_help($w_m_scenario#reset)          "Reset current scenario"
    set menu_help($w_m_scenario#new)            "Start a new scenario"
    set menu_help($w_m_scenario#load)           "Select and load an existing scenario"
    set menu_help($w_m_scenario#saveas)         "Select a name for the current scenario and save it"
    set menu_help($w_m_scenario#save)           "Save current scenario"
    set menu_help($w_m_scenario#savesequencetree)           "Save the sub-tree going through the current transition into a .bcg file"
    set menu_help($w_m_scenario#saveasequenceoflabels) \
	    "Save the sequence of labels along the current path into a .seq file"
    set menu_help($w_m_scenario#savepostscript) \
	    "Generate a postscript file for the current scenario in MSC, Text, or Tree format"
    set menu_help($w_m_scenario#printpostscript) \
	    "Print current scenario in MSC, Text, or Tree format"
    set menu_help($w_m_scenario#previewpostscript) \
	    "Show prostscript preview of current scenario in MSC, Text, or Tree format"
    set menu_help($w_m_scenario#quit)           "Quit OCIS"

    set menu_help($w_m_edit#)    "Edit"
    set menu_help($w_m_edit#selectcurrenttransition(treeviewonly))   "Add the current transition to the list of selected transitions (Applicable only in the TREE view)"
    set menu_help($w_m_edit#disableselection(treeviewonly))   "Disable the selected transitions (Applicable only in the TREE view)"
    set menu_help($w_m_edit#selectspecifictransitions(treeviewonly))   "Open dialog box for selecting transitions having a specific label (Applicable only in the TREE view)"
    set menu_help($w_m_edit#closeselectedtransitions(treeviewonly))    "Close open selected transitions (Applicable only in the TREE view)"
    set menu_help($w_m_edit#openselectedtransitions(treeviewonly))    "Open closed selected transitions (Applicable only in the TREE view)"
    set menu_help($w_m_edit#cutselectedtransitions)        "Cut selected transitions"
    set menu_help($w_m_edit#cutcurrenttransition)        "Cut current transition"
    set menu_help($w_m_edit#cutdowntreeofcurrenttransition)        "Cut all the sequences going out from the current transition"
    set menu_help($w_m_edit#findregularexpressions)      \
	    "Open window for finding specific sequences defined by regular expressions"

    set menu_help($w_m_edit#executeasequenceoflabels) \
	    "Open window for selecting and executing a sequence defined by a series of labels"
    set menu_help($w_m_edit#cutdowntree) \
	    "Cut the successors of the current transition"
    set menu_help($w_m_edit#cutcurrenttransition) \
	    "Cut the current transition and its successors"
    set menu_help($w_m_edit#savesequencetree) \
	    "Save the path ending at the current transition \
	    and the sub-trees starting at its successors"

    set menu_help($w_m_run#)                "Navigating through scenarii"
    set menu_help($w_m_run#backward)        "Go 1 step backward"
    set menu_help($w_m_run#forward)         "Go 1 step forward"
    set menu_help($w_m_run#showcurrenttransition)         "Make current transition visible"
    set menu_help($w_m_run#showtop)         "Make the initial transition visible"

    set menu_help($w_m_backcode#) "Opening debugging windows"
    set menu_help($w_m_backcode#editsourcefile)       "Open window for selecting and editing a file"
    set menu_help($w_m_backcode#viewingsourcecode)  \
	    "Open window for viewing the trace of the execution of the specification program"
    set menu_help($w_m_backcode#recompile)      "Open window for recompiling the specification program"
    set menu_help($w_m_backcode#openshellwindow)      "Open shell window"

    set menu_help($w_m_simulation_options#) "Selecting simulation options"
    set menu_help($w_m_simulation_options#autoadvancemode) \
	    "Firing autimatically the transitions when the choics is deterministic"
    set menu_help($w_m_simulation_options#loopbackchecking) \
	    "Display additional information when loopback is detected (for MSC and Text formats only)"
    set menu_help($w_m_simulation_options#extendedmscformat) \
	    "Display additional information on the tasks (for MSC format only)"
    set menu_help($w_m_simulation_options#extendedtreeformat) \
	    "Display additional information (for Tree format only)"

    set menu_help($w_m_simulation_options#makewindowsforeground)  \
	    "Make foreground the windows which are traversed by the mouse"

    set menu_help($w_m_simulation_options#savepreferencesincurrentdirectory)  \
	    "Save simulation preferences in the file \".ocisrc\" in the current directory"
    set menu_help($w_m_simulation_options#savepreferencesinhomedirectory)  \
	    "Save simulation preferences in the file \".ocisrc\" in the home directory $env(HOME)"
    set menu_help($w_m_simulation_options#resetpreferences)  \
	    "Erase the current .ocisrc file"

    set menu_help($w_m_help#)               ""
    set menu_help($w_m_help#index)          "On-line Help"
    set menu_help($w_m_help#about)          "About OCIS ..."

    set menu_help($w_m_simulation_options.simulation_pref#)    ""
    set menu_help($w_m_simulation_options#popupwindow) "Pop up all view windows"
    set menu_help($w_m_simulation_options#iconbarsetup)   "Customize iconbar"

    set menu_help($w.view.m#)               ""
    set menu_help($w.view.m#mainwindow)     "Change top window view"
    set menu_help($w.view.m#transitionwindow) "Change transition view"
    set menu_help($w.view.m#source)         "Enable/disable source window"
    set menu_help($w.view.m#iconbar)        "Enable/disable iconbar"

    set menu_help($w.view.m.main#)          ""
    set menu_help($w.view.m.main#mscdiagram) "Toggle MSC Diagram view"
    set menu_help($w.view.m.main#trace)     "Toggle trace view"
    set menu_help($w.view.m.main#tree)      "Toggle tree view"

    set menu_help($w.view.m.trans#)         ""
    set menu_help($w.view.m.trans#mscview)  "Toggle MSC Diagram view"
    set menu_help($w.view.m.trans#timeview) "Toggle Time view"
    set menu_help($w.view.m.trans#textview) "Toggle Text view"

    set menu_help(.popup_menu_main_texte#)		""
    set menu_help(.popup_menu_main_texte#back)  	"Go back"
    set menu_help(.popup_menu_main_texte#infos)	  	"Task(s) information"
    set menu_help(.popup_menu_main_texte#source)       	"Task(s) source code"
    set menu_help(.popup_menu_main_texte#reset)       	"Restart simulation"
    set menu_help(.popup_menu_main_texte#goto)       	"Launch Exhibitor"

    set menu_help(.popup_menu_trans_texte#)		""
    set menu_help(.popup_menu_trans_texte#next)		"Select Transition"
    set menu_help(.popup_menu_trans_texte#infos)	"Task(s) information"
    set menu_help(.popup_menu_trans_texte#source)       "Task(s) source code"

}

proc Initialiser_Bindings_Menu_Help {} {

    global menu_help

    bind Menu <<MenuSelect>> {
	if {[catch {%W entrycget active -label} label]} {
	    set label "    "
	    $main.status configure -text $label
	} else {
	    set p1 ""
	    set p [string tolower [string trim "$label" ". "]]
	    eval "append p1 $p"
	    if [info exists menu_help(%W#$p1)] {
		$main.status configure -text $menu_help(%W#$p1)
	    }
	}
    }
}

proc Initialiser_Balloon_Help {w status} {
    global w_balloon_help

    set w_balloon_help $w.balloon_help
    tixBalloon $w_balloon_help -state both -statusbar $status
}

set help_window .help
proc help_config {w} {
    global Font_Bold_10 Font_Bold_24

  $w tag configure bold -font $Font_Bold_10
  $w tag configure italic -font $Font_Bold_10
  $w tag configure title -foreground darkgreen -font $Font_Bold_24
  $w tag configure link -underline 1 -foreground blue
  $w tag configure under -underline 1
}

proc help_add_link {w tagname text link_proc} {
  $w insert end "$text" [list $tagname link bold]
  $w tag bind $tagname <1> "$link_proc $w"
  $w tag bind $tagname <Enter> "$w config -cursor hand2"
  $w tag bind $tagname <Leave> "$w config -cursor xterm"
}

proc help_clear {w} {
  $w delete 1.0 end
}
proc help_add_hr {w} {
  $w insert end "---------------------------------\n"
}
proc help_add {w style text} {
  $w insert end $text $style
}
proc help_add_pic {w file} {
  $w image create end -image [tix getimage $file]
}
proc help_start {w} {
  $w configure -state normal
}
proc help_end {w} {
  $w configure -state disabled
}
proc help_add_index {w path text style } {
  $w add $path -text $text -style $style 
}
proc help_make_index {w dest} {
    global Font_Bold_10 Font_Bold_12 Font_Bold_24

  set l [$w subwidget hlist]

  set style1 [tixDisplayStyle text -refwindow $l -fg black -font $Font_Bold_12]
  set style2 [tixDisplayStyle text -refwindow $l -fg blue3 -font $Font_Bold_12]
  set style3 [tixDisplayStyle text -refwindow $l -fg blue4 -font $Font_Bold_10]

  $l add help -text "OCIS" -state disabled -style $style1
  help_add_index $l help_intro "Introduction" $style2 
  help_add_index $l help_overv "General Overview" $style2
  help_add_index $l help_menus "Menus" $style2
  help_add_index $l help_menus_file "File" $style3
  help_add_index $l help_menus_edit "Edit" $style3
  help_add_index $l help_menus_motion "Motion" $style3
  help_add_index $l help_menus_window "Window" $style3
  help_add_index $l help_menus_options "Options" $style3
  help_add_index $l help_menus_help "Help" $style3
  help_add_index $l help_toolbar "Toolbar" $style2
  help_add_index $l help_views "Views" $style2
  help_add_index $l help_views_msc "MSC" $style3
  help_add_index $l help_views_text "Text" $style3
  help_add_index $l help_views_tree "Tree" $style3
  help_add_index $l help_nav "Input/Output capabilities" $style2
  help_add_index $l help_infosource "Information & source" $style2
  help_add_index $l help_about "About OCIS" $style2
}

proc help_goto {w path} {
  set cmd "$path $w"
  eval $cmd
}

proc mk_help_window {w} {
    global global_menu_bg_color 
    global Font_Bold_12

  frame $w.bottom -bg $global_menu_bg_color 
  frame $w.top -bg $global_menu_bg_color 

  pack $w.bottom -side bottom -fill x
  pack $w.top -fill both -expand yes

  button $w.bottom.close -text "Close" -command "destroy $w" -bg $global_menu_bg_color 
  pack $w.bottom.close

  tixPanedWindow $w.top.pane -separatorbg gray50 -orient horizontal\
                 -handleactivebg red -bg $global_menu_bg_color 

  pack $w.top.pane -fill both -expand yes

  set index [$w.top.pane add index -min 100 -size 150 -expand 0.0]
  set contents [$w.top.pane add contents -min 100 -size 500 -expand 1.0]

  label $index.title -text "INDEX" -anchor c -font $Font_Bold_12 \
	  -bg $global_menu_bg_color 
  label $contents.title -text "DESCRIPTION" -anchor c -font $Font_Bold_12 \
	  -bg $global_menu_bg_color 
  tixScrolledHList $index.tree 
  tixScrolledText $contents.text -scrollbar auto

  set index_tree [$index.tree subwidget hlist]
  set contents_text [$contents.text subwidget text]
  $contents_text configure -wrap word
  $index_tree configure -drawbranch 0 -indent 10 \
              -browsecmd "help_goto $contents_text" -separator "_"

  $index.tree subwidget vsb configure -width 10
  $index.tree subwidget hsb configure -width 10
  $contents.text subwidget vsb configure -width 10
  $contents.text subwidget hsb configure -width 10

  pack $index.title -fill x -side top
  pack $index.tree -fill both -expand yes
  pack $contents.title -fill x -side top
  pack $contents.text -fill both -expand yes

  help_config $contents_text
  help_make_index $index.tree $contents.text
  return $contents_text
}

proc help_show {rub} {
    global help_window 
    global help_contents
    global Titre_Fenetres
    global Width_Win_Help Height_Win_Help 
    global Win_Help_X_Position Win_Help_Y_Position

  if {[winfo exists $help_window]} {
    wm deiconify $help_window
    eval "$rub $help_contents"
  } else {
    toplevel $help_window
    wm title $help_window "$Titre_Fenetres ... Help"
    wm geometry $help_window ${Width_Win_Help}x${Height_Win_Help}+${Win_Help_X_Position}+${Win_Help_Y_Position} 
    bind $help_window <Configure> ComputeRulesWinHelp
    bind $help_window <Control-c> "destroy $help_window"
    set help_contents [mk_help_window $help_window]
    eval "$rub $help_contents"
  }

}



proc help_about {w} {
    global Ocis_Version 
    global Ocis_Authors

  help_start $w
  help_clear $w
  help_add $w title "About OCIS\n\n"

  help_add $w bold "Open/Caesar Interactive Simulator"
  help_add $w "" " $Ocis_Version \n\n"

  help_add $w bold "Authors:\n\n"
  help_add $w "" "    $Ocis_Authors\n\n"

  help_add $w bold "Address:\n\n"
  help_add $w "" "    CONVECS team\n"
  help_add $w "" "    INRIA Grenoble Rhone-Alpes\n"
  help_add $w "" "    655, avenue de l'Europe\n"
  help_add $w "" "    38330 Montbonnot Saint-Martin\n"
  help_add $w "" "    France\n\n"

  help_add $w bold "Internet:\n\n"
  help_add $w "" "    http://cadp.inria.fr"
  help_add $w "" "    http://vasy.inria.fr and http://convecs.inria.fr\n"

  help_end $w
}

proc help_intro {w} {
  help_start $w
  help_clear $w
  help_add $w title "Introduction\n\n"
  help_add $w bold "Presentation\n\n"
  help_add $w "" "OCIS (Open/Caesar Interactive Simulator) is a interactive "
  help_add $w "" "simulator with X-windows interface for the CADP toolset.\n"
  help_add $w "" "  It has been devised in order to replace the "
  help_add $w bold "Simulator/XSimulator"
  help_add $w "" " tool.\n\n"
  help_add $w bold "Main features of OCIS\n\n"
  help_add $w "" " - Use of MSC-like diagrams to visualize synchronization betwwen tasks\n"
  help_add $w "" " - Debugging capabilities including on-line compililation of the specification programs, visualizing of the source code executed instantaneously by each task and tracing the state variables\n"
  help_add $w "" " - Handling multiple simulation scenarios\n "
  help_add $w "" " - Automatic navigation\n"
  help_add $w "" " - Automatic navigation by searching desired execution sequences or regular expressions\n"
  help_add $w "" " - Handling input-output scenario files encoded in the BCG-format\n"
  help_end $w
}

proc help_overv {w} {
  help_start $w
  help_clear $w
  help_add $w title "General overview\n\n"

  help_add $w "" "Selecting one of the entries of this menu is the same as "
  help_add $w "" "selecting the visual \"tabs\" in each window.\n\n"
  help_add $w "" "You can find more information about these views in the "
  help_add_link $w link_views "views description" help_views
  help_add $w "" " section.\n\n"
  help_add $w bold "Main view\n"
  help_add $w italic " . MSC History\n"
  help_add $w "" "  History is shown as MSC-like diagrams\n\n"
  help_add $w italic " . Text History\n"
  help_add $w "" "  History is shown as text\n\n"
  help_add $w italic " . Tree History\n"
  help_add $w "" "  A hierarchy of explored histories is shown\n\n"
  help_add $w bold "Transition window\n"
  help_add $w italic " . MSC Transitions\n"
  help_add $w "" "  Transitions are shown as MSC-like diagrams\n\n"
  help_add $w italic " . Text Transitions\n"
  help_add $w "" "  Transitions are shown as MSC-like diagrams\n\n"

  help_add $w bold "Components\n\n"
  help_add_pic $w main_win
  help_add $w "" "\n\n"
  help_add_link $w link_menu "Menu bar" help_menus
  help_add $w "" "\n -> Operations\n\n"
  help_add_link $w link_roolbar "Toolbar" help_toolbar
  help_add $w "" "\n -> Shortcuts for menu entries\n\n"
  help_add_link $w link_views "View windows" help_views
  help_add $w "" "\n -> History & transitions selection\n\n"
  help_end $w
}

proc help_menus {w} {
  help_start $w
  help_clear $w
  help_add $w title "Menus\n\n"
  help_add $w "" "The following menus are available:\n\n"
  help_add_link $w link_file "1. The \"File\" menu" help_menus_file
  help_add $w "" "\n  --> I/O primitives (load, save, print)."
  help_add $w "" "\n\n"
  help_add_link $w link_edit "2. The \"Edit\" menu" help_menus_edit
  help_add $w "" "\n  --> .........."
  help_add $w "" "\n\n"
  help_add_link $w link_run "3. The \"Motion\" menu" help_menus_motion
  help_add $w "" "\n  --> Browsing the current scenario"
  help_add $w "" "\n\n"
  help_add_link $w link_window "4. The \"Window\" menu" help_menus_window
  help_add $w "" "\n  --> Opening windows"
  help_add $w "" "\n\n"
  help_add_link $w link_options "5. The \"Options\" menu" help_menus_options
  help_add $w "" "\n  --> Simulation and preference options"
  help_add $w "" "\n\n"
  help_add_link $w link_help "6. The \"Help\" menu" help_menus_help
  help_add $w "" "\n  --> This help"
  help_add $w "" "\n\n"
  help_end $w
}

proc help_menus_file {w} {
  global Prefix_Scenario_Par_Defaut

  help_start $w
  help_clear $w
  help_add $w title "File menu\n\n"
  help_add $w bold "Reset\n"
  help_add $w "" "  Clear current simulation\n\n"

  help_add $w bold "New\n"
  help_add $w "" "  Clear current simulation and start a new scenario\n\n"

  help_add $w bold "load\n"
  help_add $w "" "  Select and load an existing simulation scenario (.bcg file)\n\n"

  help_add $w bold "Save as\n"
  help_add $w "" "  Select a name for the current scenario and save it\n\n"

  help_add $w bold "Save\n"
  help_add $w "" "  Save the current scenario (default name: $Prefix_Scenario_Par_Defaut.bcg)\n\n"

  help_add $w bold "Save sequence tree\n"
  help_add $w "" "  Select a name .bcg for the sub-tree of the current scenario (defined by the path starting at the initial state and ending at the current state, and the sub-tree going out from the current state) and save it (.bcg format)\n\n"

  help_add $w bold "Save a sequence of labels\n"
  help_add $w "" "  Select a name .seq and save the labels of the transitions lying on the current active path (starting from the initial state and ending at the current state)\n\n"

  help_add $w bold "Preview postscript\n"
  help_add $w "" "  Show a preview of the current scenario (all or part of it)\n\n"

  help_add $w bold "Preview postscript\n"
  help_add $w "" "  Print the current scneario (all or part of it)\n\n"

  help_add $w bold "Save postscript\n"
  help_add $w "" "  Save the postscript of the current scenario (all or part of it)\n\n"

  help_add $w bold "Quit\n"
  help_add $w "" "  Exit OCIS\n\n"

  help_end $w
}

proc help_menus_edit {w} {
  help_start $w
  help_clear $w
  help_add $w title "Edit menu\n\n"

  help_add $w bold "Select current transition\n"
  help_add $w "" "  .............\n\n"
  help_add $w bold "Select specific transitions\n"
  help_add $w "" "  .............\n\n"
  help_add $w bold "Disable selection\n"
  help_add $w "" "  .............\n\n"
  help_add $w bold "Close selected transitions\n"
  help_add $w "" "  .............\n\n"
  help_add $w bold "Open selected transitions\n"
  help_add $w "" "  .............\n\n"

  help_add $w bold "Cut selected transition\n"
  help_add $w "" "  .............\n\n"

  help_add $w bold "Cut current transition\n"
  help_add $w "" "  .............\n\n"

  help_add $w bold "Cut down tree of current transition\n"
  help_add $w "" "  .............\n\n"

  help_add $w bold "Find regular expressions\n"
  help_add $w "" "  Popup an interface to launch exhibitor tool\n\n"

  help_end $w
}

proc help_menus_motion {w} {
  help_start $w
  help_clear $w
  help_add $w title "Motion menu\n\n"
  help_add $w bold "Backward\n"
  help_add $w "" " Move back to the state preceding the current state\n\n"
  help_add $w bold "Forward\n"
  help_add $w "" " Move forward to the last state following the current state\n\n"

  help_add $w bold "Show current transition\n"
  help_add $w "" " Show current transition\n\n"
  help_add $w bold "Show top\n"
  help_add $w "" " Show initial state\n\n"

  help_end $w
}

proc help_menus_window {w} {
  help_start $w
  help_clear $w
  help_add $w title "Window menu\n\n"

  help_add $w bold "Edit file\n"
  help_add $w "" "  Select a file and edit it using an editor specified by the environment variable EDITOR \n\n"

  help_add $w bold "Viewing source code\n"
  help_add $w "" "  Display the source code of the current specification and show the trace of the execution by highlighting the code corresponding to firing the current transition. The values of internal variables are also displayed\n\n"

  help_add $w bold "Recompile\n"
  help_add $w "" "  Open a window for launch re-compilation of the current specification files\n\n"

  help_add $w bold "Open shell window\n"
  help_add $w "" "  Open a terminal window running a shell interpreter\n\n"

  help_end $w
}

proc help_menus_options {w} {
  help_start $w
  help_clear $w
  help_add $w title "Options menu\n\n"

  help_add $w bold "Auto advance mode\n"
  help_add $w "" "  Expand automatically the scenario each time a single transition can be fired from the current state\n\n"

  help_add $w bold "Loopback checking\n"
  help_add $w "" "  show loopback transitions\n\n"
  help_add $w bold "    CAUTION:"
  help_add $w "" " this option may slow down significantly the simulator when activated\n\n"

  help_add $w bold "Extended MSC format\n"
  help_add $w "" "  Display further information on the tasks involved in a given transition (effective on MSC view)\n\n"

  help_add $w bold "Save preferences in current directory\n"
  help_add $w "" " Save preferences in the .ocisrc file located in the \
directory where OCIS has been lauched. This file is read when OCIS \
is launched. If this file does not exist, OCIS searches instead for file \
\$HOME/.config/cadp/ocisrc, where the environment variable \f4$HOME\fP \
refers to the home directory. If both files do not exist, OCIS uses its \
standard preferences.\n\n"

  help_add $w bold "Save preferences in home directory\n"
  help_add $w "" "  Save preferences in file \$HOME/.config/cadp/ocisrc file, so that the saved preferences can be reused in other simulation sessions\n\n"

  help_add $w bold "Reset preferences\n"
  help_add $w "" "  Erase .ocisrc file located in the current directory\n\n"

  help_end $w
}

proc help_menus_help {w} {
  help_start $w
  help_clear $w
  help_add $w title "Help menu\n\n"
  help_add $w bold "Help index\n"
  help_add $w "" " Popup this window\n\n"
  help_add $w bold "About\n"
  help_add $w "" " Show OCIS information\n\n"
  help_end $w
}

proc help_toolbar {w} {
  help_start $w
  help_clear $w
  help_add $w title "Toolbar\n\n"
  help_add $w "" "The toolbar icons are described as follows:\n\n"

  help_add_pic $w win_reset
  help_add $w bold " Reset"
  help_add $w "" " (same as File/Reset). See "
  help_add_link $w file_menu "File menu" help_menus_file
  help_add $w "" " section.\n\n"

  help_add_pic $w win_new
  help_add $w bold " New"
  help_add $w "" " (same as File/New). See "
  help_add_link $w file_menu "File menu" help_menus_file
  help_add $w "" " section.\n\n"

  help_add_pic $w win_load
  help_add $w bold " Load"
  help_add $w "" " (same as File/Load). See "
  help_add_link $w file_menu "File menu" help_menus_file
  help_add $w "" " section.\n\n"

  help_add_pic $w win_save
  help_add $w bold " Save"
  help_add $w "" " (same as File/Save). See "
  help_add_link $w file_menu "File menu" help_menus_file
  help_add $w "" " section.\n\n\n"

  help_add_pic $w win_back
  help_add $w bold " Back"
  help_add $w "" " (same as Motion/Back). See "
  help_add_link $w motion_menu "Motion menu" help_menus_motion
  help_add $w "" " section.\n\n"

  help_add_pic $w win_next
  help_add $w bold " Forward"
  help_add $w "" " (same as Motion/Forward). See "
  help_add_link $w motion_menu "Motion menu" help_menus_motion
  help_add $w "" " section.\n\n\n"

  help_add_pic $w win_explore
  help_add $w bold " Exhibitor"
  help_add $w "" " (same as Edit/Find regular expressions). See "
  help_add_link $w edit_menu "Edit menu" help_menus_edit
  help_add $w "" " section.\n\n\n"

  help_add_pic $w win_ap_print
  help_add $w bold " Print preview"
  help_add $w "" " (same as File/Print preview). See "
  help_add_link $w file_menu "File menu" help_menus_file
  help_add $w "" " section.\n\n"

  help_add_pic $w win_print
  help_add $w bold " Print"
  help_add $w "" " (same as File/Print). See "
  help_add_link $w file_menu "File menu" help_menus_file
  help_add $w "" " section.\n\n\n"

  help_add_pic $w compile-up
  help_add $w bold " Recompile"
  help_add $w "" " (same as Window/Recompile). See "
  help_add_link $w window_menu "Window menu" help_menus_window
  help_add $w "" " section.\n\n"

  help_add_pic $w folder-up
  help_add $w bold " Edit"
  help_add $w "" " (same as Window/Edit). See "
  help_add_link $w window_menu "Window menu" help_menus_window
  help_add $w "" " section.\n\n"

  help_end $w
}

proc help_views {w} {
  help_start $w
  help_clear $w
  help_add $w title "Views\n\n"

  help_add $w "" "This section describes the views in the history window"
  help_add $w "" " and the transitions window.\n\n"

  help_add $w "" "The following views are available: \n\n"
  help_add_link $w link_text "Text view" help_views_text
  help_add $w "" ": available either for history & transition windows\n\n"
  help_add_link $w link_msc "MSC view" help_views_msc
  help_add $w "" ": available either for history & transition windows\n\n"
  help_add_link $w link_tree "Tree view" help_views_tree
  help_add $w "" ": available only for history window\n\n"

  help_end $w
}

proc help_views_msc {w} {
  help_start $w
  help_clear $w
  help_add $w title "MSC view\n\n"
  help_add $w bold "Description\n\n"
  help_add_pic $w msc_view
  help_add $w "" "This view mode shows more visually the interactions between"
  help_add $w "" " processes.\n"
  help_add $w "" "Each task is shown as a vertical line. Each transition is"
  help_add $w "" " shown as a horizontal line. If a process synchronizes"
  help_add $w "" " on this transition, a circle is shown at the intersection"
  help_add $w "" " of the 2 lines. When a task changes its process, it is"
  help_add $w "" " shown on the vertical line of this task, and the name of"
  help_add $w "" " the process is displayed.\n\n"
  help_add $w bold "Mouse interactions: \n\n"
  help_add $w "" "These bindings are the same as in text view.\n\n"
  help_add $w "" "The following functions are bound to mouse buttons:\n\n"
  help_add $w italic "Left button"
  help_add $w "" "(history window): go back to the selected transition.\n\n"
  help_add $w italic "Left button"
  help_add $w "" "(transitions window): select the transition under pointer"
  help_add $w "" " and put it in history window.\n\n"
  help_add $w italic "Right button"
  help_add $w "" "(history & transitions window): popup a menu concerning"
  help_add $w "" "information and source capabilities. see "
  help_add_link $w link_infosource "information & source" help_intro
  help_add $w "" " section for more information.\n\n"
  help_add $w under "Note:"
  help_add $w "" " in the history window, an entry \"back\" is added to"
  help_add $w "" " the popup menu, that have the same effect as clicking"
  help_add $w "" " on the left button.\n"
  help_end $w
}

proc help_views_text {w} {
  help_start $w
  help_clear $w
  help_add $w title "Text view\n\n"
  help_add $w bold "Description\n\n"
  help_add $w "" "This is the simplest view mode.\n"
  help_add $w "" "Each transition (either in the history window and the"
  help_add $w "" " transitions window) is shown as a text line containing its"
  help_add $w "" " label. If processes information are available, the window is"
  help_add $w "" " split vertically into 2 frames. The left one contains the"
  help_add $w "" " transition label, and the right one contains the processes"
  help_add $w "" " that are synchronized on this transition.\n\n"
  help_add $w bold "Mouse interactions: \n\n"
  help_add $w "" "The following functions are bound to mouse buttons:\n\n"
  help_add $w italic "Left button"
  help_add $w "" "(history window): go back to the selected transition.\n\n"
  help_add $w italic "Left button"
  help_add $w "" "(transitions window): select the transition under pointer"
  help_add $w "" " and put it in history window.\n\n"
  help_add $w italic "Right button"
  help_add $w "" "(history & transitions window): popup a menu concerning"
  help_add $w "" "information and source capabilities. see "
  help_add_link $w link_infosource "information & source" help_infosource
  help_add $w "" " section for more information.\n\n"
  help_add $w under "Note:"
  help_add $w "" " in the history window, an entry \"back\" is added to"
  help_add $w "" " the popup menu, that have the same effect that clicking"
  help_add $w "" " on the left button\n"
  help_end $w
}

proc help_views_tree {w} {
  help_start $w
  help_clear $w
  help_add $w title "Tree view\n(history window only)\n\n"
  help_add $w bold "Description:\n"
  help_add $w "" "  The tree view is used to choose scenarios. "
  help_add $w "" "A scenario is a list of transitions selected sequentially. "
  help_add $w "" "Each time you go back and select a new transition, a new "
  help_add $w "" "scenario is created, shown by a new branch in the tree.\n\n"
  help_add $w bold "Bindings:\n"
  help_add $w "" " By left-clicking on a node of the tree, you will reload "
  help_add $w "" "the selected scenario, updating the history window. The "
  help_add $w "" "simulator will prompt on the position just after the "
  help_add $w "" "selected transition .\n"
  help_end $w
}

proc help_nav {w} {
  help_start $w
  help_clear $w
  help_add $w title "Input/Output capabilities\n\n"
  help_add $w bold "Scenario files\n"
  help_add $w "" "  Each scenario file is saved in a BCG-format file, readable "
  help_add $w "" "by any tool accepting this format. For example the program "
  help_add $w "" "bcg-draw will draw the tree of scenarios. Each node of the "
  help_add $w "" "BCG tree contains 2 parts separated by a \"#\" symbol: "
  help_add $w "" "the first is internal values for "
  help_add $w italic "OCIS"
  help_add $w "" ", the second is the labelled transition.\n\n"
  help_add $w bold "Printed files\n"
  help_add $w "" "  Each printed file is in PS format, thus printable by many "
  help_add $w "" "applications.\n\n"
  help_end $w
}

proc help_infosource {w} {
  help_start $w
  help_clear $w
  help_add $w title "Information & Source\n\n"
  help_add $w "" "  By right-clicking on a transition, you can open either "
  help_add $w "" "an information window or a source window.\n\n"
  help_add $w bold "Information window\n\n"
  help_add_pic $w info_win
  help_add $w "" "\n  The information window shows the types and values of the "
  help_add $w "" "local variables of each task synchronizing on the selected "
  help_add $w "" "transition.\n"
  help_add $w "" "  Each task is selectable separately by clicking on the "
  help_add $w "" "visual tab on the top on the window.\n\n"
  help_add $w bold "Source window\n"
  help_add_pic $w source_win
  help_add $w "" "\n  The source window shows the source code corresponding " 
  help_add $w "" "to the simulated file. The source line concerning the "
  help_add $w "" "selected transition is highlighted and any variable name "
  help_add $w "" "appearing on the line is left clickable: by clicking on it,"
  help_add $w "" " the type and the value of the variable is displayed.\n"
  help_add $w "" "  Each task is selectable separately by clicking on the "
  help_add $w "" "visual tab on the top on the window.\n"
  help_add $w "" "  The \"Edit...\" button allows to edit the file according "
  help_add $w "" "to the "
  help_add $w italic "\$EDITOR"
  help_add $w "" " environment variable."

  help_end $w
}

set color_task(0) "grey" 
set color_task(1) "black"
set color_task(2) "black"
set color_task(3) "black"

set width_task(0) 1
set width_task(1) 1
set width_task(2) 1
set width_task(3) 1

set pos_task_trace(1) -0
set pos_task_trace(2) +12
set pos_task_trace(3) -0

set pos_task_trans(1) -0
set pos_task_trans(2) +6
set pos_task_trans(3) -0

set Msc_Task_Horizontal_Distance 75

set Msc_Vertical_Distance 30

set ystart 10 

set Msc_Disc_Radius 5

set Ordonnees_X_Taches_Vues_Msc {}

set Font_Msc_Label $Font_Bold_9

set Font_Msc_Info_Process $Font_Bold_8

set Relative_Text_Distance_In_Msc_View 9

proc Charger_Transition_Vue_Msc {chemin_transition} {

    global Fenetres_Affichage 
    global Numero_Transition_Courante 
    global Chemin_Backward
    global Arbre_Vue_Tree

    set info_transition [lindex [$Arbre_Vue_Tree info data $chemin_transition] 0]
    set indice [lindex $info_transition 0]
    set porte [lindex $info_transition 2] 
    set etat [lindex $info_transition 3]
    set procs [lindex $info_transition 4] 
    set time [lindex $info_transition 5] 

    set global_info_rebouclage [lindex $info_transition 6]

    if {$global_info_rebouclage != "" && $global_info_rebouclage != 0} then {
	set porte "$porte : Loopback \[Step $global_info_rebouclage\]"
    }

    set couleur [Determiner_Numero_Couleur_Transition $chemin_transition]

    Afficher_Transition_Vue_Msc $Numero_Transition_Courante $chemin_transition $porte $procs $time $couleur $Fenetres_Affichage "" 

    if {$indice != ""} {
	lappend Chemin_Backward $indice
    }
}

proc Dessiner_Lignes_Noires_Verticales {label status_list fen_msc ymin ymax} {
    global color_task
    global Label_Etat_Initial
    global Font_Msc_Info_Process
    global global_proc_names
    global width_task
    global Ordonnees_X_Taches_Vues_Msc

    foreach i $Ordonnees_X_Taches_Vues_Msc {chgt etat nom} $status_list {

	if {$nom==""} {
	    set active 0
	} else {
	    set active 1
	}

	if {$label == $Label_Etat_Initial} {
	    $fen_msc create line $i $ymin $i $ymax \
		    -fill black -tags item_all -joinstyle round -width 1
	} else {
	    $fen_msc create line $i $ymin $i $ymax \
		    -fill $color_task($active) -tags item_all \
		    -joinstyle round -width $width_task($active)
	}

        if {$chgt && $global_proc_names} {
	    $fen_msc create line \
		    [expr $i-3] [expr $ymax-5] [expr $i+3] [expr $ymax-5]\
		    -fill black -width 1 -tags item_all
	    $fen_msc create text [expr $i-3] [expr $ymax-5] \
		    -anchor e -fill purple -text $nom \
		    -font $Font_Msc_Info_Process 
	}
    }
}

proc Ajouter_Transition_Format_Msc_Fenetre {fenetre chemin_transition y liste_proc label status_list time couleur} {
    global Msc_Task_Horizontal_Distance 
    global Msc_Vertical_Distance Msc_Disc_Radius 
    global Ordonnees_X_Taches_Vues_Msc ystart 
    global global_nb_tache
    global color_task global_info_temps
    global global_proc_names pos_task_trace width_task
    global Font_Msc_Label
    global Font_Msc_Info_Process
    global Relative_Text_Distance_In_Msc_View

    set fen_msc [Widget_Main $fenetre.1]

    set start [lindex $Ordonnees_X_Taches_Vues_Msc [lindex $liste_proc 0]]

    set end [lindex $Ordonnees_X_Taches_Vues_Msc [lindex $liste_proc \
	    [expr [llength $liste_proc]-1]]]

    set mean [expr ($start+$end)/2]

    set yreal [expr $Msc_Vertical_Distance*$y+$ystart]

    set ymin [expr $yreal-$Msc_Vertical_Distance/2]
    set ymax [expr $yreal+$Msc_Vertical_Distance/2]

    set current_width_of_fen_msc \
	    [expr [$fen_msc cget -width] + 2*$Msc_Task_Horizontal_Distance]

    global global_bg_color
    if {$couleur == 5} {
	global Couleur_Background_Transition_Selection
	set couleur_background $Couleur_Background_Transition_Selection
    } elseif {$couleur == 4} {
	global Couleur_Background_Transition_Sink
	set couleur_background $Couleur_Background_Transition_Sink
    } else {
	set couleur_background $global_bg_color
    }

    $fen_msc create rect \
	    0 [expr $ymin] $current_width_of_fen_msc [expr $ymax] \
	    -fill $couleur_background -outline $global_bg_color\
	    -tags {item_canvas item_all} 

    global Fenetres_Affichage
    if {$fenetre == $Fenetres_Affichage} {
	Dessiner_Lignes_Noires_Verticales \
		$label $status_list $fen_msc $ymin $ymax 
    }

    set color_line [Generer_Couleur_Reelle $couleur]

    $fen_msc create line $start $yreal $end $yreal \
	    -fill $color_line -width 3 -tags {item_canvas item_all}

    $fen_msc create text $mean [\
	    expr $yreal- $Relative_Text_Distance_In_Msc_View] -text "$label"\
	    -fill $color_line  -tags {item_canvas item_all} \
	    -font $Font_Msc_Label

    set y1 [expr $yreal-$Msc_Disc_Radius]
    set y2 [expr $yreal+$Msc_Disc_Radius]
    set last_pos_vert 1000
    set last_pos_hor 0

    foreach i $liste_proc {
	set xc [lindex $Ordonnees_X_Taches_Vues_Msc $i]
	set s [lindex $status_list [expr $i*3+1]]
	if {$s==0} {
	    set s 1
	}
	$fen_msc create oval \
		[expr $xc-$Msc_Disc_Radius] [expr $y1+$pos_task_trace($s)] \
		[expr $xc+$Msc_Disc_Radius] [expr $y2+$pos_task_trace($s)] \
		-fill $color_line -tags {item_canvas item_all}
	set nyreal [expr $yreal+$pos_task_trace($s)]
	if {$last_pos_vert!=1000} {
	    if {$last_pos_vert>$nyreal} {
		$fen_msc create line $last_pos_hor $last_pos_vert $xc $nyreal\
			-fill $color_line -width 3 -arrow first\
			-tags {item_canvas item_all} 
	    } elseif {$last_pos_vert<$nyreal} {
		$fen_msc create line $last_pos_hor $last_pos_vert $xc $nyreal\
			-fill $color_line -width 3 -arrow last \
			-tags {item_canvas item_all} 
	    } else {
		$fen_msc create line $last_pos_hor $last_pos_vert $xc $nyreal\
			-fill $color_line -width 3 \
			-tags {item_canvas item_all} 
	    }
	}
	set last_pos_vert $nyreal
	set last_pos_hor $xc
    }

    set fen_time [Widget_Time $fenetre.1]
    if {$global_info_temps} {
	
	$fen_time create rect \
	    0 [expr $ymin] 50 [expr $ymax] \
	    -fill $couleur_background -outline $global_bg_color\
	    -tags {item_canvas item_all} 

	$fen_time create text 3 $yreal -anchor w -text $time \
		-fill $color_line  -tags {item_canvas item_all} \
		-font $Font_Msc_Label
    }

    global Afficher_Colonne_Taches
    if {$Afficher_Colonne_Taches == 1} {
	set fen_proc [Widget_Process $fenetre.1]

	$fen_proc create rect \
	    0 [expr $ymin] 50 [expr $ymax] \
	    -fill $couleur_background -outline $global_bg_color\
	    -tags {item_canvas item_all} 

	$fen_proc create text 3 $yreal -anchor w -text $liste_proc\
		-fill $color_line  -tags {item_canvas item_all} \
		-font $Font_Msc_Label
    }

    if {$fenetre == $Fenetres_Affichage} {

	set fen_fired [Widget_Fired $fenetre.1]

	$fen_fired create rect \
	    0 [expr $ymin] 50 [expr $ymax] \
	    -fill $couleur_background -outline $global_bg_color\
	    -tags {item_canvas item_all} 

	$fen_fired create text 3 $yreal -anchor w \
		-text [Label_Colonne_Fired $chemin_transition] \
		-fill $color_line -tags {item_canvas item_all} \
		-font $Font_Msc_Label
    }

}

proc Afficher_Transition_Vue_Msc {indice chemin_transition porte procs time couleur fenetre chgt} {
    global global_info_process Fenetres_Affichage 
    global changement_transition

    if {$global_info_process} {
	if {$fenetre == $Fenetres_Affichage} {
	    Ajouter_Transition_Format_Msc_Fenetre \
		    $fenetre $chemin_transition $indice $procs $porte \
		    $changement_transition $time $couleur
	} else {
	    Ajouter_Transition_Format_Msc_Fenetre \
		    $fenetre $chemin_transition $indice $procs $porte \
		    $chgt $time $couleur
	}
    }
}

proc Realiser_Focus_Premiere_Ligne_Vue_Msc {fenetre} {

    set fen_msc [Widget_Main $fenetre.1]
    $fen_msc yview moveto 0

    global global_info_temps
    if {$global_info_temps} then {
	set fen_time [Widget_Time $fenetre.1]
	$fen_time yview moveto 0
    }
    global Afficher_Colonne_Taches
    if {$Afficher_Colonne_Taches == 1} then {
	set fen_proc [Widget_Process $fenetre.1]
	$fen_proc yview moveto 0
    }

    global Fenetres_Affichage
    if {$fenetre == $Fenetres_Affichage} {
	set fen_fired [Widget_Fired $fenetre.1]
	$fen_fired yview moveto 0

    }
}

proc Realiser_Focus_Ligne_Courante_Vue_Msc {fenetre} {
    global Msc_Vertical_Distance

    set fen_msc [Widget_Main $fenetre.1]
    set region [$fen_msc bbox item_all]
    set y_max [expr [lindex $region 3] + $Msc_Vertical_Distance/2]
    set zone [list 0 0 [lindex $region 2] $y_max]
    $fen_msc configure -scrollregion $zone
    $fen_msc yview moveto 1

    global global_info_temps
    if {$global_info_temps} then {
	set fen_time [Widget_Time $fenetre.1]
	set region [$fen_time bbox item_all]
	set zone [list 0 0 [lindex $region 2] $y_max]
	$fen_time configure -scrollregion $zone
	$fen_time yview moveto 1
    }
    global Afficher_Colonne_Taches
    if {$Afficher_Colonne_Taches == 1} then {
	set fen_proc [Widget_Process $fenetre.1]
	set region [$fen_proc bbox item_all]
	set zone [list 0 0 [lindex $region 2] $y_max]
	$fen_proc configure -scrollregion $zone
	$fen_proc yview moveto 1
    }

    global Fenetres_Affichage
    if {$fenetre == $Fenetres_Affichage} {
	set fen_fired [Widget_Fired $fenetre.1]
	set region [$fen_fired bbox item_all]
	set zone [list 0 0 [lindex $region 2] $y_max]
	$fen_fired configure -scrollregion $zone
	$fen_fired yview moveto 1

    }
}

proc Calculer_Numero_Ligne_Cliquee_Vue_Msc {Widget_Msc} {

    global Msc_Vertical_Distance ystart
    global Relative_Text_Distance_In_Msc_View

    set y_min [lindex [$Widget_Msc coords current] 1]
    set y_max [lindex [$Widget_Msc coords current] 3]

    if {$y_max == ""} {
	set tmp_y [expr int($y_min + $Relative_Text_Distance_In_Msc_View \
		- $ystart)]
	set numero_ligne [expr $tmp_y/$Msc_Vertical_Distance]
    } else {
	set tmp_y [expr int($y_min + $y_max - 2*$ystart)]
	set numero_ligne [expr $tmp_y/2/$Msc_Vertical_Distance]
    }

    return $numero_ligne

}

proc Construire_Bind_Transition_Vue_Msc {Widget_Msc val Nom_Commande_Bind arg args} {

    set numero_ligne [Calculer_Numero_Ligne_Cliquee_Vue_Msc $Widget_Msc]

    set Commande_Bind "$Nom_Commande_Bind $numero_ligne $arg"
    eval $Commande_Bind
}

proc Etablir_Bindings_Transition_Vue_Msc {fenetre Nom_Commande_Bind_Bouton_1 Nom_Commande_Bind_Bouton_2 ligne_fin} {

    global global_info_process
    if {$global_info_process} then {
	Realiser_Focus_Ligne_Courante_Vue_Msc $fenetre

	set fen_msc [Widget_Main $fenetre.1]
	$fen_msc bind item_canvas <1> \
		"Construire_Bind_Transition_Vue_Msc $fen_msc $fenetre {$Nom_Commande_Bind_Bouton_1} {}"
	$fen_msc bind item_canvas <3> \
		"Construire_Bind_Transition_Vue_Msc $fen_msc $fenetre {$Nom_Commande_Bind_Bouton_2} {%X %Y}"  
    }
}

proc Afficher_Menu_Msc_Transition_Bouton_Droit {menu fenetre ligne r_x r_y} {

    global global_info_process 
    global Numero_Ligne_Transition_Courante_Vue_Msc_Et_Text
    global Liste_Numeros_Taches_Ligne_Selectionnee

    set Numero_Ligne_Transition_Courante_Vue_Msc_Et_Text $ligne

    set liste_procs ""

    global Afficher_Colonne_Taches
    if {$Afficher_Colonne_Taches == 1} then {
	set frame_texte $fenetre.2
	set fen_proc [Widget_Process $frame_texte]
	set liste_procs [$fen_proc get $ligne.0 "$ligne.0 lineend"]
    }

    set Liste_Numeros_Taches_Ligne_Selectionnee "$liste_procs"

    tk_popup $menu $r_x $r_y
}

proc Changer_Couleur_Colonne_Vue_Msc {Widget_Colonne Numero_Ligne couleur} {

    global ystart 
    global Msc_Vertical_Distance
    global Fenetres_Affichage

    set yreal [expr $Msc_Vertical_Distance*$Numero_Ligne+$ystart]

    set ymin [expr $yreal-$Msc_Vertical_Distance/2]
    set ymax [expr $yreal+$Msc_Vertical_Distance/2-1]

    set Bounding_Box [$Widget_Colonne bbox item_all]
    set xmin [lindex $Bounding_Box 0]
    set xmax [lindex $Bounding_Box 2]
    foreach i [$Widget_Colonne find enclose $xmin $ymin $xmax $ymax] {
	$Widget_Colonne itemconfigure $i -fill $couleur
    }

}

proc Changer_Texte_Colonne_Vue_Msc {Widget_Colonne Numero_Ligne Nouveau_Texte} {
    global ystart 
    global Msc_Vertical_Distance

    set yreal [expr $Msc_Vertical_Distance*$Numero_Ligne+$ystart]

    set ymin [expr $yreal-$Msc_Vertical_Distance/2]
    set ymax [expr $yreal+$Msc_Vertical_Distance/2-1]

    set Bounding_Box [$Widget_Colonne bbox item_all]
    set xmin [lindex $Bounding_Box 0]
    set xmax [lindex $Bounding_Box 2]
    foreach i [$Widget_Colonne find enclose $xmin $ymin $xmax $ymax] {
	$Widget_Colonne itemconfigure $i -text $Nouveau_Texte
    }
}

proc Lire_Couleur_Colonne_Vue_Msc {Widget_Colonne Numero_Ligne} {

    global ystart 
    global Msc_Vertical_Distance

    set yreal [expr $Msc_Vertical_Distance*$Numero_Ligne+$ystart]

    set ymin [expr $yreal-$Msc_Vertical_Distance/2]
    set ymax [expr $yreal+$Msc_Vertical_Distance/2-1]

    set Bounding_Box [$Widget_Colonne bbox item_all]
    set xmin [lindex $Bounding_Box 0]
    set xmax [lindex $Bounding_Box 2]
    foreach i [$Widget_Colonne find enclose $xmin $ymin $xmax $ymax] {
	set Couleur_Colonne [$Widget_Colonne itemconfigure $i -fill]
    }

    if ![info exists Couleur_Colonne] {
	global Couleur_Transition_Exploree
	return $Couleur_Transition_Exploree
    }
    return [lindex $Couleur_Colonne 4]

}

proc Lire_Couleur_Colonne_Vue_Msc_Any_Motion {Widget_Colonne} {

    global ystart 
    global Msc_Vertical_Distance

    if {[$Widget_Colonne coords current] == ""} {
	global Couleur_Transition_Exploree
	return $Couleur_Transition_Exploree
    }

    if {[lindex [$Widget_Colonne coords current] 3] == ""} {
	set yr [lindex [$Widget_Colonne coords current] 1]
    } else {
	set yr [expr ([lindex [$Widget_Colonne coords current] 1]+[lindex [$Widget_Colonne coords current] 3])/2]
    }

    set y [expr (($yr-$ystart)/$Msc_Vertical_Distance)*$Msc_Vertical_Distance+$ystart]
    set ymin [expr $y-$Msc_Vertical_Distance/2]
    set ymax [expr $y+($Msc_Vertical_Distance/2)-1]

    set Bounding_Box [$Widget_Colonne bbox item_all]
    set xmin [lindex $Bounding_Box 0]
    set xmax [lindex $Bounding_Box 2]
    foreach i [$Widget_Colonne find enclose $xmin $ymin $xmax $ymax] {
	set Couleur_Colonne [$Widget_Colonne itemconfigure $i -fill]
    }
    return [lindex $Couleur_Colonne 4]

}

proc Binding_Any_Motion_Vue_Msc {Type_Fenetre Fenetre} {

    global ystart
    set yreal [lindex [[Widget_Main $Fenetre] coords current] 1]

    global global_info_temps
    if {$global_info_temps} {
	if {$yreal == ""} {
	    set yreal [lindex [[Widget_Time $Fenetre] coords current] 1]
	}
    }
    global Afficher_Colonne_Taches
    if {$Afficher_Colonne_Taches == 1} then {
	if {$yreal == ""} {
	    set yreal [lindex [[Widget_Process $Fenetre] coords current] 1]
	}
    }

    if {$Type_Fenetre == "Trace"} {
	if {$yreal == ""} {
	    set yreal [lindex [[Widget_Fired $Fenetre] coords current] 1]
	}
    }

    global Msc_Vertical_Distance
    set Numero_Ligne [expr int (ceil ([expr [expr $yreal - $ystart] / $Msc_Vertical_Distance]))]

    if {$Type_Fenetre == "Trace"} {
	global Numero_Ligne_Msc_Any_Motion_Vue_Trace
	set Numero_Ligne_Msc_Any_Motion_Vue_Trace $Numero_Ligne 
    } else {
	global Numero_Ligne_Msc_Any_Motion_Vue_Trans
	set Numero_Ligne_Msc_Any_Motion_Vue_Trans $Numero_Ligne 
    }

    global Couleur_Originale_Colonne_Msc
    set Couleur_Originale_Colonne_Msc [Lire_Couleur_Colonne_Vue_Msc [Widget_Main $Fenetre] $Numero_Ligne]

    global Couleur_Highlight

    global global_info_temps
    if {$global_info_temps} {
	Changer_Couleur_Colonne_Vue_Msc [Widget_Time $Fenetre] $Numero_Ligne $Couleur_Highlight
    }

    Changer_Couleur_Colonne_Vue_Msc [Widget_Main $Fenetre] $Numero_Ligne $Couleur_Highlight

    global Afficher_Colonne_Taches
    if {$Afficher_Colonne_Taches == 1} then {
	Changer_Couleur_Colonne_Vue_Msc [Widget_Process $Fenetre] $Numero_Ligne $Couleur_Highlight
    }
    if {$Type_Fenetre == "Trace"} {

	Changer_Couleur_Colonne_Vue_Msc [Widget_Fired $Fenetre] $Numero_Ligne $Couleur_Highlight
    }
}

proc Binding_Any_Leave_Vue_Msc {Type_Fenetre Fenetre} {

    if {$Type_Fenetre == "Trace"} {
	global Numero_Ligne_Msc_Any_Motion_Vue_Trace
	set Numero_Ligne $Numero_Ligne_Msc_Any_Motion_Vue_Trace
    } else {
	global Numero_Ligne_Msc_Any_Motion_Vue_Trans
	set Numero_Ligne $Numero_Ligne_Msc_Any_Motion_Vue_Trans
    }

    global Couleur_Originale_Colonne_Msc
    if [info exists Couleur_Originale_Colonne_Msc] {

	global global_info_temps
	if {$global_info_temps} {
	    Changer_Couleur_Colonne_Vue_Msc [Widget_Time $Fenetre] $Numero_Ligne $Couleur_Originale_Colonne_Msc
	}

	Changer_Couleur_Colonne_Vue_Msc [Widget_Main $Fenetre] $Numero_Ligne $Couleur_Originale_Colonne_Msc

	global Afficher_Colonne_Taches
	if {$Afficher_Colonne_Taches == 1} then {
	    Changer_Couleur_Colonne_Vue_Msc [Widget_Process $Fenetre] $Numero_Ligne $Couleur_Originale_Colonne_Msc
	}
	if {$Type_Fenetre == "Trace"} {

	    Changer_Couleur_Colonne_Vue_Msc [Widget_Fired $Fenetre] $Numero_Ligne $Couleur_Originale_Colonne_Msc
	}

    }
}

proc Etablir_Binding_Any_Motion_Any_Leave_Vue_Msc_Colonne {Type_Fenetre Widget_Colonne} {

    if {$Type_Fenetre == "Trace"} {
	global Fenetres_Affichage
	set Fenetre $Fenetres_Affichage.1
    } else {
	global Fenetres_Transition 
	set Fenetre $Fenetres_Transition.1
    }

    $Widget_Colonne bind item_canvas <Any-Enter> [subst {
	Binding_Any_Motion_Vue_Msc $Type_Fenetre $Fenetre
    }]

    $Widget_Colonne bind item_canvas <Any-Leave> [subst {
	Binding_Any_Leave_Vue_Msc $Type_Fenetre $Fenetre
    }]
}    

proc Etablir_Binding_Any_Motion_Any_Leave_Vue_Msc {Type_Fenetre} {

    if {$Type_Fenetre == "Trace"} {
	global Fenetres_Affichage
	set Fenetre $Fenetres_Affichage.1
    } else {
	global Fenetres_Transition 
	set Fenetre $Fenetres_Transition.1
    }

    global global_info_temps
    if {$global_info_temps} {
	Etablir_Binding_Any_Motion_Any_Leave_Vue_Msc_Colonne \
		$Type_Fenetre [Widget_Time $Fenetre]
    }

    Etablir_Binding_Any_Motion_Any_Leave_Vue_Msc_Colonne \
	    $Type_Fenetre [Widget_Main $Fenetre]

    global Afficher_Colonne_Taches
    if {$Afficher_Colonne_Taches == 1} then {
	Etablir_Binding_Any_Motion_Any_Leave_Vue_Msc_Colonne \
		$Type_Fenetre [Widget_Process $Fenetre]
    }

    if {$Type_Fenetre == "Trace"} {

	Etablir_Binding_Any_Motion_Any_Leave_Vue_Msc_Colonne \
		$Type_Fenetre [Widget_Fired $Fenetre]
    }
}

proc Bind_Foreground_Windows {} {
    global Foreground_Windows

    foreach nom_fenetre \
	    {.main .fenetre_code_source .edit_fichier .choose_psfile \
	    .choose_preview .choose_printer .fenetre_exhibitor \
	    .fenetre_compilation .reset_preferences} {
	if [winfo exists $nom_fenetre] then {
	    if {$Foreground_Windows == 1} {
		bind $nom_fenetre <Enter> "raise $nom_fenetre"
	    } else {
		bind $nom_fenetre <Enter> ""
	    }
	}		
    }
}

proc ComputeRulesWinMain {} {
    global Screen_Width Screen_Height Screen_X_Position Screen_Y_Position
    global main 

    scan [wm geometry $main] "%dx%d+%d+%d" Current_Width Current_Height Screen_X_Position Screen_Y_Position

    if [expr $Current_Width != 1] {
	set Screen_Width $Current_Width
    }
    if [expr $Current_Height != 1] {
	set Screen_Height $Current_Height
    }
}

proc ComputeRulesWinSource {} {
    global Width_Win_Source Height_Win_Source 
    global Win_Source_X_Position Win_Source_Y_Position

    scan [wm geometry .fenetre_code_source] "%dx%d+%d+%d" Current_Width Current_Height Win_Source_X_Position Win_Source_Y_Position

    if [expr $Current_Width != 1] {
	set Width_Win_Source $Current_Width
    }
    if [expr $Current_Height != 1] {
	set Height_Win_Source $Current_Height
    }
}

proc ComputeRulesWinExhibitor {} {
    global Width_Win_Exhibitor Height_Win_Exhibitor 
    global Win_Exhibitor_X_Position Win_Exhibitor_Y_Position

    scan [wm geometry .fenetre_exhibitor] "%dx%d+%d+%d" Current_Width Current_Height Win_Exhibitor_X_Position Win_Exhibitor_Y_Position

	if [expr $Current_Width != 1] {
		set Width_Win_Exhibitor $Current_Width
	}

	if [expr $Current_Height != 1] {
		set Height_Win_Exhibitor $Current_Height
	}
}

proc ComputeRulesWinHelp {} {
    global help_window
    global Width_Win_Help Height_Win_Help 
    global Win_Help_X_Position Win_Help_Y_Position

    scan [wm geometry $help_window] "%dx%d+%d+%d" Current_Width Current_Height Win_Help_X_Position Win_Help_Y_Position

	if [expr $Current_Width != 1] {
		set Width_Win_Help $Current_Width
	}

	if [expr $Current_Height != 1] {
		set Height_Win_Help $Current_Height
	}
}

proc ComputeRulesWinRecompile {} {
    global Width_Win_Recompile Height_Win_Recompile 
    global Recompile_X_Position Recompile_Y_Position

    scan [wm geometry .fenetre_compilation] "%dx%d+%d+%d" Current_Width Current_Height \
	    Recompile_X_Position Recompile_Y_Position

    if [expr $Current_Width != 1] {
	set Width_Win_Recompile $Current_Width
    }
    if [expr $Current_Height != 1] {
	set Height_Win_Recompile $Current_Height
    }
}

proc ComputeRulesWinError {} {
    global Error_Win_Width 
    global Error_Win_Height 

    scan [wm geometry .file_opening_failure] "%dx%d+%d+%d" Current_Width Current_Height \
	    Current_X_Pos Current_Y_Pos

	if [expr $Current_Width != 1] {
		set Error_Win_Width $Current_Width
	}

	if [expr $Current_Height != 1] {
		set Error_Win_Height $Current_Height
	}
}

proc ComputeRulesWinWarningGeneral {} {
    global Warning_General_Win_Width  
    global Warning_General_Win_Height 

    scan [wm geometry .warning_general] "%dx%d+%d+%d" Current_Width Current_Height Current_X_Pos Current_Y_Pos

	if [expr $Current_Width != 1] {
		set Warning_General_Win_Width $Current_Width
	}

	if [expr $Current_Height != 1] {
		set Warning_General_Win_Height $Current_Height
	}
}

proc ComputeRulesSelectionFilebox {} {
    global Selection_Filebox_Width 
    global Selection_Filebox_Height

    scan [wm geometry .selection_filebox] "%dx%d+%d+%d" Current_Width Current_Height Current_X_Pos Current_Y_Pos

	if [expr $Current_Width != 1] {
		set Selection_Filebox_Width $Current_Width
	}

	if [expr $Current_Height != 1] {
		set Selection_Filebox_Height $Current_Height
	}
}

set List_Variables_To_Save {
    Ocis_Version
    Screen_Width
    Screen_Height
    Screen_MinWidth
    Screen_MinHeight
    Screen_X_Position
    Screen_Y_Position
    Error_Win_Width                                
    Error_Win_Height                               
    Warning_General_Win_Width  
    Warning_General_Win_Height 
    Warning_Width                               
    Warning_Height                             
    Selection_Filebox_Width 
    Selection_Filebox_Height
    global_heure_courante
    Pane_Border_Width
    Pane_Relief
    Fg_Color
    Title_Color
    Xterm_Options

    Auto_Advance_Option   
    Auto_Advance_Max_Steps 
    Loopback_Option
    global_proc_names

    Viewing_Source_Code

    Pref_Main_Win_Type
    Pref_Trans_Win_Type 
    Height_Msc_View 
    Height_Trans_View

    Width_Time_View
    Width_TextTrace_View
    Width_Processes_View

    Width_Win_Source
    Height_Win_Source
    Win_Source_X_Position 
    Win_Source_Y_Position

    Width_Win_Recompile 
    Height_Win_Recompile 
    Recompile_X_Position 
    Recompile_Y_Position

    Width_Win_Exhibitor 
    Height_Win_Exhibitor 
    Win_Exhibitor_X_Position 
    Win_Exhibitor_Y_Position
    Exhibitor_Width_Label

    Width_Win_Help 
    Height_Win_Help 
    Win_Help_X_Position 
    Win_Help_Y_Position

    Exhibitor_Starting_State
    Exhibitor_Case_Sensitive
    Exhibitor_Conflict
    Exhibitor_Exploration_Mode
    Exhibitor_Strategy
    Exhibitor_Type_Sequence
    Exhibitor_Depth_Search  
    Exhibitor_File_Input_Sequence
    Exhibitor_Text_Input_Sequence
    Exhibitor_File_Result

    Msc_Task_Horizontal_Distance

    Font_Msc_Label
    Font_Msc_Info_Process
    Font_Msc_Title_Tasks
    Font_Vue_Texte_Label
    Font_Code_Source_Title
    Font_Code_Source_Texte
    Font_Tree_Label
    Font_Texte_Fenetre_Recompilation

}

proc Execute_Shell {Shell_Command} {

    global env
    if [string compare $env(Ocis_SHELL) ""] {
	if [catch { eval exec $env(Ocis_SHELL) \"$Shell_Command\" } Result] {
	    Afficher_Message_Erreur "Command \"$env(Ocis_SHELL) $Shell_Command\" failed" {}
	    return
	}
    } else {
	if [catch {eval exec "$Shell_Command"} Result] {
	    Afficher_Message_Erreur "Command \"$Shell_Command\" failed" {}
	    return
	}
    }
    return $Result
}

proc Read_Ocis_Preferences {} {
   global ocis_local_startup_file
   global ocis_global_startup_file
   global List_Variables_To_Save

   foreach Variable_Name $List_Variables_To_Save {
       global $Variable_Name
   }

   if [file exists $ocis_local_startup_file] then {
       source "$ocis_local_startup_file"
   } elseif [file exists $ocis_global_startup_file] then {
       source "$ocis_global_startup_file"
   }
}

proc Command_Reset_Ocis_Preferences {} {
   global ocis_local_startup_file
   global ocis_global_startup_file

    destroy .reset_preferences
    if [file exists $ocis_local_startup_file] then {
       Envoi_Message "shell rm -f $ocis_local_startup_file"
    } elseif [file exists $ocis_global_startup_file] then {
       Envoi_Message "shell rm -f $ocis_global_startup_file"
    }
}

proc Save_Ocis_Preferences {fichier_ocisrc} {
    global env
    global List_Variables_To_Save
    global Ocis_Version

    set List "\n# ocisrc generated automatically by OCIS version $Ocis_Version\n"
    foreach Variable_Name $List_Variables_To_Save {
	global ${Variable_Name}
	set List "$List\nset ${Variable_Name} {[subst $[subst $Variable_Name]]}"
    }

    set List "$List\n"

    if {[file exists $fichier_ocisrc]} then {
	if [catch {eval exec chmod u+w $fichier_ocisrc} tmp] {
	    Afficher_Message_Erreur "Command \"chmod u+w $fichier_ocisrc\" failed" {}
	    return 
	}
    }
	
    if [catch {open $fichier_ocisrc "w"} File_Id] {
	Afficher_Message_Erreur "File $fichier_ocisrc unwritable" {}
	return
    }
    puts $File_Id $List
    close $File_Id
}

proc Reset_Ocis_Preferences {} {
    global global_info_process global_menu_bg_color
    global Warning_Width Warning_Height Warning_X_Pos Warning_Y_Pos
    global Screen_Width Screen_Height Screen_X_Position Screen_Y_Position 
    global Titre_Fenetres
    global Foreground_Windows
    global Font_Bold_9

    if [winfo exists .reset_preferences] then {
	return 0
    }
    toplevel .reset_preferences
    wm title .reset_preferences "$Titre_Fenetres ... Reset general preferences"
    bind .reset_preferences <Control-c> "destroy .reset_preferences"
    bind .reset_preferences <Enter> "raise .reset_preferences"
	
    focus .reset_preferences
    grab .reset_preferences

    set Warning_X_Pos [expr $Screen_X_Position + $Screen_Width /2 - $Warning_Width /2]
    set Warning_Y_Pos [expr $Screen_Y_Position + $Screen_Height /2 - $Warning_Height /2]

    wm geometry .reset_preferences ${Warning_Width}x${Warning_Height}+${Warning_X_Pos}+${Warning_Y_Pos}

    frame .reset_preferences.frame -bg $global_menu_bg_color
    pack .reset_preferences.frame -side top -expand yes -fill both

    label .reset_preferences.frame.message \
	    -text "Do you really want to remove your .ocisrc file ?" \
	    -font $Font_Bold_9 -bg $global_menu_bg_color \
	    -highlightcolor $global_menu_bg_color \
	    -highlightbackground $global_menu_bg_color
    pack .reset_preferences.frame.message -side top -expand yes

    tixLabelFrame .reset_preferences.frame.buttons -labelside none \
	    -bg $global_menu_bg_color
    [.reset_preferences.frame.buttons subwidget frame] configure \
	    -bg $global_menu_bg_color
    pack .reset_preferences.frame.buttons -side top -fill both -expand yes  

    set frame_button [.reset_preferences.frame.buttons subwidget frame]
    button $frame_button.save -text "Remove" \
	    -font $Font_Bold_9 \
	    -command Command_Reset_Ocis_Preferences \
	    -bg $global_menu_bg_color -fg red \
	    -highlightcolor $global_menu_bg_color \
	    -highlightbackground $global_menu_bg_color

    button $frame_button.cancel -text "Cancel" \
	    -font $Font_Bold_9 \
	    -command {destroy .reset_preferences} \
	    -bg $global_menu_bg_color \
	    -highlightcolor $global_menu_bg_color \
	    -highlightbackground $global_menu_bg_color

    pack $frame_button.save $frame_button.cancel \
	    -side left -expand yes -padx 5 -pady 5 -fill x

}

proc Charger_Transition_Vue_Texte {chemin_transition} {
    global Fenetres_Affichage 
    global Numero_Transition_Courante 
    global Chemin_Backward
    global Arbre_Vue_Tree

    set info_transition [lindex [$Arbre_Vue_Tree info data $chemin_transition] 0]
    set indice [lindex $info_transition 0]
    set porte [lindex $info_transition 2] 
    set etat [lindex $info_transition 3]
    set procs [lindex $info_transition 4] 
    set time [lindex $info_transition 5] 

    set global_info_rebouclage [lindex $info_transition 6]

    if {$global_info_rebouclage != "" && $global_info_rebouclage != 0} then {
	set porte "$porte : Loopback \[Step $global_info_rebouclage\]"
    }

    set couleur [Determiner_Numero_Couleur_Transition $chemin_transition]

    Afficher_Transition_Vue_Texte $Numero_Transition_Courante \
	    $chemin_transition \
	    $porte $procs $time $couleur $Fenetres_Affichage 

    if {$indice != ""} {
	lappend Chemin_Backward $indice
    }
}

proc Afficher_Transition_Selectionnee_Vue_Texte {x y} {
    global Fenetres_Transition
    global global_info_temps global_info_process heure_courante

    set frame_texte $Fenetres_Transition.2
    set fen_texte [Widget_Main $frame_texte]

    set pos [$fen_texte index @0,$y]

    scan $pos "%d.%d" ligne colonne
    Afficher_Transition_Selectionnee $ligne
}

proc Afficher_Transition_Vue_Texte {indice chemin_transition porte procs time couleur fenetre} {
    global global_info_temps global_info_process
    global Fenetres_Affichage 
    global Font_Vue_Texte_Label

    set frame_texte $fenetre.2

    if {$porte != ""} {
	Afficher_Temps_Ecoule_Dans_Colonne_Time \
		$indice $time $couleur $frame_texte
	Afficher_Liste_Taches_Dans_Colonne_Tasks \
		$indice $procs $couleur $frame_texte
    }

    if {$fenetre == $Fenetres_Affichage} {

	if {$porte != ""} {
	    Afficher_Informations_Mise_A_Feu $indice [Label_Colonne_Fired $chemin_transition] $couleur $frame_texte
	}
    }

    set fen_texte [Widget_Main $frame_texte]
    $fen_texte configure -state normal -width 500
    if {$porte == ""} {
	$fen_texte insert end ""
    } else {
	if {$fenetre == $Fenetres_Affichage} {

	    global Numero_Transition_Courante 
	    if {$Numero_Transition_Courante == 1} {
		$fen_texte insert end "$indice. $porte"
	    } else {
		$fen_texte insert end "\n$indice. $porte"
	    }
	} else {
	    $fen_texte insert end "$indice. $porte\n"
	}
    }
    $fen_texte configure -font $Font_Vue_Texte_Label
    Ajouter_Tag_Et_Couleur_Ligne_Texte $fen_texte $indice $couleur
    $fen_texte configure -state disabled
}

proc Etablir_Bindings_Transition_Vue_Texte {fenetre cmd cmd1 ligne_fin} {
    global global_info_temps 
    global global_info_process
    global Fenetres_Affichage

    set frame_texte $fenetre.2
    set fen_texte [Widget_Main $frame_texte]

    if {$global_info_temps} then {

	set fen_time [Widget_Time $frame_texte]
	$fen_time tag add $fen_time.menu 1.0 "[expr $ligne_fin+1].0 lineend" 

	$fen_time tag bind $fen_time.menu <Any-Motion> "Afficher_HighLight_Position TEXT %x %y {$fenetre}"
	$fen_time tag bind $fen_time.menu <Any-Leave> "Eliminer_Highlight_Position TEXT %x %y {$fenetre}"
    }

    $fen_texte tag add $fen_texte.menu 1.0 "[expr $ligne_fin+1].0 lineend" 

    if {$cmd != ""} then {
	$fen_texte tag bind $fen_texte.menu <1> "$cmd %x %y"
    }

    if {$cmd1 != ""} then {
	$fen_texte tag bind $fen_texte.menu <3> "$cmd1 %x %y %X %Y"
    }

    $fen_texte tag bind $fen_texte.menu <Any-Motion> "Afficher_HighLight_Position TEXT %x %y {$fenetre}"
    $fen_texte tag bind $fen_texte.menu <Any-Leave> "Eliminer_Highlight_Position TEXT %x %y {$fenetre}"

    global Afficher_Colonne_Taches 
    if {$Afficher_Colonne_Taches == 1} then {

	set fen_proc [Widget_Process $frame_texte]
	$fen_proc tag add $fen_proc.menu 1.0 "[expr $ligne_fin+1].0 lineend"  

	$fen_proc tag bind $fen_proc.menu <Any-Motion> "Afficher_HighLight_Position TEXT %x %y {$fenetre}"
	$fen_proc tag bind $fen_proc.menu <Any-Leave> "Eliminer_Highlight_Position TEXT %x %y {$fenetre}"
    }

    if {$fenetre == $Fenetres_Affichage} then {

	set fen_fired [Widget_Fired $frame_texte]
	$fen_fired tag add $fen_fired.menu 1.0 "[expr $ligne_fin+1].0 lineend" 

	$fen_fired tag bind $fen_fired.menu <Any-Motion> "Afficher_HighLight_Position TEXT %x %y {$fenetre}"
	$fen_fired tag bind $fen_fired.menu <Any-Leave> "Eliminer_Highlight_Position TEXT %x %y {$fenetre}"
    }

}

proc Afficher_Menu_Texte_Transition_Bouton_Droit {menu fenetre x y r_x r_y} {
  global global_info_temps global_info_process heure_courante

  set frame_texte $fenetre.2
  set fen_texte [Widget_Main $frame_texte]

  set pos [$fen_texte index @0,$y]
  scan $pos "%d.%d" ligne colonne
  Afficher_Menu_Msc_Transition_Bouton_Droit $menu $fenetre $ligne $r_x $r_y
}

proc Effectuer_Goto_Vue_Tree {path} {
    global Chemin_Backward
    global Chemin_Forward
    global Numero_Transition_Courante
    global global_nb_tache
    global Transition_Courante_Vue_Tree 

    set Chemin_Backward ""
    set Chemin_Forward ""

    set Transition_Courante_Vue_Tree $path

    set temporary_path $path
    set ligne1 [split $temporary_path /]
    set ligne2 [lreplace $ligne1 0 0]
    if {[llength $ligne2] >= 1} then { 
	set ligne3 [join $ligne2 /]
	set temporary_path $ligne3

	set Chemin_Backward $ligne2
    }

    Ouvrir_Parents_Transition $path

    Envoi_Message "goto $Numero_Transition_Courante $temporary_path"

    Lire_Reponse 

    Recuperer_Information_Backcode Historique

}

proc Commande_Fermeture_Transition_Vue_Tree {process_event path} {
    global Arbre_Vue_Tree
    global tree_path
    global Transition_Courante_Vue_Tree

    global Select_Region_Mode
    if {$Select_Region_Mode == 1} {
	return
    }

    if {$process_event == 1} {

	BrowseCmd_Click_Souris_Vue_Tree $path
    }

    set liste_fils [$Arbre_Vue_Tree info children $path]
    foreach fils $liste_fils {
	$Arbre_Vue_Tree hide entry $fils
    }

    $tree_path setmode $path open

    global Liste_Transitions_Cachees
    if {[lsearch -exact $Liste_Transitions_Cachees $path] == -1} {
	set Liste_Transitions_Cachees \
		[lappend Liste_Transitions_Cachees $path]
    }

    Envoi_Message "close_current_node"

    Envoi_Message "number_of_open_children"
    Lire_Reponse

    global Fenetres_Affichage
    global Numero_Ligne_Transition_Courante_Vue_Tree
    global Nombre_Descendants_Ouverts_Transition_Courante

    Effacer_Sequence_Transitions_Colonne_Time $Fenetres_Affichage.3 \
	    [expr $Numero_Ligne_Transition_Courante_Vue_Tree + 1]\
	    [expr $Numero_Ligne_Transition_Courante_Vue_Tree + \
	    $Nombre_Descendants_Ouverts_Transition_Courante]
    Effacer_Sequence_Transitions_Colonne_Tasks $Fenetres_Affichage.3 \
	    [expr $Numero_Ligne_Transition_Courante_Vue_Tree + 1] \
	    [expr $Numero_Ligne_Transition_Courante_Vue_Tree + \
	    $Nombre_Descendants_Ouverts_Transition_Courante]
    Effacer_Sequence_Transitions_Colonne_Fired $Fenetres_Affichage.3 \
	    [expr $Numero_Ligne_Transition_Courante_Vue_Tree + 1] \
	    [expr $Numero_Ligne_Transition_Courante_Vue_Tree + \
	    $Nombre_Descendants_Ouverts_Transition_Courante]

}

proc Mise_A_Jour_Ligne_Time_Tasks_Fired_Vue_Tree {entree_courante ligne} {
    global Arbre_Vue_Tree
    global global_info_temps 
    global Fenetres_Affichage
    global tree_path

    set mode_entree_courante [$tree_path getmode $entree_courante]
    if {$mode_entree_courante != "open"} {
	set liste_fils [$Arbre_Vue_Tree info children $entree_courante]

	set inverted_liste_fils [lsort -decreasing $liste_fils]
	foreach fils $inverted_liste_fils {

	    set couleur [Determiner_Numero_Couleur_Transition $fils]

	    set data_fils [$Arbre_Vue_Tree info data $fils]
	    set label_fils [lindex $data_fils 0]

	    if {$global_info_temps} {
		set data_time [lindex $label_fils 5]
		Afficher_Temps_Ecoule_Dans_Colonne_Time $ligne \
		    "$data_time" \
		    $couleur $Fenetres_Affichage.3
	    }
	    set data_tasks [lindex $label_fils 4]
	    set data_fired [Label_Colonne_Fired $fils]

	    Afficher_Liste_Taches_Dans_Colonne_Tasks \
		    $ligne $data_tasks $couleur $Fenetres_Affichage.3
	    Afficher_Informations_Mise_A_Feu \
		    $ligne $data_fired $couleur $Fenetres_Affichage.3

	    Mise_A_Jour_Ligne_Time_Tasks_Fired_Vue_Tree $fils [expr $ligne + 1]
	}
    }

}	

proc Commande_Ouverture_Transition_Vue_Tree {process_event path} {
    global Arbre_Vue_Tree
    global Transition_Courante_Vue_Tree
    global tree_path

    global Select_Region_Mode
    if {$Select_Region_Mode == 1} {
	return
    }

    if {$process_event == 1} {

	BrowseCmd_Click_Souris_Vue_Tree $path
    }

    Envoi_Message "open_current_node"

    $tree_path setmode $path close

    global Liste_Transitions_Cachees
    set index_path [lsearch -exact $Liste_Transitions_Cachees $path]
    if {$index_path != -1} {
	set Liste_Transitions_Cachees \
		[lreplace $Liste_Transitions_Cachees $index_path $index_path]
    }

    set liste_fils [$Arbre_Vue_Tree info children $path]
    foreach fils $liste_fils {
	$Arbre_Vue_Tree show entry $fils
    }

    global Fenetres_Affichage
    global Numero_Ligne_Transition_Courante_Vue_Tree
    global Nombre_Descendants_Ouverts_Transition_Courante

    Mise_A_Jour_Ligne_Time_Tasks_Fired_Vue_Tree \
	    $path [expr $Numero_Ligne_Transition_Courante_Vue_Tree + 1]

}

set Transition_Courante_Vue_Tree "0"

proc BrowseCmd_Click_Souris_Vue_Tree {path} {
    global Transition_Courante_Vue_Tree
    global Arbre_Vue_Tree

    global Select_Region_Mode
    if {$Select_Region_Mode == 1} {
	$Arbre_Vue_Tree anchor set $Transition_Courante_Vue_Tree
	return
    }

    $Arbre_Vue_Tree selection clear
    set entry [tixEvent value]

    if {$entry == $Transition_Courante_Vue_Tree} {

	return
    } else {

	Effectuer_Goto_Vue_Tree $path
    }
}

proc Ajouter_Transition_Vue_Tree {path ligne1 ligne2 ligne3} {
    global Arbre_Vue_Tree
    global tree_path blue_tree_image all_fired_tree_image 
    global leaf_tree_image wait_tree_image sink_tree_image
    global exhibitor_actif 
    global Transition_Courante_Vue_Tree
    global Font_Tree_Label
    global Tree_View_Display_Comments
    global Numero_Transition_Courante
    global Fenetres_Affichage

    $Arbre_Vue_Tree selection clear

    set label [lindex $ligne1 2]

    set list_process [lindex $ligne1 4]

    if {[lindex $ligne1 1] == "T"} {
	set current_tree_image $wait_tree_image

	set Couleur_Texte 3
    } else {
	if {$ligne3 == 0} {

	    set current_tree_image $sink_tree_image

	    set Couleur_Texte 4
	} else {

	    set current_tree_image $leaf_tree_image

	    set Couleur_Texte 2
	}
    }

    $Arbre_Vue_Tree add $path -text "$label" \
	    -data "{$ligne1} {$ligne2} {$ligne3}" \
	    -itemtype imagetext -image $current_tree_image
    $Arbre_Vue_Tree configure -font $Font_Tree_Label

    set number_transition [lindex $ligne1 0]

    if {$path != "0"} {
	set father [$Arbre_Vue_Tree info parent $path]
	set list_children [$Arbre_Vue_Tree info children $father]

	set i 0
	while {1} {
	    set child [lindex $list_children $i]
	    if {$child == ""} {
		break
	    } else {

		set data_child [lindex [$Arbre_Vue_Tree info data $child] 0]
		set number_transition_child [lindex $data_child 0]
		
		if {[expr $number_transition_child > $number_transition] == 1} {
		    $Arbre_Vue_Tree delete entry $path
		    $Arbre_Vue_Tree add $path -before $child \
			    -text "$label" \
			    -data "{$ligne1} {$ligne2} {$ligne3}" \
			    -itemtype imagetext -image $current_tree_image
		    $Arbre_Vue_Tree configure -font $Font_Tree_Label
		    break
		}
	    }
	    incr i 1
	} 
    }

    global Numero_Ligne_Transition_Courante_Vue_Tree
    Afficher_Temps_Ecoule_Dans_Colonne_Time $Numero_Ligne_Transition_Courante_Vue_Tree "[lindex $ligne1 5]" $Couleur_Texte $Fenetres_Affichage.3

    Afficher_Liste_Taches_Dans_Colonne_Tasks $Numero_Ligne_Transition_Courante_Vue_Tree $list_process $Couleur_Texte $Fenetres_Affichage.3

    Afficher_Informations_Mise_A_Feu $Numero_Ligne_Transition_Courante_Vue_Tree [Label_Colonne_Fired $path] $Couleur_Texte $Fenetres_Affichage.3

    Realiser_Focus_Ligne_Texte TREE $Fenetres_Affichage $Numero_Ligne_Transition_Courante_Vue_Tree

    if {$path != "0"} {

	if {$father != ""} {
	    $tree_path setmode $father close
	}

	set data_father [$Arbre_Vue_Tree info data $father]
	set couleur_pere [Determiner_Numero_Couleur_Transition $father]
	if {$couleur_pere == 0} {

	    $Arbre_Vue_Tree entryconfigure $father -image $blue_tree_image
	} elseif {$couleur_pere == 1} {

	    $Arbre_Vue_Tree entryconfigure $father -image $all_fired_tree_image
	} elseif {$couleur_pere == 5} {

	    global selection_tree_image
	    $Arbre_Vue_Tree entryconfigure $father -image $selection_tree_image

	}

	global Numero_Ligne_Transition_Parent_Vue_Tree
	Mettre_A_Jour_Couleur_Et_Texte_Transition 3 $Numero_Ligne_Transition_Parent_Vue_Tree $father

    }

}

proc Etablir_Bindings_Highlight_Transition_Vue_Tree {fenetre numero_ligne} {
    global global_info_temps 
    global global_info_process
    global Fenetres_Affichage

    set frame_texte $fenetre.3
    set fen_texte [Widget_Main $frame_texte]

    if {$global_info_temps} then {

	set fen_time [Widget_Time $frame_texte]
	$fen_time tag add $fen_time.menu 1.0 "$numero_ligne.0 lineend" 

	$fen_time tag bind $fen_time.menu <Any-Motion> "Afficher_HighLight_Position TREE %x %y {$fenetre}"
	$fen_time tag bind $fen_time.menu <Any-Leave> "Eliminer_Highlight_Position TREE %x %y {$fenetre}"
    }

    global Afficher_Colonne_Taches 
    if {$Afficher_Colonne_Taches == 1} then {

	set fen_proc [Widget_Process $frame_texte]
	$fen_proc tag add $fen_proc.menu 1.0 "$numero_ligne.0 lineend"  

	$fen_proc tag bind $fen_proc.menu <Any-Motion> "Afficher_HighLight_Position TREE %x %y {$fenetre}"
	$fen_proc tag bind $fen_proc.menu <Any-Leave> "Eliminer_Highlight_Position TREE %x %y {$fenetre}"
    }

    if {$fenetre == $Fenetres_Affichage} then {

	set fen_fired [Widget_Fired $frame_texte]
	$fen_fired tag add $fen_fired.menu 1.0 "$numero_ligne.0 lineend" 

	$fen_fired tag bind $fen_fired.menu <Any-Motion> "Afficher_HighLight_Position TREE %x %y {$fenetre}"
	$fen_fired tag bind $fen_fired.menu <Any-Leave> "Eliminer_Highlight_Position TREE %x %y {$fenetre}"
    }

}

proc Mettre_Highlight_Colonnes_Time_Tasks_Fired_Vue_Msc {fenetre numero_ligne couleur} {
    global global_info_temps 
    global global_info_process
    global Fenetres_Affichage

    set frame_texte $fenetre.3
    set fen_texte [Widget_Main $frame_texte]

    if {$global_info_temps} then {

	set fen_time [Widget_Time $frame_texte]
	Afficher_HighLight_Ligne $fen_time $numero_ligne $couleur
    }

    global Afficher_Colonne_Taches 
    if {$Afficher_Colonne_Taches == 1} then {

	set fen_proc [Widget_Process $frame_texte]
	Afficher_HighLight_Ligne $fen_proc $numero_ligne $couleur
    }

    if {$fenetre == $Fenetres_Affichage} then {

	set fen_fired [Widget_Fired $frame_texte]
	Afficher_HighLight_Ligne $fen_fired $numero_ligne $couleur
    }
}

proc Eliminer_Highlight_Colonnes_Time_Tasks_Fired_Vue_Msc {fenetre numero_ligne} {
    global global_info_temps 
    global global_info_process
    global Fenetres_Affichage

    set frame_texte $fenetre.3
    set fen_texte [Widget_Main $frame_texte]

    if {$global_info_temps} then {

	set fen_time [Widget_Time $frame_texte]
	Eliminer_Highlight_Ligne $fen_time $numero_ligne
    }

    global Afficher_Colonne_Taches 
    if {$Afficher_Colonne_Taches == 1} then {

	set fen_proc [Widget_Process $frame_texte]
	Eliminer_Highlight_Ligne $fen_proc $numero_ligne
    }

    if {$fenetre == $Fenetres_Affichage} then {

	set fen_fired [Widget_Fired $frame_texte]
	Eliminer_Highlight_Ligne $fen_fired $numero_ligne
    }
}

proc Executer_Wait {} {
    global Value_Wait_Time

    set Temps [expr $Value_Wait_Time]

    if {$Temps < 0 || [catch {expr $Temps + 1}]} then {
	return 0
    }

    Ouvrir_Noeud_Courant_Vue_Tree

    Envoi_Message "wait [expr $Temps + 1.0 - 1.0]"

    Lire_Reponse 

}

proc Reactualiser_Temps_Format_Texte {Time_Widget Time_Value} {

    $Time_Widget.frame_entry_scale.entry delete 0 end
    $Time_Widget.frame_entry_scale.entry insert 1 [expr $Time_Value / 1000.0]
}

proc Lire_Wait_Time_Sur_Entry {Time_Widget} {
    global Value_Wait_Time_Scale
    global Value_Wait_Time

    if [catch {set Value_Wait_Time \
	    [$Time_Widget.frame_entry_scale.entry get]} resultat_get] {
	Afficher_Message_Erreur "Irregular value of time" {}
	return 
    } elseif [catch {set temp [expr $Value_Wait_Time + 0.0]} resultat_expr] {

	Afficher_Message_Erreur "Value of time $Value_Wait_Time\nis not real" {}
	return 
    } elseif {$Value_Wait_Time < 0.0 || $Value_Wait_Time >= 1.0} {
	Afficher_Message_Erreur "Value of time $Value_Wait_Time\nout of \
		the range \[0..1\[" {}
	return 
    }

    set Value_Wait_Time_Scale [expr $Value_Wait_Time * 1000]
    $Time_Widget.frame_entry_scale.scale set $Value_Wait_Time_Scale

    Executer_Wait
}

proc Afficher_Transition_Wait {status indice porte etat procs time rebouclage} {
    global Numero_Transition_Courante global_heure_courante Fenetres_Affichage
    global global_info_process
    global changement_transition
    global global_info_rebouclage
    global Transition_Courante_Vue_Tree

    set couleur 3
    set global_info_rebouclage $rebouclage
    if {$global_info_process} then {

	set  changement_transition $status
    }

    if {$global_info_rebouclage} then {
	set porte "$porte : Loopback \[Step $global_info_rebouclage\]"
    }

    set global_heure_courante $time

    global Pref_Main_Win_Type
    global Arbre_Vue_Tree
    Mettre_A_Jour_Couleur_Et_Texte_Transition $Pref_Main_Win_Type [expr $Numero_Transition_Courante -1] [$Arbre_Vue_Tree info parent $Transition_Courante_Vue_Tree]

    global Numero_Ligne_Transition_Parent_Vue_Tree
    Mettre_A_Jour_Couleur_Et_Texte_Transition 3 $Numero_Ligne_Transition_Parent_Vue_Tree [$Arbre_Vue_Tree info parent $Transition_Courante_Vue_Tree]

    if {$Pref_Main_Win_Type == 2} {
	Afficher_Transition_Vue_Texte $Numero_Transition_Courante \
		$Transition_Courante_Vue_Tree \
		$porte $procs $global_heure_courante $couleur \
		$Fenetres_Affichage 
    } elseif {$Pref_Main_Win_Type == 1} {
	Afficher_Transition_Vue_Msc $Numero_Transition_Courante \
		$Transition_Courante_Vue_Tree \
		$porte $procs $global_heure_courante $couleur \
		$Fenetres_Affichage ""
    }

}

proc Creer_Menu_Principal {top} {
    global w_m_run w_m_help 
    global w_m_edit w_m_scenario w_m_simulation_options w_m_backcode 
    global w_m_new_functions 
    global global_info_temps
    global global_menu_bg_color
    global main 
    global env imprimante fenetres
    global Auto_Advance_Max_Steps Auto_Advance_Current_Step
    global Auto_Advance_Option Loopback_Option global_proc_names 
    global Tree_View_Display_Comments
    global Nom_Scenario_Courant
    global Viewing_Source_Code
    global current_list_procs
    global Ocis_Version
    global Foreground_Windows
    global ocis_local_startup_file
    global ocis_global_startup_file

    set w [frame $top.frame -bd 2 -relief raised -bg $global_menu_bg_color]

    set w_m_scenario $w.scenario.m
    set w_m_edit $w.edit.m
    set w_m_run $w.run.m
    set w_m_simulation_options $w.simulation_options.m
    set w_m_backcode $w.backcode.m
    set w_m_new_functions $w.new_functions.m
    set w_m_help $w.help.m

    Initialiser_Menu_Help $w

    bind $top <Configure> ComputeRulesWinMain 

    menubutton $w.scenario -menu $w_m_scenario -text "File" \
	    -bg $global_menu_bg_color
    menubutton $w.edit -menu $w_m_edit -text "Edit" -bg $global_menu_bg_color
    menubutton $w.run -menu $w_m_run -text "Motion" -bg $global_menu_bg_color
    menubutton $w.simulation_options -menu $w_m_simulation_options \
	    -text "Options" -bg $global_menu_bg_color
    menubutton $w.backcode -menu $w_m_backcode -text "Window" \
	    -bg $global_menu_bg_color
    menubutton $w.new_functions -menu $w_m_new_functions \
	    -text "New_Functions" -bg $global_menu_bg_color
    menubutton $w.help -menu $w_m_help -text "Help" -bg $global_menu_bg_color

    menu $w_m_scenario  -tearoff 0 -bg $global_menu_bg_color
    $w_m_scenario add command -label "Reset" -underline 0 \
	    -command {Reset_Scenario 1} -accelerator Ctrl+l
    bind $top <Control-l> {Reset_Scenario 1}

    $w_m_scenario add command -label "New" -underline 0  \
	    -command Creer_Nouveau_Scenario
    $w_m_scenario add command -label "Load ..." -underline 0 \
	    -command {Charger_Scenario Fichier_Bcg_A_Ouvrir} \
	    -accelerator Ctrl+o
    bind $top <Control-o> {Charger_Scenario Fichier_Bcg_A_Ouvrir}

    $w_m_scenario add command -label "Save as ..." -underline 1 \
	    -command {Sauvegarder_Scenario 0}

    $w_m_scenario add command -label "Save" -underline 0 \
	    -command {Sauvegarder_Scenario 1} \
	    -accelerator Ctrl+s
    bind $top <Control-s> {Sauvegarder_Scenario 1}

    $w_m_scenario add separator
    $w_m_scenario add command -label "Save sequence tree ..." -underline 0 \
	    -command {Ouvrir_Fenetre_Selection_Fichier .selection_filebox \
	    {Saving sub-tree} {*.bcg} \
	    Save {Save_Sequence_Tree} {Fichier_Sequence_Tree}}

    $w_m_scenario add command -label "Save a sequence of labels ..." \
            -underline 0 -command {Ouvrir_Fenetre_Selection_Fichier \
             .selection_filebox {Saving a sequence of labels} {*.seq} \
	    Save Display_Top_Path_Of_Transition {Fichier_Sequence_Labels}}

    $w_m_scenario add separator
    $w_m_scenario add command -label "Preview postscript ..." -underline 0 \
	    -command Ouvrir_Fenetre_Preview

    $w_m_scenario add command -label "Print postscript ..." -underline 0 \
	    -command Ouvrir_Fenetre_Imprimante -accelerator Ctrl+i
    bind $top <Control-i> {Ouvrir_Fenetre_Imprimante}

    $w_m_scenario add command -label "Save postscript ..." -underline 5 \
	    -command Sauvegarder_Postscript_Fenetre_Principale \
	    -accelerator Ctrl+w
    bind $top <Control-w> {Sauvegarder_Postscript_Fenetre_Principale}

    $w_m_scenario add separator
    $w_m_scenario add command -label "Save preferences \
	    in current directory" -underline 3 \
	    -command {Save_Ocis_Preferences $ocis_local_startup_file}
    $w_m_scenario add command -label "Save preferences \
	    in home directory" -underline 3 \
	    -command {Save_Ocis_Preferences $ocis_global_startup_file}
    $w_m_scenario add command -label "Reset preferences" \
	    -underline 3 -command Reset_Ocis_Preferences

    $w_m_scenario add separator
    $w_m_scenario add command -label "Quit" -underline 0 \
	    -command Quitter_Proprement_Ocis -accelerator Ctrl+q
    bind $top <Control-q> {Quitter_Proprement_Ocis}

    menu $w_m_edit -tearoff 0 -bg $global_menu_bg_color
    global Liste_Transitions_Selectionnees

    $w_m_edit add command -label "Select current transition (Tree view only)" -underline 0 \
	    -command {Selectionner_Transition_Courante}

    $w_m_edit add command -label "Select specific transitions (Tree view only)" -underline 0 -command Ouvrir_Fenetre_Selection_Label

    $w_m_edit add separator
    $w_m_edit add command -label "Disable selection (Tree view only)" -underline 0 \
	    -command Liberer_Transitions_Selectionnees
    $w_m_edit add separator

    $w_m_edit add command -label "Close selected transitions (Tree view only )"\
	    -underline 0 -command Fermer_Transitions_Selectionnees

    $w_m_edit add command -label "Open selected transitions (Tree view only )"\
	    -underline 0 -command Ouvrir_Transitions_Selectionnees

    $w_m_edit add separator

    $w_m_edit add command -label "Cut selected transitions" -underline 0 \
	    -command {set Liste_Transitions_Selectionnees \
	    [lsort $Liste_Transitions_Selectionnees] ; \
	    Couper_Transitions_Selectionnees}

    $w_m_edit add command -label "Cut current transition" -underline 0 \
	    -command Cut_Current_Transition 

    $w_m_edit add command -label "Cut down tree of current transition"\
	    -underline 0 -command Cut_Down_Tree_Of_Transition 

    menu $w_m_simulation_options -tearoff 0 -bg $global_menu_bg_color
    $w_m_simulation_options add checkbutton -label "Auto advance mode" \
	    -underline 0 -variable Auto_Advance_Option 
	      

    set Auto_Advance_Current_Step 0
    $w_m_simulation_options add checkbutton -label "Loopback checking" \
	    -underline 0 -variable Loopback_Option\
	    -command {Envoi_Message "set_loopback $Loopback_Option"}

    $w_m_simulation_options add checkbutton -label "Extended MSC format" \
	    -underline 0 -variable global_proc_names \
	    -command {Afficher_Active_Path_Vue_Msc_Ou_Texte "Msc"}

    $w_m_simulation_options add separator
    set Foreground_Windows 0
    $w_m_simulation_options add checkbutton -label "Make windows foreground" \
	    -underline 0 -variable Foreground_Windows\
	    -command {Bind_Foreground_Windows}

    menu $w_m_backcode -tearoff 0 -bg $global_menu_bg_color
    $w_m_backcode add command -label "Edit source file" -underline 0 \
	    -command {Ouvrir_Fenetre_Selection_Fichier .selection_filebox \
	    {Editing text files} {*} Edit {Lancer_Edition_Fichier} \
	    {Fichier_A_Editer}} 

    $w_m_backcode add command -label "Viewing source code" -underline 0 \
	    -command {set Viewing_Source_Code 1; \
	    set current_list_procs ""; menu_dynamic_backcode trace 0} \
	    -accelerator Ctrl+v
    bind $top <Control-v> {set Viewing_Source_Code 1;\
	    set current_list_procs ""; menu_dynamic_backcode trace 0}

    $w_m_backcode add command -label "Recompile" -underline 0 \
	    -command {Creer_Et_Ouvrir_Fenetre_Recompilation} -accelerator Ctrl+r
    bind $top <Control-r> {Creer_Et_Ouvrir_Fenetre_Recompilation}

    $w_m_backcode add separator
    $w_m_backcode add command -label "Open shell window" -underline 0 \
	    -command {set $env(XTERM_OPTIONS) $Xterm_Options ; \
		      Envoi_Message "shell $env(CADP)/src/com/cadp_xterm &" ; \
		      Lire_Reponse}

    menu $w_m_run -tearoff 0 -bg $global_menu_bg_color
    $w_m_run add command -label "Backward" -underline 0 \
	    -command Effectuer_1_Pas_Arriere -accelerator Ctrl+b
    bind $top <Control-b> {Effectuer_1_Pas_Arriere}

    $w_m_run add command -label "Forward" -underline 0 \
	    -command Effectuer_1_Pas_Avant -accelerator Ctrl+f
    bind $top <Control-f> {Effectuer_1_Pas_Avant}

    $w_m_run add separator
    $w_m_run add command -label "Show current transition" -underline 0 \
	    -command {Montrer_Transition_Courante}
    $w_m_run add command -label "Show top" -underline 0 \
	    -command {Montrer_Transition_Initiale}

    $w_m_run add separator
    $w_m_run add command -label "Find regular expressions" -underline 0 \
		-command Creer_Et_Ouvrir_Fenetre_Exhibitor -accelerator Ctrl+e
    bind $top <Control-e> {Creer_Et_Ouvrir_Fenetre_Exhibitor}

    menu $w_m_new_functions -tearoff 0 -bg $global_menu_bg_color
    $w_m_new_functions add command -label "Line number of current transition"\
	    -underline 0 -command {Envoi_Message "line_number" ; Lire_Reponse}

    $w_m_new_functions add command -label "Number of children of current transition"\
	    -underline 0 -command {Envoi_Message "number_of_children" ; Lire_Reponse}

    $w_m_new_functions add command -label "Number of open children of current transition"\
	    -underline 0 -command {Envoi_Message "number_of_open_children" ; Lire_Reponse}

    $w_m_new_functions add separator
    $w_m_new_functions add command -label "Execute text commands" \
	    -underline 0 -command ocis_batch_cmd 

    $w_m_new_functions add command -label "Save history" \
	    -underline 0 -command ocis_save_history_cmd 

    menu $w_m_help -tearoff 0 -bg $global_menu_bg_color
    $w_m_help add command -label "Index" -underline 1 \
	    -command {help_show help_intro} -accelerator F1
    bind $top <F1> {help_show help_intro}
    $w_m_help add separator
    $w_m_help add command -label "About..." -underline 0 \
	    -command {Afficher_Message_Erreur "OCIS (Open/Caesar Interactive Simulator) version $Ocis_Version\n\n" {}}
		

    pack $w.scenario -side left
    pack $w.edit -side left
    pack $w.run -side left
    pack $w.backcode -side left
    pack $w.simulation_options -side left

    pack $w.help -side right
    return $w
}

proc gen_toolbar {w liste_couples} {
    global w_balloon_help global_menu_bg_color
    global Font_Bold_9

    frame $w.buttons -relief raised -bd 1 -bg $global_menu_bg_color
    foreach i $liste_couples {
	set nom $w.buttons.[lindex $i 0]
	if {[lindex $i 1] == ""} {
	    button $nom -width 1 -state disabled -relief flat \
		    -bg $global_menu_bg_color
	    pack $nom -side left
	} elseif {[lindex $i 1] == "texte"} {
	    button $nom -width 1 -text [lindex $i 4] -font $Font_Bold_9 \
		    -relief raised -foreground [lindex $i 2] \
		    -bg $global_menu_bg_color -command [lindex $i 3] 
	    pack $nom -side left
	} elseif {[lindex $i 1] == "image"} {
	    set pic [tix getimage [lindex $i 2]]
	    set commande [lindex $i 3]
	    button $nom -image $pic  -width 20 -height 20 \
		    -command $commande -bg $global_menu_bg_color
	    pack $nom -side left
	    $w_balloon_help bind $nom -balloonmsg [lindex $i 4] \
		    -statusmsg  [lindex $i 5]
	}
    }
    return $w.buttons
}

proc Creer_Fenetre_Principale {w} {
    global w_pane_top w_pane_bottom env global_info_temps global_info_process
    global global_info_source w_hist w_trans global_info_temps
    global Pref_Trans_Win_Type Pref_Main_Win_Type   
    global global_heure_courante
    global global_menu_bg_color
    global global_bg_color 
    global Title_Color
    global Pane_Border_Width Separator_Bg Pane_Relief Handle_Active_Bg
    global Height_Msc_View Height_Trans_View
    global env imprimante fenetres
    global Note_Book_Path Note_Book_Trans
    global Note_Book_Path_Msc Note_Book_Path_Text Note_Book_Path_Tree 
    global Note_Book_Trans_Msc Note_Book_Trans_Text Note_Book_Trans_Wait 
    global Wait_Time_Slider Value_Wait_Time_Scale 
    global Value_Wait_Time
    global Font_Bold_9 Font_Bold_10

    set menu [Creer_Menu_Principal $w]
    pack $menu -side top -fill x

    frame $w.top -relief raised -bd 1 -bg $global_menu_bg_color 
    pack $w.top -side top -fill both

    set path $env(OCIS)/tix
    tix addbitmapdir $env(OCIS)/bitmaps

    Initialiser_Balloon_Help $w $w.statusobal
    set buttons [gen_toolbar $w.top { \
	{reset image win_reset "Reset_Scenario 1" "Reset" \
		"Reset transitions"} \
	{new image win_new "Creer_Nouveau_Scenario" "New scenario" \
		"Create a new scenario"} \
	{load image win_load {Charger_Scenario Fichier_Bcg_A_Ouvrir} \
	"Load scenario" "Load scenario"} \
	{save image win_save {Sauvegarder_Scenario 1} \
	"Save current scenario" "Save current scenario"} \
	{sep1} \
	{back image win_back "Effectuer_1_Pas_Arriere" "Back" \
		"Go 1 step backward"} \
	{forward image win_next "Effectuer_1_Pas_Avant" "Forward" \
		"Go 1 step forward"} \
	{sep2} \
	{exhibitor image win_explore \
	"Creer_Et_Ouvrir_Fenetre_Exhibitor" "Exhibitor" \
	"Popup exhibitor interface"}\
	{sep3} \
	{ap_print image win_ap_print "Ouvrir_Fenetre_Preview" "Preview" \
		"Preview before printing"} \
	{print image win_print "Ouvrir_Fenetre_Imprimante" "Print" \
		"Print the document"} \
	{sep4} \
	{recompile image compile-up \
	"Creer_Et_Ouvrir_Fenetre_Recompilation" \
	"Recompile" "Recompile the source"}
         {edit image folder-up "Ouvrir_Fenetre_Selection_Fichier .selection_filebox {Editing text files} {*} Edit {Lancer_Edition_Fichier} {Fichier_A_Editer}" \
		 "Edit a file" "Edit a file"} 

    }]
    pack $buttons -side top -expand yes -anchor w -fill x

    label $w.status -relief sunken -bd 1 -bg $global_menu_bg_color \
	    -foreground black
    pack $w.status -side bottom -fill x 

    .main.status configure -text \
	    "Go to top view to navigate in current scenario, \
	    and fire transitions in bottom view"

    tixPanedWindow $w.pane -paneborderwidth $Pane_Border_Width \
	    -separatorbg $Separator_Bg -panerelief $Pane_Relief \
	    -handlebg $Handle_Active_Bg -handleactivebg $Handle_Active_Bg\
	    -bg $global_menu_bg_color
    pack $w.pane -fill both -expand yes

    set w_pane_top [$w.pane add msc -min 100 -size $Height_Msc_View -expand 1.0]
    $w_pane_top configure -bg $global_menu_bg_color

    set w_pane_bottom [$w.pane add transitions -min 100 \
	    -size $Height_Trans_View -expand 0.0]
    $w_pane_bottom configure -bg $global_menu_bg_color

    set Note_Book_Path [tixNoteBook $w_pane_top.note \
	    -dynamicgeometry yes  -bg $global_menu_bg_color]
    pack $w_pane_top.note -fill both -expand yes
    $w_pane_top.note subwidget nbframe configure -bg $global_menu_bg_color\
	    -backpagecolor $global_menu_bg_color \
	    -inactivebackground $global_menu_bg_color

    set Note_Book_Trans [tixNoteBook $w_pane_bottom.note \
	    -dynamicgeometry yes -bg $global_menu_bg_color]
    pack $w_pane_bottom.note -fill both -expand yes
    $w_pane_bottom.note subwidget nbframe configure -bg $global_menu_bg_color\
	    -backpagecolor $global_menu_bg_color \
	    -inactivebackground $global_menu_bg_color

    if {$global_info_process} {

	set Note_Book_Path_Msc [$w_pane_top.note add 1 -label "MSC format" \
		-underline 0 \
		-raisecmd {set Pref_Main_Win_Type 1 ; \
		Afficher_Active_Path_Vue_Msc_Ou_Texte "Msc"}]
	set w_hist(1) [$w_pane_top.note subwidget 1]
	$w_hist(1) configure -background $global_menu_bg_color

	bind $w_hist(1) <Enter> {$main.status configure -text \
		"Use button left-click to select a transition"}

	set Note_Book_Trans_Msc [$w_pane_bottom.note add 1 \
		-label "MSC - Next Transitions" -underline 1 \
		-raisecmd "set Pref_Trans_Win_Type 1"]
	set w_trans(1) [$w_pane_bottom.note subwidget 1]
	$w_trans(1) configure -background $global_menu_bg_color

	bind $w_trans(1) <Enter> {$main.status configure -text \
		"Use button left-click to fire a transition, \
		and right-click to open source code window"}
    }

    set Note_Book_Path_Text [$w_pane_top.note add 2 \
	    -label "Text format" -underline 2 \
	    -raisecmd {set Pref_Main_Win_Type 2 ; \
	    Afficher_Active_Path_Vue_Msc_Ou_Texte "Text" }]
    set w_hist(2) [$w_pane_top.note subwidget 2]
    $w_hist(2) configure -background $global_menu_bg_color

    bind $w_hist(2) <Enter> {$main.status configure -text \
	    "Use button left-click to select a transition"}

    $w_pane_bottom.note subwidget nbframe config
    set Note_Book_Trans_Text [$w_pane_bottom.note add 2 \
	    -label "Text - Next Transitions" \
	    -underline 1 -raisecmd "set Pref_Trans_Win_Type 2"]
    set w_trans(2) [$w_pane_bottom.note subwidget 2]
    $w_trans(2) configure -background $global_menu_bg_color

    bind $w_trans(2) <Enter> {$main.status configure -text \
	    "Use button left-click to fire a transition, and \
	    right-click to open source code window"}

    set Note_Book_Path_Tree [$w_pane_top.note add 3 -label "Tree format" \
	    -underline 0 -raisecmd "set Pref_Main_Win_Type 3"]
    set w_hist(3) [$w_pane_top.note subwidget 3]
    $w_hist(3) configure -background $global_menu_bg_color

    bind $w_hist(3) <Enter> {$main.status configure -text \
	    "Use button left-click to select a transition"}

    if {$global_info_temps} {
	set Note_Book_Trans_Wait [$w_pane_bottom.note add time \
		-label "WAIT" -underline 0]
	set w_wait [$w_pane_bottom.note subwidget time]
	$w_wait configure -background $global_menu_bg_color
	
	bind $w_wait <Enter> {$main.status configure -text \
		"Each left-click on \"WAIT\" button adds a temporal \
		transition"}

	set frame_titre [frame $w_wait.frame_titre -bg $global_menu_bg_color]
	label $frame_titre.titre \
		-text "\nAdding a temporal transition (WAIT)"\
		-font $Font_Bold_10 -bg $global_menu_bg_color
	pack $frame_titre -side top -fill both -expand yes -padx 3 -pady 3 
	pack $frame_titre.titre  -side top 

	set frame_valeur_temps [frame $w_wait.frame_valeur_temps \
		-bg $global_menu_bg_color]
	label $frame_valeur_temps.label \
		-text "Waiting time (less than 1 second):" \
		-font $Font_Bold_9 -bg $global_menu_bg_color

	frame $frame_valeur_temps.frame_entry_scale -bg $global_menu_bg_color
	set Wait_Time_Slider $frame_valeur_temps.frame_entry_scale.scale
	scale $Wait_Time_Slider -from 0 -to 999 \
		-variable Value_Wait_Time_Scale \
		-orient horizontal -font $Font_Bold_9  \
		-bg $global_menu_bg_color -borderwidth 0 -troughcolor white\
		-command [subst {Reactualiser_Temps_Format_Texte \
		$frame_valeur_temps}] \
		-digits 8 -showvalue 0
	entry $frame_valeur_temps.frame_entry_scale.entry \
		-background $global_bg_color \
		-font $Font_Bold_9 
	$frame_valeur_temps.frame_entry_scale.entry insert end \
		$global_heure_courante
	pack $frame_valeur_temps  -side top -fill x -expand yes -padx 3 -pady 3
	pack $frame_valeur_temps.label -padx 10 -fill x -side left 
	pack $frame_valeur_temps.frame_entry_scale -padx 10 \
		-expand yes -fill x -side left 
	pack $frame_valeur_temps.frame_entry_scale.entry \
		-side top -expand yes -fill x 
	pack $frame_valeur_temps.frame_entry_scale.scale \
		-side bottom -expand yes -fill x 

	button $w_wait.wait -text "Add WAIT transition" \
		-font $Font_Bold_9 -takefocus yes \
		-background $global_menu_bg_color \
		-command [subst {Lire_Wait_Time_Sur_Entry $frame_valeur_temps}]

	pack $w_wait.wait -padx 10 -expand yes -side top -padx 3 -pady 3 
    }
}

proc Lire_Images_Vue_Tree {} {
    global blue_tree_image 
    global all_fired_tree_image 
    global leaf_tree_image
    global wait_tree_image
    global sink_tree_image
    global selection_tree_image

    set blue_tree_image      [tix getimage blue_msc_image]
    set all_fired_tree_image [tix getimage red_msc_image]
    set leaf_tree_image      [tix getimage green_msc_image]
    set wait_tree_image      [tix getimage orange_msc_image]
    set sink_tree_image      [tix getimage black_msc_image]
    set selection_tree_image [tix getimage yellow_msc_image]

}

proc scrollMultiple_y {lists vs first last} {
    $vs set $first $last
}

proc SetMultiple_y  {scrollbar_path type_vue lists args} {

    if {$type_vue == "MSC" || $type_vue == "TEXT"} {
	foreach l $lists { 
	    eval $l yview $args 
	}
    } else {

	global global_info_temps

	if {$global_info_temps} {
	    set num_colonne_tree 2
	} else {
	    set num_colonne_tree 1
	}
	set i 1
	foreach l $lists { 
	    if {$i != $num_colonne_tree} {
		eval $l yview $args 
	    } else {
		set arbre [$l subwidget hlist] 
		eval $arbre yview $args
	    }
	    incr i 1
	}
    }
}

proc Scroller_Horizontalement_Widget_Tree {center args} {
    set arbre [$center subwidget hlist]
    eval $arbre xview $args
}

proc Generer_Widgets_Vues {type_vue w sub bool_time bool_process bool_text bool_fired title} {
  global global_bg_color global_menu_bg_color
  global Pane_Border_Width Separator_Bg Pane_Relief Handle_Active_Bg
  global Width_Time_View Width_TextTrace_View Width_Processes_View
  global global_nb_tache

  frame $w.$sub -background $global_menu_bg_color

  set curseur [. cget -cursor]

    if {$bool_time || $bool_process || $bool_fired} {
      tixPanedWindow $w.$sub.pane \
	      -paneborderwidth $Pane_Border_Width -separatorbg $Separator_Bg \
	      -separatoractivebg $global_menu_bg_color \
	      -panerelief $Pane_Relief -handlebg $Handle_Active_Bg \
	      -orient horizontal -handleactivebg $Handle_Active_Bg \
	      -bg $global_menu_bg_color

      if { $bool_time } {
	  set Width_Time_View 50
	  set pane_left [$w.$sub.pane add left \
		  -size $Width_Time_View -expand 0.0]

	  $pane_left configure -bg $global_menu_bg_color
      }

      set pane_center [$w.$sub.pane add center -min 100 -expand 1.0 ]  
      $pane_center configure -bg $global_menu_bg_color

      if { $bool_process } {
	  set Old_Width_Processes_View $Width_Processes_View
	  set Width_Processes_View [expr $global_nb_tache * 3]
	  if {$Width_Processes_View > $Old_Width_Processes_View} {
	      set Width_Processes_View $Old_Width_Processes_View
	  } elseif {$Width_Processes_View < 50} {
	      set Width_Processes_View 50
	  }
	  set pane_right [$w.$sub.pane add right \
		  -size $Width_Processes_View -expand 0.0]  

	  $pane_right configure -bg $global_menu_bg_color
      }

      if {$bool_fired} {
	  set Width_Fired_View 50
	  set pane_fired [$w.$sub.pane add fired \
		  -size $Width_Time_View -expand 0.0 ]  

	  $pane_fired configure -bg $global_menu_bg_color
      }

  } else {
    set pane_center $w.$sub
    $pane_center configure -bg $global_menu_bg_color

  }

  set left ""
  set right ""
  set left_return ""
  set right_return ""

  if { $bool_time } {
    set left   [frame $pane_left.in -background $global_menu_bg_color]
    lappend list_frames $left.contents
    set left_return $left.contents
  }

  set center [frame $pane_center.in -background $global_menu_bg_color]
  lappend list_frames $center.contents
  set center_return $center.contents

  if { $bool_process } {
    set right [frame $pane_right.in -background $global_menu_bg_color]
    lappend list_frames $right.contents
    set right_return $right.contents
  }

  set fired_return ""
  if {$bool_fired} {
      if [info exists pane_fired] {
	  set fired [frame $pane_fired.in -background $global_menu_bg_color]
	  lappend list_frames $fired.contents
	  set fired_return $fired.contents
      }
  }

  scrollbar $w.$sub.vscroll \
	  -command "SetMultiple_y $w.$sub.vscroll $type_vue [list $list_frames]" \
	  -width 10 -bg $global_menu_bg_color

  pack $w.$sub.vscroll -side right -fill y

  if {$bool_time || $bool_process || $bool_fired} {
      pack $w.$sub.pane -fill both -expand yes
  }
  if { $bool_time } {
    pack $left -fill both -expand yes
  }
  if { $bool_process } {
    pack $right -fill both -expand yes
  }
  pack $center -fill both -expand yes

  if {$bool_fired} {
      if [info exists pane_fired] {
	  pack $fired -fill both -expand yes
      }
  }

  if { $bool_time } {
      if {$bool_text} {
	  text $left.contents -width 10 \
		  -wrap none\
		  -background $global_bg_color \
		  -foreground blue4 \
		  -selectbackground $global_bg_color \
		  -selectforeground blue4 \
		  -cursor $curseur\
		  -highlightbackground $global_menu_bg_color \
		  -xscrollcommand "$left.hscroll set" \
		  -yscrollcommand "scrollMultiple_y [list $list_frames] $w.$sub.vscroll"

      } else {
	  canvas $left.contents -width 50 \
		  -background $global_bg_color \
		  -xscrollcommand "$left.hscroll set" \
		  -yscrollcommand "scrollMultiple_y [list $list_frames] $w.$sub.vscroll "\
		  -cursor $curseur\
		  -highlightbackground $global_menu_bg_color
      }

      scrollbar $left.hscroll -command "$left.contents xview" \
	      -orient horizontal -width 10 -bg $global_menu_bg_color

      if {$title != ""} {
	  label $left.title -text "Time" -anchor center -bd 2 \
		  -relief raised -bg $global_menu_bg_color
	  pack $left.title -side top -fill x
      }
      pack $left.hscroll -side bottom -fill x
      pack $left.contents -side bottom -fill both -expand yes
  }

  if { $bool_process } {
      if {$bool_text} {
	  text $right.contents -width 10 -wrap none\
		  -background $global_bg_color \
		  -selectbackground $global_bg_color \
		  -selectforeground blue4 \
		  -foreground blue4 \
		  -cursor $curseur\
		  -highlightbackground $global_menu_bg_color \
		  -xscrollcommand "$right.hscroll set" \
		  -yscrollcommand "scrollMultiple_y [list $list_frames] $w.$sub.vscroll"
      } else {
	  canvas $right.contents -width 50 \
		  -background $global_bg_color \
		  -xscrollcommand "$right.hscroll set" \
		  -yscrollcommand "scrollMultiple_y [list $list_frames] $w.$sub.vscroll"\
		  -cursor $curseur\
		  -highlightbackground $global_menu_bg_color
      }

      scrollbar $right.hscroll -command "$right.contents xview" \
	      -orient horizontal -width 10 -bg $global_menu_bg_color 

      if {$title != ""} {
	  label $right.title -text "Tasks" -width 20 \
		  -anchor center -bd 2 -relief raised \
		  -bg $global_menu_bg_color -bg $global_menu_bg_color
	  pack $right.title -side top -fill x
      }

      pack $right.hscroll -side bottom -fill x
      pack $right.contents -side bottom -fill both -expand yes

  }

  if {$type_vue == "TREE"} {

      global Arbre_Vue_Tree 
      global tree_path 
      global global_bg_color global_menu_bg_color

      Lire_Images_Vue_Tree

      set tree_path $center.contents
      tixTree $tree_path -browsecmd {BrowseCmd_Click_Souris_Vue_Tree} \
	      -command {BrowseCmd_Click_Souris_Vue_Tree}  \
	      -closecmd {Commande_Fermeture_Transition_Vue_Tree 1} \
	      -opencmd  {Commande_Ouverture_Transition_Vue_Tree 1} \
	      -ignoreinvoke true \
	      -background $global_menu_bg_color \
	      -highlightbackground $global_menu_bg_color 

      $tree_path subwidget vsb configure -width 0 -bg $global_menu_bg_color
      $tree_path subwidget hsb configure -width 0 -bg $global_menu_bg_color

      set Arbre_Vue_Tree [$tree_path subwidget hlist]

      global Select_Region_Mode
      set Select_Region_Mode 0
      bind $Arbre_Vue_Tree <Shift-ButtonPress-1> {Debut_Selection %x %y}
      bind $Arbre_Vue_Tree <Shift-Button1-Motion> {Bouger_Selection %x %y}
      bind $Arbre_Vue_Tree <Shift-ButtonRelease-1> {set Select_Region_Mode 0}
      bind $Arbre_Vue_Tree <ButtonPress-1> {set Select_Region_Mode 0}
      bind $Arbre_Vue_Tree <1> {set Select_Region_Mode 0}

      bind $Arbre_Vue_Tree <ButtonPress-3> {Debut_Selection %x %y}
      bind $Arbre_Vue_Tree <Button3-Motion> {Bouger_Selection %x %y}
      bind $Arbre_Vue_Tree <ButtonRelease-3> {set Select_Region_Mode 0}

      $Arbre_Vue_Tree configure  \
	      -separator "/" \
	      -selectmode browse  \
	      -xscrollcommand "$center.hscroll set" \
	      -yscrollcommand \
	      "scrollMultiple_y [list $list_frames] $w.$sub.vscroll" \
	      -background $global_bg_color \
	      -highlightbackground $global_menu_bg_color \
	      -highlightcolor $global_menu_bg_color \
	      -selectbackground $global_bg_color

	
      scrollbar $center.hscroll -orient horiz -command "Scroller_Horizontalement_Widget_Tree $center.contents" -width 10 -bg $global_menu_bg_color

  } else {
      if {$bool_text} {
	  text $center.contents -wrap none \
		  -background $global_bg_color \
		  -selectbackground $global_bg_color \
		  -selectforeground blue4 \
		  -foreground blue4 \
		  -cursor $curseur\
		  -highlightbackground $global_menu_bg_color \
		  -xscrollcommand "$center.hscroll set"\
		  -yscrollcommand "scrollMultiple_y [list $list_frames] $w.$sub.vscroll"

      } else {
	  canvas $center.contents -confine 0\
		  -background $global_bg_color \
		  -xscrollcommand "$center.hscroll set"\
		  -yscrollcommand "scrollMultiple_y [list $list_frames] $w.$sub.vscroll" \
		  -cursor $curseur -confine 1\
		  -highlightbackground $global_menu_bg_color
      }
      scrollbar $center.hscroll -orient horiz \
	      -command "$center.contents xview" \
	      -width 10 -bg $global_menu_bg_color
  }

  if {$title != ""} {
      label $center.title -text $title -anchor center -bd 2 \
	      -relief raised -bg $global_menu_bg_color
      pack $center.title -side top -fill x
  }
  pack $center.hscroll -side bottom -fill x 
  pack $center.contents -side bottom -fill both -expand yes

  if {$bool_fired} {
      if [info exists pane_fired] {
	  if {$bool_text} {
	      text $fired.contents -width 10 -wrap none \
		      -background $global_bg_color \
		      -selectbackground $global_bg_color \
		      -selectforeground blue4 \
		      -foreground blue4 \
		      -cursor $curseur\
		      -highlightbackground $global_menu_bg_color \
		      -xscrollcommand "$fired.hscroll set"\
		      -yscrollcommand "scrollMultiple_y [list $list_frames] $w.$sub.vscroll"

	  } else {
	      canvas $fired.contents -width 50 \
		      -background $global_bg_color \
		      -xscrollcommand "$fired.hscroll set" \
		      -yscrollcommand "scrollMultiple_y [list $list_frames] $w.$sub.vscroll "\
		      -cursor $curseur\
		      -highlightbackground $global_menu_bg_color
	  }

	  scrollbar $fired.hscroll -orient horiz \
		  -command "$fired.contents xview" \
		  -width 10 -bg $global_menu_bg_color

	  label $fired.title -text "Fired" -anchor center -bd 2 \
		  -relief raised -bg $global_menu_bg_color

	  pack $fired.title -side top -fill x
	  pack $fired.hscroll -side bottom -fill x 
	  pack $fired.contents -side bottom -fill both -expand yes
      }    
  }

  return [list $w.$sub $left_return $center_return \
	  $right_return $fired_return $fired_return]
} 

proc lib_gestion_menu_cree_menu {nom liste} {
    global global_menu_bg_color

    set nom_menu $nom 

    menu $nom_menu -tearoff 0 -bg $global_menu_bg_color

    set nb_entrees [llength $liste]

    for {set i 0} {$i < $nb_entrees} {incr i 1} {
	set entree_courante [lindex $liste $i]
	set cmd [lindex [lindex $entree_courante 0] 0]
	set arg [lindex [lindex $entree_courante 0] 1]
	$nom_menu add command -command  "$cmd $arg" \
		-label "[lindex $entree_courante 1]" \
		-state "[lindex $entree_courante 2]"
    }
    return $nom_menu
}

proc Ecrire_Information_Tache {num x y} {
    global global_nb_tache 
    global global_nom_tache

    if {[winfo exists .popup_menu_info_tache]} then {
	destroy .popup_menu_info_tache
    }
    lib_gestion_menu_cree_menu .popup_menu_info_tache "{{} {[lindex $global_nom_tache $num]} normal}"
    tk_popup .popup_menu_info_tache $x $y
}

proc Afficher_Entete_Taches_Vue_Msc {w nb} {
    global Msc_Task_Horizontal_Distance Ordonnees_X_Taches_Vues_Msc canvas_width 
    global global_info_temps
    global Font_Msc_Title_Tasks

    set Ordonnees_X_Taches_Vues_Msc {}

    global Afficher_Colonne_Taches
    if {$Afficher_Colonne_Taches == 0} then {
	set i [expr 2 * $Msc_Task_Horizontal_Distance]
    } else {
	set i [expr 2* $Msc_Task_Horizontal_Distance / 3]
    }

    for {set no 0} {$no < $nb} {incr no 1} {
	set tag_task "task_$no"
	$w create text $i 10 -text "Task $no" -anchor c \
		-tags {item_all $tag_task} -font $Font_Msc_Title_Tasks
	$w bind $tag_task <1> "Ecrire_Information_Tache $no %X %Y"
	lappend Ordonnees_X_Taches_Vues_Msc $i
	incr i $Msc_Task_Horizontal_Distance
    }
    set canvas_width [$w cget -width]
}

proc Initialiser_Vues {} {
    global w_hist w_trans
    global global_info_temps
    global global_info_process 
    global global_nb_tache
    global Fenetres_Affichage 
    global Fenetres_Transition 
    global fenetres 
    global Afficher_Colonne_Taches

    set bool_fired 1

    set Fenetres_Affichage 1

    set msc_trace ""
    if {$global_info_process} then {
	set msc_trace [Generer_Widgets_Vues MSC $w_hist(1) \
		msc $global_info_temps $Afficher_Colonne_Taches 0 \
		$bool_fired "Current path"]
	Afficher_Entete_Taches_Vue_Msc [lindex $msc_trace 2] $global_nb_tache
    }

    set texte_trace [Generer_Widgets_Vues TEXT $w_hist(2) \
	    trace $global_info_temps $Afficher_Colonne_Taches 1 \
	    $bool_fired "Current path"] 

    set tree_trace [Generer_Widgets_Vues TREE $w_hist(3) trace \
	    $global_info_temps $Afficher_Colonne_Taches 1 \
	    $bool_fired "Expanded tree"]

    set Fenetres_Transition 2

    set msc_trans ""
    if {$global_info_process} then {
	set msc_trans [Generer_Widgets_Vues MSC $w_trans(1) \
		msc $global_info_temps $Afficher_Colonne_Taches 0 \
		0 "Fireable transitions"]

	Afficher_Entete_Taches_Vue_Msc [lindex $msc_trans 2] $global_nb_tache
    }

    set texte_trans [Generer_Widgets_Vues TEXT $w_trans(2) \
	    transition $global_info_temps $Afficher_Colonne_Taches 1 \
	    0 "Fireable transitions"]

    set fenetres(1.1.1) [lindex $msc_trace 1]  
    set fenetres(1.1.2) [lindex $msc_trace 2]
    set fenetres(1.1.3) [lindex $msc_trace 3] 
    set fenetres(1.1.4) [lindex $msc_trace 4] 

    set fenetres(1.2.1) [lindex $texte_trace 1] 
    set fenetres(1.2.2) [lindex $texte_trace 2] 
    set fenetres(1.2.3) [lindex $texte_trace 3] 
    set fenetres(1.2.4) [lindex $texte_trace 4] 

    set fenetres(1.3.1) [lindex $tree_trace 1]
    set fenetres(1.3.2) [lindex $tree_trace 2]
    set fenetres(1.3.3) [lindex $tree_trace 3]
    set fenetres(1.3.4) [lindex $tree_trace 4] 

    set fenetres(2.1.1) [lindex $msc_trans 1]  
    set fenetres(2.1.2) [lindex $msc_trans 2] 
    set fenetres(2.1.3) [lindex $msc_trans 3] 

    set fenetres(2.2.1) [lindex $texte_trans 1] 
    set fenetres(2.2.2) [lindex $texte_trans 2] 
    set fenetres(2.2.3) [lindex $texte_trans 3] 

    global Couleur_Originale_Colonne_Msc
    global Couleur_Transition_Exploree
    set Couleur_Originale_Colonne_Msc $Couleur_Transition_Exploree
    Etablir_Binding_Any_Motion_Any_Leave_Vue_Msc Trace
    Etablir_Binding_Any_Motion_Any_Leave_Vue_Msc Trans

    if {$global_info_process} then {
	pack [lindex $msc_trace 0] -fill both -expand yes 
	pack [lindex $msc_trans 0] -fill both -expand yes 
    }

    pack [lindex $texte_trans 0] -fill both -expand yes
    pack [lindex $texte_trace 0] -fill both -expand yes

    pack [lindex $tree_trace 0] -fill both -expand yes
    pack $fenetres(1.3.2) -fill both -expand yes

}

proc Initialiser_Menus_Deroulants {} { 
    global global_info_temps
    global global_info_process
    global global_info_source 

    set popup_menu_source disabled
    if {$global_info_source} then {
	set popup_menu_source normal
    }

    lib_gestion_menu_cree_menu .popup_menu_main_texte \
	    "{{init_dynamic_backcode_trace_cmd 1} {Show source code} $popup_menu_source}"

    lib_gestion_menu_cree_menu .popup_menu_trans_texte \
	    "{{init_dynamic_backcode_trans_cmd} {Show source code} $popup_menu_source}"

}

proc protocol_signal_failure {error_code error_response} {
    global env

    puts stderr "\nerror on communication pipe"
    switch -exact -- $error_code {
	01 {
	    puts stderr "(pipe cannot be opened when running $env(OCIS_START_COMMAND))"
	}
	02 {
	    puts stderr "(pipe cannot be opened when running $env(OCIS_RESTART_COMMAND))"
	}
	03 {
	    puts stderr "(pipe has been closed)"
	}
	04 {
	    puts stderr "(pipe cannot be opened when checking the environment variable OCIS_START_COMMAND)"
	}
	05 {
	    puts stderr "(pipe cannot be opened when initializing the simulation kernel)"
	}
	06 {
	    puts stderr "(invalid command $error_response from simulation kernel)"
	} 
	07 {
	    puts stderr "(simulation kernel not responding: $error_response)"
	} 
    }
    exit 1
}

proc Envoi_Message {cmd} {
    global channel_id
    global DEBUG_MODE_PROTOCOL

    if {$DEBUG_MODE_PROTOCOL == 1} {
	puts stdout "\nTix-->C: $cmd"
    }

    catch "puts $channel_id \"$cmd\"" erreur
    if {$erreur != ""} then {
	protocol_signal_failure 03 $erreur
    }
    catch {flush $channel_id}
}

proc Lire_Reponse {} {

    global channel_id
    global changement_transition
    global Nombre_Descendants_Transition_Courante

    global global_current_path
    global global_heure_courante 
    global global_next_event_time
    global Chemin_Backward
    global Chemin_Forward
    global global_info_temps 
    global global_info_process 
    global global_info_source 
    global global_info_rebouclage 
    global global_nb_tache 
    global global_nom_tache 

    global Fenetres_Affichage 
    global Fenetres_Transition

    global Num_Info_Variable_Code_Source
    global Info_Variable_Code_Source
    global Info_Tache_Fichier_Code_Source
    global Info_Tache_Ligne_Code_Source

    global nb_erreur 
    global systeme_erreur 
    global Numero_Transition_Courante 
    global Arbre_Vue_Tree
    global tree_path  
    global Mode_Affichage_Transition_Wait

    global Transition_Courante_Vue_Tree

    global nbr_fils_etat_initial
    global nbr_fils_etat_courant

    global exhibitor_actif

    global current_list_procs
    global Label_Transition_Courante

    global Scenario_Courant_Deja_Sauvegarde

    global Heure_Etat_Initial

    global Noms_Taches 

    global Ouverture_Fichier_Reussie

    global DEBUG_MODE_PROTOCOL
    global DEBUG_MODE_PROTOCOL_EXTENSIVE

    global Afficher_Colonne_Taches

    global Numero_Ligne_Transition_Courante_Vue_Tree
    global Numero_Ligne_Transition_Parent_Vue_Tree

    global Numero_Ligne_Transition_Selectionnee_Vue_Tree

    global Nombre_Descendants_Transition_Courante

    global Nombre_Descendants_Ouverts_Transition_Courante

    global Couleur_Highlight

    global Error_Detected
    global Error_Caesar_Adt_Detected

    set ligne_motcle [gets $channel_id]

    if {$DEBUG_MODE_PROTOCOL == 1} {
	puts stdout "C-->Tix: $ligne_motcle."
    }

    switch -exact -- $ligne_motcle {

	END_SHELL {
	}

	TRANSITIONS {
	    Lire_Prochaines_Transitions
	}

	TOP_PATH {
	    while {1} {
		set ligne [gets $channel_id]
		if {$DEBUG_MODE_PROTOCOL_EXTENSIVE == 1} {
		    puts stdout "   $ligne"
		}

		if {$ligne == "END_TOP_PATH"} then {
		    break
		}
	    }
	}

	DOWN_TREE {
	    while {1} {
		set ligne [gets $channel_id]
		if {$DEBUG_MODE_PROTOCOL_EXTENSIVE == 1} {
		    puts stdout "   $ligne"
		}

		if {$ligne == "END_DOWN_TREE"} then {
		    break
		}
	    }
	}

	CUT_DOWN_TREE {
	    while {1} {
		set ligne [gets $channel_id]
		if {$DEBUG_MODE_PROTOCOL_EXTENSIVE == 1} {
		    puts stdout "   $ligne"
		}

		if {$ligne == "END_CUT_DOWN_TREE"} then {
		    break
		}
	    }
	}

	CUT_CURRENT_TRANSITION {
	    while {1} {
		set ligne [gets $channel_id]
		if {$DEBUG_MODE_PROTOCOL_EXTENSIVE == 1} {
		    puts stdout "   $ligne"
		}

		if {$ligne == "END_CUT_CURRENT_TRANSITION"} then {
		    break
		}
	    }
	}

	SAVE_SEQUENCE_TREE {
	    while {1} {
		set ligne [gets $channel_id]
		if {$DEBUG_MODE_PROTOCOL_EXTENSIVE == 1} {
		    puts stdout "   $ligne"
		}

		if {$ligne == "END_SAVE_SEQUENCE_TREE"} then {
		    break
		}
	    }
	}

	SCENARIO_STATEMENT {

	    while {1} {
		set ligne [gets $channel_id]
		if {$DEBUG_MODE_PROTOCOL_EXTENSIVE == 1} {
		    puts stdout "   SAVED_SCENARIO $ligne"
		}

		if {$ligne == "END_SCENARIO_STATEMENT"} then {
		    break
		}
		if {$ligne == "SAVED"} {
		    set Scenario_Courant_Deja_Sauvegarde 1
		} else {
		    set Scenario_Courant_Deja_Sauvegarde 0
		}
	    }
	}

	COMMAND_FINISHED {

	    while {1} {
		set ligne [gets $channel_id]
		if {$DEBUG_MODE_PROTOCOL_EXTENSIVE == 1} {
		    puts stdout "   COMMAND_FINISHED $ligne"
		}

		if {$ligne == "END_COMMAND_FINISHED"} then {
		    break
		}
	    }
	}

	LINE_NUMBER {

	    while {1} {
		set ligne [gets $channel_id]
		if {$DEBUG_MODE_PROTOCOL_EXTENSIVE == 1} {
		    puts stdout "   LINE_NUMBER $ligne"
		}

		if {$ligne == "END_LINE_NUMBER"} then {
		    break
		}
		set Numero_Ligne_Transition_Courante_Vue_Tree [lindex $ligne 0]
	    }
	}

	LINE_NUMBER_TRANSITION {

	    while {1} {
		set ligne [gets $channel_id]
		if {$DEBUG_MODE_PROTOCOL_EXTENSIVE == 1} {
		    puts stdout "   LINE_NUMBER_TRANSITION $ligne"
		}

		if {$ligne == "END_LINE_NUMBER_TRANSITION"} then {
		    break
		}
		set Numero_Ligne_Transition_Selectionnee_Vue_Tree [lindex $ligne 0]
	    }
	}

	NUMBER_OF_CHILDREN {

	    while {1} {
		set ligne [gets $channel_id]
		if {$DEBUG_MODE_PROTOCOL_EXTENSIVE == 1} {
		    puts stdout "   NUMBER_OF_CHILDREN $ligne"
		}

		if {$ligne == "END_NUMBER_OF_CHILDREN"} then {
		    break
		}
		set Nombre_Descendants_Transition_Courante [lindex $ligne 0]
	    }
	}

	NUMBER_OF_OPEN_CHILDREN {

	    while {1} {
		set ligne [gets $channel_id]
		if {$DEBUG_MODE_PROTOCOL_EXTENSIVE == 1} {
		    puts stdout "   NUMBER_OF_OPEN_CHILDREN $ligne"
		}

		if {$ligne == "END_NUMBER_OF_OPEN_CHILDREN"} then {
		    break
		}
		set Nombre_Descendants_Ouverts_Transition_Courante [lindex $ligne 0]
	    }
	}

	EXHIBITOR {
	    set exhibitor_actif 1

	    Lire_Reponse

	    while {1} {

		if {$Error_Caesar_Adt_Detected == 1} {
		    break
		}

		set ligne [gets $channel_id]
		if {$DEBUG_MODE_PROTOCOL_EXTENSIVE == 1} {
		    puts stdout "   EXHIBITOR $ligne"
		}

		if {$ligne == "END_EXHIBITOR"} then {
		    break
		}
	    }
	    set exhibitor_actif 0

	    if {$Error_Caesar_Adt_Detected == 1} {
		set Error_Caesar_Adt_Detected 0
		Lire_Reponse
	    }		
	}

	BCG_READABLE {
            set Ouverture_Fichier_Reussie 1
	}

	ERROR {
	    set nb_erreur 0

	    while {1} {
		set ligne [gets $channel_id]
		if {$DEBUG_MODE_PROTOCOL_EXTENSIVE == 1} {
		    puts stdout "   ERROR $ligne"
		}

		if {$ligne == "END_ERROR"} then {
		    break
		}

		set systeme_erreur($nb_erreur) $ligne
		incr nb_erreur 1 
	    }

	    if {$nb_erreur > 0} then {
		set i 0
		set message_erreur ""
		while {$i < $nb_erreur} {
		    if {$i == 0} {
			set message_erreur "$systeme_erreur($i)"
		    } else {
			set message_erreur "$message_erreur\n $systeme_erreur($i)"			
		    }
		    incr i 1
		}
		Afficher_Message_Erreur $message_erreur {}
	    }

	    set Error_Detected 1
	    set Ouverture_Fichier_Reussie 0	    
	    fileevent $channel_id readable "Lire_Reponse"
	}

	GLOBAL_INFO { 
	    while {1} {
		set ligne [gets $channel_id]
		if {$DEBUG_MODE_PROTOCOL_EXTENSIVE == 1} {
		    puts stdout "   GLOBAL_INFO $ligne"
		}

		if {$ligne == "END_GLOBAL_INFO"} then {
		    break
		}

		set global_info_temps [lindex $ligne 0]
		set global_info_process [lindex $ligne 1]
		set global_info_source [lindex $ligne 2]
		set global_nb_tache [lindex $ligne 3]
		set global_nom_tache [lindex $ligne 4]

		if {$global_nb_tache > 1} {
		    set Afficher_Colonne_Taches 1
		} else {
		    set Afficher_Colonne_Taches 0
		}
	    }
	}

	LOAD {
	    

	    Effacer_Transition $Fenetres_Transition 1

	    while {1} {
		set ligne [gets $channel_id]
		if {$DEBUG_MODE_PROTOCOL_EXTENSIVE == 1} {
		    puts stdout "   LOAD $ligne"
		}
		if {$ligne == "END_LOAD"} then {
		    break
		}
		set Numero_Transition_Courante $ligne
	    }
	    

	    Lire_Reponse 
	    

	    Lire_Reponse 

	}
	    
	BACKCODE {
	    set i 0
	    while {1} {
		set ligne [gets $channel_id]
		if {$DEBUG_MODE_PROTOCOL_EXTENSIVE == 1} {
		    puts stdout "   BACKCODE $ligne"
		}

		if {$ligne == "END_BACKCODE"} then {
		    break
		}
		incr i 1

		Ajouter_Mise_A_Jour_Page_Tache_Fenetre_Code_Source .fenetre_code_source.nb \
			[lindex $ligne 0] [lindex $ligne 2] [lindex $ligne 1]
	    }
	}

	CLOCK {
	    set i 0
	    while {1} {
		set ligne [gets $channel_id]
		if {$DEBUG_MODE_PROTOCOL_EXTENSIVE == 1} {
		    puts stdout "   CLOCK $ligne"
		}

		if {$ligne == "END_CLOCK"} then {
		    break
		}

		if {$i == 0} then {
		    set global_heure_courante $ligne 
		} elseif {$i == 1} then {
		    set global_next_event_time $ligne
		}
		incr i 1
	    }
	}

	INFOS {
	    set Num_Info_Variable_Code_Source 0
	    set i 0
	    while {1} {
		set ligne [gets $channel_id]
		if {$DEBUG_MODE_PROTOCOL_EXTENSIVE == 1} {
		    puts stdout "   INFOS $ligne"
		}

		if {$ligne == "END_INFOS"} then {
		    break
		}
		

		if {$i == 0} {
		    set Label_Transition_Courante [lindex $ligne 0]
		} else {

		    set Info_Variable_Code_Source($Num_Info_Variable_Code_Source) "[lindex $ligne 0] [lindex $ligne 1] [lindex $ligne 2]"
		    set Info_Tache_Fichier_Code_Source($Num_Info_Variable_Code_Source) [lindex $ligne 3]
		    set Info_Tache_Ligne_Code_Source($Num_Info_Variable_Code_Source) [lindex $ligne 4]
		    incr Num_Info_Variable_Code_Source 1 
		}
		incr i 1
	    }
	}

	PATH { 

	    global Mode_Lecture_Fichier
	    if {$Mode_Lecture_Fichier == 1 || $exhibitor_actif == 1} {
		Bcg_Load_Refresh_Init
	    }

	    set Error_Caesar_Adt_Detected 0

	    while {1} {

		set ligne_path [gets $channel_id]

		if {[string range [lindex $ligne_path 0] 0 0] == "\#"} {
		    set Error_Caesar_Adt_Detected 1
		    puts stdout "$ligne_path"
		    Lire_Reponse
		    break
		}

		if {$DEBUG_MODE_PROTOCOL_EXTENSIVE == 1} {
		    puts stdout "   PATH: $ligne_path"
		}

		if {$ligne_path == "END_PATH"} then {
		    break
		}

		set Transition_Courante_Vue_Tree $ligne_path

		set ligne_info_feuille [gets $channel_id]
		if {$DEBUG_MODE_PROTOCOL_EXTENSIVE == 1} {
		    puts stdout "   PATH: $ligne_info_feuille"
		}

		set Label_Transition_Courante [lindex $ligne_info_feuille 2]

		set current_list_procs [lindex $ligne_info_feuille 4]

		set global_info_rebouclage [lindex $ligne_info_feuille 6]

		if {$exhibitor_actif == 0} {
		    Eliminer_Highlight_Colonnes_Time_Tasks_Fired_Vue_Msc $Fenetres_Affichage $Numero_Ligne_Transition_Courante_Vue_Tree 	
		}

		set Numero_Ligne_Transition_Parent_Vue_Tree \
			 [lindex $ligne_info_feuille 7]

		set Numero_Ligne_Transition_Courante_Vue_Tree \
			 [lindex $ligne_info_feuille 8]

		set Nombre_Descendants_Ouverts_Transition_Courante \
			[lindex $ligne_info_feuille 9]

		set ligne_list_status [gets $channel_id]
		set changement_transition $ligne_list_status
		if {$DEBUG_MODE_PROTOCOL_EXTENSIVE == 1} {
		    puts stdout "   PATH: $ligne_list_status"
		}

		set ligne_nbr_fils_generes [gets $channel_id]
		if {$DEBUG_MODE_PROTOCOL_EXTENSIVE == 1} {
		    puts stdout "   PATH: .$ligne_nbr_fils_generes."
		}
		set nbr_fils_etat_courant [lindex $ligne_nbr_fils_generes 0]

		if {[lindex $ligne_info_feuille 1] == "T" && \
			[lindex [lindex $ligne_info_feuille 2] 1] == 1.0} {
		    Afficher_Message_Erreur "Value of time may be rounded-off to 1.0" {}
		}

		$Arbre_Vue_Tree selection clear

		if { ![$Arbre_Vue_Tree info exists $Transition_Courante_Vue_Tree]} {
		    if {$Transition_Courante_Vue_Tree == "0"} {
			global Label_Etat_Initial
			set ligne_info_feuille "{} {T} {$Label_Etat_Initial} Explored \
				{$Noms_Taches} \
				{$Heure_Etat_Initial} {0 0 0 0 0}"
		    }
		    Ajouter_Transition_Vue_Tree $Transition_Courante_Vue_Tree \
			    $ligne_info_feuille \
			    $ligne_list_status $ligne_nbr_fils_generes
		}

		if {$exhibitor_actif == 0} {

		    $Arbre_Vue_Tree anchor set $Transition_Courante_Vue_Tree

		    Mettre_Highlight_Colonnes_Time_Tasks_Fired_Vue_Msc $Fenetres_Affichage $Numero_Ligne_Transition_Courante_Vue_Tree $Couleur_Highlight
		}

		$Arbre_Vue_Tree see $Transition_Courante_Vue_Tree

		global Pref_Main_Win_Type
		if {$Pref_Main_Win_Type != 3 && \
			[lindex $ligne_info_feuille 1] == "T" && \
			$Mode_Affichage_Transition_Wait == 1} {
		    Afficher_Transition_Wait $ligne_list_status \
			    [lindex $ligne_info_feuille 0] \
			    [lindex $ligne_info_feuille 2] \
			    [lindex $ligne_info_feuille 3] \
			    [lindex $ligne_info_feuille 4] \
			    [lindex $ligne_info_feuille 5] \
			    [lindex $ligne_info_feuille 6] 
		}

		if {$exhibitor_actif == 1 || $Mode_Lecture_Fichier == 1} {
		    Bcg_Load_Refresh_Update
		}

	    }

	}

	STATUS {
	    while {1} {
		set ligne [gets $channel_id]
		if {$DEBUG_MODE_PROTOCOL_EXTENSIVE == 1} {
		    puts stdout "   STATUS $ligne"
		}

		if {$ligne == "END_STATUS"} then {
		    break
		}

		set changement_transition [lindex $ligne 0]
	    }
	    
	}

	WAIT {

	    while {1} {
		set ligne [gets $channel_id]
		if {$DEBUG_MODE_PROTOCOL_EXTENSIVE == 1} {
		    puts stdout "   WAIT $ligne"
		}

		if {$ligne == "END_WAIT"} then {
		    break
		}
	    }

	    Effacer_Transition $Fenetres_Transition 1
	    set Mode_Affichage_Transition_Wait 1
	    incr Numero_Transition_Courante 1

	    Lire_Reponse 
	    set Mode_Affichage_Transition_Wait 0

	    Lire_Reponse

	    lappend Chemin_Backward [expr $Nombre_Descendants_Transition_Courante + 1] 

	    set Chemin_Forward ""  

	    if {$global_info_temps} then {

		Envoi_Message "clock"

		Lire_Reponse 

		set time $global_heure_courante
	    }

	    Etablir_Bindings_Transition_Vue_Texte $Fenetres_Affichage \
		    "affichage_selection_back"\
		    "Afficher_Menu_Texte_Transition_Bouton_Droit .popup_menu_main_texte {$Fenetres_Affichage}" $Numero_Transition_Courante
	    
	    Etablir_Bindings_Transition_Vue_Msc $Fenetres_Affichage "Effectuer_Retour_Arriere" "Afficher_Menu_Msc_Transition_Bouton_Droit .popup_menu_main_texte {$Fenetres_Affichage}" $Numero_Transition_Courante 

	    Realiser_Focus_Ligne_Texte TEXT $Fenetres_Affichage $Numero_Transition_Courante
	}

	CURRENT_PATH {
	    while {1} {
		set ligne [gets $channel_id]
		if {$DEBUG_MODE_PROTOCOL_EXTENSIVE == 1} {
		    puts stdout "   CURRENT_PATH $ligne"
		}

		if {$ligne == "END_CURRENT_PATH"} then {
		    break
		}

		set global_current_path $ligne
		

		set ligne_nbr_fils_generes [gets $channel_id]
		if {$DEBUG_MODE_PROTOCOL_EXTENSIVE == 1} {
		    puts stdout "   CURRENT_PATH $ligne_nbr_fils_generes"
		}
		set nbr_fils_etat_initial [lindex $ligne_nbr_fils_generes 0]
	    }
	}

	default {

	    if {$ligne_motcle != ""} {
		puts stderr "$ligne_motcle"
	    }
	    if {[eof $channel_id]} then {
		protocol_signal_failure 06 "$ligne_motcle"
	    }
	    Lire_Reponse
	}
    }
}	

proc Reset_Scenario {Affichage_Warning} {
    global Numero_Transition_Courante 
    global Fenetres_Affichage 
    global Fenetres_Transition 
    global Chemin_Forward 
    global Chemin_Backward
    global Arbre_Vue_Tree 
    global wait_tree_image
    global separator_space 
    global Transition_Courante_Vue_Tree
    global Flag_Execution_Commande
    global Noms_Taches
    global Heure_Etat_Initial

    if {$Affichage_Warning == 1} {
	Afficher_Warning_General "SAVE_SCENARIO" "Save the current simulation scenario\nbefore reset?"
    } else {

	set Flag_Execution_Commande 1
    }

    if {$Flag_Execution_Commande == 2} {
	return 1
    }

    if {$Flag_Execution_Commande == 0} {
       Sauvegarde_Et_Attend
    }

    global Liste_Transitions_Selectionnees
    global Liste_Transitions_Cachees
    set Liste_Transitions_Selectionnees ""
    set Liste_Transitions_Cachees ""

    Effacer_Transition $Fenetres_Transition 1

    Effacer_Transition $Fenetres_Affichage 1

    $Arbre_Vue_Tree delete all

    Effacer_Transition_Colonne_Time $Fenetres_Affichage.3 1
    Effacer_Transition_Colonne_Tasks $Fenetres_Affichage.3 1
    Effacer_Transition_Colonne_Fired $Fenetres_Affichage.3 1

    set Numero_Transition_Courante 1

    set Chemin_Forward ""
    set Chemin_Backward ""

    Envoi_Message "reset"

    Lire_Reponse 

    Envoi_Message "get_current_path"

    Lire_Reponse 

    Affichage_Etat_Initial

    set Transition_Courante_Vue_Tree 0

    Recuperer_Information_Backcode Historique

}

proc Effectuer_Retour_Arriere {ligne} {
    global Numero_Transition_Courante Fenetres_Affichage Fenetres_Transition
    global Chemin_Forward Chemin_Backward
    global Compile_Mode

    if {$Compile_Mode == 1} {
	return
    }

    set back [expr $Numero_Transition_Courante - $ligne]

    if {$back <= 0} then {

	return 0
    }

    set Chemin_Forward [concat [lrange $Chemin_Backward [expr $ligne -1]\
	    [llength $Chemin_Backward]] $Chemin_Forward]

    set Chemin_Backward [lrange $Chemin_Backward 0 [expr $ligne - 2]]

    Envoi_Message "back $back"

    Effacer_Transition $Fenetres_Transition 1
    Effacer_Transition $Fenetres_Affichage [expr $ligne + 1]

    Afficher_Transition_Vue_Texte  [expr $ligne +1] "" "" "" "" 0 $Fenetres_Affichage 

    incr Numero_Transition_Courante -$back 

    Lire_Reponse  

    Lire_Reponse

    Recuperer_Information_Backcode Historique

}

proc Effectuer_1_Pas_Arriere {} {
    global Numero_Transition_Courante 

    set back  [expr $Numero_Transition_Courante - 1]

    if {$Numero_Transition_Courante > 1} then {
	Effectuer_Retour_Arriere $back 
    }
}

proc Effectuer_1_Pas_Avant {} {
    global Chemin_Forward 

    if {$Chemin_Forward != ""} then {

	set trans [lindex $Chemin_Forward 0]
	set Chemin_Forward [lrange $Chemin_Forward 1 [llength $Chemin_Forward]]

	set temp $Chemin_Forward
	Afficher_Transition_Selectionnee $trans
	set Chemin_Forward $temp
    }
}

proc Montrer_Transition_Courante {} {
    global Fenetres_Affichage
    global Numero_Transition_Courante
    global Transition_Courante_Vue_Tree
    global Arbre_Vue_Tree
    global Pref_Main_Win_Type

    if {$Pref_Main_Win_Type == 1} {
	Realiser_Focus_Ligne_Courante_Vue_Msc $Fenetres_Affichage
    } elseif {$Pref_Main_Win_Type == 2} {
	Realiser_Focus_Ligne_Texte TEXT $Fenetres_Affichage $Numero_Transition_Courante
    } elseif {$Pref_Main_Win_Type == 3} {
	$Arbre_Vue_Tree see $Transition_Courante_Vue_Tree
	Realiser_Focus_Ligne_Texte TREE $Fenetres_Affichage $Numero_Transition_Courante
    }

}

proc Montrer_Transition_Initiale {} {
    global Fenetres_Affichage
    global Numero_Transition_Courante
    global Transition_Courante_Vue_Tree
    global Arbre_Vue_Tree
    global Pref_Main_Win_Type

    if {$Pref_Main_Win_Type == 1} {
	Realiser_Focus_Premiere_Ligne_Vue_Msc $Fenetres_Affichage
    } elseif {$Pref_Main_Win_Type == 2} {
	Realiser_Focus_Ligne_Texte TEXT $Fenetres_Affichage 1
    } elseif {$Pref_Main_Win_Type == 3} {
	$Arbre_Vue_Tree see 0
	Realiser_Focus_Ligne_Texte TREE $Fenetres_Affichage 1
    }

}

proc Initialiser_Moteur_Simuleur_C {} {
    global env
    global channel_id 
    global Loopback_Option
    global global_info_temps global_info_process global_info_source

    global Numero_Transition_Courante
    global Compile_Mode
    global exhibitor_actif
    global Chemin_Forward 
    global Chemin_Backward 
    global Scenario_Courant_Deja_Sauvegarde
    global Initial_State_Changement_Transition 
    global changement_transition
    global Mode_Affichage_Transition_Wait
    global Numero_Ligne_Transition_Courante_Vue_Tree
    global Nombre_Descendants_Transition_Courante
    global Nombre_Descendants_Ouverts_Transition_Courante
    global Liste_Transitions_Selectionnees
    global Liste_Transitions_Cachees
    global DEBUG_MODE_PROTOCOL

    if [expr ! [info exists env(OCIS_START_COMMAND)]] then {

	puts stderr "failed (variable \$OCIS_START_COMMAND is not defined in the environment)"
	protocol_signal_failure 04 ""
    }

    if {$DEBUG_MODE_PROTOCOL == 1} {
	puts stdout "starting command : $env(OCIS_START_COMMAND)"
    }

    if [catch {open "|$env(OCIS_START_COMMAND)" "r+"} channel_id] then {

	puts stderr "failed (cannot start)"
	protocol_signal_failure 05 ""
    }
    if {$DEBUG_MODE_PROTOCOL == 1} {
	puts stdout "communication pipe is: $channel_id"
    }

    Envoi_Message "set_loopback $Loopback_Option"

    Envoi_Message "global_info"

    Lire_Reponse

    if {[info exists global_info_temps] == 0 || \
        [info exists global_info_process] == 0 || \
	[info exists global_info_source] == 0} then {
	protocol_signal_failure 07 "unable to obtain global info"
    }

    Envoi_Message "status"
    Lire_Reponse 
    set Initial_State_Changement_Transition $changement_transition

    if {$global_info_temps} then {
	Envoi_Message "clock"
	Lire_Reponse 
    }

    set Numero_Transition_Courante 1

    set Chemin_Backward ""
    set Chemin_Forward ""

    set Liste_Transitions_Selectionnees ""

    set Liste_Transitions_Cachees ""

    set Scenario_Courant_Deja_Sauvegarde 0

    set Compile_Mode 0
    set exhibitor_actif 0
    set Mode_Affichage_Transition_Wait 0

    set Numero_Ligne_Transition_Courante_Vue_Tree 1
    set Nombre_Descendants_Transition_Courante 0
    set Nombre_Descendants_Ouverts_Transition_Courante 0

    global Mode_Lecture_Fichier
    set Mode_Lecture_Fichier 0

}

proc Initialiser_Variables_Environnement {} {
    global env
    global Nom_Scenario_Courant 
    global imprimante 
    global imprimante_cmd
    global ocis_temporary_postscript 
    global ocis_other_temporary_postscript
    global ocis_temporary_bcg_file
    global ocis_temporary_o_file
    global ocis_temporary_exhibitor_output_log 
    global ocis_temporary_exhibitor_output_seq
    global ocis_all_temporary_files

    global ocis_local_startup_file
    global ocis_global_startup_file

    global Fichier_Open_Caesar
    global Prefix_Scenario_Par_Defaut

    set imprimante ""
    if {[info exists env(LP_DEST)]} then {
	set imprimante "$env(LP_DEST)"
    }

    set Fichier_Open_Caesar ""

    set Prefix_Scenario_Par_Defaut "untitled"
    set Nom_Scenario_Courant "$Prefix_Scenario_Par_Defaut.bcg"

    set imprimante_cmd "$env(CADP)/src/com/cadp_print"

    set ocis_temporary_postscript [Join $env(CADP_TMP) ocis_[pid].ps]
    set ocis_other_temporary_postscript [Join $env(CADP_TMP) ocis_[pid]_other.ps]
    set ocis_temporary_bcg_file [Join $env(CADP_TMP) ocis_[pid].bcg]
    set ocis_temporary_o_file [Join $env(CADP_TMP) ocis_[pid]\@1.o]
    set ocis_temporary_exhibitor_output_log [Join $env(CADP_TMP) ocis_[pid]_exhibitor.log]
    set ocis_temporary_exhibitor_output_seq [Join $env(CADP_TMP) ocis_[pid]_exhibitor.seq]
    set ocis_all_temporary_files [Join $env(CADP_TMP) ocis*]

    set ocis_local_startup_file "./.ocisrc"
    set ocis_global_startup_file [file join $env(HOME) .config cadp ocisrc]

    if [file exists [file join $env(HOME) .ocisrc]] {

       set upgrade_command "$env(CADP)/src/com/cadp_setup -upgrade"
       catch {eval exec sh -c {$upgrade_command}} resultat
    }
}

global bold
global normal
set bold "-background lightsalmon -foreground black -relief sunken"
set normal "-background {} -relief flat"

set Ocis_Authors "M. Cherif, H. Garavel, B. Hondelatte, and P.-A. Kessler"

Initialiser_Variables_Environnement

Read_Ocis_Preferences

set Screen_Center_X_Position [expr $Screen_X_Position + $Screen_Width /2]
set Screen_Center_Y_Position [expr $Screen_Y_Position + $Screen_Height /2]

wm withdraw .
set main .main
toplevel $main
wm protocol $main WM_DELETE_WINDOW { Quitter_Proprement_Ocis }

if {[info exists env(OPEN_CAESAR_SOURCE)]} {
   set Source_File " \"$env(OPEN_CAESAR_SOURCE)\""
} else {
   set Source_File ""
}

set Titre_Fenetres "Open/Caesar Interactive Simulator$Source_File"

wm title $main "$Titre_Fenetres ($Prefix_Scenario_Par_Defaut.bcg)"
wm geometry $main ${Screen_Width}x${Screen_Height}+${Screen_X_Position}+${Screen_Y_Position}
wm minsize $main $Screen_MinWidth $Screen_MinHeight

set Couleur_Transition_Exploree blue2
set Couleur_Transition_Completement_Exploree red
set Couleur_Transition_Feuille green4
set Couleur_Transition_Temporelle orange2
set Couleur_Transition_Sink white
set Couleur_Background_Transition_Sink black
set Couleur_Transition_Selectionnee yellow2
set Couleur_Background_Transition_Selection blue4
set Couleur_Highlight pink2

set Label_Etat_Initial "START"

if [info exists env(DEBUG_OCIS)] {
    set DEBUG_MODE_PROTOCOL 1
} else {
    set DEBUG_MODE_PROTOCOL 0
}

if [info exists env(DEBUG_OCIS_EXTENSIVE)] {
    set DEBUG_MODE_PROTOCOL 1
    set DEBUG_MODE_PROTOCOL_EXTENSIVE 1
} else {
    set DEBUG_MODE_PROTOCOL_EXTENSIVE 0
}

if [info exists env(DEBUG_OCIS_RECOMPILE)] {
    set DEBUG_MODE_PROTOCOL 1
    set DEBUG_MODE_RECOMPILE 1
} else {
    set DEBUG_MODE_RECOMPILE 0
}

set Bcg_Load_Counter_Limit 32
set Bcg_Load_Counter_Step 128

Initialiser_Moteur_Simuleur_C

Creer_Fenetre_Principale $main

Initialiser_Vues

Initialiser_Menus_Deroulants 

Initialiser_Boites_Selection

Initialiser_Bindings_Menu_Help

Envoi_Message "get_current_path"

Lire_Reponse 

set Noms_Taches $global_nom_tache
set Heure_Etat_Initial $global_heure_courante

Envoi_Message "transitions"

Lire_Reponse 

Affichage_Etat_Initial

set current_list_procs "" 
if {$Viewing_Source_Code == 1} {
    menu_dynamic_backcode trace 0
}

$w_pane_top.note raise $Pref_Main_Win_Type
$w_pane_bottom.note raise $Pref_Trans_Win_Type

