/// @description Overrides parents, necessary variables are all intialize in here.
var _faceIndex = irandom(sprite_get_number(spr_dollFaces));
var _hairIndex = irandom(sprite_get_number(spr_dollHairs));
var _shirtIndex = irandom(sprite_get_number(spr_dollShirts));
var _pantsIndex = 0;

var _skinColor = make_color_hsv(irandom(255), 255, 255);
var _hairColor = make_color_hsv(irandom(255), 255, 255);
var _shirtColor = make_color_hsv(irandom(255), 255, 255);
var _pantsColor = make_color_hsv(irandom(255), 255, 255);

doll_initialize(5, 5, 3, 3, irandom(factions.neutral), _faceIndex, _hairIndex, _shirtIndex, _pantsIndex, _skinColor, _hairColor, _shirtColor, _pantsColor);