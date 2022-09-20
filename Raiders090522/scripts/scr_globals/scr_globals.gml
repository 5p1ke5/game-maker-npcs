/// @function globals_initialize()
/// @description Initializes the game's global variabls.
function globals_initialize()
{
	global.playerMaxHP = 400;
	global.playerHP = 400;
	
	//hhhhh dunno if I'll use these
	global.playerMaxPP = 3;
	global.playerPP = 3;
	
	//Player appearance variables.
	global.playerFaceIndex = 0;
	global.playerHairIndex = 0;
	global.playerShirtIndex = 0;
	global.playerPantsIndex = 0;
	
	global.playerSkinColor = c_hispanic1;
	global.playerHairColor = c_brunette;
	global.playerShirtColor = c_red;
	global.playerPantsColor = c_blue;
	
	//Cursor things.
	global.cursorState = cursor.normal;
	
	//Faction things
	//Currently recruited allies.
	global.partyMembers = ds_list_create();
	
	
	//Currently selected allies.
	global.selected = ds_list_create();
	
	//Story flags.
	global.storyTalkedToDad = false;
}