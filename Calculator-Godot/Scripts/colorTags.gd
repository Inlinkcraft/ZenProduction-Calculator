#
# @author Antoine Montpetit
#

extends Node

#
# Just a script to tell witch color of the theme to put
#

# = VAR = #
enum Tags {
	Nothing,
	Main,
	Secondary,
	BarMain,
	BarSecondary,
	Background,
	Text
}

export(Tags) var tag = Tags.Nothing
