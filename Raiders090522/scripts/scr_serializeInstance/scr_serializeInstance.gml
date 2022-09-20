///@function SerializedInstance() constructor
function SerializedInstance() constructor
{
	
}

///@function serializeInstance(_instance)
///@description Gets all variables from an instance, then saves them to a SerializedInstance() struct.
function serializeInstance(_instance)
{
	var _variableNameArray = variable_instance_get_names(_instance);

	print(string(_variableNameArray));
	
	for (var _i = 0; _i < array_length(_variableNameArray); _i++)
	{
		var _var = variable_instance_get(_instance, _variableNameArray[_i]);
		
		print(string(_var));
	}
}