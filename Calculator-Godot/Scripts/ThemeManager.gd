#
# @author Inlinkcraft
#

extends Node

# = VAR = #

var themeButton = preload("res://Scenes/ThemeButton.tscn")
var colorBlock = preload("res://Scenes/Color.tscn")

var themeJsonFilePath = "res://Data/Themes.json"

onready var themeTab = $"/root/Node2D/InteractionSpace/ThemeTab"
onready var fileManager = $"../FileMananager"

# = Current Theme Param = #

var allThemeData = []

var backgroundColor = Color(0,0,0,1)

var mainColor = Color(0,0,0,1)
var secondaryColor = Color(0,0,0,1)

var infoAlertColor = Color(0,0,0,1)
var actionColor = Color(0,0,0,1)
var inactiveColor = Color(0,0,0,1)

var textColor = Color(0,0,0,1)
var textHighlightColor = Color(0,0,0,1)
var textLittleColor = Color(0,0,0,1)

# = FUNC = #

#
# Called at the start
#
func _ready():
	allThemeData = GetAllThemes()
	CreateAllButton()
	SetTheme(0)


#
# Get he Json file that countain the theme data
#
func GetAllThemes():
	return fileManager.DecriptJson(themeJsonFilePath)


#
# this take all the json data file and create a button for each one
#
# @param allFiles : all the json theme data files
#
func CreateAllButton():
	
	for i in range(allThemeData.size()):
		
		var curButton = themeButton.instance()
		curButton.name = allThemeData[i]["ThemeName"]
		curButton.get_node("Name").text = allThemeData[i]["ThemeName"]
		curButton.id = i
		
		for j in range(allThemeData[i]["Color"].keys().size()):
			var colorKey = allThemeData[i]["Color"].keys()[j]
			CreateColorCube(allThemeData[i]["Color"][colorKey], curButton, colorKey)
		
		themeTab.add_child(curButton)

#
# This just create a square with a certain color for presenting the theme
#
# @param color: Is a color aray aka [r,g,b,a]
# @param parentButton : Is the parent that the square will be parented
# @param colorName : The "Purpose" name of the color aka Main, Secondary, etc. 
#
func CreateColorCube(color, parentButton, colorName):
	var curColor = colorBlock.instance()
	curColor.get_node("ColorGraph").modulate = Color(color[0],color[1],color[2],color[3]);
	curColor.name = colorName
	parentButton.get_node("Colors").add_child(curColor)

#
# Called by the button went pressed
# 
# @param pressedButton : the button that was pressed
#
func SetTheme(id):
	
	var themeSelectedColors = allThemeData[id]["Color"]
	
	backgroundColor = Color(themeSelectedColors["Background"][0],themeSelectedColors["Background"][1],themeSelectedColors["Background"][2],themeSelectedColors["Background"][3])
	
	mainColor = Color(themeSelectedColors["Main"][0],themeSelectedColors["Main"][1],themeSelectedColors["Main"][2],themeSelectedColors["Main"][3])
	secondaryColor = Color(themeSelectedColors["Secondary"][0],themeSelectedColors["Secondary"][1],themeSelectedColors["Secondary"][2],themeSelectedColors["Secondary"][3])
	
	infoAlertColor = Color(themeSelectedColors["InfoAlert"][0],themeSelectedColors["InfoAlert"][1],themeSelectedColors["InfoAlert"][2],themeSelectedColors["InfoAlert"][3])
	actionColor = Color(themeSelectedColors["Action"][0],themeSelectedColors["Action"][1],themeSelectedColors["Action"][2],themeSelectedColors["Action"][3])
	inactiveColor = Color(themeSelectedColors["Inactive"][0],themeSelectedColors["Inactive"][1],themeSelectedColors["Inactive"][2],themeSelectedColors["Inactive"][3])
	
	textColor = Color(themeSelectedColors["Text"][0],themeSelectedColors["Text"][1],themeSelectedColors["Text"][2],themeSelectedColors["Text"][3])
	textHighlightColor = Color(themeSelectedColors["TextHighlight"][0],themeSelectedColors["TextHighlight"][1],themeSelectedColors["TextHighlight"][2],themeSelectedColors["TextHighlight"][3])
	textLittleColor = Color(themeSelectedColors["TextLittle"][0],themeSelectedColors["TextLittle"][1],themeSelectedColors["TextLittle"][2],themeSelectedColors["TextLittle"][3])
	
	# Set background
	VisualServer.set_default_clear_color(backgroundColor)
	
	# Set Pastille
	for theme in themeTab.get_children():
		if(theme.name == allThemeData[id]["ThemeName"]):
			theme.get_node("Circle/ColorTag").colorId = 4
		else:
			theme.get_node("Circle/ColorTag").colorId = 5
		
	
	LoadCurThemeFor(get_tree().root.get_node("Node2D"))

#
# Load the theme for all object under a given root
#
# @param root : The base object to Set the theme to
#
func LoadCurThemeFor(root):
	var Childs = root.get_children()
	for i in range(Childs.size()):
		#Color if has Tag
		if(Childs[i].get_children().size() != 0 && Childs[i].get_node_or_null("ColorTag") != null):
			UpdateColor(Childs[i])
			
		# If has Child
		if (Childs[i].get_children().size() != 0):
			LoadCurThemeFor(Childs[i])

#
# Switches the color of the parent
#
# @param parent : the parent that het his color changes
#
func UpdateColor(parent):
	
	var colorId = parent.get_node("ColorTag").colorId
	
	if(colorId != 9):
		match(colorId):
			0:
				parent.modulate = backgroundColor
				
			1:
				parent.modulate = mainColor
				
			2:
				parent.modulate = secondaryColor
				
			3:
				parent.modulate = infoAlertColor
				
			4:
				parent.modulate = actionColor
				
			5:
				parent.modulate = inactiveColor
				
			6:
				parent.modulate = textColor
				
			7:
				parent.modulate = textHighlightColor
				
			8:
				parent.modulate = textLittleColor
