#
# @author Antoine Montpetit
#

extends CanvasLayer

# = VAR = #
var speed = 0.075
var maxAlfa = 0.5

var isMenuOpen = false

var MenuXPos = -620

var TabOpen = "MainTab"

onready var menutab = $"MenuTab"
onready var backButton = $"BackButton"
onready var interactionSpace = $"../InteractionSpace"

onready var allInterationSpace = interactionSpace.get_children()

# = FUNC = #

func _process(delta):
	if (MenuXPos != menutab.get_position().x):
		menutab.set_position(Vector2(lerp(menutab.get_position().x, MenuXPos, speed),menutab.get_position().y))
	
	if (isMenuOpen):
		if (backButton.modulate.a <= maxAlfa):
			backButton.modulate.a += delta
	else:
		if (backButton.modulate.a > 0):
			backButton.modulate.a -= delta
		else:
			backButton.set_position(Vector2(-720,0))
#
# Used to open/close menu and manage tab 
#
func ButtonPressed():
	isMenuOpen = !isMenuOpen
	
	if (isMenuOpen):
		SlideMenuIn();
	else:
		SlideMenuOut();
		for i in range(allInterationSpace.size()):
			if (allInterationSpace[i].name == TabOpen):
				allInterationSpace[i].set_visible(true)
	
	#menu.set_visible(isMenuOpen)

#
# Close the all the menus
#
func CloseMenus():
	for i in range(allInterationSpace.size()):
		allInterationSpace[i].set_visible(false)

#
# Open the side menu
#
func SlideMenuIn():
	backButton.set_position(Vector2(0,0))
	MenuXPos = 0

#
# Close the side menu
#
func SlideMenuOut():
	MenuXPos = -620


# All button call

#
# called whent the back button is pressed
#
func _on_BackButton_pressed():
	ButtonPressed()

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
	CloseMenus()
	ButtonPressed()

#
# called whent the theme tab button is pressed
#
func _on_ThemeButton_pressed():
	TabOpen = "ThemeTab"
	CloseMenus()
	ButtonPressed()
