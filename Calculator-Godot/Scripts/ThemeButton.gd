#
# @author Antoine Montpetit
#

extends Button

# = FUNC = #

#
# Called went the theme button is press it just sends itself to the manager
#
func _on_ThemeButton_pressed():
	get_parent().ButtonPress(self)
