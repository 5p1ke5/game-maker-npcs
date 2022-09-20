/// @description If hurt also sets target and plays sound effect.

//Checks HP at start. If it's different we know that damage was taken.
var _startHP = hp;

event_inherited();

//If damage was taken and there isn't a target already sets target as whoever delt that damage.
if (hp < _startHP)// && (!instance_exists(target))
{
	
	audio_play_sound(snd_seNPCHit, 1, false);
}
