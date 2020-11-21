#
# @author Antoine Montpetit
#

extends Control

# = Var = #

var value = 0 setget Set_Value, Get_Value

export(float) var minValue = 0.0 setget Set_Min_Value, Get_Min_Value
export(float) var maxValue = 100.0 setget Set_Max_Value, Get_Max_Value
export(float) var step = 0.01 setget Set_Step, Get_Step

export(bool) var useLimiters = false setget Set_Using_Limiter, Get_Using_Limiter
export(float) var minLimiter = 0.0 setget Set_Min_Limiter, Get_Min_Limiter
export(float) var maxLimiter = 100.0 setget Set_Max_Limiter, Get_Max_Limiter

onready var handle = $Handle
onready var valideValueBar = $Top

var selected = false

# = Func = #

#
# Update every frame the value base on the handle position
# @param delta : time elapse between frame
#
func _process(_delta):
	var rangeX = self.get_size().x
	var rangeV = maxValue - minValue
	value = (handle.position.x * rangeV)/rangeX

#
# Called went a Input is sent to the device
# @param event: is the type of input recive
#
func _input(event):
	if(event is InputEventMouseButton || event is InputEventScreenTouch):
		if (event.is_pressed()):
			if(CheckOnSlider(event.position)):
				selected = true
				handle.global_position.x = HandleClamp(event.position.x)
		if (!event.is_pressed()):
			selected = false
	
	if(event is InputEventScreenDrag || event is InputEventMouseMotion):
		if(selected):
			handle.global_position.x = HandleClamp(event.position.x)

#
# This makes sure that the handle never get out of the valid values
# @param x : the new x position
#
func HandleClamp(var x):
	
	var maxX = self.get_global_position().x + self.get_size().x
	var minX = self.get_global_position().x
	
	var rangeX = self.get_size().x
	var rangeV = maxValue - minValue
	var stepX = (rangeX * step)/rangeV
	
	var limitMinPosX = self.get_global_position().x + ((minLimiter * rangeX)/rangeV)
	var limitMaxPosX = self.get_global_position().x + ((maxLimiter * rangeX)/rangeV)
	
	x = stepify(x, stepX)
	
	if(useLimiters):
		x = clamp(x,limitMinPosX,limitMaxPosX)
	else:
		x = clamp(x, minX, maxX)
	
	return x

#
# Check if a given position is on the slider
# @param pos : the postion to test
#
func CheckOnSlider(var pos):
	var maxX = self.get_global_position().x + self.get_size().x
	var minX = self.get_global_position().x
	var maxY = self.get_global_position().y + self.get_size().y
	var minY = self.get_global_position().y
	return pos.x > minX && pos.x < maxX && pos.y > minY && pos.y < maxY

#
# Update the vizual of the limiter
#
func UpdateLimitLayer():
	var rangeX = self.get_size().x
	var rangeV = maxValue - minValue
	
	var limitMinPosX = self.get_global_position().x + ((minLimiter * rangeX)/rangeV)
	var limitMaxPosX = self.get_global_position().x + ((maxLimiter * rangeX)/rangeV)
	
	var newXSize = self.get_size().x - (((self.get_global_position().x + self.get_size().x) - limitMaxPosX)+(limitMinPosX - (self.get_global_position().x)))
	
	if(valideValueBar != null):
		valideValueBar.region_rect.size.x = newXSize
		valideValueBar.global_position.x = limitMinPosX + (limitMaxPosX - limitMinPosX)/2
		
		handle.global_position.x = HandleClamp(handle.global_position.x)

# SETS

#
# Set the value of the slider
#
func Set_Value(_value):
	if (Validate_Value(_value)):
		value = _value

#
# Set the min value of the slider
#
func Set_Min_Value(_value):
	if (Validate_MinMax_Value(_value)):
		minValue = _value

#
# Set the min value of the slider
#
func Set_Max_Value(_value):
	if (Validate_MinMax_Value(_value)):
		maxValue = _value

#
# Set a new setp size
#
func Set_Step(_step):
	if (Validate_Step_Size(_step)):
		step = _step

#
# Set a new using limiter
#
func Set_Using_Limiter(_useLimiters):
	if (Validate_Use_Limiter(_useLimiters)):
		useLimiters = _useLimiters
		UpdateLimitLayer()

#
# Set a min limiter Value
#
func Set_Min_Limiter(_value):
	if (Validate_MinMax_Limiter(_value)):
		minLimiter = _value
		UpdateLimitLayer()

#
# Set a max limiter Value
#
func Set_Max_Limiter(_value):
	if (Validate_MinMax_Limiter(_value)):
		maxLimiter = _value
		UpdateLimitLayer()

# GETS

#
# Get the value of the slider
#
func Get_Value():
	return value

#
# Get the min value of the slider
#
func Get_Min_Value():
	return minValue

#
# Get the max value of the slider
#
func Get_Max_Value():
	return maxValue

#
# Get the step size of the slider
#
func Get_Step():
	return step

#
# Get the slider that using a limiter
#
func Get_Using_Limiter():
	return useLimiters

#
# Get the min limiter value
#
func Get_Min_Limiter():
	return minLimiter

#
# Get the max limiter value
#
func Get_Max_Limiter():
	return maxLimiter

# VALIDATE

#
# Check the validiti of the value of the slider
#
func Validate_Value(_value):
	return (_value is float || _value is int) && _value > minValue && _value < maxValue

#
# Check the validiti of the value min or max of the slider
#
func Validate_MinMax_Value(_value):
	return _value is float || _value is int

#
# Check the validiti of the step value
#
func Validate_Step_Size(_step):
	return (_step is float || _step is int) && _step > 0

#
# Check the validiti of the Using Limiter value
#
func Validate_Use_Limiter(_useLimiters):
	return _useLimiters is bool

#
# Check the validiti of the min/max value of the limiter 
#
func Validate_MinMax_Limiter(_value):
	return Get_Using_Limiter() && (_value is float || _value is int)

