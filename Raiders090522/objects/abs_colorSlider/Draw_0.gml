/// @description Draws the slider, writes val in text over it
meter_draw(bbox_left, bbox_top, bbox_right, bbox_bottom, bgColor, fgColor, outlineColor, shadowColor, shadowOffset, val, maxVal);
draw_text((bbox_left + bbox_right) / 2, (bbox_bottom + bbox_top) / 2, string(val));