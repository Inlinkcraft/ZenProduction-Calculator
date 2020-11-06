
#
# @author Antoine Montpetit
#

extends VBoxContainer

# = VAR = #

var alocatedPourcent = 0 setget setPourcentage, getPourcentage
var alocatedMoney = 0 

onready var sliderContainer = get_parent()
onready var pourcentLabel = get_node("Info/PourcentLabel")
onready var slider = get_node("Info/Slider")
onready var moneyLabel = get_node("Info/MoneyLabel")

# = FUNC = #

# Called went the slider value is changed
func _on_Slider_value_changed(value):
	setPourcentage(value)
	sliderContainer.UpdateBarValues(self)

# Take a pourcentage and Change the bar
# @param value: the pourcentage [0,1]
func SetBarValue(value):
	setPourcentage(value)
	slider.value = value

# Update the alocated money for the pourcent
func UpdateMoney():
	alocatedMoney = sliderContainer.total * alocatedPourcent
	moneyLabel.text = str(stepify(alocatedMoney, 0.01)) + "$"
	

# = SETGET = #
func setPourcentage(value):
	if(validatePourcent(value)):
		alocatedPourcent = value
		UpdateMoney()
		pourcentLabel.text = str(stepify(alocatedPourcent * 100, 0.01)) + "%"

func getPourcentage():
	return alocatedPourcent

func validatePourcent(value):
	return (value >= 0 && value <= 1)
