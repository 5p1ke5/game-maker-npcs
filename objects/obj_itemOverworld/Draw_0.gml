/// @description If sprite is not set tries to find sprite in item struct.
if ((sprite_index == -1) && (is_struct(item)))
{
	draw_sprite_ext(item.GetIcon(), 0, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha);
}
else
{
	draw_self();
}