###############################################################################
#                       E U C A L Y P T U S - 2
#-----------------------------------------------------------------------------
#   INRIA
#   Unite de Recherche Rhone-Alpes
#   655, avenue de l'Europe
#   38330 Montbonnot Saint Martin
#   FRANCE
#-----------------------------------------------------------------------------
#   Module              :       eucalyptus.tcl
#   Auteurs             :       Jean-Michel FRUME, Hubert GARAVEL, Mark
#				JORGENSEN, Aldo MAZZILLI, Moez CHERIF, David
#				CHAMPELOVIER, Remi HERILIER et Frederic LANG
#   Version             :       2.13
#   Date                :       2019/04/12 15:24:51
##############################################################################

set Eucalyptus_Version 2.13

set Screen_Background 				Use_Default_Background

set File_Display				Display_with_Icons

set File_Sorting 				Sort_by_Dates

set Status(Kind_Directory)			Visible
set Status(Kind_Makefile)			Visible
set Status(Kind_Lotos)				Visible
set Status(Kind_Lotos_Library)			Visible
set Status(Kind_SVL)				Visible
set Status(Kind_Composition_Expression)		Visible
set Status(Kind_Error)				Visible
set Status(Kind_Labelled_Transitions_System)	Visible
set Status(Kind_Execution_Sequence)		Visible
set Status(Kind_Mu_Calculus_Formula)		Visible
set Status(Kind_Hide_Rename)			Visible
set Status(Kind_C_Programs)			Visible
set Status(Kind_Xtl)                            Visible
set Status(Kind_Expanded_Xtl)                   Visible
set Status(Kind_Postscript)			Visible
set Status(Kind_PDF)				Visible
set Status(Kind_Fsp)				Visible
set Status(Kind_Lnt)				Visible
set Status(Kind_Core)                           Hidden
set Status(Kind_Object_Files)                   Hidden
set Status(Kind_BCG_Dynamic_Libraries)          Hidden
set Status(Kind_SVL_Temporary_Files)		Transparent
set Status(Kind_Other)				Visible

set Bg_Color                                     #EEFFFF
set Fg_Color                                     black
set Title_Color                                  #FFFF33
set Menubar_Bg_Color                             #63b8ff
set File_Icon_Bg_Color                           #63b8ff
set File_Icon_Fg_Color                           black
set Dir_Icon_Bg_Color                            #FFFF33
set Dir_Icon_Fg_Color                            black
set Radio_Select_Color                           red
set Check_Select_Color                           green
set Disabled_Buttons_Color                       grey
set Cadre_Color                                  black

set Xterm_Options                              "-geometry 80x40"

set Screen_Width                                1004
set Screen_Height                               760
set Screen_MinWidth				750
set Screen_MinHeight				160
set Screen_X_Position				0
set Screen_Y_Position 				0

set Files_Associations(.htm) 		$env(CADP)/src/com/cadp_web
set Files_Associations(.html) 		$env(CADP)/src/com/cadp_web
set Files_Associations(.log)		$env(CADP)/src/com/cadp_edit
set Files_Associations(.pdf)		$env(CADP)/src/com/cadp_pdf
set Files_Associations(.ps)		$env(CADP)/src/com/cadp_postscript
set Files_Associations(.txt)		$env(CADP)/src/com/cadp_edit

set UNIX_Commands "
      {Command Edit {Execute_Tool Edit}}
      {Command Display {Execute_Tool Display}}
      {Command Print {Execute_Tool Print}}
      {Command Touch {Execute_Tool Touch}}
      {Command Copy {Execute_Tool Copy}}
      {Command Move {Execute_Tool Move}}
      {Command Remove {Execute_Tool Remove}}
      {Command \"Mail to\" {Execute_Tool Mailto}}
      {Separator}
      {Command Properties {Execute_Tool Properties}}
"

set Menu_UNIX_Commands [subst {
       $UNIX_Commands      
}]

set Kind_List {
	Kind_SVL_Temporary_Files
	Kind_Lotos
	Kind_SVL
        Kind_Composition_Expression
	Kind_Fsp
	Kind_Lnt
	Kind_Error
        Kind_Labelled_Transitions_System
        Kind_Execution_Sequence
        Kind_Mu_Calculus_Formula
        Kind_Xtl
        Kind_Expanded_Xtl
        Kind_Makefile
        Kind_C_Programs
        Kind_Hide_Rename
        Kind_Lotos_Library
        Kind_Postscript
        Kind_PDF
	Kind_Core
	Kind_BCG_Dynamic_Libraries
	Kind_Object_Files
	Kind_Fc2
}

set RegExp(Kind_Directory) {*}
set Menu(Kind_Directory) {}

set RegExp(Kind_Lotos) {*.l|*.lot|*.lotos}
set Menu(Kind_Lotos) [subst {
   {Cascade "File"  \
            $UNIX_Commands
   }
   {Cascade "Execute"
      {Command "Advanced simulation..." {Execute_Tool Open_Caesar_Ocis}}
      {Command "Standard simulation..." {Execute_Tool Open_Caesar_XSimulator}}
      {Command "Random execution..." {Execute_Tool Open_Caesar_Executor}}
   }
   {Command "Generate labelled transition system..." {Execute_Tool Generate_LTS}}
   {Command "Find deadlocks..." {Execute_Tool Spec_Deadlock}}
   {Command "Find livelocks..." {Execute_Tool Spec_Livelock}}
   {Command "Find execution sequences..." {Execute_Tool Open_Caesar_Exhibitor}}
   {Command "Verify temporal formulas..." {Execute_Tool Open_Caesar_Evaluator}}
   {Command "Reduce..." {Execute_Tool Verif_Spec_Reduce}}
   {Command "Compare..." {Execute_Tool Verif_Spec_Compare}}
   {Command "Generate tests..." {Execute_Tool Open_Caesar_TGV}}
   {Separator}
   {Command "Indent" {Execute_Tool Caesar_Indent}}
   {Cascade "More commands"
	{Command "Compile abstract data types" {Execute_Tool Caesar_Adt}}
	{Command "Generate external types/functions" {Execute_Tool Generate_External_Types_Functions}}
	{Command "Generate gate functions..." {Execute_Tool Generate_Gate_Functions}}
   }
}]

set RegExp(Kind_Composition_Expression) {*.exp}
set Menu(Kind_Composition_Expression) [subst { 
   {Cascade "File"  \
       $UNIX_Commands
   }
   {Cascade "Execute"
      {Command "Advanced simulation..." {Execute_Tool Open_Caesar_Ocis}}
      {Command "Standard simulation..." {Execute_Tool Open_Caesar_XSimulator}}
      {Command "Random execution..." {Execute_Tool Open_Caesar_Executor}}
   }
   {Command "Generate labelled transition system..." {Execute_Tool Compositional_Generator}}
   {Command "Find deadlocks..." {Execute_Tool Spec_Deadlock}}
   {Command "Find livelocks..." {Execute_Tool Spec_Livelock}}
   {Command "Find execution sequences..." {Execute_Tool Open_Caesar_Exhibitor}}
   {Command "Verify temporal formulas..." {Execute_Tool Open_Caesar_Evaluator}}
   {Command "Reduce..." {Execute_Tool Verif_Spec_Reduce}}
   {Command "Compare..." {Execute_Tool Verif_Spec_Compare}}
   {Command "Convert..." {Execute_Tool Exp_Convert}}
   {Command "Generate tests..." {Execute_Tool Open_Caesar_TGV}}
   {Command "Properties" {Execute_Tool Exp_Info}}
}]

set RegExp(Kind_Fsp) {*.lts}
set Menu(Kind_Fsp) [subst { 
   {Cascade "File"  \
       $UNIX_Commands
   }
   {Cascade "Execute"
      {Command "Advanced simulation..." {Execute_Fsp_Options_Before_Tool Open_Caesar_Ocis}}
      {Command "Standard simulation..." {Execute_Fsp_Options_Before_Tool Open_Caesar_XSimulator}}
      {Command "Random execution..." {Execute_Fsp_Options_Before_Tool Open_Caesar_Executor}}
   }
   {Command "Translate into LOTOS + EXP..." {Execute_Fsp_Options_Before_Tool {}}}
   {Command "Generate labelled transition system..." {Execute_Fsp_Options_Before_Tool Compositional_Generator}}
   {Command "Find deadlocks..." {Execute_Fsp_Options_Before_Tool Spec_Deadlock}}
   {Command "Find livelocks..." {Execute_Fsp_Options_Before_Tool Spec_Livelock}}
   {Command "Find execution sequences..." {Execute_Fsp_Options_Before_Tool Open_Caesar_Exhibitor}}
   {Command "Verify temporal formulas..." {Execute_Fsp_Options_Before_Tool Open_Caesar_Evaluator}}
   {Command "Reduce..." {Execute_Fsp_Options_Before_Tool Verif_Spec_Reduce}}
   {Command "Compare..." {Execute_Fsp_Options_Before_Tool Verif_Spec_Compare}}
   {Command "Generate tests..." {Execute_Fsp_Options_Before_Tool Open_Caesar_TGV}}
}]

set RegExp(Kind_Lnt) {*.lnt}
set Menu(Kind_Lnt) [subst { 
   {Cascade "File"  \
       $UNIX_Commands
   }
   {Cascade "Execute"
      {Command "Advanced simulation..." {Execute_Lnt_Options_Before_Tool Open_Caesar_Ocis}}
      {Command "Standard simulation..." {Execute_Lnt_Options_Before_Tool Open_Caesar_XSimulator}}
      {Command "Random execution..." {Execute_Lnt_Options_Before_Tool Open_Caesar_Executor}}
   }
   {Command "Translate into LOTOS..." {Execute_Lnt_Options_Before_Tool {}}}
   {Command "Generate labelled transition system..." {Execute_Lnt_Options_Before_Tool Compositional_Generator}}
   {Command "Find deadlocks..." {Execute_Lnt_Options_Before_Tool Spec_Deadlock}}
   {Command "Find livelocks..." {Execute_Lnt_Options_Before_Tool Spec_Livelock}}
   {Command "Find execution sequences..." {Execute_Lnt_Options_Before_Tool Open_Caesar_Exhibitor}}
   {Command "Verify temporal formulas..." {Execute_Lnt_Options_Before_Tool Open_Caesar_Evaluator}}
   {Command "Reduce..." {Execute_Lnt_Options_Before_Tool Verif_Spec_Reduce}}
   {Command "Compare..." {Execute_Lnt_Options_Before_Tool Verif_Spec_Compare}}
   {Command "Generate tests..." {Execute_Lnt_Options_Before_Tool Open_Caesar_TGV}}
}]

set RegExp(Kind_Error) {*.err}
set Menu(Kind_Error) [subst {
      $UNIX_Commands
}]

set RegExp(Kind_Labelled_Transitions_System) {*.aut|*.bcg}
set Menu(Kind_Labelled_Transitions_System) [subst { 
   {Cascade "File"  \
       $UNIX_Commands
   }
   {Cascade "Execute"
      {Command "Advanced simulation..." {Execute_Tool Open_Caesar_Ocis}}
      {Command "Standard simulation..." {Execute_Tool Open_Caesar_XSimulator}}
      {Command "Random execution..." {Execute_Tool Open_Caesar_Executor}}
   }
   {Command "Find deadlocks..." {Execute_Tool LTS_Deadlock}}
   {Command "Find livelocks..." {Execute_Tool LTS_Livelock}}
   {Command "Find execution sequences..." {Execute_Tool Open_Caesar_Exhibitor}}
   {Command "Verify temporal formulas..." {Execute_Tool Verif_Temporal}}
   {Command "Reduce..."  {Execute_Tool Verif_Reduce}}
   {Command "Compare..." {Execute_Tool Verif_Compare}}
   {Command "Display labels" {Execute_Tool Display_Labels}}
   {Command "Hide labels..." {Execute_Tool Hide_Labels}}
   {Command "Rename labels..." {Execute_Tool Rename_Labels}}
   {Command "Convert..." {Execute_Tool Convert}}
   {Command "Find path to state..." {Execute_Tool Bcg_Info_Path}}
   {Command "Find nondeterminism..." {Execute_Tool Bcg_Info_Nondeterminism}}
   {Command "Find unreachable states" {Execute_Tool Bcg_Info_Unreachable}}
   {Cascade "Visualize"
      {Command "Draw" {Execute_Tool Bcg_Draw}}
      {Command "Edit" {Execute_Tool Bcg_Edit}}
   }
   {Command "Generate tests..." {Execute_Tool Open_Caesar_TGV}}
   {Command "Evaluate performance..." {Execute_Tool Bcg_Steady_Transient}}
   {Command "Properties" {Execute_Tool Bcg_Info}}
}]

set RegExp(Kind_Fc2) {*.fc2}
set Menu(Kind_Fc2) [linsert $Menu(Kind_Labelled_Transitions_System) [llength $Menu(Kind_Labelled_Transitions_System)] \
	{Command "Generate labelled transition system..." {Execute_Tool Compositional_Generator}}]

set Status(Kind_Fc2) $Status(Kind_Labelled_Transitions_System)

set RegExp(Kind_Execution_Sequence) {*.seq}
set Menu(Kind_Execution_Sequence) [subst {
	$Menu(Kind_Labelled_Transitions_System)
}]

set RegExp(Kind_Mu_Calculus_Formula) {*.mcl}
set Menu(Kind_Mu_Calculus_Formula) [subst {
      $UNIX_Commands
}]

set RegExp(Kind_Xtl) {*.xtl}
set Menu(Kind_Xtl) [subst {
      $UNIX_Commands
}]

set RegExp(Kind_Expanded_Xtl) {*.pp}
set Menu(Kind_Expanded_Xtl) [subst {
      {Command Display {Execute_Tool Display}}
}]

set RegExp(Kind_Other) {*}
set Menu(Kind_Other) [subst {
      {Command "Open with..." {Execute_Tool Create_File_Association}}
      {Command Execute {Execute_Tool Execute}}
      {Separator}
      $UNIX_Commands
}]

set RegExp(Kind_Makefile) {[Mm]akefile*|*.mk}
set Menu(Kind_Makefile) [subst {
      {Command Make {Execute_Tool Make}}
      {Separator}
      $UNIX_Commands
}]

set RegExp(Kind_SVL) {*.svl}
set Menu(Kind_SVL) [subst {
      {Command "Execute" {Execute_Tool SVL_Execute}}
      {Command "Clean" {Execute_Tool SVL_Clean}}
      {Separator}
      $UNIX_Commands
}]

set RegExp(Kind_C_Programs) {*.c|*.h|*.f|*.t|*.fnt|*.tnt}
set Menu(Kind_C_Programs) $Menu_UNIX_Commands

set RegExp(Kind_Hide_Rename) {*.hid|*.hide|*.ren|*.rename|*.io}
set Menu(Kind_Hide_Rename) $Menu_UNIX_Commands

set RegExp(Kind_Lotos_Library) {*.lib}
set Menu(Kind_Lotos_Library) [subst {
      {Command "Indent" {Execute_Tool Caesar_Indent}}
      {Separator}
      $UNIX_Commands
}]

set RegExp(Kind_Postscript) {*.ps|*.ps.Z}
set Menu(Kind_Postscript) [subst {
      {Command "View/Draw" {Execute_Tool View_PostScript}}
      {Command "Edit" {Execute_Tool Bcg_Edit}}
      {Separator}
      $Menu_UNIX_Commands
}]

set RegExp(Kind_PDF) {*.pdf}
set Menu(Kind_PDF) [subst {
      {Command "View/Draw" {Execute_Tool View_PDF}}
      {Separator}
      $Menu_UNIX_Commands
}]

set RegExp(Kind_Core) {core}
set Menu(Kind_Core) $Menu_UNIX_Commands

set RegExp(Kind_BCG_Dynamic_Libraries) {*@1.o|*@2.o}
set Menu(Kind_BCG_Dynamic_Libraries) $Menu_UNIX_Commands

set RegExp(Kind_SVL_Temporary_Files) {svl[0-9][0-9][0-9]*}
set Menu(Kind_SVL_Temporary_Files) "<undefined>"

set RegExp(Kind_Object_Files) {*.o}
set Menu(Kind_Object_Files) $Menu_UNIX_Commands

proc Make_Canonical_Reg_Exp {Kind} {
    global RegExp

    set Reg_Exp $RegExp($Kind)
    regsub -all -- {\.} $Reg_Exp {\\.} Reg_Exp
    regsub -all -- {\*} $Reg_Exp {.*} Reg_Exp
    regsub -all -- {\|} $Reg_Exp {$|} Reg_Exp
    append Reg_Exp {$}
    set RegExp($Kind) $Reg_Exp
}

foreach Kind $Kind_List {
    Make_Canonical_Reg_Exp $Kind
}

set Space_Inside 5
set Space_Outside 5

set Character_Refresh "\f"

set Normal_Cursor {}
set Waiting_Cursor watch
set DescMenus \
{
 {Textmenubutton "File" left
   {Command "Change directory..." {Execute_Tool Change_Directory}}
   {Command "Text editor" {Execute_Tool Editor}}
   {Command "Command shell" {Execute_Tool Terminal}}
   {Separator}
   {Command "Save preferences" Save_Xeuca_Preferences}
   {Command "Reset preferences" {Execute_Tool Reset_Xeuca_Preferences}}
   {Separator}
   {Command "Exit" {exit}}
 }
 {Textmenubutton "View" left
   {Command "Refresh" {MakeIcons}}
   {Separator}
   {Command "Change presentation..." {Execute_Tool Presentation}}
   {Command "Change background..." {Execute_Tool Background}}
   {Command "Change file associations..." {Execute_Tool Edit_Files_Associations}}
 }	
 {Button "Help" right
      {Help_Command}
 }
 {Textmenubutton "Web" right
      {Command "CADP Home Page" {Execute_Tool Web_CADP_Home_Page}}
      {Command "CADP Tutorials" {Execute_Tool Web_CADP_Tutorials}}
      {Command "CADP Manual Pages" {Execute_Tool Web_CADP_Manuals}}
      {Command "CADP Case Studies" {Execute_Tool Web_CADP_Case_Studies}}
      {Command "CADP FAQ" {Execute_Tool Web_CADP_FAQ}}
 } 
}
set DescOptions { \
   {Textmenubutton "Options" left \
      {Cascade "BISIMULATOR" \
               {Checkbutton "Statistics" Option_Bisimulator(Statistics) "-stat" "" 0 {}}
	       {Window_Options "Boolean Equation System printing..." BES_filename}
      }
      {Cascade "CAESAR and CAESAR.ADT" \
	  {Command "   OPTIONS COMMON TO CAESAR AND CAESAR.ADT" {}}
          {Cascade "Language" \
                   {Radiobutton "English" 
                                Option_Caesar_General(Language) 
                                "-english" \
			        {[expr ! [info exists env(CADP_LANGUAGE)] || ! [string compare [Variable env(CADP_LANGUAGE)] "english"]]} \
				{}
                   } \
                   {Radiobutton "French" 
                                Option_Caesar_General(Language) 
                                "-french" 
			        {[expr ! [string compare [Variable env(CADP_LANGUAGE)] "french"]]} \
				{}
                   } \
          } 
	  {Cascade "Messages"
	       {Radiobutton "Verbose" \
			    Option_Caesar_General(Messages) \
			    " " \
			    1 \
			    {} \
	       }
	       {Radiobutton "Silent" \
			    Option_Caesar_General(Messages) \
			    "-silent" \
			    0 \
			    {} \
	       }
	  }
          {Checkbutton "Errors" Option_Caesar_General(Errors) "" "-error" 1 {}}
          {Checkbutton "Warnings" Option_Caesar_General(Warnings) "" "-warning"  1 {}}
          {Checkbutton "Abstract/concrete correspondence printing" Option_Caesar_General(AC_Cor_Print) -map "" 2 {}}
          {Checkbutton "Abstract/concrete comments required" Option_Caesar_General(AC_Com_Req) -comments "" 2 {}}
          {Checkbutton "Force recompilations even if not necessary" Option_Caesar_General(Force) -force "" 2 {}}
          {Window_Options "Miscellaneous options..." Miscellaneous_Options}
	  {Separator}
	  {Command "   OPTIONS SPECIFIC TO CAESAR" {}}
		{Checkbutton "Enable garbage collection" Option_Caesar(Garbage_Collector) -gc "" 1 {}}
		{Checkbutton "Optimization V3" Option_Caesar(Optimization_V3) ""
"-v3" 1 {}}
		{Checkbutton "Optimization V4" Option_Caesar(Optimization_V4) ""
"-v4" 1 {}}
		{Cascade "Optimization E7"
			{Radiobutton "BDD based" Option_Caesar(Optimization_E7) " " 1 {}}
			{Radiobutton "Explicit-state based" Option_Caesar(Optimization_E7) "-e7old" 0 {}}
			{Radiobutton "Disabled" Option_Caesar(Optimization_E7) "-e7" 0 {}}
		}
		{Checkbutton "Optimization `safety'" Option_Caesar(Optimization_Safety) "-safety" "" 2 {}}
		{Checkbutton "Optimization `gradual'" Option_Caesar(Optimization_Gradual) "-gradual" "" 2 {}}
		{Checkbutton "Petri net printing" Option_Caesar(PetriNet) "-network" "" 2 {}}
	  {Separator}
	  {Command "   OPTIONS SPECIFIC TO CAESAR.ADT" {}}
               {Checkbutton "Code generation with `debug' features" Option_Caesar_Adt(Gen_Debug) -debug "" 2 {}}
               {Checkbutton "Code generation with `trace' features" Option_Caesar_Adt(Gen_Trace) -trace "" 2 {}}
               {Checkbutton "Indentation of generated C code" Option_Caesar_Adt(Indentation) "" -indent 2 {}}
	       {Window_Options "Cardinal of numeral types..." Caesar_Adt_Numeral_Cardinal}
      }
      {Cascade "CAESAR.INDENT" 
	       {Checkbutton "Verbose" Option_Caesar_Indent(Messages) "-v" "-nv" 2 {}}
	       {Separator}
               {Radiobutton "Keywords in lower case" Option_Caesar_Indent(Case) "-kwlc" 1 {}}
	       {Radiobutton "Keywords in upper case" Option_Caesar_Indent(Case) "-kwuc" 0 {}}
	       {Radiobutton "Keywords with capitalised initial" Option_Caesar_Indent(Case) "-kwci" 0 {}}
	       {Separator}	
	       {Checkbutton "Replace spaces with tabs" Option_Caesar_Indent(Tabs) "-tabs" "-notabs" 2 {}}
	       {Checkbutton "Preserve block structure" Option_Caesar_Indent(Structure) "-struct" "-nstruct" 1 {}}
	       {Separator}
	       {Window_Options "Tab, line and margin lengths..." Tab_Line_Margin}
	}
		
      {Cascade "EVALUATOR" \
               {Cascade "Evaluator version"
			{Radiobutton "Version V3 (basic)" Option_Evaluator(Executable) "evaluator3" 1 {}}
			{Radiobutton "Version V4 (with data)" Option_Evaluator(Executable) "evaluator4" 0 {}}
			{Radiobutton "Version V5 (with probabilities)" Option_Evaluator(Executable) "evaluator5" 0 {}}
               }
               {Separator}
               {Cascade "Messages"
                        {Radiobutton "Verbose" Option_Evaluator(Messages) "-verbose" 1 {}}
                        {Radiobutton "Silent" Option_Evaluator(Messages) "-silent" 0 {}}
               }
               {Separator}
               {Checkbutton "Statistics" Option_Evaluator(Statistics) "-stat" "" 0 {}}
	       {Window_Options "Boolean Equation System printing..." Evaluator_BES}
      }

      {Cascade "EXP.OPEN"
               {Cascade "Reference language"
                        {Radiobutton "(automatic)" Option_Exp_Open(Language) " " 1 {}}
                        {Radiobutton "lotos" Option_Exp_Open(Language) "-lotos" 0 {}}
                        {Radiobutton "ccs" Option_Exp_Open(Language) "-ccs" 0 {}}
                        {Radiobutton "csp" Option_Exp_Open(Language) "-csp" 0 {}}
                        {Radiobutton "elotos" Option_Exp_Open(Language) "-elotos" 0 {}}
                        {Radiobutton "mcrl" Option_Exp_Open(Language) "-mcrl" 0 {}}
               }
               {Window_Options "Change name of hidden action..." Exp_Open_Hidden_Action}
               {Window_Options "Change name of termination action..." Exp_Open_Termination_Action}
               {Window_Options "Change name of CCS coaction prefix..." Exp_Open_CCS_Coaction_Prefix}
               {Separator}
               {Cascade "Partial order reduction preserving"
                        {Radiobutton "strong equivalence" Option_Exp_Open(Preserving) " " 1 {}}
                        {Radiobutton "branching equivalence" Option_Exp_Open(Preserving) "-branching" 0 {}}
                        {Radiobutton "stochastic branching equivalence" Option_Exp_Open(Preserving) "-ratebranching" 0 {}}
                        {Radiobutton "weak trace equivalence" Option_Exp_Open(Preserving) "-weaktrace" 0 {}}
                        {Radiobutton "deadlocks" Option_Exp_Open(Preserving) "-deadpreserving" 0 {}}
               }
      }

      {Cascade "SEQ.OPEN" 
	      {Window_Options "Index of sequence..." Seq_Open_Sequence_Index}
	      {Window_Options "Size of cache table..." Seq_Open_Cache_Size}
      }
      {Cascade "SVL" 
          {Cascade "Messages"
              {Radiobutton "Verbose" Option_SVL(Messages) " " 1 {}}
              {Radiobutton "Silent" Option_SVL(Messages) "-silent" 0 {}}
          }
          {Checkbutton "Case-sensitive gate identifiers" Option_SVL(Sensitive) "-case" "" 2 {}}
          {Checkbutton "Ignore errors and continue" Option_SVL(Ignore) "-ignore" "" 2 {}}
          {Checkbutton "Keep intermediate files and shell-script" Option_SVL(Debug) "-debug" "" 2 {}}
          {Window_Options "Shell options..." SVL_Shell_Options}
      }
      {Cascade "TGV" 
	  {Cascade "Messages"
	       {Radiobutton "Verbose" Option_TGV(Messages) "-verbose" 1 {}}
	       {Radiobutton "Silent" Option_TGV(Messages) " " 0 {}}
	  }
          {Separator}
	  {Checkbutton "Disable parsing of BCG labels" Option_TGV(Parse) "-unparse" " " 2 {}}
          {Checkbutton "Enable connection with VTS and AC" Option_TGV(Verif) "-verif" " " 2 {}}
	  {Checkbutton "Disable pruning of lock transitions" Option_TGV(Keeplock) "-keeplock" " " 2 {}}
	  {Separator}
	       {Radiobutton "Display lock transitions" Option_TGV(Locks) " " 1 {}}
	       {Radiobutton "Differentiate lock transitions" Option_TGV(Locks) "-difflock" 0 {}}
               {Radiobutton "Do not display lock transitions" Option_TGV(Locks) "-unlock" 0 {}}
      }
      {Cascade "XTL"
               {Cascade "Messages"
                        {Radiobutton "Verbose" Option_XTL(Messages) "-verbose" 1 {}}
                        {Radiobutton "Silent" Option_XTL(Messages) "-silent" 0 {}}
               }
               {Cascade "Language" 
                        {Radiobutton "English" Option_XTL(Language) "-english" 1 {}}
                        {Radiobutton "French" Option_XTL(Language) "-french" 0 {}}
               }
               {Separator}
               {Checkbutton "Warnings" Option_XTL(Warnings) "-warning" "" 2 {}}
	       {Separator}
               {Window_Options "Miscellaneous XTL options..." XTL_Miscellaneous_Options}
      }
   }
}

set Window(Miscellaneous_Options) {
      {Frame top {
           {Entry "C compiler options" C_Flags {}}
      }}
      {Frame top {
           {Entry "Error file display" Pager "/bin/cat"}
      }}
}

set Commands(Miscellaneous_Options) {}

set Window(Caesar_Adt_Numeral_Cardinal) {
      {Frame top {
           {Entry "Cardinal of numeral types (256 by default, if empty)" Numeral_Cardinal ""}
      }}
}

set Commands(Caesar_Adt_Numeral_Cardinal) {
      {global Numeral_Cardinal
       global Option_Caesar_Adt
       set Option_Caesar_Adt(Numeral) ""
       if [string compare [Variable Numeral_Cardinal] ""] then {
          append Option_Caesar_Adt(Numeral) "-numeral '[Variable Numeral_Cardinal]'"
       }
       }
}

set Window(BES_filename) {
      {Frame top {
             {Entry "Boolean Equation System filename (empty if none)" Bisimulator_BES_Filename ""}
      }}
}
set Commands(BES_filename) { 
      {global Bisimulator_BES_Filename
       global Option_Bisimulator
       set Option_Bisimulator(BES_filename) ""
       if [string compare [Variable Bisimulator_BES_Filename] ""] then {
          append Option_Bisimulator(BES_filename) "-bes '[Variable Bisimulator_BES_Filename]'"
       }
       }
}

set Window(Evaluator_BES) {
      {Frame top {
             {Entry "Boolean Equation System filename (empty if none)" Evaluator_BES_Filename ""}
      }}
}
set Commands(Evaluator_BES) { 
      {global Evaluator_BES_Filename
       global Option_Evaluator
       set Option_Evaluator(BES_filename) ""
       if [string compare [Variable Evaluator_BES_Filename] ""] then {
          append Option_Evaluator(BES_filename) "-bes '[Variable Evaluator_BES_Filename]'"
       }
       }
}

set Window(Exp_Open_Hidden_Action) {
      {Frame top {
             {Entry "Name of hidden action (empty if default)" Exp_Open_Hidden_Action_String ""}
      }}
}

set Commands(Exp_Open_Hidden_Action) {
      {global Exp_Open_Hidden_Action_String
       global Option_Exp_Open
       set Option_Exp_Open(Hidden_Action) ""
       if [string compare [Variable Exp_Open_Hidden_Action_String] ""] then {
          append Option_Exp_Open(Hidden_Action) "-hidden "  \"[Variable Exp_Open_Hidden_Action_String]\"
       }
      }
}

set Window(Exp_Open_Termination_Action) {
      {Frame top {
             {Entry "Name of termination action (empty if default)" Exp_Open_Termination_Action_String ""}
      }}
}

set Commands(Exp_Open_Termination_Action) {
      {global Exp_Open_Termination_Action_String
       global Option_Exp_Open
       set Option_Exp_Open(Termination_Action) ""
       if [string compare [Variable Exp_Open_Termination_Action_String] ""] then {
          append Option_Exp_Open(Termination_Action) "-termination "  \"[Variable Exp_Open_Termination_Action_String]\"
       }
      }
}

set Window(Exp_Open_CCS_Coaction_Prefix) {
      {Frame top {
             {Entry "Name of CCS coaction prefix (empty if default)" Exp_Open_CCS_Coaction_Prefix_String ""}
      }}
}

set Commands(Exp_Open_CCS_Coaction_Prefix) {
      {global Exp_Open_CCS_Coaction_Prefix_String
       global Option_Exp_Open
       set Option_Exp_Open(CCS_Coaction_Prefix) ""
       if [string compare [Variable Exp_Open_CCS_Coaction_Prefix_String] ""] then {
          append Option_Exp_Open(CCS_Coaction_Prefix) "-coaction "  \"[Variable Exp_Open_CCS_Coaction_Prefix_String]\"
       }
      }
}

set Window(Seq_Open_Sequence_Index) {
      {Frame top {
             {Entry "Index of sequence (0 means all sequences)" Seq_Open_Seqno 0}
      }}
}

set Commands(Seq_Open_Sequence_Index) {
      {global Seq_Open_Seqno
       global Option_Seq_Open
       set Option_Seq_Open(Seqno) ""
       append Option_Seq_Open(Seqno) "-seqno '[Variable Seq_Open_Seqno]'"
      }
}

set Window(Seq_Open_Cache_Size) {
      {Frame top {
             {Entry "Size of cache table (0 means default number of entries)" Seq_Open_Cache 0}
      }}
}

set Commands(Seq_Open_Cache_Size) {
      {global Seq_Open_Cache
       global Option_Seq_Open
       set Option_Seq_Open(Cache) ""
       append Option_Seq_Open(Cache) "-cache '[Variable Seq_Open_Cache]'"
      }
}

set Window(XTL_Miscellaneous_Options) {
      {Frame top {
             {Entry "C compiler options" XTL_C_Flags {}}
      }}
      {Frame top {
             {Entry "Temporary files location" XTL_Temporary_File_Location {[Variable env(CADP_TMP)]}}
      }}
}

set Commands(XTL_Miscellaneous_Options) {}

set DescMenus [concat $DescMenus $DescOptions]

set Window(Tab_Line_Margin) {
	{Label "CAESAR.INDENT tabulation, line, and margin lengths"}
	{Frame top {
             {Entry "Tabulation length    " Option_Caesar_Indent_Tab 8}
        }}
        {Frame top {
             {Entry "Maximum line length  " Option_Caesar_Indent_Line 500}
        }}
	{Frame top {
             {Entry "Maximum margin length" Option_Caesar_Indent_Margin 460}
        }}
}
set Commands(Tab_Line_Margin) {
	{global Option_Caesar_Indent_Tab
	 global Option_Caesar_Indent_Line
	 global Option_Caesar_Indent_Margin
	 global Option_Caesar_Indent
	 set Option_Caesar_Indent(Tab_Length) ""
	 set Option_Caesar_Indent(Line_Length) ""
	 set Option_Caesar_Indent(Margin_Length) ""
	 append Option_Caesar_Indent(Tab_Length) "-every " $Option_Caesar_Indent_Tab
	 append Option_Caesar_Indent(Line_Length) "-ll " $Option_Caesar_Indent_Line
	 append Option_Caesar_Indent(Margin_Length) "-m " $Option_Caesar_Indent_Margin
	}
}

array set Files_Associations {}

set Open_Program_Name ""

proc Make_File_Association {Ext} {
    global Menu
    global RegExp
    global Status
    global UNIX_Commands
    global Kind_List
    global Files_Associations

    set Kind "Kind_User_[string toupper [string range $Ext 1 end] 0 0]"

    set RegExp($Kind) "*$Ext"
    Make_Canonical_Reg_Exp $Kind

    set Status($Kind) Visible

    set Commands_List {}

    foreach Program $Files_Associations($Ext) {
	set Name [string toupper [file tail $Program] 0 0]
	lappend Commands_List [subst {Command "$Name" {Open_With "$Program"}}]
    }

    set Commands_List [concat $Commands_List {{Separator} {Command "Other program..." {Execute_Tool Create_File_Association}}}]
    set Menu_Open_With {{[subst {Cascade "Open with..." $Commands_List}]}}

    set Menu($Kind) [subst {
	{[subst {Command "Open" {Open_With "[lindex $Files_Associations($Ext) 0]"}}]}
	[subst $Menu_Open_With]
	{Command "Execute" {Execute_Tool Execute}}
	{Separator}
	$UNIX_Commands	
    }]

    lappend Kind_List $Kind
}

proc Delete_File_Association {Ext} {
    global Menu
    global RegExp
    global Status
    global Kind_List

    set Kind "Kind_User_[string toupper [string range $Ext 1 end] 0 0]"

    unset Menu($Kind)
    unset RegExp($Kind)
    unset Status($Kind)

    set index [lsearch -exact $Kind_List $Kind]
    set Kind_List [lreplace $Kind_List $index $index]
}

proc Init_Files_Associations {} {
    global Files_Associations

    foreach Item [array names Files_Associations] {
        Make_File_Association $Item
    }
    MakeIcons
}

set Window(Open) {}

set Commands(Open) {{
    global Files_Associations
    global Open_Program_Name

    set Filename [File_Name Open]
    set Ext [file extension $Filename]

    if {$Open_Program_Name == ""} {
	Display "Debug error: the action \"Open\" must not be called directly ; use Open_With{} instead"
    } else {
	Execute "$Open_Program_Name $Filename &"
	set Open_Program_Name ""
    }
}}

proc Open_With {Program} {
    global Open_Program_Name

    set Open_Program_Name "$Program"
    Execute_Tool Open    
}

set Disable_Ok_Button(Create_File_Association) 1

set Window(Create_File_Association) {
    {Label "Select the program to use to open files with the extension \"[file extension [File_Name Create_File_Association]]\""}
    {Invisible_Frame top {
        {Filebox Create_File_Association "/" "*" Create_File_Association}
    }}
}

set Commands(Create_File_Association) {{
    global Files_Associations
    global Selected_File_Name

    set Filename [File_Name Create_File_Association]
    set Ext [file extension $Filename]
    set Program [Get_Selected_File Create_File_Association]

    lappend Files_Associations($Ext) "$Program"
    Make_File_Association $Ext

    set Selected_File_Name(Open) "$Filename"
    Open_With "$Program"
}}

set Rule(Create_File_Association) 1

array set Files_Associations_Tmp {}

set Edit_Extensions_Listbox ""

set Edit_Current_File_Extension ""

set Edit_Programs_Listbox ""

set Edit_Current_Programs_List {}

proc Get_Files_Associations_Tmp_Keys {} {
    global Files_Associations_Tmp

    return [lsort [array names Files_Associations_Tmp]]
}

proc Get_Current_Associated_Programs {} {
    global Files_Associations_Tmp
    global Edit_Current_File_Extension

    if {$Edit_Current_File_Extension != ""} {
	return $Files_Associations_Tmp($Edit_Current_File_Extension)
    } else {
	return {}
    }
}

proc Get_Edit_Current_File_Extension {} {
    global Edit_Current_File_Extension

    return $Edit_Current_File_Extension
}

set Window(Edit_Files_Associations) {
    {{
	global Files_Associations
	global Files_Associations_Tmp

	unset Files_Associations_Tmp
	array set Files_Associations_Tmp [array get Files_Associations]
    }}
    {Label "Files associations editor"}
    {Invisible_Frame top {
	{Process_Listbox Edit_Extensions_Listbox [Get_Files_Associations_Tmp_Keys] 20 single}
	{{
	    global Edit_Extensions_Listbox

	    set Edit_Extensions_Listbox $Wind.frame[expr $Number].listbox 
	    $Edit_Extensions_Listbox selection clear 0 end
	}}
    }}
    {Invisible_Frame top {
	{Invisible_Frame left {
	    {Button "Edit" {
		global Edit_Current_File_Extension
                if [expr [llength [$Edit_Extensions_Listbox curselection]] != 1] {

	           Display "Please select first which file extension to edit"
	           Display $Rule_Error
                } else {
		   set Edit_Current_File_Extension $Selected_Process_Name(Edit_Extensions_Listbox)
		   Execute_Tool Edit_Programs_List
                }
	    }}
	}}
	{Invisible_Frame left {
	    {Button "Delete" {
		global Files_Associations_Tmp
		global Selected_Process_Name

                if [expr [llength [$Edit_Extensions_Listbox curselection]] != 1] {

	           Display "Please select first which file extension to delete"
	           Display $Rule_Error
                } else {

		   $Edit_Extensions_Listbox delete [$Edit_Extensions_Listbox curselection]
		   unset Files_Associations_Tmp($Selected_Process_Name(Edit_Extensions_Listbox))
                }
	    }}
	}}
    }}
}

set Commands(Edit_Files_Associations) {{
    global Files_Associations_Tmp
    global Files_Associations
    global Edit_Extensions_Listbox

    foreach Ext [array names Files_Associations] {
	Delete_File_Association $Ext
    }

    unset Files_Associations
    array set Files_Associations [array get Files_Associations_Tmp]

    foreach Ext [array names Files_Associations] {
	Make_File_Association $Ext
    }

    Save_Xeuca_Preferences

    MakeIcons
}}

set Rule(Edit_Files_Associations) 1

set Window(Edit_Programs_List) {
    {{
	global Files_Associations_Tmp
	global Edit_Current_File_Extension
	global Edit_Current_Programs_List

	set Edit_Current_Programs_List $Files_Associations_Tmp($Edit_Current_File_Extension)
    }}
    {Label "Associated programs with the extension [Get_Edit_Current_File_Extension]"}
    {Invisible_Frame top {
	{Process_Listbox Edit_Programs_List [Get_Current_Associated_Programs] 40 single}
	{{
	    global Edit_Programs_Listbox

	    set Edit_Programs_Listbox $Wind.frame[expr $Number].listbox 
	    $Edit_Programs_Listbox selection clear 0 end
	}}
    }}
    {Invisible_Frame top {
	{Invisible_Frame left {
	    {Button "Add" {
		Execute_Tool Edit_Add_Program
	    }}
	}}
	{Invisible_Frame left {
	    {Button "Delete" {
		global Edit_Programs_Listbox
		global Edit_Current_Programs_List

		if [expr [llength [$Edit_Programs_Listbox curselection]] != 1] {

                   Display "Please select first which file association to delete"
                   Display $Rule_Error
                } else {

		   $Edit_Programs_Listbox delete [$Edit_Programs_Listbox curselection]
		   set Edit_Current_Programs_List [$Edit_Programs_Listbox get 0 end]
                }
	    }}
	}}
	{Invisible_Frame right {
	    {Button "Make default" {
		global Edit_Programs_Listbox
		global Edit_Current_Programs_List

		if [expr [llength [$Edit_Programs_Listbox curselection]] != 1] {

                   Display "Please select first which file association to be made the default"
                   Display $Rule_Error
                } else {

		   set New_Default [$Edit_Programs_Listbox get [$Edit_Programs_Listbox curselection]]
		   $Edit_Programs_Listbox delete [$Edit_Programs_Listbox curselection]
		   $Edit_Programs_Listbox insert 0 $New_Default
		   set Edit_Current_Programs_List [$Edit_Programs_Listbox get 0 end]
                }
	    }}
	}}
    }}
}

set Commands(Edit_Programs_List) {{
    global Files_Associations_Tmp
    global Edit_Current_File_Extension
    global Edit_Current_Programs_List

    set Files_Associations_Tmp($Edit_Current_File_Extension) $Edit_Current_Programs_List
}}

set Rule(Edit_Files_Associations) 1

set Window(Edit_Add_Program) {
    {Label "Select the program to use to open files with the extension \"[Get_Edit_Current_File_Extension]\""}
    {Invisible_Frame top {
        {Filebox Edit_Add_Program "/" "*" Edit_Add_Program}
    }}
}

set Commands(Edit_Add_Program) {{
    global Selected_File_Name
    global Edit_Programs_Listbox
    global Edit_Current_Programs_List

    $Edit_Programs_Listbox insert end $Selected_File_Name(Edit_Add_Program)
    set Edit_Current_Programs_List [$Edit_Programs_Listbox get 0 end]
}}

set Rule(Edit_Add_Program) 1

set Disable_Ok_Button(Edit_Add_Program) 1

set Disable_Ok_Button(Background) 1

set Window(Background) {
     {Frame top {
         {Label "Change screen background"}
         {Invisible_Frame top {
            {Filebox Background_List "Frame_Directory" *.gif Background}
          }}
          {Button "Apply" {
             global Screen_Background
             if [string compare [Get_Selected_File Background_List]  ""] then {
                set Screen_Background [Get_Selected_File Background_List]
                MakeIcons 
             }
         }}
     }}
}

set Commands(Background) {
	{
	global Screen_Background
	set Screen_Background [Get_Selected_File Background_List]
	}
}

proc Locate_Screen_Background {} {
   global Screen_Background
   global Frame_Directory

   if [file exists $Screen_Background] then {

      return $Screen_Background
   } elseif [file exists $Frame_Directory/$Screen_Background] then {

      return $Frame_Directory/$Screen_Background
   } else {

      return $Frame_Directory/clouds1.gif
   }
}

proc Normalize_Screen_Background {} {
   global Screen_Background
   global Frame_Directory

   if [expr ![string compare [file dirname $Screen_Background] $Frame_Directory]] {
      set Screen_Background [file tail $Screen_Background]
  }
}

set Window(Change_Directory) {
       {Label "Current Directory"}
       {Label_Variable Selected_Directory_Name(Files_List)}
       {Invisible_Frame top {
         {Frame left {
            {Radiobutton "Home" \
                         Selected_Directory_Name(Files_List) \
                         {[Variable env(XEUCA_HOME)]} 1 \
                         {Refresh_Files_Listbox Files_List}
            }
            {Radiobutton "/ (root)" \
                         Selected_Directory_Name(Files_List) \
                         / 0 \
                         {Refresh_Files_Listbox Files_List}
            }
            {Radiobutton "/tmp" \
                         Selected_Directory_Name(Files_List) \
                         /tmp 0 \
                         {Refresh_Files_Listbox Files_List}
            }
            {Radiobutton "CADP" \
                         Selected_Directory_Name(Files_List) \
                         {[Variable env(CADP)]} 0 \
                         {Refresh_Files_Listbox Files_List}
            }
            }}
	    {Filebox Files_List . * No_Ok_Button}
       }}
}

set Commands(Change_Directory) {{global Selected_Directory_Name
                                cd "$Selected_Directory_Name(Files_List)"
                                Execute "cd \"$Selected_Directory_Name(Files_List)\""
                                MakeIcons
                                }
                               }

proc Join {Directory File} {

   if [expr [string compare $Directory "/"] == 0] {

      return "/$File"
   } elseif [expr [string compare $File ".."] == 0] {

      return [file dirname $Directory]
   } else {
      return "$Directory/$File"
   }
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

proc List_Files {Path} {

   set Files {}
   foreach File [glob -nocomplain $Path] {
       if [expr [file isfile $File] && [file readable $File]] then {
           lappend Files [file tail $File]
       }
   }
   return [lsort $Files]
}
proc Unix_Communication_Mode {} {
        global Pipe
	global env
        if ![catch {open "| [eval exec $env(XEUCA_SHELL) cadp_shell] |& cat -u" r+} Pipe] {
                fconfigure $Pipe -buffering none
                fconfigure $Pipe -blocking $env(XEUCA_BLOCKING_FACTOR)
                fconfigure $Pipe -translation [Execute_Shell "cadp_crlf"]
                fileevent $Pipe readable Log
        }
}

proc Log {} {
    global Pipe
    global Commands_List Rule_Done Rule_Killed Rule_Error

    global Failed_Conversion
    global Xeuca_Result

    gets $Pipe Char

    regsub -all {[\r]} $Char {} Char

    switch -regexp -- $Char {
      \f {
         Display $Rule_Done
         global File_Id
         MakeIcons
         if [string compare $File_Id  0] then {
             Log_Close
         }
         .f1.fileswindow configure -cursor [Variable Normal_Cursor]
         set Commands_List [lrange $Commands_List 1 [llength $Commands_List]]
         if [expr [llength $Commands_List] > 0 ] then {
             Execute_First_Command
         }

    }

    xeuca_result:.* {

	scan $Char {xeuca_result: %s} Xeuca_Result
	global File_Id
	if [string compare $File_Id  0] then {
	    puts $File_Id $Char
	}
    }

    \b.* {
         set Commands_List [lrange $Commands_List 1 [llength $Commands_List]]
         if [expr [string compare $Char "\b0"]] then {
            if [expr ![string compare $Char \b137]] then {
              Display $Rule_Killed
            } else {
              Display $Rule_Error
	    }

	    set Xeuca_Result $Failed_Conversion

            .f1.fileswindow configure -cursor [Variable Normal_Cursor]
            global File_Id
            MakeIcons
            if [string compare $File_Id  0] then {
                Log_Close
            }
            .f1.fileswindow configure -cursor [Variable Normal_Cursor]
            set Commands_List {}

         } elseif [expr [llength $Commands_List] > 0 ] then {

                 Execute_First_Command
         } else {

         }
    } 
    default {
              Display $Char
              global File_Id
              if [string compare $File_Id  0] then {
                  puts $File_Id $Char
              }
    }
    }
}

proc Display {String} {
     .f.t configure -state normal

     regsub -all {[\001\002\r]} $String {} line
     .f.t insert end "${line}\n"
     .f.t see end
     .f.t configure -state disabled
}

proc Send {Command} {
   global Pipe
   if [expr [string compare [lindex $Command 0] xeuca_echo] && \
	    [string compare [lindex $Command 0] xeuca_convert]] then {
        Display $Command
   }
   puts $Pipe "$Command"
}

proc Execute_First_Command {} {

   global Commands_List
   set Command [lindex [Variable Commands_List] 0]

   Send $Command
   Send "xeuca_echo \b\$?"
}

proc Execute {String} {

   global Commands_List
   if [expr [llength [Variable Commands_List]] == 0] then {

       lappend Commands_List $String
       Execute_First_Command
   } else {

       lappend Commands_List $String
   }
}

proc Execute_Shell {Shell_Command} {

    global env
    if [string compare $env(XEUCA_SHELL) ""] {
       catch { eval exec $env(XEUCA_SHELL) [ list $Shell_Command ] } Result
    } else {
       catch { eval exec "$Shell_Command" } Result
    }
    return $Result
}

proc Execute_Shell_With_Status {Shell_Command} {

    global env
    if [string compare $env(XEUCA_SHELL) ""] {
       set Status [catch { eval exec $env(XEUCA_SHELL) [ list $Shell_Command ] } Result]
    } else {
       set Status [catch { eval exec "$Shell_Command" } Result]
    }
    return [list $Status $Result]
}

proc Execute_Shell_Background {Shell_Command} {

    global env
    if [string compare $env(XEUCA_SHELL) ""] {
       catch { eval exec $env(XEUCA_SHELL) [ list $Shell_Command ] & } Result
    } else {
       catch { eval exec "$Shell_Command" & } Result
    }
    return $Result
}

proc Execute_Tool {Action} {

   global Window
   global Menus

   if ![Update_Currently_Selected_File $Action] {

      return
   }

   if [info exists Menus($Action)] {
        Make_Window_with_Menus $Action
   } elseif [expr [llength $Window($Action)] > 0] {
        Make_Window_with_Buttons $Action
   } else {
      Execute_Commands $Action

      Unset_Currently_Selected_File $Action
   }
}

proc Execute_Commands {Action} {

   .f1.fileswindow configure -cursor [Variable Waiting_Cursor]
   global Commands
   global Rule

   foreach Command $Commands($Action) {
       if [catch $Command Message] then {
          bgerror "Unexpected Tcl error message: $Message"
       }
   }
   if [expr ![info exists Rule($Action)]] then {
      Execute "xeuca_echo \f"
   }
}

proc File_Name {Action} {

    global Currently_Selected_File

    return $Currently_Selected_File($Action)
}

proc File_Base {Action} {
      return [file rootname [File_Name $Action]]
}

proc Set_Currently_Selected_File {Action1 Action2} {

    global Currently_Selected_File

    set Currently_Selected_File($Action1) $Currently_Selected_File($Action2)
}

proc Unset_Currently_Selected_File {Action} {

    global Currently_Selected_File

    if [info exists Currently_Selected_File($Action)] {
	unset Currently_Selected_File($Action)
    }
}

proc Update_Currently_Selected_File {Action} {

    global File_Name_Of_Selected_Icon
    global Currently_Selected_File
    global Window_Name

    if {[info exists Window_Name($Action)]} {
	Execute "xeuca_echo Window of tool $Action is already open"
	Execute "xeuca_echo \f"
	return 0
    } else {
	set Currently_Selected_File($Action) $File_Name_Of_Selected_Icon
	return 1
    }
}

proc Help_Window_Initialize {} {

 global env

 if [winfo exists .top_help] then {

   wm deiconify .top_help
   raise .top_help
   return
 }
  toplevel .top_help

  wm minsize .top_help 75 32
  wm title .top_help "Eucalyptus Help"

  frame .top_help.frame_menu \
        -borderwidth 1 \
        -relief raised

  frame .top_help.frame_text \
        -borderwidth 1 \
        -relief raised

  button .top_help.index_button \
        -command {Help_Show_Index} \
        -text "Help Index"

  button .top_help.versions_button \
        -command {Help_Show_Versions} \
        -text "Tool Versions"

  button .top_help.test_button \
        -command {Help_Show_Test} \
        -text "Installation Check"

  button .top_help.done_button \
        -command {destroy .top_help} \
        -text Done

  text .top_help.text \
	-height 40 \
	-setgrid true \
	-width 80 \
	-wrap word \
	-yscrollcommand ".top_help.scroll set" \
        -font $env(XEUCA_RIGHT_WINDOW_FONT)

  scrollbar .top_help.scroll\
	 -command ".top_help.text yview"

  pack .top_help.index_button .top_help.versions_button .top_help.test_button .top_help.done_button \
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

  set tag_num 1
  foreach item $list \
    {
    set str [lindex $item 0]
    set length [string length $str]
    .top_help.text insert end " $str " "$tag_suf$tag_num"
    if "[expr $tag_num%$mod]" \
      {
      for {set i 0} {$i<[expr $max_length-$length-2]} {incr i} \
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
                            "Help_Show_File {[lindex $item 1]}"
    incr tag_num
    }
  }

proc Help_Show_Index {} {

  global help_tools_list help_files_list help_functions_list

  .top_help.text configure -state normal
  .top_help.text delete 0.0 end
  .top_help.text tag configure title \
	-underline 1

  .top_help.text insert 0.0 "\t\t\t\tTools help\n" title
  .top_help.text insert end "\n"
  Help_Show_List $help_tools_list tools

  .top_help.text insert end "\n"
  .top_help.text insert end "\n"
  .top_help.text insert end "\t\t\t\tFiles help\n" title
  .top_help.text insert end "\n"
  Help_Show_List $help_files_list files

  .top_help.text insert end "\n"
  .top_help.text insert end "\t\t\t\tFunctions help\n" title
  .top_help.text insert end "\n"
  Help_Show_List $help_functions_list functions
  .top_help.text configure -state disabled
  }

proc Help_Show_File {Command} {

  .top_help.text configure -state normal
  .top_help.text delete 0.0 end
  if [string match cadp_postscript* $Command] {

     Execute_Shell_Background "$Command"
     Help_Show_Index
  } else {

     .top_help.text insert end [Execute_Shell "$Command"]
     .top_help.text configure -state disabled
  }
  }

proc Help_Command {} {

  global env help_tools_list help_files_list help_functions_list

  set help_tools_list [subst \
       {{{EUCALYPTUS}			{xeuca_man -cadp xeuca}} \
	{{ALDEBARAN}			{xeuca_man -cadp aldebaran}} \
	{{BCG Tools}			{xeuca_man -cadp bcg}} \
	{{BCG_CMP}			{xeuca_man -cadp bcg_cmp}} \
	{{BCG_DRAW}			{xeuca_man -cadp bcg_draw}} \
	{{BCG_EDIT}			{xeuca_man -cadp bcg_edit}} \
	{{BCG_GRAPH}			{xeuca_man -cadp bcg_graph}} \
	{{BCG_INFO}			{xeuca_man -cadp bcg_info}} \
	{{BCG_IO}			{xeuca_man -cadp bcg_io}} \
	{{BCG_LABELS}			{xeuca_man -cadp bcg_labels}} \
	{{BCG_LIB}			{xeuca_man -cadp bcg_lib}} \
	{{BCG_MERGE}			{xeuca_man -cadp bcg_merge}} \
	{{BCG_MIN}			{xeuca_man -cadp bcg_min}} \
	{{BCG_OPEN}			{xeuca_man -cadp bcg_open}} \
	{{BCG_STEADY}			{xeuca_man -cadp bcg_steady}} \
	{{BCG_TRANSIENT}		{xeuca_man -cadp bcg_transient}} \
	{{BES_SOLVE}			{xeuca_man -cadp bes_solve}} \
	{{BISIMULATOR}			{xeuca_man -cadp bisimulator}} \
	{{CAESAR}			{xeuca_man -cadp caesar}} \
	{{CAESAR.ADT}			{xeuca_man -cadp caesar.adt}} \
	{{CAESAR.BDD}			{xeuca_man -cadp caesar.bdd}} \
	{{CAESAR.INDENT}		{xeuca_man -cadp caesar.indent}} \
	{{CONTRIBUTOR}			{xeuca_man -cadp contributor}} \
	{{CUNCTATOR}			{xeuca_man -cadp cunctator}} \
	{{DECLARATOR}			{xeuca_man -cadp declarator}} \
	{{DETERMINATOR}			{xeuca_man -cadp determinator}} \
	{{DISTRIBUTOR}			{xeuca_man -cadp distributor}} \
	{{EVALUATOR}			{xeuca_man -cadp evaluator}} \
	{{EVALUATOR3}			{xeuca_man -cadp evaluator3}} \
	{{EVALUATOR4}			{xeuca_man -cadp evaluator4}} \
	{{EVALUATOR5}			{xeuca_man -cadp evaluator5}} \
	{{EXECUTOR}			{xeuca_man -cadp executor}} \
	{{EXHIBITOR}			{xeuca_man -cadp exhibitor}} \
	{{EXP.OPEN}			{xeuca_man -cadp exp.open}} \
	{{FSP2LOTOS}			{xeuca_man -cadp fsp2lotos}} \
	{{FSP.OPEN}			{xeuca_man -cadp fsp.open}} \
	{{GENERATOR}			{xeuca_man -cadp generator}} \
	{{INSTALLATOR}			{xeuca_man -cadp installator}} \
	{{LNT2LOTOS}			{xeuca_man -cadp lnt2lotos}} \
	{{LNT.OPEN}			{xeuca_man -cadp lnt.open}} \
	{{LOTOS.OPEN}			{xeuca_man -cadp lotos.open}} \
	{{LPP}				{xeuca_man -cadp lpp}} \
	{{NUPN_INFO}			{xeuca_man -cadp nupn_info}} \
	{{OCIS}				{xeuca_man -cadp ocis}} \
	{{OPEN/CAESAR}			{cadp_postscript "$env(CADP)/doc/ps/Garavel-92-a.ps.Z"}} \
	{{PBG_CP}			{xeuca_man -cadp pbg_cp}} \
	{{PBG_INFO}			{xeuca_man -cadp pbg_info}} \
	{{PBG_MV}			{xeuca_man -cadp pbg_mv}} \
	{{PBG_RM}			{xeuca_man -cadp pbg_rm}} \
	{{PREDICTOR}			{xeuca_man -cadp predictor}} \
	{{PROJECTOR}			{xeuca_man -cadp projector}} \
	{{REDUCTOR}			{xeuca_man -cadp reductor}} \
	{{SCRUTATOR}			{xeuca_man -cadp scrutator}} \
	{{SEQ.OPEN}			{xeuca_man -cadp seq.open}} \
	{{SIMULATOR}			{xeuca_man -cadp simulator}} \
	{{SVL}				{xeuca_man -cadp svl}} \
	{{TERMINATOR}			{xeuca_man -cadp terminator}} \
	{{TGV}				{xeuca_man -cadp tgv}} \
	{{TST}				{xeuca_man -cadp tst}} \
	{{XEUCA}			{xeuca_man -cadp xeuca}} \
	{{XSIMULATOR}			{xeuca_man -cadp xsimulator}} \
	{{XTL}				{xeuca_man -cadp xtl}} \
	}
]
  set help_files_list [subst \
	"{{AUT files}			{xeuca_man -cadp aut}} \
	{{BCG files}			{xeuca_man -cadp bcg}} \
	{{BES files}			{xeuca_man -cadp bes}} \
	{{C programs}			{xeuca_man -euca ft.C_Programs}} \
	{{Error files}			{xeuca_man -euca ft.Error_files}} \
	{{EXP files}			{xeuca_man -cadp exp}} \
	{{GCF files}			{xeuca_man -cadp gcf}} \
	{{Hiding files}			{xeuca_man -cadp caesar_hide_1}} \
	{{Labelled Transition Systems}	{xeuca_man -euca ft.Labelled_Transition_Systems}} \
	{{LOTOS specifications}		{xeuca_man -cadp lotos}} \
	{{LOTOS libraries}		{xeuca_man -euca ft.LOTOS_Libraries}} \
	{{MCL files}			{xeuca_man -cadp mcl}} \
	{{MCL3 files}			{xeuca_man -cadp mcl3}} \
	{{MCL4 files}			{xeuca_man -cadp mcl4}} \
	{{MCL5 files}			{xeuca_man -cadp mcl5}} \
	{{NUPN files}			{xeuca_man -cadp nupn}} \
	{{PBG files}			{xeuca_man -cadp pbg}} \
	{{RBC files}			{xeuca_man -cadp rbc}} \
	{{Renaming files}		{xeuca_man -cadp caesar_rename_1}} \
	{{SEQ files}			{xeuca_man -cadp seq}} \
	{{SVL files}			{xeuca_man -cadp svl-lang}} \
	{{XTL files}			{xeuca_man -cadp xtl-lang}}"]

  set help_functions_list [subst \
       "{{Edit}				{xeuca_man -euca fnc.Edit}} \
	{{Display}			{xeuca_man -euca fnc.Display}} \
	{{Compile}			{xeuca_man -euca fnc.Compile}} \
	{{Compile abstract data types}	{xeuca_man -euca fnc.Compile_ADTs}} \
	{{Reduce}			{xeuca_man -euca fnc.Reduce}} \
 	{{Compare}			{xeuca_man -euca fnc.Compare}} \
	{{Info}				{xeuca_man -euca fnc.Info}} \
	{{Deadlock}			{xeuca_man -euca fnc.Deadlock}} \
	{{Livelock}			{xeuca_man -euca fnc.Livelock}} \
	{{KILL}				{xeuca_man -euca fnc.KILL}} \
	{{CANCEL}			{xeuca_man -euca fnc.CANCEL}} \
	{{EXIT}				{xeuca_man -euca fnc.EXIT}}"]
  Help_Window_Initialize
  Help_Show_Index
  }

proc Help_Show_Versions {} {

  global env

  .top_help.text configure -state normal
  .top_help.text delete 0.0 end
  .top_help.text tag configure title \
	-underline 1

  .top_help.text insert 0.0 "VERSION NUMBERS OF THE CADP COMPONENTS\n" title
  .top_help.text insert end "\n"

  set Tool_Version [Execute_Shell "xeuca_version \"$env(CADP)\" cadp"]
  .top_help.text insert end "CADP               : $Tool_Version\n"

  set Tool_Version [Execute_Shell "xeuca_version \"$env(CADP)\" . aldebaran -version"]
  .top_help.text insert end "ALDEBARAN          : $Tool_Version\n"

  set Tool_Version [Execute_Shell "xeuca_version \"$env(CADP)\" bcg cat \"$env(CADP)/VERSION\""]
  .top_help.text insert end "BCG                : $Tool_Version\n"

  set Tool_Version [Execute_Shell "xeuca_version \"$env(CADP)\" . bcg_cmp -version"]
  .top_help.text insert end "BCG_CMP            : $Tool_Version\n"

  set Tool_Version [Execute_Shell "xeuca_version \"$env(CADP)\" . bcg_min -version"]
  .top_help.text insert end "BCG_MIN            : $Tool_Version\n"

  set Tool_Version [Execute_Shell "xeuca_version \"$env(CADP)\" . cadp_lib -version"]
  .top_help.text insert end "CADP_LIB           : $Tool_Version\n"

  set Tool_Version [Execute_Shell "xeuca_version \"$env(CADP)\" . caesar -version"]
  .top_help.text insert end "CAESAR             : $Tool_Version\n"

  set Tool_Version [Execute_Shell "xeuca_version \"$env(CADP)\" . caesar.adt -version"]
  .top_help.text insert end "CAESAR.ADT         : $Tool_Version\n"

  set Tool_Version [Execute_Shell "xeuca_version \"$env(CADP)\" . caesar.bdd -version"]
  .top_help.text insert end "CAESAR.BDD         : $Tool_Version\n"

  set Tool_Version [Execute_Shell "xeuca_version \"$env(CADP)\" . caesar.indent -version"]
  .top_help.text insert end "CAESAR.INDENT      : $Tool_Version\n"

  set Tool_Version [Execute_Shell "xeuca_version \"$env(CADP)\" evaluator3 cat \"$env(CADP)/VERSION\""]
  .top_help.text insert end "EVALUATOR3         : $Tool_Version\n"

  set Tool_Version [Execute_Shell "xeuca_version \"$env(CADP)\" evaluator4 cat \"$env(CADP)/VERSION\""]
  .top_help.text insert end "EVALUATOR4         : $Tool_Version\n"

  set Tool_Version [Execute_Shell "xeuca_version \"$env(CADP)\" evaluator5 cat \"$env(CADP)/VERSION\""]
  .top_help.text insert end "EVALUATOR5         : $Tool_Version\n"

  set Tool_Version [Execute_Shell "xeuca_version \"$env(CADP)\" . exp.open -version"]
  .top_help.text insert end "EXP.OPEN           : $Tool_Version\n"

  set Tool_Version [Execute_Shell "xeuca_version \"$env(CADP)\" . fsp2lotos -version"]
  .top_help.text insert end "FSP2LOTOS          : $Tool_Version\n"

  set Tool_Version [Execute_Shell "xeuca_version \"$env(CADP)\" . lnt2lotos -version"]
  .top_help.text insert end "LNT2LOTOS          : $Tool_Version\n"

  set Tool_Version [Execute_Shell "xeuca_version \"$env(CADP)\" . lpp -version"]
  .top_help.text insert end "LPP                : $Tool_Version\n"

  set Tool_Version [Execute_Shell "xeuca_version \"$env(CADP)\" . mcl_expand -version"]
  .top_help.text insert end "MCL_EXPAND         : $Tool_Version\n"

  set Tool_Version [Execute_Shell "xeuca_version \"$env(CADP)\" ocis cat \"$env(CADP)/VERSION\""]
  .top_help.text insert end "OCIS               : $Tool_Version\n"

  set Tool_Version [Execute_Shell "xeuca_version \"$env(CADP)\" open.caesar cat \"$env(CADP)/VERSION\""]
  .top_help.text insert end "OPEN/CAESAR        : $Tool_Version\n"

  set Tool_Version [Execute_Shell "xeuca_version \"$env(CADP)\" projector cat \"$env(CADP)/VERSION\""]
  .top_help.text insert end "PROJECTOR          : $Tool_Version\n"

  set Tool_Version [Execute_Shell "xeuca_version \"$env(CADP)\" reductor cat \"$env(CADP)/VERSION\""]
  .top_help.text insert end "REDUCTOR           : $Tool_Version\n"

  set Tool_Version [Execute_Shell "xeuca_version \"$env(CADP)\" . seq.open -version"]
  .top_help.text insert end "SEQ.OPEN           : $Tool_Version\n"

  set Tool_Version [Execute_Shell "xeuca_version \"$env(CADP)\" . svl -version"]
  .top_help.text insert end "SVL                : $Tool_Version\n"

  set Tool_Version [Execute_Shell "xeuca_version \"$env(CADP)\" tgv cat \"$env(CADP)/VERSION\""]
  .top_help.text insert end "TGV                : $Tool_Version\n"

  set Tool_Version [Execute_Shell "xeuca_version \"$env(CADP)\" . xtl -version"]
  .top_help.text insert end "XTL                : $Tool_Version\n"

  set Date [Execute_Shell "xeuca_version $env(CADP) date"]
  .top_help.text insert end "\n\[$Date\]\n"
  .top_help.text configure -state disabled
  }

proc Help_Show_Test {} {

  .top_help.text configure -state normal
  .top_help.text delete 0.0 end

  .top_help.text insert end [Execute_Shell "tst"]
  .top_help.text configure -state disabled
}

set Background_Width 216

set Background_Height 144 

set Background_Double_Width [expr 2 * $Background_Width]

proc Sort_Icon_List {Order_Function List_Of_Icons} {

    if {$Order_Function == {}} then {

        set Temporary_List [lsort $List_Of_Icons]
    } else {

        set Temporary_List [lsort -command $Order_Function $List_Of_Icons]
    }

    set Position_In_List [lsearch $Temporary_List ".."]

    set Temporary_List [lreplace $Temporary_List $Position_In_List $Position_In_List]

    set Temporary_List ".. $Temporary_List"
    return $Temporary_List
}

proc MakeIcons {} {

global env
global Menu
global CurrentDir
global Status
global RegExp
global Icon_Directory
global Background_Width
global Background_Height
global Background_Double_Width
global File_Display
global File_Sorting
global Kind_List
global Dir_Icon_Bg_Color
global Dir_Icon_Fg_Color
global File_Icon_Bg_Color
global File_Icon_Fg_Color

if [expr [winfo exists .f1.fileswindow] == 0] {return}

    .f1.fileswindow delete all

    foreach Child [winfo children .f1.fileswindow] {
        destroy $Child
    }

    image create photo .f1.fileswindo -format GIF -file [Locate_Screen_Background]

    set All_Files_And_Directories [lsort [glob -nocomplain *]]

    if [expr [string compare $Status(Kind_Directory) Visible] == 0] then {
        set Icon_List {..}
    } else {
        set Icon_List {}
    }

    foreach Icon_Name $All_Files_And_Directories {
       set Kind [Search_Kind $Icon_Name]
       if [expr [string compare $Status($Kind) Visible] == 0] then {
          lappend Icon_List $Icon_Name
       }
    }

    switch $File_Sorting {
       Sort_by_Types { }
       Sort_by_Names { set Icon_List [Sort_Icon_List {} $Icon_List] }
       Sort_by_Dates { set Icon_List [Sort_Icon_List Older_Than_Sort $Icon_List] }
    }

    set Number_Files  -1
    set X 0
    set Y -1

    switch $File_Display {
       Display_with_Icons {
          set Nb_Icons_Per_Line 4
          set Icon_Width 60
          set Icon_Height 60
          set Magic_A 50
          set Magic_B 200
          set Magic_X 110
          set Magic_Y 100
       }
       Display_without_Icons {
          set Nb_Icons_Per_Line 2
          set Icon_Width 20
          set Icon_Height 1
          set Magic_A 160
          set Magic_B 160
          set Magic_X 180
          set Magic_Y 50
       }
    }

    switch $File_Display {
       Display_with_Icons {
          foreach Icon_Name $Icon_List {
              incr Number_Files 
              if {[expr $Number_Files % $Nb_Icons_Per_Line ] == 0} {
                     set X 0
		     .f1.fileswindow create image 0 [expr 200 + $Background_Height * $Y] -image .f1.fileswindo
		     .f1.fileswindow create image $Background_Width [expr 200 + $Background_Height * $Y] -image .f1.fileswindo
		     .f1.fileswindow create image $Background_Double_Width [expr 200 + $Background_Height * $Y] -image .f1.fileswindo
                     incr Y
              } 
              set Kind [Search_Kind $Icon_Name]

              if [expr [string compare $Kind Kind_Directory] == 0] then {

              		button .f1.fileswindow.button$Number_Files \
			   -relief raised -borderwidth 1 \
			   -bitmap @$Icon_Directory/[Search_Icon $Icon_Name] \
			   -width $Icon_Width -height $Icon_Height \
                           -background $Dir_Icon_Bg_Color \
                           -foreground $Dir_Icon_Fg_Color \
			   -command [subst {Enter_Directory "$Icon_Name"}]
	      } else {

			menubutton .f1.fileswindow.button$Number_Files \
			   -relief raised -borderwidth 1 \
			   -bitmap @$Icon_Directory/[Search_Icon $Icon_Name] \
			   -width $Icon_Width -height $Icon_Height \
                           -background $File_Icon_Bg_Color \
                           -foreground $File_Icon_Fg_Color \
			   -menu .f1.fileswindow.button$Number_Files.menu
			menu .f1.fileswindow.button$Number_Files.menu \
			   -tearoff 0 \
			   -postcommand [subst {Create_Menu .f1.fileswindow.button$Number_Files.menu "$Icon_Name" $Kind}]

			bind .f1.fileswindow.button$Number_Files <2> [bind Menubutton <1>]
			bind .f1.fileswindow.button$Number_Files <3> [bind Menubutton <1>]
	      }

              .f1.fileswindow create window\
                     [expr 20 + $X * $Magic_X] [expr 20 + $Magic_Y * $Y] \
                     -window .f1.fileswindow.button$Number_Files -anchor nw

              .f1.fileswindow create text\
                     [expr 50 + $X * $Magic_X] [expr 100 + $Magic_Y * $Y] \
                     -text "$Icon_Name" -justify center \
                     -width 90 \
		     -font $env(XEUCA_LEFT_WINDOW_FONT)
              incr X
              }
          if [winfo exists .f1.s2] {destroy .f1.s2}
          .f1.fileswindow yview moveto 0
          scrollbar .f1.s2 -borderwidth 1 -relief flat -command {.f1.fileswindow yview}
          .f1.fileswindow configure -yscrollcommand {.f1.s2 set}
          .f1.fileswindow configure -scrollregion "0 0 [expr $Magic_A + $X * $Magic_X] [expr $Magic_B + $Magic_Y * $Y]"
          pack .f1.s2 -side left -fill y
       } 
    Display_without_Icons {  
          foreach Icon_Name $Icon_List {
              incr Number_Files 
              if {[expr $Number_Files % $Nb_Icons_Per_Line ] == 0} {
                     set X 0
		     .f1.fileswindow create image 0 [expr 200 + $Background_Height * $Y] -image .f1.fileswindo
		     .f1.fileswindow create image $Background_Width [expr 200 + $Background_Height * $Y] -image .f1.fileswindo
		     .f1.fileswindow create image $Background_Double_Width [expr 200 + $Background_Height * $Y] -image .f1.fileswindo
                     incr Y
              }  
              set Kind [Search_Kind $Icon_Name]
              if [expr [string compare $Kind Kind_Directory] == 0] then {

			button .f1.fileswindow.button$Number_Files \
			   -relief raised -borderwidth 1 \
			   -text $Icon_Name \
			   -width $Icon_Width -height $Icon_Height \
                           -background $Dir_Icon_Bg_Color \
                           -foreground $Dir_Icon_Fg_Color \
			   -font $env(XEUCA_LEFT_WINDOW_FONT) \
			   -command [subst {Enter_Directory "$Icon_Name"}]
              } else {

			menubutton .f1.fileswindow.button$Number_Files \
			   -relief raised -borderwidth 1 \
			   -text $Icon_Name \
			   -width $Icon_Width -height $Icon_Height \
                           -background $File_Icon_Bg_Color \
                           -foreground $File_Icon_Fg_Color \
			   -font $env(XEUCA_LEFT_WINDOW_FONT) \
			   -menu .f1.fileswindow.button$Number_Files.menu

			menu .f1.fileswindow.button$Number_Files.menu \
			   -tearoff 0 \
			   -postcommand [subst {Create_Menu .f1.fileswindow.button$Number_Files.menu "$Icon_Name" $Kind}]

			bind .f1.fileswindow.button$Number_Files <2> [bind Menubutton <1>]
			bind .f1.fileswindow.button$Number_Files <3> [bind Menubutton <1>]
              }

              .f1.fileswindow create window\
                     [expr 20 + $X * $Magic_X] [expr 20 + $Magic_Y * $Y] \
                     -window .f1.fileswindow.button$Number_Files -anchor nw

              incr X
              }
          if [winfo exists .f1.s2] {destroy .f1.s2}
          .f1.fileswindow yview moveto 0
          scrollbar .f1.s2 -borderwidth 1 -relief flat -command {.f1.fileswindow yview}
          .f1.fileswindow configure -yscrollcommand {.f1.s2 set}
          .f1.fileswindow configure -scrollregion "0 0 [expr $Magic_A + $X * $Magic_X] [expr $Magic_B + $Magic_Y * $Y]"
          pack .f1.s2 -side left -fill y
          }
    }
    if { $Y < 25} {
        for {set Y2 $Y} {$Y2 < 7} {incr Y2} {
              .f1.fileswindow create image 0 [expr 200 + $Background_Height * $Y2] -image .f1.fileswindo
              .f1.fileswindow create image $Background_Width [expr 200 + $Background_Height * $Y2] -image .f1.fileswindo
              .f1.fileswindow create image $Background_Double_Width [expr 200 + $Background_Height * $Y2] -image .f1.fileswindo
        }
    }
}

proc Search_Icon {Icon_Name} {

    if [file isdirectory $Icon_Name] { 
       switch -- $Icon_Name {
	    ..			{ return icon_father.xbm }
	    doc			{ return icon_doc.xbm }
	    games		{ return icon_games.xbm }
	    man 		{ return icon_doc.xbm }
	    old			{ return icon_old.xbm }
       }
       switch -regexp -- $Icon_Name {
	    bin[.]sun.*		{ return icon_sun.xbm }
	    demo.*		{ return icon_doc.xbm }
	    .*[.]old		{ return icon_old.xbm }
	    default	 	{ return icon_directory.xbm }
       }
    }

    regsub \.exe$ $Icon_Name {} Icon_Name
    switch -- $Icon_Name {
	HISTORY		{ return icon_time.xbm }
	PREHISTORY	{ return icon_time.xbm }
	LICENSE		{ return icon_license.xbm }
	README		{ return icon_info.xbm }
	=READ_ME.txt	{ return icon_info.xbm }
	VERSION		{ return icon_time.xbm }
	USERS		{ return icon_users.xbm }

	aldebaran	{ return icon_aldebaran.xbm }
	caesar		{ return icon_caesar.xbm }
	caesar.adt	{ return icon_caesar_adt.xbm }
	core		{ return icon_core.xbm }
	exp2c		{ return icon_open.xbm }
	cadp_hostinfo	{ return icon_license.xbm }
	libcaesar.a	{ return icon_open.xbm }
	libexpopen.a	{ return icon_open.xbm }
	rfl		{ return icon_license.xbm }
	tst		{ return icon_info.xbm }
	upc		{ return icon_time.xbm }
    }
    switch -regexp -- $Icon_Name {
	INSTALLATION.*	{ return icon_info.xbm }
	.*~		{ return icon_backup.xbm }
	\#.*\#		{ return icon_backup.xbm }
	xeuca.*		{ return icon_eucalyptus.xbm }
        [Mm]akefile.*	{ return icon_makefile.xbm }
	libbcg.*	{ return icon_bcg_lib.xbm }
	libBCG.*	{ return icon_bcg_lib.xbm }
	.*[._]open	{ return icon_open.xbm }
	bcg_.*		{ return icon_bcg_tool.xbm }
	.*tor$		{ return icon_open_tool.xbm }
	.*tor[.][aoci]	{ return icon_open_tool.xbm }
	.*[.]ps[.]Z	{ return icon_postscript.xbm }
	.pdf		{ return icon_pdf.xbm }
    }
    switch [file extension $Icon_Name] {
	.aut		{ return icon_aut.xbm }
	.bcg		{ return icon_bcg.xbm }
	.fc2		{ return icon_aut.xbm }
	.err		{ return icon_err.xbm }
	.exp		{ return icon_exp.xbm }
        .hid 		{ return icon_hide.xbm }
        .hide 		{ return icon_hide.xbm }
	.l		{ return icon_lotos.xbm }
	.lib		{ return icon_lotos.xbm }
	.lot  		{ return icon_lotos.xbm }
	.lotos		{ return icon_lotos.xbm }
	.lnt		{ return icon_lnt.xbm }
	.lts		{ return icon_fsp.xbm }
	.mcl		{ return icon_mcl.xbm }
        .ren	 	{ return icon_rename.xbm }
        .rename 	{ return icon_rename.xbm }
	.seq		{ return icon_seq.xbm }

	.pp		{ return icon_xtl.xbm }
	.xtl		{ return icon_xtl.xbm }

	.c		{ return icon_c.xbm }
	.h		{ return icon_h.xbm }
	.f		{ return icon_h.xbm }
	.t		{ return icon_h.xbm }
	.a		{ return icon_a.xbm }
	.o		{ return icon_o.xbm }
	.s		{ return icon_s.xbm }
	.y		{ return icon_y.xbm }

	.ps		{ return icon_postscript.xbm }
	.eps		{ return icon_postscript.xbm }

	.txt		{ return icon_info.xbm }
	.tex		{ return icon_tex.xbm }
	.sdl 		{ return icon_sdl.xbm }
	.svl 		{ return icon_svl.xbm }
        default		{ return icon_file.xbm }
    }
}

proc Search_Kind {Icon_Name} {
   global Kind_List
   global RegExp
   global Status

   if [file isdirectory $Icon_Name] { 
       return Kind_Directory
   } elseif [file isfile $Icon_Name] {
       foreach Kind $Kind_List {
           if {[expr [string compare $Status($Kind) "Transparent"] != 0] && \
               [regexp -- $RegExp($Kind) $Icon_Name]} then {
               return $Kind
           }
       }
   }
   return Kind_Other
}

proc Enter_Directory {Name_Of_Directory} {

    if [catch {cd "$Name_Of_Directory"} Result] {
	Execute "xeuca_echo Directory change failed"

	Execute "xeuca_echo \f"
        return
    }
    Execute "cd \"$Name_Of_Directory\""
    Execute "xeuca_echo \f"
}

proc Update_File_Name_Of_Selected_Icon {File} {

    global File_Name_Of_Selected_Icon

    set File_Name_Of_Selected_Icon $File
}

proc Create_Menu {RootMenu Name_Of_File Kind} {

   global Menu

   Update_File_Name_Of_Selected_Icon $Name_Of_File

   $RootMenu delete 0 last

   foreach Menu_File $Menu($Kind) {
       MakeButtons $RootMenu $Menu_File
   }
}

proc Kill_Process {Process_Id} {
    Execute_Shell "xeuca_kill -9 $Process_Id"
    Display "xeuca_kill -9 $Process_Id"
}

set Window(Kill) {
	{Label "Select the process(es) to kill and click on OK"}
	{Process_Listbox Reference_Process {[Execute_Shell "xeuca_ps"]} 80 multiple}
}

set Commands(Kill) {
	{
	global Reference_Process
	global Selected_Process_Name
	foreach i $Selected_Process_Name(Reference_Process) {
		Kill_Process [lindex $i 0]
		}
	}
}

proc CreateMainWindow {} {

global env
global DescMenus
global Title_Color
global Menubar_Bg_Color
global Cadre_Color
global Screen_MaxHeight

    frame .menubar -relief raised -bd 2 -background $Menubar_Bg_Color
    pack .menubar -side top -fill x
    MakeMenuBar .menubar $DescMenus

    set Cadp_Version [Execute_Shell "xeuca_version \"$env(CADP)\" toplevel"]
    label .menubar.title -text "CADP $Cadp_Version" -font $env(XEUCA_TITLE_FONT) -background $Menubar_Bg_Color -foreground $Title_Color

    pack .menubar.title -side top 

    frame .f1
    pack .f1 -side left
    canvas .f1.fileswindow  -width 450 -height $Screen_MaxHeight -confine 1

    pack .f1.fileswindow -side left -fill both

    frame .f

    frame .f.frame2 -borderwidth 1 -relief raised

    label .f.frame2.label -text "Results Window" 

    pack .f.frame2.label -side left -padx 10 -pady 6

    button .f.frame2.button1 -text "Kill" \
           -command {global Commands_List Rule_Done

                      global Currently_Selected_File
                      set Currently_Selected_File(Kill) ""

                        if [expr [info exists Commands_List]] then {
                              if [expr [llength $Commands_List] > 0] then {
                               set Command [lindex [lindex $Commands_List 0] 0]
                               catch { Execute_Shell "xeuca_ps $Command" } Message
			       if [expr [string compare $Message ""] == 0] then {

				Make_Window_with_Buttons Kill
				Display $Rule_Done
                               } else {

                                   Kill_Process [lindex $Message 0]

                                   set Commands_List [lrange $Commands_List 1 end]
				 }
                               } else {

                                   Make_Window_with_Buttons Kill
				   Display $Rule_Done
                               }
                         } else {

                             Display "There is no process to kill."
			     Display $Rule_Done
                         }
                    }

    pack .f.frame2.button1 -side left -padx 10

    button .f.frame2.button2 -text "Clear" \
           -command { global Rule_Cleared
		      .f.t configure -state normal
                      .f.t delete 0.0 end
                      .f.t configure -state disabled
                      Display $Rule_Cleared
    }
    pack .f.frame2.button2 -side left -fill x -padx 10

    pack .f.frame2 -side top -fill x 

    scrollbar .f.s1 -relief flat -command ".f.t yview"
    pack .f.s1 -side right -fill y

    text .f.t -width 250 -relief raised -yscrollcommand ".f.s1 set" -borderwidth 2 -state disabled -highlightbackground $Cadre_Color -font $env(XEUCA_RIGHT_WINDOW_FONT)

    pack .f.t   -side left -fill both

    pack .f -side left -fill both -in .
}
proc Array_Name {Variable_Name} {

    regsub -- {\(.*\)} $Variable_Name "" Array_Name
    return $Array_Name
}

proc MakeButtons {Root List} {

global Number
global Command
global Tool
global Window
global Check_Select_Color
global Radio_Select_Color

        global TmpRoot
        set TmpRoot $Root

        set i 0
        foreach Characteristic $List {
             set Array($i) $Characteristic
             incr i
        }

        switch $Array(0) {
            Checkbutton {
                global [Array_Name $Array(2)]
		if [expr ![info exists $Array(2)]] then {
		   switch $Array(5) {
			0 { }
			1 { set $Array(2) $Array(3) } 
			2 { set $Array(2) $Array(4) }
		   }
		}
                $Root add checkbutton \
                      -label $Array(1) \
                      -variable $Array(2) \
                      -onvalue $Array(3) \
                      -offvalue $Array(4) \
                      -selectcolor [Select_Color $Check_Select_Color] \
                      -command $Array(6)
             }

            Radiobutton {
                         global [Array_Name  $Array(2)]	
			 if [expr ![info exists $Array(2)]] then {
			    if {[subst $Array(4)] != 0} then {
				  set $Array(2) $Array(3)
			    }
			 }
                         $Root add radiobutton \
                               -label $Array(1) \
                               -variable $Array(2) \
                               -value $Array(3) \
                               -selectcolor [Select_Color $Radio_Select_Color] \
                               -command $Array(5)

                        }

            Command { $Root add command \
                           -label $Array(1) \
                           -command $Array(2)
                    }

            Window_Options { $Root add command \
                                   -label $Array(1) \
                                   -command [subst {Execute_Tool $Array(2)}]
                             Initialize_Window_Variables $Array(2)
            }

            Cascade {$Root add cascade \
                           -menu $Root.cascade[incr Number] \
                           -label $Array(1)
                     menu $Root.cascade$Number -tearoff 0

                     set Number_Current_Cascade $Number
                     for {set j 2} {$j < $i} {incr j} {
                          MakeButtons $Root.cascade$Number_Current_Cascade \
                                      $Array($j) 
                     }
            }

            Separator {$Root add separator}

        }
}

proc MakeMenu {Root Menu} {

global Number
global Menubar_Bg_Color

        set i 0
        foreach Characteristic $Menu {
             set Array($i) $Characteristic
             incr i
        }
        switch $Array(0) {
        Textmenubutton {
            menubutton $Root.menu[incr Number] \
                       -text $Array(1) \
                       -menu $Root.menu$Number.menu \
                       -background $Menubar_Bg_Color
            pack $Root.menu$Number -side $Array(2) -ipadx 2m 
            menu $Root.menu$Number.menu -tearoff 0 \
                -background $Menubar_Bg_Color
            set Number_Menu $Number
            for {set j 3} {$j < $i} {set j [expr $j + 1]} {
                 MakeButtons $Root.menu$Number_Menu.menu $Array($j)
            }
        }

        Button {

            button $Root.button[incr Number] \
                   -text $Array(1) \
                   -borderwidth 0 \
                   -command $Array(3) \
                   -highlightbackground $Menubar_Bg_Color \
                   -background $Menubar_Bg_Color
            pack $Root.button$Number -side $Array(2) -ipadx 2m
        }
        }
}

proc MakeMenuBar {Root List} {

    foreach Menu $List {
	MakeMenu $Root $Menu
    }
}

set Window(Presentation) {
     {Frame top {
        {Label "File display"}
        {Invisible_Frame left {
	   {Radiobutton "with icons" File_Display Display_with_Icons 0 {}}
	}}
        {Invisible_Frame right {
           {Radiobutton "without icons"  File_Display Display_without_Icons 0 {}}
	}}
     }}
     {Frame top {
        {Label "File sorting"}
        {Invisible_Frame left {
           {Radiobutton "by file dates" File_Sorting Sort_by_Dates 0 {}}
           {Radiobutton "by file types" File_Sorting Sort_by_Types 0 {}}
	}}
        {Invisible_Frame right {
	   {Radiobutton "by file names" File_Sorting Sort_by_Names 0 {}}
	}}
     }}
     {Frame top {
      {Label "File selection"}
        {Invisible_Frame left {
      {Checkbutton     "Directories" Status(Kind_Directory) Visible Hidden 0 {}}
      {Checkbutton     "ISO LOTOS specs" Status(Kind_Lotos) Visible Hidden 0 {}}
      {Checkbutton     "LOTOS libraries" Status(Kind_Lotos_Library) Visible Hidden 0 {}}
      {Checkbutton     "SVL scripts" Status(Kind_SVL) Visible Hidden 0 {}}
      {Checkbutton     "Composition expressions" Status(Kind_Composition_Expression) Visible Hidden 0 {}}
      {Checkbutton     "Error files" Status(Kind_Error) Visible Hidden 0 {}}
      {Checkbutton     "Labelled Transitions Systems" Status(Kind_Labelled_Transitions_System) Visible Hidden 0 {}}
      {Checkbutton     "Execution sequences" Status(Kind_Execution_Sequence) Visible Hidden 0 {}}
      {Checkbutton     "Mu-calculus formulas" Status(Kind_Mu_Calculus_Formula) Visible Hidden 0 {}}

      {Checkbutton     "Makefiles" Status(Kind_Makefile) Visible Hidden 0 {}}
	}}
        {Invisible_Frame right {
      {Checkbutton     "Hiding, renaming and I/O files" Status(Kind_Hide_Rename) Visible Hidden 0 {}}
      {Checkbutton     "Postscript files" Status(Kind_Postscript) Visible Hidden 0 {}}
      {Checkbutton     "PDF files" Status(Kind_Postscript) Visible Hidden 0 {}}
      {Checkbutton     "XTL specs" Status(Kind_Xtl) Visible Hidden 0 {}}
      {Checkbutton     "Preprocessed XTL specs" Status(Kind_Expanded_Xtl) Visible Hidden 0 {}}
      {Checkbutton     "C programs" Status(Kind_C_Programs) Visible Hidden  0 {}}
      {Checkbutton     "Core files" Status(Kind_Core) Visible Hidden 0 {}}
      {Checkbutton     "Object files" Status(Kind_Object_Files) Visible Hidden 0 {}}
      {Checkbutton     "BCG dynamic libraries" Status(Kind_BCG_Dynamic_Libraries) Visible Hidden 0 {}}
      {Checkbutton     "SVL temporary files" Status(Kind_SVL_Temporary_Files) Transparent Hidden 0 {}}

      {Checkbutton     "Other files" Status(Kind_Other) Visible Hidden 0 {}}
      }}
	}}
}

set Commands(Presentation) {
         MakeIcons
}

proc MakeRule {RuleName} {
        global env
	global Screen_Width

        set Nb_Chars [expr ($Screen_Width - $env(XEUCA_LEFT_WINDOW_WIDTH)) / $env(XEUCA_CHARACTER_WIDTH)]

        set Nb_Left_Chars [expr ($Nb_Chars - [string length $RuleName]) / 2]

	set i 0
        set Left_Rule ""
        while {[expr $i < $Nb_Left_Chars]} {
                set Left_Rule "$Left_Rule\-"
                set i [expr $i + 1]
        }

        set Nb_Right_Chars [expr $Nb_Chars - [string length $RuleName] - $Nb_Left_Chars -1]

        set i 0
        set Right_Rule ""
        while {[expr $i < ($Nb_Right_Chars)]} {
                set Right_Rule "$Right_Rule\-"
                set i [expr $i + 1]
        }
        return "$Left_Rule$RuleName$Right_Rule"
}

proc ComputeRules {} {
	global Eucalyptus_Banner
	global Screen_Width Screen_Height Screen_X_Position Screen_Y_Position
        global Rule_Done Rule_Killed Rule_Error Rule_Cleared Rule_Welcome

	scan [wm geometry .] "%dx%d+%d+%d" Current_Width Current_Height Screen_X_Position Screen_Y_Position

	if [expr $Current_Width != 1] {
		set Screen_Width $Current_Width
	}

	if [expr $Current_Height != 1] {
		set Screen_Height $Current_Height
	}

	set Rule_Done [MakeRule ""]
        set Rule_Killed [MakeRule " Killed "]
        set Rule_Error [MakeRule " Error "]
        set Rule_Cleared [MakeRule " Cleared "]
        set Rule_Welcome [MakeRule " Welcome to $Eucalyptus_Banner "]
}

set List_Arrays_To_Save {
	Status
	Option_Bisimulator
	Option_Caesar_General
	Option_Caesar
	Option_Caesar_Adt
	Option_Caesar_Indent
	Option_Evaluator
	Option_Exp_Open
	Option_Seq_Open
	Option_SVL
	Option_TGV
	Option_XTL
	Files_Associations
	}

set List_Variables_To_Save {
	Xeucarc_Version
	Screen_Background	
	Screen_Width
	Screen_Height
	Screen_MinWidth
	Screen_MinHeight
	Screen_X_Position
	Screen_Y_Position
	File_Display	
	File_Sorting
	Bg_Color
	Fg_Color
	Title_Color
	Menubar_Bg_Color
	File_Icon_Bg_Color
	File_Icon_Fg_Color
	Dir_Icon_Bg_Color
	Dir_Icon_Fg_Color
	Radio_Select_Color
	Check_Select_Color
        Disabled_Buttons_Color  
	Cadre_Color
	Xterm_Options
	C_Flags
	Pager
	SVL_Shell_Flags
	XTL_C_Flags
	XTL_Temporary_File_Location
	}

proc Save_Xeuca_Preferences {} {
	global Xeucarc_File
	global List_Variables_To_Save
	global List_Arrays_To_Save

	Normalize_Screen_Background

	set List "\n# xeucarc generated automatically by EUCALYPTUS version [Variable Eucalyptus_Version]\n"
	Execute "xeuca_echo Saving preferences in $Xeucarc_File"

	foreach Variable_Name $List_Variables_To_Save {
		global ${Variable_Name}
		set List "$List\nset ${Variable_Name} {[subst $[subst $Variable_Name]]}"	
	}
	set List "$List\n"

	foreach Array_Name $List_Arrays_To_Save {
		global ${Array_Name}
      		foreach Item [array names ${Array_Name}] {
		    set List "$List\nset ${Array_Name}($Item) {[subst $[subst $Array_Name]($Item)]}"
      		}
	}
	set List "$List\n"

	if [file exists $Xeucarc_File] then {
		set tmp [Execute_Shell "chmod +w \"$Xeucarc_File\""]
	}
	
	set File_Id [open $Xeucarc_File "w"]	
	puts $File_Id $List
	close $File_Id
	Execute "xeuca_echo \f"
}

proc Select_Color {Color} {
    global env

    if {$env(XEUCA_COLORED_RADIO_CHECK_BUTTONS) == 1} {
	return $Color
    } else {
	return ""
    }
}

proc Make_Buttons_Grey {Name_Of_Tool} {

    global List_Paths_Of_Buttons_Tool 
    global Disabled_Buttons_Color

    if {[info exists List_Paths_Of_Buttons_Tool] &&\
	    [info exists List_Paths_Of_Buttons_Tool($Name_Of_Tool)]} {
	foreach button_name $List_Paths_Of_Buttons_Tool($Name_Of_Tool) {
	    if [winfo exists $button_name] {

		if [string match *radiobutton* $button_name] {
		    set Name_Of_Variable [$button_name cget -variable]
		    global [subst $Name_Of_Variable]
		    if {[$button_name cget -value] == \
			    [subst $[subst $Name_Of_Variable]]} {
			$button_name configure -selectcolor $Disabled_Buttons_Color
		    } 
		} elseif [string match *checkbutton* $button_name] {
		    set Name_Of_Variable [$button_name cget -variable]
		    global [subst $Name_Of_Variable]
		    if {[$button_name cget -onvalue] == \
			    [subst $[subst $Name_Of_Variable]]} {
			$button_name configure -selectcolor $Disabled_Buttons_Color
		    }
		}
	    }
	}
    }
}

proc Make_Buttons_Red {Name_Of_Tool} {

    global List_Paths_Of_Buttons_Tool 
    global Check_Select_Color
    global Radio_Select_Color

    if {[info exists List_Paths_Of_Buttons_Tool] &&\
	    [info exists List_Paths_Of_Buttons_Tool($Name_Of_Tool)]} {
	foreach button_name $List_Paths_Of_Buttons_Tool($Name_Of_Tool) {
	    if [winfo exists $button_name] {
		if [string match *radiobutton* $button_name] {
		    $button_name configure -selectcolor [Select_Color $Radio_Select_Color]
		} elseif [string match *checkbutton* $button_name] {
		    $button_name configure -selectcolor [Select_Color $Check_Select_Color]
		}
	    }
	}
    }
}

proc Bind_Click {Listbox Fbox New_Item Directory_Change Ok_Button} {

      global Selected_Directory_Index
      global Selected_Directory_Name
      global Selected_File_Index
      global Selected_File_Name
      global Ok_Button_Address

      if [expr $Directory_Change == 1] then {

         set Selected_Directory_Index($Fbox) [$Listbox nearest $New_Item]
         set New_Directory [$Listbox get $Selected_Directory_Index($Fbox)]
         set Selected_Directory_Name($Fbox) [Join $Selected_Directory_Name($Fbox) $New_Directory]

         Refresh_Files_Listbox $Fbox
         set Selected_File_Index($Fbox) 0
         set Selected_File_Name($Fbox) ""

         if [string compare $Ok_Button No_Ok_Button] then {
	     $Ok_Button_Address($Ok_Button) configure -state disabled
         }
      } else {

         set Selected_File_Index($Fbox) [$Listbox nearest $New_Item]
         set Selected_File_Name($Fbox) [Join $Selected_Directory_Name($Fbox) [$Listbox get $Selected_File_Index($Fbox)]]
         if [string compare $Ok_Button No_Ok_Button] then {
             $Ok_Button_Address($Ok_Button) configure -state normal
         }
      }
}

proc Get_Selected_File {Fbox} {

    global Selected_File_Name
    if [expr [string first "*." $Selected_File_Name($Fbox)] == 0] then {
       return ""
    } else { 
      return $Selected_File_Name($Fbox)
    }
}

proc Bind_Click_Process {Listbox Pbox New_Item Multiple} {

  global Selected_Process_Index
  global Selected_Process_Name
  set Selected_Process_Index($Pbox) [$Listbox nearest $New_Item]
  if [expr [string compare $Multiple "multiple"] != 0] then {

  	set Selected_Process_Name($Pbox) [$Listbox get $Selected_Process_Index($Pbox)]
  } else {

  	set Process_Index [lsearch $Selected_Process_Name($Pbox) [$Listbox get $Selected_Process_Index($Pbox)] ]
  	if {[expr $Process_Index == -1 ] } then {
  		set Selected_Process_Name($Pbox) [linsert  $Selected_Process_Name($Pbox) 0 [$Listbox get $Selected_Process_Index($Pbox)] ]
	} else {
		set Selected_Process_Name($Pbox) [lreplace $Selected_Process_Name($Pbox) $Process_Index $Process_Index]  
	}
  }	
}

proc Get_Selected_Process {Pbox} {

   global Selected_Process_Name
   return $Selected_Process_Name($Pbox)
}

proc Restore_Initial_Values {} {

   global Save_Initial_Values

   global Selected_File_Name

   set Even_Item 0
   foreach Item [array get Save_Initial_Values] {

      if [expr $Even_Item == 0] then {

	set Variable $Item
        global $Variable
      } else {

        set $Variable $Item
      }
      set Even_Item [expr ! $Even_Item]
   }
}

proc Update_Initial_Values {} {

   global Save_Initial_Values
   global Selected_File_Name

   foreach Variable [array names Save_Initial_Values] {
        global $Variable
	set Save_Initial_Values($Variable) [subst $[subst $Variable]]
   }
}

proc Initialize_Window_Buttons_Variables {List} {

   set i 0
   foreach Characteristic $List {
      set Array($i) $Characteristic
      incr i
   }

    switch $Array(0) {

       Label {}
       Button {}
       Entry {
	  regsub -- {\(.*\)} $Array(2) "" Variable_Name
          global $Variable_Name
          if [info exists ${Variable_Name}] then {
          } else {
              set $Array(2) [subst $Array(3)]
          }
       }

       File_Entry {

	  regsub -- {\(.*\)} $Array(2) "" Variable_Name
          global $Variable_Name
          if [info exists ${Variable_Name}] then {
          } else {
              set $Array(2) [subst $Array(3)]
          }
       }

       Listbox {}

       Frame {
         foreach Button $Array(2) {
              Initialize_Window_Buttons_Variables $Button 
         }
       } 

       Invisible_Frame {
         foreach Button $Array(2) {
              Initialize_Window_Buttons_Variables $Button 
         }
       } 

       Checkbutton { 
		   global [Array_Name $Array(2)]
		   switch $Array(5) {
			0 { }
			1 { set $Array(2) $Array(3) } 
		        2 { set $Array(2) $Array(4) }
		   }
	          }

       Radiobutton {
		     global [Array_Name $Array(2)]
                     if { [subst $Array(4)] == 1} then {
                             set $Array(2) $Array(3)
                     }
		   }

       Scale {global [Array_Name $Array(7)]
	      global $Array(2)
	      global $Array(7)
	      if [info exists $Array(7)] then {
		scan [subst $[subst $Array(7)]] "-%s %s" dummy_variable $Array(2)
	      } else {
		set $Array(7) $Array(6)
		set $Array(2) $Array(5)
	      }
	     }

       Initialise {}

    }
}

proc Initialize_Window_Variables {Tool} {

global Window
    foreach Widget $Window($Tool) {
       Initialize_Window_Buttons_Variables $Widget
    }
}

proc Make_Window_Buttons {Wind List} {

global Space_Inside
global Space_Outside
global Number
global Radio_Select_Color
global Check_Select_Color

   set i 0
   foreach Characteristic $List {
      set Array($i) $Characteristic
      incr i
   }

    switch $Array(0) {

       Label {
          label $Wind.label[incr Number] \
                -text [subst $Array(1)]

	  bind $Wind.label$Number <1> [bind $Wind <1>]
	  if [info exists Array(2)] then {
		$Wind.label$Number configure -bg [subst $Array(2)]
	  }
          pack $Wind.label$Number -side top  
       }

       Label_Variable {
          global [Array_Name $Array(1)]
          label $Wind.label[incr Number] \
                -textvariable $Array(1)
	  bind $Wind.label$Number <1> [bind $Wind <1>]
          pack $Wind.label$Number \
               -side top  -padx $Space_Outside -pady $Space_Outside
       }

       Button {
          button $Wind.button[incr Number] \
                 -text $Array(1) \
                 -command $Array(2)
          bind $Wind.button$Number <1> [bind $Wind <1>]
          pack $Wind.button$Number \
               -side top
       }

       Entry {

          regsub -- {\(.*\)} $Array(2) "" Variable_Name
          global $Variable_Name
          global Variable[incr Number]
          if [info exists ${Variable_Name}] then {
          } else {
	  	set $Array(2) [subst $Array(3)]
          }
          global Save_Initial_Values
	  set Save_Initial_Values($Array(2)) [subst $[subst $Array(2)]]
          frame $Wind.frame$Number 

          bind $Wind.frame$Number <1> [bind $Wind <1>]
	  if [string compare $Array(1) ""] then {
          label $Wind.frame$Number.label \
                -text [subst $Array(1)] \
                -anchor w
	  bind $Wind.frame$Number.label <1> [bind $Wind <1>]
          pack $Wind.frame$Number.label \
               -side left 
          } 
          entry $Wind.frame$Number.entry -width 32 -textvariable $Array(2)
	  bind $Wind.frame$Number.entry <1> [bind $Wind <1>]
          pack $Wind.frame$Number.entry \
              -side right 
          pack $Wind.frame$Number -side top -fill x 

	  if [info exists Array(4)] then {
               bind $Wind.frame$Number.entry <Key-Return> $Array(4)
               }
       }

       Process_Listbox {
          frame $Wind.frame[incr Number]
          pack $Wind.frame$Number -fill both -expand yes

          listbox $Wind.frame$Number.listbox \
		  -exportselection false \
		  -width $Array(3) \
		  -selectmode $Array(4) \
                  -xscrollcommand "$Wind.frame$Number.xscrollbar set" \
                  -yscrollcommand "$Wind.frame$Number.yscrollbar set"

          scrollbar $Wind.frame$Number.yscrollbar -relief raised \
                    -command "$Wind.frame$Number.listbox yview"
          pack $Wind.frame$Number.yscrollbar -side right -fill y

          scrollbar $Wind.frame$Number.xscrollbar -relief raised \
                    -orient horizontal \
                    -command "$Wind.frame$Number.listbox xview"
          pack $Wind.frame$Number.xscrollbar -side bottom -fill x

          pack $Wind.frame$Number.listbox -side top -expand yes -fill both

          global Selected_Process_Index
          global Selected_Process_Name
	  
	  if [expr [string compare $Array(4) "multiple"] != 0] then {

          	Fill_List $Wind.frame$Number.listbox [subst $Array(2)]
          	$Wind.frame$Number.listbox selection set 0
	  	set Selected_Process_Index($Array(1)) 0
	  	set Selected_Process_Name($Array(1)) [$Wind.frame$Number.listbox get 0]
	  } else {

          	Fill_List_with_Lines $Wind.frame$Number.listbox [subst $Array(2)]
	  	set Selected_Process_Index($Array(1)) ""
	  	set Selected_Process_Name($Array(1)) ""
	  }
	  	bind $Wind.frame$Number.listbox  <1> [subst {Bind_Click_Process %W $Array(1) %y $Array(4)}]
		
       }

       Filebox {

          frame $Wind.frame[incr Number] -relief raised -borderwidth 1
	  bind $Wind.frame$Number <1> [bind $Wind <1>]

          pack $Wind.frame$Number -side left -fill both -expand yes

          label $Wind.frame$Number.label -text "Directories"
	  bind $Wind.frame$Number.label <1> [bind $Wind <1>]
	  pack $Wind.frame$Number.label -side top

	  if [info exists Array(5)] then {
               listbox $Wind.frame$Number.listbox \
		       -exportselection false -height $Array(5) \
                       -yscrollcommand "$Wind.frame$Number.scrollbar set"
	  } else {
               listbox $Wind.frame$Number.listbox \
		       -exportselection false \
                       -yscrollcommand "$Wind.frame$Number.scrollbar set"
	  }
          pack $Wind.frame$Number.listbox -side left -fill both -expand yes

          scrollbar $Wind.frame$Number.scrollbar -relief raised \
                    -command "$Wind.frame$Number.listbox yview"
          pack $Wind.frame$Number.scrollbar -side right -fill y

          global Directory_Widget
          global Selected_Directory_Index
          global Selected_Directory_Name

          set Directory_Widget($Array(1)) $Wind.frame$Number.listbox
          $Wind.frame$Number.listbox selection set 0
          set Selected_Directory_Index($Array(1)) 0
          if [string compare $Array(2) "Frame_Directory"] then {
             set Selected_Directory_Name($Array(1)) $Array(2)
          } else {
             set Selected_Directory_Name($Array(1)) [Variable Frame_Directory]
          }

          bind $Wind.frame$Number.listbox  <1> "[bind $Wind <1>] ; [subst {Bind_Click %W $Array(1) %y 1 $Array(4)}]"

          frame $Wind.frame[incr Number] -relief raised -borderwidth 1
	  bind $Wind.frame$Number <1> [bind $Wind <1>]

          pack $Wind.frame$Number -side right -fill both -expand yes

          label $Wind.frame$Number.label -text "Files"
	  bind $Wind.frame$Number.label <1> [bind $Wind <1>]
          pack $Wind.frame$Number.label -side top  

	  if [info exists Array(5)] then {
               listbox $Wind.frame$Number.listbox \
		       -exportselection false -height $Array(5) \
                       -yscrollcommand "$Wind.frame$Number.scrollbar set"
	  } else {
               listbox $Wind.frame$Number.listbox \
		       -exportselection false \
                       -yscrollcommand "$Wind.frame$Number.scrollbar set"
	  }
          pack $Wind.frame$Number.listbox -side left -fill both -expand yes

          scrollbar $Wind.frame$Number.scrollbar -relief raised \
                    -command "$Wind.frame$Number.listbox yview"
          pack $Wind.frame$Number.scrollbar -side right -fill y

	  global File_Widget
          global Selected_File_Index
          global Selected_File_Name
          global Filter

          set File_Widget($Array(1)) $Wind.frame$Number.listbox
          $Wind.frame$Number.listbox selection set 0
          set Selected_File_Index($Array(1)) 0

          set Filter($Array(1)) $Array(3)

          Refresh_Files_Listbox $Array(1)
          bind $Wind.frame$Number.listbox  <1> "[bind $Wind <1>] ; [subst {Bind_Click %W $Array(1) %y 0 $Array(4)}]"
       }

       Frame {
         frame $Wind.frame[incr Number] -relief raised -borderwidth 1
	 bind $Wind.frame$Number <1> [bind $Wind <1>]

	 if [info exists Array(3)] then {
		$Wind.frame$Number configure -background [subst $Array(3)] 
	 }
         pack $Wind.frame$Number -side $Array(1) -fill both

         set Number_Frame $Number
         foreach Button $Array(2) {
              Make_Window_Buttons $Wind.frame$Number_Frame $Button 
         }
       } 

       Exclusive_Frame {

	   if {$Array(1) != ""} {
	       global List_Paths_Of_Buttons_Tool 
	       if [info exists List_Paths_Of_Buttons_Tool($Array(1))] {
		   unset List_Paths_Of_Buttons_Tool($Array(1))
	       }
	       global Current_Active_Tool 
	       set Current_Active_Tool $Array(1)
	   }

	   frame $Wind.frame[incr Number] -relief raised -borderwidth 1

	   if {[info exists Array(4)] && $Array(4) != ""} then {
		$Wind.frame$Number configure -background [subst $Array(4)] 
	   }

	   bind $Wind.frame$Number <1> [subst $Array(5)]

           pack $Wind.frame$Number -side $Array(2) -fill both
           set Number_Frame $Number
           foreach Button $Array(3) {
	       Make_Window_Buttons $Wind.frame$Number_Frame $Button 
	   }
       } 

       Invisible_Frame {
         frame $Wind.frame[incr Number]
	 bind $Wind.frame$Number <1> [bind $Wind <1>]
         pack $Wind.frame$Number -side $Array(1) -fill both
         set Number_Frame $Number
         foreach Button $Array(2) {
              Make_Window_Buttons $Wind.frame$Number_Frame $Button 
         }
       }

       Variable {
         set Number_Frame $Number
         foreach Button [Variable $Array(1)] {
              Make_Window_Buttons $Wind $Button
         }
       }

       File_Entry {
	  set Number_Frame $Number
	  global Window
	  global Commands
	  global Selected_File_Name
	  if [string compare $Array(5) No_Ok_Button] then {
	     set Window($Array(2)) [subst {
		   {Frame top {
			   {Label "$Array(1)"}
			   {Filebox $Array(2) . "$Array(4)" [subst $Array(5)]}
		   }}
	     } ]
	  } else {
	     set Window($Array(2)) [subst {
		   {Frame top {
			   {Label "$Array(1)"}
			   {Filebox $Array(2) . "$Array(4)" No_Ok_Button}
		   }}
	     } ]
	  }
	    
	  set Commands($Array(2)) {}
	  set Tmp_Cmd "\$Ok_Button_Address([subst $Array(5)])"

	  set File_Entry_Initial_Value [subst $Array(3)]
	  if [expr [string first "*." $File_Entry_Initial_Value] != 0] then {

	     set Selected_File_Name($Array(2)) $File_Entry_Initial_Value
          } else {

             if [expr ![string compare [array names Selected_File_Name $Array(2)] ""]] then {

	        set Selected_File_Name($Array(2)) $File_Entry_Initial_Value 
	     } 
          }

	  set Script [subst { 
                {Invisible_Frame left {

                {Entry "$Array(1)" Selected_File_Name($Array(2)) "xxx" {
			if [string compare $Array(5) No_Ok_Button] then {
			    global Ok_Button_Address
			    $Tmp_Cmd configure -state normal}
			}}
                }}
                {Invisible_Frame left {
		   {Button "Browse" {Execute_Tool $Array(2)}}
                }}
	  }]
	  foreach Button $Script {
              Make_Window_Buttons $Wind $Button
          }
	}

       Radiobutton {global [Array_Name $Array(2)]

                    radiobutton $Wind.radiobutton[incr Number]\
                               -text [subst $Array(1)] \
                               -variable $Array(2) \
                               -selectcolor [Select_Color $Radio_Select_Color] \
                               -value [subst [subst $Array(3)]] \
                               -command [subst {
		                         if [info exists Array(5)] {
					     $Array(5)
					 }
				  }]
					 
		    bind $Wind.radiobutton$Number <1> [bind $Wind <1>]

	            global List_Paths_Of_Buttons_Tool 
	            global Current_Active_Tool
	            if [info exists Current_Active_Tool] {
			lappend List_Paths_Of_Buttons_Tool($Current_Active_Tool) $Wind.radiobutton$Number
		    }

		    if [expr ![string compare [subst [subst $Array(3)]] /not_installed]] then {
		       $Wind.radiobutton$Number configure -state disabled
		    }
                    pack $Wind.radiobutton$Number -side top -anchor w
                         if { [subst $Array(4)] == 1} then {
                              set $Array(2) $Array(3)
                         }
                        }

       Coloured_Radiobutton {
		    global [Array_Name $Array(2)]
		    frame $Wind.frame[incr Number] -relief raised \
		       -borderwidth 1 \
		       -background [Variable Menubar_Bg_Color]
		    bind $Wind.frame$Number <1> [bind $Wind <1>]
		    pack $Wind.frame$Number -side top -fill both

		    radiobutton $Wind.frame$Number.radiobutton \
                               -text [subst $Array(1)] \
                               -variable $Array(2) \
                               -value [subst [subst $Array(3)]] \
                               -selectcolor [Select_Color $Check_Select_Color] \
			       -highlightbackground [Variable Menubar_Bg_Color] \
			       -background [Variable Menubar_Bg_Color] \
                               -command $Array(5)
		    bind $Wind.frame$Number.radiobutton <1> [bind $Wind <1>]

		    if [expr ![string compare [subst [subst $Array(3)]] /not_installed]] then {
		       $Wind.frame$Number.radiobutton configure -state disabled
		    }
                    pack $Wind.frame$Number.radiobutton -side top -anchor w
                         if {[subst $Array(4)] == 1} then {
                              set $Array(2) $Array(3)
                         }
                    }

       Checkbutton {
		   global [Array_Name $Array(2)]
		   switch $Array(5) {
			0 { }
			1 { set $Array(2) $Array(3) } 
		        2 { set $Array(2) $Array(4) }
		   }
		   
		   checkbutton $Wind.checkbutton[incr Number]\
			 -text [subst $Array(1)] \
			 -variable $Array(2) \
                         -selectcolor [Select_Color $Check_Select_Color] \
			 -onvalue $Array(3) \
			 -offvalue $Array(4) \
			 -command [subst {
		                         if [info exists Array(6)] {
					     $Array(6)
					 }
				  }]
                   bind $Wind.checkbutton$Number <1> [bind $Wind <1>]

		    global List_Paths_Of_Buttons_Tool 
		    global Current_Active_Tool 
		    if [info exists Current_Active_Tool] {
			lappend List_Paths_Of_Buttons_Tool($Current_Active_Tool) $Wind.checkbutton$Number
		    }

		  pack $Wind.checkbutton$Number -side top -anchor w 
      }

       Scale {global $Array(2)
	      scale $Wind.scale[incr Number]\
		    -bigincrement 1 \
		    -label $Array(1) \
		    -from $Array(3) \
		    -to $Array(4) \
		    -orient horizontal \
		    -tickinterval 1 \
		    -showvalue true \
		    -variable $Array(2) \
		    -resolution 1 \
		    -length 400
	      if [info exists Array(8)] then {
		 $Wind.scale$Number configure -tickinterval $Array(8)
	      }
	      pack $Wind.scale$Number -side top 
	      }

       Initialise {

	   eval $Array(1) 
	  }

       default {
	   eval $Array(0)
       }
      }       
}

proc Fill_List {Listbox Items_List} {

    $Listbox delete 0 [$Listbox size ] 
    foreach Item $Items_List {
       $Listbox insert [$Listbox size] $Item 
    }
}

proc Fill_List_with_Lines {Listbox Items_List} {

   set End_Of_Current_Line_Index [string first "\n" $Items_List ]
   set Current_Line [string range $Items_List 0 [expr $End_Of_Current_Line_Index - 1]]
   set Remaining_Lines [string range $Items_List [expr $End_Of_Current_Line_Index + 1] end]

   $Listbox delete 0 [$Listbox size ] 

   while {[expr $End_Of_Current_Line_Index != -1]} {
	$Listbox insert [$Listbox size] $Current_Line
        set End_Of_Current_Line_Index [string first "\n" $Remaining_Lines ]
   	set Current_Line [string range $Remaining_Lines 0 [expr $End_Of_Current_Line_Index - 1]]
   	set Remaining_Lines [string range $Remaining_Lines [expr $End_Of_Current_Line_Index + 1] end]
   }
}

proc Make_Window_with_Menus {Tool} {

    global Eucalyptus_Banner
    global Number
    global Menus
    global Window
    global Window_Name

    if [info exists Window_Name($Tool)] then {
       Display "This window is already open"
       return
    }
    set Wind .window[incr Number]
    toplevel $Wind
    set Window_Name($Tool) $Wind
    wm title $Wind "$Eucalyptus_Banner"
    frame $Wind.menubar -relief raised -bd 2
    pack $Wind.menubar -side top -fill x
    MakeMenuBar $Wind.menubar $Menus($Tool)
    foreach Widget $Window($Tool) {
       Make_Window_Buttons $Wind $Widget
    }
}

proc Make_Window_with_Buttons {Tool} {

    global Eucalyptus_Banner
    global Number
    global Window
    global Disable_Ok_Button
    global Ok_Button_Address
    global Window_Name
    global Tool_Name
    set Tool_Name $Tool

    if [info exists Window_Name($Tool)] then {

	raise $Window_Name($Tool)
	return
    }

    set Wind .window[incr Number]
    set Window_Name($Tool) $Wind
    toplevel $Wind
    wm title $Wind "$Eucalyptus_Banner"
    foreach Widget $Window($Tool) {
       Make_Window_Buttons $Wind $Widget
    }

    set Current_Frame $Wind.frame[incr Number] 
    frame $Current_Frame

    button $Current_Frame.button_ok -text "OK" \
                                    -command [subst {
                                        destroy $Wind

                                        Update_Initial_Values
                                        Execute_Commands $Tool 
				        Unset_Currently_Selected_File $Tool
				    }]

    if [info exists Disable_Ok_Button($Tool)] then {
	 $Current_Frame.button_ok configure -state disabled
    }

    set Ok_Button_Address($Tool) $Current_Frame.button_ok 
    pack $Current_Frame.button_ok -side left -padx 80 -pady 2

    button $Current_Frame.button_cancel -text "Cancel" \
                                        -command [subst {
					     Restore_Initial_Values
                                             destroy $Wind

				             Unset_Currently_Selected_File $Tool
					     }]

    pack $Current_Frame.button_cancel  -side right -padx 80 -pady 2
    pack $Current_Frame -side top -fill x 

    bind $Current_Frame <Destroy> [subst {
	global Window_Name
	unset Window_Name($Tool_Name)

    }]

   global Current_Active_Tool
   if [info exists Current_Active_Tool] {
	   unset Current_Active_Tool
   }
}

set Window(Editor) {}

set Commands(Editor) {
     {Execute "cadp_edit &"}
}

set Window(Terminal) {}

set Commands(Terminal) {
     {Execute "cadp_xterm &"}
}

set Window(Bcg_Info) {}

set Commands(Bcg_Info) {		
     {	
	global Failed_Conversion

	set Tmp_File [Convert [File_Name Bcg_Info] {.bcg} ""] 
	if [expr ![string equal "$Tmp_File" $Failed_Conversion]] then {
	     Execute "bcg_info \"$Tmp_File\""
	}
     }
}

set Window(Bcg_Info_Unreachable) {}

set Commands(Bcg_Info_Unreachable) {
     {
	global Failed_Conversion

        set Tmp_File [Convert [File_Name Bcg_Info_Unreachable] {.bcg} ""]
        if [expr ![string equal "$Tmp_File" $Failed_Conversion]] then {
             Execute "bcg_info -unreachable \"$Tmp_File\""
        }
     }
}

set Window(Bcg_Info_Deadlock) {}

set Commands(Bcg_Info_Deadlock) {
     {
	global Failed_Conversion

	set Tmp_File [Convert [File_Name Bcg_Info_Deadlock] {.bcg} ""]
	if [expr ![string equal "$Tmp_File" $Failed_Conversion]] then {
	     Execute "bcg_info -deadlock \"$Tmp_File\""
	}
     }
}

set Window(Bcg_Info_Nondeterminism) {
    {Label "Find nondeterminism in [File_Name Bcg_Info_Nondeterminism]"}
    {Entry "Specified label ('-' means all labels):" Nondeterministic_Label "-" {-}}
}

set Commands(Bcg_Info_Nondeterminism) {
     {
	global Failed_Conversion

        set Tmp_File [Convert [File_Name Bcg_Info_Nondeterminism] {.bcg} "" ]
        if [expr ![string equal "$Tmp_File" $Failed_Conversion]] then {
             Execute "bcg_info -nondeterministic \"[Variable Nondeterministic_Label]\" \"$Tmp_File\""}
        }
}

set Window(Bcg_Info_Path) {
    {Label "Find a path leading to a state in [File_Name Bcg_Info_Path]"}
    {Entry "State number:" State_Number "" {}}
    {Entry "Diagnostic path file:" Result_File "path.seq" {}}
}

set Commands(Bcg_Info_Path) {
     {
	global Failed_Conversion

	set Tmp_File [Convert [File_Name Bcg_Info_Path] {.bcg} "" ]
	if [expr ![string equal "$Tmp_File" $Failed_Conversion]] then {
	     Execute "bcg_info -path \"[Variable State_Number]\" \"$Tmp_File\" | tee \"[Variable Result_File]\""}
	}
}

set Window(Bcg_Draw) {}

set Commands(Bcg_Draw) {
     {
	global Failed_Conversion

	set Tmp_File [Convert [File_Name Bcg_Draw] {.bcg} ""] 
	if [expr ![string equal "$Tmp_File" $Failed_Conversion]] then {
	     Execute "bcg_draw \"$Tmp_File\""
	}
     }
}

set Window(Bcg_Edit) {}

set Commands(Bcg_Edit) {
     {
	global Failed_Conversion

	set Tmp_File [Convert [File_Name Bcg_Edit] {.ps .bcg} "[File_Base Bcg_Edit].ps" ]
	if [expr ![string equal "$Tmp_File" $Failed_Conversion]] then {
	     Execute "bcg_edit \"$Tmp_File\""
	}
     }
}

set Window(Convert) {
   {Label "Format chosen for converting [File_Name Convert]"}
   {Invisible_Frame top {
   {Invisible_Frame left {
      {Radiobutton "Aldebaran" Option_Convert ".aut" 0 {}}
      {Radiobutton "Auto" Option_Convert ".m0" 0 {}}
      {Radiobutton "Ascii (long)" Option_Convert ".ascii" 0 {}}
      {Radiobutton "Ascii (small)" Option_Convert "-small .ascii" 0 {}}
      {Radiobutton "BCG (with label parsing)" Option_Convert "-parse .bcg" 1 {}}
      {Radiobutton "BCG (without label parsing)" Option_Convert "-unparse .bcg" 0 {}}
      {Radiobutton "CWB" Option_Convert ".cwb" 0 {}}
      {Radiobutton "ETMCC" Option_Convert ".tra" 0 {}}
      {Radiobutton "FC2 (normal)" Option_Convert ".fc2" 0 {}}
      {Radiobutton "FC2 (verbose)" Option_Convert "-verbose .fc2" 0 {}}
      {Radiobutton "GML" Option_Convert ".gml" 0 {}}
      {Radiobutton "GraphViz" Option_Convert ".dot" 0 {}}
      }}
   {Invisible_Frame right {
      {Radiobutton "(pseudo) LOTOS" Option_Convert ".lotos" 0 {}}
      {Radiobutton "MEC" Option_Convert ".mec" 0 {}}
      {Radiobutton "PIPN" Option_Convert ".auto.pro" 0 {}}
      {Radiobutton "Scan" Option_Convert ".scan" 0 {}}
      {Radiobutton "Sequence" Option_Convert ".seq" 0 {}}
      {Radiobutton "Squiggles" Option_Convert ".graph" 0 {}}
      {Radiobutton "VCG" Option_Convert ".vcg" 0 {}}
      {Radiobutton "Viscope" Option_Convert ".trans" 0 {}}
      {Radiobutton "Xesar (new)" Option_Convert ".gra" 0 {}}
      {Radiobutton "Xesar (old)" Option_Convert "-old .gra" 0 {}}
      {Radiobutton "Postscript" Option_Convert ".ps" 0 {}}
      {Radiobutton "Postscript (encapsulated)" Option_Convert ".eps" 0 {}}
      }}}}
      }

set Commands(Convert) {
	{
	global Option_Convert
	set Option_Convert_Length [llength $Option_Convert]
	if {$Option_Convert_Length == 1} {
	    set Convert_Target_Options ""
	    set Convert_Target_Extension $Option_Convert
	} elseif {$Option_Convert_Length == 2} {
	    set Convert_Target_Options [lindex $Option_Convert 0]
	    set Convert_Target_Extension [lindex $Option_Convert 1]
	}
        Execute "xeuca_convert \"[File_Name Convert]\" $Convert_Target_Extension \"[File_Base Convert]$Convert_Target_Extension\" $Convert_Target_Options"
	}
}

set Window(Exp_Convert) {
   {Frame top {
      {Label "Format chosen for converting [File_Name Exp_Convert]"}
   }}
   {Frame top {
   {Invisible_Frame left {
      {Radiobutton "FC2         " Option_Exp_Convert ".fc2" 1 {}}
   }}
   {Invisible_Frame left {
      {Radiobutton "PEP         " Option_Exp_Convert ".ll_net" 0 {}}
   }}
   {Invisible_Frame left {
      {Radiobutton "TINA        " Option_Exp_Convert ".tpn" 0 {}}
   }}
   }}
}

set Commands(Exp_Convert) {
	{
	global Option_Exp_Convert
	set Exp_Convert_Target_Extension $Option_Exp_Convert
        Execute "xeuca_convert \"[File_Name Exp_Convert]\" $Exp_Convert_Target_Extension \"[File_Base Exp_Convert]$Exp_Convert_Target_Extension\""
	}
}

set Window(Display_Labels) {}

set Commands(Display_Labels) {
	{
	global Failed_Conversion
	global env
        set Tmp_File [Convert [File_Name Display_Labels] {.bcg} ""]
        if [expr ![string equal "$Tmp_File" $Failed_Conversion]] then {
             Execute "bcg_info -labels \"$Tmp_File\" | $env(CADP)/src/com/cadp_tail -n +3"

        }
	}
} 

set Disable_Ok_Button(Hide_Labels) 1

set Window(Hide_Labels) {
   {Label "Hide the labels of [File_Name Hide_Labels]"}
   {Frame top {
	{Label "Hiding mode"}
	{Invisible_Frame left {
	   {Radiobutton "Total" Option_Hide "" 1 {}}
	}}
	{Invisible_Frame right {
	   {Radiobutton "Partial" Option_Hide "-partial" 0 {}}
	}}
   }}
   {Frame top {
	{Label "Hiding file"}
        {Filebox Hiding_File . *.{hid,hide} Hide_Labels}
   }}
   {Frame top {
        {Checkbutton "Disable parsing of BCG labels" Option_Hide_Parse "-unparse" " " 2 {}}
   }}
   {Frame top {
	{File_Entry "Result file after hiding" Specified_Result_Hide "[File_Base Hide_Labels].bcg" *.bcg No_Ok_Button}
   }}
}

set Commands(Hide_Labels) {
	{
	global Failed_Conversion

        set Tmp_File [Convert [File_Name Hide_Labels] {.bcg} ""]
        if [expr ![string equal "$Tmp_File" $Failed_Conversion]] then {
	     Execute "bcg_labels [Variable Option_Hide_Parse] -hide [Variable Option_Hide] \"[Get_Selected_File Hiding_File]\" \"$Tmp_File\" \"[Variable Selected_File_Name(Specified_Result_Hide)]\""
        }
	}
}

set Disable_Ok_Button(Rename_Labels) 1

set Window(Rename_Labels) {
   {Label "Rename the labels of [File_Name Rename_Labels]"}
   {Frame top {
	{Label "Renaming mode"}
	{Invisible_Frame left {
	   {Radiobutton "Total" Option_Rename "" 1 {}}
	}}
	{Invisible_Frame right {
	   {Radiobutton "Single partial" Option_Rename "-single" 0 {}}
	}}
	{Invisible_Frame right {
	   {Radiobutton "Multiple partial" Option_Rename "-multiple" 0 {}}
	}}
   }}
   {Frame top {
	{Label "Renaming file"}
        {Filebox Renaming_File . *.{ren,rename} Rename_Labels}
   }}
   {Frame top {
        {Checkbutton "Disable parsing of BCG labels" Option_Rename_Parse "-unparse" " " 2 {}}
   }}
   {Frame top {
	{File_Entry "Result file after renaming" Specified_Result_Rename "[File_Base Rename_Labels].bcg" *.bcg No_Ok_Button}
   }}
}

set Commands(Rename_Labels) {
	{
	global Failed_Conversion

        set Tmp_File [Convert [File_Name Rename_Labels] {.bcg} ""]
        if [expr ![string equal "$Tmp_File" $Failed_Conversion]] then {
	     Execute "bcg_labels [Variable Option_Rename_Parse] -rename [Variable Option_Rename] \"[Get_Selected_File Renaming_File]\" \"$Tmp_File\" \"[Variable Selected_File_Name(Specified_Result_Rename)]\""
        }
	}
}

set Window(Bcg_Cmp_Compare) {
    {Frame top {
	   {Label "Type of LTS"}
	   {Invisible_Frame top {
	   {Invisible_Frame left {
	       {Radiobutton "Normal LTS" Bcg_Cmp_LTS_Type "-normal" 1 {}}
	   }}
	   {Invisible_Frame right {
	      {Radiobutton "Stochastic LTS" Bcg_Cmp_LTS_Type "-rate" 0 {}}
           }   }
	   {Invisible_Frame right {
	      {Radiobutton "Probabilistic LTS" Bcg_Cmp_LTS_Type "-prob" 0 {}}
	   }}
           }}
   }}
   {Frame top {
           {Label "Comparison relation"}
	   {Invisible_Frame top {
	   {Invisible_Frame left {
	       {Radiobutton "Strong equivalence" Bcg_Cmp_Comparison_Relation "-strong" 1 {}}
	   }}
	   {Invisible_Frame right {
              {Invisible_Frame top {
		  {Radiobutton "Branching equivalence" Bcg_Cmp_Comparison_Relation "-branching" 0 {}}
		  {Radiobutton "Div-branching equivalence" Bcg_Cmp_Comparison_Relation "-divbranching" 0 {}}
              }}
	   }}
	}}
   }}
   {Frame top {
	   {Label "Other options"}
	   {Invisible_Frame top {
	   {Invisible_Frame left {
	       {Entry "Precision (for stochastic and probabilistic LTSs)" Bcg_Cmp_Epsilon "1E-6"}
	       {Entry "Floating-point numbers format in transition labels\n(for stochastic and probabilistic LTSs)" Bcg_Cmp_Format "%g"}
	       {Checkbutton "Print equivalence classes" Bcg_Cmp_Class "-class" "" 2 {}}
               {File_Entry "Output classes file        " Bcg_Cmp_Class_File "*.cla" *.cla No_Ok_Button}
           }}
           }}
   }}
}

set Commands(Bcg_Cmp_Compare) {
    {
    global Failed_Conversion

    set Tmp_File_1 [Convert [File_Name Bcg_Cmp_Compare] {.bcg} ""]
    if [string equal "$Tmp_File_1" $Failed_Conversion] then {
	return
    }

    set Tmp_File_2 [Convert [Get_Selected_File Verif_Compare_LTS] {.bcg} ""]
    if [string equal "$Tmp_File_2" $Failed_Conversion] then {
	return
    }

    if {[Variable Bcg_Cmp_Class] == "-class"} {
	if [expr ! [string compare [Get_Selected_File Bcg_Cmp_Class_File] ""]] then {
	    set Bcg_Cmp_Class_Output "\"[File_Base Bcg_Cmp_Compare].cla\""
	} else {
	    set Bcg_Cmp_Class_Output "\"[Get_Selected_File Bcg_Cmp_Class_File]\""
	}
    } else {
	set Bcg_Cmp_Class_Output ""
    }

    if {[Variable Bcg_Cmp_LTS_Type] != "-rate" && \
	    [Variable Bcg_Cmp_LTS_Type] != "-prob"} {
	set epsilon_option ""
    } elseif {[Variable Bcg_Cmp_Epsilon] == ""} {
	set epsilon_option ""
    } else {
	set epsilon_option "-epsilon \"[Variable Bcg_Cmp_Epsilon]\""
    }

    if {[Variable Bcg_Cmp_LTS_Type] != "-rate" && \
	    [Variable Bcg_Cmp_LTS_Type] != "-prob"} {
	set format_option ""
    } elseif {[Variable Bcg_Cmp_Format] == ""} {
	set format_option ""
    } else {
	set format_option "-format \"[Variable Bcg_Cmp_Format]\""
    }

    Execute "bcg_cmp [Variable Bcg_Cmp_Comparison_Relation] [Variable Bcg_Cmp_LTS_Type] [Variable Bcg_Cmp_Class] $Bcg_Cmp_Class_Output $epsilon_option $format_option -diag \"[Variable Comparison_Diagnostic_File]\" \"$Tmp_File_1\" \"$Tmp_File_2\""
}
}

proc Update_Output_File_Verif_Reduce_Bcg_Min {} {

    global Selected_File_Name 
    global Bcg_Min_Reduction_Relation

    if {$Bcg_Min_Reduction_Relation == "-strong"} {
	set Selected_File_Name(Verif_Reduce_Output) "[File_Base Verif_Reduce]_s.bcg"
    } elseif {$Bcg_Min_Reduction_Relation == "-branching"} {	
	set Selected_File_Name(Verif_Reduce_Output) "[File_Base Verif_Reduce]_b.bcg"
    } elseif {$Bcg_Min_Reduction_Relation == "-divbranching"} {	
	set Selected_File_Name(Verif_Reduce_Output) "[File_Base Verif_Reduce]_d.bcg"
    }
}

set Window(Bcg_Min_Reduce) {
    {Frame top {
	   {Label "Type of LTS"}
	   {Invisible_Frame top {
	   {Invisible_Frame left {
	       {Radiobutton "Normal LTS" Bcg_Min_LTS_Type "-normal" 1 {}}
	   }}
	   {Invisible_Frame right {
	      {Radiobutton "Stochastic LTS" Bcg_Min_LTS_Type "-rate" 0 {}}
           }   }
	   {Invisible_Frame right {
	      {Radiobutton "Probabilistic LTS" Bcg_Min_LTS_Type "-prob" 0 {}}
	   }}
           }}
   }}
   {Frame top {
           {Label "Reduction relation"}
	   {Invisible_Frame top {
	   {Invisible_Frame left {
	      {Radiobutton "Strong equivalence" Bcg_Min_Reduction_Relation "-strong" 1 {Update_Output_File_Verif_Reduce_Bcg_Min}}
	   }}
	   {Invisible_Frame right {
              {Invisible_Frame top {
	         {Radiobutton "Branching equivalence" Bcg_Min_Reduction_Relation "-branching" 0 {Update_Output_File_Verif_Reduce_Bcg_Min}}
	         {Radiobutton "Div-branching equivalence" Bcg_Min_Reduction_Relation "-divbranching" 0 {Update_Output_File_Verif_Reduce_Bcg_Min}}
              }}
	   }}
	}}
   }}
   {Frame top {
	   {Label "Other options"}
	   {Invisible_Frame top {
	   {Invisible_Frame left {
	       {Entry "Precision (for stochastic and probabilistic LTSs)" Bcg_Min_Epsilon "1E-6"}
	       {Entry "Floating-point numbers format in transition labels\n(for stochastic and probabilistic LTSs)" Bcg_Min_Format "%g"}
	       {Checkbutton "Print equivalence classes" Bcg_Min_Class "-class" "" 2 {}}
               {File_Entry "Output classes file        " Bcg_Min_Class_File "*.cla" *.cla No_Ok_Button}
           }}
           }}
   }}
}

set Commands(Bcg_Min_Reduce) {
    {
    global Failed_Conversion

    set Tmp_File_1 [Convert [File_Name Bcg_Min_Reduce] {.bcg} ""]
    if [string equal "$Tmp_File_1" $Failed_Conversion] then {
	return
    }
    global Selected_File_Name
    set Bcg_Min_Output $Selected_File_Name(Verif_Reduce_Output)

    if {[Variable Bcg_Min_Class] == "-class"} {
	if [expr ! [string compare [Get_Selected_File Bcg_Min_Class_File] ""]] then {
	    set Bcg_Min_Class_Output "\"[File_Base Bcg_Min_Reduce].cla\""
	} else {
	    set Bcg_Min_Class_Output "\"[Get_Selected_File Bcg_Min_Class_File]\""
	}
    } else {
	set Bcg_Min_Class_Output ""
    }

    if {[Variable Bcg_Min_LTS_Type] != "-rate" && \
	    [Variable Bcg_Min_LTS_Type] != "-prob"} {
	set epsilon_option ""
    } elseif {[Variable Bcg_Min_Epsilon] == ""} {
	set epsilon_option ""
    } else {
	set epsilon_option "-epsilon \"[Variable Bcg_Min_Epsilon]\""
    }

    if {[Variable Bcg_Min_LTS_Type] != "-rate" && \
	    [Variable Bcg_Min_LTS_Type] != "-prob"} {
	set format_option ""
    } elseif {[Variable Bcg_Min_Format] == ""} {
	set format_option ""
    } else {
	set format_option "-format \"[Variable Bcg_Min_Format]\""
    }

    Execute "bcg_min [Variable Bcg_Min_Reduction_Relation] [Variable Bcg_Min_LTS_Type] [Variable Bcg_Min_Class] $Bcg_Min_Class_Output $epsilon_option $format_option \"$Tmp_File_1\" \"$Bcg_Min_Output\""
	
}
}

set Window(Bcg_Steady_Transient) {
     {Frame top {
        {Label "Performance evaluation of [File_Name Bcg_Steady_Transient]"}
        {Invisible_Frame left {
           {Radiobutton "Steady analysis" Perf_Tool "bcg_steady" 1 {}}
	}}
        {Invisible_Frame right {
           {Radiobutton "Transient analysis" Perf_Tool "bcg_transient" 0 {}}
        }}
     }}
     {Frame top {
        {Label "Time instants"}
	{Entry "Time instants (for transient analysis only)" Perf_Time_Instants "" {}}
     }}
     {Frame top {
        {Label "Output files (\"-\" displays in the Results Window)"}
	{Invisible_Frame top {
	   {Entry "Solution file" Perf_Solution_File "[File_Base Bcg_Steady_Transient].sol" {}}
	   {Entry "Throughput file" Perf_Throughput_File "-" {}}
	   {Entry "Matrix file" Perf_Matrix_File "[File_Base Bcg_Steady_Transient].csv" {}}
	   {Entry "Reduced matrix file" Perf_Reduced_Matrix_File "[File_Base Bcg_Steady_Transient]_reduced.csv" {}}
	   {Entry "Log file" Perf_Log_File "[File_Base Bcg_Steady_Transient].log" {}}
	}}
     }}
	{Invisible_Frame top {
            {Label "Additional Options"}
            {Entry "Additional throughput parameters" Perf_Params "" {}}
	    {Entry "Precision (floating-point comparisons)" Perf_Epsilon "1E-6" {}}
	}}
}

set Commands(Bcg_Steady_Transient) {
     {
     Execute "[Variable Perf_Tool] -epsilon \"[Variable Perf_Epsilon]\" -sol \"[Variable Perf_Solution_File]\" -thr \"[Variable Perf_Throughput_File]\" -mat \"[Variable Perf_Matrix_File]\" -red \"[Variable Perf_Reduced_Matrix_File]\" -log \"[Variable Perf_Log_File]\" \"[File_Name Bcg_Steady_Transient]\" [Variable Perf_Params] [Variable Perf_Time_Instants]"
     }
}

set Window(Caesar_Adt) {}

set Commands(Caesar_Adt) {
   {
   Execute "caesar.adt [Get_Caesar_Options] [Array Option_Caesar_General] [Array Option_Caesar_Adt] \"[File_Name Caesar_Adt]\""
   }
}

set Window(Generate_External_Types_Functions) {}

set Commands(Generate_External_Types_Functions) {
   {
   Execute "caesar.adt [Get_Caesar_Options] [Array Option_Caesar_General] [Array Option_Caesar_Adt] -external \"[File_Name Generate_External_Types_Functions]\""
   }
}

set Window(Caesar_Indent) {}
set Commands(Caesar_Indent) {
      {Execute "caesar.indent [Array Option_Caesar_Indent] \"[File_Name Caesar_Indent]\""}
}

proc Get_Caesar_Options {} {
      set Files ""
      if [string compare [Variable C_Flags] ""] then {
          append Files "-cc '[Variable C_Flags]'"
      }
      if [string compare [Variable Pager] ""] then {
           append Files " -more '[Variable Pager]'"
      }
      return $Files 
}

set Window(Generate_LTS) {
    {Frame top {
	{Label "LTS generation for [File_Name Generate_LTS]"}
    }}
    {Frame top {
	    {Label "LTS format"}
		    {Invisible_Frame left {
                        {Radiobutton "BCG"
                                     Option_Caesar_LTS(LTS_Format)
                                     "" 1 {set Option_Caesar_LTS(Monitor) "-monitor"}
                        }
		    }}
		    {Invisible_Frame right {
                        {Radiobutton "Ascii (only for debugging)"
                                     Option_Caesar_LTS(LTS_Format)
                                     "-graph" 0 {set Option_Caesar_LTS(Monitor) ""}
                        }
		    }}
		    {Invisible_Frame right {
                        {Radiobutton "Aldebaran"
                                     Option_Caesar_LTS(LTS_Format)
                                     "-aldebaran" 0 {set Option_Caesar_LTS(Monitor) ""}
                        }
		    }}
     }}
     {Frame top {
	    {Checkbutton "Real-time monitoring during BCG graph construction" Option_Caesar_LTS(Monitor) "-monitor" "" 1 {}}
     }}
     {Frame top {
            {Label "Predict size of LTS"}
	    {Button "Try" {
		           Set_Currently_Selected_File Open_Caesar_Predictor Generate_LTS
	                   Execute_Tool Open_Caesar_Predictor
	                   Unset_Currently_Selected_File Open_Caesar_Predictor
             }}
     }}
}

set Commands(Generate_LTS) {
        {Execute "caesar.adt [Get_Caesar_Options] [Array Option_Caesar_General] [Array Option_Caesar_Adt] \"[File_Name Generate_LTS]\"" }
       {Execute "caesar [Get_Caesar_Options] [Array Option_Caesar_General] [Array Option_Caesar] [Array Option_Caesar_LTS] \"[File_Name Generate_LTS]\"" }
}

set Window(Generate_Gate_Functions) {
    {Frame top {
	{Label "Gate function generation for [File_Name Generate_Gate_Functions]"}
    }}
    {Frame top {
	    {Label "Format for C function prototypes"}
		    {Invisible_Frame left {
                        {Radiobutton "New style"
                                     Option_Gate_Functions(Style)
                                     "-newstyle" 1 {}
                        }
		    }}
		    {Invisible_Frame right {
                        {Radiobutton "Old style"
                                     Option_Gate_Functions(Style)
                                     "-oldstyle" 0 {}
                        }
		    }}
     }}
    {Frame top {
	    {Checkbutton "Indentation of generated C code" Option_Gate_Functions(Indent) " " "-indent" 1 {}}
     }}
}

set Commands(Generate_Gate_Functions) {
       {Execute "caesar.adt [Get_Caesar_Options] [Array Option_Caesar_General] [Array Option_Caesar_Adt] \"[File_Name Generate_Gate_Functions]\"" }
       {Execute "caesar [Get_Caesar_Options] [Array Option_Caesar_General] [Array Option_Caesar] -exec -external [Array Option_Gate_Functions] \"[File_Name Generate_Gate_Functions]\"" }
}

set Fsp_Next_Tool {}
set Fsp_Pid_List {}

proc Fsp_Get_Pid_List {} {
    global Fsp_Pid_List

    return $Fsp_Pid_List
}

set Option_Fsp2Lotos {}

set Window(FspOptions) {
    {Frame top {
	{Label "Translation of [File_Name FspOptions] into LOTOS"}
    }}
    {Frame top {
	{Label "Select the main FSP process"}
	{Process_Listbox Fsp_Root_Process {[Fsp_Get_Pid_List]} 50 single}
    }}
    {Frame top {
	{Checkbutton "Debug mode" Option_Fsp2Lotos_Debug "-debug" "" 2 {}}
    }}
}

set Commands(FspOptions) {{
    global Fsp_Root_Process
    global Selected_Process_Name
    global Option_Fsp2Lotos_Debug
    global Fsp_Next_Tool
    global Option_Fsp_Open

    array unset Option_Fsp_Open
    set Option_Fsp_Open(Debug) $Option_Fsp2Lotos_Debug
    set Option_Fsp_Open(Root_Process_Name) "-root $Selected_Process_Name(Fsp_Root_Process)"

    if {$Fsp_Next_Tool != {}} then {
	Execute_Tool $Fsp_Next_Tool
	set Fsp_Next_Tool {}
    } else {
	Execute "fsp.open [Array Option_Fsp_Open] \"[File_Name FspOptions]\" -"
    }
}}

set Rule(FspOptions) 1

proc Execute_Fsp_Options_Before_Tool {Action} {
    global Fsp_Next_Tool
    global File_Name_Of_Selected_Icon
    global Rule_Done
    global Fsp_Pid_List

    set Fsp_Next_Tool $Action

    if {[catch {eval exec "fsp2lotos -pidlist \"$File_Name_Of_Selected_Icon\""} Result]} {
	Display "Error in \"$File_Name_Of_Selected_Icon\":"
	Display "$Result"
	Display $Rule_Done
    } elseif {$Result == {}} {
        Display "Error in \"$File_Name_Of_Selected_Icon\":"
        Display "no potential root process found"
        Display $Rule_Done
    } else {
	set Fsp_Pid_List [lsort $Result]
	Execute_Tool FspOptions
    }
}

set Lnt_Next_Tool {}
set Lnt_Pid_List {}

proc Lnt_Get_Pid_List {} {
    global Lnt_Pid_List

    return $Lnt_Pid_List
}

set Option_Lnt2Lotos {}

set Window(Lnt_Options) {
    {Frame top {
	{Label "Translation of [File_Name Lnt_Options] into LOTOS"}
    }}
    {Frame top {
	{Label "Select the main LNT process"}
	{Process_Listbox Lnt_Root_Process {[Lnt_Get_Pid_List]} 50 single}
    }}
}

set Commands(Lnt_Options) {{
    global Lnt_Root_Process
    global Selected_Process_Name
    global Option_Lnt2Lotos_Debug
    global Lnt_Next_Tool
    global Option_Lnt_Open

    set Option_Lnt_Open(Root_Process_Name) "-root $Selected_Process_Name(Lnt_Root_Process)"

    if {$Lnt_Next_Tool != {}} then {
	Execute_Tool $Lnt_Next_Tool
	set Lnt_Next_Tool {}
    } else {
	Execute "lnt.open [Get_Caesar_Options] [Array Option_Lnt_Open] \"[File_Name Lnt_Options]\" -"
    }
}}

set Rule(Lnt_Options) 1

proc Execute_Lnt_Options_Before_Tool {Action} {
    global Lnt_Next_Tool
    global File_Name_Of_Selected_Icon
    global Rule_Done
    global Lnt_Pid_List
    global env

    set Lnt_Next_Tool $Action

    set Result_List [Execute_Shell_With_Status "lnt.open -pidlist \"$File_Name_Of_Selected_Icon\""]

    set Status [lindex $Result_List 0]
    set Result [lindex $Result_List 1]
    if {$Status != 0} {
	Display "Error in \"$File_Name_Of_Selected_Icon\":"
	Display "$Result"
	Display $Rule_Done
    } elseif {$Result == {}} {
	Display "Error in \"$File_Name_Of_Selected_Icon\":"
	Display "no potential root process found"
	Display $Rule_Done
    } else {
	set Lnt_Pid_List [lsort $Result]
	Execute_Tool Lnt_Options
    }
}

proc Execute_Open_Caesar {Action Open_Caesar_Options} {
      if [Lotos_Suffix $Action] then {
           Execute "lotos.open [Get_Caesar_Options] [Array Option_Caesar_General] [Array Option_Caesar] [Array Option_Caesar_Adt] \"[File_Name $Action]\" $Open_Caesar_Options"
      } elseif [Suffix $Action .exp] then {
           Execute "exp.open [Array Option_Exp_Open] \"[File_Name $Action]\" $Open_Caesar_Options"
      } elseif [Suffix $Action .seq] then {
           Execute "seq.open [Array Option_Seq_Open] \"[File_Name $Action]\" $Open_Caesar_Options"
      } elseif [Suffix $Action .lts] then {
           Execute "fsp.open [Array Option_Fsp_Open] \"[File_Name $Action]\" $Open_Caesar_Options"
      } elseif [Suffix $Action .lnt] then {
           Execute "lnt.open [Get_Caesar_Options] [Array Option_Lnt_Open] \"[File_Name $Action]\" $Open_Caesar_Options"
      } else {
	   global Failed_Conversion

           set Tmp_File [Convert [File_Name $Action] {.bcg} ""]
           if [expr ![string equal "$Tmp_File" $Failed_Conversion]] then {
                Execute "bcg_open \"$Tmp_File\" $Open_Caesar_Options"
           }
      }
}

set Commands(Open_Caesar_Executor) {
      {Execute_Open_Caesar Open_Caesar_Executor "executor [Variable Max_Number_Transitions] [Variable Execution_Strategy] [Variable Seed_Value] | tee \"[Variable Executor_Sequence_File]\""}
}

set Window(Open_Caesar_Executor) {
     {Label "Executor options for [File_Name Open_Caesar_Executor]"}
     {Frame top {
        {Entry "Maximal number of transitions (0 means infinity)" Max_Number_Transitions 100 }
     }}
     {Frame top {
        {Label "Execution strategy"}
        {Radiobutton "deterministic" Execution_Strategy 1 0 {}}
        {Radiobutton "non-deterministic with random seed" Execution_Strategy 2 1 {}}
        {Frame top {
           {Radiobutton "non-deterministic with given seed" Execution_Strategy 3 0 {}}
           {Entry "Seed value" Seed_Value "" }
        }}   
        {Frame top {
           {Entry "Diagnostic sequence file (output)" Executor_Sequence_File "executor.seq" } 
        }}
     }}
}

set Commands(Open_Caesar_Deadlock) {
      {
      global env
      Execute_Open_Caesar Open_Caesar_Deadlock "exhibitor [Variable Deadlock_Search_Algorithm] [Variable Deadlock_Selected_Sequence] -depth \"[Variable Deadlock_Maximal_Depth]\" < $env(XEUCADIR)/deadlock.seq | tee \"[Variable Deadlock_Sequence_File]\"" }
}

set Window(Open_Caesar_Deadlock) {
     {Frame top {
        {Label "Selected algorithm"}
	{Invisible_Frame left {
        {Radiobutton "Breadth-First Search" Deadlock_Search_Algorithm "-bfs" 1 {}}
        }}
	{Invisible_Frame right {
        {Radiobutton "Depth-First Search" Deadlock_Search_Algorithm "-dfs" 0 {}}
	}}
     }}
     {Frame top {
        {Entry "Maximal number of transitions (0 means infinity)" Deadlock_Maximal_Depth "0" }
     }}
     {Frame top {
        {Label "Selected execution sequence"}
           {Invisible_Frame left {
              {Radiobutton "Shortest one" Deadlock_Selected_Sequence "" 1 {}}
              {Radiobutton "First one" Deadlock_Selected_Sequence "-first" 0 {}}
              {Radiobutton "Decreasing size" Deadlock_Selected_Sequence "-decr" 0 {}}
           }}
           {Invisible_Frame right {
              {Radiobutton "All" Deadlock_Selected_Sequence "-all" 0 {}}
              {Radiobutton "None" Deadlock_Selected_Sequence "-none" 0 {}}
           }}
     }}
     {Frame top {
        {Entry "Diagnostic sequence file (output)" Deadlock_Sequence_File  "deadlock.seq"}
     }}
}

set Disable_Ok_Button(Open_Caesar_Exhibitor) 1

set Commands(Open_Caesar_Exhibitor) {
      {Execute_Open_Caesar Open_Caesar_Exhibitor "exhibitor [Variable Exhibitor_Search_Algorithm] [Variable Exhibitor_Selected_Sequence] -seqno \"[Variable Index_Sequence]\" [Variable Conflict_Detection] [Variable Case_Preservation] -depth \"[Variable Exhibitor_Maximal_Depth]\" < \"[Get_Selected_File Exhibitor_Files_List]\" | tee \"[Variable Exhibitor_Sequence_File]\"" }
}

set Window(Open_Caesar_Exhibitor) {
     {Label "Exhibitor options for [File_Name Open_Caesar_Exhibitor]"}
     {Frame top {
            {Label "File containing the sequence to find"}
	    {Filebox Exhibitor_Files_List . *.seq Open_Caesar_Exhibitor}
      }}
     {Frame top {
        {Label "Selected algorithm"}
        {Radiobutton "Breadth-first search" Exhibitor_Search_Algorithm "-bfs" 1 {}}
        {Radiobutton "Depth-first search" Exhibitor_Search_Algorithm "-dfs" 0 {}}
     }}
     {Frame top {
        {Entry "Maximal number of transitions (0 means infinity)" Exhibitor_Maximal_Depth "0" }
     }}
     {Frame top {
        {Entry "Index of sequence" Index_Sequence "1"}
     }}
     {Frame top {
        {Checkbutton "Differenciate lower/upper case" Case_Preservation "-case" "" 2 {}}
     }}
     {Frame top {
        {Checkbutton "Conflict detection" Conflict_Detection "-conflict" "" 2 {}}
     }}
     {Frame top {
        {Label "Selected execution sequence"}
           {Invisible_Frame left {
              {Radiobutton "Shortest one" Exhibitor_Selected_Sequence "" 1 {}}
              {Radiobutton "First one" Exhibitor_Selected_Sequence "-first" 0 {}}
              {Radiobutton "Decreasing size" Exhibitor_Selected_Sequence "-decr" 0 {}}
           }}
           {Invisible_Frame right {
              {Radiobutton "All" Exhibitor_Selected_Sequence "-all" 0 {}}
              {Radiobutton "None" Exhibitor_Selected_Sequence "-none" 0 {}}
           }}
     }}
     {Frame top {
        {Entry "Diagnostic sequence file (output)" Exhibitor_Sequence_File  "exhibitor.seq"}
     }}
}

set Commands(Open_Caesar_Terminator) {
      {Execute_Open_Caesar Open_Caesar_Terminator "terminator [Variable Terminator_Selected_Sequence] -depth \"[Variable Terminator_Maximal_Depth]\" \"[Variable Selected_Order]\" \"[Variable Size_Hash_Table1]\" [Variable Size_Hash_Table2] | tee \"[Variable Terminator_Sequence_File]\""}
}

set Window(Open_Caesar_Terminator) {
     {Frame top {
        {Entry "Maximal number of transitions (0 means infinity)" Terminator_Maximal_Depth "0" }
     }}
     {Frame top {
        {Entry "Selected order for transition firing" Selected_Order "0" }
     }}
     {Frame top {
        {Entry "Size of the first hash-table" Size_Hash_Table1 "100" }
     }}
     {Frame top {
        {Entry "Size of the second hash-table (possibly undefined)" Size_Hash_Table2 ""}
     }}
     {Frame top {
        {Label "Selected execution sequence"}
	{Invisible_Frame left {
	    {Radiobutton "Shortest one" Terminator_Selected_Sequence "" 1 {}}
	    {Radiobutton "First one" Terminator_Selected_Sequence "-first" 0 {}}
	    {Radiobutton "Decreasing size" Terminator_Selected_Sequence "-decr" 0 {}}
	}}
	{Invisible_Frame right {
	    {Radiobutton "All" Terminator_Selected_Sequence "-all" 0 {}}
	    {Radiobutton "None" Terminator_Selected_Sequence "-none" 0 {}}
	}}
     }}
     {Frame top {
        {Entry "Diagnostic sequence file (output)" Terminator_Sequence_File  "terminator.seq"}
     }}   
}

set Window(Open_Caesar_XSimulator) {}

set Commands(Open_Caesar_XSimulator) {
      {Execute_Open_Caesar Open_Caesar_XSimulator "xsimulator"}
}

set Window(Open_Caesar_Ocis) {}

set Commands(Open_Caesar_Ocis) {
      {Execute_Open_Caesar Open_Caesar_Ocis "ocis"}
}

set Disable_Ok_Button(Open_Caesar_Evaluator) 1
set Selected_File_Name(Evaluator_Files_List) ""

proc Evaluator_Diagnostic_Option {} {
   global Evaluator_Diagnostics
   global Evaluator_Diagnostic_File
   if { $Evaluator_Diagnostics == "-diag" } then {
	return "-diag $Evaluator_Diagnostic_File"
   } else {
	return ""
   }
}

set Window(Open_Caesar_Evaluator) {
     {Frame top {
	{Frame top {
	   {Label "Evaluator options for [File_Name Open_Caesar_Evaluator]"}
	}}
	{Variable Window(Open_Caesar_Evaluator_Base)}
     }}
}

set Commands(Open_Caesar_Evaluator) {
      {
      Execute_Open_Caesar Open_Caesar_Evaluator "[CommandArray Option_Evaluator "Executable"] [Variable Evaluator_Expand] [Variable Evaluator_Algorithm] [Evaluator_Diagnostic_Option] \"[Get_Selected_File Evaluator_Files_List]\"" }
}

set Window(Open_Caesar_Evaluator_Base) {
     {Frame top {
         {Frame top {
            {Checkbutton "Expand only" Evaluator_Expand "-expand" "" 0 {}}
         }}
         {Frame top {
	    {Label "File containing mu-calculus formula (*.mcl)"}
	    {Filebox Evaluator_Files_List . *.mcl {[Variable Tool_Name]}}
         }}
         {Frame top {

            {Label "Selected algorithm"}
            {Invisible_Frame top {
               {Radiobutton "Breadth-first search" Evaluator_Algorithm "-bfs" 1 {}}
            }}
            {Invisible_Frame top {
               {Radiobutton "Depth-first search (with cycles)" Evaluator_Algorithm "-dfs" 0 {}}
            }}
            {Invisible_Frame top {
               {Radiobutton "Depth-first search without cycles" Evaluator_Algorithm "-dfs -acyclic" 0 {}}
            }}
           }}
         {Frame top {
            {Checkbutton "Generation of diagnostic files" Evaluator_Diagnostics "-diag" "" 1 {}}
	    {Entry "Diagnostic file (output)" Evaluator_Diagnostic_File "evaluator.bcg"}
         }}
     }}
}

set Window(Open_Caesar_Livelock) {
     {Frame top {
        {Entry "Diagnostic file (output)" Livelock_Result_File "livelock.bcg"}
     }}
}

set Commands(Open_Caesar_Livelock) {
      {
      global Livelock_Result_File
      global env
      Execute_Open_Caesar Open_Caesar_Livelock "evaluator [Array Option_Evaluator] -diag \"$Livelock_Result_File\" \"$env(CADP)/src/xtl/livelock.mcl\""
      }
}

set Window(Open_Caesar_Generator) {
    {Frame top {
       {Label "Labelled Transition System format"}
       {Invisible_Frame left {
	   {Radiobutton "BCG" Generator_Format "generator" 1 {}}
       }}
       {Invisible_Frame right {
	   {Radiobutton "BCG reduced for tau*.a equivalence" Generator_Format "reductor" 0 {}}
       }}
    }}

    {Frame top {
        {Checkbutton "Real-time monitoring during BCG graph construction" Generator_Monitor "-monitor" "" 1 {}}
    }}

    {Frame top {
	{Label "Predict size of Labelled Transition System"}
	{Button "Try" {

	    Set_Currently_Selected_File Open_Caesar_Predictor Compositional_Generator
	    Execute_Commands Open_Caesar_Predictor
	    Unset_Currently_Selected_File Open_Caesar_Predictor
        }}
    }}
}

set Commands(Open_Caesar_Generator) {
       {
       global Generator_Format
       Execute_Open_Caesar Open_Caesar_Generator "$Generator_Format [Variable Generator_Monitor] \"[File_Base Open_Caesar_Generator].bcg\""
       }
}

set Window(Open_Caesar_Predictor) {}

set Commands(Open_Caesar_Predictor) {
      {Execute_Open_Caesar Open_Caesar_Predictor "predictor"

}
}

set Disable_Ok_Button(Open_Caesar_TGV) 1

set Commands(Open_Caesar_TGV) {
      {
      global Option_TGV
      global TGV_Hiding_Option
      global TGV_Renaming_Option
      global TGV_InputOutput_Option
      global Failed_Conversion

      if [expr ! [string compare [Get_Selected_File TGV_Hiding] ""]] then {
            set TGV_Hiding_Option ""
            } else {
            set TGV_Hiding_Option "-hide [Get_Selected_File TGV_Hiding]"
            }
      if [expr ! [string compare [Get_Selected_File TGV_Renaming] ""]] then {
            set TGV_Renaming_Option ""
            } else {
            set TGV_Renaming_Option "-rename [Get_Selected_File TGV_Renaming]"
            }
      if [expr ! [string compare [Get_Selected_File TGV_InputOutput] ""]] then {
            set TGV_InputOutput_Option ""
            } else {
            set TGV_InputOutput_Option "-io [Get_Selected_File TGV_InputOutput]"
            }
      set Tmp_Test_Purpose [Convert [Get_Selected_File TGV_Test_Purpose] {.aut .bcg} ""]
      if [expr ![string equal "$Tmp_Test_Purpose" $Failed_Conversion]] then {
           Execute_Open_Caesar Open_Caesar_TGV "tgv $Option_TGV(Messages) [Variable TGV_Hiding_Option] [Variable TGV_Renaming_Option] [Variable TGV_InputOutput_Option] [Variable TGV_Tpprior] [Variable TGV_Outprior] -hash \"[Variable TGV_Hash]\" -depth \"[Variable TGV_Depth]\" -output \"[Variable TGV_Output]\" $Option_TGV(Keeplock) $Option_TGV(Parse) $Option_TGV(Locks) [Variable TGV_Controllability] [Variable TGV_Post] -postdepth \"[Variable TGV_Postdepth]\" $Option_TGV(Verif) [Variable TGV_Timer] [Variable TGV_Monitor] \"$Tmp_Test_Purpose\""
      }}
}

set Window(Open_Caesar_TGV) {
     {Frame top {
        {Frame top {
           {Label "Test generation using TGV for [File_Name Open_Caesar_TGV]"}
        }}
        {Frame top {
                {Label "Test purpose"}
                {Filebox TGV_Test_Purpose . *.{aut,bcg,fc2} Open_Caesar_TGV}
        }}
	{Frame top {
	    {Invisible_Frame top {
		{File_Entry "Hiding file (optional)         " TGV_Hiding "*.hide" *.{hid,hide} No_Ok_Button}
	    }}
	    {Invisible_Frame top {
		{File_Entry "Renaming file (optional)       " TGV_Renaming "*.rename" *.{ren,rename} No_Ok_Button}
	    }}
	    {Invisible_Frame top {
		{File_Entry "Input/Output file (optional)   " TGV_InputOutput "*.io" *.io No_Ok_Button}
	    }}
	}}
        {Frame top {
           {Label "Test case controllability"}
           {Radiobutton "Produce a controllable test case with loops" TGV_Controllability " " 1 {}}
           {Radiobutton "Produce a controllable test case without loops" TGV_Controllability "-unloop" 0 {}}
           {Radiobutton "Produce the complete (possibly non controllable) test case" TGV_Controllability "-csg" 0 {}}
        }}
	{Frame top {
	   {Label "Priority of actions (specification vs. test purpose)"}
	   {Radiobutton "Give priority to specification actions" TGV_Tpprior " " 1 {}}
	   {Radiobutton "Give priority to test purpose actions" TGV_Tpprior "-tpprior" 0 {}}
	}}
	{Frame top {
	   {Label "Priority of actions (inputs vs. outputs)"}
	   {Radiobutton "Give priority to input actions" TGV_Outprior " " 1 {}}
	   {Radiobutton "Give priority to output actions" TGV_Outprior "-outprior" 0 {}}
	}}
        {Frame top {
           {Frame top {
              {Checkbutton "Search a postamble from pass and inconclusive states" TGV_Post "-post" "" 2 {}}
              {Checkbutton "Produce a test case with test timers" TGV_Timer "-timer" "" 2 {}}
           }}
        }}
        {Frame top {
           {Entry "Maximal depth search for preamble (0 means infinity)" TGV_Depth  "0"}
           {Entry "Maximal depth search for postamble (0 means infinity)" TGV_Postdepth  "0"}
           {Entry "Size of hash table" TGV_Hash  "100000"}
        }}
        {Frame top {
            {Checkbutton "Real-time monitoring during test case construction" TGV_Monitor "-monitor" "" 1 {}}
        }}
        {Frame top {
           {Entry "Generated test case (output)" TGV_Output "tgv_result.bcg" } 
        }}
     }}
}

proc Select_Frame_Exhibitor_Spec_Deadlock {} {
    global Spec_Deadlock_Selector

    set Spec_Deadlock_Selector "Deadlock_Using_Exhibitor"
    Make_Buttons_Red Exhibitor_Spec_Deadlock
    Make_Buttons_Grey Terminator_Spec_Deadlock
}

proc Select_Frame_Terminator_Spec_Deadlock {} {
    global Spec_Deadlock_Selector 

    set Spec_Deadlock_Selector "Deadlock_Using_Terminator"
    Make_Buttons_Grey Exhibitor_Spec_Deadlock
    Make_Buttons_Red Terminator_Spec_Deadlock
}

set Window(Spec_Deadlock) {
   {Frame top {
       {Frame top {
           {Label "Deadlock detection in [File_Name Spec_Deadlock]"}
       }}

       {Exclusive_Frame "Exhibitor_Spec_Deadlock" top {
	   {Coloured_Radiobutton "Search deadlocks using Open/Caesar's Exhibitor" Spec_Deadlock_Selector "Deadlock_Using_Exhibitor" 1 {}}
	   {Variable Window(Open_Caesar_Deadlock)}
       } "" {Select_Frame_Exhibitor_Spec_Deadlock}}

       {Exclusive_Frame "Terminator_Spec_Deadlock" top {
           {Coloured_Radiobutton "Search deadlocks using Open/Caesar's Terminator (partial search)" Spec_Deadlock_Selector "Deadlock_Using_Terminator" 0 {}}
           {Variable Window(Open_Caesar_Terminator)}
       } "" {Select_Frame_Terminator_Spec_Deadlock}}

       {Initialise {Select_Frame_Exhibitor_Spec_Deadlock}}
   }}
}

set Commands(Spec_Deadlock) {
        {
	    global Spec_Deadlock_Selector

	    switch $Spec_Deadlock_Selector {
		"Deadlock_Using_Exhibitor" {
		    Set_Currently_Selected_File Open_Caesar_Deadlock Spec_Deadlock
		    Execute_Commands Open_Caesar_Deadlock
		    Unset_Currently_Selected_File Open_Caesar_Deadlock
		}
		"Deadlock_Using_Terminator" {
		    Set_Currently_Selected_File Open_Caesar_Terminator Spec_Deadlock
		    Execute_Commands Open_Caesar_Terminator
		    Unset_Currently_Selected_File Open_Caesar_Terminator
		}
	    }
	}
}

set Rule(Spec_Deadlock) 1

set Window(Spec_Livelock) {
        {Frame top {
           {Label "Livelock detection in [File_Name Spec_Livelock]"}
        }}
	{Variable Window(Open_Caesar_Livelock)}
}

set Commands(Spec_Livelock) {
	{
	Set_Currently_Selected_File Open_Caesar_Livelock Spec_Livelock
	Execute_Commands Open_Caesar_Livelock
	Unset_Currently_Selected_File Open_Caesar_Livelock
	}
}

set Rule(Spec_Livelock) 1

set Window(Compositional_Generator) {
   {Frame top {
	{Label "LTS generation using Generator / Reductor for [File_Name Compositional_Generator]"}
	{Variable Window(Open_Caesar_Generator)}
   }}
}

set Commands(Compositional_Generator) {
   {
	Set_Currently_Selected_File Open_Caesar_Generator Compositional_Generator
	Execute_Commands Open_Caesar_Generator
	Unset_Currently_Selected_File Open_Caesar_Generator
   }    
}

set Rule(Compositional_Generator) 1

set Window(Bisimulator_Compare) {
     {Frame top {
        {Label "Comparison relation"}
        {Invisible_Frame top {
        {Invisible_Frame left {
	   {Invisible_Frame top {
           {Radiobutton "Strong equivalence" Bisimulator_Comparison_Relation "-strong" 1 {}}
	   }}
	   {Invisible_Frame top {
           {Radiobutton "Observational equivalence" Bisimulator_Comparison_Relation "-observational" 0 {}}
	   }}
        }}
        {Invisible_Frame left {
	   {Invisible_Frame top {
           {Radiobutton "Branching equivalence" Bisimulator_Comparison_Relation "-branching" 0 {}}
	   }}
	   {Invisible_Frame top {
           {Radiobutton "Safety equivalence" Bisimulator_Comparison_Relation "-safety" 0 {}}
	   }}
	   {Invisible_Frame top {
           {Radiobutton "Weak trace equivalence" Bisimulator_Comparison_Relation "-weaktrace" 0 {}}
	   }}
        }}
        {Invisible_Frame left {
	   {Invisible_Frame top {
           {Radiobutton "Tau*.a equivalence" Bisimulator_Comparison_Relation "-taustar" 0 {}}
	   }}
	   {Invisible_Frame top {
           {Radiobutton "Trace equivalence" Bisimulator_Comparison_Relation "-trace" 0 {}}
	   }}
        }}
        }}
        {Invisible_Frame top {
           {Checkbutton "Reduce on-the-fly modulo tau-confluence" Bisimulator_Tau_Confluence "-tauconfluence" "" 0 {}}
        }}        
     }}
     {Frame top {
        {Label "Selected comparison"}
        {Invisible_Frame left {
          {Radiobutton "Equivalence (=)        " Bisimulator_Comparison_Check "-equal" 1 {}}
        }}
        {Invisible_Frame left {
          {Radiobutton "Preorder (<=)          " Bisimulator_Comparison_Check "-smaller" 0 {}}
        }}
        {Invisible_Frame left {
          {Radiobutton "Preorder (>=)          " Bisimulator_Comparison_Check "-greater" 0 {}}
        }}
     }}
     {Frame top {
        {Label "Selected algorithm"}
        {Invisible_Frame left {
          {Radiobutton "Breadth-first search    " Bisimulator_Algorithm "-bfs" 1 {}}
        }}
        {Invisible_Frame left {
          {Radiobutton "Depth-first search      " Bisimulator_Algorithm "-dfs" 0 {}}
        }}
     }}
}

set Commands(Bisimulator_Compare) {
      {
	global Failed_Conversion

	set Tmp_File [Convert [Get_Selected_File Verif_Compare_LTS] {.bcg} ""]
	if [expr ![string equal "$Tmp_File" $Failed_Conversion]] then {
	     Execute_Open_Caesar Bisimulator_Compare "bisimulator [Array Option_Bisimulator] [Variable Bisimulator_Comparison_Check] [Variable Bisimulator_Comparison_Relation] [Variable Bisimulator_Tau_Confluence] [Variable Bisimulator_Algorithm] -diag \"[Variable Comparison_Diagnostic_File]\" \"$Tmp_File\""
	}
      }
}

set Window(Exp_Info) {}
set Commands(Exp_Info) {
     {
      global Failed_Conversion

      set Tmp_File [Convert [File_Name Exp_Info] {.exp} ""] 
      if [expr ![string equal "$Tmp_File" $Failed_Conversion]] then {
           Execute "exp.open -info \"$Tmp_File\""
      }
     }
}

proc Update_Output_File_Verif_Reduce_Reductor {} {

    global Selected_File_Name
    global Red_Reduction_Relation

    if {$Red_Reduction_Relation == "-strong"} {
        set Selected_File_Name(Verif_Reduce_Output) "[File_Base Reductor_Reduce]_s.bcg"
    } elseif {$Red_Reduction_Relation == "-taudivergence"} {
        set Selected_File_Name(Verif_Reduce_Output) "[File_Base Reductor_Reduce]_dv.bcg"
    } elseif {$Red_Reduction_Relation == "-taucompression"} {
        set Selected_File_Name(Verif_Reduce_Output) "[File_Base Reductor_Reduce]_cp.bcg"
    } elseif {$Red_Reduction_Relation == "-tauconfluence"} {
        set Selected_File_Name(Verif_Reduce_Output) "[File_Base Reductor_Reduce]_cf.bcg"
    } elseif {$Red_Reduction_Relation == "-taustar"} {
        set Selected_File_Name(Verif_Reduce_Output) "[File_Base Reductor_Reduce]_st.bcg"
    } elseif {$Red_Reduction_Relation == "-safety"} {
        set Selected_File_Name(Verif_Reduce_Output) "[File_Base Reductor_Reduce]_sf.bcg"
    } elseif {$Red_Reduction_Relation == "-trace"} {
        set Selected_File_Name(Verif_Reduce_Output) "[File_Base Reductor_Reduce]_tr.bcg"
    } elseif {$Red_Reduction_Relation == "-weaktrace"} {
        set Selected_File_Name(Verif_Reduce_Output) "[File_Base Reductor_Reduce]_wt.bcg"
    }
}

set Window(Reductor_Reduce) {
     {Frame top {
        {Label "Reduction relation"}
        {Invisible_Frame left {
	   {Invisible_Frame top {
           {Radiobutton "Strong equivalence" Red_Reduction_Relation "-strong" 1 {Update_Output_File_Verif_Reduce_Reductor}}
	   }}
	   {Invisible_Frame top {
           {Radiobutton "Tau-divergence" Red_Reduction_Relation "-taudivergence" 0 {Update_Output_File_Verif_Reduce_Reductor}}
	   }}
	   {Invisible_Frame top {
           {Radiobutton "Tau-compression" Red_Reduction_Relation "-taucompression" 0 {Update_Output_File_Verif_Reduce_Reductor}}
	   }}
        }}
        {Invisible_Frame left {
	   {Invisible_Frame top {
           {Radiobutton "Tau-confluence" Red_Reduction_Relation "-tauconfluence" 0 {Update_Output_File_Verif_Reduce_Reductor}}
	   }}
	   {Invisible_Frame top {
           {Radiobutton "Tau*.a equivalence" Red_Reduction_Relation "-taustar" 0 {Update_Output_File_Verif_Reduce_Reductor}}
	   }}
	   {Invisible_Frame top {
           {Radiobutton "Safety equivalence" Red_Reduction_Relation "-safety" 0 {Update_Output_File_Verif_Reduce_Reductor}}
	   }}
        }}
        {Invisible_Frame left {
	   {Invisible_Frame top {
           {Radiobutton "Trace equivalence" Red_Reduction_Relation "-trace" 0 {Update_Output_File_Verif_Reduce_Reductor}}
	   }}
	   {Invisible_Frame top {
           {Radiobutton "Weak trace equivalence" Red_Reduction_Relation "-weaktrace" 0 {Update_Output_File_Verif_Reduce_Reductor}}
	   }}
        }}
     }}
     {Frame top {
           {Label "Other options"}
           {Invisible_Frame top {
               {Invisible_Frame left {
                   {Radiobutton "Partial reduction" Red_Kind_Of_Reduction "-partial" 0 {}}
               }}
               {Invisible_Frame left {
                   {Radiobutton "Total reduction" Red_Kind_Of_Reduction "-total" 1 {}}
               }}
           }}
           {Invisible_Frame top {
               {Checkbutton "Real-time monitoring during BCG graph construction" Red_Monitor "-monitor" "" 2 {}}
           }}
     }}
     {Initialise Update_Output_File_Verif_Reduce_Reductor}
}

set Commands(Reductor_Reduce) {
      {
        global Selected_File_Name
	Execute_Open_Caesar Reductor_Reduce "reductor [Variable Red_Reduction_Relation] [Variable Red_Kind_Of_Reduction] [Variable Red_Monitor] \"$Selected_File_Name(Verif_Reduce_Output)\""
      }
}

proc Get_SVL_Shell_Flags {} {
      set Options ""
      if [string compare [Variable SVL_Shell_Flags] ""] then {
          append Options "-sh '[Variable SVL_Shell_Flags]'"
      }
      return $Options
}

set Window(SVL_Shell_Options) {
      {Frame top
          {
           {Entry "Shell options" SVL_Shell_Flags  {} }
          }
      }
}

set Commands(SVL_Shell_Options) {}

set Window(SVL_Execute) {
	{Label "Execute SVL script"}
	{Entry "SVL script parameters (optional)" SVL_Parameters ""}
}

set Commands(SVL_Execute) {
	{Execute "svl [Array Option_SVL] [Get_SVL_Shell_Flags] \"[File_Name SVL_Execute]\" [Variable SVL_Parameters]"}
}

set Window(SVL_Clean) {}

set Commands(SVL_Clean) {
	{Execute "svl -clean \"[File_Name SVL_Clean]\""}
}

proc Variable {Variable_Name} {

      global [Array_Name $Variable_Name]
      if [info exists $Variable_Name] then {
          return [subst $[subst $Variable_Name]]
      } else {
          return ""
      }
}

proc Array {Array_Name} {
      global $Array_Name
      set List {}
      foreach Item [array names $Array_Name] {
          set List "$List [subst $[subst $Array_Name]($Item)]"
      }
      return $List
}

proc CommandArray {Array_Name CommandName} {
      global $Array_Name

      set List [subst $[subst $Array_Name]($CommandName)]

      foreach Item [array names $Array_Name] {
          if {$Item != $CommandName} then {
             set List "$List [subst $[subst $Array_Name]($Item)]"
          }
      }
      return $List
}

proc Suffix {Action String} {

      if [string compare [file extension [File_Name $Action]] $String] then {
            return 0
      } else {
            return 1
      }
}

proc Lotos_Suffix {Action} {
	switch [file extension [File_Name $Action]] { 
		.lotos { return 1 }
		.lot { return 1 }
		.l { return 1 }
		default { return 0 }
	}		
}

proc Temporary_File {Suffix} {
   global env
   global Tmp_Number
   return $env(EUCALYPTUS_TMP)_[incr Tmp_Number]$Suffix
}

proc Base {Path_Name} {
      return [file rootname  [Variable $Path_Name]]
}

proc Log_Open {File} {
      global File_Id
      if [string compare $File ""] then {} else {
        set File_Id [open $File "w"]
      } 
}

proc Log_Close {} {
      global File_Id
      close $File_Id
      set File_Id 0
}

proc Older_Than {File1 File2} {

      if [expr ![file exists $File1] || ![file exists $File2]] {
            return 1
      } else {
             return [expr [file mtime $File1] < [file mtime $File2]]
      }	     
} 

proc Older_Than_Sort {File1 File2} {

      if [expr ![file exists $File1] || ![file exists $File2]] {
            return 1
      } elseif {$File1 == ".."} {
	    return -1
      } elseif {$File2 == ".."} { 
	      return 1
      } else {
	      return [expr [file mtime $File2] - [file mtime $File1]]
      }
}	     

proc Convert {File_In Format File_Out} {
	global env
	global Xeuca_Result
	global Failed_Conversion

	if [expr [lsearch $Format [file extension $File_In]] == -1] then {  
	   if [expr ![string compare $File_Out ""]] then {
	      Execute "xeuca_convert \"$File_In\" [lindex $Format 0]"
	   } else {
	      Execute "xeuca_convert \"$File_In\" [lindex $Format 0] \"$File_Out\""
	   }
	   tkwait variable Xeuca_Result
	   if [string equal $Xeuca_Result $Failed_Conversion] then {

	      return $Failed_Conversion
	   }
	   set Tmp_File $Xeuca_Result	
	   if [string match $env(EUCALYPTUS_TMP)* $Tmp_File] then {
		   Execute "xeuca_echo Converted $File_In to \"$Tmp_File\""
	   }
	   return $Tmp_File
	} else {
	   return $File_In
	}
}	

set Window(Edit) {}

set Commands(Edit) {
     {Execute "cadp_edit \"[File_Name Edit]\" &"}
}

set Window(Display) {}

set Commands(Display) {
     {global Result
      catch {Execute_Shell "cat \"[File_Name Display]\""} Result
      Display $Result}
}

set Window(Print) {}

set Commands(Print) {
        {Execute "cadp_print \"[File_Name Print]\""}
}

set Window(Touch) {}

set Commands(Touch) {
     {Execute "touch \"[File_Name Touch]\""}
}

set Window(Remove) {
    {Label "Do you want to remove [File_Name Remove]?"}
}

set Commands(Remove) {
     {Execute "rm -f \"[File_Name Remove]\""}
}

set Window(Reset_Xeuca_Preferences) {
    {Label "Do you want to remove your preferences file ?"}
}

set Commands(Reset_Xeuca_Preferences) {
     {global Xeucarc_File
      Execute "rm -f $Xeucarc_File"}
}

set Window(Copy) {
    {Label "File [File_Name Copy]"}
    {Initialise {global Copy_Target; set Copy_Target ""}}
    {Entry "Copy to :" Copy_Target "" \
	{global Ok_Button_Address
	 $Ok_Button_Address(Copy) invoke}}
}

set Commands(Copy) {
     {Execute "cp \"[File_Name Copy]\" \"[Variable Copy_Target]\""}
}

set Window(Move) {
    {Label "File [File_Name Move]"}
    {Initialise {global Move_Target; set Move_Target ""}}
    {Entry "Move to :" Move_Target "" \
	{global Ok_Button_Address
	 $Ok_Button_Address(Move) invoke}}
}

set Commands(Move) {
     {Execute "mv \"[File_Name Move]\" \"[Variable Move_Target]\""}
}

set Window(Properties) {}

set Commands(Properties) {
     {global Result
      catch {Execute_Shell "xeuca_info \"[File_Name Properties]\""} Result
      Display $Result}
}

set Window(Make) {}

set Commands(Make) {
     {Execute "make -f \"[File_Name Make]\""}
}

set Window(Execute) {}

set Commands(Execute) {
     {Execute "\"./[File_Name Execute]\""}
}

set Window(View_PostScript) {}

set Commands(View_PostScript) {
      {Execute "cadp_postscript \"[File_Name View_PostScript]\" &"}
}

set Window(View_PDF) {}

set Commands(View_PDF) {
      {Execute "cadp_pdf \"[File_Name View_PDF]\" &"}
}

switch [Execute_Shell "cadp_mail -server"] {
	"cadp_mail_automatic" {
		set From "-"	
		set SMTP_Server "-"	
		set Window(Mailto) {
		  {Label "Mail file [File_Name Mailto]"}
		  {Entry "Recipient e-mail address:" Email "" \
		     {global Ok_Button_Address
		      $Ok_Button_Address(Mailto) invoke}}
		}
	}
	"cadp_mail_failed" {
		set Disable_Ok_Button(Mailto) 1
		set Window(Mailto) {
                  {Label "Mail file [File_Name Mailto]"}
                  {Label ""}
                  {Label "Error: cannot send mail from this machine (no running 'sendmail' daemon)"}
                }
	}
	"cadp_mail_unknown" {
                set Window(Mailto) {
                  {Label "Mail file [File_Name Mailto]"}
                  {Label ""}
		  {Entry "SMTP server:" SMTP_Server ""}
		  {Entry "Your e-mail address :" From ""}
                  {Entry "Recipient e-mail address:" Email "" \
                     {global Ok_Button_Address
                      $Ok_Button_Address(Mailto) invoke}}
		}
        }
	default {
		set Window(Mailto) {
		  {Label "Mail file [File_Name Mailto]"}
                  {Label ""}
		  {Entry "SMTP server:" SMTP_Server {[Execute_Shell "cadp_mail -server"]}}
		  {Entry "Your e-mail address:" From {[Execute_Shell "cadp_mail -from"]}}
		  {Entry "Recipient e-mail address:" Email "" \
		     {global Ok_Button_Address
		      $Ok_Button_Address(Mailto) invoke}}
		}
	}
}

set Commands(Mailto) {
	{Execute "cadp_mail -send \"[Variable SMTP_Server]\" \"[Variable From]\" \"[File_Name Mailto]\" \"[Variable Email]\"" }

}
proc Select_Frame_Bcg_Min_Reduce {} {
    global Reduce_Selector

    set Reduce_Selector "Reduce_Using_Bcg_Min"
    Update_Output_File_Verif_Reduce_Bcg_Min
    Make_Buttons_Red Bcg_Min_Reduce
    Make_Buttons_Grey Reductor_Reduce
}

proc Select_Frame_Reductor_Reduce {} {
    global Reduce_Selector

    set Reduce_Selector "Reduce_Using_Reductor"
    Update_Output_File_Verif_Reduce_Reductor
    Make_Buttons_Grey Bcg_Min_Reduce
    Make_Buttons_Red Reductor_Reduce
}

set Window(Verif_Reduce) {
     {Frame top {
	 {Frame top {
	     {Label "Reduction of [File_Name Verif_Reduce]"}
         }}

	 {Exclusive_Frame "Bcg_Min_Reduce" top {
	     {Coloured_Radiobutton "Reduce using BCG_MIN" Reduce_Selector "Reduce_Using_Bcg_Min" 1 {}}
	     {Variable Window(Bcg_Min_Reduce)}
	 } "" {Select_Frame_Bcg_Min_Reduce}}

	 {Exclusive_Frame "Reductor_Reduce" top {
             {Initialise {Set_Currently_Selected_File Reductor_Reduce Verif_Reduce}}
	     {Coloured_Radiobutton "Reduce on the fly using Reductor" Reduce_Selector "Reduce_Using_Reductor" 0 {}}
	     {Variable Window(Reductor_Reduce)}
	 } "" {Select_Frame_Reductor_Reduce}}

	 {Initialise {Select_Frame_Bcg_Min_Reduce}}

	 {File_Entry "Output file        " Verif_Reduce_Output "[Get_Selected_File Verif_Reduce_Output]" *.bcg No_Ok_Button}
     }}
}

set Commands(Verif_Reduce) {
    {
	global Reduce_Selector

	switch $Reduce_Selector {
	    "Reduce_Using_Bcg_Min" {
		Set_Currently_Selected_File Bcg_Min_Reduce Verif_Reduce
		Execute_Commands Bcg_Min_Reduce
		Unset_Currently_Selected_File Bcg_Min_Reduce
	    }
	    "Reduce_Using_Reductor" {
		Set_Currently_Selected_File Reductor_Reduce Verif_Reduce
		Execute_Commands Reductor_Reduce
		Unset_Currently_Selected_File Reductor_Reduce
	    }
	}
    }
}

set Rule(Verif_Reduce) 1

set Window(Verif_Spec_Reduce) {
     {Frame top {

         {Initialise {Set_Currently_Selected_File Verif_Reduce Verif_Spec_Reduce}}

	 {Frame top {
	     {Label "Reduction of [File_Name Verif_Reduce]"}
         }}

	 {Exclusive_Frame "Reductor_Reduce" top {
             {Initialise {Set_Currently_Selected_File Reductor_Reduce Verif_Reduce}}
	     {Coloured_Radiobutton "Reduce on the fly using Reductor" Reduce_Selector "Reduce_Using_Reductor" 0 {}}
	     {Variable Window(Reductor_Reduce)}
	 } "" {Select_Frame_Reductor_Reduce}}

	 {Initialise {Select_Frame_Reductor_Reduce}}

	 {File_Entry "Output file        " Verif_Reduce_Output "[Get_Selected_File Verif_Reduce_Output]" *.bcg No_Ok_Button}
     }}
}

set Commands(Verif_Spec_Reduce) $Commands(Verif_Reduce)

set Disable_Ok_Button(Verif_Compare) 1

proc Select_Frame_Bisimulator_Compare {} {
    global Compare_Selector 

    set Compare_Selector "Compare_Using_Bisimulator"
    Make_Buttons_Grey Bcg_Cmp_Compare
    Make_Buttons_Red Bisimulator_Compare
}

proc Select_Frame_Bcg_Cmp_Compare {} {
    global Compare_Selector 

    set Compare_Selector "Compare_Using_Bcg_Cmp"
    Make_Buttons_Red Bcg_Cmp_Compare
    Make_Buttons_Grey Bisimulator_Compare
}

set Window(Verif_Compare) {
     {Frame top {
        {Frame top {
	   {Label "Comparison of [File_Name Verif_Compare] with another LTS"}
        }}
	{Frame top {
		{Filebox Verif_Compare_LTS . *.{aut,bcg,fc2} Verif_Compare 4}
	}}

	 {Exclusive_Frame "Bcg_Cmp_Compare" top {
             {Initialise {Set_Currently_Selected_File Bcg_Cmp_Compare Verif_Compare}}
	     {Coloured_Radiobutton "Compare using BCG_CMP" Compare_Selector "Compare_Using_Bcg_Cmp" 1 {}}
	     {Variable Window(Bcg_Cmp_Compare)}
	 } "" {Select_Frame_Bcg_Cmp_Compare}}

	 {Exclusive_Frame "Bisimulator_Compare" top {
             {Initialise {Set_Currently_Selected_File Bisimulator_Compare Verif_Compare}}
	     {Coloured_Radiobutton "Compare on the fly using Bisimulator" Compare_Selector "Compare_Using_Bisimulator" 0 {}}
	     {Variable Window(Bisimulator_Compare)}
	 } "" {Select_Frame_Bisimulator_Compare}}

	{Initialise {Select_Frame_Bcg_Cmp_Compare}}

	{Frame top {
	    {Invisible_Frame top {
	        {Entry "Diagnostic BCG file (output)" Comparison_Diagnostic_File "diagnostic.bcg" {}}
	    }}
        }}
     }}
}

set Commands(Verif_Compare) {
    {
	global Compare_Selector

	switch $Compare_Selector {
	    "Compare_Using_Bcg_Cmp" {
		Set_Currently_Selected_File Bcg_Cmp_Compare Verif_Compare
		Execute_Commands Bcg_Cmp_Compare
		Unset_Currently_Selected_File Bcg_Cmp_Compare
	    }
	    "Compare_Using_Bisimulator" {
		Set_Currently_Selected_File Bisimulator_Compare Verif_Compare
		Execute_Commands Bisimulator_Compare
		Unset_Currently_Selected_File Bisimulator_Compare
	    }
	}
    }
}

set Rule(Verif_Compare) 1

set Disable_Ok_Button(Verif_Spec_Compare) 1

set Window(Verif_Spec_Compare) {
     {Frame top {

	 {Initialise {Set_Currently_Selected_File Verif_Compare Verif_Spec_Compare}}
	 {Frame top {
	     {Label "Comparison of [File_Name Verif_Compare] with another LTS"}
	 }}
	 {Frame top {
	     {Filebox Verif_Compare_LTS . *.{aut,bcg,fc2} Verif_Spec_Compare 4}
	 }}

	 {Exclusive_Frame "Bisimulator_Compare" top {
	     {Initialise {Set_Currently_Selected_File Bisimulator_Compare Verif_Compare}}
	     {Coloured_Radiobutton "Compare on the fly using Bisimulator" Compare_Selector "Compare_Using_Bisimulator" 0 {}}
	     {Variable Window(Bisimulator_Compare)}
	 } "" {Select_Frame_Bisimulator_Compare}}

	 {Initialise {Select_Frame_Bisimulator_Compare}}

	 {Frame top {
	     {Invisible_Frame top {
	         {Entry "Diagnostic BCG file (output)" Comparison_Diagnostic_File "diagnostic.bcg" {}}
	     }}
	 }}
     }}
}

set Commands(Verif_Spec_Compare) {
    {
      Set_Currently_Selected_File Bisimulator_Compare Verif_Spec_Compare
      Execute_Commands Bisimulator_Compare
      Unset_Currently_Selected_File Bisimulator_Compare
    }
}

set Rule(Verif_Spec_Compare) 1

proc Select_Frame_Exhibitor_LTS_Deadlock {} {
    global LTS_Deadlock_Selector

    set LTS_Deadlock_Selector "LTS_Deadlock_Using_Exhibitor"

    Make_Buttons_Red  Exhibitor_LTS_Deadlock
    Make_Buttons_Grey Bcg_Info_LTS_Deadlock
}

proc Select_Frame_Bcg_Info_LTS_Deadlock {} {
    global LTS_Deadlock_Selector

    set LTS_Deadlock_Selector "LTS_Deadlock_Using_Bcg_Info"

    Make_Buttons_Grey Exhibitor_LTS_Deadlock
    Make_Buttons_Red  Bcg_Info_LTS_Deadlock
}

set Window(LTS_Deadlock) {
    {Frame top {
	{Frame top {
	    {Label "Deadlock detection in [File_Name LTS_Deadlock]"}
        }}

	{Exclusive_Frame "Exhibitor_LTS_Deadlock" top {
	    {Coloured_Radiobutton "Search deadlocks using Open/Caesar's Exhibitor" LTS_Deadlock_Selector "LTS_Deadlock_Using_Exhibitor" 0 {}}
	    {Variable Window(Open_Caesar_Deadlock)}
	} "" {Select_Frame_Exhibitor_LTS_Deadlock}}

	{Exclusive_Frame "Bcg_Info_LTS_Deadlock" top {
	    {Coloured_Radiobutton "Search deadlocks using Bcg_Info" LTS_Deadlock_Selector "LTS_Deadlock_Using_Bcg_Info" 1 {}}
	} ""  {Select_Frame_Bcg_Info_LTS_Deadlock}}

	{Initialise {Select_Frame_Exhibitor_LTS_Deadlock}}
    }}
}

set Commands(LTS_Deadlock) {
       {
	   global LTS_Deadlock_Selector

	   switch $LTS_Deadlock_Selector {
	       "LTS_Deadlock_Using_Exhibitor" {
		   Set_Currently_Selected_File Open_Caesar_Deadlock LTS_Deadlock
		   Execute_Commands Open_Caesar_Deadlock
		   Unset_Currently_Selected_File Open_Caesar_Deadlock
	       }
	       "LTS_Deadlock_Using_Bcg_Info" {
		   Set_Currently_Selected_File Bcg_Info_Deadlock LTS_Deadlock
		   Execute_Commands Bcg_Info_Deadlock
		   Unset_Currently_Selected_File Bcg_Info_Deadlock
	       }
	   }
       }
}

set Rule(LTS_Deadlock) 1

set Window(LTS_Livelock) {
    {Frame top {
	{Frame top {
	    {Label "Livelock detection in [File_Name LTS_Livelock]"}
        }}

	{Variable Window(Open_Caesar_Livelock)}

	}}
}

set Commands(LTS_Livelock) {
    {
	Set_Currently_Selected_File Open_Caesar_Livelock LTS_Livelock
	Execute_Commands Open_Caesar_Livelock
	Unset_Currently_Selected_File Open_Caesar_Livelock
    }
}

set Rule(LTS_Livelock) 1

proc Select_Frame_Open_Caesar_Evaluator_Base {} {
    global Temporal_Selector

    set Temporal_Selector "Temporal_Using_Evaluator"
    Make_Buttons_Red Open_Caesar_Evaluator_Base
    Make_Buttons_Grey Xtl_Eval
}

proc Select_Frame_Xtl_Eval {} {
    global Temporal_Selector

    set Temporal_Selector "Temporal_Using_Xtl"
    Make_Buttons_Grey Open_Caesar_Evaluator_Base
    Make_Buttons_Red Xtl_Eval
}

set Disable_Ok_Button(Verif_Temporal) 1

set Window(Verif_Temporal) {
   {Frame top {
	{Frame top {
	   {Label "Verify temporal formulas in [File_Name Verif_Temporal]"}
	}}

	{Exclusive_Frame "Open_Caesar_Evaluator_Base" top {
	    {Coloured_Radiobutton "Use Open/Caesar's Evaluator" Temporal_Selector "Temporal_Using_Evaluator" 1 {}}
	    {Variable Window(Open_Caesar_Evaluator_Base)}
	} "" {Select_Frame_Open_Caesar_Evaluator_Base}}

	{Exclusive_Frame "Xtl_Eval" top {
	    {Coloured_Radiobutton "Use Xtl" Temporal_Selector "Temporal_Using_Xtl" 0 {}}
	    {Variable Window(Xtl_Eval)}
	} "" {Select_Frame_Xtl_Eval}}

        {Initialise {Select_Frame_Open_Caesar_Evaluator_Base}}
   }}
}

set Commands(Verif_Temporal) {
	{global Temporal_Selector
         if {$Temporal_Selector == "Temporal_Using_Evaluator" && \
             [string compare [Get_Selected_File Evaluator_Files_List] ""]} then {
		Set_Currently_Selected_File Open_Caesar_Evaluator Verif_Temporal
                Execute_Commands Open_Caesar_Evaluator
	        Unset_Currently_Selected_File Open_Caesar_Evaluator
	 }
	 if {$Temporal_Selector == "Temporal_Using_Xtl" && \
	     [string compare [Get_Selected_File Xtl_FileWindow] "" ]} then {
		Set_Currently_Selected_File Xtl_Eval Verif_Temporal
                Execute_Commands Xtl_Eval
	        Unset_Currently_Selected_File Xtl_Eval
	 }
	}
}
set Rule(Verif_Temporal) 1

set Window(Web_CADP_Home_Page) {}

set Commands(Web_CADP_Home_Page) {
   {
   Execute "cadp_web http://cadp.inria.fr"
   }
}

set Window(Web_CADP_Tutorials) {}

set Commands(Web_CADP_Tutorials) {
   {
   Execute "cadp_web http://cadp.inria.fr/tutorial"
   }
}

set Window(Web_CADP_Manuals) {}

set Commands(Web_CADP_Manuals) {
   {
   Execute "cadp_web http://cadp.inria.fr/man"
   }
}

set Window(Web_CADP_Case_Studies) {}

set Commands(Web_CADP_Case_Studies) {
   {
   Execute "cadp_web http://cadp.inria.fr/case-studies"
   }
}

set Window(Web_CADP_FAQ) {}

set Commands(Web_CADP_FAQ) {
   {
   Execute "cadp_web http://cadp.inria.fr/faq.html"
   }
}

proc Get_XTL_Files {} {
      set Files ""
      if [string compare [Variable XTL_C_Flags] ""] then {
          append Files "-cc '[Variable XTL_C_Flags]'"
      }
      if [string compare [Variable XTL_Temporary_File_Location] ""] then {
           append Files " -tmp '[Variable XTL_Temporary_File_Location]'"
      }
      return $Files
}

set Selected_File_Name(Xtl_FileWindow) ""
set XTL_INSTALLED normal
set Disable_Ok_Button(Xtl_Eval) 1

set Window(Xtl_Eval) {
      {Frame top {
	 {Frame top {
	       {Checkbutton "Expand only" Xtl_Expand "-expand" "" 0 {}}
	 }}
	 {Frame top {
		   {Label "File containing temporal formulas (*.xtl)"}
		   {Filebox Xtl_FileWindow . *.xtl {[Variable Tool_Name]}}
	 }}
       }}
}

set Commands(Xtl_Eval) {
      {
	global Failed_Conversion

	set Tmp_File [Convert [File_Name Xtl_Eval] {.bcg} ""]
	if [expr ![string equal "$Tmp_File" $Failed_Conversion]] then {
	    Execute "xtl [Get_XTL_Files] [Array Option_XTL] [Variable Xtl_Expand] \"[Get_Selected_File Xtl_FileWindow]\" \"$Tmp_File\""
	}
      } 
}

set Eucalyptus_Banner "EUCALYPTUS $Eucalyptus_Version"

set Xeucarc_File [file join $env(XEUCA_HOME) .config cadp xeucarc]

set Xeucarc_Incompatibility 0

if [file exists $Xeucarc_File] then {

    set  Xeucarc_Version "2.1"

    source $Xeucarc_File

    if [expr [string compare $Xeucarc_Version "2.1"] == 0] then {
	set Xeucarc_Incompatibility "2.1"
    }

    if [expr [string compare $Option_Caesar(Optimization_E7) ""] == 0] then {
         set Option_Caesar(Optimization_E7) " "
    }
}

set Xeucarc_Version $Eucalyptus_Version

Init_Files_Associations

set env(XTERM_OPTIONS) $Xterm_Options 

set File_Name_Of_Selected_Icon ""

set Number 0
set Tmp_Number 0

set File_Id 0

set Failed_Conversion ""

set Icon_Directory $env(XEUCADIR)/icons
set Frame_Directory $env(XEUCADIR)/frames

option add *background $Bg_Color
option add *foreground $Fg_Color
option add *activeBackground $Fg_Color
option add *activeForeground $Bg_Color
option add *highlightBackground $Bg_Color
option add *troughColor $Menubar_Bg_Color 
option add *selectBackground $Fg_Color
option add *selectForeground $Bg_Color

frame .xoptions -class BorderWidth

if [expr [option get .xoptions {} BorderWidth] + 0 > 1] {
        option add *BorderWidth 1
}

. configure -cursor [Variable Normal_Cursor] -background $Bg_Color

set Screen_MaxWidth [expr ([winfo screenwidth .] - 8)]
set Screen_MaxHeight [expr ([winfo screenheight .] - $env(XEUCA_WINDOW_HEADER_SIZE))]

if [expr $Screen_Width > $Screen_MaxWidth] then {
	set Screen_Width $Screen_MaxWidth
}

if [expr $Screen_Height > $Screen_MaxHeight] {
        set Screen_Height $Screen_MaxHeight
}

CreateMainWindow

wm geometry . ${Screen_Width}x${Screen_Height}+${Screen_X_Position}+${Screen_Y_Position}

wm minsize . $Screen_MinWidth $Screen_MinHeight
wm maxsize . $Screen_MaxWidth $Screen_MaxHeight
wm title . $Eucalyptus_Banner
wm iconbitmap . @$Icon_Directory/icon_eucalyptus.xbm

MakeIcons

Unix_Communication_Mode

bind .f.t <Configure> {
        ComputeRules 
}

ComputeRules 
Display $Rule_Welcome

if [expr $Xeucarc_Incompatibility != 0] then {
        Display ""
	Display "Warning: your file $Xeucarc_File is incorrect or out-of-date"
        Display ""
	Display "You should remove it or modify it manually following the model given in"
	Display [subst  "$env(XEUCADIR)/xeucarc_standard"]
        Display ""
	Display "You can also cross the fingers and try to update it automatically"
	Display "by clicking on `Save Preferences' in the `File' menu"
	Display ""
}

