#
# @autor Inlinkcraft
#

extends Node

#
# Decript a json file at a certain path
#
# @param path : The file path
#
func DecriptJson(path):
	var file = File.new();
	file.open(path, file.READ)
	
	var jsonParseResult = JSON.parse(file.get_as_text())

	if(jsonParseResult.error):
		printerr("json Error : " + jsonParseResult.error_string + " | at line :" + str(jsonParseResult.error_line) + " in file : " + path)
	
	file.close()
	return jsonParseResult.result
