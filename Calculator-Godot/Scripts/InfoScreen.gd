#
# @author Inlinkcraft
#

extends RichTextLabel

# = VAR  = #
onready var data = $"../../.."

# = FUNC = #

func _process(_delta):
	set_text(	"Budget:\t\t" + str(stepify(data.totalBudget,0.01)) + "$\n" + 
				"Budget Left:\t" + str(stepify(data.budgetLeft,0.01)) + "$")
