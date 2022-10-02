///@function guiButton_create(_x, _y, _depth, _text, _color, _onClick, _onClickArguments=[], _owner = noone)
///@description Creates a guiBUtton and initializes variables a button gui object should have. Returns reference to the created button.
///@param _x starting x coordinate
///@param _y starting y coordinate.
///@param _depth depth to create the button at
///@param _text Text to have on the button.
///@param _color color for button
///@param _onClick Method to be called when button is clicked. If it has parameters they should be an array and passed via _arguments (below). If it has params it should be a single array.
///@param [_onClickArguments] Array holding any arguments to be passed to the onClick method when it is called, if any.
///@param [_owner] optional owner instance. That instance will need to have a reference back to this one and should usually be the one calling this function to create the button instance.
function guiButton_create(_x, _y, _depth, _text, _color, _onClick, _onClickArguments=[], _owner = noone)
{
	var _button = instance_create_depth(_x, _y, _depth, obj_guiButton);
	
	with (_button)
	{
		guiButton_initialize(_text, _color, _onClick, _onClickArguments, _owner)
	}
	
	return _button;
}

///@function guiButton_initialize(_text, _color, _onClick, _onClickArguments=[], _owner = noone)
///@description initializes variables for a guiButton object.
///@param _text Text to have on the button.
///@param _color1 color for button
///@param _onClick Method to be called when button is clicked. If it has parameters they should be an array and passed via _arguments (below). If it has params it should be a single array.
///@param [_onClickArguments] Array holding any arguments to be passed to the onClick method when it is called, if any.
///@param [_owner] optional owner instance. That instance will need to have a reference back to this one and should usually be the one calling this function to create the button instance.
function guiButton_initialize(_text, _color, _onClick, _onClickArguments=[], _owner = noone)
{
	text = _text;
	image_blend = _color;
	onClick = _onClick;
	onClickArguments = _onClickArguments;
	owner = _owner;
}