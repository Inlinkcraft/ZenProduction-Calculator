#
# @author Inlinkcraft
#

extends RichTextLabel

# = VAR  = #
onready var data = $"../../.."

# = FUNC = #

func _process(delta):
	set_text(	"Budget:\t\t" + str(stepify(data.totalBudget,0.01)) + "$\n" + 
				"Bujet Left:\t" + str(stepify(data.budgetLeft,0.01)) + "$")
