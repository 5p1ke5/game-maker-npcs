/// @description Commands units depending on cursor state.
var _list = ds_list_create();
collision_point_list(mouse_x, mouse_y, obj_npc, false, true, _list, true);

switch (global.cursorState) {
    case cursor.normal:
	
    break;
	
    case cursor.select:
		for (var _i = 0; _i < ds_list_size(_list); _i++)
		{
			var _npc = ds_list_find_value(_list, _i);
			
			//If it's a member of the party can select and deselect.
			var _indexA = ds_list_find_index(global.partyMembers, _npc)
			
			if (_indexA != -1)
			{
				//If not part of selection selects; if not deselects.
				var _indexB = ds_list_find_index(global.selected, _npc);
				if (_indexB == -1)
				{
					//Adds to list
					ds_list_add(global.selected, _npc);
					break;
				}
				
				//removes from list. Either way breaks.
				ds_list_delete(global.selected, _indexB);
				break;
			}
		}
    break;
	
	case cursor.follow:
		//Check if mouse is on NPC and if so make them follow.
		for (var _i = 0; _i < ds_list_size(_list); _i++)
		{
			var _npc = ds_list_find_value(_list, _i);
			
			if (_npc.faction == factions.player)
			{
				var _playerID = id;
				with (_npc)
				{
					_newState = new NPCStateFollow(_playerID);
				
					state = _newState;
				}
				
				if (ds_list_find_index(global.partyMembers, _npc) == -1)
				{
					ds_list_add(global.partyMembers, _npc)
				}
				
				if (ds_list_find_index(global.selected, _npc) == -1)
				{
					ds_list_add(global.selected, _npc)
				} 
				break;
			}
		}
	break;
	
	case cursor.attack:
		//Order all selected npcs to attack
	break;
	
	case cursor.move:
		//Order all selected NPCs to move.
		var _point = new Point2(mouse_x, mouse_y);
		var _newState = new NPCStateMove(_point);
		
		print(string(_point));
		for (var _i = 0; _i < ds_list_size(global.selected); _i++)
		{
			var _npc = ds_list_find_value(global.selected, _i);
			
			with (_npc)
			{
				state = _newState;
				print(string(state));
			}
			
		}
		
	break;
}