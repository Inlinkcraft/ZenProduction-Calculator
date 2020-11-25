#
# @author Antoine Montpetit
#

extends Node

# = VAR = #
enum Colors {
	Background,
	
	Main,
	Secondary,
	
	InfoAlert,
	Action,
	Inactive,
	
	Text,
	TextHighlight,
	TextLittle,
	
	Gradien
}

export(Colors) var colorId = Colors.Background
