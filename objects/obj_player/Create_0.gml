/// @description Overrides parents, imports variables from global.
/// @description Overrides parents, necessary variables are all intialize in here.
var _faceIndex = global.playerFaceIndex;
var _hairIndex = global.playerHairIndex;
var _shirtIndex = global.playerShirtIndex;
var _pantsIndex = global.playerPantsIndex;

var _skinColor = global.playerSkinColor;
var _hairColor = global.playerHairColor;
var _shirtColor = global.playerShirtColor;
var _pantsColor = global.playerPantsColor;

doll_initialize(global.playerMaxHP, global.playerHP, global.playerMaxPP, global.playerPP, factions.player, _faceIndex, _hairIndex, _shirtIndex, _pantsIndex, _skinColor, _hairColor, _shirtColor, _pantsColor);


var _item = new ITEM_SWORD;
inventory_add(inventory, _item);