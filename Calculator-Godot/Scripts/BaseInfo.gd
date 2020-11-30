#
# @author Inlinkcraft
#

extends Node

# = VAR = #

var totalIncome = 0
var totalExpense = 0
var totalBudget = 0
var budgetLeft = 0

# = Func = #

func _process(_delta):
	totalBudget = totalIncome - totalExpense
