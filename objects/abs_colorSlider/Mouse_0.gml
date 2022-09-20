/// @description sets val as proportional to where the meter was clicked. Child instances should inherit, then set it with their owner.
var _width = bbox_left - bbox_right;

val = maxVal * ((bbox_left - mouse_x) /_width);