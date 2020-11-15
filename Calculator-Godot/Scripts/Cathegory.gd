
#
# @author Antoine Montpetit
#

extends Control

# = VAR = #

onready var slider = $CustomSlider

onready var minLimBar = $CustomSlider/MinLimBar
onready var maxLimBar = $CustomSlider/MaxLimBar
onready var maxBar = $CustomSlider/MaxBar

# = Func = #


func _process(delta):
	
	# Set Values
	maxBar.get_node("Value").set_text(str(stepify(slider.Get_Max_Value(), 0.01)) + "$")
	
	# Set position
	var rangeX = slider.get_size().x
	var rangeV = slider.Get_Max_Value() - slider.Get_Min_Value()
	
	minLimBar.position.x = (slider.Get_Min_Limiter() * rangeX) / rangeV
	maxLimBar.position.x = (slider.Get_Max_Limiter() * rangeX) / rangeV
