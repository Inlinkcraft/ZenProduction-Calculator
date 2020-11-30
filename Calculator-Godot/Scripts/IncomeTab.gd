#
# @author Inlinkcraft
#

extends Control

# = VAR = #
onready var addTab = $"AddTab"
onready var chooseTab = $"AddTab/ChoseAdd"
onready var amountTab = $"AddTab/ChoseAmount"
onready var amountBar = $"AddTab/ChoseAmount/HowMuch"
onready var nameBar = $"AddTab/ChoseAmount/Name"
onready var incomesScroll = $"ScrollContainer/Incomes"
onready var totalIncomeText = $"TotalIncome"

onready var themeManager = $"/root/Node2D/Managers/ThemeManager"
onready var themeMoneyManager = $"/root/Node2D/Managers/MoneyManager"


var incomeTab = preload("res://Scenes/IncomeTab.tscn")
# = FUNC = #

func _process(_delta):
	var sum = 0
	for income in incomesScroll.get_children():
		sum += float(income.get_node("Amount").text)
	themeMoneyManager.totalIncome = sum
	totalIncomeText.text = ("%.2f" % sum) + "$"

# Button Pressed

func _on_OneTimeAmount_pressed():
	chooseTab.set_visible(false)
	amountTab.set_visible(true)

func _on_Add_pressed():
	addTab.set_visible(true)

func _on_Back_pressed():
	addTab.set_visible(false)

func _on_BackAmount_pressed():
	chooseTab.set_visible(true)
	amountTab.set_visible(false)

func _on_DoneAmount_pressed():
	
	# Test for the countain of the bar
	var amount = float(amountBar.get_text())
	var name = nameBar.get_text()
	if(amount != 0 && name.replace(" ", "").length() != 0):
		# Valid
		chooseTab.set_visible(true)
		amountTab.set_visible(false)
		addTab.set_visible(false)
		
		# create the income
		var newIncome = incomeTab.instance()
		newIncome.get_node("Name").text = name
		newIncome.get_node("Amount").text = str("%.2f" % amount) + "$"
		var time = OS.get_date()
		newIncome.get_node("Date").text = str(time["day"]) + "/" + str(time["month"]) + "/" + str(time["year"])
		
		newIncome.get_node("SideBar/ColorTag").colorId = 4
		
		themeManager.LoadCurThemeFor(newIncome)
		
		incomesScroll.add_child(newIncome)
		incomesScroll.move_child(newIncome,0)
