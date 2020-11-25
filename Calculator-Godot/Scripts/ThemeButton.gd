#
# @author Antoine Montpetit
#

extends Button

# = Var = #
var id = 0;
onready var themeManager = $"/root/Node2D/Managers/ThemeManager"

# = FUNC = #

#
# Called went the theme button is press it just sends itself to the manager
#
func _on_ThemeButton_pressed():
	themeManager.SetTheme(id)
