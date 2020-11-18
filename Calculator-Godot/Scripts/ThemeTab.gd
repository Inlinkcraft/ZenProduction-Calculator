#
# @author Inlinkcraft
#

extends Control

# = VAR = #

var ThemeButton = preload("res://Scenes/ThemeButton.tscn")
var ColorBlock = preload("res://Scenes/Color.tscn")

var CurrentThemeColors

# = FUNC = #

#
# Called at the start
#
func _ready():
	var allFiles = GetAllThemes()
	CreateAllButton(allFiles)
	ButtonPress(get_node("Default"))


#
# Get all the Json file that countain the theme data
#
func GetAllThemes():
	var files = []
	var dir = Directory.new()
	dir.open("res://Themes/")
	dir.list_dir_begin()
	
	while true:
		var file = dir.get_next()
		if file == "":
			break
		elif not file.begins_with("."):
			files.append(file)
	
	dir.list_dir_end()
	
	return files


#
# Decript a json file at a certain path
#
# @param path : The file path
#
func DecriptJson(path):
	var file = File.new();
	file.open(path, file.READ)
	
	var jsonParseResult = JSON.parse(file.get_as_text())

	if(jsonParseResult.error):
		printerr("json Error : " + jsonParseResult.error_string + " | at line :" + str(jsonParseResult.error_line) + " in file : " + path)
	
	file.close()
	return jsonParseResult.result

#
# this take all the json data file and create a button for each one
#
# @param allFiles : all the json theme data files
#
func CreateAllButton(allFiles):
	for i in range(allFiles.size()):
		
		var data = DecriptJson("res://Themes/" + allFiles[i])
		
		var CurButton = ThemeButton.instance()
		CurButton.name = data["ThemeName"]
		CurButton.get_node("Name").text = data["ThemeName"]
		
		for j in range(data["Color"].keys().size()):
			var colorKey = data["Color"].keys()[j]
			CreateColorCube(data["Color"][colorKey], CurButton, colorKey)
		
		self.add_child(CurButton)

#
# This just create a square with a certain color for presenting the theme
#
# @param color: Is a color aray aka [r,g,b,a]
# @param parentButton : Is the parent that the square will be parented
# @param colorName : The "Purpose" name of the color aka Main, Secondary, etc. 
#
func CreateColorCube(color, parentButton, colorName):
	var CurColor = ColorBlock.instance()
	CurColor.get_node("ColorGraph").modulate = Color(color[0],color[1],color[2],color[3]);
	CurColor.name = colorName
	parentButton.get_node("Colors").add_child(CurColor)

#
# Called by the button went pressed
# 
# @param pressedButton : the button that was pressed
#
func ButtonPress(pressedButton):

	var colors = [
		Color(), # Main
		Color(), # Secondary
		Color(), # BarMain
		Color(), # BarSecondary
		Color(), # Background
		Color()  # Text
		]
	
	colors[0] = pressedButton.get_node("Colors/Main/ColorGraph").modulate
	colors[1] = pressedButton.get_node("Colors/Secondary/ColorGraph").modulate
	colors[2] = pressedButton.get_node("Colors/BarMain/ColorGraph").modulate
	colors[3] = pressedButton.get_node("Colors/BarSecondary/ColorGraph").modulate
	
	colors[4] = pressedButton.get_node("Colors/Background/ColorGraph").modulate
	
	colors[5] = pressedButton.get_node("Colors/Text/ColorGraph").modulate
	
	CurrentThemeColors = colors
	VisualServer.set_default_clear_color(colors[4])
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
			var colorType = Childs[i].get_node("ColorTag").tag
			if (colorType - 1 != 0):
				Childs[i].modulate = CurrentThemeColors[colorType - 1]
			
		# If has Child
		if (Childs[i].get_children().size() != 0):
			LoadCurThemeFor(Childs[i])
