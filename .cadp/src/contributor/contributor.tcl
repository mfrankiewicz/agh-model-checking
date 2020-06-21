###############################################################################
#                       C O N T R I B U T O R
#-----------------------------------------------------------------------------
#   INRIA
#   Unite de Recherche Rhone-Alpes
#   655, avenue de l'Europe
#   38330 Montbonnot Saint Martin
#   FRANCE
#-----------------------------------------------------------------------------
#   Module              :       contributor.tcl
#   Auteurs             :       Julien HENRY, Remi HERILIER, Hubert GARAVEL
#   Version             :       1.8
#   Date                :       2018/08/24 15:00:44 
##############################################################################

	
set VERBOSE 1
set DEBUG 1

proc DisplayMsg {msg {state ""}} {
	variable VERBOSE

	set FD [open [Trace] a+]

	switch $state {
		data          {if {$VERBOSE} {puts $FD $msg}}
		control       {if {$VERBOSE} {puts $FD $msg}}
		error         {puts $FD "ERROR: $msg"}
		default       {if {$VERBOSE} {puts $FD $msg}}
	}
	close $FD
}

proc Timeout {} {
variable ftp
upvar #0 finished state

	after cancel $ftp(Wait)
	set state(control) 1

	DisplayMsg "Timeout of control connection after $ftp(Timeout) sec.!" error

}

proc WaitOrTimeout {} {
variable ftp
upvar #0 finished state

	set retvar 1

	if {[info exists state(control)]} {

		set ftp(Wait) [after [expr $ftp(Timeout) * 1000] [namespace current]::Timeout]

		vwait finished(control)
		set retvar $state(control)
	}

	return $retvar
}

proc WaitComplete {value} {
variable ftp
upvar #0 finished state

	if {[info exists state(data)]} {
		vwait finished(data)
	}

	after cancel $ftp(Wait)
	set state(control) $value
}

proc PutsCtrlSock {{command ""}} {
variable ftp 
variable DEBUG
	
	if {$DEBUG} {
		DisplayMsg "---> $command"
	}

	puts $ftp(CtrlSock) $command
	flush $ftp(CtrlSock)

}

proc StateHandler {{sock ""}} {
upvar #0 finished state
variable ftp
variable DEBUG 
variable VERBOSE

		

	set rc "   "

	if { $sock != "" } {

		set number [gets $sock bufline]

		if { $number > 0 } {

			regexp "(^\[0-9\]+)( |-)?(.*)$" $bufline all rc multi_line msgtext

			set buffer $bufline
			

			while { $multi_line == "-"  } {
				set number [gets $sock bufline]	
				if { $number > 0 } {
					append buffer \n "$bufline"
					regexp "(^\[0-9\]+)( |-)?(.*)$" $bufline all rc multi_line
				}
			}
		} elseif [eof $ftp(CtrlSock)] {

			set rc 421
			if {$VERBOSE} {
				DisplayMsg "C: 421 Service not available, closing control connection." control
			}
			DisplayMsg "Service not available!" error
			CloseDataConn
			WaitComplete 0
			catch {unset ftp(State)}
			catch {close $ftp(CtrlSock); unset ftp(CtrlSock)}
			return
		}
		
	} 
	
	if {$DEBUG} {
		DisplayMsg "-> rc=\"$rc\"\n-> state=\"$ftp(State)\""
	}
	

	if {$rc == "211"} {return}

	regexp "^\[0-9\]?" $rc rc
	
 	switch -- $ftp(State) {
	
		user	{ 
			  switch $rc {
			    2       {
			    	       PutsCtrlSock "USER $ftp(User)"
			               set ftp(State) passwd
			            }
			    default {
				       set errmsg "Error connecting! $msgtext"
				       set complete_with 0
			            }
			  }
			}

		passwd	{
			  switch $rc {
			    2       {
				       set complete_with 1
			            }
			    3       {
			  	       PutsCtrlSock "PASS $ftp(Passwd)"
		  	       	       set ftp(State) connect
			            }
			    default {
				       set errmsg "Error connecting! $msgtext"
				       set complete_with 0
			            }
			  }
			}

		connect	{
			  switch $rc {
			    2       {
				       set complete_with 1
			            }
			    default {
				       set errmsg "Error connecting! $msgtext"
				       set complete_with 0
			            }
			  }
			}

		quit	{
		    	   PutsCtrlSock "QUIT"
			   set ftp(State) quit_sent
			}

		quit_sent {
			  switch $rc {
			    2       {
			               set complete_with 1
			            }
			    default {
				       set errmsg "Error disconnecting! $msgtext"
				       set complete_with 0
			            }
			  }
			}
		
		quote	{
		    	   PutsCtrlSock $ftp(Cmd)
			   set ftp(State) quote_sent
			}

		quote_sent {
	                   set complete_with 1
                           set ftp(Quote) $buffer
			}
		
		type	{
		  	  if { $ftp(Type) == "ascii" } {
			  	PutsCtrlSock "TYPE A"
			  } else {
			  	PutsCtrlSock "TYPE I"
			  }
  		  	  set ftp(State) type_sent
			}
			
		type_sent {
			  switch $rc {
			    2       {
				       set complete_with 1
			            }
			    default {
				       set errmsg "Error setting type \"$ftp(Type)\"!"
				       set complete_with 0
			            }
			  }
			}
	
		nlist_active {
			  if {[OpenActiveConn]} {
			    	PutsCtrlSock "PORT $ftp(LocalAddr),$ftp(DataPort)"
			  	set ftp(State) nlist_open
			  } else {
				set errmsg "Error setting port!"
			  }
			  
		}
			
		nlist_passive {
		    PutsCtrlSock "PASV"
		    set ftp(State) nlist_open
		}
			
		nlist_open {
			  switch $rc {
			    2 {
			         if {$ftp(Mode) == "passive"} {
				     if ![OpenPassiveConn $buffer] {
				         set errmsg "Error setting PASSIVE mode!"
				       	 set complete_with 0
				     }
				 }   
			         PutsCtrlSock "NLST$ftp(Dir)"
			  	 set ftp(State) list_sent
			      }
			    default {
			              if {$ftp(Mode) == "passive"} {
				          set errmsg "Error setting PASSIVE mode!"
				      } else {
				          set errmsg "Error setting port!"
				      }  
			       	      set complete_with 0
			            }
			  }
		}
	
		list_active	{
			  if {[OpenActiveConn]} {
				PutsCtrlSock "PORT $ftp(LocalAddr),$ftp(DataPort)"
		  		set ftp(State) list_open
			  } else {
				set errmsg "Error setting port!"
			  }
			  
		}
			
		list_passive	{
		    PutsCtrlSock "PASV"
		    set ftp(State) list_open
		}
			
		list_open {
			  switch $rc {
			    2  {
			         if {$ftp(Mode) == "passive"} {
				     if {![OpenPassiveConn $buffer]} {
				         set errmsg "Error setting PASSIVE mode!"
				       	 set complete_with 0
				     }
				 }   
			         PutsCtrlSock "LIST$ftp(Dir)"
			  	 set ftp(State) list_sent
			       }
			    default {
			              if {$ftp(Mode) == "passive"} {
				          set errmsg "Error setting PASSIVE mode!"
				      } else {
				          set errmsg "Error setting port!"
				      }  
				      set complete_with 0
			            }
			  }
		}
			
		list_sent	{
			  switch $rc {
			    1       {
			               set ftp(State) list_close
			            }
			    default {  
			               if { $ftp(Mode) == "passive" } {
			    	           unset state(data)
				       }    
				       set errmsg "Error getting directory listing!"
				       set complete_with 0
			            }
			  }
		}

		list_close {
			  switch $rc {
			    2     {
			               set complete_with 1
			            }
			    default {
				       set errmsg "Error receiving list!"
				       set complete_with 0
			            }
			  }
			}
									
		size {
			  PutsCtrlSock "SIZE $ftp(File)"
  		  	  set ftp(State) size_sent
			}

		size_sent {
			  switch $rc {
			    2       {
            			       regexp "^\[0-9\]+ (.*)$" $buffer all ftp(FileSize)
			               set complete_with 1
			            }
			    default {
				       set errmsg "Error getting file size!"
				       set complete_with 0
			            }
			  }
			}

		modtime {
			  PutsCtrlSock "MDTM $ftp(File)"
  		  	  set ftp(State) modtime_sent
			}

		modtime_sent {
			  switch $rc {
			    2       {
            			       regexp "^\[0-9\]+ (.*)$" $buffer all ftp(DateTime)
			               set complete_with 1
			            }
			    default {
				       set errmsg "Error getting modification time!"
				       set complete_with 0
			            }
			  }
			}

		pwd	{
			   PutsCtrlSock "PWD"
  		  	   set ftp(State) pwd_sent
			}
			
		pwd_sent {
			  switch $rc {
			    2       {
            			       regexp "^.*\"(.*)\"" $buffer temp ftp(Dir)
			               set complete_with 1
			            }
			    default {
				       set errmsg "Error getting working dir!"
				       set complete_with 0
			            }
			  }
			}

		cd	{
			   PutsCtrlSock "CWD$ftp(Dir)"
  		  	   set ftp(State) cd_sent
			}
			
		cd_sent {
			  switch $rc {
			    2       {
			               set complete_with 1
			            }
			    default {
				       set errmsg "Error changing directory!"
				       set complete_with 0
				     }
			  }
			}
			
		mkdir	{
			  PutsCtrlSock "MKD $ftp(Dir)"
  		  	  set ftp(State) mkdir_sent
			}
			
		mkdir_sent {
			  switch $rc {
			    2       {
			               set complete_with 1
			            }
			    default {
				       set errmsg "Error making dir \"$ftp(Dir)\"!"
				       set complete_with 0
				     }
			  }
			}
			
		rmdir	{
			  PutsCtrlSock "RMD $ftp(Dir)"
  		  	  set ftp(State) rmdir_sent
			}
			
		rmdir_sent {
			  switch $rc {
			    2       {
			               set complete_with 1
			            }
			    default {
				       set errmsg "Error removing directory!"
				       set complete_with 0
				     }
			  }
			}
										
		delete	{
			  PutsCtrlSock "DELE $ftp(File)"
  		  	  set ftp(State) delete_sent
			}
			
		delete_sent {
			  switch $rc {
			    2       {
			               set complete_with 1
			            }
			    default {
				       set errmsg "Error deleting file \"$ftp(File)\"!"
				       set complete_with 0
				     }
			  }
			}
			
		rename	{
			  PutsCtrlSock "RNFR $ftp(RenameFrom)"
  		  	  set ftp(State) rename_to
			}
			
		rename_to {
			  switch $rc {
			    3       {
			  	       PutsCtrlSock "RNTO $ftp(RenameTo)"
  		  	  	       set ftp(State) rename_sent
			            }
			    default {
				       set errmsg "Error renaming file \"$ftp(RenameFrom)\"!"
				       set complete_with 0
				     }
			  }
			}

		rename_sent {
			  switch $rc {
			    2     {
			               set complete_with 1
			            }
			    default {
				       set errmsg "Error renaming file \"$ftp(RenameFrom)\"!"
				       set complete_with 0
				     }
			  }
			}
			
		put_active 	{
			  if {[OpenActiveConn]} {
			    	PutsCtrlSock "PORT $ftp(LocalAddr),$ftp(DataPort)"
			  	set ftp(State) put_open
			  } else {
				set errmsg "Error setting port!"
			  }
			}
			
			
		put_passive	{
			               PutsCtrlSock "PASV"
			  	       set ftp(State) put_open
			}
			
		put_open {
			  switch $rc {
			    2  {
			         if {$ftp(Mode) == "passive"} {
				     if {![OpenPassiveConn $buffer]} {
				         set errmsg "Error setting PASSIVE mode!"
				       	 set complete_with 0
				     }
				 }   
			         PutsCtrlSock "STOR $ftp(RemoteFilename)"
			         set ftp(State) put_sent
			       }
			    default {
			              if {$ftp(Mode) == "passive"} {
				          set errmsg "Error setting PASSIVE mode!"
				      } else {
				          set errmsg "Error setting port!"
				      }  
				      set complete_with 0
				    }
			  }
		}
			
		put_sent	{
			  switch $rc {
			    1       {
			               set ftp(State) put_close
			            }
			    default {
			              if {$ftp(Mode) == "passive"} {

			    	         unset state(data)
				      }  
				       set errmsg "Error opening connection!"
				       set complete_with 0
				     }
			  }
		}
			
		put_close	{
			  switch $rc {
			    2       {
			  	       set complete_with 1
			            }
			    default {
				       set errmsg "Error storing file \"$ftp(RemoteFilename)\"!"
				       set complete_with 0
				     }
			  }
		}
			
		append_active 	{
			  if {[OpenActiveConn]} {
			    	PutsCtrlSock "PORT $ftp(LocalAddr),$ftp(DataPort)"
			  	set ftp(State) append_open
			  } else {
				set errmsg "Error setting port!"
			  }
			}
			
			
		append_passive	{
			               PutsCtrlSock "PASV"
			  	       set ftp(State) append_open
			}
			
		append_open {
			  switch $rc {
			    2  {
			         if {$ftp(Mode) == "passive"} {
				     if {![OpenPassiveConn $buffer]} {
				         set errmsg "Error setting PASSIVE mode!"
				       	 set complete_with 0
				     }
				 }   
			         PutsCtrlSock "APPE $ftp(RemoteFilename)"
			         set ftp(State) append_sent
			       }
			    default {
			              if {$ftp(Mode) == "passive"} {
				          set errmsg "Error setting PASSIVE mode!"
				      } else {
				          set errmsg "Error setting port!"
				      }  
				      set complete_with 0
				    }
			  }
		}
			
		append_sent	{
			  switch $rc {
			    1       {
			               set ftp(State) append_close
			            }
			    default {
			              if {$ftp(Mode) == "passive"} {

			    	         unset state(data)
				      }  
				       set errmsg "Error opening connection!"
				       set complete_with 0
				     }
			  }
		}
			
		append_close	{
			  switch $rc {
			    2       {
			  	       set complete_with 1
			            }
			    default {
				       set errmsg "Error storing file \"$ftp(RemoteFilename)\"!"
				       set complete_with 0
				     }
			  }
		}
			
		reget_active 	{
			  if {[OpenActiveConn]} {
			    	PutsCtrlSock "PORT $ftp(LocalAddr),$ftp(DataPort)"
			  	set ftp(State) reget_restart
			  } else {
				set errmsg "Error setting port!"
			  }
		}
			
		reget_passive	{
			               PutsCtrlSock "PASV"
			  	       set ftp(State) reget_restart
		}
			
		reget_restart {
			  switch $rc {
			    2 { 
			         if {$ftp(Mode) == "passive"} {
				     if {![OpenPassiveConn $buffer]} {
				         set errmsg "Error setting PASSIVE mode!"
				       	 set complete_with 0
				     }
				 }   
			         if {$ftp(FileSize) != 0} {
				    PutsCtrlSock "REST $ftp(FileSize)"
	               		    set ftp(State) reget_open
				 } else {
			            PutsCtrlSock "RETR $ftp(RemoteFilename)"
			           set ftp(State) reget_sent
				 } 
			       }
			    default {
				       set errmsg "Error restarting filetransfer of \"$ftp(RemoteFilename)\"!"
				       set complete_with 0
				     }
			  }
			}
			
		reget_open {
			  switch $rc {
			    2  -
			    3  {
			         PutsCtrlSock "RETR $ftp(RemoteFilename)"
			         set ftp(State) reget_sent
			       }
			    default {
			              if {$ftp(Mode) == "passive"} {
				          set errmsg "Error setting PASSIVE mode!"
				      } else {
				          set errmsg "Error setting port!"
				      }  
				      set complete_with 0
				    }
			   }
			 }
			
			
		reget_sent	{
			  switch $rc {
			    1 {
			         set ftp(State) reget_close
			       }
			    default {
			              if {$ftp(Mode) == "passive"} {

			    	         unset state(data)
				      }  
				      set errmsg "Error retrieving file \"$ftp(RemoteFilename)\"!"
				      set complete_with 0
				    }
			   }
		}
			
		reget_close	{
			  switch $rc {
			    2       {
			  	       set complete_with 1
			            }
			    default {
				       set errmsg "Error retrieving file \"$ftp(RemoteFilename)\"!"
				       set complete_with 0
				     }
			  }
		}
		get_active 	{
			  if {[OpenActiveConn]} {
			    	PutsCtrlSock "PORT $ftp(LocalAddr),$ftp(DataPort)"
			  	set ftp(State) get_open
			  } else {
				set errmsg "Error setting port!"
			  }
			}
			
		get_passive {
			        PutsCtrlSock "PASV"
			  	set ftp(State) get_open
			    }
			
		get_open {
			  switch $rc {
			    2  -
			    3  {
			         if {$ftp(Mode) == "passive"} {
				     if {![OpenPassiveConn $buffer]} {
				         set errmsg "Error setting PASSIVE mode!"
				       	 set complete_with 0
				     }
				 }   
			         PutsCtrlSock "RETR $ftp(RemoteFilename)"
			         set ftp(State) get_sent
			       }
			    default {
			              if {$ftp(Mode) == "passive"} {
				          set errmsg "Error setting PASSIVE mode!"
				      } else {
				          set errmsg "Error setting port!"
				      }  
				      set complete_with 0
				    }
			   }
			 }
			
		get_sent	{
			  switch $rc {
			    1 {
			         set ftp(State) get_close
			       }
			    default {
			              if {$ftp(Mode) == "passive"} {

			    	         unset state(data)
				      }  
				      set errmsg "Error retrieving file \"$ftp(RemoteFilename)\"!"
				      set complete_with 0
				    }
			   }
		}
			
		get_close	{
			  switch $rc {
			    2       {
			  	       set complete_with 1
			            }
			    default {
				       set errmsg "Error retrieving file \"$ftp(RemoteFilename)\"!"
				       set complete_with 0
				     }
			  }
		}

			
	}

	if {[info exists complete_with]} {
		WaitComplete $complete_with
	}

	if {[info exists buffer]} {
		if {$VERBOSE} {
			foreach line [split $buffer \n] {
				DisplayMsg "C: $line" control
			}
		}
	}
	

	if {[info exists errmsg]} {
		set ftp(Error) $errmsg
		DisplayMsg $errmsg error
	}

}

proc Type {{type ""}} {
variable ftp 

	if ![info exists ftp(State)] {
		DisplayMsg "Not connected!" error
		return {}
	}

	if { $type == "" } {
		return $ftp(Type)
	}

	set old_type $ftp(Type) 
	
	set ftp(Type) $type
	set ftp(State) type
	StateHandler
	

	set rc [WaitOrTimeout]
	if {$rc} {
		return $ftp(Type)
	} else {

		set ftp(Type) $old_type
		return {}
	}

}

proc NList {{dir ""}} {
variable ftp 

	if ![info exists ftp(State)] {
		DisplayMsg "Not connected!" error
		return {}
	}

	set ftp(List) {}
	if { $dir == "" } {
		set ftp(Dir) ""
	} else {
		set ftp(Dir) " $dir"
	}

	set old_type $ftp(Type)
	if { $ftp(Type) != "ascii" } {
		Type ascii
	}

	set ftp(State) nlist_$ftp(Mode)
	StateHandler

	set rc [WaitOrTimeout]

	if { [Type] != $old_type } {
		Type $old_type
	}

	unset ftp(Dir)
	if {$rc} { 
		return [lsort $ftp(List)]
	} else {
		CloseDataConn
		return {}
	}

}

proc List {{dir ""}} {
variable ftp 

	if ![info exists ftp(State)] {
		DisplayMsg "Not connected!" error
		return {}
	}

	set ftp(List) {}
	if { $dir == "" } {
		set ftp(Dir) ""
	} else {
		set ftp(Dir) " $dir"
	}

	set old_type $ftp(Type)
	if { $ftp(Type) != "ascii" } {
		Type ascii
	}

	set ftp(State) list_$ftp(Mode)
	StateHandler

	set rc [WaitOrTimeout]

	if { [Type] != $old_type } {
		Type $old_type
	}

	unset ftp(Dir)
	if {$rc} { 
		

		set l [split $ftp(List) "\n"]
		set index [lsearch -regexp $l "^total"]
		if { $index != "-1" } { 
			set l [lreplace $l $index $index]
		}

		set index [lsearch -regexp $l "^$"]
		if { $index != "-1" } { 
			set l [lreplace $l $index $index]
		}
		
		return $l
	} else {
		CloseDataConn
		return {}
	}
}

proc FileSize {{filename ""}} {
variable ftp 

	if ![info exists ftp(State)] {
		DisplayMsg "Not connected!" error
		return {}
	}
	
	if { $filename == "" } {
		return {}
	} 

	set ftp(File) $filename
	set ftp(FileSize) 0
	
	set ftp(State) size
	StateHandler

	set rc [WaitOrTimeout]
	
	unset ftp(File)
		
	if {$rc} {
		return $ftp(FileSize)
	} else {
		return {}
	}

}

proc ModTime {{filename ""}} {
variable ftp 

	if ![info exists ftp(State)] {
		DisplayMsg "Not connected!" error
		return {}
	}
	
	if { $filename == "" } {
		return {}
	} 

	set ftp(File) $filename
	set ftp(DateTime) ""
	
	set ftp(State) modtime
	StateHandler

	set rc [WaitOrTimeout]
	
	unset ftp(File)
		
	if {$rc} {
		scan $ftp(DateTime) "%4s%2s%2s%2s%2s%2s" year month day hour min sec
		set clock [clock scan "$month/$day/$year $hour:$min:$sec" -gmt 1]
		unset year month day hour min sec
		return $clock
	} else {
		return {}
	}

}

proc Pwd {} {
variable ftp 

	if ![info exists ftp(State)] {
		DisplayMsg "Not connected!" error
		return {}
	}

	set ftp(Dir) {}

	set ftp(State) pwd
	StateHandler

	set rc [WaitOrTimeout]
	
	if {$rc} {
		return $ftp(Dir)
	} else {
		return {}
	}
}

proc Cd {{dir ""}} {
variable ftp 

	if ![info exists ftp(State)] {
		DisplayMsg "Not connected!" error
		return 0
	}

	if { $dir == "" } {
		set ftp(Dir) ""
	} else {
		set ftp(Dir) " $dir"
	}

	set ftp(State) cd
	StateHandler

	set rc [WaitOrTimeout] 

	unset ftp(Dir)
	
	if {$rc} {
		return 1
	} else {
		return 0
	}
}

proc MkDir {dir} {
variable ftp 

	if ![info exists ftp(State)] {
		DisplayMsg "Not connected!" error
		return 0
	}

	set ftp(Dir) $dir

	set ftp(State) mkdir
	StateHandler

	set rc [WaitOrTimeout] 

	unset ftp(Dir)
	
	if {$rc} {
		return 1
	} else {
		return 0
	}
}

proc RmDir {dir} {
variable ftp 

	if ![info exists ftp(State)] {
		DisplayMsg "Not connected!" error
		return 0
	}

	set ftp(Dir) $dir

	set ftp(State) rmdir
	StateHandler

	set rc [WaitOrTimeout] 

	unset ftp(Dir)
	
	if {$rc} {
		return 1
	} else {
		return 0
	}
}

proc Delete {file} {
variable ftp 

	if ![info exists ftp(State)] {
		DisplayMsg "Not connected!" error
		return 0
	}

	set ftp(File) $file

	set ftp(State) delete
	StateHandler

	set rc [WaitOrTimeout] 

	unset ftp(File)
	
	if {$rc} {
		return 1
	} else {
		return 0
	}
}

proc Rename {from to} {
variable ftp 

	if ![info exists ftp(State)] {
		DisplayMsg "Not connected!" error
		return 0
	}

	set ftp(RenameFrom) $from
	set ftp(RenameTo) $to

	set ftp(State) rename

	StateHandler

	set rc [WaitOrTimeout] 

	unset ftp(RenameFrom)
	unset ftp(RenameTo)
	
	if {$rc} {
		return 1
	} else {
		return 0
	}
}

proc ElapsedTime {stop_time} {
variable ftp

	set elapsed [expr $stop_time - $ftp(Start_Time)]
	if { $elapsed == 0 } { set elapsed 1}
	set persec [expr $ftp(Total) / $elapsed]
	DisplayMsg "$ftp(Total) bytes sent in $elapsed seconds ($persec Bytes/s)"
}

proc Put {source {dest ""}} {
variable ftp 

	if ![info exists ftp(State)] {
		DisplayMsg "Not connected!" error
		return 0
	}

	if ![file exists $source] {
		DisplayMsg "File \"$source\" not exist" error
		return 0
     	}
			
	if { $dest == "" } {
		set dest $source
	}

	set ftp(LocalFilename) $source
	set ftp(RemoteFilename) $dest

	set ftp(SourceCI) [open $ftp(LocalFilename) r]
	if { $ftp(Type) == "ascii" } {
		fconfigure $ftp(SourceCI) -buffering line -blocking 1
	} else {
		fconfigure $ftp(SourceCI) -buffering line -translation binary -blocking 1
	}

	set ftp(State) put_$ftp(Mode)
	StateHandler

	set rc [WaitOrTimeout]
	if {$rc} {
		ElapsedTime [clock seconds]
		return 1
	} else {
		CloseDataConn
		return 0
	}

}

proc Append {source {dest ""}} {
variable ftp 

	if ![info exists ftp(State)] {
		DisplayMsg "Not connected!" error
		return 0
	}

	if ![file exists $source] {
		DisplayMsg "File \"$source\" not exist" error
		return 0
     	}
			
	if { $dest == "" } {
		set dest $source
	}

	set ftp(LocalFilename) $source
	set ftp(RemoteFilename) $dest

	set ftp(SourceCI) [open $ftp(LocalFilename) r]
	if { $ftp(Type) == "ascii" } {
		fconfigure $ftp(SourceCI) -buffering line -blocking 1
	} else {
		fconfigure $ftp(SourceCI) -buffering line -translation binary -blocking 1
	}

	set ftp(State) append_$ftp(Mode)
	StateHandler

	set rc [WaitOrTimeout]
	if {$rc} {
		ElapsedTime [clock seconds]
		return 1
	} else {
		CloseDataConn
		return 0
	}

}

proc Get {source {dest ""}} {
variable ftp 

	if ![info exists ftp(State)] {
		DisplayMsg "Not connected!" error
		return 0
	}

	if { $dest == "" } {
		set dest $source
	}

	set ftp(RemoteFilename) $source
	set ftp(LocalFilename) $dest

	set ftp(State) get_$ftp(Mode)
	StateHandler

	set rc [WaitOrTimeout]
	if {$rc} {
		ElapsedTime [clock seconds]
		return 1
	} else {
		CloseDataConn
		return 0
	}

}

proc Reget {source {dest ""}} {
variable ftp 

	if ![info exists ftp(State)] {
		DisplayMsg "Not connected!" error
		return 0
	}

	if { $dest == "" } {
		set dest $source
	}

	set ftp(RemoteFilename) $source
	set ftp(LocalFilename) $dest

	if [file exists $ftp(LocalFilename)] {
		set ftp(FileSize) [file size $ftp(LocalFilename)]
	} else {
		set ftp(FileSize) 0
	}
	
	set ftp(State) reget_$ftp(Mode)
	StateHandler

	set rc [WaitOrTimeout]
	if {$rc} {
		ElapsedTime [clock seconds]
		return 1
	} else {
		CloseDataConn
		return 0
	}

}

proc Newer {source {dest ""}} {
variable ftp 

	if ![info exists ftp(State)] {
		DisplayMsg "Not connected!" error
		return 0
	}

	if { $dest == "" } {
		set dest $source
	}

	set ftp(RemoteFilename) $source
	set ftp(LocalFilename) $dest

	set rmt [ModTime $ftp(RemoteFilename)]
	if { $rmt == "-1" } {
		return 0
	}

	if [file exists $ftp(LocalFilename)] {
		set lmt [file mtime $ftp(LocalFilename)]
	} else {
		set lmt 0
	}
	

	if { $rmt < $lmt } {
		return 0
	}

	set rc [Get $ftp(RemoteFilename) $ftp(LocalFilename)]
	return $rc
		
}

proc Quote {args} {
variable ftp

	if ![info exists ftp(State)] {
		DisplayMsg "Not connected!" error
		return 0
	}

	set ftp(Cmd) $args

	set ftp(State) quote
	StateHandler

	set rc [WaitOrTimeout] 

	unset ftp(Cmd)

	if {$rc} {
		return $ftp(Quote)
	} else {
		return {}
	}
}

proc Close {} {
variable ftp

	if ![info exists ftp(State)] {
		DisplayMsg "Not connected!" error
		return 0
	}

	set ftp(State) quit
	StateHandler

	WaitOrTimeout

	catch {close $ftp(CtrlSock)}
	catch {unset ftp}
}

proc Open {server user passwd {args ""}} {
variable ftp
variable DEBUG 
variable VERBOSE
upvar #0 finished state

	if [info exists ftp(State)] {
       		DisplayMsg "Mmh, another attempt to open a new connection? There is already a hot wire!" error
		return 0
	}

	if {![info exists DEBUG]} {
		set DEBUG 0
	}

	if {![info exists VERBOSE]} {
		set VERBOSE 0
	}
	
	if {$DEBUG} {
		DisplayMsg "Starting new connection with: "
	}
	
	set ftp(User) 		$user
	set ftp(Passwd) 	$passwd
	set ftp(RemoteHost) 	$server
	set ftp(LocalHost) 	[info hostname]
	set ftp(DataPort) 	0
	set ftp(Type) 		{}
	set ftp(Error) 		{}
	set ftp(Progress) 	{}
	set ftp(Blocksize) 	4096	
	set ftp(Timeout) 	600	
	set ftp(Mode) 		active	
	set ftp(Port) 		21	

	set ftp(State) 		user
	

	set state(control) ""
	

	set options {-blocksize -timeout -mode -port -progress}
	foreach {option value} $args {
		if { [lsearch -exact $options $option] != "-1" } {
				if {$DEBUG} {
					DisplayMsg "  $option = $value"
				}
				regexp {^-(.?)(.*)$} $option all first rest
				set option "[string toupper $first]$rest"
				set ftp($option) $value
		} 
	}
	if { $DEBUG && ($args == "") } {
		DisplayMsg "  no option"
	}

	if ![OpenControlConn] { return 0 }

	if {[WaitOrTimeout]} {

		Type binary
		return 1
	} else {

		Close
		return 0
	}
}

proc CopyNext {bytes {error {}}} {
variable ftp
variable DEBUG
variable VERBOSE
upvar #0 finished state

	incr ftp(Total) $bytes

	if { ([info exists ftp(Progress)]) && ([info commands [lindex $ftp(Progress) 0]] != "") } { 
		eval $ftp(Progress) $ftp(Total)
	}

	after cancel $ftp(Wait)
	set ftp(Wait) [after [expr $ftp(Timeout) * 1000] [namespace current]::Timeout]

	if {$DEBUG} {
		DisplayMsg "-> $ftp(Total) bytes $ftp(SourceCI) -> $ftp(DestCI)" 
	}

	if {$error != ""} {
		catch {close $ftp(DestCI)}
		catch {close $ftp(SourceCI)}
   		unset state(data)
		DisplayMsg $error error

	} elseif {[eof $ftp(SourceCI)]} {
		close $ftp(DestCI)
		close $ftp(SourceCI)
   		unset state(data)
		if {$VERBOSE} {
			DisplayMsg "D: Port closed" data
		}

	} else {
		fcopy $ftp(SourceCI) $ftp(DestCI) -command [namespace current]::CopyNext -size $ftp(Blocksize)

	}

}

proc HandleData {sock} {
variable ftp 

	fileevent $sock writable {}		
	fileevent $sock readable {}

	if [regexp "^get" $ftp(State)] {
		set rc [catch {set ftp(DestCI) [open $ftp(LocalFilename) w]} msg]
		if { $rc != 0 } {
			DisplayMsg "$msg" error
			return 0
		}
		if { $ftp(Type) == "ascii" } {
			fconfigure $ftp(DestCI) -buffering line -blocking 1
		} else {
			fconfigure $ftp(DestCI) -buffering line -translation binary -blocking 1
		}
	}	

	if [regexp "^reget" $ftp(State)] {
		set rc [catch {set ftp(DestCI) [open $ftp(LocalFilename) a]} msg]
		if { $rc != 0 } {
			DisplayMsg "$msg" error
			return 0
		}
		if { $ftp(Type) == "ascii" } {
			fconfigure $ftp(DestCI) -buffering line -blocking 1
		} else {
			fconfigure $ftp(DestCI) -buffering line -translation binary -blocking 1
		}
	}	

	set ftp(Total) 0
	set ftp(Start_Time) [clock seconds]
	fcopy $ftp(SourceCI) $ftp(DestCI) -command [namespace current]::CopyNext -size $ftp(Blocksize)
}

proc HandleList {sock} {
variable ftp 
variable VERBOSE
upvar #0 finished state

	if ![eof $sock] {
		set buffer [read $sock]
		if { $buffer != "" } {
			set ftp(List) [append ftp(List) $buffer]
		}	
	} else {
		close $sock
   		unset state(data)
		if {$VERBOSE} {
			DisplayMsg "D: Port closed" data
		}
	} 
}

proc CloseDataConn {} {
variable ftp

	catch {after cancel $ftp(Wait)}
	catch {fileevent $ftp(DataSock) readable {}}
	catch {close $ftp(DataSock); unset ftp(DataSock)}
	catch {close $ftp(DestCI); unset ftp(DestCI)} 
	catch {close $ftp(SourceCI); unset ftp(SourceCI)}
	catch {close $ftp(DummySock); unset ftp(DummySock)}
}

proc InitDataConn {sock addr port} {
variable ftp
variable VERBOSE
upvar #0 finished state

	catch {close $ftp(DummySock); unset ftp(DummySock)}

	set state(data) 0

	if { $ftp(Type) == "ascii" } {
		fconfigure $sock -buffering line -blocking 1
	} else {
		fconfigure $sock -buffering line -translation binary -blocking 1
	}

	switch -regexp $ftp(State) {

		list {
			  fileevent $sock readable [list [namespace current]::HandleList $sock]
			  set ftp(SourceCI) $sock		  
			}

		get	{
			  fileevent $sock readable [list [namespace current]::HandleData $sock]
			  set ftp(SourceCI) $sock			  
			}

		append  -
		
		put {
			  fileevent $sock writable [list [namespace current]::HandleData $sock]
			  set ftp(DestCI) $sock			  
			}
	}

	if {$VERBOSE} {
		DisplayMsg "D: Connection from $addr:$port" data
	}
}

proc OpenActiveConn {} {
variable ftp
variable VERBOSE

	set rc [catch {set ftp(DummySock) [socket -server [namespace current]::InitDataConn 0]} msg]
	if { $rc != 0 } {
       		DisplayMsg "$msg" error
       		return 0
	}

	set p [lindex [fconfigure $ftp(DummySock) -sockname] 2]
	if {$VERBOSE} {
		DisplayMsg "D: Port is $p" data
	}
	set ftp(DataPort) "[expr "$p / 256"],[expr "$p % 256"]"

	return 1
}

proc OpenPassiveConn {buffer} {
variable ftp

	if {[regexp {([0-9]+),([0-9]+),([0-9]+),([0-9]+),([0-9]+),([0-9]+)} $buffer all a1 a2 a3 a4 p1 p2]} {
		set ftp(LocalAddr) "$a1.$a2.$a3.$a4"
		set ftp(DataPort) "[expr $p1 * 256 + $p2]"

		set rc [catch {set ftp(DataSock) [socket $ftp(LocalAddr) $ftp(DataPort)]} msg]
		if { $rc != 0 } {
			DisplayMsg "$msg" error
			return 0
		}

		InitDataConn $ftp(DataSock) $ftp(LocalAddr) $ftp(DataPort)			
		return 1
	} else {
		return 0
	}
}

proc OpenControlConn {} {
variable ftp
variable DEBUG
variable VERBOSE

        set rc [catch {set ftp(CtrlSock) [socket $ftp(RemoteHost) $ftp(Port)]} msg]
	if { $rc != 0 } {
		if {$VERBOSE} {
       			DisplayMsg "C: No connection to server!" error
		}
		if {$DEBUG} {
			DisplayMsg "[list $msg]" error
		}
       		unset ftp(State)
       		return 0
	}

	fconfigure $ftp(CtrlSock) -buffering line -blocking 1 -translation {auto crlf}
        fileevent $ftp(CtrlSock) readable [list [namespace current]::StateHandler $ftp(CtrlSock)]
	

	set ftp(LocalAddr) [lindex [fconfigure $ftp(CtrlSock) -sockname] 0]
	regsub -all "\[.\]" $ftp(LocalAddr) "," ftp(LocalAddr) 

	set peer [fconfigure $ftp(CtrlSock) -peername]
	if {$VERBOSE} {
		DisplayMsg "C: Connection from [lindex $peer 0]:[lindex $peer 2]" control
	}
	
	return 1
}

set Bg_Color                                     #FFFFFF
set Fg_Color                                     blue
set Menubar_Bg_Color                             #63b8ff
set Object_Color                                 LightSkyBlue1
set Ftpbar_Color				 blue
set Version_Color				 red

option add *background $Bg_Color
option add *foreground $Fg_Color
option add *activeBackground $Fg_Color
option add *activeForeground $Bg_Color
option add *highlightBackground $Bg_Color
option add *troughColor $Menubar_Bg_Color 
option add *disabledForeground grey
option add *Listbox.Background $Object_Color
option add *Button.Background $Object_Color
option add *Text.Background $Object_Color
option add *Scrollbar.Background $Object_Color
option add *Entry.Background $Object_Color
option add *Radiobutton.troughcolor $Object_Color
option add *Checkbutton.troughcolor $Object_Color
option add *selectBackground $Fg_Color
option add *selectForeground $Object_Color

proc Small_Font {} {return {-adobe-helvetica-bold-r-normal-*-14-*}}
proc Large_Font {} {return {-Adobe-Helvetica-Medium-R-Normal-*-*-240-*}}

global STACK
global TOP
set TOP 0

proc Push {ELEM} {
    global STACK 
    global TOP
    set STACK($TOP) $ELEM
    incr TOP
}

proc Pop {} {
    global STACK 
    global TOP
    incr TOP -1
    return $STACK($TOP)
}

proc Make_Check {PATH TEXT SIDE {VAR 1} } {
    checkbutton $PATH \
	-text $TEXT \
	-variable $VAR \
	-font [Small_Font]\
	-command {}
    pack $PATH -side $SIDE
    return $PATH
}

proc Make_Button {PATH TEXT SIDE CMD} {
    button $PATH \
	-text $TEXT \
	-command $CMD \
	-font [Small_Font]
    pack $PATH -side $SIDE
}

	
proc Make_Entry {PATH VAR WIDTH SIDE} {
    entry $PATH \
	-textvariable $VAR \
	-font [Small_Font] \
	-width $WIDTH 
    pack $PATH -side $SIDE
}

proc Make_Label {PATH SIDE TEXT} {
    label $PATH \
	-text $TEXT \
	-wraplength 500 \
	-font [Small_Font]
    pack $PATH -side $SIDE
}

proc Message {ALIGN NUM TEXT} {
    set LABELFRAME [frame [Main_Frame].message_$NUM ]
    label $LABELFRAME.label \
	-text $TEXT \
	-justify $ALIGN \
	-wraplength 500 \
	-font [Small_Font]
    pack $LABELFRAME.label -side left
    pack $LABELFRAME -side top -fill x
    update ; update idletasks
}

proc Change_Message {NUM TEXT} {
    [Main_Frame].message_$NUM.label configure -text $TEXT
}

proc Color_Message {NUM COLOR} {
    [Main_Frame].message_$NUM.label configure -foreground $COLOR
}

proc Make_Checkbutton_hide {FRAME_HIDE TEXT NAME i} {
    global COLOR
    global GL
    global Tree_files

    set FRAME [frame $FRAME_HIDE.hide_$NAME]
    checkbutton $FRAME.c \
	-text $TEXT \
	-variable GL(SHOW_$NAME) \
	-font [Small_Font]\
	-selectcolor [subst \$COLOR($NAME)] \
	-command "
 . configure -cursor watch
 update idletasks
 hide_files $Tree_files.tree $NAME
 update idletasks
 . configure -cursor {}
"
    grid  $FRAME -column 1 -row $i -sticky nsew
    pack $FRAME.c -side left 
}

proc Rename_Next {TEXT} {
    .invisible.frame_bottom.exit configure -text $TEXT
}

proc FrameMessage {NAME TEXT {WITH_BULLET 1} } {

    set FRAMENAME [frame [Main_Frame].$NAME]
    set CANVAS_BULLET [canvas $FRAMENAME.canvas -width 10 -height 10 ]

    set MESSAGE_$NAME [label $FRAMENAME.label \
			   -text $TEXT\
			   -font [Small_Font]\
			   -foreground gray
		      ]

    if $WITH_BULLET {
	$CANVAS_BULLET create oval 2 2 9 9 -fill gray -outline gray
	pack $CANVAS_BULLET  -side left
    } 
	pack [subst \$MESSAGE_$NAME] -side left

    return $FRAMENAME
}

proc Make_Search_messages {} {

    set MESSAGE_BEGIN_FIND         [FrameMessage begin_find [Get_Search_Text begin_find]]

    set MESSAGE_LOAD_FILES         [FrameMessage load_files [Get_Search_Text load_files]]

    set MESSAGE_REMAINING_FILES    [FrameMessage remaining_files [Get_Search_Text remaining_files]]

    set MESSAGE_SORTING_FILES      [FrameMessage sorting_files [Get_Search_Text sorting_files]]

    set MESSAGE_UNJOIN_FILES       [FrameMessage unjoin_files [Get_Search_Text unjoin_files]]

    set MESSAGE_GENERATE_TREE      [FrameMessage generate_tree "Preparing the display of files selected..."]

    pack $MESSAGE_BEGIN_FIND          -side top -padx 20 -pady 10  -fill x 
    pack $MESSAGE_LOAD_FILES          -side top -padx 20 -pady 10  -fill x 
    pack $MESSAGE_REMAINING_FILES     -side top -padx 20 -pady 10  -fill x 
    pack $MESSAGE_SORTING_FILES       -side top -padx 20 -pady 10  -fill x 
    pack $MESSAGE_UNJOIN_FILES        -side top -padx 20 -pady 10  -fill x
    pack $MESSAGE_GENERATE_TREE       -side top -padx 20 -pady 10  -fill x
    update idletasks
}

proc Make_Send_FTP_message {} {
    global GL

    set MESSAGE_TAR               [FrameMessage tar [subst [Texte archive]] ]
    set MESSAGE_OPEN_CONNEXION    [FrameMessage open_connexion  [subst [Texte ouverture_connexion]] ]
    set MESSAGE_TRANSFERT         [FrameMessage transfert [subst [Texte transfert]] ]
    set MESSAGE_SAVE_LISTS         [FrameMessage save_lists [subst [Texte sauvegarde_listes]] ]

    pack $MESSAGE_TAR             -side top -padx 20 -pady 25  -fill x
    pack $MESSAGE_OPEN_CONNEXION  -side top -padx 20 -pady 25  -fill x
    pack $MESSAGE_TRANSFERT       -side top -padx 20 -pady 25  -fill x

    Barre_Init

    pack $MESSAGE_SAVE_LISTS      -side top -padx 20 -pady 25  -fill x
    update idletasks
}

proc Activate_message {NAME} {
    [Main_Frame].$NAME.label configure -foreground red
    [Main_Frame].$NAME.canvas itemconfigure all -outline red -fill red
    update idletasks
}

proc Desactivate_message {NAME} {
    [Main_Frame].$NAME.label configure -foreground blue
    [Main_Frame].$NAME.canvas itemconfigure all -outline blue -fill blue
    update idletasks
}

proc legend_checkbox {} {
    set FRAME_LEGEND [frame [Main_Frame].frame_legend]

    set CANVAS_ON [canvas $FRAME_LEGEND.canvas_on \
                         -width 20 \
		       -height 20 ]

    set CANVAS_OFF [canvas $FRAME_LEGEND.canvas_off \
                         -width 20 \
		       -height 20 ]

    set CANVAS_DEF [canvas $FRAME_LEGEND.canvas_def \
                         -width 20 \
		       -height 20 ]

    $CANVAS_ON create image 2 2 -image $::CK_IMAGE_ON -anchor nw
    $CANVAS_OFF create image 2 2 -image $::CK_IMAGE_OFF -anchor nw
    $CANVAS_DEF create image 2 2 -image $::CK_IMAGE_DEF -anchor nw

    set FRAME_ON  [ frame $FRAME_LEGEND.frame_on  ]
    set FRAME_OFF [ frame $FRAME_LEGEND.frame_off ]
    set FRAME_DEF [ frame $FRAME_LEGEND.frame_def ]

    set LABEL_ON  [ label $FRAME_ON.label_on -justify left -text "Selected" -font [Small_Font] ]
    set LABEL_OFF [ label $FRAME_OFF.label_off -justify left  -text "Unselected" -font [Small_Font] ]
    set LABEL_DEF [ label $FRAME_DEF.label_def -justify left -text "Partially selected" -font [Small_Font] ]

    pack $LABEL_ON -side left
    pack $LABEL_OFF -side left
    pack $LABEL_DEF -side left
    grid $FRAME_ON -column 2 -row 1 -sticky nsew
    grid $CANVAS_ON -column 1 -row 1 -sticky nsew
    grid $FRAME_OFF -column 2 -row 2 -sticky nsew
    grid $CANVAS_OFF -column 1 -row 2 -sticky nsew
    grid $FRAME_DEF -column 2 -row 3 -sticky nsew
    grid $CANVAS_DEF -column 1 -row 3 -sticky nsew
    pack $FRAME_LEGEND -side top -pady 10 -padx 10
}

proc Warning_Window {Window_Name Window_Text} {
    global CADP
    global env
   wm title $Window_Name $Window_Text 
   wm geometry $Window_Name +[expr [winfo x .] + 100]+[expr [winfo y .] + 80]
   set FRAME_LOGO [frame $Window_Name.frame_logo]
   set CANVAS_LOGO [canvas $FRAME_LOGO.canvas_logo \
                         -width 65 \
                         -height 75 ]

   image create photo LOGO_ATTENTION -format GIF -file $env(CADP_CONTRIBUTOR)/attention.gif
   set IMG_LOGO_ATTENTION [$CANVAS_LOGO create image 1 1 \
                           -image LOGO_ATTENTION \
                           -anchor nw ]
   pack $CANVAS_LOGO -side left
   pack $FRAME_LOGO -side left -padx 10 -pady 5
}

proc Wait_Window {Window_Text} {

    catch {destroy .wait_window}
    toplevel .wait_window
    wm title .wait_window "Contributor: Please wait"
    wm geometry .wait_window +[expr [winfo x .] + 100]+[expr [winfo y .] + 80]

    wm minsize .wait_window 300 70

    set LOGO_INFO [tix getimage info]
    set CANVAS_LOGO [canvas .wait_window.canvas_logo \
                         -width 50 \
                         -height 50 ]

    set CANVAS_LOGO_INFO [$CANVAS_LOGO create image 5 5 -image $LOGO_INFO -anchor nw]
    set LABEL [label .wait_window.label -text $Window_Text -font [Small_Font] ]

    pack $CANVAS_LOGO -side left
    pack $LABEL -side left
    update idletasks

}

proc destroy_Wait_Window {} {
        catch {destroy .wait_window}
}

proc Ask_Quit {} {
    global GL

   if [catch {set FILE_WINDOW [toplevel .quitwindow]} err] then {
        return
   }

    Warning_Window .quitwindow "Quit Contributor?"
    grab set .quitwindow   
    bell
    set FRAME [frame .quitwindow.f]
    set FRAME_MSG1 [frame $FRAME.msg1]
    Make_Label $FRAME_MSG1.msg left [subst [Texte Ask_Quit]]
    $FRAME_MSG1.msg configure -justify left
    pack $FRAME_MSG1 -side top -fill x

    set FRAME_MIDDLE [frame $FRAME.fm]

    pack $FRAME_MIDDLE -side top

    set FRAME_MSG2 [frame $FRAME.msg2]
    Make_Label $FRAME_MSG2.msg_middle top "\nDo you really want to quit?"
    pack $FRAME_MSG2 -side top -fill x

    set GL(REMEMBER_PREFERENCES) 1
    Make_Check $FRAME_MSG2.save_preferences "Remember preferences" bottom GL(REMEMBER_PREFERENCES)

    set FRAME_BAS [frame $FRAME.f] 
    Make_Button $FRAME_BAS.yes "Yes" left {
	
	destroy .quitwindow
	Quit
    }

    Make_Button $FRAME_BAS.no "No" right {

	unset GL(REMEMBER_PREFERENCES)
	destroy .quitwindow
    }
    pack $FRAME_BAS -side bottom -expand true -fill x -padx 20 -pady 10
    pack $FRAME -side right -padx 5
} 

proc centrage {X Y PATH} {
    set DELTA_X [expr [winfo screenwidth $PATH] - $X]
    set DELTA_Y [expr [winfo screenheight $PATH] - $Y]
    set CENTRAGE "${X}x$Y+[expr $DELTA_X / 2]+[expr $DELTA_Y / 2]"  
    wm geometry $PATH $CENTRAGE    
    wm maxsize $PATH $X $Y
    wm minsize $PATH $X $Y
}

proc Make_Screen { SCREEN_MODE {DESTROY_LEFT 0} } {
    if { $DESTROY_LEFT == 1 } {
	foreach widget [ pack slaves [Left_Main_Frame]] {
	     pack forget $widget 
	}
    }
    catch {destroy .invisible.f_middle.f.main_frame}
    set MAIN_FRAME [frame .invisible.f_middle.f.main_frame]
    pack $MAIN_FRAME -fill both -expand true

}

proc Make_left_logo {} {

    global env
    global CANVAS_LOGO
    global COPYRIGHT

    set CANVAS_LOGO [canvas [Left_Main_Frame].canvas_logo \
			 -width 150 \
			 -height 165 ]

    image create photo LOGO_VASY -format GIF -file $env(CADP_CONTRIBUTOR)/vasy.gif

    set IMG_LOGO_VASY [$CANVAS_LOGO create image 1 3 \
			   -image LOGO_VASY \
			   -anchor nw ]

    set COPYRIGHT [label [Left_Main_Frame].copyright \
		       -text "(C) 2016 INRIA VASY+CONVECS" \
		       -font [Small_Font] ]
}

proc display_left_logo {} {
    global CANVAS_LOGO
    global COPYRIGHT
    pack $CANVAS_LOGO $COPYRIGHT -side top -fill both -padx 40
}

proc Make_Window {} {
    global env

    centrage 850 600 .

    wm title . "CADP Contributor"
    wm iconbitmap . @$env(CADP_CONTRIBUTOR)/icon_contributor.xbm 

    wm protocol . WM_DELETE_WINDOW Ask_Quit

    frame .invisible
    pack .invisible -fill both -expand true

    set FRAME_TOP [frame .invisible.f_top]
    set TITLEPAGE [label $FRAME_TOP.title -text "" -font [Large_Font] ]

    set FRAME_MIDDLE [frame .invisible.f_middle -height 20]

    set FRAME_LEFT [frame $FRAME_MIDDLE.frame_left]

    set LEFT_MAIN_FRAME  [frame $FRAME_LEFT.main_frame ]

    set FRAME_MAIN_FRAME [frame $FRAME_MIDDLE.f]

    Make_left_logo

    pack $FRAME_TOP -side top -fill x
    pack $TITLEPAGE -side left -padx 20
    pack $FRAME_LEFT -side left -padx 5
    pack $FRAME_MAIN_FRAME  -side left -padx 5 -expand true -fill both
    pack propagate $FRAME_MAIN_FRAME 0
    pack $FRAME_MIDDLE -fill both -side top -expand true
    pack $LEFT_MAIN_FRAME -side left -padx 5 -fill both -expand true
}

proc Titlepage {TITLE} {
    .invisible.f_top.title configure -text $TITLE
}

proc Make_Bar_Buttons {TYPE_SCREEN} {
    global BRANCH

    catch {destroy .invisible.frame_bottom}

    set FRAME_BOTTOM [frame .invisible.frame_bottom]

    set FRAME_LEFT [frame $FRAME_BOTTOM.frame_left]

    button $FRAME_BOTTOM.exit \
	-text "Cancel" \
	-command {
	    set CANCEL_INSTALL 1
	    Ask_Quit
	} \
	-font  [Small_Font]
    pack $FRAME_BOTTOM.exit -side right -padx 10 -pady 10

    set FRAME_BUTTONS [frame $FRAME_BOTTOM.buttons]
    button $FRAME_BUTTONS.next \
	-text " Next " \
	-command {
	    set BRANCH(BACK) 0
	    $BRANCH(NEXT) 
	}\
	-font  [Small_Font]

    button $FRAME_BUTTONS.previous \
	-text " Previous " \
	-command {
	    set BRANCH(BACK) 1
	    $BRANCH(PREVIOUS)
	    [Pop]
	}\
	-font  [Small_Font]

    Disable_Previous 
    Disable_Next 

    pack $FRAME_LEFT -side left -expand yes -fill both
    pack $FRAME_BUTTONS.next $FRAME_BUTTONS.previous \
	-side right 
    pack $FRAME_BUTTONS -side right -padx 20

    pack $FRAME_BOTTOM -side bottom
    pack $FRAME_BOTTOM  -side bottom  -fill x -pady 5 -padx 10
}

proc Frame_Buttons {} {return {.invisible.frame_bottom.buttons}}
proc Main_Frame {} {return {.invisible.f_middle.f.main_frame}}
proc Left_Main_Frame {} {return {.invisible.f_middle.frame_left.main_frame}}
proc Frame_BottomLeft {} {return {.invisible.frame_bottom.frame_left}}

proc Init_Frame_BottomLeft {} {
    catch {destroy [Frame_BottomLeft]}
    frame [Frame_BottomLeft]
    pack [Frame_BottomLeft] -side left -expand yes -fill both
}

proc Init_Buttons {TYPE_SCREEN NEXT_PROC PREV_PROC} {

    global BRANCH

    if  ![string match $BRANCH(PREVIOUS) ""] \
	then {
	    Push $BRANCH(PREVIOUS)
	}

    set BRANCH(NEXT) $NEXT_PROC
    set BRANCH(PREVIOUS) $PREV_PROC
    Make_Bar_Buttons $TYPE_SCREEN
}

global X2 
set X2 1

proc Barre_Init {} {
    global COORD_BAR
    global BAR
    global Ftpbar_Color

    catch { destroy [Main_Frame].frame_bar}

    set FRAME_BARRE [frame [Main_Frame].frame_bar ]
    set FRAME_LEFT  [frame $FRAME_BARRE.frame_left ]

    set COORD_BAR(X1) 10
    set COORD_BAR(Y1) 10
    set COORD_BAR(X2) 350
    set COORD_BAR(Y2) 30
    set CANVAS_BAR [canvas $FRAME_LEFT.canvas_bar \
			-width $COORD_BAR(X2) \
			-height $COORD_BAR(Y2) ]

    $CANVAS_BAR create rect \
	$COORD_BAR(X1) $COORD_BAR(Y1) \
	$COORD_BAR(X2) $COORD_BAR(Y2)

    set BAR [$CANVAS_BAR create rect \
		 $COORD_BAR(X1) $COORD_BAR(Y1) \
		 $COORD_BAR(X1) $COORD_BAR(Y1) \
		 -fill $Ftpbar_Color]

    set MESSAGE_INFORMATION [label $FRAME_LEFT.label\
				 -text "0%"\
				 -font [Small_Font]\
				 -justify center]
    pack $FRAME_BARRE -side top -fill x
    pack $FRAME_LEFT  -side left
    pack $CANVAS_BAR $MESSAGE_INFORMATION -side top

}

proc Barre {TAILLE TAILLE_MAX} {
    global BAR
    global COORD_BAR

    if { $TAILLE_MAX != 0 } {
	set RATIO [expr (double ($TAILLE) / double ($TAILLE_MAX))]
    } else {
	set RATIO 1
    }

    set X2 [ expr $COORD_BAR(X1) + round (($COORD_BAR(X2) - $COORD_BAR(X1)) * $RATIO) ]

    catch {
	[Main_Frame].frame_bar.frame_left.canvas_bar coord $BAR \
		 $COORD_BAR(X1)  $COORD_BAR(Y1) \
		 $X2             $COORD_BAR(Y2)
    }
    set UNITE "MB"
    set TAILLE_EN_UNITE [format "%.1f" [expr double($TAILLE_MAX) / (double (1024) * double (1024))]]
    if { $TAILLE_EN_UNITE < 1 } {
	set TAILLE_EN_UNITE [format "%.1f" [expr double($TAILLE_MAX) / double (1024)]]
	set UNITE "KB"
    }
    set PER_CENT [expr round ($RATIO * double (100))]
    [Main_Frame].frame_bar.frame_left.label configure -text "${PER_CENT}% of ${TAILLE_EN_UNITE} $UNITE"
}

proc see_list_of_files {} {
    global GL
    global Tree_files

    if [catch {set FILE_WINDOW [toplevel .list_of_files]} err] then {
	return
    }

    set GL(FILES_TO_SEND) {}
    list_select_files $Tree_files.tree [$Tree_files.tree nodes "root"] GL(FILES_TO_SEND)

    wm title .list_of_files "Contributor: List of files"

    wm minsize .list_of_files 700 500

    Make_Label .list_of_files.msg top "Here is the exhaustive list\nof the files to send:"

    tixScrolledListBox .list_of_files.listbox 
    set GL(FILES_TO_SEND) [lsort $GL(FILES_TO_SEND)]
    .list_of_files.listbox.listbox delete 0 end
    foreach item $GL(FILES_TO_SEND) {
	.list_of_files.listbox.listbox insert end $item
    }
    pack .list_of_files.listbox -side top -pady 10 -expand yes -fill both

    set FRAME_B [frame .list_of_files.frame_bottom]
    pack $FRAME_B -side bottom

    set SAVE [button $FRAME_B.save \
		  -text "Save list of files" \
		  -command {
		      save_list_files_to_send 
		  }\
		  -font  [Small_Font] ]

    set PRINT [button $FRAME_B.print \
		   -text "Print list of files"\
		   -command {
		       print_list_files_to_send 
		  }\
		  -font  [Small_Font] ]

    set CLOSE [button $FRAME_B.close \
		   -text "Close" \
		   -command {catch {destroy .list_of_files}} \
		   -font [Small_Font]]

    pack $CLOSE $SAVE $PRINT -side right -padx 10 -pady 5
}

proc Update_Search_Label {STEP COUNT TEXT} {

    if {($COUNT % 20) == 0} then {
        [Main_Frame].$STEP.label configure -text "$TEXT"

        set wait_for_evenement 1
        after 1 {set wait_for_evenement 0}
        vwait wait_for_evenement
    }
}

set PREFERENCES_DIR [file join $env(HOME) .config cadp contributor]

set COMPRESSED_LINE "COMPRESSED"

proc get_preference_path {filename} {
    global PREFERENCES_DIR
    return [file join $PREFERENCES_DIR $filename]
}

proc init_preferences {} {
    global PREFERENCES_DIR
    if { ![file isdirectory $PREFERENCES_DIR] } {
	file mkdir $PREFERENCES_DIR
    }
}

proc load_authorized_classes {} {
    global GL
    global COMPRESSED_LINE
    set GL(AUTH_CLASSES) {}
    set GL(CONSIDER_COMPRESSED) 0

    if { [ catch {open [get_preference_path authorized_classes] r} fileId ] } {

	set GL(CONSIDER_COMPRESSED) 1
	foreach CLASS $GL(CLASSES) {
	    lappend GL(AUTH_CLASSES) [lindex $CLASS 0]
	}
	return
    }

    foreach line [split [read $fileId] \n ] {
	if { [exists_class $line] != 0 && [lsearch $GL(AUTH_CLASSES) $line] == -1} {

	    lappend GL(AUTH_CLASSES) $line
	} elseif {$line == $COMPRESSED_LINE} {
	    set GL(CONSIDER_COMPRESSED) 1
	}
    }
    close $fileId
}

proc load_authorized_paths {} {
    global GL

    if { [ catch {open [get_preference_path authorized_paths] r} fileId ] } {
	return
    }

    foreach line [split [read $fileId] \n ] {
	if {$line == {}} {
	    continue
	}
	if {[file isdirectory $line]} {
	    if {[lsearch $GL(AUTH_DIR) $line] == -1} {
		lappend GL(AUTH_DIR) $line
	    }
	} else {
	    if {[lsearch $GL(LOST_AUTH_DIR) $line] == -1} {
		lappend GL(LOST_AUTH_DIR) $line
	    }
	}
    }
    close $fileId
}

proc load_files_already_sent {} {
    global GL
    global CADP_SUM

    set GL(FILES_ALREADY_SENT) {}
    set GL(MD5S_ALREADY_SENT) {}
    set GL(NAME_ALREADY_SENT) {}
    set GL(TAIL_ALREADY_SENT) {}
    set GL(LOST_ALREADY_SENT) {}

    if { [ catch {open [get_preference_path already_sent] r} fileId ] } {
	exec echo "" >  [get_preference_path already_sent]
	return
    }

    set old_cksums {}

    foreach line [split [read $fileId] \n] {
	if {$line == {}} then {

	    continue
	}

	set pos [string first " " $line]
	set name [string range $line [expr $pos + 1] end]

	if {[file isfile "$name"] && [file readable "$name"]} {
	    lappend old_cksums [lindex $line 0]
	} else {

	    lappend GL(LOST_ALREADY_SENT) "$line"
	}
    }
    close $fileId

    set cksum_pipe [open "| sh -c \"cat \\\"[get_preference_path already_sent]\\\" | cut -b 34- | $CADP_SUM 2> /dev/null\""]
    fconfigure $cksum_pipe -buffering none

    set index 0
    while {[gets $cksum_pipe line] >= 0} {
	set pos [string first " " $line]
	set name [string range $line [expr $pos + 1] end]
	set cksum [lindex $line 0]

	if {[string equal "$cksum" "[lindex $old_cksums $index]"] && [lsearch $GL(FILES_ALREADY_SENT) [list $cksum $name]] == -1} {

	    lappend GL(FILES_ALREADY_SENT) [list "$cksum" "$name" ]
	    lappend GL(MD5S_ALREADY_SENT) "$cksum"
	    lappend GL(NAME_ALREADY_SENT) "$name"
	    lappend GL(TAIL_ALREADY_SENT) [file tail "$name"]
	}
	incr index

	update
    }

    catch {close $cksum_pipe}
}

proc load_forbidden_files {} {
    global GL

    set GL(FORBIDDEN_FILES) {}

    if { [ catch {open [get_preference_path forbidden_files] r} fileId ] } {
	exec echo "" >  [get_preference_path forbidden_files]
	return
    }

    foreach line [split [read $fileId] \n ] {
	if { [lsearch $GL(FORBIDDEN_FILES) $line] == -1 && $line != {} && ![is_already_sent $line] } {
	    lappend GL(FORBIDDEN_FILES) "$line"
	}
    }
    close $fileId
}

proc save_authorized_classes {} {

    global GL
    global COMPRESSED_LINE

    if { [ catch {open [get_preference_path authorized_classes] w} fileId ] } {
	error "File [get_preference_path authorized_classes] hasn't been opened"
    }
    foreach type $GL(AUTH_CLASSES) {
	puts $fileId $type
    }
    if {$GL(CONSIDER_COMPRESSED) != 0} {
	puts $fileId $COMPRESSED_LINE
    }
    close $fileId
}

proc save_authorized_paths {} {
    global GL
    if { [ catch {open [get_preference_path authorized_paths] w} fileId ] } {
	error "File [get_preference_path authorized_paths] hasn't been opened"
    }
    foreach dir $GL(LOST_AUTH_DIR) {
	puts $fileId $dir
    }
    foreach dir $GL(AUTH_DIR) {
	puts $fileId $dir
    }
    close $fileId
}

proc save_forbidden_files {} {

    global GL
    global GL_FILES

    if { $GL(REMEMBER_FILES) == 0 } {
	return
    }

    if { [ catch {open [get_preference_path forbidden_files] w} fileId ] } {
	error "File [get_preference_path forbidden_files] hasn't been opened"
    }

    foreach file $GL(FORBIDDEN_FILES) {
	puts $fileId "$file"
    }

    foreach file [array names GL_FILES] {
	if {[lsearch $GL(FORBIDDEN_FILES) $file] == -1 && [lsearch $GL(RULES_FORBIDDEN_FILES) $file] == -1 && [lsearch $GL(NAME_ALREADY_SENT) $file] == -1 && [lsearch $GL(FILES_TO_SEND) $file] == -1} {
	    puts $fileId "$file"
	}
    }
    close $fileId
}

proc save_files_sent {} {

    global GL
    global CADP_SUM

    if { [ catch {open [get_preference_path already_sent] w} fileId ] } {
	error "File [get_preference_path already_sent] hasn't been opened"
    }

    foreach elt $GL(LOST_ALREADY_SENT) {
	puts $fileId "$elt"
    }

    update

    foreach elt $GL(FILES_ALREADY_SENT) {
	puts $fileId "[lindex $elt 0] [lindex $elt 1]"
    }
    close $fileId

    update

    if {[info exists GL(TRANSFERT_COMPLETE)] && $GL(TRANSFERT_COMPLETE)} {

	set fileId [open [get_preference_path last_sent] "w"]

	foreach file $GL(FILES_TO_SEND) {
	    puts $fileId "$file"  
	}

	close $fileId

        update

	exec sh -c "cat \"[get_preference_path last_sent]\" | $CADP_SUM >> \"[get_preference_path already_sent]\""

	update
    }
}

proc is_already_sent {file {cksum ""}} {

    global GL
    global CADP_SUM

    if {[lsearch $GL(NAME_ALREADY_SENT) "$file"] != -1} {

	return 1
    }

    set name [file tail "$file"]
    set N [lsearch -all $GL(TAIL_ALREADY_SENT) "$name"]

    if { $N == "" } {
	return 0
    }

    if {$cksum == ""} {
	set md5s [lindex [exec sh -c "$CADP_SUM \"$file\""] 0]
    } else {
	set md5s $cksum
    }
    foreach i $N {
	if { [ string compare [lindex $GL(MD5S_ALREADY_SENT) $i ] $md5s ] == 0  } {

	    if { [lsearch $GL(NAME_ALREADY_SENT) "$file"] == -1 } {
		lappend GL(FILES_ALREADY_SENT) [list "$md5s" "$file"]
		lappend GL(MD5S_ALREADY_SENT) "$md5s"
		lappend GL(NAME_ALREADY_SENT) "$file"
		lappend GL(TAIL_ALREADY_SENT) "$name"
	       
		set j [lsearch $GL(FORBIDDEN_FILES) "$file"]
		if { $j != -1 } {
		    set GL(FORBIDDEN_FILES) [lreplace $GL(FORBIDDEN_FILES) $j $j]
		} else {
		    set k [lsearch $GL(RULES_FORBIDDEN_FILES) "$file"]
		    if { $k != -1 } {
			set GL(RULES_FORBIDDEN_FILES) [lreplace $GL(RULES_FORBIDDEN_FILES) $k $k]
		    }
		}
	    }
	    
	    return 1
	}
    }

    return 0

}

proc read_user_info {INFO} {

    global env 

    set USER_FILE [get_preference_path user]

    if { [file exists $USER_FILE] } {
	set LICENSE_FILE $USER_FILE
    } elseif { [file exists [file join $env(CADP) LICENSE]] } {
	set LICENSE_FILE [file join $env(CADP) LICENSE]
    } else {
	exec echo "" > $USER_FILE
	set LICENSE_FILE $USER_FILE
    }

    switch $INFO {
	NAME {
	    set NAME ""
	    catch {set NAME [exec sh -c "$env(CADP)/com/rfl -n $LICENSE_FILE"] }
	    return $NAME
	}
	ADDRESS {
	    set ADDRESS ""
	    catch {set ADDRESS [exec sh -c "$env(CADP)/com/rfl -a $LICENSE_FILE"] }
	    return $ADDRESS
	}
	
	EMAIL {
	    set EMAIL ""
	    catch {set EMAIL [exec sh -c "$env(CADP)/com/rfl -e $LICENSE_FILE"] }
	    return $EMAIL
	}
    }
}

set CADP_regexp [file join $env(CADP) *]

proc verify_rules_conditions {file} {
    global TYPE_CONDITION
    global GL

    if [string match "$::CADP_regexp" "$file"] {
	return 0
    }

    if {[lsearch $GL(COMPRESSED_FORMAT) [file extension $file] ] != -1} {
	set archive_ext [file extension $file]
	set ext [file extension [string range $file 0 end-[string length $archive_ext]] ]
    } else {
	set ext [file extension $file]
    }

    if $TYPE_CONDITION($ext) {
	return 1
    } else {
	return 0
    }
}

proc sort_lists_files {} {

    global GL

    set LIST_TMP {}

    foreach file $GL(FORBIDDEN_FILES) {
	if { [lsearch $GL(NAME_ALREADY_SENT) $file] == -1 && [lsearch $GL(RULES_FORBIDDEN_FILES) $file] == -1 } {
	    lappend LIST_TMP $file
	}
    }
    set GL(FORBIDDEN_FILES) $LIST_TMP

    set LIST_TMP {}

    foreach file $GL(RULES_FORBIDDEN_FILES) {
	if { [lsearch $GL(NAME_ALREADY_SENT) $file] == -1 } {
	    lappend LIST_TMP $file
	}
    }

    set GL(RULES_FORBIDDEN_FILES) $LIST_TMP
}

proc Texte {TITLE} {
    global PREFERENCES_DIR
    global NEW_TAR
    global GL

    switch $TITLE {

	Start {
	    return {\n\n\n\n\n\n\n\n\n\nWelcome to the CADP Contributor.\n\nYou can use this application to send files to the CADP development team. These files will be added to our regression test suite, and used to improve quality and stability of future versions of CADP.\nUse of Contributor is optional but appreciated. }
	}

	Start_next {
	    return [subst {\n\n\nConfidentiality:\n\nThe files you send will be kept confidential and used only by the CADP team. You have full control of the files that you send. You choose when to run Contributor, and you choose which directories to search and which files to select. Contributor only makes a network connection when you send files.\n\nTo submit your files, this assistant will propose the following steps:\n\
			1. Specify the directories that contain files to be sent.\n\
			2. Specify the file types of the files to be sent.\n\
			3. Contributor's selection rules are automatically applied to select the relevant files in the directories you have specified.\n\
			4. Review the list of files selected, and add or exclude files.\n\
			5. Send the files to the CADP team.\n\nContributor will record in $PREFERENCES_DIR the files you send and the files you exclude. This information is used next time you run Contributor to avoid selecting those files you have already sent or previously excluded.}]
	    }

	Choix_types_fichier {
	    return {\n\nPlease check the file types you want to search.\n\Contributor will only search for files of the types you specify.\n}
	}

	aucun_type {
	    return {\nYou must select at least one file format. \n}
	}

	inclure_archives {
	    return {Include compressed versions of selected files}
	}

	Choix_repertoires {
	    return {\n\nPlease select the directories\nwhere the files are located\nby clicking in the boxes.\nContributor will only explore\nthe selected directories.\n\n\
			Shift+Click:\ncheck all between 2 lines \n\n\n\
			Control+Shift+Click:\nuncheck all between 2 lines\n }
	}

	aucun_repertoire {
	    return {\nYou must select at least one directory.\n}
	}

	choix_fichiers {
	    return {Review the selection of files.}
	}

	fichiers_caches {
	    return {The following files will not\nbe included unless\nyou select them manually.\n}
	}

	selection_fichiers {
	    return {\nDouble click on a file to view\nits contents.\nYou can add files to the selection\nand exclude files by checking or\nunchecking the boxes.\n\n\
			Shift+Click:\ncheck all between 2 lines \n\
			Control+Shift+Click:\nuncheck all between 2 lines\n}
	}

	list_files {
	    return {\n\n\nIt is useful for us to know who is contributing to our regression test suite, and we would like the opportunity to thank you for your contribution.}
	}

	info_recherche {
	    return {\n\n\n\n\nPlease wait while Contributor searches the specified directories to select files. This can take a few minutes and cannot be interrupted.\n}
	}

	recherche_finie {
	    return {\n\nThe search is complete. Click Next to review the result. } 
	}

	recherche_vide {
	    return {\n\nNo relevant files found. Please retry with other search criteria.}
	}

	accept_upload {
	    return {\n\nClick Next to create an archive containing all these files and to begin the transfer.\n}
	}

	nothing_to_send {
	    return {\n\nThere are no files to send.}
	}
	   
	archive {
	    return {Creating the archive .tar.gz ...}
	}

	archivage_echoue {
	    return [subst {Error: Unable to create the archive\n$NEW_TAR.\nSee $PREFERENCES_DIR/tar.log\nfor more details about the problem}]
	}

	ouverture_connexion {
	    return [subst {Opening FTP connexion to $GL(SERVER)...}]
	}

        connexion_echouee {
	    return [subst {\nUnable to connect to $GL(SERVER).\nSee $PREFERENCES_DIR/ftp.log\nfor more details about the problem}]
	}	
	transfert {
	    return {Sending archive...}
	}

	sauvegarde_listes {
	    return {Saving the list of files already sent...}
	}

	transfert_complete {
	    return {\n\nAll the files were successfully uploaded.\n\
		    Thank you for your support of our continuing efforts to improve the quality and the stability of CADP.\n\n\n\n}
	}
    }
} 

proc Get_Search_Text {TITLE} {
    switch $TITLE {
	begin_find {
	    return "Searching the files in the selected directories..."
	}

	load_files {
	    return "Loading lists of files already sent and excluded..."
	}

	remaining_files {
	    return "Checking list of files already sent and excluded..."
	}

	sorting_files {
	    return "Analyzing the files with the selection rules..."
	}

	unjoin_files {
	    return "Detecting duplicated files..."
	}
    }
}

proc insert_dir { tree dirname} {
    set parent [file dirname $dirname]

    if { $parent != $dirname } {
	insert_dir $tree $parent
	if { ![$tree exists $dirname] } {
	    $tree insert end $parent $dirname -text [file tail $dirname] \
		-data [list "$dirname" 0] -open 1 -image $::CK_IMAGE_OFF
	}
    } else {
	if { ![$tree exists $dirname] } {

	    set name [file tail $dirname]
	    if {$name == ""} {
		set name $dirname
	    }
	    $tree insert end root $dirname -text $name \
		-data [list "$dirname" 0] -open 1 -image $::CK_IMAGE_OFF

	    getdir $tree $dirname $dirname
	}
    }
}

proc open_tree_correctly_rec {tree nodes} {

    foreach node $nodes {
	set ck_node [$tree itemcget $node -image]
	
	if { $ck_node == $::CK_IMAGE_DEF } {
	    $tree toggle $node
	    open_tree_correctly_rec $tree [$tree nodes $node]
	}
    }
}

proc open_tree_correctly {tree} {

    global GL
    set racines [$tree nodes root]

    foreach racine $racines {
	$tree closetree $racine
    }

    open_tree_correctly_rec $tree $racines
}

proc init { tree } {

    global tcl_platform
    global GL
    global env

    if { $tcl_platform(platform) == "unix" } {
        set list_rootdir [list [file normalize [glob "~"] ] ]
    } else {
	set home [file normalize [glob "~"] ]
        set list_rootdir [list "C:/" "$home"  ]
    }

    if {$GL(AUTH_DIR) == ""} {
	set GL(AUTH_DIR) [file normalize [glob "~"] ]
    }

    foreach rootdir [concat $GL(AUTH_DIR) $list_rootdir] {

	set chemin [ file split $rootdir ]
	set dir ""

	insert_dir $tree [file dirname $rootdir]

	set name [file tail $rootdir]
	if { $name == "" } { 
	    set name $rootdir
	}

	if { ![$tree exists $rootdir] } {

	    $tree insert end [file dirname $rootdir] $rootdir -text $name -data [list "$rootdir" 0] -open 1 \
		-image $::CK_IMAGE_OFF

	    getdir $tree $rootdir $rootdir

	    if {[lsearch $GL(AUTH_DIR) $rootdir] != -1 } {
		check_node $tree 2 $rootdir

		set parent [$tree parent $rootdir]
		if {[lsearch $list_rootdir $parent] == -1} {
		    getdir $tree $parent $parent
		}
	    }
	} elseif {[lsearch $list_rootdir $rootdir] != -1} {

	    getdir $tree $rootdir $rootdir
	    check_node $tree 2 $rootdir
	} else {
	    check_node $tree 2 $rootdir
	}
    }
    open_tree_correctly $tree
}

proc init_files { tree } {
    global GL
    global GL_FILES
    global GL_SELECTED_FILES
    global COLOR

    set TAILLE_TOTALE [array size GL_FILES]
    set TAILLE 0

    foreach fichier [lsort -dictionary [array names GL_FILES]] {
	set chemin [ file split $fichier ]
	set dir ""
	set prec root

	if {![$tree exists [file dirname $fichier]]} {
	    for {set i 0} {$i < [expr [llength $chemin] -1]} {incr i} {
		if { [lindex $chemin $i] != [file separator] } {
		    set name [file separator][lindex $chemin $i]
		} else {
		    set name [lindex $chemin $i]
		}
		set dir "[file join ${dir} [lindex $chemin $i] ]"
		if {![$tree exists "$dir"]} {
		    $tree insert end "$prec" "$dir" -text "$name" -data [list "$dir" 1] -open 1 -image $::CK_IMAGE_OFF
		}
		set prec "$dir"
	    }
	}

	if {![$tree exists "$fichier"] && [info exists GL_SELECTED_FILES($fichier)]} {
	    $tree insert end [file dirname $fichier] "$fichier" -text [file tail $fichier] -data [list "$fichier" 1] -open 1 \
		-image $::CK_IMAGE_ON
	    
	    reload_check_parent $tree $fichier
	}
    }
}

proc getdir_tmp { tree node path } {

    global GL

    set lentries [glob -nocomplain [file join $path "*"]]
    foreach f $lentries {
        set tail "[file tail $f]"
        if { [file isdirectory $f] } {
	    if { ![$tree exists $f]  } {

		if {[lsearch $GL(AUTH_DIR) $f] != -1} {
		    set image $::CK_IMAGE_ON
		} else {
		    set image $::CK_IMAGE_OFF
		}
		set parent [ $tree parent $node ]
		if { [string compare $parent "root"] != 0 && [$tree itemcget $parent -image ] == $::CK_IMAGE_ON }  {
		    set image $::CK_IMAGE_ON
		}
		
		$tree insert end $node $f \
		    -text      $tail \
		    -image     $image \
		    -drawcross allways \
		    -data      [list "$f" 0]
	    }
	    
	}
    }

    $tree reorder $node [lsort -dictionary [$tree nodes $node] ]
    $tree itemconfigure $node -drawcross auto 
}

proc getdir { tree node path } {

    global GL

    set lentries [glob -nocomplain [file join $path "*"]]
    foreach f $lentries {
        set tail "[file tail $f]"
        if { [file isdirectory $f] } {
	    if { ![$tree exists $f]  } {
		
		if {[lsearch $GL(AUTH_DIR) $f] != -1} {
		    set image $::CK_IMAGE_ON
		} else {
		    set image $::CK_IMAGE_OFF
		}

		set parent [ $tree parent $node ]
		if { [string compare $parent "root"] != 0 && [$tree itemcget $parent -image ] == $::CK_IMAGE_ON }  {
		    set image $::CK_IMAGE_ON
		}
		
		$tree insert end $node $f \
		    -text      $tail \
		    -image     $image \
		    -drawcross allways \
		    -data      [list "$f" 0]
		
	    }
	    reload_check_parent $tree $f
	    getdir_tmp $tree $f $f 
	    
	}
    }
    $tree reorder $node [lsort -dictionary [$tree nodes $node] ]
    $tree itemconfigure $node -drawcross auto -data "[lindex [$tree itemcget $node -data] 0] 1"
}

proc moddir { tree node } {
    if {  [lindex [$tree itemcget $node -data] 1] == 0 } {
        getdir $tree $node [lindex [$tree itemcget $node -data] 0]
    }
}

proc check_node { tree rec_mode node } {
    global COLOR

    if {[$tree itemcget $node -fill] == $COLOR(FILES_ALREADY_SENT)} {
	return
    }

    if { $rec_mode == 0 } {
	
	if {[$tree itemcget $node -image] == $::CK_IMAGE_ON} {
	    $tree itemconfigure $node -image $::CK_IMAGE_OFF
	    
	} else {
	    $tree itemconfigure $node -image $::CK_IMAGE_ON
	    
	}

	foreach child [$tree nodes $node] {
	    check_node $tree 1 $child
	}
	
	reload_check_parent $tree $node

    } elseif { $rec_mode == 1} {

	$tree itemconfigure $node -image [$tree itemcget [$tree parent $node] -image]
	    
	    foreach child [$tree nodes $node] {
		check_node $tree 1 $child
	    }
    } elseif { $rec_mode == 2 || $rec_mode == 3} {
	
	$tree itemconfigure $node -image $::CK_IMAGE_ON
	foreach child [$tree nodes $node] {
	    check_node $tree 3 $child
	}
	if { $rec_mode == 2} {
	    reload_check_parent $tree $node
	}
    } else {

	$tree itemconfigure $node -image $::CK_IMAGE_OFF
	foreach child [$tree nodes $node] {
	    check_node $tree 5 $child
	}
	if { $rec_mode == 4} {
	    reload_check_parent $tree $node
	}
    }
}

proc def_parent { tree node image} {

    set parent [$tree parent "$node"]
    $tree itemconfigure "$node" -image $image

    if {  [lsearch [$tree nodes root] $node] == -1 } {
	def_parent "$tree" "$parent" "$image"
    }

}

proc reload_check_parent { tree node } {

    global GL

    if { [lsearch [$tree nodes root] $node] != -1 } {
	return 0
    }

    set val [$tree itemcget $node -image]

    set parent [$tree parent $node]
    set val_parent [$tree itemcget $parent -image]
    set unknown_child [lindex [$tree itemcget $parent -data] 1]

    if {$unknown_child == 0 && $val == $::CK_IMAGE_ON} {
	def_parent $tree $parent $::CK_IMAGE_DEF
	return 0
    }

    if {$val == $val_parent} {
	return 0
    }

    set nb_on 0
    set nb_off 0

    foreach child [$tree nodes $parent] {
	if {[$tree itemcget $child -image] == $::CK_IMAGE_ON } {
	    incr nb_on
	} else {
	    
	    if {[$tree itemcget $child -image] == $::CK_IMAGE_OFF } {

		if { ![is_already_sent $child] } {
		    incr nb_off
		}
	    } else {
		incr nb_on
		incr nb_off
	    }
	}
    }

    if {$nb_on == 0} {
	$tree itemconfigure $parent -image $::CK_IMAGE_OFF
    } else {
	if {$nb_off == 0} {
	    $tree itemconfigure $parent -image $::CK_IMAGE_ON
	} else {
	    $tree itemconfigure $parent -image $::CK_IMAGE_DEF
	}
    }

    if {$val_parent != [$tree itemcget $parent -image]} {
	reload_check_parent $tree $parent
    }

}

proc list_select_node {tree node list} {

    upvar $list liste

    if {[$tree itemcget "$node" -image] == $::CK_IMAGE_ON } {
	lappend liste "$node"
    }
    if {[$tree itemcget "$node" -image] == $::CK_IMAGE_DEF } {
	foreach child [$tree nodes "$node"] {
	    list_select_node "$tree" "$child" liste
	}
    }
}

proc list_select_files {tree node list} {

    upvar $list liste

    if {[$tree itemcget "$node" -image] == $::CK_IMAGE_ON && [file exists "$node"] && [file isfile "$node"]} {
	lappend liste "$node"
    } else {
	if {[$tree itemcget "$node" -image] == $::CK_IMAGE_DEF || [$tree itemcget "$node" -image] == $::CK_IMAGE_ON } {
	    foreach child [$tree nodes "$node"] {
		list_select_files $tree "$child" liste
	    }
	}
    }
}

proc hide_files {tree TYPE} {

    global GL
    global GL_FILES
    global COLOR

    if { [string compare $TYPE "FILES_ALREADY_SENT" ] == 0 } {
	set HIDE_LIST $GL(NAME_ALREADY_SENT)
    } else {
	set HIDE_LIST [subst \$GL($TYPE)]
    }

    if { [llength $HIDE_LIST] > 200 } {
	Wait_Window "Please Wait. This can take a moment..."
    }

    if { ![subst \$GL(SHOW_$TYPE)] } {
	foreach file $HIDE_LIST {
	    if {[info exists GL_FILES($file)]} {
		$tree delete \"$file\"
	    }
	}
    } else {
	set dir_to_sort {}
	foreach file $HIDE_LIST {
	    if {[info exists GL_FILES($file)]} {
		set dirname [file dirname $file]
		$tree insert end "$dirname" "$file" \
		    -text [file tail $file]\
		    -image $::CK_IMAGE_OFF\
		    -fill [subst \$COLOR($TYPE)]

		if {[lsearch $dir_to_sort $dirname] == -1} {
		    lappend dir_to_sort $dirname
		}
	    }
	}

	foreach dir $dir_to_sort {
	    $tree reorder $dir [lsort -dictionary [$tree nodes $dir]]
	    $tree opentree $dir
	}
    }
    destroy_Wait_Window
}

proc check_all_nodes {tree bool node} {

    set first_node [lindex [$tree selection get] 0]

    if {$first_node == ""} {
	$tree selection add $node
	return
    }

    $tree selection range $first_node $node

    if {$bool == 1} {
	foreach node [$tree selection get] {
	    check_node $tree 2 $node
	}
    } else {
	foreach node [$tree selection get] {
	    check_node $tree 4 $node
	}
    }
}

proc hide_unchecked_dir {tree node} {

    if {[$tree itemcget "$node" -image ] == $::CK_IMAGE_OFF} {
	$tree closetree $node
    } elseif {[$tree itemcget "$node" -image ] == $::CK_IMAGE_DEF} {
	foreach child [$tree nodes $node] {
	    hide_unchecked_dir $tree $child
	}
    }
}

proc create_tree_dir {tree width height} {

    Wait_Window "Please Wait..."

    frame $tree

    scrollbar $tree.yscrollbar -orient vertical
    scrollbar $tree.xscrollbar -orient horizontal

    Tree $tree.tree \
	-width $width\
	-height $height\
	-dropenabled 1 \
	-dragenabled 1 \
	-dragevent 3 \
	-deltax 17 \
	-linesfill #000000 \
	-opencmd   "moddir $tree.tree" \
	-closecmd  "moddir $tree.tree" \
	-yscrollcommand "$tree.yscrollbar set"\
	-xscrollcommand "$tree.xscrollbar set"

    $tree.tree bindImage <ButtonPress-1> "check_node $tree.tree 0"
    $tree.tree bindText <Shift-ButtonPress-1> "check_all_nodes  $tree.tree 1"
    $tree.tree bindText <Control-Shift-ButtonPress-1> "check_all_nodes  $tree.tree 0"

    init $tree.tree
    $tree.yscrollbar configure -command "$tree.tree yview"
    $tree.xscrollbar configure -command "$tree.tree xview"
    destroy_Wait_Window
    return $tree
}

proc create_tree_files {tree width height} {

    frame $tree

    scrollbar $tree.yscrollbar -orient vertical
    scrollbar $tree.xscrollbar -orient horizontal

    Tree $tree.tree                            \
	-width $width                          \
	-height $height                        \
	-dropenabled 1                         \
	-dragenabled 1                         \
	-dragevent 3                           \
	-deltax 17                             \
	-linesfill #000000                     \
	-yscrollcommand "$tree.yscrollbar set" \
	-xscrollcommand "$tree.xscrollbar set"

    $tree.tree bindImage <ButtonPress-1> "check_node $tree.tree 0"

    $tree.tree bindText <Shift-ButtonPress-1> "check_all_nodes $tree.tree 1"
    $tree.tree bindText <Control-Shift-ButtonPress-1> "check_all_nodes $tree.tree 0"

    $tree.tree bindText <Double-ButtonPress-1> "edit_file"

    init_files $tree.tree

    $tree.yscrollbar configure -command "$tree.tree yview"
    $tree.xscrollbar configure -command "$tree.tree xview"

    if {[$tree.tree nodes "root"] != "" } {
	hide_unchecked_dir $tree.tree [$tree.tree nodes "root"]
    }
    return $tree
}

proc display_tree {tree} {
    pack $tree -fill both -expand yes
    grid $tree.tree $tree.yscrollbar -sticky nsew
    grid $tree.xscrollbar -sticky nsew
}

package require Tix
package require Tk

lappend auto_path $env(CADP)/tcl-tk/lib-bwidget
package require BWidget

source $env(CADP_CONTRIBUTOR)/rules.tcl

set MAN_PAGE "http://cadp.inria.fr/man/contributor.html"

set TAIL $env(CADP)/src/com/cadp_tail
set PRINT $env(CADP)/src/com/cadp_print
set EDIT $env(CADP)/src/com/cadp_edit
set WEB $env(CADP)/src/com/cadp_web
set CADP_SUM $env(CADP)/src/com/cadp_sum
set CADP_ZIP $env(CADP)/src/com/cadp_zip

set CD "cd"

proc Trace {} {
    return [get_preference_path ftp.log]
}

set GL(SERVER) "ftp.inrialpes.fr"
set GL(USER)   "anonymous" 
set GL(PASSWD) "contributor@"

set GL(FTP_DIR) "/incoming/vasy" 

array set TYPE_CONDITION {}

set GL(AUTH_TYPES) {}
set GL(AUTH_CLASSES) {}

set GL(COMPRESSED_FORMAT) [list .Z .gz .bz2 .zip]

set GL(AUTH_COMPRESSED) [list ""]

set GL(CONSIDER_COMPRESSED) 1

set GL(AUTH_DIR) {}

set GL(LOST_AUTH_DIR) {}

array set GL_FILES {}

set GL(LOST_ALREADY_SENT) {}

set GL(FILES_ALREADY_SENT) {}

set GL(FILES_TO_SEND) {}

array set GL_SELECTED_FILES {}

set GL(FORBIDDEN_FILES) {}

set GL(RULES_FORBIDDEN_FILES) {}

set GL(MD5S_ALREADY_SENT) {}
set GL(NAME_ALREADY_SENT) {}
set GL(TAIL_ALREADY_SENT) {}

set GL(REMEMBER_FILES) 1

set GL(FOLLOW_LINKS) 1

set GL(SHOW_RULES_FORBIDDEN_FILES) 0
set GL(SHOW_FORBIDDEN_FILES) 0
set GL(SHOW_FILES_ALREADY_SENT) 0

set GL(CURRENT_PAGE) ""

set BRANCH(PREVIOUS) ""
set BRANCH(NEXT) ""

set BRANCH(BACK) 0

set COLOR(FILES_ALREADY_SENT) #5555FF
set COLOR(FORBIDDEN_FILES)    #FF5555
set COLOR(RULES_FORBIDDEN_FILES)  #9933FF

set CK_IMAGE_ON [tix getimage ck_on]
set CK_IMAGE_OFF [tix getimage ck_off]
set CK_IMAGE_DEF [tix getimage ck_def]

proc Enable_Next {} {[Frame_Buttons].next configure -state normal}
proc Enable_Previous {} {[Frame_Buttons].previous configure -state normal}
proc Disable_Next {} {[Frame_Buttons].next configure -state disabled}
proc Disable_Previous {} {[Frame_Buttons].previous configure -state disabled}
proc Enable_Cancel {} {.invisible.frame_bottom.exit configure -state normal}
proc Disable_Cancel {} {.invisible.frame_bottom.exit configure -state disabled}
proc Rename_Next {TEXT} {[Frame_Buttons].next configure -text $TEXT}

proc Init_Procedure {TYPE_SCREEN NEXT_PROC PREV_PROC {DESTROY_LEFT 0}  } {
    Make_Screen $TYPE_SCREEN $DESTROY_LEFT
    Init_Buttons $TYPE_SCREEN $NEXT_PROC $PREV_PROC
    Init_Frame_BottomLeft
}

proc Learn_more {} {
    global WEB
    global MAN_PAGE

    set LEARN_MORE [button [Frame_BottomLeft].learn_more \
			-text "Learn more about Contributor" \
			-font [Small_Font] \
			-command "
	                    exec $WEB $MAN_PAGE &
	                "]
    pack $LEARN_MORE -side left -padx 10
}

proc Start {} {
    global GL
    global BRANCH

    set GL(CURRENT_PAGE) "Start"

    Init_Procedure NORMAL Start_next Start

    init_preferences

    Titlepage "CADP Contribution Assistant"

    display_left_logo
    Message left Accueil [subst [Texte Start]]

    Learn_more

    Enable_Next
}

proc Start_next {} {
    global GL
    global BRANCH

    set GL(CURRENT_PAGE) "Start"
    if { $BRANCH(BACK) == 1 } {
	Init_Procedure NORMAL Choose_Directories Start 1
	display_left_logo
    } else {
	Init_Procedure NORMAL Choose_Directories Start
    }

    Titlepage "How Contributor works"

    display_left_logo
    Message left Accueil [subst [Texte Start_next]]

    Learn_more

    load_type

    load_authorized_classes

    Enable_Previous
    Enable_Next
}

proc Choose_Directories {} {
    global GL
    global Tree

    set GL(CURRENT_PAGE) "Choose_Directories"

    Init_Procedure NORMAL load_select_dir Start_next 1

    Titlepage "Select the directories that Contributor will search"

    load_authorized_paths

    if { ![info exists Tree] || ![winfo exists $Tree]} {
	set Tree [create_tree_dir [Left_Main_Frame].tree 70 32] 
    }

    display_tree $Tree

    Message left choose_directories [subst [Texte Choix_repertoires]]

    legend_checkbox

    checkbutton [Main_Frame].follow_links \
	-text "Follow symbolic links" \
	-variable GL(FOLLOW_LINKS) \
	-font [Small_Font]\
	-command {}
    pack [Main_Frame].follow_links -side bottom -pady 30

    Enable_Previous
    Enable_Next
}

proc load_select_dir {} {
    global GL
    global Tree

    set GL(AUTH_DIR) {}
    list_select_node $Tree.tree [$Tree.tree nodes "root"] GL(AUTH_DIR)

    if {[llength $GL(AUTH_DIR)] == 0} {
	if [catch {set FILE_WINDOW [toplevel .no_dir]} err] then {
	    return
	}
	Warning_Window .no_dir "Contributor: Error"
	Make_Label .no_dir.msg left [subst [Texte aucun_repertoire]]
	return
    }

    Choose_File_Formats
}

proc load_type {} {
    global GL
    global TYPE_CONDITION

    unset TYPE_CONDITION
    array set TYPE_CONDITION {}

    foreach CLASS $GL(CLASSES) {
	foreach TYPE [lindex $CLASS 2] {
	    set EXT [lindex $TYPE 0]
	    set COND [lindex $TYPE 1]
	    if {[info exists TYPE_CONDITION($EXT)]} {
		if [catch {set FILE_WINDOW [toplevel .multiple_cond]} err] then {
		    return
		}
		Warning_Window .multiple_cond "Contributor: Error"
		Make_Label .multiple_cond.msg left "A selection rule already exists for the \"$EXT\" extension."
		return
	    } else {
		set TYPE_CONDITION($EXT) "$COND"
	    }
	}
    }
}

proc exists_class {CLASS_ID} {
    global GL

    foreach CLASS $GL(CLASSES) {
	if {[lindex $CLASS 0] == $CLASS_ID} {
	    return 1
	}
    }
    return 0
}

proc Choose_File_Formats {} {
    global GL
    global BRANCH

    set GL(CURRENT_PAGE) "Choose_File_Formats"

    Init_Procedure NORMAL get_authorized_classes Choose_Directories 1
    display_left_logo

    Titlepage "Select the file types that Contributor will search"

    Message left Choix_types_fichier [subst [Texte Choix_types_fichier]]

    set FRAME_TYPES [frame [Main_Frame].types ]
    pack $FRAME_TYPES -fill both -expand 1

    foreach CLASS $GL(CLASSES) {
	set CLASS_ID [lindex $CLASS 0]

	if {[lsearch $GL(AUTH_CLASSES) $CLASS_ID] != -1} {
	    set GL(CONSIDER_$CLASS_ID) 1
	} else {
	    set GL(CONSIDER_$CLASS_ID) 0
	}

	set CHECK_BUTTON [checkbutton $FRAME_TYPES.check_button_for_$CLASS_ID \
				      -variable GL(CONSIDER_$CLASS_ID) \
				      -font [Small_Font] \
				      -text [lindex $CLASS 1]]
	pack $CHECK_BUTTON -anchor w
    }

    label $FRAME_TYPES.breakline_label -font [Small_Font] -text "\n"
    pack $FRAME_TYPES.breakline_label

    set TEXT [join $GL(COMPRESSED_FORMAT) " "]

    set TEXT "[Texte inclure_archives] ($TEXT)"

    set CHECK_BUTTON [checkbutton $FRAME_TYPES.check_button_for_compressed \
				  -variable GL(CONSIDER_COMPRESSED) \
				  -font [Small_Font] \
				  -text "$TEXT"]
    pack $CHECK_BUTTON -anchor w

    Enable_Previous
    Enable_Next
}

proc get_authorized_classes {} {

    global GL

    set GL(AUTH_CLASSES) {}
    set GL(AUTH_TYPES) {}
    set GL(AUTH_COMPRESSED) [list {}]

    foreach CLASS $GL(CLASSES) {
	set CLASS_ID [lindex $CLASS 0]

	if {$GL(CONSIDER_$CLASS_ID) != 0} {
	    lappend GL(AUTH_CLASSES) $CLASS_ID
	    foreach TYPE [lindex $CLASS 2] {
		lappend GL(AUTH_TYPES) [lindex $TYPE 0]
	    }
	}
    }
    if { [llength $GL(AUTH_CLASSES)] == 0 } {
	if [catch {set FILE_WINDOW [toplevel .no_types]} err] then {
	    return
	}
	Warning_Window .no_types "Contributor: Error"
	Make_Label .no_types.msg left [subst [Texte aucun_type]]
	return
    }

    if {$GL(CONSIDER_COMPRESSED) != 0} {
	set GL(AUTH_COMPRESSED) [concat {""} $GL(COMPRESSED_FORMAT)]
    }
    search_files
}

proc search_files {} {
    global GL
    global GL_FILES
    global GL_SELECTED_FILES
    global FIND
    global TAIL
    global ProcessId_find
    global Tree_files

    global CADP_SUM

    set GL(CURRENT_PAGE) "search_files"
    Init_Procedure NORMAL select_files_to_send Choose_File_Formats 1
    display_left_logo

    Titlepage "Selecting files"

    Message left info_search [subst [Texte info_recherche]]
    Make_Search_messages
    Disable_Previous
    Disable_Next
    Disable_Cancel

    Activate_message begin_find

    exec echo "" > [get_preference_path find.log]

    set recherche_name ""
    foreach ext $GL(AUTH_TYPES) {
	foreach compressed $GL(AUTH_COMPRESSED) {
	    if {$recherche_name != ""} {
		set recherche_name "$recherche_name -o -name \\\"*$ext$compressed\\\" "
	    } else {
		set recherche_name "-name \\\"*$ext$compressed\\\" "
	    }
	}
    }

    if { $GL(FOLLOW_LINKS) } {
	set FOLLOW_LINKS "-L"
    } else {
	set FOLLOW_LINKS ""
    }

    set ignored_dirs "-name SCCS -o -name BitKeeper -o -name RCS -o -name CVS -o -name .svn -o -name .git -o -name .hg -o -name .bzr" 

    set find_pipe [open "| sh -c \"find $FOLLOW_LINKS $GL(AUTH_DIR) \\\\\\\( $ignored_dirs \\\\\\\) -prune -o \\\\\\\( $recherche_name \\\\\\\) -print 2> [get_preference_path find_error.log]\"" "r"]
    fconfigure $find_pipe -buffering none

    set ProcessId_find [pid $find_pipe]

    set found_files_count 0
    unset GL_FILES
    array set GL_FILES {}

    while {[gets $find_pipe filename] >= 0} {

	if {[file readable "$filename"] == 0} {
	    continue
	}

	set chemin [file split $filename]
	set expanded_filename ""
	foreach dir $chemin {

	    set tmp [file normalize [file join $expanded_filename $dir]]
	    if {[string equal [file type "$tmp"] "link"]} {
		set linkpath [file readlink "$tmp"]
		if {[string equal [file pathtype "$linkpath"] "absolute"]} {
		    set expanded_filename "$linkpath"
		} else {
		    set expanded_filename [file join "$expanded_filename" "$linkpath"]
		}
	    } else {
		set expanded_filename "$tmp"
	    }
	}
	set expanded_filename [file normalize "$expanded_filename"]

	if {[string equal [file type "$filename"] "link"]} {

	    set file_ext [file extension "$expanded_filename"]

	    if {[lsearch $GL(AUTH_COMPRESSED) "*$file_ext"] != -1} {

		set file_ext [file extension [file rootname "$expanded_filename"]]

	    }

	    if {[lsearch $GL(AUTH_TYPES) "*$file_ext"] == -1} {

		continue
	    }
	}

	if {[file isfile $expanded_filename] == 0 || [file readable $expanded_filename] == 0} {

	    continue
	}

	if {[info exists GL_FILES($expanded_filename)] == 0} {
	    set GL_FILES($expanded_filename) 1
	    incr found_files_count
	}

	Update_Search_Label begin_find $found_files_count "[Get_Search_Text begin_find] $found_files_count files found"
    }

    [Main_Frame].begin_find.label configure -text "[Get_Search_Text begin_find] $found_files_count files found"

    catch {close $find_pipe}

    Desactivate_message begin_find
    Activate_message load_files

    load_files_already_sent
    load_forbidden_files

    Desactivate_message load_files
    Activate_message remaining_files

    set remaining_files {}
    set remaining_files_count $found_files_count
    set loop_count 0

    foreach filename [array names GL_FILES] {
	incr loop_count

	Update_Search_Label remaining_files $loop_count "[Get_Search_Text remaining_files] $remaining_files_count files kept"

	if {[lsearch $GL(NAME_ALREADY_SENT) "$filename"] == -1 && [lsearch $GL(FORBIDDEN_FILES) "$filename"] == -1} {
	    lappend remaining_files "$filename"
	} else {
	    incr remaining_files_count -1
	}
    }

    [Main_Frame].remaining_files.label configure -text "[Get_Search_Text remaining_files] $remaining_files_count files kept"

    Desactivate_message remaining_files
    Activate_message sorting_files

    set GL(RULES_FORBIDDEN_FILES) {}
    set loop_count 0
    set selected_files_count $remaining_files_count
    set relevant_files {}

    foreach filename $remaining_files {
	incr loop_count

	Update_Search_Label sorting_files $loop_count "[Get_Search_Text sorting_files] $selected_files_count files selected"

	if {![ verify_rules_conditions $filename] && [lsearch $GL(RULES_FORBIDDEN_FILES) $filename] == -1} {
	    lappend GL(RULES_FORBIDDEN_FILES) $filename
	    incr selected_files_count -1
	} else {
	    lappend relevant_files "$filename"
	}
    }

    [Main_Frame].sorting_files.label configure -text "[Get_Search_Text sorting_files] $selected_files_count files selected"

    catch {file delete [get_preference_path find.log] }
    catch {file delete [get_preference_path find_error.log] }

    Desactivate_message sorting_files

    Activate_message unjoin_files
    sort_lists_files

    unset GL_SELECTED_FILES
    array set GL_SELECTED_FILES {}
    set nb_selected_files $selected_files_count
    set loop_count 0

    set fileId [open [get_preference_path relevant_files_list] "w"]
    foreach file $relevant_files {
	puts $fileId "$file"
    }
    catch {close $fileId}

    set cksum_pipe [open "| sh -c \"cat \\\"[get_preference_path relevant_files_list]\\\" | $CADP_SUM 2> /dev/null\""]
    fconfigure $cksum_pipe -buffering none

    while {[gets $cksum_pipe line] >= 0} {
	set pos [string first " " $line]
	set file [string range $line [expr $pos + 1] end]
	set cksum [lindex $line 0]

	incr loop_count

	Update_Search_Label unjoin_files $loop_count "[Get_Search_Text unjoin_files] $nb_selected_files files kept"

	if {[lsearch $GL(RULES_FORBIDDEN_FILES) "$file"] == -1 && ![is_already_sent "$file" "$cksum"]} {
	    set GL_SELECTED_FILES($file) 1
	} else {
	    incr nb_selected_files -1
	}
    }

    catch {close $cksum_pipe}
    catch {file delete [get_preference_path relevant_files_list]}

    [Main_Frame].unjoin_files.label configure -text "[Get_Search_Text unjoin_files] $nb_selected_files files kept"

    Desactivate_message unjoin_files

    [Main_Frame].generate_tree.label configure -text "Preparing the display of these $nb_selected_files files..."

    Activate_message generate_tree
    if {[info exists Tree_files] && [winfo exists $Tree_files]} {
	destroy $Tree_files
    }
    set Tree_files [create_tree_files [Left_Main_Frame].tree_files 70 32 ]

    unset GL_SELECTED_FILES
    array set GL_SELECTED_FILES {}
    Desactivate_message generate_tree

    if {$nb_selected_files != 0} {

	Message center search_complete [subst [Texte recherche_finie]]
	Enable_Next
    } else {

	Message center search_complete [subst [Texte recherche_vide]]
    }

    Enable_Cancel
    Enable_Previous
}

proc select_files_to_send {} {
    global GL
    global Tree_files
    global COLOR
    global BRANCH

    set GL(CURRENT_PAGE) "select_files_to_send"
    Init_Procedure NORMAL Confirm_send Choose_File_Formats 1

    Titlepage "Review and refine selection"

    set GL(SHOW_RULES_FORBIDDEN_FILES) 0
    set GL(SHOW_FORBIDDEN_FILES) 0
    set GL(SHOW_FILES_ALREADY_SENT) 0

    display_tree $Tree_files

    Message left choose_files [subst [Texte choix_fichiers]]

    legend_checkbox

    Message left hidden_files [subst [Texte fichiers_caches]]

    set FRAME_HIDE [frame [Main_Frame].frame_hide ]
    pack $FRAME_HIDE -side top

    Make_Checkbutton_hide $FRAME_HIDE "Show user-excluded files" FORBIDDEN_FILES 0
    Make_Checkbutton_hide $FRAME_HIDE "Show rules-excluded files" RULES_FORBIDDEN_FILES 1
    Make_Checkbutton_hide $FRAME_HIDE "Show files already sent" FILES_ALREADY_SENT 2

    Message left selection_files [subst [Texte selection_fichiers]]

    button [Main_Frame].view_files -text "See the list of files to sent"\
	-command {see_list_of_files}\
	-font [Small_Font]
    pack  [Main_Frame].view_files -side bottom -pady 10

    checkbutton [Frame_BottomLeft].remember_files \
	-text "Remember selection for next time" \
	-variable GL(REMEMBER_FILES) \
	-font [Small_Font]\
	-command {}
    pack [Frame_BottomLeft].remember_files -side left -padx 30

    Enable_Previous
    Enable_Next
}

proc Confirm_send {} {

    global GL
    global BRANCH
    global Tree_files
    global env

    if {$BRANCH(BACK) == 0} {
	set GL(FILES_TO_SEND) {}
	list_select_files $Tree_files.tree [$Tree_files.tree nodes "root"] GL(FILES_TO_SEND)
    }

    set GL(CURRENT_PAGE) "Confirm_send"

    if { $BRANCH(BACK) != 1 } {
	Init_Procedure NORMAL Send_FTP select_files_to_send 1
	display_left_logo
    } else {
	Init_Procedure NORMAL Send_FTP select_files_to_send 
    }

    Titlepage ""

    Message left list_files [subst [Texte list_files]]

    Enable_Previous

    if {[llength $GL(FILES_TO_SEND)] > 0} { 

	global NAME
	global EMAIL
	
	set NAME ""

	set frame_infos [frame [Main_Frame].infos]
	set NL [frame $frame_infos.name_label    ]
	set EL [frame $frame_infos.email_label     ]
	set AL [frame $frame_infos.address_label  ]
	set ML [frame $frame_infos.message_label ]
	
	set NL_LABEL [label $NL.label -justify left -text "Name: " -font [Small_Font] ]
	set EL_LABEL [label $EL.label -justify left -text "E-mail: " -font [Small_Font] ]
	set AL_LABEL [label $AL.label -justify left -text "Organization\nand address: " -font [Small_Font] ]
	set ML_LABEL [label $ML.label -justify left -text "Message to\nthe CADP team:\n(Optional)" -font [Small_Font] ]

	set N  [entry $frame_infos.name -textvariable NAME -width 30]
	set A  [ text $frame_infos.address  -height 4 -width 30 ]
	set E  [entry $frame_infos.email -textvariable EMAIL -width 30 ]
	set M  [ text $frame_infos.message -height 4 -width 30 ]

	pack $NL_LABEL $AL_LABEL $ML_LABEL $EL_LABEL -side left
	grid $NL $N -sticky nsew
	grid $AL $A -sticky nsew
	grid $EL $E -sticky nsew
	grid $ML $M -sticky nsew

	pack $frame_infos -side top -pady 10

	Message left accept_upload [subst [Texte accept_upload]]

	update idletasks

	set NAME [read_user_info NAME]
	set EMAIL [read_user_info EMAIL]
	set ADDRESS [read_user_info ADDRESS]
	$A insert end $ADDRESS
	
	Enable_Next
    } else {

	Message left nothing_to_send [subst [Texte nothing_to_send]]
	Disable_Next
    }
}

proc ProgressBar {{TAILLE 0}} {

    global TAILLE_TOTALE

    Barre $TAILLE $TAILLE_TOTALE
    update idletasks
}

proc Send_FTP {} {

    global GL
    global BRANCH
    global TAILLE_TOTALE
    global HERE
    global NEW_TAR
    global env
    global NAME
    global EMAIL
    global CD

    set NEW_TAR_README "user"

    if { $BRANCH(BACK) != 1 } {
	set description [ [Main_Frame].infos.message get 1.0 end ]
	set address      [ [Main_Frame].infos.address  get 1.0 end ]

	if { [ catch {open [get_preference_path user] w} fileId ] } {
	    error "unable to create [get_preference_path user]"
	    return
	}
	
	puts $fileId "Institution: [string trim $address]"
	puts $fileId "Official: $NAME"
	puts $fileId "E-mail: $EMAIL"
	puts $fileId "\nDescription:\n[string trim $description]"

	close $fileId
    }

    set GL(CURRENT_PAGE) "Send_FTP"
    Init_Procedure NORMAL Quit Confirm_send

    Titlepage "Sending files"

    Disable_Next
    Disable_Cancel

    Make_Send_FTP_message

    Activate_message tar

    set HERE [pwd]
    $CD [glob "~"]

    set NEW_TAR [clock format [clock seconds] -format "$env(CONTRIBUTOR_TMP)/CONTRIBUTOR-%Y-%m-%d-%Hh%Mm%Ss.tar.gz"]

    set TAR_FILE_LIST [open "[get_preference_path tar_file_list]" "w"]

    fconfigure $TAR_FILE_LIST -translation lf

    foreach file [ concat [list [get_preference_path $NEW_TAR_README]] $GL(FILES_TO_SEND) ] {
	puts $TAR_FILE_LIST "$file"
    }  
    close $TAR_FILE_LIST

    set command_tar  "exec $env(CONTRIBUTOR_TAR) [get_preference_path tar_file_list] 2> [get_preference_path tar.log] | gzip > $NEW_TAR 2> [get_preference_path tar.log]"

    $CD /
    if { [catch {eval   $command_tar}] } {

	if [catch {set FILE_WINDOW [toplevel .tar_failed]} err] then {
	    return
	}
	Warning_Window .tar_failed "Contributor: Error"
	label .tar_failed.msg -font [Small_Font] -text [subst [Texte archivage_echoue]]
        pack .tar_failed.msg -side top
	frame .tar_failed.f
	pack .tar_failed.f -side top
	set QUIT [button .tar_failed.f.quit -text "Quit"  -command "
	    $CD $HERE
            catch \{file delete $NEW_TAR\}
	    Quit
	" ]
	set RETRY [button .tar_failed.f.retry -text "Retry" -command "
	    destroy .tar_failed
            catch \{file delete $NEW_TAR\}
	    Send_FTP
	" ]
	pack $RETRY -side left -padx 10 -pady 10 
	pack $QUIT -side left -padx 10 -pady 10
	return
    }

    catch {file delete [get_preference_path tar.log] }

    catch {file delete [get_preference_path tar_file_list] }

    set TAILLE_TOTALE [file size $NEW_TAR]

    Desactivate_message tar
    Activate_message open_connexion

    begin_connexion 
}

proc begin_connexion {} {
    global GL
    global HERE
    global CD
    global NEW_TAR

    if ![Open $GL(SERVER) $GL(USER) $GL(PASSWD) -mode passive -progress {ProgressBar}] {

	if [catch {set FILE_WINDOW [toplevel .connexion_failed]} err] then {
	    return
	}
	Warning_Window .connexion_failed "Contributor: Error"
	label .connexion_failed.msg -font [Small_Font] -text [subst [Texte connexion_echouee]]
        pack .connexion_failed.msg -side top
	frame .connexion_failed.f
	pack .connexion_failed.f -side top
	set QUIT [button .connexion_failed.f.quit -text "Quit"  -command "
	    $CD $HERE
	    Quit
	" ]
	set RETRY [button .connexion_failed.f.retry -text "Retry" -command {
	    destroy .connexion_failed
	    begin_connexion $NEW_TAR
	} ]
	pack $RETRY -side left -padx 10 -pady 10 
	pack $QUIT -side left -padx 10 -pady 10
	return
    }

    Cd $GL(FTP_DIR)

    begin_transfert 
}

proc begin_transfert {} {   

    global GL
    global HERE
    global CD
    global NEW_TAR

    Desactivate_message open_connexion
    Activate_message transfert

    set GL(TRANSFERT_COMPLETE) 0

    if [Put $NEW_TAR [file tail $NEW_TAR] ] then {
	set GL(TRANSFERT_COMPLETE) 1
    } else {
	set GL(TRANSFERT_COMPLETE) 0
    }
    Desactivate_message transfert

    if $GL(TRANSFERT_COMPLETE) {

	$CD $HERE
	catch {file delete $NEW_TAR}

	Activate_message save_lists

	save_authorized_classes
	save_authorized_paths
	save_forbidden_files

	save_files_sent
	Desactivate_message save_lists
	
	Message left transfert_complete [subst [Texte transfert_complete]]
	Color_Message transfert_complete red
	
	Disable_Previous
	Enable_Next

	Rename_Next "Finish"
    } else {

	if [catch {set FILE_WINDOW [toplevel .tranfert_failed]} err] then {
	    return
	}
	Warning_Window .tranfert_failed "Contributor: Error"
	Make_Label .transfert_failed.msg top [subst [Texte transfert_echoue]]
	frame .transfert_failed.f
	pack .transfert_failed.f -side top
	Make_Button .transfert_failed.f..quit "Quit" right {
	    Quit
	}
	Make_Button .transfert_failed.f.retry "Retry" right {
	    destroy .transfert_failed
	    begin_transfert
	}
	return
    }

    Close

    if $GL(TRANSFERT_COMPLETE) {

	file delete [Trace]
    }
}

proc save_list_files_to_send {} {

    global GL

    set FILE [ tk_getSaveFile ]

    if { $FILE == "" } {
	return
    }

    if { ![ catch {open $FILE w} fileId ] } {

	puts $fileId "Here is the list of all the files to send to the VASY TEAM:\n\n"
	foreach file $GL(FILES_TO_SEND) {
	    puts $fileId $file
	}
	close $fileId

	if [catch {set FRAME_SAVE [toplevel .frame_save]} err] then {
	    return
	}
	wm title $FRAME_SAVE "Contributor: list saved"
	
	set TEXT [ Label $FRAME_SAVE.text \
		       -text "\nThe list has been saved in\n$FILE\n"\
		       -font  [Small_Font]\
		      ]
	set BUTTON_OK [ button $FRAME_SAVE.ok -text "Ok" -command "destroy $FRAME_SAVE" ]
	
	pack $TEXT -side top
	pack $BUTTON_OK -side bottom
    }
}

proc print_list_files_to_send {} {

    global GL
    global env
    global PRINTER

    if { [ catch {open [get_preference_path files_to_send.txt] w} fileId ] } {
	return
    }

    puts $fileId "Here is the list of all the files to send to the VASY Team ([llength $GL(FILES_TO_SEND)] file(s) ):"
    foreach file $GL(FILES_TO_SEND) {
	puts $fileId $file
    }
    close $fileId

    if [catch {set FRAME_PRINT [toplevel .frame_print]} err] then {
 	return
    }
    wm title $FRAME_PRINT "Contributor: print list of files to send"
    wm minsize $FRAME_PRINT 400 150
    wm maxsize $FRAME_PRINT 400 150

    set PRINTER $env(PRINTER)

    set FRAME_TOP [ frame $FRAME_PRINT.top ]
    set FRAME_BOTTOM [ frame $FRAME_PRINT.bottom ]

    set TEXT [ label $FRAME_TOP.text -text "Specify the printer: " -font [Small_Font] ]

    set PRINTER_NAME [ entry $FRAME_TOP.name \
			   -textvariable PRINTER\
			   -width 10 ]
    set INFOS_PRINT [ label $FRAME_PRINT.infos -text "" -font [Small_Font] ]
    set BUTTON_OK [ button $FRAME_BOTTOM.ok -text "Print" -command {print_list_files_to_send_next} ]
    set BUTTON_CANCEL [ button $FRAME_BOTTOM.close -text "Close" -command {catch {destroy .frame_print}} ]

    pack $FRAME_TOP -side top -pady 20
    pack $INFOS_PRINT -side top
    pack $FRAME_BOTTOM -side bottom
    pack $TEXT $PRINTER_NAME -side left
    pack $BUTTON_OK $BUTTON_CANCEL -side left -padx 10 -pady 10
}

proc print_list_files_to_send_next {} {
    global PRINT
    global PRINTER

    if {![catch {exec sh -c "$PRINT -d $PRINTER [get_preference_path files_to_send.txt] &" } err]} { 
	.frame_print.infos configure -text "Printing list on $PRINTER..."
    } else {
	.frame_print.infos configure -text "Error: $PRINTER is not a valid printer."
    }
}

proc edit_file {file} {
    global EDIT

    exec sh -c "$EDIT \"$file\" "
}

proc Quit {} {

    global GL
    global ProcessId_find
    global HERE
    global CD

    if {[info exists GL(REMEMBER_PREFERENCES) ] && $GL(REMEMBER_PREFERENCES)  } {
	Wait_Window "\nPlease Wait...\n"

	if { [info exist ProcessId_find] } {

	    catch {exec sh -c "kill [expr $ProcessId_find + 1]"}
	}
	
	if {[info exists HERE]} {
	    $CD $HERE
	}

	switch $GL(CURRENT_PAGE) {
	    Start -

	    Choose_Directories -
	    
      	    Choose_File_Formats {
		save_authorized_paths
	    }
	    search_files {
		save_authorized_classes
		save_authorized_paths
	    }
	    select_files_to_send {
		save_authorized_classes
		save_authorized_paths
		
	    }
	    Confirm_send {
		save_authorized_classes
		save_authorized_paths
		save_forbidden_files
	    }
	    Send_FTP {
		save_authorized_classes
		save_authorized_paths
		save_forbidden_files
	    }
	}
    }

    exit 0
}

Make_Window
Make_Bar_Buttons NORMAL

Start

