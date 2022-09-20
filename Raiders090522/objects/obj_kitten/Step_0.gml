/// @description If the player is close enough tries to fight.
if (instance_exists(obj_player))
{
	if (distance_to_object(obj_player) < LONG_RANGE)
	{
		target = obj_player;
	}
}

// Inherit the parent event
event_inherited();

