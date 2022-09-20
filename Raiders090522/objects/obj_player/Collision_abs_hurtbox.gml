/// @description Plays sound effect if damage was taken, inherits.

var _startingHP = hp;

// Inherit the parent event
event_inherited();

if (hp < _startingHP)
{
	audio_play_sound(snd_sePlayerHit,1, false);
}