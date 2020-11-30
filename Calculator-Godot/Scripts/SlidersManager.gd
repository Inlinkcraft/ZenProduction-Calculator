
#
# @author Inlinkcraft
#

extends VBoxContainer

# = VAR = #

var categoryPrefab = preload("res://Scenes/Category.tscn")

onready var themeManager = $"/root/Node2D/Managers/ThemeManager"
onready var data = $"/root/Node2D/Managers/MoneyManager"

onready var addButton = $Add
onready var allSlider = []

# = FUNC = #

# Calculate budget
func _process(_delta):
	var sum = 0;
	
	for i in range(allSlider.size()):
		sum += (allSlider[i].Get_Value() * data.totalBudget)/100
		allSlider[i].get_parent().get_node("Pourcent").text = "%" + str(stepify(allSlider[i].Get_Value(), 0.01))
		allSlider[i].get_parent().get_node("Money").text = str(stepify((allSlider[i].Get_Value() * data.totalBudget)/100, 0.01)) + "$"
	
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
