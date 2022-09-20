/// @function message_initialize(text, time)
/// @description initializes variables for a message object.
/// @param _text The text the message will display.
/// @param _time The number of frames this object will fade over. Once this is up, the instance will be destroyed.
function message_initialize(_text, _time = (game_get_speed(gamespeed_fps) * 2)) 
{
	//Instance variables.
	text = _text;
	maxTime = _time;
	time = maxTime;
}

/// @function message_create(_x, _y, _depth, _text, _time)
/// @description creates a message object at the specified coordinaes and depth. Returns created instance.
/// @param _x x coordinate to spawn at.
/// @param _y y coordinate to spawn at.
/// @param _depth depth to spawn at.
/// @param _text Text string to display.
/// @param _time Time in frames for the text to stay.
function message_create(_x, _y, _depth, _text, _time = (game_get_speed(gamespeed_fps) * 2))
{
	//Reference to message object. 
	var _messageObject = obj_message;
	
	//Creates instance of messageObject and stores a reference to it.
	var _messageInstance = instance_create_depth(_x, _y, _depth, _messageObject);
	
	//Calls initializing script with passed variables.
	with (_messageInstance)
	{
		message_initialize(_text, _time);
	}

	return _messageInstance;
}