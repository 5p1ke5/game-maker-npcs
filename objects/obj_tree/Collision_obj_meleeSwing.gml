/// @description Can be destroyed by axes.
if (living)
{
	with (other)
	{
		var _name = name;	
	}

	if (_name == "Axe")
	{
		audio_play_sound(snd_treeHit, 0, false);
		living = false;
	
		mask_index = spr_none;
	
		dir = choose(1, -1);
	}
}