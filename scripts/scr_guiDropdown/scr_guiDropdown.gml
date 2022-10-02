///@function guiDropdown_create(_x, _y, _depth, _buttons)
///@description creatures a guiDropdown object and initializes variables for it.
///@param _x x coordinate to create dropdown at.
///@param _y y coordinate to create dropdown at.
///@param _color color to have dropdown be
///@param [_buttons[]] array of button objects. The dropdown will be set as the owner for them and they will be arranged on the dropdown based on their order in the list.
///@param [_owner] Optional owner object to be linked to for callbacks.
function guiDropdown_create(_x, _y, _depth, _color, _buttons = [], _owner = noone)
{
	var _dropdown = instance_create_depth(_x, _y, _depth, obj_guiDropdown)
	
	with (_dropdown)
	{
		image_blend = _color;
		
		//take all the guiButtons and arrange them in order within the box. Sets self as the owner.
	}
}