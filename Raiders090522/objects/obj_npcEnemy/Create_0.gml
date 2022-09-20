/// @description Initializes character-specific variables
//Random character.

var _faceIndex = irandom(sprite_get_number(spr_dollFaces));
var _hairIndex = irandom(sprite_get_number(spr_dollHairs));
var _shirtIndex =irandom(sprite_get_number(spr_dollShirts));
var _pantsIndex = 0;
var _skinColor = choose(c_asian1, c_asian2, c_asian3, c_black1, c_black2, c_black3, c_hispanic1, c_hispanic2, c_hispanic3, c_white1, c_white2, c_white3);
var _hairColor = choose(c_blonde, c_brunette, c_black, c_ginger, c_darkBrunette, c_lightBrunette);
var _shirtColor = c_brunette;
var _pantsColor = c_brunette;

doll_initialize(5, 5, 3, 3, factions.enemy, _faceIndex, _hairIndex, _shirtIndex, _pantsIndex, _skinColor, _hairColor, _shirtColor, _pantsColor);


var _item = new ITEM_SWORD;
inventory_add(inventory, _item);

var _state = new NPCStateIdle(noone);

npc_initialize("Bandit", "Grr we're bandits!", 100, _state);
