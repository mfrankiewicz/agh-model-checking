#############################################################################
#                         DISTRIBUTED MONITOR
#-----------------------------------------------------------------------------
#   INRIA - Unite de Recherche Rhone-Alpes
#   655, avenue de l'Europe
#   38330 Montbonnot Saint Martin
#   FRANCE
#-----------------------------------------------------------------------------
#   Module             :       distributor.tcl
#   Auteurs            :       Gilles Stragier, Nicolas Descoubes, David
#                              Champelovier et Hubert Garavel
#   Version            :       1.40
#   Date               :       2016/01/11 14:06:23
##############################################################################

package require Tix

source $env(CADP_WINPATH)/tcl-tk/lib-tk/dialog.tcl
source $env(CADP_WINPATH)/tcl-tk/lib-tk/bgerror.tcl

wm title . "Distributed Monitor"

global NBTRANS
global NBREMAIN
global OLDREMAIN
global TOTALVISIT
global TOTALREMAIN
global TOTALTRANS
global MEANVISIT
global MEANREMAIN
global MEANTRANS
global TOTALLABELS
global NBBLOCK
global MEMORY
global RES
global FIFO_NAME
global FIFO
global LABEL_LIST
global SORT_LABELS

proc InsertHosts {HOSTARRAY top} {
    upvar $HOSTARRAY host
    for {set i 0} {$i < [array size host]} {incr i}  {
	label $top.machine$i -text $host($i)
	pack $top.machine$i -side top -pady 2 -fill x 
    }
}

proc InsertEntriesMemory {nb top args} {
    for {set i 0} {$i < $nb} {incr i} {
	eval {entry $top.machine$i -justify right -state disabled \
		-textvariable MEMORY($i)} $args
	pack $top.machine$i -side top -pady 1 -fill x
    }
}

proc InsertEntriesCPU {nb top args} {
    for {set i 0} {$i < $nb} {incr i} {
	eval {entry $top.machine$i -justify right -state disabled \
		-textvariable RES($i)} $args
	pack $top.machine$i -side top -pady 1 -fill x
    }
}

proc InsertEntriesVisit {nb top args} {
    for {set i 0} {$i < $nb} {incr i} {
	eval {entry $top.machine$i -justify right -state disabled \
		-textvariable NBVISIT($i)} $args
	pack $top.machine$i -side top -pady 1 -fill x
    }
}

proc InsertEntriesRemain {nb top args} {
    for {set i 0} {$i < $nb} {incr i} {
	eval {entry $top.machine$i -justify right -state disabled \
		-textvariable NBREMAIN($i)} $args
	pack $top.machine$i -side top -pady 1 -fill x
    }
}

proc InsertEntriesTrans {nb top args}  {
    for {set i 0} {$i < $nb} {incr i} {
	eval {entry $top.machine$i -justify right -state disabled \
		-textvariable NBTRANS($i)} $args
	pack $top.machine$i -side top -pady 1 -fill x
    }
}

proc InsertBlocks {nb top BLOCKARRAY} {
    global LASTRECT
    upvar $BLOCKARRAY block
    for {set i 0} {$i < $nb} {incr i} {
	set F [canvas $top.block$i -height 22 -width 100]
	pack $F -side top  -fill x
	set LASTRECT($i) [$F create rectangle 40 5 60 15 -fill green]
	set block($i) $F
    }
}

proc LabelFrame {top} {

    checkbutton $top.sort -text "Sort Labels Alphabetically" -variable SORT_LABELS -command DisplayLabelList
    pack $top.sort -side top

    frame $top.labels
    pack $top.labels -side top -expand true -fill both 
    text $top.labels.output -background white -wrap none \
	    -xscrollcommand "$top.scroll_x set" \
	    -yscrollcommand "$top.labels.scroll_y set" \
	    -width 5 -height 2

    scrollbar $top.scroll_x -orient horiz -command "$top.labels.output xview"
    scrollbar $top.labels.scroll_y -command "$top.labels.output yview"

    pack $top.labels.scroll_y -fill y -side right
    pack $top.labels.output -side right -fill both -expand true

    pack $top.scroll_x -fill x -side top
}

proc DisplayLabelList {} {

    global LABELS
    global SORT_LABELS
    global LABEL_LIST
    if {[expr $SORT_LABELS == 1]} {

        set DISPLAY_LABEL_LIST [lsort $LABEL_LIST]
    } else {

        set DISPLAY_LABEL_LIST $LABEL_LIST
    }
    $LABELS.labels.output configure -state normal
    $LABELS.labels.output delete 0.0 end
    foreach L $DISPLAY_LABEL_LIST {
        if [expr [string length $L] > 0] {
            $LABELS.labels.output insert end "$L\n"
        }
    }
    $LABELS.labels.output see end
    $LABELS.labels.output configure -state disabled
}

proc CreateLabeledEntry {top name label args } {

    frame $top.$name
    pack $top.$name -fill x
    label $top.$name.label -text $label -anchor w
    eval {entry $top.$name.entry -relief sunken} -state disabled $args 
    pack $top.$name.label -side left
    pack $top.$name.entry -side right 

}

proc CreateProgressBarFrame {f nb size} {

    set ret [frame $f.f$nb -height 20 -width $size -relief sunken -bd 2 -background blue]
    pack propagate $f.f$nb false
    pack $f.f$nb -side top -pady 2 -padx 3 
    set truc [frame $f.f$nb.f -height 20 -relief solid -bd 2 -width 100 -background red]
    pack propagate $f.f$nb.f false
    pack $f.f$nb.f -side left
    return $ret
}

proc AdjustProgressBarFrame {top nb} {

    $top.f configure -width $nb -background red
}	

proc InsertProgressBars {nb top size} {

    global PROGBARVISIT
    for {set i 0} {$i < $nb} {incr i} {
	set PROGBARVISIT($i) [CreateProgressBarFrame $top $i $size]
    }
}	

proc CreateHeader {top HEADERLIST} {

    frame $top.header
    pack $top.header -side top -fill x
    for {set i 0} {$i < [llength $HEADERLIST]} {incr i 1} {
	set F [frame $top.header.$i -height 22]
	pack propagate $top.header.$i false
	pack $top.header.$i -side left

	label $top.header.$i.lab$i -text [lindex $HEADERLIST $i] 
	pack $top.header.$i.lab$i -side top 
	lappend RETLIST $F
    }
    return $RETLIST
}

proc CreateScrollableColumns {top nb canvas main} {

    upvar $canvas can
    upvar $main win

    frame $top.canvas
    pack $top.canvas -expand true -fill both

    set can [canvas $top.canvas.scroll -yscrollcommand "$top.canvas.yscroll set"]
    scrollbar $top.canvas.yscroll -command "$top.canvas.scroll yview" -orient vertical

    pack $top.canvas.yscroll -fill y -side right 
    pack $top.canvas.scroll -expand 1 -fill both

    set win [frame $top.canvas.scroll.main]

    $top.canvas.scroll create window 0 0 -window $top.canvas.scroll.main -anchor nw

    for {set i 0} {$i < $nb} {incr i} {
	set F [frame $top.canvas.scroll.main.$i]
	pack $F -side left 
	lappend RETLIST $F
    }
    return $RETLIST
}

proc Exit {} {
    global FIFO
    if {[info exist FIFO]} {
      close $FIFO
    }
    exit
}

proc InputFifoName {} {
   global FIFO_NAME
   gets stdin FIFO_NAME
}

proc InputMachineList {HOSTARRAY} {

    upvar $HOSTARRAY temp

    global TOTALHOSTS
    global MAXHOSTS
    global OLDREMAIN
    global OLDVISIT
    global OLDTRANS
    global NBVISIT
    global STATESIZE
    set MAXHOSTS 30
    set TOTALHOSTS 0
    while (1) {
	gets stdin LINE
	switch -regexp $LINE {
	    ^[!].* {
		Exit
	    }				
	    ^[:].* {
		scan $LINE ":%s %d" HOST HOSTNUMBER
		set OLDREMAIN($HOSTNUMBER) 0
		set OLDVISIT($HOSTNUMBER) 0
		set NBVISIT($HOSTNUMBER) 0
		set OLDTRANS($HOSTNUMBER) 0
		set temp($HOSTNUMBER) $HOST
		incr TOTALHOSTS
	    }
	    ^[&].* {
		scan $LINE "&%d" STATESIZE
	    }
	    default {
		break
	    }
	}	
    }
}

proc CreateBottomBasicFrame {top FIFO} {

    button $top.done -text "stop" -command "WriteAndFlushFifo $FIFO \"e\""

    pack $top.done -side top
}

proc AdjustCanvasScroll {canvas main} {

    set width [winfo width $main]
    set height [winfo height $main]
    $canvas config -scrollregion "0 0 $width $height"
    $canvas config -yscrollincrement 24
}

proc AdjustHeaderValues {top HEADERWIDGETS REFWIDGETS} {

    for {set i 0} {$i < [llength $HEADERWIDGETS]} {incr i 1} {
	set REF [lindex $REFWIDGETS $i]
	set HEAD [lindex $HEADERWIDGETS $i]
	set width [winfo width $REF]
	$HEAD configure -width $width
    }
}

proc WriteAndFlushFifo {FIFO char} {

    puts -nonewline $FIFO $char
    flush $FIFO
}

set NBBLOCK 0

wm resizable . 0 1

tixNoteBook .n 
.n add basic -label "Overview" -underline 0
.n add labels -label "Labels" -underline 0
.n add progress -label "Progress" -underline 0
.n add statistics -label "Statistics" -underline 0
.n add resources -label "Resources" -underline 0

set PROGBARSIZE 300

pack .n -expand true -fill both -side top
frame .f
pack .f

set W [.n subwidget basic]

set PROGRESS [.n subwidget progress]

set STATISTICS [.n subwidget statistics]

set RESOURCES [.n subwidget resources]

CreateLabeledEntry $STATISTICS totvisit "Total number of Visited States" -textvariable TOTALVISIT
CreateLabeledEntry $STATISTICS totremain "Total number of Remaining States" -textvariable TOTALREMAIN
CreateLabeledEntry $STATISTICS tottrans "Total number of Transitions" -textvariable TOTALTRANS
CreateLabeledEntry $STATISTICS meanvisit "Mean number of Visited States" -textvariable MEANVISIT
CreateLabeledEntry $STATISTICS meanremain "Mean number of Remaining States" -textvariable MEANREMAIN
CreateLabeledEntry $STATISTICS meantrans "Mean number of Transitions" -textvariable MEANTRANS
CreateLabeledEntry $STATISTICS totallabe "Total number of Labels" -textvariable TOTALLABELS
CreateLabeledEntry $STATISTICS statesize "Size of each State (bytes)" -textvariable STATESIZE

set HEADERLISTBASIC [CreateHeader $W [list Hosts "Explored States" "Remaining States" Transitions Variation]]
set HEADERLISTPROGRESS [CreateHeader $PROGRESS [list Hosts "Visited States" "Number"]]
set HEADERLISTRESOURCES [CreateHeader $RESOURCES [list Hosts "Memory (Mb)" "CPU Usage (%)"]]
set BASICSTRUCTURE [CreateScrollableColumns $W 5 canvasBA mainBA]
set PROGRESSSTRUCTURE [CreateScrollableColumns $PROGRESS 3 canvasPR mainPR]
set RESOURCESSTRUCTURE [CreateScrollableColumns $RESOURCES 3 canvasRE mainRE]

InputFifoName 

InputMachineList HOSTARRAY

InsertHosts HOSTARRAY [lindex $BASICSTRUCTURE 0] 
InsertEntriesVisit [array size HOSTARRAY] [lindex $BASICSTRUCTURE 1] -width 15
InsertEntriesRemain [array size HOSTARRAY] [lindex $BASICSTRUCTURE 2] -width 15
InsertEntriesTrans [array size HOSTARRAY] [lindex $BASICSTRUCTURE 3] -width 15
InsertBlocks [array size HOSTARRAY] [lindex $BASICSTRUCTURE 4] BLOCKARRAY

InsertHosts HOSTARRAY [lindex $PROGRESSSTRUCTURE 0]
InsertProgressBars [array size HOSTARRAY] [lindex $PROGRESSSTRUCTURE 1] $PROGBARSIZE
InsertEntriesVisit [array size HOSTARRAY] [lindex $PROGRESSSTRUCTURE 2] -width 10

InsertHosts HOSTARRAY [lindex $RESOURCESSTRUCTURE 0]
InsertEntriesMemory [array size HOSTARRAY] [lindex $RESOURCESSTRUCTURE 1] -width 15
InsertEntriesCPU [array size HOSTARRAY] [lindex $RESOURCESSTRUCTURE 2] -width 15

set FIFO [open "$FIFO_NAME" w]
CreateBottomBasicFrame .f $FIFO

tkwait visibility $W.canvas.scroll.main
AdjustCanvasScroll $W.canvas.scroll $W.canvas.scroll.main
AdjustCanvasScroll $PROGRESS.canvas.scroll $PROGRESS.canvas.scroll.main
AdjustCanvasScroll $RESOURCES.canvas.scroll $RESOURCES.canvas.scroll.main

AdjustHeaderValues $W $HEADERLISTBASIC $BASICSTRUCTURE
AdjustHeaderValues $PROGRESS $HEADERLISTPROGRESS $PROGRESSSTRUCTURE
AdjustHeaderValues $RESOURCES $HEADERLISTRESOURCES $RESOURCESSTRUCTURE

CreateLabeledEntry $STATISTICS nbproc "Number of Hosts" -textvariable TOTALHOSTS

set LABELS [.n subwidget labels]

set SORT_LABELS 0

set LABEL_LIST {}

LabelFrame $LABELS

if {[array size HOSTARRAY] < $MAXHOSTS} {
    $canvasBA configure -height [expr $TOTALHOSTS*24]
} else	{
    $canvasBA configure -height [expr $MAXHOSTS*24]
}

set IMAX -1
set RIMAX 0
set OLDIMAX 0
set PROGBARSIZE 300

proc ReadInput {} {
    global FIFO     
    global MAXHOSTS  TOTALHOSTS HOSTARRAY
    global NBBLOCK   RES MEMORY
    global STATESIZE IMAX OLDIMAX RIMAX
    global BLOCKARRAY LASTRECT
    global LABELS TOTALLABELS
    global MEANVISIT  MEANREMAIN  MEANTRANS
    global NBVISIT    NBREMAIN    NBTRANS
    global OLDVISIT   OLDREMAIN   OLDTRANS
    global TOTALVISIT TOTALREMAIN TOTALTRANS
    global PROGBARSIZE PROGBARVISIT
    global LABEL_LIST

    gets stdin LINE

    switch -regexp $LINE {
	^[!] { 
	    Exit
	}

	^[.] {
	    .f.done configure -text "done"
	    .f.done configure -command Exit
	}

	^[;].* {
	    scan $LINE ";%d" nb
	    $BLOCKARRAY($nb) itemconfigure $LASTRECT($nb) -fill red
	    set NBREMAIN($nb) 0
	}				
	^[,].* {
	    set LAB [string range $LINE 1 end]
	    lappend LABEL_LIST $LAB
	    DisplayLabelList
	    set TOTALLABELS [expr $TOTALLABELS + 1]
	}
	default {

	    if { 5 != [scan $LINE "%d %d %d %d %d" nb A B C D] } {
		if {[eof stdin]} {

		    close stdin
		}
		return
	    }
	    set NBREMAIN($nb) $A
	    set NBVISIT($nb) $B
	    set NBTRANS($nb) $C
	    set RES($nb) $D

	    set MEMORY($nb) [expr (( (($A * ($STATESIZE+3)) +($B * ($STATESIZE+3))) / 1024) /1024)]

	    if {[expr $B > $RIMAX]} {
		set RIMAX $B
		set OLDIMAX $IMAX
		set IMAX $nb
	    }
	    if {$RIMAX==0} { 
		set RIMAX 1
	    }

	    if { ($nb == $IMAX) } {

		for {set i 0} {$i < [array size	HOSTARRAY]} {incr i} {
		    set COEFF [expr  ((double ($NBVISIT($i)) / $RIMAX) * $PROGBARSIZE)]
		    AdjustProgressBarFrame $PROGBARVISIT($i) $COEFF  
		}
	    } else {	
		set COEFF [expr ((double ($B) / $RIMAX) * $PROGBARSIZE)]
		AdjustProgressBarFrame $PROGBARVISIT($nb) $COEFF
	    }

	    set TOTALVISIT [expr ($TOTALVISIT - $OLDVISIT($nb)) + $B]
	    set TOTALREMAIN [expr ($TOTALREMAIN - $OLDREMAIN($nb)) + $A]
	    set TOTALTRANS [expr ($TOTALTRANS - $OLDTRANS($nb)) + $C]
	    set MEANVISIT [expr $TOTALVISIT /[array size HOSTARRAY]]
	    set MEANREMAIN [expr $TOTALREMAIN / [array size HOSTARRAY]]
	    set MEANTRANS [expr $TOTALTRANS / [array size HOSTARRAY]]
	    if {[expr ($NBREMAIN($nb) - $OLDREMAIN($nb)) > 0]} {
		$BLOCKARRAY($nb) itemconfigure $LASTRECT($nb) -fill green
	    } else {
		$BLOCKARRAY($nb) itemconfigure $LASTRECT($nb) -fill orange
	    }
	    set OLDTRANS($nb) $NBTRANS($nb)
	    set OLDREMAIN($nb) $NBREMAIN($nb)
	    set OLDVISIT($nb) $NBVISIT($nb)
	    incr NBBLOCK

	    WriteAndFlushFifo $FIFO "o"
	}
    }
}

fileevent stdin readable ReadInput

