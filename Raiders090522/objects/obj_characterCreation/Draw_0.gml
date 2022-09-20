/// @description Draws a preview of the player character, then menu options from parent.

doll_draw();

/// Draws the menu
menu_draw(room_width / 2, 8, options, c_white, c_gray, room_height, optionSelected);
