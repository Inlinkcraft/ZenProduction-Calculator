#
# @author Inlinkcraft
#

extends HBoxContainer

onready var allButton = get_children()
onready var themeManager = $"/root/Node2D/Managers/ThemeManager"

func ButtonPressed(node):
	for i in range(allButton.size()):
		allButton[i].get_node("Background").set_visible(false)
		allButton[i].get_node("Name").modulate = themeManager.textColor
		allButton[i].get_node("Name/ColorTag").colorId = 6
	
	var allTabs = get_parent().get_parent().get_children()
	for i in range(allTabs.size()):
		if (allTabs[i].name != node.name && allTabs[i].name != "Tabs"):
			allTabs[i].set_visible(false)
		else:
			allTabs[i].set_visible(true)
	
	node.get_node("Name/ColorTag").colorId = 7
	node.get_node("Name").modulate = themeManager.textHighlightColor
	node.get_node("Background").set_visible(true)
