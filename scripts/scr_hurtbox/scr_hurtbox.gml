/// @function hurtbox_initialize(_damage, _knockback, _owner)
/// @description initializes variables a hurtbox will have.
/// @param _damage the damage this hurtbox will deal.
/// @param _kockback knockback.
/// @param _owner The instance that this object is aligned to.
function hurtbox_initialize(_damage, _knockback, _owner)
{
	damage = _damage;
	knockback = _knockback;
	owner = _owner;
}