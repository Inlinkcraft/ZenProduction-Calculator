
#
# @author Inlinkcraft
#

extends VBoxContainer

# = VAR = #

var categoryPrefab = preload("res://Scenes/Category.tscn")

onready var themeManager = $"/root/Node2D/InteractionSpace/ThemeTab"
onready var data = $"/root/Node2D"

onready var addButton = $Add
onready var allSlider = []

# = FUNC = #

# Calculate budget
func _process(_delta):
	var sum = 0;
	
	for i in range(allSlider.size()):
		sum += (allSlider[i].Get_Value() * data.totalBudget)/100
	
	data.budgetLeft = data.totalBudget - sum

# Called went the "Add" button is pressed
func _on_Add_pressed():
	var category = categoryPrefab.instance()
	var slider = category.get_node("CustomSlider")
	
	slider.Set_Max_Value(100)
	
	themeManager.LoadCurThemeFor(category)
	
	self.rect_size.y += 150
	self.add_child(category)
	allSlider.append(slider)
	self.move_child(addButton,self.get_children().size())
