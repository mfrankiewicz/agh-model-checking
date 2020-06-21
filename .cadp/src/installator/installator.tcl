###############################################################################
#                       I N S T A L L A T O R
#-----------------------------------------------------------------------------
#   INRIA
#   Unite de Recherche Rhone-Alpes
#   655, avenue de l'Europe
#   38330 Montbonnot Saint Martin
#   FRANCE
#-----------------------------------------------------------------------------
#   Module              :       installator.tcl
#   Auteurs             :       Patrick WENDEL, Hubert GARAVEL, Aldo MAZZILLI,
#                       :       Nicolas DESCOUBES et David CHAMPELOVIER
#   Version             :       2.38
#   Date                :       2019/11/12 20:31:25 
##############################################################################

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

set STATUS_COMMAND				 -1

set CADP(INSTALL_PATH) $env(CADP_INSTALLATOR)

set CADP(ARCHIVE_OLD_VERSION) ""

set CADP(EXISTE) 0

set CADP(OLD_PATH) ""

set CADP(DEFAULT_INSTALLATION_PATH) $env(CADP_DEFAULT_DIR)

set CADP(NEW_PATH) ""

set CADP(DIR) $CADP(INSTALL_PATH)

set CADP(GIVEN_PATH) ""

set CADP(SEARCH_PATH) ""

set CADP(NEW_PATH_SHOWN_TO_USER) ""

set CADP(TMP) [exec sh "$CADP(INSTALL_PATH)/src/com/cadp_path" "-winpath" $env(CADP_TMP)]

set CADP(TMP_ARCHIVE) $CADP(TMP)

set CADP(PREFIXE) $env(CADP_PREFIXE)

set CADP(LOG_FILE) "INSTALLATOR.log"

set CADP(FILE_VERSION) {CADP_CURRENT_VERSION}

set CADP(DISTRIBUTION_KIND) $env(CADP_DISTRIBUTION_KIND)

proc Set_Version_Specific_Variables {} {
    global CADP
    if {$CADP(DISTRIBUTION_KIND) == "stable"} {
	set CADP(FTP_FILE_VERSION) "CURRENT_VERSION"
	set CADP(TEST) "CADP_test_"
    } else {
	set CADP(FTP_FILE_VERSION) "CURRENT_BETA_VERSION"
	set CADP(TEST) "CADP_beta_"
    }
}

Set_Version_Specific_Variables

set CADP(LICENSE_OLD) "CADP_LICENSE_OLD"

set CADP(LICENSE_MAIL) "CADP_LICENSE_MAIL"

set CADP_LICENSE_SAVE "$env(CADP_HOME_DIR)/CADP_LICENSE"

set CADP(INFO_FILE) "CADP_INFO_FILE"

set CADP(FROM) ""

set CADP(SMTP_SERVER) ""

set FROM_LABEL "Return license to:"

set SMTP_LABEL "SMTP Server:"

set CADP(E_MAIL_ADDRESS) "cadp@inria.fr"

set CADP(FTP_ADDRESS) "ftp.inrialpes.fr"

set CADP(FILE_ERROR_UNCOMPRESS) "cadp_error_uncompress"

set CADP(FILE_ERROR_TAR) "cadp_error_tar"

set CADP(IS_DOWNLOAD_VERSION) 0

set CADP(IS_DOWNLOAD_TEST) 0

set CADP(PASSWD) {}

set CADP(HOSTS) ""

set INFO_NAME ""

set INFO_ORGANIZATION ""

set INFO_EMAIL ""

set INFO_REMINDER 30

set OPTION(SAUVE) RM_AFTER

set PARAM(SEND_METHOD) "FTP"

set PARAM(REMOTE_ACCESS_PROTOCOL) "any"

set BRANCH(PREVIOUS) ""
set BRANCH(NEXT) ""
set BRANCH(RETRY) ""

global INSTALLATOR_STATE 

	
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

proc Make_Check {PATH TEXT SIDE VAR} {
    checkbutton $PATH \
	-text $TEXT \
	-variable $VAR \
	-font [Small_Font]
    pack $PATH -side $SIDE
}

proc Make_Radio {PATH TEXT SIDE VAL VAR} {
    radiobutton $PATH \
	-text $TEXT \
	-value $VAL \
	-variable $VAR \
	-font [Small_Font]
    pack $PATH -side $SIDE
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
    label [Main_Frame].message_$NUM \
	-text $TEXT \
	-justify $ALIGN \
	-wraplength 500 \
	-font [Small_Font]
    pack [Main_Frame].message_$NUM -side top
    update ; update idletasks
}

proc Change_Message {NUM TEXT} {
    [Main_Frame].message_$NUM configure -text $TEXT

}

proc Make_List {PATH HEIGHT WIDTH SIDE} {

    set FRAME [frame $PATH.flist]
    listbox $FRAME.list -width $WIDTH\
	-height $HEIGHT \
	-yscrollcommand [list $FRAME.yscroll set] \
	-font [Small_Font]

    scrollbar $FRAME.yscroll -orient vertical \
	-command [list $FRAME.list yview]
    pack $FRAME.yscroll -side right -fill y
    pack $FRAME.list -side left  -expand true
    pack $FRAME -side $SIDE

}

proc Add_List {NOM} {
    global CADP
    if {$NOM!=""} then {
	[Main_Frame].f.flist.list insert 0 $NOM
	set CADP(HOSTS) [linsert $CADP(HOSTS) 0 $NOM]
	[Main_Frame].f.fr.entry delete 0 end
    }
}

proc Add_Listbox {PATH NOM} {
    global CADP
    if {$NOM!=""} then {
	$PATH.flist.list insert end $NOM
    }
}

proc Delete_List {PATH} {
    global CADP
    foreach INDEX [$PATH.flist.list curselection] {
	$PATH.flist.list delete $INDEX
	set CADP(HOSTS) \
	    [concat \
		 [lrange $CADP(HOSTS) 0 [expr $INDEX - 1]] \
		 [lrange $CADP(HOSTS) [expr $INDEX + 1] end]]
    }
}

proc Warning_Window {Window_Name Window_Text} {
   global CADP

   wm title $Window_Name $Window_Text 
   wm geometry $Window_Name +[expr [winfo x .] + 100]+[expr [winfo y .] + 80]

   set FRAME_LOGO [frame $Window_Name.frame_logo]

   set CANVAS_LOGO [canvas $FRAME_LOGO.canvas_logo \
                         -width 65 \
                         -height 75 ]

   image create photo LOGO_ATTENTION -format GIF -file $CADP(INSTALL_PATH)/src/installator/attention.gif

   set IMG_LOGO_ATTENTION [$CANVAS_LOGO create image 1 1 \
                           -image LOGO_ATTENTION \
                           -anchor nw ]

   pack $CANVAS_LOGO -side left
   pack $FRAME_LOGO -side left -padx 10 -pady 5
}

proc Message_Error {MSG MODE} {
    global ERROR_MSG CADP

    if [catch {set FILE_WINDOW [toplevel .errorwindow]} err] then {
	return
    }

    Warning_Window .errorwindow "Installator error"

    grab set .errorwindow   
    bell

    set FRAME [frame .errorwindow.f]

    switch $MODE {
	ERROR_MSG {
	    Make_Label $FRAME.msg top "$MSG\n $ERROR_MSG"
	}
	NO_MSG {
	    Make_Label $FRAME.msg top "$MSG\n"
	}
    }
    pack  $FRAME.msg -side top -padx 10 -pady 0 
    Make_Button $FRAME.ok "OK" bottom {destroy .errorwindow}
    pack $FRAME.ok -side bottom -pady 5

    pack $FRAME -side right -pady 10

}

proc Please_Wait {} {
   if [catch {set FILE_WINDOW [toplevel .waitwindow]} err] then {
        return
   }

   Warning_Window .waitwindow "Please wait..."

   set FRAME_PLEASE_WAIT [frame .waitwindow.f]
   Make_Label $FRAME_PLEASE_WAIT.please_wait top "Please Wait..."
   pack $FRAME_PLEASE_WAIT -side right -padx 5
   update ; update idletasks

   . config -cursor {watch}
   .waitwindow config -cursor {watch}

   after 1000
}

proc Ask_Quit {} {
    global OPTION CADP env INSTALLATOR_STATE

   if [catch {set FILE_WINDOW [toplevel .quitwindow]} err] then {
        return
   }

    Warning_Window .quitwindow "Quit Installator?"

    grab set .quitwindow   
    bell

    set FRAME [frame .quitwindow.f]

    if [expr $CADP(RUN_INSTALL)] then {

	set FRAME_MSG1 [frame $FRAME.msg1]
	Make_Label $FRAME_MSG1.msg left [subst [Texte Ask_Quit]]
	$FRAME_MSG1.msg configure -justify left
	pack $FRAME_MSG1 -side top -fill x

	set FRAME_MIDDLE [frame $FRAME.fm]
	
	set FRAME_KEEP [frame $FRAME_MIDDLE.keep]
	Make_Radio $FRAME_KEEP.keep "Keep CADP not completely installed" left KEEP OPTION(QUIT)
	$FRAME_KEEP.keep select
	
	set FRAME_CLEAN [frame $FRAME_MIDDLE.clean]
	
	Make_Radio $FRAME_CLEAN.clean " Undo the installation" left CLEAN OPTION(QUIT)
	$FRAME_CLEAN.clean select

	
	pack $FRAME_CLEAN $FRAME_KEEP -side top -fill x
	pack $FRAME_MIDDLE -side top

	set FRAME_MSG2 [frame $FRAME.msg2]
	Make_Label $FRAME_MSG2.msg_middle left "\nDo you really want to quit?"
	pack $FRAME_MSG2 -side top -fill x

	set FRAME_BAS [frame $FRAME.f] 
	Make_Button $FRAME_BAS.yes "Yes" left {

	    destroy .quitwindow
	    Please_Wait

	    if [string match $OPTION(QUIT) CLEAN] then {
		set INSTALLATOR_STATE "CANCEL_AND_UNINSTALL"
	    } else {
		set INSTALLATOR_STATE "CANCEL_AND_LEAVE"
	    }
	    Run_Shell_Setup
	    exit
	}

    } else {
	Make_Label $FRAME.msg top [subst [Texte Ask_Quit2]]
	set FRAME_BAS [frame $FRAME.f] 
	Make_Button $FRAME_BAS.yes "Yes" left {
	    destroy .quitwindow
	    Please_Wait

	    set INSTALLATOR_STATE "CANCEL_AND_LEAVE"
	    Run_Shell_Setup
	    exit
	}
    } 
    Make_Button $FRAME_BAS.no "No" right {destroy .quitwindow}
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

proc Make_Window {} {
    global CADP RETRY

    set RETRY 0

    centrage 850 500 .
    wm iconbitmap . @$CADP(INSTALL_PATH)/src/installator/icon_installator.xbm

    wm title . "installator"

    frame .invisible
    pack .invisible -fill both -expand true

    set FRAME_MIDDLE [frame .invisible.f_middle -height 20]

    set MESSAGE [label .invisible.message_CADP \
		     -text "CADP Installation Assistant "\
		     -font  -Adobe-Helvetica-Medium-R-Normal-*-*-240-* ]

    set FRAME_LOGO [frame $FRAME_MIDDLE.frame_logo]

    set CANVAS_LOGO [canvas $FRAME_LOGO.canvas_logo \
			 -width 150 \
			 -height 360 ]

    image create photo LOGO_VASY -format GIF -file $CADP(INSTALL_PATH)/src/installator/vasy.gif
    set IMG_LOGO_VASY [$CANVAS_LOGO create image 65 20 \
			   -image LOGO_VASY \
			   -anchor nw ]

    image create photo LOGO_CONVECS -format GIF -file $CADP(INSTALL_PATH)/src/installator/convecs.gif
    set IMG_LOGO_CONVECS [$CANVAS_LOGO create image 65 185 \
			   -image LOGO_CONVECS \
			   -anchor nw ]

    set COPYRIGHT [label $FRAME_LOGO.copyright \
		       -text "(C) 1997-2020 INRIA VASY+CONVECS" \
		       -font [Small_Font] ]

    set FRAME_MAIN_FRAME [frame $FRAME_MIDDLE.f ]

    pack $MESSAGE  -anchor nw -side top
    pack $CANVAS_LOGO $COPYRIGHT -side top -fill both
    pack $FRAME_LOGO -side left -padx 5
    pack $FRAME_MAIN_FRAME  -side left -padx 5  -expand true -fill both
    pack propagate $FRAME_MAIN_FRAME 0
    pack $FRAME_MIDDLE -fill both -side top -expand true

    bind all <FocusIn> {update ; update idletasks}
}

proc Make_Screen { SCREEN_MODE } {
    catch {destroy .invisible.f_middle.f.main_frame}
    set MAIN_FRAME [frame .invisible.f_middle.f.main_frame]
    pack $MAIN_FRAME -fill both -expand true
}

proc Make_Bar_Buttons {SCREEN_MODE CODE} {

    global BRANCH RETRY env

    catch {destroy .invisible.frame_bottom}

    set FRAME_BOTTOM [frame .invisible.frame_bottom]

    if $env(INSTALLATOR_DEBUG_MODE) then {
	Make_Label $FRAME_BOTTOM.code left $CODE
    }

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
	    set RETRY 0
	    $BRANCH(NEXT) 
	}\
	-font  [Small_Font]

    button $FRAME_BUTTONS.previous \
	-text " Previous " \
	-command {
	    set RETRY 0
	    set BRANCH(PREVIOUS) ""
	    [Pop]} \
	-font  [Small_Font]

    Disable_Previous 
    Disable_Next 

    pack $FRAME_BUTTONS.next $FRAME_BUTTONS.previous \
	-side right 
    pack $FRAME_BUTTONS -side right -padx 20

    if [regexp {RETRY} $SCREEN_MODE] then {
	button $FRAME_BUTTONS.retry \
	    -text "Retry" \
	    -font [Small_Font] \
	    -command {
		set RETRY 1
		$BRANCH(RETRY)
	    }
	pack $FRAME_BUTTONS.retry -side right -padx 20
    }

    pack $FRAME_BOTTOM -side bottom
    pack $FRAME_BOTTOM  -side bottom  -fill x -pady 5 -padx 10

    bind all <Alt-n> {[Frame_Buttons].next invoke}
    bind all <Alt-p> {[Frame_Buttons].previous invoke}
    bind all <Alt-c> {.invisible.frame_bottom.exit invoke}
}

proc Frame_Buttons {} {return {.invisible.frame_bottom.buttons}}

proc Main_Frame {} {return {.invisible.f_middle.f.main_frame}}

proc F_Text {} {return {.invisible.f_middle.f.main_frame.frame.text}}

proc Init_Procedure {TYPE_SCREEN NEXT_PROC PREV_PROC RETRY_PROC CODE} {
    Make_Screen $TYPE_SCREEN 
    Init_Buttons $TYPE_SCREEN $NEXT_PROC $PREV_PROC $RETRY_PROC $CODE
}

proc Init_Buttons {TYPE_SCREEN NEXT_PROC PREV_PROC RETRY_PROC CODE} {

    global BRANCH RETRY

    if [expr ![string match $BRANCH(PREVIOUS) ""] \
	    && $RETRY==0 ] \
	then {
	    Push $BRANCH(PREVIOUS)
	}

    set BRANCH(NEXT) $NEXT_PROC
    set BRANCH(PREVIOUS) $PREV_PROC
    set BRANCH(RETRY) $RETRY_PROC
    Make_Bar_Buttons $TYPE_SCREEN $CODE
}

proc Small_Font {} {return {-adobe-helvetica-bold-r-normal-*-14-*}}

proc Enable_Next {} {[Frame_Buttons].next configure -state normal}

proc Enable_Previous {} {[Frame_Buttons].previous configure -state normal}

proc Enable_Retry {} {[Frame_Buttons].retry configure -state normal}

proc Disable_Next {} {[Frame_Buttons].next configure -state disabled}

proc Disable_Previous {} {[Frame_Buttons].previous configure -state disabled}

proc Disable_Retry {} {[Frame_Buttons].retry configure -state disabled}

proc Invoke_Next {} {[Frame_Buttons].next invoke}

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

proc Make_Text {PATH TEXT WIDTH HEIGHT STATE} {
    set FRAME [frame $PATH]
    text $FRAME.text -width $WIDTH\
	-height $HEIGHT \
	-xscrollcommand [list $FRAME.xscroll set] \
	-yscrollcommand [list $FRAME.yscroll set] \
	-font [Small_Font] \
	-wrap none     
    scrollbar $FRAME.xscroll -orient horizontal \
	-command [list $FRAME.text xview]
    scrollbar $FRAME.yscroll -orient vertical \
	-command [list $FRAME.text yview]
    pack $FRAME.xscroll -side bottom -fill x
    pack $FRAME.yscroll -side right -fill y
    pack $FRAME.text -side left  -expand true
    pack $FRAME -side top 

    $FRAME.text insert end $TEXT
    $FRAME.text configure -state $STATE
    return $FRAME.text
}

proc Add_Text {TEXT} {
    [F_Text] insert end "\n[string trim $TEXT "\n\r"]"
    [F_Text] yview end 
    update idletasks
}

global X2 
set X2 1

proc Barre_Init {} {
    global COORD_BAR
    global BAR
    global Ftpbar_Color

    catch { destroy [Main_Frame].canvas_bar}
    set COORD_BAR(X1) 10
    set COORD_BAR(Y1) 10
    set COORD_BAR(X2) 250
    set COORD_BAR(Y2) 30
    set CANVAS_BAR [canvas [Main_Frame].canvas_bar \
			-width $COORD_BAR(X2) \
			-height $COORD_BAR(Y2) ]

    $CANVAS_BAR create rect \
	$COORD_BAR(X1) $COORD_BAR(Y1) \
	$COORD_BAR(X2) $COORD_BAR(Y2)

    set BAR [$CANVAS_BAR create rect \
		 $COORD_BAR(X1) $COORD_BAR(Y1) \
		 $COORD_BAR(X1) $COORD_BAR(Y1) \
		 -fill $Ftpbar_Color]

    pack $CANVAS_BAR -side top
    Message center INFORMATION "0%"
}

proc Barre {TAILLE TAILLE_MAX} {
    global BAR
    global COORD_BAR

    set RATIO [expr (double ($TAILLE) / double ($TAILLE_MAX))]

    set X2 [ expr $COORD_BAR(X1) + round (($COORD_BAR(X2) - $COORD_BAR(X1)) * $RATIO) ]

    catch {
	[Main_Frame].canvas_bar coord $BAR \
		 $COORD_BAR(X1)  $COORD_BAR(Y1) \
		 $X2             $COORD_BAR(Y2)
    }
    set TAILLE_EN_MB [format "%.1f" [expr double($TAILLE_MAX) / (double (1024) * double (1024))]]
    set PER_CENT [expr round ($RATIO * double (100))]
    catch {Change_Message INFORMATION "${PER_CENT}% of ${TAILLE_EN_MB} MB"}
}

proc Browse_Path {VAR NAME} {
    global CADP 
    global CHEMIN_ABSOLU
    global G_VAR BROWSE_ROOT
    set G_VAR $VAR

    if [catch {set FILE_WINDOW [toplevel .filewindow]} err] then {
	return
    }
    grab set .filewindow
    if {$CADP($G_VAR)==""} then {
	set BROWSE_ROOT /
    } elseif [file isdirectory $CADP($G_VAR)] then {
	set BROWSE_ROOT $CADP($G_VAR)
    } elseif [file isdirectory [file dirname $CADP($G_VAR)]] then {
	set BROWSE_ROOT [file dirname $CADP($G_VAR)]
    } else {
	set BROWSE_ROOT /
    }
    wm title .filewindow $NAME

    Make_Entry $FILE_WINDOW.path CHEMIN_ABSOLU 40 top
    pack $FILE_WINDOW.path -side top -pady 5 
    Make_Filebox {DIR BROWSE_ROOT *  No_Ok_Button}

    set BOTTOM [frame $FILE_WINDOW.bottom]
    Make_Button $BOTTOM.ok "OK" left {
	set CADP($G_VAR) $CHEMIN_ABSOLU	
	destroy .filewindow
    }
    $BOTTOM.ok configure -borderwidth 4
    pack $BOTTOM.ok -side left -padx 40
    Make_Button $BOTTOM.cancel "Cancel" right {
	destroy .filewindow
    }
    pack $BOTTOM.cancel -side right -padx 40
    pack $BOTTOM -side top -pady 5 -fill x 

    bind  $FILE_WINDOW.path <Return> {.filewindow.bottom.ok invoke}
}

proc Bind_Click {Listbox Fbox New_Item Directory_Change Ok_Button} {
      global CHEMIN_ABSOLU

      global Selected_Directory_Index
      global Selected_Directory_Name
      global Selected_File_Index
      global Selected_File_Name
      global Ok_Button_Address

      if [expr $Directory_Change == 1] then {

         set Selected_Directory_Index($Fbox) [$Listbox nearest $New_Item]
         set New_Directory [$Listbox get $Selected_Directory_Index($Fbox)]
         set Selected_Directory_Name($Fbox) $Selected_Directory_Name($Fbox)/$New_Directory

         Refresh_Files_Listbox $Fbox
         set Selected_File_Index($Fbox) 0
         set Selected_File_Name($Fbox) ""

         if [string compare $Ok_Button No_Ok_Button] then {
	     $Ok_Button_Address($Ok_Button) configure -state disabled
         }
      } else {
         set Selected_File_Index($Fbox) [$Listbox nearest $New_Item]
         set Selected_File_Name($Fbox) $Selected_Directory_Name($Fbox)/[$Listbox get $Selected_File_Index($Fbox)]
         if [string compare $Ok_Button No_Ok_Button] then {
             $Ok_Button_Address($Ok_Button) configure -state normal
         }
      set CHEMIN_ABSOLU $CHEMIN_ABSOLU/[file tail $Selected_File_Name($Fbox)]
      }
}

proc Make_Filebox {List} {
    set Wind .filewindow
    set i 1
    foreach Characteristic $List {
	set Array($i) $Characteristic
	incr i
    }

    set FRAME_FILEBOX [frame $Wind.frame_filebox]

    frame $FRAME_FILEBOX.frame -relief raised -borderwidth 1
          pack $FRAME_FILEBOX.frame -side left -fill both

    label $FRAME_FILEBOX.frame.label -font [Small_Font] -text "Directories"
          pack $FRAME_FILEBOX.frame.label -side top -padx 20 -fill both 

          listbox $FRAME_FILEBOX.frame.listbox \
 	          -font [Small_Font] \
		  -exportselection false \
                  -yscrollcommand "$FRAME_FILEBOX.frame.scrollbar set"
          pack $FRAME_FILEBOX.frame.listbox -side left -fill both 

          scrollbar $FRAME_FILEBOX.frame.scrollbar -relief raised \
                    -command "$FRAME_FILEBOX.frame.listbox yview"
          pack $FRAME_FILEBOX.frame.scrollbar -side left -fill y

          global Directory_Widget
          global Selected_Directory_Index
          global Selected_Directory_Name
          global Directory

          set Directory_Widget($Array(1)) $FRAME_FILEBOX.frame.listbox

          $FRAME_FILEBOX.frame.listbox selection set 0
          set Selected_Directory_Index($Array(1)) 0
          if [string compare $Array(2) "Frame_Directory"] then {
	     global $Array(2)
             set Selected_Directory_Name($Array(1)) [subst $[subst $Array(2)]]
          } else {
             set Selected_Directory_Name($Array(1)) $Frame_Directory
          }

          bind $FRAME_FILEBOX.frame.listbox  <1> [subst {Bind_Click %W $Array(1) %y 1 $Array(4)}]

          frame $FRAME_FILEBOX.frame2 -relief raised -borderwidth 1
          pack $FRAME_FILEBOX.frame2 -side left -fill both

          label $FRAME_FILEBOX.frame2.label -text "Files" -font [Small_Font]
          pack $FRAME_FILEBOX.frame2.label -side top  

          listbox $FRAME_FILEBOX.frame2.listbox \
		  -font [Small_Font] \
	          -exportselection false \
                  -yscrollcommand "$FRAME_FILEBOX.frame2.scrollbar set"
          pack $FRAME_FILEBOX.frame2.listbox -side left

          scrollbar $FRAME_FILEBOX.frame2.scrollbar -relief raised \
                    -command "$FRAME_FILEBOX.frame2.listbox yview"
          pack $FRAME_FILEBOX.frame2.scrollbar -side left -fill y

          pack $FRAME_FILEBOX -side top

	  global File_Widget
          global Selected_File_Index
          global Selected_File_Name
          global Filter

          set File_Widget($Array(1)) $FRAME_FILEBOX.frame2.listbox
          $FRAME_FILEBOX.frame2.listbox selection set 0
          set Selected_File_Index($Array(1)) 0
          set Selected_File_Name($Array(1)) ""

          set Filter($Array(1)) $Array(3)

          Refresh_Files_Listbox $Array(1)

}

proc Refresh_Files_Listbox {Files_Listbox} {
   global Filter
   global Selected_Directory_Name
   global Directory_Widget
   global CHEMIN_ABSOLU
   global File_Widget
   set CHEMIN_ABSOLU [Chemin $Selected_Directory_Name($Files_Listbox)]
   Fill_List $Directory_Widget($Files_Listbox) \
             [List_Directories $CHEMIN_ABSOLU]

   Fill_List $File_Widget($Files_Listbox) \
             [List_Files $CHEMIN_ABSOLU/$Filter($Files_Listbox)]

}

proc List_Directories {Path} {
   if [string compare $Path /] then {
       set Dirs {..}
   } else {
       set Dirs {}
   }
   foreach Dir [glob -nocomplain $Path/*] {
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

proc Fill_List {Listbox Items_List} {
    $Listbox delete 0 [$Listbox size ] 
    foreach Item $Items_List {
       $Listbox insert [$Listbox size] $Item 
    }
}

proc Chemin {PATH} {
    set PWD [pwd]
    cd $PATH
    set RES [pwd]
    cd $PWD
    return $RES
}

proc Download_Fg  {REMOTE_FILE LOCAL_FILE} {
	global env CADP

	set HERE [pwd]
	cd $CADP(TMP_ARCHIVE)

	if ![Open $CADP(FTP_ADDRESS) anonymous "[exec sh "$CADP(INSTALL_PATH)/src/com/install_logname"]@" -mode passive] {
		cd $HERE
		return 0
	}

	set COMMAND_OK 0
	catch {set COMMAND_OK [Cd /pub/vasy/cadp]}
	if {$COMMAND_OK == 0} then {

		catch {Close}
		cd $HERE
		return 0
	}

	set COMMAND_OK 0
	catch {set COMMAND_OK [Type ascii]}
	if {$COMMAND_OK == 0} then {

		catch {Close}
		cd $HERE
		return 0
	}

	set COMMAND_OK 0
	catch {set COMMAND_OK [Get $REMOTE_FILE $LOCAL_FILE]}
	if {$COMMAND_OK == 0} then {

		catch {Close}
		cd $HERE
		return 0
	}

	catch {Close}
	cd $HERE
	return 1
}

proc Download {FILENAME} {
	global env CADP
	global DOWNLOAD_ERROR

	set HERE [pwd]
	cd $CADP(TMP_ARCHIVE)

	if ![Open $CADP(FTP_ADDRESS) anonymous "[exec sh "$CADP(INSTALL_PATH)/src/com/install_logname"]@" -mode passive -progress {Progress} -blocksize 524288] {
		cd $HERE
		set DOWNLOAD_ERROR 1
		return
	}

	Cd /pub/vasy/cadp
	Type binary
	if [Get $FILENAME $CADP(PREFIXE)$FILENAME] then {
		set DOWNLOAD_ERROR 0
	} else {
		set DOWNLOAD_ERROR 1
	}

	cd $HERE
	Close
}

proc Upload_Fg {LOCAL_FILE REMOTE_FILE} {
	global env CADP

	set HERE [pwd]
	cd $CADP(TMP_ARCHIVE)

	if ![Open $CADP(FTP_ADDRESS) anonymous "[exec sh "$CADP(INSTALL_PATH)/src/com/install_logname"]@" -mode passive] {
		cd $HERE
		return 0
	}

	Cd /incoming/vasy
	Type binary
	if [Put $LOCAL_FILE $REMOTE_FILE] then {
		set TRANSFERT_OK 1
	} else {
		set TRANSFERT_OK 0
	}

	cd $HERE
	Close
	return $TRANSFERT_OK
}

proc Trace {} {
    global CADP
    return "$CADP(TMP)/$CADP(PREFIXE)$CADP(LOG_FILE)"
}

proc Open_Trace_File {} {
    catch {exec rm -f [Trace]}
    exec echo "-------------------------------------------------------------------------------" > [Trace] 
    exec date >> [Trace]
    exec echo "-------------------------------------------------------------------------------" >> [Trace] 
    exec env >> [Trace]
    exec echo "" >> [Trace] 
}

proc Exec_Command {COMMAND} {
    global ERROR_MSG

    exec echo $COMMAND >> [Trace]

    return [expr ![catch {eval exec $COMMAND 2>> [list [Trace]]} ERROR_MSG]]
}

proc Exec_Command_Background {COMMAND} {
    global ERROR_MSG

    exec echo $COMMAND >> [Trace]

    return [expr ![catch {eval exec $COMMAND 2>> [list [Trace]] &} ERROR_MSG]]
}

proc Exec_Command_With_Result {COMMAND RESULT} {

    global ERROR_MSG

    global $RESULT

    exec echo $COMMAND >> [Trace]

    return [expr ![catch {set $RESULT [eval exec $COMMAND 2>> [list [Trace]]]} ERROR_MSG]]
}

proc Exec_Command_With_Output {COMMAND} {

    exec echo $COMMAND >> [Trace]

    return [eval exec $COMMAND 2>> [list [Trace]]] 
}

proc Run_Shell_Setup {} {
    global env CADP INSTALLATOR_STATE

    set env(CADP_NEW_PATH) "$CADP(NEW_PATH)"
    set env(CADP_TAIL_NEW_PATH) [file tail $CADP(NEW_PATH)]
    set env(CADP_TMP_ARCHIVE) "$CADP(TMP_ARCHIVE)"
    set env(CADP_OLD_DIR) "$CADP(ARCHIVE_OLD_VERSION)"
    set env(CADP_DIR) "$CADP(DIR)"
    set env(CADP_LOG_FILE) "$CADP(LOG_FILE)"
    Exec_Command [list sh -x "$CADP(TMP)/$CADP(PREFIXE)install_setup" $INSTALLATOR_STATE]
}

proc Get_Free_Space {PATH} {

    global CADP
    set LIGNE [exec sh "$CADP(INSTALL_PATH)/src/com/install_df" "$PATH"]
    set LIGNE [lindex [split $LIGNE "\n"] end]
    set TAILLE [Get_Word $LIGNE 4]
    return [expr double(round((double($TAILLE) / (1024))*10))/10]
}

proc Get_Partition {PATH} {

    global CADP
    set LIGNE [exec sh "$CADP(INSTALL_PATH)/src/com/install_df" "$PATH"]
    set LIGNE [lindex [split $LIGNE "\n"] end]
    return [Get_Word $LIGNE 6]
}

proc Same_Partition {PATH1 PATH2} {

    return [expr [string compare [Get_Partition $PATH1] [Get_Partition $PATH2]]==0]
}

proc Get_Word {TEXT NUM} {
    for {set CPT 0} {$CPT<$NUM} {incr CPT} {
	set LISTE [split [string trim $TEXT] " "]
	set TEXT [join [lrange $LISTE 1 end]]
    }
    set RESULT [lindex $LISTE 0]
    return $RESULT
}

proc Mkdir {PATH} {
    return [Exec_Command [list mkdir "$PATH"]]
}

proc Copy {SRC DEST} {
    return [Exec_Command [list cp "$SRC" "$DEST"]]
}

proc Copy_License {} {
    global CADP CADP_LICENSE_SAVE CPT env

    set CADP_LICENSE_SAVE "$env(CADP_HOME_DIR)/CADP_LICENSE"
    if [file exists $CADP_LICENSE_SAVE] then {
	for {set CPT 1; set FOUND 1} {$FOUND>0} {incr CPT} {
		set FOUND [file exists "$CADP_LICENSE_SAVE.$CPT"]
	}
	set CADP_LICENSE_SAVE "$CADP_LICENSE_SAVE.[expr $CPT - 1]"
    }
    return [Exec_Command [list cp "$CADP(TMP)/$CADP(PREFIXE)$CADP(LICENSE_MAIL)" "$CADP_LICENSE_SAVE"]]
}

proc Run_Shell {SHELL_COMMAND} {
	global Pipe

	set STATUS_COMMAND -1
	puts $Pipe "$SHELL_COMMAND"
	vwait STATUS_COMMAND

}

proc Remove_File {REMOVED_FILE} {
    return [Exec_Command [list rm -f "$REMOVED_FILE"]]
}

proc Remove {KIND PASSWD} {
    global CADP
    return [Exec_Command [list rm -f "$CADP(TMP_ARCHIVE)/CADP_${KIND}_${PASSWD}.tar.Z"]]
}

proc Remove_Dir {PATH} {
    global CADP
    Exec_Command [list sh "$CADP(INSTALL_PATH)/src/com/cadp_chmod" -Rf u+rwx "$PATH"]
    return [Exec_Command [list rm -Rf "$PATH"]]
}

proc Chmod_1 {PATH} {
    global CADP
    return [Exec_Command [list sh "$CADP(INSTALL_PATH)/src/com/cadp_chmod" -R og-w "$PATH"]]
}

proc Chmod_Writable {PATH} {
    global CADP
    return [Exec_Command [list sh "$CADP(INSTALL_PATH)/src/com/cadp_chmod" -R u+w "$PATH"]]
}

proc Chmod_2 {PATH} {
    global CADP
    return [Exec_Command [list sh "$CADP(INSTALL_PATH)/src/com/cadp_chmod" -R a+rX "$PATH"]]
}

proc Get_Help_Rfl {} {
    global CADP 

    return [Exec_Command_Background [list sh "$CADP(INSTALL_PATH)/src/com/cadp_edit" "$CADP(INSTALL_PATH)/INSTALLATION_3"]]
}

proc Get_Help_Customization {} {
    global CADP
    return [Exec_Command_With_Output [list cat "$CADP(INSTALL_PATH)/INSTALLATION_2"]]
}

proc Get_Version {VERSION_FILE} {
    global CADP
    return [Exec_Command_With_Output [list sh "$CADP(INSTALL_PATH)/src/com/install_version" "$VERSION_FILE"]]
}

proc Rfl_Get_Info {LICENSE_FILE} {
    global CADP INFO_NAME INFO_ORGANIZATION INFO_EMAIL INFO_REMINDER
    set INFO_NAME ""
    set INFO_ORGANIZATION ""
    set INFO_EMAIL ""
    set INFO_REMINDER ""

    return [expr [Exec_Command_With_Result [list sh "$CADP(INSTALL_PATH)/com/rfl" -n "$LICENSE_FILE"] INFO_NAME] && \
		[Exec_Command_With_Result [list sh "$CADP(INSTALL_PATH)/com/rfl" -a "$LICENSE_FILE"] INFO_ORGANIZATION] && \
		[Exec_Command_With_Result [list sh "$CADP(INSTALL_PATH)/com/rfl" -e "$LICENSE_FILE"] INFO_EMAIL] && \
		[Exec_Command_With_Result [list sh "$CADP(INSTALL_PATH)/com/rfl" -r "$LICENSE_FILE"] INFO_REMINDER]]
}

proc RFL_List {LICENSE_FILE} {
    global CADP tmp
    if [Exec_Command_With_Result [list sh "$CADP(INSTALL_PATH)/com/rfl" -l "$LICENSE_FILE"] tmp] then {
	return $tmp
    } else {
        return "" 
    }
}

proc Make_File {TEXT_FILE TEXT} {
    Remove_File $TEXT_FILE
    set File [open $TEXT_FILE w+]
    puts $File $TEXT
    close $File
    return 1
}

proc Mail_to_CADP_Team {SMTP_SERVER FROM} {
   global CADP

   set RESULT1 [Exec_Command_With_Output [list \
			sh "$CADP(INSTALL_PATH)/src/com/cadp_mail" \
			-verbose \
			-send $SMTP_SERVER $FROM \
			"$CADP(TMP)/$CADP(PREFIXE)$CADP(LICENSE_MAIL)" \
			$CADP(E_MAIL_ADDRESS) RFL \
			]]

   if [string match $FROM "-"] {
      set FROM [exec sh "$CADP(INSTALL_PATH)/src/com/install_logname"]
   }

   set RESULT2 [Exec_Command_With_Output [list \
			sh "$CADP(INSTALL_PATH)/src/com/cadp_mail" \
			-verbose \
			-send $SMTP_SERVER $FROM \
			"$CADP(TMP)/$CADP(PREFIXE)$CADP(LICENSE_MAIL)" \
			$FROM RFL \
			]]

   return "$RESULT1"
}

proc Path {PATH LNG} {
    set LONGUEUR [string length $PATH]
    if [expr $LONGUEUR > $LNG] {
	return "...[string range $PATH [expr $LONGUEUR - [expr $LNG - 3] ] end]"
    }
    return $PATH
}

proc Temporary_Installation_Directory {} {
    global CADP

    return "new.$CADP(LATEST_NUM_VERSION)"
}

proc Date_Compare {VERSION1 VERSION2} {
    global CADP
    set DATE1 [exec echo "$VERSION1" \| sh "$CADP(INSTALL_PATH)/src/com/cadp_tail" -n 1]
    set DATE2 [exec echo "$VERSION2" \| sh "$CADP(INSTALL_PATH)/src/com/cadp_tail" -n 1]
    return [expr [string compare $DATE1 $DATE2]==0]
}

proc existe_CADP {} {
    global env
    global CADP

    if {$CADP(OLD_PATH) != ""} {

        set CADP(EXISTE) 1
        return 1
    }

    if {[array get env "CADP"] == ""} then {

       set CADP(EXISTE) 0
       return 0
    } 

    set CADP_PATHNAME [exec sh "$CADP(INSTALL_PATH)/src/com/cadp_path" "-winpath" $env(CADP)]

    if [verifier_CADP $CADP_PATHNAME] then {
        set CADP(OLD_PATH) $CADP_PATHNAME
        set CADP(EXISTE) 1
        return 1
    } else {
        set CADP(EXISTE) 0
        return 0
    }
}

proc verifier_CADP {directory} {
    global CADP 

    set CADP_FOUND [exec sh "$CADP(INSTALL_PATH)/src/com/cadp_path" "-check_release" "$directory"]

    if {$CADP_FOUND == 1} then {
       return 1
    } else {
       return 0
    }
}

proc Search_Bis {STARTDIR} {
    global CADP

    set PWD [pwd]
    Add_Text "Searching: $STARTDIR \n"
    update ; update idletasks

    if [catch {cd $STARTDIR} err] {
	return
    }

    if [verifier_CADP [pwd]] then {

	set CADP(OLD_PATH) [pwd]
	set CADP(EXISTE) 1
	return
    }

    foreach FILENAME [glob -nocomplain *] {

	if ![catch {set TEST [expr [file isdirectory $FILENAME] \
				 && [file readable $FILENAME]]}] \
	    then {
		if $TEST then {
		    Search_Bis $STARTDIR/$FILENAME
		}
	    }
    }
    cd $PWD
}

proc Compte_Ligne {FILENAME} {
    set File_Id [open $FILENAME r]
    set NUM [expr [llength [split [read $File_Id] "\n"]] - 1]
    return $NUM
}

proc Traitement_CURRENT_VERSION {} {
    global ARCHI env CADP

    set FILENAME $CADP(TMP)/$CADP(PREFIXE)$CADP(FILE_VERSION)

    set HEADER 2

    set NB_LIGNES [Compte_Ligne $FILENAME]
    incr NB_LIGNES -$HEADER

    set TAIL [split [exec sh "$CADP(INSTALL_PATH)/src/com/cadp_tail" -n $NB_LIGNES "$FILENAME"] "\n"]
    set ARCHI(CODE) {} 

    foreach ARCHI_LINE $TAIL {

	set ARCHI_LIST [split $ARCHI_LINE " "]

	set CODE [lindex $ARCHI_LIST 0] 

	set ARCHI(CODE) [lappend ARCHI(CODE) $CODE]

	set ARCHI(SIZE_$CODE) [lindex $ARCHI_LIST 1]

	set ARCHI(NORMAL_SIZE_$CODE) [lindex $ARCHI_LIST 2]

	set ARCHI(NAME_$CODE) \
	    [join [lrange $ARCHI_LIST 3 [expr [llength $ARCHI_LIST] - 1]] " "]

	if {[string match $env(CADP_ARCH32) $CODE]} {
	    set ARCHI(TRUE_$CODE) 1
        } elseif {[string match $env(CADP_ARCH64) $CODE]} {
	    set ARCHI(TRUE_$CODE) 1
        } else {
	    set ARCHI(TRUE_$CODE) 0
        }

	set ARCHI(TRUE_base) 1
    }

    set CADP(LATEST_VERSION) [Get_Version $CADP(TMP)/$CADP(PREFIXE)$CADP(FILE_VERSION)]
    set CADP(LATEST_NUM_VERSION) [lindex [split [string trim $CADP(LATEST_VERSION)] " \n"] 1]

    if $CADP(EXISTE) then {
	return [Date_Compare $CADP(YOUR_VERSION) $CADP(LATEST_VERSION)]
    }

    return 0
}

proc Cadp_Available_With_Arch_And_Version {} {
    global ARCHI env

    if {[lsearch -exact $ARCHI(CODE) $env(CADP_ARCH32)] == -1} {
	return 0;
    } elseif {[lsearch -exact $ARCHI(CODE) $env(CADP_ARCH64)] == -1} {
	return 0;
    } else {
	return 1;
    }
}

proc Check_Path {PATH} {
    global CADP

    if {$PATH == ""} then {
       Message_Error "ERROR: Empty directory name:\n$PATH" NO_MSG
       tkwait window .errorwindow
       return 0
    }
    if ![file isdirectory [file dirname $PATH]] then {
       Message_Error "ERROR: Invalid directory name:\n$PATH" NO_MSG
       tkwait window .errorwindow
       return 0
    }
    if [file isdirectory $PATH] then {

	if ![file writable $PATH] then {
	    Message_Error "ERROR: Cannot write in directory:\n$PATH" NO_MSG
	    tkwait window .errorwindow
	    return 0
	} 
    } else {
	    if ![Mkdir $PATH] then {
		Message_Error "ERROR: Cannot create directory:\n$PATH" NO_MSG
		tkwait window .errorwindow
		return 0
	    }
    }

    set TEST [exec sh "$CADP(INSTALL_PATH)/src/com/cadp_ln" -check "$PATH"]
    if {$TEST != 0} {
        Message_Error "ERROR: Cannot create symbolic link in directory:\n$PATH\n(possibly located on a FAT or NTFS file system?)" NO_MSG
        tkwait window .errorwindow
        return 0
     }

     return 1
}

proc Put_Lines {NUM} {
    set AUX ""
    for {set CPT 0} {$CPT<$NUM} {incr CPT} {
	set AUX $AUX\n
    }
    return $AUX
}

proc Ligne_Vide {} {

    return {}
}

proc Texte {TITLE} {
    global env CADP FROM_LABEL SMTP_LABEL CADP_LICENSE_SAVE
    switch $TITLE {
	Start {
	    return {\n\n\n\n\n\n Welcome to the CADP Installation Assistant.\n\nThis software will help you to install or to upgrade the CADP software on your machine(s).\n\n\n\n\nATTENTION: Use of the CADP software is subject to the terms and conditions defined in the CADP software agreement. You should not use the CADP software until you have made sure that your Company, Institute, Organization, or University has signed the CADP software agreement and been granted the right to use CADP. By pressing the Next button, you signify that you have read the CADP software agreement and accept its terms and conditions.}
	}
	Latest_Version {
	    if {$CADP(DISTRIBUTION_KIND) == "stable"} then {
	        return {\n\nThe latest stable version of CADP is:}
	    } else {
	        return {\n\nThe latest beta version of CADP is:}
	    }
	}
	Already {
	    return {is already installed on this machine in directory:\n  $CADP(OLD_PATH) \n\n Checking for information about the latest version available... \n(This can take a few seconds)}
	}
	Up_to_date {
	    return { Your version of CADP is up to date \n \Do you want to reinstall it nevertheless?}
	}
	Newer_Version {
	    if {$CADP(DISTRIBUTION_KIND) == "stable"} then {
	        return {There is a newer version available:}
	    } else {
	        return {There is a beta version available:}
	    }
	}
	Ever_Installed {
	    return {\n\n\n\n\n\n\nHas CADP ever been installed on this machine?\n}
	}
	Not_Available {
	    if {$CADP(DISTRIBUTION_KIND) == "stable"} then {
	        return {\n(No stable version of CADP available for this machine architecture)\n}
	    } else {
	        return {\n(No beta version of CADP available for this machine architecture)\n}
	    }
	}
	Inst_Yes {
	    return {Yes, CADP is installed in the following directory:}
	}
	Inst_Scan {
	    return {May be, scan the disk from the following directory:}
	}
	Inst_No {
	    return {No, CADP has never been installed on this machine.}
	}
	Look_Instead {
	    if {$CADP(DISTRIBUTION_KIND) == "stable"} then {

	        return {Look instead for a beta version}
	    } else {

	        return {Look instead for a stable version}
	    }
	}
	Not_Enough_Space_for_CADP {
	    return {Sorry! There is not enough disk space to install CADP.\n\n\
		Available space on $CADP(NEW_PATH): $FREE_SPACE_FOR_CADP MB ($REQUIRED_SPACE_FOR_CADP MB required)\n\n\
		Remove some files, or press Previous and select another directory to install CADP}
	}
	Not_Enough_Space_for_TMP {
	    return {Sorry! There is not enough disk space to install CADP.\n\n\
		Available space on $CADP(TMP_ARCHIVE): $FREE_SPACE_FOR_TMP MB ($REQUIRED_SPACE_FOR_TMP MB required)\n\n\
		Remove some files in $CADP(TMP_ARCHIVE), or press Previous and select another directory to store temporary files}
	}
	Permission_Denied {
	    return {Installator cannot update directory:\n$CADP(NEW_PATH)\n}
	}
	Locked_Directory_Error {
	    return {ERROR: Installator cannot update directory:\n$CADP(NEW_PATH).\nThis directory seems to be locked by Windows, either because a program contained in this directory is running, or because a running program is using the contents of this directory.\n\nYou should try to quit any running program located in this directory or using its contents, and then choose \"Retry\".\n}
	}
	Path_Error {
	    return {\n   ERROR: CADP was not found in directory\n$CADP(GIVEN_PATH) \n}
	}
	Ftp_Error {
	    return {\nError during FTP.\n\nCheck whether this machine is allowed to download files from $CADP(FTP_ADDRESS) using the FTP protocol. If it is not the case, cancel the installation and install CADP from another machine.}
	}
	Decompress_Error {
	    return {Error during archive extraction.\n\nThe \"tar\" and/or \"uncompress/gunzip\" commands generated unexpected error messages, which are displayed at the bottom of the blue scrolling window.\n\nPlease report these messages to $CADP(E_MAIL_ADDRESS) unless you believe it is a problem strictly related to your local machine (such as a disk quota overflow).\n\nIf you believe that these messages can be safely ignored, press the \"Next\" button to continue the installation.\nOtherwise, press \"Retry\" or \"Cancel\".}
	}
	Rfl_Error {
	    return {There was an error during the RFL (Request For License).}
	}
	Scan_Found {
	    return {CADP has been found. Press Next}
	}
	Scan_Not_Found {
	    return {CADP has not been found. Press Previous}
	}
	Enter_Pass {
	    return {\n\n\n\n\n\n\nEnter your CADP password:\n}
	}
	Wait {
	    return {\n\nVerifying the password. This may take a few seconds...}
	}
	Sending_Mail {
	    return {\n\n\n\n\nYour prototype license file will be sent by e-mail to $CADP(E_MAIL_ADDRESS).\n\nA copy of this prototype will also be sent to you for information.\n\nIn reply, you will soon receive a valid license file, returned to the e-mail address below.\n}
	}
	No_Unix_Sendmail_daemon {
	    return {\n\n\n\n\nYour prototype license file cannot be sent by e-mail from this machine: the 'sendmail' daemon is not running.\n\nThe prototype license file was saved in $CADP_LICENSE_SAVE\n\nFinish the installation and send the prototype license to $CADP(E_MAIL_ADDRESS) from another machine}
	}
	License_Prototype_Saved {
	    return {\n\n\n\n\nYour prototype license file was saved in $CADP_LICENSE_SAVE\n\nFinish the installation and send by e-mail the prototype license to $CADP(E_MAIL_ADDRESS)}
	}
	Win32_Mail_Failed {
	    return {\n\nCannot send e-mail.\n\nThe prototype license file was saved in $CADP_LICENSE_SAVE.\n\nPress Previous to go back, correct the '$FROM_LABEL' and/or the '$SMTP_LABEL' fields, and try again.\n\nIf the problem persists, continue the installation and send later the prototype license to $CADP(E_MAIL_ADDRESS) from another machine.}
	}
	Unix_Mail_Failed {
		return {\n\nCannot send e-mail.\n\nThe prototype license file was saved in $CADP_LICENSE_SAVE.\n\nPress Previous to go back, attempt to correct the '$FROM_LABEL', and try again.\n\nIf the problem persists, continue the installation and send later the prototype license to $CADP(E_MAIL_ADDRESS) from another machine.}  
	}
	Wrong_Pass {
	    return {\n ERROR: Wrong password!\n}
	}
	Upgrade {
	    return {\n\n\n\n\n\n Installator will update the contents of directory:\n$CADP(NEW_PATH)  \n}
	}
	During {
	    return {During the installation:}
	}
	Sauvegarde {
	    return {1- Your current version of CADP will be saved in directory $CADP(NEW_PATH)/$CADP(ARCHIVE_OLD_VERSION)}
	}
	Temp_Dir {
	    return {\n\n\nDuring the installation, temporary files will be stored in directory:}
	}
	Select_New {
	    return {Select path for the new version}
	}
	Select_Old {
	    return {Select path to move old version}
	}
	Select_Tmp {
	    return {Select path for temporary directory}
	}
	Check_Info {
	    return {\n\n\n\n\n Checking for information about the latest version available... \n(This may take a few seconds)}
	}
	Ask_Path {
	    return {\n\n\n\n\n\n In which directory do you want to install CADP\n\n}
	}
	Select_Archi {
	    return {\n Select the desired architecture(s):\n (several architectures can be selected simultaneously)\n}
	}
	Extract {
	    return {Extracting files from archive CADP_${KIND}_$CADP(PASSWD).tar.Z\n}
	}
	Uncompressed {
	    return {CADP_${KIND} uncompressed and untared.\n}
	}
	Adjust {
	    return {Adjusting installed files.\n}
	}
	Deleted {
	    return {Archive CADP_${KIND} deleted.\n[Ligne_Vide]\n}
	}
	Set_Group {
	    return {Setting permission modes in the CADP directory. Please wait...\n}
	}
	Group_Set_Ok {
	    return {Permission modes have been set successfully.\n}
	}
	Rfl_Instructions1 {
	    return {For remote connection from \"$env(LOCAL_HOST)\" to these machines, use:}
	}
	Rfl_Instructions2 {
	    return {\nOn all these machines, the CADP software should be located in the following directory (do not alter this directory unless necessary):}
	}
	Host_Empty {
	    return {\nHost list empty}
	}
	Exec_Rfl{ 
	    return {Execute RFL\n[Ligne_Vide]\n}
	}
	Rfl_Done { 
	    return {Your prototype license file is ready. Press Next to continue.}
	}
	Ask_Quit {
	    return {\n The installation of CADP is not complete.\n\nWhen quitting Installator now:}
	}
	Ask_Quit2 {
	    return {\nDo you really want to abort the installation?}
	}
	Ask_Info {
	    return {\nPlease enter the required information for the license.\n}
	}
	Select_License_Transfer_Method {
	    return {\nPlease select a method to send your CADP license request.\n\n}
	}
	Upload_License_Prototype_Failed {
	    return {\n\n\nUnable to upload your CADP license prototype on $CADP(FTP_ADDRESS).\n You can either retry (using the \"Retry\" button)\nor try another method (using the \"Previous\" button).}
	}
	Upload_License_Prototype {
	    return {\n\n\nUploading your CADP license prototype on $CADP(FTP_ADDRESS)...\n}
	}
	Sent_License_Prototype {
	    return {\n\n\nYour license prototype was sent.\nYou should receive soon (within a few days) a valid license file from the CADP team sent to you by e-mail. Otherwise, contact cadp@inria.fr.\n\nPress Next to continue.}
	}
    }
}

proc Start {} {

    global CADP

    Init_Procedure NORMAL Start__Next Start "" "A"
    Message left Accueil [subst [Texte Start]]

    Open_Trace_File

    Remove_File $CADP(TMP)/$CADP(PREFIXE)install_setup
    Copy $CADP(INSTALL_PATH)/src/com/install_setup $CADP(TMP)/$CADP(PREFIXE)install_setup

    set CADP(RUN_INSTALL) 0

    Enable_Next
}

proc Start__Next {} {
    if {[existe_CADP]} then {
	CADP_found
    } else {
	CADP_not_found
    }
}

proc Switch_Version {CADP_FOUND} {
    global CADP
    if {$CADP(DISTRIBUTION_KIND) == "stable"} then {

        set CADP(DISTRIBUTION_KIND) "beta"
    } else {

        set CADP(DISTRIBUTION_KIND) "stable"
    }
    Set_Version_Specific_Variables

    set CADP(IS_DOWNLOAD_VERSION) 0

    if [expr $CADP_FOUND] {
	CADP_found
    } else {
	Install_CADP
    }
}

proc CADP_found {} {
    global CADP OPTION
    global Version_Color

    Init_Procedure RETRY CADP_found__next Start CADP_found "C"
    Disable_Retry

    set CADP(YOUR_VERSION) [Get_Version $CADP(OLD_PATH)/VERSION]
    set CADP(YOUR_NUM_VERSION) [lindex [split [string trim $CADP(YOUR_VERSION)] " \n"] 1]
    set CADP(ARCHIVE_OLD_VERSION) old.$CADP(YOUR_NUM_VERSION)

    Message center Lines [Put_Lines 1]
    Message center Your_Version "CADP $CADP(YOUR_VERSION)"
    [Main_Frame].message_Your_Version configure -foreground $Version_Color
    Message center Accueil [subst [Texte Already]]

    set CADP(NEW_PATH) $CADP(OLD_PATH)

    . config -cursor {watch}

    if ![expr $CADP(IS_DOWNLOAD_VERSION)] then {
	if ![Download_Fg $CADP(FTP_FILE_VERSION) $CADP(PREFIXE)$CADP(FILE_VERSION)] then {
	    . config -cursor {top_left_arrow}

	    Message center Error [subst [Texte Ftp_Error]] 
	    Enable_Retry
	    return
	}
	set CADP(IS_DOWNLOAD_VERSION) 1
    }

    set FRAME [frame [Main_Frame].f]
    set CHOIX_1 [frame $FRAME.c1]
    set CHOIX_2 [frame $FRAME.c2]

    if [Traitement_CURRENT_VERSION] then {
	Message center Update [subst [Texte Up_to_date]]
	Make_Radio $CHOIX_1.keep "No, keep the existing version." left "KEEP" OPTION(INSTALL)
	$CHOIX_1.keep select
	Make_Radio $CHOIX_2.install "Yes, reinstall it." left "INSTALL" OPTION(INSTALL)	
    } else {	
	Message center Update [subst [Texte Newer_Version]]
	Message center Version "CADP $CADP(LATEST_VERSION)"
	[Main_Frame].message_Version configure -foreground $Version_Color
	if {! [Cadp_Available_With_Arch_And_Version]} {
	    Message center Warning [subst [Texte Not_Available]]
	}
	Message center Install "Do you want to install it?"
	
	Make_Radio $CHOIX_1.upgrade "Yes, upgrade to the new version." left "INSTALL" OPTION(INSTALL)
	$CHOIX_1.upgrade select
	Make_Radio $CHOIX_2.keep "No, keep the existing version unchanged." left "KEEP" OPTION(INSTALL)
    }

    Message center Vspace ""
    set BUTTON [frame [Main_Frame].b]
    Make_Button $BUTTON.switch [Texte Look_Instead] bottom {Switch_Version 1}

    . config -cursor {top_left_arrow}
    pack $CHOIX_1 $CHOIX_2 -side top -fill x
    pack configure [Main_Frame].message_Vspace -after $CHOIX_2
    pack $FRAME $BUTTON -side top
    Enable_Next;Enable_Previous
}

proc CADP_found__next {} {
    global OPTION CADP

    if [file exists  $CADP(OLD_PATH)/LICENSE] then {

	Copy $CADP(OLD_PATH)/LICENSE $CADP(TMP)/$CADP(PREFIXE)$CADP(LICENSE_OLD)

	Rfl_Get_Info $CADP(TMP)/$CADP(PREFIXE)$CADP(LICENSE_OLD)

	set CADP(HOSTS) [RFL_List $CADP(TMP)/$CADP(PREFIXE)$CADP(LICENSE_OLD)]
    }    

    set CADP(DIR) $CADP(NEW_PATH)
    if {$OPTION(INSTALL) == "KEEP"} then {
	Check_Old_License
    } else {
	Ask_Passwd
    }
}

proc CADP_not_found {} {   
    global CADP PARAM
    global FRAME_GIVEN
    global FRAME_SEARCH

    Init_Procedure NORMAL CADP_not_found__next Start "" "B"

    Message center Accueil [subst [Texte Ever_Installed]]

    set FRAME_GLOBAL [frame [Main_Frame].f1]
    set FRAME_GIVEN [frame $FRAME_GLOBAL.f11]
    set FRAME_GIVEN_TEXT [frame $FRAME_GIVEN.txt]
    set FRAME_GIVEN_PATH [frame $FRAME_GIVEN.p]
    set FRAME_SEARCH [frame $FRAME_GLOBAL.f12]
    set FRAME_SEARCH_TEXT [frame $FRAME_SEARCH.txt]
    set FRAME_SEARCH_PATH [frame $FRAME_SEARCH.p]
    set FRAME_NON [frame $FRAME_GLOBAL.f13]
    set FRAME_NON_TEXT [frame $FRAME_GLOBAL.f13.txt]

    Make_Radio $FRAME_GIVEN_TEXT.oui [subst [Texte Inst_Yes]] left INSTALLED PARAM(CADP_STATUS)
    pack $FRAME_GIVEN_TEXT -side top -fill x

    Make_Button $FRAME_GIVEN_PATH.browse1 "Browse" right {Browse_Path GIVEN_PATH "Select new directory"} 
    Make_Entry $FRAME_GIVEN_PATH.chemin CADP(GIVEN_PATH) 30 right
    bind $FRAME_GIVEN_PATH.chemin  <Key-Return> {Invoke_Next}
    pack $FRAME_GIVEN_PATH -side top -expand true 

    Make_Radio $FRAME_SEARCH_TEXT.search [subst [Texte Inst_Scan]] left SEARCH PARAM(CADP_STATUS)
    pack $FRAME_SEARCH_TEXT -side top -fill x

    Make_Button $FRAME_SEARCH_PATH.browse2 "Browse" right {Browse_Path SEARCH_PATH "Select directory"}
    Make_Entry $FRAME_SEARCH_PATH.init_search CADP(SEARCH_PATH) 30 right 
    bind $FRAME_SEARCH_PATH.init_search  <Key-Return> {Invoke_Next}
    pack $FRAME_SEARCH_PATH -side top -expand true

    Make_Radio $FRAME_NON_TEXT.non [subst [Texte Inst_No]] left NOT_INSTALLED PARAM(CADP_STATUS)
    pack $FRAME_NON_TEXT -side top -fill x

    pack $FRAME_NON $FRAME_GIVEN $FRAME_SEARCH -side top -fill x
    pack $FRAME_GLOBAL -side top 

    Enable_Next;Enable_Previous
}

proc CADP_not_found__next {} {
    global PARAM CADP

    switch $PARAM(CADP_STATUS) {
	INSTALLED {

	    if [verifier_CADP $CADP(GIVEN_PATH)] then {
	        set CADP(EXISTE) 1
		set CADP(OLD_PATH) $CADP(GIVEN_PATH)
		CADP_found
	    } else {
                set CADP(EXISTE) 0
		Message_Error [subst [Texte Path_Error]] NO_MSG
	    }
	}
	SEARCH {

	    Search_CADP		    
	}
	NOT_INSTALLED {

	    set CADP(EXISTE) 0
	    Install_CADP
	}
    }    
}   

proc Search_CADP {} {
    global CADP

    Init_Procedure NORMAL CADP_found "" "" "SRCH"

    Message center Search " Searching Cadp \n"
    Make_Text [Main_Frame].frame "" 80 15 normal
    update ; update idletasks

    Search_Bis $CADP(SEARCH_PATH)

    if $CADP(EXISTE) then {
	Enable_Next
	Enable_Previous
	Make_Label [Main_Frame].message_End bottom [subst [Texte Scan_Found]]
    } else {
	Enable_Previous
	Make_Label [Main_Frame].message_End bottom [subst [Texte Scan_Not_Found]]
    } 
}

proc Ask_Passwd {} {
    global CADP
    Init_Procedure NORMAL Ask_Passwd__Next Ask_Passwd "" "PASS"

    Message center Pass [subst [Texte Enter_Pass]]

    Make_Entry [Main_Frame].pass CADP(PASSWD) 13 top
    focus [Main_Frame].pass
    bind [Main_Frame].pass <Key-Return> {Ask_Passwd__Next}

    Message center Rem ""
    Message center Status ""
    Enable_Next;Enable_Previous
}

proc Ask_Passwd__Next {} {
    global CADP

    Change_Message Rem [subst [Texte Wait]]
    . config -cursor {watch}
    Disable_Previous;Disable_Next
    [Main_Frame].pass configure -state disabled

    set CADP(PASSWD) [string trim $CADP(PASSWD)]
    if ![expr $CADP(IS_DOWNLOAD_TEST)] then {
	if ![Download_Fg "$CADP(TEST)$CADP(PASSWD)" "$CADP(PREFIXE)$CADP(TEST)$CADP(PASSWD)"] then {
	    . config -cursor {top_left_arrow}
	    [Main_Frame].pass configure -state normal
	    Enable_Previous;Enable_Next
	    Message_Error [subst [Texte Wrong_Pass]] NO_MSG
	    return
	}
	set CADP(IS_DOWNLOAD_TEST) 1
    }
	
    . config -cursor {top_left_arrow}

    if $CADP(EXISTE) then {
	Update_CADP
    } else {
	Ask_Path
    }
}

proc Update_CADP {} {
    global CADP OPTION

    global FRAME_RM_AFTER_PATH FRAME_ARCHIVE_PATH

    Init_Procedure NORMAL Check_Update Update_CADP "" "UPDT"

    Message center Install [subst [Texte Upgrade]]

    set FRAME_GLOBAL [frame [Main_Frame].fg]
    set FRAME_PHRASE [frame $FRAME_GLOBAL.ph]

    set FRAME_RM_AFTER [frame $FRAME_GLOBAL.rmafter]
    Make_Radio $FRAME_RM_AFTER.rmafter "Remove old version after successful installation" left RM_AFTER OPTION(SAUVE)
    $FRAME_RM_AFTER.rmafter select

    set FRAME_KEEP [frame $FRAME_GLOBAL.keep]
    Make_Radio $FRAME_KEEP.keep "Keep old version in [Path $CADP(NEW_PATH)/$CADP(ARCHIVE_OLD_VERSION) 25] after installation" left KEEP OPTION(SAUVE)

    set FRAME_ARCHIVE [frame $FRAME_GLOBAL.f_arc]
    Make_Label $FRAME_ARCHIVE.radio left [subst [Texte Temp_Dir]] 

    set FRAME_ARCHIVE_PATH [frame $FRAME_GLOBAL.f_arc_path]
    Make_Button $FRAME_ARCHIVE_PATH.browse "Browse" right {Browse_Path TMP_ARCHIVE "Select path for temporary files"}  
    Make_Entry $FRAME_ARCHIVE_PATH.path CADP(TMP_ARCHIVE) 35 right

    pack $FRAME_PHRASE $FRAME_RM_AFTER $FRAME_KEEP $FRAME_ARCHIVE \
	$FRAME_ARCHIVE_PATH -side top -fill x

    pack $FRAME_GLOBAL -side top

    Enable_Next;Enable_Previous
}

proc Check_Update {} {

    global CADP OPTION
    if $CADP(EXISTE) then {
        set ABSOLUTE_TMP_PATH [exec sh "$CADP(INSTALL_PATH)/src/com/cadp_path" "-absolute" $CADP(TMP_ARCHIVE)]
	if {$ABSOLUTE_TMP_PATH == 0} then {
	    Message_Error "ERROR: Enter an absolute pathname for the directory of temporary files" NO_MSG
	    return
	}
    }

    if ![Check_Path $CADP(TMP_ARCHIVE)] then {return}

    if ![file writable $CADP(NEW_PATH)] then {

	Affiche_Message_Box
	tkwait window .chmodwindow
	if [string match $OPTION(CHANGE) CHANGE] then {
	    if ![Chmod_Writable $CADP(NEW_PATH)] then {
		Message_Error "ERROR: Cannot change permission mode" NO_MSG
		tkwait window .errorwindow
	    }
	    Check_Update
	    return
	} else {
	    Ask_Path
	    return
	}
    }

    if ![Check_Path $CADP(NEW_PATH)] then {return}

    Check_Install_Dir_Unlocked

    set CADP(DIR) $CADP(NEW_PATH)

    Demande_Archi 
}

proc Check_Install_Path {} {
    global CADP

    if ![Check_Path $CADP(TMP_ARCHIVE)] then {return}

    if ![Check_Path $CADP(NEW_PATH)] then {return}

    if ![string match [exec ls $CADP(NEW_PATH)] ""] then {
	Message_Error "ERROR: Directory is not empty\n$CADP(NEW_PATH)" NO_MSG
	return
    }

    Check_Install_Dir_Unlocked

    set CADP(DIR) $CADP(NEW_PATH)

    Demande_Archi 
} 

proc Affiche_Message_Box {} {
    global OPTION CADP

    if [catch {set FILE_WINDOW [toplevel .chmodwindow]} err] then {
	return 0
    }
    wm title .chmodwindow "Overwrite?"
    wm geometry .chmodwindow +[expr [winfo x .] + 100]+[expr [winfo y .] + 80]
    grab set .chmodwindow 

    Make_Label .chmodwindow.txt top [subst [Texte Permission_Denied]]

    set FRAME [frame .chmodwindow.f]
    set FRAME_CHMOD [frame $FRAME.chmod]
    Make_Radio $FRAME_CHMOD.chmod "Change permissions mode of the directory (recommended)." left CHANGE OPTION(CHANGE)
    set FRAME_INSTALL [frame $FRAME.install]
    Make_Radio $FRAME_INSTALL.install "Install CADP in another directory." left INSTALL OPTION(CHANGE)
    $FRAME_CHMOD.chmod select

    pack $FRAME_CHMOD $FRAME_INSTALL -side top -fill x -expand true
    pack $FRAME -side top

    Make_Button .chmodwindow.ok "Ok" bottom {destroy .chmodwindow}
} 

proc Affiche_Message_Directory_Locked {} {
    global OPTION CADP

    if [catch {set FILE_WINDOW [toplevel .lockedDirWindow]} err] then {
	return 0
    }
    wm title .lockedDirWindow "Directory Locked"
    wm geometry .lockedDirWindow +[expr [winfo x .] + 100]+[expr [winfo y .] + 80]
    grab set .lockedDirWindow 

    Make_Label .lockedDirWindow.txt top [subst [Texte Locked_Directory_Error]]

    set FRAME [frame .lockedDirWindow.f]
    set FRAME_RETRY [frame $FRAME.retry]
    Make_Radio $FRAME_RETRY.retry "Retry." left RETRY OPTION(DIR_LOCKED)
    set FRAME_CANCEL [frame $FRAME.cancel]
    Make_Radio $FRAME_CANCEL.cancel "Cancel CADP installation." left CANCEL OPTION(DIR_LOCKED)
    $FRAME_RETRY.retry select

    pack $FRAME_RETRY $FRAME_CANCEL -side top -fill x -expand true
    pack $FRAME -side top

    Make_Button .lockedDirWindow.ok "Ok" bottom {destroy .lockedDirWindow}
} 

proc Check_Install_Dir_Unlocked {} {
    global CADP STATUS_COMMAND OPTION

    set LIGNE [exec sh -c "CADP=\"$CADP(INSTALL_PATH)\"; export CADP; \"$CADP(INSTALL_PATH)\"/src/com/install_lock \"$CADP(NEW_PATH)\"" ]

    if {[string match $LIGNE "END_SHELL_1"]} then {

	Affiche_Message_Directory_Locked
	tkwait window .lockedDirWindow
	if [string match $OPTION(DIR_LOCKED) CANCEL] {
	    set CANCEL_INSTALL 1
	    Ask_Quit
	    tkwait window .quitwindow
	}

	Check_Install_Dir_Unlocked
    } else {

	return
    }
}

proc Install_CADP {} {
    global CADP OPTION
    global Version_Color

    set OPTION(SAUVE) NOT_TOUCH
    set CADP(EXISTE) 0

    Init_Procedure RETRY Install_CADP__Next Install_CADP Install_CADP "INST"
    Disable_Retry
    Message center Accueil [subst [Texte Check_Info]]

    . config -cursor {watch}

    if ![expr $CADP(IS_DOWNLOAD_VERSION)] then {
	if ![Download_Fg $CADP(FTP_FILE_VERSION) $CADP(PREFIXE)$CADP(FILE_VERSION)] then {
	    . config -cursor {top_left_arrow}

	    Message center Error [subst [Texte Ftp_Error]] 
	    Enable_Retry;Enable_Previous
	    return
	}
	set CADP(IS_DOWNLOAD_VERSION) 1
    }

    . config -cursor {top_left_arrow}
    set FRAME [frame [Main_Frame].f]
    set CHOIX_1 [frame $FRAME.c1]
    set CHOIX_2 [frame $FRAME.c2]

    Traitement_CURRENT_VERSION 
    Message center Update [subst [Texte Latest_Version]]
    Message center Version $CADP(LATEST_VERSION)
    [Main_Frame].message_Version configure -foreground $Version_Color
    if {! [Cadp_Available_With_Arch_And_Version]} {
	Message center Warning [subst [Texte Not_Available]]
    }
    Message center Install "\nDo you want to install it ?"

    Make_Radio $CHOIX_1.install "Yes " left "INSTALL" OPTION(INSTALL)
    $CHOIX_1.install select
    Make_Radio $CHOIX_2.stop "No " left "STOP" OPTION(INSTALL)	

    Message center Vspace ""
    set BUTTON [frame [Main_Frame].b]
    Make_Button $BUTTON.switch [Texte Look_Instead] bottom {Switch_Version 0}

    pack $CHOIX_1 $CHOIX_2 -side top -fill x
    pack configure [Main_Frame].message_Vspace -after $CHOIX_2
    pack $FRAME $BUTTON -side top

    Enable_Next;Enable_Previous
}

proc Install_CADP__Next {} {
    global OPTION
    switch $OPTION(INSTALL) {
	INSTALL {Ask_Passwd}
	STOP {Ask_Quit}
    }
}

proc Ask_Path {} {

    global CADP OPTION
    set CADP(EXISTE) 0
    set OPTION(SAUVE) NOT_TOUCH

    Init_Procedure NORMAL Check_Install_Path Ask_Path  "" "INST2"
    Message center Install [subst [Texte Ask_Path]]

    set FRAME_GLOBAL [frame [Main_Frame].fg]
    set FRAME [frame $FRAME_GLOBAL.f1]
    Make_Label $FRAME.label_new left "Install in:"
    Make_Button $FRAME.browse "Browse" right {Browse_Path NEW_PATH "Select path for installation"}
    if [expr ![string compare $CADP(NEW_PATH) ""]] then {
       set CADP(NEW_PATH) $CADP(DEFAULT_INSTALLATION_PATH)
    }
    Make_Entry $FRAME.chemin CADP(NEW_PATH) 35 right

    set FRAME2 [frame $FRAME_GLOBAL.f2]
    Make_Label $FRAME2.label_new left "\n\n\n\n\nDuring installation temporary files will be stored in:"
    set FRAME3 [frame $FRAME_GLOBAL.f3]
    Make_Button $FRAME3.browse "Browse" right {Browse_Path TMP_ARCHIVE "Select path for installation"}
    Make_Entry $FRAME3.chemin CADP(TMP_ARCHIVE) 35 right

    pack $FRAME $FRAME2 $FRAME3 -side top -fill x
    pack $FRAME_GLOBAL -side top

    Enable_Next;Enable_Previous
}

proc Demande_Archi {} {

    global ARCHI CADP
    global FRAME_TMP FRAME_CADP
    set CADP(RUN_INSTALL) 0

    Init_Procedure NORMAL Init_Install Demande_Archi "" "ARCH"

    set FRAME_GLOBAL [frame [Main_Frame].f1]
    set FRAME_ARCHI [frame $FRAME_GLOBAL.f12]

    Message center Accueil [subst [Texte Select_Archi]]
    pack $FRAME_ARCHI -side top -fill x

    foreach CODE $ARCHI(CODE) {
	if {$CODE != {base}} then {
	    set FRAME($CODE) [frame $FRAME_GLOBAL.f_$CODE]
	    Make_Check $FRAME($CODE).check_$CODE $ARCHI(NAME_$CODE) left ARCHI(TRUE_$CODE) 
	    $FRAME($CODE).check_$CODE configure -command {Check_Required_Space}
	    pack $FRAME($CODE) -side top -fill x
	}
    }
    pack $FRAME_GLOBAL -side top 

    set FRAME_BAS [frame [Main_Frame].f]
    set FRAME_TMP [frame $FRAME_BAS.ftmp]
    Make_Label $FRAME_TMP.message_Required_During_TMP left ""
    $FRAME_TMP.message_Required_During_TMP configure -justify left
    set FRAME_CADP [frame $FRAME_BAS.fcadp]
    Make_Label $FRAME_CADP.message_Required_During_CADP left ""
    $FRAME_CADP.message_Required_During_CADP configure -justify left
    pack $FRAME_CADP $FRAME_TMP -side bottom -fill x
    pack $FRAME_BAS -side bottom

    Check_Required_Space

    Enable_Previous;Enable_Previous
}

proc Check_Required_Space {} {
    global ARCHI CADP
    global FRAME_TMP FRAME_CADP
    global REQUIRED_SPACE_FOR_CADP REQUIRED_SPACE_FOR_TMP
    global FREE_SPACE_FOR_CADP FREE_SPACE_FOR_TMP

    set REQUIRED_SPACE_FOR_CADP 0
    set REQUIRED_SPACE_FOR_TMP 0

    set NO_ARCHI 1
    foreach CODE $ARCHI(CODE) {
	if $ARCHI(TRUE_$CODE) then {
	    if ![string match $CODE base] then {set NO_ARCHI 0}
	    set REQUIRED_SPACE_FOR_CADP [expr double($REQUIRED_SPACE_FOR_CADP) + double(round((double($ARCHI(NORMAL_SIZE_$CODE)) / (1024*1024))*10))/10]
	    set REQUIRED_SPACE_FOR_TMP [expr double($REQUIRED_SPACE_FOR_TMP) + double(round((double($ARCHI(SIZE_$CODE)) / (1024*1024))*10))/10]
	}
    }

    if $NO_ARCHI then {
	Disable_Next
	set REQUIRED_SPACE_FOR_CADP 0
	set REQUIRED_SPACE_FOR_TMP 0
    } else {
	Enable_Next
    }

    set FREE_SPACE_FOR_CADP [Get_Free_Space $CADP(NEW_PATH)]
    set FREE_SPACE_FOR_TMP [Get_Free_Space $CADP(TMP_ARCHIVE)]

    if [Same_Partition $CADP(NEW_PATH) $CADP(TMP_ARCHIVE)] then {

	if [expr $FREE_SPACE_FOR_TMP < $REQUIRED_SPACE_FOR_CADP] then {
	    set FREE_SPACE_FOR_TMP 0
	} else {
	    set FREE_SPACE_FOR_TMP [expr $FREE_SPACE_FOR_TMP - $REQUIRED_SPACE_FOR_CADP]
	}
    }

    catch {$FRAME_CADP.message_Required_During_CADP configure -text "Required space in [Path $CADP(NEW_PATH) 25]:\n        $REQUIRED_SPACE_FOR_CADP MB ($FREE_SPACE_FOR_CADP MB available)"}
    catch {$FRAME_TMP.message_Required_During_TMP configure -text "\nRequired space in [Path $CADP(TMP_ARCHIVE) 25] during installation:\n        $REQUIRED_SPACE_FOR_TMP MB ($FREE_SPACE_FOR_TMP MB available)"}
}

proc Init_Install {} {
    global CADP OPTION
    global MODE_MONITEUR ARCHI
    global REQUIRED_SPACE_FOR_CADP REQUIRED_SPACE_FOR_TMP
    global FREE_SPACE_FOR_CADP FREE_SPACE_FOR_TMP

    if {[expr $REQUIRED_SPACE_FOR_CADP > $FREE_SPACE_FOR_CADP]} then {
	Message_Error [subst [Texte Not_Enough_Space_for_CADP]] NO_MSG
	return
    }

    if {[expr $REQUIRED_SPACE_FOR_TMP > $FREE_SPACE_FOR_TMP]} then {
	Message_Error [subst [Texte Not_Enough_Space_for_TMP]] NO_MSG
	return
    }

    Init_Procedure RETRY "" "" Init_Install "INST"
    Disable_Retry

    Message center Preparing "Preparing directories for installation"
    if $CADP(EXISTE) then {

	. config -cursor {watch}

	set CADP(DIR) $CADP(NEW_PATH)
	set CADP(NEW_PATH) "$CADP(NEW_PATH)/[Temporary_Installation_Directory]"

	Remove_Dir $CADP(NEW_PATH)
	Mkdir $CADP(NEW_PATH)

    }

    . config -cursor {top_left_arrow}    

    set ARCHI(LIST_INDEX) 0
    set MODE_MONITEUR {FTP}
    set CADP(RUN_INSTALL) 1

    set ARCHI(TOTAL_FICHIER) 0
    foreach CODE $ARCHI(CODE) {
	if $ARCHI(TRUE_$CODE) then {incr ARCHI(TOTAL_FICHIER)}
    }

    Message center Accueil ""   
    Barre_Init 
    Message center Status ""
    Boucle_Download_Decompress
}

proc Boucle_Download_Decompress {} {

    global KIND ARCHI MODE_MONITEUR 

    while {$ARCHI(LIST_INDEX)<[llength $ARCHI(CODE)]}  {
	set KIND [string trim [lindex $ARCHI(CODE) $ARCHI(LIST_INDEX)]]
	if $ARCHI(TRUE_$KIND) then {break}
	incr ARCHI(LIST_INDEX)
    }

    if [expr $ARCHI(LIST_INDEX)<[llength $ARCHI(CODE)]] then {
	incr ARCHI(LIST_INDEX)
	Affiche_Moniteur 

    } elseif {$MODE_MONITEUR == {FTP}} then {

	set MODE_MONITEUR DECOMPRESS
	set ARCHI(LIST_INDEX) 0
	Init_Procedure RETRY_NO_NEXT_NO_PREVIOUS \
	    Boucle_Download_Decompress {} Download_Retry "RET"
	Message center Accueil ""
	Make_Text [Main_Frame].frame "" 80 18 normal
	Boucle_Download_Decompress
    } elseif {$MODE_MONITEUR == {DECOMPRESS}} then {
	Adjust_Files
	Change_Group
    }

}

proc Affiche_Moniteur {} {
    global KIND MODE_MONITEUR OPTION ARCHI CADP
    global DOWNLOAD_ERROR

    Init_Buttons RETRY Boucle_Download_Decompress {} Affiche_Moniteur "MON"
    Disable_Retry

    . config -cursor {watch}

    if {$MODE_MONITEUR =={FTP}} then {
	set FILENAME  CADP_${KIND}_$CADP(PASSWD).tar.Z
	Change_Message Accueil "\n\n\n Downloading $KIND package from $CADP(FTP_ADDRESS)\n\n\nProgression:"
	Barre 0 $ARCHI(SIZE_$KIND)  
	Change_Message Status ""
	Download $FILENAME

	if ![expr $DOWNLOAD_ERROR] then {
	    Enable_Next;Invoke_Next
	    return
	}
	Message_Error [subst [Texte Ftp_Error]] NO_MSG
    } elseif {$MODE_MONITEUR =={DECOMPRESS}} then {
	update idletasks
	if [Decompress $KIND] then {
	    Enable_Next;Invoke_Next
	    return
	} 
	Message_Error [subst [Texte Decompress_Error]] NO_MSG
	Enable_Next
    }
    Enable_Previous;Enable_Retry
    . config -cursor {top_left_arrow}
    update idletasks
}

proc Download_Retry {} {

    Affiche_Moniteur
}

proc Progress {{TAILLE 0}} {
	global KIND ARCHI

	Barre $TAILLE $ARCHI(SIZE_$KIND)
	update idletasks
}

proc Decompress {KIND} {
    global env
    global CADP ARCHI OPTION

    Change_Message Accueil "Processing ${KIND} package"
    Add_Text [subst [Texte Extract]]

    Run_Shell "CADP=\"$CADP(NEW_PATH)\" ; \
	 CADP_ARCHIVE=\"$CADP(TMP_ARCHIVE)\" ; \
	 CADP_ARCHIVE_NAME=\"$CADP(PREFIXE)CADP_${KIND}_$CADP(PASSWD)\" ; \
	 CADP_ERROR_UNCOMPRESS=\"$CADP(TMP)/$CADP(PREFIXE)$CADP(FILE_ERROR_UNCOMPRESS)\" ; \
	 CADP_ERROR_TAR=\"$CADP(TMP)/$CADP(PREFIXE)$CADP(FILE_ERROR_TAR)\" ; \
	 export CADP CADP_ARCHIVE CADP_ARCHIVE_NAME CADP_ERROR_UNCOMPRESS ;\
	 export CADP_ERROR_TAR ; \      
	 \"$CADP(INSTALL_PATH)\"/src/com/install_uncompress"
        if [expr [file exists $CADP(TMP)/$CADP(PREFIXE)$CADP(FILE_ERROR_UNCOMPRESS)] \
		&&  [file exists $CADP(TMP)/$CADP(PREFIXE)$CADP(FILE_ERROR_TAR)]] then {
	    if [expr [file size $CADP(TMP)/$CADP(PREFIXE)$CADP(FILE_ERROR_UNCOMPRESS)]==0 \
		    && [file size $CADP(TMP)/$CADP(PREFIXE)$CADP(FILE_ERROR_TAR)]==0] then {
		Remove_File $CADP(TMP)/$CADP(PREFIXE)$CADP(FILE_ERROR_TAR)
		Remove_File $CADP(TMP)/$CADP(PREFIXE)$CADP(FILE_ERROR_UNCOMPRESS)
		Add_Text [subst [Texte Uncompressed]]
		if [Remove_File $CADP(TMP_ARCHIVE)/$CADP(PREFIXE)CADP_${KIND}_$CADP(PASSWD).tar.Z] then {
		    Add_Text [subst [Texte Deleted]]
		    return 1
		}
	    }
	}
    Add_Text "Error during archive extraction\n"

    return 0
}

proc Adjust_Files {} {
    global env
    global CADP ARCHI

    Change_Message Accueil "Adjusting installed files"
    Add_Text [subst [Texte Adjust]]
    Disable_Next
    Run_Shell "CADP=\"$CADP(NEW_PATH)\" ; \
	export CADP ; \
	\"$CADP(INSTALL_PATH)\"/src/com/cadp_adjust -verbose ; \
	echo END_SHELL_0"
    Enable_Next
    return 1
}

proc Change_Group {} {

    global CADP OPTION    
    global USER

    Init_Buttons RETRY Remove_After {} Change_Group "GRP"
    Disable_Retry
    . config -cursor {watch}

    Change_Message Accueil "Setting permission"
    Add_Text [subst [Texte Set_Group]]
    update ; update idletasks
    if ![Chmod_1 $CADP(NEW_PATH)] then {
	Add_Text "\nError while executing chmod\n"
	Enable_Retry
    }

    if ![Chmod_2 $CADP(NEW_PATH)] then {
	Add_Text "\nError while executing chmod\n"
	. config -cursor {top_left_arrow}
	Enable_Retry
    }

    Add_Text [subst [Texte Group_Set_Ok]]

    Enable_Next
    Invoke_Next

}

proc Remove_After {} {
    global OPTION CADP

    Init_Buttons RETRY Ask_Personnal_Info "" Remove_After "RM"
    Disable_Retry
    . config -cursor {watch}
    bell
    Message center Fin "CADP $CADP(LATEST_NUM_VERSION) is now installed on your machine.\nPress Next to complete the installation."
    . config -cursor {top_left_arrow}	    
    Enable_Next
}

proc Ask_Personnal_Info {} {
    global INFO_NAME INFO_ORGANIZATION INFO_EMAIL FRAME_ORGANIZATION CADP 

    Init_Procedure NORMAL Ask_Personnal_Info__Next Ask_Personnal_Info "" "INFO"

    Message center Accueil [subst [Texte Ask_Info]]

    set FRAME_GLOBAL [frame [Main_Frame].fg]
    set FRAME_NAME [frame $FRAME_GLOBAL.fn]
    set FRAME_EMAIL [frame $FRAME_GLOBAL.fe]
    set FRAME_ORGANIZATION [frame $FRAME_GLOBAL.fo]
    set FRAME_REMINDER [frame $FRAME_GLOBAL.fr]
    set FRAME_REMINDER_VAL [frame $FRAME_GLOBAL.frv]

    Make_Label $FRAME_NAME.nom left "Your name:"
    pack $FRAME_NAME -side top -fill x
    Make_Entry $FRAME_GLOBAL.entry INFO_NAME 44 top

    Make_Label $FRAME_ORGANIZATION.org left "Your organization and address:"
    pack $FRAME_ORGANIZATION -side top -fill x
    Make_Text $FRAME_GLOBAL.text_org $INFO_ORGANIZATION 40 6 normal

    Make_Label $FRAME_EMAIL.email left "Your e-mail address (the licence will be sent to this address):"
    pack $FRAME_EMAIL -side top -fill x
    Make_Entry $FRAME_GLOBAL.email_entry INFO_EMAIL 44 top

    Make_Label $FRAME_REMINDER.reminder left "License expiration reminder:"
    pack $FRAME_REMINDER -side top -fill x

    Make_Label $FRAME_REMINDER_VAL.begin left "\tYou will be reminded by e-mail "
    Make_Entry $FRAME_REMINDER_VAL.rem_ent INFO_REMINDER 3 left
    Make_Label $FRAME_REMINDER_VAL.rem_end left "day(s) before license expires"
    pack $FRAME_REMINDER_VAL -side top -fill x
    Make_Label $FRAME_GLOBAL.rem_help left "\t(a value of \"0\" means that no reminder will be sent to you)."

    pack $FRAME_GLOBAL -side top

    Enable_Next
}

proc Ask_Personnal_Info__Next {} {
    global INFO_NAME INFO_ORGANIZATION INFO_EMAIL INFO_REMINDER
    global FRAME_ORGANIZATION CADP

    set INFO_ORGANIZATION [string trim [[Main_Frame].fg.text_org.text get 0.0 end] " \n"]
    if {$INFO_NAME==""} then {
	Message_Error "Please enter your name." NO_MSG
	return
    }
    if {! [regexp "^\[a-zA-Z0-9_.%-\]*@\[a-zA-Z0-9_%-\]{1,}\[.\]\[a-zA-Z0-9_.%-\]*$" $INFO_EMAIL]} then {
	Message_Error "Please enter a valid e-mail address." NO_MSG
	return
    }

    set FORBIDDEN_EMAIL_DOMAINS "$CADP(INSTALL_PATH)/src/installator/cadp_registration_mail_filter"
    if [file exists "$FORBIDDEN_EMAIL_DOMAINS"] {
	set EMAIL_DOMAIN_NAME [lindex [split $INFO_EMAIL @] 1]
	if {![catch {exec grep -w "$EMAIL_DOMAIN_NAME" "$FORBIDDEN_EMAIL_DOMAINS"}]} {
	    Message_Error "Please, use a professional e-mail address.\nIf not, your request for license\nmight be rejected by the CADP team." NO_MSG
	}
    }
    if {$INFO_ORGANIZATION==""} then {
	Message_Error "Please enter your organization and address." NO_MSG
	return
    }
    if {! [expr {[string is integer -strict $INFO_REMINDER] && [expr $INFO_REMINDER >= 0 && $INFO_REMINDER <= 366 ]}]} then {
	Message_Error "Please enter a number of days between 0 and 366." NO_MSG
	return
    }

    set INFO_LAST_LINE "$INFO_NAME <$INFO_EMAIL> $INFO_REMINDER"
    set TEXT "[string trim [join [list $INFO_ORGANIZATION $INFO_LAST_LINE] "\n"] " \n"]\n"
    if [Make_File $CADP(TMP)/$CADP(PREFIXE)$CADP(INFO_FILE) $TEXT] then {
	Read_Machine
    } else {
	Message_Error "ERROR: Can't create information file" ERROR_MSG
    } 
}

proc Check_Old_License {} {

    global CADP 

    if $CADP(EXISTE) then {

	if [file exists $CADP(TMP)/$CADP(PREFIXE)$CADP(LICENSE_OLD)] then {
	    Ask_License
	    return
	}
    }
    Ask_Personnal_Info
}

proc Ask_License {} {
    global CADP INFO_NAME INFO_ORGANIZATION INFO_EMAIL

    Init_Procedure NORMAL Ask_License__Next Ask_License {} "LIC"

    if [expr [string match $INFO_NAME ""] && [string match $INFO_ORGANIZATION ""] && [string match $INFO_EMAIL ""]] then {
	Message center Accueil "\n\n\nA license already exists for machines:\n"
    } else {
	Message center Accueil "A license already exists for:\n\n$INFO_NAME\n$INFO_EMAIL\n$INFO_ORGANIZATION\n\nThis license is available for machines:"
	[Main_Frame].message_Accueil configure -justify left
	
    }
    Make_Text [Main_Frame].frame $CADP(HOSTS) 15 5 disabled

    set FRAME_GLOBAL [frame [Main_Frame].f]
    set FRAME_CHANGE [frame $FRAME_GLOBAL.fchg]
    set FRAME_KEEP [frame $FRAME_GLOBAL.fkeep]

    Message center Question "Do you want to change it?"
    Make_Radio $FRAME_CHANGE.change "Yes" left CHANGE OPTION(LICENSE)
    $FRAME_CHANGE.change select
    Make_Radio $FRAME_KEEP.keep "No, keep it unchanged" left KEEP OPTION(LICENSE)

    pack $FRAME_CHANGE $FRAME_KEEP -side top -fill x
    pack $FRAME_GLOBAL -side top

    Enable_Next
    if ![expr $CADP(RUN_INSTALL)] then {Enable_Previous}
}

proc Ask_License__Next {} {
    global OPTION
    switch $OPTION(LICENSE) {
	CHANGE {Ask_Personnal_Info}
	KEEP {Customize}
    }
}

proc Read_Machine {} {
    global CADP NEW_HOST PARAM env
    Init_Procedure NORMAL Read_Machine__Next Read_Machine {} "READ"

    set FRAME_HAUT [frame [Main_Frame].haut]

    set FRAME [frame [Main_Frame].f]
    Make_Label [Main_Frame].txt top "Enter the name of each machine on which you want to run CADP"
    set FRAME_RIGHT [frame $FRAME.fr]
    Make_Label $FRAME_RIGHT.msg top "Enter new machine:"
    Make_Entry $FRAME_RIGHT.entry NEW_HOST 20 top
    set FRAME_BUT [frame $FRAME_RIGHT.but]
    Make_Button $FRAME_BUT.add  "Add host" top {Add_List $NEW_HOST}
    Make_Button $FRAME_BUT.del "Remove host" top {Delete_List [Main_Frame].f}
    pack $FRAME_BUT.add $FRAME_BUT.del  -side top -fill x
    pack $FRAME_BUT -side top -expand true -padx 10
    pack $FRAME_RIGHT -side right -pady 10
    Make_List $FRAME 6 15 left
    pack $FRAME -side top -pady 10

    pack $FRAME_HAUT -side top

    set FRAME_HAUT1 [frame $FRAME_HAUT.f1]
    Make_Label $FRAME_HAUT1.message_Accueil1 left [subst [Texte Rfl_Instructions1]]
    $FRAME_HAUT1.message_Accueil1 configure -justify left
    pack $FRAME_HAUT1 -side top -fill x -expand true

    set FRAME_HAUT3 [frame $FRAME_HAUT.f3]
    Make_Radio $FRAME_HAUT3.rsh "rsh" left "rsh" PARAM(REMOTE_ACCESS_PROTOCOL)
    Make_Radio $FRAME_HAUT3.ssh "ssh" left "ssh" PARAM(REMOTE_ACCESS_PROTOCOL)
    Make_Radio $FRAME_HAUT3.krsh "krsh" left "krsh" PARAM(REMOTE_ACCESS_PROTOCOL)
    Make_Radio $FRAME_HAUT3.any "any of these" left "any" PARAM(REMOTE_ACCESS_PROTOCOL)
    pack $FRAME_HAUT3.rsh -padx 30 -side left
    pack $FRAME_HAUT3.ssh -padx 15 -side left
    pack $FRAME_HAUT3.krsh -padx 15 -side left
    pack $FRAME_HAUT3.any -padx 15 -side left
    pack $FRAME_HAUT3 -side top -fill x -expand true

    set FRAME_HAUT2 [frame $FRAME_HAUT.f2]
    Make_Label $FRAME_HAUT2.message left [subst [Texte Rfl_Instructions2]]
    $FRAME_HAUT2.message configure -justify left
    pack $FRAME_HAUT2 -side top -fill x -expand true

    if {$CADP(NEW_PATH_SHOWN_TO_USER) == ""} {
        set CADP(NEW_PATH_SHOWN_TO_USER) $CADP(DIR)

    }
    Make_Entry $FRAME_HAUT.global_path CADP(NEW_PATH_SHOWN_TO_USER) 35 top

    set FRAME_OPTION [frame [Main_Frame].opt]
    Make_Button [Frame_Buttons].help "Help" left {Get_Help_Rfl}

    pack $FRAME_OPTION -side left -expand true

    if [string match $CADP(HOSTS) ""] then {
	set CADP(HOSTS) $env(LOCAL_HOST)
    }

    foreach ELEMENT $CADP(HOSTS) {
	Add_Listbox $FRAME $ELEMENT
    }

    bind $FRAME_BUT.add <Key-Return> {[Main_Frame].f.fr.but.add invoke}
    bind $FRAME_RIGHT.entry <Key-Return> {[Main_Frame].f.fr.but.add invoke}

    Enable_Next;Enable_Previous
}

proc Read_Machine__Next {} {
    global FRAME_TEXT HOST_LIST CADP

    set HOST_LIST [[Main_Frame].f.flist.list get 0 end]

    if {[string trim [join $HOST_LIST ]]=={}}  then {
	Message_Error [subst [Texte Host_Empty]] NO_MSG
    } else {
	Run_RFL
    }
}

proc Show_License {} {
    global CADP
    [Main_Frame].show configure -state disabled
    Run_Shell "echo; cat \"$CADP(TMP)/$CADP(PREFIXE)$CADP(LICENSE_MAIL)\""
}

proc Run_RFL {} {
    global CADP PARAM HOST_LIST STATUS_COMMAND OPTION

    Init_Procedure NO_NEXT_NO_PREVIOUS_RETRY Select_Send_License_Method "" Run_RFL "RFL"
    Disable_Retry

    if {($CADP(EXISTE) == 1) && ($OPTION(INSTALL) == "INSTALL")} then {

	set CADP(NEW_PATH_FOR_RFL) "$CADP(NEW_PATH_SHOWN_TO_USER)/[Temporary_Installation_Directory]"
    } else {
	set CADP(NEW_PATH_FOR_RFL) "$CADP(NEW_PATH_SHOWN_TO_USER)"
    }

    Message center Running " Running RFL (Request-For-License)\n"
    Make_Text [Main_Frame].frame [subst [Texte Exec_Rfl]] 80 15 normal

    Run_Shell "CADP=\"$CADP(NEW_PATH_FOR_RFL)\" ; \
	CADP_DIR=\"$CADP(DIR)\"; \
	CADP_INFO_FILE=\"$CADP(TMP)/$CADP(PREFIXE)$CADP(INFO_FILE)\" ; \
	CADP_LICENSE_MAIL=\"$CADP(TMP)/$CADP(PREFIXE)$CADP(LICENSE_MAIL)\" ; \
	CADP_HOST_LIST=\"$HOST_LIST\" ; \
	CADP_REMOTE_ACCESS_PROTOCOL=\"$PARAM(REMOTE_ACCESS_PROTOCOL)\" ; \
	export CADP CADP_DIR CADP_INFO_FILE CADP_LICENSE_MAIL CADP_HOST_LIST CADP_REMOTE_ACCESS_PROTOCOL ; \
	\"$CADP(INSTALL_PATH)\"/src/com/install_rfl"

    if !$STATUS_COMMAND then {
	Message center End_Running [subst [Texte Rfl_Done]]
	[Main_Frame].message_End_Running configure -justify left
	Make_Button [Main_Frame].show "Show Prototype License File" top {Show_License}
	bell
	Enable_Previous
	Enable_Next
	return
    }
    bell
    Message center End_Running [subst [Texte Rfl_Error]]
    Enable_Retry
    Enable_Previous
}

proc Select_Send_License_Method {} {
    global CADP FROM_LABEL SMTP_LABEL CADP_LICENSE_SAVE INFO_EMAIL
    global SEND_METHOD
    global PARAM
    Init_Procedure NORMAL Send_License__Next Select_Send_License_Method "" "SEND"

    Message center Accueil [subst [Texte Select_License_Transfer_Method]]

    set SENDMAIL_STATUS [Exec_Command_With_Output [list sh "$CADP(INSTALL_PATH)/src/com/cadp_mail" -server]]

    set FRAME_GLOBAL [frame [Main_Frame].f1]
    set FRAME_MAIL [frame $FRAME_GLOBAL.fm]
    set FRAME_MAIL_TXT [frame $FRAME_GLOBAL.fmt]
    set FRAME_FTP [frame $FRAME_GLOBAL.ff]
    set FRAME_FTP_TXT [frame $FRAME_GLOBAL.fft]
    set FRAME_DISK [frame $FRAME_GLOBAL.fd]
    set FRAME_DISK_TXT [frame $FRAME_GLOBAL.fdt]
    set FRAME_HTTP [frame $FRAME_GLOBAL.fh]
    set FRAME_HTTP_TXT [frame $FRAME_GLOBAL.fht]
    set B "      "

    Make_Radio $FRAME_FTP.ftp "FTP" left FTP PARAM(SEND_METHOD)
    pack $FRAME_FTP -side top -fill x
    Make_Label $FRAME_FTP_TXT.txt left "$B Your license request will be uploaded on the CADP FTP server\n"
    pack $FRAME_FTP_TXT -side top -fill x

    Make_Radio $FRAME_MAIL.mail "E-mail" left MAIL PARAM(SEND_METHOD)
    pack $FRAME_MAIL -side top -fill x
    Make_Label $FRAME_MAIL_TXT.txt left "$B Your license request will be sent by e-mail to $CADP(E_MAIL_ADDRESS).\n$B This is only possible if the current machine is able to send e-mail\n"
    pack $FRAME_MAIL_TXT -side top -fill x
    if [string match $SENDMAIL_STATUS "cadp_mail_failed"] then {

	$FRAME_MAIL.mail configure -state disabled
	$FRAME_MAIL_TXT.txt configure -state disabled
    }

    Make_Radio $FRAME_HTTP.http "HTTP" left HTTP PARAM(SEND_METHOD)
    pack $FRAME_HTTP -side top -fill x
    Make_Label $FRAME_HTTP_TXT.txt left "$B Your license request will be submitted to the CADP Web server\n"
    pack $FRAME_HTTP_TXT -side top -fill x
    $FRAME_HTTP.http configure -state disabled
    $FRAME_HTTP_TXT.txt configure -state disabled

    Make_Radio $FRAME_DISK.disk "Save to disk" left DISK PARAM(SEND_METHOD)
    pack $FRAME_DISK -side top -fill x
    Make_Label $FRAME_DISK_TXT.txt left "$B The license request will be saved in your home directory.\n$B You will have to send it to $CADP(E_MAIL_ADDRESS) by yourself\n"
    pack $FRAME_DISK_TXT -side top -fill x

    pack $FRAME_GLOBAL -side top

    Enable_Next;Enable_Previous
}

proc Send_License__Next {} {
    global PARAM

    switch $PARAM(SEND_METHOD) {
    	"FTP" {

	    Send_License_By_Ftp
	}
	"MAIL" {

	    Send_License_By_Mail
	}
	"DISK" {

	    Save_License
	}
    }
}

proc Save_License {} {
    global CADP CADP_LICENSE_SAVE
    Init_Procedure NORMAL Customize Save_License "" "COPIED"
    Copy_License
    Message center Ok [subst [Texte License_Prototype_Saved]]
    Enable_Next;Enable_Previous
    return
}

proc Send_License_By_Ftp {} {
    global CADP
    Init_Procedure RETRY Customize Select_Send_License_Method Send_License_By_Ftp "SEND_FTP"
    Disable_Retry

    Message center Upload [subst [Texte Upload_License_Prototype]]

    for {set CPT 0} {$CPT < 5} {incr CPT} {
	. config -cursor {watch}
        set REMOTE_FILENAME [clock format [clock seconds] -format "LICENSE-%Y-%m-%d-%T"]

	set TRANSFERT_OK [Upload_Fg "$CADP(TMP)/$CADP(PREFIXE)$CADP(LICENSE_MAIL)" $REMOTE_FILENAME ]
	. config -cursor {top_left_arrow}
	if {$TRANSFERT_OK} then {
	    break;
	}
    }

    if {$TRANSFERT_OK} then {
	Message center Success [subst [Texte Sent_License_Prototype]]
	Enable_Next;

    } else {
	Message center Failed [subst [Texte Upload_License_Prototype_Failed]]
	Enable_Retry;Enable_Previous;
    }
}

proc Send_License_By_Mail {} {
    global CADP FROM_LABEL SMTP_LABEL CADP_LICENSE_SAVE INFO_EMAIL
    Init_Procedure NORMAL Send_Mail__Next Send_License_By_Mail "" "SEND_MAIL"

    set CADP(SMTP_SERVER) [Exec_Command_With_Output [list sh "$CADP(INSTALL_PATH)/src/com/cadp_mail" -server]]
    set CADP(FROM) $INFO_EMAIL

    set FRAME_GLOBAL [frame [Main_Frame].fg]
    set FRAME_FROM [frame $FRAME_GLOBAL.ff]
    set FRAME_SMTP [frame $FRAME_GLOBAL.fs]

    switch $CADP(SMTP_SERVER) {
	cadp_mail_failed {
		Copy_License
		Message center Ok [subst [Texte No_Unix_Sendmail_daemon]]
		Enable_Next;Enable_Previous
		return
	}
	cadp_mail_automatic -
	cadp_mail_unknown -
	default {

    		Message center Ok [subst [Texte Sending_Mail]] 
		Make_Label $FRAME_FROM.from left $CADP(FROM)
		pack $FRAME_FROM -side top -fill x

		pack $FRAME_GLOBAL -side top
	}
    }

    switch $CADP(SMTP_SERVER) {
	cadp_mail_automatic {

		focus [Frame_Buttons].next
	}
	cadp_mail_unknown {

		set CADP(SMTP_SERVER) ""
		Make_Label $FRAME_SMTP.smtpserver left "\n\n$SMTP_LABEL"
		pack $FRAME_SMTP -side top -fill x
		Make_Entry $FRAME_GLOBAL.entry2 CADP(SMTP_SERVER) 25 top
		focus $FRAME_GLOBAL.entry2
	}
	default {

		Make_Label $FRAME_SMTP.smtpserver left "\n\n$SMTP_LABEL"
		pack $FRAME_SMTP -side top -fill x
		Make_Entry $FRAME_GLOBAL.entry2 CADP(SMTP_SERVER) 25 top
		focus $FRAME_GLOBAL.entry2
	}
    }
    Enable_Next;Enable_Previous
}

proc Send_Mail__Next {} {
    global CADP FROM_LABEL SMTP_LABEL CADP_LICENSE_SAVE

    if  [string match $CADP(SMTP_SERVER) "cadp_mail_failed"] then {
	Customize
	return
    }

    switch [Exec_Command_With_Output [list sh "$CADP(INSTALL_PATH)/src/com/cadp_mail" -server]] {
	cadp_mail_automatic {

		set RESULT [Mail_to_CADP_Team "-" $CADP(FROM)]
		if ![string match $RESULT "cadp_mail_ok"] then {
			Copy_License
			Message_Error  [subst [Texte Unix_Mail_Failed]] NO_MSG
		}
	}
	cadp_mail_unknown -
	default {

    		if [expr [string match $CADP(SMTP_SERVER) ""]] then {
			Message_Error "The '$SMTP_LABEL' field should not be empty" NO_MSG
			return
    		}
		set RESULT [Mail_to_CADP_Team $CADP(SMTP_SERVER) $CADP(FROM)]
		if ![string match $RESULT "cadp_mail_ok"] then {
			Copy_License
			Message_Error  [subst [Texte Win32_Mail_Failed]] NO_MSG
		}
	}
    }

    Customize
    Enable_Next;Enable_Previous
}

proc Customize {} {
    Init_Procedure NORMAL Fin Customize "" "CUSTOM"
    [Frame_Buttons].next configure -text "Finish"

    Message center Accueil "\n\n"
    Make_Text [Main_Frame].text [Get_Help_Customization]  80 17 disabled

    Enable_Next
}

proc Fin {} {
    global CADP env OPTION INSTALLATOR_STATE

    Please_Wait
    if $CADP(EXISTE) then {
	if $CADP(RUN_INSTALL) then {
	    if [string match $OPTION(SAUVE) RM_AFTER] then {
		set INSTALLATOR_STATE "UPGRADE_AND_REMOVE_OLD"
	    } else {
		set INSTALLATOR_STATE "UPGRADE_AND_KEEP_OLD"
	    }
	} else {
		set INSTALLATOR_STATE "INSTALL"
	}
    } else {
		set INSTALLATOR_STATE "INSTALL"
    }
    Run_Shell_Setup
    exit
}

proc Unix_Communication_Mode {} {
	global Pipe CADP

	if ![catch {open "| [exec sh "$CADP(INSTALL_PATH)/src/com/cadp_shell"] |& cat -u" r+} Pipe] {
		fconfigure $Pipe -buffering none
		fconfigure $Pipe -blocking 0
		fconfigure $Pipe -translation [exec sh "$CADP(INSTALL_PATH)/src/com/cadp_crlf"]
		fileevent $Pipe readable Log
	}
}

proc Log {} {
	global Pipe
	global STATUS_COMMAND

	gets $Pipe Char
	switch -regexp  -- $Char {
		END_SHELL_0 {

			set LIST [split [string trim $Char] "\n\r"]
			Add_Text "[join [lrange $LIST 0 [expr [llength $LIST] \
			 - 2]] "\n"]\n"
			set STATUS_COMMAND 0
			update idletasks
		}
		END_SHELL_1 {

			set LIST [split [string trim $Char] "\n\r"]
			Add_Text "[join [lrange $LIST 0 [expr [llength $LIST] \
			 - 2]] "\n"]\n"
			set STATUS_COMMAND 1
			update idletasks
		}
		default {
			regsub -all "\r" [string trim $Char "\r"] "" RESULT
			catch {Add_Text "$RESULT"}
			update idletasks
		}
	}
}

Make_Window

Unix_Communication_Mode

Start

