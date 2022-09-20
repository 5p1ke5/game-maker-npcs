/// @function meter_draw(_x1, _y1, _x2, _y2, _bgcolor, _fgcolor, _outlineColor, _shadowColor, _shadowOffset, _val, _maxval)
/// @description draws a horizontal meter.
/// @param x1 the x coordinate the top left of the meter will be drawn at.
/// @param y1 the y coordinate the top left of the meter will be drawn at.
/// @param x2 the x coordinate of the bottom right of the meter.
/// @param y2 the y coordinate of the bottom right of the meter.
/// @param bgcolor the background color of the meter.
/// @param fgcolor the color of the actual meter (part that moves)
/// @param outlinecolor The color of the outline. -1 means no outline will be drawn.
/// @param shadowColor the color of the shadow. -1 means no shadow will be drawn.
/// @param shadowOffset How far beneath the meter the drop shadow is.
/// @param val The current value of the stat being represented.
/// @param maxVal the maximum value of the stat being represented.
function meter_draw(_x1, _y1, _x2, _y2, _bgColor, _fgColor, _outlineColor, _shadowColor, _shadowOffset, _val, _maxVal) 
{
	var _width = _x2 - _x1;


	//Drop shadow
	if (_shadowColor != -1)
	{
		draw_roundrect_color(_x1, _y1 + _shadowOffset, _x2, _y2 + _shadowOffset, _shadowColor, _shadowColor, false);
	}

	//Background
	draw_roundrect_color(_x1, _y1, _x2, _y2, _bgColor, _bgColor, false);

	//Meter. Scales with hp / maxHP
	draw_roundrect_color(_x1,_y1, _x1 + (_width * (_val / _maxVal)), _y2, _fgColor, _fgColor, false);


	//Outline.
	if (_outlineColor != -1)
	{
		draw_roundrect_color(_x1, _y1, _x2, _y2, c_white, c_white, true);
	}


}
/// @function slider_create(_bgcolor, _fgcolor, _outlineColor, _shadowColor, _shadowOffset, _val, _maxval)
/// @description initializes a slider.
/// @param bgcolor the background color of the meter.
/// @param fgcolor the color of the actual meter (part that moves)
/// @param outlinecolor The color of the outline. -1 means no outline will be drawn.
/// @param shadowColor the color of the shadow. -1 means no shadow will be drawn.
/// @param shadowOffset How far beneath the meter the drop shadow is.
/// @param val The current value of the stat being represented.
/// @param maxVal the maximum value of the stat being represented.
function slider_create(_bgColor, _fgColor, _outlineColor, _shadowColor, _shadowOffset, _val, _maxVal) 
{
	bgColor = _bgColor;
	fgColor = _fgColor;
	outlineColor = _outlineColor;
	shadowColor = _shadowColor;
	shadowOffset = _shadowOffset;
	val = _val;
	maxVal = _maxVal;
	owner = instance_find(obj_characterCreation, 0);
	if (owner == noone)
	{
		instance_destroy();	
	}
	
	optionSelected = owner.optionSelected;
	
}