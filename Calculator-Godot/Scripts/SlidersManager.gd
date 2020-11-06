
#
# @author Antoine Montpetit
#

extends VBoxContainer

# = VAR = #

onready var allcath = get_children()
var total = 1000

# = FUNC = #

func _ready():
	var basePourcentPerCath = 1 / float(allcath.size())
	for i in range(allcath.size()):
		allcath[i].SetBarValue(basePourcentPerCath)

#User Change a bar value
#@param from: The slider that change
func UpdateBarValues(from):
	if (from == null):
		return
	for i in range(allcath.size()):
		if(allcath[i] != from):
			var SliderSum = 0
			for j in range(allcath.size()):
				if(allcath[j] != allcath[i]):
					SliderSum += allcath[j].alocatedPourcent
			allcath[i].SetBarValue(1-SliderSum)

# Update went thge user change the max amount
func _on_SpinBox_value_changed(value):
	total = value
	for i in range(allcath.size()):
		allcath[i].UpdateMoney()
