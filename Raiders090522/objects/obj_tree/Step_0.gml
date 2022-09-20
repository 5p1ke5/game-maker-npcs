/// @description Sets depth, if in death state rotates until it's at a 45 degree angle, then stops and fades away.
depth = -y;

if (!living)
{
	if (abs(image_angle) < 90)
	{
		image_angle += dir * 4;
		if (abs(image_angle) >= 90)
		{
			audio_play_sound(snd_treeFall, 0, false);
		}
	}
	else
	{
		image_alpha -= 0.01;
		
		if (image_alpha <= 0)
		{
			instance_destroy();
		}
	}
}