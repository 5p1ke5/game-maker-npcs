///Scripts for living things.

/// @function living_initialize(_maxHP, _hp)
/// @description initializes variables for living things.
/// @param _maxHP maximum HP the object can have.
/// @param _hp current hp the object has/
function living_initialize(_maxHP, _hp)
{
	maxHP = _maxHP;
	hp = _hp;
	
	//Invulnerability counter.
	flicker = 0;
}


/// @function living_hurtbox_collision(_hurtbox)
/// @description Put it in the step event to make an object take damage when hit.
/// @param _hurtbox Hurtbox object.
function living_hurtbox_collision(_hurtbox)
{
	//You can't be damaged by your own hurtbox.
	//TODO: Maybe something that distinguishes between enemies and friends better?
	if (_hurtbox.owner == id)
	{
		return;
	}

	//Temp variables to be applied.
	var _hDir = sign(x - _hurtbox.x);
	var _vDir = sign(y - _hurtbox.y);
	var _damage = _hurtbox.damage;
	var _knockback = _hurtbox.knockback;
	
	//Exits if the instance is flickering or damage is 0.
	if (flicker > 0) || (_damage == 0)
	{
		return;
	}

	hp -= _damage;
	print("Damage taken! Damage: " + string(_damage) + " New HP: " + string(hp));
	
	if (variable_instance_exists(id, "hsp"))
	{
		hsp += _knockback * _hDir;
	}
		
	if (variable_instance_exists(id, "vsp"))
	{
		vsp += _knockback * _vDir;
	}
		
	flicker = FLICKER;

	//Dies
	if (hp <= 0)
	{
		instance_destroy();
	}
}