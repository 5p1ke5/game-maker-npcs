/// @description Rotates weapon by arc amount.

//If owner can't be found destroys itself without calling destroy code and exits immediately.
if (!instance_exists(owner))
{
	print("Owner " + string(owner) + " not found.");
	instance_destroy(id, false);
	exit;
}


//Links position to owner's position.
x = owner.x;
y = owner.y;

//Rotates self according to owner's angle. This should be being set by the right mouse button being held down.
angle = owner.angle;
image_angle = angle;

