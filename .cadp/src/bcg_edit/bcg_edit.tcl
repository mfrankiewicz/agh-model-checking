##############################################################################
#                                B C G
#-----------------------------------------------------------------------------
#   INRIA - Unite de Recherche Rhone-Alpes
#   655, avenue de l'Europe
#   38330 Montbonnot Saint Martin
#   FRANCE
#-----------------------------------------------------------------------------
#   Module             :       entete.tcl
#   Auteur             :       Louis-Pascal Tock, Hubert Garavel, Aldo Mazzilli
#   Version            :       1.22
#   Date               :       2018/10/09 16:48:57
##############################################################################

 
set CADP			$env(CADP)
set BCG_EDIT_SRC		$env(BCG_EDIT_SRC)
set BCG_EDIT_TMP_FILE		$env(BCG_EDIT_TMP_FILE)
set BCG_EDIT_TMP_VIEW		$env(BCG_EDIT_TMP_VIEW)
set BCG_EDIT_TMP_PRINT		$env(BCG_EDIT_TMP_PRINT)
set num_spline_steps		$env(BCG_EDIT_SPLINE_STEPS)
set printer			$env(PRINTER)
set PostScript_viewer		$env(CADP_PS_VIEWER)

event add <<MIDDLE_BUTTON>> <ButtonPress-2>
event add <<MIDDLE_BUTTON>> <Shift-ButtonPress-3>
set dialogue_numero -1

proc Boite_Dialogue {racine titre texte args} {

  global borderwidth_size

  toplevel $racine
  wm title $racine $titre

  frame $racine.frame_h \
        -borderwidth $borderwidth_size \
        -relief raised 
  frame $racine.frame_b \
        -borderwidth $borderwidth_size \
        -relief raised 

  label $racine.texte \
        -font -Adobe-Times-Medium-R-Normal--*-140-*-*-*-*-*-* \
        -justify left \
        -text $texte \
        -wraplength 10c

  set i 0
  foreach bouton $args \
    {
    button $racine.button$i \
        -command "destroy $racine;set dialogue_numero $i" \
        -text $bouton 
    pack $racine.button$i \
        -expand 1 \
        -fill x \
        -side left \
        -in $racine.frame_b
    incr i
    }  

  pack $racine.texte \
        -expand 1 \
        -fill both \
        -in $racine.frame_h 
  pack $racine.frame_h \
        -fill both \
        -expand 1 \
        -ipadx 0.4c \
        -ipady 0.3c \
        -side top
  pack $racine.frame_b \
        -fill both \
        -side bottom

  grab $racine
  focus $racine
  tkwait window $racine
  }
proc Run_Return_For_Files {} {

    global selecteur_nom_fichier

    set selecteur_nom_fichier [.selecteur.entree get] 
    if {![regexp {(\?|\*|~)} $selecteur_nom_fichier] && $selecteur_nom_fichier != ""} {
	destroy .selecteur
	return
    }
    set selecteur_nom_fichier {}
}

proc Run_Return_For_Directories {} {

    if {![catch {cd  [.selecteur.entree_rep get]}]} {Selecteur_ls}
    .selecteur.entree_rep delete 0 end
    .selecteur.entree_rep insert 0 [pwd]
    return
}

proc Selecteur_Fichier {{action} {titre {File selector}} {filtre {*}}} {

  global selecteur_filtre selecteur_nom_fichier selecteur_pwd
  global borderwidth_size

  set selecteur_filtre $filtre
  set selecteur_nom_fichier {}
  set selecteur_pwd [pwd]
  toplevel .selecteur  \
        -borderwidth $borderwidth_size \
        -relief raised
  wm title .selecteur $titre

  frame .selecteur.frame_entree \
        -borderwidth $borderwidth_size
  frame .selecteur.frame_list \
        -borderwidth $borderwidth_size
  frame .selecteur.frame_bouton \
        -borderwidth $borderwidth_size

  button .selecteur.ok \
        -command {
          set selecteur_tmp [.selecteur.list curselection]
          if {$selecteur_tmp!=""} \
            { 

            set selecteur_nom_fichier [.selecteur.list get $selecteur_tmp]
            if {[file isfile $selecteur_nom_fichier]} \
              {
              destroy .selecteur
              return
              }
            } \
          else \
            {

            set selecteur_nom_fichier [.selecteur.entree get]
            if {![regexp {(\?|\*|~)} $selecteur_nom_fichier]} \
              {
              destroy .selecteur
              return
              }
            }
          set selecteur_nom_fichier {}
          } \
        -text $action

  button .selecteur.met_a_jour \
        -command {Met_a_jour} \
        -text Refresh

  button .selecteur.annuler \
        -command {
          cd $selecteur_pwd
          destroy .selecteur
          } \
        -text Cancel

  scrollbar .selecteur.scrollbarv \
        -command {.selecteur.list yview}

  listbox .selecteur.list \
        -height 10 \
        -relief sunken \
        -selectmode single \
        -setgrid 1 \
        -width 40 \
        -yscrollcommand {.selecteur.scrollbarv set}
  .selecteur.list insert end {..}

  label .selecteur.label \
        -text {File name:}
  entry .selecteur.entree \
        -font [lindex [.selecteur.list config -font] 3] \
        -relief {sunken} 
  .selecteur.entree insert 0 $filtre

  label .selecteur.label_rep \
        -text {Directory:} 
  entry .selecteur.entree_rep \
        -relief {sunken}   
  .selecteur.entree_rep insert 0 [pwd]

  pack .selecteur.ok .selecteur.met_a_jour .selecteur.annuler \
        -expand 1 \
        -fill x \
        -side left \
        -in .selecteur.frame_bouton
  pack .selecteur.list \
        -expand 1 \
        -fill both \
        -side left \
        -in .selecteur.frame_list
  pack .selecteur.scrollbarv \
        -fill y \
        -side left \
        -in .selecteur.frame_list
  pack .selecteur.label \
        -anchor w \
        -in .selecteur.frame_entree
  pack .selecteur.entree  \
        -fill x \
        -in .selecteur.frame_entree
  pack .selecteur.label_rep \
        -anchor w \
        -in .selecteur.frame_entree
  pack .selecteur.entree_rep  \
        -fill x \
        -in .selecteur.frame_entree
  pack .selecteur.frame_entree \
        -fill x \
        -side top
  pack .selecteur.frame_list \
        -expand 1 \
        -fill both \
        -side top
  pack .selecteur.frame_bouton \
        -fill x \
        -side top

  bind .selecteur.list <Double-ButtonRelease-1> { }

  bind .selecteur.list <ButtonRelease-1> \
    {
    set selecteur_tmp [.selecteur.list curselection]
    set selecteur_tmp [.selecteur.list get $selecteur_tmp]
    switch $selecteur_tmp \
      {
      ..
        {
        if {![catch {cd ..}]} \
          {
          Selecteur_ls
          .selecteur.entree delete 0 end
          .selecteur.entree insert 0 $selecteur_filtre
          .selecteur.entree_rep delete 0 end
          .selecteur.entree_rep insert 0 [pwd]
          }
        }
      default
        {
        if {[file isdirectory $selecteur_tmp]} \
          {
          cd $selecteur_tmp
          Selecteur_ls
          .selecteur.entree delete 0 end
          .selecteur.entree insert 0 $selecteur_filtre
          .selecteur.entree_rep delete 0 end
          .selecteur.entree_rep insert 0 [pwd]
          } \
        else \
          {

          focus .selecteur.frame_list
          set selecteur_tmp [.selecteur.list curselection]
          set selecteur_tmp [.selecteur.list get $selecteur_tmp]
          if {[file isfile $selecteur_tmp]} \
            {
            .selecteur.entree delete 0 end
            .selecteur.entree insert 0 $selecteur_tmp 
            }
          }
        }
      }
    }

  bind .selecteur.entree <ButtonRelease-1> \
    {
    .selecteur.list selection clear active 
    }   

  bind .selecteur.entree <KeyPress-Return> \
    { 
    set filtre [.selecteur.entree get]
    if {$filtre==""} \
      {
      .selecteur.entree delete 0 end
      .selecteur.entree insert 0 $selecteur_filtre
      } \
    else \
      {
      regexp {([A-Z]|[a-z]|[0-9]|\*|~|\?|/|_|\.|\ )*} $filtre match
      if {$match==$filtre} \
        {
        set selecteur_filtre $filtre
        Selecteur_ls
        } \
      else \
        {
        .selecteur.entree delete 0 end
        .selecteur.entree insert 0 $selecteur_filtre
        }
      unset match
      }
    unset filtre 
  }

  bind .selecteur.entree <KeyPress-Return> Run_Return_For_Files

  bind .selecteur.entree_rep <KeyPress-Return> Run_Return_For_Directories

  Selecteur_ls

  grab .selecteur
  focus .selecteur
  tkwait window .selecteur  
  }

proc Selecteur_ls {} {
  global selecteur_filtre

  if {[.selecteur.list index end]>1} {.selecteur.list delete 1 end}
  foreach i [concat [lsort [glob -nocomplain */]] \
                    [lsort [eval glob -nocomplain $selecteur_filtre]]] \
    {.selecteur.list insert end $i}
  }

proc Met_a_jour {} {

  global selecteur_filtre

  Selecteur_ls
  .selecteur.entree delete 0 end
  .selecteur.entree insert 0 $selecteur_filtre
  .selecteur.entree_rep delete 0 end
  .selecteur.entree_rep insert 0 [pwd]
  }
proc Main_Window_Initialize {} {

  global bcg_edit_version grid_activated visu_mod
  global canvas_x canvas_y canvas_dx canvas_dy
  global scroll_size
  global borderwidth_size

  wm title . "BCG_EDIT"

  wm protocol . WM_DELETE_WINDOW { Quit_Command }

  frame .frame_menu \
        -borderwidth $borderwidth_size \
        -relief raised
  frame .frame_canvas \
        -borderwidth $borderwidth_size \
        -relief raised

  menubutton .file_menu \
        -menu .file_menu.file \
        -text File
  menu .file_menu.file \
        -tearoff 0
  .file_menu.file add command \
        -command Load_PS_Command \
        -label {Load PS ...}
  .file_menu.file add command \
        -command Load_BCG_Command \
        -label {Load BCG ...}
  .file_menu.file add command \
        -command Save_Command \
        -label {Save PS}
  .file_menu.file add command \
        -command Saveas_Command \
        -label {Save PS as ...}
  .file_menu.file add separator
  .file_menu.file add command \
        -command Preview_Command \
        -label {Preview ...}
   .file_menu.file add command \
        -command Print_Command \
        -label {Print ...}
  .file_menu.file add separator
  .file_menu.file add command \
        -command Quit_Command \
        -label {Quit ...}

  button .help_button \
        -text {Help} \
        -command Help_Command

  menubutton .edit_menu \
        -text {Edit} \
        -menu .edit_menu.edit 
  menu .edit_menu.edit\
        -tearoff 0
  .edit_menu.edit add command \
        -command \
          {
          set visu_mod 1 
          Refresh 
          } \
	-label {Refresh} 
  .edit_menu.edit add separator
  .edit_menu.edit add checkbutton \
	-label {Active the grid} \
	-variable grid_activated
  .edit_menu.edit add checkbutton \
	-label {Active arrow auto-scale} \
	-variable arrows_auto_scale
  .edit_menu.edit add separator
  .edit_menu.edit add command \
        -command \
          {
          .canvas delete sym_curve_control
          .canvas delete asym_curve_control
          .canvas delete loop_control
          catch {unset edges_control}
          } \
        -label {Hide all control points}
  .edit_menu.edit add command \
        -command \
          {
          foreach i [array names edges] \
            {
            switch $edges_type($i) \
              {
              sym_curve {Create_Sym_Curve_Control $i}
              asym_curve {Create_Asym_Curve_Control $i}
              loop {Create_Loop_Control $i}
              }
            }
          } \
        -label {Show all control points}
  .edit_menu.edit add separator
  .edit_menu.edit add command \
        -command  H_Align_Command \
        -label {Align horizontally} 
  .edit_menu.edit add command \
        -command  V_Align_Command \
        -label {Align vertically} 

  menubutton .options_menu \
        -text Options \
        -menu .options_menu.options
  menu .options_menu.options \
        -tearoff 0
  .options_menu.options add command \
        -command PostScript_Command  \
        -label {PostScript options ...} 
  .options_menu.options add command \
        -command Display_Command  \
        -label {Display options ...} 

  canvas .canvas \
        -borderwidth $borderwidth_size \
	-height "[expr $canvas_y+2*$canvas_dy]" \
        -relief sunken \
        -scrollregion "0 0 [expr $canvas_x+2*$canvas_dx] \
                           [expr $canvas_y+2*$canvas_dy]" \
	-width "[expr $canvas_x+2*$canvas_dx]" \
        -xscrollcommand {.scrollbarh set} \
        -yscrollcommand {.scrollbarv set}

global visible_width visible_height
bind .canvas <Configure> {set visible_width %w ; set visible_height %h}

  scrollbar .scrollbarh \
        -command {.canvas xview} \
        -orient horizontal -width $scroll_size
  scrollbar .scrollbarv \
        -command {.canvas yview} \
        -orient vertical -width $scroll_size

  bind .canvas <Shift-ButtonPress-1> {Begin_Selection %x %y}
  bind .canvas <Shift-Button1-Motion> {Move_Selection %x %y}
  bind .canvas <Shift-ButtonRelease-1> {End_Selection}

  bind .canvas <KeyRelease-Shift_L> {End_Selection}
  bind .canvas <KeyRelease-Shift_R> {End_Selection}

  pack .file_menu \
        -side left \
        -in .frame_menu     
  pack .edit_menu \
        -side left \
        -in .frame_menu     
  pack .options_menu \
        -side left \
        -in .frame_menu     
  pack .help_button \
        -side right \
        -in .frame_menu

  pack .scrollbarv \
        -fill y \
        -side right \
        -in .frame_canvas
  pack .scrollbarh \
        -fill x \
        -side bottom \
        -in .frame_canvas
  pack .canvas \
        -expand 1 \
        -fill both \
        -side left \
        -in .frame_canvas

  pack .frame_menu \
        -fill x \
        -side top 
  pack .frame_canvas \
        -expand 1 \
        -fill both \
        -side bottom 

 }

proc Edge_Window_Initialize {i} {

  global edge_type edges
  global borderwidth_size

  catch {destroy .top_edges}
  toplevel .top_edges
  wm title .top_edges "Transform ..."
  wm resizable .top_edges 0 0
  frame .top_edges.frame \
        -borderwidth $borderwidth_size \
        -relief raised
  radiobutton .top_edges.straight \
	-command {destroy .top_edges} \
  	-text {Straight edge} \
	-value straight \
	-variable edge_type
  radiobutton .top_edges.loop \
	-command {destroy .top_edges} \
  	-text Loop \
	-value loop \
	-variable edge_type
  radiobutton .top_edges.sym_curve \
	-command {destroy .top_edges} \
  	-text {Symmetrical curve} \
	-value sym_curve \
	-variable edge_type
  radiobutton .top_edges.asym_curve \
	-command {destroy .top_edges} \
  	-text {Asymmetrical curve} \
	-value asym_curve \
	-variable edge_type
  button .top_edges.cancel \
	-command {destroy .top_edges} \
  	-text Cancel 

  if {[lindex $edges($i) 0]==[lindex $edges($i) 1]} \
    {

    pack .top_edges.loop .top_edges.sym_curve .top_edges.asym_curve \
         -anchor w \
    	 -side top \
         -in .top_edges.frame
    } \
  else \
    {

    pack .top_edges.straight .top_edges.sym_curve .top_edges.asym_curve \
         -anchor w \
         -side top \
         -in .top_edges.frame
    }
  pack .top_edges.cancel \
         -anchor c \
         -expand 1 \
         -fill x \
    	 -side bottom \
         -in .top_edges.frame
  pack .top_edges.frame -in .top_edges
  }

proc Display_Command {} {

  proc Disp_Update {} {

    global visu_mod grid_x_size grid_y_size

    if {[regexp {[0-9]+(\.[0-9]+)?} [.display.grid_ex get] match]} \
      {
      if {$match!=$grid_x_size} \
        {
        set grid_x_size $match
        set visu_mod 1
        }
      }
    .display.grid_ex delete 0 end
    .display.grid_ex insert 0 $grid_x_size

    if {[regexp {[0-9]+(\.[0-9]+)?} [.display.grid_ey get] match]} \
      {
      if {$match!=$grid_y_size} \
        {
        set grid_y_size $match
        set visu_mod 1
        }
      }
    .display.grid_ey delete 0 end
    .display.grid_ey insert 0 $grid_y_size
    }

  global visu_mod grid_x_size grid_y_size
  global visu_vertices visu_edges visu_labels
  global visu_grid

  global grid_x_size_tmp grid_y_size_tmp 
  global visu_vertices_tmp visu_edges_tmp visu_labels_tmp
  global visu_grid_tmp 

  global borderwidth_size

  catch {destroy .display}
  toplevel .display
  wm title .display "Display options"
  wm resizable .display 0 0

  set grid_x_size_tmp $grid_x_size 
  set grid_y_size_tmp $grid_y_size
  set visu_vertices_tmp $visu_vertices
  set visu_edges_tmp $visu_edges
  set visu_labels_tmp $visu_labels
  set visu_grid_tmp $visu_grid

  frame .display.frame_h \
        -borderwidth $borderwidth_size \
        -relief raised
  frame .display.frame_button \
        -borderwidth $borderwidth_size \
        -relief raised
  frame .display.frame_c1        
  frame .display.frame_c2

  button .display.ok \
        -command \
          {
          Disp_Update
          Refresh
          destroy .display
          } \
        -text Ok
  button .display.refresh \
        -command \
          {
          Disp_Update
          Refresh 
          } \
        -text {Refresh}
  button .display.cancel \
        -command \
          {
          set visu_mod 1
          set grid_x_size $grid_x_size_tmp 
          set grid_y_size $grid_y_size_tmp
          set visu_vertices $visu_vertices_tmp
          set visu_edges $visu_edges_tmp
          set visu_labels $visu_labels_tmp
          set visu_grid $visu_grid_tmp
          Refresh 
          destroy .display          
          } \
        -text {Cancel}
  label .display.label \
        -text Display
  checkbutton .display.visu_vertices \
        -command {set visu_mod 1} \
        -text Vertices
  checkbutton .display.visu_edges \
        -command {set visu_mod 1} \
        -text Edges
  checkbutton .display.visu_labels \
        -command {set visu_mod 1} \
        -text Labels 
  checkbutton .display.visu_grid \
        -command {set visu_mod 1} \
        -text Grid

  label .display.grid_x \
        -text {Grid width (x)}
  entry .display.grid_ex
  .display.grid_ex insert 0 $grid_x_size

  label .display.grid_y \
        -text {Grid height (y)}
  entry .display.grid_ey 
  .display.grid_ey insert 0 $grid_y_size 

  pack .display.visu_vertices .display.visu_edges \
       .display.visu_labels \
        -anchor w \
        -side top \
        -in .display.frame_c1
  pack .display.visu_grid \
        -anchor w \
        -side top \
        -in .display.frame_c2
  pack .display.grid_x .display.grid_ex \
       .display.grid_y .display.grid_ey \
       .display.label \
	-fill x \
        -side top \
        -in .display.frame_h
  pack .display.frame_c1 .display.frame_c2 \
        -expand 1 \
        -fill x \
        -side left \
        -in .display.frame_h
  pack .display.ok .display.refresh .display.cancel \
        -expand 1 \
        -fill x \
        -side left \
        -in .display.frame_button
  pack .display.frame_h .display.frame_button \
        -fill x \
        -side top
  }

proc PostScript_Command {} {

  proc Ps_Update {} {

    global bounding_box canvas_x canvas_y arrow_shape_point arrow_shape
    global radius_point radius visu_mod pixel_per_point
    global edges edges_type arrow_scale
    global dialogue_numero arrows_auto_scale

    if {[regexp {([0-9]+)\ ([0-9]+)\ ([0-9]+)\ ([0-9]+)} \
        [.parameters.bbox_e get] match]} \
      {
      if {$match!=$bounding_box} \
        {
        set bounding_box $match
        set canvas_x [expr ([lindex $bounding_box 2]- \
                           [lindex $bounding_box 0])*$pixel_per_point]
        set canvas_y [expr ([lindex $bounding_box 3]- \
                           [lindex $bounding_box 1])*$pixel_per_point]
        set visu_mod 1
        }
      }
    .parameters.bbox_e delete 0 end
    .parameters.bbox_e insert 0 $bounding_box

    if {[regexp {[0-9]+(\.[0-9]+)?} [.parameters.radius_e get] match]} \
      {
      if {$match!=$radius_point} \
        {
        set d_min [Get_Dist_Min]
        set r_2_as [expr $match*$pixel_per_point*2+[lindex $arrow_shape 0]]
        set dialogue_numero 1
        if {$d_min<=$r_2_as} \
          {
          Boite_Dialogue .dialogue {Warning!}\
            "The vertex radius is too large, because the distance between \
             two vertices is less than the arrow length. Are you sure?" \
	    "Cancel" "Confirm the change"
          }
        if {$dialogue_numero==1} \
          {

          set radius_point $match
          set radius [expr $radius_point*$pixel_per_point]
          if {$arrows_auto_scale} \
            {
            foreach i [array names edges] \
              {
              if {$edges_type($i)!={loop}} \
                { 
                set arrow_scale($i) [Get_Scale $i]
                Arrow_Shape_Update $i
                }
              }
            }
          set visu_mod 1
          }
        }
      }
    .parameters.radius_e delete 0 end
    .parameters.radius_e insert 0 $radius_point  	

    if {[regexp {([0-9]+)\ ([0-9]+)\ ([0-9]+)} \
        [.parameters.arrow_e get] match]} \
      {
      if {$match!=$arrow_shape_point} \
        {
        set d_min [Get_Dist_Min]
        set r_2_as [expr $radius*2.0+[lindex $match 0]*$pixel_per_point]
        set dialogue_numero 1
        if {$d_min<=$r_2_as} \
          {
          Boite_Dialogue .dialogue {Warning!}\
            "The vertex radius is too large, because the distance between \
             two vertices is less than the arrow length. Are you sure?" \
	    "Cancel" "Confirm the change"
          }
        if {$dialogue_numero==1} \
          {

          set arrow_shape_point $match
          set arrow_shape "[expr [lindex $arrow_shape_point 0]*$pixel_per_point] \
                           [expr [lindex $arrow_shape_point 1]*$pixel_per_point] \
                           [expr [lindex $arrow_shape_point 2]*$pixel_per_point]"
          if {$arrows_auto_scale} \
            {
            foreach i [array names edges] \
              {
              if {$edges_type($i)!={loop}} \
                { 
                set arrow_scale($i) [Get_Scale $i]
                Arrow_Shape_Update $i
                }
              }
            }          
          set visu_mod 1
          }
        }
      }         
    .parameters.arrow_e delete 0 end
    .parameters.arrow_e insert 0 $arrow_shape_point
    }

  global bounding_box radius_point arrow_shape_point visu_mod graph_mod
  global borderwidth_size

  global bounding_box_tmp  arrow_shape_point_tmp radius_point_tmp

  catch {destroy .parameters}
  toplevel .parameters
  wm title .parameters "PostScript options"
  wm resizable .parameters 0 0

  set bounding_box_tmp $bounding_box
  set arrow_shape_point_tmp $arrow_shape_point
  set radius_point_tmp $radius_point

  frame .parameters.frame_h \
        -borderwidth $borderwidth_size \
        -relief raised
  frame .parameters.frame_button \
        -borderwidth $borderwidth_size \
        -relief raised

  button .parameters.ok \
        -command \
          {
          Ps_Update

	  set graph_mod [expr $graph_mod || $visu_mod]
	  Refresh
	  destroy .parameters
          } \
        -text Ok
  button .parameters.refresh \
        -command \
          {
          Ps_Update	
          Refresh
          } \
        -text {Refresh}
  button .parameters.cancel \
        -command \
          {
          set visu_mod 1
          .parameters.bbox_e delete 0 end
          .parameters.bbox_e insert 0 $bounding_box_tmp
          .parameters.radius_e delete 0 end
          .parameters.radius_e insert 0 $radius_point_tmp
          .parameters.arrow_e delete 0 end
          .parameters.arrow_e insert 0 $arrow_shape_point_tmp
          Ps_Update
          Refresh
 	  destroy .parameters        
          } \
        -text {Cancel}
  label .parameters.bbox \
        -text {PostScript bounding box}
  entry .parameters.bbox_e
  .parameters.bbox_e insert 0 $bounding_box

  label .parameters.radius \
        -text {Vertex radius}
  entry .parameters.radius_e
  .parameters.radius_e insert 0 $radius_point

  label .parameters.arrow \
        -text {Arrow shape}
  entry .parameters.arrow_e 
  .parameters.arrow_e insert 0 $arrow_shape_point 

  pack .parameters.bbox .parameters.bbox_e \
       .parameters.radius .parameters.radius_e \
       .parameters.arrow .parameters.arrow_e \
	-fill x \
        -side top \
        -in .parameters.frame_h
  pack .parameters.ok .parameters.refresh .parameters.cancel \
        -expand 1 \
        -fill x \
        -side left \
        -in .parameters.frame_button
  pack .parameters.frame_h .parameters.frame_button \
        -fill x \
        -side top
  }

proc Run_Printing_Command {} {

    global printer BCG_EDIT_TMP_PRINT file_name CADP
    global env 

    set printer [.print.printer_e get]
    Save $BCG_EDIT_TMP_PRINT ""
    set env(PRINTER) $printer
    destroy .print

    if [catch {exec sh $CADP/src/com/cadp_print $BCG_EDIT_TMP_PRINT} \
	    resultat_print] {
	Boite_Dialogue .dialogue {Warning!} \
		"Print command failed.\n\nWhen invoking the print command:\n\n   \"$CADP/src/com/cadp_print $BCG_EDIT_TMP_PRINT\"\n\n\with variable PRINTER set to \"$printer\"\n\nthe following error message was returned:\n\n   \"$resultat_print\"" \
		"OK"
	return
    }
} 

proc Print_Command {} {

  global printer BCG_EDIT_TMP_PRINT file_name CADP
  global borderwidth_size

  if {$file_name==""} {return}

  catch {destroy .print}
  toplevel .print
  wm title .print "Print"
  wm resizable .print 0 0

  frame .print.frame_h \
        -borderwidth $borderwidth_size \
        -relief raised
  frame .print.frame_button \
        -borderwidth $borderwidth_size \
        -relief raised

  button .print.ok \
        -command Run_Printing_Command\
        -text "Print"
  button .print.cancel \
        -command \
          {
          destroy .print
          } \
        -text "Cancel"
  label .print.printer \
        -text {Printer}
  entry .print.printer_e
  bind .print.printer_e <Return> Run_Printing_Command
  .print.printer_e insert 0 $printer

  pack .print.printer .print.printer_e \
	-fill x \
        -side top \
        -in .print.frame_h
  pack .print.ok .print.cancel \
        -expand 1 \
        -fill x \
        -side left \
        -in .print.frame_button
  pack .print.frame_h .print.frame_button \
        -fill x \
        -side top
  }

proc Run_Postscript_Viewer {} {

    global PostScript_viewer BCG_EDIT_TMP_VIEW CADP
    global env 

    set PostScript_viewer [.preview.ps_viewer_e get]
    Save $BCG_EDIT_TMP_VIEW ""
    set env(CADP_PS_VIEWER) $PostScript_viewer
    destroy .preview

    if [catch {exec sh $CADP/src/com/cadp_postscript $BCG_EDIT_TMP_VIEW} resultat_view] {
	Boite_Dialogue .dialogue {Warning!} \
		"Preview command failed.\n\nWhen invoking the display command:\n\n   \"$CADP/src/com/cadp_postscript $BCG_EDIT_TMP_VIEW\"\n\n\with variable CADP_PS_VIEWER set to \"$PostScript_viewer\"\n\nthe following error message was returned:\n\n   \"$resultat_view\"" \
		"OK"
	return
    }
}

proc Preview_Command {} {

  global PostScript_viewer BCG_EDIT_TMP_VIEW file_name CADP
  global borderwidth_size

  if {$file_name==""} {return}

  catch {destroy .preview}
  toplevel .preview
  wm title .preview "Preview"
  wm resizable .preview 0 0

  frame .preview.frame_h \
        -borderwidth $borderwidth_size \
        -relief raised
  frame .preview.frame_button \
        -borderwidth $borderwidth_size \
        -relief raised

  button .preview.ok \
        -command Run_Postscript_Viewer\
        -text "Preview"
  button .preview.cancel \
        -command \
          {
          destroy .preview
          } \
        -text "Cancel"
  label .preview.ps_viewer \
        -text {Previewer}
  entry .preview.ps_viewer_e
  bind .preview.ps_viewer_e <Return> Run_Postscript_Viewer
  .preview.ps_viewer_e insert 0 $PostScript_viewer

  pack .preview.ps_viewer .preview.ps_viewer_e \
        -fill x \
        -side top \
        -in .preview.frame_h
  pack .preview.ok .preview.cancel \
        -expand 1 \
        -fill x \
        -side left \
        -in .preview.frame_button
  pack .preview.frame_h .preview.frame_button \
        -fill x \
        -side top
  }

proc Load_PS_Command {} {

  global selecteur_nom_fichier file_name visu_mod graph_mod

  if {$graph_mod} \
    {
    global dialogue_numero

    Boite_Dialogue .dialogue {Warning!}\
        "The graph ``$file_name'' was modified. Loading another file will discard your changes. Do you still want to load?" \
	"Don't Load" "Discard and Load"
    switch $dialogue_numero \
      {
      0 {return}
      }
    }

  Selecteur_Fichier "Load" "Load a PS file" "*.ps"

  if {$selecteur_nom_fichier==""} {return}

  catch {destroy .top_edges}
  catch {destroy .parameters}
  catch {destroy .display}

  Load [pwd]/$selecteur_nom_fichier

  set graph_mod 0
  set visu_mod 1
  Refresh
}

proc Load_BCG_Command {} {

  global selecteur_nom_fichier file_name visu_mod graph_mod

  if {$graph_mod} \
    {
    global dialogue_numero

    Boite_Dialogue .dialogue {Warning!}\
        "The graph ``$file_name'' was modified. Loading another file will discard your changes. Do you still want to load?" \
	"Don't Load" "Discard and Load"
    switch $dialogue_numero \
      {
      0 {return}
      }
    }

  Selecteur_Fichier "Load" "Load a BCG file" "*.bcg"

  if {$selecteur_nom_fichier==""} {return}

  catch {destroy .top_edges}
  catch {destroy .parameters}
  catch {destroy .display}

  Load [pwd]/$selecteur_nom_fichier

  set graph_mod 0
  set visu_mod 1
  Refresh
  }

proc Offset_X {bounding_box} {
  return [lindex $bounding_box 0]
  }

proc Offset_Y {bounding_box} {
  return [lindex $bounding_box 1]
  }

proc Load {name} {

  global radius_point radius arrow_shape_point arrow_shape
  global bounding_box canvas_x canvas_y canvas_dy pixel_per_point
  global vertices edges edges_type labels arrow_scale num_spline_steps
  global file_name

  if {![file isfile $name] || ![file readable $name]} {
    global dialogue_numero
    Boite_Dialogue .dialogue {Warning!}\
        "Unable to read in ``$name''" \
         "OK" "Load a BCG file" "Load a PS file"
    if {$dialogue_numero == 0} {return} \
    elseif {$dialogue_numero == 1} {Load_BCG_Command ; return} \
    elseif {$dialogue_numero == 2} {Load_PS_Command ; return}
    }

  if {[file extension $name]=={.bcg}} \
    {
    set name_tmp [file rootname $name].ps
    if [file exists $name_tmp] \
      {
      global dialogue_numero
      Boite_Dialogue .dialogue {Warning!}\
        "The PS file ``$name_tmp'' already exists. Loading the BCG file will cause the PS file to be overwritten by ``bcg_draw''. Do you still want to load?" \
	"Don't Overwrite" "Overwrite and Load"
      if {$dialogue_numero==0} {return}
  }

  if [catch {eval exec sh -c \"bcg_draw -ps '$name'\"} resultat_bcg_draw] {
      global dialogue_numero
      global env
      Boite_Dialogue .dialogue {Warning!}\
	      "Command ``bcg_draw'' failed.\n\nWhen invoking the ``bcg_draw'' command\nto translate ``$name'' into PostScript,\nthe following error message was returned:\n\n``$resultat_bcg_draw''" \
	      "OK" "Load a BCG file" "Load a PS file"
      if {$dialogue_numero == 0} {return} \
      elseif {$dialogue_numero == 1} {Load_BCG_Command ; return} \
      elseif {$dialogue_numero == 2} {Load_PS_Command ; return}
    }
  set name $name_tmp    
  }

  if [catch {set f [open $name r]} resultat_open] {
      global dialogue_numero
      Boite_Dialogue .dialogue {Warning!}\
	      "Unable to read in ``$name''" \
	       "OK" "Load a BCG file" "Load a PS file"
      if {$dialogue_numero == 0} {return} \
      elseif {$dialogue_numero == 1} {Load_BCG_Command ; return} \
      elseif {$dialogue_numero == 2} {Load_PS_Command ; return}
  }

  Make_Menu_Buttons_Disabled_And_Cursor_Watch

  gets $f lu
  while {![eof $f] && $lu!={% BCG_BEGIN_SECTION_1}} \
    {

    if [catch {set first_element_of_line [lindex $lu 0]} result_file_reading] {
      global env
      global dialogue_numero
      Boite_Dialogue .dialogue {Warning!}\
	      "File ``$name'' is not in the BCG PS format" \
	      "OK" "Load a BCG file" "Load a PS file"
      if {$dialogue_numero == 0} {Make_Menu_Buttons_Normal_And_Cursor_Pointer ; return} \
      elseif {$dialogue_numero == 1} {Load_BCG_Command ; return} \
      elseif {$dialogue_numero == 2} {Load_PS_Command ; return}
    }

    switch $first_element_of_line \
      {
      %%BoundingBox: {set bounding_box [string range $lu 15 [string length $lu]]}
      }
    gets $f lu
  }

  if {$lu != {% BCG_BEGIN_SECTION_1}} {
      global env
      global dialogue_numero
      Boite_Dialogue .dialogue {Warning!}\
	      "File ``$name'' is not in the BCG PS format" \
	      "OK" "Load a BCG file" "Load a PS file"
      if {$dialogue_numero == 0} {Make_Menu_Buttons_Normal_And_Cursor_Pointer ; return} \
      elseif {$dialogue_numero == 1} {Load_BCG_Command ; return} \
      elseif {$dialogue_numero == 2} {Load_PS_Command ; return}
  }
	

  set file_name $name

  catch {unset vertices edges labels}

  set offset_x [Offset_X $bounding_box]
  set offset_y [Offset_Y $bounding_box]

  set canvas_x [expr ([lindex $bounding_box 2]- \
                     [lindex $bounding_box 0])*$pixel_per_point]
  set canvas_y [expr ([lindex $bounding_box 3]- \
                     [lindex $bounding_box 1])*$pixel_per_point]

  set max_y [expr $canvas_y+$canvas_dy]

  while {![eof $f] && $lu!={% BCG_END_SECTION_1}} \
    {

    switch [lindex $lu 0] \
      {
      {/vertex_radius}
        {

        set radius_point [expr [lindex $lu 1]]
        set radius [expr $radius_point*$pixel_per_point]
        }
      {/arrow_shape_1}
        {
        set arrow_1 [expr [lindex $lu 1]]
        }
      {/arrow_shape_2}
        {
        set arrow_2 [expr [lindex $lu 1]]
        }
      {/arrow_shape_3}
        {
        set arrow_3 [expr [lindex $lu 1]]
        }
      }
    gets $f lu

    update
  }

  set arrow_shape_point "$arrow_1 $arrow_2 $arrow_3"
  set arrow_shape "[expr $arrow_1*$pixel_per_point] \
                   [expr $arrow_2*$pixel_per_point] \
                   [expr $arrow_3*$pixel_per_point]"

  while {![eof $f] && $lu!={% BCG_BEGIN_SECTION_2}} {gets $f lu}

  gets $f lu

  set pos [expr [string last ) $lu]-1]
  set first [string range $lu 1 $pos]
  set lu [string range $lu [expr $pos+2] [expr [string length $lu]-1]]    

  while {[lindex $lu 2]=={vertex}} \
    {
    set i [expr $first]
    set x [expr [lindex $lu 0]-$offset_x]
    set y [expr [lindex $lu 1]-$offset_y]
    set vertices($i) "[expr $x*$pixel_per_point] \
                      [expr $max_y-$y*$pixel_per_point]"
    gets $f lu

    set pos [expr [string last ) $lu]-1]
    set first [string range $lu 1 $pos]
    set lu [string range $lu [expr $pos+2] [expr [string length $lu]-1]]    

    update
    }

  set i 0

  while {$lu!={% BCG_END_SECTION_2}} \
    {

    set labels($i,0) $first

    regsub -all {\\\\} $labels($i,0) {\\} labels($i,0)
    regsub -all {\\\(} $labels($i,0) {(} labels($i,0)
    regsub -all {\\\)} $labels($i,0) {)} labels($i,0)

    if {[lindex $lu 7]=={edge}} \
      {
      set ori [lindex $lu 9]
      set des [lindex $lu 10]
      set edges_type($i) straight
      set edges($i) "$ori $des"   
      set labels($i,1) [lindex $lu 11]
      set arrow_scale($i) [lindex $lu 6]
      } \
    else \
      {

      set ori [lindex $lu 13]
      set des [lindex $lu 14]
      set edges($i) "$ori $des"
      set arrow_scale($i) [lindex $lu 10]
      set par_16 [lindex $lu 16]
      if {$par_16!={}} \
        {
        lappend edges($i) [expr [lindex $lu 15]*$pixel_per_point] $par_16
        set labels($i,1) [expr round([lindex $lu 17]*$num_spline_steps/2)]

        if {$ori==$des} \
          {

          set edges_type($i) loop
          } \
        else \
          {

          set edges_type($i) sym_curve
          }
        } \
      else \
        {

        set edges_type($i) asym_curve
        set labels($i,1) [expr round([lindex $lu 15]*$num_spline_steps/2)]
        set x2 [lindex $lu 4]
        set y2 [lindex $lu 5]
        set x3 [lindex $lu 6]
        set y3 [lindex $lu 7]
        lappend edges($i) \
            [expr $x2*$pixel_per_point] [expr $max_y-$y2*$pixel_per_point] \
            [expr $x3*$pixel_per_point] [expr $max_y-$y3*$pixel_per_point]
        }      
      }
    incr i
    gets $f lu

    set pos [expr [string last ) $lu]-1]
    set first [string range $lu 1 $pos]
    set lu [string range $lu [expr $pos+2] [expr [string length $lu]-1]]

    update
    }
  close $f

  Make_Menu_Buttons_Normal_And_Cursor_Pointer

  }

proc Save_Command {} {

  global file_name BCG_EDIT_TMP_FILE graph_mod 

  if {$file_name!=""} \
    {
    Save $BCG_EDIT_TMP_FILE $file_name
    set graph_mod 0
    }
  }

proc Saveas_Command {} {

  global selecteur_nom_fichier BCG_EDIT_TMP_FILE file_name graph_mod

  if {$file_name==""} {return}

  Selecteur_Fichier "Save" "Save PS as" "*.ps"

  if {$selecteur_nom_fichier==""} {return}

  Save $BCG_EDIT_TMP_FILE [pwd]/$selecteur_nom_fichier
  set graph_mod 0
  }

proc Save {tmp_name new_name} {

  global file_name
  global radius_point radius arrow_shape_point arrow_shape loop_const
  global bounding_box canvas_x canvas_y canvas_dy point_per_pixel
  global vertices edges edges_type edges_id labels labels_id
  global arrow_scale
  global visu_mod num_spline_steps

  global visu_vertices visu_edges visu_labels visu_mod
  if {!($visu_vertices && $visu_edges && $visu_labels)} \
    {
    set visu_vertices 1
    set visu_edges 1
    set visu_labels 1
    set visu_mod 1
    Refresh
    }

  if [catch {set fw [open "$tmp_name" w]} resultat_open] {
      Boite_Dialogue .dialogue {Warning!}\
	      "Unable to write in ``$tmp_name''" \
	      "OK"
      return
  }

  if [catch {set fr [open $file_name r]} resultat_open] {
      Boite_Dialogue .dialogue {Warning!}\
	      "Unable to read again in ``$file_name''" \
	      "OK"
      return
  }

  if [catch {set Date_Creation [exec date]} resultat_date] {
        set Date_Creation "unknown"
  }
	
  gets $fr lu

  while {$lu!={% BCG_BEGIN_SECTION_1}} \
    {
    switch [lindex $lu 0] \
      {
      %%Creator: {puts $fw "%%Creator: bcg_edit"}
      %%CreationDate: {puts $fw "%%CreationDate: $Date_Creation"}
      %%BoundingBox: {puts $fw "%%BoundingBox: $bounding_box"}
      default {puts $fw $lu}
      }
    gets $fr lu
    } 

  while {$lu!={% BCG_END_SECTION_1}} \
    {
    switch [lindex $lu 0] \
      {
      /vertex_radius {puts $fw "/vertex_radius \{ $radius_point \} def"}     
      /arrow_shape_1 
        {puts $fw "/arrow_shape_1 \{ [lindex $arrow_shape_point 0] \} def"}
      /arrow_shape_2 
        {puts $fw "/arrow_shape_2 \{ [lindex $arrow_shape_point 1] \} def"}
      /arrow_shape_3 
        {puts $fw "/arrow_shape_3 \{ [lindex $arrow_shape_point 2] \} def"}
      default {puts $fw $lu}
      }
    gets $fr lu
    }  

  while {$lu!={% BCG_BEGIN_SECTION_2}} \
    {  
    puts $fw $lu
    gets $fr lu
    }

  puts $fw "% BCG_BEGIN_SECTION_2"

  set max_y [expr $canvas_y+$canvas_dy]

  set offset_x [Offset_X $bounding_box]
  set offset_y [Offset_Y $bounding_box]

  foreach i [array names vertices] \
    {
    set x [expr [lindex $vertices($i) 0]*$point_per_pixel+$offset_x]
    set y [expr ($max_y-[lindex $vertices($i) 1])*$point_per_pixel+$offset_y]
    puts $fw "($i) $x $y vertex"
    }

  foreach i [array names edges] \
    {
    set ori [lindex $edges($i) 0]
    set des [lindex $edges($i) 1]
    set coords [.canvas coords $labels_id($i)]

    set x_label [expr [lindex $coords 0]*$point_per_pixel]
    set y_label [expr ($max_y-[lindex $coords 1])*$point_per_pixel]

    set new_labels($i) $labels($i,0)
    regsub -all {\\} $new_labels($i) {\\\\} new_labels($i)
    regsub -all {\(} $new_labels($i) {\\(} new_labels($i)
    regsub -all {\)} $new_labels($i) {\\)} new_labels($i)

    switch $edges_type($i) \
      {
      straight
        {
        set x1 [lindex $vertices($ori) 0]
        set y1 [lindex $vertices($ori) 1]
        set x2 [lindex $vertices($des) 0]
        set y2 [lindex $vertices($des) 1]

        set dx2x1 [expr $x2-$x1]
        set dy2y1 [expr $y1-$y2]
        if {$dx2x1==0} \
          {
          set dx1 0
          set dx2 0
          if {$dy2y1>0} \
            {
            set dy1 $radius
            set dy2 [expr $radius+[lindex $arrow_shape 0]*$arrow_scale($i)]
            } \
          else \
            {
            set dy1 -$radius
            set dy2 [expr -($radius+[lindex $arrow_shape 0]*$arrow_scale($i))]
            }
          } \
        else \
          {
          set alpha [expr atan($dy2y1/$dx2x1)]
          set cos [expr cos($alpha)]
          set sin [expr sin($alpha)]
          set dx1 [expr $radius*$cos]
          set dy1 [expr $radius*$sin]
          set dx2 [expr ($radius+[lindex $arrow_shape 0]*$arrow_scale($i))*$cos]
          set dy2 [expr ($radius+[lindex $arrow_shape 0]*$arrow_scale($i))*$sin]
          }
        if {$dx2x1<0} \
          {
          set dx1 [expr $dx1*(-1)]
          set dy1 [expr $dy1*(-1)]
          set dx2 [expr $dx2*(-1)]
          set dy2 [expr $dy2*(-1)]
          }
        set px1 [expr ($x1+$dx1)*$point_per_pixel]
        set py1 [expr ($max_y-($y1-$dy1))*$point_per_pixel]
        set px2 [expr ($x2-$dx2)*$point_per_pixel]
        set py2 [expr ($max_y-($y2+$dy2))*$point_per_pixel]

	  
        puts $fw "($new_labels($i)) $x_label $y_label\
                  $px1 $py1 $px2 $py2 $arrow_scale($i) edge % $ori $des $labels($i,1)"
        }
      sym_curve
        {
        set x1 [lindex $vertices($ori) 0]
        set y1 [lindex $vertices($ori) 1]
        set x2 [lindex $vertices($des) 0]
        set y2 [lindex $vertices($des) 1]

        set rho [lindex $edges($i) 2]
        set theta [lindex $edges($i) 3]
        set dx2x1 [expr $x2-$x1]
        set dy2y1 [expr $y1-$y2]
        if {$dx2x1==0} \
          {
          if {$dy2y1<=0} {set alpha [expr -3.1416/2]} \
          else {set alpha [expr 3.1416/2]}
          } \
        else {set alpha [expr atan($dy2y1/$dx2x1)]}
        if {$dx2x1<0} {set alpha [expr $alpha*(-1)]}
        set angle [expr $theta+$alpha]
        set sin [expr sin($angle)]
        set cos [expr cos($angle)] 
        set dx1 [expr $cos*$radius]
        set dy1 [expr $sin*$radius]
        set dx2 [expr $cos*$rho]
        set dy2 [expr $sin*$rho]

        set angle [expr $theta-$alpha]
        set sin [expr sin($angle)]
        set cos [expr cos($angle)] 
        set dx3 [expr $cos*$rho]
        set dy3 [expr $sin*$rho]
        set dx4 [expr $cos*($radius+[lindex $arrow_shape 0]*$arrow_scale($i))]
        set dy4 [expr $sin*($radius+[lindex $arrow_shape 0]*$arrow_scale($i))]

        if {$dx2x1<0} \
          {
          set dx1 [expr $dx1*(-1)]
          set dx2 [expr $dx2*(-1)]
          set dx3 [expr $dx3*(-1)]
          set dx4 [expr $dx4*(-1)]
          }
        set px1 [expr ($x1+$dx1)*$point_per_pixel]
        set py1 [expr ($max_y-($y1-$dy1))*$point_per_pixel]
        set px2 [expr ($x1+$dx2)*$point_per_pixel]
        set py2 [expr ($max_y-($y1-$dy2))*$point_per_pixel]
        set px3 [expr ($x2-$dx3)*$point_per_pixel]
        set py3 [expr ($max_y-($y2-$dy3))*$point_per_pixel]
        set px4 [expr ($x2-$dx4)*$point_per_pixel]
        set py4 [expr ($max_y-($y2-$dy4))*$point_per_pixel]
        set rho [expr [lindex $edges($i) 2]*$point_per_pixel]
        set theta [lindex $edges($i) 3]

        puts $fw "($new_labels($i)) $x_label $y_label $px1 $py1 $px2 $py2 \
                  $px3 $py3 $px4 $py4 $arrow_scale($i) spline % $ori $des $rho $theta \
                  [expr double(2*$labels($i,1))/$num_spline_steps]"
        }
      asym_curve
        {
        set x1 [lindex $vertices($ori) 0]
        set y1 [lindex $vertices($ori) 1]
        set x2 [lindex $edges($i) 2]
        set y2 [lindex $edges($i) 3]
        set x3 [lindex $edges($i) 4]
        set y3 [lindex $edges($i) 5]
        set x4 [lindex $vertices($des) 0]
        set y4 [lindex $vertices($des) 1]

        set dx [expr $x2-$x1]
        set dy [expr $y1-$y2]
        if {$dx==0} \
          { 
          if {$dy<0} {set theta [expr -3.1416/2]} \
          else {set theta [expr 3.1416/2]}
          } \
        else \
          {    
          if {$x4>=$x1} \
            {
            if {$dx<0} {set theta [expr 3.1416+atan($dy/$dx)]} \
            else {set theta [expr atan($dy/$dx)]}
            } \
          else \
            {
            if {$dx<0} {set theta [expr -atan($dy/$dx)]} \
            else {set theta [expr 3.14116-atan($dy/$dx)]}
            }
          }
        set dx1 [expr cos($theta)*$radius]
        set dy1 [expr sin($theta)*$radius]

        set dx [expr $x4-$x3]
        set dy [expr $y3-$y4]
        if {$dx==0} \
          { 
          if {$dy<0} {set theta [expr -3.1416/2]} \
          else {set theta [expr 3.1416/2]}
          } \
        else \
          {    
          if {$x4>=$x1} \
            {
            if {$dx<0} {set theta [expr 3.1416+atan($dy/$dx)]} \
            else {set theta [expr atan($dy/$dx)]}
            } \
          else \
            {
            if {$dx<0} {set theta [expr -atan($dy/$dx)]} \
            else {set theta [expr 3.1416-atan($dy/$dx)]}
            }
          }
        set dx4 [expr cos($theta)*($radius+[lindex $arrow_shape 0]*$arrow_scale($i))]
        set dy4 [expr sin($theta)*($radius+[lindex $arrow_shape 0]*$arrow_scale($i))]
        if {$x4<$x1} \
          {
          set dx1 [expr $dx1*(-1)]
          set dx4 [expr $dx4*(-1)]
          }
        set px1 [expr ($x1+$dx1)*$point_per_pixel]
        set py1 [expr ($max_y-($y1-$dy1))*$point_per_pixel]
        set px2 [expr $x2*$point_per_pixel]
        set py2 [expr ($max_y-$y2)*$point_per_pixel]
        set px3 [expr $x3*$point_per_pixel]
        set py3 [expr ($max_y-$y3)*$point_per_pixel]
        set px4 [expr ($x4-$dx4)*$point_per_pixel]
        set py4 [expr ($max_y-($y4+$dy4))*$point_per_pixel]

         puts $fw "($new_labels($i)) $x_label $y_label $px1 $py1 $px2 $py2 \
                  $px3 $py3 $px4 $py4 $arrow_scale($i) spline % $ori $des \
                  [expr double(2*$labels($i,1))/$num_spline_steps]"
        }
      loop
        {
        set x1 [lindex $vertices($ori) 0]
        set y1 [lindex $vertices($ori) 1]

        set rho [lindex $edges($i) 2]
        set theta [expr $loop_const/$rho]
        set alpha [lindex $edges($i) 3]

        set angle [expr $alpha+$theta]
        set sin [expr sin($angle)]
        set cos [expr cos($angle)]
        set dx1 [expr $cos*$radius]
        set dy1 [expr $sin*$radius]
        set dx2 [expr $cos*$rho]
        set dy2 [expr $sin*$rho]
        set angle [expr $alpha-$theta]
        set sin [expr sin($angle)]
        set cos [expr cos($angle)] 
        set dx4 [expr $cos*($radius+[lindex $arrow_shape 0]*$arrow_scale($i))]
        set dy4 [expr $sin*($radius+[lindex $arrow_shape 0]*$arrow_scale($i))]
        set dx3 [expr $cos*$rho]
        set dy3 [expr $sin*$rho]
        set px1 [expr ($x1+$dx1)*$point_per_pixel]
        set py1 [expr ($max_y-($y1-$dy1))*$point_per_pixel]
        set px2 [expr ($x1+$dx2)*$point_per_pixel]
        set py2 [expr ($max_y-($y1-$dy2))*$point_per_pixel]
        set px3 [expr ($x1+$dx3)*$point_per_pixel]
        set py3 [expr ($max_y-($y1-$dy3))*$point_per_pixel]
        set px4 [expr ($x1+$dx4)*$point_per_pixel]
        set py4 [expr ($max_y-($y1-$dy4))*$point_per_pixel]
        set rho [expr [lindex $edges($i) 2]*$point_per_pixel]
        set alpha [lindex $edges($i) 3]

         puts $fw "($new_labels($i)) $x_label $y_label $px1 $py1 $px2 $py2 \
                  $px3 $py3 $px4 $py4 $arrow_scale($i) spline % $ori $des $rho $alpha \
                  [expr double(2*$labels($i,1))/$num_spline_steps]"
        }
      }
    }

  while {$lu!={% BCG_END_SECTION_2}} \
    {  
    gets $fr lu
    }
  while {![eof $fr]} \
    {
    puts $fw $lu
    gets $fr lu
    }

  close $fr
  close $fw

  if {$new_name != ""} \
      {

     if [catch {eval exec mv $tmp_name $new_name} resultat_mv] {
	 global dialogue_numero
	 Boite_Dialogue .dialogue {Warning!}\
		 "Unable to write in ``$new_name''\n\nthe following error message was returned:\n\n``$resultat_mv''" \
                  "OK" "Save as another file"
         if {$dialogue_numero==1} {Saveas_Command;return} else {return}
     }

     set file_name $new_name 
     wm title . "BCG_EDIT $file_name"
   }
}

proc Quit_Command {} {

  global dialogue_numero file_name graph_mod

  if {$graph_mod} \
    {
    Boite_Dialogue .dialogue {Warning!}\
        "The graph ``$file_name'' was modified. Quitting will discard your changes. Do you still want to quit?" \
         "Don't Quit" "Discard and Quit" 
    switch $dialogue_numero \
      {
      0 {return}
      }
    }
  Delete_Temporary_Files
  destroy .
  }
proc Help_Window_Initialize {} {

  global borderwidth_size

  catch {destroy .top_help}
  toplevel .top_help
  wm resizable .top_help 0 1
  wm title .top_help {Help}

  frame .top_help.frame_menu \
        -borderwidth $borderwidth_size \
        -relief raised

  frame .top_help.frame_text \
        -borderwidth $borderwidth_size \
        -relief raised

  button .top_help.done_button \
        -command {destroy .top_help} \
        -text Cancel

  button .top_help.refresh_button \
        -command  "" \
        -text Refresh

  button .top_help.index_button \
        -command {Help_Show_Index;
                  .top_help.refresh_button configure \
                    -command {Help_Show_Index}} \
        -text Index

  text .top_help.text \
	-height 52 \
	-setgrid true \
	-width 78 \
	-wrap word \
	-yscrollcommand ".top_help.scroll set"

  scrollbar .top_help.scroll\
	 -command ".top_help.text yview"

  pack .top_help.index_button .top_help.refresh_button .top_help.done_button \
        -side left \
        -in .top_help.frame_menu    

  pack .top_help.scroll \
        -fill y \
        -side right \
        -in .top_help.frame_text
  pack .top_help.text \
        -expand 1 \
        -fill both \
        -side left \
        -in .top_help.frame_text

  pack .top_help.frame_menu \
        -fill x \
        -side top 
  pack .top_help.frame_text \
        -expand 1 \
        -fill both \
        -side bottom 
  }

proc Help_Show_List {list tag_suf} {

  set max_length 0
  foreach item $list \
    {
    set str [lindex $item 0]
    if {[string length $str]>$max_length} {set max_length [string length $str]}
    }
  incr max_length 2
  set mod [expr [.top_help.text cget -width]/$max_length]

  set mod 1

  set tag_num 1
   foreach item $list \
    {
    set str [lindex $item 0]
    set length [string length $str]
    .top_help.text insert end " $str " "$tag_suf$tag_num"
    if "[expr $tag_num%$mod]" \
      {
      for {set i 0} {$i<[expr $max_length-$length]} {incr i} \
        {
        .top_help.text insert end " "
        }
      } \
    else \
      {
      .top_help.text insert end "\n"
      }
    .top_help.text tag bind "$tag_suf$tag_num" <Any-Enter> \
                            ".top_help.text tag configure $tag_suf$tag_num \
                            -foreground white -background black"
    .top_help.text tag bind "$tag_suf$tag_num" <Any-Leave> \
                            ".top_help.text tag configure $tag_suf$tag_num \
                            -foreground {} -background {}"
    .top_help.text tag bind "$tag_suf$tag_num" <ButtonRelease-1> \
                            "Help_Show_File {[lindex $item 1]};
                             .top_help.refresh_button configure \
                               -command {Help_Show_File {[lindex $item 1]}}"

    incr tag_num
    }
  }

proc Help_Show_Index {} {

  global help_list

  .top_help.text configure -state normal
  .top_help.text delete 0.0 end
  .top_help.text tag configure title \
	-justify center \
	-underline 1

  .top_help.text insert 0.0 "BCG_EDIT help\n" title
  .top_help.text insert end "\n"
  Help_Show_List $help_list help
  .top_help.text configure -state disabled
  }

proc Help_Show_File {command} {

  global PostScript_viewer CADP BCG_EDIT_SRC

  .top_help.text configure -state normal
  .top_help.text delete 0.0 end
  .top_help.text insert end [eval exec $command]
  .top_help.text configure -state disabled
  }

proc Help_Command {} {

  global help_list

  set help_list \
       {{{Overview}		  {cat $BCG_EDIT_SRC/overview.txt}} \
	{{File menu}		  {cat $BCG_EDIT_SRC/file_menu.txt}} \
	{{Edit menu}		  {cat $BCG_EDIT_SRC/edit_menu.txt}} \
	{{Options menu}		  {cat $BCG_EDIT_SRC/options_menu.txt}} \
	{{File browser}      	  {cat $BCG_EDIT_SRC/file_browser.txt}} \
	{{Edge editing}        	  {cat $BCG_EDIT_SRC/edge_editing.txt}} \
	{{Item moving}      	  {cat $BCG_EDIT_SRC/item_moving.txt}} \
	{{Item alignment}      	  {cat $BCG_EDIT_SRC/item_alignment.txt}} \
	{{Summary of bindings}    {cat $BCG_EDIT_SRC/summary.txt}} \
	{{BCG PostScript Format}  {sh $CADP/src/com/cadp_postscript $CADP/doc/ps/Tock-95.ps.Z}} \
        }
  Help_Window_Initialize
  Help_Show_Index
  }

proc Select_Vertex {i} {

  global vertices_id vertices_label_id

  .canvas itemconfigure $vertices_id($i) -fill black
  .canvas itemconfigure $vertices_label_id($i) -fill white
  }

proc Unselect_Vertex {i} {

  global vertices_id vertices_label_id

  .canvas itemconfigure $vertices_id($i) -fill white
  .canvas itemconfigure $vertices_label_id($i) -fill black
  }

proc Begin_Selection {x y} {

  global selection_box_id
  global select_vertex_list

  set select_x [.canvas canvasx $x]
  set select_y [.canvas canvasy $y]
  set selection_box_id [.canvas create rectangle $select_x $select_y \
                                                 $select_x $select_y]
  foreach i $select_vertex_list {Unselect_Vertex $i}
  }

proc Move_Selection {x y} {

  global selection_box_id

  set coords [.canvas coords $selection_box_id]
  set select_x2 [.canvas canvasx $x]
  set select_y2 [.canvas canvasy $y]
  .canvas coord $selection_box_id [lindex $coords 0] [lindex $coords 1] \
                                  $select_x2 $select_y2
  }

proc End_Selection {} {

  global selection_box_id vertices_i vertices_label_i
  global select_vertex_list

  if {[catch {set coords [.canvas coords $selection_box_id]}]} {return}
  .canvas delete $selection_box_id
  unset selection_box_id

  set list [.canvas find enclosed [lindex $coords 0] [lindex $coords 1] \
		                  [lindex $coords 2] [lindex $coords 3]]

  set tmp_list {}
  foreach id $list \
    {
    switch [.canvas gettags $id] \
      {
      vertex {lappend tmp_list $vertices_i($id)}
      vertex_label {lappend tmp_list $vertices_label_i($id)}
      }
    }

  set select_vertex_list {}
  foreach i $tmp_list \
    {
    if {[catch {set void $tmp($i)}]} \
      {
      lappend select_vertex_list $i
      Select_Vertex $i
      set tmp($i) exist 
      }
    }

  set select_vertex_list [lsort -integer -increasing $select_vertex_list]
  }
proc H_Align_Command {} {

  global select_vertex_list radius graph_mod
  global vertices vertices_id visu_edges 

  if {$select_vertex_list=={}} \
    {
    Boite_Dialogue .dialogue {Warning!} \
      {A set of vertices should be defined first, by pressing the shift key and a mouse button simultaneously, then dragging the mouse to delimit a rectangular box} \
      Cancel
    return
    }
  set i [lindex $select_vertex_list 0]
  set y [expr [lindex [.canvas coords $vertices_id($i)] 1]+$radius]
  foreach i $select_vertex_list \
    {
    set x [expr [lindex [.canvas coords $vertices_id($i)] 0]+$radius]
    set vertices($i) "$x $y"
    Draw_Vertex $i

    if {$visu_edges} \
      {
      global edges_type edges_link visu_labels

      foreach j $edges_link($i) \
        {
        switch $edges_type($j) \
          {
          straight	{Draw_Straight $j}
          loop		{Draw_Loop $j}
          sym_curve 	{Draw_Sym_Curve $j}
          asym_curve	{Draw_Asym_Curve $j}
          }
        if {$visu_labels} {Draw_Label $j}
        }
      }
    }
  foreach i $select_vertex_list {Unselect_Vertex $i} 
  set select_vertex_list {}
  set graph_mod 1
  }

proc V_Align_Command {} {

  global select_vertex_list radius graph_mod
  global vertices vertices_id visu_edges 

  if {$select_vertex_list=={}} \
    {
    Boite_Dialogue .dialogue {Warning!} \
      {A set of vertices should be defined first, by pressing the shift key and a mouse button simultaneously, then dragging the mouse to delimit a rectangular box} \
      Cancel
    return
    }
  set i [lindex $select_vertex_list 0]
  set x [expr [lindex [.canvas coords $vertices_id($i)] 0]+$radius]
  foreach i $select_vertex_list \
    {
    set y [expr [lindex [.canvas coords $vertices_id($i)] 1]+$radius]
    set vertices($i) "$x $y"
    Draw_Vertex $i

    if {$visu_edges} \
      {
      global edges_type edges_link visu_labels

      foreach j $edges_link($i) \
        {
        switch $edges_type($j) \
          {
          straight	{Draw_Straight $j}
          loop		{Draw_Loop $j}
          sym_curve 	{Draw_Sym_Curve $j}
          asym_curve	{Draw_Asym_Curve $j}
          }
        if {$visu_labels} {Draw_Label $j}
        }
      }
    }
  foreach i $select_vertex_list {Unselect_Vertex $i}
  set select_vertex_list {}
  set graph_mod 1
  } 
proc Draw_Vertex {i} {

  global vertices vertices_id vertices_label_id
  global radius

  set x [lindex $vertices($i) 0]
  set y [lindex $vertices($i) 1]
  .canvas coords $vertices_id($i) [expr $x-$radius] [expr $y-$radius] \
                                  [expr $x+$radius] [expr $y+$radius]
  .canvas coords $vertices_label_id($i) $x $y
  }

proc Compute_New_Visible_Position {s_x s_y R} {

    global canvas_x canvas_y
    global canvas_dx canvas_dy
    global visible_width visible_height

    set left_pos_scrollbarh [lindex [.scrollbarh get] 0]
    set left_d_x [expr $visible_width * $left_pos_scrollbarh]
    if {$left_d_x > $canvas_dx} {
	set left_d_x $canvas_dx
    }

    set right_pos_scrollbarh [lindex [.scrollbarh get] 1]
    set right_d_x [expr $visible_width - $visible_width * $right_pos_scrollbarh]
    if {$right_d_x > $canvas_dx} {
	set right_d_x $canvas_dx
    }

    set top_pos_scrollbarv  [lindex [.scrollbarv get] 0]
    set top_d_y [expr $visible_height * $top_pos_scrollbarv]
    if {$top_d_y > $canvas_dy} {
	set top_d_y $canvas_dy
    }

    set bottom_pos_scrollbarv  [lindex [.scrollbarv get] 1]
    set bottom_d_y [expr $visible_height - $visible_height * $bottom_pos_scrollbarv]
    if {$bottom_d_y > $canvas_dy} {
	set bottom_d_y $canvas_dy
    }

    set border_width_widgets 2

    set test_left_boundary [expr $s_x > [expr $canvas_dx - $left_d_x + $R + $border_width_widgets]]

    set test_right_boundary [expr $s_x < [expr $visible_width  - $canvas_dx + $right_d_x - $R - 2*$border_width_widgets]]

    set test_top_boundary  [expr $s_y > [expr $canvas_dy - $top_d_y + $R + $border_width_widgets]]

    set test_bottom_boundary [expr $s_y < [expr $visible_height - $canvas_dy + $bottom_d_y - $R - 2*$border_width_widgets]]

    if {$test_left_boundary && $test_right_boundary && \
	    $test_top_boundary && $test_bottom_boundary } {

	return "$s_x $s_y"
    } else {

	if {!$test_top_boundary && $test_left_boundary && \
		$test_right_boundary } {
	    set region 1
	}
	if {!$test_top_boundary && !$test_right_boundary } {
	    set region 2
	}
	if {!$test_right_boundary && \
		$test_top_boundary && $test_bottom_boundary } {
	    set region 3
	}
	if {!$test_right_boundary && !$test_bottom_boundary} {
	    set region 4
	}
	if {!$test_bottom_boundary  && 
		$test_left_boundary && $test_right_boundary } {
	    set region 5
	}
	if {!$test_left_boundary && !$test_bottom_boundary } {
	    set region 6
	}
	if {!$test_left_boundary && $test_top_boundary && \
		$test_bottom_boundary } {
	    set region 7
	}
	if {!$test_top_boundary && !$test_left_boundary} {
	    set region 8
	}
	

	switch $region {
	    1 {
		set p_x $s_x
		set p_y [expr $R + $border_width_widgets + $canvas_dy - $top_d_y]
	    }
	    2 {
		set p_x [expr $visible_width  - $canvas_dx + $right_d_x - $R - 2*$border_width_widgets]
		set p_y [expr $R + $border_width_widgets  + $canvas_dy - $top_d_y]
	    }
	    3 {
		set p_x [expr $visible_width  - $canvas_dx + $right_d_x - $R - 2*$border_width_widgets]
		set p_y $s_y
	    }
	    4 {
		set p_x [expr $visible_width  - $canvas_dx + $right_d_x - $R - 2*$border_width_widgets]
		set p_y [expr $visible_height  - $canvas_dy + $bottom_d_y - $R - $border_width_widgets]
	    }
	    5 {
		set p_x $s_x
		set p_y [expr $visible_height  - $canvas_dy + $bottom_d_y - $R - $border_width_widgets]
	    }
	    6 {
		set p_x [expr $R + $border_width_widgets + $canvas_dx - $left_d_x]
		set p_y [expr $visible_height  - $canvas_dy + $bottom_d_y - $R - $border_width_widgets]
	    }
	    7 {
		set p_x [expr $R + $border_width_widgets + $canvas_dx - $left_d_x]
		set p_y $s_y
	    }
	    8 {
		set p_x [expr $R + $border_width_widgets + $canvas_dx - $left_d_x]
		set p_y [expr $R + $border_width_widgets  + $canvas_dy - $top_d_y]
	    }
	}
	return "$p_x $p_y"
    }
}   

proc Move_Vertex {i x y} {

  global grid_x_size grid_y_size grid_activated
  global vertices visu_edges
  global radius

  set new_pos [eval Compute_New_Visible_Position $x $y $radius]
  set new_x [lindex $new_pos 0]
  set new_y [lindex $new_pos 1]

  if {$grid_activated} \
    {
    set x [.canvas canvasx $new_x $grid_x_size]
    set y [.canvas canvasy $new_y $grid_y_size]
    } \
  else \
    {
    set x [.canvas canvasx $new_x]
    set y [.canvas canvasy $new_y]
    } 
  set vertices($i) "$x $y"

  Draw_Vertex $i

  if {$visu_edges} \
    {
    global edges_type edges_link scale visu_labels arrow_shape
    global arrow_scale edges_id arrows_auto_scale

    foreach j $edges_link($i) \
      {
      switch $edges_type($j) \
        {
        straight	
          {
          if {$arrows_auto_scale} \
            {
            set arrow_scale($j) [Get_Scale $j]
            Arrow_Shape_Update $j
            }
          Draw_Straight $j
          }
        loop		{Draw_Loop $j}
        sym_curve 	
          {
          if {$arrows_auto_scale} \
            {
            set arrow_scale($j) [Get_Scale $j]
            Arrow_Shape_Update $j
            }
          Draw_Sym_Curve $j
          }
        asym_curve	
          {
          if {$arrows_auto_scale} \
            {
            set arrow_scale($j) [Get_Scale $j]
            Arrow_Shape_Update $j
            }
          Draw_Asym_Curve $j
          }
        }
       if {$visu_labels} {Draw_Label $j}
      }
    }
}
proc Compute_Straight {i} {

  global radius
  global vertices edges

  set ori [lindex $edges($i) 0]
  set x1 [lindex $vertices($ori) 0]
  set y1 [lindex $vertices($ori) 1]

  set des [lindex $edges($i) 1]
  set x2 [lindex $vertices($des) 0]
  set y2 [lindex $vertices($des) 1]

  set dx2x1 [expr $x2-$x1]
  set dy2y1 [expr $y1-$y2]
  if {$dx2x1==0} \
    {
    set dx 0
    if {$dy2y1>0} {set dy $radius} \
    else {set dy -$radius}
    } \
  else \
    {
    set alpha [expr atan($dy2y1/$dx2x1)]
    set dx [expr $radius*cos($alpha)]
    set dy [expr $radius*sin($alpha)]
    }
  if {$dx2x1<0} \
    {
    set dx [expr $dx*(-1)]
    set dy [expr $dy*(-1)]
    }
  return "[expr $x1+$dx] [expr $y1-$dy] [expr $x2-$dx] [expr $y2+$dy]"
  }

proc Build_Straight {i} {

  global edges_id arrow_shape arrow_scale

  set arrow_shape_tmp "[expr [lindex $arrow_shape 0]*$arrow_scale($i)] \
                      [expr [lindex $arrow_shape 1]*$arrow_scale($i)] \
                      [expr [lindex $arrow_shape 2]*$arrow_scale($i)]"
  set coords [Compute_Straight $i]
  set id [.canvas create line [lindex $coords 0] [lindex $coords 1] \
                              [lindex $coords 2] [lindex $coords 3] \
	      -arrow last \
              -arrowshape $arrow_shape_tmp \
              -tag straight]
  set edges_id($i) $id
  .canvas bind $id <Control-ButtonPress-1> "Modify_Arrow_Scale $i"
  .canvas bind $id <ButtonPress-3> "Transform_Into $i %x %y"
  .canvas bind $id <<MIDDLE_BUTTON>> "Straight_To_Sym_Curve $i %x %y"
  }

proc Draw_Straight {i} {

  global edges_id

  set coords [Compute_Straight $i]
  .canvas coords $edges_id($i) [lindex $coords 0] [lindex $coords 1] \
                               [lindex $coords 2] [lindex $coords 3] 
  }

proc Straight_To_Sym_Curve {i cx cy} {

  global edges_id edges vertices edges_type labels labels_id
  global num_spline_steps visu_labels

  .canvas delete $edges_id($i)
  catch {.canvas delete $labels_id($i)}

  set x [.canvas canvasx $cx]
  set y [.canvas canvasy $cy]

  set ori [lindex $edges($i) 0]
  set des [lindex $edges($i) 1]
  set dx [expr [lindex $vertices($ori) 0]-$x]
  set dy [expr [lindex $vertices($ori) 1]-$y]
  set d_ori [expr $dx*$dx+$dy*$dy]
  set dx [expr [lindex $vertices($des) 0]-$x]
  set dy [expr [lindex $vertices($des) 1]-$y]
  set d_des [expr $dx*$dx+$dy*$dy]
  if {$d_ori<$d_des} {Move_Sym_Curve $x $y ori $i 1} \
  else {Move_Sym_Curve $x $y des $i 1}
  set edges_type($i) sym_curve
  set labels($i,1) [expr $labels($i,1)*$num_spline_steps]
  Build_Sym_Curve $i
  Create_Sym_Curve_Control $i
  if {$visu_labels} {Build_Label $i}
  }

proc Compute_Loop {i} {

  global radius loop_const
  global vertices edges

  set ori [lindex $edges($i) 0]
  set x1 [lindex $vertices($ori) 0]
  set y1 [lindex $vertices($ori) 1]

  set rho [lindex $edges($i) 2]
  set theta [expr $loop_const/$rho]
  set alpha [lindex $edges($i) 3]

  set angle [expr $alpha+$theta]
  set sin [expr sin($angle)]
  set cos [expr cos($angle)]
  set dx1 [expr $cos*$radius]
  set dy1 [expr $sin*$radius]
  set dx2 [expr $cos*$rho]
  set dy2 [expr $sin*$rho]
  set angle [expr $alpha-$theta]
  set sin [expr sin($angle)]
  set cos [expr cos($angle)] 
  set dx4 [expr $cos*$radius]
  set dy4 [expr $sin*$radius]
  set dx3 [expr $cos*$rho]
  set dy3 [expr $sin*$rho]
  return "[expr $x1+$dx1] [expr $y1-$dy1] [expr $x1+$dx2] [expr $y1-$dy2] \
          [expr $x1+$dx3] [expr $y1-$dy3] [expr $x1+$dx4] [expr $y1-$dy4]"
  }

proc Build_Loop {i} {

  global edges_id arrow_shape arrow_scale

  set arrow_shape_tmp "[expr [lindex $arrow_shape 0]*$arrow_scale($i)] \
                      [expr [lindex $arrow_shape 1]*$arrow_scale($i)] \
                      [expr [lindex $arrow_shape 2]*$arrow_scale($i)]"
  set coords [Compute_Loop $i]
  set id [.canvas create line [lindex $coords 0] [lindex $coords 1] \
                              [lindex $coords 2] [lindex $coords 3] \
                              [lindex $coords 4] [lindex $coords 5] \
                              [lindex $coords 6] [lindex $coords 7] \
              -arrow last \
              -arrowshape $arrow_shape_tmp \
              -smooth  1 \
              -tag loop]
  set edges_id($i) $id
  .canvas bind $id <Control-ButtonPress-1> "Modify_Arrow_Scale $i"
  .canvas bind $id <ButtonPress-1> "Create_Loop_Control $i"
  .canvas bind $id <<MIDDLE_BUTTON>> "Loop_To_Sym_Curve $i"
  .canvas bind $id <ButtonPress-3> "Transform_Into $i %x %y"
  }

proc Draw_Loop {i} {

  global edges_id edges_control

  set coords [Compute_Loop $i]
  .canvas coords $edges_id($i) [lindex $coords 0] [lindex $coords 1] \
                               [lindex $coords 2] [lindex $coords 3] \
                               [lindex $coords 4] [lindex $coords 5] \
                               [lindex $coords 6] [lindex $coords 7]

  if {![catch {set  control $edges_control($i)}]} \
    {
    global vertices edges 
    global radius

    set ori [lindex $edges($i) 0]
    set x1 [lindex $vertices($ori) 0]
    set y1 [lindex $vertices($ori) 1]

    set rho [lindex $edges($i) 2]
    set alpha [lindex $edges($i) 3]

    set sin [expr sin($alpha)]
    set cos [expr cos($alpha)]
    set dx1 [expr $cos*$radius]
    set dy1 [expr $sin*$radius]
    set dx2 [expr $cos*$rho]
    set dy2 [expr $sin*$rho]
    set x2 [expr $x1+$dx2]
    set y2 [expr $y1-$dy2]
    .canvas coords [lindex $control 0] [expr $x1+$dx1] [expr $y1-$dy1] \
                                       $x2 $y2
    .canvas coords [lindex $control 1] [expr $x2-4] [expr $y2-4] \
                                       [expr $x2+4] [expr $y2+4]
    }
  }

proc Create_Loop_Control {i} {

  global radius
  global vertices edges edges_control labels_t
  global visu_labels

  if {![catch {set void $edges_control($i)}]} {return}

  if {$visu_labels} {catch {unset labels_t($i,0)}}

  set ori [lindex $edges($i) 0]
  set x1 [lindex $vertices($ori) 0]
  set y1 [lindex $vertices($ori) 1]

  set rho [lindex $edges($i) 2]
  set alpha [lindex $edges($i) 3]

  set sin [expr sin($alpha)]
  set cos [expr cos($alpha)]
  set dx1 [expr $cos*$radius]
  set dy1 [expr $sin*$radius]
  set dx2 [expr $cos*$rho]
  set dy2 [expr $sin*$rho]
  set x2 [expr $x1+$dx2]
  set y2 [expr $y1-$dy2]
  set idc [.canvas create line [expr $x1+$dx1] [expr $y1-$dy1] $x2 $y2 \
               -fill black \
               -stipple gray50 \
               -tag loop_control]
  set idp [.canvas create rectangle [expr $x2-4] [expr $y2-4] \
                                    [expr $x2+4] [expr $y2+4] \
               -fill white \
               -tag loop_control]
  .canvas bind $idp <Button1-Motion> \
      "Move_Loop %x %y $i 0
       Draw_Loop $i
       if [list {$visu_labels}] {Draw_Label $i}"
  .canvas bind $idp <Double-ButtonPress-1> "End_Loop_Control $i"

  set edges_control($i) "$idc $idp"

  .canvas bind $idc <Control-ButtonPress-1> "Modify_Arrow_Scale $i"
  .canvas bind $idp <Control-ButtonPress-1> "Modify_Arrow_Scale $i"
  .canvas bind $idc <<MIDDLE_BUTTON>> "Loop_To_Sym_Curve $i"
  .canvas bind $idp <<MIDDLE_BUTTON>> "Loop_To_Sym_Curve $i"
  .canvas bind $idc <ButtonPress-3> "Transform_Into $i %x %y"
  .canvas bind $idp <ButtonPress-3> "Transform_Into $i %x %y"
  }

proc Move_Loop {x y i not_conv} {

  global grid_activated grid_x_size grid_y_size
  global vertices edges
  global visu_labels graph_mod

  set graph_mod 1

  if {$grid_activated} \
    {
    set x [.canvas canvasx $x $grid_x_size]
    set y [.canvas canvasy $y $grid_y_size]
    } \
  else \
    {
    if {!$not_conv} \
      {
      set x [.canvas canvasx $x]
      set y [.canvas canvasy $y]
      }
    } 

  set ori [lindex $edges($i) 0]
  set x1 [lindex $vertices($ori) 0]
  set y1 [lindex $vertices($ori) 1]

  set dx [expr $x-$x1]
  set dy [expr $y1-$y]
  if {$dx==0} \
    { 
    if {$dy<0} {set alpha [expr -3.1416/2]} \
    else {set alpha [expr 3.1416/2]}
    } \
  else \
    {
    if {$dx<0} {set alpha [expr 3.1416+atan($dy/$dx)]} \
    else {set alpha [expr atan($dy/$dx)]}
    }
  set rho [expr sqrt($dx*$dx+$dy*$dy)]
  if {$rho!=0} {set edges($i) "$ori $ori $rho $alpha"}
  }

proc End_Loop_Control {i} {

  global edges_control

  .canvas delete [lindex $edges_control($i) 0]
  .canvas delete [lindex $edges_control($i) 1]
  unset edges_control($i)
  }

proc Loop_To_Sym_Curve {i} {

  global edges_id edges_control edges_type
  global visu_labels labels_id

  .canvas delete $edges_id($i)
  catch {.canvas delete $labels_id($i)}

  if {![catch {set void $edges_control($i)}]} \
    {End_Loop_Control $i}
  set coords [Compute_Loop $i]
  Move_Sym_Curve [lindex $coords 2] [lindex $coords 3] ori $i 1
  set edges_type($i) sym_curve
  Build_Sym_Curve $i
  Create_Sym_Curve_Control $i
  if {$visu_labels} {Build_Label $i}
  }
proc Compute_Sym_Curve {i} {

  global radius
  global vertices edges

  set ori [lindex $edges($i) 0]
  set x1 [lindex $vertices($ori) 0]
  set y1 [lindex $vertices($ori) 1]

  set des [lindex $edges($i) 1]
  set x2 [lindex $vertices($des) 0]
  set y2 [lindex $vertices($des) 1]

  set rho [lindex $edges($i) 2]
  set theta [lindex $edges($i) 3]
  set dx2x1 [expr $x2-$x1]
  set dy2y1 [expr $y1-$y2]
  if {$dx2x1==0} \
    {
    if {$dy2y1<=0} {set alpha [expr -3.1416/2]} \
    else {set alpha [expr 3.1416/2]}
    } \
  else {set alpha [expr atan($dy2y1/$dx2x1)]}
  if {$dx2x1<0} {set alpha [expr $alpha*(-1)]}
  set angle [expr $theta+$alpha]
  set sin [expr sin($angle)]
  set cos [expr cos($angle)] 
  set dx1 [expr $cos*$radius]
  set dy1 [expr $sin*$radius]
  set dx2 [expr $cos*$rho]
  set dy2 [expr $sin*$rho]

  set angle [expr $theta-$alpha]
  set sin [expr sin($angle)]
  set cos [expr cos($angle)] 
  set dx3 [expr $cos*$rho]
  set dy3 [expr $sin*$rho]
  set dx4 [expr $cos*$radius]
  set dy4 [expr $sin*$radius]
  if {$dx2x1<0} \
    {
    set dx1 [expr $dx1*(-1)]
    set dx2 [expr $dx2*(-1)]
    set dx3 [expr $dx3*(-1)]
    set dx4 [expr $dx4*(-1)]
    }
  return "[expr $x1+$dx1] [expr $y1-$dy1] [expr $x1+$dx2] [expr $y1-$dy2] \
          [expr $x2-$dx3] [expr $y2-$dy3] [expr $x2-$dx4] [expr $y2-$dy4]"
  }

proc Build_Sym_Curve {i} {

  global edges_id arrow_shape edges arrow_scale

  set coords [Compute_Sym_Curve $i]
  set arrow_shape_tmp "[expr [lindex $arrow_shape 0]*$arrow_scale($i)] \
                      [expr [lindex $arrow_shape 1]*$arrow_scale($i)] \
                      [expr [lindex $arrow_shape 2]*$arrow_scale($i)]"
  set id [.canvas create line [lindex $coords 0] [lindex $coords 1] \
                              [lindex $coords 2] [lindex $coords 3] \
                              [lindex $coords 4] [lindex $coords 5] \
                              [lindex $coords 6] [lindex $coords 7] \
              -arrow last \
              -arrowshape $arrow_shape_tmp \
              -smooth 1 \
              -tag sym_curve]
  set edges_id($i) $id
  .canvas bind $id <Control-ButtonPress-1> "Modify_Arrow_Scale $i"
  .canvas bind $id <ButtonPress-1> "Create_Sym_Curve_Control $i"
  set ori [lindex $edges($i) 0]
  set des [lindex $edges($i) 1]  
  if {$ori==$des} \
    {
    .canvas bind $id <<MIDDLE_BUTTON>> "Sym_Curve_To_Loop $i"
    } \
  else \
    {
    .canvas bind $id <<MIDDLE_BUTTON>> "Sym_Curve_To_Straight $i"
    }
  .canvas bind $id <ButtonPress-3> "Transform_Into $i %x %y"
  }

proc Draw_Sym_Curve {i} {

  global edges_id edges_control

  set coords [Compute_Sym_Curve $i]
  set x2 [lindex $coords 2]
  set y2 [lindex $coords 3]
  set x3 [lindex $coords 4]
  set y3 [lindex $coords 5]
  .canvas coords $edges_id($i) [lindex $coords 0] [lindex $coords 1] \
                               $x2 $y2 $x3 $y3 \
                               [lindex $coords 6] [lindex $coords 7] 

  if {![catch {set control $edges_control($i)}]} \
    {
    .canvas coords [lindex $control 0] \
                   [lindex $coords 0] [lindex $coords 1] $x2 $y2 $x3 $y3 \
                   [lindex $coords 6] [lindex $coords 7] 
    .canvas coords [lindex $control 1] [expr $x2-4] [expr $y2-4] \
                                       [expr $x2+4] [expr $y2+4] 
    .canvas coords [lindex $control 2] [expr $x3-4] [expr $y3-4] \
                                       [expr $x3+4] [expr $y3+4] 
    }
  }

proc Create_Sym_Curve_Control {i} {

  global edges_id edges_control labels_t edges
  global visu_labels 

  if {![catch {set void $edges_control($i)}]} {return}

  if {$visu_labels} {catch {unset labels_t($i,0)}}

  set coords [.canvas coords $edges_id($i)]
  set x2 [lindex $coords 2]
  set y2 [lindex $coords 3]
  set x3 [lindex $coords 4]
  set y3 [lindex $coords 5]
  set idc [.canvas create line [lindex $coords 0] [lindex $coords 1] \
                               $x2 $y2 $x3 $y3 \
                               [lindex $coords 6] [lindex $coords 7] \
               -fill black \
               -stipple gray50 \
               -tag sym_curve_control]
  set idp1 [.canvas create rectangle [expr $x2-4] [expr $y2-4] \
                                     [expr $x2+4] [expr $y2+4] \
               -fill white \
               -tag sym_curve_control]
  set idp2 [.canvas create rectangle [expr $x3-4] [expr $y3-4] \
                                     [expr $x3+4] [expr $y3+4] \
                -fill white \
               -tag sym_curve_control]
  .canvas bind $idp1 <Button1-Motion> \
      "Move_Sym_Curve %x %y ori $i 0
       Draw_Sym_Curve $i
       if [list {$visu_labels}] {Draw_Label $i}"
  .canvas bind $idp2 <Button1-Motion> \
      "Move_Sym_Curve %x %y des $i 0
       Draw_Sym_Curve $i
       if [list {$visu_labels}] {Draw_Label $i}"
  .canvas bind $idp1 <Double-ButtonPress-1> "End_Sym_Curve_Control $i"
  .canvas bind $idp2 <Double-ButtonPress-1> "End_Sym_Curve_Control $i"

  set edges_control($i) "$idc $idp1 $idp2"

  .canvas bind $idc <Control-ButtonPress-1> "Modify_Arrow_Scale $i"
  .canvas bind $idp1 <Control-ButtonPress-1> "Modify_Arrow_Scale $i"
  .canvas bind $idp2 <Control-ButtonPress-1> "Modify_Arrow_Scale $i"
  set ori [lindex $edges($i) 0]
  set des [lindex $edges($i) 1]  
  if {$ori==$des} \
    {
    .canvas bind $idc <<MIDDLE_BUTTON>> "Sym_Curve_To_Loop $i"
    .canvas bind $idp1 <<MIDDLE_BUTTON>> "Sym_Curve_To_Loop $i"
    .canvas bind $idp2 <<MIDDLE_BUTTON>> "Sym_Curve_To_Loop $i"
    } \
  else \
    {
    .canvas bind $idc <<MIDDLE_BUTTON>> "Sym_Curve_To_Straight $i"
    .canvas bind $idp1 <<MIDDLE_BUTTON>> "Sym_Curve_To_Straight $i"
    .canvas bind $idp2 <<MIDDLE_BUTTON>> "Sym_Curve_To_Straight $i"
    }  
  .canvas bind $idc <ButtonPress-3> "Transform_Into $i %x %y"
  .canvas bind $idp1 <ButtonPress-3> "Transform_Into $i %x %y"
  .canvas bind $idp2 <ButtonPress-3> "Transform_Into $i %x %y"
  }

proc Move_Sym_Curve {x y pos i not_conv} {

  global grid_activated grid_x_size grid_y_size
  global vertices edges graph_mod

  set new_pos [eval Compute_New_Visible_Position $x $y 0]
  set new_x [lindex $new_pos 0]
  set new_y [lindex $new_pos 1]

  set graph_mod 1

  if {$grid_activated} \
    {
    set x [.canvas canvasx $new_x $grid_x_size]
    set y [.canvas canvasy $new_y $grid_y_size]
    } \
  else \
    {
    if {!$not_conv} \
      {
      set x [.canvas canvasx $new_x]
      set y [.canvas canvasy $new_y]
      }
    } 

  set ori [lindex $edges($i) 0]
  set x1 [lindex $vertices($ori) 0]
  set y1 [lindex $vertices($ori) 1]

  set des [lindex $edges($i) 1]
  set x2 [lindex $vertices($des) 0]
  set y2 [lindex $vertices($des) 1]

  set dx2x1 [expr $x2-$x1]
  set dy2y1 [expr $y1-$y2]
  if {$dx2x1==0} \
    {
    if {$dy2y1<=0} {set alpha [expr -3.1416/2]} \
    else {set alpha [expr 3.1416/2]}
    } \
  else {set alpha [expr atan($dy2y1/$dx2x1)]}
  if {$dx2x1<0} {set alpha [expr $alpha*(-1)]} 
  if {$pos=={ori}} \
    {
    set dx [expr $x-$x1]
    set dy [expr $y1-$y]
    } \
  else \
    {
    set dx [expr $x2-$x]
    set dy [expr $y-$y2]
    }
  if {$dx==0} \
    { 
    if {$dy<0} {set theta [expr -3.1416/2]} \
    else {set theta [expr 3.1416/2]}
    } \
  else \
    {    
    if {$dx2x1>=0} \
      {
      if {$dx<0} {set theta [expr 3.1416+atan($dy/$dx)]} \
      else {set theta [expr atan($dy/$dx)]}
      } \
    else \
      {
      if {$dx<0} {set theta [expr -atan($dy/$dx)]} \
      else {set theta [expr 3.1416-atan($dy/$dx)]}
      }
    }
  set rho [expr sqrt($dx*$dx+$dy*$dy)]
  if {$pos=={ori}} {set edges($i) "$ori $des $rho [expr $theta-$alpha]"} \
  else {set edges($i) "$ori $des $rho [expr -$theta+$alpha]"}
  }

proc End_Sym_Curve_Control {i} {

  global edges_control

  .canvas delete [lindex $edges_control($i) 0]
  .canvas delete [lindex $edges_control($i) 1]
  .canvas delete [lindex $edges_control($i) 2]
  unset edges_control($i)
  }

proc Sym_Curve_To_Straight {i} {

  global edges_id edges_control edges_type labels
  global num_spline_steps visu_labels labels_id

  .canvas delete $edges_id($i)
  catch {.canvas delete $labels_id($i)}

  if {![catch {set void $edges_control($i)}]} \
    {End_Sym_Curve_Control $i}
  set edges_type($i) straight
  set labels($i,1) [expr double($labels($i,1))/$num_spline_steps]
  Build_Straight $i
  if {$visu_labels} {Build_Label $i}
  }

proc Sym_Curve_To_Loop {i} {

  global edges_id edges_control edges_type
  global visu_labels labels_id

  .canvas delete $edges_id($i)
  catch {.canvas delete $labels_id($i)}

  if {![catch {set void $edges_control($i)}]} \
    {End_Sym_Curve_Control $i}
  set coords [Compute_Sym_Curve $i]
  set x2 [lindex $coords 2]
  set y2 [lindex $coords 3]
  set x3 [lindex $coords 4]
  set y3 [lindex $coords 5]          
  Move_Loop [expr ($x2+$x3)/2.0] [expr ($y2+$y3)/2.0] $i 1
  set edges_type($i) loop
  Build_Loop $i
  Create_Loop_Control $i
  if {$visu_labels} {Build_Label $i}
  }
proc Compute_Asym_Curve {i} {

  global radius
  global vertices edges

  set ori [lindex $edges($i) 0]
  set x1 [lindex $vertices($ori) 0]
  set y1 [lindex $vertices($ori) 1]
  set x2 [lindex $edges($i) 2]
  set y2 [lindex $edges($i) 3]
  set x3 [lindex $edges($i) 4]
  set y3 [lindex $edges($i) 5]
  set des [lindex $edges($i) 1]
  set x4 [lindex $vertices($des) 0]
  set y4 [lindex $vertices($des) 1]

  set dx [expr $x2-$x1]
  set dy [expr $y1-$y2]
  if {$dx==0} \
    { 
    if {$dy<0} {set theta [expr -3.1416/2]} \
    else {set theta [expr 3.1416/2]}
    } \
  else \
    {    
    if {$x4>=$x1} \
      {
      if {$dx<0} {set theta [expr 3.1416+atan($dy/$dx)]} \
      else {set theta [expr atan($dy/$dx)]}
      } \
    else \
      {
      if {$dx<0} {set theta [expr -atan($dy/$dx)]} \
      else {set theta [expr 3.1416-atan($dy/$dx)]}
      }
    }
  set dx1 [expr cos($theta)*$radius]
  set dy1 [expr sin($theta)*$radius]

  set dx [expr $x4-$x3]
  set dy [expr $y3-$y4]
  if {$dx==0} \
    { 
    if {$dy<0} {set theta [expr -3.1416/2]} \
    else {set theta [expr 3.1416/2]}
    } \
  else \
    {    
    if {$x4>=$x1} \
      {
      if {$dx<0} {set theta [expr 3.1416+atan($dy/$dx)]} \
      else {set theta [expr atan($dy/$dx)]}
      } \
    else \
      {
      if {$dx<0} {set theta [expr -atan($dy/$dx)]} \
      else {set theta [expr 3.1416-atan($dy/$dx)]}
      }
    }
  set dx4 [expr cos($theta)*$radius]
  set dy4 [expr sin($theta)*$radius]
  if {$x4<$x1} \
    {
    set dx1 [expr $dx1*(-1)]
    set dx4 [expr $dx4*(-1)]
    }
  return "[expr $x1+$dx1] [expr $y1-$dy1] \
          $x2 $y2 $x3 $y3 \
          [expr $x4-$dx4] [expr $y4+$dy4]"
  }

proc Build_Asym_Curve {i} {

  global edges_id arrow_shape edges arrow_scale

  set arrow_shape_tmp "[expr [lindex $arrow_shape 0]*$arrow_scale($i)] \
                      [expr [lindex $arrow_shape 1]*$arrow_scale($i)] \
                      [expr [lindex $arrow_shape 2]*$arrow_scale($i)]"
  set coords [Compute_Asym_Curve $i]
  set id [.canvas create line [lindex $coords 0] [lindex $coords 1] \
                              [lindex $coords 2] [lindex $coords 3] \
                              [lindex $coords 4] [lindex $coords 5] \
                              [lindex $coords 6] [lindex $coords 7] \
              -arrow last \
              -arrowshape $arrow_shape_tmp \
              -smooth 1 \
              -tag Asym_Curve]
  set edges_id($i) $id
  .canvas bind $id <ButtonPress-1> "Create_Asym_Curve_Control $i"
  .canvas bind $id <Control-ButtonPress-1> "Modify_Arrow_Scale $i"
   set ori [lindex $edges($i) 0]
  set des [lindex $edges($i) 1]  
  if {$ori==$des} \
    {
    .canvas bind $id <<MIDDLE_BUTTON>> "Asym_Curve_To_Loop $i"
    } \
  else \
    {
    .canvas bind $id <<MIDDLE_BUTTON>> "Asym_Curve_To_Straight $i"
    }
  .canvas bind $id <ButtonPress-3> "Transform_Into $i %x %y"
  }

proc Draw_Asym_Curve {i} {

  global edges_id edges_control

  set coords [Compute_Asym_Curve $i]
  set x2 [lindex $coords 2]
  set y2 [lindex $coords 3]
  set x3 [lindex $coords 4]
  set y3 [lindex $coords 5]
  .canvas coords $edges_id($i) [lindex $coords 0] [lindex $coords 1] \
                               $x2 $y2 $x3 $y3 \
                               [lindex $coords 6] [lindex $coords 7] 

  if {![catch {set control $edges_control($i)}]} \
    {
    .canvas coords [lindex $control 0] \
                   [lindex $coords 0] [lindex $coords 1] $x2 $y2 $x3 $y3 \
                   [lindex $coords 6] [lindex $coords 7] 
    .canvas coords [lindex $control 1] [expr $x2-4] [expr $y2-4] \
                                       [expr $x2+4] [expr $y2+4] 
    .canvas coords [lindex $control 2] [expr $x3-4] [expr $y3-4] \
                                       [expr $x3+4] [expr $y3+4] 
    }
  }

proc Create_Asym_Curve_Control {i} {

  global edges_id edges_control labels_t edges
  global visu_labels

  if {![catch {set void $edges_control($i)}]} {return}

  if {$visu_labels} {catch {unset labels_t($i,0)}}

  set coords [.canvas coords $edges_id($i)]
  set x2 [lindex $coords 2]
  set y2 [lindex $coords 3]
  set x3 [lindex $coords 4]
  set y3 [lindex $coords 5]
  set idc [.canvas create line [lindex $coords 0] [lindex $coords 1] \
                               $x2 $y2 $x3 $y3 \
                               [lindex $coords 6] [lindex $coords 7] \
               -fill black \
               -stipple gray50 \
               -tag asym_curve_control]
  set idp1 [.canvas create rectangle [expr $x2-4] [expr $y2-4] \
                                     [expr $x2+4] [expr $y2+4] \
               -fill white \
               -tag asym_curve_control]
  set idp2 [.canvas create rectangle [expr $x3-4] [expr $y3-4] \
                                     [expr $x3+4] [expr $y3+4] \
               -fill white \
               -tag asym_curve_control]
  .canvas bind $idp1 <Button1-Motion> \
      "Move_Asym_Curve %x %y ori $i 0
       Draw_Asym_Curve $i
       if [list {$visu_labels}] {Draw_Label $i}"
  .canvas bind $idp2 <Button1-Motion> \
      "Move_Asym_Curve %x %y des $i 0
       Draw_Asym_Curve $i
       if [list {$visu_labels}] {Draw_Label $i}"
  .canvas bind $idp1 <Double-ButtonPress-1> "End_Asym_Curve_Control $i"
  .canvas bind $idp2 <Double-ButtonPress-1> "End_Asym_Curve_Control $i"

  set edges_control($i) "$idc $idp1 $idp2"

  .canvas bind $idc <Control-ButtonPress-1> "Modify_Arrow_Scale $i"
  .canvas bind $idp1 <Control-ButtonPress-1> "Modify_Arrow_Scale $i"
  .canvas bind $idp2 <Control-ButtonPress-1> "Modify_Arrow_Scale $i"
  set ori [lindex $edges($i) 0]
  set des [lindex $edges($i) 1]  
  if {$ori==$des} \
    {
    .canvas bind $idc <<MIDDLE_BUTTON>> "Asym_Curve_To_Loop $i"
    .canvas bind $idp1 <<MIDDLE_BUTTON>> "Asym_Curve_To_Loop $i"
    .canvas bind $idp2 <<MIDDLE_BUTTON>> "Asym_Curve_To_Loop $i"
    } \
  else \
    {
    .canvas bind $idc <<MIDDLE_BUTTON>> "Asym_Curve_To_Straight $i"
    .canvas bind $idp1 <<MIDDLE_BUTTON>> "Asym_Curve_To_Straight $i"
    .canvas bind $idp2 <<MIDDLE_BUTTON>> "Asym_Curve_To_Straight $i"
    }
  .canvas bind $idc <ButtonPress-3> "Transform_Into $i %x %y"
  .canvas bind $idp1 <ButtonPress-3> "Transform_Into $i %x %y"
  .canvas bind $idp2 <ButtonPress-3> "Transform_Into $i %x %y"
  }

proc Move_Asym_Curve {x y pos i not_conv} {

  global grid_activated grid_x_size grid_y_size
  global edges graph_mod

  set new_pos [eval Compute_New_Visible_Position $x $y 0]
  set new_x [lindex $new_pos 0]
  set new_y [lindex $new_pos 1]

  set graph_mod 1

  if {$grid_activated} \
    {
    set x [.canvas canvasx $new_x $grid_x_size]
    set y [.canvas canvasy $new_y $grid_y_size]
    } \
  else \
    {
    if {!$not_conv} \
      {
      set x [.canvas canvasx $new_x]
      set y [.canvas canvasy $new_y]
      }
    } 
  if {$pos=={ori}} \
    {
    set edges($i) "[lindex $edges($i) 0] [lindex $edges($i) 1] \
                   $x $y [lindex $edges($i) 4] [lindex $edges($i) 5]" 
    } \
  else \
    {
    set edges($i) "[lindex $edges($i) 0] [lindex $edges($i) 1] \
                   [lindex $edges($i) 2] [lindex $edges($i) 3] $x $y" 
    }
  }

proc End_Asym_Curve_Control {i} {

  global edges_control

  .canvas delete [lindex $edges_control($i) 0]
  .canvas delete [lindex $edges_control($i) 1]
  .canvas delete [lindex $edges_control($i) 2]
  unset edges_control($i)
  }

proc Asym_Curve_To_Straight {i} {

  global edges_id edges_control edges_type labels
  global num_spline_steps visu_labels labels_id

  .canvas delete $edges_id($i)
  catch {.canvas delete $labels_id($i)}

  if {![catch {set void $edges_control($i)}]} \
    {End_Asym_Curve_Control $i}
  set edges_type($i) straight
  set labels($i,1) [expr double($labels($i,1))/$num_spline_steps]
  Build_Straight $i
  if {$visu_labels} {Build_Label $i}
  }

proc Asym_Curve_To_Loop {i} {

  global edges_id edges_control edges_type
  global visu_labels

  .canvas delete $edges_id($i)
  catch {.canvas delete $labels_id($i)}

  if {![catch {set void $edges_control($i)}]} \
    {End_Asym_Curve_Control $i}
  set coords [Compute_Asym_Curve $i]
  set x2 [lindex $coords 2]
  set y2 [lindex $coords 3]
  set x3 [lindex $coords 4]
  set y3 [lindex $coords 5]     
  Move_Loop [expr ($x2+$x3)/2.0] [expr ($y2+$y3)/2.0] $i 1
  set edges_type($i) loop
  Build_Loop $i
  Create_Loop_Control $i
  if {$visu_labels} {Build_Label $i}
  }
proc Compute_t_Label {i} {

  global labels_t edges_id num_spline_steps

  set coords [.canvas coords $edges_id($i)]
  set x0 [lindex $coords 0]
  set y0 [lindex $coords 1]
  set x1 [lindex $coords 2]
  set y1 [lindex $coords 3]
  set x2 [lindex $coords 4]
  set y2 [lindex $coords 5]
  set x3 [lindex $coords 6]
  set y3 [lindex $coords 7]

  set c0 $x0
  set c1 $y0
  set c2 [expr 0.333*$x0+0.667*$x1]
  set c3 [expr 0.333*$y0+0.667*$y1]
  set c4 [expr 0.833*$x1+0.167*$x2]
  set c5 [expr 0.833*$y1+0.167*$y2]
  set c6 [expr 0.5*$x1+0.5*$x2]
  set c7 [expr 0.5*$y1+0.5*$y2]
  set num_steps [expr $num_spline_steps/2]
  set n 1
  while {$n<=$num_steps} \
    {
    set t [expr double($n)/double($num_steps)]
    set t2 [expr $t*$t]
    set t3 [expr $t2*$t]
    set u [expr 1.0-$t]
    set u2 [expr $u*$u]
    set u3 [expr $u2*$u]
    set labels_t($i,[expr $n-1]) \
        "[expr $c0*$u3+3.0*($c2*$t*$u2+$c4*$t2*$u)+$c6*$t3] \
         [expr $c1*$u3+3.0*($c3*$t*$u2+$c5*$t2*$u)+$c7*$t3]"
    incr n
    }
  set c0 [expr 0.5*$x1+0.5*$x2]
  set c1 [expr 0.5*$y1+0.5*$y2]
  set c2 [expr 0.167*$x1+0.833*$x2]
  set c3 [expr 0.167*$y1+0.833*$y2]
  set c4 [expr 0.667*$x2+0.333*$x3]
  set c5 [expr 0.667*$y2+0.333*$y3]
  set c6 $x3
  set c7 $y3
  set n 1
  while {$n<=$num_steps} \
    {
    set t [expr double($n)/double($num_steps)]
    set t2 [expr $t*$t]
    set t3 [expr $t2*$t]
    set u [expr 1.0-$t]
    set u2 [expr $u*$u]
    set u3 [expr $u2*$u]
    set labels_t($i,[expr $num_steps+$n-1]) \
        "[expr $c0*$u3+3.0*($c2*$t*$u2+$c4*$t2*$u)+$c6*$t3] \
         [expr $c1*$u3+3.0*($c3*$t*$u2+$c5*$t2*$u)+$c7*$t3]"
    incr n
    }
  }

proc Compute_Spline_Label {i t} {

  global edges_id num_spline_steps

  set coords [.canvas coords $edges_id($i)]
  set x0 [lindex $coords 0]
  set y0 [lindex $coords 1]
  set x1 [lindex $coords 2]
  set y1 [lindex $coords 3]
  set x2 [lindex $coords 4]
  set y2 [lindex $coords 5]
  set x3 [lindex $coords 6]
  set y3 [lindex $coords 7]
  set num_steps [expr $num_spline_steps/2]
  if {$t<$num_steps} \
    {
    set c0 $x0
    set c1 $y0
    set c2 [expr 0.333*$x0+0.667*$x1]
    set c3 [expr 0.333*$y0+0.667*$y1]
    set c4 [expr 0.833*$x1+0.167*$x2]
    set c5 [expr 0.833*$y1+0.167*$y2]
    set c6 [expr 0.5*$x1+0.5*$x2]
    set c7 [expr 0.5*$y1+0.5*$y2]
    set t [expr double($t)/double($num_steps)]
    set t2 [expr $t*$t]
    set t3 [expr $t2*$t]
    set u [expr 1.0-$t]
    set u2 [expr $u*$u]
    set u3 [expr $u2*$u]
    } \
  else \
    {
    set c0 [expr 0.5*$x1+0.5*$x2]
    set c1 [expr 0.5*$y1+0.5*$y2]
    set c2 [expr 0.167*$x1+0.833*$x2]
    set c3 [expr 0.167*$y1+0.833*$y2]
    set c4 [expr 0.667*$x2+0.333*$x3]
    set c5 [expr 0.667*$y2+0.333*$y3]
    set c6 $x3
    set c7 $y3
    set t [expr double($t-$num_steps)/double($num_steps)]
    set t2 [expr $t*$t]
    set t3 [expr $t2*$t]
    set u [expr 1.0-$t]
    set u2 [expr $u*$u]
    set u3 [expr $u2*$u]
    }
  return "[expr $c0*$u3+3.0*($c2*$t*$u2+$c4*$t2*$u)+$c6*$t3] \
          [expr $c1*$u3+3.0*($c3*$t*$u2+$c5*$t2*$u)+$c7*$t3]"
  }

proc Compute_Straight_Label {i} {

  global edges_id labels

  set coord [.canvas coord $edges_id($i)]
  set x1 [lindex $coord 0]
  set y1 [lindex $coord 1]
  set x2 [lindex $coord 2]
  set y2 [lindex $coord 3]

  set dx2x1 [expr $x2-$x1]
  set dy2y1 [expr $y1-$y2]
  set d1 [expr sqrt($dx2x1*$dx2x1+$dy2y1*$dy2y1)*$labels($i,1)]
  if {$dx2x1==0} \
    {
    set dx 0
    if {$dy2y1<0} {set dy [expr -$d1]} \
    else {set dy $d1}
    } \
  else \
    {
    set alpha [expr atan($dy2y1/$dx2x1)]
    set dx [expr $d1*cos($alpha)]
    set dy [expr $d1*sin($alpha)]
    }
  if {$dx2x1<0} \
    {
    set dx [expr $dx*(-1)]
    set dy [expr $dy*(-1)]
    }
  return "[expr $x1+$dx] [expr $y1-$dy]"
  }

proc Compute_Straight_Ratio {i x y} {

  global edges_id labels_t

  set coord [.canvas coord $edges_id($i)]
  set x1 [lindex $coord 0]
  set y1 [lindex $coord 1]
  set x2 [lindex $coord 2]
  set y2 [lindex $coord 3]

  set dx2x1 [expr $x2-$x1]
  set dy2y1 [expr $y1-$y2]
  set dx [expr $x-$x1]
  set dy [expr $y1-$y]
  set t [expr (($dx*$dx2x1)+($dy*$dy2y1))/($dx2x1*$dx2x1+$dy2y1*$dy2y1)]
  if {$t<0} {set t 0.0} \
  else \
    {
    if {$t>1.0} {set t 1.0}
    }
  return $t
  }

proc Search_Closest_t {i xl yl} {

  global num_spline_steps labels_t

  set min_t 0
  set coords $labels_t($i,0)
  set dx [expr [lindex $coords 0]-$xl]
  set dy [expr [lindex $coords 1]-$yl]
  set min_d [expr $dx*$dx+$dy*$dy]
  set t 1
  while {$t<$num_spline_steps} \
    { 
    set coords $labels_t($i,$t)
    set dx [expr [lindex $coords 0]-$xl]
    set dy [expr [lindex $coords 1]-$yl]
    set d [expr $dx*$dx+$dy*$dy]
    if {$d<$min_d} \
      {
      set min_d $d
      set min_t $t
      }
    incr t
    }
  return $min_t
  }

proc Build_Label {i} {

  global labels labels_id edges_type edges

  set ori [lindex $edges($i) 0]
  set des [lindex $edges($i) 1]  
  switch $edges_type($i) \
    {
    straight
      {   
      set coords [Compute_Straight_Label $i]
      set id [.canvas create text [lindex $coords 0] [lindex $coords 1] \
          -text $labels($i,0)]
      .canvas bind $id <Control-ButtonPress-1> "Modify_Arrow_Scale $i"
      .canvas bind $id <<MIDDLE_BUTTON>> "Straight_To_Sym_Curve $i %x %y"
      }
    sym_curve
      { 
      set coords [Compute_Spline_Label $i $labels($i,1)]
      set id [.canvas create text [lindex $coords 0] [lindex $coords 1] \
          -text $labels($i,0)]
      .canvas bind $id <Control-ButtonPress-1> "Modify_Arrow_Scale $i"
      if {$ori==$des} \
        {
        .canvas bind $id <<MIDDLE_BUTTON>> "Sym_Curve_To_Loop $i"
        } \
      else \
        {
        .canvas bind $id <<MIDDLE_BUTTON>> "Sym_Curve_To_Straight $i"
        } 
      }
    asym_curve
      {
      set coords [Compute_Spline_Label $i $labels($i,1)]
      set id [.canvas create text [lindex $coords 0] [lindex $coords 1] \
          -text $labels($i,0)]
      .canvas bind $id <<MIDDLE_BUTTON>> "Asym_Curve_To_Straight $i"
      .canvas bind $id <Control-ButtonPress-1> "Modify_Arrow_Scale $i"
      if {$ori==$des} \
        {
        .canvas bind $id <<MIDDLE_BUTTON>> "Asym_Curve_To_Loop $i"
        } \
      else \
        {
        .canvas bind $id <<MIDDLE_BUTTON>> "Asym_Curve_To_Straight $i"
        }
      }
    loop
      {
      set coords [Compute_Spline_Label $i $labels($i,1)]
      set id [.canvas create text [lindex $coords 0] [lindex $coords 1] \
        -text $labels($i,0)]
      .canvas bind $id <<MIDDLE_BUTTON>> "Loop_To_Sym_Curve $i"
      }
    }
  set labels_id($i) $id
  .canvas bind $id <Button1-Motion> \
      "Move_Label $i %x %y
       Draw_Label $i"
  .canvas bind $id <ButtonPress-3> "Transform_Into $i %x %y"
  }

proc Draw_Label {i} {

  global labels labels_id edges_type

  if {$edges_type($i)=={straight}} \
    {
    set coords [Compute_Straight_Label $i]
    .canvas coords $labels_id($i) [lindex $coords 0] [lindex $coords 1] 
    } \
  else \
    {
    set coords [Compute_Spline_Label $i $labels($i,1)]
    .canvas coords $labels_id($i) [lindex $coords 0] [lindex $coords 1]
    }
  }

proc Move_Label {i x y} {

  global labels labels_t edges_type graph_mod
  global grid_activated grid_x_size grid_y_size

  set graph_mod 1

  if {$grid_activated} \
    {
    set x [.canvas canvasx $x $grid_x_size]
    set y [.canvas canvasy $y $grid_y_size]
    } \
  else \
    {
    set x [.canvas canvasx $x]
    set y [.canvas canvasy $y]
    } 

  if {$edges_type($i)=={straight}} \
    {
    set labels($i,1) [Compute_Straight_Ratio $i $x $y]
    } \
  else \
    {
    if {[catch {set void $labels_t($i,0)}]} {Compute_t_Label $i}
    set t [Search_Closest_t $i $x $y]
    set labels($i,1) $t
    }
  }

proc Get_Dist_Min {} {

  global edges vertices edges_type
  global canvas_x canvas_y radius

  set d_min [expr ($canvas_x-2*$radius)*($canvas_x-2*$radius)]
  foreach i [array names edges] \
    {
    if {$edges_type($i)!={loop}} \
      {
      set ori [lindex $edges($i) 0]
      set des [lindex $edges($i) 1]
      set dx [expr [lindex $vertices($ori) 0]-[lindex $vertices($des) 0]]
      set dy [expr [lindex $vertices($ori) 1]-[lindex $vertices($des) 1]]
      set d_tmp [expr ($dx*$dx)+($dy*$dy)]
      if {$d_tmp<$d_min} {set d_min $d_tmp}
      }
    }
  return [expr sqrt($d_min)]
  }

proc Get_Scale {i} {

  global edges vertices arrow_shape radius

  set ori [lindex $edges($i) 0]
  set des [lindex $edges($i) 1]
  set dx [expr [lindex $vertices($ori) 0]-[lindex $vertices($des) 0]]
  set dy [expr [lindex $vertices($ori) 1]-[lindex $vertices($des) 1]]
  set dist [expr sqrt(($dx*$dx)+($dy*$dy))-2*$radius]
  set a1 [lindex $arrow_shape 0]
  if {[lindex $arrow_shape 0]>$dist} \
    {
    return [expr $dist/(2.0*$a1)]
    } \
  else \
    {
    return 1.0
    }
  }

proc Arrow_Shape_Update {i} {

  global arrow_shape arrow_scale edges_id

  set arrow_shape_tmp \
    "[expr [lindex $arrow_shape 0]*$arrow_scale($i)] \
     [expr [lindex $arrow_shape 1]*$arrow_scale($i)] \
     [expr [lindex $arrow_shape 2]*$arrow_scale($i)]"
  .canvas itemconfigure $edges_id($i) \
    -arrowshape $arrow_shape_tmp
  }

proc Modify_Arrow_Scale {i} {

  proc Arrow_Update {i} {

    global arrow_scale graph_mod

    if {[regexp {[0-9]+(\.[0-9]+)?} [.arrow.e get] match]} \
      {
      set arrow_scale($i) $match
      }
    .arrow.e delete 0 end
    .arrow.e insert 0 $arrow_scale($i)
    }

  catch {destroy .arrow}
  toplevel .arrow
  wm title .arrow "Arrow scale"

  global arrow_scale

  global arrow_scale_tmp 

  set arrow_scale_tmp $arrow_scale($i)

  global borderwidth_size
  frame .arrow.frame_h \
        -borderwidth $borderwidth_size \
        -relief raised
  frame .arrow.frame_button \
        -borderwidth $borderwidth_size \
        -relief raised

  button .arrow.ok \
        -command \
          "
          Arrow_Update $i
          Arrow_Shape_Update $i
	  set graph_mod 1
          destroy .arrow
          " \
        -text Ok
  button .arrow.refresh \
        -command \
          "
          Arrow_Update $i
          Arrow_Shape_Update $i
          " \
        -text {Refresh}
  button .arrow.cancel \
        -command \
          "
          set arrow_scale($i) $arrow_scale_tmp
          Arrow_Shape_Update $i
          destroy .arrow          
          " \
        -text {Cancel}
  label .arrow.text \
        -text {Arrow scale factor}
  entry .arrow.e
  .arrow.e insert 0 $arrow_scale_tmp

  pack .arrow.text .arrow.e \
	-fill x \
        -side top \
        -in .arrow.frame_h
  pack .arrow.ok .arrow.refresh .arrow.cancel \
        -expand 1 \
        -fill x \
        -side left \
        -in .arrow.frame_button
  pack .arrow.frame_h .arrow.frame_button \
        -fill x \
        -side top
  }

proc Make_Menu_Buttons_Disabled_And_Cursor_Watch {} {

    .file_menu configure -state disabled
    .edit_menu configure -state disabled
    .options_menu configure -state disabled
    .help_button configure -state disabled

    . configure -cursor watch 
}

proc Make_Menu_Buttons_Normal_And_Cursor_Pointer {} {

    .file_menu configure -state normal
    .edit_menu configure -state normal
    .options_menu configure -state normal
    .help_button configure -state normal

    . configure -cursor left_ptr
}

set counter_limit 256
set counter_step 16

proc Refresh_Init {} {
  global counter 
  set counter 0
} 

proc Refresh_Update {} {
  global counter counter_limit counter_step
  incr counter 1
  if {($counter < $counter_limit) || (($counter % $counter_step) == 0)} {

        update
  }
}

proc Build_Vertices {} {

  global radius 
  global vertices vertices_id vertices_i vertices_label_id vertices_label_i

  Refresh_Init
  foreach i [array names vertices] \
    {
    set x [lindex $vertices($i) 0]
    set y [lindex $vertices($i) 1]
    set id [.canvas create oval [expr $x-$radius] [expr $y-$radius] \
                                [expr $x+$radius] [expr $y+$radius] \
	        -fill white \
                -tag vertex]
    set idl [.canvas create text $x $y \
                 -tag vertex_label \
                 -text $i]
    set vertices_id($i) $id
    set vertices_i($id) $i
    set vertices_label_id($i) $idl
    set vertices_label_i($idl) $i
    .canvas bind $id <Button1-Motion> \
      "set graph_mod 1
       Move_Vertex $i %x %y"
    .canvas bind $idl <Button1-Motion> \
      "set graph_mod 1
       Move_Vertex $i %x %y"
    Refresh_Update
    }
  }

proc Build_Edges {} {

  global edges edges_type edges_link

  set edges_link(0) {}
  Refresh_Init
  foreach i [array names edges] \
    {
    set ori [lindex $edges($i) 0]
    lappend edges_link($ori) $i
    if {$edges_type($i)!={loop}} \
      {
      set des [lindex $edges($i) 1]
      lappend edges_link($des) $i
      }
    switch $edges_type($i) \
      {
      straight		{Build_Straight $i}
      loop		{Build_Loop $i}
      sym_curve 	{Build_Sym_Curve $i}
      asym_curve 	{Build_Asym_Curve $i}
      }
    Refresh_Update
    }
  }

proc Build_Labels {} {

  global edges

  foreach i [array names edges] {Build_Label $i}
  }

proc Build_Grid {} {

  global canvas_x canvas_dx canvas_y canvas_dy 
  global grid_x_size grid_y_size

  for {set x $canvas_dx} {$x<[expr $canvas_x + $canvas_dx]} {set x [expr $x+$grid_x_size]} \
    {
   .canvas create line $x $canvas_dy $x [expr $canvas_y + $canvas_dy] \
        -fill lightblue -tag grid
    }

  .canvas create line [expr $canvas_x + $canvas_dx] $canvas_dy [expr $canvas_x + $canvas_dx] [expr $canvas_y + $canvas_dy] \
        -fill lightblue -tag grid

  for {set y $canvas_dy} {$y<[expr $canvas_y + $canvas_dy]} {set y [expr $y+$grid_y_size]} \
    {
    .canvas create line $canvas_dx $y [expr $canvas_x + $canvas_dx] $y \
        -fill lightblue -tag grid
    }

  .canvas create line $canvas_dx [expr $canvas_y + $canvas_dy] [expr $canvas_x + $canvas_dx] [expr $canvas_y + $canvas_dy] \
        -fill lightblue -tag grid
}

proc Transform_Into {i x y} {

  global vertices edges_type edge_type 
  global labels_id visu_labels

  set old_type $edges_type($i)
  set edge_type $old_type

  Edge_Window_Initialize $i
  tkwait window .top_edges

  if {$edge_type==$old_type} {return}

  global edges edges_id edges_control num_spline_steps labels

  switch $old_type \
    {
    straight
      {
      switch $edge_type \
        {
        sym_curve {Straight_To_Sym_Curve $i $x $y}
        asym_curve
          {
          .canvas delete $edges_id($i)
          catch {.canvas delete $labels_id($i)}

          Move_Asym_Curve $x $y ori $i 0
          Move_Asym_Curve $x $y des $i 0
          set edges_type($i) asym_curve
          set labels($i,1) [expr $labels($i,1)*$num_spline_steps]
          Build_Asym_Curve $i
          Create_Asym_Curve_Control $i
          if {$visu_labels} {Build_Label $i}
          }
        }
      }
    sym_curve
      {
      switch $edge_type \
        {
        straight {Sym_Curve_To_Straight $i}
        asym_curve
          {
          .canvas delete $edges_id($i)
          catch {.canvas delete $labels_id($i)}

          if {![catch {set void $edges_control($i)}]} \
            {End_Sym_Curve_Control $i}
          set coords [Compute_Sym_Curve $i]
          set x2 [lindex $coords 2]
          set y2 [lindex $coords 3]
          set x3 [lindex $coords 4]
          set y3 [lindex $coords 5]  
          Move_Asym_Curve $x2 $y2 ori $i 1
          Move_Asym_Curve $x3 $y3 des $i 1
          set edges_type($i) asym_curve
          Build_Asym_Curve $i
          Create_Asym_Curve_Control $i
          if {$visu_labels} {Build_Label $i}
          }
        loop {Sym_Curve_To_Loop $i}
        }
      }
    asym_curve
      {
      switch $edge_type \
        {
        straight {Asym_Curve_To_Straight $i}
        sym_curve
          {
          .canvas delete $edges_id($i)
          catch {.canvas delete $labels_id($i)}

          if {![catch {set void $edges_control($i)}]} \
            {End_Asym_Curve_Control $i}
          set coords [Compute_Asym_Curve $i]
          Move_Sym_Curve [lindex $coords 2] [lindex $coords 3] ori $i 1
          set edges_type($i) sym_curve
          Build_Sym_Curve $i
          Create_Sym_Curve_Control $i
          if {$visu_labels} {Build_Label $i}
          }
        loop {Asym_Curve_To_Loop $i}
        }
      }
    loop
      {
      switch $edge_type \
        {
        sym_curve {Loop_To_Sym_Curve $i}
        asym_curve
          {
          .canvas delete $edges_id($i)
          catch {.canvas delete $labels_id($i)}

          if {![catch {set void $edges_control($i)}]} \
            {End_Loop_Control $i}
          set coords [Compute_Loop $i]
          Move_Asym_Curve [lindex $coords 2] [lindex $coords 3] ori $i 1
          Move_Asym_Curve [lindex $coords 4] [lindex $coords 5] des $i 1
          set edges_type($i) asym_curve
          Build_Asym_Curve $i
          Create_Asym_Curve_Control $i
          if {$visu_labels} {Build_Label $i}
          }
        }
      }
    }
  }

proc Refresh {} {

  global canvas_x canvas_y canvas_dx canvas_dy radius
  global visu_mod file_name
  global visu_grid
  global scroll_size
  global file_name
  global borderwidth_size
  global Win_Manager_BorderWidth

  if {$visu_mod != 1} {return}

  wm title . "BCG_EDIT $file_name"

  set max_x [expr $canvas_x+ 2 * $canvas_dx]
  set max_y [expr $canvas_y+ 2 * $canvas_dy]

  wm maxsize . [expr [lindex [split $max_x .] 0] + $scroll_size + 2*$borderwidth_size + 2*$Win_Manager_BorderWidth]  [expr [lindex [split $max_y .] 0] + $scroll_size + 25 + 9 + 2*$borderwidth_size + 2*$Win_Manager_BorderWidth]

  wm minsize . 200 100

  .canvas configure -scrollregion "0 0 [expr $canvas_x+2*$canvas_dx] \
                                       [expr $canvas_y+2*$canvas_dy]"

  foreach item [.canvas find all] {.canvas delete $item}
  .canvas create rectangle $canvas_dx $canvas_dy \
                           [expr $canvas_x+$canvas_dx] \
                           [expr $canvas_y+$canvas_dy] \
			   -fill white

  if {$visu_grid} {Build_Grid}

  if {$file_name != ""} \
    {
    global visu_vertices visu_edges visu_labels 
    global edges_link edges_control

    Make_Menu_Buttons_Disabled_And_Cursor_Watch

    catch {unset edges_link}
    catch {unset edges_control}

    if {$visu_vertices} {Build_Vertices}
    if {$visu_edges} \
      {
      Build_Edges 
      if {$visu_labels} {Build_Labels}
      } \
    else {set visu_labels 0}
    set visu_mod 0

    Make_Menu_Buttons_Normal_And_Cursor_Pointer
   }

  }

proc Delete_Temporary_Files {} { 

    global BCG_EDIT_TMP_VIEW BCG_EDIT_TMP_PRINT

    if [catch {exec rm -f $BCG_EDIT_TMP_VIEW $BCG_EDIT_TMP_PRINT} result_rm] {
          Boite_Dialogue .dialogue {Warning!}\
            "Error when removing temporary files:\n$result_rm" \
	    "OK"
    }
}

set scroll_size 15

set borderwidth_size 1

set Win_Manager_BorderWidth 4

set bounding_box {0 0 595 842}

set radius_point 12
set arrow_shape_point {7 9 3}

set coeff 1.2
set canvas_x [expr ([lindex $bounding_box 2]-[lindex $bounding_box 0])*$coeff]

set canvas_y 650
set radius [expr $radius_point*$coeff]
set arrow_shape "[expr [lindex $arrow_shape_point 0]*$coeff] \
                 [expr [lindex $arrow_shape_point 1]*$coeff] \
                 [expr [lindex $arrow_shape_point 2]*$coeff]"

set canvas_dx 10
set canvas_dy 8

set grid_x_size 20
set grid_y_size 20

set loop_const 40

set select_vertex_list {}
set select_vertex_label_list {}

set visu_vertices 1
set visu_edges 1
set visu_labels 1
set visu_grid 1
set grid_activated 0
set visu_mod 1
set graph_mod 0

set  arrows_auto_scale 1

Main_Window_Initialize
set pixel_per_point [expr [winfo fpixels .canvas 1000.0p]/1000.0]
set point_per_pixel [expr 1000.0/[winfo fpixels .canvas 1000.0p]]

set file_name ""
Refresh

if {$env(BCG_EDIT_INPUT_FILE)!=""} \
 {

   update

   Load $env(BCG_EDIT_INPUT_FILE)

   set visu_mod 1
   Refresh
 }

