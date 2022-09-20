/// @description Removes self from lists.

//party members
var _indexA = ds_list_find_index(global.partyMembers, id);

if (_indexA != -1)
{
	ds_list_delete(global.partyMembers, _indexA);
}

//selected units
var _indexB = ds_list_find_index(global.selected, id);

if (_indexB != -1)
{
	ds_list_delete(global.selected, _indexB);
}