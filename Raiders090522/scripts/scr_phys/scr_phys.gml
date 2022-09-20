/// @function  phys_initialize(_frict, _hsp, _vsp, _collision) 
/// @description Initializes physics variables.
/// @param _frict How much horizontal speed is reduced each step while it is non-zero.
/// @param _hsp Horizontal speed.
/// @param _vsp vertical speed
/// @param _collision Whether the object stops when it collides with blocks.
function phys_initialize(_frict, _hsp, _vsp, _collision) 
{

	//Initializes instance variables.
	frict = _frict;
	hsp = _hsp;
	vsp = _vsp;
	collision = _collision;
}


/// @function phys_step()
/// @description Place in the step event to activate physics.
function phys_step() 
{
	//Friction will reduce horizontal and vertical speed..
	phys_friction();

	//Collision with walls. The object's position is changed after each collision function.
	if (collision)
	{
	    vsp = phys_floor_collision(vsp);
	    hsp = phys_wall_collision(hsp);
	}

	y += round(vsp);
	x += round(hsp);
	
	
	//Due to perspective anything moving will need this
	depth = -y;
}


/// @function phys_friction() 
/// @description Applies friction the object's speed variables.
function phys_friction() 
{
				var _angle = point_direction(x, y, x + hsp, y + vsp)
				
				hsp -= dsin(_angle + 90) * frict;
				vsp -= dcos(_angle + 90) * frict;
				
				if (abs(hsp) < frict)
				{
					hsp = 0;
				}
				
				if (abs(vsp) < frict)
				{
					vsp = 0;
				}
}

/// @function phys_force_add(_force, _accel, _max)
/// @description Accelerates a given force value up to a maximum number. eg hsp = phsy_force_add(hsp, accel, terminalVelocity) Returns the new value.
/// @param _force the base value to be added to. Usually hsp or vsp.
/// @param _accel the number to be added to the _force variable.
/// @param _max the maximum value that _force can be set to.
function phys_force_add(_force, _accel, _max)
{
	var _sign = sign(_accel);
	
	_force += _accel;
	_force = min(abs(_force), _max);
	
	return _force * _sign;
}



/// @function phys_floor_collision(_vsp)
/// @description Stops the player if they would touch a block vertically. eg vsp = phys_floor_collison(vsp). Returns new vsp.
/// @param _vsp object's vertical speed.
function phys_floor_collision(_vsp) 
{
	//Checks every pixel in the player's path for collision.
	for (var _i = 0; (abs(_i) < abs(_vsp)) || (place_meeting(x, y + _i, BLOCK)); _i += sign(_vsp))
	{
	    //If there is a collision, it will move the player as close to the object as possible and then stop.
	    if (place_meeting(x, y + _i, BLOCK))
	    {
	        y += _i - sign(_vsp);
	        return 0;
	    }
	}

	return _vsp;
}

/// @function phys_wall_collision(hsp)
/// @description If the object would end up inside the block object, it instead just moves them as close as possible. eg hsp = phys_wall_collision(hsp)
/// @param hsp object's horizontal speed.
function phys_wall_collision(_hsp) 
{
	//Checks every pixel in the object's path for collision.
	for (var _i = 0; (abs(_i) < abs(_hsp)) || (place_meeting(x + _i, y, BLOCK)); _i += sign(_hsp))
	{
	    //If there is a collision, it will move the player as close to the object as possible and then stop. Bas a tiny upwards margin for now.4
	    if (place_meeting(x + _i, y, BLOCK))
	    {
	        x += _i - sign(_hsp);
	        return 0;
	    }
	}
	
	return _hsp;
}