/// @description Removes references to self from owner upon destruction.
if (instance_exists(owner))
{
	with (owner)
	{
		myHeld = noone;
	}
}