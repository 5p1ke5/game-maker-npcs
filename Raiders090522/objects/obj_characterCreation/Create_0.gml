/// @description Insert description here
var _array;
_array[0] = "FACE: " + string(global.playerFaceIndex);
_array[1] = "HAIR: " + string(global.playerHairIndex);
_array[2] = "SHIRT: " + string(global.playerShirtIndex);
_array[3] = "PANTS: " + string(global.playerPantsIndex);
_array[4] = "START GAME";
	
menu_create(_array);

doll_initialize(4, 4, 5, 5, factions.player, global.playerFaceIndex, global.playerHairIndex, global.playerShirtIndex, global.playerPantsIndex,
global.playerSkinColor, global.playerHairColor, global.playerShirtColor, global.playerPantsColor);


//Sliders.
sliderRed = instance_find(obj_colorSliderRed, 0);
sliderGreen = instance_find(obj_colorSliderGreen, 0);
sliderBlue = instance_find(obj_colorSliderBlue, 0);