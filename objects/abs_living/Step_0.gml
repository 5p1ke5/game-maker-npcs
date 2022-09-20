/// @description Inherit physics, decrements flicker.

//Invulnerability timer.
if (flicker > 0)
{
	flicker--;	
}

// Inherit the parent event
event_inherited();

