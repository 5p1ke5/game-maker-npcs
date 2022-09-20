/// @description Draws +the GUI

draw_set_halign(fa_left);

draw_text(5, 5, "HP: " + string(hp) + "/" + string(maxHP));
draw_text(5, 20, "PP: " + string(pp)+ "/" + string(maxPP));

if (ds_list_size(inventory) > 0)
{
	var _item = inventory[|inventoryIndex];
	draw_text(5, 35, "Item: " + _item.itemName);	
}

for (var _i = 0; _i < ds_list_size(global.partyMembers); _i++)
{
	var _partyMember = ds_list_find_value(global.partyMembers, _i)
	
	//If one of the selected party members draws the text in yellow. Otherwise black.
	if (ds_list_find_index(global.selected, _partyMember) != -1)
	{
		var _color = c_yellow;
	}
	else
	{
		var _color = c_black;
	}
	
	draw_text_color(0, window_get_height() - ((1 + _i) * 20) - 20, _partyMember.name, _color, _color, _color, _color, 1);
}