//Scripts for generating random dungeons.

///@function randomDungeon_generate(_width, _height, _block)
///@description forms a room into a randomized dungeon. Usually is applied to a "template" room in the creation code.
///@param _width How wide the room should be.
///@param _height Height of the room.
///@param _block Block object to be used. Bounding box is used to get tile width, height (maybe make an _ext function for this?)
function randomDungeon_generate(_width, _height, _block)
{
	room_width = _width;
	room_height = _height;
	
	var _blockObject = _block;
	var _blockSprite = object_get_sprite(_block);
	
	var _tileW = sprite_get_bbox_right(_blockSprite) - sprite_get_bbox_left(_blockSprite);
	var _tileH = sprite_get_bbox_bottom(_blockSprite) - sprite_get_bbox_top(_blockSprite);
	
	var _tileRows = floor(_width / _tileW);
	var _tileColumns = floor(_height / _tileH);
	
	print("_tileW: " + string(_tileW));
	print("_tileH: " + string(_tileH));
	
	print("_tileRows: " + string(_tileRows));
	print("_tileColumns: " + string(_tileColumns));
	
	for (var _i = _tileRows; _i >= 0; _i--)
	{
		for (var _ii = _tileColumns; _ii >= 0; _ii--)
		{
			instance_create_layer(_i * _tileW, _ii * _tileH, "Blocks", _block);
			print ("Block " + string(_i) +",  " +string(_ii) + ";");
		}
	}
	
	//Let's just make a room in the middle for now.
	for (var _i = _tileRows - 1; _i >= 1; _i--)
	{
		for (var _ii = _tileColumns - 1; _ii >= 1; _ii--)
		{
			var _target = instance_position(_i * _tileW, _ii * _tileH, _block);
			instance_destroy(_target);
		}
	}
	
	//Find a random position to place player.
	var _player = instance_create_layer(irandom(_width),  irandom(_height), "Player", obj_player);
	with (_player)
	{
		while (place_meeting(x, y, _block))
		{
			x = irandom(_width);
			y = irandom(_height);
		}
	}
}