//functions that output to console and otherwise help with debugging.

///@function print(_string)
///@description Short version of show_debug_message()
///@param _string output 
function print(_str)
{
	show_debug_message(_str);
}

///@function trace(...)
///@description prints an arbitrary number of arguments seperated by a comma.
///@param  argument[n] Any number of arguments.
function trace()
{
	var _str = string(argument[0]);
	
	for (var _i = 1; _i < argument_count; _i++)
	{
		_str += ", " + string(argument[_i]);
	}
	
	print(_str);
}