/// @description Hitting another hurtbox will knock the owners the other hurtbox back.

//Temp variables to be applied.
var _hDir = sign(x - other.x);
var _vDir = sign(y - other.y);
var _knockback = other.knockback;

if (instance_exists(other.owner))
{
	with (other.owner)
	{
			hsp += _knockback * _hDir;
			vsp += _knockback * _vDir;
	}	
}
