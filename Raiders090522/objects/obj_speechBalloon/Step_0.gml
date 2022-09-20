/// @description Overrides parent. Doesn't float up, just slowly fades. Always stays on same x as owner.

if (instance_exists(owner))
{
	var _balloonHeight = string_height_ext(text, string_height(text), TEXT_BALLOON_MAXW);
	
	x = owner.x;	
	y = owner.y - (_balloonHeight / 3) - (owner.sprite_height * 1.5);
}

time--;

if (time < 0)
{
	instance_destroy();	
}