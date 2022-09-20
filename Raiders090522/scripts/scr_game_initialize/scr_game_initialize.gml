/// @function game_initialize()
/// @description Sets up things right as the game starts. Sets random seed, initializes globals.
function game_initialize()
{
	randomize();
	globals_initialize();
	
	window_set_cursor(cr_none);
	cursor_sprite = global.cursorState;
}