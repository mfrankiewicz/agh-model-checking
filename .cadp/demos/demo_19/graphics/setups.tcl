####################################################################
#
# Datei setups.tcl
#
# VERSION: 1.0
# Autor : 	   Artur Brauer
# Erstellzetraum : April 94
# Lezte Aenderung: 
#
# Contains the Setups for the simulation of the production cell
#
####################################################################

global max_blanks
global belt1_speed
global belt2_speed
global table_rotation_angle
global table_height_speed
global robot_rotation_angle
global arms_extension_speed
global press_speed
global crane_horizontal_speed
global crane_vertical_speed



#Defaults for:
#display         : color
#language	 : english
#mode 	         : loop

set color_schwarzweiss  color
set engl_deutsch 	english
set mode loop




#This constans defines the number of blanks available in the stock
set max_blanks 5


#This constant defines the speed of the feedbelt
set belt1_speed 6


#This constant defines the speed of the depositbelt
set belt2_speed -6


#This constant defines the rotation angle of the table
set table_rotation_angle 5


#This constant defines the up- and down- movement speed of the table
set table_height_speed 2


#This constant defines the rotation angle of the robot
set robot_rotation_angle 5


#This constant defines the speed of both arms of the robot
set arms_extension_speed 3


#This constant defines the speed of the press
set press_speed 4


#This constant defines the speed of the crane into horizontal direction
set crane_horizontal_speed 4


#This constant defines the speed of the crane into vertical direction
set crane_vertical_speed 1
