/// @description Hitting another hurtbox will reduce damage to 0, 'disarming' it and also knocking the owner of that hurttbox back.
/*
//TODO: Maybe move this to begin step and just do collision there?
var _parried = collision_point(x, y, obj_meleeSwing, true, false);

if (_parried == noone)
{
	
}

//Sets damage to 0.
with (other)
{
	if (damage != 0)
	{
		damage = 0;
		audio_play_sound(snd_seParry, 1, false);
	}
	
	knockback = knockback/2;
}
show_debug_message("Attack parried!");

//Temp variables to be applied.
var _hDir = sign(x - other.x);
var _vDir = sign(y - other.y);
var _knockback = knockback * 4;

//TODO: set this up so it's at the actual angle
if (instance_exists(other.owner))
{
	with (other.owner)
	{
			hsp -= _knockback * _hDir;
			vsp -= _knockback * _vDir;
	}	
}

*/