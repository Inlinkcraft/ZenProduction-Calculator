#
# @autor Inlinkcraft
#

extends Node2D

# = VAR = #

onready var data = $"/root/Node2D/Managers/MoneyManager"
onready var bar = $"TextureProgress"
onready var text = $"Amount"
onready var pourcent = $"pourcentLeft"

# = FUNC = #

#
# Executed every frame to set the circle value correctly
#
func _process(_delta):
	bar.max_value = data.totalBudget
	bar.value = data.budgetLeft
	text.text = str(stepify(data.budgetLeft,0.01)) + "$"
	if(data.totalBudget != 0):
		pourcent.text = str(stepify((data.budgetLeft/data.totalBudget)*100,0.01)) + "%"
	else:
		pourcent.text = "0%"
