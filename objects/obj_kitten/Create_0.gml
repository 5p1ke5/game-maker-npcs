/// @description Initializes character-specific variables
//Evil kitten

var _faceIndex = choose(13, 14);
var _hairIndex = choose(13, 14);
var _shirtIndex = 1;
var _pantsIndex = 0;
var _skinColor = 297215;
var _hairColor = 35071;
var _shirtColor = 1245036;
var _pantsColor = 142450;

doll_initialize(5, 5, 3, 3, factions.enemy, _faceIndex, _hairIndex, _shirtIndex, _pantsIndex, _skinColor, _hairColor, _shirtColor, _pantsColor);

npc_initialize("Kitten", "Die, human!", 100);

var _item = new ITEM_KNIFE;
inventory_add(inventory, _item);