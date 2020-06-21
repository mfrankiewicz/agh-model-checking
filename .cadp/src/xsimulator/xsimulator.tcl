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
#   Module		:	xsimulator.tcl
#   Auteur		:	Mark JORGENSEN, Jean-Michel FRUME, H. GARAVEL
#   Version		:	1.3
#   Date		: 	2013/09/04 11:27:15
##############################################################################

global List_label_radio_button
set List_label_radio_button {
   {Radiobutton "0" Xsim_Label_Format 0 1 {caesar_S_assign_label_format_Tcl 0}} 
}

for  {set i 1} {$i <= [caesar_max_format_label_Tcl]} {incr i 1} {
   lappend List_label_radio_button [subst {Radiobutton "$i" Xsim_Label_Format $i 0 {caesar_S_assign_label_format_Tcl $i}}]
   }

global List_state_radio_button
set List_state_radio_button {
   {Radiobutton "0" Xsim_State_Format 0 1 {caesar_S_assign_state_format_Tcl 0}} 
}

for  {set i 1} {$i <= [caesar_max_format_state_Tcl] } {incr i 1} {
   lappend List_state_radio_button [subst {Radiobutton "$i" Xsim_State_Format $i 0 {caesar_S_assign_state_format_Tcl $i}}]
   }

set Window(Xsimulator) [subst {
   {Colored_Frame top White {
      {Logo}
      {Empty_Frame right {
   {Label  "OPEN/CAESAR    XSIMULATOR" -*-times-bold-r-normal--24-*-*-*-*-*-*-* }
      {Frame left  {
	 {Label "General display"}
	 {Radiobutton "Silent" Xsim_General_Display 0 1 {caesar_S_unset_verbose_Tcl}}
	 {Radiobutton "Verbose" Xsim_General_Display 1 0 {caesar_S_set_verbose_Tcl}}
      }}
      {Frame left  {
	 {Label "State display"}
	 {Radiobutton "Plain" Xsim_State_Display 0 1 {caesar_S_unset_delta_Tcl}}
	 {Radiobutton "Delta" Xsim_State_Display 1 0 {caesar_S_set_delta_Tcl}}
      }}
      {Frame left  {
	 {Label "Path display"}
	 {Radiobutton "Sequence" Xsim_Path_Display 0 1 {caesar_S_unset_stack_Tcl}}
	 {Radiobutton "Stack" Xsim_Path_Display 1 0 {caesar_S_set_stack_Tcl}}
      }}
      {Frame left  {
	 {Label "State format"}
	 $List_state_radio_button
      }}
      {Frame left  {
	 {Label "Label format"}
	 $List_label_radio_button
      }}
   }}
   }}

   {Colored_Frame left VioletRed1 {
      {Button "State" {caesar_S_state_display_Tcl
		       flush stdout}}
      {Button "Edges" {caesar_S_edge_display_Tcl
			flush stdout}}
      {Button "Path" {caesar_S_path_display_Tcl
			flush stdout}}
      {Button "Header" {caesar_S_header_display_Tcl
			flush stdout} }
      {Button "Next" {caesar_S_next_Tcl
			flush stdout}}
      {Button "Prev" {caesar_S_previous_Tcl
			flush stdout}}
      {Button "Reset" {caesar_S_reset_Tcl
			flush stdout} }
      {Button "Help" {caesar_S_help_Tcl
			flush stdout}}
      {Button "Quit" {exit} }
    }}
}]

set Commands(Xsimulator) {}
