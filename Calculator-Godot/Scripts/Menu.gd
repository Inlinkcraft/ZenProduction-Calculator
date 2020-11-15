#
# @author Antoine Montpetit
#

extends Control

# = VAR = #
var isMenuOpen = false

var TabOpen = "MainTab"

onready var menu = $"../Menu"
onready var interactionSpace = $"../InteractionSpace"

onready var allInterationSpace = interactionSpace.get_children()

# = FUNC = #

#
# Used to open/close menu and manage tab 
#
func ButtonPressed():
	isMenuOpen = !isMenuOpen
	
	if (isMenuOpen):
		for i in range(allInterationSpace.size()):
			allInterationSpace[i].set_visible(false)
	else:
		for i in range(allInterationSpace.size()):
			if (allInterationSpace[i].name == TabOpen):
				allInterationSpace[i].set_visible(true)
	
	menu.set_visible(isMenuOpen)

# All button call

#
# called whent the menu button is pressed
#
func _on_MenuButton_pressed():
	ButtonPressed()

#
# called whent the main tab button is pressed
#
func _on_MainTabButton_pressed():
	TabOpen = "MainTab"
	ButtonPressed()


func _on_ThemeButton_pressed():
	TabOpen = "ThemeTab"
	ButtonPressed()
